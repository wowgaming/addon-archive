-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

XPerl_SetModuleRevision("$Revision: 374 $")

XPerl_MainTanks = {}
local MainTankCount, blizzMTanks, ctraTanks = 0, 0, 0
local MainTanks = {}
local BlizzardMainTanks = {}
local Events = {}
local XUnits = {}
local UpdateTime = 0
local XGaps = 0
local XTitle
local pendingTankListChange		-- If in combat when tank list changes, then we'll defer it till next time we're out of combat
local conf

local new, del = XPerl_GetReusableTable, XPerl_FreeTable

-- Dup colours used to show which tanks have the same target
local MTdupColours = {	{r = "0.8", g = "0.2", b = "0.2"},
			{r = "0.2", g = "0.2", b = "0.8"},
			{r = "0.8", g = "0.2", b = "0.8"},
			{r = "0.2", g = "0.8", b = "0.2"},
			{r = "0.2", g = "0.8", b = "0.8"}}

local GAP_SPACING = 10
XPERL_UNIT_HEIGHT_MIN = 17
XPERL_UNIT_HEIGHT_MAX = 30
XPERL_UNIT_WIDTH_MIN = 50
XPERL_UNIT_WIDTH_MAX = 125

if (not XPerlColourTable) then
	XPerlColourTable = setmetatable({},{
		__index = function(self, class)
			local c = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class] or {r = 0, g = 0, b = 0}
			return format("|c00%02X%02X%02X", 255 * c.r, 255 * c.g, 255 * c.b)
		end
	})
end

-- Although your own "target" is updated immediately, any reference to ourself via our raid id is updated via the server
-- So, to cure the slow response times, we check if anything is 'me'. Only direct targets are updated immedately,
-- so we don't bother with target's target onwards.
local function SpecialCaseUnit(self)
	local id
	if (self.type == "MTT") then
		id = self:GetParent():GetAttribute("unit")	-- SecureButton_GetUnit(self:GetParent())
		if (id) then
			if (UnitIsUnit("player", id)) then
				return "target"
			end
			return id.."target"
		end

	elseif (self.type == "MT") then
		id = self:GetAttribute("unit")			-- SecureButton_GetUnit(self)
		if (id and UnitIsUnit("player", id)) then
			return "player"
		end
		return id
	end

	return SecureButton_GetUnit(self)
end

----------------------------
------- DISPLAY ------------
----------------------------
local function UpdateUnit(self,forcedUpdate)
	if (not self or self.hidden) then
		return
	end

	if (forcedUpdate) then
		local time = GetTime()
		if (self.update and time < self.update + 0.2) then
			-- Since we catch UNIT_HEALTH changes, we don't need to update always
			return
		end
	end

	self.update = GetTime()

	local xunit = SpecialCaseUnit(self)
	if (not xunit) then
		return
	end

	local name = UnitName(xunit)
	local percBar, grey

	self.healthBar.bg:Show()

	if (name and name ~= UNKNOWNOBJECT) then
		-- Name
		self.text:SetText(name)
		self.text:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 0, -12)

		local remCount = 1
		while ((self.text:GetStringWidth() >= (self:GetWidth() - 2)) and (string.len(name) > remCount)) do
			name = string.sub(name, 1, string.len(name) - remCount)..".."
			remCount = 3
			self.text:SetText(name)
		end

		if (UnitPlayerControlled(xunit)) then
			XPerl_ColourFriendlyUnit(self.text, xunit)
		else
			XPerl_SetUnitNameColor(self.text, xunit)
		end

		-- Health
		local healthMax = UnitHealthMax(xunit)
		local health = UnitHealth(xunit)
		percBar = health / healthMax
		local perc = percBar * 100

		if (healthMax == 0) then
			grey, health, healthMax, perc = 1, 0, 1, 0
		end

		self.healthBar:SetMinMaxValues(0, healthMax)
		self.healthBar:SetValue(health)

		if (UnitIsDeadOrGhost(xunit)) then
			self.healthBar.text:SetText(XPERL_LOC_DEAD)
			grey = true
		elseif (not UnitIsConnected(xunit)) then
			self.healthBar.text:SetText(XPERL_LOC_OFFLINE)
			grey = true
		else
			if (conf.HealerMode == 1 and UnitInRaid(xunit)) then
				if (conf.HealerModeType == 1) then
					self.healthBar.text:SetText(health - healthMax.."/"..healthMax)
				else
					self.healthBar.text:SetText(health - healthMax)
				end
			else
				self.healthBar.text:SetText(floor(perc + 0.5).."%")
			end
		end
		if (conf.UnitHeight < 23) then
			self.healthBar.text:Hide()
		else
			self.healthBar.text:Show()
		end

		if (self.type == "MTT") then
			if (BigWigsTargetMonitor) then
				BigWigsTargetMonitor:TargetCheck(xunit)
			end

			local index = GetRaidTargetIndex(xunit)
			if (index) then
				SetRaidTargetIconTexture(self.raidIcon, index)
				self.raidIcon:Show()
			else
				self.raidIcon:Hide()
			end
		else
			self.raidIcon:Hide()
		end

		if (UnitAffectingCombat(xunit)) then
			self.combatIcon:Show()
		else
			self.combatIcon:Hide()
		end

		if (UnitIsCharmed(xunit)) then
			self.warningIcon:Show()
		else
			self.warningIcon:Hide()
		end
	else
		self.text:SetPoint("BOTTOMRIGHT", -2, 1)

		if (self.type == "MTT") then
			local id = SecureButton_GetUnit(self:GetParent())
			name = UnitName(id)

			if (name) then
				XPerl_ColourFriendlyUnit(self.text, id)
				self.text:SetFormattedText(XPERL_XS_TARGET, name)
				self.healthBar.bg:Hide()
			end
		else
			self.text:SetText(XPERL_NO_TARGET)
			self.text:SetTextColor(0.5, 0.5, 0.5, 1)
		end
		self.healthBar:SetMinMaxValues(0, 1)
		self.healthBar:SetValue(0)
		percBar = 0
		grey = true
		self.healthBar.text:Hide()
		self.raidIcon:Hide()
		self.combatIcon:Hide()
		self.warningIcon:Hide()
	end

	if (XPerl_UpdateSpellRange and XPerlDB.rangeFinder.enabled) then
		XPerl_UpdateSpellRange(self)
	else
		self:SetAlpha(1)
	end

	if (grey) then
		self.healthBar:SetStatusBarColor(0.5, 0.5, 0.5, 1)
		self.healthBar.bg:SetVertexColor(0.5, 0.5, 0.5, 0.5)
	else
		if (XPerlDB and XPerlDB.colour.classbar and UnitIsFriend("player", xunit)) then
			local bar = self.healthBar
			local class = select(2, UnitClass(xunit))
			if (class) then
				local c = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]

				bar:SetStatusBarColor(c.r, c.g, c.b)
				if (bar.bg) then
					bar.bg:SetVertexColor(c.r, c.g, c.b, 0.25)
				end
				return
			end
		end

		XPerl_SetSmoothBarColor(self.healthBar, percBar)
	end
end

-- XPerl_RaidHelp_Show
function XPerl_RaidHelp_Show()
	conf.RaidHelper = 1
	XPerl_RaidHelperCheck:Show()		-- XPerl_EnableDisable()
	return true
end

-- XPerl_MTListUnit_OnEnter
function XPerl_MTListUnit_OnEnter(self)

	local x = XPerl_Frame:GetCenter()
	local a1, a2 = "ANCHOR_LEFT", "ANCHOR_TOPLEFT"
	if ( x < (GetScreenWidth() / 2)) then
		a1, a2 = "ANCHOR_RIGHT", "ANCHOR_TOPRIGHT"
	end

	if (conf.Tooltips == 1) then
		local partyid = SecureButton_GetUnit(self)

		if (partyid and UnitName(partyid) and conf.TooltipsWhich == 2) then
			GameTooltip:SetOwner(self, a1)
			GameTooltip:SetUnit(partyid)

			if (self.type == "MTT" and conf.TooltipsWhich == 2) then
				local parentID = SecureButton_GetUnit(self:GetParent())
				if (parentID) then
					XPerl_BottomTip:SetOwner(GameTooltip, a2, 0, 10)
					XPerl_BottomTip:SetUnit(parentID)
					XPerl_BottomTip:SetBackdropColor(0.1, 0.4, 0.1, 0.75)
				end
			end
		else
			if (conf.TooltipsWhich == 0) then
				GameTooltip:SetOwner(self, a1)
				GameTooltip:SetUnit(partyid)
			else
				if (self.type == "MTT") then
					partyid = SecureButton_GetUnit(self:GetParent())
				end

				GameTooltip:SetOwner(self, a1)
				GameTooltip:SetUnit(partyid)
				GameTooltip:SetBackdropColor(0.1, 0.4, 0.1, 0.75)
			end
		end
	end
end

-- XPerl_SetupFrameSimple
function XPerl_SetupFrameSimple(self, alpha)
	self:SetBackdropBorderColor(0.5, 0.5, 0.5, alpha or 0.8)
	self:SetBackdropColor(0, 0, 0, alpha or 0.8)
end

-- XPerl_HelperBarTextures
if (XPerl_GetBarTexture) then
function XPerl_HelperBarTextures(tex)
	local function UnitTex(v, tex)
		v.healthBar.tex:SetTexture(tex)
		if (XPerlConfig and XPerlConfig.BackgroundTextures == 1) then
			v.healthBar.bg:SetTexture(tex)
		else
			v.healthBar.bg:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
		end
	end

	for k,v in pairs(XUnits) do
		UnitTex(v, tex)
	end
end
end

-- RemoveDupMT
local function RemoveDupMT(name)
	for k, v in pairs(XPerl_MainTanks) do
		if (strlower(v[2]) == strlower(name)) then
			XPerl_MainTanks[k] = del(XPerl_MainTanks[k])
			return true
		end
	end
end

-- GetRaidIDByName
local function GetRaidIDByName(name)
	for i = 1, GetNumRaidMembers() do
		if (strlower(UnitName("raid"..i)) == strlower(name)) then
			return i
		end
	end
end

-- GetUnitRank
local function GetUnitRank(name)
	local index = GetRaidIDByName(name)
	if (index) then
		return select(2, GetRaidRosterInfo(index))
	end
	return 0
end

-- ValidateTankList
-- Check the roster for any tanks that have left the raid
local function ValidateTankList()
	for index,entry in pairs(XPerl_MainTanks) do
		local found
		for i = 1,GetNumRaidMembers() do
			if (strlower(UnitName("raid"..i)) == strlower(entry[2])) then
				found = true
				break
			end
		end

		if (not found) then
			XPerl_MainTanks[index] = nil
		end
	end
end

-- inBattlegrounds
local function inBattlegrounds()
	for i = 1,50 do
		local r = GetBattlefieldStatus(i)
		if (not r) then
			return
		end
		if (r == "active") then
			return true
		end
	end
end

-- XPerl_MTRosterChanged()
function XPerl_MTRosterChanged()
	ValidateTankList()

	del(MainTanks, true)
	MainTanks = new()

	-- TODO: oRA:GetSortedTanks()

	blizzMTanks, ctraTanks = 0, 0
	
	-- if conf is nothing, just return.
	if (conf == nil) then
                return
        else
                if (conf and conf.UseCTRATargets == 1) then
                        for index,entry in pairs(XPerl_MainTanks) do
                                local raidid = GetRaidIDByName(entry[2])
                                if (raidid) then
                                        ctraTanks = ctraTanks + 1
                                        tinsert(MainTanks, new(raidid, UnitName("raid"..raidid)))
                                end
                        end
                end
	end

	-- Blizzard defined main tanks bit. Looks a bit convoluted, but this is all so the order of the tanks is defined
	-- by they order that they were assigned. It's a reasonable assumption that the MT is promoted first. There's no
	-- guarentees of course. This is up to your raid leader, but imo it's better than the default raid ID ordering.
	if (conf and conf.UseBlizzardMTTargets == 1) then
		-- Remember old tanks
		local oldBlizzardNames = new()
		for i,n in ipairs(BlizzardMainTanks) do
			oldBlizzardNames[n] = true
		end

		-- Scan roster, adding any new ones, and removing found ones from old tanks list
		for i = 1,GetNumRaidMembers() do
			local unitid = "raid"..i
			if (GetPartyAssignment("maintank", unitid)) then
				local name = UnitName(unitid)
				if (name ~= UNKNOWN) then
					if (oldBlizzardNames[name]) then
						-- We already had this tank, so leave it where it is
						oldBlizzardNames[name] = nil
					else
						-- New tank defined, add it to the end of the list
						tinsert(BlizzardMainTanks, name)
					end
				end
			end
		end

		-- Remove any that have been demoted
		for name in pairs(oldBlizzardNames) do
			for i = #BlizzardMainTanks,1,-1 do
				if (BlizzardMainTanks[i] == name) then
					tremove(BlizzardMainTanks, i)
					break
				end
			end
		end
		oldBlizzardNames = del(oldBlizzardNames)

		for i,name in ipairs(BlizzardMainTanks) do
			local found
			for i,info in ipairs(MainTanks) do
				if (name == info[2]) then
					found = true
				end
			end
			if (not found) then
				tinsert(MainTanks, new(i, name))
				blizzMTanks = blizzMTanks + 1
			end
		end
	end

	if (not next(XPerl_MainTanks)) then
		-- If no defined tanks, then make a list from the warriors in raid

		if (blizzMTanks == 0 and conf.NoAutoList == 0 and not inBattlegrounds()) then
			for i = 1,GetNumRaidMembers() do
				local id = "raid"..i
				if (select(2, UnitClass(id)) == "WARRIOR") then
					tinsert(MainTanks, new(i, UnitName(id)))
				end
			end
		end
	end

	MainTankCount = #MainTanks

	XPerl_MakeTankList()
end

-- ProcessCTRAMessage
XPerlCTRASet = {}
local function ProcessCTRAMessage(unitName, msg)

	local mtListUpdate

	if (strsub(msg, 1, 4) == "SET ") then
		if (GetUnitRank(unitName) < 1) then
			return
		end

		local num, name = strmatch(msg, "^SET (%d+) (.+)$")
		if (num and name) then
			num = tonumber(num)
			local mtID = 0
			for i = 1, GetNumRaidMembers() do
				if (strlower(UnitName("raid"..i)) == strlower(name)) then
					mtID = i
					break
				end
			end

			if (XPerl_MainTanks[num]) then
				if (XPerl_MainTanks[num][1] == mtID and XPerl_MainTanks[num][2] == name) then
					return			-- No Change
				end
			end

			RemoveDupMT(name)

			del(XPerl_MainTanks[tonumber(num)])
			XPerl_MainTanks[tonumber(num)] = new(mtID, name)

			mtListUpdate = true
		end

	elseif (strsub(msg, 1, 2) == "R ") then
		if (GetUnitRank(unitName) < 1) then
			return
		end

		local name = strmatch(msg, "^R (.+)$")
		if (name) then
			mtListUpdate = RemoveDupMT(name)
		end
	end

	if (mtListUpdate) then
		-- XPerl_MTRosterChanged()
		XPerl_RaidHelperCheck:Show()		-- XPerl_EnableDisable()
	end
end

-- XPerl_SplitCTRAMessage
function XPerl_SplitCTRAMessage(msg, char)
	local arr = new()
	while (strfind(msg, char) ) do
		local iStart, iEnd = strfind(msg, char)
		tinsert(arr, strsub(msg, 1, iStart-1))
		msg = strsub(msg, iEnd+1, strlen(msg))
	end
	if ( strlen(msg) > 0 ) then
		tinsert(arr, msg)
	end
	return arr
end

-- XPerl_ParseCTRA
function XPerl_ParseCTRA(nick, msg, func)
	if (strfind(msg, "#")) then
		local arr = XPerl_SplitCTRAMessage(msg, "#")
		for i,subMsg in pairs(arr) do
			func(nick, subMsg)
		end
		del(arr)
	else
		func(nick, msg)
	end
end

-- CHAT_MSG_ADDON
function Events:CHAT_MSG_ADDON()
	if (arg1 == "CTRA" and arg3 == "RAID") then
		XPerl_ParseCTRA(arg4, arg2, ProcessCTRAMessage)
	end
end

----------------------------
---------- EVENTS ----------
----------------------------

-- OnEvent
function XPerl_OnEvent(self, event, ...)
	Events[event](self, ...)
end

-- XPerl_GetUnit
local function XPerl_GetUnit(unit)
	for i,search in pairs(XUnits) do
		if (search.type == "MTT") then
			local partyid = SecureButton_GetUnit(search:GetParent())
			if (partyid == unit) then
				return search
			end
		end
	end
end

-- ScanForMTDups
-- Check MTs all have unique targets
local function ScanForMTDups()
	local dup = 1
	local dups = new()

	for i,unit in pairs(XUnits) do
		XPerl_SetupFrameSimple(unit, conf.Background_Transparency)
	end

	for i,t1 in pairs(MainTanks) do
		local any = false

		if (UnitExists("raid"..t1[1].."target") and not UnitIsDeadOrGhost("raid"..t1[1])) then
			for j,t2 in pairs(MainTanks) do
				if (j > i and not dups["raid"..t2[1]]) then
					if (UnitIsUnit("raid"..t1[1].."target", "raid"..t2[1].."target")) then
						dups["raid"..t2[1]] = 1

						local unit1 = XPerl_GetUnit("raid"..t1[1])
						local unit2 = XPerl_GetUnit("raid"..t2[1])

						if (unit1) then
							unit1:SetBackdropBorderColor(MTdupColours[dup].r, MTdupColours[dup].g, MTdupColours[dup].b)
							unit1:SetBackdropColor(MTdupColours[dup].r, MTdupColours[dup].g, MTdupColours[dup].b)
						end
						if (unit2) then
							unit2:SetBackdropBorderColor(MTdupColours[dup].r, MTdupColours[dup].g, MTdupColours[dup].b)
							unit2:SetBackdropColor(MTdupColours[dup].r, MTdupColours[dup].g, MTdupColours[dup].b)
						end
						any = true
					end
				end
			end

			if (any and dup < 5) then
				dup = dup + 1
			end
		end
	end

	del(dups)
end

-- MoveArrow
local function MoveArrow(unit)
	XPerl_MyTarget:SetParent(unit)
	XPerl_MyTarget:SetPoint("RIGHT", unit, "LEFT", 2 - (conf.MTLabels * 10), 0)
	XPerl_MyTarget:Show()
end

-- OnUpdate
local function OnUpdate(self, elapsed)
	UpdateTime = UpdateTime + elapsed
	if (UpdateTime > 0.5) then
		-- Forced update here for anything we don't receive events for
		UpdateTime = 0
		for k,unit in pairs(XUnits) do
			if (unit.type == "MTT" or unit.type == "MTTT") then
				UpdateUnit(unit, true)
			end
		end
	end
end

-- CT_RA_IsSendingWithVersion override
-- Override this so that we get the MT list if there's only us in the raid with a CTRA version registered
local old_CT_RA_IsSendingWithVersion

-- VARIABLES_LOADED
function Events:VARIABLES_LOADED()
	self:UnregisterEvent("VARIABLES_LOADED")

	conf = XPerlConfigHelper

	if (CT_RA_IsSendingWithVersion) then
		old_CT_RA_IsSendingWithVersion = CT_RA_IsSendingWithVersion
		CT_RA_IsSendingWithVersion = function(version)
			if (version == 1.08) then
				return 1
			end
			return old_CT_RA_IsSendingWithVersion(version)
		end
	end

	if (type(XPerl_MainTanks) ~= "table") then
		XPerl_MainTanks = {}
	end

	XPerl_MTTargets:UnregisterEvent("UNIT_NAME_UPDATE")	-- Fix for WoW 2.1 UNIT_NAME_UPDATE issue
	XPerl_MTTargets:SetAttribute("template", "XPerl_MTList_UnitTemplate")

	XPerl_Startup()
	XPerl_RaidHelperCheck:Show()		-- XPerl_EnableDisable()

	XPerl_RegisterOptionChanger(XPerl_SetFrameSizes)
	XPerl_SetFrameSizes()

	Events.VARIABLES_LOADED = nil
end

-- Registration
local function Registration()
	local list = {	"UNIT_HEALTH",
			"UNIT_MAXHEALTH",
			"UNIT_TARGET",
			"PLAYER_TARGET_CHANGED",
			"PLAYER_REGEN_ENABLED",
			"PLAYER_REGEN_DISABLED",
			"PLAYER_ENTERING_WORLD",
			"CHAT_MSG_ADDON",
			"UNIT_DYNAMIC_FLAGS",
			"UNIT_FACTION"}

	for i,a in pairs(list) do
		if (GetNumRaidMembers() > 0 and conf.RaidHelper == 1) then
			XPerl_Frame:RegisterEvent(a)
		else
			XPerl_Frame:UnregisterEvent(a)
		end
	end
end

-- XPerl_HelperCheck_OnUpdate
function XPerl_HelperCheck_OnUpdate(self)
	self:Hide()
	XPerl_EnableDisable()
end

-- XPerl_EnableDisable
function XPerl_EnableDisable()
	if (InCombatLockdown()) then
		pendingTankListChange = true
		return
	end

	if (XPerlConfigHelper and conf and conf.RaidHelper == 1 and GetNumRaidMembers() > 0) then
		if (not XPerl_Frame:IsShown()) then
			XPerl_Frame:Show()
			XPerl_Frame:SetScript("OnUpdate", OnUpdate)
		end

		if (CT_RAMenu_Options and CT_RA_UpdateVisibility) then
			conf.OldCTMTListHide = CT_RAMenu_Options["temp"]["HideMTs"]
			CT_RAMenu_Options["temp"]["HideMTs"] = true
			CT_RA_UpdateVisibility(1)
		end
	else
		if (XPerl_Frame:IsShown()) then
			XPerl_Frame:Hide()
			XPerl_Frame:SetScript("OnUpdate", nil)
		end

		if (XPerlConfigHelper and conf and conf.RaidHelper == 0 and CT_RAMenu_Options and CT_RA_UpdateVisibility) then
			if (conf.OldCTMTListHide ~= true) then
				conf.OldCTMTListHide = nil
				CT_RAMenu_Options["temp"]["HideMTs"] = false
				CT_RA_UpdateVisibility(1)
			end
		end
	end

	Registration()
	XPerl_MTRosterChanged()
end

-- RAID_ROSTER_UPDATE
function Events:RAID_ROSTER_UPDATE()
	if (GetNumRaidMembers() == 0) then
		del(MainTanks, 1)
		MainTanks = new()
		del(BlizzardMainTanks)
		BlizzardMainTanks = new()
	end

	XPerl_RaidHelperCheck:Show()		-- XPerl_EnableDisable()
end

-- UNIT_HEALTH
function Events:UNIT_HEALTH(u)
	if (strfind(u, "^raid%d")) then
		for k,unit in pairs(XUnits) do
			local partyid = SecureButton_GetUnit(unit)
			if (partyid and UnitIsUnit(partyid, u)) then
				UpdateUnit(unit)
			end
		end
	end
end

Events.UNIT_MAXHEALTH = Events.UNIT_HEALTH

-- UNIT_DYNAMIC_FLAGS
function Events:UNIT_DYNAMIC_FLAGS(u)
	if (strfind(u, "^raid%d")) then
		for k,unit in pairs(XUnits) do
			if (unit.type == "MT") then
				local partyid = unit:GetAttribute("unit")
				if (partyid and partyid == u) then
					if (UnitAffectingCombat(partyid)) then
						unit.combatIcon:Show()
					else
						unit.combatIcon:Hide()
					end

					if (UnitIsCharmed(partyid)) then
						unit.warningIcon:Show()
					else
						unit.warningIcon:Hide()
					end
				end
			end
		end
	end
end

Events.UNIT_FACTION = Events.UNIT_DYNAMIC_FLAGS

-- CheckArrowPosition
local function CheckArrowPosition()
	local arrowDone
	local arrowType = "MTT"
	local arrowExtra = ""
	if (conf.ShowMT == 1) then
		arrowType = "MT"
		arrowExtra = "target"
	end

	XPerl_MyTarget:Hide()
	XPerl_MainAssist:Hide()
	XPerl_MainTank:Hide()

	local maAssignment, tankAssignment
	if (GetPartyAssignment) then
		maAssignment = GetPartyAssignment("mainassist")
		tankAssignment = GetPartyAssignment("maintank")
	end

	local maDone, mtDone
	for i,unit in pairs(XUnits) do
		local xunit = SpecialCaseUnit(unit)
		if (xunit) then
			if (not arrowDone and unit.type == arrowType and UnitIsUnit("target", xunit..arrowExtra) and UnitExists("target")) then
				MoveArrow(unit)
				arrowDone = true
			end

			if (unit.type == "MTT") then
				xunit = SpecialCaseUnit(unit:GetParent())
			end

			local name = UnitName(xunit)
			if (maAssignment and unit.type == arrowType and not maDone and name == maAssignment) then
				maDone = true
				XPerl_MainAssist:SetParent(unit.healthBar)
				XPerl_MainAssist:ClearAllPoints()

				if (conf.MTLabels == 1) then
					XPerl_MainAssist:SetPoint("BOTTOMRIGHT", unit, "BOTTOMLEFT", 3, 1)
				else
					XPerl_MainAssist:SetPoint("BOTTOMRIGHT", -1, 1)
				end
				XPerl_MainAssist:Show()
			end

			if (tankAssignment and unit.type == arrowType and not mtDone and name == tankAssignment) then
				mtDone = true
				XPerl_MainTank:SetParent(unit.healthBar)
				XPerl_MainTank:ClearAllPoints()

				if (conf.MTLabels == 1) then
					XPerl_MainTank:SetPoint("BOTTOMRIGHT", unit, "BOTTOMLEFT", 3, 1)
				else
					XPerl_MainTank:SetPoint("BOTTOMRIGHT", -1, 1)
				end
				XPerl_MainTank:Show()
			end
		end
	end
end

-- TargetChanged
local function TargetChanged(xunit)
	local unit, i = XPerl_MTTargets:GetAttribute("child1"), 1
	while (unit) do
		local id = unit:GetAttribute("unit")
		if (id and UnitIsUnit(id, xunit)) then
			UpdateUnit(unit.target)
			UpdateUnit(unit.targettarget)
			any = true
			break
		end

		i = i + 1
		unit = XPerl_MTTargets:GetAttribute("child"..i)
	end

	if (any) then
		ScanForMTDups()
		CheckArrowPosition()
	end
end

-- PLAYER_TARGET_CHANGED
function Events:PLAYER_TARGET_CHANGED()
	if (XPerl_Frame:IsShown()) then
		TargetChanged("player")
	end
end

-- UNIT_TARGET
function Events:UNIT_TARGET(u)
	if (XPerl_Frame:IsShown() and strmatch(u, "^raid")) then
		TargetChanged(u)
	end
end

-- DoButtons
local function DoButtons(disable)
	if (disable or InCombatLockdown()) then
		XPerl_Frame_CloseButton:Disable()
		XPerl_Frame_ToggleShowMT:Disable()
		XPerl_Frame_ToggleMTTargets:Disable()
		XPerl_Frame_ToggleLabels:Disable()
	else
		XPerl_Frame_CloseButton:Enable()
		XPerl_Frame_ToggleShowMT:Enable()
		XPerl_Frame_ToggleMTTargets:Enable()
		XPerl_Frame_ToggleLabels:Enable()
	end

	XPerl_Frame_ToggleShowMT:SetButtonTex()
	XPerl_Frame_ToggleMTTargets:SetButtonTex()
	XPerl_Frame_ToggleLabels:SetButtonTex()
end

-- PLAYER_REGEN_ENABLED
function Events:PLAYER_REGEN_ENABLED()
	if (pendingTankListChange) then
		XPerl_MakeTankList()
	end
	DoButtons()
end
Events.PLAYER_ENTERING_WORLD = Events.PLAYER_REGEN_ENABLED

-- PLAYER_REGEN_DISABLED
function Events:PLAYER_REGEN_DISABLED()
	DoButtons(true)

end

-- The number of 'Other' colums that can be shown
local function DisplayableColumns()
	return 1 + conf.ShowMT + conf.MTTargetTargets
end

-- XPerl_SetTitle
function XPerl_SetTitle()
	if (DisplayableColumns() > 1 and conf.UnitWidth >= 70) then
		if (ctraTanks > 0 or blizzMTanks > 0) then
			XPerl_Frame_Title:SetText(XPERL_TITLE_MT_LONG)
		else
			XPerl_Frame_Title:SetText(XPERL_TITLE_WARRIOR_LONG)
		end
	else
		if (ctraTanks > 0 or blizzMTanks > 0) then
			XPerl_Frame_Title:SetText(XPERL_TITLE_MT_SHORT)
		else
			XPerl_Frame_Title:SetText(XPERL_TITLE_WARRIOR_SHORT)
		end
	end
end

local bEdge = {	bgFile = "Interface\\AddOns\\XPerl_RaidHelper\\images\\XPerl_FrameBack",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 9,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	}
local bNoEdge = {bgFile = "Interface\\AddOns\\XPerl_RaidHelper\\images\\XPerl_FrameBack",
		edgeFile = "", tile = true, tileSize = 16, edgeSize = 9,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	}

-- SetVisibility
local function SetVisibility()

	local left = 3 + (conf.MTLabels * 10)
	XPerl_Frame:ClearAllPoints()
	XPerl_Frame_TitleBar:ClearAllPoints()
	XPerl_MTTargets:ClearAllPoints()
	if (conf.MTListUpward == 1) then
		XPerl_Frame:SetPoint("BOTTOMLEFT", XPerl_MTList_Anchor, "BOTTOMLEFT", 0, 0)
		XPerl_Frame_TitleBar:SetPoint("BOTTOMLEFT", 3, 3)
		XPerl_Frame_TitleBar:SetPoint("TOPRIGHT", XPerl_Frame, "BOTTOMRIGHT", -3, 13)
		XPerl_MTTargets:SetAttribute("point", "BOTTOM")
		XPerl_MTTargets:SetPoint("BOTTOMLEFT", left, 13)
	else
		XPerl_Frame:SetPoint("TOPLEFT", XPerl_MTList_Anchor, "TOPLEFT", 0, 0)
		XPerl_Frame_TitleBar:SetPoint("TOPLEFT", 3, -3)
		XPerl_Frame_TitleBar:SetPoint("BOTTOMRIGHT", XPerl_Frame, "TOPRIGHT", -3, -13)
		XPerl_MTTargets:SetAttribute("point", "TOP")
		XPerl_MTTargets:SetPoint("TOPLEFT", left, -13)
	end

	local v, k = XPerl_MTTargets:GetAttribute("child1"), 1
	while (v) do
		-- We don't actually hide the MT if it's not shown, just make it unclickable and no visible content
		if (conf.ShowMT == 1) then
			if (v.hidden or not v.text:IsShown() or not v.healthBar:IsShown()) then
				v.hidden = false
				v.text:Show()
				v.healthBar:Show()
				v.healthBar.text:Show()
				v:EnableMouse(true)

				v:SetBackdrop(bEdge)

				v.target:SetPoint("TOPLEFT", v, "TOPRIGHT", 0, 0)
			end
		else
			if (not v.hidden or v.text:IsShown() or v.healthBar:IsShown()) then
				v.hidden = true
				v.text:Hide()
				v.healthBar:Hide()
				v.healthBar.text:Hide()
				v.combatIcon:Hide()
				v.warningIcon:Hide()
				v.raidIcon:Hide()
				v:EnableMouse(false)

				v:SetBackdrop(nil)		--bNoEdge)

				v.target:SetPoint("TOPLEFT", v, "TOPLEFT", 0, 0)
			end
		end

		UpdateUnit(v)

		if (conf.MTTargetTargets == 1) then
			v.targettarget:Show()
		else
			v.targettarget:Hide()
		end

		local label = v.label
		if (conf.MTLabels == 1) then
			local u = v:GetAttribute("unit")
			if (u) then
				local lbl
				local name = UnitName(u)
				for i,tank in pairs(MainTanks) do
					if (tank[2] == name) then
						lbl = i
						break
					end
				end

				label:SetText(lbl)
				label:Show()
			end
		else
			label:Hide()
		end

		k = k + 1
		v = XPerl_MTTargets:GetAttribute("child"..k)
	end
end

-- XPerl_MakeTankList
function XPerl_MakeTankList()
	if (InCombatLockdown()) then
		pendingTankListChange = true
		return
	else
		pendingTankListChange = nil
	end

	if (not XPerlConfigHelper or (conf and conf.RaidHelper == 0) or GetNumRaidMembers() == 0) then
		XPerl_SetFrameSizes()
		return
	end

	XPerl_SetTitle()
	XPerl_MyTarget:Hide()
	XGaps = 0

	local tanks = new()
	for i = 1,10 do
		if (MainTanks[i]) then
			tinsert(tanks, MainTanks[i][2])
			if (#tanks >= conf.MaxMainTanks) then
				break
			end
		end
	end

	if (#tanks == 0) then
		XPerl_Frame:Hide()
	else
		XPerl_Frame:Show()
		XPerl_Tutorial(12)
	end

	XPerl_MTTargets:SetAttribute("nameList", table.concat(tanks, ","))
	XPerl_MTTargets:Show()

	del(tanks)

	if (XPerl_NoFadeBars) then XPerl_NoFadeBars() end

	XPerl_SetFrameSizes()
end

-- SetUnitSettings
local function SetUnitSettings(self)
	self:SetWidth(conf.UnitWidth)
	self:SetHeight(conf.UnitHeight)

	if (XPerl_GetBarTexture) then
		local tex = XPerl_GetBarTexture()
		self.healthBar.tex:SetTexture(tex)

		if (not XPerlDB or XPerlDB.bar.background) then
			self.healthBar.bg:SetTexture(tex)
		else
			self.healthBar.bg:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
		end
	end

	self.healthBar:ClearAllPoints()
	if (conf.UnitHeight > 16) then
		self.healthBar:SetPoint("TOPLEFT", 3, -14)
		self.healthBar:SetPoint("BOTTOMRIGHT", -3, 2)
	else
		self.healthBar:SetPoint("TOPLEFT", 4, -4)
		self.healthBar:SetPoint("BOTTOMRIGHT", -4, 4)
	end

	if (XPerl_RegisterHighlight) then
		XPerl_RegisterHighlight(self, 3)
	else
		local tex = self:GetHighlightTexture()
		tex:SetVertexColor(0.86, 0.82, 0.41)
	end
end

-- onAttrChanged
local function onAttrChanged(self, name, value)
	if (name == "unit") then
		if (value) then
			UpdateUnit(self)
			UpdateUnit(self.target)
			UpdateUnit(self.targettarget)
		end
	end
end

-- SetChildAttributes(self, child)
--[[
local function SetChildAttributes(self, Type, suffix)

	local frame = self

	frame.type = Type

	if (suffix) then
		frame = CreateFrame("Button", self:GetName()..suffix, self, "XPerl_MTList_UnitTemplate")
		frame:SetAttribute("useparent-unit", true)
		frame:SetAttribute("unitsuffix", suffix)
		frame:SetPoint("TOPLEFT", self.target or self, "TOPRIGHT", 0, 0)
		self[suffix] = frame
	else
		self.hidden = false
	end

	frame:SetAttribute("*type1", "target")

	XPerl_RegisterClickCastFrame(frame)
	SetUnitSettings(frame)
	frame:SetScript("OnShow", UpdateUnit)

	if (not suffix) then
		self:SetScript("OnAttributeChanged", onAttrChanged)
	end

	frame:Show()
	tinsert(XUnits, frame)
end

function XPerl_MTList_ChildUnits(self)
	SetChildAttributes(self, "MT")
	SetChildAttributes(self, "MTT", "target")
	SetChildAttributes(self, "MTTT", "targettarget")
end
]]

-- XPerl_MTList_ChildUnits
function XPerl_MTList_ChildUnits(self)
	self.type = "MT"
	self.hidden = false
	self:SetAttribute("*type1", "target")
	XPerl_RegisterClickCastFrame(self)
	SetUnitSettings(self)

	local c1 = CreateFrame("Button", self:GetName().."Target", self, "XPerl_MTList_UnitTemplate")
	c1.type = "MTT"
	c1:SetAttribute("useparent-unit", true)
	c1:SetAttribute("unitsuffix", "target")
	c1:SetAttribute("*type1", "target")
	XPerl_RegisterClickCastFrame(c1)

	c1:SetPoint("TOPLEFT", self, "TOPRIGHT", 0, 0)
	SetUnitSettings(c1)

	local c2 = CreateFrame("Button", self:GetName().."TargetTarget", self, "XPerl_MTList_UnitTemplate")
	c2.type = "MTTT"
	c2:SetAttribute("useparent-unit", true)
	c2:SetAttribute("unitsuffix", "targettarget")
	c2:SetAttribute("*type1", "target")
	XPerl_RegisterClickCastFrame(c2)

	c2:SetPoint("TOPLEFT", c1, "TOPRIGHT", 0, 0)
	SetUnitSettings(c2)

	self.target = c1
	self.targettarget = c2

	self:SetScript("OnShow", UpdateUnit)
	c1:SetScript("OnShow", UpdateUnit)
	c2:SetScript("OnShow", UpdateUnit)

	self:SetScript("OnAttributeChanged", onAttrChanged)

	self:Show()
	c1:Show()
	c2:Show()

	tinsert(XUnits, self)
	tinsert(XUnits, c1)
	tinsert(XUnits, c2)
end

-- XPerl_SetFrameSizes
function XPerl_SetFrameSizes()
	conf = XPerlConfigHelper
	local tanks = MainTankCount

	if (XPerlConfigHelper) then
		SetVisibility()		-- Change which of MT, MTT and MTTT we can see
		ScanForMTDups()

		if (tanks > conf.MaxMainTanks) then
			tanks = conf.MaxMainTanks
		end

		XPerl_SwitchAnchor(XPerl_MTList_Anchor, (conf.MTListUpward == 1 and "BOTTOMLEFT") or "TOPLEFT")

		if (conf) then
			XPerl_MTTargets:SetHeight((conf.UnitHeight * tanks) + (XGaps * GAP_SPACING))

			local ExtraWidth = (conf.MTLabels * 10);	-- 0 for off, 10 for on
			XPerl_Frame:SetWidth(DisplayableColumns() * conf.UnitWidth + 6 + ExtraWidth)

			XPerl_Frame:SetHeight((conf.UnitHeight * tanks) + (XGaps * GAP_SPACING) + 6 + XPerl_Frame_TitleBar:GetHeight())

			XPerl_RegisterScalableFrame(XPerl_Frame, XPerl_MTList_Anchor, nil, nil, conf.MTListUpward == 1)
		end
		XPerl_Frame_Pin:SetButtonTex()

		CheckArrowPosition()
	end
end

-- XPerl_MTList_ApplyUnitSizes
function XPerl_MTList_ApplyUnitSizes()
	for k,unit in pairs(XUnits) do
		unit:SetWidth(conf.UnitWidth)
		unit:SetHeight(conf.UnitHeight)
		UpdateUnit(unit)
	end
end

-- XPerl_Toggle_UseCTRATargets
function XPerl_Toggle_UseCTRATargets()
	if (conf.UseCTRATargets == 1) then
		conf.UseCTRATargets = 0
	else
		conf.UseCTRATargets = 1
	end

	--XPerl_MTRosterChanged()
	XPerl_RaidHelperCheck:Show()		-- XPerl_EnableDisable()
	return true
end

function XPerl_Toggle_MTTargets()
	if (conf.MTTargetTargets == 1) then
		conf.MTTargetTargets = 0
	else
		conf.MTTargetTargets = 1
	end

	XPerl_SetFrameSizes()

	XPerl_Frame_ToggleMTTargets:SetButtonTex()
	return true
end

-- XPerl_Toggle_ToggleLabels
function XPerl_Toggle_ToggleLabels()
	if (conf.MTLabels == 1) then
		conf.MTLabels = 0
	else
		conf.MTLabels = 1
	end

	XPerl_SetFrameSizes()

	XPerl_Frame_ToggleLabels:SetButtonTex()

	return true
end

function XPerl_Toggle_ShowMT()
	if (conf.ShowMT == 1) then
		conf.ShowMT = 0
	else
		conf.ShowMT = 1
	end

	XPerl_SetFrameSizes()

	XPerl_Frame_ToggleShowMT:SetButtonTex()

	return true
end

-- SmoothBarColor
local function SmoothBarColor(bar, barBG)
	local barmin, barmax = bar:GetMinMaxValues()
	local percentage = (bar:GetValue()/(barmax-barmin))

	local r, g
	if (percentage < 0.5) then
		r = 2*percentage
		g = 1
	else
		r = 1
		g = 2*(1 - percentage)
	end

	if ((r>=0) and (g>=0) and (r<=1) and (g<=1)) then
		bar:SetStatusBarColor(r, g, 0)
		barBG:SetVertexColor(r, g, 0, 0.25)
	end
end
