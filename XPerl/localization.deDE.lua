-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

if (GetLocale() == "deDE") then
	XPerl_LongDescription	= "UnitFrame Alternative f\195\188r ein neues Aussehen von Spieler, Begleiter, Gruppe, Ziel, Ziel des Ziels, Fokus und Schlachtzug"

	XPERL_MINIMAP_HELP1		= "|c00FFFFFFLinks-Klick|r, f\195\188r die Optionen (und zum |c0000FF00Entsperren der Frames|r)"
	XPERL_MINIMAP_HELP2		= "|c00FFFFFFRechts-Klick|r, um das Symbol zu verschieben"
	XPERL_MINIMAP_HELP3		= "\rRichtige Schlachtzugsmitglieder: |c00FFFF80%d|r\rRichtige Gruppenmitglieder: |c00FFFF80%d|r"
	XPERL_MINIMAP_HELP4		= "\rDu bist der Leiter der richtigen Gruppe/Schlachtzugs"
	XPERL_MINIMAP_HELP5		= "|c00FFFFFFAlt|r, f\195\188r die X-Perl Speicherausnutzung"
	XPERL_MINIMAP_HELP6		= "|c00FFFFFF+Umschalt|r, f\195\188r die X-Perl Speicherausnutzung seit dem Start"

	XPERL_MINIMENU_OPTIONS	= "Optionen"
	XPERL_MINIMENU_ASSIST	= "Zeige Assistiert-Frame"
	XPERL_MINIMENU_CASTMON	= "Zeige Casting-Monitor"
	XPERL_MINIMENU_RAIDAD	= "Zeige Schlachtzugs-Admin"
	XPERL_MINIMENU_ITEMCHK	= "Zeige Gegenstands-Checker"
	XPERL_MINIMENU_RAIDBUFF = "Schlachtzugsbuffs"
	XPERL_MINIMENU_ROSTERTEXT = "Listen-Text"
	XPERL_MINIMENU_RAIDSORT = "Sortierung des Schlachtzugs"
	XPERL_MINIMENU_RAIDSORT_GROUP = "Nach Gruppe sortieren"
	XPERL_MINIMENU_RAIDSORT_CLASS = "Nach Klasse sortieren"
	
	XPERL_TYPE_NOT_SPECIFIED	= "Nicht spezifiziert"
	XPERL_TYPE_PET		= PET			-- "Pet"
	XPERL_TYPE_BOSS 	= "Boss"
	XPERL_TYPE_RAREPLUS = "Rar+"
	XPERL_TYPE_ELITE		= "Elite"
	XPERL_TYPE_RARE 	= "Rar"

-- Zones
	XPERL_LOC_ZONE_SERPENTSHRINE_CAVERN = "H\195\182hle des Schlangenschreins"
	XPERL_LOC_ZONE_BLACK_TEMPLE = "Der Schwarze Tempel"
	XPERL_LOC_ZONE_HYJAL_SUMMIT = "Hyjalgipfel"
	XPERL_LOC_ZONE_KARAZHAN = "Karazhan"
	XPERL_LOC_ZONE_SUNWELL_PLATEAU = "Sonnenbrunnenplateau"
	XPERL_LOC_ZONE_NAXXRAMAS = "Naxxramas"
	XPERL_LOC_ZONE_OBSIDIAN_SANCTUM = "Das Obsidiansanktum"
	XPERL_LOC_ZONE_EYE_OF_ETERNITY = "Das Auge der Ewigkeit"
	XPERL_LOC_ZONE_ULDUAR = "Ulduar"
	XPERL_LOC_ZONE_TRIAL_OF_THE_CRUSADER = "Prüfung des Kreuzfahrers"
	XPERL_LOC_ZONE_ICECROWN_CITADEL = "Eiskronenzitadelle"
	XPERL_LOC_ZONE_RUBY_SANCTUM = "Das Rubinsanktum"

-- Status
	XPERL_LOC_DEAD		= DEAD			-- "Dead"
	XPERL_LOC_GHOST 	= "Geist"
	XPERL_LOC_FEIGNDEATH	= "Totgestellt"
	XPERL_LOC_OFFLINE	= PLAYER_OFFLINE	-- "Offline"
	XPERL_LOC_RESURRECTED	= "Wiederbelebung"
	XPERL_LOC_SS_AVAILABLE	= "SS verf\195\188gbar"
	XPERL_LOC_UPDATING	= "Aktualisierung"
	XPERL_LOC_ACCEPTEDRES	= "Akzeptiert"		-- Res accepted
	XPERL_RAID_GROUP	= "Gruppe %d"
	XPERL_RAID_GROUPSHORT	= "G%d"

	XPERL_LOC_NONEWATCHED	= "nicht beobachtet"

	XPERL_LOC_STATUSTIP = "Status Hervorhebungen: " 	-- Tooltip explanation of status highlight on unit
	XPERL_LOC_STATUSTIPLIST = {
		HOT = "Heilung \195\188ber Zeit",
		AGGRO = "Aggro",
		MISSING = "Dein Klassenbuff fehlt",
		HEAL = "Wird geheilt",
		SHIELD = "Schild"
	}

	XPERL_OK		= "OK"
	XPERL_CANCEL		= "Abbrechen"

	XPERL_LOC_LARGENUMDIV	= 1000
	XPERL_LOC_LARGENUMTAG	= "K"
	XPERL_LOC_HUGENUMDIV	= 1000000
	XPERL_LOC_HUGENUMTAG	= "M"

	BINDING_HEADER_XPERL = XPerl_ProductName
	BINDING_NAME_TOGGLERAID = "Schalter f\195\188r die Schlachtzugsfenster"
	BINDING_NAME_TOGGLERAIDSORT = "Schalter f\195\188r Schlachtzug sortieren nach Klasse/Gruppe"
	BINDING_NAME_TOGGLERAIDPETS = "Schalter f\195\188r Schlachtzugsbegleiter"
	BINDING_NAME_TOGGLEOPTIONS = "Schalter f\195\188r das Optionenfenster"
	BINDING_NAME_TOGGLEBUFFTYPE = "Schalter f\195\188r Buffs/Debuffs/Keine"
	BINDING_NAME_TOGGLEBUFFCASTABLE = "Schalter f\195\188r Zauberbar/Heilbar"
	BINDING_NAME_TEAMSPEAKMONITOR = "Teamspeak Monitor"
	BINDING_NAME_TOGGLERANGEFINDER = "Schalter f\195\188r Reichweiten-Sucher"

	XPERL_KEY_NOTICE_RAID_BUFFANY = "Alle Buffs/Debuffs zeigen"
	XPERL_KEY_NOTICE_RAID_BUFFCURECAST = "Nur zauberbare/heilbare Buffs oder Debuffs zeigen"
	XPERL_KEY_NOTICE_RAID_BUFFS = "Raid-Buffs zeigen"
	XPERL_KEY_NOTICE_RAID_DEBUFFS = "Raid-Debuffs zeigen"
	XPERL_KEY_NOTICE_RAID_NOBUFFS = "Keine Raid-Buffs zeigen"

	XPERL_DRAGHINT1		= "|c00FFFFFFKlick|r, zum Skalieren des Fensters"
	XPERL_DRAGHINT2		= "|c00FFFFFFUmschalt+Klick|r, zum Anpassen der Fenstergr\195\182\195\159e"

	-- Usage
	XPerlUsageNameList	= {XPerl = "Core", XPerl_Player = "Player", XPerl_PlayerPet = "Pet", XPerl_Target = "Target", XPerl_TargetTarget = "Target's Target", XPerl_Party = "Party", XPerl_PartyPet = "Party Pets", XPerl_RaidFrames = "Raid Frames", XPerl_RaidHelper = "Raid Helper", XPerl_RaidAdmin = "Raid Admin", XPerl_TeamSpeak = "TS Monitor", XPerl_RaidMonitor = "Raid Monitor", XPerl_RaidPets = "Raid Pets", XPerl_ArcaneBar = "Arcane Bar", XPerl_PlayerBuffs = "Player Buffs", XPerl_GrimReaper = "Grim Reaper"}
	XPERL_USAGE_MEMMAX	= "UI Max. Speicher: %d"
	XPERL_USAGE_MODULES = "Module: "
	XPERL_USAGE_NEWVERSION	= "*Neuere Version"
	XPERL_USAGE_AVAILABLE	= "%s |c00FFFFFF%s|r ist zum Download verf\195\188gbar"

	XPERL_CMD_MENU		= "menu"
	XPERL_CMD_OPTIONS	= "options"
	XPERL_CMD_LOCK		= "lock"
	XPERL_CMD_UNLOCK	= "unlock"
	XPERL_CMD_CONFIG	= "config"
	XPERL_CMD_LIST		= "list"
	XPERL_CMD_DELETE	= "delete"
	XPERL_CMD_HELP		= "|c00FFFF80Verwendung: |c00FFFFFF/xperl menu | lock | unlock | config list | config delete <realm> <name>"
	XPERL_CANNOT_DELETE_CURRENT = "Die aktuelle Konfiguration kann nicht gel\195\182scht werden"
	XPERL_CONFIG_DELETED		= "Konfiguration gel\195\182scht f\195\188r %s/%s"
	XPERL_CANNOT_FIND_DELETE_TARGET = "Konfiguration kann nicht zum L\195\182schen gefunden werden (%s/%s)"
	XPERL_CANNOT_DELETE_BADARGS = "Bitte einen Realmnamen und Spielernamen angeben"
	XPERL_CONFIG_LIST		= "Konfigurationsliste:"
	XPERL_CONFIG_CURRENT		= " (Aktuell)"

	XPERL_RAID_TOOLTIP_WITHBUFF      = "Mit Buff: (%s)"
	XPERL_RAID_TOOLTIP_WITHOUTBUFF   = "Ohne Buff: (%s)"
	XPERL_RAID_TOOLTIP_BUFFEXPIRING	= "%s's %s schwindet in %s"	-- Name, buff name, time to expire


-- Default spells for range checking in the healer visual out-of-range cues.
XPerl_DefaultRangeSpells = {
	DRUID	= {spell = GetSpellInfo(26979)},			-- Healing Touch
	PALADIN = {spell = GetSpellInfo(27136)},			-- Holy Light
	PRIEST	= {spell = GetSpellInfo(2053)},				-- Lesser Heal
	SHAMAN	= {spell = GetSpellInfo(25396)},			-- Healing Wave
	MAGE	= {spell = GetSpellInfo(475)},				-- Remove Lesser Curse
	WARLOCK	= {spell = GetSpellInfo(132)},				-- Detect Invisibility
	ANY	= {item = "Schwerer Netherstoffverband"}		-- TODO - Use Item ID
}

end
