--[[
This file contains all the Atlas specific functions
]]

local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

--[[
AtlasLoot_SetupForAtlas:
This function sets up the Atlas specific XML objects
]]
function AtlasLoot_SetupForAtlas()
    --Position the frame with the AtlasLoot version details in the Atlas frame
    AtlasLootInfo:ClearAllPoints();
    AtlasLootInfo:SetParent(AtlasFrame);
    AtlasLootInfo:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 546, -3);
    
    --Anchor the bottom panel to the Atlas frame
    AtlasLootPanel:ClearAllPoints();
    AtlasLootPanel:SetParent(AtlasFrame);
    AtlasLootPanel:SetPoint("TOP", "AtlasFrame", "BOTTOM", 0, 9);

    --Anchor the loot table to the Atlas frame
    AtlasLoot_SetItemInfoFrame();
    AtlasLootItemsFrame:Hide();
    AtlasLoot_AnchorFrame = AtlasFrame;	
end

--[[
AtlasLootBoss_OnClick:
Invoked whenever a boss line in Atlas is clicked
Shows a loot page if one is associated with the button
]]
function AtlasLootBoss_OnClick(name)
    
    
    
    local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone];
    local id = this.idnum;
    
    
    --If the loot table was already shown and boss clicked again, hide the loot table and fix boss list icons
    if getglobal(name.."_Selected"):IsVisible() then
        getglobal(name.."_Selected"):Hide();
        getglobal(name.."_Loot"):Show();
        AtlasLootItemsFrame:Hide();
        AtlasLootItemsFrame.activeBoss = nil;
    else    
        --If an loot table is associated with the button, show it.  Note multiple tables need to be checked due to the database structure
        if (AtlasLootBossButtons[zoneID] ~= nil and AtlasLootBossButtons[zoneID][id] ~= nil and AtlasLootBossButtons[zoneID][id] ~= "") then
            if AtlasLoot_IsLootTableAvailable(AtlasLootBossButtons[zoneID][id]) then
                getglobal(name.."_Selected"):Show();
                getglobal(name.."_Loot"):Hide();
                local _,_,boss = string.find(getglobal(name.."_Text"):GetText(), "|c%x%x%x%x%x%x%x%x%s*[%dX']*[%) ]*(.*[^%,])[%,]?$");
                AtlasLoot_ShowBossLoot(AtlasLootBossButtons[zoneID][id], boss, AtlasFrame);
                AtlasLootItemsFrame.activeBoss = id;
                AtlasLoot_AtlasScrollBar_Update();
            end
        elseif (AtlasLootWBBossButtons[zoneID] ~= nil and AtlasLootWBBossButtons[zoneID][id] ~= nil and AtlasLootWBBossButtons[zoneID][id] ~= "") then
            if AtlasLoot_IsLootTableAvailable(AtlasLootWBBossButtons[zoneID][id]) then
                getglobal(name.."_Selected"):Show();
                getglobal(name.."_Loot"):Hide();
                local _,_,boss = string.find(getglobal(name.."_Text"):GetText(), "|c%x%x%x%x%x%x%x%x%s*[%dX]*[%) ]*(.*[^%,])[%,]?$");
                AtlasLoot_ShowBossLoot(AtlasLootWBBossButtons[zoneID][id], boss, AtlasFrame);
                AtlasLootItemsFrame.activeBoss = id;
                AtlasLoot_AtlasScrollBar_Update();
            end
        elseif (AtlasLootBattlegrounds[zoneID] ~= nil and AtlasLootBattlegrounds[zoneID][id] ~= nil and AtlasLootBattlegrounds[zoneID][id] ~= "") then
            if AtlasLoot_IsLootTableAvailable(AtlasLootBattlegrounds[zoneID][id]) then    
                getglobal(name.."_Selected"):Show();
                getglobal(name.."_Loot"):Hide();
                local _,_,boss = string.find(getglobal(name.."_Text"):GetText(), "|c%x%x%x%x%x%x%x%x%s*[%wX]*[%) ]*(.*[^%,])[%,]?$");
                AtlasLoot_ShowBossLoot(AtlasLootBattlegrounds[zoneID][id], boss, AtlasFrame);
                AtlasLootItemsFrame.activeBoss = id;
                AtlasLoot_AtlasScrollBar_Update();
            end
        end
    end
    
    --This has been invoked from Atlas, so we remove any claim external mods have on the loot table
    AtlasLootItemsFrame.externalBoss = nil;
    
    --Hide the AtlasQuest frame if present so that the AtlasLoot items frame is not stuck under it
    if (AtlasQuestInsideFrame) then
        HideUIPanel(AtlasQuestInsideFrame);
    end
end
