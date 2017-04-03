----------------------------------------
Outfitter.OutfitBar = {}
----------------------------------------

Outfitter.OutfitBar.UniqueNameIndex = 1

Outfitter.OutfitBar.cBlizzardIconPath = "Interface\\Icons\\"
Outfitter.OutfitBar.cBlizzardIconPathLength = string.len(Outfitter.OutfitBar.cBlizzardIconPath)
Outfitter.OutfitBar.cWildcardIconName = "INV_Misc_QuestionMark"
Outfitter.OutfitBar.cWildcardIcon = Outfitter.OutfitBar.cBlizzardIconPath..Outfitter.OutfitBar.cWildcardIconName

Outfitter.OutfitBar.cDefaultScriptIcons =
{
	ArgentDawn = "INV_Jewelry_Talisman_07",
	Riding = "Ability_Mount_RidingHorse",
	Fishing = "Trade_Fishing",
	Swimming = "Spell_Shadow_DemonBreath",
	City = "INV_Shirt_Black_01",
	Battleground = "Ability_Hunter_RapidKilling",
	AB = "Ability_Hunter_RapidKilling",
	AV = "Ability_Hunter_RapidKilling",
	WSG = "Ability_Hunter_RapidKilling",
	EotS = "Ability_Hunter_RapidKilling",
	Arena = "Ability_Hunter_RapidKilling",
	Battle = "Ability_Warrior_OffensiveStance",
	Defensive = "Ability_Warrior_DefensiveStance",
	Berserker = "Ability_Racial_Avatar",
	Bear = "Ability_Racial_BearForm",
	Cat = "Ability_Druid_CatForm",
	Aquatic = "Ability_Druid_AquaticForm",
	Flight = "Ability_Druid_FlightForm",
	Travel = "Ability_Druid_TravelForm",
	Moonkin = "Ability_Druid_TreeOfLife",
	Tree = "Ability_Druid_TreeOfLife",
	Prowl = "Ability_Stealth",
	Stealth = "Ability_Stealth",
	Shadowform = "Spell_Shadow_Shadowform",
	GhostWolf = "Spell_Nature_SpiritWolf",
	Monkey = "Ability_Hunter_AspectOfTheMonkey",
	Hawk = "Spell_Nature_RavenForm",
	Cheetah = "Ability_Mount_JungleTiger",
	Pack = "Ability_Mount_WhiteTiger",
	Beast = "Ability_Mount_PinkTiger",
	Wild = "Spell_Nature_ProtectionformNature",
	Viper = "Ability_Hunter_AspectOfTheViper",
	Dragonhawk = "Ability_Hunter_Pet_DragonHawk",
	Feigning = "Ability_Rogue_FeignDeath",
	Evocate = "Spell_Nature_Purge",
	Solo = "INV_Mask_05",
	LOW_HEALTH = "Ability_Rogue_FeignDeath",
	HAS_BUFF = "Spell_Fire_FlameTounge",
	Dining = "INV_Misc_Fork&Knife",
	Spirit = "Spell_Holy_DivineSpirit",
	Caster = "INV_Staff_14",
	HERBALISM = "INV_Misc_Herb_13",
	MINING = "INV_Pick_03",
	SKINNING = "INV_Weapon_ShortBlade_01",
	LOCKPICKING = "INV_Misc_Key_03",
	
	-- Stat outfits
	
	FireResist = "INV_Elemental_Primal_Fire",
	NatureResist = "Spell_Nature_ProtectionFromNature",
	ShadowResist = "INV_Elemental_Primal_Shadow",
	ArcaneResist = "Spell_Nature_WispSplode",
	FrostResist = "Spell_Frost_ColdHearted",
	
	[Outfitter.cNakedOutfit] = "INV_Misc_CelebrationCake_01",
}

function Outfitter.OutfitBar:Construct()
	self.Settings = Outfitter.Settings
	
	if not self.Settings.OutfitBar then
		self.Settings.OutfitBar = {}
	end
	
	if not self.Settings.OutfitBar.Position then
		self.Settings.OutfitBar.Position =
		{
			RelativePoint = "TOPLEFT",
			x = 200,
			y = -200,
		}
	end
	
	if self.Initialized
	or not self.CanInitialize
	or not self.Settings.OutfitBar.ShowOutfitBar then
		return
	end
	
	if Outfitter.LBF and not Outfitter.LBFGroup then
		Outfitter.LBFGroup = Outfitter.LBF:Group("Outfitter")
		Outfitter.LBF:RegisterSkinCallback("Outfitter", Outfitter.LBFSkinCallback, Outfitter)
		if self.Settings.LBFSettings then
			Outfitter.LBFGroup:Skin(self.Settings.LBFSettings.SkinID, self.Settings.LBFSettings.Gloss, self.Settings.LBFSettings.Backdrop, self.Settings.LBFSettings.Colors)
		end
	end
	
	self.Bars = {}
	
	self.DragBar1 = Outfitter.OutfitBar._DragBar:New(self)
	self.DragBar2 = Outfitter.OutfitBar._DragBar:New(self)
	
	self:SetScale(self.Settings.OutfitBar.Scale or 1) -- This also sets the position
	
	Outfitter:RegisterOutfitEvent("WEAR_OUTFIT", function () Outfitter.OutfitBar:ChangedOutfits() end)
	Outfitter:RegisterOutfitEvent("UNWEAR_OUTFIT", function () Outfitter.OutfitBar:ChangedOutfits() end)
	Outfitter:RegisterOutfitEvent("ADD_OUTFIT", function () Outfitter.OutfitBar:ChangedOutfits() end)
	Outfitter:RegisterOutfitEvent("DELETE_OUTFIT", function () Outfitter.OutfitBar:ChangedOutfits() end)
	Outfitter:RegisterOutfitEvent("EDIT_OUTFIT", function () Outfitter.OutfitBar:ChangedOutfits() end)
	
	self.Initialized = true
	
	self:Show()
end

function Outfitter.OutfitBar:InitializeSettings()
	self.Settings = Outfitter.Settings
	
	self.Settings.OutfitBar =
	{
		ShowOutfitBar = false,
		Position =
		{
			RelativePoint = "TOPLEFT",
			x = 200,
			y = -200,
		},
	}
end

function Outfitter.OutfitBar:UpdateDragBarOrientation()
	self.DragBar1:SetVerticalOrientation(self.Settings.OutfitBar.Vertical)
	self.DragBar2:SetVerticalOrientation(self.Settings.OutfitBar.Vertical)
end

function Outfitter.OutfitBar:Show()
	if not self.Initialized then
		self:Construct()
	end
	
	if self.IsShown then
		return
	end
	
	self.IsShown = true

	self.DragBar1:Show()
	self.DragBar2:Show()
	self:ChangedOutfits()
end

function Outfitter.OutfitBar:Hide()
	if not self.IsShown then
		return
	end
	
	self.IsShown = false
	
	self.DragBar1:Hide()
	self.DragBar2:Hide()
	
	for vIndex = 1, #self.Bars do
		self.Bars[vIndex]:Hide()
	end
end

function Outfitter.OutfitBar:AdjustAlpha()
	if not self.Initialized then
		return
	end
	
	self:SetAlpha(Outfitter.InCombat and self.Settings.OutfitBar.CombatAlpha or self.Settings.OutfitBar.Alpha or 1)
end

function Outfitter.OutfitBar:SetAlpha(pAlpha)
	if self.LockedAlpha then
		pAlpha = self.LockedAlpha
	end
	
	for vIndex = 1, #self.Bars do
		self.Bars[vIndex]:SetAlpha(pAlpha)
	end
end

function Outfitter.OutfitBar:SetLockedAlpha(pAlpha)
	self.LockedAlpha = pAlpha
	self:AdjustAlpha()
end

function Outfitter.OutfitBar:ShowBackground(pShow)
	for vIndex = 1, #self.Bars do
		self.Bars[vIndex]:ShowBackground(pShow)
	end
end

function Outfitter.OutfitBar:SetScale(pScale)
	self.DragBar1:SetScale(pScale)
	self.DragBar2:SetScale(pScale)
	
	for vIndex = 1, #self.Bars do
		self.Bars[vIndex]:SetScale(pScale)
	end
	
	self:UpdateBars2()
end

function Outfitter.OutfitBar:DragBar_OnClick()
	if arg1 == "RightButton" then
		if not self.SettingsDialog then
			self.SettingsDialog = Outfitter.OutfitBar._SettingsDialog:New()
		end
		
		if self.SettingsDialog:IsVisible() then
			self.SettingsDialog:HideDialog()
		else
			self.SettingsDialog:ShowDialog()
		end
	elseif self.SettingsDialog then
		self.SettingsDialog:HideDialog()
	end
end
	
function Outfitter.OutfitBar:SetShowOutfitBar(pShowBar)
	self.Settings.OutfitBar.ShowOutfitBar = pShowBar
	
	if pShowBar then
		self:Show()
	else
		self:Hide()
	end
end

function Outfitter.OutfitBar:GetOutfitSettings(pOutfit)
	if not pOutfit.OutfitBar then
		pOutfit.OutfitBar = {}
	end
	
	return pOutfit.OutfitBar
end

function Outfitter.OutfitBar:IsOutfitShown(pOutfit)
	return not self:GetOutfitSettings(pOutfit).Hide
end

function Outfitter.OutfitBar:StartFrameFades(pForceDragBars)
	if pForceDragBars or not self.Settings.OutfitBar.LockPosition then
		UIFrameFadeOut(self.DragBar1, 0.3, 1, 0)
		UIFrameFadeOut(self.DragBar2, 0.3, 1, 0)
	end
	
	if self.Settings.OutfitBar.Alpha and self.Settings.OutfitBar.Alpha ~= 1 then
		for vIndex = 1, #self.Bars do
			UIFrameFadeOut(self.Bars[vIndex], 0.5, 1, self.Settings.OutfitBar.Alpha)
		end
	end
end

function Outfitter.OutfitBar:StopFrameFades(pForceDragBars)
	if pForceDragBars or not self.Settings.OutfitBar.LockPosition then
		UIFrameFadeRemoveFrame(self.DragBar1)
		UIFrameFadeRemoveFrame(self.DragBar2)
	end
	
	for vIndex = 1, #self.Bars do
		UIFrameFadeRemoveFrame(self.Bars[vIndex])
	end
end

function Outfitter.OutfitBar:ShowDragBars(pForceShow)
	if pForceShow or not self.Settings.OutfitBar.LockPosition then
		self.DragBar1:SetAlpha(1)
		self.DragBar2:SetAlpha(1)
	end
	
	self:StopFrameFades(pForceShow)
	self:SetLockedAlpha(1)
end

function Outfitter.OutfitBar:HideDragBars(pForceHide)	
	self.LockedAlpha = nil
	self:StartFrameFades(pForceHide)
end

function Outfitter.OutfitBar:PositionChanged()
	if not self.Settings.OutfitBar.Position then
		self.Settings.OutfitBar.Position = {}
	end
	
	local vBarScale = self.Bars[1]:GetEffectiveScale()
	
	local vUIScale = UIParent:GetEffectiveScale()
	local vUILeft = UIParent:GetLeft() * vUIScale
	local vUIRight = UIParent:GetRight() * vUIScale
	local vUITop = UIParent:GetTop() * vUIScale
	local vUIBottom = UIParent:GetBottom() * vUIScale
	
	local vTopLeftBar = self.DidStackBackwards and self.Bars[#self.Bars] or self.Bars[1]
	local vBottomRightBar = self.DidStackBackwards and self.Bars[1] or self.Bars[#self.Bars]
	
	local vBarLeft = vTopLeftBar:GetLeft() * vBarScale
	local vBarRight = vBottomRightBar:GetRight() * vBarScale
	local vBarTop = vTopLeftBar:GetTop() * vBarScale
	local vBarBottom = vBottomRightBar:GetBottom() * vBarScale
	
	local vIsAnchorBottom = 0.5 * (vBarTop + vBarBottom) < 0.5 * (vUITop + vUIBottom)
	local vIsAnchorRight = 0.5 * (vBarLeft + vBarRight) < 0.5 * (vUILeft + vUIRight)
	
	if vIsAnchorBottom then
		self.Settings.OutfitBar.Position.RelativePoint = "BOTTOM"
		self.Settings.OutfitBar.Position.y = vBarBottom - vUIBottom
	else
		self.Settings.OutfitBar.Position.RelativePoint = "TOP"
		self.Settings.OutfitBar.Position.y = vBarTop - vUITop
	end
	
	if vIsAnchorRight then
		self.Settings.OutfitBar.Position.RelativePoint = self.Settings.OutfitBar.Position.RelativePoint.."LEFT"
		self.Settings.OutfitBar.Position.x = vBarLeft - vUILeft
	else
		self.Settings.OutfitBar.Position.RelativePoint = self.Settings.OutfitBar.Position.RelativePoint.."RIGHT"
		self.Settings.OutfitBar.Position.x = vBarRight - vUIRight
	end
end

function Outfitter.OutfitBar:NewBar(pNumColumns, pNumRows)
	local vName = "OutfitterOutfitBar"..self.UniqueNameIndex
	
	self.UniqueNameIndex = self.UniqueNameIndex + 1
	
	local vBar = CreateFrame("Frame", vName)
	
	Outfitter.InitializeFrame(vBar, Outfitter._ButtonBar, self._Bar)
	
	vBar:Construct(vName, pNumColumns, pNumRows)
	vBar:SetScale(self.Settings.OutfitBar.Scale or 1)
	vBar:ShowBackground(not self.Settings.OutfitBar.HideBackground)
	
	return vBar
end

function Outfitter.OutfitBar:GetDefaultIcons(pOutfit)
	local vIcons = {}
	
	-- See if the script has a default icon
	
	local vTexture = Outfitter.OutfitBar.cDefaultScriptIcons[pOutfit.ScriptID]
	
	if vTexture then
		table.insert(vIcons, Outfitter.OutfitBar.cBlizzardIconPath..vTexture)
	end
	
	-- See if the optimization has a default icon
	
	vTexture = Outfitter.OutfitBar.cDefaultScriptIcons[pOutfit.StatID]
	
	if vTexture then
		table.insert(vIcons, Outfitter.OutfitBar.cBlizzardIconPath..vTexture)
	end
	
	-- See if the name has a default icon
	
	vTexture = Outfitter.OutfitBar.cDefaultScriptIcons[pOutfit:GetName()]
	
	if vTexture then
		table.insert(vIcons, Outfitter.OutfitBar.cBlizzardIconPath..vTexture)
	end
	
	return vIcons
end

function Outfitter.OutfitBar:GetOutfitTexture(pOutfit)
	if not pOutfit then
		return "Interface\\Icons\\INV_Chest_Cloth_50"
	end
	
	-- If the icon specifies the texture then just use it
	
	local vTexture = pOutfit:GetIcon()
	
	if vTexture then
		return vTexture
	end
	
	-- See if the outfit has a default icon
	
	local vIcons = self:GetDefaultIcons(pOutfit)
	
	if #vIcons > 0 then
		return vIcons[1]
	end
	
	-- If it's a single-item outfit, use that item as the icon
	
	local vOutfitItem
	local vItems = pOutfit:GetItems()
	
	for vInventorySlot, vItem in pairs(vItems) do
		if not vOutfitItem then
			vOutfitItem = vItem
		else
			vOutfitItem = nil
			break
		end
	end
	
	if vOutfitItem then
		local vTexture = GetItemIcon(vOutfitItem.Code)
		
		if vTexture then
			return vTexture
		end
	end
	
	-- Use a plain icon
	
	return "Interface\\Icons\\INV_Chest_Cloth_50"
end

function Outfitter.OutfitBar:GetCursorTexture()
	local vType, vParam1, vParam2 = GetCursorInfo()
		
	if not vType then
		return
	end
	
	if vType == "spell" then
		return GetSpellTexture(vParam1, vParam2)
	
	elseif vType == "item" then
		for _, vInventorySlot in ipairs(Outfitter.cSlotNames) do
			local	vSlotID = Outfitter.cSlotIDs[vInventorySlot]
			local	vItemLink = Outfitter:GetInventorySlotIDLink(vSlotID)
			
			if vItemLink == vParam2 then
				return GetInventoryItemTexture("player", vSlotID)
			end
		end
		
		local	vNumBags, vFirstBagIndex = Outfitter:GetNumBags()
		
		for vBagIndex = vFirstBagIndex, vNumBags do
			local vNumBagSlots = GetContainerNumSlots(vBagIndex)
			
			for vBagSlotIndex = 1, vNumBagSlots do
				local vItemLink = GetContainerItemLink(vBagIndex, vBagSlotIndex)
				
				if vItemLink == vParam2 then
					local vTexture = GetContainerItemInfo(vBagIndex, vBagSlotIndex)
					
					return vTexture
				end
			end
		end
	else
		Outfitter:DebugMessage("OutfitBar: Unknown cursor type %s param1 %s param2 %s", vType, vParam1 or "nil", vParam2 or "nil")
	end
end

function Outfitter.OutfitBar:ChangedOutfits()
	self:UpdateBars()
end

function Outfitter.OutfitBar:UpdateBars()
	if not self.IsShown then
		return
	end
	
	-- Use a delayed task to update the bar to ensure performance
	-- is not affected when there are multiple outfits being changed
	-- simultaneously
	
	Outfitter.SchedulerLib:ScheduleUniqueTask(0.01, self.UpdateBars2, self)
end

function Outfitter.OutfitBar:xor(a, b)
	return (a or b) and not (a and b)
end

function Outfitter.OutfitBar:UpdateBars2()
	Outfitter.SchedulerLib:UnscheduleTask(self.UpdateBars2, self)
	
	-- Update the title bar orientation
	
	self:UpdateDragBarOrientation()
	
	--
	
	local vIsAnchorBottom = string.sub(self.Settings.OutfitBar.Position.RelativePoint, 1, 6) == "BOTTOM"
	local vIsAnchorRight = string.sub(self.Settings.OutfitBar.Position.RelativePoint, -5) == "RIGHT"
	local vStackBackwards = (self.Settings.OutfitBar.Vertical and vIsAnchorBottom)
	                     or (not self.Settings.OutfitBar.Vertical and vIsAnchorRight)
	
	local vDragBarAnchor = tern(self:xor(self.Settings.OutfitBar.Vertical, vIsAnchorBottom), "BOTTOM", "TOP")..
	                       tern(self:xor(self.Settings.OutfitBar.Vertical, vIsAnchorRight), "LEFT", "RIGHT")
	
	self.DidStackBackwards = vStackBackwards
	
	--
	
	self.DragBar1:ClearAllPoints()
	
	self.DragBar1:SetPoint(
			vDragBarAnchor,
			UIParent,
			self.Settings.OutfitBar.Position.RelativePoint,
			self.Settings.OutfitBar.Position.x / self.DragBar1:GetEffectiveScale(),
			self.Settings.OutfitBar.Position.y / self.DragBar1:GetEffectiveScale())
	
	-- Update the bars
	
	local vBarIndex = 1
	local vPreviousBar = self.DragBar1
	
	local vCategoryOrder = Outfitter:GetCategoryOrder()
	
	if vStackBackwards then
		for vCategoryIndex = #vCategoryOrder, 1, -1 do
			local vCategoryID = vCategoryOrder[vCategoryIndex]
			
			if self:UpdateBar(vBarIndex, vCategoryID) then
				local vBar = self.Bars[vBarIndex]
				
				vBar:ClearAllPoints()
				
				if self.Settings.OutfitBar.Vertical then
					vBar:SetPoint("BOTTOMLEFT", vPreviousBar, "TOPLEFT")
				else
					vBar:SetPoint("TOPRIGHT", vPreviousBar, "TOPLEFT")
				end
				
				vAnchorOffsetX, vAnchorOffsetY = nil, nil
							
				vBar:Show()
				
				vBarIndex = vBarIndex + 1
				vPreviousBar = vBar
			end
		end
		
		self.DragBar2:ClearAllPoints()
		if self.Settings.OutfitBar.Vertical then
			self.DragBar2:SetPoint("BOTTOMLEFT", vPreviousBar, "TOPLEFT")
		else
			self.DragBar2:SetPoint("TOPRIGHT", vPreviousBar, "TOPLEFT")
		end
	else
		for vCategoryIndex, vCategoryID in ipairs(vCategoryOrder) do
			if self:UpdateBar(vBarIndex, vCategoryID) then
				local vBar = self.Bars[vBarIndex]
				
				vBar:ClearAllPoints()
				
				if self.Settings.OutfitBar.Vertical then
					vBar:SetPoint("TOPLEFT", vPreviousBar, "BOTTOMLEFT")
				else
					vBar:SetPoint("TOPLEFT", vPreviousBar, "TOPRIGHT")
				end
				
				vAnchorOffsetX, vAnchorOffsetY = nil, nil
				
				vBar:Show()
				
				vBarIndex = vBarIndex + 1
				vPreviousBar = vBar
			end
		end
		
		self.DragBar2:ClearAllPoints()
		if self.Settings.OutfitBar.Vertical then
			self.DragBar2:SetPoint("TOPLEFT", vPreviousBar, "BOTTOMLEFT", 0, 6)
		else
			self.DragBar2:SetPoint("TOPLEFT", vPreviousBar, "TOPRIGHT", -1, 0)
		end
	end

	-- Hide unused bars
	
	for vIndex = vBarIndex, #self.Bars do
		self.Bars[vIndex]:Hide()
	end
	
	-- Fudge the drag bars so they look nice against the edges of the frame
	
	local vBar1OffsetX, vBar1OffsetY = 0, 0
	local vBar2OffsetX, vBar2OffsetY = 0, 0
	
	if self.Settings.OutfitBar.Vertical then
		if vIsAnchorBottom then
			vBar1OffsetY = 4
			vBar2OffsetY = 1
		else
			vBar1OffsetY = 1
			vBar2OffsetY = -2
		end
	else
		if vIsAnchorRight then
			vBar1OffsetX = -1
			vBar2OffsetX = -2
		else
			vBar1OffsetX = -2
		end
	end
	
	self.DragBar1:SetTextureOffset(vBar1OffsetX, vBar1OffsetY)
	self.DragBar2:SetTextureOffset(vBar2OffsetX, vBar2OffsetY)
end

function Outfitter.OutfitBar:AnchorDragBar(pBar)
	pBar:ClearAllPoints()
	
	pBar:SetPoint(
			self.Settings.OutfitBar.Position.RelativePoint,
			UIParent,
			self.Settings.OutfitBar.Position.RelativePoint,
			self.Settings.OutfitBar.Position.x / self.DragBar1:GetEffectiveScale(),
			self.Settings.OutfitBar.Position.y / self.DragBar1:GetEffectiveScale())
end

function Outfitter.OutfitBar:UpdateBar(pBarIndex, pCategoryID)
	local vOutfits = Outfitter:GetOutfitsByCategoryID(pCategoryID)
	
	if not vOutfits then
		return false
	end
	
	local vNumShown = 0
	
	for vOutfitIndex, vOutfit in ipairs(vOutfits) do
		if Outfitter.OutfitBar:IsOutfitShown(vOutfit) then
			vNumShown = vNumShown + 1
		end
	end
	
	if vNumShown == 0 then
		return false
	end
	
	local vBar = self.Bars[pBarIndex]
	local vNumColumns, vNumRows
	
	if self.Settings.OutfitBar.Vertical then
		vNumColumns = 1
		vNumRows = vNumShown
	else
		vNumColumns = vNumShown
		vNumRows = 1
	end
	
	if not vBar then
		vBar = self:NewBar(vNumColumns, vNumRows)
		table.insert(self.Bars, vBar)
	else
		vBar:SetDimensions(vNumColumns, vNumRows)
	end
	
	local vButtonIndex = 1
	
	for vOutfitIndex, vOutfit in ipairs(vOutfits) do
		if Outfitter.OutfitBar:IsOutfitShown(vOutfit) then
			vBar:SetButtonOutfit(vButtonIndex, vOutfit)
			vButtonIndex = vButtonIndex + 1
		end
	end
	
	return true
end

function Outfitter.OutfitBar.IconSetDropdown_OnLoad(pMenuFrame)
	pMenuFrame.Dialog = OutfitterChooseIconDialog
	pMenuFrame.ChangedValueFunc = Outfitter.OutfitBar.IconSetDropdown_ChangedValue
	
	Outfitter:DropDownMenu_Initialize(pMenuFrame, Outfitter.OutfitBar.IconSetDropdown_Initialize)
	pMenuFrame:SetMenuWidth(175)
	pMenuFrame:Refresh()
end

function Outfitter.OutfitBar.IconSetDropdown_Initialize(pFrame)
	local vStoredInEM = pFrame.Dialog.Outfit and pFrame.Dialog.Outfit.StoredInEM
	
	Outfitter:AddMenuItem(pFrame, Outfitter.cSuggestedIcons, "Recommend")
	Outfitter:AddMenuItem(pFrame, Outfitter.cSpellbookIcons, "Spellbook")
	if not vStoredInEM then
		Outfitter:AddMenuItem(pFrame, Outfitter.cYourItemIcons, "Inventory")
		Outfitter:AddMenuItem(pFrame, Outfitter.cEveryIcon, "All")
		Outfitter:AddMenuItem(pFrame, Outfitter.cItemIcons, "Items")
	end
	Outfitter:AddMenuItem(pFrame, Outfitter.cAbilityIcons, "Abilities")
end

function Outfitter.OutfitBar.IconSetDropdown_ChangedValue(pMenuFrame, pValue)
	pMenuFrame.Dialog:SetIconSetID(pValue)
end

----------------------------------------
Outfitter.OutfitBar._Bar = {}
----------------------------------------

function Outfitter.OutfitBar._Bar:Construct(pName, pNumColumns, pNumRows)
	Outfitter._ButtonBar.Construct(self, pName, pNumColumns, pNumRows, Outfitter.OutfitBar._Button, "ActionButtonTemplate")
	
	self:SetScript("OnEnter", function () Outfitter.OutfitBar:ShowDragBars() end)
	self:SetScript("OnLeave", function () Outfitter.OutfitBar:HideDragBars() end)
end

function Outfitter.OutfitBar._Bar:SetButtonOutfit(pButtonIndex, pOutfit)
	local vButton = self:GetIndexedButton(pButtonIndex)
	
	if not vButton then
		return
	end
	
	vButton:SetOutfit(pOutfit)
end

function Outfitter.OutfitBar._Bar:Update()
	for vIndex = 1, self.NumButtons do
		self:GetIndexedButton(vIndex):Update()
	end
end

----------------------------------------
Outfitter.OutfitBar._Button = {}
----------------------------------------

Outfitter.OutfitBar._Button.Widgets =
{
	"Icon",
}

function Outfitter.OutfitBar._Button:Construct()
	self:SetWidth(Outfitter.Style.ButtonBar.ButtonWidth)
	self:SetHeight(Outfitter.Style.ButtonBar.ButtonHeight)
	
	self:SetScript("OnClick", function (button, ...) button:OnClick(...) end)
	self:SetScript("OnEnter", function (button, ...) button:OnEnter(...) end)
	self:SetScript("OnLeave", function (button, ...) button:OnLeave(...) end)
	
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	
	-- Initialize the stuff for the dropdown menu
	
	self.SavedHeight = Outfitter.Style.ButtonBar.ButtonHeight
	self.ChangedValueFunc = self.MenuItemSelected
	
	Outfitter.UIDropDownMenu_SetAnchor(self, 0, 0, "TOPLEFT", self:GetName(), "CENTER")
	Outfitter:DropDownMenu_Initialize(self, self.InitializeMenu)
	
	if Outfitter.LBFGroup then
		Outfitter.LBFGroup:AddButton(self)
	end
end

function Outfitter.OutfitBar._Button.InitializeMenu(pButton)
	Outfitter:InitializeOutfitMenu(pButton, pButton.Outfit)
	
	pButton:SetHeight(Outfitter.Style.ButtonBar.ButtonHeight) -- WoW's menu code changes the height, so put it back
end

function Outfitter.OutfitBar._Button:MenuItemSelected(pItemID)
	Outfitter:PerformAction(pItemID, self.Outfit)
end

function Outfitter.OutfitBar._Button:SetOutfit(pOutfit)
	self.Outfit = pOutfit
	self:Update()
end

function Outfitter.OutfitBar._Button:Update()
	self.Widgets.Icon:SetTexture(Outfitter.OutfitBar:GetOutfitTexture(self.Outfit))
	
	if Outfitter:WearingOutfit(self.Outfit) then
		self:SetChecked(true)
		self.Widgets.Icon:SetVertexColor(1, 1, 1)
	else
		self:SetChecked(false)
		self.Widgets.Icon:SetVertexColor(0.9, 0.9, 0.9)
	end
end

function Outfitter.OutfitBar._Button:OnClick(pMouseButton)
	if pMouseButton == "LeftButton" then
		local vType, vParam1, vParam2 = GetCursorInfo()
			
		if vType then
			-- Set the icon if they're holding an item and
			-- the alt key is down
			
			if IsAltKeyDown() then
				local vTexture = Outfitter.OutfitBar:GetCursorTexture()
				
				if vTexture then
					if not self.Outfit.OutfitBar then
						self.Outfit.OutfitBar = {}
					end
					
					self.Outfit:SetIcon(vTexture)
					self:Update()
					ClearCursor()
				end
			
			-- Otherwise create an outfit from the item being held
			
			elseif vType == "item" then
				local vItem = Outfitter:GetItemInfoFromLink(vParam2)
				
				if not vItem then
					Outfitter:ErrorMessage("Outfitter.OutfitBar: Couldn't get information about the item being dropped")
					return
				end
				
				if not vItem.ItemSlotName then
					Outfitter:ErrorMessage("Outfitter.OutfitBar: Couldn't make an outfit from "..vItem.Name.." because it isn't equippable")
					return
				end
				
				-- Create a new outfit containing the item and equip it
				
				local vOutfit = Outfitter:NewEmptyOutfit(vItem.Name)
				
				vOutfit:AddItem(vItem.ItemSlotName, vItem)
				Outfitter:AddOutfit(vOutfit)
				Outfitter:WearOutfit(vOutfit)
			end
		
		-- If there are no modifiers down, then just equip or unequip the outfit
		
		else
			Outfitter.HasHWEvent = true
			if self.Outfit.CategoryID == "Complete"
			or not Outfitter:WearingOutfit(self.Outfit) then
				Outfitter:WearOutfit(self.Outfit)
			else
				Outfitter:RemoveOutfit(self.Outfit)
			end
			Outfitter.HasHWEvent = false
		end
	else -- if pButton == "RightButton" then
		if DropDownList1:IsShown() then
			ToggleDropDownMenu(nil, nil, self, self)
		else
			ToggleDropDownMenu(nil, nil, self, self)
			PlaySound("igMainMenuOptionCheckBoxOn")
		end
	end
end

function Outfitter.OutfitBar._Button:OnEnter()
	local	vMissingItems, vBankedItems = Outfitter:GetInventoryCache():GetMissingItems(self.Outfit)
	
	Outfitter:ShowOutfitTooltip(self.Outfit, self, vMissingItems, vBankedItems, true)
	
	Outfitter.OutfitBar:ShowDragBars()
end

function Outfitter.OutfitBar._Button:OnLeave()
	GameTooltip:Hide()
	Outfitter.OutfitBar:HideDragBars()
end

----------------------------------------
Outfitter.OutfitBar._ChooseIconDialog = {}
----------------------------------------

Outfitter.OutfitBar._ChooseIconDialog.Widgets =
{
	"ScrollFrame",
	"IconSetMenu",
	"FilterEditBox",
	"Title"
}

function Outfitter.OutfitBar._ChooseIconDialog:Construct()
	-- Create the icon buttons
	
	self.IconButtons = {}
	self.NumRows = 5
	self.NumColumns = 6
	
	local vPrevRowFirstButton
	
	for vRow = 1, self.NumRows do
		local vPrevButton
		
		for vColumn = 1, self.NumColumns do
			local vButton = self:NewIconButton()
			
			table.insert(self.IconButtons, vButton)
			
			if vPrevButton then
				vButton:SetPoint("LEFT", vPrevButton, "RIGHT", 10, 0)
			else
				if vPrevRowFirstButton then
					vButton:SetPoint("TOPLEFT", vPrevRowFirstButton, "BOTTOMLEFT", 0, -8)
				else
					vButton:SetPoint("TOPLEFT", self.Widgets.ScrollFrame, "TOPLEFT", 0, 0)
				end
				
				vPrevRowFirstButton = vButton
			end
			
			vPrevButton = vButton
		end
	end
	
	-- Hook into the UIMenus list when the dialog is up to capture the escape key presses
	
	self:SetScript("OnShow", function(self)
		Outfitter:BeginMenu(self)
	end)
	
	self:SetScript("OnHide", function(self)
		Outfitter:EndMenu(self)
		
		if self.Outfit then
			self:Close()
		end
	end)

	-- Set the default icon set
	
	self.IconSetID = "Recommend"
end

function Outfitter.OutfitBar._ChooseIconDialog:Open(pOutfit)
	self.Outfit = pOutfit
	self.SelectedTexture = self.Outfit:GetIcon()
	
	if not self.SelectedTexture then
		self.SelectedTexture = Outfitter.OutfitBar.cWildcardIcon
	end
	
	self.Widgets.Title:SetText(string.format(Outfitter.cChooseIconTitle, pOutfit:GetName()))
	self.Widgets.FilterEditBox:SetText("")
	self:SetIconSetID(self.IconSetID)
	
	self:Show()
end

function Outfitter.OutfitBar._ChooseIconDialog:Save()
	if self.SelectedTexture == Outfitter.OutfitBar.cWildcardIcon then
		self.Outfit:SetIcon(nil)
	else
		self.Outfit:SetIcon(self.SelectedTexture)
	end
	
	Outfitter:DispatchOutfitEvent("EDIT_OUTFIT", self.Outfit:GetName(), self.Outfit)
end

function Outfitter.OutfitBar._ChooseIconDialog:Close()
	if self.TextureSet and self.TextureSet.Deactivate then
		self.TextureSet:Deactivate()
		self.TextureSet = nil
	end
	
	self.Outfit = nil
	self:Hide()
end

function Outfitter.OutfitBar._ChooseIconDialog:SetIconSetID(pIconSetID)
	self.IconSetID = pIconSetID
	self.TextureList = nil
	
	UIDropDownMenu_SetSelectedValue(self.Widgets.IconSetMenu, pIconSetID)
	
	self:SetIconFilter(self.Widgets.FilterEditBox:GetText())
end

function Outfitter.OutfitBar._ChooseIconDialog:SetIconFilter(pText)
	local vTextureSet = Outfitter.OutfitBar.TextureSets[self.IconSetID]
	
	-- Activate the set if it's changing
	
	if vTextureSet ~= self.TextureSet then
		if self.TextureSet and self.TextureSet.Deactivate then
			self.TextureSet:Deactivate()
		end
		
		self.TextureSet = vTextureSet
		
		if self.TextureSet.Activate then
			self.TextureSet:Activate(self.Outfit)
		end
	end
	
	--
	
	if pText and pText ~= "" then
		self.DisplayTextureSet = Outfitter.OutfitBar.TextureSets.Filtered
		self.DisplayTextureSet:SetFilter(vTextureSet, pText)
	else
		if self.DisplayTextureSet == Outfitter.OutfitBar.TextureSets.Filtered then
			self.DisplayTextureSet:Deactivate()
		end
		
		self.DisplayTextureSet = self.TextureSet
	end
	
	self:UpdateIcons()
end

function Outfitter.OutfitBar._ChooseIconDialog:SetSelectedTexture(pTexture)
	self.SelectedTexture = pTexture
	
	self:UpdateIcons()
end

function Outfitter.OutfitBar._ChooseIconDialog:UpdateIcons()
	local vNumTextures = self.DisplayTextureSet:GetNumTextures()
	
	FauxScrollFrame_Update(self.Widgets.ScrollFrame, ceil(vNumTextures / self.NumColumns), self.NumRows, 36)
	
	local vScrollOffset = FauxScrollFrame_GetOffset(self.Widgets.ScrollFrame)
	local vTextureIndex = 1 + vScrollOffset * self.NumColumns
	
	for _, vIconButton in ipairs(self.IconButtons) do
		if vTextureIndex <= vNumTextures then
			local vTexture = self.DisplayTextureSet:GetIndexedTexture(vTextureIndex)
			
			if vTexture == self.SelectedTexture then
				vIconButton:SetChecked(true)
			else
				vIconButton:SetChecked(false)
			end
			
			vIconButton.Texture = vTexture
			vIconButton.Widgets.Icon:SetTexture(vTexture)
			vIconButton:Show()
			
			vTextureIndex = vTextureIndex + 1
		else
			vIconButton:Hide()
		end
	end
end

function Outfitter.OutfitBar._ChooseIconDialog:NewIconButton()
	local vButtonName = "OutfitterChooseIconDialogButton"..#self.IconButtons
	local vButton = CreateFrame("CheckButton", vButtonName, self, "ActionButtonTemplate")
	
	Outfitter.InitializeFrame(vButton, Outfitter.OutfitBar._IconButton)
	vButton:Construct()
	
	vButton:SetFrameLevel(self:GetFrameLevel() + 1)
	vButton:SetParent(self)
	
	vButton:Enable()
	vButton:Show()

	return vButton
end

----------------------------------------
Outfitter.OutfitBar._IconButton = {}
----------------------------------------

Outfitter.OutfitBar._IconButton.Widgets =
{
	"Icon",
	"Flash",
	"HotKey",
	"Count",
	"Name",
	"Border",
	"Cooldown",
	"NormalTexture",
}

function Outfitter.OutfitBar._IconButton:Construct()
	self:EnableMouse(true)
	
	self:SetScript("OnEnter", self.OnEnter)
	self:SetScript("OnLeave", self.OnLeave)
	self:SetScript("OnClick", self.OnClick)
end

function Outfitter.OutfitBar._IconButton:OnEnter()
	local vTextureName
	
	if self.Texture == Outfitter.OutfitBar.cWildcardIcon then
		vTextureName = Outfitter.cOutfitterDecides
	elseif strsub(self.Texture, 1, Outfitter.OutfitBar.cBlizzardIconPathLength) == Outfitter.OutfitBar.cBlizzardIconPath then
		vTextureName = strsub(self.Texture, Outfitter.OutfitBar.cBlizzardIconPathLength + 1)
	else
		vTextureName = self.Texture
	end
	
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	GameTooltip:AddLine(vTextureName)
	GameTooltip:Show()
end

function Outfitter.OutfitBar._IconButton:OnLeave()
	GameTooltip:Hide()
end

function Outfitter.OutfitBar._IconButton:OnClick()
	self:GetParent():SetSelectedTexture(self.Texture)
end

----------------------------------------
Outfitter.OutfitBar.TextureSets = {}
----------------------------------------

----------------------------------------
Outfitter.OutfitBar.TextureSets.Recommend = {}
----------------------------------------

function Outfitter.OutfitBar.TextureSets.Recommend:Activate(pOutfit)
	self.TextureList = Outfitter:RecycleTable(self.TextureList)
	
	table.insert(self.TextureList, Outfitter.OutfitBar.cWildcardIcon)
	
	local vItems = pOutfit:GetItems()
	
	for vInventorySlot, vOutfitItem in pairs(vItems) do
		local vItem = Outfitter:GetInventoryCache():FindItemOrAlt(vOutfitItem)
		
		if vItem and vItem.Texture then
			table.insert(self.TextureList, vItem.Texture)
		end
	end
	
	-- Add any default icons
	
	local vIcons = Outfitter.OutfitBar:GetDefaultIcons(pOutfit)
	
	for _, vTexture in ipairs(vIcons) do
		table.insert(self.TextureList, vTexture)
	end
end

function Outfitter.OutfitBar.TextureSets.Recommend:Deactivate()
	self.TextureList = Outfitter:RecycleTable(self.TextureList)
end

function Outfitter.OutfitBar.TextureSets.Recommend:GetNumTextures()
	return #self.TextureList
end

function Outfitter.OutfitBar.TextureSets.Recommend:GetIndexedTexture(pIndex)
	return self.TextureList[pIndex]
end

----------------------------------------
Outfitter.OutfitBar.TextureSets.All = {}
----------------------------------------

function Outfitter.OutfitBar.TextureSets.All:GetNumTextures()
	return GetNumMacroItemIcons() + GetNumMacroIcons()
end

function Outfitter.OutfitBar.TextureSets.All:GetIndexedTexture(pIndex)
	local vNumMacroItemIcons = GetNumMacroItemIcons()
	
	if pIndex <= vNumMacroItemIcons then
		return GetMacroItemIconInfo(pIndex)
	else
		return GetMacroIconInfo(pIndex - vNumMacroItemIcons)
	end
end

----------------------------------------
Outfitter.OutfitBar.TextureSets.Items = {}
----------------------------------------

function Outfitter.OutfitBar.TextureSets.Items:GetNumTextures()
	return GetNumMacroItemIcons()
end

function Outfitter.OutfitBar.TextureSets.Items:GetIndexedTexture(pIndex)
	return GetMacroItemIconInfo(pIndex)
end

----------------------------------------
Outfitter.OutfitBar.TextureSets.Abilities = {}
----------------------------------------

function Outfitter.OutfitBar.TextureSets.Abilities:GetNumTextures()
	return GetNumMacroIcons()
end

function Outfitter.OutfitBar.TextureSets.Abilities:GetIndexedTexture(pIndex)
	return GetMacroIconInfo(pIndex)
end

----------------------------------------
Outfitter.OutfitBar.TextureSets.Spellbook = {}
----------------------------------------

function Outfitter.OutfitBar.TextureSets.Spellbook:Activate()
	self.TextureList = Outfitter:RecycleTable(self.TextureList)
	
	table.insert(self.TextureList, Outfitter.OutfitBar.cWildcardIcon)
	
	local vUsedTextures = {}
	
	-- Insert the spellbook category icons together
	
	for vSpellTabIndex = 1, MAX_SKILLLINE_TABS do
		local	vCategoryName, vCategoryTexture, vCategoryOffset, vCategoryNumSpells = GetSpellTabInfo(vSpellTabIndex)
		
		if not vCategoryName then
			break
		end
		
		table.insert(self.TextureList, vCategoryTexture)
		vUsedTextures[vCategoryTexture] = true
	end
	
	-- Now insert the icons from each category
	
	for vSpellTabIndex = 1, MAX_SKILLLINE_TABS do
		local	vCategoryName, vCategoryTexture, vCategoryOffset, vCategoryNumSpells = GetSpellTabInfo(vSpellTabIndex)
		
		if not vCategoryName then
			break
		end
		
		for vSpellIndex = vCategoryOffset + 1, vCategoryOffset + vCategoryNumSpells do
			local vSpellTexture = GetSpellTexture(vSpellIndex, BOOKTYPE_SPELL)
			
			if not vUsedTextures[vSpellTexture] then
				table.insert(self.TextureList, vSpellTexture)
				vUsedTextures[vSpellTexture] = true
			end
		end
	end
end

function Outfitter.OutfitBar.TextureSets.Spellbook:Deactivate()
	-- Wipe the list so the memory doesn't linger
	
	self.TextureList = Outfitter:RecycleTable(self.TextureList)
end

function Outfitter.OutfitBar.TextureSets.Spellbook:GetNumTextures()
	return #self.TextureList
end

function Outfitter.OutfitBar.TextureSets.Spellbook:GetIndexedTexture(pIndex)
	return self.TextureList[pIndex]
end

----------------------------------------
Outfitter.OutfitBar.TextureSets.Inventory = {}
----------------------------------------

function Outfitter.OutfitBar.TextureSets.Inventory:Activate()
	self.TextureList = Outfitter:RecycleTable(self.TextureList)
	
	table.insert(self.TextureList, Outfitter.OutfitBar.cWildcardIcon)
	
	local vUsedTextures = {}
	
	for _, vInventorySlot in ipairs(Outfitter.cSlotNames) do
		local	vSlotID = Outfitter.cSlotIDs[vInventorySlot]
		local	vItemLink = Outfitter:GetInventorySlotIDLink(vSlotID)
		
		if vItemLink == vParam2 then
			local vTexture = GetInventoryItemTexture("player", vSlotID)
			
			if vTexture and not vUsedTextures[vTexture] then
				table.insert(self.TextureList, vTexture)
				vUsedTextures[vTexture] = true
			end
		end
	end
	
	--
	
	local vNumBags, vFirstBagIndex = Outfitter:GetNumBags()
	
	for vBagIndex = vFirstBagIndex, vNumBags do
		local	vNumBagSlots = GetContainerNumSlots(vBagIndex)
		
		if vNumBagSlots > 0 then
			for vSlotIndex = 1, vNumBagSlots do
				local vTexture = GetContainerItemInfo(vBagIndex, vSlotIndex)
				
				if vTexture and not vUsedTextures[vTexture] then
					table.insert(self.TextureList, vTexture)
					vUsedTextures[vTexture] = true
				end
			end
		end
	end
end

function Outfitter.OutfitBar.TextureSets.Inventory:Deactivate()
	self.TextureList = Outfitter:RecycleTable(self.TextureList)
end

function Outfitter.OutfitBar.TextureSets.Inventory:GetNumTextures()
	return #self.TextureList
end

function Outfitter.OutfitBar.TextureSets.Inventory:GetIndexedTexture(pIndex)
	return self.TextureList[pIndex]
end

----------------------------------------
Outfitter.OutfitBar.TextureSets.Filtered = {}
----------------------------------------

function Outfitter.OutfitBar.TextureSets.Filtered:Deactivate()
	-- Wipe the list so the memory doesn't linger
	
	self.TextureList = Outfitter:RecycleTable(self.TextureList)
end

function Outfitter.OutfitBar.TextureSets.Filtered:SetFilter(pTextureSet, pFilter)
	self.TextureSet = pTextureSet
	self.Filter = strlower(pFilter)
	
	self.TextureList = Outfitter:RecycleTable(self.TextureList)
	
	local vNumTextures = self.TextureSet:GetNumTextures()
	
	for vIndex = 1, vNumTextures do
		local vTexture = self.TextureSet:GetIndexedTexture(vIndex)
		
		if strfind(strlower(vTexture), self.Filter) then
			table.insert(self.TextureList, vTexture)
		end
	end
end

function Outfitter.OutfitBar.TextureSets.Filtered:GetNumTextures()
	return #self.TextureList
end

function Outfitter.OutfitBar.TextureSets.Filtered:GetIndexedTexture(pIndex)
	return self.TextureList[pIndex]
end

Outfitter:RegisterOutfitEvent("OUTFITTER_INIT", function ()
	Outfitter.OutfitBar.CanInitialize = true
	Outfitter.OutfitBar:Construct()
	OutfitterChooseIconDialog:Construct()
end)

----------------------------------------
Outfitter.OutfitBar._SettingsDialog = {}
----------------------------------------

function Outfitter.OutfitBar._SettingsDialog:New()
	local vSettingsDialog = CreateFrame("Frame", "OutfitBarSettingsDialog", UIParent)
	
	Outfitter:ConstructFrame(vSettingsDialog, self)
	
	return vSettingsDialog
end

function Outfitter.OutfitBar._SettingsDialog:Construct()
	self:SetFrameStrata("DIALOG")
	
	self:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = {left = 3, right = 3, top = 3, bottom = 3}})

	self:SetBackdropBorderColor(0.75, 0.75, 0.75)
	self:SetBackdropColor(0, 0, 0, 0.9)
	self:SetAlpha(1)
	
	self:SetScript("OnShow", function (self) self:OnShow() end)
	self:SetScript("OnHide", function (self) self:OnHide() end)
	
	self:SetWidth(180)
	self:SetHeight(245)
	
	self.SizeSlider = self:NewSlider(Outfitter.cOutfitBarSizeLabel, 0.5, 1.5, Outfitter.cOutfitBarSmallSizeLabel, Outfitter.cOutfitBarLargeSizeLabel, self.SizeSlider_OnValueChanged)
	self.SizeSlider:SetPoint("TOP", self, "TOP", 0, -27)
	
	self.AlphaSlider = self:NewSlider(Outfitter.cOutfitBarAlphaLabel, 0, 1, nil, nil, self.AlphaSlider_OnValueChanged)
	self.AlphaSlider:SetPoint("TOPLEFT", self.SizeSlider, "BOTTOMLEFT", 0, -30)
	
	self.CombatAlphaSlider = self:NewSlider(Outfitter.cOutfitBarCombatAlphaLabel, 0, 1, nil, nil, self.CombatAlphaSlider_OnValueChanged)
	self.CombatAlphaSlider:SetPoint("TOPLEFT", self.AlphaSlider, "BOTTOMLEFT", 0, -30)
	
	self.VerticalCheckbutton = self:NewCheckbutton(Outfitter.cOutfitBarVerticalLabel, self.VerticalCheckbutton_OnClick)
	self.VerticalCheckbutton:SetPoint("TOPLEFT", self.CombatAlphaSlider, "BOTTOMLEFT", -5, -15)
	
	self.LockPositionCheckbutton = self:NewCheckbutton(Outfitter.cOutfitBarLockPositionLabel, self.LockPositionCheckbutton_OnClick)
	self.LockPositionCheckbutton:SetPoint("TOPLEFT", self.VerticalCheckbutton, "BOTTOMLEFT", 0, 7)
	
	self.HideBackgroundCheckbutton = self:NewCheckbutton(Outfitter.cOutfitBarHideBackgroundLabel, self.HideBackgroundCheckbutton_OnClick)
	self.HideBackgroundCheckbutton:SetPoint("TOPLEFT", self.LockPositionCheckbutton, "BOTTOMLEFT", 0, 7)
	
	self:Hide() -- Hidden by default
end

function Outfitter.OutfitBar._SettingsDialog:ShowDialog()
	self.DisableUpdates = true
	self.SizeSlider:SetValue(Outfitter.Settings.OutfitBar.Scale or 1)
	self.AlphaSlider:SetValue(Outfitter.Settings.OutfitBar.Alpha or 1)
	self.CombatAlphaSlider:SetValue(Outfitter.Settings.OutfitBar.CombatAlpha or 1)
	self.VerticalCheckbutton:SetChecked(Outfitter.Settings.OutfitBar.Vertical)
	self.LockPositionCheckbutton:SetChecked(Outfitter.Settings.OutfitBar.LockPosition)
	self.HideBackgroundCheckbutton:SetChecked(Outfitter.Settings.OutfitBar.HideBackground)
	self.DisableUpdates = false
	
	-- Put the dialog under the cursor
	
	local	vCursorX, vCursorY = GetCursorPosition()
	local	vUIScale = UIParent:GetScale()
	
	vCursorX = vCursorX / vUIScale
	vCursorY = vCursorY / vUIScale
	
	self:ClearAllPoints()
	
	local	vAnchorPoint
	
	if vCursorY < 0.5 * (UIParent:GetTop() + UIParent:GetBottom()) then
		vAnchorPoint = "BOTTOM"
	else
		vAnchorPoint = "TOP"
	end
	
	if vCursorX < 0.5 * (UIParent:GetLeft() + UIParent:GetRight()) then
		vAnchorPoint = vAnchorPoint.."LEFT"
	else
		vAnchorPoint = vAnchorPoint.."RIGHT"
	end
	
	self:SetPoint(vAnchorPoint, UIParent, "BOTTOMLEFT", vCursorX, vCursorY)
	self:Show()
end

function Outfitter.OutfitBar._SettingsDialog:HideDialog()
	self:Hide()
	Outfitter.OutfitBar:AdjustAlpha()
	
	return true
end

function Outfitter.OutfitBar._SettingsDialog:OnShow()
	Outfitter:BeginMenu(self)
end

function Outfitter.OutfitBar._SettingsDialog:OnHide()
	Outfitter:EndMenu(self)
	Outfitter.OutfitBar:AdjustAlpha()
end

----------------------------------------
-- Notifications
----------------------------------------

function Outfitter.OutfitBar._SettingsDialog:SizeSlider_OnValueChanged()
	if self.DisableUpdates then return end
	Outfitter.Settings.OutfitBar.Scale = self.SizeSlider:GetValue()
	
	Outfitter.OutfitBar:SetScale(Outfitter.Settings.OutfitBar.Scale)
	Outfitter.OutfitBar:SetAlpha(1)
end

function Outfitter.OutfitBar._SettingsDialog:AlphaSlider_OnValueChanged()
	if self.DisableUpdates then return end
	Outfitter.Settings.OutfitBar.Alpha = self.AlphaSlider:GetValue()
	Outfitter.OutfitBar:SetAlpha(Outfitter.Settings.OutfitBar.Alpha)
end

function Outfitter.OutfitBar._SettingsDialog:CombatAlphaSlider_OnValueChanged()
	if self.DisableUpdates then return end
	Outfitter.Settings.OutfitBar.CombatAlpha = self.CombatAlphaSlider:GetValue()
	Outfitter.OutfitBar:SetAlpha(Outfitter.Settings.OutfitBar.CombatAlpha)
end

function Outfitter.OutfitBar._SettingsDialog:VerticalCheckbutton_OnClick()
	if self.DisableUpdates then return end
	Outfitter.Settings.OutfitBar.Vertical = not Outfitter.Settings.OutfitBar.Vertical
	self.VerticalCheckbutton:SetChecked(Outfitter.Settings.OutfitBar.Vertical)
	
	Outfitter.OutfitBar:AdjustAlpha()
	Outfitter.OutfitBar:ChangedOutfits() -- Update the display
end

function Outfitter.OutfitBar._SettingsDialog:LockPositionCheckbutton_OnClick()
	if self.DisableUpdates then return end
	Outfitter.Settings.OutfitBar.LockPosition = not Outfitter.Settings.OutfitBar.LockPosition
	self.LockPositionCheckbutton:SetChecked(Outfitter.Settings.OutfitBar.LockPosition)

	Outfitter.OutfitBar:AdjustAlpha()
end

function Outfitter.OutfitBar._SettingsDialog:HideBackgroundCheckbutton_OnClick()
	if self.DisableUpdates then return end
	Outfitter.Settings.OutfitBar.HideBackground = not Outfitter.Settings.OutfitBar.HideBackground
	self.HideBackgroundCheckbutton:SetChecked(Outfitter.Settings.OutfitBar.HideBackground)
	
	Outfitter.OutfitBar:ShowBackground(not Outfitter.Settings.OutfitBar.HideBackground)
end

----------------------------------------
-- Slider
----------------------------------------

Outfitter.OutfitBar._SettingsDialog.SliderCount = 0

function Outfitter.OutfitBar._SettingsDialog:NewSlider(pTitle, pMinValue, pMaxValue, pLowText, pHighText, pOnValueChangedFunc)
	-- Generate a name
	
	Outfitter.OutfitBar._SettingsDialog.SliderCount = Outfitter.OutfitBar._SettingsDialog.SliderCount + 1
	
	local vName = "OutfitBarSettingsDialogSlider"..Outfitter.OutfitBar._SettingsDialog.SliderCount
	
	-- Create the slider
	
	local vSlider = CreateFrame("Slider", vName, self, "OptionsSliderTemplate")
	
	vSlider.OnValueChangedFunc = pOnValueChangedFunc
	
	vSlider:SetMinMaxValues(pMinValue, pMaxValue)
	vSlider:SetScript("OnValueChanged", self.Slider_OnValueChanged)
	
	vSlider.Text = getglobal(vName.."Text")
	vSlider.LowText = getglobal(vName.."Low")
	vSlider.HighText = getglobal(vName.."High")
	
	vSlider.Text:SetText(pTitle)
	
	if pLowText then
		vSlider.LowText:SetText(pLowText)
		vSlider.HighText:SetText(pHighText)
	end
	
	return vSlider
end

function Outfitter.OutfitBar._SettingsDialog.Slider_OnValueChanged(self)
	self.OnValueChangedFunc(self:GetParent())
end

----------------------------------------
-- Checkbutton
----------------------------------------

Outfitter.OutfitBar._SettingsDialog.CheckbuttonCount = 0

function Outfitter.OutfitBar._SettingsDialog:NewCheckbutton(pTitle, pOnClickFunction)
	-- Generate a name
	
	Outfitter.OutfitBar._SettingsDialog.CheckbuttonCount = Outfitter.OutfitBar._SettingsDialog.CheckbuttonCount + 1
	
	local vName = "OutfitBarSettingsDialogCheckbuttom"..Outfitter.OutfitBar._SettingsDialog.CheckbuttonCount
	
	-- Create the button
	
	local vCheckbutton = CreateFrame("Checkbutton", vName, self, "OptionsCheckButtonTemplate")
	
	vCheckbutton.OnClickFunction = pOnClickFunction
	vCheckbutton:SetScript("OnClick", self.Checkbutton_OnClick)
	vCheckbutton.Text = getglobal(vName.."Text")
	vCheckbutton.Text:SetText(pTitle)

	return vCheckbutton
end

function Outfitter.OutfitBar._SettingsDialog.Checkbutton_OnClick(self)
	self.OnClickFunction(self:GetParent())
end

----------------------------------------
Outfitter.OutfitBar._DragBar = {}
----------------------------------------

function Outfitter.OutfitBar._DragBar:New(pOutfitBar)
	local vDragBar = CreateFrame("Button")
	
	Outfitter:ConstructFrame(vDragBar, self, pOutfitBar)
	
	return vDragBar
end

function Outfitter.OutfitBar._DragBar:Construct(pOutfitBar)
	self.OutfitBar = pOutfitBar
	self.TextureOffsetX = 0
	self.TextureOffsetY = 0
	
	self:SetParent(UIParent)
	self:RegisterForClicks("LeftButtonDown", "RightButtonDown")

	self:EnableMouse(true)
	self:RegisterForDrag("LeftButton")
	self:SetMovable(true)
	self:SetAlpha(0)
	
	self.DragTexture = self:CreateTexture(nil, "ARTWORK")
	
	self:SetScript("OnEnter", function (self) self.OutfitBar:ShowDragBars(true) end)
	self:SetScript("OnLeave", function (self) self.OutfitBar:HideDragBars(true) end)
	self:SetScript("OnDragStart", function (self) self:OnDragStart() end)
	self:SetScript("OnDragStop", function (self) self:OnDragStop() end)
	self:SetScript("OnMouseUp", function (self) self:OnDragStop() end)
	self:SetScript("OnMouseDown", function (self) self:OnMouseDown() end)
	self:SetScript("OnClick", function (self) self.OutfitBar:DragBar_OnClick() end)
end

function Outfitter.OutfitBar._DragBar:SetTextureOffset(pOffsetX, pOffsetY)
	self.TextureOffsetX = pOffsetX
	self.TextureOffsetY = pOffsetY
	
	self:SetVerticalOrientation(self.Vertical)
end

function Outfitter.OutfitBar._DragBar:OnMouseDown()
	Outfitter:FrameMouseDown(self.OutfitBar.DragBar1)
end

function Outfitter.OutfitBar._DragBar:OnDragStart()
	if not Outfitter.Settings.OutfitBar.LockPosition then
		Outfitter:StartMovingFrame(self.OutfitBar.DragBar1)
	else
		Outfitter:ErrorMessage(Outfitter.cPositionLockedError)
	end
end

function Outfitter.OutfitBar._DragBar:OnDragStop()
	if not Outfitter.Settings.OutfitBar.LockPosition then
		Outfitter:StopMovingFrame(self.OutfitBar.DragBar1)
		self.OutfitBar:PositionChanged()
	end
end

function Outfitter.OutfitBar._DragBar:SetVerticalOrientation(pVertical)
	self.Vertical = pVertical
	
	if pVertical then
		self:SetWidth(53)
		self:SetHeight(12)
		
		self.DragTexture:SetWidth(0)
		self.DragTexture:SetHeight(15)
		
		self.DragTexture:ClearAllPoints()
		self.DragTexture:SetPoint("TOPLEFT", self, "TOPLEFT", self.TextureOffsetX, self.TextureOffsetY)
		self.DragTexture:SetPoint("TOPRIGHT", self, "TOPRIGHT", self.TextureOffsetX - 3, self.TextureOffsetY)
		
		self.DragTexture:SetTexture("Interface\\Addons\\Outfitter\\Textures\\TopDragHandle")
		self.DragTexture:SetTexCoord(0, 0.78125, 0, 0.46875)
	else
		self:SetWidth(10)
		self:SetHeight(53)
		
		self.DragTexture:SetWidth(15)
		self.DragTexture:SetHeight(0)
		
		self.DragTexture:ClearAllPoints()
		self.DragTexture:SetPoint("TOPLEFT", self, "TOPLEFT", self.TextureOffsetX, self.TextureOffsetY - 1)
		self.DragTexture:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", self.TextureOffsetX, self.TextureOffsetY + 4)
		
		self.DragTexture:SetTexture("Interface\\Addons\\Outfitter\\Textures\\LeftDragHandle")
		self.DragTexture:SetTexCoord(0, 0.46875, 0, 0.75)
	end
end

function Outfitter:LBFSkinCallback(pSkinID, pGloss, pBackdrop, pGroup, pButton, pColors)
	if not self.Settings.LBFSettings then
		self.Settings.LBFSettings = {}
	end
	
	self.Settings.LBFSettings.SkinID = pSkinID
	self.Settings.LBFSettings.Gloss = pGloss
	self.Settings.LBFSettings.Backdrop = pBackdrop
	self.Settings.LBFSettings.Colors = pColors
end
