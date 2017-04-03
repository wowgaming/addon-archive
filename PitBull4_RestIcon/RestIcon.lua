if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_RestIcon requires PitBull4")
end

local L = PitBull4.L

local PitBull4_RestIcon = PitBull4:NewModule("RestIcon", "AceEvent-3.0")

PitBull4_RestIcon:SetModuleType("indicator")
PitBull4_RestIcon:SetName(L["Rest icon"])
PitBull4_RestIcon:SetDescription(L["Show an icon on the unit frame when the unit is resting in an inn or city."])
PitBull4_RestIcon:SetDefaults({
	attach_to = "root",
	location = "edge_bottom_left",
	position = 1,
})

function PitBull4_RestIcon:OnEnable()
	self:RegisterEvent("PLAYER_UPDATE_RESTING")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
end

function PitBull4_RestIcon:GetTexture(frame)
	if frame.unit ~= "player" then
		return nil
	end
	
	if IsResting() then
		return [[Interface\CharacterFrame\UI-StateIcon]]
	else
		return nil
	end
end

function PitBull4_RestIcon:GetExampleTexture(frame)
	if frame.unit ~= "player" then
		return nil
	end
	
	return [[Interface\CharacterFrame\UI-StateIcon]]
end

function PitBull4_RestIcon:GetTexCoord(frame, texture)
	return 0.09, 0.43, 0.08, 0.42
end
PitBull4_RestIcon.GetExampleTexCoord = PitBull4_RestIcon.GetTexCoord

function PitBull4_RestIcon:PLAYER_UPDATE_RESTING()
	self:UpdateForUnitID("player")
end

PitBull4_RestIcon.PLAYER_ENTERING_WORLD = PitBull4_RestIcon.PLAYER_UPDATE_RESTING