

XPERL_MSG_PREFIX	= "|c00C05050X-Perl|r "
XPERL_COMMS_PREFIX	= "X-Perl"

XPERL_TOOLTIP_ASSISTING	= "Players Assisting:"
XPERL_TOOLTIP_HEALERS	= "Healers Targetting Me:"
XPERL_TOOLTIP_ALLONME	= "All Targetting Me:"
XPERL_TOOLTIP_ENEMYONME	= "Enemy Targetting Me:"
XPERL_TOOLTIP_HELP	= "Click to open real time view"
XPERL_TOOLTIP_PET	= "%s's pet"

XPERL_LOC_DEAD		= "Dead"

XPERL_BUTTON_TOGGLE_LABELS	= "Toggle Target Labels"
XPERL_BUTTON_TOGGLE_MTTARGETS	= "Toggle MT targets showing their target"
XPERL_BUTTON_TOGGLE_SHOWMT	= "Toggle showing of the Main Tank"
XPERL_BUTTON_HELPER_PIN		= "Pin Window"

XPERL_XS_TARGET			= "%s's target"
XPERL_NO_TARGET			= "no target"

XPERL_TITLE_MT_LONG		= "MT Targets"
XPERL_TITLE_MT_SHORT		= "MT"
XPERL_TITLE_WARRIOR_LONG	= "Warrior Targets"
XPERL_TITLE_WARRIOR_SHORT	= "Tanks"

XPERL_HELPER_NEEDPROMOTE	= "You must be promoted to set the Main Assist"
XPERL_HELPER_MASET		= "Main Assist set to %s"
XPERL_HELPER_MACLEAR		= "Main Assist |c00FF0000cleared!"
XPERL_HELPER_MAREMOVED		= "Main Assist %s not found in tank list - removed!"
XPERL_HELPER_MAREMOTESET	= "%s has assigned the Main Assist to be %s"

XPERL_HELPER_FINDFOUND		= "Using FIND found suitable target. ('|c00007F00/xp find|r' to clear)."
XPERL_HELPER_FINDCLEARED	= "Find |c00FF0000cleared!|r"
XPERL_HELPER_FINDSET		= "Find set to %s. ('|c00007F00/xp find|r' to clear)."

XPERL_AGGRO_PLAYER		= "- AGGRO -"
XPERL_AGGRO_PET			= "- PET AGGRO -"
XPERL_AGGRO_DRAGTIP		= "Move the location of the Aggro warning"

if ( GetLocale() == "frFR" ) then
	XPERL_LOC_DEAD = "Mort"

elseif ( GetLocale() == "koKR" ) then
	XPERL_LOC_DEAD = "죽음"
end
