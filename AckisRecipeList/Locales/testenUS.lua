--[[
************************************************************************
testenUS.lua
These are localization strings used for the testing of ARL.
Manually add entries here and then proceed to update the localization
application located here:
	http://www.wowace.com/addons/arl/localization/
************************************************************************
File date: 2010-01-31T04:59:34Z 
File revision: 2816 
Project revision: 2817
Project version: v1.0-r2818
************************************************************************
Please see http://www.wowace.com/addons/arl/ for more information.
These translations are released under the Public Domain.
************************************************************************
]]--

local MODNAME	= "Ackis Recipe List"

local L = LibStub("AceLocale-3.0"):NewLocale(MODNAME, "enUS", true)

if not L then return end

-- Command line options
L["Profile"]			= true

-- Config Options
L["About"]			= true
L["Main Options"]		= true
L["General Options"]		= true
L["Display Options"]		= true
L["Main Filter Options"]	= true
L["Sorting Options"]		= true
L["Profile Options"]		= true
L["Tooltip Options"]		= true
L["Map Options"]		= true
L["ARL Documentation"]		= true
L["Documentation"]		= true

-- Config UI Elements and their associated descriptions
L["MAIN_OPTIONS_DESC"]		= "Main configuration options"
L["Scan"]					= true
L["SCAN_RECIPES_DESC"]		= [[Scans an open tradeskill for missing recipes.
Shift-click to generate a text dump.
Alt-click to remove all waypoints from the mini-map and world map.]]
L["Text Dump"]			= true
L["TEXT_DUMP_DESC"]		= "Displays all recipes in a comma separated value format which can be copied and pasted into another client."
L["View Exclusion List"]	= true
L["Clear Exclusion List"]	= true
L["Reset All Filters"]		= true
L["Scan Button Position"]	= true
L["SCANBUTTONPOSITION_DESC"]	= "Allows you to customize where the scan button is placed on the tradeskill frame."
L["VIEW_EXCLUSION_LIST_DESC"]	= "Prints out a list of all recipes on the exclusion list."
L["CLEAR_EXCLUSION_LIST_DESC"]	= "Removes all recipes from the exclusion list."
L["MAINFILTER_OPTIONS_DESC"]	= "Allows you to specify how ARL handles different filters."
L["DISPLAY_OPTIONS_DESC"]	= "Allows you to customize how the GUI behaves."
L["SORTING_OPTIONS_DESC"]	= "Allows you to customize the way displayed recipes are sorted."
L["ARL_DOC_DESC"]		= "Documentation for Ackis Recipe List"

-- UI Documentation
L["Using Filters"]		= true
L["USING_FILTERS_DESC"]		= [[Filters may be toggled on or off.  There are two types of filters: one which will prevent the recipe from showing up at all, and one which will prevent a specific type of acquire information from showing up.
With the first type of filter, these match the proprieties of the recipe (ie: binding).  If you toggle ARL to not show BoP recipes, no recipes that are BoP will show up in the scan.  The second type of filter deals with acquire information.  If a recipe is available as a mob drop, or from a vendor and you toggle to not show vendor recipes, the recipe will still show up but vendor information will be hidden for it.  The reason is that there is still another way to acquire this recipe (mob drop) so it should still be included in the scan.
Please note that the tooltips will always hide the opposite faction methods of acquiring a recipe.  This has been done to save space in the tooltip since they can get quite large.]]
L["Reporting Bugs"]		= true
L["REPORTING_BUGS_DESC"]	= [[When reporting a bug, please make sure you do the following:
1) Download the latest version, available from http://www.wowace.com/addons/arl/files/
2) Make sure there is not a bug report filed for your issue already.  You can check these at http://www.wowace.com/addons/arl/tickets/
3) Disable addons such as Skillet or ATSW.
4) Read the bug reporting documentation at http://www.wowace.com/addons/arl/pages/feedback-and-bug-reporting/
5) If your problem is not listed and you are using the latest version verify your addon settings.  Verify filters, profiles, etc.
6) You have found a bug that no one has reported before.  Create a new ticket at http://www.wowace.com/addons/arl/tickets/ with a descriptive heading about the problem.  In the ticket make sure you include the error message that you received (just the error message, I don't need a listing of the addons you use), the recipe/profession you were working with, and any other info that you think may help.
When posting a bug report, do NOT include all of the addons from swatter.  This just makes it difficult to read.  If you want a good error reporting mod, get BugSack.  Do not post errors/missing recipes in the comments, or send them to me via a PM.  Post them as a ticket which I can address and track easily.]]
L["Common Issues"]		= true
L["COMMON_ISSUES_DESC"]		= [[Please refer to these common issues before submitting a bug report.
1) Recipe X does not show up! - Check your filter settings to make sure that the recipe is not being filtered.
2) Inscription is missing so many glyphs! Why aren't they listed?  Turn off your 'classes' filter.  By default (and due to popular request) ARL will only show recipes which your class can use and most glyphs are not usable by your class.
3) I don't want to see opposite faction recipes! Turn on the factions filter.  This will set it up to only display your factions obtainable recipes.  If something still shows up and it shouldn't, please submit a bug report.]]
L["Exclusion Issues"]		= true
L["EXCLUSION_ISSUES_DESC"]	= "To add a recipe to the exclusion (ignore) list, just alt-click on it from the recipe window.  To get this recipe back, open up the ARL options and set the toggle of \"Show Excluded Recipes\" to be on.  This will show all the recipes you've excluded in your scan during your next scan.  Once you have done this, Alt Click on the recipe again to remove it from the exclusion list."
L["Map Issues"]			= true
L["MAP_ISSUES_DESC"]		= "ARL relies on TomTom to add icons and waypoints to the World Map and the Mini-map.  You can customize these by going to the ARL configuration menu and scrolling to the display options.  If you do not have TomTom installed, nothing will be added.  Auto-adding icons is disabled by default."
L["Game Commands"]		= true
L["GAME_COMMANDS_DESC"]		= [[Command Line:
Ackis Recipe List has recently changed to use a GUI for change parameters.  Type /arl to open up the GUI.  Acceptable commands include:
- /arl about
  Opens up the about panel, listing information about the mod.
- /arl sort or /arl sorting
  Opens up the sorting options.
- /arl documentation
  Opens up in-game documentation regarding ARL.
- /arl display
  Opens up display options.
- /arl profile
  Opens up profile options.
- /arl filter
  Opens up filtering options.
- /arl scan
  Performs a scan for missing recipes.  This is in place for those times when you cannot access the scan button.

Clicking:
Ackis Recipe List will behave differently depending on which modifying keys you use to click.

Scan Button:
This is the functionality that occurs when you are clicking the scan button.

- Normal Click
  Performs a scan of the current tradeskill displaying recipes in a new window.
- Shift Click
  Generates a text dumping of the current tradeskill in CSV format.
- Alt Click
  Removes all waypoints on the World Map and Mini-map generated by ARL.

Recipe:
This is the functionality that occurs when you click on a recipe.

- Normal Click
  Expands or contracts the recipe acquire information.
- Shift Click
  Generates an item link of the item that the recipe will make into your default chat box.
- Ctrl Click
  Generates a spell link for the recipe you clicked.
- Alt Click
  Adds or removes a recipe from the exclusion list.
- Ctrl-Shift Click
  Adds the specific recipe acquire methods to the World Map and Mini-map.]]

-- Config UI Elements and their associated descriptions
L["Include Filtered"]		= true
L["FILTERCOUNT_DESC"]		= "Include filtered recipes in the count of total recipes."
L["Include Excluded"]		= true
L["EXCLUDECOUNT_DESC"]		= "Include excluded recipes in the count of total recipes."
L["Close GUI"]			= "Close with Tradeskill UI"
L["CLOSEGUI_DESC"]		= "Close the ARL window when the crafting window is closed."
L["Display Exclusions"]		= true
L["DISPLAY_EXCLUSION_DESC"]	= "Display recipes that are in the exclusion list."
L["Reset Window Position"]	= true
L["RESET_WINDOW_DESC"]		= "Resets the ARL GUI to default position."
L["UI_SCALE_DESC"]		= "Changes the scale of the UI. Ranges from .5 to 1.5 (1 is default)"
L["Tooltip Scale"]		= true
L["TOOLTIP_SCALE_DESC"]		= "Changes the scale of the ARL tooltip. Ranges from .5 to 1.5 (.9 is default)"
L["Tooltip (Recipe) Position"]	= true
L["SPELLTOOLTIPPOSITION_DESC"]	= "Changes the location of the tooltip containing the recipe information."
L["Tooltip (Acquire) Position"]	= true
L["ACQUIRETOOLTIPPOSITION_DESC"] = "Changes the location of the tooltip containing the acquire information."
L["FONT_SIZE_DESC"]		= "Changes the size of the fonts for ARL."
L["Sorting"]			= true
L["Sort"]			= true
L["SORTING_DESC"]		= "Change the way in which displayed recipes are sorted."
L["TOOLTIP_OPTIONS_DESC"]	= "Allows you to specify how the tooltips for ARL behave.  The acquire tooltip lists the different information on how to acquire the recipe, whereas the spell tooltip lists the recipe information itself."
L["MAP_OPTIONS_DESC"]		= "Allows you to change how ARL integrates into the world map and into the mini-map."
L["Right"]			= true
L["Left"]			= true
L["Top"]			= true
L["Bottom"]			= true
L["Top Right"]			= true
L["Top Left"]			= true
L["Bottom Right"]		= true
L["Bottom Left"]		= true
L["Skill (Asc)"]		= true
L["Skill (Desc)"]		= true
L["Location"]			= true
L["Acquisition"]		= true
L["Unhandled Recipe"]		= true
L["Mini Map"]			= true
L["WORLDMAP_DESC"]		= "Do you want missing vendor recipes to appear on the world map."
L["MINIMAP_DESC"]		= "Do you want missing vendor recipes to appear on the mini map."
L["Clear Waypoints"]		= true
L["CLEAR_WAYPOINTS_DESC"]	= "Remove all ARL waypoints from TomTom."
L["Hide Pop-Up"]		= true
L["HIDEPOPUP_DESC"]		= "Prevents pop-ups notifying you why the scan window is empty from showing.  Pop-ups will always show for the first time after a new version has been added."
L["Auto Scan Map"]		= true
L["AUTOSCANMAP_DESC"]		= "Auto show all waypoints when doing a recipe scan."
L["MAP_TRAINER_DESC"]		= "Display trainers on the map."
L["MAP_VENDOR_DESC"]		= "Display vendors on the map."
L["MAP_MONSTER_DESC"]		= "Display monsters on the map."
L["MAP_QUEST_DESC"]		= "Display quests on the map."

-- Filter Config Options
L["Filtering Options"]		= true
L["Obtain"]			= true
L["Binding"]			= true
L["Item"]			= true
L["Weapon"]			= true

-- Filter Configuration Descriptions
L["FILTERING_OPTIONS_DESC"]					= "Allows you to customize which recipes are filtered."
L["General Filtering Options"]				= true
L["FILTERING_GENERAL_DESC"]					= "Configuration for several more general filter types."
L["Obtain Filtering Options"]				= true
L["FILTERING_OBTAIN_DESC"]					= "Configuration for which methods of obtaining recipes are included in the scan."
L["Binding Filtering Options"]				= true
L["FILTERING_BINDING_DESC"]					= "Configuration for which types of binding are included in the scan."
L["Item Filtering Options"]					= true
L["FILTERING_ITEM_DESC"]					= "Configuration for which item types are included in the scan."
L["Armor Filtering Options"]				= true
L["FILTERING_Armor_DESC"]					= "Configuration for which types of armor are included in the scan."
L["Weapon Filtering Options"]				= true
L["FILTERING_WEAPONS_DESC"]					= "Configuration for which types of weapons are included in the scan."
L["Player Type Filtering Options"]			= true
L["FILTERING_PLAYERTYPE_DESC"]				= "Configuration for items matching which player types are included in the scan."
L["Reputation Filtering Options"]			= true
L["FILTERING_REP_DESC"]						= "Configuration for which reputation reward recipes are included in the scan."
L["Old World Rep. Filtering Options"]		= true
L["FILTERING_OLDWORLD_DESC"]				= "Configuration for which Old World Reputation reward recipes are included in the scan."
L["Burning Crusade Rep. Filtering Options"]	= true
L["FILTERING_BC_DESC"]						= "Configuration for which Burning Crusade Reputation reward recipes are included in the scan."
L["Lich King Rep. Filtering Options"]		= true
L["FILTERING_WOTLK_DESC"]					= "Configuration for which Wrath of the Lich King Reputation reward recipes are included in the scan."
L["REP_TEXT_DESC"]							= [[Left-click here to select all reputation filters.
Right-click here to deselect all reputation filters.]]
L["FILTERING_MISC_DESC"]					= "Configuration for miscellaneous options which are also present in the display options."
L["ORIGINAL_WOW_DESC"] = "Recipes available with the original game."
L["BC_WOW_DESC"] = "Recipes available with The Burning Crusade."
L["LK_WOW_DESC"] = "Recipes available with Wrath of the Lich King."
L["Alt-Tradeskills"] = true
L["ALT_TRADESKILL_DESC"] = "This will display a list of alts which have had trade skills scanned.  Clicking on the alt's name will output the tradeskill to chat."
L["Other Realms"] = true

-- General Filter UI Elements and their associated descriptions
L["FACTION_DESC"]			= "Include both horde and alliance faction recipes in the scan."
L["Classes"]				= true
L["CLASS_DESC"]				= "Include this class in the scan.  This will filter on two factors: 1) Can the class use the recipe and 2) can the class learn the recipe."
L["CLASS_TEXT_DESC"]		= [[Left-click here to select all classes.
Right-click here to select your own class.]]
L["Specialties"]			= true
L["SPECIALTY_DESC"]			= "Include all trade-skill specialties in the scan."
L["SKILL_DESC"]				= "Include all recipes in the scan, regardless of your current skill level."
L["Show Known"]				= true
L["KNOWN_DESC"]				= "Include all known recipes in the scan."
L["Show Unknown"]			= true
L["UNKNOWN_DESC"]			= "Include all unknown recipes in the scan."

-- Obtain Filter UI Elements and their associated descriptions
L["INSTANCE_DESC"]			= "Recipes obtained from (5 man) instances should be included in the scan."
L["RAID_DESC"]				= "Recipes obtained in raids (ie: Molten Core, Serpent Shrine Cavern, etc.) should be included in the scan."
L["Quest"]				= true
L["QUEST_DESC"]				= "Recipes obtained as quest rewards should be included in the scan."
L["SEASONAL_DESC"]			= "Recipes obtained in world events should be included in the scan."
L["Trainer"]				= true
L["TRAINER_DESC"]			= "Recipes learned from trainers should be included in the scan."
L["Vendor"]					= true
L["VENDOR_DESC"]			= "Recipes purchased from vendors should be included in the scan."
L["PVP_DESC"]				= "Recipes obtained through PVP should be included in the scan."
L["Discovery"]				= true
L["DISCOVERY_DESC"]			= "Recipes obtained through Discovery should be included in the scan."
L["World Drop"]				= true
L["WORLD_DROP_DESC"]			= "Recipes that are World Drops should be included in the scan."
L["Mob Drop"]				= true
L["MOB_DROP_DESC"]			= "Recipes that are Mob Drops should be included in the scan."

-- Binding Filter UI Elements and their associated descriptions
L["BOEFilter"]				= "Item Bind on Equip"
L["BOE_DESC"]				= "Recipes that make Bind on Equip items should be included in the scan."
L["BOPFilter"]				= "Item Bind on Pickup"
L["BOP_DESC"]				= "Recipes that make Bind on Pickup items should be included in the scan."
L["BOAFilter"]				= "Item Bind to Account"
L["BOA_DESC"]				= "Recipes that make Bind to Account items should be included in the scan."
L["RecipeBOEFilter"]		= "Recipe Bind on Equip"
L["RECIPE_BOE_DESC"]		= "Recipes that are Bind on Equip should be included in the scan."
L["RecipeBOPFilter"]		= "Recipe Bind on Pickup"
L["RECIPE_BOP_DESC"]		= "Recipes that are Bind on Pickup should be included in the scan."
L["RecipeBOAFilter"]		= "Recipe Bind to Account"
L["RECIPE_BOA_DESC"]		= "Recipes that are Bind to Account should be included in the scan."

-- Item - Armor UI Elements and their associated descriptions
L["ARMOR_TEXT_DESC"]		= [[Left-click here to select all armor filters.
Right-click here to deselect all armor filters.]]
L["Cloth"]				= true
L["CLOTH_DESC"]				= "Recipes that make cloth items should be included in the scan."
L["Leather"]				= true
L["LEATHER_DESC"]			= "Recipes that make leather items should be included in the scan."
L["Mail"]					= true
L["MAIL_DESC"]				= "Recipes that make mail items should be included in the scan."
L["Plate"]					= true
L["PLATE_DESC"]				= "Recipes that make plate items should be included in the scan."
L["Cloak"]					= true
L["CLOAK_DESC"]				= "Recipes that make cloaks should be included in the scan."
L["Ring"]					= true
L["RING_DESC"]				= "Recipes that make rings should be included in the scan."
L["Trinket"]				= true
L["TRINKET_DESC"]			= "Recipes that make trinkets should be included in the scan."
L["Necklace"]				= true
L["NECKLACE_DESC"]			= "Recipes that make necklaces should be included in the scan."
L["Shield"]					= true
L["SHIELD_DESC"]			= "Recipes that make shields should be included in the scan."

-- Item - Weapon UI Elements and their associated descriptions
L["WEAPON_TEXT_DESC"]		= [[Left-click here to select all weapon filters.
Right-click here to deselect all weapon filters.]]
L["One Hand"]				= true
L["ONEHAND_DESC"]			= "Recipes that make one handed items should be included in the scan."
L["Two Hand"]				= true
L["TWOHAND_DESC"]			= "Recipes that make two handed items should be included in the scan."
L["Axe"]					= true
L["AXE_DESC"]				= "Recipes that make axes should be included in the scan."
L["Sword"]					= true
L["SWORD_DESC"]				= "Recipes that make swords should be included in the scan."
L["Mace"]					= true
L["MACE_DESC"]				= "Recipes that make maces should be included in the scan."
L["Polearm"]				= true
L["POLEARM_DESC"]			= "Recipes that make polearms should be included in the scan."
L["Dagger"]					= true
L["DAGGER_DESC"]			= "Recipes that make daggers should be included in the scan."
L["Fist"]					= true
L["FIST_DESC"]				= "Recipes that make fist weapons should be included in the scan."
L["Staff"]					= true
L["STAFF_DESC"]				= "Recipes that make stave's should be included in the scan."
L["Wand"]					= true
L["WAND_DESC"]				= "Recipes that make wands should be included in the scan."
L["Thrown"]					= true
L["THROWN_DESC"]			= "Recipes that make thrown weapons should be included in the scan."
L["Bow"]					= true
L["BOW_DESC"]				= "Recipes that make bows should be included in the scan."
L["Crossbow"]				= true
L["CROSSBOW_DESC"]			= "Recipes that make crossbows should be included in the scan."
L["Ammo"]					= true
L["AMMO_DESC"]				= "Recipes that make ammunition should be included in the scan."
L["Gun"]					= true
L["GUN_DESC"]				= "Recipes that make guns should be included in the scan."

-- Player Type Filtering UI Elements and their associated descriptions
L["MELEE_DPS_DESC"]			= "Recipes that are used by melee dps players should be included in the scan."
L["TANKS_DESC"]				= "Recipes that are used by tank players should be included in the scan."
L["CASTER_DPS_DESC"]			= "Recipes that are used by casting dps players should be included in the scan."
L["HEALERS_DESC"]			= "Recipes that are used by healer players should be included in the scan."

-- Reputation Filtering UI Elements and their associated description
L["SPECIFIC_REP_DESC"]		= "Include %s faction."

-- ZJUI UI Elements (when different from the above ones) and their associated descriptions
L["FILTER_OPEN"]			= "Filter >>>"
L["FILTER_OPEN_DESC"]		= "Open filter option panel."
L["FILTER_CLOSE"]			= "<<< Filter"
L["FILTER_CLOSE_DESC"]		= "Close filter option panel."
L["EXPANDALL"]				= "+ All"
L["EXPANDALL_DESC"]			= "Expand all recipes listed below."
L["CONTRACTALL"]			= "- All"
L["CONTRACTALL_DESC"]		= "Minimize all recipes listed below."
L["SEARCH_DESC"]			= "Filter to recipes that contain text at left."
L["SEARCH_BOX_DESC"]		= "Enter search text"
L["CLEAR_DESC"]				= "Clear search text"
L["Close"]				= "Exit"
L["CLOSE_DESC"]				= "Close the Ackis Recipe List Window."
L["RESET_DESC"]				= "Reset All Filters to default values."
L["NOT_YET_SCANNED"]		= "Not yet scanned!"

-- Common Tool tip Strings (where different from above)
L["CTRL_CLICK"]			= "Ctrl-Click to add this recipe's link to your chat."
L["ALT_CLICK"]			= "Alt-Click to add/remove this recipe to your ignore list."
L["SHIFT_CLICK"]		= "Shift-Click to add the item crafted by this recipe's link to your chat."
L["CTRL_SHIFT_CLICK"]	= "Ctrl-Shift-Click to add the item to the map and mini-map."
L["Obtained From"]		= true
L["RECIPE_EXCLUDED"]	= "Recipe is in Exclusion list"
L["Required Skill"]		= true

--Dataminer Strings
L["DATAMINER_SKILLELVEL"] = [[Recipe level different!
    Name: %s
	ARL Level: %s
	Trainer Level: %s]]
L["DATAMINER_SKILLLEVEL_ERROR"] = "This can only be used for a trade skill trainer.  Please open up the trainer and try again."
L["DATAMINER_TRAINER_NOTTARGETTED"] = "You must target the trainer when you run this command."
L["DATAMINER_VENDOR_NOTTARGETTED"] = "You must target the vendor when you run this command."
L["DATAMINER_TRAINER_INFO"] = [[Trainer Name: %s
Trainer ID: %s]]
L["DATAMINER_TRAINER_TEACH"] = "%s (%s) - Missing"
L["DATAMINER_TRAINER_NOTTEACH"] = "%s (%s) - Extra"
L["Auto Scan Trainers"] = true
L["Datamine Options"] = true
L["DATAMINE_OPTIONS_DESC"] = "Allows you to customize in-game ARL datamining."
L["AUTOSCAN_TRAINERS_DESC"] = "Turns on scanning at trainers to compare skill levels, and recipe acquire methods."
L["Generate Tradeskill Links"] = true
L["GENERATE_LINKS_DESC"] = "Generate complete profession links."
L["Compare Trainer Skills"] = true
L["COMPARE_TRAINER_SKILL_DESC"] = "Compare skill levels of selected trainer with those in ARL database."
L["Compare Trainer Acquire"] = true
L["COMPARE_TRAINER_ACQUIRE_DESC"] = "Compare selected trainer acquire methods with those in the ARL database."
L["DATAMINER_NODB_ERROR"] = "Recipe database not loaded.  Please scan the tradeskill first then try the datamining."
L["AUTOLOAD_DB_DESC"] = "Automatically loads all of the ARL recipe databases when doing a datamining scan."
L["Auto Load Recipe Database"] = true
L["Scan Entire Database"] = true
L["SCAN_ENTIRE_DB_DESC"] = "Loads the entire recipe database, and scans every single recipes tooltip checking the flags.  This will lag your computer and use a lot of memory."
L["Scan Vendor"] = true
L["SCAN_VENDOR_DESC"] = "Scans the currently opened vendor for recipes and compares the information with the internal database."
L["Scan A Profession"] = true
L["SCAN_PROF_DB_DESC"] = "Scans a specified profession (lower case name or spell id) in the recipe database, scanning the tooltips and comparing them with the internal database."
L["Scan A Spell ID"] = true
L["SCAN_SPELL_ID_DESC"] = "Scans a specified spell ID, scanning its tooltip and comparing it with the internal database."
L["Auto Scan Vendors"] = true
L["AUTOSCAN_VENDORS_DESC"] = "Turns on scanning at vendors to compare skill levels, and recipe acquire methods."
L["DATAMINE_WARNING_DESC"] = "Please note that enabling Auto Load Recipe Database will increase the amount of memory used by ARL.  Enabling Auto Scan Trainers may cause a slight bit of lag when the trainer is opened.  This will be more noticeable on the first scan of a trainer."

-- Popup Strings
L["NOTSCANNED"]		= "You have not yet scanned this profession. Please open this profession and click on Scan."
L["ALL_FILTERED"]	= "Although you have already scanned this profession, your filters are currently preventing any recipes from being displayed. Please change your filters and try again."
L["ARL_ALLKNOWN"]	= "You know all the recipes for this profession."
L["ARL_ALLEXCLUDED"] = "Although you have already scanned this profession, your exclusions are currently preventing any recipes from being displayed. Please change your exclusions and try again."
L["ARL_SEARCHFILTERED"] = "Your search has no results."
L["NO_DISPLAY"] 	= "No recipes to display.  If you get this message please submit a ticket at http://www.wowace.com/addons/arl/tickets listing what filters you have, what is in your exclusion list, which profession, and the number of known/unknown recipes."

-- Error/warning Text
L["MissingFromDB"] = [[": is missing from the database.
Please inform the author of the add-on about this recipe."]]
L["UnknownTradeSkill"] = "You have opened up a trade skill window which is not supported by this add-on.  The trade skill is %s.  Please provide the author of the add-on with this information."
L["OpenTradeSkillWindow"] = "Please open trade skill window to scan."
L["SpellIDCache"] = "Spell ID: %s is not in your local cache.  Please submit a ticket at http://wow.curseforge.com/projects/ackis-recipe-list/tickets/ and include the spell ID and the profession in which you were scanning."
L["NoItemLink"] = "This item does not have an item link or it was not in your cache."
L["MISSING_LIBRARY"] = "%s is missing.  Addon cannot run."

-- Drop Obtain Info
L["Unknown Zone"] = true

-- Custom database strings:
-- Alchemy Discoveries
L["DISCOVERY_ALCH_ELIXIRFLASK"] = "Discovered by making elixirs or flasks using Burning Crusade or higher ingredients."
L["DISCOVERY_ALCH_POTION"] = "Discovered by making potions using Burning Crusade or higher ingredients."
L["DISCOVERY_ALCH_XMUTE"] = "Discovered by doing transmutes using Burning Crusade or higher ingredients."
L["DISCOVERY_ALCH_PROT"] = "Discovered by Major Protection Potions using Burning Crusade or higher ingredients."
L["DISCOVERY_ALCH_WRATH"] = "Discovered by doing transmutes using Wrath of the Lich King ingredients."
L["DISCOVERY_ALCH_NORTHREND_RESEARCH"] = "Obtained randomly by conducting Northrend alchemy research."
L["DISCOVERY_ALCH_NORTHREND_XMUTE"] = "Discovered by doing transmutes using Northrend or higher ingredients (transmute tooltip mentions that there is a chance to discovery something)."
-- Inscription Discoveries
L["DISCOVERY_INSC_MINOR"] = "Obtained randomly by conducting minor inscription research."
L["DISCOVERY_INSC_NORTHREND"] = "Obtained randomly by conducting Northrend inscription research."
L["DISCOVERY_INSC_BOOK"] = "Discovered randomly by reading the Book of Glyph Mastery."
-- Cooking/Fishing Daily Quests
L["DAILY_COOKING_MEAT"] = "Randomly obtained by completing the cooking daily quest in Shattrath and selecting the meat crate."
L["DAILY_COOKING_FISH"] = "Randomly obtained by completing the cooking daily quest in Shattrath and selecting the fish barrel."
L["DAILY_FISHING_SHATT"] = "Randomly obtained by completing the fishing daily quest in Shattrath."
L["DAILY_COOKING_DAL"] = "Randomly obtained by completing the cooking daily quest in Dalaran."
-- Engineering Related
L["ENG_GNOMER"] = "Dropped from mobs in Gnomeregan."
L["ENG_FLOOR_ITEM_BRD"] = "The schematic can be found on the floor near Golem Lord Argelmach in Blackrock Depths. Only engineers with 300 skill may learn the schematic after clicking on it."
L["GOBLIN_ENG"] = "You need to be a Goblin Engineer to obtain and use this item."
L["GNOMISH_ENG"] = "You need to be a Gnomish Engineer to obtain and use this item." 
-- Default
L["DEFAULT_RECIPE"] = "Learned by default when learning the profession."
-- Crafted by other professions
L["CRAFTED_ENGINEERS"] = "Recipe is created by Engineers."
-- Instances
L["HENRY_STERN_RFD"] = "Obtained by talking to Henry Stern in Razorfen Downs."
L["DM_CACHE"] = "Randomly obtained in Dire Maul (North) in Knot Thimblejack's cache."
L["BRD_RANDOM_ROOM"] = "There is a chance that you will find it in 5 different rooms in blackrock depths, it is a random spawn though, and sometimes it doesn't even spawn at all."
L["SCHOLO_BOOK_SPAWN"] = "After you kill Jandice Barov in Scholomance, a book spawns that let's you learn this recipe"
L["STRATH_BS_PLANS"] = "Blacksmith plans in Stratholme" -- Update
L["DM_TRIBUTE"] = "DM Tribute Run - Chest" -- Update
L["WORLD_DRAGONS"] = "World Dragons" -- Update
-- Quests
L["ONYXIA_HEAD_QUEST"] = "Quest to obtain the recipe opens up after turning in the Head of Onyxia."
L["EDGE_OF_MADNESS"] = "Obtained by clicking on a tablet in Zul'Gurub in the Edge of Madness."
-- Raids
L["AQ40_RANDOM_BOP"] = "Random BoP drop off of bosses in AQ40."
L["SUNWELL_RANDOM"] = "Random Sunwell trash drop."
L["MC_RANDOM"] = "Random drop off of Molten Core bosses."
L["HYJAL_RANDOM"] = "Random drop from Hyjal Summit trash/bosses."
L["BT_RANDOM"] = "Random drop from Black Temple trash/bosses."
L["ZA_RANDOM"] = "Random drop off of Zul'Aman bosses."
L["SSC_RANDOM"] = "Random drop from mobs in Serpentshrine Cavern."
L["TK_RANDOM"] = "Random drop from mobs in Tempest Keep: The Eye."
L["ULDUAR_RANDOM"] = "Random drop off of Ulduar bosses."
L["TOC25_RANDOM"] = "Random drop from the Trial of the Crusader, 25 man normal version."

L["Custom35"] = "Drops from dragons in Ogri'la and Blade's Edge Mountains Summon Bosses"
L["Custom36"] = "From a NPC in Dalaran sewers after doing The Taste Test" -- Update
L["Custom41"] = "Removed from the game when Naxx 40 was taken out."

-- Monster/Quest/Trainer/Vendor strings:

-- Do not translate anything below this line without talking to Ackis first please.

L["\"Cookie\" McWeaksauce"] = true
L["Aaron Hollman"] = true
L["Aayndia Floralwind"] = true
L["Abigail Shiel"] = true
L["Abyssal Flamebringer"] = true
L["Adele Fielder"] = true
L["Adelene Sunlance"] = true
L["Aendel Windspear"] = true
L["Aged Dalaran Wizard"] = true
L["Ainderu Summerleaf"] = true
L["Ainethil"] = true
L["Akham"] = true
L["Alanna Raveneye"] = true
L["Alard Schmied"] = true
L["Alchemist Finklestein"] = true
L["Alchemist Gribble"] = true
L["Alchemist Kanhu"] = true
L["Alchemist Mallory"] = true
L["Alchemist Narett"] = true
L["Alchemist Pestlezugg"] = true
L["Aldraan"] = true
L["Alegorn"] = true
L["Aleinia"] = true
L["Alestos"] = true
L["Alestus"] = true
L["Alexandra Bolero"] = true
L["Alexandra McQueen"] = true
L["Alexis Marlowe"] = true
L["Algernon"] = true
L["Almaador"] = true
L["Altaa"] = true
L["Alurmi"] = true
L["Alys Vol'tyr"] = true
L["Amal'thazad"] = true
L["Amy Davenport"] = true
L["Anchorite Ensham"] = true
L["Anchorite Fateema"] = true
L["Anchorite Paetheus"] = true
L["Anchorite Yazmina"] = true
L["Andellion"] = true
L["Andre Firebeard"] = true
L["Andrew Hilbert"] = true
L["Andrion Darkspinner"] = true
L["Androd Fadran"] = true
L["Anger Guard"] = true
L["Anguished Highborne"] = true
L["Annora"] = true
L["Anuur"] = true
L["Anvilrage Captain"] = true
L["Anvilrage Marshal"] = true
L["Apothecary Antonivich"] = true
L["Apothecary Bressa"] = true
L["Apothecary Wormwick"] = true
L["Apprentice Darius"] = true
L["Arathel Sunforge"] = true
L["Arcanist Sheynathren"] = true
L["Arcatraz Sentinel"] = true
L["Archmage Alvareaux"] = true
L["Are We There, Yeti?"] = true
L["Aresella"] = true
L["Argent Quartermaster Hasana"] = true
L["Argent Quartermaster Lightspark"] = true
L["Argo Strongstout"] = true
L["Arkkoran Oracle"] = true
L["Arnok"] = true
L["Arras"] = true
L["Arred"] = true
L["Arrond"] = true
L["Arthur Denny"] = true
L["Arthur Henslowe"] = true
L["Arthur Moore"] = true
L["Artificer Daelo"] = true
L["Asarnan"] = true
L["Ashtongue Warrior"] = true
L["Aska Mistrunner"] = true
L["Auchenai Monk"] = true
L["Awan Iceborn"] = true
L["Awilo Lon'gomba"] = true
L["Bale"] = true
L["Balgaras the Foul"] = true
L["Banalash"] = true
L["Barien"] = true
L["Barim Spilthoof"] = true
L["Bash'ir Spell-Thief"] = true
L["Baxter"] = true
L["Belil"] = true
L["Bemarrin"] = true
L["Bena Winterhoof"] = true
L["Bengus Deepforge"] = true
L["Benjamin Clegg"] = true
L["Bernadette Dexter"] = true
L["Bethany Cromwell"] = true
L["Binkie Brightgear"] = true
L["Blackened Ancient"] = true
L["Blackhand Elite"] = true
L["Blackrock Battlemaster"] = true
L["Blackrock Slayer"] = true
L["Blackrock Soldier"] = true
L["Blacksmith Calypso"] = true
L["Blackwater Deckhand"] = true
L["Blimo Gadgetspring"] = true
L["Blizrik Buckshot"] = true
L["Bliztik"] = true
L["Bloodmaul Geomancer"] = true
L["Bloodsail Raider"] = true
L["Bombus Finespindle"] = true
L["Bonechewer Backbreaker"] = true
L["Booker Kells"] = true
L["Borgosh Corebender"] = true
L["Borgus Steelhand"] = true
L["Borto"] = true
L["Borus Ironbender"] = true
L["Borya"] = true
L["Boulderfist Warrior"] = true
L["Bowen Brisboise"] = true
L["Bradley Towns"] = true
L["Braeg Stoutbeard"] = true
L["Brandig"] = true
L["Brawn"] = true
L["Brek Stonehoof"] = true
L["Brienna Starglow"] = true
L["Brikk Keencraft"] = true
L["Bro'kin"] = true
L["Brock Stoneseeker"] = true
L["Brom Brewbaster"] = true
L["Brom Killian"] = true
L["Bronk"] = true
L["Bronk Guzzlegear"] = true
L["Brumman"] = true
L["Brumn Winterhoof"] = true
L["Brunna Ironaxe"] = true
L["Bryan Landers"] = true
L["Brynna Wilson"] = true
L["Burbik Gearspanner"] = true
L["Burko"] = true
L["Buzzek Bracketswing"] = true
L["Byancie"] = true
L["Cabal Fanatic"] = true
L["Camberon"] = true
L["Captain Halyndor"] = true
L["Captain O'Neal"] = true
L["Captured Gnome"] = true
L["Carolai Anise"] = true
L["Carter Tiffens"] = true
L["Caryssia Moonhunter"] = true
L["Catarina Stanford"] = true
L["Catherine Leland"] = true
L["Celie Steelwing"] = true
L["Charles Worth"] = true
L["Charred Ancient"] = true
L["Chaw Stronghide"] = true
L["Chief Engineer Leveny"] = true
L["Christoph Jeffcoat"] = true
L["Cielstrasza"] = true
L["Clarise Gnarltree"] = true
L["Cliff Breaker"] = true
L["Cloned Ooze"] = true
L["Clyde Ranthal"] = true
L["Cobalt Mageweaver"] = true
L["Coilfang Oracle"] = true
L["Coilfang Sorceress"] = true
L["Coilskar Siren"] = true
L["Constance Brisboise"] = true
L["Cook Ghilm"] = true
L["Cookie One-Eye"] = true
L["Coreiel"] = true
L["Corporal Bluth"] = true
L["Cowardly Crosby"] = true
L["Crazed Ancient"] = true
L["Crazed Murkblood Foreman"] = true
L["Crazed Murkblood Miner"] = true
L["Crazk Sparks"] = true
L["Crimson Inquisitor"] = true
L["Crimson Sorcerer"] = true
L["Cro Threadstrong"] = true
L["Crog Steelspine"] = true
L["Crystal Boughman"] = true
L["Crystal Brightspark"] = true
L["Cult Alchemist"] = true
L["Cult Researcher"] = true
L["Cultist Shard Watcher"] = true
L["Cyndra Kindwhisper"] = true
L["Daedal"] = true
L["Daenril"] = true
L["Daga Ramba"] = true
L["Daggle Ironshaper"] = true
L["Dalinna"] = true
L["Dalria"] = true
L["Damned Apothecary"] = true
L["Daniel Bartlett"] = true
L["Danielle Zipstitch"] = true
L["Dank Drizzlecut"] = true
L["Dannelor"] = true
L["Danwe"] = true
L["Darin Goodstitch"] = true
L["Dark Adept"] = true
L["Dark Conclave Shadowmancer"] = true
L["Dark Iron Demolitionist"] = true
L["Dark Iron Dwarf"] = true
L["Dark Iron Saboteur"] = true
L["Dark Iron Slaver"] = true
L["Dark Iron Taskmaster"] = true
L["Dark Iron Tunneler"] = true
L["Dark Iron Watchman"] = true
L["Dark Strand Voidcaller"] = true
L["Darkmoon Faire"] = true
L["Darmari"] = true
L["Darnall"] = true
L["Daryl Riknussun"] = true
L["Daryl Stack"] = true
L["Day of the Dead"] = true
L["Deadwind Warlock"] = true
L["Deadwood Shaman"] = true
L["Dealer Malij"] = true
L["Deathforge Guardian"] = true
L["Deathforge Imp"] = true
L["Deathforge Smith"] = true
L["Deathforge Tinkerer"] = true
L["Decaying Horror"] = true
L["Deek Fizzlebizz"] = true
L["Defias Enchanter"] = true
L["Defias Looter"] = true
L["Defias Pirate"] = true
L["Defias Profiteer"] = true
L["Defias Renegade Mage"] = true
L["Defias Squallshaper"] = true
L["Delfrum Flintbeard"] = true
L["Deneb Walker"] = true
L["Derak Nightfall"] = true
L["Derek Odds"] = true
L["Deynna"] = true
L["Diane Cannings"] = true
L["Didi the Wrench"] = true
L["Dirge Quikcleave"] = true
L["Disembodied Protector"] = true
L["Disembodied Vindicator"] = true
L["Doba"] = true
L["Doctor Gregory Victor"] = true
L["Doctor Gustaf VanHowzen"] = true
L["Doctor Herbert Halsey"] = true
L["Don Carlos"] = true
L["Doomforge Craftsman"] = true
L["Doomforge Engineer"] = true
L["Drac Roughcut"] = true
L["Drake Lindgren"] = true
L["Drakk Stonehand"] = true
L["Drovnar Strongbrew"] = true
L["Duchess Mynx"] = true
L["Duhng"] = true
L["Dulvi"] = true
L["Durnholde Rifleman"] = true
L["Dustin Vail"] = true
L["Dwukk"] = true
L["Eclipsion Archmage"] = true
L["Eclipsion Blood Knight"] = true
L["Eclipsion Bloodwarder"] = true
L["Eclipsion Cavalier"] = true
L["Eclipsion Centurion"] = true
L["Eclipsion Soldier"] = true
L["Eclipsion Spellbinder"] = true
L["Edna Mullby"] = true
L["Eebee Jinglepocket"] = true
L["Egomis"] = true
L["Eiin"] = true
L["Eldara Dawnrunner"] = true
L["Eldrin"] = true
L["Elise Brightletter"] = true
L["Elizabeth Jackson"] = true
L["Elynna"] = true
L["Emil Autumn"] = true
L["Emrul Riknussun"] = true
L["Enchanter Nalthanis"] = true
L["Enchantress Volali"] = true
L["Engineer Sinbei"] = true
L["Enraged Mammoth"] = true
L["Enraged Earth Spirit"] = true
L["Enraged Water Spirit"] = true
L["Enraged Air Spirit"] = true
L["Enraged Fire Spirit"] = true
L["Eorain Dawnstrike"] = true
L["Eredar Deathbringer"] = true
L["Eriden"] = true
L["Erika Tate"] = true
L["Erilia"] = true
L["Erin Kelly"] = true
L["Ethereal Priest"] = true
L["Ethereum Jailor"] = true
L["Ethereum Nullifier"] = true
L["Eunice Burch"] = true
L["Fael Morningsong"] = true
L["Falorn Nightwhisper"] = true
L["Fariel Starsong"] = true
L["Farii"] = true
L["Fazu"] = true
L["Fedryen Swiftspear"] = true
L["Feera"] = true
L["Felannia"] = true
L["Felicia Doan"] = true
L["Felika"] = true
L["Fendrig Redbeard"] = true
L["Fera Palerunner"] = true
L["Festive Recipes"] = true
L["Feyden Darkin"] = true
L["Fimble Finespindle"] = true
L["Finbus Geargrind"] = true
L["Findle Whistlesteam"] = true
L["Firebrand Grunt"] = true
L["Firebrand Invoker"] = true
L["Firebrand Legionnaire"] = true
L["Firebrand Pyromancer"] = true
L["Firegut Brute"] = true
L["Fono"]= true
L["Foreman Marcrid"] = true
L["Fradd Swiftgear"] = true
L["Franklin Lloyd"] = true
L["Fremal Doohickey"] = true
L["Frostbrood Spawn"] = true
L["Frostfeather Screecher"] = true
L["Frostfeather Witch"] = true
L["Frostmaul Giant"] = true
L["Fyldan"] = true
L["Gagsprocket"] = true
L["Gambarinka"] = true
L["Gan'arg Analyzer"] = true
L["Gara Skullcrush"] = true
L["Gargantuan Abyssal"] = true
L["Gaston"] = true
L["Gearcutter Cogspinner"] = true
L["Geba'li"] = true
L["Geen"] = true
L["Gelanthis"] = true
L["Gelman Stonehand"] = true
L["Geofram Bouldertoe"] = true
L["George Candarte"] = true
L["Georgio Bolero"] = true
L["Ghak Healtouch"] = true
L["Gharash"] = true
L["Gidge Spellweaver"] = true
L["Gigget Zipcoil"] = true
L["Gikkix"] = true
L["Gimble Thistlefuzz"] = true
L["Gina MacGregor"] = true
L["Gloria Femmel"] = true
L["Glutinous Ooze"] = true
L["Glyx Brewright"] = true
L["Gnaz Blunderflame"] = true
L["Godan"] = true
L["Goli Krumn"] = true
L["Gordunni Back-Breaker"] = true
L["Gordunni Elementalist"] = true
L["Gordunni Head-Splitter"] = true
L["Gordunni Soulreaper"] = true
L["Grarnik Goodstitch"] = true
L["Great-father Winter's Helper"] = true
L["Greatfather Winter"] = true
L["Gremlock Pilsnor"] = true
L["Gretta Ganter"] = true
L["Grikka"] = true
L["Grimtak"] = true
L["Grimtotem Geomancer"] = true
L["Grondal Moonbreeze"] = true
L["Grumbol Stoutpick"] = true
L["Grumnus Steelshaper"] = true
L["Grutah"] = true
L["Guillaume Sorouy"] = true
L["Gundrak Savage"] = true
L["Gunter Hansen"] = true
L["Haalrun"] = true
L["Haferet"] = true
L["Hagrus"] = true
L["Hahrana Ironhide"] = true
L["Hama"] = true
L["Hamanar"] = true
L["Hammered Patron"] = true
L["Hammon Karwn"] = true
L["Harggan"] = true
L["Harklan Moongrove"] = true
L["Harlown Darkweave"] = true
L["Harn Longcast"] = true
L["Haughty Modiste"] = true
L["Heldan Galesong"] = true
L["Helenia Olden"] = true
L["Hgarth"] = true
L["High Enchanter Bardolan"] = true
L["Highlord Darion Mograine"] = true
L["Hillsbrad Tailor"] = true
L["Himmik"] = true
L["Hotoppik Copperpinch"] = true
L["Hula'mahi"] = true
L["Humphry"] = true
L["Hurnak Grimmord"] = true
L["Ildine Sorrowspear"] = true
L["Illidari Watcher"] = true
L["Imindril Spearsong"] = true
L["Indormi"] = true
L["Indu'le Fisherman"] = true
L["Inessera"] = true
L["Innkeeper Biribi"] = true
L["Innkeeper Fizzgrimble"] = true
L["Innkeeper Grilka"] = true
L["Iron Rune-Shaper"] = true
L["Ironus Coldsteel"] = true
L["Ironwool Mammoth"] = true
L["Jabbey"] = true
L["Jack Trapper"] = true
L["Jadefire Rogue"] = true
L["Jalane Ayrole"] = true
L["James Van Brunt"] = true
L["Jamesina Watterly"] = true
L["Jandia"] = true
L["Janet Hommers"] = true
L["Jangdor Swiftstrider"] = true
L["Jannos Ironwill"] = true
L["Jaquilina Dramet"] = true
L["Jase Farlane"] = true
L["Jaxin Chong"] = true
L["Jazdalaad"] = true
L["Jazzrik"] = true
L["Jedidiah Handers"] = true
L["Jeeda"] = true
L["Jenna Lemkenilli"] = true
L["Jennabink Powerseam"] = true
L["Jessara Cordell"] = true
L["Jim Saltit"] = true
L["Jinky Twizzlefixxit"] = true
L["Jo'mah"] = true
L["Johan Barnes"] = true
L["Johan Focht"] = true
L["Jonathan Garrett"] = true
L["Jonathan Lewis"] = true
L["Jormund Stonebrow"] = true
L["Josef Gregorian"] = true
L["Joseph Moore"] = true
L["Joseph Wilson"] = true
L["Josephine Lister"] = true
L["Josric Fame"] = true
L["Jubie Gadgetspring"] = true
L["Jun'ha"] = true
L["Juno Dufrain"] = true
L["Timofey Oshenko"] = true
L["Jutak"] = true
L["K. Lee Smallfry"] = true
L["Kaita Deepforge"] = true
L["Kalaen"] = true
L["Kalinda"] = true
L["Kalldan Felmoon"] = true
L["Kanaria"] = true
L["Kania"] = true
L["Karaaz"] = true
L["Karn Stonehoof"] = true
L["Karolek"] = true
L["Katherine Lee"] = true
L["Keelen Sheets"] = true
L["Keena"] = true
L["Kelgruk Bloodaxe"] = true
L["Kelsey Yance"] = true
L["Kendor Kabonka"] = true
L["Khara Deepwater"] = true
L["Khole Jinglepocket"] = true
L["Kiknikle"] = true
L["Kil'hala"] = true
L["Killian Sanatha"] = true
L["Kilxx"] = true
L["Kireena"] = true
L["Kirembri Silvermane"] = true
L["Kithas"] = true
L["Kitta Firewind"] = true
L["Knaz Blunderflame"] = true
L["Knight Dameron"] = true
L["Kor'geld"] = true
L["Koren"] = true
L["Korim"] = true
L["Kradu Grimblade"] = true
L["Krek Cragcrush"] = true
L["Kriggon Talsone"] = true
L["Krinkle Goodsteel"] = true
L["Kristen Smythe"] = true
L["Krugosh"] = true
L["Krulmoo Fullmoon"] = true
L["Krunn"] = true
L["Kul'de"] = true
L["Kulwia"] = true
L["Kurdram Stonehammer"] = true
L["Kurzen Commando"] = true
L["Kylanna"] = true
L["Kylanna Windwhisper"] = true
L["Kylene"] = true
L["Kzixx"] = true
L["Lady Alistra"] = true
L["Lady Palanseer"] = true
L["Laird"] = true
L["Lalla Brightweave"] = true
L["Landraelanis"] = true
L["Lanolis Dewdrop"] = true
L["Larana Drome"] = true
L["Lardan"] = true
L["Lavinia Crowe"] = true
L["Lebowski"] = true
L["Leeli Longhaggle"] = true
L["Legashi Rogue"] = true
L["Leo Sarn"] = true
L["Leonard Porter"] = true
L["Librarian Erickson"] = true
L["Lieutenant General Andorov"] = true
L["Lillehoff"] = true
L["Lilliam Sparkspindle"] = true
L["Lilly"] = true
L["Lilyssia Nightbreeze"] = true
L["Lindea Rabonne"] = true
L["Linna Bruder"] = true
L["Linzy Blackbolt"] = true
L["Lizbeth Cromwell"] = true
L["Logannas"] = true
L["Logistics Officer Brighton"] = true
L["Logistics Officer Silverstone"] = true
L["Logistics Officer Ulrike"] = true
L["Lokhtos Darkbargainer"] = true
L["Loolruna"] = true
L["Lord Thorval"] = true
L["Lorelae Wintersong"] = true
L["Lorokeem"] = true
L["Lucan Cordell"] = true
L["Lucc"] = true
L["Lyna"] = true
L["Lynalis"] = true
L["Mack Diver"] = true
L["Madame Ruby"] = true
L["Magar"] = true
L["Mageslayer"] = true
L["Magistrix Eredania"] = true
L["Magnus Frostwake"] = true
L["Mahani"] = true
L["Mahu"] = true
L["Makaru"] = true
L["Mallen Swain"] = true
L["Malygen"] = true
L["Manfred Staller"] = true
L["Margaux Parchley"] = true
L["Mari Stonehand"] = true
L["Maria Lumere"] = true
L["Martine Tramblay"] = true
L["Mary Edras"] = true
L["Masat T'andr"] = true
L["Master Chef Mouldier"] = true
L["Master Craftsman Omarion"] = true
L["Master Elemental Shaper Krixix"] = true
L["Mathar G'ochar"] = true
L["Matt Johnson"] = true
L["Mavralyn"] = true
L["Mazk Snipeshot"] = true
L["Me'lynn"] = true
L["Meilosh"] = true
L["Melaris"] = true
L["Miall"] = true
L["Miao'zan"] = true
L["Micha Yance"] = true
L["Michael Schwan"] = true
L["Michelle Belle"] = true
L["Mildred Fletcher"] = true
L["Millie Gregorian"] = true
L["Mindri Dinkles"] = true
L["Mining"] = true
L["Miralisse"] = true
L["Mire Lord"] = true
L["Misensi"] = true
L["Mishta"] = true
L["Mixie Farshot"] = true
L["Mo'arg Weaponsmith"] = true
L["Modoru"] = true
L["Molt Thorn"] = true
L["Monster"] = true
L["Montarr"] = true
L["Moonrage Tailor"] = true
L["Moordo"] = true
L["Morgan Day"] = true
L["Mossflayer Shadowhunter"] = true
L["Muaat"] = true
L["Muculent Ooze"] = true
L["Mudduk"] = true
L["Muheru the Weaver"] = true
L["Mukdrak"] = true
L["Mumman"] = true
L["Murk Worm"] = true
L["Murkblood Raider"] = true
L["Muuran"] = true
L["Mycah"] = true
L["Mythrin'dir"] = true
L["Naal Mistrunner"] = true
L["Nadyia Maneweaver"] = true
L["Nahogg"] = true
L["Naka"] = true
L["Nakodu"] = true
L["Namdo Bizzfizzle"] = true
L["Namha Moonwater"] = true
L["Nandar Branson"] = true
L["Nardstrum Copperpinch"] = true
L["Narj Deepslice"] = true
L["Narkk"] = true
L["Narv Hidecrafter"] = true
L["Nascent Val'kyr"] = true
L["Nasmara Moonsong"] = true
L["Nata Dawnstrider"] = true
L["Neal Allen"] = true
L["Neferatti"] = true
L["Neii"] = true
L["Nemiha"] = true
L["Nergal"] = true
L["Nerrist"] = true
L["Nessa Shadowsong"] = true
L["Nexus Stalker"] = true
L["Nimar the Slayer"] = true
L["Nina Lightbrew"] = true
L["Niobe Whizzlespark"] = true
L["Nioma"] = true
L["Nissa Firestone"] = true
L["Nixx Sprocketspring"] = true
L["Nula the Butcher"] = true
L["Nurse Applewood"] = true
L["Nurse Neela"] = true
L["Nus"] = true
L["Nyoma"] = true
L["Ockil"] = true
L["Ogg'marr"] = true
L["Oglethorpe Obnoticus"] = true
L["Okothos Ironrager"] = true
L["Okuno"] = true
L["Olisarra the Kind"] = true
L["Oluros"] = true
L["Onodo"] = true
L["Onslaught Mason"] = true
L["Ontuvo"] = true
L["Orland Schaeffer"] = true
L["Orn Tenderhoof"] = true
L["Otho Moji'ko"] = true
L["Ounhulo"] = true
L["Outfitter Eric"] = true
L["Pand Stonebinder"] = true
L["Paulsta'ats"] = true
L["Penney Copperpinch"] = true
L["Peter Galen"] = true
L["Phantom Attendant"] = true
L["Phantom Stagehand"] = true
L["Phantom Valet"] = true
L["Phea"] = true
L["Pikkle"] = true
L["Plains Mammoth"] = true
L["Portal Seeker"] = true
L["Poshken Hardbinder"] = true
L["Pratt McGrubben"] = true
L["Primal Ooze"] = true
L["Professor Pallin"] = true
L["Prospector Khazgorm"] = true
L["Prospector Nachlan"] = true
L["Provisioner Lorkran"] = true
L["Provisioner Nasela"] = true
L["Pyall Silentstride"] = true
L["Pyrewood Tailor"] = true
L["Qia"] = true
L["Quarelestra"] = true
L["Quartermaster Davian Vaclav"] = true
L["Quartermaster Endarin"] = true
L["Quartermaster Enuril"] = true
L["Quartermaster Jaffrey Noreliqe"] = true
L["Quartermaster Miranda Breechlock"] = true
L["Quartermaster Urgronn"] = true
L["Quelis"] = true
L["Raenah"] = true
L["Raging Skeleton"] = true
L["Ranik"] = true
L["Rann Flamespinner"] = true
L["Rartar"] = true
L["Rathis Tomber"] = true
L["Rawrk"] = true
L["Recorder Lidio"] = true
L["Refik"] = true
L["Rekka the Hammer"] = true
L["Ribbly's Crony"] = true
L["Rift Keeper"] = true
L["Rift Lord"] = true
L["Rikqiz"] = true
L["Rin'wosho the Trader"] = true
L["Rizz Loosebolt"] = true
L["Rogvar"] = true
L["Rohok"] = true
L["Rollick MacKreel"] = true
L["Ronald Burch"] = true
L["Rosemary Bovard"] = true
L["Rosina Rivet"] = true
L["Rotting Behemoth"] = true
L["Roxxik"] = true
L["Rungor"] = true
L["Ruppo Zipcoil"] = true
L["Saenorion"] = true
L["Sairuk"] = true
L["Sally Tompkins"] = true
L["Sarah Tanner"] = true
L["Saru Steelfury"] = true
L["Sassa Weldwell"] = true
L["Sathein"] = true
L["Scargil"] = true
L["Scarlet Archmage"] = true
L["Scarlet Cavalier"] = true
L["Scarlet Smith"] = true
L["Scarlet Spellbinder"] = true
L["Scholomance Adept"] = true
L["Sock Brightbolt"] = true
L["Se'Jib"] = true
L["Sebastian Crane"] = true
L["Sedana"] = true
L["Seer Janidi"] = true
L["Seersa Copperpinch"] = true
L["Sempstress Ambershine"] = true
L["Serge Hinott"] = true
L["Sethekk Ravenguard"] = true
L["Sewa Mistrunner"] = true
L["Shaani"] = true
L["Shadi Mistrunner"] = true
L["Shadow Council Warlock"] = true
L["Shadowmage"] = true
L["Shadowsworn Thug"] = true
L["Shadowy Assassin"] = true
L["Shaina Fuller"] = true
L["Shankys"] = true
L["Shattered Hand Centurion"] = true
L["Shattertusk Mammoth"] = true
L["Shayis Steelfury"] = true
L["Sheendra Tallgrass"] = true
L["Shelene Rhobart"] = true
L["Shen'dralar Provisioner"] = true
L["Sheri Zipstitch"] = true
L["Sid Limbardi"] = true
L["Silverbrook Trapper"] = true
L["Silverbrook Villager"] = true
L["Silverbrook Hunter"] = true
L["Silverbrook Defender"] = true
L["Simon Tanner"] = true
L["Simon Unit"] = true
L["Skeletal Flayer"] = true
L["Skeletal Runesmith"] = true
L["Skreah"] = true
L["Slagg"] = true
L["Slavering Ghoul"] = true
L["Smith Argus"] = true
L["Smudge Thunderwood"] = true
L["Son of Arkkoroc"] = true
L["Soolie Berryfizz"] = true
L["Sovik"] = true
L["Spectral Researcher"] = true
L["Spirestone Warlord"] = true
L["Springspindle Fizzlegear"] = true
L["Stephen Ryback"] = true
L["Stoic Mammoth"] = true
L["Stone Guard Mukar"] = true
L["Stormforged Ambusher"] = true
L["Stormforged Artificer"] = true
L["Stormforged Champion"] = true
L["Stormforged Infiltrator"] = true
L["Strashaz Myrmidon"] = true
L["Strashaz Serpent Guard"] = true
L["Strashaz Warrior"] = true
L["Stuart Fleming"] = true
L["Sunfury Arcanist"] = true
L["Sunfury Arch Mage"] = true
L["Sunfury Archer"] = true
L["Sunfury Bloodwarder"] = true
L["Sunfury Bowman"] = true
L["Sunfury Researcher"] = true
L["Sunseeker Astromage"] = true
L["Sunseeker Botanist"] = true
L["Super-Seller 680"] = true
L["Supply Officer Mills"] = true
L["Swampwalker"] = true
L["Swampwalker Elder"] = true
L["Sylann"] = true
L["Syndicate Assassin"] = true
L["Syndicate Spy"] = true
L["Taladan"] = true
L["Tally Berryfizz"] = true
L["Tamar"] = true
L["Tanaika"] = true
L["Tanak"] = true
L["Tangled Horror"] = true
L["Tansy Puddlefizz"] = true
L["Tarban Hearthgrain"] = true
L["Tari'qa"] = true
L["Tatiana"] = true
L["Teg Dawnstrider"] = true
L["Telonis"] = true
L["Tepa"] = true
L["Terrormaster"] = true
L["Thaddeus Webb"] = true
L["Thamner Pol"] = true
L["Tharynn Bouden"] = true
L["Thaurissan Firewalker"] = true
L["Theramore Infiltrator"] = true
L["Theramore Marine"] = true
L["Theramore Preserver"] = true
L["Therum Deepforge"] = true
L["Thomas Kolichio"] = true
L["Thomas Yance"] = true
L["Thorkaf Dragoneye"] = true
L["Thoth"] = true
L["Thuzadin Shadowcaster"] = true
L["Tidelord Rrurgaz"] = true
L["Tiffany Cartier"] = true
L["Tilli Thistlefuzz"] = true
L["Time-Lost Shadowmage"] = true
L["Timothy Jones"] = true
L["Timothy Worthington"] = true
L["Tink Brightbolt"] = true
L["Tinkerwiz"] = true
L["Tinkmaster Overspark"] = true
L["Tisha Longbridge"] = true
L["Tognus Flintfire"] = true
L["Tomas"] = true
L["Torloth the Magnificent"] = true
L["Torn Fin Coastrunner"] = true
L["Torn Fin Muckdweller"] = true
L["Torn Fin Oracle"] = true
L["Torn Fin Tidehunter"] = true
L["Trader Narasu"] = true
L["Traugh"] = true
L["Truk Wildbeard"] = true
L["Tunkk"] = true
L["Twilight Fire Guard"] = true
L["Ulthaan"] = true
L["Ulthir"] = true
L["Una"] = true
L["Unchained Doombringer"] = true
L["Uriku"] = true
L["Uthok"] = true
L["Vaean"] = true
L["Valdaron"] = true
L["Vance Undergloom"] = true
L["Vanessa Sellers"] = true
L["Vargus"] = true
L["Vazario Linkgrease"] = true
L["Veenix"] = true
L["Vekh'nir Dreadhawk"] = true
L["Vendor-Tron 1000"] = true
L["Vengeful Ancient"] = true
L["Venture Co. Excavator"] = true
L["Venture Co. Strip Miner"] = true
L["Veteran Crusader Aliocha Segard"] = true
L["Vharr"] = true
L["Viggz Shinesparked"] = true
L["Vilebranch Hideskinner"] = true
L["Vir'aani Arcanist"] = true
L["Vira Younghoof"] = true
L["Vivianna"] = true
L["Vizzklick"] = true
L["Vodesiin"] = true
L["Voidshrieker"] = true
L["Volchan"] = true
L["Vosur Brakthel"] = true
L["Waldor"] = true
L["Wastewander Assassin"] = true
L["Wastewander Bandit"] = true
L["Wastewander Rogue"] = true
L["Wastewander Scofflaw"] = true
L["Wastewander Shadow Mage"] = true
L["Wastewander Thief"] = true
L["Weapon Technician"] = true
L["Weaver Aoa"] = true
L["Wenna Silkbeard"] = true
L["Werg Thickblade"] = true
L["Wik'Tar"] = true
L["Wilhelmina Renel"] = true
L["Wind Trader Lathrai"] = true
L["Winter Reveler"] = true
L["Winterfall Den Watcher"] = true
L["Winterfall Totemic"] = true
L["Winterfall Ursa"] = true
L["Witherbark Berserker"] = true
L["Witherbark Headhunter"] = true
L["Witherbark Shadow Hunter"] = true
L["Withered Ancient"] = true
L["Wolgren Jinglepocket"] = true
L["Wrahk"] = true
L["Wrathwalker"] = true
L["Wulan"] = true
L["Wulmort Jinglepocket"] = true
L["Wunna Darkmane"] = true
L["Xandar Goodbeard"] = true
L["Xen'to"] = true
L["Xerintha Ravenoak"] = true
L["Xizk Goodstitch"] = true
L["Xizzer Fizzbolt"] = true
L["Xylinnia Starshine"] = true
L["Xyrol"] = true
L["Yarr Hammerstone"] = true
L["Yatheon"] = true
L["Yelmak"] = true
L["Yonada"] = true
L["Ythyar"] = true
L["Yuka Screwspigot"] = true
L["Yurial Soulwater"] = true
L["Zamja"] = true
L["Zan Shivsproket"] = true
L["Zannok Hidepiercer"] = true
L["Zansoa"] = true
L["Zantasia"] = true
L["Zaralda"] = true
L["Zarena Cromwind"] = true
L["Zargh"] = true
L["Zarrin"] = true
L["Zebig"] = true
L["Zixil"] = true
L["Zorbin Fandazzle"] = true
L["Zula Slagfury"] = true
L["Zurai"] = true
L["Zurii"] = true
