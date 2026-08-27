

#pragma option -d3
#include <open.mp>
#include <sampvoice>

#define MAX_VOICE_RADIO 31
#define MAX_RADIOS 50 
#define DUBAI_VOICE_BLUE 0x2F80EDFF
#define INSERT_KEY 0x2D
#define VOICE_TALK_KEY 0x42
#define MAX_INSERT_WARNINGS 2
#define pKicked 0
new PlayerInfo[MAX_PLAYERS][1];
new insert_key_warnings[MAX_PLAYERS];
new dubai_voice_call_name[] = "Dubai Voice | Call";
new dubai_voice_local_name[] = "Dubai Voice | Local";
new voice_phonecall_targetid[MAX_PLAYERS];
new voice_radiocall_radioid[MAX_PLAYERS];
new voice_factioncall_radioid[MAX_PLAYERS][2];
new SV_LSTREAM:local_stream[MAX_PLAYERS] = { SV_NULL, ... };
new SV_GSTREAM:radio_stream[MAX_VOICE_RADIO] = { SV_NULL, ... };
new SV_GSTREAM:callstream[MAX_PLAYERS] = { SV_NULL, ... };
new SV_GSTREAM:factiongang_stream[MAX_RADIOS][2];
forward ToggleListenerLocalStream(playerid, targetid, status);

public SV_VOID:OnPlayerActivationKeyPress(SV_UINT:playerid, SV_UINT:keyid) 
{
    if (keyid == INSERT_KEY)
    {
        // PlayerInfo belongs to the gamemode AMX, so request the real pAdmin
        // value through a public bridge instead of maintaining a duplicate.
        if (CallRemoteFunction("DubaiVoice_GetAdminLevel", "i", playerid) > 0)
        {
            return;
        }

        insert_key_warnings[playerid]++;

        if (insert_key_warnings[playerid] <= MAX_INSERT_WARNINGS)
        {
            new warning[160];
            format(warning, sizeof(warning),
                "{2F80ED}[DUBAI VOICE] {FFFFFF}Insert is restricted to administrators. Warning {FFCC00}%d/%d{FFFFFF}; the next attempt will disconnect you.",
                insert_key_warnings[playerid], MAX_INSERT_WARNINGS);
            SendClientMessage(playerid, -1, warning);
        }
        else
        {
            SendClientMessage(playerid, -1,
                "{2F80ED}[DUBAI VOICE] {FFFFFF}You were disconnected after repeatedly using the administrator-only Insert key.");
            KickPlayer(playerid);
        }
        return;
    }
	if (keyid == VOICE_TALK_KEY) {
        new pvarTalkStats = GetPVarInt(playerid,"talkStats");
        new pvarTalkStats2 = GetPVarInt(playerid,"radiostat");
        if(pvarTalkStats != 3) {
            // phone
            new callid = voice_phonecall_targetid[playerid];
            if(callid != 65535 && callid < MAX_PLAYERS) {
                if(callstream[playerid]) {
                    if(!SvHasSpeakerInStream(callstream[playerid], playerid))
                    {
                        SvAttachSpeakerToStream(callstream[playerid], playerid);
                    }
                }
            }
            // local
            else if(local_stream[playerid]) {
                if(!SvHasSpeakerInStream(local_stream[playerid], playerid))
                {
                    SvAttachSpeakerToStream(local_stream[playerid], playerid);
                }
            }

        }
        // radio
        else if(pvarTalkStats == 3) {
            new radioid = voice_radiocall_radioid[playerid];
            if(radioid > 0 && radioid < MAX_VOICE_RADIO) {
                if(radio_stream[radioid]) {
                    if(!SvHasSpeakerInStream(radio_stream[radioid], playerid))
                    {
                        SvAttachSpeakerToStream(radio_stream[radioid], playerid);
                    }
                }
            }
        }
        if(pvarTalkStats2 == 1) {
            new factionid = voice_factioncall_radioid[playerid][1];
            if(factionid >= 0 && factionid < MAX_RADIOS) {
                if(factiongang_stream[factionid][1]) {
                    if(!SvHasSpeakerInStream(factiongang_stream[factionid][1], playerid))
                    {
                        SvAttachSpeakerToStream(factiongang_stream[factionid][1], playerid);
                    }
                }
            }
        }
        else if(pvarTalkStats2 == 2) {
            new gangid = voice_factioncall_radioid[playerid][0];
            if(gangid >= 0 && gangid < MAX_RADIOS) {
                if(factiongang_stream[gangid][0]) {
                    if(!SvHasSpeakerInStream(factiongang_stream[gangid][0], playerid))
                    {
                        SvAttachSpeakerToStream(factiongang_stream[gangid][0], playerid);
                    }
                }
            }
        }
    }
}

public SV_VOID:OnPlayerActivationKeyRelease(SV_UINT:playerid, SV_UINT:keyid)
{
    if (keyid == VOICE_TALK_KEY) {
        // phone
        new callid = voice_phonecall_targetid[playerid];
        if(callid != 65535 && callid < MAX_PLAYERS) {
            if(callstream[playerid]) {
                if(SvHasSpeakerInStream(callstream[playerid], playerid))
                {
                    SvDetachSpeakerFromStream(callstream[playerid], playerid);
                }
            }
        }
        // local
        if(local_stream[playerid]) {
            if(SvHasSpeakerInStream(local_stream[playerid], playerid))
            {
                SvDetachSpeakerFromStream(local_stream[playerid], playerid);
            }
        }
        // radio
        new radioid = voice_radiocall_radioid[playerid];
        if(radioid > 0 && radioid < MAX_VOICE_RADIO) {
            if(radio_stream[radioid]) {
                if(SvHasSpeakerInStream(radio_stream[radioid], playerid))
                {
                    SvDetachSpeakerFromStream(radio_stream[radioid], playerid);
                }
            }
        }
   
		new factionid = voice_factioncall_radioid[playerid][1];
		if(factionid >= 0 && factionid < MAX_RADIOS) {
			if(factiongang_stream[factionid][1] != 0) {
			   if(SvHasSpeakerInStream(factiongang_stream[factionid][1], playerid))
			   {
				   SvDetachSpeakerFromStream(factiongang_stream[factionid][1], playerid);
			   }
			}
		}
		
  
		new gangid = voice_factioncall_radioid[playerid][0];
		if(gangid >= 0 && gangid < MAX_RADIOS) {
			if(factiongang_stream[gangid][0] != 0) {
			   if(SvHasSpeakerInStream(factiongang_stream[gangid][0], playerid))
			   {
				   SvDetachSpeakerFromStream(factiongang_stream[gangid][0], playerid);
			   }
			}
		}
		
    }
}

public ToggleListenerLocalStream(playerid, targetid, status) 
{
    if (playerid < 0 || playerid >= MAX_PLAYERS || targetid < 0 || targetid >= MAX_PLAYERS)
    {
        return 0;
    }

    if(status)
    {
        if(local_stream[playerid])
        {
            SvAttachListenerToStream(local_stream[playerid], targetid);
        }
    }
    else
    {
        if(local_stream[playerid])
        {
            SvDetachListenerFromStream(local_stream[playerid], targetid);
        } 
    }
    
    return 1;
}

forward deletecallstream(playerid);
public deletecallstream(playerid)
{
    if (playerid < 0 || playerid >= MAX_PLAYERS)
    {
        return 0;
    }

    new targetid = voice_phonecall_targetid[playerid];

    if(callstream[playerid])
    {
        SvDeleteStream(callstream[playerid]);
        callstream[playerid] = SV_NULL;
    }
    voice_phonecall_targetid[playerid] = 65535;

    if (targetid >= 0 && targetid < MAX_PLAYERS && targetid != playerid &&
        voice_phonecall_targetid[targetid] == playerid)
    {
        if (callstream[targetid])
        {
            SvDeleteStream(callstream[targetid]);
            callstream[targetid] = SV_NULL;
        }
        voice_phonecall_targetid[targetid] = 65535;
    }

    return 1;
}

forward callstreams(targetid, playerid);
public callstreams(targetid, playerid)
{
    if (playerid < 0 || playerid >= MAX_PLAYERS ||
        targetid < 0 || targetid >= MAX_PLAYERS || targetid == playerid)
    {
        return 0;
    }

    deletecallstream(playerid);
    deletecallstream(targetid);

   	callstream[playerid] = SvCreateGStream(DUBAI_VOICE_BLUE, dubai_voice_call_name);
    callstream[targetid] = SvCreateGStream(DUBAI_VOICE_BLUE, dubai_voice_call_name);

    if (!callstream[playerid] || !callstream[targetid])
    {
        deletecallstream(playerid);
        deletecallstream(targetid);
        return 0;
    }

    SvAttachListenerToStream(callstream[targetid], playerid);
    SvAttachListenerToStream(callstream[playerid], targetid);
    voice_phonecall_targetid[playerid] = targetid;
    voice_phonecall_targetid[targetid] = playerid;
	return 1;
}

forward KickPlayer(playerid);
public KickPlayer(playerid)
{
	if(!PlayerInfo[playerid][pKicked])
	{
	    PlayerInfo[playerid][pKicked] = 1;
	    SetTimerEx("KickPlayer", 200, false, "i", playerid);
	}
	else
	{
	    PlayerInfo[playerid][pKicked] = 0;
	    Kick(playerid);
	}
	return 1;
}

public OnPlayerConnect(playerid) {
    insert_key_warnings[playerid] = 0;
    PlayerInfo[playerid][pKicked] = 0;
    voice_phonecall_targetid[playerid] = 65535;
    voice_radiocall_radioid[playerid] = 0;
    voice_factioncall_radioid[playerid][0] = -1;
    voice_factioncall_radioid[playerid][1] = -1;
    callstream[playerid] = SV_NULL;
    local_stream[playerid] = SV_NULL;
    
    if (SvGetVersion(playerid) == SV_NULL)
    {
        SetPVarInt(playerid, "hasVoiceOnClient", 0);
        SendClientMessage(playerid, -1,
            "{2F80ED}[DUBAI VOICE] {FFFFFF}Voice client not detected. Install SA-MP Voice before joining Dubai Roleplay.");
        SendClientMessage(playerid, -1,
            "{2F80ED}[DUBAI VOICE] {FF6B6B}Connection closed: {FFFFFF}voice verification could not be completed.");
		KickPlayer(playerid);
    }
    
    else if (SvHasMicro(playerid) == SV_FALSE)
    {
        
        SetPVarInt(playerid, "hasVoiceOnClient", 2);
        SendClientMessage(playerid, -1,
            "{2F80ED}[DUBAI VOICE] {FFCC00}Microphone not detected. {FFFFFF}Connect a microphone to use proximity voice chat.");
    }
    
    
    else if ((local_stream[playerid] = SvCreateDLStreamAtPlayer(40.0, SV_INFINITY, playerid, DUBAI_VOICE_BLUE, dubai_voice_local_name)))
    {
        
        SvAddKey(playerid, VOICE_TALK_KEY);
       
        SvAddKey(playerid, INSERT_KEY);
        
        SetPVarInt(playerid, "hasVoiceOnClient", 1);
        SendClientMessage(playerid, -1,
            "{2F80ED}[DUBAI VOICE] {FFFFFF}Voice initialization completed successfully. Hold {2F80ED}B {FFFFFF}to speak.");
    }
    
}
public OnPlayerDisconnect(playerid, reason)
{
    insert_key_warnings[playerid] = 0;
    
    if (local_stream[playerid])
    {
        SvDeleteStream(local_stream[playerid]);
        local_stream[playerid] = SV_NULL;
    }
    deletecallstream(playerid);
    
    LeavePrivateVoiceChannel(playerid);
    
    LeaveGroupVoiceChannel(playerid);
    LeaveFgVoiceChannel(playerid, 0);
    LeaveFgVoiceChannel(playerid, 1);
}

public OnFilterScriptInit() {
    new string[128];
    

    
    for(new i = 0; i < MAX_VOICE_RADIO; i++)
    {
        format(string, sizeof(string), "Dubai Voice | Radio %i", i);
        radio_stream[i] = SvCreateGStream(DUBAI_VOICE_BLUE, string);
    }
}

forward createfgstream(fgid, type);
public createfgstream(fgid, type)
{
    if (fgid < 0 || fgid >= MAX_RADIOS || type < 0 || type > 1)
    {
        return 0;
    }

    
    new string[128];
    switch(type)
    {
       case 0 :
       {
           format(string, sizeof(string), "Dubai Voice | Gang Radio %i", fgid);
       }
       case 1 :
       {
           format(string, sizeof(string), "Dubai Voice | Faction Radio %i", fgid);
       }

    }
    if (factiongang_stream[fgid][type])
    {
        SvDeleteStream(factiongang_stream[fgid][type]);
    }
    factiongang_stream[fgid][type] = SvCreateGStream(DUBAI_VOICE_BLUE, string);
	return 1;
}

forward destroyfgstream();
public destroyfgstream()
{
    for(new i; i < MAX_RADIOS; i++)
    {
        if (factiongang_stream[i][0])
        {
            SvDeleteStream(factiongang_stream[i][0]);
            factiongang_stream[i][0] = SV_NULL;
        }
        if (factiongang_stream[i][1])
        {
            SvDeleteStream(factiongang_stream[i][1]);
            factiongang_stream[i][1] = SV_NULL;
        }
    }
	return 1;
}

public OnFilterScriptExit() {
   
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        deletecallstream(i);
        if (local_stream[i])
        {
            SvDeleteStream(local_stream[i]);
            local_stream[i] = SV_NULL;
        }
    }
    
    for(new i = 0; i < MAX_VOICE_RADIO; i++)
    {
        if (radio_stream[i]) SvDeleteStream(radio_stream[i]);
    }
    destroyfgstream();
}

forward JoinPrivateVoiceChannel(playerid, targetid);
public JoinPrivateVoiceChannel(playerid, targetid)
{
    return callstreams(targetid, playerid);
}

forward LeavePrivateVoiceChannel(playerid);
public LeavePrivateVoiceChannel(playerid)
{
    return deletecallstream(playerid);
}

forward JoinFgVoiceChannel(fgid, playerid, type);
public JoinFgVoiceChannel(fgid, playerid, type)
{
    if (playerid < 0 || playerid >= MAX_PLAYERS ||
        fgid < 0 || fgid >= MAX_RADIOS || type < 0 || type > 1)
    {
        return 0;
    }
   
    LeaveFgVoiceChannel(playerid, type);
   
    if (factiongang_stream[fgid][type] != 0) {
        if(!SvHasListenerInStream(factiongang_stream[fgid][type], playerid)) {
            SvAttachListenerToStream(factiongang_stream[fgid][type], playerid);
        }
    }
    
    voice_factioncall_radioid[playerid][type] = fgid;
    return 1;
}

forward LeaveFgVoiceChannel(playerid , type);
public LeaveFgVoiceChannel(playerid , type)
{
    if (playerid < 0 || playerid >= MAX_PLAYERS || type < 0 || type > 1)
    {
        return 0;
    }

    new oldchannelid = voice_factioncall_radioid[playerid][type];
    voice_factioncall_radioid[playerid][type] = -1;
    if (oldchannelid >= 0 && oldchannelid < MAX_RADIOS && factiongang_stream[oldchannelid][type]) {
        
        if(SvHasSpeakerInStream(factiongang_stream[oldchannelid][type], playerid))
        {
            SvDetachSpeakerFromStream(factiongang_stream[oldchannelid][type], playerid);
        }
        
        if(SvHasListenerInStream(factiongang_stream[oldchannelid][type], playerid))
        {
            SvDetachListenerFromStream(factiongang_stream[oldchannelid][type], playerid);
        }
    }
	return 1;
}

forward JoinGroupVoiceChannel(playerid, frequency_id);
public JoinGroupVoiceChannel(playerid, frequency_id)
{
    if (playerid < 0 || playerid >= MAX_PLAYERS ||
        frequency_id <= 0 || frequency_id >= MAX_VOICE_RADIO)
    {
        return 0;
    }
    
    LeaveGroupVoiceChannel(playerid);
    
    if (radio_stream[frequency_id]) {
        if(!SvHasListenerInStream(radio_stream[frequency_id], playerid)) {
            SvAttachListenerToStream(radio_stream[frequency_id], playerid);
        }
    }
    
    voice_radiocall_radioid[playerid] = frequency_id;
    return 1;
}

forward LeaveGroupVoiceChannel(playerid);
public LeaveGroupVoiceChannel(playerid)
{
    if (playerid < 0 || playerid >= MAX_PLAYERS)
    {
        return 0;
    }

    new oldchannelid = voice_radiocall_radioid[playerid];
    voice_radiocall_radioid[playerid] = 0;
    if (oldchannelid > 0 && oldchannelid < MAX_VOICE_RADIO && radio_stream[oldchannelid]) {
        
        if(SvHasSpeakerInStream(radio_stream[oldchannelid], playerid))
        {
            SvDetachSpeakerFromStream(radio_stream[oldchannelid], playerid);
        }
        
        if(SvHasListenerInStream(radio_stream[oldchannelid], playerid))
        {
            SvDetachListenerFromStream(radio_stream[oldchannelid], playerid);
        }
    }
    return 1;
}
