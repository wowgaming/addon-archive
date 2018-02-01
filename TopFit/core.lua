
-- utility for rounding
function round(input, places)
    if not places then
        places = 0
    end
    if type(input) == "number" and type(places) == "number" then
        local pow = 1
        for i = 1, ceil(places) do
            pow = pow * 10
        end
        return floor(input * pow + 0.5) / pow
    else
        return input
    end
end

-- for keeping a set's icon intact when it is updated
local function GetTextureIndex(tex) -- blatantly stolen from Tekkubs EquipSetUpdate. Thanks!
    RefreshEquipmentSetIconInfo()
    tex = tex:lower()
    local numicons = GetNumMacroIcons()
    for i = INVSLOT_FIRST_EQUIPPED,INVSLOT_LAST_EQUIPPED do if GetInventoryItemTexture("player", i) then numicons = numicons + 1 end end
    for i = 1, numicons do
        local texture, index = GetEquipmentSetIconInfo(i)
        if texture:lower() == tex then return index end
    end
end

-- create Addon object
TopFit = LibStub("AceAddon-3.0"):NewAddon("TopFit", "AceConsole-3.0")

-- debug function
function TopFit:Debug(text)
    if self.db.profile.debugMode then
        TopFit:Print("Debug: "..text)
    end
end

-- debug function
function TopFit:Warning(text)
    --TODO: create table of warnings and dont print any multiples
    --TopFit:Print("|cffff0000Warning: "..text)
end

-- joins any number of tables together, one after the other. elements within the input-tables will get mixed, though
function TopFit:JoinTables(...)
    local result = {}
    local tab
    
    for i = 1, select("#", ...) do
        tab = select(i, ...)
        if tab then
            for index, value in pairs(tab) do
                tinsert(result, value)
            end
        end
    end
    
    return result
end

function TopFit:EquipRecommendedItems()
    -- skip equipping if virtual items were included
    if (not TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].skipVirtualItems) and TopFit.db.profile.sets[TopFit.setCode].virtualItems and #(TopFit.db.profile.sets[TopFit.setCode].virtualItems) > 0 then
        TopFit:Print("No items will be equipped because virtual items were included in the set calculation.")
        
        -- reenable options and quit
        TopFit.ProgressFrame:StoppedCalculation()
        TopFit.isBlocked = false
        
        -- reset relevant score field
        TopFit.ignoreCapsForCalculation = nil
        
        -- initiate next calculation if necessary
        if (#TopFit.workSetList > 0) then
            TopFit:CalculateSets()
        end
        return
    end
    
    -- equip them
    TopFit.updateEquipmentCounter = 10000
    TopFit.equipRetries = 0
    TopFit.updateFrame:SetScript("OnUpdate", TopFit.onUpdateForEquipment)
end

function TopFit:onUpdateForEquipment()
    -- don't try equipping in combat or while dead
    if UnitAffectingCombat("player") or UnitIsDeadOrGhost("player") then
        return
    end

    -- see if all items already fit
    allDone = true
    for slotID, recTable in pairs(TopFit.itemRecommendations) do
        if (TopFit:GetItemScore(recTable.locationTable.itemLink, TopFit.setCode, TopFit.ignoreCapsForCalculation) > 0) then
            slotItemLink = GetInventoryItemLink("player", slotID)
            if (slotItemLink ~= recTable.locationTable.itemLink) then
                allDone = false
            end
        end
    end
    
    TopFit.updateEquipmentCounter = TopFit.updateEquipmentCounter + 1
    
    -- try equipping the items every 100 frames (some weird ring positions might stop us from correctly equipping items on the first try, for example)
    if (TopFit.updateEquipmentCounter > 100) then
        for slotID, recTable in pairs(TopFit.itemRecommendations) do
            slotItemLink = GetInventoryItemLink("player", slotID)
            if (slotItemLink ~= recTable.locationTable.itemLink) then
                -- find itemLink in bags
                local itemTable = nil
                local found = false
                local foundBag, foundSlot
                for bag = 0, 4 do
                    for slot = 1, GetContainerNumSlots(bag) do
                        local itemLink = GetContainerItemLink(bag,slot)
                        
                        if itemLink == recTable.locationTable.itemLink then
                            foundBag = bag
                            foundSlot = slot
                            found = true
                            break
                        end
                    end
                end
                
                if not found then
                    -- try to find item in equipped items
                    for _, invSlot in pairs(TopFit.slots) do
                        local itemLink = GetInventoryItemLink("player", invSlot)
                        
                        if itemLink == recTable.locationTable.itemLink then
                            foundBag = nil
                            foundSlot = invSlot
                            found = true
                            break
                        end
                    end
                end
                
                if not found then
                    TopFit:Print(recTable.locationTable.itemLink.." could not be found in your inventory for equipping! Did you remove it during calculation?")
                    TopFit.itemRecommendations[slotID] = nil
                else
                    -- try equipping the item again
                    --TODO: if we try to equip offhand, and mainhand is two-handed, and no titan's grip, unequip mainhand first
                    ClearCursor()
                    if foundBag then
                        PickupContainerItem(foundBag, foundSlot)
                    else
                        PickupInventoryItem(foundSlot)
                    end
                    EquipCursorItem(slotID)
                end
            end
        end
        
        TopFit.updateEquipmentCounter = 0
        TopFit.equipRetries = TopFit.equipRetries + 1
    end
    
    -- if all items have been equipped, save equipment set and unregister script
    -- also abort if it takes to long, just save the items that _have_ been equipped
    if ((allDone) or (TopFit.equipRetries > 5)) then
        if (not allDone) then
            TopFit:Print("Oh. I am sorry, but I must have made a mistake. I cannot equip all the items I chose:")
            
            for slotID, recTable in pairs(TopFit.itemRecommendations) do
                slotItemLink = GetInventoryItemLink("player", slotID)
                if (slotItemLink ~= recTable.locationTable.itemLink) then
                    TopFit:Print("  "..recTable.locationTable.itemLink.." into Slot "..slotID.." ("..TopFit.slotNames[slotID]..")")
                    TopFit.itemRecommendations[slotID] = nil
                end
            end
        end
        
        TopFit:Debug("All Done!")
        TopFit.updateFrame:SetScript("OnUpdate", nil)
        TopFit.ProgressFrame:StoppedCalculation()
        
        EquipmentManagerClearIgnoredSlotsForSave()
        for _, slotID in pairs(TopFit.slots) do
            if (not TopFit.itemRecommendations[slotID]) then
                TopFit:Debug("Ignoring slot "..slotID)
                EquipmentManagerIgnoreSlotForSave(slotID)
            end
        end
        
        -- save equipment set
        if (CanUseEquipmentSets()) then
            setName = TopFit:GenerateSetName(TopFit.currentSetName)
            -- check if a set with this name exists
            if (GetEquipmentSetInfoByName(setName)) then
                texture = GetEquipmentSetInfoByName(setName)
                texture = "Interface\\Icons\\"..texture
                
                textureIndex = GetTextureIndex(texture)
            else
                textureIndex = GetTextureIndex("Interface\\Icons\\Spell_Holy_EmpowerChampion")
            end
            
            TopFit:Debug("Trying to save set: "..setName..", "..(textureIndex or "nil"))
            SaveEquipmentSet(setName, textureIndex)
        end
    
        -- we are done with this set
        TopFit.isBlocked = false
        
        -- reset relevant score field
        TopFit.ignoreCapsForCalculation = nil
        
        -- initiate next calculation if necessary
        if (#TopFit.workSetList > 0) then
            TopFit:CalculateSets()
        end
    end
end

function TopFit:GenerateSetName(name)
    -- using substr because blizzard interface only allows 16 characters
    -- although technically SaveEquipmentSet & co allow more ;)
    return (((name ~= nil) and string.sub(name.." ", 1, 12).."(TF)") or "TopFit")
end

function TopFit:ChatCommand(input)
    if not input or input:trim() == "" then
        InterfaceOptionsFrame_OpenToCategory("TopFit")
    else
        if input:trim():lower() == "show" then
            TopFit:CreateProgressFrame()
        elseif input:trim():lower() == "options" then
            InterfaceOptionsFrame_OpenToCategory("TopFit")
        else
            TopFit:Print("Available Options:\n  show - shows the calculations frame\n  options - shows TopFit's options")
        end
    end
end

function TopFit:OnInitialize()
    -- load saved variables
    self.db = LibStub("AceDB-3.0"):New("TopFitDB")
    
    -- set callback handler
    TopFit.eventHandler = TopFit.eventHandler or LibStub("CallbackHandler-1.0"):New(TopFit)
    
    -- create gametooltip for scanning
    TopFit.scanTooltip = CreateFrame('GameTooltip', 'TFScanTooltip', UIParent, 'GameTooltipTemplate')

    -- check if any set is saved already, if not, create default
    if (not self.db.profile.sets) then
        self.db.profile.sets = {
            set_1 = {
                name = "Default Set",
                weights = {},
                caps = {},
                forced = {},
            },
        }
    end
    
    -- for savedvariable updates: check if each set has a forced table
    for set, table in pairs(self.db.profile.sets) do
        if table.forced == nil then
            table.forced = {}
        end
        
        -- also set if all stat and cap values are numbers
        for stat, value in pairs(table.weights) do
            table.weights[stat] = tonumber(value) or nil
        end
        for _, capTable in pairs(table.caps) do
            capTable.value = tonumber(capTable.value)
        end
    end
    
    -- list of weight categories and stats
    TopFit.statList = {
        ["Basic Attributes"] = {
            [1] = "ITEM_MOD_AGILITY_SHORT",
            [2] = "ITEM_MOD_INTELLECT_SHORT",
            [3] = "ITEM_MOD_SPIRIT_SHORT",
            [4] = "ITEM_MOD_STAMINA_SHORT",
            [5] = "ITEM_MOD_STRENGTH_SHORT",
        },
        ["Melee"] = {
            [1] = "ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT",
            [2] = "ITEM_MOD_ATTACK_POWER_SHORT",
            [3] = "ITEM_MOD_EXPERTISE_RATING_SHORT",
            [4] = "ITEM_MOD_FERAL_ATTACK_POWER_SHORT",
        },
        ["Caster"] = {
            [1] = "ITEM_MOD_SPELL_PENETRATION_SHORT",
            [2] = "ITEM_MOD_SPELL_POWER_SHORT",
            [3] = "ITEM_MOD_MANA_REGENERATION_SHORT",
        },
        ["Defensive"] = {
            [1] = "ITEM_MOD_BLOCK_RATING_SHORT",
            [2] = "ITEM_MOD_BLOCK_VALUE_SHORT",
            [3] = "ITEM_MOD_DEFENSE_SKILL_RATING_SHORT",
            [4] = "ITEM_MOD_DODGE_RATING_SHORT",
            [5] = "ITEM_MOD_PARRY_RATING_SHORT",
            [6] = "ITEM_MOD_RESILIENCE_RATING_SHORT",
            [7] = "RESISTANCE0_NAME",                   -- armor
        },
        ["Hybrid"] = {
            [1] = "ITEM_MOD_CRIT_RATING_SHORT",
            [2] = "ITEM_MOD_DAMAGE_PER_SECOND_SHORT",
            [3] = "ITEM_MOD_HASTE_RATING_SHORT",
            [4] = "ITEM_MOD_HIT_RATING_SHORT",
        },
        ["Misc."] = {
            [1] = "ITEM_MOD_HEALTH_SHORT",
            [2] = "ITEM_MOD_MANA_SHORT",
            [3] = "ITEM_MOD_HEALTH_REGENERATION_SHORT",
        },
        ["Resistances"] = {
            [1] = "RESISTANCE1_NAME",                   -- holy
            [2] = "RESISTANCE2_NAME",                   -- fire
            [3] = "RESISTANCE3_NAME",                   -- nature
            [4] = "RESISTANCE4_NAME",                   -- frost
            [5] = "RESISTANCE5_NAME",                   -- shadow
            [6] = "RESISTANCE6_NAME",                   -- arcane
        },
    }
    
    -- list of inventory slot names
    TopFit.slotList = {
        --"AmmoSlot",
        "BackSlot",
        "ChestSlot",
        "FeetSlot",
        "Finger0Slot",
        "Finger1Slot",
        "HandsSlot",
        "HeadSlot",
        "LegsSlot",
        "MainHandSlot",
        "NeckSlot",
        "RangedSlot",
        "SecondaryHandSlot",
        "ShirtSlot",
        "ShoulderSlot",
        "TabardSlot",
        "Trinket0Slot",
        "Trinket1Slot",
        "WaistSlot",
        "WristSlot",
    }
    
    -- create list of slot names with corresponding slot IDs
    TopFit.slots = {}
    TopFit.slotNames = {}
    for _, slotName in pairs(TopFit.slotList) do
        local slotID, _, _ = GetInventorySlotInfo(slotName)
        TopFit.slots[slotName] = slotID;
        TopFit.slotNames[slotID] = slotName;
    end
    
    -- create frame for OnUpdate
    TopFit.updateFrame = CreateFrame("Frame")
    
    -- create options
    TopFit:createOptions()

    -- register Slash command
    self:RegisterChatCommand("topfit", "ChatCommand")
    self:RegisterChatCommand("tf", "ChatCommand")
    
    -- cache tables
    TopFit.itemsCache = {}
    TopFit.scoresCache = {}
    
    -- table for equippable item list
    TopFit.equippableItems = {}
    TopFit:collectEquippableItems()
    TopFit.loginDelay = 150
    
    -- frame for eventhandling
    TopFit.eventFrame = CreateFrame("Frame")
    TopFit.eventFrame:RegisterEvent("BAG_UPDATE")
    TopFit.eventFrame:RegisterEvent("PLAYER_LEVEL_UP")
    TopFit.eventFrame:SetScript("OnEvent", TopFit.FrameOnEvent)
    TopFit.eventFrame:SetScript("OnUpdate", TopFit.delayCalculationOnLogin)
    
    -- frame for calculation function
    TopFit.calculationsFrame = CreateFrame("Frame");
    
    -- heirloom info
    local isPlateWearer, isMailWearer = false, false
    if (select(2, UnitClass("player")) == "WARRIOR") or (select(2, UnitClass("player")) == "PALADIN") or (select(2, UnitClass("player")) == "DEATHKNIGHT") then
        isPlateWearer = true
    end
    if (select(2, UnitClass("player")) == "SHAMAN") or (select(2, UnitClass("player")) == "HUNTER") then
        isMailWearer = true
    end
    
    -- tables of itemIDs for heirlooms which change armor type
    TopFit.heirloomInfo = {
        plateHeirlooms = {
            [3] = {
                [1] = 42949,
                [2] = 44100,
                [3] = 44099,
            },
            [5] = {
                [1] = 48685,
            },
        },
        mailHeirlooms = {
            [3] = {
                [1] = 44102,
                [2] = 42950,
                [3] = 42951,
                [4] = 44101,
            },
            [5] = {
                [1] = 48677,
                [2] = 48683,
            },
        },
        isPlateWearer = isPlateWearer,
        isMailWearer = isMailWearer
    }
    
    -- container for plugin information and frames
    TopFit.plugins = {}
    
    -- button to open frame
    hooksecurefunc("ToggleCharacter", function (...)
        if not TopFit.toggleProgressFrameButton then
            TopFit.toggleProgressFrameButton = CreateFrame("Button", "TopFit_toggleProgressFrameButton", PaperDollFrame)
            TopFit.toggleProgressFrameButton:SetWidth(30)
            TopFit.toggleProgressFrameButton:SetHeight(32)
            TopFit.toggleProgressFrameButton:SetPoint("RIGHT", GearManagerToggleButton, "LEFT")
            
            local normalTexture = TopFit.toggleProgressFrameButton:CreateTexture()
            local pushedTexture = TopFit.toggleProgressFrameButton:CreateTexture()
            local highlightTexture = TopFit.toggleProgressFrameButton:CreateTexture()
            normalTexture:SetTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Up")
            pushedTexture:SetTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Down")
            highlightTexture:SetTexture("Interface\\Buttons\\UI-MicroButton-Hilight")
            normalTexture:SetTexCoord(0, 25/64, 0, 63/64, 1, 25/64, 1, 62/64)
            normalTexture:SetAllPoints()
            pushedTexture:SetTexCoord(0, 25/64, 0, 63/64, 1, 25/64, 1, 62/64)
            pushedTexture:SetAllPoints()
            highlightTexture:SetTexCoord(0, 25/64, 0, 63/64, 1, 25/64, 1, 62/64)
            highlightTexture:SetAllPoints()
            TopFit.toggleProgressFrameButton:SetNormalTexture(normalTexture)
            TopFit.toggleProgressFrameButton:SetPushedTexture(pushedTexture)
            TopFit.toggleProgressFrameButton:SetHighlightTexture(highlightTexture)
            local iconTexture = TopFit.toggleProgressFrameButton:CreateTexture()
            iconTexture:SetTexture("Interface\\Icons\\Achievement_BG_trueAVshutout") -- golden sword
            iconTexture:SetTexCoord(9/64, 4/64, 9/64, 61/64, 55/64, 4/64, 55/64, 61/64)
            iconTexture:SetDrawLayer("OVERLAY")
            iconTexture:SetBlendMode("ADD")
            iconTexture:SetPoint("TOPLEFT", TopFit.toggleProgressFrameButton, "TOPLEFT", 6, -4)
            iconTexture:SetPoint("BOTTOMRIGHT", TopFit.toggleProgressFrameButton, "BOTTOMRIGHT", -6, 4)
            
            TopFit.toggleProgressFrameButton:SetScript("OnClick", function(...)
                if (not TopFit.ProgressFrame) or (not TopFit.ProgressFrame:IsShown()) then
                    TopFit:CreateProgressFrame()
                else
                    TopFit:HideProgressFrame()
                end
            end)
            
            TopFit.toggleProgressFrameButton:SetScript("OnMouseDown", function(...)
                iconTexture:SetVertexColor(0.5, 0.5, 0.5)
            end)
            TopFit.toggleProgressFrameButton:SetScript("OnMouseUp", function(...)
                iconTexture:SetVertexColor(1, 1, 1)
            end)
            
            -- tooltip
            TopFit.toggleProgressFrameButton:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText("Open TopFit", nil, nil, nil, nil, true)
                GameTooltip:Show()
            end)
            TopFit.toggleProgressFrameButton:SetScript("OnLeave", function(...)
                GameTooltip:Hide()
            end)
        end
        if GearManagerToggleButton:IsShown() then
            TopFit.toggleProgressFrameButton:SetPoint("RIGHT", GearManagerToggleButton, "LEFT", 4, 0)
        else
            TopFit.toggleProgressFrameButton:SetPoint("RIGHT", GearManagerToggleButton, "RIGHT")
        end
    end)
    
    -- create default plugin frames
    TopFit:CreateStatsPlugin()
    TopFit:CreateVirtualItemsPlugin()
    
    TopFit:collectItems()
end

function TopFit:collectEquippableItems()
    local newItem = false
    
    -- check bags
    for bag = 0, 4 do
        for slot = 1, GetContainerNumSlots(bag) do
            local item = GetContainerItemLink(bag, slot)
            
            if IsEquippableItem(item) then
                local found = false
                for _, link in pairs(TopFit.equippableItems) do
                    if link == item then
                        found = true
                        break
                    end
                end
                
                if not found then
                    tinsert(TopFit.equippableItems, item)
                    newItem = true
                end
            end
        end
    end
    
    -- check equipment (mostly so your set doesn't get recalculated just because you unequip an item)
    for _, invSlot in pairs(TopFit.slots) do
        local item = GetInventoryItemLink("player", invSlot)
        if IsEquippableItem(item) then
            local found = false
            for _, link in pairs(TopFit.equippableItems) do
                if link == item then
                    found = true
                    break
                end
            end
            
            if not found then
                tinsert(TopFit.equippableItems, item)
                newItem = true
            end
        end
    end
    
    return newItem
end

function TopFit:delayCalculationOnLogin()
    if TopFit.loginDelay then
        TopFit.loginDelay = TopFit.loginDelay - 1
        if TopFit.loginDelay <= 0 then
            TopFit.loginDelay = nil
            TopFit.eventFrame:SetScript("OnUpdate", nil)
        end
    end
end

function TopFit:FrameOnEvent(event, ...)
    if (event == "BAG_UPDATE") then
        -- update item list
        --TODO: only update affected bag
        TopFit:collectItems()
        
        -- check inventory for new equippable items
        if TopFit:collectEquippableItems() and not TopFit.loginDelay then
            -- new equippable item in inventory!!!!
            -- calculate set silently if player wishes
            if TopFit.db.profile.defaultUpdateSet then
                if not TopFit.workSetList then
                    TopFit.workSetList = {}
                end
                tinsert(TopFit.workSetList, TopFit.db.profile.defaultUpdateSet)
                
                TopFit:CalculateSets(true) -- calculate silently
            end
        end
    elseif (event == "PLAYER_LEVEL_UP") then
        -- remove cache info for heirlooms so they are rescanned
        for itemLink, itemTable in pairs(TopFit.itemsCache) do
            if itemTable.itemQuality == 7 then
                TopFit.itemsCache[itemLink] = nil
                TopFit.scoresCache[itemLink] = nil
            end
        end
        
        -- if an auto-update-set is set, update that as well
        if TopFit.db.profile.defaultUpdateSet then
            if not TopFit.workSetList then
                TopFit.workSetList = {}
            end
            tinsert(TopFit.workSetList, TopFit.db.profile.defaultUpdateSet)
            
            TopFit:CalculateSets(true) -- calculate silently
        end
    end
end

function TopFit:OnEnable()
    -- Called when the addon is enabled
end

function TopFit:OnDisable()
    -- Called when the addon is disabled
end
