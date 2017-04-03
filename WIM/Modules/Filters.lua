--imports
local WIM = WIM;
local _G = _G;
local table = table;
local string = string;
local pairs = pairs;
local CreateFrame = CreateFrame;
local type = type;
local tonumber = tonumber;
local unpack = unpack;

--set namespace
setfenv(1, WIM);

--[[
    type:   1 - Pattern
            2 - User Type
            3 - Level
            
    action: 1 - Allow
            2 - Ignore
            3 - Block
]]

--Default Filters
local DefaultFilters = {
    {
        name = L["Whispers Sent by Addons"],
        type = 1,
        tag = "addons",
        pattern = "^<T>PartyQuests[^A-Z]+\n"..
                    "^<M_N>\n"..
                    "^ItemDB-Request:\n"..
                    "^LVBM\n"..
                    "^YOU ARE BEING WATCHED!\n"..
                    "^YOU ARE MARKED!\n"..
                    "^YOU ARE CURSED!\n"..
                    "^YOU HAVE THE PLAGUE!\n"..
                    "^YOU ARE BURNING!\n"..
                    "^YOU ARE THE BOMB!\n"..
                    "VOLATILE INFECTION\n"..
                    "^/"..
                    "^GA[^A-Z]+\n"..
                    "^<METAMAP\n"..
                    "^<CT",
        action = 2,
        stats = 0,
        protected = true,
        enabled = true,
        received = true,
        sent = true
    },
    {
        name = L["WhisperSelect Part 1"],
        enabled = false;
        type = 2,
        action = 1,
        friend = true,
        party = true,
        raid = true,
        guild = true,
        received = true,
        stats = 0
    },
    {
        name = L["Example Spam Blocker"],
        enabled = false;
        type = 3,
        action = 3,
        level = 2,
        received = true,
        notify = true,
        stats = 0
    },
    {
        name = L["WhisperSelect Part 2"],
        enabled = false;
        type = 2,
        action = 2,
        all = true,
        received = true,
        stats = 0
    }
};


local filterFrame;

local maxLevel = 80;

local Filters = CreateModule("Filters", true);

-- This module requires LibChatHandler-1.0
_G.LibStub:GetLibrary("LibChatHandler-1.0"):Embed(Filters);

-- filtering

local userCache = {};
local blockedEvents = {};

local function logBlockedEvent(eventItem)
    -- only blocked events whishing a notification will be logged.
    local event = eventItem:GetEvent();
    local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11 = eventItem:GetArgs();
    if(event == "CHAT_MSG_WHISPER_INFORM") then
        arg2 = _G.UnitName("player");
    end
    if(arg11 and blockedEvents[arg11] == nil) then
        blockedEvents[arg11] = {event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11};
        local msg = "|cffff7d0a"..L["WIM has blocked a message from %s."].." |r|cffff0000[|HWIMBLOCKED:"..arg11.."|h"..L["View Blocked Message"].."|h]|r"
        _G.DEFAULT_CHAT_FRAME:AddMessage(msg:gsub("%%s", "|r[|Hplayer:"..arg2.."|h"..arg2.."|h]|cffff7d0a"));
        _G.PlaySound("TellMessage");
    end
end


local function checkClass(result, filter)
    -- class check here
    local triggerClass, classTag = true, "blank";
    if(constants.classes[result.Class]) then
        classTag = string.gsub(constants.classes[result.Class].tag, "F$", "");
        if(not filter.classSpecific) then
		triggerClass = true;
        else
		if(filter.classSpecific ~= classTag) then
		    triggerClass = false;
	    end
        end
    end
    return triggerClass;
end

local function cacheUser(result)
    if(not userCache[result.Name]) then
	userCache[result.Name] = {};
    end
    for key, val in pairs(result) do
	userCache[result.Name][key] = val;
    end
end

local function whoCallback(result, eventItem, filter)
    local arg1, name = eventItem:GetArgs();
    if(result and result.Online and result.Name == name) then
        cacheUser(result);
        if(result.Level < filter.level and checkClass(result, filter)) then
            if(filter.action == 1) then
                dPrint("Filter->WhoCallBack: Allow()");
                filter.stats = filter.stats + 1;
                eventItem:Allow();
                Filters:CHAT_MSG_WHISPER_CONTROLLER(eventItem, eventItem.continueFrom);
            elseif(filter.action == 2) then
                dPrint("Filter->WhoCallBack: Ignored()");
                filter.stats = filter.stats + 1;
                eventItem.ignoredByWIM = true;
                eventItem:BlockFromDelegate(modules.WhisperEngine);
                Filters:CHAT_MSG_WHISPER_CONTROLLER(eventItem, eventItem.continueFrom);
            elseif(filter.action == 3) then
                dPrint("Filter->WhoCallBack: Block()");
                filter.stats = filter.stats + 1;
                if(filter.notify) then
                    logBlockedEvent(eventItem);
                end
                eventItem:Block();
                eventItem:Release(Filters);
            else
                dPrint("Filter->WhoCallBack: Unknown Action...");
                Filters:CHAT_MSG_WHISPER_CONTROLLER(eventItem, eventItem.continueFrom);
            end
        else
            dPrint("Filter->WhoCallBack: Level above threshhold");
            Filters:CHAT_MSG_WHISPER_CONTROLLER(eventItem, eventItem.continueFrom);
        end
    else
        dPrint("Filter->WhoCallBack: Result failure");
        Filters:CHAT_MSG_WHISPER_CONTROLLER(eventItem, eventItem.continueFrom);
    end
end

local function processFilter(eventItem, filter)
    local message, name = eventItem:GetArgs();
    if(filter.type == 1) then
        --message = string.trim(message);
        local patterns = filter.pattern.."\n";
        local start, stop, pattern = string.find(patterns, "([^\n]+)\n", 1);
        while(pattern) do
            pattern = string.trim(pattern);
            if(pattern ~= "" and string.find(message, pattern)) then
                filter.stats = filter.stats + 1;
                return filter.action;
            end
            start, stop, pattern = string.find(patterns, "([^\n]+)\n", stop + 1);
        end
        return; -- no patterns matched.
    elseif(filter.type == 2) then
        if(filter.all or (filter.friend and (lists.friends[name] or _G.UnitName("player") == name)) or (filter.guild and (lists.guild[name] or _G.UnitName("player") == name)) or
            (filter.party and (IsInParty(name) or _G.UnitName("player") == name)) or (filter.raid and (IsInRaid(name) or _G.UnitName("player") == name)) or
            (filter.xrealm and string.find(name, "%-"))) then
                filter.stats = filter.stats + 1;
                return filter.action;
        end
    elseif(filter.type == 3) then
        -- do not do look up if user has window opened already. Defeats the purpose.
        if(not windows.active.whisper[name] and not userCache[name] and _G.UnitName("player") ~= name) then
            dPrint("Running WhoLookUp on: "..name);
            local result = libs.WhoLib:UserInfo(name, 
    	    {
    		queue = libs.WhoLib.WHOLIB_QUEUE_QUIET, 
    		timeout = 60,
    		--flags = libs.WhoLib.WHOLIB_FLAG_ALWAYS_CALLBACK,
    		callback = function(result)
                    whoCallback(result, eventItem, filter);
                end
    	    });
            if(result) then
                whoCallback(result, eventItem, filter);
            else
                eventItem:Suspend(Filters);
            end
            return 0;
        elseif(windows.active.whisper[name]) then
            return;
        elseif(userCache[name]) then
            if(userCache[name].Level < filter.level and checkClass(userCache[name], filter)) then
                return filter.action;
            else
                return;
            end
        else
            return;
        end
    else
        return; -- not a valid filter, return nil.
    end
end

function Filters:CHAT_MSG_WHISPER_CONTROLLER(eventItem, startFrom)
    if(not db or not db.enabled) then
        return;
    end
    startFrom = type(startFrom) == "number" and startFrom or 1;
    for i=startFrom, #filters do
        if(filters[i].received and filters[i].enabled) then
            eventItem.continueFrom = startFrom + 1;
            local result = processFilter(eventItem, filters[i]);
            if(result == 0) then
                -- event suspended... will resume later.
                eventItem.suspendedByWIM_Filter = true;
                return;
            elseif(result == 1) then
                break;
            elseif(result == 2) then
                eventItem.ignoredByWIM = true;
                eventItem:BlockFromDelegate(modules.WhisperEngine);
                break;
            elseif(result == 3) then
                if(filters[i].notify) then
                    logBlockedEvent(eventItem);
                end
                eventItem:Block();
                break;
            end
        end
    end
    if(eventItem.suspendedByWIM_Filter) then
        eventItem.suspendedByWIM_Filter = nil;
        eventItem:Release(Filters);
    end
    if(options.frame and options.frame.filterList) then
        options.frame.filterList:Hide();
        options.frame.filterList:Show();
    end
end

function Filters:CHAT_MSG_WHISPER_INFORM_CONTROLLER(eventItem, startFrom)
    if(not db or not db.enabled) then
        return;
    end
    startFrom = type(startFrom) == "number" and startFrom or 1;
    for i=startFrom, #filters do
        if(filters[i].sent and filters[i].type == 1 and filters[i].enabled) then
            local result = processFilter(eventItem, filters[i]);
            if(result == 0) then
                -- event suspended... will resume later.
                break;
            elseif(result == 1) then
                break;
            elseif(result == 2) then
                eventItem.ignoredByWIM = true;
                eventItem:BlockFromDelegate(modules.WhisperEngine);
                break;
            elseif(result == 3) then
                if(filters[i].notify) then
                    logBlockedEvent(eventItem);
                end
                eventItem:Block();
                break;
            end
        end
    end
    if(eventItem.suspendedByWIM_Filter) then
        eventItem.suspendedByWIM_Filter = false;
        eventItem:Release(Filters);
    end
    if(options.frame and options.frame.filterList) then
        options.frame.filterList:Hide();
        options.frame.filterList:Show();
    end
end

function Filters:OnEnable()
    if(db.enabled) then
        Filters:RegisterChatEvent("CHAT_MSG_WHISPER", 1);
        Filters:RegisterChatEvent("CHAT_MSG_WHISPER_INFORM", 1);
    end
end

function Filters:OnDisable()
    Filters:UnregisterChatEvent("CHAT_MSG_WHISPER");
    Filters:UnregisterChatEvent("CHAT_MSG_WHISPER_INFORM");
end


--Chat Filters
local ChatFilters = CreateModule("ChatFilters");

-- This module requires LibChatHandler-1.0
_G.LibStub:GetLibrary("LibChatHandler-1.0"):Embed(ChatFilters);

function ChatFilters:OnEnable()
    if(db.enabled) then
        ChatFilters:RegisterChatEvent("CHAT_MSG_GUILD", 1);
        ChatFilters:RegisterChatEvent("CHAT_MSG_OFFICER", 1);
        ChatFilters:RegisterChatEvent("CHAT_MSG_PARTY", 1);
        ChatFilters:RegisterChatEvent("CHAT_MSG_RAID", 1);
        ChatFilters:RegisterChatEvent("CHAT_MSG_RAID_LEADER", 1);
        ChatFilters:RegisterChatEvent("CHAT_MSG_SAY", 1);
        ChatFilters:RegisterChatEvent("CHAT_MSG_CHANNEL", 1);
        ChatFilters:RegisterChatEvent("CHAT_MSG_BATTLEGROUND", 1);
        ChatFilters:RegisterChatEvent("CHAT_MSG_BATTLEGROUND_LEADER", 1);
    end
end

function ChatFilters:OnDisable()
    ChatFilters:UnregisterChatEvent("CHAT_MSG_GUILD");
    ChatFilters:UnregisterChatEvent("CHAT_MSG_OFFICER");
    ChatFilters:UnregisterChatEvent("CHAT_MSG_PARTY");
    ChatFilters:UnregisterChatEvent("CHAT_MSG_RAID");
    ChatFilters:UnregisterChatEvent("CHAT_MSG_RAID_LEADER");
    ChatFilters:UnregisterChatEvent("CHAT_MSG_SAY");
    ChatFilters:UnregisterChatEvent("CHAT_MSG_CHANNEL");
    ChatFilters:UnregisterChatEvent("CHAT_MSG_BATTLEGROUND");
    ChatFilters:UnregisterChatEvent("CHAT_MSG_BATTLEGROUND_LEADER");
end

local function chatController(self, eventItem, msg, from)
    if(not db or not db.enabled) then
        return;
    end
    local isSent = from == _G.UnitName("player");
    for i=1, #chatFilters do
        if(((isSent and chatFilters[i].sent) or (not isSent and chatFilters[i].received)) and chatFilters[i].enabled) then
            local result = processFilter(eventItem, chatFilters[i]);
            if(result == 1) then
                break;
            elseif(result == 2) then
                eventItem.ignoredByWIM = true;
                break;
            elseif(result == 3) then
                if(chatFilters[i].notify) then
                    logBlockedEvent(eventItem);
                end
                eventItem:Block();
                break;
            end
        end
    end
    if(options.frame and options.frame.chatFilterList) then
        options.frame.chatFilterList:Hide();
        options.frame.chatFilterList:Show();
    end
end


ChatFilters.CHAT_MSG_GUILD_CONTROLLER = chatController;
ChatFilters.CHAT_MSG_OFFICER_CONTROLLER = chatController;
ChatFilters.CHAT_MSG_PARTY_CONTROLLER = chatController;
ChatFilters.CHAT_MSG_RAID_CONTROLLER = chatController;
ChatFilters.CHAT_MSG_RAID_LEADER_CONTROLLER = chatController;
ChatFilters.CHAT_MSG_SAY_CONTROLLER = chatController;
ChatFilters.CHAT_MSG_CHANNEL_CONTROLLER = chatController;
ChatFilters.CHAT_MSG_BATTLEGROUND_CONTROLLER = chatController;
ChatFilters.CHAT_MSG_BATTLEGROUND_LEADER_CONTROLLER = chatController;



-- Globals
function GetDefaultFilters()
    return DefaultFilters;
end



-- Options UI

local function createFilterFrame()
    local win = CreateFrame("Frame", "WIM3_FilterFrame", _G.UIParent);
    win:Hide();
    win.filter = {};
    -- set size and position
    win:SetWidth(475);
    win:SetHeight(390);
    win:SetPoint("CENTER");
    
    -- set backdrop
    win:SetBackdrop({bgFile = "Interface\\AddOns\\"..addonTocName.."\\Sources\\Options\\Textures\\Frame_Background", 
        edgeFile = "Interface\\AddOns\\"..addonTocName.."\\Sources\\Options\\Textures\\Frame", 
        tile = true, tileSize = 64, edgeSize = 64, 
        insets = { left = 64, right = 64, top = 64, bottom = 64 }});

    -- set basic frame properties
    win:SetClampedToScreen(true);
    win:SetFrameStrata("DIALOG");
    win:SetMovable(true);
    win:SetToplevel(true);
    win:EnableMouse(true);
    win:RegisterForDrag("LeftButton");

    -- set script events
    win:SetScript("OnDragStart", function(self) self:StartMoving(); end);
    win:SetScript("OnDragStop", function(self) self:StopMovingOrSizing(); end);
    
    -- create and set title bar text
    win.title = win:CreateFontString(win:GetName().."Title", "OVERLAY", "ChatFontNormal");
    win.title:SetPoint("TOPLEFT", 50 , -20);
    local font = win.title:GetFont();
    win.title:SetFont(font, 16, "");
    
    -- create close button
    win.close = CreateFrame("Button", win:GetName().."Close", win);
    win.close:SetWidth(18); win.close:SetHeight(18);
    win.close:SetPoint("TOPRIGHT", -24, -20);
    win.close:SetNormalTexture("Interface\\AddOns\\"..addonTocName.."\\Sources\\Options\\Textures\\blipRed");
    win.close:SetHighlightTexture("Interface\\AddOns\\"..addonTocName.."\\Sources\\Options\\Textures\\close", "BLEND");
    win.close:SetScript("OnClick", function(self)
            self:GetParent():Hide();
        end);
        
    -- create filter name
    win.nameText = win:CreateFontString(win:GetName().."NameText", "OVERLAY", "ChatFontNormal");
    win.nameText:SetText(L["Filter Name"]..":");
    win.nameText:SetTextColor(_G.GameFontNormal:GetTextColor());
    win.nameText:SetPoint("TOPLEFT", 30, -60);
    win.name = CreateFrame("EditBox", win:GetName().."Name", win);
    win.name:SetFontObject(_G.ChatFontNormal);
    win.name:SetPoint("TOPLEFT", win.nameText, "TOPLEFT", win.nameText:GetStringWidth()+10, 2);
    win.name:SetPoint("BOTTOMLEFT", win.nameText, "BOTTOMLEFT", win.nameText:GetStringWidth()+10, 0);
    win.name:SetPoint("RIGHT", -30, 0);
    win.name:SetAutoFocus(false);
    win.name:SetScript("OnTextChanged", function(self)
            win.filter.name = self:GetText();
        end);
    win.name:SetScript("OnShow", function(self)
            win.filter.name = win.filter.name or "";
            self:SetText(win.filter.name);
        end);
    win.name:SetScript("OnEscapePressed", function(self) self:ClearFocus() end);
    options.AddFramedBackdrop(win.name);
    
    --create filter by
    win.byText = win:CreateFontString(win:GetName().."By_Text", "OVERLAY", "ChatFontNormal");
    win.byText:SetText(L["Filter By"]..":");
    win.byText:SetTextColor(_G.GameFontNormal:GetTextColor());
    win.byText:SetPoint("TOPLEFT", win.nameText, "BOTTOMLEFT", 0, -20);
    win.by = CreateFrame("Frame", win:GetName().."By", win, "UIDropDownMenuTemplate");
    win.by:SetPoint("TOPLEFT", win.byText, "TOPLEFT", win.byText:GetStringWidth()+8, 8);
    win.by.click = function(self)
            self = self or _G.this;
            win.filter.type = self.value;
            _G.UIDropDownMenu_SetSelectedValue(win.by, self.value);
            win.by:Hide();
            win.by:Show();
        end
    win.by.init = function(self)
            local info = _G.UIDropDownMenu_CreateInfo();
            info.text = L["Pattern"];
            info.value = 1;
            info.func = win.by.click;
            _G.UIDropDownMenu_AddButton(info, _G.UIDROPDOWNMENU_MENU_LEVEL);
            local info = _G.UIDropDownMenu_CreateInfo();
            info.text = L["User Type"];
            info.value = 2;
            info.func = win.by.click;
            _G.UIDropDownMenu_AddButton(info, _G.UIDROPDOWNMENU_MENU_LEVEL);
            if(not win.isChat) then
                local info = _G.UIDropDownMenu_CreateInfo();
                info.text = L["Level"];
                info.value = 3;
                info.func = win.by.click;
                _G.UIDropDownMenu_AddButton(info, _G.UIDROPDOWNMENU_MENU_LEVEL);
            end
        end
    win.by:SetScript("OnShow", function(self)
            win.filter.type = win.filter.type or 1;
            _G.UIDropDownMenu_Initialize(self, self.init);
            _G.UIDropDownMenu_SetSelectedValue(self, win.filter.type);
            if(win.filter.type == 1) then
                win.patternContainer:Show();
                win.user:Hide();
                win.level:Hide();
            elseif(win.filter.type == 2) then
                win.patternContainer:Hide();
                win.user:Show();
                win.level:Hide();
            else
                win.patternContainer:Hide();
                win.user:Hide();
                win.level:Show();
            end
        end);
    
    -- create patterns box
    win.patternContainer = CreateFrame("ScrollFrame", win:GetName().."PatternContainer", win, "UIPanelScrollFrameTemplate");
    win.patternContainer:SetPoint("TOPLEFT", win.byText, "BOTTOMLEFT", 0, -25);
    win.patternContainer:SetPoint("RIGHT", -50, 0);
    win.patternContainer:SetHeight(95);
    options.AddFramedBackdrop(win.patternContainer);
    win.pattern = CreateFrame("EditBox", win:GetName().."Pattern", win.patternContainer);
    win.pattern:SetFontObject(_G.ChatFontNormal);
    win.pattern:SetMultiLine(true);
    win.patternContainer:SetScrollChild(win.pattern);
    win.pattern:SetWidth(win.patternContainer:GetWidth());
    win.pattern:SetHeight(200);
    win.pattern:SetAutoFocus(false);
    win.pattern:SetScript("OnTextChanged", function(self)
            win.filter.pattern = self:GetText();
            win.patternContainer:UpdateScrollChildRect();
        end);
    win.pattern:SetScript("OnShow", function(self)
            win.filter.pattern = win.filter.pattern or "";
            self:SetText(win.filter.pattern);
        end);
    win.pattern:SetScript("OnEscapePressed", function(self) self:ClearFocus() end);
    
    --create user options
    win.user = CreateFrame("Frame", win:GetName().."UserFrame", win);
    win.user:SetPoint("TOPLEFT", win.patternContainer, "TOPLEFT");
    win.user:SetPoint("BOTTOMLEFT", win.patternContainer, "BOTTOMLEFT");
    win.user:SetPoint("RIGHT", -30, 0)
    win.user:Hide();
    options.AddFramedBackdrop(win.user);
    win.user.friend = CreateFrame("CheckButton", win.user:GetName().."Friend", win.user, "UICheckButtonTemplate");
    win.user.friend:SetPoint("TOPLEFT", 0, 0);
    _G.getglobal(win.user.friend:GetName().."Text"):SetText(L["Friends"]);
    win.user.friend:SetScript("OnShow", function(self) self:SetChecked(win.filter.friend); end);
    win.user.friend:SetScript("OnClick", function(self) win.filter.friend = self:GetChecked(); end);
    win.user.guild = CreateFrame("CheckButton", win.user:GetName().."Guild", win.user, "UICheckButtonTemplate");
    win.user.guild:SetPoint("TOPLEFT", win.user.friend, "BOTTOMLEFT");
    _G.getglobal(win.user.guild:GetName().."Text"):SetText(L["Guild Members"]);
    win.user.guild:SetScript("OnShow", function(self) self:SetChecked(win.filter.guild); end);
    win.user.guild:SetScript("OnClick", function(self) win.filter.guild = self:GetChecked(); end);
    win.user.party = CreateFrame("CheckButton", win.user:GetName().."Party", win.user, "UICheckButtonTemplate");
    win.user.party:SetPoint("TOPLEFT", win.user.guild, "BOTTOMLEFT");
    _G.getglobal(win.user.party:GetName().."Text"):SetText(L["Party Members"]);
    win.user.party:SetScript("OnShow", function(self) self:SetChecked(win.filter.party); end);
    win.user.party:SetScript("OnClick", function(self) win.filter.party = self:GetChecked(); end);
    
    win.user.raid = CreateFrame("CheckButton", win.user:GetName().."Raid", win.user, "UICheckButtonTemplate");
    win.user.raid:SetPoint("TOPLEFT", win.user:GetWidth()/2, 0);
    _G.getglobal(win.user.raid:GetName().."Text"):SetText(L["Raid Members"]);
    win.user.raid:SetScript("OnShow", function(self) self:SetChecked(win.filter.raid); end);
    win.user.raid:SetScript("OnClick", function(self) win.filter.raid = self:GetChecked(); end);
    win.user.xrealm = CreateFrame("CheckButton", win.user:GetName().."XRealm", win.user, "UICheckButtonTemplate");
    win.user.xrealm:SetPoint("TOPLEFT", win.user.raid, "BOTTOMLEFT");
    _G.getglobal(win.user.xrealm:GetName().."Text"):SetText(L["Cross-Realm"]);
    win.user.xrealm:SetScript("OnShow", function(self) self:SetChecked(win.filter.xrealm); end);
    win.user.xrealm:SetScript("OnClick", function(self) win.filter.xrealm = self:GetChecked(); end);
    win.user.all = CreateFrame("CheckButton", win.user:GetName().."All", win.user, "UICheckButtonTemplate");
    win.user.all:SetPoint("TOPLEFT", win.user.xrealm, "BOTTOMLEFT");
    _G.getglobal(win.user.all:GetName().."Text"):SetText(L["Everyone"]);
    win.user.all:SetScript("OnShow", function(self)
            self:SetChecked(win.filter.all);
            if(not win.filter.all) then
                win.user.friend:Enable();   win.user.friend:SetAlpha(1);
                win.user.guild:Enable();    win.user.guild:SetAlpha(1);
                win.user.party:Enable();    win.user.party:SetAlpha(1);
                win.user.raid:Enable();     win.user.raid:SetAlpha(1);
                win.user.xrealm:Enable();   win.user.xrealm:SetAlpha(1);
            else
                win.user.friend:Disable();  win.user.friend:SetAlpha(.5);
                win.user.guild:Disable();   win.user.guild:SetAlpha(.5);
                win.user.party:Disable();   win.user.party:SetAlpha(.5);
                win.user.raid:Disable();    win.user.raid:SetAlpha(.5);
                win.user.xrealm:Disable();  win.user.xrealm:SetAlpha(.5);
            end
        end);
    win.user.all:SetScript("OnClick", function(self) win.filter.all = self:GetChecked(); self:Hide(); self:Show(); end);
    
    --create level options
    win.level = CreateFrame("Frame", win:GetName().."LevelFrame", win);
    win.level:SetPoint("TOPLEFT", win.patternContainer, "TOPLEFT");
    win.level:SetPoint("BOTTOMLEFT", win.patternContainer, "BOTTOMLEFT");
    win.level:SetPoint("RIGHT", -30, 0)
    win.level:Hide();
    options.AddFramedBackdrop(win.level);
    win.level.slider = CreateFrame("Slider", win.level:GetName().."Slider", win.level);
    -- set backdrop
    win.level.slider:SetBackdrop({bgFile = "Interface\\Buttons\\UI-SliderBar-Background", 
        edgeFile = "Interface\\Buttons\\UI-SliderBar-Border", 
        tile = true, tileSize = 8, edgeSize = 8, 
        insets = { left = 3, right = 3, top = 6, bottom = 6 }});
    win.level.slider:SetHeight(17);
    --win.level.slider:SetPoint("CENTER");
    win.level.slider:SetPoint("TOPLEFT", 20, -30);
    win.level.slider:SetPoint("RIGHT", -65, 0);
    win.level.slider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal");
    win.level.slider:SetOrientation("HORIZONTAL");
    win.level.slider:SetMinMaxValues(2, maxLevel);
    win.level.slider.title = win.level.slider:CreateFontString(win.level.slider:GetName().."Title", "OVERLAY", "ChatFontNormal");
    win.level.slider.title:SetPoint("BOTTOMLEFT", win.level.slider, "TOPLEFT", 0, 5);
    win.level.slider.title:SetText(L["User must be at least level:"]);
    win.level.slider.title:SetTextColor(_G.GameFontNormal:GetTextColor());
    win.level.slider.minText = win.level.slider:CreateFontString(win.level.slider:GetName().."Min", "OVERLAY", "ChatFontSmall");
    win.level.slider.minText:SetPoint("TOPLEFT", win.level.slider, "BOTTOMLEFT", 5, 0);
    win.level.slider.minText:SetText("2");
    win.level.slider.maxText = win.level.slider:CreateFontString(win.level.slider:GetName().."Max", "OVERLAY", "ChatFontSmall");
    win.level.slider.maxText:SetPoint("TOPRIGHT", win.level.slider, "BOTTOMRIGHT", -5, 0);
    win.level.slider.maxText:SetText(maxLevel);
    win.level.slider.valText = win.level.slider:CreateFontString(win.level.slider:GetName().."Val", "OVERLAY", "ChatFontSmall");
    win.level.slider.valText:SetPoint("LEFT", win.level.slider, "RIGHT", 15, 2);
    win.level.slider.valText:SetTextColor(_G.GameFontNormal:GetTextColor());
    win.level.slider.valText:SetText("");
    win.level.slider:SetValueStep(1);
    win.level.slider:SetScript("OnValueChanged", function(self)
            self.valText:SetText(self:GetValue());
            win.filter.level = self:GetValue();
        end);
    win.level.slider:SetScript("OnShow", function(self)
            win.filter.level = win.filter.level or 2;
            self:SetValue(tonumber(win.filter.level));
        end);
    win.level.classText = win.level:CreateFontString(win:GetName().."ClassSpecific", "OVERLAY", "ChatFontSmall");
    win.level.classText:SetText(L["Apply to:"]);
    win.level.classText:SetPoint("TOPLEFT", 20, -70);
    win.level.classText:SetTextColor(_G.GameFontNormal:GetTextColor());
    win.level.class = CreateFrame("Frame", win:GetName().."ClassList", win.level, "UIDropDownMenuTemplate");
    win.level.class:SetPoint("TOPLEFT", win.level.classText, "TOPLEFT", win.level.classText:GetStringWidth()+8, 8);
    win.level.class.click = function(self)
            self = self or _G.this;
            win.filter.classSpecific = self.value;
            _G.UIDropDownMenu_SetSelectedValue(win.level.class, self.value);
            win.level.class:Hide();
            win.level.class:Show();
        end
    win.level.class.init = function(self)
            local info = _G.UIDropDownMenu_CreateInfo();
            info.text = L["All Classes"];
            info.value = 0;
            info.func = win.level.class.click;
	    local classes = constants.classListEng;
	    _G.UIDropDownMenu_AddButton(info, _G.UIDROPDOWNMENU_MENU_LEVEL);
	    for i=1, #classes do
                local info = _G.UIDropDownMenu_CreateInfo();
                info.text = L[classes[i]];
                info.value = constants.classes[L[classes[i]]].tag;
                info.func = win.level.class.click;
		_G.UIDropDownMenu_AddButton(info, _G.UIDROPDOWNMENU_MENU_LEVEL);
	    end
        end
    win.level.class:SetScript("OnShow", function(self)
            win.filter.classSpecific = win.filter.classSpecific or 0;
            _G.UIDropDownMenu_Initialize(self, self.init);
            _G.UIDropDownMenu_SetSelectedValue(self, win.filter.classSpecific);
        end);

    
    
    
    --create incoming out going
    win.received = CreateFrame("CheckButton", win:GetName().."In", win, "UICheckButtonTemplate");
    win.received:SetPoint("TOPLEFT", win.patternContainer, "BOTTOMLEFT", 0, -10);
    win.received.text = _G.getglobal(win.received:GetName().."Text");
    win.received.text:SetText(L["Apply to messages received."]);
    win.received:SetScript("OnShow", function(self)
            win.filter.received = win.filter.received;
            self:SetChecked(win.filter.received);
        end);
    win.received:SetScript("OnClick", function(self)
            win.filter.received = self:GetChecked() and true or nil;
        end);
    win.sent = CreateFrame("CheckButton", win:GetName().."Out", win, "UICheckButtonTemplate");
    win.sent:SetPoint("TOPLEFT", win.received, "TOPRIGHT", win.received.text:GetStringWidth() + 10, 0);
    _G.getglobal(win.sent:GetName().."Text"):SetText(L["Apply to messages sent."]);
    win.sent:SetScript("OnShow", function(self)
            win.filter.sent = win.filter.sent;
            self:SetChecked(win.filter.sent);
        end);
    win.sent:SetScript("OnClick", function(self)
            win.filter.sent = self:GetChecked() and true or nil;
        end);
        
        
    --create action
    win.actionText = win:CreateFontString(win:GetName().."Action_Text", "OVERLAY", "ChatFontNormal");
    win.actionText:SetText(L["Action to Perform:"]);
    win.actionText:SetTextColor(_G.GameFontNormal:GetTextColor());
    win.actionText:SetPoint("TOPLEFT", win.received, "BOTTOMLEFT", 0, -20);
    win.action = CreateFrame("Frame", win:GetName().."Action", win, "UIDropDownMenuTemplate");
    win.action:SetPoint("TOPLEFT", win.actionText, "TOPLEFT", win.actionText:GetStringWidth()+8, 8);
    win.action.click = function(self)
            self = self or _G.this;
            win.filter.action = self.value;
            _G.UIDropDownMenu_SetSelectedValue(win.action, self.value);
            win.action:Hide();
            win.action:Show();
        end
    win.action.init = function(self)
            local info = _G.UIDropDownMenu_CreateInfo();
            info.text = L["Allow"];
            info.value = 1;
            info.func = win.action.click;
            _G.UIDropDownMenu_AddButton(info, _G.UIDROPDOWNMENU_MENU_LEVEL);
            local info = _G.UIDropDownMenu_CreateInfo();
            info.text = L["Ignore"];
            info.value = 2;
            info.func = win.action.click;
            _G.UIDropDownMenu_AddButton(info, _G.UIDROPDOWNMENU_MENU_LEVEL);
            local info = _G.UIDropDownMenu_CreateInfo();
            info.text = L["Blocked"];
            info.value = 3;
            info.func = win.action.click;
            _G.UIDropDownMenu_AddButton(info, _G.UIDROPDOWNMENU_MENU_LEVEL);
        end
    win.actionNotify = CreateFrame("CheckButton", win:GetName().."Notify", win, "UICheckButtonTemplate");
    win.actionNotify:SetPoint("LEFT", win.action, "RIGHT", 130, 2);
    win.actionNotify.text = _G.getglobal(win.actionNotify:GetName().."Text");
    win.actionNotify.text:SetText(L["Show Alert"]);
    win.actionNotify:SetScript("OnShow", function(self)
            win.filter.notify = win.filter.notify;
            self:SetChecked(win.filter.notify);
        end);
    win.actionNotify:SetScript("OnClick", function(self)
            win.filter.notify = self:GetChecked() and true or nil;
        end);
        
    win.action:SetScript("OnShow", function(self)
            win.filter.action = win.filter.action or 2;
            _G.UIDropDownMenu_Initialize(self, self.init);
            _G.UIDropDownMenu_SetSelectedValue(self, win.filter.action);
            if(win.filter.action ~= 3) then
                win.actionNotify:Hide();
            else
                win.actionNotify:Show();
            end
        end);
    
    
    -- cancel / save
    win.border = win:CreateTexture(nil, "OVERLAY");
    win.border:SetHeight(1);
    win.border:SetWidth(win:GetWidth() - 60);
    win.border:SetPoint("BOTTOM", 0, 55);
    win.border:SetTexture(1, 1, 1, .25);
    win.save = CreateFrame("Button", win:GetName().."Save", win, "UIPanelButtonTemplate2");
    win.save:SetPoint("TOPRIGHT", win.border, "BOTTOMRIGHT", 0, -5);
    win.save.text = _G[win.save:GetName().."Text"];
    win.save.text:SetText(L["Save"]);
    win.save:SetWidth(win.save.text:GetStringWidth()+60);
    win.save:SetScript("OnClick", function(self)
	    if win.filter.classSpecific == 0 then
		win.filter.classSpecific = nil;
	    end
            if(win.saveIndex) then
                -- save edited filter
                local filters = win.isChat and chatFilters or filters;
                filters[win.saveIndex] = win.filter;
            else
                -- add new filter
                local filters = win.isChat and chatFilters or filters;
                win.filter.enabled = true;
                win.filter.stats = 0;
                table.insert(filters, 1, win.filter);
                if(win.isChat) then
                    options.frame.chatFilterList.selected = 1;
                else
                    options.frame.filterList.selected = 1;
                end
            end
            win:Hide();
        end);
    win.cancel = CreateFrame("Button", win:GetName().."Cancel", win, "UIPanelButtonTemplate2");
    win.cancel:SetPoint("TOPRIGHT", win.save, "TOPLEFT", -10, 0);
    win.cancel.text = _G[win.cancel:GetName().."Text"];
    win.cancel.text:SetText(L["Cancel"]);
    win.cancel:SetWidth(win.cancel.text:GetStringWidth()+60);
    win.cancel:SetScript("OnClick", function(self) win:Hide(); end);
        
    -- window actions
    win:SetScript("OnShow", function(self)
            _G.PlaySound("igMainMenuOpen");
            if(options.frame) then
                options.frame:Disable();
            end
        end);
    win:SetScript("OnHide", function(self)
            self.saveIndex = nil;
            _G.PlaySound("igMainMenuClose");
            if(options.frame) then
                options.frame:Enable();
            end
            if(self.isChat) then
                options.frame.chatFilterList:Hide();
                options.frame.chatFilterList:Show();
            else
                options.frame.filterList:Hide();
                options.frame.filterList:Show();
            end
        end);
    
    table.insert(_G.UISpecialFrames,win:GetName());
    
    return win;
end







function ShowFilterFrame(filter, index, isChat)
    if(not options.frame or not (options.frame.filterList or options.frame.chatFilterList)) then
        -- no reason for this frame to be called when options window has not been loaded.
        return;
    end
    if(not filterFrame) then
        filterFrame = createFilterFrame();
    end
    filterFrame.filter = {};
    if(type(filter) == "table" and type(index) == "number") then
        filterFrame.saveIndex = index;
	for key, val in pairs(filter) do
	    filterFrame.filter[key] = val;
	end
    end
    filterFrame.title:SetText(filterFrame.saveIndex and L["Edit Filter"] or L["Add Filter"]);
    filterFrame.isChat = isChat;
    filterFrame:Show();
end


WIM.RegisterItemRefHandler("WIMBLOCKED", function (link)
    local msgId = _G.tonumber(link:match("(%d+)"));
    if(msgId and blockedEvents[msgId]) then
        local event = blockedEvents[msgId][1];
        local args = {"\009\002"..blockedEvents[msgId][2],
            blockedEvents[msgId][3], blockedEvents[msgId][4], blockedEvents[msgId][5], blockedEvents[msgId][6],
            blockedEvents[msgId][7], blockedEvents[msgId][8], blockedEvents[msgId][9], blockedEvents[msgId][10],
            blockedEvents[msgId][11], blockedEvents[msgId][12]};
        local win;
        if(event:find("WHISPER_INFORM")) then
            modules.WhisperEngine:CHAT_MSG_WHISPER_INFORM(_G.unpack(args));
        elseif(event:find("WHISPER")) then
            modules.WhisperEngine:CHAT_MSG_WHISPER(_G.unpack(args));
        elseif(event:find("RAID_LEADER")) then
            modules.RaidChat:CHAT_MSG_RAID_LEADER(_G.unpack(args));
        elseif(event:find("RAID")) then
            modules.RaidChat:CHAT_MSG_RAID(_G.unpack(args));
        elseif(event:find("GUILD")) then
            modules.GuildChat:CHAT_MSG_GUILD(_G.unpack(args));
        elseif(event:find("OFFICER")) then
            modules.OfficerChat:CHAT_MSG_OFFICER(_G.unpack(args));
        elseif(event:find("PARTY")) then
            modules.PartyChat:CHAT_MSG_PARTY(_G.unpack(args));
        elseif(event:find("SAY")) then
            modules.SayChat:CHAT_MSG_SAY(_G.unpack(args));
        elseif(event:find("CHANNEL")) then
            modules.ChannelChat:CHAT_MSG_CHANNEL(_G.unpack(args));
        end
    end
end);


local function blockCatcher(msg, smf)
    if(msg and msg:match("\009\002")) then
        smf:AddMessage("    ");
        smf:AddMessage("|cffff0000"..L["Blocked Message"]..":|r");
	if(smf.parentWindow) then
            smf.parentWindow:Pop(true);
	end
        msg = msg:gsub("\009\002", "");
    end
    return msg;
end
RegisterStringModifier(blockCatcher, true);
