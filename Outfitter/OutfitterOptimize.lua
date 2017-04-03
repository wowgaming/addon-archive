----------------------------------------
-- Specialty items for outfit optimization
----------------------------------------

Outfitter.cArgentDawnTrinkets = 
{
	{Code = 13209, SubCode = 0}, -- Seal of the Dawn
	{Code = 19812, SubCode = 0}, -- Rune of the Dawn
	{Code = 12846, SubCode = 0}, -- Argent Dawn Commission
}

Outfitter.cStatIDItems =
{
	ArgentDawn = Outfitter.cArgentDawnTrinkets,
}

----------------------------------------
-- Linear optimization (item-to-item comparisons)
----------------------------------------

function Outfitter:GenerateSmartOutfit(pName, pStatConfig, pInventoryCache, pAllowEmptyOutfit, pCompletionFunc)
	pInventoryCache:ResetIgnoreItemFlags()
	
	if type(pStatConfig) == "string" then
		local vStatID = pStatConfig
		
		-- Backward compatibility (pre-LibStatLogic)
		
		if vStatID == "Fishing" then
			vStatID = "FISHING"
		end
		
		-- Hard-coded item lists
		
		if vStatID then
			local vStatIDItems = self.cStatIDItems[vStatID]
			
			if vStatIDItems then
				vOutfit = self:NewEmptyOutfit(pName)
				
				self:FindAndAddItemsToOutfit(vOutfit, nil, vStatIDItems, pInventoryCache)
				
				vOutfit.StatID = vStatID
				
				if pCompletionFunc then
					pCompletionFunc(vOutfit)
				end
				
				return vOutfit
			end
		end
		
		--
		
		pStatConfig = {{StatID = vStatID}}
	end
	
	-- Get the stat objects
	
	local vStatConfig = {}
	
	for _, vConfig in ipairs(pStatConfig) do
		local vStat = self:GetStatByID(vConfig.StatID)
		
		if not vStat then
			Outfitter:ErrorMessage("Unknown stat ID: %s", tostring(vConfig.StatID))
			return
		end
		
		table.insert(vStatConfig, {Stat = vStat, StatID = vConfig.StatID, MinValue = vConfig.MinValue, MaxValue = vConfig.MaxValue})
	end
	
	-- Determine if this is complex
	
	local vComplex = #vStatConfig > 1
	              or vStatConfig[1].Stat.Complex
	              or vStatConfig[1].MinValue
	              or vStatConfig[1].MaxValue
	
	--
	
	local vOutfit
	
	if vComplex then
		local vMultiStat = {Config = vStatConfig}
		
		setmetatable(vMultiStat, Outfitter._MultiStatMetaTable)
		
		vOutfit = self:FindGeneticCombination(
							pName,
							pInventoryCache,
							nil,
							vMultiStat, vStatConfig, pCompletionFunc)
	else
		vOutfit = self:NewEmptyOutfit(pName)
		
		self:AddItemsWithStatToOutfit(vOutfit, vStatConfig[1].Stat, pInventoryCache)
		
		if not pAllowEmptyOutfit
		and vOutfit:IsEmpty() then
			return nil
		end
	end
	
	if vOutfit then
		vOutfit.StatConfig = pStatConfig
		
		if pCompletionFunc then
			pCompletionFunc(vOutfit)
		end
	end
	
	return vOutfit
end

function Outfitter:AddItemsWithStatToOutfit(pOutfit, pStat, pInventoryCache)
	local vItemStats
	
	if not pInventoryCache then
		return
	end
	
	for vInventorySlot, vItems in pairs(pInventoryCache.ItemsBySlot) do
		for vIndex, vItem in ipairs(vItems) do
			local vScore = pStat:GetItemScore(vItem)
			
			if vScore then
				local vSlotName = vItem.MetaSlotName
				
				if not vSlotName then
					vSlotName = vItem.ItemSlotName
				end
				
				if vItem.InvType == "INVTYPE_2HWEAPON"
				and not self:ItemUsesBothWeaponSlots(vItem) then
					vSlotName = "Weapon0Slot"
				end
				
				self:AddOutfitStatItemIfBetter(pOutfit, vSlotName, vItem, pStat, vScore)
			end
		end
	end
	
	-- Collapse the meta slots (currently just 2H vs. 1H/OH)
	
	self:CollapseMetaSlotsIfBetter(pOutfit, pStat)
end

function Outfitter:AddOutfitStatItemIfBetter(pOutfit, pSlotName, pItemInfo, pStat, pScore)
	local vCurrentItem = pOutfit:GetItem(pSlotName)
	local vAlternateSlotName = Outfitter.cHalfAlternateStatSlot[pSlotName]
	
	local vCurrentScore = vCurrentItem and pStat:GetItemScore(vCurrentItem)
	
	if self.Debug.Optimize then
		self:DebugMessage("AddOutfitStatItemIfBetter for %s: %s (%s) compared to %s (%s)", tostring(pSlotName), tostring(vCurrentItem and vCurrentItem.Name), tostring(vCurrentScore), tostring(pItemInfo.Name), tostring(pScore))
	end
	
	if not vCurrentScore
	or pScore > vCurrentScore then
		-- If we're bumping the current item, see if it should be moved to the alternate slot
		
		if vCurrentScore
		and vAlternateSlotName then
			Outfitter:AddOutfitStatItemIfBetter(pOutfit, vAlternateSlotName, vCurrentItem, pStat, vCurrentScore)
		end
		
		Outfitter:AddOutfitStatItem(pOutfit, pSlotName, pItemInfo, pStat, pScore)
	else
		if not vAlternateSlotName then
			return
		end
		
		return Outfitter:AddOutfitStatItemIfBetter(pOutfit, vAlternateSlotName, pItemInfo, pStat, pScore)
	end
end

function Outfitter:AddOutfitStatItem(pOutfit, pSlotName, pItemInfo, pStat, pScore)
	if not pSlotName then
		Outfitter:ErrorMessage("AddOutfitStatItem: SlotName is nil for %s", tostring(pItemName))
		return
	end
	
	if not pStat then
		Outfitter:ErrorMessage("AddOutfitStatItem: Stat is nil for %s", tostring(pItemName))
		return
	end
	
	pOutfit:AddItem(pSlotName, pItemInfo)
end

function Outfitter:CollapseMetaSlotsIfBetter(pOutfit, pStat)
	if self.Debug.Optimize then
		self:DebugMessage("CollapseMetaSlotsIfBetter: %s", tostring(pStat.ID))
		self:DebugOutfitTable(pOutfit)
	end
	
	-- Compare the weapon slot with the 1H/OH slots
	
	local vWeapon0Item = pOutfit:GetItem("Weapon0Slot")
	local vWeapon1Item = pOutfit:GetItem("Weapon1Slot")
	
	if vWeapon0Item or vWeapon1Item then
		-- Try the various combinations of MH/OH/W0/W1
		
		local v1HItem = pOutfit:GetItem("MainHandSlot")
		local vOHItem = pOutfit:GetItem("SecondaryHandSlot")
		
		local vCombinations
		
		if pStat.ID ~= "ITEM_LEVEL" then
			vCombinations =
			{
				{MainHand = v1HItem, SecondaryHand = vOHItem, AllowEmptyMainHand = true},
				{MainHand = v1HItem, SecondaryHand = vWeapon0Item, AllowEmptyMainHand = false},
				{MainHand = v1HItem, SecondaryHand = vWeapon1Item, AllowEmptyMainHand = false},
				{MainHand = vWeapon0Item, SecondaryHand = vOHItem, AllowEmptyMainHand = true},
				{MainHand = vWeapon1Item, SecondaryHand = vOHItem, AllowEmptyMainHand = true},
				{MainHand = vWeapon0Item, SecondaryHand = vWeapon1Item, AllowEmptyMainHand = false},
			}
		else
			vCombinations =
			{
				{MainHand = v1HItem, SecondaryHand = vWeapon1Item, AllowEmptyMainHand = false},
				{MainHand = vWeapon0Item, SecondaryHand = vOHItem, AllowEmptyMainHand = false},
				{MainHand = vWeapon1Item, SecondaryHand = vOHItem, AllowEmptyMainHand = false},
			}
		end
		
		local vBestCombinationIndex = nil
		local vBestCombinationValue = nil
		
		for vIndex, vCombination in ipairs(vCombinations) do
			local vCombination = vCombinations[vIndex]
			
			-- Ignore combinations where the main hand is empty if
			-- that's not allowed with this combination
			
			if vCombination.AllowEmptyMainHand
			or vCombination.MainHand then
				local vCombinationValue = self:AddScores(vCombination.MainHand, vCombination.SecondaryHand, pStat)
				
				if not vBestCombinationIndex
				or vCombinationValue > vBestCombinationValue then
					vBestCombinationIndex = vIndex
					vBestCombinationValue = vCombinationValue
				end
			end
		end
		
		if vBestCombinationIndex then
			local vCombination = vCombinations[vBestCombinationIndex]
			
			pOutfit:SetItem("MainHandSlot", vCombination.MainHand)
			pOutfit:SetItem("SecondaryHandSlot", vCombination.SecondaryHand)
		end
		
		pOutfit:RemoveItem("Weapon0Slot")
		pOutfit:RemoveItem("Weapon1Slot")
	end
	
	-- Compare the 2H slot with the 1H/OH slots
	
	local v2HItem = pOutfit:GetItem("TwoHandSlot")
	
	if v2HItem then
		local v1HItem = pOutfit:GetItem("MainHandSlot")
		local vOHItem = pOutfit:GetItem("SecondaryHandSlot")
		local v1HOHScore = (v1HItem and pStat:GetItemScore(v1HItem) or 0) + (vOHItem and pStat:GetItemScore(vOHItem) or 0)
		
		local v2HScore = pStat:GetItemScore(v2HItem)
		
		if v2HScore
		and v2HScore > v1HOHScore then
			pOutfit:SetItem("MainHandSlot", v2HItem)
			pOutfit:RemoveItem("SecondaryHandSlot")
		end
		
		pOutfit:RemoveItem("TwoHandSlot")
	end
end

function Outfitter:AddScores(pItem1, pItem2, pStat)
	return (pItem1 and pStat:GetItemScore(pItem1) or 0)
	     + (pItem2 and pStat:GetItemScore(pItem2) or 0)
end

----------------------------------------
-- Combinatorial progress dialog
----------------------------------------

function Outfitter:BeginCombiProgress(pName, pNumCombos, pCancelFunc, pHighSpeedFunc)
	if not self.CombiProgressDialog then
		self.CombiProgressDialog = Outfitter:New(self._CombiProgressDialog)
	end
	
	self.NumCombos = pNumCombos
	
	self.CombiProgressDialog:SetTitle(pName)
	self.CombiProgressDialog:SetCancelFunc(pCancelFunc)
	self.CombiProgressDialog:SetHighSpeedFunc(pHighSpeedFunc)
	self.CombiProgressDialog:SetHighSpeed(false)
	
	self.CombiProgressDialog:Show()
end

function Outfitter:FormatThousands(pNumber)
	local vResult = tostring(math.floor(pNumber + 0.5)):reverse():gsub("(%d%d%d)", "%1,"):reverse()
	return vResult:sub(1, 1) == "," and vResult:sub(2) or vResult
end

function Outfitter:UpdateCombiProgress(pComboIndex)
	self.CombiProgressDialog:SetProgress(pComboIndex / self.NumCombos)
	self.CombiProgressDialog:SetProgressText(format("%s of %s", self:FormatThousands(pComboIndex), self:FormatThousands(self.NumCombos)))
end

function Outfitter:EndCombiProgress()
	Outfitter.CombiProgressDialog:Hide()
end

function Outfitter:ItemContainsStats(pItem, pFilterStats)
	for vStatID, _ in pairs(pFilterStats) do
		if pItem.Stats[vStatID] then
			return true
		end
	end
	
	return false
end

----------------------------------------
-- Genetic optimization
----------------------------------------

function Outfitter:FindGeneticCombination(pName, pInventoryCache, pFilterStats, pStat, pStatParams, pCompletionFunc)
	assert(pCompletionFunc)
	
	self.FindGeneticCombinationCoroutineRef = coroutine.create(self.FindGeneticCombinationThread)
	
	local vResult, vMessage = coroutine.resume(self.FindGeneticCombinationCoroutineRef, self, pName, pInventoryCache, pFilterStats, pStat, pStatParams, pCompletionFunc)
	
	if not vResult then
		self:ErrorMessage(vMessage)
	end
	
	self.SchedulerLib:ScheduleRepeatingTask(0, self.RunGeneticThread, self)
end

function Outfitter:RunGeneticThread()
	local vResult, vMessage = coroutine.resume(self.FindGeneticCombinationCoroutineRef, self)
	
	if not vResult then
		self:ErrorMessage(vMessage)
	end
	
	if not vResult
	or not self.FindGeneticCombinationCoroutineRef then
		self.FindGeneticCombinationCoroutineRef = nil
		self.SchedulerLib:UnscheduleTask(self.RunGeneticThread, self)
	end
end

function Outfitter:CompareCompoundScores(pScore1, pScore2, pStatParams)
	for vIndex, vScore1 in ipairs(pScore1) do
		local vScore2 = pScore2[vIndex]
		local vStatConfig = pStatParams[vIndex]
		
		if vScore1 == vScore2 then
			-- Do nothing if they're equal
		
		elseif vStatConfig and vStatConfig.MinValue then
			if vScore1 >= vStatConfig.MinValue
			and vScore2 >= vStatConfig.MinValue then
				return vScore1 < vScore2 -- The one closer to the minValue is better
			else
				return vScore1 > vScore2 -- The one closer to the minValue is better
			end
		
		elseif vStatConfig and vStatConfig.MaxValue then
			if vScore1 <= vStatConfig.MaxValue
			and vScore2 <= vStatConfig.MaxValue then
				return vScore1 > vScore2 -- The one closer to the maxValue is better
			else
				return vScore1 < vScore2 -- The one closer to the maxValue is better
			end
		
		elseif vScore1 > vScore2 then
			return true
		elseif vScore1 < vScore2 then
			return false
		end
	end

	return false
end

function Outfitter:SortCitizens(pCitizens, pStatParams)
	if type(pCitizens[1].GeneticScore) == "table" then
		table.sort(pCitizens, function (pOutfit1, pOutfit2)
			return self:CompareCompoundScores(pOutfit1.GeneticScore, pOutfit2.GeneticScore, pStatParams)
		end)
	else
		table.sort(pCitizens, function (pOutfit1, pOutfit2)
			return pOutfit1.GeneticScore > pOutfit2.GeneticScore
		end)
	end
end

function Outfitter:FindGeneticCombinationThread(pName, pInventoryCache, pFilterStats, pStat, pStatParams, pCompletionFunc)
	assert(pCompletionFunc)
	
	local vMaxGenerations = 1000
	local vPopulation = 300
	local vNumParents = 25
	local vCitizens = {}
	local vNumOutfitsGenerated = 0
	local vMutationRate = 0.2
	local vMaxNoChangeCount = 100
	
	pInventoryCache:ResetIgnoreItemFlags()
	
	local vOutfitIterator = Outfitter:New(self._OutfitIterator, pName, pInventoryCache, pFilterStats)
	
	local vMaxYieldTime = 0.02
	local vCancel
	
	self:BeginCombiProgress(
		string.format("Genetically optimizing %s for %s", pName, pStat.Name),
		vMaxNoChangeCount,
		function ()
			vCancel = true
		end,
		function (pSet)
			if pSet then
				vMaxYieldTime = 0.1
			else
				vMaxYieldTime = 0.02
			end
		end)
	
	-- HACK: Modify LibStatLogic to cache values for vastly better performance
	
	local vOrig_GetStatMod = Outfitter.LibStatLogic.GetStatMod
	local vGetStatModCache = {}
	
	Outfitter.LibStatLogic.GetStatMod = function (pLibrary, pStatID, ...)
		local vCacheEntry = vGetStatModCache[pStatID]
		local vNumParams = select("#", ...)
		
		if vCacheEntry
		and vNumParams == #vCacheEntry.Params then
			local vIgnoreCache
			
			for vParamIndex = 1, vNumParams do
				if vCacheEntry.Params[vParamIndex] ~= select(vParamIndex, ...) then
					vIgnoreCache = true
					break
				end
			end
			
			if not vIgnoreCache then
				return vCacheEntry.Result
			end
		end
		
		if not vCacheEntry then
			vCacheEntry = {}
			vGetStatModCache[pStatID] = vCacheEntry
		end
		
		vCacheEntry.Result = vOrig_GetStatMod(pLibrary, pStatID, ...)
		vCacheEntry.Params = {...}
		
		return vCacheEntry.Result
	end
	
	--
	
	local vStartTime = GetTime()
	
	if pStat.Begin then
		pStat:Begin(pInventoryCache)
	end
	
	-- Generate the initial population and their scores
	
	for vCitizenIndex = 1, vPopulation do
		local vOutfit = vOutfitIterator:GenerateRandomOutfit()
		
		vOutfit.GeneticScore = Outfitter:GetOutfitScoreWithEmptySlots(vOutfit, pStat, pStatParams)
		
		table.insert(vCitizens, vOutfit)
		
		vNumOutfitsGenerated = vNumOutfitsGenerated + 1
	end
	
	-- Sort the initial population by score
	
	self:SortCitizens(vCitizens, pStatParams)
	
	--
	
	local vYieldTime = GetTime() + vMaxYieldTime
	local vPreviousBestScore, vBestScore
	local vNoChangeCount = 0
	local vPreviousNoChangeCount
	
	for vGenerationIndex = 1, vMaxGenerations do
		-- Mate the best parents randomly to generate new citizens
		
		for vChildIndex = vNumParents + 1, vPopulation do
			local vParentIndex1 = math.random(vNumParents)
			local vParentIndex2 = math.random(vNumParents)
			
			while vParentIndex2 == vParentIndex1 do
				vParentIndex2 = math.random(vNumParents)
			end
			
			local vChildOutfit = vOutfitIterator:SpliceOutfits(vCitizens[vParentIndex1], vCitizens[vParentIndex2])
			
			vOutfitIterator:MutateOutfit(vChildOutfit, vMutationRate)
			
			vChildOutfit.GeneticScore = Outfitter:GetOutfitScoreWithEmptySlots(vChildOutfit, pStat, pStatParams)
			
			vCitizens[vChildIndex] = vChildOutfit
			
			vNumOutfitsGenerated = vNumOutfitsGenerated + 1
			
			if GetTime() >= vYieldTime then
				coroutine.yield()
				vYieldTime = GetTime() + vMaxYieldTime
			end
			
			if vCancel then
				break
			end
		end
		
		-- Sort the new population by score
		
		self:SortCitizens(vCitizens, pStatParams)
		
		--
		
		if not vPreviousNoChangeCount
		or vNoChangeCount > vPreviousNoChangeCount then
			self:UpdateCombiProgress(vNoChangeCount)
			vPreviousNoChangeCount = vNoChangeCount
		end
		
		vBestScore = vCitizens[1].GeneticScore
		
		if type(vBestScore) == "table" then
			vBestScore = table.concat(vBestScore, ", ")
		end
		
		if vPreviousBestScore == vBestScore then
			vNoChangeCount = vNoChangeCount + 1
			
			if vNoChangeCount > vMaxNoChangeCount then
				break
			end
		else
			vNoChangeCount = 0
			vPreviousBestScore = vBestScore
		end
		
		self.CombiProgressDialog:SetDescription(string.format("Best score: %s", tostring(vBestScore)))
		
		if vCancel then
			break
		end
	end
	
	if pStat.End then
		pStat:End(pInventoryCache)
	end
	
	local vEndTime = GetTime()
	
	-- HACK: Unhook the patch from LSL

	Outfitter.LibStatLogic.GetStatMod = vOrig_GetStatMod
	
	--
	
	self:EndCombiProgress()
	
	self.FindGeneticCombinationCoroutineRef = nil
	
	if not vCancel then
		Outfitter:NoteMessage(
			"Checked %s outfits in %s seconds (%s outfits per second)",
			Outfitter:FormatThousands(vNumOutfitsGenerated),
			math.floor(vEndTime - vStartTime),
			Outfitter:FormatThousands(vNumOutfitsGenerated / (vEndTime - vStartTime)))
		
		Outfitter:NoteMessage("Best outfit score: %s", tostring(vBestScore))
		
		pCompletionFunc(vCitizens[1])
	end
end

function Outfitter:GetOutfitScoreWithEmptySlots(pOutfit, pStat, pStatParams)
	local vGeneticScore = pStat:GetOutfitScore(pOutfit, pStatParams)
	
	if type(vGeneticScore) ~= "table" then
		vGeneticScore = {vGeneticScore}
	end
	
	table.insert(vGeneticScore, pOutfit:GetNumEmptySlots())
	
	return vGeneticScore
end

----------------------------------------
Outfitter._CombiProgressDialog = {}
----------------------------------------

function Outfitter._CombiProgressDialog:New()
	return Outfitter:New(Outfitter.UIElementsLib._FloatingWindow)
end

function Outfitter._CombiProgressDialog:Construct()
	self:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	self:SetWidth(300)
	self:SetHeight(60)
	
	local vMargin = 8
	
	self.CancelButton = Outfitter:New(Outfitter.UIElementsLib._PushButton, self.ContentFrame, CANCEL, 80)
	self.CancelButton:SetPoint("TOPRIGHT", self.ContentFrame, "TOPRIGHT", -vMargin, -vMargin)
	self.CancelButton:SetScript("OnClick", function ()
		self.CancelFunc()
	end)
	
	self.ProgressBar = Outfitter:New(Outfitter.UIElementsLib._ProgressBar, self.ContentFrame)
	self.ProgressBar:SetPoint("TOPLEFT", self.ContentFrame, "TOPLEFT", vMargin, -vMargin)
	self.ProgressBar:SetPoint("RIGHT", self.CancelButton, "LEFT", -4, 0)
	
	self.HighSpeed = Outfitter:New(Outfitter.UIElementsLib._CheckButton, self.ContentFrame, "High speed")
	self.HighSpeed:SetPoint("TOPLEFT", self.ProgressBar, "BOTTOMLEFT", 0, -4)
	self.HighSpeed:SetScript("OnClick", function (pButton)
		self.HighSpeedFunc(pButton:GetChecked())
	end)
	
	self.Description = self.ContentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	self.Description:SetJustifyH("RIGHT")
	self.Description:SetJustifyV("TOP")
	self.Description:SetPoint("LEFT", self.HighSpeed.Title, "RIGHT", 4, 0)
	self.Description:SetPoint("RIGHT", self.ContentFrame, "RIGHT", -vMargin, 0)
	
	self.TitleBar:SetCloseFunc(function () self.CancelFunc() end)
end

function Outfitter._CombiProgressDialog:SetDescription(pDescription)
	self.Description:SetText(pDescription)
end

function Outfitter._CombiProgressDialog:SetCancelFunc(pCancelFunc)
	self.CancelFunc = pCancelFunc
end

function Outfitter._CombiProgressDialog:SetHighSpeed(pHighSpeed)
	self.HighSpeed:SetChecked(pHighSpeed)
end

function Outfitter._CombiProgressDialog:SetHighSpeedFunc(pHighSpeedFunc)
	self.HighSpeedFunc = pHighSpeedFunc
end

function Outfitter._CombiProgressDialog:SetProgress(pProgress)
	self.ProgressBar:SetProgress(pProgress)
end

function Outfitter._CombiProgressDialog:SetProgressText(pText)
	self.ProgressBar:SetText(pText)
end

----------------------------------------
Outfitter._OutfitIterator = {}
----------------------------------------

function Outfitter._OutfitIterator:Construct(pName, pInventoryCache, pFilterStats)
	self.Name = pName
	
	self.Slots = {}
	self.NumCombinations = 1
	
	for vInventorySlot, vItems in pairs(pInventoryCache.ItemsBySlot) do
		local vNumSlotItems = 0
		local vNumItems = #vItems
		
		if vInventorySlot ~= "AmmoSlot"
		and vNumItems > 0 then
			-- Filter the items by stat
			
			local vFilteredItems = nil
			
			if pFilterStats then
				vNumItems = 0
				
				for vItemIndex, vItem in ipairs(vItems) do
					for _, vStat in ipairs(pFilterStats) do
						if vStat:GetItemScore(vItem) then
							if not vFilteredItems then
								vFilteredItems = {}
							end
							
							table.insert(vFilteredItems, vItem)
							vNumItems = vNumItems + 1
							vNumSlotItems = vNumSlotItems + 1
							
							break
						end
					end
				end
			else
				vFilteredItems = vItems
			end
			
			-- Add the filtered list
			
			if vFilteredItems then
				table.insert(self.Slots, {ItemSlotName = vInventorySlot, Items = vFilteredItems, Index = 1, MaxIndex = vNumItems})
				
				self.NumCombinations = self.NumCombinations * vNumItems
				
				-- Duplicate the list for slots with alternates (finger, weapon, trinket)
				
				local vAltInventorySlot = Outfitter.cHalfAlternateStatSlot[vInventorySlot]
				
				if vAltInventorySlot then
					table.insert(self.Slots, {ItemSlotName = vAltInventorySlot, Items = vFilteredItems, Index = 1, MaxIndex = vNumItems})
					
					self.NumCombinations = self.NumCombinations * vNumItems
				end
			end
			
			Outfitter:DebugMessage("%s has %s items", vInventorySlot, vNumSlotItems)
		end
	end
end

function Outfitter._OutfitIterator:Outfits()
	-- Reset the slots
	
	for vSlotIndex, vSlotIterator in ipairs(self.Slots) do
		vSlotIterator.Index = 1
	end
	
	return self.Next, self, 0, nil
end

function Outfitter._OutfitIterator:Next(pPreviousIndex)
	if not self.Slots[1] then
		return nil
	end
	
	if pPreviousIndex == 0 then
		return 1, self:GetOutfit()
	end
	
	for vSlotIndex, vSlotIterator in ipairs(self.Slots) do
		vSlotIterator.Index = vSlotIterator.Index + 1
		
		if vSlotIterator.Index <= vSlotIterator.MaxIndex then
			return pPreviousIndex + 1, self:GetOutfit()
		end
		
		vSlotIterator.Index = 1
	end
	
	return nil -- Couldn't increment
end

function Outfitter._OutfitIterator:GetOutfit()
	local vOutfit = Outfitter:NewEmptyOutfit(self.Name)

	for _, vItems in ipairs(self.Slots) do
		if vItems.Index > 0 then
			local vItem = vItems.Items[vItems.Index]
			local vAltSlotName = Outfitter.cFullAlternateStatSlot[vItems.ItemSlotName]
			
			-- Only include the item if it isn't already being tried in an alternate slot (ie, trinket0 vs. trinket1)
			
			if not vAltSlotName
			or vOutfit.Items[vAltSlotName] ~= vItem then
				vOutfit.Items[vItems.ItemSlotName] = vItem
			end
		end
	end
	
	if vOutfit.Items.MainHandSlot
	and vOutfit.Items.MainHandSlot.InvType == "INVTYPE_2HWEAPON"
	and not Outfitter.CanDualWield2H then
		vOutfit.Items.SecondaryHandSlot = nil
	end
	
	return vOutfit
end

-- Genetic methods

function Outfitter._OutfitIterator:SetRandomItemForSlot(pOutfit, pItems)
	local vNumItems = #pItems.Items
	
	-- Set the slot to empty if there are no items for it
	
	if vNumItems < 1 then
		pOutfit.Items[pItems.ItemSlotName] = nil
		return
	end
	
	-- Pick a random item (zero means that an empty slot was chosen)
	
	local vIndex = math.random(vNumItems + 1) - 1
	
	local vItem = vIndex > 0 and pItems.Items[vIndex] or nil
	
	-- All done if there's no alternate slot or that
	-- slot has a different item
	
	local vAltSlotName = Outfitter.cFullAlternateStatSlot[pItems.ItemSlotName]
	
	if not vItem
	or not vAltSlotName
	or pOutfit.Items[vAltSlotName] ~= vItem then
		pOutfit.Items[pItems.ItemSlotName] = vItem
		return
	end
	
	-- Choose an empty slot if there's only one item to choose from
	
	if vNumItems < 2 then
		pOutfit.Items[pItems.ItemSlotName] = nil
		return
	end
	
	-- If there are only two items to choose from then choose the other one
	
	if vNumItems == 2 then
		pOutfit.Items[pItems.ItemSlotName] = pItems.Items[3 - vIndex]
		return
	end
	
	-- Try to find an item until there's no conflict
	
	while vItem and pOutfit.Items[vAltSlotName] == vItem do
		local vItemIndex = math.random(vNumItems + 1) - 1
		vItem = vItemIndex > 0 and pItems.Items[vItemIndex] or nil
	end
	
	pOutfit.Items[pItems.ItemSlotName] = vItem
end

function Outfitter._OutfitIterator:GenerateRandomOutfit()
	local vOutfit = Outfitter:NewEmptyOutfit(self.Name)

	for _, vItems in ipairs(self.Slots) do
		self:SetRandomItemForSlot(vOutfit, vItems)
	end
	
	-- Remove the OH choice if there's a 2H in the MH and
	-- they can't dual-wield
	
	if vOutfit.Items.MainHandSlot
	and vOutfit.Items.MainHandSlot.InvType == "INVTYPE_2HWEAPON"
	and not Outfitter.CanDualWield2H then
		vOutfit.Items.SecondaryHandSlot = nil
	end
	
	return vOutfit
end

function Outfitter._OutfitIterator:SpliceOutfits(pOutfit1, pOutfit2)
	local vOutfit = Outfitter:NewEmptyOutfit(self.Name)
	
	for _, vItems in ipairs(self.Slots) do
		local vItem = (math.random() < 0.5) and pOutfit1.Items[vItems.ItemSlotName] or pOutfit2.Items[vItems.ItemSlotName]
		local vAltSlotName = Outfitter.cFullAlternateStatSlot[vItems.ItemSlotName]
		
		-- This may need more work, but I'm not sure.  If the same item gets selected
		-- for two slots (trinket 1 and 2, ring 1 and 2, etc.) then it can't be used.
		-- Right now I just punt and leave one of them empty, but this isn't optimal of course.
		-- I think it may not matter though since that outfit will be genetically inferior
		-- to other outfits and will get weeded out.
		
		if not vAltSlotName
		or vOutfit.Items[vAltSlotName] ~= vItem then
			vOutfit.Items[vItems.ItemSlotName] = vItem
		end
	end
	
	-- Remove the OH choice if there's a 2H in the MH and
	-- they can't dual-wield
	
	if vOutfit.Items.MainHandSlot
	and vOutfit.Items.MainHandSlot.InvType == "INVTYPE_2HWEAPON"
	and not Outfitter.CanDualWield2H then
		vOutfit.Items.SecondaryHandSlot = nil
	end
	
	return vOutfit
end

function Outfitter._OutfitIterator:MutateOutfit(pOutfit, pMutationRate)
	for _, vItems in ipairs(self.Slots) do
		if math.random() < pMutationRate then
			self:SetRandomItemForSlot(pOutfit, vItems)
		end
	end
	
	-- Remove the OH choice if there's a 2H in the MH and
	-- they can't dual-wield
	
	if pOutfit.Items.MainHandSlot
	and pOutfit.Items.MainHandSlot.InvType == "INVTYPE_2HWEAPON"
	and not Outfitter.CanDualWield2H then
		pOutfit.Items.SecondaryHandSlot = nil
	end
end

local gOutfitter_CompareStat

function Outfitter._OutfitIterator:SortItemsByStat(pStat)
	gOutfitter_CompareStat = pStat
	
	for _, vSlotInfo in ipairs(self.Slots) do
		table.sort(vSlotInfo.Items,
			function (pItem1, pItem2)
				local vStat1, vStat2 = pItem1[gOutfitter_CompareStat], pItem2[gOutfitter_CompareStat]
				
				if vStat1 == nil then
					return vStat2 ~= nil
				elseif not vStat2 then
					return false
				else
					return vStat1 < vStat2
				end
			end
		)
	end
end

function Outfitter._OutfitIterator:CalcMinNumSlotsByStat(pStat, pMinValue)
	local vStatValues = {}

	for _, vSlotInfo in ipairs(self.Slots) do
		local vNumItems = #vSlotInfo.Items
		
		if vNumItems > 0 then
			local vValue = vSlotInfo.Items[1].Stats[pStat]
			
			if vValue then
				table.insert(vStatValues, vValue)
			end

			if vNumItems > 1
			and (vSlotInfo.ItemSlotName == "Trinket0Slot"
			or vSlotInfo.ItemSlotName == "Finger0Slot"
			or vSlotInfo.ItemSlotName == "WeaponSlot") then
				local vValue = vSlotInfo.Items[2].Stats[pStat]
				
				if vValue then
					table.insert(vStatValues, vValue)
				end
			end
		end
	end
	
	table.sort(vStatValues, function (pValue1, pValue2) return pValue1 > pValue2 end)
	
	local vTotal = 0
	
	for vIndex, vValue in ipairs(vStatValues) do
		vTotal = vTotal + vValue
		
		if vTotal >= pMinValue then
			return vIndex
		end
	end
	
	return #vStatValues
end

----------------------------------------
Outfitter._MultiStatConfig = {}
----------------------------------------

function Outfitter._MultiStatConfig:New(pParent)
	return CreateFrame("Frame", nil, pParent)
end

function Outfitter._MultiStatConfig:Construct(pParent)
	self.ConfigLines = {}
	
	self.AddStatButton = Outfitter:New(Outfitter.UIElementsLib._PushButton, self, "Add another stat", 200)
	
	self.AddStatButton:SetScript("OnClick", function ()
		self:SetNumConfigLines(self.NumConfigLines + 1)
	end)
	
	self:AdjustSize()
end

function Outfitter._MultiStatConfig:SetConfig(pConfig)
	local vNumConfigLines
	
	if not pConfig then
		pConfig = {{StatID = "STA"}}
	end
	
	local vNumConfigLines = #pConfig
	
	self:SetNumConfigLines(vNumConfigLines)
	
	for vIndex, vConfig in ipairs(pConfig) do
		self.ConfigLines[vIndex]:SetConfig(vConfig)
	end
end

function Outfitter._MultiStatConfig:SetNumConfigLines(pNumLines)
	self.NumConfigLines = pNumLines
	
	local vOldNumConfigLines = #self.ConfigLines
	local vNumConfigLines = vOldNumConfigLines
	
	while vNumConfigLines < pNumLines do
		local vLineIndex = vNumConfigLines + 1
		
		vConfigLine = Outfitter:New(Outfitter._MultiStatConfigLine, self, vLineIndex, vLineIndex > 1)
		
		vConfigLine.OnDelete = function ()
			self:DeleteConfigLine(vLineIndex)
		end
		
		if #self.ConfigLines == 0 then
			vConfigLine:SetPoint("TOPLEFT", self, "TOPLEFT")
		else
			vConfigLine:SetPoint("TOPLEFT", self.ConfigLines[#self.ConfigLines], "BOTTOMLEFT", 0, -4)
		end
		
		table.insert(self.ConfigLines, vConfigLine)
		
		vNumConfigLines = vNumConfigLines + 1
	end
	
	for vIndex, vConfigLine in ipairs(self.ConfigLines) do
		if vIndex <= pNumLines then
			if vIndex > vOldNumConfigLines then
				vConfigLine:SetConfig({StatID = "STA"})
			end
			
			vConfigLine:Show()
		else
			vConfigLine:Hide()
		end
	end
	
	self.AddStatButton:ClearAllPoints()
	self.AddStatButton:SetPoint("TOPLEFT", self.ConfigLines[pNumLines], "BOTTOMLEFT", 0, -4)
	
	self:AdjustSize()
	
	if self.OnNumLinesChanged then
		self:OnNumLinesChanged(pNumLines)
	end
end

function Outfitter._MultiStatConfig:GetConfig()
	local vConfig = {}
	
	for vIndex, vConfigLine in ipairs(self.ConfigLines) do
		if not vConfigLine:IsShown() then
			break
		end
		
		table.insert(vConfig, vConfigLine:GetConfig())
	end
	
	return vConfig
end

function Outfitter._MultiStatConfig:DeleteConfigLine(pLineIndex)
	local vConfig = self:GetConfig()
	
	table.remove(vConfig, pLineIndex)
	
	self:SetConfig(vConfig)
end

function Outfitter._MultiStatConfig:AdjustSize()
	local vWidth = 0
	local vHeight = 0
	
	for vIndex, vConfigLine in ipairs(self.ConfigLines) do
		if not vConfigLine:IsShown() then
			break
		end
		
		vHeight = vHeight + vConfigLine:GetHeight() + 4
		
		if vConfigLine:GetWidth() > vWidth then
			vWidth = vConfigLine:GetWidth()
		end
	end
	
	vHeight = vHeight + self.AddStatButton:GetHeight()
	
	self:SetWidth(vWidth)
	self:SetHeight(vHeight)
end

----------------------------------------
Outfitter._MultiStatConfigLine = {}
----------------------------------------

function Outfitter._MultiStatConfigLine:New(pParent)
	return CreateFrame("Frame", nil, pParent)
end

function Outfitter._MultiStatConfigLine:Construct(pParent, pIndex, pCanDelete)
	self.StatMenu = Outfitter:New(Outfitter.UIElementsLib._DropDownMenu, self, function (...) self:StatMenuFunc(...) end)
	self.StatMenu:SetTitle(string.format("Stat %d", pIndex))
	self.StatMenu.ItemClickedFunc = function (pMenu, pValue)
		self:SetStatID(pValue)
	end
	
	self.OpMenu = Outfitter:New(Outfitter.UIElementsLib._DropDownMenu, self, function (...) self:OpMenuFunc(...) end)
	self.OpMenu.ItemClickedFunc = function (pMenu, pValue)
		self:SetOp(pValue)
	end
	
	self.MinValue = Outfitter:New(Outfitter.UIElementsLib._EditBox, self, nil, 7)
	self.MinValue:SetEmptyText("value")
	
	if pCanDelete then
		self.DeleteButton = Outfitter:New(Outfitter.UIElementsLib._PushButton, self, REMOVE, 90)
		self.DeleteButton:SetScript("OnClick", function ()
			if self.OnDelete then
				self:OnDelete()
			end
		end)
	end
	
	-- Arrange the layout
	
	self.StatMenu:SetWidth(120)
	self.OpMenu:SetWidth(60)
	self.MinValue:SetWidth(80)
	
	self.StatMenu:SetPoint("LEFT", self, "LEFT", 50, 0)
	self.OpMenu:SetPoint("LEFT", self.StatMenu, "RIGHT", 15, 0)
	self.MinValue:SetPoint("LEFT", self.OpMenu, "RIGHT", 15, 0)
	
	if self.DeleteButton then
		self.DeleteButton:SetPoint("LEFT", self.MinValue, "RIGHT", 10, 1)
	end
	
	self:SetWidth(445)
	self:SetHeight(30)
end

function Outfitter._MultiStatConfigLine:StatMenuFunc(pMenu)
	if UIDROPDOWNMENU_MENU_LEVEL == 2 then
		local vCategory = Outfitter:GetCategoryByID(UIDROPDOWNMENU_MENU_VALUE)
		
		if vCategory then
			local vNumStats = vCategory:GetNumStats()
			
			for vStatIndex = 1, vNumStats do
				local vStat = vCategory:GetIndexedStat(vStatIndex)
				
				pMenu:AddNormalItem(vStat.Name, vStat.ID)
			end
		end
	else
		for _, vCategory in ipairs(Outfitter.StatCategories) do
			pMenu:AddChildMenu(
				vCategory.Name,
				vCategory.CategoryID)
		end
	end
end

function Outfitter._MultiStatConfigLine:OpMenuFunc(pMenu)
	pMenu:AddNormalItem("Max", "MAX")
	pMenu:AddNormalItem("<=", "LT")
	pMenu:AddNormalItem(">=", "GT")
end

function Outfitter._MultiStatConfigLine:SetStatID(pStatID)
	self.StatID = pStatID
	self.StatMenu:SetSelectedValue(self.StatID)
end

function Outfitter._MultiStatConfigLine:SetOp(pOp)
	self.OpMenu:SetSelectedValue(pOp)
	
	if pOp == "MAX" then
		self.MinValue:Hide()
	else
		self.MinValue:Show()
	end
end

function Outfitter._MultiStatConfigLine:SetConfig(pConfig)
	if not pConfig then
		self:SetStatID("STA")
		self:SetOp("MAX")
		self.MinValue:SetText("")
	else
		self:SetStatID(pConfig.StatID)
		
		self:SetOp((pConfig.MinValue and "GT")
				or (pConfig.MaxValue and "LT")
				or "MAX")
		
		self.MinValue:SetText(pConfig.MinValue or pConfig.MaxValue or "")
	end
end

function Outfitter._MultiStatConfigLine:GetConfig()
	local vMinValue = tonumber(self.MinValue:GetText())
	local vStatID = self.StatMenu:GetSelectedValue()
	local vOp = self.OpMenu:GetSelectedValue()
	
	local vValue = tonumber(self.MinValue:GetText())
	local vMinValue = vOp == "GT" and vValue or nil
	local vMaxValue = vOp == "LT" and vValue or nil
	
	local vConfig =
	{
		StatID = vStatID,
		MinValue = vMinValue,
		MaxValue = vMaxValue
	}
	
	return vConfig
end
