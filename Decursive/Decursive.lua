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
if not T._LoadedFiles or not T._LoadedFiles["Dcr_Raid.lua"] then
    if not DecursiveInstallCorrupted then T._FatalError("Decursive installation is corrupted! (Dcr_Raid.lua not loaded)"); end;
    DecursiveInstallCorrupted = true;
    return;
end

local D = Dcr;
--D:SetDateAndRevision("$Date: 2008-09-16 00:25:13 +0200 (mar., 16 sept. 2008) $", "$Revision: 81755 $");

local L = D.L;
local LC = D.LC;
local DC = DcrC;
local DS = DC.DS;
-------------------------------------------------------------------------------

local pairs             = _G.pairs;
local ipairs            = _G.ipairs;
local type              = _G.type;
local table             = _G.table;
local t_sort            = _G.table.sort;
local PlaySoundFile     = _G.PlaySoundFile;
local UnitName          = _G.UnitName;
local UnitDebuff        = _G.UnitDebuff;
local UnitBuff          = _G.UnitBuff;
local UnitIsCharmed     = _G.UnitIsCharmed;
local UnitCanAttack     = _G.UnitCanAttack;
local UnitClass         = _G.UnitClass;
local UnitExists        = _G.UnitExists;
local GetNetStats       = _G.GetNetStats;
local _;

-------------------------------------------------------------------------------
-- The UI functions {{{
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- The printing functions {{{
-------------------------------------------------------------------------------

function D:Show_Cure_Order() --{{{
    self:Println("printing cure order:");
    for index, unit in ipairs(self.Status.Unit_Array) do
        self:Println( unit, " - ", self:MakePlayerName((self:UnitName(unit))) , " Index: ", index);
    end
end --}}}

-- }}}
-------------------------------------------------------------------------------

-- Show Hide FUNCTIONS -- {{{

function D:ShowHideLiveList(hide) --{{{

    if not D.DcrFullyInitialized then
        return;
    end

    -- if hide is requested or if hide is not set and the live-list is shown
    if (hide==1 or (not hide and DcrLiveList:IsVisible())) then
        D.profile.Hide_LiveList = true;
        DcrLiveList:Hide();
        D:CancelDelayedCall("Dcr_LLupdate");
    else
        D.profile.Hide_LiveList = false;
        DcrLiveList:ClearAllPoints();
        DcrLiveList:SetPoint("TOPLEFT", "DecursiveMainBar", "BOTTOMLEFT");
        DcrLiveList:Show();

        D:ScheduleRepeatedCall("Dcr_LLupdate", D.LiveList.Update_Display, D.profile.ScanTime, D.LiveList);
    end

end --}}}

-- This functions hides or shows the "Decursive" bar depending on its current
-- state, it's also able hide/show the live-list if the "tie live-list" option is active
function D:HideBar(hide) --{{{

    if not D.DcrFullyInitialized then
        return;
    end

    if (hide==1 or (not hide and DecursiveMainBar:IsVisible())) then
        if (D.profile.LiveListTied) then
            D:ShowHideLiveList(1);
        end
        D.profile.Hidden = true;
        DecursiveMainBar:Hide();
    else
        if (D.profile.LiveListTied) then
            D:ShowHideLiveList(0);
        end
        D.profile.Hidden = false;
        DecursiveMainBar:Show();
    end

    if DecursiveMainBar:IsVisible() and DcrLiveList:IsVisible() then
        DcrLiveList:ClearAllPoints();
        DcrLiveList:SetPoint("TOPLEFT", "DecursiveMainBar", "BOTTOMLEFT");
    else
        D:ColorPrint(0.3, 0.5, 1, L["SHOW_MSG"]);
    end

    LibStub("AceConfigRegistry-3.0"):NotifyChange(D.name);
end --}}}

function D:ShowHidePriorityListUI() --{{{

    if not D.DcrFullyInitialized then
        return;
    end

    if (DecursivePriorityListFrame:IsVisible()) then
        DecursivePriorityListFrame:Hide();
    else
        DecursivePriorityListFrame:Show();
    end
end --}}}

function D:ShowHideSkipListUI() --{{{
    
    if not D.DcrFullyInitialized then
        return;
    end

    if (DecursiveSkipListFrame:IsVisible()) then
        DecursiveSkipListFrame:Hide();
    else
        DecursiveSkipListFrame:Show();
    end
end --}}}

-- This shows/hides the buttons near the "Decursive" bar
function D:ShowHideButtons(UseCurrentValue) --{{{

    if not D.DcrFullyInitialized then
        return;
    end

    if not D.profile then
        return;
    end


    local DcrFrame = "DecursiveMainBar";
    local buttons = {
        DcrFrame .. "Priority",
        DcrFrame .. "Skip",
        DcrFrame .. "Hide",
    }

    local DCRframeObject = _G[DcrFrame];

    if (not UseCurrentValue) then
        D.profile.HideButtons = (not D.profile.HideButtons);
    end

    for _, ButtonName in pairs(buttons) do
        local Button = _G[ButtonName];

        if (D.profile.HideButtons) then
            Button:Hide();
            DCRframeObject.isLocked = 1;
        else
            Button:Show();
            DCRframeObject.isLocked = 0;
        end

    end

end --}}}

-- }}}


-- this resets the location of the windows
function D:ResetWindow() --{{{

    DecursiveMainBar:ClearAllPoints();
    DecursiveMainBar:SetPoint("CENTER", UIParent);
    DecursiveMainBar:Show();

    DcrLiveList:ClearAllPoints();
    DcrLiveList:SetPoint("TOPLEFT", DecursiveMainBar, "BOTTOMLEFT");
    DcrLiveList:Show();

    DecursivePriorityListFrame:ClearAllPoints();
    DecursivePriorityListFrame:SetPoint("CENTER", UIParent);

    DecursiveSkipListFrame:ClearAllPoints();
    DecursiveSkipListFrame:SetPoint("CENTER", UIParent);

    DecursivePopulateListFrame:ClearAllPoints();
    DecursivePopulateListFrame:SetPoint("CENTER", UIParent);

    D.MFContainer:ClearAllPoints();
    D.MFContainer:SetPoint("CENTER", UIParent, "CENTER", 0, 0);

    DecursiveAnchor:ClearAllPoints();
    DecursiveAnchor:SetPoint("TOP", UIErrorsFrame, "BOTTOM", 0, 0);

end --}}}


function D:PlaySound (UnitID, Caller) --{{{
    if self.profile.PlaySound and not self.Status.SoundPlayed then
        local Debuffs = self:UnitCurableDebuffs(UnitID, true);
        if Debuffs and Debuffs[1] and Debuffs[1].Type then

            -- good sounds: Sound\\Doodad\\BellTollTribal.wav
            --          Sound\\interface\\AuctionWindowOpen.wav
            --          Sound\\interface\\AlarmClockWarning3.wav
            PlaySoundFile(self.profile.SoundFile);
            self:Debug("Sound Played! by %s", Caller);
            self.Status.SoundPlayed = true;
        else
            self.UnitDebuffed[UnitID] = false;
        end
    end
end --}}}

-- LIVE-LIST DISPLAY functions {{{



-- Those set the scalling of the LIVELIST container
-- SACALING FUNCTIONS {{{
-- Place the LIVELIST container according to its scale
function D:PlaceLL () -- {{{
    local UIScale       = UIParent:GetEffectiveScale()
    local FrameScale    = DecursiveMainBar:GetEffectiveScale();
    local x, y = D.profile.MainBarX, D.profile.MainBarY;

    -- check if the coordinates are correct
    if x and y and (x + 10 > UIParent:GetWidth() * UIScale or x < 0 or (-1 * y + 10) > UIParent:GetHeight() * UIScale or y > 0) then
        x = false; -- reset to default position
        T._FatalError("Decursive's bar position reset to default");
    end

    -- Executed for the very first time, then put it in the top right corner of the screen
    if (not x or not y) then
        x =    (UIParent:GetWidth()  * UIScale) / 2;
        y =  - (UIParent:GetHeight() * UIScale) / 8;

        D.profile.MainBarX = x;
        D.profile.MainBarY = y;
    end

    -- set to the scaled position
    DecursiveMainBar:ClearAllPoints();
    DecursiveMainBar:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x/FrameScale , y/FrameScale);
    DcrLiveList:ClearAllPoints();
    DcrLiveList:SetPoint("TOPLEFT", DecursiveMainBar, "BOTTOMLEFT");
end -- }}}

-- Save the position of the frame without its scale
function D:SaveLLPos () -- {{{
    if self.profile and DecursiveMainBar:IsVisible() then
        -- We save the unscalled position (no problem if the sacale is changed behind our back)
        self.profile.MainBarX = DecursiveMainBar:GetEffectiveScale() * DecursiveMainBar:GetLeft();
        self.profile.MainBarY = DecursiveMainBar:GetEffectiveScale() * DecursiveMainBar:GetTop() - UIParent:GetHeight() * UIParent:GetEffectiveScale();

        
        if self.profile.MainBarX < 0 then
            self.profile.MainBarX = 0;
        end

        if self.profile.MainBarY > 0 then
            self.profile.MainBarY = 0;
        end

    end
end -- }}}

-- set the scaling of the LIVELIST container according to the user settings
function D:SetLLScale (NewScale) -- {{{
    
    -- save the current position without any scaling
    D:SaveLLPos ();
    -- Set the new scale
    DecursiveMainBar:SetScale(NewScale);
    DcrLiveList:SetScale(NewScale);
    -- Place the frame adapting its position to the news cale
    D:PlaceLL ();
    
end -- }}}
-- }}}


-- }}}

-- // }}}
-------------------------------------------------------------------------------

do
   local iterator = 1;
   local DebuffHistHashTable = {};

   function D:Debuff_History_Add( DebuffName, DebuffType )

       if not DebuffHistHashTable[DebuffName] then

           -- reset iterator if out of boundaries
           if iterator > DC.DebuffHistoryLength then
               iterator = 1;
           end

           -- clean hastable if necessary before adding a new entry
           if DebuffHistHashTable[D.DebuffHistory[iterator]] then
               DebuffHistHashTable[D.DebuffHistory[iterator]] = nil;
           end

           -- Register the name in the HashTable using the debuff type
           DebuffHistHashTable[DebuffName] = (DebuffType and DC.NameToTypes[DebuffType] or DC.NOTYPE);
           --D:Debug(DebuffName, DebuffHistHashTable[DebuffName]);

           -- Put this debuff in our history
           D.DebuffHistory[iterator] = DebuffName;

           -- This is a useless comment
           iterator = iterator + 1;
       end

   end

   function D:Debuff_History_Get (Index, Colored)

       local HumanIndex = iterator - Index;

       if HumanIndex < 1 then
           HumanIndex = HumanIndex + DC.DebuffHistoryLength;
       end

       if not D.DebuffHistory[HumanIndex] then
           return "|cFF777777Empty|r", false;
       end

       if Colored then
           --D:Debug(D.DebuffHistory[HumanIndex], DebuffHistHashTable[D.DebuffHistory[HumanIndex]]);
           return D:ColorText(D.DebuffHistory[HumanIndex], "FF" .. DC.TypeColors[DebuffHistHashTable[D.DebuffHistory[HumanIndex]]]), true;
       else
           return D.DebuffHistory[HumanIndex], true;
       end
   end

end

-- Scanning functionalities {{{
-------------------------------------------------------------------------------

do

    local Name, rank, Texture, Applications, TypeName, Duration, expirationTime;
    local D = _G.Dcr;
    local UnitAura = _G.UnitAura;

    -- This function only returns interesting values of UnitDebuff()
    local function GetUnitDebuff  (Unit, i) --{{{

        if D.LiveList.TestItemDisplayed and i == 1 and Unit ~= "target" and Unit ~= "mouseover" and UnitExists(Unit) then
            D:Debug("|cFFFF0000Setting test debuff for %s (debuff %d)|r", Unit, i);
            return "Test item", DC.TypeNames[D.Status.ReversedCureOrder[1]], 2, "Interface\\AddOns\\Decursive\\iconON.tga", D.LiveList.TestItemDisplayed + 70;
        end

        --D:Debug("|cFFFF0000Getting debuffs for %s , id = %d|r", Unit, i);


        --    Name, rank, Texture, Applications, TypeName, duration, expirationTime, unitCaster, isStealable = UnitAura("unit", index or ["name", "rank"][, "filter"])

        local Name, rank, Texture, Applications, TypeName, Duration, expirationTime = UnitAura(Unit, i, "HARMFUL");

        --local Name, rank, Texture, Applications, TypeName, Duration = UnitDebuff(Unit, i);

        if Name then
            return Name, TypeName, Applications, Texture, expirationTime;
        else
            return false, false, false, false, false;
        end
    end --}}}

    -- there is a known maximum number of unit and a known maximum debuffs per unit so lets allocate the memory needed only once. Memory will be allocated when needed and re-used...
    local DebuffUnitCache = {};

    -- Variables are declared outside so that Lua doesn't initialize them at each call
    local Name, Type, i, StoredDebuffIndex, CharmFound, IsCharmed;

    local DcrC = DcrC; -- for faster access

    local UnitIsCharmed = _G.UnitIsCharmed;
    local UnitCanAttack = _G.UnitCanAttack;
    local GetTime       = _G.GetTime;
    local IsSpellInRange    = _G.IsSpellInRange;

    -- This is the core debuff scanning function of Decursive
    -- This function does more than just reporting Debuffs. it also detects charmed units

    function D:GetUnitDebuffAll (Unit) --{{{

        -- create a Debuff table for this unit if there is not already one
        if (not DebuffUnitCache[Unit]) then
            DebuffUnitCache[Unit] = {};
        end

        -- This is just a shortcut for easier readability
        local ThisUnitDebuffs = DebuffUnitCache[Unit];

        i = 1;                  -- => to index all debuffs
        StoredDebuffIndex = 1;  -- => this index only debuffs with a type
        CharmFound = false;     -- => avoid to find that the unit is charmed again and again...


        -- test if the unit is mind controlled once
        if (UnitIsCharmed(Unit) and (UnitCanAttack("player", Unit) or UnitIsCharmed("player"))) then
            IsCharmed = true;
        else
            IsCharmed = false;
        end

        -- iterate all available debuffs
        while (true) do
            Name, TypeName, Applications, Texture, expirationTime = GetUnitDebuff(Unit, i);

            if not Name then
                break;
            end

        
            -- test for a type (Magic Curse Disease or Poison)
            if (TypeName and TypeName ~= "") then
                Type = DC.NameToTypes[TypeName];
            else
                Type = false;
            end

            -- implement the test for DominateMind I HATE stupid exceptions like this one... so many hours lost because of this :/
            --[=[
            if Name == DS["YOGGG_DOMINATE_MIND"] and Type == DC.MAGIC then

                if DC.MyClass == "PALADIN" then
                    IsCharmed = false;
                    CharmFound = false;
                else
                    IsCharmed = true;
                end

                if DC.MyClass == "PALADIN" or DC.MyClass == "SHAMAN" then

                    YoggReport = true;

                    D:AddDebugText("|cFFFF9955Decursive Yoggy Debug (try 6):|r", Unit, TypeName, Applications,
                    "PC:",DC.MyClass,"IsOvering:", self.Status.MouseOveringMUF, "DN",i, "SDi",StoredDebuffIndex,
                    "UICp:",UnitIsCharmed( "player"), "UICu:",UnitIsCharmed(Unit),
                    "UCApu:",UnitCanAttack("player", Unit), "IsCharmed:", IsCharmed
                    -- "UCAup:",UnitCanAttack(Unit, "player"), "UCApu:",UnitCanAttack("player", Unit), "UIFpu:",UnitIsFriend( "player", Unit), "UIEpu:",UnitIsEnemy( "player", Unit)
                    );
                end

            end
            --]=]

            -- if the unit is charmed and we didn't took care of this information yet
            if IsCharmed and (not CharmFound or Type == DC.MAGIC) then
                -- If the unit has a magical debuff and we can cure it
                -- (note that the target is not friendly in that case)
                if (Type == DC.MAGIC and self.Status.CuringSpells[DC.ENEMYMAGIC]) then
                    Type = DC.ENEMYMAGIC;

                    -- NOTE: if a unit is charmed and has another magical debuff
                    -- this block will be executed...
                else -- the unit doesn't have a magical debuff or we can't remove magical debuffs
                    Type = DC.CHARMED; -- The player can't remove it anyway so just say the unit is afflicted by a charming effect
                    TypeName = DC.TypeNames[DC.CHARMED];
                end
                CharmFound = true;
            end

            --[=[
            if YoggReport then
                local IsInRange;
                if self.Status.CuringSpells[Type] then
                    IsInRange = IsSpellInRange(self.Status.CuringSpells[Type], Unit)
                end
                D:AddDebugText("CharmFound:", CharmFound, "TN:", DC.TypeNames[Type], "ISIR", IsInRange);
            end
            --]=]


            -- If we found a type, register the Debuff
            if (Type) then
                -- Create a Debuff index entry if necessary
                if (not ThisUnitDebuffs[StoredDebuffIndex]) then
                    ThisUnitDebuffs[StoredDebuffIndex] = {};
                end

                ThisUnitDebuffs[StoredDebuffIndex].expirationTime = expirationTime;
                ThisUnitDebuffs[StoredDebuffIndex].Texture        = Texture;
                ThisUnitDebuffs[StoredDebuffIndex].Applications   = Applications;
                ThisUnitDebuffs[StoredDebuffIndex].TypeName       = TypeName;
                ThisUnitDebuffs[StoredDebuffIndex].Type           = Type;
                ThisUnitDebuffs[StoredDebuffIndex].Name           = Name;
                ThisUnitDebuffs[StoredDebuffIndex].index          = i;

                -- we can't use i, else we wouldn't have contiguous indexes in the table
                StoredDebuffIndex = StoredDebuffIndex + 1;
            end

            i = i + 1;
        end

        -- erase remaining unused entries without freeing the memory (less garbage)
        while (ThisUnitDebuffs[StoredDebuffIndex]) do
            ThisUnitDebuffs[StoredDebuffIndex].Type = false;
            StoredDebuffIndex = StoredDebuffIndex + 1;
        end

        -- if no debuff on the unit then it can't be charmed... FUCKING LAG!!
        if i == 1 then
            IsCharmed = false;
        end

        return ThisUnitDebuffs, IsCharmed;
    end --}}}
end


do
    -- see the comment about DebuffUnitCache
    local ManagedDebuffUnitCache = D.ManagedDebuffUnitCache;


    local D = D;
    local _ = false;
    local CureOrder;
    local sorting = function (a, b)

        CureOrder = D.classprofile.CureOrder; -- LUA is too simple, lets do the access optimization...

        local cura = (a.Type and CureOrder[a.Type] and CureOrder[a.Type] > 0) and CureOrder[a.Type] or 1024;
        local curb = (b.Type and CureOrder[b.Type] and CureOrder[b.Type] > 0) and CureOrder[b.Type] or 1024;

        return cura < curb;
    end

    -- This function will return a table containing only the Debuffs we can cure excepts the one we have to ignore
    -- in different conditions.
    function D:UnitCurableDebuffs (Unit, JustOne) -- {{{

        if not Unit then
            self:Debug("No unit supplied to UnitCurableDebuffs()");
            return false;
        end

        if (not ManagedDebuffUnitCache[Unit]) then
            ManagedDebuffUnitCache[Unit] = {};
        end

        local AllUnitDebuffs, IsCharmed = self:GetUnitDebuffAll(Unit); -- always return a table, may be empty though

        if not (AllUnitDebuffs[1] and AllUnitDebuffs[1].Type ) then -- if there is no curable debuff (a debuff with a type)
            return false, IsCharmed;
        end

        local Spells    = self.Status.CuringSpells; -- shortcut to available spells by debuff type


        local ManagedDebuffs = ManagedDebuffUnitCache[Unit]; -- shortcut for readability

        --self:Debug("Debuffs were found");

        local DebuffNum = 1; -- number of found debuff (used for indexing)

        local continue_ = true; -- if we have to ignore a debuff, this will become false



        for _, Debuff in ipairs(AllUnitDebuffs) do

            if (not Debuff.Type) then -- useless test, only debuffs with a type are returned...
                break;
            end
            continue_ = true;

            -- test if we have to ignore this debuf  {{{ --
            
            if self.Status.PlayerOnlyTypes[Debuff.Type] and Unit ~= "player" then -- if this type is curable on the player only
                continue_ = false;
            end
            
            if (self.profile.DebuffsToIgnore[Debuff.Name]) then
                -- these are the BAD ones... the ones that make the target immune... abort this unit
                --D:Debug("UnitCurableDebuffs(): %s is ignored", Debuff.Name);
                break; -- exit here
            end

            if (self.profile.BuffDebuff[Debuff.Name]) then
                -- these are just ones you don't care about (sleepless deam etc...)
                continue_ = false;
                --D:Debug("UnitCurableDebuffs(): %s is not a real debuff", Debuff.Name);
            end

            if (self.Status.Combat or self.profile.DebuffAlwaysSkipList[Debuff.Name]) then
                local _, EnUClass = UnitClass(Unit);
                if (self.profile.skipByClass[EnUClass]) then
                    if (self.profile.skipByClass[EnUClass][Debuff.Name]) then
                        -- these are just ones you don't care about by class while in combat

                        -- This lead to a problem because once the fight is finished there are no event to trigger
                        -- a rescan of this unit, so the debuff does not appear...

                        -- solution to the above problem:

                        if not self.profile.DebuffAlwaysSkipList[Debuff.Name] then
                            self:AddDelayedFunctionCall("ReScan"..Unit, D.MicroUnitF.UpdateMUFUnit, D.MicroUnitF, Unit);
                        end
                        
                        D:Debug("UnitCurableDebuffs(): %s is configured to be skipped", Debuff.Name);
                        continue_ = false;
                    end
                end
            end

            -- }}}

            
            if continue_ then
                --      self:Debug("Debuffs matters");
                -- If we are still here it means that this Debuff is something not to be ignored...


                -- We have a match for this type and we decided (checked) to
                -- cure it NOTE: self.classprofile.CureOrder[DEBUFF_TYPE] is set
                -- to FALSE when the type is unchecked and to < 0 when there is
                -- no spell available for the type or when the spell is gone
                -- (it happens for warlocks or when using the same profile with
                -- several characters)
                --if (self.classprofile.CureOrder[Debuff.Type] and self.classprofile.CureOrder[Debuff.Type] > 0) then
                if (self:GetCureCheckBoxStatus(Debuff.Type)) then


                    -- self:Debug("we can cure it");

                    -- if we do have a spell to cure
                    if (Spells[Debuff.Type]) then
                        -- The user doesn't want to cure a unit afllicted by poison or disease if the unit
                        -- is beeing cured by an abolish spell

                        if (self.profile.Check_For_Abolish and (Debuff.Type == DC.POISON and self:CheckUnitForBuffs(Unit, DS["SPELL_ABOLISH_POISON"]) or Debuff.Type == DC.DISEASE and self:CheckUnitForBuffs(Unit, DS["SPELL_ABOLISH_DISEASE"]))) then
                            self:Debug("Abolish buff found, skipping");
                        else
                            -- self:Debug("It's managed");

                            -- create an entry for this debuff index if necessary
                            if (not ManagedDebuffs[DebuffNum]) then
                                ManagedDebuffs[DebuffNum] = {};
                            end

                            -- copy the debuff information to this table.
                            self:tcopy(ManagedDebuffs[DebuffNum], Debuff);

                            DebuffNum = DebuffNum + 1;

                            -- the live-list only reports the first debuf found and set JustOne to true
                            if (JustOne) then
                                break;
                            end
                        end
                    end
                end
            end
        end -- for END

        -- erase unused entries without freeing the memory (less garbage)
        if (not JustOne or DebuffNum == 1)  then -- if JustOne is set don't clear anything except if we found nothing
            while (ManagedDebuffs[DebuffNum]) do
                ManagedDebuffs[DebuffNum].Type = false;
                -- ManagedDebuffs[DebuffNum].TimeStamp = false;
                DebuffNum = DebuffNum + 1;
            end
        end

        -- sort the table only if it's not 'empty' and only if there is at least two debuffs
        if (ManagedDebuffs[1] and ManagedDebuffs[1].Type) then

            -- order Debuffs according to type priority order
            if (not JustOne and ManagedDebuffs[2] and ManagedDebuffs[2].Type) then
                t_sort(ManagedDebuffs, sorting); -- uses memory..
            end
            return ManagedDebuffs, IsCharmed;
        else
            return false, IsCharmed;
        end

    end -- // }}}

    local GetTime       = _G.GetTime;
    local Debuffs       = {}; local IsCharmed = false; local Unit; local MUF; local IsDebuffed= false; local CheckStealth = false;
    local NoScanStatuses        = false;
    function D:ScanEveryBody()

        if not NoScanStatuses then
            NoScanStatuses = {[DC.ABSENT] = true, [DC.FAR] = true, [DC.BLACKLISTED] = true};
        end

        local UnitArray = self.Status.Unit_Array; local i = 1;
        local CheckStealth = self.profile.Show_Stealthed_Status;

        --[===[@debug@
        local start = GetTime();
        --@end-debug@]===]

        while UnitArray[i] do
            Unit = UnitArray[i];
            MUF = self.MicroUnitF.UnitToMUF[Unit];

            if MUF and not NoScanStatuses[MUF.UnitStatus] then
                Debuffs, IsCharmed = self:UnitCurableDebuffs(Unit, true);

                if CheckStealth then
                    self.Stealthed_Units[Unit] = self:CheckUnitStealth(Unit); -- update stealth status
                end

                IsDebuffed = (Debuffs and true) or IsCharmed;
                -- If MUF disagrees
                if IsDebuffed ~= MUF.IsDebuffed and not D:DelayedCallExixts("Dcr_Update" .. Unit) then
                    --[===[@debug@
                    if IsDebuffed then
                        self:AddDebugText("delayed debuff found by scaneveryone, scheduling analysis in 1s");
                        --D:ScheduleDelayedCall("Dcr_lateanalysis" .. Unit, self.MicroUnitF.LateAnalysis, 1, self.MicroUnitF, "ScanEveryone", Debuffs, MUF, MUF.UnitStatus);
                    else
                        self:AddDebugText("delayed UNdebuff found by scaneveryone on", Unit);
                    end
                    --@end-debug@]===]

                    self.MicroUnitF:UpdateMUFUnit(Unit, true);

                    --[===[@debug@
                    D:Println("HAAAAAAA!!!!!");
                    --@end-debug@]===]
                end
            end

            i = i + 1;
        end
        --[===[@debug@
        --D:Debug("|cFF777777Scanning everybody...", i - 1, "units scanned in ", GetTime() - start, "seconds|r");
        --@end-debug@]===]
    end


    -- a little test... the ".." way wins (6x faster than the format solution) when both sides are strings
    function D:tests()

        local test = "test1";
        local start = GetTime();
        local strings = {"string1", "string2", "strring3"};
        local teststring = "unitraid5"
        for i =1, 1000000 do
            teststring = strings[i%3 + 1];
            test = "test_"..teststring;
        end
        D:Debug("pass (\"\".. completed in:", GetTime() - start, test);

        start = GetTime();
        for i =1, 1000000 do
            local t = strings[i%3 + 1];
            test = ("test_%s"):format(teststring);
        end
        D:Debug("pass format completed in:", GetTime() - start, test);

    end

end

local UnitBuffsCache    = {};

-- this function returns true if one of the debuff(s) passed to it is found on the specified unit
function D:CheckUnitForBuffs(Unit, BuffNamesToCheck) --{{{

    -- --[=[
    if (not UnitBuffsCache[Unit]) then
        UnitBuffsCache[Unit] = {};
    end

    local UnitBuffs     = UnitBuffsCache[Unit];
    local i             = 1;
    local buff_name     = "";

    -- Get all the unit's buffs
    while true do

        buff_name = UnitBuff(Unit, i)

        if not buff_name then
            break;
        end

        UnitBuffs[i] = buff_name;
        i = i + 1;
    end

    while UnitBuffs[i] do -- clean the rest of the cache
        UnitBuffs[i] = false;
        i = i + 1;
    end
    --]=]

    if type(BuffNamesToCheck) ~= "table" then

        if self:tcheckforval(UnitBuffs, BuffNamesToCheck) then
            return true;
        else
            return false;
        end
    else
        local Buff;
        for _, Buff in pairs(BuffNamesToCheck) do

            if self:tcheckforval(UnitBuffs, Buff) then
                return true;
            end

        end
    end

    return false;

end --}}}


D.Stealthed_Units = {};

do
    local Stealthed = {DS["Prowl"], DS["Stealth"], DS["Shadowmeld"],  DS["Invisibility"], DS["Lesser Invisibility"]}; --, DS["Ice Armor"],};

    DC.IsStealthBuff = D:tReverse(Stealthed);

    function D:CheckUnitStealth(Unit)
        if self:CheckUnitForBuffs(Unit, Stealthed) then
            --      self:Debug("Sealth found !");
            return true;
        end
        return false;
    end
end
-- }}}



T._LoadedFiles["Decursive.lua"] = "2.5.1-6-gd3885c5";

-- Sin
