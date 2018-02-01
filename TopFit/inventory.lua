--[[ inventory management and caching

interesting variables:
TopFit.itemsCache - item Tables, indexed by itemLink
TopFit.scoresCache - scores, indexed by itemLink and setCode

]]--

local function tinsertonce(table, data)
    local found = false
    for _, v in pairs(table) do
        if v == data then
            found = true
            break
        end
    end
    if not found then
        tinsert(table, data)
    end
end

-- gather all items from inventory and bags, save their info to cache
function TopFit:collectItems(bag)
    TopFit.characterLevel = UnitLevel("player")
    
    if bag and bag >= 0 and bag <= 4 then
        -- only check a specific bag (used on BAG_UPDATE)
        for slot = 1, GetContainerNumSlots(bag) do
            local item = GetContainerItemLink(bag, slot)
            
            TopFit:UpdateCache(item)
        end
    else
        -- check bags
        for bag = 0, 4 do
            for slot = 1, GetContainerNumSlots(bag) do
                local item = GetContainerItemLink(bag, slot)
                
                TopFit:UpdateCache(item)
            end
        end
        
        -- check equipped items
        for _, invSlot in pairs(TopFit.slots) do
            local item = GetInventoryItemLink("player", invSlot)
            
            TopFit:UpdateCache(item)
        end
    end
end

-- collect item information if necessary
function TopFit:UpdateCache(item)
    if item and (not TopFit.itemsCache[item]) then
        -- check if it's equipment
        if IsEquippableItem(item) then
            local itemTable = TopFit:GetItemInfoTable(item)
            
            if itemTable then
                -- save in cache
                TopFit.itemsCache[item] = itemTable
                
                -- calculate set scores
                TopFit:CalculateItemScore(item)
            end
        end
    end
end

-- find out all we need to know about an item. and maybe even more
-- this does not return information which might change, only things you can get from the item link
function TopFit:GetItemInfoTable(item)
    local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(item)
    if itemLink then
        -- generate item info
        local itemID = string.gsub(itemLink, ".*|Hitem:([0-9]*):.*", "%1")
        itemID = tonumber(itemID)
    
        local enchantID = string.gsub(itemLink, ".*|Hitem:[0-9]*:([0-9]*):.*", "%1")
        enchantID = tonumber(enchantID)
        
        -- item stats
        local itemBonus = GetItemStats(itemLink)
        
        -- gems
        local gemBonus = {}
        local gems = {}
        for i = 1, 3 do
            local _, gem = GetItemGem(item, i) -- name, itemlink
            if gem then
                gems[i] = gem
                
                local gemID = string.gsub(gem, ".*|Hitem:([0-9]*):.*", "%1")
                gemID = tonumber(gemID)
                if (TopFit.gemIDs[gemID]) then
                    -- collect stats
                    
                    for stat, value in pairs(TopFit.gemIDs[gemID].stats) do
                        if (gemBonus[stat]) then
                            gemBonus[stat] = gemBonus[stat] + value
                        else
                            gemBonus[stat] = value
                        end
                    end
                else
                    -- unknown gem, tell the user
                    TopFit:Warning("Could not identify gem "..i.." ("..gem..") of your "..itemLink..". Please tell the author so its stats can be added.")
                end
            end
        end
            
        if #gems > 0 then       
            -- try to find socket bonus by scanning item tooltip (though I hoped to avoid that entirely)
            --TODO: this will have to be rewritten to be calculated on the fly at some point. meta gem requirements will not always work this way
            TopFit.scanTooltip:SetOwner(UIParent, 'ANCHOR_NONE')
            TopFit.scanTooltip:SetHyperlink(itemLink)
            local numLines = TopFit.scanTooltip:NumLines()
            
            local socketBonusString = _G["ITEM_SOCKET_BONUS"] -- "Socket Bonus: %s" in enUS client, for example
            socketBonusString = string.gsub(socketBonusString, "%%s", "(.*)")
            
            local socketBonusIsActive = false
            local socketBonus = nil
            for i = 1, numLines do
                local leftLine = getglobal("TFScanTooltip".."TextLeft"..i)
                local leftLineText = leftLine:GetText()
                
                if string.find(leftLineText, socketBonusString) then
                    -- This line is the socket bonus.
                    if leftLine.GetTextColor then
                        socketBonusIsActive = (leftLine:GetTextColor() == 0) -- green's red component is 0, but grey's red component is .5      
                    else
                        socketBonusIsActive = true -- we can't get the text color, so we assume the bonus is active
                    end
                    
                    socketBonus = string.gsub(leftLineText, "^"..socketBonusString.."$", "%1")
                    break
                end
            end
            
            if (socketBonusIsActive) then
                -- go through our stats to find the bonus
                for _, sTable in pairs(TopFit.statList) do
                    for _, statCode in pairs(sTable) do
                        if (string.find(socketBonus, _G[statCode])) then -- simple short stat codes like "Intellect", "Hit Rating"
                            local bonusValue = string.gsub(socketBonus, _G[statCode], "")
                            
                            bonusValue = (tonumber(bonusValue) or 0)
                            
                            if (gemBonus[statCode]) then
                                gemBonus[statCode] = gemBonus[statCode] + bonusValue
                            else
                                gemBonus[statCode] = bonusValue
                            end
                        end
                    end
                end
            end
            
            TopFit.scanTooltip:Hide()
        end
        
        -- enchantment
        local enchantBonus = {}
        if enchantID > 0 then
            for _, slotID in pairs(TopFit.slots) do
                if (TopFit.enchantIDs[slotID] and TopFit.enchantIDs[slotID][enchantID]) then
                    enchantBonus = TopFit.enchantIDs[slotID][enchantID]
                end
            end
        end
        
        -- scan for setname
        TopFit.scanTooltip:SetOwner(UIParent, 'ANCHOR_NONE')
        TopFit.scanTooltip:SetHyperlink(itemLink)
        local numLines = TopFit.scanTooltip:NumLines()
        local setName = nil
        for i = 1, numLines do
            local leftLine = getglobal("TFScanTooltip".."TextLeft"..i)
            local leftLineText = leftLine:GetText()
            
            if string.find(leftLineText, "(.*)%s%([0-9]+/[0-9+]%)") then
                setName = select(3, string.find(leftLineText, "(.*)%s%([0-9]+/[0-9+]%)"))
                break
            end
        end
        
        -- add set name
        if setName then
            itemBonus["SET: "..setName] = 1
        end
        
        -- dirty little mana regen fix!
        --TODO: better synonim handling
        itemBonus["ITEM_MOD_MANA_REGENERATION_SHORT"] = ((itemBonus["ITEM_MOD_POWER_REGEN0_SHORT"] or 0) + (itemBonus["ITEM_MOD_MANA_REGENERATION_SHORT"] or 0))
        itemBonus["ITEM_MOD_POWER_REGEN0_SHORT"] = nil
        if (itemBonus["ITEM_MOD_MANA_REGENERATION_SHORT"] == 0) then itemBonus["ITEM_MOD_MANA_REGENERATION_SHORT"] = nil end
        
        gemBonus["ITEM_MOD_MANA_REGENERATION_SHORT"] = ((gemBonus["ITEM_MOD_POWER_REGEN0_SHORT"] or 0) + (gemBonus["ITEM_MOD_MANA_REGENERATION_SHORT"] or 0))
        gemBonus["ITEM_MOD_POWER_REGEN0_SHORT"] = nil
        if (gemBonus["ITEM_MOD_MANA_REGENERATION_SHORT"] == 0) then gemBonus["ITEM_MOD_MANA_REGENERATION_SHORT"] = nil end
        
        enchantBonus["ITEM_MOD_MANA_REGENERATION_SHORT"] = ((gemBonus["ITEM_MOD_POWER_REGEN0_SHORT"] or 0) + (gemBonus["ITEM_MOD_MANA_REGENERATION_SHORT"] or 0))
        enchantBonus["ITEM_MOD_POWER_REGEN0_SHORT"] = nil
        if (enchantBonus["ITEM_MOD_MANA_REGENERATION_SHORT"] == 0) then enchantBonus["ITEM_MOD_MANA_REGENERATION_SHORT"] = nil end
        
        -- calculate total values
        local totalBonus = {}
        for _, bonusTable in pairs({itemBonus, gemBonus, enchantBonus}) do
            for stat, value in pairs(bonusTable) do
                totalBonus[stat] = (totalBonus[stat] or 0) + value
            end
        end
        
        local result = {
            ["itemLink"] = itemLink,
            ["itemID"] = itemID,
            ["itemQuality"] = itemQuality,
            ["itemMinLevel"] = itemMinLevel,
            ["itemEquipLoc"] = itemEquipLoc,
            ["itemBonus"] = itemBonus,
            ["gems"] = gems,
            ["enchantBonus"] = enchantBonus,
            ["gemBonus"] = gemBonus,
            ["equipLocationsByType"] = TopFit:GetEquipLocationsByInvType(itemEquipLoc),
            ["totalBonus"] = totalBonus,
        }
        
        return result
    else
        return nil
    end
end

-- calculate an item's score relative to a given set
function TopFit:CalculateItemScore(itemLink)
    local itemTable = TopFit:GetCachedItem(itemLink)
    if not itemTable then return end
    
    for setCode, setTable in pairs(TopFit.db.profile.sets) do
        local set = setTable.weights
        local caps = setTable.caps
        
        -- calculate item score
        local itemScore = 0
        local capsModifier = 0
        -- iterate given weights
        for stat, statValue in pairs(set) do
            if itemTable.totalBonus[stat] then
                -- check for hard cap on this stat
                if ((not caps) or (not caps[stat]) or (not caps[stat]["active"]) or (caps[stat]["soft"])) then
                    itemScore = itemScore + statValue * itemTable.totalBonus[stat]
                else
                    -- part of hard cap, score calculated extra
                    capsModifier = capsModifier + statValue * itemTable.totalBonus[stat]
                end
            end
        end
        
        -- also calculate raw item score
        local rawScore = 0
        local rawModifier = 0
        -- iterate given weights
        for stat, statValue in pairs(set) do
            if itemTable.itemBonus[stat] then
                -- check for hard cap on this stat
                if ((not caps) or (not caps[stat]) or (not caps[stat]["active"]) or (caps[stat]["soft"])) then
                    rawScore = rawScore + statValue * itemTable.itemBonus[stat]
                else
                    -- part of hard cap, score calculated extra
                    rawModifier = rawModifier + statValue * itemTable.totalBonus[stat]
                end
            end
        end
        
        if not TopFit.scoresCache[itemLink] then
            TopFit.scoresCache[itemLink] = {}
        end
        
        --TODO: could be rewritten slightly to save some tables
        TopFit.scoresCache[itemLink][setCode] = {
            itemScore = itemScore,
            itemScoreWithoutCaps = itemScore + capsModifier,
            rawScore = rawScore,
            rawScoreWithoutCaps = rawScore + rawModifier,
        }
    end
end

-- calculate item scores
function TopFit:CalculateScores()
    -- iterate all cached items and recalculate their scores
    for itemLink, _ in pairs(TopFit.itemsCache) do
        TopFit:CalculateItemScore(itemLink)
    end
end

-- used by tooltip to decide which item slots to compare to
function TopFit:GetEquipLocationsByInvType(itemEquipLoc)
    if itemEquipLoc == "INVTYPE_2HWEAPON" then
        --TODO: check weapon type
        return {16}
    elseif itemEquipLoc == "INVTYPE_BODY" then
        return {4}
    elseif itemEquipLoc == "INVTYPE_CHEST" or itemEquipLoc == "INVTYPE_ROBE" then
        return {5}
    elseif itemEquipLoc == "INVTYPE_CLOAK" then
        return {15}
    elseif itemEquipLoc == "INVTYPE_FEET" then
        return {8}
    elseif itemEquipLoc == "INVTYPE_FINGER" then
        return {11, 12}
    elseif itemEquipLoc == "INVTYPE_HAND" then
        return {10}
    elseif itemEquipLoc == "INVTYPE_HEAD" then
        return {1}
    elseif itemEquipLoc == "INVTYPE_HOLDABLE" or itemEquipLoc == "INVTYPE_SHIELD" then
        return {17}
    elseif itemEquipLoc == "INVTYPE_LEGS" then
        return {7}
    elseif itemEquipLoc == "INVTYPE_NECK" then
        return {2}
    elseif itemEquipLoc == "INVTYPE_RANGED" or itemEquipLoc == "INVTYPE_RANGEDRIGHT" or itemEquipLoc == "INVTYPE_RELIC" or itemEquipLoc == "INVTYPE_THROWN" then
        return {18}
    elseif itemEquipLoc == "INVTYPE_SHOULDER" then
        return {3}
    elseif itemEquipLoc == "INVTYPE_TABARD" then
        return {19}
    elseif itemEquipLoc == "INVTYPE_TRINKET" then
        return {13, 14}
    elseif itemEquipLoc == "INVTYPE_WAIST" then
        return {6}
    elseif itemEquipLoc == "INVTYPE_WEAPON" then
        return {16, 17}
    elseif itemEquipLoc == "INVTYPE_WEAPONMAINHAND" then
        return {16}
    elseif itemEquipLoc == "INVTYPE_WEAPONOFFHAND" then
        return {17}
    elseif itemEquipLoc == "INVTYPE_WRIST" then
        return {9}
    end
    -- default / invalid location
    return {}
end



-- returns all equippable items, limited by slot, if given
function TopFit:GetEquippableItems(requestedSlotID)
    local itemListBySlot = {}
    local availableSlots = {}

    -- find available item ids for each slot
    for slotName, slotID in pairs(TopFit.slots) do
        itemListBySlot[slotID] = {}
        slotAvailableItems = GetInventoryItemsForSlot(slotID)
        if (slotAvailableItems) then
            for availableLocation, availableItemID in pairs(slotAvailableItems) do
                if (not availableSlots[availableItemID]) then
                    availableSlots[availableItemID] = { slotID }
                else
                    tinsertonce(availableSlots[availableItemID], slotID)
                end
            end
        end
        
        -- special handling for plate heirlooms
        if (TopFit.heirloomInfo.isPlateWearer and (slotID == 3 or slotID == 5) and UnitLevel("player") < 40) then
            for i = 1, #(TopFit.heirloomInfo.plateHeirlooms[slotID]) do
                if (not availableSlots[TopFit.heirloomInfo.plateHeirlooms[slotID][i]]) then
                    availableSlots[TopFit.heirloomInfo.plateHeirlooms[slotID][i]] = { slotID }
                else
                    tinsertonce(availableSlots[TopFit.heirloomInfo.plateHeirlooms[slotID][i]], slotID)
                end
            end
        end
        
        -- special handling for mail heirlooms
        if (TopFit.heirloomInfo.isMailWearer and (slotID == 3 or slotID == 5) and UnitLevel("player") < 40) then
            for i = 1, #(TopFit.heirloomInfo.mailHeirlooms[slotID]) do
                if (not availableSlots[TopFit.heirloomInfo.mailHeirlooms[slotID][i]]) then
                    availableSlots[TopFit.heirloomInfo.mailHeirlooms[slotID][i]] = { slotID }
                else
                    tinsertonce(availableSlots[TopFit.heirloomInfo.mailHeirlooms[slotID][i]], slotID)
                end
            end
        end
    end
    
    -- check player's bags
    for bag = 0, 4 do
        for slot = 1, GetContainerNumSlots(bag) do
            local itemLink = GetContainerItemLink(bag, slot)
            if itemLink then
                local itemID = string.gsub(itemLink, ".*|Hitem:([0-9]*):.*", "%1")
                itemID = tonumber(itemID)
                
                if (availableSlots[itemID]) then
                    -- check if item is BoE
                    local isBoE = false
                    TopFit.scanTooltip:SetOwner(UIParent, 'ANCHOR_NONE')
                    TopFit.scanTooltip:SetBagItem(bag, slot)
                    local numLines = TopFit.scanTooltip:NumLines()
                    for i = 1, numLines do
                        local leftLine = getglobal("TFScanTooltip".."TextLeft"..i)
                        local leftLineText = leftLine:GetText()
                        
                        if string.find(leftLineText, _G["ITEM_BIND_ON_EQUIP"]) then
                            isBoE = true
                            break
                        end
                    end
                    
                    for _, slotID in pairs(availableSlots[itemID]) do
                        tinsert(itemListBySlot[slotID], {
                            itemLink = itemLink,
                            isBoE = isBoE,
                            bag = bag,
                            slot = slot
                        })
                    end
                end
            end
        end
    end
    
    -- check player's inventory
    for _, invSlot in pairs(TopFit.slots) do
        local itemLink = GetInventoryItemLink("player", invSlot)
        if itemLink then
            local itemID = string.gsub(itemLink, ".*|Hitem:([0-9]*):.*", "%1")
            itemID = tonumber(itemID)
            
            if (availableSlots[itemID]) then
                for _, slotID in pairs(availableSlots[itemID]) do
                    tinsert(itemListBySlot[slotID], {
                        itemLink = itemLink,
                        isBoE = false, -- it is already equipped
                        slot = invSlot
                    })
                end
            end
        end
    end
    
    -- add virtual items
    if (TopFit.setCode and TopFit.db.profile.sets[TopFit.setCode].virtualItems and not TopFit.db.profile.sets[TopFit.setCode].skipVirtualItems) then
        for _, itemLink in pairs(TopFit.db.profile.sets[TopFit.setCode].virtualItems) do
            local item = TopFit:GetCachedItem(itemLink)
            local equipSlots = TopFit:GetEquipLocationsByInvType(item.itemEquipLoc)
            for _, slotID in pairs(equipSlots) do
                tinsert(itemListBySlot[slotID], {
                    itemLink = itemLink,
                    isBoE = false, -- if it's in virtual items, we want to include it
                    isVirtual = true
                })
            end
        end
    end
    
    if (requestedSlotID) then
        return itemListBySlot[requestedSlotID]
    else
        return itemListBySlot
    end
end

function TopFit:GetItemScore(itemLink, setCode, dontUseCaps, useRawItem)
    if not TopFit.scoresCache[itemLink] or not TopFit.scoresCache[itemLink][setCode] then return 0 end
    
    if dontUseCaps then
        if useRawItem then
            return TopFit.scoresCache[itemLink][setCode].rawScoreWithoutCaps
        else
            return TopFit.scoresCache[itemLink][setCode].itemScoreWithoutCaps
        end
    else
        if useRawItem then
            return TopFit.scoresCache[itemLink][setCode].rawScore
        else
            return TopFit.scoresCache[itemLink][setCode].itemScore
        end
    end
end

-- gets an item's info from the cache
function TopFit:GetCachedItem(itemLink)
    if not itemLink then return nil end
    TopFit:UpdateCache(itemLink)
    
    return TopFit.itemsCache[itemLink]
end
