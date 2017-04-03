local L = LibStub("AceLocale-3.0"):NewLocale("ClassLoot", "enUS", true)

if L then
	-- Slash Commands
	L["Check an item (Local)"] = true
	L["Check an item (Guild)"] = true
	L["Check an item (Raid)"] = true
	L["Display ClassLoot for an item locally"] = true
	L["Display ClassLoot for an item in guild chat"] = true
	L["Display ClassLoot for an item in raid chat"] = true
	L["<item link>"] = true
	
	-- Info Messages
	L["Version"] = true
	L["Last updated"] = true
	
	-- Error Messages
	L["could not be found"] = true
	L["Not in a guild!"] = true
	L["Not in a raid!"] = true
	
	-- Output Messages
	L["ClassLoot info for"] = true
	L["Dropped in"] = true
	L["by"] = true
	
	-- Tooltip Stuff
	L["Boss"] = true
	L["Instance"] = true
	
	-- Interface Options
	L["Enable ClassLoot Tooltips"] = true
	L["Display Boss Name"] = true
	L["Display Instance Name"] = true
	
	-- Misc Translations
	L["Tank"] = true
	L["DPS"] = true
	L["Trash Mobs"] = true
	L["World Bosses"] = true
	L["Timed Event"] = true
end
