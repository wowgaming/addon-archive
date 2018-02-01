
-- button tooltip infos
local function ShowTooltip(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    if self.tiptext then
        GameTooltip:SetText(self.tiptext, nil, nil, nil, nil, true)
    elseif self.itemLink then
        GameTooltip:SetHyperlink(self.itemLink)
    end
    GameTooltip:Show()
end
local function HideTooltip() GameTooltip:Hide() end

function TopFit:createOptions()
    if not TopFit.InterfaceOptionsFrame then
        TopFit.InterfaceOptionsFrame = CreateFrame("Frame", "TopFit_InterfaceOptionsFrame", InterfaceOptionsFramePanelContainer)
        TopFit.InterfaceOptionsFrame.name = "TopFit"
        TopFit.InterfaceOptionsFrame:Hide()
        
        local title, subtitle = LibStub("tekKonfig-Heading").new(TopFit.InterfaceOptionsFrame, "TopFit", "Basic options")
        
        -- Show Tooltip Checkbox
        local showTooltip = LibStub("tekKonfig-Checkbox").new(TopFit.InterfaceOptionsFrame, nil, "Show set values in tooltip", "TOPLEFT", subtitle, "BOTTOMLEFT", -2, 0)
        showTooltip.tiptext = "|cffffffffCheck to show your sets' scores for an item in the item's tooltip."
        showTooltip:SetChecked(TopFit.db.profile.showTooltip)
        local checksound = showTooltip:GetScript("OnClick")
        showTooltip:SetScript("OnClick", function(self)
            checksound(self)
            TopFit.db.profile.showTooltip = not TopFit.db.profile.showTooltip
        end)
        
        -- Show Comparison Tooltip Checkbox
        local showComparisonTooltip = LibStub("tekKonfig-Checkbox").new(TopFit.InterfaceOptionsFrame, nil, "Show item comparison values in tooltip", "TOPLEFT", showTooltip, "BOTTOMLEFT", 0, 0)
        showComparisonTooltip.tiptext = "|cffffffffCheck to show values in your tooltip which indicate how much of an improvement an item is in comparison with your equipped items for each set."
        showComparisonTooltip:SetChecked(TopFit.db.profile.showComparisonTooltip)
        local checksound = showComparisonTooltip:GetScript("OnClick")
        showComparisonTooltip:SetScript("OnClick", function(self)
            checksound(self)
            TopFit.db.profile.showComparisonTooltip = not TopFit.db.profile.showComparisonTooltip
        end)
        
        -- Auto Update Set Dropdown
        local autoUpdateSet, autoUpdateSetText, autoUpdateSetContainer = LibStub("tekKonfig-Dropdown").new(TopFit.InterfaceOptionsFrame, "Automatic update set", "TOPLEFT", showComparisonTooltip, "BOTTOMLEFT", 0, 0)
        if (TopFit.db.profile.defaultUpdateSet) and (TopFit.db.profile.sets[TopFit.db.profile.defaultUpdateSet]) then
            autoUpdateSetText:SetText(TopFit.db.profile.sets[TopFit.db.profile.defaultUpdateSet].name)
        else
            autoUpdateSetText:SetText("None")
        end
        autoUpdateSet.tiptext = "|cffffffffThe set you choose here will be updated automatically whenever you loot an equippable item.\n\n|cffffff00Warning: |cffffffffThis option is intended to be used while levelling. If you have a character with dualspec, it might suddenly equip the set you specify here even if you activated your other specialization."
        
        UIDropDownMenu_Initialize(autoUpdateSet, function()
            local info = UIDropDownMenu_CreateInfo()
            info.text = "None"
            info.value = "none"
            info.func = function()
                UIDropDownMenu_SetSelectedValue(autoUpdateSet, this.value)
                autoUpdateSetText:SetText("None")
                TopFit.db.profile.defaultUpdateSet = nil
            end
            UIDropDownMenu_AddButton(info)
            
            for setCode, setTable in pairs(TopFit.db.profile.sets or {}) do
                local info = UIDropDownMenu_CreateInfo()
                info.text = setTable.name
                info.value = setCode
                info.func = function()
                    UIDropDownMenu_SetSelectedValue(autoUpdateSet, this.value)
                    autoUpdateSetText:SetText(TopFit.db.profile.sets[this.value].name)
                    TopFit.db.profile.defaultUpdateSet = this.value
                end
                UIDropDownMenu_AddButton(info)
            end
        end)
        
        -- Debug Mode Checkbox
        local debugMode = LibStub("tekKonfig-Checkbox").new(TopFit.InterfaceOptionsFrame, nil, "Debug mode", "TOPLEFT", showComparisonTooltip, "BOTTOMLEFT", 0, -70)
        debugMode.tiptext = "|cffffffffCheck to enable debug messages.\n\n|cffffff00Caution: |cffffffffThis will spam your chatframe, a lot!"
        debugMode:SetChecked(TopFit.db.profile.debugMode)
        local checksound = debugMode:GetScript("OnClick")
        debugMode:SetScript("OnClick", function(self)
            checksound(self)
            TopFit.db.profile.debugMode = not TopFit.db.profile.debugMode
        end)
        
        InterfaceOptions_AddCategory(TopFit.InterfaceOptionsFrame)
        LibStub("tekKonfig-AboutPanel").new("TopFit", "TopFit")
        
        TopFit.InterfaceOptionsFrame:SetScript("OnShow", function()
            showTooltip:SetChecked(TopFit.db.profile.showTooltip)
            if (TopFit.db.profile.defaultUpdateSet) and (TopFit.db.profile.sets[TopFit.db.profile.defaultUpdateSet]) then
                autoUpdateSetText:SetText(TopFit.db.profile.sets[TopFit.db.profile.defaultUpdateSet].name)
            else
                autoUpdateSetText:SetText("None")
            end
            debugMode:SetChecked(TopFit.db.profile.debugMode)
        end)
    end
end

function TopFit:AddSet(preset)
    local i = 1
    while  TopFit.db.profile.sets["set_"..i] do i = i + 1 end
    
    local setName
    local weights = {}
    local caps = {}
    if preset then
        TopFit.debug = preset
        setName = preset.name
        for key, value in pairs(preset.weights) do
            weights[key] = value
        end
        for key, value in pairs(preset.caps) do
            caps[key] = {}
            for key2, value2 in pairs(value) do
                caps[key][key2] = value2
            end
        end
    else
        setName = "Set "..i
    end
    --TODO: check if set name is taken
    
    TopFit.db.profile.sets["set_"..i] = {
        name = setName,
        weights = weights,
        caps = caps,
        forced = {}
    }
    
    if TopFit.ProgressFrame then
        TopFit.ProgressFrame:SetSelectedSet("set_"..i)
    end
end

function TopFit:DeleteSet(setCode)
    local setName = TopFit:GenerateSetName(self.db.profile.sets[setCode].name)
    
    -- remove from equipment manager
    if (CanUseEquipmentSets() and GetEquipmentSetInfoByName(setName)) then
        DeleteEquipmentSet(setName)
    end
    
    -- remove from saved variables
    self.db.profile.sets[setCode] = nil
    
    -- remove automatic update set if necessary
    if self.db.profile.defaultUpdateSet == setCode then
        self.db.profile.defaultUpdateSet = nil
    end
    
    if (TopFit.ProgressFrame) then
        TopFit.ProgressFrame:SetSelectedSet()
        TopFit.ProgressFrame:SetCurrentCombination()
        TopFit.ProgressFrame:SetSetName("Set Name")
    end
end

function TopFit:RenameSet(setCode, newName)
    oldSetName = TopFit:GenerateSetName(self.db.profile.sets[setCode]["name"])
    newSetName = TopFit:GenerateSetName(newName)

    -- rename in saved variables
    self.db.profile.sets[setCode]["name"] = newName
    
    -- rename equipment set if it exists
    if (CanUseEquipmentSets() and GetEquipmentSetInfoByName(oldSetName)) then
        RenameEquipmentSet(oldSetName, newSetName)
    end
    
    if (TopFit.ProgressFrame) then
        -- update setname if it is selected
        if UIDropDownMenu_GetSelectedValue(TopFit.ProgressFrame.setDropDown) == setCode then
            UIDropDownMenu_SetSelectedName(TopFit.ProgressFrame.setDropDown, newName)
        end
    end
end
