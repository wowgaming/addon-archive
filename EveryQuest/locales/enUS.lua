local debug = false
--[===[@debug@
--debug = true
--@end-debug@]===]

local L = LibStub("AceLocale-3.0"):NewLocale("EveryQuest", "enUS", true, debug)

-- Core.lua
L[" (%d Times)"] = true
L[" [L]"] = true
L["%d Shown"] = true
L["%d days %d hr ago"] = true
L["%d days ago"] = true
L["%d hr %d min ago"] = true
L["%d hr ago"] = true
L["%d minutes ago"] = true
L["%d seconds ago"] = true
L["%m/%d/%y %I%p"] = true
L["1 day %d hr ago"] = true
L["1 day ago"] = true
L["1 minute ago"] = true
L["1 second ago"] = true
L["Abandoned"] = true
L["Abandoned: %s"] = true
L["Cancel"] = true
L["Completed"] = true
L["Completed%s: %s"] = true
L["Could not load %s Quest Data because of %s"] = true
L["D"] = true
L["E"] = true
L["EQ_CLEARIMPORTDESC"] = [=[Click the checkbox to confirm deleting imported data.

When you imported, each imported quest was tagged so they can later be removed easily. Don't panic though as when you start to quest using EQ, this imported tag is cleared so any new data is not lost.]=]
L["EQ_PURGETXT"] = "Are you sure you want to purge all old data? If you are unsure, or just completed an upgrade, cancel and check the EveryQuest window to see if your quests are there. To continue type 'DELETE' in the box below. This action is irreversible. You can clear the database later using the interface options"
L["EQ_UPGRADETXT"] = "EveryQuest has detected %s out of date database(s) (resulting from a version upgrade), click Yes to attempt to upgrade. This may take a moment. You can upgrade later using the interface options"
L["Failed"] = true
L["Failed or Abandoned"] = true
L["Failed: %s"] = true
L["Forget"] = true
L["G"] = true
L["H"] = true
L["Ignore"] = true
L["Imported From: %s"] = true
L["In Progress"] = true
L["Loading %s Quest Data"] = true
L["Other"] = true
L["P"] = true
L["PURGE_ERROR"] = "You have not entered the correct text to delete old data. Please read the message!"
L["Purge"] = true
L["QuestGuru"] = true
L["QuestHistory"] = true
L["R"] = true
L["Requires LOD Module: %s"] = true
L["Server Query"] = true
L["Status: %s"] = true
L["Turned In"] = true
L["Unknown"] = true
L["Upgrade"] = true
L["W"] = true
L["WE"] = true
L["Y"] = true
L["You are running a source checkout of EveryQuest %s directly from the repository."] = true
L["You are running an ALPHA RELEASE of EveryQuest %s (revision %d). Please report any bugs @ http://www.wowace.com/addons/everyquest/tickets/"] = true
L["r%d"] = true


-- events.lua
L["Abandon Quest: %s"] = true
L["Complete Quest: %s"] = true
L["Failed Quest: %s"] = true
L["Obtained Quest: %s"] = true
L["Turn In Quest: %s"] = true
L["Unable to get Quest Information from DB"] = true


-- frames.lua
L["%d Completed"] = true
L["%d Failed/Abandoned"] = true
L["%d Hidden"] = true
L["%d Ignored"] = true
L["%d In Progress"] = true
L["%d Turned In"] = true
L["%d Unknown"] = true
L["- Select -"] = true
L["Click to toggle the main window"] = true
L["EveryQuest"] = true
L["EveryQuest Log"] = true
L["Filters"] = true
L["Options"] = true
L["Right-click to open the options menu"] = true
L["Toggle Frame"] = true


-- import.lua
L["Clear Import Confirm"] = true
L["Clear Imported Data"] = true
L["Delete any quest tagged as being imported."] = true
L["Deleted %d quests from your database"] = true
L["EQ_CLEARIMPORTDESC"] = [=[Click the checkbox to confirm deleting imported data.

When you imported, each imported quest was tagged so they can later be removed easily. Don't panic though as when you start to quest using EQ, this imported tag is cleared so any new data is not lost.]=]
L["EQ_IMPORT"] = [=[Here you can import quest history from other addons. Currently only QuestGuru and QuestHistory are supported.

|cffFFAFAFNOTE: To import all of your data, you will need to repeat this function on all your characters while the addon you are importing from is loaded. This is a limitation in EveryQuest storing data per-character rather then globally (this saves you memory/startup time).|r]=]
L["EQ_IMPORT_TRAILER"] = "If either of these buttons are disabled, that means you don't have the necessary addon loaded. Logout and enable the addon to import your data."
L["Import"] = true
L["Import QuestGuru Data"] = true
L["Import QuestHistory Data"] = true
L["Import failed, you have no data relating to this character on this server."] = true
L["Imported %d quests from %s"] = true
L["QuestHistory importing is strictly alpha quality. This is due to having to guess at which quest you are trying to import."] = true


-- options.lua
L["Alliance"] = true
L["Ascending"] = true
L["Both Factions"] = true
L["Completed Quests"] = true
L["Configure filtering options for the quest list. These settings are character specific."] = true
L["Control the display of specific quest statuses"] = true
L["Customize how your quest list is sorted.  Higher Weight moves the items to the top of the list, lower weight goes to the bottom.  Sort order Ascending: A-Z 0-9, Descending: Z-A, 9-0."] = true
L["Daily Quests"] = true
L["Descending"] = true
L["Direction"] = true
L["Dungeon Quests"] = true
L["EQ_DESC"] = "EveryQuest allows you to track which quests you've completed in a friendly list. It will also show you what quests are available in each zone. Combine this addon with LightHeaded and TomTom for the ultimate questing experience"
L["EQ_LOCALLIST"] = "Warning: Localizing the quest list can result in random disconnects.  This is due to querying the game server for a quest's tooltip and can result in the server not knowing about a quest."
L["Enable Filtering"] = true
L["Example for Ignored quest: Some quests are still in Wowhead's database but are not attainable ingame anymore. Ignore them to hide them from the list."] = true
L["Faction Filter"] = true
L["Failed or Abandoned Quests"] = true
L["Filter Quests by Level"] = true
L["Filter Quests by Type"] = true
L["General Settings"] = true
L["Group Quests"] = true
L["Heroic Quests"] = true
L["Horde"] = true
L["Ignored Quests"] = true
L["Level Filter"] = true
L["List Order"] = true
L["Localized Quest List"] = true
L["Maximum Level"] = true
L["Minimum Level"] = true
L["More Numbers"] = true
L["No Side/No Data"] = true
L["Normal Quests"] = true
L["Note: Stores localized quest titles in the global database"] = true
L["Order by Daily"] = true
L["Order by Level"] = true
L["Order by Name"] = true
L["Order by Type"] = true
L["Order by Weekly"] = true
L["Other"] = true
L["Purge Old data"] = true
L["Purge Old database data, generally used after running upgrade"] = true
L["PvP Quests"] = true
L["Quests In Progress"] = true
L["Raid Quests"] = true
L["Removes 'shown' from the displayed numbers, adds a counts of each status shown."] = true
L["Save Zone"] = true
L["Saves which zone you where last looking at to load upon login"] = true
L["Show Debugging Messages"] = true
L["Show Debugging Messages - *WARNING* Spams your default chat frame"] = true
L["Show quests for specific faction"] = true
L["Shows 'group suggested' quests"] = true
L["Shows 'raid suggested' quests"] = true
L["Shows Alliance Quests"] = true
L["Shows Horde Quests"] = true
L["Shows PVP quests"] = true
L["Shows completed quests still in your questlog"] = true
L["Shows daily quests"] = true
L["Shows dungeon quests"] = true
L["Shows heroic quests"] = true
L["Shows normal Blizzard soloable quests"] = true
L["Shows quests that are available to both factions"] = true
L["Shows quests that don't have a side or don't have data for a specific side"] = true
L["Shows quests that you are on but not completed"] = true
L["Shows quests that you have failed or abandoned"] = true
L["Shows quests turned back into NPCs"] = true
L["Shows quests you haven't seen before"] = true
L["Shows quests you've ignored"] = true
L["Shows weekly quests"] = true
L["Status Filter"] = true
L["Track Zone"] = true
L["Track zone changes and update the EveryQuest list for that zone"] = true
L["Turned In Quests"] = true
L["Type Filter"] = true
L["Unknown Status"] = true
L["Upgrade DB"] = true
L["Upgrade the Database from the old format"] = true
L["Weekly Quests"] = true
L["Weight"] = true


-- query.lua
L["Added %d quests to your database"] = true
L["Auto Populate"] = true
L["Consider uploading your WTF\\Account\\{account name}\\SavedVariables\\EveryQuest.lua to http://wow.kandarz.com/everyquest/upload.html"] = true
L["EQ_QUERY"] = [=[|cffFFFF00NEW IN 3.3!|r

In this 2 step process, EveryQuest can get your completed quest history from the Blizzard servers! Find those quests you missed before you used EveryQuest.

  |cff00E1FFStep 1:|r Click to query the server.]=]
L["EQ_QUERY2"] = [=[
  |cff00E1FFStep 2:|r Click to populate your client's database. Please be warned, depending on the amount of quests you've completed, this may take some time and your game will 'freeze' during this process. I hope you don't get disconnected.]=]
L["EQ_QUERY_TRAILER"] = [=[
  |cff00E1FFAll done!|r

If you got a red message in your chat window, it means the current EveryQuest database doesn't contain some quests you've done. Do not fret though, Blizzard's log contains special quests that you never actually turned into anyone. Such as |cffFFFF00[FLAG: Tournament Invitation]|r]=]
L["Once the server responds, automatically start the import of quest data"] = true
L["Once you recieve the server responce, populate the database with your completed quests."] = true
L["Populate History"] = true
L["Populate History: %d quests not found in the database."] = true
L["Populating your quest history from the server, this may take a while and might freeze your game."] = true
L["Query Server"] = true
L["Querying Server for your quest history"] = true
L["Ready to populate your quest history from server"] = true


-- zonemenu.lua
L["Ahn'Qiraj War Effort"] = true
L["Alchemy"] = true
L["All"] = true
L["Battlegrounds"] = true
L["Blacksmithing"] = true
L["Brewfest"] = true
L["Burning Crusade"] = true
L["Children's Week"] = true
L["Classes"] = true
L["Classic"] = true
L["Cooking"] = true
L["Dalaran Crater"] = true
L["Darkmoon Faire"] = true
L["Day of the Dead"] = true
L["Dungeons"] = true
L["Engineering"] = true
L["Epic"] = true
L["First Aid"] = true
L["Fishing"] = true
L["Hallow's End"] = true
L["Harvest Festival"] = true
L["Herbalism"] = true
L["Inscription"] = true
L["Jewelcrafting"] = true
L["Leatherworking"] = true
L["Legendary"] = true
L["Love is in the Air"] = true
L["Lunar Festival"] = true
L["Midsummer Fire Festival"] = true
L["Miscellaneous"] = true
L["New Year's Eve"] = true
L["Noblegarden"] = true
L["Pilgrim's Bounty"] = true
L["Professions"] = true
L["Raids"] = true
L["Reputation"] = true
L["Scourge Invasion"] = true
L["Skettis"] = true
L["Tailoring"] = true
L["The Black Temple"] = true
L["Timbermaw Hold"] = true
L["Tournament"] = true
L["Winter Veil"] = true
L["World Events"] = true
L["Wrath of the Lich King"] = true


