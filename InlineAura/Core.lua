--[[
Copyright (C) 2009 Adirelle

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
--]]

local addonName, ns = ...

------------------------------------------------------------------------------
-- Our main frame
------------------------------------------------------------------------------

local InlineAura = CreateFrame('Frame', 'InlineAura')

------------------------------------------------------------------------------
-- Retrieve the localization table
------------------------------------------------------------------------------

local L = ns.L
InlineAura.L = L

------------------------------------------------------------------------------
-- Locals
------------------------------------------------------------------------------

local db

local unitAuras = {
	player = {},
	target = {},
	pet = {},
	focus = {}
}
local enabledUnits = {
	player = true,
	target = true,
}
local timerFrames = {}
local needUpdate = false
local configUpdated = false
local inVehicle = false

local buttons = {}
InlineAura.buttons = buttons

------------------------------------------------------------------------------
-- Libraries and helpers
------------------------------------------------------------------------------

local LSM = LibStub('LibSharedMedia-3.0')

local function dprint() end
--[===[@debug@
if tekDebug then
	local frame = tekDebug:GetFrame(addonName)
	dprint = function(...)
		return frame:AddMessage(string.join(", ", tostringall(...)):gsub("([:=]), ", "%1"))
	end
end
--@end-debug@]===]
InlineAura.dprint = dprint

------------------------------------------------------------------------------
-- Constants
------------------------------------------------------------------------------
local FONTMEDIA = LSM.MediaType.FONT

local FONT_NAME = LSM:GetDefault(FONTMEDIA)
local FONT_FLAGS = "OUTLINE"
local FONT_SIZE_SMALL = 13
local FONT_SIZE_LARGE = 20

local DEFAULT_OPTIONS = {
	profile = {
		onlyMyBuffs = true,
		onlyMyDebuffs = true,
		hideCountdown = false,
		hideStack = false,
		showStackAtTop = false,
		preciseCountdown = false,
		decimalCountdownThreshold = 10,
		singleTextPosition = 'BOTTOM',
		twoTextFirstPosition = 'BOTTOMLEFT',
		twoTextSecondPosition = 'BOTTOMRIGHT',
		fontName = FONT_NAME,
		smallFontSize     = FONT_SIZE_SMALL,
		largeFontSize     = FONT_SIZE_LARGE,
		colorBuffMine     = { 0.0, 1.0, 0.0, 1.0 },
		colorBuffOthers   = { 0.0, 1.0, 1.0, 1.0 },
		colorDebuffMine   = { 1.0, 0.0, 0.0, 1.0 },
		colorDebuffOthers = { 1.0, 1.0, 0.0, 1.0 },
		colorCountdown    = { 1.0, 1.0, 1.0, 1.0 },
		colorStack        = { 1.0, 1.0, 0.0, 1.0 },
		colorAlternate    = { 1.0, 0.0, 1.0, 1.0 },
		spells = {
			['**'] = {
				disabled = false,
				auraType = 'buff',
				unitsToScan = {
					target = true,
					player = true,
					['*'] = false,
				}
			},
		},
	},
}
InlineAura.DEFAULT_OPTIONS = DEFAULT_OPTIONS

-- Events only needed if the unit is enabled
local UNIT_EVENTS = {
	pet = 'UNIT_PET',
	focus = 'PLAYER_FOCUS_CHANGED',
}

local UNIT_SCAN_ORDER = { 'focus', 'target', 'pet', 'player' }
local DEFAULT_UNITS_TO_SCAN = { target = true, player = true }

------------------------------------------------------------------------------
-- Table recycling stub
------------------------------------------------------------------------------

local new, del
do
	local heap = setmetatable({}, {__mode='k'})
	function new()
		local t = next(heap)
		if t then
			heap[t] = nil
		else
			t = {}
		end
		return t
	end
	function del(t)
		if type(t) == "table" then
			wipe(t)
			heap[t] = true
		end
	end
end
InlineAura.new, InlineAura.del = new, del

------------------------------------------------------------------------------
-- Some Unit helpers
------------------------------------------------------------------------------

local UnitCanAssist, UnitCanAttack, UnitIsUnit = UnitCanAssist, UnitCanAttack, UnitIsUnit

local MY_UNITS = { player = true, pet = true, vehicle = true }

-- These two functions return nil when unit does not exist
local UnitIsBuffable = function(unit) return MY_UNITS[unit] or UnitCanAssist('player', unit) end
local UnitIsDebuffable = function(unit) return UnitCanAttack('player', unit) end

local origUnitAura = _G.UnitAura
local UnitAura = function(...)
	local name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable, shouldConsolidate, spellId = origUnitAura(...)
	return name, rank, icon, count, debuffType, duration, expirationTime, MY_UNITS[caster or "none"], isStealable, shouldConsolidate, spellId
end

------------------------------------------------------------------------------
-- Aura monitoring
------------------------------------------------------------------------------

local function WipeAuras(auras)
	if next(auras) then
		for name,aura in pairs(auras) do
			del(aura)
		end
		wipe(auras)
		needUpdate = true
	end
end

local auraScanners = {}
InlineAura.auraScanners = auraScanners

local UpdateUnitAuras
do
	local serial = 0
	local callbacks = setmetatable({}, {__mode='k'})
	function UpdateUnitAuras(unit, event)
		local auras, filter
		if inVehicle then
			unit = 'vehicle'
			auras = unitAuras.player
		else
			auras = unitAuras[unit]
		end
		if UnitIsBuffable(unit) then
			filter = 'HELPFUL'
		elseif UnitIsDebuffable(unit) then
			filter = 'HARMFUL'
		else
			return WipeAuras(auras)
		end
		serial = (serial + 1) % 1000000

		-- Avoid recreating callback on every call
		local now = GetTime()
		local callback = callbacks[auras]
		if not callback then
			callback = function(name, count, duration, expirationTime, isMine, spellId)
				if not count or count == 0 then
					count = nil
				end
				duration, expirationTime, isMine = tonumber(duration) or 0, tonumber(expirationTime) or 0, not not isMine
				if expirationTime > 0 and expirationTime < now then return end
				local data = auras[name]
				if not data then
					data = new()
					auras[name] = data
					needUpdate = true
					--[===[@debug@
					dprint('New aura', unit, name)
					--@end-debug@]===]
				elseif data.serial == serial and data.isMine and not isMine then
					-- Do not overwrite player's auras by others' auras when they have already seen during this scan
					data = nil
				elseif expirationTime ~= data.expirationTime or count ~= data.count or isMine ~= data.isMine then
					needUpdate = true
					--[===[@debug@
					dprint('Updating aura', unit, name)
					--@end-debug@]===]
				end
				if data then
					data.serial = serial
					data.count = count
					data.duration = duration
					data.expirationTime = expirationTime
					data.isMine = isMine
					if spellId then
						auras['#'..spellId] = data
					end
				end
			end
			callbacks[auras] = callback
		end

		-- Give every scanner a try
		for index, scan in ipairs(auraScanners) do
			local ok, msg = pcall(scan, callback, unit, filter)
			if not ok then
				geterrorhandler()(msg)
			end
		end

		-- Remove auras that have faded out
		for name, data in pairs(auras) do
			if not data.serial or data.serial ~= serial then
				auras[name] = del(auras[name])
				needUpdate = true
				--[===[@debug@
				dprint('Removing aura', unit, name)
				--@end-debug@]===]
			end
		end
	end
	InlineAura.UpdateUnitAuras = UpdateUnitAuras
end

-- This scanner scans all auras
tinsert(auraScanners, function(callback, unit, filter)
	for i = 1, 255 do
		local name, _, _, count, _, duration, expirationTime, isMine, _, _, spellId = UnitAura(unit, i, filter)
		if not name then
			break
		else
			callback(name, count, duration, expirationTime, isMine, spellId)
		end
	end
end)

-- This scanner handles tracking as player self buff
tinsert(auraScanners, function(callback, unit, filter)
	if unit ~= 'player' or filter ~= 'HELPFUL' then return end
	for i = 1, GetNumTrackingTypes() do
		local name, _, active, category = GetTrackingInfo(i)
		if active and category == 'spell' then
			callback(name, 0, nil, nil, true)
		end
	end
end)
function InlineAura:MINIMAP_UPDATE_TRACKING(event)
	UpdateUnitAuras("player", event)
end
InlineAura:RegisterEvent('MINIMAP_UPDATE_TRACKING')

-- Shaman totem support
if select(2, UnitClass("player")) == "SHAMAN" then
	tinsert(auraScanners, function(callback, unit, filter)
		if unit ~= 'player' or filter ~= 'HELPFUL' then return end
		for i = 1, MAX_TOTEMS do
			local haveTotem, name, startTime, duration = GetTotemInfo(i)
			if haveTotem and name and name ~= "" then
				name = name:gsub("%s[IV]-$", "")
				callback(name, 0, duration, startTime+duration, true)
			end
		end
	end)

	function InlineAura:PLAYER_TOTEM_UPDATE(event)
		UpdateUnitAuras("player", event)
	end
	InlineAura:RegisterEvent('PLAYER_TOTEM_UPDATE')
end

------------------------------------------------------------------------------
-- Countdown formatting
------------------------------------------------------------------------------

local floor, ceil = math.floor, math.ceil

local function GetPreciseCountdownText(timeLeft, threshold)
	if timeLeft >= 3600 then
		return L["%dh"]:format(floor(timeLeft/3600)), 1 + floor(timeLeft) % 3600
	elseif timeLeft >= 600 then
		return L["%dm"]:format(floor(timeLeft/60)), 1 + floor(timeLeft) % 60
	elseif timeLeft >= 60 then
		return ("%d:%02d"):format(floor(timeLeft/60), floor(timeLeft%60)), timeLeft % 1
	elseif timeLeft >= threshold then
		return tostring(floor(timeLeft)), timeLeft % 1
	elseif timeLeft >= 0 then
		return ("%.1f"):format(floor(timeLeft*10)/10), 0
	else
		return "0"
	end
end

local function GetImpreciseCountdownText(timeLeft)
	if timeLeft >= 3600 then
		return L["%dh"]:format(ceil(timeLeft/3600)), ceil(timeLeft) % 3600
	elseif timeLeft >= 60 then
		return L["%dm"]:format(ceil(timeLeft/60)), ceil(timeLeft) % 60
	elseif timeLeft > 0 then
		return tostring(floor(timeLeft)), timeLeft % 1
	else
		return "0"
	end
end

local function GetCountdownText(timeLeft, precise, threshold)
	return (precise and GetPreciseCountdownText or GetImpreciseCountdownText)(timeLeft, threshold)
end

------------------------------------------------------------------------------
-- Home-made bucketed timers
------------------------------------------------------------------------------
-- This is mainly a simplified version of AceTimer-3.0, credits goes to Ace3 authors

local ScheduleTimer, CancelTimer, FireTimers, TimerCallback
do
	local BUCKETS = 131
	local HZ = 20
	local buckets = {}
	local targets = {}
	for i = 1, BUCKETS do buckets[i] = {} end

	local lastIndex = floor(GetTime()*HZ)

	function ScheduleTimer(target, delay)
		assert(target and type(delay) == "number" and delay >= 0)
		if targets[target] then
			buckets[targets[target]][target] = nil
		end
		local when = GetTime() + delay
		local index = floor(when*HZ) + 1
		local bucketNum = 1 + (index % BUCKETS)
		buckets[bucketNum][target] = when
		targets[target] = bucketNum
	end

	function CancelTimer(target)
		assert(target)
		local bucketNum = targets[target]
		if bucketNum then
			buckets[bucketNum][target] = nil
			targets[target] = nil
		end
	end

	function ProcessTimers()
		local now = GetTime()
		local newIndex = floor(now*HZ)
		for index = lastIndex + 1, newIndex do
			local bucketNum = 1 + (index % BUCKETS)
			local bucket = buckets[bucketNum]
			for target, when in pairs(bucket) do
				if when <= now then
					bucket[target] = nil
					targets[target] = nil
					TimerCallback(target)
				end
			end
		end
		lastIndex = newIndex
	end
end

------------------------------------------------------------------------------
-- Timer frame handling
------------------------------------------------------------------------------

local TimerFrame_OnUpdate, TimerFrame_Skin, TimerFrame_Display, TimerFrame_UpdateCountdown

local function SetTextPosition(text, position)
	text:SetJustifyH(position:match('LEFT') or position:match('RIGHT') or 'MIDDLE')
	text:SetJustifyV(position:match('TOP') or position:match('BOTTOM') or 'CENTER')
end

function TimerFrame_UpdateTextLayout(self)
	local stackText, countdownText = self.stackText, self.countdownText
	if countdownText:IsShown() and stackText:IsShown() then
		SetTextPosition(countdownText, InlineAura.db.profile.twoTextFirstPosition)
		SetTextPosition(stackText, InlineAura.db.profile.twoTextSecondPosition)
	elseif countdownText:IsShown() then
		SetTextPosition(countdownText, InlineAura.db.profile.singleTextPosition)
	elseif stackText:IsShown() then
		SetTextPosition(stackText, InlineAura.db.profile.singleTextPosition)
	end
end

function TimerFrame_Skin(self)
	local font = LSM:Fetch(FONTMEDIA, db.profile.fontName)

	local countdownText = self.countdownText
	countdownText.fontName = font
	countdownText.baseFontSize = db.profile[InlineAura.bigCountdown and "largeFontSize" or "smallFontSize"]
	countdownText:SetFont(font, countdownText.baseFontSize, FONT_FLAGS)
	countdownText:SetTextColor(unpack(db.profile.colorCountdown))

	local stackText = self.stackText
	stackText:SetFont(font, db.profile.smallFontSize, FONT_FLAGS)
	stackText:SetTextColor(unpack(db.profile.colorStack))

	TimerFrame_UpdateTextLayout(self)
end

function TimerFrame_OnUpdate(self)
	TimerFrame_UpdateCountdown(self, GetTime())
end

-- Compat
TimerFrame_CancelTimer = CancelTimer
TimerCallback = TimerFrame_OnUpdate

function TimerFrame_UpdateCountdown(self, now)
	local timeLeft = self.expirationTime - now
	local displayTime, delay = GetCountdownText(timeLeft, db.profile.preciseCountdown, db.profile.decimalCountdownThreshold)
	self.countdownText:SetText(displayTime)
	if delay then
		ScheduleTimer(self, math.min(delay, timeLeft))
	end
end

function TimerFrame_Display(self, expirationTime, count, now, hideCountdown)
	self:Show()

	if count then
		local stackText = self.stackText
		stackText:SetText(count)
		stackText:Show()
	else
		self.stackText:Hide()
	end

	if not hideCountdown then
		local countdownText = self.countdownText
		self.expirationTime = expirationTime
		TimerFrame_UpdateCountdown(self, now)
		countdownText:Show()
		countdownText:SetFont(countdownText.fontName, countdownText.baseFontSize, FONT_FLAGS)
		local sizeRatio = countdownText:GetStringWidth() / (self:GetWidth()-4)
		if sizeRatio > 1 then
			countdownText:SetFont(countdownText.fontName, countdownText.baseFontSize / sizeRatio, FONT_FLAGS)
		end
	else
		TimerFrame_CancelTimer(self)
		self.countdownText:Hide()
	end

	TimerFrame_UpdateTextLayout(self)
end

local function CreateTimerFrame(button)
	local timer = CreateFrame("Frame", nil, button)
	local cooldown = _G[button:GetName()..'Cooldown']
	timer:SetFrameLevel(cooldown:GetFrameLevel() + 5)
	timer:SetAllPoints(cooldown)
	timer:SetToplevel(true)
	timer:Hide()
	timer:SetScript('OnHide', TimerFrame_CancelTimer)
	timerFrames[button] = timer

	local countdownText = timer:CreateFontString(nil, "OVERLAY")
	countdownText:SetAllPoints(timer)
	countdownText:Show()
	timer.countdownText = countdownText

	local stackText = timer:CreateFontString(nil, "OVERLAY")
	stackText:SetAllPoints(timer)
	timer.stackText = stackText

	TimerFrame_Skin(timer)

	return timer
end

------------------------------------------------------------------------------
-- Aura lookup
------------------------------------------------------------------------------

local function CheckAura(auras, name, onlyMine)
	local aura = auras[name]
	if aura and (aura.isMine or not onlyMine) then
		return aura
	end
end

local function LookupAura(auras, spell, aliases, auraType, onlyMine, ...)
	local aura = CheckAura(auras, spell, onlyMine)
	if not aura and aliases then
		for i, alias in ipairs(aliases) do
			aura = CheckAura(auras, alias, onlyMine)
			if aura then
				break
			end
		end
	end
	if aura then
		return aura, auraType, ...
	end
end

local function GetTristateValue(value, default)
	if value ~= nil then
		return value
	else
		return default
	end
end

local function GetAuraToDisplay(spell)
	local specific = rawget(db.profile.spells, spell) -- Bypass AceDB auto-creation
	if type(specific) == 'table' then
		if specific.disabled then
			return
		end
		local units = specific.unitsToScan or DEFAULT_UNITS_TO_SCAN
		local onlyMine, auraType, buffTest
		local hideStack = GetTristateValue(specific.hideStack, db.profile.hideStack)
		local hideCountdown = GetTristateValue(specific.hideCountdown, db.profile.hideCountdown)
		if specific.auraType == 'debuff' then
			onlyMine = GetTristateValue(specific.onlyMine, db.profile.onlyMyDebuffs)
			auraType = 'Debuff'
			buffTest = UnitIsDebuffable
		else
			onlyMine = GetTristateValue(specific.onlyMine, db.profile.onlyMyBuffs)
			auraType = 'Buff'
			buffTest = UnitIsBuffable
		end
		for i, unit in pairs(UNIT_SCAN_ORDER) do
			if units[unit] and buffTest(unit) then
				return LookupAura(unitAuras[unit], spell, specific.aliases, auraType, onlyMine, hideStack, hideCountdown, specific.alternateColor)
			end
		end
	else
		if UnitIsBuffable('target') then
			return LookupAura(unitAuras.target, spell, nil, 'Buff', db.profile.onlyMyBuffs, db.profile.hideStack, db.profile.hideCountdown)
		elseif UnitIsDebuffable('target') then
			local aura, auraType = LookupAura(unitAuras.target, spell, nil, 'Debuff', db.profile.onlyMyDebuffs, db.profile.hideStack, db.profile.hideCountdown)
			if aura then
				return aura, auraType, db.profile.hideStack
			end
		end
		return LookupAura(unitAuras.player, spell, nil, 'Buff', db.profile.onlyMyBuffs, db.profile.hideStack, db.profile.hideCountdown)
	end
end

------------------------------------------------------------------------------
-- Visual feedback
------------------------------------------------------------------------------

local function UpdateTimer(self, aura, hideStack, hideCountdown)
	if aura and aura.serial and not (hideCountdown and hideStack) then
		local now = GetTime()
		if aura.expirationTime and aura.expirationTime > now then
			local count = not hideStack and aura.count and aura.count > 0 and aura.count
			local frame = timerFrames[self] or CreateTimerFrame(self)
			TimerFrame_Display(frame, aura.expirationTime, count, now, hideCountdown)
		end
	elseif timerFrames[self] then
		timerFrames[self]:Hide()
	end
end

local function SetVertexColor(texture, r, g, b, a)
	texture:SetVertexColor(r, g, b, a)
end

local function UpdateHighlight(self, aura, color)
	local texture = self:GetCheckedTexture()
	if aura then
		SetVertexColor(texture, unpack(color))
		self:SetChecked(true)
	else
		local action = self.action
		texture:SetVertexColor(1, 1, 1)
		if action then
			self:SetChecked(IsCurrentAction(action) or IsAutoRepeatAction(action))
		end
	end
end

------------------------------------------------------------------------------
-- LibButtonFacade compatibility
------------------------------------------------------------------------------

local function LBF_SetVertexColor(texture, r, g, b, a)
	local R, G, B, A = texture:GetVertexColor()
	texture:SetVertexColor(r*R, g*G, b*B, a*(A or 1))
end

local function LBF_Callback()
	configUpdated = true
end

------------------------------------------------------------------------------
-- Button hooks
------------------------------------------------------------------------------

local function ActionButton_OnLoad_Hook(self)
	if not buttons[self] then
		buttons[self] = true
		needUpdate = true
	end
end

local function ActionButton_UpdateState_Hook(self)
	if not self:IsVisible() then return end
	local spell = self.actionName
	if spell and self.actionType == 'macro' then
		spell = GetMacroSpell(spell)
	end
	local aura, color, hideStack, hideCountdown
	if spell then
		local auraType
		aura, auraType, hideStack, hideCountdown, alternateColor = GetAuraToDisplay(spell)
		if aura then
			if alternateColor then
				color = db.profile.colorAlternate
			else
				color = db.profile['color'..auraType..(aura.isMine and 'Mine' or 'Others')]
			end 
		end
	end
	UpdateHighlight(self, aura, color)
	UpdateTimer(self, aura, hideStack, hideCountdown)
end

local function ActionButton_Update_Hook(self)
	local actionName, actionType
	if self.action then
		local arg1, arg2, arg3
		actionType, arg1, arg2, arg3 = GetActionInfo(ActionButton_GetPagedID(self))
		if actionType == 'spell' then
			if arg1 and arg2 and arg1 > 0 then
				actionName = GetSpellName(arg1, arg2)
			elseif arg3 then
				actionName = GetSpellInfo(arg3)
			end
		elseif actionType == 'item' then
			actionName = GetItemSpell(arg1)
		else
			actionName = arg1
		end
	end
	self.actionName, self.actionType = actionName, actionType
	ActionButton_UpdateState_Hook(self)
	buttons[self] = self:IsVisible() and actionName or nil
end

------------------------------------------------------------------------------
-- Button updates
------------------------------------------------------------------------------

local function IsUnitEnabled(unit, event)
	for name, spell in pairs(db.profile.spells) do
		if not spell.disabled and spell.unitsToScan and spell.unitsToScan[unit] then
			InlineAura:RegisterEvent(event)
			return true
		end
	end
	InlineAura:UnregisterEvent(event)
	WipeAuras(unitAuras[unit])
end

function InlineAura:OnUpdate()
	if configUpdated then
		-- Update event listening
		for unit, event in pairs(UNIT_EVENTS) do
			enabledUnits[unit] = IsUnitEnabled(unit, event)
		end
		-- Update all auras
		for unit in pairs(enabledUnits) do
			UpdateUnitAuras(unit)
		end
		-- Update timer skins
		for button, timerFrame in pairs(timerFrames) do
			TimerFrame_Skin(timerFrame)
		end
	end
	if needUpdate or configUpdated then
		-- Update buttons
		for button in pairs(buttons) do
			ActionButton_UpdateState_Hook(button)
		end
		needUpdate, configUpdated = false, false
	end
	ProcessTimers()
end

function InlineAura:RequireUpdate(config)
	configUpdated = config
	needUpdate = true
end

function InlineAura:RegisterButtons(prefix, count)
	for id = 1, count do
		local button = _G[prefix .. id]
		if button and not buttons[button] then
			buttons[button] = true
			needUpdate = true
		end
	end
end

------------------------------------------------------------------------------
-- Event handling
------------------------------------------------------------------------------

function InlineAura:UNIT_ENTERED_VEHICLE(event, unit)
	if unit == 'player' then
		inVehicle = (event == 'UNIT_ENTERED_VEHICLE')
		UpdateUnitAuras('player', event)
	end
end

InlineAura.UNIT_EXITED_VEHICLE = InlineAura.UNIT_ENTERED_VEHICLE

function InlineAura:UNIT_AURA(event, unit)
	if enabledUnits[unit] or (unit == 'vehicle' and inVehicle) then
		UpdateUnitAuras(unit, event)
	end
end

function InlineAura:UNIT_PET(event, unit)
	if unit == 'player' then
		UpdateUnitAuras('pet', event)
		needUpdate = true
	end
end

function InlineAura:PLAYER_ENTERING_WORLD(event)
	inVehicle = not not UnitControllingVehicle('player')
	for unit in pairs(enabledUnits) do
		UpdateUnitAuras(unit, event)
	end
end

function InlineAura:PLAYER_FOCUS_CHANGED(event)
	UpdateUnitAuras('focus', event)
	needUpdate = true
end

function InlineAura:PLAYER_TARGET_CHANGED(event)
	UpdateUnitAuras('target', event)
	needUpdate = true
end

function InlineAura:VARIABLES_LOADED()
	self.VARIABLES_LOADED = nil
	-- ButtonFacade support
	local LBF = LibStub('LibButtonFacade', true)
	local LBF_RegisterCallback = function() end
	if LBF then
		SetVertexColor = LBF_SetVertexColor
		LBF:RegisterSkinCallback("Blizzard", LBF_Callback)
	end
	-- Miscellanous addon support
	if Dominos then
		self:RegisterButtons("DominosActionButton", 72)
		hooksecurefunc(Dominos.ActionButton, "Skin", ActionButton_OnLoad_Hook)
		if LBF then
			LBF:RegisterSkinCallback("Dominos", LBF_Callback)
		end
	end
	if Bartender4 then
		self:RegisterButtons("BT4Button", 120)
		if LBF then
			LBF:RegisterSkinCallback("Bartender4", LBF_Callback)
		end
	end
	if OmniCC or CooldownCount then
		InlineAura.bigCountdown = false
	end

	-- Refresh everything
	self:RequireUpdate(true)

	-- Force a full refresh on first frame
	self:SetScript('OnUpdate', function(self, ...)
		for button in pairs(buttons) do
			ActionButton_Update_Hook(button)
		end
		self:SetScript('OnUpdate', self.OnUpdate)
		return self:OnUpdate(...)
	end)

	-- Scan unit in case of delayed loading
	if IsLoggedIn() then
		self:PLAYER_ENTERING_WORLD()
	end
end

function InlineAura:ADDON_LOADED(event, name)
	if name ~= addonName then return end
	self:UnregisterEvent('ADDON_LOADED')
	self.ADDON_LOADED = nil

	-- Saved variables setup
	db = LibStub('AceDB-3.0'):New("InlineAuraDB", DEFAULT_OPTIONS)
	db.RegisterCallback(self, 'OnProfileChanged', 'RequireUpdate')
	db.RegisterCallback(self, 'OnProfileCopied', 'RequireUpdate')
	db.RegisterCallback(self, 'OnProfileReset', 'RequireUpdate')
	self.db = db

	LibStub('LibDualSpec-1.0'):EnhanceDatabase(db, "Inline Aura")

	-- Setup
	self.bigCountdown = true

	-- Setup basic event listening up
	self:RegisterEvent('UNIT_AURA')
	self:RegisterEvent('PLAYER_TARGET_CHANGED')
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:RegisterEvent('UNIT_ENTERED_VEHICLE')
	self:RegisterEvent('UNIT_EXITED_VEHICLE')

	if IsLoggedIn() then
		self:VARIABLES_LOADED()
	else
		self:RegisterEvent('VARIABLES_LOADED')
	end

	-- standard buttons
	self:RegisterButtons("ActionButton", 12)
	self:RegisterButtons("BonusActionButton", 12)
	self:RegisterButtons("MultiBarRightButton", 12)
	self:RegisterButtons("MultiBarLeftButton", 12)
	self:RegisterButtons("MultiBarBottomRightButton", 12)
	self:RegisterButtons("MultiBarBottomLeftButton", 12)

	-- Hooks
	hooksecurefunc('ActionButton_OnLoad', ActionButton_OnLoad_Hook)
	hooksecurefunc('ActionButton_UpdateState', ActionButton_UpdateState_Hook)
	hooksecurefunc('ActionButton_Update', ActionButton_Update_Hook)
end

-- Event handler
InlineAura:SetScript('OnEvent', function(self, event, ...)
	if type(self[event]) == 'function' then
		local success, msg = pcall(self[event], self, event, ...)
		if not success then
			geterrorhandler()(msg)
		end
	--[===[@debug@
	else
		dprint('InlineAura: registered event has no handler: '..event)
	--@end-debug@]===]
	end
end)

-- Initialize on ADDON_LOADED
InlineAura:RegisterEvent('ADDON_LOADED')

------------------------------------------------------------------------------
-- Configuration GUI loader
------------------------------------------------------------------------------

local function LoadConfigGUI()
	LoadAddOn('InlineAura_Config')
end

-- Chat command line
SLASH_INLINEAURA1 = "/inlineaura"
function SlashCmdList.INLINEAURA()
	LoadConfigGUI()
	InterfaceOptionsFrame_OpenToCategory(L['Inline Aura'])
end

-- InterfaceOptionsFrame spy
CreateFrame("Frame", nil, InterfaceOptionsFrameAddOns):SetScript('OnShow', LoadConfigGUI)

