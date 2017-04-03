--[[---------------------------------------------------------------------------------
    Localisation for English
----------------------------------------------------------------------------------]]

local L = Clique.Locals

-- This is the default locale.
if GetLocale() then
	L.RANK                    = "Rank"
	L.RANK_PATTERN            = "Rank (%d+)"
	L.CAST_FORMAT             = "%s(Rank %s)"

	L.RACIAL_PASSIVE          = "Racial Passive"
	L.PASSIVE                 = SPELL_PASSIVE
	
	L.CLICKSET_DEFAULT        = "Default"
	L.CLICKSET_HARMFUL        = "Harmful actions"
	L.CLICKSET_HELPFUL        = "Helpful actions"
	L.CLICKSET_OOC            = "Out of Combat"
	L.CLICKSET_BEARFORM       = "Bear Form"
	L.CLICKSET_CATFORM        = "Cat Form"
    L.CLICKSET_AQUATICFORM    = "Aquatic Form"
	L.CLICKSET_TRAVELFORM     = "Travel Form"
	L.CLICKSET_MOONKINFORM    = "Moonkin Form"
	L.CLICKSET_TREEOFLIFE     = "Tree of Life Form"
	L.CLICKSET_SHADOWFORM     = "Shadowform"
	L.CLICKSET_STEALTHED      = "Stealthed"
	L.CLICKSET_BATTLESTANCE   = "Battle Stance"
	L.CLICKSET_DEFENSIVESTANCE = "Defensive Stance"
	L.CLICKSET_BERSERKERSTANCE = "Berserker Stance"

	L.BEAR_FORM = "Bear Form"
	L.DIRE_BEAR_FORM = "Dire Bear Form"
	L.CAT_FORM = "Cat Form"
	L.AQUATIC_FORM = "Aquatic Form"
	L.TRAVEL_FORM = "Travel Form"
	L.TREEOFLIFE = "Tree of Life"
	L.MOONKIN_FORM = "Moonkin Form"
	L.STEALTH = "Stealth"
	L.SHADOWFORM = "Shadowform"
	L.BATTLESTANCE = "Battle Stance"
	L.DEFENSIVESTANCE = "Defensive Stance"
	L.BERSERKERSTANCE = "Berserker Stance"

	L.BINDING_NOT_DEFINED     = "Binding not defined"
	L.CANNOT_CHANGE_COMBAT    = "Cannot make changes in combat.  These changes will be delayed until you exit combat."
	L.APPLY_QUEUE             = "Out of combat.  Applying all queued changes."
	L.PROFILE_CHANGED         = "Profile has changed to '%s'."
	L.PROFILE_DELETED         = "Profile '%s' has been deleted."
	L.PROFILE_RESET         = "Your profile '%s' has been reset."

	L.ACTION_ACTIONBAR = "Change ActionBar"
	L.ACTION_ACTION = "Action Button"
	L.ACTION_PET = "Pet Action Button"
	L.ACTION_SPELL = "Cast Spell"
	L.ACTION_ITEM = "Use Item"
	L.ACTION_MACRO = "Run Custom Macro"
	L.ACTION_STOP = "Stop Casting"
	L.ACTION_TARGET = "Target Unit"
	L.ACTION_FOCUS = "Set Focus"
	L.ACTION_ASSIST = "Assist Unit"
	L.ACTION_CLICK = "Click Button"
	L.ACTION_MENU = "Show Menu"

	L.HELP_TEXT               = "Welcome to Clique.  For basic operation, you can navigate the spellbook and decide what spell you'd like to bind to a specific click.  Then click on that spell with whatever click-binding you would like.  For example, navigate to \"Flash Heal\" and shift-LeftClick on it to bind that spell to Shift-LeftClick."
	L.CUSTOM_HELP             = "This is the Clique custom edit screen.  From here you can configure any of the combinations that the UI makes available to us in response to clicks.  Select a base action from the left column.  You can then click on the button below to set the binding you'd like, and then supply the arguments required (if any)."
	
	L.BS_ACTIONBAR_HELP = "Change the actionbar.  'increment' will move it up one page, 'decrement' does the opposite.  If you supply a number, the action bar will be turned to that page.  You can specify 1,3 to toggle between pages 1 and 3"
	L.BS_ACTIONBAR_ARG1_LABEL = "Action:"

	L.BS_ACTION_HELP = "Simulate a click on an action button.  Specify the number of the action button."
	L.BS_ACTION_ARG1_LABEL = "Button Number:"
	L.BS_ACTION_ARG2_LABEL = "(Optional) Unit:"

	L.BS_PET_HELP = "Simulate a click on an pet's action button.  Specify the number of the button."
	L.BS_PET_ARG1_LABEL = "Pet Button Number:"
	L.BS_PET_ARG2_LABEL = "(Optional) Unit:"

	L.BS_SPELL_HELP = "Cast a spell from the spellbook.  Takes a spell name, and optionally a bag and slot, or item name to use as the target of the spell (i.e. Feed Pet)"
	L.BS_SPELL_ARG1_LABEL = "Spell Name:"
	L.BS_SPELL_ARG2_LABEL = "*Rank/Bag Number:"
	L.BS_SPELL_ARG3_LABEL = "*Slot Number:"
	L.BS_SPELL_ARG4_LABEL = "*Item Name:"
	L.BS_SPELL_ARG5_LABEL = "(Optional) Unit:"

	L.BS_ITEM_HELP = "Use an item.  Can take either a bag and slot, or an item name."
	L.BS_ITEM_ARG1_LABEL = "Bag Number:"
	L.BS_ITEM_ARG2_LABEL = "Slot Number:"
	L.BS_ITEM_ARG3_LABEL = "Item Name:"
	L.BS_ITEM_ARG4_LABEL = "(Optional) Unit:"

	L.BS_MACRO_HELP = "Use a custom macro in a given index"
	L.BS_MACRO_ARG1_LABEL = "Macro Index:"
	L.BS_MACRO_ARG2_LABEL = "Macro Text:"

	L.BS_STOP_HELP = "Stops casting the current spell"
	
	L.BS_TARGET_HELP = "Targets the unit"
	L.BS_TARGET_ARG1_LABEL = "(Optional) Unit:"

	L.BS_FOCUS_HELP = "Sets your \"focus\" unit"
	L.BS_FOCUS_ARG1_LABEL = "(Optional) Unit:"

	L.BS_ASSIST_HELP = "Assists the unit"
	L.BS_ASSIST_ARG1_LABEL = "(Optional) Unit:"

	L.BS_CLICK_HELP = "Simulate click on a button"
	L.BS_CLICK_ARG1_LABEL = "Button Name:"

	L.BS_MENU_HELP = "Shows the unit pop up menu"

    L.CUSTOM = "Custom"
    L.FRAMES = "Frames"
    L.PROFILES = "Profiles"
    L.DELETE = "Delete"
    L.EDIT = "Edit"
    L["Clique Options"] = "Clique Options"
    L["Primary:"] = "Primary:"
    L["Secondary:"] = "Secondary:"
end

