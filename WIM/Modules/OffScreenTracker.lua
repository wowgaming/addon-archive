--imports
local WIM = WIM;
local _G = _G;
local pairs = pairs;
local table = table;


--set namespace
setfenv(1, WIM);

local blips = {
    available = {},
    used = {}
};

------------------------------------------
-- Module: OffScreenTracker (Experimental)
------------------------------------------

local function createBlip()
    local obj = _G.CreateFrame("Button");
    obj:SetFrameStrata("TOOLTIP");
    obj:SetClampedToScreen(true);
    obj:SetWidth(16);
    obj:SetHeight(16);
    obj:SetNormalTexture("Interface/WorldMap/WorldMapPlayerIcon");
    obj:Hide();
    obj:RegisterForClicks("LeftButtonUp", "RightButtonUp");
    obj:SetScript("OnClick", function(self)
        if(self.tracking) then
            local win = self.tracking;
            win:SetClampedToScreen(true);
            win:Hide();
            win:Show();
            win:SetClampedToScreen(false);
        end
    end);
    obj:SetScript("OnEnter", function(self)
        _G.GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
        _G.GameTooltip:AddLine(L["WIM Window Off Screen"]);
        _G.GameTooltip:AddLine("|cff69ccf0"..L["Click to reposition."].."|r");
        _G.GameTooltip:Show(txt);
    end);
    obj:SetScript("OnLeave", function(self)
        _G.GameTooltip:Hide();
    end);
    return obj;
end

local function getBlip()
    if(table.getn(blips.available) > 0) then
        local obj = blips.available[1];
        table.remove(blips.available, 1);
        table.insert(blips.used, obj);
        return obj;
    else
        local obj = createBlip();
        table.insert(blips.used, obj);
        return obj;
    end
end

local function releaseBlip(blip)
    -- release the blip for future use.
    blip:ClearAllPoints();
    blip:Hide();
    for i=1, #blips.used do
        if(blips.used[i] == blip) then
            table.insert(blips.available, blips.used[i]);
            table.remove(blips.used[i])
        end
    end
end


local Module = WIM.CreateModule("OffScreenTracker", true);

-- window exists the screen
function Module:OnWindowLeaveScreen(win, ...)
    local blip = getBlip();
    win.offScreenTracker = blip;
    blip.tracking = win;
    blip:SetParent(win);
    blip:SetPoint("CENTER", win);
    blip:Show();
end

-- window enters the screen
function Module:OnWindowEnterScreen(win, ...)
    local blip = win.offScreenTracker;
    if(blip) then
        win.offScreenTracker = nil;
        releaseBlip(blip);
    end
end

Module.canDisable = false;
Module:Enable();
