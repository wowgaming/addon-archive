local addonName, Critline = ...
_G.Critline = Critline

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local templates = Critline.templates
local playerClass = select(2, UnitClass("player"))
local debugging

-- auto attack spell
local AUTOATK = GetSpellInfo(6603)

-- local references to commonly used functions and variables for faster access
local HasPetUI = HasPetUI
local tonumber = tonumber
local CombatLog_Object_IsA = CombatLog_Object_IsA
local bor = bit.bor
local band = bit.band

local COMBATLOG_FILTER_MINE = COMBATLOG_FILTER_MINE
local COMBATLOG_FILTER_MY_PET = COMBATLOG_FILTER_MY_PET
local COMBATLOG_OBJECT_REACTION_FRIENDLY = COMBATLOG_OBJECT_REACTION_FRIENDLY
local COMBATLOG_OBJECT_REACTION_HOSTILE = COMBATLOG_OBJECT_REACTION_HOSTILE
local COMBATLOG_OBJECT_CONTROL_PLAYER = COMBATLOG_OBJECT_CONTROL_PLAYER
local COMBATLOG_OBJECT_TYPE_GUARDIAN = COMBATLOG_OBJECT_TYPE_GUARDIAN


local treeNames = {
	dmg = L["damage"],
	heal = L["healing"],
	pet = L["pet"],
}
Critline.treeNames = treeNames


Critline.icons = {
	dmg = "Interface\\Icons\\Ability_SteelMelee",
	heal = "Interface\\Icons\\Spell_Holy_FlashHeal",
	pet = "Interface\\Icons\\Ability_Hunter_Pet_Bear",
}


-- non hunter pets whose damage we may want to register
local classPets = {
	[510] = true,	-- Water Elemental
	[11859] = true,	-- Doomguard
	[15438] = true,	-- Greater Fire Elemental
	[27829] = true, -- Ebon Gargoyle
	[29264] = true,	-- Spirit Wolf
	[37994] = true, -- Water Elemental (glyphed)
}


local swingDamage = function(amount, _, school, resisted, _, _, critical)
	return AUTOATK, amount, resisted, critical, school
end

local spellDamage = function(_, spellName, _, amount, _, school, resisted, _, _, critical)
	return spellName, amount, resisted, critical, school
end

local healing = function(_, spellName, _, amount, _, _, critical)
	return spellName, amount, 0, critical, 0
end


local combatEvents = {
	SWING_DAMAGE = swingDamage,
	RANGE_DAMAGE = spellDamage,
	SPELL_DAMAGE = spellDamage,
	SPELL_PERIODIC_DAMAGE = spellDamage,
	SPELL_HEAL = healing,
	SPELL_PERIODIC_HEAL = healing,
}


local recordSorters = {
	-- alpha: sort by name
	alpha = function(a, b)
		if a == b then return end
		if a.spellName == b.spellName then
			-- sort DoT entries after non DoT
			return b.isPeriodic
		else
			return a.spellName < b.spellName
		end
	end,
	-- crit: sort by crit > normal > name
	crit = function(a, b)
		if a == b then return end
		local critA, critB = (a.crit and a.crit.amount or 0), (b.crit and b.crit.amount or 0)
		if critA == critB then
			-- equal crit amounts, sort by normal amount instead
			local normalA, normalB = (a.normal and a.normal.amount or 0), (b.normal and b.normal.amount or 0)
			if normalA == normalB then
				-- equal normal amounts, sort by name instead
				if a.spellName == b.spellName then
					return b.isPeriodic
				else
					return a.spellName < b.spellName
				end
			else
				return normalA > normalB
			end
		else
			return critA > critB
		end
	end,
	-- normal: sort by normal > crit > name
	normal = function(a, b)
		if a == b then return end
		local normalA, normalB = (a.normal and a.normal.amount or 0), (b.normal and b.normal.amount or 0)
		if normalA == normalB then
			local critA, critB = (a.crit and a.crit.amount or 0), (b.crit and b.crit.amount or 0)
			if critA == critB then
				if a.spellName == b.spellName then
					return b.isPeriodic
				else
					return a.spellName < b.spellName
				end
			else
				return critA > critB
			end
		else
			return normalA > normalB
		end
	end,
}


local callbacks = LibStub("CallbackHandler-1.0"):New(Critline)
Critline.callbacks = callbacks


-- this will hold the text for the summary tooltip
local tooltips = {dmg = {}, heal = {}, pet = {}}


Critline.eventFrame = CreateFrame("Frame")
function Critline:RegisterEvent(event)
	self.eventFrame:RegisterEvent(event)
end
function Critline:UnregisterEvent(event)
	self.eventFrame:UnregisterEvent(event)
end
Critline:RegisterEvent("ADDON_LOADED")
Critline:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
Critline.eventFrame:SetScript("OnEvent", function(self, event, ...)
	return Critline[event] and Critline[event](Critline, ...)
end)


local config = templates:CreateConfigFrame(addonName, nil, true)


do
	local options = {}
	Critline.options = options
	
	local function toggleTree(self)
		local display = Critline.display
		if display then
			display:UpdateTree(self.setting)
		end
	end
	
	local checkButtons = {
		db = {},
		percharDB = {},
		{
			text = L["Record damage"],
			tooltipText = L["Check to enable damage events to be recorded."],
			setting = "dmg",
			perchar = true,
			func = toggleTree,
		},
		{
			text = L["Record healing"],
			tooltipText = L["Check to enable healing events to be recorded."],
			setting = "heal",
			perchar = true,
			func = toggleTree,
		},
		{
			text = L["Record pet damage"],
			tooltipText = L["Check to enable pet damage events to be recorded."],
			setting = "pet",
			perchar = true,
			func = toggleTree,
		},
		{
			text = L["Record PvE"],
			tooltipText = L["Disable to ignore records where the target is an NPC."],
			setting = "PvE",
			gap = 16,
		},
		{
			text = L["Record PvP"],
			tooltipText = L["Disable to ignore records where the target is a player."],
			setting = "PvP",
		},
		{
			text = L["Chat output"],
			tooltipText = L["Prints new record notifications to the chat frame."],
			setting = "chatOutput",
		},
		{
			text = L["Play sound"],
			tooltipText = L["Plays a sound on a new record."],
			setting = "sound",
		},
		{
			text = L["Screenshot"],
			tooltipText = L["Saves a screenshot on a new record."],
			setting = "screenshot",
			newColumn = true,
		},
		{
			text = L["Detailed tooltip"],
			tooltipText = L["Use detailed format in the summary tooltip."],
			setting = "detailedTooltip",
			func = function(self) Critline:UpdateTooltips() end,
		},
		{
			text = L["Ignore vulnerability"],
			tooltipText = L["Enable to ignore additional damage due to vulnerability."],
			setting = "ignoreVulnerability",
		},
	}
	
	options.checkButtons = checkButtons
	
	for i, v in ipairs(checkButtons) do
		local btn = templates:CreateCheckButton(config, v)
		if i == 1 then
			btn:SetPoint("TOPLEFT", config.title, "BOTTOMLEFT", -2, -16)
		elseif v.newColumn then
			btn:SetPoint("TOPLEFT", config.title, "BOTTOM", 0, -16)
		else
			btn:SetPoint("TOP", checkButtons[i - 1], "BOTTOM", 0, -(v.gap or 8))
		end
		btn.module = Critline
		local btns = checkButtons[btn.db]
		btns[#btns + 1] = btn
		checkButtons[i] = btn
	end
	
	-- summary sort dropdown
	local menu = {
		onClick = function(self)
			self.owner:SetSelectedValue(self.value)
			Critline.db.profile.tooltipSort = self.value
			Critline:UpdateTooltips()
		end,
		{
			text = L["Alphabetically"],
			value = "alpha",
		},
		{
			text = L["By normal record"],
			value = "normal",
		},
		{
			text = L["By crit record"],
			value = "crit",
		},
	}
	
	local sorting = templates:CreateDropDownMenu("CritlineTooltipSorting", config, menu)
	sorting:SetFrameWidth(120)
	sorting:SetPoint("TOPLEFT", checkButtons[#checkButtons], "BOTTOMLEFT", -15, -24)
	sorting.label:SetText(L["Tooltip sorting:"])
	
	options.tooltipSort = sorting
end


SlashCmdList.CRITLINE = function(msg)
	msg = msg:trim():lower()
	if msg == "debug" then
		Critline:ToggleDebug()
	elseif msg == "reset" then
		local display = Critline.display
		if display then
			display:ClearAllPoints()
			display:SetPoint("CENTER")
		end
	else
		Critline:OpenConfig()
	end
end

SLASH_CRITLINE1 = "/critline"
SLASH_CRITLINE2 = "/cl"


local defaults = {
	profile = {
		PvE = true,
		PvP = true,
		chatOutput = false,
		sound = false,
		screenshot = false,
		detailedTooltip = false,
		ignoreVulnerability = true,
		tooltipSort = "normal",
	},
}


-- which trees are enabled by default for a given class
local treeDefaults = {
	DEATHKNIGHT	= {dmg = true, heal = false, pet = false},
	DRUID		= {dmg = true, heal = true, pet = false},
	HUNTER		= {dmg = true, heal = false, pet = true},
	MAGE		= {dmg = true, heal = false, pet = false},
	PALADIN		= {dmg = true, heal = true, pet = false},
	PRIEST		= {dmg = true, heal = true, pet = false},
	ROGUE		= {dmg = true, heal = false, pet = false},
	SHAMAN		= {dmg = true, heal = true, pet = false},
	WARLOCK		= {dmg = true, heal = false, pet = true},
	WARRIOR		= {dmg = true, heal = false, pet = false},
}

function Critline:ADDON_LOADED(addon)
	if addon == addonName then
		local AceDB = LibStub("AceDB-3.0")
		local db = AceDB:New("CritlineDB", defaults, nil)
		self.db = db
		
		local percharDefaults = {
			profile = treeDefaults[playerClass],
		}
		
		percharDefaults.profile.spells = {
			dmg = {},
			heal = {},
			pet = {},
		}
		
		local percharDB = AceDB:New("CritlinePerCharDB", percharDefaults)
		self.percharDB = percharDB
		
		-- dual spec support
		local LibDualSpec = LibStub("LibDualSpec-1.0")
		LibDualSpec:EnhanceDatabase(self.db, addonName)
		LibDualSpec:EnhanceDatabase(self.percharDB, addonName)
		
		db.RegisterCallback(self, "OnProfileChanged", "LoadSettings")
		db.RegisterCallback(self, "OnProfileCopied", "LoadSettings")
		db.RegisterCallback(self, "OnProfileReset", "LoadSettings")
		
		percharDB.RegisterCallback(self, "OnProfileChanged", "LoadPerCharSettings")
		percharDB.RegisterCallback(self, "OnProfileCopied", "LoadPerCharSettings")
		percharDB.RegisterCallback(self, "OnProfileReset", "LoadPerCharSettings")
		
		self:UnregisterEvent("ADDON_LOADED")
		callbacks:Fire("AddonLoaded")
		
		-- import old records and mob filter
		if CritlineSettings then
			for i, v in ipairs({"dmg","heal","pet"}) do
				percharDB.profile.spells[v] = CritlineDB[v]
				CritlineDB[v] = nil
			end
			
			if self.filters and CritlineMobFilter then
				self.filters.db.global.mobs = CritlineMobFilter
			end
		end
		
		self:LoadSettings()
		self:LoadPerCharSettings()
		
		self.ADDON_LOADED = nil
	end
end


function Critline:COMBAT_LOG_EVENT_UNFILTERED(timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
	-- we seem to get events with standard arguments equal to nil, so they need to be ignored
	if not (timestamp and eventType) then
		self:Debug("nil errors on start")
		return
	end

	-- if we don't have a destName (who we hit or healed) and we don't have a sourceName (us or our pets) then we leave
	if not (destName or sourceName) then
		self:Debug("nil source/dest")
		return
	end
	
	-- check for filtered auras
	if self.filters then
		if self.filters:IsAuraEvent(eventType, ..., sourceFlags, destFlags, destGUID) then
			return
		end
	end
	
	local isPet
	
	-- if sourceGUID is not us or our pet, we leave
	if not CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MINE) then
		local isMyPet = CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MY_PET)
		local isGuardian = band(sourceFlags, COMBATLOG_OBJECT_TYPE_GUARDIAN) ~= 0
		-- only register if it's a real pet, or a guardian tree pet that's included in the filter
		if isMyPet and ((not isGuardian and HasPetUI()) or classPets[tonumber(sourceGUID:sub(6, 12), 16)]) then
			isPet = true
			-- self:Debug(format("This is my pet (%s)", sourceName))
		else
			-- self:Debug("This is not me, my trap or my pet; return.")
			return
		end
	else
		-- self:Debug(format("This is me or my trap (%s)", sourceName))
	end
	
	if not combatEvents[eventType] then
		return
	end
	
	local isHeal
	local isPeriodic
	if eventType:find("_HEAL$") then
		isHeal = true
		if isPet then
			return
		end
	end
	if eventType:find("_PERIODIC_") then
		isPeriodic = true
	end
	
	local spellName, amount, resisted, critical, school = combatEvents[eventType](...)
	
	-- below are some checks to see if we want to register the hit at all
	if amount <= 0 then
		self:Debug(format("Amount <= 0. (%s) Return.", self:GetFullSpellName(tree, spellName, isPeriodic)))
		return
	end

	local tree = "dmg"
	
	if isPet then
		tree = "pet"
	elseif isHeal then
		tree = "heal"
	end
	
	local passed, isFiltered, targetLevel
	if self.filters then
		passed, isFiltered, targetLevel = self.filters:SpellPassesFilters(tree, spellName, ..., isPeriodic, destGUID, destName, school)
		if not passed then
			return
		end
	end
	
	local isPlayer = band(destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) ~= 0
	local friendlyFire = band(destFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) ~= 0
	local hostileTarget = band(destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) ~= 0
	
	if not (isPlayer or self.db.profile.PvE or isHeal) then
		self:Debug(format("Target (%s) is an NPC and PvE damage is not registered.", destName))
		return
	end
	
	if isPlayer and not (self.db.profile.PvP or isHeal or friendlyFire) then
		self:Debug(format("Target (%s) is a player and PvP damage is not registered.", destName))
		return
	end
	
	-- ignore damage done to friendly targets
	if friendlyFire and not isHeal then
		self:Debug(format("Friendly fire (%s, %s).", spellName, destName))
		return
	end
	
	-- ignore healing done to hostile targets
	if hostileTarget and isHeal then
		self:Debug(format("Healing hostile target (%s, %s).", spellName, destName))
		return
	end
	
	-- we only want damage spells from the pet
	if isHeal and isPet then
		self:Debug("Pet healing. Return.")
		return
	end

	-- exit if not recording tree dmg
	if not self.percharDB.profile[tree] then
		self:Debug(format("Not recording this tree (%s). Return.", tree))
		return
	end
	
	-- ignore vulnerability damage if necessary
	if self.db.profile.ignoreVulnerability then
		amount = amount + (resisted or 0)
	end
	
	local hitType = critical and "crit" or "normal"
	
	local data = self:GetSpellInfo(tree, spellName, isPeriodic)
	
	-- create spell database entries as required
	if not data then
		self:Debug(format("Creating data for %s (%s)", self:GetFullSpellName(tree, spellName, isPeriodic), tree))
		data = {
			spellName = spellName,
			isPeriodic = isPeriodic,
		}
		self:AddSpell(tree, data)
		self:UpdateSpells(tree)
	end
	
	if not data[hitType] then
		data[hitType] = {amount = 0}
	end
	
	data = data[hitType]

	if amount > data.amount then
		local oldAmount = data.amount
		data.amount = amount
		data.target = destName
		data.targetLevel = targetLevel
		data.isPvPTarget = isPlayer
		
		if not isFiltered then
			self:NewRecord(self:GetFullSpellName(tree, spellName, isPeriodic), amount, critical, oldAmount)
		end
		
		self:UpdateRecords(tree, isFiltered)
	end
end


function Critline:Message(msg)
	if msg then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Critline:|r "..msg)
	end
end


function Critline:Debug(msg)
	if debugging then
		DEFAULT_CHAT_FRAME:AddMessage("|cff56a3ffCritlineDebug:|r "..msg)
	end
end


function Critline:ToggleDebug()
	debugging = not debugging
	self:Message("Debugging "..(debugging and "enabled" or "disabled"))
end


function Critline:OpenConfig()
	InterfaceOptionsFrame_OpenToCategory(config)
end


function Critline:LoadSettings()
	callbacks:Fire("SettingsLoaded")
	
	local options = self.options
	
	for _, btn in ipairs(options.checkButtons.db) do
		btn:LoadSetting()
	end
	
	options.tooltipSort:SetSelectedValue(self.db.profile.tooltipSort)
end


function Critline:LoadPerCharSettings()
	callbacks:Fire("PerCharSettingsLoaded")
	
	self:UpdateTooltips()
	
	for _, btn in ipairs(self.options.checkButtons.percharDB) do
		btn:LoadSetting()
	end
end


function Critline:NewRecord(spell, amount, crit, oldAmount)
	callbacks:Fire("NewRecord", spell, amount, crit, oldAmount)
	
	if self.db.profile.chatOutput then
		self:Message(format(L["New %s%s record - %d"], crit and L["critical "] or "", spell, amount))
	end
	
	if self.db.profile.sound then 
		PlaySound("LEVELUP", 1, 1, 0, 1, 3) 
	end
	
	if self.db.profile.screenshot then 
		TakeScreenshot() 
	end
end


-- return spell table from database, given tree, spell name and isPeriodic value
function Critline:GetSpellInfo(tree, spellName, periodic)
	for i, v in ipairs(self.percharDB.profile.spells[tree]) do
		if v.spellName == spellName and v.isPeriodic == periodic then
			return v, i
		end
	end
end


function Critline:GetFullSpellName(tree, spellName, isPeriodic)
	local suffix = ""
	if isPeriodic then
		if tree == "heal" then
			suffix = L[" (HoT)"]
		else
			suffix = L[" (DoT)"]
		end
	end
	return format("%s%s", spellName, suffix)
end


function Critline:GetFullTargetName(spell)
	local suffix = ""
	if spell.isPvPTarget then
		suffix = format(" (%s)", PVP)
	end
	return format("%s%s", spell.target, suffix)
end


-- retrieves the top, non filtered record amounts and spell names for a given tree
function Critline:GetHighest(tree)
	local normalRecord, critRecord = 0, 0
	local normalSpell, critSpell
	
	for _, data in ipairs(self.percharDB.profile.spells[tree]) do
		if not (self.filters and self.filters:IsFilteredSpell(tree, data.spellName, data.isPeriodic)) then
			local normal = data.normal
			if normal and normal.amount > normalRecord then
				normalRecord = normal.amount
				normalSpell = data.spellName
			end
			local crit = data.crit
			if crit and crit.amount > critRecord then
				critRecord = crit.amount
				critSpell = data.spellName
			end
		end
	end
	return normalRecord, critRecord, normalSpell, critSpell
end


function Critline:AddSpell(tree, spell)
	local spells = self.percharDB.profile.spells[tree]
	tinsert(spells, spell)
	sort(spells, recordSorters.alpha)
end


function Critline:DeleteSpell(tree, index)
	tremove(self.percharDB.profile.spells[tree], index)
end


-- this "fires" when spells are added to/removed from the database
function Critline:UpdateSpells(tree)
	if tree then
		self:UpdateTooltip(tree)
		callbacks:Fire("SpellsChanged", tree)
	else
		for k in pairs(tooltips) do
			self:UpdateSpells(k)
		end
	end
end


-- this "fires" when a new record has been registered
function Critline:UpdateRecords(tree, isFiltered)
	if tree then
		self:UpdateTooltip(tree)
		callbacks:Fire("RecordsChanged", tree, isFiltered)
	else
		for k in pairs(tooltips) do
			self:UpdateRecords(k, isFiltered)
		end
	end
end


function Critline:ShowTooltip(tree)
	GameTooltip:AddLine("Critline "..treeNames[tree], HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
	for i, v in ipairs(tooltips[tree]) do
		local left, right = v:match("(.+)\t(.+)")
		if left and right then
			GameTooltip:AddDoubleLine(left, right)
		else
			GameTooltip:AddLine(v)
		end
	end
	GameTooltip:Show()
end


function Critline:UpdateTooltips()
	for k in pairs(tooltips) do
		self:UpdateTooltip(k)
	end
end


local sortedSpells = {}

function Critline:UpdateTooltip(tree)
	local line = "   |cffc0c0c0%s:|r %s\t%s (%s)"
	
	wipe(sortedSpells)
	
	local n = 1
	
	for i, v in ipairs(self.percharDB.profile.spells[tree]) do
		if (v.normal or v.crit) and not (self.filters and self.filters:IsFilteredSpell(tree, v.spellName, v.isPeriodic)) then
			sortedSpells[n] = {
				spellName = v.spellName,
				isPeriodic = v.isPeriodic,
				normal = v.normal,
				crit = v.crit,
			}
			n = n + 1
		end
	end
	
	sort(sortedSpells, recordSorters[self.db.profile.tooltipSort])
	
	local tooltip = tooltips[tree]
	wipe(tooltip)
	
	local normalRecord, critRecord = self:GetHighest(tree)
	n = 1
	
	for _, v in ipairs(sortedSpells) do
		-- if this is a DoT/HoT, and a direct entry exists, add the proper suffix
		if v.isPeriodic then
			for _, v2 in ipairs(sortedSpells) do
				if v2.spellName == v.spellName and not v2.isPeriodic then
					v.spellName = self:GetFullSpellName(tree, v.spellName, true)
					break
				end
			end
		end
		
		local normalAmount, critAmount = HIGHLIGHT_FONT_COLOR_CODE..(0)..FONT_COLOR_CODE_CLOSE, HIGHLIGHT_FONT_COLOR_CODE..(0)..FONT_COLOR_CODE_CLOSE
		
		-- color the top score amount green
		local normal = v.normal
		if normal then
			normalAmount = (normal.amount == normalRecord and GREEN_FONT_COLOR_CODE or HIGHLIGHT_FONT_COLOR_CODE)..normal.amount..FONT_COLOR_CODE_CLOSE
		end
		
		local crit = v.crit
		if crit then
			critAmount = (crit.amount == critRecord and GREEN_FONT_COLOR_CODE or HIGHLIGHT_FONT_COLOR_CODE)..crit.amount..FONT_COLOR_CODE_CLOSE
		end
		
		if self.db.profile.detailedTooltip then
			tooltip[n] = v.spellName
			if normal then
				n = n + 1
				local target = HIGHLIGHT_FONT_COLOR_CODE..self:GetFullTargetName(normal)..FONT_COLOR_CODE_CLOSE
				local level = (normal.targetLevel > 0) and normal.targetLevel or "??"
				tooltip[n] = format(line, L["Normal"], normalAmount, target, level)
			end
			if crit then
				n = n + 1
				local target = HIGHLIGHT_FONT_COLOR_CODE..self:GetFullTargetName(crit)..FONT_COLOR_CODE_CLOSE
				local level = (crit.targetLevel > 0) and crit.targetLevel or "??"
				tooltip[n] = format(line, L["Crit"], critAmount, target, level)
			end
		else
			tooltip[n] = format("%s\t%s%s", v.spellName, normalAmount, (crit and "/"..critAmount or ""))
		end
		
		n = n + 1
	end
	
	if #tooltip == 0 then
		tooltip[1] = L["No records"]
	end
end