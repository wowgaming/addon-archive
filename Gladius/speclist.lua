local L = LibStub("AceLocale-3.0"):GetLocale("Gladius", true)

-- Spec-specific buffs
-- Strings are self-buffs only. That unit is that spec.
-- Tables are for castable talent buffs or auras.
function Gladius:GetSpecBuffList()
	return {
		-- WARRIOR
		[GetSpellInfo(56638)]	= L["Arms"],			-- Taste for Blood
		[GetSpellInfo(64976)]	= L["Arms"],			-- Juggernaut
		[GetSpellInfo(29801)]	= L["Fury"],			-- Rampage
		[GetSpellInfo(50227)]	= L["Protection"],		-- Sword and Board
		-- PALADIN
		[GetSpellInfo(20375)]	= L["Retribution"],		-- If you are using Seal of Command, I hate you so much
		[GetSpellInfo(31836)]	= L["Holy"],			-- Light's Grace
		-- ROGUE
		[GetSpellInfo(36554)]	= L["Subtlety"],		-- Shadowstep
		[GetSpellInfo(31223)]	= L["Subtlety"],		-- Master of Subtlety
		-- PRIEST
		[GetSpellInfo(47788)]	= L["Holy"],			-- Guardian Spirit
		[GetSpellInfo(52800)]	= L["Discipline"],		-- Borrowed Time
		[GetSpellInfo(15473)]	= L["Shadow"],			-- Shadowform
		[GetSpellInfo(15286)]	= L["Shadow"],			-- Vampiric Embrace
		-- DEATHKNIGHT
		[GetSpellInfo(49222)]	= L["Unholy"],			-- Bone Shield
		[GetSpellInfo(49016)]	= L["Blood"],			-- Hysteria
		[GetSpellInfo(53138)]	= L["Blood"],			-- Abomination's Might
		[GetSpellInfo(55610)]	= L["Frost"],			-- Imp. Icy Talons
		-- MAGE
		[GetSpellInfo(43039)]	= L["Frost"],			-- Ice Barrier
		[GetSpellInfo(11129)]	= L["Fire"],			-- Combustion
		[GetSpellInfo(31583)]	= L["Arcane"],			-- Arcane Empowerment
		-- WARLOCK
		[GetSpellInfo(30302)]	= L["Destruction"],		-- Nether Protection
		-- SHAMAN
		[GetSpellInfo(57663)]	= L["Elemental"],		-- Totem of Wrath
		[GetSpellInfo(49284)]	= L["Restoration"],		-- Earth Shield
		[GetSpellInfo(51470)]	= L["Elemental"],		-- Elemental Oath
		[GetSpellInfo(30809)]	= L["Enhancement"],		-- Unleashed Rage
		-- HUNTER
		[GetSpellInfo(20895)]	= L["Beast Mastery"],	-- Spirit Bond
		[GetSpellInfo(19506)]	= L["Marksmanship"],	-- Trueshot Aura
		-- DRUID
		[GetSpellInfo(24932)]	= L["Feral"],			-- Leader of the Pack
		[GetSpellInfo(34123)]	= L["Restoration"],		-- Tree of Life
		[GetSpellInfo(24907)]	= L["Balance"],			-- Moonkin Aura
		[GetSpellInfo(53251)]	= L["Restoration"],		-- Wild Growth
	}
end

-- Spec-specific abilities
-- If someone uses that ability, they are that spec.
function Gladius:GetSpecSpellList()
	return {
		-- WARRIOR
		[GetSpellInfo(47486)]	= L["Arms"],			-- Mortal Strike
		[GetSpellInfo(46924)]	= L["Arms"],			-- Bladestorm
		[GetSpellInfo(23881)]	= L["Fury"],			-- Bloodthirst
		[GetSpellInfo(12809)]	= L["Protection"],		-- Concussion Blow
		[GetSpellInfo(47498)]	= L["Protection"],		-- Devastate
		-- PALADIN
		[GetSpellInfo(48827)]	= L["Protection"],		-- Avenger's Shield
		[GetSpellInfo(48825)]	= L["Holy"],			-- Holy Shock
		[GetSpellInfo(35395)]	= L["Retribution"],		-- Crusader Strike
		[GetSpellInfo(53385)]	= L["Retribution"],		-- Divine Storm
		[GetSpellInfo(20066)]	= L["Retribution"],		-- Repentance
		-- ROGUE
		[GetSpellInfo(48666)]	= L["Assassination"],	-- Mutilate
		[GetSpellInfo(51690)]	= L["Combat"],			-- Killing Spree
		[GetSpellInfo(13877)]	= L["Combat"],			-- Blade Flurry
		[GetSpellInfo(13750)]	= L["Combat"],			-- Adrenaline Rush
		[GetSpellInfo(48660)]	= L["Subtlety"],		-- Hemorrhage
		-- PRIEST
		[GetSpellInfo(53007)]	= L["Discipline"],		-- Penance
		[GetSpellInfo(10060)]	= L["Discipline"],		-- Power Infusion
		[GetSpellInfo(33206)]	= L["Discipline"],		-- Pain Suppression
		[GetSpellInfo(34861)]	= L["Holy"],			-- Circle of Healing
		[GetSpellInfo(15487)]	= L["Shadow"],			-- Silence
		[GetSpellInfo(48160)]	= L["Shadow"],			-- Vampiric Touch	
		-- DEATHKNIGHT
		[GetSpellInfo(55262)]	= L["Blood"],			-- Heart Strike
		[GetSpellInfo(49203)]	= L["Frost"],			-- Hungering Cold
		[GetSpellInfo(55268)]	= L["Frost"],			-- Frost Strike
		[GetSpellInfo(51411)]	= L["Frost"],			-- Howling Blast
		[GetSpellInfo(55271)]	= L["Unholy"],			-- Scourge Strike
		-- MAGE
		[GetSpellInfo(44781)]	= L["Arcane"],			-- Arcane Barrage
		[GetSpellInfo(55360)]	= L["Fire"],			-- Living Bomb
		[GetSpellInfo(42950)]	= L["Fire"],			-- Dragon's Breath
		[GetSpellInfo(42945)]	= L["Fire"],			-- Blast Wave
		[GetSpellInfo(44572)]	= L["Frost"],			-- Deep Freeze
		-- WARLOCK
		[GetSpellInfo(59164)]	= L["Affliction"],		-- Haunt
		[GetSpellInfo(47843)]	= L["Affliction"],		-- Unstable Affliction
		[GetSpellInfo(59672)]	= L["Demonology"],		-- Metamorphosis
		[GetSpellInfo(59172)]	= L["Destruction"],		-- Chaos Bolt
		[GetSpellInfo(47847)]	= L["Destruction"],		-- Shadowfury
		-- SHAMAN
		[GetSpellInfo(59159)]	= L["Elemental"],		-- Thunderstorm
		[GetSpellInfo(16166)]	= L["Elemental"],		-- Elemental Mastery
		[GetSpellInfo(51533)]	= L["Enhancement"],		-- Feral Spirit
		[GetSpellInfo(30823)]	= L["Enhancement"],		-- Shamanistic Rage
		[GetSpellInfo(17364)]	= L["Enhancement"],		-- Stormstrike
		[GetSpellInfo(61301)]	= L["Restoration"],		-- Riptide
		[GetSpellInfo(51886)]	= L["Restoration"],		-- Cleanse Spirit
		-- HUNTER
		[GetSpellInfo(19577)]	= L["Beast Mastery"],	-- Intimidation
		[GetSpellInfo(34490)]	= L["Marksmanship"],	-- Silencing Shot
		[GetSpellInfo(53209)]	= L["Marksmanship"],	-- Chimera Shot
		[GetSpellInfo(60053)]	= L["Survival"],		-- Explosive Shot
		[GetSpellInfo(49012)]	= L["Survival"],		-- Wyvern Sting
		-- DRUID
		[GetSpellInfo(53201)]	= L["Balance"],			-- Starfall
		[GetSpellInfo(61384)]	= L["Balance"],			-- Typhoon
		[GetSpellInfo(48566)]	= L["Feral"],			-- Mangle (Cat)
		[GetSpellInfo(48564)]	= L["Feral"],			-- Mangle (Bear)
		[GetSpellInfo(18562)]	= L["Restoration"],		-- Swiftmend
	}
end