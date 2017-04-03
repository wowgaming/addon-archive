local L = LibStub("AceLocale-3.0"):NewLocale("DataStore_Crafts", "enUS", true, true)

if not L then return end

L["Professions"] = true
L["Secondary Skills"] = true
L["Broadcast my profession links to guild at logon"] = true
L["BROADCAST_PROFS_TITLE"] = "Broadcast Profession Links"
L["BROADCAST_PROFS_ENABLED"] = "Your alts' known profession links will be sent on the guild channel 5 seconds after logon."
L["BROADCAST_PROFS_DISABLED"] = "Nothing will be sent at all. Disabling this option considerably decreases network traffic on the guild channel."
