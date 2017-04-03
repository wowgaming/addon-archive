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
if not T._LoadedFiles or not T._LoadedFiles["Decursive.xml"] or not T._LoadedFiles["Decursive.lua"] then
    if not DecursiveInstallCorrupted then T._FatalError("Decursive installation is corrupted! (Decursive.xml or Decursive.lua not loaded)"); end;
    DecursiveInstallCorrupted = true;
    return;
end

local D = Dcr;
--D:SetDateAndRevision("$Date: 2008-08-12 04:50:10 +0200 (mar., 12 août 2008) $", "$Revision: 80230 $");


local L = D.L;
local LC = D.LC;
local DC = DcrC;
local DS = DC.DS;
local _;
local _G = _G;

local pairs             = _G.pairs;
local ipairs            = _G.ipairs;
local UnitGUID          = _G.UnitGUID;
local table             = _G.table;
local str_format        = _G.string.format;
local str_sub           = _G.string.gsub;
local t_insert          = _G.table.insert;

-- Dcr_ListFrameTemplate specific internal functions {{{
function D.ListFrameTemplate_OnLoad(frame)
    frame.ScrollFrame = _G[frame:GetName().."ScrollFrame"];
    frame.ScrollBar = _G[frame.ScrollFrame:GetName().."ScrollBar"];
    frame.ScrollFrame.offset = 0;
end

function D:ListFrameScrollFrameTemplate_OnMouseWheel(frame, value)
    local scrollBar = _G[frame:GetName().."ScrollBar"];
    local min, max = scrollBar:GetMinMaxValues();
    if ( value > 0 ) then
        if (IsShiftKeyDown() ) then
            scrollBar:SetValue(min);
        else
            scrollBar:SetValue(scrollBar:GetValue() - scrollBar:GetValueStep());
        end
    else
        if (IsShiftKeyDown() ) then
            scrollBar:SetValue(max);
        else
            scrollBar:SetValue(scrollBar:GetValue() + scrollBar:GetValueStep());
        end
    end
end

-- }}}

-- Dcr_ListFrameTemplate specific handlers {{{

function D.PrioSkipListFrame_OnUpdate(frame) --{{{


    if not D.DcrFullyInitialized then
        return;
    end

    if (frame.UpdateYourself) then
        frame.UpdateYourself = false;
        local baseName = frame:GetName();
        local size;

        if (frame.Priority) then
            size = table.getn(D.profile.PriorityList);
        else
            size = table.getn(D.profile.SkipList);
        end
        -- D:Debug("PrioSkipListFrame_OnUpdate executed", size, this.ScrollFrame.offset);

        local i;
        for i = 1, 10 do
            local id = ""..i;
            if (i < 10) then
                id = "0"..i;
            end
            local btn = _G[baseName.."Index"..id];

            btn:SetID( i + frame.ScrollFrame.offset);
            D:PrioSkipListEntry_Update(btn);

            if (i <= size) then
                btn:Show();
            else
                btn:Hide();
            end
        end
        frame.ScrollUpdateFunc(_G[baseName.."ScrollFrame"], true);
    end

end --}}}

function D:PrioSkipListEntryTemplate_OnClick(frame) --{{{
--    D:PrintLiteral(arg1);

    local list;
    local UnitNum;
    if (frame:GetParent().Priority) then
        list = D.profile.PriorityList;
        UnitNum = getn(D.profile.PriorityList);
    else
        list = D.profile.SkipList;
        UnitNum = getn(D.profile.SkipList);
    end


    local id = frame:GetID();
    if (id) then
        if (IsControlKeyDown()) then
            if (frame:GetParent().Priority) then
                D:RemoveIDFromPriorityList(id);
            else
                D:RemoveIDFromSkipList(id);
            end
        elseif (UnitNum > 1) then
            local previousUnit_ID, previousUnit, nextUnit_ID, nextUnit, currentUnit;

            --if (id == 0) then
                -- previousUnit_ID      = UnitNum;  else 
                previousUnit_ID  = id - 1;
            --end
            --if (id == UnitNum - 1) then
                --nextUnit_ID   =           0;  else
                nextUnit_ID      = id + 1;
            --end

            previousUnit = list[previousUnit_ID];
            nextUnit     = list[nextUnit_ID    ];
            currentUnit  = list[id];


            if (arg1=="RightButton" and IsShiftKeyDown()) then -- move at the bottom
                table.remove(list, id);
                table.insert(list, UnitNum, currentUnit);

            elseif (arg1=="LeftButton" and IsShiftKeyDown()) then -- move at the top
                table.remove(list, id);
                table.insert(list, 1, currentUnit);
            elseif (arg1=="LeftButton" and id ~= 1) then -- unit gets higher
                D:Debug("upping %s of id %d", list[id], id);
                list[previousUnit_ID]   = list[id];
                list[id]                = previousUnit;
            elseif (arg1=="RightButton" and id ~= UnitNum) then -- unit gets lower
                D:Debug("downing %s of id %d", list[id], id);
                list[nextUnit_ID]       = list[id];
                list[id]                = nextUnit;
            elseif (arg1=="MiddleButton") then
            
            end
            frame:GetParent().UpdateYourself = true;
        end
        D.Status.PrioChanged       = true;
        D:GroupChanged ("PrioSkipListEntryTemplate_OnClick");
    else
            D:Debug("No ID");
    end

end --}}}

function D:PrioSkipListEntry_Update(Entry) --{{{
        local id = Entry:GetID();
        if (id) then
        --D:Debug("PrioSkipListEntry_Update executed");
            local name, classname, GUIDorNum;
            if (Entry:GetParent().Priority) then
                GUIDorNum = D.profile.PriorityList[id];
                classname = D.profile.PriorityListClass[GUIDorNum];
                name = D.profile.PrioGUIDtoNAME[GUIDorNum];
            else
                GUIDorNum = D.profile.SkipList[id];
                classname = D.profile.SkipListClass[GUIDorNum];
                name = D.profile.SkipGUIDtoNAME[GUIDorNum];
            end
            if not classname then
                classname = "WARRIOR";
            end
            if (GUIDorNum) then
                if (type(GUIDorNum) == "number") then
                    if (GUIDorNum < 10) then
                        name = str_format("[ %s %s ]", L["STR_GROUP"], GUIDorNum);
                    else
                        name = str_format("[ %s ]", DC.ClassNumToLName[GUIDorNum]);
                    end
                end
                Entry:SetText(id.." - "..D:ColorText(name, "FF"..DC.HexClassColor[classname]));
            else
                Entry:SetText("Error - NO name!");
            end
        else
            Entry:SetText("Error - No ID!");
        end
end --}}}

function D.PrioSkipList_ScrollFrame_Update (ScrollFrame) -- {{{

    if not D.DcrFullyInitialized then
        return;
    end

    local maxentry;
    local UpdateListOnceDone = true;
    local DirectCall = false;

    D:Debug("ScrollFrame is a %s", type(ScrollFrame));
    if (not ScrollFrame) then
        --ScrollFrame = this; -- Called from the scrollbar frame handler
    else
        --UpdateListOnceDone = false; -- The function was called from the list update function
        DirectCall = true;
    end

    if (not ScrollFrame.UpdateYourself) then
        ScrollFrame.UpdateYourself = true;
        return;
    end

    if (ScrollFrame:GetParent().Priority) then
        maxentry = table.getn(D.profile.PriorityList);
    else
        maxentry = table.getn(D.profile.SkipList);
    end

    FauxScrollFrame_Update(ScrollFrame,maxentry,10,16);


    if (UpdateListOnceDone) then
        ScrollFrame.UpdateYourself = false; -- prevent this function to re-execute unecessarily
        ScrollFrame:GetParent().UpdateYourself = true;
    end
    D:Debug("PrioSkipList_ScrollFrame_Update executed for %s", ScrollFrame:GetName());
end -- }}}


-- }}}

-- list specific management functions {{{
-------------------------------------------------------------------------------
D.Status.GroupsPrio = { };
D.Status.ClassPrio  = { };
function D:MakeGroupsAndClassPrio ()

    if D.Status.PrioChanged then
        local GroupsPrio = {};
        local ClassPrio = {};

        for i, ListEntry in ipairs(self.profile.PriorityList) do
            if (type(ListEntry) ~= "string") then
                if (ListEntry < 10) then
                    t_insert(GroupsPrio, ListEntry);
                else
                    t_insert(ClassPrio, ListEntry);
                end
            end
        end

        -- Reverse GroupsPrio and ClassPrio so we can have something useful...
        D.Status.GroupsPrio = self:tReverse(GroupsPrio);
        D.Status.ClassPrio  = self:tReverse(ClassPrio);
        D.Status.PrioChanged = false;
    end

    return D.Status.GroupsPrio, D.Status.ClassPrio;
end


function D:AddTargetToPriorityList() --{{{
    D:Debug( "Adding the target to the priority list");
    return D:AddUnitToPriorityList("target", true);
end --}}}

function D:AddUnitToPriorityList( unit, check ) --{{{

    if not D.DcrFullyInitialized then
        return false;
    end

    if (#D.profile.PriorityList > 99) then
        return false;
    end

    if (not check or UnitExists(unit)) then
        if (type(unit) == "number" or UnitIsPlayer(unit)) then
            D:Debug("adding %s", unit);

            --local name;
            local GUIDorNum;

            if type(unit) == "number" then
                GUIDorNum = unit;
            else
                --name = (D:UnitName(unit));
                GUIDorNum = UnitGUID(unit);
                --if name == DC.UNKNOWN then
                if not GUIDorNum then
                    return false;
                end
            end

            if D.profile.PrioGUIDtoNAME[GUIDorNum] then
                return false;
            end
            --[[
            for _, pname in pairs(D.profile.PriorityList) do
                if (name == pname) then
                    return false;
                end
            end
            --]]

            table.insert(D.profile.PriorityList,GUIDorNum);



            if (type(unit) == "string") then
                _, D.profile.PriorityListClass[GUIDorNum] = UnitClass(unit);
                D.profile.PrioGUIDtoNAME[GUIDorNum] = (D:UnitName(unit));
            elseif unit > 10 then
                D.profile.PriorityListClass[unit] = DC.ClassNumToUName[unit];
                D.profile.PrioGUIDtoNAME[GUIDorNum] = str_format("[ %s ]", DC.ClassNumToLName[GUIDorNum]);
            else
                D.profile.PrioGUIDtoNAME[GUIDorNum] = str_format("[ %s %s ]", L["STR_GROUP"], GUIDorNum);
            end

            DecursivePriorityListFrame.UpdateYourself = true;
            D:Debug("Unit %s added to the prio list", GUIDorNum);
            D.Status.PrioChanged       = true;
            D:GroupChanged ("AddUnitToPriorityList");
            return true;
        else
            D:Debug("Unit is not a player:", unit, check, UnitExists(unit));
            if (not unit) then
                error("D:AddUnitToPriorityList: bad argument #1 'unit' must be!",2);
            end
        end
    else
            D:Debug("Unit does not exist");
    end
    return false;
end --}}}

function D:RemoveIDFromPriorityList(id) --{{{

    D.profile.PriorityListClass[ D.profile.PriorityList[id] ] = nil; -- remove it from the table
    D.profile.PrioGUIDtoNAME[ D.profile.PriorityList[id]] = nil;

    table.remove( D.profile.PriorityList, id );

    D.Status.PrioChanged       = true;
    D:GroupChanged ("RemoveIDFromPriorityList");
    DecursivePriorityListFrame.UpdateYourself = true;
end --}}}

function D:ClearPriorityList() --{{{
    D.profile.PriorityList = {};
    D.profile.PriorityListClass = {};
    D.profile.PrioGUIDtoNAME = {};
    
    D.Status.PrioChanged       = true;
    D:GroupChanged ("ClearPriorityList");
    DecursivePriorityListFrame.UpdateYourself = true;
end --}}}

function D:AddTargetToSkipList() --{{{
    D:Debug( "Adding the target to the Skip list");
    return D:AddUnitToSkipList("target");
end --}}}

function D:AddUnitToSkipList( unit) --{{{

    if (#D.profile.SkipList > 99) then
        return false;
    end

    if (not check or UnitExists(unit)) then
        if (type(unit) == "number" or UnitIsPlayer(unit)) then
            D:Debug("adding %s", unit);

             --local name;
            local GUIDorNum;

            
            if type(unit) == "number" then
                GUIDorNum = unit;
            else
                --name = (D:UnitName( unit));
                GUIDorNum = UnitGUID(unit);
                --if name == DC.UNKNOWN then
                if not GUIDorNum then
                    return false;
                end
            end

            if D.profile.SkipGUIDtoNAME[GUIDorNum] then
                return false;
            end
            --[[
            for _, pname in pairs(D.profile.SkipList) do
                if (name == pname) then
                    return false;
                end
            end
            --]]

            table.insert(D.profile.SkipList,GUIDorNum);

            if (type(unit) == "string") then
                _, D.profile.SkipListClass[GUIDorNum] = UnitClass(unit);
                D.profile.SkipGUIDtoNAME[GUIDorNum] = (D:UnitName(unit));
            elseif unit > 10 then
                D.profile.SkipListClass[unit] = DC.ClassNumToUName[unit];
                D.profile.SkipGUIDtoNAME[GUIDorNum] = str_format("[ %s ]", DC.ClassNumToLName[GUIDorNum]);
            else
                D.profile.SkipGUIDtoNAME[GUIDorNum] = str_format("[ %s %s ]", L["STR_GROUP"], GUIDorNum);
            end

            DecursiveSkipListFrame.UpdateYourself = true;
            D:Debug("Unit %s added to the skip list", GUIDorNum);
            D.Status.PrioChanged       = true;
            D:GroupChanged ("AddUnitToSkipList");
            return true;
        else
            D:Debug("Unit is not a player:", unit);
        end
    else
            D:Debug("Unit does not exist");
    end
    return false;
end --}}}

function D:RemoveIDFromSkipList(id) --{{{

    D.profile.SkipListClass[ D.profile.SkipList[id] ] = nil; -- remove it from the table
    D.profile.SkipGUIDtoNAME[ D.profile.SkipList[id]] = nil;
    

    table.remove( D.profile.SkipList, id );

    D.Status.PrioChanged       = true;
    D:GroupChanged ("RemoveIDFromSkipList");
    DecursiveSkipListFrame.UpdateYourself = true;
end --}}}

function D:ClearSkipList() --{{{
    local i;

    D.profile.SkipList = {};
    D.profile.SkipListClass = {};
    D.profile.SkipGUIDtoNAME = {};
    
    D.Status.PrioChanged       = true;
    D.Groups_datas_are_invalid = true;
    D:GroupChanged ("ClearSkipList");
    DecursiveSkipListFrame.UpdateYourself = true;
end --}}}


function D:IsInPriorList (GUID) --{{{
    return self.Status.InternalPrioList[GUID] or false;

--[=[
    for _, PriorName in pairs(D.profile.PrioGUIDtoNAME) do
        if (PriorName == name) then
            return true;
        end
    end
    return false;
    --]=]
end --}}}

function D:IsInSkipList (name) --{{{
    return self.Status.InternalSkipList[GUID] or false;
--[=[
    for _, SkipName in pairs(D.profile.SkipGUIDtoNAME) do
        if (SkipName == name) then
            return true;
        end
    end
    return false
    --]=]
end --}}}


-- }}}



function D:PopulateButtonPress(frame) --{{{
    local PopulateFrame = frame:GetParent();
    local UppedClass = "";

    if (IsShiftKeyDown() and frame.ClassType) then

        -- UnitClass returns uppercased class...
        UppedClass = string.upper(frame.ClassType);

        D:Debug("Populate called for %s", frame.ClassType);
        -- for the class type stuff... we do party

        local _, pclass = UnitClass("player");
        if (pclass == UppedClass) then
            PopulateFrame:addFunction("player");
        end

        _, pclass = UnitClass("party1");
        if (pclass == UppedClass) then
            PopulateFrame:addFunction("party1");
        end
        _, pclass = UnitClass("party2");
        if (pclass == UppedClass) then
            PopulateFrame:addFunction("party2");
        end
        _, pclass = UnitClass("party3");
        if (pclass == UppedClass) then
            PopulateFrame:addFunction("party3");
        end
        _, pclass = UnitClass("party4");
        if (pclass == UppedClass) then
            PopulateFrame:addFunction("party4");
        end
    end

    local i, pgroup, pclass;


    if (IsShiftKeyDown() and frame.ClassType) then
        D:Debug("Finding raid units with a macthing class");
        for index, unit in ipairs(D.Status.Unit_Array) do
            _, pclass = UnitClass(unit);

            if (pclass == UppedClass) then
                D:Debug("found %s", pclass);
                PopulateFrame:addFunction(unit);
            end

        end
    elseif (frame.ClassType) then
        PopulateFrame:addFunction(DC.ClassUNameToNum[string.upper(frame.ClassType)]);
    end


    local max = GetNumRaidMembers();

    if (IsShiftKeyDown() and frame.GroupNumber and max > 0) then
        D:Debug("Finding raid units with a macthing group number");
        for i = 1, max do
            _, _, pgroup, _, _, pclass = GetRaidRosterInfo(i);

            if (pgroup == frame.GroupNumber) then
                D:Debug("found %s in group %d", pclass, max);
                PopulateFrame:addFunction("raid"..i);
            end
        end
    elseif (not IsShiftKeyDown() and frame.GroupNumber) then
        PopulateFrame:addFunction(frame.GroupNumber);
    end

end --}}}

T._LoadedFiles["Dcr_lists.lua"] = "2.5.1-6-gd3885c5";
