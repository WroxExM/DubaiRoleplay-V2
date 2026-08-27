
// Developed By Wrox.Ex GM Developer



#define MAX_VDM_WARNINGS            (3)

#define VDM_DAMAGE_THRESHOLD        (1.0)
#define VDM_MIN_SPEED               (80.0)
#define VDM_REPEAT_HIT_TIME         (3500)
#define VDM_MAX_REPEAT_HITS         (3)
#define VDM_ATTACK_DISTANCE         (7.0)
#define VDM_WARNING_DECAY_TIME      (180000)
#define VDM_DEATH_TRACE_TIME        (7000)

#define VDM_DUPLICATE_HIT_TIME      (900)
#define VDM_STEER_THRESHOLD         (32.0)
#define VDM_INTENT_STEER_THRESHOLD  (18.0)

#define VDM_WARNING_COLOR           (0xF4C542FF)
#define VDM_INTENT_COLOR            (0xFF4D4DFF)
#define VDM_INFO_COLOR              (0xFFFFFFFF)

#define ResetVDMWarnings            AntiVDM_ResetWarn
#define GetVehicleDriver            AntiVDM_GetVehDriver
#define GetVehicleSpeed             AntiVDM_GetVehSpeed
#define IsVehicleSteeringTowardPlayer AntiVDM_IsVehToward
#define IsRepeatedVDMHit            AntiVDM_IsRepeatHit
#define FindVehicleDamager          AntiVDM_FindDamager


static bool:gAntiVDMInitialized = false;
static bool:VDMKickPending[MAX_PLAYERS];

static
    VDMWarnings[MAX_PLAYERS],
    VDMRepeatHits[MAX_PLAYERS],
    VDMLastVictim[MAX_PLAYERS],
    VDMLastHitTick[MAX_PLAYERS],
    VDMVictimLastAttacker[MAX_PLAYERS],
    VDMVictimLastVehicle[MAX_PLAYERS],
    VDMVictimLastTick[MAX_PLAYERS],
    VDMWarningDecayTimer[MAX_PLAYERS],
    VDMVehicleDriverCache[MAX_VEHICLES],
    VDMVehicleDriverTick[MAX_VEHICLES];

static stock AntiVDM_GetTickDiff(current_tick, previous_tick)
{
    if(current_tick >= previous_tick)
    {
        return current_tick - previous_tick;
    }
    return (cellmax - previous_tick) + current_tick + 1;
}

static stock AntiVDM_EnsureInit()
{
    if(gAntiVDMInitialized)
    {
        return 1;
    }

    for(new p = 0; p < MAX_PLAYERS; p++)
    {
        VDMWarnings[p] = 0;
        VDMRepeatHits[p] = 0;
        VDMLastVictim[p] = INVALID_PLAYER_ID;
        VDMLastHitTick[p] = 0;
        VDMVictimLastAttacker[p] = INVALID_PLAYER_ID;
        VDMVictimLastVehicle[p] = INVALID_VEHICLE_ID;
        VDMVictimLastTick[p] = 0;
        VDMWarningDecayTimer[p] = -1;
        VDMKickPending[p] = false;
    }

    for(new v = 0; v < MAX_VEHICLES; v++)
    {
        VDMVehicleDriverCache[v] = INVALID_PLAYER_ID;
        VDMVehicleDriverTick[v] = 0;
    }

    gAntiVDMInitialized = true;
    return 1;
}

static stock bool:AntiVDM_IsValidPlayer(playerid)
{
    return (playerid >= 0 && playerid < MAX_PLAYERS) && IsPlayerConnected(playerid);
}

static stock bool:AntiVDM_IsSameWorld(playerid, targetid)
{
    return GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)
        && GetPlayerInterior(playerid) == GetPlayerInterior(targetid);
}

static stock AntiVDM_GetPlayerDisplayName(playerid, output[], size = MAX_PLAYER_NAME)
{
    GetPlayerName(playerid, output, size);

    for(new i = 0, len = strlen(output); i < len; i++)
    {
        if(output[i] == '_')
        {
            output[i] = ' ';
        }
    }
    return 1;
}

static stock Float:AntiVDM_GetVehicleAimDifference(vehicleid, playerid)
{
    new
        Float:vehicle_x,
        Float:vehicle_y,
        Float:vehicle_z,
        Float:player_x,
        Float:player_y,
        Float:player_z,
        Float:vehicle_angle;

    if(!IsValidVehicle(vehicleid))
    {
        return 360.0;
    }

    GetVehiclePos(vehicleid, vehicle_x, vehicle_y, vehicle_z);
    GetPlayerPos(playerid, player_x, player_y, player_z);
    GetVehicleZAngle(vehicleid, vehicle_angle);

    new Float:target_angle = atan2(player_y - vehicle_y, player_x - vehicle_x);
    if(target_angle < 0.0)
    {
        target_angle += 360.0;
    }

    new Float:angle_diff = floatabs(vehicle_angle - target_angle);
    if(angle_diff > 180.0)
    {
        angle_diff = 360.0 - angle_diff;
    }
    return angle_diff;
}

static stock bool:AntiVDM_IsVehicleSteerEx(vehicleid, playerid, Float:max_angle)
{
    if(!AntiVDM_IsValidPlayer(playerid))
    {
        return false;
    }
    return AntiVDM_GetVehicleAimDifference(vehicleid, playerid) <= max_angle;
}

static stock Float:AntiVDM_GetVehDistToPlayer(vehicleid, playerid)
{
    new
        Float:vehicle_x,
        Float:vehicle_y,
        Float:vehicle_z,
        Float:player_x,
        Float:player_y,
        Float:player_z;

    if(!IsValidVehicle(vehicleid))
    {
        return 9999.9;
    }

    GetVehiclePos(vehicleid, vehicle_x, vehicle_y, vehicle_z);
    GetPlayerPos(playerid, player_x, player_y, player_z);

    return floatsqroot(
        ((vehicle_x - player_x) * (vehicle_x - player_x)) +
        ((vehicle_y - player_y) * (vehicle_y - player_y)) +
        ((vehicle_z - player_z) * (vehicle_z - player_z))
    );
}

static stock AntiVDM_SetVehicleDriverCache(vehicleid, playerid)
{
    if(vehicleid >= 0 && vehicleid < MAX_VEHICLES)
    {
        VDMVehicleDriverCache[vehicleid] = playerid;
        VDMVehicleDriverTick[vehicleid] = GetTickCount();
    }
    return 1;
}

static stock AntiVDM_ClearVehicleDriverCache(vehicleid, playerid = INVALID_PLAYER_ID)
{
    if(vehicleid < 0 || vehicleid >= MAX_VEHICLES)
    {
        return 1;
    }

    if(playerid == INVALID_PLAYER_ID || VDMVehicleDriverCache[vehicleid] == playerid)
    {
        VDMVehicleDriverCache[vehicleid] = INVALID_PLAYER_ID;
        VDMVehicleDriverTick[vehicleid] = 0;
    }
    return 1;
}

static stock AntiVDM_StopWarningDecay(playerid)
{
    if(playerid < 0 || playerid >= MAX_PLAYERS)
    {
        return 0;
    }

    if(VDMWarningDecayTimer[playerid] != -1)
    {
        KillTimer(VDMWarningDecayTimer[playerid]);
        VDMWarningDecayTimer[playerid] = -1;
    }
    return 1;
}

static stock AntiVDM_StartWarningDecay(playerid)
{
    if(playerid < 0 || playerid >= MAX_PLAYERS || VDMWarnings[playerid] <= 0)
    {
        return 0;
    }

    if(VDMWarningDecayTimer[playerid] == -1)
    {
        VDMWarningDecayTimer[playerid] = SetTimerEx("AntiVDM_DecayWarning", VDM_WARNING_DECAY_TIME, false, "i", playerid);
    }
    return 1;
}

forward AntiVDM_DecayWarning(playerid);
public AntiVDM_DecayWarning(playerid)
{
    AntiVDM_EnsureInit();

    if(playerid < 0 || playerid >= MAX_PLAYERS)
    {
        return 1;
    }

    VDMWarningDecayTimer[playerid] = -1;

    if(!AntiVDM_IsValidPlayer(playerid))
    {
        VDMWarnings[playerid] = 0;
        return 1;
    }

    if(VDMWarnings[playerid] > 0)
    {
        VDMWarnings[playerid]--;
        if(VDMWarnings[playerid] > 0)
        {
            AntiVDM_StartWarningDecay(playerid);
        }
        else
        {
            VDMRepeatHits[playerid] = 0;
            VDMLastVictim[playerid] = INVALID_PLAYER_ID;
            VDMLastHitTick[playerid] = 0;
        }
    }
    return 1;
}

stock ResetVDMWarnings(playerid)
{
    AntiVDM_EnsureInit();

    if(playerid < 0 || playerid >= MAX_PLAYERS)
    {
        return 0;
    }

    AntiVDM_StopWarningDecay(playerid);
    VDMWarnings[playerid] = 0;
    VDMRepeatHits[playerid] = 0;
    VDMLastVictim[playerid] = INVALID_PLAYER_ID;
    VDMLastHitTick[playerid] = 0;
    VDMVictimLastAttacker[playerid] = INVALID_PLAYER_ID;
    VDMVictimLastVehicle[playerid] = INVALID_VEHICLE_ID;
    VDMVictimLastTick[playerid] = 0;
    VDMKickPending[playerid] = false;
    return 1;
}

stock GetVehicleDriver(vehicleid)
{
    AntiVDM_EnsureInit();

    if(!IsValidVehicle(vehicleid))
    {
        return INVALID_PLAYER_ID;
    }

    if(vehicleid >= 0 && vehicleid < MAX_VEHICLES)
    {
        new cached_driver = VDMVehicleDriverCache[vehicleid];
        if(AntiVDM_IsValidPlayer(cached_driver)
        && IsPlayerInVehicle(cached_driver, vehicleid)
        && GetPlayerState(cached_driver) == PLAYER_STATE_DRIVER)
        {
            VDMVehicleDriverTick[vehicleid] = GetTickCount();
            return cached_driver;
        }
    }

    for(new playerid = 0; playerid < MAX_PLAYERS; playerid++)
    {
        if(!IsPlayerConnected(playerid))
        {
            continue;
        }

        if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        {
            continue;
        }

        if(GetPlayerVehicleID(playerid) != vehicleid)
        {
            continue;
        }

        AntiVDM_SetVehicleDriverCache(vehicleid, playerid);
        return playerid;
    }
    return INVALID_PLAYER_ID;
}

stock Float:GetVehicleSpeed(vehicleid)
{
    new
        Float:x,
        Float:y,
        Float:z;

    if(!IsValidVehicle(vehicleid))
    {
        return 0.0;
    }

    GetVehicleVelocity(vehicleid, x, y, z);
    return floatsqroot((x * x) + (y * y) + (z * z)) * 181.5;
}

stock bool:IsVehicleSteeringTowardPlayer(vehicleid, playerid)
{
    return AntiVDM_IsVehicleSteerEx(vehicleid, playerid, VDM_STEER_THRESHOLD);
}

stock bool:IsRepeatedVDMHit(playerid, victimid = INVALID_PLAYER_ID)
{
    AntiVDM_EnsureInit();

    if(playerid < 0 || playerid >= MAX_PLAYERS)
    {
        return false;
    }

    new tick = GetTickCount();
    new bool:same_victim = (victimid == INVALID_PLAYER_ID || VDMLastVictim[playerid] == victimid);

    if(same_victim && AntiVDM_GetTickDiff(tick, VDMLastHitTick[playerid]) <= VDM_REPEAT_HIT_TIME)
    {
        VDMRepeatHits[playerid]++;
    }
    else
    {
        VDMRepeatHits[playerid] = 1;
    }

    VDMLastVictim[playerid] = victimid;
    VDMLastHitTick[playerid] = tick;
    return VDMRepeatHits[playerid] >= VDM_MAX_REPEAT_HITS;
}

stock FindVehicleDamager(playerid)
{
    AntiVDM_EnsureInit();

    if(!AntiVDM_IsValidPlayer(playerid))
    {
        return INVALID_PLAYER_ID;
    }

    new attacker = INVALID_PLAYER_ID;
    new Float:best_distance = (VDM_ATTACK_DISTANCE + 2.5);

    for(new otherid = 0; otherid < MAX_PLAYERS; otherid++)
    {
        if(!IsPlayerConnected(otherid))
        {
            continue;
        }

        if(otherid == playerid)
        {
            continue;
        }

        if(GetPlayerState(otherid) != PLAYER_STATE_DRIVER)
        {
            continue;
        }

        if(!AntiVDM_IsSameWorld(otherid, playerid))
        {
            continue;
        }

        new vehicleid = GetPlayerVehicleID(otherid);
        if(!IsValidVehicle(vehicleid))
        {
            continue;
        }

        new Float:distance = AntiVDM_GetVehDistToPlayer(vehicleid, playerid);
        if(distance > (VDM_ATTACK_DISTANCE + 2.5))
        {
            continue;
        }

        if(GetVehicleSpeed(vehicleid) < 5.0)
        {
            continue;
        }

        if(!IsVehicleSteeringTowardPlayer(vehicleid, playerid) && distance > 4.0)
        {
            continue;
        }

        if(distance < best_distance)
        {
            best_distance = distance;
            attacker = otherid;
        }
    }
    return attacker;
}

static stock bool:AntiVDM_IsDuplicateHit(victimid, attacker, vehicleid)
{
    new tick = GetTickCount();

    if(VDMVictimLastAttacker[victimid] == attacker
    && VDMVictimLastVehicle[victimid] == vehicleid
    && AntiVDM_GetTickDiff(tick, VDMVictimLastTick[victimid]) <= VDM_DUPLICATE_HIT_TIME)
    {
        return true;
    }

    VDMVictimLastAttacker[victimid] = attacker;
    VDMVictimLastVehicle[victimid] = vehicleid;
    VDMVictimLastTick[victimid] = tick;
    return false;
}

static stock AntiVDM_ResolveAttacker(victimid, issuerid)
{
    if(AntiVDM_IsValidPlayer(issuerid) && IsPlayerInAnyVehicle(issuerid))
    {
        new vehicleid = GetPlayerVehicleID(issuerid);
        if(IsValidVehicle(vehicleid))
        {
            new driverid = GetVehicleDriver(vehicleid);
            if(AntiVDM_IsValidPlayer(driverid))
            {
                return driverid;
            }
        }
    }
    return FindVehicleDamager(victimid);
}

static stock bool:AntiVDM_IsIntentionalRoadkill(attacker, victimid, vehicleid, Float:amount)
{
    new Float:speed = GetVehicleSpeed(vehicleid);
    new Float:distance = AntiVDM_GetVehDistToPlayer(vehicleid, victimid);
    new bool:steering = IsVehicleSteeringTowardPlayer(vehicleid, victimid);
    new bool:hard_steering = AntiVDM_IsVehicleSteerEx(vehicleid, victimid, VDM_INTENT_STEER_THRESHOLD);
    new bool:repeated = IsRepeatedVDMHit(attacker, victimid);
    new score = 0;

    if(speed >= VDM_MIN_SPEED)
    {
        score++;
    }
    if(speed >= (VDM_MIN_SPEED + 20.0))
    {
        score++;
    }
    if(distance <= VDM_ATTACK_DISTANCE)
    {
        score++;
    }
    if(steering)
    {
        score++;
    }
    if(hard_steering)
    {
        score++;
    }
    if(repeated)
    {
        score += 2;
    }
    if(amount >= 15.0 && speed >= (VDM_MIN_SPEED + 10.0) && hard_steering && distance <= 5.5)
    {
        score++;
    }
    return score >= 4;
}

static stock AntiVDM_NotifyWarning(attacker, victimid)
{
    new attacker_name[MAX_PLAYER_NAME], victim_name[MAX_PLAYER_NAME], text[160];

    AntiVDM_GetPlayerDisplayName(attacker, attacker_name, sizeof(attacker_name));
    AntiVDM_GetPlayerDisplayName(victimid, victim_name, sizeof(victim_name));

    format(text, sizeof(text), "{F4C542}[ANTI-VDM]{FFFFFF} Warning %d/%d: vehicle damage detected.", VDMWarnings[attacker], MAX_VDM_WARNINGS);
    SendClientMessage(attacker, VDM_WARNING_COLOR, text);

    format(text, sizeof(text), "{FFAA33}[ANTI-VDM]{FFFFFF} %s hit you using a vehicle.", attacker_name);
    SendClientMessage(victimid, VDM_INFO_COLOR, text);
    return 1;
}

static stock AntiVDM_PunishIntentional(attacker, victimid, vehicleid)
{
    #pragma unused vehicleid

    new attacker_name[MAX_PLAYER_NAME], victim_name[MAX_PLAYER_NAME], text[170];

    AntiVDM_GetPlayerDisplayName(attacker, attacker_name, sizeof(attacker_name));
    AntiVDM_GetPlayerDisplayName(victimid, victim_name, sizeof(victim_name));

    format(text, sizeof(text), "{FF4D4D}[ANTI-VDM]{FFFFFF} Intentional roadkill detected. You are being removed.");
    SendClientMessage(attacker, VDM_INTENT_COLOR, text);

    format( text, sizeof(text), "{FF4D4D}[ANTI-VDM]{FFFFFF} Intentional VDM attempt from %s was blocked.", attacker_name);
    SendClientMessage(victimid, VDM_INFO_COLOR, text);

    format(text, sizeof(text), "[ANTI-VDM] %s was kicked for intentional VDM against %s.", attacker_name, victim_name);
    SendAdminMessage(VDM_INTENT_COLOR, text);
    KickEx(attacker);
    return 1;
}

static stock AntiVDM_PunishWarningLimit(attacker, victimid)
{
    new attacker_name[MAX_PLAYER_NAME], victim_name[MAX_PLAYER_NAME], text[170];

    AntiVDM_GetPlayerDisplayName(attacker, attacker_name, sizeof(attacker_name));
    AntiVDM_GetPlayerDisplayName(victimid, victim_name, sizeof(victim_name));

    format(text, sizeof(text), "[ANTI-VDM] %s was kicked after %d VDM warnings.", attacker_name, MAX_VDM_WARNINGS);
    SendAdminMessage(VDM_INTENT_COLOR, text);
    format(text, sizeof(text), "{FF4D4D}[ANTI-VDM]{FFFFFF} %s was removed by the Anti-VDM protection system.", attacker_name);
    SendClientMessage(victimid, VDM_INFO_COLOR, text);

    KickEx(attacker);
    return 1;
}

static stock AntiVDM_PunishDeath(attacker, victimid)
{
    if(VDMKickPending[attacker])
    {
        return 1;
    }

    new attacker_name[MAX_PLAYER_NAME], victim_name[MAX_PLAYER_NAME], text[170];

    AntiVDM_GetPlayerDisplayName(attacker, attacker_name, sizeof(attacker_name));
    AntiVDM_GetPlayerDisplayName(victimid, victim_name, sizeof(victim_name));

    format(text, sizeof(text), "{FF4D4D}[ANTI-VDM]{FFFFFF} You killed %s using a vehicle and were removed.", victim_name);
    SendClientMessage(attacker, VDM_INTENT_COLOR, text);

    format(text, sizeof(text), "[ANTI-VDM] %s was kicked for killing %s with VDM.", attacker_name, victim_name);
    SendAdminMessage(VDM_INTENT_COLOR, text);

    KickEx(attacker);
    return 1;
}

stock KickEx(playerid)
{
    if(!AntiVDM_IsValidPlayer(playerid))
    {
        return 0;
    }

    if(VDMKickPending[playerid])
    {
        return 1;
    }

    VDMKickPending[playerid] = true;
    SetTimerEx("AntiVDM_DeferredKick", 150, false, "i", playerid);
    return 1;
}

forward AntiVDM_DeferredKick(playerid);
public AntiVDM_DeferredKick(playerid)
{
    if(AntiVDM_IsValidPlayer(playerid))
    {
        Kick(playerid);
    }
    else if(playerid >= 0 && playerid < MAX_PLAYERS)
    {
        VDMKickPending[playerid] = false;
    }
    return 1;
}

stock AntiVDM_OnPlayerDeath(playerid, killerid, WEAPON:reason)
{
    AntiVDM_EnsureInit();

    if(!AntiVDM_IsValidPlayer(playerid) || _:reason != 49)
    {
        return 1;
    }

    new attacker = INVALID_PLAYER_ID;
    new tick = GetTickCount();

    if(AntiVDM_IsValidPlayer(VDMVictimLastAttacker[playerid])
    && AntiVDM_GetTickDiff(tick, VDMVictimLastTick[playerid]) <= VDM_DEATH_TRACE_TIME)
    {
        attacker = VDMVictimLastAttacker[playerid];
    }
    else if(AntiVDM_IsValidPlayer(killerid))
    {
        attacker = AntiVDM_ResolveAttacker(playerid, killerid);
    }
    else
    {
        attacker = FindVehicleDamager(playerid);
    }

    if(AntiVDM_IsValidPlayer(attacker) && attacker != playerid)
    {
        AntiVDM_PunishDeath(attacker, playerid);
    }
    return 1;
}

stock AntiVDM_OnPlayerConnect(playerid)
{
    AntiVDM_EnsureInit();
    ResetVDMWarnings(playerid);
    return 1;
}

stock AntiVDM_OnPlayerDisconnect(playerid, reason)
{
    #pragma unused reason

    AntiVDM_EnsureInit();

    if(IsPlayerInAnyVehicle(playerid))
    {
        AntiVDM_ClearVehicleDriverCache(GetPlayerVehicleID(playerid), playerid);
    }
    ResetVDMWarnings(playerid);
    return 1;
}

stock AntiVDM_OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate)
{
    AntiVDM_EnsureInit();

    if(oldstate == PLAYER_STATE_DRIVER)
    {
        AntiVDM_ClearVehicleDriverCache(GetPlayerVehicleID(playerid), playerid);
    }

    if(newstate == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
    {
        AntiVDM_SetVehicleDriverCache(GetPlayerVehicleID(playerid), playerid);
    }
    return 1;
}

stock AntiVDM_OnPlayerDamageDone(playerid, Float:amount, issuerid, WEAPON:weaponid, bodypart)
{
    #pragma unused bodypart

    AntiVDM_EnsureInit();

    if(!AntiVDM_IsValidPlayer(playerid)
    || amount < VDM_DAMAGE_THRESHOLD
    || _:weaponid != 49)
    {
        return 1;
    }

    new attacker = AntiVDM_ResolveAttacker(playerid, issuerid);
    if(!AntiVDM_IsValidPlayer(attacker) || attacker == playerid)
    {
        return 1;
    }

    if(!IsPlayerInAnyVehicle(attacker) || !AntiVDM_IsSameWorld(attacker, playerid))
    {
        return 1;
    }

    new vehicleid = GetPlayerVehicleID(attacker);
    if(!IsValidVehicle(vehicleid))
    {
        return 1;
    }

    if(AntiVDM_IsDuplicateHit(playerid, attacker, vehicleid))
    {
        return 1;
    }

    if(AntiVDM_IsIntentionalRoadkill(attacker, playerid, vehicleid, amount))
    {
        AntiVDM_PunishIntentional(attacker, playerid, vehicleid);
        return 1;
    }

    VDMWarnings[attacker]++;
    AntiVDM_NotifyWarning(attacker, playerid);
    AntiVDM_StartWarningDecay(attacker);

    if(VDMWarnings[attacker] >= MAX_VDM_WARNINGS)
    {
        AntiVDM_PunishWarningLimit(attacker, playerid);
    }
    return 1;
}

#undef ResetVDMWarnings
#undef GetVehicleDriver
#undef GetVehicleSpeed
#undef IsVehicleSteeringTowardPlayer
#undef IsRepeatedVDMHit
#undef FindVehicleDamager
