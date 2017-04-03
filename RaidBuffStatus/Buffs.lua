local L = LibStub('AceLocale-3.0'):GetLocale('RaidBuffStatus')
local longtoshortblessing = RaidBuffStatus.longtoshortblessing
local ppassignments = RaidBuffStatus.ppassignments
local pppallies = RaidBuffStatus.pppallies
local SP = RaidBuffStatus.SP
local GT = RaidBuffStatus.GT
local report = RaidBuffStatus.report
local raid = RaidBuffStatus.raid

local BSmeta = {}
local BS = setmetatable({}, BSmeta)
local BSI = setmetatable({}, BSmeta)
BSmeta.__index = function(self, key)
	local name, icon
	if type(key) == "number" then
		name, _, icon = GetSpellInfo(key)
	else
		geterrorhandler()(("Unknown spell key %q"):format(key))
	end
	if name then
		BS[key] = name
		BS[name] = name
		BSI[key] = icon
		BSI[name] = icon
	else
		BS[key] = false
		BSI[key] = false
		geterrorhandler()(("Unknown spell info key %q"):format(key))
	end
	return self[key]
end

local function SpellName(spellID)
	local name = GetSpellInfo(spellID)
	return name
end

local ITmeta = {}
local ITN = setmetatable({}, ITmeta)
local ITT = setmetatable({}, ITmeta)
ITN.unknown = L["Please relog or reload UI to update the item cache."]
ITT.unknown = "Interface\\Icons\\INV_Misc_QuestionMark"
ITmeta.__index = function(self, key)
	local name, icon
	if type(key) == "number" then
		name, _, _, _, _, _, _, _, _, icon = GetItemInfo(key)
		if not name then
			GameTooltip:SetHyperlink("item:"..key..":0:0:0:0:0:0:0")  -- force server to send item info
			GameTooltip:ClearLines();
			name, _, _, _, _, _, _, _, _, icon = GetItemInfo(key)  -- info might not be in the cache yet but worth trying again
		end
	else
		geterrorhandler()(("Unknown item key %q"):format(key))
	end
	if name then
		ITN[key] = name
		ITN[name] = name
		ITT[key] = icon
		ITT[name] = icon
		return self[key]
	end
	return self.unknown
end

local tbcflasks = {
	SpellName(17626), -- Flask of the Titans
	SpellName(17627), -- [Flask of] Distilled Wisdom
	SpellName(17628), -- [Flask of] Supreme Power
	SpellName(17629), -- [Flask of] Chromatic Resistance
	SpellName(28518), -- Flask of Fortification
	SpellName(28519), -- Flask of Mighty Restoration
	SpellName(28520), -- Flask of Relentless Assault
	SpellName(28521), -- Flask of Blinding Light
	SpellName(28540), -- Flask of Pure Death
	SpellName(33053), -- Mr. Pinchy's Blessing
	SpellName(42735), -- [Flask of] Chromatic Wonder
	SpellName(40567), -- Unstable Flask of the Bandit
	SpellName(40568), -- Unstable Flask of the Elder
	SpellName(40572), -- Unstable Flask of the Beast
	SpellName(40573), -- Unstable Flask of the Physician
	SpellName(40575), -- Unstable Flask of the Soldier
	SpellName(40576), -- Unstable Flask of the Sorcerer
	SpellName(41608), -- Relentless Assault of Shattrath
	SpellName(41609), -- Fortification of Shattrath
	SpellName(41610), -- Mighty Restoration of Shattrath
	SpellName(41611), -- Supreme Power of Shattrath
	SpellName(46837), -- Pure Death of Shattrath
	SpellName(46839), -- Blinding Light of Shattrath
	SpellName(67019), -- Flask of the North (WotLK 3.2)
}

local wotlkflasks = {
	SpellName(53755), -- Flask of the Frost Wyrm
	SpellName(53758), -- Flask of Stoneblood
	SpellName(54212), -- Flask of Pure Mojo
	SpellName(53760), -- Flask of Endless Rage
	SpellName(62380), -- Lesser Flask of Resistance  -- pathetic flask
}

local tbcbelixirs = {
	SpellName(11390),-- Arcane Elixir
	SpellName(17538),-- Elixir of the Mongoose
	SpellName(17539),-- Greater Arcane Elixir
	SpellName(28490),-- Major Strength
	SpellName(28491),-- Healing Power
	SpellName(28493),-- Major Frost Power
	SpellName(54494),-- Major Agility
	SpellName(28501),-- Major Firepower
	SpellName(28503),-- Major Shadow Power
	SpellName(38954),-- Fel Strength Elixir
	SpellName(33720),-- Onslaught Elixir
	SpellName(54452),-- Adept's Elixir
	SpellName(33726),-- Elixir of Mastery
	SpellName(26276),-- Elixir of Greater Firepower
	SpellName(45373),-- Bloodberry - only works on Sunwell Plateau
}
local tbcgelixirs = {
	SpellName(11348),-- Greater Armor/Elixir of Superior Defense
	SpellName(11396),-- Greater Intellect
	SpellName(24363),-- Mana Regeneration/Mageblood Potion
	SpellName(28502),-- Major Armor/Elixir of Major Defense
	SpellName(28509),-- Greater Mana Regeneration/Elixir of Major Mageblood
	SpellName(28514),-- Empowerment
	SpellName(29626),-- Earthen Elixir
	SpellName(39625),-- Elixir of Major Fortitude
	SpellName(39627),-- Elixir of Draenic Wisdom
	SpellName(39628),-- Elixir of Ironskin
}

local wotlkbelixirs = {
	SpellName(28497), -- Mighty Agility
	SpellName(53748), -- Mighty Strength
	SpellName(53749), -- Guru's Elixir
	SpellName(33721), -- Spellpower Elixir
	SpellName(53746), -- Wrath Elixir
	SpellName(60345), -- Armor Piercing
	SpellName(60340), -- Accuracy
	SpellName(60344), -- Expertise
	SpellName(60341), -- Deadly Strikes
	SpellName(60346), -- Lightning Speed
}
local wotlkgelixirs = {
	SpellName(60347), -- Mighty Thoughts
	SpellName(53751), -- Mighty Fortitude
	SpellName(53747), -- Elixir of Spirit
	SpellName(60343), -- Mighty Defense
	SpellName(53763), -- Elixir of Protection
	SpellName(53764), -- Mighty Mageblood
}

local wotlkgoodtbcflasks = {}
local wotlkgoodtbcbelixirs = {}
local wotlkgoodtbcgelixirs = {}

table.insert(wotlkgoodtbcflasks,SpellName(17627)) -- [Flask of] Distilled Wisdom

table.insert(wotlkgoodtbcbelixirs,SpellName(33721)) -- Spellpower Elixir
table.insert(wotlkgoodtbcbelixirs,SpellName(28491))-- Healing Power
table.insert(wotlkgoodtbcbelixirs,SpellName(54494))-- Major Agility
table.insert(wotlkgoodtbcbelixirs,SpellName(28503))-- Major Shadow Power

table.insert(wotlkgoodtbcgelixirs,SpellName(39627))-- Elixir of Draenic Wisdom

RaidBuffStatus.wotlkgoodtbcflixirs = {}
for _,v in ipairs (wotlkgoodtbcflasks) do
	table.insert(RaidBuffStatus.wotlkgoodtbcflixirs,v)
end
for _,v in ipairs (wotlkgoodtbcbelixirs) do
	table.insert(RaidBuffStatus.wotlkgoodtbcflixirs,v)
end
for _,v in ipairs (wotlkgoodtbcgelixirs) do
	table.insert(RaidBuffStatus.wotlkgoodtbcflixirs,v)
end

for _,v in ipairs (wotlkgelixirs) do
	table.insert(wotlkgoodtbcgelixirs,v)
end
for _,v in ipairs (wotlkbelixirs) do
	table.insert(wotlkgoodtbcbelixirs,v)
end
for _,v in ipairs (wotlkflasks) do
	table.insert(wotlkgoodtbcflasks,v)
end


local allflasks = {}
local allbelixirs = {}
local allgelixirs = {}
for _,v in ipairs (tbcflasks) do
	table.insert(allflasks,v)
end
for _,v in ipairs (wotlkflasks) do
	table.insert(allflasks,v)
end
for _,v in ipairs (tbcbelixirs) do
	table.insert(allbelixirs,v)
end
for _,v in ipairs (wotlkbelixirs) do
	table.insert(allbelixirs,v)
end
for _,v in ipairs (tbcgelixirs) do
	table.insert(allgelixirs,v)
end
for _,v in ipairs (wotlkgelixirs) do
	table.insert(allgelixirs,v)
end


local foods = {
	SpellName(35272), -- Well Fed
	SpellName(44106), -- "Well Fed" from Brewfest
}

local allfoods = {
	SpellName(35272), -- Well Fed
	SpellName(44106), -- "Well Fed" from Brewfest
	SpellName(43730), -- Electrified
	SpellName(43722), -- Enlightened
	SpellName(25661), -- Increased Stamina
	SpellName(25804), -- Rumsey Rum Black Label
}

local fortitude = {
	SpellName(1243), -- Power Word: Fortitude
	SpellName(21562), -- Prayer of Fortitude
}

local wild = {
	SpellName(1126), -- Mark of the Wild
	SpellName(21849), -- Gift of the Wild
}

local intellect = {
	SpellName(1459), -- Arcane Intellect
	SpellName(23028), -- Arcane Brilliance
	SpellName(61024), -- Dalaran Intellect
	SpellName(61316), -- Dalaran Brilliance
}

local spirit = {
	SpellName(14752), -- Divine Spirit
	SpellName(27681), -- Prayer of Spirit
}

local shadow = {
	SpellName(976), -- Shadow Protection
	SpellName(27683), -- Prayer of Shadow Protection
}

local auras = {
	SpellName(32223), -- Crusader Aura
	SpellName(465), -- Devotion Aura
	SpellName(7294), -- Retribution Aura
	SpellName(19746), -- Concentration Aura
	SpellName(19876), -- Shadow Resistance Aura
	SpellName(19888), -- Frost Resistance Aura
	SpellName(19891), -- Fire Resistance Aura
}

local aspects = {
	SpellName(13163), -- Aspect of the Monkey
	SpellName(13165), -- Aspect of the Hawk
	SpellName(13161), -- Aspect of the Beast
	SpellName(20043), -- Aspect of the Wild
	SpellName(34074), -- Aspect of the Viper
	SpellName(5118), -- Aspect of the Cheetah
	SpellName(13159), -- Aspect of the Pack
	SpellName(61846),  -- Aspect of the Dragonhawk
}

local badaspects = {
	SpellName(5118), -- Aspect of the Cheetah
	SpellName(13159), -- Aspect of the Pack
}

local magearmors = {
	SpellName(6117), -- Mage Armor
	SpellName(168), -- Frost Armor
	SpellName(7302), -- Ice Armor
	SpellName(30482), -- Molten Armor
}

local dkpresences = {
	SpellName(48266), -- Blood Presence
	SpellName(48263), -- Frost Presence
	SpellName(48265), -- Unholy Presence
}

local seals = {
	SpellName(20165), -- Seal of Light
	SpellName(20166), -- Seal of Wisdom
	SpellName(21084), -- Seal of Righteousness
	SpellName(20164), -- Seal of Justice
	SpellName(31801), -- Seal of Vengeance
	SpellName(20375), -- Seal of Command
	SpellName(53736), -- Seal of Corruption
}

local blessingofforgottenkings = {
	BS[69378], -- Blessing of Forgotten Kings
	BS[20217], -- Blessing of Kings
	BS[25898], -- Greater Blessing of Kings
}

local blessingofkings = {
	BS[20217], -- Blessing of Kings
	BS[25898], -- Greater Blessing of Kings
--	BS[69378], -- Blessing of Forgotten Kings
}
blessingofkings.name = BS[20217] -- Blessing of Kings
blessingofkings.shortname = L["BoK"]

local blessingofsanctuary = {
	BS[20911], -- Blessing of Sanctuary
	BS[25899], -- Greater Blessing of Sanctuary
}
blessingofsanctuary.name = BS[20911] -- Blessing of Sanctuary
blessingofsanctuary.shortname = L["BoS"]

local blessingofwisdom = {
	BS[19742], -- Blessing of Wisdom
	BS[25894], -- Greater Blessing of Wisdom
	BS[5677], -- Mana Spring
}
blessingofwisdom.name = BS[19742] -- Blessing of Wisdom
blessingofwisdom.shortname = L["BoW"]

local blessingofmight = {
	BS[19740], -- Blessing of Might
	BS[25782], -- Greater Blessing of Might
	BS[27578], -- Battle Shout
}
blessingofmight.name = BS[19740] -- Blessing of Might
blessingofmight.shortname = L["BoM"]

local allblessings = {}
table.insert(allblessings, blessingofkings)
table.insert(allblessings, blessingofsanctuary)
table.insert(allblessings, blessingofwisdom)
table.insert(allblessings, blessingofmight)

local nametoblessinglist = {}
nametoblessinglist[BS[20217]] = blessingofkings -- Blessing of Kings
nametoblessinglist[BS[20911]] = blessingofsanctuary -- Blessing of Sanctuary
nametoblessinglist[BS[19742]] = blessingofwisdom -- Blessing of Wisdom
nametoblessinglist[BS[19740]] = blessingofmight -- Blessing of Might
RaidBuffStatus.nametoblessinglist = nametoblessinglist

local minblessings = {}
local mb = minblessings
mb.WARRIOR = {}
mb.WARRIOR.All = {}
mb.WARRIOR.All[1] = blessingofmight
mb.WARLOCK = {}
mb.WARLOCK.All = {}
mb.SHAMAN = {}
mb.SHAMAN.All = {}
mb.SHAMAN[L["Elemental"]] = {}
mb.SHAMAN[L["Enhancement"]] = {}
mb.SHAMAN[L["Restoration"]] = {}
mb.SHAMAN[L["Enhancement"]][1] = blessingofmight
mb.ROGUE = {}
mb.ROGUE.All = {}
mb.ROGUE.All[1] = blessingofmight
mb.PRIEST = {}
mb.PRIEST.All = {}
mb.PALADIN = {}
mb.PALADIN.All = {}
mb.PALADIN[L["Holy"]] = {}
mb.PALADIN[L["Protection"]] = {}
mb.PALADIN[L["Retribution"]] = {}
mb.PALADIN[L["Protection"]][1] = blessingofmight
mb.PALADIN[L["Retribution"]][1] = blessingofmight
mb.MAGE = {}
mb.MAGE.All = {}
mb.HUNTER = {}
mb.HUNTER.All = {}
mb.HUNTER.All[1] = blessingofmight
mb.DRUID = {}
mb.DRUID.All = {}
mb.DRUID[L["Balance"]] = {}
mb.DRUID[L["Feral Combat"]] = {}
mb.DRUID[L["Restoration"]] = {}
mb.DRUID[L["Feral Combat"]][1] = blessingofmight
mb.DEATHKNIGHT = {}
mb.DEATHKNIGHT.All = {}
mb.DEATHKNIGHT.All[1] = blessingofmight
table.insert(mb.WARRIOR.All, blessingofkings) -- todo change in to the format above instead of table inserts
table.insert(mb.WARLOCK.All, blessingofkings)
table.insert(mb.SHAMAN.All, blessingofkings)
table.insert(mb.SHAMAN[L["Elemental"]], blessingofkings)
table.insert(mb.SHAMAN[L["Enhancement"]], blessingofkings)
table.insert(mb.SHAMAN[L["Restoration"]], blessingofkings)
table.insert(mb.ROGUE.All, blessingofkings)
table.insert(mb.PRIEST.All, blessingofkings)
table.insert(mb.PALADIN.All, blessingofkings)
table.insert(mb.PALADIN[L["Holy"]], blessingofkings)
table.insert(mb.PALADIN[L["Protection"]], blessingofkings)
table.insert(mb.PALADIN[L["Retribution"]], blessingofkings)
table.insert(mb.MAGE.All, blessingofkings)
table.insert(mb.HUNTER.All, blessingofkings)
table.insert(mb.DRUID.All, blessingofkings)
table.insert(mb.DRUID[L["Restoration"]], blessingofkings)
table.insert(mb.DRUID[L["Balance"]], blessingofkings)
table.insert(mb.DRUID[L["Feral Combat"]], blessingofkings)
table.insert(mb.DEATHKNIGHT.All, blessingofkings)
table.insert(mb.WARLOCK.All, blessingofwisdom)
table.insert(mb.SHAMAN.All, blessingofwisdom)
table.insert(mb.SHAMAN[L["Elemental"]], blessingofwisdom)
table.insert(mb.SHAMAN[L["Enhancement"]], blessingofwisdom)
table.insert(mb.SHAMAN[L["Restoration"]], blessingofwisdom)
table.insert(mb.PRIEST.All, blessingofwisdom)
table.insert(mb.PALADIN.All, blessingofwisdom)
table.insert(mb.PALADIN[L["Protection"]], blessingofwisdom)
table.insert(mb.PALADIN[L["Holy"]], blessingofwisdom)
table.insert(mb.PALADIN[L["Retribution"]], blessingofwisdom)
table.insert(mb.MAGE.All, blessingofwisdom)
table.insert(mb.HUNTER.All, blessingofwisdom)
table.insert(mb.DRUID.All, blessingofwisdom)
table.insert(mb.DRUID[L["Balance"]], blessingofwisdom)
table.insert(mb.DRUID[L["Feral Combat"]], blessingofwisdom)
table.insert(mb.DRUID[L["Restoration"]], blessingofwisdom)
table.insert(mb.WARRIOR.All, blessingofsanctuary)
table.insert(mb.WARLOCK.All, blessingofsanctuary)
table.insert(mb.SHAMAN.All, blessingofsanctuary)
table.insert(mb.SHAMAN[L["Elemental"]], blessingofsanctuary)
table.insert(mb.SHAMAN[L["Enhancement"]], blessingofsanctuary)
table.insert(mb.SHAMAN[L["Restoration"]], blessingofsanctuary)
table.insert(mb.ROGUE.All, blessingofsanctuary)
table.insert(mb.PRIEST.All, blessingofsanctuary)
table.insert(mb.PALADIN.All, blessingofsanctuary)
table.insert(mb.PALADIN[L["Holy"]], blessingofsanctuary)
table.insert(mb.PALADIN[L["Protection"]], blessingofsanctuary)
table.insert(mb.PALADIN[L["Retribution"]], blessingofsanctuary)
table.insert(mb.MAGE.All, blessingofsanctuary)
table.insert(mb.HUNTER.All, blessingofsanctuary)
table.insert(mb.DRUID.All, blessingofsanctuary)
table.insert(mb.DRUID[L["Restoration"]], blessingofsanctuary)
table.insert(mb.DRUID[L["Balance"]], blessingofsanctuary)
table.insert(mb.DRUID[L["Feral Combat"]], blessingofsanctuary)
table.insert(mb.DEATHKNIGHT.All, blessingofsanctuary)


local scrollofagility = {
	BS[8115], -- Agility
}
scrollofagility.name = BS[8115] -- Agility
scrollofagility.shortname = L["Agil"]

local scrollofstrength = {
	BS[8118], -- Strength
}
scrollofstrength.name = BS[8118] -- Strength
scrollofstrength.shortname = L["Str"]

local scrollofintellect = {
	BS[8096], -- Intellect
}
scrollofintellect.name = BS[8096] -- Intellect
scrollofintellect.shortname = L["Int"]

local scrollofprotection = {
	BS[42206], -- Protection
}
scrollofprotection.name = BS[42206] -- Protection
scrollofprotection.shortname = L["Prot"]

local scrollofspirit = {
	BS[8112], -- Spirit
}
scrollofspirit.name = BS[8112] -- Spirit
scrollofspirit.shortname = L["Spi"]

local flaskzones = {
	gruul = {
		zones = {
			L["Gruul's Lair"],
		},
		flasks = {
			SpellName(40567), -- 40567 Unstable Flask of the Bandit
			SpellName(40568), -- 40568 Unstable Flask of the Elder
			SpellName(40572), -- 40572 Unstable Flask of the Beast
			SpellName(40573), -- 40573 Unstable Flask of the Physician
			SpellName(40575), -- 40575 Unstable Flask of the Soldier
			SpellName(40576), -- 40576 Unstable Flask of the Sorcerer
		},
	},
	shattrath = {
		zones = {
			L["Tempest Keep"],
			L["Serpentshrine Cavern"],
			L["Black Temple"],
			L["Sunwell Plateau"],
			L["Hyjal Summit"],
		},
		flasks = {
			SpellName(41608), -- 41608 Relentless Assault of Shattrath
			SpellName(41609), -- 41609 Fortification of Shattrath
			SpellName(41610), -- 41610 Mighty Restoration of Shattrath
			SpellName(41611), -- 41611 Sureme Power of Shattrath
			SpellName(46837), -- 46837 Pure Death of Shattrath
			SpellName(46839), -- 46839 Blinding Light of Shattrath
		},
	},
}

local roguewepbuffs = {
	L["( Poison ?[IVX]*)"], -- Anesthetic Poison, Deadly Poison [IVX]*, Crippling Poison [IVX]*, Wound Poison [IVX]*, Instant Poison [IVX]*, Mind-numbing Poison [IVX]*
}

local lockwepbuffs = {
	L["(Spellstone)"], -- Lock self buff
	L["(Firestone)"], -- Lock self buff
}

local shamanwepbuffs = {
	L["(Flametongue)"], -- Shaman self buff
	L["(Earthliving)"], -- Resto Shaman self buff
	L["(Frostbrand)"], -- Shaman self buff
	L["(Rockbiter)"], -- Shaman self buff
	L["(Windfury)"], -- Shaman self buff
}


local BF = {
	pvp = {											-- button name
		order = 1000,
		list = "pvplist",								-- list name
		check = "checkpvp",								-- check name
		default = false,									-- default state enabled
		defaultbuff = false,								-- default state report as buff missing
		defaultwarning = true,								-- default state report as warning
		defaultdash = false,								-- default state show on dash
		defaultdashcombat = false,							-- default state show on dash when in combat
		defaultboss = false,
		defaulttrash = false,
		checkzonedout = true,								-- check when unit is not in this zone
		selfbuff = true,								-- is it a buff the player themselves can fix
		timer = true,									-- rbs will count how many minutes this buff has been missing/active
		chat = L["PVP On"],								-- chat report
		pre = nil,
		main = function(self, name, class, unit, raid, report)				-- called in main loop
			if UnitIsPVP(unit.unitid) then
				table.insert(report.pvplist, name)
			end
		end,
		post = nil,									-- called after main loop
		icon = "Interface\\Icons\\INV_BannerPVP_02",					-- icon
		update = function(self)								-- icon text
			RaidBuffStatus:DefaultButtonUpdate(self, report.pvplist, RaidBuffStatus.db.profile.checkpvp, true, report.pvplist)
		end,
		click = function(self, button, down)						-- button click
			RaidBuffStatus:ButtonClick(self, button, down, "pvp")
		end,
		tip = function(self)								-- tool tip
			RaidBuffStatus:Tooltip(self, L["PVP is On"], report.pvplist, raid.BuffTimers.pvptimerlist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
	},
	crusader = {
		order = 990,
		list = "crusaderlist",
		check = "checkcrusader",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { PALADIN = true, },
		chat = BS[32223], -- Crusader Aura
		pre = function(self, raid, report)
			report.whoescrusader = {}
		end,
		main = function(self, name, class, unit, raid, report)
			if class == "PALADIN" then
				report.checking.crusader = true
				if unit.hasbuff[BS[32223]] then -- Crusader Aura
					local _, _, _, _, _, _, _, isMine = UnitBuff(unit.unitid, BS[32223]) -- Crusader Aura
					if isMine then
						local lolname = UnitName(isMine)
						report.whoescrusader[lolname] = true
					end
				end
			end
		end,
		post = function(self, raid, report)
			for name, _ in pairs(report.whoescrusader) do
				table.insert(report.crusaderlist, name)
			end
		end,
		icon = BSI[32223], -- Crusader Aura
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.crusaderlist, RaidBuffStatus.db.profile.checkcrusader, report.checking.crusader or false, report.crusaderlist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "crusader", RaidBuffStatus:SelectPalaAura())
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Paladin has Crusader Aura"], report.crusaderlist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
	},

	shadows = {
		order = 980,
		list = "shadowslist",
		check = "checkshadows",
		default = false,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = false,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		chat = L["Shadow Resistance Aura AND Shadow Protection"],
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.PRIEST > 0 then
				if class == "PALADIN" then
					report.checking.shadows = true
					if unit.hasbuff[BS[19876]] then -- Shadow Resistance Aura
						table.insert(report.shadowslist, name)
					end
				end
			end
		end,
		post = nil,
		icon = BSI[19876], -- Shadow Resistance Aura
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.shadowslist, RaidBuffStatus.db.profile.checkshadows, report.checking.shadows or false, nil)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "shadows", RaidBuffStatus:SelectPalaAura())
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Paladin has Shadow Resistance Aura AND Shadow Protection"], report.shadowslist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
	},
	health = {
		order = 970,
		list = "healthlist",
		check = "checkhealth",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = true,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { WARRIOR = true, ROGUE = true, PRIEST = true, DRUID = true, PALADIN = true, HUNTER = true, MAGE = true, WARLOCK = true, SHAMAN = true, DEATHKNIGHT = true, },
		chat = L["Health less than 80%"],
		main = function(self, name, class, unit, raid, report)
			if not unit.isdead then
				if UnitHealth(unit.unitid)/UnitHealthMax(unit.unitid) < 0.8 then
					table.insert(report.healthlist, name)
				end
			end
		end,
		post = nil,
		icon = "Interface\\Icons\\INV_Potion_131",
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.healthlist, RaidBuffStatus.db.profile.checkhealth, true, report.healthlist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "health")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Player has health less than 80%"], report.healthlist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
	},

	mana = {
		order = 960,
		list = "manalist",
		check = "checkmana",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = true,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { PRIEST = true, DRUID = true, PALADIN = true, HUNTER = true, MAGE = true, WARLOCK = true, SHAMAN = true, },
		chat = L["Mana less than 80%"],
		main = function(self, name, class, unit, raid, report)
			if unit.isdead then
				return
			end
			if class == "WARRIOR" or class == "ROGUE" or class == "DEATHKNIGHT" then
				return
			end
			if class == "DRUID" then
				if raid.classes.DRUID[name].spec == L["Feral Combat"] then
					return
				end
			end
			if UnitMana(unit.unitid)/UnitManaMax(unit.unitid) < 0.8 then
				table.insert(report.manalist, name)
			end
		end,
		post = nil,
		icon = "Interface\\Icons\\INV_Potion_137",
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.manalist, RaidBuffStatus.db.profile.checkmana, true, report.manalist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "mana")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Player has mana less than 80%"], report.manalist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
	},
	zone = {
		order = 950,
		list = "zonelist",
		check = "checkzone",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = true, -- actually has no effect
		selfbuff = false,
		timer = false,
		core = true,
		chat = L["Different Zone"],
		main = nil, -- done by main code
		post = nil,
		icon = "Interface\\Icons\\INV_Misc_QuestionMark",
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.zonelist, RaidBuffStatus.db.profile.checkzone, true, nil)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "zone")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Player is in a different zone"], report.zonelist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
	},

	offline = {
		order = 940,
		list = "offlinelist",
		check = "checkoffline",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = true,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = true, -- actualy has no effect
		selfbuff = false,
		timer = true,
		core = true,
		chat = L["Offline"],
		main = nil, -- done by main code
		post = nil,
		icon = "Interface\\Icons\\INV_Gizmo_FelStabilizer",
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.offlinelist, RaidBuffStatus.db.profile.checkoffline, true, nil)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "offline")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Player is Offline"], report.offlinelist, raid.BuffTimers.offlinetimerlist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
	},

	afk = {
		order = 930,
		list = "afklist",
		check = "checkafk",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = true,
		selfbuff = true,
		timer = true,
		chat = L["AFK"],
		main = function(self, name, class, unit, raid, report)
			if UnitIsAFK(unit.unitid) then
				table.insert(report.afklist, name)
			end
		end,
		post = nil,
		icon = "Interface\\Icons\\Trade_Fishing",
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.afklist, RaidBuffStatus.db.profile.checkafk, true, report.afklist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "afk")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Player is AFK"], report.afklist, raid.BuffTimers.afktimerlist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
	},

	dead = {
		order = 920,
		list = "deadlist",
		check = "checkdead",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = true,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = true,
		selfbuff = false,
		timer = true,
		class = { PRIEST = true, DRUID = true, PALADIN = true, SHAMAN = true, },
		chat = L["Dead"],
		main = function(self, name, class, unit, raid, report)
			if unit.isdead then
				table.insert(report.deadlist, name)
			end
		end,
		post = nil,
		icon = "Interface\\Icons\\Spell_Holy_SenseUndead",
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.deadlist, RaidBuffStatus.db.profile.checkdead, true, RaidBuffStatus.BF.dead:buffers())
		end,
		click = function(self, button, down)
			local rezspell = RaidBuffStatus:SelectRezSpell()
			RaidBuffStatus:ButtonClick(self, button, down, "dead", rezspell, rezspell, nil, true)
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Player is Dead"], report.deadlist, raid.BuffTimers.deadtimerlist, RaidBuffStatus.BF.dead:buffers())
		end,
		whispertobuff = nil,
		singlebuff = true,
		partybuff = false,
		raidbuff = false,
		whispertobuff = function(reportl, prefix)
			local therezers = RaidBuffStatus.BF.dead:buffers()
			for _,name in ipairs(therezers) do
				if RaidBuffStatus.db.profile.WhisperMany and #reportl >= RaidBuffStatus.db.profile.HowMany then
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.dead.chat .. ">: " .. L["MANY!"], name)
				else
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.dead.chat .. ">: " .. table.concat(reportl, ", "), name)
				end
			end
		end,
		buffers = function()
			local therezers = {}
			for name,_ in pairs(raid.classes.DRUID) do
				table.insert(therezers, name)
			end
			for name,_ in pairs(raid.classes.PALADIN) do
				table.insert(therezers, name)
			end
			for name,_ in pairs(raid.classes.SHAMAN) do
				table.insert(therezers, name)
			end
			for name,_ in pairs(raid.classes.PRIEST) do
				table.insert(therezers, name)
			end
			return therezers
		end,
	},
	durability = {
		order = 910,
		list = "durabilitylist",
		check = "checkdurability",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = true,
		selfbuff = true,
		timer = false,
		chat = L["Low durability"],
		main = function(self, name, class, unit, raid, report)
			if not oRA or not raid.israid or raid.isbattle then
				return
			end
			report.checking.durabilty = true
			local broken = RaidBuffStatus.broken[name]
			if broken ~= nil and broken ~= "0" then
				table.insert(report.durabilitylist, name .. "(0)")
			else
				local dura = RaidBuffStatus.durability[name]
				if dura ~= nil and dura < 36 then
					table.insert(report.durabilitylist, name .. "(" .. dura .. ")")
				end
			end
		end,
		post = nil,
		icon = "Interface\\Icons\\INV_Chest_Cloth_61",
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.durabilitylist, RaidBuffStatus.db.profile.checkdurability, report.checking.durabilty or false, report.durabilitylist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "durability")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Low durability (35% or less)"], report.durabilitylist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
	},

	cheetahpack = {
		order = 900,
		list = "cheetahpacklist",
		check = "checkcheetahpack",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { HUNTER = true, },
		chat = L["Aspect Cheetah/Pack On"],
		main = function(self, name, class, unit, raid, report)
			if class == "HUNTER" then
				report.checking.cheetahpack = true
				local hasbuff = false
				for _, v in ipairs(badaspects) do
					if unit.hasbuff[v] then
						hasbuff = true
						break
					end
				end
				if hasbuff then
					if RaidBuffStatus.db.profile.ShowGroupNumber then
						table.insert(report.cheetahpacklist, name .. "(" .. unit.group .. ")" )
					else
						table.insert(report.cheetahpacklist, name)
					end
				end
			end
		end,
		post = function(self, raid, report)
			RaidBuffStatus:SortNameBySuffix(report.cheetahpacklist)
		end,
		icon = BSI[5118], -- Aspect of the Cheetah
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.cheetahpacklist, RaidBuffStatus.db.profile.checkcheetahpack, report.checking.cheetahpack or false, report.cheetahpacklist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "cheetahpack")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Aspect of the Cheetah or Pack is on"], report.cheetahpacklist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
	},

	oldflixir = {
		order = 895,
		list = "oldflixirlist",
		check = "checkoldflixir",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = false,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		chat = L["Flasked or Elixired but slacking"],
		main = function(self, name, class, unit, raid, report)
			for _, v in ipairs(tbcflasks) do
				if unit.hasbuff[v] then
					table.insert(report.oldflixirlist, name .. "(" .. v .. ")")
					return
				end
			end
			for _, v in ipairs(tbcbelixirs) do
				if unit.hasbuff[v] then
					table.insert(report.oldflixirlist, name .. "(" .. v .. ")")
					return
				end
			end
			for _, v in ipairs(tbcgelixirs) do
				if unit.hasbuff[v] then
					table.insert(report.oldflixirlist, name .. "(" .. v .. ")")
					return
				end
			end
		end,
		post = nil,
		icon = "Interface\\Icons\\INV_Potion_91",
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.oldflixirlist, RaidBuffStatus.db.profile.checkoldflixir, true, report.oldflixirlist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "oldflixir")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Flasked or Elixired but slacking"], report.oldflixirlist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
	},

	slackingfood = {
		order = 894,
		list = "slackingfoodlist",
		check = "checkslackingfood",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = false,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		chat = L["Well Fed but slacking"],
		main = function(self, name, class, unit, raid, report)
			local hasfood = false
			local slacking = false
			for _, v in ipairs(allfoods) do
				if unit.hasbuff[v] then
					hasfood = true
					break
				end
			end
			if hasfood then
				slacking = true
				if unit.hasbuff["foodz"] then
					if unit.hasbuff["foodz"]:find(L["Stamina increased by 40"]) then
						slacking = false
					end
				end
			end
			if slacking then
				table.insert(report.slackingfoodlist, name)
			end
		end,
		post = nil,
		icon = "Interface\\Icons\\INV_Misc_Food_67",
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.slackingfoodlist, RaidBuffStatus.db.profile.checkslackingfood, true, report.slackingfoodlist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "slackingfood")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Well Fed but slacking"], report.slackingfoodlist)
		end,
		partybuff = nil,
	},

	righteousfury = {
		order = 890,
		list = "righteousfurylist",
		check = "checkrighteousfury",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		core = true,
		class = { PALADIN = true, },
		chat = BS[25780], -- Righteous Fury
		main = function(self, name, class, unit, raid, report)
			if class == "PALADIN" then
				if raid.classes.PALADIN[name].spec == L["Protection"] then
					report.checking.righteousfury = true
					if not unit.hasbuff[BS[25780]] then -- Righteous Fury
						table.insert(report.righteousfurylist, name)
					end
				end
			end
		end,
		post = nil,
		icon = BSI[25780], -- Righteous Fury
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.righteousfurylist, RaidBuffStatus.db.profile.checkrighteousfury, report.checking.righteousfury or false, report.righteousfurylist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "righteousfury", BS[25780]) -- Righteous Fury
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Protection Paladin with no Righteous Fury"], report.righteousfurylist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
	},

	thorns = {
		order = 880,
		list = "thornslist",
		check = "checkthorns",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		class = { DRUID = true, },
		chat = BS[26992],  -- Thorns
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.DRUID < 1 then
				return
			end
			if not unit.istank then
				return  -- only tanks need thorns
			end
			if class == "PALADIN" or class == "DRUID" or class == "WARRIOR" or class == "DEATHKNIGHT" then  -- only melee tanks need thorns
				report.checking.thorns = true
				if not unit.hasbuff[BS[26992]] then  -- Thorns
					table.insert(report.thornslist, name)
				end
			end
		end,
		post = nil,
		icon = BSI[26992],  -- Thorns
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.thornslist, RaidBuffStatus.db.profile.checkthorns, report.checking.thorns or false, RaidBuffStatus.BF.thorns:buffers())
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "thorns", BS[26992], BS[26992], nil, true)  -- Thorns
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Tank missing Thorns"], report.thornslist, nil, RaidBuffStatus.BF.thorns:buffers())
		end,
		singlebuff = true,
		partybuff = false,
		raidbuff = false,
		whispertobuff = function(reportl, prefix)
			for name,_ in pairs(raid.classes.DRUID) do
				if RaidBuffStatus.db.profile.WhisperMany and #reportl >= RaidBuffStatus.db.profile.HowMany then
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.thorns.chat .. ">: " .. L["MANY!"], name)
				else
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.thorns.chat .. ">: " .. table.concat(reportl, ", "), name)
				end
			end
		end,
		buffers = function()
			local thedruids = {}
			for name,_ in pairs(raid.classes.DRUID) do
				table.insert(thedruids, name)
			end
			return thedruids
		end,
	},

	vigilancebuff = {
		order = 876,
		list = "vigilancebufflist",
		check = "checkvigilancebuff",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		class = { WARRIOR = true, },
		chat = function(report, raid, prefix, channel)
			prefix = prefix or ""
			if report.checking.vigilancebuff then
				if #report.peoplegotvigilance < #raid.VigilanceTalent then
					RaidBuffStatus:Say(prefix .. "<" .. L["Missing Vigilance"] .. ">: " .. L["Got"] .. " " .. #report.peoplegotvigilance .. " " .. L["expecting"] .. " " .. #raid.VigilanceTalent, nil, nil, channel)
				end
			end
		end,
		pre = function(self, raid, report)
			report.peoplegotvigilance = {}
		end,
		main = function(self, name, class, unit, raid, report)
			if # raid.VigilanceTalent < 1 then
				return
			end
			report.checking.vigilancebuff = true
			if unit.hasbuff[BS[50725]] then  -- Vigilance
				table.insert(report.peoplegotvigilance , name)
			end
		end,
		post = function(self, raid, report)
			local missing = # raid.VigilanceTalent - #report.peoplegotvigilance
			if missing > 0 then
				report.vigilancebufflist = {}
				for row = 1, missing do
					table.insert(report.vigilancebufflist, "raid")
				end
			end
		end,
		icon = BSI[50725],  -- Vigilance
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.vigilancebufflist, RaidBuffStatus.db.profile.checkvigilancebuff, report.checking.vigilancebuff or false)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "vigilancebuff")
		end,
		tip = function(self)
			if not report.peoplegotvigilance then  -- fixes error when tip being called from option window when not in a party/raid
				RaidBuffStatus:Tooltip(self, L["Missing Vigilance"])
			else
				RaidBuffStatus:Tooltip(self, L["Missing Vigilance"], {L["Got"] .. " " .. #report.peoplegotvigilance, " " .. L["expecting"] .. " " .. #raid.VigilanceTalent}, nil, raid.VigilanceTalent, nil, nil, nil, nil, nil, nil, report.peoplegotvigilance)
			end
		end,
		singlebuff = true,
		partybuff = false,
		raidbuff = false,
		whispertobuff = function(reportl, prefix)
			for _,name in pairs(raid.VigilanceTalent) do
				RaidBuffStatus:Say(prefix .. "<" .. L["Missing Vigilance"] .. "> " .. L["Got"] .. " " .. #report.peoplegotvigilance .. " " .. L["expecting"] .. " " .. #raid.VigilanceTalent, name)
			end
		end,
		buffers = function()
			return raid.VigilanceTalent
		end,
	},


	earthshield = {
		order = 875,
		list = "earthshieldlist",
		check = "checkearthshield",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		class = { SHAMAN = true, },
		chat = BS[974],  -- Earth Shield
		pre = function(self, raid, report)
			report.tanksneedingearthshield = {}
			report.tanksgotearthshield = {}
			report.shamanwithearthshield = {}
		end,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.SHAMAN < 1 then
				return
			end
			if class == "SHAMAN" then
				if raid.classes.SHAMAN[name].specialisations.earthshield then
					table.insert(report.shamanwithearthshield, name)
				end
			elseif unit.istank then
				if class == "PALADIN" or class == "DRUID" or class == "WARRIOR" or class == "DEATHKNIGHT" then  -- only melee tanks need earthshield
					report.checking.earthshield = true
					if unit.hasbuff[BS[974]] then  -- Earth Shield
						table.insert(report.tanksgotearthshield, name)
					else
						table.insert(report.tanksneedingearthshield, name)
					end
				end
			end
		end,
		post = function(self, raid, report)
			local numberneeded = #report.tanksneedingearthshield
			local numberavailable = #report.shamanwithearthshield - #report.tanksgotearthshield
			if #report.tanksneedingearthshield > 0 and #report.shamanwithearthshield > 0 then
				report.checking.earthshield = true
			end
			if numberneeded > 0 and numberavailable > 0 then
				report.earthshieldlist = report.tanksneedingearthshield
			end
		end,
		icon = BSI[974],  -- Earth Shield
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.earthshieldlist, RaidBuffStatus.db.profile.checkearthshield, report.checking.earthshield or false, RaidBuffStatus.BF.earthshield:buffers())
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "earthshield", BS[974], BS[974], nil, true)  -- Earth Shield
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Tank missing Earth Shield"], report.earthshieldlist, nil, RaidBuffStatus.BF.earthshield:buffers(), nil, nil, nil, nil, nil, nil, report.tanksgotearthshield)
		end,
		singlebuff = true,
		partybuff = false,
		raidbuff = false,
		whispertobuff = function(reportl, prefix)
			local theshamans = RaidBuffStatus.BF.earthshield:buffers()
			for _,name in pairs(theshamans) do
				RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.earthshield.chat .. ">: " .. table.concat(reportl, ", "), name)
			end
		end,
		buffers = function()
			local theshamans = {}
			for name,rcn in pairs(raid.classes.SHAMAN) do
				if rcn.specialisations.earthshield then
					table.insert(theshamans, name)
				end
			end
			return theshamans
		end,
	},

	focusmagic = {
		order = 874,
		list = "focusmagiclist",
		check = "checkfocusmagic",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		class = { MAGE = true, },
		chat = function(report, raid, prefix, channel)
			prefix = prefix or ""
			if report.checking.focusmagic then
				if # report.focusmagiclist > 0 then
					RaidBuffStatus:Say(prefix .. "<" .. L["Missing "] .. BS[54646] .. ">: " .. #report.focusmagiclist, nil, nil, channel)  -- Focus Magic
				end
			end
		end,
		pre = function(self, raid, report)
			report.peoplegotfocusmagic = {}
			report.magewithfocusmagic = {}
		end,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.MAGE < 1 then
				return
			end
			if class == "MAGE" then
				if raid.classes.MAGE[name].specialisations.focusmagic then
					report.checking.focusmagic = true
					table.insert(report.magewithfocusmagic, name)
				end
			end
			if unit.hasbuff[BS[54646]] then  -- Focus Magic
				table.insert(report.peoplegotfocusmagic, name)
			end  -- todo make it not allow non-magics to have it
		end,
		post = function(self, raid, report)
			local numbermissing = #report.magewithfocusmagic - #report.peoplegotfocusmagic
			for _ = 1, numbermissing do
				table.insert(report.focusmagiclist, "raid")
			end
		end,
		icon = BSI[54646], -- Focus Magic
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.focusmagiclist, RaidBuffStatus.db.profile.checkfocusmagic, report.checking.focusmagic or false, RaidBuffStatus.BF.focusmagic:buffers())
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "focusmagic", nil, nil, nil, true)
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. BS[54646] .. ": " .. #report.focusmagiclist, nil, nil, RaidBuffStatus.BF.focusmagic:buffers(), nil, nil, nil, nil, nil, nil, report.peoplegotfocusmagic)
		end,
		singlebuff = true,
		partybuff = false,
		raidbuff = false,
		whispertobuff = function(reportl, prefix)
			prefix = prefix or ""
			local themages = RaidBuffStatus.BF.focusmagic:buffers()
			for _,name in pairs(themages) do
				if RaidBuffStatus.db.profile.WhisperMany and #reportl >= RaidBuffStatus.db.profile.HowMany then
					RaidBuffStatus:Say(prefix .. "<" .. L["Missing "] .. BS[54646] .. ">: " .. L["MANY!"], name)
				else
					RaidBuffStatus:Say(prefix .. "<" .. L["Missing "] .. BS[54646] .. ">: " .. table.concat(reportl, ", "), name)
				end
			end
		end,
		buffers = function()
			local themages = {}
			for name,rcn in pairs(raid.classes.MAGE) do
				if rcn.specialisations.focusmagic then
					table.insert(themages, name)
				end
			end
			return themages
		end,
	},

	vigilance = {
		order = 870,
		list = "vigilancelist",
		check = "checkvigilance",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = false,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		chat = BS[50725],  -- Vigilance
		main = function(self, name, class, unit, raid, report)
			if # raid.VigilanceTalent < 1 then
				return
			end
			if not unit.istank then
				return  -- only tanks need not Vigilance
			end
			if class == "PALADIN" or class == "DRUID" or class == "WARRIOR" or class == "MAGE" or class == "WARLOCK" or class == "DEATHKNIGHT" then  -- only tanks
				report.checking.vigilance = true
				if unit.hasbuff[BS[50725]] then  -- vigilance
					table.insert(report.vigilancelist, name)
				end
			end
		end,
		post = nil,
		icon = BSI[50725],  -- vigilance
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.vigilancelist, RaidBuffStatus.db.profile.checkvigilance, report.checking.vigilance or false, nil)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "vigilance")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Tank with "] .. BS[50725], report.vigilancelist)
		end,
		partybuff = nil,
	},


	soulstone = {
		order = 860,
		list = "nosoulstonelist",
		check = "checksoulstone",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = true,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = true,
		selfbuff = false,
		timer = false,
		class = { WARLOCK = true, },
		chat = function(report, raid, prefix, channel)
			prefix = prefix or ""
			if report.checking.soulstone then
				if # report.soulstonelist < 1 then
					RaidBuffStatus:Say(prefix .. "<" .. L["No Soulstone detected"] .. ">", nil, nil, channel)
				end
			end
		end,
		pre = function(self, raid, report)
			report.soulstonelist = {}
		end,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.WARLOCK > 0 then
				report.checking.soulstone = true
				if unit.hasbuff[BS[20707]] then -- Soulstone Resurrection
					table.insert(report.soulstonelist, name)
				end
			end
		end,
		post = function(self, raid, report)
			if # report.soulstonelist < 1 then
				table.insert(report.nosoulstonelist, "raid")
			end
		end,
		icon = "Interface\\Icons\\Spell_Shadow_SoulGem",
		update = function(self)
			if RaidBuffStatus.db.profile.checksoulstone then
				if report.checking.soulstone then
					self:SetAlpha(1)
					if # report.soulstonelist > 0 then
						self.count:SetText("0")
					else
						self.count:SetText("1")
					end
				else
					self:SetAlpha(0.15)
					self.count:SetText("")
				end
			else
				self:SetAlpha(0.5)
				self.count:SetText("X")
			end
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "soulstone")
		end,
		tip = function(self)
			if not report.soulstonelist then  -- fixes error when tip being called from option window when not in a party/raid
				RaidBuffStatus:Tooltip(self, L["Someone has a Soulstone or not"])
			else
				if #report.soulstonelist < 1 then
					RaidBuffStatus:Tooltip(self, L["Someone has a Soulstone or not"], {L["No Soulstone detected"]}, nil, RaidBuffStatus.BF.soulstone:buffers(), nil, nil, nil, nil, nil, nil, report.soulstonelist)
				else
					RaidBuffStatus:Tooltip(self, L["Someone has a Soulstone or not"], nil, nil, RaidBuffStatus.BF.soulstone:buffers(), nil, nil, nil, nil, nil, nil, report.soulstonelist)
				end
			end
		end,
		partybuff = nil,
		whispertobuff = function(reportl, prefix)
			local thelocks = RaidBuffStatus.BF.soulstone:buffers()
			for _,name in pairs(thelocks) do
				RaidBuffStatus:Say(prefix .. "<" .. L["No Soulstone detected"] .. ">", name)
			end
		end,
		buffers = function()
			local thelocks = {}
			for name,_ in pairs(raid.classes.WARLOCK) do
				table.insert(thelocks, name)
			end
			return thelocks
		end,
	},

	healthstone = {
		order = 850,
		list = "healthstonelist",
		check = "checkhealthstone",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = false,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		chat = BS[5720], -- Healthstone
		pre = function(self, raid, report)
			if raid.ClassNumbers.WARLOCK < 1 or not oRA or not raid.israid or raid.isbattle then
				return
			end
			if not RaidBuffStatus.itemcheck.healthstone then
				RaidBuffStatus.itemcheck.healthstone = {}
				RaidBuffStatus.itemcheck.healthstone.results = {}
				RaidBuffStatus.itemcheck.healthstone.list = "healthstonelist"
				RaidBuffStatus.itemcheck.healthstone.check = "healthstone"
				RaidBuffStatus.itemcheck.healthstone.next = 0
				RaidBuffStatus.itemcheck.healthstone.item = ITN[36894] -- Fel Healthstone
				RaidBuffStatus.itemcheck.healthstone.min = 1
				RaidBuffStatus.itemcheck.healthstone.frequency = 60 * 3
				RaidBuffStatus.itemcheck.healthstone.frequencymissing = 30
--				RaidBuffStatus:Debug("RaidBuffStatus.itemcheck.healthstone.item = " .. RaidBuffStatus.itemcheck.healthstone.item)
			end
			report.healthstonelistunknown = {}
		end,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.WARLOCK < 1 or not oRA or not raid.israid or raid.isbattle then
				return
			end
			report.checking.healthstone = true
			local stones = RaidBuffStatus.itemcheck.healthstone.results[name]
			if stones == nil then
				table.insert(report.healthstonelistunknown, name)
			elseif stones < RaidBuffStatus.itemcheck.healthstone.min then
				table.insert(report.healthstonelist, name)
			end
		end,
		icon = BSI[5720], -- Healthstone
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.healthstonelist, RaidBuffStatus.db.profile.checkhealthstone, report.checking.healthstone or false, RaidBuffStatus.BF.healthstone:buffers())
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "healthstone")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. BS[5720], report.healthstonelist, nil, RaidBuffStatus.BF.healthstone:buffers(), nil, nil, nil, report.healthstonelistunknown) -- Healthstone
		end,
		partybuff = nil,
		whispertobuff = function(reportl, prefix)
			local thelocks = RaidBuffStatus.BF.healthstone:buffers()
			for _,name in pairs(thelocks) do
				if RaidBuffStatus.db.profile.WhisperMany and #reportl >= RaidBuffStatus.db.profile.HowMany then
					RaidBuffStatus:Say(prefix .. "<" .. L["Missing "] .. BS[5720] .. ">: " .. L["MANY!"], name)
				else
					RaidBuffStatus:Say(prefix .. "<" .. L["Missing "] .. BS[5720] .. ">: " .. table.concat(reportl, ", "), name)
				end
			end
		end,
		buffers = function()
			local thelocks = {}
			local maxpoints = 0
			for name,rcn in pairs(raid.classes.WARLOCK) do
				local points = GT:GUIDHasTalent(rcn.guid, BS[18692]) or 0 -- Improved Healthstone talent
				if points > maxpoints then
					maxpoints = points
					thelocks = {}
					table.insert(thelocks, name)
				elseif points == maxpoints then
					table.insert(thelocks, name)
				end
			end
			return thelocks
		end,
	},


	hunterammo = {
		order = 840,
		list = "hunterammolist",
		check = "checkhunterammo",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		chat = ITN[41164] .. "/" .. ITN[41165] .. "/" .. ITN[52020] .. "/" .. ITN[52021],  -- Mammoth Cutters + Saronite Razorheads + Shatter Rounds + Iceblade Arrow
		pre = function(self, raid, report)
			if raid.ClassNumbers.HUNTER < 1 or not oRA or not raid.israid or raid.isbattle then
				return
			end
			if not RaidBuffStatus.itemcheck.hunterammo1 then
				RaidBuffStatus.itemcheck.hunterammo1 = {}
				RaidBuffStatus.itemcheck.hunterammo1.results = {}
				RaidBuffStatus.itemcheck.hunterammo1.list = "hunterammolist"
				RaidBuffStatus.itemcheck.hunterammo1.check = "hunterammo"
				RaidBuffStatus.itemcheck.hunterammo1.next = 0
				RaidBuffStatus.itemcheck.hunterammo1.item = "41164" -- Mammoth Cutters
				RaidBuffStatus.itemcheck.hunterammo1.min = 1
				RaidBuffStatus.itemcheck.hunterammo1.frequency = 60 * 10
				RaidBuffStatus.itemcheck.hunterammo1.frequencymissing = 60 * 3
--				RaidBuffStatus:Debug("RaidBuffStatus.itemcheck.hunterammo1.item = " .. RaidBuffStatus.itemcheck.hunterammo1.item)
			end
			if not RaidBuffStatus.itemcheck.hunterammo2 then
				RaidBuffStatus.itemcheck.hunterammo2 = {}
				RaidBuffStatus.itemcheck.hunterammo2.results = {}
				RaidBuffStatus.itemcheck.hunterammo2.list = RaidBuffStatus.itemcheck.hunterammo1.list
				RaidBuffStatus.itemcheck.hunterammo2.check = RaidBuffStatus.itemcheck.hunterammo1.check
				RaidBuffStatus.itemcheck.hunterammo2.next = RaidBuffStatus.itemcheck.hunterammo1.next
				RaidBuffStatus.itemcheck.hunterammo2.item = "41165" -- Saronite Razorheads
				RaidBuffStatus.itemcheck.hunterammo2.min = RaidBuffStatus.itemcheck.hunterammo1.min
				RaidBuffStatus.itemcheck.hunterammo2.frequency = RaidBuffStatus.itemcheck.hunterammo1.frequency
				RaidBuffStatus.itemcheck.hunterammo2.frequencymissing = RaidBuffStatus.itemcheck.hunterammo1.frequencymissing
			end
			if not RaidBuffStatus.itemcheck.hunterammo3 then
				RaidBuffStatus.itemcheck.hunterammo3 = {}
				RaidBuffStatus.itemcheck.hunterammo3.results = {}
				RaidBuffStatus.itemcheck.hunterammo3.list = RaidBuffStatus.itemcheck.hunterammo1.list
				RaidBuffStatus.itemcheck.hunterammo3.check = RaidBuffStatus.itemcheck.hunterammo1.check
				RaidBuffStatus.itemcheck.hunterammo3.next = RaidBuffStatus.itemcheck.hunterammo1.next
				RaidBuffStatus.itemcheck.hunterammo3.item = "52020" -- Shatter Rounds
				RaidBuffStatus.itemcheck.hunterammo3.min = RaidBuffStatus.itemcheck.hunterammo1.min
				RaidBuffStatus.itemcheck.hunterammo3.frequency = RaidBuffStatus.itemcheck.hunterammo1.frequency
				RaidBuffStatus.itemcheck.hunterammo3.frequencymissing = RaidBuffStatus.itemcheck.hunterammo1.frequencymissing
			end
			if not RaidBuffStatus.itemcheck.hunterammo4 then
				RaidBuffStatus.itemcheck.hunterammo4 = {}
				RaidBuffStatus.itemcheck.hunterammo4.results = {}
				RaidBuffStatus.itemcheck.hunterammo4.list = RaidBuffStatus.itemcheck.hunterammo1.list
				RaidBuffStatus.itemcheck.hunterammo4.check = RaidBuffStatus.itemcheck.hunterammo1.check
				RaidBuffStatus.itemcheck.hunterammo4.next = RaidBuffStatus.itemcheck.hunterammo1.next
				RaidBuffStatus.itemcheck.hunterammo4.item = "52021" -- Iceblade Arrow
				RaidBuffStatus.itemcheck.hunterammo4.min = RaidBuffStatus.itemcheck.hunterammo1.min
				RaidBuffStatus.itemcheck.hunterammo4.frequency = RaidBuffStatus.itemcheck.hunterammo1.frequency
				RaidBuffStatus.itemcheck.hunterammo4.frequencymissing = RaidBuffStatus.itemcheck.hunterammo1.frequencymissing
			end
			report.hunterammolistunknown = {}
			report.hunterammolistcount = {}
		end,
		main = function(self, name, class, unit, raid, report)
			if class ~= "HUNTER" or not oRA or not raid.israid or raid.isbattle then
				return
			end
			report.checking.hunterammo = true
			local items1 = RaidBuffStatus.itemcheck.hunterammo1.results[name]
			local items2 = RaidBuffStatus.itemcheck.hunterammo2.results[name]
			local items3 = RaidBuffStatus.itemcheck.hunterammo3.results[name]
			local items4 = RaidBuffStatus.itemcheck.hunterammo4.results[name]
			if items1 == nil and items2 == nil and items3 == nil and items4 == nil then
				table.insert(report.hunterammolistunknown, name)
			else
				if items1 == nil then
					items1 = 0
				end
				if items2 == nil then
					items2 = 0
				end
				if items3 == nil then
					items3 = 0
				end
				if items4 == nil then
					items4 = 0
				end
				if items1 < RaidBuffStatus.itemcheck.hunterammo1.min and items2 < RaidBuffStatus.itemcheck.hunterammo2.min and items3 < RaidBuffStatus.itemcheck.hunterammo3.min and items4 < RaidBuffStatus.itemcheck.hunterammo4.min then
					table.insert(report.hunterammolist, name)
				end
				table.insert(report.hunterammolistcount, name .. "[" .. items1 .. "/" .. items2 .. "/" .. items3 .. "/" .. items4 .. "]")
			end
		end,
		icon = BSI[60879], -- Create Mammoth Cutters
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.hunterammolist, RaidBuffStatus.db.profile.checkhunterammo, report.checking.hunterammo or false, report.hunterammolist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "hunterammo")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. ITN[41164] .. "/" .. ITN[41165] .. "/" .. ITN[52020] .. "/" .. ITN[52021], report.hunterammolist, nil, nil, nil, nil, report.hunterammolistcount, report.hunterammolistunknown)  -- Mammoth Cutters + Saronite Razorheads + Shatter Rounds + Iceblade Arrow
		end,
		partybuff = nil,
	},

	lockshards = {
		order = 830,
		list = "lockshardslist",
		check = "checklockshards",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		chat = ITN[6265], -- Soul Shard
		pre = function(self, raid, report)
			if raid.ClassNumbers.WARLOCK < 1 or not oRA or not raid.israid or raid.isbattle then
				return
			end
			if not RaidBuffStatus.itemcheck.lockshards then
				RaidBuffStatus.itemcheck.lockshards = {}
				RaidBuffStatus.itemcheck.lockshards.results = {}
				RaidBuffStatus.itemcheck.lockshards.list = "lockshardslist"
				RaidBuffStatus.itemcheck.lockshards.check = "lockshards"
				RaidBuffStatus.itemcheck.lockshards.next = 0
				RaidBuffStatus.itemcheck.lockshards.item = "6265" -- Soul Shard
				RaidBuffStatus.itemcheck.lockshards.min = 1
				RaidBuffStatus.itemcheck.lockshards.frequency = 60 * 10
				RaidBuffStatus.itemcheck.lockshards.frequencymissing = 60 * 3
--				RaidBuffStatus:Debug("RaidBuffStatus.itemcheck.lockshards.item = " .. RaidBuffStatus.itemcheck.lockshards.item)
			end
			report.lockshardslistunknown = {}
			report.lockshardslistcount = {}
		end,
		main = function(self, name, class, unit, raid, report)
			if class ~= "WARLOCK" or not oRA or not raid.israid or raid.isbattle then
				return
			end
			report.checking.lockshards = true
			local items = RaidBuffStatus.itemcheck.lockshards.results[name]
			if items == nil then
				table.insert(report.lockshardslistunknown, name)
			else
				if items < RaidBuffStatus.itemcheck.lockshards.min then
					table.insert(report.lockshardslist, name)
				end
				table.insert(report.lockshardslistcount, name .. "[" .. items .. "]")
			end
		end,
		icon = ITT[6265], -- Soul Shard
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.lockshardslist, RaidBuffStatus.db.profile.checklockshards, report.checking.lockshards or false, report.lockshardslist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "lockshards")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. ITN[6265], report.lockshardslist, nil, nil, nil, nil, report.lockshardslistcount, report.lockshardslistunknown) -- Soul Shard
		end,
		partybuff = nil,
	},

	food = {
		order = 500,
		list = "foodlist",
		check = "checkfood",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		core = true,
		class = { WARRIOR = true, ROGUE = true, PRIEST = true, DRUID = true, PALADIN = true, HUNTER = true, MAGE = true, WARLOCK = true, SHAMAN = true, DEATHKNIGHT = true, },
		chat = BS[35272], -- Well Fed
		main = function(self, name, class, unit, raid, report)
			local missingbuff = true
			if RaidBuffStatus.db.profile.GoodFoodOnly then
				if unit.hasbuff["foodz"] then
					if unit.hasbuff["foodz"]:find(L["Stamina increased by 40"]) then
						missingbuff = false
					end
				end
			else
				for _, v in ipairs(foods) do
					if unit.hasbuff[v] then
						missingbuff = false
						break
					end
				end
			end
			if missingbuff then
				table.insert(report.foodlist, name)
			end
		end,
		post = nil,
		icon = "Interface\\Icons\\INV_Misc_Food_74",
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.foodlist, RaidBuffStatus.db.profile.checkfood, true, report.foodlist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "food")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Not Well Fed"], report.foodlist)
		end,
		partybuff = nil,
	},
	scroll = {
		order = 495,
		list = "scrolllist",
		check = "checkscroll",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		chat = L["Scroll"],
		pre = function(self, raid, report)
			report.suggestedscroll = {}
			local mb = report.suggestedscroll
			mb.WARRIOR = {}
			mb.WARRIOR.All = {}
			mb.WARRIOR[L["Protection"]] = {}

			mb.WARLOCK = {}
			mb.WARLOCK.All = {}

			mb.SHAMAN = {}
			mb.SHAMAN.All = {}

			mb.ROGUE = {}
			mb.ROGUE.All = {}

			mb.PRIEST = {}
			mb.PRIEST.All = {}

			mb.PALADIN = {}
			mb.PALADIN.All = {}
			mb.PALADIN[L["Holy"]] = {}
			mb.PALADIN[L["Protection"]] = {}
			mb.PALADIN[L["Retribution"]] = {}

			mb.MAGE = {}
			mb.MAGE.All = {}

			mb.HUNTER = {}
			mb.HUNTER.All = {}

			mb.DRUID = {}
			mb.DRUID.All = {}
			mb.DRUID[L["Balance"]] = {}
			mb.DRUID[L["Feral Combat"]] = {}
			mb.DRUID[L["Restoration"]] = {}

			mb.DEATHKNIGHT = {}
			mb.DEATHKNIGHT.All = {}
			mb.DEATHKNIGHT[L["Frost"]] = {}

			if raid.ClassNumbers.WARLOCK < 1 and raid.ClassNumbers.MAGE < 1 then
				table.insert(mb.SHAMAN.All, scrollofintellect)
				table.insert(mb.PRIEST.All, scrollofintellect)
				table.insert(mb.PALADIN.All, scrollofintellect)
				table.insert(mb.PALADIN[L["Holy"]], scrollofintellect)
				table.insert(mb.PALADIN[L["Retribution"]], scrollofintellect)
				table.insert(mb.HUNTER.All, scrollofintellect)
				table.insert(mb.DRUID[L["Restoration"]], scrollofintellect)
				table.insert(mb.DRUID[L["Balance"]], scrollofintellect)
			end

			if raid.ClassNumbers.DRUID < 1 and raid.ClassNumbers.PALADIN < 1 then
				table.insert(mb.WARRIOR.All, scrollofprotection)
			end
			if raid.ClassNumbers.SHAMAN < 1 and raid.ClassNumbers.DEATHKNIGHT < 1 then
				table.insert(mb.WARRIOR.All, scrollofstrength)
				table.insert(mb.ROGUE.All, scrollofstrength)
				table.insert(mb.PALADIN[L["Protection"]], scrollofstrength)
				table.insert(mb.PALADIN[L["Retribution"]], scrollofstrength)
				table.insert(mb.HUNTER.All, scrollofstrength)
				table.insert(mb.DRUID[L["Feral Combat"]], scrollofstrength)
				table.insert(mb.WARRIOR.All, scrollofagility)
				table.insert(mb.ROGUE.All, scrollofagility)
				table.insert(mb.PALADIN[L["Protection"]], scrollofagility)
				table.insert(mb.PALADIN[L["Retribution"]], scrollofagility)
				table.insert(mb.HUNTER.All, scrollofagility)
				table.insert(mb.DRUID[L["Feral Combat"]], scrollofagility)
			end

			if raid.ClassNumbers.PRIEST < 1 and raid.ClassNumbers.WARLOCK < 1 then
				table.insert(mb.PRIEST.All, scrollofspirit)
				table.insert(mb.MAGE.All, scrollofspirit)
				table.insert(mb.DRUID[L["Restoration"]], scrollofspirit)
				table.insert(mb.DRUID[L["Balance"]], scrollofspirit)
			end
		end,
		main = function(self, name, class, unit, raid, report)
			local mb = report.suggestedscroll
			local scrollslist = mb[class].All
			if raid.classes[class][name].talents then
				local spec = raid.classes[class][name].spec
				if mb[class][spec] then
					scrollslist = mb[class][spec]
				end
			end
			if #scrollslist < 1 then
				return
			end
			report.checking.scroll = true
			local missinglist = {}
			for _, sc in ipairs(scrollslist) do
				for _, v in ipairs(sc) do
					if unit.hasbuff[v] then
						return
					end
				end
				if RaidBuffStatus.db.profile.ShortMissingBlessing then
					table.insert(missinglist, sc.shortname)
				else
					table.insert(missinglist, sc.name)
				end
			end
			table.insert(report.scrolllist, name .. "(" .. table.concat(missinglist, ", ") .. ")")
		end,
		post = nil,
		icon = "Interface\\Icons\\INV_Scroll_02",
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.scrolllist, RaidBuffStatus.db.profile.checkscroll, true, report.scrolllist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "scroll")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing a scroll"], report.scrolllist)
		end,
		partybuff = nil,
	},
	flask = {
		order = 490,
		list = "flasklist",
		check = "checkflaskir",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		core = true,
		class = { WARRIOR = true, ROGUE = true, PRIEST = true, DRUID = true, PALADIN = true, HUNTER = true, MAGE = true, WARLOCK = true, SHAMAN = true, DEATHKNIGHT = true, },
		chat = L["Flask or two Elixirs"],
		pre = function(self, raid, report)
			report.belixirlist = {}
			report.gelixirlist = {}
			report.flaskzonelist = {}
		end,
		main = function(self, name, class, unit, raid, report)
			report.checking.flaskir = true
			local cflasks = wotlkflasks
			local cbelixirs = wotlkbelixirs
			local cgelixirs = wotlkgelixirs
			if RaidBuffStatus.db.profile.TBCFlasksElixirs then
				cflasks = allflasks
				cbelixirs = allbelixirs
				cgelixirs = allgelixirs
			elseif RaidBuffStatus.db.profile.GoodTBC then
				cflasks = wotlkgoodtbcflasks
				cbelixirs = wotlkgoodtbcbelixirs
				cgelixirs = wotlkgoodtbcgelixirs
			end
			local missingbuff = true
			for _, v in ipairs(cflasks) do
				if unit.hasbuff[v] then
					missingbuff = false
					-- has flask now check the zone
					if raid.israid then
						local thiszone = GetRealZoneText()
						local flaskmatched = false
						for _, types in pairs (flaskzones) do
							for _, flask in ipairs(types.flasks) do
								if flask == v then
									flaskmatched = true
									local zonematched = false
									for _, zone in ipairs(types.zones) do
										if thiszone == zone then
											zonematched = true
											break
										end
									end
									if not zonematched then
										table.insert(report.flaskzonelist, name .. "(" .. v .. ")")
									end
								break
								end
							end
							if flaskmatched then break end
						end
					end
					break
				end
			end
			if missingbuff then
				local numbbelixir = 0
				local numbgelixir = 0
				for _, v in ipairs(cbelixirs) do
					if unit.hasbuff[v] then
						numbbelixir = 1
						break
					end
				end
				for _, v in ipairs(cgelixirs) do
					if unit.hasbuff[v] then
						numbgelixir = 1
						break
					end
				end
				local totalelixir = numbbelixir + numbgelixir
				if totalelixir == 0 then
					table.insert(report.flasklist, name) -- no flask or elixir
				elseif totalelixir == 1 then
					if numbbelixir == 0 then
						table.insert(report.belixirlist, name)
					else
						table.insert(report.gelixirlist, name)
					end
				end
			end
		end,
		post = nil,
		icon = "Interface\\Icons\\INV_Potion_119",
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.flasklist, RaidBuffStatus.db.profile.checkflaskir, true, report.flasklist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "flask")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing a Flask or two Elixirs"], report.flasklist)
		end,
		partybuff = nil,
	},
	belixir = {
		order = 480,
		list = "belixirlist",
		check = "checkflaskir",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		core = true,
		class = { WARRIOR = true, ROGUE = true, PRIEST = true, DRUID = true, PALADIN = true, HUNTER = true, MAGE = true, WARLOCK = true, SHAMAN = true, DEATHKNIGHT = true, },
		chat = L["Battle Elixir"],
		pre = nil,
		main = nil,
		post = nil,
		icon = "Interface\\Icons\\INV_Potion_111",
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.belixirlist, RaidBuffStatus.db.profile.checkflaskir, true, report.belixirlist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "flask")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing a Battle Elixir"], report.belixirlist)
		end,
		partybuff = nil,
	},
	
	gelixir = {
		order = 470,
		list = "gelixirlist",
		check = "checkflaskir",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		core = true,
		class = { WARRIOR = true, ROGUE = true, PRIEST = true, DRUID = true, PALADIN = true, HUNTER = true, MAGE = true, WARLOCK = true, SHAMAN = true, DEATHKNIGHT = true, },
		chat = L["Guardian Elixir"],
		pre = nil,
		main = nil,
		post = nil,
		icon = "Interface\\Icons\\INV_Potion_158",
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.gelixirlist, RaidBuffStatus.db.profile.checkflaskir, true, report.gelixirlist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "flask")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing a Guardian Elixir"], report.gelixirlist)
		end,
		partybuff = nil,
	},

	flaskzone = {
		order = 465,
		list = "flaskzonelist",
		check = "checkflaskzone",
		default = false,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = false,
		defaultdashcombat = false,
		defaultboss = false,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		chat = L["Wrong flask for this zone"],
		pre = nil,
		main = nil,
		post = nil,
		icon = "Interface\\Icons\\INV_Potion_35",
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.flaskzonelist, RaidBuffStatus.db.profile.flaskzone, report.checking.flaskir or false, report.flaskzonelist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "flaskzone")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Wrong flask for this zone"], report.flaskzonelist)
		end,
		partybuff = nil,
	},
	wepbuff = {
		order = 464,
		list = "wepbufflist",
		check = "checkwepbuff",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { ROGUE = true, WARLOCK = true, SHAMAN = true, },
		chat = L["Weapon buff"],
		pre = nil,
		main = function(self, name, class, unit, raid, report)
			local bufflist = false
			local dualw = false
			if class == "WARLOCK" then
				bufflist = lockwepbuffs
			elseif class == "SHAMAN" then
				bufflist = shamanwepbuffs
				if raid.classes.SHAMAN[name].specialisations.dualwield then
					dualw = true
				end
			elseif class == "ROGUE" then
				bufflist = roguewepbuffs
				dualw = true
			else
				return
			end
			if _G.InspectFrame and _G.InspectFrame:IsShown() then
				return -- can't inspect at same time as UI
			end
--			if RaidBuffStatus.inspectqueuename ~= "" then
--				return  -- can't inspect as someone in the queue
--			end
			if not CanInspect(unit.unitid) then
				return
			end
			report.checking.wepbuff = true
			local missingbuffmh = true
			local missingbuffoh = true
			RBSToolScanner:ClearLines()
			RBSToolScanner:SetInventoryItem(unit.unitid, 16)
			if RBSToolScanner:NumLines() < 1 then
				if not UnitIsUnit(unit.unitid, "player") then
--					RaidBuffStatus:Debug("having to call notifyinspect for:" .. unit.unitid)
					NotifyInspect(unit.unitid)
				else
					RaidBuffStatus:Debug("skipping call notifyinspect for:" .. unit.unitid)
				end
				RBSToolScanner:ClearLines()
				RBSToolScanner:SetInventoryItem(unit.unitid, 16)
			end
			for _,buff in ipairs(bufflist) do
				if RBSToolScanner:Find(buff) then
					missingbuffmh = false
					break
				end
			end
			if dualw then
				RBSToolScanner:ClearLines()
				RBSToolScanner:SetInventoryItem(unit.unitid, 17)
				if RBSToolScanner:NumLines() > 1 then
					for _,buff in ipairs(bufflist) do
						if RBSToolScanner:Find(buff) then
							missingbuffoh = false
							break
						end
					end
				else
					missingbuffoh = false -- nothing equipped
				end
			end
			if dualw then
				if missingbuffmh or missingbuffoh then
					table.insert(report.wepbufflist, name)
				end
			else
				if missingbuffmh then
					table.insert(report.wepbufflist, name)
				end
			end
		end,
		post = nil,
		icon = "Interface\\Icons\\INV_Potion_101",
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.wepbufflist, RaidBuffStatus.db.profile.checkwepbuff, report.checking.wepbuff or false, report.wepbufflist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "wepbuff")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing a temporary weapon buff"], report.wepbufflist)
		end,
		partybuff = nil,
	},

	spirit = {
		order = 460,
		list = "spiritlist",
		check = "checkspirit",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		core = true,
		class = { PRIEST = true, },
		chat = BS[14752], -- Divine Spirit
		pre = nil,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.PRIEST > 0 then
				report.checking.spirit = true
				if class ~= "ROGUE" and class ~= "WARRIOR" and class ~= "DEATHKNIGHT" then
					local missingbuff = true
					for _, v in ipairs(spirit) do
						if unit.hasbuff[v] then
							missingbuff = false
							break
						end
					end
					if missingbuff then
						if RaidBuffStatus.db.profile.ShowGroupNumber then
							table.insert(report.spiritlist, name .. "(" .. unit.group .. ")" )
						else
							table.insert(report.spiritlist, name)
						end
					end
				end
			end
		end,
		post = function(self, raid, report)
			RaidBuffStatus:SortNameBySuffix(report.spiritlist)
		end,
		icon = BSI[14752], -- Divine Spirit
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.spiritlist, RaidBuffStatus.db.profile.checkspirit, report.checking.spirit or false, RaidBuffStatus.BF.spirit:buffers())
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "spirit", BS[14752], BS[27681], GetItemInfo(44615), true) -- Divine Spirit and Prayer of Spirit + Devout Candle
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. BS[14752], report.spiritlist, nil, RaidBuffStatus.BF.spirit:buffers()) -- Divine Spirit
		end,
		singlebuff = false,
		partybuff = false,
		raidbuff = true,
		whispertobuff = function(reportl, prefix)
			local thepriests = RaidBuffStatus.BF.spirit:buffers()
			for _,name in ipairs(thepriests) do
				if RaidBuffStatus.db.profile.WhisperMany and #reportl >= RaidBuffStatus.db.profile.HowMany then
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.spirit.chat .. ">: " .. L["MANY!"], name)
				else
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.spirit.chat .. ">: " .. table.concat(reportl, ", "), name)
				end
			end
		end,
		buffers = function()
			local thepriests = {}
			for name,_ in pairs(raid.classes.PRIEST) do
				table.insert(thepriests, name)
			end
			return thepriests
		end,
	},

	intellect = {
		order = 450,
		list = "intellectlist",
		check = "checkintellect",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		core = true,
		class = { MAGE = true, },
		chat = BS[1459], -- Arcane Intellect
		pre = nil,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.MAGE > 0 then
				report.checking.intellect = true
				if class ~= "ROGUE" and class ~= "WARRIOR" and class ~= "DEATHKNIGHT" then
					local missingbuff = true
					for _, v in ipairs(intellect) do
						if unit.hasbuff[v] then
							missingbuff = false
							break
						end
					end
					if missingbuff then
						if RaidBuffStatus.db.profile.ShowGroupNumber then
							table.insert(report.intellectlist, name .. "(" .. unit.group .. ")" )
						else
							table.insert(report.intellectlist, name)
						end
					end
				end
			end
		end,
		post = function(self, raid, report)
			RaidBuffStatus:SortNameBySuffix(report.intellectlist)
		end,
		icon = BSI[1459], -- Arcane Intellect
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.intellectlist, RaidBuffStatus.db.profile.checkintellect, report.checking.intellect or false, RaidBuffStatus.BF.intellect:buffers())
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "intellect", BS[1459], BS[23028], GetItemInfo(17020), true) -- Arcane Intellect and Arcane Brilliance + Arcane Powder
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. BS[1459], report.intellectlist, nil, RaidBuffStatus.BF.intellect:buffers())
		end,
		singlebuff = false,
		partybuff = false,
		raidbuff = true,
		whispertobuff = function(reportl, prefix)
			for name,_ in pairs(raid.classes.MAGE) do
				if RaidBuffStatus.db.profile.WhisperMany and #reportl >= RaidBuffStatus.db.profile.HowMany then
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.intellect.chat .. ">: " .. L["MANY!"], name)
				else
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.intellect.chat .. ">: " .. table.concat(reportl, ", "), name)
				end
			end
		end,
		buffers = function()
			local themages = {}
			for name,_ in pairs(raid.classes.MAGE) do
				table.insert(themages, name)
			end
			return themages
		end,
	},

	wild = {
		order = 440,
		list = "wildlist",
		check = "checkwild",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		core = true,
		class = { DRUID = true, },
		chat = BS[1126], -- Mark of the Wild
		pre = nil,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.DRUID > 0 then
				report.checking.wild = true
				local missingbuff = true
				for _, v in ipairs(wild) do
					if unit.hasbuff[v] then
						missingbuff = false
						break
					end
				end
				if missingbuff then
					if RaidBuffStatus.db.profile.ShowGroupNumber then
						table.insert(report.wildlist, name .. "(" .. unit.group .. ")" )
					else
						table.insert(report.wildlist, name)
					end
				end
			end
		end,
		post = function(self, raid, report)
			RaidBuffStatus:SortNameBySuffix(report.wildlist)
		end,
		icon = BSI[1126], -- Mark of the Wild
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.wildlist, RaidBuffStatus.db.profile.checkwild, report.checking.wild or false, RaidBuffStatus.BF.wild:buffers())
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "wild", BS[1126], BS[21849], GetItemInfo(44605), true) -- Mark of the Wild and Gift of the Wild + Wild Spineleaf
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. BS[1126], report.wildlist, nil, RaidBuffStatus.BF.wild:buffers())
		end,
		singlebuff = false,
		partybuff = false,
		raidbuff = true,
		whispertobuff = function(reportl, prefix)
			local thedruids = RaidBuffStatus.BF.wild:buffers()
			for _,name in ipairs(thedruids) do
				if RaidBuffStatus.db.profile.WhisperMany and #reportl >= RaidBuffStatus.db.profile.HowMany then
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.wild.chat .. ">: " .. L["MANY!"], name)
				else
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.wild.chat .. ">: " .. table.concat(reportl, ", "), name)
				end
			end
		end,
		buffers = function()
			local thedruids = {}
			local maxpoints = 0
			for name,rcn in pairs(raid.classes.DRUID) do
				local points = GT:GUIDHasTalent(rcn.guid, BS[17050]) or 0 -- Improved Mark of the Wild
				if points > maxpoints then
					maxpoints = points
					thedruids = {}
					table.insert(thedruids, name)
				elseif points == maxpoints then
					table.insert(thedruids, name)
				end
			end
			return thedruids
		end,
	},
	
	drumswild = {
		order = 435,
		list = "drumswildlist",
		check = "checkdrumswild",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		chat = BS[69381], -- Gift of the Wild
		pre = function(self, raid, report)
			if raid.ClassNumbers.DRUID > 0 or not oRA or not raid.israid or raid.isbattle then
				return
			end
			if not RaidBuffStatus.itemcheck.drumswild then
				RaidBuffStatus.itemcheck.drumswild = {}
				RaidBuffStatus.itemcheck.drumswild.results = {}
				RaidBuffStatus.itemcheck.drumswild.list = "drumswildlist"
				RaidBuffStatus.itemcheck.drumswild.check = "drumswild"
				RaidBuffStatus.itemcheck.drumswild.next = 0
				RaidBuffStatus.itemcheck.drumswild.item = "49634" -- Drums of the Wild
				RaidBuffStatus.itemcheck.drumswild.min = 0
				RaidBuffStatus.itemcheck.drumswild.frequency = 60 * 5
				RaidBuffStatus.itemcheck.drumswild.frequencymissing = 60 * 5
			end
		end,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.DRUID> 0 then
				return
			end
			report.checking.drumswild = true
			if not unit.hasbuff[BS[69381]] then -- Gift of the Wild
				table.insert(report.drumswildlist, name)
			end
		end,
		post = nil,
		icon = ITT[49634], -- Drums of the Wild
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.drumswildlist, RaidBuffStatus.db.profile.checkdrumswild, report.checking.drumswild or false, RaidBuffStatus.BF.drumswild:buffers())
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "drumswild")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. ITN[49634], report.drumswildlist, nil, RaidBuffStatus.BF.drumswild:buffers()) -- Drums of the Wild
		end,
		singlebuff = false,
		partybuff = false,
		raidbuff = true,
		whispertobuff = function(reportl, prefix)
			local thebuffers = RaidBuffStatus.BF.drumswild:buffers()
			for _,name in ipairs(thebuffers) do
				if RaidBuffStatus.db.profile.WhisperMany and #reportl >= RaidBuffStatus.db.profile.HowMany then
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.drumswild.chat .. ">: " .. L["MANY!"], name)
				else
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.drumswild.chat .. ">: " .. table.concat(reportl, ", "), name)
				end
			end
		end,
		buffers = function()
			if not RaidBuffStatus.itemcheck.drumswild then
				return
			end
			local thebuffers = {}
				for _,rc in pairs(raid.classes) do
					for name,_ in pairs(rc) do
						local items = RaidBuffStatus.itemcheck.drumswild.results[name] or 0
						if items > 0 then
							table.insert(thebuffers, name .. "(" .. items .. ")")
						end
					end
				end
			return thebuffers
		end,
	},

	fortitude = {
		order = 430,
		list = "fortitudelist",
		check = "checkfortitude",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		core = true,
		class = { PRIEST = true, },
		chat = BS[1243], -- Power Word: Fortitude
		pre = nil,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.PRIEST > 0 then
				report.checking.fortitude = true
				local missingbuff = true
				for _, v in ipairs(fortitude) do
					if unit.hasbuff[v] then
						missingbuff = false
						break
					end
				end
				if missingbuff then
					if RaidBuffStatus.db.profile.ShowGroupNumber then
						table.insert(report.fortitudelist, name .. "(" .. unit.group .. ")" )
					else
						table.insert(report.fortitudelist, name)
					end
				end
			end
		end,
		post = function(self, raid, report)
			RaidBuffStatus:SortNameBySuffix(report.fortitudelist)
		end,
		icon = BSI[1243], -- Power Word: Fortitude
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.fortitudelist, RaidBuffStatus.db.profile.checkfortitude, report.checking.fortitude or false, RaidBuffStatus.BF.fortitude:buffers())
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "fortitude", BS[1243], BS[21562], GetItemInfo(44615), true) -- Power Word: Fortitude and Prayer of Fortitude + Devout Candle
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. BS[1243], report.fortitudelist, nil, RaidBuffStatus.BF.fortitude:buffers()) -- Power Word: Fortitude
		end,
		singlebuff = false,
		partybuff = false,
		raidbuff = true,
		whispertobuff = function(reportl, prefix)
			local thepriests = RaidBuffStatus.BF.fortitude:buffers()
			for _,name in ipairs(thepriests) do
				if RaidBuffStatus.db.profile.WhisperMany and #reportl >= RaidBuffStatus.db.profile.HowMany then
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.fortitude.chat .. ">: " .. L["MANY!"], name)
				else
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.fortitude.chat .. ">: " .. table.concat(reportl, ", "), name)
				end
			end
		end,
		buffers = function()
			local thepriests = {}
			local maxpoints = 0
			for name,rcn in pairs(raid.classes.PRIEST) do
				local points = GT:GUIDHasTalent(rcn.guid, BS[14749]) or 0 -- Improved Power Word: Fortitude talent
				if points > maxpoints then
					maxpoints = points
					thepriests = {}
					table.insert(thepriests, name)
				elseif points == maxpoints then
					table.insert(thepriests, name)
				end
			end
			return thepriests
		end,
	},

	runescrollfortitude = {
		order = 425,
		list = "runescrollfortitudelist",
		check = "checkrunescrollfortitude",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		chat = BS[69377], -- Fortitude
		pre = function(self, raid, report)
			if raid.ClassNumbers.PRIEST > 0 or not oRA or not raid.israid or raid.isbattle then
				return
			end
			if not RaidBuffStatus.itemcheck.runescrollfortitude then
				RaidBuffStatus.itemcheck.runescrollfortitude = {}
				RaidBuffStatus.itemcheck.runescrollfortitude.results = {}
				RaidBuffStatus.itemcheck.runescrollfortitude.list = "runescrollfortitudelist"
				RaidBuffStatus.itemcheck.runescrollfortitude.check = "runescrollfortitude"
				RaidBuffStatus.itemcheck.runescrollfortitude.next = 0
				RaidBuffStatus.itemcheck.runescrollfortitude.item = "49632" -- Runescroll of Fortitude
				RaidBuffStatus.itemcheck.runescrollfortitude.min = 0
				RaidBuffStatus.itemcheck.runescrollfortitude.frequency = 60 * 5
				RaidBuffStatus.itemcheck.runescrollfortitude.frequencymissing = 60 * 5
			end
		end,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.PRIEST > 0 then
				return
			end
			report.checking.runescrollfortitude = true
			if not unit.hasbuff[BS[69377]] then -- Fortitude
				table.insert(report.runescrollfortitudelist, name)
			end
		end,
		post = nil,
		icon = ITT[49632], -- Runescroll of Fortitude
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.runescrollfortitudelist, RaidBuffStatus.db.profile.checkrunescrollfortitude, report.checking.runescrollfortitude or false, RaidBuffStatus.BF.runescrollfortitude:buffers())
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "runescrollfortitude")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. ITN[49632], report.runescrollfortitudelist, nil, RaidBuffStatus.BF.runescrollfortitude:buffers()) -- Runescroll of Fortitude
		end,
		singlebuff = false,
		partybuff = false,
		raidbuff = true,
		whispertobuff = function(reportl, prefix)
			local thebuffers = RaidBuffStatus.BF.runescrollfortitude:buffers()
			for _,name in ipairs(thebuffers) do
				if RaidBuffStatus.db.profile.WhisperMany and #reportl >= RaidBuffStatus.db.profile.HowMany then
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.runescrollfortitude.chat .. ">: " .. L["MANY!"], name)
				else
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.runescrollfortitude.chat .. ">: " .. table.concat(reportl, ", "), name)
				end
			end
		end,
		buffers = function()
			if not RaidBuffStatus.itemcheck.runescrollfortitude then
				return
			end
			local thebuffers = {}
				for _,rc in pairs(raid.classes) do
					for name,_ in pairs(rc) do
						local items = RaidBuffStatus.itemcheck.runescrollfortitude.results[name] or 0
						if items > 0 then
							table.insert(thebuffers, name .. "(" .. items .. ")")
						end
					end
				end
			return thebuffers
		end,
	},

	shadow = {
		order = 420,
		list = "shadowlist",
		check = "checkshadow",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		core = true,
		class = { PRIEST = true, },
		chat = BS[976], -- Shadow Protection
		pre = nil,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.PRIEST > 0 then
				report.checking.shadow = true
				local missingbuff = true
				for _, v in ipairs(shadow) do
					if unit.hasbuff[v] then
						missingbuff = false
						break
					end
				end
				if missingbuff then
					if RaidBuffStatus.db.profile.ShowGroupNumber then
						table.insert(report.shadowlist, name .. "(" .. unit.group .. ")" )
					else
						table.insert(report.shadowlist, name)
					end
				end
			end
		end,
		post = function(self, raid, report)
			RaidBuffStatus:SortNameBySuffix(report.shadowlist)
		end,
		icon = BSI[976], -- Shadow Protection
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.shadowlist, RaidBuffStatus.db.profile.checkshadow, report.checking.shadow or false, RaidBuffStatus.BF.shadow:buffers())
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "shadow", BS[976], BS[27683], GetItemInfo(44615), true) -- Shadow Protection and Prayer of Shadow Protection + Devout Candle
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. BS[976], report.shadowlist, nil, RaidBuffStatus.BF.shadow:buffers())
		end,
		singlebuff = false,
		partybuff = false,
		raidbuff = true,
		whispertobuff = function(reportl, prefix)
			for name,_ in pairs(raid.classes.PRIEST) do
				if RaidBuffStatus.db.profile.WhisperMany and #reportl >= RaidBuffStatus.db.profile.HowMany then
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.shadow.chat .. ">: " .. L["MANY!"], name)
				else
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.shadow.chat .. ">: " .. table.concat(reportl, ", "), name)
				end
			end
		end,
		buffers = function()
			local thepriests = {}
			for name,_ in pairs(raid.classes.PRIEST) do
				table.insert(thepriests, name)
			end
			return thepriests
		end,
	},

	noaura = {
		order = 410,
		list = "noauralist",
		check = "checknoaura",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { PALADIN = true, },
		chat = L["Paladin Aura"],
		pre = nil,
		main = function(self, name, class, unit, raid, report)
			if class == "PALADIN" then
				report.checking.noaura = true
				local missingbuff = true
				for _, v in ipairs(auras) do
					if unit.hasbuff[v] then
						if raid.ClassNumbers.PALADIN < 3 then  -- when many palas auras will start getting overwritten
							local _, _, _, _, _, _, _, isMine = UnitBuff(unit.unitid, v)
							if isMine then
								if UnitName(isMine) == name then
									missingbuff = false
									break
								end
							end
						else
							missingbuff = false
							break
						end
					end
				end
				if missingbuff then
					table.insert(report.noauralist, name)
				end
			end
		end,
		post = nil,
		icon = BSI[465], -- Devotion Aura
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.noauralist, RaidBuffStatus.db.profile.checknoaura, report.checking.noaura or false, report.noauralist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "noaura", RaidBuffStatus:SelectPalaAura())
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Paladin has no Aura at all"], report.noauralist)
		end,
		partybuff = nil,
	},

	noaspect = {
		order = 400,
		list = "noaspectlist",
		check = "checknoaspect",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { HUNTER = true, },
		chat = L["Hunter Aspect"],
		pre = nil,
		main = function(self, name, class, unit, raid, report)
			if class == "HUNTER" then
				report.checking.noaspect = true
				local missingbuff = true
				for _, v in ipairs(aspects) do
					if unit.hasbuff[v] then
						missingbuff = false
						break
					end
				end
				if missingbuff then
					table.insert(report.noaspectlist, name)
				end
			end
		end,
		post = nil,
		icon = BSI[13163], -- Aspect of the Monkey
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.noaspectlist, RaidBuffStatus.db.profile.checknoaspect, report.checking.noaspect or false, report.noaspectlist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "noaspect")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Hunter has no aspect at all"], report.noaspectlist)
		end,
		partybuff = nil,
	},

	trueshotaura = {
		order = 395,
		list = "trueshotauralist",
		check = "checktrueshotaura",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { HUNTER = true, },
		chat = BS[19506], -- Trueshot Aura
		main = function(self, name, class, unit, raid, report)
			if class == "HUNTER" then
				if GT:GUIDHasTalent(raid.classes.HUNTER[name].guid, BS[19506]) then -- Trueshot Aura
					report.checking.trueshotaura = true
					if not unit.hasbuff[BS[19506]] then -- Trueshot Aura
						table.insert(report.trueshotauralist, name)
					end
				end
			end
		end,
		post = nil,
		icon = BSI[19506], -- Trueshot Aura
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.trueshotauralist, RaidBuffStatus.db.profile.checktrueshotaura, report.checking.trueshotaura or false, report.trueshotauralist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "trueshotaura", BS[19506]) -- Trueshot Aura
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. BS[19506], report.trueshotauralist)
		end,
		partybuff = nil,
	},

	dkpresence = {
		order = 394,
		list = "dkpresencelist",
		check = "checkdkpresence",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { DEATHKNIGHT = true, },
		chat = L["Death Knight Presence"],
		main = function(self, name, class, unit, raid, report)
			if class ~= "DEATHKNIGHT" then
				return
			end
			report.checking.dkpresence = true
			local missingbuff = true
			for _, v in ipairs(dkpresences) do
				if unit.hasbuff[v] then
					missingbuff = false
					break
				end
			end
			if missingbuff then
				table.insert(report.dkpresencelist, name)
			end
		end,
		post = nil,
		icon = BSI[48266], -- Blood presence
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.dkpresencelist, RaidBuffStatus.db.profile.dkpresence, report.checking.dkpresence or false, report.dkpresencelist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "dkpresence")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Death Knight Presence"], report.dkpresencelist)
		end,
		partybuff = nil,
	},


	innerfire = {
		order = 390,
		list = "innerfirelist",
		check = "checkinnerfire",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { PRIEST = true, },
		chat = BS[588], -- Inner Fire
		main = function(self, name, class, unit, raid, report)
			if class == "PRIEST" then
				report.checking.innerfire = true
				if not unit.hasbuff[BS[588]] then -- Inner Fire
					table.insert(report.innerfirelist, name)
				end
			end
		end,
		post = nil,
		icon = BSI[588], -- Inner Fire
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.innerfirelist, RaidBuffStatus.db.profile.checkinnerfire, report.checking.innerfire or false, report.innerfirelist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "innerfire", BS[588]) -- Inner Fire
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. BS[588], report.innerfirelist)
		end,
		partybuff = nil,
	},

	shadowform = {
		order = 387,
		list = "shadowformlist",
		check = "checkshadowform",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { PRIEST = true, },
		chat = BS[15473], -- Shadowform
		main = function(self, name, class, unit, raid, report)
			if class == "PRIEST" then
				if raid.classes.PRIEST[name].specialisations.shadowform then -- Shadowform
					report.checking.shadowform = true
					if not unit.hasbuff[BS[15473]] then -- Shadowform
						table.insert(report.shadowformlist, name)
					end
				end
			end
		end,
		post = nil,
		icon = BSI[15473], -- Shadowform
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.shadowformlist, RaidBuffStatus.db.profile.checkshadowform, report.checking.shadowform or false, report.shadowformlist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "shadowform", BS[15473]) -- Shadowform
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. BS[15473], report.shadowformlist)
		end,
		partybuff = nil,
	},

	vampiricembrace = {
		order = 386,
		list = "vampiricembracelist",
		check = "checkvampiricembrace",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { PRIEST = true, },
		chat = BS[15286], -- Vampiric Embrace
		main = function(self, name, class, unit, raid, report)
			if class == "PRIEST" then
				if raid.classes.PRIEST[name].specialisations.vampiricembrace then -- Vampiric Embrace
					report.checking.vampiricembrace = true
					if not unit.hasbuff[BS[15286]] then -- Vampiric Embrace
						table.insert(report.vampiricembracelist, name)
					end
				end
			end
		end,
		post = nil,
		icon = BSI[15286], -- Vampiric Embrace
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.vampiricembracelist, RaidBuffStatus.db.profile.vampiricembraceform, report.checking.vampiricembrace or false, report.vampiricembracelist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "vampiricembrace", BS[15286]) -- Vampiric Embrace
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. BS[15286], report.vampiricembracelist) -- Vampiric Embrace
		end,
		partybuff = nil,
	},

	boneshield = {
		order = 385,
		list = "boneshieldlist",
		check = "checkboneshield",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { DEATHKNIGHT = true, },
		chat = BS[49222], -- Bone Shield
		main = function(self, name, class, unit, raid, report)
			if class == "DEATHKNIGHT" then
				if raid.classes.DEATHKNIGHT[name].specialisations.boneshield then
					report.checking.boneshield = true
					if not unit.hasbuff[BS[49222]] then -- Bone Shield
						table.insert(report.boneshieldlist, name)
					end
				end
			end
		end,
		post = nil,
		icon = BSI[49222], -- Bone Shield
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.boneshieldlist, RaidBuffStatus.db.profile.checkboneshield, report.checking.boneshield or false, report.boneshieldlist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "boneshield", BS[49222]) -- Bone Shield
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. BS[49222], report.boneshieldlist) -- Bone Shield
		end,
		partybuff = nil,
	},

	felarmor = {
		order = 380,
		list = "felarmorlist",
		check = "checkfelarmor",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { WARLOCK = true, },
		chat = BS[28176], -- Fel Armor
		main = function(self, name, class, unit, raid, report)
			if class == "WARLOCK" then
				report.checking.felarmor = true
				if not unit.hasbuff[BS[28176]] then -- Fel Armor
					table.insert(report.felarmorlist, name)
				end
			end
		end,
		post = nil,
		icon = BSI[28176], -- Fel Armor
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.felarmorlist, RaidBuffStatus.db.profile.checkfelarmor, report.checking.felarmor or false, report.felarmorlist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "felarmor", BS[28176]) -- Fel Armor
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. BS[28176], report.felarmorlist)
		end,
		partybuff = nil,
	},

	soullink = {
		order = 375,
		list = "soullinklist",
		check = "checksoullink",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { WARLOCK = true, },
		chat = BS[19028], -- Soul Link
		main = function(self, name, class, unit, raid, report)
			if class ~= "WARLOCK" then
				return
			end
			if GT:GUIDHasTalent(raid.classes.WARLOCK[name].guid, BS[19028]) then -- Soul Link talent
				report.checking.soullink = true
				if not unit.hasbuff[BS[19028]] then -- Soul Link
					table.insert(report.soullinklist, name)
				end
			end
		end,
		post = nil,
		icon = BSI[19028], -- Soul Link
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.soullinklist, RaidBuffStatus.db.profile.checksoullink, report.checking.soullink or false, report.soullinklist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "soullink", BS[19028]) -- Soul Link
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. BS[19028], report.soullinklist) -- Soul Link
		end,
		partybuff = nil,
	},
	magearmor = {
		order = 370,
		list = "magearmorlist",
		check = "checkmagearmor",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { MAGE = true, },
		chat = BS[6117], -- Mage Armor
		pre = nil,
		main = function(self, name, class, unit, raid, report)
			if class == "MAGE" then
				report.checking.magearmor = true
				local missingbuff = true
				for _, v in ipairs(magearmors) do
					if unit.hasbuff[v] then
						missingbuff = false
						break
					end
				end
				if missingbuff then
					table.insert(report.magearmorlist, name)
				end
			end
		end,
		post = nil,
		icon = BSI[6117], -- Mage Armor
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.magearmorlist, RaidBuffStatus.db.profile.checkmagearmor, report.checking.magearmor or false, report.magearmorlist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "magearmor")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Mage is missing a Mage Armor"], report.magearmorlist)
		end,
		partybuff = nil,
	},

	shamanshield = {
		order = 355,
		list = "shamanshieldlist",
		check = "checkshamanshield",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { SHAMAN = true, },
		chat = BS[57960] .. "/" .. BS[49281], -- Water Shield/Lightning Shield
		main = function(self, name, class, unit, raid, report)
			if class ~= "SHAMAN" then
				return
			end
			report.checking.shamanshield = true

			local missing = true
			if unit.hasbuff[BS[57960]] then -- Water Shield rank 9
				missing = false
			else
				if GT:GUIDHasTalent(raid.classes.SHAMAN[name].guid, BS[51525]) then -- Static Shock talent
					if unit.hasbuff[BS[49281]] then -- Lightning Shield rank 11
						missing = false
					end
				end
			end
			if missing then
				table.insert(report.shamanshieldlist, name)
			end
		end,
		post = nil,
		icon = BSI[57960], -- Water Shield rank 9
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.shamanshieldlist, RaidBuffStatus.db.profile.checkshamanshield, report.checking.shamanshield or false, report.shamanshieldlist)
		end,
		click = function(self, button, down)
			local name = UnitName("player")
			if name and raid.classes.SHAMAN[name] and GT:GUIDHasTalent(raid.classes.SHAMAN[name].guid, BS[51525]) then -- Static Shock talent
				RaidBuffStatus:ButtonClick(self, button, down, "shamanshield", BS[49281]) -- Lightning Shield rank 11
			else
				RaidBuffStatus:ButtonClick(self, button, down, "shamanshield", BS[57960]) -- Water Shield rank 9
			end
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. BS[57960] .. "/" .. BS[49281], report.shamanshieldlist) -- Water Shield/Lightning Shield
		end,
		partybuff = nil,
	},
	seal = {
		order = 352,
		list = "seallist",
		check = "checkseal",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = true,
		timer = false,
		class = { PALADIN = true, },
		chat = L["Seal"],
		main = function(self, name, class, unit, raid, report)
			if class == "PALADIN" then
				report.checking.seal = true
				local missingbuff = true
				for _, v in ipairs(seals) do
					if unit.hasbuff[v] then
						missingbuff = false
						break
					end
				end
				if missingbuff then
					table.insert(report.seallist, name)
				end
			end
		end,
		post = nil,
		icon = BSI[20165], -- Seal of Light
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.seallist, RaidBuffStatus.db.profile.checkseal, report.checking.seal or false, report.seallist)
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "seal", RaidBuffStatus:SelectSeal())
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Paladin missing Seal"], report.seallist)
		end,
		whispertobuff = nil,
		singlebuff = nil,
		partybuff = nil,
		raidbuff = nil,
	},

	missingblessing = {
		order = 350,
		list = "missingblessinglist",
		check = "checkmissingblessing",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		core = true,
		class = { PALADIN = true, },
		chat = function(report, raid, prefix, channel)
			prefix = prefix or ""
			if RaidBuffStatus.db.profile.ShowMany and #report.missingblessinglist >= RaidBuffStatus.db.profile.HowMany then
				RaidBuffStatus:Say(prefix .. "<" .. L["Paladin blessing"] .. ">: " .. L["MANY!"], nil, nil, channel)
			else
				RaidBuffStatus:Say(prefix .. "<" .. L["Paladin blessing"] .. ">: " .. table.concat(report.missingblessinglist, ", "), nil, nil, channel)
			end
			if #report.slackingpaladins > 0 then
				RaidBuffStatus:Say("<" .. L["Slacking Paladins"] .. ">: " .. table.concat(report.slackingpaladins, ", ", nil, nil, channel))
			end
		end,
		pre = function(self, raid, report)
			if raid.ClassNumbers.PALADIN < 1 then
				return
			end
			report.whichblessingsmissing = {}
			report.slackingpaladins = {}
			report.slackingpaladinsnames = {}
			report.paladinsresponsible = {}
			report.pallyblessingsmessagelist = {}
			report.ppproblems = {}
			report.ppunassigned = {}
			report.ppunassignedlist = {}
			report.ppinappropriate = {}
			report.ppinappropriatelist = {}
			report.sanctuaryassignedbutnoonetodoit = false
			report.gotwiz = false
			report.gotsanc = false
			if (raid.maxbowpoints + 1) >= raid.maxrestorativetotemspoints then
				report.gotwiz = true
			else
				report.pallyblessingsmessagelist[L["Blessing of Wisdom will be overwritten by Shaman totems as points spent in Restorative Totems is greater than Improved Blessing of Wisdom."]] = true
			end
			if # raid.SanctuaryTalent > 0 then
				report.gotsanc = true
			end

			report.blessingsperclass = {}
			report.usingpallypower = false
			report.allpallyhavepp = true
			report.pallymissingpp = {}
			for name,_ in pairs(raid.classes.PALADIN) do
				if not pppallies[name] then
					report.allpallyhavepp = false
					table.insert(report.pallymissingpp, name)
				end
			end
			for class,_ in pairs(raid.classes) do
				report.blessingsperclass[class] = {}
				if RaidBuffStatus.db.profile.usepallypower and (not RaidBuffStatus.db.profile.noppifpaladinmissing or report.allpallyhavepp or raid.isbattle) then
					for spell,_ in pairs(ppassignments[class]) do
						table.insert(report.blessingsperclass[class], spell)
						report.usingpallypower = true
					end
				end
			end
			if not RaidBuffStatus:UsePalaKings(raid, report) then
				report.pallyblessingsmessagelist[L["Blessing of Kings, with this raid configuration, is better at least partly provided by Drums of the Forgotten Kings thus allowing other blessings to be used."]] = true
			end
		end,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.PALADIN < 1 then
				return
			end
			report.checking.missingblessing = true
			local unitblessings = {}  -- all the blessings suitable for this character
			for _, blessinglist in ipairs(minblessings[class].All) do
				unitblessings[blessinglist.shortname] = blessinglist
			end
			if unit.talents then
				local spec = unit.spec
				if minblessings[class][spec] then
					for _, blessinglist in ipairs(minblessings[class][spec]) do
						unitblessings[blessinglist.shortname] = blessinglist
					end
				end
			end
			local maxblessingssize = RaidBuffStatus:DicSize(unitblessings)
			if not report.gotsanc then
				maxblessingssize = maxblessingssize - 1
			end
			local ppunitblessings = {} -- all the blessings allocated for this character
			local ppunitblessingssize = 0
			if report.usingpallypower then
				ppunitblessings = RaidBuffStatus:GetAllocatedBlessings(name, class)
				ppunitblessingssize = RaidBuffStatus:DicSize(ppunitblessings)
			end
			local numbless = 0
			local missinglist = {}
			local missinglistf = {}
			local unassignedlist = {}
			local inappropriatelist = {}
			for _, bl in pairs(allblessings) do
				local found = false
				for _, v in ipairs(bl) do
					if unit.hasbuff[v] then
						found = true
						break
					end
				end
				local appropriate = false
				if (bl.name == blessingofsanctuary.name and report.gotsanc) or bl.name ~= blessingofsanctuary.name then
					for _, bll in pairs(unitblessings) do
						if bll.name == bl.name then  -- is missing one which is appropriate
							appropriate = true
							break
						end
					end
				end
				if found then
					if not appropriate then
						table.insert(inappropriatelist, bl.name)  -- they have an inappropriate blessing
					end
				end
				local assigned = false
				if report.usingpallypower then
					for _, bll in pairs(ppunitblessings) do
						if bll.name == bl.name then  -- is missing one which is appropriate
							assigned = true
							break
						end
					end
					if (appropriate and not assigned) or (not appropriate and assigned) then
						table.insert(unassignedlist, bl.name)
					end
					if assigned and not report.gotsanc and bl.name == blessingofsanctuary.name then
						report.sanctuaryassignedbutnoonetodoit = true
					end
				end
				if ((report.usingpallypower and assigned) or not report.usingpallypower) and appropriate then
					if found then
						numbless = numbless + 1
					else
						if RaidBuffStatus.db.profile.ShortMissingBlessing then
							table.insert(missinglist, bl.shortname)
						else
							table.insert(missinglist, bl.name)
						end
						table.insert(missinglistf, bl.name)
					end
				end
			end
			if numbless < maxblessingssize and numbless < raid.ClassNumbers.PALADIN then
				if #missinglist > 0 then
					table.insert(report.missingblessinglist, name .. "(" .. table.concat(missinglist, ", ") .. ")")
					if not report.whichblessingsmissing[class] then
						report.whichblessingsmissing[class] = {}
					end
					report.whichblessingsmissing[class][name] = missinglistf
				else
					if #unassignedlist > 0 then
						if not report.ppunassigned[class] then
							report.ppunassigned[class] = {}
							report.ppunassigned[class][name] = unassignedlist
						end
					end
					if #inappropriatelist > 0 then
						if not report.ppinappropriate[class] then
							report.ppinappropriate[class] = {}
							report.ppinappropriate[class][name] = inappropriatelist
						end
					end
				end
			end
		end,
		post = function(self, raid, report)
			if RaidBuffStatus.db.profile.usepallypower and (not RaidBuffStatus.db.profile.noppifpaladinmissing or report.allpallyhavepp) then
				report.paladinsresponsible = RaidBuffStatus:FindPaladinsResponsible(report.whichblessingsmissing)
				for name,_ in pairs(report.paladinsresponsible) do
					table.insert(report.slackingpaladinsnames, name)
				end
				for _,name in ipairs(report.slackingpaladinsnames) do
					table.insert(report.slackingpaladins, name .. "(" .. table.concat(RaidBuffStatus:GetPaladinsAssignments(name, RaidBuffStatus.db.profile.ShortMissingBlessing), ", ") .. ")")
				end
				for class, c in pairs(report.ppunassigned) do
					local blesss = {}
					for name, list in pairs(c) do
						for _, spell in ipairs(list) do
							if RaidBuffStatus.db.profile.ShortMissingBlessing then
								table.insert(blesss, longtoshortblessing[spell])
							else
								table.insert(blesss, spell)
							end
						end
					end
					table.insert(report.ppunassignedlist, LOCALIZED_CLASS_NAMES_MALE[class] .. "(" .. table.concat(blesss, ", ") .. ")")-- todo normalise it!
				end
				if #report.ppunassignedlist > 0 then
					table.insert(report.missingblessinglist, "[" .. L["Check Pally Power for: "] .. table.concat(report.ppunassignedlist, ", ") .. "]")
				end
				for class, c in pairs(report.ppinappropriate) do
					local blesss = {}
					for name, list in pairs(c) do
						for _, spell in ipairs(list) do
							if RaidBuffStatus.db.profile.ShortMissingBlessing then
								table.insert(blesss, longtoshortblessing[spell])
							else
								table.insert(blesss, spell)
							end
						end
					end
					table.insert(report.ppinappropriatelist, LOCALIZED_CLASS_NAMES_MALE[class] .. "(" .. table.concat(blesss, ", ") .. ")")
				end
				if #report.ppinappropriatelist > 0 then
					table.insert(report.missingblessinglist, "[" .. L["The following have inappropriate Paladin blessings: "] .. table.concat(report.ppinappropriatelist, ", ") .. "]")
				end
				if report.sanctuaryassignedbutnoonetodoit then
					report.ppproblems[L["Sanctuary is assigned in Pally Power but no one has the spec to do it."]] = true
				end
			end
		end,
		icon = BSI[25898], -- Greater Blessing of Kings
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.missingblessinglist, RaidBuffStatus.db.profile.checkmissingblessing, report.checking.missingblessing or false, report.slackingpaladins)
		end,
		click = function(self, button, down)
			if report.usingpallypower then
				RaidBuffStatus:ButtonClick(self, button, down, "missingblessing", BSI[25898], BSI[25898], GetItemInfo(21177), true) -- Greater Blessing of Kings + Symbol of Kings
			else
				RaidBuffStatus:ButtonClick(self, button, down, "missingblessing")
			end
		end,
		tip = function(self)
			if not report.slackingpaladinsnames then  -- fixes error when tip being called from option window when not in a party/raid and when no paladins
				RaidBuffStatus:Tooltip(self, L["Player is missing at least one Paladin blessing"])
			else
				if RaidBuffStatus.db.profile.usepallypower then
					RaidBuffStatus:Tooltip(self, L["Player is missing at least one Paladin blessing"], report.missingblessinglist, nil, RaidBuffStatus.BF.missingblessing:buffers(), report.slackingpaladins, report.pallymissingpp, nil, nil, report.pallyblessingsmessagelist, report.ppproblems)
				else
					RaidBuffStatus:Tooltip(self, L["Player is missing at least one Paladin blessing"], report.missingblessinglist, nil, RaidBuffStatus.BF.missingblessing:buffers(), nil, nil, nil, nil, report.pallyblessingsmessagelist, report.ppproblems)
				end
			end
		end,
		singlebuff = false,
		partybuff = false,
		raidbuff = false,
		paladinbuff = true,
		whispertobuff = function(reportl, prefix)
			if #report.slackingpaladinsnames < 1 then
				for name,_ in pairs(raid.classes.PALADIN) do
					if RaidBuffStatus.db.profile.WhisperMany and #reportl >= RaidBuffStatus.db.profile.HowMany then
						RaidBuffStatus:Say(prefix .. "<" .. L["Paladin blessing"] .. ">: " .. L["MANY!"], name)
					else
						RaidBuffStatus:Say(prefix .. "<" .. L["Paladin blessing"] .. ">: " .. table.concat(reportl, ", "), name)
					end
				end
			else
				for name,_ in pairs(report.paladinsresponsible) do
					local missings = {}
					for nom,_ in pairs(report.paladinsresponsible[name]) do
						for spell,_ in pairs(report.paladinsresponsible[name][nom]) do
							if RaidBuffStatus.db.profile.ShortMissingBlessing then
								table.insert(missings, nom .. "(" .. longtoshortblessing[spell] .. ")")
							else
								table.insert(missings, nom .. "(" .. spell .. ")")
							end
						end
					end
					RaidBuffStatus:Say(prefix .. "<" .. L["Paladin blessing"] .. ">: " .. table.concat(missings, ", "), name)
				end
			end
		end,
		buffers = function()
			local thelols = {}
			if RaidBuffStatus.db.profile.usepallypower and (not RaidBuffStatus.db.profile.noppifpaladinmissing or report.allpallyhavepp) then
				for name,_ in pairs(raid.classes.PALADIN) do
					local assignments = RaidBuffStatus:GetPaladinsAssignments(name, RaidBuffStatus.db.profile.ShortMissingBlessing)
					if #assignments > 0 then
						table.insert(thelols, name .. "(" .. table.concat(assignments, ", ") .. ")")
					end
				end
			end
			if #thelols < 1 then  -- maybe no PP installed
				for name,_ in pairs(raid.classes.PALADIN) do
					table.insert(thelols, name)
				end
			end
			return thelols
		end,
	},

	drumskings = {
		order = 345,
		list = "drumskingslist",
		check = "checkdrumskings",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		chat = BS[69378], -- Blessing of Forgotten Kings
		pre = function(self, raid, report)
			if raid.ClassNumbers.PALADIN > 3 or not oRA or raid.isbattle then
				return
			end
			if RaidBuffStatus:UsePalaKings(raid) then
				return
			end
			if not RaidBuffStatus.itemcheck.drumskings then
				RaidBuffStatus.itemcheck.drumskings = {}
				RaidBuffStatus.itemcheck.drumskings.results = {}
				RaidBuffStatus.itemcheck.drumskings.list = "drumskingslist"
				RaidBuffStatus.itemcheck.drumskings.check = "drumskings"
				RaidBuffStatus.itemcheck.drumskings.next = 0
				RaidBuffStatus.itemcheck.drumskings.item = "49633" -- Drums of Forgotten Kings
				RaidBuffStatus.itemcheck.drumskings.min = 0
				RaidBuffStatus.itemcheck.drumskings.frequency = 60 * 5
				RaidBuffStatus.itemcheck.drumskings.frequencymissing = 60 * 5
			end
		end,
		main = function(self, name, class, unit, raid, report)
			if RaidBuffStatus:UsePalaKings(raid) then
				return
			end
			report.checking.drumskings = true
			local missingbuff = true
			for _, v in ipairs(blessingofforgottenkings) do
				if unit.hasbuff[v] then
					missingbuff = false
					break
				end
			end
			if missingbuff then
				table.insert(report.drumskingslist, name)
			end
		end,
		post = nil,
		icon = ITT[49633], -- Drums of Forgotten Kings
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.drumskingslist, RaidBuffStatus.db.profile.checkdrumskings, report.checking.drumskings or false, RaidBuffStatus.BF.drumskings:buffers())
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "drumskings")
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. BS[69378] .. "/" .. BS[20217], report.drumskingslist, nil, RaidBuffStatus.BF.drumskings:buffers()) -- Blessing of Forgotten Kings, Blessing of Kings
		end,
		singlebuff = false,
		partybuff = false,
		raidbuff = true,
		whispertobuff = function(reportl, prefix)
			local thebuffers = RaidBuffStatus.BF.drumskings:buffers()
			for _,name in ipairs(thebuffers) do
				if RaidBuffStatus.db.profile.WhisperMany and #reportl >= RaidBuffStatus.db.profile.HowMany then
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.drumskings.chat .. ">: " .. L["MANY!"], name)
				else
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.drumskings.chat .. ">: " .. table.concat(reportl, ", "), name)
				end
			end
		end,
		buffers = function()
			if not RaidBuffStatus.itemcheck.drumskings then
				return
			end
			local thebuffers = {}
				for _,rc in pairs(raid.classes) do
					for name,_ in pairs(rc) do
						local items = RaidBuffStatus.itemcheck.drumskings.results[name] or 0
						if items > 0 then
							table.insert(thebuffers, name .. "(" .. items .. ")")
						end
					end
				end
			return thebuffers
		end,
	},

	amplifymagic = {
		order = 340,
		list = "amplifymagiclist",
		check = "checkamplifymagic",
		default = false,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = false,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		chat = BS[33946], -- Amplify Magic
		pre = nil,
		main = function(self, name, class, unit, raid, report)
			if raid.ClassNumbers.MAGE > 0 then
				report.checking.amplifymagic = true
				if not unit.hasbuff[BS[33946]] then
					table.insert(report.amplifymagiclist, name)
				end
			end
		end,
		post = nil,
		icon = BSI[33946], -- Amplify Magic
		update = function(self)
			RaidBuffStatus:DefaultButtonUpdate(self, report.amplifymagiclist, RaidBuffStatus.db.profile.checkamplifymagic, report.checking.amplifymagic or false, RaidBuffStatus.BF.amplifymagic:buffers())
		end,
		click = function(self, button, down)
			RaidBuffStatus:ButtonClick(self, button, down, "amplifymagic", BS[33946], BS[33946], nil, true) -- Amplify Magic
		end,
		tip = function(self)
			RaidBuffStatus:Tooltip(self, L["Missing "] .. BS[33946], report.amplifymagiclist, nil, RaidBuffStatus.BF.amplifymagic:buffers()) -- same as intellect for amplify magic
		end,
		singlebuff = true,
		partybuff = false,
		raidbuff = false,
		whispertobuff = function(reportl, prefix)
			for name,_ in pairs(raid.classes.MAGE) do
				if RaidBuffStatus.db.profile.WhisperMany and #reportl >= RaidBuffStatus.db.profile.HowMany then
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.amplifymagic.chat .. ">: " .. L["MANY!"], name)
				else
					RaidBuffStatus:Say(prefix .. "<" .. RaidBuffStatus.BF.amplifymagic.chat .. ">: " .. table.concat(reportl, ", "), name)
				end
			end
		end,
		buffers = function()
			local themages = {}
			local maxpoints = 0
			for name,rcn in pairs(raid.classes.MAGE) do
				local points = GT:GUIDHasTalent(rcn.guid, BS[11247]) or 0 -- Magic Attunement
				if points > maxpoints then
					maxpoints = points
					themages = {}
					table.insert(themages, name)
				elseif points == maxpoints then
					table.insert(themages, name)
				end
			end
			return themages
		end,
	},
	tanklist = {
		order = 20,
		list = "none",
		check = "checktanklist",
		default = true,
		defaultbuff = false,
		defaultwarning = true,
		defaultdash = false,
		defaultdashcombat = false,
		defaultboss = false,
		defaulttrash = true,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		chat = nil,
		pre = nil,
		main = nil,
		post = nil,
		icon = "Interface\\Icons\\Ability_Defend",
		update = function(self)
			self.count:SetText("")
			if #raid.TankList > 0 then
				self:SetAlpha("1")
			else
				self:SetAlpha("0.15")
			end
		end,
		click = nil,
		tip = function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(L["RBS Tank List"],1,1,1)
			for _,v in ipairs(raid.TankList) do
				local class = "WARRIOR"
				local unit = RaidBuffStatus:GetUnitFromName(v)
				if unit then
					class = unit.class
				end
				GameTooltip:AddLine(v,RAID_CLASS_COLORS[class].r,RAID_CLASS_COLORS[class].g,RAID_CLASS_COLORS[class].b,nil)
			end
			GameTooltip:Show()
		end,
		partybuff = nil,
	},
	help20090704 = {
		order = 10,
		list = "none",
		check = "checkhelp20090704",
		default = true,
		defaultbuff = true,
		defaultwarning = false,
		defaultdash = true,
		defaultdashcombat = false,
		defaultboss = true,
		defaulttrash = false,
		checkzonedout = false,
		selfbuff = false,
		timer = false,
		chat = nil,
		pre = nil,
		main = nil,
		post = nil,
		icon = "Interface\\Icons\\Mail_GMIcon",
		update = function(self)
			self.count:SetText("")
		end,
		click = nil,
		tip = function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(L["RBS Dashboard Help"],1,1,1)
			GameTooltip:AddLine(L["Click buffs to disable and enable."],nil,nil,nil)
			GameTooltip:AddLine(L["Shift-Click buffs to report on only that buff."],nil,nil,nil)
			GameTooltip:AddLine(L["Ctrl-Click buffs to whisper those who need to buff."],nil,nil,nil)
			GameTooltip:AddLine(L["Alt-Click on a self buff will renew that buff."],nil,nil,nil)
			GameTooltip:AddLine(L["Alt-Click on a party buff will cast on someone missing that buff."],nil,nil,nil)
			GameTooltip:AddLine(" ",nil,nil,nil)
			GameTooltip:AddLine(L["Remove this button from this dashboard in the buff options window."],nil,nil,nil)
			GameTooltip:AddLine(" ",nil,nil,nil)
			GameTooltip:AddLine(L["The above default button actions can be reconfigured."],nil,nil,nil)
			GameTooltip:AddLine(L["Press Escape -> Interface -> AddOns -> RaidBuffStatus for more options."],nil,nil,nil)
			GameTooltip:AddLine(" ",nil,nil,nil)
			GameTooltip:AddLine(L["Ctrl-Click Boss or Trash to whisper all those who need to buff."],nil,nil,nil)
			GameTooltip:Show()
		end,
		partybuff = nil,
	},
}

RaidBuffStatus.BF = BF
