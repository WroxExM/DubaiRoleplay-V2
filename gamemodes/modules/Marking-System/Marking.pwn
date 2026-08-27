#if defined _tactical_marking_included
	#endinput
#endif
#define _tactical_marking_included

#if !defined KEY_WALK
	#define KEY_WALK (1024)
#endif


#define MARK_MAX_ACTIVE            (160)


enum E_TACTICAL_MARK
{
	bool:tmUsed,
	tmGang,
	tmOwner,
	tmCreated,
	tmExpire,
	tmWorld,
	tmInterior,
	Float:tmX,
	Float:tmY,
	Float:tmZ,
	Float:tmDirX,
	Float:tmDirY,
	Float:tmDirZ,
	Float:tmRadius
};

enum E_BULLET_HISTORY
{
	bool:tbUsed,
	tbTick,
	Float:tbFromX,
	Float:tbFromY,
	Float:tbFromZ,
	Float:tbToX,
	Float:tbToY,
	Float:tbToZ,
	Float:tbHitX,
	Float:tbHitY,
	Float:tbHitZ,
	Float:tbDirX,
	Float:tbDirY,
	Float:tbDirZ
};

new TacticalMark[MARK_MAX_ACTIVE][E_TACTICAL_MARK];
new TacticalBullet[MAX_PLAYERS][4][E_BULLET_HISTORY];
new TacticalBulletIndex[MAX_PLAYERS];
new TacticalLastMarkTick[MAX_PLAYERS];
new TacticalLastShotTick[MAX_PLAYERS];
new TacticalVisibleMark[MAX_PLAYERS];
new TacticalSyncTimer = -1;
new bool:TacticalColAndreasReady;
new bool:TacticalColAndreasTried;

forward Tactical_MarkerPulse();

stock Tactical_IsPlayerValid(playerid)
{
	return (0 <= playerid < MAX_PLAYERS && IsPlayerConnected(playerid));
}

stock Tactical_TickDiff(now, old)
{
	return (now >= old) ? (now - old) : ((cellmax - old) + now + 1);
}

stock Float:Tactical_VectorLength(Float:x, Float:y, Float:z)
{
	return floatsqroot((x * x) + (y * y) + (z * z));
}

stock Tactical_NormalizeVector(&Float:x, &Float:y, &Float:z)
{
	new Float:length = Tactical_VectorLength(x, y, z);
	if(length <= 0.0001) return 0;

	x /= length;
	y /= length;
	z /= length;
	return 1;
}

stock Tactical_GetPlayerSpeedVector(playerid, &Float:vx, &Float:vy, &Float:vz)
{
	vx = 0.0;
	vy = 0.0;
	vz = 0.0;

	if(IsPlayerInAnyVehicle(playerid))
	{
		GetVehicleVelocity(GetPlayerVehicleID(playerid), vx, vy, vz);
	}
	else
	{
		GetPlayerVelocity(playerid, vx, vy, vz);
	}
	return 1;
}

stock Tactical_IsGangReady(gangid)
{
	return (0 <= gangid < MAX_GANGS && GangInfo[gangid][gSetup]);
}

stock Tactical_IsNetworkOnline(playerid)
{
	if(!Tactical_IsPlayerValid(playerid)) return 0;
	if(PlayerInfo[playerid][pGang] == -1) return 0;
	if(!Tactical_IsGangReady(PlayerInfo[playerid][pGang])) return 0;
	return (PlayerInfo[playerid][pBandana] && PlayerInfo[playerid][pEnableMarking]);
}

stock Tactical_GetVisualColor(gangid)
{
	if(Tactical_IsGangReady(gangid) && GangInfo[gangid][gColor] != -1 && GangInfo[gangid][gColor] != -256)
	{
		return (GangInfo[gangid][gColor] & 0xFFFFFF00) | 0xFF;
	}
	return 0x00B4D8FF;
}

stock Tactical_ClearVisuals(playerid)
{
	if(!Tactical_IsPlayerValid(playerid)) return 0;

	DisablePlayerCheckpoint(playerid);
	DisablePlayerRaceCheckpoint(playerid);
	for(new i = 0; i < 8; i++)
	{
		RemovePlayerMapIcon(playerid, 80 + i);
	}
	TacticalVisibleMark[playerid] = -1;
	return 1;
}

stock Tactical_ResetPlayer(playerid)
{
	PlayerInfo[playerid][pEnableMarking] = 0;
	TacticalLastMarkTick[playerid] = 0;
	TacticalLastShotTick[playerid] = 0;
	TacticalBulletIndex[playerid] = 0;
	TacticalVisibleMark[playerid] = -1;

	for(new i = 0; i < 4; i++)
	{
		TacticalBullet[playerid][i][tbUsed] = false;
		TacticalBullet[playerid][i][tbTick] = 0;
	}
	Tactical_ClearVisuals(playerid);
	return 1;
}

stock Tactical_HasActiveMarks()
{
	for(new i = 0; i < MARK_MAX_ACTIVE; i++)
	{
		if(TacticalMark[i][tmUsed]) return 1;
	}
	return 0;
}

stock Tactical_EnsurePulseTimer()
{
	if(TacticalSyncTimer == -1)
	{
		TacticalSyncTimer = SetTimer("Tactical_MarkerPulse", 5000, true);
	}
	return 1;
}

stock Tactical_StopPulseTimerIfIdle()
{
	if(TacticalSyncTimer != -1 && !Tactical_HasActiveMarks())
	{
		KillTimer(TacticalSyncTimer);
		TacticalSyncTimer = -1;
	}
	return 1;
}

stock Tactical_Init()
{
	TacticalSyncTimer = -1;
	TacticalColAndreasTried = false;
	TacticalColAndreasReady = false;
	// CA_Init builds ColAndreas' collision world and can block for several
	// seconds.  Never run it inside the server's OnGameModeInit callback.
	SetTimer("Tactical_DeferredColAndreasInit", 1, false);
	return 1;
}

forward Tactical_DeferredColAndreasInit();
public Tactical_DeferredColAndreasInit()
{
	if(TacticalColAndreasTried) return 1;

	TacticalColAndreasTried = true;
	new startedAt = GetTickCount();
	TacticalColAndreasReady = (CA_Init() != 0);
	printf(
		"[TAC-NET] ColAndreas initialization %s in %d ms.",
		TacticalColAndreasReady ? ("completed") : ("failed"),
		GetTickCount() - startedAt
	);
	return 1;
}

stock Tactical_EnableForBandana(playerid)
{
	if(!Tactical_IsPlayerValid(playerid)) return 0;
	if(!Tactical_IsGangReady(PlayerInfo[playerid][pGang])) return 0;

	PlayerInfo[playerid][pEnableMarking] = 1;
	Tactical_ClearVisuals(playerid);
	SendClientMessage(playerid, 0x00E6A8FF, "[TAC-NET] Linked to gang channel. Press ALT to mark live positions.");
	ShowTDN(playerid, "[TAC-NET] Linked to gang channel. Press ALT to mark live positions.");
	PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
	Tactical_RefreshPlayer(playerid);
	return 1;
}

stock Tactical_DisableForBandana(playerid)
{
	if(!Tactical_IsPlayerValid(playerid)) return 0;

	PlayerInfo[playerid][pEnableMarking] = 0;
	Tactical_ClearVisuals(playerid);
	SendClientMessage(playerid, 0xFFD166FF, "[TAC-NET] Channel closed. Tactical markers cleared.");
	ShowTDN(playerid, "[TAC-NET] Channel closed. Tactical markers cleared.");
	PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
	return 1;
}

stock Tactical_CountGangMarks(gangid)
{
	new count;
	for(new i = 0; i < MARK_MAX_ACTIVE; i++)
	{
		if(TacticalMark[i][tmUsed] && TacticalMark[i][tmGang] == gangid)
		{
			count++;
		}
	}
	return count;
}

stock Tactical_FreeOldestGangMark(gangid)
{
	new oldest = -1;
	new oldestTick = cellmax;

	for(new i = 0; i < MARK_MAX_ACTIVE; i++)
	{
		if(TacticalMark[i][tmUsed] && TacticalMark[i][tmGang] == gangid && TacticalMark[i][tmCreated] < oldestTick)
		{
			oldest = i;
			oldestTick = TacticalMark[i][tmCreated];
		}
	}
	if(oldest != -1)
	{
		Tactical_ClearGangMark(oldest);
	}
	return oldest;
}

stock Tactical_GetFreeMarkSlot(gangid)
{
	if(Tactical_CountGangMarks(gangid) >= 8)
	{
		Tactical_FreeOldestGangMark(gangid);
	}

	for(new i = 0; i < MARK_MAX_ACTIVE; i++)
	{
		if(!TacticalMark[i][tmUsed]) return i;
	}

	new oldest = 0;
	for(new i = 1; i < MARK_MAX_ACTIVE; i++)
	{
		if(TacticalMark[i][tmCreated] < TacticalMark[oldest][tmCreated])
		{
			oldest = i;
		}
	}
	return oldest;
}

stock Tactical_GetMarkVisualSlot(markid)
{
	new slot;
	new gangid = TacticalMark[markid][tmGang];

	for(new i = 0; i < markid; i++)
	{
		if(TacticalMark[i][tmUsed] && TacticalMark[i][tmGang] == gangid)
		{
			slot++;
		}
	}
	return (slot % 8);
}

stock Tactical_Raycast(Float:startX, Float:startY, Float:startZ, Float:endX, Float:endY, Float:endZ, &Float:x, &Float:y, &Float:z)
{
	if(!TacticalColAndreasReady)
	{
		if(!TacticalColAndreasTried)
		{
			TacticalColAndreasTried = true;
			TacticalColAndreasReady = (CA_Init() != 0);
		}
		if(!TacticalColAndreasReady) return 0;
	}

	new model = CA_RayCastLine(startX, startY, startZ, endX, endY, endZ, x, y, z);
	if(!model || model == WATER_OBJECT) return 0;
	if(x != x || y != y || z != z) return 0;
	if(floatabs(x) > 20000.0 || floatabs(y) > 20000.0 || z < -200.0 || z > 2000.0) return 0;

	new Float:dx = x - startX;
	new Float:dy = y - startY;
	new Float:dz = z - startZ;
	if(Tactical_VectorLength(dx, dy, dz) < 1.2) return 0;
	return 1;
}

stock Tactical_GetCameraPoint(playerid, &Float:x, &Float:y, &Float:z, &Float:dirX, &Float:dirY, &Float:dirZ)
{
	new Float:camX, Float:camY, Float:camZ;
	new Float:vx, Float:vy, Float:vz;

	GetPlayerCameraPos(playerid, camX, camY, camZ);
	GetPlayerCameraFrontVector(playerid, dirX, dirY, dirZ);
	if(!Tactical_NormalizeVector(dirX, dirY, dirZ)) return 0;

	Tactical_GetPlayerSpeedVector(playerid, vx, vy, vz);
	camX += (dirX * 0.85) + (vx * 4.0);
	camY += (dirY * 0.85) + (vy * 4.0);
	camZ += (dirZ * 0.85) + 0.12 + (vz * 2.0);

	new Float:endX = camX + (dirX * 850.0);
	new Float:endY = camY + (dirY * 850.0);
	new Float:endZ = camZ + (dirZ * 850.0);

	return Tactical_Raycast(camX, camY, camZ, endX, endY, endZ, x, y, z);
}

stock Tactical_GetRecentBulletPoint(playerid, &Float:x, &Float:y, &Float:z, &Float:dirX, &Float:dirY, &Float:dirZ)
{
	new now = GetTickCount();

	for(new n = 0; n < 4; n++)
	{
		new idx = (TacticalBulletIndex[playerid] - 1 - n + 4) % 4;
		if(!TacticalBullet[playerid][idx][tbUsed]) continue;
		if(Tactical_TickDiff(now, TacticalBullet[playerid][idx][tbTick]) > 900) continue;

		x = TacticalBullet[playerid][idx][tbHitX];
		y = TacticalBullet[playerid][idx][tbHitY];
		z = TacticalBullet[playerid][idx][tbHitZ];
		dirX = TacticalBullet[playerid][idx][tbDirX];
		dirY = TacticalBullet[playerid][idx][tbDirY];
		dirZ = TacticalBullet[playerid][idx][tbDirZ];
		TacticalBullet[playerid][idx][tbUsed] = false;
		return 1;
	}
	return 0;
}

stock Tactical_ResolvePoint(playerid, &Float:x, &Float:y, &Float:z, &Float:dirX, &Float:dirY, &Float:dirZ)
{
	if(Tactical_GetRecentBulletPoint(playerid, x, y, z, dirX, dirY, dirZ))
	{
		return 1;
	}
	return Tactical_GetCameraPoint(playerid, x, y, z, dirX, dirY, dirZ);
}

stock Tactical_BroadcastMark(owner, markid)
{
	new gangid = TacticalMark[markid][tmGang];
	new Float:x = TacticalMark[markid][tmX];
	new Float:y = TacticalMark[markid][tmY];
	new Float:z = TacticalMark[markid][tmZ];
	new Float:dist;

	foreach(new i : Player)
	{
		if(!Tactical_IsNetworkOnline(i)) continue;
		if(PlayerInfo[i][pGang] != gangid) continue;
		if(GetPlayerVirtualWorld(i) != TacticalMark[markid][tmWorld]) continue;
		if(GetPlayerInterior(i) != TacticalMark[markid][tmInterior]) continue;

		dist = GetPlayerDistanceFromPoint(i, x, y, z);
		if(dist > 520.0) continue;

		if(i == owner)
		{
			ShowTDN(i, "[TAC-NET] Marker sent to your gang.");
		}
		else
		{
			ShowTDN(i, "[TAC-NET] Live marker synced.");
		}
		PlayerPlaySound(i, 1056, x, y, z);
	}
	return 1;
}

stock Tactical_CreateMark(playerid)
{
	if(!Tactical_IsNetworkOnline(playerid))
	{
		SendClientMessage(playerid, 0xFF4D6DFF, "[TAC-NET] Wear your gang bandana to open the tactical channel.");
		ShowTDN(playerid, "Turn On Your Bandana to see the gang members marks.");
		return 1;
	}

	new now = GetTickCount();
	if(Tactical_TickDiff(now, TacticalLastMarkTick[playerid]) < 1500)
	{
		ShowTDN(playerid, "[TAC-NET] Marker link cooling down.");
		return 1;
	}

	new Float:x, Float:y, Float:z;
	new Float:dirX, Float:dirY, Float:dirZ;

	if(!Tactical_ResolvePoint(playerid, x, y, z, dirX, dirY, dirZ))
	{
		PlayerPlaySound(playerid, 1055, 0.0, 0.0, 0.0);
		ShowTDN(playerid, "[TAC-NET] No surface lock.");
		return 1;
	}

	new gangid = PlayerInfo[playerid][pGang];
	new slot = Tactical_GetFreeMarkSlot(gangid);

	TacticalMark[slot][tmUsed] = true;
	TacticalMark[slot][tmGang] = gangid;
	TacticalMark[slot][tmOwner] = playerid;
	TacticalMark[slot][tmCreated] = now;
	TacticalMark[slot][tmExpire] = now + 60000;
	TacticalMark[slot][tmWorld] = GetPlayerVirtualWorld(playerid);
	TacticalMark[slot][tmInterior] = GetPlayerInterior(playerid);
	TacticalMark[slot][tmX] = x;
	TacticalMark[slot][tmY] = y;
	TacticalMark[slot][tmZ] = z + 0.12;
	TacticalMark[slot][tmDirX] = dirX;
	TacticalMark[slot][tmDirY] = dirY;
	TacticalMark[slot][tmDirZ] = dirZ;
	TacticalMark[slot][tmRadius] = 3.6;
	TacticalLastMarkTick[playerid] = now;

	Tactical_BroadcastMark(playerid, slot);
	Tactical_ShowMarkForGang(slot);
	Tactical_EnsurePulseTimer();
	return 1;
}

stock Tactical_StoreShot(playerid, WEAPON:weaponid)
{
	if(!Tactical_IsNetworkOnline(playerid)) return 1;
	if(_:weaponid < 22 || _:weaponid > 34) return 1;

	new now = GetTickCount();
	if(Tactical_TickDiff(now, TacticalLastShotTick[playerid]) < 250) return 1;
	TacticalLastShotTick[playerid] = now;

	new Float:fromX, Float:fromY, Float:fromZ;
	new Float:toX, Float:toY, Float:toZ;

	if(!GetPlayerLastShotVectors(playerid, fromX, fromY, fromZ, toX, toY, toZ)) return 1;
	if((fromX == 0.0 && fromY == 0.0 && fromZ == 0.0) || (toX == 0.0 && toY == 0.0 && toZ == 0.0)) return 1;

	new Float:hitX, Float:hitY, Float:hitZ;
	if(!Tactical_Raycast(fromX, fromY, fromZ, toX, toY, toZ, hitX, hitY, hitZ)) return 1;

	new Float:dirX = toX - fromX;
	new Float:dirY = toY - fromY;
	new Float:dirZ = toZ - fromZ;
	Tactical_NormalizeVector(dirX, dirY, dirZ);

	new idx = TacticalBulletIndex[playerid];
	TacticalBullet[playerid][idx][tbUsed] = true;
	TacticalBullet[playerid][idx][tbTick] = now;
	TacticalBullet[playerid][idx][tbFromX] = fromX;
	TacticalBullet[playerid][idx][tbFromY] = fromY;
	TacticalBullet[playerid][idx][tbFromZ] = fromZ;
	TacticalBullet[playerid][idx][tbToX] = toX;
	TacticalBullet[playerid][idx][tbToY] = toY;
	TacticalBullet[playerid][idx][tbToZ] = toZ;
	TacticalBullet[playerid][idx][tbHitX] = hitX;
	TacticalBullet[playerid][idx][tbHitY] = hitY;
	TacticalBullet[playerid][idx][tbHitZ] = hitZ + 0.12;
	TacticalBullet[playerid][idx][tbDirX] = dirX;
	TacticalBullet[playerid][idx][tbDirY] = dirY;
	TacticalBullet[playerid][idx][tbDirZ] = dirZ;
	TacticalBulletIndex[playerid] = (idx + 1) % 4;
	return 1;
}

stock Tactical_GetBestVisibleMark(playerid)
{
	new best = -1;
	new bestCreated = -1;
	new gangid = PlayerInfo[playerid][pGang];
	new world = GetPlayerVirtualWorld(playerid);
	new interior = GetPlayerInterior(playerid);

	for(new i = 0; i < MARK_MAX_ACTIVE; i++)
	{
		if(!TacticalMark[i][tmUsed]) continue;
		if(TacticalMark[i][tmGang] != gangid) continue;
		if(TacticalMark[i][tmWorld] != world || TacticalMark[i][tmInterior] != interior) continue;
		if(GetPlayerDistanceFromPoint(playerid, TacticalMark[i][tmX], TacticalMark[i][tmY], TacticalMark[i][tmZ]) > 520.0) continue;

		if(TacticalMark[i][tmCreated] > bestCreated)
		{
			best = i;
			bestCreated = TacticalMark[i][tmCreated];
		}
	}
	return best;
}

stock Tactical_ShowMarkForPlayer(playerid, markid, bool:flash)
{
	new iconSlot = 80 + Tactical_GetMarkVisualSlot(markid);
	new gangid = TacticalMark[markid][tmGang];
	new Float:x = TacticalMark[markid][tmX];
	new Float:y = TacticalMark[markid][tmY];
	new Float:z = TacticalMark[markid][tmZ];
	new Float:size = TacticalMark[markid][tmRadius];
	new raceType = flash ? 1 : 0;

	SetPlayerCheckpoint(playerid, x, y, z, size + 1.4);
	SetPlayerRaceCheckpoint(playerid, raceType, x, y, z, x + TacticalMark[markid][tmDirX] * 8.0, y + TacticalMark[markid][tmDirY] * 8.0, z, size);
	SetPlayerMapIcon(playerid, iconSlot, x, y, z, 0, Tactical_GetVisualColor(gangid), MAPICON_GLOBAL);
	TacticalVisibleMark[playerid] = markid;
	return 1;
}

stock Tactical_ShowMarkForGang(markid)
{
	if(!(0 <= markid < MARK_MAX_ACTIVE)) return 0;
	if(!TacticalMark[markid][tmUsed]) return 0;

	new gangid = TacticalMark[markid][tmGang];
	foreach(new i : Player)
	{
		if(!Tactical_IsNetworkOnline(i)) continue;
		if(PlayerInfo[i][pGang] != gangid) continue;
		if(GetPlayerVirtualWorld(i) != TacticalMark[markid][tmWorld]) continue;
		if(GetPlayerInterior(i) != TacticalMark[markid][tmInterior]) continue;
		if(GetPlayerDistanceFromPoint(i, TacticalMark[markid][tmX], TacticalMark[markid][tmY], TacticalMark[markid][tmZ]) > 520.0) continue;

		Tactical_ShowMarkForPlayer(i, markid, false);
	}
	return 1;
}

stock Tactical_RefreshPlayer(playerid)
{
	if(!Tactical_IsNetworkOnline(playerid))
	{
		return Tactical_ClearVisuals(playerid);
	}

	new markid = Tactical_GetBestVisibleMark(playerid);
	if(markid == -1)
	{
		return Tactical_ClearVisuals(playerid);
	}
	return Tactical_ShowMarkForPlayer(playerid, markid, false);
}

stock Tactical_ClearGangMark(markid, reachedby = INVALID_PLAYER_ID)
{
	if(!(0 <= markid < MARK_MAX_ACTIVE)) return 0;
	if(!TacticalMark[markid][tmUsed]) return 0;

	new gangid = TacticalMark[markid][tmGang];
	TacticalMark[markid][tmUsed] = false;

	foreach(new i : Player)
	{
		if(PlayerInfo[i][pGang] != gangid) continue;

		if(TacticalVisibleMark[i] == markid)
		{
			Tactical_ClearVisuals(i);
		}
		if(reachedby != INVALID_PLAYER_ID && Tactical_IsNetworkOnline(i))
		{
			ShowTDN(i, "[TAC-NET] Marker reached and cleared.");
			ShowTDN(i, "Gang Marking Cleared");
		}
	}
	return 1;
}

stock Tactical_TryReachMark(playerid)
{
	if(!Tactical_IsNetworkOnline(playerid)) return 0;

	new markid = TacticalVisibleMark[playerid];
	if(!(0 <= markid < MARK_MAX_ACTIVE)) return 0;
	if(!TacticalMark[markid][tmUsed]) return 0;
	if(TacticalMark[markid][tmGang] != PlayerInfo[playerid][pGang]) return 0;
	if(GetPlayerVirtualWorld(playerid) != TacticalMark[markid][tmWorld]) return 0;
	if(GetPlayerInterior(playerid) != TacticalMark[markid][tmInterior]) return 0;

	if(GetPlayerDistanceFromPoint(playerid, TacticalMark[markid][tmX], TacticalMark[markid][tmY], TacticalMark[markid][tmZ]) <= (TacticalMark[markid][tmRadius] + 2.5))
	{
		Tactical_ClearGangMark(markid, playerid);
		Tactical_MarkerPulse();
		return 1;
	}
	return 0;
}

public Tactical_MarkerPulse()
{
	new now = GetTickCount();

	for(new i = 0; i < MARK_MAX_ACTIVE; i++)
	{
		if(!TacticalMark[i][tmUsed]) continue;
		if(Tactical_TickDiff(now, TacticalMark[i][tmCreated]) >= 60000)
		{
			Tactical_ClearGangMark(i);
		}
	}

	foreach(new playerid : Player)
	{
		if(!Tactical_IsNetworkOnline(playerid))
		{
			if(TacticalVisibleMark[playerid] != -1)
			{
				Tactical_ClearVisuals(playerid);
			}
			continue;
		}

		new markid = TacticalVisibleMark[playerid];
		if(0 <= markid < MARK_MAX_ACTIVE && TacticalMark[markid][tmUsed] && TacticalMark[markid][tmGang] == PlayerInfo[playerid][pGang])
		{
			continue;
		}

		if(TacticalVisibleMark[playerid] != -1)
		{
			Tactical_ClearVisuals(playerid);
			continue;
		}

		markid = Tactical_GetBestVisibleMark(playerid);
		if(markid != -1)
		{
			Tactical_ShowMarkForPlayer(playerid, markid, false);
		}
	}

	Tactical_StopPulseTimerIfIdle();
	return 1;
}

stock Tactical_OnPlayerConnect(playerid)
{
	Tactical_ResetPlayer(playerid);
	return 1;
}

stock Tactical_OnPlayerDisconnect(playerid)
{
	for(new i = 0; i < MARK_MAX_ACTIVE; i++)
	{
		if(TacticalMark[i][tmUsed] && TacticalMark[i][tmOwner] == playerid)
		{
			Tactical_ClearGangMark(i);
		}
	}
	Tactical_ResetPlayer(playerid);
	Tactical_StopPulseTimerIfIdle();
	return 1;
}

stock Tactical_OnBandanaChanged(playerid)
{
	if(PlayerInfo[playerid][pBandana]) return Tactical_EnableForBandana(playerid);
	return Tactical_DisableForBandana(playerid);
}

stock Tactical_OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	if(((newkeys & KEY_WALK) == KEY_WALK) && ((oldkeys & KEY_WALK) != KEY_WALK))
	{
		if(Tactical_IsNetworkOnline(playerid))
		{
			Tactical_CreateMark(playerid);
		}
	}
	return 1;
}

stock Tactical_OnPlayerWeaponShot(playerid, WEAPON:weaponid, BULLET_HIT_TYPE:hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	#pragma unused hittype
	#pragma unused hitid
	#pragma unused fX
	#pragma unused fY
	#pragma unused fZ
	return Tactical_StoreShot(playerid, weaponid);
}

stock Tactical_OnEnterCP(playerid)
{
	return Tactical_TryReachMark(playerid);
}

stock Tactical_OnEnterRaceCP(playerid)
{
	return Tactical_TryReachMark(playerid);
}
