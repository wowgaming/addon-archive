-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

CreateFrame("Frame", "XPerl_Voice")
local voice = XPerl_Voice

local conf
XPerl_RequestConfig(function(new) conf = new voice:RepositionAll() end, "$Revision: 176 $")

voice.frames = {}
voice.permenantUnits = {}

function voice:ClearCache()
	self.cachedUnits = setmetatable({}, {
		__index = function(self, unit)
			for frame in pairs(XPerl_Voice.frames) do
				--if (not frame.permenantVoiceID) then		-- Shouldn't ever happen
					if (frame.partyid == unit) then
						self[unit] = frame
						return self[unit]
					end
				--end
			end
		end
	})
end
voice:ClearCache()

-- if (IsVoiceChatEnabled()) then

-- voice:Create
function voice:Create(frame)
	frame.voiceButton = CreateFrame("Button", self:GetName().."Speaker", frame, "VoiceChatSpeakerTemplate")
	frame.voiceButton:EnableMouse(false)
	XPerl_SetChildMembers(frame.voiceButton)
	self:Position(frame)
end

-- voice:Position
function voice:Position(frame)
	if (frame.nameFrame and frame.nameFrame:IsShown()) then
		frame.voiceButton:SetParent(frame.nameFrame)
		frame.voiceButton:SetPoint("LEFT", frame.nameFrame, "LEFT", 5, 0)
		frame.voiceButton:SetFrameLevel(frame.nameFrame:GetFrameLevel() + 1)
	elseif (frame.portraitFrame and frame.portraitFrame:IsShown()) then
		frame.voiceButton:SetParent(frame.portraitFrame)
		frame.voiceButton:SetPoint("TOPLEFT", frame.portraitFrame, "TOPLEFT", 5, -5)
		frame.voiceButton:SetFrameLevel(frame.portraitFrame:GetFrameLevel() + 1)
	elseif (frame.statsFrame and frame.statsFrame:IsShown()) then
		frame.voiceButton:SetParent(frame.statsFrame)
		frame.voiceButton:SetPoint("CENTER", frame.statsFrame, "CENTER", 0, 0)
		frame.voiceButton:SetFrameLevel(frame.statsFrame:GetFrameLevel() + 1)
	else
		frame.voiceButton:SetParent(frame)
		frame.voiceButton:SetPoint("TOPLEFT", 5, -5)
		frame.voiceButton:SetFrameLevel(frame:GetFrameLevel() + 1)
	end

	frame.voiceButton:SetWidth(16)
	frame.voiceButton:SetHeight(16)
end

-- voice:RepositionAll
function voice:RepositionAll()
	for frame in pairs(self.frames) do
		self:Position(frame)
	end
end

-- voice:Register
function voice:Register(frame, variableUnitID)
	self:Create(frame)
	self.frames[frame] = true

	if (not variableUnitID) then
		self.permenantUnits[frame.partyid] = frame
		frame.permenantVoiceID = true
	end

	self:UpdateVoice(frame)
end

-- voice:Unregister
function voice:Unregister(frame)
	self.frames[frame] = nil
end

-- voice:OnEvent(event, a, b, c)
function voice:OnEvent(event, a, b, c)
--XPerl_ShowMessage("voice")
	self[event](self, a, b, c)
end

-- voice:Updatevoice
function voice:UpdateVoice(frame, onoff)
	if (IsVoiceChatEnabled()) then
		if (onoff == nil) then
			if (frame.partyid and GetVoiceStatus(frame.partyid)) then
				onoff = UnitIsTalking(frame.partyid)
			end
		end
	else
		onoff = nil
	end

	if (onoff) then
		frame.voiceButton.On:Show()
		frame.voiceButton.Flash:Hide()
		XPerl_FrameFlash(frame.voiceButton.Flash)
	else
		frame.voiceButton.On:Hide()
		XPerl_FrameFlashStop(frame.voiceButton.Flash)
	end

	--local muted = frame.partyid and GetMuteStatus(frame.partyid)
	--if (muted) then
	--	frame.voiceButton.Muted:Show()
	--else
	--	frame.voiceButton.Muted:Hide()
	--end
end

-- voice:UpdateAllVoice
function voice:UpdateAllVoice()
	for frame in pairs(self.frames) do
		self:UpdateVoice(frame)
	end
end

-- VOICE_STATUS_UPDATE
function voice:VOICE_STATUS_UPDATE(a, b, c)
	self:UpdateAllVoice()
end

-- MUTELIST_UPDATE
function voice:MUTELIST_UPDATE()
	self:UpdateAllVoice()
end

-- voice:UpdateByUnit
function voice:UpdateByUnit(unit, onoff)
	local frame = self.permenantUnits[unit] or self.cachedUnits[unit]
	if (frame) then
		self:UpdateVoice(frame, onoff)
	end
end

-- voice:VOICE_START
function voice:VOICE_START(unit)
	self:UpdateByUnit(unit, true)
end

-- voice:VOICE_STOP
function voice:VOICE_STOP(unit)
	self:UpdateByUnit(unit, false)
end

-- voice:RAID_ROSTER_UPDATE
function voice:RAID_ROSTER_UPDATE()
	self:ClearCache()
end

-- voice:PARTY_MEMBERS_CHANGED
function voice:PARTY_MEMBERS_CHANGED()
	self:ClearCache()
end

voice:RegisterEvent("VOICE_STATUS_UPDATE")
voice:RegisterEvent("MUTELIST_UPDATE")
voice:RegisterEvent("VOICE_START")
voice:RegisterEvent("VOICE_STOP")
voice:RegisterEvent("PARTY_MEMBERS_CHANGED")
voice:RegisterEvent("RAID_ROSTER_UPDATE")
voice:SetScript("OnEvent", voice.OnEvent)
