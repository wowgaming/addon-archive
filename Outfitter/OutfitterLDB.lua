Outfitter.LDB = {}

function Outfitter.LDB:Initialize()
	self.LDB = LibStub("LibDataBroker-1.1", true)
	self.DataObj = self.LDB:NewDataObject(Outfitter.cTitle,
	{
		type = "data source",
		icon = "Interface\\AddOns\\Outfitter\\Textures\\Icon",
		text = "Outfitter",
		OnClick = function(pFrame, pButton) self:OnClick(pFrame, pButton) end
	})
	
	self.Menu = CreateFrame("Frame", "OutfitterLDBMenu", UIParent)
	self.Menu:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 100, -100)
	self.Menu:SetWidth(100)
	self.Menu:SetHeight(20)
	Outfitter.MinimapDropDown_OnLoad(self.Menu)
	self.Menu.ChangedValueFunc = Outfitter.MinimapButton_ItemSelected
	
	Outfitter:RegisterOutfitEvent("WEAR_OUTFIT", function (...) self:OutfitEvent(...) end)
	Outfitter:RegisterOutfitEvent("UNWEAR_OUTFIT", function (...) self:OutfitEvent(...) end)
	Outfitter:RegisterOutfitEvent("OUTFITTER_INIT", function (...) self:OutfitEvent(...) end)
end

function Outfitter.LDB:OnClick(pFrame, pButton)
	if pButton == "LeftButton" then
		ToggleDropDownMenu(nil, nil, self.Menu, "cursor")
		
		-- Hack to force the menu to position correctly.  UIDropDownMenu code
		-- keeps thinking that it's off the screen and trying to reposition
		-- it, which it does very poorly
		
		-- Outfitter.MinimapDropDown_AdjustScreenPosition(self.Menu)
		
		PlaySound("igMainMenuOptionCheckBoxOn")
	else
		Outfitter:ToggleUI(true)
	end
end

function Outfitter.LDB:OutfitEvent(pEvent, pOutfitName, pOutfit)
	local vOutfitName, vOutfit = Outfitter:GetCurrentOutfitInfo()
	
	if vOutfit then
		self.DataObj.text = vOutfitName
		self.DataObj.icon = Outfitter.OutfitBar:GetOutfitTexture(vOutfit)
	else
		self.DataObj.text = Outfitter.cTitle
		self.DataObj.icon = "Interface\\AddOns\\Outfitter\\Textures\\Icon"
	end
end

Outfitter.LDB:Initialize()
