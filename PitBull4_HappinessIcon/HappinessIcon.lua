if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

if select(2, UnitClass("player")) ~= "HUNTER" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_HappinessIcon requires PitBull4")
end

local L = PitBull4.L

local PitBull4_HappinessIcon = PitBull4:NewModule("HappinessIcon", "AceEvent-3.0")

PitBull4_HappinessIcon:SetModuleType("indicator")
PitBull4_HappinessIcon:SetName(L["Happiness icon"])
PitBull4_HappinessIcon:SetDescription(L["Show an icon on the pet frame to indicate its happiness."])
PitBull4_HappinessIcon:SetDefaults({
	attach_to = "root",
	location = "edge_bottom_right",
	position = 1,
	size = 1.2,
	tooltip = true,
})

function PitBull4_HappinessIcon:OnEnable()
	self:RegisterEvent("UNIT_HAPPINESS")
end

function PitBull4_HappinessIcon:GetTexture(frame)
	if frame.unit ~= "pet" then
		return nil
	end
	
	local happiness = GetPetHappiness()
	if not happiness then
		return nil
	end
	
	return [[Interface\PetPaperDollFrame\UI-PetHappiness]]
end

function PitBull4_HappinessIcon:GetExampleTexture(frame)
	if frame.unit ~= "pet" then
		return nil
	end
	
	return [[Interface\PetPaperDollFrame\UI-PetHappiness]]
end

local tex_coords = {
	-- unhappy
	{0.375, 0.5625, 0, 0.359375},
	
	-- content
	{0.1875, 0.375, 0, 0.359375},
	
	-- happy
	{0, 0.1875, 0, 0.359375},
}

function PitBull4_HappinessIcon:GetTexCoord(frame, texture)
	local happiness = GetPetHappiness()
	local tex_coord = tex_coords[happiness] or tex_coords[3]
	
	return tex_coord[1], tex_coord[2], tex_coord[3], tex_coord[4]
end
function PitBull4_HappinessIcon:GetExampleTexCoord()
	local tex_coord = tex_coords[3] -- happy
	return tex_coord[1], tex_coord[2], tex_coord[3], tex_coord[4]
end

function PitBull4_HappinessIcon:UNIT_HAPPINESS()
	self:UpdateForUnitID("pet")
end

function PitBull4_HappinessIcon:GetEnableMouse(frame)
	return self:GetLayoutDB(frame).tooltip
end

function PitBull4_HappinessIcon.OnEnter(icon, motion)
	local happiness, damage_percentage = GetPetHappiness()
	if happiness then
		GameTooltip:SetOwner(icon, "ANCHOR_RIGHT")
		GameTooltip:SetText(_G["PET_HAPPINESS"..happiness])
		if damage_percentage then
			GameTooltip:AddLine(format(PET_DAMAGE_PERCENTAGE, damage_percentage), "", 1, 1, 1)
		end
		GameTooltip:Show()
	end
end

function PitBull4_HappinessIcon.OnLeave(icon, motion)
	if GameTooltip:GetOwner() == icon then
		GameTooltip:Hide()
	end
end

PitBull4_HappinessIcon:SetLayoutOptionsFunction(function(self)
	return 'tooltip', {
		type = 'toggle',
		name = L["Tooltip"],
		desc = L["Show a tooltip on mouseover with the happiness and damage percent for the pet."],
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).tooltip
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).tooltip = value

			for frame in PitBull4:IterateFramesForUnitID("pet") do
				self:Clear(frame)
				self:Update(frame)
			end
		end
	}
end)
