local WIM = WIM;

-- load message window related default settings.
WIM.db_defaults.displayColors = {
		wispIn = {
				r=0.5607843137254902, 
				g=0.03137254901960784, 
				b=0.7607843137254902
			},
		wispOut = {
				r=1, 
				g=0.07843137254901961, 
				b=0.9882352941176471
			},
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
		webAddress = {
				r=0, 
				g=0, 
				b=1
			},
	};
WIM.db_defaults.fontSize = 12;
WIM.db_defaults.windowSize = 1;
WIM.db_defaults.windowAlpha = .8;
WIM.db_defaults.windowOnTop = true;
WIM.db_defaults.windowFade = false;
WIM.db_defaults.keepFocus = true;
WIM.db_defaults.keepFocusRested = true;
WIM.db_defaults.autoFocus = false;
WIM.db_defaults.winSize = {
		width = 384,
		height = 256
	};
WIM.db_defaults.winLoc = {
		left =242 ,
		top =775
	};
WIM.db_defaults.winCascade = {
		enabled = true,
		direction = "downright"
	};


local ShortcutCount = 5;

local ofs = 0.000723339 * (GetScreenHeight()/GetScreenWidth() + 1/3) * 70.4;
local radius = ofs / 1.166666666666667;

local SML = LibStub:GetLibrary("LibSharedMedia-3.0"); -- used for font sharing

-- Window Soup Bowl Table: Used to keep track and recycle old windows.
local WindowSoupBowl = {
    windowToken = 0,
    available = 0,
    used = 0,
    windows = {
    }
}


-- climb up inherritance tree and find parent window recursively.
local function getParentMessageWindow(obj)
    if(obj.isParent) then
        return obj;
    elseif(obj:GetName() == "UIParent") then
        return nil;
    else
        return getParentMessageWindow(obj:GetParent())
    end
end


--------------------------------------
--       Widget Script Handlers     --
--------------------------------------

local function MessageWindow_MovementControler_OnDragStart()
    local window = getParentMessageWindow(this);
    if(window) then
        window:StartMoving();
        window.isMoving = true;
    end
end

local function MessageWindow_MovementControler_OnDragStop()
    local window = getParentMessageWindow(this);
    if(window) then
        window:StopMovingOrSizing();
        window.isMoving = false;
    end
end

local function MessageWindow_FadeControler_OnEnter()
    local window = getParentMessageWindow(this);
    if(window) then
        if(WIM.db.windowFade) then
            -- WIM_FadeIn(window.theUser);
        end
        window.isMouseOver = true;
        window.QueuedToHide = false;
    end
end

local function MessageWindow_FadeControler_OnLeave()
    local window = getParentMessageWindow(this);
    if(window) then
        if(WIM.db.windowFade) then
            if(getglobal(window:GetName().."MsgBox") ~= WIM_EditBoxInFocus) then
                -- WIM_FadeOut(window.theUser);
            else
                window.QueuedToHide = true;
            end
        end
        window.isMouseOver = false;
    end
end

local function MessageWindow_Frame_OnShow()
    local user = this.theUser;
    if(user ~= nil and WIM.windows[user]) then
        WIM.windows[user].newMSG = false;
        WIM.windows[user].is_visible = true;
        if(WIM.db.autoFocus == true) then
    	getglobal(this:GetName().."MsgBox"):SetFocus();
        end
        --WIM_WindowOnShow(this);
        this.QueuedToHide = false;
        --WIM_UpdateScrollBars(getglobal(this:GetName().."ScrollingMessageFrame"));
    end
end

local function MessageWindow_Frame_OnHide()
    local user = this.theUser;
    if(user ~= nil and WIM.windows[user]) then
        --WIM_Tabs.lastParent = nil;
        --WIM_TabStrip:Hide();
        this.isMouseOver = false;
        if(WIM.windows[user]) then
            WIM.windows[user].is_visible = false;
        end
        if ( this.isMoving ) then
    	this:StopMovingOrSizing();
    	this.isMoving = false;
        end
    end
end

local function MessageWindow_Frame_OnUpdate()
    --if(WIM_Tabs.enabled == true) then
    --      WIM_Tabs.x = this:GetLeft();
    --      WIM_Tabs.y = this:GetTop();
    --end
end

local function MessageWindow_ExitButton_OnEnter()
    if(WIM.db.showToolTips == true) then
	GameTooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
	GameTooltip:SetText(WIM_LOCALIZED_TOOLTIP_SHIFT_CLICK_TO_CLOSE);
    end
    MessageWindow_FadeControler_OnEnter();
end

local function MessageWindow_ExitButton_OnLeave()
    GameTooltip:Hide();
    MessageWindow_FadeControler_OnLeave();
end

local function MessageWindow_ExitButton_OnClick()
    if(IsShiftKeyDown()) then
	--WIM_CloseConvo(this:GetParent().theUser);
	-- do some check if tabs are loaded and show next available.
    else
        this:GetParent():Hide();
    end
end

local function MessageWindow_HistoryButton_OnEnter()
    if(WIM.db.showToolTips == true) then
	GameTooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
	GameTooltip:SetText(WIM_LOCALIZED_TOOLTIP_VIEW_HISTORY);
    end
    MessageWindow_FadeControler_OnEnter();
end

local function MessageWindow_HistoryButton_OnLeave()
    GameTooltip:Hide();
    MessageWindow_FadeControler_OnLeave();
end

local function MessageWindow_HistoryButton_OnClick()
    WIM_HistoryView_Name_Selected = this:GetParent().theUser;
    WIM_HistoryView_Filter_Selected = "";
    if(WIM_HistoryFrame:IsVisible()) then
	WIM_HistoryViewNameScrollBar_Update();
	WIM_HistoryViewFiltersScrollBar_Update();
    else
	WIM_HistoryFrame:Show();
    end
end

local function MessageWindow_W2WButton_OnEnter()
    local user = this:GetParent().theUser;
    local theTip = "WIM Version: |cffffffff"..WIM_W2W[user].version.."|r";
    theTip = theTip.."\n"..WIM_W2W_CAPABILITIES..": |cffffffffCoordinates|r";
    if(WIM_W2W[user].spec) then theTip = theTip..",\n|cffffffffTalent Spec|r"; end
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
    GameTooltip:SetText(theTip);
    MessageWindow_FadeControler_OnEnter();
end

local function MessageWindow_W2WButton_OnLeave()
    GameTooltip:Hide();
    MessageWindow_FadeControler_OnLeave();
end

local function MessageWindow_W2WButton_Initialize()
	local info = {};
	
	info = { };
	info.text = "W2W - WIM To WIM";
	info.isTitle = true;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = WIM_W2W_TRACKMINIMAP;
	info.func = MessageWindow_W2WButtomMenu_OnClick;
        info.value = this:GetParent().theUser;
        info.checked = this:GetParent().icon.track;
        info.tooltipTitle = WIM_W2W_TRACKMINIMAP;
        info.tooltipText = WIM_W2W_TRACKMINIMAP_INFO;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end

local function MessageWindow_W2WButtomMenu_OnClick()
    local icon = getglobal(WIM.windows[this.value].frame).icon;
    icon.track = not icon.track;
    if(icon.track) then
        icon:Show();
    else
        icon:Hide();
    end
end

local function MessageWindow_W2WButton_OnClick()
    UIDropDownMenu_Initialize(this:GetParent().w2w_menu, MessageWindow_W2WButton_Initialize, "MENU");
    ToggleDropDownMenu(1, nil, this:GetParent().w2w_menu, this, -130, -1);
end

local function MessageWindow_IsChattingButton_OnEnter()
    if(WIM.db.showToolTips == true) then
	local user = this:GetParent().theUser;
	local theTip = user.." "..WIM_W2W_IS_TYPING;
	GameTooltip:SetOwner(this, "ANCHOR_TOPLEFT");
	GameTooltip:SetText(theTip);
    end
    MessageWindow_FadeControler_OnEnter();
end

local function MessageWindow_IsChattingButton_OnLeave()
    GameTooltip:Hide();
    MessageWindow_FadeControler_OnLeave();
end

local function MessageWindow_IsChattingButton_OnUpdate()
    this.time_elapsed = this.time_elapsed + arg1;
    while(this.time_elapsed > 2) do
	if((time() - this.typing_stamp) > 5) then
	    this:Hide();
	end
	this.time_elapsed = 0;
    end
end

local function MessageWindow_ScrollUp_OnClick()
    if( IsControlKeyDown() ) then
	getglobal(this:GetParent():GetName().."ScrollingMessageFrame"):ScrollToTop();
    else
	if( IsShiftKeyDown() ) then
	    getglobal(this:GetParent():GetName().."ScrollingMessageFrame"):PageUp();
	else
	    getglobal(this:GetParent():GetName().."ScrollingMessageFrame"):ScrollUp();
	end
    end
    updateScrollBars(getglobal(this:GetParent():GetName().."ScrollingMessageFrame"));
end

local function MessageWindow_ScrollDown_OnClick()
    if( IsControlKeyDown() ) then
	getglobal(this:GetParent():GetName().."ScrollingMessageFrame"):ScrollToBottom();
    else
	if( IsShiftKeyDown() ) then
	    getglobal(this:GetParent():GetName().."ScrollingMessageFrame"):PageDown();
	else
	    getglobal(this:GetParent():GetName().."ScrollingMessageFrame"):ScrollDown();
	end
    end
    updateScrollBars(getglobal(this:GetParent():GetName().."ScrollingMessageFrame"));
end

local function MessageWindow_ScrollingMessageFrame_OnMouseWheel()
    if(arg1 > 0) then
	if( IsControlKeyDown() ) then
	    this:ScrollToTop();
	else
	    if( IsShiftKeyDown() ) then
		this:PageUp();
	    else
		this:ScrollUp();
	    end
	end
    else
	if( IsControlKeyDown() ) then
	    this:ScrollToBottom();
	else
	    if( IsShiftKeyDown() ) then
                this:PageDown();
	    else
		this:ScrollDown();
	    end
	end
    end
end

local function MessageWindow_ScrollingMessageFrame_OnMouseDown()
    this:GetParent().prevLeft = this:GetParent():GetLeft();
    this:GetParent().prevTop = this:GetParent():GetTop();
end

local function MessageWindow_ScrollingMessageFrame_OnMouseUp()
    if(this:GetParent().prevLeft == this:GetParent():GetLeft() and this:GetParent().prevTop == this:GetParent():GetTop()) then
	--[ Frame was clicked not dragged
	if(WIM_EditBoxInFocus == nil) then
	    getglobal(this:GetParent():GetName().."MsgBox"):SetFocus();
	else
	    if(WIM_EditBoxInFocus:GetName() == this:GetParent():GetName().."MsgBox") then
		getglobal(this:GetParent():GetName().."MsgBox"):Hide();
		getglobal(this:GetParent():GetName().."MsgBox"):Show();
	    else
		getglobal(this:GetParent():GetName().."MsgBox"):SetFocus();
	    end
	end
    end
end

local function MessageWindow_MsgBox_OnMouseUp()
    CloseDropDownMenus();
    if(arg1 == "RightButton") then
        WIM_MSGBOX_MENU_CUR_USER = this:GetParent().theUser;
        UIDropDownMenu_Initialize(WIM_MsgBoxMenu, WIM_MsgBoxMenu_Initialize, "MENU");
        ToggleDropDownMenu(1, nil, WIM_MsgBoxMenu, this, 0, 0);
    end
end

local function MessageWindow_MsgBox_OnEnterPressed()
    local _, tParent = this:GetParent();
						
    if(this:GetText() == "") then
	if(WIM.db.windowFade and this:GetParent().QueuedToHide) then
            --WIM_FadeOut(this:GetParent().theUser);
        end
        this:Hide();
        this:Show();
        return;
    else
        if(WIM.db.windowFade) then
            --WIM_FadeOutDelayed(this:GetParent().theUser);
        end
    end
						
    if(strsub(this:GetText(), 1, 1) == "/") then
        WIM_EditBoxInFocus = nil;
        ChatFrameEditBox:SetText(this:GetText());
        ChatEdit_SendText(ChatFrameEditBox, 1);
        WIM_EditBoxInFocus = this;
    else
        SendChatMessage(this:GetText(), "WHISPER", nil, WIM_ParseNameTag(this:GetParent().theUser));
        this:AddHistoryLine(this:GetText());
    end
    this:SetText("");
    if(not WIM.db.keepFocus) then
        this:Hide();
        this:Show();
    elseif(not IsResting() and WIM.db.keepFocusRested) then
        this:Hide();
        this:Show();
    end
end

local function MessageWindow_MsgBox_OnEscapePressed()
    this:SetText("");
    this:Hide();
    this:Show();
    if(WIM.db.windowFade) then
        --WIM_FadeOut(this:GetParent().theUser);
    end
end

local function MessageWindow_MsgBox_OnTabPressed()
    --cycle through windows
    if(WIM_Tabs.enabled == true) then
        if(IsShiftKeyDown()) then
            WIM_TabStep(-1);
        else
            WIM_TabStep(1);
        end
    else
        WIM_ToggleWindow_Toggle();
    end
end

local function MessageWindow_MsgBox_OnTextChanged()
    if(WIM_W2W[this:GetParent().theUser]) then
	if(not this.w2w_typing) then 
		this.w2w_typing = 0;
	end
	if(this:GetText() ~= "") then
	    if(time() - this.w2w_typing > 2) then
		this.w2w_typing = time();
                if(WIM.db.w2w.typing) then
        	    --WIM_W2W_SendAddonMessage(this:GetParent().theUser , "IS_TYPING#TRUE");
                end
	    end
	else
	    this.w2w_typing = 0;
            if(WIM.db.w2w.typing) then
                --WIM_W2W_SendAddonMessage(this:GetParent().theUser , "IS_TYPING#FALSE");
            end
	end
    end
    --WIM_EditBox_OnChanged();
end

local function MessageWindow_MsgBox_OnUpdate()
    if(this.setText == 1) then
	this.setText = 0;
	this:SetText("");
    end
end







--Returns object, SoupBowl_windows_index or nil if window can not be found.
local function getMessageWindow(userName)
    if(type(userName) ~= "string") then
        return nil;
    end
    for i=1,table.getn(WindowSoupBowl.windows) do
        if(WindowSoupBowl.windows[i].user == userName) then
            return WindowSoupBowl.windows[i].obj, i;
        end
    end
end

local function shouldTrackUser(theUser)
    if(WIM_W2W[theUser]) then
        if(WIM_W2W[theUser].zoneInfo) then
            local astrolabe = WIM.libs.Astrolabe;
            local tmp = WIM_W2W[theUser].zoneInfo;
            local C, Z, x, y = astrolabe:GetCurrentPlayerPosition();
            if((tonumber(tmp.x) == 0 and tonumber(tmp.y == 0)) or (tonumber(x) == 0 or tonumber(y) == 0)) then
                -- do not show on minimap if either the player or myself are in a non-valid instance.
                return false
            else
                -- only show if we are on the same continent.
                if(tonumber(C) == tonumber(tmp.C)) then
                    return true;
                else
                    return false;
                end
            end
        else
            return false;
        end
    else
        return false;
    end
end

local function createMipmapDodad()
    local astrolabe = WIM.libs.Astrolabe;

    local icon = CreateFrame("Button", nil, UIParent);
    icon:SetWidth(16);
    icon:SetHeight(16);
    icon.bg = icon:CreateTexture();
    icon.bg:SetTexture("Interface\\AddOns\\WIM\\Images\\miniEnabled");
    icon.bg:SetDrawLayer("BACKGROUND");
    icon.bg:SetAllPoints();
    icon.bg:Hide();
    icon:SetPoint("CENTER", Minimap, "CENTER", 0, 0);
    
    icon.track = false;
    
    icon.recalc_timeout = 0;
    icon.phase = 0;
    
    icon.arrow = CreateFrame("Model", nil, icon)
    icon.arrow:SetHeight(140.8)
    icon.arrow:SetWidth(140.8)
    icon.arrow:SetPoint("CENTER", Minimap, "CENTER", 0, 0)
    icon.arrow:SetModel("Interface\\Minimap\\Rotating-MinimapArrow.mdx")
    icon.arrow:Hide();
    
    function icon:OnUpdate(elapsed)
      if (icon.track and shouldTrackUser(self.theUser)) then
        
        self:Show()
        
        if self.recalc_timeout <= 0 then
          self.recalc_timeout = 50
          
          astrolabe:PlaceIconOnMinimap(self, tonumber(WIM_W2W[this.theUser].zoneInfo.C), tonumber(WIM_W2W[this.theUser].zoneInfo.Z), tonumber(WIM_W2W[this.theUser].zoneInfo.x), tonumber(WIM_W2W[this.theUser].zoneInfo.y))
        else
          self.recalc_timeout = self.recalc_timeout - 1
        end
        
        local edge = astrolabe:IsIconOnEdge(self)
        
        if edge then
          self.arrow:Show()
          self.bg:Hide()
        else
          self.arrow:Hide()
          self.bg:Show()
        end
        
        if edge then
          local angle = astrolabe:GetDirectionToIcon(self)
          if GetCVar("rotateMinimap") == "1" then
            angle = angle + MiniMapCompassRing:GetFacing()
          end
          
          self.arrow:SetFacing(angle)
          self.arrow:SetPosition(ofs * (137 / 140) - radius * math.sin(angle),
                                 ofs               + radius * math.cos(angle), 0);
          
          if self.phase > 6.283185307179586476925 then
            self.phase = self.phase-6.283185307179586476925+elapsed*3.5
          else
            self.phase = self.phase+elapsed*3.5
          end
          self.arrow:SetModelScale(0.600000023841879+0.1*math.sin(self.phase))
        end
      else
        self:Hide()
      end
    end
    
    function icon:OnEnter()
        WIM_ShortcutFrame_Location_OnEnter(icon.theUser);
    end
    
    function icon:OnLeave()
      GameTooltip:Hide()
    end
    
    function icon:OnClick()
        WIM_PostMessage(this.theUser, "", 5);
    end
    
    icon:SetScript("OnUpdate", icon.OnUpdate)
    icon:SetScript("OnEnter", icon.OnEnter)
    icon:SetScript("OnLeave", icon.OnLeave)
    icon:SetScript("OnClick", icon.OnClick)
    
    icon:RegisterForClicks("LeftButtonUp")
    
    return icon;
end

-- create all of MessageWindow's object children
local function instantiateMessageWindowObj(obj)
    local fName = obj:GetName();
    -- set frame's initial properties
    obj:SetClampedToScreen(true);
    obj:SetFrameStrata("DIALOG");
    obj:SetMovable(true);
    obj:SetToplevel(true);
    obj:SetWidth(384);
    obj:SetHeight(256);
    obj:EnableMouse(true);
    obj:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 25, -125);
    obj:RegisterForDrag("LeftButton");
    obj:SetScript("OnDragStart", function() MessageWindow_MovementControler_OnDragStart(); end);
    obj:SetScript("OnDragStop", function() MessageWindow_MovementControler_OnDragStop(); end);
    obj:SetScript("OnEnter", MessageWindow_FadeControler_OnEnter);
    obj:SetScript("OnLeave", MessageWindow_FadeControler_OnLeave);
    obj:SetScript("OnShow", MessageWindow_Frame_OnShow);
    obj:SetScript("OnHide", MessageWindow_Frame_OnHide);
    obj:SetScript("OnUpdate", MessageWindow_Frame_OnUpdate);
    
    obj.icon = createMipmapDodad(fName);
    
    obj.w2w_menu = CreateFrame("Frame", fName.."W2WMenu", obj, "UIDropDownMenuTemplate");
    obj.w2w_menu:SetClampedToScreen(true);
    
    
    -- add window backdrop frame
    local Backdrop = CreateFrame("Frame", fName.."Backdrop", obj);
    Backdrop:SetToplevel(false);
    Backdrop:SetAllPoints(obj);
    local class_icon = Backdrop:CreateTexture(fName.."BackdropClassIcon", "BACKGROUND");
    local tl = Backdrop:CreateTexture(fName.."Backdrop_TL", "BORDER");
    local tr = Backdrop:CreateTexture(fName.."Backdrop_TR", "BORDER");
    local bl = Backdrop:CreateTexture(fName.."Backdrop_BL", "BORDER");
    local br = Backdrop:CreateTexture(fName.."Backdrop_BR", "BORDER");
    local t  = Backdrop:CreateTexture(fName.."Backdrop_T" , "BORDER");
    local b  = Backdrop:CreateTexture(fName.."Backdrop_B" , "BORDER");
    local l  = Backdrop:CreateTexture(fName.."Backdrop_L" , "BORDER");
    local r  = Backdrop:CreateTexture(fName.."Backdrop_R" , "BORDER");
    local bg = Backdrop:CreateTexture(fName.."Backdrop_BG", "BORDER");
    local from = Backdrop:CreateFontString(fName.."BackdropFrom", "OVERLAY", "GameFontNormalLarge");
    local char_info = Backdrop:CreateFontString(fName.."BackdropCharacterDetails", "OVERLAY", "GameFontNormal");
    
    -- create window objects
    local close = CreateFrame("Button", fName.."ExitButton", obj);
    close:RegisterForClicks("LeftButtonUp", "RightButtonUp");
    close:SetScript("OnEnter", MessageWindow_ExitButton_OnEnter);
    close:SetScript("OnLeave", MessageWindow_ExitButton_OnLeave);
    close:SetScript("OnClick", MessageWindow_ExitButton_OnClick);
    local history = CreateFrame("Button", fName.."HistoryButton", obj);
    history:RegisterForClicks("LeftButtonUp", "RightButtonUp");
    history:SetScript("OnEnter", MessageWindow_HistoryButton_OnEnter);
    history:SetScript("OnLeave", MessageWindow_HistoryButton_OnLeave);
    history:SetScript("OnClick", MessageWindow_HistoryButton_OnClick);
    local w2w = CreateFrame("Button", fName.."W2WButton", obj);
    w2w:RegisterForClicks("LeftButtonUp", "RightButtonUp");
    w2w:SetScript("OnEnter", MessageWindow_W2WButton_OnEnter);
    w2w:SetScript("OnLeave", MessageWindow_W2WButton_OnLeave);
    w2w:SetScript("OnClick", MessageWindow_W2WButton_OnClick);
    local chatting = CreateFrame("Button", fName.."IsChattingButton", obj);
    chatting:RegisterForClicks("LeftButtonUp", "RightButtonUp");
    chatting:SetScript("OnEnter", MessageWindow_IsChattingButton_OnEnter);
    chatting:SetScript("OnLeave", MessageWindow_IsChattingButton_OnLeave);
    chatting:SetScript("OnUpdate", MessageWindow_IsChattingButton_OnUpdate);
    chatting.time_elapsed = 0;
    chatting.typing_stamp = 0;
    local scroll_up = CreateFrame("Button", fName.."ScrollUp", obj);
    scroll_up:RegisterForClicks("LeftButtonUp", "RightButtonUp");
    scroll_up:SetScript("OnEnter", MessageWindow_FadeControler_OnEnter);
    scroll_up:SetScript("OnLeave", MessageWindow_FadeControler_OnLeave);
    scroll_up:SetScript("OnClick", MessageWindow_ScrollUp_OnClick);
    local scroll_down = CreateFrame("Button", fName.."ScrollDown", obj);
    scroll_down:RegisterForClicks("LeftButtonUp", "RightButtonUp");
    scroll_down:SetScript("OnEnter", MessageWindow_FadeControler_OnEnter);
    scroll_down:SetScript("OnLeave", MessageWindow_FadeControler_OnLeave);
    scroll_down:SetScript("OnClick", MessageWindow_ScrollDown_OnClick);
    local chat_display = CreateFrame("ScrollingMessageFrame", fName.."ScrollingMessageFrame", obj);
    chat_display:RegisterForDrag("LeftButton");
    chat_display:SetFading(false);
    chat_display:SetMaxLines(128);
    chat_display:SetMovable(true);
    chat_display:SetScript("OnDragStart", function() MessageWindow_MovementControler_OnDragStart(); end);
    chat_display:SetScript("OnDragStop", function() MessageWindow_MovementControler_OnDragStop(); end);
    chat_display:SetScript("OnMouseWheel", MessageWindow_ScrollingMessageFrame_OnMouseWheel);
    chat_display:SetScript("OnHyperlinkClick", function() ChatFrame_OnHyperlinkShow(arg1, arg2, arg3); end);
    chat_display:SetScript("OnMessageScrollChanged", function() WIM_UpdateScrollBars(this); end);
    chat_display:SetScript("OnMouseDown", MessageWindow_ScrollingMessageFrame_OnMouseDown);
    chat_display:SetScript("OnMouseUp", MessageWindow_ScrollingMessageFrame_OnMouseUp);
    chat_display:SetScript("OnEnter", MessageWindow_FadeControler_OnEnter);
    chat_display:SetScript("OnLeave", MessageWindow_FadeControler_OnLeave);
    chat_display:SetScript("OnHyperlinkEnter", MessageWindow_Hyperlink_OnEnter);
    chat_display:SetScript("OnHyperlinkLeave", MessageWindow_Hyperlink_OnLeave);
    chat_display:SetJustifyH("LEFT");
    chat_display:EnableMouse(true);
    chat_display:EnableMouseWheel(1);
    local msg_box = CreateFrame("EditBox", fName.."MsgBox", obj);
    msg_box:SetAutoFocus(false);
    msg_box:SetHistoryLines(32);
    msg_box:SetMaxLetters(255);
    msg_box:SetAltArrowKeyMode(true);
    msg_box:EnableMouse(true);
    msg_box:SetScript("OnEnterPressed", MessageWindow_MsgBox_OnEnterPressed);
    msg_box:SetScript("OnEscapePressed", MessageWindow_MsgBox_OnEscapePressed);
    msg_box:SetScript("OnTabPressed", MessageWindow_MsgBox_OnTabPressed);
    msg_box:SetScript("OnEditFocusGained", function() WIM_EditBoxInFocus = this; end);
    msg_box:SetScript("OnEditFocusLost", function() WIM_EditBoxInFocus = nil; end);
    msg_box:SetScript("OnEnter", MessageWindow_FadeControler_OnEnter);
    msg_box:SetScript("OnLeave", MessageWindow_FadeControler_OnLeave);
    msg_box:SetScript("OnTextChanged", MessageWindow_MsgBox_OnTextChanged);
    msg_box:SetScript("OnUpdate", MessageWindow_MsgBox_OnUpdate);
    msg_box:SetScript("OnMouseUp", MessageWindow_MsgBox_OnMouseUp);
    
    
    local shortcuts = CreateFrame("Frame", fName.."ShortcutFrame", obj);
    shortcuts:SetToplevel(true);
    shortcuts:SetFrameStrata("DIALOG");
    for i=1,ShortcutCount do
        CreateFrame("Button", fName.."ShortcutFrameButton"..i, shortcuts, "WIM_ShortcutButtonTemplate");
    end

end

local function updateMessageWindowClassIcon(obj)
    local SelectedSkin = WIM:GetSelectedSkin();
    local fName = obj:GetName();
    local class_icon = getglobal(fName.."BackdropClassIcon");
    local coord = SelectedSkin.message_window.class_icon[class_icon.class];
    class_icon:SetTexCoord(coord[1], coord[2], coord[3], coord[4], coord[5], coord[6], coord[7], coord[8]);
end


local function setMessageWindowClass(obj, class)
    local fName = obj:GetName();
    local class_icon = getglobal(fName.."BackdropClassIcon");
    
    local classes = {};
    classes[WIM_LOCALIZED_DRUID]    = "druid";
    classes[WIM_LOCALIZED_HUNTER]   = "hunter";
    classes[WIM_LOCALIZED_MAGE]	    = "mage";
    classes[WIM_LOCALIZED_PALADIN]  = "paladin";
    classes[WIM_LOCALIZED_PRIEST]   = "priest";
    classes[WIM_LOCALIZED_ROGUE]    = "rogue";
    classes[WIM_LOCALIZED_SHAMAN]   = "shaman";
    classes[WIM_LOCALIZED_WARLOCK]  = "warlock";
    classes[WIM_LOCALIZED_WARRIOR]  = "warrior";
    
    classes[WIM_LOCALIZED_DRUID_FEMALE]    = classes[WIM_LOCALIZED_DRUID];
    classes[WIM_LOCALIZED_HUNTER_FEMALE]   = classes[WIM_LOCALIZED_HUNTER];
    classes[WIM_LOCALIZED_MAGE_FEMALE]	   = classes[WIM_LOCALIZED_MAGE];
    classes[WIM_LOCALIZED_PALADIN_FEMALE]  = classes[WIM_LOCALIZED_PALADIN];
    classes[WIM_LOCALIZED_PRIEST_FEMALE]   = classes[WIM_LOCALIZED_PRIEST];
    classes[WIM_LOCALIZED_ROGUE_FEMALE]    = classes[WIM_LOCALIZED_ROGUE];
    classes[WIM_LOCALIZED_SHAMAN_FEMALE]   = classes[WIM_LOCALIZED_SHAMAN];
    classes[WIM_LOCALIZED_WARLOCK_FEMALE]  = classes[WIM_LOCALIZED_WARLOCK];
    classes[WIM_LOCALIZED_WARRIOR_FEMALE]  = classes[WIM_LOCALIZED_WARRIOR];
    
    classes[WIM_LOCALIZED_GM] 	    = "gm";
    
    if(classes[class]) then
        class_icon.class = classes[class];
    else
        class_icon.class = "blank";
    end
    updateMessageWindowClassIcon(obj);
end

local function setMessageWindowCharacterDetails(obj, guild, level, race, class)
    obj.theGuild = guild;
    obj.theLevel = level;
    obj.theRace = race;
    obj.theClass = class;
    MessageWindow_RefreshCharacterDetails(obj);
end

local function MessageWindow_RefreshCharacterDetails(obj)
    local SelectedSkin = WIM:GetSelectedSkin();
    local fName = obj:GetName();
    local char_info = getglobal(fName.."BackdropCharacterDetails");
    local formatDetails = SelectedSkin.message_window.strings.char_info.format;
    char_info:SetText(formatDetails(obj.theGuild, obj.theLevel, obj.theRace, obj.theClass));
end

local function setMessageWindow_SmartStyle(obj, name, guild, level, race, class)
    local SelectedSkin = WIM:GetSelectedSkin();
    local SelectedStyle = WIM:GetSelectedStype();
    obj.theGuild = guild;
    obj.theLevel = level;
    obj.theRace = race;
    obj.theClass = class;
    if(type(SelectedSkin.smart_style) == "function" and SelectedStyle == "#SMART#") then
        WIM:LoadMessageWindowSkin(obj);
    end
end



-- load object into it's default state.
local function loadMessageWindowDefaults(obj)
    obj:Hide();

    obj.theGuild = "";
    obj.theLevel = "";
    obj.theRace = "";
    obj.theClass = "";
    
    obj.icon.track = false;

    local fName = obj:GetName();
    obj:SetScale(1);
    obj:SetAlpha(1);
    
    local backdrop = getglobal(fName.."Backdrop");
    backdrop:SetAlpha(1);
    
    local class_icon = getglobal(fName.."BackdropClassIcon");
    class_icon.class = "blank";
    
    local from = getglobal(fName.."BackdropFrom");
    from:SetText(obj.theUser);
    
    local char_info = getglobal(fName.."BackdropCharacterDetails");
    char_info:SetText("");
    
    local history = getglobal(fName.."HistoryButton");
    history:Hide();
    
    local w2w = getglobal(fName.."W2WButton");
    w2w:Hide();
    
    local chatting = getglobal(fName.."IsChattingButton");
    chatting:Hide();
    
    local msg_box = getglobal(fName.."MsgBox");
    msg_box.setText = 0;
    msg_box:SetText("");
    
    local scroll_up = CreateFrame("Button", fName.."ScrollUp", obj);
    scroll_up:Disable();
    
    local scroll_down = CreateFrame("Button", fName.."ScrollDown", obj);
    scroll_down:Disable();
    
    WIM:LoadMessageWindowSkin(obj);
end

----------------------------------------------------------
--          MessageWindow Controling Functions          --
----------------------------------------------------------

local function getXYLimits()
    local width, height;
    
    width = SelectedSkin.message_window.rect.top_left.size.x + SelectedSkin.message_window.rect.bottom_right.size.x;
    height = SelectedSkin.message_window.rect.top_left.size.y + SelectedSkin.message_window.rect.bottom_right.size.y;
    
    return width, height;
end


----------------------------------------------------------
--          MessageWindow OnEvent Functions             --
----------------------------------------------------------















-- Globals

function WIM:GetWindowSoupBowl()
    return WindowSoupBowl;
end

--Create (recycle if available) message window. Returns object.
function WIM:CreateMessageWindow(userName)
    if(type(userName) ~= "string") then
        return;
    end
    if(type(WIM:GetSelectedSkin()) ~= "table") then
        WIM:LoadSkin(WIM.db.skin.selected, WIM.db.skin.style);
    end
    local func = function ()
                        if(WindowSoupBowl.available > 0) then
                            local i;
                            for i=1,table.getn(WindowSoupBowl.windows) do
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
        obj.icon.theUser = userName;
        loadMessageWindowDefaults(obj);
        WIM:dPrint("Window recycled '"..obj:GetName().."'");
        return obj;
    else
        -- must create new object
        WindowSoupBowl.used = WindowSoupBowl.used + 1;
        WindowSoupBowl.windowToken = WindowSoupBowl.windowToken + 1; --increment token for propper frame name creation.
        local fName = "WIM3_msgFrame"..WindowSoupBowl.windowToken;
        local f = CreateFrame("Frame",fName, UIParent);
        local winTable = {
            user = userName,
            frameName = fName,
            inUse = true,
            obj = f
        };
        table.insert(WindowSoupBowl.windows, winTable);
        f.theUser = userName;
        f.isParent = true;
        instantiateMessageWindowObj(f);
        f.icon.theUser = userName;
        loadMessageWindowDefaults(f);
        WIM:dPrint("Window created '"..f:GetName().."'");
        return f;
    end
end


--Deletes message window and makes it available in the Soup Bowl.
function WIM:DestroyMessageWindow(userName)
    local obj, index = getMessageWindow(userName);
    if(obj) then
        WindowSoupBowl.windows[index].inUse = false;
        WindowSoupBowl.windows[index].user = "";
        WindowSoupBowl.available = WindowSoupBowl.available + 1;
        WindowSoupBowl.used = WindowSoupBowl.used - 1;
        WIM_Astrolabe:RemoveIconFromMinimap(obj.icon);
        obj.icon:Hide();
        obj.icon.track = false;
        obj.theUser = nil;
        obj:Show();
        local chatBox = getglobal(obj:GetName().."ScrollingMessageFrame");
        chatBox:Clear();
        obj:Hide();
    end
end

function WIM:GetShortcutCount()
	return ShortcutCount;
end




-----------------------------------------------------
--              Register Default Fonts             --
-----------------------------------------------------

-- register wow's 3 main font types.
WIM:RegisterFont("GameFontNormal", "(WoW) Game Font");
WIM:RegisterFont("ChatFontNormal", "(WoW) Chat Font");
WIM:RegisterFont("QuestTitleFont", "(WoW) Quest Font");

-- initial import from SharedMediaLib
--WIM_Skinner_Import_SharedMedia();
