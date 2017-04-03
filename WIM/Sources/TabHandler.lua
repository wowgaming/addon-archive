local WIM = WIM;

-- imports
local _G = _G;
local CreateFrame = CreateFrame;
local IsShiftKeyDown = IsShiftKeyDown;
local GetMouseFocus = GetMouseFocus;
local table = table;
local pairs = pairs;
local math = math;

-- set namespace
setfenv(1, WIM);

db_defaults.tabs = {
    sortBy = 2, -- 1: Window created, 2: Activity, 3: Alphabetical
};

local tabsPerStrip = 10;
local minimumWidth = 75;

local tabGroups = {};

----------------------------------
--      Core Tab Management     --
----------------------------------

-- a simple function to add an item to a table checking for duplicates.
-- this is ok, since the table is never too large to slow things down.
local addToTableUnique = addToTableUnique;

-- remove item from table. Return true if removed, false otherwise.
local removeFromTable = removeFromTable;

-- sorting functions
local function sortTabs(a, b)
    if(db.tabs.sortBy == 1) then
        -- sort by window creation
        return a.age < b.age;
    elseif(db.tabs.sortBy == 2) then
        -- sort by activity
        return a.lastActivity > b.lastActivity;
    else
        -- sort alphabetical
        return a.theUser < b.theUser;
    end
end


-- get the table index of an item. return's 0 if not found
local function getIndexFromTable(tbl, item)
    for i=1, #tbl do
        if(tbl[i] == item) then
            return i;
        end
    end
    return;
end

local function applySkinToTab(tab, skinTable)
    tab:SetHighlightTexture(skinTable.textures.tab.HighlightTexture, skinTable.textures.tab.HighlightAlphaMode);
    tab:SetTexture(skinTable.textures.tab.NormalTexture);
    tab:SetSelectedTexture(skinTable.textures.tab.PushedTexture);
    local hlt = tab:GetHighlightTexture();
    if(hlt) then
        hlt:ClearAllPoints();
        hlt:SetAllPoints();
    end
end

-- update tabStip with propper skin layout.
local function applySkin(tabStrip)
    local skinTable = GetSelectedSkin().tab_strip;
    local i;
    for i=1,table.getn(tabStrip.tabs) do
        local tab = tabStrip.tabs[i];
        tab:ClearAllPoints();
        if(skinTable.vertical) then
            if(i == 1) then
                tab:SetPoint("TOPLEFT", tabStrip, "TOPLEFT");
                tab:SetPoint("TOPRIGHT", tabStrip, "TOPRIGHT");
            else
                tab:SetPoint("TOPLEFT", tabStrip.tabs[i-1], "BOTTOMLEFT");
                tab:SetPoint("TOPRIGHT", tabStrip.tabs[i-1], "BOTTOMRIGHT");
            end
        else
            if(i == 1) then
                tab:SetPoint("TOPLEFT", tabStrip, "TOPLEFT");
                tab:SetPoint("BOTTOMLEFT", tabStrip, "BOTTOMLEFT");
            else
                tab:SetPoint("TOPLEFT", tabStrip.tabs[i-1], "TOPRIGHT");
                tab:SetPoint("BOTTOMLEFT", tabStrip.tabs[i-1], "BOTTOMRIGHT");
            end
        end
        applySkinToTab(tab, skinTable);
    end
    tabStrip.nextButton:SetNormalTexture(skinTable.textures.next.NormalTexture);
    tabStrip.nextButton:SetPushedTexture(skinTable.textures.next.PushedTexture);
    tabStrip.nextButton:SetHighlightTexture(skinTable.textures.next.HighlightTexture, skinTable.textures.next.HighlightAlphaMode);
    tabStrip.nextButton:SetDisabledTexture(skinTable.textures.next.DisabledTexture);
    tabStrip.prevButton:SetNormalTexture(skinTable.textures.prev.NormalTexture);
    tabStrip.prevButton:SetPushedTexture(skinTable.textures.prev.PushedTexture);
    tabStrip.prevButton:SetHighlightTexture(skinTable.textures.prev.HighlightTexture, skinTable.textures.prev.HighlightAlphaMode);
    tabStrip.prevButton:SetDisabledTexture(skinTable.textures.prev.DisabledTexture);
                
    tabStrip.prevButton:ClearAllPoints();
    tabStrip.prevButton:SetPoint("RIGHT", tabStrip, "LEFT", 0, 0);
    tabStrip.prevButton:SetWidth(skinTable.textures.prev.width); tabStrip.prevButton:SetHeight(skinTable.textures.prev.height);
    tabStrip.nextButton:ClearAllPoints();
    tabStrip.nextButton:SetPoint("LEFT", tabStrip, "RIGHT", 0, 0);
    tabStrip.nextButton:SetWidth(skinTable.textures.next.width); tabStrip.nextButton:SetHeight(skinTable.textures.next.height);
end

-- modify and manage tab offsets. pass 1 or -1. will always increment/decriment by 1.
local function setTabOffset(tabStrip, PlusOrMinus)
    local offset = tabStrip.curOffset + PlusOrMinus;
    local count = tabStrip.visibleCount;
    local attached = #tabStrip.attached;
    if(offset + count > attached) then
        offset = attached - count;
    end
    if(offset < 0) then
        offset = 0;
    end
    --dPrint("attached:"..attached..", visible:"..count..", range:"..offset+1 .."-"..offset+count);
    tabStrip.curOffset = offset;
    tabStrip:UpdateTabs(true);
end


local function tabOnUpdate(self, elapsed)
    if(IsShiftKeyDown() and not self.dragFrame and self.dragging) then
        return;
    end
    local dragFrame = self.dragFrame or self
    if(IsShiftKeyDown()) then
        -- shift is being held down over tab.
        dragFrame:Show();
    else
        dragFrame:Hide();
    end
end


-- create a tabStrip object and register it to table TabGroups.
-- returns the tabStrip just created.
local function createTabGroup()
    local stripName = "WIM_TabStrip"..(table.getn(tabGroups) + 1);
    local tabStrip = CreateFrame("Frame", stripName, WindowParent);
    tabStrip:SetFrameStrata("DIALOG");
    tabStrip:SetToplevel(true);
    --tabStrip:SetWidth(384);
    --tabStrip:SetHeight(32);
    
    -- properties, tags, trackers
    tabStrip.attached = {};
    tabStrip.selected = {
        name = "",
        tab = 0,
        obj = nil
    };
    tabStrip.curOffset = 0;
    tabStrip.visibleCount = 0;
    
    --test
    tabStrip:SetPoint("CENTER");
    
    --create tabs for tab strip.
    tabStrip.tabs = {};
    local i;
    for i=1,tabsPerStrip do
        local tab = CreateFrame("Button", stripName.."_Tab"..i, tabStrip);
        tab.text = tab:CreateFontString(tab:GetName().."Text", "OVERLAY", "ChatFontNormal")
        tab.text:ClearAllPoints();
        tab.text:SetAllPoints();
        tab.tabIndex = i;
        tab.tabStrip = tabStrip;
        tab.left = tab:CreateTexture(stripName.."_Tab"..i.."Backdrop_L", "BORDER");
        tab.left:SetTexCoord(0.0, 0.25, 0.0, 1.0);
        tab.left:SetWidth(16);
        tab.left:SetPoint("TOPLEFT", tab, "TOPLEFT");
        tab.left:SetPoint("BOTTOMLEFT", tab, "BOTTOMLEFT");
        tab.right = tab:CreateTexture(stripName.."_Tab"..i.."Backdrop_R", "BORDER");
        tab.right:SetTexCoord(0.75, 1.0, 0.0, 1.0);
        tab.right:SetWidth(16);
        tab.right:SetPoint("TOPRIGHT", tab, "TOPRIGHT");
        tab.right:SetPoint("BOTTOMRIGHT", tab, "BOTTOMRIGHT");
        tab.middle = tab:CreateTexture(stripName.."_Tab"..i.."Backdrop_M", "BORDER");
        tab.middle:SetTexCoord(0.25, 0.75, 0.0, 1.0);
        tab.middle:SetPoint("TOPLEFT", tab.left, "TOPRIGHT");
        tab.middle:SetPoint("BOTTOMRIGHT", tab.right, "BOTTOMLEFT");
        tab.sleft = tab:CreateTexture(stripName.."_Tab"..i.."Backdrop_SL", "BORDER");
        tab.sleft:SetTexCoord(0.0, 0.25, 0.0, 1.0);
        tab.sleft:SetWidth(16);
        tab.sleft:SetPoint("TOPLEFT", tab, "TOPLEFT");
        tab.sleft:SetPoint("BOTTOMLEFT", tab, "BOTTOMLEFT");
        tab.sright = tab:CreateTexture(stripName.."_Tab"..i.."Backdrop_SR", "BORDER");
        tab.sright:SetTexCoord(0.75, 1.0, 0.0, 1.0);
        tab.sright:SetWidth(16);
        tab.sright:SetPoint("TOPRIGHT", tab, "TOPRIGHT");
        tab.sright:SetPoint("BOTTOMRIGHT", tab, "BOTTOMRIGHT");
        tab.smiddle = tab:CreateTexture(stripName.."_Tab"..i.."Backdrop_SM", "BORDER");
        tab.smiddle:SetTexCoord(0.25, 0.75, 0.0, 1.0);
        tab.smiddle:SetPoint("TOPLEFT", tab.left, "TOPRIGHT");
        tab.smiddle:SetPoint("BOTTOMRIGHT", tab.right, "BOTTOMLEFT");
        
        tab.dragFrame = _G.CreateFrame("Frame");
        tab.dragFrame.parentTab = tab;
        tab.dragFrame.tabStrip = tabStrip;
        tab.dragFrame:SetPoint("TOPLEFT", tab.dragFrame.parentTab, 0, 0);
        tab.dragFrame:SetPoint("BOTTOMRIGHT", tab.dragFrame.parentTab, 0, 0);
        tab.dragFrame.marker = tab.dragFrame:CreateTexture(nil, "OVERLAY");
        tab.dragFrame.marker:SetPoint("BOTTOMLEFT");
        tab.dragFrame.marker:SetPoint("BOTTOMRIGHT");
        tab.dragFrame.marker:SetHeight(2);
        tab.dragFrame.marker:SetBlendMode("ADD");
        tab.dragFrame.marker:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
        --tab.dragFrame:SetClampedToScreen(true);
        tab.dragFrame:SetFrameStrata("TOOLTIP");
        tab.dragFrame:SetMovable(true);
        tab.dragFrame:SetToplevel(true);
        tab.dragFrame:EnableMouse(true);
        tab.dragFrame:RegisterForDrag("LeftButton");
        tab.dragFrame:SetScript("OnEnter", function(self)
            self:SetScript("OnUpdate", tabOnUpdate);
        end);
        tab.dragFrame:SetScript("OnLeave", function(self)
            self:SetScript("OnUpdate", nil);
            self:Hide();
        end);
        tab.dragFrame:SetScript("OnShow", function(self)
            self.marker:Show();
        end);
        tab.dragFrame:SetScript("OnDragStart", function(self)
            self.marker:Hide();
            self.dragging = true;
            self:StartMoving();
            local win = self.parentTab.childObj;
            win.isMoving = true;
            self.draggedObject = win;
            self.parentWindow = win;
            self.tabStrip = nil;
            --detach window from tab group
            win.tabStrip:Detach(win);
            win:Show();
            win:ClearAllPoints();
            win:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0);
        end);
        tab.dragFrame:SetScript("OnDragStop", function(self)
            self:StopMovingOrSizing();
            self.dragging = nil;
            
            local win = self.draggedObject;
            win.isMoving = nil;
            win:ClearAllPoints();
            self.draggedObj = nil;
            self.parentWindow = nil;
            self.tabStrip = self.parentTab.tabStrip;

            win:ClearAllPoints();
            win:SetPoint("TOPLEFT", WindowParent, "BOTTOMLEFT", win:GetLeft(), win:GetTop());
            
            -- account for win's helper frame.
            if(win.helperFrame.isAttached) then
                local dropTo = win.helperFrame.attachedTo;
                win.helperFrame:ResetState();
                if(dropTo) then
                    -- win was already detached when drag started.
                    -- so no need to check for that again.
                    if(dropTo.tabStrip) then
                        dropTo.tabStrip:Attach(win);
                        dropTo.tabStrip:JumpToTab(dropTo);
                    else
                        local tabStrip = GetAvailableTabGroup();
                        tabStrip:Attach(dropTo);
                        tabStrip:Attach(win);
                        tabStrip:JumpToTab(dropTo);
                    end
                end
            end
            
            self:ClearAllPoints();
            self:SetPoint("TOPLEFT", self.parentTab, 0, 0);
            self:SetPoint("BOTTOMRIGHT", self.parentTab, 0, 0);
            self:Hide();
        end);
        tab.dragFrame:SetScript("OnHide", function(self)
            if(self.dragging) then
                local fun = self:GetScript("OnDragStop");
                fun(self);
            end
        end);
        
        tab.dragFrame:Hide();
        
        
        tab.SetTexture = function(self, pathOrTexture)
            self.left:SetTexture(pathOrTexture);
            self.middle:SetTexture(pathOrTexture);
            self.right:SetTexture(pathOrTexture);
        end
        tab.SetSelectedTexture = function(self, pathOrTexture)
            self.sleft:SetTexture(pathOrTexture);
            self.smiddle:SetTexture(pathOrTexture);
            self.sright:SetTexture(pathOrTexture);
        end
        tab.SetSelected = function(self, selected)
            if(selected) then
                self:SetAlpha(1);
                self.sleft:Show();
                self.smiddle:Show();
                self.sright:Show();
                self.left:Hide();
                self.middle:Hide();
                self.right:Hide();

            else
                self:SetAlpha(.7);
                self.left:Show();
                self.middle:Show();
                self.right:Show();
                self.sleft:Hide();
                self.smiddle:Hide();
                self.sright:Hide();

            end
        end
        tab:RegisterForClicks("LeftButtonUp", "RightButtonUp");
        tab:SetScript("OnClick", function(self, button)
            if(button == "RightButton") then
                self.childObj.widgets.close.forceShift = true;
                self.childObj.widgets.close:Click();
            else
                self.tabStrip:JumpToTab(self.childObj);
            end
            self:UnlockHighlight();
        end);
        tab:EnableMouseWheel(true);
        tab:SetScript("OnMouseWheel", function(self, direction)
            setTabOffset(self:GetParent(), -direction);
        end);
        tab.isWimTab = true;
        tab:SetScript("OnEnter", function(self)
            self:SetScript("OnUpdate", tabOnUpdate);
        end);
        tab:SetScript("OnLeave", function(self)
            self:SetScript("OnUpdate", nil);
        end);
        
        table.insert(tabStrip.tabs, tab);
    end
    
    -- create prev and next buttons
    tabStrip.prevButton = CreateFrame("Button", stripName.."_Prev", tabStrip);
    tabStrip.prevButton:SetScript("OnClick", function(self) setTabOffset(self:GetParent(), -1); end);
    tabStrip.nextButton = CreateFrame("Button", stripName.."_Next", tabStrip);
    tabStrip.nextButton:SetScript("OnClick", function(self) setTabOffset(self:GetParent(), 1); end);
    
    -- tabStip functions
    tabStrip.UpdateTabs = function(self, ignoreOffset)
        
        -- sort tabs
        table.sort(self.attached, sortTabs);
    
        -- relocate tabStrip to window
        local win = self.selected.obj;
        local skinTable = GetSelectedSkin().tab_strip;
        self:SetParent(win);
        self.parentWindow = win;
        SetWidgetRect(self, skinTable);
        
        -- check to see if we have more than one tab to show...
        if(#self.attached > 1) then
            self:Show();
        else
            if(#self.attached == 1) then
                self:Detach(self.attached[i])
            end
            self:Hide();
            return;
        end
    
        -- re-order tabs & sizing
        local curSize;
        if(skinTable.vertical) then
            curSize = self:GetHeight();
        else
            curSize = self:GetWidth();
        end
        local count = math.floor(curSize / minimumWidth);
        self.visibleCount = count;
        
        if(not ignoreOffset) then
            local index;
            -- get index of selected object
            for i=1, #self.attached do
                if(self.selected.obj == self.attached[i]) then
                    index = i;
                    break;
                end
            end
            if(index) then -- just incase.
                    -- we need to adjust the offset to make sure the selected tab is shown.
                    if((self.curOffset + count) < index) then
                        self.curOffset = index - count;
                    elseif(index - 1 < self.curOffset) then
                        self.curOffset = index - 1;
                    end
            end
        end
        
        if((self.curOffset + count) > #self.attached) then
            self.curOffset = math.max(#self.attached - count , 0);
        end
        if(count >= #self.attached) then
		count = #self.attached;
		self.nextButton:Hide();
		self.prevButton:Hide();
	else
		self.nextButton:Show();
		self.prevButton:Show();
                
                self.prevButton.parentWindow = self:GetParent();
                self.nextButton.parentWindow = self:GetParent();
                
		if(self.curOffset <= 0) then
                        self.curOffset = 0;
			self.prevButton:Disable();
		else
			self.prevButton:Enable();
		end
		if(self.curOffset >= #self.attached - count) then
                        self.curOffset = #self.attached - count;
			self.nextButton:Disable();
		else
			self.nextButton:Enable();
		end
	end
        for i=1,tabsPerStrip do
            local tab = self.tabs[i];
            if(i <= count) then
                local str = self.attached[i+self.curOffset].theUser;
                tab:Show();
                tab.childObj = self.attached[i+self.curOffset];
                tab.childName = str;
                tab.text:SetText(str);
                if(tab.childObj == self.selected.obj) then
                    tab:SetSelected(true);
                else
                    tab:SetSelected(false);
                end
            else
                tab:Hide();
                tab.childName = "";
                tab.childObj = nil;
                tab:SetText("");
            end
            --include logic here to show selected tab or not.
            tab:SetWidth(curSize/count);
            tab:SetHeight(curSize/count);
        end
    end
    
    tabStrip.SetSelectedName = function(self, win)
        --local win = windows.active.whisper[winName] or windows.active.chat[winName] or windows.active.w2w[winName];
        if(win) then
            self.selected.name = win.theUser;
            self.selected.obj = win;
            --self:UpdateTabs();
            self.parentWindow = win;
        end
    end
    
    tabStrip.JumpToTab = function(self, win)
        local lastWin = "NONE";
        if(win) then
            local oldWin = self.selected.obj;
            local oldCustomSize = win.customSize;
            local inFocus = EditBoxInFocus and EditBoxInFocus:GetParent().tabStrip == self and true or false;
            win.customSize = true;
            DisplayTutorial(L["Manipulating Tabs"], L["You can <Shift-Click> a tab and drag it out into it's own window."]);
            
            if(oldWin and oldWin ~= win) then
                local oW, oH, oL, oT, oA = oldWin:GetWidth(), oldWin:GetHeight(), oldWin:GetLeft(), oldWin:SafeGetTop(), oldWin:GetAlpha();
                local cW, cH, cL, cT, cA = win:GetWidth(), win:GetHeight(), win:GetLeft(), win:SafeGetTop(), win:GetAlpha();
                if(oW ~= cW) then win:SetWidth(oW); end
                if(oH ~= cH) then win:SetHeight(oH); end
                if(oL ~= cL or oT ~= oT) then win:SetPoint("TOPLEFT", WindowParent, "BOTTOMLEFT", oL, oT); end
                if(oA ~= cA) then win:SetAlpha(oA); end
                lastWin = oldWin:GetName();
            end
            if( not win.popNoShow ) then
                self:SetSelectedName(win);
                win:Show();
                if(inFocus) then
                    win.widgets.msg_box:SetFocus()
                end
            end
            
            win.customSize = oldCustomSize;
            
            self:UpdateTabs();
            if( not win.popNoShow ) then
                for i=1,#self.attached do
                    local obj = self.attached[i];
                    if(obj ~= win and obj:IsShown()) then
                        obj:Hide();
                    end
                end
            end
            win.popNoShow = nil;
        end
    end
    
    tabStrip.Detach = function(self, win)
        --local win = windows.active.whisper[winName] or windows.active.chat[winName] or windows.active.w2w[winName];
        if(win) then
            local curIndex = getIndexFromTable(self.attached, win);
            if(curIndex and self.attached[curIndex]) then
                win.tabStrip = nil;
                table.remove(self.attached, curIndex);
            else
                return; -- window isn't attached.
            end
            if(win == self.selected.obj) then
                if(#self.attached < 1) then
                    self.selected.name = "";
                    self.selected.obj = nil;
                    self.parentWindow = nil;
                    self:UpdateTabs();
                else
                    local nextIndex = 0;
                    if(curIndex > #self.attached) then
                        nextIndex = #self.attached;
                    else
                        nextIndex = curIndex;
                    end
                    self:UpdateTabs();
                    self:JumpToTab(self.attached[nextIndex]);
                    win:SetFrameLevel(self:GetFrameLevel()+10);
                end
            else
                self:UpdateTabs();
            end
            --win:Show();
            dPrint(win:GetName().." is detached from "..self:GetName());
        end
    end
    
    tabStrip.Attach = function(self, win, jumpToTab)
        --local win = windows.active.whisper[winName] or windows.active.chat[winName] or windows.active.w2w[winName];
        if(win) then
            --if already attached, detach then attach here.
            if(win.tabStrip) then
                win.tabStrip:Detach(win);
            end
            table.insert(self.attached, win);
            win.tabStrip = self;
            self:SetSelectedName(self.selected.obj or win);
            self:UpdateTabs();
            dPrint(win:GetName().." is attached to "..self:GetName());
        end
    end
    
    tabStrip.flashTrack_elapsed = 0;
    tabStrip:SetScript("OnUpdate", function(self, elapsed)
            -- manage flashing tabs.
            self.flashTrack_elapsed = self.flashTrack_elapsed + elapsed;
            while(self.flashTrack_elapsed >= 1) do
                for i=1, #self.tabs do
                    local tab = self.tabs[i];
                    if(tab:IsShown()) then
                        if(tab.childObj and (tab.childObj.unreadCount or 0) > 0) then
                            if(tab.flashOn) then
                                tab.flashOn = nil;
                                tab:UnlockHighlight();
                            else
                                tab.flashOn = true;
                                tab:LockHighlight();
                            end
                        else
                            tab:UnlockHighlight();
                        end
                    else
                        tab:UnlockHighlight();
                    end
                end
                self.flashTrack_elapsed = 0;
            end
        end);
    
    applySkin(tabStrip);
    
    -- hide after first created.
    tabStrip:Hide();
    table.insert(tabGroups, tabStrip);
    return tabStrip;
end

-- using the following logic, get an unsed tab group, if none
-- are available, create a new one and return.
local function getAvailableTabGroup()
    if(table.getn(tabGroups) == 0) then
        return createTabGroup();
    else
        local i;
        for i=1, table.getn(tabGroups) do
            if(table.getn(tabGroups[i].attached) == 0) then
                return tabGroups[i];
            end
        end
        return createTabGroup();
    end
end



--------------------------------------
--          Widget Handling         --
--------------------------------------


RegisterWidgetTrigger("msg_box", "whisper,chat,w2w,demo", "OnTabPressed", function(self)
    local win = self.parentWindow;
    if(win.tabStrip and #win.tabStrip.attached > 1 and self:GetCursorPosition() == 0) then
        local index;
        -- get window index
        for i=1, #win.tabStrip.attached do
            if(win.tabStrip.attached[i] == win) then
                index = i;
                break;
            end
        end
        -- shouldn't be needed but just in case.
        if(index) then
            -- cycle forward or backword?
            if(_G.IsShiftKeyDown()) then
                -- backwards
                index = win.tabStrip.attached[index - 1] and (index - 1) or #win.tabStrip.attached;
            else
                -- forwards
                if(not db.tabAdvance) then
                    index = win.tabStrip.attached[index + 1] and (index + 1) or 1;
                else
                    return;
                end
            end
            win.tabStrip:JumpToTab(win.tabStrip.attached[index]);
        end
    end
end);




--------------------------------------
--          Global Tab Functions    --
--------------------------------------

-- update All Tabs (used for options mainly)
function UpdateAllTabs()
    for i=1, table.getn(tabGroups) do
        tabGroups[i]:UpdateTabs();
    end
end

-- update skin to all tabStrips.
function ApplySkinToTabs()
    for i=1, table.getn(tabGroups) do
        applySkin(tabGroups[i]);
    end
end

-- give getAvailableTabGroup() a global reference.
function GetAvailableTabGroup()
    return getAvailableTabGroup();
end
