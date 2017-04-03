-- File: WhisperEngine.lua
-- Author: John Langone (Pazza - Bronzebeard)
-- Description: This module handles whisper behaviors as well as their respective window actions.

--[[
    Extends Modules by adding:
        Module:PostEvent_Whisper(args[...])
        Module:PostEvent_WhisperInform(args[...])
]]


-- imports
local WIM = WIM;
local _G = _G;
local CreateFrame = CreateFrame;
local hooksecurefunc = hooksecurefunc;
local table = table;
local pairs = pairs;
local strupper = strupper;
local gsub = gsub;
local strlen = strlen;
local strsub = strsub;
local string = string;
local IsShiftKeyDown = IsShiftKeyDown;
local select = select;
local unpack = unpack;
local math = math;
local time = time;

-- set name space
setfenv(1, WIM);

-- create WIM Module
local WhisperEngine = CreateModule("WhisperEngine", true);

-- This Module requires LibChatHandler-1.0
_G.LibStub:GetLibrary("LibChatHandler-1.0"):Embed(WhisperEngine);

-- declare default settings for whispers.
-- if new global env wasn't set to WIM's namespace, then your module would call as follows:
--      WhisperEngine.db_defaults... or WIM.db_defaults...
db_defaults.pop_rules.whisper = {
        --pop-up rule sets based off of your location
        resting = {
            onSend = true,
            onReceive = true,
            supress = true,
            autofocus = true,
            keepfocus = true,
        },
        combat = {
            onSend = false,
            onReceive = false,
            supress = false,
            autofocus = false,
            keepfocus = false,
        },
        pvp = {
            onSend = true,
            onReceive = true,
            supress = true,
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
            onSend = true,
            onReceive = true,
            supress = true,
            autofocus = false,
            keepfocus = false,
        },
        raid = {
            onSend = true,
            onReceive = true,
            supress = true,
            autofocus = false,
            keepfocus = false,
        },
        other = {
            onSend = true,
            onReceive = true,
            supress = true,
            autofocus = false,
            keepfocus = false,
        },
        alwaysOther = false,
        intercept = true,
}

db_defaults.displayColors.wispIn = {
	r=0.5607843137254902, 
	g=0.03137254901960784, 
	b=0.7607843137254902
    }
db_defaults.displayColors.wispOut = {
        r=1, 
	g=0.07843137254901961, 
	b=0.9882352941176471
    }
db_defaults.displayColors.BNwispIn = {
	r=0,
	g=0.4862745098039216,
	b=0.6549019607843137,
    }
db_defaults.displayColors.BNwispOut = {
        r=0.1725490196078431,
	g=0.6352941176470588,
	b=1,
    }

local Windows = windows.active.whisper;

local WhisperQueue_Bowl = {}; -- used to recycle tables for queue
local WhisperQueue = {}; -- active event queue
local WhisperQueue_Index = {}; -- a quick reference to an active index

local CF_MessageEventHandler_orig; -- used for a hook of the chat frame. Messaage filter handlers aren't sufficient.

local addToTableUnique = addToTableUnique;
local removeFromTable = removeFromTable;

local recentSent = {};
local maxRecent = 10;

local alertPushed = false;

local function updateMinimapAlerts()
    local count = 0;
    for _, win in pairs(Windows) do
        if(not win:IsVisible()) then
            count = count + (win.unreadCount or 0);
        end
    end
    if(count == 0 and alertPushed) then
        alertPushed = false;
        MinimapPopAlert(L["Whispers"]);
    elseif(count > 0) then
        alertPushed = true;
        local color = db.displayColors.wispIn;
        MinimapPushAlert(L["Whispers"], RGBPercentToHex(color.r, color.g, color.b), count);
        DisplayTutorial(L["Whisper Received!"], L["You received a whisper which was hidden due to your current activity. You can change how whispers behave in WIM's options by typing"].." |cff69ccf0/wim|r");
    end
end

function WhisperEngine:OnEnableWIM()
        WhisperEngine:RegisterChatEvent("CHAT_MSG_WHISPER");
        WhisperEngine:RegisterChatEvent("CHAT_MSG_WHISPER_INFORM");
        WhisperEngine:RegisterChatEvent("CHAT_MSG_AFK");
        WhisperEngine:RegisterChatEvent("CHAT_MSG_DND");
        WhisperEngine:RegisterChatEvent("CHAT_MSG_SYSTEM");
	WhisperEngine:RegisterChatEvent("CHAT_MSG_BN_WHISPER");
        WhisperEngine:RegisterChatEvent("CHAT_MSG_BN_WHISPER_INFORM");
end

function WhisperEngine:OnDisableWIM()
        WhisperEngine:UnregisterChatEvent("CHAT_MSG_WHISPER");
        WhisperEngine:UnregisterChatEvent("CHAT_MSG_WHISPER_INFORM");
        WhisperEngine:UnregisterChatEvent("CHAT_MSG_AFK");
        WhisperEngine:UnregisterChatEvent("CHAT_MSG_DND");
        WhisperEngine:UnregisterChatEvent("CHAT_MSG_SYSTEM");
	WhisperEngine:UnregisterChatEvent("CHAT_MSG_BN_WHISPER");
        WhisperEngine:UnregisterChatEvent("CHAT_MSG_BN_WHISPER_INFORM");
end



local function getWhisperWindowByUser(user, isBN)
    user = FormatUserName(user);
    if(not user or user == "") then
        -- if invalid user, then return nil;
        return nil;
    end
    local obj = Windows[user];
    if(obj and obj.type == "whisper") then
        -- if the whisper window exists, return the object
        return obj;
    else
        -- otherwise, create a new one.
        Windows[user] = CreateWhisperWindow(user);
	Windows[user].isBN = isBN;
	Windows[user].bn = Windows[user].bn or {};
        if(db.whoLookups or lists.gm[user] or Windows[user].isBN) then
            Windows[user]:SendWho(); -- send who request
        end
        Windows[user].online = true;
        return Windows[user];
    end
end

local function windowDestroyed(self)
    if(IsShiftKeyDown() or self.forceShift) then
        local user = self:GetParent().theUser;
        Windows[user].online = nil;
        Windows[user].msgSent = nil;
	for k in pairs(Windows[user].bn) do
		Windows[user].bn[k] = nil;
	end
	Windows[user].isBN = nil;
        Windows[user] = nil;
    end
end

function WhisperEngine:OnWindowDestroyed(self)
    if(self.type == "whisper") then
        local user = self.theUser;
        Windows[user] = nil;
    end
end


function WhisperEngine:OnWindowShow(win)
    updateMinimapAlerts();
end

local splitMessage, splitMessageLinks = {}, {};
function SendSplitMessage(PRIORITY, HEADER, theMsg, CHANNEL, EXTRA, to)
        -- parse out links as to not split them incorrectly.
        theMsg, results = string.gsub(theMsg, "(|H[^|]+|h[^|]+|h)", function(theLink)
                table.insert(splitMessageLinks, theLink);
                return "\001\002"..paddString(#splitMessageLinks, "0", string.len(theLink)-4).."\003\004";
        end);
        
        -- split up each word.
        SplitToTable(theMsg, "%s", splitMessage);
        
        --reconstruct message into chunks of no more than 255 characters.
        local chunk = "";
        for i=1, #splitMessage + 1 do
                if(splitMessage[i] and string.len(chunk) + string.len(splitMessage[i]) <= 254) then
                        chunk = chunk..splitMessage[i].." ";
                else
                        -- reinsert links of necessary
                        chunk = string.gsub(chunk, "\001\002%d+\003\004", function(link)
                                local index = _G.tonumber(string.match(link, "(%d+)"));
                                return splitMessageLinks[index] or link;
                        end);
			if(Windows[to] and Windows[to].isBN) then
				_G.BNSendWhisper(Windows[to].bn.id, chunk);
			else
				_G.ChatThrottleLib:SendChatMessage(PRIORITY, HEADER, chunk, CHANNEL, EXTRA, to);
                        end
			chunk = (splitMessage[i] or "").." ";
                end
        end
        
        -- clean up
        for k, _ in pairs(splitMessage) do
                splitMessage[k] = nil;
        end
        for k, _ in pairs(splitMessageLinks) do
                splitMessageLinks[k] = nil;
        end
end


RegisterWidgetTrigger("msg_box", "whisper", "OnEnterPressed", function(self)
        local obj = self:GetParent();
        local msg = PreSendFilterText(self:GetText());
        local msgCount = math.ceil(string.len(msg)/255);
        if(msgCount == 1) then
            Windows[obj.theUser].msgSent = true;
	    if(obj.isBN) then
		_G.BNSendWhisper(obj.bn.id, msg);
	    else
	        _G.ChatThrottleLib:SendChatMessage("ALERT", "WIM", msg, "WHISPER", nil, obj.theUser);
	    end
        elseif(msgCount > 1) then
            Windows[obj.theUser].msgSent = true;
            SendSplitMessage("ALERT", "WIM", msg, "WHISPER", nil, obj.theUser);
        end
        self:SetText("");
    end);


--------------------------------------
--          Event Handlers          --
--------------------------------------

-- CHAT_MSG_WHISPER  CONTROLLER (For Supression from Chat Frame)
function WhisperEngine:CHAT_MSG_WHISPER_CONTROLLER(eventItem, ...)
    if(select(6, ...) == "GM") then
        lists.gm[select(2, ...)] = true;
    end
    if(eventItem.ignoredByWIM) then
        return;
    end
    -- execute appropriate supression rules
    local curState = curState;
    curState = db.pop_rules.whisper.alwaysOther and "other" or curState;
    if(WIM.db.pop_rules.whisper[curState].supress) then
        eventItem:BlockFromChatFrame();
    end
end

function WhisperEngine:CHAT_MSG_WHISPER(...)
    local filter, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = honorChatFrameEventFilter("CHAT_MSG_WHISPER", ...);
    if(filter) then
        return; -- ChatFrameEventFilter says don't process
    end
    local color = WIM.db.displayColors.wispIn; -- color contains .r, .g & .b
    local win = getWhisperWindowByUser(arg2);
    win.unreadCount = win.unreadCount and (win.unreadCount + 1) or 1;
    win:AddEventMessage(color.r, color.g, color.b, "CHAT_MSG_WHISPER", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    win:Pop("in");
    _G.ChatEdit_SetLastTellTarget(arg2);
    win.online = true;
    updateMinimapAlerts();
    CallModuleFunction("PostEvent_Whisper", ...);
end

-- CHAT_MSG_WHISPER_INFORM  CONTROLLER (For Supression from Chat Frame)
function WhisperEngine:CHAT_MSG_WHISPER_INFORM_CONTROLLER(eventItem, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    if(eventItem.ignoredByWIM) then
        return;
    end
    -- execute appropriate supression rules
    local curState = curState;
    curState = db.pop_rules.whisper.alwaysOther and "other" or curState;
    if(WIM.db.pop_rules.whisper[curState].supress) then
        eventItem:BlockFromChatFrame();
    end
end

function WhisperEngine:CHAT_MSG_WHISPER_INFORM(...)
    local filter, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = honorChatFrameEventFilter("CHAT_MSG_WHISPER_INFORM", ...);
    if(filter) then
        return; -- ChatFrameEventFilter says don't process
    end
    local color = db.displayColors.wispOut; -- color contains .r, .g & .b
    local win = getWhisperWindowByUser(arg2);
    win:AddEventMessage(color.r, color.g, color.b, "CHAT_MSG_WHISPER_INFORM", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    win:Pop("out");
    _G.ChatEdit_SetLastToldTarget(arg2);
    win.online = true;
    win.msgSent = false;
    CallModuleFunction("PostEvent_WhisperInform", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    addToTableUnique(recentSent, arg1);
        if(#recentSent > maxRecent) then
                table.remove(recentSent, 1);
        end
end


-- CHAT_MSG_BN_WHISPER_INFORM  CONTROLLER (For Supression from Chat Frame)
function WhisperEngine:CHAT_MSG_BN_WHISPER_INFORM_CONTROLLER(eventItem, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    if(eventItem.ignoredByWIM) then
        return;
    end
    -- execute appropriate supression rules
    local curState = curState;
    curState = db.pop_rules.whisper.alwaysOther and "other" or curState;
    if(WIM.db.pop_rules.whisper[curState].supress) then
        eventItem:BlockFromChatFrame();
    end
end

function WhisperEngine:CHAT_MSG_BN_WHISPER_INFORM(...)
    local filter, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13 = honorChatFrameEventFilter("CHAT_MSG_BN_WHISPER_INFORM", ...);
    if(filter) then
        return; -- ChatFrameEventFilter says don't process
    end
    local color = db.displayColors.BNwispOut; -- color contains .r, .g & .b
    local win = getWhisperWindowByUser(arg2, true);
    win:AddEventMessage(color.r, color.g, color.b, "CHAT_MSG_BN_WHISPER_INFORM", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    win:Pop("out");
    _G.ChatEdit_SetLastToldTarget(arg2);
    win.online = true;
    win.msgSent = false;
    CallModuleFunction("PostEvent_WhisperInform", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    addToTableUnique(recentSent, arg1);
        if(#recentSent > maxRecent) then
                table.remove(recentSent, 1);
        end
end

-- CHAT_MSG_BN_WHISPER  CONTROLLER (For Supression from Chat Frame)
function WhisperEngine:CHAT_MSG_BN_WHISPER_CONTROLLER(eventItem, ...)
    if(eventItem.ignoredByWIM) then
        return;
    end
    -- execute appropriate supression rules
    local curState = curState;
    curState = db.pop_rules.whisper.alwaysOther and "other" or curState;
    if(WIM.db.pop_rules.whisper[curState].supress) then
        eventItem:BlockFromChatFrame();
    end
end

function WhisperEngine:CHAT_MSG_BN_WHISPER(...)
    local filter, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13 = honorChatFrameEventFilter("CHAT_MSG_BN_WHISPER", ...);
    if(filter) then
        return; -- ChatFrameEventFilter says don't process
    end
    local color = WIM.db.displayColors.BNwispIn; -- color contains .r, .g & .b
    local win = getWhisperWindowByUser(arg2, true);
    win.unreadCount = win.unreadCount and (win.unreadCount + 1) or 1;
    win:AddEventMessage(color.r, color.g, color.b, "CHAT_MSG_BN_WHISPER", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    win:Pop("in");
    _G.ChatEdit_SetLastTellTarget(arg2);
    win.online = true;
    updateMinimapAlerts();
    CallModuleFunction("PostEvent_Whisper", ...);
end

-- CHAT_MSG_AFK  CONTROLLER (For Supression from Chat Frame)
function WhisperEngine:CHAT_MSG_AFK_CONTROLLER(eventItem, ...)
    -- execute appropriate supression rules
    local curState = curState;
    curState = db.pop_rules.whisper.alwaysOther and "other" or curState;
    if(WIM.db.pop_rules.whisper[curState].supress) then
        eventItem:BlockFromChatFrame();
    end
end

function WhisperEngine:CHAT_MSG_AFK(...)
    local color = db.displayColors.wispIn; -- color contains .r, .g & .b
    local win = Windows[select(2, ...)];
    if(win) then
        win:AddEventMessage(color.r, color.g, color.b, "CHAT_MSG_AFK", ...);
        win:Pop("out");
        _G.ChatEdit_SetLastTellTarget(select(2, ...));
        win.online = true;
    end
end

-- CHAT_MSG_DND  CONTROLLER (For Supression from Chat Frame) Handle same as AFK
function WhisperEngine:CHAT_MSG_DND_CONTROLLER(eventItem, ...)
        WhisperEngine:CHAT_MSG_AFK_CONTROLLER(eventItem, ...);
end

function WhisperEngine:CHAT_MSG_DND(...)
    local color = db.displayColors.wispIn; -- color contains .r, .g & .b
    local win = Windows[select(2, ...)];
    if(win) then
        win:AddEventMessage(color.r, color.g, color.b, "CHAT_MSG_AFK", ...);
        win:Pop("out");
        _G.ChatEdit_SetLastTellTarget(select(2, ...));
        win.online = true;
    end
end


-- CHAT_MSG_SYSTEM   CONTROLLER (for collection and supression of data)
function WhisperEngine:CHAT_MSG_SYSTEM_CONTROLLER(eventItem, msg)
    -- set patterns
    local ERR_CHAT_PLAYER_NOT_FOUND_S = string.gsub(_G.ERR_CHAT_PLAYER_NOT_FOUND_S, "%%s", "(.+)");
    local CHAT_IGNORED = string.gsub(_G.CHAT_IGNORED, "%%s", "(.+)");
    local ERR_FRIEND_ONLINE_SS = string.gsub(_G.ERR_FRIEND_ONLINE_SS, "%[", "%%[");
        ERR_FRIEND_ONLINE_SS = string.gsub(ERR_FRIEND_ONLINE_SS, "%]", "%%]");
        ERR_FRIEND_ONLINE_SS = string.gsub(ERR_FRIEND_ONLINE_SS, "%%s", "(.+)");
    local ERR_FRIEND_OFFLINE_S = string.gsub(_G.ERR_FRIEND_OFFLINE_S, "%%s", "(.+)");

    local user;
    local curState = db.pop_rules.whisper.alwaysOther and "other" or curState;
    
    -- detect player not online
    user = FormatUserName(string.match(msg, ERR_CHAT_PLAYER_NOT_FOUND_S));
    local win = Windows[user];
    if(win) then
        if(win.online or win.msgSent) then
            win:AddMessage(msg, db.displayColors.errorMsg.r, db.displayColors.errorMsg.g, db.displayColors.errorMsg.b);
        end
        win.online = false;
        win.msgSent = nil;
        if(win:IsShown() and db.pop_rules.whisper[curState].supress) then
                eventItem:BlockFromChatFrame();
        elseif(not win.msgSent) then
                eventItem:BlockFromChatFrame();
        end
        return;
    end
    
    -- detect player has you ignored
    user = FormatUserName(string.match(msg, CHAT_IGNORED));
    win = Windows[user];
    if(win) then
        if(win.online) then
            win:AddMessage(msg, db.displayColors.errorMsg.r, db.displayColors.errorMsg.g, db.displayColors.errorMsg.b);
        end
        win.online = false;
        if(win:IsShown() and db.pop_rules.whisper[curState].supress) then
                eventItem:Block();
        elseif(not win.msgSent) then
                eventItem:Block();
        end
        return;
    end
    
    -- detect player has come online
    user = FormatUserName(string.match(msg, ERR_FRIEND_ONLINE_SS));
    win = Windows[user];
    if(win) then
        win:AddMessage(msg, db.displayColors.sysMsg.r, db.displayColors.sysMsg.g, db.displayColors.sysMsg.b);
        win.online = true;
        if(win and win:IsShown() and db.pop_rules.whisper[curState].supress) then
            eventItem:Block();
        end
        return;
    end
    
        -- detect player has gone offline
    user = FormatUserName(string.match(msg, ERR_FRIEND_OFFLINE_S));
    win = Windows[user];
    if(win) then
        win:AddMessage(msg, db.displayColors.sysMsg.r, db.displayColors.sysMsg.g, db.displayColors.sysMsg.b);
        win.online = false;
        if(win and win:IsShown() and db.pop_rules.whisper[curState].supress) then
            eventItem:Block();
        end
        return;
    end
    
end


--------------------------------------
--          Whisper Related Hooks   --
--------------------------------------

local function replyTellTarget(TellNotTold)
    if(db.enabled) then
        local curState = curState;
        curState = db.pop_rules.whisper.alwaysOther and "other" or curState;
        local lastTell; 
	if(TellNotTold) then 
		lastTell = _G.ChatEdit_GetLastTellTarget(); 
	else 
		lastTell = _G.ChatEdit_GetLastToldTarget(); 
	end             
	if(lastTell ~= "" and db.pop_rules.whisper.intercept) then 
		local win = getWhisperWindowByUser(lastTell); 
		if(win:IsVisible() or db.pop_rules.whisper[curState].onSend) then 
			win.widgets.msg_box.setText = 1; 
			win:Pop(true); -- force popup 
			win.widgets.msg_box:SetFocus();
			local eb = getVisibleChatFrameEditBox();
			_G.ChatEdit_OnEscapePressed(getVisibleChatFrameEditBox() or _G.ChatFrame1EditBox); 
		end      
        end
    end
end


local tellTargetExtractionAutoComplete = _G.AUTOCOMPLETE_LIST.ALL;
function CF_ExtractTellTarget(editBox, msg)
	-- Grab the string after the slash command
	local target = string.match(msg, "%s*(.*)");
	
	--If we haven't even finished one word, we aren't done.
	if ( not target or not string.find(target, "%s") or (string.sub(target, 1, 1) == "|") ) then
		return false;
	end
	
	if ( _G.GetAutoCompleteResults(target, tellTargetExtractionAutoComplete.include, tellTargetExtractionAutoComplete.exclude, 1, nil, true) ) then
		--Even if there's a space, we still want to let the person keep typing -- they may be trying to type whatever is in AutoComplete.
		return false;
	end
	
	--Keep pulling off everything after the last space until we either have something on the AutoComplete list or only a single word is left.
	while ( string.find(target, "%s") ) do
		--Pull off everything after the last space.
		target = string.match(target, "(.+)%s+[^%s]*");
		if ( _G.GetAutoCompleteResults(target, tellTargetExtractionAutoComplete.include, tellTargetExtractionAutoComplete.exclude, 1, nil, true)  ) then
			break;
		end
	end

	msg = string.sub(msg, string.len(target) + 2);

	if(db and db.enabled) then
		local curState = curState;
		curState = db.pop_rules.whisper.alwaysOther and "other" or curState;
		if(db.pop_rules.whisper.intercept and db.pop_rules.whisper[curState].onSend) then
		    local win = getWhisperWindowByUser(target, _G.BNet_GetPresenceID(target));
		    win.widgets.msg_box.setText = 1;
		    win:Pop(true); -- force popup
		    win.widgets.msg_box:SetFocus();
		    _G.ChatEdit_OnEscapePressed(editBox);
		end
	end
end

-- the following hook is needed in order to intercept /r
hooksecurefunc("ChatEdit_ExtractTellTarget", CF_ExtractTellTarget);

--Hook ChatFrame_ReplyTell & ChatFrame_ReplyTell2
hooksecurefunc("ChatFrame_ReplyTell", function() replyTellTarget(true) end);
hooksecurefunc("ChatFrame_ReplyTell2", function() replyTellTarget(false) end);

local hookedSendChatMessage = _G.SendChatMessage;
function _G.SendChatMessage(...)
    if(select(2, ...) == "WHISPER") then
        local win = Windows[FormatUserName(select(4, ...)) or "NIL"];
        if(win) then
            win.msgSent = true;
        end
    end
    hookedSendChatMessage(...);
end

-- global reference
GetWhisperWindowByUser = getWhisperWindowByUser;





-- define context menu
local info = _G.UIDropDownMenu_CreateInfo();
info.text = "MENU_MSGBOX";
local msgBoxMenu = AddContextMenu(info.text, info);
        info = _G.UIDropDownMenu_CreateInfo();
        info.text = WIM.L["Recently Sent Messages"];
        info.notCheckable = true;
        msgBoxMenu:AddSubItem(AddContextMenu("RECENT_LIST", info), 1);
        local recentMenu = GetContextMenu("RECENT_LIST");
        if(recentMenu.menuTable) then
                for k, _ in pairs(recentMenu.menuTable) do
                        recentMenu.menuTable[k] = nil;
                end
        end
        for i=1, maxRecent do
            info = GetContextMenu("RECENT_LIST"..i) or _G.UIDropDownMenu_CreateInfo();
            info.txt = " ";
            info.hidden = true;
            info.notCheckable = true;
            recentMenu:AddSubItem(AddContextMenu("RECENT_LIST"..i, info));
        end

local function recentMenuClick(self)
        _G.CloseDropDownMenus();
        if(MSG_CONTEXT_MENU_EDITBOX) then
                if(_G.IsShiftKeyDown()) then
                        MSG_CONTEXT_MENU_EDITBOX:Insert(self.value);
                else
                        MSG_CONTEXT_MENU_EDITBOX:SetText(self.value);
                end
        end
end

RegisterWidgetTrigger("msg_box", "whisper,chat,w2w", "OnMouseDown", function(self)
                if(#recentSent == 0) then
                        local item = GetContextMenu("RECENT_LIST1");
                        item.text = "|cff808080 - "..L["None"].." - |r";
                        item.notClickable = true;
                        item.hidden = nil;
                        return;
                end
                for i=maxRecent, 1, -1 do
                        local item = GetContextMenu("RECENT_LIST"..(10-i+1));
                        item.notClickable = nil;
                        if(recentSent[i]) then
                                item.text = recentSent[i];
                                item.value = recentSent[i];
                                item.func = recentMenuClick;
                                item.hidden = nil;
                        else
                                item.hidden = true;
                        end
                end
        end);




-- This is a core module and must always be loaded...
WhisperEngine.canDisable = false;
WhisperEngine:Enable();