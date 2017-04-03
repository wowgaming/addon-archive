--imports
local WIM = WIM;
local _G = _G;
local table = table;
local string = string;
local pairs = pairs;
local tonumber = tonumber;
local type = type;
local math = math;
local tostring = tostring;

--set namespace
setfenv(1, WIM);

db_defaults.disableAddonMessages = isPrivateServer;

local SocketPool = {};
local recycled = {};

local socketCount = 0;
local socketFrame = _G.CreateFrame("Frame");
socketFrame:RegisterEvent("CHAT_MSG_ADDON");

local CommandHandlers = {};

WIM.stats.Socket = {
  i = 0,
  o = 0,
};
local Stats = WIM.stats.Socket;

local function getNewTable()
    if(#recycled > 0) then
        local tbl = recycled[1];
        table.remove(recycled, 1);
        return tbl;
    else
        return {};
    end
end

local function recycleTable(tbl)
    for k, _ in pairs(tbl) do
        tbl[k] = nil;
    end
    table.insert(recycled, tbl);
end


-- inbound Traffic:
local function getSocket(user, socketIndex)
    -- returns nil if socket doesn't exist
    return SocketPool[user] and SocketPool[user][socketIndex] or nil;
end

local function createNewSocket(user, socketIndex, dataLength)
    SocketPool[user] = SocketPool[user] or getNewTable();
    SocketPool[user][socketIndex] = getNewTable();
    SocketPool[user][socketIndex].data = "";
    SocketPool[user][socketIndex].len = tonumber(dataLength);
    return SocketPool[user][socketIndex];
end

local function ProcessData(channel, from, data)
    local cmd, dat = string.match(data, "^(%w+):(.*)$")
    dat = Decompress(dat);
    dPrint(channel..":"..from.."->"..cmd..":"..dat);
    if(CommandHandlers[cmd]) then
        for i = 1, #CommandHandlers[cmd] do
            if(CommandHandlers[cmd][i].callBack) then
                CommandHandlers[cmd][i].callBack(from, dat);
            end
        end
    end
end


local function OnEvent(self, event, ...)
    local addon, data, channel, from = ...;
    -- we are only processing WIM addon messages
    if(addon == "WIM") then
        Stats.i = Stats.i + string.len(data);
        local cmd, args, pcmd = string.match(data, "^#HEADER:(%d+):(%d+):(%w+)");
        if(cmd and args) then
            local socket = createNewSocket(from, tonumber(cmd), tonumber(args));
            socket.cmd = pcmd;
            return;
        end
        local sIndex, packet = string.match(data, "^#(%d+):(.*)");
        if(sIndex and packet) then
            local socket = getSocket(from, tonumber(sIndex));
            socket.data = socket.data..packet;
            local cmd = string.match(socket.data, "^(%w+):(.*)");
            --dPrint(string.len(socket.data)/socket.len*100 .. "%")
            if(CommandHandlers[cmd]) then
                for i = 1,  #CommandHandlers[cmd] do
                    if(CommandHandlers[cmd][i].progress) then
                        CommandHandlers[cmd][i].progress(from, string.len(socket.data)/socket.len);
                    end
                end
            end
            if(string.len(socket.data) == socket.len) then
                ProcessData(channel, from, socket.data);
                SocketPool[from][tonumber(sIndex)] = nil;
                recycleTable(socket);
            end
            return;
        end
        local cmd, args = string.match(data, "^!(.*)");
        if(cmd) then
            ProcessData(channel, from, cmd);
            return;
        end
    end
end

socketFrame:SetScript("OnEvent", OnEvent);


function RegisterAddonMessageHandler(command, callBack, progressCallBack)
    command = string.upper(command);
    CommandHandlers[command] = CommandHandlers[command] or {};
    table.insert(CommandHandlers[command], {
        callBack = callBack,
        progress = progressCallBack
    });
end


local function debugSentData(msg, ttype, target)
    if(WIM.beta) then
        WIM.debugSentData = WIM.debugSentData or {};
        table.insert(WIM.debugSentData, "["..msg.."],["..(ttype or "NIL").."],["..(target or "NIL").."]");
        if(#WIM.debugSentData > 100) then
            table.remove(WIM.debugSentData, #WIM.debugSentData);
        end
    end
end

local function isBattleNet(user)
  return _G.BNet_GetPresenceID(user);
end


-- outbound Traffic:
function SendData(ttype, target, cmd, data)
    if(db.disableAddonMessages or (ttype == "WHISPER" and isBattleNet(target))) then
        return; -- we don't want to send addon messages if on a private server.
    end
    data = data and tostring(data) or ""; --tostring(data);
    ttype = string.upper(ttype);
    if(ttype == "WHISPER" and IsGM(target)) then
        -- we do not want to send any messages to GM's
        return;
    end
    debugSentData(string.upper(cmd)..":"..data, ttype, target); -- for debugging
    if((string.len(cmd) + string.len(data) + 1) <= 200) then
        msg = string.upper(cmd)..":"..data;
    else
        msg = string.upper(cmd)..":"..Compress(data);
    end
    --local msg = string.upper(cmd)..":"..data
    local msgCount = math.ceil(string.len(msg)/200);
    if(msgCount == 1) then
        Stats.o = Stats.o + string.len(msg) + 1;
        _G.ChatThrottleLib:SendAddonMessage("NORMAL", "WIM", "!"..msg, ttype, target);
    else
        socketCount = socketCount + 1;
        local header = "#HEADER:"..socketCount..":"..string.len(msg)..":"..string.upper(cmd);
        local prefix = "#"..socketCount..":";
        Stats.o = Stats.o + string.len(header);
        _G.ChatThrottleLib:SendAddonMessage("NORMAL", "WIM", header, ttype, target);
        for i=1, msgCount do
            local chunk = string.sub(msg, ((i-1)*200+1), (((i-1)*200)+200));
            Stats.o = Stats.o + string.len(prefix) + string.len(chunk);
            _G.ChatThrottleLib:SendAddonMessage("BULK", "WIM", prefix..chunk, ttype, target);
        end
    end
end



-- Private Server Checks
local function addonMessages()
  if(db.disableAddonMessages) then
    db.disableAddonMessages = false;
    _G.DEFAULT_CHAT_FRAME:AddMessage("WIM: Addon Messages "..L["Enabled"]);
  else
    db.disableAddonMessages = true;
    _G.DEFAULT_CHAT_FRAME:AddMessage("WIM: Addon Messages "..L["Disabled"]);
  end
end
RegisterSlashCommand("addon_messages", addonMessages, L["Enable/Disable addon messages."]); -- ReloadUI()


