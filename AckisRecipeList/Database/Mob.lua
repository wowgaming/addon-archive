--[[
************************************************************************
Mob.lua
Mob data for all of Ackis Recipe List
************************************************************************
File date: 2009-12-30T10:16:20Z 
File revision: 2785 
Project revision: 2817
Project version: v1.0-r2818
************************************************************************
Format:
	self:addLookupList(MobDB,NPC ID, NPC Name, NPC Location, X Coord, Y Coord, Faction)
	the "Faction" parameter isn't used in this specific database
************************************************************************
Please see http://www.wowace.com/addons/arl/ for more information.
************************************************************************
This source code is released under All Rights Reserved.
************************************************************************
]]--

local MODNAME		= "Ackis Recipe List"
local addon		= LibStub("AceAddon-3.0"):GetAddon(MODNAME)
local L			= LibStub("AceLocale-3.0"):GetLocale(MODNAME)
local BZ		= LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BB		= LibStub("LibBabble-Boss-3.0"):GetLookupTable()

function addon:InitMob(MobDB)

-- Zones
	-- Alterac Mountains
	self:addLookupList(MobDB,2242,L["Syndicate Spy"],BZ["Alterac Mountains"],63.0,40.6)
	self:addLookupList(MobDB,2246,L["Syndicate Assassin"],BZ["Alterac Mountains"],40.6,16.8)
	-- Arathi Highlands
	self:addLookupList(MobDB,2556,L["Witherbark Headhunter"],BZ["Arathi Highlands"],70.5,70.4)
	self:addLookupList(MobDB,2557,L["Witherbark Shadow Hunter"],BZ["Arathi Highlands"],70.3,78.9)
	self:addLookupList(MobDB,2558,L["Witherbark Berserker"],BZ["Arathi Highlands"],24.2,66.2)
	self:addLookupList(MobDB,2606,L["Nimar the Slayer"],BZ["Arathi Highlands"],66.6,64.0)
	self:addLookupList(MobDB,2636,L["Blackwater Deckhand"],BZ["Arathi Highlands"],33.0,81.3)
	-- Ashenvale
	self:addLookupList(MobDB,3834,L["Crazed Ancient"],BZ["Ashenvale"],59.4,43.0)
	self:addLookupList(MobDB,3919,L["Withered Ancient"],BZ["Ashenvale"],58.5,36.1)
	-- Azshara
	self:addLookupList(MobDB,6138,L["Arkkoran Oracle"],BZ["Azshara"],78.0,41.8)
	self:addLookupList(MobDB,6144,L["Son of Arkkoroc"],BZ["Azshara"],65.5,54.4)
	self:addLookupList(MobDB,6146,L["Cliff Breaker"],BZ["Azshara"],66.0,13.2)
	self:addLookupList(MobDB,6201,L["Legashi Rogue"],BZ["Azshara"],50.1,19.6)
	-- Blade's Edge Mountains
	self:addLookupList(MobDB,16952,L["Anger Guard"],BZ["Blade's Edge Mountains"],72.0,40.5)
	self:addLookupList(MobDB,19952,L["Bloodmaul Geomancer"],BZ["Blade's Edge Mountains"],45.0,68.5)
	self:addLookupList(MobDB,19960,L["Doomforge Engineer"],BZ["Blade's Edge Mountains"],75.1,39.8)
	self:addLookupList(MobDB,19973,L["Abyssal Flamebringer"],BZ["Blade's Edge Mountains"],30.0,81.0)
	self:addLookupList(MobDB,19984,L["Vekh'nir Dreadhawk"],BZ["Blade's Edge Mountains"],78.0,74.3)
	self:addLookupList(MobDB,22242,L["Bash'ir Spell-Thief"],BZ["Blade's Edge Mountains"],51.0,16.5)
	self:addLookupList(MobDB,23385,L["Simon Unit"],BZ["Blade's Edge Mountains"],33.5,51.5)
	self:addLookupList(MobDB,23386,L["Gan'arg Analyzer"],BZ["Blade's Edge Mountains"],33.0,52.5)
	-- Blasted Lands
	self:addLookupList(MobDB,5981,L["Portal Seeker"],BZ["Blasted Lands"],51.1,34.0)
	self:addLookupList(MobDB,6005,L["Shadowsworn Thug"],BZ["Blasted Lands"],63.8,32.0)
	-- Burning Steppes
	self:addLookupList(MobDB,7025,L["Blackrock Soldier"],BZ["Burning Steppes"],44.0,52.8)
	self:addLookupList(MobDB,7027,L["Blackrock Slayer"],BZ["Burning Steppes"],44.4,50.7)
	self:addLookupList(MobDB,7029,L["Blackrock Battlemaster"],BZ["Burning Steppes"],40.5,35.8)
	self:addLookupList(MobDB,7035,L["Firegut Brute"],BZ["Burning Steppes"],82.5,48.1)
	self:addLookupList(MobDB,7037,L["Thaurissan Firewalker"],BZ["Burning Steppes"],61.1,42.0)
	self:addLookupList(MobDB,10119,L["Volchan"],BZ["Burning Steppes"],73.0,49.3)
	-- Darkshore
	self:addLookupList(MobDB,2337,L["Dark Strand Voidcaller"],BZ["Darkshore"],56.2,26.0)
	-- Deadwind Pass
	self:addLookupList(MobDB,7372,L["Deadwind Warlock"],BZ["Deadwind Pass"],59.8,74.4)
	-- Dragonblight
	self:addLookupList(MobDB,26343,L["Indu'le Fisherman"],BZ["Dragonblight"],40.2,65.5)
	self:addLookupList(MobDB,27333,L["Onslaught Mason"],BZ["Dragonblight"],85.8,36.0)
	-- Duskwood
	self:addLookupList(MobDB,910,L["Defias Enchanter"],BZ["Duskwood"],49.5,75.6)
	-- Dustwallow Marsh
	self:addLookupList(MobDB,4364,L["Strashaz Warrior"],BZ["Dustwallow Marsh"],76.5,22.3)
	self:addLookupList(MobDB,4366,L["Strashaz Serpent Guard"],BZ["Dustwallow Marsh"],74.1,18.2)
	self:addLookupList(MobDB,4368,L["Strashaz Myrmidon"],BZ["Dustwallow Marsh"],75.1,14.2)
	self:addLookupList(MobDB,4834,L["Theramore Infiltrator"],BZ["Dustwallow Marsh"],44.0,27.3)
	self:addLookupList(MobDB,16072,L["Tidelord Rrurgaz"],BZ["Dustwallow Marsh"],76.7,19.5)
	-- Eastern Plaguelands
	self:addLookupList(MobDB,8546,L["Dark Adept"],BZ["Eastern Plaguelands"],65.8,37.9)
	self:addLookupList(MobDB,8550,L["Shadowmage"],BZ["Eastern Plaguelands"],78.5,35.3)
	self:addLookupList(MobDB,8561,L["Mossflayer Shadowhunter"],BZ["Eastern Plaguelands"],60.9,21.5)
	self:addLookupList(MobDB,9451,L["Scarlet Archmage"],BZ["Eastern Plaguelands"],81.5,75.4)
	-- Grizzly Hills
	self:addLookupList(MobDB,26270,L["Iron Rune-Shaper"],BZ["Grizzly Hills"],67.8,16.3)
	self:addLookupList(MobDB,26679,L["Silverbrook Trapper"],BZ["Grizzly Hills"],27.3,33.9)
	self:addLookupList(MobDB,26708,L["Silverbrook Villager"],BZ["Grizzly Hills"],27.3,33.9)
	self:addLookupList(MobDB,27546,L["Silverbrook Hunter"],BZ["Grizzly Hills"],37.5,68.0)
	self:addLookupList(MobDB,27676,L["Silverbrook Defender"],BZ["Grizzly Hills"],24.6,33.3)
	-- Hillsbrad Foothills
	self:addLookupList(MobDB,2434,L["Shadowy Assassin"],BZ["Hillsbrad Foothills"],52.7,52.8)
	-- Icecrown
	self:addLookupList(MobDB,30921,L["Skeletal Runesmith"],BZ["Icecrown"],60.0,73.1)
	self:addLookupList(MobDB,31702,L["Frostbrood Spawn"],BZ["Icecrown"],75.3,43.4)
	self:addLookupList(MobDB,32289,L["Damned Apothecary"],BZ["Icecrown"],49.8,32.7)
	self:addLookupList(MobDB,32290,L["Cult Alchemist"],BZ["Icecrown"],49.5,33.1)
	self:addLookupList(MobDB,32297,L["Cult Researcher"],BZ["Icecrown"],50.7,30.9)
	self:addLookupList(MobDB,32349,L["Cultist Shard Watcher"],BZ["Icecrown"],48.1,67.9)
	-- Felwood
	self:addLookupList(MobDB,7106,L["Jadefire Rogue"],BZ["Felwood"],37.5,66.5)
	self:addLookupList(MobDB,7158,L["Deadwood Shaman"],BZ["Felwood"],62.5,10.3)
	self:addLookupList(MobDB,7441,L["Winterfall Totemic"],BZ["Felwood"],41.5,42.7)
	-- Hillsbrad Foothills
	self:addLookupList(MobDB,2264,L["Hillsbrad Tailor"],BZ["Hillsbrad Foothills"],36.6,44.4)
	self:addLookupList(MobDB,2374,L["Torn Fin Muckdweller"],BZ["Hillsbrad Foothills"],31.5,72.1)
	self:addLookupList(MobDB,2375,L["Torn Fin Coastrunner"],BZ["Hillsbrad Foothills"],25.1,70.5)
	self:addLookupList(MobDB,2376,L["Torn Fin Oracle"],BZ["Hillsbrad Foothills"],42.0,68.0)
	self:addLookupList(MobDB,2377,L["Torn Fin Tidehunter"],BZ["Hillsbrad Foothills"],39.0,69.0)
	self:addLookupList(MobDB,14276,L["Scargil"],BZ["Hillsbrad Foothills"],26.6,71.2)
	-- Nagrand
	self:addLookupList(MobDB,17136,L["Boulderfist Warrior"],BZ["Nagrand"],51.0,57.0)
	self:addLookupList(MobDB,17150,L["Vir'aani Arcanist"],BZ["Nagrand"],40.5,69.6)
	self:addLookupList(MobDB,18203,L["Murkblood Raider"],BZ["Nagrand"],31.5,43.5)
	-- Netherstorm
	self:addLookupList(MobDB,18853,L["Sunfury Bloodwarder"],BZ["Netherstorm"],27.0,72.0)
	self:addLookupList(MobDB,18866,L["Mageslayer"],BZ["Netherstorm"],55.5,85.5)
	self:addLookupList(MobDB,18870,L["Voidshrieker"],BZ["Netherstorm"],60.0,39.0)
	self:addLookupList(MobDB,18872,L["Disembodied Vindicator"],BZ["Netherstorm"],36.0,55.5)
	self:addLookupList(MobDB,18873,L["Disembodied Protector"],BZ["Netherstorm"],31.8,52.7)
	self:addLookupList(MobDB,19707,L["Sunfury Archer"],BZ["Netherstorm"],55.5,81.0)
	self:addLookupList(MobDB,22822,L["Ethereum Nullifier"],BZ["Netherstorm"],66.0,49.5)
	self:addLookupList(MobDB,20134,L["Sunfury Arcanist"],BZ["Netherstorm"],51.0,82.5)
	self:addLookupList(MobDB,20135,L["Sunfury Arch Mage"],BZ["Netherstorm"],46.5,81.0)
	self:addLookupList(MobDB,20136,L["Sunfury Researcher"],BZ["Netherstorm"],48.2,82.5)
	self:addLookupList(MobDB,20207,L["Sunfury Bowman"],BZ["Netherstorm"],61.5,67.5)
	self:addLookupList(MobDB,23008,L["Ethereum Jailor"],BZ["Netherstorm"],58.8,35.6)
	-- Searing Gorge
	self:addLookupList(MobDB,5844,L["Dark Iron Slaver"],BZ["Searing Gorge"],43.8,33.8)
	self:addLookupList(MobDB,5846,L["Dark Iron Taskmaster"],BZ["Searing Gorge"],44.4,41.1)
	self:addLookupList(MobDB,5861,L["Twilight Fire Guard"],BZ["Searing Gorge"],25.5,33.8)
	self:addLookupList(MobDB,8637,L["Dark Iron Watchman"],BZ["Searing Gorge"],69.3,34.8)
	self:addLookupList(MobDB,9026,BB["Overmaster Pyron"],BZ["Searing Gorge"],26.2,74.9)
	-- Shadowmoon Valley
	self:addLookupList(MobDB,19740,L["Wrathwalker"],BZ["Shadowmoon Valley"],25.5,33.0)
	self:addLookupList(MobDB,19754,L["Deathforge Tinkerer"],BZ["Shadowmoon Valley"],39.0,38.7)
	self:addLookupList(MobDB,19755,L["Mo'arg Weaponsmith"],BZ["Shadowmoon Valley"],25.5,31.5)
	self:addLookupList(MobDB,19756,L["Deathforge Smith"],BZ["Shadowmoon Valley"],37.5,42.0)
	self:addLookupList(MobDB,19768,L["Coilskar Siren"],BZ["Shadowmoon Valley"],46.5,30.0)
	self:addLookupList(MobDB,19792,L["Eclipsion Centurion"],BZ["Shadowmoon Valley"],48.0,61.8)
	self:addLookupList(MobDB,19795,L["Eclipsion Blood Knight"],BZ["Shadowmoon Valley"],52.7,63.2)
	self:addLookupList(MobDB,19796,L["Eclipsion Archmage"],BZ["Shadowmoon Valley"],49.5,58.5)
	self:addLookupList(MobDB,19806,L["Eclipsion Bloodwarder"],BZ["Shadowmoon Valley"],46.5,66.0)
	self:addLookupList(MobDB,19826,L["Dark Conclave Shadowmancer"],BZ["Shadowmoon Valley"],37.5,29.0)
	self:addLookupList(MobDB,20878,L["Deathforge Guardian"],BZ["Shadowmoon Valley"],39.0,47.0)
	self:addLookupList(MobDB,20887,L["Deathforge Imp"],BZ["Shadowmoon Valley"],40.5,39.1)
	self:addLookupList(MobDB,21050,L["Enraged Earth Spirit"],BZ["Shadowmoon Valley"],46.5,45.0)
	self:addLookupList(MobDB,21059,L["Enraged Water Spirit"],BZ["Shadowmoon Valley"],51.0,25.5)
	self:addLookupList(MobDB,21060,L["Enraged Air Spirit"],BZ["Shadowmoon Valley"],70.5,28.5)
	self:addLookupList(MobDB,21061,L["Enraged Fire Spirit"],BZ["Shadowmoon Valley"],48.0,43.5)
	self:addLookupList(MobDB,21302,L["Shadow Council Warlock"],BZ["Shadowmoon Valley"],22.9,38.2)
	self:addLookupList(MobDB,21314,L["Terrormaster"],BZ["Shadowmoon Valley"],24.0,45.0)
	self:addLookupList(MobDB,21454,L["Ashtongue Warrior"],BZ["Shadowmoon Valley"],57.0,36.0)
	self:addLookupList(MobDB,22016,L["Eclipsion Soldier"],BZ["Shadowmoon Valley"],52.8,66.5)
	self:addLookupList(MobDB,22017,L["Eclipsion Spellbinder"],BZ["Shadowmoon Valley"],52.7,63.4)
	self:addLookupList(MobDB,22018,L["Eclipsion Cavalier"],BZ["Shadowmoon Valley"],52.7,61.1)
	self:addLookupList(MobDB,22076,L["Torloth the Magnificent"],BZ["Shadowmoon Valley"],51.2,72.5)
	self:addLookupList(MobDB,22093,L["Illidari Watcher"],BZ["Shadowmoon Valley"],52.5,72.0)
	self:addLookupList(MobDB,23305,L["Crazed Murkblood Foreman"],BZ["Shadowmoon Valley"],72.3,90.0)
	self:addLookupList(MobDB,23324,L["Crazed Murkblood Miner"],BZ["Shadowmoon Valley"],73.5,88.5)
	-- Sholazar Basin
	self:addLookupList(MobDB,28123,L["Venture Co. Excavator"],BZ["Sholazar Basin"],35.8,45.5)      
	self:addLookupList(MobDB,28379,L["Shattertusk Mammoth"],BZ["Sholazar Basin"],53.5,24.4)
	-- Silithus
	self:addLookupList(MobDB,14454,BB["The Windreaver"],BZ["Silithus"],27.0,26.8)
	-- Silverpine Forest
	self:addLookupList(MobDB,3530,L["Pyrewood Tailor"],BZ["Silverpine Forest"],45.7,71.0)
	self:addLookupList(MobDB,3531,L["Moonrage Tailor"],BZ["Silverpine Forest"],45.5,73.3)
	-- Stonetalon Mountains
	self:addLookupList(MobDB,4028,L["Charred Ancient"],BZ["Stonetalon Mountains"],34.0,66.1)
	self:addLookupList(MobDB,4029,L["Blackened Ancient"],BZ["Stonetalon Mountains"],33.0,70.7)
	self:addLookupList(MobDB,4030,L["Vengeful Ancient"],BZ["Stonetalon Mountains"],33.0,72.4)
	-- Stranglethorn Vale
	self:addLookupList(MobDB,674,L["Venture Co. Strip Miner"],BZ["Stranglethorn Vale"],40.5,43.7)
	self:addLookupList(MobDB,938,L["Kurzen Commando"],BZ["Stranglethorn Vale"],47.2,7.6)
	self:addLookupList(MobDB,1561,L["Bloodsail Raider"],BZ["Stranglethorn Vale"],27.0,69.9)
	-- Swamp of Sorrows
	self:addLookupList(MobDB,764,L["Swampwalker"],BZ["Swamp of Sorrows"],51.0,36.7)
	self:addLookupList(MobDB,765,L["Swampwalker Elder"],BZ["Swamp of Sorrows"],12.0,33.2)
	self:addLookupList(MobDB,766,L["Tangled Horror"],BZ["Swamp of Sorrows"],12.0,31.8)
	self:addLookupList(MobDB,1081,L["Mire Lord"],BZ["Swamp of Sorrows"],5.6,31.4)
	self:addLookupList(MobDB,14448,L["Molt Thorn"],BZ["Swamp of Sorrows"],30.4,41.4)
	-- Tanaris
  	self:addLookupList(MobDB,5615,L["Wastewander Rogue"],BZ["Tanaris"],60.4,39.3)
	self:addLookupList(MobDB,5616,L["Wastewander Thief"],BZ["Tanaris"],63.0,29.9)
	self:addLookupList(MobDB,5617,L["Wastewander Shadow Mage"],BZ["Tanaris"],60.0,37.4)
	self:addLookupList(MobDB,5618,L["Wastewander Bandit"],BZ["Tanaris"],63.6,30.6)
	self:addLookupList(MobDB,5623,L["Wastewander Assassin"],BZ["Tanaris"],58.6,36.1)
	self:addLookupList(MobDB,7805,L["Wastewander Scofflaw"],BZ["Tanaris"],66.1,35.0)
	self:addLookupList(MobDB,7883,L["Andre Firebeard"],BZ["Tanaris"],73.4,47.1)
	-- Terokkar Forest
	self:addLookupList(MobDB,16810,L["Bonechewer Backbreaker"],BZ["Terokkar Forest"],66.0,55.2)
	self:addLookupList(MobDB,22148,L["Gordunni Head-Splitter"],BZ["Terokkar Forest"],22.5,8.3)
	self:addLookupList(MobDB,23022,L["Gordunni Soulreaper"],BZ["Terokkar Forest"],22.9,8.8)
	self:addLookupList(MobDB,22143,L["Gordunni Back-Breaker"],BZ["Terokkar Forest"],21.2,8.1)
	self:addLookupList(MobDB,22144,L["Gordunni Elementalist"],BZ["Terokkar Forest"],21.3,12.0)
	-- The Barrens
	self:addLookupList(MobDB,3385,L["Theramore Marine"],BZ["The Barrens"],61.2,52.2)
	self:addLookupList(MobDB,3386,L["Theramore Preserver"],BZ["The Barrens"],63.1,56.7)
	-- The Hinterlands
	self:addLookupList(MobDB,2644,L["Vilebranch Hideskinner"],BZ["The Hinterlands"],62.2,69.2)
	-- The Storm Peaks
	self:addLookupList(MobDB,29370,L["Stormforged Champion"],BZ["The Storm Peaks"],26.1,47.5)
	self:addLookupList(MobDB,29376,L["Stormforged Artificer"],BZ["The Storm Peaks"],31.5,44.2)
	self:addLookupList(MobDB,29402,L["Ironwool Mammoth"],BZ["The Storm Peaks"],36.0,83.5)
	self:addLookupList(MobDB,29570,L["Nascent Val'kyr"],BZ["The Storm Peaks"],27.1,60.0)
	self:addLookupList(MobDB,29792,L["Frostfeather Screecher"],BZ["The Storm Peaks"],33.5,65.5)
	self:addLookupList(MobDB,29793,L["Frostfeather Witch"],BZ["The Storm Peaks"],33.0,66.8)
	self:addLookupList(MobDB,30208,L["Stormforged Ambusher"],BZ["The Storm Peaks"],70.3,57.5)
	self:addLookupList(MobDB,30222,L["Stormforged Infiltrator"],BZ["The Storm Peaks"],58.5,63.2)
	self:addLookupList(MobDB,30260,L["Stoic Mammoth"],BZ["The Storm Peaks"],54.8,64.9)
	self:addLookupList(MobDB,30448,L["Plains Mammoth"],BZ["The Storm Peaks"],66.1,45.6)
	-- Thousand Needles
	self:addLookupList(MobDB,10760,L["Grimtotem Geomancer"],BZ["Thousand Needles"],33.1,35.4)
	-- Un'Goro Crater
	self:addLookupList(MobDB,6556,L["Muculent Ooze"],BZ["Un'Goro Crater"],62.2,25.4)
	self:addLookupList(MobDB,6557,L["Primal Ooze"],BZ["Un'Goro Crater"],51.8,34.9)
	self:addLookupList(MobDB,6559,L["Glutinous Ooze"],BZ["Un'Goro Crater"],39.0,37.7)
	self:addLookupList(MobDB,9477,L["Cloned Ooze"],BZ["Un'Goro Crater"],45.5,22.7)
	-- Western Plaguelands
	self:addLookupList(MobDB,1783,L["Skeletal Flayer"],BZ["Western Plaguelands"],50.7,80.5)
	self:addLookupList(MobDB,1791,L["Slavering Ghoul"],BZ["Western Plaguelands"],36.0,56.5)
	self:addLookupList(MobDB,1812,L["Rotting Behemoth"],BZ["Western Plaguelands"],64.5,36.6)
	self:addLookupList(MobDB,1813,L["Decaying Horror"],BZ["Western Plaguelands"],62.0,37.6)
	self:addLookupList(MobDB,1836,L["Scarlet Cavalier"],BZ["Western Plaguelands"],42.5,16.0)
	self:addLookupList(MobDB,1844,L["Foreman Marcrid"],BZ["Western Plaguelands"],47.7,35.4)
	self:addLookupList(MobDB,1885,L["Scarlet Smith"],BZ["Western Plaguelands"],45.4,14.5)
	self:addLookupList(MobDB,4494,L["Scarlet Spellbinder"],BZ["Western Plaguelands"],52.7,38.4)
	-- Westfall
	self:addLookupList(MobDB,450,L["Defias Renegade Mage"],BZ["Westfall"],53.0,78.8)
	self:addLookupList(MobDB,590,L["Defias Looter"],BZ["Westfall"],37.5,58.4)
	-- Wetlands
	self:addLookupList(MobDB,1051,L["Dark Iron Dwarf"],BZ["Wetlands"],60.1,25.7)
	self:addLookupList(MobDB,1052,L["Dark Iron Saboteur"],BZ["Wetlands"],58.5,24.2)
	self:addLookupList(MobDB,1053,L["Dark Iron Tunneler"],BZ["Wetlands"],61.4,27.7)
	self:addLookupList(MobDB,1054,L["Dark Iron Demolitionist"],BZ["Wetlands"],59.5,29.7)
	self:addLookupList(MobDB,1160,L["Captain Halyndor"],BZ["Wetlands"],15.0,24.0)
	self:addLookupList(MobDB,1364,L["Balgaras the Foul"],BZ["Wetlands"],60.0,28.7)
	-- Winterspring
	self:addLookupList(MobDB,7428,L["Frostmaul Giant"],BZ["Winterspring"],58.5,70.0)
	self:addLookupList(MobDB,7437,L["Cobalt Mageweaver"],BZ["Winterspring"],59.5,49.2)
	self:addLookupList(MobDB,7438,L["Winterfall Ursa"],BZ["Winterspring"],67.5,36.3)
	self:addLookupList(MobDB,7440,L["Winterfall Den Watcher"],BZ["Winterspring"],68.0,35.5)
	self:addLookupList(MobDB,7524,L["Anguished Highborne"],BZ["Winterspring"],50.7,41.9)
	self:addLookupList(MobDB,14457,BB["Princess Tempestria"],BZ["Winterspring"],52.7,41.9)
	-- Zul'drak
	self:addLookupList(MobDB,28851,L["Enraged Mammoth"],BZ["Zul'Drak"],72.0,41.1)
	self:addLookupList(MobDB,29235,L["Gundrak Savage"],BZ["Zul'Drak"],66.8,42.4)
-- Instances
	-- Ahn'kahet: The Old Kingdom
	self:addLookupList(MobDB,29311,BB["Herald Volazj"],BZ["Ahn'kahet: The Old Kingdom"],0,0)
	-- Auchenai Crypts
	self:addLookupList(MobDB,18497,L["Auchenai Monk"],BZ["Auchenai Crypts"],0,0)
	self:addLookupList(MobDB,18521,L["Raging Skeleton"],BZ["Auchenai Crypts"],0,0)
	-- Azjol-Nerub
	self:addLookupList(MobDB,29120,BB["Anub'arak"],BZ["Azjol-Nerub"],0,0)
	-- Blackrock Depths
	self:addLookupList(MobDB,8897,L["Doomforge Craftsman"],BZ["Blackrock Depths"],0,0)
	self:addLookupList(MobDB,8898,L["Anvilrage Marshal"],BZ["Blackrock Depths"],0,0)
	self:addLookupList(MobDB,8903,L["Anvilrage Captain"],BZ["Blackrock Depths"],0,0)
	self:addLookupList(MobDB,8920,L["Weapon Technician"],BZ["Blackrock Depths"],0,0)
	self:addLookupList(MobDB,8983,BB["Golem Lord Argelmach"],BZ["Blackrock Depths"],0,0)
	self:addLookupList(MobDB,9024,BB["Pyromancer Loregrain"],BZ["Blackrock Depths"],0,0)
	self:addLookupList(MobDB,9025,BB["Lord Roccor"],BZ["Blackrock Depths"],0,0)
	self:addLookupList(MobDB,9028,BB["Grizzle"],BZ["Blackrock Depths"],0,0)
	self:addLookupList(MobDB,9499,BB["Plugger Spazzring"],BZ["Blackrock Depths"],0,0)
	self:addLookupList(MobDB,9543,BB["Ribbly Screwspigot"],BZ["Blackrock Depths"],0,0)
	self:addLookupList(MobDB,9554,L["Hammered Patron"],BZ["Blackrock Depths"],0,0)
	self:addLookupList(MobDB,10043,L["Ribbly's Crony"],BZ["Blackrock Depths"],0,0)
	-- Blackrock Spire
	self:addLookupList(MobDB,9216,L["Spirestone Warlord"],BZ["Blackrock Spire"],0,0)
	self:addLookupList(MobDB,9259,L["Firebrand Grunt"],BZ["Blackrock Spire"],0,0)
	self:addLookupList(MobDB,9260,L["Firebrand Legionnaire"],BZ["Blackrock Spire"],0,0)
	self:addLookupList(MobDB,9262,L["Firebrand Invoker"],BZ["Blackrock Spire"],0,0)
	self:addLookupList(MobDB,9264,L["Firebrand Pyromancer"],BZ["Blackrock Spire"],0,0)
	self:addLookupList(MobDB,9596,BB["Bannok Grimaxe"],BZ["Blackrock Spire"],0,0)
	self:addLookupList(MobDB,9736,BB["Quartermaster Zigris"],BZ["Blackrock Spire"],0,0)
	self:addLookupList(MobDB,10264,BB["Solakar Flamewreath"],BZ["Blackrock Spire"],0,0)
	self:addLookupList(MobDB,10317,L["Blackhand Elite"],BZ["Blackrock Spire"],0,0)
	self:addLookupList(MobDB,10339,BB["Gyth"],BZ["Blackrock Spire"],0,0)
	self:addLookupList(MobDB,10363,BB["General Drakkisath"],BZ["Blackrock Spire"],0,0)
	self:addLookupList(MobDB,10899,BB["Goraluk Anvilcrack"],BZ["Blackrock Spire"],0,0)
	-- Blackwing Lair
	self:addLookupList(MobDB,14401,L["Master Elemental Shaper Krixix"],BZ["Blackwing Lair"],0,0)
	-- Dire Maul
	self:addLookupList(MobDB,11487,BB["Magister Kalendris"],BZ["Dire Maul"],59.04,48.82)
	self:addLookupList(MobDB,14354,BB["Pusillin"],BZ["Dire Maul"],59.04,48.82)
	-- Drak'Tharon Keep
	self:addLookupList(MobDB,26632,BB["The Prophet Tharon'ja"],BZ["Drak'Tharon Keep"],0,0)
	-- Gnomeregan
	self:addLookupList(MobDB,7800,BB["Mekgineer Thermaplugg"],BZ["Gnomeregan"],0,0)
	-- Halls of Lightning
	self:addLookupList(MobDB,28923,BB["Loken"],BZ["Halls of Lightning"],0,0)
	-- Halls of Stone
	self:addLookupList(MobDB,27978,BB["Sjonnir The Ironshaper"],BZ["Halls of Stone"],0,0)
	-- Karazhan
	self:addLookupList(MobDB,16406,L["Phantom Attendant"],BZ["Karazhan"],0,0)
	self:addLookupList(MobDB,16408,L["Phantom Valet"],BZ["Karazhan"],0,0)
	self:addLookupList(MobDB,16472,L["Phantom Stagehand"],BZ["Karazhan"],0,0)
	self:addLookupList(MobDB,15687,BB["Moroes"],BZ["Karazhan"],0,0)
	self:addLookupList(MobDB,15688,BB["Terestian Illhoof"],BZ["Karazhan"],0,0)
	self:addLookupList(MobDB,16152,BB["Attumen the Huntsman"],BZ["Karazhan"],0,0)
	self:addLookupList(MobDB,16524,BB["Shade of Aran"],BZ["Karazhan"],0,0)
	-- Magister's Terrace
	self:addLookupList(MobDB,24560,BB["Priestess Delrissa"],BZ["Magisters' Terrace"],0,0)
	self:addLookupList(MobDB,24664,BB["Kael'thas Sunstrider"],BZ["Magisters' Terrace"],0,0)
	-- Mana-Tombs
	self:addLookupList(MobDB,18314,L["Nexus Stalker"],BZ["Mana-Tombs"],0,0)
	self:addLookupList(MobDB,18317,L["Ethereal Priest"],BZ["Mana-Tombs"],0,0)
	self:addLookupList(MobDB,18344,BB["Nexus-Prince Shaffar"],BZ["Mana-Tombs"],0,0)
	-- Oculus
	self:addLookupList(MobDB,27656,BB["Ley-Guardian Eregos"],BZ["The Oculus"],0,0)
	-- Old Hillsbrad Foothills
	self:addLookupList(MobDB,17820,L["Durnholde Rifleman"],BZ["Old Hillsbrad Foothills"],0,0)
	self:addLookupList(MobDB,17862,BB["Captain Skarloc"],BZ["Old Hillsbrad Foothills"],0,0)
	self:addLookupList(MobDB,18096,BB["Epoch Hunter"],BZ["Old Hillsbrad Foothills"],0,0)
	self:addLookupList(MobDB,28132,L["Don Carlos"],BZ["Old Hillsbrad Foothills"],0,0)
	-- Ruins of Ahn'Qiraj
	self:addLookupList(MobDB,15340,BB["Moam"],BZ["Ruins of Ahn'Qiraj"],0,0)
	-- Scholomance
	self:addLookupList(MobDB,1853,BB["Darkmaster Gandling"],BZ["Scholomance"],0,0)
	self:addLookupList(MobDB,10469,L["Scholomance Adept"],BZ["Scholomance"],0,0)
	self:addLookupList(MobDB,10499,L["Spectral Researcher"],BZ["Scholomance"],0,0)
	self:addLookupList(MobDB,10503,BB["Jandice Barov"],BZ["Scholomance"],0,0)
	self:addLookupList(MobDB,10508,BB["Ras Frostwhisper"],BZ["Scholomance"],0,0)
	-- Sethekk Halls
	self:addLookupList(MobDB,18320,L["Time-Lost Shadowmage"],BZ["Sethekk Halls"],0,0)
	self:addLookupList(MobDB,18322,L["Sethekk Ravenguard"],BZ["Sethekk Halls"],0,0)
	self:addLookupList(MobDB,18472,BB["Darkweaver Syth"],BZ["Sethekk Halls"],0,0)
	-- Shadow Labyrinth
	self:addLookupList(MobDB,18667,BB["Blackheart the Inciter"],BZ["Shadow Labyrinth"],0,0)
	self:addLookupList(MobDB,18708,BB["Murmur"],BZ["Shadow Labyrinth"],0,0)
	self:addLookupList(MobDB,18830,L["Cabal Fanatic"],BZ["Shadow Labyrinth"],0,0)
	-- Stratholme
	self:addLookupList(MobDB,10398,L["Thuzadin Shadowcaster"],BZ["Stratholme"],0,0)
	self:addLookupList(MobDB,10422,L["Crimson Sorcerer"],BZ["Stratholme"],0,0)
	self:addLookupList(MobDB,10426,L["Crimson Inquisitor"],BZ["Stratholme"],0,0)
	self:addLookupList(MobDB,10813,BB["Balnazzar"],BZ["Stratholme"],0,0)
	self:addLookupList(MobDB,10438,BB["Maleki the Pallid"],BZ["Stratholme"],0,0)
	self:addLookupList(MobDB,10997,BB["Cannon Master Willey"],BZ["Stratholme"],0,0)
	-- Temple of Ahn'Qiraj
	self:addLookupList(MobDB,15263,BB["The Prophet Skeram"],BZ["Temple of Ahn'Qiraj"],0,0)
	self:addLookupList(MobDB,15275,BB["Emperor Vek'nilash"],BZ["Temple of Ahn'Qiraj"],0,0)
	self:addLookupList(MobDB,15276,BB["Emperor Vek'lor"],BZ["Temple of Ahn'Qiraj"],0,0)
	-- The Arcatraz
	self:addLookupList(MobDB,20869,L["Arcatraz Sentinel"],BZ["The Arcatraz"],0,0)
	self:addLookupList(MobDB,20880,L["Eredar Deathbringer"],BZ["The Arcatraz"],0,0)
	self:addLookupList(MobDB,20898,L["Gargantuan Abyssal"],BZ["The Arcatraz"],0,0)
	self:addLookupList(MobDB,20900,L["Unchained Doombringer"],BZ["The Arcatraz"],0,0)
	self:addLookupList(MobDB,20885,BB["Dalliah the Doomsayer"],BZ["The Arcatraz"],0,0)
	--The Black Morass
	self:addLookupList(MobDB,21104,L["Rift Keeper"],BZ["The Black Morass"],0,0)
	self:addLookupList(MobDB,17839,L["Rift Lord"],BZ["The Black Morass"],0,0)
	self:addLookupList(MobDB,17879,BB["Chrono Lord Deja"],BZ["The Black Morass"],0,0)
	-- The Botanica
	self:addLookupList(MobDB,17975,BB["High Botanist Freywinn"],BZ["The Botanica"],0,0)
	self:addLookupList(MobDB,18422,L["Sunseeker Botanist"],BZ["The Botanica"],0,0)
	self:addLookupList(MobDB,17977,BB["Warp Splinter"],BZ["The Botanica"],0,0)
	self:addLookupList(MobDB,17978,BB["Thorngrin the Tender"],BZ["The Botanica"],0,0)
	-- The Deadmines
	self:addLookupList(MobDB,657,L["Defias Pirate"],BZ["The Deadmines"],0,0)
	self:addLookupList(MobDB,1732,L["Defias Squallshaper"],BZ["The Deadmines"],0,0)
	-- The Mechanar
	self:addLookupList(MobDB,19168,L["Sunseeker Astromage"],BZ["The Mechanar"],0,0)
	self:addLookupList(MobDB,19219,BB["Mechano-Lord Capacitus"],BZ["The Mechanar"],0,0)
	self:addLookupList(MobDB,19220,BB["Pathaleon the Calculator"],BZ["The Mechanar"],0,0)
	self:addLookupList(MobDB,19221,BB["Nethermancer Sepethrea"],BZ["The Mechanar"],0,0)
	-- The Nexus
	self:addLookupList(MobDB,26723,BB["Keristrasza"],BZ["The Nexus"],0,0)
	-- The Shattered Halls
	self:addLookupList(MobDB,17465,L["Shattered Hand Centurion"],BZ["The Shattered Halls"],0,0)
	self:addLookupList(MobDB,16807,BB["Grand Warlock Nethekurse"],BZ["The Shattered Halls"],0,0)
	-- The Slave Pens
	self:addLookupList(MobDB,17941,BB["Mennu the Betrayer"],BZ["The Slave Pens"],0,0)
	-- The Steamvault
	self:addLookupList(MobDB,17722,L["Coilfang Sorceress"],BZ["The Steamvault"],0,0)
	self:addLookupList(MobDB,17803,L["Coilfang Oracle"],BZ["The Steamvault"],0,0)
	self:addLookupList(MobDB,17796,BB["Mekgineer Steamrigger"],BZ["The Steamvault"],0,0)
	self:addLookupList(MobDB,17797,BB["Hydromancer Thespia"],BZ["The Steamvault"],0,0)
	self:addLookupList(MobDB,17798,BB["Warlord Kalithresh"],BZ["The Steamvault"],0,0)
	-- The Temple of Atal'Hakkar
	self:addLookupList(MobDB,5226,L["Murk Worm"],BZ["The Temple of Atal'Hakkar"],0,0)
	-- The Violet Hold
	self:addLookupList(MobDB,31134,BB["Cyanigosa"],BZ["The Violet Hold"],0,0)
	-- Utgarde Keep
	self:addLookupList(MobDB,23954,BB["Ingvar the Plunderer"],BZ["Utgarde Keep"],0,0)
	-- Utgarde Pinnacle
	self:addLookupList(MobDB,26861,BB["King Ymiron"],BZ["Utgarde Pinnacle"],0,0)

end
