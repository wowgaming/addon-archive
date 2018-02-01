local minimalist = [=[Interface\AddOns\TopFit\media\minimalist]=]

-- tooltip functions for equipment buttons
local function ShowTooltip(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    if self.tipText then
        GameTooltip:SetText(self.tipText, nil, nil, nil, nil, true)
    elseif self.itemLink then
        GameTooltip:SetHyperlink(self.itemLink)
    end
    GameTooltip:Show()
end

local function HideTooltip()
    GameTooltip:Hide()
end

function TopFit:CreateProgressFrame()
    if not TopFit.ProgressFrame then
        -- actual frame
        
        --[[--
        --              Left part of Panel
        --]]--
        
        TopFit.ProgressFrame = CreateFrame("Frame", "TopFit_ProgressFrame", nil) -- change nil to UIParent if the frame should be affected by UIScale
        tinsert(UISpecialFrames, "TopFit_ProgressFrame")
        TopFit.ProgressFrame:SetToplevel(true)
        TopFit.ProgressFrame:ClearAllPoints()
        TopFit.ProgressFrame:SetBackdrop({
            bgFile="Interface\\DialogFrame\\UI-DialogBox-Background",
            tileSize=32,
            edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border",
            tile=1,
            edgeSize=32,
            insets={
                top=12,
                right=12,
                left=11,
                bottom=11
            }
        })
        TopFit.ProgressFrame:SetHeight(32 * 8 + 16 + 70 + 20 * 2)
        TopFit.ProgressFrame:SetWidth(32 * 5 + 48 * 2 + 20 * 2)
        TopFit.ProgressFrame:EnableMouse(true)
        --TopFit.ProgressFrame:SetScale(GetCVar("uiScale"))
        local titleRegion = TopFit.ProgressFrame:CreateTitleRegion()
        titleRegion:SetAllPoints(TopFit.ProgressFrame)
        
        -- the most important thing: the close-button
        TopFit.ProgressFrame.closeButton = CreateFrame("Button", "TopFit_ProgressFrame_closeButton", TopFit.ProgressFrame, "UIPanelCloseButton")
        TopFit.ProgressFrame.closeButton:SetWidth(30)
        TopFit.ProgressFrame.closeButton:SetHeight(30)
        TopFit.ProgressFrame.closeButton:SetPoint("TOPRIGHT", TopFit.ProgressFrame, "TOPRIGHT")
        TopFit.ProgressFrame.closeButton:SetScript("OnClick", function(...) TopFit:HideProgressFrame() end)
        
        -- select set label
        TopFit.ProgressFrame.selectSetLabel = TopFit.ProgressFrame:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
        TopFit.ProgressFrame.selectSetLabel:SetPoint("TOPLEFT", TopFit.ProgressFrame, "TOPLEFT", 20, -30)
        --TopFit.ProgressFrame.selectSetLabel:SetPoint("TOPRIGHT", TopFit.ProgressFrame, "TOPRIGHT", -20, -20)
        TopFit.ProgressFrame.selectSetLabel:SetWidth(TopFit.ProgressFrame:GetWidth() - 40)
        TopFit.ProgressFrame.selectSetLabel:SetText("Select set to calculate:")
        TopFit.ProgressFrame.selectSetLabel:SetJustifyH("LEFT")
        
        -- abort button
        TopFit.ProgressFrame.abortButton = CreateFrame("Button", "TopFit_ProgressFrame_abortButton", TopFit.ProgressFrame, "UIPanelButtonTemplate")
        TopFit.ProgressFrame.abortButton:SetPoint("TOPRIGHT", TopFit.ProgressFrame.selectSetLabel, "BOTTOMRIGHT", 0, 0)
        TopFit.ProgressFrame.abortButton:SetText("Abort")
        TopFit.ProgressFrame.abortButton:SetHeight(22)
        TopFit.ProgressFrame.abortButton:SetWidth(80)
        TopFit.ProgressFrame.abortButton:Hide()
        
        TopFit.ProgressFrame.abortButton:SetScript("OnClick", TopFit.AbortCalculations)
        
        -- start button
        TopFit.ProgressFrame.startButton = CreateFrame("Button", "TopFit_ProgressFrame_startButton", TopFit.ProgressFrame, "UIPanelButtonTemplate")
        TopFit.ProgressFrame.startButton:SetAllPoints(TopFit.ProgressFrame.abortButton)
        TopFit.ProgressFrame.startButton:SetText("Start")
        --TopFit.ProgressFrame.startButton:Hide()
        
        TopFit.ProgressFrame.startButton:SetScript("OnClick", function(...)
            if not TopFit.isBlocked then
                if TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet] then
                    TopFit.workSetList = { TopFit.ProgressFrame.selectedSet }
                    TopFit:CalculateSets()
                end
            end
        end)
        
        -- progress bar
        TopFit.ProgressFrame.progressBar = CreateFrame("StatusBar", "TopFit_ProgressFrame_StatusBar", TopFit.ProgressFrame)
        TopFit.ProgressFrame.progressBar:SetPoint("TOPLEFT", TopFit.ProgressFrame.selectSetLabel, "BOTTOMLEFT", 2, -2)
        --TopFit.ProgressFrame.progressBar:SetPoint("BOTTOMRIGHT", TopFit.ProgressFrame.abortButton, "BOTTOMLEFT", -2, 2)
        TopFit.ProgressFrame.progressBar:SetWidth(170)
        TopFit.ProgressFrame.progressBar:SetHeight(20)
        TopFit.ProgressFrame.progressBar:SetStatusBarTexture(minimalist)
        TopFit.ProgressFrame.progressBar:SetMinMaxValues(0, 100)
        TopFit.ProgressFrame.progressBar:SetStatusBarColor(0, 1, 0, 0.8)
        TopFit.ProgressFrame.progressBar:Hide()
        
        -- progress text
        TopFit.ProgressFrame.progressText = TopFit.ProgressFrame.progressBar:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        TopFit.ProgressFrame.progressText:SetAllPoints()
        TopFit.ProgressFrame.progressText:SetText("0.00%")
        
        -- set selection
        TopFit.ProgressFrame.setDropDown = CreateFrame("Frame", "TopFit_ProgressFrame_setDropDown", TopFit.ProgressFrame, "UIDropDownMenuTemplate")
        TopFit.ProgressFrame.setDropDown:SetPoint("TOPLEFT", TopFit.ProgressFrame.selectSetLabel, "BOTTOMLEFT", -20, 2)
        TopFit.ProgressFrame.setDropDown:SetWidth(150)
        UIDropDownMenu_Initialize(TopFit.ProgressFrame.setDropDown, function(self, level)
            local info = UIDropDownMenu_CreateInfo()
            for k, v in pairs(TopFit.db.profile.sets) do
                if not TopFit.ProgressFrame.selectedSet then
                    TopFit.ProgressFrame.selectedSet = k
                end
                info = UIDropDownMenu_CreateInfo()
                info.text = v.name
                info.value = k
                info.func = function(self)
                    TopFit.ProgressFrame:SetSelectedSet(self.value)
                end
                UIDropDownMenu_AddButton(info, level)
            end
        end)
        UIDropDownMenu_SetSelectedID(TopFit.ProgressFrame.setDropDown, 1)
        UIDropDownMenu_JustifyText(TopFit.ProgressFrame.setDropDown, "LEFT")
        
        -- add set button
        TopFit.ProgressFrame.addSetButton = CreateFrame("Button", "TopFit_ProgressFrame_addSetButton", TopFit.ProgressFrame)
        TopFit.ProgressFrame.addSetButton:SetPoint("LEFT", TopFit.ProgressFrame.setDropDown, "RIGHT", 0, 8)
        TopFit.ProgressFrame.addSetButton:SetHeight(12)
        TopFit.ProgressFrame.addSetButton:SetWidth(12)
        TopFit.ProgressFrame.addSetButton:SetNormalTexture("Interface\\Icons\\Spell_chargepositive")
        TopFit.ProgressFrame.addSetButton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
        
        -- set selection for add set button
        TopFit.ProgressFrame.addSetButton.setDropDown = CreateFrame("Frame", "TopFit_ProgressFrame_addSetButton_setDropDown", TopFit.ProgressFrame.addSetButton, "UIDropDownMenuTemplate")
        UIDropDownMenu_Initialize(TopFit.ProgressFrame.addSetButton.setDropDown, function(self, level)
            local info = UIDropDownMenu_CreateInfo()
            info.hasArrow = false; -- no submenu
            info.notCheckable = true;
            info.text = "Empty Set"
            info.value = 0
            info.func = function(self)
                TopFit:AddSet()
                TopFit:CalculateScores()
            end
            UIDropDownMenu_AddButton(info, level)
            
            local presets = TopFit:GetPresets()
            for k, v in pairs(presets) do
                info = UIDropDownMenu_CreateInfo()
                info.hasArrow = false; -- no submenu
                info.notCheckable = true;
                info.text = v.name
                info.value = k
                info.func = function(self)
                    TopFit:AddSet(v)
                    TopFit:CalculateScores()
                    --TopFit.ProgressFrame:SetCurrentCombination()
                end
                UIDropDownMenu_AddButton(info, level)
            end
        end, "MENU")
        
        TopFit.ProgressFrame.addSetButton:SetScript("OnClick", function(self)
            ToggleDropDownMenu(1, nil, TopFit.ProgressFrame.addSetButton.setDropDown, self, 0, 0)
        end)
        TopFit.ProgressFrame.addSetButton.tipText = "Add a new equipment set\n|cffffffffAftewards, you can adjust this set's weights and caps in the right frame, or force items by clicking on any equipment slots below."
        TopFit.ProgressFrame.addSetButton:SetScript("OnEnter", ShowTooltip)
        TopFit.ProgressFrame.addSetButton:SetScript("OnLeave", HideTooltip)
        
        -- delete set button
        TopFit.ProgressFrame.deleteSetButton = CreateFrame("Button", "TopFit_ProgressFrame_deleteSetButton", TopFit.ProgressFrame)
        TopFit.ProgressFrame.deleteSetButton:SetPoint("TOP", TopFit.ProgressFrame.addSetButton, "BOTTOM", 0, 0)
        TopFit.ProgressFrame.deleteSetButton:SetHeight(12)
        TopFit.ProgressFrame.deleteSetButton:SetWidth(12)
        TopFit.ProgressFrame.deleteSetButton:SetNormalTexture("Interface\\Icons\\Spell_chargenegative")
        TopFit.ProgressFrame.deleteSetButton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
        
        TopFit.ProgressFrame.deleteSetButton:SetScript("OnClick", function(...)
            -- on first click: mark red
            if not TopFit.ProgressFrame.deleteSetButton.firstClick then
                if not TopFit.ProgressFrame.deleteSetButton.redHightlight then
                    TopFit.ProgressFrame.deleteSetButton.redHightlight = TopFit.ProgressFrame.deleteSetButton:CreateTexture("$parent_higlightTexture")
                    TopFit.ProgressFrame.deleteSetButton.redHightlight:SetTexture("Interface\\Buttons\\CheckButtonHilight")
                    TopFit.ProgressFrame.deleteSetButton.redHightlight:SetAllPoints()
                    TopFit.ProgressFrame.deleteSetButton.redHightlight:SetBlendMode("ADD")
                    TopFit.ProgressFrame.deleteSetButton.redHightlight:SetDrawLayer("OVERLAY")
                    TopFit.ProgressFrame.deleteSetButton.redHightlight:SetVertexColor(1, 0, 0, 1)
                end
                TopFit.ProgressFrame.deleteSetButton.redHightlight:Show();
                TopFit.ProgressFrame.deleteSetButton.firstClick = true
            else
                -- on second click: delete set
                --TopFit.ProgressFrame:SetCurrentCombination()
                TopFit:DeleteSet(TopFit.ProgressFrame.selectedSet)
                --TopFit:CalculateScores()
                TopFit.ProgressFrame.deleteSetButton.redHightlight:Hide();
                TopFit.ProgressFrame.deleteSetButton.firstClick = false
            end
        end)
        TopFit.ProgressFrame.deleteSetButton.tipText = "Delete the selected set\n|cffffffffYou will have to click this button a second time to confirm the deletion.\n\n|cffff0000WARNING|cffffffff: The associated set in the equipment manager will also be deleted! If you want to keep it, create a copy in Blizzard's equipment manager first!"
        TopFit.ProgressFrame.deleteSetButton:SetScript("OnEnter", ShowTooltip)
        TopFit.ProgressFrame.deleteSetButton:SetScript("OnLeave", function() HideTooltip() if TopFit.ProgressFrame.deleteSetButton.redHightlight then TopFit.ProgressFrame.deleteSetButton.redHightlight:Hide(); TopFit.ProgressFrame.deleteSetButton.firstClick = false end end)
        
        -- expand / contract button
        TopFit.ProgressFrame.expandButton = CreateFrame("Button", "TopFit_ProgressFrame_expandButton", TopFit.ProgressFrame, "UIPanelButtonTemplate")
        TopFit.ProgressFrame.expandButton:SetPoint("TOPRIGHT", TopFit.ProgressFrame.selectSetLabel, "BOTTOMRIGHT", 0, 30)
        TopFit.ProgressFrame.expandButton:SetText(">>")
        TopFit.ProgressFrame.expandButton:SetHeight(22)
        TopFit.ProgressFrame.expandButton:SetWidth(80)
        
        TopFit.ProgressFrame.expandButton:SetScript("OnClick", function(...)
            if TopFit.ProgressFrame.isExpanded then
                TopFit.ProgressFrame.expandButton:SetText(">>")
                TopFit.ProgressFrame.isExpanded = false
                TopFit.ProgressFrame.pluginContainer:Hide()
                TopFit.ProgressFrame:SetWidth(TopFit.ProgressFrame:GetWidth() / 2)
            else
                TopFit.ProgressFrame.expandButton:SetText("<<")
                TopFit.ProgressFrame.isExpanded = true
                TopFit.ProgressFrame.pluginContainer:Show()
                TopFit.ProgressFrame:SetWidth(TopFit.ProgressFrame:GetWidth() * 2)
            end
        end)
        
        -- equipment buttons
        TopFit.ProgressFrame.equipButtons = {}
        for slotID, _ in pairs(TopFit.slotNames) do
            TopFit.ProgressFrame.equipButtons[slotID] = CreateFrame("Button", "TopFit_ProgressFrame_slot"..slotID.."Button", TopFit.ProgressFrame)
            TopFit.ProgressFrame.equipButtons[slotID]:SetHeight(32)
            TopFit.ProgressFrame.equipButtons[slotID]:SetWidth(32)
            TopFit.ProgressFrame.equipButtons[slotID]:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
            
            -- create extra highlight texture for marking purposes
            TopFit.ProgressFrame.equipButtons[slotID].highlightTexture = TopFit.ProgressFrame.equipButtons[slotID]:CreateTexture("$parent_higlightTexture")
            TopFit.ProgressFrame.equipButtons[slotID].highlightTexture:SetTexture("Interface\\Buttons\\CheckButtonHilight")
            TopFit.ProgressFrame.equipButtons[slotID].highlightTexture:SetAllPoints()
            TopFit.ProgressFrame.equipButtons[slotID].highlightTexture:SetBlendMode("ADD")
            TopFit.ProgressFrame.equipButtons[slotID].highlightTexture:SetDrawLayer("OVERLAY")
            TopFit.ProgressFrame.equipButtons[slotID].highlightTexture:SetVertexColor(1, 1, 1, 0)
        end
        -- anchor them all like in the equipment window
        TopFit.ProgressFrame.equipButtons[1]:SetPoint("LEFT", TopFit.ProgressFrame.selectSetLabel, "LEFT")
        TopFit.ProgressFrame.equipButtons[1]:SetPoint("TOP", TopFit.ProgressFrame.abortButton, "BOTTOM", 0, -15)
        TopFit.ProgressFrame.equipButtons[2]:SetPoint("TOPLEFT", TopFit.ProgressFrame.equipButtons[1], "BOTTOMLEFT")
        TopFit.ProgressFrame.equipButtons[3]:SetPoint("TOPLEFT", TopFit.ProgressFrame.equipButtons[2], "BOTTOMLEFT")
        TopFit.ProgressFrame.equipButtons[15]:SetPoint("TOPLEFT", TopFit.ProgressFrame.equipButtons[3], "BOTTOMLEFT")
        TopFit.ProgressFrame.equipButtons[5]:SetPoint("TOPLEFT", TopFit.ProgressFrame.equipButtons[15], "BOTTOMLEFT")
        TopFit.ProgressFrame.equipButtons[4]:SetPoint("TOPLEFT", TopFit.ProgressFrame.equipButtons[5], "BOTTOMLEFT")
        TopFit.ProgressFrame.equipButtons[19]:SetPoint("TOPLEFT", TopFit.ProgressFrame.equipButtons[4], "BOTTOMLEFT")
        TopFit.ProgressFrame.equipButtons[9]:SetPoint("TOPLEFT", TopFit.ProgressFrame.equipButtons[19], "BOTTOMLEFT")
        
        TopFit.ProgressFrame.equipButtons[16]:SetPoint("TOPLEFT", TopFit.ProgressFrame.equipButtons[9], "BOTTOMRIGHT", 48, 16)
        TopFit.ProgressFrame.equipButtons[17]:SetPoint("TOPLEFT", TopFit.ProgressFrame.equipButtons[16], "TOPRIGHT")
        TopFit.ProgressFrame.equipButtons[18]:SetPoint("TOPLEFT", TopFit.ProgressFrame.equipButtons[17], "TOPRIGHT")
        
        TopFit.ProgressFrame.equipButtons[14]:SetPoint("BOTTOMLEFT", TopFit.ProgressFrame.equipButtons[18], "TOPRIGHT", 48, -16)
        TopFit.ProgressFrame.equipButtons[13]:SetPoint("BOTTOMLEFT", TopFit.ProgressFrame.equipButtons[14], "TOPLEFT")
        TopFit.ProgressFrame.equipButtons[12]:SetPoint("BOTTOMLEFT", TopFit.ProgressFrame.equipButtons[13], "TOPLEFT")
        TopFit.ProgressFrame.equipButtons[11]:SetPoint("BOTTOMLEFT", TopFit.ProgressFrame.equipButtons[12], "TOPLEFT")
        TopFit.ProgressFrame.equipButtons[8]:SetPoint("BOTTOMLEFT", TopFit.ProgressFrame.equipButtons[11], "TOPLEFT")
        TopFit.ProgressFrame.equipButtons[7]:SetPoint("BOTTOMLEFT", TopFit.ProgressFrame.equipButtons[8], "TOPLEFT")
        TopFit.ProgressFrame.equipButtons[6]:SetPoint("BOTTOMLEFT", TopFit.ProgressFrame.equipButtons[7], "TOPLEFT")
        TopFit.ProgressFrame.equipButtons[10]:SetPoint("BOTTOMLEFT", TopFit.ProgressFrame.equipButtons[6], "TOPLEFT")
        
        -- set their default (empty) textures
        TopFit.ProgressFrame.equipButtons[1].emptyTexture = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Head"
        TopFit.ProgressFrame.equipButtons[2].emptyTexture = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Neck"
        TopFit.ProgressFrame.equipButtons[3].emptyTexture = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Shoulder"
        TopFit.ProgressFrame.equipButtons[15].emptyTexture = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Chest"
        TopFit.ProgressFrame.equipButtons[5].emptyTexture = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Chest"
        TopFit.ProgressFrame.equipButtons[4].emptyTexture = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Shirt"
        TopFit.ProgressFrame.equipButtons[19].emptyTexture = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Tabard"
        TopFit.ProgressFrame.equipButtons[9].emptyTexture = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Wrists"
        TopFit.ProgressFrame.equipButtons[16].emptyTexture = "Interface\\PaperDoll\\UI-PaperDoll-Slot-MainHand"
        TopFit.ProgressFrame.equipButtons[17].emptyTexture = "Interface\\PaperDoll\\UI-PaperDoll-Slot-SecondaryHand"
        TopFit.ProgressFrame.equipButtons[18].emptyTexture = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Ranged"
        TopFit.ProgressFrame.equipButtons[14].emptyTexture = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Trinket"
        TopFit.ProgressFrame.equipButtons[13].emptyTexture = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Trinket"
        TopFit.ProgressFrame.equipButtons[12].emptyTexture = "Interface\\PaperDoll\\UI-PaperDoll-Slot-RFinger"
        TopFit.ProgressFrame.equipButtons[11].emptyTexture = "Interface\\PaperDoll\\UI-PaperDoll-Slot-RFinger"
        TopFit.ProgressFrame.equipButtons[8].emptyTexture = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Feet"
        TopFit.ProgressFrame.equipButtons[7].emptyTexture = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Legs"
        TopFit.ProgressFrame.equipButtons[6].emptyTexture = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Waist"
        TopFit.ProgressFrame.equipButtons[10].emptyTexture = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Hands"
        for slotID, button in pairs(TopFit.ProgressFrame.equipButtons) do
            button:SetNormalTexture(button.emptyTexture)
            -- also set tooltip functions
            button.slotID = slotID
            button:SetScript("OnEnter", ShowTooltip)
            button:SetScript("OnLeave", function (...)
                HideTooltip()
                if TopFit.ProgressFrame.forceItemsFrame then
                    if not TopFit.ProgressFrame.forceItemsFrame:IsMouseOver() then
                        TopFit.ProgressFrame.forceItemsFrame:Hide()
                    end
                end
            end)
            button:SetScript("OnClick", function (self, ...)
                if not TopFit.isBlocked then
                    if not TopFit.ProgressFrame.forceItemsFrame then
                        -- creat frame for forced items
                        TopFit.ProgressFrame.forceItemsFrame = CreateFrame("Frame", "TopFit_ProgressFrame_forceItemsFrame", UIParent)
                        --TopFit.ProgressFrame.forceItemsFrame:SetBackdrop(StaticPopup1:GetBackdrop())
                        TopFit.ProgressFrame.forceItemsFrame:SetBackdrop({
                            bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
                            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
                            tile = true,
                            tileSize = 16,
                            edgeSize = 16,
                            -- distance from the edges of the frame to those of the background texture (in pixels)
                            insets = {
                                left = 4,
                                right = 4,
                                top = 4,
                                bottom = 4
                            }
                        })
                        TopFit.ProgressFrame.forceItemsFrame:SetBackdropColor(0, 0, 0)
                        TopFit.ProgressFrame.forceItemsFrame:SetWidth(300)
                        TopFit.ProgressFrame.forceItemsFrame:EnableMouse(true)
                        TopFit.ProgressFrame.forceItemsFrame:SetScript("OnLeave", function (self, ...)
                            if not self:IsMouseOver() then
                                self:Hide()
                            end
                        end)
                        
                        -- label
                        TopFit.ProgressFrame.forceItemsFrame.slotLabel = TopFit.ProgressFrame.forceItemsFrame:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
                        TopFit.ProgressFrame.forceItemsFrame.slotLabel:SetPoint("TOPLEFT", TopFit.ProgressFrame.forceItemsFrame, "TOPLEFT", 10, -10)
                        
                        TopFit.ProgressFrame.forceItemsFrame.itemButtons = {}
                        --TopFit.ProgressFrame.forceItemsFrame.itemLabels = {}
                    end
                    TopFit.ProgressFrame.forceItemsFrame.slotLabel:SetText("Force Item for "..TopFit.slotNames[self.slotID]..":")
                    
                    local itemButtons = TopFit.ProgressFrame.forceItemsFrame.itemButtons
                    -- create "Force none" button
                    if not itemButtons[1] then
                        itemButtons[1] = CreateFrame("Button", "TopFit_ProgressFrame_forceItemsFrame_itemButton1", TopFit.ProgressFrame.forceItemsFrame)
                        itemButtons[1]:SetWidth(280)
                        itemButtons[1]:SetHeight(24)
                        itemButtons[1]:SetHighlightTexture("Interface\\Buttons\\UI-ListBox-Highlight")
                        itemButtons[1]:SetPoint("TOPLEFT", TopFit.ProgressFrame.forceItemsFrame.slotLabel, "BOTTOMLEFT", 0, -5)
                        
                        itemButtons[1].itemTexture = itemButtons[1]:CreateTexture()
                        itemButtons[1].itemTexture:SetWidth(24)
                        itemButtons[1].itemTexture:SetHeight(24)
                        itemButtons[1].itemTexture:SetPoint("TOPLEFT")
                        
                        itemButtons[1].itemLabel = itemButtons[1]:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
                        itemButtons[1].itemLabel:SetPoint("LEFT", itemButtons[1].itemTexture, "RIGHT", 3)
                        
                        itemButtons[1].itemLabel:SetText("Do not force")
                        itemButtons[1].itemTexture:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
                        
                        itemButtons[1]:SetScript("OnClick", function(self)
                            TopFit:Debug("Cleared forced item for slot "..self.slotID)
                            TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].forced[self.slotID] = nil
                            TopFit.ProgressFrame.equipButtons[self.slotID].highlightTexture:SetVertexColor(1, 1, 1, 0)
                            TopFit.ProgressFrame.forceItemsFrame:Hide()
                        end)
                    end
                    itemButtons[1].slotID = self.slotID
                    
                    -- create buttons for all items
                    TopFit:collectItems()
                    local i = 2
                    local maxWidth = 200
                    
                    local itemListBySlot = TopFit:GetEquippableItems(self.slotID)
                    
                    if itemListBySlot then
                        for _, locationTable in pairs(itemListBySlot) do
                            if not itemButtons[i] then
                                itemButtons[i] = CreateFrame("Button", "TopFit_ProgressFrame_forceItemsFrame_itemButton"..i, TopFit.ProgressFrame.forceItemsFrame)
                                itemButtons[i]:SetWidth(280)
                                itemButtons[i]:SetHeight(24)
                                itemButtons[i]:SetHighlightTexture("Interface\\Buttons\\UI-ListBox-Highlight")
                                itemButtons[i]:SetPoint("TOPLEFT", itemButtons[i - 1], "BOTTOMLEFT")
                                
                                itemButtons[i].itemTexture = itemButtons[i]:CreateTexture()
                                itemButtons[i].itemTexture:SetWidth(24)
                                itemButtons[i].itemTexture:SetHeight(24)
                                itemButtons[i].itemTexture:SetPoint("TOPLEFT")
                                
                                itemButtons[i].itemLabel = itemButtons[i]:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
                                itemButtons[i].itemLabel:SetPoint("LEFT", itemButtons[i].itemTexture, "RIGHT", 3)
                                
                                -- script handlers
                                itemButtons[i]:SetScript("OnClick", function(self)
                                    TopFit:Debug("Forced item "..select(2, GetItemInfo(self.itemID)).." for slot "..self.slotID)
                                    TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].forced[self.slotID] = self.itemID
                                    TopFit.ProgressFrame.equipButtons[self.slotID].highlightTexture:SetVertexColor(1, 0, 0, 1)
                                    TopFit.ProgressFrame.forceItemsFrame:Hide()
                                end)
                            end
                            
                            local itemTable = TopFit:GetCachedItem(locationTable.itemLink)
                            
                            if itemTable then
                                itemButtons[i].itemID = itemTable.itemID
                            end
                            itemButtons[i].slotID = self.slotID
                            itemButtons[i]:Show()
                            itemButtons[i].itemLabel:SetText(locationTable.itemLink)
                            
                            if itemButtons[i].itemLabel:GetWidth() > maxWidth then
                                maxWidth = itemButtons[i].itemLabel:GetWidth()
                            end
                            
                            local tex = select(10, GetItemInfo(locationTable.itemLink))
                            if not tex then tex = "Interface\\Icons\\Inv_misc_questionmark" end
                            itemButtons[i].itemTexture:SetTexture(tex)
                            
                            i = i + 1
                        end
                    end
                    
                    TopFit.ProgressFrame.forceItemsFrame:SetHeight(25 + (i - 1) * 24 + TopFit.ProgressFrame.forceItemsFrame.slotLabel:GetHeight())
                    TopFit.ProgressFrame.forceItemsFrame:SetWidth(maxWidth + 24 + 20)
                    for j = 1, i - 1 do
                        itemButtons[j]:SetWidth(maxWidth + 24)
                    end
                    
                    -- hide unused buttons
                    for i = i, #itemButtons do
                        itemButtons[i]:Hide()
                    end
                    
                    TopFit.ProgressFrame.forceItemsFrame:Show()
                    TopFit.ProgressFrame.forceItemsFrame:ClearAllPoints()
                    TopFit.ProgressFrame.forceItemsFrame:SetParent(self) -- so "OnLeave" will fire when the mouse leaves this frame or the button
                    TopFit.ProgressFrame.forceItemsFrame:SetPoint("RIGHT", self, "RIGHT")
                end
            end)
        end
        
        function TopFit.ProgressFrame:ResetProgress()
            TopFit.ProgressFrame.progress = nil
            TopFit.ProgressFrame.startButton:Hide()
            TopFit.ProgressFrame.setDropDown:Hide()
            TopFit.ProgressFrame.addSetButton:Hide()
            TopFit.ProgressFrame.deleteSetButton:Hide()
            TopFit.ProgressFrame.abortButton:Show()
            TopFit.ProgressFrame.progressBar:Show()
        end
        function TopFit.ProgressFrame:StoppedCalculation()
            TopFit.ProgressFrame.startButton:Show()
            TopFit.ProgressFrame.setDropDown:Show()
            TopFit.ProgressFrame.addSetButton:Show()
            TopFit.ProgressFrame.deleteSetButton:Show()
            TopFit.ProgressFrame.abortButton:Hide()
            TopFit.ProgressFrame.progressBar:Hide()
        end
        function TopFit.ProgressFrame:SetProgress(progress)
            if (TopFit.ProgressFrame.progress == nil) or (TopFit.ProgressFrame.progress < progress) then
                TopFit.ProgressFrame.progress = progress
                TopFit.ProgressFrame.progressText:SetText(round(progress * 100, 2).."%")
                TopFit.ProgressFrame.progressBar:SetValue(progress * 100)
            end
        end
        
        -- centered scrollframe for stats summary
        local boxHeight = 32 * 8 - 16
        local boxWidth = 32 * 3 + 48 * 2 - 22
        TopFit.ProgressFrame.statScrollFrame = CreateFrame("ScrollFrame", "TopFit_StatScrollFrame", TopFit.ProgressFrame, "UIPanelScrollFrameTemplate")
        TopFit.ProgressFrame.statScrollFrame:SetPoint("TOPLEFT", TopFit.ProgressFrame.equipButtons[1], "TOPRIGHT")
        TopFit.ProgressFrame.statScrollFrame:SetPoint("BOTTOMRIGHT", TopFit.ProgressFrame.equipButtons[14], "LEFT", -22, 0)
        --TopFit.ProgressFrame.statScrollFrame:SetHeight(boxHeight)
        --TopFit.ProgressFrame.statScrollFrame:SetWidth(boxWidth)
        local statScrollFrameContent = CreateFrame("Frame", nil, TopFit.ProgressFrame.statScrollFrame)
        statScrollFrameContent:SetAllPoints()
        statScrollFrameContent:SetHeight(boxHeight)
        statScrollFrameContent:SetWidth(boxWidth)
        TopFit.ProgressFrame.statScrollFrame:SetScrollChild(statScrollFrameContent)
        
        local backdrop = {bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
            tile = true,
            tileSize = 32,
            insets = { left = 0, right = -22, top = 0, bottom = 0 }}
        TopFit.ProgressFrame.statScrollFrame:SetBackdrop(backdrop)
        TopFit.ProgressFrame.statScrollFrame:SetBackdropBorderColor(0.4, 0.4, 0.4)
        TopFit.ProgressFrame.statScrollFrame:SetBackdropColor(0.1, 0.1, 0.1)
        
        -- Button for set renaming
        TopFit.ProgressFrame.renameSetButton = CreateFrame("Button", "TopFit_ProgressFrame_renameSetButton", statScrollFrameContent)
        TopFit.ProgressFrame.renameSetButton:SetPoint("TOPLEFT", statScrollFrameContent, "TOPLEFT", 3, 0)
        TopFit.ProgressFrame.renameSetButton:SetPoint("RIGHT", statScrollFrameContent, "RIGHT")
        TopFit.ProgressFrame.renameSetButton:SetHeight(32)
        TopFit.ProgressFrame.renameSetButton:SetHighlightTexture("Interface\\Buttons\\UI-ListBox-Highlight")
        TopFit.ProgressFrame.renameSetButton:SetAlpha(0.5)
        TopFit.ProgressFrame.renameSetButton:SetScript("OnClick", function(self)
            -- hide Button and Text
            TopFit.ProgressFrame.renameSetButton:Hide()
            TopFit.ProgressFrame.setNameFontString:Hide()
            
            -- show edit box
            if not TopFit.ProgressFrame.setNameEditTextBox then
                -- create box
                TopFit.ProgressFrame.setNameEditTextBox = CreateFrame("EditBox", "TopFit_ProgressFrame_statEditTextBox", statScrollFrameContent)
                TopFit.ProgressFrame.setNameEditTextBox:SetPoint("TOPLEFT", TopFit.ProgressFrame.renameSetButton, "TOPLEFT")
                TopFit.ProgressFrame.setNameEditTextBox:SetPoint("BOTTOMRIGHT", TopFit.ProgressFrame.renameSetButton, "BOTTOMRIGHT")
                TopFit.ProgressFrame.setNameEditTextBox:SetAutoFocus(false)
                TopFit.ProgressFrame.setNameEditTextBox:SetFontObject("GameFontNormalHuge")
                TopFit.ProgressFrame.setNameEditTextBox:SetJustifyH("CENTER")
                
                -- background textures
                local left = TopFit.ProgressFrame.setNameEditTextBox:CreateTexture(nil, "BACKGROUND")
                left:SetWidth(12) left:SetHeight(32)
                left:SetPoint("LEFT", -5, 0)
                left:SetTexture("Interface\\Common\\Common-Input-Border")
                left:SetTexCoord(0, 0.0625, 0, 0.625)
                local right = TopFit.ProgressFrame.setNameEditTextBox:CreateTexture(nil, "BACKGROUND")
                right:SetWidth(12) right:SetHeight(32)
                right:SetPoint("RIGHT", 0, 0)
                right:SetTexture("Interface\\Common\\Common-Input-Border")
                right:SetTexCoord(0.9375, 1, 0, 0.625)
                local center = TopFit.ProgressFrame.setNameEditTextBox:CreateTexture(nil, "BACKGROUND")
                center:SetHeight(32)
                center:SetPoint("RIGHT", right, "LEFT", 0, 0)
                center:SetPoint("LEFT", left, "RIGHT", 0, 0)
                center:SetTexture("Interface\\Common\\Common-Input-Border")
                center:SetTexCoord(0.0625, 0.9375, 0, 0.625)
                
                -- scripts
                TopFit.ProgressFrame.setNameEditTextBox:SetScript("OnEscapePressed", function (self)
                    TopFit.ProgressFrame.setNameEditTextBox:Hide()
                    TopFit.ProgressFrame.renameSetButton:Show()
                    TopFit.ProgressFrame.setNameFontString:Show()
                end)
                
                TopFit.ProgressFrame.setNameEditTextBox:SetScript("OnEnterPressed", function (self)
                    -- save new set name
                    local value = TopFit.ProgressFrame.setNameEditTextBox:GetText()
                    TopFit:RenameSet(TopFit.ProgressFrame.selectedSet, value)
                    TopFit.ProgressFrame.setNameEditTextBox:Hide()
                    TopFit.ProgressFrame.renameSetButton:Show()
                    TopFit.ProgressFrame.setNameFontString:SetText(value)
                    TopFit.ProgressFrame.setNameFontString:Show()
                end)
            end
            TopFit.ProgressFrame.setNameEditTextBox:SetText(TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].name)
            TopFit.ProgressFrame.setNameEditTextBox:Show()
            TopFit.ProgressFrame.setNameEditTextBox:HighlightText()
            TopFit.ProgressFrame.setNameEditTextBox:SetFocus()
        end)
        
        -- fontstrings for set name
        TopFit.ProgressFrame.setNameFontString = statScrollFrameContent:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge")
        TopFit.ProgressFrame.setNameFontString:SetHeight(32)
        TopFit.ProgressFrame.setNameFontString:SetPoint("TOP", statScrollFrameContent, "TOP")
        TopFit.ProgressFrame.setNameFontString:SetText("Set Name")
        
        -- fontsting for set value
        TopFit.ProgressFrame.setScoreFontString = statScrollFrameContent:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        TopFit.ProgressFrame.setScoreFontString:SetHeight(32)
        TopFit.ProgressFrame.setScoreFontString:SetPoint("TOP", TopFit.ProgressFrame.setNameFontString, "BOTTOM")
        TopFit.ProgressFrame.setScoreFontString:SetText("Total Score: -")
        
        -- List of Score contributing Texts and Bars
        statScrollFrameContent.statNameFontStrings = {}
        statScrollFrameContent.statValueFontStrings = {}
        statScrollFrameContent.statValueStatusBars = {}
        statScrollFrameContent.capNameFontStrings = {}
        statScrollFrameContent.capValueFontStrings = {}
        
        -- function for changing set name
        function TopFit.ProgressFrame:SetSelectedSet(setCode)
            if not setCode then
                -- select the first set
                local i = 1
                if TopFit.db.profile.sets and TopFit.db.profile.sets ~= {} then
                    while (not TopFit.db.profile.sets["set_"..i]) and (i < 1000) do i = i + 1 end
                    setCode = "set_"..i
                end
            end
            
            if not TopFit.db.profile.sets[setCode] then
                TopFit.ProgressFrame.selectedSet = nil
                -- disable some buttons
                TopFit.ProgressFrame.deleteSetButton:Disable()
                TopFit.ProgressFrame.startButton:Disable()
                TopFit.ProgressFrame.renameSetButton:Disable()
            else
                -- (re-)enable buttons
                TopFit.ProgressFrame.deleteSetButton:Enable()
                TopFit.ProgressFrame.startButton:Enable()
                TopFit.ProgressFrame.renameSetButton:Enable()
                
                TopFit.ProgressFrame.selectedSet = setCode
                UIDropDownMenu_SetSelectedValue(TopFit.ProgressFrame.setDropDown, setCode)
                UIDropDownMenu_SetText(TopFit.ProgressFrame.setDropDown, TopFit.db.profile.sets[setCode].name)
                TopFit.ProgressFrame:SetSetName(TopFit.db.profile.sets[setCode].name)
                
                -- generate pseudo equipment set to display when selecting a set
                local combination = {
                    items = {},
                    totalStats = {},
                    totalScore = 0,
                }
                local itemPositions = GetEquipmentSetLocations(TopFit:GenerateSetName(TopFit.db.profile.sets[setCode].name))
                --local items = GetEquipmentSetItemIDs(TopFit:GenerateSetName(TopFit.db.profile.sets[setCode].name))
                if itemPositions then
                    for slotID, itemLocation in pairs(itemPositions) do
                        if itemLocation and itemLocation ~= 1 and itemLocation ~= 0 then
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
                            
                            if itemLink then
                                itemTable = TopFit:GetCachedItem(itemLink)
                                if itemTable then
                                    combination.items[slotID] = {
                                        itemLink = itemLink,
                                        bag = bag,
                                        slot = slot
                                    }
                                    
                                    -- add to total stats and score
                                    for statName, statValue in pairs(itemTable.totalBonus) do
                                        combination.totalStats[statName] = (combination.totalStats[statName] or 0) + statValue
                                    end
                                    combination.totalScore = combination.totalScore + TopFit:GetItemScore(itemTable.itemLink, setCode)
                                end
                            end
                        end
                    end
                end
                
                TopFit.ProgressFrame:SetCurrentCombination(combination)
            end
            TopFit.eventHandler:Fire("OnSetChanged", TopFit.ProgressFrame.selectedSet)
        end
        
        function TopFit.ProgressFrame:SetSetName(text)
            TopFit.ProgressFrame.setNameFontString:SetText(text)
        end
        
        -- function for showing current calculated set
        function TopFit.ProgressFrame:SetCurrentCombination(combination)
            -- default: empty
            if not combination then
                combination = {
                    items = {},
                    totalScore = 0,
                    totalStats = {},
                }
            end
            
            -- reset to default icon
            for slotID, button in pairs(TopFit.ProgressFrame.equipButtons) do
                button:SetNormalTexture(button.emptyTexture)
                button.itemLink = nil
                -- set highlight if forced item
                if (TopFit.ProgressFrame.selectedSet) and (TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet]) and
                        (TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].forced[slotID]) then
                    TopFit.ProgressFrame.equipButtons[slotID].highlightTexture:SetVertexColor(1, 0, 0, 1)
                else
                    TopFit.ProgressFrame.equipButtons[slotID].highlightTexture:SetVertexColor(1, 1, 1, 0)
                end
            end
            for slotID, locationTable in pairs(combination.items) do
                -- set to item icon
                _, _, _, _, _, _, _, _, _, texture, _ = GetItemInfo(locationTable.itemLink)
                if not texture then texture = "Interface\\Icons\\Inv_misc_questionmark" end
                TopFit.ProgressFrame.equipButtons[slotID]:SetNormalTexture(texture)
                TopFit.ProgressFrame.equipButtons[slotID].itemLink = locationTable.itemLink
            end
            
            TopFit.ProgressFrame.setScoreFontString:SetText("Total Score: "..round(combination.totalScore, 2))
            
            -- sort stats by score contribution
            statList = {}
            scorePerStat = {}
            for key, _ in pairs(combination.totalStats) do
                tinsert(statList, key)
            end
            
            local set
            local caps
            if not TopFit.ProgressFrame.selectedSet then
                set = {}
                caps = {}
            else
                set = TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].weights
                caps = TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].caps
            end
            
            table.sort(statList, function(a, b)
                local score1, score2 = 0, 0
                if set[a] and ((not caps) or (not caps[a]) or (not caps[a]["active"]) or (caps[a]["soft"])) then
                    score1 = combination.totalStats[a] * set[a]
                end
                if set[b] and ((not caps) or (not caps[b]) or (not caps[b]["active"]) or (caps[b]["soft"])) then
                    score2 = combination.totalStats[b] * set[b]
                end
                
                scorePerStat[a] = score1
                scorePerStat[b] = score2
                
                return score1 > score2
            end)
            
            local statTexts = statScrollFrameContent.statNameFontStrings
            local valueTexts = statScrollFrameContent.statValueFontStrings
            local statusBars = statScrollFrameContent.statValueStatusBars
            local lastStat = 0
            local maxStatValue = scorePerStat[statList[1]]
            for i = 1, #statList do
                if (scorePerStat[statList[i]] ~= nil) and (scorePerStat[statList[i]] > 0) then
                    lastStat = i
                    if not statTexts[i] then
                        -- create FontStrings
                        -- fontsting for stat name
                        statusBars[i] = CreateFrame("StatusBar", "TopFit_ProgressFrame_statValueBar"..i, statScrollFrameContent)
                        statTexts[i] = statusBars[i]:CreateFontString(nil, "ARTWORK", "GameFontHighlightExtraSmall")
                        valueTexts[i] = statusBars[i]:CreateFontString(nil, "ARTWORK", "GameFontHighlightExtraSmall")
                        statTexts[i]:SetTextHeight(11)
                        valueTexts[i]:SetTextHeight(11)
                        --statTexts[i]:SetHeight(32)
                        if i == 1 then
                            statTexts[i]:SetPoint("TOP", TopFit.ProgressFrame.setScoreFontString, "BOTTOM", 0, -10)
                            valueTexts[i]:SetPoint("TOP", TopFit.ProgressFrame.setScoreFontString, "BOTTOM", 0, -10)
                            statTexts[i]:SetPoint("LEFT", statScrollFrameContent, "LEFT", 3, 0)
                            valueTexts[i]:SetPoint("RIGHT", statScrollFrameContent, "RIGHT", -3, 0)
                        else
                            statTexts[i]:SetPoint("TOPLEFT", statTexts[i - 1], "BOTTOMLEFT")
                            valueTexts[i]:SetPoint("TOPRIGHT", valueTexts[i - 1], "BOTTOMRIGHT")
                        end
                        statusBars[i]:SetPoint("TOPLEFT", statTexts[i], "TOPLEFT")
                        statusBars[i]:SetPoint("BOTTOMRIGHT", valueTexts[i], "BOTTOMRIGHT", 0, 1)
                        statusBars[i]:SetStatusBarTexture(minimalist)
                    end
                    statTexts[i]:Show()
                    valueTexts[i]:Show()
                    statusBars[i]:Show()
                    statTexts[i]:SetText(_G[statList[i]])
                    valueTexts[i]:SetText(round(combination.totalStats[statList[i]], 1))
                    statusBars[i]:SetMinMaxValues(0, maxStatValue)
                    statusBars[i]:SetValue(scorePerStat[statList[i]])
                    statusBars[i]:SetStatusBarColor(0.3, 1, 0.5, 0.5)
                end
            end
            for i = lastStat + 1, #statTexts do
                statTexts[i]:Hide()
                valueTexts[i]:Hide()
                statusBars[i]:Hide()
            end
            
            -- list for caps
            local i = 1
            local capNameTexts = statScrollFrameContent.capNameFontStrings
            local capValueTexts = statScrollFrameContent.capValueFontStrings
            
            if not statScrollFrameContent.capHeader then
                statScrollFrameContent.capHeader = statScrollFrameContent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
                statScrollFrameContent.capHeader:SetTextHeight(15)
                statScrollFrameContent.capHeader:SetText("Caps")
            end
            statScrollFrameContent.capHeader:Hide()
            
            for stat, capTable in pairs(caps) do
                if capTable.active then
                    if not capNameTexts[i] then
                        capNameTexts[i] = statScrollFrameContent:CreateFontString(nil, "ARTWORK", "GameFontHighlightExtraSmall")
                        capValueTexts[i] = statScrollFrameContent:CreateTexture()
                        capValueTexts[i]:SetWidth(11)
                        capValueTexts[i]:SetHeight(11)
                        if i == 1 then
                            capNameTexts[i]:SetPoint("TOPLEFT", statScrollFrameContent.capHeader, "BOTTOMLEFT")
                            capValueTexts[i]:SetPoint("TOP", statScrollFrameContent.capHeader, "BOTTOM")
                            capValueTexts[i]:SetPoint("RIGHT", statScrollFrameContent, "RIGHT")
                        else
                            capNameTexts[i]:SetPoint("TOPLEFT", capNameTexts[i - 1], "BOTTOMLEFT")
                            capValueTexts[i]:SetPoint("TOPRIGHT", capValueTexts[i - 1], "BOTTOMRIGHT")
                        end
                    end
                    capNameTexts[i]:SetText((_G[stat] or string.gsub(stat, "SET: ", "")))
                    if (combination.totalStats[stat]) and (combination.totalStats[stat] >= capTable.value) then
                        capValueTexts[i]:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready")
                    else
                        capValueTexts[i]:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-NotReady")
                    end
                    capNameTexts[i]:Show()
                    capValueTexts[i]:Show()
                    statScrollFrameContent.capHeader:Show()
                    
                    i = i + 1
                end
            end
            -- anchor to bottom of stat list
            if capNameTexts[1] then
                statScrollFrameContent.capHeader:SetPoint("TOPLEFT", statTexts[lastStat], "BOTTOMLEFT", 0, -20)
            end
            
            -- hide unused cap texts
            local numCaps = i
            for i = numCaps, #capNameTexts do
                capNameTexts[i]:Hide()
                capValueTexts[i]:Hide()
            end
        end
        
        --[[--
        --              Right part of Panel
        --]]--
        
        -- stuff for second half of the frame goes here!
        TopFit.ProgressFrame.isExpanded = false
        
        function TopFit.ProgressFrame:CreateHeaderButton(parent, name)
            local butt = CreateFrame("Button", name, parent)
            butt:SetWidth(80) butt:SetHeight(18)
            
            -- Fonts --
            butt:SetHighlightFontObject(GameFontHighlightSmall)
            butt:SetNormalFontObject(GameFontNormalSmall)
            
            -- Textures --
            --butt:SetHighlightTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
            --butt:GetHighlightTexture():SetTexCoord(0, 0.625, 0, 0.6875)
            butt:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")
            butt:GetHighlightTexture():SetBlendMode("ADD")
            
            local left = butt:CreateTexture("$parentLeft")
            left:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs")
            left:SetTexCoord(0, 0.078125, 0, 0.59375)
            left:SetPoint("BOTTOMLEFT")
            left:SetWidth(5)
            left:SetHeight(butt:GetHeight())
            
            local right = butt:CreateTexture("$parentRight")
            right:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs")
            right:SetTexCoord(0.90625, 0.96875, 0, 0.59375)
            right:SetPoint("BOTTOMRIGHT")
            right:SetWidth(5)
            right:SetHeight(butt:GetHeight())
            
            local center = butt:CreateTexture("$parentCenter")
            center:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs")
            center:SetTexCoord(0.078125, 0.90625, 0, 0.59375)
            center:SetPoint("LEFT", "$parentLeft", "RIGHT")
            center:SetPoint("RIGHT", "$parentRight", "LEFT")
            --center:SetWidth(5)
            center:SetHeight(butt:GetHeight())
            
            -- Tooltip bits
            butt:SetScript("OnEnter", ShowTooltip)
            butt:SetScript("OnLeave", HideTooltip)
            
            return butt
        end
        
        TopFit.ProgressFrame.pluginContainer = CreateFrame("Frame", "TopFit_ProgressFrame_PluginContainer", TopFit.ProgressFrame)
        TopFit.ProgressFrame.pluginContainer:SetPoint("TOPRIGHT", TopFit.ProgressFrame, "TOPRIGHT", -15, -15)
        TopFit.ProgressFrame.pluginContainer:SetPoint("BOTTOMRIGHT", TopFit.ProgressFrame, "BOTTOMRIGHT", -15, 15)
        TopFit.ProgressFrame.pluginContainer:SetWidth(TopFit.ProgressFrame:GetWidth() - 30)
        TopFit.ProgressFrame.pluginContainer:Hide()
        
        -- center frame on screen
        TopFit.ProgressFrame:SetPoint("CENTER", 0, 0)
        
        -- select default set
        TopFit.ProgressFrame:SetSelectedSet()
        
        -- show plugins
        TopFit:UpdatePlugins()
        TopFit:SelectPluginTab(1)
    end
    
    if not TopFit.ProgressFrame:IsShown() then
        TopFit.ProgressFrame:Show()
    end
end

function TopFit:HideProgressFrame()
    TopFit.ProgressFrame:Hide()
end
