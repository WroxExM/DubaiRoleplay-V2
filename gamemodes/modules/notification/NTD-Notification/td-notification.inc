/*
    td-notification - Version 1.0

    Modes of use:
    MAX_TDN: set how many TextDraw will be shown in TextDraw's Notification
    TDN_POS_X: TextDraw notifications will be at the position set on the X axis
    TDN_POS_Y: TextDraw notifications will be at the position set on the Y axis
    TDN_FONT: TextDraw Notification will have the set font
    TDN_LETTER_SIZE_X: TextDraw notifications will have the set font size on the X axis
    TDN_LETTER_SIZE_Y: TextDraw notifications will have the set font size on the Y axis
    TDN_SIZE: TextDraw notifications will have the set width size
    TDN_COLOR: TextDraw notifications will have the set font color
    TDN_COLOR_BOX: TextDraw notifications will have the set box color
    TDN_PROPORTIONAL: TextDraw notifications will have the set proportional
    TDN_DISTANCE: TextDraw notifications will have the set distance
    MAX_TDN_TEXT: TextDraw notifications will have a maximum the set text
    TDN_MODE_DOWN: TextDraw notifications will scroll down
    TDN_MODE_UP: TextDraw notifications will scroll up
    TDN_TIME: TextDraw notifications will hide at the set time

    TDN_MODE_DEFAULT: TextDraw notifications will use the default settings

    Created by ThePez - NaS
*/
 
#if defined include_td_notification
    #endinput
#endif
#define include_td_notification
 
#if !defined TDN_MODE_DEFAULT
    #if !defined MAX_TDN
        #error "MAX_TDN is not defined"
    #endif
 
    #if !defined TDN_POS_X
        #error "TDN_POS_X is not defined"
    #endif
 
    #if !defined TDN_POS_Y
        #error "TDN_POS_Y is not defined"
    #endif
 
    #if !defined TDN_FONT
        #error "TDN_FONT is not defined"
    #endif
 
    #if !defined TDN_LETTER_SIZE_X
        #error "TDN_LETTER_SIZE_X is not defined"
    #endif
 
    #if !defined TDN_LETTER_SIZE_Y
        #error "TDN_LETTER_SIZE_Y is not defined"
    #endif
 
    #if !defined TDN_SIZE
        #error "TDN_SIZE is not defined"
    #endif
 
    #if !defined TDN_COLOR
        #error "TDN_COLOR is not defined"
    #endif
 
    #if !defined TDN_COLOR_BOX
        #error "TDN_COLOR_BOX is not defined"
    #endif
 
    #if !defined TDN_PROPORTIONAL
        #error "TDN_PROPORTIONAL is not defined"
    #endif
 
    #if !defined TDN_DISTANCE
        #error "TDN_DISTANCE is not defined"
    #endif
 
    #if !defined TDN_MODE_DOWN && !defined TDN_MODE_UP
        #error "TDN_MODE is not defined"
    #elseif defined TDN_MODE_DOWN && defined TDN_MODE_UP
        #error "TDN_MODE_DOWN and TDN_MODE_UP is defined"
    #endif
 
    #if !defined TDN_TIME
        #error "TDN_TIME is not defined"
    #endif
 
    #if !defined MAX_TDN_TEXT
        #error "MAX_TDN_TEXT is not defined"
    #endif
#else
    #define MAX_TDN 3
    #define TDN_POS_X 497.000000
    #define TDN_POS_Y 130.000000
    #define TDN_FONT 1
    #define TDN_LETTER_SIZE_X 0.250000
    #define TDN_LETTER_SIZE_Y 1.000000
    #define TDN_SIZE 112.000000
    #define TDN_COLOR 0xFFFFFFFF
    #define TDN_COLOR_BOX 0x000000FF
    #define TDN_PROPORTIONAL 1
    #define TDN_DISTANCE 5
    #define TDN_MODE_DOWN
    // Each automatic notification remains visible for five seconds.
    #define TDN_TIME 5000
    #define MAX_TDN_TEXT 800
#endif

#include <td-string-width>
 
enum InformationTDN
{
    Use,
    Line,
    Text[MAX_TDN_TEXT],
    PlayerText:TextDraw,
    Float:MinPosY,
    Float:MaxPosY,
    Hide
}
new TextDrawsNotification[MAX_PLAYERS][MAX_TDN][InformationTDN],
    counter[MAX_PLAYERS];

forward TimerHideTDN(playerid);
public TimerHideTDN(playerid)
{
    for(new cycle; cycle < MAX_TDN; cycle++)
    {
        if(TextDrawsNotification[playerid][cycle][Hide] == -1)
        {
            TextDrawsNotification[playerid][cycle][Use] = 0;
            if(TextDrawsNotification[playerid][cycle][TextDraw] != PlayerText:-1)
            {
                PlayerTextDrawDestroy(playerid, TextDrawsNotification[playerid][cycle][TextDraw]);
                TextDrawsNotification[playerid][cycle][Line] = 0;
                TextDrawsNotification[playerid][cycle][Text][0] = EOS;
                TextDrawsNotification[playerid][cycle][MinPosY] = 0;
                TextDrawsNotification[playerid][cycle][MaxPosY] = 0;
                TextDrawsNotification[playerid][cycle][TextDraw] = PlayerText:-1;
            }
            TextDrawsNotification[playerid][cycle][Hide] = -1;
            UpdateTDN(playerid);

            return 1;
        }
    }
    return 0;
}

forward ShowTDN(playerid, const reason[]); 
public ShowTDN(playerid, const reason[])
{
    for(new cycle; cycle < MAX_TDN; cycle++)
    {
        if(!TextDrawsNotification[playerid][cycle][Use])
        {
            TextDrawsNotification[playerid][cycle][Text][0] = EOS;

            new text[MAX_TDN_TEXT];

            for(new len = strlen(reason), pos; pos < len; pos ++)
            {
                switch(reason[pos])
                {
                    case 'à': text[pos] = 151;
                    case 'á': text[pos] = 152;
                    case 'â': text[pos] = 153;
                    case 'ä': text[pos] = 154;
                    case 'À': text[pos] = 128;
                    case 'Á': text[pos] = 129;
                    case 'Â': text[pos] = 130;
                    case 'Ä': text[pos] = 131;
                    case 'è': text[pos] = 157;
                    case 'é': text[pos] = 158;
                    case 'ê': text[pos] = 159;
                    case 'ë': text[pos] = 160;
                    case 'È': text[pos] = 134;
                    case 'É': text[pos] = 135;
                    case 'Ê': text[pos] = 136;
                    case 'Ë': text[pos] = 137;
                    case 'ì': text[pos] = 161;
                    case 'í': text[pos] = 162;
                    case 'î': text[pos] = 163;
                    case 'ï': text[pos] = 164;
                    case 'Ì': text[pos] = 138;
                    case 'Í': text[pos] = 139;
                    case 'Î': text[pos] = 140;
                    case 'Ï': text[pos] = 141;
                    case 'ò': text[pos] = 165;
                    case 'ó': text[pos] = 166;
                    case 'ô': text[pos] = 167;
                    case 'ö': text[pos] = 168;
                    case 'Ò': text[pos] = 142;
                    case 'Ó': text[pos] = 143;
                    case 'Ô': text[pos] = 144;
                    case 'Ö': text[pos] = 145;
                    case 'ù': text[pos] = 169;
                    case 'ú': text[pos] = 170;
                    case 'û': text[pos] = 171;
                    case 'ü': text[pos] = 172;
                    case 'Ù': text[pos] = 146;
                    case 'Ú': text[pos] = 147;
                    case 'Û': text[pos] = 148;
                    case 'Ü': text[pos] = 149;
                    case 'ñ': text[pos] = 174;
                    case 'Ñ': text[pos] = 173;
                    case '¡': text[pos] = 64;
                    case '¿': text[pos] = 175;
                    case '`': text[pos] = 177;
                    case '&': text[pos] = 38;
                    default:  text[pos] = reason[pos];
                }
            }
            
            strcat(TextDrawsNotification[playerid][cycle][Text], text, MAX_TDN_TEXT);
 
            TextDrawsNotification[playerid][cycle][Use] = 1;
 
            LinesTDN(playerid, cycle);

            #if defined TDN_MODE_DOWN

            MinPosYTDN(playerid, cycle);
            MaxPosYTDN(playerid, cycle);

            #endif

            #if defined TDN_MODE_UP

            MaxPosYTDN(playerid, cycle);
            MinPosYTDN(playerid, cycle);
            
            #endif

            TextDrawsNotification[playerid][cycle][Hide] = -1;

            CreateTDN(playerid, cycle);

            SetTimerEx("TimerHideTDN", TDN_TIME, false, "i", playerid);

            return 1;
        }
    }
    return -1;
}

forward ShowTDN_Manual(playerid, const reason[]); 
public ShowTDN_Manual(playerid, const reason[])
{
    for(new cycle; cycle < MAX_TDN; cycle++)
    {
        if(!TextDrawsNotification[playerid][cycle][Use])
        {
            TextDrawsNotification[playerid][cycle][Text][0] = EOS;

            new text[MAX_TDN_TEXT];

            for(new len = strlen(reason), pos; pos < len; pos ++)
            {
                switch(reason[pos])
                {
                    case 'à': text[pos] = 151;
                    case 'á': text[pos] = 152;
                    case 'â': text[pos] = 153;
                    case 'ä': text[pos] = 154;
                    case 'À': text[pos] = 128;
                    case 'Á': text[pos] = 129;
                    case 'Â': text[pos] = 130;
                    case 'Ä': text[pos] = 131;
                    case 'è': text[pos] = 157;
                    case 'é': text[pos] = 158;
                    case 'ê': text[pos] = 159;
                    case 'ë': text[pos] = 160;
                    case 'È': text[pos] = 134;
                    case 'É': text[pos] = 135;
                    case 'Ê': text[pos] = 136;
                    case 'Ë': text[pos] = 137;
                    case 'ì': text[pos] = 161;
                    case 'í': text[pos] = 162;
                    case 'î': text[pos] = 163;
                    case 'ï': text[pos] = 164;
                    case 'Ì': text[pos] = 138;
                    case 'Í': text[pos] = 139;
                    case 'Î': text[pos] = 140;
                    case 'Ï': text[pos] = 141;
                    case 'ò': text[pos] = 165;
                    case 'ó': text[pos] = 166;
                    case 'ô': text[pos] = 167;
                    case 'ö': text[pos] = 168;
                    case 'Ò': text[pos] = 142;
                    case 'Ó': text[pos] = 143;
                    case 'Ô': text[pos] = 144;
                    case 'Ö': text[pos] = 145;
                    case 'ù': text[pos] = 169;
                    case 'ú': text[pos] = 170;
                    case 'û': text[pos] = 171;
                    case 'ü': text[pos] = 172;
                    case 'Ù': text[pos] = 146;
                    case 'Ú': text[pos] = 147;
                    case 'Û': text[pos] = 148;
                    case 'Ü': text[pos] = 149;
                    case 'ñ': text[pos] = 174;
                    case 'Ñ': text[pos] = 173;
                    case '¡': text[pos] = 64;
                    case '¿': text[pos] = 175;
                    case '`': text[pos] = 177;
                    case '&': text[pos] = 38;
                    default:  text[pos] = reason[pos];
                }
            }

            strcat(TextDrawsNotification[playerid][cycle][Text], text, MAX_TDN_TEXT);
 
            TextDrawsNotification[playerid][cycle][Use] = 1;
 
            LinesTDN(playerid, cycle);

            #if defined TDN_MODE_DOWN

            MinPosYTDN(playerid, cycle);
            MaxPosYTDN(playerid, cycle);

            #endif

            #if defined TDN_MODE_UP

            MaxPosYTDN(playerid, cycle);
            MinPosYTDN(playerid, cycle);
            
            #endif

            CreateTDN(playerid, cycle);

            for(new i; i < MAX_TDN; i++)
            {
                if(used(playerid, counter[playerid]))
                {
                    if(counter[playerid] == MAX_TDN - 1) counter[playerid] = 0;
                    else counter[playerid]++;
                }
                else break;
            }

            new TDN = counter[playerid];

            TextDrawsNotification[playerid][cycle][Hide] = TDN;

            if(counter[playerid] == MAX_TDN - 1) counter[playerid] = 0;
            else counter[playerid]++;

            return TDN;
        }
    }
    return -1;
}

stock used(playerid, id)
{
    for(new cycle; cycle < MAX_TDN; cycle++)
    {
        if(TextDrawsNotification[playerid][cycle][Hide] == id) return 1;
    }
    return 0;
}

forward hideTDN(playerid, TDN);
public hideTDN(playerid, TDN)
{
    for(new cycle; cycle < MAX_TDN; cycle++)
    {
        if(TextDrawsNotification[playerid][cycle][Hide] == TDN)
        {
            TextDrawsNotification[playerid][cycle][Use] = 0;
            if(TextDrawsNotification[playerid][cycle][TextDraw] != PlayerText:-1)
            {
                PlayerTextDrawDestroy(playerid, TextDrawsNotification[playerid][cycle][TextDraw]);
                TextDrawsNotification[playerid][cycle][Line] = 0;
                TextDrawsNotification[playerid][cycle][Text][0] = EOS;
                TextDrawsNotification[playerid][cycle][MinPosY] = 0;
                TextDrawsNotification[playerid][cycle][MaxPosY] = 0;
                TextDrawsNotification[playerid][cycle][TextDraw] = PlayerText:-1;
            }
            TextDrawsNotification[playerid][cycle][Hide] = -1;
            UpdateTDN(playerid);
            return 1;
        }
    }
    return 0;
}

stock UpdateTDN(playerid)
{
    for(new cycle = 0; cycle < MAX_TDN; cycle ++)
    {
        if(!TextDrawsNotification[playerid][cycle][Use])
        {
            if(cycle != MAX_TDN - 1)
            {
                if(TextDrawsNotification[playerid][cycle + 1][Use])
                {
                    TextDrawsNotification[playerid][cycle][Use] = TextDrawsNotification[playerid][cycle + 1][Use];
                    TextDrawsNotification[playerid][cycle][Line] = TextDrawsNotification[playerid][cycle + 1][Line];
                    strcat(TextDrawsNotification[playerid][cycle][Text], TextDrawsNotification[playerid][cycle + 1][Text], MAX_TDN_TEXT);
                    TextDrawsNotification[playerid][cycle][TextDraw] = TextDrawsNotification[playerid][cycle + 1][TextDraw];
                    TextDrawsNotification[playerid][cycle][Hide] = TextDrawsNotification[playerid][cycle + 1][Hide];

                    TextDrawsNotification[playerid][cycle + 1][Use] = 0;
                    TextDrawsNotification[playerid][cycle + 1][Line] = 0;
                    TextDrawsNotification[playerid][cycle + 1][Text][0] = EOS;
                    TextDrawsNotification[playerid][cycle + 1][TextDraw] = PlayerText:-1;
                    TextDrawsNotification[playerid][cycle + 1][MinPosY] = 0;
                    TextDrawsNotification[playerid][cycle + 1][MaxPosY] = 0;
                    TextDrawsNotification[playerid][cycle + 1][Hide] = -1;

                    #if defined TDN_MODE_DOWN

                    MinPosYTDN(playerid, cycle);
                    MaxPosYTDN(playerid, cycle);
                    
                    #endif

                    #if defined TDN_MODE_UP
                    
                    MaxPosYTDN(playerid, cycle);
                    MinPosYTDN(playerid, cycle);
                    
                    #endif       
                }
            }
        }
        else if(TextDrawsNotification[playerid][cycle][Use])
        {
            if(cycle != 0)
            {
                if(!TextDrawsNotification[playerid][cycle - 1][Use])
                {
                    TextDrawsNotification[playerid][cycle - 1][Use] = TextDrawsNotification[playerid][cycle][Use];
                    TextDrawsNotification[playerid][cycle - 1][Line] = TextDrawsNotification[playerid][cycle][Line];
                    strcat(TextDrawsNotification[playerid][cycle - 1][Text], TextDrawsNotification[playerid][cycle][Text], MAX_TDN_TEXT);
                    TextDrawsNotification[playerid][cycle - 1][TextDraw] = TextDrawsNotification[playerid][cycle][TextDraw];
                    TextDrawsNotification[playerid][cycle - 1][Hide] = TextDrawsNotification[playerid][cycle][Hide];

                    TextDrawsNotification[playerid][cycle][Use] = 0;
                    TextDrawsNotification[playerid][cycle][Line] = 0;
                    TextDrawsNotification[playerid][cycle][Text][0] = EOS;
                    TextDrawsNotification[playerid][cycle][TextDraw] = PlayerText:-1;
                    TextDrawsNotification[playerid][cycle][MinPosY] = 0;
                    TextDrawsNotification[playerid][cycle][MaxPosY] = 0;
                    TextDrawsNotification[playerid][cycle][Hide] = -1;

                    #if defined TDN_MODE_DOWN

                    MinPosYTDN(playerid, cycle - 1);
                    MaxPosYTDN(playerid, cycle - 1);
                    
                    #endif

                    #if defined TDN_MODE_UP
                    
                    MaxPosYTDN(playerid, cycle - 1);
                    MinPosYTDN(playerid, cycle - 1);
                    
                    #endif
                }
            }
        }
        CreateTDN(playerid, cycle);
    }
    return 1;
}

stock MinPosYTDN(playerid, TDN)
{
    #if defined TDN_MODE_DOWN

    if(TDN == 0)
    {
        TextDrawsNotification[playerid][TDN][MinPosY] = TDN_POS_Y;
    }
    else
    {
        TextDrawsNotification[playerid][TDN][MinPosY] = TextDrawsNotification[playerid][TDN - 1][MaxPosY] + TDN_DISTANCE;
    }
    return 1;

    #endif

    #if defined TDN_MODE_UP

    TextDrawsNotification[playerid][TDN][MinPosY] = TextDrawsNotification[playerid][TDN][MaxPosY] - ((TDN_LETTER_SIZE_Y * 2) + 2) - ((TDN_LETTER_SIZE_Y * 5.75) * TextDrawsNotification[playerid][TDN][Line]) - ((TextDrawsNotification[playerid][TDN][Line] - 1) * ((TDN_LETTER_SIZE_Y * 2) + 2 + TDN_LETTER_SIZE_Y)) - (TDN_LETTER_SIZE_Y + 3);
    return 1;

    #endif
}

stock MaxPosYTDN(playerid, TDN)
{
    #if defined TDN_MODE_DOWN

    TextDrawsNotification[playerid][TDN][MaxPosY] = TextDrawsNotification[playerid][TDN][MinPosY] + (TDN_LETTER_SIZE_Y * 2) + 2 + (TDN_LETTER_SIZE_Y * 5.75 * TextDrawsNotification[playerid][TDN][Line]) + ((TextDrawsNotification[playerid][TDN][Line] - 1) * ((TDN_LETTER_SIZE_Y * 2) + 2 + TDN_LETTER_SIZE_Y)) + TDN_LETTER_SIZE_Y + 3;
    return 1;

    #endif

    #if defined TDN_MODE_UP

    if(TDN == 0)
    {
        TextDrawsNotification[playerid][TDN][MaxPosY] = TDN_POS_Y;
    }
    else
    {
        TextDrawsNotification[playerid][TDN][MaxPosY] = TextDrawsNotification[playerid][TDN - 1][MinPosY] - TDN_DISTANCE;
    }
    return 1;

    #endif
}

stock LinesTDN(playerid, TDN)
{
    new lines = 1, Float:width, lastspace = -1, supr, len = strlen(TextDrawsNotification[playerid][TDN][Text]);
 
    for(new i = 0; i < len; i ++)
    {
        if(TextDrawsNotification[playerid][TDN][Text][i] == '~')
        {
            if(supr == 0)
            {
                supr = 1;
                if(TextDrawsNotification[playerid][TDN][Text][i+2] != '~') SendClientMessage(playerid, -1, "Error: '~' used incorrectly'");
            }
            else if(supr == 1) supr = 0;
        }
        else
        {
            if(supr == 1)
            {
                if(TextDrawsNotification[playerid][TDN][Text][i] == 'n')
                {
                    lines ++;
                    lastspace = -1;
                    width = 0;
                }
            }
            else
            {
                if(TextDrawsNotification[playerid][TDN][Text][i] == ' ') lastspace = i;
 
                width += TDN_LETTER_SIZE_X * GetTextDrawCharacterWidth(TextDrawsNotification[playerid][TDN][Text][i], TDN_FONT, bool:TDN_PROPORTIONAL);

                if(width > TDN_SIZE - 3)
                {
                    if(lastspace != i && lastspace != -1)
                    {
                        lines ++;
                        i = lastspace;
                        lastspace = -1;
                        width = 0;
                    }
                    else
                    {
                        lines ++;
                        lastspace = -1;
                        width = 0;
                    }
                }
            }
        }
    }
    
    TextDrawsNotification[playerid][TDN][Line] = lines;
 
    return 1;
}

stock CreateTDN(playerid, TDN)
{
    if(TextDrawsNotification[playerid][TDN][Use] == 1)
    {
        if(TextDrawsNotification[playerid][TDN][TextDraw] != PlayerText:-1)
        {
            PlayerTextDrawDestroy(playerid, TextDrawsNotification[playerid][TDN][TextDraw]);
        }
    
        TextDrawsNotification[playerid][TDN][TextDraw] = CreatePlayerTextDraw(playerid, TDN_POS_X, TextDrawsNotification[playerid][TDN][MinPosY], TextDrawsNotification[playerid][TDN][Text]);
        PlayerTextDrawFont(playerid, TextDrawsNotification[playerid][TDN][TextDraw], TDN_FONT);
        PlayerTextDrawLetterSize(playerid, TextDrawsNotification[playerid][TDN][TextDraw], TDN_LETTER_SIZE_X, TDN_LETTER_SIZE_Y);
        PlayerTextDrawTextSize(playerid, TextDrawsNotification[playerid][TDN][TextDraw], floatadd(TDN_POS_X, TDN_SIZE), 1.000000);
        PlayerTextDrawSetOutline(playerid, TextDrawsNotification[playerid][TDN][TextDraw], 1);
        PlayerTextDrawSetShadow(playerid, TextDrawsNotification[playerid][TDN][TextDraw], 0);
        PlayerTextDrawAlignment(playerid, TextDrawsNotification[playerid][TDN][TextDraw], 1);
        PlayerTextDrawColor(playerid, TextDrawsNotification[playerid][TDN][TextDraw], TDN_COLOR);
        PlayerTextDrawBackgroundColor(playerid, TextDrawsNotification[playerid][TDN][TextDraw], TDN_COLOR_BOX);
        PlayerTextDrawBoxColor(playerid, TextDrawsNotification[playerid][TDN][TextDraw], TDN_COLOR_BOX);
        PlayerTextDrawUseBox(playerid, TextDrawsNotification[playerid][TDN][TextDraw], 1);
        PlayerTextDrawSetProportional(playerid, TextDrawsNotification[playerid][TDN][TextDraw], TDN_PROPORTIONAL);
        PlayerTextDrawSetSelectable(playerid, TextDrawsNotification[playerid][TDN][TextDraw], 0);
        PlayerTextDrawShow(playerid, TextDrawsNotification[playerid][TDN][TextDraw]);
    }
    return 1;
}

public OnGameModeInit()
{
    for(new playerid = 0; playerid < MAX_PLAYERS; playerid++)
    {
        for(new TDN = 0; TDN < MAX_TDN; TDN++)
        {
            TextDrawsNotification[playerid][TDN][TextDraw] = PlayerText:-1;
            TextDrawsNotification[playerid][TDN][Hide] = -1;
        }
    }
    #if defined TDN_OnGameModeInit
		return TDN_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit TDN_OnGameModeInit
#if defined TDN_OnGameModeInit
	forward TDN_OnGameModeInit();
#endif

 
public OnFilterScriptInit()
{
    for(new playerid = 0; playerid < MAX_PLAYERS; playerid++)
    {
        for(new TDN = 0; TDN < MAX_TDN; TDN++)
        {
            TextDrawsNotification[playerid][TDN][TextDraw] = PlayerText:-1;
            TextDrawsNotification[playerid][TDN][Hide] = -1;
        }
    }
    #if defined TDN_OnFilterScriptInit
		return TDN_OnFilterScriptInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnFilterScriptInit
	#undef OnFilterScriptInit
#else
	#define _ALS_OnFilterScriptInit
#endif

#define OnFilterScriptInit TDN_OnFilterScriptInit
#if defined TDN_OnFilterScriptInit
	forward TDN_OnFilterScriptInit();
#endif

public OnPlayerDisconnect(playerid, reason)
{
    for(new cycle; cycle < MAX_TDN; cycle++)
    {
        TextDrawsNotification[playerid][cycle][Use] = 0;
        TextDrawsNotification[playerid][cycle][Line] = 0;
        TextDrawsNotification[playerid][cycle][Text][0] = EOS;
        TextDrawsNotification[playerid][cycle][MinPosY] = 0;
        TextDrawsNotification[playerid][cycle][MaxPosY] = 0;
        TextDrawsNotification[playerid][cycle][Hide] = -1;
        TextDrawsNotification[playerid][cycle][TextDraw] = PlayerText:-1;
    }
    #if defined TDN_OnPlayerDisconnect
		return TDN_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect TDN_OnPlayerDisconnect
#if defined TDN_OnPlayerDisconnect
	forward TDN_OnPlayerDisconnect(playerid, reason);
#endif
