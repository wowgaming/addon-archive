--[[
    This file is part of Decursive.
    
    Decursive (v 2.5.1-6-gd3885c5) add-on for World of Warcraft UI
    Copyright (C) 2006-2007-2008-2009 John Wellesz (archarodim AT teaser.fr) ( http://www.2072productions.com/to/decursive.php )

    Starting from 2009-10-31 and until said otherwise by its author, Decursive
    is no longer free software, all rights are reserved to its author (John Wellesz).

    The only official and allowed distribution means are www.2072productions.com, www.wowace.com and curse.com.
    To distribute Decursive through other means a special authorization is required.
    

    Decursive is inspired from the original "Decursive v1.9.4" by Quu.
    The original "Decursive 1.9.4" is in public domain ( www.quutar.com )

    Decursive is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY.
    
--]]
-------------------------------------------------------------------------------

local addonName, T = ...;
-- big ugly scary fatal error message display function {{{
if not T._FatalError then
-- the beautiful error popup : {{{ -
StaticPopupDialogs["DECURSIVE_ERROR_FRAME"] = {
    text = "|cFFFF0000Decursive Error:|r\n%s",
    button1 = "OK",
    OnAccept = function()
        return false;
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    showAlert = 1,
    }; -- }}}
T._FatalError = function (TheError) StaticPopup_Show ("DECURSIVE_ERROR_FRAME", TheError); end
end
-- }}}
if not T._LoadedFiles or not T._LoadedFiles["DCR_init.lua"] then
    if not DecursiveInstallCorrupted then T._FatalError("Decursive installation is corrupted! (DCR_init.lua not loaded)"); end;
    DecursiveInstallCorrupted = true;
    return;
end

local DC = DcrC;
local D = Dcr;
local L = D.L;
local LC = D.LC;
local DC = DcrC;
local DS = DC.DS;


local icon    = LibStub("LibDBIcon-1.0");

local LibQTip = LibStub('LibQTip-1.0');


local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("Decursive", {
        type = "launcher",
        OnClick = function(Frame, button)
            D:QuickAccess(Frame, button);
        end,
        
        text = "Decursive",
        label = "Decursive",
        
        icon = DC.IconOFF,
});


local HeadFont;
local function CreateFonts()

    Dcr:Debug("create font called");

    -- Create the fonts objects we'll use in the tooltip:
    -- New font looking like GameTooltipText
    local HeadFont = CreateFont("DCR_QT_HeadFont")
    HeadFont:SetFont(GameTooltipText:GetFont(), 16)
    HeadFont:SetTextColor(0.8,0.8,0.3)

    --[=[

    -- New font looking like defaultFont
    local CommandFont = CreateFont("DCR_QT_CommandFont")
    CommandFont:CopyFontObject(defaultFont)
    CommandFont:SetTextColor(0,1,0)

    --]=]

    return HeadFont;


end


local function ShowToolTip (frame)
    if not D.DcrFullyInitialized then
        return;
    end

    --Dcr:Debug("ShowToolTip called");

    if not HeadFont then
        HeadFont = CreateFonts();
    end

    local tooltip = LibQTip:Acquire("DecursiveGenInfo", 2, "LEFT", "RIGHT");
    frame.tooltip = tooltip 

    tooltip:SetHeaderFont(HeadFont);
    
    local x, y;
    -- 1
    x, y = tooltip:AddLine();
    tooltip:SetCell(x,y,'Decursive', HeadFont,"CENTER",2);

    -- 2
    --tooltip:AddLine(    ("|cFF00FF00%s|r: "):format(D.L["HLP_RIGHTCLICK"]),
      --                      D.L["STR_OPTIONS"]);

    -- 3
    tooltip:AddLine(    ("|cFF00FF00%s-%s|r: "):format(D.L["ALT"],      D.L["HLP_RIGHTCLICK"]),
                            D.L["BINDING_NAME_DCRSHOWOPTION"]);

    -- 4
    tooltip:AddLine(    ("|cFF00FF00%s-%s|r: "):format(D.L["CTRL"],     D.L["HLP_LEFTCLICK"]),
                            D.L["BINDING_NAME_DCRPRSHOW"]);

    -- 5
    tooltip:AddLine(    ("|cFF00FF00%s-%s|r: "):format(D.L["SHIFT"],    D.L["HLP_LEFTCLICK"]),
                            D.L["BINDING_NAME_DCRSKSHOW"]);

    -- 6
    tooltip:AddLine(    ("|cFF00FF00%s-%s|r: " ):format(D.L["SHIFT"],   D.L["HLP_RIGHTCLICK"]),
                            D.L["BINDING_NAME_DCRSHOW"]);

    if (D.db.global.debugging) then
        tooltip:AddSeparator();

        x, y = tooltip:AddLine();
        tooltip:SetCell(x,y,'Debugging', HeadFont,"CENTER",2);

        tooltip:AddLine("Afflicted units count:", D.ForLLDebuffedUnitsNum);

        tooltip:AddLine("Afflicted units count in range:", D.MicroUnitF.UnitsDebuffedInRange);

        tooltip:AddLine("Max Concurrent update events:", D.Status.MaxConcurentUpdateDebuff);

        tooltip:AddSeparator();

        x, y = tooltip:AddLine();
        tooltip:SetCell(x,y,'Debuff seen history:', HeadFont,"CENTER",2);

        local HistoryIndex = 1;

        while HistoryIndex < 10 do
            tooltip:AddLine( "|cFFAAFFAA"..HistoryIndex.."|r", (D:Debuff_History_Get (HistoryIndex, true)));

            HistoryIndex = HistoryIndex + 1;

        end
    end

    -- Use smart anchoring code to anchor the tooltip to our frame
    tooltip:SmartAnchorTo(frame)

    -- Show it
    tooltip:Show()

end

LDB.OnEnter = function(frame) 
    ShowToolTip(frame);
end

LDB.OnLeave = function(frame)
    LibQTip:Release(frame.tooltip)
    frame.tooltip = nil

    --Dcr:Debug("Releasing tooltip");
end



function D:SetIcon (icon)
    LDB.icon = icon;
end

function D:SetMinimapIcon()
    if not icon:IsRegistered("Decursive") then
        icon:Register("Decursive", LDB, D.profile.MiniMapIcon);
    end
end

function D:HideMiniMapIcon()
    icon:Hide();
end

T._LoadedFiles["Dcr_LDB.lua"] = "2.5.1-6-gd3885c5";
