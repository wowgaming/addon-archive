-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

local init_done, gradient, conf, doneOptions
local errorCount = 0
XPerl_RequestConfig(function(new) conf = new end, "$Revision: 396 $")

local classOrder = {"WARRIOR", "DEATHKNIGHT", "ROGUE", "HUNTER", "DRUID", "SHAMAN", "PALADIN", "PRIEST", "MAGE", "WARLOCK"}

-- SetTex
local highlightPositions = {	{0, 0.25, 0, 0.5},
				{0.25, 0.75, 0, 0.5},
				{0, 1, 0.5, 1},
				{0.75, 1, 0, 0.5}}
local function SetTex(self, num)
	local p = highlightPositions[num]
	if ((self.GetFrameType or self.GetObjectType)(self) == "Button") then
		if (conf.highlightSelection == 1) then
			self:SetHighlightTexture("Interface\\Addons\\XPerl\\images\\XPerl_Highlight", "ADD")
			local tex = self:GetHighlightTexture()
			tex:SetTexCoord(unpack(p))
			tex:SetVertexColor(0.86, 0.82, 0.41)
		else
			self:SetHighlightTexture("")
		end

	elseif ((self.GetFrameType or self.GetObjectType)(self) == "Frame") then
		if (self.tex) then
			self.tex:SetTexture("Interface\\Addons\\XPerl\\images\\XPerl_Highlight", "ADD")
			self.tex:SetTexCoord(unpack(p))
			self.tex:SetVertexColor(0.86, 0.82, 0.41)
			XPerl_Highlight:SetHighlight(self:GetParent())
		end
	end
end

-- RegisterHighlight
local HighlightFrames = {}
function XPerl_RegisterHighlight(frame, ratio)
	HighlightFrames[frame] = ratio
	if (init_done) then
		SetTex(frame, ratio)
	end
end

-- XPerl_SetHighlights
function XPerl_SetHighlights()
	for k,v in pairs(HighlightFrames) do
		SetTex(k, v)
	end
end

-- XPerl_MakeGradient(self)
function XPerl_DoGradient(self, force)
	if ((force or (conf and conf.colour.gradient.enable)) and not self.tfade) then
		if (gradient) then
			if (not self.gradient) then
				local w = self:GetWidth()
				if (w and w > 10) then
					self.gradient = self:CreateTexture(nil, "BORDER")
					self.gradient:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
					self.gradient:SetBlendMode("ADD")

					local bd = self:GetBackdrop()

					if (bd) then
						self.gradient:SetPoint("TOPLEFT", bd.insets.left, -bd.insets.top)
						self.gradient:SetPoint("BOTTOMRIGHT", -bd.insets.right, bd.insets.bottom)
					else
						self.gradient:SetAllPoints()
					end
				end
			end
			if (self.gradient) then
				self.gradient:Show()
				self.gradient:SetGradientAlpha(unpack(gradient))
			end
			return true
		end
	else
		if (self.gradient) then
			self.gradient:Hide()
		end
	end
end

-- SetupUnitFrame
local function SetupUnitFrame(self)
	self:SetBackdropBorderColor(conf.colour.border.r, conf.colour.border.g, conf.colour.border.b, conf.colour.border.a)
	self:SetBackdropColor(conf.colour.frame.r, conf.colour.frame.g, conf.colour.frame.b, conf.colour.frame.a)
	XPerl_DoGradient(self)
end

-- SetupUnitFrameList
local function SetupUnitFrameList(frame, subList)

	if (conf.colour.gradient.enable) then
		local o
		if (conf.colour.gradient.horizontal) then
			o = "HORIZONTAL"
		else
			o = "VERTICAL"
		end

		gradient = {o, conf.colour.gradient.e.r, conf.colour.gradient.e.g, conf.colour.gradient.e.b, conf.colour.gradient.e.a,
				conf.colour.gradient.s.r, conf.colour.gradient.s.g, conf.colour.gradient.s.b, conf.colour.gradient.s.a}
	end

	if (type(subList) == "table") then
		frame:SetAlpha(conf.transparency.frame)
		for k,v in pairs(subList) do
			SetupUnitFrame(v)
		end
	else
		SetupUnitFrame(frame)
	end
end

-- XPerl_RegisterUnitFrame(frame)
local UnitFrames = {}
function XPerl_RegisterPerlFrames(frame, subList)
	if (not subList) then
		subList = true
	end
	UnitFrames[frame] = subList

	if (init_done) then
		SetupUnitFrameList(frame, subList)
	end
end

-- XPerl_SetupAllPerlFrames
function XPerl_SetupAllPerlFrames(frame)
	for k,v in pairs(UnitFrames) do
		SetupUnitFrameList(k, v)
	end
end

-- XPerl_SetAllFrames
function XPerl_SetAllFrames()
	XPerl_SetupAllPerlFrames()
	XPerl_SetHighlights()
end

-- XPerl_pcall
function XPerl_pcall(...)
	local success, error = pcall(...)
	if (not success) then
		errorCount = errorCount + 1
		if (not doneOptions) then
			XPerl_Notice("Error:"..error)
		end
		geterrorhandler()(error)
	end
end

-- GetNamesWithoutBuff
local matches
if select(4, _G.GetBuildInfo()) >= 40000 then
	matches = {
		{GetSpellInfo(21562)},				-- Fortitude
		{GetSpellInfo(1459)},				-- Intellect
		{GetSpellInfo(1126)},				-- Mark of the Wild
		{GetSpellInfo(27683)},				-- Shadow Protection
		{GetSpellInfo(19740)},				-- Blessing of Might
		{GetSpellInfo(20217)},				-- Blessing of Kings
	}
else
	matches = {
		{GetSpellInfo(48161), GetSpellInfo(48162)},				-- Fortitude
		{GetSpellInfo(42995), GetSpellInfo(43002)},				-- Intellect
		{GetSpellInfo(26990), GetSpellInfo(26991)},				-- Mark of the Wild
		{GetSpellInfo(48169), GetSpellInfo(48170)},				-- Shadow Protection
		{GetSpellInfo(48073), GetSpellInfo(48074)},				-- Spirit
		{GetSpellInfo(27140), GetSpellInfo(27141)},				-- Blessing of Might
		{GetSpellInfo(27142), GetSpellInfo(27143)},				-- Blessing of Wisdom
		{GetSpellInfo(20217), GetSpellInfo(25898)},				-- Blessing of Kings
		{GetSpellInfo(20911), GetSpellInfo(25899)},				-- Blessing of Sanctuary
	}
end

local checkExpiring
local function GetNamesWithoutBuff(spellName, with, filter)
	if (spellName == lastName and with == lastWith and lastNamesList) then
		return lastNamesList, lastNamesCount
	end

	local count = 0
	local names
	local unitName

	local class = select(2, UnitClass("player"))

	if select(4, _G.GetBuildInfo()) >= 40000 then
		if (not checkExpiring) then
			local cet = {}

			if (class == "PRIEST" or IsRaidOfficer()) then
				cet[GetSpellInfo(21562)] = 2			-- Sta
				cet[GetSpellInfo(27683)] = 2			-- Shadow Prot
			end
		
			if (class == "DRUID" or IsRaidOfficer()) then
				cet[GetSpellInfo(1126)] = 2			-- Mark
				cet[GetSpellInfo(467)] = 1			-- Thorns
			end
		
			if (class == "MAGE" or IsRaidOfficer()) then
				cet[GetSpellInfo(1459)] = 2			-- Int
			end

			if (class == "PALADIN" or IsRaidOfficer()) then
				cet[GetSpellInfo(19740)] = 2			-- Blessing of Might
				cet[GetSpellInfo(20217)] = 2			-- Blessing of Kings
			end

			checkExpiring = cet
		end
	else
		if (not checkExpiring) then
			local cet = {}

			if (class == "PRIEST" or IsRaidOfficer()) then
				cet[GetSpellInfo(21562)] = 2			-- Sta
				cet[GetSpellInfo(48162)] = 2			-- Sta
				cet[GetSpellInfo(48073)] = 2			-- Spirit
				cet[GetSpellInfo(48074)] = 2			-- Spirit
				cet[GetSpellInfo(48169)] = 2			-- Shadow Prot
				cet[GetSpellInfo(48170)] = 2			-- Shadow Prot
			end
		
			if (class == "DRUID" or IsRaidOfficer()) then
				cet[GetSpellInfo(26990)] = 2			-- Mark
				cet[GetSpellInfo(26991)] = 2			-- Gift
				cet[GetSpellInfo(53307)] = 1			-- Thorns
			end
		
			if (class == "MAGE" or IsRaidOfficer()) then
				cet[GetSpellInfo(42995)] = 2			-- Int
				cet[GetSpellInfo(43002)] = 2			-- Int
				cet[GetSpellInfo(43015)] = 1			-- Dampen
				cet[GetSpellInfo(43017)] = 1			-- Amplify
			end

			if (class == "PALADIN" or IsRaidOfficer()) then
				cet[GetSpellInfo(27140)] = 2
				cet[GetSpellInfo(27141)] = 2			-- Blessing of Might
				cet[GetSpellInfo(27142)] = 2
				cet[GetSpellInfo(27143)] = 2			-- Blessing of Wisdom
				cet[GetSpellInfo(20217)] = 2
				cet[GetSpellInfo(25898)] = 2			-- Blessing of Kings
				cet[GetSpellInfo(20911)] = 2
				cet[GetSpellInfo(25899)] = 2			-- Blessing of Sanctuary
			end

			checkExpiring = cet
		end
	end

	local withList = XPerl_GetReusableTable()
	for unitid, unitName, unitClass, group, zone, online, dead in XPerl_NextMember do
		local use

		if (not conf.buffHelper.visible) then
			use = true
		else
			if (conf.raid.sortByClass) then
				if (conf.raid.class[group].enable) then
					use = unitClass == conf.raid.class[group].name
				end
			else
				use = conf.raid.group[group]
			end
		end

		if (unitName and use and online and not dead) then
			local hasBuff
			for num = 1,25 do
			local name, rank, buffTexture, count, _, fullDuration, endTime, isMine, isStealable = UnitAura(unitid, num, filter)
				if (not name) then
					break
				end

				if (name == spellName) then
					hasBuff = true
				else
					for dups,pair in pairs(matches) do
						if (name == pair[1] or name == pair[2]) then
							if (spellName == pair[1] or spellName == pair[2]) then
								hasBuff = true
								break
							end
						end
					end
				end
				if (hasBuff) then
					if (without and checkExpiring) then
						local found = checkExpiring[buffTextureNoPath]

						if (found) then
							if (endTime and endTime > 0 and endTime <= GetTime() + (found * 60)) then
								GameTooltip:AddLine(format(XPERL_RAID_TOOLTIP_BUFFEXPIRING, XPerlColourTable[unitClass]..name.."|c", buffName, SecondsToTime(endTime - GetTime())), 1, 0.2, 0)
							end
						end
					end
					break
				end
			end

			if ((with and hasBuff) or (not with and not hasBuff)) then
				count = count + 1

				if (conf.buffHelper.sort == "group") then
					if (not withList[group]) then
						withList[group] = XPerl_GetReusableTable()
					end
					tinsert(withList[group], {class = unitClass, ["name"] = unitName})
				elseif (conf.buffHelper.sort == "class") then
					if (not withList[unitClass]) then
						withList[unitClass] = XPerl_GetReusableTable()
					end
					tinsert(withList[unitClass], unitName)
				else
					local n = XPerl_GetReusableTable()
					tinsert(withList, n)
					n.class = unitClass
					n.name = unitName
				end
			end
		end
	end

	if (conf.buffHelper.sort == "group") then
		for i = 1,8 do
			local list = withList[i]
			if (list) then
				sort(list, function(a,b) return a.name < b.name end)

				names = (names or "").."|r"..i..": "
				for i,item in ipairs(list) do
					names = names..XPerlColourTable[item.class]..item.name.." "
				end
				names = names.."|r\r"
			end
			XPerl_FreeTable(list)
		end
	elseif (conf.buffHelper.sort == "class") then
		for j,class in ipairs(classOrder) do
			local list = withList[class]
			if (list) then
				sort(list)

				for i,name in ipairs(list) do
					if (i == 1) then
						names = (names or "")..XPerlColourTable[class]
					end
					names = (names or "")..name.." "
				end

				names = (names or "").."|r\r"
			end
			XPerl_FreeTable(list)
		end
	else
		sort(withList, function(a,b) return a.name < b.name end)
		for i,item in ipairs(withList) do
			names = (names or "")..XPerlColourTable[item.class]..item.name.." "
			XPerl_FreeTable(item)
		end

		names = (names or "").."\r"
	end

	XPerl_FreeTable(withList)

	lastNamesList = names
	lastName = spellName
	lastWith = with
	lastNamesCount = count

	return names, count
end

local function UnitFullName(unit)
    local name, realm = UnitName(unit)
    if (name) then
		if (realm and realm ~= "") then
	        return name .. "-" .. realm
		else
    		return name
		end
	end
end

-- XPerl_ToolTip_AddBuffDuration
local function XPerl_ToolTip_AddBuffDuration(self, partyid, buffID, filter)
	local name, rank, buff, count, _, dur, max, caster, isStealable = UnitAura(partyid, buffID, filter)

	if (GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0) then
		if (conf.buffHelper.enable and partyid and (UnitInParty(partyid) or UnitInRaid(partyid))) then
			if (name) then
				local names, count = GetNamesWithoutBuff(name, IsAltKeyDown(), filter)
				if (names) then
					if (IsAltKeyDown()) then
						self:AddLine(format(XPERL_RAID_TOOLTIP_WITHBUFF, count), 0.3, 1, 0.2)
					else
						self:AddLine(format(XPERL_RAID_TOOLTIP_WITHOUTBUFF, count), 1, 0.3, 0.1)
					end

					if (conf.buffHelper.sort) then
						self:AddLine(names, 0.5, 0.5, 0.5)
					else
						self:AddLine(names, 0.5, 0.5, 0.5, 1)
					end
				end
			end
		end
	end

	if (caster and conf.buffs.names) then
		local casterName = UnitFullName(caster)
		if (casterName) then
			local c
			if (UnitIsPlayer(caster)) then
				local _, class = UnitClass(caster)
				c = class and (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
			else
				c = XPerl_ReactionColour(caster)
			end
			if (c) then
				self:AddLine(casterName, c.r, c.g, c.b)
			else				
				self:AddLine(casterName)
			end
		end
	end

	GameTooltip:Show()
end

-- Buff Tooltip Hook
local function XPerl_GameTooltipSetUnitAura(self, unitId, buffId, filter)
	XPerl_ToolTip_AddBuffDuration(self, unitId, buffId, filter)
end

local function XPerl_GameTooltipSetUnitBuff(self, unitId, buffId)
	XPerl_ToolTip_AddBuffDuration(self, unitId, buffId, "HELPFUL")
end

local function XPerl_GameTooltipSetUnitDebuff(self, unitId, buffId)
	XPerl_ToolTip_AddBuffDuration(self, unitId, buffId, "HARMFUL")
end

-- XPerl_Init()
function XPerl_Init()
	init_done = true
	if (GameTooltip.SetUnitAura) then
		hooksecurefunc(GameTooltip, "SetUnitAura", XPerl_GameTooltipSetUnitAura)
		hooksecurefunc(GameTooltip, "SetUnitBuff", XPerl_GameTooltipSetUnitBuff)
		hooksecurefunc(GameTooltip, "SetUnitDebuff", XPerl_GameTooltipSetUnitDebuff)
	end

	DisableAddOn("XPerl_TeamSpeak")

	-- Check for eCastbar and disable old frame if used.
	if (eCastingBar_Saved and eCastingBar_Player and eCastingBar_Saved[eCastingBar_Player].Enabled == 1) then
		conf.player.castBar.original = nil
	elseif (BCastBar and BCastingBar and BCastBarDragButton) then
		conf.player.castBar.original = nil
	end

	XPerl_pcall(XPerl_OptionActions)

	--PartyMemberFrame:UnregisterEvent("UNIT_NAME_UPDATE")

	if (CT_PartyBuffFrame1) then
		if (XPerl_party1) then
			CT_PartyBuffFrame1:Hide()
			CT_PartyBuffFrame2:Hide()
			CT_PartyBuffFrame3:Hide()
			CT_PartyBuffFrame4:Hide()
		end
		if (XPerl_Player_Pet) then
			CT_PetBuffFrame:Hide()
		end
	end

	if (CT_RAMTGroup) then
		-- Fix CTRA lockup issues for WoW 2.1
		-- Sure it's not my responsibility, but you can bet your ass I'll get blamed for it's lockups...
		CT_RAMTGroup:UnregisterEvent("UNIT_NAME_UPDATE")
		if (CT_RAMTTGroup) then	CT_RAMTTGroup:UnregisterEvent("UNIT_NAME_UPDATE")	end
		if (CT_RAPTGroup) then	CT_RAPTGroup:UnregisterEvent("UNIT_NAME_UPDATE")	end
		if (CT_RAPTTGroup) then	CT_RAPTTGroup:UnregisterEvent("UNIT_NAME_UPDATE")	end
		if (CT_RAGroup1) then
			for i = 1,8 do
				local f = _G["CT_RAGroup"..i]
				if (f) then	f:UnregisterEvent("UNIT_NAME_UPDATE")		end
			end
		end
	end

	local name, title, notes, enabled = GetAddOnInfo("SupportFuncs")
	if (name and enabled) then
		local ver = GetAddOnMetadata(name, "Version")
		if (tonumber(ver) < 20000.2) then
			XPerl_Notice("Out-dated version of SupportFuncs detected. This will break the X-Perl Range Finder by replacing standard Blizzard API functions.")
		end
	end

	name, title, notes, enabled = GetAddOnInfo("AutoBar")
	if (name and enabled) then
		local ver = GetAddOnMetadata(name, "Version")
		if (ver < "2.01.00.02 beta") then
			XPerl_Notice("Out-dated version of AutoBar detected. This will taint the Targetting system for all mods that use them, including X-Perl.")
		end
	end

	name, title, notes, enabled = GetAddOnInfo("TrinityBars")
	if (name and enabled) then
		local ver = GetAddOnMetadata(name, "Version")
		if (ver <= "20003.14") then
			XPerl_Notice("Out-dated version of TrinityBars detected. This will taint the Targetting system for all mods that use them, including X-Perl.")
		end
	end

	if (EarthFeature_AddButton) then
		EarthFeature_AddButton ({name = XPerl_ProductName,
					icon = XPerl_ModMenuIcon,
					subtext = "by "..XPerl_Author,
					tooltip = XPerl_LongDescription,
					callback = XPerl_Toggle})
	end

	if (CT_RegisterMod) then
		CT_RegisterMod(XPerl_ProductName.." "..XPerl_VersionNumber, "By "..XPerl_Author, 4, XPerl_ModMenuIcon, XPerl_LongDescription, "switch", "", XPerl_Toggle)
	end

	if (myAddOnsFrame) then
		myAddOnsList.XPerl_Description = {
			name			= XPerl_Description,
			description		= XPerl_LongDescription,
			version			= XPerl_VersionNumber,
			category		= MYADDONS_CATEGORY_OTHERS,
			frame			= "XPerl_Globals",
			optionsframe		= "XPerl_Options"
		}
	end

	XPerl_RegisterSMBarTextures()

	--if (not strfind("Zek Zali Hek Zeks Zekked Zekstuff Pooksie Wazek", UnitName("player")) or GetRealmName() ~= "Bloodhoof") then
	--	XPerl_ShowMessage = function() end
	--end

	XPerl_pcall(XPerl_DebufHighlightInit)

	XPerl_Init = nil
end

-- XPerl_StatsFrame_Setup
function XPerl_StatsFrameSetup(self, others, offset)
	if (not self) then
		return
	end
	local StatsFrame = self.statsFrame
	if (not StatsFrame) then
		return
	end

        local healthBar = StatsFrame.healthBar
        local healthBarText = healthBar.text
        local healthBarPercent = healthBar.percent
        local manaBar = StatsFrame.manaBar
        local manaBarPercent = manaBar.percent
	local otherBars = {}
	local secondaryBarsShown = 0
        local percentSize = 0
	if (healthBarPercent:IsShown() or manaBarPercent:IsShown()) then
		percentSize = 35
	end

	offset = (offset or 0)
	
	healthBar:SetWidth(0)

	if (manaBar:IsShown()) then
		secondaryBarsShown = secondaryBarsShown + 1
		manaBar:SetWidth(0)
	end

	local needTicker = 0
	if (StatsFrame.energyTicker) then
		needTicker = 1
	end

	if (others) then
		for i,bar in pairs(others) do
			if (bar) then
				tinsert(otherBars, bar)
				if (bar:IsShown()) then
					secondaryBarsShown = secondaryBarsShown + 1
					bar:SetWidth(0)
				end
			end
		end
	end
	
	if (conf.bar.fat) then       
		if (StatsFrame == XPerl_Player_PetstatsFrame) then
			healthBarText:SetFontObject(GameFontNormalSmall)
		else
			healthBarText:SetFontObject(GameFontNormal)
		end

        	healthBar:ClearAllPoints()
        	healthBar:SetPoint("TOPLEFT", 5, -5)
        	healthBar:SetPoint("BOTTOMRIGHT", -(5 + percentSize), 5 + needTicker + (secondaryBarsShown * 10))

        	manaBar:ClearAllPoints()
        	manaBar:SetPoint("BOTTOMLEFT", 5, -5 + needTicker + (secondaryBarsShown * 10))
        	manaBar:SetPoint("TOPRIGHT", healthBar, "BOTTOMRIGHT", 0, 0)

		local lastBar = manaBar
		local tickerSpace = needTicker * 1.5
		for i,bar in pairs(otherBars) do
			if (bar:IsShown()) then
        	        	bar:ClearAllPoints()

        	        	bar:SetPoint("TOPLEFT", lastBar, "BOTTOMLEFT", 0, -tickerSpace)
        	        	bar:SetPoint("BOTTOMRIGHT", lastBar, "BOTTOMRIGHT", 0, -10 - tickerSpace)

				lastBar = bar
				tickerSpace = 0
			end
        	end
	else
		healthBarText:SetFontObject(GameFontNormalSmall)

        	healthBar:ClearAllPoints()
        	healthBar:SetPoint("TOPLEFT", 8, -9 + offset)
        	healthBar:SetPoint("BOTTOMRIGHT", StatsFrame, "TOPRIGHT", -(8 + percentSize), -19 + offset)

        	manaBar:ClearAllPoints()
        	manaBar:SetPoint("TOPLEFT", healthBar, "BOTTOMLEFT", 0, -2)
        	manaBar:SetPoint("BOTTOMRIGHT", healthBar, "BOTTOMRIGHT", 0, -12)

		local lastBar = manaBar
		for i,bar in pairs(otherBars) do
			if (bar:IsShown()) then
        	        	bar:ClearAllPoints()

        	        	bar:SetPoint("TOPLEFT", lastBar, "BOTTOMLEFT", 0, -2)
        	        	bar:SetPoint("BOTTOMRIGHT", lastBar, "BOTTOMRIGHT", 0, -12)

				lastBar = bar
			end
        	end
	end
end

-- XPerl_RegisterUnitText(self)
local unitText = {}
function XPerl_RegisterUnitText(self)
	tinsert(unitText, self)
end

-- XPerl_SetTextTransparency()
function XPerl_SetTextTransparency()
	local t = conf.transparency.text
	for k,v in pairs(unitText) do
		if (v.GetTextColor) then
			local r, g, b = v:GetTextColor()
			v:SetTextColor(r, g, b, t)
		end
	end
end

-- Set1Bar
local function Set1Bar(bar, tex)
	if (bar.tex) then
		bar.tex:SetTexture(tex)
		bar.tex:SetHorizTile(false)
		bar.tex:SetVertTile(false)
	end
	if (bar.bg) then
		if (conf.bar.background) then
			bar.bg:SetTexture(tex)
		else
			bar.bg:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
		end
		bar.bg:SetHorizTile(false)
		bar.bg:SetVertTile(false)
	end
end

-- XPerl_RegisterBar
local XPerlBars = {}
function XPerl_RegisterBar(bar)
	tinsert(XPerlBars, bar)
	if (init_done) then
		local tex = XPerl_GetBarTexture()
		Set1Bar(bar, tex)
	end
end

-- XPerl_SetBarTextures
function XPerl_SetBarTextures()
	local tex = XPerl_GetBarTexture()
	for k,v in pairs(XPerlBars) do
		Set1Bar(v, tex)
	end
end

-- XPerl_RegisterOptionChanger
local optionFuncs = {}
function XPerl_RegisterOptionChanger(f, s)
	tinsert(optionFuncs, {func = f, slf = s})
end

-- XPerl_OptionActions()
function XPerl_OptionActions(which)

	UIParent:UnregisterEvent("RAID_ROSTER_UPDATE")			-- IMPORTANT! Stops raid framerate lagging when members join/leave/zone

	if (InCombatLockdown()) then
		XPerl_OutOfCombatOptionSet = true
		return
	end

	if (conf.showTutorials) then
		if (not IsAddOnLoaded("XPerl_Tutorial")) then
			EnableAddOn("XPerl_Tutorial")
			LoadAddOn("XPerl_Tutorial")
		end
	end

	conf.transparency.frame	= min(max(tonumber(conf.transparency.frame or 1), 0), 1)
	conf.transparency.text	= min(max(tonumber(conf.transparency.text or 1), 0), 1)

	XPerl_pcall(XPerl_SetBarTextures)

	XPerl_pcall(XPerl_SetAllFrames)

	for k,v in pairs(optionFuncs) do
		XPerl_NoFadeBars(true)
		XPerl_pcall(v.func, v.slf, which)
	end
	XPerl_NoFadeBars()

	XPerl_pcall(XPerl_SetTextTransparency)
	doneOptions = true

	if (conf.buffs.blizzardCooldowns and BuffFrame and BuffFrame:IsShown()) then
		BuffFrame_Update()
	end
end
