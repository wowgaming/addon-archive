--[[
Name: LibChatHandler-1.0
Revision: $Revision: 15 $
Date: $Date: 2010-04-21 14:51:36 +0000 (Wed, 21 Apr 2010) $
Author: Pazza <Bronzebeard> (johnlangone@gmail.com)
Website: http://www.wimaddon.com
Documentation: http://www.wimaddon.com/wiki/LibChatHandler-1.0
svn: svn://svn.curseforge.net/wow/libchathandler/mainline/trunk
Description: Event Model Control View (MCV) for handling chat events.
License: LGPL v2.1
]]

local MAJOR, MINOR = "LibChatHandler-1.0", tonumber(("$Revision: 15 $"):match("(%d+)"));
-- check if lib is already loaded and check versioning -- update as needed.
local prevLib = LibStub:GetLibrary("LibChatHandler-1.0", 1); -- load library silently.
local prevDelegatedEvents;
if(prevLib and prevLib:GetMinor() < MINOR) then
    --upgrade needed perform cleanup operations.
    prevDelegatedEvents = prevLib:GetDelegatedEventsTable();
    prevLib:ReadyUpgrade();
end

local lib = LibStub:NewLibrary(MAJOR, MINOR);

if not lib then return; end -- newer version is already loaded


-- locals are always faster than globals
local tbl_rm = table.remove;
local tbl_ins = table.insert;
local type = type;
local pairs = pairs;
local regd4Event = GetFramesRegisteredForEvent;
local str_find = string.find;


local DelegatedEvents = prevDelegatedEvents or {}; -- objects which handle events
local ChatEvents = {}; -- queued events
local messagesReceived = {}; -- organizer for delivered messages.

local eventHandler = LibChatHander_EventHandler or CreateFrame("Frame", "LibChatHander_EventHandler");


--------------------------------------
--          table recycling         --
--------------------------------------
local tablePool =   {{}, -- [1] in use
                    {}}; -- [2] available

-- get index of table from in use pool
local function getTableIndex(tbl)
    for i=1, #tablePool[1] do
        if(tablePool[1][i] == tbl) then
            return i;
        end
    end
end

local function pack(tbl, ...)
    for i=1, select("#", ...) do
        tbl[i] = select(i, ...);
    end
end

-- get an available or new table
local function newTable(...)
    if(#tablePool[2] > 0) then
        local tbl = tbl_rm(tablePool[2], 1);
        tbl_ins(tablePool[1], tbl);
        pack(tbl, ...);
        return tbl;
    else
        local tbl = {};
        tbl_ins(tablePool[1], tbl);
        pack(tbl, ...);
        return tbl;
    end
end

local function destroyTable(tbl)
    if(tbl) then
        for k, v in pairs(tbl) do
            if(type(v) == "table" and not v.GetParent and not v.LibChatHandler_Delegate) then
                destroyTable(v);
            end
            tbl[k] = nil;
        end
        -- whether or not the table was created here,
        -- save it for future use.
        local index = getTableIndex(tbl);
        if(index) then
            tbl_rm(tablePool[1], index);
        end
        tbl_ins(tablePool[2], tbl);
    end
end

local function tbl_indexOf(tbl, obj)
    if(type(tbl) == "table") then
        for i=1, #tbl do
            if(tbl[i] == obj) then
                return i;
            end
        end
    end
    return nil;
end

--------------------------------------
--        Event Object Object       --
--------------------------------------

--is delegate in suspended list
local function isSuspendedBy(eventItem, delegate)
    local tbl = eventItem.suspendedBy;
    return tbl_indexOf(tbl, delegate) and true or false;
end

--is delegate valid for eventItem
local function isValidDelegate(eventItem, delegate)
    local tbl = DelegatedEvents[eventItem:GetEvent()];
    if(tbl) then
        return tbl_indexOf(tbl, delegate) and true or false;
    else
        return false;
    end
end

-- The following functions provide actions for the chat events.
local function Suspend(self, delegate)
    if(isValidDelegate(self, delegate)) then
        if(isSuspendedBy(self, delegate)) then
            return false, "Event already suspended by delegate";
        else
            tbl_ins(self.suspendedBy, delegate);
            return true;
        end
    else
        return false, "Invalid delegate - Not registered for event.";
    end
end

local function Release(self, delegate)
    if(isSuspendedBy(self, delegate)) then
        tbl_rm(self.suspendedBy, tbl_indexOf(self.suspendedBy, delegate));
        if(#self.suspendedBy == 0) then
            lib:popEvents();
        end
        return true;
    else
        return false, "Delegate hasn't claimed responsibility for suspending this event.";
    end
end

local function Block(self)
    self.flag_block = true;
end

local function BlockFromChatFrame(self)
    self.flag_blocked_from_chatFrame = true;
end

local function BlockFromDelegate(self, delegate)
    if(isValidDelegate(self, delegate)) then
        tbl_ins(self.blockFrom, delegate);
        return true;
    else
        return false, "Invalid delegate - Not registered for event.";
    end
end

local function Allow(self)
    -- do nothing to event
end

-- provide some get methods for args & events
local function GetArgs(self)
    -- function returns 15 args incase blizzard ever decides to add more.
    return self.arg[1], self.arg[2], self.arg[3], self.arg[4], self.arg[5],
        self.arg[6], self.arg[7], self.arg[8], self.arg[9], self.arg[10],
        self.arg[11], self.arg[12], self.arg[13], self.arg[14], self.arg[15]; 
end

local function GetEvent(self)
    return self.event;
end

local function GetNumDelegates(self)
    return #DelegatedEvents[self:GetEvent()];
end

local function GetDelegate(self, index)
    return DelegatedEvents[self:GetEvent()][index];
end


-- instantiate new chat event object
local function newChatEvent(event, ...)
    local c = newTable();
    c.event = event;
    c.arg = newTable(...);
    c.frames = newTable(regd4Event(event));
    c.flag_block = false;
    c.flag_blocked_from_chatFrame = false;
    c.suspendedBy = newTable();
    c.blockFrom = newTable();
    --event actions
    c.Suspend = Suspend;
    c.Release = Release;
    c.Block = Block;
    c.BlockFromChatFrame = BlockFromChatFrame;
    c.BlockFromDelegate = BlockFromDelegate;
    c.Allow = Allow;
    --event data
    c.GetArgs = GetArgs;
    c.GetEvent = GetEvent;
    c.GetNumDelegate = GetNumDelegate;
    c.GetDelegate = GetDelegate;
    return c;
end



-- PROTOTYPE to AVOID HOOKING
local missingIdIndex = 10000;
local function filterFunc(self, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15, arg15, arg16)
    if(self and type(self.GetName) == "function" and string.match(self:GetName(), "^ChatFrame%d+$" )) then
        if(not arg11) then
            -- create arg11 (msgID) if none exists.
            arg11 = missingIdIndex*(-1);
            missingIdIndex = missingIdIndex + 1;
        end
        messagesReceived[arg11] = messagesReceived[arg11] or -1;
        -- block for now
        return messagesReceived[arg11] < 0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15, arg15, arg16;
    end
    return false, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15, arg15, arg16;
end

--------------------------------------
--          Event Handling          --
--------------------------------------

local function isChatEvent(event)
    if(type(event) == "string" and event ~= "CHAT_MSG_ADDON" and str_find(event, "^CHAT_")) then
        return true;
    else
        return false;
    end
end

local function popEvents()
    for i=#ChatEvents, 1, -1 do
        local e = ChatEvents[i];
        local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11 = e:GetArgs(); -- need arg11
        if(e.flag_sent_to_delegates and #e.suspendedBy == 0) then
            if(not e.flag_block) then
                tbl_rm(ChatEvents, i);
                -- first return to registered objects
                local delegates = DelegatedEvents[e:GetEvent()];
                if(delegates) then
                    -- for each delegate handling the event
                    for j=1, #delegates do
                        if(not tbl_indexOf(e.blockFrom, delegates[j])) then
                            local handler = delegates[j][e:GetEvent()];
                            if(handler) then
                                handler(delegates[j], e:GetArgs());
                            end
                        end
                    end
                end
                -- next return to chat frame... only if asked to...
                if(not e.flag_blocked_from_chatFrame) then
                    messagesReceived[arg11] = time();
                    for j=1,#e.frames do
                        --send ChatFrame* windows only
                        local f = e.frames[j];
                        local fName = f and f.GetName and f:GetName();
                        if(fName and str_find(fName, "^ChatFrame%d+$")) then
                            --ChatFrame_MessageEventHandler_orig(e.frames[j], e:GetEvent(), e:GetArgs());
                            ChatFrame_OnEvent(e.frames[j], e:GetEvent(), e:GetArgs());
                        end
                    end
                end
            else
                tbl_rm(ChatEvents, i);
            end
            messagesReceived[arg11] = nil;
            -- destroy event
            destroyTable(e); 
        end
    end
end

-- eventHandler OnEvent handler
local function eventHandler_OnEvent(self, event, ...)
    if(str_find(event, "^CHAT_")) then
        local e = newChatEvent(event, ...);
        local delegates = DelegatedEvents[event];
        tbl_ins(ChatEvents, 1, e);
        for i=1, #delegates do
            local delegate = delegates[i][event.."_CONTROLLER"];
            if(delegate) then
                    delegate(delegates[i], e, ...);
            end
        end
        e.flag_sent_to_delegates = true;
        popEvents();
    end
end
eventHandler:SetScript("OnEvent", eventHandler_OnEvent);
-- if we are upgrading, we want to make sure all events are accounted for.
for event, _ in pairs(DelegatedEvents) do
    eventHandler:RegisterEvent(event);
end


--------------------------------------
--    local lib declarations        --
--------------------------------------

local function RegisterChatEvent(self, chatEvent, priority)
    -- only register if chat event
    if(isChatEvent(chatEvent)) then
        -- register delegate and event
        if(DelegatedEvents[chatEvent]) then
            -- don't register the event more than once
            if(not tbl_indexOf(DelegatedEvents[chatEvent], self)) then
                if(priority) then
                    tbl_ins(DelegatedEvents[chatEvent], 1, self);
                else
                    tbl_ins(DelegatedEvents[chatEvent], self);
                end
            end
        else
            ChatFrame_AddMessageEventFilter(chatEvent, filterFunc);
            DelegatedEvents[chatEvent] = newTable(self);
        end
        eventHandler:RegisterEvent(chatEvent);
    end
end

local function UnregisterChatEvent(self, chatEvent)
    if(isChatEvent(chatEvent) and DelegatedEvents[chatEvent]) then
        local index = tbl_indexOf(DelegatedEvents[chatEvent], self);
        if(index) then
            tbl_rm(DelegatedEvents[chatEvent], index);
            if(#DelegatedEvents[chatEvent] == 0) then
                ChatFrame_RemoveMessageEventFilter(chatEvent, filterFunc)
                eventHandler:UnregisterEvent(chatEvent);
                local tbl = DelegatedEvents[chatEvent];
                DelegatedEvents[chatEvent] = nil;
                destroyTable(tbl);
            end
        end
    end
end

local function prepDelegate(delegate)
    delegate.RegisterChatEvent = RegisterChatEvent;
    delegate.UnregisterChatEvent = UnregisterChatEvent;
    delegate.LibChatHandler_Delegate = true;
end


--------------------------------------
--          Lib API                 --
--------------------------------------

-- debugging information
function lib:ShowStats()
    local cf = DEFAULT_CHAT_FRAME;
    cf:AddMessage("Tables in use: ".. #tablePool[1]);
    cf:AddMessage("Tables available: ".. #tablePool[2]);
    cf:AddMessage("Pending events in queue: "..#ChatEvents);
    cf:AddMessage("Delegated Events:");
    for event, tbl in pairs(DelegatedEvents) do
        cf:AddMessage("+-- "..event.." ("..#tbl..")");
    end
end


-- available lib API
function lib:NewDelegate()
    local delegate = newTable();
    prepDelegate(delegate);
    
    return delegate;
end

function lib:Embed(tbl)
    -- tbl must be a table, if not, do nothing
    if(type(tbl) ~= "table") then
        return;
    end
    -- prep the delegate
    prepDelegate(tbl);
end


-- get MINOR - for upgrade checks.
local function GetMinor()
    return MINOR;
end

-- get DelegatedEvents table for upgrade. (really only needed if Loaded on demand)
local function GetDelegatedEventsTable()
    return DelegatedEvents;
end

-- ready the lib to be upgraded.
local function ReadyUpgrade()
    -- restore hook
    --ChatFrame_MessageEventHandler = ChatFrame_MessageEventHandler_orig;
    ChatFrame_OnEvent = ChatFrame_OnEvent_orig;
end

-- load hidden API
setmetatable(lib, {
    __index = function(t, k)
        if(k == "popEvents") then return popEvents; end
        if(k == "GetMinor") then return GetMinor; end
        if(k == "GetDelegatedEventsTable") then return GetDelegatedEventsTable; end
        if(k == "ReadyUpgrade") then return ReadyUpgrade; end
    end
});