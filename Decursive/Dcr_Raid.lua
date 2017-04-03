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
if not T._LoadedFiles or not T._LoadedFiles["Dcr_Events.lua"] then
    if not DecursiveInstallCorrupted then T._FatalError("Decursive installation is corrupted! (Dcr_Events.lua not loaded)"); end;
    DecursiveInstallCorrupted = true;
    return;
end

local D = Dcr;
--D:SetDateAndRevision("$Date: 2008-09-16 00:25:13 +0200 (mar., 16 sept. 2008) $", "$Revision: 81755 $");


local L     = D.L;
local LC    = D.LC;
local DC    = DcrC;
local DS    = DC.DS;

local RaidRosterCache           = { };
local SortingTable              = { };
D.Status.Unit_Array_GUIDToUnit  = { };
D.Status.Unit_Array_UnitToGUID  = { };

D.Status.InternalPrioList       = { };
D.Status.InternalSkipList       = { };
D.Status.Unit_Array             = { };

local pairs                 = _G.pairs;
local ipairs                = _G.ipairs;
local type                  = _G.type;
local select                = _G.select;
local UnitIsFriend          = _G.UnitIsFriend;
local UnitCanAttack         = _G.UnitCanAttack;
local GetNumRaidMembers     = _G.GetNumRaidMembers;
local GetNumPartyMembers    = _G.GetNumPartyMembers;
local GetRaidRosterInfo     = _G.GetRaidRosterInfo;
local random                = _G.random;
local UnitIsUnit            = _G.UnitIsUnit;
local UnitClass             = _G.UnitClass;
local UnitExists            = _G.UnitExists;
local UnitGUID              = _G.UnitGUID;
local table                 = _G.table;
local t_insert              = _G.table.insert;
local str_upper             = _G.string.upper;
local MAX_RAID_MEMBERS      = _G.MAX_RAID_MEMBERS;
local setmetatable          = _G.setmetatable;
local rawget                = _G.rawget;
local GetTime               = _G.GetTime;
-------------------------------------------------------------------------------

-- GROUP STATUS UPDATE, these functions update the UNIT table to scan {{{
-------------------------------------------------------------------------------

--[=[
local function AddToSort (unit, GUID, index) -- // {{{
    if (D.profile.Random_Order and
        (not D.Status.InternalPrioList[GUID]) and not GUID~=MyGUID) then
        index = random (1, 3000);
    end
    SortingTable[unit] = index;
    --D:Debug("Adding to sort: ", unit, index);
end --}}}
--]=]


-- Raid/Party Name Check Function (a terrible function, need optimising)
-- this returns the UnitID that the Name points to
-- this does not check "target" or "mouseover"
--[=[
function D:NameToUnit( Name ) --{{{

    local numRaidMembers = GetNumRaidMembers();
    local FoundUnit = false;


    if (not Name) then
        return false;
    end

    if self.Status.Unit_Array_NameToUnit[Name] ~= nil then
        return self.Status.Unit_Array_NameToUnit[Name];
    end

    if (numRaidMembers == 0) then
        if (Name == (self:UnitName("player"))) then
            FoundUnit =  "player";
        elseif (Name == (self:UnitName("pet"))) then
            FoundUnit =  "pet";
        elseif GetNumPartyMembers() > 0 then
            if (Name == (self:UnitName("party1"))) then
                FoundUnit =  "party1";
            elseif (Name == (self:UnitName("party2"))) then
                FoundUnit =  "party2";
            elseif (Name == (self:UnitName("party3"))) then
                FoundUnit =  "party3";
            elseif (Name == (self:UnitName("party4"))) then
                FoundUnit =  "party4";
            elseif (Name == (self:UnitName("partypet1"))) then
                FoundUnit =  "partypet1";
            elseif (Name == (self:UnitName("partypet2"))) then
                FoundUnit =  "partypet2";
            elseif (Name == (self:UnitName("partypet3"))) then
                FoundUnit =  "partypet3";
            elseif (Name == (self:UnitName("partypet4"))) then
                FoundUnit =  "partypet4";
            end
        end
    else
        -- we are in a raid
        local i;
        local foundmembers = 0;
        local RaidName;
        for i=1, MAX_RAID_MEMBERS do
            RaidName = (GetRaidRosterInfo(i));

            if RaidName then

                foundmembers = foundmembers + 1;

                if ( Name == RaidName) then
                    FoundUnit =  "raid"..i;
                    break;
                end
                if ( self.profile.Scan_Pets and Name == (self:UnitName("raidpet"..i))) then
                    FoundUnit =  "raidpet"..i;
                    break;
                end

                if foundmembers == numRaidMembers then
                    break;
                end

            end
        end
    end

    self.Status.Unit_Array_NameToUnit[Name] = FoundUnit;

    return FoundUnit;

end --}}}
--]=]
-- }}}



DC.ClassNumToLName = {
    [11]        = LC[DC.CLASS_DRUID],
    [12]        = LC[DC.CLASS_HUNTER],
    [13]        = LC[DC.CLASS_MAGE],
    [14]        = LC[DC.CLASS_PALADIN],
    [15]        = LC[DC.CLASS_PRIEST],
    [16]        = LC[DC.CLASS_ROGUE],
    [17]        = LC[DC.CLASS_SHAMAN],
    [18]        = LC[DC.CLASS_WARLOCK],
    [19]        = LC[DC.CLASS_WARRIOR],
    [20]        = LC[DC.CLASS_DEATHKNIGHT],
}

DC.ClassLNameToNum = D:tReverse(DC.ClassNumToLName);

DC.ClassNumToUName = {
    [11]        = DC.CLASS_DRUID,
    [12]        = DC.CLASS_HUNTER,
    [13]        = DC.CLASS_MAGE,
    [14]        = DC.CLASS_PALADIN,
    [15]        = DC.CLASS_PRIEST,
    [16]        = DC.CLASS_ROGUE,
    [17]        = DC.CLASS_SHAMAN,
    [18]        = DC.CLASS_WARLOCK,
    [19]        = DC.CLASS_WARRIOR,
    [20]        = DC.CLASS_DEATHKNIGHT,
}

DC.ClassUNameToNum = D:tReverse(DC.ClassNumToUName);


-- this gets an array of units for us to check

do

    local i = 1;
    local D = D;
    local _ = false; -- a local dummy trash variable

    local MAX_RAID_MEMBERS = _G.MAX_RAID_MEMBERS;

    local UnitToGUID = {};
    local GUIDToUnit = {};

    local raidnum = 0;

    local UnitToGUID_mt = { __index = function(self, unit)
        local GUID = UnitGUID(unit) or false;

        self[unit] = GUID;
        GUIDToUnit[GUID] = unit;

        --[=[
        if (D.db.global.debugging) then
            if not GUID then
                D:errln("UnitToGUID_mt: no GUID for: ", unit); -- this is not an error, it's to see when raid# ids are not contiguous...
            end
        end
        --]=]


        return self[unit];
    end };


    local GUIDToUnit_ScannedAll = false;
    local lookforpets = true;
    local GUIDToUnit_mt = { __index = function(self, GUID)
        -- {{{

        if GUIDToUnit_ScannedAll then
            self[GUID] = false;
            D:Debug("GUIDToUnit_mt: %s is not in our group!", GUID);
            return self[GUID];
        end

        if (not GUID) then
            D:errln("GUIDToUnit_mt: no GUID! ");
            return false;
        end

        local unit = false;


        if GUID == DC.MyGUID then
            unit = "player";
        elseif GUID == UnitToGUID["pet"] then
            unit = "pet";
        elseif (raidnum == 0) then
            if GetNumPartyMembers() > 0 then
                if GUID == UnitToGUID["party1"] then
                    unit = "party1";
                elseif GUID == UnitToGUID["party2"] then
                    unit = "party2";
                elseif GUID == UnitToGUID["party3"] then
                    unit = "party3";
                elseif GUID == UnitToGUID["party4"] then
                    unit = "party4";
                elseif D.profile.Scan_Pets then
                    if GUID == UnitToGUID["partypet1"] then
                        unit = "partypet1";
                    elseif GUID == UnitToGUID["partypet2"] then
                        unit = "partypet2";
                    elseif GUID == UnitToGUID["partypet3"] then
                        unit = "partypet3";
                    elseif GUID == UnitToGUID["partypet4"] then
                        unit = "partypet4";
                    end
                end
            end
        else
            -- we are in a raid
            local i;
            local foundmembers = 0;
            local RaidGUID;
            for i=1, MAX_RAID_MEMBERS do
                RaidGUID = UnitToGUID[ "raid"..i];

                if RaidGUID then

                    foundmembers = foundmembers + 1;

                    if GUID == RaidGUID then
                        unit = "raid"..i;
                        break;
                    end

                    if lookforpets and D.profile.Scan_Pets and GUID == UnitToGUID["raidpet"..i]  then
                        unit = "raidpet"..i;
                        break;
                    end

                    if foundmembers == raidnum then
                        break;
                    end
                end
            end
        end 

        if not unit then
            GUIDToUnit_ScannedAll = true;
        end

        self[GUID] = unit;

        return self[GUID];
    end };
    --}}}


    local function IsInSkipList ( GUID, group, classNum ) -- {{{
        if (D.Status.InternalSkipList[GUID] or D.Status.InternalSkipList[group] or D.Status.InternalSkipList[classNum]) then
            return true;
        end

        return false;
    end -- }}}

    local function IsInSkipOrPriorList( GUID, group, classNum )  --{{{

        if (IsInSkipList ( GUID, group, classNum )) then
            return true;
        end

        if (D.Status.InternalPrioList[GUID] or D.Status.InternalPrioList[group] or D.Status.InternalPrioList[classNum]) then
            return true;
        end

        return false;
    end --}}}


    local ClassPrio = { };
    local GroupsPrio = { };

    local currentGroup = 0; -- the group we are in

    local function GetUnitDefaultPriority (RaidId, UnitGroup) -- {{{

        if (not UnitGroup) then
            return RaidId;
        end

        if (UnitGroup >= currentGroup) then
            return ( 8 - ( UnitGroup - currentGroup ) ) * 100 + (41 - RaidId);
        end

        if (UnitGroup < currentGroup) then
            return (currentGroup - UnitGroup) * 100 + (41 - RaidId);
        end
    end -- }}}

    local function GetUnitPriority(Unit, RaidId, UnitGroup, UNClass, IsPet) -- {{{

        -- A little explanation of the principle behind this function {{{
        --[=[ ****************************************************************************
          levels of priority:

          0 --> PriorityList
          1 --> Group
          2 --> Class
          3 --> Default (Decursive "natural" order: our group, groups after, groups before)
          4 --> Pets

          - 8 groups with 5 persons maximum per group
          - 10 classes with 80 persons max for each class (Pets may be counted)
          - 80 persons for default (including possible pets)

          Priority list:    1,000,000 till 100,000,000
          Group indexes:    10,000, 20,000, 30,000, till 80,000
          class indexes:    1,000, 2,000, 3,000, till 10,000
          default indexes:  100 to 800 (player's index will be 900)
          pet indexes:      Same as above but * -1

          We make additions, exemple:
            - Our current group is the group 7
            - The resulting default groups priorities are:
                7:800 8: 700, 1:600, 2: 500, 3: 400, 4: 300, 5: 200, 6:100
            - Archarodim, Mage from Group 5 (23rd unit of the raid)
            - Unit Archarodim priority is 223
            - Class Mage priority is 4000
            - Group 5 priority is 20000

            --> Archarodim priority is 200 + 23 + 4000 + 20000 = 24223
        **************************************************************************** }}} ]=]

        -- Get Decursive's natural default priority of the unit
        local UnitPriority = GetUnitDefaultPriority(RaidId, UnitGroup);

        -- Get the class priority if available
        if ( UNClass and ClassPrio[ DC.ClassUNameToNum [UNClass] ] ) then
            UnitPriority = UnitPriority + ( 10 + 1 - ClassPrio[DC.ClassUNameToNum [UNClass]]) * 1000; -- XXX 10 (Deathknight) is no good
        end

        -- Get the group priority if available
        if (UnitGroup and GroupsPrio[UnitGroup]) then
            UnitPriority = UnitPriority + (8 + 1 - GroupsPrio[UnitGroup]) * 10000;
        end

        -- Get the priority list index if available
        if not IsPet then
            local Unit_GUID = UnitToGUID[Unit];

            local PrioListIndex = 100;

            -- get the higher of the three...
            if (D.Status.InternalPrioList[Unit_GUID] and D.Status.InternalPrioList[Unit_GUID] < PrioListIndex) then
                PrioListIndex = D.Status.InternalPrioList[Unit_GUID];
            end

            if (D.Status.InternalPrioList[UnitGroup] and D.Status.InternalPrioList[UnitGroup] < PrioListIndex) then
                PrioListIndex = D.Status.InternalPrioList[UnitGroup];
            end

            if (D.Status.InternalPrioList[ DC.ClassUNameToNum [UNClass] ] and D.Status.InternalPrioList[ DC.ClassUNameToNum [UNClass] ] < PrioListIndex) then
                PrioListIndex = D.Status.InternalPrioList[ DC.ClassUNameToNum [UNClass] ];
            end


            if ( PrioListIndex < 100) then
                UnitPriority = UnitPriority + (100 + 1 - PrioListIndex) * 1000000;
            end
        end

        if IsPet then
            UnitPriority = UnitPriority * -1;
        end

        return UnitPriority;
    end -- }}}


    local RaidRosterCache = {};

    local pet;
    function D:GetUnitArray() --{{{
        -- if the groups composition did not changed
        if not self.Groups_datas_are_invalid or not self.DcrFullyInitialized then
            return;
        end
        self.Groups_datas_are_invalid = false;

        self:Debug ("|cFFFF44FF-->|r Updating Units Array");

        local pGUID;
        raidnum = GetNumRaidMembers();

        if DC.MyGUID == "NONE" then

            self:Debug("|cFFFF0000DC.MyGUID was nil!!|r");

            DC.MyGUID = (UnitGUID("player"));

            if not DC.MyGUID then
                DC.MyGUID = "NONE";
                self:Debug("|cFFFF0000DC.MyGUID is STILL nil!!|r");
            end

        end

        local MyGUID  = DC.MyGUID;

        -- clear all the arrays
        local Status = self.Status;
        Status.InternalPrioList         = {}; -- these lists contains only units currently present
        Status.InternalSkipList         = {};
        SortingTable                    = {};
        Status.Unit_Array_GUIDToUnit    = {};
        Status.Unit_Array_UnitToGUID    = {};

        UnitToGUID = setmetatable(UnitToGUID, UnitToGUID_mt); -- we could simply erase this one to prevent garbage
        GUIDToUnit = setmetatable(GUIDToUnit, GUIDToUnit_mt); -- this one cannot be erased (memory leak due to GUID...)
        GUIDToUnit_ScannedAll = false;

        if Status.TestLayout then
            D:GetFakeUnit_array ();
            return;
        end


        local unit;


        -- ############### PARSE PRIO AND SKIP LIST ###############

        GroupsPrio, ClassPrio = D:MakeGroupsAndClassPrio();

        lookforpets = false;

        -- First clean and load the prioritylist (remove missing units)
        for i, ListEntry in ipairs(self.profile.PriorityList) do

            -- first add GUIDs present in our raid group
            if (type(ListEntry) == "string") then
                unit = GUIDToUnit[ListEntry];
                if (unit) then
                    Status.InternalPrioList[ListEntry] = i;
                end

            else -- if ListEntry is not a string, then it's a number
                 -- representing the groups or the classes

                Status.InternalPrioList[ListEntry] = i;
            end
        end

        -- Get a cleaned skip list
        for i, ListEntry in ipairs(self.profile.SkipList) do
            if (type(ListEntry) == "string") then
                unit = GUIDToUnit[ListEntry];
                if (unit) then
                    Status.InternalSkipList[ListEntry] = i;
                end
            else
                Status.InternalSkipList[ListEntry] = i;
            end
        end
        lookforpets = true;


        -- if we are not in a raid but in a party
        if (raidnum == 0) then
            currentGroup = 1; -- this is used to compute the default priorities
            -- Add the player to the main list if needed
            if not IsInSkipOrPriorList(MyGUID, false, DC.ClassUNameToNum[DC.MyClass]) then
                -- the player is not in a priority state, add to default prio
                SortingTable["player"] = 900;
                Status.Unit_Array_GUIDToUnit[MyGUID] = "player";


            elseif not IsInSkipList(MyGUID, false, DC.ClassUNameToNum[DC.MyClass]) then
                -- The player is contained within a priority rule
                SortingTable["player"] =      GetUnitPriority ("player", 1, 1, DC.MyClass );
                Status.Unit_Array_GUIDToUnit[MyGUID] = "player";

            end

            local unit = "";

            -- add the party members and their pets... if they exist
            for i = 1, 4 do
                unit = "party"..i;

                if (UnitExists(unit)) then

                    pGUID = UnitToGUID[unit];

                    if (not pGUID) then -- at logon sometimes pGUID is nil...
                        pGUID = unit;
                    end

                    -- check the GUID to see if we skip
                    if (not IsInSkipList(pGUID, nil, DC.ClassUNameToNum[(select(2, UnitClass(unit)))])) then

                        Status.Unit_Array_GUIDToUnit[pGUID] = unit;

                        SortingTable[unit] =      GetUnitPriority (unit, i + 1, 1, (select(2, UnitClass(unit)) ) );

                    end

                    if ( self.profile.Scan_Pets ) then

                        pet = "partypet"..i;

                        if (UnitExists(pet)) then
                            pGUID = UnitToGUID[pet];

                            if (not pGUID) then -- at logon sometimes pGUID is nil...
                                pGUID = pet;
                            end

                            SortingTable[pet] =      GetUnitPriority (pet, i + 1, 1, (select(2, UnitClass(pet))), true);
                            Status.Unit_Array_GUIDToUnit[pGUID] = pet;
                        end
                    end
                end
            end
        end

        -- add our own pet
        if ( self.profile.Scan_Pets ) then
            if (UnitExists("pet")) then
                SortingTable["pet"] =                  -900;
                Status.Unit_Array_GUIDToUnit[UnitToGUID["pet"]] = "pet";
            end
        end

        if ( raidnum > 0 ) then -- if we are in a raid
            currentGroup = 0;
            local rName, rGroup, rClass, GUID;
            local CaheID = 1; -- make an ordered table
            local excluded = 0;
            local playerPrio = 900;

            -- Cache the raid roster info eliminating useless info and already listed members
            for i = 1, MAX_RAID_MEMBERS do
                rName, _, rGroup, _, _, rClass = GetRaidRosterInfo(i);
                GUID =  UnitToGUID["raid"..i];

                -- add all except member to skip
                if not IsInSkipList(GUID, rGroup, DC.ClassUNameToNum[rClass]) then

                    if (rName) then -- (at log-in GetRaidRosterInfo() returns garbage)

                        if (not RaidRosterCache[CaheID]) then
                            RaidRosterCache[CaheID] = {};
                        end

                        RaidRosterCache[CaheID].rName    = rName;
                        RaidRosterCache[CaheID].rGroup   = rGroup;
                        RaidRosterCache[CaheID].rClass   = rClass;
                        RaidRosterCache[CaheID].rIndex   = i;
                        RaidRosterCache[CaheID].rGUID    = GUID;
                        CaheID = CaheID + 1;
                    end
                else
                    excluded = excluded + 1;
                end

                -- find our group (a whole iteration is required, raid info are not ordered) -- wrong, the player is always the last now but never trust Blizzard...
                if currentGroup==0 and GUID == MyGUID then -- anyway they do the same thing in PlayerFrame.lua...
                    currentGroup = rGroup;
                    playerPrio = GetUnitPriority ("player", i, rGroup, rClass, false);
                end

                if CaheID + excluded > raidnum then -- we found all the units
                    RaidRosterCache[CaheID] = false;
                    break;
                end
            end

            -- Add the player to the main list if needed
            if (not IsInSkipOrPriorList(MyGUID, currentGroup, DC.ClassUNameToNum[DC.MyClass])) then
                SortingTable["player"] =           900;
                Status.Unit_Array_GUIDToUnit[MyGUID] =  "player";
            else -- well let's see if people complains that they cannot exclude themself...
                SortingTable["player"] =    playerPrio;
                Status.Unit_Array_GUIDToUnit[MyGUID] =  "player";
            end

            -- Now we have a cache without the units we want to skip
            local TempID;
            for _, raidMember in ipairs(RaidRosterCache) do

                if not raidMember then break; end;

                -- put each raid member with the right priority in our sorting table
                if not Status.Unit_Array_GUIDToUnit[raidMember.rGUID] then

                    TempID = "raid"..raidMember.rIndex;

                    SortingTable[TempID] =                 GetUnitPriority (TempID, raidMember.rIndex, raidMember.rGroup, raidMember.rClass, false);
                    Status.Unit_Array_GUIDToUnit[raidMember.rGUID] = TempID;
                end

                if ( self.profile.Scan_Pets ) then
                    local pet = "";
                    pet = "raidpet"..raidMember.rIndex;

                    if ( UnitExists(pet) ) then

                        pGUID = UnitToGUID[pet];

                        if (not pGUID) then -- at logon sometimes pGUID is nil...
                            pGUID = pet;
                        end

                        -- add it only if not already in (could be the player pet...)
                        if (not Status.Unit_Array_GUIDToUnit[pGUID]) then
                            SortingTable[pet] =      GetUnitPriority (pet, raidMember.rIndex, raidMember.rGroup, (select(2,UnitClass(pet))), true);
                            Status.Unit_Array_GUIDToUnit[pGUID] = pet;
                        end
                    end

                end

            end

        end -- END if we are in a raid

        -- NEW focus management
        -- there is a focus and its not hostile in the first place
        if UnitExists("focus") and (not UnitCanAttack("focus", "player") or UnitIsFriend("focus", "player")) then
            pGUID = UnitToGUID["focus"]
            -- the unit is not registered somewhere else yet
            if not Status.Unit_Array_GUIDToUnit[pGUID] then
                SortingTable["focus"] =      -1; -- add it at the end...
                Status.Unit_Array_GUIDToUnit[pGUID] = "focus";
            end
        end

        -- we use a hash-key style table for Status.Unit_Array_GUIDToUnit because it allows us
        -- to not care if we add a same unit several times (speed optimization)
        -- but we cannot use sort unless indexes are integer so:
        Status.Unit_Array = {}
        local GUID;
        for GUID, unit in pairs(Status.Unit_Array_GUIDToUnit) do -- /!\ PAIRS not iPAIRS
            t_insert(Status.Unit_Array, unit);

            Status.Unit_Array_UnitToGUID[unit] = GUID; -- just a useful table, not used here :)
        end

        table.sort(Status.Unit_Array, function (a,b)
            if (not (SortingTable[a] < 0 and SortingTable[b] < 0)) then -- one of the values is > 0
                return SortingTable[b] < SortingTable[a];
            else                                                        -- both are < 0
                return SortingTable[a] < SortingTable[b];
            end
        end);


        Status.UnitNum = #Status.Unit_Array;

        UnitToGUID = {};
        GUIDToUnit = {};
        D.Status.GroupUpdatedOn = D:NiceTime(); -- It's used in UNIT_AURA event handler to trigger a rescan if the array is found inacurate

        self:Debug ("|cFFFF44FF-->|r Update complete!", Status.UnitNum);
        return;
    end

    function D:GetFakeUnit_array ()

        if not D.Status.TestLayout then
            return;
        end

        self:Debug ("|cFFFF22FF-->|r Creating fake Units Array");

        local Status = self.Status;
        Status.Unit_Array_GUIDToUnit[DC.MyGUID] =  "player";

        Status.Unit_Array = {}

        for i = 1, D.Status.TestLayoutUNum - 1 do -- the player is always in so we remove one here.
            Status.Unit_Array_GUIDToUnit["raid" .. i .. "GUID"] = "raid" .. i;
        end

        local GUID;
        for GUID, unit in pairs(Status.Unit_Array_GUIDToUnit) do -- /!\ PAIRS not iPAIRS
            t_insert(Status.Unit_Array, unit);

            Status.Unit_Array_UnitToGUID[unit] = GUID; -- just a useful table, not used here :)
        end

        table.sort(Status.Unit_Array);

        Status.UnitNum = #Status.Unit_Array;
        D.Status.GroupUpdatedOn = D:NiceTime(); -- It's used in UNIT_AURA event handler to trigger a rescan if the array is found inacurate

    end

end

--}}}

-------------------------------------------------------------------------------
T._LoadedFiles["Dcr_Raid.lua"] = "2.5.1-6-gd3885c5";

-- "Your God is dead and no one cares"
-- "If there is a Hell I'll see you there"
