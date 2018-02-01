
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

function TopFit:CreateVirtualItemsPlugin()
    local frame, pluginId = TopFit:RegisterPlugin("Virtual Items", "Use this tab to include items you currently do not have in your inventory in the calculation.")
    frame.initialized = false
    
    -- register events
    TopFit.RegisterCallback("TopFit_vitualItems", "OnShow", function(event, id)
        if (id == pluginId) then
            if (not frame.initialized) then
                -- initialize interface when shown the first time
                -- option for disabling virtual items calculation
                frame.includeVirtualItemsCheckButton = LibStub("tekKonfig-Checkbox").new(frame, nil, "Include virtual items in calculation", "TOPLEFT", frame, "TOPLEFT", 0, 0)
                frame.includeVirtualItemsCheckButton.tiptext = "|cffffffffCheck to include virtual items in this set's calculations. This will result in the set not being equipped, regardless of whether the resulting equipment uses a virtual item or not.\nTurn this option off or remove all virtual items from the set to do a calculation including only your actual items and save the result as an equipment set."
                if TopFit.ProgressFrame and TopFit.ProgressFrame.selectedSet then
                    frame.includeVirtualItemsCheckButton:SetChecked(not TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].skipVirtualItems)
                end
                local checksound = frame.includeVirtualItemsCheckButton:GetScript("OnClick")
                frame.includeVirtualItemsCheckButton:SetScript("OnClick", function(self)
                    checksound(self)
                    if (TopFit.ProgressFrame.selectedSet) then
                        TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].skipVirtualItems = not TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].skipVirtualItems
                    end
                end)
                
                -- label for item text box
                frame.addItemLabel = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
                frame.addItemLabel:SetWordWrap(true)
                frame.addItemLabel:SetJustifyH("LEFT")
                frame.addItemLabel:SetHeight(50)
                frame.addItemLabel:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -20)
                frame.addItemLabel:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, -20)
                frame.addItemLabel:SetText("Paste an item link or an item ID in this edit box and press <Enter> to add that item to your virtual items.\nTo remove it, right-click it in the list below.")
                
                -- create text box for items
                frame.addItemTextBox = CreateFrame("EditBox", "$parent_AddItemTextBox", frame)
                frame.addItemTextBox:SetWidth(50)
                frame.addItemTextBox:SetHeight(11)
                frame.addItemTextBox:SetAutoFocus(false)
                frame.addItemTextBox:SetFontObject("GameFontHighlightSmall")
                frame.addItemTextBox:SetJustifyH("LEFT")
                
                frame.addItemTextBox:SetPoint("LEFT")
                frame.addItemTextBox:SetPoint("RIGHT")
                frame.addItemTextBox:SetPoint("TOP", frame.addItemLabel, "BOTTOM", 0, -10)
                
                -- background textures
                local left = frame.addItemTextBox:CreateTexture(nil, "BACKGROUND")
                left:SetWidth(8) left:SetHeight(20)
                left:SetPoint("LEFT", -5, 0)
                left:SetTexture("Interface\\Common\\Common-Input-Border")
                left:SetTexCoord(0, 0.0625, 0, 0.625)
                local right = frame.addItemTextBox:CreateTexture(nil, "BACKGROUND")
                right:SetWidth(8) right:SetHeight(20)
                right:SetPoint("RIGHT", 0, 0)
                right:SetTexture("Interface\\Common\\Common-Input-Border")
                right:SetTexCoord(0.9375, 1, 0, 0.625)
                local center = frame.addItemTextBox:CreateTexture(nil, "BACKGROUND")
                center:SetHeight(20)
                center:SetPoint("RIGHT", right, "LEFT", 0, 0)
                center:SetPoint("LEFT", left, "RIGHT", 0, 0)
                center:SetTexture("Interface\\Common\\Common-Input-Border")
                center:SetTexCoord(0.0625, 0.9375, 0, 0.625)
                
                -- scripts
                frame.addItemTextBox:SetScript("OnEscapePressed", function (self)
                    frame.addItemTextBox:SetText("")
                    frame.addItemTextBox:ClearFocus()
                end)
                
                frame.addItemTextBox:SetScript("OnEnterPressed", function (self)
                    -- check if input is itemLink or itemID
                    name, link = GetItemInfo(self:GetText())
                    frame.addItemTextBox:SetText("")
                    
                    if not link then
                        TopFit:Print("Item not found.")
                    else
                        TopFit:Debug("Adding "..link.." to virtual items")
                        frame.itemsFrame:AddItem(link)
                    end
                end)
                
                -- hook shift-clicks on items
                hooksecurefunc("ChatEdit_InsertLink", function(text)
                    if --[[IsShiftKeyDown() and]] frame.addItemTextBox:HasFocus() then
                        frame.addItemTextBox:Insert(text)
                    end
                end)
                
                -- item list
                local backdrop = {bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
                    tile = true,
                    tileSize = 32,
                    insets = { left = 0, right = -22, top = 0, bottom = 0 }}
                
                frame.itemsFrame = CreateFrame("ScrollFrame", "$parent_ItemsFrame", frame, "UIPanelScrollFrameTemplate")
                frame.itemsFrame:SetPoint("TOPLEFT", frame.addItemTextBox, "BOTTOMLEFT", 0, -25)
                frame.itemsFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -25, 0)
                frame.itemsFrame.content = CreateFrame("Frame", nil, frame.itemsFrame)
                frame.itemsFrame.content:SetHeight(100)
                frame.itemsFrame.content:SetWidth(100)
                frame.itemsFrame.content:SetAllPoints()
                frame.itemsFrame:SetScrollChild(frame.itemsFrame.content)
                
                frame.itemsFrame:SetBackdrop(backdrop)
                frame.itemsFrame:SetBackdropBorderColor(0.4, 0.4, 0.4)
                frame.itemsFrame:SetBackdropColor(0.1, 0.1, 0.1)
                
                local itemButtons = {}
                frame.itemsFrame.buttons = itemButtons
                
                function frame.itemsFrame:AddItem(link)
                    if (TopFit.ProgressFrame.selectedSet) then
                        if not TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].virtualItems then TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].virtualItems = {} end
                        tinsertonce(TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].virtualItems, link)
                    end
                    frame.itemsFrame:RefreshItems()
                end
                
                function frame.itemsFrame:RefreshItems()
                    local i
                    local lastLine, totalWidth = 1, 0
                    local j = 1
                    if (TopFit.ProgressFrame.selectedSet) then
                        if (TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].virtualItems) then
                            for i = 1, #(TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].virtualItems) do
                                j = i + 1
                                if not frame.itemsFrame.buttons[i] then
                                    frame.itemsFrame.buttons[i] = CreateFrame("Button", "$parent_ItemButton_"..i, frame.itemsFrame.content)
                                    frame.itemsFrame.buttons[i]:SetHeight(32)
                                    frame.itemsFrame.buttons[i]:SetWidth(32)
                                    frame.itemsFrame.buttons[i]:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
                                    
                                    frame.itemsFrame.buttons[i]:RegisterForClicks("RightButtonUp")
                                    
                                    frame.itemsFrame.buttons[i]:SetScript("OnEnter", ShowTooltip)
                                    frame.itemsFrame.buttons[i]:SetScript("OnLeave", HideTooltip)
                                    frame.itemsFrame.buttons[i]:SetScript("OnClick", function(self)
                                        -- remove item from list
                                        if (TopFit.ProgressFrame.selectedSet and TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].virtualItems) then
                                            -- find item and remove it
                                            local i
                                            for i = 1, #(TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].virtualItems) do
                                                if (self.itemLink == TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].virtualItems[i]) then
                                                    tremove(TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].virtualItems, i)
                                                end
                                            end
                                            
                                            frame.itemsFrame:RefreshItems()
                                        end
                                    end)
                                end
                                frame.itemsFrame.buttons[i].itemLink = TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].virtualItems[i]
                                local texture = select(10, GetItemInfo(TopFit.db.profile.sets[TopFit.ProgressFrame.selectedSet].virtualItems[i]))
                                if texture then
                                    frame.itemsFrame.buttons[i]:SetNormalTexture(texture)
                                else
                                    frame.itemsFrame.buttons[i]:SetNormalTexture("Interface\\Icons\\Inv_Misc_Questionmark")
                                end
                                frame.itemsFrame.buttons[i]:Show()
                                
                                if i == 1 then
                                    -- anchor to top left of frame
                                    frame.itemsFrame.buttons[i]:SetPoint("TOPLEFT", frame.itemsFrame.content, "TOPLEFT")
                                    totalWidth = totalWidth + 32
                                else
                                    -- anchor to previous item, or beginning of next line
                                    if (totalWidth + 32) < frame.itemsFrame:GetWidth() then
                                        frame.itemsFrame.buttons[i]:SetPoint("TOPLEFT", frame.itemsFrame.buttons[i - 1], "TOPRIGHT")
                                        totalWidth = totalWidth + 32
                                    else
                                        frame.itemsFrame.buttons[i]:SetPoint("TOPLEFT", frame.itemsFrame.buttons[lastLine], "BOTTOMLEFT")
                                        totalWidth = 32
                                        lastLine = i
                                    end
                                end
                            end
                        end
                    end
                    
                    -- hide unused buttons
                    for i = j, #(frame.itemsFrame.buttons) do
                        frame.itemsFrame.buttons[i]:Hide()
                    end
                end
                frame.initialized = true
            end
            
            
            frame.itemsFrame:RefreshItems()
        end
    end)
    
    TopFit.RegisterCallback("TopFit_vitualItems", "OnSetChanged", function(event, setId)
        if (setId) then
            -- enable inputs
        else
            -- no set selected, disable inputs
        end
        if (frame.initialized) then
            frame.itemsFrame:RefreshItems()
        end
    end)
end
