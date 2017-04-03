----------------------------------------
-- General
----------------------------------------

function Outfitter:FindNextCooldownItem(pItemCodes, pIgnoreSwapCooldown)
	local vInventoryCache = self:GetInventoryCache()
	local vBestItem, vBestTime
	
	for _, vItemCode in ipairs(pItemCodes) do
		if type(vItemCode) == "string" then
			local vItemName, vItemLink = GetItemInfo(vItemCode)
			
			if vItemLink then
				vItemCode = self:ParseItemLink(vItemLink)
			end
		end
		
		local vItems = vItemCode and vInventoryCache.ItemsByCode[vItemCode]
		
		if vItems then
			for _, vItemInfo in ipairs(vItems) do
				local vStart, vDuration, vEnabled
				
				if vItemInfo.Location.BagIndex then
					vStart, vDuration, vEnabled = GetContainerItemCooldown(vItemInfo.Location.BagIndex, vItemInfo.Location.BagSlotIndex)
				elseif vItemInfo.Location.SlotID then
					vStart, vDuration, vEnabled = GetInventoryItemCooldown("player", vItemInfo.Location.SlotID)
				end
				
				local vRemainingTime
				
				if vEnabled == 1 and vStart ~= 0 then
					local vElapsed = GetTime() - vStart
					vRemainingTime = vDuration - vElapsed
				elseif self:ItemHasUseFeature(vItemInfo.Link) then
					vRemainingTime = 0
				else
					vRemainingTime = 30 -- Items without a /use are just considered to be 30 secs so that they have lowest priority
				end
				
				-- If it's in the bag then the minimum is 30 secs
				
				if vItemInfo.Location.BagIndex
				and not pIgnoreSwapCooldown
				and vRemainingTime < 30 then
					vRemainingTime = 30
				end
				
				-- Compare it to the current result
				
				if not vBestTime or vRemainingTime < vBestTime then
					vBestItem = vItemInfo
					vBestTime = vRemainingTime
				end
			end
		end
	end
	
	return vBestItem, vBestTime
end

function Outfitter:InventorySlotIsEmpty(pInventorySlot)
	return GetInventoryItemTexture("player", self.cSlotIDs[pInventorySlot]) == nil
end

function Outfitter:GetBagItemInfo(pBagIndex, pSlotIndex)
	local vItemLink = GetContainerItemLink(pBagIndex, pSlotIndex)
	local vItemInfo = self:GetItemInfoFromLink(vItemLink)
	
	if not vItemInfo then
		return nil
	end
	
	vItemInfo.Texture = GetContainerItemInfo(pBagIndex, pSlotIndex)
	
	vItemInfo.Gem1, vItemInfo.Gem2, vItemInfo.Gem3 = GetContainerItemGems(pBagIndex, pSlotIndex)
	
	vItemInfo.Location = {BagIndex = pBagIndex, BagSlotIndex = pSlotIndex}
	
	return vItemInfo
end

function Outfitter:GetBagItemLinkInfo(pBagIndex, pSlotIndex)
	local vItemLink = GetContainerItemLink(pBagIndex, pSlotIndex)
	
	if not vItemLink then
		return
	end
	
	return self:ParseItemLink(vItemLink)
end

function Outfitter:GetExtendedBagItemLinkInfo(pBagIndex, pSlotIndex)
	local vItemLink = GetContainerItemLink(pBagIndex, pSlotIndex)
	
	if not vItemLink then
		return
	end
	
	local vItemCode,
	      vItemEnchantCode,
	      vItemJewelCode1,
	      vItemJewelCode2,
	      vItemJewelCode3,
	      vItemJewelCode4,
	      vItemSubCode,
	      vItemUniqueID,
	      vItemUnknownCode1,
	      vItemName = self:ParseItemLink(vItemLink)
	
	if not vItemCode then
		return
	end
	
	local vItemFamilyName,
	      vItemLink,
	      vItemQuality,
	      vItemLevel,
	      vItemMinLevel,
	      vItemType,
	      vItemSubType,
	      vItemCount,
	      vItemInvType = GetItemInfo(vItemCode)
	
	return vItemCode,
	      vItemEnchantCode,
	      vItemJewelCode1,
	      vItemJewelCode2,
	      vItemJewelCode3,
	      vItemJewelCode4,
	      vItemSubCode,
	      vItemUniqueID,
	      vItemUnknownCode1,
	      vItemName,
	      vItemFamilyName,
	      vItemLink,
	      vItemQuality,
	      vItemLevel,
	      vItemMinLevel,
	      vItemType,
	      vItemSubType,
	      vItemCount,
	      vItemInvType
end

function Outfitter:GetItemLocationBagType(pItemLocation)
	if not pItemLocation then
		return
	end
	
	if pItemLocation.BagIndex then
		return self:GetBagItemBagType(pItemLocation.BagIndex, pItemLocation.BagSlotIndex)
	elseif pItemLocation.SlotName then
		return self:GetSlotIDItemBagType(self.cSlotIDs[pItemLocation.SlotName])
	else
		self:ErrorMessage("Unknown location in GetItemLocationBagType")
		return
	end
end

function Outfitter:GetBagItemBagType(pBagIndex, pSlotIndex)
	local vItemCode = self:GetBagItemLinkInfo(pBagIndex, pSlotIndex)
	
	if not vItemCode then
		return
	end
	
	return GetItemFamily(vItemCode)
end

function Outfitter:GetSlotIDLinkInfo(pSlotID)
	return self:ParseItemLink(self:GetInventorySlotIDLink(pSlotID))
end

function Outfitter:GetSlotIDItemBagType(pSlotID)
	local vItemCode = self:GetSlotIDLinkInfo(pSlotID)
	
	if not vItemCode then
		return
	end
	
	return GetItemFamily(vItemCode)
end

function Outfitter:ParseItemLink(pItemLink)
	if not pItemLink then
		return
	end
	
	local vStartIndex, vEndIndex, vItemCode, vItemEnchantCode,
	      vItemJewelCode1, vItemJewelCode2, vItemJewelCode3, vItemJewelCode4,
	      vItemSubCode, vItemUniqueID, vItemUnknownCode1, vItemUnknownCode2,
	      vItemName
	
	if self.IsWoW4 then
		vStartIndex, vEndIndex, vItemCode, vItemEnchantCode,
		vItemJewelCode1, vItemJewelCode2, vItemJewelCode3, vItemJewelCode4,
		vItemSubCode, vItemUniqueID, vItemUnknownCode1, vItemUnknownCode2,
		vItemName = pItemLink:find(self.cItemLinkFormat)
	else
		vStartIndex, vEndIndex, vItemCode, vItemEnchantCode,
		vItemJewelCode1, vItemJewelCode2, vItemJewelCode3, vItemJewelCode4,
		vItemSubCode, vItemUniqueID, vItemUnknownCode1,
		vItemName = pItemLink:find(self.cItemLinkFormat)
	end
	
	if not vStartIndex then
		self:DebugMessage("ParseItemLink: Pattern didn't match")
		self:DebugMessage(pItemLink:gsub("|", "\\"))
		self:DebugMessage(self.cItemLinkFormat:gsub("|", "\\"))
		return
	end
	
	return tonumber(vItemCode),
	       tonumber(vItemEnchantCode),
	       tonumber(vItemJewelCode1),
	       tonumber(vItemJewelCode2),
	       tonumber(vItemJewelCode3),
	       tonumber(vItemJewelCode4),
	       tonumber(vItemSubCode),
	       tonumber(vItemUniqueID),
	       tonumber(vItemUnknownCode1),
	       vItemName
end

function Outfitter:GetItemInfoFromLink(pItemLink)
	if not pItemLink then
		return nil
	end
	
	-- |cff1eff00|Hitem:1465:803:0:0:0:0:0:0|h[Tigerbane]|h|r
	-- |(hex code for item color)|Hitem:(item ID code):(enchant code):(added stats code):0|h[(item name)]|h|r
	
	local vItemCode,
	      vItemEnchantCode,
	      vItemJewelCode1,
	      vItemJewelCode2,
	      vItemJewelCode3,
	      vItemJewelCode4,
	      vItemSubCode,
	      vItemUniqueID,
	      vItemUnknownCode1,
	      vItemName = self:ParseItemLink(pItemLink)
	
	if not vItemCode then
		return nil
	end
	
	vItemCode = tonumber(vItemCode)
	
	local vItemInfo = self:GetItemInfoFromCode(vItemCode)
	
	vItemInfo.Name = vItemName
	vItemInfo.Link = pItemLink
	vItemInfo.SubCode = tonumber(vItemSubCode)
	
	vItemInfo.EnchantCode = tonumber(vItemEnchantCode)
	
	vItemInfo.JewelCode1 = tonumber(vItemJewelCode1)
	vItemInfo.JewelCode2 = tonumber(vItemJewelCode2)
	vItemInfo.JewelCode3 = tonumber(vItemJewelCode3)
	vItemInfo.JewelCode4 = tonumber(vItemJewelCode4)
	
	vItemInfo.Gem1 = self.cUniqueGemEnchantIDs[vItemInfo.JewelCode1]
	vItemInfo.Gem2 = self.cUniqueGemEnchantIDs[vItemInfo.JewelCode2]
	vItemInfo.Gem3 = self.cUniqueGemEnchantIDs[vItemInfo.JewelCode3]
	
	vItemInfo.UniqueID = tonumber(vItemUniqueID)
	
	return vItemInfo
end

function Outfitter:GetItemInfoFromCode(pItemCode)
	local vItemFamilyName,
	      vItemLink,
	      vItemQuality,
	      vItemLevel,
	      vItemMinLevel,
	      vItemType,
	      vItemSubType,
	      vItemCount,
	      vItemInvType = GetItemInfo(pItemCode)
	
	--
	
	local vItemInfo =
	{
		Name = vItemFamilyName,
		Link = "",
		Code = pItemCode,
		SubCode = 0,
		
		Quality = vItemQuality,
		Level = vItemLevel,
		MinLevel = vItemMinLevel,
		Type = vItemType,
		SubType = vItemSubType,
		
		Count = vItemCount,
		InvType = vItemInvType,
		
		EnchantCode = 0,
		
		JewelCode1 = 0,
		JewelCode2 = 0,
		JewelCode3 = 0,
		JewelCode4 = 0,
		
		UniqueID = 0,
	}
	
	-- Just return if there's no inventory type
	
	if not vItemInvType
	or vItemInvType == "" then
		return vItemInfo
	end
	
	-- If it's a known inventory type add that knowledge to the item info
	
	local vInvTypeInfo = self.cInvTypeToSlotName[vItemInvType]
	
	if vInvTypeInfo then
		-- Get the slot name
		
		if not vInvTypeInfo.SlotName then
			self:ErrorMessage("Unknown slot name for inventory type "..vItemInvType)
			return vItemInfo
		end
		
		vItemInfo.ItemSlotName = vInvTypeInfo.SlotName
		vItemInfo.MetaSlotName = vInvTypeInfo.MetaSlotName
	else
		-- This function can be used to query non-equippable items, so it's not an error for
		-- the inventory type to be unknown.  Should Blizzard ever add a new type though, this
		-- debug message may be useful in figuring out its characteristics
		
		-- self:ErrorMessage("Unknown slot type "..vItemInvType.." for item "..vItemName)
	end
	
	-- Done
	
	return vItemInfo
end

function Outfitter:GetAmmotSlotItemName()
	local vSlotID = self.cSlotIDs.AmmoSlot
	local vAmmoItemTexture = GetInventoryItemTexture("player", vSlotID)
	
	if not vAmmoItemTexture then
		return nil
	end
	
	OutfitterTooltip:SetOwner(OutfitterFrame, "ANCHOR_BOTTOMRIGHT", 0, 0)
	OutfitterTooltip:SetInventoryItem("player", vSlotID)
	
	if not OutfitterTooltipTextLeft1:IsShown() then
		OutfitterTooltip:Hide()
		return nil
	end
	
	local vAmmoItemName = OutfitterTooltipTextLeft1:GetText()
	
	OutfitterTooltip:Hide()
	
	return vAmmoItemName, vAmmoItemTexture
end

function Outfitter:GetBagSlotItemName(pBagIndex, pBagSlotIndex)
	OutfitterTooltip:SetOwner(OutfitterFrame, "ANCHOR_BOTTOMRIGHT", 0, 0)
	OutfitterTooltip:SetBagItem(pBagIndex, pBagSlotIndex)
	
	if not OutfitterTooltipTextLeft1:IsShown() then
		OutfitterTooltip:Hide()
		return nil
	end
	
	local vItemName = OutfitterTooltipTextLeft1:GetText()
	
	OutfitterTooltip:Hide()
	
	return vItemName
end

function Outfitter:IsBankBagIndex(pBagIndex)
	return pBagIndex and (pBagIndex > NUM_BAG_SLOTS or pBagIndex < 0)
end

----------------------------------------
-- Ammo slot link caching
----------------------------------------

function Outfitter:GetAmmotSlotItemLink()
	local vName, vTexture = self:GetAmmotSlotItemName()
	
	if not vName then
		return nil
	end
	
	if not self.Settings.AmmoLinkByName then
		self.Settings.AmmoLinkByName = {}
	end
	
	local vLink = self.Settings.AmmoLinkByName[vName]
	
	if vLink then
		return vLink
	end
	
	vLink = self:FindAmmoSlotItemLink(vName)
	
	if not vLink then
		return nil
	end
	
	self.Settings.AmmoLinkByName[vName] = vLink
	return vLink
end

function Outfitter:FindAmmoSlotItemLink(pName)
	local vNumBags, vFirstBagIndex = self:GetNumBags()
	
	for vBagIndex = vFirstBagIndex, vNumBags do
		local vNumBagSlots = GetContainerNumSlots(vBagIndex)
		
		for vBagSlotIndex = 1, vNumBagSlots do
			local vLink = GetContainerItemLink(vBagIndex, vBagSlotIndex)
			
			if vLink then
				local _, _, vName = vLink:find("|Hitem:.*|h%[(.*)%]|h")
				
				if vName == pName then
					return vLink
				end
			end
		end -- for vBagSlotIndex
	end -- for vBagIndex
	
	-- Failed to find the ammo
	
	return nil
end

----------------------------------------
--
----------------------------------------

function Outfitter:GetInventoryItemInfo(pInventorySlot)
	local vSlotID = self.cSlotIDs[pInventorySlot]
	
	if not vSlotID then
		return
	end
	
	local vItemInfo = self:GetSlotIDItemInfo(vSlotID)
	
	if not vItemInfo then
		return
	end
	
	vItemInfo.Location.SlotName = pInventorySlot
	
	return vItemInfo
end

function Outfitter:GetSlotIDItemInfo(pSlotID)
	local vItemLink = self:GetInventorySlotIDLink(pSlotID)
	local vItemInfo = self:GetItemInfoFromLink(vItemLink)
	
	if not vItemInfo then
		return nil
	end
	
	vItemInfo.Quality = GetInventoryItemQuality("player", pSlotID)
	vItemInfo.Texture = GetInventoryItemTexture("player", pSlotID)
	
	vItemInfo.Gem1, vItemInfo.Gem2, vItemInfo.Gem3 = GetInventoryItemGems(pSlotID)
	
	vItemInfo.Location = {SlotID = pSlotID}
	
	return vItemInfo
end

function Outfitter:GetNumBags()
	if self.BankFrameOpened then
		return NUM_BAG_SLOTS + NUM_BANKBAGSLOTS, -1
	else
		return NUM_BAG_SLOTS, 0
	end
end

function Outfitter:GetInventorySlotIDLink(pSlotID)
	if pSlotID == 0 then -- AmmoSlot
		return self:GetAmmotSlotItemLink()
	else
		return GetInventoryItemLink("player", pSlotID)
	end
end

function Outfitter:GetInventorySlotItemInfo(pInventorySlot)
	local vItemLink = self:GetInventorySlotIDLink(self.cSlotIDs[pInventorySlot])

	if not vItemLink then
		return
	end
	
	return self:GetItemInfoFromLink(vItemLink)
end

Outfitter.LinkCache =
{
	Inventory = {},
	FirstBagIndex = 0,
	NumBags = 0,
	Bags = {},
}

function Outfitter:ScheduleSynch()
	self.SchedulerLib:RescheduleTask(0.01, self.Synchronize, self)
end

function Outfitter:Synchronize()
	local vBagsChanged, vInventoryChanged = false, false

	if self.Debug.InventoryCache then
		self:TestMessage("Synchronize()")
	end
	
	-- Synchronize bag links
	
	local vNumBags, vFirstBagIndex = self:GetNumBags()
	
	if self.LinkCache.FirstBagIndex ~= vFirstBagIndex
	or self.LinkCache.NumBags ~= vNumBags then
		
		self.LinkCache.FirstBagIndex = vFirstBagIndex
		self.LinkCache.NumBags = vNumBags
		
		vBagsChanged = true
	end
	
	for vBagIndex = vFirstBagIndex, vNumBags do
		local vBag = self.LinkCache.Bags[vBagIndex]
		local vBagChanged = false
		
		if not vBag then
			vBag = {}
			self.LinkCache.Bags[vBagIndex] = vBag
		end
		
		local vNumBagSlots = GetContainerNumSlots(vBagIndex)
		
		if #vBag ~= vNumBagSlots then
			self:EraseTable(vBag)
			vBagChanged = true
		end
		
		for vSlotIndex = 1, vNumBagSlots do
			local vItemLink = GetContainerItemLink(vBagIndex, vSlotIndex) or ""
			
			if vBag[vSlotIndex] ~= vItemLink then
				vBag[vSlotIndex] = vItemLink
				vBagChanged = true
			end
		end
		
		if vBagChanged then
			if self.InventoryCache then
				self.InventoryCache:FlushBag(vBagIndex)
			end
			
			vBagsChanged = true
		end
	end
	
	-- Synchronize inventory links
	
	for _, vInventorySlot in ipairs(self.cSlotNames) do
		local vItemLink
		
		if vInventorySlot == "AmmoSlot" then
			local vName, vTexture = self:GetAmmotSlotItemName()
			
			if vName then
				vItemLink = vName.."|"..(vTexture or "") -- Not an item link, just a unique reference to the contents so we can detect changes
			end
		else
			vItemLink = GetInventoryItemLink("player", self.cSlotIDs[vInventorySlot])
		end
		
		if self.Debug.InventoryCache then
			self:TestMessage("Synchronize: Slot %s contains %s", tostring(vInventorySlot), tostring(vItemLink))
		end
		
		if self.LinkCache.Inventory[vInventorySlot] ~= vItemLink then
			self.LinkCache.Inventory[vInventorySlot] = vItemLink
			vInventoryChanged = true
		end
	end
	
	if vInventoryChanged then
		if self.Debug.InventoryCache then
			self:TestMessage("Synchronize: InventoryChanged")
		end
		
		if self.InventoryCache then
			self.InventoryCache:FlushInventory()
		end
		
		self.EventLib:DispatchEvent("OUTFITTER_INVENTORY_CHANGED")
	end
	
	if vBagsChanged then
		if self.Debug.InventoryCache then
			self:TestMessage("Synchronize: Bags changed")
		end
		
		self.EventLib:DispatchEvent("OUTFITTER_BAGS_CHANGED")
	end
	
	-- Done
	
	if vBagsChanged or vInventoryChanged then
		self.DisplayIsDirty = true
		self:Update(false)
	end
	
	--
	
	self:RunThreads()
	
	return vBagsChanged or vInventoryChanged, vInventoryChanged, vBagsChanged
end

----------------------------------------
-- InventoryCache
----------------------------------------

function Outfitter:GetInventoryCache()
	if not self.InventoryCache then
		self.InventoryCache = self:New(self._InventoryCache)
		
		if self.Debug.InventoryCache then
			self:DebugTable(self.InventoryCache, "InventoryCache")
		end
	end
	
	self.InventoryCache:Synchronize()
	
	return self.InventoryCache
end

function Outfitter:FlushInventoryCache()
	self.InventoryCache = nil
end

----------------------------------------
Outfitter._InventoryCache = {}
----------------------------------------

function Outfitter._InventoryCache:Construct()
	self.ItemsByCode = {}
	self.ItemsBySlot = {}
	self.InventoryItems = nil
	self.BagItems = {}
	self.NeedsUpdate = true
	
	self.FirstBagIndex = 0
	self.NumBags = 0
end

function Outfitter._InventoryCache:Synchronize()
	-- Check for a change in the number of bags
	
	local vNumBags, vFirstBagIndex = Outfitter:GetNumBags()
	
	if self.FirstBagIndex ~= vFirstBagIndex
	or self.NumBags ~= vNumBags then
		for vBagIndex = self.FirstBagIndex, vFirstBagIndex - 1 do
			self:FlushBag(vBagIndex)
		end
		
		for vBagIndex = vNumBags + 1, self.NumBags do
			self:FlushBag(vBagIndex)
		end
		
		self.NeedsUpdate = true
	end
	
	-- If there's a cached copy just clear the IgnoreItem flags and return it
	
	if not self.NeedsUpdate then
		return
	end
	
	if not self.InventoryItems then
		self.InventoryItems = {}
		
		for _, vInventorySlot in ipairs(Outfitter.cSlotNames) do
			local vItemInfo = Outfitter:GetInventoryItemInfo(vInventorySlot)
			
			if vItemInfo
			and vItemInfo.ItemSlotName
			and vItemInfo.Code ~= 0 then
				vItemInfo.SlotName = vInventorySlot
				
				self:AddItem(vItemInfo)
			end
		end
	end
	
	for vBagIndex = vFirstBagIndex, vNumBags do
		local vBagItems = self.BagItems[vBagIndex]
		
		if not vBagItems then
			self.BagItems[vBagIndex] = {}
			
			local vNumBagSlots = GetContainerNumSlots(vBagIndex)
			
			if vNumBagSlots > 0 then
				for vBagSlotIndex = 1, vNumBagSlots do
					local vItemInfo = Outfitter:GetBagItemInfo(vBagIndex, vBagSlotIndex)
					
					if vItemInfo
					and vItemInfo.Code ~= 0
					and vItemInfo.ItemSlotName
					and Outfitter:CanEquipBagItem(vBagIndex, vBagSlotIndex)
					and not Outfitter:BagItemWillBind(vBagIndex, vBagSlotIndex) then
						self:AddItem(vItemInfo)
					end
				end -- for vBagSlotIndex
			end -- if vNumBagSlots > 0
		end -- if not BagItems
	end -- for vBagIndex
	
	self.FirstBagIndex = vFirstBagIndex
	self.NumBags = vNumBags
	
	self.NeedsUpdate = false
end

function Outfitter._InventoryCache:AddItem(pItem)
	if pItem.Name == "Mining Sack" then
		Outfitter:TestMessage("AddItem on Mining Sack")
		Outfitter:DebugTable(pItem)
		Outfitter:DebugStack()
	end
	
	-- Add the item to the code list
	
	local vItemFamily = self.ItemsByCode[pItem.Code]

	if not vItemFamily then
		vItemFamily = {}
		self.ItemsByCode[pItem.Code] = vItemFamily
	end
	
	table.insert(vItemFamily, pItem)
	
	-- Add the item to the slot list
	
	local vItemSlot = self.ItemsBySlot[pItem.ItemSlotName]
	
	if not vItemSlot then
		vItemSlot = {}
		self.ItemsBySlot[pItem.ItemSlotName] = vItemSlot
	end
	
	table.insert(vItemSlot, pItem)
	
	-- Add the item to the bags
	
	if pItem.Location.BagIndex then
		local vBagItems = self.BagItems[pItem.Location.BagIndex]
		
		if not vBagItems then
			vBagItems = {}
			self.BagItems[pItem.Location.BagIndex] = vBagItems
		end
		
		vBagItems[pItem.Location.BagSlotIndex] = pItem
		
	-- Add the item to the inventory
	
	elseif pItem.Location.SlotName then
		self.InventoryItems[pItem.Location.SlotName] = pItem
	end
end

function Outfitter._InventoryCache:RemoveItem(pItem)
	-- Remove the item from the code list
	
	local vItems = self.ItemsByCode[pItem.Code]
	
	for vIndex, vItem in ipairs(vItems) do
		if vItem == pItem then
			table.remove(vItems, vIndex)
			break
		end
	end

	-- Remove the item from the slot list
	
	local vItemSlot = self.ItemsBySlot[pItem.ItemSlotName]
	
	if vItemSlot then
		for vIndex, vItem in ipairs(vItemSlot) do
			if vItem == pItem then
				table.remove(vItemSlot, vIndex)
				break
			end
		end
	end
	
	-- Remove the item from the bags list
	
	if pItem.Location.BagIndex then
		local vBagItems = self.BagItems[pItem.Location.BagIndex]
		
		if vBagItems then
			vBagItems[pItem.Location.BagSlotIndex] = nil
		end
		
	-- Remove the item from the inventory list
	
	elseif pItem.Location.SlotName then
		self.InventoryItems[pItem.Location.SlotName] = nil
	end
end

function Outfitter._InventoryCache:SwapLocations(pLocation1, pLocation2)
	-- if pLocation1.BagIndex then
	-- 	Outfitter:TestMessage("Outfitter._InventoryCache:SwapLocations: Swapping bag "..pLocation1.BagIndex..", "..pLocation1.BagSlotIndex)
	-- elseif pLocation1.SlotName then
	-- 	Outfitter:TestMessage("Outfitter._InventoryCache:SwapLocations: Swapping slot "..pLocation1.SlotName)
	-- end
	-- if pLocation2.BagIndex then
	-- 	Outfitter:TestMessage("Outfitter._InventoryCache:SwapLocations: with bag "..pLocation2.BagIndex..", "..pLocation2.BagSlotIndex)
	-- elseif pLocation2.SlotName then
	-- 	Outfitter:TestMessage("Outfitter._InventoryCache:SwapLocations: with slot "..pLocation2.SlotName)
	-- end
end

function Outfitter._InventoryCache:SwapLocationWithInventorySlot(pLocation, pSlotName)
	-- if pLocation.BagIndex then
	-- 	Outfitter:TestMessage("Outfitter._InventoryCache:SwapLocationWithInventorySlot: Swapping bag "..pLocation.BagIndex..", "..pLocation.BagSlotIndex.." with slot "..pSlotName)
	-- elseif pLocation.SlotName then
	-- 	Outfitter:TestMessage("Outfitter._InventoryCache:SwapLocationWithInventorySlot: Swapping slot "..pLocation.SlotName.." with slot "..pSlotName)
	-- end
end

function Outfitter._InventoryCache:SwapBagSlotWithInventorySlot(pBagIndex, pBagSlotIndex, pSlotName)
	-- Outfitter:TestMessage("Outfitter._InventoryCache:SwapBagSlotWithInventorySlot: Swapping bag "..pBagIndex..", "..pBagSlotIndex.." with slot "..pSlotName)
end

function Outfitter._InventoryCache:FindItemInfoByCode(pItemInfo)
	local vItems = self.ItemsByCode[pItemInfo.Code]
	
	for _, vItemInfo in ipairs(vItems) do
		if pItemInfo == vItemInfo then
			return true
		end
	end
	
	return false
end

function Outfitter._InventoryCache:FindItemInfoBySlot(pItemInfo)
	local vItems = self.ItemsBySlot[pItemInfo.ItemSlotName]

	for _, vItemInfo in ipairs(vItems) do
		if pItemInfo == vItemInfo then
			return true
		end
	end
	
	return false
end

function Outfitter._InventoryCache:FindItem(pOutfitItem, pMarkAsInUse, pAllowSubCodeWildcard)
	local vItem, vIndex, vItemFamily, vIgnoredItem = self:FindItemIndex(pOutfitItem, pAllowSubCodeWildcard)
	
	if not vItem then
		return nil, vIgnoredItem
	end
	
	if pMarkAsInUse then
		vItem.IgnoreItem = true
	end
	
	return vItem
end

function Outfitter._InventoryCache:FindItemIndex(pOutfitItem, pAllowSubCodeWildcard)
	local vItemFamily = self.ItemsByCode[pOutfitItem.Code]
	
	if not vItemFamily then
		return
	end
	
	local vBestMatch = nil
	local vBestMatchIndex = nil
	local vNumItemsFound = 0
	local vFoundIgnoredItem = nil
	
	for vIndex, vItem in ipairs(vItemFamily) do
		-- All done if the caller doesn't care about the SubCode
		
		if pAllowSubCodeWildcard
		and not pOutfitItem.SubCode then
			if vItem.IgnoreItem then
				vFoundIgnoredItem = vItem
			else
				return vItem, vIndex, vItemFamily, nil
			end
		
		-- If the subcode matches then check for an enchant match
		
		elseif vItem.SubCode == pOutfitItem.SubCode then
			-- If the enchant matches then we're all done
			
			if vItem.InvType == "INVTYPE_AMMO"
			or (vItem.EnchantCode == pOutfitItem.EnchantCode 
			and vItem.JewelCode1 == pOutfitItem.JewelCode1 
			and vItem.JewelCode2 == pOutfitItem.JewelCode2
			and vItem.JewelCode3 == pOutfitItem.JewelCode3 
			and vItem.JewelCode4 == pOutfitItem.JewelCode4
			and vItem.UniqueID == pOutfitItem.UniqueID) then
				if vItem.IgnoreItem then
					vFoundIgnoredItem = vItem
				else
					return vItem, vIndex, vItemFamily
				end
			
			-- Otherwise save the match in case a better one can
			-- be found
			
			else
				if vItem.IgnoreItem then
					if not vFoundIgnoredItem then
						vFoundIgnoredItem = vItem
					end
				else
					vBestMatch = vItem
					vBestMatchIndex = vIndex
					vNumItemsFound = vNumItemsFound + 1
				end
			end
		end
	end
	
	-- Return the match if only one item was found
	
	if vNumItemsFound == 1
	and not vBestMatch.IgnoreItem then
		return vBestMatch, vBestMatchIndex, vItemFamily, nil
	end
	
	return nil, nil, nil, vFoundIgnoredItem
end
		
function Outfitter._InventoryCache:FindItemOrAlt(pOutfitItem, pMarkAsInUse, pAllowSubCodeWildcard)
	local vItem, vIgnoredItem = self:FindItem(pOutfitItem, pMarkAsInUse, pAllowSubCodeWildcard)
	
	if vItem then
		return vItem
	end
	
	-- See if there's an alias for the item if it wasn't found
	
	local vAltCode = Outfitter.cItemAliases[pOutfitItem.Code]
	
	if not vAltCode then
		return nil, vIgnoredItem
	end
	
	return self:FindItem({Code = vAltCode}, pMarkAsInUse, true)
end

function Outfitter._InventoryCache:FindAllItemsOrAlt(pOutfitItem, pAllowSubCodeWildcard, rItems)
	local vNumItems = self:FindAllItems(pOutfitItem, pAllowSubCodeWildcard, rItems)
	local vAltCode = Outfitter.cItemAliases[pOutfitItem.Code]
	
	if vAltCode then
		vNumItems = vNumItems + self:FindAllItems({Code = vAltCode}, true, rItems)
	end
	
	return vNumItems
end

function Outfitter._InventoryCache:FindAllItems(pOutfitItem, pAllowSubCodeWildcard, rItems)
	local vItemFamily = self.ItemsByCode[pOutfitItem.Code]
	
	if not vItemFamily then
		return 0
	end
	
	local vNumItemsFound = 0
	
	for vIndex, vItem in ipairs(vItemFamily) do
		if (pAllowSubCodeWildcard and not pOutfitItem.SubCode)
		or vItem.SubCode == pOutfitItem.SubCode then
			table.insert(rItems, vItem)
			vNumItemsFound = vNumItemsFound + 1
		end
	end
	
	return vNumItemsFound
end

function Outfitter._InventoryCache:FlushBag(pBagIndex)
	if self.BagItems[pBagIndex] then
		for vBagSlotIndex, vItem in pairs(self.BagItems[pBagIndex]) do
			self:RemoveItem(vItem)
		end
		
		self.NeedsUpdate = true
		self.BagItems[pBagIndex] = nil
	end
end

function Outfitter._InventoryCache:FlushInventory()
	if Outfitter.Debug.InventoryCache then
		Outfitter:TestMessage("Outfitter._InventoryCache:FlushInventory()")
	end
	
	for vInventorySlot, vItem in pairs(self.InventoryItems) do
		self:RemoveItem(vItem)
	end
	
	self.NeedsUpdate = true
	self.InventoryItems = nil
end

function Outfitter._InventoryCache:ResetIgnoreItemFlags()
	for vItemCode, vItemFamily in pairs(self.ItemsByCode) do
		for _, vItem in ipairs(vItemFamily) do
			vItem.IgnoreItem = nil
		end
	end
end

function Outfitter._InventoryCache:GetMissingItems(pOutfit)
	if not pOutfit then
		Outfitter:DebugMessage("Outfitter._InventoryCache:GetMissingItems: pOutfit is nil")
		Outfitter:DebugStack()
		return
	end
	
	self:ResetIgnoreItemFlags()
	
	return pOutfit:GetMissingItems(self)
end

function Outfitter._InventoryCache:CompiledUnusedItemsList()
	self:ResetIgnoreItemFlags()
	
	for vCategoryID, vOutfits in pairs(gOutfitter_Settings.Outfits) do
		for vOutfitIndex, vOutfit in ipairs(vOutfits) do
			local vItems = vOutfit:GetItems()
			if vItems then
				for vInventorySlot, vOutfitItem in pairs(vItems) do
					if vOutfitItem.Code ~= 0 then
						local vItem = self:FindItemOrAlt(vOutfitItem, true)
						
						if vItem then
							vItem.UsedInOutfit = true
						end
					end
				end
			end
		end
	end
	
	local vUnusedItems = nil
	
	for vCode, vFamilyItems in pairs(self.ItemsByCode) do
		for vIndex, vOutfitItem in ipairs(vFamilyItems) do
			if not vOutfitItem.UsedInOutfit
			and vOutfitItem.ItemSlotName ~= "AmmoSlot"
			and Outfitter.cIgnoredUnusedItems[vOutfitItem.Code] == nil then
				if not vUnusedItems then
					vUnusedItems = {}
				end
				
				table.insert(vUnusedItems, vOutfitItem)
			end
		end
	end
	
	self.UnusedItems = vUnusedItems
end

function Outfitter._InventoryCache:ItemsAreSame(pItem1, pItem2)
	if not pItem1 then
		if Outfitter.Debug.TemporaryItems
		and pItem2 ~= nil then
			Outfitter:DebugMessage("ItemsAreSame(nil, %s): false", tostring(pItem2.Name))
		end
		
		return pItem2 == nil
	end
	
	if not pItem2 then
		if Outfitter.Debug.TemporaryItems then
			Outfitter:DebugMessage("ItemsAreSame(%s, nil): false", tostring(pItem1.Name))
		end
		return false
	end
	
	if pItem1.Code == 0 then
		if Outfitter.Debug.TemporaryItems
		and pItem2.Code ~= 0 then
			Outfitter:DebugMessage("ItemsAreSame(EMPTY, %s): false", tostring(pItem2.Name))
		end
		return pItem2.Code == 0
	end
	
	if (pItem1.Code ~= pItem2.Code and Outfitter.cItemAliases[pItem1.Code] ~= pItem2.Code)
	or (pItem1.Code == pItem2.Code and pItem1.SubCode ~= pItem2.SubCode) then
		if Outfitter.Debug.TemporaryItems then
			Outfitter:DebugMessage("ItemsAreSame(%s, %s): false", tostring(pItem1.Name), tostring(pItem2.Name))
		end
		return false
	end
	
	local vItems = {}
	local vNumItems = self:FindAllItemsOrAlt(pItem1, nil, vItems)
	
	if vNumItems == 0 then
		-- Shouldn't ever get here
		
		Outfitter:DebugMessage("Outfitter.ItemList_ItemsAreSame: Item not found")
		Outfitter:DebugTable(pItem1, "Item")
		
		return false
	elseif vNumItems == 1
	or pItem1.InvType == "INVTYPE_AMMO"
	or pItem2.InvType == "INVTYPE_AMMO" then
		-- If there's only one of that item then the enchant code
		-- is disregarded so just make sure it's the same
		
		-- Also don't bother comparing enchants on ammo or on items that
		-- were found as alternate codes for the desired item (ie, Argent vs. Alliance/Horde Lance)
		
		return true
	else
		local vResult = Outfitter.cItemAliases[pItem1.Code] -- Aliasable item, don't compare sub-codes
		   or (pItem1.EnchantCode == pItem2.EnchantCode
		   and pItem1.JewelCode1 == pItem2.JewelCode1
		   and pItem1.JewelCode2 == pItem2.JewelCode2
		   and pItem1.JewelCode3 == pItem2.JewelCode3
		   and pItem1.JewelCode4 == pItem2.JewelCode4
		   and pItem1.UniqueID == pItem2.UniqueID)
		 
		if Outfitter.Debug.TemporaryItems
		and not vResult then
			Outfitter:DebugMessage("ItemsAreSame(%s, %s): false", tostring(pItem1.Name), tostring(pItem2.Name))
		end
		
		return vResult
	end
end

function Outfitter._InventoryCache:InventorySlotContainsItem(pInventorySlot, pOutfitItem)
	-- Nil items are supposed to be ignored, so never claim the slot contains them
	
	if pOutfitItem == nil then
--		Outfitter:DebugMessage("InventorySlotContainsItem: OutfitItem is nil")
		return false, nil
	end
	
	-- If the item specifies an empty slot check to see if the slot is actually empty
	
	if pOutfitItem.Code == 0 then
		return self.InventoryItems[pInventorySlot] == nil
	end
	
	local vItems = {}
	local vNumItems = self:FindAllItemsOrAlt(pOutfitItem, nil, vItems)
	
	if vNumItems == 0 then
--		Outfitter:DebugMessage("InventorySlotContainsItem: OutfitItem not found")
--		Outfitter:DebugTable(pOutfitItem, "InventorySlotContainsItem: OutfitItem")
		
		return false
	elseif vNumItems == 1 then
		-- If there's only one of that item then the enchant code
		-- is disregarded so just make sure it's in the slot
		
		local vMatch = vItems[1].Location.SlotName == pInventorySlot
		
		if not vMatch then
--			Outfitter:DebugMessage("InventorySlotContainsItem: Slots don't match %s", tostring(pInventorySlot))
--			Outfitter:DebugTable(vItems[1], "InventorySlotContainsItem: Item")
		end
		
		return vMatch, vItems[1]
	else
		-- See if one of the items is in the slot
		
		for vIndex, vItem in ipairs(vItems) do
			if vItem.Location.SlotName == pInventorySlot then
				-- Must match the enchant and jewel codes if there are multiple items
				-- in order to be considered a perfect match
				
				local vCodesMatch = vItem.InvType == "INVTYPE_AMMO"
				                or (vItem.EnchantCode == pOutfitItem.EnchantCode
				                and vItem.JewelCode1 == pOutfitItem.JewelCode1
				                and vItem.JewelCode2 == pOutfitItem.JewelCode2
				                and vItem.JewelCode3 == pOutfitItem.JewelCode3
				                and vItem.JewelCode4 == pOutfitItem.JewelCode4
				                and vItem.UniqueID == pOutfitItem.UniqueID)
				
				if not vCodesMatch then
--					Outfitter:DebugMessage("InventorySlotContainsItem: Items don't match")
--					Outfitter:DebugTable(pOutfitItem, "InventorySlotContainsItem: OutfitItem")
--					Outfitter:DebugTable(vItem, "InventorySlotContainsItem: Item")
				end
				
				return vCodesMatch, vItem
			end
		end
		
		-- No items in the slot
		
--		Outfitter:DebugMessage("InventorySlotContainsItem: Items don't match -- no item")
--		Outfitter:DebugTable(pOutfitItem, "InventorySlotContainsItem: OutfitItem")
		
		return false, nil
	end
end
