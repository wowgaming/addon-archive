--imports
local WIM = WIM;
local _G = _G;
local time = time;
local date = date;

--set namespace
setfenv(1, WIM);

local TimeStamps = WIM.CreateModule("TimeStamps", true);

-- define available timeStamps
local formats = {
    "%I:%M",	  -- HH:MM (12hr)
    "%I:%M %p",	  -- HH:MM AM/PM (12hr)
    "%H:%M",	  -- HH:MM (24hr)
    "%I:%M:%S",	  -- HH:MM:SS (12hr)
    "%I:%M:%S %p",-- HH:MM:SS AM/PM (12hr)
    "%H:%M:%S"	  -- HH:MM:SS (24hr)
};

db_defaults.timeStampFormat = formats[3];


local function addTimeStamp(msg, chatDisplay)
    return GetTimeStamp(nil, chatDisplay).." "..msg;
end


function TimeStamps:OnEnable()
    RegisterStringModifier(addTimeStamp);
end

function TimeStamps:OnDisable()
    UnregisterStringModifier(addTimeStamp);
end

function TimeStamps:OnWindowDestroyed(win)
    win.lastDate = nil;
end

-- Global
function GetTimeStamp(cTime, chatDisplay)
    local win = chatDisplay and chatDisplay.parentWindow or chatDisplay;
    cTime = cTime or (win and win.nextStamp) or time();
    local cDate = _G.date(L["_DateFormat"], cTime);
    local color = win and win.nextStampColor or db.displayColors.sysMsg;
    if(win and win.lastDate ~= cDate) then
        chatDisplay:AddMessage(" ");
        chatDisplay:AddMessage("["..cDate.."]", color.r, color.g, color.b);
    end
    local stamp = "|cff"..RGBPercentToHex(color.r, color.g, color.b)..date(db.timeStampFormat, cTime).."|r"; 
    if(win) then
        win.lastDate = cDate;
        win.nextChatDisplay = nil;
        win.nextStamp = nil;
        win.nextStampColor = nil;
    end
    return stamp;
end

function GetTimeStampFormats()
    return formats;
end
