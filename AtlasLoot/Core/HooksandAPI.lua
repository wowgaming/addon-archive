--[[
File containing all the Atlas replacement functions and the External API
]]

local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

-- Colours stored for code readability
local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";

--Establish number of boss lines in the Atlas frame for scrolling
local ATLAS_LOOT_BOSS_LINES	= 24;

--[[
AtlasLoot_Atlas_OnShow:
Hooks Atlas_OnShow() to add extra setup routines that AtlasLoot needs for
integration purposes.
]]
function AtlasLoot_Atlas_OnShow()
    Atlas_Refresh();
    
    --We don't want Atlas and the Loot Browser open at the same time, so the Loot Browser is close
    if AtlasLootDefaultFrame then
        AtlasLootDefaultFrame:Hide();
        AtlasLoot_SetupForAtlas();
    end
    --Call the Atlas function
    Hooked_Atlas_OnShow();
    --If we were looking at a loot table earlier in the session, it is still
    --saved on the item frame, so restore it in Atlas
    if AtlasLootItemsFrame.activeBoss ~= nil then
        AtlasLootItemsFrame:Show();
    else
        --If no loot table is selected, set up icons next to boss names
        for i=1,ATLAS_CUR_LINES do
            if (getglobal("AtlasEntry"..i.."_Selected") and getglobal("AtlasEntry"..i.."_Selected"):IsVisible()) then
                getglobal("AtlasEntry"..i.."_Loot"):Show();
                getglobal("AtlasEntry"..i.."_Selected"):Hide();
            end
        end
    end
    --Consult the saved variable table to see whether to show the bottom panel
    if AtlasLoot.db.profile.HidePanel == true then
        AtlasLootPanel:Hide();
    else
        AtlasLootPanel:Show();
    end 
    pFrame = AtlasFrame;
end

--[[
AtlasLoot_Refresh:
Replacement for Atlas_Refresh, required as the template for the boss buttons in Atlas is insufficient
Called whenever the state of Atlas changes
]]
function AtlasLoot_Refresh()
    --Reset which loot page is 'current'
    AtlasLootItemsFrame.activeBoss = nil;

    --Get map selection info from Atlas
    local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone];
    local data = AtlasMaps;
    local base = {};
    
    --Get boss name information
    for k,v in pairs(data[zoneID]) do
        base[k] = v;
    end
    
    --Display the newly selected texture
    AtlasMap:ClearAllPoints();
    AtlasMap:SetWidth(512);
    AtlasMap:SetHeight(512);
    AtlasMap:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 18, -84);
    local builtIn = AtlasMap:SetTexture("Interface\\AddOns\\Atlas\\Images\\Maps\\"..zoneID);
    
    --If texture was not found in the core Atlas mod, check plugins
    if ( not builtIn ) then
        for k,v in pairs(ATLAS_PLUGINS) do
            if ( AtlasMap:SetTexture("Interface\\AddOns\\"..v.."\\Images\\"..zoneID) ) then
                break;
            end
        end
    end
    
    --Setup info panel above boss listing
    local tName = base.ZoneName[1];
    if ( AtlasOptions.AtlasAcronyms and base.Acronym ~= nil) then
        local _RED = "|cffcc6666";
        tName = tName.._RED.." ["..base.Acronym.."]";
    end
    AtlasText_ZoneName_Text:SetText(tName);
    
    local tLoc = "";
    local tLR = "";
    local tML = "";
    local tPL = "";
    if ( base.Location ) then
        tLoc = ATLAS_STRING_LOCATION..": "..base.Location[1];
    end
    if ( base.LevelRange ) then
        tLR = ATLAS_STRING_LEVELRANGE..": "..base.LevelRange;
    end
    if ( base.MinLevel ) then
		tML = ATLAS_STRING_MINLEVEL..": "..base.MinLevel;
	end
    if ( base.PlayerLimit ) then
        tPL = ATLAS_STRING_PLAYERLIMIT..": "..base.PlayerLimit;
    end
    AtlasText_Location_Text:SetText(tLoc);
    AtlasText_LevelRange_Text:SetText(tLR);
    AtlasText_MinLevel_Text:SetText(tML);
    AtlasText_PlayerLimit_Text:SetText(tPL);
    
    Atlastextbase = base;
    --Get the size of the Atlas text to append stuff to the bottom.  Looks for empty lines
	--[[
    local i = 1;
    local j = 2;
    while ( (Atlastextbase[i] ~= nil and Atlastextbase[i]~="") or (Atlastextbase[j] ~= nil and Atlastextbase[j]~="")) do
        i = i + 1;
        j = i + 1;
    end
    --Allow AtlasLoot to append any extra 'boss' entries needed to a map
    if AtlasLoot_ExtraText[zoneID] ~= nil then
        --Workaround for Old Hillsbrad, we don't want the Trash Mobs stuck under the 'flavour' NPCS
        if zoneID == "CoTOldHillsbrad" then
		    Atlastextbase[22][1] = GREY..ATLASLOOT_INDENT..AL["Trash Mobs"];
        else
            for k,v in ipairs(AtlasLoot_ExtraText[zoneID]) do
                j = i + 1;
                --If the line after the empty line is not empty itself, all text below this point is shuffled down to make room
                if Atlastextbase[i]~=nil and Atlastextbase[i]~="" then
                    Atlastextbase[j] = Atlastextbase[i];
                end
                Atlastextbase[i]={v, nil, nil};
                i = i + 1;
            end
            Atlastextbase[i]={"", nil, nil};
        end
    end
	]]--
	if AtlasLoot_ExtraText[zoneID] and #Atlastextbase and #Atlastextbase > 0 then
		local numContent = #Atlastextbase
		-- add the extra lines
		for i = 1,#AtlasLoot_ExtraText[zoneID]+1 do
			Atlastextbase[numContent+i] = {"", nil, nil}
		end
		for k,v in ipairs(AtlasLoot_ExtraText[zoneID]) do
			numContent = numContent + 1
			Atlastextbase[numContent] = {v, nil, nil}
		end
		Atlastextbase[numContent+2]={"", nil, nil}
	end
	
	
    
    --Hide any Atlas objects lurking around that have now been replaced
    for i=1,ATLAS_CUR_LINES do
        if ( getglobal("AtlasEntry"..i) ) then
            getglobal("AtlasEntry"..i):Hide();
        end
    end
    
    ATLAS_DATA = Atlastextbase;
    ATLAS_SEARCH_METHOD = data.Search;
    --Deal with Atlas's search function
    if ( data.Search == nil ) then
        ATLAS_SEARCH_METHOD = AtlasSimpleSearch;
    end
    
    if ( data.Search ~= false ) then
        AtlasSearchEditBox:Show();
        AtlasNoSearch:Hide();
    else
        AtlasSearchEditBox:Hide();
        AtlasNoSearch:Show();
        ATLAS_SEARCH_METHOD = nil;
    end

    --populate the scroll frame entries list, the update func will do the rest
    Atlas_Search("");
    AtlasSearchEditBox:SetText("");
    AtlasSearchEditBox:ClearFocus();
    
    --create and align any new entry buttons that we need
    for i=1,ATLAS_CUR_LINES do
        local f;
        if (not getglobal("AtlasBossLine"..i)) then
            f = CreateFrame("Button", "AtlasBossLine"..i, AtlasFrame, "AtlasLootNewBossLineTemplate");
            f:SetFrameStrata("HIGH");
            if i==1 then
                f:SetPoint("TOPLEFT", "AtlasScrollBar", "TOPLEFT", 16, -3);
            else
                f:SetPoint("TOPLEFT", "AtlasBossLine"..(i-1), "BOTTOMLEFT");
            end
        else
            getglobal("AtlasBossLine"..i.."_Loot"):Hide();
            getglobal("AtlasBossLine"..i.."_Selected"):Hide();
        end
    end
    
    --Hide the loot frame now that a pristine Atlas instance is created
    AtlasLootItemsFrame:Hide();
    Atlas_Search("");
    --Make sure the scroll bar is correctly offset
    AtlasLoot_AtlasScrollBar_Update();
	
	--see if we should display the entrance/instance button or not, and decide what it should say
	local matchFound = {nil};
	local sayEntrance = nil;
	for k,v in pairs(Atlas_EntToInstMatches) do
		if ( k == zoneID ) then
			matchFound = v;
			sayEntrance = false;
		end
	end
	if ( not matchFound[1] ) then
		for k,v in pairs(Atlas_InstToEntMatches) do
			if ( k == zoneID ) then
				matchFound = v;
				sayEntrance = true;
			end
		end
	end
	
	--set the button's text, populate the dropdown menu, and show or hide the button
	if ( matchFound[1] ~= nil ) then
		ATLAS_INST_ENT_DROPDOWN = {};
		for k,v in pairs(matchFound) do
			table.insert(ATLAS_INST_ENT_DROPDOWN, v);
		end
		table.sort(ATLAS_INST_ENT_DROPDOWN, AtlasSwitchDD_Sort);
		if ( sayEntrance ) then
			AtlasSwitchButton:SetText(ATLAS_ENTRANCE_BUTTON);
		else
			AtlasSwitchButton:SetText(ATLAS_INSTANCE_BUTTON);
		end
		AtlasSwitchButton:Show();
		UIDropDownMenu_Initialize(AtlasSwitchDD, AtlasSwitchDD_OnLoad);
	else
		AtlasSwitchButton:Hide();
	end
	
	if ( TitanPanelButton_UpdateButton ) then
		TitanPanelButton_UpdateButton("Atlas");
	end
end


--[[
AtlasLoot_AtlasScrollBar_Update:
Hooks the Atlas scroll frame.  
Required as the Atlas function cannot deal with the AtlasLoot button template or the added Atlasloot entries
]]
function AtlasLoot_AtlasScrollBar_Update()
    local line, lineplusoffset;
    if (getglobal("AtlasBossLine1_Text") ~= nil) then
        local zoneID = ATLAS_DROPDOWNS[AtlasOptions.AtlasType][AtlasOptions.AtlasZone];
        --Update the contents of the Atlas scroll frame
        FauxScrollFrame_Update(AtlasScrollBar,ATLAS_CUR_LINES,ATLAS_LOOT_BOSS_LINES,15);
        --Make note of how far in the scroll frame we are
        for line=1,ATLAS_NUM_LINES do
            lineplusoffset = line + FauxScrollFrame_GetOffset(AtlasScrollBar);
            if ( lineplusoffset <= ATLAS_CUR_LINES ) then
                getglobal("AtlasBossLine"..line.."_Text"):SetText(ATLAS_SCROLL_LIST[lineplusoffset]);
                if AtlasLootItemsFrame.activeBoss == lineplusoffset then
                    getglobal("AtlasBossLine"..line.."_Loot"):Hide();
                    getglobal("AtlasBossLine"..line.."_Selected"):Show();
                elseif (AtlasLootBossButtons[zoneID]~=nil and AtlasLootBossButtons[zoneID][lineplusoffset] ~= nil and AtlasLootBossButtons[zoneID][lineplusoffset] ~= "") then
                    getglobal("AtlasBossLine"..line.."_Loot"):Show();
                    getglobal("AtlasBossLine"..line.."_Selected"):Hide();
                elseif (AtlasLootWBBossButtons[zoneID]~=nil and AtlasLootWBBossButtons[zoneID][lineplusoffset] ~= nil and AtlasLootWBBossButtons[zoneID][lineplusoffset] ~= "") then
                    getglobal("AtlasBossLine"..line.."_Loot"):Show();
                    getglobal("AtlasBossLine"..line.."_Selected"):Hide();
                elseif (AtlasLootBattlegrounds[zoneID]~=nil and AtlasLootBattlegrounds[zoneID][lineplusoffset] ~= nil and AtlasLootBattlegrounds[zoneID][lineplusoffset] ~= "") then
                    getglobal("AtlasBossLine"..line.."_Loot"):Show();
                    getglobal("AtlasBossLine"..line.."_Selected"):Hide();
                else
                    getglobal("AtlasBossLine"..line.."_Loot"):Hide();
                    getglobal("AtlasBossLine"..line.."_Selected"):Hide();
                end
                getglobal("AtlasBossLine"..line).idnum = lineplusoffset;
                getglobal("AtlasBossLine"..line):Show();
            elseif ( getglobal("AtlasBossLine"..line) ) then
                --Hide lines that are not needed
                getglobal("AtlasBossLine"..line):Hide();
            end
        end
    else
        Hooked_AtlasScrollBar_Update();
    end
end

--[[
AtlasLoot_ShowBossLoot(dataID, boss, pFrame):
dataID - Name of the loot table
boss - Text string to be used as the title for the loot page
pFrame - Data structure describing how and where to anchor the item frame (more details, see the function AtlasLoot_SetItemInfoFrame)
This is the intended API for external mods to use for displaying loot pages.
This function figures out where the loot table is stored, then sends the relevant info to AtlasLoot_ShowItemsFrame
]]
function AtlasLoot_ShowBossLoot(dataID, boss, pFrame)

    local tableavailable = AtlasLoot_IsLootTableAvailable(dataID);
    
    if (tableavailable) then
        AtlasLootItemsFrame:Hide();

        --If the loot table is already being displayed, it is hidden and the current table selection cancelled
        if ( dataID == AtlasLootItemsFrame.externalBoss ) and (AtlasLootItemsFrame:GetParent() ~= AtlasFrame) and (AtlasLootItemsFrame:GetParent() ~= AtlasLootDefaultFrame_LootBackground) then
            AtlasLootItemsFrame.externalBoss = nil;
        else
            --Use the original WoW instance data by default
            local dataSource = AtlasLoot_TableNames[dataID][2];

            --Set anchor point, set selected table and call AtlasLoot_ShowItemsFrame
            AtlasLoot_AnchorFrame = pFrame;
            AtlasLootItemsFrame.externalBoss = dataID;
            AtlasLoot_ShowItemsFrame(dataID, dataSource, boss, pFrame);
        end
    end
end
