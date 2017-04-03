if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_CombatText requires PitBull4")
end

-- CONSTANTS ----------------------------------------------------------------
local MAX_ALPHA = 0.6
local COMBATFEEDBACK_FADEINTIME = COMBATFEEDBACK_FADEINTIME
local COMBATFEEDBACK_HOLDTIME = COMBATFEEDBACK_HOLDTIME
local COMBATFEEDBACK_FADEOUTTIME = COMBATFEEDBACK_FADEOUTTIME

local COMBATFEEDBACK_FADEINTIME_AND_HOLDTIME = COMBATFEEDBACK_FADEINTIME + COMBATFEEDBACK_HOLDTIME
local COMBATFEEDBACK_FADEINTIME_AND_HOLDTIME_AND_FADEOUTTIME = COMBATFEEDBACK_FADEINTIME + COMBATFEEDBACK_HOLDTIME + COMBATFEEDBACK_FADEOUTTIME

local CRITICAL_HARM_SIZE_MODIFIER = 1.5
local CRITICAL_HELP_SIZE_MODIFIER = 1.3
local BLOCK_SIZE_MODIFIER = 0.75

local EXAMPLE_TEXT = "123"
-----------------------------------------------------------------------------

local L = PitBull4.L

local PitBull4_CombatText = PitBull4:NewModule("CombatText", "AceEvent-3.0")

PitBull4_CombatText:SetModuleType("custom_text")
PitBull4_CombatText:SetName(L["Combat text"])
PitBull4_CombatText:SetDescription(L["Show information like damage taken, healing taken, resists, etc. on the unit frame."])
PitBull4_CombatText:SetDefaults({
	attach_to = "root",
	location = "in_center",
	position = 1,
	size = 1.5,
})

local timerFrame = CreateFrame("Frame")
timerFrame:Hide()
timerFrame:SetScript("OnUpdate", function()
	PitBull4_CombatText:UpdateAlphas()
end)

function PitBull4_CombatText:OnEnable()
	self:RegisterEvent("UNIT_COMBAT")
end

function PitBull4_CombatText:OnDisable()
	timerFrame:Hide()
end

function PitBull4_CombatText:ClearFrame(frame)
	if not frame.CombatText then
		return false
	end
	
	frame.CombatText.size_modifier = nil
	frame.CombatText = frame.CombatText:Delete()
	return true
end

PitBull4_CombatText.OnHide = PitBull4_CombatText.ClearFrame

function PitBull4_CombatText:UpdateFrame(frame)
	local font_string = frame.CombatText
	local created = not font_string
	if created then
		font_string = PitBull4.Controls.MakeFontString(frame.overlay, "OVERLAY")
		frame.CombatText = font_string
		font_string:SetShadowColor(0, 0, 0, 1)
		font_string:SetShadowOffset(0.8, -0.8)
		font_string:SetNonSpaceWrap(false)
	end
	
	if not font_string.size_modifier then
		font_string.size_modifier = 1
	end
	local font, size = self:GetFont(frame)
	font_string:SetFont(font, size * font_string.size_modifier, "OUTLINE")
	
	if frame.force_show and not frame.guid then
		font_string:SetText(EXAMPLE_TEXT)
	elseif font_string:GetText() == EXAMPLE_TEXT then
		font_string:SetText("")
	end
	
	return created
end

local frame_to_time = {}

function PitBull4_CombatText:UNIT_COMBAT(_, unit, event, flags, amount, type)
	for frame in PitBull4:IterateFramesForUnitID(unit) do
		local font_string = frame.CombatText
		if font_string then
			local text = ""
			local r, g, b = 1, 1, 1
			local size_modifier = 1
			if event == "IMMUNE" then
				size_modifier = BLOCK_SIZE_MODIFIER
				text = CombatFeedbackText["IMMUNE"]
			elseif event == "WOUND" then
				if amount ~= 0 then
					if flags == "CRITICAL" or flags == "CRUSHING" then
						size_modifier = CRITICAL_HARM_SIZE_MODIFIER
					elseif flags == "GLANCING" then
						size_modifier = BLOCK_SIZE_MODIFIER
					end
					
					if UnitInParty(unit) or UnitInRaid(unit) then
						r, g, b = 1, 0, 0
					elseif type > 0 then
						r, g, b = 1, 1, 0
					end
					
					text = tostring(-amount)
				else
					if flags == "ABSORB" or flags == "BLOCK" or flags == "RESIST" then
						size_modifier = BLOCK_SIZE_MODIFIER
					end
					text = CombatFeedbackText[flags]
				end
			elseif event == "BLOCK" then
				size_modifier = BLOCK_SIZE_MODIFIER
				text = CombatFeedbackText[event]
			elseif event == "HEAL" then
				text = ("%+d"):format(amount)
				r, g, b = 0, 1, 0
				if flags == "CRITICAL" then
					size_modifier = CRITICAL_HELP_SIZE_MODIFIER
				end
			elseif event == "ENERGIZE" then
				text = tostring(amount)
				r, g, b = 0.41, 0.8, 0.94
				if flags == "CRITICAL" then
					size_modifier = CRITICAL_HELP_SIZE_MODIFIER
				end
			else
				text = CombatFeedbackText[event]
			end
			
			font_string:SetText(text)
			font_string.size_modifier = size_modifier
			local font, size = self:GetFont(frame)
			font_string:SetFont(font, size * size_modifier, "OUTLINE")
			font_string:SetTextColor(r, g, b)
			font_string:SetAlpha(0)
			
			frame_to_time[frame] = GetTime()
			timerFrame:Show()
		end
	end
end

function PitBull4_CombatText:UpdateAlphas()
	local now = GetTime()
	
	for frame, time in pairs(frame_to_time) do
		local font_string = frame.CombatText
		if not font_string then
			frame_to_time[frame] = nil
		else
			local delta = now - time
			
			if delta < COMBATFEEDBACK_FADEINTIME then
				font_string:SetAlpha(MAX_ALPHA * delta / COMBATFEEDBACK_FADEINTIME)
			elseif delta < COMBATFEEDBACK_FADEINTIME_AND_HOLDTIME then
				font_string:SetAlpha(MAX_ALPHA)
			elseif delta < COMBATFEEDBACK_FADEINTIME_AND_HOLDTIME_AND_FADEOUTTIME then
				font_string:SetAlpha(MAX_ALPHA * (1 - (delta - COMBATFEEDBACK_FADEINTIME_AND_HOLDTIME) / COMBATFEEDBACK_FADEOUTTIME))
			else
				font_string:SetAlpha(0)
				frame_to_time[frame] = nil
			end
		end
	end
	if not next(frame_to_time) then
		timerFrame:Hide()
	end
end
