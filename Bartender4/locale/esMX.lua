-- Bartender4 Locale
-- Please use the Localization App on WoWAce to Update this
-- http://www.wowace.com/projects/bartender4/localization/ ;¶

local L = LibStub("AceLocale-3.0"):NewLocale("Bartender4", "esMX")
if not L then return end

-- L["ActionBar Paging"] = "ActionBar Paging"
-- L["Alignment"] = "Alignment"
-- L["Alpha"] = "Alpha"
-- L["ALT"] = "ALT"
-- L["Always Hide"] = "Always Hide"
-- L["Anchor"] = "Anchor"
-- L["Auto-Assist"] = "Auto-Assist"
-- L["Bag Bar"] = "Bag Bar"
-- L["Bar Options"] = "Bar Options"
-- L["Bars"] = "Bars"
-- L["Bar %s"] = "Bar %s"
-- L["Bar Snapping"] = "Bar Snapping"
-- L["Bar Style & Layout"] = "Bar Style & Layout"
-- L["Bars unlocked. Move them now and click Lock when you are done."] = "Bars unlocked. Move them now and click Lock when you are done."
-- L["Bartender4"] = "Bartender4"
-- L["Blizzard Art"] = "Blizzard Art"
-- L["Blizzard Art Bar"] = "Blizzard Art Bar"
-- L["Blizzard interface"] = "Blizzard interface"
-- L["Button Grid"] = "Button Grid"
-- L["Button Lock"] = "Button Lock"
-- L["Button Look"] = "Button Look"
-- L["Buttons"] = "Buttons"
-- L["Button %s"] = "Button %s"
-- L["Button Tooltip"] = "Button Tooltip"
-- L["Cannot access options during combat."] = "Cannot access options during combat."
-- L["Center Horizontally"] = "Center Horizontally"
-- L["Centers the bar horizontally on screen."] = "Centers the bar horizontally on screen."
-- L["Centers the bar vertically on screen."] = "Centers the bar vertically on screen."
-- L["Center Vertically"] = "Center Vertically"
-- L["|cffffff00Click|r to toggle bar lock"] = "|cffffff00Click|r to toggle bar lock"
-- L["|cffffff00Right-click|r to open the options menu"] = "|cffffff00Right-click|r to open the options menu"
-- L["Change the current anchor point of the bar."] = "Change the current anchor point of the bar."
-- L["Choose between the classic WoW layout and two variations"] = "Choose between the classic WoW layout and two variations"
-- L["Choose the ending to the left"] = "Choose the ending to the left"
-- L["Choose the ending to the right"] = "Choose the ending to the right"
-- L["Classic"] = "Classic"
-- L["Click-Through"] = "Click-Through"
-- L["Colors"] = "Colors"
-- L["Configure actionbar paging when the %s key is down."] = "Configure actionbar paging when the %s key is down."
-- L["Configure all of Bartender to preset defaults"] = "Configure all of Bartender to preset defaults"
-- L["Configure Bar %s"] = "Configure Bar %s"
-- L["Configure how the Out of Range Indicator should display on the buttons."] = "Configure how the Out of Range Indicator should display on the buttons."
-- L["Configure the alpha of the bar."] = "Configure the alpha of the bar."
-- L["Configure the Bag Bar"] = "Configure the Bag Bar"
-- L["Configure the Blizzard Art Bar"] = "Configure the Blizzard Art Bar"
-- L["Configure the Button Tooltip."] = "Configure the Button Tooltip."
-- L["Configure the Fade Out Alpha"] = "Configure the Fade Out Alpha"
-- L["Configure the Fade Out Delay"] = "Configure the Fade Out Delay"
-- L["Configure the Micro Menu"] = "Configure the Micro Menu"
-- L["Configure the padding of the buttons."] = "Configure the padding of the buttons."
-- L["Configure the Pet Bar"] = "Configure the Pet Bar"
-- L["Configure the Reputation Bar"] = "Configure the Reputation Bar"
-- L["Configure the scale of the bar."] = "Configure the scale of the bar."
-- L["Configure  the Stance Bar"] = "Configure  the Stance Bar"
-- L["Configure the Totem Bar"] = "Configure the Totem Bar"
-- L["Configure the VehicleBar"] = "Configure the VehicleBar"
-- L["Configure the XP Bar"] = "Configure the XP Bar"
-- L["Copy Conditionals"] = "Copy Conditionals"
-- L["Create a copy of the auto-generated conditionals in the custom configuration as a base template."] = "Create a copy of the auto-generated conditionals in the custom configuration as a base template."
-- L["CTRL"] = "CTRL"
-- L["Custom Conditionals"] = "Custom Conditionals"
-- L["Default Bar State"] = "Default Bar State"
-- L["Defaults"] = "Defaults"
-- L["Disable any reaction to mouse events on this bar, making the bar click-through."] = "Disable any reaction to mouse events on this bar, making the bar click-through."
-- L["Disabled"] = "Disabled"
-- L["Disabled in Combat"] = "Disabled in Combat"
-- L["Don't Page"] = "Don't Page"
-- L["Down"] = "Down"
-- L["Empty button background"] = "Empty button background"
--[==[ L[ [=[Enable Auto-Assist for this bar.
 Auto-Assist will automatically try to cast on your target's target if your target is no valid target for the selected spell.]=] ] = [=[Enable Auto-Assist for this bar.
 Auto-Assist will automatically try to cast on your target's target if your target is no valid target for the selected spell.]=] ]==]
--[==[ L[ [=[Enable Bar Switching based on the actionbar controls provided by the game. 
See Blizzard Key Bindings for assignments - Usually Shift-Mouse Wheel and Shift+1 - Shift+6.]=] ] = [=[Enable Bar Switching based on the actionbar controls provided by the game. 
See Blizzard Key Bindings for assignments - Usually Shift-Mouse Wheel and Shift+1 - Shift+6.]=] ]==]
-- L["Enabled"] = "Enabled"
-- L["Enable/Disable the bar."] = "Enable/Disable the bar."
-- L["Enable State-based Button Swaping"] = "Enable State-based Button Swaping"
-- L["Enable the Bag Bar"] = "Enable the Bag Bar"
-- L["Enable the Blizzard Art Bar"] = "Enable the Blizzard Art Bar"
-- L["Enable the FadeOut mode"] = "Enable the FadeOut mode"
-- L["Enable the Micro Menu"] = "Enable the Micro Menu"
-- L["Enable the PetBar"] = "Enable the PetBar"
-- L["Enable the Reputation Bar"] = "Enable the Reputation Bar"
-- L["Enable the StanceBar"] = "Enable the StanceBar"
-- L["Enable the Totem Bar"] = "Enable the Totem Bar"
-- L["Enable the use of a custom condition, disabling all of the above."] = "Enable the use of a custom condition, disabling all of the above."
-- L["Enable the use of the Blizzard Vehicle UI, hiding any Bartender4 bars in the meantime."] = "Enable the use of the Blizzard Vehicle UI, hiding any Bartender4 bars in the meantime."
-- L["Enable the Vehicle Bar"] = "Enable the Vehicle Bar"
-- L["Enable the XP Bar"] = "Enable the XP Bar"
-- L["Fade Out"] = "Fade Out"
-- L["Fade Out Alpha"] = "Fade Out Alpha"
-- L["Fade Out Delay"] = "Fade Out Delay"
-- L["FAQ"] = "FAQ"
--[==[ L["FAQ_TEXT"] = [=[|cffffd200
I just installed Bartender4, but my keybindings do not show up on the buttons/do not work entirely.
|r
Bartender4 only converts the bindings of Bar1 to be directly usable, all other Bars will have to be re-bound to the Bartender4 keys. A direct indicator if your key-bindings are setup correctly is the hotkey display on the buttons. If the key-bindings shows correctly on your button, everything should work fine as well.

|cffffd200
How do I change the Bartender4 Keybindings then?
|r
You can either click the KeyBound button in the options, or use the |cffffff78/kb|r chat command to open the keyBound control. 

Once open, simply hover the button you want to bind, and press the key you want to be bound to that button. The keyBound tooltip and on-screen status will inform you about already existing bindings to that button, and the success of your binding attempt.

|cffffd200
My BagBar does not have the Keyring on it, how do i get it back?
|r
Its simple! Just check the Keyring option in the BagBars configuration menu, and it'll appear next to your bags.

|cffffd200
I've found a bug! Where do I report it?
|r
You can report bugs or give suggestions at the discussion forums at |cffffff78http://forums.wowace.com/showthread.php?t=12513|r or check the project page at |cffffff78http://www.wowace.com/projects/bartender4/|r

Alternatively, you can also find us on |cffffff78irc://irc.freenode.org/wowace|r

When reporting a bug, make sure you include the |cffffff78steps on how to reproduce the bug|r, supply any |cffffff78error messages|r with stack traces if possible, give the |cffffff78revision number|r of Bartender4 the problem occured in and state whether you are using an |cffffff78English client or otherwise|r.

|cffffd200
Who wrote this cool addon?
|r
Bartender4 was written by Nevcairiel of EU-Antonidas, the author of Bartender3!]=] ]==]
-- L["Focus-Cast by modifier"] = "Focus-Cast by modifier"
-- L["Focus-Cast Modifier"] = "Focus-Cast Modifier"
-- L["Frequently Asked Questions"] = "Frequently Asked Questions"
-- L["Full Button Mode"] = "Full Button Mode"
-- L["Full reset"] = "Full reset"
-- L["General Settings"] = "General Settings"
-- L["Griffin"] = "Griffin"
-- L["Hide Hotkey"] = "Hide Hotkey"
-- L["Hide in Combat"] = "Hide in Combat"
-- L["Hide in Stance/Form"] = "Hide in Stance/Form"
-- L["Hide Macro Text"] = "Hide Macro Text"
-- L["Hide on Vehicle"] = "Hide on Vehicle"
-- L["Hide out of Combat"] = "Hide out of Combat"
-- L["Hide the Hotkey on the buttons of this bar."] = "Hide the Hotkey on the buttons of this bar."
-- L["Hide the Macro Text on the buttons of this bar."] = "Hide the Macro Text on the buttons of this bar."
-- L["Hide this bar in a specific Stance or Form."] = "Hide this bar in a specific Stance or Form."
-- L["Hide this bar when the game wants to show a vehicle UI."] = "Hide this bar when the game wants to show a vehicle UI."
-- L["Hide this bar when you are possessing a NPC."] = "Hide this bar when you are possessing a NPC."
-- L["Hide this bar when you are riding on a vehicle."] = "Hide this bar when you are riding on a vehicle."
-- L["Hide this bar when you have a pet."] = "Hide this bar when you have a pet."
-- L["Hide this bar when you have no pet."] = "Hide this bar when you have no pet."
-- L["Hide when Possessing"] = "Hide when Possessing"
-- L["Hide without pet"] = "Hide without pet"
-- L["Hide with pet"] = "Hide with pet"
-- L["Hide with Vehicle UI"] = "Hide with Vehicle UI"
-- L["Horizontal Growth"] = "Horizontal Growth"
-- L["Horizontal growth direction for this bar."] = "Horizontal growth direction for this bar."
-- L["Hotkey Mode"] = "Hotkey Mode"
-- L["Key Bindings"] = "Key Bindings"
-- L["Keyring"] = "Keyring"
-- L["Layout"] = "Layout"
-- L["Left"] = "Left"
-- L["Left ending"] = "Left ending"
-- L["Lion"] = "Lion"
-- L["Lock"] = "Lock"
-- L["Lock all bars."] = "Lock all bars."
-- L["Lock the buttons."] = "Lock the buttons."
-- L["Micro Menu"] = "Micro Menu"
-- L["Minimap Icon"] = "Minimap Icon"
-- L["Modifier Based Switching"] = "Modifier Based Switching"
-- L["No Display"] = "No Display"
-- L["None"] = "None"
-- L["No Stance/Form"] = "No Stance/Form"
-- L["Note: Enabling Custom Conditionals will disable all of the above settings!"] = "Note: Enabling Custom Conditionals will disable all of the above settings!"
-- L["Number of buttons."] = "Number of buttons."
-- L["Number of rows."] = "Number of rows."
-- L["Offset in X direction (horizontal) from the given anchor point."] = "Offset in X direction (horizontal) from the given anchor point."
-- L["Offset in Y direction (vertical) from the given anchor point."] = "Offset in Y direction (vertical) from the given anchor point."
-- L["One action bar only"] = "One action bar only"
-- L["One Bag"] = "One Bag"
-- L["Only show one Bag Button in the BagBar."] = "Only show one Bag Button in the BagBar."
-- L["Out of Mana Indicator"] = "Out of Mana Indicator"
-- L["Out of Range Indicator"] = "Out of Range Indicator"
-- L["Padding"] = "Padding"
-- L["Page %2d"] = "Page %2d"
-- L["Pet Bar"] = "Pet Bar"
-- L["Positioning"] = "Positioning"
-- L["Possess Bar"] = "Possess Bar"
-- L["Reputation Bar"] = "Reputation Bar"
-- L["Reset Position"] = "Reset Position"
-- L["Reset profile"] = "Reset profile"
-- L["Reset the position of this bar completly if it ended up off-screen and you cannot reach it anymore."] = "Reset the position of this bar completly if it ended up off-screen and you cannot reach it anymore."
-- L["Right"] = "Right"
-- L["Right-click Self-Cast"] = "Right-click Self-Cast"
-- L["Right ending"] = "Right ending"
-- L["Rows"] = "Rows"
-- L["Scale"] = "Scale"
-- L["Select the Focus-Cast Modifier"] = "Select the Focus-Cast Modifier"
-- L["Select the Self-Cast Modifier"] = "Select the Self-Cast Modifier"
-- L["Self-Cast by modifier"] = "Self-Cast by modifier"
-- L["Self-Cast Modifier"] = "Self-Cast Modifier"
-- L["SHIFT"] = "SHIFT"
-- L["Show a Icon to open the config at the Minimap"] = "Show a Icon to open the config at the Minimap"
-- L["Show Reputation Bar"] = "Show Reputation Bar"
-- L["Show the keyring button."] = "Show the keyring button."
-- L["Show XP Bar"] = "Show XP Bar"
-- L["Specify the Color of the Out of Mana Indicator"] = "Specify the Color of the Out of Mana Indicator"
-- L["Specify the Color of the Out of Range Indicator"] = "Specify the Color of the Out of Range Indicator"
-- L["Stance Bar"] = "Stance Bar"
-- L["Stance Configuration"] = "Stance Configuration"
-- L["State Configuration"] = "State Configuration"
-- L["Switch this bar to the Possess Bar when possessing a npc (eg. Mind Control)"] = "Switch this bar to the Possess Bar when possessing a npc (eg. Mind Control)"
-- L["Switch to key-binding mode"] = "Switch to key-binding mode"
--[==[ L[ [=[The Alignment menu is still on the TODO.

As a quick preview of whats planned:

	- Absolute and relative Bar Positioning
	- Bars "snapping" together and building clusters]=] ] = [=[The Alignment menu is still on the TODO.

As a quick preview of whats planned:

	- Absolute and relative Bar Positioning
	- Bars "snapping" together and building clusters]=] ]==]
-- L["The background of button places where no buttons are placed"] = "The background of button places where no buttons are placed"
-- L["The bar default is to be visible all the time, you can configure conditions here to control when the bar should be hidden."] = "The bar default is to be visible all the time, you can configure conditions here to control when the bar should be hidden."
-- L["The default behaviour of this bar when no state-based paging option affects it."] = "The default behaviour of this bar when no state-based paging option affects it."
-- L["The Positioning options here will allow you to position the bar to your liking and with an absolute precision."] = "The Positioning options here will allow you to position the bar to your liking and with an absolute precision."
-- L["This bar will be hidden once you enter combat."] = "This bar will be hidden once you enter combat."
-- L["This bar will be hidden whenever you are not in combat."] = "This bar will be hidden whenever you are not in combat."
--[==[ L[ [=[Toggle Button Zoom
For more style options you need to install ButtonFacade]=] ] = [=[Toggle Button Zoom
For more style options you need to install ButtonFacade]=] ]==]
-- L["Toggle the button grid."] = "Toggle the button grid."
-- L["Toggle the use of the modifier-based focus-cast functionality."] = "Toggle the use of the modifier-based focus-cast functionality."
-- L["Toggle the use of the modifier-based self-cast functionality."] = "Toggle the use of the modifier-based self-cast functionality."
-- L["Toggle the use of the right-click self-cast functionality."] = "Toggle the use of the right-click self-cast functionality."
-- L["Totem Bar"] = "Totem Bar"
-- L["Two action bars"] = "Two action bars"
-- L["Up"] = "Up"
-- L["Use Blizzard Vehicle UI"] = "Use Blizzard Vehicle UI"
-- L["Use Custom Condition"] = "Use Custom Condition"
-- L["VehicleBar"] = "VehicleBar"
-- L["Vehicle Bar"] = "Vehicle Bar"
-- L["Vertical Growth"] = "Vertical Growth"
-- L["Vertical growth direction for this bar."] = "Vertical growth direction for this bar."
-- L["Visibility"] = "Visibility"
-- L["WARNING: Pressing the button will reset your complete profile! If you're not sure about this create a new profile and use that to experiment."] = "WARNING: Pressing the button will reset your complete profile! If you're not sure about this create a new profile and use that to experiment."
-- L["X Offset"] = "X Offset"
-- L["XP Bar"] = "XP Bar"
-- L["Y Offset"] = "Y Offset"
-- L["You can set the bar to be always hidden, if you only wish to access it using key-bindings."] = "You can set the bar to be always hidden, if you only wish to access it using key-bindings."
--[==[ L[ [=[You can use any macro conditionals in the custom string, using "show" and "hide" as values.

Example: [combat]hide;show]=] ] = [=[You can use any macro conditionals in the custom string, using "show" and "hide" as values.

Example: [combat]hide;show]=] ]==]
--[==[ L[ [=[You can use any macro conditionals in the custom string, using the number of the bar as target value.
Example: [form:1]9;0]=] ] = [=[You can use any macro conditionals in the custom string, using the number of the bar as target value.
Example: [form:1]9;0]=] ]==]
-- L["You can use the preset defaults as a starting point for setting up your interface. Just choose your preferences here and click the button below to reset your profile to the preset default."] = "You can use the preset defaults as a starting point for setting up your interface. Just choose your preferences here and click the button below to reset your profile to the preset default."
-- L["You have to exit the vehicle in order to be able to change the Vehicle UI settings."] = "You have to exit the vehicle in order to be able to change the Vehicle UI settings."
-- L["Zoom"] = "Zoom"

