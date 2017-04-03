local L = LibStub("AceLocale-3.0"):GetLocale("Gladius", true)

function Gladius:GetCooldownList()
	return {
		-- Spell Name			   Cooldown[, Spec]
		-- Mage
		["MAGE"] = {
         [1953] 	= 15,    -- Blink
         [42917] 	= 25,    -- Frost Nova
         [2139] 	= 24,    -- Counterspell
         [44572] 	= 30,    -- Deep Freze
         [45438] 	= 300,   -- Ice Block
         [55342] 	= 180,   -- Mirror Image
         [12472] 	= { cd = 180, spec = L["Frost"], },    -- Icy Veins
         [31687] 	= { cd = 180, spec = L["Frost"], },    -- Summon Water Elemental    
         [12043] 	= { cd = 120, spec = L["Arcane"], },   -- Presence of Mind
         [11129] 	= { cd = 120, spec = L["Fire"] },      -- Combustion
         [12042] 	= { cd = 120, spec = L["Arcane"], },   -- Arcane Power  
         [11958] 	= { cd = 480, spec = L["Frost"],       -- Coldsnap
            resetCD = { 
               [12472] = true, 
               [45438] = true, 
               [42917] = true,
               [31687] = true,  
            }, 
         },        
      },
      		
		-- Priest
		["PRIEST"] = {
         [10890] 	= { cd = 27, [L["Shadow"]] = 23, },    -- Psychic Scream  
         [34433] 	= { cd = 300, [L["Shadow"]] = 180, },  -- Shadowfiend
         [15487] 	= { cd = 45, spec = L["Shadow"], },    -- Silence
         [64044] 	= { cd = 120, spec = L["Shadow"], },   -- Psychic Horror   
         [64843] 	= 480,   -- Divine Hymn
         [64901] 	= 360,   -- Hymn of Hope
         [47585] 	= { cd = 75, spec = L["Shadow"], },    -- Dispersion (+ Glyph)
         [10060] 	= { cd = 120, spec = L["Discipline"], }, -- Power Infusion
         [33206] 	= { cd = 180, spec = L["Discipline"], }, -- Pain Suppression
      },
		
		-- Death Knight
		["DEATHKNIGHT"] = {         
         [47476] 	= 120,   -- Strangulate
         [47528] 	= 10,    -- Mind Freeze
         [48707] 	= 45,    -- Anti-Magic Shell
         [48792] 	= 120,   -- Icebound Fortitude
         [49576] 	= 35,    -- Death Grip
         [47568] 	= 300,   -- Empower Rune Weapon
         [48743] 	= 120,   -- Death Pact
         [51052] 	= { cd = 120, spec = L["Unholy"], },   -- Anti-Magic Zone         
         [46584] 	= { cd = 180, notSpec = L["Unholy"], }, -- Raise Dead
         [49206] 	= { cd = 180, spec = L["Unholy"], },   -- Summon Gargoyle
         [49028] 	= { cd = 90, spec = L["Blood"], },     -- Dancing Rune Weapon
         [49203] 	= { cd = 60, spec = L["Frost"], },     -- Hungering Cold         
      },
		
		-- Druid
		["DRUID"] = {
         [22812] 	= 60,    -- Barkskin
         [29166] 	= 180,   -- Innervate
         [8983] 	= 60,    -- Bash
         [53312] 	= 60,    -- Natures Grasp
         [48505] 	= { cd = 90, spec = L["Balance"], },   -- Starfall
         [50334] 	= { cd = 180, spec = L["Feral"], },    -- Berserk
         [17116] 	= { cd = 120, spec = L["Restoration"], } , -- Natures Swiftness
         [33831] 	= { cd = 180, spec = L["Balance"], },  -- Force of Nature
      },
		
		-- Shaman
		["SHAMAN"] = {
         [57994] 	= 6,     -- Wind Shear 
         [51514] 	= 45,    -- Hex
         [30823] 	= { cd = 60, spec = L["Enhancement"], }, -- Shamanistic Rage
         [16166] 	= { cd = 180, spec = L["Elemental"], },  -- Elemental Mastery
         [16188] 	= { cd = 120, spec = L["Restoration"], }, -- Natures Swiftness
         [51533] 	= { cd = 180, spec = L["Enhancement"], }, -- Feral Spirit         
         [16190] 	= { cd = 300, spec = L["Restoration"], }, -- Mana Tide Totem             
      },
      
      -- Paladin
      ["PALADIN"] = {
         [10278] 	= 300,   -- Hand of Protection
         [1044] 	= 25,    -- Hand of Freedom
         [54428] 	= 60,    -- Divine Plea   
         [64205] 	= 120,   -- Divine Sacrifice
         [10308] 	= { cd = 60, [L["Protection"]] = 40, },   -- Hammer of Justice
         [642] 	= { cd = 300,                             -- Divine Shield
            sharedCD = {
               cd = 30,
               [31884] = true,
            },
         },
         [31884] 	= { cd = 180,                             -- Avenging Wrath
            sharedCD = {
               cd = 30,
               [642] = true,
            },
         },      
         [31821] 	= { cd = 120, spec = L["Holy"], },        -- Aura Mastery         
         [20066] 	= { cd = 60, spec = L["Retribution"], },  -- Repentance
         [20216] 	= { cd = 120, spec = L["Holy"], },        -- Divine Favor
         [31842] 	= { cd = 180, spec = L["Holy"], },        -- Divine Illumination
         [31935] 	= { cd = 30, spec = L["Protection"], },   -- Avengers Shield
                                  
      }, 
      
      -- Warlock
      ["WARLOCK"] = {
         [17928] 	= 40,    -- Howl of Terror
         [47860] 	= 120,   -- Death Coil         
         [47996] 	= { cd = 30, pet = true, },               -- Intercept 
         [48020] 	= 30,    -- Demonic Circle: Port
         [19647] 	= { cd = 24, pet = true, },               -- Spell Lock           
         [47847] 	= { cd = 20, spec = L["Destruction"], },  -- Shadowfury
         [47241] 	= { cd = 180, spec = L["Demonology"], },  -- Metamorphosis         
         [1122] 	= { cd = 600, spec = L["Demonology"], },  -- Inferno              
      },  
      
      -- Warrior
      ["WARRIOR"] = {
         [6552] 	= { cd = 10,                              -- Pummel
            sharedCD = {
               [72] = true,
            },
         },
         [72] 	   = { cd = 12,                              -- Shield Bash
            sharedCD = {
               [6552] = true,
            },
         },         
         [23920] 	= 10,    -- Spell Reflection
         [3411] 	= 30,    -- Intervene
         [676] 	= 60,    -- Disarm       
         [5246] 	= 120,   -- Intimidating Shout 
         [2565] 	= 60,    -- Shield Block
         [55694] 	= 180,   -- Enraged Regeneration
         [20230] 	= 300,   -- Retaliation
         [1719] 	= 300,   -- Recklessness                   
         [871] 	= 300,   -- Shield Wall
         [12292] 	= { cd = 180, spec = L["Fury"], },        -- Death Wish
         [46924] 	= { cd = 90, spec = L["Arms"], },         -- Bladestorm
         [46968] 	= { cd = 20, spec = L["Protection"], },   -- Shockwave               
         [12975] 	= { cd = 180, spec = L["Protection"], },  -- Last Stand         
         [12809] 	= { cd = 30, spec = L["Protection"], },   -- Concussion Blow
         
      },
      
      -- Hunter
      ["HUNTER"] = {
         [19503] 	= 30,    -- Scatter Shot
         [19263] 	= 90,    -- Deterrence
         [781] 	= 25,    -- Disengage    
         [60192] 	= { cd = 30,                              -- Freezing Arrow
            sharedCD = {
               [14311] = true,       -- Freezing Trap
               [13809] = true,       -- Frost Trap
               [34600] = true,       -- Snake Trap
            },
         },
         [14311] 	= { cd = 30,                              -- Freezing Trap
            sharedCD = {
               [60192] = true,       -- Freezing Arrow
               [13809] = true,       -- Frost Trap
               [34600] = true,       -- Snake Trap
            },
         },
         [13809] 	= { cd = 30,                              -- Frost Trap
            sharedCD = {
               [14311] = true,       -- Freezing Trap
               [60192] = true,       -- Freezing Arrow
               [34600] = true,       -- Snake Trap
            },
         },
         [34600] 	= { cd = 30,                              -- Snake Trap
            sharedCD = {
               [14311] = true,       -- Freezing Trap
               [13809] = true,       -- Frost Trap
               [60192] = true,       -- Freezing Arrow
            },
         },
         [34490] 	= { cd = 20, spec = L["Marksmanship"], }, -- Silencing Shot
         [19386] 	= { cd = 60, spec = L["Survival"], },     -- Wyvern Sting
         [53271] 	= { cd = 60, pet = true, },               -- Masters Call         
         [19577] 	= { cd = 60, pet = true, },               -- Intimidation
         [19574] 	= { cd = 120, pet = true, },              -- Bestial Wrath
      },
      
      -- Rogue
      ["ROGUE"] = {
         [1766] 	= 10,    -- Kick
         [8643] 	= 20,    -- Kidney Shot
         [26669] 	= 180,   -- Evasion
         [31224] 	= 90,    -- Cloak of Shadow
         [26889] 	= 180,   -- Vanish        
         [2094] 	= 180,   -- Blind
         [51722] 	= 60,    -- Dismantle
         [11305] 	= 180,   -- Sprint
         [14177] 	= { cd = 180, spec = L["Assassination"], }, -- Cold Blood
         [51713] 	= { cd = 60, spec = L["Subtlety"], },     -- Shadow Dance
         [13750] 	= { cd = 180, spec = L["Combat"], },      -- Adrenaline Rush
         [13877] 	= { cd = 120, spec = L["Combat"], },      -- Blade Flurry
         [51690] 	= { cd = 120, spec = L["Combat"], },      -- Killing Spree
         [36554] 	= { cd = 30, spec = L["Subtlety"], },     -- Shadowstep
         [14185] 	= { cd = 480, spec = L["Subtlety"],       -- Preparation
            resetCD = {
               [26669] = true,
               [11305] = true,
               [26889] = true,
               [14177] = true,
               [36554] = true,
            },
         },
      },                        
	}
end