--[[
Functions:
AtlasLoot_DewDropClick(tablename, text, tabletype)
AtlasLoot_DewDropSubMenuClick(tablename, text)
AtlasLoot_DefaultFrame_OnShow()
AtlasLootDefaultFrame_OnHide()
AtlasLoot_DewdropSubMenuRegister(loottable)
AtlasLoot_DewdropRegister()
AtlasLoot_SetNewStyle(style)
]]

--Include all needed libraries
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local BabbleBoss = AtlasLoot_GetLocaleLibBabble("LibBabble-Boss-3.0")
local BabbleFaction = AtlasLoot_GetLocaleLibBabble("LibBabble-Faction-3.0")
local BabbleZone = AtlasLoot_GetLocaleLibBabble("LibBabble-Zone-3.0")

--Load the 2 dewdrop menus
AtlasLoot_Dewdrop = AceLibrary("Dewdrop-2.0");
AtlasLoot_DewdropSubMenu = AceLibrary("Dewdrop-2.0");

AtlasLoot_Data["AtlasLootFallback"] = {
    EmptyInstance = {};
};

--[[
AtlasLoot_DewDropClick(tablename, text, tabletype):
tablename - Name of the loot table in the database
text - Heading for the loot table
tabletype - Whether the tablename indexes an actual table or needs to generate a submenu
Called when a button in AtlasLoot_Dewdrop is clicked
]]
function AtlasLoot_DewDropClick(tablename, text, tabletype)
    --Definition of where I want the loot table to be shown
    pFrame = { "TOPLEFT", "AtlasLootDefaultFrame_LootBackground", "TOPLEFT", "2", "-2" };
    
    --If the button clicked was linked to a loot table
    if tabletype == "Table" then
        --Show the loot table
        AtlasLoot_ShowItemsFrame(tablename, "", text, pFrame);
        --Save needed info for fuure re-display of the table
        AtlasLoot.db.profile.LastBoss = tablename;
        --Purge the text label for the submenu and disable the submenu
        AtlasLootDefaultFrame_SubMenu:Disable();
        AtlasLootDefaultFrame_SelectedTable:SetText("");
        AtlasLootDefaultFrame_SelectedTable:Show();
    --If the button links to a sub menu definition
    else
        --Enable the submenu button
        AtlasLootDefaultFrame_SubMenu:Enable();
        --Show the first loot table associated with the submenu
        AtlasLoot_ShowBossLoot(AtlasLoot_DewDropDown_SubTables[tablename][1][2], AtlasLoot_DewDropDown_SubTables[tablename][1][1], pFrame);
        --Save needed info for fuure re-display of the table
        AtlasLoot.db.profile.LastBoss = AtlasLoot_DewDropDown_SubTables[tablename][1][2];
        --Load the correct submenu and associated with the button
        AtlasLoot_DewdropSubMenu:Unregister(AtlasLootDefaultFrame_SubMenu);
        AtlasLoot_DewdropSubMenuRegister(AtlasLoot_DewDropDown_SubTables[tablename]);
        --Show a text label of what has been selected
        if AtlasLoot_DewDropDown_SubTables[tablename][1][1] ~= "" then
            AtlasLootDefaultFrame_SelectedTable:SetText(AtlasLoot_DewDropDown_SubTables[tablename][1][1]);
        else
            AtlasLootDefaultFrame_SelectedTable:SetText(AtlasLoot_TableNames[AtlasLoot_DewDropDown_SubTables[tablename][1][2]][1]);
        end
        AtlasLootDefaultFrame_SelectedTable:Show();
    end
    --Show the category that has been selected
    AtlasLootDefaultFrame_SelectedCategory:SetText(text);
    AtlasLootDefaultFrame_SelectedCategory:Show();
    AtlasLoot_Dewdrop:Close(1);
end 

--[[
AtlasLoot_DewDropSubMenuClick(tablename, text):
tablename - Name of the loot table in the database
text - Heading for the loot table
Called when a button in AtlasLoot_DewdropSubMenu is clicked
]]
function AtlasLoot_DewDropSubMenuClick(tablename, text)
    --Definition of where I want the loot table to be shown
    pFrame = { "TOPLEFT", "AtlasLootDefaultFrame_LootBackground", "TOPLEFT", "2", "-2" };
    --Show the select loot table
    AtlasLoot_ShowItemsFrame(tablename, "", text, pFrame);
    --Save needed info for fuure re-display of the table
    AtlasLoot.db.profile.LastBoss = tablename;
    --Show the table that has been selected
    if text ~= "" then
        AtlasLootDefaultFrame_SelectedTable:SetText(text);
    else
        AtlasLootDefaultFrame_SelectedTable:SetText(AtlasLoot_TableNames[tablename][1]);
    end
    AtlasLootDefaultFrame_SelectedTable:Show();
    AtlasLoot_DewdropSubMenu:Close(1);
end

--[[
AtlasLootDefaultFrame_OnShow:
Called whenever the loot browser is shown and sets up buttons and loot tables
]]
function AtlasLootDefaultFrame_OnShow()
    --Definition of where I want the loot table to be shown    
    pFrame = { "TOPLEFT", "AtlasLootDefaultFrame_LootBackground", "TOPLEFT", "2", "-2" };
    --Having the Atlas and loot browser frames shown at the same time would
    --cause conflicts, so I hide the Atlas frame when the loot browser appears
    if AtlasFrame then
        AtlasFrame:Hide();
    end
    --Remove the selection of a loot table in Atlas
    AtlasLootItemsFrame.activeBoss = nil;
    --Set the item table to the loot table
    AtlasLoot_SetItemInfoFrame(pFrame);
    --Show the last displayed loot table
    if AtlasLoot_IsLootTableAvailable(AtlasLoot.db.profile.LastBoss) then
        AtlasLoot_ShowBossLoot(AtlasLoot.db.profile.LastBoss, "", pFrame);
    else
        AtlasLoot_ShowBossLoot("EmptyTable", AL["Select a Loot Table..."], pFrame);
    end
end

--[[
AtlasLootDefaultFrame_OnHide:
When we close the loot browser, re-bind the item table to Atlas
and close all Dewdrop menus
]]
function AtlasLootDefaultFrame_OnHide()
    if AtlasFrame then
        AtlasLoot_SetupForAtlas();
    end
    AtlasLoot_Dewdrop:Close(1);
    AtlasLoot_DewdropSubMenu:Close(1);
end   

--[[
AtlasLoot_DewdropSubMenuRegister(loottable):
loottable - Table defining the sub menu
Generates the sub menu needed by passing a table of loot tables and titles
]]
function AtlasLoot_DewdropSubMenuRegister(loottable)
    AtlasLoot_DewdropSubMenu:Register(AtlasLootDefaultFrame_SubMenu,
        'point', function(parent)
            return "TOP", "BOTTOM"
        end,
        'children', function(level, value)
            if level == 1 then
                for k,v in pairs(loottable) do
                    if v[1] == "" then
                        AtlasLoot_DewdropSubMenu:AddLine(
                            'text', AtlasLoot_TableNames[v[2]][1],
                            'func', AtlasLoot_DewDropSubMenuClick,
                            'arg1', v[2],
                            'arg2', v[1],
                            'notCheckable', true
                        )
                    else
                        AtlasLoot_DewdropSubMenu:AddLine(
                            'text', v[1],
                            'func', AtlasLoot_DewDropSubMenuClick,
                            'arg1', v[2],
                            'arg2', v[1],
                            'notCheckable', true
                        )
                    end
                end
                AtlasLoot_DewdropSubMenu:AddLine(
					'text', AL["Close Menu"],
                    'textR', 0,
                    'textG', 1,
                    'textB', 1,
					'func', function() AtlasLoot_DewdropSubMenu:Close() end,
					'notCheckable', true
				)
            end
		end,
		'dontHook', true
	)
end

--[[
AtlasLoot_DewdropRegister:
Constructs the main category menu from a tiered table
]]
function AtlasLoot_DewdropRegister()
	AtlasLoot_Dewdrop:Register(AtlasLootDefaultFrame_Menu,
        'point', function(parent)
            return "TOP", "BOTTOM"
        end,
		'children', function(level, value)
			if level == 1 then
				if AtlasLoot_DewDropDown then
                    for k,v in ipairs(AtlasLoot_DewDropDown) do
                        --If a link to show a submenu
                        if (type(v[1]) == "table") and (type(v[1][1]) == "string") then
                            local checked = false;
                            if v[1][3] == "Submenu" then
                                AtlasLoot_Dewdrop:AddLine(
                                    'text', v[1][1],
                                    'textR', 1,
                                    'textG', 0.82,
                                    'textB', 0,
                                    'func', AtlasLoot_DewDropClick,
                                    'arg1', v[1][2],
                                    'arg2', v[1][1],
                                    'arg3', v[1][3],
                                    'notCheckable', true
                                )
                            elseif v[1][3] == "Table" and v[1][1] ~= "" then
                                AtlasLoot_Dewdrop:AddLine(
                                    'text', v[1][1],
                                    'textR', 1,
                                    'textG', 0.82,
                                    'textB', 0,
                                    'func', AtlasLoot_DewDropClick,
                                    'arg1', v[1][2],
                                    'arg2', v[1][1],
                                    'arg3', v[1][3],
                                    'notCheckable', true
                                )
                            end
                        else
                            local lock=0;
                            --If an entry linked to a subtable
                            for i,j in pairs(v) do
                                if lock==0 then
                                    AtlasLoot_Dewdrop:AddLine(
                                        'text', i,
                                        'textR', 1,
                                        'textG', 0.82,
                                        'textB', 0,
                                        'hasArrow', true,
                                        'value', j,
                                        'notCheckable', true
                                    )
                                    lock=1;
                                end
                            end
                        end
                    end
                end
                --Close button
				AtlasLoot_Dewdrop:AddLine(
					'text', AL["Close Menu"],
                    'textR', 0,
                    'textG', 1,
                    'textB', 1,
					'func', function() AtlasLoot_Dewdrop:Close() end,
					'notCheckable', true
				)
			elseif level == 2 then
				if value then
                    for k,v in ipairs(value) do
                        if type(v) == "table" then
                            if (type(v[1]) == "table") and (type(v[1][1]) == "string") then
                                local checked = false;
                                --If an entry to show a submenu
                                if v[1][3] == "Submenu" then
                                AtlasLoot_Dewdrop:AddLine(
                                    'text', v[1][1],
                                    'textR', 1,
                                    'textG', 0.82,
                                    'textB', 0,
                                    'func', AtlasLoot_DewDropClick,
                                    'arg1', v[1][2],
                                    'arg2', v[1][1],
                                    'arg3', v[1][3],
                                    'notCheckable', true
                                )
                                --An entry to show a specific loot page
                                elseif v[1][3] == "Table" and v[1][1] == "" then
                                    AtlasLoot_Dewdrop:AddLine(
                                        'text', AtlasLoot_TableNames[v[1][2]][1],
                                        'textR', 1,
                                        'textG', 0.82,
                                        'textB', 0,
                                        'func', AtlasLoot_DewDropClick,
                                        'arg1', v[1][2],
                                        'arg2', v[1][1],
                                        'arg3', v[1][3],
                                        'notCheckable', true
                                    )
                                else
                                    AtlasLoot_Dewdrop:AddLine(
                                        'text', v[1][1],
                                        'textR', 1,
                                        'textG', 0.82,
                                        'textB', 0,
                                        'func', AtlasLoot_DewDropClick,
                                        'arg1', v[1][2],
                                        'arg2', v[1][1],
                                        'arg3', v[1][3],
                                        'notCheckable', true
                                    )
                                end
                            else
                                local lock=0;
                                --Entry to link to a sub table
                                for i,j in pairs(v) do
                                    if lock==0 then
                                        AtlasLoot_Dewdrop:AddLine(
                                            'text', i,
                                            'textR', 1,
                                            'textG', 0.82,
                                            'textB', 0,
                                            'hasArrow', true,
                                            'value', j,
                                            'notCheckable', true
                                        )
                                        lock=1;
                                    end
                                end
                            end
                        end
                    end
                end
                AtlasLoot_Dewdrop:AddLine(
					'text', AL["Close Menu"],
                    'textR', 0,
                    'textG', 1,
                    'textB', 1,
					'func', function() AtlasLoot_Dewdrop:Close() end,
					'notCheckable', true
				)
            elseif level == 3 then
                --Essentially the same as level == 2
                if value then
                    for k,v in pairs(value) do
                        if type(v[1]) == "string" then
                            local checked = false;
                            if v[3] == "Submenu" then
                                AtlasLoot_Dewdrop:AddLine(
                                    'text', v[1],
                                    'textR', 1,
                                    'textG', 0.82,
                                    'textB', 0,
                                    'func', AtlasLoot_DewDropClick,
                                    'arg1', v[2],
                                    'arg2', v[1],
                                    'arg3', v[3],
                                    'notCheckable', true
                                )
                            elseif v[3] == "Table" and v[1] == "" then
                                AtlasLoot_Dewdrop:AddLine(
                                    'text', AtlasLoot_TableNames[v[2]][1],
                                    'textR', 1,
                                    'textG', 0.82,
                                    'textB', 0,
                                    'func', AtlasLoot_DewDropClick,
                                    'arg1', v[2],
                                    'arg2', v[1],
                                    'arg3', v[3],
                                    'notCheckable', true
                                )
                            else
                                AtlasLoot_Dewdrop:AddLine(
                                    'text', v[1],
                                    'textR', 1,
                                    'textG', 0.82,
                                    'textB', 0,
                                    'func', AtlasLoot_DewDropClick,
                                    'arg1', v[2],
                                    'arg2', v[1],
                                    'arg3', v[3],
                                    'notCheckable', true
                                )
                            end
                        elseif type(v) == "table" then
                            AtlasLoot_Dewdrop:AddLine(
                                'text', k,
                                'textR', 1,
                                'textG', 0.82,
                                'textB', 0,
                                'hasArrow', true,
                                'value', v,
                                'notCheckable', true
                            )
                        end
                    end
                end
                AtlasLoot_Dewdrop:AddLine(
					'text', AL["Close Menu"],
                    'textR', 0,
                    'textG', 1,
                    'textB', 1,
					'func', function() AtlasLoot_Dewdrop:Close() end,
					'notCheckable', true
				)
			end
		end,
		'dontHook', true
	)
end

--[[
AtlasLoot_SetNewStyle:
Create the new Default Frame style
	style = "new"
	style = "old"
]]
function AtlasLoot_SetNewStyle(style)

	local buttons = {
		"AtlasLootDefaultFrame_Options",
		"AtlasLootDefaultFrame_LoadModules",
		"AtlasLootDefaultFrame_Menu",
		"AtlasLootDefaultFrame_SubMenu",
		"AtlasLootDefaultFrame_Preset1",
		"AtlasLootDefaultFrame_Preset2",
		"AtlasLootDefaultFrame_Preset3",
		"AtlasLootDefaultFrame_Preset4",
		"AtlasLootDefaultFrameSearchButton",
		"AtlasLootDefaultFrameSearchClearButton",
		"AtlasLootDefaultFrameLastResultButton",
		"AtlasLootDefaultFrameWishListButton"
	}
	
	if style == "new" then
		AtlasLootDefaultFrame_LootBackground:SetBackdrop({bgFile = "Interface/AchievementFrame/UI-Achievement-StatsBackground"});
		AtlasLootDefaultFrame_LootBackground:SetBackdropColor(1,1,1,0.5)
		AtlasLootDefaultFrame:SetBackdrop({bgFile = "Interface/AchievementFrame/UI-Achievement-AchievementBackground", 
			  edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
			  edgeSize = 16, 
			  insets = { left = 4, right = 4, top = 4, bottom = 4 }});
		AtlasLootDefaultFrame:SetBackdropColor(1,1,1,0.5)
		AtlasLootDefaultFrame:SetBackdropBorderColor(1,0.675,0.125,1)
		AtlasLootDefaultFrameHeader:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Alert-Background.blp")
		AtlasLootDefaultFrameHeader:SetTexCoord(0,0.605,0,0.703)
		AtlasLootDefaultFrameHeader:SetWidth(299)
		AtlasLootDefaultFrameHeader:SetHeight(60)
		AtlasLootDefaultFrameHeader:SetPoint("TOP",AtlasLootDefaultFrame,"TOP",-3,22)

		AtlasLootDefaultFrame_Options:SetNormalTexture("Interface/AchievementFrame/UI-Achievement-Category-Background")
		AtlasLootDefaultFrame_Options:SetHeight(24)
		AtlasLootDefaultFrame_Options:SetPushedTexture("Interface/AchievementFrame/UI-Achievement-Category-Background")
		AtlasLootDefaultFrame_Options:SetHeight(24)

		local function SetButtons(path)
		   getglobal(path):SetNormalTexture("Interface/AchievementFrame/UI-Achievement-Category-Background")
		   getglobal(path):SetHeight(24)
		   getglobal(path):SetPushedTexture("Interface/AchievementFrame/UI-Achievement-Category-Background")
		   getglobal(path):SetHeight(24)
		   local tex = getglobal(path):GetNormalTexture();
		   tex:SetTexCoord(0, 0.6640625, 0, 0.8);
		   tex:SetHeight(32)
		   
		   local tex2 = getglobal(path):GetPushedTexture();
		   tex2:SetTexCoord(0, 0.6640625, 0, 0.8);
		   tex2:SetHeight(32)
		end

		for k,v in pairs(buttons) do
		   SetButtons(v)
		end
	elseif style == "old" then
	
		AtlasLootDefaultFrame_LootBackground:SetBackdrop({bgFile = ""});
		AtlasLootDefaultFrame_LootBackground:SetBackdropColor(0,0,0.5,0.5)	
		
		AtlasLootDefaultFrame:SetBackdrop({bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
			  edgeFile = "Interface/DialogFrame/UI-DialogBox-Border", 
			  edgeSize = 32, 
			  insets = { left = 11, right = 12, top = 12, bottom = 11 }});
		AtlasLootDefaultFrame:SetBackdropColor(1,1,1,1)
		AtlasLootDefaultFrame:SetBackdropBorderColor(1,1,1,1)
		
		
		AtlasLootDefaultFrameHeader:SetTexture("Interface/DialogFrame/UI-DialogBox-Header")
		AtlasLootDefaultFrameHeader:SetTexCoord(0,1,0,1)
		AtlasLootDefaultFrameHeader:SetWidth(425)
		AtlasLootDefaultFrameHeader:SetHeight(64)
		AtlasLootDefaultFrameHeader:SetPoint("TOP",AtlasLootDefaultFrame,"TOP",0,12)

		AtlasLootDefaultFrame_Options:SetNormalTexture("Interface/Buttons/UI-Panel-Button-Up")
		AtlasLootDefaultFrame_Options:SetHeight(20)
		AtlasLootDefaultFrame_Options:SetPushedTexture("Interface/Buttons/UI-Panel-Button-Down")
		AtlasLootDefaultFrame_Options:SetHeight(20)

		local function SetButtons(path)
		   getglobal(path):SetNormalTexture("Interface/Buttons/UI-Panel-Button-Up")
		   getglobal(path):SetHeight(20)
		   getglobal(path):SetPushedTexture("Interface/Buttons/UI-Panel-Button-Down")
		   getglobal(path):SetHeight(20)
		   local tex = getglobal(path):GetNormalTexture();
		   tex:SetTexCoord(0, 0.625, 0, 0.6875);
		   tex:SetHeight(20)
		   
		   local tex2 = getglobal(path):GetPushedTexture();
		   tex2:SetTexCoord(0, 0.625, 0, 0.6875);
		   tex2:SetHeight(20)
		end

		for k,v in pairs(buttons) do
		   SetButtons(v)
		end
		
	end
end
