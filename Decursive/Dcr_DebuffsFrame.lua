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

if not T._LoadedFiles or not T._LoadedFiles["Dcr_lists.xml"] or not T._LoadedFiles["Dcr_lists.lua"] then -- XML are loaded even if LUA syntax errors exixts
    if not DecursiveInstallCorrupted then T._FatalError("Decursive installation is corrupted! (Dcr_lists.xml or Dcr_lists.lua not loaded)"); end;
    DecursiveInstallCorrupted = true;
    return;
end

local D   = T.Dcr;


local L     = D.L;
local LC    = D.LC;
local DC    = DcrC;
local DS    = DC.DS;


-- NS def
D.MicroUnitF = {};
-- create a shortcut
local MicroUnitF = D.MicroUnitF;
MicroUnitF.prototype = {};
MicroUnitF.metatable ={ __index = MicroUnitF.prototype };

function MicroUnitF:new(...)
    local instance = setmetatable({}, self.metatable);
    instance:init(...);
    return instance;
end



-- since there are tens of thousands of globals defined at all times, lets use some locals!
local BOOKTYPE_PET      = BOOKTYPE_PET;
local BOOKTYPE_SPELL    = BOOKTYPE_SPELL;

-- Init object factory defaults
--MicroUnitF.ExistingPerID          = {};
MicroUnitF.ExistingPerUNIT          = {};
MicroUnitF.ExistingPerNum           = {};
MicroUnitF.UnitToMUF                = {};
MicroUnitF.Number                   = 0;
MicroUnitF.UnitShown                = 0;
MicroUnitF.UnitsDebuffedInRange     = 0;
MicroUnitF.DraggingHandle           = false;
D.ForLLDebuffedUnitsNum             = 0;


-- using power 2 values just to OR them but only CHARMED_STATUS is ORed (it's a C style bitfield)
local NORMAL                = DC.NORMAL;
local ABSENT                = DC.ABSENT;
local FAR                   = DC.FAR;
local STEALTHED             = DC.STEALTHED;
local BLACKLISTED           = DC.BLACKLISTED;
local AFFLICTED             = DC.AFFLICTED;
local AFFLICTED_NIR         = DC.AFFLICTED_NIR;
local CHARMED_STATUS        = DC.CHARMED_STATUS;
local AFFLICTED_AND_CHARMED = DC.AFFLICTED_AND_CHARMED;


-- Those are the different colors used for the MUFs main texture
local MF_colors = { };

local unpack            = _G.unpack;
local select            = _G.select;
local pairs             = _G.pairs;
local ipairs            = _G.ipairs;
local GetTime           = _G.GetTime;
local PlaySoundFile     = _G.PlaySoundFile;
local IsControlKeyDown  = _G.IsControlKeyDown;
local floor             = _G.math.floor;
local table             = _G.table;
local t_insert          = _G.table.insert;
local str_format        = _G.string.format;
local str_sub           = _G.string.gsub;
local table             = _G.table;
local string            = _G.string;
local UnitExists        = _G.UnitExists;
local UnitClass         = _G.UnitClass;
local fmod              = _G.math.fmod;
local UnitIsUnit        = _G.UnitIsUnit;
local str_upper         = _G.string.upper;
local InCombatLockdown  = _G.InCombatLockdown;
local UnitAura          = _G.UnitAura;
local GetRaidTargetIndex= _G.GetRaidTargetIndex;


DC.AvailableButtonsReadable = { -- {{{
    ["%s1"]         =   L["HLP_LEFTCLICK"], -- left mouse button
    ["%s2"]         =   L["HLP_RIGHTCLICK"], -- right mouse button
    ["%s3"]         =   L["HLP_MIDDLECLICK"], -- middle mouse button
    ["ctrl-%s1"]    =   L["CTRL"]  .. "-" .. L["HLP_LEFTCLICK"],
    ["ctrl-%s2"]    =   L["CTRL"]  .. "-" .. L["HLP_RIGHTCLICK"],
    ["ctrl-%s3"]    =   L["CTRL"]  .. "-" .. L["HLP_MIDDLECLICK"],
    ["shift-%s1"]   =   L["SHIFT"] .. "-" .. L["HLP_LEFTCLICK"],
    ["shift-%s2"]   =   L["SHIFT"] .. "-" .. L["HLP_RIGHTCLICK"],
    ["shift-%s3"]   =   L["SHIFT"] .. "-" .. L["HLP_MIDDLECLICK"],
    ["alt-%s1"]     =   L["ALT"]   .. "-" .. L["HLP_LEFTCLICK"],
    ["alt-%s2"]     =   L["ALT"]   .. "-" .. L["HLP_RIGHTCLICK"],
    ["alt-%s3"]     =   L["ALT"]   .. "-" .. L["HLP_MIDDLECLICK"],
    -- 3, -- middle mouse button || RESERVED FOR TARGETTING
}; -- }}}

-- modifier for the macro
local AvailableModifier = { -- {{{
    "shift","ctrl","alt",
} -- }}}

-- MicroUnitF STATIC methods {{{

-- Updates the color table
function MicroUnitF:RegisterMUFcolors ()
   -- MF_colors = D.profile.MF_colors; -- this should be enough but is not because D.profile can change at unexpected times....
    D:tcopy(MF_colors, D.profile.MF_colors);
end

-- defines what is printed when the object is read as a string
function MicroUnitF:ToString() -- {{{
    return "Decursive Micro Unit Frame Object";
end -- }}}

-- The Factory for MicroUnitF objects
function MicroUnitF:Create(Unit, ID) -- {{{

    if InCombatLockdown() then
        -- if we are fighting, postpone the call
        D:AddDelayedFunctionCall (
        "Create"..Unit, self.Create,
        Unit, ID);
        return false;
    end

    -- if we attempt to create a MUF that already exists, update it instead
    if (self.ExistingPerUNIT[Unit]) then
        return self.ExistingPerUNIT[Unit];
    end

    self.Number = self.Number + 1;

    -- create a new MUF object
    self.ExistingPerUNIT[Unit] = self:new(D.MFContainer, Unit, self.Number, ID);

    self.ExistingPerNum[self.Number] = self.ExistingPerUNIT[Unit];

    return self.ExistingPerUNIT[Unit];
end -- }}}

-- return a MUF object if it exists, nil otherwise
--[=[
function MicroUnitF:Exists(IdOrNum) -- {{{
    return self.ExistingPerID[IdOrNum] or self.ExistingPerNum[IdOrNum];
end
--]=]
-- }}}

-- return the number MUFs we can use
function MicroUnitF:MFUsableNumber () -- {{{
    return ((self.MaxUnit > D.Status.UnitNum) and D.Status.UnitNum or self.MaxUnit);
end -- }}}

-- this is used when a setting influencing MUF's position is changed
function MicroUnitF:ResetAllPositions () -- {{{

    if InCombatLockdown() then
        D:AddDelayedFunctionCall (
        "ResetAllPositions", self.ResetAllPositions,
        self);
        return false;
    end

    local MF, i;

    D:Debug("Resetting all MF position");

    self:Delayed_MFsDisplay_Update ();

    local Unit_Array = D.Status.Unit_Array;

    for i=1, #Unit_Array do
        MF = self.ExistingPerUNIT[ Unit_Array[i] ]

        if MF then
            MF.Frame:SetPoint(unpack(self:GiveMFAnchor(i)));
        end
    end
end -- }}}

-- return the anchor of a given MUF depending on its creation ID
do
local Anchor = { "TOPLEFT", x, y, "TOPLEFT" };
function MicroUnitF:GiveMFAnchor (ID) -- {{{
    local LineNum = floor( (ID - 1) / D.profile.DebuffsFramePerline);
    local NumOnLine = fmod( (ID - 1), D.profile.DebuffsFramePerline);

    local x = (D.profile.DebuffsFrameGrowToTop and DC.MFSIZE or 0) + NumOnLine * (DC.MFSIZE + D.profile.DebuffsFrameXSpacing);
    local y = (D.profile.DebuffsFrameGrowToTop and -1 or 1) * LineNum * ((-1 * D.profile.DebuffsFrameYSpacing) - DC.MFSIZE);

    Anchor[2] = x; Anchor[3] = y;

    return Anchor;
end
end-- }}}


function MicroUnitF:Delayed_MFsDisplay_Update ()
    if D.profile.ShowDebuffsFrame then
        D:ScheduleDelayedCall("Dcr_UpdateMUFsNUM", self.MFsDisplay_Update, 1.5, self);
    end
end

-- This update the MUFs display, show and hide MUFs as necessary
function MicroUnitF:MFsDisplay_Update () -- {{{

    if (not D.profile.ShowDebuffsFrame) then
        return false; -- XXX we will have to call this function again when we show the MUFs
    end

    -- This function cannot do anything if we are fighting
    if InCombatLockdown() then
        -- if we are fighting, postpone the call
        D:AddDelayedFunctionCall (
        "UpdateMicroUnitFrameDisplay", self.MFsDisplay_Update,
        self);
        return false;
    end

    -- Get an up to date unit array if necessary
    D:GetUnitArray(); -- this is the only place where GetUnitArray() is called directly

    -- =======
    --  Begin
    -- =======
   
    -- get the number of MUFs we should display
    local NumToShow = self:MFUsableNumber();


    -- if we don't have all the MUFs needed then return, we are not ready
    if (self.Number < NumToShow) then
        self:Delayed_MFsDisplay_Update ();
        return false;
    end


    local MF = false;
    local i = 1;
    local Old_UnitShown = self.UnitShown;


    D:Debug("Update required: NumToShow = ", NumToShow);

    local Unit_Array_UnitToGUID = D.Status.Unit_Array_UnitToGUID;
    local Unit_Array            = D.Status.Unit_Array;


    -- Scan unit array in display order and show the maximum until NumToShow is reached
    -- The ID is set for all MUFs present in our unit array
    local Updated = 0;
    for i, Unit in ipairs(Unit_Array) do

        MF = self.ExistingPerUNIT[Unit];
        if MF then
            MF.ID = i;

            if not MF.Shown and i <= NumToShow then -- we got this unit in our group but it's hidden

                MF.Shown = true;
                self.UnitShown = self.UnitShown + 1;
                MF.ToPlace = true;
                Updated = Updated + 1;

                D:ScheduleDelayedCall("Dcr_Update"..MF.CurrUnit, MF.UpdateWithCS, D.profile.DebuffsFrameRefreshRate * Updated, MF);
                --D:Debug("|cFF88AA00Show schedule for MUF", Unit, "UnitShown:", self.UnitShown);
            end
        else
            --D:errln("showhide: no muf for", Unit); -- call delay display up 
            self:Delayed_MFsDisplay_Update ();
        end

    end

    -- hide remaining units
    if self.UnitShown > NumToShow then

        for Unit, MF in  pairs(self.ExistingPerUNIT) do -- see all the MUF we ever created and show or hide them if there corresponding unit exists

            -- show/hide
            if MF.Shown and (not Unit_Array_UnitToGUID[Unit] or MF.ID > NumToShow ) then -- we don't have this unit but its MUF is shown

                -- clear debuff before hiding to avoid leaving 'ghosts' behind...
                if D.UnitDebuffed[MF.CurrUnit] then
                    D.ForLLDebuffedUnitsNum = D.ForLLDebuffedUnitsNum - 1;
                end

                MF.Debuffs                      = false;
                MF.IsDebuffed                   = false;
                MF.Debuff1Prio                  = false;
                MF.PrevDebuff1Prio              = false;
                D.UnitDebuffed[MF.CurrUnit]     = false; -- used by the live-list only
                D.Stealthed_Units[MF.CurrUnit]  = false;


                MF.Shown = false;
                self.UnitShown = self.UnitShown - 1;
                --D:Debug("|cFF88AA00Hiding %d (%s), scheduling update in %f|r", i, MF.CurrUnit, D.profile.DebuffsFrameRefreshRate * i);
                Updated = Updated + 1;
                D:ScheduleDelayedCall("Dcr_Update"..MF.CurrUnit, MF.Update, D.profile.DebuffsFrameRefreshRate * Updated, MF);
                MF.Frame:Hide();
            end

        end
    end

    -- manage to get what we show in the screen
    if self.UnitShown > 0 and Old_UnitShown ~= self.UnitShown then
        MicroUnitF:Place();
    end

    return true;
end -- }}}


function MicroUnitF:Delayed_Force_FullUpdate ()
    if (D.profile.ShowDebuffsFrame) then
        D:ScheduleDelayedCall("Dcr_Force_FullUpdate", self.Force_FullUpdate, 0.3, self);
    end
end

function MicroUnitF:Force_FullUpdate () -- {{{
    if (not D.profile.ShowDebuffsFrame) then
        return false;
    end

    -- This function cannot do anything if we are fighting
    if InCombatLockdown() then
        -- if we are fighting, postpone the call
        D:AddDelayedFunctionCall (
        "Force_FullUpdate", self.Force_FullUpdate,
        self);
        return false;
    end

    local MF;--, MF_f;

    D.Status.SpellsChanged = GetTime(); -- will force an update of all MUFs attributes

    local i = 1;
    for Unit, MF in  pairs(self.ExistingPerUNIT) do

        if not MF.IsDebuffed then
            MF.UnitStatus = 0; -- reset status to force SetColor to update
        end

        MF.ChronoFontString:SetTextColor(unpack(MF_colors["COLORCHRONOS"]));

        D:ScheduleDelayedCall("Dcr_Update"..MF.CurrUnit, MF.UpdateWithCS, D.profile.DebuffsFrameRefreshRate * i, MF);
        i = i + 1;
    end
end -- }}}


-- Those set the scalling of the MUF container
-- SACALING FUNCTIONS (MicroUnitF Children) {{{
-- Place the MUFs container according to its scale
function MicroUnitF:Place () -- {{{

    if self.UnitShown == 0 or self.DraggingHandle then return end

    if InCombatLockdown() then
        -- if we are fighting, postpone the call
        D:AddDelayedFunctionCall (
        "MicroUnitFPlace", self.Place,
        self);
        return;
    end


    local UIScale       = UIParent:GetEffectiveScale()
    local FrameScale    = self.Frame:GetEffectiveScale();
    local x, y = D.profile.DebuffsFrame_x, D.profile.DebuffsFrame_y;

    -- If executed for the very first time, then put it in the top right corner of the screen
    if (not x or not y) then
        x =    (UIParent:GetWidth() * UIScale) - (UIParent:GetWidth() * UIScale) / 4;
        y =  - (UIParent:GetHeight() * UIScale) / 5;

        D.profile.DebuffsFrame_x = x;
        D.profile.DebuffsFrame_y = y;
    end


    local FirstLineNum    = 0;
    local Handle_x_offset = 0;
    local Handle_y_offset = 0;

    -- get the number of max unit per line
    if self.UnitShown >= D.profile.DebuffsFramePerline then FirstLineNum = D.profile.DebuffsFramePerline; else FirstLineNum = self.UnitShown; end

    -- get the offset of the handle we need to apply in order to align the MUFs on the right
    if D.profile.DebuffsFrameStickToRight then
        Handle_x_offset = -1 * FrameScale * (FirstLineNum * (DC.MFSIZE + D.profile.DebuffsFrameXSpacing) - D.profile.DebuffsFrameXSpacing );
    end

    Handle_x_offset = Handle_x_offset - FrameScale * (D.profile.DebuffsFrameGrowToTop and DC.MFSIZE or 0);
    Handle_y_offset = Handle_y_offset + FrameScale * (D.profile.DebuffsFrameGrowToTop and DC.MFSIZE or 0);

    -- check the right edge so it can't be out of the screen
    local RightEdge = x + FrameScale * (FirstLineNum * (DC.MFSIZE + D.profile.DebuffsFrameXSpacing) - D.profile.DebuffsFrameXSpacing + (D.profile.DebuffsFrameGrowToTop and DC.MFSIZE or 0)) + Handle_x_offset ;

    if (RightEdge > UIParent:GetWidth() * UIScale) then
        Handle_x_offset = Handle_x_offset - (RightEdge - UIParent:GetWidth() * UIScale);
        D:Debug("put the MUFs on the screen!!! (Right edge out)");
    end

    -- check the left edge so it can't be out of the screen
    local LeftEdge = x + Handle_x_offset;
    if (LeftEdge < 0) then
        Handle_x_offset = Handle_x_offset - LeftEdge;
        D:Debug("put the MUFs on the screen!!! (Left edge out)");
    end

    -- check the bottom edge
    local NumberOfLines = floor( (self.UnitShown - 1) / D.profile.DebuffsFramePerline) + 1;
    --D:Debug(NumberOfLines);
    
    local BottomEdge = y - FrameScale * ((D.profile.DebuffsFrameGrowToTop and 1 or NumberOfLines) * (DC.MFSIZE + D.profile.DebuffsFrameYSpacing) - D.profile.DebuffsFrameYSpacing) + Handle_y_offset;
    
    if -BottomEdge > UIParent:GetHeight() * UIScale then
        Handle_y_offset = Handle_y_offset - (BottomEdge + UIParent:GetHeight() * UIScale);
        D:Debug("put the MUFs on the screen!!! (Bottom edge out)");
    end

    -- check the top edge
    local TopEdge = y + FrameScale * (((D.profile.DebuffsFrameGrowToTop and NumberOfLines > 1) and NumberOfLines - 1 or 1) * (DC.MFSIZE + D.profile.DebuffsFrameYSpacing) - ((not D.profile.DebuffsFrameGrowToTop) and 1 or 0) * D.profile.DebuffsFrameYSpacing) + Handle_y_offset;
     if (TopEdge > 0) then
        Handle_y_offset = Handle_y_offset - TopEdge;
        D:Debug("put the MUFs on the screen!!! (Top edge out)");
    end

    x = x + Handle_x_offset;
    y = y + Handle_y_offset;

   

    -- set to the scaled position
    self.Frame:ClearAllPoints();
    self.Frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x/FrameScale , y/FrameScale);
    D:Debug("MUF Window position set");
end -- }}}

-- Save the position of the frame without its scale
function MicroUnitF:SavePos () -- {{{

    if self.UnitShown == 0 then return end

    local FirstLineNum;

    if self.Frame:IsVisible() then
        -- We save the unscalled position (no problem if the sacale is changed behind our back)
        D.profile.DebuffsFrame_x = self.Frame:GetEffectiveScale() * self.Frame:GetLeft();
        D.profile.DebuffsFrame_y = self.Frame:GetEffectiveScale() * self.Frame:GetTop() - UIParent:GetHeight() * UIParent:GetEffectiveScale();


        -- if we choosed to align the MUF to the right then we have to add the
        -- width of the first line to get the original position of the handle
        
        if D.profile.DebuffsFrameStickToRight then

            if self.UnitShown >= D.profile.DebuffsFramePerline then
                FirstLineNum = D.profile.DebuffsFramePerline;
            else
                FirstLineNum = self.UnitShown;
            end

            D.profile.DebuffsFrame_x = D.profile.DebuffsFrame_x + self.Frame:GetEffectiveScale() * (FirstLineNum * (DC.MFSIZE + D.profile.DebuffsFrameXSpacing) - D.profile.DebuffsFrameXSpacing);
        end
        
        D.profile.DebuffsFrame_x = D.profile.DebuffsFrame_x + self.Frame:GetEffectiveScale() * (D.profile.DebuffsFrameGrowToTop and DC.MFSIZE or 0);
        D.profile.DebuffsFrame_y = D.profile.DebuffsFrame_y - self.Frame:GetEffectiveScale() * (D.profile.DebuffsFrameGrowToTop and DC.MFSIZE or 0);

        --      D:Debug("Frame position saved");
    end

end -- }}}

-- set the scaling of the MUFs container according to the user settings
function MicroUnitF:SetScale (NewScale) -- {{{
    
    -- save the current position without any scaling
--    self:SavePos ();
    -- Setting the new scale
    self.Frame:SetScale(NewScale);
    -- Place the frame adapting its position to the news cale
    self:Place ();
    
end -- }}}
-- }}}

-- Update the MUF of a given unitid
function MicroUnitF:UpdateMUFUnit(Unitid, CheckStealth)
    if not D.profile.ShowDebuffsFrame then
        return;
    end

    local unit = false;

    if (D.Status.Unit_Array_UnitToGUID[Unitid]) then
        unit = Unitid;
    else
        D:Debug("Unit", Unitid, "not in raid or party!" );
        return;
    end

    -- get the MUF object
    local MF = self.UnitToMUF[unit];

    if (MF and MF.Shown) then
        -- The MUF will be updated only every DebuffsFrameRefreshRate seconds at most
        -- but we don't miss any event XXX note this can be the cause of slowdown if 25 or 40 players got debuffed at the same instant, DebuffUpdateRequest is here to prevent that since 2008-02-17
        if (not D:DelayedCallExixts("Dcr_Update"..unit)) then
            D.DebuffUpdateRequest = D.DebuffUpdateRequest + 1;
            D:ScheduleDelayedCall("Dcr_Update"..unit, CheckStealth and MF.UpdateWithCS or MF.Update, D.profile.DebuffsFrameRefreshRate * (1 + floor(D.DebuffUpdateRequest / (D.profile.DebuffsFramePerUPdate / 2))), MF);
            D:Debug("Update scheduled for, ", unit, MF.ID);

            return true; -- return value used to aknowledge that the function actually did something
        end
    else
        D:Debug("No MUF found for ", unit, Unitid);
    end
end

-- Event management functions
-- MUF EVENTS (MicroUnitF children) (OnEnter, OnLeave, OnLoad, OnPreClick) {{{
-- It's outside the function to avoid creating and discarding this table at each call
local DefaultTTAnchor = {"ANCHOR_TOPLEFT", 0, 6};
local UnitGUID = _G.UnitGUID;
local TooltipButtonsInfo = {}; -- help tooltip text table
local TooltipUpdate = 0; -- help tooltip change update check
-- This function is responsible for showing the tooltip when the mouse pointer is over a MUF
-- it also handles Unstable Affliction detection and warning.
function MicroUnitF:OnEnter(frame) -- {{{
    D.Status.MouseOveringMUF = true;

    local MF = frame.Object;
    local Status;

    local Unit = MF.CurrUnit; -- shortcut
    local TooltipText = "";


    local GUIDwasFixed = false;
    local unitguid = UnitGUID(Unit);

    if unitguid ~= D.Status.Unit_Array_UnitToGUID[Unit] or Unit ~= D.Status.Unit_Array_GUIDToUnit[unitguid] then

        if unitguid then
            D.Status.Unit_Array_UnitToGUID[Unit] = unitguid;
            D.Status.Unit_Array_GUIDToUnit[unitguid] = Unit;
            GUIDwasFixed = true;
        end

    end

    MF:Update(false, false, true); -- will reset the color early and set the current status of the MUF
    MF:SetClassBorder(); -- set the border if it wasn't possible at the time the unit was discovered
    
    if not Unit then
        return; -- If the user overs the MUF befor it's completely initialized
    end

    --Test for unstable affliction
    if MF.Debuffs then
        for i, Debuff in ipairs(MF.Debuffs) do
            if Debuff.Type then
                -- Create a warning if the Unstable Affliction is detected
                if Debuff.Name == DS["Unstable Affliction"] then
                    --if Debuff.Name == "Malédiction de Stalvan" then -- to test easily
                    D:Println("|cFFFF0000 ==> %s !!|r (%s)", DS["Unstable Affliction"], D:MakePlayerName((D:PetUnitName(      Unit, true    ))));
                    PlaySoundFile("Sound\\Doodad\\G_NecropolisWound.wav");
                end
            end
        end
    end

    if D.profile.AfflictionTooltips then

        -- removes the CHARMED_STATUS bit from Status, we don't need it
        Status = bit.band(MF.UnitStatus,  bit.bnot(CHARMED_STATUS));

        -- First, write the name of the unit in its class color
        if UnitExists(MF.CurrUnit) then
            TooltipText =
            ((DC.RAID_ICON_LIST[GetRaidTargetIndex(Unit)]) and (DC.RAID_ICON_LIST[GetRaidTargetIndex(Unit)] .. "0:0:0:0|t ") or ""  ) ..
            -- Colored unit name
            D:ColorText(            (D:PetUnitName(       Unit, true    ))
            , "FF" .. ((UnitClass(Unit)) and DC.HexClassColor[ (select(2, UnitClass(Unit))) ] or "AAAAAA")) .. "  |cFF3F3F3F(".. Unit .. ")|r";
        else
            TooltipText = MF.CurrUnit;
        end


        -- set UnitStatus text
        local StatusText = "";

        -- set the status text, just translate the bitfield to readable text
        if Status == NORMAL then
            StatusText = L["NORMAL"];

        elseif Status == ABSENT then
            StatusText = str_format(L["ABSENT"], Unit);

        elseif Status == FAR then
            StatusText = L["TOOFAR"];

        elseif Status == STEALTHED then
            StatusText = L["STEALTHED"];

        elseif Status == BLACKLISTED then
            StatusText = L["BLACKLISTED"];

        elseif MF.Debuffs and (Status == AFFLICTED or Status == AFFLICTED_NIR) then
            local DebuffType = MF.Debuffs[1].Type;
            StatusText = str_format(L["AFFLICTEDBY"], D:ColorText( L[str_upper(DC.TypeNames[DebuffType])], "FF" .. DC.TypeColors[DebuffType]) );
        end

        -- Unit Status
        --TooltipText = TooltipText .. "\n" .. L["UNITSTATUS"] .. StatusText .. "\n";
        TooltipText = TooltipText .. "\n" .. StatusText;

        -- list the debuff(s) names
        if MF.Debuffs then
            for i, Debuff in ipairs(MF.Debuffs) do
                if Debuff.Type then
                    local DebuffApps = Debuff.Applications;
                    TooltipText = TooltipText .. "\n" .. str_format("%s", D:ColorText(Debuff.Name, "FF" .. DC.TypeColors[Debuff.Type])) .. (DebuffApps>0 and str_format(" (%d)", DebuffApps) or "");
                end
            end
        end

        local VerticalMUF    = floor((self.UnitShown - 1) / D.profile.DebuffsFramePerline ) * D.profile.DebuffsFramePerline + 1;

        -- The tooltip is anchored above the top first MUF
        if not D.profile.DebuffsFrameGrowToTop then
            local FirstMUFAnchor = self:GiveMFAnchor(1);
            DefaultTTAnchor[2] = FirstMUFAnchor[2];
            DefaultTTAnchor[3] = FirstMUFAnchor[3];
        else
            local TopMUFAnchor   = self:GiveMFAnchor(VerticalMUF);
            DefaultTTAnchor[2] = TopMUFAnchor[2];
            DefaultTTAnchor[3] = TopMUFAnchor[3];
        end

        -- Display the tooltip
        D:DisplayTooltip( TooltipText , self.Frame, DefaultTTAnchor);

        -- if the tooltip is at the top of the screen it means it's overlaping the MUF, let's move the tooltip somewhere else.
        if floor(DcrDisplay_Tooltip:GetTop()) == floor(UIParent:GetTop()) then
            local RefMUF = 1;

            if not D.profile.DebuffsFrameGrowToTop then
               RefMUF = VerticalMUF;
            end

            DcrDisplay_Tooltip:ClearAllPoints();
            DcrDisplay_Tooltip:SetPoint("TOPLEFT", self.ExistingPerNum[RefMUF].Frame, "BOTTOMLEFT");
        end
    end

    -- show a help text in the Game default tooltip
    if D.profile.DebuffsFrameShowHelp then
        -- if necessary we will update the help tooltip text
        if (D.Status.SpellsChanged ~= TooltipUpdate) then
            TooltipButtonsInfo = {};
            local AvailableButtons = D.db.global.AvailableButtons;

            for Spell, Prio in pairs(D.Status.CuringSpellsPrio) do
                TooltipButtonsInfo[Prio] =
                str_format("%s: %s", D:ColorText(DC.AvailableButtonsReadable[AvailableButtons[Prio]], D:NumToHexColor(MF_colors[Prio])), Spell);
            end

            t_insert(TooltipButtonsInfo, str_format("%s: %s", DC.AvailableButtonsReadable[AvailableButtons[#AvailableButtons - 1]], L["TARGETUNIT"]));
            t_insert(TooltipButtonsInfo, str_format("%s: %s", DC.AvailableButtonsReadable[AvailableButtons[#AvailableButtons    ]], L["FOCUSUNIT"]));
            TooltipButtonsInfo = table.concat(TooltipButtonsInfo, "\n");
            TooltipUpdate = D.Status.SpellsChanged;
        end

        GameTooltip_SetDefaultAnchor(GameTooltip, frame);
        GameTooltip:SetText(TooltipButtonsInfo);
        GameTooltip:Show();

    end

end -- }}}

-- No longer used
--[===[
function MicroUnitF:LateAnalysis(From, Debuffs, MF, Status, GUIDwasFixed)

    local Unit = MF.CurrUnit; -- shortcut
    local unitguid = UnitGUID(Unit);
    local RegisteredUnitguid = MF.UnitGUID;
    -- search for detection by combat event manager
    local foundcblevents = {}; local highestever = 0; local _; local i=1; local dname; local DebuffApplyTime = false;
    local debuffname = Debuffs and Debuffs[1].Name or "No debuff, charmed?";

    -- find the debuff on the unit and find out when it was applyed
    while 1 do
        dname = UnitAura(Unit, i, "HARMFUL");

        if not dname then break end;

        if dname == debuffname then
            local Dduration, DexpireTime;
            dname, _, _, _, _, Dduration, DexpireTime = UnitAura(Unit, i, "HARMFUL");
            DebuffApplyTime = DexpireTime - Dduration;
            break;
        end
        i = i + 1;
    end


    if not DebuffApplyTime or DebuffApplyTime == 0 then
        D:AddDebugText("DebuffApplyTime could not be found for ", dname, "on", Unit, "DebuffApplyTime set to now - 3s");
        DebuffApplyTime = GetTime() - 3;
    end

    local DetectHistoryIndex = 1;
    local halfrange = 5; local RangeMatch = false; local latestever = "none"; local latesttime = 0;
    local tconcat = _G.table.concat
    D:Debug("Looking for events on", Unit, "between", DebuffApplyTime - halfrange, "and", DebuffApplyTime + halfrange);
    -- look in the history of the combat log event handler
    while D.DetectHistory[DetectHistoryIndex] do
        -- take all the events related to this unit or debuffname around the time the missed debuff was applyed
        if D.DetectHistory[DetectHistoryIndex][8] == unitguid or D.DetectHistory[DetectHistoryIndex][12] == debuffname then

            if D.DetectHistory[DetectHistoryIndex][1] > DebuffApplyTime - halfrange and D.DetectHistory[DetectHistoryIndex][1] < DebuffApplyTime + halfrange then
                t_insert(foundcblevents, tconcat(D.DetectHistory[DetectHistoryIndex],", "));
                t_insert(foundcblevents, "\n");
                RangeMatch = true;
            elseif D.DetectHistory[DetectHistoryIndex][1] > latesttime then-- find the latest event concerning this unit
                latesttime = D.DetectHistory[DetectHistoryIndex][1];
                latestever = DetectHistoryIndex;
            end

        end

        DetectHistoryIndex = DetectHistoryIndex + 1;
    end

    if latestever ~= "none" then
        latestever = tconcat(D.DetectHistory[latestever],", ");
    end

    D:AddDebugText("Debuff late detection:", From, debuffname, "Type:", Debuffs[1].TypeName, "on unit:", Unit, unitguid, "_AppT_:", DebuffApplyTime, "DFRR:", D.profile.DebuffsFrameRefreshRate, "Status:", Status, "DT:", GetTime(), "LGU:", D.Status.GroupUpdatedOn, "LGuEr", D.Status.GroupUpdateEvent, "JFGUID:", GUIDwasFixed, "DbUreq:", D.DebuffUpdateRequest, "MFGuid~:", RegisteredUnitguid ~= unitguid, "Z:", GetZoneText(), "DTI:", DetectHistoryIndex);

    -- trigger a dcr diag if DetectHistoryIndex is 1 :/
    if DetectHistoryIndex == 1 then
        T._SelfDiagnostic(true, true);
    end

    if #foundcblevents == 0 then
        D:AddDebugText("No event in range at all for ", Unit, "or debuff:", debuffname, "latest found:", latestever);
    else
        D:AddDebugText(#foundcblevents / 2, "events for ", Unit, "or debuff:", debuffname, "Status:", Status, "Events:\n", unpack(foundcblevents));
    end
end
--]===]

function MicroUnitF:OnLeave() -- {{{
    D.Status.MouseOveringMUF = false;
    --D:Debug("Micro unit Hidden");
    DcrDisplay_Tooltip:Hide();

    if (D.profile.DebuffsFrameShowHelp) then
        GameTooltip:Hide();
    end
end -- }}}


function D.MicroUnitF:OnCornerEnter(frame)
    if (D.profile.DebuffsFrameShowHelp) then
        D:DisplayGameTooltip(frame,
        str_format(
        "|cFF11FF11%s|r-|cFF11FF11%s|r: %s\n\n"..
        --"|cFF11FF11%s|r: %s\n"..
        "|cFF11FF11%s|r-|cFF11FF11%s|r: %s\n\n"..
        "|cFF11FF11%s|r-|cFF11FF11%s|r: %s\n"..
        "|cFF11FF11%s|r-|cFF11FF11%s|r: %s\n\n"..
        "|cFF11FF11%s|r-|cFF11FF11%s|r: %s",

        D.L["ALT"],             D.L["HLP_LEFTCLICK"],   D.L["HANDLEHELP"],

        --D.L["HLP_RIGHTCLICK"],  D.L["STR_OPTIONS"],
        D.L["ALT"],             D.L["HLP_RIGHTCLICK"],  D.L["BINDING_NAME_DCRSHOWOPTION"],

        D.L["CTRL"],            D.L["HLP_LEFTCLICK"],   D.L["BINDING_NAME_DCRPRSHOW"], 
        D.L["SHIFT"],           D.L["HLP_LEFTCLICK"],   D.L["BINDING_NAME_DCRSKSHOW"],

        D.L["SHIFT"],           D.L["HLP_RIGHTCLICK"],  D.L["BINDING_NAME_DCRSHOW"]
        ));
    end;
end


function MicroUnitF:OnLoad(frame) -- {{{
    frame:SetScript("PreClick", self.OnPreClick);
    frame:SetScript("PostClick", self.OnPostClick);
end
-- }}}

function MicroUnitF.OnPreClick(frame, Button) -- {{{
        D:Debug("Micro unit Preclicked: ", Button);

        local Unit = frame.Object.CurrUnit; -- shortcut

        if (frame.Object.UnitStatus == NORMAL and (Button == "LeftButton" or Button == "RightButton")) then

            D:Println(L["HLP_NOTHINGTOCURE"]);

        elseif (frame.Object.UnitStatus == AFFLICTED) then
            local NeededPrio = D:GiveSpellPrioNum(frame.Object.Debuffs[1].Type);
            local RequestedPrio = false;
            local ButtonsString = "";

            if IsControlKeyDown() then
                ButtonsString = "ctrl-";
            elseif IsAltKeyDown() then
                ButtonsString = "alt-";
            elseif IsShiftKeyDown() then
                ButtonsString = "shift-";
            end

            if Button == "LeftButton" then
               ButtonsString = ButtonsString .. "%s1";
            elseif Button == "RightButton" then
               ButtonsString = ButtonsString .. "%s2";
            end

            RequestedPrio = D:tGiveValueIndex(D.db.global.AvailableButtons, ButtonsString);

            if RequestedPrio and NeededPrio ~= RequestedPrio then
                D:errln(L["HLP_WRONGMBUTTON"]);
                if NeededPrio and MF_colors[NeededPrio] then
                    D:Println(L["HLP_USEXBUTTONTOCURE"], D:ColorText(DC.AvailableButtonsReadable[ D.db.global.AvailableButtons[NeededPrio] ], D:NumToHexColor(MF_colors[NeededPrio])));
                --[===[@debug@
                else
                    D:AddDebugText("Button wrong click info bug: NeededPrio:", NeededPrio, "Unit:", Unit, "RequestedPrio:", RequestedPrio, "Button clicked:", Button, "MF_colors:", unpack(MF_colors), "Debuff Type:", frame.Object.Debuffs[1].Type);
                --@end-debug@]===]
                end


            elseif RequestedPrio and D.Status.HasSpell then
--              D:Print("XXX ClickedMF SET");
                D.Status.ClickedMF = frame.Object; -- used to update the MUF on cast success and failure to know which unit is being cured
                D.Status.ClickedMF.SPELL_CAST_SUCCESS = false;
                D:Debuff_History_Add(frame.Object.Debuffs[1].Name, frame.Object.Debuffs[1].TypeName);
            end
        end
end -- }}}

-- }}}

-- }}}



-- MicroUnitF NON STATIC METHODS {{{
-- init a new micro frame (Call internally by :new() only)
function MicroUnitF.prototype:init(Container, Unit, FrameNum, ID) -- {{{

        D:Debug("Initializing MicroUnit object", Unit, "with FrameNum=", FrameNum, " and ID", ID);


        -- set object default variables
        self.Parent             = Container;
        self.ID                 = ID; -- is set by te roaming updater
        self.FrameNum           = FrameNum;
        self.ToPlace            = true;
        self.Debuffs            = false;
        self.Debuff1Prio        = false;
        self.PrevDebuff1Prio    = false;
        self.IsDebuffed         = false;
        self.CurrUnit           = false;
        self.UnitName           = false;
        self.UnitGUID           = false;
        self.UnitClass          = false;
        self.UnitStatus         = 0;
        self.FirstDebuffType    = 0;
        self.NormalAlpha        = false;
        self.BorderAlpha        = false;
        self.Color              = {};
        self.IsCharmed          = false;
        self.UpdateCountDown    = 3;
        self.LastAttribUpdate   = 0;
        self.LitTime            = false;
        self.Chrono             = false;
        self.PrevChrono         = false;
        self.Shown              = false; -- Setting this to true will broke the stick to right option
        self.UpdateCD           = 0;
        self.RaidTargetIcon     = false;
        self.PrevRaidTargetIndex= false;

        -- create the frame
        self.Frame  = CreateFrame ("Button", "DcrMicroUnit"..Unit, self.Parent, "DcrMicroUnitTemplateSecure");
        self.CooldownFrame = CreateFrame ("Cooldown", "DcrMicroUnitCD"..Unit, self.Frame, "DcrMicroUnitCDTemplate");

        -- outer texture (the class border)
        -- Bottom side
        self.OuterTexture1 = self.Frame:CreateTexture("DcrMicroUnit"..Unit.."Bottom", "BORDER");
        self.OuterTexture1:SetPoint("BOTTOMLEFT", self.Frame, "BOTTOMLEFT", 0, 0);
        self.OuterTexture1:SetPoint("TOPRIGHT", self.Frame, "BOTTOMRIGHT",  0, 2);

        -- left side
        self.OuterTexture2 = self.Frame:CreateTexture("DcrMicroUnit"..Unit.."Left", "BORDER");
        self.OuterTexture2:SetPoint("TOPLEFT", self.Frame, "TOPLEFT", 0, -2);
        self.OuterTexture2:SetPoint("BOTTOMRIGHT", self.Frame, "BOTTOMLEFT", 2, 2);

        -- top side
        self.OuterTexture3 = self.Frame:CreateTexture("DcrMicroUnit"..Unit.."Top", "BORDER");
        self.OuterTexture3:SetPoint("TOPLEFT", self.Frame, "TOPLEFT", 0, 0);
        self.OuterTexture3:SetPoint("BOTTOMRIGHT", self.Frame, "TOPRIGHT", 0, -2);

        -- right side
        self.OuterTexture4 = self.Frame:CreateTexture("DcrMicroUnit"..Unit.."Right", "BORDER");
        self.OuterTexture4:SetPoint("TOPRIGHT", self.Frame, "TOPRIGHT", 0, -2);
        self.OuterTexture4:SetPoint("BOTTOMLEFT", self.Frame, "BOTTOMRIGHT", -2, 2);


        -- global texture
        self.Texture = self.Frame:CreateTexture("DcrMicroUnit"..Unit.."Back", "ARTWORK");
        self.Texture:SetPoint("CENTER",self.Frame ,"CENTER",0,0)
        self.Texture:SetHeight(16);
        self.Texture:SetWidth(16);

        -- inner Texture (Charmed special texture)
        self.InnerTexture = self.Frame:CreateTexture("DcrMicroUnit"..Unit.."Charmed", "OVERLAY");
        self.InnerTexture:SetPoint("CENTER",self.Frame ,"CENTER",0,0)
        self.InnerTexture:SetHeight(7);
        self.InnerTexture:SetWidth(7);
        self.InnerTexture:SetTexture(unpack(MF_colors[CHARMED_STATUS]));

        -- Chrono Font string
        self.ChronoFontString = self.Frame:CreateFontString("DcrMicroUnit"..Unit.."Chrono", "ARTWORK", "DcrMicroUnitChronoFont");
        self.ChronoFontString:SetTextColor(unpack(MF_colors["COLORCHRONOS"]));

        -- raid target icon
        self.RaidIconTexture = self.Frame:CreateTexture("DcrMicroUnit"..Unit.."RaidTargetIcon", "OVERLAY");
        self.RaidIconTexture:SetPoint("CENTER",self.Frame ,"CENTER",0,8)
        self.RaidIconTexture:SetHeight(13);
        self.RaidIconTexture:SetWidth(13);


        -- a reference to this object
        self.Frame.Object = self;

        -- register events
        self.Frame:RegisterForClicks("AnyUp");
        self.Frame:SetFrameStrata("MEDIUM");

        -- set the frame attributes
        self:UpdateAttributes(Unit);

        -- once the MF frame is set up, schedule an event to show it
        MicroUnitF:Delayed_MFsDisplay_Update();
end -- }}}


function MicroUnitF.prototype:Update(SkipSetColor, SkipDebuffs, CheckStealth)

    local MF = self;
    local ActionsDone = 0;

    local Unit = MF.CurrUnit;

    -- The unit is the same but the name isn't... (check for class change)
    if MF.CurrUnit == Unit and D.Status.Unit_Array_UnitToGUID[self.CurrUnit] ~= self.UnitGUID then
        if MF:SetClassBorder() then
            ActionsDone = ActionsDone + 1; -- count expensive things done
        end
        -- if the guid changed we really need to rescan the unit!
        SkipSetColor = false; SkipDebuffs = false; CheckStealth = true;
        --[===[@debug@
        D:Debug("|cFF00CC00MUF:Update(): Guid change rescanning", Unit, "|r");
        --@end-debug@]===]
    end

    -- Update the frame attributes if necessary (Spells priority or unit id changes)
    if (D.Status.SpellsChanged ~= MF.LastAttribUpdate ) then
        --D:Debug("Attributes update required: ", MF.ID);
        if (MF:UpdateAttributes(Unit, true)) then
            ActionsDone = ActionsDone + 1; -- count expensive things done
            SkipSetColor = false; SkipDebuffs = false; -- if some attributes were updated then update the rest
        end
    end


    if (not SkipSetColor) then
        if (not SkipDebuffs) then
            -- get the manageable debuffs of this unit
            MF:SetDebuffs();
            D:Debug("Debuff set for ", MF.ID);
            if CheckStealth then
                D.Stealthed_Units[MF.CurrUnit] = D:CheckUnitStealth(MF.CurrUnit); -- update stealth status
--              D:Debug("MF:Update(): Stealth status checked as requested.");
            end
        end

        if (MF:SetColor()) then
            ActionsDone = ActionsDone + 1; -- count expensive things done
        end
    end

    return ActionsDone;
end


function MicroUnitF.prototype:UpdateWithCS()
    self:Update(false, false, true);
end

function MicroUnitF.prototype:UpdateSkippingSetBuf()
    self:Update(false, true);
end

-- UPDATE attributes (Spells and Unit) {{{



do
    -- used to tell if we changed something to improve performances.
    -- Each attribute change trigger an event...
    local ReturnValue = false;
    -- this updates the sttributes of a MUF's frame object
    function MicroUnitF.prototype:UpdateAttributes(Unit, DoNotDelay)

        -- Delay the call if we are fighting
        if InCombatLockdown() then
            if not DoNotDelay then
                D:AddDelayedFunctionCall (
                "MicroUnit_" .. Unit,                   -- UID
                self.UpdateAttributes, self, Unit);     -- function call
            end
            return false;
        end

        ReturnValue = false;

        -- if the unit is not set
        if not self.CurrUnit then
            self.Frame:SetAttribute("unit", Unit);

            -- UnitToMUF[] can only be set when out of fight so it remains
            -- coherent with what is displayed when groups are changed during a
            -- fight
            
            MicroUnitF.UnitToMUF[Unit] = self;
            self.CurrUnit = Unit;

            self:SetClassBorder();

            -- set the return value because we did something expensive
            ReturnValue = self;
        end

        if (D.Status.SpellsChanged == self.LastAttribUpdate) then
            return ReturnValue; -- nothing changed
        end

        -- D:Debug("UpdateAttributes() executed");

        if self.LastAttribUpdate == 0 then -- only once
            -- set the mouse left-button actions on all modifiers
            self.Frame:SetAttribute("type1", "macro");
            self.Frame:SetAttribute("ctrl-type1", "macro");
            self.Frame:SetAttribute("alt-type1", "macro");
            self.Frame:SetAttribute("shift-type1", "macro");

            -- set the mouse right-button actions on all modifiers
            self.Frame:SetAttribute("type2", "macro");
            self.Frame:SetAttribute("ctrl-type2", "macro");
            self.Frame:SetAttribute("alt-type2", "macro");
            self.Frame:SetAttribute("shift-type2", "macro");

            -- set the mouse middle-button actions on all modifiers
            self.Frame:SetAttribute("type3", "macro");
            self.Frame:SetAttribute("ctrl-type3", "macro");
            self.Frame:SetAttribute("alt-type3", "macro");
            self.Frame:SetAttribute("shift-type3", "macro");
        end

        local AvailableButtons = D.db.global.AvailableButtons;

        self.Frame:SetAttribute(str_format(AvailableButtons[#AvailableButtons - 1], "macrotext"), str_format("/target %s", Unit));
        self.Frame:SetAttribute(str_format(AvailableButtons[#AvailableButtons    ], "macrotext"), str_format("/focus %s", Unit));

        -- set the spells attributes using the lookup tables above
        for Spell, Prio in pairs(D.Status.CuringSpellsPrio) do

            --the [target=%s, help][target=%s, harm] prevents the 'please select a unit' cursor problem (Blizzard should fix this...)
            self.Frame:SetAttribute(str_format(AvailableButtons[Prio], "macrotext"), str_format("%s/cast [target=%s, help][target=%s, harm] %s%s",
            ((not D.Status.FoundSpells[Spell][1]) and "/stopcasting\n" or ""),
            Unit,Unit,
            Spell,
            (DC.SpellsToUse[Spell].Rank and "(" .. (str_sub(DC.RANKNUMTRANS, '%d+', DC.SpellsToUse[Spell].Rank)) .. ")" or "")  ));


            --[[
            D:Debug("XX-> macro: ",str_format(AvailableButtons[Prio], "macrotext"), str_format("%s/cast [target=%s, help][target=%s, harm] %s%s",
            ((not D.Status.FoundSpells[Spell][1]) and "/stopcasting\n" or ""),
            Unit,Unit,
            Spell,
            (DC.SpellsToUse[Spell].Rank and "(" .. (str_sub(DC.RANKNUMTRANS, '%d+', DC.SpellsToUse[Spell].Rank)) .. ")" or "")  ));
            --]]

        end

        self.Debuff1Prio = false;

        -- the update timestamp
        self.LastAttribUpdate = D.Status.SpellsChanged;
        return self;
    end
end -- }}}

function MicroUnitF.prototype:SetDebuffs() -- {{{
    self.Debuffs, self.IsCharmed = D:UnitCurableDebuffs(self.CurrUnit);

    if D.UnitDebuffed[self.CurrUnit] then
        D.ForLLDebuffedUnitsNum = D.ForLLDebuffedUnitsNum - 1;
    end

    if (self.Debuffs and self.Debuffs[1] and self.Debuffs[1].Type) then
        --D:Debug("A debuff was found"); -- XXX
        self.IsDebuffed = true;
        self.Debuff1Prio = D:GiveSpellPrioNum( self.Debuffs[1].Type );

        D.UnitDebuffed[self.CurrUnit] = true;
        D.ForLLDebuffedUnitsNum = D.ForLLDebuffedUnitsNum + 1;

    else
        --D:Debug("No debuff found"); -- XXX
        self.IsDebuffed                 = false;
        self.Debuff1Prio                = false;
        self.PrevDebuff1Prio            = false;
        D.UnitDebuffed[self.CurrUnit] = false; -- used by the live-list only
    end
end -- }}}

do
    --[=[
    --      This function is responsible for setting all the textures of a MUF object:
    --          - The main color
    --          - Showing/Hiding the charmed alert square
    --          - The Alpha of the center and borders
    --      This function also set the Status of the MUF that will be used in the tooltip
    --]=]
    local DebuffType, Unit, PreviousStatus, BorderAlpha, Class, ClassColor, ReturnValue, RangeStatus, Alpha, PrioChanged, PrevChrono, Time, Status;
    local profile = {};

    -- global access optimization
    local IsSpellInRange    = _G.IsSpellInRange;
    local UnitClass         = _G.UnitClass;
    local UnitExists        = _G.UnitExists;
    local UnitIsVisible     = _G.UnitIsVisible;
    local UnitLevel         = _G.UnitLevel;
    local unpack            = _G.unpack;
    local select            = _G.select;
    local GetTime           = _G.GetTime;
    local floor             = _G.math.floor;
    local fmod              = _G.math.fmod;
    local CooldownFrame_SetTimer = _G.CooldownFrame_SetTimer;
    local GetSpellCooldown = _G.GetSpellCooldown;
    local GetRaidTargetIndex= _G.GetRaidTargetIndex;
    local bor = _G.bit.bor;

    function MicroUnitF.prototype:SetColor() -- {{{

        profile = D.profile;
        Status  = D.Status;

        -- register default alpha of the border
        BorderAlpha =  profile.DebuffsFrameElemBorderAlpha;

        -- register local variables
        DebuffType = false;
        ReturnValue = false;
        Unit = self.CurrUnit;
        PreviousStatus = self.UnitStatus;



        -- if unit not available, if a unit cease to exist (this happen often for pets)
        if not UnitExists(Unit) then
            if PreviousStatus ~= ABSENT then
                self.Color = MF_colors[ABSENT];
                self.UnitStatus = ABSENT;
                if self.LitTime then
                    self.LitTime = false;
                    self.ChronoFontString:SetText(" ");
                end
            end

            -- UnitIsVisible() behavior is not 100% reliable so we also use UnitLevel() that will return -1 when the Unit is too far...
        elseif not UnitIsVisible(Unit) or UnitLevel(Unit) < 1 then
            if PreviousStatus ~= FAR then
                self.Color = MF_colors[FAR];
                self.UnitStatus = FAR;
                if self.LitTime then
                    self.LitTime = false;
                    self.ChronoFontString:SetText(" ");

                end
            end

        else
            -- If the Unit is invisible
            if profile.Show_Stealthed_Status and D.Stealthed_Units[Unit] then
                if PreviousStatus ~= STEALTHED then
                    self.Color = MF_colors[STEALTHED];
                    self.UnitStatus = STEALTHED;
                    if self.LitTime then
                        self.LitTime = false;
                        self.ChronoFontString:SetText(" ");

                    end
                end

                -- if unit is blacklisted
            elseif Status.Blacklisted_Array[Unit] then
                if PreviousStatus ~= BLACKLISTED then
                    self.Color = MF_colors[BLACKLISTED];
                    self.UnitStatus = BLACKLISTED;
                    if self.LitTime then
                        self.LitTime = false;
                        self.ChronoFontString:SetText(" ");

                    end
                end

                -- if the unit has some debuffs we can handle
            elseif (self.IsDebuffed) then
                DebuffType = self.Debuffs[1].Type;

                if self.PrevDebuff1Prio ~= self.Debuff1Prio then
                    self.Color = MF_colors[self.Debuff1Prio];
                    self.PrevDebuff1Prio = self.Debuff1Prio;
                    PrioChanged = true;
                end

                -- Test if the spell we are going to use is in range
                -- Some time can elaps between the instant the debuff is detected and the instant it is shown.
                -- Between those instants, a reconfiguration can happen (pet dies or some spells become unavailable)
                -- So we test before calling this api that we can still cure this debuff type
                if Status.CuringSpells[DebuffType] then
                    RangeStatus = IsSpellInRange(Status.CuringSpells[DebuffType], Unit);
                else
                    RangeStatus = false;
                end

                Time = GetTime();

                if RangeStatus and self.UpdateCD < Status.UpdateCooldown then
                    CooldownFrame_SetTimer (self.CooldownFrame, GetSpellCooldown(Status.CuringSpells[DebuffType]) );
                    self.UpdateCD = Time;
                end

                -- update the chrono
                if profile.DebuffsFrameChrono then
                    if self.LitTime then
                        PrevChrono = self.Chrono;

                        if not profile.DebuffsFrameTimeLeft then
                            self.Chrono = floor(Time - self.LitTime);

                            if self.Chrono ~= PrevChrono then
                                self.ChronoFontString:SetText( ((self.Chrono < 60) and self.Chrono or (floor(self.Chrono / 60) .. "\'") ));
                            end
                        else
                            self.Chrono = floor(self.Debuffs[1].expirationTime - Time);

                            if self.Chrono ~= PrevChrono then
                                self.ChronoFontString:SetText( ((self.Chrono < 60) and (self.Chrono + 1) or (floor(self.Chrono / 60 + 1) .. "\'") ));
                            end
                        end
                    else
                        self.LitTime = Time;
                    end
                end
                
                self.RaidTargetIcon = GetRaidTargetIndex(Unit);
                if self.PrevRaidTargetIndex ~= self.RaidTargetIcon then
                    self.RaidIconTexture:SetTexture(self.RaidTargetIcon and DC.RAID_ICON_TEXTURE_LIST[self.RaidTargetIcon] or nil);
                    self.PrevRaidTargetIndex = self.RaidTargetIcon;
                end
 

                -- set the status according to RangeStatus
                if (not RangeStatus or RangeStatus == 0) then
                    Alpha = 0.40;
                    self.UnitStatus = AFFLICTED_NIR;
                else
                    Alpha = 1;
                    self.UnitStatus = AFFLICTED;
                    BorderAlpha = 1;

                    MicroUnitF.UnitsDebuffedInRange = MicroUnitF.UnitsDebuffedInRange + 1;

                    if (not Status.SoundPlayed) then
                        D:PlaySound (self.CurrUnit, "SetColor()" );
                    end
                end
            elseif PreviousStatus ~= NORMAL then
                -- the unit has nothing special, set the status to normal
                self.Color = MF_colors[NORMAL];
                self.UnitStatus = NORMAL;
                if self.LitTime then
                    self.LitTime = false;
                    self.ChronoFontString:SetText(" ");
                end

                if self.RaidTargetIcon then
                    self.RaidIconTexture:SetTexture(nil);
                    self.RaidTargetIcon = false;
                    self.PrevRaidTargetIndex = false;
                end

                -- if the previous status was FAR, trigger a full rescan of the unit (combat log event does not report events for far away units)
                if PreviousStatus == FAR then
                    D.MicroUnitF:UpdateMUFUnit(self.CurrUnit, true); -- this is able to deal when a lot of update queries
                end
            end
        end

        if PreviousStatus == AFFLICTED or PreviousStatus == AFFLICTED_AND_CHARMED  then
            MicroUnitF.UnitsDebuffedInRange = MicroUnitF.UnitsDebuffedInRange - 1;

            if MicroUnitF.UnitsDebuffedInRange == 0 and profile.Hide_LiveList then
                D:Debug("SetColor(): No more unit, sound re-enabled");
                Status.SoundPlayed = false;
            end
        end

        if not profile.DebuffsFrameElemBorderShow then
            BorderAlpha = 0;
        end


        -- set the class border color when needed (the class is unknown and the unit exists or the unit name changed)
        --self:SetClassBorder();
        
        -- set the alpha of the border if necessary
        if self.BorderAlpha ~= BorderAlpha then
            self.OuterTexture1:SetAlpha(BorderAlpha);
            self.OuterTexture2:SetAlpha(BorderAlpha);
            self.OuterTexture3:SetAlpha(BorderAlpha);
            self.OuterTexture4:SetAlpha(BorderAlpha);

            self.BorderAlpha = BorderAlpha;

            -- set this to true because we just did something expensive...
            ReturnValue = true;
            --D:Debug("border alpha set");
        end


        -- Add the charm status to the bitfield (note that it's treated separatly because it's shown even if the unit is not afflicetd by anything we can cure)
        if self.IsCharmed then
            self.UnitStatus = bor(self.UnitStatus, CHARMED_STATUS);
        end

        -- if the unit is not afflicted or too far set the color to a lower alpha
        if not DebuffType then -- if DebuffType was not set, it means that the unit is too far
            Alpha = self.Color[4] * profile.DebuffsFrameElemAlpha;
            self.PrevDebuff1Prio = false;
        end


        -- Apply the colors and alphas only if necessary
        --      The MUF status changed
        --      The user changed the defaultAlpha
        --      The priority (and thus the color) of the first affliction changed
        if (self.UnitStatus ~= PreviousStatus or self.NormalAlpha ~= profile.DebuffsFrameElemAlpha or PrioChanged) then-- or self.FirstDebuffType ~= DebuffType) then

            if PrioChanged then PrioChanged = false; end

            -- Set the main texture
            self.Texture:SetTexture(self.Color[1], self.Color[2], self.Color[3], Alpha);
            --self.Texture:SetAlpha(Alpha);

            

            -- Show the charmed alert square
            if self.IsCharmed then
                self.InnerTexture:Show();
            else
                self.InnerTexture:Hide();
            end

            --D:Debug("Color Applied, MUF Status:", self.UnitStatus);


            -- save the current global status
            self.NormalAlpha = profile.DebuffsFrameElemAlpha;
            self.FirstDebuffType = DebuffType;

            -- set this to true because we just did something expensive...
            ReturnValue = true;
        end

        return ReturnValue;

    end -- }}}

    function MicroUnitF.prototype:SetClassBorder()
        --D:Debug("SetClassBorder called ", D.Status.Unit_Array_UnitToGUID[self.CurrUnit] , self.UnitGUID);
        ReturnValue = false;
        if (D.profile.DebuffsFrameElemBorderShow and (D.Status.Unit_Array_UnitToGUID[self.CurrUnit] ~= self.UnitGUID or (not self.UnitClass and UnitExists(self.CurrUnit)))) then

            -- Get the GUID of this unit
            self.UnitGUID = D.Status.Unit_Array_UnitToGUID[self.CurrUnit];

            if self.UnitGUID then -- can be nil because of focus...
                -- Get its class
                Class = (select(2, UnitClass(self.CurrUnit)));
            else
                Class = false;
            end

            -- if the class changed
            if (Class and Class ~= self.UnitClass) then
                ClassColor = DC.ClassesColors[Class];
                -- update the border color (the four borders)
                self.OuterTexture1:SetTexture(  unpack(ClassColor) );
                self.OuterTexture2:SetTexture(  unpack(ClassColor) );
                self.OuterTexture3:SetTexture(  unpack(ClassColor) );
                self.OuterTexture4:SetTexture(  unpack(ClassColor) );

                -- save the class for futur reference
                self.UnitClass = Class;

                -- set this to true because we just did something expensive...
                ReturnValue = true;

                --D:Debug("Class '%s' set for '%s'", Class, self.CurrUnit);
            elseif not Class and self.UnitClass then
                -- if the class is not available, set it to false so this test will be done again and again until a class is found
                self.UnitClass = false;
                BorderAlpha = 0;
                self.OuterTexture1:SetAlpha(BorderAlpha);
                self.OuterTexture2:SetAlpha(BorderAlpha);
                self.OuterTexture3:SetAlpha(BorderAlpha);
                self.OuterTexture4:SetAlpha(BorderAlpha);

                self.BorderAlpha = BorderAlpha;

                ReturnValue = true;
                --D:Debug("Class of unit %s is Nil", self.CurrUnit);
            end
        end
        return ReturnValue;

    end

end 
-- }}}

do
    local MicroFrameUpdateIndex = 1; -- MUFs are not updated all together
    local NumToShow, ActionsDone, Unit, MF, pass, UnitNum;
    -- updates the micro frames if needed (called regularly by ACE event, changed in the option menu)
    function D:DebuffsFrame_Update() -- {{{

        local Unit_Array = self.Status.Unit_Array;
        local UnitToGUID = self.Status.Unit_Array_UnitToGUID;

        UnitNum = self.Status.UnitNum; -- we need to go through all the units to set MF.ID properly
        NumToShow = ((MicroUnitF.MaxUnit > UnitNum) and UnitNum or MicroUnitF.MaxUnit);

        ActionsDone = 0; -- used to limit the maximum number of consecutive UI actions


        -- we don't check all the MUF at each call, only some of them (changed in the options)
        for pass = 1, self.profile.DebuffsFramePerUPdate do

            -- When all frames have been updated, go back to the first
            if (MicroFrameUpdateIndex > UnitNum) then
                MicroFrameUpdateIndex = 1;
                -- self:Debug("last micro frame updated,,:: %d", #self.Status.Unit_Array);
            end

            -- get a unit
            Unit = Unit_Array[MicroFrameUpdateIndex];

            -- should never fire unless the player choosed to ignore everything or something is wrong somewhere in the code
            if not Unit then
                --self:Debug("Unit is nil :/");
                return false;
            end

            -- get its MUF
            MF = MicroUnitF.ExistingPerUNIT[Unit];

            -- if no MUF then create it (All MUFs are created here)
            if (not MF) then
                if not InCombatLockdown() then
                    MF = MicroUnitF:Create(Unit, MicroFrameUpdateIndex);
                    ActionsDone = ActionsDone + 1;
                end
            end

            -- place the MUF ~right where it belongs~
            if MF and MF.ToPlace ~= MicroFrameUpdateIndex and not InCombatLockdown() then

                --sanity check
                --[[
                if MicroFrameUpdateIndex ~= MF.ID then  -- XXX to remove for release
                    D:AddDebugText("DebuffsFrame_Update(): MicroFrameUpdateIndex ~= MF.ID", MicroFrameUpdateIndex, MF.ID, Unit, MF.CurrUnit, "ToPlace:", MF.ToPlace);
                end
                --]]
                
                MF.ToPlace = MicroFrameUpdateIndex;

                MF.Frame:SetPoint(unpack(MicroUnitF:GiveMFAnchor(MicroFrameUpdateIndex)));
                if MF.Shown then
                    MF.Frame:Show();
                end

                -- test for GUID change and force a debuff update in this case
                if UnitToGUID[MF.CurrUnit] ~= MF.UnitGUID then
                    MF.UpdateCountDown = 0; -- will force MF:Update() to be called
                    --[===[@debug@
                    D:Println("|cFFFFAA55GUID change detected while placing for |r", MicroFrameUpdateIndex, UnitToGUID[MF.CurrUnit], MF.UnitGUID );
                    --@end-debug@]===]
                end

                ActionsDone = ActionsDone + 1;
            end

            -- update the MUF attributes and its colors -- this is done by an event handler now (buff/debuff received...) except when the unit has a debuff and is in range
            if MF and MicroFrameUpdateIndex <= NumToShow then
                if not (MF.IsDebuffed or MF.IsCharmed) and MF.UpdateCountDown ~= 0 then
                    MF.UpdateCountDown = MF.UpdateCountDown - 1;
                else -- if MF.IsDebuffed or MF.IsCharmed or MF.UpdateCountDown == 0
                    ActionsDone = ActionsDone + MF:Update(false, true);--, not ((MF.IsDebuffed or MF.IsCharmed) and MF.UnitStatus ~= AFFLICTED)); -- we rescan debuffs if the unit is not in spell range XXX useless now since we rescan everyone every second
                    MF.UpdateCountDown = 3;
                end
            end

            -- we are done for this frame, go to te next
            MicroFrameUpdateIndex = MicroFrameUpdateIndex + 1;

            -- don't update more than 5 MUF in a row
            -- don't loop when reaching the end, wait for the next call (useful when less MUFs than PerUpdate)
            if (ActionsDone > 5 or pass == UnitNum) then
                --self:Debug("Max actions count reached");
                break;
            end

        end
        --    end
    end -- }}}
end

-- This little function returns the priority of the spell corresponding to an affliction type (one spell can be used for several types)
function D:GiveSpellPrioNum (Type) -- {{{
    return D.Status.CuringSpellsPrio[D.Status.CuringSpells[Type]];
end -- }}}








-- old unused variables and functions
-- UNUSED STUFF {{{
-- Micro Frame Events, useless for now

function MicroUnitF:OnPostClick(frame, button)
--      D:Debug("Micro unit PostClicked");
end

function MicroUnitF:OnAttributeChanged(self, name, value)
        D:Debug("Micro unit", name, "AttributeChanged to", value);
end


local MUF_Status = { -- unused
    [1] = "normal";
    [2] = "absent";
    [3] = "far";
    [4] = "stealthed";
    [5] = "blacklist";
    [6] = "afflicted";
    [7] = "afflicted-far";
    [8] = "afflicted-charmed";
    [9] = "afflicted-charmed-far";
}


local MF_Textures = { -- unused
    "Interface/AddOns/Decursive/Textures/BackDrop-red", -- red
    "Interface/AddOns/Decursive/Textures/BackDrop-blue", -- blue
    "Interface/AddOns/Decursive/Textures/BackDrop-orange", -- orange
    ["grey"] = "Interface\\AddOns\\Decursive\\Textures\\BackDrop-grey-medium",
    ["black"] = "Interface/AddOns/Decursive/Textures/BackDrop",
};


-- }}}

T._LoadedFiles["Dcr_DebuffsFrame.lua"] = "2.5.1-6-gd3885c5";

-- Heresy
