--imports
local WIM = WIM;
local _G = _G;
local CreateFrame = CreateFrame;
local unpack = unpack;
local tostring = tostring;
local type = type;
local table = table;
local pairs = pairs;
local tonumber = tonumber;

--set namespace
setfenv(1, WIM);

--[[
    To create an option frame, invoke WIM.options.CreateOptionsFrame() returns Frame
    Available Tools:
    - frame:CreateSection(title[, description]) returns Frame
    - frame:SetFullSize()
    - frame:CreateText(inherritFrom[, fontHeight]) returns FontString
    - frame:ImportCustomObject(theObject) returns theObject
    - frame:CreateFramedPanel() returns Frame
    - CreateCheckButton(parent, title, dbTree, varName, tooltip, valChanged) returns CheckButton
    - CreateCheckButtonMenu(parent, title, dbTree, varName, tooltip, valChanged, itemList, dbTree2, varName2, valChanged2) returns CheckButton
    - CreateSlider(parent, title, minText, maxText, min, max, step, dbTree, varName, valChanged) returns Slider
    - CreateColorPicker(parent, title, dbTree, varName, valChanged) returns Frame
    - CreateButton(parent, title, fun) returns Button
    
    Frame Modifying Tools:
    - WIM.options.AddFramedBackdrop(theFrame)
]]

local DefaultFont = "ChatFontNormal";
local TitleColor = {_G.GameFontNormal:GetTextColor()};
local DisabledColor = {.5, .5, .5};

local ObjectStats = {};


local function statObject(str)
    ObjectStats[str] = ObjectStats[str] or 0;
    ObjectStats[str] = ObjectStats[str] + 1;
    return str..ObjectStats[str];
end

local function SetNextAnchor(obj)
    local parent = obj:GetParent();
    local relativePoint = parent.lastObj;
    --obj:ClearAllPoints();
    if(relativePoint) then
        obj:SetPoint("TOPLEFT", relativePoint, "BOTTOMLEFT", parent.nextOffSetX or 0, parent.nextOffSetY or 0);
    else
        obj:SetPoint("TOPLEFT", parent.nextOffSetX or 0, parent.nextOffSetY or 0);
    end
    parent.nextOffsetX, parent.nextOffSetY = 0, 0;
    parent.lastObj = obj;
end

local function SetFullSize(self)
    self:SetPoint("LEFT");
    self:SetPoint("RIGHT");
end

local function CreateButton(parent, text, fun)
    local button = CreateFrame("Button", parent:GetName()..statObject("Button"), parent, "UIPanelButtonTemplate2");
    button.text = _G[button:GetName().."Text"];
    button.text:SetText(text);
    button:SetWidth(button.text:GetStringWidth()+40);
    button:SetScript("OnClick", fun);
    SetNextAnchor(button);
    return button;
end

local function CreateColorPicker(parent, title, dbTree, varName, valChanged)
    local frame = CreateFrame("Frame", parent:GetName()..statObject("ColorPicker"), parent);
    frame:SetWidth(22); frame:SetHeight(22);
    frame.swatch = CreateFrame("Button", frame:GetName().."Swatch", frame);
    frame.swatch:SetWidth(20); frame.swatch:SetHeight(20);
    frame.swatch:SetPoint("LEFT");
    frame.swatch.bg = frame.swatch:CreateTexture(frame.swatch:GetName().."Bg", "BACKGROUND");
    frame.swatch.bg:SetWidth(18); frame.swatch.bg:SetHeight(18);
    frame.swatch.bg:SetPoint("CENTER");
    frame.swatch.bg:SetTexture(1, 1, 1);
    frame.swatch:SetNormalTexture("Interface\\ChatFrame\\ChatFrameColorSwatch");
    frame.swatch:SetScript("OnEnter", function(self)
            self.bg:SetVertexColor(_G.NORMAL_FONT_COLOR.r, _G.NORMAL_FONT_COLOR.g, _G.NORMAL_FONT_COLOR.b);
        end);
    frame.swatch:SetScript("OnLeave", function(self)
            self.bg:SetVertexColor(_G.HIGHLIGHT_FONT_COLOR.r, _G.HIGHLIGHT_FONT_COLOR.g, _G.HIGHLIGHT_FONT_COLOR.b);
        end);
    frame.swatch:SetScript("OnClick", function(self, button)
            _G.ColorPickerFrame.hasOpacity = false;
            _G.ColorPickerFrame.func = function()
                    local r,g,b = _G.ColorPickerFrame:GetColorRGB();
                    dbTree[varName].r = r;
                    dbTree[varName].g = g;
                    dbTree[varName].b = b;
                    self:Hide();
                    self:Show();
                    options.frame:Enable();
                end
            _G.ColorPickerFrame.prev = {dbTree[varName].r, dbTree[varName].g, dbTree[varName].b};
            _G.ColorPickerFrame:SetColorRGB(dbTree[varName].r, dbTree[varName].g, dbTree[varName].b);
            _G.ColorPickerFrame.cancelFunc = function()
                    dbTree[varName].r = _G.ColorPickerFrame.prev[1];
                    dbTree[varName].g = _G.ColorPickerFrame.prev[2];
                    dbTree[varName].b = _G.ColorPickerFrame.prev[3];
                    self:Hide();
                    self:Show();
                    options.frame:Enable();
                end
            _G.ColorPickerFrame:SetFrameStrata("DIALOG");
            _G.ColorPickerFrame:Show();
            options.frame:Disable();
        end);
    frame.swatch:SetScript("OnShow", function(self)
            self:GetNormalTexture():SetVertexColor(dbTree[varName].r, dbTree[varName].g, dbTree[varName].b);
        end);
    frame.swatch.title = frame.swatch:CreateFontString(frame.swatch:GetName().."Text", "OVERLAY", DefaultFont);
    frame.swatch.title:SetPoint("LEFT", frame.swatch, "RIGHT", 10, 0);
    frame.swatch.title:SetText(title);
    SetNextAnchor(frame);
    return frame;
end


local function CreateSlider(parent, title, minText, maxText, min, max, step, dbTree, varName, valChanged)
    local s = CreateFrame("Slider", parent:GetName()..statObject("Slider"), parent);
    -- set backdrop
    s:SetBackdrop({bgFile = "Interface\\Buttons\\UI-SliderBar-Background", 
        edgeFile = "Interface\\Buttons\\UI-SliderBar-Border", 
        tile = true, tileSize = 8, edgeSize = 8, 
        insets = { left = 3, right = 3, top = 6, bottom = 6 }});
    s:SetHeight(17);
    s:SetPoint("LEFT");
    s:SetPoint("RIGHT", -75, 0);
    s:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal");
    s:SetOrientation("HORIZONTAL");
    s:SetMinMaxValues(min, max);
    s.title = s:CreateFontString(s:GetName().."Title", "OVERLAY", DefaultFont);
    s.title:SetPoint("BOTTOMLEFT", s, "TOPLEFT", 0, 5);
    s.title:SetText(title);
    s.minText = s:CreateFontString(s:GetName().."Min", "OVERLAY", "ChatFontSmall");
    s.minText:SetPoint("TOPLEFT", s, "BOTTOMLEFT", 5, 0);
    s.minText:SetText(minText);
    s.maxText = s:CreateFontString(s:GetName().."Max", "OVERLAY", "ChatFontSmall");
    s.maxText:SetPoint("TOPRIGHT", s, "BOTTOMRIGHT", -5, 0);
    s.maxText:SetText(maxText);
    s.valText = s:CreateFontString(s:GetName().."Val", "OVERLAY", "ChatFontSmall");
    s.valText:SetPoint("LEFT", s, "RIGHT", 15, 2);
    s.valText:SetTextColor(unpack(TitleColor));
    s.valText:SetText("");
    s:SetValueStep(step);
    s:SetScript("OnValueChanged", function(self)
            self.valText:SetText(self:GetValue());
            dbTree[varName] = self:GetValue();
            if(type(valChanged) == "function") then
                valChanged(self, self:GetValue());
            end
        end);
    s:SetScript("OnShow", function(self)
            self:SetValue(tonumber(dbTree[varName]));
        end);
        
    SetNextAnchor(s);
    return s;
end


local function CreateDropDownMenu(parent, dbTree, varName, itemList, width)
    local menu = CreateFrame("Frame", parent:GetName()..statObject("DropDownMenu"), parent, "UIDropDownMenuTemplate");
    menu:EnableMouse(true);
    if(width) then
        _G.UIDropDownMenu_SetWidth(menu, width);
    end
    menu.itemList = itemList or {};
    menu.init = function()
            for i=1, #menu.itemList do
                if(not menu.itemList[i].hooked) then
                    local func = menu.itemList[i].func or function(self) end;
                    menu.itemList[i].func = function(self, arg1, arg2)
                        self = self or _G.this; -- wotlk/tbc hack
                        dbTree[varName] = self.value;
                        _G.UIDropDownMenu_SetSelectedValue(menu, self.value);
                        func(self, arg1, arg2);
                    end
                    menu.itemList[i].hooked = true;
                end
                local info = _G.UIDropDownMenu_CreateInfo();
                for k,v in pairs(menu.itemList[i]) do
                    info[k] = v;
                end
                _G.UIDropDownMenu_AddButton(info, _G.UIDROPDOWNMENU_MENU_LEVEL);
            end
        end
    menu:SetScript("OnShow", function(self)
            _G.UIDropDownMenu_Initialize(self, self.init);
            _G.UIDropDownMenu_SetSelectedValue(self, dbTree[varName]);
        end);
    menu.SetValue = function(self, value)
            _G.UIDropDownMenu_SetSelectedValue(self, value);
        end;
    SetNextAnchor(menu);
    menu:Hide(); menu:Show();
    return menu;
end

local function CreateCheckButton(parent, title, dbTree, varName, tooltip, valChanged)
    local cb = CreateFrame("CheckButton", parent:GetName()..statObject("CheckButton"), parent, "UICheckButtonTemplate");
    cb.text = _G.getglobal(cb:GetName().."Text");
    cb.children = {};
    cb.isCheckButton = true;
    cb.disabledByParent = nil; -- used to track enable and disables.
    cb.CreateCheckButton = CreateCheckButton;
    cb._Disable = cb.Disable;
    cb._Enable = cb.Enable;
    cb.text:SetText("  "..tostring(title));
    cb.text:SetFontObject(DefaultFont);
    cb:SetScript("OnShow", function(self)
            local dbTbl = dbTree;
            if(type(dbTree) == "function") then
                dbTbl = dbTree();
            end
            self:SetChecked(dbTbl[varName]);
            self:UpdateChildren();
        end);
    cb:SetScript("OnClick", function(self, button)
            _G.PlaySound("igMainMenuOptionCheckBoxOn");
            for i=1, #self.children do
                if(self:GetChecked()) then
                    self.children[i]:Enable(self);
                else
                    self.children[i]:Disable(self);
                end
            end
            local dbTbl = dbTree;
            if(type(dbTree) == "function") then
                dbTbl = dbTree();
            end
            dbTbl[varName] = self:GetChecked() and true or false;
            if(type(valChanged) == "function") then
                valChanged(self, button);
            end
        end);
    cb.Enable = function(self, enabler)
            enabler = _enabler or self;
            for i=1, #self.children do
                if(not self.children[i]:IsEnabled() and self.children[i].disabledByParent == enabler) then
                    self.children[i]:Enable(enabler);
                end
            end
            self:UpdateChildren();
            self.disabledByParent = nil;
            self.text:SetTextColor(1, 1, 1);
            self:_Enable();
        end
    cb.Disable = function(self, disabler)
            disabler = disabler or self;
            for i=1, #self.children do
                if(self.children[i]:IsEnabled()) then
                    --self.children[i]:UpdateChildren();
                    self.children[i]:Disable(disabler);
                end
            end
            self.disabledByParent = disabler;
            self.text:SetTextColor(unpack(DisabledColor));
            self:_Disable();
        end
    cb.UpdateChildren = function(self)
            for i=1, #self.children do
                if(self:GetChecked()) then
                    self.children[i].text:SetTextColor(1, 1, 1);
                    self.children[i]:_Enable(self);
                else
                    self.children[i].text:SetTextColor(unpack(DisabledColor));
                    self.children[i]:Disable(self);
                end
            end
        end
        
    if(parent.isCheckButton) then
        cb:SetScale(.90);
        if(#parent.children == 0) then
            parent.nextOffSetX = parent:GetWidth();
            parent.nextOffSetY = -parent:GetHeight();
        else
            parent.nextOffSetX = nil;
            parent.nextOffSetY = nil;
        end
        table.insert(parent.children, cb);
    end
    SetNextAnchor(cb);
    return cb;
end

local function CreateCheckButtonMenu(parent, title, dbTree, varName, tooltip, valChanged, itemList, dbTree2, varName2, valChanged2)
    local cbm = CreateCheckButton(parent, title, dbTree, varName, tooltip, valChanged);
    cbm.CreateCheckButtonMenu = CreateCheckButtonMenu;
    cbm.menu = CreateFrame("Button", cbm:GetName().."MenuButton", cbm);
    cbm.menu:SetWidth(26); cbm.menu:SetHeight(cbm.menu:GetWidth());
    cbm.menu:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up");
    cbm.menu:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down");
    cbm.menu:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled");
    cbm.menu:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD");
    cbm.menu:SetPoint("LEFT", cbm:GetWidth()-2, 0);
    cbm.menu.itemList = itemList;
    cbm.menu.dropdown = options.createDropDownFrame();
    
    cbm.text:ClearAllPoints(); cbm.text:SetPoint("LEFT", cbm.menu, "RIGHT");
    -- some hooks to enherit disabled functionality.
    local Enable, Disable = cbm.Enable, cbm.Disable;
    cbm.Enable = function(...) cbm.menu:Enable(); Enable(...); end
    cbm.Disable = function(...) cbm.menu:Disable();  Disable(...); end
    
    local function clickFunc(self, ...)
        dbTree2[varName2] = self.value;
    end
    
    -- now the menu work...
    cbm.menu:SetScript("OnClick", function(self, button)
            _G.PlaySound("igChatScrollDown");
            self.dropdown:SetItemList(self.itemList, dbTree2[varName2], clickFunc);
            self.dropdown:ToggleDropDownMenu(self, "TOPLEFT", "BOTTOMLEFT", 0, 0);
        end);
    return cbm;
end

local function CreateText(parent, inherritFrom, fontHeight)
    inherritFrom = inherritFrom or DefaultFont;
    local fs = parent:CreateFontString(parent:GetName()..statObject("FontString"), "OVERLAY", inherritFrom);
    fs:Show();
    if(fontHeight) then
        local font, _, flags = fs:GetFont();
        fs:SetFont(font, fontHeight, flags);
    end
    fs.SetFullSize = SetFullSize;
    SetNextAnchor(fs);
    return fs;
end

local function CreateSection(parent, title, desc)
    local frame = options.CreateOptionsFrame();
    frame:SetParent(parent);
    frame:Show();
    frame:SetFullSize();
    if(title) then
        frame.title = frame:CreateText(nil, 18);
        frame.title:SetText(title);
        frame.title:SetTextColor(unpack(TitleColor));
        frame.title:SetFullSize();
        frame.title:SetJustifyH("LEFT");
        frame.title:SetPoint("TOPLEFT");
        frame.nextOffSetY = -4;
    end
    if(desc) then
        frame.description = frame:CreateText();
        frame.description:SetText(desc);
        frame.description:SetFullSize();
        frame.description:SetJustifyH("LEFT");
        frame.description:SetJustifyV("TOP");
        frame:SetScript("OnUpdate", function(self, elapsed)
                if(frame:GetWidth() < self.description:GetStringWidth()) then
                    self.description:SetHeight(self.description:GetStringWidth()/parent:GetWidth()*(self.description:GetStringHeight()+
                                    self.description:GetSpacing()) + (self.description:GetStringHeight()+self.description:GetSpacing()));
                end
                frame:Hide();
                frame:Show();
                self:SetScript("OnUpdate", nil);
            end);
    end
    frame:SetScript("OnShow", function(self)
            if(self.lastObj) then
                self:SetHeight(self:GetTop()-self.lastObj:GetBottom());
            end
        end);
    SetNextAnchor(frame);
    return frame;
end

local function CreateFramedPanel(parent)
    local frame = CreateSection(parent, nil, nil);
    options.AddFramedBackdrop(frame);
    return frame;
end

local function ImportCustomObject(parent, obj)
    statObject("CustomObj");
    obj:SetParent(parent);
    options.InherritOptionFrameProperties(obj);
    SetNextAnchor(obj);
    return obj;
end

function options.InherritOptionFrameProperties(obj)
    obj.CreateSection = CreateSection;
    obj.CreateText = CreateText;
    obj.SetFullSize = SetFullSize;
    obj.CreateCheckButton = CreateCheckButton;
    obj.ImportCustomObject = ImportCustomObject;
    obj.CreateFramedPanel = CreateFramedPanel;
    obj.CreateDropDownMenu = CreateDropDownMenu;
    obj.CreateCheckButtonMenu = CreateCheckButtonMenu;
    obj.CreateSlider = CreateSlider;
    obj.CreateColorPicker = CreateColorPicker;
    obj.CreateButton = CreateButton;
end

-- Global usage for modules
function options.CreateOptionsFrame()
    local frame = CreateFrame("Frame", "WIM3_OptionFrame"..statObject("Frame"));
    frame:Hide();
    -- declare the following tools.
    options.InherritOptionFrameProperties(frame);
    return frame;
end

function options.AddFramedBackdrop(obj)
    obj.backdrop = {};
    obj.backdrop.top = obj:CreateTexture(nil, "BACKGROUND");
    obj.backdrop.top:SetTexture(1, 1, 1, .25);
    obj.backdrop.top:SetPoint("TOPLEFT",-1 , 1);
    obj.backdrop.top:SetPoint("TOPRIGHT",1 , 1);
    obj.backdrop.top:SetHeight(1);
    obj.backdrop.bottom = obj:CreateTexture(nil, "BACKGROUND");
    obj.backdrop.bottom:SetTexture(1, 1, 1, .25);
    obj.backdrop.bottom:SetPoint("BOTTOMLEFT",-1 , -1);
    obj.backdrop.bottom:SetPoint("BOTTOMRIGHT",1 , -1);
    obj.backdrop.bottom:SetHeight(1);
    obj.backdrop.left = obj:CreateTexture(nil, "BACKGROUND");
    obj.backdrop.left:SetTexture(1, 1, 1, .25);
    obj.backdrop.left:SetPoint("TOPLEFT", obj.backdrop.top, "BOTTOMLEFT" ,0 , 0);
    obj.backdrop.left:SetPoint("BOTTOMLEFT", obj.backdrop.bottom, "TOPLEFT" ,0 , 0);
    obj.backdrop.left:SetWidth(1);
    obj.backdrop.right = obj:CreateTexture(nil, "BACKGROUND");
    obj.backdrop.right:SetTexture(1, 1, 1, .25);
    obj.backdrop.right:SetPoint("TOPRIGHT", obj.backdrop.top, "BOTTOMRIGHT" ,0 , 0);
    obj.backdrop.right:SetPoint("BOTTOMRIGHT", obj.backdrop.bottom, "TOPRIGHT" ,0 , 0);
    obj.backdrop.right:SetWidth(1);
    obj.backdrop.bg = obj:CreateTexture(nil, "BACKGROUND");
    obj.backdrop.bg:SetTexture(0, 0, 0, .25);
    obj.backdrop.bg:SetAllPoints();
end



--[[
Textures:
Buttons/UI-SliderBar-Button-Horizontal.blp - scroll thumb

]]

-- Prototype for scrollable menu. Must be toggled by whatever object it is bound to.

local dropDownFrame;
local dropDownButtonCount = 11;

local buttonProps = {"func", "owner", "keepShownOnClick", "tooltipTitle", "tooltipText", "arg1", "arg2", "notCheckable", "value"};
local function clearButton(self)
    for i=1, #buttonProps do
        self[buttonProps[i]] = nil;
    end
end

local function clearButtons(self)
    for i=1, #self.buttons do
        self.buttons[i]:ClearButton();
    end
end

local function setButton(self, info)
    self:ClearButton();
    local invisibleButton = _G[self:GetName().."InvisibleButton"];
    local normalText = _G[self:GetName().."NormalText"];
    
    -- set default values
    self:Enable();
    self:SetDisabledFontObject(_G.GameFontDisableSmallLeft);
    invisibleButton:Hide();
    
    -- If not clickable then disable the button and set it white
	if ( info.notClickable ) then
		info.disabled = 1;
		self:SetDisabledFontObject(_G.GameFontHighlightSmallLeft);
	end
        
    -- Set the text color and disable it if its a title
	if ( info.isTitle ) then
		info.disabled = 1;
		self:SetDisabledFontObject(_G.GameFontNormalSmallLeft);
	end
        
    -- Disable the button if disabled and turn off the color code
	if ( info.disabled ) then
		self:Disable();
		invisibleButton:Show();
		info.colorCode = nil;
	end
    
    self:SetText(info.text or "");

    -- Pass through attributes
	self.func = info.func;
	self.owner = info.owner;
	self.keepShownOnClick = info.keepShownOnClick;
	self.tooltipTitle = info.tooltipTitle;
	self.tooltipText = info.tooltipText;
	self.arg1 = info.arg1;
	self.arg2 = info.arg2;
	self.notCheckable = info.notCheckable;

        if ( info.value ) then
		self.value = info.value;
	elseif ( info.text ) then
		self.value = info.text;
	else
		self.value = nil;
	end
        
        local checked = info.checked;
        
        -- If not checkable move everything over to the left to fill in the gap where the check would be
	normalText:ClearAllPoints();
	if ( info.notCheckable ) then
		if ( info.justifyH and info.justifyH == "CENTER" ) then
			normalText:SetPoint("CENTER", self, "CENTER", -7, 0);
		else
			normalText:SetPoint("LEFT", self, "LEFT", 0, 0);
		end
	else
		normalText:SetPoint("LEFT", self, "LEFT", 20, 0);
                if(self.value and self:GetParent().value == self.value) then
                    checked = true;
                end
	end
        
    -- Checked can be a function now
	if ( type(checked) == "function" ) then
		checked = checked();
	end

	-- Show the check if checked
	if ( checked ) then
		self:LockHighlight();
		_G.getglobal(self:GetName().."Check"):Show();
	else
		self:UnlockHighlight();
		_G.getglobal(self:GetName().."Check"):Hide();
	end
	self.checked = info.checked;
end

local function DropDown_OnMouseWheel(self, delta)
    local scroll = self.scroll or self:GetParent().scroll or self:GetParent():GetParent().scroll;
    if(scroll and scroll:IsShown()) then
        local min, max = scroll:GetMinMaxValues();
        local newVal = _G.math.floor(scroll:GetValue()) - delta;
        if(newVal >= min and newVal <= max) then
            scroll:SetValue(newVal);
        end
    end
end

function options.createDropDownFrame()
    if(dropDownFrame) then
        -- don't create more than once.
        return dropDownFrame;
    end
    local f = CreateFrame("Button", "WIM_DropDownFrame", _G.UIParent);
    f:Hide();
    f:SetFrameStrata("TOOLTIP");
    f:SetPoint("CENTER");
    f:SetWidth(100);
    f:SetHeight(300);
    f:EnableMouseWheel(1);
    f:SetBackdrop( { 
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, 
        insets = { left = 5, right = 5, top = 5, bottom = 5 }
    });
    f:SetBackdropBorderColor(_G.TOOLTIP_DEFAULT_COLOR.r, _G.TOOLTIP_DEFAULT_COLOR.g, _G.TOOLTIP_DEFAULT_COLOR.b);
    f:SetBackdropColor(_G.TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, _G.TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, _G.TOOLTIP_DEFAULT_BACKGROUND_COLOR.b);
    
    f.testString = f:CreateFontString(f:GetName().."TestString", "OVERLAY", "GameFontNormalSmallLeft");
    f.testString:SetPoint("TOPLEFT");
    f.testString:Hide();
    
    --create scroll bar
    f.scroll = CreateFrame("Slider", f:GetName().."Slider", f);
    f.scroll.bg = f.scroll:CreateTexture(nil, "BACKGROUND");
    f.scroll.bg:SetPoint("TOP", 0, -15);
    f.scroll.bg:SetPoint("BOTTOM", 0, 15);
    f.scroll.bg:SetWidth(2);
    f.scroll.bg:SetTexture(1, 1, 1, .10);
    f.scroll:SetOrientation("VERTICAL");
    f.scroll:SetPoint("TOPRIGHT", -8, 0);
    f.scroll:SetPoint("BOTTOM", 0 ,0);
    f.scroll:SetWidth(5);
    f.scroll:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal");
    f.scroll:SetMinMaxValues(0, 10);
    f.scroll:SetValue(5);
    f.scroll:EnableMouseWheel(1);
    f.scroll:SetScript("OnEnter", function(self) _G.UIDropDownMenu_StopCounting(self:GetParent()) end);
    f.scroll:SetScript("OnLeave", function(self) _G.UIDropDownMenu_StartCounting(self:GetParent()) end);
    f.scroll:SetScript("OnMouseWheel", DropDown_OnMouseWheel);
    f.scroll:SetScript("OnValueChanged", function(self)
        self:GetParent():Refresh();
    end);
    
    -- create buttons
    f.buttons = {};
    for i=1, dropDownButtonCount do
        local button = CreateFrame("Button", f.scroll:GetName().."Button"..i, f, "UIDropDownMenuButtonTemplate");
        button.ClearButton = clearButton;
        button.SetButton = setButton;
        table.insert(f.buttons, button);
        if(i==1) then
            button:SetPoint("TOPLEFT", 9, -9);
            button:SetPoint("RIGHT", f.scroll, "LEFT", -2, 0);
        else
            button:SetPoint("TOPLEFT", f.buttons[i-1], "BOTTOMLEFT");
            button:SetPoint("TOPRIGHT", f.buttons[i-1], "BOTTOMRIGHT");
        end
        button:EnableMouseWheel(1);
        button:SetScript("OnMouseWheel", DropDown_OnMouseWheel);
        button:HookScript("OnClick", function(self, ...)
            local func = self:GetParent().clickFunc;
            if(func) then
                func(self, ...);
            end
        end);
    end
    
    -- actions
    f.ClearButtons = clearButtons;
    -- this call is made to reconfigure buttons.
    f.Refresh = function(self)
        local offset = _G.math.floor(self.scroll:GetValue()) or 0;
        for i=1, (self.buttonsShown or 0) do
            self.buttons[i]:SetButton(self.list[i+offset]);
        end
    end
    -- this call is made when toggling. supplying fresh list.
    f.SetItemList = function(self, list, val, additionalClickFunc)
        self.value = val;
        self.clickFunc = additionalClickFunc;
        self:ClearButtons();
        self.list = list;
        if(#self.list > #self.buttons) then
            self.scroll:Show();
            self.scroll:SetValue(0);
            self.scroll:SetMinMaxValues(0, _G.math.max(#self.list - #self.buttons, 1));
            self.scroll:SetWidth(5);
            -- add code to jump to selected offset.
        else
            self.scroll:SetValue(0);
            self.scroll:Hide();
            self.scroll:SetWidth(1);
        end
        -- set appropriate height
        self.buttonsShown = _G.math.min(#self.list, #self.buttons);
        self:SetHeight((self.buttonsShown * self.buttons[1]:GetHeight()) + 18);
        
        -- set appropriate width
        local maxWidth, tIndex = 20;
        for index, tbl in pairs(self.list) do
            self.testString:SetText(tbl.text or "");
            maxWidth = _G.math.max(maxWidth, (self.testString:GetWidth() or 0) + (not tbl.notCheckable and 30 or 0));
            tIndex = self.value == tbl.value and index or tIndex;
        end
        self:SetWidth(maxWidth + self.scroll:GetWidth() + 25)
        if(self.scroll:IsShown() and tIndex and tIndex > self.buttonsShown) then
            self.scroll:SetValue(tIndex - self.buttonsShown);
        end
        -- set up button visiblity;
        for i=1, #self.buttons do
            if i > self.buttonsShown then
                self.buttons[i]:Hide();
            else
                self.buttons[i]:Show();
            end
        end
        
        self:Refresh();
        return self; -- allow for Chained actions;
    end
    
    f.ToggleDropDownMenu = function(self, parent, point, relativePoint, xOffset, yOffset)
        if(f.prevParent == parent) then
            f.prevParent = nil;
            f:Hide();
            return;
        end
        self:SetParent(parent);
        point = point or "TOPLEFT";
        relativePoint = relativePoint or "BOTTOMLEFT";
        if( not xOffset and not yOffset ) then
            xOffset = 8;
            yOffset = -22;
        end
        xOffset = xOffset or 0;
        yOffset = yOffset or 0;
        self:ClearAllPoints();
        self:SetPoint(point, parent, relativePoint, xOffset, yOffset);
        f.prevParent = parent;
        f:Show();
    end
    
    f:SetScript("OnClick", function(self) self:Hide(); end);
    f:SetScript("OnEnter", _G.UIDropDownMenu_StopCounting);
    f:SetScript("OnLeave", _G.UIDropDownMenu_StartCounting);
    f:SetScript("OnUpdate", _G.UIDropDownMenu_OnUpdate);
    f:SetScript("OnHide", function(self)
        _G.UIDropDownMenu_OnHide(self);
        self.prevParent = nil;
    end);
    f:SetScript("OnMouseWheel", DropDown_OnMouseWheel);
    
    dropDownFrame = f;
    return f;
end
