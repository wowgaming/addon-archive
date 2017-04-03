-- imports
local WIM = WIM;
local _G = _G;
local hooksecurefunc = hooksecurefunc;
local table = table;
local pairs = pairs;
local string = string;
local select = select;
local math = math;

-- set name space
setfenv(1, WIM);

local Windows = windows.active.chat;

db_defaults.pop_rules.chat = {
        --pop-up rule sets based off of your location
        resting = {
            onSend = false,
            onReceive = false,
            supress = false,
            autofocus = false,
            keepfocus = false,
        },
        combat = {
            onSend = false,
            onReceive = false,
            supress = false,
            autofocus = false,
            keepfocus = false,
        },
        pvp = {
            onSend = false,
            onReceive = false,
            supress = false,
            autofocus = false,
            keepfocus = false,
        },
        arena = {
            onSend = false,
            onReceive = false,
            supress = false,
            autofocus = false,
            keepfocus = false,
        },
        party = {
            onSend = false,
            onReceive = false,
            supress = false,
            autofocus = false,
            keepfocus = false,
        },
        raid = {
            onSend = false,
            onReceive = false,
            supress = false,
            autofocus = false,
            keepfocus = false,
        },
        other = {
            onSend = false,
            onReceive = false,
            supress = false,
            autofocus = false,
            keepfocus = false,
        },
        alwaysOther = true,
        intercept = false,
}

db_defaults.chat = {
    world = {
        enabled = false,
        channelSettings = {}
    },
    custom = {
        enabled = false,
        channelSettings = {}
    },
    guild = {
        showAlerts = true,
    },
    officer = {
        showAlerts = true,
    },
    raid = {
        showAlerts = true,
    },
    party = {
        showAlerts = true,
    },
    battleground = {
    
    },
    say = {
    
    }
};


local USERLIST_BUTTON_COUNT = 5;

local function getRuleSet()
    local curState = db.pop_rules.chat.alwaysOther and "other" or curState
    return db.pop_rules.chat[curState];
end
    

local function createWidget_Chat()
    local button = _G.CreateFrame("Button");
    button.text = button:CreateFontString(nil, "BACKGROUND");
    button.text:SetFont("Fonts\\SKURRI.ttf", 16);
    button.text:SetAllPoints();
    button.text:SetText("");
    button.SetText = function(self, text)
            self.text:SetText(text);
            --adjust font size to match widget
        end
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
            --self.flash.bg:SetTexture(GetSelectedSkin().message_window.widgets.w2w.HighlightTexture);
        end
    button:SetScript("OnClick", function(self)
            if(self.active) then
                ChatUserList.listCount = self.parentWindow.CHAT_listCount;
                ChatUserList.listFun = self.parentWindow.CHAT_listFun;
                ChatUserList:PopUp(self, "TOPRIGHT", "TOPLEFT")
                ChatUserList:SetChannel(self.parentWindow.widgets.from:GetText());
            end
        end);
    button:SetScript("OnLeave", function(self)
                --ChatUserList:Hide();
        end);
    
    return button;
end

local function getChatWindow(ChatName, chatType)
    if(not ChatName or ChatName == "") then
        -- if invalid user, then return nil;
        return nil;
    end
    local obj = Windows[ChatName];
    if(obj and obj.type == "chat") then
        -- if the whisper window exists, return the object
        return obj;
    else
        -- otherwise, create a new one.
        Windows[ChatName] = CreateChatWindow(ChatName);
        Windows[ChatName].chatType = chatType;
        Windows[ChatName]:UpdateIcon();
        Windows[ChatName].widgets.chat_info:SetActive(true);
        Windows[ChatName].chatList = Windows[ChatName].chatList or {};
        
        if(chatType == "guild") then
            Windows[ChatName].CHAT_listCount = _G.GetNumGuildMembers;
            Windows[ChatName].CHAT_listFun = _G.GetGuildRosterInfo;
        else
            Windows[ChatName].CHAT_listCount = nil;
            Windows[ChatName].CHAT_listFun = nil;
        end
        
        return Windows[ChatName];
    end
end


local function cleanChatList(win)
    if(win.chatList) then
        for k, _ in pairs(win.chatList) do
            win.chatList[k] = nil;
        end
    end
end


RegisterWidgetTrigger("msg_box", "chat", "OnEnterPressed", function(self)
        local obj, msg, TARGET, NUMBER = self:GetParent(), self:GetText();
	msg = PreSendFilterText(msg);
        if(obj.chatType == "guild") then
            TARGET = "GUILD";
        elseif(obj.chatType == "officer") then
            TARGET = "OFFICER";
        elseif(obj.chatType == "party") then
            TARGET = "PARTY";
        elseif(obj.chatType == "raid") then
            TARGET = "RAID";
        elseif(obj.chatType == "battleground") then
            TARGET = "BATTLEGROUND";
        elseif(obj.chatType == "say") then
            TARGET = "SAY";
        elseif(obj.chatType == "channel") then
            TARGET = "CHANNEL";
            NUMBER = obj.channelNumber;
        else
            return;
        end
        local msgCount = math.ceil(string.len(msg)/255);
        if(msgCount == 1) then
            _G.ChatThrottleLib:SendChatMessage("ALERT", "WIM", msg, TARGET, nil, NUMBER);
        elseif(msgCount > 1) then
            SendSplitMessage("ALERT", "WIM", msg, TARGET, nil, NUMBER);
        end
        self:SetText("");
    end);



--------------------------------------
--              Guild Chat          --
--------------------------------------

-- create GuildChat Module
local Guild = CreateModule("GuildChat");

-- This Module requires LibChatHandler-1.0
_G.LibStub:GetLibrary("LibChatHandler-1.0"):Embed(Guild);

function Guild:OnEnable()
    RegisterWidget("chat_info", createWidget_Chat);
    self:RegisterChatEvent("CHAT_MSG_GUILD");
    self:RegisterChatEvent("CHAT_MSG_GUILD_ACHIEVEMENT");
    self:RegisterEvent("GUILD_ROSTER_UPDATE");
end

function Guild:OnDisable()
    self:UnregisterChatEvent("CHAT_MSG_GUILD");
    self:UnregisterChatEvent("CHAT_MSG_GUILD_ACHIEVEMENT");
end

function Guild:OnWindowDestroyed(self)
    if(self.type == "chat" and self.chatType == "guild") then
        local chatName = self.theUser;
        Windows[chatName].chatType = nil;
        Windows[chatName].unreadCount = nil;
        Windows[chatName].chatLoaded = nil;
        cleanChatList(Windows[chatName]);
        Windows[chatName] = nil;
        Guild.guildWindow = nil;
    end
end

function Guild:OnWindowShow(self)
    if(self.type == "chat" and self.chatType == "guild") then
        _G.GuildRoster();
    end
end

function Guild:GUILD_ROSTER_UPDATE()
    if(self.guildWindow) then
        -- update guild count
        cleanChatList(self.guildWindow);
        local count = 0;
        for i=1, _G.GetNumGuildMembers() do 
	    local name, rank, rankIndex, level, class, zone, note, officernote, online, status, classFileName = _G.GetGuildRosterInfo(i);
	    if(online) then
		_G.GuildControlSetRank(rankIndex);
                local guildchat_listen, guildchat_speak, officerchat_listen, officerchat_speak, promote, demote,
                        invite_member, remove_member, set_motd, edit_public_note, view_officer_note, edit_officer_note,
                        modify_guild_info, _, withdraw_repair, withdraw_gold, create_guild_event = _G.GuildControlGetRankFlags();
        	if(guildchat_listen) then
                    count = count + 1;
                    table.insert(self.guildWindow.chatList, name);
                end
	    end
	end
        self.guildWindow.widgets.chat_info:SetText(count);
    end
end

function Guild:CHAT_MSG_GUILD_CONTROLLER(eventController, ...)
    if(eventController.ignoredByWIM) then
        eventController:BlockFromDelegate(self);
        return;
    end
    if(not db.chat.guild.neverSuppress and getRuleSet().supress) then
        eventController:BlockFromChatFrame(self);
    end
end

function Guild:CHAT_MSG_GUILD(...)
    local filter, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = honorChatFrameEventFilter("CHAT_MSG_GUILD", ...);
    if(filter) then
        return;
    end
    local win = getChatWindow(_G.GUILD, "guild");
    local color = _G.ChatTypeInfo["GUILD"];
    self.guildWindow = win;
    if(not self.chatLoaded) then
        Guild:GUILD_ROSTER_UPDATE();
    end
    self.chatLoaded = true;
    arg3 = CleanLanguageArg(arg3);
    win:AddEventMessage(color.r, color.g, color.b, "CHAT_MSG_GUILD", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    if(arg2 ~= _G.UnitName("player")) then
        win.unreadCount = win.unreadCount and (win.unreadCount + 1) or 1;
        if(not db.chat.guild.neverPop) then
            win:Pop("in");
        end
    else
        if(not db.chat.guild.neverPop) then
            win:Pop("out");
        end
    end
    CallModuleFunction("PostEvent_ChatMessage", "CHAT_MSG_GUILD", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
end





--------------------------------------
--            Officer Chat          --
--------------------------------------

-- create OfficerChat Module
local Officer = CreateModule("OfficerChat");

-- This Module requires LibChatHandler-1.0
_G.LibStub:GetLibrary("LibChatHandler-1.0"):Embed(Officer);

function Officer:OnEnable()
    RegisterWidget("chat_info", createWidget_Chat);
    self:RegisterChatEvent("CHAT_MSG_OFFICER");
    self:RegisterEvent("GUILD_ROSTER_UPDATE");
end

function Officer:OnDisable()
    self:UnregisterChatEvent("CHAT_MSG_OFFICER");
end

function Officer:OnWindowDestroyed(self)
    if(self.type == "chat" and self.chatType == "officer") then
        local chatName = self.theUser;
        Windows[chatName].chatType = nil;
        Windows[chatName].unreadCount = nil;
        Windows[chatName].chatLoaded = nil;
        cleanChatList(Windows[chatName]);
        Windows[chatName] = nil;
        Officer.officerWin = nil;
    end
end

function Officer:GUILD_ROSTER_UPDATE()
    if(self.officerWindow) then
        -- update guild count
        cleanChatList(self.officerWindow);
        local count = 0;
        for i=1, _G.GetNumGuildMembers() do 
	    local name, rank, rankIndex, level, class, zone, note, officernote, online, status, classFileName = _G.GetGuildRosterInfo(i);
            if(online) then
                _G.GuildControlSetRank(rankIndex);
                local guildchat_listen, guildchat_speak, officerchat_listen, officerchat_speak, promote, demote,
                        invite_member, remove_member, set_motd, edit_public_note, view_officer_note, edit_officer_note,
                        modify_guild_info, _, withdraw_repair, withdraw_gold, create_guild_event = _G.GuildControlGetRankFlags();
        	if(officerchat_listen) then
                    count = count + 1;
                    table.insert(self.officerWindow.chatList, name);
                end
            end
	end
        self.officerWindow.widgets.chat_info:SetText(count);
    end
end

function Officer:CHAT_MSG_OFFICER_CONTROLLER(eventController, ...)
    if(eventController.ignoredByWIM) then
        eventController:BlockFromDelegate(self);
        return;
    end
    if(not db.chat.officer.neverSuppress and getRuleSet().supress) then
        eventController:BlockFromChatFrame(self);
    end
end

function Officer:CHAT_MSG_OFFICER(...)
    local filter, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = honorChatFrameEventFilter("CHAT_MSG_OFFICER", ...);
    if(filter) then
        return;
    end
    local win = getChatWindow(_G.GUILD_RANK1_DESC, "officer");
    local color = _G.ChatTypeInfo["OFFICER"];
    Officer.officerWindow = win;
    if(not self.chatLoaded) then
        Officer:GUILD_ROSTER_UPDATE();
    end
    self.chatLoaded = true;
    arg3 = CleanLanguageArg(arg3);
    win:AddEventMessage(color.r, color.g, color.b, "CHAT_MSG_OFFICER", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    if(arg2 ~= _G.UnitName("player")) then
        win.unreadCount = win.unreadCount and (win.unreadCount + 1) or 1;
        if(not db.chat.officer.neverPop) then
            win:Pop("in");
        end
    else
        if(not db.chat.officer.neverPop) then
            win:Pop("out");
        end
    end
    CallModuleFunction("PostEvent_ChatMessage", "CHAT_MSG_OFFICER", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
end




--------------------------------------
--            Party Chat            --
--------------------------------------

-- create PartyChat Module
local Party = CreateModule("PartyChat");

-- This Module requires LibChatHandler-1.0
_G.LibStub:GetLibrary("LibChatHandler-1.0"):Embed(Party);

function Party:OnEnable()
    RegisterWidget("chat_info", createWidget_Chat);
    self:RegisterChatEvent("CHAT_MSG_PARTY");
    self:RegisterChatEvent("CHAT_MSG_PARTY_LEADER");
    self:RegisterEvent("PARTY_MEMBERS_CHANGED");
end

function Party:OnDisable()
    self:UnregisterChatEvent("CHAT_MSG_PARTY");
end

function Party:OnWindowDestroyed(self)
    if(self.type == "chat" and self.chatType == "party") then
        local chatName = self.theUser;
        Windows[chatName].chatType = nil;
        Windows[chatName].unreadCount = nil;
        Windows[chatName].chatLoaded = nil;
        cleanChatList(Windows[chatName]);
        Windows[chatName] = nil;
        Party.partyWindow = nil;
    end
end

function Party:PARTY_MEMBERS_CHANGED()
    if(Party.partyWindow) then
        cleanChatList(self.partyWindow);
        local myName = _G.UnitName("player");
        table.insert(self.partyWindow.chatList, myName);
        local count = 0;
        for i=1, 4 do
            if(_G.GetPartyMember(i)) then
                count = count + 1;
                local name = _G.UnitName("party"..i);
                table.insert(self.partyWindow.chatList, name);
            end
        end
        Party.partyWindow.widgets.chat_info:SetText(count + 1);
    end
end

function Party:CHAT_MSG_PARTY_CONTROLLER(eventController, ...)
    if(eventController.ignoredByWIM) then
        eventController:BlockFromDelegate(self);
        return;
    end
    if(not db.chat.party.neverSuppress and getRuleSet().supress) then
        eventController:BlockFromChatFrame(self);
    end
end

function Party:CHAT_MSG_PARTY(...)
    local filter, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = honorChatFrameEventFilter("CHAT_MSG_PARTY", ...);
    if(filter) then
        return;
    end
    local win = getChatWindow(_G.PARTY, "party");
    local color = _G.ChatTypeInfo["PARTY"];
    Party.partyWindow = win;
    if(not self.chatLoaded) then
        Party:PARTY_MEMBERS_CHANGED();
    end
    self.chatLoaded = true;
    arg3 = CleanLanguageArg(arg3);
    win:AddEventMessage(color.r, color.g, color.b, "CHAT_MSG_PARTY", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    if(arg2 ~= _G.UnitName("player")) then
        win.unreadCount = win.unreadCount and (win.unreadCount + 1) or 1;
        if(not db.chat.party.neverPop) then
            win:Pop("in");
        end
    else
        if(not db.chat.party.neverPop) then
            win:Pop("out");
        end
    end
    CallModuleFunction("PostEvent_ChatMessage", "CHAT_MSG_PARTY", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
end

function Party:CHAT_MSG_PARTY_LEADER_CONTROLLER(eventController, ...)
    if(eventController.ignoredByWIM) then
        eventController:BlockFromDelegate(self);
        return;
    end
    if(not db.chat.party.neverSuppress and getRuleSet().supress) then
        eventController:BlockFromChatFrame(self);
    end
end

function Party:CHAT_MSG_PARTY_LEADER(...)
    local filter, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = honorChatFrameEventFilter("CHAT_MSG_PARTY_LEADER", ...);
    if(filter) then
        return;
    end
    local win = getChatWindow(_G.PARTY, "party");
    local color = _G.ChatTypeInfo["PARTY_LEADER"];
    self.raidWindow = win;
    if(not self.chatLoaded) then
        Party:PARTY_MEMBERS_CHANGED();
    end
    self.chatLoaded = true;
    arg3 = CleanLanguageArg(arg3);
    win:AddEventMessage(color.r, color.g, color.b, "CHAT_MSG_PARTY_LEADER", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    if(arg2 ~= _G.UnitName("player")) then
        win.unreadCount = win.unreadCount and (win.unreadCount + 1) or 1;
        if(not db.chat.party.neverPop) then
            win:Pop("in");
        end
    else
        if(not db.chat.party.neverPop) then
            win:Pop("out");
        end
    end
    CallModuleFunction("PostEvent_ChatMessage", "CHAT_MSG_PARTY_LEADER", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
end


--------------------------------------
--            Raid Chat             --
--------------------------------------

-- create RaidChat Module
local Raid = CreateModule("RaidChat");

-- This Module requires LibChatHandler-1.0
_G.LibStub:GetLibrary("LibChatHandler-1.0"):Embed(Raid);

function Raid:OnEnable()
    RegisterWidget("chat_info", createWidget_Chat);
    self:RegisterChatEvent("CHAT_MSG_RAID");
    self:RegisterChatEvent("CHAT_MSG_RAID_LEADER");
    self:RegisterChatEvent("CHAT_MSG_RAID_WARNING");
    self:RegisterEvent("PARTY_MEMBERS_CHANGED");
end

function Raid:OnDisable()
    self:UnregisterChatEvent("CHAT_MSG_RAID");
    self:UnregisterChatEvent("CHAT_MSG_RAID_LEADER");
    self:UnregisterChatEvent("CHAT_MSG_RAID_WARNING");
end

function Raid:OnWindowDestroyed(self)
    if(self.type == "chat" and self.chatType == "raid") then
        local chatName = self.theUser;
        Windows[chatName].chatType = nil;
        Windows[chatName].unreadCount = nil;
        Windows[chatName].chatLoaded = nil;
        cleanChatList(Windows[chatName]);
        Windows[chatName] = nil;
    end
end

function Raid:PARTY_MEMBERS_CHANGED()
    if(Raid.raidWindow) then
        cleanChatList(self.raidWindow);
        local count = 0;
        for i=1,40 do
            local name = _G.GetRaidRosterInfo(i);
            if(name) then
                count = count + 1;
                table.insert(self.raidWindow.chatList, name);
            end
        end
        self.raidWindow.widgets.chat_info:SetText(count);
    end 
end

function Raid:CHAT_MSG_RAID_CONTROLLER(eventController, ...)
    if(eventController.ignoredByWIM) then
        eventController:BlockFromDelegate(self);
        return;
    end
    if(not db.chat.raid.neverSuppress and getRuleSet().supress) then
        eventController:BlockFromChatFrame(self);
    end
end

function Raid:CHAT_MSG_RAID(...)
    local filter, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = honorChatFrameEventFilter("CHAT_MSG_RAID", ...);
    if(filter) then
        return;
    end
    local win = getChatWindow(_G.RAID, "raid");
    local color = _G.ChatTypeInfo["RAID"];
    self.raidWindow = win;
    if(not self.chatLoaded) then
        Raid:PARTY_MEMBERS_CHANGED();
    end
    self.chatLoaded = true;
    arg3 = CleanLanguageArg(arg3);
    win:AddEventMessage(color.r, color.g, color.b, "CHAT_MSG_RAID", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    if(arg2 ~= _G.UnitName("player")) then
        win.unreadCount = win.unreadCount and (win.unreadCount + 1) or 1;
        if(not db.chat.raid.neverPop) then
            win:Pop("in");
        end
    else
        if(not db.chat.raid.neverPop) then
            win:Pop("out");
        end
    end
    CallModuleFunction("PostEvent_ChatMessage", "CHAT_MSG_RAID", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
end

function Raid:CHAT_MSG_RAID_LEADER_CONTROLLER(eventController, ...)
    if(eventController.ignoredByWIM) then
        eventController:BlockFromDelegate(self);
        return;
    end
    if(not db.chat.raid.neverSuppress and getRuleSet().supress) then
        eventController:BlockFromChatFrame(self);
    end
end

function Raid:CHAT_MSG_RAID_LEADER(...)
    local filter, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = honorChatFrameEventFilter("CHAT_MSG_RAID_LEADER", ...);
    if(filter) then
        return;
    end
    local win = getChatWindow(_G.RAID, "raid");
    local color = _G.ChatTypeInfo["RAID_LEADER"];
    self.raidWindow = win;
    if(not self.chatLoaded) then
        Raid:PARTY_MEMBERS_CHANGED();
    end
    self.chatLoaded = true;
    arg3 = CleanLanguageArg(arg3);
    win:AddEventMessage(color.r, color.g, color.b, "CHAT_MSG_RAID_LEADER", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    if(arg2 ~= _G.UnitName("player")) then
        win.unreadCount = win.unreadCount and (win.unreadCount + 1) or 1;
        if(not db.chat.raid.neverPop) then
            win:Pop("in");
        end
    else
        if(not db.chat.raid.neverPop) then
            win:Pop("out");
        end
    end
    CallModuleFunction("PostEvent_ChatMessage", "CHAT_MSG_RAID_LEADER", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
end

function Raid:CHAT_MSG_RAID_WARNING_CONTROLLER(eventController, ...)
    if(eventController.ignoredByWIM) then
        eventController:BlockFromDelegate(self);
        return;
    end
    if(not db.chat.raid.neverSuppress and getRuleSet().supress) then
        eventController:BlockFromChatFrame(self);
    end
end

function Raid:CHAT_MSG_RAID_WARNING(...)
    local filter, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = honorChatFrameEventFilter("CHAT_MSG_RAID_WARNING", ...);
    if(filter) then
        return;
    end
    local win = getChatWindow(_G.RAID, "raid");
    local color = _G.ChatTypeInfo["RAID_WARNING"];
    self.raidWindow = win;
    if(not self.chatLoaded) then
        Raid:PARTY_MEMBERS_CHANGED();
    end
    self.chatLoaded = true;
    arg3 = CleanLanguageArg(arg3);
    win:AddEventMessage(color.r, color.g, color.b, "CHAT_MSG_RAID_WARNING", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    if(arg2 ~= _G.UnitName("player")) then
        win.unreadCount = win.unreadCount and (win.unreadCount + 1) or 1;
        if(not db.chat.raid.neverPop) then
            win:Pop("in");
        end
    else
        if(not db.chat.raid.neverPop) then
            win:Pop("out");
        end
    end
    CallModuleFunction("PostEvent_ChatMessage", "CHAT_MSG_RAID_WARNING", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
end


--------------------------------------
--            Battleground Chat             --
--------------------------------------

-- create RaidChat Module
local Battleground = CreateModule("BattlegroundChat");

-- This Module requires LibChatHandler-1.0
_G.LibStub:GetLibrary("LibChatHandler-1.0"):Embed(Battleground);

function Battleground:OnEnable()
    RegisterWidget("chat_info", createWidget_Chat);
    self:RegisterChatEvent("CHAT_MSG_BATTLEGROUND");
    self:RegisterChatEvent("CHAT_MSG_BATTLEGROUND_LEADER");
end

function Battleground:OnDisable()
    self:UnregisterChatEvent("CHAT_MSG_BATTLEGROUND");
    self:UnregisterChatEvent("CHAT_MSG_BATTLEGROUND_LEADER");
end

function Battleground:OnWindowDestroyed(self)
    if(self.type == "chat" and self.chatType == "battleground") then
        local chatName = self.theUser;
        Windows[chatName].chatType = nil;
        Windows[chatName].unreadCount = nil;
        Windows[chatName].chatLoaded = nil;
        Windows[chatName].battlegroundWindow = nil;
        Windows[chatName] = nil;
    end
end

local function getBattlegroundCount()
    for i=1, 20 do
        local name, header, collapsed, channelNumber, count, active, category, voiceEnabled, voiceActive = _G.GetChannelDisplayInfo(i);
        if(name == _G.BATTLEGROUND) then
            return count;
        end
    end
    return 0;
end

function Battleground:OnWindowShow(win)
    if(win.type == "chat" and win.chatType == "battleground") then
        win.widgets.chat_info:SetText(getBattlegroundCount());
    end
end

function Battleground:CHAT_MSG_BATTLEGROUND_CONTROLLER(eventController, ...)
    if(eventController.ignoredByWIM) then
        eventController:BlockFromDelegate(self);
        return;
    end
    if(not db.chat.battleground.neverSuppress and getRuleSet().supress) then
        eventController:BlockFromChatFrame(self);
    end
end

function Battleground:CHAT_MSG_BATTLEGROUND(...)
    local filter, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = honorChatFrameEventFilter("CHAT_MSG_BATTLEGROUND", ...);
    if(filter) then
        return;
    end
    local win = getChatWindow(_G.BATTLEGROUND, "battleground");
    win.widgets.chat_info:SetText(getBattlegroundCount());
    local color = _G.ChatTypeInfo["BATTLEGROUND"];
    self.battlegroundWindow = win;
    self.chatLoaded = true;
    arg3 = CleanLanguageArg(arg3);
    win:AddEventMessage(color.r, color.g, color.b, "CHAT_MSG_BATTLEGROUND", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    if(arg2 ~= _G.UnitName("player")) then
        win.unreadCount = win.unreadCount and (win.unreadCount + 1) or 1;
        if(not db.chat.battleground.neverPop) then
            win:Pop("in");
        end
    else
        if(not db.chat.battleground.neverPop) then
            win:Pop("out");
        end
    end
    CallModuleFunction("PostEvent_ChatMessage", "CHAT_MSG_BATTLEGROUND", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
end

function Battleground:CHAT_MSG_BATTLEGROUND_LEADER_CONTROLLER(eventController, ...)
    if(eventController.ignoredByWIM) then
        eventController:BlockFromDelegate(self);
        return;
    end
    if(not db.chat.battleground.neverSuppress and getRuleSet().supress) then
        eventController:BlockFromChatFrame(self);
    end
end

function Battleground:CHAT_MSG_BATTLEGROUND_LEADER(...)
    local filter, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = honorChatFrameEventFilter("CHAT_MSG_BATTLEGROUND_LEADER", ...);
    if(filter) then
        return;
    end
    local win = getChatWindow(_G.BATTLEGROUND, "battleground");
    win.widgets.chat_info:SetText(getBattlegroundCount());
    local color = _G.ChatTypeInfo["BATTLEGROUND_LEADER"];
    self.battlegroundWindow = win;
    self.chatLoaded = true;
    arg3 = CleanLanguageArg(arg3);
    win:AddEventMessage(color.r, color.g, color.b, "CHAT_MSG_BATTLEGROUND_LEADER", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    if(arg2 ~= _G.UnitName("player")) then
        win.unreadCount = win.unreadCount and (win.unreadCount + 1) or 1;
        if(not db.chat.battleground.neverPop) then
            win:Pop("in");
        end
    else
        if(not db.chat.battleground.neverPop) then
            win:Pop("out");
        end
    end
    CallModuleFunction("PostEvent_ChatMessage", "CHAT_MSG_BATTLEGROUND_LEADER", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
end

--------------------------------------
--            Say Chat            --
--------------------------------------

-- create SayChat Module
local Say = CreateModule("SayChat");

-- This Module requires LibChatHandler-1.0
_G.LibStub:GetLibrary("LibChatHandler-1.0"):Embed(Say);

function Say:OnEnable()
    RegisterWidget("chat_info", createWidget_Chat);
    self:RegisterChatEvent("CHAT_MSG_SAY");
end

function Say:OnDisable()
    self:UnregisterChatEvent("CHAT_MSG_SAY");
end

function Say:OnWindowDestroyed(self)
    if(self.type == "chat" and self.chatType == "say") then
        local chatName = self.theUser;
        Windows[chatName].chatType = nil;
        Windows[chatName].unreadCount = nil;
        Windows[chatName].chatLoaded = nil;
        cleanChatList(Windows[chatName]);
        Windows[chatName] = nil;
    end
end

function Say:CHAT_MSG_SAY_CONTROLLER(eventController, ...)
    if(eventController.ignoredByWIM) then
        eventController:BlockFromDelegate(self);
        return;
    end
    if(not db.chat.say.neverSuppress and getRuleSet().supress) then
        eventController:BlockFromChatFrame(self);
    end
end

function Say:CHAT_MSG_SAY(...)
    local filter, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = honorChatFrameEventFilter("CHAT_MSG_SAY", ...);
    if(filter) then
        return;
    end
    local win = getChatWindow(_G.SAY, "say");
    local color = _G.ChatTypeInfo["SAY"];
    self.chatLoaded = true;
    arg3 = CleanLanguageArg(arg3);
    win:AddEventMessage(color.r, color.g, color.b, "CHAT_MSG_SAY", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    if(arg2 ~= _G.UnitName("player")) then
        win.unreadCount = win.unreadCount and (win.unreadCount + 1) or 1;
        if(not db.chat.say.neverPop) then
            win:Pop("in");
        end
    else
        if(not db.chat.say.neverPop) then
            win:Pop("out");
        end
    end
    CallModuleFunction("PostEvent_ChatMessage", "CHAT_MSG_SAY", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
end



--------------------------------------
--            Channel Chat            --
--------------------------------------

-- create SayChat Module
local Channel = CreateModule("ChannelChat");

-- This Module requires LibChatHandler-1.0
_G.LibStub:GetLibrary("LibChatHandler-1.0"):Embed(Channel);

function Channel:OnEnable()
    RegisterWidget("chat_info", createWidget_Chat);
    self:RegisterChatEvent("CHAT_MSG_CHANNEL");
    self:RegisterChatEvent("CHAT_MSG_CHANNEL_JOIN");
    self:RegisterChatEvent("CHAT_MSG_CHANNEL_LEAVE");
    self:RegisterChatEvent("CHAT_MSG_CHANNEL_NOTICE");
    self:RegisterChatEvent("CHAT_MSG_CHANNEL_NOTICE_USER");
end

function Channel:OnDisable()
    self:UnregisterChatEvent("CHAT_MSG_CHANNEL");
    self:UnregisterChatEvent("CHAT_MSG_CHANNEL_JOIN");
    self:UnregisterChatEvent("CHAT_MSG_CHANNEL_LEAVE");
    self:UnregisterChatEvent("CHAT_MSG_CHANNEL_NOTICE");
    self:UnregisterChatEvent("CHAT_MSG_CHANNEL_NOTICE_USER");
end

function Channel:OnWindowDestroyed(self)
    if(self.type == "chat" and self.chatType == "channel") then
        local chatName = self.theUser;
        Windows[chatName].chatType = nil;
        Windows[chatName].unreadCount = nil;
        Windows[chatName].chatLoaded = nil;
        Windows[chatName].channelNumber = nil;
        Windows[chatName].channelSpecial = nil;
        cleanChatList(Windows[chatName]);
        Windows[chatName] = nil;
    end
end


Channel.waitingList = {};
--GetChannelRosterInfo(id, rosterIndex)

local function loadChatList(win, ...)
    cleanChatList(win);
    for i=1, select("#", ...) do
        table.insert(win.chatList, string.trim(select(i, ...)));
    end
end

local function updateJoinLeave(event, ...)
    local arg1, who, arg3, channelIdentifier, arg5, arg6, arg7, channelNumber, arg9 = ...;
    for _, win in pairs(Windows) do
        if(win.channelIdentifier == channelIdentifier) then
            win.widgets.chat_info:SetText(GetChannelCount(win.channelNumber));
            local color = _G.ChatTypeInfo["CHANNEL"..channelNumber];
            win:AddEventMessage(color.r, color.g, color.b, event, ...);
            return;
        end
    end
end

function Channel:CHAT_MSG_CHANNEL_JOIN(...)
    local arg1, who, arg3, channelIdentifier, arg5, arg6, arg7, channelNumber, arg9 = ...;
    updateJoinLeave("CHAT_MSG_CHANNEL_JOIN", ...)
end

function Channel:CHAT_MSG_CHANNEL_LEAVE(...)
    local arg1, who, arg3, channelIdentifier, arg5, arg6, arg7, channelNumber, arg9 = ...;
    updateJoinLeave("CHAT_MSG_CHANNEL_LEAVE", ...)
end

function Channel:CHAT_MSG_CHANNEL_NOTICE(...)
    local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11 = ...;
    for _, win in pairs(Windows) do
        if(win.channelIdentifier == arg4) then
            local color = _G.ChatTypeInfo["CHANNEL"..arg8];
            win:AddEventMessage(color.r, color.g, color.b, "CHAT_MSG_CHANNEL_NOTICE", ...);
            return;
        end
    end
    -- create new window if arg1 is YOU_JOINED
    if(arg1 == "YOU_JOINED") then
        -- open window.
        Channel:CHAT_MSG_CHANNEL("", "", nil, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    end
end

function Channel:CHAT_MSG_CHANNEL_NOTICE_USER(...)
    local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11 = ...;
    for _, win in pairs(Windows) do
        if(win.channelIdentifier == arg4) then
            local color = _G.ChatTypeInfo["CHANNEL"..arg8];
            win:AddEventMessage(color.r, color.g, color.b, "CHAT_MSG_CHANNEL_NOTICE_USER", ...);
            return;
        end
    end
end

function Channel:OnWindowShow(win)
    if(win.type == "chat" and win.chatType == "channel") then
        win.widgets.chat_info:SetText(GetChannelCount(win.channelNumber));
    end
end

-- manage suppression
function Channel:CHAT_MSG_CHANNEL_CONTROLLER(eventController, arg1, arg2, arg3, ...)
    if(eventController.ignoredByWIM) then
        eventController:BlockFromDelegate(self);
        return;
    end
    local arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11 = ...;
    -- arg7 Generic Channels (1 for General, 2 for Trade, 22 for LocalDefense, 23 for WorldDefense and 26 for LFG)
    -- arg8 Channel Number
    -- arg9 Channel Name
    local isWorld = arg7 and arg7 > 0;
    local channelName = string.split(" - ", arg9);
    local neverSuppress = db.chat[isWorld and "world" or "custom"].channelSettings[channelName] and db.chat[isWorld and "world" or "custom"].channelSettings[channelName].neverSuppress;
    --check options. do we want the specified channels.
    if(isWorld and not db.chat.world.enabled) then
        return;
    elseif(not isWorld and not db.chat.custom.enabled) then
        return;
    elseif(not neverSuppress and getRuleSet().supress and db.chat[isWorld and "world" or "custom"].channelSettings[channelName] and db.chat[isWorld and "world" or "custom"].channelSettings[channelName].monitor) then
        eventController:BlockFromChatFrame(self);
    end
end

function Channel:CHAT_MSG_CHANNEL(...)
    local filter, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = honorChatFrameEventFilter("CHAT_MSG_CHANNEL", ...);
    if(filter) then
        return;
    end
    -- arg7 Generic Channels (1 for General, 2 for Trade, 22 for LocalDefense, 23 for WorldDefense and 26 for LFG)
    -- arg8 Channel Number
    -- arg9 Channel Name
    local isWorld = arg7 and arg7 > 0;
    local channelName = string.split(" - ", arg9);
    --check options. do we want the specified channels.
    if(isWorld and not db.chat.world.enabled) then
        return;
    elseif(not isWorld and not db.chat.custom.enabled) then
        return;
    elseif(not db.chat[isWorld and "world" or "custom"].channelSettings[channelName] or not db.chat[isWorld and "world" or "custom"].channelSettings[channelName].monitor) then
        return;
    end
    local win = getChatWindow(channelName, "channel");
    local color = _G.ChatTypeInfo["CHANNEL"..arg8];
    if(arg7 == 1 or arg7 == 2 or arg7 == 22 or arg7 == 23 or arg7 == 26) then
        win.widgets.char_info:SetText(arg9);
        win.channelSpecial = _G.time();
    else
        win.widgets.char_info:SetText("");
    end
    win.channelNumber = arg8;
    win.channelIdentifier = arg4;
    if(win:IsVisible()) then
        win.widgets.chat_info:SetText(GetChannelCount(win.channelNumber));
    end
    self.chatLoaded = true;
    if(arg1 and _G.strlen(arg1) > 0) then
        arg3 = CleanLanguageArg(arg3);
        win:AddEventMessage(color.r, color.g, color.b, "CHAT_MSG_CHANNEL", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        local neverPop = db.chat[isWorld and "world" or "custom"].channelSettings[channelName] and db.chat[isWorld and "world" or "custom"].channelSettings[channelName].neverPop;
        if(arg2 ~= _G.UnitName("player")) then
            win.unreadCount = win.unreadCount and (win.unreadCount + 1) or 1;
            if(not neverPop) then
                win:Pop("in");
            end
        else
            if(not neverPop) then
                win:Pop("out");
            end
        end
        CallModuleFunction("PostEvent_ChatMessage", "CHAT_MSG_CHANNEL", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    end
end

function Channel:SettingsChanged()
    if(db.chat.world.enabled or db.chat.custom.enabled) then
        self:Enable();
    else
        self:Disable();
    end
end





-- alert management
local ChatAlerts = CreateModule("ChatAlerts");
function ChatAlerts:OnWindowShow(win)
    if(win.type == "chat") then
        MinimapPopAlert(win.theUser);
    end
end
ChatAlerts.OnWindowDestroyed = ChatAlerts.OnWindowShow;


function ChatAlerts:PostEvent_ChatMessage(event, ...)
    local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11 = ...;
    if(arg2 == _G.UnitName("player")) then
        return; -- we don't count our own messages as new.
    end
    event = event:gsub("CHAT_MSG_", "");
    if(event == "CHANNEL") then
        local isWorld = arg7 and arg7 > 0;
        local channelName = string.split(" - ", arg9);
        local win = getChatWindow(channelName, "channel");
        local showAlert = db.chat[isWorld and "world" or "custom"].channelSettings[channelName] and db.chat[isWorld and "world" or "custom"].channelSettings[channelName].showAlerts;
        if(showAlert and win and not win:IsVisible() and win.unreadCount) then
            local color = _G.ChatTypeInfo["CHANNEL"..arg8];
            MinimapPushAlert(win.theUser, RGBPercentToHex(color.r, color.g, color.b), win.unreadCount);
        end
    else
        local win;
        if(event == "GUILD" and db.chat.guild.showAlerts) then
            win = getChatWindow(_G.GUILD, "guild");
        elseif(event == "OFFICER" and db.chat.officer.showAlerts) then
            win = getChatWindow(_G.GUILD_RANK1_DESC, "officer");
        elseif(event == "PARTY" and db.chat.party.showAlerts) then
            win = getChatWindow(_G.PARTY, "party");
        elseif((event == "RAID" or event == "RAID_LEADER") and db.chat.raid.showAlerts) then
            win = getChatWindow(_G.RAID, "raid");
        elseif((event == "BATTLEGROUND" or event == "BATTLEGROUND_LEADER") and db.chat.battleground.showAlerts) then
            win = getChatWindow(_G.BATTLEGROUND, "battleground");
        elseif(event == "SAY" and db.chat.say.showAlerts) then
            win = getChatWindow(_G.SAY, "say");
        end
        
        if(win and not win:IsVisible() and win.unreadCount and win.unreadCount > 0) then
            local color = _G.ChatTypeInfo[string.upper(win.chatType)];
            MinimapPushAlert(win.theUser, RGBPercentToHex(color.r, color.g, color.b), win.unreadCount);
        end
    end
end

-- should never be disabled.
ChatAlerts.canDisable = false;
ChatAlerts:Enable();



-- Options
-- create ChatOptions Module
local ChatOptions = CreateModule("ChatOptions");
local function loadChatOptions()
    
    local desc = L["WIM will manage this chat type within its own message windows."];
    
    -- standard chat template
    local function createChatTemplate(chatName, moduleName, chatType)
        local chatDB = db.chat[chatType];
        local f = options.CreateOptionsFrame();
        f.sub = f:CreateSection(chatName, desc);
        f.sub.nextOffSetY = -10;
        f.sub:CreateCheckButton(L["Enable"], WIM.modules[moduleName], "enabled", nil, function(self, button) EnableModule(moduleName, self:GetChecked()); end);
        f.sub.nextOffSetY = -30;
        f.sub:CreateCheckButton(L["Show Minimap Alerts"], chatDB, "showAlerts");
        f.sub.nextOffSetY = -25;
        f.sub:CreateCheckButton(L["Never pop-up on my screen."], chatDB, "neverPop");
        f.sub:CreateCheckButton(L["Never suppress messages."], chatDB, "neverSuppress");
        return f;
    end
    
    local channelList = {};
    local function getChannelList(world)
        --clear list
        for k, _ in pairs (channelList) do
            channelList[k] = nil;
        end
        for i=1, 20 do
            local name, header, collapsed, channelNumber, count, active, category, voiceEnabled, voiceActive = _G.GetChannelDisplayInfo(i);
            if((world and category == "CHANNEL_CATEGORY_WORLD") or (not world and category == "CHANNEL_CATEGORY_CUSTOM")) then
                table.insert(channelList, name.."*"..(active and "1" or "0").."*"..(channelNumber or "0"));
            end
        end
        return channelList;
    end
    
    
    local channelScrollCount = 1;
    local function createChannelChatTemplate(chatName, channelType, channelListFun)
        local f = options.CreateOptionsFrame();
        f.sub = f:CreateSection(chatName, desc);
        f.sub.nextOffSetY = -10;
        f.sub.enabled = f.sub:CreateCheckButton(L["Enable"], db.chat[channelType], "enabled", nil, function(self, button) Channel:SettingsChanged(); end);
        f.sub.nextOffSetY = -10;
        
        --list
        f.sub.list = f.sub:ImportCustomObject(_G.CreateFrame("Frame"));
        options.AddFramedBackdrop(f.sub.list);
        f.sub.list:SetFullSize();
        f.sub.list.buttonHeight = 80;
        f.sub.list:SetHeight(4 * f.sub.list.buttonHeight);
        f.sub.list.scroll = _G.CreateFrame("ScrollFrame", f.sub:GetName().."ChannelScroll"..channelScrollCount, f.sub.list, "FauxScrollFrameTemplate");
        channelScrollCount = channelScrollCount + 1;
        f.sub.list.scroll:SetPoint("TOPLEFT", 0, -1);
        f.sub.list.scroll:SetPoint("BOTTOMRIGHT", -23, 0);
        f.sub.list.scroll.update = function(self)
            local channelList = channelListFun();
            local offset = _G.FauxScrollFrame_GetOffset(self);
            for i=1, #f.sub.list.buttons do
                local index = i+offset;
                if(index <= #channelList) then
                    local name, active, channelNumber = string.split("*", channelList[index]);
                    active = active == "1";
                    f.sub.list.buttons[i]:Show();
                    f.sub.list.buttons[i].channelName = name;
                    if(not db.chat[channelType].channelSettings[name]) then
                        db.chat[channelType].channelSettings[name] = {};
                    end
                    f.sub.list.buttons[i].title:SetText("|cffffffff"..channelNumber..". |r"..name);
                    f.sub.list.buttons[i].cb1:SetChecked(db.chat[channelType].channelSettings[name] and db.chat[channelType].channelSettings[name].monitor);
                    f.sub.list.buttons[i].neverPop:SetChecked(db.chat[channelType].channelSettings[name] and db.chat[channelType].channelSettings[name].neverPop);
                    f.sub.list.buttons[i].neverSuppress:SetChecked(db.chat[channelType].channelSettings[name] and db.chat[channelType].channelSettings[name].neverSuppress);
                    f.sub.list.buttons[i].showAlerts:SetChecked(db.chat[channelType].channelSettings[name] and db.chat[channelType].channelSettings[name].showAlerts);
                    f.sub.list.buttons[i].noHistory:SetChecked(db.chat[channelType].channelSettings[name] and db.chat[channelType].channelSettings[name].noHistory);
                    local color = _G.ChatTypeInfo["CHANNEL"..channelNumber];
                    f.sub.list.buttons[i].title:SetTextColor(color.r, color.g, color.b);
                    if(active) then
                        f.sub.list.buttons[i].title:SetAlpha(1);
                    else
                        f.sub.list.buttons[i].title:SetAlpha(.4);
                    end
                else
                    f.sub.list.buttons[i]:Hide();
                end
            end
            _G.FauxScrollFrame_Update(self, #channelList, #f.sub.list.buttons, f.sub.list.buttonHeight);
        end
        f.sub.list.scroll:SetScript("OnVerticalScroll", function(self, offset)
            _G.FauxScrollFrame_OnVerticalScroll(self, offset, f.sub.list.buttonHeight, f.sub.list.scroll.update);
        end);
        f.sub.list:SetScript("OnShow", function(self)
            self.scroll:update();
        end);
        f.sub.list.createButton = function(self)
            self.buttons = self.buttons or {};
            local button = _G.CreateFrame("Button", nil, self);
            button:SetHeight(self.buttonHeight);
            --button:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD");
            button.bg = button:CreateTexture(nil, "BACKGROUND");
            button.bg:SetAllPoints();
            button.bg:SetTexture(1,1,1, ((#self.buttons+1) % 2)*.1);
            button.bg:SetGradientAlpha("HORIZONTAL", 1,1,1,1, 0,0,0,0);
            button.border = {};
            
            button.border.left = button:CreateTexture(nil, "OVERLAY");
            button.border.left:SetPoint("TOPLEFT");
            button.border.left:SetPoint("BOTTOMLEFT");
            button.border.left:SetWidth(4);
            button.border.left:SetTexture(1,1,1,.5);
            
            button.title = button:CreateFontString(nil, "OVERLAY", "ChatFontNormal");
            button.title:SetPoint("TOPLEFT", 35, -8);
            button.title:SetPoint("TOPRIGHT");
            button.title:SetJustifyH("LEFT")
            local font, height, flags = button.title:GetFont();
            button.title:SetFont(font, 14, flags);
            button.title:SetTextColor(_G.GameFontNormal:GetTextColor());
            button.title:SetText("Test");
            --monitor checkbox
            button.cb1 = _G.CreateFrame("CheckButton", nil, button, "UICheckButtonTemplate");
            button.cb1:SetPoint("RIGHT", button.title, "LEFT", -5, 0);
            button.cb1:SetScale(.75);
            button.cb1:SetScript("OnEnter", function(self)
                self:GetParent():GetParent().help:SetJustifyH("LEFT");
                self:GetParent():GetParent().help:SetText(L["Have WIM monitor this channel."]);
            end);
            button.cb1:SetScript("OnLeave", function(self)
                self:GetParent():GetParent().help:SetText("");
            end);
            button.cb1:SetScript("OnClick", function(self)
                local name = self:GetParent().channelName;
                db.chat[channelType].channelSettings[name].monitor = self:GetChecked();
            end);
            
            -- Never Pop
            button.neverPop = _G.CreateFrame("CheckButton", nil, button, "UICheckButtonTemplate");
            button.neverPop:SetPoint("TOPLEFT", button.cb1, "BOTTOMRIGHT", 20, 0);
            button.neverPop:SetScale(.75);
            button.neverPop.text = button.neverPop:CreateFontString(nil, "OVERLAY", "ChatFontNormal");
            button.neverPop.text:SetPoint("LEFT", button.neverPop, "RIGHT", 0, 0);
            button.neverPop.text:SetText(L["Never Pop"]);
            button.neverPop:SetScript("OnClick", function(self)
                    local name = self:GetParent().channelName;
                    db.chat[channelType].channelSettings[name].neverPop = self:GetChecked();
            end)
            button.neverPop:SetScript("OnEnter", function(self)
                self:GetParent():GetParent().help:SetJustifyH("LEFT");
                self:GetParent():GetParent().help:SetText(L["Never have this window pop-up on my screen."]);
            end);
            button.neverPop:SetScript("OnLeave", function(self)
                self:GetParent():GetParent().help:SetText("");
            end);

            -- Never Suppress
            button.neverSuppress = _G.CreateFrame("CheckButton", nil, button, "UICheckButtonTemplate");
            button.neverSuppress:SetPoint("TOPLEFT", button.neverPop, "BOTTOMLEFT", 0, 0);
            button.neverSuppress:SetScale(.75);
            button.neverSuppress.text = button.neverSuppress:CreateFontString(nil, "OVERLAY", "ChatFontNormal");
            button.neverSuppress.text:SetPoint("LEFT", button.neverSuppress, "RIGHT", 0, 0);
            button.neverSuppress.text:SetText(L["Never Supress"]);
            button.neverSuppress:SetScript("OnClick", function(self)
                    local name = self:GetParent().channelName;
                    db.chat[channelType].channelSettings[name].neverSuppress = self:GetChecked();
            end)
            button.neverSuppress:SetScript("OnEnter", function(self)
                self:GetParent():GetParent().help:SetJustifyH("LEFT");
                self:GetParent():GetParent().help:SetText(L["Never suppress messages from the default chat frame."]);
            end);
            button.neverSuppress:SetScript("OnLeave", function(self)
                self:GetParent():GetParent().help:SetText("");
            end);
            
            
            -- Show Minimap Alerts
            button.showAlerts = _G.CreateFrame("CheckButton", nil, button, "UICheckButtonTemplate");
            button.showAlerts:SetPoint("TOPLEFT", button.neverPop, "TOPRIGHT", 150, 0);
            button.showAlerts:SetScale(.75);
            button.showAlerts.text = button.showAlerts:CreateFontString(nil, "OVERLAY", "ChatFontNormal");
            button.showAlerts.text:SetPoint("LEFT", button.showAlerts, "RIGHT", 0, 0);
            button.showAlerts.text:SetText(L["Show Minimap Alerts"]);
            button.showAlerts:SetScript("OnClick", function(self)
                    local name = self:GetParent().channelName;
                    db.chat[channelType].channelSettings[name].showAlerts = self:GetChecked();
            end)
            button.showAlerts:SetScript("OnEnter", function(self)
                self:GetParent():GetParent().help:SetJustifyH("LEFT");
                self:GetParent():GetParent().help:SetText(L["Show unread message alert on minimap."]);
            end);
            button.showAlerts:SetScript("OnLeave", function(self)
                self:GetParent():GetParent().help:SetText("");
            end);
            
            -- Don't record history
            button.noHistory = _G.CreateFrame("CheckButton", nil, button, "UICheckButtonTemplate");
            button.noHistory:SetPoint("TOPLEFT", button.showAlerts, "BOTTOMLEFT", 0, 0);
            button.noHistory:SetScale(.75);
            button.noHistory.text = button.noHistory:CreateFontString(nil, "OVERLAY", "ChatFontNormal");
            button.noHistory.text:SetPoint("LEFT", button.noHistory, "RIGHT", 0, 0);
            button.noHistory.text:SetText(L["No History"]);
            button.noHistory:SetScript("OnClick", function(self)
                    local name = self:GetParent().channelName;
                    db.chat[channelType].channelSettings[name].noHistory = self:GetChecked();
            end)
            button.noHistory:SetScript("OnEnter", function(self)
                self:GetParent():GetParent().help:SetJustifyH("LEFT");
                self:GetParent():GetParent().help:SetText(L["Do not record history for this channel."]);
            end);
            button.noHistory:SetScript("OnLeave", function(self)
                self:GetParent():GetParent().help:SetText("");
            end);
            
	    
	    -- Don't play sounds
            button.noSound = _G.CreateFrame("CheckButton", nil, button, "UICheckButtonTemplate");
            button.noSound:SetPoint("TOPLEFT", button.noHistory, "TOPRIGHT", 100, 0);
            button.noSound:SetScale(.75);
            button.noSound.text = button.noSound:CreateFontString(nil, "OVERLAY", "ChatFontNormal");
            button.noSound.text:SetPoint("LEFT", button.noSound, "RIGHT", 0, 0);
            button.noSound.text:SetText(L["No Sound"]);
            button.noSound:SetScript("OnClick", function(self)
                    local name = self:GetParent().channelName;
                    db.chat[channelType].channelSettings[name].noSound = self:GetChecked();
            end)
            button.noSound:SetScript("OnEnter", function(self)
                self:GetParent():GetParent().help:SetJustifyH("LEFT");
                self:GetParent():GetParent().help:SetText(L["Do not play sounds for this channel."]);
            end);
            button.noSound:SetScript("OnLeave", function(self)
                self:GetParent():GetParent().help:SetText("");
            end);
	    
	    
            
            if(#self.buttons == 0) then
                button:SetPoint("TOPLEFT");
                button:SetPoint("TOPRIGHT", -25, 0);
            else
                button:SetPoint("TOPLEFT", self.buttons[#self.buttons], "BOTTOMLEFT");
                button:SetPoint("TOPRIGHT", self.buttons[#self.buttons], "BOTTOMRIGHT");
            end
            
            button:SetScript("OnUpdate", function(self, elapsed)
                    for _, border in pairs(self.border) do
                        if(_G.MouseIsOver(self)) then
                            border:Show();
                        else
                            border:Hide();
                        end
                    end
            end);
            
            table.insert(self.buttons, button);
        end
        for i=1, 4 do
            f.sub.list:createButton();
        end
        f.sub.list.help = f.sub.list:CreateFontString(nil, "OVERLAY", "ChatFontNormal");
        f.sub.list.help:SetPoint("TOPLEFT", f.sub.list, "BOTTOMLEFT", 0, -2);
        f.sub.list.help:SetPoint("BOTTOMRIGHT", f.sub.list, "BOTTOMRIGHT", 0, -12);
        f.sub.list.help:SetText("");
        f.sub.list.help:SetJustifyH("LEFT");
        local font, height, flags = f.sub.list.help:GetFont();
        f.sub.list.help:SetFont(font, 12, flags);
        
        
        return f;
    end
    
    local function createGuildChat()
        local f = createChatTemplate(_G.GUILD, "GuildChat", "guild");
        return f;
    end
    
    local function createOfficerChat()
        local f = createChatTemplate(_G.GUILD_RANK1_DESC, "OfficerChat", "officer");
        return f;
    end
    
    local function createPartyChat()
        local f = createChatTemplate(_G.PARTY, "PartyChat", "party");
        return f;
    end
    
    local function createRaidChat()
        local f = createChatTemplate(_G.RAID, "RaidChat", "raid");
        return f;
    end
    
    local function createBattlegroundChat()
        local f = createChatTemplate(_G.BATTLEGROUND, "BattlegroundChat", "battleground");
        return f;
    end
    
    local function createSayChat()
        local f = createChatTemplate(_G.SAY, "SayChat", "say");
        return f;
    end
    
    local function createWorldChat()
        local f = createChannelChatTemplate(L["World Chat"], "world", function() return getChannelList(true); end);
        return f;
    end
    
    local function createCustomChat()
        local f = createChannelChatTemplate(L["Custom Chat"], "custom", getChannelList);
        return f;
    end
    
    RegisterOptionFrame(L["Chat"], _G.GUILD, createGuildChat);
    RegisterOptionFrame(L["Chat"], _G.GUILD_RANK1_DESC, createOfficerChat);
    RegisterOptionFrame(L["Chat"], _G.PARTY, createPartyChat);
    RegisterOptionFrame(L["Chat"], _G.RAID, createRaidChat);
    RegisterOptionFrame(L["Chat"], _G.BATTLEGROUND, createBattlegroundChat);
    RegisterOptionFrame(L["Chat"], _G.SAY, createSayChat);
    RegisterOptionFrame(L["Chat"], L["World Chat"], createWorldChat);
    RegisterOptionFrame(L["Chat"], L["Custom Chat"], createCustomChat);
    
    dPrint("Chat Options Initialized...");
    ChatOptions.optionsLoaded = true;
end


local function createUserList()
    local win = _G.CreateFrame("Frame", "WIM3_ChatUserList", WIM.WindowParent);
    win:EnableMouse(true);
    win:Hide();
    win:SetPoint("CENTER");
    -- set backdrop
    win:SetBackdrop({bgFile = "Interface\\AddOns\\"..addonTocName.."\\Modules\\Textures\\Menu_bg",
        edgeFile = "Interface\\AddOns\\"..addonTocName.."\\Modules\\Textures\\Menu", 
        tile = true, tileSize = 32, edgeSize = 32, 
        insets = { left = 32, right = 32, top = 32, bottom = 32 }});
    win:SetWidth(200);
    win.title = _G.CreateFrame("Frame", win:GetName().."Title", win);
    win.title:SetHeight(17);
    win.title:SetPoint("TOPLEFT", 20, -18); win.title:SetPoint("TOPRIGHT", -20, -18);
    win.title.bg = win.title:CreateTexture(nil, "BACKGROUND");
    win.title.bg:SetAllPoints();
    win.title.text = win.title:CreateFontString(nil, "OVERLAY", "ChatFontNormal");
    local font = win.title.text:GetFont();
    win.title.text:SetFont(font, 11, "");
    win.title.text:SetAllPoints();
    win.title.text:SetJustifyV("TOP");
    win.title.text:SetJustifyH("RIGHT");
    win.title.text:SetText("Testing...");
    win.buttons = {};
    
    for i = 1, USERLIST_BUTTON_COUNT do
        local button = _G.CreateFrame("Button", win:GetName().."Button1", win);
        button:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight", "ADD");
        button:GetHighlightTexture():SetVertexColor(.196, .388, .8);
        button:SetHeight(20);
        button.text = button:CreateFontString(nil, "OVERLAY", "ChatFontNormal");
        button.text:SetText("  Button "..i);
        button.text:SetJustifyH("LEFT");
        button.text:SetAllPoints();
        button.SetUser = function(self, user)
            self.user = user;
            self.text:SetText("  "..user);
        end
        
        button:SetScript("OnClick", function(self, button)
            --if(button == "RightButton") then
                --_G.ChannelRosterFrame_ShowDropdown(self.user);
            --end
        end);
        
        
        if(i == 1) then
            button:SetPoint("TOPLEFT", 20, -35);
            button:SetPoint("RIGHT", -30, 0);
        else
            button:SetPoint("TOPLEFT", win.buttons[i-1], "BOTTOMLEFT");
            button:SetPoint("TOPRIGHT", win.buttons[i-1], "BOTTOMRIGHT");
        end
       
       table.insert(win.buttons, button); 
    end
    win:SetHeight(#win.buttons*win.buttons[1]:GetHeight() + 35 + 20);
    win.scroll = _G.CreateFrame("ScrollFrame", win:GetName().."Scroll", win, "FauxScrollFrameTemplate");
    win.scroll:SetPoint("TOPLEFT", win.buttons[1], "TOPLEFT", 0, 0);
    win.scroll:SetPoint("BOTTOMRIGHT", win.buttons[#win.buttons], "BOTTOMRIGHT", -10, 0);
    
    win.scroll:SetScript("OnVerticalScroll", function(self, offset)
        _G.FauxScrollFrame_OnVerticalScroll(self, offset, win.buttons[1]:GetHeight(), win.updateList);
    end);
    
    win:SetScript("OnHide", function(self)
        self:Hide();
        self.attachedTo = nil;
        self.listCount = nil;
        self.listFun = nil;
        self:SetParent(_G.UIParent);
    end);
    
    win:SetScript("OnUpdate", function(self, elapsed)
        if(_G.MouseIsOver(self) or (self.attachedTo and _G.MouseIsOver(self.attachedTo))) then
            self.idleTime = 0;
        else
            self.idleTime = self.idleTime + elapsed;
            if(self.idleTime > 1) then
                self:Hide();
            end
        end
    end);
    
    
    win.SetChannel = function(self, title)
        self.title.text:SetText(string.format(L["Users in %s"], title or _G.CHAT).."  ");
    end
    
    win.PopUp = function(self, attachTo, point, point2, offsetX, offsetY)
        if(self.attachedTo == attachTo) then
            self:Hide();
            return;
        end
        self:SetParent(attachTo);
        self:SetParentWindow(attachTo.parentWindow);
        self.attachedTo = attachTo;
        self:SetPoint(point, attachTo, point2, offsetX, offsetY);
        self:Show();
        win:updateList();
    end
    
    win.updateList = function(self)
        self = win;
        if(self.listCount and self.listFun) then
            local count = self.listCount();
            local offset = _G.FauxScrollFrame_GetOffset(win.scroll);
            for i=1, USERLIST_BUTTON_COUNT do
                self.buttons[i]:Show();
                local index = i + offset;
                if(index <= count) then
                    self.buttons[i]:SetUser(self.listFun(index));
                    self.buttons[i]:Show();
                else
                    self.buttons[i]:Hide();
                end
            end
            
            _G.FauxScrollFrame_Update(win.scroll, count, USERLIST_BUTTON_COUNT, self.buttons[1]:GetHeight());
        else
            self:Hide();
        end
    end
    
    win.SetParentWindow = function(self, parent, start)
        start = start or self;
        start.parentWindow = parent;
        if(start.GetChildren) then
            for i=1, select("#", start:GetChildren()) do
                self:SetParentWindow(parent, select(i, start:GetChildren()));
            end
        end
    end
    
    return win;
end






function ChatOptions:OnEnableWIM()
    loadChatOptions();
    --load joined channels.
    
    --create user List
    if(not ChatUserList) then
        ChatUserList = createUserList();
    end
end


-- global reference
GetChatWindow = getChatWindow;

function CleanLanguageArg(arg)
    if(arg and arg ~= "Universal" and arg ~= _G.DEFAULT_CHAT_FRAME.defaultLanguage) then
        return arg;
    else
        return nil;
    end
end

local channelCountCache = {};
function GetChannelCount(id)
    if(ChatUserList:IsVisible()) then
        return channelCountCache[id] or "...";
    end
    for i=1, 20 do
        local name, header, collapsed, channelNumber, count, active, category, voiceEnabled, voiceActive = _G.GetChannelDisplayInfo(i);
        if(header and collapsed) then
            _G.ExpandChannelHeader(i);
            return GetChannelCount(id);
        end
        if(id == channelNumber) then
            if(_G.GetSelectedDisplayChannel() ~= i) then
                _G.SetSelectedDisplayChannel(i);
                name, header, collapsed, channelNumber, count, active, category, voiceEnabled, voiceActive = _G.GetChannelDisplayInfo(i);
            end
            channelCountCache[id] = channelCountCache[id] or "...";
            channelCountCache[id] = count or channelCountCache[id];
            return channelCountCache[id];
        end
    end
    return 0;
end
