local WIM = WIM;

-- imports
local _G = _G;
local table = table;
local string = string;
local pairs = pairs;
local type = type;
local UIDropDownMenu_AddButton = UIDropDownMenu_AddButton;
local UIDropDownMenu_CreateInfo = UIDropDownMenu_CreateInfo
local UIDropDownMenu_Initialize = UIDropDownMenu_Initialize;
local ToggleDropDownMenu = ToggleDropDownMenu;

-- set namespace
setfenv(1, WIM);

local menuFrame = _G.CreateFrame("Frame", "WIM3_ContextMenu", _G.UIParent, "UIDropDownMenuTemplate");
menuFrame:SetPoint("TOP", -80, -200);
menuFrame:Hide();

 ctxMenu = {};

local MENU_ID = 0;

local CurMenu;

local function getMenuByTitle(text)
    for key, val in pairs(ctxMenu) do
        if(val.text == text) then
            return key;
        end
    end
    return;
end

local function addMenuItem(tag, info)
    -- required checks
    if(type(info) ~= "table" and not info.text) then
        if(type(tag) == "table" and tag.text) then
            MENU_ID = MENU_ID + 1;
            return addMenuItem("MENU_ITEM"..MENU_ID, tag);
        else
            return;
        end
    end
    if(type(tag) ~= "string") then
        return;
    end
    if(tag == "") then
        MENU_ID = MENU_ID + 1;
        return addMenuItem("MENU_ITEM"..MENU_ID, info);
    end
    if(ctxMenu[string.upper(tag)]) then
        return ctxMenu[string.upper(tag)];
    end
    
    -- propper formatting
    tag = string.upper(tag);
    
    -- load data into its own table. we will send this back to the user later.
    local item = {};
    for key, val in pairs(info) do
        item[key] = val;
    end
    
    ctxMenu[tag] = item;
    item.MENU_ID = tag;
    
    item.AddSubItem = function(self, menuItem, insertAt)
        if(type(menuItem) == "string") then
            menuItem = ctxMenu[string.upper(menuItem)];
            if(not menuItem) then
                return;
            end
        end
        if(not (type(menuItem) == "table" and menuItem.MENU_ID)) then
            return;
        end
        
        if(not self.menuTable) then
            self.menuTable = {};
        end
        if(insertAt) then
            table.insert(self.menuTable, insertAt, menuItem.MENU_ID);
        else
            table.insert(self.menuTable, menuItem.MENU_ID);
        end
        self.hasArrow = true;
        self.value = self.MENU_ID;
        return true;
    end
    return item;
end

local function initializeMenu(frame, level, menuTable)
    level = level or _G.UIDROPDOWNMENU_MENU_LEVEL;
    if(level > 1 and _G.UIDROPDOWNMENU_MENU_VALUE) then
        CurMenu = ctxMenu[_G.UIDROPDOWNMENU_MENU_VALUE];
    end
    if(not CurMenu) then
        dPrint("ContextMenu Error - Menu not set.");
        return; -- menu not set
    end
    dPrint("Initializing Menu - level "..level);
    local items = CurMenu.menuTable;
    if(not items) then
        return;
    end
    for i=1, #items do
        local info = UIDropDownMenu_CreateInfo();
        for key, val in pairs(ctxMenu[items[i]]) do
            info[key] = val;
        end
        if(not ctxMenu[items[i]].hidden) then
            UIDropDownMenu_AddButton(info, level);
        end
    end
end


-- global API

function PopContextMenu(tag, parent)
    if(type(tag) ~= "string") then
        return;
    end
    tag = string.upper(tag);
    
    local id = ctxMenu[tag];
    if(id) then
        _G.CloseDropDownMenus();
        dPrint("Popping menu ["..tag.."]");
        CurMenu = id;
        _G.UIDROPDOWNMENU_MENU_VALUE = nil;
        if(WIM.Menu) then
            WIM.Menu:Hide();
        end
        UIDropDownMenu_Initialize(menuFrame, initializeMenu, "MENU");
        ToggleDropDownMenu(1, 1, menuFrame, parent, 0, 0);
        _G.UIDropDownMenu_SetButtonWidth(menuFrame, 25);
	_G.UIDropDownMenu_SetWidth(menuFrame, 25, 5);
        _G.PlaySound("UChatScrollButton");
    else
        dPrint("Menu ["..tag.."] not found!")
    end
end

function AddContextMenu(tag, info)
    local item = addMenuItem(tag, info)
    if(item) then
        dPrint("Menu ["..item.MENU_ID.."] registered with ContextMenu.");
    else
        dPrint("Menu failed to register with ContextMenu.")
    end
    return item;
end

function GetContextMenu(tag)
    return ctxMenu[tag or "<NIL>"];
end

