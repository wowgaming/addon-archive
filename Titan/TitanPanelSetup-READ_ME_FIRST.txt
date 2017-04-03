Titan Panel Setup Read Me First File
Titan Development Team: HonorGoG, Lothayer, JoeJanko, oXidFoX, PatoDaia, StingerSoft, Urnati & Yeachan.
-------------------------------------------------------------------------------------------------------------

1. Description

Titan Panel adds a configurable interface bar/control panel to your WoW UI.  Because so much of the code has been rewritten since version 3.1.1, we are providing this help file.


2. Installation

Unzip the contents of the zip file into your ..\Interface\Addons directory.

Important Note for Mac Users:  When a zip file contains folders, the auto-unzip function built into Mac OSX will create a new folder to place them in.  If you unzip directly to the Addons folder, this newly-created folder will prevent Titan from loading.  We recommend Mac users unzip to the desktop, open the Titan folder on the desktop, then select and drag the contents of it to your ..\Interface\Addons folder.


3. Setup

   - Verify WoW recognizes the addon.  After signing on to WoW, click the AddOns button on the Realm/Character Selection screen.  Titan Panel should be checked by default; if not, check it.  While there, check any unchecked addons, including Titan plugins, you want to display and uncheck any addons you don't want to display.
   
   - Display desired core functions and built-in plugins.  After you enter the game, right-click a blank area of the Titan Panel and hover the cursor over Built-ins.  Core functions and built-ins that are displayed by default will be checked; click to check any others you want displayed.  You can also click any checked built-ins you want to disable.


4. Customization

You have numerous ways to customize the panel.  One way is to change the settings of core functions.  The following core functions appear on the right side of the main bar:

   - Auto-Hide (Push Pin icon).  Left-clicking this icon causes the bars to only appear when you move the cursor atop the bar.  Otherwise, the bars are hidden.  There is a separate push pin for the top and bottom bars.  The default setting is OFF.

   - Volume Control (speaker icon).  This allows you to override Blizzard's default sound settings. Note that this setting/icon will only appear if the Titan Volume internal plugin is loaded !
     Right-click this icon to display the following Volume Control options:
     * Show Sound/Voice options.  Displays the Sound & Voice window.  Here you can control volume using Blizzard's interface.
     * Override Blizzard Volume Settings.  Select this to control volume using Titan Panel's interface.  The default setting is off.
     * Hide.  Remove the plugin from the panel.

     Left-click this icon to display 6 slider bars with which you can control the volume levels of the following:  Master, Effects, Music, Ambience, Microphone, and Speaker.  The default settings are 1.  NOTE:  You MUST select Override Blizzard Volume Settings from the right-click options menu if you want to control the volume with these sliders.

The following core functions appear in Blizzard's Interface Options frame and can be accessed from Titan's right-click menu:

   - Panel Control.  Left-clicking this option displays 4 slider bars with which you can control the scale of Blizzard's user interface (UI Scale), the scale of Titan Panel (Panel Scale), the spacing of the left-side buttons on the panel (Button Spacing), and the scale of the fonts in tooltips (Tooltip Font Scale).  The Disable Tooltip Font Scale checkbox overrides the setting on the Tooltip Font Scale slider.  The default settings are:
     * UI Scale = .9
     * Panel Scale = 1.0
     * Button Spacing = 20
     * Tooltip Font = 1.0.
     
     Moreover, by using this configuration screen, you will be able to change the font type and size for the addon, as well as the framestrata setting for the entire Panel.

   - Transparency.  Left-clicking this icon displays 3 slider bars with which you can control the transparency of the Main Bar (usually located at the top, though it can appear at the bottom if Display on Top option is unchecked); the Auxiliary Bar, (the bottom bar(s) if the top bars are also displayed); and the Tooltips.  The default settings are:
     * Main Bar = .7
     * Auxiliary Bar = .7
     * Tooltip = 1.0

Each of the built-ins gives you the option to disable it by right-clicking the icon and selecting Hide.

You may restore the defaults at any time by using slash commands. The slash command handler for Titan Panel is /titan or /titanpanel.  Two important slash commands are:

   - /titan reset or /titanpanel reset.  Restores all default settings by clearing the user preferences in the Saved Variables folder.

   - /titan or /titanpanel.  Displays in the chat window other slash handler commands for resetting individual settings.

   - /titan gui control.  Opens the Panel Control configuration window without invoking Blizzard's Interface Options menu.

   - /titan gui trans.  Opens the Transparency configuration window without invoking Blizzard's Interface Options menu.

   _ /titan gui skin.  Opens the Skins configuration window without invoking Blizzard's Interface Options menu.

A second way to customize Titan Panel is through plugins.  Titan Panel will display native plugins (written specifically for Titan Panel) as well as Data Broker plugins and launchers.

   - Plugins are controlled by hovering the cursor over a Plugins Category on the right-click menu, such as General or Information, and clicking an unchecked plugin to display it or clicking a checked plugin to hide it.  When you display additional left-side plugins, Titan will add each one to the right of existing buttons, alternating between the 2 top or 2 bottom bars, if double bars are displayed. Newly-selected right-side plugins display on the top-most or bottom-most bar only, to the left of the existing buttons. When top and bottom bars are displayed, select the new plugin from the bar on which you want it to appear.  
   
   - Some plugins have Readme files, like this, to guide you on their uses; some have directions for use on the addon download site; some have slash commands; most have hint text in their tooltip.  Most native plugins include a right-click menu of display options, such as toggles for displaying the icon, label text, and colored text.  For Data Broker plugins and launchers, these options are displayed in a follow-on menu accessed by hovering the plugin/launcher name.

A third way to customize Titan Panel is through the Options menu, in the panel's right-click menu.  Here, you can:

   - Auto-hide.  This works like the Push Pin icon-- selecting it will hide the bar until you put the cursor over it.  You must select this separately for top and bottom bars.  The default setting is OFF.

   - Center text.  This centers left-side buttons on the bar.  The default setting is OFF (left-justified buttons).

   - Lock buttons.  This locks the buttons in place, keeping you from inadvertently moving them.  (See Moving Buttons/Icons, below.)  The default setting is OFF.

   - Show plugin versions.  This displays the version numbers of plugins (if coded to do so) next to the plugins' names on the panel's right-click menu.  The default setting is ON.
   
   - Force launchers to right-side.  By default, LDB launchers display as right-side icons but you can tell Titan to display them as left-side buttons if you so wish to.  
     This command will automatically convert all active left-side button launchers to right-side icons.
     
   - Reset Panel to Default (Reload UI).  This overrides any changes you have made and immediately reloads the UI.  If you report a problem with the panel, we may ask you to do this. The slash command /titan reset or /titanpanel reset will produce the same result.

   - Bars.  There are three settings that control where and how many bars are displayed - Display on Top, Display Both Bars, and Double Bar.

     * To display one top bar, select Display on Top only.  This is the default setting.
     * To display two top bars, invoke the right-click menu from the top bar and select Display on Top AND Double Bar.
     * To display two top bars and one bottom bar, invoke the right-click menu from the top bar and select all three settings.

     * To display one bottom bar, select no settings (all unchecked).
     * To display two bottom bars, invoke the right-click menu from the bottom bar and select Double Bar only.
     * To display two bottom bars and one top bar, invoke the right-click menu from the bottom bar and select all three settings.
     
     * To display one top and one bottom bar, select Display on Top AND Display Both Bars.

     * To display two top and two bottom bars, select all three settings from the top or bottom bar and then select Double Bar from the opposite bar. 

   - Show tooltips.  This displays a tooltip when you hover the cursor over a button/icon.  The default setting is ON.

   - Hide tooltips in combat.  This turns off tooltips in combat so you're not distracted while fighting.  The default setting is OFF.

   - Disable screen adjust.  Titan Panel adjusts the Blizzard UI automatically so Titan Panel fits without overlapping frames, such as the minimap.  This allows you to disable this automatic adjustment.  The default setting is OFF.  You may want to check this in conjunction with Auto-Hide, since that setting hides the panel except when the cursor is over it.
     Note:  Disabling screen adjust will have *NO EFFECT* on frames such as the combat log. Use options described below to explicitly adjust those frames.
     
   - Disable minimap adjust. Explicitly disables the adjustment of the minimap. This is useful in cases you want to enable another addon to specifically handle that frame. The default setting is OFF.
   
   - Automatic log adjust.  This instructs Titan to pin/stick the chat log above your lowest action bar, so the chat log doesn't overlap the action bars (should only work on Blizzard default bars and not custom bars like those added/created by Bartender4 or similar addons).  The default setting is OFF.
     Note:  Since this option has created a lot of confusion, we recommend that you keep this off, manually move the chat log, and lock it.
     
   - Automatic bag adjust. Automatically adjusts your bag containers, so they don't overlap with the Main menu bar, when you are using bottom bar(s). Unchecking this option is useful in cases you want to enable (or have already enabled) another addon which specifically handles your container frames. The default setting is ON.
   
   - Automatic ticket frame adjust (Reload UI). Automatically adjusts the GM ticket frame, so it doesn't overlap with the top bar(s). Unchecking this option is useful in cases you want to enable (or have already enabled) another addon which specifically handles positioning of the ticket frame, note however that the temporary enchant (buff) frame, will always adjust as to be below any active ticket frame.
     The default setting is ON. As implied, this setting requires a UI reload, in order to properly sync the GM ticket position with the temporary enchant (buff) frame.

A fourth way to customize Titan Panel is by changing skins.  Titan comes with a large selection of skins.  Selecting the Skins option on Titan Panel's right-click menu displays the Titan Skins frame, on which you can Set Panel Skin, Add New Skin, and Remove Skin.

As of version 4.1.7 (and beyond), Titan provides a public function called: TitanPanel_AddNewSkin(name, path), in order to assist artwork authors with adding their own custom skins to the Panel's settings without having to go through the configuration menu.
The function should be called with name of the skin and skin path as arguments.
Restrictions :

a) name cannot be empty ("") or nil or "None" for obvious reasons. Function does nothing if that is the case.
b) path cannot be empty of nil. Function does nothing if that is the case.
c) If a skin already exists in the Panel's savedvariables having the same name or artwork path with the skin you are attempting to register, registration will fail, function will take no action.


Titan Panel automatically saves the character's settings in a profile, using the character's name. The Profiles Manage option on the right-click menu allows you to replace the current character's profile with another another character's profile.  The Profiles Save option allows you to save the current character's settings under a user-specified name.


5. Moving Buttons/Icons.

You can swap positions of any two left-side buttons by left-clicking one and dragging it atop another.  You can even swap between bars.  Holding down modifier keys (Ctrl, Shift, Alt) and attempting to move a plugin will not work, by design.

You can also swap positions of any two right-side icons by left-clicking and dragging, as above.  Again, you can swap between the top and bottom bars.  However, it is intended behavior *NOT* to be able to swap plugins with the Titan Clock or the Auxiliary Auto-Hide.

It is also intended *NOT* to be able to switch right-side icons with left-side buttons and vice versa.

Developer Note: Authors should be careful when creating/using right-side icon plugins. To make right-side icons moveable, insert a new entry in the TITAN_PANEL_NONMOVABLE_PLUGINS table containing the id of your plugin, e.g., tinsert(TITAN_PANEL_NONMOVABLE_PLUGINS, "MyAddonID"). You can do this on your OnLoad method, or any initializing method for that matter. This insures that, if a user attempts to switch a right-side button with a left-side icon, right-side and left-side plugins will not get combined inside a certain table in the saved variables profile.  Such behavior is "NOT* intended; this is a safeguard to ensure the profile won't get malformed.


6. Bug Reporting.

The best way to report a bug is to open an Issue at our Google Code site (http://code.google.com/p/titanpanel/issues/).  Please include as many details as possible.  We will post our troubleshooting results and recommendations there, so check back often.  Before opening the Issue, please Search All Issues to see if the bug has already been reported and fixed.  Also, check the download sites for information on the download page, such as http://wowui.incgamers.com/?p=mod&m=1442 and
http://www.wowinterface.com/downloads/info8092-TitanPanel.html