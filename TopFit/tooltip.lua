
-- Tooltip functions
local cleared = true
local refCleared = true
local s1Cleared = true
local s2Cleared = true

local function TooltipAddCompareLines(tt, link)
    local itemTable = TopFit:GetCachedItem(link)
    
    TopFit:Debug("Adding Compare Tooltip for "..(link or "nil"))
    
    -- if the item is not yet cached, no tooltip info is added
    if not itemTable then
        return
    end
    
    -- iterate all sets and compare with set's items
    tt:AddLine(" ")
    tt:AddLine("Compared with your current items for each set:")
    for setCode, setTable in pairs(TopFit.db.profile.sets) do
        if not TopFit.db.profile.sets[setCode].excludeFromTooltip then
            -- find current item(s) from set
            local itemPositions = GetEquipmentSetLocations(TopFit:GenerateSetName(setTable.name))
            local itemIDs = GetEquipmentSetItemIDs(TopFit:GenerateSetName(setTable.name))
            local itemLinks = {}
            if itemPositions then
                for slotID, itemLocation in pairs(itemPositions) do
                    if itemLocation and itemLocation ~= 1 and itemLocation ~= 0 then -- 0: set to no item; 1: slot is ignored
                        local itemLink = nil
                        local player, bank, bags, slot, bag = EquipmentManager_UnpackLocation(itemLocation)
                        if player then
                            if bank then
                                -- item is banked, use itemID
                                local itemID = GetEquipmentSetItemIDs(TopFit:GenerateSetName(TopFit.db.profile.sets[setCode].name))[slotID]
                                if itemID and itemID ~= 1 then
                                    _, itemLink = GetItemInfo(itemID)
                                end
                            elseif bags then
                                -- item is in player's bags
                                itemLink = GetContainerItemLink(bag, slot)
                            else
                                -- item is equipped
                                itemLink = GetInventoryItemLink("player", slot)
                            end
                        else
                            -- item not found
                        end
                        itemLinks[slotID] = itemLink
                    end
                end
                
                for _, slotID in pairs(itemTable.equipLocationsByType) do
                    -- get compare items sorted out
                    local itemID = nil
                    local itemLink = nil
                    local rawScore, asIsScore, rawCompareScore, asIsCompareScore = 0, 0, 0, 0
                    local extraText = ""
                    local compareTable = nil
                    local itemTable2 = nil
                    local compareTable2 = nil
                    local compareNotCached = false
                    
                    rawScore = TopFit:GetItemScore(itemTable.itemLink, setCode, false, true) -- including caps, raw score
                    asIsScore = TopFit:GetItemScore(itemTable.itemLink, setCode, false, false) -- including caps, enchanted score
                    
                    if itemIDs and itemIDs[slotID] and itemIDs[slotID] ~= 1 and itemIDs[slotID] ~= 0 then
                        itemID = itemIDs[slotID]
                        itemLink = itemLinks[slotID]
                        
                        if itemLink then
                            compareTable = TopFit:GetCachedItem(itemLink)
                        end
                        
                        if compareTable then
                            rawCompareScore = TopFit:GetItemScore(compareTable.itemLink, setCode, false, true)
                            asIsCompareScore = TopFit:GetItemScore(compareTable.itemLink, setCode, false, false)
                        else
                            compareNotCached = true
                        end
                    end
                    
                    -- location tables for best-in-slot requests
                    local locationTable, compLocationTable
                    if (slotID == 16 or slotID == 17) then
                        locationTable = {itemLink = itemTable.itemLink, slot = nil, bag = nil}
                        if compareTable then
                            local player, bank, bags, slot, bag = EquipmentManager_UnpackLocation(itemPositions[slotID])
                            if player then
                                if bags then
                                    compLocationTable = {itemLink = compareTable.itemLink, slot = slot, bag = bag}
                                elseif bank then
                                    compLocationTable = {itemLink = compareTable.itemLink, slot = nil, bag = nil}
                                else
                                    compLocationTable = {itemLink = compareTable.itemLink, slot = slot, bag = nil}
                                end
                            else
                                compLocationTable = {itemLink = compareTable.itemLink, slot = nil, bag = nil}
                            end
                        else
                            compLocationTable = {itemLink = "", slot = nil, bag = nil}
                        end
                    end
                    
                    if slotID == 16 then -- main hand slot
                        if TopFit:IsOnehandedWeapon(link) then
                            -- is the weapon we compare to (if it exists) two-handed?
                            if itemIDs and itemIDs[slotID] and itemIDs[slotID] ~= 1 and itemIDs[slotID] ~= 0 and not TopFit:IsOnehandedWeapon(itemIDs[slotID]) then
                                -- try to find a fitting offhand for better comparison
                                if TopFit.playerCanDualwield then
                                    -- find best offhand regardless of type
                                    local lTable2 = TopFit:CalculateBestInSlot({locationTable, compLocationTable}, false, 17, setCode, function(locationTable) return TopFit:IsOnehandedWeapon(locationTable.itemLink) end)
                                    if lTable2 then
                                        itemTable2 = TopFit:GetCachedItem(lTable2.itemLink)
                                    end
                                else
                                    -- find best offhand that is not a weapon
                                    local lTable2 = TopFit:CalculateBestInSlot({locationTable, compLocationTable}, false, 17, setCode, function(locationTable) itemTable = TopFit:GetCachedItem(locationTable.itemLink); if not itemTable or string.find(itemTable.itemEquipLoc, "WEAPON") then return false else return true end end)
                                    if lTable2 then
                                        itemTable2 = TopFit:GetCachedItem(lTable2.itemLink)
                                    end
                                end
                            else
                            end
                        else
                            if itemIDs and itemIDs[slotID] and itemIDs[slotID] ~= 1 then
                                -- mainhand is set
                                if TopFit:IsOnehandedWeapon(itemIDs[slotID]) then
                                    -- use offhand of that set as second compare item
                                    if (itemLinks[17]) then
                                        compareTable2 = TopFit:GetCachedItem(itemLinks[17])
                                    end
                                else
                                    -- compare normally, these are 2 two-handed weapons
                                end
                            else
                                -- compare with offhand if appliccapble
                                if (itemLinks[17]) then
                                    compareTable2 = TopFit:GetCachedItem(itemLinks[17])
                                end
                            end
                        end
                    elseif slotID == 17 then -- offhand slot
                        -- find a valid mainhand to use in comparisons (only when comparing to a 2h)
                        if itemIDs and itemIDs[16] and itemIDs[16] ~= 1 and not TopFit:IsOnehandedWeapon(itemIDs[16]) then
                            local lTable2 = TopFit:CalculateBestInSlot({locationTable, compLocationTable}, false, 16, setCode, function(locationTable) return TopFit:IsOnehandedWeapon(locationTable.itemLink) end)
                            if lTable2 then
                                itemTable2 = TopFit:GetCachedItem(lTable2.itemLink)
                            end
                            
                            -- also set compareTable to the relevant MAIN HAND! since offhand is empty, obviously
                            compareTable = TopFit:GetCachedItem(itemLinks[16])
                            
                            if compareTable then
                                rawCompareScore = TopFit:GetItemScore(compareTable.itemLink, setCode, false, true)
                                asIsCompareScore = TopFit:GetItemScore(compareTable.itemLink, setCode, false, false)
                            else
                                compareNotCached = true
                            end
                        end
                    end
                    
                    if itemTable2 then
                        rawScore = rawScore + TopFit:GetItemScore(itemTable2.itemLink, setCode, false, true)
                        asIsScore = asIsScore + TopFit:GetItemScore(itemTable2.itemLink, setCode, false, false)
                        
                        extraText = extraText..", if you also use "..itemTable2.itemLink
                    end
                    
                    if compareTable2 then
                        rawCompareScore = rawCompareScore + TopFit:GetItemScore(compareTable2.itemLink, setCode, false, true)
                        asIsCompareScore = asIsCompareScore + TopFit:GetItemScore(compareTable2.itemLink, setCode, false, false)
                        
                        extraText = extraText..", "..compareTable2.itemLink
                    end
                    
                    local ratio, rawRatio, ratioString, rawRatioString = 1, 1, "", ""
                    if rawCompareScore ~= 0 then
                        rawRatio = rawScore / rawCompareScore
                    elseif rawScore > 0 then
                        rawRatio = 20
                    elseif rawScore < 0 then
                        rawRatio = -20
                    end
                    if asIsCompareScore ~= 0 then
                        ratio = asIsScore / asIsCompareScore
                    elseif asIsScore > 0 then
                        ratio = 20
                    elseif asIsScore < 0 then
                        ratio = -20
                    end
                    
                    local function percentilize(ratio)
                        local ratioString
                        if ratio > 11 then
                            ratioString = "|cff00ff00> 1000%|r"
                        elseif ratio > 1.1 then
                            ratioString = "|cff00ff00"..round((ratio - 1) * 100, 2).."%|r"
                        elseif ratio >= 1 then
                            ratioString = "|cffffff00"..round((ratio - 1) * 100, 2).."%|r"
                        elseif ratio < -9 then
                            ratioString = "|cffff0000< -1000%|r"
                        else -- ratio < 1
                            ratioString = "|cffff0000"..round((ratio - 1) * 100, 2).."%|r"
                        end
                        return ratioString
                    end
                    
                    local compareItemText = ""
                    if compareNotCached then
                        compareItemText = "Item not in cache!|n"
                    elseif not compareTable then
                        compareItemText = "No item in set"
                    else
                        compareItemText = compareTable.itemLink
                    end
                    
                    if ratio ~= rawRatio then
                        tt:AddDoubleLine("["..percentilize(rawRatio).."/"..percentilize(ratio).."] - "..compareItemText..extraText, setTable.name)
                    else
                        tt:AddDoubleLine("["..percentilize(rawRatio).."] - "..compareItemText..extraText, setTable.name)
                    end
                end
            end
        end
    end
end

local function TooltipAddLines(tt, link)
    local itemTable = TopFit:GetCachedItem(link)
    
    if not itemTable then return end
    
    if (TopFit.db.profile.debugMode) then
        -- item stats
        tt:AddLine("Item stats as seen by TopFit:", 0.5, 0.9, 1)
        for stat, value in pairs(itemTable["itemBonus"]) do
            if not string.find(stat, "SET: ") then
                local valueString = ""
                local first = true
                for _, setTable in pairs(TopFit.db.profile.sets) do
                    local weightedValue = (setTable.weights[stat] or 0) * value
                    if first then
                        first = false
                    else
                        valueString = valueString.." / "
                    end
                    valueString = valueString..(tonumber(weightedValue) or "0")
                end
                tt:AddDoubleLine("  +"..value.." ".._G[stat], valueString, 0.5, 0.9, 1)
            end
        end
        
        -- enchantment stats
        if (itemTable["enchantBonus"]) then
            tt:AddLine("Enchant:", 1, 0.9, 0.5)
            for stat, value in pairs(itemTable["enchantBonus"]) do
                local valueString = ""
                local first = true
                for _, setTable in pairs(TopFit.db.profile.sets) do
                    local weightedValue = (setTable.weights[stat] or 0) * value
                    if first then
                        first = false
                    else
                        valueString = valueString.." / "
                    end
                    valueString = valueString..(tonumber(weightedValue) or "0")
                end
                tt:AddDoubleLine("  +"..value.." ".._G[stat], valueString, 1, 0.9, 0.5)
            end
        end
        
        -- gems
        if (itemTable["gemBonus"]) then
            local first = true
            for stat, value in pairs(itemTable["gemBonus"]) do
                if first then
                    first = false
                    tt:AddLine("Gems:", 0.8, 0.2, 0)
                end
                
                local valueString = ""
                local first = true
                for _, setTable in pairs(TopFit.db.profile.sets) do
                    local weightedValue = (setTable.weights[stat] or 0) * value
                    if first then
                        first = false
                    else
                        valueString = valueString.." / "
                    end
                    valueString = valueString..(tonumber(weightedValue) or "0")
                end
                tt:AddDoubleLine("  +"..value.." ".._G[stat], valueString, 0.8, 0.2, 0)
            end
        end
    end
    
    if (TopFit.db.profile.showTooltip) then
        -- scores for sets
        local first = true
        for setCode, setTable in pairs(TopFit.db.profile.sets) do
            if not TopFit.db.profile.sets[setCode].excludeFromTooltip then
                if first then
                    first = false
                    tt:AddLine("Set Values:", 0.6, 1, 0.7)
                end
                
                tt:AddLine("  "..round(TopFit:GetItemScore(itemTable.itemLink, setCode), 2).." - "..setTable.name, 0.6, 1, 0.7)
            end
        end
    end
end

local function OnTooltipCleared(self)
    cleared = true   
end

local function OnTooltipSetItem(self)
    if cleared then
        local name, link = self:GetItem()
        if (name) then
            local equippable = IsEquippableItem(link)
            if (not equippable) then
                -- Do nothing
            else
                TooltipAddLines(self, link)
                if (TopFit.db.profile.showComparisonTooltip and not TopFit.isBlocked) then
                    TooltipAddCompareLines(self, link)
                end
            end
            cleared = false
        end
    end
end

local function OnRefTooltipCleared(self)
    refCleared = true   
end

local function OnRefTooltipSetItem(self)
    if refCleared then
        local name, link = self:GetItem()
        if (name) then
            local equippable = IsEquippableItem(link)
            if (not equippable) then
                -- Do nothing
            else
                TooltipAddLines(self, link)
                if (TopFit.db.profile.showComparisonTooltip and not TopFit.isBlocked) then
                    TooltipAddCompareLines(self, link)
                end
            end
            refCleared = false
        end
    end
end

local function OnShoppingTooltip1Cleared(self)
    s1Cleared = true   
end

local function OnShoppingTooltip1SetItem(self)
    if s1Cleared then
        local name, link = self:GetItem()
        if (name) then
            local equippable = IsEquippableItem(link)
            if (not equippable) then
                -- Do nothing
            else
                TooltipAddLines(self, link)
            end
            s1Cleared = false
        end
    end
end

local function OnShoppingTooltip2Cleared(self)
    s2Cleared = true   
end

local function OnShoppingTooltip2SetItem(self)
    if s2Cleared then
        local name, link = self:GetItem()
        if (name) then
            local equippable = IsEquippableItem(link)
            if (not equippable) then
                -- Do nothing
            else
                TooltipAddLines(self, link)
            end
            s2Cleared = false
        end
    end
end

GameTooltip:HookScript("OnTooltipCleared", OnTooltipCleared)
GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
ItemRefTooltip:HookScript("OnTooltipCleared", OnRefTooltipCleared)
ItemRefTooltip:HookScript("OnTooltipSetItem", OnRefTooltipSetItem)
ShoppingTooltip1:HookScript("OnTooltipCleared", OnShoppingTooltip1Cleared)
ShoppingTooltip1:HookScript("OnTooltipSetItem", OnShoppingTooltip1SetItem)
ShoppingTooltip2:HookScript("OnTooltipCleared", OnShoppingTooltip2Cleared)
ShoppingTooltip2:HookScript("OnTooltipSetItem", OnShoppingTooltip2SetItem)
