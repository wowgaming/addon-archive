***********************************
Proximo 2.3
***********************************

Website - http://grayhoof.wowinterface.com/

What is it? - Simple enemy unit frames for Arena matches used for identifying and coordinating targets

Features:

- Unit tracking via mouse over, target, party targets, death messages, name plate updates, and optional syncing between all teammates
- Main Assist setting and syncing, shown by yellow outline on current Main Assist target.
- Optional New Enemy, Low Health, Death, and Aura announcements via Chat, Party, RaidWarning, SCT, or MSBT.
- Optional Focus setting via right click.
- Optional Mana bars.
- Optional Party Targets.
- Optional Race Icons.
- Optional Aura tracking.
- Optional Cast bars.
- Optional Talent Guessing.
- Optional Battle Ground Support.
- Minor frame customizations: size, font, texture, header, etc...

Where did it come from? - After using ArenaMaster for a long time, I decided to make my own Arena based mod based some some ideas from myself and friends.

How do I use it? - Unzip Proximo into your interface\addons directory. For more info on installing, please read install.txt. Type /prox test to see a test frame when not in arena. Alt+left click header to move. Right click header for options.

What happens if an enemy is first seen after combat starts? - They will still be shown and synced, however you will not be able to target them by clicking on their bar. This will be designated with **'s around their name (ex. ** Grayhoof ** ).

Thanks To
ArenaMaster for the idea of an Arena Frame
Kelyk and Gromphe for endless testing
kinta for the ideas and examples of using keybindings

Support
Please post all errors and suggestions on http://grayhoof.wowinterface.com/ using the provided forms.

Version History
2.3 - Added New "Use in Battlegrounds" option. It basically just becomes a "last 5 targets" unit frame for self only, and doesn't sync with other users. Added new talents using TalentGuess-1.0. Provides talents as best as possible based on comblog events and buffs. Converted to using ShareMedia Widgets for Ace3. Added Frost Nova to tracked auras. Fix for highlighted frames staying after leaving and re-entering an arena. Register SML callbacks correctly.
2.2 - Converted Auras to use spellid. Fixed Profile copies/changes. Removed unneeded locals. Convert to LibShareMedia-3.0.
2.1 - Fix for combat log names. Added optional cast bars. Cast bars for your focus and target will be accurate, while others are only approximations. Options for cast bar: color, size, font size, time. Made more of the frame clickable, besides just the health bar. Converted to quicker combat log method. Gave main frame a name
2.0 - Converted to WoW 2.4 Combat Log. Converted to Ace3. Added optional Race Icon. Added important but limited buff and debuff tracking. Added options to lock frame, grow frame size, and grow frame up. Added click functionality for Mouse3, Mouse4, and Mouse5. Moved options menu to WoW 2.4 Addons Menu.
1.4 - Changed Arena zone code, removed Babble-Zone as a result. Fixed RaidWarning announcements (though doesn't work as well). Moved localization to its own folder. Added optional talents display using the 2.2 new talent API. Talents currently work for enemies but may not in a future update. Note you may need to increase the width of your bars or reduce font size to make talents display properly.
1.3 - Added FR localization. Changed up zoning logic. Changed up MA logic. Changed up window movement code.
1.2 - Cleaned up syncs to only update when data changes. Changed class passing to use a standard name instead of localized name. Non enUS clients must all be running 1.2 if anyone in the group is using 1.2. Added option to display class in text. Added left click options. Added Target and Macro as options for clicks. Fixed mind-control issue. Add usage text on test function. Made option menu not appear in combat or after arena starts. Fixed adjusting frame sizes. Cleaned up bindings framexml.log errors
1.11 - Added Version Check. Added option to cast spell on right click. Cleaned up options. Added Key Bindings. Added slightly faded color and sound when clicking a frame for an enemy that was added during combat.
1.1 - Added party targets and options. Added mana bars and options. Added multiple highlight options. Added low health announcements and options. Cleaned up Syncs. Added option to turn of syncs. Cleaned up friendly units being added as enemy. Lots of general code clean up.
1.0 - Initial Release






