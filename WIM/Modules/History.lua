--imports
local WIM = WIM;
local _G = _G;
local table = table;
local string = string;
local pairs = pairs;
local CreateFrame = CreateFrame;
local date = date;
local time = time;
local select = select;

--set namespace
setfenv(1, WIM);

local History = CreateModule("History", true);

-- default history settings.
db_defaults.history = {
    preview = true,
    previewCount = 25,
    maxPer = true,
    maxCount = 500,
    ageLimit = true,
    maxAge = 60*60*24*7*2,
    whispers = {
        friends = true,
        guild = true,
        all = false
    },
    chat = {
        preview = true,
        previewCount = 25,
        maxPer = true,
        maxCount = 500,
        ageLimit = true,
        maxAge = 60*60*24*7*2,
    }
};
db_defaults.displayColors.historyIn = {
    r=0.4705882352941176,
    g=0.4705882352941176,
    b=0.4705882352941176
};
db_defaults.displayColors.historyOut = {
    r=0.7058823529411764,
    g=0.7058823529411764,
    b=0.7058823529411764
};

local dDay = 60*60*24;
local dWeek = dDay*7;
local dMonth = dWeek*4;
local dYear = dMonth*12;

local tmpTable = {};

local ViewTypes = {};

local ChannelCache = {};

local function clearTmpTable()
    for key, _ in pairs(tmpTable) do
        tmpTable[key] = nil;
    end
end

local function isEmptyTable(tbl)
    for k, _ in pairs(tbl) do
        if(k ~= "info") then
            return false;
        end
    end
    return true;
end

local function getPlayerHistoryTable(convoName)
    if(history[env.realm] and history[env.realm][env.character] and history[env.realm][env.character][convoName]) then
        return history[env.realm][env.character][convoName];
    else
        -- this player hasn't been set up yet. Do it now.
        history[env.realm] = history[env.realm] or {};
        history[env.realm][env.character] = history[env.realm][env.character] or {};
        history[env.realm][env.character][convoName] = history[env.realm][env.character][convoName] or {info = {}};
        return history[env.realm][env.character][convoName];
    end
end


local function createWidget()
    local button = _G.CreateFrame("Button");
    button.SetHistory = function(self, isHistory)
        self.parentWindow.isHistory = isHistory;
        if(isHistory and modules.History.enabled) then
            self:SetAlpha(1);
            DisplayTutorial(L["WIM History Button"], _G.format(L["Clicking the %s button on the message window will show that user's history in WIM's History Viewer."],
                    "|T"..GetSelectedSkin().message_window.widgets.history.NormalTexture..":0:0:0:0|t"));
        else
            self:SetAlpha(0);
        end
    end
    button.UpdateProps = function(self)
        self:SetHistory(self.parentWindow.isHistory);
    end
    button:SetScript("OnEnter", function(self)
        if(db.showToolTips == true and self.parentWindow.isHistory) then
            _G.GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT");
            _G.GameTooltip:SetText(L["Click to view message history."]);
        end
    end);
    button:SetScript("OnLeave", function(self)
        _G.GameTooltip:Hide();
    end);
    button:SetScript("OnClick", function(self, button)
        if(self.parentWindow.isHistory) then
            ShowHistoryViewer(self.parentWindow.theUser);
        end
    end);
    return button;
end


local function recordWhisper(inbound, ...)
    local msg, from = ...;
    local db = db.history.whispers;
    local win = windows.active.whisper[from] or windows.active.chat[from] or windows.active.w2w[from];
    if(win and (lists.gm[from] or db.all or (db.friends and (lists.friends[from] or win.isBN)) or (db.guild and lists.guild[from]))) then
        win.widgets.history:SetHistory(true);
        local history = getPlayerHistoryTable(from);
        history.info.gm = lists.gm[from];
        table.insert(history, {
            convo = from,
            type = 1, -- whisper
            inbound = inbound or false,
            from = inbound and from or env.character,
            msg = msg,
            time = _G.time();
        });
        if(WIM.db.history.maxPer) then
            while(WIM.db.history.maxCount < #history) do
                table.remove(history, 1);
            end
        end
    end
end

function History:PostEvent_Whisper(...)
    recordWhisper(true, ...);
end

function History:PostEvent_WhisperInform(...)
    recordWhisper(false, ...);
end

local function deleteOldHistory(isChat)
    local historyDB = isChat and db.history.chat or db.history;
    local count = 0;
    for realm, characters in pairs(history) do
        for character, convos in pairs(characters) do
            for convo, messages in pairs(convos) do
                for i=#messages, 1, -1 do
                    if((time() - messages[i].time) > historyDB.maxAge and ((isChat and messages[i].type == 2) or (not isChat and messages[i].type == 1))) then
                        dPrint("Deleting History."..realm.."."..character.."."..convo.."["..i.."]");
                        table.remove(messages, i);
                        count = count + 1;
                    end
                end
                if(isEmptyTable(messages)) then convos[convo] = nil; end
            end
            if(isEmptyTable(convos)) then characters[character] = nil; end
        end
        if(isEmptyTable(characters)) then history[realm] = nil; end
    end
    if(count > 0) then
        _G.DEFAULT_CHAT_FRAME:AddMessage(_G.format(L["WIM pruned %d |4message:messages; from your history."], count));
    end
end

function History:OnEnableWIM()
    -- clean up history if asked to.
    if(db.history.ageLimit) then
        deleteOldHistory();
    end
end

function History:OnEnable()
    RegisterWidget("history", createWidget);
    for widget in Widgets("history") do
        local win = widget.parentWindow;
        if(win) then
            local history = history[env.realm] and history[env.realm][env.character] and history[env.realm][env.character][win.theUser] and win.type == "whisper";
            if(history) then
                widget:SetHistory(true);
            end
        end
    end
end

function History:OnDisable()
    if(db.modules.History.enabled) then
        return;
    end
    for widget in Widgets("history") do
        if(widget.parentWindow.type == "whisper") then
            widget:SetHistory(false); -- module is disabled, hide Icons.
        end
    end
end

function History:OnWindowDestroyed(win)
    win.isHistory = nil;
end

function History:OnWindowCreated(win)
    if(db.history.preview) then
        local history = history[env.realm] and history[env.realm][env.character] and history[env.realm][env.character][win.theUser];
        if(history) then
            local type = win.type == "whisper" and 1;
            for i=#history, 1, -1 do
                table.insert(tmpTable, 1, history[i]);
                if(#tmpTable >= db.history.previewCount) then
                    break;
                end
            end
            if(#tmpTable > 0) then
                win.isHistory = true;
                win.widgets.history:SetHistory(true);
                for i=1, #tmpTable do
                    local color = db.displayColors[tmpTable[i].inbound and "historyIn" or "historyOut"];
                    win.nextStamp = tmpTable[i].time;
                    win.nextStampColor = db.displayColors.historyOut;
                    win:AddMessage(applyMessageFormatting(win.widgets.chat_display, "CHAT_MSG_WHISPER", tmpTable[i].msg, tmpTable[i].from,
                                    nil, nil, nil, nil, nil, nil, nil, nil, -i), color.r, color.g, color.b);
                end
                win.widgets.chat_display:AddMessage(" ");
            end
            clearTmpTable();
        end
    end
end


--Chat History
local ChatHistory = CreateModule("HistoryChat");

-- synonymous functions
ChatHistory.OnWindowDestroyed = History.OnWindowDestroyed;


function ChatHistory:OnEnableWIM()
    -- clean up history if asked to.
    if(db.history.chat.ageLimit) then
        deleteOldHistory(true);
    end
end

function ChatHistory:OnEnable()
    RegisterWidget("history", createWidget);
    for widget in Widgets("history") do
        local win = widget.parentWindow;
        if(win) then
            local chatName = win.theUser
            local history = history[env.realm] and history[env.realm][env.character] and history[env.realm][env.character][chatName] and win.type == "chat";
            if(history) then
                widget:SetHistory(true);
            end
        end
    end
end

function ChatHistory:OnDisable()
    if(db.modules.HistoryChat.enabled) then
        return;
    end
    for widget in Widgets("history") do
        if(widget.parentWindow.type == "chat") then
            widget:SetHistory(false); -- module is disabled, hide Icons.
        end
    end
end


local function recordChannelChat(recordAs, ChannelType, ...)
    local msg, from = ...;
    local db = db.history.whispers;
    local win = windows.active.chat[recordAs];
    if(win) then
        win.widgets.history:SetHistory(true);
        local history = getPlayerHistoryTable(recordAs);
        history.info.chat = true;
        history.info.channelNumber = channelNumber;
        _G.test = history;
        table.insert(history, {
            event = ChannelType,
            channelName = recordAs,
            type = 2, -- chat
            from = from,
            msg = msg,
            time = _G.time();
        });
        if(WIM.db.history.chat.maxPer) then
            while(WIM.db.history.chat.maxCount < #history) do
                table.remove(history, 1);
            end
        end
    end
end


function ChatHistory:PostEvent_ChatMessage(event, ...)
    local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11 = ...;
    event = event:gsub("CHAT_MSG_", "");
    if(event == "CHANNEL") then
        local recordAs;
        local isWorld = arg7 and arg7 > 0;
        local chatType = isWorld and "world" or "custom";
        local channelName = string.split(" - ", arg9);
        local channelNumber = arg8;
        recordAs = channelName;
        if(recordAs and ((isWorld and db.history.chat.world) or (not isWorld and db.history.chat.custom))) then
            local noHistory = db.chat[isWorld and "world" or "custom"].channelSettings[channelName] and db.chat[isWorld and "world" or "custom"].channelSettings[channelName].noHistory;
            if(not noHistory) then
                recordChannelChat(recordAs, event, ...);
            end
        end
    else
        local recordAs;
        local chatType;
        if(event == "GUILD" and db.history.chat.guild) then
            recordAs = _G.GUILD;
            chatType = "guild";
        elseif(event == "OFFICER" and db.history.chat.officer) then
            recordAs = _G.GUILD_RANK1_DESC;
            chatType = "officer";
        elseif((event == "PARTY" or event == "PARTY_LEADER") and db.history.chat.party) then
            recordAs = _G.PARTY;
            chatType = "party";
        elseif((event == "RAID" or event == "RAID_LEADER") and db.history.chat.raid) then
            recordAs = _G.RAID;
            chatType = "raid";
        elseif((event == "BATTLEGROUND" or event == "BATTLEGROUND_LEADER") and db.history.chat.battleground) then
            recordAs = _G.BATTLEGROUND;
            chatType = "battleground";
        elseif(event == "SAY" and db.history.chat.say) then
            recordAs = _G.SAY;
            chatType = "say";
        end
        
        if(recordAs) then
            recordChannelChat(recordAs, event, ...);
        end
    end
end


--------------------------------------
--          History Viewer          --
--------------------------------------

local function searchResult(msg, search)
    search = string.lower(string.trim(search));
    msg = string.lower(msg);
    local start, stop, match = string.find(search, "([^%s]+)",1);
    while(match) do
        if(not string.find(msg, match)) then
            return false;
        end
        start, stop, match = string.find(search, "([^%s]+)",stop+1);
    end
    return true;
end


local function createHistoryViewer()
    local win = CreateFrame("Frame", "WIM3_HistoryFrame", _G.UIParent);
    win:Hide();
    win.filter = {};
    -- set size and position
    win:SetWidth(700);
    win:SetHeight(505);
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
    win:SetMinResize(600, 400);

    -- set script events
    win:SetScript("OnDragStart", function(self) self:StartMoving(); end);
    win:SetScript("OnDragStop", function(self) self:StopMovingOrSizing(); end);
    
    -- create and set title bar text
    win.title = win:CreateFontString(win:GetName().."Title", "OVERLAY", "ChatFontNormal");
    win.title:SetPoint("TOPLEFT", 50 , -20);
    local font = win.title:GetFont();
    win.title:SetFont(font, 16, "");
    win.title:SetText(L["History Viewer"])
    
    -- create close button
    win.close = CreateFrame("Button", win:GetName().."Close", win);
    win.close:SetWidth(18); win.close:SetHeight(18);
    win.close:SetPoint("TOPRIGHT", -24, -20);
    win.close:SetNormalTexture("Interface\\AddOns\\"..addonTocName.."\\Sources\\Options\\Textures\\blipRed");
    win.close:SetHighlightTexture("Interface\\AddOns\\"..addonTocName.."\\Sources\\Options\\Textures\\close", "BLEND");
    win.close:SetScript("OnClick", function(self)
            self:GetParent():Hide();
        end);
    
    -- window actions
    win:SetScript("OnShow", function(self)
            _G.PlaySound("igMainMenuOpen");
            self.UpdateUserList();
        end);
    win:SetScript("OnHide", function(self) _G.PlaySound("igMainMenuClose"); end);
    table.insert(_G.UISpecialFrames,win:GetName());
    
    -- create nav
    win.nav = CreateFrame("Frame", nil, win);
    win.nav.border = win.nav:CreateTexture(nil, "BACKGROUND");
    win.nav.border:SetTexture(1,1,1,.25);
    win.nav.border:SetPoint("TOPRIGHT");
    win.nav.border:SetPoint("BOTTOMRIGHT");
    win.nav.border:SetWidth(2);
    win.nav:SetPoint("TOPLEFT", 18, -47);
    win.nav:SetPoint("BOTTOMLEFT", 18, 18);
    win.nav:SetWidth(200);
    win.nav.user = CreateFrame("Frame", "WIM3_HistoryUserMenu", win.nav, "UIDropDownMenuTemplate");
    win.nav.user:SetPoint("TOPLEFT", -15, 0);
    _G.UIDropDownMenu_SetWidth(win.nav.user, win.nav:GetWidth() - 25);

    win.nav.user.list = {};
    win.nav.user.getUserList = function(self)
            for key, _ in pairs(self.list) do
                self.list[key] = nil;
            end
            local thisToon = env.realm.."/"..env.character;
            for realm, users in pairs(history) do
                table.insert(self.list, realm);
                for user, _ in pairs(users) do
                    if(thisToon == realm.."/"..user) then
                        thisToon = nil;
                    end
                    table.insert(self.list, realm.."/"..user);
                end
            end
            if(thisToon) then
                table.insert(self.list, 1, thisToon);
            end
            table.sort(self.list);
            return self.list;
        end
    win.nav.user.init = function()
            local self = win.nav.user;
            local list = self:getUserList();
            for i=1, #list do
                local info = _G.UIDropDownMenu_CreateInfo();
                info.text = list[i];
                info.value = list[i];
                info.func = function(self)
                        self = self or _G.this;
                        win.USER = self.value;
                        win.CONVO = "";
                        win.FILTER = "";
                        win.UpdateUserList();
                        _G.UIDropDownMenu_SetSelectedValue(win.nav.user, self.value);
                    end;
                _G.UIDropDownMenu_AddButton(info, _G.UIDROPDOWNMENU_MENU_LEVEL);
            end
        end
    win.nav.user:SetScript("OnShow", function(self)
            _G.UIDropDownMenu_Initialize(self, self.init);
            _G.UIDropDownMenu_SetSelectedValue(self, win.USER);
        end);
    win.nav.filters = CreateFrame("Frame", nil, win.nav);
    win.nav.filters:SetPoint("BOTTOMLEFT");
    win.nav.filters:SetPoint("BOTTOMRIGHT", -2, 0);
    win.nav.filters:SetHeight(125);
    win.nav.filters.border = win.nav.filters:CreateTexture(nil, "BACKGROUND");
    win.nav.filters.border:SetTexture(1, 1, 1, .25);
    win.nav.filters.border:SetPoint("TOPLEFT");
    win.nav.filters.border:SetPoint("TOPRIGHT");
    win.nav.filters.border:SetHeight(20);
    win.nav.filters.text = win.nav.filters:CreateFontString(nil, "OVERLAY", "ChatFontNormal");
    win.nav.filters.text:SetPoint("TOPLEFT", win.nav.filters.border);
    win.nav.filters.text:SetPoint("BOTTOMRIGHT", win.nav.filters.border);
    win.nav.filters.text:SetText(L["Filters"]);
    win.nav.filters.text:SetTextColor(_G.GameFontNormal:GetTextColor());
    win.nav.filters.scroll = CreateFrame("ScrollFrame", "WIM3_HistoryFilterListScroll", win.nav.filters, "FauxScrollFrameTemplate");
    win.nav.filters.scroll:SetPoint("TOPLEFT", 0, -22);
    win.nav.filters.scroll:SetPoint("BOTTOMRIGHT", -23, 0);
    win.nav.filters.scroll.buttons = {};
    win.nav.filters.scroll.createButton = function()
            local button = CreateFrame("Button", nil, win.nav.filters);
                if(#win.nav.filters.scroll.buttons > 0) then
                    button:SetPoint("TOPLEFT", win.nav.filters.scroll.buttons[#win.nav.filters.scroll.buttons], "BOTTOMLEFT");
                    button:SetPoint("TOPRIGHT", win.nav.filters.scroll.buttons[#win.nav.filters.scroll.buttons], "BOTTOMRIGHT");
                else
                    button:SetPoint("TOPLEFT", win.nav.filters.scroll);
                    button:SetPoint("TOPRIGHT", win.nav.filters.scroll);
                end
                button:SetHeight(20);
                button:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight" , "ADD");
                button:GetHighlightTexture():SetVertexColor(.196, .388, .5);
                
                button.text = button:CreateFontString(nil, "OVERLAY", "ChatFontNormal");
                button.text:SetAllPoints();
                button.text:SetJustifyH("LEFT");
                
                button.SetFilter = function(self, filter)
                        self.filter = filter;
                        if(_G.type(filter) == "number") then
                            self.text:SetText("     "..date(L["_DateFormat"], filter));
                        else
                            self.filter = "";
                            self.text:SetText("     "..filter);
                        end
                    end
                button:SetScript("OnClick", function(self)
                        win.FILTER = self.filter;
                        win.nav.filters.scroll.update();
                        win.UpdateDisplay();
                    end);
                
                table.insert(win.nav.filters.scroll.buttons, button);
            return button;
        end
    for i=1, 5 do
        win.nav.filters.scroll.createButton();
    end
    win.nav.filters.scroll.update = function()
            local self = win.nav.filters.scroll;
            local offset = _G.FauxScrollFrame_GetOffset(self);
            for i=1, #self.buttons do
                local index = i + offset;
                if(index <= #win.FILTERLIST) then
                    self.buttons[i]:SetFilter(win.FILTERLIST[index]);
                    self.buttons[i]:Show();
                    if(self.buttons[i].filter == win.FILTER) then
                        self.buttons[i]:LockHighlight();
                    else
                        self.buttons[i]:UnlockHighlight();
                    end
                else
                    self.buttons[i]:Hide();
                end
            end
            
            _G.FauxScrollFrame_Update(self, #win.FILTERLIST, 5, 20);
        end
    win.nav.filters.scroll:SetScript("OnShow", function(self)
            self:update();
        end);
    win.nav.filters.scroll:SetScript("OnVerticalScroll", function(self, offset)
            _G.FauxScrollFrame_OnVerticalScroll(self, offset, 20, win.nav.filters.scroll.update);
        end);

    win.nav.userList = CreateFrame("Frame", nil, win.nav);
    win.nav.userList:SetPoint("BOTTOMLEFT", win.nav.filters, "TOPLEFT", 0, 1);
    win.nav.userList:SetPoint("BOTTOMRIGHT", win.nav.filters, "TOPRIGHT", 0, 1);
    win.nav.userList:SetPoint("TOP", 0, -30);
    win.nav.userList.border = win.nav.userList:CreateTexture(nil, "BACKGROUND");
    win.nav.userList.border:SetTexture(1,1,1,.25);
    win.nav.userList.border:SetPoint("TOPLEFT", 0, 1);
    win.nav.userList.border:SetPoint("TOPRIGHT", 0, 1);
    win.nav.userList.border:SetHeight(1);
    win.nav.userList.scroll = CreateFrame("ScrollFrame", "WIM3_HistoryUserListScroll", win.nav.userList, "FauxScrollFrameTemplate");
    win.nav.userList.scroll:SetPoint("TOPLEFT", 0, -2);
    win.nav.userList.scroll:SetPoint("BOTTOMRIGHT", -23, 0);
    win.nav.userList.scroll.buttons = {};
    win.nav.userList.scroll.createButton = function()
            local button = CreateFrame("Button", nil, win.nav.userList);
                if(#win.nav.userList.scroll.buttons > 0) then
                    button:SetPoint("TOPLEFT", win.nav.userList.scroll.buttons[#win.nav.userList.scroll.buttons], "BOTTOMLEFT");
                    button:SetPoint("TOPRIGHT", win.nav.userList.scroll.buttons[#win.nav.userList.scroll.buttons], "BOTTOMRIGHT");
                else
                    button:SetPoint("TOPLEFT", win.nav.userList.scroll);
                    button:SetPoint("TOPRIGHT", win.nav.userList.scroll);
                end
                button:SetHeight(20);
                button:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight" , "ADD");
                button:GetHighlightTexture():SetVertexColor(.196, .388, .5);
                
                button.text = button:CreateFontString(nil, "OVERLAY", "ChatFontNormal");
                button.text:SetPoint("TOPLEFT");
                button.text:SetPoint("BOTTOMRIGHT", -18, 0);
                button.text:SetJustifyH("LEFT");
                
                button.SetUser = function(self, user)
                        local original, extra, color = user, "";
                        local user, gmTag = string.match(original, "([^*]+)(*?)$");
                        color = gmTag == "*" and constants.classes[L["Game Master"]].color or "ffffff";
                        if(string.match(original, "^*")) then
                            extra = " |TInterface\\AddOns\\WIM\\Skins\\Default\\minimap.tga:20:20:0:0|t";
                            color = "fff569";
                        end
                        self.user = user;
                        self.text:SetText("     |cff"..color..user.."|r"..extra..(gmTag == "*" and " |TInterface\\ChatFrame\\UI-ChatIcon-Blizz.blp:0:2:0:0|t" or ""));
                        if(user == win.SELECT) then
                            self:Click();
                        end
                    end
                button:SetScript("OnClick", function(self)
                        win:SelectConvo(self.user);
                        win.nav.userList.scroll.update();
                    end);
                button.delete = CreateFrame("Button", nil, button);
                button.delete:SetNormalTexture("Interface\\AddOns\\"..addonTocName.."\\Modules\\Textures\\xNormal");
                button.delete:SetPushedTexture("Interface\\AddOns\\"..addonTocName.."\\Modules\\Textures\\xPressed");
                button.delete:SetWidth(16);
                button.delete:SetHeight(16);
                button.delete:SetAlpha(.5);
                button.delete:SetPoint("RIGHT");
                button.delete:SetScript("OnClick", function(self)
                        _G.StaticPopupDialogs["WIM_DELETE_HISTORY"] = {
                            text = _G.format(L["Are you sure you want to delete all history saved for %s on %s?"],
                                "|cff69ccf0"..self:GetParent().user.."|r",
                                "|cff69ccf0"..win.USER.."|r"
                                ),
                            button1 = L["Yes"],
                            button2 = L["No"],
                            OnAccept = function()
                                local realm, character = string.match(win.USER, "^([^/]+)/?(.*)$");
                                if(realm and character and history[realm] and history[realm][character]) then
                                    history[realm][character][self:GetParent().user] = nil;
                                    if(isEmptyTable(history[realm][character])) then
                                        history[realm][character] = nil;
                                        if(isEmptyTable(history[realm])) then
                                            history[realm] = nil;
                                        end
                                    end
                                elseif(realm and history[realm]) then
                                    for character, convos in pairs(history[realm]) do
                                        convos[self:GetParent().user] = nil;
                                        if(isEmptyTable(convos)) then
                                            history[realm][character] = nil;
                                        end
                                    end
                                    if(isEmptyTable(history[realm])) then
                                        history[realm] = nil;
                                    end
                                end
                                win.nav.user:Hide();
                                win.nav.user:Show();
                                win.UpdateUserList();
                            end,
                            timeout = 0,
                            whileDead = 1,
                            hideOnEscape = 1
                        };
                        _G.StaticPopup_Show("WIM_DELETE_HISTORY");
                    end);
                
                table.insert(win.nav.userList.scroll.buttons, button);
            return button;
        end
    win.nav.userList.scroll.update = function()
            local self = win.nav.userList.scroll;
            local maxButtons = _G.math.floor(self:GetHeight()/20);
            local offset = _G.FauxScrollFrame_GetOffset(self);
            for i=1, #self.buttons do
                if(i <= maxButtons) then
                    self.buttons[i]:Show();
                    local index = i + offset;
                    if(index <= #win.USERLIST) then
                        self.buttons[i]:SetUser(win.USERLIST[index]);
                        self.buttons[i]:Show();
                        if(self.buttons[i].user == win.CONVO) then
                            self.buttons[i]:LockHighlight();
                        else
                            self.buttons[i]:UnlockHighlight();
                        end
                    else
                        self.buttons[i]:Hide();
                    end
                else
                    self.buttons[i]:Hide();
                end
            end
            
            _G.FauxScrollFrame_Update(self, #win.USERLIST, maxButtons, 20);
        end
    win.nav.userList.scroll:SetScript("OnShow", function(self)
            local maxButtons = _G.math.floor(self:GetHeight()/20);
            if(maxButtons > #self.buttons) then
                local toCreate = maxButtons - #self.buttons;
                for i=1, toCreate do
                    self.createButton();
                end
            end
            self:update();
        end);
    win.nav.userList.scroll:SetScript("OnVerticalScroll", function(self, offset)
            _G.FauxScrollFrame_OnVerticalScroll(self, offset, 20, win.nav.userList.scroll.update);
        end);
    
    --search bar
    win.search = CreateFrame("Frame", nil, win);
    win.search.bg = win.search:CreateTexture(nil, "BACKGROUND");
    win.search.bg:SetTexture(1,1,1,.25);
    win.search.bg:SetAllPoints();
    win.search:SetPoint("TOPLEFT", win.nav, "TOPRIGHT");
    win.search:SetPoint("RIGHT", -18, 0);
    win.search:SetHeight(30);
    win.search.clear = CreateFrame("Button", nil, win.search);
    win.search.clear:SetNormalTexture("Interface\\AddOns\\"..addonTocName.."\\Modules\\Textures\\xNormal");
    win.search.clear:SetPushedTexture("Interface\\AddOns\\"..addonTocName.."\\Modules\\Textures\\xPressed");
    win.search.clear:SetWidth(16);
    win.search.clear:SetHeight(16);
    win.search.clear:SetPoint("RIGHT", -5, 0)
    win.search.clear:SetScript("OnClick", function(self)
            win.search.text:ClearFocus();
            win.search.text:SetText("");
            for key, _ in pairs(win.SEARCHLIST) do
                win.SEARCHLIST[key] = nil;
            end
            win.search.result:Hide();
            win.UpdateFilterList();
            win.UpdateDisplay();
        end);
    win.search.text = CreateFrame("EditBox", nil, win.search);
    win.search.text:SetFontObject(_G.ChatFontNormal);
    win.search.text:SetWidth(200); win.search.text:SetHeight(15);
    win.search.text:SetPoint("RIGHT", win.search.clear, "LEFT", -5, 0);
    win.search.text:SetScript("OnEditFocusGained", function(self) self:HighlightText() end);
    win.search.text:SetScript("OnEditFocusLost", function(self) self:HighlightText(0, 0) end);
    win.search.text:SetScript("OnEnterPressed", function(self)
            for key, _ in pairs(win.SEARCHLIST) do
                win.SEARCHLIST[key] = nil;
            end
            local realm, character = string.match(win.USER, "^([^/]+)/?(.*)$");
            if(realm and character and history[realm] and history[realm][character]) then
                for convo, tbl in pairs(history[realm][character]) do
                    for i=1, #tbl do
                        if(searchResult(tbl[i].msg, self:GetText())) then
                            table.insert(win.SEARCHLIST, tbl[i]);
                        end
                    end
                end
            elseif(realm and history[realm]) then
                for character, convos in pairs(history[realm]) do
                    for convo, tbl in pairs(convos) do
                        for i=1, #tbl do
                            if(searchResult(tbl[i].msg, self:GetText())) then
                                table.insert(win.SEARCHLIST, tbl[i]);
                            end
                        end
                    end
                end
            end
            table.sort(win.SEARCHLIST, function(a, b)
                return a.time < b.time;
            end);
            if(#win.SEARCHLIST > 0) then
                win.search.result:SetText(_G.format(L["Search resulted in %d |4message:messages;."], #win.SEARCHLIST))
            else
                win.search.result:SetText("|cffff0000"..L["No results found!"].."|r");
            end
            win.search.result:Show();
            self:ClearFocus();
            win.UpdateFilterList();
            win.UpdateDisplay();
        end);
    options.AddFramedBackdrop(win.search.text);
    win.search.text:SetAutoFocus(false);
    win.search.text:SetScript("OnEscapePressed", function(self) self:ClearFocus() end);
    win.search.label = win.search:CreateFontString(nil, "OVERLAY", "ChatFontNormal");
    win.search.label:SetText(L["Search"]..":");
    win.search.label:SetTextColor(_G.GameFontNormal:GetTextColor());
    win.search.label:SetPoint("RIGHT", win.search.text, "LEFT", -5, 0);
    win.search.result = win.search:CreateFontString(nil, "OVERLAY", "ChatFontSmall");
    win.search.result:SetPoint("LEFT");
    win.search.result:SetPoint("RIGHT", win.search.label, "LEFT", -5, 0);
    win.search.result:Hide();
    
    
    --content frame
    win.content = CreateFrame("Frame", nil, win);
    win.content.border = win.content:CreateTexture(nil, "BACKGROUND");
    win.content.border:SetTexture(1,1,1,.25);
    win.content.border:SetPoint("BOTTOMLEFT");
    win.content.border:SetPoint("BOTTOMRIGHT");
    win.content.border:SetHeight(1);
    win.content:SetPoint("TOPLEFT", win.search, "BOTTOMLEFT");
    win.content:SetPoint("BOTTOMRIGHT", win, "BOTTOMRIGHT", -18, 40);
    
    win.content.tabs = {};
    win.content.createTab = function(self, index)
            local tab = CreateFrame("Button", nil, self);
            tab.index = index;
            tab.frame = ViewTypes[index].frame;
            tab:SetHeight(20);
            tab.text = tab:CreateFontString(nil, "OVERLAY", "ChatFontSmall");
            tab.text:SetAllPoints();
            tab.text:SetText(ViewTypes[index].text);
            tab.bg = tab:CreateTexture(nil, "BACKGROUND");
            tab.bg:SetTexture(1, 1, 1, .25);
            tab.bg:SetAllPoints();
            tab:SetWidth(tab.text:GetStringWidth() + 16);
            if(#self.tabs > 0) then
                tab:SetPoint("TOPLEFT", self.tabs[#self.tabs], "TOPRIGHT",2 ,0);
            else
                tab:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 5, 0);
            end
            tab:SetScript("OnClick", function(self)
                for i=1, #win.content.tabs do
                    if(win.progressBar:IsVisible()) then
                        win.progressBar.delete:Click();
                    end
                    if(self.index == i) then
                        win.content.tabs[i]:SetAlpha(1);
                        win.TAB = self.index;
                        if(self.frame == "chatFrame") then
                            win.content.chatFrame:Show();
                            win.content.textFrame:Hide();
                        else
                            win.content.textFrame:Show();
                            win.content.chatFrame:Hide();
                        end
                    else
                        win.content.tabs[i]:SetAlpha(.5);
                    end
                end
                win:UpdateDisplay();
            end);
            table.insert(self.tabs, tab);
        end
    for i=1, #ViewTypes do
        win.content:createTab(i);
    end
    
    
    win.content.chatFrame = CreateFrame("ScrollingMessageFrame", "WIM3_HistoryChatFrame", win.content);
    win.content.chatFrame:SetPoint("TOPLEFT", 4, -4);
    win.content.chatFrame:SetPoint("BOTTOMRIGHT", -30, 4);
    win.content.chatFrame:SetFontObject("ChatFontNormal");
    win.content.chatFrame:EnableMouse(true);
    win.content.chatFrame:EnableMouseWheel(true);
    win.content.chatFrame:SetJustifyH("LEFT");
    win.content.chatFrame:SetFading(false);
    win.content.chatFrame:SetMaxLines(800);
    win.content.chatFrame.update = function(self)
            if(self:AtTop()) then
		self.up:Disable();
            else
		self.up:Enable();
            end
            if(self:AtBottom()) then
                self.down:Disable();
            else
		self.down:Enable();
            end
        end
    win.content.chatFrame:SetScript("OnShow", function(self)
            self:update();
        end);
    win.content.chatFrame:SetScript("OnMouseWheel", function(self, ...)
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
	    self:update();
	end);
    win.content.chatFrame:SetScript("OnHyperlinkClick", _G.ChatFrame_OnHyperlinkShow);

    win.content.chatFrame.up = CreateFrame("Button", nil, win.content.chatFrame);
    win.content.chatFrame.up:SetWidth(28); win.content.chatFrame.up:SetHeight(28);
    win.content.chatFrame.up:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up");
    win.content.chatFrame.up:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Down");
    win.content.chatFrame.up:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Disabled");
    win.content.chatFrame.up:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD");
    win.content.chatFrame.up:SetPoint("TOPRIGHT", 30 ,0);
    win.content.chatFrame.up:SetScript("OnClick", function(self)
            local obj = self:GetParent();
	    if( _G.IsControlKeyDown() ) then
		obj:ScrollToTop();
	    else
		if( _G.IsShiftKeyDown() ) then
		    obj:PageUp();
		else
		    obj:ScrollUp();
		end
	    end
            obj:update();
        end);
    win.content.chatFrame.down = CreateFrame("Button", nil, win.content.chatFrame);
    win.content.chatFrame.down:SetWidth(28); win.content.chatFrame.down:SetHeight(28);
    win.content.chatFrame.down:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up");
    win.content.chatFrame.down:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down");
    win.content.chatFrame.down:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled");
    win.content.chatFrame.down:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD");
    win.content.chatFrame.down:SetPoint("BOTTOMRIGHT", 30 ,-4);
    win.content.chatFrame.down:SetScript("OnClick", function(self)
            local obj = self:GetParent();
	    if( _G.IsControlKeyDown() ) then
		obj:ScrollToBottom();
	    else
		if( _G.IsShiftKeyDown() ) then
		    obj:PageDown();
		else
		    obj:ScrollDown();
		end
	    end
            obj:update();
        end);
    
    win.content.textFrame = CreateFrame("ScrollFrame", "WIM3_HistoryTextFrame", win.content, "UIPanelScrollFrameTemplate");
    win.content.textFrame:SetPoint("TOPLEFT", win.content, "TOPLEFT", 4, -4);
    win.content.textFrame:SetPoint("BOTTOMRIGHT", -25, 4);
    win.content.textFrame.text = CreateFrame("EditBox", "WIM3_HistoryTextFrameText", win.content.textFrame);
    win.content.textFrame.text:SetFontObject(_G.ChatFontNormal);
    win.content.textFrame.text:SetMultiLine(true);
    win.content.textFrame:SetScrollChild(win.content.textFrame.text);
    win.content.textFrame.text:SetWidth(win.content.textFrame:GetWidth());
    win.content.textFrame.text:SetHeight(200);
    win.content.textFrame.text:SetAutoFocus(false);
    win.content.textFrame.text:SetScript("OnEscapePressed", function(self) self:ClearFocus() end);
    win.content.textFrame.text:SetScript("OnTextChanged", function(self)
            win.content.textFrame:UpdateScrollChildRect();
        end);
    win.content.textFrame.text.AddMessage = function(self, msg, r, g, b)
            local color;
            --if(r and g and b) then
            --    color = RGBPercentToHex(r, g, b);
            --end
            msg = msg:gsub("|c[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]", "");
            msg = msg:gsub("|r", "");
            --self:SetText(self:GetText()..(color and "|cff"..color or "")..msg..(color and "|r" or "").."\n");
            self:SetText(self:GetText()..msg.."\n");
        end;
    
    
    
    --resize
    win.resize = CreateFrame("Button", nil, win);
    win.resize:SetNormalTexture("Interface\\AddOns\\"..addonTocName.."\\Skins\\Default\\resize");
    win.resize:SetHighlightTexture("Interface\\AddOns\\"..addonTocName.."\\Skins\\Default\\resize", "ADD");
    win.resize:SetWidth(20); win.resize:SetHeight(20);
    win.resize:SetPoint("BOTTOMRIGHT", -11, 11);
    win.resize:SetScript("OnMouseDown", function(self)
            self:GetParent().isSizing = true;
	    self:GetParent():SetResizable(true);
	    self:GetParent():StartSizing("BOTTOMRIGHT");
            self:SetScript("OnUpdate", function(self)
                win.nav.userList.scroll:update();
            end);
        end);
    win.resize:SetScript("OnMouseUp", function(self)
            self:SetScript("OnUpdate", nil);
            self:GetParent().isSizing = false;
	    self:GetParent():StopMovingOrSizing();
            win.nav.userList.scroll:Hide();
            win.nav.userList.scroll:Show();
        end);
    
    win.USER = env.realm.."/"..env.character;
    win.USERLIST = {};
    win.CONVO = "";
    win.CONVOLIST = {};
    win.FILTER = "";
    win.FILTERLIST = {};
    win.SEARCHLIST = {};

    win.SelectConvo = function(self, convo)
        win.search.text:SetText("");
        win.search.result:Hide();
        for k, _ in pairs(win.SEARCHLIST) do
            win.SEARCHLIST[k] = nil;
        end
        win.CONVO = convo;
        win.FILTER = "";
        win.UpdateConvoList();
        win.UpdateFilterList();
        win.UpdateDisplay();
    end
    
    win.UpdateDisplay = function(self)
        if(win.displayUpdate) then
            win.displayUpdate:Show();
        end
    end
    
    win.UpdateFilterList = function(self)
        for i=1, #win.FILTERLIST do
            win.FILTERLIST[i] = nil;
        end
        local theList = #win.SEARCHLIST > 0 and win.SEARCHLIST or win.CONVOLIST;
        for i=1, #theList do
            local t = theList[i].time;
            local tbl = date("*t", t);
            t = time{year=tbl.year, month=tbl.month, day=tbl.day, hour=0};
            addToTableUnique(win.FILTERLIST, t);
            win.FILTER = t;
        end
        if(#win.FILTERLIST > 0) then
            table.insert(win.FILTERLIST, 1, L["Show All"]);
        end
        win.nav.filters.scroll:Hide();
        win.nav.filters.scroll:Show();
    end
    
    win.UpdateConvoList = function(self)
        for i=1, #win.CONVOLIST do
            win.CONVOLIST[i] = nil;
        end
        local realm, character = string.match(win.USER, "^([^/]+)/?(.*)$");
        if(realm and character and history[realm] and history[realm][character]) then
            local tbl = history[realm][character][win.CONVO];
            for i=1, #tbl do
                table.insert(win.CONVOLIST, tbl[i]);
            end
        elseif(realm and history[realm]) then
            for character, tbl in pairs(history[realm]) do
                if(tbl[win.CONVO]) then
                    for i=1, #tbl[win.CONVO] do
                        table.insert(win.CONVOLIST, tbl[win.CONVO][i]);
                    end
                end
            end
        end
        table.sort(win.CONVOLIST, function(a, b)
            return a.time < b.time;
        end);
    end
    
    win.UpdateUserList = function(self)
        for i=1, #win.USERLIST do
            win.USERLIST[i] = nil;
        end
        local realm, character = string.match(win.USER, "^([^/]+)/?(.*)$");
        if(realm and character and history[realm] and history[realm][character]) then
            local tbl = history[realm][character];
            for convo, t in pairs(tbl) do
                ChannelCache[convo] = t.info and t.info.channelNumber or nil;
                convo = (t.info and t.info.chat and "*" or "")..convo
                addToTableUnique(win.USERLIST, convo..(t.info and t.info.gm and "*" or ""));
            end
        elseif(realm and (not character or character == "") and history[realm]) then
            for character, tbl in pairs(history[realm]) do
                for convo, t in pairs(tbl) do
                    ChannelCache[convo] = t.info and t.info.channelNumber or nil;
                    convo = (t.info and t.info.chat and "*" or "")..convo
                    addToTableUnique(win.USERLIST, convo..(t.info and t.info.gm and "*" or ""));
                end
            end
        end
        table.sort(win.USERLIST);
        win.nav.userList.scroll:Hide();
        win.nav.userList.scroll:Show();
        if(#win.USERLIST>0) then
            if(not win.SELECT) then
                win.nav.userList.scroll.buttons[1]:Click();
            else
                win.SELECT = nil;
            end
        else
            win.SELECT = nil;
            win:SelectConvo("");
        end
    end
    
    
    win.progressBar = CreateFrame("Frame", nil, win.content);
    win.progressBar:SetFrameStrata("TOOLTIP");
    win.progressBar:SetWidth(300); win.progressBar:SetHeight(65);
    win.progressBar:SetPoint("CENTER", 0, 50);
    options.AddFramedBackdrop(win.progressBar);
    win.progressBar.backdrop.bg:SetTexture(0, 0, 0, 1);
    win.progressBar.bar = CreateFrame("Frame", nil, win.progressBar);
    options.AddFramedBackdrop(win.progressBar.bar);
    win.progressBar.bar:SetWidth(win.progressBar:GetWidth()-50); win.progressBar.bar:SetHeight(15);
    win.progressBar.bar:SetPoint("CENTER", -10, -5);
    win.progressBar.bar.bg = win.progressBar.bar:CreateTexture(nil, "OVERLAY");
    win.progressBar.bar.bg:SetTexture(1,1,1, .5);
    win.progressBar.bar.bg:SetPoint("TOPLEFT");
    win.progressBar.bar.bg:SetPoint("BOTTOMLEFT");
    win.progressBar.text = win.progressBar:CreateFontString(nil, "OVERLAY", "ChatFontNormal");
    win.progressBar.text:SetPoint("BOTTOMLEFT", win.progressBar.bar, "TOPLEFT", 0, 5);
    win.progressBar.text:SetText(L["Loading History"].."...");
    win.progressBar:SetScript("OnShow", function(self)
            win.content.chatFrame:SetAlpha(.5);
            win.content.textFrame:SetAlpha(.5);
        end);
    win.progressBar:SetScript("OnHide", function(self)
            win.content.chatFrame:SetAlpha(1);
            win.content.textFrame:SetAlpha(1);
        end);
    win.progressBar.delete = CreateFrame("Button", nil, win.progressBar);
    win.progressBar.delete:SetNormalTexture("Interface\\AddOns\\"..addonTocName.."\\Modules\\Textures\\xNormal");
    win.progressBar.delete:SetPushedTexture("Interface\\AddOns\\"..addonTocName.."\\Modules\\Textures\\xPressed");
    win.progressBar.delete:SetWidth(16);
    win.progressBar.delete:SetHeight(16);
    win.progressBar.delete:SetPoint("LEFT", win.progressBar.bar, "RIGHT", 4, 0);
    win.progressBar.delete:SetScript("OnClick", function(self)
            win.displayUpdate:Hide();
        end);
    
    win.content.tabs[1]:Click();
    
    return win;
end


local HistoryViewer;
local function createDisplayUpdate()
    -- displayUpdate loads messages into the correct content frames avoiding lag from system ops.
    local displayUpdate = CreateFrame("Frame");
    displayUpdate:Hide();
    displayUpdate.firstPass = true;
    displayUpdate.tmpTable = {};
    displayUpdate.Process = function(self)
            self.i = self.i or 1;
            if(not self.curList or not self.curList[self.i]) then
                self:Hide();
                return;
            end
            HistoryViewer.progressBar.bar.bg:SetWidth(HistoryViewer.progressBar.bar:GetWidth()*self.i/#self.curList);
            
            -- clear tmpTable
            for k, _ in pairs(self.tmpTable) do
                self.tmpTable[k] = nil;
            end
            -- load tmpTable
            for k, v in pairs(self.curList[self.i]) do
                self.tmpTable[k] = v;
            end
            
            if(self.filter) then
                if(self.min <= self.tmpTable.time and self.max > self.tmpTable.time) then
                    ViewTypes[HistoryViewer.TAB].func(self.frame, self.tmpTable);
                else
                    self.i = self.i + 1;
                    self:Process();
                    return;
                end
            else
                ViewTypes[HistoryViewer.TAB].func(self.frame, self.tmpTable);
            end
            self.i = self.i + 1;
        end;
    displayUpdate:SetScript("OnUpdate", function(self, elapsed)
        if(self.firstPass) then
            HistoryViewer.content.chatFrame:Clear();
            HistoryViewer.content.chatFrame.lastDate = nil;
            HistoryViewer.content.chatFrame:SetIndentedWordWrap(db.wordwrap_indent);
            HistoryViewer.content.textFrame.text:SetText("");
            HistoryViewer.content.textFrame.text.lastDate = nil;
            self.firstPass = nil;
        end
        self:Process()
    end);
    displayUpdate:SetScript("OnHide", function(self)
        self.firstPass = true;
        self.i = 1;
        HistoryViewer.progressBar:Hide();
        HistoryViewer.content.chatFrame:update();
        local buttons = HistoryViewer.nav.userList.scroll.buttons;
        for i=1, #buttons do
            buttons[i]:Enable();
            buttons[i].delete:Enable();
        end
        buttons = HistoryViewer.nav.filters.scroll.buttons;
        for i=1, #buttons do
            buttons[i]:Enable();
        end
    end);
    
    displayUpdate:SetScript("OnShow", function(self)
        local buttons = HistoryViewer.nav.userList.scroll.buttons;
        for i=1, #buttons do
            buttons[i]:Disable();
            buttons[i].delete:Disable();
        end
        buttons = HistoryViewer.nav.filters.scroll.buttons;
        for i=1, #buttons do
            buttons[i]:Disable();
        end
        HistoryViewer.progressBar:Show();
        self.curList = #HistoryViewer.SEARCHLIST > 0 and HistoryViewer.SEARCHLIST or HistoryViewer.CONVOLIST;
        self.frame = ViewTypes[HistoryViewer.TAB].frame == "chatFrame" and HistoryViewer.content.chatFrame or HistoryViewer.content.textFrame.text;
        
        
        
        self.filter = _G.type(HistoryViewer.FILTER) == "number" or nil;
        self.min, self.max = 0, 0;
        if(self.filter) then
            local t = HistoryViewer.FILTER;
            local tbl = date("*t", t);
            t = time{year=tbl.year, month=tbl.month, day=tbl.day, hour=0};
            self.min, self.max = t, t+dDay;
        end
    end);
    return displayUpdate;
end

local colorWhite = {r=1, g=1, b=1};
local chatFrameMsgId = -1;
table.insert(ViewTypes, {
        text = L["Chat View"],
        frame = "chatFrame",
        func = function(frame, msg)
            local color;
            if(msg.type == 1) then
                color = db.displayColors[msg.inbound and "wispIn" or "wispOut"];
                nextColor.r, nextColor.g, nextColor.b = color.r, color.g, color.b;
            elseif(msg.type == 2) then
                if(msg.event == CHANNEL) then
                    color = _G.ChatTypeInfo["CHANNEL"..msg.channelNumber];
                else
                    color = _G.ChatTypeInfo[msg.event];
                end
                color = color or colorWhite;
                nextColor.r, nextColor.g, nextColor.b = color.r, color.g, color.b;
            end
                frame.nextStamp = msg.time;
                frame:AddMessage(applyStringModifiers(applyMessageFormatting(frame, "CHAT_MSG_"..(msg.event or "WHISPER"), msg.msg, msg.from,
                        nil, nil, nil, nil, 0, msg.channelName and ChannelCache[msg.channelName], msg.channelName, nil, chatFrameMsgId), frame), color.r, color.g, color.b);
                chatFrameMsgId = chatFrameMsgId > -1000 and chatFrameMsgId - 1 or -1;
                
        end
    });
table.insert(ViewTypes, {
        text = L["Text View"],
        frame = "textFrame",
        func = function(frame, msg)
            frame.noEscapedStrings = true;
            if(msg.type == 1 or msg.type == 2) then
                local color = db.displayColors[msg.inbound and "wispIn" or "wispOut"];
                nextColor.r, nextColor.g, nextColor.b = color.r, color.g, color.b;
                frame.nextStamp = msg.time;
                frame:AddMessage(applyStringModifiers(applyMessageFormatting(frame, "CHAT_MSG_WHISPER", msg.msg, msg.from,
                nil, nil, nil, nil, 0, msg.channelName and ChannelCache[msg.channelName], msg.channelName), frame), color.r, color.g, color.b)
            end
        end
    });
    
-- stewart
table.insert(ViewTypes, { 
	        text = L["BBCode"], 
	        frame = "textFrame", 
	        func = function(frame, msg)
                    local color;
	            if(msg.type == 1) then
                        color = db.displayColors[msg.inbound and "wispIn" or "wispOut"];
                        nextColor.r, nextColor.g, nextColor.b = color.r, color.g, color.b;
                    elseif(msg.type == 2) then
                        if(msg.event == CHANNEL) then
                            color = _G.ChatTypeInfo["CHANNEL"..msg.channelNumber];
                        else
                            color = _G.ChatTypeInfo[msg.event];
                        end
                        color = color or colorWhite;
                        nextColor.r, nextColor.g, nextColor.b = color.r, color.g, color.b;
                    end
	            frame.noEscapedStrings = nil;
                    frame.noEmoticons = true;
	            frame.nextStamp = msg.time;
                    local chatColor = "[color=#"..RGBPercentToHex(color.r, color.g, color.b).."]";
                    local chatColorPattern = "%[color%=%#"..RGBPercentToHex(color.r, color.g, color.b).."%]%s*%[%/color%]";
	            msg = applyMessageFormatting(frame, "CHAT_MSG_WHISPER", msg.msg, msg.from) 
	            msg = applyStringModifiers(msg, frame); 
	            msg = msg:gsub("|c[0-9A-Fa-f][0-9A-Fa-f]([0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f])|Hwim_url:([^|]*)|h.-|h|r", "[/color][url=%2][color=#%1]%2[/color][/url]"..chatColor); 
	            msg = msg:gsub("|c[0-9A-Fa-f][0-9A-Fa-f]([0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f])", "[color=#%1]"); 
	            msg = msg:gsub("|r", "[/color]"); 
	            msg = msg:gsub("(%[color%=%#[0-9A-Fa-f]+%])|Hitem:(%d+)[:%d]*|h([^|]+)|h(%[%/color%])", "[/color][url=http://www.wowhead.com/?item=%2]%1%3%4[/url]"..chatColor); 
	            msg = chatColor..msg.."[/color]"; 
	            msg = msg:gsub("(%[color%=%#[0-9A-Fa-f]+%])(%[color%=%#[0-9A-Fa-f]+%])(.-)(%[%/color%])", "%2%3%4%1");
                    msg = msg:gsub(chatColorPattern, "");
	            frame:AddMessage(msg, color.r, color.g, color.b) 
	        end 
	    });  

table.insert(ViewTypes, { 
	        text = "HTML", 
	        frame = "textFrame", 
	        func = function(frame, msg)
                    local color;
	            if(msg.type == 1) then
                        color = db.displayColors[msg.inbound and "wispIn" or "wispOut"];
                        nextColor.r, nextColor.g, nextColor.b = color.r, color.g, color.b;
                    elseif(msg.type == 2) then
                        if(msg.event == CHANNEL) then
                            color = _G.ChatTypeInfo["CHANNEL"..msg.channelNumber];
                        else
                            color = _G.ChatTypeInfo[msg.event];
                        end
                        color = color or colorWhite;
                        nextColor.r, nextColor.g, nextColor.b = color.r, color.g, color.b;
                    end
	            frame.noEscapedStrings = nil;
                    frame.noEmoticons = true;
	            frame.nextStamp = msg.time;
                    local chatColor = "<font color='#"..RGBPercentToHex(color.r, color.g, color.b).."'>";
                    local chatColorPattern = "%<font color%='%#"..RGBPercentToHex(color.r, color.g, color.b).."'%>%s*%<%/font%>";
	            msg = applyMessageFormatting(frame, "CHAT_MSG_WHISPER", msg.msg, msg.from) 
	            msg = applyStringModifiers(msg, frame);
                    
                    -- html escapes
                    msg = msg:gsub("&", "&amp;");
                    msg = msg:gsub("<", "&lt;");
                    msg = msg:gsub(">", "&gt;");
                    msg = msg:gsub("\"", "&quot;");
                    
                    -- color & URL handling...
	            msg = msg:gsub("|c[0-9A-Fa-f][0-9A-Fa-f]([0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f])|Hwim_url:([^|]*)|h.-|h|r", "</color><a href='%2'><font color='#%1'>%2</font></a>"..chatColor); 
	            msg = msg:gsub("|c[0-9A-Fa-f][0-9A-Fa-f]([0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f])", "<font color='#%1'>"); 
	            msg = msg:gsub("|r", "</font>"); 
	            msg = msg:gsub("(%<font color%='%#[0-9A-Fa-f]+'%>)|Hitem:(%d+)[:%d]*|h([^|]+)|h(%[%/color%])", "</font><a href='http://www.wowhead.com/?item=%2'>%1%3%4</a>"..chatColor); 
	            msg = chatColor..msg.."</font>"; 
	            msg = msg:gsub("(%<font color%='%#[0-9A-Fa-f]+'%>)(%<font color%='%#[0-9A-Fa-f]+'%>)(.-)(%<%/font%>)", "%2%3%4%1");
                    msg = "<br>"..msg:gsub(chatColorPattern, "");
	            frame:AddMessage(msg, color.r, color.g, color.b) 
	        end 
	    });  


function ShowHistoryViewer(user)
    if(HistoryViewer and not user and HistoryViewer:IsShown()) then
        HistoryViewer:Hide();
        return;
    end
    HistoryViewer = HistoryViewer or createHistoryViewer();
    HistoryViewer.displayUpdate = HistoryViewer.displayUpdate or createDisplayUpdate();
    
    if(user) then
        HistoryViewer.USER = env.realm.."/"..env.character;
        HistoryViewer.SELECT = user;
        HistoryViewer.nav:Hide();
        HistoryViewer.nav:Show();
        HistoryViewer.UpdateUserList();
        HistoryViewer:SelectConvo(user);
        DisplayTutorial(L["WIM History Viewer"], L["WIM History Viewer can be accessed any time by typing:"].." \n|cff69ccf0/wim history|r");
    end
    HistoryViewer:Show();
end

RegisterSlashCommand("history", function() ShowHistoryViewer(); end, L["Display history viewer."])
