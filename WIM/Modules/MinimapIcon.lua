local WIM = WIM;

-- imports
local _G = _G;
local CreateFrame = CreateFrame;
local math = math;
local table = table;
local pairs = pairs;
local string = string;
local GetMouseFocus = GetMouseFocus;
local IsShiftKeyDown = IsShiftKeyDown;

-- set namespace
setfenv(1, WIM);

local MinimapIcon = CreateModule("MinimapIcon", true);

db_defaults.minimap = {
    position = 200,
    rightClickNew = false,
    free = false,
    free_position = {
        point = "CENTER",
        x = 0,
        y = 0
    }
};

Notifications = {};	-- list of current notifications
local NotificationIndex = 1;	-- index for update messages
local Notification_Bowl = {};

local colorEnabled = "!000000";
local colorDisabled = "!c41f3b";
local IconColor = colorEnabled;
local icon;

local function getNotificationTable(tag)
    local i;
    local emptyNote;
    for i=1, #Notification_Bowl do
        if(Notification_Bowl[i].tag == "") then
            emptyNote = Notification_Bowl[i];
        end
        if(Notification_Bowl[i].tag == tag) then
            return Notification_Bowl[i];
        end
    end
    if(not emptyNote) then
        local note = {tag=tag};
        table.insert(Notification_Bowl, note);
        return note;
    else
        return emptyNote;
    end
end

local function pushNote(tag, color, num, desc)
    if(tag) then
        if(tag == "") then
            return;
        else
            local note = getNotificationTable(tag);
            note.color, note.text, note.desc = color, num, (desc or "");
            if(not note.index) then
                table.insert(Notifications, note);
                note.index = #Notifications;
            end
        end
        if(WIM.MinimapIcon) then
            WIM.MinimapIcon.flash:Show();
        end
    end
end

local function popNote(tag)
    local i, note;
    for i=1, #Notifications do
        if(Notifications[i].tag == tag) then
            local note = Notifications[i];
            table.remove(Notifications, i);
            for key, _ in pairs(note) do
                note[key] = nil;
            end
            return;
        end
    end
end

----------------------------------------------
--          Minimap Icon Creation           --
----------------------------------------------

local function toggleMenu(parent)
    Menu:ClearAllPoints();
    if(Menu:IsShown()) then
        Menu:Hide();
    else
        Menu:SetPoint("TOPRIGHT", parent, "BOTTOMLEFT", 20, 20);
        Menu:Show();
    end
end


local function getFreePoints(x, y)
    local scale = _G.UIParent:GetEffectiveScale();
    local width = _G.UIParent:GetWidth()*scale;
    local height = _G.UIParent:GetHeight()*scale;
    local point;
    
    -- set limits to cursor position. We want to stay on the screen.
    x = math.min(width, math.max(x, 0));
    y = math.min(height, math.max(y, 0));
    
    --determine TOP or BOTTOM
    if(y > height/2) then
        point = "TOP";
        y = y - height;
    else
        point = "BOTTOM";
    end
    
    --determine LEFT or RIGHT
    if(x < width/2) then
        point = point.."LEFT";
    else
        point = point.."RIGHT";
        x = x - width;
    end
    
    return point, x, y;
end


local function createMinimapIcon()
    local icon = CreateFrame('Button', 'WIM3MinimapButton');
    icon.Load = function(self)
        self:SetFrameStrata('MEDIUM');
	self:SetWidth(31); self:SetHeight(31);
	self:SetFrameLevel(8);
        self:SetMovable(true);
	self:RegisterForClicks('LeftButtonUp', "RightButtonUp");
	self:SetHighlightTexture('Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight');

	local overlay = self:CreateTexture(nil, 'OVERLAY');
	overlay:SetWidth(53); overlay:SetHeight(53);
	overlay:SetTexture('Interface\\Minimap\\MiniMap-TrackingBorder');
	overlay:SetPoint('TOPLEFT');

	local bg = self:CreateTexture(nil, 'BACKGROUND');
	bg:SetWidth(20); bg:SetHeight(20);
	bg:SetTexture('Interface\\CharacterFrame\\TempPortraitAlphaMask');
	bg:SetPoint("TOPLEFT", 6, -6)
	self.backGround = bg;

	local text = self:CreateFontString(nil, "BACKGROUND");
	text:SetFont("Fonts\\SKURRI.ttf", 16);
	text:SetAllPoints(bg);
	text:SetText("");
	self.text = text;

	local ticon = self:CreateTexture(nil, 'BORDER');
	ticon:SetWidth(20); ticon:SetHeight(20);
	ticon:SetTexture('Interface\\AddOns\\'..addonTocName..'\\Skins\\Default\\minimap');
	ticon:SetTexCoord(0.05, 0.95, 0.05, 0.95);
	ticon:SetPoint("TOPLEFT", 6, -5)
	self.icon = ticon;

	local flash = CreateFrame("Frame", "WIM3MinimapButtonFlash", self);
	flash:SetFrameStrata('MEDIUM');
	flash:SetParent(self);
	flash:SetAllPoints(self);
	flash:Show();
	flash.texture = flash:CreateTexture(nil, "BORDER");
	flash.texture:SetTexture('Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight');
	flash.OnUpdate = function(self, elapsed)
			    self.timeElapsed = (self.timeElapsed or 0) + elapsed;
			    while(self.timeElapsed > 1) do
				local minimap = self:GetParent();
				if(NotificationIndex > #Notifications or not Notifications[NotificationIndex]) then
				    minimap.icon:Show();
				    minimap.backGround:SetGradient("VERTICAL", getGradientFromColor(IconColor));
				    minimap.text:Hide();
				    NotificationIndex = 0; -- will be incremented at end of loop
				else
				    minimap:SetText(Notifications[NotificationIndex].text);
				    minimap.backGround:SetGradient("VERTICAL", getGradientFromColor(Notifications[NotificationIndex].color));
				    minimap.text:Show();
				    minimap.icon:Hide();
				end
				self.timeElapsed = 0;
				NotificationIndex = NotificationIndex + 1
			    end
			    if(#Notifications == 0) then
				NotificationIndex = 1;
				self.timeElapsed = 0;
				local minimap = self:GetParent();
				minimap.text:Hide();
				minimap.icon:Show();
				minimap.backGround:SetGradient("VERTICAL", getGradientFromColor(IconColor));
				flash:Hide();
			    end
			end
	flash:SetScript("OnUpdate", flash.OnUpdate);
        icon.flash = flash;


	self:SetScript('OnEnter', self.OnEnter);
	self:SetScript('OnLeave', self.OnLeave);
	self:SetScript('OnClick', self.OnClick);
	self:SetScript('OnDragStart', self.OnDragStart);
	self:SetScript('OnDragStop', self.OnDragStop);
	self:SetScript('OnMouseDown', self.OnMouseDown);
	self:SetScript('OnMouseUp', self.OnMouseUp);
    end
    icon.SetText = function(self, text)
	text = text or "";
	local font, _, _ = icon.text:GetFont();
	if(string.len(text) == 1) then
	    icon.text:SetFont(font, 16);
	elseif(string.len(text) == 2) then
	    icon.text:SetFont(font, 14);
	else
	    icon.text:SetFont(font, 12);
	end
	icon.text:SetText(text);
    end
    icon.OnClick = function(self, button)
        if(button == "LeftButton") then
            toggleMenu(self);
        else
            if(db.minimap.rightClickNew) then
                if(_G.IsShiftKeyDown()) then
                    -- display tools menu
                    PopContextMenu("MENU_MINIMAP", "WIM3MinimapButton");
                else
                    ShowAllUnreadWindows();
                end
            else
                if(_G.IsShiftKeyDown()) then
                    ShowAllUnreadWindows();
                else
                    -- display tools menu
                    PopContextMenu("MENU_MINIMAP", "WIM3MinimapButton");
                end
            end
        end
    end
    icon.OnMouseDown = function(self)
        self.icon:SetTexCoord(0, 1, 0, 1);
    end
    icon.OnMouseUp = function(self)
        self.icon:SetTexCoord(0.05, 0.95, 0.05, 0.95);
    end
    icon.OnEnter = function(self)
        
    end
    icon.OnLeave = function(self)
        
    end
    icon.OnDragStart = function(self)
        self.dragging = true;
	self:LockHighlight();
	self.icon:SetTexCoord(0, 1, 0, 1);
        self:SetScript('OnUpdate', self.OnUpdate);
	_G.GameTooltip:Hide();
    end
    icon.OnDragStop = function(self)
        self.dragging = nil;
	self:SetScript('OnUpdate', nil);
	self.icon:SetTexCoord(0.05, 0.95, 0.05, 0.95);
	self:UnlockHighlight();
        self.registeredForDrag = nil;
        self:RegisterForDrag();
    end
    icon.OnUpdate = function(self)
        local mx, my = _G.Minimap:GetCenter();
	local px, py = _G.GetCursorPosition();
	local scale = _G.Minimap:GetEffectiveScale();

        if(db.minimap.free) then
            local free = db.minimap.free_position;
            free.point, free.x, free.y = getFreePoints(px, py);
        else
            px, py = px / scale, py / scale;
            db.minimap.position = math.deg(math.atan2(py - my, px - mx)) % 360;
        end
	self:UpdatePosition();
    end
    icon.UpdatePosition = function(self)
        if(db.minimap.free) then
            local free = db.minimap.free_position;
            self:SetFrameStrata("DIALOG");
            self:SetParent(_G.UIParent);
            self:ClearAllPoints();
            local scale = _G.UIParent:GetEffectiveScale();
            self:SetPoint("CENTER", _G.UIParent, free.point, free.x/scale, free.y/scale)
        else
            self:SetFrameStrata("BACKGROUND");
            self:SetParent(_G.Minimap);
            self:SetFrameLevel(8);
            local angle = math.rad(db.minimap.position or random(0, 360));
            local cos = math.cos(angle);
            local sin = math.sin(angle);
            local minimapShape = _G.GetMinimapShape and _G.GetMinimapShape() or 'ROUND';

            local round = false;
            if minimapShape == 'ROUND' then
		round = true;
            elseif minimapShape == 'SQUARE' then
            	round = false;
            elseif minimapShape == 'CORNER-TOPRIGHT' then
		round = not(cos < 0 or sin < 0);
            elseif minimapShape == 'CORNER-TOPLEFT' then
		round = not(cos > 0 or sin < 0);
            elseif minimapShape == 'CORNER-BOTTOMRIGHT' then
		round = not(cos < 0 or sin > 0);
            elseif minimapShape == 'CORNER-BOTTOMLEFT' then
		round = not(cos > 0 or sin > 0);
            elseif minimapShape == 'SIDE-LEFT' then
		round = cos <= 0;
            elseif minimapShape == 'SIDE-RIGHT' then
		round = cos >= 0;
            elseif minimapShape == 'SIDE-TOP' then
		round = sin <= 0;
            elseif minimapShape == 'SIDE-BOTTOM' then
		round = sin >= 0;
            elseif minimapShape == 'TRICORNER-TOPRIGHT' then
		round = not(cos < 0 and sin > 0);
            elseif minimapShape == 'TRICORNER-TOPLEFT' then
		round = not(cos > 0 and sin > 0);
            elseif minimapShape == 'TRICORNER-BOTTOMRIGHT' then
		round = not(cos < 0 and sin < 0);
            elseif minimapShape == 'TRICORNER-BOTTOMLEFT' then
		round = not(cos > 0 and sin < 0);
            end

            local x, y;
            if round then
            	x = cos*80;
            	y = sin*80;
            else
            	x = math.max(-82, math.min(110*cos, 84));
            	y = math.max(-86, math.min(110*sin, 82));
            end

            self:ClearAllPoints();
            self:SetPoint('CENTER', x, y);
            local free = db.minimap.free_position;
            local scale = self:GetEffectiveScale();
            free.point, free.x, free.y = getFreePoints((self:GetLeft() + self:GetWidth()/2)*scale, (self:GetTop() - self:GetHeight()/2)*scale);
        end
    end
    icon:Load();
    
    local helperFrame = _G.CreateFrame("Frame");
    helperFrame:SetScript("OnUpdate", function(self)
            if(not icon.dragging and not icon.registeredForDrag and IsShiftKeyDown() and GetMouseFocus() == icon) then
                icon.registeredForDrag = true;
                icon:RegisterForDrag('LeftButton');
            end
        end);
    
    
    dPrint("MinimapIcon Created...");
    return icon;
end


function MinimapIcon:OnEnableWIM()
    IconColor = colorEnabled;
    if(WIM.MinimapIcon) then
        WIM.MinimapIcon.icon:SetAlpha(1);
        WIM.MinimapIcon.flash:Show();
    end
    local menu = GetContextMenu("ENABLE_DISABLE_WIM");
    menu.text = L["Disable"].." WIM";
    dPrint("enable event received");
end

function MinimapIcon:OnDisableWIM()
    IconColor = colorDisabled;
    if(WIM.MinimapIcon) then
        WIM.MinimapIcon.icon:SetAlpha(.75);
        WIM.MinimapIcon.flash:Show();
    end
    local menu = GetContextMenu("ENABLE_DISABLE_WIM");
    menu.text = L["Enable"].." WIM";
    dPrint("disable event received");
end

function MinimapIcon:OnEnable()
    if(icon) then
        -- display icon
        icon:Show();
        icon:UpdatePosition();
    else
        -- create icon
        icon = createMinimapIcon();
        MinimapIcon:OnEnable();
    end
    WIM.MinimapIcon = icon;
    if(WIM.db.enabled) then
        MinimapIcon:OnEnableWIM();
    else
        MinimapIcon:OnDisableWIM();
    end
end

function MinimapIcon:OnDisable()
    if(db.modules.MinimapIcon.enabled) then
        return;
    end
    if(icon) then
        icon:Hide();
    end
    WIM.MinimapIcon = nil;
end


--------------------------------------
--      Right Click Menu            --
--------------------------------------
local info = _G.UIDropDownMenu_CreateInfo();
info.text = "MENU_MINIMAP";
local minimapMenu = AddContextMenu(info.text, info);
    --show unread messages
    info = _G.UIDropDownMenu_CreateInfo();
    info.text = L["Show All Windows"];
    info.func = function() ShowAllWindows(); end;
    info.notCheckable = true;
    minimapMenu:AddSubItem(AddContextMenu("SHOW_ALL_WINDOWS", info));
    --show unread messages
    info = _G.UIDropDownMenu_CreateInfo();
    info.text = L["Hide All Windows"];
    info.func = function() HideAllWindows(); end;
    info.notCheckable = true;
    minimapMenu:AddSubItem(AddContextMenu("HIDE_ALL_WINDOWS", info));
    --show unread messages
    info = _G.UIDropDownMenu_CreateInfo();
    info.text = L["Show Unread Messages"];
    info.func = function() ShowAllUnreadWindows(); end;
    info.notCheckable = true;
    minimapMenu:AddSubItem(AddContextMenu("SHOW_UNREAD_MESSAGES", info));
    -- add space
    info = GetContextMenu("MENU_SPACE") or _G.UIDropDownMenu_CreateInfo();
    info.text = "";
    info.isTitle = true;
    info.notCheckable = true;
    minimapMenu:AddSubItem(AddContextMenu("MENU_SPACE", info));
    -- history viewer
    info = _G.UIDropDownMenu_CreateInfo();
    info.text = L["History Viewer"];
    info.func = function() ShowHistoryViewer() end;
    info.notCheckable = true;
    minimapMenu:AddSubItem(AddContextMenu("HISTORY_VIEWER", info));
    -- options
    info = _G.UIDropDownMenu_CreateInfo();
    info.text = L["Options"];
    info.func = ShowOptions;
    info.notCheckable = true;
    minimapMenu:AddSubItem(AddContextMenu("OPTIONS", info));
    -- add space
    info = GetContextMenu("MENU_SPACE") or _G.UIDropDownMenu_CreateInfo();
    info.text = "";
    info.isTitle = true;
    info.notCheckable = true;
    minimapMenu:AddSubItem(AddContextMenu("MENU_SPACE", info));
    --enable disable WIM
    info = _G.UIDropDownMenu_CreateInfo();
    info.text = L["Enable"].." WIM";
    info.func = function() SetEnabled(not db.enabled); end;
    info.notCheckable = true;
    minimapMenu:AddSubItem(AddContextMenu("ENABLE_DISABLE_WIM", info));    

--------------------------------------
--      Global Extensions to WIM    --
--------------------------------------

function MinimapPushAlert(tag, color, numText, description)
    pushNote(tag, color, numText, description);
end

function MinimapPopAlert(tag)
    popNote(tag);
end

