-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

local conf
local percD	= "%d"..PERCENT_SYMBOL
local perc1F = "%.1f"..PERCENT_SYMBOL
XPerl_RequestConfig(function(New) conf = New end, "$Revision: 401 $")
XPerl_SetModuleRevision("$Revision: 401 $")

-- Some local copies for speed
local strsub = strsub
local format = format
local cos, sin, abs = cos, sin, abs
local max = math.max
local min = math.min
local IsItemInRange = IsItemInRange
local IsSpellInRange = IsSpellInRange
local UnitBuff = UnitBuff
local UnitDebuff = UnitDebuff
local UnitCanAssist = UnitCanAssist
local UnitCanAttack = UnitCanAttack
local UnitClass = UnitClass
local UnitExists = UnitExists
local UnitFactionGroup = UnitFactionGroup
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitIsEnemy = UnitIsEnemy
local UnitIsPVP = UnitIsPVP
local UnitIsTapped = UnitIsTapped
local UnitIsVisible = UnitIsVisible
local UnitPlayerControlled = UnitPlayerControlled
local UnitReaction = UnitReaction
local GetNumRaidMembers = GetNumRaidMembers
local GetNumPartyMembers = GetNumPartyMembers
local GetRaidRosterInfo = GetRaidRosterInfo
local largeNumDiv = XPERL_LOC_LARGENUMDIV
local largeNumTag = XPERL_LOC_LARGENUMTAG
local hugeNumDiv = XPERL_LOC_HUGENUMDIV
local hugeNumTag = XPERL_LOC_HUGENUMTAG
local hugeNumDiv10 = hugeNumDiv * 10
local largeNumDiv100 = largeNumDiv * 100
local ArcaneExclusions = XPerl_ArcaneExclusions
local GetDifficultyColor = GetDifficultyColor or GetQuestDifficultyColor
local is_cata = select(4, _G.GetBuildInfo()) >= 40000

------------------------------------------------------------------------------
-- Re-usable tables
local FreeTables = setmetatable({}, {__mode = "k"})
local requested, freed = 0, 0
function XPerl_GetReusableTable(...)
	requested = requested + 1
	for t in pairs(FreeTables) do
		FreeTables[t] = nil
		for i = 1, select("#", ...) do
			t[i] = select(i, ...)
		end
		return t
	end
	return {...}
end
function XPerl_FreeTable(t, deep)
	if (t) then
		if (type(t) ~= "table") then
			error("Usage: XPerl_FreeTable([table])")
		end
		if (FreeTables[t]) then
			error("XPerl_FreeTable - Table already freed")
		end

		freed = freed + 1

		FreeTables[t] = true
		for k,v in pairs(t) do
			if (deep and type(v) == "table") then
				XPerl_FreeTable(v, true)
			end
			t[k] = nil
		end
		t[''] = 0
		t[''] = nil
	end
end
function XPerl_TableStats()
	return requested, freed
end

local new, del = XPerl_GetReusableTable, XPerl_FreeTable

local function rotate(angle)
	local A = cos(angle)
	local B = sin(angle)
	local ULx, ULy = -0.5 * A - -0.5 * B, -0.5 * B + -0.5 * A
	local LLx, LLy = -0.5 * A - 0.5 * B, -0.5 * B + 0.5 * A
	local URx, URy = 0.5 * A - -0.5 * B, 0.5 * B + -0.5 * A
	local LRx, LRy = 0.5 * A - 0.5 * B, 0.5 * B + 0.5 * A
	return ULx+0.5, ULy+0.5, LLx+0.5, LLy+0.5, URx+0.5, URy+0.5, LRx+0.5, LRy+0.5
end

-- meta table for string based colours. Allows for other mods changing class colours and things all working
XPerlColourTable = setmetatable({},{
	__index = function(self, class)
		local c = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[strupper(class or "")]
		if (c) then
			c = format("|c00%02X%02X%02X", 255 * c.r, 255 * c.g, 255 * c.b)
		else
			c = "|c00808080"
		end
		self[class] = c
		return c
	end
})

-- Dummy Tutorial function if it's not enabled
if (not XPerl_Tutorial) then
	function XPerl_Tutorial()
	end
end

--XPerl_Percent = setmetatable({},
--	{__mode = "kv",
--	__index = function(self, i)
--		if (type(i) == "number" and i >= 0) then
--			self[i] = format(percD, i)
--			return self[i]
--		end
--		return ""
--	end
--	})
--local xpPercent = XPerl_Percent

-- XPerl_ShowMessage
-- debug function
function XPerl_ShowMessage(cMsg)
	local str = "|c00FF7F00"..event.."|r"
	local theEnd
	if (arg1 and (arg1 == "player" or arg1 == "pet" or arg1 == "target" or arg1 =="focus" or strfind(arg1, "^raid") or strfind(arg1, "^party"))) then
		local class = select(2, UnitClass(arg1))
		if (class) then
			str = str..", |c00808080"..tostring(arg1).."("..XPerlColourTable[class]..UnitName(arg1).."|c00808080)|r"
			theEnd = 2
		end
	else
		theEnd = 1
	end

	local tail, doit = ""
	for i = 9,theEnd,-1 do
		local v = _G["arg"..i]
		if (v or doit) then
			if (tail ~= "") then
				tail = tostring(v)..", "..tail
			else
				tail = tostring(v)
			end
			doit = true
		end
	end
	if (tail ~= "") then
		str = str..", "..tail
	end

	if (cMsg) then
		str = cMsg.." - "..str
	end

	local cf = ChatFrame2
	if (not cf:IsVisible()) then
		cf = DEFAULT_CHAT_FRAME
	end
	if (self and self.GetName and self:GetName()) then
		cf:AddMessage("|c00007F7F"..self:GetName().."|r - "..str)
	else
		cf:AddMessage(str)
	end
end

XPerl_AnchorList = {"TOP", "LEFT", "BOTTOM", "RIGHT"}

-- FindABandage()
local function FindABandage()
	local bandages = {
		[34722] = true, -- Heavy Frostweave Bandage
		[34721] = true,	-- Frostweave Bandage
		[21991] = true, -- Heavy Netherweave Bandage
		[21990] = true, -- Netherweave Bandage
		[14530] = true, -- Heavy Runecloth Bandage
		[14529] = true, -- Runecloth Bandage
		[8545] = true, -- Heavy Mageweave Bandage
		[8544] = true, -- Mageweave Bandage
		[6451] = true, -- Heavy Silk Bandage
		[6450] = true, -- Silk Bandage
		[3531] = true, -- Heavy Wool Bandage
		[3530] = true, -- Wool Bandage
		[2581] = true, -- Heavy Linen Bandage
		[1251] = true, -- Linen Bandage
	}

	for k,v in pairs(bandages) do
		if (GetItemCount(k) > 0) then
			return GetItemInfo(k)
		end
	end
end

local playerClass

-- We have a dummy do-nothing function here for classes that don't have range checking
-- The do-something function is setup after variables_loaded and we work out spell to use just once
function XPerl_UpdateSpellRange()
	return
end

-- DoRangeCheck
local function DoRangeCheck(unit, opt)
	local range
	if (opt.PlusHealth) then
		local hp, hpMax = UnitHealth(unit), UnitHealthMax(unit)
		if (hp / hpMax > opt.HealthLowPoint) then
			range = 0
		end
	end

	if (opt.PlusDebuff and ((opt.PlusHealth and range == 0) or not opt.PlusHealth)) then
		local name = UnitDebuff(unit, 1, "RAID")
		if (not name) then
			range = 0
		else
			if (ArcaneExclusions[name]) then
				-- It's one of the filtered debuffs, so we have to iterate thru all debuffs to see if anything is curable
				for i = 2,100 do
					local name = UnitDebuff(unit, i, "RAID")
					if (not name) then
						range = 0
						break
					elseif (not ArcaneExclusions[name]) then
						range = nil
						break
					end
				end
			else
				range = nil		-- Override's the health check, because there's a debuff on unit
			end
		end
	end

	if (not range) then
		if (opt.interact) then
			if (opt.interact == 5) then
				range = UnitInRange(unit)			-- 40 yards
			else
				range = CheckInteractDistance(unit, opt.interact)
			end
			-- 1 = Inspect = 30 yards
			-- 2 = Trade = 11.11 yards
			-- 3 = Duel = 10 yards
			-- 4 = Follow = 28 yards
		elseif (opt.spell) then
			range = IsSpellInRange(opt.spell, unit)
		elseif (opt.item) then
			range = IsItemInRange(opt.item, unit)
		else
			range = 1
		end
	end

	if (range ~= 1) then
		return opt.FadeAmount
	end
end

-- XPerl_UpdateSpellRange(self)
function XPerl_UpdateSpellRange2(self, overrideUnit, isRaidFrame)
	local unit
	if (overrideUnit) then
		unit = overrideUnit
	else
		unit = self:GetAttribute("unit")
		if (not unit) then
			unit = SecureButton_GetUnit(self)
		end
	end
	if (unit) then
		local rf = conf.rangeFinder
		local mainA, nameA, statsA		-- Receives main, name and stats alpha levels

		if (rf.enabled and (isRaidFrame or not conf.rangeFinder.raidOnly)) then
			if (not UnitIsVisible(unit)) or UnitInVehicle(unit) then
				if (rf.Main.enabled) then
					mainA = conf.transparency.frame * rf.Main.FadeAmount
				else
					if (rf.NameFrame.enabled) then
						nameA = rf.NameFrame.FadeAmount
					end
					if (rf.StatsFrame.enabled) then
						statsA = rf.StatsFrame.FadeAmount
					end
				end

			--elseif (XPerl_Highlight:HasEffect(UnitName(unit), "AGGRO")) then
			--	mainA = conf.transparency.frame

			elseif (UnitCanAssist("player", unit)) then
				if (rf.Main.enabled) then
					mainA = DoRangeCheck(unit, rf.Main)
					if (mainA) then
						mainA = mainA * conf.transparency.frame
					end
				end

				if (rf.NameFrame.enabled) then
					-- check for same item/spell. Saves doing the check multiple times
					if (rf.Main.enabled and (rf.Main.spell == rf.NameFrame.spell) and (rf.Main.item == rf.NameFrame.item) and (rf.Main.PlusHealth == rf.NameFrame.PlusHealth)) then
						if (mainA) then
							nameA = rf.NameFrame.FadeAmount
						end
					else
						nameA = DoRangeCheck(unit, rf.NameFrame)
						if (not nameA and mainA) then
							-- In range, but 'Whole' frame is out of range, so we need to override the fade for name
							nameA = 1
						end
					end
				end
				if (rf.StatsFrame.enabled) then
					-- check for same item/spell. Saves doing the check multiple times
					if (rf.Main.enabled and (rf.Main.spell == rf.StatsFrame.spell) and (rf.Main.item == rf.StatsFrame.item) and (rf.Main.PlusHealth == rf.StatsFrame.PlusHealth)) then
						if (mainA) then
							statsA = rf.StatsFrame.FadeAmount
						end
					else
						statsA = DoRangeCheck(unit, rf.StatsFrame)
						if (not statsA and mainA) then
							-- In range, but 'Whole' frame is out of range, so we need to override the fade for stats
							statsA = 1
						end
					end
				end
			end
		end

		local forcedMainA
		if (not mainA) then
			if (UnitIsConnected(unit)) then
				mainA = conf.transparency.frame
				forcedMainA = true
			else
				mainA = conf.transparency.frame * rf.Main.FadeAmount
				nameA, statsA = mainA
				forcedMainA = true
			end
		end

--if (self == XPerl_Target) then
--   ChatFrame7:AddMessage(format("%4s %4s %4s", tostring(mainA), tostring(nameA), tostring(statsA)))
--end

		self:SetAlpha(mainA)
		if (self.nameFrame) then
			if (nameA or forcedMainA) then
				self.nameFrame:SetAlpha(nameA or mainA)
			else
				self.nameFrame:SetAlpha(1)
			end
		end
		if (self.statsFrame) then
			if (nameA or forcedMainA) then
				self.statsFrame:SetAlpha(statsA or mainA)
			else
				self.statsFrame:SetAlpha(1)
			end
		end
	end
end

-- XPerl_StartupSpellRange()
function XPerl_StartupSpellRange()
	local _
	_, playerClass = UnitClass("player")

	if (not XPerl_DefaultRangeSpells.ANY) then
		XPerl_DefaultRangeSpells.ANY = {}
	end

	local b = FindABandage()
	if (b) then
		XPerl_DefaultRangeSpells.ANY.item = b
	end

	local rf = conf.rangeFinder

	local function Setup1(self)
		local bCanUse
		if (self.spell) then
			bCanUse = GetSpellInfo(self.spell)
		end
		if ((type(self.spell) ~= "string" and type(self.item) ~= "string") or not bCanUse) then
			self.spell = XPerl_DefaultRangeSpells[playerClass] and XPerl_DefaultRangeSpells[playerClass].spell
			if (type(self.spell) ~= "string") then
				self.item = (XPerl_DefaultRangeSpells.ANY and XPerl_DefaultRangeSpells.ANY.item) or ""
			end
		end

		if (not self.FadeAmount) then
			self.FadeAmount = 0.3
		end
		if (not self.HealthLowPoint) then
			self.HealthLowPoint = 0.7
		end
	end

	Setup1(rf.Main)
	Setup1(rf.NameFrame)
	Setup1(rf.StatsFrame)

	--if (rangeCheckSpell) then
		-- Put the real work function in place
		XPerl_UpdateSpellRange = XPerl_UpdateSpellRange2
	--else
	--	XPerl_UpdateSpellRange = function() end
	--end
end

XPerl_RegisterOptionChanger(XPerl_StartupSpellRange)

-- XPerl_StatsFrame_SetGrey
local function XPerl_StatsFrame_SetGrey(self, r, g, b)
	if (not r) then
		r, g, b = 0.5, 0.5, 0.5
	end

	self.healthBar:SetStatusBarColor(r, g, b, 1)
	self.healthBar.bg:SetVertexColor(r, g, b, 0.5)
	if (self.manaBar) then
		self.manaBar:SetStatusBarColor(r, g, b, 1)
		self.manaBar.bg:SetVertexColor(r, g, b, 0.5)
	end
	self.greyMana = true
end

-- XPerl_SetChildMembers - Recursive
-- This iterates a frame's child frames and regions and assigns member variables
-- based on the sub-set part of the child's name compared to the parent frame name
function XPerl_SetChildMembers(self)
	local n = self:GetName()
	if (n) then
		local match = "^"..n.."(.+)$"

		local function AddList(list)
			for k,v in pairs(list) do
				local t = v:GetName()
				if (t) then
					local found = strmatch(t, match)
					if (found) then
						--if (self[found] == v) then
						--	break		-- Already done
						--end
						self[found] = v
					end
				end
			end
		end

		AddList({self:GetRegions()})

		local c = {self:GetChildren()}
		AddList(c, true)

		for k,v in pairs(c) do
			if (v:GetName()) then
				XPerl_SetChildMembers(v)
			end
			v:SetScript("OnLoad", nil)
		end

		self:SetScript("OnLoad", nil)
	end
end

do
	local shortlist
	local list
	local media

	-- XPerl_RegisterSMBarTextures
	function XPerl_RegisterSMBarTextures()
		if (LibStub) then
			media = LibStub("LibSharedMedia-3.0", true)
			if (not media) then
				media = LibStub("SharedMedia-2.0", true)
				if (not media) then
					media = LibStub("SharedMedia-1.0", true)
				end
			end
		end

		shortlist = {
			{"Perl v2", "Interface\\Addons\\XPerl\\Images\\XPerl_StatusBar"},
		}
		for i = 1,9 do
			local name = i == 2 and "BantoBar" or "X-Perl "..i
			tinsert(shortlist, {name, "Interface\\Addons\\XPerl\\Images\\XPerl_StatusBar"..(i + 1)})
		end

		if (media) then
			for k,v in pairs(shortlist) do
				media:Register("statusbar", v[1], v[2])
			end

			media:Register("border", "X-Perl Thin", "Interface\\Addons\\XPerl\\images\\XPerl_ThinEdge")
		end
	end

	-- XPerl_AllBarTextures
	function XPerl_AllBarTextures(short)
		if (not list) then
			if (short) then
				return shortlist
			end

			if (media) then
				list = {}
				local smlBars = media:List("statusbar")
				for k,v in pairs(smlBars) do
					tinsert(list, {v, media:Fetch("statusbar", v)})
				end
			else
				list = shortlist
			end
		end

		return list
	end
end

-- XPerl_GetBarTexture
function XPerl_GetBarTexture()
	return (conf.bar and conf.bar.texture and conf.bar.texture[2]) or "Interface\\TargetingFrame\\UI-StatusBar"
end

-- XPerl_StatsFrame_Setup
function XPerl_StatsFrame_Setup(self)
	XPerl_SetChildMembers(self)
	self.SetGrey = XPerl_StatsFrame_SetGrey
end

-- XPerl_GetClassColour
local defaultColour = {r = 0.5, g = 0.5, b = 1}
function XPerl_GetClassColour(class)
	return (class and (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]) or defaultColour
end

---------------------------------
--Loading Function             --
---------------------------------

-- XPerl_BlizzFrameDisable
function XPerl_BlizzFrameDisable(self)
	if (self) then
		UnregisterUnitWatch(self)		-- Should stop Archaeologist from re-showing target frame
		self:UnregisterAllEvents()
		self:Hide()
		-- Make it so it won't be visible, even if shown by another mod
		self:ClearAllPoints()
		self:SetPoint("BOTTOMLEFT", UIParent, "TOPLEFT", -400, 500)

		local healthBar = _G[self:GetName().."HealthBar"]
		if (healthBar) then
			healthBar:UnregisterAllEvents()
		end

		local manaBar = _G[self:GetName().."ManaBar"]
		if (manaBar) then
			manaBar:UnregisterAllEvents()
		end
	end
end

-- smoothColor
local function smoothColor(percentage)
	local r, g, b
	if (percentage < 0.5) then
		r = 1
		g = min(1, max(0, 2*percentage))
		b = 0
	else
		g = 1
		r = min(1, max(0, 2*(1 - percentage)))
		b = 0
	end

	return r, g, b
end

---------------------------------
--Smooth Health Bar Color      --
---------------------------------
function XPerl_SetSmoothBarColor(self, percentage)
	if (self) then
		local r, g, b
		if (conf.colour.classic) then
			r, g, b = smoothColor(percentage)
		else
			local c = conf.colour.bar
			r = min(1, max(0, c.healthEmpty.r + ((c.healthFull.r - c.healthEmpty.r) * percentage)))
			g = min(1, max(0, c.healthEmpty.g + ((c.healthFull.g - c.healthEmpty.g) * percentage)))
			b = min(1, max(0, c.healthEmpty.b + ((c.healthFull.b - c.healthEmpty.b) * percentage)))
		end

		self:SetStatusBarColor(r, g, b)

		if (self.bg) then
			self.bg:SetVertexColor(r, g, b, 0.25)
		end
	end
end

local barColours
function XPerl_ResetBarColourCache()
	barColours = setmetatable({}, {
		__index = function(self, k)
			local c = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[k]
			if (c) then
				if (not conf.colour.classbarBright) then
					conf.colour.classbarBright = 1
				end
				self[k] = {	r = max(0, min(1, c.r * conf.colour.classbarBright)),
						g = max(0, min(1, c.g * conf.colour.classbarBright)),
						b = max(0, min(1, c.b * conf.colour.classbarBright))}
				return self[k]
			end
		end
	})
end
XPerl_ResetBarColourCache()

-- XPerl_ColourHealthBar
function XPerl_ColourHealthBar(self, healthPct, partyid)
	if (not partyid) then
		partyid = self.partyid
	end
	local bar = self.statsFrame.healthBar
	if (conf.colour.classbar and UnitIsPlayer(partyid)) then
		local class = select(2, UnitClass(partyid))
		if (class) then
			local c = barColours[class]
			if (c) then
				bar:SetStatusBarColor(c.r, c.g, c.b)
				if (bar.bg) then
					bar.bg:SetVertexColor(c.r, c.g, c.b, 0.25)
				end
				return
			end
		end
	end

	XPerl_SetSmoothBarColor(bar, healthPct)
end
local XPerl_ColourHealthBar = XPerl_ColourHealthBar

-- XPerl_SetValuedText
function XPerl_SetValuedText(self, current, Max, suffix)
	if (Max >= hugeNumDiv) then
		if (abs(current) < largeNumDiv100) then
			-- 123/12.3M
			self:SetFormattedText("%d/%.1f%s%s", current, Max / hugeNumDiv, hugeNumTag, suffix or "")
		else
			if (abs(current) >= hugeNumDiv) then
				-- 1.2M/12.3M
				self:SetFormattedText("%.1f%s/%.1f%s%s", current / hugeNumDiv, hugeNumTag, Max / hugeNumDiv, hugeNumTag, suffix or "")
			else
				-- 12.3K/12.3M
				self:SetFormattedText("%.1f%s/%.1f%s%s", current / largeNumDiv, largeNumTag, Max / hugeNumDiv, hugeNumTag, suffix or "")
			end
		end
	else
		if (Max > largeNumDiv100) then
			if (abs(current) < largeNumDiv100) then
				-- 123/123.4K
				self:SetFormattedText("%d/%.1f%s%s", current, Max / largeNumDiv, largeNumTag, suffix or "")
			else
				-- 12345/123.4K
				self:SetFormattedText("%.1f%s/%.1f%s%s", current / largeNumDiv, largeNumTag, Max / largeNumDiv, largeNumTag, suffix or "")
			end
		else
			-- 12345/12345
			self:SetFormattedText("%d/%d%s", current, Max, suffix or "")
		end
	end
end
local SetValuedText = XPerl_SetValuedText

-- XPerl_SetHealthBar
function XPerl_SetHealthBar(self, hp, Max)
	local bar = self.statsFrame.healthBar

	bar:SetMinMaxValues(0, Max)
    local percent = max(0, hp / Max) -- Fix for SetFormatted text displaying -21474... for 0 / 0			
            
    if (conf.bar.inverse) then

		bar:SetValue(Max - hp)
		bar.tex:SetTexCoord(0, max(0,(1 - percent)), 0, 1)
	
	else

		bar:SetValue(hp)
		bar.tex:SetTexCoord(0, max(0, percent), 0, 1)
	
	end

	XPerl_ColourHealthBar(self, percent)
	if (bar.percent) then
		if (self.conf.healerMode and self.conf.healerMode.enable and self.conf.healerMode.type == 2) then
			bar.percent:SetText(hp - Max)
		else
			local show = percent * 100
			if (show < 10) then
				bar.percent:SetFormattedText(perc1F or "%.1f%%", show + 0.05)
			else
				bar.percent:SetFormattedText(percD or "%d%%", show + 0.5)
			end
		end
	end

	if (bar.text) then
		local hbt = bar.text
		if (self.conf.healerMode.enable and self.conf.healerMode.type ~= 2) then
			local health = hp - Max
			if (self.conf.healerMode.type == 1) then
				SetValuedText(hbt, health, Max)
			else
				if (abs(health) >= hugeNumDiv10) then
					hbt:SetFormattedText("%d%s", health / hugeNumDiv, hugeNumTag)
				elseif (abs(health) >= largeNumDiv100) then
					hbt:SetFormattedText("%d%s", health / largeNumDiv, largeNumTag)
				else
					hbt:SetFormattedText("%d", health)
				end
			end
		else
			SetValuedText(hbt, hp, Max)
		end
	end
	XPerl_SetExpectedHealth(self)
end

---------------------------------
--Class Icon Location Functions--
---------------------------------
--local ClassPos = {
--	WARRIOR	= {0,    0.25,    0,	0.25},
--	MAGE	= {0.25, 0.5,     0,	0.25},
--	ROGUE	= {0.5,  0.75,    0,	0.25},
--	DRUID	= {0.75, 1,       0,	0.25},
--	HUNTER	= {0,    0.25,    0.25,	0.5},
--	SHAMAN	= {0.25, 0.5,     0.25,	0.5},
--	PRIEST	= {0.5,  0.75,    0.25,	0.5},
--	WARLOCK	= {0.75, 1,       0.25,	0.5},
--	PALADIN	= {0,    0.25,    0.5,	0.75},
--	none	= {0.25, 0.5, 0.5, 0.75},
--}
--function XPerl_ClassPos(class)
--	return unpack(ClassPos[class] or ClassPos.none)
--end

local ClassPos = CLASS_BUTTONS
function XPerl_ClassPos(class)
	local b = ClassPos[class]		-- Now using the Blizzard supplied from FrameXML/WorldStateFrame.lua
	if (b) then
		return unpack(b)
	end
	return 0.25, 0.5, 0.5, 0.75
end

-- XPerl_Toggle
function XPerl_Toggle()
	if (XPerlLocked == 1) then
		XPerl_UnlockFrames()
	else
		XPerl_LockFrames()
	end
end

-- XPerl_UnlockFrames
function XPerl_UnlockFrames()
	XPerl_LoadOptions()

	XPerlLocked = 0

	if (XPerl_Party_Virtual) then
		XPerl_Party_Virtual(true)
	end

	if (XPerl_Player_Pet_Virtual) then
		XPerl_Player_Pet_Virtual(true)
	end

	if (XPerl_AggroAnchor) then
		XPerl_AggroAnchor:Enable()
	end

	if (XPerl_Player) then
		if (XPerl_Player.runes) then
			XPerl_Player.runes:EnableMouse(true)
		end
	end

	if (XPerl_Options) then
		XPerl_Tutorial(7)
		XPerl_Options:Show()
		XPerl_Options:SetAlpha(0)
		XPerl_Options.Fading = "in"
	end

	if (XPerl_RaidTitles) then
		XPerl_RaidTitles()
		if (XPerl_RaidPets_Titles) then
			XPerl_RaidPets_Titles()
		end
	end
end

-- XPerl_LockFrames
function XPerl_LockFrames()
	XPerlLocked = 1
	if (XPerl_Options) then
		XPerl_Options.Fading = "out"
	end

	if (XPerl_Party_Virtual) then
		XPerl_Party_Virtual()
	end

	if (XPerl_Player_Pet_Virtual) then
		XPerl_Player_Pet_Virtual()
	end

	if (XPerl_AggroAnchor) then
		XPerl_AggroAnchor:Disable()
	end

	if (XPerl_Player) then
		if (XPerl_Player.runes) then
			XPerl_Player.runes:EnableMouse(false)
		end
	end

	if (XPerl_RaidTitles) then
		XPerl_RaidTitles()
		if (XPerl_RaidPets_Titles) then
			XPerl_RaidPets_Titles()
		end
	end

	XPerl_OptionActions()
end

-- Minimap Icon
function XPerl_MinimapButton_OnClick(self, button)
	GameTooltip:Hide()
	if (button == "LeftButton") then
		XPerl_Toggle()
	elseif (button == "RightButton") then
		XPerl_MinimapMenu(self)
	end
end

-- XPerl_MinimapMenu_OnLoad
function XPerl_MinimapMenu_OnLoad(self)
	self.displayMode = "MENU"
	UIDropDownMenu_Initialize(self, XPerl_MinimapMenu_Initialize)
end

-- XPerl_MinimapMenu_Initialize
function XPerl_MinimapMenu_Initialize(self, level)
	local info

	if (level == 2) then
		if (UIDROPDOWNMENU_MENU_VALUE == "raidbuffs") then
			info = UIDropDownMenu_CreateInfo()
			info.isTitle = 1
			info.text = XPERL_MINIMENU_RAIDBUFF
			UIDropDownMenu_AddButton(info, level)

			info = UIDropDownMenu_CreateInfo()
			info.notCheckable = 1
			info.text = BINDING_NAME_TOGGLEBUFFCASTABLE
			info.func = function() XPerl_ToggleRaidBuffs(1) end
			UIDropDownMenu_AddButton(info, level)

			info = UIDropDownMenu_CreateInfo()
			info.notCheckable = 1
			info.text = BINDING_NAME_TOGGLEBUFFTYPE
			info.func = XPerl_ToggleRaidBuffs
			UIDropDownMenu_AddButton(info, level)

		elseif (UIDROPDOWNMENU_MENU_VALUE == "raidsort") then

			info = UIDropDownMenu_CreateInfo()
			info.isTitle = 1
			info.text = XPERL_MINIMENU_RAIDSORT
			UIDropDownMenu_AddButton(info, level)

			info = UIDropDownMenu_CreateInfo()
			info.checked = XPerlDB.raid.sortByClass == 1
			info.text = XPERL_MINIMENU_RAIDSORT_GROUP
			info.func = function() XPerl_ToggleRaidSort(1) end
			UIDropDownMenu_AddButton(info, level)

			info = UIDropDownMenu_CreateInfo()
			info.checked = XPerlDB.raid.sortByClass == nil
			info.text = XPERL_MINIMENU_RAIDSORT_CLASS
			info.func = function() XPerl_ToggleRaidSort(0) end
			UIDropDownMenu_AddButton(info, level)
		end
		return
	end

	info = UIDropDownMenu_CreateInfo()
	info.isTitle = 1
	info.text = XPerl_ProductName
	UIDropDownMenu_AddButton(info)

	info = UIDropDownMenu_CreateInfo()
	info.notCheckable = 1
	info.func = XPerl_Toggle
	info.text = XPERL_MINIMENU_OPTIONS
	UIDropDownMenu_AddButton(info)

	if (XPerl_ToggleRaidBuffs) then
		info = UIDropDownMenu_CreateInfo()
		info.notCheckable = 1
		info.text = XPERL_MINIMENU_RAIDBUFF
		info.hasArrow = 1
		info.value = "raidbuffs"
		UIDropDownMenu_AddButton(info)
	end

	if (XPerl_ToggleRaidSort) then
		info = UIDropDownMenu_CreateInfo()
		info.notCheckable = 1
		info.text = XPERL_MINIMENU_RAIDSORT
		info.hasArrow = 1
		info.value = "raidsort"
		UIDropDownMenu_AddButton(info)
	end

	if (IsAddOnLoaded("XPerl_RaidHelper")) then
		if (XPerl_Assists_Frame and not XPerl_Assists_Frame:IsShown()) then
			info = UIDropDownMenu_CreateInfo()
			info.notCheckable = 1
			info.text = XPERL_MINIMENU_ASSIST
			info.func = function()
					XPerlConfigHelper.AssistsFrame = 1
					XPerlConfigHelper.TargettingFrame = 1
					XPerl_SetFrameSides()
				end
			UIDropDownMenu_AddButton(info)
		end
	end

	if (IsAddOnLoaded("XPerl_RaidMonitor")) then
		if (XPerl_RaidMonitor_Frame and not XPerl_RaidMonitor_Frame:IsShown()) then
			info = UIDropDownMenu_CreateInfo()
			info.notCheckable = 1
			info.text = XPERL_MINIMENU_CASTMON
			info.func = function()
					XPerlRaidMonConfig.enabled = 1
					XPerl_RaidMonitor_Frame:SetFrameSizes()
				end
			UIDropDownMenu_AddButton(info)
		end
	end

	if (IsAddOnLoaded("XPerl_RaidAdmin")) then
		if (XPerl_AdminFrame and not XPerl_AdminFrame:IsShown()) then
			info = UIDropDownMenu_CreateInfo()
			info.notCheckable = 1
			info.text = XPERL_MINIMENU_RAIDAD
			info.func = function() XPerl_AdminFrame:Show() end
			UIDropDownMenu_AddButton(info)
		end

		if (XPerl_Check and not XPerl_Check:IsShown()) then
			info = UIDropDownMenu_CreateInfo()
			info.notCheckable = 1
			info.text = XPERL_MINIMENU_ITEMCHK
			info.func = function() XPerl_Check:Show() end
			UIDropDownMenu_AddButton(info)
		end

		if (XPerl_RosterText and not XPerl_RosterText:IsShown()) then
			info = UIDropDownMenu_CreateInfo()
			info.notCheckable = 1
			info.text = XPERL_MINIMENU_ROSTERTEXT
			info.func = function() XPerl_RosterText:Show() end
			UIDropDownMenu_AddButton(info)
		end
	end
end

-- XPerl_MinimapMenu
function XPerl_MinimapMenu(self)
	if (not XPerl_Minimap_Dropdown) then
		CreateFrame("Frame", "XPerl_Minimap_Dropdown")
		XPerl_MinimapMenu_OnLoad(XPerl_Minimap_Dropdown)
	end

	ToggleDropDownMenu(1, nil, XPerl_Minimap_Dropdown, "cursor", 0, 0)
end

local xpModList = {"XPerl", "XPerl_Player", "XPerl_PlayerBuffs", "XPerl_PlayerPet", "XPerl_Target", "XPerl_TargetTarget", "XPerl_Party", "XPerl_PartyPet", "XPerl_ArcaneBar", "XPerl_HUD", "XPerl_RaidFrames", "XPerl_RaidHelper", "XPerl_RaidAdmin", "XPerl_RaidMonitor", "XPerl_RaidPets", "XPerl_GrimReaper"}
local xpStartupMemory = {}

-- XPerl_MinimapButton_Init
function XPerl_MinimapButton_Init(self)
	self.time = 0
	collectgarbage()
	UpdateAddOnMemoryUsage()
	local totalKB = 0
	for k,v in pairs(xpModList) do
		local usedKB = GetAddOnMemoryUsage(v)
		if ((usedKB or 0) > 0) then
			xpStartupMemory[v] = usedKB
		end
	end

	XPerl_MinimapButton_UpdatePosition(self)

	if (conf.minimap.enable) then
		self:Show()
	else
		self:Hide()
	end

	self.UpdateTooltip = XPerl_MinimapButton_OnEnter

	XPerl_MinimapButton_Init = nil
end

-- XPerl_MinimapButton_UpdatePosition
function XPerl_MinimapButton_UpdatePosition(self)
	if (not conf.minimap.radius) then
		conf.minimap.radius = 78
	end
	self:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		54 - (conf.minimap.radius * cos(conf.minimap.pos)),
		(conf.minimap.radius * sin(conf.minimap.pos)) - 55
	)
end

-- XPerl_MinimapButton_Dragging
function XPerl_MinimapButton_Dragging(self, elapsed)
	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()

	xpos = xmin-xpos/UIParent:GetScale()+70
	ypos = ypos/UIParent:GetScale()-ymin-70

	if (IsAltKeyDown()) then
		local radius = (xpos^2 + ypos^2)^0.5
		if (radius < 78) then
			radius = 78
		end
		if (radius > 148) then
			radius = 148
		end
		conf.minimap.radius = radius
		end

	local angle = math.deg(math.atan2(ypos,xpos))
	if (angle < 0) then
		angle = angle + 360
	end
	conf.minimap.pos = angle

	XPerl_MinimapButton_UpdatePosition(self)
end

-- DiffColour(diff, val)
local function DiffColour(val)
	local r, g, b, offset
	offset = max(0, min(0.5, 0.5 * min(1, val)))
	if (val < 0) then
		r = 0.5 + offset
		g = 0.5 - offset
		b = r
	else
		r = 0.5 + offset
		g = 0.5 - offset
		b = g
	end
	return format("|c00%02X%02X%02X", 255 * r, 255 * g, 255 * b)
end

-- XPerl_MinimapButton_OnEnter
function XPerl_MinimapButton_OnEnter(self)
	if (self.dragging) then
		return
	end

	XPerl_Tutorial(1)			-- Minimap Icon/Options

	GameTooltip:SetOwner(self or UIParent, "ANCHOR_LEFT")
	XPerl_MinimapButton_Details(GameTooltip)
end

-- XPerl_MinimapButton_Details
function XPerl_MinimapButton_Details(tt, ldb)
	tt:SetText(XPerl_Version.." "..XPerl_GetRevision(), 1, 1, 1)
	tt:AddLine(XPERL_MINIMAP_HELP1)
	if (not ldb) then
		tt:AddLine(XPERL_MINIMAP_HELP2)
	end
	if (UpdateAddOnMemoryUsage) then
		if (IsAltKeyDown()) then
			tt:AddLine(XPERL_MINIMAP_HELP6)
		elseif (not IsShiftKeyDown()) then
			tt:AddLine(XPERL_MINIMAP_HELP5)
		end
	end

	if (GetRealNumRaidMembers) then
		if (GetNumRaidMembers() > 0 and GetRealNumRaidMembers() > 0) then
			if (select(2, IsInInstance()) == "pvp") then
				tt:AddLine(format(XPERL_MINIMAP_HELP3, GetRealNumRaidMembers(), GetRealNumPartyMembers()))

				if (IsRealPartyLeader()) then
					tt:AddLine(XPERL_MINIMAP_HELP4)
				end
			end
		end
	end

	if (UpdateAddOnMemoryUsage and IsAltKeyDown()) then
		local showDiff = IsShiftKeyDown()

		local allAddonsCPU = 0
		for i = 1,GetNumAddOns() do
			allAddonsCPU = allAddonsCPU + GetAddOnCPUUsage(i)
		end

		-- Show X-Perl memory usage
		UpdateAddOnMemoryUsage()
		UpdateAddOnCPUUsage()
		local totalKB, totalCPU, diffKB, diff = 0, 0, 0
		local cpuText = ""
		for k,v in pairs(xpModList) do
			local usedKB = GetAddOnMemoryUsage(v)
			local usedCPU = GetAddOnCPUUsage(v)
			if ((usedKB or 0) > 0) then
				totalKB = totalKB + usedKB
				totalCPU = totalCPU + usedCPU

				if (allAddonsCPU > 0) then
					cpuText = format(" |c008080FF%.2f%%|r", 100 * (usedCPU / allAddonsCPU))
				end

				if (showDiff) then
					diff = usedKB - xpStartupMemory[v]
					diffKB = diffKB + diff
					tt:AddDoubleLine(format(" %s", v), format("%.1fkb (%s%.1fkb|r)%s", usedKB, DiffColour(diff / 500), diff, cpuText), 1, 1, 0.5, 1, 1, 1)
				else
					tt:AddDoubleLine(format(" %s", v), format("%.1fkb%s", usedKB, cpuText), 1, 1, 0.5, 1, 1, 1)
				end
			end
		end

		if (showDiff) then
			local color = DiffColour(diffKB / 2000)

			tt:AddDoubleLine("Total", format("%.1fkb (%s%.1fkb|r)", totalKB, color, diffKB), 1, 1, 1, 1, 1, 1)
		else
			tt:AddDoubleLine("Total", format("%.1fkb", totalKB), 1, 1, 1, 1, 1, 1)
		end

		local usedKB = GetAddOnMemoryUsage("XPerl_Options")
		if ((usedKB or 0) > 0) then
			tt:AddDoubleLine(" XPerl_Options", format("%.1fkb", usedKB), 0.5, 0.5, 0.5, 0.5, 0.5, 0.5)
		end

		if (totalCPU > 0) then
			tt:AddDoubleLine(" XPerl CPU Usage Comparison", format("%.2f%%", 100 * (totalCPU / allAddonsCPU)), 0.5, 0.5, 1, 0.5, 0.5, 1)
		end
	end

	tt:Show()
	tt.updateTooltip = 1
end


-- XPerl_SetManaBarType
local ManaColours = {
	[0] = "mana",
	[1] = "rage",
	[2] = "focus",
	[3] = "energy",
	[4] = "happiness",
	[5] = "runes",
	[6] = "runic_power",
}
function XPerl_SetManaBarType(self)
	local m = self.statsFrame.manaBar
	if (m and not self.statsFrame.greyMana) then
		local unit = self.partyid		-- SecureButton_GetUnit(self)
		if (unit) then
			local p = UnitPowerType(unit)
			if (p) then
				local c = conf.colour.bar[ManaColours[p]]
				if (c) then
					m:SetStatusBarColor(c.r, c.g, c.b, 1)
					m.bg:SetVertexColor(c.r, c.g, c.b, 0.25)
				end
			end
		end
	end
end

-- XPerl_TooltipModiferPressed()
function XPerl_TooltipModiferPressed(buffs)
	local mod, ic
	if (buffs) then
		if (not conf.tooltip.enableBuffs) then
			return
		end
		mod = conf.tooltip.buffModifier
		ic = conf.tooltip.buffHideInCombat
	else
		if (not conf.tooltip.enable) then
			return
		end
		mod = conf.tooltip.modifier
		ic = conf.tooltip.hideInCombat
	end

	if (mod == "alt") then
		mod = IsAltKeyDown()
	elseif (mod == "shift") then
		mod = IsShiftKeyDown()
	elseif (mod == "control") then
		mod = IsControlKeyDown()
	else
		mod = true
	end

	mod = mod and (not ic or not InCombatLockdown())

	return mod
end

-- XPerl_PlayerTip
function XPerl_PlayerTip(self, unitid)
	if (not unitid) then
		unitid = SecureButton_GetUnit(self)
	end

	if (not unitid or XPerlLocked == 0) then
		return
	end

	if (not XPerl_TooltipModiferPressed()) then
		return
	end

	if (SpellIsTargeting()) then
		if (SpellCanTargetUnit(unitid)) then
			SetCursor("CAST_CURSOR")
		else
			SetCursor("CAST_ERROR_CURSOR")
		end
	end

	GameTooltip_SetDefaultAnchor(GameTooltip, self)
	GameTooltip:SetUnit(unitid)

	if (XPerl_RaidTipExtra) then
		XPerl_RaidTipExtra(unitid)
	end

	XPerl_Highlight:TooltipInfo(UnitName(unitid))
end

-- XPerl_PlayerTipHide
function XPerl_PlayerTipHide()
	if (conf.tooltip.fading) then
		GameTooltip:FadeOut()
	else
		GameTooltip:Hide()
	end
end

-- XPerl_ColourFriendlyUnit
function XPerl_ColourFriendlyUnit(self, partyid)
	local color
	if (UnitCanAttack("player", partyid) and UnitIsEnemy("player", partyid)) then	-- For dueling
		color = conf.colour.reaction.enemy
	else
		if (conf.colour.class) then
			color = XPerl_GetClassColour(select(2, UnitClass(partyid)))
		else
			if (UnitIsPVP(partyid)) then
				color = conf.colour.reaction.friend
			else
				color = conf.colour.reaction.none
			end
		end
	end

	self:SetTextColor(color.r, color.g, color.b, conf.transparency.text)
end

-- XPerl_ReactionColour
function XPerl_ReactionColour(argUnit)
	if (UnitPlayerControlled(argUnit) or not UnitIsVisible(argUnit)) then
		if (UnitFactionGroup("player") == UnitFactionGroup(argUnit)) then
			if (UnitIsEnemy("player", argUnit)) then
				-- Dueling
				return conf.colour.reaction.enemy

			elseif (UnitIsPVP(argUnit)) then
				return conf.colour.reaction.friend
			end
		else
			if (UnitIsPVP(argUnit)) then
				if (UnitIsPVP("player")) then
					return conf.colour.reaction.enemy
				else
					return conf.colour.reaction.neutral
				end
			end
		end
	else
		if (UnitIsTapped(argUnit) and not UnitIsTappedByPlayer(argUnit)) then
			return conf.colour.reaction.tapped
		else
			local reaction = UnitReaction(argUnit, "player")
			if (reaction) then
				if (reaction >= 5) then
					return conf.colour.reaction.friend
				elseif (reaction <= 2) then
					return conf.colour.reaction.enemy
				elseif (reaction == 3) then
					return conf.colour.reaction.unfriendly
				else
					return conf.colour.reaction.neutral
				end
			else
				if (UnitFactionGroup("player") == UnitFactionGroup(argUnit)) then
					return conf.colour.reaction.friend
				elseif (UnitIsEnemy("player", argUnit)) then
					return conf.colour.reaction.enemy
				else
					return conf.colour.reaction.neutral
				end
			end
		end
	end

	return conf.colour.reaction.none
end

-- XPerl_SetUnitNameColor
function XPerl_SetUnitNameColor(self, unit)
	local color
	if (UnitIsPlayer(unit) or not UnitIsVisible(unit)) then			-- Changed UnitPlayerControlled to UnitIsPlayer for 2.3.5
		-- 1.8.3 - Changed to override pvp name colours
		if (conf.colour.class) then
			color = XPerl_GetClassColour(select(2, UnitClass(unit)))
		else
			color = XPerl_ReactionColour(unit)
		end
	else
		if (UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit)) then
			color = conf.colour.reaction.tapped
		else
			color = XPerl_ReactionColour(unit)
		end
	end

	self:SetTextColor(color.r, color.g, color.b, conf.transparency.text)
end

-- XPerl_CombatFlashSet
function XPerl_CombatFlashSet(self, elapsed, argNew, argGreen)
	if (not conf.combatFlash) then
		self.PlayerFlash = nil
		return
	end

	if (self) then
		if (argNew) then
			self.PlayerFlash = 1.5
			self.PlayerFlashGreen = argGreen
		else
			if (elapsed and self.PlayerFlash) then
				self.PlayerFlash = self.PlayerFlash - elapsed

				if (self.PlayerFlash <= 0) then
					self.PlayerFlash = 0
					self.PlayerFlashGreen = nil
				end
			else
				return
			end
		end

		return true
	end
end

-- XPerl_CombatFlashSetFrames
function XPerl_CombatFlashSetFrames(self)
	if (self.PlayerFlash) then
		local baseColour = self.forcedColour or conf.colour.border

		local r, g, b, a
		if (self.PlayerFlash > 0) then
			local flashOffsetColour = min(self.PlayerFlash,1) / 2
			if (self.PlayerFlashGreen) then
				r = min(1, max(0, baseColour.r - flashOffsetColour))
				g = min(1, max(0, baseColour.g + flashOffsetColour))
			else
				r = min(1, max(0, baseColour.r + flashOffsetColour))
				g = min(1, max(0, baseColour.g - flashOffsetColour))
			end
			b = min(1, max(0, baseColour.b - flashOffsetColour))
			a = min(1, max(0, baseColour.a + flashOffsetColour))
		else
			r, g, b, a = baseColour.r, baseColour.g, baseColour.b, baseColour.a
			self.PlayerFlash = false
		end

		for i, frame in pairs(self.FlashFrames) do
			frame:SetBackdropBorderColor(r, g, b, a)
		end
	end
end

local getShow
function XPerl_DebufHighlightInit()
	-- We also re-set the colours here so that we highlight best colour per class
	if (playerClass == "MAGE") then
		getShow = function(Curses)
			local show
			if (not conf.highlightDebuffs.class) then
				show = Curses.Magic or Curses.Curse or Curses.Poison or Curses.Disease
			end
			return Curses.Curse or show
		end

	elseif (playerClass == "DRUID") then
		getShow = function(Curses)
			local show
			if (not conf.highlightDebuffs.class) then
				show = Curses.Magic or Curses.Curse or Curses.Poison or Curses.Disease
			end
			return Curses.Curse or Curses.Poison or show
		end

	elseif (playerClass == "PRIEST") then
		getShow = function(Curses)
			local show
			if (not conf.highlightDebuffs.class) then
				show = Curses.Magic or Curses.Curse or Curses.Poison or Curses.Disease
			end
			return Curses.Magic or Curses.Disease or show
		end

	elseif (playerClass == "WARLOCK") then
		getShow = function(Curses)
			local show
			if (not conf.highlightDebuffs.class) then
				show = Curses.Magic or Curses.Curse or Curses.Poison or Curses.Disease
			end
			return Curses.Magic or show
		end

	elseif (playerClass == "PALADIN") then
		getShow = function(Curses)
			local show
			if (not conf.highlightDebuffs.class) then
				show = Curses.Magic or Curses.Curse or Curses.Poison or Curses.Disease
			end
			return Curses.Magic or Curses.Poison or Curses.Disease or show
		end

	elseif (playerClass == "SHAMAN") then
		getShow = function(Curses)
			local show
			if (not conf.highlightDebuffs.class) then
				show = Curses.Magic or Curses.Curse or Curses.Poison or Curses.Disease
			end
			return Curses.Curse or Curses.Poison or Curses.Disease or show
		end

	elseif (playerClass == "ROGUE") then
		getShow = function(Curses)
			local show
			if (not conf.highlightDebuffs.class) then
				show = Curses.Magic or Curses.Curse or Curses.Poison or Curses.Disease
			end
			return Curses.Poison or show
		end
	else
		getShow = function(Curses)
			return Curses.Magic or Curses.Curse or Curses.Poison or Curses.Disease
		end
	end

	XPerl_DebufHighlightInit = nil
end

local bgDef = {bgFile = "Interface\\Addons\\XPerl\\Images\\XPerl_FrameBack",
	       edgeFile = "",
	       tile = true, tileSize = 32, edgeSize = 16,
	       insets = { left = 5, right = 5, top = 5, bottom = 5 }
		}
local normalEdge = "Interface\\Tooltips\\UI-Tooltip-Border"
local curseEdge = "Interface\\Addons\\XPerl\\Images\\XPerl_Curse"

-- XPerl_CheckDebuffs
local Curses = setmetatable({}, {__mode = "k"})		-- 2.2.6 - Now re-using static table to save garbage memory creation
function XPerl_CheckDebuffs(self, unit, resetBorders)
	if (not self.FlashFrames) then
		return
	end

	local high = conf.highlightDebuffs.enable or (self == XPerl_Target and conf.target.highlightDebuffs.enable)

	if (resetBorders or not high or not getShow) then
		-- Reset the frame edges back to normal in case they changed options while debuffed.
		self.forcedColour = nil
		bgDef.edgeFile = self.edgeFile or normalEdge
		bgDef.edgeSize = self.edgeSize or 16
		bgDef.insets.left = self.edgeInsets or 5
		bgDef.insets.top = self.edgeInsets or 5
		bgDef.insets.right = self.edgeInsets or 5
		bgDef.insets.bottom = self.edgeInsets or 5
		for i, f in pairs(self.FlashFrames) do
			f:SetBackdrop(bgDef)
			f:SetBackdropColor(conf.colour.frame.r, conf.colour.frame.g, conf.colour.frame.b, conf.colour.frame.a)
			f:SetBackdropBorderColor(conf.colour.border.r, conf.colour.border.g, conf.colour.border.b, conf.colour.border.a)
		end
		return
	end

	if (not unit) then
		unit = self:GetAttribute("unit")
		if (not unit) then
			return
		end
	end

	Curses.Magic, Curses.Curse, Curses.Poison, Curses.Disease = nil, nil, nil, nil

	local show
	local debuffCount = 0
	local _, unitClass = UnitClass(unit)

	for i = 1, 40 do
		local debuffName,_, debuff, debuffStack, debuffType = UnitDebuff(unit, i)
		if (not debuff) then
			break
		end

		if (debuffType) then
			local exclude = ArcaneExclusions[debuffName]
			if (not exclude or (type(exclude) == "table" and not exclude[unitClass])) then
				Curses[debuffType] = debuffType
				debuffCount = debuffCount + 1
			end
		end
	end

	if (debuffCount > 0) then
		-- 2.2.6 - Very (very very) slight speed optimazation by having a function per class which is set at startup
		show = getShow(Curses)
	end

	local colour, borderColour
	if (show) then
		colour = DebuffTypeColor[show]
		colour.a = 1

		if (conf.highlightDebuffs.border) then
			borderColour = colour
		else
			borderColour = conf.colour.border
		end
	else
		colour = conf.colour.frame
		borderColour = conf.colour.border
	end

	if (show and conf.highlightDebuffs.frame) then
		self.forcedColour = borderColour
		bgDef.edgeFile = curseEdge
	else
		self.forcedColour = nil
		--bgDef.edgeFile = normalEdge

		bgDef.edgeFile = self.edgeFile or normalEdge
		bgDef.edgeSize = self.edgeSize or 16
		bgDef.insets.left = self.edgeInsets or 5
		bgDef.insets.top = self.edgeInsets or 5
		bgDef.insets.right = self.edgeInsets or 5
		bgDef.insets.bottom = self.edgeInsets or 5
	end

	for i, f in pairs(self.FlashFrames) do
		if (not conf.highlightDebuffs.frame) then
			colour = conf.colour.frame
		end
		f:SetBackdrop(bgDef)
		f:SetBackdropColor(colour.r, colour.g, colour.b, colour.a)
		f:SetBackdropBorderColor(borderColour.r, borderColour.g, borderColour.b, borderColour.a)
	end
end

-- XPerl_GetSavePositionTable
function XPerl_GetSavePositionTable(create)
	if (not XPerlConfigNew) then
		return
	end

	local name = UnitName("player")
	local realm = GetRealmName()

	if (not XPerlConfigNew.savedPositions) then
		if (not create) then
			return
		end
		XPerlConfigNew.savedPositions = {}
	end
	local c = XPerlConfigNew.savedPositions
	if (not c[realm]) then
		if (not create) then
			return
		end
		c[realm] = {}
	end
	if (not c[realm][name]) then
		if (not create) then
			return
		end
		c[realm][name] = {}
	end
	local table = c[realm][name]

	return table
end


-- XPerl_SavePosition
function XPerl_SavePosition(self, onlyIfEmpty)
	local name = self:GetName()
	if (name) then
		local s = self:GetScale()
		local t = self:GetTop()
		local l = self:GetLeft()
		local h = self:IsResizable() and self:GetHeight()
		local w = self:IsResizable() and self:GetWidth()

		local table = XPerl_GetSavePositionTable(true)
		if (table) then
			if (not onlyIfEmpty or (onlyIfEmpty and not table[name])) then
				if (t and l) then
					if (not table[name]) then
						table[name] = {}
					end
					table[name].top = t * s
					table[name].left = l * s
					table[name].height = h
					table[name].width = w
				else
					table[name] = nil
				end
			else
				if (table[name] and not self:IsUserPlaced()) then
					XPerl_RestorePosition(self)
				end
			end
		end
	end
end

-- XPerl_RestorePosition
function XPerl_RestorePosition(self)
	if (XPerlConfigNew.savedPositions) then
		local name = self:GetName()
		if (name) then
			local table = XPerl_GetSavePositionTable()
			if (table) then
				local pos = table[name]
				if (pos and pos.left and pos.top) then
					self:ClearAllPoints()
					self:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", pos.left / self:GetScale(), pos.top / self:GetScale())

					if (pos.height and pos.width) then
						if (self:IsResizable()) then
							self:SetHeight(pos.height)
							self:SetWidth(pos.width)
						else
							pos.height, pos.width = nil, nil
						end
					end

					self:SetUserPlaced(true)
				end
			end
		end
	end
end

-- XPerl_RestorePosition
function XPerl_RestoreAllPositions()
	local table = XPerl_GetSavePositionTable()
	if (table) then
		for k,v in pairs(table) do
			if (k == "XPerl_Frame" or k == "XPerl_RaidMonitor_Frame" or k == "XPerl_Check" or k == "XPerl_AdminFrame" or k == "XPerl_Assists_Frame") then
				-- Fix for a wrong name with versions 2.3.2 and 2.3.2a
				-- It was using XPerl_Frame instead of XPerl_MTList_Anchor
				-- and XPerl_RaidMonitor_Frame instead of XPerl_RaidMonitor_Anchor
				-- And now a change to XPerl_Check to XPerl_CheckAnchor and XPerl_AdminFrame to XPerl_AdminFrameAnchor
				table[k] = nil
			else
				local frame = _G[k]
				if (frame) then
					if (v.left and v.top) then
						frame:ClearAllPoints()
						frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", v.left / frame:GetScale(), v.top / frame:GetScale())
						if (v.height and v.width) then
							if (frame:IsResizable()) then
								frame:SetHeight(v.height)
								frame:SetWidth(v.width)
							else
								v.height, v.width = nil, nil
							end
						end
						frame:SetUserPlaced(true)
					end
				end
			end
		end
	end
end

local BuffExceptions
if is_cata then--If client is cataclysm client, use these buff exceptions
	BuffExceptions = {
	PRIEST = {
		[GetSpellInfo(774)] = true,					-- Rejuvenation
		[GetSpellInfo(8936)] = true,				-- Regrowth
		[GetSpellInfo(33076)] = true,				-- Prayer of Mending
	},
	DRUID = {
		[GetSpellInfo(139)] = true,					-- Renew
	},
	WARLOCK = {
		[GetSpellInfo(20707)] = true,				-- Soulstone Resurrection
	},
	HUNTER = {
		
		[GetSpellInfo(13165)] = "HUNTER",			-- Aspect of the Hawk
		[GetSpellInfo(5118)] = "HUNTER",			-- Aspect of the Cheetah
		[GetSpellInfo(13159)] = true,				-- Aspect of the Pack
		[GetSpellInfo(20043)] = true,				-- Aspect of the Wild
		[GetSpellInfo(61648)] = "HUNTER",			-- Aspect of the Beast
		-- [GetSpellInfo(13163)] = "HUNTER",			-- Aspect of the Monkey
		[GetSpellInfo(19506)] = true,				-- Trueshot Aura
		[GetSpellInfo(5384)] = "HUNTER",			-- Feign Death
	},
	ROGUE = {
		[GetSpellInfo(1784)] = "ROGUE",				-- Stealth
		[GetSpellInfo(1856)] = "ROGUE",			-- Vanish
		[GetSpellInfo(2983)] = "ROGUE",			-- Sprint
		[GetSpellInfo(13750)] = "ROGUE",			-- Adrenaline Rush
		[GetSpellInfo(13877)] = "ROGUE",			-- Blade Flurry
	},
	PALADIN = {
		[GetSpellInfo(20154)] = true,				-- Seal of Righteousness
		[GetSpellInfo(20165)] = true,				-- Seal of Insight
		[GetSpellInfo(20164)] = true,				-- Seal of Justice
		[GetSpellInfo(31801)] = true,				-- Seal of Truth
		-- [GetSpellInfo(20375)] = true,				-- Seal of Command
		-- [GetSpellInfo(20166)] = true,				-- Seal of Wisdom
		-- [GetSpellInfo(20165)] = true,				-- Seal of Light
		-- [GetSpellInfo(53736)] = true,				-- Seal of Corruption
		-- [GetSpellInfo(31892)] = true,				-- Seal of Blood
		-- [GetSpellInfo(31801)] = true,				-- Seal of Vengeance
		
		[GetSpellInfo(465)] = true,				-- Devotion Aura
		[GetSpellInfo(7294)] = true,				-- Retribution Aura
		[GetSpellInfo(19746)] = true,				-- Concentration Aura
		[GetSpellInfo(19891)] = true,				-- Resistance Aura
		[GetSpellInfo(32223)] = true,				-- Crusader Aura
		[GetSpellInfo(25780)] = true,				-- Righteous Fury
		[GetSpellInfo(20925)] = true,				-- Holy Shield
		[GetSpellInfo(54428)] = true,				-- Divine Plea
	},
}
else--It's not cataclysm client, use old buff exceptions
	BuffExceptions = {
	PRIEST = {
		[GetSpellInfo(26982)] = true,				-- Rejuvenation
		[GetSpellInfo(26980)] = true,				-- Regrowth
		[GetSpellInfo(33076)] = true,				-- Prayer of Mending
	},
	DRUID = {
		[GetSpellInfo(25222)] = true,				-- Renew
	},
	WARLOCK = {
		[GetSpellInfo(20707)] = true,				-- Soulstone Resurrection
	},
	HUNTER = {
		[GetSpellInfo(34074)] = "HUNTER",			-- Aspect of the Viper
		[GetSpellInfo(27044)] = "HUNTER",			-- Aspect of the Hawk
		[GetSpellInfo(5118)] = "HUNTER",			-- Aspect of the Cheetah
		[GetSpellInfo(13159)] = true,				-- Aspect of the Pack
		[GetSpellInfo(61846)] = "HUNTER",			-- Aspect of the Dragonhawk
		[GetSpellInfo(27045)] = true,				-- Aspect of the Wild
		[GetSpellInfo(13161)] = "HUNTER",			-- Aspect of the Beast
		[GetSpellInfo(13163)] = "HUNTER",			-- Aspect of the Monkey
		[GetSpellInfo(19506)] = true,				-- Trueshot Aura
		[GetSpellInfo(5384)] = "HUNTER",			-- Feign Death
	},
	ROGUE = {
		[GetSpellInfo(1787)] = "ROGUE",				-- Stealth
		[GetSpellInfo(26889)] = "ROGUE",			-- Vanish
		[GetSpellInfo(11305)] = "ROGUE",			-- Sprint
		[GetSpellInfo(13750)] = "ROGUE",			-- Adrenaline Rush
		[GetSpellInfo(13877)] = "ROGUE",			-- Blade Flurry
	},
	PALADIN = {
		[GetSpellInfo(21084)] = true,				-- Seal of Righteousness
		[GetSpellInfo(20375)] = true,				-- Seal of Command
		[GetSpellInfo(20166)] = true,				-- Seal of Wisdom
		[GetSpellInfo(20165)] = true,				-- Seal of Light
		[GetSpellInfo(53736)] = true,				-- Seal of Corruption
		[GetSpellInfo(31892)] = true,				-- Seal of Blood
		[GetSpellInfo(31801)] = true,				-- Seal of Vengeance
		[GetSpellInfo(27149)] = true,				-- Devotion Aura
		[GetSpellInfo(27150)] = true,				-- Retribution Aura
		[GetSpellInfo(19746)] = true,				-- Concentration Aura
		[GetSpellInfo(27151)] = true,				-- Shadow Resistance Aura
		[GetSpellInfo(27152)] = true,				-- Frost Resistance Aura
		[GetSpellInfo(27153)] = true,				-- Fire Resistance Aura
		[GetSpellInfo(32223)] = true,				-- Crusader Aura
		[GetSpellInfo(25780)] = true,				-- Righteous Fury
		[GetSpellInfo(27179)] = true,				-- Holy Shield
		[GetSpellInfo(54428)] = true,				-- Divine Plea
	},
}
end

local DebuffExceptions = {
	ALL = {
		[GetSpellInfo(11196)] = true,				-- Recently Bandaged
	},
	PRIEST = {
		[GetSpellInfo(6788)] = true,				-- Weakened Soul
	},
	PALADIN = {
		[GetSpellInfo(25771)] = true				-- Forbearance
	}
}

local SeasonalDebuffs = {
	[GetSpellInfo(26004)] = true,					-- Mistletoe
	[GetSpellInfo(26680)] = true,					-- Adored
	[GetSpellInfo(26898)] = true,					-- Heartbroken
	[GetSpellInfo(64805)] = true,					-- Bested Darnassus
	[GetSpellInfo(64808)] = true,					-- Bested the Exodar
	[GetSpellInfo(64809)] = true,					-- Bested Gnomeregan
	[GetSpellInfo(64810)] = true,					-- Bested Ironforge
	[GetSpellInfo(64811)] = true,					-- Bested Orgrimmar
	[GetSpellInfo(64812)] = true,					-- Bested Sen'jin
	[GetSpellInfo(64813)] = true,					-- Bested Silvermoon City
	[GetSpellInfo(64814)] = true,					-- Bested Stormwind
	[GetSpellInfo(64815)] = true,					-- Bested Thunder Bluff
	[GetSpellInfo(64816)] = true,					-- Bested the Undercity
	[GetSpellInfo(36900)] = true,					-- Soul Split: Evil!
	[GetSpellInfo(36901)] = true,					-- Soul Split: Good
	[GetSpellInfo(36899)] = true,					-- Transporter Malfunction
	[GetSpellInfo(24755)] = true,					-- Tricked or Treated
	[GetSpellInfo(69127)] = true,					-- Chill of the Throne
}

local RaidFrameIgnores = {
	[GetSpellInfo(26013)] = true,					-- Deserter
	[GetSpellInfo(71041)] = true,					-- Dungeon Deserter
	[GetSpellInfo(71328)] = true,					-- Dungeon Cooldown
}

-- BuffException
local showInfo
local function BuffException(unit, index, flag, func, exceptions, raidFrames)
	local name, rank, buff, count, debuffType, dur, max, isMine, isStealable
	if (flag ~= "RAID") then
		-- Not filtered, just return it
		name, rank, buff, count, debuffType, dur, max, isMine, isStealable = func(unit, index)
		return name, rank, buff, count, debuffType, dur, max, isMine, isStealable, index
	end

	name, rank, buff, count, debuffType, dur, max, isMine, isStealable = func(unit, index, "RAID")
	if (buff) then
		-- We need the index of the buff unfiltered later for tooltips
		for i = 1,1000 do
			local name1, rank1, buff1, count1, debuffType1, dur1, max1, isMine1, isStealable1 = func(unit, i)
			if (not name1) then
				break
			end
			if (name == name1 and rank == rank1 and buff == buff1 and count == count1 and isMine == isMine1) then
				index = i
				break
			end
		end

		return name, rank, buff, count, debuffType, dur, max, isMine, isStealable, index
	end

	-- See how many filtered buffs WoW has returned by default
	local normalBuffFilterCount = 0
	for i = 1,1000 do
		name = func(unit, i, "RAID")
		if (not name) then
			normalBuffFilterCount = i - 1
			break
		end
	end

	-- Nothing found by default, so look for exceptions that we want to tack onto the end
	local unitClass
	local foundValid = 0
	local classExceptions = exceptions[playerClass]
	local allExceptions = exceptions.ALL
	for i = 1,1000 do
		name, rank, buff, count, debuffType, dur, max, isMine, isStealable = func(unit, i)
		if (not name) then
			break
		end

		local good
		if (classExceptions) then
			good = classExceptions[name]
		end
		if (not good and allExceptions) then
			good = allExceptions[name]
		end

		if (type(good) == "string") then
			if (not unitClass) then
				unitClass = select(2, UnitClass(unit))
			end
			if (good ~= unitClass) then
				good = nil
			end
		end

		if (good) then
			foundValid = foundValid + 1
			if (foundValid + normalBuffFilterCount == index) then
				return name, rank, buff, count, debuffType, dur, max, isMine, isStealable, i
			end
		end
	end
end

-- DebuffException
local function DebuffException(unit, start, flag, func, raidFrames)
	local name, rank, buff, count, debuffType, dur, max, caster, isStealable, index
	local valid = 0
	for i = 1,1000 do
		name, rank, buff, count, debuffType, dur, max, caster, isStealable, index = BuffException(unit, i, flag, func, DebuffExceptions, raidFrames)
		if (not name) then
			break
		end
		if (not SeasonalDebuffs[name] and not (raidFrames and RaidFrameIgnores[name])) then
			valid = valid + 1
			if (valid == start) then
				return name, rank, buff, count, debuffType, dur, max, caster, isStealable, index
			end
		end
	end
end

-- XPerl_UnitBuff
function XPerl_UnitBuff(unit, index, flag, raidFrames)
	return BuffException(unit, index, flag, Utopia_UnitBuff or UnitBuff, BuffExceptions, raidFrames)
end

-- XPerl_UnitBuff
function XPerl_UnitDebuff(unit, index, flag, raidFrames)
	if (conf.buffs.ignoreSeasonal or raidFrames) then
		return DebuffException(unit, index, flag, Utopia_UnitDebuff or UnitDebuff, raidFrames)
	end
	return BuffException(unit, index, flag, Utopia_UnitDebuff or UnitDebuff, DebuffExceptions, raidFrames)
end

-- XPerl_TooltipSetUnitBuff
-- Retreives the index of the actual unfiltered buff, and uses this on unfiltered tooltip call
function XPerl_TooltipSetUnitBuff(self, unit, ind, filter, raidFrames)
	local name, rank, buff, count, _, dur, max, caster, isStealable, index = BuffException(unit, ind, filter, UnitBuff, BuffExceptions, raidFrames)
	if (name and index) then
		if (Utopia_SetUnitBuff) then
			Utopia_SetUnitBuff(self, unit, index)
		else
			self:SetUnitBuff(unit, index)
		end
	end
end

-- XPerl_TooltipSetUnitDebuff
-- Retreives the index of the actual unfiltered debuff, and uses this on unfiltered tooltip call
function XPerl_TooltipSetUnitDebuff(self, unit, ind, filter, raidFrames)
	local name, rank, buff, count, debuffType, dur, max, caster, isStealable, index = XPerl_UnitDebuff(unit, ind, filter, raidFrames)
	if (name and index) then
		if (Utopia_SetUnitDebuff) then
			Utopia_SetUnitDebuff(self, unit, index)
		else
			self:SetUnitDebuff(unit, index)
		end
	end
end

local colourList = {}
for class,localClass in pairs(LOCALIZED_CLASS_NAMES_MALE) do
	colourList[localClass] = class
end
for class,localClass in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do
	colourList[localClass] = class
end

-- XPerl_GuildStatusUpdate()
function XPerl_GuildStatusUpdate()
	if (conf.colour.class or conf.tooltip.xperlInfo) then
		local myZone = GetRealZoneText()

		local guildOffset = FauxScrollFrame_GetOffset(GuildListScrollFrame)
		for i=1, GUILDMEMBERS_TO_DISPLAY, 1 do
			local guildIndex = guildOffset + i

			local button = _G["GuildFrameButton"..i];
			button.guildIndex = guildIndex;
			local name, rank, rankIndex, level, class, zone, note, officernote, online = GetGuildRosterInfo(guildIndex)
			if (not name) then
				break
			end

			if (conf.tooltip.xperlInfo and XPerl_GetUsage) then
				local u = XPerl_GetUsage(name)

				if (u) then
					if (online) then
						if (u.old) then
							_G["GuildFrameButton"..i.."Name"]:SetTextColor(1, 0.4, 0.1)
						else
							_G["GuildFrameButton"..i.."Name"]:SetTextColor(1, 0.4, 0.4)
						end
					else
						if (u.old) then
							_G["GuildFrameButton"..i.."Name"]:SetTextColor(0.5, 0.2, 0.05)
						else
							_G["GuildFrameButton"..i.."Name"]:SetTextColor(0.5, 0.2, 0.2)
						end
					end
				end
			end

			if (conf.colour.class and conf.colour.guildList) then
				class = colourList[class]

				if (class) then
					local color = XPerl_GetClassColour(class)
					if (color) then
						if (online) then
							_G["GuildFrameButton"..i.."Class"]:SetTextColor(color.r, color.g, color.b)
						else
							_G["GuildFrameButton"..i.."Class"]:SetTextColor(color.r / 2, color.g / 2, color.b / 2)
						end
					end
				end

				if (zone == myZone) then
					if (online) then
						_G["GuildFrameButton"..i.."Zone"]:SetTextColor(0, 1, 0)
					else
						_G["GuildFrameButton"..i.."Zone"]:SetTextColor(0, 0.5, 0)
					end
				end

				local color = GetDifficultyColor(level)
				if (online) then
					_G["GuildFrameButton"..i.."Level"]:SetTextColor(color.r, color.g, color.b)
				else
					_G["GuildFrameButton"..i.."Level"]:SetTextColor(color.r / 2, color.g / 2, color.b / 2)
				end
			end
		end
	end
end

--cataclysm hooksecurefunc removed, check it.
if is_cata then
	--hooksecurefunc("GuildStatus_Update", XPerl_GuildStatusUpdate)
else
	hooksecurefunc("GuildStatus_Update", XPerl_GuildStatusUpdate)
end

-- XPerl_WhoList_Update
function XPerl_WhoList_Update()
	if (conf.colour.class and conf.colour.guildList) then
		local numWhos, totalCount = GetNumWhoResults()
		local whoOffset = FauxScrollFrame_GetOffset(WhoListScrollFrame)

		local myZone = GetRealZoneText()
		local myRace = UnitRace("player")
		local myGuild = GetGuildInfo("player")

		for i=1, WHOS_TO_DISPLAY, 1 do
			local name, guild, level, race, class, zone = GetWhoInfo(whoOffset + i)
			local color
			if (not name) then
				break
			end

			_G["WhoFrameButton"..i.."Name"]:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
			if (conf.tooltip.xperlInfo and XPerl_GetUsage) then
				local u = XPerl_GetUsage(name)
				if (u) then
					_G["WhoFrameButton"..i.."Name"]:SetTextColor(1, 0.4, 0.4)
				end
			end

			if (conf.colour.class and conf.colour.guildList) then
				if (UIDropDownMenu_GetSelectedID(WhoFrameDropDown) == 1) then
					-- Zone
					if (zone == myZone) then
						_G["WhoFrameButton"..i.."Variable"]:SetTextColor(0, 1, 0)
					else
						_G["WhoFrameButton"..i.."Variable"]:SetTextColor(1, 1, 1)
					end
				elseif (UIDropDownMenu_GetSelectedID(WhoFrameDropDown) == 2) then
					if (guild == myGuild) then
						_G["WhoFrameButton"..i.."Variable"]:SetTextColor(0, 1, 0)
					else
						_G["WhoFrameButton"..i.."Variable"]:SetTextColor(1, 1, 1)
					end

				elseif (UIDropDownMenu_GetSelectedID(WhoFrameDropDown) == 3) then
					if (race == myRace) then
						_G["WhoFrameButton"..i.."Variable"]:SetTextColor(0, 1, 0)
					else
						_G["WhoFrameButton"..i.."Variable"]:SetTextColor(1, 1, 1)
					end
				end

				_G["WhoFrameButton"..i.."Class"]:SetTextColor(1, 1, 1)
				class = colourList[class]
				if (class) then
					local color = XPerl_GetClassColour(class)
					if (color) then
						_G["WhoFrameButton"..i.."Class"]:SetTextColor(color.r, color.g, color.b)
					end
				end

				local color = GetDifficultyColor(level)
				_G["WhoFrameButton"..i.."Level"]:SetTextColor(color.r, color.g, color.b)
			else
				_G["WhoFrameButton"..i.."Variable"]:SetTextColor(1, 1, 1)
				_G["WhoFrameButton"..i.."Level"]:SetTextColor(1, 1, 1)
				_G["WhoFrameButton"..i.."Class"]:SetTextColor(1, 1, 1)
			end
		end
	end
end

hooksecurefunc("WhoList_Update", XPerl_WhoList_Update)

----------------------
-- Fading Bar Stuff --
----------------------
local fadeBars = {}
local freeFadeBars = {}
local tempDisableFadeBars

function XPerl_NoFadeBars(tempDisable)
	tempDisableFadeBars = tempDisable
end

-- CheckOnUpdate
local function CheckOnUpdate()
	if (next(fadeBars)) then
		XPerl_Globals:SetScript("OnUpdate", XPerl_BarUpdate)
	else
		XPerl_Globals:SetScript("OnUpdate", nil)
	end
end

-- XPerl_BarUpdate
--local speakerTimer = 0
--local speakerCycle = 0
function XPerl_BarUpdate(self, arg1)
	local did
	for k,v in pairs(fadeBars) do
		if (k:IsShown()) then
			v:SetAlpha(k.fadeAlpha)
			k.fadeAlpha = k.fadeAlpha - (arg1 / conf.bar.fadeTime)

			local r, g, b = v.tex:GetVertexColor()
			v:SetStatusBarColor(r, g, b)
		else
			-- Not shown, so end it
			k.fadeAlpha = 0
		end

		if (k.fadeAlpha <= 0) then
			tinsert(freeFadeBars, v)
			fadeBars[k] = nil
			k.fadeAlpha = nil
			k.fadeBar = nil
			v:SetValue(0)
			v:Hide()
			v.tex = nil
			did = true
		end
	end

	if (did) then
		CheckOnUpdate()
	end
end

-- GetFreeFader
local function GetFreeFader(parent)
	local bar = freeFadeBars[1]
	if (bar) then
		tremove(freeFadeBars, 1)
		bar:SetParent(parent)
	else
		bar = CreateFrame("StatusBar", nil, parent)
	end

	if (bar) then
		fadeBars[parent] = bar
		CheckOnUpdate()

		bar.tex = parent.tex

		local tex = parent:GetStatusBarTexture()
		bar:SetStatusBarTexture(tex:GetTexture())
		bar:GetStatusBarTexture():SetHorizTile(false)
		bar:GetStatusBarTexture():SetVertTile(false)

		local r, g, b = bar.tex:GetVertexColor()
		bar:SetStatusBarColor(r, g, b)

		bar:SetFrameLevel(parent:GetFrameLevel())

		bar:ClearAllPoints()
		bar:SetPoint("TOPLEFT", 0, 0)
		bar:SetPoint("BOTTOMRIGHT", 0, 0)
		bar:SetAlpha(1)

		return bar
	end
end

-- XPerl_StatusBarSetValue
function XPerl_StatusBarSetValue(self, val)
	if (not tempDisableFadeBars and conf.bar.fading and self:GetName()) then
		local min, max = self:GetMinMaxValues()
		local current = self:GetValue()

		if (val < current and val <= max and val >= min) then
			local bar = fadeBars[self]

			if (not bar) then
				bar = GetFreeFader(self)
			end

			if (bar) then
				if (not self.fadeAlpha) then
					self.fadeAlpha = self:GetParent():GetAlpha()
					bar:SetValue(current)
				end

				bar:SetMinMaxValues(min, max)
				bar:SetAlpha(self.fadeAlpha)
				bar:Show()
			end
		end
	end

	XPerl_OldStatusBarSetValue(self, val)
end

-- XPerl_RegisterClickCastFrame
function XPerl_RegisterClickCastFrame(self)
	if (not ClickCastFrames) then
		ClickCastFrames = {}
	end
	ClickCastFrames[self] = true
end

function XPerl_UnregisterClickCastFrame(self)
	if (ClickCastFrames) then
		ClickCastFrames[self] = nil
	end
end

-- unitmenuOnPostClick
local function unitmenuOnPostClick(self)
	if (UIDROPDOWNMENU_OPEN_MENU == self.dropdownMenu and DropDownList1:IsShown())   then
		local parent = self
		if (self:GetParent() and self:GetParent().nameFrame == self) then
			parent = self:GetParent()
		end

		local point, relativePoint
		if (parent:GetTop() * parent:GetEffectiveScale() > UIParent:GetHeight() * UIParent:GetEffectiveScale() / 2) then
			point, relativePoint = "TOPLEFT", "BOTTOMLEFT"
		else
			point, relativePoint = "BOTTOMLEFT", "TOPLEFT"
		end

		DropDownList1:ClearAllPoints()
		DropDownList1:SetPoint(point, parent, relativePoint, 0, 0)
	end
end

-- XPerl_SecureUnitButton_OnLoad
function XPerl_SecureUnitButton_OnLoad(self, unit, menufunc, m1, m2)
	self:SetAttribute("*type1", "target")
	self:SetAttribute("type2", "menu")
	if (unit) then
		self:SetAttribute("unit", unit)
	end

	self.menu = menufunc
	self.dropdownMenu = m1
	self:SetAttribute("_menu", m2)
	self:SetScript("PostClick", unitmenuOnPostClick)

	XPerl_RegisterClickCastFrame(self)
end

------------------------------------------------------------------------------
-- Generic menus

-- XPerl_GenericDropDown_OnLoad
function XPerl_GenericDropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, XPerl_GenericDropDown_Initialize, "MENU")
	tinsert(UnitPopupFrames, "XPerl_DropDown")
end

local whichMenu
-- XPerl_GenericDropDown_Initialize
function XPerl_GenericDropDown_Initialize()
	local unitid = XPerl_DropDown.unit or "player"
	local menu
	local name
	local id

	if ( UnitIsUnit(unitid, "player") ) then
		menu = "SELF"
	elseif ( UnitIsUnit(unitid, "pet") ) then
		menu = "PET"
	elseif ( UnitIsPlayer(unitid) ) then
		id = UnitInRaid(unitid)
		if ( id ) then
			menu = "RAID_PLAYER"		-- "RAID" ?
		elseif ( UnitInParty(unitid) ) then
			menu = "PARTY"
		else
			menu = "PLAYER"
		end
	else
		menu = "RAID_TARGET_ICON"
		name = RAID_TARGET_ICON
	end
	if (menu) then
		whichMenu = menu
		UnitPopup_ShowMenu(XPerl_DropDown, menu, unitid, name, id)
	end
end

local function d(...)
	ChatFrame1:AddMessage(format(...))
end

local function HideSetFocus()
	if (XPerl_ShouldHideSetFocus) then
		local count = 0
		for index, value in ipairs(UnitPopupMenus[XPerl_DropDown.which]) do
			if (UnitPopupShown[1][index] == 1) then
				count = count + 1
				if (value == "SET_FOCUS") then
					UnitPopupShown[1][index] = 0
					break
				end
			end
		end
	end
end
hooksecurefunc("UnitPopup_HideButtons", HideSetFocus)

-- XPerl_ShowGenericMenu
-- self, unit, button are passed from secure template handler (SecureTemplates.lua, line 288 in SecureActionButton_OnClick)
function XPerl_ShowGenericMenu(self, unit, button, actionType)
	if (not unit) then
		unit = SecureButton_GetUnit(self)
	end
	XPerl_DropDown.unit = unit

	if (unit) then
		HideDropDownMenu(1)
		XPerl_DropDown.id = strmatch(unit or "", "(%d+)")
		XPerl_DropDown.displayMode = "MENU"

		XPerl_DropDown.initialize = XPerl_GenericDropDown_Initialize

		if (not anchor) then
			if (self.statsFrame) then
				anchor = self.statsFrame:GetName()
			elseif (self:GetParent().statsFrame) then
				anchor = self:GetParent().statsFrame:GetName()
			end
		end

		local parent = self
		if (self:GetParent() and self:GetParent().nameFrame == self) then
			parent = self:GetParent()
		end

		XPerl_ShouldHideSetFocus = true
		ToggleDropDownMenu(1, nil, XPerl_DropDown, parent, 0, 0)
		XPerl_ShouldHideSetFocus = nil
	end
end

------------------------------------------------------------------------------
-- XPerl_GetBuffButton
local buffIconCount = 0
function XPerl_GetBuffButton(self, buffnum, debuff, createIfAbsent, newID)
	debuff = (debuff or 0)
	local buffType, buffList		--, buffFrame

	if (debuff == 1) then
		--buffFrame = self.debuffFrame
		buffType = "DeBuff"
		buffList = self.buffFrame.debuff
		if (not buffList) then
			self.buffFrame.debuff = {}
			buffList = self.buffFrame.debuff
		end
	else
		--buffFrame = self.buffFrame
		buffType = "Buff"
		buffList = self.buffFrame.buff
		if (not buffList) then
			self.buffFrame.buff = {}
			buffList = self.buffFrame.buff
		end
	end

	local button = buffList and buffList[buffnum]

	if (not button and createIfAbsent) then
		local setup = self.buffSetup
		local parent = self.buffFrame

		if (debuff == 1 and setup.debuffParent) then
			parent = self.debuffFrame
		end

		buffIconCount = buffIconCount + 1
		button = CreateFrame("Button", "XPerlBuff"..buffIconCount, parent, format("XPerl_Cooldown_%sTemplate", buffType))
		button:Hide()
		--button.cooldown.noCooldownCount = true				-- OmniCC to NOT show cooldown

		if (setup.rightClickable) then
			button:RegisterForClicks("RightButtonUp")
			--button:SetAttribute("type", "cancelaura")
			--button:SetAttribute("index", "number")
		end

		local size = self.conf.buffs.size
		if (debuff == 1) then
			size = self.conf.debuffs.size or (size * (1 + (setup.debuffSizeMod * debuff)))
		end
		button:SetScale(size / 32)

		if (setup.onCreate) then
			setup.onCreate(button)
		end

		if (debuff == 1) then
			--buffFrame.UpdateTooltip = setup.updateTooltipDebuff
			button.UpdateTooltip = setup.updateTooltipDebuff
			for k,v in pairs (setup.debuffScripts) do
				button:SetScript(k, v)
			end
		else
			--buffFrame.UpdateTooltip = setup.updateTooltipBuff
			button.UpdateTooltip = setup.updateTooltipBuff
			for k,v in pairs (setup.buffScripts) do
				button:SetScript(k, v)
			end
		end
		buffList[buffnum] = button

		button:ClearAllPoints()
		if (buffnum == 1) then
			if (debuff == 1) then
				if (setup.debuffAnchor1) then
					setup.debuffAnchor1(self, button)
				end
			else
				if (setup.buffAnchor1) then
					setup.buffAnchor1(self, button)
				end
			end
		else
			button:SetPoint("TOPLEFT", buffList[buffnum - 1], "TOPRIGHT", 1 + debuff, 0)
		end
	end
	button:SetID(newID or buffnum)

	return button
end

-- BuffCooldownDisplay
local function BuffCooldownDisplay(self)
	if (self.countdown) then
		local t = GetTime()
		if (t > self.endTime - 1) then
			self.countdown:SetText(strsub(format("%.1f", max(0, self.endTime - t)), 2, 10))
			self.countdown:Show()
		elseif (t > self.endTime - conf.buffs.countdownStart) then
			self.countdown:SetText(max(0, floor(self.endTime - t)))
			self.countdown:Show()
		else
			self.countdown:Hide()
		end
	end
end

-- XPerl_CooldownFrame_SetTimer(self, start, duration, enable)
function XPerl_CooldownFrame_SetTimer(self, start, duration, enable, mine)
	if ( start > 0 and duration > 0 and enable > 0) then
		self:SetCooldown(start, duration)
		self.endTime = start + duration

		if (conf.buffs.countdown and (mine or conf.buffs.countdownAny)) then
			self:SetScript("OnUpdate", BuffCooldownDisplay)
		else
			self:SetScript("OnUpdate", nil)
			self.countdown:Hide()
		end

		self:Show()
	else
		self:Hide()
	end
end

-- AuraButtonOnShow
local function AuraButtonOnShow(self)
	if (not conf.buffs.blizzardCooldowns) then
		if (self.cooldown) then
			self.cooldown:Hide()
		end
		return
	end

	local cd = self.cooldown
	if (not cd) then
		cd = CreateFrame("Cooldown", nil, self, "CooldownFrameTemplate")
		self.cooldown = cd
		cd:SetAllPoints()
	end
	cd:SetReverse(true)
	cd:SetDrawEdge(true)
	
	if (not cd.countdown) then
		cd.countdown = self.cooldown:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
		cd.countdown:SetPoint("TOPLEFT")
		cd.countdown:SetPoint("BOTTOMRIGHT", -1, 2)
		cd.countdown:SetTextColor(1, 1, 0)
	end

	local name, rank, buff, count, _, duration, endTime, caster, isStealable = UnitAura("player", self.xindex, self.xfilter)

	local start = endTime - duration
	XPerl_CooldownFrame_SetTimer(self.cooldown, start, duration, 1, caster == "player")
end

-- XPerl_AuraButton_Update
-- Hook for Blizzard aura button setup to add cooldowns if we have them enabled
local function XPerl_AuraButton_Update(buttonName, index, filter)
	if (conf.buffs.blizzardCooldowns and BuffFrame:IsShown()) then
		local buffName = buttonName..index
		local button = _G[buffName]
		if (button) then
			button.xindex = index
			button.xfilter = filter
			button:SetScript("OnShow", AuraButtonOnShow)
			if (button:IsShown()) then
				AuraButtonOnShow(button)
			end
		end
	end
end

hooksecurefunc("AuraButton_Update", XPerl_AuraButton_Update)

-- XPerl_Unit_BuffSpacing
local function XPerl_Unit_BuffSpacing(self)

	local w = self.statsFrame:GetWidth()
	if (self.portraitFrame and self.portraitFrame:IsShown()) then
		w = w - 2 + self.portraitFrame:GetWidth()
	end
	if (self.levelFrame and self.levelFrame:IsShown()) then
		w = w - 2 + self.levelFrame:GetWidth()
	end
	if (not self.buffSpacing) then
		self.buffSpacing = XPerl_GetReusableTable()
	end
	self.buffSpacing.rowWidth = w

	local srs = 0
	if (not self.conf.buffs.above) then
		if (not self.statsFrame.manaBar or not self.statsFrame.manaBar:IsShown()) then
			srs = 10
		end

		if (self.creatureTypeFrame and self.creatureTypeFrame:IsShown()) then
			srs = srs + self.creatureTypeFrame:GetHeight() - 2
		end
	end

	if (srs > 0) then
		self.buffSpacing.smallRowHeight = srs
		self.buffSpacing.smallRowWidth = self.statsFrame:GetWidth()
	else
		self.buffSpacing.smallRowHeight = 0
		self.buffSpacing.smallRowWidth = w
	end
end

-- WieghAnchor(self, at)
local function WieghAnchor(self)
	if (not self.TOPLEFT or self.conf.flip ~= self.lastFlip or self.conf.buffs.above ~= self.lastAbove) then
		self.lastFlip = self.conf.flip
		self.lastAbove = self.conf.buffs.above

		local left, right, top, bottom
		if (self.conf.flip) then
			left, right = "RIGHT", "LEFT"
			self.SPACING = -1
		else
			left, right = "LEFT", "RIGHT"
			self.SPACING = 1
		end
		if (self.conf.buffs.above) then
			top, bottom = "BOTTOM", "TOP"
			self.VSPACING = 1
		else
			top, bottom = "TOP", "BOTTOM"
			self.VSPACING = -1
		end

		self.TOPLEFT = top..left
		self.TOPRIGHT = top..right
		self.BOTTOMLEFT = bottom..left
		self.BOTTOMRIGHT = bottom..right
	end
end

-- XPerl_Unit_BuffPositionsType
local function XPerl_Unit_BuffPositionsType(self, list, useSmallStart, buffSizeBase)
	local prevBuff, reusedSpace, hideFrom
	local firstOfRow = nil
	local prevRow, prevRowI = list[1], 1
	if (not prevRow) then
		return
	end
	local above = self.conf.buffs.above
	local colPoint, curRow, rowsHeight = 0, 1, 0
	local rowSize = (useSmallStart and self.buffSpacing.smallRowWidth) or self.buffSpacing.rowWidth
	local maxRows = self.conf.buffs.rows or 99
	local decrementMaxRowsIfLastIsBig			-- Descriptive variable names ftw... If only upvalues took no actual memory space for the name... :(

	for i = 1,#list do
		if (curRow > maxRows) then
			hideFrom = i
			break
		end

		if (rowsHeight >= self.buffSpacing.smallRowHeight) then
			rowSize = self.buffSpacing.rowWidth
		end

		local buff = list[i]
		if (i > 1 and not buff:IsShown()) then
			break
		end

		local buffSize = (buff.big and (buffSizeBase * 2)) or buffSizeBase

		buff:ClearAllPoints()
		if (i == 1) then
			prevRow, prevRowI = buff, 1

			if (buff.big) then
				if (curRow == maxRows) then
					maxRows = maxRows + 1
					decrementMaxRowsIfLastIsBig = true
				end
			end

			if (self.prevBuff) then
				buff:SetPoint(self.TOPLEFT, self.prevBuff, self.BOTTOMLEFT, 0, self.VSPACING)
			else
				buff:SetPoint(self.TOPLEFT, 0, 0)
			end
		elseif (firstOfRow) then
			firstOfRow = nil
			if (not buff.big and prevRow.big and not reusedSpace) then
				-- Previous row starts with a big buff at start, so we try to use the odd space between rows
				-- for normal size buffs instead of starting a new row and having a buff width of wasted space.
				-- So we get:
				--	1123456
				--	11789AB
				--	CDEF
				-- Instead of:
				--	1123456
				--	11
				--	789ABCD
				--	EF

				local tempColPoint = (buffSizeBase * 2) + 1
				local j = prevRowI
				while (j < #list) do
					local temp = list[j + 1]
					if (temp and temp.big) then
						tempColPoint = tempColPoint + (buffSizeBase * 2) + 1
						j = j + 1
					else
						break
					end
				end

				if (tempColPoint < rowSize - buffSizeBase) then		--  and rowsHeight - buffSizeBase - 1 >= self.buffSpacing.smallRowHeight
					local prevRowBig, prevRowBigI = list[j], j
					colPoint = tempColPoint
					buff:SetPoint(self.BOTTOMLEFT, prevRowBig, self.BOTTOMRIGHT, self.SPACING, 0)
				else
					buff:SetPoint(self.TOPLEFT, prevRow, self.BOTTOMLEFT, 0, self.VSPACING)
					prevRow, prevRowI = buff, i
				end
				reusedSpace = true
			else
				buff:SetPoint(self.TOPLEFT, prevRow, self.BOTTOMLEFT, 0, self.VSPACING)
				prevRow, prevRowI = buff, i
				reusedSpace = nil

				if (buff.big) then
					if (curRow == maxRows) then
						maxRows = maxRows + 1
						decrementMaxRowsIfLastIsBig = true
					end
				end
			end
		else
			buff:SetPoint(self.TOPLEFT, prevBuff, self.TOPRIGHT, self.SPACING, 0)
		end

		colPoint = colPoint + buffSize + 1

		local nextBuff = list[i + 1]
		local nextBuffSize = buffSize
		if (nextBuff) then
			nextBuffSize = (nextBuff.big and (buffSizeBase * 2)) or buffSizeBase
		end

		if (self.conf.buffs.wrap and colPoint + nextBuffSize + 1 > rowSize) then
			if (buff.big and decrementMaxRowsIfLastIsBig) then
				decrementMaxRowsIfLastIsBig = nil
				maxRows = maxRows - 1
			end

			colPoint = 0
			curRow = curRow + 1
			if (prevRow.big) then
				rowsHeight = rowsHeight + (buffSize * 2) + 1
			else
				rowsHeight = rowsHeight + buffSize + 1
			end
			firstOfRow = true
		end

		prevBuff = buff
	end

	if (hideFrom) then
		for i = hideFrom,#list do
			list[i]:Hide()
		end
	end
	if (useSmallStart) then
		self.hideFrom1 = hideFrom
	else
		self.hideFrom2 = hideFrom
	end

	self.prevBuff = prevRow
end

-- XPerl_Unit_BuffPositions
function XPerl_Unit_BuffPositions(self, buffList1, buffList2, size1, size2)
	local optMix = format("%d%d%d%d%d%d%d", self.perlBuffs or 0, self.perlDebuffs or 0, self.perlBuffsMine or 0, self.perlDebuffsMine or 0, UnitCanAttack("player", self.partyid) or 2, (UnitManaMax(self.partyid) > 0 and 1) or 0, (self.creatureTypeFrame and self.creatureTypeFrame:IsVisible() and 1) or 0)
	if (optMix ~= self.buffOptMix) then
		WieghAnchor(self)

		local buffsFirst = self.buffFrame.buff == buffList1

		self.buffOptMix = optMix
		self.prevBuff = nil

		if (self.GetBuffSpacing) then
			self:GetBuffSpacing(self)
		else
			XPerl_Unit_BuffSpacing(self)
		end

		-- De-anchor first 2 because faction changes can mess up the order of things.
		if (buffList1 and buffList1[1]) then buffList1[1]:ClearAllPoints() end
		if (buffList2 and buffList2[1]) then buffList2[1]:ClearAllPoints() end

		if (buffList1) then
			XPerl_Unit_BuffPositionsType(self, buffList1, true, size1)
		end
		if (buffList2) then
			XPerl_Unit_BuffPositionsType(self, buffList2, false, size2)
		end

		if (buffList2) then
			-- If top row is disabled, then nudge the bottom row into it's place
			if (buffsFirst) then
				if (not self.conf.buffs.enable) then
					buffList2[1]:SetPoint(self.TOPLEFT, self.buffFrame, self.TOPLEFT, 0, self.VSPACING)
				end
			else
				if (not self.conf.debuffs.enable) then
					buffList2[1]:SetPoint(self.TOPLEFT, self.buffFrame, self.TOPLEFT, 0, self.VSPACING)
				end
			end
		end
	else
		if (self.hideFrom1 and buffList1) then
			for i = self.hideFrom1,#buffList1 do
				buffList1[i]:Hide()
			end
		end
		if (self.hideFrom2 and buffList2) then
			for i = self.hideFrom2,#buffList2 do
				buffList2[i]:Hide()
			end
		end
	end
end

local function fixMeBlizzard(self)
	self.anim:Play()
	self:SetScript("OnUpdate", nil)
end

-- XPerl_Unit_UpdateBuffs(self)
function XPerl_Unit_UpdateBuffs(self, maxBuffs, maxDebuffs, castableOnly, curableOnly)
	local buffs, debuffs, buffsMine, debuffsMine = 0, 0, 0, 0
	local partyid = self.partyid

	if (self.conf and UnitExists(partyid)) then
		if (not maxBuffs) then maxBuffs = 24 end
		if (not maxDebuffs) then maxDebuffs = 40 end
		local lastIcon = 0

		XPerl_GetBuffButton(self, 1, 0, true)
		XPerl_GetBuffButton(self, 1, 1, true)

		local isFriendly = not UnitCanAttack("player", partyid)

		if (self.conf.buffs.enable and maxBuffs and maxBuffs > 0) then
			local buffIconIndex = 1
			self.buffFrame:Show()
			for mine = 1,2 do
				if (self.conf.buffs.onlyMine and mine == 2) then
					if (not UnitCanAttack("player", partyid)) then
						break
					end
					-- else we'll ignore this option for enemy targets, because
					-- it's unlikey that we'll be buffing them
				end
				-- Two passes here now since 3.0.1, cos they did away with the GetPlayerBuff function
				-- in favor of all in UnitBuff instead. We still want our big buffs first in the list,
				-- so we have to scan thru twice. I know what you're thinking; "Why do 2 passes when
				-- player's buffs are first anyway". Well, usually they are, but in the case of hunters
				-- and warlocks, the pet triggered buffs can be anywhere, but we still want those alongside
				-- our own buffs.
				for buffnum = 1,maxBuffs do
					local filter = castableOnly == 1 and "RAID" or nil
					local name, rank, buff, count, _, duration, endTime, isMine, isStealable = XPerl_UnitBuff(partyid, buffnum, filter)
					if (not name) then
						if (mine == 1) then
							maxBuffs = buffnum - 1
						end
						break
					end
					if (self.conf.buffs.bigpet) then
						isMine = isMine == "player" or isMine == "pet" or isMine == "vehicle"
					else
						isMine = isMine == "player" or isMine == "vehicle"
					end

					if (buff and (((mine == 1) and (isMine or isStealable)) or ((mine == 2) and not (isMine or isStealable)))) then
						local button = XPerl_GetBuffButton(self, buffIconIndex, 0, true, buffnum)
						button.filter = filter
						button:SetAlpha(1)

						buffs = buffs + 1

						button.icon:SetTexture(buff)
						if (count > 1) then
							button.count:SetText(count)
							button.count:Show()
						else
							button.count:Hide()
						end
	
						-- Handle cooldowns
						if (button.cooldown) then
							if (duration and conf.buffs.cooldown and (isMine or conf.buffs.cooldownAny)) then
								local start = endTime - duration
								XPerl_CooldownFrame_SetTimer(button.cooldown, start, duration, 1, isMine)
							else
								button.cooldown:Hide()
							end
						end

						button:Show()

						if (isStealable) then		--  and UnitCanAttack("player", partyid)
							if (not button.steal) then
								button.steal = CreateFrame("Frame", nil, button)
								button.steal:SetPoint("TOPLEFT", -2, 2)
								button.steal:SetPoint("BOTTOMRIGHT", 2, -2)

								button.steal.tex = button.steal:CreateTexture(nil, "OVERLAY")
								button.steal.tex:SetAllPoints()
								button.steal.tex:SetTexture("Interface\\Addons\\XPerl\\Images\\StealMe")

								local g = button.steal.tex:CreateAnimationGroup()
								button.steal.anim = g
								local r = g:CreateAnimation("Rotation")
								g.rot = r

								r:SetDuration(4)
								r:SetDegrees(-360)
								r:SetOrigin("CENTER", 0, 0)

								g:SetLooping("REPEAT")
								g:Play()
							end

							button.steal:Show()
							button.steal:SetScript("OnUpdate", fixMeBlizzard)		-- Workaround for Play not always working..
						else
							if (button.steal) then
								button.steal:Hide()
							end
						end

						lastIcon = buffIconIndex
	
						if ((self.conf.buffs.big and isMine) or (self.conf.buffs.bigStealable and isStealable)) then
							buffsMine = buffsMine + 1
							button.big = true
							button:SetScale((self.conf.buffs.size * 2) / 32)
						else
							button.big = nil
							button:SetScale(self.conf.buffs.size / 32)
						end
						buffIconIndex = buffIconIndex + 1
					end
				end
			end
			for buffnum = lastIcon + 1,40 do
				local button = self.buffFrame.buff and self.buffFrame.buff[buffnum]
				if (button) then
					button.expireTime = nil
					button:Hide()
				else
					break
				end
			end
		else
			self.buffFrame:Hide()
		end

		if (self.conf.debuffs.enable and maxDebuffs and maxDebuffs > 0) then
			local buffIconIndex = 1
			self.debuffFrame:Show()
			lastIcon = 0
			for mine = 1,2 do
				if (self.conf.debuffs.onlyMine and mine == 2) then
					if (UnitCanAttack("player", partyid)) then
						break
					end
					-- Else we'll ignore this option for friendly targets, because it's unlikey
					-- (except for PW:Shield and HoProtection) that we'll be debuffing friendlies
				end

				for buffnum = 1,maxDebuffs do
					local filter = (isFriendly and curableOnly == 1 or castableOnly == 1) and "RAID" or nil
					local name, rank, debuff, debuffApplications, debuffType, duration, endTime, isMine, isStealable = XPerl_UnitDebuff(partyid, buffnum, filter)
					if (not name) then
						if (mine == 1) then
							maxDebuffs = buffnum - 1
						end
						break
					end

					if (self.conf.buffs.bigpet) then
						isMine = isMine == "player" or isMine == "pet" or isMine == "vehicle"
					else
						isMine = isMine == "player"
					end

					if (debuff and (((mine == 1) and isMine) or ((mine == 2) and not isMine))) then
						local button = XPerl_GetBuffButton(self, buffIconIndex, 1, true, buffnum)
						button.filter = filter
						button:SetAlpha(1)

						debuffs = debuffs + 1

						button.icon:SetTexture(debuff)
						if ((debuffApplications or 0) > 1) then
							button.count:SetText(debuffApplications)
							button.count:Show()
						else
							button.count:Hide()
						end

						local borderColor = DebuffTypeColor[(debuffType or "none")]
						button.border:SetVertexColor(borderColor.r, borderColor.g, borderColor.b)

						-- Handle cooldowns
						if (button.cooldown) then
							if (duration and conf.buffs.cooldown and (isMine or conf.buffs.cooldownAny)) then
								local start = endTime - duration
								XPerl_CooldownFrame_SetTimer(button.cooldown, start, duration, 1, isMine)
							else
								button.cooldown:Hide()
							end
						end

						lastIcon = buffIconIndex
						button:Show()

						if (self.conf.debuffs.big and isMine) then
							debuffsMine = debuffsMine + 1
							button.big = true
							button:SetScale((self.conf.debuffs.size * 2) / 32)
						else
							button.big = nil
							button:SetScale(self.conf.debuffs.size / 32)
						end
						buffIconIndex = buffIconIndex + 1
					end
				end
			end
			for buffnum = lastIcon + 1,40 do
				local button = self.buffFrame.debuff and self.buffFrame.debuff[buffnum]
				if (button) then
					button.expireTime = nil
					button:Hide()
				else
					break
				end
			end
		else
			self.debuffFrame:Hide()
		end
	end

	self.perlBuffs = buffs
	self.perlDebuffs = debuffs

	if (self.conf and self.conf.buffs.big) then
		self.perlBuffsMine = buffsMine
		self.perlDebuffsMine = debuffsMine
	else
		self.perlBuffsMine, self.perlDebuffsMine = nil, nil
	end
end

-- XPerl_SetBuffSize
function XPerl_SetBuffSize(self)
	local sizeBuff = self.conf.buffs.size
	local sizeDebuff = (self.conf.debuffs and self.conf.debuffs.size) or (sizeBuff * (1 + self.buffSetup.debuffSizeMod))

	local buff
	for i = 1,40 do
		buff = self.buffFrame.buff and self.buffFrame.buff[i]
		if (buff) then
			buff:SetScale(sizeBuff / 32)
		end

		buff = self.buffFrame.debuff and self.buffFrame.debuff[i]
		if (buff) then
			buff:SetScale(sizeDebuff / 32)
		end

		buff = self.buffFrame.tempEnchant and self.buffFrame.tempEnchant[i]
		if (buff) then
			buff:SetScale(sizeBuff / 32)
		end
	end
end

-- XPerl_Update_RaidIcon
function XPerl_Update_RaidIcon(self, unit)
	local index = GetRaidTargetIndex(unit)
	if (index) then
		SetRaidTargetIconTexture(self, index)
		self:Show()
	else
		self:Hide()
	end
end

------------------------------------------------------------------------------
-- Flashing frames handler. Is hidden when there's nothing to do.
local FlashFrame = CreateFrame("Frame", "XPerl_FlashFrame")
FlashFrame.list = {}

-- XPerl_FrameFlash_OnUpdate(self, elapsed)
function XPerl_FrameFlash_OnUpdate(self, elapsed)
	for k,v in pairs(self.list) do
		if (k.frameFlash.out) then
			k.frameFlash.alpha = k.frameFlash.alpha - elapsed
			if (k.frameFlash.alpha < 0.2) then
				k.frameFlash.alpha = 0.2
				k.frameFlash.out = nil

				if (k.frameFlash.method == "out") then
					XPerl_FrameFlashStop(k)
				end
			end
		else
			k.frameFlash.alpha = k.frameFlash.alpha + elapsed
			if (k.frameFlash.alpha > 1) then
				k.frameFlash.alpha = 1
				k.frameFlash.out = true

				if (k.frameFlash.method == "in") then
					XPerl_FrameFlashStop(k)
				end
			end
		end

		if (k.frameFlash) then
			k:SetAlpha(k.frameFlash.alpha)
		end
	end
end

FlashFrame:SetScript("OnUpdate", XPerl_FrameFlash_OnUpdate)

-- XPerl_FrameFlash
function XPerl_FrameFlash(self)
	if (not FlashFrame.list[self]) then
		if (self.frameFlash) then
			error("X-Perl ["..self:GetName()..".frameFlash is set with no entry in FlashFrame.list]")
		end

		self.frameFlash = XPerl_GetReusableTable()
		self.frameFlash.out = true
		self.frameFlash.alpha = 1
		self.frameFlash.shown = self:IsShown()
		--self.frameFlash = {out = true, alpha = 1, shown = self:IsShown()}

		FlashFrame.list[self] = true
		FlashFrame:Show()
		self:Show()
	end
end

-- XPerl_FrameIsFlashing(self)
function XPerl_FrameIsFlashing(self)
	return self.frameFlash		--FlashFrame.list[self]
end

-- XPerl_FrameFlashStop
function XPerl_FrameFlashStop(self, method)
	if (not self.frameFlash) then
		return
	end

	if (method) then
		self.frameFlash.method = method
		return
	end

	if (not self.frameFlash.shown) then
		self:Hide()
	end

	XPerl_FreeTable(self.frameFlash)
	self.frameFlash = nil

	self:SetAlpha(1)

	FlashFrame.list[self] = nil

	if (not next(FlashFrame.list)) then
		FlashFrame:Hide()
	end
end

-- XPerl_ProtectedCall
function XPerl_ProtectedCall(func, self)
	if (func) then
		if (InCombatLockdown()) then
			if (self) then
				tinsert(XPerl_OutOfCombatQueue, {func, self})
			else
				tinsert(XPerl_OutOfCombatQueue, func)
			end
		else
			func(self)
		end
	end
end

-- nextMember(last)
function XPerl_NextMember(_, last)
	if (last) then
		local raidCount = GetNumRaidMembers()
		if (raidCount > 0) then
			local i = tonumber(strmatch(last, "^raid(%d+)"))
			if (i and i < raidCount) then
				i = i + 1
				local unitName, rank, group, level, _, unitClass, zone, online, dead = GetRaidRosterInfo(i)
				return "raid"..i, unitName, unitClass, group, zone, online, dead
			end
		else
			local partyCount = GetNumPartyMembers()
			if (partyCount > 0) then
				local id
				if (last == "player") then
					id = "party1"
				else
					local i = tonumber(strmatch(last, "^party(%d+)"))
					if (i and i < partyCount) then
						i = i + 1
						id = "party"..i
					end
				end

				if (id) then
					return id, UnitName(id), select(2, UnitClass(id)), 1, "", UnitIsConnected(id), UnitIsDeadOrGhost(id)
				end
			end
		end
	else
		if (GetNumRaidMembers() > 0) then
			local unitName, rank, group, level, _, unitClass, zone, online, dead = GetRaidRosterInfo(1)
			return "raid1", unitName, unitClass, group, zone, online, dead
		else
			return "player", UnitName("player"), select(2, UnitClass("player")), 1, GetRealZoneText(), 1, UnitIsDeadOrGhost("player")
		end
	end
end

-- Some models have camera views switched for face/body or just don't look right with face
local alternateCamera = {
	[21717] = true,			-- Dragonmaw Wrangler
	[21718] = true,			-- Dragonmaw Subjugator
	[21719] = true,			-- Dragonmaw Drake-Rider
	[21720] = true,			-- Dragonmaw Shaman
	[22231] = true,			-- Dragonmaw Elite
	[22252] = true,			-- Dragonmaw Peon
	[23188] = true,			-- Dragonmaw Transporter
	[28859] = true,			-- Malygos
	[33136] = true,			-- Guardian of Yogg-Saron
	[33687] = true,			-- Chillmaw
	[33845] = true,			-- Quel'dorei Steed
	[37230] = true,			-- Spire Frostwyrm (ICC)
	[37955] = true,			-- Blood Queen Lana'thel
}
local dragonmawIllusion = GetSpellInfo(42016)

-- PerlSetPortrait3D
local function XPerlSetPortrait3D(self, argUnit)
	self:ClearModel()
	self:SetUnit(argUnit)

	local guid = UnitGUID(argUnit)
	local id = guid and tonumber(strsub(guid, -12, -7), 16)
	if (alternateCamera[id] or UnitBuff(argUnit, dragonmawIllusion)) then
		self:SetCamera(1)
	else
		self:SetCamera(0)
	end
end

-- XPerl_Unit_UpdatePortrait()
function XPerl_Unit_UpdatePortrait(self)
	if (self.conf and self.conf.portrait) then
		local pf = self.portraitFrame
		if (self.conf.portrait3D and UnitIsVisible(self.partyid)) then
			pf.portrait:Hide()
			pf.portrait3D:Show()
			XPerlSetPortrait3D(pf.portrait3D, self.partyid)
		else
			pf.portrait:Show()
			pf.portrait3D:Hide()
			SetPortraitTexture(pf.portrait, self.partyid)
		end
	end
end

-- XPerl_Unit_UpdateLevel
function XPerl_Unit_UpdateLevel(self)
	local level = UnitLevel(self.partyid)
	local color = GetDifficultyColor(level)
	if (self.levelFrame) then
		self.levelFrame.text:SetTextColor(color.r,color.g,color.b)
		self.levelFrame.text:SetText(level)
	elseif (self.nameFrame.level) then
		if (level == 0) then
			level = ""
		end
		self.nameFrame.level:SetTextColor(color.r,color.g,color.b)
		self.nameFrame.level:SetText(level)
	end
end

-- XPerl_Unit_GetHealth
function XPerl_Unit_GetHealth(self)
	local partyid = self.partyid
	local hp, hpMax = XPerl_UnitHealth(partyid), UnitHealthMax(partyid)

	if (hp > hpMax) then
		if (UnitIsDeadOrGhost(partyid)) then
			hp = 0
		else
			hp = hpMax
		end
	end

	return hp or 0, hpMax or 1, (hpMax == 100)
end

-- XPerl_Unit_OnEnter
function XPerl_Unit_OnEnter(self)
	XPerl_PlayerTip(self)
	if (self.highlight) then
		self.highlight:Select()
	end
	XPerl_Tutorial(self.tutorialPage)

	if (self.statsFrame and self.statsFrame.healthBar and self.statsFrame.healthBar.text and not self.statsFrame.healthBar.text:IsShown()) then
		self.hideValues = true
		self.statsFrame.healthBar.text:Show()
		if (self.statsFrame.manaBar) then
			self.statsFrame.manaBar.text:Show()
		end
		if (self.statsFrame.xpBar and self.statsFrame.xpBar:IsShown()) then
			self.statsFrame.xpBar.text:Show()
		end
		if (self.statsFrame.repBar and self.statsFrame.repBar:IsShown()) then
			self.statsFrame.repBar.text:Show()
		end
	end
end

-- XPerl_Unit_OnLeave
function XPerl_Unit_OnLeave(self)
	XPerl_PlayerTipHide()
	if (self.highlight) then
		self.highlight:Deselect()
	end

	if (self.hideValues) then
		self.hideValues = nil

		self.statsFrame.healthBar.text:Hide()
		if (self.statsFrame.manaBar) then
			self.statsFrame.manaBar.text:Hide()
		end
		if (self.statsFrame.xpBar and self.statsFrame.xpBar:IsShown()) then
			self.statsFrame.xpBar.text:Hide()
		end
		if (self.statsFrame.repBar and self.statsFrame.repBar:IsShown()) then
			self.statsFrame.repBar.text:Hide()
		end
	end
end

-- XPerl_Unit_SetBuffTooltip
function XPerl_Unit_SetBuffTooltip(self)
	if (conf and conf.tooltip.enableBuffs and XPerl_TooltipModiferPressed(true)) then
		if (not conf.tooltip.buffHideInCombat or not InCombatLockdown()) then
			local frame = self:GetParent():GetParent()
			local partyid = frame.partyid
			if (partyid) then
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT",0,0)
				XPerl_TooltipSetUnitBuff(GameTooltip, partyid, self:GetID(), self.filter)
			end
		end
	end
end

-- XPerl_Unit_SetDeBuffTooltip
function XPerl_Unit_SetDeBuffTooltip(self)
	if (conf and conf.tooltip.enableBuffs and XPerl_TooltipModiferPressed(true)) then
		if (not conf.tooltip.hideInCombat or not InCombatLockdown()) then
			local frame = self:GetParent():GetParent()
			local partyid = frame.partyid
			if (partyid) then
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT",0,0)
				XPerl_TooltipSetUnitDebuff(GameTooltip, partyid, self:GetID(), self.filter)
			end
		end
	end
end

-- XPerl_Unit_UpdateReadyState
function XPerl_Unit_UpdateReadyState(self)
	local status = conf.showReadyCheck and self.partyid and GetReadyCheckStatus(self.partyid)
	if (status) then
		self.statsFrame.ready:Show()
		if (status == "ready") then
			self.statsFrame.ready.check:SetTexture(READY_CHECK_READY_TEXTURE)
		elseif (status == "waiting") then
			self.statsFrame.ready.check:SetTexture(READY_CHECK_WAITING_TEXTURE)
		else -- "notready"
			self.statsFrame.ready.check:SetTexture(READY_CHECK_NOT_READY_TEXTURE)
		end
	else
		self.statsFrame.ready:Hide()
	end
end

-- XPerl_SwitchAnchor(self, new)
-- Changes anchored corner without actually moving the frame

-- XPerl_SwitchAnchor
function XPerl_SwitchAnchor(self, New)
	if (not self:GetPoint(2)) then
		local a1, f, a2, x, y = self:GetPoint(1)

		if (a1 == a2 and New ~= a1) then
			local parent = self:GetParent()
			local newV = strmatch(New, "TOP") or strmatch(New, "BOTTOM")
			local newH = strmatch(New, "LEFT") or strmatch(New, "RIGHT")

			if (newV == "TOP") then
				y = -(768 - (self:GetTop() * self:GetEffectiveScale())) / self:GetEffectiveScale()
			elseif (newV == "BOTTOM") then
				y = self:GetBottom()
			else
				y = self:GetBottom() + self:GetHeight() / 2
			end

			if (newH == "LEFT") then
				x = self:GetLeft()
			elseif (newV == "RIGHT") then
				x = self:GetRight()
			else
				x = self:GetLeft() + self:GetWidth() / 2
			end

			self:ClearAllPoints()
			self:SetPoint(New, f, New, x, y)
		end
	end
end

---------------------------------
-- Scaling frame corner thingy --
---------------------------------
-- Seems a convoluted way of doing things, rather than just anchoring bottomleft, topright.. but
-- doing that introduces a really ugly latency between the anchor moving and the frame scaling because
-- the OnSizeChanged event is fired on the frame after the actual resize took place.

local scaleIndication

local function scaleMouseDown(self)

	GameTooltip:Hide()

	if (self.resizable and IsShiftKeyDown()) then
		self.sizing = true
	elseif (self.scalable) then
		self.scaling = true
	end

	if (not scaleIndication) then
		scaleIndication = CreateFrame("Frame", nil, UIParent)
		scaleIndication:SetWidth(100)
		scaleIndication:SetHeight(18)
		scaleIndication.text = scaleIndication:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		scaleIndication.text:SetAllPoints()
		scaleIndication.text:SetJustifyH("LEFT")
	end

	scaleIndication:Show()
	scaleIndication:ClearAllPoints()
	scaleIndication:SetPoint("LEFT", self, "RIGHT", 4, 0)

	if (self.scaling) then
		scaleIndication.text:SetFormattedText("%.1f%%", self.frame:GetScale() * 100)
	else
		scaleIndication.text:SetFormattedText("%dx%d", self.frame:GetWidth(), self.frame:GetHeight())
	end

	self.anchor:StartSizing(self.resizeTop and "TOPRIGHT")

	self.oldBdBorder = {self.frame:GetBackdropBorderColor()}
	self.frame:SetBackdropBorderColor(1, 1, 0.5, 1)
end

local function scaleMouseUp(self)
	self.anchor:StopMovingOrSizing()

	scaleIndication:Hide()

	XPerl_SavePosition(self.anchor)

	if (self.resizeTop) then
		XPerl_SwitchAnchor(self.anchor, "BOTTOMLEFT")
	end

	if (self.scaling) then
		if (self.onScaleChanged) then
			self:onScaleChanged(self.frame:GetScale())
		elseif (self.onSizeChanged) then
			self:onSizeChanged(self.frame:GetWidth(), self.frame:GetHeight())
		end
	end

	if (self.oldBdBorder) then
		self.frame:SetBackdropBorderColor(unpack(self.oldBdBorder))
		self.oldBdBorder = nil
	end

	self.scaling = nil
	self.sizing = nil
end

local function scaleMouseChange(self)
	if (self.corner.sizing) then
		self.corner.frame:SetWidth(self:GetWidth() / self.corner.frame:GetScale())
		self.corner.frame:SetHeight(self:GetHeight() / self.corner.frame:GetScale())

		self.corner.startSize.w = self.corner.frame:GetWidth()
		self.corner.startSize.h = self.corner.frame:GetHeight()

		if (scaleIndication and scaleIndication:IsShown()) then
			scaleIndication.text:SetFormattedText("|c00FFFF80%d|c00808080x|c00FFFF80%d", self.corner.frame:GetWidth(), self.corner.frame:GetHeight())
		end

	elseif (self.corner.scaling) then
		local w = self:GetWidth()
		if (w) then
			self.corner.scaling = nil
			local ratio = self.corner.frame:GetWidth() / self.corner.frame:GetHeight()
			local s = min(self.corner.maxScale, max(self.corner.minScale, w / self.corner.startSize.w))	-- New Scale

			w = self.corner.startSize.w * s		-- Set height and width of anchor window to match ratio of actual
			if (self.corner.resizeTop) then
				XPerl_SwitchAnchor(self, "BOTTOMLEFT")
				local bottom, left = self:GetBottom(), self:GetLeft()
				self:SetWidth(w)
				self:SetHeight(w / ratio)
			else
				self:SetWidth(w)
				self:SetHeight(w / ratio)
			end

			if (scaleIndication and scaleIndication:IsShown()) then
				scaleIndication.text:SetFormattedText("%.1f%%", s * 100)
			end

			self.corner.frame:SetScale(s)
			self.corner.scaling = true
		end
	end
end

-- scaleMouseEnter
local function scaleMouseEnter(self)
	self.tex:SetVertexColor(1, 1, 1, 1)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	if (self.scalable) then
		GameTooltip:SetText(XPERL_DRAGHINT1, nil, nil, nil, nil, 1)
	end
	if (self.resizable) then
		GameTooltip:AddLine(XPERL_DRAGHINT2, nil, nil, nil, 1)
	end
	GameTooltip:Show()
end

-- scaleMouseLeave
local function scaleMouseLeave(self)
	self.tex:SetVertexColor(1, 1, 1, 0.5)
	GameTooltip:Hide()
end

-- XPerl_RegisterScalableFrame
function XPerl_RegisterScalableFrame(self, anchorFrame, minScale, maxScale, resizeTop, resizable, scalable)
	if (scalable == nil) then
		scalable = true
	end

	if (not self.corner) then
		self.corner = CreateFrame("Frame", nil, self)
		self.corner:SetFrameLevel(self:GetFrameLevel() + 3)
		self.corner:EnableMouse(true)
		self.corner:SetScript("OnMouseDown", scaleMouseDown)
		self.corner:SetScript("OnMouseUp", scaleMouseUp)
		self.corner:SetScript("OnEnter", scaleMouseEnter)
		self.corner:SetScript("OnLeave", scaleMouseLeave)
		self.corner:SetHeight(12)
		self.corner:SetWidth(12)

		anchorFrame:SetScript("OnSizeChanged", scaleMouseChange)
		anchorFrame.corner = self.corner

		self.corner.tex = self.corner:CreateTexture(nil, "BORDER")
		self.corner.tex:SetTexture("Interface\\Addons\\XPerl\\images\\XPerl_Elements")
		self.corner.tex:SetAllPoints()
		self.corner.tex:SetVertexColor(1, 1, 1, 0.5)

		self.corner.anchor = anchorFrame
		self.corner.frame = self
	end

	self:SetMinResize(10, 10)

	self.corner.scalable = scalable
	self.corner.resizable = resizable
	self.corner.resizeTop = resizeTop
	self.corner.minScale = minScale or 0.4
	self.corner.maxScale = maxScale or 5
	self.corner.startSize = {w = self:GetWidth(), h = self:GetHeight()}

	local bgDef = self:GetBackdrop()

	self.corner:ClearAllPoints()
	if (resizeTop) then
		self.corner.tex:SetTexCoord(0.78125, 1, 0.5, 0.703125)
		self.corner:SetPoint("TOPRIGHT", -bgDef.insets.right, -bgDef.insets.top)
		self.corner:SetHitRectInsets(0, -6, -6, 0)		-- So the click area extends over the tooltip border
	else
		self.corner.tex:SetTexCoord(0.78125, 1, 0.78125, 1)
		self.corner:SetPoint("BOTTOMRIGHT", -bgDef.insets.right, bgDef.insets.bottom)
		self.corner:SetHitRectInsets(0, -6, 0, -6)		-- So the click area extends over the tooltip border
	end

	self.corner.scaling = true
	scaleMouseChange(anchorFrame)
	self.corner.scaling = nil
end

-- HealComm/LibQuickHealth interface
XPerl_UnitHealth = UnitHealth
XPerl_ExpectedUnitHealth = XPerl_UnitHealth
function XPerl_SetExpectedHealth()
end

function XPerl_Load_LQHLHC()
	if (LibStub or LoadAddOn("LibStub")) then
		local lqh = 1
		LoadAddOn("LibQuickHealth-2.0")
		local QuickHealth = LibStub("LibQuickHealth-2.0", true)
		if (QuickHealth) then
			lqh = 2
		else
			LoadAddOn("LibQuickHealth-1.0")
			QuickHealth = LibStub("LibQuickHealth-1.0", true)
		end

		if (QuickHealth) then
			QuickHealth.RegisterCallback("XPerlHealthCallback", "HealthUpdated",
				function(event, GUID, newHealth)
					if (XPerl_Raid_Frame and conf.raid.enable and GetNumRaidMembers() > 0) then
						local f = XPerl_Raid_GetUnitFrameByGUID(GUID)
						if (f) then
							XPerl_Raid_UpdateHealth(f)
						end
					end

					if (XPerl_party1 and GetNumPartyMembers() > 0) then
						local f = XPerl_Party_GetUnitFrameByGUID(GUID)
						if (f) then
							XPerl_Party_UpdateHealth(f)
						end
					end

					if (XPerl_Player and UnitGUID("player") == GUID) then
						XPerl_Player_UpdateHealth(XPerl_Player)
					end

					if (XPerl_Player_Pet and UnitGUID("pet") == GUID) then
						XPerl_Player_Pet_UpdateHealth(XPerl_Player_Pet)
					end

					if (XPerl_Target and UnitGUID("target") == GUID) then
						XPerl_Target_SetHealth(XPerl_Target)
					end

					if (XPerl_Focus and UnitGUID("focus") == GUID) then
						XPerl_Target_SetHealth(XPerl_Focus)
					end
				end
			)

			if (lqh == 2) then
				XPerl_UnitHealth = QuickHealth.UnitHealth
			else
				function XPerl_UnitHealth(...)
					if (not UnitIsFriend("player", "target")) then	-- UnitCanAttack("player", ...)) then
						return UnitHealth(...)
					else
						return QuickHealth:UnitHealth(...)
					end
				end
			end
		end

		-- HealComm interface
		LoadAddOn("LibHealComm-4.0")
		local HealComm4 = LibStub and LibStub("LibHealComm-4.0", true)
		local HealComm3
		if (not HealComm4) then
			LoadAddOn("LibHealComm-3.0")
			HealComm3 = LibStub and LibStub("LibHealComm-3.0", true)
		end

		if ((HealComm3 and HealComm3.UnitIncomingHealGet) or (HealComm4 and HealComm4.GetHealAmount)) then
			local myHeals = {}
			local hcMiniFrame = CreateFrame("Frame", nil)
			hcMiniFrame:RegisterEvent("RAID_ROSTER_UPDATE")
			hcMiniFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
			hcMiniFrame:SetScript("OnEvent", function()
				local temp = new()

				if (GetNumRaidMembers() > 0) then
					for i = 1,GetNumRaidMembers() do
						local id = "raid"..i
						local guid = UnitGUID(id)
						if (guid) then
							temp[guid] = true
							id = "raidpet"..i
							guid = UnitGUID(id)
							if (guid) then
								temp[guid] = true
							end
						end
					end
				elseif (GetNumPartyMembers() > 0) then
					for i = 0,GetNumPartyMembers() do
						local id = i == 0 and "player" or "party"..i
						local guid = UnitGUID(id)
						if (guid) then
							temp[guid] = true
							id = i == 0 and "pet" or "raidpet"..i
							guid = UnitGUID(id)
							if (guid) then
								temp[guid] = true
							end
						end
					end
				else
					myHeals = {}
				end

				for guid in pairs(myHeals) do
					if (not temp[guid]) then
						myHeals[guid] = nil
					end
				end

				del(temp)
			end)

			local guidFrame = CreateFrame("Frame")
			guidFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
			local playerGUID, targetGUID, focusGUID, petGUID, targettargetGUID

			guidFrame:SetScript("OnEvent", function(self, event, ...)
				local f = self[event]
				if (f) then f(self, ...) end
			end)
		
			function guidFrame:PLAYER_ENTERING_WORLD()
				self:UnregisterEvent("PLAYER_ENTERING_WORLD")
				self:RegisterEvent("PLAYER_LEAVING_WORLD")
				self:RegisterEvent("PLAYER_TARGET_CHANGED")
				self:RegisterEvent("PLAYER_FOCUS_CHANGED")
				self:RegisterEvent("UNIT_PET")
				playerGUID = UnitGUID("player")
				self:GetGUIDs()
				self.PLAYER_ENTERING_WORLD = nil
			end

			function guidFrame:PLAYER_LEAVING_WORLD()
				targetGUID, focusGUID, targettargetGUID = nil, nil, nil
			end

			function guidFrame:GetGUIDs()
				petGUID = UnitGUID("pet")
				targetGUID = UnitGUID("target")
				targettargetGUID = UnitGUID("targettarget")
				focusGUID = UnitGUID("focus")
			end

			guidFrame.PLAYER_TARGET_CHANGED = guidFrame.GetGUIDs
			guidFrame.PLAYER_FOCUS_CHANGED = guidFrame.GetGUIDs

			function guidFrame:UNIT_PET(unit)
				if (unit == "player") then
					self:GetGUIDs()
				end
			end

			-- XPerl_ExpectedUnitHealth
			function XPerl_ExpectedUnitHealth(unit)
				local health = XPerl_UnitHealth(unit)
				if (HealComm3) then
					local incoming = HealComm3:UnitIncomingHealGet(unit, GetTime() + 100) or 0
					incoming = incoming + (myHeals[UnitGUID(unit)] or 0)
					if (incoming > 0) then
						local effective = incoming * HealComm3:UnitHealModifierGet(unit)
						return health + effective
					end
				else
					local incoming = HealComm4:GetHealAmount(UnitGUID(unit), HealComm4.ALL_HEALS, GetTime() + 5)
					if (incoming and incoming > 0) then
						local effective = incoming * HealComm4:GetHealModifier(UnitGUID(unit))
						return health + effective
					end
				end

				return health
			end

			-- XPerl_SetExpectedHealth
			function XPerl_SetExpectedHealth(self)
				local bar = self.statsFrame.expectedHealth
				if (bar) then
					local expectedHealth = XPerl_ExpectedUnitHealth(self.partyid)
					if (expectedHealth == XPerl_UnitHealth(self.partyid)) then
						bar:Hide()
					else
						local healthMax = UnitHealthMax(self.partyid)
						bar:Show()
						bar:SetMinMaxValues(0, healthMax)
						bar:SetValue(expectedHealth)
					end
				end
			end

			if (HealComm3) then
				local function UpdateIncomingHeals(healerFullName, healSize, ...)
					for i = 1,select("#",...) do
						local name = select(i, ...)
						local guid = UnitGUID(name)
						local f

						if (guid) then
							if (healSize and UnitIsUnit("player", healerFullName)) then
								myHeals[guid] = healSize
							end

							if (XPerl_Raid_GetUnitFrameByGUID) then
								f = XPerl_Raid_GetUnitFrameByGUID(guid)
								if (f) then
									XPerl_Raid_UpdateHealth(f)
								end
							end

							if (XPerl_Party_GetUnitFrameByGUID) then
								f = XPerl_Party_GetUnitFrameByGUID(guid)
								if (f) then
									XPerl_Party_UpdateHealth(f)
								end
							end

							if (XPerl_Player_UpdateHealth and guid == playerGUID) then
								XPerl_Player_UpdateHealth(XPerl_Player)
							elseif (XPerl_Player_Pet_UpdateHealth and guid == petGUID) then
								XPerl_Player_Pet_UpdateHealth(XPerl_Player)
							elseif (XPerl_Party_Pet_GetUnitFrameByGUID) then
								f = XPerl_Party_Pet_GetUnitFrameByGUID(guid)
								if (f) then
									XPerl_Party_Pet_UpdateHealth(f)
								end
							end

							if (XPerl_Target_SetHealth and guid == targetGUID) then
								XPerl_Target_SetHealth(XPerl_Target)
							end
							if (XPerl_Target_SetHealth and XPerl_Focus and guid == focusGUID) then
								XPerl_Target_SetHealth(XPerl_Focus)
							end
							if (XPerl_Target_SetHealth and XPerl_TargetTarget and guid == targettargetGUID) then
								XPerl_Target_SetHealth(XPerl_TargetTarget)
							end
						end
					end
				end

				local function xperl_HealComm_DirectHealStart(event, healerFullName, healSize, endTime, ...)
					--ChatFrame1:AddMessage(format("xperl_HealComm_DirectHealStart(%s, %s, %s, %s, %s)", tostring(event), tostring(healerFullName), tostring(healSize), tostring(endTime), tostring(...)))
					UpdateIncomingHeals(healerFullName, healSize, ...)
				end
				local function xperl_HealComm_DirectHealStop(event, healerFullName, healSize, succeeded, ...)
					--ChatFrame1:AddMessage(format("xperl_HealComm_DirectHealStop(%s, %s, %s, %s, %s)", tostring(event), tostring(healerFullName), tostring(healSize), tostring(endTime), tostring(...)))
					UpdateIncomingHeals(healerFullName, 0, ...)
				end
				local function xperl_HealComm_DirectHealDelayed(event, healerFullName, healSize, endTime, ...)
					--ChatFrame1:AddMessage(format("xperl_HealComm_DirectHealDelayed(%s, %s, %s, %s, %s)", tostring(event), tostring(healerFullName), tostring(healSize), tostring(endTime), tostring(...)))
					UpdateIncomingHeals(healerFullName, healSize, ...)
				end
				local function xperl_HealComm_HealModifierUpdate(event, unit, targetFullName, healModifier)
					--ChatFrame1:AddMessage(format("xperl_HealComm_HealModifierUpdate(%s, %s, %s, %s, %s)", tostring(event), tostring(healerFullName), tostring(healSize), tostring(endTime)))
					UpdateIncomingHeals(healerFullName, nil, targetFullName)
				end

				HealComm3.RegisterCallback("XPerlHealCommCallback", "HealComm_DirectHealStart", xperl_HealComm_DirectHealStart)
				HealComm3.RegisterCallback("XPerlHealCommCallback", "HealComm_DirectHealStop", xperl_HealComm_DirectHealStop)
				HealComm3.RegisterCallback("XPerlHealCommCallback", "HealComm_DirectHealDelayed", xperl_HealComm_DirectHealDelayed)
				HealComm3.RegisterCallback("XPerlHealCommCallback", "HealComm_HealModifierUpdate", xperl_HealComm_HealModifierUpdate)
			elseif (HealComm4) then
				local function UpdateIncomingHeals(...)
					for i = 1,select("#",...) do
						local guid = select(i, ...)
						local f

						if (guid) then
							if (XPerl_Raid_GetUnitFrameByGUID) then
								f = XPerl_Raid_GetUnitFrameByGUID(guid)
								if (f) then
									XPerl_Raid_UpdateHealth(f)
								end
							end

							if (XPerl_Party_GetUnitFrameByGUID) then
								f = XPerl_Party_GetUnitFrameByGUID(guid)
								if (f) then
									XPerl_Party_UpdateHealth(f)
								end
							end

							if (XPerl_Player_UpdateHealth and guid == playerGUID) then
								XPerl_Player_UpdateHealth(XPerl_Player)
							elseif (XPerl_Player_Pet_UpdateHealth and guid == petGUID) then
								XPerl_Player_Pet_UpdateHealth(XPerl_Player)
							elseif (XPerl_Party_Pet_GetUnitFrameByGUID) then
								f = XPerl_Party_Pet_GetUnitFrameByGUID(guid)
								if (f) then
									XPerl_Party_Pet_UpdateHealth(f)
								end
							end

							if (XPerl_Target_SetHealth and guid == targetGUID) then
								XPerl_Target_SetHealth(XPerl_Target)
							end
							if (XPerl_Target_SetHealth and XPerl_Focus and guid == focusGUID) then
								XPerl_Target_SetHealth(XPerl_Focus)
							end
							if (XPerl_Target_SetHealth and XPerl_TargetTarget and guid == targettargetGUID) then
								XPerl_Target_SetHealth(XPerl_TargetTarget)
							end
						end
					end
				end

				local function xperl_HealComm4_HealStarted(event, casterGUID, spellID, bitType, endTime, ...)
					UpdateIncomingHeals(...)
				end
				local function xperl_HealComm4_HealStopped(event, casterGUID, spellID, bitType, interrupted, ...)
					UpdateIncomingHeals(...)
				end
				local function xperl_HealComm4_HealDelayed(event, casterGUID, spellID, bitType, endTime, ...)
					UpdateIncomingHeals(...)
				end
				local function xperl_HealComm4_ModifierChanged(event, ...)
					UpdateIncomingHeals(...)
				end

				HealComm4.RegisterCallback("XPerlHealCommCallback", "HealComm_HealStarted", xperl_HealComm4_HealStarted)
				HealComm4.RegisterCallback("XPerlHealCommCallback", "HealComm_HealStopped", xperl_HealComm4_HealStopped)
				HealComm4.RegisterCallback("XPerlHealCommCallback", "HealComm_HealDelayed", xperl_HealComm4_HealDelayed)
				HealComm4.RegisterCallback("XPerlHealCommCallback", "HealComm_ModifierChanged", xperl_HealComm4_ModifierChanged)
			end
		end
	end
	-- End of HealComm/LibQuickHealth
	
	XPerl_Load_LQHLHC = nil
end

-- Threat Display
local function DrawHand(self, percent)
	local angle = 360 - (percent * 2.7 - 135)
	local ULx, ULy, LLx, LLy, URx, URy, LRx, LRy = rotate(angle)
	self.needle:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy)
end

local function DrawSlider(self, percent)
	local offset = (self:GetWidth() - 9) / 100 * percent
	self.needle:ClearAllPoints()
	self.needle:SetPoint("CENTER", self, "TOPLEFT", offset + 5, -2)

	local r, g, b
	if (percent <= 70) then
		r, g, b = 0, 1, 0
	else
		r, g, b = smoothColor(abs((percent - 100) / 30))
	end

	self.needle:SetVertexColor(r, g, b)
end

-- XPerl_ThreatDisplayOnLoad
function XPerl_ThreatDisplayOnLoad(self, mode)
	XPerl_SetChildMembers(self)
	self:SetFrameLevel(self:GetParent():GetFrameLevel() + 4)
	self.text:SetWidth(100)
	self.current, self.target = 0, 0
	self.mode = mode

	if (mode == "nameFrame") then
		self.Draw = DrawSlider
	else
		self.Draw = DrawHand
	end
	self:Draw(0)
end

-- threatOnUpdate
local function threatOnUpdate(self, elapsed)
	local diff = (self.target - self.current) * 0.2
	self.current = min(100, max(0, self.current + diff))
	if (abs(self.current - self.target) <= 0.01) then
		self.current = self.target
		self:SetScript("OnUpdate", nil)
	end

	self:Draw(self.current)
end

-- XPerl_Unit_ThreatStatus
function XPerl_Unit_ThreatStatus(self, relative, immediate)
	if (not self.partyid or not self.conf) then
		return
	end

	local mode = self.conf.threatMode or (self.conf.portrait and "portraitFrame" or "nameFrame")
	local t = self.threatFrames and self.threatFrames[mode]
	if (not self.conf.threat) then
		if (t) then
			t:Hide()
		end
		return
	end

	if (not t) then
		if (self.threatFrames) then
			for mode,frame in pairs(self.threatFrames) do
				frame:SetScript("OnUpdate", nil)
				frame.current, frame.target = 0, 0
				frame:Hide()
			end
		else
			self.threatFrames = {}
		end
		if (self[mode]) then		-- If desired parent frame exists
			t = CreateFrame("Frame", self:GetName().."Threat"..mode, self[mode], "XPerl_ThreatTemplate"..mode)
			t:SetAllPoints()
			self.threatFrames[mode] = t
		end

		self.threat = self.threatFrames[mode]
	end

	if (t) then
		local isTanking, state, scaledPercent, rawPercent, threatValue
		local one, two
		if (UnitAffectingCombat(self.partyid) or (relative and UnitAffectingCombat(relative))) then
			if (relative and UnitCanAttack(relative, self.partyid)) then
				one, two = relative, self.partyid
			else
				if (UnitExists("target") and UnitCanAttack(self.partyid, "target")) then
					one, two = self.partyid, "target"
				elseif (UnitCanAttack("player", self.partyid)) then
					one, two = "player", self.partyid
				elseif (UnitCanAttack(self.partyid, self.partyid.."target")) then
					one, two = self.partyid, self.partyid.."target"
				end
			end

			if (one) then
				-- scaledPercent is 0% - 100%, 100 means you pull agro
				-- rawPercent is before normalization so can go up to 110% or 130% before you pull agro
				isTanking, state, scaledPercent, rawPercent, threatValue = UnitDetailedThreatSituation(one, two)
			end
		end

		if (scaledPercent) then
			if (scaledPercent ~= t.target) then
				t.target = scaledPercent
				if (immediate) then
					t.current = scaledPercent
				end
				t.one = one
				t.two = two
				t:SetScript("OnUpdate", threatOnUpdate)
			end

			t.text:SetFormattedText("%d%%", scaledPercent)
			local r, g, b = smoothColor(scaledPercent)
			t.text:SetTextColor(r, g, b)

			t:Show()
			return
		end

		t:Hide()
	end
end
