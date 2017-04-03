local L = LibStub("AceLocale-3.0"):GetLocale("Gladius", true)

function Gladius:GetDRList()
	return {
		-- Spell ID    Type
		[42950]        = "DISORIENT",    -- Dragons Breath
		[49203]        = "DISORIENT",    -- Hungering Cold
		[51724]        = "DISORIENT",    -- Sap
      [1776]         = "DISORIENT",    -- Gouge
      [51514]        = "DISORIENT",    -- Hex
      [10955]        = "DISORIENT",    -- Shackle Undead
      [61780]        = "DISORIENT",    -- Polymorph
      [14309]        = "DISORIENT",    -- Freezing Trap
      [60210]        = "DISORIENT",    -- Freezing Arrow
      [49012]        = "DISORIENT",    -- Wyvern Sting
      [20066]        = "DISORIENT",    -- Repentance
      
      [53588]        = "SILENCE",      -- Nether Shock
      [1330]         = "SILENCE",      -- Garrote
      [25046]        = "SILENCE",      -- Arcane Torrent
      [15487]        = "SILENCE",      -- Silence 
      [34490]        = "SILENCE",      -- Silencing Shot
      [18425]        = "SILENCE",      -- Improved Kick
      [18469]        = "SILENCE",      -- Improved Counterspell
      [19647]        = "SILENCE",      -- Spell Lock
      [63529]        = "SILENCE",      -- Shield of the Templar
      [49916]        = "SILENCE",      -- Strangulate
      [18498]        = "SILENCE",      -- Gag Order
      
      [53543]        = "DISARM",       -- Snatch
      [51722]        = "DISARM",       -- Dismantle
      [676]          = "DISARM",       -- Disarm
      [53359]        = "DISARM",       -- Chimera Shot
      [64058]        = "DISARM",       -- Psychic Horror
      
      [2094]         = "FEAR",         -- Blind
      [6215]         = "FEAR",         -- Fear
      [6358]         = "FEAR",         -- Seducation
      [17928]        = "FEAR",         -- Howl of Terror
      [10890]        = "FEAR",         -- Psychic Scream
      [14327]        = "FEAR",         -- Scare Beast
      [10326]        = "FEAR",         -- Turn Evil
      [5246]         = "FEAR",         -- Intimidating Shout
      
      [47995]        = "CONTROLLEDSTUN",  -- Intercept (Pet)
      [53562]        = "CONTROLLEDSTUN",  -- Ravage
      [53568]        = "CONTROLLEDSTUN",  -- Sonic Blast
      [12809]        = "CONTROLLEDSTUN",  -- Concussion Blow
      [46968]        = "CONTROLLEDSTUN",  -- Shockwave
      [10308]        = "CONTROLLEDSTUN",  -- Hammer of Justice
      [8983]         = "CONTROLLEDSTUN",  -- Bash
      [19577]        = "CONTROLLEDSTUN",  -- Intimidation
      [49802]        = "CONTROLLEDSTUN",  -- Maim
      [8643]         = "CONTROLLEDSTUN",  -- Kidney Shot
      [20549]        = "CONTROLLEDSTUN",  -- War Stomp
      [20252]	      = "CONTROLLEDSTUN",  -- Intercept
      [44572]        = "CONTROLLEDSTUN",  -- Deep Freeze
      [30414]        = "CONTROLLEDSTUN",  -- Shadowfury
      [2812]         = "CONTROLLEDSTUN",  -- Holy Wrath
      [22703]        = "CONTROLLEDSTUN",  -- Inferno Effect
      [60995]        = "CONTROLLEDSTUN",  -- Demon Charge
      [47481]        = "CONTROLLEDSTUN",  -- Gnaw
      
      [12355]        = "RANDOMSTUN",   -- Impact
      [16544]        = "RANDOMSTUN",   -- Improved Fire Nova Totem
      [39796]        = "RANDOMSTUN",   -- Stoneclaw Totem
      [20170]        = "RANDOMSTUN",   -- Seal of Justice
      [12798]        = "RANDOMSTUN",   -- Revenge Stun
      
      [33395]        = "CONTROLLEDROOT",  -- Freeze
      [53548]        = "CONTROLLEDROOT",  -- Pin
      [42917]        = "CONTROLLEDROOT",  -- Frost Nova
      [53308]        = "CONTROLLEDROOT",  -- Entangling Roots
      [53313]        = "CONTROLLEDROOT",  -- Natures Grasp
      [8377]         = "CONTROLLEDROOT",  -- Earthgrab
      
      [23694]        = "RANDOMROOT",   -- Improved Harmstring
      [12494]        = "RANDOMROOT",   -- Frostbite
      [55080]        = "RANDOMROOT",   -- Shattered Barrier
      
      [47860]        = "HORROR",       -- Death Coil
      [64044]        = "HORROR",       -- Psychic Horror
      
      [19503]        = "OPENERSTUN",   -- Scatter Shot
      [1833]         = "OPENERSTUN",   -- Cheap Shot
      [49803]        = "OPENERSTUN",   -- Pounce
      
      [7922]         = "CHARGE",       -- Charge      
      [605]          = "MINDCONTROL",  -- Mind Control      
      [18647]        = "BANISH",       -- Banish      
      [19185]        = "ENTRAPMENT",   -- Entrapment
      [18658]        = "SLEEP",        -- Hibernate
      [33786]        = "CYCLONE",      -- Cyclone
   }
end