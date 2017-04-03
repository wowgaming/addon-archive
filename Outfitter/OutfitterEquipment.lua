Outfitter.EquipmentUpdateCount = 0

function Outfitter:DebugEquipmentChangeList(pEquipmentChangeList)
	self:DebugMark()
	self:DebugTable(pEquipmentChangeList, "ChangeList")
end

function Outfitter:NewEquipmentChange(pInventorySlot, pItemName)
	local vSlotID = self.cSlotIDs[pInventorySlot]
	local vEquipmentChange = {SlotName = pInventorySlot, SlotID = vSlotID, ItemName = pItemName, UniqueGemTotals = {}}
	
	self:SubtractInventoryUniqueGems(vSlotID, vEquipmentChange.UniqueGemTotals)
	
	return vEquipmentChange
end

function Outfitter:ShowEquipError(pOutfitItem, pIgnoredItem, pInventorySlot)
	if self.Settings.DisableEquipErrors then
		return
	end
	
	if pOutfitItem.Name then
		if pIgnoredItem then
			local vSlotDisplayName = self.cSlotDisplayNames[pInventorySlot]
			
			if not vSlotDisplayName then
				vSlotDisplayName = pInventorySlot
			end
			
			self:ErrorMessage(format(self.cItemAlreadyUsedError, self:GenerateItemLink(pOutfitItem), vSlotDisplayName))
		else
			self:ErrorMessage(format(self.cItemNotFoundError, self:GenerateItemLink(pOutfitItem)))
		end
	else
		self:ErrorMessage(format(self.cItemNotFoundError, "unknown"))
	end
end

function Outfitter:SubtractInventoryUniqueGems(pSlotID, pUniqueGemTotals)
	if not self.TempGemCodes then
		self.TempGemCodes = {}
	end
	
	self.TempGemCodes[1], self.TempGemCodes[2], self.TempGemCodes[3], self.TempGemCodes[4] = GetInventoryItemGems(pSlotID)
	
	for vGemIndex = 1, 4 do
		local vGemItemCode = self.TempGemCodes[vGemIndex]
		local vUniqueGemCode = vGemItemCode and self.cUniqueGemItemIDs[vGemItemCode]
		
		if vUniqueGemCode then
			pUniqueGemTotals[vUniqueGemCode] = (pUniqueGemTotals[vUniqueGemCode] or 0) - 1
		end
	end
end	

function Outfitter:AddLocationUniqueGems(pLocation, pUniqueGemTotals)
	if not self.TempGemCodes then
		self.TempGemCodes = {}
	end
	
	if pLocation.BagIndex then
		self.TempGemCodes[1], self.TempGemCodes[2], self.TempGemCodes[3], self.TempGemCodes[4] = GetContainerItemGems(pLocation.BagIndex, pLocation.BagSlotIndex)
	else
		self.TempGemCodes[1], self.TempGemCodes[2], self.TempGemCodes[3], self.TempGemCodes[4] = GetInventoryItemGems(pLocation.SlotID)
	end
	
	for vGemIndex = 1, 4 do
		local vGemItemCode = self.TempGemCodes[vGemIndex]
		local vUniqueGemCode = vGemItemCode and self.cUniqueGemItemIDs[vGemItemCode]
		
		if vUniqueGemCode then
			pUniqueGemTotals[vUniqueGemCode] = (pUniqueGemTotals[vUniqueGemCode] or 0) + 1
		end
	end
end	

function Outfitter:FindEquipmentChangeForSlot(pEquipmentChangeList, pSlotName)
	for vChangeIndex, vEquipmentChange in ipairs(pEquipmentChangeList) do
		if not vEquipmentChange.TGFix and vEquipmentChange.SlotName == pSlotName then
			return vChangeIndex, vEquipmentChange
		end
	end
	
	return nil, nil
end

function Outfitter:PickupItemLocation(pItemLocation)
	if pItemLocation == nil then
		self:ErrorMessage("nil location in PickupItemLocation")
		return
	end
	
	if pItemLocation.BagIndex then
		if CT_oldPickupContainerItem then
			CT_oldPickupContainerItem(pItemLocation.BagIndex, pItemLocation.BagSlotIndex)
		else
			PickupContainerItem(pItemLocation.BagIndex, pItemLocation.BagSlotIndex)
		end
	elseif pItemLocation.SlotName then
		PickupInventoryItem(self.cSlotIDs[pItemLocation.SlotName])
	else
		self:ErrorMessage("Unknown location in PickupItemLocation")
		return
	end
end

function Outfitter:BuildUnequipChangeList(pOutfit, pInventoryCache)
	self.EquipmentChangeList = self:RecycleTable(self.EquipmentChangeList)
	
	local vEquipmentChangeList = self.EquipmentChangeList
	local vItems = pOutfit:GetItems()
	
	for vInventorySlot, vOutfitItem in pairs(vItems) do
		local vItem, vIgnoredItem = pInventoryCache:FindItemOrAlt(vOutfitItem, true)
		
		if vItem then
			table.insert(vEquipmentChangeList, {FromLocation = vItem.Location, Item = vItem})
		end
	end -- for
	
	return vEquipmentChangeList
end

function Outfitter:BuildEquipmentChangeList(pOutfit, pInventoryCache)
	self.EquipmentChangeList = self:RecycleTable(self.EquipmentChangeList)
	
	local vEquipmentChangeList = self.EquipmentChangeList
	
	pInventoryCache:ResetIgnoreItemFlags()
	
	-- Remove items which are already in the correct slot from the outfit and from the
	-- equippable items list
	
	local vItems = pOutfit:GetItems()
	
	for vInventorySlot, vOutfitItem in pairs(vItems) do
		local vContainsItem, vItem = pInventoryCache:InventorySlotContainsItem(vInventorySlot, vOutfitItem)
		
		if vContainsItem then
			pOutfit:RemoveItem(vInventorySlot)
			
			if vItem then
				vItem.IgnoreItem = true
			end
		end
	end
	
	-- WoW has a bug with dual-spec where you can end up with dual 2H weapons equipped even
	-- though you may no longer have Titan's Grip.  To correct this, I detect the situation here
	-- and insert an unequip operation for the 2H'er in the OH slot to restore the equipment
	-- to a valid state.
	
	local vHas2HGlitch
	local vSecondaryHandItem = pInventoryCache.InventoryItems.SecondaryHandSlot
	
	if not self.CanDualWield2H
	and vSecondaryHandItem
	and vSecondaryHandItem.InvType == "INVTYPE_2HWEAPON" then
		vHas2HGlitch = true
		
		local vEquipmentChange = self:NewEquipmentChange("SecondaryHandSlot", vSecondaryHandItem.Name)
		
		vEquipmentChange.TGFix = true
		
		table.insert(vEquipmentChangeList, vEquipmentChange)
	end
	
	-- Scan the outfit using the Outfitter.cSlotNames array as an index so that changes
	-- are executed in the specified order.  The order is designed so that items with
	-- durability values are unequipped first, followed by other items such as cloaks and rings
	-- which have no durability.  This makes unequipping before death (falling, raid/party wipe) more useful
	-- since it'll reduce the cost of repairs
	
	for _, vInventorySlot in ipairs(self.cSlotNames) do
		self:AddSlotToChangeList(pOutfit, pInventoryCache, vInventorySlot, vHas2HGlitch, vEquipmentChangeList)
	end -- for
	
	if #vEquipmentChangeList == 0 then
		return nil
	end
	
	self:AdjustGemSwaps(vEquipmentChangeList)
	self:OptimizeEquipmentChangeList(vEquipmentChangeList)
	
	return vEquipmentChangeList
end

function Outfitter:AddSlotToChangeList(pOutfit, pInventoryCache, pInventorySlot, pHas2HGlitch, pEquipmentChangeList)
	local vOutfitItem = pOutfit:GetItem(pInventorySlot)
	
	if not vOutfitItem then
		return -- Exit if the outfit doesn't want this slot modified
	end
	
	local vSlotID = self.cSlotIDs[pInventorySlot]
	
	local vCurrentItemCode,
	      vCurrentItemEnchantCode,
	      vCurrentItemJewelCode1,
	      vCurrentItemJewelCode2,
	      vCurrentItemJewelCode3,
	      vCurrentItemJewelCode4,
	      vCurrentItemSubCode,
	      vCurrentItemUniqueID,
	      vCurrentItemUnknownCode1,
	      vCurrentItemName = self:GetSlotIDLinkInfo(vSlotID)
	
	local vEquipmentChange = self:NewEquipmentChange(pInventorySlot, vOutfitItem.Name)
	
	--
	
	if pHas2HGlitch and pInventorySlot == "SecondaryHandSlot" then
		vCurrentItemCode = nil -- Pretend there's nothing in the OH since we've queued an unequip for it
	end
	
	-- Empty the slot if it's supposed to be blank
	
	if vOutfitItem.Code == 0 or vOutfitItem.Code == nil then
		if not vCurrentItemCode then
			return -- Nothing to do if the slot is supposed to be empty and already is
		end
	else
		-- Find the item
		
		local vItem, vIgnoredItem = pInventoryCache:FindItemOrAlt(vOutfitItem, true)
		
		-- If the item wasn't found then show an appropriate error message and leave
		
		if not vItem then
			self:ShowEquipError(vOutfitItem, vIgnoredItem, pInventorySlot)
			return
		end
		
		-- Add the unique-equipped gem counts for the item being equipped
		
		self:AddLocationUniqueGems(vItem.Location, vEquipmentChange.UniqueGemTotals)
		
		-- Update the change with info for the item being equipped
		
		pOutfit:GetItem(pInventorySlot).MetaSlotName = vItem.MetaSlotName -- This may be obsolete, a remnant from my transition to including the MetaSlotName field
		
		vEquipmentChange.ItemMetaSlotName = vItem.MetaSlotName
		vEquipmentChange.ItemLocation = vItem.Location
		
		-- Treat the item as a 1H if they can dual wield it
		
		if vEquipmentChange.ItemMetaSlotName == "TwoHandSlot"
		and not self:ItemUsesBothWeaponSlots(vOutfitItem) then
			vEquipmentChange.ItemMetaSlotName = "Weapon0Slot"
		end
	end -- else vOutfitItem.Code == 0 or vOutfitItem.Code == nil
	
	-- Insert the change
	
	table.insert(pEquipmentChangeList, vEquipmentChange)
end

function Outfitter:GetGemChangeRank(pChange, pGemCountOffsets)
	local vHasNegative, vHasPositive
	
	for vGemID, vGemCount in pairs(pChange.UniqueGemTotals) do
		if pGemCountOffsets then
			vGemCount = vGemCount + (pGemCountOffsets[vGemID] or 0)
		end
		
		if vGemCount < 0 then
			vHasNegative = true
			
			if vHasPositive then
				break
			end
		elseif vGemCount > 0 then
			vHasPositive = true
			
			if vHasNegative then
				break
			end
		end
	end
	
	if vHasNegative and vHasPositive then
		return 2
	elseif vHasPositive then	
		return 3
	end
	
	-- No changes or only negative changes are rank 1
	
	return 1
end

function Outfitter:AdjustGemSwaps(pEquipmentChangeList)
	-- Calculate the sort rank for each change
	
	for vIndex, vChange in ipairs(pEquipmentChangeList) do
		vChange.GemChangeRank = self:GetGemChangeRank(vChange)
		vChange.GemChangeRank2 = Outfitter.cSlotOrder[vChange.SlotName]
	end
	
	local vPreviousRank1Count, vPreviousRank2Count
	
	while true do
		-- Sort the by rank
		
		table.sort(pEquipmentChangeList, Outfitter.CompareGemsChangeRank)
		
		-- Sum up the gem counts in rank 1 entries and re-assign ranks
		
		self.GemSortStartCounts = self:RecycleTable(self.GemSortStartCounts)
		
		local vRank1Count, vRank2Count = 0, 0
		
		for vIndex, vChange in ipairs(pEquipmentChangeList) do
			-- Rank 1 doesn't change, just total up the counts
			-- and preserve the ordering
			
			if vChange.GemChangeRank == 1 then
				-- Total the counts
				
				for vGemID, vGemCount in pairs(vChange.UniqueGemTotals) do
					self.GemSortStartCounts[vGemID] = (self.GemSortStartCounts[vGemID] or 0) + vGemCount
				end
				
				-- Preserve the ordering
				
				vChange.GemRank2 = vIndex
				
				vRank1Count = vRank1Count + 1
			elseif vChange.GemChangeRank == 2 then
				-- If there's nothing in rank 1 then we're done
				
				if vRank1Count == 0 then
					return
				end
				
				-- Calculate a new rank using the offsets
				
				vChange.GemChangeRank = self:GetGemChangeRank(vChange, self.GemSortStartCounts)
				
				if vChange.GemChangeRank == 1 then
					vRank1Count = vRank1Count + 1
					vChange.GemChangeRank2 = vIndex
				elseif vChange.GemChangeRank == 2 then
					vRank2Count = vRank2Count + 1
				else  -- 3
					vChange.GemChangeRank2 = vIndex
				end
				
			else -- rank 3
				-- If there's nothing in rank 1 or 2 we're done
				
				if vRank1Count == 0
				or vRank2Count == 0 then
					return
				end
				
				-- Preserve the ordering
				
				vChange.GemRank2 = vIndex
			end
		end
		
		-- If the counts don't change we're done, otherwise
		-- do it again
		
		if vPreviousRank1Count == vRank1Count
		and vPreviousRank2Count == vRank2Count then
			break
		end
		
		vPreviousRank1Count = vRank1Count
		vPreviousRank2Count = vRank2Count
	end -- while
end

function Outfitter.CompareGemsChangeRank(pChange1, pChange2)
	if pChange1.GemChangeRank ~= pChange2.GemChangeRank then
		return pChange1.GemChangeRank < pChange2.GemChangeRank
	end
	
	return pChange1.GemChangeRank2 < pChange2.GemChangeRank2
end

function Outfitter:AdjustGemSwaps2(pEquipmentChangeList)
	local vNumChanges = #pEquipmentChangeList
	local vPassCount = 0
	
	for vPassNumber = 1, 4 do
		local vDidRelocate
		
		self.SwapGemTotals = self:RecycleTable(self.SwapGemTotals)
		
		for vChangeIndex = 1, vNumChanges do
			local vEquipmentChange = pEquipmentChangeList[vChangeIndex]
			local vDestIndex
			
			-- Check each unique gem and move the change up until
			-- it compensates for increases
			
			for vUniqueGemID, vGemTotal in pairs(vEquipmentChange.UniqueGemTotals) do
				local vSwapGemTotal = self.SwapGemTotals[vUniqueGemID] or 0
				
				-- If this swap will decrease the count and the current count
				-- shows a net increase, move this swap up to be before the first swap
				-- that increased the count beyond zero
				
				if vGemTotal < 0 and vSwapGemTotal > 0 then
					local vSwapGemTotal2 = vSwapGemTotal
					
					-- Work backwards to find the point at which the count
					-- went positive
					
					for vChangeIndex2 = vChangeIndex - 1, 1, -1 do
						local vEquipmentChange2 = pEquipmentChangeList[vChangeIndex2]
						local vGemTotal2 = vEquipmentChange2.UniqueGemTotals[vUniqueGemID]
						
						if vGemTotal2 then
							vSwapGemTotal2 = vSwapGemTotal2 - vGemTotal2
							
							if vSwapGemTotal2 <= 0 then
								if not vDestIndex or vChangeIndex2 < vDestIndex then
									vDestIndex = vChangeIndex2
								end
								
								break
							end
						end
					end -- for vChangeIndex2
				end -- if vGemTotal < 0
				
				self.SwapGemTotals[vUniqueGemID] = vSwapGemTotal + vGemTotal
			end -- for vUniqueGemID
			
			if vDestIndex then
				pEquipmentChangeList[vChangeIndex] = pEquipmentChangeList[vDestIndex]
				pEquipmentChangeList[vDestIndex] = vEquipmentChange
				
				vDidRelocate = true
			end
		end -- for vChangeIndex
		
		if not vDidRelocate then
			break
		end
	end -- for vPassNumber
end

function Outfitter:FixSlotSwapChange(pEquipmentList, pChangeIndex1, pEquipmentChange1, pSlotName1, pChangeIndex2, pEquipmentChange2, pSlotName2)
	-- No problem if both slots will be emptied
	
	if not pEquipmentChange1.ItemLocation
	and not pEquipmentChange2.ItemLocation then
		return
	end
	
	-- No problem if neither slot is being moved to the other one
	
	local vSlot2ToSlot1 = pEquipmentChange1.ItemLocation ~= nil
			            and pEquipmentChange1.ItemLocation.SlotName == pSlotName2
	
	local vSlot1ToSlot2 = pEquipmentChange2.ItemLocation ~= nil
			            and pEquipmentChange2.ItemLocation.SlotName == pSlotName1
	
	-- No problem if the slots are swapping with each other
	-- or not moving between each other at all
	
	if vSlot2ToSlot1 == vSlot1ToSlot2 then
		return
	end
	
	-- Slot 1 is moving to slot 2
	
	if vSlot1ToSlot2 then
		if pEquipmentChange1.ItemLocation then
			if self.Debug.EquipmentChanges then
				self:DebugMessage("FixSlotSwapChange: Rearranging so that %s can move to %s", pSlotName1, pSlotName2)
			end
			
			-- Swap change 1 and change 2 around
			
			pEquipmentList[pChangeIndex1] = pEquipmentChange2
			pEquipmentList[pChangeIndex2] = pEquipmentChange1
			
			-- Insert a change to empty slot 2
			
			local vEmptySlot2 = self:NewEquipmentChange(pEquipmentChange2.SlotName)
			table.insert(pEquipmentList, pChangeIndex1, vEmptySlot2)

			pEquipmentChange1.Optimized = true
			pEquipmentChange2.Optimized = true
			vEmptySlot2.Optimized = true
		else
			-- Slot 1 is going to be empty, so empty slot 2 instead
			-- and then when slot 1 is moved it'll swap the empty space
			
			if self.Debug.EquipmentChanges then
				self:DebugMessage("FixSlotSwapChange: Emptying %s so that %s can move there", pSlotName2, pSlotName1)
			end
			
			pEquipmentChange1.SlotName = pSlotName2
			pEquipmentChange1.SlotID = pEquipmentChange2.SlotID
			pEquipmentChange1.ItemLocation = nil

			pEquipmentChange1.Optimized = true
			pEquipmentChange2.Optimized = true
		end
		
	-- Slot 2 is moving to slot 1
	
	else
		if pEquipmentChange2.ItemLocation then
			if self.Debug.EquipmentChanges then
				self:DebugMessage("FixSlotSwapChange: Rearranging so that %s can move to %s", pSlotName2, pSlotName1)
			end
			
			-- Insert a change to empty slot 1 first
			
			local vEmptySlot1 = self:NewEquipmentChange(pEquipmentChange1.SlotName)
			table.insert(pEquipmentList, pChangeIndex1, vEmptySlot1)

			pEquipmentChange1.Optimized = true
			pEquipmentChange2.Optimized = true
			vEmptySlot1.Optimized = true
		else
			if self.Debug.EquipmentChanges then
				self:DebugMessage("FixSlotSwapChange: Emptying %s so that %s can move there", pSlotName1, pSlotName2)
			end
			
			-- Slot 2 is going to be empty, so empty slot 1 instead
			-- and then when slot 2 is moved it'll swap the empty space
			
			pEquipmentChange2.SlotName = pSlotName1
			pEquipmentChange2.SlotID = pEquipmentChange1.SlotID
			pEquipmentChange2.ItemLocation = nil
			
			-- Change the order so that slot 1 gets emptied before the move
			
			pEquipmentList[pChangeIndex1] = pEquipmentChange2
			pEquipmentList[pChangeIndex2] = pEquipmentChange1

			pEquipmentChange1.Optimized = true
			pEquipmentChange2.Optimized = true
		end
	end
end

Outfitter.SlotSwapList =
{
	Finger0Slot = "Finger1Slot",
	Trinket0Slot = "Trinket1Slot",
	MainHandSlot = "SecondaryHandSlot",
}

function Outfitter:OptimizeEquipmentChangeList(pEquipmentChangeList)
	self.DidOptimizeSlot = self:RecycleTable(self.DidOptimizeSlot)
	local vDidSlot = self.DidOptimizeSlot
	
	local vChangeIndex = 1
	local vNumChanges = #pEquipmentChangeList
	
	while vChangeIndex <= vNumChanges do
		local vEquipmentChange = pEquipmentChangeList[vChangeIndex]
		
		-- Do nothing if this change has already been worked on
		
		if vEquipmentChange.Optimized then
		
		-- If this is the change for the Titan's Grip fix, put it at the very start
		-- so it clears the state before any mainhand/offhand swaps happen
		
		elseif vEquipmentChange.TGFix then
			if vChangeIndex ~= 1 then
				if self.Debug.EquipmentChanges then
					self:DebugMessage("OptimizeEquipmentChangeList: Moving TGFix to the front of the list")
				end
				
				table.remove(pEquipmentChangeList, vChangeIndex)
				table.insert(pEquipmentChangeList, 1, vEquipmentChange)
			end
			
		elseif vEquipmentChange.SlotName == "SecondaryHandSlot" then
			local vChangeIndex2, vEquipmentChange2 = self:FindEquipmentChangeForSlot(pEquipmentChangeList, "MainHandSlot")
			
			-- If equipping an offhand item, make sure it's after equipping
			-- a mainhand item or it will fail when the current mainhand
			-- is a two-hander
			
			if vEquipmentChange.ItemLocation ~= nil then
				if vChangeIndex2 and vChangeIndex2 > vChangeIndex then
					if self.Debug.EquipmentChanges then
						self:DebugMessage("OptimizeEquipmentChangeList: Moving offhand swap to be after mainhand")
					end
					
					table.remove(pEquipmentChangeList, vChangeIndex)
					table.insert(pEquipmentChangeList, vChangeIndex2, vEquipmentChange)
					
					vChangeIndex = vChangeIndex - 1
				end
			
			-- If the off-hand slot is being emptied, then do that before handling the
			-- main hand slot (fixes Titan's Grip problem with the Argent Lance)
			
			elseif vEquipmentChange.ItemLocation == nil then
				if vChangeIndex2 and vChangeIndex2 < vChangeIndex then
					if self.Debug.EquipmentChanges then
						self:DebugMessage("OptimizeEquipmentChangeList: Moving offhand swap to be before mainhand")
					end
					
					table.remove(pEquipmentChangeList, vChangeIndex)
					table.insert(pEquipmentChangeList, vChangeIndex2, vEquipmentChange)
				end
			end
		
		-- If a two-hand weapon is being equipped, remove the change event
		-- for removing the offhand slot
		
		elseif vEquipmentChange.ItemMetaSlotName == "TwoHandSlot" then
			local vChangeIndex2, vEquipmentChange2 = self:FindEquipmentChangeForSlot(pEquipmentChangeList, "SecondaryHandSlot")
			
			-- If there's a change for the offhand slot, remove it
			
			if vChangeIndex2 then
				if self.Debug.EquipmentChanges then
					self:DebugMessage("OptimizeEquipmentChangeList: Removing offhand swap because of 2H being equipped")
				end
				
				table.remove(pEquipmentChangeList, vChangeIndex2)
				
				if vChangeIndex2 < vChangeIndex then
					vChangeIndex = vChangeIndex - 1
				end
				
				vNumChanges = vNumChanges - 1
			end
			
			-- Insert a new change for the offhand slot to empty it ahead
			-- of equipping the two-hand item
			
			if self.Debug.EquipmentChanges then
				self:DebugMessage("OptimizeEquipmentChangeList: Emptying offhand before 2H equip")
			end
			
			table.insert(pEquipmentChangeList, vChangeIndex, self:NewEquipmentChange("SecondaryHandSlot", nil))
		
		-- Otherwise see if the change needs to be re-arranged so that slot
		-- swapping works correctly (trinkets, rings, or weapon slots being swapped)
		
		else
			local vSwapSlot = self.SlotSwapList[vEquipmentChange.SlotName]
			
			if vSwapSlot and not vDidSlot[vEquipmentChange.SlotName] then
				local vChangeIndex2, vEquipmentChange2 = self:FindEquipmentChangeForSlot(pEquipmentChangeList, vSwapSlot)
				
				if vChangeIndex2 then
					self:FixSlotSwapChange(pEquipmentChangeList, vChangeIndex, vEquipmentChange, vEquipmentChange.SlotName, vChangeIndex2, vEquipmentChange2, vSwapSlot)
				end
				
				vDidSlot[vEquipmentChange.SlotName] = true
				
				vNumChanges = #pEquipmentChangeList
			end
		end
		
		--
		
		vChangeIndex = vChangeIndex + 1
	end
end

function Outfitter:ExecuteEquipmentChangeList(pEquipmentChangeList, pEmptyBagSlots, pExpectedInventoryCache)
	local vSaved_EnableSFX
	
	if not self.Settings.EnableEquipSounds then
		vSaved_EnableSFX = GetCVar("Sound_EnableSFX")
		SetCVar("Sound_EnableSFX", "0")
	end
	
	for vChangeIndex, vEquipmentChange in ipairs(pEquipmentChangeList) do
		local vSwapItems, vEmptyThenEquip
		
		-- Determine if an in-place swap is possible (or even necessary)
		
		if vEquipmentChange.ItemLocation then
			vSwapItems = true
			
			-- If the items are for different bag types, check to see if we need to
			-- separate the swap operation into Empty then Equip
			
			local vEquippedItemBagType = self:GetSlotIDItemBagType(vEquipmentChange.SlotID)
			local vNewItemBagType = self:GetItemLocationBagType(vEquipmentChange.ItemLocation)
			
			-- If the item being equipped is in a specialty bag already and the
			-- current item can't go in that bag then we have to EmptyThenEquip
			
			local vNewItemInBagType = vEquipmentChange.ItemLocation.BagIndex and self:GetBagType(vEquipmentChange.ItemLocation.BagIndex)
			
			if vEquippedItemBagType
			and vNewItemInBagType
			and vNewItemInBagType ~= 0
			and bit.band(vNewItemInBagType, vEquippedItemBagType) == 0 then
				vEmptyThenEquip = true
			
			-- Otherwise, if the item being unequipped has a specialty slot available, then we have to EmptyThenEquip
			
			elseif vEquippedItemBagType and self:FindEmptySpecialtyBagSlot(vEquippedItemBagType, pEmptyBagSlots) then
				vEmptyThenEquip = true
			end
		end
		
		-- Swap the item in-place with the new item
		
		if vSwapItems then
			if vEmptyThenEquip then
				self:UnequipSlotID(vEquipmentChange.SlotID, pEmptyBagSlots, pExpectedInventoryCache)
			end
			
			ClearCursor() -- Make sure nothing is already being held
			
			self:PickupItemLocation(vEquipmentChange.ItemLocation)
			EquipCursorItem(vEquipmentChange.SlotID)
			
			if pExpectedInventoryCache then
				pExpectedInventoryCache:SwapLocationWithInventorySlot(vEquipmentChange.ItemLocation, vEquipmentChange.SlotName)
			end
		
		-- Remove the item
		
		else
			self:UnequipSlotID(vEquipmentChange.SlotID, pEmptyBagSlots, pExpectedInventoryCache)
		end
	end
	
	ClearCursor() -- Make sure we leave nothing on the cursor
	
	if vSaved_EnableSFX then
		SetCVar("Sound_EnableSFX", vSaved_EnableSFX)
	end
end

function Outfitter:ExecuteEquipmentChangeList2(pEquipmentChangeList, pEmptySlots, pBagsFullErrorFormat, pExpectedInventoryCache)
	local vSaved_EnableSFX
	
	if not self.Settings.EnableEquipSounds then
		vSaved_EnableSFX = GetCVar("Sound_EnableSFX")
		SetCVar("Sound_EnableSFX", "0")
	end
	
	for vChangeIndex, vEquipmentChange in ipairs(pEquipmentChangeList) do
		if vEquipmentChange.ToLocation then
			ClearCursor() -- Make sure nothing is already being held
			
			self:PickupItemLocation(vEquipmentChange.FromLocation)
			EquipCursorItem(vEquipmentChange.SlotID)
			
			if pExpectedInventoryCache then
				pExpectedInventoryCache:SwapLocationWithInventorySlot(vEquipmentChange.ToLocation, vEquipmentChange.SlotName)
			end
		else
			-- Remove the item
			
			self:MoveLocationToEmptyBagSlot(vEquipmentChange.FromLocation, pEmptySlots, pBagsFullErrorFormat, pExpectedInventoryCache)
		end
	end
	
	ClearCursor() -- Make sure we leave nothing on the cursor
	
	if vSaved_EnableSFX then
		SetCVar("Sound_EnableSFX", vSaved_EnableSFX)
	end
end

function Outfitter:FindEmptySpecialtyBagSlot(pItemBagType, pEmptyBagSlots)
	if not pEmptyBagSlots
	or not pItemBagType then
		return
	end
	
	for vSlotInfoIndex, vSlotInfo in ipairs(pEmptyBagSlots) do
		if bit.band(vSlotInfo.BagType, pItemBagType) ~= 0 then
			return vSlotInfo, vSlotInfoIndex
		end
	end
end

function Outfitter:UnequipSlotID(pSlotID, pEmptyBagSlots, pExpectedInventoryCache)
	self:MoveLocationToEmptyBagSlot(pSlotID, pEmptyBagSlots, self.cBagsFullError, pExpectedInventoryCache)
end
	
function Outfitter:MoveLocationToEmptyBagSlot(pLocation, pEmptyBagSlots, pErrorMessage, pExpectedInventoryCache)
	local vItemBagType
	
	if type(pLocation) == "table" then
		vItemBagType = self:GetItemLocationBagType(pLocation)
	else
		vItemBagType = self:GetSlotIDItemBagType(pLocation)
	end
	
	if not vItemBagType then
		return -- Location is already empty
	end
	
	-- Find a bag slot for it
	
	local vEmptySlotInfo
	
	if pEmptyBagSlots then
		-- First try for a specialized bag
		
		if vItemBagType
		and vItemBagType ~= self.cGeneralBagType then
			local vSlotInfoIndex
			
			vEmptySlotInfo, vSlotInfoIndex = self:FindEmptySpecialtyBagSlot(vItemBagType, pEmptyBagSlots)
			
			if vEmptySlotInfo then
				table.remove(pEmptyBagSlots, vSlotInfoIndex)
			end
		end

		-- Try for a general purpose bag
		
		if not vEmptySlotInfo then
			for vSlotInfoIndex, vSlotInfo in ipairs(pEmptyBagSlots) do
				if vSlotInfo.BagType == self.cGeneralBagType then
					vEmptySlotInfo = vSlotInfo
					table.remove(pEmptyBagSlots, vSlotInfoIndex)
					break
				end
			end
		end
	end
	
	--
	
	if not vEmptySlotInfo then
		self:ErrorMessage(format(pErrorMessage, tostring(vItemLink)))
	else
		ClearCursor() -- Make sure they aren't holding anything already or things get wonky
		
		if type(pLocation) == "table" then
			self:PickupItemLocation(pLocation)
		else
			PickupInventoryItem(pLocation)
		end
		
		self:PickupItemLocation(vEmptySlotInfo)
		
		if pExpectedInventoryCache then
			if type(pLocation) == "table" then
				pExpectedInventoryCache:SwapLocations(pLocation, vEmptySlotInfo)
			else
				pExpectedInventoryCache:SwapLocationWithInventorySlot(pLocation, self.cSlotIDToInventorySlot[pLocation])
			end
		end
	end
end

function Outfitter:BeginEquipmentUpdate()
	self.EquipmentUpdateCount = self.EquipmentUpdateCount + 1
end

function Outfitter:EndEquipmentUpdate(pCallerName, pUpdateNow)
	self.EquipmentUpdateCount = self.EquipmentUpdateCount - 1
	
	if self.EquipmentUpdateCount == 0 then
		if pUpdateNow then
			if self.Debug.EquipmentChanges then
				self:DebugMessage("EndEquipmentUpdate: updating now")
			end
			self:UpdateEquippedItems()
		else
			self:ScheduleEquipmentUpdate()
		end
		
		self:Update(false)
	end
end

function Outfitter:UpdateEquippedItems()
	if not self.EquippedNeedsUpdate then
		if self.Debug.EquipmentChanges then
			self:DebugMessage("UpdateEquippedItems: Nothing to update")
		end
		return
	end
	
	if self.Debug.EquipmentChanges then
		self:DebugMessage("UpdateEquippedItems: updating equipment")
	end
	
	-- Delay all changes until they're alive or not casting a spell
	
	if self.IsDead
	or not self.InterruptCasting and (self.IsCasting or self.IsChanneling) then
		if self.Debug.EquipmentChanges then
			self:DebugMessage("UpdateEquippedItems: deferring while casting")
		end
		
		return
	end
	
	self.InterruptCasting = nil
	
	local vCurrentTime = GetTime()
	
	if vCurrentTime - self.LastEquipmentUpdateTime < self.cMinEquipmentUpdateInterval then
		if self.Debug.EquipmentChanges then
			self:DebugMessage("UpdateEquippedItems: deferring for min interval")
		end
		
		self:ScheduleEquipmentUpdate()
		return
	end
	
	self.LastEquipmentUpdateTime = vCurrentTime
	
	self.EquippedNeedsUpdate = false
	
	-- Compile the outfit
	
	local vInventoryCache = self:GetInventoryCache()
	local vCompiledOutfit = self:GetCompiledOutfit()
	
	-- When in combat delay the outfit change until
	-- combat ends
	
	if self.InCombat or self.MaybeInCombat then
		self.EquippedNeedsUpdate = true
		self.MaybeInCombat = false
		self:ScheduleEquipmentUpdate()
		return
	end
	
	-- Equip it
	
	local vEquipmentChangeList = self:BuildEquipmentChangeList(vCompiledOutfit, vInventoryCache)
	
	if vEquipmentChangeList then
		-- local vExpectedInventoryCache = self:New(self._InventoryCache)
	
		if self.Debug.EquipmentChanges then
			self:DebugMessage("UpdateEquippedItems: Executing change list")
			self:DebugTable(vEquipmentChangeList, "ChangeList")
		end
		
		self:ExecuteEquipmentChangeList(vEquipmentChangeList, self:GetEmptyBagSlotList(), vExpectedInventoryCache)
	else
		if self.Debug.EquipmentChanges then
			self:DebugMessage("UpdateEquippedItems: No change list generated")
		end
	end
	
	-- Update the outfit we're expecting to see on the player
	
	local vItems = vCompiledOutfit:GetItems()
	
	for vInventorySlot, vItem in pairs(vItems) do
		self.ExpectedOutfit:SetItem(vInventorySlot, vItem)
	end
	
	if self.Debug.EquipmentChanges then
		self:DebugOutfitTable(vCompiledOutfit, "CompiledOutfit")
	end
	
	self.MaybeInCombat = false
	
	self:ScheduleEquipmentUpdate()
end

function Outfitter:DebugOutfitTable(pOutfit, pPrefix)
	local vPrefix = pPrefix or pOutfit.Name or "unnamed"
	local vItems = pOutfit:GetItems()
	
	if not vItems then
		self:DebugMessage("%s: No items", vPrefix)
		return
	end
	
	for vInventorySlot, vItem in pairs(vItems) do
		if vItem.Code == 0 then
			self:DebugMessage("%s.%s: Empty slot", vPrefix, vInventorySlot)
		else
			self:DebugMessage("%s.%s: %s", vPrefix, vInventorySlot, tostring(vItem.Link))
		end
	end
end

function Outfitter:ScheduleEquipmentUpdate()
	if not self.EquippedNeedsUpdate then
		return
	end
	
	local vElapsed = GetTime() - self.LastEquipmentUpdateTime
	local vDelay = self.cMinEquipmentUpdateInterval - vElapsed
	
	 if vDelay < 0.05 then
		vDelay = 0.05
	end
	
	if self.Debug.EquipmentChanges then
		self:DebugMessage("ScheduleEquipmentUpdate: updating in %d seconds", vDelay)
	end
	
	self.SchedulerLib:ScheduleUniqueTask(vDelay, self.UpdateEquippedItems, self)
end

----------------------------------------
-- Outfitter.OutfitStack
----------------------------------------

function Outfitter.OutfitStack:Initialize()
	self:RestoreSavedStack()
end

function Outfitter.OutfitStack:RestoreSavedStack()
	if not gOutfitter_Settings.LastOutfitStack then
		gOutfitter_Settings.LastOutfitStack = {}
	end
	
	for vIndex, vOutfit in ipairs(gOutfitter_Settings.LastOutfitStack) do
		if vOutfit.Name then
			vOutfit = Outfitter:FindOutfitByName(vOutfit.Name)
		else
			setmetatable(vOutfit, Outfitter._OutfitMetaTable)
		end
		
		if vOutfit and vOutfit:GetItems() then
			table.insert(self.Outfits, vOutfit)
		end
	end
	
	Outfitter.ExpectedOutfit = Outfitter:GetCompiledOutfit()
	
	Outfitter:UpdateTemporaryOutfit(Outfitter:GetNewItemsOutfit(Outfitter.ExpectedOutfit))
	
	if gOutfitter_Settings.Options.ShowStackContents then
		self:DebugOutfitStack("Restore saved stack")
	end
end

function Outfitter.OutfitStack:AddOutfit(pOutfit, pLayerID)
	local vFound, vIndex = self:FindOutfit(pOutfit)
	
	-- If it's already the topmost outfit just ignore the request
	
	if vFound and vIndex == #self.Outfits then
		return
	end
	
	-- If it's already on then remove it from the stack
	-- so it can be added to the end
	
	if vFound then
		table.remove(self.Outfits, vIndex)
		table.remove(gOutfitter_Settings.LastOutfitStack, vIndex)
		
		for vLayerID, vLayerIndex in pairs(gOutfitter_Settings.LayerIndex) do
			if vIndex < vLayerIndex then
				gOutfitter_Settings.LayerIndex[vLayerID] = vLayerIndex - 1
			end
		end
		
		Outfitter:DispatchOutfitEvent("UNWEAR_OUTFIT", pOutfit:GetName(), pOutfit)
	end
	
	-- Figure out the position to insert at
	
	local vStackLength = #self.Outfits
	local vInsertIndex = vStackLength + 1
	
	local vLayerIndex = gOutfitter_Settings.LayerIndex[pLayerID]
	
	if vLayerIndex then
		vInsertIndex = vLayerIndex
	end
	
	if pLayerID then
		gOutfitter_Settings.LayerIndex[pLayerID] = vInsertIndex
	end
	
	-- Adjust the layer indices
	
	for vLayerID, vLayerIndex in pairs(gOutfitter_Settings.LayerIndex) do
		if vInsertIndex < vLayerIndex then
			gOutfitter_Settings.LayerIndex[vLayerID] = vLayerIndex + 1
		end
	end
	
	-- Add the outfit
	
	table.insert(self.Outfits, vInsertIndex, pOutfit)
	
	if pOutfit:GetName() then
		table.insert(gOutfitter_Settings.LastOutfitStack, vInsertIndex, {Name = pOutfit:GetName()})
	else
		table.insert(gOutfitter_Settings.LastOutfitStack, vInsertIndex, pOutfit)
	end
	
	Outfitter.DisplayIsDirty = true
	
	if gOutfitter_Settings.Options.ShowStackContents then
		self:DebugOutfitStack("Add outfit")
	end
	
	if vFound then
		self:CollapseTemporaryOutfits()
	end
	
	Outfitter:DispatchOutfitEvent("WEAR_OUTFIT", pOutfit:GetName(), pOutfit)
end

function Outfitter.OutfitStack:RemoveOutfit(pOutfit)
	local vFound, vIndex = self:FindOutfit(pOutfit)
	
	if not vFound then
		return false
	end
	
	-- Remove the outfit
	
	table.remove(self.Outfits, vIndex)
	table.remove(gOutfitter_Settings.LastOutfitStack, vIndex)
	
	self:CollapseTemporaryOutfits()
			
	for vLayerID, vLayerIndex in pairs(gOutfitter_Settings.LayerIndex) do
		if vIndex < vLayerIndex then
			gOutfitter_Settings.LayerIndex[vLayerID] = vLayerIndex - 1
		end
	end
	
	Outfitter.DisplayIsDirty = true
	
	if gOutfitter_Settings.Options.ShowStackContents then
		self:DebugOutfitStack("Remove outfit")
	end
	
	return true
end

function Outfitter.OutfitStack:FindOutfit(pOutfit)
	for vIndex, vOutfit in ipairs(self.Outfits) do
		if vOutfit == pOutfit then
			return true, vIndex
		end
	end
	
	return false, nil
end

function Outfitter.OutfitStack:FindOutfitByCategory(pCategoryID)
	for vIndex, vOutfit in ipairs(self.Outfits) do
		if vOutfit.CategoryID == pCategoryID then
			return true, vIndex
		end
	end
	
	return false, nil
end

function Outfitter.OutfitStack:Clear()
	for vIndex, vOutfit in ipairs(self.Outfits) do
		Outfitter:DispatchOutfitEvent("UNWEAR_OUTFIT", vOutfit:GetName(), vOutfit)
	end
	
	Outfitter:EraseTable(self.Outfits)
	
	gOutfitter_Settings.LastOutfitStack = Outfitter:RecycleTable(gOutfitter_Settings.LastOutfitStack)
	gOutfitter_Settings.LayerIndex = Outfitter:RecycleTable(gOutfitter_Settings.LayerIndex)
	Outfitter.DisplayIsDirty = true
	
	if gOutfitter_Settings.Options.ShowStackContents then
		Outfitter:DebugMessage("Outfitter stack cleared")
	end
end

function Outfitter.OutfitStack:ClearCategory(pCategoryID)
	local vIndex = 1
	local vStackLength = #self.Outfits
	local vChanged = false
	
	while vIndex <= vStackLength do
		local vOutfit = self.Outfits[vIndex]
		
		if vOutfit
		and vOutfit.CategoryID == pCategoryID then
			-- Remove the outfit from the stack
			
			table.remove(self.Outfits, vIndex)
			table.remove(gOutfitter_Settings.LastOutfitStack, vIndex)
			
			vStackLength = vStackLength - 1
			vChanged = true
			
			-- Adjust the layer indices
			
			for vLayerID, vLayerIndex in pairs(gOutfitter_Settings.LayerIndex) do
				if vIndex < vLayerIndex then
					gOutfitter_Settings.LayerIndex[vLayerID] = vLayerIndex - 1
				end
			end
			
			Outfitter:DispatchOutfitEvent("UNWEAR_OUTFIT", vOutfit:GetName(), vOutfit)
		else
			vIndex = vIndex + 1
		end
	end
	
	self:CollapseTemporaryOutfits()
	
	if vChanged then
		if gOutfitter_Settings.Options.ShowStackContents then
			self:DebugOutfitStack("Clear category "..pCategoryID)
		end
		
		Outfitter.DisplayIsDirty = true
	end
end

function Outfitter.OutfitStack:GetTemporaryOutfit()
	local vStackSize = #self.Outfits
	
	if vStackSize == 0 then
		return nil
	end
	
	local vOutfit = self.Outfits[vStackSize]
	
	if vOutfit:GetName() then
		return nil
	end
	
	return vOutfit
end

function Outfitter.OutfitStack:CollapseTemporaryOutfits()
	local vIndex = 1
	local vStackLength = #self.Outfits
	local vTemporaryOutfit1 = nil
	
	while vIndex <= vStackLength do
		local vOutfit = self.Outfits[vIndex]
		
		if vOutfit
		and vOutfit:GetName() == nil then
			if vTemporaryOutfit1 then
				-- Copy the items up
				
				local vTemporaryItems = vTemporaryOutfit1:GetItems()
				
				for vInventorySlot, vItem in pairs(vTemporaryItems) do
					if not vOutfit:SlotIsEnabled(vInventorySlot) then
						vOutfit:SetItem(vInventorySlot, vItem)
					end
				end
				
				-- Remove the lower temp outfit
				
				table.remove(self.Outfits, vIndex - 1)
				vStackLength = vStackLength - 1
			else
				vIndex = vIndex + 1
			end
			
			vTemporaryOutfit1 = vOutfit
		else
			vTemporaryOutfit1 = nil
			vIndex = vIndex + 1
		end
	end
end

function Outfitter.OutfitStack:IsTopmostOutfit(pOutfit)
	local vStackLength = #self.Outfits
	
	if vStackLength == 0 then
		return false
	end
	
	return self.Outfits[vStackLength] == pOutfit
end

function Outfitter.OutfitStack:UpdateOutfitDisplay()
	local vShowHelm, vShowCloak, vShowTitleID
	
	for vIndex, vOutfit in ipairs(self.Outfits) do
		if vOutfit.ShowHelm ~= nil then
			vShowHelm = vOutfit.ShowHelm
		end
		
		if vOutfit.ShowCloak ~= nil then
			vShowCloak = vOutfit.ShowCloak
		end
		
		if vOutfit.ShowTitleID ~= nil then
			vShowTitleID = vOutfit.ShowTitleID
		end
	end -- for
	
	if vShowHelm == true then
		ShowHelm("1")
	elseif vShowHelm == false then
		ShowHelm("0")
	end
	
	if vShowCloak == true then
		ShowCloak("1")
	elseif vShowCloak == false then
		ShowCloak("0")
	end
	
	if vShowTitleID ~= nil
	and Outfitter.HasHWEvent then
		SetCurrentTitle(vShowTitleID)
	end
end

function Outfitter:TagOutfitLayer(pOutfit, pLayerID)
	local vFound, vIndex = self.OutfitStack:FindOutfit(pOutfit)
	
	if not vFound then
		return
	end
	
	gOutfitter_Settings.LayerIndex[pLayerID] = vIndex
end

function Outfitter.OutfitStack:DebugOutfitStack(pOperation)
	Outfitter:DebugMessage("Outfitter Stack Contents: "..pOperation)
	
	for vIndex, vOutfit in ipairs(self.Outfits) do
		if vOutfit:GetName() then
			Outfitter:DebugMessage("Slot "..vIndex..": "..vOutfit:GetName())
		else
			Outfitter:DebugMessage("Slot "..vIndex..": Temporaray outfit")
		end
	end
	
	Outfitter:DebugTable(gOutfitter_Settings.LayerIndex, "LayerIndex")
end

function Outfitter.OutfitStack:GetCurrentOutfitInfo()
	local vStackLength = #self.Outfits
	
	if vStackLength == 0 then
		return "", nil
	end
	
	local vOutfit = self.Outfits[vStackLength]
	
	if vOutfit and vOutfit:GetName() then
		return vOutfit:GetName(), vOutfit
	else
		return Outfitter.cCustom, vOutfit
	end
end

function Outfitter:GemTest()
	local vStartEnchantID, vEndEnchantID = 3518, 3533
	
	for vEnchantID = vStartEnchantID, vEndEnchantID, 3 do
		DEFAULT_CHAT_FRAME:AddMessage(string.format("|cffa335ee|Hitem:43590:0:%d:%d:%d:0:0:0:0|h[Polar Vest]|h|r",
			vEnchantID,
			vEnchantID + 1,
			vEnchantID + 2))
	end
end
