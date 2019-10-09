-- Chat notifications

SG_STRING_MSG_ON		= "SorryGuys activated"
SG_STRING_MSG_OFF		= "SorryGuys deactivated"
SG_STRING_MSG_MSGSET	= "SorryGuys changed message to: "
SG_STRING_MSG_DNDMSGSET = "SorryGuys DND message changed to: "
SG_STRING_MSG_DNDON		= "SorryGuys will now set you to DND, when leaving a channel"
SG_STRING_MSG_DNDOFF	= "SorryGuys won't set you to DND, when leaving a channel"
SG_STRING_MSG_DNDSTARTON = "SorryGuys will set you to DND from start"
SG_STRING_MSG_DNDSTARTOFF = "SorryGuys won't set you to DND from start"
-- Help

SG_STRING_SLASH_HELP	= "use /sg or /sorryguys [command] [args] where command and args are one of:\
/sg toggle     toggle activation\
/sg on         activate leaving on entering channel\
/sg off        deactivate SorryGuys\
/sg dndtoggle  toggle setting state to DND on leaving a channel\
/sg	dndon      activate setting state to DND\
/sg dndoff     deactivate setting state to DND\
/sg dndstarttoggle toggel DND on start\
/sg dndstarton set state to DND on start\
/sg dndstartoff do not set state to DND on start\
/sg msg <TEXT> set the message on leaving a channel to <TEXT>\
/sg dndmsg <TEXT> set the DND and status message on leaving a channel to <TEXT>\
"

-- Interface

SG_STRING_OPTIONS_CHECKBUTTON_ONOFF			=	"Leave any friends chat (battle.net-chat) automatically"
SG_STRING_OPTIONS_CHECKBUTTON_DNDONOFF		=	"Set your state to DND after leaving a channel"
SG_STRING_OPTIONS_CHECKBUTTON_DNDSTARTONOFF		=	"Set your state to DND on start"
SG_STRING_OPTIONS_EDITBOX					=	"Message to send on leaving a channel:"
SG_STRING_OPTIONS_DNDEDITBOX				=	"Set your DND and status message to:"


if (GetLocale() == "deDE") then

SG_STRING_MSG_ON		= "SorryGuys ist nun aktiviert"
SG_STRING_MSG_OFF		= "SorryGuys ist nun deaktiviert"
SG_STRING_MSG_MSGSET	= "SorryGuys Nachricht geaendert zu: "
SG_STRING_MSG_DNDMSGSET = "SorryGuys DND-Nachricht geaendert zu: "
SG_STRING_MSG_DNDON		= "SorryGuys: DND bei Verlassen eines Kanals aktiviert"
SG_STRING_MSG_DNDOFF	= "SorryGuys: DND bei Verlassen eines Kanals deaktiviert"
SG_STRING_MSG_DNDSTARTON = "SorryGuys setzt den Status beim Start auf DND"
SG_STRING_MSG_DNDSTARTOFF = "SorryGuys setzt den Status beim Start nicht auf DND"

-- Help

SG_STRING_SLASH_HELP	= "Benutze /sg oder /sorryguys [Kommando] [Argument]:\
/sg toggle      Aktivierung umschalten\
/sg on          aktivieren\
/sg off         deaktivieren\
/sg dndtoggle   setzen des DND-Status\' umschalten\
/sg dndon       DND bei Verlassen eines Kanals aktivieren\
/sg dndoff      DND bei Verlassen eines Kanals nicht aktivieren\
/sg dndstarttoggle DND bei Start umschalten\
/sg dndstarton DND bei Start setzen\
/sg dndstartoff DND nicht bei Start setzen\
/sg msg <TEXT>  Die Nachricht, die vor Verlassen des Kanals gesendet wird auf <TEXT> setzen\
/sg dndmsg <TEXT> Setzt die DND- und Statusnachricht auf <TEXT>\
"

-- Interface

SG_STRING_OPTIONS_CHECKBUTTON_ONOFF			=	"Freundeschat automatisch wieder verlassen"
SG_STRING_OPTIONS_CHECKBUTTON_DNDONOFF		=	"Nach Verlassen DND setzen"
SG_STRING_OPTIONS_CHECKBUTTON_DNDSTARTONOFF		=	"Beim Start DND setzen"
SG_STRING_OPTIONS_EDITBOX					=	"Zu sendende Nachricht vor Verlassen des Chats:"
SG_STRING_OPTIONS_DNDEDITBOX				=	"DND- und Statusnachricht:"
end