A much enchanced version of Nymbia's Perl UnitFrames, and a complete replacement for Blizzard's default unit frames, including raid frames and raid tools, with many additions and improvements over the original Nymbia code.

Range Finder (combined with optional health check and/or debuff check) for all frames based on spell or item range test.

HoT Monitor will highlight units clearly that have your own active Heal over Time spells. Regardless of how many other heal over time buffs are on the raid members, you can keep track of your own ones and when they expire.

Debuff Highlights in standard debuff colours on all friendly frames. Priority given to show debuffs that YOU can cure first.

Raid Frames, buff icons, MT list units and some other portions or X-Perl are Created on demand. Saving a lot of time and memory at system startup. Defering the creation of many parts of X-Perl to when they are actually required. And of course, most often outside of raids they are never required and are never created.

Raid Target icon support for Target, Target's Target, MT Targets.

Raid tooltip will show combat rezzers available (druids with Rebirth ready (or very soon available) and any normal rezzers out of combat) if you bring up tooltip of a dead person.

'In-combat' indicators for Pet, Target, Target's Target, Party, Party pets, Raid, MT Targets.

3D Portraits for player, pet, target, focus, party. Optional. Of course this may degrade your framerate somewhat because you are displaying more 3D character models that without this option. But some like it pretty, and it does look cool.

Red and Green combat flashes for frames when player, pet, target, party, partypets, raid take damage/heals. Useful indication of things happening.

Added time left on party member/target buffs/debuffs when in a raid, these depend somewhat on CTRA/oRA/oRA2 sending appropriate information over the addon channel, although some of it can be determined at run time by X-Perl, when a player gets a buff for example, we know how long it should last, and therefor when it should expire.

Totally new options window including all X-Perl options and access via minimap icon.

Configurable colours for borders and backgrounds. Including class coloured names, and configurable reaction colours.

Much care has been taken with code size, memory load, memory usage per cycle and so on. LuaProfiler/OnEvent mods used extensively and regularly to ensure that X-Perl does not do more work than is absolutely necessary.

With that in mind, the event system was totally re-written, and is as kind to system performance as possible. The majority of events are disabled while zoning to alleviate any event backlog issues. And where most addons use 1 event handler per unit frame, which although standard, the alternative has improved X-Perl's performance. By using single main event handlers, we can route the events to appropriate units. So, for example, when a single UNIT_HEALTH update is fired, then just a single raid frame or party frame etc. gets the event, rather than 40 raid frame's handlers, 4 party and so on. Nymbia's Perl used to do a lot of crazy full frame udpates all over the place, eating away at CPU cycles. This was all fixed to only update what was necessary based on events.

XPerl_RaidHelper sub-addon
-------------------------
Assists View
Will show anyone from raid assising you with your target, and can also show healers or all plus known enemies targetting you.
Tooltips for the same also available (on player and target frames) if you prefer to not use the main window.

MT Targets
Replaces CTRA/oRA2 MT Targets window, and doubles as a replacement for the Perl RaidFrames warrior targets.
Indicator shows which target you are on.
Frames will be coloured to show if tanks have duplicate targets.

XPerl_RaidMonitor sub-addon (WORK IN PROGRESS)
----------------------------------------------
Casting Monitor
Shows selected classes (defaults to healer classes) in a list (much like the MT List), but with some differences.
Shows mana bars and cast bars on left. Their targets on right. Health bar as normal, but a secondary small red bar on targets which shows the maximum single hit this unit has received since entering combat. The secondary bar will extend downwards from their current HP level down to as far as zero.
A green name on the targets indicates this is the same target that you have.
You can click on casters or their targets as expected.
For druids, right clicking on a caster will cast Innervate on them.
For shamans, right clicking on a caster will cast Mana Tide Totem. Check the * indicator to see if they're in your group.

All bars can be re-sized in X-Perl main options (Monitor section).

Totals can be toggled (from the 'T' minibutton at top of frame) which gives overview of raid mana status.

XPerl_RaidAdmin sub-addon (WORK IN PROGRESS)
-------------------------------------------
Raid Admin
Save/Load raid roster setups
Only does direct save and load for the moment, but more to come (templates and such).

Item Check
Replacement for /raitem /radur /raresist /rareg. Use the old commands before, or drop items in the left item list.
Query button will perform /raitem on all ticked items (query always includes dur and resists) and you can then view and review all the results whenever, without having to re-query each item.
Includes everyone in raid, so you don't have to work out who doesn't have items, it'll list them with 0 instead of no entry.
Active Scanner to check raid member's equipment for the item selected. So you can be sure that people actually have the item worn (Onyxia Cloak for example), without having to go round single target inspecting everyone who 'forgot' to install CTRA for the 50th raid in a row.

Roster Text
Allows you to Copy'n'Paste the player names from the raid roster for selected groups, for pasting into web forms like EQDKP.
Access via minimap icon menu.

XPerl_GrimReaper sub-addon
--------------------------
The Grim Reaper remembers the most recent combat events for each unit in the party or raid, so that you may mouse over someone and immediately see the kind of damage/healing they took prior to death.

/grim for options

Right click Reaper for menu (when un-docked)
Alt-Mousewheel to scale the reaper window (when un-docked)

Supported Addons
----------------
CT_RaidAssist, oRA2. Shows tooltip info and player status, replaces MT Targets List, improves raid frames, shows player status, resurrection monitor, buff timers aware.
MobInfo-2 / MobHealth3 - Shows target health from MobHealth database.
DruidBar - Shows druid mana bar from SimpleDruidBar, DruidBar or SmartyCat when shapeshifted.
Clique compatible. And any other click cast addon that uses the same communication method. (see below)

Notes for other mod authors
---------------------------
The ClickCastFrames table (as used by Clique) is maintained by all X-Perl's unit frames.

Defined as:

	if (not ClickCastFrames) then
		ClickCastFrames = {}
	end
        ClickCastFrames[SomeSecureUnitFrame] = true

With this you can change the attributes for various click methods.

Frame names:
        XPerl_Player
        XPerl_Player_Pet
        XPerl_Target
        XPerl_TargetTarget
        XPerl_TargetTargetTarget
        XPerl_Focus
        XPerl_FocusTarget
        XPerl_party1 (&2, 3, 4)
        XPerl_partypet1 (&2, 3, 4)

        Raid frames are defined by groups
        XPerl_Raid_Grp[1-9]
        You can query each raid group by doing
                XPerl_Raid_Grp1:GetAttribute("child1") for example

Alternatively, ignore the frame names and dynamically use them from the ClickCastFrames table.

TODO
----
Big Party option for 10 man raids to show 9 party member frames rather than needing raid frames.
Player Buffs.
Class Coloured Health Bars.
Improved options with more independance with some global options that could be set per frame.
Setup Wizard.
Player Targets view to go with MT Targets.

Known Issues
------------
Large non-standard fonts can exclude all text in frames. Please let me know which ones, where, when, what addon, settings etc.
Targets Target fading bars occasional jump a little.
Occasionally clicking a player in the Item Checker can select wrong person. Think it's when an active equipment scan is in progress and the list is in constant movement internally.

While every care is taken to ensure there are few or no bugs, it is always possible that some slip through. And often other mods can interfere with normal behaviour. Popup error messages are annoying, so it is highly recommended that you install an improved error catcher. BugSack(Ace2) is particularly good, or ImprovedErrorFrame would also suffice. These divert the popups away to a little minimap button that you can ignore mostly.

--
X-Perl UnitFrames by Zek <Blood Cult> - Bloodhoof-EU
