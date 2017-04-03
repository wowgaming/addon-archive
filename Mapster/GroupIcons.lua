--[[
Copyright (c) 2009, Hendrik "Nevcairiel" Leppkes < h.leppkes@gmail.com >
All rights reserved.
]]

local Mapster = LibStub("AceAddon-3.0"):GetAddon("Mapster")
local L = LibStub("AceLocale-3.0"):GetLocale("Mapster")

local MODNAME = "GroupIcons"
local GroupIcons = Mapster:NewModule(MODNAME, "AceEvent-3.0", "AceHook-3.0")

local fmt = string.format
local sub = string.sub
local find = string.find

local _G = _G

local RAID_CLASS_COLORS = RAID_CLASS_COLORS

local UnitClass = UnitClass
local GetRaidRosterInfo = GetRaidRosterInfo
local UnitAffectingCombat = UnitAffectingCombat
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local MapUnit_IsInactive = MapUnit_IsInactive

--Artwork taken from Cartographer
local path = "Interface\\AddOns\\Mapster\\Artwork\\"

local FixUnit, FixWorldMapUnits, FixBattlefieldUnits, OnUpdate, UpdateUnitIcon

local options
local function getOptions()
	if not options then
		options = {
			order = 20,
			type = "group",
			name = L["Group Icons"],
			arg = MODNAME,
			args = {
				intro = {
					order = 1,
					type = "description",
					name = L["The Group Icons module converts the player icons on the World Map and the Zone/Battlefield map to more meaningful icons, showing their class and (in raids) their sub-group."],
				},
				enabled = {
					order = 2,
					type = "toggle",
					name = L["Enable Group Icons"],
					get = function() return Mapster:GetModuleEnabled(MODNAME) end,
					set = function(info, value) Mapster:SetModuleEnabled(MODNAME, value) end,
				},
			}
		}
	end

	return options
end

function GroupIcons:OnInitialize()
	self:SetEnabledState(Mapster:GetModuleEnabled(MODNAME))
	Mapster:RegisterModuleOptions(MODNAME, getOptions, L["Group Icons"])
end

function GroupIcons:OnEnable()
	-- Support for !Class Colors
	if CUSTOM_CLASS_COLORS then
		RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS
	end

	if not IsAddOnLoaded("Blizzard_BattlefieldMinimap") then
		self:RegisterEvent("ADDON_LOADED", function(event, addon)
			if addon == "Blizzard_BattlefieldMinimap" then
				GroupIcons:UnregisterEvent("ADDON_LOADED")
				FixBattlefieldUnits(true)
				self:UnregisterEvent("ADDON_LOADED")
			end
		end)
	else
		FixBattlefieldUnits(true)
	end
	FixWorldMapUnits(true)
	self:RawHook("WorldMapUnit_Update", true)
end

function GroupIcons:OnDisable()
	FixWorldMapUnits(false)
	FixBattlefieldUnits(false)
end

function FixUnit(unit, state, isNormal)
	local frame = _G[unit]
	local icon = frame.icon
	if state then
		frame.elapsed = 0.5
		frame:SetScript("OnUpdate", OnUpdate)
		frame:SetScript("OnEvent", nil)
		if isNormal then
			icon:SetTexture(path .. "Normal")
		end
	else
		frame.elapsed = nil
		frame:SetScript("OnUpdate", nil)
		frame:SetScript("OnEvent", WorldMapUnit_OnEvent)
		icon:SetVertexColor(1, 1, 1)
		icon:SetTexture("Interface\\WorldMap\\WorldMapPartyIcon")
	end
end

function FixWorldMapUnits(state)
	for i = 1, 4 do
		FixUnit(fmt("WorldMapParty%d", i), state, true)
	end
	for i = 1,40 do
		FixUnit(fmt("WorldMapRaid%d", i), state)
	end
end

function FixBattlefieldUnits(state)
	if BattlefieldMinimap then
		for i = 1, 4 do
			FixUnit(fmt("BattlefieldMinimapParty%d", i), state, true)
		end
		for i = 1, 40 do
			FixUnit(fmt("BattlefieldMinimapRaid%d", i), state)
		end
	end
end

function OnUpdate(self, elapsed)
	self.elapsed = self.elapsed - elapsed
	if self.elapsed <= 0 then
		self.elapsed = 0.5
		UpdateUnitIcon(self.icon, self.unit)
	end
end

local grouptex = path .. "Group%d"
function UpdateUnitIcon(tex, unit)
	-- sanity check
	if not (tex and unit) then return end

	-- grab the class filename
	local _, fileName = UnitClass(unit)
	if not fileName then return end

	-- handle raid units, and set the correct subgroup texture
	if find(unit, "raid", 1, true) then
		local _, _, subgroup = GetRaidRosterInfo(sub(unit, 5))
		if not subgroup then return end
		tex:SetTexture(fmt(grouptex, subgroup))
	end

	-- color the texture
	-- either by flash color
	local t = RAID_CLASS_COLORS[fileName]
	if (GetTime() % 1 < 0.5) then
		if UnitAffectingCombat(unit) then
			-- red flash for units in combat
			tex:SetVertexColor(0.8, 0, 0)
		elseif UnitIsDeadOrGhost(unit) then
			-- dark grey flash for dead units
			tex:SetVertexColor(0.2, 0.2, 0.2)
		elseif PlayerIsPVPInactive(unit) then
			tex:SetVertexColor(0.5, 0.2, 0.8)
		end
	-- or class color
	elseif t then
		tex:SetVertexColor(t.r, t.g, t.b)
	else --fallback grey, you never know what happens
		tex:SetVertexColor(0.8, 0.8, 0.8)
	end
end

function GroupIcons:WorldMapUnit_Update(unitFrame)
	UpdateUnitIcon(unitFrame.icon, unitFrame.unit)
end
