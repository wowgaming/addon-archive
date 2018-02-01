--[[
-- Name: TinyTipBasic
-- Author: Thrae of Maelstrom (aka "Matthew Carras")
-- Release Date:
-- Release Version: 2.0
--
-- Thanks to #wowace, #dongle, and #wowi-lounge on Freenode as always for
-- optimization assistance. Thanks to AF_Tooltip_Mini for the idea that
-- became TinyTip.
--
-- Note: If running TinyTipBasic without TinyTipOptions, see
-- StandAloneConfig.lua for manual configuration options.
--]]

local _G = getfenv(0)

--[[---------------------------------------------
-- Local References
----------------------------------------------]]
local strformat, strfind = string.format, string.find
local UIParent, GameTooltip = _G.UIParent, _G.GameTooltip
local GameTooltipTextLeft1, GameTooltipTextLeft2 = _G.GameTooltipTextLeft1, _G.GameTooltipTextLeft2
local UnitName, UnitIsPlayer, GetPVPRankInfo, UnitPVPRank, UnitIsPVP, GetGuildInfo, UnitPlayerControlled, UnitReaction, UnitIsTapped, UnitIsTappedByPlayer, UnitCanAttack, GetNumFriends, GetFriendInfo, IsInGuild, UnitLevel, UnitFactionGroup, GetQuestGreenRange, UnitRace, UnitClass, UnitClassification, UnitCreatureFamily, UnitCreatureType, UnitIsSameServer = UnitName, UnitIsPlayer, GetPVPRankInfo, UnitPVPRank, UnitIsPVP, GetGuildInfo, UnitPlayerControlled, UnitReaction, UnitIsTapped, UnitIsTappedByPlayer, UnitCanAttack, GetNumFriends, GetFriendInfo, IsInGuild, UnitLevel, UnitFactionGroup, GetQuestGreenRange, UnitRace, UnitClass, UnitClassification, UnitCreatureFamily, UnitCreatureType, UnitIsSameServer

local L = _G.TinyTipLocale

--[[---------------------------------------------
-- Local Variables
----------------------------------------------]]

local _, PlayerRealm, ClassColours

--[[----------------------------------------------------------------------
-- Module Support
------------------------------------------------------------------------]]

local modulecore, name = TinyTip, "TinyTipBasic"

local module, db, ColourPlayer, HookOnTooltipSetUnit
if not modulecore then
    module = {}
    module.name, module.localizedname = name, name
else
    local localizedname, reason
    _, localizedname, _, _, _, reason = GetAddOnInfo(name)
    if (not reason or reason ~= "MISSING") and not IsAddOnLoaded(name) then return end -- skip internal loading if module is external
    module = modulecore:NewModule(name)
    module.name, module.localizedname = name, localizedname or name
    ColourPlayer = modulecore.ColourPlayer
    HookOnTooltipSetUnit = modulecore.HookOnTooltipSetUnit
end

--[[----------------------------------------------------------------------
-- Formating
-------------------------------------------------------------------------]]

-- Return color format in HEX from Blizzard percentage RGB
-- for the class.
if not modulecore then
    ColourPlayer = function(unit)
        local _,c = UnitClass(unit)
        return ( c and UnitIsPlayer(unit) and ClassColours[c]) or "FFFFFF"
    end
end

function module.TooltipFormat(unit, name, realm, isPlayer, isPlayerOrPet, isDead)
    local self = module
    if self.onstandby then return end

    local numLines = GameTooltip:NumLines()
    local guildName = GetGuildInfo(unit)
    local line, lineText, levelLine, afterLevelLine, guildLine
    local isPvP = UnitIsPVP(unit)
    for i = 1,numLines,1 do
        line = _G[ "GameTooltipTextLeft" .. i ]
        if line:IsShown() then
            lineText = line:GetText()
            if lineText and lineText ~= guildName and strfind(lineText, L.Level, 1, true) then
                levelLine = line
                afterLevelLine = i + 1
            elseif lineText == guildName then
                guildLine = line
            elseif isPvP and strfind(lineText, PVP_ENABLED, 1, true) then
                line:SetText(nil)
                if modulecore then GameTooltip:Show() end -- this removes nil'd lines
            end
        end
    end

    -- First Line
    if not isPlayer then isPlayer = UnitIsPlayer(unit) end
    if not name or realm then name, realm = UnitName(unit) end
    local _, rankNumber
    if db["PvPRankText"] ~= 2 then
        _, rankNumber = GetPVPRankInfo(UnitPVPRank(unit), unit)
    end
    if isPlayer then
        if rankNumber and rankNumber > 0 then
            if db["PvPRankText"] == 1 then
                -- UnitName PlayerRealm RankNumber
                GameTooltipTextLeft1:SetText( string.format( "%s " .. L.strformat_ranknumber,
                                    (name or L.UnknownEntity) .. ( (realm and
                                    not UnitIsSameServer("player", unit) and
                                    ( (db["KeyServer"] and "(*)") or (" (" .. realm .. ")") )) or ""),
                                    rankNumber))
            else
                -- RankNumber UnitName PlayerRealm
                GameTooltipTextLeft1:SetText( string.format(L.strformat_ranknumber .. " %s",
                                    rankNumber,
                                    (name or L.UnknownEntity) .. ( (realm and
                                    not UnitIsSameServer("player", unit) and
                                    ( (db["KeyServer"] and "(*)") or (" (" .. realm .. ")") )) or "")))
            end
        else -- UnitName PlayerRealm
            GameTooltipTextLeft1:SetText( (name or L.UnknownEntity) .. ( (realm and
                                    not UnitIsSameServer("player", unit) and
                                    ( (db["KeyServer"] and "(*)") or (" (" .. realm .. ")") )) or ""))
        end
    end

    -- Reaction coloring
    local bdR,bdG,bdB = 0,0,0
    if not isPlayerOrPet then isPlayerOrPet = UnitPlayerControlled(unit) end
    local reactionNum = UnitReaction(unit, "player")
    local deadOrTappedColour, reactionText
    if UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) then
        bdR,bdG,bdB = 0.54,0.54,0.54
        GameTooltipTextLeft1:SetTextColor(0.54,0.54,0.54)
        deadOrTappedColour = "888888"
    elseif ( isPlayerOrPet and UnitCanAttack(unit, "player") ) or UnitIsTappedByPlayer(unit) or
            ( not isPlayerOrPet and reactionNum ~= nil and reactionNum > 0 and reactionNum <= 2 ) then
        -- hostile
        GameTooltipTextLeft1:SetTextColor(  FACTION_BAR_COLORS[reactionNum or 2].r,
                                            FACTION_BAR_COLORS[reactionNum or 2].g,
                                            FACTION_BAR_COLORS[reactionNum or 2].b)
        reactionText = ( reactionNum ~= nil and reactionNum > 0 and db["ReactionText"] and
                        _G["FACTION_STANDING_LABEL" .. reactionNum] ) or FACTION_STANDING_LABEL2

        if isPlayerOrPet and not UnitCanAttack("player", unit) then
            bdR,bdG,bdB = 0.5,0.2,0.1
        else
            bdR,bdG,bdB = 0.5,0.0,0.0
        end
    elseif ( isPlayerOrPet and UnitCanAttack("player",unit) ) or
            ( not isPlayerOrPet and reactionNum and reactionNum <= 4 ) then
        -- neutral
        GameTooltipTextLeft1:SetTextColor(  FACTION_BAR_COLORS[4].r,
                                            FACTION_BAR_COLORS[4].g,
                                            FACTION_BAR_COLORS[4].b)

        if db["ReactionText"] then reactionText = FACTION_STANDING_LABEL4 end
        bdR,bdG,bdB = 0.5, 0.5, 0.0
    else -- friendly
        reactionText = FACTION_STANDING_LABEL5
        if isPlayerOrPet then
            bdR,bdG,bdB = 0.0, 0.0, 0.5
        else
            bdR,bdG,bdB = 0.0, 0.5, 0.0
        end
        if UnitIsPVP(unit) then -- friendly, PvP-enabled
            GameTooltipTextLeft1:SetTextColor(  FACTION_BAR_COLORS[6].r,
                                                FACTION_BAR_COLORS[6].g,
                                                FACTION_BAR_COLORS[6].b)
        else
            GameTooltipTextLeft1:SetTextColor(  (not isPlayerOrPet and FACTION_BAR_COLORS[reactionNum or 5].r) or 0,
                                                (not isPlayerOrPet and FACTION_BAR_COLORS[reactionNum or 5].g) or 0.67,
                                                (not isPlayerOrPet and FACTION_BAR_COLORS[reactionNum or 5].b) or 1.0)

        end
    end

    -- We like to know who our friends are.
    if isPlayer and reactionText == FACTION_STANDING_LABEL5 and realm == PlayerRealm and db["ColourFriends"] ~= 2 then
        local numFriends = GetNumFriends()
        local friendName, friendLevel
        for i = 1,numFriends,1 do
            friendName,friendLevel = GetFriendInfo(i)
            if friendName and friendName ~= name and friendLevel ~= nil and friendLevel > 0 then
                if db["ColourFriends"] == 1 or db["BGColor"] == 1 or db["BGColor"] == 3 then
                    GameTooltipTextLeft1:SetTextColor(0.58, 0.0, 0.83)
                else
                    bdR,bdG,bdB = 0.29, 0.0, 0.42
                end
                break
            end
        end
    end

    -- Check for a dead unit, but try to leave out Hunter's Feign Death
    if not isDead then
        isDead = UnitHealth(unit) <= 0 and ( not isPlayer or UnitIsDeadOrGhost(unit) or UnitIsCorpse(unit) )
    end
    if isDead then
        bdR,bdG,bdB = 0.54, 0.54, 0.54
        GameTooltipTextLeft1:SetTextColor(0.54,0.54,0.54)
        deadOrTappedColour = "888888"
    end

    -- Set the color of the trade or guild line, if it's available. This
    -- line comes before the level line.
    if afterLevelLine and afterLevelLine > 3 then
        if guildLine and guildLine:IsShown() then
            guildLine:SetText( "<" .. guildLine:GetText() .. ">" )
            -- We like to know who our guild members are.
            if guildName and IsInGuild() and guildName == GetGuildInfo("player") then
                guildLine:SetTextColor( 0.58, 0.0, 0.83 )
            else -- other guilds or NPC trade line
                guildLine:SetTextColor( GameTooltipTextLeft1:GetTextColor() )
            end
        elseif GameTooltipTextLeft2:IsShown() then
            GameTooltipTextLeft2:SetText( "<" .. GameTooltipTextLeft2:GetText() .. ">" )
            GameTooltipTextLeft2:SetTextColor( GameTooltipTextLeft1:GetTextColor() )
        end
        for i = 3, afterLevelLine - 2, 1 do -- add misc. lines before level line
            _G[ "GameTooltipTextLeft" .. i]:SetTextColor( GameTooltipTextLeft1:GetTextColor() )
        end
    end

    -- The Level Line
    if levelLine then
        local levelColour
        local level = UnitLevel(unit)
        local levelDiff = level - UnitLevel("player") -- Level difference
        if levelDiff and UnitFactionGroup(unit) ~= UnitFactionGroup("player") then
            if levelDiff >= 5 or level == -1 then levelColour = "FF0000"
            elseif levelDiff >= 3 then levelColour = "FF6600"
            elseif levelDiff >= -2 then levelColour = "FFFF00"
            elseif -levelDiff <= GetQuestGreenRange() then levelColour = "00FF00"
            else levelColour = "888888"
            end
        end

        local levelLineText
        if level and level >= 1 then
            levelLineText = "|cFF" .. (deadOrTappedColour or levelColour or "FFCC00") ..
                            level .. "|r"
        elseif db["LevelGuess"] and ulevel and ulevel == -1 and ulevel < 60 then
            levelLineText = "|cFF" .. (deadOrTappedColour or levelColour or "FFCC00") ..
                            ">" .. (UnitLevel("player") + 10 ) .. "|r"
        else
            levelLineText = "|cFF" .. (deadOrTappedColour or levelColour or "FFCC00") .. "??|r"
        end

        if isPlayer then
            local race = (not db["HideRace"] and ( UnitRace(unit) or "") ) or " "
            levelLineText = levelLineText .. ((race and
                                            (" |cFF" .. (deadOrTappedColour or "DDEEAA") .. race .. " |r")) or "") ..
                            "|cFF" .. (deadOrTappedColour or ColourPlayer(unit)) .. (UnitClass(unit) or "" ) .. "|r"
        else -- pet or npc
            if not isPlayerOrPet then
                local npcType = UnitClassification(unit) -- Elite,etc. status
                if npcType and npcType ~= "normal" then
                    if npcType == "elite" then
                        levelLineText = levelLineText .. " |cFF" .. (deadOrTappedColour or "FFCC00") ..
                                                        ((db["KeyElite"] and "++") or L.Elite) .. "|r"
                    elseif npcType == "worldboss" then
                        levelLineText = levelLineText .. " |cFF" .. (deadOrTappedColour or "FF0000") ..
                                                        ((db["KeyElite"] and "(!)") or L.Boss) .. "|r"
                    elseif npcType == "rare" then
                        levelLineText = levelLineText .. " |cFF" .. (deadOrTappedColour or "FF66FF") ..
                                                        ((db["KeyElite"] and "+") or L.Rare) .. "|r"
                    elseif npcType == "rareelite" then
                        levelLineText = levelLineText .. "|cFF" .. (deadOrTappedColour or "FFAAFF") ..
                                                        ((db["KeyElite"] and "+++") or L["Rare Elite"]) .. "|r"
                    else -- should never get here
                        levelLineText = levelLineText .. " [|cFF" ..
                                        (deadOrTappedColour or "FFFFFF") .. npcType .. "|r]"
                    end
                end
             end
             if not db["HideNPCType"] then
                if isPlayerOrPet then
                    levelLineText = levelLineText .. " |cFF" .. (deadOrTappedColour or "DDEEAA") ..
                        (UnitCreatureFamily(unit) or UnitCreatureType(unit) or L.Unknown) .. "|r"
                else
                    levelLineText = levelLineText .. " |cFF" .. (deadOrTappedColour or "DDEEAA") ..
                                                    (UnitCreatureType(unit) or L.Unknown) .. "|r"
                end
            end
         end

        -- add corpse/tapped line
         if deadOrTappedColour then
            levelLineText = levelLineText .. " |cFF" .. deadOrTappedColour .. "(" ..
                                ( ( isDead and L.Corpse ) or L.Tapped ) .. ")|r"
         end

         levelLine:SetText( levelLineText )
    end -- the Level Line

    if db["BGColor"] ~= 1 and (isPlayerOrPet or deadOrTappedColour or db["BGColor"] == 2) then
        if db["BGColor"] == 3 and not deadOrTappedColour then
            bdR,bdG,bdB = 0,0,0
        end
        GameTooltip:SetBackdropColor(bdR, bdG, bdB)
    end

    if db["Border"] ~= 1 then
        if db["Border"] == 2 and not deadOrTappedColour then
            GameTooltip:SetBackdropBorderColor(0,0,0,0) -- ghetto hide
        else
            GameTooltip:SetBackdropBorderColor(bdR * 1.5 , bdG * 1.5, bdB * 1.5, 1)
        end
    end
end

--[[-------------------------------------------------------
-- Event Handlers
---------------------------------------------------------]]

if not modulecore then
    local OriginalOnTooltipSetUnit = nil
    local function OnTooltipSetUnit(self,...)
        if OriginalOnTooltipSetUnit then
            if module.onstandby then
                return OriginalOnTooltipSetUnit(self,...)
            else
                OriginalOnTooltipSetUnit(self,...)
            end
        elseif module.onstandby then
            return
        end

        local _, unit = self:GetUnit()
        if unit and UnitExists(unit) and GameTooltipTextLeft1:IsShown() then
            module.TooltipFormat(unit)
            GameTooltip:Show()
        end
    end
    HookOnTooltipSetUnit = function(tooltip)
        if OriginalOnTooltipSetUnit == nil then
            OriginalOnTooltipSetUnit  = tooltip:GetScript("OnTooltipSetUnit") or false
            tooltip:SetScript("OnTooltipSetUnit", OnTooltipSetUnit)
        end
    end
end

function module:ReInitialize(_db)
    db = _db or db
    if not modulecore and not ClassColours then
        ClassColours = {}
        for k,v in pairs(RAID_CLASS_COLORS) do
            ClassColours[k] = strformat("%2x%2x%2x", v.r*255, v.g*255, v.b*255)
        end
    end
end

function module:Standby()
    if not modulecore then ClassColours = nil end
end

-- For initializing the database and hooking functions.
function module:Initialize()
    db = ( modulecore and modulecore:GetDB() ) or TinyTip_StandAloneDB or {}

    HookOnTooltipSetUnit(GameTooltip, self.TooltipFormat, 1)
end

-- Setting variables that only need to be set once goes here.
function module:Enable()
       PlayerRealm = GetRealmName()
       self:ReInitialize()
end

-- TinyTipModuleCore NOT loaded
local EventFrame
if not modulecore then
    local function OnEvent(self, event, arg1)
        if event == "ADDON_LOADED" and arg1 == module.name then
            module:Initialize()
            if not module.loaded then
                module:Enable()
            end
            self:UnregisterEvent("ADDON_LOADED")
        elseif event == "PLAYER_LOGIN" then
                module.loaded = true
                module:Enable()
        end
    end
    EventFrame = CreateFrame("Frame", nil, GameTooltip)
    EventFrame:RegisterEvent("ADDON_LOADED")
    EventFrame:RegisterEvent("PLAYER_LOGIN")
    EventFrame:SetScript("OnEvent", OnEvent)
end

