if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_VoiceIcon requires PitBull4")
end

-- CONSTANTS ----------------------------------------------------------------

-- how long a full flash iteration takes, fading in and fading out
local FLASH_TIME = 0.7

-- how long either fading in or fading out takes
local HALF_FLASH_TIME = FLASH_TIME / 2

local INVERSE_HALF_FLASH_TIME = 1 / HALF_FLASH_TIME
-----------------------------------------------------------------------------

local L = PitBull4.L

local PitBull4_VoiceIcon = PitBull4:NewModule("VoiceIcon", "AceEvent-3.0")

PitBull4_VoiceIcon:SetModuleType("indicator")
PitBull4_VoiceIcon:SetName(L["Voice icon"])
PitBull4_VoiceIcon:SetDescription(L["Show an icon based on whether or not the unit's voice status."])
PitBull4_VoiceIcon:SetDefaults({
	attach_to = "root",
	location = "edge_top_right",
	position = 1,
})

local timerFrame = CreateFrame("Frame")
timerFrame:Hide()

function PitBull4_VoiceIcon:OnEnable()
	timerFrame:Show()
	self:RegisterEvent("VOICE_START")
	self:RegisterEvent("VOICE_STOP")
end

function PitBull4_VoiceIcon:OnDisable()
	timerFrame:Hide()
end

local guids_to_update = {}
timerFrame:SetScript("OnUpdate", function(self)
	for guid in pairs(guids_to_update) do
		guids_to_update[guid] = nil
		PitBull4_VoiceIcon:UpdateForGUID(guid)
	end
end)

function PitBull4_VoiceIcon:VOICE_START(event, unit)
	guids_to_update[UnitGUID(unit)] = true
end

PitBull4_VoiceIcon.VOICE_STOP = PitBull4_VoiceIcon.VOICE_START

function PitBull4_VoiceIcon:ClearFrame(frame)
	if not frame.VoiceIcon then
		return false
	end
	
	local icon = frame.VoiceIcon
	icon:SetScript("OnUpdate", nil)
	icon.elapsed = nil
	
	icon.base = icon.base:Delete()
	icon.noise = icon.noise:Delete()
	
	frame.VoiceIcon = icon:Delete()
	return true
end

local function icon_OnUpdate(self, elapsed)
	elapsed = self.elapsed + elapsed
	self.elapsed = elapsed
	
	local alpha = (elapsed % FLASH_TIME) * INVERSE_HALF_FLASH_TIME
	if alpha > 1 then
		alpha = 2 - alpha
	end
	self.noise:SetAlpha(alpha)
end

function PitBull4_VoiceIcon:UpdateFrame(frame)
	if not UnitIsTalking(frame.unit) and not frame.force_show then
		return self:ClearFrame(frame)
	end

	local icon = frame.VoiceIcon
	if icon then
		icon:Show()
		return false
	end
	
	icon = PitBull4.Controls.MakeFrame(frame)
	frame.VoiceIcon = icon
	icon:SetFrameLevel(frame:GetFrameLevel() + 3)
	icon:SetScript("OnUpdate", icon_OnUpdate)
	icon:SetWidth(15)
	icon:SetHeight(15)
	
	local base = PitBull4.Controls.MakeTexture(icon, "ARTWORK")
	icon.base = base
	base:SetTexture([[Interface\Common\VoiceChat-Speaker]])
	base:SetTexCoord(0.04, 0.96, 0.04, 0.96)
	base:SetAllPoints(icon)
	
	local noise = PitBull4.Controls.MakeTexture(icon, "ARTWORK")
	icon.noise = noise
	noise:SetTexture([[Interface\Common\VoiceChat-On]])
	noise:SetTexCoord(0.04, 0.96, 0.04, 0.96)
	noise:SetAllPoints(icon)
	
	icon.elapsed = 0
	
	icon:Show()
	
	return true
end
