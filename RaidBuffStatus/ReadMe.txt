Instructions: http://www.wowace.com/addons/raidbuffstatus/

Version 1.0 8th March 2008
- This version checks raids for:
- Fortitude
- Mark of the Wild
- Intellect
- Spirit
- Shadow
- Intelligently skips checks of buffs from classes that are not in the raid
- Intelligently spots priests with the spirit talent and skips spirit check if there are none
- Checks that paladins don't have shadow aura and priest shadow aura as they don't stack
- Food buff
- Flask or Battle and Guardian elixir
- AFK
- PVP
- Dead
- Offline
- In different zone
- There is a different aura per paladin per group
- All paladins have an aura
- Paladins for Crusader Aura
- Chars with < 80% mana
- Chars with < 80% health
- Works in a party and a raid
- Only allow you report to raid if you are a leader or assist but always allows report to self or party
- Checking for a buff or warning can be enabled or disabled by clicking on the buff button
- Window position and buff options are preserved between logins
- Support profiles
- Support debug mode
- Window auto shows and closes when joining or leaving a party or raid
- Currently it scans every 6 secs or on buff event.

Version 1.1 9th March 2008
- Currently it scans every 10 secs or on buff event.
- Hunter with no aspect
- Hunter with aspect of the pack or cheetah
- Protection paladin with no Righteous Fury
- Checks events actually registered before unregistering
- Fixed bug: Shadow and Aura at same time check not enabling
- Fixed bug: Sometimes an inspect fails and this is now captured
- Fixed bug: Noisy talent inspection addons would interfere with the inspect ready event so
   this is handled by using a secure hook
- toc file now has svn revision information
- Check someone has a soul stone

Version 1.2 14th March 2008
- Fixed bug: Re-showing all the time.  Now hiding stays hidden until you join a party or raid again.
- Added to the Well Fed check "Increased Stamina", "Rumsey Rum Black Label", and "Electrified".

Version 1.3 24th March 2008
- Added German translations. (Done by Farook)
- Completely re-worked how buttons and buff checks are stored and displayed.  Now it is completely
   dynamic thus making it easier to add more checks and an options window in the near future.
- Boss only buff checks are now in their own section.
- Window title changed to RBS 1.3.
- Disabled-manually buffs now display a "." instead of being blank so you can tell the difference
   between disabled and not being used due to lack of a class.
- Soulstone is now a boss check only.

Version 1.31 25th March 2008
- Added /rbs toggle option for toggling open and close the dashboard.
- Fixed bug: frame and icons not on same level.  Now comes to front when clicked.
- Fixed bug: offline check would not disable.
- Fixed bug: tooltip was much too wide when many people need a buff.
- Added ability to shift click and report only on a single missing buff.
- Priest with spirit buff detected now only appears if you are the leader.
- Added check for Inner Fire.
- Fixed bug: missing number of buffs and warnings are correctly counted again now.
- It no longer says it has activated on start.  No need to add to the other spam.

Version 1.32 26th March 2008
- Updated to WoW version 2.4.
- Added missing flasks Mr Pinchy's Blessing, Flask of Blinding Light, Flask of Pure Death.
- Added new 2.4 flasks Shattrath Flask of Pure Death and Shattrath Flask of Blinding Light.
- Mouse-over hi-lighting added.

Version 1.40 1st April 2008
- Changed talent inspection to work properly with 2.4.
- Added check for Fel Armor.
- Added a talent and specialisation report window.  Many more specialisation reports to come in future.
- Moved the spirit buff talent announce from raid chat to just display on the talent report window.
- Added a talent report for priests with improved spirit buff.
- Tidied German translations file.  It sill needs some translations.
- It now ignores players in groups 5 and above.  This is a temporary change until something better is written.
- Text colours now set properly.
- Fixed bug in dynamic button layout maths.
- Added report for Druids with improved Mark of the Wild.

Version 1.41 2nd April 2008
- Added report on Warlock healthstone talents.
- Added check for Druids who have the Omen of Clarity talent point that they have self buffed with it.
- Fixed Shattrath Flask of Pure Death and Shattrath Flask of Blinding Light.  Stupid Blizzard inconsistent naming.
- Fixed missing tool tip for Shadow Aura and Protection.

Version 1.42 4th April 2008
- Added diplaying of group number next to the character name on group buffs.

Version 1.43 5th April 2008
- Displaying of group numbers is now sorted by group number in the report.
- A number of the buffs are no longer checked if the person is not in the same zone.
- Rogues and Warriors are now ignored for Intellect and Spirit buffs.
- Reports on Priests with Lightwell ability.
- Reports on Priests with improved Power Word: Fortitude.

Version 1.44 8th April 2008
- Added check that a Mage has an armor self buff.
- Default talent report sort order is class now.

Version 1.44b 9th April 2008
- Fixed MotW report.  It incorrectly reported 4 or 5 points spent even when they where not.  Spotted by Tanagra in a code review.

Version 1.44t 10th April 2008
- Added Spanish translations by Tanagra on Kul Tiras Europe server.
- Added French translations by Veve CDO EU Server.
- Fixed bug causing error when other addons check talents.
- Added zhTW translations.  Actually someone ninja added it to SVN not me.

Version 1.44u 12th April 2008
- Fixed German translation by commenting out the translations not done and by doing some.

Version 1.45 12th April 2008
- Added a Ready Check button.

Version 1.46 20th April 2008
- Corrected positioning of the Ready check button.
- Hidden Options Window button as it's taken longer than expected to get around to implementing it.
- Removed BabbleSpell and instead use GetSpellInfo() with spell IDs.
- Removed a huge number of translation lines that are now automatically translated using GetSpellInfo().
- Added some translations for the Ready check button.
- When no buffs are needed it now also lets you know if it was a Boss or a Trash check.

Version 1.46t 21st April 2008
- Corrected some Spanish translations.

Version 1.50 30th April 2008
- Added options window which allows you to configure which buffs to check and when.

Version 1.60 11th May 2008
- Added the ability to Ctrl-click a self buff and have the addon whisper those who need it.
- Added some Spanish translations.
- Added a talent report for Paladins with Kings and Sanctuary.
- Added a talent report for Warriors with improved demo shout.
- Auto-disabled buffs are now faded out on the dashboard for improved clarity.
- Disabled buffs are now faded out and have a cross on the dashboard for improved clarity.
- Shift clicking a missing buff will now display in raid "Missing buff:" or "Warning:" as appropriate.
- Sorting has been made slightly neater.
- Added a new warning which checks the flasks are correct for the zone, eg Unstable at Gruul.

Version 1.61 13th May 2008
- Fixed some translation and zone issues with the flask zone checker.
- Added some Spanish translations.

Version 1.70 21st May 2008
- Added a feature where it tells you how long someone was AFK, Offline, PVP or dead.
- Added a feature where Ctrl-click Shadow Protection and it will whisper all the Priests a list of who needs it.
- Added a feature where Ctrl-click Arcane Intellect and it will whisper all the Mages a list of who needs it.
- Added a feature where Ctrl-click Mark of the Wild and it will whisper all the Druids, with the most talent points spend in MotW, a list of who needs it.
- Added a feature where Ctrl-click Fortitude and it will whisper all the Priests, with the most talent points spend in Fortitude, a list of who needs it.
- Added a feature where Ctrl-click Spirit and it will whisper all the Priests, with the most talent points spend in Spirit, a list of who needs it.

Version 1.71 28th May 2008
- Added the option to hide selected dashboard items on entering combat to reduce the size and only show what matters in combat.

Version 1.72 30th May 2008
- Added a check for Priests, Mages and Warlocks with Blessing of Might.  And Rogues with Blessing of Wisdom.
- Added a check that looks for players obviously missing Paladin blessings.
- Added a check for Amplify Magic. It is disabled and hidden by default as most encounters don't need it. Enable in the options window.

Version 1.72b 31st May 2008
- Fixed some of the Paladin blessing checking especially when in a party.

Version 1.73 2nd June 2008
- Fixed bug with Paladin blessings and Feral Combat druids and Enhancement Shamans.
- Added temporary weapon buff checking.  Warning: This is experimental code.

Version 1.80 27th June 2008
- Fixed some bugs with temporary weapon buff checking.
- Removed the warning about temporary weapon buff checking being experimental.  It seems to work but is range limited.
- Melee dps with a temporary weapon buff and are in a group with an enhancement shaman will show a warning.
- Reworked Paladin blessing checking to cope with fringe scenarios better.
- Party based buffs now show in the tooltip who the buffers are, as well.
- Added a fake buff button.  The tooltip gives help information.  It can be disabled in the options window.
- Alt-click on a self buff will renew that buff.
- Alt-click on a party buff will cast a spell on someone in a party missing that buff.
   If 3 or more people are missing, the longer reagent buff will be cast otherwise the shorter one.

Version 1.81 29th June 2008
- Fixed bug in Paladin blessing checking for Druids and Shamans.

Version 1.81g 30th June 2008
- Fixed problem with German translation file.

Version 1.81h 5th July 2008
- Fixed bug causing an error to pop up sometimes when the tank list is set up.

Version 1.90 6th July 2008
- Role information and main tank lists are now parsed to be able to know who is a tank.
- Added a new warning for melee tanks missing thorns.
- Added a new warning for tanks with salvation.
- Group 6 is no longer ignored so you must use groups 7 and 8 for reserves.  This will be configurable in the future.
- Buffers on tooltips now in green to make it clearer.
- Added a button that shows the tanks.  Hidden by default.  The tanks listed are, in theory, true tanks and not just
   those listed on the tank list.  I.e. it looks at spec etc.

Version 1.91 10th July 2008
- Added a minimap button.
- Group 6 is again ignored due to popular demand.  This will be configurable in the future.

Version 1.92 27th July 2008
- Added Righteous and Blessed Weapon Coatings to the weapon buffs list.
- Added talent report on improved Battle Shout.
- Added some checks for being in combat or not and if in combat disable some protected actions causing taint log spam.

Version 1.92t 30th July 2008
- Updated Spanish translations.

Version 1.93 1st August 2008
- Added a Blizzard UI addon options pane.
- Added option to ignore or not groups 6 to 8.
- Added option to hide or show the Minimap icon.
- Added option to report only to self instead of raid.

Version 2.00 13th August 2008
- Ported from Ace2 to Ace3 framework.  Ace3 is faster and uses less memory and provides nice config widgets.
- You can now alt-click on tanks missing thorns to automatically buff just like the party buffs.
- Reworked buff checking to be faster and also to not check buffs that are not displayed during combat.
- Raid scanning is now rate-limited so combat action will not cause lots of CPU usage.
- Ace 2 Aura-Special-Events library (seemingly-no-longer-maintained) has been replaced with a few lines of my own code.
- Fixed taint error on clicking on self buffs during combat.
- Corrected Rumsy Rum Black Label spell id.
- The few remaining spells referenced by name are now by number for speed.
- Fixed a long standing bug where if you were the same class as somone who was offline you might be skipped for buff checking.
- Added the option to report to some different channels.
- Added an option to allow you to configure the number of buff columns and hense the width and height.
- Implemented my own minimal replacement for Ace 2 Gratuity library.
- You can now change the colour and alpha of the window.

Version 2.01 14th August 2008
- Fixed issue with it not reading the tank list when reconnecting when already in a raid.

Version 2.02 23rd August 2008
- Added check for Trueshot Aura.
- Added an option to completely disable the dashboard and buff checking during combat.

Version 2.02t 25th August 2008
- Updated Spanish translation.
- Added Simplified Chinese translation.

Version 2.03 25th August 2008
- Added an option to allow you to configure if the dashboard automatically shows or not when you join a party or raid.

Version 2.04 31st August 2008
- Cybersea fixed Inner Fire spell checking. It has been broken since version 2 as it was using a spell name instead of a spell id.
- Added an option to switch off or on the group number of a person in reporting.
- Added an option to spam "RBS::" a lot less.
- Added some more simplified Chinese translations.
- Fixed weapon buff checking with enhancement shamans.  Now it knows druids don't get Windfury.

Version 2.05 2nd September 2008
- Added talent report for Earth Shield.
- Added buff check for Shaman Water Shield.
- Added some simplified Chinese and Spanish translations.

Version 2.06 7th September 2008
- Added talent report for Aura Mastery.
- Added some Spanish translations.

Version 3.00 29th September 2008
- Modified to work with WoW 3.0 patch changes.  In theory should work.

Version 3.01 8th October 2008
- Added talent report for Circle of Healing talent.

Version 3.02 18th October 2008
- Removed Omen of Clarify check as it is now passive.
- Fixed some spellids which had changed.
- Fixed issue with reporting Kings and blessings calculations.
- Added report to show Sacred Cleansing.
- Reduced the need for manual translations for the specialisation reports.
- Added report to show improved Retribution Aura.
- Added report to show improved Devotion Aura.
- Added an option, enabled by default, to report MANY! instead of spamming all people missing a raid/party buff when it's more than 3.
- Alt clicking party/raid buffs is now aware of raid-wide buffs and also will cast reagent spell if more than 3 (rather than 2) require the buff.

Version 3.03 24th October 2008
- Fixed Trueshot Aura spell id.
- Fixed Paladin blessings hopefully.  They are not perfect due to not counting stacking yet.
- Added a check for Vigilance being cast on tanks.

Version 3.04 26th October 2008
- Added check that someone has focus magic when a mage has the talent point spent.
- Changed the code to know the difference between raid-wide and party-wide buffs. I.e. Shadow Protection is handled better now.
- Added support for the new temporary weapon self buffs Spellstone, Firestone, Flametongue and Earthliving.

Version 3.05 29th October 2008
- Removed aura per group checking as auras are now per raid.
- Reduced the font size slightly so it does not display 25 as ... any more.
- Fixed whispering of floating poo missing.
- Increased the number of buffs possible from 24 to 32 fixing incorrect reports of missing buffs.

Version 3.06 2nd November 2008
- Fixed alt-clicking on Amplify Magic
- Removed Enhancement Shaman with weapon buff check as Windfury now stacks.

Version 3.07 4th November 2008
- Fixed, again, paladin blessing checking.

Version 3.10 18th November 2008
- Added basic Death Knight support.

Version 3.20 22nd November 2008
- Added Aspect of the Dragonhawk.
- Added Shaman weapon self buffs.
- Weapon buff checking now will report missing weapon buff if main or off hand are missing.  Previously it would report if both were missing.
- Added Bone Shield.
- Added Death Knight Auras.
- In theory all important 71-80 buffs are now added.

Version 3.30 26th November 2008
- Added WotLK Elixirs and Flasks.

Version 3.31 11th December 2008
- Added support for Death Knight tanks.

Version 3.32 17th December 2008
- Added a bunch more battle elixirs.

Version 3.40 22nd December 2008
- Added LibDataBroker support for Titan etc.
- Fixed Bone Shield checking to be talented.
- Maybe fixed Earth Shield bug.

Version 3.41 29th December 2008
- Fixed weapon buffing as only Rogues, Locks and Shaman can do it with lvl 80 weapons.

Version 3.42 30th December 2008
- Fixed weapon buffing for Locks.
- Fixed error on tooltip when not in a raid in options window.

Version 3.43 8th January 2009
- Fixed weapon buffing for Shamans without dual wield.

Version 3.44 9th January 2009
- Fixed and improved Paladin blessing checking.

Version 3.45 10th January 2009
- Made reporting which blessing is missing configurable.
- Fixed wrong spec checking for DK tanks.

Version 3.46 19th January 2009
- Fixed Mighty Defense.  Correctly now labelled as a Guardian elixir.
- Removed checking for Intellect on Death Knights.

Version 3.47 20th January 2009
- Now re-checks spec every 10 mins in case of in-raid respec.
- Spec checking is now faster.
- Raid buff checking on dashboard is now more frequent.

Version 3.48 22nd January 2009
- Removed checking for Spirit on Death Knights.
- Removed wrong blessing checker as the missing blessing checker will tell you enough info.
- Added an option to configure how many is MANY.  This also changes how many are needed before using a reagent to buff.
- Added an automatic reagent checker for buffing.  If you run out it will instead use the shorter spell.

Version 3.49 23rd January 2009
- Added option to configure what the addon does depending on which mouse button is clicked.
- Added option to configure how quickly the addon re-scans the raid for missing buffs.
- Updated Shadow Protection since 3.08 it is now raid-wide.

Version 3.50 24th January 2009
- If Shaman has Static Shock talents then accept Lighting Shield as an alternative to Water Shield.

Version 3.51 24th January 2009
- Added an option to not include TBC flasks and elixirs in the allowed buffs.
- Added a warning to warn when players are using TBC flasks and elixirs.

Version 3.52 25th January 2009
- Fixed flask and elixir checking.

Version 3.60 27th January 2009
- Added very basic scroll checking.  Disabled by default due to being in testing.

Version 3.61 10th February 2009
- Now ignores mana check for Feral Combat Druids always.  Previously it would ignore if shape shifted only.

Version 3.70 15th February 2009
- Actions which require you to be a raid leader or assistant now warn you if you have not been promoted rather than doing nothing.
- Fixed a bug with some ancient unused code which caused RBS to stop working when using with Lootster.
- The out of range warning is now more visible.
- Added a whole new feature.  This feature allows you to see when people are taunting your mob.  This is useful in boss fights where one needs to swap tanks and to find out when a Death Knight accidentally taunts Malygos.

Version 3.71 22nd February 2009
- Some code tidying where I moved the buff checking code to another file.
- Added option to write tank warning to raid chat.
- Added option to warn if someone targets a mob and taunts that mob and it is targetting you.

Version 3.80 1st March 2009
- Fixed Bone Shield checking.
- Added talent report for Vigilance.
- Added a check that all Warriors with Vigilance have used it.
- Any DK on the tank list is now considered a tank.
- Added talent report for improved Anti-Magic Zone.
- Amplify Magic buffers are now chosen according to how many points are spent in improving it.
- Added talent report for improved Amplify Magic.
- Fixed alt-click Amplify Magic.
- Added Lesser Flask of Resistance.
- Paladin blessings now have MANY! support.
- RBS now uses PallyPower addon to track blessing assignments to report which paladin is slacking on his buffing.
- Spec checking is now every 300 seconds rather than 600.
- Fixed a race condition bug when talents are being inspected and you zone.
- Maximum line length of a message is now 150 instead of 250.


Version 3.81 7th March 2009
- Fixed a bug with Vigilence talent checking.
- Fixed a display bug when changing the number of columns on the dash.
- Added a new feature which optionally shows status bars for things like tanks health, healer mana, dead people etc.
- Slightly changed the heuristics for detecting if Druids or Paladins are tanks.
- Water Shield and Lightning Shield check now says both names.

Version 3.82 9th March 2009
- Fixed slacking paladins report.
- Missing paladin blessings whispers now only go to those assigned the blessing.
- In general paladin blessings checking is now much more integrated with Pally Power so the reporting is clearer and only shows missing blessings actually assigned.
- Fixed Power Word: Fortitude talent checking.
- Fixed race condition with the Alive status bar.
- Fixed the windows background colour so it can actually be set to an alpha of 100% now.
- Changed the text an appearance of the status bars to be much clearer and handle different colour schemes better.
- Added missing Elixir of Protection and Mighty Mageblood.
- Changed status bars tooltip titles to have percent signs where appropriate.
- Added Tanagra's Spanish translations.

Version 3.83 12th March 2009
- One can now buff one's own assigned blessings with alt click although it does not do pets.

Version 3.84 13th March 2009
- Fixed casting of Paladin blessings.

Version 3.85 15th March 2009
- Out of range now clarifies which and whom.

Version 3.86 2nd April 2009
- Blessings tooltip now shows slacking Paladins.
- Blessings tooltip now warns if Pally Power is set wrong or missing an assignment.
- Fixed DK Unholy Aura talent report.
- Removed event for when player buffs change for performance.
- Changed tooltip wrapping.

Version 3.87 6th April 2009
- Moved all global variables to within RaidBuffStatus. to prevent collisions with other addons.

Version 3.88 7th April 2009
- Fixed errors with Paladin Blessings and Vigilence checks when no Paladin or not in a party/raid.

Version 3.89 7th April 2009
- Fixed errors with whispering caused by the global variable changes.
- The "Good TBC" option now enumerates in the tooltip the flasks and elixirs I consider comparable with WotLK.

Version 3.90 14th April 2009
- Added an option to use MANY! when whispering.
- Added an option to highlight buffs for which one must take action such as eat or buff.
- Added support for X-Perl tank list.
- Corrected talent checking for Bone Shield and Anti Magic Zone.

Version 3.91 14th April 2009
- Fixed a problem with having flask zone checking disabled but flask checking enabled.
- Fixed the highlight buffs for blessings.

Version 3.92 16th April 2009
- Version bump to be compatible with patch 3.1.
- Removed DK aura checking as they no longer have auras.
- Changed Spirit checking as all Priests now have it.
- Changed Kings checking as all Paladins now have it.
- Updated talent checks for Circle of Healing, Improved Retribution Aura, Sacred Cleansing, Dual Wield.

Version 3.93 18th April 2009
- Added an option to only allow 40 Stamina food.
- Removed Electrified, Enlightened, Increased Stamina and Rumsey Rum Black Label.

Version 3.94 19th April 2009
- Crusader Aura check now knows which Paladin is responsible.

Version 3.95 19th April 2009
- Fixed bug due to changes with dual spec.

Version 3.96 20th April 2009
- Added talent reports for Demonic Pact, Earth and Moon, Improved Faerie Fire and Ebon Plaguebringer.
- Added a refresh button to the talents report window to force it to re-scan all talents.  It automatically re-scans every 4 mins anyway.

Version 3.97 25th April 2009
- Added an option which makes Alt need to be held down to move the dashboard.
- Fixed a race condition on exiting a raid to do with talent inspection.
- Modified Death Knight tank analysis to take into consideration points spent in Anticipation, Toughness and Blade Barrier.

Version 3.98 12th May 2009
- Added an option to give a raid warning when someone places a Fish Feast or a Refreshment Table.
- Added Mana Spring as an alternative to Blessing of Wisdom.
- Flask of Fortification is no longer considered a good Flask now that Flask of Stoneblood has been buffed so much.
- Updated ruRU from Hemathio.
- Removed Lesser Flask of Resistance as 50 resistance is pathetic and the drop in HP, DPS, HPS or MP5 from not using other flasks is not worth it.

Version 3.99 16th May 2009
- Added a "Well Fed but slacking" button for those who have eaten but it's not the the 40 stamina food.
- When there is no tank list when in a raid it will now switch to party mode and look at only spec.
- Added option to switch on or off the automatic use of Pally Power.
- Added option to switch on or off the automatic use of Pally Power when a Paladin is missing Pally Power.
- Added Lesser Flask of Resistance back in due to popular demand although in my tests it makes no noticable difference to damage taken in most fights.

Version 3.100 18th May 2009
- Changed missing Paladin blessing method to consider which specs are in the raid per class as a whole rather than per character to cope with some situations where different specs want different blessings and they are not available.  Basically fixed some situations where it said a blessing was missing or not set in Pally Power.
- Tooltips now dynamically update.
- Paladin aura checking now can spot Paladins missing an aura even if they are in range of another Paladin's aura.
- Now checks for Seal of Wisdom or Light on Holy Paladins who one expects will have a glyph using these seals.

Version 3.101 21st May 2009
- Paladin aura checking working again although it is not perfect.
- Raid warnings for Table and Feast automatically throttle back so will be much less spammy now.
- Fixed a bug where it would whisper people to buff others even when no buff was needed.

Version 3.102 25th May 2009
- When in combat, talents will not be re-read any more.
- A race condition with talent checking which caused the addon to stop working after a time has hopefully been resolved.
- Fish Feast and Refreshment Table announces will now delay for a short period and watch out for other people announcing it first to reduce spam.

Version 3.103 26th May 2009
- Fixed the anti-spam for Fish Feast so it actually works now.
- Added an option to show or hide in Battlegrounds.

Version 3.104 28th May 2009
- Updated esES and deDE.
- Added a durability check which uses oRA2.  However oRA2 will need a small change to work so for now this option is disabled by default. See http://www.wowace.com/projects/ora2/tickets/22-patch-to-allow-other-addons-to-query-ora2-for-durability/

Version 3.105 29th May 2009
- Now auto-detects if it is a pug and if so reporting to raid is allowed without having to be an officer or leader.

Version 3.106 31st May 2009
- Another attempt to fix a talent inspection bug.

Version 3.107 31st May 2009
- Tooltip for Shaman shield updated to make it clear it also looks for Lightning Shield (when talent points are spent in it).
- Alt-Click self buff for Shaman shield will now automatically cast Lightning Shield rather than Water Shield when talent points are spent in it.

Version 3.108 31st May 2009
- Durability check is now every 3 mins instead of 4 and also never occurs in combat.

Version 3.109 4th June 2009
- Again another attempt to try to solve a mystery bug.

Version 3.110 7th June 2009
- Added some error checking around where the bug happens so I can get further to the cause
- Fixed the random-delay-to-avoid-food-spam so it is not always the same number.

Version 3.111 9th June 2009
- Some tidying of talent inspection code.
- Fixed whispering for the durability check.
- Buffs which you are missing but are not your responsibility (which are red) are now light green so you know at a glance which slacking buffers to poke for oneself to be buffed.
- Fixed durability check to show zero durability if any items are broken.

Version 3.112 11th June 2009
- Fixed a bug which meant that RBS would continue to do talent checks during combat if the dashboard was enabled during combat.
- Slight tidy of talent checking code.

Version 3.113 11th June 2009
- Ctrl-click soulstone now whispers all the locks.
- Soulstone tooltip now lists the locks.

Version 3.200 18th June 2009
- Added Crown Control breaking warnings but with a unique-to-RBS-twist - it can differentiate tanks and non-tanks so can be configured to only warn when a non-tank breaks it for example.
- Tank taunt warnings now show raid icons.
- When Fish Feast or Refreshment Table is announced, it checks to see if the person placing it is the player.  If so it pings the map on the player.
- Now when considering which spec someone is it sees which tree has more than 36 points rather than more than 31 as per TBC.

Version 3.201 28th June 2009
- Fixed Repentance and Hex breakage being blamed on the CCers.
- Fixed problem with sometimes Fish Feast or Refreshment Table announcements would be announced twice in some rare situations.

Version 3.202 5th July 2009
- Fixed bug where the dashboard would not show when it was configured to show in raid but not party and the party is converted to raid.
- Added the ability to only show when you break Crown Control.
- Talent re-checking is now every 2 mins instead of 4.
- Added a check and talent report for Shadowform.
- When someone has low durability it now re-checks every 30 seconds when out of combat.
- You can now Ctrl-click on the Boss and Trash buttons to whisper everyone missing something.

Version 3.203 6th July 2009
- Fixed bug where it might not buff a blessing if someone in the class needing it was out of range.

Version 3.204 17th July 2009
- Updated to use WowAce Localisation system.

Version 3.205 19th July 2009
- Added an option to ignore spec when there is a tank list when determining who is a tank.
- Added an option to announce to raid warning when a Soul Well is prepared.
- No longer attempt to inspect talents of people who are dead.
- Fixed bug where the Blizzard standard main tank list would be ignored.
- Detection of Fish Feast now uses a spellid so it compatible with all languages without needing a translation.
- When a Soul Well, Fish Feast or Refreshment Table are about to run it out it now does a raid warning.
- Added some checks to prevent bad talent scan results being used.

Version 3.205 21st July 2009
- Standardised the tooltips text for missing buffs.
- Fixed bug in Soul Well detection.
- Fixed string in options for tank taunt warnings.
- Added Soul Link buff checking and talent report.
- Added "Role" to talent report window.
- Added talent report for Improved Blizzard.
- Updated anti-spam Food Announce code to hopefully be more reliable.

Version 3.206
- went missing

Version 3.207
- Fixed bug in talent role report causing an error when there was a Shaman or non-healing Druid in the raid.

Version 3.208 28th July 2009
- Increased some button sizes to fit German translations.
- Added translations for specs which should fix the roles problem in deDE.  But if this fixes it then how was blessings and scroll checking working???
- Hybrids now show unknown role until spec is determined.

Version 3.209 29th July 2009
- Fixed translation strings for Scrolls and Blessings assignments.

Version 3.210 4th August 2009
- Updated talent checks for 3.2 for DK.
- Made other minor changes to in-theory make it work with 3.2 based purely on the patch notes.
- One can now alt-click on Paladin Aura checks to cast an appropriate Aura for the current spec of the player.
- Fixed a bug with hybrid talent builds.
- Warlock Soul Well warning now shows the health size rather than the points spent.
- Fixed a bug in anti-spam of Soul Well announce and the translation of it.

Version 3.211 10th August 2009
- Now compares the points spent in Restorative Totems and improved Blessing of Wisdom and won't check for BoW when the totems will overwrite it.
- Added talent reports for points spent in Restorative Totems and improved Blessing of Wisdom.
- Fixed Fish/Table/Well expire announces going off when in combat but the announcer is dead.
- Fish Feast expire warning will no longer go off if you are checking Well Fed and no one is missing the buff.
- Fish Feast expire warning will now say the name of whoever is missing the Well Fed buff if there is only one of them.
- Slightly increased the delay for announcing Fish Feast to avoid spams better.

Version 3.220 16th August 2009
- Fixed red buff numbers when there are none for you to buff.
- Added Death Knight Presence check.
- Features like durability check now no longer try to work in party as oRA2 does not seem to work in a party.
- Added Healthstone item check. Requires oRA2 r665 or later. Experimental.
- Added Soul Shard item check. Requires oRA2 r665 or later. Experimental.
- Added Mammoth Cutters + Saronite Razorheads hunter item check. Requires oRA2 r665 or later. Experimental.
- Fixed a bug where RBS would call NotifyInspect when inspecting player.

Version 3.221 19th August 2009
- Added a Scan button on the dashboard to make it re-scan all buffs, items, and durability now.

Version 3.222 22nd August 2009
- Added a fix for talent scanning getting stuck.
- Added a new Death Warnings feature where it tells you when a tank, DPS or healer die.
- Attempted to fix a problem with handling items not in the item cache.
- Fixed whispering of Warlocks when people are missing Healthstones.
- The Scan button now forces a re-check of buffs always.
- Fixed a few odd error messages such as when attempting to cast a spell you are the wrong class to cast or if the raid member is dead or offline.
- Slightly increased the time between warning a Fish Feast, Refreshment Table or Soul Well is about to expire and when it will expire.
- It will now automatically whisper anyone missing Well Fed or a Healthstone when the Fish Feast and Soul Well expire warnings appear.
- It will no longer warn about a Soul Well expiring if everyone has a Healthstone.

Version 3.223 24th August 2009
- Fixed whisper on expire.

Version 3.224 27th August 2009
- Added an option to turn off the anti-spam pause between a Fish Feast, Refreshment Table or Soul Well are placed and RBS warning.
- Updated the CC break translation to make it possible to translate better.

Version 3.225 28th August 2009
- Split death warnings for DPS in to melee and ranged.

Version 3.226 7th September 2009
- Corrected spelling of "melee".
- Now auto-whisper of people missing a Soul Stone or Well Fed buff is only done if you are a leader or assistant.
- Food announce and whispers are now disabled in battlegrounds.
- Added option to enable and disable the auto-whisper.

Version 3.227 9th September 2009
- Fixed buffing when out of reagents on raid buffs.

Version 3.228 13th September 2009
- CTRA and PLPWR messages are no longer sent in battlegrounds.
- RBS will be disabled in battlegrounds by default.
- Durability will no longer be checked in battlegrounds.
- Item checks like Healthstone will no longer be checked in battlegrounds.
- Pally Power will no longer be used in battlegrounds.
- In combat the dashboard will hide its buttons making it even smaller.

Version 3.229 25th September 2009
- Right-clicking or Alt-clicking on the dead buff check will automatically resurrect the dead.
- Added Seal of Command to the acceptible Paladin Seals after its buff from 3.2.2.
- Now all Paladins are expected to Seal up - not just Holy.
- Default sort order of the talent report window is now by Role.

Version 3.230 1st October 2009
- Fixed tool tip for Paladin Seal.
- There is now a separate option for automatic whispers for Fish Feast and Soul Well.
- Fixed out of range message for some buffs and resurrections.

Version 3.231 5th October 2009
- Fixed Paladin Seal check for Seal of Corruption.
- Changed to using LibTalentQuery-1.0 and LibGroupTalents-1.0 for improved and more reliable talent queries. Mostly work done by Taral. A big thanks to him.

Version 3.232 7th October 2009
- Many bugs!  Handle it!
- Fixed incorrect Soul Well size and generally not working since talent code changes.
- Fixed a bunch of errors scanning talents.

Version 3.233 7th October 2009
- Fixed Death Knight tanks not being detected as tank since 2.331.

Version 3.234 14th October 2009
- Added Repair Bot announce.
- Added Flask of the North to slacking flasks.

Version 3.235 16th October 2009
- Fixed toc file for LibTalentQuery-1.0 and LibGroupTalents-1.0 loading when using no-lib.
- Fixed anti-spam of Repair Bot announce.

Version 3.236 16th October 2009
- Added support for Drums of the Wild.
- Added support for Runescroll of Fortitude.
- Added partial support for Drums of Forgotten Kings.

Version 3.237 18th October 2009
- Fixed some errors with the Drums and Runescroll code.

Version 3.238 21st October 2009
- Fixed some errors when joining a battleground.
- Fixed some "You are not in a party." messages when in a battleground.
- Fixed Priests with Spirit of Redemption so they only get announced once when they die.  It is announced when they turn in to the spirit so it give you a little bit of notice.
- Added more support for Drums of Forgotten Kings.
- Fixed melee and ranged dps death warnings - they never worked ever!

Version 3.239 21st October 2009
- Really fixed Priests deaths this time.

Version 3.240 15th November 2009
- Pug detection is now less strict so is more likely to think a raid is a pug.
- Completed support for Drums of Forgotten Kings.  It will now know according to the spec and raid or party make up and number of Paladins if to be used or not.
- Re-wrote Paladin blessings to be able to handle short blessing assignments in Pally Power as well as give more information and in a clearer way about problems with Paladin assignments and many other improvements.
- Paladin blessings now tells you when it would be better to use Forgotten Kings.
- Paladin blessings now tells you when Sanctuary is allocated but no one has the spec to do it.
- Paladin blessings now tells you when Wisdom will be overwritten by Shaman totems because more points have been spent in Restorative Totems than Improved Blessing of Wisdom.
- Removed Scroll of Stamina as Runescroll of Fortitude is much more useful and less likely to be overwritten.
- Fixed a bug with hiding the main frame from the command line.
- Fixed a bug with pressing Refresh on the talents report window when not in a party or raid.
- Talents report window now has the classes translated correctly.
- RBS is now better at picking up single class changes in Pally Power without needing the Refresh button clicking in Pally Power.
- Added Scrapbot support for repair bot warnings.

Version 3.241 16th November 2009
- Updated to use LOCALIZED_CLASS_NAMES_MALE instead of custom translations.

Version 3.242 17th November 2009
- Fixed a class localisation missed in 3.241.
- Optimised combat log parsing when not in a party.
- Slightly improved Pally Power message processing.

Version 3.243 19th November 2009
- Fixed error when setting Pally Power.
- Stopped in-combat Pally Power messages.
- Fixed a bug with counting number of points spent in improved Blessing of Wisdom and Restorative totems.
- Fixed a bug with it complaining about incorrectly set Pally Power when there are 4 or more Paladins and no Blessing of Sanctuary available.

Version 3.244 8th December 2009
- Fixed weapon buff checking which has been broken since 3.323.
- Fixed some errors when joining a raid when in combat.
- Updated toc for 3.3.  I don't see any changes which would need any change to RBS in the patch notes so fingers crossed...


Version 3.245 26th December 2009
- Added an option to hide the Boss R Trash buttons.
- Added a Misdirection warning feature where it will tell you if Misdirection or Tricks of the Trade are cast.
- Added Vampiric Embrace buff check and talent report.
- Added Shatter Rounds + Iceblade Arrow support.
- RBS now attempts to call NotifyInspect() less on weapon buff checking.
- Improved Pally Power message parsing, fixed a bug with short blessing assignments and also hopefully made RBS spam "PLPWR REQ" a lot less.

Version 3.246 27th December 2009
- Repair bot expiring warnings now no longer appear when the person who put down the bot died thus causing it to disappear.  It uses the combat log so if you zone and don't notice the death then it won't.
- Added a feature where RBS will warn leaders and assistants when someone who had Pally Power blessings assigned to them leaves the raid.  It tries to spot when people leave due to raid end time and not spam.
- Added a feature where RBS will warn leaders and assistants when someone tries to assign blessings to a raid member no longer in the raid.
- Added the ability to report to Officer chat by holding down Shift when clicking the Boss or Trash buttons.
- PLPWR messages are now ignored and not sent in a Battleground.

Version 3.247 28th December 2009
- Added a feature where RBS will tell you if someone in your party, raid or guild has a newer version of RBS than you.

Version 3.248 3rd January 2010
- Added a Buff Wizard.  What this does is help the new user configure the dashboard buffs for what they want to do.

Version 3.249 7th January 2010
- Fixed some individual buffs accidentally reporting to officer channel.
- Fixed Shadow Protection not appearing when clicking Raid Leader in the Buff Wizzard.
- Split the warnings for when one's own taunts fail in to two seperate set of options; one for resists and one for immune.  They even have their own sounds.
- Taunt fails now include information to say if it was a Resist or due to Immune.
- The warning when someone who had Pally Power blessings assigned to them leaves the raid now only goes to the leader and Paladin raid assistants with Pally Power.  So those using RBS as a buff bot don't need to see it.  Now also plays a sound.
- The warning when someone tries to assign blessings to a raid member no longer in the raid now only warns the person doing it and only if they are a leader or Paladin raid assistant with Pally Power.  In addition it has anti-spam but now also plays a sound.
- The option to ignore the last three groups is now off by default.  This was causing issues with Paladins being in group 6-8 and RBS complaining.

Daniel Barron daniel@jadeb.com
