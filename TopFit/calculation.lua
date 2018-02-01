
function TopFit:StartCalculations()
    -- generate table of set codes
    TopFit.workSetList = {}
    for setCode, _ in pairs(self.db.profile.sets) do
        tinsert(TopFit.workSetList, setCode)
    end
    
    TopFit:CalculateSets()
end

function TopFit:AbortCalculations()
    if TopFit.isBlocked then
        TopFit.abortCalculation = true
    end
end

function TopFit:CalculateSets(silent)
    if (not TopFit.isBlocked) then
        if not silent then
            HideUIPanel(InterfaceOptionsFrame)
        end
        TopFit.silentCalculation = silent
        local setCode = tremove(TopFit.workSetList)
        while not self.db.profile.sets[setCode] and #(TopFit.workSetList) > 0 do
            setCode = tremove(TopFit.workSetList)
        end
        
        if self.db.profile.sets[setCode] then
            TopFit.setCode = setCode -- globally save the current set that is being calculated
            
            TopFit:Debug("Calculating items for "..setCode)
            
            -- set as working to prevent any further calls from "interfering"
            TopFit.isBlocked = true
            
            TopFit.Utopia = TopFit.db.profile.sets[setCode].caps
            TopFit.ignoreCapsForCalculation = false
            
            -- do the actual work
            TopFit:collectItems()
            TopFit:CalculateRecommendations()
        end
    end
end

--start calculation for setName
function TopFit:CalculateRecommendations()
    local setName = self.db.profile.sets[TopFit.setCode].name
    TopFit.itemRecommendations = {}
    TopFit.currentItemCombination = {}
    TopFit.itemCombinations = {}
    TopFit.currentSetName = setName
    
    -- determine if the player can dualwield
    TopFit.playerCanDualWield = false
    TopFit.playerCanTitansGrip = false
    if (select(2, UnitClass("player")) == "ROGUE") or (select(2, UnitClass("player")) == "DEATHKNIGHT") or (((select(2, UnitClass("player")) == "WARRIOR") or (select(2, UnitClass("player")) == "HUNTER")) and (UnitLevel("player") > 20)) or
        ((select(2, UnitClass("player")) == "SHAMAN") and (select(5, GetTalentInfo(2, 20)) > 0)) then
        TopFit.playerCanDualWield = true
    end
    if ((select(2, UnitClass("player")) == "WARRIOR") and (select(5, GetTalentInfo(2, 27)) > 0)) then
        TopFit.playerCanTitansGrip = true
    end
    
    if (TopFit.db.profile.sets[TopFit.setCode].simulateDualWield) then
        TopFit.playerCanDualWield = true
    end
    if (TopFit.db.profile.sets[TopFit.setCode].simulateTitansGrip) then
        TopFit.playerCanTitansGrip = true
    end
    
    TopFit:InitSemiRecursiveCalculations()
end

function TopFit:InitSemiRecursiveCalculations()
    -- save equippable items
    TopFit.itemListBySlot = TopFit:GetEquippableItems()
    TopFit:ReduceItemList()
    
    TopFit.slotCounters = {}
    TopFit.currentSlotCounter = 0
    TopFit.operationsPerFrame = 500
    TopFit.combinationCount = 0
    TopFit.bestCombination = nil
    TopFit.maxScore = nil
    TopFit.firstCombination = true
    
    TopFit.capHeuristics = {}
    TopFit.maxRestStat = {}
    TopFit.currentCapValues = {}
    -- create maximum values for each cap and item slot
    for statCode, preferences in pairs(TopFit.Utopia) do
        if preferences.active then
            TopFit.capHeuristics[statCode] = {}
            TopFit.maxRestStat[statCode] = {}
            for _, slotID in pairs(TopFit.slots) do
                if (TopFit.itemListBySlot[slotID]) then
                    -- get maximum value contributed to cap in this slot
                    local maxStat = nil
                    for _, locationTable in pairs(TopFit.itemListBySlot[slotID]) do
                        local itemTable = TopFit:GetCachedItem(locationTable.itemLink)
                        if itemTable then
                            local thisStat = itemTable.totalBonus[statCode] or 0
                            
                            if ((thisStat > 0) and ((maxStat == nil) or (thisStat > maxStat))) then
                                maxStat = thisStat
                            end
                        end
                    end
                    
                    TopFit.capHeuristics[statCode][slotID] = maxStat
                end
            end
            
            for i = 0, 20 do
                TopFit.maxRestStat[statCode][i] = 0
                if (TopFit.capHeuristics[statCode][i]) then
                    for j = 0, i do
                        TopFit.maxRestStat[statCode][j] = TopFit.maxRestStat[statCode][j] + TopFit.capHeuristics[statCode][i]
                    end
                end
            end
        end
    end
    
    TopFit.calculationsFrame:SetScript("OnUpdate", TopFit.SemiRecursiveCalculation)
    
    -- show progress frame
    if not TopFit.silentCalculation then
        TopFit:CreateProgressFrame()
    elseif not TopFit.ProgressFrame then
        TopFit:CreateProgressFrame()
        TopFit.ProgressFrame:Hide()
    end
    TopFit.ProgressFrame:SetSelectedSet(TopFit.setCode)
    TopFit.ProgressFrame:SetSetName(TopFit.currentSetName)
    TopFit.ProgressFrame:ResetProgress()
end

function TopFit:ReduceItemList()
    -- remove all non-forced items from item list
    for slotID, forceID in pairs(self.db.profile.sets[TopFit.setCode].forced) do
        if TopFit.itemListBySlot[slotID] then
            for i = #(TopFit.itemListBySlot[slotID]), 1, -1 do
                local itemTable = TopFit:GetCachedItem(TopFit.itemListBySlot[slotID][i].itemLink)
                if not itemTable or (itemTable.itemID ~= forceID) then
                    tremove(TopFit.itemListBySlot[slotID], i)
                    --TopFit.itemListBySlot[slotID][i].reason = TopFit.itemListBySlot[slotID][i].reason.."forced item in slot; "
                end
            end
        end
        
        if (slotID == 17) then -- offhand
            --TODO: check if forced item is a weapon and remove all weapons from mainhand if player cannot dualwield
            -- always remove all 2H-weapons from mainhand
        end
    end
    
    -- remove all items with score <= 0 that are neither forced nor contribute to caps
    for slotID, itemList in pairs(TopFit.itemListBySlot) do
        if #itemList >= 1 then
            for i = #itemList, 1, -1 do
                if (TopFit:GetItemScore(itemList[i].itemLink, TopFit.setCode, TopFit.ignoreCapsForCalculation) <= 0) then
                    if not (self.db.profile.sets[TopFit.setCode].forced[slotID]) then
                        -- check caps
                        local hasCap = false
                        for statCode, preferences in pairs(TopFit.Utopia) do
                            if preferences.active then
                                local itemTable = TopFit:GetCachedItem(itemList[i].itemLink)
                                if itemTable and (itemTable.totalBonus[statCode] or -1) > 0 then
                                    hasCap = true
                                    break
                                end
                            end
                        end
                        
                        if not hasCap then
                            tremove(itemList, i)
                            --itemList[i].reason = itemList[i].reason.."score <= 0, no cap contribution and not forced; "
                        end
                    end
                end
            end
        end
    end
    
    -- remove BoE items
    for slotID, itemList in pairs(TopFit.itemListBySlot) do
        if #itemList > 0 then
            for i = #itemList, 1, -1 do
                if itemList[i].isBoE then
                    tremove(itemList, i)
                    --itemList[i].reason = itemList[i].reason.."BoE item; "
                end
            end
        end
    end

    -- reduce item list: remove items with < cap and < score
    for slotID, itemList in pairs(TopFit.itemListBySlot) do
        if #itemList > 1 then
            for i = #itemList, 1, -1 do
                local itemTable = TopFit:GetCachedItem(itemList[i].itemLink)
                if not itemTable then
                    tremove(itemList, i)
                else
                    -- try to see if an item exists which is definitely better
                    local betterItemExists = 0
                    local numBetterItemsNeeded = 1
                    
                    -- For items that can be used in 2 slots, we also need at least 2 better items to declare an item useless
                    if (slotID == 17) -- offhand
                        or (slotID == 12) -- ring 2
                        or (slotID == 14) -- trinket 2
                        then
                        
                        numBetterItemsNeeded = 2
                    end
                    
                    for j = 1, #itemList do
                        if i ~= j then
                            local compareTable = TopFit:GetCachedItem(itemList[j].itemLink)
                            if compareTable and
                                (TopFit:GetItemScore(itemTable.itemLink, TopFit.setCode, TopFit.ignoreCapsForCalculation) < TopFit:GetItemScore(compareTable.itemLink, TopFit.setCode, TopFit.ignoreCapsForCalculation)) and
                                (itemTable.itemEquipLoc == compareTable.itemEquipLoc) then -- especially important for weapons, we do not want to compare 2h and 1h weapons
                                
                                --TopFit:Debug("score: "..TopFit:GetItemScore(itemTable.itemLink, TopFit.setCode, TopFit.ignoreCapsForCalculation).."; compareScore: "..TopFit:GetItemScore(compareTable.itemLink, TopFit.setCode, TopFit.ignoreCapsForCalculation)..
                                --    " when comparing "..itemTable.itemLink.." with "..compareTable.itemLink)
                                
                                -- score is greater, see if caps are also better
                                local allStats = true
                                for statCode, preferences in pairs(TopFit.Utopia) do
                                    if preferences.active then
                                        if (itemTable.totalBonus[statCode] or 0) > (compareTable.totalBonus[statCode] or 0) then
                                            allStats = false
                                            break
                                        end
                                    end
                                end
                                
                                if allStats then
                                    betterItemExists = betterItemExists + 1
                                    if (betterItemExists >= numBetterItemsNeeded) then
                                        break
                                    end
                                end
                            end
                        end
                    end
                    
                    if betterItemExists >= numBetterItemsNeeded then
                        -- remove this item
                        --TopFit:Debug(itemTable.itemLink.." removed because "..betterItemExists.." better items found.")
                        tremove(itemList, i)
                        --itemList[i].reason = itemList[i].reason..betterItemExists.." better items found (setCode: "..(TopFit.setCode or "nil").."; relevantScore: "..(TopFit.ignoreCapsForCalculation or "nil").."); "
                    end
                end
            end
        end
    end
end

function TopFit:SemiRecursiveCalculation()
    local operation
    local done = false
    for operation = 1, TopFit.operationsPerFrame do
        if (not done) and (not TopFit.abortCalculation) then
            -- set counters to next combination
            
            -- check all nil counters from the end
            local currentSlot = 19
            local increased = false
            while (not increased) and (currentSlot > 0) do
                while (TopFit.slotCounters[currentSlot] == nil or TopFit.slotCounters[currentSlot] == #(TopFit.itemListBySlot[currentSlot])) and (currentSlot > 0) do
                    TopFit.slotCounters[currentSlot] = nil -- reset to "no item"
                    currentSlot = currentSlot - 1
                end
                
                if (currentSlot > 0) then
                    -- increase combination, starting at currentSlot
                    TopFit.slotCounters[currentSlot] = TopFit.slotCounters[currentSlot] + 1
                    if (not TopFit:IsDuplicateItem(currentSlot)) and (TopFit:IsOffhandValid(currentSlot)) then
                        increased = true
                    end
                else
                    if TopFit.firstCombination then
                        TopFit.firstCombination = false
                    else
                        -- we're back here, and so we're done
                        done = true
                        TopFit.calculationsFrame:SetScript("OnUpdate", nil)
                        operation = TopFit.operationsPerFrame
                        
                        -- save a default set of only best-in-slot items
                        TopFit:SaveCurrentCombination()
                        
                        -- find best combination that satisfies ALL caps
                        if (TopFit.bestCombination) then
                            -- caps are reached, save and equip best combination
                            --local itemsAlreadyChosen = {}
                            for slotID, locationTable in pairs(TopFit.bestCombination.items) do
                                TopFit.itemRecommendations[slotID] = {
                                    locationTable = locationTable,
                                }
                                --tinsert(itemsAlreadyChosen, itemTable)
                            end
                            
                            TopFit:EquipRecommendedItems()
                        else
                            -- caps could not all be reached, calculate without caps instead
                            if not TopFit.silentCalculation then
                                TopFit:Print("Caps could not be reached, calculating again without caps.")
                            end
                            TopFit.Utopia = {}
                            TopFit.ignoreCapsForCalculation = true
                            TopFit:CalculateRecommendations(TopFit.currentSetName)
                            return
                        end
                    end
                end
            end
            
            if not done then
                -- fill all further slots with first choices again - until caps are reached or unreachable
                while (not TopFit:IsCapsReached(currentSlot)) and (not TopFit:IsCapsUnreachable(currentSlot)) and (currentSlot < 19) do
                    currentSlot = currentSlot + 1
                    if #(TopFit.itemListBySlot[currentSlot]) > 0 then
                        TopFit.slotCounters[currentSlot] = 1
                        while TopFit:IsDuplicateItem(currentSlot) or (not TopFit:IsOffhandValid(currentSlot)) do
                            TopFit.slotCounters[currentSlot] = TopFit.slotCounters[currentSlot] + 1
                        end
                        if TopFit.slotCounters[currentSlot] > #(TopFit.itemListBySlot[currentSlot]) then
                            TopFit.slotCounters[currentSlot] = 0
                        end
                    else
                        TopFit.slotCounters[currentSlot] = 0
                    end
                end
                
                if TopFit:IsCapsReached(currentSlot) then
                    -- valid combination, save
                    TopFit:SaveCurrentCombination()
                end
            end
        end
    end
    
    -- update progress
    if not done then
        local progress = 0
        local impact = 1
        local slot
        for slot = 1, 20 do
            -- check if slot has items for calculation
            if TopFit.itemListBySlot[slot] then
                -- calculate current progress towards finish
                local numItemsInSlot = #(TopFit.itemListBySlot[slot]) or 1
                local selectedItem = (TopFit.slotCounters[slot] == 0) and (#(TopFit.itemListBySlot[slot]) or 1) or (TopFit.slotCounters[slot] or 1)
                if numItemsInSlot == 0 then numItemsInSlot = 1 end
                if selectedItem == 0 then selectedItem = 1 end
                
                impact = impact / numItemsInSlot
                progress = progress + impact * (selectedItem - 1)
            end
        end
        
        TopFit.ProgressFrame:SetProgress(progress)
    else
        TopFit.ProgressFrame:SetProgress(1) -- done
    end
    
    -- update icons and statistics
    if TopFit.bestCombination then
        TopFit.ProgressFrame:SetCurrentCombination(TopFit.bestCombination)
    end
    
    if TopFit.abortCalculation then
        TopFit.calculationsFrame:SetScript("OnUpdate", nil)
        --TopFit:Print("Calculation aborted.")
        TopFit.abortCalculation = nil
        TopFit.isBlocked = false
        TopFit.ProgressFrame:StoppedCalculation()
    end
    
    TopFit:Debug("Current combination count: "..TopFit.combinationCount)
end

function TopFit:IsCapsReached(currentSlot)
    local currentValues = {}
    local i
    for i = 1, currentSlot do
        if TopFit.slotCounters[i] ~= nil and TopFit.slotCounters[i] > 0 then
            for stat, preferences in pairs(TopFit.Utopia) do
                if preferences.active then
                    local itemTable = TopFit:GetCachedItem(TopFit.itemListBySlot[i][TopFit.slotCounters[i]].itemLink)
                    if itemTable then
                        currentValues[stat] = (currentValues[stat] or 0) + (itemTable.totalBonus[stat] or 0)
                    end
                end
            end
        end
    end
    
    for stat, preferences in pairs(TopFit.Utopia) do
        if preferences.active and (currentValues[stat] or 0) < preferences.value then
            return false
        end
    end
    return true
end

function TopFit:IsCapsUnreachable(currentSlot)
    local currentValues = {}
    local restValues = {}
    local i
    for stat, preferences in pairs(TopFit.Utopia) do
        if preferences.active then
            for i = 1, currentSlot do
                if TopFit.slotCounters[i] ~= nil and TopFit.slotCounters[i] > 0 then
                    local itemTable = TopFit:GetCachedItem(TopFit.itemListBySlot[i][TopFit.slotCounters[i]].itemLink)
                    if itemTable then
                        currentValues[stat] = (currentValues[stat] or 0) + (itemTable.totalBonus[stat] or 0)
                    end
                end
            end
            
            for i = currentSlot + 1, 19 do
                restValues[stat] = (restValues[stat] or 0) + (TopFit.capHeuristics[stat][i] or 0)
            end
            
            if (currentValues[stat] or 0) + (restValues[stat] or 0) < preferences.value then
                TopFit:Debug("|cffff0000Caps unreachable - "..stat.." reached "..(currentValues[stat] or 0).." + "..(restValues[stat] or 0).." / "..preferences.value)
                return true
            end
        end
    end
    return false
end

function TopFit:IsDuplicateItem(currentSlot)
    -- check if the item is already equipped in another slot
    local i
    for i = 1, currentSlot - 1 do
        if TopFit.slotCounters[i] and TopFit.slotCounters[i] > 0 then
            local lTable1 = TopFit.itemListBySlot[i][TopFit.slotCounters[i]]
            local lTable2 = TopFit.itemListBySlot[currentSlot][TopFit.slotCounters[currentSlot]]
            if lTable1 and lTable2 and lTable1.itemLink == lTable2.itemLink and lTable1.bag == lTable2.bag and lTable1.slot == lTable2.slot then
                return true
            end
        end
    end
    return false
end

function TopFit:IsOffhandValid(currentSlot)
    if currentSlot == 17 then -- offhand slot
        if (TopFit.slotCounters[17] ~= nil) and (TopFit.slotCounters[17] > 0) and (TopFit.slotCounters[17] <= #(TopFit.itemListBySlot[17])) then -- offhand is set to something
            if (TopFit.slotCounters[16] == nil or TopFit.slotCounters[16] == 0) or -- no Mainhand is forced
                (TopFit:IsOnehandedWeapon(TopFit.itemListBySlot[16][TopFit.slotCounters[16]].itemLink)) then -- Mainhand is not a Two-Handed Weapon
                
                local itemTable = TopFit:GetCachedItem(TopFit.itemListBySlot[17][TopFit.slotCounters[17]].itemLink)
                if not itemTable then return false end
                
                if (not TopFit.playerCanDualWield) then
                    if (string.find(itemTable.itemEquipLoc, "WEAPON")) then
                        -- no weapon in offhand if you cannot dualwield
                        return false
                    end
                else -- player can dualwield
                    if (not TopFit:IsOnehandedWeapon(itemTable.itemID)) then
                        -- no 2h-weapon in offhand
                        return false
                    end
                end
            else
                -- a 2H-Mainhand is set, there can be no offhand!
                return false
            end
        end
    end
    return true
end

function TopFit:SaveCurrentCombination()
    TopFit.combinationCount = TopFit.combinationCount + 1
    
    local cIC = {
        items = {},
        totalScore = 0,
        totalStats = {},
    }
    
    local itemsAlreadyChosen = {}
    
    local i
    for i = 1, 20 do
        local itemTable, locationTable = nil, nil
        local stat, slotTable
        
        if TopFit.slotCounters[i] ~= nil and TopFit.slotCounters[i] > 0 then
            locationTable = TopFit.itemListBySlot[i][TopFit.slotCounters[i]]
            itemTable = TopFit:GetCachedItem(locationTable.itemLink)
        else
            -- choose highest valued item for otherwise empty slots, if possible
            locationTable = TopFit:CalculateBestInSlot(itemsAlreadyChosen, false, i)
            if locationTable then
                itemTable = TopFit:GetCachedItem(locationTable.itemLink)
            end
            
            if (itemTable) then
                -- special cases for main an offhand (to account for dualwielding and Titan's Grip)
                if (i == 16) then
                    -- check if offhand is forced
                    if TopFit.slotCounters[17] then
                        -- use 1H-weapon in Mainhand (or a titan's grip 2H, if applicable)
                        locationTable = TopFit:CalculateBestInSlot(itemsAlreadyChosen, false, i, TopFit.setCode, function(locationTable) return TopFit:IsOnehandedWeapon(locationTable.itemLink) end)
                        if locationTable then
                            itemTable = TopFit:GetCachedItem(locationTable.itemLink)
                        end
                    else
                        -- choose best main- and offhand combo
                        if not TopFit:IsOnehandedWeapon(itemTable.itemID) then
                            -- see if a combination of main and offhand would have a better score
                            local bestMainScore, bestOffScore = 0, 0
                            local bestOff = nil
                            local bestMain = TopFit:CalculateBestInSlot(itemsAlreadyChosen, false, i, TopFit.setCode, function(locationTable) return TopFit:IsOnehandedWeapon(locationTable.itemLink) end)
                            if bestMain ~= nil then
                                bestMainScore = (TopFit:GetItemScore(bestMain.itemLink, TopFit.setCode, TopFit.ignoreCapsForCalculation) or 0)
                            end
                            if (TopFit.playerCanDualWield) then
                                -- any non-two-handed offhand is fine
                                bestOff = TopFit:CalculateBestInSlot(TopFit:JoinTables(itemsAlreadyChosen, {bestMain}), false, i + 1, TopFit.setCode, function(locationTable) return TopFit:IsOnehandedWeapon(locationTable.itemLink) end)
                            else
                                -- offhand may not be a weapon (only shield, other offhand...)
                                bestOff = TopFit:CalculateBestInSlot(TopFit:JoinTables(itemsAlreadyChosen, {bestMain}), false, i + 1, TopFit.setCode, function(locationTable) local itemTable = TopFit:GetCachedItem(locationTable.itemLink); if not itemTable or string.find(itemTable.itemEquipLoc, "WEAPON") then return false else return true end end)
                            end
                            if bestOff ~= nil then
                                bestOffScore = (TopFit:GetItemScore(bestOff.itemLink, TopFit.setCode, TopFit.ignoreCapsForCalculation) or 0)
                            end
                            
                            -- alternatively, calculate offhand first, then mainhand
                            local bestMainScore2, bestOffScore2 = 0, 0
                            local bestMain2 = nil
                            local bestOff2 = nil
                            if (TopFit.playerCanDualWield) then
                                -- any non-two-handed offhand is fine
                                bestOff2 = TopFit:CalculateBestInSlot(itemsAlreadyChosen, false, i + 1, TopFit.setCode, function(locationTable) return TopFit:IsOnehandedWeapon(locationTable.itemLink) end)
                            else
                                -- offhand may not be a weapon (only shield, other offhand...)
                                bestOff2 = TopFit:CalculateBestInSlot(itemsAlreadyChosen, false, i + 1, TopFit.setCode, function(locationTable) local itemTable = TopFit:GetCachedItem(locationTable.itemLink); if not itemTable or string.find(itemTable.itemEquipLoc, "WEAPON") then return false else return true end end)
                            end
                            if bestOff2 ~= nil then
                                bestOffScore2 = (TopFit:GetItemScore(bestOff2.itemLink, TopFit.setCode, TopFit.ignoreCapsForCalculation) or 0)
                            end
                            
                            bestMain2 = TopFit:CalculateBestInSlot(TopFit:JoinTables(itemsAlreadyChosen, {bestOff2}), false, i, TopFit.setCode, function(locationTable) return TopFit:IsOnehandedWeapon(locationTable.itemLink) end)
                            if bestMain2 ~= nil then
                                bestMainScore2 = (TopFit:GetItemScore(bestMain2.itemLink, TopFit.setCode, TopFit.ignoreCapsForCalculation) or 0)
                            end
                            
                            local maxScore = (TopFit:GetItemScore(itemTable.itemLink, TopFit.setCode, TopFit.ignoreCapsForCalculation) or 0)
                            if (maxScore < (bestMainScore + bestOffScore)) then
                                -- main- + offhand is better, use the one-handed mainhand
                                locationTable = bestMain
                                if locationTable then
                                    itemTable = TopFit:GetCachedItem(locationTable.itemLink)
                                end
                                maxScore = bestMainScore + bestOffScore
                                --TopFit:Debug("Choosing Mainhand "..itemTable.itemLink)
                            end
                            if (maxScore < (bestMainScore2 + bestOffScore2)) then
                                -- main- + offhand is better, use the one-handed mainhand
                                locationTable = bestMain2
                                if locationTable then
                                    itemTable = TopFit:GetCachedItem(locationTable.itemLink)
                                end
                                --TopFit:Debug("Choosing Mainhand "..itemTable.itemLink)
                            end
                        end -- if mainhand would not be twohanded anyway, it can just be used
                    end
                elseif (i == 17) then
                    -- check if mainhand is empty or one-handed
                    if (not cIC.items[i - 1]) or (TopFit:IsOnehandedWeapon(cIC.items[i - 1].itemLink)) then
                        -- check if player can dual wield
                        if TopFit.playerCanDualWield then
                            -- only use 1H-weapons in Offhand
                            locationTable = TopFit:CalculateBestInSlot(itemsAlreadyChosen, false, i, TopFit.setCode, function(locationTable) return TopFit:IsOnehandedWeapon(locationTable.itemLink) end)
                            if locationTable then
                                itemTable = TopFit:GetCachedItem(locationTable.itemLink)
                            end
                        else
                            -- player cannot dualwield, only use offhands which are not weapons
                            locationTable = TopFit:CalculateBestInSlot(itemsAlreadyChosen, false, i, TopFit.setCode, function(locationTable) local itemTable = TopFit:GetCachedItem(locationTable.itemLink); if not itemTable or string.find(itemTable.itemEquipLoc, "WEAPON") then return false else return true end end)
                            if locationTable then
                                itemTable = TopFit:GetCachedItem(locationTable.itemLink)
                            end
                        end
                    else
                        -- Two-handed mainhand means we leave offhand empty
                        locationTable = nil
                        itemTable = nil
                    end
                end
            end
        end
        
        if locationTable and itemTable then -- slot will be filled
            tinsert(itemsAlreadyChosen, locationTable)
            cIC.items[i] = locationTable
            cIC.totalScore = cIC.totalScore + (TopFit:GetItemScore(itemTable.itemLink, TopFit.setCode, TopFit.ignoreCapsForCalculation) or 0)
            
            -- add total stats
            local stat, value
            for stat, value in pairs(itemTable.totalBonus) do
                if (cIC.totalStats[stat]) then
                    cIC.totalStats[stat] = cIC.totalStats[stat] + value
                else
                    cIC.totalStats[stat] = value
                end
            end
        end
    end
    
    -- check if it's better than old best
    local satisfied = true
    for stat, preferences in pairs(TopFit.Utopia) do
        if preferences.active and ((not cIC.totalStats[stat]) or (cIC.totalStats[stat] < tonumber(preferences["value"]))) then
            satisfied = false
        end
    end
    
    if ((satisfied) and ((TopFit.maxScore == nil) or (TopFit.maxScore < cIC.totalScore))) then
        TopFit.maxScore = cIC.totalScore
        TopFit.bestCombination = cIC
        
        TopFit.debugSlotCounters = {} -- save slot counters for best combination
        for i = 1, 20 do
            TopFit.debugSlotCounters[i] = TopFit.slotCounters[i]
        end
    end
end

-- now with assertion as optional parameter
function TopFit:CalculateBestInSlot(itemsAlreadyChosen, insert, sID, setCode, assertion)
    if not setCode then setCode = TopFit.setCode end

    -- get best item(s) for each equipment slot
    local bis = {}
    local itemListBySlot = TopFit.itemListBySlot or TopFit:GetEquippableItems()
    for slotID, itemsTable in pairs(itemListBySlot) do
        if ((not sID) or (sID == slotID)) then -- use single slot if sID is set, or all slots
            bis[slotID] = {}
            local maxScore = nil
            
            -- iterate all items of given location
            for _, locationTable in pairs(itemsTable) do
                local itemTable = TopFit:GetCachedItem(locationTable.itemLink)
                
                if (itemTable and ((maxScore == nil) or (maxScore < TopFit:GetItemScore(itemTable.itemLink, setCode, TopFit.ignoreCapsForCalculation))) -- score
                    and (itemTable.itemMinLevel <= TopFit.characterLevel or locationTable.isVirtual)) -- character level
                    and (not assertion or assertion(locationTable)) then -- optional assertion is true
                    -- also check if item has been chosen already (so we don't get the same ring / trinket twice)
                    local found = false
                    if (itemsAlreadyChosen) then
                        for _, lTable in pairs(itemsAlreadyChosen) do
                            if ((not lTable.bag and not lTable.slot) or ((lTable.bag == locationTable.bag) and (lTable.slot == locationTable.slot))) and (lTable.itemLink == locationTable.itemLink) then
                                found = true
                            end
                        end
                    end
                    
                    if not found then
                        bis[slotID].locationTable = locationTable
                        maxScore = TopFit:GetItemScore(itemTable.itemLink, setCode, TopFit.ignoreCapsForCalculation)
                    end
                end
            end
            
            if (not bis[slotID].locationTable) then
                -- remove dummy table if no item has been found
                bis[slotID] = nil
            else
                -- mark this item as used
                if (itemsAlreadyChosen and insert) then
                    tinsert(itemsAlreadyChosen, bis[slotID].locationTable)
                end
            end
        end
    end
    
    if (not sID) then
        return bis
    else
        -- return only the slot item's table (if it exists)
        if (bis[sID]) then
            return bis[sID].locationTable
        else
            return nil
        end
    end
end

function TopFit:IsOnehandedWeapon(itemID)
    _, _, _, _, _, class, subclass, _, equipSlot, _, _ = GetItemInfo(itemID)
    if equipSlot and string.find(equipSlot, "2HWEAPON") then
        if (TopFit.playerCanTitansGrip) then
            local polearms = select(7, GetAuctionItemSubClasses(1))
            local staves = select(10, GetAuctionItemSubClasses(1))
            local fishingPoles = select(17, GetAuctionItemSubClasses(1))
            if (subclass == polearms) or -- Polearms
                (subclass == staves) or -- Staves
                (subclass == fishingPoles) then -- Fishing Poles
                
                return false
            end
        else
            return false
        end
    end
    return true
end
