--[[--------------------------------------------------------------------
	GridStatusVoiceComm.lua
	GridStatus module for showing who's speaking over the in-game voice comm system.
	Based on code from Halgrimm
	http://www.wowace.com/forums/index.php?topic=2525.msg143457#msg143457
----------------------------------------------------------------------]]

local _, ns = ...
local L = ns.L

local GridStatusVoiceComm = Grid:GetModule("GridStatus"):NewModule("GridStatusVoiceComm")
GridStatusVoiceComm.menuName = L["Voice Chat"]

GridStatusVoiceComm.defaultDB = {
	debug = false,
	alert_voice = {
		text =  L["Talking"],
		enable = false,
		color = { r = 0.5, g = 1.0, b = 0.5, a = 1.0 },
		priority = 50,
		range = false,
	},
}

GridStatusVoiceComm.options = false

function GridStatusVoiceComm:OnInitialize()
	self.super.OnInitialize(self)
	self:RegisterStatus("alert_voice", L["Voice Chat"], nil, true)
end

function GridStatusVoiceComm:OnStatusEnable(status)
	if status == "alert_voice" then
		self:RegisterEvent("VOICE_START")
		self:RegisterEvent("VOICE_STOP")
	end
end

function GridStatusVoiceComm:OnStatusDisable(status)
	if stats == "alert_voice" then
		self:UnregisterEvent("VOICE_START")
		self:UnregisterEvent("VOICE_STOP")
		self.core:SendStatusLostAllUnits("alert_voice")
	end
end

function GridStatusVoiceComm:VOICE_START(unitid)
	local settings = self.db.profile.alert_voice

	self.core:SendStatusGained(
		UnitGUID(unitid),
		"alert_voice",
		settings.priority,
		(settings.range and 40),
		settings.color,
		settings.text,
		nil,
		nil,
		settings.icon)
end

function GridStatusVoiceComm:VOICE_STOP(unitid)
	self.core:SendStatusLost(UnitGUID(unitid), "alert_voice")
end
