
function TopFit:RegisterPlugin(pluginName, tooltipText)
    -- create / register plugin-tab
    local pluginInfo = {
        name = pluginName,
        tooltipText = tooltipText,
    }
    
    tinsert(TopFit.plugins, pluginInfo)
    pluginInfo.id = #(TopFit.plugins)
    
    -- return frame for plugin UI
    pluginInfo.frame = CreateFrame("Frame", "TopFit_ProgressFrame_PluginFrame_"..(pluginInfo.id), nil)
    if pluginInfo.id > 1 then
        pluginInfo.frame:Hide()
    end
    
    TopFit:UpdatePlugins()
    
    return pluginInfo.frame, pluginInfo.id
end

function TopFit:UpdatePlugins()
    if TopFit.ProgressFrame then
        local i
        for i = 1, #(TopFit.plugins) do
            local pluginInfo = TopFit.plugins[i]
            -- update parents and anchors for plugin frames
            pluginInfo.frame:SetParent(TopFit.ProgressFrame.pluginContainer)
            pluginInfo.frame:SetAllPoints()
            
            -- create tabs if necessary
            if not pluginInfo.tabButton then
                -- create plugin button and size / anchor it
                pluginInfo.tabButton = TopFit.ProgressFrame:CreateHeaderButton(TopFit.ProgressFrame.pluginContainer, "TopFit_ProgressFrame_PluginButton_"..(pluginInfo.id))
                pluginInfo.tabButton:SetPoint("BOTTOM", TopFit.ProgressFrame, "TOP", 0, -7)
                if (pluginInfo.id == 1) then
                    pluginInfo.tabButton:SetPoint("LEFT", TopFit.ProgressFrame.pluginContainer, "LEFT")
                else
                    pluginInfo.tabButton:SetPoint("LEFT", TopFit.plugins[pluginInfo.id - 1].tabButton, "RIGHT", 3, 0)
                end
                
                -- set event handlers
                pluginInfo.tabButton:SetScript("OnClick", function()
                    TopFit:SelectPluginTab(pluginInfo.id)
                end)
            end
            pluginInfo.tabButton:SetText(pluginInfo.name)
            pluginInfo.tabButton:SetWidth(pluginInfo.tabButton:GetFontString():GetStringWidth() + 10)
            pluginInfo.tabButton.tipText = pluginInfo.tooltipText
        end
    end
end

function TopFit:SelectPluginTab(id)
    local i
    for i = 1, #(TopFit.plugins) do
        if i == id then
            TopFit.plugins[i].frame:Show()
            TopFit.eventHandler:Fire("OnShow", id)
        else
            TopFit.plugins[i].frame:Hide()
        end
    end
end
