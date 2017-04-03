
 CARBONITE
 Addon for World of Warcraft(tm)

 Copyright 2007-2010 Carbon Based Creations, LLC
 CARBONITE(tm) is a registered trademark of Carbon Based Creations, LLC.

 World of Warcraft(tm) and "WOW" are trademarks owned by Blizzard Entertainment, Inc.
 The CARBONITE addon is not endorsed by or affiliated with Blizzard Entertainment, Inc.

 Website: carboniteaddon.com

----------------------------------------------------------

Common Installation Instructions

 This zip file contains

   Carbonite (a folder)
   CarboniteNodes (a folder)
   CarboniteTransfer (a folder)
   CarboniteLicenseAgreement.txt
   CarboniteReadMe.txt

 The Carbonite folder needs to be dragged from the zip file or the zip file
 extracted to the Warcraft AddOns folder. Any existing Carbonite folders in
 the addons folder should be deleted first. This should be done while the
 game is not running.

 You can look at the shortcut (right click and select properties) you use to
 launch Warcraft to get the path to where it is installed.

 So if the shortcut says "C:\Program Files\World of Warcraft\Launcher.exe",
 then your addon path is "C:\Program Files\World of Warcraft\Interface\AddOns".
  
 Default paths:
 
 Windows XP "C:\Program Files\World of Warcraft\Interface\AddOns"
 Vista "C:\Users\Public\Games\World of Warcraft\Interface\AddOns"
 Machintosh "Machintosh HD/Applications/World of Warcraft/Interface/AddOns"

 Delete any existing Carbonite folders in the AddOns folder before you unzip a
 new version.

 If you have Warcraft installed at "C:\Program Files", then you would put
 the Carbonite folder in:

   "C:\Program Files\World of Warcraft\Interface\AddOns"

 Now you would have:

   "C:\Program Files\World of Warcraft\Interface\AddOns\Carbonite"

 Which contains:

  Bindings.xml
  Carbonite.lua
  Carbonite.toc
  Carbonite.xml
  CarboniteLicenseAgreement.txt
  CarboniteReadMe.txt
  Localizations.lua
  Gfx (a folder)
  Snd (a folder)
  
 A common error is to create a Carbonite folder in AddOns and unzip to the folder.
 This would leave you with

   "C:\Program Files\World of Warcraft\Interface\AddOns\Carbonite\Carbonite" (WRONG)

 which will not work!

 Some users have found two AddOns directories on their computers.
 This may be caused by having installed both a downloaded and CD version of Warcraft or
 if Vista's Virtual Store is enabled.
 
 When properly installed, the Carbonite logo will appear on login.
 If the Carbonite logo does not appear, then the AddOns folder you are using is the wrong one.
 You would then use your computer's "file search" to find the actual folder.

----------------------------------------------------------

Vista specific installation instructions:
 
 When you download an addon it will be in a zip file.

 When you click the "Download" button a dialog box should ask to
 "Open" or "Save". If you click "Open", then it will download the
 file and then show the contents. Near the top of the window that
 shows the file contents is a "Extract all files" button.
 Left click that and then click "Browse..." in the new window that opens.

 If you don't know the addon folder location, then look at the shortcut
 (right click and select properties) you use to launch Warcraft to
 get the path to where it is installed.

 Use the "Select a destination" window that opened to left click on
 "Computer" then (C:) or whatever drive it is installed on.
 Continue to click until you are at the game's "Interface\AddOns" folder.
 
 "C:\Program Files\World of Warcraft\Interface\AddOns" or
 "C:\Users\Public\Games\World of Warcraft\Interface\AddOns"
 are common locations for the game using Vista.
 
 Now left click "OK" at the bottom of the window and you should see
 "(the game path)\Interface\AddOns" in the
 "Files will be extracted to this folder:" line. Now click the
 "Extract" button at the bottom of the window. If it asks to overwrite
 files, which it will the next time you install another version of
 Carbonite and you did not delete the existing Carbonite folders first, then
 click "Yes".

 You would now have a
 "(the game path)\Interface\AddOns\Carbonite" folder.

 Installation is now complete and you can run World of Warcraft(tm).
 
----------------------------------------------------------

Macintosh installation:

1 Sign in to the Carbonite website using the email address and password you entered when signing up.
2 Click on "Downloads" in the website navigation bar.
3 Click on the newest file in the download list to get a web page for that file, then click the Download button.
4 When the download is finished you would "open" the downloaded file by right clicking the name and selecting "Open".
5 Select "Edit" from the Finder menu bar and then "Select All".
6 Select "Edit" from the Finder menu bar and then "Copy 5 Items".
7 On the left side of the Finder. Left click "Applications".
8 On the right side of the Finder. Double left click "World of Warcraft", then "Interface" and "Addons".
9 Select "Edit" from the Finder menu bar and then "Paste Items".

----------------------------------------------------------

Carbonite Start Up

 When you enter the game world with a character, you will see a Carbonite Logo
 appear.

 If the Carbonite Logo does not appear, then you have installed it incorrectly
 or it is disabled. Check if the addon is enabled by using the AddOns button on
 the character selection screen. If it does not appear in the list of addons,
 then repeat the installation instructions, since 99% of the time it was unzipped
 to the wrong location.

----------------------------------------------------------

** Carbonite User Guide **

-- Some things to do when first using Carbonite

There are dozens of settings you can configure and lots of ways to use Carbonite, but you really can ignore most of that stuff initially.

I would:

1 Read the help window that opens when you first sign in. Right click the Carbonite minimap button and select "Help" to see it again.
2 Drag the Carbonite map window (using the title bar) to the top right of the screen leaving a little room on the right edge.
3 Size the map window by dragging the edges.
4 Drag the Quest Watch List (title bar) to a nice spot under the map.
5 Drag the little window under (around) the Carbonite minimap button icon, so the icons start at the very top right of the screen.
6 Right click the Carbonite minimap button and select "Show Info 1 2" to get the HUD for you and your target. Select again if you don't like it to hide them.

When you start questing, you would click the purple "Auto Track" button at the top of the Quest Watch List or click a grey button on a specific quest objective to get the HUD arrow to start tracking it. Follow the arrow.


-- General User Interface

Most windows can be moved, sized, scaled & locked.
To move a window, Left Click the title bar and drag.
To size a window, Left Click and drag any window edge.
To scale a window, Right Click the title bar or close button and adjust the Scale slider.
To close a window, Left Click the close button.
To lock a window, Right Click the title bar or close button and check lock.
To unlock a window, Right Click the close button which appears as a lock icon when locked.

Transparency:  Each window has two transparency settings. Fade in and fade out.  Each setting controls the transparency level for the window borders & background.
- The fade in setting is used when the window has mouse focus.
- The fade out setting is use when the mouse leaves the window.
You can change these settings by Right Clicking the window title bar.

When using a slider control if you hold down shift all units are snapped to 0.1.  Pressing ALT while on a slider will set its value to 1.0


-- Minimap Carbonite Icon

This icon is found at the top left of the minimap or at the top of the minimap docking window.

Left Clicking will show or hide the map.
Right Clicking will open the main Carbonite menu. The menu can be used to open the help or options windows.


-- Map

Left Click and drag to move the map around inside the window
Roll your mouse wheel to zoom in/out at the current mouse position on the map.
Pressing M will toggle the map between normal mode and full-screen mode.

The size, position and settings for the map are saved.  These settings are also saved independently for each battleground. 

The "Follow You" option is on by default for the normal map.  As you move about, the map will adjust to keep you in the center of the screen.  Various battleground maps have this setting off by default as you will typically want to view the entire map and not have it scrolling as you move.

The map has two additional fade settings.  These control the transparency level of the map itself and can be adjusted by Right Clicking in the map window title.

The map title shows the zone you are currently in, your map coordinates and your movement speed as a percentage of normal walk speed.

The map tooltip will show you the level range of the map and is color coded based on faction (Yellow = contested, Green = friendly, Red = enemy)

Party/Raid members will show up as blue dots on your map.  Friends and guild mates running Carbonite will show up on your map as yellow and green dots respectively.  Other Carbonite users in your zone will show up as gray dots on the map.

The tooltip of any Carbonite user on the map will show you their coordinates, health, target name and target health.  Right Clicking their icon will allow you to whisper, retrieve quests and GOTO them.

For users wishing to see your original map, it is accessible by pressing ALT+M.


-- Map Menu

Right Clicking a non icon area of the map will show the main map menu.

"Goto" - Sets a point on the map, which the map and HUD will track. Map moves and scales to keep both you and the goto visible.
"Clear Goto" - Clears all gotos from the map.

"Add Note" - Sets a note for the click location in a folder with that zone name in the Favorites window. It will be shown on the map when that zone is selected.

"Save Map Scale" - Saves (remembers) the current map scale (zoom level). A keybinding can be set to do this.
"Restore Map Scale" - Sets the current map scale to the value that was previouly saved. A keybinding can be set to do this.

"Follow You" - If on, when you move or turn, the map will scroll to keep you in the center.

"Select Cities First" - Changes how cities are selected when you mouse over the map. It will select the zone, like Terokkar, first instead of the city Shattrath. Mostly useless. Someone was having a problem with tring to select a zone and it was added.

"Monitor Zone" - Makes you join that zone channel even if you are not in the zone, so you can see players and get punk info from the zone. Useful if you think a punk moved to another zone or to expand your punk detection.



-- Quests

The quest log replaces the original quest log.  Like most windows it is fully sizeable.
You can Click the button or Shift Click any quest title in the quest log to add it to the watch list.  When you pick up a new quest it will be automatically added to the watch list.  Any quest can be watched including quests with no objectives.  You can add as many quests to the watch list as you like. If you Shift Click a quest category header it will add/remove all quests under that category.

Right Clicking a quest in the quest log will bring up a menu with additional options.

 Menu:
  Watch All Quests will mark all quests as being watched, so they show in the Watch List.
  Share will try to share the quest with your party.
  Abandon will ask you if you want to abandon the quest.


The quest log has 3 additional tabs:
- History: a history of completed quests
- Database: a searchable list of quests in the database (shows current map zone by default)
- Player: You can Right Click another Carbonite user's map icon to retrieve their quests.  Their quests will show up in this tab.


Quest Watch List

The watch window is draggable but not sizeable.  It grows and shrinks as needed based on the quests you are currently watching. The Watch window can be made into a sizeable scrolling list if "Use fixed size list" is checked in the Quest Watch page of the Options window.

The green button toggles if all watched quests will be shown on the map and is on by default.

The purple "Auto Track" button will target the highest priority quest objective and updates dynamically as you move. Priority is based on distance, quest level and if the quest is complete.

The yellow/blue "Quest Givers" button shows Quest Giver icons on the map. Normal ones are shown as parchment icons. Daily quest givers as blue ! icons.

 Button colors:
  Dark yellow = No givers
  Yellow = Quest givers and daily givers
  Blue = Daily givers

The white "Show Party Quests" button determines if quests from other party members with Carbonite will also be shown in the Watch List.



Quest Watch List Objective Buttons

The round buttons to the left of the quests/objectives have several functions.

Left Click will activate "GOTO" mode.  This display the location and direction of the objective on the world map.  The map will scale so that you and your target are always visible.

Shift Left Click will toggle the display of quest objectives on/off, but not track it.

Alt Left Click will send a status message about the quest to party chat.

Right Click will bring up a menu with additional options.

Alt Right Click will open the Quest Log with that quest selected.

The black squares will show a tooltip with quest information if you put the mouse cursor over them.


-- HUD

The HUD arrow turns on whenever you are using the GOTO feature.  The arrow will point to the target and show you the name, distance and estimated arrival time.  The HUD arrow can be moved by dragging the title bar.

Left Clicking the arrow will target a player if it is pointing at a player.
Right Clicking the arrow will target the target of a player if it is pointing at a player.


-- Guide

The guide is your in-game GPS with the location of various points of interest.  You can bring up the Guide by Clicking the Guide button on the map window (Question Icon).  By default the map will show you common POIs such as mailbox, bank, flight path, etc. when the map is zoomed in to a certain level.

You can Right Click any POI icon to GOTO it or paste the name & coordinates into a chat message.

Clicking any guide button will display the POI on the map and activate the GOTO mode where appropriate.  

Some guide categories have subcategories ( >>> after the text).  If you Click the text it will open up the subcategory.  Pressing the back button will move back up one level. 

We plan to add new categories based on user feedback, such as browsing honor/arena rewards.


-- Warehouse

The Warehouse enables you to browse the equipment and information of every one of your characters at one time.  You can bring up the Warehouse by clicking the Warehouse button in the map window (Chest Icon at bottom of map).

The Warehouse window has a list of your characters on the left side and items on the right side. You can select your characters in the left panel while the right panel displays their inventory, bank or profession items. Clicking a name in the left shows the items. Clicking a profession shows what can be make or done using the profession. You have to open each profession window for the data to get recorded in the Warehouse. This also records a profession link, if it has a link. You can the left click the chain icon to paste the link into an open chat edit box.

You can link items from the warehouse by clicking the item icon.

There is a search field at the top right of the window.  You can type any text into this field and it will display matching items below. 

You can click on "All Characters" and it will display all the items of all your characters at once. This is a useful feature when you are trying to track down specific items.

Equipped items are listed first; other items follow grouped by category. The number in front of an item name shows the total number that the current character or all characters have. It will be blank if the count is one. The numbers after the name are the amounts in inventory and bank.

Right click the list for a popup menu that allows you to turn off the category headers.
If you left click on an item it will display the names and total count of any characters with the item. Click the names to hide them.

After installing Carbonite for the first time, it is a good idea to open up the bank with each of your characters to populate the warehouse data.

The sync command in the Warehouse menu imports characters from other accounts in the transfer file that match the current server and exports all current server character data as recorded in the Warehouse. Every character stat that the Warehouse tracks is transfered. You would then copy the CarboniteTransfer.lua file from the SavedVariables folder of the current account to the other account's SavedVariables folder.

The only requirement is that the "Remember Account Name" setting at the account login screen be checked when you login, so Carbonite can know which account you are on when you sync. That is stored in the CVars if it is checked.


Transfering settings to other characters:

You can move the window layouts and other settings from a character to all your other characters. You would login with the character that is setup the way you like. Open the Warehouse. Right click the list on the right half of the window. Select "Export current settings to all characters" and click "Export" on the message box.
 
You can also do it the opposite way using "Import settings" from the same menu, but you would have to do that on each character.


-- Social window

The Social window is opened by pressing the O key and contains the normal friends window tabs and the Carbonite "Pals" and "Punks" tabs.

Pals:

The "Pals" tab keeps track of your friends across all your characters and lets you add them as friends on any character you log in with. It also lets you assign a character to a person, so you can group characters according to the player that owns them. Right click the list for a menu of commands.

The Pals List automatically adds the names of any friends the currently logged in character has. The game keeps a list of friends separately for each character. The Friends List can have a maximum of 50 characters. Pals info is stored by Carbonite for the realm, so you can see all Pals on all characters you have on a realm.

A Pal character name will show in red if they are not on the Friends List of the character that is currently logged in. Right click the name and select "Make Pal Into Friend" to add that Pal to the current character's Friends List.

If you want to remove a Pal, you have to remove them from the Friends List on each character. An addon cannot remove friends from a character that is not currently logged in. Log in to each of your characters, right click the Pal name and select "Remove Pal And Friend". Once they are removed from each character, they will stop showing up as a Pal.

Punks:

The "Punks" tab is for finding enemy players and keeping notes on them. The list has a top and bottom section divided by a blue "-- Active --" line of text. The top lists the names of enemies you have manually added to the list and when detected you will get a message and the area of the map they were seen at will have a large green glowing circle around it and a red icon near the middle of the area. The bottom of the list shows recent punk detections. Those punk areas will show a red glow on the map. Right click the list for the popup menu. When you use "Add Character" from the menu it will add an enemy player to the top section of the list. If an enemy player is targeted it will use that name, otherwise an edit box will open and be filled with the name of the most recent punk personally detected near you. A chat message will show if a new punk is detected near you.

Punks list options are in the "Social & Punks" page in the Options window.

The Social window can be disabled, right click the Carbonite minimap icon and select "Options". Click "Social & Punks" in the left side list, uncheck the box on the right side and reload UI when asked.


-- Favorites window

The Favorites window has a left and right side.

The left side shows a tree of folders and favorites. You can put folders inside of folders. This works like a computer file system. You select a favorite for viewing or editing by left clicking it.

The right side shows the list of items that belong to the currently selected favorite.

There are 4 item types you can put in a favorite.

1. Comment. Just a line of text that shows in the favorite item list. Create by right clicking the item list and selecting "Add Comment".

2. Note. An item that has an icon, text and map location. Create by right clicking the map and selecting "Add Note". The note will be created in a favorite with the name of the zone. The favorite will be in the "Notes" folder. The note will set to the map location where you right clicked and will be set to the Star icon. Notes can be put inside of favorites that are not in the notes folder, but they will not automatically show on the map when the zone is selected. The point of that is so you can make a favorite with you own set of steps (dailies, quest guide) and have notes mixed with targets. When the "Record" button is on the note will go into the selected favorite instead of the favorite in the notes folder.

3. Target 1st. This is the first part of a path or a single destination. Has a name and a map location. These are created when the "Record" button is on and you ctrl click the map or right click the map and select "Goto".

4. Target. This is the next part of a path. Has a name and a map location. These are created when the "Record" button is on and you ctrl shift click the map.

Record Mode:

This is on when the Record button is pressed. The button will glow red. Any map targets created (goto, guide or quest selection) will be added to the currently selected favorite below the selected item. Record mode is canceled when a different favorite is selected.

Viewing:

Note items inside of favorites in the "Notes" folder will be automatically drawn on the map if the the selected zone name matches the favorite name. Notes in favorites in any other folder will only be drawn when selected in the item list. The Notes folder is meant to mimic how notes are managed in other addons. Generally you should not put items other than notes inside the favorites in the notes folder.

Targets are drawn on the map when selected in the item list. Each target after the selected one will also be drawn until a "Target 1st" or a non target is reached. This lets you see a whole path or part of a path.


-- Info Windows

Info windows show various bits of information in a small movable list.
Info #1 to #6 come with various default text in them.
Right click the Carbonite minimap button and select "Show Info 1 2" to make #1 and #2 visible. These are setup for the health and mana of you and your target.

To move or edit them, you need to unlock them on the Info Windows page of the Carb Options window.
Left click and drag the window title bar to move them around.
Right click a line in an unlocked info window and select "New" to show Info #3. Again will show #4 and so on.
Right click a line in an unlocked info window and select "Edit Item" to change the text for that line.

Info text:

<xxx> runs a command.
<c> is the color from the last command.
<t> is the text from the last command.
xxx is raw text.

Example:

<THealth><c>HP <t>
This runs the target health command, sets the color, shows the text "HP " and shows the text from the command.

You cannot currently add new lines to an Info Window, but Info #3, 5 and 6 have an extra blank line in them, which can be edited.

Info Window defaults:

#1 Your health, mana, DK runes, rogue combo points, global cooldown bar, casting bar.
#2 Target health, mana, casting bar.
#3 Durability, time to level.
#4 Battleground queues, start, duration, honor, stats.
#5 Time, FPS.
#6 Rest %


-- Battlegrounds

Carbonite adds clickable objective icons right onto your Battleground map.
Timer bars are displayed under each objective and you can mouse over to see the exact times.
Right Click on any objective to issue orders such as attack, defend, incoming, and to report time status.
Shift Click an objective to send an ‘incoming’ message.  Each Click adds one to the count.  E.g. Shift Click 3 times on the Lumber Mill icon and you will say “Incoming Lumber Mill: 3”

Hold down ALT to display player names (works anywhere, not just battlegrounds).
Hold down Shift to draw objectives on top of the player icons.

When a player is in combat his icon has an X in the middle.
The icon for each player has a health bar along the top and his target's health bar is displayed down the left side.

The HUD arrow will display the closest teammate that is in combat.  It will also point out friends/guildmates in the same battleground. When left clicked it will target that player and right click will target the target of that player.


-- Keyboard modifiers

Map:

 Shift down - Makes player arrow small. Draws BG objectives on top
 Shift click - Pings minimap if click is near the player arrow on the map
 Ctrl left click - Sets goto
 Alt down - Shows player icon names and makes icons draw on top

Minimap (in Carbonite map):

 Shift click - Pings
 Ctrl down - Makes integrated minimap draw on top or bottom if already on top
 Alt down - Makes docked minimap transparency 50%

List:

 Shift down - Makes mouse wheel scroll 5 times faster
 Shift + ctrl down - Makes mouse wheel scroll 100 times faster

Quest Watch:

 Alt left click button - Send quest status to party
 Alt right click button - Open quest window with quest selected

Keybindings you can set:

 Toggle Original Map
 Toggle Normal or Max Map
 Toggle None or Max Map
 Toggle None or Normal Map
 Restore Saved Map Scale
 Toggle Full Size Minimap
 Toggle Favorites
 Toggle Guide
 Toggle Warehouse
 Toggle Watch List Minimize

-- Map Icons

 Round solid icons are players:

  Yellow - friend
  Green - guild
  Blue - party
  Grey - non of the above

  Top Horizontal Bar - player health
  Mid Horizontal Bar - friendly target health
  Left Vertical Bar - enemy health (red glow if a player)
  x in center - in combat
  red in center - health low
  black in center - dead

 Round icons with black centers are for quests:

  White - quest ender if quest is simply to get to the end location

  By default there are 12 quest colors. Each quest starting at the top of the quest log has a different color. Once the 12 colors are used it repeats.

  Red - first quest in quest log
  Green - second quest in quest log
  Blue - third quest in quest log
  Yellow - forth quest and so on

  If "Use one color per quest" is off then
   Red - objective #1 or #4
	Green - objective #2 or #5
	Blue - objective #3 or #6

 Yellow ! - quest starter when you add a goto quest giver
 Yellow ? - quest ender

 Square icons with 4 black arrows are the closest point to reach a quest area:

  White color - is being tracked
  Non white colors match the same quest colors as described above.


-- Gathering

Carbonite tracks mining, herb, gas and everfost shard locations when you gather them.

To show them on the map for the selected zone:

Herbs - Right click a non icon area of map, select Show and check "Show Herb Locations".
Mining - Right click a non icon area of map, select Show and check "Show Mining Locations".
Gas - Click the Guide ? icon on map, left click "Gather >>>" and left click the Gas icon.
Everfrost chip - Click the Guide ? icon on map, left click "Gather >>>" and left click the Everfrost chip icon.

Routing:

Once any nodes are being shown on the map, you can right click a non icon area of map, select "Route..." and select "Current Gather Locations" to make a route on the map.


-- Carbonite Items

CarboniteItems is a data addon that contains information on over 25000 game items. It is a load on demand addon, which means it is not actually loaded until you use the "Items >>" section of the Guide. Left click the "Items >>" text to view the CarboniteItems data.

Mouse over the item icons to see a Carbonite generated tooltip of information on the item. The tooltip is similar to the normal game tooltip, but there are some minor differences. If the item icon is not shown as a ?, then the item is in the game's cache file, which means you can hold down the alt key and then mouse over the icons to see the game's tooltip for the item.

The "Search [click]" edit box filters the items shown in the list on the right side by searching the Carbonite tooltips of the items currently show. Some examples:

 spell pow    (items with spell power)
 hit rat      (items with hit rating)
 mana per     (items with mana regeneration)
 quest:       (items from a quest)
 minor        (only minor glyphs)

The first tooltip line that matches the filter will be shown in the Info3 column.

Left click a column header to sort by that column.
Shift left click a column header to decrease the column width.
Shift right click a column header to increase the column width.


-- Carbonite Nodes

CarboniteNodes is a simple data addon that contains predefined locations for Herbalism and Mining. It is a load on demand addon, which means it is not actually loaded until you import data from it into Carbonite.

To import the data into Carbonite's gather data, you right click the Carbonite minimap button, select "Options" and select the Guide page of Options window. You would then left click the text that says "Import Carbonite Nodes Herbalism locations" to get the herbs and "Import Carbonite Nodes Mining locations" to get the mining data.


-- Carbonite Transfer

CarboniteTransfer is a simple addon that is used to move Warehouse data between accounts. It will also be used to send and receive favorites in the future. You can delete it or disable it, although it takes almost no memory since it is empty until used.

In the Warehouse you right click the character list and select "Sync account transfer file" and any characters from your other synced accounts are imported from the CarboniteTransfer.lua file and characters in the current account are exported to the CarboniteTransfer.lua file. The file is then copied to the Savedvariables folder of another account, so you can sync the Warehouse data when you login with that account.

Transfering is a manual process, because addons cannot directly access files and can't see addon data from other accounts. You have to copy the CarboniteTransfer.lua file from one SavedVariables folder to another.

Example:

1 Login to any character using AccountA.

2 Select "Sync account transfer file" from the Warehouse menu.

3 Logout. Go back to Account Screen, which saves the CarboniteTransfer.lua file.

4 Copy WTF\Account\<AccountA>\SavedVariables\CarboniteTransfer.lua  to  WTF\Account\<AccountB>\SavedVariables\CarboniteTransfer.lua

5 Login to any character using AccountB.

6 Select "Sync account transfer file" from the Warehouse menu. AccountB will now have Warehouse data from AccountA.




----------------------------------------------------------





