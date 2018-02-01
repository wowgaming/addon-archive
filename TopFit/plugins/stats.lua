function TopFit:CreateStatsPlugin()
    local statsFrame, pluginId = TopFit:RegisterPlugin("Weights & Caps", "Use this tab to set weights and caps for your sets, defining their basic behavior.")
    
    -- options button
    statsFrame.optionsButton = CreateFrame("Button", "TopFit_ProgressFrame_optionsButton", statsFrame)
    statsFrame.optionsButton:SetPoint("TOPRIGHT", statsFrame, "TOPRIGHT", -15, -5)
    statsFrame.optionsButton:SetHeight(32)
    statsFrame.optionsButton:SetWidth(32)
    statsFrame.optionsButton:SetNormalTexture("Interface\\Icons\\INV_Misc_Gear_02")
    statsFrame.optionsButton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
    
    -- set options
    statsFrame.includeInTooltipCheckButton = LibStub("tekKonfig-Checkbox").new(statsFrame, nil, "Include set in tooltip", "TOPLEFT", statsFrame, "TOPLEFT", 15, -15)
    statsFrame.includeInTooltipCheckButton.tiptext = "|cffffffffCheck to show this set in item comparison tooltips when that option is enabled."
    if (TopFit.ProgressFrame and TopFit.ProgressFrame.selectedSet) then
        statsFrame.includeInTooltipCheckButton:SetChecked(TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].excludeFromTooltip)
    end
    local checksound = statsFrame.includeInTooltipCheckButton:GetScript("OnClick")
    statsFrame.includeInTooltipCheckButton:SetScript("OnClick", function(self)
        checksound(self)
        if (TopFit.ProgressFrame.selectedSet) then
            TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].excludeFromTooltip = not TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].excludeFromTooltip
        end
    end)
    
    -- option to simulate dualwielding / titan's grip
    if select(2, UnitClass("player")) == "SHAMAN" then
        statsFrame.simulateDualWieldCheckButton = LibStub("tekKonfig-Checkbox").new(statsFrame, nil, "Force dual-wield", "TOPLEFT", statsFrame, "TOPLEFT", 15, -35)
        statsFrame.simulateDualWieldCheckButton.tiptext = "|cffffffffCheck to calculate this set with dualwielding in mind even if your current spec does not allow you to. If left off, the set will be calculated with your current spec in mind."
        if TopFit.ProgressFrame and TopFit.ProgressFrame.selectedSet then
            statsFrame.simulateDualWieldCheckButton:SetChecked(TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].simulateDualWield)
        end
        local checksound = statsFrame.simulateDualWieldCheckButton:GetScript("OnClick")
        statsFrame.simulateDualWieldCheckButton:SetScript("OnClick", function(self)
            checksound(self)
            if (TopFit.ProgressFrame.selectedSet) then
                TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].simulateDualWield = not TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].simulateDualWield
            end
        end)
    elseif select(2, UnitClass("player")) == "WARRIOR" then
        statsFrame.simulateTitansGripCheckButton = LibStub("tekKonfig-Checkbox").new(statsFrame, nil, "Force Titan's Grip", "TOPLEFT", statsFrame, "TOPLEFT", 15, -35)
        statsFrame.simulateTitansGripCheckButton.tiptext = "|cffffffffCheck to calculate this set with Titan's Grip in mind even if your current spec does not include it. If left off, the set will be calculated with your current spec in mind."
        if TopFit.ProgressFrame and TopFit.ProgressFrame.selectedSet then
            statsFrame.simulateTitansGripCheckButton:SetChecked(TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].simulateTitansGrip)
        end
        local checksound = statsFrame.simulateTitansGripCheckButton:GetScript("OnClick")
        statsFrame.simulateTitansGripCheckButton:SetScript("OnClick", function(self)
            checksound(self)
            if (TopFit.ProgressFrame.selectedSet) then
                TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].simulateTitansGrip = not TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].simulateTitansGrip
            end
        end)
    end
    
    statsFrame.optionsButton:SetScript("OnClick", function(...)
        InterfaceOptionsFrame_OpenToCategory("TopFit")
        TopFit.ProgressFrame:Hide()
    end)
    statsFrame.optionsButton.tipText = "Open TopFit's options"
    statsFrame.optionsButton:SetScript("OnEnter", ShowTooltip)
    statsFrame.optionsButton:SetScript("OnLeave", HideTooltip)
    
    statsFrame.statDropDown = CreateFrame("Frame", "TopFit_ProgressFrame_statDropDown", statsFrame, "UIDropDownMenuTemplate")
    --statsFrame.statDropDown:SetPoint("TOPLEFT", statsFrame, "TOPLEFT", 20, -20)
    UIDropDownMenu_Initialize(statsFrame.statDropDown, function(self, level)
        level = level or 1
        local info = UIDropDownMenu_CreateInfo()
        if (level == 1) then
            TopFit:collectItems()
            local info = UIDropDownMenu_CreateInfo();
            info.hasArrow = false; -- no submenu
            info.notCheckable = true;
            info.text = "Add stat...";
            info.isTitle = true;
            UIDropDownMenu_AddButton(info, level);
            
            for categoryName, statTable in pairs(TopFit.statList) do
                local info = UIDropDownMenu_CreateInfo();
                info.hasArrow = true;
                info.notCheckable = true;
                info.text = categoryName;
                info.isTitle = false;
                info.value = categoryName
                UIDropDownMenu_AddButton(info, level);
            end
            
            -- submenu for set pieces
            local info = UIDropDownMenu_CreateInfo();
            info.hasArrow = true;
            info.notCheckable = true;
            info.text = "Set Piece";
            info.isTitle = false;
            info.value = "setpieces"
            UIDropDownMenu_AddButton(info, level);
        elseif level == 2 then
            local parentValue = UIDROPDOWNMENU_MENU_VALUE
            
            if parentValue == "setpieces" then
                -- check all items' set names
                local setnames = {}
                for _, itemList in pairs(TopFit:GetEquippableItems()) do
                    for _, locationTable in pairs(itemList) do
                        local itemTable = TopFit:GetCachedItem(locationTable.itemLink)
                        if itemTable then
                            for stat, _ in pairs(itemTable.itemBonus) do
                                if (string.find(stat, "SET: ")) then
                                    local setname = string.gsub(stat, "SET: (.*)", "%1")
                                    
                                    -- check if set was added already
                                    local found = false
                                    for _, setname2 in pairs(setnames) do
                                        if setname == setname2 then found = true break end
                                    end
                                    
                                    if not found then tinsert(setnames, setname) end
                                end
                            end
                        end
                    end
                end
                
                table.sort(setnames)
                local i
                for i = 1, #setnames do
                    local info = UIDropDownMenu_CreateInfo();
                    info.hasArrow = false;
                    info.notCheckable = true;
                    info.text = setnames[i];
                    info.isTitle = false;
                    info.isChecked = false;
                    info.value = setnames[i]
                    info.func = function(...)
                        TopFit:Debug("Adding stat: "..info.value)
                        if (TopFit.ProgressFrame.selectedSet) then
                            TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].weights["SET: "..setnames[i]] = 0
                        end
                        statsFrame:UpdateSetStats()
                        TopFit:CalculateScores()
                    end
                    UIDropDownMenu_AddButton(info, level);
                end
            else
                -- normal values
                for key, value in pairs(TopFit.statList[parentValue]) do
                    local info = UIDropDownMenu_CreateInfo();
                    info.hasArrow = false;
                    info.notCheckable = true;
                    info.text = _G[value];
                    info.isTitle = false;
                    info.isChecked = false;
                    info.value = value
                    info.func = function(...)
                        TopFit:Debug("Adding stat: "..value)
                        if (TopFit.ProgressFrame.selectedSet) then
                            TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].weights[value] = 0
                        end
                        statsFrame:UpdateSetStats()
                        TopFit:CalculateScores()
                    end
                    UIDropDownMenu_AddButton(info, level);
                end
            end
        end
    end, "MENU")
    UIDropDownMenu_JustifyText(statsFrame.statDropDown, "LEFT")
    
    statsFrame.addStatButton = CreateFrame("Button", "TopFit_ProgressFrame_expandButton", statsFrame, "UIPanelButtonTemplate")
    statsFrame.addStatButton:SetPoint("TOPLEFT", statsFrame, "TOPLEFT", 5, -65)
    statsFrame.addStatButton:SetText("Add stat...")
    statsFrame.addStatButton:SetHeight(22)
    statsFrame.addStatButton:SetWidth(80)
    statsFrame.addStatButton:RegisterForClicks("AnyUp")
    
    statsFrame.addStatButton:SetScript("OnClick", function(self, button)
        ToggleDropDownMenu(1, nil, statsFrame.statDropDown, self, -20, 0)
    end)
    
    statsFrame.editStatScrollFrame = CreateFrame("ScrollFrame", "TopFit_EditStatScrollFrame", statsFrame, "UIPanelScrollFrameTemplate")
    statsFrame.editStatScrollFrame:SetPoint("TOPLEFT", statsFrame.addStatButton, "BOTTOMLEFT", 0, -25)
    statsFrame.editStatScrollFrame:SetPoint("BOTTOMRIGHT", statsFrame, "BOTTOMRIGHT", -25, 5)
    statsFrame.editStatScrollFrame:SetHeight(statsFrame.editStatScrollFrame:GetHeight())
    statsFrame.editStatScrollFrame:SetWidth(statsFrame.editStatScrollFrame:GetWidth())
    local editStatScrollFrameContent = CreateFrame("Frame", nil, statsFrame.editStatScrollFrame)
    editStatScrollFrameContent:SetAllPoints()
    editStatScrollFrameContent:SetHeight(10)
    editStatScrollFrameContent:SetWidth(235)
    statsFrame.editStatScrollFrame:SetScrollChild(editStatScrollFrameContent)
    statsFrame.editStatScrollFrame:SetBackdrop(backdrop)
    statsFrame.editStatScrollFrame:SetBackdropBorderColor(0.4, 0.4, 0.4)
    statsFrame.editStatScrollFrame:SetBackdropColor(0.1, 0.1, 0.1)
    
    -- containers for stat list
    statsFrame.menuHeaders = {}
    statsFrame.statCapCheckboxes = {}
    statsFrame.editStatNameTexts = {}
    statsFrame.editStatValueTexts = {}
    statsFrame.editStatButtons = {}
    statsFrame.statCapTexts = {}
    statsFrame.statCapValueTexts = {}
    statsFrame.statCapButtons = {}
    statsFrame.capTypeTexts = {}
    statsFrame.capTypeButtons = {}
    
    function statsFrame:UpdateSetStats()
        local menuHeaders = statsFrame.menuHeaders
        local statTexts = statsFrame.editStatNameTexts
        local valueTexts = statsFrame.editStatValueTexts
        local capBoxes = statsFrame.statCapCheckboxes
        local statButtons = statsFrame.editStatButtons
        local capTexts = statsFrame.statCapTexts
        local capValueTexts = statsFrame.statCapValueTexts
        local capButtons = statsFrame.statCapButtons
        local capTypeTexts = statsFrame.capTypeTexts
        local capTypeButtons = statsFrame.capTypeButtons
        
        local sortableStatWeightTable = {}
        if TopFit.ProgressFrame.selectedSet then
            -- little fix: set values for active caps to 0 if they are nil, so they are always shown
            for stat, capTable in pairs(TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].caps) do
                if capTable.active and TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].weights[stat] == nil then
                    TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].weights[stat] = 0
                end
            end
            
            for stat, value in pairs(TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].weights) do
                table.insert(sortableStatWeightTable, {stat, value})
            end
        end
        
        table.sort(sortableStatWeightTable, function(a,b)
            local order = TopFit.db.profile.statSortOrder
            
            local nameA = _G[a[1]] or a[1]
            local nameB = _G[b[1]] or b[1]
            
            if order == "NameAsc" then
                return nameA < nameB
            elseif order == "NameDesc" then
                return nameA > nameB
                
            elseif order == "ValueAsc" then
                return a[2] < b[2]
            elseif order == "ValueDesc" then
                return a[2] > b[2]
                
            elseif order == "CapAsc" then
                -- capped stats first, then ordered by name
                local a_capped = TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].caps[a[1]]
                local b_capped = TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].caps[b[1]]
                if (a_capped and a_capped.active) and (b_capped and b_capped.active) then
                    return nameA < nameB
                elseif a_capped and a_capped.active then
                    return true
                elseif b_capped and b_capped.active then
                    return false
                else
                    return nameA < nameB
                end
            elseif order == "CapDesc" then
                -- capped stats last, then ordered by name
                local a_capped = TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].caps[a[1]]
                local b_capped = TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].caps[b[1]]
                if (a_capped and a_capped.active) and (b_capped and b_capped.active) then
                    return nameA < nameB
                elseif a_capped and a_capped.active then
                    return false
                elseif b_capped and b_capped.active then
                    return true
                else
                    return nameA < nameB
                end
            else
                return a[1] < b[1]
            end
        end)
        
        -- headers
        local headerTitles = {{"Name", 165}, {"Value", 40}, {"Cap", 35}}
        if not menuHeaders[1] then
            local prefix = "TopFit_ProgressFrame_MenuHeader_"
            for i = 1, #headerTitles do
                menuHeaders[i] = TopFit.ProgressFrame:CreateHeaderButton(statsFrame, prefix .. headerTitles[i][1])
                if i == 1 then
                    menuHeaders[i]:SetPoint("BOTTOMLEFT", statsFrame.editStatScrollFrame, "TOPLEFT")
                else
                    menuHeaders[i]:SetPoint("TOPLEFT", menuHeaders[i-1], "TOPRIGHT")
                end
                menuHeaders[i]:SetText(headerTitles[i][1])
                menuHeaders[i].tiptext = headerTitles[i][1]
                menuHeaders[i]:SetWidth(headerTitles[i][2])
                menuHeaders[i]:SetScript("OnClick", function(self)
                    if TopFit.db.profile.statSortOrder == headerTitles[i][1].."Asc" then
                        TopFit.db.profile.statSortOrder = headerTitles[i][1].."Desc"
                    else
                        TopFit.db.profile.statSortOrder = headerTitles[i][1].."Asc"
                    end
                    
                    statsFrame:UpdateSetStats()
                end)
                menuHeaders[i]:Show()
            end
        end
        
        -- actual stat entries
        local stat, value
        local actualStatCount = 1
        for i = 1, #sortableStatWeightTable do
            stat = sortableStatWeightTable[i][1]
            value = sortableStatWeightTable[i][2]
            
            if not statTexts[i] then
                statButtons[i] = CreateFrame("Button", "TopFit_ProgressFrame_editStatButton"..i, editStatScrollFrameContent)
                statTexts[i] = editStatScrollFrameContent:CreateFontString(nil, "ARTWORK", "GameFontHighlightExtraSmall")
                valueTexts[i] = editStatScrollFrameContent:CreateFontString(nil, "ARTWORK", "GameFontHighlightExtraSmall")
                capBoxes[i] = CreateFrame("CheckButton", "TopFit_ProgressFrame_CapCheckBox"..i, editStatScrollFrameContent, "UICheckButtonTemplate")
                capButtons[i] = CreateFrame("Button", "TopFit_ProgressFrame_editCapButton"..i, editStatScrollFrameContent)
                capTexts[i] = editStatScrollFrameContent:CreateFontString(nil, "ARTWORK", "GameFontHighlightExtraSmall")
                capValueTexts[i] = editStatScrollFrameContent:CreateFontString(nil, "ARTWORK", "GameFontHighlightExtraSmall")
                capTypeButtons[i] = CreateFrame("Button", "TopFit_ProgressFrame_editCapTypeButton"..i, editStatScrollFrameContent)
                capTypeTexts[i] = editStatScrollFrameContent:CreateFontString(nil, "ARTWORK", "GameFontHighlightExtraSmall")
                
                statTexts[i]:SetTextHeight(11)
                valueTexts[i]:SetTextHeight(11)
                capTexts[i]:SetTextHeight(11)
                capValueTexts[i]:SetTextHeight(11)
                capTypeTexts[i]:SetTextHeight(11)
                if i == 1 then
                    statTexts[i]:SetPoint("TOPLEFT", editStatScrollFrameContent, "TOPLEFT", 3, -3)
                else
                    statTexts[i]:SetPoint("TOPLEFT", capTexts[i - 1], "BOTTOMLEFT")
                end
                valueTexts[i]:SetPoint("RIGHT", statTexts[i], "LEFT", headerTitles[1][2] + headerTitles[2][2] - 4, 0)
                capTexts[i]:SetPoint("TOPLEFT", statTexts[i], "BOTTOMLEFT")
                capValueTexts[i]:SetPoint("RIGHT", capTexts[i], "LEFT", headerTitles[1][2] + headerTitles[2][2] - 4, 0)
                capTypeTexts[i]:SetPoint("LEFT", capBoxes[i], "LEFT")
                capTypeTexts[i]:SetPoint("RIGHT", editStatScrollFrameContent, "RIGHT")
                capTypeTexts[i]:SetPoint("TOP", capValueTexts[i], "TOP")
                statButtons[i].i = i
                statButtons[i]:SetPoint("TOPLEFT", statTexts[i], "TOPLEFT")
                statButtons[i]:SetPoint("BOTTOMRIGHT", valueTexts[i], "BOTTOMRIGHT")
                --statButtons[i]:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
                statButtons[i]:SetHighlightTexture("Interface\\Buttons\\UI-ListBox-Highlight")
                statButtons[i]:SetAlpha(0.5)
                statButtons[i]:SetScript("OnClick", function(self)
                    statsFrame:HideStatEditTextBox()
                    statsFrame:ShowStatEditTextBox(self.i)
                end)
                capButtons[i].i = i
                capButtons[i]:SetPoint("TOPLEFT", capTexts[i], "TOPLEFT")
                capButtons[i]:SetPoint("BOTTOMRIGHT", capValueTexts[i], "BOTTOMRIGHT")
                --statButtons[i]:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
                capButtons[i]:SetHighlightTexture("Interface\\Buttons\\UI-ListBox-Highlight")
                capButtons[i]:SetAlpha(0.5)
                capButtons[i]:SetScript("OnClick", function(self)
                    statsFrame:HideStatEditTextBox()
                    statsFrame:ShowStatEditTextBox(self.i, true)
                end)
                capTypeButtons[i].i = i
                capTypeButtons[i]:SetPoint("TOPLEFT", capTypeTexts[i], "TOPLEFT")
                capTypeButtons[i]:SetPoint("BOTTOMRIGHT", capTypeTexts[i], "BOTTOMRIGHT")
                --statButtons[i]:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
                capTypeButtons[i]:SetHighlightTexture("Interface\\Buttons\\UI-ListBox-Highlight")
                capTypeButtons[i]:SetAlpha(0.5)
                capTypeButtons[i]:SetScript("OnClick", function(self)
                    local stat = statsFrame.editStatButtons[self.i].myStat
                    if TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].caps[stat].soft then
                        TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].caps[stat].soft = false
                    else
                        TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].caps[stat].soft = true
                    end
                    statsFrame:UpdateSetStats()
                end)
                
                capBoxes[i].i = i
                capBoxes[i]:SetHeight(12); capBoxes[i]:SetWidth(12)
                capBoxes[i]:SetPoint("LEFT", valueTexts[i], "RIGHT")
                capBoxes[i]:SetScript("OnClick", function(self)
                    local stat = statsFrame.editStatButtons[self.i].myStat
                    if not TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].caps[stat] then
                        -- create new cap
                        TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].caps[stat] = {
                            active = true,
                            soft = false,
                            value = 0,
                        }
                    else
                        if TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].caps[stat].active then
                            TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].caps[stat].active = false
                        else
                            TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].caps[stat].active = true
                        end
                    end
                    
                    statsFrame:UpdateSetStats()
                    TopFit:CalculateScores()
                end)
            end
            statButtons[i]:Show()
            statTexts[i]:Show()
            valueTexts[i]:Show()
            statTexts[i]:SetText(_G[stat] or string.gsub(stat, "SET: ", "Set: "))
            valueTexts[i]:SetText(value)
            if TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].caps[stat] and TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].caps[stat].active then
                capBoxes[i]:SetChecked(true)
                capTexts[i]:SetText("   Cap")
                capValueTexts[i]:SetText(TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].caps[stat].value)
                capTypeTexts[i]:SetText(TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].caps[stat].soft and "Soft" or "Hard")
                capValueTexts[i]:Show()
                capTypeTexts[i]:Show()
                capButtons[i]:Show()
                capTypeButtons[i]:Show()
            else
                capBoxes[i]:SetChecked(false)
                capTexts[i]:SetText("")
                capValueTexts[i]:Hide()
                capTypeTexts[i]:Hide()
                capButtons[i]:Hide()
                capTypeButtons[i]:Hide()
            end
            capBoxes[i]:Show()
            statButtons[i].myStat = stat
            actualStatCount = actualStatCount + 1
        end
        
        -- hide any texts not in use
        for i = actualStatCount, #statTexts do
            statTexts[i]:Hide()
            valueTexts[i]:Hide()
            statButtons[i]:Hide()
            capBoxes[i]:Hide()
            capTexts[i]:SetText("")
            capValueTexts[i]:Hide()
            capTypeTexts[i]:Hide()
            capButtons[i]:Hide()
            capTypeButtons[i]:Hide()
        end
    end
    
    function statsFrame:ShowStatEditTextBox(statID, isCap)
        if not statsFrame.statEditTextBox then
            -- create box
            statsFrame.statEditTextBox = CreateFrame("EditBox", "TopFit_ProgressFrame_statEditTextBox", editStatScrollFrameContent)
            statsFrame.statEditTextBox:SetWidth(50)
            statsFrame.statEditTextBox:SetHeight(11)
            statsFrame.statEditTextBox:SetAutoFocus(false)
            statsFrame.statEditTextBox:SetFontObject("GameFontHighlightSmall")
            statsFrame.statEditTextBox:SetJustifyH("RIGHT")
            
            -- background textures
            local left = statsFrame.statEditTextBox:CreateTexture(nil, "BACKGROUND")
            left:SetWidth(8) left:SetHeight(20)
            left:SetPoint("LEFT", -5, 0)
            left:SetTexture("Interface\\Common\\Common-Input-Border")
            left:SetTexCoord(0, 0.0625, 0, 0.625)
            local right = statsFrame.statEditTextBox:CreateTexture(nil, "BACKGROUND")
            right:SetWidth(8) right:SetHeight(20)
            right:SetPoint("RIGHT", 0, 0)
            right:SetTexture("Interface\\Common\\Common-Input-Border")
            right:SetTexCoord(0.9375, 1, 0, 0.625)
            local center = statsFrame.statEditTextBox:CreateTexture(nil, "BACKGROUND")
            center:SetHeight(20)
            center:SetPoint("RIGHT", right, "LEFT", 0, 0)
            center:SetPoint("LEFT", left, "RIGHT", 0, 0)
            center:SetTexture("Interface\\Common\\Common-Input-Border")
            center:SetTexCoord(0.0625, 0.9375, 0, 0.625)
            
            -- scripts
            statsFrame.statEditTextBox:SetScript("OnEscapePressed", function (self)
                statsFrame:HideStatEditTextBox()
                statsFrame:UpdateSetStats()
            end)
            
            statsFrame.statEditTextBox:SetScript("OnEnterPressed", function (self)
                -- save new stat value if it is numeric
                local value = tonumber(statsFrame.statEditTextBox:GetText())
                local stat = statsFrame.editStatButtons[statsFrame.statEditTextBox.statID].myStat
                local isCap = statsFrame.statEditTextBox.isCap
                if value and stat then -- otherwise, the text was probably not a number
                    if not isCap then
                        if value == 0 then value = nil end
                        TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].weights[stat] = value
                    else
                        TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].caps[stat].value = value
                    end
                else
                    TopFit:Debug("invalid input")
                end
                statsFrame:HideStatEditTextBox()
                statsFrame:UpdateSetStats()
                TopFit:CalculateScores()
            end)
        end
        if not isCap then
            statsFrame.statEditTextBox:SetPoint("RIGHT", statsFrame.editStatValueTexts[statID], "RIGHT")
            statsFrame.statEditTextBox:SetText(TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].weights[statsFrame.editStatButtons[statID].myStat])
            statsFrame.editStatValueTexts[statID]:Hide()
        else
            statsFrame.statEditTextBox:SetPoint("RIGHT", statsFrame.statCapValueTexts[statID], "RIGHT")
            statsFrame.statEditTextBox:SetText(TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].caps[statsFrame.editStatButtons[statID].myStat].value)
            statsFrame.statCapValueTexts[statID]:Hide()
        end
        statsFrame.statEditTextBox:Show()
        statsFrame.statEditTextBox:HighlightText()
        statsFrame.statEditTextBox:SetFocus()
        statsFrame.statEditTextBox.statID = statID
        statsFrame.statEditTextBox.isCap = isCap
    end
    
    function statsFrame:HideStatEditTextBox()
        if statsFrame.statEditTextBox then
            statsFrame.statEditTextBox:Hide()
            statsFrame.statEditTextBox:ClearFocus()
        end
    end
    
    -- event handlers
    TopFit.RegisterCallback("TopFit_stats", "OnShow", function(event, id)
        if (id == pluginId) then
            statsFrame:UpdateSetStats()
        end
    end)
    
    TopFit.RegisterCallback("TopFit_stats", "OnSetChanged", function(event, setId)
        if (setId) then
            -- enable inputs
            statsFrame.addStatButton:Enable()
            statsFrame.includeInTooltipCheckButton:Enable()
            statsFrame.includeInTooltipCheckButton:SetChecked(not TopFit.db.profile.sets[setId].excludeFromTooltip)
            if (statsFrame.simulateDualWieldCheckButton) then
                statsFrame.simulateDualWieldCheckButton:Enable()
                statsFrame.simulateDualWieldCheckButton:SetChecked(TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].simulateDualWield)
            end
            if (statsFrame.simulateTitansGripCheckButton) then
                statsFrame.simulateTitansGripCheckButton:Enable()
                statsFrame.simulateTitansGripCheckButton:SetChecked(TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].simulateTitansGrip)
            end
        else
            -- no set selected, disable inputs
            statsFrame.addStatButton:Disable()
            statsFrame.includeInTooltipCheckButton:Disable()
            if (tatsFrame.simulateDualWieldCheckButton) then
                statsFrame.simulateDualWieldCheckButton:Disable()
            end
            if (statsFrame.simulateTitansGripCheckButton) then
                statsFrame.simulateTitansGripCheckButton:Disable()
            end
        end
        statsFrame:UpdateSetStats()
    end)
end
