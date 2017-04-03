----------------------------------------
-- Outfitter Copyright 2009, 2010 John Stephen, wobbleworks.com
-- All rights reserved, unauthorized redistribution is prohibited
----------------------------------------

----------------------------------------
Outfitter._OutfitMethods = {}
Outfitter._OutfitMetaTable = {__index = Outfitter._OutfitMethods}
----------------------------------------

function Outfitter._OutfitMethods:Delete()
	-- Nothing more to do for native outfits
end

function Outfitter._OutfitMethods:GetName()
	return self.Name
end

function Outfitter._OutfitMethods:SetName(pName)
	self.Name = pName
	Outfitter.DisplayIsDirty = true
end

function Outfitter._OutfitMethods:GetIcon()
	if self.OutfitBar and self.OutfitBar.Texture then
		return self.OutfitBar.Texture
	end
end

function Outfitter._OutfitMethods:SetIcon(pTexture)
	if not self.OutfitBar then
		self.OutfitBar = {}
	end
	
	self.OutfitBar.Texture = pTexture
end

function Outfitter._OutfitMethods:SetToCurrentInventory()
	for _, vSlotName in ipairs(Outfitter.cSlotNames) do
		if self:SlotIsEnabled(vSlotName) then
			self:SetInventoryItem(vSlotName)
		end
	end
end

function Outfitter._OutfitMethods:AddNewItems(pNewItems)
	for vInventorySlot, vNewItem in pairs(pNewItems) do
		-- Only update slots which aren't in an unknown state
		
		local vCheckbox = _G["OutfitterEnable"..vInventorySlot]
		
		if not vCheckbox:GetChecked()
		or not vCheckbox.IsUnknown then
			self:SetItem(vInventorySlot, vNewItem)
			Outfitter:NoteMessage(Outfitter.cAddingItem, vNewItem.Name, self:GetName())
		end
		
		-- Add the new items to the current compiled outfit
		
		Outfitter.ExpectedOutfit:SetItem(vInventorySlot, vNewItem)
	end
end

function Outfitter._OutfitMethods:GetNumEmptySlots()
	local vNumEmptySlots = 0
	
	for _, vSlotName in ipairs(Outfitter.cSlotNames) do
		if not self.Items[vSlotName]
		or self.Items[vSlotName].Code == 0 then
			vNumEmptySlots = vNumEmptySlots + 1
		end
	end
	
	return vNumEmptySlots
end

function Outfitter._OutfitMethods:IsEmpty()
	return Outfitter:ArrayIsEmpty(self.Items)
end

function Outfitter._OutfitMethods:IsAmmoOnly()
	local vHasAmmoItem = false
	
	for vInventorySlot, vItem in pairs(self.Items) do
		if vInventorySlot ~= "AmmoSlot" then
			return false
		else
			vHasAmmoItem = true
		end
	end
	
	return vHasAmmoItem
end

function Outfitter._OutfitMethods:SetItems(pItems)
	self.Items = pItems
	Outfitter.DisplayIsDirty = true
end

function Outfitter._OutfitMethods:SetInventoryItem(pSlotName)
	self:AddItem(pSlotName, Outfitter:GetInventoryItemInfo(pSlotName))
	Outfitter.DisplayIsDirty = true
end

function Outfitter._OutfitMethods:EnableAllSlots()
	for _, vSlotName in ipairs(Outfitter.cSlotNames) do
		self:SetInventoryItem(vSlotName)
	end
	
	Outfitter.DisplayIsDirty = true
end

function Outfitter._OutfitMethods:DisableAllSlots()
	for _, vSlotName in ipairs(Outfitter.cSlotNames) do
		self:RemoveItem(vSlotName)
	end
	
	Outfitter.DisplayIsDirty = true
end

function Outfitter._OutfitMethods:AddItem(pSlotName, pItemInfo)
	if pItemInfo == nil then
		pItemInfo = Outfitter:NewEmptyItemInfo()
	end
	
	self.Items[pSlotName] =
	{
		Code = tonumber(pItemInfo.Code),
		SubCode = tonumber(pItemInfo.SubCode),
		Name = pItemInfo.Name,
		EnchantCode = tonumber(pItemInfo.EnchantCode),
		JewelCode1 = tonumber(pItemInfo.JewelCode1),
		JewelCode2 = tonumber(pItemInfo.JewelCode2),
		JewelCode3 = tonumber(pItemInfo.JewelCode3),
		JewelCode4 = tonumber(pItemInfo.JewelCode4),
		UniqueID = tonumber(pItemInfo.UniqueID),
		InvType = pItemInfo.InvType,
		SubType = pItemInfo.SubType,
		Link = pItemInfo.Link,
		Quality = pItemInfo.Quality,
		Level = pItemInfo.Level,
		BagType = pItemInfo.BagType,
	}
	
	Outfitter.DisplayIsDirty = true
end

function Outfitter._OutfitMethods:SetItem(pSlotName, pItemInfo)
	self.Items[pSlotName] = pItemInfo
	Outfitter.DisplayIsDirty = true
end

function Outfitter._OutfitMethods:GetItem(pSlotName)
	return self.Items[pSlotName]
end

function Outfitter._OutfitMethods:RemoveItem(pSlotName)
	self.Items[pSlotName] = nil
	Outfitter.DisplayIsDirty = true
end

function Outfitter._OutfitMethods:GetItems()
	return self.Items
end

function Outfitter._OutfitMethods:AdjustOffhandSlot()
	if self.Items.MainHandSlot
	and Outfitter:ItemUsesBothWeaponSlots(self.Items.MainHandSlot) then
		self.Items.SecondaryHandSlot = Outfitter:NewEmptyItemInfo()
	end
end

function Outfitter._OutfitMethods:SlotIsEnabled(pSlotName)
	return self.Items[pSlotName] ~= nil
end

function Outfitter._OutfitMethods:SlotIsEquipped(pSlotName, pInventoryCache)
	local vOutfitItem = self.Items[pSlotName]
	
	if not vOutfitItem then
		return false
	end
	
	return pInventoryCache:InventorySlotContainsItem(pSlotName, vOutfitItem)
end
--[[
function Outfitter._OutfitMethods:HasCombatEquipmentSlots()
	for vEquipmentSlot, _ in pairs(Outfitter.cCombatEquipmentSlots) do
		if self.Items[vEquipmentSlot] then
			return true
		end
	end
	
	return false
end

function Outfitter._OutfitMethods:OnlyHasCombatEquipmentSlots()
	for vEquipmentSlot, _ in pairs(self.Items) do
		if not Outfitter.cCombatEquipmentSlots[vEquipmentSlot] then
			return false
		end
	end
	
	return true
end
]]
function Outfitter._OutfitMethods:IsComplete(pIgnoreAmmoSlot)
	for _, vInventorySlot in ipairs(Outfitter.cSlotNames) do
		if not self.Items[vInventorySlot]
		and vInventorySlot ~= "AmmoSlot" then
		-- and (not pIgnoreAmmoSlot or vInventorySlot ~= "AmmoSlot") then
			return false
		end
	end
	
	return true
end

function Outfitter._OutfitMethods:CalculateOutfitCategory()
	return self:IsComplete(UnitHasRelicSlot("player")) and "Complete" or "Accessory"
end

Outfitter._OutfitMethods.DefaultRepairValues =
{
	Code = 0,
	SubCode = 0,
	Name = "",
	EnchantCode = 0,
	JewelCode1 = 0,
	JewelCode2 = 0,
	JewelCode3 = 0,
	JewelCode4 = 0,
	UniqueID = 0,
}

function Outfitter._OutfitMethods:CheckOutfit(pCategoryID)
	if not self:GetName() then
		self:SetName("Damaged outfit")
	end
	
	if self.CategoryID ~= pCategoryID then
		self.CategoryID = pCategoryID
	end
	
	if not self.Items then
		self.Items = {}
	end
	
	for vInventorySlot, vItem in pairs(self.Items) do
		for vField, vDefaultValue in pairs(self.DefaultRepairValues) do
			if not vItem[vField] then
				vItem[vField] = vDefaultValue
			end
		end
	end
end

function Outfitter._OutfitMethods:UpdateInvTypes(pInventoryCache)
	local vResult = true
	
	for vInventorySlot, vOutfitItem in pairs(self.Items) do
		if vOutfitItem.Code ~= 0 then
			local vItem = pInventoryCache:FindItemOrAlt(vOutfitItem, false, true)
			
			if vItem then
				vOutfitItem.InvType = vItem.InvType
			else
				vResult = false
			end
		end
	end
	
	return vResult
end

function Outfitter._OutfitMethods:UpdateSubTypes(pInventoryCache)
	local vResult = true
	
	for vInventorySlot, vOutfitItem in pairs(self.Items) do
		if vOutfitItem.Code ~= 0 then
			local vItem = pInventoryCache:FindItemOrAlt(vOutfitItem, false, true)
			
			if vItem then
				vOutfitItem.SubType = vItem.SubType
			else
				vResult = false
			end
		end
	end
	
	return vResult
end

function Outfitter._OutfitMethods:UpdateDatabaseItemCodes(pInventoryCache)
	local vResult = true
	
	for vInventorySlot, vOutfitItem in pairs(self.Items) do
		if vOutfitItem.Code ~= 0 then
			local vItem = vInventoryCache:FindItemOrAlt(vOutfitItem, false, true)
			
			if vItem then
				vOutfitItem.SubCode = vItem.SubCode
				vOutfitItem.Name = vItem.Name
				vOutfitItem.EnchantCode = vItem.EnchantCode
				vOutfitItem.JewelCode1 = vItem.JewelCode1
				vOutfitItem.JewelCode2 = vItem.JewelCode2
				vOutfitItem.JewelCode3 = vItem.JewelCode3
				vOutfitItem.JewelCode4 = vItem.JewelCode4
				vOutfitItem.UniqueID = vItem.UniqueID
				vOutfitItem.Checksum = nil
			else
				vResult = false
			end
		end
	end
	
	return vResult
end

function Outfitter._OutfitMethods:OutfitUsesItem(pItemInfo)
	local vInventoryCache = Outfitter:GetInventoryCache(false)
	local vItemInfo, vItemInfo2
	
	if pItemInfo.ItemSlotName == "Finger0Slot" then
		vItemInfo = self.Items.Finger0Slot
		vItemInfo2 = self.Items.Finger1Slot
	
	elseif pItemInfo.ItemSlotName == "Trinket0Slot" then
		vItemInfo = self.Items.Trinket0Slot
		vItemInfo2 = self.Items.Trinket1Slot
	
	elseif Outfitter:GetItemMetaSlot(pItemInfo) == "Weapon0Slot" then
		vItemInfo = self.Items.MainHandSlot
		vItemInfo2 = self.Items.SecondaryHandSlot
	
	else
		vItemInfo = self.Items[pItemInfo.ItemSlotName]
	end
	
	return (vItemInfo and vInventoryCache:ItemsAreSame(vItemInfo, pItemInfo))
	    or (vItemInfo2 and vInventoryCache:ItemsAreSame(vItemInfo2, pItemInfo))
end

function Outfitter._OutfitMethods:StoreOnServer()
	-- Just leave if there's no room
	
	if GetNumEquipmentSets() >= MAX_EQUIPMENT_SETS_PER_PLAYER then
		StaticPopup_Show("OUTFITTER_SERVER_FULL", MAX_EQUIPMENT_SETS_PER_PLAYER)		
		return
	end
	
	-- Remember the selected icon
	
	local vTexture = Outfitter.OutfitBar:GetOutfitTexture(self)
	local vIconIndex = Outfitter:GetIconIndex(vTexture)
	
	if not vIconIndex then
		vIconIndex = -1 -- Use the helm icon, better would be to pick the first enabled slot
	end
	
	-- Create the outfit object
	
	local vOutfitEM =
	{
		Name = self.Name,
		StoredInEM = true,
		Items = {},
	}
	
	if vOutfitEM.Name:len() > 31 then
		vOutfitEM.Name = vOutfitEM.Name:sub(1, 31)
	end
	
	setmetatable(vOutfitEM, Outfitter._OutfitMetaTableEM)
	
	-- Create the new outfit in the EM
	
	vOutfitEM:MarkEnabledSlots()
	vOutfitEM:SaveEquipmentSet(vOutfitEM.Name, vIconIndex)
	
	-- Copy the script
	
	vOutfitEM.Script = self.Script
	vOutfitEM.ScriptID = self.ScriptID
	vOutfitEM.StatID = self.StatID
	
	-- Add the new outfit and remove the old one
	
	Outfitter:AddOutfit(vOutfitEM)
	Outfitter:WearOutfit(vOutfitEM)
	Outfitter:SelectOutfit(vOutfitEM)
	
	Outfitter:DeleteOutfit(self)
	
	-- Done
	
	Outfitter.DisplayIsDirty = true
	Outfitter:Update(true)
end

function Outfitter._OutfitMethods:GetMissingItems(pInventoryCache)
	local vMissingItems = nil
	local vBankedItems = nil
	
	local vItems = self:GetItems()
	
	for vInventorySlot, vOutfitItem in pairs(vItems) do
		if vOutfitItem.Code ~= 0 then
			local vItem = pInventoryCache:FindItemOrAlt(vOutfitItem)
			
			if not vItem then
				if not vMissingItems then
					vMissingItems = {}
				end
				
				table.insert(vMissingItems, vOutfitItem)
			elseif Outfitter:IsBankBagIndex(vItem.Location.BagIndex) then
				if not vBankedItems then
					vBankedItems = {}
				end
				
				table.insert(vBankedItems, vOutfitItem)
			end
		end
	end
	
	return vMissingItems, vBankedItems
end

----------------------------------------
Outfitter._OutfitMethodsEM = {}
Outfitter._OutfitMetaTableEM = {__index = Outfitter._OutfitMethodsEM}
----------------------------------------

function Outfitter._OutfitMethodsEM:Delete()
	DeleteEquipmentSet(self.Name)
end

function Outfitter._OutfitMethodsEM:GetName()
	return self.Name
end

function Outfitter._OutfitMethodsEM:SetName(pName)
	RenameEquipmentSet(self.Name, pName) 
	
	self.Name = pName
	
	Outfitter.DisplayIsDirty = true
end

function Outfitter._OutfitMethodsEM:GetIcon()
	local vIcon = GetEquipmentSetInfoByName(self.Name)
	
	if not vIcon then
		return "Interface\\Icons\\INV_Chest_Cloth_21"
	end
	
	return "Interface\\Icons\\"..vIcon
end

function Outfitter._OutfitMethodsEM:SetIcon(pTexture)
	if not self:IsFullyEquipped() then
		StaticPopupDialogs.OUTFITTER_CANT_SET_ICON.OnAccept = function ()
			self:SetIcon2(pTexture)
		end
		
		StaticPopup_Show("OUTFITTER_CANT_SET_ICON", tostring(self.Name))		
	else
		self:SetIcon2(pTexture)
	end
end

function Outfitter._OutfitMethodsEM:SetIcon2(pTexture)
	local vIndex = Outfitter:GetIconIndex(pTexture)
	
	if not vIndex then
		return
	end
	
	self:MarkSlotsToIgnore()
	self:SaveEquipmentSet(self.Name, vIndex)
end

function Outfitter._OutfitMethodsEM:IsFullyEquipped()
	local vLocations = GetEquipmentSetLocations(self.Name)
	
	if not vLocations then
		return false
	end
	
	for vSlotID, vLocation in pairs(vLocations) do
		if vLocation
		and vLocation ~= 0 -- Empty slot
		and vLocation ~= 1 then -- Ignored slot
			local vOnPlayer, vInBank, vInBags, vSlotIndex, vBagIndex = self:UnpackLocation(vLocation)
			
			if not vOnPlayer then
				return false
			end
		end
	end
	
	return true
end

function Outfitter._OutfitMethodsEM:GetIconIndex()
	local vTexture = GetEquipmentSetInfoByName(self.Name)
	
	return Outfitter:GetIconIndex(vTexture) or 1
end

function Outfitter._OutfitMethodsEM:MarkSlotsToIgnore()
	EquipmentManagerClearIgnoredSlotsForSave()
	
	for vSlotName, vSlotID in pairs(Outfitter.cSlotIDs) do
		if not self:SlotIsEnabled(vSlotName)
		and vSlotName ~= "AmmoSlot" then
			EquipmentManagerIgnoreSlotForSave(vSlotID)
		end
	end
end

function Outfitter._OutfitMethodsEM:SetToCurrentInventory()
	Outfitter:DebugMessage("OutfitMethodsEM:SetToCurrentInventory()")
	
	self:MarkSlotsToIgnore()
	self:SaveEquipmentSet(self.Name, self:GetIconIndex())
end

function Outfitter._OutfitMethodsEM:AddNewItems(pNewItems)
	if Outfitter.Debug.NewItems then
		Outfitter:DebugTable(pNewItems, "AddNewItems", 2)
	end
	
	self:MarkSlotsToIgnore()
	
	for vInventorySlot, vNewItem in pairs(pNewItems) do
		-- Only update slots which aren't in an unknown state
		
		local vCheckbox = _G["OutfitterEnable"..vInventorySlot]
		
		if (not vCheckbox:GetChecked()
		or not vCheckbox.IsUnknown)
		and vInventorySlot ~= "AmmoSlot" then
			EquipmentManagerUnignoreSlotForSave(Outfitter.cSlotIDs[vInventorySlot])
			Outfitter:NoteMessage(Outfitter.cAddingItem, vNewItem.Name, self:GetName())
		end
		
		-- Add the new items to the current compiled outfit
		
		Outfitter.ExpectedOutfit:SetItem(vInventorySlot, vNewItem)
	end
	
	self:SaveEquipmentSet(self.Name, self:GetIconIndex())
end

function Outfitter._OutfitMethodsEM:MarkEnabledSlots()
	EquipmentManagerClearIgnoredSlotsForSave()
	
	for vSlotName, vSlotID in pairs(Outfitter.cSlotIDs) do
		local vCheckbox = _G["OutfitterEnable"..vSlotName]
		
		if vCheckbox:GetChecked()
		and not vCheckbox.IsUnknown then
			-- SaveEquipmentSet will pick it up
		elseif vSlotName ~= "AmmoSlot" then
			EquipmentManagerIgnoreSlotForSave(vSlotID)
		end
	end
end

function Outfitter._OutfitMethodsEM:IsEmpty()
	self.ItemLocations = GetEquipmentSetLocations(self.Name)
	
	for _, vLocation in pairs(self.ItemLocations) do
		return false
	end
	
	return true
end

function Outfitter._OutfitMethodsEM:IsAmmoOnly()
	local vHasAmmoItem = false
	
	self.ItemLocations = GetEquipmentSetLocations(self.Name)
	
	for vSlotID, vLocation in pairs(self.ItemLocations) do
		if vSlotID ~= Outfitter.cSlotIDs.AmmoSlot then
			return false
		else
			vHasAmmoItem = true
		end
	end
	
	return vHasAmmoItem
end

function Outfitter._OutfitMethodsEM:SetItems(pItems)
	self:CancelTemporaryItems()
	
	self.TemporaryItems = pItems
	Outfitter.EventLib:RegisterEvent("OUTFITTER_SWAP_COMPLETE", self.SetItemsSwapComplete, self)
	
	Outfitter:WearOutfit(self)
	
	Outfitter:InventoryChanged()
	
	Outfitter.DisplayIsDirty = true
end

function Outfitter._OutfitMethodsEM:SetItemsSwapComplete()
	self:CancelTemporaryItems()
	self:SetToCurrentInventory()
	
	Outfitter:NoteMessage("Saved outfit to Equipment Manager")
end

function Outfitter._OutfitMethodsEM:CancelTemporaryItems()
	if not self.TemporaryItems then
		return
	end
	
	self.TemporaryItems = nil
	Outfitter.EventLib:UnregisterEvent("OUTFITTER_SWAP_COMPLETE", self.SetItemsSwapComplete, self)
end

function Outfitter._OutfitMethodsEM:SetInventoryItem(pSlotName)
	if pSlotName == "AmmoSlot" then
		return
	end
	
	self:CancelTemporaryItems()
	
	self:MarkSlotsToIgnore()
	EquipmentManagerUnignoreSlotForSave(Outfitter.cSlotIDs[pSlotName])
	
	local vIconIndex = self:GetIconIndex()
	
	self:SaveEquipmentSet(self.Name, vIconIndex)
	Outfitter.DisplayIsDirty = true
end

function Outfitter._OutfitMethodsEM:EnableAllSlots()
	self:CancelTemporaryItems()
	
	EquipmentManagerClearIgnoredSlotsForSave()
	
	self:SaveEquipmentSet(self.Name, self:GetIconIndex())
	
	Outfitter.DisplayIsDirty = true
end

function Outfitter._OutfitMethodsEM:DisableAllSlots()
	self:CancelTemporaryItems()
	
	EquipmentManagerClearIgnoredSlotsForSave()
	
	for _, vSlotName in ipairs(Outfitter.cSlotNames) do
		if vSlotName ~= "AmmoSlot" then
			EquipmentManagerIgnoreSlotForSave(Outfitter.cSlotIDs[vSlotName])
		end
	end
	
	self:SaveEquipmentSet(self.Name, self:GetIconIndex())
	
	Outfitter.DisplayIsDirty = true
end

function Outfitter._OutfitMethodsEM:RemoveItem(pSlotName)
	self:MarkSlotsToIgnore()
	EquipmentManagerIgnoreSlotForSave(Outfitter.cSlotIDs[pSlotName])
	
	self:SaveEquipmentSet(self.Name, self:GetIconIndex())
	Outfitter.DisplayIsDirty = true
end

function Outfitter._OutfitMethodsEM:AddItem(pSlotName, pItemInfo)
	error("Not implemented")
	Outfitter.DisplayIsDirty = true
end

function Outfitter._OutfitMethodsEM:SetItem(pSlotName, pItemInfo)
	error("Not implemented")
	Outfitter.DisplayIsDirty = true
end

function Outfitter._OutfitMethodsEM:GetItem(pSlotName)
	if self.TemporaryItems then
		return self.TemporaryItems[pSlotName]
	else
		return self:GetItemEM(pSlotName, GetEquipmentSetLocations(self.Name))
	end
end

function Outfitter._OutfitMethodsEM:UnpackLocation(pLocation)
	local vOnPlayer, vInBank, vInBags, vSlotIndex, vBagIndex = EquipmentManager_UnpackLocation(pLocation)
	
	if vInBags
	and Outfitter:IsBankBagIndex(vBagIndex) then
		vInBags = false
		vInBank = true
	end
	
	if vInBags then
		vOnPlayer = false
		vInBank = false
	elseif vInBank then
		vOnPlayer = false
		
		if not vBagIndex then
			vBagIndex = -1
		end
	end
	
	return vOnPlayer, vInBank, vInBags, vSlotIndex, vBagIndex
end

function Outfitter._OutfitMethodsEM:GetItemEM(pSlotName, pLocations)
	if not pLocations then
		Outfitter:DebugMessage("GetItemEM: No locations for %s", tostring(self.Name))
		return
	end
	
	local vLocation = pLocations[Outfitter.cSlotIDs[pSlotName]]
	
	if not vLocation
	or vLocation == 1 then
		return
	end
	
	local vItemInfo = self.Items and self.Items[pSlotName]
	
	if vLocation == 0 then
		if not vItemInfo
		or vItemInfo.Code ~= 0 then
			vItemInfo = {Code = 0} -- this slot is emptied on equip
		end
	else
		local vOnPlayer, vInBank, vInBags, vSlotIndex, vBagIndex = self:UnpackLocation(vLocation)
		
		if Outfitter.Debug.NewItems then
			Outfitter:DebugMessage("%s:GetItemEM: %s OnPlayer=%s, InBank=%s, InBags=%s, SlotIndex=%s, BagIndex=%s", tostring(self.Name), tostring(vLocation), tostring(vOnPlayer), tostring(vInBank), tostring(vInBags), tostring(vSlotIndex), tostring(vBagIndex))
		end
		
		if vOnPlayer then
			vItemInfo = Outfitter:GetInventoryItemInfo(Outfitter.cSlotIDToInventorySlot[vSlotIndex])
		elseif vInBank then
			if vBagIndex == -1 then
				vItemInfo = Outfitter:GetSlotIDItemInfo(vSlotIndex)
			else
				vItemInfo = Outfitter:GetBagItemInfo(vBagIndex, vSlotIndex)
			end
		elseif vInBags then
			vItemInfo = Outfitter:GetBagItemInfo(vBagIndex, vSlotIndex)
		else -- missing
			vItemInfo = self.Items[pSlotName]
		end
		
		if Outfitter.Debug.NewItems and vItemInfo then
			Outfitter:DebugMessage("%s:GetItemEM: %s has item %s", tostring(self.Name), pSlotName, tostring(vItemInfo.Link))
		end
	end
	
	self.Items[pSlotName] = vItemInfo
	
	return vItemInfo
end

function Outfitter:DumpEMOutfitLocations(pName)
	local vLocations = GetEquipmentSetLocations(pName)
	
	for vSlotID, vLocation in pairs(vLocations) do
		local vSlotName = Outfitter.cSlotIDToInventorySlot[vSlotID]
		local vOnPlayer, vInBank, vInBags, vSlotIndex, vBagIndex = Outfitter._OutfitMethodsEM:UnpackLocation(vLocation)
		
		self:DebugMessage("%s (%s): Location=%s OnPlayer=%s, InBank=%s, InBags=%s, SlotIndex=%s, BagIndex=%s", vSlotName, vSlotID, tostring(vLocation), tostring(vOnPlayer), tostring(vInBank), tostring(vInBags), tostring(vSlotIndex), tostring(vBagIndex))
	end
end


function Outfitter._OutfitMethodsEM:GetItems()
	if self.TemporaryItems then
		return self.TemporaryItems
	end
	
	self.ItemLocations = GetEquipmentSetLocations(self.Name)
	
	if not self.ItemLocations then
		Outfitter:ErrorMessage("Couldn't get item locations for %s", tostring(self.Name))
		return
	end
	
	for vSlotID, vSlotName in pairs(Outfitter.cSlotIDToInventorySlot) do
		self.Items[vSlotName] = self:GetItemEM(vSlotName, self.ItemLocations)
	end
	
	return self.Items
end

function Outfitter._OutfitMethodsEM:SlotIsEnabledEM(pSlotName, pItemLocations)
	if pSlotName == "AmmoSlot" then
		return false
	end
	
	local vLocation = pItemLocations[Outfitter.cSlotIDs[pSlotName]]
	
	return vLocation and vLocation ~= 1
end

function Outfitter._OutfitMethodsEM:SlotIsEnabled(pSlotName)
	if self.TemporaryItems then
		return self.TemporaryItems[pSlotName] ~= nil
	end
	
	return self:SlotIsEnabledEM(pSlotName, GetEquipmentSetLocations(self.Name))
end

function Outfitter._OutfitMethodsEM:SlotIsEquipped(pSlotName, pInventoryCache)
	local vLocations = GetEquipmentSetLocations(self.Name)
	local vLocation = vLocations[Outfitter.cSlotIDs[pSlotName]]
	
	if not vLocation
	or vLocation == 1
	or pSlotName == "AmmoSlot" then
		return false
	end
	
	if vLocation == 0 then
		return pInventoryCache.InventoryItems[pSlotName] == nil
	end
	
	local vOnPlayer, vInBank, vInBags = self:UnpackLocation(vLocation)
	
	return vOnPlayer and not vInBank and not vInBags
end
--[[
function Outfitter._OutfitMethodsEM:HasCombatEquipmentSlots()
	if self.TemporaryItems then
		for vEquipmentSlot, _ in pairs(Outfitter.cCombatEquipmentSlots) do
			if self.TemporaryItems[vEquipmentSlot] then
				return true
			end
		end
		
		return false
	end
	
	--
	
	local vLocations = GetEquipmentSetLocations(self.Name)
	
	for vEquipmentSlot, _ in pairs(Outfitter.cCombatEquipmentSlots) do
		if self:SlotIsEnabledEM(vEquipmentSlot, vLocations) then
			return true
		end
	end
	
	return false
end

function Outfitter._OutfitMethodsEM:OnlyHasCombatEquipmentSlots()
	if self.TemporaryItems then
		for vEquipmentSlot, _ in pairs(self.TemporaryItems) do
			if not Outfitter.cCombatEquipmentSlots[vEquipmentSlot] then
				return false
			end
		end
		
		return true
	end
	
	--
	
	local vLocations = GetEquipmentSetLocations(self.Name)
	
	for vSlotName, vSlotID in pairs(Outfitter.cSlotIDs) do
		if self:SlotIsEnabledEM(vSlotName, vLocations)
		and not Outfitter.cCombatEquipmentSlots[vSlotName] then
			return false
		end
	end
	
	return true
end
]]
function Outfitter._OutfitMethodsEM:IsComplete(pIgnoreAmmoSlot)
	if self.TemporaryItems then
		for _, vInventorySlot in ipairs(Outfitter.cSlotNames) do
			if not self.TemporaryItems[vInventorySlot]
			and (not pIgnoreAmmoSlot or vInventorySlot ~= "AmmoSlot") then
				-- If it's the offhand slot and there's a 2H weapon in the mainhand
				-- then ignore the fact that it's empty
				
				if vInventorySlot == "SecondaryHandSlot"
				or not self.TemporaryItems.MainHandSlot
				or self.TemporaryItems.MainHandSlot.InvType ~= "INVTYPE_2HWEAPON" then
					return false
				end
			end
		end
		
		return true
	end
	
	--
	
	local vLocations = GetEquipmentSetLocations(self.Name)
	
	if not vLocations then
		return false
	end
	
	for vSlotName, vSlotID in pairs(Outfitter.cSlotIDs) do
		if vSlotName ~= "AmmoSlot"
		and not self:SlotIsEnabledEM(vSlotName, vLocations) then
			-- If it's the offhand slot and there's a 2H weapon in the mainhand
			-- then ignore the fact that it's empty
			
			if vSlotName ~= "SecondaryHandSlot" then
				return false
			end
			
			local vMainHandItem = self:GetItemEM("MainHandSlot", vLocations)
			
			if not vMainHandItem
			or vMainHandItem.InvType ~= "INVTYPE_2HWEAPON" then
				return false
			end
		end
	end
	
	return true
end

function Outfitter._OutfitMethodsEM:CalculateOutfitCategory()
	return self:IsComplete(UnitHasRelicSlot("player")) and "Complete" or "Accessory"
end

function Outfitter._OutfitMethodsEM:CheckOutfit(pCategoryID)
	if not self.Items then
		self.Items = {}
	end
end

function Outfitter._OutfitMethodsEM:UpdateInvTypes(pInventoryCache)
	return true
end

function Outfitter._OutfitMethodsEM:UpdateSubTypes(pInventoryCache)
	return true
end

function Outfitter._OutfitMethodsEM:UpdateDatabaseItemCodes(pInventoryCache)
	return true
end

function Outfitter._OutfitMethodsEM:LocationsEqual(pOutfitterLocation, pEMLocation)
	local vOnPlayer, vInBank, vInBags, vSlotIndex, vBagIndex = self:UnpackLocation(pEMLocation)
	
	if vOnPlayer then
		return vSlotIndex == pOutfitterLocation.SlotID
	elseif vInBank then
		return pOutfitterLocation.BagIndex == vBagIndex
		   and pOutfitterLocation.BagSlotIndex == vSlotIndex
	elseif vInBags then
		return pOutfitterLocation.BagIndex == vBagIndex
		   and pOutfitterLocation.BagSlotIndex == vSlotIndex
	else
		return false
	end
end

function Outfitter._OutfitMethodsEM:OutfitUsesItem(pItemInfo)
	local vInventoryCache = Outfitter:GetInventoryCache(false)
	local vItemInfo, vItemInfo2
	
	if pItemInfo.ItemSlotName == "Finger0Slot" then
		vItemInfo = self:GetItem("Finger0Slot")
		vItemInfo2 = self:GetItem("Finger1Slot")
	
	elseif pItemInfo.ItemSlotName == "Trinket0Slot" then
		vItemInfo = self:GetItem("Trinket0Slot")
		vItemInfo2 = self:GetItem("Trinket1Slot")
	
	elseif Outfitter:GetItemMetaSlot(pItemInfo) == "Weapon0Slot" then
		vItemInfo = self:GetItem("MainHandSlot")
		vItemInfo2 = self:GetItem("SecondaryHandSlot")
	
	else
		vItemInfo = self:GetItem(pItemInfo.ItemSlotName)
	end
	
	--Outfitter:DebugTable(pItemInfo, "pItemInfo")
	--Outfitter:DebugTable(vItemInfo, "vItemInfo")
	--Outfitter:DebugTable(vItemInfo2, "vItemInfo2")
	
	return (vItemInfo and vInventoryCache:ItemsAreSame(vItemInfo, pItemInfo))
	    or (vItemInfo2 and vInventoryCache:ItemsAreSame(vItemInfo2, pItemInfo))
end

function Outfitter._OutfitMethodsEM:SaveEquipmentSet(pName, pIconIndex)
	if Outfitter.Debug.NewItems then
		Outfitter:TestMessage("%s:SaveEquipmentSet()", pName)
		Outfitter:DebugStack()
	end
	
	if not pIconIndex then
		pIconIndex = -1
	end
	
	Outfitter.EventLib:UnregisterEvent("EQUIPMENT_SETS_CHANGED", Outfitter.SynchronizeEM, Outfitter)
	SaveEquipmentSet(pName, pIconIndex)
	Outfitter.EventLib:RegisterEvent("EQUIPMENT_SETS_CHANGED", Outfitter.SynchronizeEM, Outfitter)
end

function Outfitter._OutfitMethodsEM:StoreLocally()
	-- Clone the outfit
	
	local vOutfit = Outfitter:NewEmptyOutfit(self.Name)
	
	vOutfit:SetItems(Outfitter:DuplicateTable(self:GetItems(), true))
	vOutfit:SetIcon(self:GetIcon())
	
	vOutfit.Script = self.Script
	vOutfit.ScriptID = self.ScriptID
	vOutfit.ScriptSettings = Outfitter:DuplicateTable(self.ScriptSettings, true)
	vOutfit.StatID = self.StatID
	vOutfit.UnequipOthers = self.UnequipOthers
	
	-- Add the new outfit and remove the old one
	
	Outfitter:AddOutfit(vOutfit)
	Outfitter:WearOutfit(vOutfit)
	Outfitter:SelectOutfit(vOutfit)
	
	Outfitter:DeleteOutfit(self)
	
	-- Done
	
	Outfitter.DisplayIsDirty = true
	Outfitter:Update(true)
end

function Outfitter._OutfitMethodsEM:GetMissingItems(pInventoryCache)
	local vMissingItems = nil
	local vBankedItems = nil
	
	local vLocations = GetEquipmentSetLocations(self.Name)
	
	if not vLocations then
		return
	end
	
	for vSlotID, vLocation in pairs(vLocations) do
		local vSlotName = Outfitter.cSlotIDToInventorySlot[vSlotID]
		local vOutfitItem = self.Items[vSlotName]
		
		if vOutfitItem
		and vLocation
		and vLocation ~= 0 -- Empty slot
		and vLocation ~= 1 then -- Ignored slot
			local vOnPlayer, vInBank, vInBags, vSlotIndex, vBagIndex = self:UnpackLocation(vLocation)
			
			if vInBank then
				if not vBankedItems then
					vBankedItems = {}
				end
				
				table.insert(vBankedItems, vOutfitItem)
			elseif not vOnPlayer and not vInBags then
				if not vMissingItems then
					vMissingItems = {}
				end
				
				table.insert(vMissingItems, vOutfitItem)
			end
		end
	end
	
	return vMissingItems, vBankedItems
end

