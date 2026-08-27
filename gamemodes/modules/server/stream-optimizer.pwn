// Streamer tuning for heavy mapping zones (9000+ objects).

#if !defined STREAMER_OPTIMIZER_INCLUDED
#define STREAMER_OPTIMIZER_INCLUDED

// SA-MP 0.3.7-compatible clients have a 1000-object pool shared by global and
// player objects.  950 leaves headroom for gameplay/attached objects.
#define STREAMER_OBJECT_VISIBLE_ITEMS (950)

// Larger chunks reduce per-tick overhead when the streamer must process
// thousands of pending items after a teleport or initial spawn.
#define STREAMER_OBJECT_CHUNK_SIZE (512)
#define STREAMER_GLOBAL_TICK_RATE (25)
#define STREAMER_PLAYER_TICK_RATE (15)
#define STREAMER_OBJECT_CHUNK_TICK_RATE (15)
#define STREAMER_CELL_SIZE (800.0)
#define STREAMER_CELL_DISTANCE (1500.0)
#define STREAMER_OBJECT_RADIUS_MULTIPLIER (1.5)

stock Streamer_ApplyHighLoadSettings()
{
	Streamer_SetTickRate(STREAMER_GLOBAL_TICK_RATE);
	Streamer_ToggleChunkStream(true);
	Streamer_SetChunkTickRate(STREAMER_TYPE_OBJECT, STREAMER_OBJECT_CHUNK_TICK_RATE);
	Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, STREAMER_OBJECT_VISIBLE_ITEMS);
	Streamer_SetChunkSize(STREAMER_TYPE_OBJECT, STREAMER_OBJECT_CHUNK_SIZE);
	Streamer_SetCellSize(STREAMER_CELL_SIZE);
	Streamer_SetCellDistance(STREAMER_CELL_DISTANCE);
	Streamer_SetRadiusMultiplier(STREAMER_TYPE_OBJECT, STREAMER_OBJECT_RADIUS_MULTIPLIER);
	Streamer_ProcessActiveItems();
	return 1;
}

stock Streamer_ApplyPlayerSettings(playerid)
{
	Streamer_SetPlayerTickRate(playerid, STREAMER_PLAYER_TICK_RATE);
	Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, STREAMER_OBJECT_VISIBLE_ITEMS, playerid);
	Streamer_SetRadiusMultiplier(STREAMER_TYPE_OBJECT, STREAMER_OBJECT_RADIUS_MULTIPLIER, playerid);
	Streamer_ToggleIdleUpdate(playerid, true);
	Streamer_ToggleCameraUpdate(playerid, true);
	return 1;
}

stock Streamer_QueuePlayerMapRefresh(playerid, delay = 250)
{
	if(!IsPlayerConnected(playerid))
	{
		return 0;
	}

	SetTimerEx("Streamer_DeferPlayerMapRefresh", delay, false, "i", playerid);
	return 1;
}

stock Streamer_QueueAreaRefreshes(playerid)
{
	if(!IsPlayerConnected(playerid))
	{
		return 0;
	}

	// Process the destination immediately.  One short follow-up catches the
	// final world/interior state when a teleport changes them in the same tick.
	Streamer_DeferPlayerMapRefresh(playerid);
	Streamer_QueuePlayerMapRefresh(playerid, 100);
	return 1;
}

stock Streamer_WarmupPlayerArea(playerid)
{
	if(!IsPlayerConnected(playerid))
	{
		return 0;
	}

	Streamer_ApplyPlayerSettings(playerid);
	Streamer_QueueAreaRefreshes(playerid);
	return 1;
}

stock Streamer_CancelPlayerAreaWarmup(playerid, bool:restore_control = true)
{
	if(restore_control && IsPlayerConnected(playerid))
	{
		TogglePlayerControllable(playerid, true);
	}
	return 1;
}

forward Streamer_DeferPlayerMapRefresh(playerid);
public Streamer_DeferPlayerMapRefresh(playerid)
{
	if(!IsPlayerConnected(playerid))
	{
		return 0;
	}

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	Streamer_UpdateEx(playerid, x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
	return 1;
}

#endif
