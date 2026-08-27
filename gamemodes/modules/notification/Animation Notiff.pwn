
// WroxExM GM Developer 
// Built On CodexAi


#if defined _anim_notiff_inc
    #endinput
#endif
#define _anim_notiff_inc

#if !defined _INC_open_mp
    #include <open.mp>
#endif

#if !defined _pawn_easing_functions_included
    #include <pawn-easing-functions>
#endif

#define MAX_NOTIFICATION_SLOTS            (3)
#define MAX_NOTIFICATION_QUEUE            (12)
#define MAX_NOTIFICATION_TEXT             (128)
#define MAX_NOTIFICATION_TITLE            (24)

#define NOTIFICATION_ENTER_TIME           (400)
#define NOTIFICATION_STAY_TIME            (2000)
#define NOTIFICATION_EXIT_TIME            (350)
#define NOTIFICATION_RESTACK_TIME         (200)

#define NOTIFICATION_SLOT_GAP             (36.0)
#define NOTIFICATION_HIDDEN_X_OFFSET      (170.0)

#define NOTIFICATION_DEFAULT_TITLE        "Info"
#define NOTIFICATION_DEFAULT_ICON         "i"

enum eNotificationSlotState
{
    NOTIFICATION_STATE_IDLE,
    NOTIFICATION_STATE_ENTERING,
    NOTIFICATION_STATE_SHOWING,
    NOTIFICATION_STATE_EXITING
}

enum eNotificationSlotData
{
    bool:nfCreated,
    bool:nfBusy,
    eNotificationSlotState:nfState,
    nfOrder,
    nfToken,
    nfDuration,
    nfMessage[MAX_NOTIFICATION_TEXT],
    nfTitle[MAX_NOTIFICATION_TITLE]
}

enum eNotificationQueueData
{
    nqMessage[MAX_NOTIFICATION_TEXT],
    nqDuration
}

new PlayerText:NOTIFICATIONTD[MAX_PLAYERS][MAX_NOTIFICATION_SLOTS][11];
new NotificationSlot[MAX_PLAYERS][MAX_NOTIFICATION_SLOTS][eNotificationSlotData];
new NotificationQueue[MAX_PLAYERS][MAX_NOTIFICATION_QUEUE][eNotificationQueueData];
new NotificationQueueCount[MAX_PLAYERS];

static const Float:g_NotificationBaseX[11] =
{
    75.0,   75.0,   136.0,  136.0,  3.0,    3.0,    48.0,   26.0,   27.0,   11.0,   14.0
};

static const Float:g_NotificationBaseY[11] =
{
    208.0,  204.0,  220.0,  199.0,  199.0,  220.0,  203.0,  218.0,  208.0,  209.0,  211.0
};

static stock Float:Notification_GetTargetX(componentid)
{
    return g_NotificationBaseX[componentid];
}

static stock Float:Notification_GetTargetY(componentid, order)
{
    return g_NotificationBaseY[componentid] + (float(order) * NOTIFICATION_SLOT_GAP);
}

static stock Float:Notification_GetHiddenX(componentid)
{
    return g_NotificationBaseX[componentid] - NOTIFICATION_HIDDEN_X_OFFSET;
}

static stock Notification_ResetPlayerState(playerid)
{
    NotificationQueueCount[playerid] = 0;

    for (new slot = 0; slot < MAX_NOTIFICATION_SLOTS; slot++)
    {
        NotificationSlot[playerid][slot][nfBusy] = false;
        NotificationSlot[playerid][slot][nfState] = NOTIFICATION_STATE_IDLE;
        NotificationSlot[playerid][slot][nfOrder] = -1;
        NotificationSlot[playerid][slot][nfToken] = 0;
        NotificationSlot[playerid][slot][nfDuration] = NOTIFICATION_STAY_TIME;
        NotificationSlot[playerid][slot][nfMessage][0] = '\0';
        format(NotificationSlot[playerid][slot][nfTitle], MAX_NOTIFICATION_TITLE, NOTIFICATION_DEFAULT_TITLE);
    }
    return 1;
}

static stock Notification_SetHiddenPosition(playerid, slot)
{
    for (new i = 0; i < 11; i++)
    {
        DynamicPlayerTextDrawSetPos(playerid, NOTIFICATIONTD[playerid][slot][i], Notification_GetHiddenX(i), Notification_GetTargetY(i, 0));
    }
    return 1;
}

static stock Notification_HideSlot(playerid, slot)
{
    for (new i = 0; i < 11; i++)
    {
        PlayerTextDrawHide(playerid, NOTIFICATIONTD[playerid][slot][i]);
    }
    return 1;
}

static stock Notification_ShowSlot(playerid, slot)
{
    for (new i = 0; i < 11; i++)
    {
        PlayerText_PlaceOnTop(playerid, NOTIFICATIONTD[playerid][slot][i]);
        PlayerTextDrawShow(playerid, NOTIFICATIONTD[playerid][slot][i]);
    }
    return 1;
}

static stock Notif_CreateSlotTD(playerid, slot)
{
    if (NotificationSlot[playerid][slot][nfCreated])
    {
        return 1;
    }

    NOTIFICATIONTD[playerid][slot][0] = CreatePlayerTextDraw(playerid, Notification_GetHiddenX(0), Notification_GetTargetY(0, 0), "_");
    PlayerTextDrawLetterSize(playerid, NOTIFICATIONTD[playerid][slot][0], 0.409, 1.998);
    PlayerTextDrawTextSize(playerid, NOTIFICATIONTD[playerid][slot][0], 5.000, -145.000);
    PlayerTextDrawAlignment(playerid, NOTIFICATIONTD[playerid][slot][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, NOTIFICATIONTD[playerid][slot][0], -1);
    PlayerTextDrawUseBox(playerid, NOTIFICATIONTD[playerid][slot][0], true);
    PlayerTextDrawBoxColour(playerid, NOTIFICATIONTD[playerid][slot][0], 471607039);
    PlayerTextDrawSetShadow(playerid, NOTIFICATIONTD[playerid][slot][0], 1);
    PlayerTextDrawSetOutline(playerid, NOTIFICATIONTD[playerid][slot][0], 1);
    PlayerTextDrawBackgroundColour(playerid, NOTIFICATIONTD[playerid][slot][0], 150);
    PlayerTextDrawFont(playerid, NOTIFICATIONTD[playerid][slot][0], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, NOTIFICATIONTD[playerid][slot][0], true);

    NOTIFICATIONTD[playerid][slot][1] = CreatePlayerTextDraw(playerid, Notification_GetHiddenX(1), Notification_GetTargetY(1, 0), "_");
    PlayerTextDrawLetterSize(playerid, NOTIFICATIONTD[playerid][slot][1], 0.409, 3.098);
    PlayerTextDrawTextSize(playerid, NOTIFICATIONTD[playerid][slot][1], -2.000, -135.000);
    PlayerTextDrawAlignment(playerid, NOTIFICATIONTD[playerid][slot][1], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, NOTIFICATIONTD[playerid][slot][1], -1);
    PlayerTextDrawUseBox(playerid, NOTIFICATIONTD[playerid][slot][1], true);
    PlayerTextDrawBoxColour(playerid, NOTIFICATIONTD[playerid][slot][1], 471607039);
    PlayerTextDrawSetShadow(playerid, NOTIFICATIONTD[playerid][slot][1], 1);
    PlayerTextDrawSetOutline(playerid, NOTIFICATIONTD[playerid][slot][1], 1);
    PlayerTextDrawBackgroundColour(playerid, NOTIFICATIONTD[playerid][slot][1], 150);
    PlayerTextDrawFont(playerid, NOTIFICATIONTD[playerid][slot][1], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, NOTIFICATIONTD[playerid][slot][1], true);

    NOTIFICATIONTD[playerid][slot][2] = CreatePlayerTextDraw(playerid, Notification_GetHiddenX(2), Notification_GetTargetY(2, 0), "LD_BEAT:chit");
    PlayerTextDrawTextSize(playerid, NOTIFICATIONTD[playerid][slot][2], 11.000, 17.000);
    PlayerTextDrawAlignment(playerid, NOTIFICATIONTD[playerid][slot][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, NOTIFICATIONTD[playerid][slot][2], 471607039);
    PlayerTextDrawSetShadow(playerid, NOTIFICATIONTD[playerid][slot][2], 0);
    PlayerTextDrawSetOutline(playerid, NOTIFICATIONTD[playerid][slot][2], 0);
    PlayerTextDrawBackgroundColour(playerid, NOTIFICATIONTD[playerid][slot][2], 255);
    PlayerTextDrawFont(playerid, NOTIFICATIONTD[playerid][slot][2], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, NOTIFICATIONTD[playerid][slot][2], true);

    NOTIFICATIONTD[playerid][slot][3] = CreatePlayerTextDraw(playerid, Notification_GetHiddenX(3), Notification_GetTargetY(3, 0), "LD_BEAT:chit");
    PlayerTextDrawTextSize(playerid, NOTIFICATIONTD[playerid][slot][3], 11.000, 17.000);
    PlayerTextDrawAlignment(playerid, NOTIFICATIONTD[playerid][slot][3], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, NOTIFICATIONTD[playerid][slot][3], 471607039);
    PlayerTextDrawSetShadow(playerid, NOTIFICATIONTD[playerid][slot][3], 0);
    PlayerTextDrawSetOutline(playerid, NOTIFICATIONTD[playerid][slot][3], 0);
    PlayerTextDrawBackgroundColour(playerid, NOTIFICATIONTD[playerid][slot][3], 255);
    PlayerTextDrawFont(playerid, NOTIFICATIONTD[playerid][slot][3], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, NOTIFICATIONTD[playerid][slot][3], true);

    NOTIFICATIONTD[playerid][slot][4] = CreatePlayerTextDraw(playerid, Notification_GetHiddenX(4), Notification_GetTargetY(4, 0), "LD_BEAT:chit");
    PlayerTextDrawTextSize(playerid, NOTIFICATIONTD[playerid][slot][4], 11.000, 17.000);
    PlayerTextDrawAlignment(playerid, NOTIFICATIONTD[playerid][slot][4], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, NOTIFICATIONTD[playerid][slot][4], 471607039);
    PlayerTextDrawSetShadow(playerid, NOTIFICATIONTD[playerid][slot][4], 0);
    PlayerTextDrawSetOutline(playerid, NOTIFICATIONTD[playerid][slot][4], 0);
    PlayerTextDrawBackgroundColour(playerid, NOTIFICATIONTD[playerid][slot][4], 255);
    PlayerTextDrawFont(playerid, NOTIFICATIONTD[playerid][slot][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, NOTIFICATIONTD[playerid][slot][4], true);

    NOTIFICATIONTD[playerid][slot][5] = CreatePlayerTextDraw(playerid, Notification_GetHiddenX(5), Notification_GetTargetY(5, 0), "LD_BEAT:chit");
    PlayerTextDrawTextSize(playerid, NOTIFICATIONTD[playerid][slot][5], 11.000, 17.000);
    PlayerTextDrawAlignment(playerid, NOTIFICATIONTD[playerid][slot][5], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, NOTIFICATIONTD[playerid][slot][5], 471607039);
    PlayerTextDrawSetShadow(playerid, NOTIFICATIONTD[playerid][slot][5], 0);
    PlayerTextDrawSetOutline(playerid, NOTIFICATIONTD[playerid][slot][5], 0);
    PlayerTextDrawBackgroundColour(playerid, NOTIFICATIONTD[playerid][slot][5], 255);
    PlayerTextDrawFont(playerid, NOTIFICATIONTD[playerid][slot][5], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, NOTIFICATIONTD[playerid][slot][5], true);

    NOTIFICATIONTD[playerid][slot][6] = CreatePlayerTextDraw(playerid, Notification_GetHiddenX(6), Notification_GetTargetY(6, 0), "_");
    PlayerTextDrawLetterSize(playerid, NOTIFICATIONTD[playerid][slot][6], 2.608, -0.400);
    PlayerTextDrawTextSize(playerid, NOTIFICATIONTD[playerid][slot][6], 102.000, 77.000);
    PlayerTextDrawAlignment(playerid, NOTIFICATIONTD[playerid][slot][6], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, NOTIFICATIONTD[playerid][slot][6], -1);
    PlayerTextDrawUseBox(playerid, NOTIFICATIONTD[playerid][slot][6], true);
    PlayerTextDrawBoxColour(playerid, NOTIFICATIONTD[playerid][slot][6], 1434569983);
    PlayerTextDrawSetShadow(playerid, NOTIFICATIONTD[playerid][slot][6], 1);
    PlayerTextDrawSetOutline(playerid, NOTIFICATIONTD[playerid][slot][6], 1);
    PlayerTextDrawBackgroundColour(playerid, NOTIFICATIONTD[playerid][slot][6], 150);
    PlayerTextDrawFont(playerid, NOTIFICATIONTD[playerid][slot][6], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, NOTIFICATIONTD[playerid][slot][6], true);

    NOTIFICATIONTD[playerid][slot][7] = CreatePlayerTextDraw(playerid, Notification_GetHiddenX(7), Notification_GetTargetY(7, 0), "Notification");
    PlayerTextDrawLetterSize(playerid, NOTIFICATIONTD[playerid][slot][7], 0.127, 0.597);
    PlayerTextDrawAlignment(playerid, NOTIFICATIONTD[playerid][slot][7], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, NOTIFICATIONTD[playerid][slot][7], 1768516095);
    PlayerTextDrawSetShadow(playerid, NOTIFICATIONTD[playerid][slot][7], 1);
    PlayerTextDrawSetOutline(playerid, NOTIFICATIONTD[playerid][slot][7], 1);
    PlayerTextDrawBackgroundColour(playerid, NOTIFICATIONTD[playerid][slot][7], 0);
    PlayerTextDrawFont(playerid, NOTIFICATIONTD[playerid][slot][7], TEXT_DRAW_FONT_2);
    PlayerTextDrawSetProportional(playerid, NOTIFICATIONTD[playerid][slot][7], true);

    NOTIFICATIONTD[playerid][slot][8] = CreatePlayerTextDraw(playerid, Notification_GetHiddenX(8), Notification_GetTargetY(8, 0), NOTIFICATION_DEFAULT_TITLE);
    PlayerTextDrawLetterSize(playerid, NOTIFICATIONTD[playerid][slot][8], 0.270, 0.796);
    PlayerTextDrawAlignment(playerid, NOTIFICATIONTD[playerid][slot][8], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, NOTIFICATIONTD[playerid][slot][8], -1);
    PlayerTextDrawSetShadow(playerid, NOTIFICATIONTD[playerid][slot][8], 1);
    PlayerTextDrawSetOutline(playerid, NOTIFICATIONTD[playerid][slot][8], 1);
    PlayerTextDrawBackgroundColour(playerid, NOTIFICATIONTD[playerid][slot][8], 0);
    PlayerTextDrawFont(playerid, NOTIFICATIONTD[playerid][slot][8], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, NOTIFICATIONTD[playerid][slot][8], true);

    NOTIFICATIONTD[playerid][slot][9] = CreatePlayerTextDraw(playerid, Notification_GetHiddenX(9), Notification_GetTargetY(9, 0), "LD_BEAT:chit");
    PlayerTextDrawTextSize(playerid, NOTIFICATIONTD[playerid][slot][9], 10.000, 13.000);
    PlayerTextDrawAlignment(playerid, NOTIFICATIONTD[playerid][slot][9], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, NOTIFICATIONTD[playerid][slot][9], 1434569983);
    PlayerTextDrawSetShadow(playerid, NOTIFICATIONTD[playerid][slot][9], 0);
    PlayerTextDrawSetOutline(playerid, NOTIFICATIONTD[playerid][slot][9], 0);
    PlayerTextDrawBackgroundColour(playerid, NOTIFICATIONTD[playerid][slot][9], 255);
    PlayerTextDrawFont(playerid, NOTIFICATIONTD[playerid][slot][9], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, NOTIFICATIONTD[playerid][slot][9], true);

    NOTIFICATIONTD[playerid][slot][10] = CreatePlayerTextDraw(playerid, Notification_GetHiddenX(10), Notification_GetTargetY(10, 0), NOTIFICATION_DEFAULT_ICON);
    PlayerTextDrawLetterSize(playerid, NOTIFICATIONTD[playerid][slot][10], 0.310, 0.898);
    PlayerTextDrawAlignment(playerid, NOTIFICATIONTD[playerid][slot][10], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, NOTIFICATIONTD[playerid][slot][10], 255);
    PlayerTextDrawSetShadow(playerid, NOTIFICATIONTD[playerid][slot][10], 1);
    PlayerTextDrawSetOutline(playerid, NOTIFICATIONTD[playerid][slot][10], 1);
    PlayerTextDrawBackgroundColour(playerid, NOTIFICATIONTD[playerid][slot][10], 0);
    PlayerTextDrawFont(playerid, NOTIFICATIONTD[playerid][slot][10], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, NOTIFICATIONTD[playerid][slot][10], true);

    NotificationSlot[playerid][slot][nfCreated] = true;
    Notification_SetHiddenPosition(playerid, slot);
    Notification_HideSlot(playerid, slot);
    return 1;
}

stock InitAnimationNotifications(playerid)
{
    Notification_ResetPlayerState(playerid);

    for (new slot = 0; slot < MAX_NOTIFICATION_SLOTS; slot++)
    {
        Notif_CreateSlotTD(playerid, slot);
    }
    return 1;
}

stock DestroyAnimationNotifications(playerid)
{
    Notification_ResetPlayerState(playerid);

    for (new slot = 0; slot < MAX_NOTIFICATION_SLOTS; slot++)
    {
        if (!NotificationSlot[playerid][slot][nfCreated])
        {
            continue;
        }

        for (new i = 0; i < 11; i++)
        {
            if (NOTIFICATIONTD[playerid][slot][i] != PlayerText:INVALID_TEXT_DRAW)
            {
                PlayerTextDrawDestroy(playerid, NOTIFICATIONTD[playerid][slot][i]);
                NOTIFICATIONTD[playerid][slot][i] = PlayerText:INVALID_TEXT_DRAW;
            }
        }
        NotificationSlot[playerid][slot][nfCreated] = false;
    }
    return 1;
}

static stock Notification_GetActiveCount(playerid)
{
    new count;
    for (new slot = 0; slot < MAX_NOTIFICATION_SLOTS; slot++)
    {
        if (NotificationSlot[playerid][slot][nfBusy])
        {
            count++;
        }
    }
    return count;
}

static stock Notification_FindFreeSlot(playerid)
{
    for (new slot = 0; slot < MAX_NOTIFICATION_SLOTS; slot++)
    {
        if (!NotificationSlot[playerid][slot][nfBusy])
        {
            return slot;
        }
    }
    return -1;
}

static stock Notification_QueuePush(playerid, const text[], duration)
{
    if (NotificationQueueCount[playerid] >= MAX_NOTIFICATION_QUEUE)
    {
        return 0;
    }

    format(NotificationQueue[playerid][NotificationQueueCount[playerid]][nqMessage], MAX_NOTIFICATION_TEXT, "%s", text);
    NotificationQueue[playerid][NotificationQueueCount[playerid]][nqDuration] = duration;
    NotificationQueueCount[playerid]++;
    return 1;
}

static stock Notification_QueueShift(playerid)
{
    if (NotificationQueueCount[playerid] <= 0)
    {
        return 0;
    }

    for (new i = 1; i < NotificationQueueCount[playerid]; i++)
    {
        format(NotificationQueue[playerid][i - 1][nqMessage], MAX_NOTIFICATION_TEXT, "%s", NotificationQueue[playerid][i][nqMessage]);
        NotificationQueue[playerid][i - 1][nqDuration] = NotificationQueue[playerid][i][nqDuration];
    }

    NotificationQueueCount[playerid]--;
    NotificationQueue[playerid][NotificationQueueCount[playerid]][nqMessage][0] = '\0';
    NotificationQueue[playerid][NotificationQueueCount[playerid]][nqDuration] = 0;
    return 1;
}

static stock Notif_MoveSlotOrder(playerid, slot, order, duration, ease)
{
    for (new i = 0; i < 11; i++)
    {
        PlayerText_MoveTo(playerid, NOTIFICATIONTD[playerid][slot][i], Notification_GetTargetX(i), Notification_GetTargetY(i, order), duration, ease);
    }
    NotificationSlot[playerid][slot][nfOrder] = order;
    return 1;
}

static stock Notification_Reflow(playerid)
{
    new order;

    for (new wanted = 0; wanted < MAX_NOTIFICATION_SLOTS; wanted++)
    {
        for (new slot = 0; slot < MAX_NOTIFICATION_SLOTS; slot++)
        {
            if (!NotificationSlot[playerid][slot][nfBusy] || NotificationSlot[playerid][slot][nfState] == NOTIFICATION_STATE_EXITING)
            {
                continue;
            }

            if (NotificationSlot[playerid][slot][nfOrder] == wanted)
            {
                Notif_MoveSlotOrder(playerid, slot, order++, NOTIFICATION_RESTACK_TIME, EASE_OUT_QUART);
                break;
            }
        }
    }

    for (new slot = 0; slot < MAX_NOTIFICATION_SLOTS; slot++)
    {
        if (NotificationSlot[playerid][slot][nfBusy] && NotificationSlot[playerid][slot][nfState] != NOTIFICATION_STATE_EXITING && NotificationSlot[playerid][slot][nfOrder] >= order)
        {
            Notif_MoveSlotOrder(playerid, slot, order++, NOTIFICATION_RESTACK_TIME, EASE_OUT_QUART);
        }
    }
    return 1;
}

forward Notification_BeginExit(playerid, slot, token);
forward Notification_Finalize(playerid, slot, token);

static stock Notification_ProcessQueue(playerid)
{
    while (NotificationQueueCount[playerid] > 0)
    {
        new slot = Notification_FindFreeSlot(playerid);
        if (slot == -1)
        {
            break;
        }

        CreateNotification(playerid, NotificationQueue[playerid][0][nqMessage], NotificationQueue[playerid][0][nqDuration]);
        Notification_QueueShift(playerid);
    }
    return 1;
}

static stock Notification_FillSlot(playerid, slot, const text[], duration)
{
    new order = Notification_GetActiveCount(playerid);
    new token = ++NotificationSlot[playerid][slot][nfToken];

    NotificationSlot[playerid][slot][nfBusy] = true;
    NotificationSlot[playerid][slot][nfState] = NOTIFICATION_STATE_ENTERING;
    NotificationSlot[playerid][slot][nfOrder] = order;
    NotificationSlot[playerid][slot][nfDuration] = duration;
    format(NotificationSlot[playerid][slot][nfMessage], MAX_NOTIFICATION_TEXT, "%s", text);
    format(NotificationSlot[playerid][slot][nfTitle], MAX_NOTIFICATION_TITLE, NOTIFICATION_DEFAULT_TITLE);

    DynamicPlayerTextDrawSetString(playerid, NOTIFICATIONTD[playerid][slot][7], NotificationSlot[playerid][slot][nfMessage]);
    DynamicPlayerTextDrawSetString(playerid, NOTIFICATIONTD[playerid][slot][8], NotificationSlot[playerid][slot][nfTitle]);
    DynamicPlayerTextDrawSetString(playerid, NOTIFICATIONTD[playerid][slot][10], NOTIFICATION_DEFAULT_ICON);

    Notification_SetHiddenPosition(playerid, slot);
    Notification_ShowSlot(playerid, slot);
    Notif_MoveSlotOrder(playerid, slot, order, NOTIFICATION_ENTER_TIME, EASE_OUT_QUART);

    NotificationSlot[playerid][slot][nfState] = NOTIFICATION_STATE_SHOWING;
    SetTimerEx("Notification_BeginExit", duration + NOTIFICATION_ENTER_TIME, false, "ddd", playerid, slot, token);
    return 1;
}

stock CreateNotification(playerid, const text[], duration = NOTIFICATION_STAY_TIME)
{
    if (!IsPlayerConnected(playerid) || !text[0])
    {
        return 0;
    }

    if (duration < 250)
    {
        duration = NOTIFICATION_STAY_TIME;
    }

    for (new slot = 0; slot < MAX_NOTIFICATION_SLOTS; slot++)
    {
        if (!NotificationSlot[playerid][slot][nfCreated])
        {
            Notif_CreateSlotTD(playerid, slot);
        }
    }

    new slot = Notification_FindFreeSlot(playerid);
    if (slot == -1)
    {
        return Notification_QueuePush(playerid, text, duration);
    }

    return Notification_FillSlot(playerid, slot, text, duration);
}

public Notification_BeginExit(playerid, slot, token)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    if (slot < 0 || slot >= MAX_NOTIFICATION_SLOTS)
    {
        return 1;
    }

    if (!NotificationSlot[playerid][slot][nfBusy] || NotificationSlot[playerid][slot][nfToken] != token)
    {
        return 1;
    }

    NotificationSlot[playerid][slot][nfState] = NOTIFICATION_STATE_EXITING;

    for (new i = 0; i < 11; i++)
    {
        PlayerText_MoveTo(playerid, NOTIFICATIONTD[playerid][slot][i], Notification_GetHiddenX(i), Notification_GetTargetY(i, NotificationSlot[playerid][slot][nfOrder]), NOTIFICATION_EXIT_TIME, EASE_IN_QUART);
    }

    SetTimerEx("Notification_Finalize", NOTIFICATION_EXIT_TIME + 30, false, "ddd", playerid, slot, token);
    return 1;
}

public Notification_Finalize(playerid, slot, token)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    if (slot < 0 || slot >= MAX_NOTIFICATION_SLOTS)
    {
        return 1;
    }

    if (!NotificationSlot[playerid][slot][nfBusy] || NotificationSlot[playerid][slot][nfToken] != token)
    {
        return 1;
    }

    new removed_order = NotificationSlot[playerid][slot][nfOrder];

    Notification_HideSlot(playerid, slot);
    Notification_SetHiddenPosition(playerid, slot);

    NotificationSlot[playerid][slot][nfBusy] = false;
    NotificationSlot[playerid][slot][nfState] = NOTIFICATION_STATE_IDLE;
    NotificationSlot[playerid][slot][nfOrder] = -1;
    NotificationSlot[playerid][slot][nfMessage][0] = '\0';

    for (new other = 0; other < MAX_NOTIFICATION_SLOTS; other++)
    {
        if (!NotificationSlot[playerid][other][nfBusy] || NotificationSlot[playerid][other][nfState] == NOTIFICATION_STATE_EXITING)
        {
            continue;
        }

        if (NotificationSlot[playerid][other][nfOrder] > removed_order)
        {
            Notif_MoveSlotOrder(playerid, other, NotificationSlot[playerid][other][nfOrder] - 1, NOTIFICATION_RESTACK_TIME, EASE_OUT_QUART);
        }
    }

    Notification_ProcessQueue(playerid);
    return 1;
}

stock ClearNotifications(playerid)
{
    NotificationQueueCount[playerid] = 0;

    for (new slot = 0; slot < MAX_NOTIFICATION_SLOTS; slot++)
    {
        NotificationSlot[playerid][slot][nfToken]++;
        NotificationSlot[playerid][slot][nfBusy] = false;
        NotificationSlot[playerid][slot][nfState] = NOTIFICATION_STATE_IDLE;
        NotificationSlot[playerid][slot][nfOrder] = -1;
        NotificationSlot[playerid][slot][nfMessage][0] = '\0';

        if (NotificationSlot[playerid][slot][nfCreated])
        {
            Notification_HideSlot(playerid, slot);
            Notification_SetHiddenPosition(playerid, slot);
        }
    }
    return 1;
}

stock HideNotificationSlot(playerid, slot)
{
    if (slot < 0 || slot >= MAX_NOTIFICATION_SLOTS)
    {
        return 0;
    }

    NotificationSlot[playerid][slot][nfToken]++;
    NotificationSlot[playerid][slot][nfBusy] = false;
    NotificationSlot[playerid][slot][nfState] = NOTIFICATION_STATE_IDLE;
    NotificationSlot[playerid][slot][nfOrder] = -1;
    NotificationSlot[playerid][slot][nfMessage][0] = '\0';

    Notification_HideSlot(playerid, slot);
    Notification_SetHiddenPosition(playerid, slot);
    Notification_Reflow(playerid);
    Notification_ProcessQueue(playerid);
    return 1;
}

#if defined AnimNotiff_OnPConn
    forward AnimNotiff_OnPConn(playerid);
#endif

public OnPlayerConnect(playerid)
{
    InitAnimationNotifications(playerid);

    #if defined AnimNotiff_OnPConn
        return AnimNotiff_OnPConn(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect AnimNotiff_OnPConn

#if defined AnimNotiff_OnPDisc
    forward AnimNotiff_OnPDisc(playerid, reason);
#endif

public OnPlayerDisconnect(playerid, reason)
{
    #pragma unused reason

    ClearNotifications(playerid);
    DestroyAnimationNotifications(playerid);

    #if defined AnimNotiff_OnPDisc
        return AnimNotiff_OnPDisc(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect AnimNotiff_OnPDisc
