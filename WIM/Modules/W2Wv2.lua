-- imports
local WIM = WIM;
local _G = _G;
local pairs = pairs;
local string = string;
local table = table;
local time = time;
local mod = mod;
local tostring = tostring;

-- set namespace
setfenv(1, WIM);

-- dev flag check
    if(not useProtocol2) then
	return;
    end


local W2W = CreateModule("W2W", true);

db_defaults.w2w = {
    shareTyping = true,
    shareCoordinates = true,
    shareTalentSpec = true,
};


local myServices = {};
local profileTip;

local Windows = windows.active.whisper;

local function getW2WTable(win)
    if(not win.w2w) then
        win.w2w = {};
    end
    return win.w2w;
end


--------------------------------------------------
--  W2W Widgets                                 --
--------------------------------------------------
local w2wWidgetCount = 1;
local function createWidget_W2W()
    local button = _G.CreateFrame("Button");
    button.flash = _G.CreateFrame("Frame", "W2W_Widget"..w2wWidgetCount, button);
    w2wWidgetCount = w2wWidgetCount + 1;
    button.flash:SetAllPoints();
    button.flash.bg = button.flash:CreateTexture(nil, "OVERLAY");
    button.flash.bg:SetAllPoints();
    button.SetActive = function(self, active)
            self.active = active;
            if(active) then
                self:Show();
            else
                self:Hide();
            end
        end
    button.SetDefaults = function(self)
            self:SetActive(false);
        end
    button.UpdateSkin = function(self)
            self.flash.bg:SetTexture(GetSelectedSkin().message_window.widgets.w2w.HighlightTexture);
        end
    button:SetScript("OnEnter", function(self)
            if(self.active) then
                --ShowProfileTip(self, self.parentWindow.theUser, "TOPRIGHT", "TOPLEFT");
            end
        end);
    button:SetScript("OnLeave", function(self)
            if(profileTip) then
                profileTip:Hide();
            end
        end);
    
    return button;
end
RegisterWidgetTrigger("w2w", "whisper", "OnUpdate", function(self, elapsed)
	    local alpha = 255;
            local counter = (self.statusCounter or 0) + elapsed;
	    local sign = self.sign or 1;

	    if ( counter > 1 ) then
		sign = -sign;
		self.sign = sign;
	    end
	    counter = mod(counter, 1);
	    self.statusCounter = counter;

	    if ( sign == 1 ) then
		alpha = (55  + (counter * 400)) / 255;
	    else
		alpha = (255 - (counter * 400)) / 255;
	    end
	    self.flash:SetAlpha(alpha);
	    self.flash:SetAlpha(alpha);
	end);


local function createWidget_Chatting()
    local button = _G.CreateFrame("Button");
    button.SetActive = function(self, active)
            self.active = active;
            if(active) then
                self.lastActive = time();
                self:Show();
            else
                self.lastActive = 0;
                self:Hide();
            end
        end
    button.SetDefaults = function(self)
            self:SetActive(false);
        end
    button:SetScript("OnUpdate", function(self, elapsed)
            self.lastUpdate = self.lastUpdate + elapsed;
            while(self.lastUpdate > 2) do
                if(time() - getW2WTable(self.parentWindow).lastKeyPress > 5) then
                    self:SetActive(false);
                end
                self.lastUpdate = 0;
            end
        end);
    button:SetScript("OnEnter", function(self)
            if(self.active and db.showToolTips == true) then
		_G.GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT");
		    _G.GameTooltip:SetText(_G.format(L["%s is typing..."], self.parentWindow.theUser));
	    end
        end);
    button:SetScript("OnLeave", function(self) _G.GameTooltip:Hide(); end);
    button.lastUpdate = 0;
    return button;
end







--------------------------------------------------
--  OpCode: Services                            --
--------------------------------------------------
--[[
    Packet:
        Command: O["SERVICES"]
        Params: forceFlag(1/0),versionStr,[service:data]*
]]
local function updateServices(user)
    for k, _ in pairs(myServices) do
        myServices[k] = nil;
    end
    -- add enabled services.
    if(db.w2w.shareTyping) then
        table.insert(myServices, tostring(S["Typing"]));
    end
    if(db.w2w.shareCoordinates) then
        table.insert(myServices, tostring(S["Coordinates"]));
    end
    if(db.w2w.shareTalentSpec) then
        table.insert(myServices, tostring(S["Talent Spec"])..":"..GetTalentSpec());
    end
    
    table.sort(myServices);
end

local function getServicesStr(user)
    updateServices(user);
    return table.concat(myServices, ",");
end

local function SendServiceList(user, forceResponse)
    if(W2W.enabled) then
        SendData("WHISPER", user, O["SERVICES"], (forceResponse and "1" or "0")..","..version..":"..(beta and "1" or "0")..","..getServicesStr());
        if(Windows[user]) then
            getW2WTable(Windows[user]).sentServices = true;
        end
    end
end

RegisterAddonMessageHandler(O["SERVICES"], function(from, data)
        if(W2W.enabled and Windows[from]) then
            local tbl = getW2WTable(Windows[from]);
            -- parse data
            local forceResponse, v, serviceData = data:match("([01]),([^,]+),(.*)$");
            -- W2W Detected
            if(v) then
                tbl.w2w = true;
		tbl.version, tbl.isBeta = string.match(v, "^(.+):(%d)");
		modules.Negotiate:VersionCheck(v);
                --parse services;
                if(serviceData and serviceData ~= "") then
                    for service in serviceData:gmatch("([^,]+)") do
                        local s, p;
                        if(service:find("^[^:]+:[^:]+$")) then
                            -- service with params
                            s, p = service:match("^([^:]+):?(.*)$");
                        else
                            -- service without params
                            s = service;
                        end
                        -- responses to services
                        if(s == tostring(S["Talent Spec"])) then
                            tbl.talentSpec = p
                        elseif(s == tostring(S["Coordinates"])) then
                            -- send service request start
			    SendData("WHISPER", from, O["LOC_REQUEST"], "1");
                        end
                    end
                end
                tbl.services = serviceData;
                Windows[from].widgets.w2w:SetActive(true);
            end
            if(forceResponse == "1") then
                SendServiceList(from);
            end
        end
    end);
    
    

--------------------------------------------------
--  OpCode: Typing                              --
--------------------------------------------------
--[[
    Packet:
        Command: O["TYPING"]
        Params: [0/1] - indicating user typing
]]
-- enables typing notification for WIM window's message box.
RegisterWidgetTrigger("msg_box", "whisper", "OnTextChanged", function(self)
        if(W2W.enabled and db.w2w.shareTyping and string.sub(self:GetText(),1,1) ~= "/") then
            if(string.trim(self:GetText()) == "" and getW2WTable(self.parentWindow).lastKeyPress ~= 0) then
                getW2WTable(self.parentWindow).lastKeyPress = 0;
                SendData("WHISPER", self.parentWindow.theUser, O["TYPING_STOP"]);
            elseif(string.trim(self:GetText()) ~= "") then
                if(time() - getW2WTable(self.parentWindow).lastKeyPress > 2) then
                    SendData("WHISPER", self.parentWindow.theUser, O["TYPING_START"]);
                    getW2WTable(self.parentWindow).lastKeyPress = time();
                end
            end
        end
    end);

-- enables typing notification for default chat frame's message box.
RegisterWidgetTrigger("msg_box", "whisper", "OnShow", function(self) getW2WTable(self.parentWindow).lastKeyPress = 0; end);
_G.hooksecurefunc("ChatEdit_OnTextChanged", function(self)
    local chatType, tellTarget = self:GetAttribute("chatType"), self:GetAttribute("tellTarget");
    if(chatType == "WHISPER" and W2W.enabled and db.w2w.shareTyping and string.sub(self:GetText(),1,1) ~= "/") then
        self.lastKeyPress = self.lastKeyPress or 0;
        if(string.trim(self:GetText()) == "") then
            self.lastKeyPress = 0;
            SendData("WHISPER", tellTarget, O["TYPING_STOP"]);
        else
            if(time() - self.lastKeyPress > 2) then
                SendData("WHISPER", tellTarget, O["TYPING_START"]);
                self.lastKeyPress = time();
            end
        end
    else
        self.lastKeyPress = 0;
    end
end);

RegisterAddonMessageHandler(O["TYPING_START"], function(from, data)
        if(Windows[from] and Windows[from].widgets.chatting) then
            Windows[from].widgets.chatting:SetActive(true);
        end
    end);
RegisterAddonMessageHandler(O["TYPING_STOP"], function(from, data)
        if(Windows[from] and Windows[from].widgets.chatting) then
            Windows[from].widgets.chatting:SetActive(false);
        end
    end);
    
    

--------------------------------------------------
--  Location Services                           --
--------------------------------------------------
local servingList = {};
local locationWorker = _G.CreateFrame("Frame");
locationWorker.timeElapsed = 0;

local function getPositionStr()
	local C, Z, x, y = libs.Astrolabe:GetCurrentPlayerPosition();
	local zoneInfo, subZoneInfo;
	zoneInfo = _G.GetRealZoneText();
	subZoneInfo = _G.GetSubZoneText();
	if(not C) then C = 0; end
	if(not Z) then Z = 0; end
	if(not x) then x = 0; end
	if(not y) then y = 0; end
	if(subZoneInfo and subZoneInfo ~= zoneInfo and subZoneInfo ~= "") then zoneInfo = "("..zoneInfo..") ".._G.GetSubZoneText(); end
	return zoneInfo..":"..C..":"..Z..":"..x..":"..y;
end

local function RegisterLocationRequest(user)
    servingList[user] = getPositionStr();
    SendData("WHISPER", user, O["LOC"], servingList[user]);
end

local function UnregisterLocationRequest(user)
    servingList[user] = nil;
end

local function UpdateLocationServices()
    local curLoc = getPositionStr();
    for user, loc in pairs(servingList) do
	if(loc ~= curLoc) then
	    servingList[user] = curLoc;
	    if(W2W.enabled and db.w2w.shareCoordinates) then
		SendData("WHISPER", user, O["LOC"], curLoc);
	    end
	end
    end
end

locationWorker:SetScript("OnUpdate", function(self, elapsed)
	self.timeElapsed = self.timeElapsed + elapsed;
	while(self.timeElapsed > 5) do
	    UpdateLocationServices();
	    self.timeElapsed = 0;
	end
    end);

--[[
    Packet:
        Command: O["LOC_REQUEST"]
        Params: [0/1] - start/stop bit
]]
RegisterAddonMessageHandler(O["LOC_REQUEST"], function(from, data)
        if(data == "1") then
	    if(W2W.enabled and db.w2w.shareCoordinates) then
		RegisterLocationRequest(from);
	    end
	else
	    UnregisterLocationRequest(from);
	end
    end);

--[[
    Packet:
        Command: O["LOC"]
        Params: Astrolabe data
]]
RegisterAddonMessageHandler(O["LOC"], function(from, data)
        if(Windows[from]) then
	    local tbl = getW2WTable(Windows[from]);
            Windows[from].location, tbl.C, tbl.Z, tbl.x, tbl.y = string.match(data, "^(.+):(.+):(.+):(.+):(.+)$");
	else
	    -- window isn't open, send stop signal
	    SendData("WHISPER", user, O["LOC_REQUEST"], "0");
	end
    end);









-- Module Abstract    
function W2W:OnEnable()
    RegisterWidget("w2w", createWidget_W2W);
    RegisterWidget("chatting", createWidget_Chatting);
    locationWorker:Show();
    UpdateAllServices();
end

function W2W:OnDisable()
    for widget in Widgets("w2w") do
        widget:SetActive(false); -- module is disabled, hide Icons.
    end
    for widget in Widgets("chatting") do
        widget:SetActive(false); -- module is disabled, hide Icons.
    end
    locationWorker:Hide();
end

function W2W:OnWindowCreated(win)
    if(win.type == "whisper") then
        SendServiceList(win.theUser, true);
    end
end

function W2W:OnWindowDestroyed(win)
    -- send stop signal
    SendData("WHISPER", win.theUser, O["LOC_REQUEST"], "0");
    -- clear any w2w data
    if(win.w2w) then
        for k, _ in pairs(win.w2w) do
            win.w2w[k] = nil;
        end
    end
end









--Globals
function UpdateAllServices()
    if(W2W.enabled) then
        for user, _  in pairs(Windows) do
            SendServiceList(user);
        end
    end
end

function ShowW2WTip(win, anchor, point)
    anchor = anchor or win;
    point = point or "ANCHOR_RIGHT";
    local location = win.location ~= "" and win.location or L["Unknown"];
    local tbl = win.w2w;
    _G.GameTooltip:SetOwner(anchor, point);
    _G.GameTooltip:AddDoubleLine("|cff"..win.classColor..win.theUser.."|r", (win.w2w.version and "v"..win.w2w.version or ""));
    _G.GameTooltip:AddDoubleLine(L["Location"]..":",  "|cffffffff"..location.."|r");
    _G.GameTooltip:AddDoubleLine(L["Coordinates"]..":", "|cffffffff".._G.math.floor((tbl.x or 0)*100)..",".._G.math.floor((tbl.y or 0)*100).."|r");
    if(tbl.talentSpec) then
        _G.GameTooltip:AddDoubleLine(L["Talent Spec"]..":", "|cffffffff"..TalentsToString(tbl.talentSpec, win.class).."|r");
    end
    _G.GameTooltip:AddLine("|cff69ccf0"..L["Right-Click for profile links..."].."|r");
    _G.GameTooltip:Show();
end