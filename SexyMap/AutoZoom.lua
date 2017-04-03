local parent = SexyMap
local modName = "AutoZoom"
local mod = SexyMap:NewModule(modName, "AceTimer-3.0", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("SexyMap")
local db

local options = {
	type = "group",
	name = modName,
	args = {
		show = {
			type = "range",
			name = L["Autozoom out after..."],
			desc = L["Number of seconds to autozoom out after. Set to 0 to turn off Autozoom."],
			min = 0,
			width = "double",
			max = 60,
			step = 1,
			bigStep = 1,
			get = function()
				return db.autoZoom
			end,
			set = function(info, v)
				db.autoZoom = v
			end
		}
	}	
}

local defaults = {
	profile = { autoZoom = 5 }
}
function mod:OnInitialize()
	self.db = parent.db:RegisterNamespace(modName, defaults)
	db = self.db.profile
	parent:RegisterModuleOptions(modName, options, modName)
end

function mod:OnEnable()
	db = self.db.profile
	self:SecureHook(Minimap, "SetZoom")
end

function mod:SetZoom()
	if db.autoZoom > 0 then
		self:CancelTimer(self.timer, true)
		self.timer = self:ScheduleTimer("ZoomOut", db.autoZoom)
	end
end

function mod:ZoomOut()
	if Minimap:GetZoom() > 0 then
		Minimap:SetZoom(0)
		MinimapZoomOut:Disable()
		MinimapZoomIn:Enable()
	end
end
