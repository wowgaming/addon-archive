local parent = SexyMap
local modName = "Ping"
local mod = SexyMap:NewModule(modName, "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("SexyMap")
local db

local pingFrame

local options = {
	type = "group",
	name = modName,
	disabled = function() return not db.showPing end,
	args = {
		show = {
			type = "toggle",
			order = 1,
			name = L["Show who pinged"],
			width = "full",
			get = function()
				return db.showPing
			end,
			set = function(info, v)
				db.showPing = v
			end,
			disabled = false,
		},
		showChat = {
			type = "toggle",
			order = 2,
			name = L["Show inside chat"],
			set = function(info, v)
				db.showAt = "chat"
			end,
			get = function(info)
				return db.showAt == "chat" and true or false
			end,
		},
		showMap = {
			type = "toggle",
			order = 3,
			name = L["Show on minimap"],
			set = function(info, v)
				db.showAt = "map"
			end,
			get = function(info)
				return db.showAt == "map" and true or false
			end,
		},
	}
}

local defaults = {
	profile = {
		showPing = true,
		showAt = "map"
	}
}
function mod:OnInitialize()
	self.db = parent.db:RegisterNamespace(modName, defaults)
	db = self.db.profile
	parent:RegisterModuleOptions(modName, options, modName)
	pingFrame = CreateFrame("Frame", "SexyMapPingFrame", MinimapPing)
	pingFrame:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		insets = {left = 2, top = 2, right = 2, bottom = 2},
		edgeSize = 12,
		tile = true
	})
	pingFrame:SetBackdropColor(0,0,0,0.8)
	pingFrame:SetBackdropBorderColor(0,0,0,0.6)
	pingFrame:SetHeight(20)
	pingFrame:SetWidth(100)
	pingFrame:SetPoint("TOP", MinimapPing, "BOTTOM", 0, 15)
	pingFrame:SetFrameStrata("HIGH")
	pingFrame.name = pingFrame:CreateFontString(nil, nil, "GameFontNormalSmall")
	pingFrame.name:SetAllPoints()
	pingFrame:Hide()
end

function mod:OnEnable()
	db = self.db.profile
	self:RegisterEvent("MINIMAP_PING")
end

-- MINIMAP_PING can fire twice at the same time, just a simple way of throttling it
local lastX, lastY
function mod:MINIMAP_PING(self, unit, x, y)
	if( db.showPing and lastX ~= x and lastY ~= y ) then
		lastX, lastY = x, y
		
		local color = RAID_CLASS_COLORS[select(2, UnitClass(unit))]
		if db.showAt == "chat" then
			DEFAULT_CHAT_FRAME:AddMessage(("Ping: |cFF%02x%02x%02x%s|r"):format(color.r * 255, color.g * 255, color.b * 255, UnitName(unit)))
			pingFrame:Hide()
		else
			pingFrame.name:SetFormattedText("|cFF%02x%02x%02x%s|r", color.r * 255, color.g * 255, color.b * 255, UnitName(unit))
			pingFrame:SetWidth(pingFrame.name:GetStringWidth() + 14)
			pingFrame:SetHeight(pingFrame.name:GetStringHeight() + 10)
			pingFrame:Show()
		end
	end
end
