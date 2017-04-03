local L = LibStub("AceLocale-3.0"):NewLocale("MrTrader", "enUS", true)
if L then
-- Core Strings
L["MrTrader"] = true
L["%s v%s loaded."] = true

-- Whisper Command Strings & Responses
L["I don't know that skill."] = true
L["I don't know what skill you mean."] = true
L["No skill exists by that name."] = true
L["Character %s knows %s"] = true
L["%s knows %s"] = true

-- Options/Profiles
L["Profiles"] = true
L["Configure"] = true
L["Open configuration dialog"] = true
L["Show Opposing Faction Alts"] = true
L["Will show your alts from the opposing faction in the menu."] = true
L["Whisper Skills for Alts"] = true
L["Will search your alts for skill links when responding to whisper commands."] = true
L["Use Custom Tradeskill Window"] = true
L["Will use MrTrader's tradeskill window instead of Blizzard's"] = true
L["Respond to Whisper Commands"] = true
L["Will respond to whispers sent to you asking for skill links."] = true
L["Respond to Commands over Guild Chat"] = true
L["Will respond to guild messages asking for skill links."] = true
L["Respond to Commands over Raid and Party Chat"] = true
L["Will respond to raid and party messages asking for skill links."] = true
L["Show Minor Skills for Alts"] = true
L["Will show Cooking, Smelting, Runeforging, and First Aid on other characters."] = true
L["Use Tradeskill Window"] = true
L["Will use MrTrader's tradeskill window in place of the default."] = true
L["Remember Selected Category"] = true
L["Will remember the selected category for each tradeskill."] = true
L["Display Tooltips in Skill List"] = true
L["Will display crafted item tooltips when hovering in the skill list."] = true

-- Launcher
L["Click to open menu."] = true
L["Tradeskills"] = true
L["Close"] = true
L["Characters"] = true
L["Remove"] = true
L["Unignore"] = true
L["Tradeskill cannot be linked, and is unavailable."] = true
L["Click to open tradeskill window."] = true
L["Click to open tradeskill window. Shift-click to link tradeskill."] = true
L["Click to remove from the list, shift-click to ignore this character permanently."] = true
L["Unignore this character and show on all other characters."] = true

-- Tradeskill Window
L["All Items"] = true
L["Categories"] = true
L["Inventory Slots"] = true
L["Difficulty"] = true
L["Optimal"] = true
L["Medium"] = true
L["Easy"] = true
L["Trivial"] = true
L["Favorites"] = true
L["Queue"] = true
L["Show Queue"] = true
L["Hide Queue"] = true

-- Tradeskill Window Context Menus
L["Favorite Groups"] = true
L["Add to New Favorite Group..."] = true
L["New Favorite Group"] = true
L["Remove Favorite Group"] = true
L["New Group"] = true
L["Name"] = true
end