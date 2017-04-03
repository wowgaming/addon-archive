--[[
    Extends Modules by adding:
        Module:OnWindowCreated(winObj)
        Module:OnWindowDestroyed(winObj)
        Module:OnWindowPopped(winObj)
	Module:OnWindowMessageAdded(winObj, msg, r, g, b)
        Module:OnWindowShow(winObj)
        Module:OnWindowHide(winObj)
        Module:OnContainerShow()
        Module:OnContainerHide()
]]

local WIM = WIM;

-- imports
local _G = _G;
local CreateFrame = CreateFrame;
local UIFrameFadeIn = UIFrameFadeIn;
local UIFrameFadeOut = UIFrameFadeOut;
local GetMouseFocus = GetMouseFocus;
local table = table;
local string = string;
local IsShiftKeyDown = IsShiftKeyDown;
local select = select;
local pairs = pairs;
local type = type;
local unpack = unpack;
local strsub = strsub;
local time = time;

-- set namespace
setfenv(1, WIM);

-- load message window related default settings.
db_defaults.displayColors = {
		sysMsg = {
				r=1, 
				g=0.6627450980392157, 
				b=0
			},
		errorMsg = {
				r=1, 
				g=0, 
				b=0
			},
                useSkin = true,
	};
db_defaults.fontSize = 12;
db_defaults.windowAlpha = 80;
db_defaults.windowOnTop = true;
db_defaults.keepFocus = true;
db_defaults.keepFocusRested = true;
db_defaults.autoFocus = false;
db_defaults.winSize = {
		width = 333,
		height = 220,
		scale = 100,
                strata = "DIALOG"
	};
db_defaults.winLoc = {
		left =217,
		top =664
	};
db_defaults.winCascade = {
		enabled = true,
		direction = 8
	};
db_defaults.winFade = true;
db_defaults.winAnimation = true;
db_defaults.wordwrap_indent = false;
db_defaults.coloredNames = true;
db_defaults.escapeToHide = true;
db_defaults.ignoreArrowKeys = true;
db_defaults.pop_rules = {};
db_defaults.whoLookups = true;
db_defaults.hoverLinks = false;
db_defaults.tabAdvance = false;
db_defaults.clampToScreen = true;

db_defaults.formatting = {
                bracketing = {
                                enabled = true,
                                type = 1,
                },
};


WIM.lists.bracketing = {
                [1] = {
                                [1] = "[",
                                [2] = "]"
                },
                [2] = {
                                [1] = "<",
                                [2] = ">"
                },
}

local WindowSoupBowl = {
    windowToken = 0,
    available = 0,
    used = 0,
    windows = {
    }
}

local FadeProps = {
	min = .5,
	max = 1,
	interval = .25,
	delay = 2
};

local cascadeDirection = {
        {0, 25},        -- Up
        {0, -25},       -- Down
        {-50, 0},       -- Left
        {50, 0},        -- Right
        {-50, 25},      -- Up & Left
        {50, 25},       -- Up & Right
        {-50, -25},     -- Down & Left
        {50, -25},      -- Down & Right
};

windowsByAge = {};

nextColor = {}; 

local FormattingCallsList = {}; -- used to get a list of available Formattings.
local FormattingCalls = {}; -- functions which are passed events to be formatted. Only one may be used at once.
	
local StringModifiers = {}; -- registered functions which will be used to format the message part of the string.


--Window's Parent (Container for all Windows)
WindowParent = _G.CreateFrame("Frame", "WIM_UIParent", _G.UIParent);
                WindowParent:SetFrameStrata("BACKGROUND");
                WindowParent:SetPoint("BOTTOMLEFT", _G.UIParent, "BOTTOMLEFT", 0, 0);
                WindowParent:SetScript("OnShow", function(self)
                                WindowParent:SetWidth(_G.UIParent:GetWidth());
                                WindowParent:SetHeight(_G.UIParent:GetHeight());
                end);
                --WindowParent.test = WindowParent:CreateTexture("BACKGROUND");
                --WindowParent.test:SetTexture(1,1,1,.5)
                --WindowParent.test:SetAllPoints();
                WindowParent:Hide();


-- the following table defines a list of actions to be taken when
-- script handlers are fired for different type windows.
-- use WIM:RegisterWidgetTrigger(WindowType, ScriptEvent, function());
local Widget_Triggers = {};

local function getFormatByName(format)
	local i;
	for i=1, #FormattingCalls do
		if(FormattingCalls[i].name == format) then
			return FormattingCalls[i].fun;
		end
	end
	return FormattingCalls[1].fun;
end

function applyMessageFormatting(...)
	local fun = getFormatByName(db.messageFormat);
	return fun(...);
end


function applyStringModifiers(str, chatDisplay)
	for i=1, #StringModifiers do
		str = StringModifiers[i](str, chatDisplay);
	end
        chatDisplay.noEscapedStrings = nil;
	return str;
end


local RegisteredWidgets = {}; -- a list of registered widgets added to windows from modules.
windows.widgets = RegisteredWidgets;

--[[ Sample Widget with triggers
RegisteredWidgets["Test"] = function(parentWindow)
	_G.DEFAULT_CHAT_FRAME:AddMessage("Test Widget created!");
	local t = CreateFrame("Frame");
	t.SetDefaults = function()
			_G.DEFAULT_CHAT_FRAME:AddMessage("Test Widget defaults set!");
		end
	t.UpdateProps = function()
			_G.DEFAULT_CHAT_FRAME:AddMessage("Test Widget props updated!");
		end
	return t;
end
]]

local windowListByLevel_Recycle = {};
local function getActiveWindowListByLevel()
	-- first remove items from previously used list.
	local i;
	for i=1,#windowListByLevel_Recycle do
		table.remove(windowListByLevel_Recycle, 1);
	end
	-- load all used windows into table
	for i=1, #WindowSoupBowl.windows do
		if(WindowSoupBowl.windows[i].inUse and WindowSoupBowl.windows[i].obj:IsVisible()) then
			table.insert(windowListByLevel_Recycle, WindowSoupBowl.windows[i].obj);
		end
	end
	table.sort(windowListByLevel_Recycle, function(a,b)
		a, b = a:GetFrameLevel(), b:GetFrameLevel();
		return a>b;
	end);
	return windowListByLevel_Recycle;
end

function getWindowAtCursorPosition(excludeObj)
	-- can optionaly exclude an object
	local x,y = _G.GetCursorPosition();
	local windows = getActiveWindowListByLevel();
	local i;
	for i=1,#windows do
		if(excludeObj ~= windows[i]) then
			local x1, y1 = windows[i]:GetLeft()*windows[i]:GetEffectiveScale(), windows[i]:GetTop()*windows[i]:GetEffectiveScale();
			local x2, y2 = x1 + windows[i]:GetWidth()*windows[i]:GetEffectiveScale(), y1 - windows[i]:GetHeight()*windows[i]:GetEffectiveScale();
			if(x >= x1 and x <= x2 and y <= y1 and y >= y2) then
				return windows[i];
			end
		end
	end
	return nil;
end

-- window resizing helper
local resizeFrame = CreateFrame("Button", "WIM_WindowResizeFrame", WindowParent);
resizeFrame:Hide();
resizeFrame.widgetName = "resize";
resizeFrame:SetFrameStrata("TOOLTIP");
resizeFrame.Attach = function(self, win)
		if(win.widgets.close ~= GetMouseFocus() and win.type ~= "demo") then
			self:SetParent(win);
			self.parentWindow = win;
			ApplySkinToWidget(self);
			self:Show();
			--resizeFrame:SetFrameLevel(999);
		else
                        self:Reset();
			resizeFrame:Hide();
		end
	end
resizeFrame.Reset = function(self)
		self:SetParent(WindowParent);
		self:ClearAllPoints();
		self:SetPoint("TOPLEFT");
		self:Hide();
	end
resizeFrame:SetScript("OnMouseDown", function(self)
		self.isSizing = true;
                self.parentWindow.customSize = true;
		self.parentWindow:SetResizable(true);
		self.parentWindow:StartSizing("BOTTOMRIGHT");
	end);
resizeFrame:SetScript("OnMouseUp", function(self)
		self.isSizing = false;
                self.parentWindow.customSize = true;
		self.parentWindow:StopMovingOrSizing();
		local tabStrip = self.parentWindow.tabStrip;
		if(tabStrip) then
			dPrint("Size sent to tab strip.");
		end
                DisplayTutorial(L["Window Resized!"], L["If you want all windows to be this size, you can set the default window size within WIM's options."]);
	end);
resizeFrame:SetScript("OnHide", function(self)
                if(self.parentWindow and self.isSizing) then
                        local OnMouseUp = self:GetScript("OnMouseUp");
                        OnMouseUp(self);
                end
        end);
resizeFrame:SetScript("OnUpdate", function(self)
		if(self.isSizing and self.parentWindow and self.parentWindow.tabStrip) then
			local curSize = self.parentWindow:GetWidth()..self.parentWindow:GetHeight();
			if(self.prevSize ~= curSize) then
				self.parentWindow.tabStrip:UpdateTabs();
				self.prevSize = curSize;
			end
		end
		if(self.parentWindow.isMoving) then
			self:Reset();
		end
	end);


-- helperFrame's purpose is to assist with dragging and dropping of Windows into tab strips.
-- The frame will monitor which window objects are being dragged over and attach itself to them when
-- it's key trigger is pressed.
local helperFrame = CreateFrame("Frame", "WIM_WindowHelperFrame", WindowParent);
helperFrame.flash = helperFrame:CreateTexture(helperFrame:GetName().."Flash", "OVERLAY");
helperFrame.flash:SetPoint("BOTTOMLEFT");
helperFrame.flash:SetPoint("BOTTOMRIGHT");
helperFrame.flash:SetHeight(4);
helperFrame.flash:SetBlendMode("ADD");
helperFrame.flash:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
helperFrame:SetFrameStrata("TOOLTIP");
helperFrame:SetWidth(1);
helperFrame:SetHeight(1);
helperFrame.ResetState = function(self)
        helperFrame:ClearAllPoints();
	helperFrame:SetParent(UIPanel);
        helperFrame:SetWidth(1);
        helperFrame:SetHeight(1);
        helperFrame:SetPoint("TOPLEFT", WindowParent, "TOPLEFT", 0, 0);
	helperFrame.isAttached = false;
        helperFrame.attachedTo = nil;
    end
helperFrame:SetPoint("TOPLEFT", WindowParent, "TOPLEFT", 0, 0);
helperFrame:SetScript("OnUpdate", function(self)
                if(IsShiftKeyDown()) then
			local obj = GetMouseFocus();
			if(obj and (obj.isWimWindow or obj.parentWindow)) then
				local win;
				if(obj.isWimWindow) then
					win = obj;
				else
					win = obj.parentWindow;
				end
                                if(win == WIM.DemoWindow) then
                                        return;
                                end
				if(not win.isMoving) then
                                                resizeFrame:Attach(win);
                                end
				if(win.isMoving and not (win.tabStrip and win.tabStrip:IsVisible())) then
				        local mWin = getWindowAtCursorPosition(win);
                                        if(mWin) then
                                                if(self.isAttached) then
                                                                if(mWin ~= self.attachedTo) then
                                                                                self:ResetState();
                                                                end
                                                else
                                                                if(mWin ~= WIM.DemoWindow) then
                                                                                -- attach to window
                                                                                local skinTable = GetSelectedSkin().tab_strip;
                                                                                self.parentWindow = mWin;
                                                                                self.attachedTo = mWin;
                                                                                mWin.helperFrame = self;
                                                                                self:SetParent(mWin);
                                                                                SetWidgetRect(self, skinTable);
                                                                                self:SetHeight(self.flash:GetHeight());
                                                                                self.isAttached = true;
                                                                end
                                                end
                                        else
                                                if(self.isAttached) then
                                                                self:ResetState();
                                                end
                                        end
				else
					if(self.isAttached) then
						self:ResetState();
					end
				end
			else
				resizeFrame:Reset();
				if(self.isAttached) then
					self:ResetState();
				end
			end
                else
		    resizeFrame:Reset();
                    if(self.isAttached) then
                        self:ResetState();
                    end
                end
                if(self.isAttached) then
                    self.flash:Show();
                else
                    self.flash:Hide();
                end
            end);
helperFrame:Show();


local function executeHandlers(WidgetName, wType, HandlerName, ...)
	local tbl, fun;
	if(Widget_Triggers[WidgetName] and Widget_Triggers[WidgetName][HandlerName] and Widget_Triggers[WidgetName][HandlerName][wType]) then
		tbl = Widget_Triggers[WidgetName][HandlerName][wType];
	end
	if(type(tbl) == "table") then
		for i=1,#tbl do
			fun = tbl[i];
			fun(...);
		end
	end
end

--Returns object, SoupBowl_windows_index or nil if window can not be found.
local function getWindowBy(userName)
    if(type(userName) ~= "string") then
        return nil;
    end
    for i=1,#WindowSoupBowl.windows do
        if(WindowSoupBowl.windows[i].user == userName) then
            return WindowSoupBowl.windows[i].obj, i;
        end
    end
end


--Clean up the frame's points and make sure the main point TOPLEFT,BOTTOMRIGHT is set
function cleanPoints(win)
                local x, y;
                for i = 1, win:GetNumPoints() do
                                local p1, parent, p2, tx, ty = win:GetPoint(i);
                                _G.DEFAULT_CHAT_FRAME:AddMessage(p1..", ".._G.tostring(parent)..", "..p2..", "..tx..", "..ty);
                end
                _G.DEFAULT_CHAT_FRAME:AddMessage("    "..win:SafeGetLeft()..", "..win:SafeGetTop());
end

-- climb up inherritance tree and find parent window recursively.
local function getParentMessageWindow(obj)
    if(not obj) then
	return nil;
    elseif(obj.isParent) then
        return obj;
    elseif(obj.parentWindow) then
	return obj.parentWindow;
    elseif(obj:GetName() == "UIParent") then
        return nil;
    else
        return getParentMessageWindow(obj:GetParent())
    end
end

local function setWindowAsFadedIn(obj)
	if(WIM.db.winFade) then
		obj.delayFadeElapsed = 0;
		obj.delayFade = true;
		obj.fadedIn = true;
		UIFrameFadeIn(obj, FadeProps.interval, obj:GetAlpha(), FadeProps.max)
	else
		obj:SetAlpha(FadeProps.max);
	end
end

--------------------------------------
--       Widget Script Handlers     --
--------------------------------------

function updateScrollBars(parentWindow)
        if(parentWindow and parentWindow.widgets and parentWindow.widgets.chat_display) then
                if(parentWindow.widgets.chat_display:AtTop()) then
                	parentWindow.widgets.scroll_up:Disable();
                else
                	parentWindow.widgets.scroll_up:Enable();
                end
                if(parentWindow.widgets.chat_display:AtBottom()) then
                	parentWindow.widgets.scroll_down:Disable();
                else
                	parentWindow.widgets.scroll_down:Enable();
                end
        end
end

local function MessageWindow_MovementControler_OnDragStart(self)
    local window = getParentMessageWindow(self);
    if(window) then
        window:StartMoving();
        window.isMoving = true;
    end
end

local function MessageWindow_MovementControler_OnDragStop(self)
    local window = getParentMessageWindow(self);
    if(window) then
	local dropTo = helperFrame.attachedTo;
	helperFrame:ResetState();
        window:StopMovingOrSizing();
        window.isMoving = false;
        window.widgets.chat_display:Hide();
        window.widgets.chat_display:Show();
        window.hasMoved = true;
	if(dropTo) then
		if(dropTo.tabStrip) then
			dropTo.tabStrip:Attach(window);
                        window:Hide();
                        dropTo.tabStrip:JumpToTab(dropTo);
		else
                        window:Hide();
			local tabStrip = GetAvailableTabGroup();
			tabStrip:Attach(dropTo);
			tabStrip:Attach(window);
                        tabStrip:JumpToTab(dropTo);
		end
	end
    end
end

-- this needs to be looked at. it isn't doing anything atm...
local function MessageWindow_Frame_OnShow(self)
        if(WindowParent.animUp) then
                return;
        end
                --_G.DEFAULT_CHAT_FRAME:AddMessage(_G.debugstack(1))
        setWindowAsFadedIn(self);
        if(self ~= DemoWindow) then
                updateScrollBars(self);
                CallModuleFunction("OnWindowShow", self);
        	for widgetName, widgetObj in pairs(self.widgets) do
        		if(type(widgetObj.OnWindowShow) == "function") then
        			widgetObj:OnWindowShow();
        		end
        	end
        else
                self.widgets.chat_display:Clear();
                self.widgets.chat_display:AddMessage(L["_DemoText"]);
                self.widgets.msg_box:Hide();
        end
end

-- this needs to be looked at. it isn't doing anything atm...
local function MessageWindow_Frame_OnHide(self)
        if ( self.isMoving ) then
		self:StopMovingOrSizing();
		self.isMoving = false;
        end
        self:ResetAnimation();
        if(self.type == "demo" and self.demoSave) then
                -- save window placement settings.
                db.winLoc.left = self:SafeGetLeft()*self:GetEffectiveScale();
                db.winLoc.top = self:SafeGetTop()*self:GetEffectiveScale();
                options.frame:Enable();
                self.demoSave = nil;
                DestroyWindow(self);
                WIM.DemoWindow = nil;
        elseif(self.type ~= "demo") then
                CallModuleFunction("OnWindowHide", self);
                for widgetName, widgetObj in pairs(self.widgets) do
                	if(type(widgetObj.OnWindowHide) == "function") then
                		widgetObj:OnWindowHide();
                	end
                end
        end
end


local function updateTracker(win)
                if(not WindowParent.animUp) then
                                local pS, sS = WindowParent:GetEffectiveScale(), win:GetEffectiveScale()
                                local pL, pR, pT, pB = WindowParent:GetLeft()*pS, WindowParent:GetRight()*pS, WindowParent:GetTop()*pS, WindowParent:GetBottom()/pS;
                                local sL, sR, sT, sB = win:GetLeft()*sS, win:GetRight()*sS, win:GetTop()*sS, win:GetBottom()*sS;
                                
                                if(not db.clampToScreen and sT < 0) then -- bottom
                                                if(win.offScreen ~= 1) then
                                                                win.offScreen = 1;
                                                                CallModuleFunction("OnWindowLeaveScreen", win, 1);
                                                end
                                elseif(not db.clampToScreen and sB > pT) then -- top
                                                if(win.offScreen ~= 2) then
                                                                win.offScreen = 2;
                                                                CallModuleFunction("OnWindowLeaveScreen", win, 2);
                                                end
                                elseif(not db.clampToScreen and sR < 0) then -- left
                                                if(win.offScreen ~= 3) then
                                                                win.offScreen = 3;
                                                                CallModuleFunction("OnWindowLeaveScreen", win, 3);
                                                end
                                elseif(not db.clampToScreen and sL > pR) then -- right
                                                if(win.offScreen ~= 4) then
                                                                win.offScreen = 4;
                                                                CallModuleFunction("OnWindowLeaveScreen", win, 4);
                                                end
                                else
                                                --on screen
                                                if(win.offScreen ~= 0) then
                                                                CallModuleFunction("OnWindowEnterScreen", win);
                                                end
                                                win.offScreen = 0;
                                end
                end
end


local function MessageWindow_Frame_OnUpdate(self, elapsed)
	-- window is visible, there aren't any messages waiting...
        updateTracker(self);
	self.msgWaiting = false;
	self.unreadCount = 0;
        -- animation segment
	if(self.animation and self.animation.mode) then
                local animate = self.animation;
                if(animate.mode == "HIDE") then
                                animate.elapsed = animate.elapsed + elapsed;
                                if(animate.elapsed > animate.time) then
                                                self:Hide_Normal();
                                else
                                                local prct = animate.elapsed/animate.time;
                                                local scale = (db.winSize.scale/100)*(1-prct);
                                                scale = scale > animate.scaleLimit and scale or animate.scaleLimit;
                                		self:SetScale(scale);
                                		if(animate.to and animate.to.GetEffectiveScale) then
                                                                local to = animate.to;
                                                                local es, ts = self:GetEffectiveScale(), to:GetEffectiveScale();
                                                                es, ts = es > 0 and es or .01, ts > 0 and ts or .01;
                                                                local x1, y1, x2, y2 = animate.initLeft*es, animate.initTop*es, to:GetLeft()*ts, to:GetTop()*ts;
                                                		local rise, run = ((y2-y1)>=0) and (y2-y1) or 0, ((x2-x1)>=0) and (x2-x1) or 0;
                                                		self:ClearAllPoints();
                                                		self:SetPoint("TOPLEFT", WindowParent, "BOTTOMLEFT", (x1+run*prct)/es, (y1+rise*prct)/es);
                                                end
                                	end
                                end
	else
                -- fading segment
                if(db.winFade and self ~= DemoWindow) then
                	self.fadeElapsed = (self.fadeElapsed or 0) + elapsed;
                	while(self.fadeElapsed > .1) do
                		local window = GetMouseFocus();
                		if(window) then
                			if(((window == self or window.parentWindow == self  or self.isOnHyperLink or
                					self == helperFrame.attachedTo or
                					(EditBoxInFocus and EditBoxInFocus.parentWindow == self)) or
                					(window.tabStrip and window.tabStrip.selected.obj == self)) and
                					(not self.fadedIn or self.delayFade)) then
                				self.fadedIn = true;
                				self.delayFade = false;
                				self.delayFadeElapsed = 0;
                				UIFrameFadeIn(self, FadeProps.interval, self:GetAlpha(), FadeProps.max);
                			elseif(window ~= self and window.parentWindow ~= self and not self.isOnHyperLink and
                					(not (window.tabStrip and window.tabStrip.selected.obj == self)) and
                					helperFrame.attachedTo ~= self and
                					(not EditBoxInFocus or EditBoxInFocus.parentWindow ~= self) and self.fadedIn) then
                				if(self.delayFade) then
                					self.delayFadeElapsed = (self.delayFadeElapsed or 0) + elapsed;
                					while(self.delayFadeElapsed > FadeProps.delay) do
                						self.delayFade = false;
                						self.delayFadeElapsed = 0;
                					end
                				else
                					self.fadedIn = false;
                					self.delayFadeElapsed = 0;
                					UIFrameFadeOut(self, FadeProps.interval, self:GetAlpha(), FadeProps.min);
                				end
                			end
                		end
                		self.fadeElapsed = 0;
                	end
                elseif(not self.fadedIn) then
                        setWindowAsFadedIn(self);
                end
	end
end

--local function MessageWindow_MsgBox_OnMouseUp()
--    CloseDropDownMenus();
--    if(arg1 == "RightButton") then
--        WIM_MSGBOX_MENU_CUR_USER = this:GetParent().theUser;
--        UIDropDownMenu_Initialize(WIM_MsgBoxMenu, WIM_MsgBoxMenu_Initialize, "MENU");
--        ToggleDropDownMenu(1, nil, WIM_MsgBoxMenu, this, 0, 0);
--    end
--end



local function loadHandlers(obj)
	local widgets = obj.widgets;
	for widget, tbl in pairs(Widget_Triggers) do
		for handler,_ in pairs(tbl) do
                        -- This is, what i feel an over kill of checks.. but if it works... /shrug.
			if(widgets[widget] and widgets[widget]and not widgets[widget]:GetScript(handler)) then
				widgets[widget]:SetScript(handler, function(...) executeHandlers(widget, obj.type, handler, ...); end)
			end
		end
	end
end


local function setAllChildrenParentWindow(parent, child)
	local i;
	if(child ~= parent) then
		child.parentWindow = parent;
	end
	local children = {child:GetChildren()};
	for i=1,#children do
		setAllChildrenParentWindow(parent, children[i]);
	end
end

local function loadRegisteredWidgets(obj)
	local widgets = obj.widgets;
	for widget, createFun in pairs(RegisteredWidgets) do
		if(widgets[widget] == nil) then
			if(type(createFun) == "function") then
				widgets[widget]  = createFun();
                                widgets[widget]:SetParent(obj);
                                widgets[widget].widgetName = widget;
                                widgets[widget].parentWindow = obj;
                                widgets[widget].enabled = true;
                                widgets[widget].Enable = function(self)
                                        self.enabled = true;
                                        self:Show();
                                        self.parentWindow:UpdateProps();
                                end
                                widgets[widget].Disable = function(self)
                                        self.enabled = false;
                                        self:Hide();
                                        self.parentWindow:UpdateProps();
                                end
                                ApplySkinToWidget(widgets[widget]);
				dPrint("Widget '"..widget.."' added to '"..obj:GetName().."'");
				if(type(widgets[widget].SetDefaults) == "function") then
					widgets[widget]:SetDefaults(); -- load defaults for this widget
				end
			end
		else
			if(type(widgets[widget].SetDefaults) == "function") then
				widgets[widget]:SetDefaults(); -- load defaults for this widget
			end
		end
		--widgets[widget].parentWindow = obj;
		if(type(widgets[widget]) == "table") then
			widgets[widget].parentWindow = obj;
		end
	end
	setAllChildrenParentWindow(obj, obj)
end

local function updateActiveObjects()
	for i=1, #WindowSoupBowl.windows do
		if(WindowSoupBowl.windows[i].inUse) then
			loadRegisteredWidgets(WindowSoupBowl.windows[i].obj);
			loadHandlers(WindowSoupBowl.windows[i].obj);
		end
	end
end

function scaleWindow(self, scale)
	-- scale down window and preserve location
	local left, top = self:SafeGetLeft()*self:GetEffectiveScale(), self:SafeGetTop()*self:GetEffectiveScale();
	local setScale = self.SetScale_Orig or self.SetScale;
	setScale(self, (scale > 0) and scale or 0.01)
	self:ClearAllPoints();
        local curScale = self:GetEffectiveScale();
        curScale = (curScale > 0) and curScale or 0.01;
	self:SetPoint("TOPLEFT", WindowParent, "BOTTOMLEFT", left/curScale, top/curScale);
end

-- create all of MessageWindow's object children
local function instantiateWindow(obj)
    local fName = obj:GetName();
    -- set frame's initial properties
    obj:SetClampedToScreen(not WindowParent.animUp and db.clampToScreen);
    obj:SetFrameStrata("DIALOG");
    obj:SetMovable(true);
    obj:SetToplevel(true);
    obj:SetWidth(384);
    obj:SetHeight(256);
    obj:EnableMouse(true);
    obj:SetPoint("TOPLEFT", WindowParent, "BOTTOMLEFT", 25, WindowParent:GetTop()-125);
    obj:RegisterForDrag("LeftButton");
    obj:SetScript("OnDragStart", MessageWindow_MovementControler_OnDragStart);
    obj:SetScript("OnDragStop", MessageWindow_MovementControler_OnDragStop);
    obj:SetScript("OnMouseUp", MessageWindow_MovementControler_OnDragStop);
    obj:SetScript("OnShow", MessageWindow_Frame_OnShow);
    obj:SetScript("OnHide", MessageWindow_Frame_OnHide);
    obj:SetScript("OnUpdate", MessageWindow_Frame_OnUpdate);
    obj.isWimWindow = true;
    obj.helperFrame = helperFrame;
    obj.animation = {};
    
    obj.SetScale_Orig = obj.SetScale;
    obj.SetScale = scaleWindow;
    
    obj.widgets = {};
    local widgets = obj.widgets;
    
    -- add window backdrop frame
    widgets.Backdrop = CreateFrame("Frame", fName.."Backdrop", obj);
    widgets.Backdrop:SetToplevel(false);
    widgets.Backdrop:SetAllPoints(obj);
    widgets.class_icon = widgets.Backdrop:CreateTexture(fName.."BackdropClassIcon", "BACKGROUND");
    widgets.class_icon.widgetName = "class_icon";
    widgets.class_icon.parentWindow = obj;
    widgets.Backdrop.tl = widgets.Backdrop:CreateTexture(fName.."Backdrop_TL", "BORDER");
    widgets.Backdrop.tr = widgets.Backdrop:CreateTexture(fName.."Backdrop_TR", "BORDER");
    widgets.Backdrop.bl = widgets.Backdrop:CreateTexture(fName.."Backdrop_BL", "BORDER");
    widgets.Backdrop.br = widgets.Backdrop:CreateTexture(fName.."Backdrop_BR", "BORDER");
    widgets.Backdrop.t  = widgets.Backdrop:CreateTexture(fName.."Backdrop_T" , "BORDER");
    widgets.Backdrop.b  = widgets.Backdrop:CreateTexture(fName.."Backdrop_B" , "BORDER");
    widgets.Backdrop.l  = widgets.Backdrop:CreateTexture(fName.."Backdrop_L" , "BORDER");
    widgets.Backdrop.r  = widgets.Backdrop:CreateTexture(fName.."Backdrop_R" , "BORDER");
    widgets.Backdrop.bg = widgets.Backdrop:CreateTexture(fName.."Backdrop_BG", "BORDER");
    widgets.from = widgets.Backdrop:CreateFontString(fName.."BackdropFrom", "OVERLAY", "GameFontNormalLarge");
    widgets.from.widgetName = "from";
    widgets.char_info = widgets.Backdrop:CreateFontString(fName.."BackdropCharacterDetails", "OVERLAY", "GameFontNormal");
    widgets.char_info.widgetName = "char_info";
    
    -- create core window objects
    widgets.close = CreateFrame("Button", fName.."ExitButton", obj);
    widgets.close:RegisterForClicks("LeftButtonUp", "RightButtonUp");
    widgets.close.curTextureIndex = 1;
    widgets.close.parentWindow = obj;
    widgets.close.widgetName = "close";
    
    widgets.scroll_up = CreateFrame("Button", fName.."ScrollUp", obj);
    widgets.scroll_up:RegisterForClicks("LeftButtonUp", "RightButtonUp");
    widgets.scroll_up.widgetName = "scroll_up";
    
    widgets.scroll_down = CreateFrame("Button", fName.."ScrollDown", obj);
    widgets.scroll_down:RegisterForClicks("LeftButtonUp", "RightButtonUp");
    widgets.scroll_down.widgetName = "scroll_down";
    
    widgets.chat_display = CreateFrame("ScrollingMessageFrame", fName.."ScrollingMessageFrame", obj);
    --widgets.chat_display:RegisterForDrag("LeftButton");
    widgets.chat_display:SetFading(false);
    widgets.chat_display:SetMaxLines(128);
    widgets.chat_display:SetMovable(true);
    --widgets.chat_display:SetScript("OnDragStart", function(self) MessageWindow_MovementControler_OnDragStart(self); end);
    --widgets.chat_display:SetScript("OnDragStop", function(self) MessageWindow_MovementControler_OnDragStop(self); end);
    widgets.chat_display:SetJustifyH("LEFT");
    widgets.chat_display:EnableMouse(true);
    widgets.chat_display:EnableMouseWheel(1);
    widgets.chat_display.widgetName = "chat_display";
    
    widgets.msg_box = CreateFrame("EditBox", fName.."MsgBox", obj);
    widgets.msg_box:SetAutoFocus(false);
    widgets.msg_box:SetHistoryLines(32);
    --widgets.msg_box:SetMaxLetters(255);
    widgets.msg_box:SetAltArrowKeyMode(true);
    widgets.msg_box:EnableMouse(true);
    widgets.msg_box.widgetName = "msg_box";
    
    --Addmessage functions
    obj.AddMessage = function(self, msg, ...)
	msg = applyStringModifiers(msg, self.widgets.chat_display);
	self.widgets.chat_display:AddMessage(msg, ...);
        updateScrollBars(self);
	CallModuleFunction("OnWindowMessageAdded", self, msg, ...);
    end
    
    obj.AddMessageRaw = function(self, msg, ...)
        self.widgets.chat_display:AddMessage(msg, ...);
    end
    
    obj.AddEventMessage = function(self, r, g, b, event, ...)
        nextColor.r, nextColor.g, nextColor.b = r, g, b;
	local str = applyMessageFormatting(self.widgets.chat_display, event, ...);
	self:AddMessage(str, r, g, b);
	self.msgWaiting = true;
	self.lastActivity = _G.GetTime();
        if(self.tabStrip) then
                self.tabStrip:UpdateTabs();
        end
    end
    
    obj.UpdateIcon = function(self)
        local icon = self.widgets.class_icon;
        if(self.type == "chat" and self.chatType) then
                icon:SetTexture(GetSelectedSkin().message_window.widgets.class_icon.chatAlphaMask);
                local color = _G.ChatTypeInfo[string.upper(self.chatType)];
                icon:SetTexCoord(0,1,0,1);
                icon:SetGradient("VERTICAL", color.r, color.g, color.b, color.r, color.g, color.b);
                if(GetSelectedSkin().message_window.widgets.from.use_class_color) then
                                self.widgets.from:SetTextColor(color.r, color.g, color.b);
                end
        else
                local classTag = obj.class;
                icon:SetGradient("VERTICAL", 1, 1, 1, 1, 1, 1);
                icon:SetTexture(GetSelectedSkin().message_window.widgets.class_icon.texture);
                if(self.class == "") then
                	classTag = "blank"
                else
                	if(constants.classes[self.class]) then
                		classTag = string.lower(constants.classes[self.class].tag);
                                classTag = string.gsub(classTag, "f$", "");
                	else
                		classTag = "blank";
                	end
                end
                icon:SetTexCoord(unpack(GetSelectedSkin().message_window.widgets.class_icon[classTag]));
                if(constants.classes[self.class]) then
                        self.classColor = constants.classes[self.class].color;
                        if(GetSelectedSkin().message_window.widgets.from.use_class_color) then
                                        self.widgets.from:SetTextColor(RGBHexToPercent(constants.classes[self.class].color));
                        end
                end
          end
    end
    
    obj.UpdateCharDetails = function(self)
        self.widgets.char_info:SetText(GetSelectedSkin().message_window.widgets.char_info.format(self, self.guild, self.level, self.race, self.class));
    end
    
    obj.WhoCallback = function(result)
	if(result and result.Online and result.Name == obj.theUser) then
		obj.class = result.Class;
		obj.level = result.Level;
		obj.race = result.Race;
		obj.guild = result.Guild;
		obj.location = result.Zone;
		obj:UpdateIcon();
		obj:UpdateCharDetails();
	end
    end
    
    obj.SendWho = function(self)
        if(self.type ~= "whisper") then
                return;
        end
        if(self.isGM) then
                self.WhoCallback({
                        Name = self.theUser,
                        Online = true,
                        Guild = "Blizzard",
                        Class = L["Game Master"],
                        Level = "",
                        Race = "",
                        Zone = L["Unknown"]
                });
        elseif(self.isBN) then
                -- get information of BN user from friends data.
                local id = _G.BNet_GetPresenceID(self.theUser);
                if(id) then
                                local hasFocus, toonName, client, realmName, faction, race, class, guild, zoneName, level, gameText, broadcastText, broadcastTime = _G.BNGetToonInfo(id);
                                self.class = class;
                                self.level = level;
                                self.race = race;
                                self.guild = guild;
                                self.location = zoneName;
                                self.bn.class = class;
                                self.bn.level = level;
                                self.bn.race = race;
                                self.bn.guild = guild;
                                self.bn.location = zoneName;
                                self.bn.gameText = gameText;
                                self.bn.toonName = toonName;
                                self.bn.client = client;
                                self.bn.realmName = realmName;
                                self.bn.faction = faction;
                                self.bn.broadcastText = broadcastText;
                                self.bn.broadcastTime = broadcastTime;
                                self.bn.hasFocus = hasFocus;
                                self.bn.id = id;
                                --self.widgets.from:SetText(self.theUser.." - "..toonName);
                                self:UpdateIcon();
                                self:UpdateCharDetails();
                else
                                self:AddMessage(_G.BN_UNABLE_TO_RESOLVE_NAME, db.displayColors.errorMsg.r, db.displayColors.errorMsg.g, db.displayColors.errorMsg.b);
                end
        else
        	local whoLib = libs.WhoLib;
        	if(whoLib) then
        		local result = whoLib:UserInfo(self.theUser, 
        			{
        				queue = whoLib.WHOLIB_QUEUE_QUIET, 
        				timeout = 0,
        				--flags = whoLib.WHOLIB_FLAG_ALWAYS_CALLBACK,
        				callback = self.WhoCallback
        			});
                         if(result) then
                                self.WhoCallback(result);
                         end
        	else
        		dPrint("WhoLib-1.0 not loaded... Skipping who lookup!");
        	end
        end
    end
    
    obj.GetRuleSet = function(self)
        if(db.pop_rules[self.type]) then
                local curState = db.pop_rules[self.type].alwaysOther and "other" or curState
		return db.pop_rules[self.type][curState];
	else
                return db.pop_rules.whisper.other;
        end
    end
    
    -- PopUp rules
    obj.Pop = function(self, msgDirection, forceResult, forceFocus) -- true to force show, false it ignore rules and force quiet.
	-- account for variable arguments.
	if(type(msgDirection) == "boolean") then
		forceResult, forceFocus = msgDirection, forceResult;
		msgDirection = "in";
	elseif(msgDirection == nil) then
		msgDirection = "in";
	end
        
	local rules = self:GetRuleSet(); -- defaults incase unknown
    
	-- pass isNew to pop ruleset.
	if(forceResult == true) then
		-- go by forceResult and ignore rules
		if(self.tabStrip) then
                                --if(not EditBoxInFocus) then
                                                ShowContainer();
                                                self.tabStrip:JumpToTab(self);
                                                if(not getVisibleChatFrameEditBox() and (rules.autofocus or forceFocus)) then
                                                        self.widgets.msg_box:SetFocus();
                                                end
                                --end
		else
                                ShowContainer();
				self:ResetAnimation();
				self:Show();
                                if((not getVisibleChatFrameEditBox() and not EditBoxInFocus and rules.autofocus) or forceFocus) then
                                        self.widgets.msg_box:SetFocus();
                                end
				local count = 0;
				for i=1, #WindowSoupBowl.windows do
					count = WindowSoupBowl.windows[i].obj:IsShown() and count + 1 or count;
				end
				if(count > 1) then
					DisplayTutorial(L["Creating Tab Groups"], L["You can group two or many windows together by <Shift-Clicking> a window and dragging it on top of another."]);
				else
					DisplayTutorial(L["Resizing Windows"], L["You can resize a window by holding <Shift> and dragging the bottom right corner of the window."]);
				end
		end
	else
		-- execute pop rules.
		if((rules.onSend and msgDirection == "out") or (rules.onReceive and msgDirection == "in")) then 
			if(self.tabStrip) then
				self:ResetAnimation();
                                local infocus = EditBoxInFocus and EditBoxInFocus:GetParent().tabStrip;
                                if(infocus ~= self.tabStrip) then
                                                self.tabStrip:JumpToTab(self);
                                                setWindowAsFadedIn(self);
                                end
			else
				self:ResetAnimation();
				self:Show();
                                setWindowAsFadedIn(self);
			end
                        if(self:IsVisible() and not getVisibleChatFrameEditBox and not EditBoxInFocus and rules.autofocus) then
                                self.widgets.msg_box:SetFocus();
                        end
		end
	end
	
	-- at this state the message is no longer classified as a new window, reset flag.
	obj.isNew = false;
        CallModuleFunction("OnWindowPopped", self);
    end
    
    obj.UpdateProps = function(self)
        self:SetFrameStrata(db.winSize.strata);
	self:SetScale(db.winSize.scale/100);
	self.widgets.Backdrop:SetAlpha(db.windowAlpha/100);
	local Path,_,Flags = self.widgets.chat_display:GetFont();
        self:SetClampedToScreen(not WindowParent.animUp and db.clampToScreen);
	self.widgets.chat_display:SetFont(Path,db.fontSize+2,Flags);
	self.widgets.chat_display:SetAlpha(1);
	self.widgets.chat_display:SetIndentedWordWrap(db.wordwrap_indent);
	self.widgets.msg_box:SetAlpha(1);
	self.widgets.msg_box:SetAltArrowKeyMode(db.ignoreArrowKeys);
	
	self.widgets.from:SetAlpha(1);
	self.widgets.char_info:SetAlpha(1);
	self.widgets.close:SetAlpha(db.windowAlpha);
	self.widgets.scroll_up:SetAlpha(db.windowAlpha);
	self.widgets.scroll_down:SetAlpha(db.windowAlpha);
	
        if(not self.customSize) then
                self:SetWidth(db.winSize.width);
                self:SetHeight(db.winSize.height);
        end
        
        local minWidth, minHeight = GetSelectedSkin().message_window.min_width, GetSelectedSkin().message_window.min_height;
        
	-- process registered widgets
	local widgetName, widgetObj;
	for widgetName, widgetObj in pairs(obj.widgets) do
		if(type(widgetObj.UpdateProps) == "function") then
			widgetObj:UpdateProps();
		end
                if(widgetObj.type) then
                        if(widgetObj.enabled and string.match(widgetObj.type, obj.type)) then
                                widgetObj:Show();
                                local w, h = widgetObj:GetWidth(), widgetObj:GetHeight();
                                minWidth = _G.math.max(minWidth, (self:SafeGetLeft() - widgetObj:GetLeft()) + w + (widgetObj:GetRight() - self:SafeGetRight()));
                                minHeight = _G.math.max(minHeight, (self:SafeGetTop() - widgetObj:GetTop() - WindowParent:GetBottom()) + h + (widgetObj:GetBottom() - self:SafeGetBottom() - WindowParent:GetBottom()));
                        else
                                widgetObj:Hide()
                        end
                end
	end
        self:SetMinResize(minWidth, minHeight);
        self:SetWidth(_G.math.max(minWidth, self:GetWidth()));
        self:SetHeight(_G.math.max(minHeight, self:GetHeight()));
        self.initialized = true;
    end
    
    obj.Hide_Normal = obj.Hide;
    obj.Hide = function(self, animate)
	if(not self:IsShown() or self.animation.mode) then
		-- don't do anything if window is already hidden.
		return;
	end
	if(not animate) then
		self:Hide_Normal();
		self:ResetAnimation();
	else
                
		if(not db.winAnimation) then
			self:Hide_Normal();
			self:ResetAnimation();
		else
                        self.widgets.chat_display:SetParent("UIParent");
                        self.widgets.chat_display:Hide();
			local a = self.animation;
			obj:SetClampedToScreen(false);
			a.initLeft = self:SafeGetLeft();
			a.initTop = self:SafeGetTop();
			a.to = MinimapIcon or nil;
			a.elapsed, a.time = 0, .5;
                        a.scaleLimit = .001 --_G.math.max(_G.math.ceil((100-_G.UIParent:GetScale()*100)/2)/100 + .04, .01);
			a.mode = "HIDE"; -- this starts the animation
			dPrint("Animation Started: "..self:GetName());
		end
	end
    end
    obj.ResetAnimation = function(self)
	if(self.animation.mode) then
		self:SetClampedToScreen(not WindowParent.animUp and db.clampToScreen);
		self:SetScale_Orig(db.winSize.scale/100);
                self:ClearAllPoints();
		self:SetPoint("TOPLEFT", WindowParent, "BOTTOMLEFT", self.animation.initLeft, self.animation.initTop - WindowParent:GetBottom());
                self.widgets.chat_display:Show();
                self.widgets.chat_display:SetParent(self);
		dPrint("Animation Reset: "..self:GetName());
	end
	for key, _ in pairs(self.animation) do
		self.animation[key] = nil;
	end
    end
    obj.SafeGetLeft = function(self)
                return self:GetLeft() - WindowParent:GetLeft();
    end
    obj.SafeGetRight = function(self)
                return self:GetRight() - WindowParent:GetLeft();
    end
    obj.SafeGetTop = function(self)
                return self:GetTop() - WindowParent:GetBottom();
    end
    obj.SafeGetBottom = function(self)
                return self:GetBottom() - WindowParent:GetBottom();
    end
    
    --enforce that all core widgets have parentWindow set.
	local w;
	for _, w in pairs(obj.widgets) do
		w.parentWindow = obj;
	end
    
    -- load Registered Widgets
    loadRegisteredWidgets(obj);
    loadHandlers(obj);
    
    --local shortcuts = CreateFrame("Frame", fName.."ShortcutFrame", obj);
    --shortcuts:SetToplevel(true);
    --shortcuts:SetFrameStrata("DIALOG");
    --for i=1,ShortcutCount do
    --    CreateFrame("Button", fName.."ShortcutFrameButton"..i, shortcuts, "WIM_ShortcutButtonTemplate");
    --end

end

local function placeWindow(win)
        win:ClearAllPoints();
        local lastWindow = nil;
        for i=1, #windowsByAge do
                if(windowsByAge[i] ~= win and windowsByAge[i]:IsShown() and windowsByAge[i].hasMoved == false) then
                        lastWindow = windowsByAge[i];
                        break;
                end
        end
        if(not lastWindow or db.winCascade.enabled == false) then
                win:SetPoint("TOPLEFT", WindowParent, "BOTTOMLEFT", db.winLoc.left/win:GetEffectiveScale(), (db.winLoc.top)/win:GetEffectiveScale());
        else
                local casc = cascadeDirection[db.winCascade.direction];
                win:SetPoint("TOPLEFT", WindowParent, "BOTTOMLEFT", lastWindow:SafeGetLeft()+casc[1], lastWindow:SafeGetTop()+casc[2]);
        end
end


-- load object into it's default state.
local function loadWindowDefaults(obj)
	obj:Hide();

        obj.age = _G.GetTime();
        obj.hasMoved = false;

	obj.lastActivity = _G.GetTime();

        obj.customSize = false;

	obj.guild = "";
	obj.level = "";
	obj.race = "";
	obj.class = "";
	obj.location = "";
        obj.demoSave = nil;
        obj.classColor = "ffffff";
    
        obj.isGM = lists.gm[obj.theUser];
    
        obj:UpdateIcon();
	obj.isNew = true;

	obj:SetScale(1);
	obj:SetAlpha(1);
    
	obj.widgets.Backdrop:SetAlpha(1);
    
	obj.widgets.from:SetText(obj.theUser);
	obj.widgets.from:SetTextColor(RGBHexToPercent(GetSelectedSkin().message_window.widgets.from.font_color));
    
	obj.widgets.char_info:SetText("");
    
	obj.widgets.msg_box.setText = 0;
	obj.widgets.msg_box:SetText("");
        obj.widgets.msg_box:Show();
    
	obj.widgets.chat_display:Clear();
	obj.widgets.chat_display:AddMessage("  ");
	obj.widgets.chat_display:AddMessage("  ");
	updateScrollBars(obj);
        
        obj.widgets.close.forceShift = false;
    
	-- load Registered Widgets (if not created already) & set defaults
	loadRegisteredWidgets(obj);
	loadHandlers(obj);
    
	-- process registered widgets
	local widgetName, widgetObj;
	for widgetName, widgetObj in pairs(obj.widgets) do
		if(type(widgetObj.SetDefaults) == "function") then
			widgetObj:SetDefaults();
		end
	end
	ApplySkinToWindow(obj);
	obj:UpdateProps();
        placeWindow(obj);
end

--Create (recycle if available) message window. Returns object.
-- (wtype == "whisper", "chat" or "w2w")
local function createWindow(userName, wtype)
    if(type(userName) ~= "string") then
        return;
    end
    --if(type(WIM:GetSelectedSkin()) ~= "table") then
    --    WIM:LoadSkin(WIM.db.skin.selected, WIM.db.skin.style);
    --end
    local func = function ()
                        if(WindowSoupBowl.available > 0) then
                            local i;
                            for i=1,#WindowSoupBowl.windows do
                                if(WindowSoupBowl.windows[i].inUse == false) then
                                    return WindowSoupBowl.windows[i].obj, i;
                                end
                            end
                        else
                            return nil;
                        end
                    end
    local obj, index = func();
    if(obj) then
        --object available...
        WindowSoupBowl.available = WindowSoupBowl.available - 1;
        WindowSoupBowl.used = WindowSoupBowl.used + 1;
        WindowSoupBowl.windows[index].inUse = true;
        WindowSoupBowl.windows[index].user = userName;
        obj.theUser = userName;
        obj.type = wtype;
        loadWindowDefaults(obj); -- clear contents of window and revert back to it's initial state.
        dPrint("Window recycled '"..obj:GetName().."'");
	CallModuleFunction("OnWindowCreated", obj);
        table.insert(windowsByAge, obj);
        table.sort(windowsByAge, function(a, b) return a.age > b.age; end);
        return obj;
    else
        -- must create new object
        WindowSoupBowl.used = WindowSoupBowl.used + 1;
        WindowSoupBowl.windowToken = WindowSoupBowl.windowToken + 1; --increment token for propper frame name creation.
        local fName = "WIM3_msgFrame"..WindowSoupBowl.windowToken;
        local f = CreateFrame("Frame",fName, WindowParent);
        local winTable = {
            user = userName,
            frameName = fName,
            inUse = true,
            obj = f
        };
        table.insert(WindowSoupBowl.windows, winTable);
        f.theUser = userName;
        f.type = wtype;
        f.isParent = true;
        instantiateWindow(f);
        --f.icon.theUser = userName;
        loadWindowDefaults(f);
        dPrint("Window created '"..f:GetName().."'");
	CallModuleFunction("OnWindowCreated", f);
        table.insert(windowsByAge, f);
        table.sort(windowsByAge, function(a, b) return a.age > b.age; end);
        return f;
    end
end


--Returns object, SoupBowl_windows_index or nil if window can not be found.
local function getWindowByName(userName)
    if(type(userName) ~= "string") then
        return nil;
    end
    for i=1,#WindowSoupBowl.windows do
        if(WindowSoupBowl.windows[i].user == userName) then
            return WindowSoupBowl.windows[i].obj, i;
        end
    end
end

--Deletes message window and makes it available in the Soup Bowl.
local function destroyWindow(userNameOrObj)
    local obj, index;
    if(type(userNameOrObj) == "string") then
        obj, index = getWindowByName(userNameOrObj);
    else
	obj, index = getWindowByName(userNameOrObj.theUser);
    end
    
    if(obj) then
	if(obj.tabStrip) then
		obj.tabStrip:Detach(obj);
	end
        WindowSoupBowl.windows[index].inUse = false;
        WindowSoupBowl.windows[index].user = "";
        WindowSoupBowl.available = WindowSoupBowl.available + 1;
        WindowSoupBowl.used = WindowSoupBowl.used - 1;
        --WIM_Astrolabe:RemoveIconFromMinimap(obj.icon);
        --obj.icon:Hide();
        --obj.icon.track = false;
        obj:Show();
        obj.widgets.chat_display:Clear();
        obj:Hide();
        obj.initialized = nil;
	dPrint("Window '"..obj:GetName().."' destroyed.");
	CallModuleFunction("OnWindowDestroyed", obj);
        removeFromTable(windowsByAge, obj);
    end
end






function RegisterWidgetTrigger(WidgetName, wType, HandlerName, Function)
	-- config table to handle widget
	if(not Widget_Triggers[WidgetName]) then
		Widget_Triggers[WidgetName] = {}
	end
	--config widget table to handle hander
	if(not Widget_Triggers[WidgetName][HandlerName]) then
		Widget_Triggers[WidgetName][HandlerName] = {
			whisper = {},
			chat = {},
			w2w = {},
                        demo = {},
		};
	end
	--register to table
	for i=1,select("#", string.split(",", wType)) do
		table.insert(Widget_Triggers[WidgetName][HandlerName][select(i, string.split(",", wType))], Function);
	end
	updateActiveObjects();
end

function GetWindowSoupBowl()
    return WindowSoupBowl;
end

function CreateWhisperWindow(playerName)
    return createWindow(playerName, "whisper");
end

function CreateChatWindow(chatName)
    return createWindow(chatName, "chat");
end

function CreateW2WWindow(chatName)
    return createWindow(chatName, "w2w");
end

function DestroyWindow(playerNameOrObject)
	destroyWindow(playerNameOrObject);
end

function ShowDemoWindow()
        if(options.frame and options.frame:IsShown()) then
                options.frame:Disable();
                if(not WIM.DemoWindow) then
                        WIM.DemoWindow = createWindow(L["Demo Window"], "demo");
                end
                WIM.DemoWindow:Show();
                WIM.DemoWindow.demoSave = true;
        end
end


function RegisterWidget(widgetName, createFunction, moduleName)
	-- moduleName is optional if not being called from a module.
        -- including module name will force the UI to be reloaded before removing the widgets.
	RegisteredWidgets[widgetName] = createFunction;
	if(moduleName) then
		modules[moduleName].hasWidget = true;
	end
        for i=1, #WindowSoupBowl.windows do
		if(WindowSoupBowl.windows[i].inUse) then
			loadRegisteredWidgets(WindowSoupBowl.windows[i].obj);
		end
	end
        updateActiveObjects();
end

--iterator: All loaded widgets
function Widgets(widgetName)
        local index = 1
        return function()
                for i=index, #WindowSoupBowl.windows do
                        if(WindowSoupBowl.windows[i].obj.widgets[widgetName]) then
                                index = i+1;
                                return WindowSoupBowl.windows[i].obj.widgets[widgetName];
                        end
                end
        end
end

function RegisterStringModifier(fun, prioritize)
	addToTableUnique(StringModifiers, fun, prioritize);
end

function UnregisterStringModifier(fun)
	removeFromTable(StringModifiers, fun);
end

function RegisterMessageFormatting(name, fun)
	table.insert(FormattingCalls, {
		name = name,
		fun = fun
	});
	table.insert(FormattingCallsList, name);
end

function GetMessageFormattingList()
	return FormattingCallsList;
end

function HideAllWindows(type)
        ShowContainer();
	type = type and string.lower(type) or nil;
	for i=1, #WindowSoupBowl.windows do
		if(WindowSoupBowl.windows[i].inUse and WindowSoupBowl.windows[i].obj.type == (type or WindowSoupBowl.windows[i].obj.type)) then
			WindowSoupBowl.windows[i].obj:Hide(true);
		end
	end
end

local showAllTbl = {};
function ShowAllWindows(type)
	type = type and string.lower(type) or nil;
	for i=1, #WindowSoupBowl.windows do
		if(WindowSoupBowl.windows[i].inUse and WindowSoupBowl.windows[i].obj.type == (type or WindowSoupBowl.windows[i].obj.type)) then
                                local obj = WindowSoupBowl.windows[i] and WindowSoupBowl.windows[i].obj;
                                if(obj.tabStrip and #obj.tabStrip.attached > 1) then
                                                if(addToTableUnique(showAllTbl, obj.tabStrip)) then
                                                                obj.tabStrip.selected.obj:Pop(true);
                                                end
                                else
                                                WindowSoupBowl.windows[i].obj:Pop(true);
                                end
                end
	end
        -- clean table
        for key, _ in pairs(showAllTbl) do
                showAllTbl[key] = nil;
        end
end

local showAllUnreadTbl = {};
function ShowAllUnreadWindows(type)
        type = type and string.lower(type) or nil;
	for i=1, #WindowSoupBowl.windows do
		if(WindowSoupBowl.windows[i].inUse and WindowSoupBowl.windows[i].obj.type == (type or WindowSoupBowl.windows[i].obj.type)) then
                        local obj = WindowSoupBowl.windows[i] and WindowSoupBowl.windows[i].obj;
                        if(obj and obj.unreadCount and obj.unreadCount > 0) then
                                if(obj.tabStrip) then
                                        if(addToTableUnique(showAllUnreadTbl, obj.tabStrip)) then
                        			WindowSoupBowl.windows[i].obj:Pop(true);
                                        end
                                else
                                        WindowSoupBowl.windows[i].obj:Pop(true);
                                end
                        end
		end
	end
        -- clean table
        for key, _ in pairs(showAllUnreadTbl) do
                showAllUnreadTbl[key] = nil;
        end
end


function UpdateAllWindowProps()
	for i=1, #WindowSoupBowl.windows do
		if(WindowSoupBowl.windows[i].inUse) then
			WindowSoupBowl.windows[i].obj:UpdateProps();
		end
	end
end

function AddEscapeWindow(frame)
	for i=1, #_G.UISpecialFrames do 
		if(_G.UISpecialFrames[i] == frame:GetName()) then
			return;
		end
	end
	table.insert(_G.UISpecialFrames, frame:GetName());
end

function RemoveEscapeWindow(frame)
	for i=1, #_G.UISpecialFrames do 
		if(_G.UISpecialFrames[i] == frame:GetName()) then
			table.remove(_G.UISpecialFrames, i);
			return;
		end
	end
end


------------------------------------
-- WindowParent - Container Calls --
------------------------------------


local function WindowParent_AnimPos(self, fraction)
                if(db.expose.direction == 1) then
                                -- UP
                                return "BOTTOMLEFT", _G.UIParent, "BOTTOMLEFT", 0, fraction*(_G.UIParent:GetHeight());
                elseif(db.expose.direction == 2) then
                                -- DOWN
                                return "BOTTOMLEFT", _G.UIParent, "BOTTOMLEFT", 0, -fraction*(_G.UIParent:GetHeight());
                elseif(db.expose.direction == 3) then
                                -- LEFT
                                return "BOTTOMLEFT", _G.UIParent, "BOTTOMLEFT", -fraction*(_G.UIParent:GetWidth()), 0;
                elseif(db.expose.direction == 4) then
                                -- RIGHT
                                return "BOTTOMLEFT", _G.UIParent, "BOTTOMLEFT", fraction*(_G.UIParent:GetWidth()), 0;
                end
end

local WindowParentAnimTable = {
	totalTime = 0.5,
	updateFunc = "SetPoint",
	getPosFunc = WindowParent_AnimPos,
	}

local function WindowParent_AnimFinished(self)
	self.animFinished = true;
        if(self.animUp) then
                self:Hide();
        else
                self:SetPoint("BOTTOMLEFT", _G.UIParent, "BOTTOMLEFT", 0, 0);
                self:SetWidth(_G.UIParent:GetWidth());
                self:SetHeight(_G.UIParent:GetHeight());
        end
        for i=1, #WindowSoupBowl.windows do
		local win = WindowSoupBowl.windows[i].obj;
                win:SetClampedToScreen(not self.animUp and db.clampToScreen);
                if(win:IsVisible()) then
                                WIM.CallModuleFunction("OnWindowShow", win);
                end
	end
end

function ShowContainer(animate)
                if(not WindowParent.animUp) then
                                return;
                end
                WindowParent:Show();
                WindowParent.animUp = false;
                if(animate) then
                                WindowParentAnimTable.totalTime = 0.3;
                else
                                WindowParentAnimTable.totalTime = 0;
                end
                WindowParent.animFinished = false;
                WindowParent.inSequence = true;
                --[[for i=1, #WindowSoupBowl.windows do
                                local win = WindowSoupBowl.windows[i].obj;
                                win:SetClampedToScreen(false);
                                local left, top = win:SafeGetLeft(), win:SafeGetTop()*win:GetScale();
                                win:ClearAllPoints();
                                win:SetPoint("TOPLEFT", WindowParent, "BOTTOMLEFT", left, top);
                                win:SetClampedToScreen(false);
                end]]
                if(animate) then
                                WIM.SetUpAnimation(WindowParent, WindowParentAnimTable, WindowParent_AnimFinished, true);
                else
                                WindowParent:SetPoint(WindowParent_AnimPos(WindowParent, 100));
                                WindowParent_AnimFinished(WindowParent);
                end
                WIM.CallModuleFunction("OnContainerShow");
end

function HideContainer(animate)
                if(WindowParent.animUp) then
                                return;
                end
                WindowParent.animUp = true;
                if(animate) then
                                WindowParentAnimTable.totalTime = 0.3;
                else
                                WindowParentAnimTable.totalTime = 0;
                end
                WindowParent.animFinished = false;
                WindowParent.inSequence = true;
                for i=1, #WindowSoupBowl.windows do
                                local win = WindowSoupBowl.windows[i].obj;
                                win:SetClampedToScreen(false);
                                local left, top = win:SafeGetLeft(), win:SafeGetTop();
                                win:ClearAllPoints();
                                win:SetPoint("TOPLEFT", WindowParent, "BOTTOMLEFT", left, top);
                                win:SetClampedToScreen(false);
                end
                if(animate) then
                                WIM.SetUpAnimation(WindowParent, WindowParentAnimTable, WindowParent_AnimFinished, false);
                else
                                WindowParent:SetPoint(WindowParent_AnimPos(WindowParent, 0));
                                WindowParent_AnimFinished(WindowParent);
                end
                WIM.CallModuleFunction("OnContainerHide");
end

function ToggleContainer(animate)
                if(WindowParent.animUp) then
                                ShowContainer(animate);
                else
                                HideContainer(animate);
                end
end


----------------------------------
-- Set default widget triggers	--
----------------------------------

RegisterWidgetTrigger("close", "whisper,chat,w2w", "OnEnter", function(self)
		if(db.showToolTips == true) then
			_G.GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT");
			_G.GameTooltip:SetText(L["<Shift-Click> to close window."]);
		end
	end);
	
RegisterWidgetTrigger("close", "whisper,chat,w2w", "OnLeave", function(self) _G.GameTooltip:Hide(); end);
	
RegisterWidgetTrigger("close", "whisper,chat,w2w,demo", "OnClick", function(self)
		if(IsShiftKeyDown() or self.forceShift or self.parentWindow.type == "demo") then
                        self.forceShift = false;
			destroyWindow(self:GetParent());
		else
			DisplayTutorial(L["Message Window Hidden"], L["WIM's message window has been hidden to WIM's Minimap Icon. If you want to end a conversation, you may do so by <Shift-Clicking> the close button."]);
			self:GetParent():Hide(true);
		end
	end);
	
RegisterWidgetTrigger("close", "whisper,chat,w2w", "OnUpdate", function(self)
                local SelectedSkin = WIM:GetSelectedSkin();
		if(GetMouseFocus() == self) then
			if(IsShiftKeyDown() and self.curTextureIndex == 1) then
				self:SetNormalTexture(SelectedSkin.message_window.widgets.close.state_close.NormalTexture);
				self:SetPushedTexture(SelectedSkin.message_window.widgets.close.state_close.PushedTexture);
				self:SetHighlightTexture(SelectedSkin.message_window.widgets.close.state_close.HighlightTexture, SelectedSkin.message_window.widgets.close.state_close.HighlightAlphaMode);
				self.curTextureIndex = 2;
			elseif(not IsShiftKeyDown() and self.curTextureIndex == 2) then
				self:SetNormalTexture(SelectedSkin.message_window.widgets.close.state_hide.NormalTexture);
				self:SetPushedTexture(SelectedSkin.message_window.widgets.close.state_hide.PushedTexture);
				self:SetHighlightTexture(SelectedSkin.message_window.widgets.close.state_hide.HighlightTexture, SelectedSkin.message_window.widgets.close.state_hide.HighlightAlphaMode);
				self.curTextureIndex = 1;
			end
		elseif(self.curTextureIndex == 2) then
			self:SetNormalTexture(SelectedSkin.message_window.widgets.close.state_hide.NormalTexture);
			self:SetPushedTexture(SelectedSkin.message_window.widgets.close.state_hide.PushedTexture);
			self:SetHighlightTexture(SelectedSkin.message_window.widgets.close.state_hide.HighlightTexture, SelectedSkin.message_window.widgets.close.state_hide.HighlightAlphaMode);
			self.curTextureIndex = 1;
		end
	end);

RegisterWidgetTrigger("scroll_up", "whisper,chat,w2w", "OnClick", function(self)
		local obj = self:GetParent();
		if( _G.IsControlKeyDown() ) then
			obj.widgets.chat_display:ScrollToTop();
		else
			if( _G.IsShiftKeyDown() ) then
			    obj.widgets.chat_display:PageUp();
			else
			    obj.widgets.chat_display:ScrollUp();
			end
		end
		updateScrollBars(obj);
	end);

RegisterWidgetTrigger("scroll_down", "whisper,chat,w2w", "OnClick", function(self)
		local obj = self:GetParent();
		if( _G.IsControlKeyDown() ) then
			obj.widgets.chat_display:ScrollToBottom();
		else
			if( _G.IsShiftKeyDown() ) then
			    obj.widgets.chat_display:PageDown();
			else
			    obj.widgets.chat_display:ScrollDown();
			end
		end
		updateScrollBars(obj);
	end);

RegisterWidgetTrigger("chat_display", "whisper,chat,w2w", "OnMouseWheel", function(self, ...)
	    if(select(1, ...) > 0) then
		if( _G.IsControlKeyDown() ) then
		    self:ScrollToTop();
		else
		    if( _G.IsShiftKeyDown() ) then
			self:PageUp();
		    else
			self:ScrollUp();
		    end
		end
	    else
		if( _G.IsControlKeyDown() ) then
		    self:ScrollToBottom();
		else
		    if( _G.IsShiftKeyDown() ) then
	                self:PageDown();
		    else
			self:ScrollDown();
		    end
		end
	    end
	    updateScrollBars(getParentMessageWindow(self));
	end);

RegisterWidgetTrigger("chat_display", "whisper,chat,w2w,demo", "OnMouseDown", function(self)
                self:GetParent().prevLeft = self:GetParent():SafeGetLeft();
                self:GetParent().prevTop = self:GetParent():SafeGetTop();
                MessageWindow_MovementControler_OnDragStart(self);
	end);

RegisterWidgetTrigger("chat_display", "whisper,chat,w2w,demo", "OnMouseUp", function(self)
                MessageWindow_MovementControler_OnDragStop(self);
                if(self.parentWindow ~= DemoWindow) then
                        self:Hide();
                        self:Show();
                end
                if(self:GetParent().prevLeft == self:GetParent():SafeGetLeft() and self:GetParent().prevTop == self:GetParent():SafeGetTop() and self.parentWindow ~= DemoWindow) then
                        --[ Frame was clicked not dragged
                        local msg_box = self:GetParent().widgets.msg_box;
                        if(EditBoxInFocus == nil) then
                            msg_box:SetFocus();
                        else
                            if(EditBoxInFocus == msg_box) then
                        	msg_box:Hide();
                        	msg_box:Show();
                            else
                        	msg_box:SetFocus();
                            end
                        end
                end
	end);


RegisterWidgetTrigger("chat_display", "whisper,chat,w2w", "OnHyperlinkClick", function(self, ...) _G.SetItemRef(...); end);
RegisterWidgetTrigger("chat_display", "whisper,chat,w2w","OnMessageScrollChanged", function(self) updateScrollBars(self:GetParent()); end);

RegisterWidgetTrigger("chat_display", "whisper,chat,w2w", "OnHyperlinkEnter", function(self, link)
			local obj = self.parentWindow;
			obj.isOnHyperLink = true;
                        if(db.hoverLinks) then
                                local t = string.match(link, "^(.-):")
                                if(t == "item" or t == "enchant" or t == "spell" or t == "quest") then
                                	_G.ShowUIPanel(_G.GameTooltip);
                                	_G.GameTooltip:SetOwner(_G.UIParent, "ANCHOR_CURSOR");
                                	_G.GameTooltip:SetHyperlink(link);
                                	_G.GameTooltip:Show();
                                end
                        end
		end)
		
RegisterWidgetTrigger("chat_display", "whisper,chat,w2w", "OnHyperlinkLeave", function(self, link)
			local obj = self.parentWindow;
			obj.isOnHyperLink = false;
                        if(db.hoverLinks) then
                                local t = string.match(link, "^(.-):")
                                if(t == "item" or t == "enchant" or t == "spell" or t == "quest") then
                                        _G.HideUIPanel(_G.GameTooltip);
                                end
                        end
		end)

RegisterWidgetTrigger("msg_box", "whisper,chat,w2w,demo", "OnEnterPressed", function(self)
		if(strsub(self:GetText(), 1, 1) == "/") then
			EditBoxInFocus = nil;
			_G.ChatFrame1EditBox:SetText(self:GetText());
			_G.ChatEdit_SendText(_G.ChatFrame1EditBox, 1);
			self:SetText("");
			EditBoxInFocus = self;
		else
                        if(self:GetText() == "") then
				self:Hide();
				self:Show();
                                return;
			end
                end
                -- keep focus or not
                if(self:GetParent():GetRuleSet().keepfocus) then
                        self:SetFocus();
                else
                        self:Hide();
			self:Show();
                end
                
	end);
	
RegisterWidgetTrigger("msg_box", "whisper,chat,w2w,demo", "OnEscapePressed", function(self)
		self:SetText("");
		self:Hide();
		self:Show();
	end);
	
RegisterWidgetTrigger("msg_box", "whisper,chat,w2w,demo", "OnUpdate", function(self)
		if(self.setText == 1) then
			self.setText = 0;
			self:SetText(self.textToSet or "");
                        self.textToSet = "";
		end
	end);
	
RegisterWidgetTrigger("msg_box", "whisper,chat,w2w", "OnEditFocusGained", function(self)
                                EditBoxInFocus = self;
                                --_G.ACTIVE_CHAT_EDIT_BOX = self; -- preserve linking abilities.
                end);
RegisterWidgetTrigger("msg_box", "whisper,chat,w2w", "OnEditFocusLost", function(self)
                                EditBoxInFocus = nil;
                                --_G.ACTIVE_CHAT_EDIT_BOX = nil;
                end);
RegisterWidgetTrigger("msg_box", "whisper,chat,w2w", "OnMouseUp", function(self, button)
                                _G.CloseDropDownMenus();
                                if(button == "RightButton") then
                                                PopContextMenu("MENU_MSGBOX", self);
                                else
                                                DisplayTutorial(L["Right-Mouse Click!"], L["There might be useful tools hidden under the message box. Right-Click to see them!"]);
                                end
                end);
RegisterWidgetTrigger("msg_box", "whisper,chat,w2w", "OnMouseDown", function(self, button)
                                MSG_CONTEXT_MENU_EDITBOX = self;
                end);

RegisterWidgetTrigger("msg_box", "whisper,w2w", "OnTabPressed", function(self)
                if(db.tabAdvance and not _G.IsShiftKeyDown()) then
                		-- Get the current whisper target
                		local whisperTarget = getParentMessageWindow(self).theUser
                		-- Lookup the next whisper target
                		local nextWhisperTarget = _G.ChatEdit_GetNextTellTarget(whisperTarget)
                
                		if nextWhisperTarget ~= "" then
                			local win = GetWhisperWindowByUser(nextWhisperTarget);
                			win:Hide();
                			win:Pop(true); -- force popup
                			win.widgets.msg_box:SetFocus();
                			_G.ChatEdit_SetLastTellTarget(nextWhisperTarget);
                		end
                end
	end);


-- handle formatting options.
local function applyBracket(index)
                if(db.formatting.bracketing.enabled) then
                                local tbl = lists.bracketing[db.formatting.bracketing.type];
                                return tbl[(index or 1)];
                else
                                return "";
                end
end

RegisterMessageFormatting(L["Default"], function(smf, event, ...)
		local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = ...;
                arg11 = arg11 or 0;
                local doColoredNames = constants.classes.GetColoredNameByChatEvent;
		if(event == "CHAT_MSG_WHISPER") then
			return applyBracket().."|Hplayer:"..arg2..":"..arg11.."|h"..(db.coloredNames and doColoredNames(event, ...) or arg2).."|h"..applyBracket(2)..": "..arg1;
		elseif(event == "CHAT_MSG_WHISPER_INFORM") then
                        arg11 = arg11 or 0;
			return applyBracket().."|Hplayer:".._G.UnitName("player")..":"..arg11.."|h"..(db.coloredNames and constants.classes.GetMyColoredName() or _G.UnitName("player")).."|h"..applyBracket(2)..": "..arg1;
                elseif(event == "CHAT_MSG_BN_WHISPER") then
                        local win = smf.parentWindow;
                        local color;
                        if(win.bn.client == "WoW" and constants.classes[win.bn.class] and constants.classes[win.bn.class].color) then
                                color = constants.classes[win.bn.class].color
                                color = string.len(color) == 6 and color or nil;
                        end
			return applyBracket().."|Hplayer:"..arg2..":"..arg11.."|h"..(db.coloredNames and color and "|cff"..color..arg2.."|r" or arg2).."|h"..applyBracket(2)..": "..arg1;
		elseif(event == "CHAT_MSG_BN_WHISPER_INFORM") then
                        arg11 = arg11 or 0;
			return applyBracket().."|Hplayer:".._G.UnitName("player")..":"..arg11.."|h"..(db.coloredNames and constants.classes.GetMyColoredName() or _G.UnitName("player")).."|h"..applyBracket(2)..": "..arg1;
                elseif(event == "CHAT_MSG_AFK") then
                        return _G.format(L["%s is Away From Keyboard: %s"], applyBracket().."|Hplayer:"..arg2..":"..arg11.."|h"..arg2.."|h"..applyBracket(2), arg1);
                elseif(event == "CHAT_MSG_DND") then
                        return _G.format(L["%s does not wish to be disturbed: %s"], applyBracket().."|Hplayer:"..arg2..":"..arg11.."|h"..arg2.."|h"..applyBracket(2), arg1);
                elseif(event == "CHAT_MSG_GUILD" or event == "CHAT_MSG_OFFICER" or event == "CHAT_MSG_PARTY" or
                                event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" or event == "CHAT_MSG_SAY" or event == "CHAT_MSG_PARTY_LEADER" or
                                event == "CHAT_MSG_CHANNEL" or event == "CHAT_MSG_BATTLEGROUND" or event == "CHAT_MSG_BATTLEGROUND_LEADER") then
                        return applyBracket().."|Hplayer:"..arg2..":"..arg11.."|h"..(db.coloredNames and doColoredNames(event, ...) or arg2).."|h"..applyBracket(2)..": "..arg1;
                elseif(event == "CHAT_MSG_RAID_WARNING") then
                        return _G.RAID_WARNING.." "..applyBracket().."|Hplayer:"..arg2..":"..arg11.."|h"..(db.coloredNames and doColoredNames(event, ...) or arg2).."|h"..applyBracket(2)..": "..arg1;
                elseif(event == "CHAT_MSG_CHANNEL_JOIN") then
                        return string.format(_G.CHAT_CHANNEL_JOIN_GET, arg2);
                elseif(event == "CHAT_MSG_CHANNEL_LEAVE") then
                        return string.format(_G.CHAT_CHANNEL_LEAVE_GET, arg2);
                elseif(event == "CHAT_MSG_CHANNEL_NOTICE_USER") then
                        if(_G.strlen(arg5) > 0) then
				-- TWO users in this notice (E.G. x kicked y)
				return _G.format(_G["CHAT_"..arg1.."_NOTICE"], arg8, arg4, arg2, arg5);
			elseif ( arg1 == "INVITE" ) then
				return _G.format(_G["CHAT_"..arg1.."_NOTICE"], arg4, arg2);
			else
				return _G.format(_G["CHAT_"..arg1.."_NOTICE"], arg8, arg4, arg2);
			end
		elseif(event == "CHAT_MSG_CHANNEL_NOTICE") then
                        return _G.format(_G["CHAT_"..arg1.."_NOTICE"], arg8, arg4);
                else
			return "Unknown event received...";
		end
	end);



-- handle escape to close windows
local escapeFrame = CreateFrame("Frame", "WIM_SpecialWindowMonitor")
table.insert(_G.UISpecialFrames, "WIM_SpecialWindowMonitor");
escapeFrame.Hide = function(self)
                if(WindowParent.animUp or not (db and db.escapeToHide)) then
                                return nil; -- don't close windows if WindowParent is in use.
                end
                -- lets do some checks first shall we?
                local stack = _G.debugstack(1);
		if(stack:match("TOGGLEWORLDMAP")) then
				-- we do not want to close the windows.
                                return;
		elseif(stack:match("UIParent_OnEvent")) then
				-- need some checks here. we want to close the windows at some point...
                                return;
		end
                for i=1, #WindowSoupBowl.windows do
                                local win = WindowSoupBowl.windows[i].obj;
                                if(win:IsShown()) then
                                                win:Hide();
                                end
                end
end
escapeFrame.IsShown = function(self)
                if(WindowParent.animUp or not (db and db.escapeToHide)) then
                                return nil; -- don't close windows if WindowParent is in use.
                end
                for i=1, #WindowSoupBowl.windows do
                                local win = WindowSoupBowl.windows[i].obj;
                                if(win:IsVisible()) then
                                                return 1;
                                end
                end
                return nil;
end
escapeFrame:Show();


-- define context menu
local info = _G.UIDropDownMenu_CreateInfo();
info.text = "MENU_MSGBOX";
local msgBoxMenu = AddContextMenu(info.text, info);
                local info = _G.UIDropDownMenu_CreateInfo();
                info.text = _G.CANCEL;
                info.notCheckable = true;
                info.func = function() _G.CloseDropDownMenus(); end
                msgBoxMenu:AddSubItem(AddContextMenu("MENU_CANCEL", info));
