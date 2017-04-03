--[[
Copyright (c) 2009, Hendrik "Nevcairiel" Leppkes < h.leppkes@gmail.com >
All rights reserved.

Initial implementation provided by yssaril
]]

local Mapster = LibStub("AceAddon-3.0"):GetAddon("Mapster")

local MODNAME= "Scale"
local Scale = Mapster:NewModule(MODNAME)

local LibWindow = LibStub("LibWindow-1.1")

local scaler, mousetracker
local SOS = { --Scaler Original State
	dist = 0,
	x = 0,
	y = 0,
	left = 0,
	top = 0,
	scale = 1,
}

local GetScaleDistance, OnUpdate

function Scale:OnInitialize()
	self:SetEnabledState(Mapster:GetModuleEnabled(MODNAME))
end

function Scale:OnEnable()
	if not scaler then
		scaler = WorldMapPositioningGuide:CreateTexture(nil, "OVERLAY")
		scaler:SetWidth(20)
		scaler:SetHeight(20)
		self:UpdateMapsize(Mapster.miniMap)
		scaler:SetTexture([[Interface\BUTTONS\UI-AutoCastableOverlay]])
		scaler:SetTexCoord(0.619, 0.760, 0.612, 0.762)
		scaler:SetDesaturated(true)

		mousetracker = CreateFrame("Frame", nil, WorldMapPositioningGuide)
		mousetracker:SetFrameStrata("TOOLTIP")
		mousetracker:SetAllPoints(scaler)
		mousetracker:EnableMouse(true)
		mousetracker:SetScript("OnEnter", function()
			scaler:SetDesaturated(false)
		end)
		mousetracker:SetScript("OnLeave", function()
			scaler:SetDesaturated(true)
		end)
		mousetracker:SetScript("OnMouseUp", function(self)
			LibWindow.SavePosition(WorldMapFrame)
			self:SetScript("OnUpdate", nil)
			self:SetAllPoints(scaler)
			Mapster:ShowBlobs()
		end)
		mousetracker:SetScript("OnMouseDown",function(self)
			Mapster:HideBlobs()
			SOS.left, SOS.top = WorldMapFrame:GetLeft(), WorldMapFrame:GetTop()
			SOS.scale = WorldMapFrame:GetScale()
			SOS.x, SOS.y = SOS.left, SOS.top-(UIParent:GetHeight()/SOS.scale)
			SOS.EFscale = WorldMapFrame:GetEffectiveScale()
			SOS.dist = GetScaleDistance()
			self:SetScript("OnUpdate", OnUpdate)
			self:SetAllPoints(UIParent)
		end)
		tinsert(Mapster.elementsToHide, scaler)
	end
	scaler:Show()
	mousetracker:Show()
end

function Scale:OnDisable()
	if scaler then
		scaler:Hide()
		moustracker:Hide()
	end
end

function GetScaleDistance() -- distance from cursor to TopLeft :)
	local left, top = SOS.left, SOS.top
	local scale = SOS.EFscale

	local x, y = GetCursorPosition()
	local x = x/scale - left
	local y = top - y/scale

	return sqrt(x*x+y*y)
end

function OnUpdate(self)
	local scale = GetScaleDistance()/SOS.dist*SOS.scale
	if scale < .2 then -- clamp min and max scale
		scale = .2
	elseif scale > 1.5 then 
		scale = 1.5
	end
	WorldMapFrame:SetScale(scale)

	local s = SOS.scale/WorldMapFrame:GetScale()
	local x = SOS.x*s
	local y = SOS.y*s
	WorldMapFrame:ClearAllPoints()
	WorldMapFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)
end

function Scale:UpdateMapsize(mini)
	if not scaler then return end
	-- map was minimized, fix display position
	if mini then
		if Mapster.bordersVisible then
			scaler:SetPoint("BOTTOMRIGHT", -23, -12)
		else
			scaler:SetPoint("BOTTOMRIGHT", -26, 16)
		end
	else
		if Mapster.bordersVisible then
			scaler:SetPoint("BOTTOMRIGHT", -4, 4)
		else
			-- TODO
		end
	end
end

function Scale:BorderVisibilityChanged()
	self:UpdateMapsize(Mapster.miniMap)
end
