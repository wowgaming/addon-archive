local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local templates = addon.templates

local CombatLog_Object_IsA = CombatLog_Object_IsA

local COMBATLOG_FILTER_ME = COMBATLOG_FILTER_ME

-- amount of buttons in the spell, mob and aura filter scroll lists
local NUMSPELLBUTTONS = 8
local SPELLBUTTONHEIGHT = 22
local NUMFILTERBUTTONS = 10
local FILTERBUTTONHEIGHT = 16

-- mobs whose received hits won't be tracked due to various vulnerabilities
local specialMobs = {
	[12460] = true,	-- Death Talon Wyrmguard
	[12461] = true,	-- Death Talon Overseer
	[14020] = true,	-- Chromaggus
	[15339] = true,	-- Ossirian the Unscarred
	[15928] = true,	-- Thaddius
	[16803] = true, -- Death Knight Understudy
	[22841] = true,	-- Shade of Akama
	[33329] = true, -- Heart of the Deconstructor
	[33670] = true, -- Aerial Command Unit
	[34496] = true, -- Eydis Darkbane
	[34497] = true, -- Fjola Lightbane
	[34797] = true, -- Icehowl
	[38567] = true, -- Phantom Hallucination
}

-- auras that when gained will suppress record tracking
local specialAuras = {
	[18173] = true,	-- Burning Adrenaline (Vaelastrasz the Corrupt)
	[41337] = true,	-- Aura of Anger (Reliquary of Souls)
	[41350] = true,	-- Aura of Desire (Reliquary of Souls)
	[44335] = true,	-- Energy Feedback (Vexallus)
	[44406] = true,	-- Energy Infusion (Vexallus)
	[53642] = true,	-- Might of Mograine (Light's Hope Chapel)
	[55849] = true,	-- Power Spark (Malygos)
	[56330] = true,	-- Iron's Bane (Storm Peaks quest)
	[56648] = true,	-- Potent Fungus (Amanitar)
	[57524] = true, -- Metanoia (Valkyrion Aspirant)
	[58026] = true,	-- Blessing of the Crusade (Icecrown quest)
	[58361] = true,	-- Might of Mograine (Patchwerk)
	[58549] = true,	-- Tenacity (Lake Wintergrasp)
	[59641] = true,	-- Warchief's Blessing (The Battle For The Undercity)
	[60964] = true,	-- Strength of Wrynn (The Battle For The Undercity)
	[61888] = true, -- Overwhelming Power (Assembly of Iron - 10 man hard mode)
	[62243] = true, -- Unstable Sun Beam (Elder Brightleaf)
	[62650] = true, -- Fortitude of Frost (Yogg-Saron)
	[62670] = true, -- Resilience of Nature (Yogg-Saron)
	[62671] = true, -- Speed of Invention (Yogg-Saron)
	[62702] = true, -- Fury of the Storm (Yogg-Saron)
	[63277] = true, -- Shadow Crash (General Vezax)
	[63711] = true, -- Storm Power (Hodir 10 man)
	[64320] = true, -- Rune of Power (Assembly of Iron)
	[64321] = true, -- Potent Pheromones (Freya)
	[64637] = true, -- Overwhelming Power (Assembly of Iron - 25 man hard mode)
	[65134] = true, -- Storm Power (Hodir 25 man)
	[70867] = true, -- Essence of the Blood Queen (Blood Queen Lana'thel)
	[70879] = true, -- Essence of the Blood Queen (Blood Queen Lana'thel, bitten by a player)
	[72219] = true, -- Gastric Bloat (Festergut)
}

-- these heals are treated as periodic, but has no aura associated with them, or is associated to an aura with a different name, need to add exceptions for them to filter properly
local directHoTs = {
	[54172] = true, -- Divine Storm
	-- [63106] = "Corruption", -- Siphon Life
}

local activeAuras = {}
local corruptSpells = {}


local function filterButtonOnClick(self)
	local module = self.module
	local scrollFrame = module.scrollFrame
	local offset = FauxScrollFrame_GetOffset(scrollFrame)
	local id = self:GetID()
	
	local selection = scrollFrame.selected
	if selection then
		if selection - offset == id then
			-- clicking the selected button, clear selection
			self:UnlockHighlight()
			selection = nil
		else
			-- clear selection if visible, and set new selection
			local prevHilite = scrollFrame.buttons[selection - offset]
			if prevHilite then
				prevHilite:UnlockHighlight()
			end
			self:LockHighlight()
			selection = id + offset
		end
	else
		-- no previous selection, just set new and lock highlight
		self:LockHighlight()
		selection = id + offset
	end
	
	-- enable/disable "Delete" button depending on if selection exists
	if selection then
		module.delete:Enable()
	else
		module.delete:Disable()
	end
	scrollFrame.selected = selection
end

-- template function for mob filter buttons
local function createFilterButton(parent)
	local btn = CreateFrame("Button", nil, parent)
	btn:SetHeight(FILTERBUTTONHEIGHT)
	btn:SetPoint("LEFT")
	btn:SetPoint("RIGHT")
	btn:SetNormalFontObject("GameFontNormal")
	btn:SetHighlightFontObject("GameFontHighlight")
	btn:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	btn:SetPushedTextOffset(0, 0)
	btn:SetScript("OnClick", filterButtonOnClick)
	return btn
end

local function createFilterButtons(parent, onEnter)
	local buttons = {}
	for i = 1, NUMFILTERBUTTONS do
		local btn = createFilterButton(parent)
		if i == 1 then
			btn:SetPoint("TOP")
		else
			btn:SetPoint("TOP", buttons[i - 1], "BOTTOM")
		end
		btn:SetID(i)
		if onEnter then
			btn:SetScript("OnEnter", onEnter)
			btn:SetScript("OnLeave", GameTooltip_Hide)
		end
		btn.module = parent
		buttons[i] = btn
	end
	parent.scrollFrame.buttons = buttons
end

local function resetScroll(self)
	FauxScrollFrame_SetOffset(self, 0)
	self.scrollBar:SetValue(0)
	self:Update()
end

local function onVerticalScroll(self, offset)
	FauxScrollFrame_OnVerticalScroll(self, offset, self.buttonHeight, self.Update)
end

local function filterFrameOnShow(self)
	local scrollFrame = self.scrollFrame
	if scrollFrame.selected then
		local prevHilite = scrollFrame.buttons[scrollFrame.selected - FauxScrollFrame_GetOffset(scrollFrame)]
		if prevHilite then
			prevHilite:UnlockHighlight()
		end
		scrollFrame.selected = nil
		self.delete:Disable()
	end
end

local function addButtonOnClick(self)
	StaticPopup_Show(self.popup)
end

local function deleteButtonOnClick(self)
	local scrollFrame = self.scrollFrame
	local filterName = scrollFrame.filter
	local selection = scrollFrame.selected
	if selection then
		local filter = self.filters.db.global[filterName]
		local selectedEntry = filter[selection]
		tremove(filter, selection)
		local prevHighlight = scrollFrame.buttons[selection - FauxScrollFrame_GetOffset(scrollFrame)]
		if prevHighlight then
			prevHighlight:UnlockHighlight()
		end
		scrollFrame.selected = nil
		scrollFrame:Update()
		self:Disable()
		addon:Message(self.msg:format(GetSpellInfo(selectedEntry) or selectedEntry))
		if self.func then
			self.func(selectedEntry)
		end
	end
end

local function createFilterFrame(name, parent, numButtons, buttonHeight)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetHeight(numButtons * buttonHeight)
	parent[name] = frame

	local scrollName = "CritlineFilters"..name.."ScrollFrame"
	local scrollFrame = CreateFrame("ScrollFrame", scrollName, frame, "FauxScrollFrameTemplate")
	scrollFrame:SetAllPoints()
	scrollFrame:SetScript("OnShow", resetScroll)
	scrollFrame:SetScript("OnVerticalScroll", onVerticalScroll)
	scrollFrame.scrollBar = _G[scrollName.."ScrollBar"]
	scrollFrame.buttons = frame.buttons
	scrollFrame.numButtons = numButtons
	scrollFrame.buttonHeight = buttonHeight
	scrollFrame.filter = name
	frame.scrollFrame = scrollFrame
	
	if name ~= "spell" then
		frame:SetScript("OnShow", filterFrameOnShow)

		local add = templates:CreateButton(frame)
		add:SetScript("OnClick", addButtonOnClick)
		frame.add = add

		local delete = templates:CreateButton(frame)
		delete:Disable()
		delete:SetScript("OnClick", deleteButtonOnClick)
		delete.scrollFrame = scrollFrame
		delete.filters = parent
		frame.delete = delete
	end
	
	return frame
end


-- tooltip for level scanning
local tooltip = CreateFrame("GameTooltip", "CritlineTooltip", nil, "GameTooltipTemplate")


local filters = templates:CreateConfigFrame(FILTERS, addonName, true)
addon.filters = filters


do
	local options = {}
	filters.options = options

	local checkButtons = {
		{
			text = L["Invert spell filter"],
			tooltipText = L["Enable to include rather than exclude selected spells in the spell filter."],
			setting = "invertFilter",
			func = function(self) addon:UpdateRecords() end,
		},
		{
			text = L["Ignore mob filter"],
			tooltipText = L["Enable to ignore integrated mob filter."],
			setting = "ignoreMobFilter",
		},
		{
			text = L["Ignore aura filter"],
			tooltipText = L["Enable to ignore integrated aura filter."],
			setting = "ignoreAuraFilter",
		},
		{
			text = L["Only known spells"],
			tooltipText = L["Enable to ignore spells that are not in your (or your pet's) spell book."],
			setting = "onlyKnown",
		},
		{
			text = L["Suppress mind control"],
			tooltipText = L["Suppress all records while mind controlled."],
			setting = "suppressMC",
			newColumn = true,
		},
		{
			text = L["Don't filter magic"],
			tooltipText = L["Enable to let magical damage ignore the level filter."],
			setting = "dontFilterMagic",
		},
	}

	options.checkButtons = checkButtons
	
	local columnEnd = #checkButtons

	for i, v in ipairs(checkButtons) do
		local btn = templates:CreateCheckButton(filters, v)
		if i == 1 then
			btn:SetPoint("TOPLEFT", filters.title, "BOTTOMLEFT", -2, -16)
		elseif btn.newColumn then
			btn:SetPoint("TOPLEFT", filters.title, "BOTTOM", 0, -16)
			columnEnd = i - 1
		else
			btn:SetPoint("TOP", checkButtons[i - 1], "BOTTOM", 0, -8)
		end
		btn.module = filters
		checkButtons[i] = btn
	end
	
	local slider = templates:CreateSlider(filters, {
		text = L["Level filter"],
		tooltipText = L["If level difference between you and the target is greater than this setting, records will not be registered."],
		minValue = -1,
		maxValue = 10,
		valueStep = 1,
		minText = OFF,
		maxText = 10,
		func = function(self)
			local value = self:GetValue()
			self.value:SetText(value == -1 and OFF or value)
			filters.profile.levelFilter = value
		end,
	})
	slider:SetPoint("TOPLEFT", checkButtons[#checkButtons], "BOTTOMLEFT", 4, -24)
	options.slider = slider
	
	local filterTypes = {}

	-- spell filter frame
	local spellFilter = createFilterFrame("spell", filters, NUMSPELLBUTTONS, SPELLBUTTONHEIGHT)
	spellFilter:SetPoint("TOP", checkButtons[columnEnd], "BOTTOM", 0, -48)
	spellFilter:SetPoint("LEFT", 48, 0)
	spellFilter:SetPoint("RIGHT", -48, 0)
	filterTypes.spell = spellFilter

	do	-- spell filter buttons
		local function spellButtonOnClick(self)
			local module = self.module
			if self:GetChecked() then
				PlaySound("igMainMenuOptionCheckBoxOn")
				module:AddSpell(module.spell.tree:GetSelectedValue(), self.spell, self.isPeriodic)
			else
				PlaySound("igMainMenuOptionCheckBoxOff")
				module:DeleteSpell(module.spell.tree:GetSelectedValue(), self.spell, self.isPeriodic)
			end
		end
		
		local buttons = {}
		for i = 1, NUMSPELLBUTTONS do
			local btn = templates:CreateCheckButton(spellFilter)
			if i == 1 then
				btn:SetPoint("TOPLEFT")
			else
				btn:SetPoint("TOP", buttons[i - 1], "BOTTOM", 0, 4)
			end
			btn:SetScript("OnClick", spellButtonOnClick)
			btn.module = filters
			buttons[i] = btn
		end
		spellFilter.scrollFrame.buttons = buttons
	end
	
	-- spell filter scroll frame
	local spellScrollFrame = spellFilter.scrollFrame

	-- spell filter tree dropdown
	local menu = {
		onClick = function(self)
			self.owner:SetSelectedValue(self.value)
			FauxScrollFrame_SetOffset(spellScrollFrame, 0)
			spellScrollFrame.scrollBar:SetValue(0)
			spellScrollFrame:Update()
		end,
		{text = L["Damage"],	value = "dmg"},
		{text = L["Healing"],	value = "heal"},
		{text = L["Pet"],		value = "pet"},
	}

	local spellFilterTree = templates:CreateDropDownMenu("CritlineSpellFilterTree", spellFilter, menu)
	spellFilterTree:SetFrameWidth(120)
	spellFilterTree:SetPoint("BOTTOMRIGHT", spellFilter, "TOPRIGHT", 16, 0)
	spellFilterTree:SetSelectedValue("dmg")
	spellFilter.tree = spellFilterTree
	spellScrollFrame.tree = spellFilter.tree
	
	do	-- mob filter frame
		local mobFilter = createFilterFrame("mobs", filters, NUMFILTERBUTTONS, FILTERBUTTONHEIGHT)
		mobFilter:SetPoint("TOP", spellFilter)
		mobFilter:SetPoint("LEFT", spellFilter)
		mobFilter:SetPoint("RIGHT", spellFilter)
		mobFilter:Hide()
		filterTypes.mobs = mobFilter
		
		createFilterButtons(mobFilter)
		
		local addTarget = templates:CreateButton(mobFilter)
		addTarget:SetSize(96, 22)
		addTarget:SetPoint("TOPLEFT", mobFilter, "BOTTOMLEFT", 0, -8)
		addTarget:SetText(L["Add target"])
		addTarget:SetScript("OnClick", function()
			local targetName = UnitName("target")
			if targetName then
				-- we don't want to add PCs to the filter
				if UnitIsPlayer("target") then
					addon:Message(L["Cannot add players to mob filter."])
				else
					filters:AddMob(targetName)
				end
			else
				addon:Message(L["No target selected."])
			end
		end)
		
		local add = mobFilter.add
		add:SetSize(96, 22)
		add:SetPoint("TOP", mobFilter, "BOTTOM", 0, -8)
		add:SetText(L["Add by name"])
		add.popup = "CRITLINE_ADD_MOB_BY_NAME"
		
		local delete = mobFilter.delete
		delete:SetSize(96, 22)
		delete:SetPoint("TOPRIGHT", mobFilter, "BOTTOMRIGHT", 0, -8)
		delete:SetText(L["Delete mob"])
		delete.msg = L["%s removed from mob filter."]
	end
	
	do	-- aura filter frame
		local auraFilter = createFilterFrame("auras", filters, NUMFILTERBUTTONS, FILTERBUTTONHEIGHT)
		auraFilter:SetPoint("TOP", spellFilter)
		auraFilter:SetPoint("LEFT", spellFilter)
		auraFilter:SetPoint("RIGHT", spellFilter)
		auraFilter:Hide()
		filterTypes.auras = auraFilter

		createFilterButtons(auraFilter, function(self)
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
			GameTooltip:SetHyperlink("spell:"..self.spellID)
		end)
		
		local add = auraFilter.add
		add:SetSize(128, 22)
		add:SetPoint("TOPLEFT", auraFilter, "BOTTOMLEFT", 0, -8)
		add:SetText(L["Add by spell ID"])
		add.popup = "CRITLINE_ADD_AURA_BY_ID"

		local delete = auraFilter.delete
		delete:SetSize(128, 22)
		delete:SetPoint("TOPRIGHT", auraFilter, "BOTTOMRIGHT", 0, -8)
		delete:SetText(L["Delete aura"])
		delete.msg = L["%s removed from aura filter."]
		delete.func = function(spellID)
			activeAuras[spellID] = nil
			if not filters:IsEmpowered() then
				addon:Debug("No filtered aura detected. Resuming record tracking.")
			end
		end
	end
	
	do	-- filter tree dropdown
		local menu = {
			onClick = function(self)
				self.owner:SetSelectedValue(self.value)
				for k, v in pairs(filterTypes) do
					if k == self.value then
						v:Show()
					else
						v:Hide()
					end
				end
			end,
			{
				text = L["Spell filter"],
				value = "spell",
			},
			{
				text = L["Mob filter"],
				value = "mobs",
			},
			{
				text = L["Aura filter"],
				value = "auras",
			},
		}
		
		local filterType = templates:CreateDropDownMenu("CritlineFilterType", filters, menu)
		filterType:SetPoint("BOTTOMLEFT", spellFilter, "TOPLEFT", -16, 0)
		filterType:SetFrameWidth(120)
		filterType:SetSelectedValue("spell")
		filters.type = filterType
	end
end


StaticPopupDialogs["CRITLINE_ADD_MOB_BY_NAME"] = {
	text = L["Enter mob name:"],
	button1 = OKAY,
	button2 = CANCEL,
	hasEditBox = true,
	OnAccept = function(self)
		local name = self.editBox:GetText():trim()
		if not name:match("%S+") then
			addon:Message(L["Invalid mob name."])
			return
		end
		filters:AddMob(name)
	end,
	EditBoxOnEnterPressed = function(self)
		local name = self:GetText():trim()
		if not name:match("%S+") then
			addon:Message(L["Invalid mob name."])
			return
		end
		filters:AddMob(name)
		self:GetParent():Hide()
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end,
	OnShow = function(self)
		self.editBox:SetFocus()
	end,
	whileDead = true,
	timeout = 0,
}

StaticPopupDialogs["CRITLINE_ADD_AURA_BY_ID"] = {
	text = L["Enter spell ID:"],
	button1 = OKAY,
	button2 = CANCEL,
	hasEditBox = true,
	OnAccept = function(self)
		local id = tonumber(self.editBox:GetText())
		if not id then
			addon:Message(L["Invalid input. Please enter a spell ID."])
			return
		elseif not GetSpellInfo(id) then
			addon:Message(L["Invalid spell ID. No such spell."])
			return
		end
		filters:AddAura(id)
	end,
	EditBoxOnEnterPressed = function(self)
		local id = tonumber(self:GetText())
		if not id then
			addon:Message(L["Invalid input. Please enter a spell ID."])
			return
		elseif not GetSpellInfo(id) then
			addon:Message(L["Invalid spell ID. No such spell exists."])
			return
		end
		filters:AddAura(id)
		self:GetParent():Hide()
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end,
	OnShow = function(self)
		self.editBox:SetFocus()
	end,
	whileDead = true,
	timeout = 0,
}


local function updateSpellFilter(self)
	local selectedTree = self.tree:GetSelectedValue()
	local spells = addon.percharDB.profile.spells[selectedTree]
	local size = #spells
	
	FauxScrollFrame_Update(self, size, self.numButtons, self.buttonHeight)
	
	local offset = FauxScrollFrame_GetOffset(self)
	local buttons = self.buttons
	for line = 1, NUMSPELLBUTTONS do
		local button = buttons[line]
		local lineplusoffset = line + offset
		if lineplusoffset <= size then
			local data = spells[lineplusoffset]
			button.spell = data.spellName
			button.isPeriodic = data.isPeriodic
			button:SetText(addon:GetFullSpellName(selectedTree, data.spellName, data.isPeriodic))
			button:SetChecked(data.filtered)
			button:Show()
		else
			button:Hide()
		end
	end
end

local function updateFilter(self)
	local filter = filters.db.global[self.filter]
	local size = #filter
	
	FauxScrollFrame_Update(self, size, self.numButtons, self.buttonHeight)
	
	local offset = FauxScrollFrame_GetOffset(self)
	local buttons = self.buttons
	for line = 1, self.numButtons do
		local button = buttons[line]
		local lineplusoffset = line + offset
		if lineplusoffset <= size then
			if self.selected then
				if self.selected - offset == line then
					button:LockHighlight()
				else
					button:UnlockHighlight()
				end
			end
			local entry = filter[lineplusoffset]
			button.spellID = entry
			button:SetText(type(entry) == "number" and GetSpellInfo(entry) or entry)
			button:Show()
		else
			button:Hide()
		end
	end
end


local defaults = {
	profile = {
		invertFilter = false,
		ignoreMobFilter = false,
		ignoreAuraFilter = false,
		onlyKnown = false,
		suppressMC = true,
		dontFilterMagic = false,
		levelFilter = -1,
	},
	global = {
		mobs = {},
		auras = {},
	},
}

function filters:AddonLoaded()
	self.db = addon.db:RegisterNamespace("filters", defaults)
	addon.RegisterCallback(self, "SettingsLoaded", "LoadSettings")
	addon.RegisterCallback(self, "PerCharSettingsLoaded", "UpdateSpellFilter")
	addon.RegisterCallback(self, "SpellsChanged", "UpdateSpellFilter")
	
	-- mix in scroll frame update functions
	self.spell.scrollFrame.Update = updateSpellFilter
	self.mobs.scrollFrame.Update = updateFilter
	self.auras.scrollFrame.Update = updateFilter
end

addon.RegisterCallback(filters, "AddonLoaded")


function filters:LoadSettings()
	self.profile = self.db.profile
	
	for _, v in ipairs(self.options.checkButtons) do
		v:LoadSetting()
	end
	
	self.options.slider:SetValue(self.profile.levelFilter)
end


do
	local spellButton_OnModifiedClick = SpellButton_OnModifiedClick

	function SpellButton_OnModifiedClick(self, button, ...)
		if IsShiftKeyDown() and filters.spell:IsVisible() and filters:GetParent() then
			local spellID = SpellBook_GetSpellID(self:GetID())
			if spellID > MAX_SPELLS then
				return
			end
			filters:AddSpell(filters.spell.tree:GetSelectedValue(), (GetSpellName(spellID, SpellBookFrame.bookType)))
			return
		end
		return spellButton_OnModifiedClick(self, button, ...)
	end

	local function onClick(self, button)
		BuffButton_OnClick(self, button)
	end
	
	-- debuff buttons needs to have an onClick handler, and both buff and debuff buttons needs to monitor left clicks
	hooksecurefunc("AuraButton_Update", function(buttonName, index, filter)
		local name = UnitAura("player", index, filter)
		if name then
			local buff = _G[buttonName..index]
			if buff and not buff.Critline then
				buff:RegisterForClicks("AnyUp")
				if not buff:HasScript("OnClick") then
					buff:SetScript("OnClick", onClick)
				end
				buff.Critline = true
			end
		end
	end)

	function BuffButton_OnClick(self, button)
		if button == "LeftButton" and IsShiftKeyDown() and filters.auras:IsVisible() and filters:GetParent() then
			filters:AddAura(select(11, UnitAura(self.unit, self:GetID(), self.filter)))
		elseif button == "RightButton" and self.filter == "HELPFUL" then
			CancelUnitBuff(self.unit, self:GetID(), self.filter)
		end
	end
end


function filters:UpdateSpellFilter()
	self.spell.scrollFrame:Update()
end


function filters:UpdateFilter()
	self[self.type:GetSelectedValue()].scrollFrame:Update()
end


function filters:AddSpell(tree, spell, isPeriodic)
	local data = addon:GetSpellInfo(tree, spell, isPeriodic)
	if not data then
		addon:AddSpell(tree, {
			spellName = spell,
			isPeriodic = isPeriodic,
			filtered = true,
		})
		self:UpdateSpellFilter()
		return
	end
	data.filtered = true
	addon:UpdateRecords(tree)
end


function filters:DeleteSpell(tree, spell, isPeriodic)
	local data, index = addon:GetSpellInfo(tree, spell, isPeriodic)
	if not (data.normal or data.crit) then
		addon:DeleteSpell(tree, index)
		self:UpdateSpellFilter()
		return
	end
	data.filtered = nil
	addon:UpdateRecords(tree)
end


function filters:AddMob(name)
	if self:IsFilteredMob(name) then
		addon:Message(L["%s is already in mob filter."]:format(name))
	else
		tinsert(self.db.global.mobs, name)
		self:UpdateFilter()
		addon:Message(L["%s added to mob filter."]:format(name))
	end
end


function filters:AddAura(spellID)
	local spellName = GetSpellInfo(spellID)
	if self:IsFilteredAura(spellID) then
		addon:Message(L["%s is already in aura filter."]:format(spellName))
	else
		tinsert(self.db.global.auras, spellID)
		-- after we add an aura to the filter; check if we have it
		for i = 1, 40 do
			local buffID = select(11, UnitBuff("player", i))
			local debuffID = select(11, UnitDebuff("player", i))
			if not (buffID or debuffID) then
				break
			else
				for _, v in ipairs(self.db.global.auras) do
					if v == buffID then
						activeAuras[buffID] = true
						break
					elseif v == debuffID then
						activeAuras[debuffID] = true
						break
					end
				end
			end
		end
		self:UpdateFilter()
		addon:Message(L["%s added to aura filter."]:format(spellName))
	end
end


function filters:IsAuraEvent(eventType, spellID, sourceFlags, destFlags, destGUID)
	if eventType == "SPELL_AURA_APPLIED" or eventType == "SPELL_AURA_REFRESH" then
		if CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_ME) and self:IsFilteredAura(spellID) then
			-- if we gain any aura in the filter we can just stop tracking records
			if not (self:IsEmpowered() or self.profile.ignoreAuraFilter) then
				addon:Debug("Filtered aura gained. Disabling combat log tracking.")
			end
			activeAuras[spellID] = true
		elseif CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_ME) then
			corruptSpells[spellID] = corruptSpells[spellID] or {}
			corruptSpells[spellID][destGUID] = self:IsEmpowered()
		end
		return true
	elseif (eventType == "SPELL_AURA_REMOVED" or eventType == "SPELL_AURA_BROKEN" or eventType == "SPELL_AURA_BROKEN_SPELL" or eventType == "SPELL_AURA_STOLEN") then
		if CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_ME) and self:IsFilteredAura(spellID) then
			-- if we lost a special aura we have to check if any other filtered auras remain
			activeAuras[spellID] = nil
			if not filters:IsEmpowered() then
				addon:Debug("No filtered aura detected. Resuming record tracking.")
			end
		-- elseif CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_ME) then
			-- corruptSpells[spellID] = corruptSpells[spellID] or {}
			-- corruptSpells[spellID][destGUID] = nil
		end
		return true
	end
end


-- check if a spell passes the filter settings
function filters:SpellPassesFilters(tree, spellName, spellID, isPeriodic, destGUID, destName, school)
	if spellID and not IsSpellKnown(spellID, tree == "pet") and self.profile.onlyKnown then
		addon:Debug(format("%s is not in your%s spell book. Return.", spellName, tree == "pet" and " pet's" or ""))
		return
	end
	
	if ((corruptSpells[spellID] and corruptSpells[spellID][destGUID]) or (self:IsEmpowered() and (not isPeriodic or directHoTs[spellID]))) and not self.profile.ignoreAuraFilter then
		addon:Debug(format("Spell (%s) was cast under the influence of a filtered aura. Return.", spellName))
		return
	end
	
	local targetLevel = self:GetLevelFromGUID(destGUID)
	local levelDiff = 0
	if (targetLevel > 0) and (targetLevel < UnitLevel("player")) then
		levelDiff = (UnitLevel("player") - targetLevel)
	end
	
	-- ignore level adjustment if magic damage and the setting is enabled
	if not isHeal and (self.profile.levelFilter >= 0) and (self.profile.levelFilter < levelDiff) and (school == 1 or not self.profile.dontFilterMagic) then
		-- target level is too low to pass level filter
		addon:Debug(format("Target (%s) level too low (%d) and damage school is filtered. Return.", destName, targetLevel))
		return
	end
	
	if self:IsFilteredMob(destName, destGUID) then
		return
	end
	
	return true, self:IsFilteredSpell(tree, spellName, isPeriodic), targetLevel
end


-- check if a spell passes the filters depending on inverted setting
function filters:IsFilteredSpell(tree, spellName, periodic)
	local spell = addon:GetSpellInfo(tree, spellName, periodic)
	return ((spell and spell.filtered) ~= nil) ~= self.db.profile.invertFilter
end


-- scan for filtered auras from the specialAuras table
function filters:IsEmpowered()
	if next(activeAuras) or not self.inControl then
		return true
	end
end


function filters:IsFilteredMob(mobName, GUID)
	-- GUID is provided if the function was called from the combat event handler
	if GUID and not self.profile.ignoreMobFilter then
		if specialMobs[tonumber(GUID:sub(6, 12), 16)] then
			addon:Debug("Mob ("..mobName..") is in integrated filter.")
			return true
		end
	end
	for _, v in ipairs(self.db.global.mobs) do
		if v:lower() == mobName:lower() then
			addon:Debug("Mob ("..mobName..") is in custom filter.")
			return true
		end
	end
end


function filters:IsFilteredAura(spellID)
	if specialAuras[spellID] then
		addon:Debug("Aura ("..GetSpellInfo(spellID)..") is in integrated filter.")
		return true
	end
	for _, v in ipairs(self.db.global.auras) do
		if v == spellID then
			addon:Debug("Aura ("..GetSpellInfo(spellID)..") is in custom filter.")
			return true
		end
	end
end


function filters:GetLevelFromGUID(destGUID)
	tooltip:SetOwner(UIParent, "ANCHOR_NONE")
	tooltip:SetHyperlink("unit:"..destGUID)
	
	local level = -1
	
	for i = 1, tooltip:NumLines() do
		local text = _G["CritlineTooltipTextLeft"..i]:GetText()
		if text then
			if text:match(LEVEL) then -- our destGUID has the word Level in it.
				level = text:match("(%d+)")  -- find the level
				if level then  -- if we found the level, break from the for loop
					level = tonumber(level)
				else
					-- well, the word Level is in this tooltip, but we could not find the level
					-- either the destGUID is at least 10 levels higher than us, or we just couldn't find it.
					level = -1
				end
			end
		end
	end	
	return level
end


addon:RegisterEvent("PLAYER_LOGIN")
addon:RegisterEvent("PLAYER_CONTROL_LOST")
addon:RegisterEvent("PLAYER_CONTROL_GAINED")

function addon:PLAYER_LOGIN()
	for i = 1, 40 do
		local buffID = select(11, UnitBuff("player", i))
		local debuffID = select(11, UnitDebuff("player", i))
		if not (buffID or debuffID) then
			break
		elseif specialAuras[buffID] then
			activeAuras[buffID] = true
		elseif specialAuras[debuffID] then
			activeAuras[debuffID] = true
		else
			for _, v in ipairs(filters.db.global.auras) do
				if v == buffID then
					activeAuras[buffID] = true
					break
				elseif v == debuffID then
					activeAuras[debuffID] = true
					break
				end
			end
		end
	end
	if next(activeAuras) then
		addon:Debug("Filtered aura detected. Disabling combat log tracking.")
	end
	filters.inControl = HasFullControl()
	if not filters.inControl then
		self:Debug("Lost control. Disabling combat log tracking.")
	end
end


function addon:PLAYER_CONTROL_LOST()
	filters.inControl = false
	self:Debug("Lost control. Disabling combat log tracking.")
end


function addon:PLAYER_CONTROL_GAINED()
	filters.inControl = true
	self:Debug("Regained control. Resuming combat log tracking.")
end