//-----------------------------[ DISCORD CONNECTOR ]----------------------------

#define cmds             "1500743186618781838"
#define white            "1500418305650065483"
#define Serverip         "1500743186618781838"
#define serverupdate     "1500743186618781838"
#define announcement     "1500743186618781838"

// Resolve the requested channel from its exact ID for every message. This
// follows the stable old connector format and avoids stale cached handles.
stock SendDiscordMessage(channel, const message[])
{
	new DCC_Channel:ChannelId;

	switch(channel)
	{
		case 0:  ChannelId = DCC_FindChannelById("1500743187428409467"); // log-admin
		case 1:  ChannelId = DCC_FindChannelById("1375346740546240585"); // log-ban
		case 2:  ChannelId = DCC_FindChannelById("1500743187726073960"); // log-cheat
		case 3:  ChannelId = DCC_FindChannelById("1500743188095303680"); // log-faction
		case 4:  ChannelId = DCC_FindChannelById("1500743187428409474"); // log-namechanges
		case 5:  ChannelId = DCC_FindChannelById("1500743187428409474"); // log-namehistory
		case 6:  ChannelId = DCC_FindChannelById("1503802969336975470"); // log-punishment
		case 7:  ChannelId = DCC_FindChannelById("1500743187428409472"); // log-vip
		case 8:  ChannelId = DCC_FindChannelById("1500743187063509163"); // log-knockdown
		case 9:  ChannelId = DCC_FindChannelById("1500743186618781843"); // log-adminchat
		case 10: ChannelId = DCC_FindChannelById("1500743186618781844"); // log-helper
		case 11: ChannelId = DCC_FindChannelById("1503803422107766874"); // log-whisper
		case 12: ChannelId = DCC_FindChannelById("1503803621072965672"); // log-sellcar
		case 13: ChannelId = DCC_FindChannelById("1525384615269896253"); // log-gangchat
		case 14: ChannelId = DCC_FindChannelById("1525385190422085662"); // log-command
		case 15: ChannelId = DCC_FindChannelById("1525387801506615417"); // log-damage
		case 16: ChannelId = DCC_FindChannelById("1500743188346835065"); // log-chat
		case 17: ChannelId = DCC_FindChannelById("1500743186275106864"); // log-join-exit
		case 18: ChannelId = DCC_FindChannelById("1500743187063509170"); // log-kos
		case 19: ChannelId = DCC_FindChannelById("1503804610849018017"); // log-pm-message
		case 20: ChannelId = DCC_FindChannelById("1500743188095303689"); // log-facebookchat
		case 21: ChannelId = DCC_FindChannelById("1503804930765357208"); // log-globalchat
		case 22: ChannelId = DCC_FindChannelById("1500743188095303683"); // log-factionchat
		case 23: ChannelId = DCC_FindChannelById("1500743188346835066"); // log-instachat
		case 24: ChannelId = DCC_FindChannelById("1503805099212935229"); // log-twitterchat
		case 25: ChannelId = DCC_FindChannelById("1500743187726073960"); // log-aimbot/anticheat
		case 26: ChannelId = DCC_FindChannelById("1503803621072965672"); // log-carsale
		case 27: ChannelId = DCC_FindChannelById("1500743187428409469"); // log-business
		case 28: ChannelId = DCC_FindChannelById("1500743187428409469"); // log-business-alt
		case 29: ChannelId = DCC_FindChannelById("1500743187428409471"); // log-vehicle
		case 30: ChannelId = DCC_FindChannelById("1525386979418575018"); // log-doors-gates
		case 31: ChannelId = DCC_FindChannelById("1525387244268159016"); // log-dynamic-systems
		case 32: ChannelId = DCC_FindChannelById("1525388207041282048"); // log-player-data
		case 33: ChannelId = DCC_FindChannelById("1500743187961221121"); // log-economy
		case 34: ChannelId = DCC_FindChannelById("1500743187428409465"); // log-dialogs
		case 35: ChannelId = DCC_FindChannelById("1500743187428409469"); // log-shop-buying
		case 36: ChannelId = DCC_FindChannelById("1525388743907737751"); // log-system
		case 37: ChannelId = DCC_FindChannelById("1500743188346835073"); // log-turf-entry-exit
		case 38: ChannelId = DCC_FindChannelById("1500743188833505300"); // log-turf-kills
		case 39: ChannelId = DCC_FindChannelById("1525389049731354704"); // log-turf-reentry
		default: return 0;
	}

	if(ChannelId == DCC_Channel:0)
	{
		printf("[Discord] Invalid channel handle for log case %d.", channel);
		return 0;
	}

	return DCC_SendChannelMessage(ChannelId, message);
}

new DCC_Channel:whitelist_log;
new DCC_Channel:announce_log;
new DCC_Channel:admin_log;
new DCC_Channel:g_DiscordConnectLog;

stock DiscordRefreshChannels()
{
	whitelist_log = DCC_FindChannelById(white);
	announce_log = DCC_FindChannelById(announcement);
	admin_log = DCC_FindChannelById(cmds);
	g_DiscordConnectLog = DCC_FindChannelById("1500743186275106864");
	return 1;
}

forward DiscordConnectionWatchdog();
public DiscordConnectionWatchdog()
{
	DiscordRefreshChannels();
	return 1;
}

stock DiscordStartReliabilityMonitor()
{
	DiscordRefreshChannels();
	SetTimer("DiscordConnectionWatchdog", 15000, true);
	return 1;
}
