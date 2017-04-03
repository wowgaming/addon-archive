-- CantHealYou

-- Attempts to automatically detect when you cast a healing spell or buff 
-- on a friendly target who is out of line of sight or range and whisper 
-- them if they're in your party, raid, or guild.
--
-- This can fail; if the target isn't in range and the interface knows 
-- it, then it doesn't actually try to cast the spell, so the addon can't 
-- detect the spellcast.  However, if that's the case, you should see the 
-- red dot or number on the icon for the spell (in the default interface).
--
-- Range detection can be forced in a macro using the /chyw slash
-- command.  It behaves like /cast (taking [target=x] options, etc.).

-- create our frame for the listeners and make sure it's not visible
local CantHealYouFrame = CreateFrame("FRAME", nil, UIParent)
CantHealYouFrame:Hide()

local debugmode = false

-- for detecting when heal spells can't be cast

-- look for losing control, gaining control (?), error events indicating a stun, 

-- spells being interrupted

-- announce these events to party/raid if we're set to


-- keep track of the last time we whispered someone

local timestamp = {}

-- keep track of whether we're in combat, incapacitated, and a healer

local incombat = false
local ontaxi = 0
local incapacitated = false
local imahealer = false

local function Debug(text)
  if debugmode then
    print(text)
  end
end

local function toboolean( value )
  return not not value
end

local function FindUnitFor(who)
  local i, size
  
  -- second parameter ("true" on these) indicates whether or not
  -- to give names qualified with -servername for players from
  -- other servers
  if GetUnitName("player", true) == who then return "player" end
  if GetUnitName("target", true) == who then return "target" end
  if GetUnitName("focus", true) == who then return "focus" end
  
  size = GetNumPartyMembers()
  if size > 0 then
    for i=1, size do
      if GetUnitName("party"..i, true) == who then return "party"..i end
    end
  end
  size = GetNumRaidMembers()
  if size > 0 then
    for i=1, size do
      if GetUnitName("raid"..i, true) == who then return "raid"..i end
    end
  end

  -- couldn't find a unit, just return what we were passed
  return who
end

local function Whisper(who, message)
  -- if we're not active, we shouldn't be here.  But if we do get here, don't do the whisper!
  if not CHYconfig.Active then return end

  if not CHYconfig.InBattlegrounds then
    if ( UnitInBattleground("player") ~= nil ) then return end
  end
  
  -- get the name for who to whisper
  local name = GetUnitName(who, true)
  name = gsub( name, " ", "")
  
  Debug("Called Whisper for "..name.." with message "..message)
  if timestamp[name] and CHYconfig.Interval > 0 then
    local interval = time() - timestamp[name]
    Debug("last whispered "..who.." "..interval.." seconds ago")
    if interval < CHYconfig.Interval then
      -- too soon, don't whisper
      Debug("whispered "..name.." within last "..CHYconfig.Interval.." seconds, not whispering")
      return
    end
  end
  timestamp[name] = time()
  SendChatMessage(message, "WHISPER", nil, name)
end

-- tell party or raid something
local function Broadcast(message)
  local group
  
  if ( (message == nil) or (message == "") ) then
    Debug("Broadcast called with empty message.  Giving up.")
    return
  end
    
  Debug("Broadcast called with message: "..message)
  
  if UnitOnTaxi("player") then
    Debug("player is on taxi, won't broadcast")
    return
  end
  if not CHYconfig.InBattlegrounds then
    if ( UnitInBattleground("player") ~= nil ) then return end
  end
  
  if not CHYconfig.Active then
    return
  end

  if GetNumRaidMembers() > 0 then
    group = "RAID"
  elseif GetNumPartyMembers() > 0 then
    group = "PARTY"
  
  else
    -- we're not in a group, no one to broadcast to
    
    return
  end

  -- we use the message for the timestamp, so we don't send the same message within interval seconds
  if timestamp[message] and CHYconfig.Interval > 0 then
    local interval = time() - timestamp[message]
    Debug("last broadcast "..interval.." seconds ago")
    if interval < CHYconfig.Interval then
      return
    end
  end

  timestamp["global time"] = time()
  SendChatMessage(message, group)
end

local function DoTheWarn(who, spell, message)
  if ( (message == nil) or (message == "") ) then 
    Debug("DoTheWarn called for "..who.." with spell "..spell.." but no message.  Giving up.")
    return 
  end

  Debug("DoTheWarn called for "..who.." with spell "..spell.." and condition "..message)
  -- don't warn yourself
  if UnitIsUnit( who, "player" ) then Debug(who.." is player"); return end
  -- if they can attack us, we're not healing/buffing them, so forget it
  if UnitCanAttack( who, "player" ) then Debug(who.." can attack player"); return end
  -- no point in trying to whisper an NPC
  if not UnitIsPlayer( who ) then Debug(who.." is not a player"); return end
  -- are we only doing our party/raid/guild?
  if CHYconfig.OnlyPartyRaidGuild then
    if not (UnitInParty( who ) or UnitInRaid(who ) or UnitIsInMyGuild( who )) then 
      Debug(who.." is not in party, raid or guild")
      return 
    end
  end
  -- if we make it here, all "don't tell them" tests were passed
  Debug("whisper "..who)
  Whisper( who,  string.format( message, spell ) )

end

local currentspell = { ["spell"] = nil, ["rank"] = nil, ["target"] = nil }
local failed = false

local function SetDefault( key, value )
  Debug("checking to see if "..key.." is set")
  if ( (CHYconfig[key] == nil) or (CHYconfig[key] == "") ) then 
    Debug("was not set - setting to "..tostring(value))
    CHYconfig[key] = value 
  end
  if CantHealYou_Config[key] == nil then
    CantHealYou_Config[key] = value
  end
end

local function SetAllDefaults()
  SetDefault( "OnlyPartyRaidGuild", true )
  SetDefault( "Active", true )
  SetDefault( "InBattlegrounds", true )
  SetDefault( "DoOutOfRange", true )
  SetDefault( "OutOfRange", CHYstrings.OutOfRange )
  SetDefault( "DoLineOfSight", true )
  SetDefault( "LineOfSight", CHYstrings.LineOfSight )
  SetDefault( "DoLostControl", false )
  SetDefault( "LostControl", CHYstrings.LostControl )
  SetDefault( "GainedControl", CHYstrings.GainedControl )
  SetDefault( "DoAuraBounced", false )
  SetDefault( "AuraBounced", CHYstrings.AuraBounced )
  SetDefault( "DoInterrupted", false )
  SetDefault( "Interrupted", CHYstrings.Interrupted )
  SetDefault( "Interval", 10 )
end

function CantHealYou_OnEvent(self, event, arg1, arg2, arg3, arg4)
    Debug("Event received: "..event)
    if event == "VARIABLES_LOADED" then
      -- older versions had "CantHealYou_Config", which is now used for global default config
      -- if we don't have a per-character config (CHYconfig), but do have global, set 
      -- per-character to the global config.  If we don't have a global config, create an
      -- empty one.
      
      -- workaround for "disappearing config" problem.  First, check to see
      -- if all the config strings are "".  If they are, assume we have
      -- a "disappeared" config, and set the configuration to nil so the
      -- initialization code can create a new config.
      -- We only test the old config strings, so we won't throw errors on
      -- upgrades from older versions.  
      if CantHealYou_Config then
        if CantHealYou_Config["OutOfRange"] == "" and CantHealYou_Config["LineOfSight"] == "" then
          CantHealYou_Config = nil
        end
      end
      if CHYconfig then
        if CHYconfig["OutOfRange"] == "" and CHYconfig["LineOfSight"] == "" 
        and CHYconfig["LostControl"] == "" and CHYconfig["GainedControl"] == ""
        and CHYconfig["AuraBounced"] == "" and CHYconfig["Interrupted"] == "" then
          CHYconfig = nil
        end
      end
      
      if not CHYconfig and CantHealYou_Config then 
        -- we copy each key/value pair in CantHealYou_Config to CHYconfig
        -- because CHYconfig = CantHealYou_Config would make them both
        -- point to the same table, and any alteration done to one would
        -- happen to the other
        local key, value
        CHYconfig = {}
        for key, value in pairs( CantHealYou_Config ) do
          CHYconfig[key] = value
        end
      else
        CantHealYou_Config = {}
      end
      if not CHYconfig then
        -- no config exists, create an empty config
        CHYconfig = {}
      end
      -- set defaults (only those that don't have values will be set)
      SetAllDefaults()
      -- update the version number
      CHYconfig.Version = GetAddOnMetadata("CantHealYou", "Version")
      CantHealYouFrame:UnregisterEvent("VARIABLES_LOADED")
    elseif event == "UNIT_SPELLCAST_SENT" then
        if arg1 == "player" then
            currentspell.spell = arg2
            currentspell.rank = arg3
            currentspell.target = arg4
            Debug(arg1.." is casting "..arg2.." "..arg3.." on "..arg4)
        end
    elseif event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_FAILED_QUIET" then
        if arg1 == "player" and arg2 == currentspell.spell and arg3 == currentspell.rank then
            Debug("cast of "..arg2.." "..arg3.." on "..currentspell.target.." failed")
        end
    elseif event == "UI_ERROR_MESSAGE" then
        local message

        -- possible future additions:
        -- SPELL_FAILED_CUSTOM_ERROR_57  (Cycloned)
        -- SPELL_FAILED_CUSTOM_ERROR_54  (no target or target too far away)
        -- SPELL_FAILED_CUSTOM_ERROR_44  (rooted)
        -- SPELL_FAILED_CASTER_DEAD
        -- SPELL_FAILED_CASTER_DEAD_FEMALE       
        
        Debug("error received: "..arg1)
        if arg1 == ERR_OUT_OF_RANGE then
          if not CHYconfig.DoOutOfRange then return end
          message = CHYconfig.OutOfRange
        elseif arg1 == SPELL_FAILED_LINE_OF_SIGHT then
          if not CHYconfig.DoLineOfSight then return end
          message = CHYconfig.LineOfSight
        elseif arg1 == SPELL_FAILED_AURA_BOUNCED then
          if not CHYconfig.DoAuraBounced then return end
          message = CHYconfig.AuraBounced
        elseif arg1 == SPELL_FAILED_INTERRUPTED or arg1 == SPELL_FAILED_INTERRUPTED_COMBAT then
          if GetUnitSpeed("player") == 0 and incombat then
            -- player isn't moving, we'll assume something else interrupted
            Debug("interrupted!")
            if not CHYconfig.DoInterrupted then return end
            message = CHYconfig.Interrupted
          end
        else
          Debug("error does not match any condition")
          return
        end
        -- we only reach here if we didn't hit the default "else"
        if currentspell.target then
          local mytarget = FindUnitFor(currentspell.target)
          Debug("FindUnitFor returned unit "..mytarget)
          DoTheWarn( mytarget, currentspell.spell, message)
          currentspell.spell = nil
          currentspell.rank = nil
          currentspell.target = nil
        end
    elseif event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_REGEN_DISABLED" then
      -- entering or leaving combat, so clear timers
      timestamps = {}
      if event == "PLAYER_REGEN_DISABLED" then 
        Debug("entering combat")
        incombat = true
      else
        Debug("leaving combat")
        incombat = false 
      end
    elseif event == "PLAYER_ROLES_ASSIGNED" then
      -- not used right now, but for possible future use
      Debug("role assigned")
      local isTank, isHealer, isDamage = UnitGroupRolesAssigned("player")
      if isHealer then
        Debug("player has been assigned as healer")
        imahealer = true
      else
        imahealer = false
      end
    elseif event == "TAXIMAP_CLOSED" then
      -- when WoW puts you on a taxi, it sends PLAYER_CONTROL_LOST before
      -- UnitOnTaxi("player") will return true.  Thus, we have to use this
      -- fake to detect whether control was lost because of using a 
      -- flight master.
      ontaxi = time()
    elseif event == "PLAYER_CONTROL_LOST" then
      if ( (time() - ontaxi) < 2) then
        Debug("Control lost within 2 seconds of closing taxi map - will assume is due to flight")
        return
      end
      if incapacitated then return else incapacitated = true end
      if not CHYconfig.DoLostControl then return end
      Broadcast(CHYconfig.LostControl)
    elseif event == "PLAYER_CONTROL_GAINED" or event == "PLAYER_DEAD" then
      if not incapacitated then return else incapacitated = false end
      if not CHYconfig.DoLostControl then return end
      Broadcast(CHYconfig.ControlRegained)
    elseif event == "SPELL_FAILED_NOT_INCONTROL" or event == "SPELL_FAILED_CHARMED" or event == "SPELL_FAILED_SILENCED" then
      if incapacitated then return else incapacitated = true end
      if not CHYconfig.DoLostControl then return end
      Broadcast(CHYconfig.LostControl)
    else
        -- UNIT_SPELLCAST_STOP, UNIT_SPELLCAST_CHANNEL_STOP, or UNIT_SPELLCAST_SUCCEEDED
        if arg1 == "player" and arg2 == currentspell.spell and arg3 == currentspell.rank then
            -- looks to be the spell we're keeping, so release it
            Debug("cast of "..arg2.." "..arg3.." on "..currentspell.target.." ended")
            currentspell.spell = nil
            currentspell.rank = nil
            currentspell.target = nil
        end
        if incapacitated then
          incapacitated = false
          if CHYconfig.DoLostControl then
            Broadcast(CHYconfig.ControlRegained)
          end
        end
    end
end

function CantHealYou_warn(str)
  local spell, target = SecureCmdOptionParse(str)
  if not target then target = "target" end
  Debug( "testing range for "..spell.." on "..target )
  if IsSpellInRange(spell, target) == 0 then
    DoTheWarn(target, spell, CHYconfig.OutOfRange )
  end
end

function CantHealYou_slash(str)
  local cmd = string.lower(str)

  if cmd == "debug" then
    debugmode = not debugmode
    if debugmode then
print("Debug on.")
    else
print("Debug off.")

    end
  elseif cmd == "reset" or cmd == "resetall" then
    CHYconfig = {}
    if cmd == "resetall" then
      CantHealYouConfig = {}
    end
    SetAllDefaults()
  else
    InterfaceOptionsFrame_OpenToCategory(CantHealYouOptions)
  end
end

SLASH_CHYMAIN1 = "/chy"
SlashCmdList["CHYMAIN"] = CantHealYou_slash

SLASH_CHYWARN1 = "/chyw"
SlashCmdList["CHYWARN"] = CantHealYou_warn

CantHealYouFrame:SetScript("OnEvent", CantHealYou_OnEvent)
CantHealYouFrame:RegisterEvent("UNIT_SPELLCAST_SENT")
CantHealYouFrame:RegisterEvent("UNIT_SPELLCAST_FAILED")
CantHealYouFrame:RegisterEvent("UNIT_SPELLCAST_FAILED_QUIET")
CantHealYouFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
CantHealYouFrame:RegisterEvent("UNIT_SPELLCAST_STOP")
CantHealYouFrame:RegisterEvent("UNIT_SPELLCAST_CHANNELED_STOP")
CantHealYouFrame:RegisterEvent("PLAYER_ROLES_ASSIGNED")
CantHealYouFrame:RegisterEvent("PLAYER_CONTROL_LOST")
CantHealYouFrame:RegisterEvent("PLAYER_CONTROL_GAINED")
CantHealYouFrame:RegisterEvent("PLAYER_DEAD")
--CantHealYouFrame:RegisterEvent("PLAYER_ALIVE")
--CantHealYouFrame:RegisterEvent("PLAYER_UNGHOST")
CantHealYouFrame:RegisterEvent("UI_ERROR_MESSAGE")
CantHealYouFrame:RegisterEvent("VARIABLES_LOADED")
CantHealYouFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
CantHealYouFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
CantHealYouFrame:RegisterEvent("TAXIMAP_OPENED")
CantHealYouFrame:RegisterEvent("TAXIMAP_CLOSED")

-- END OF MAIN CODE.  From here down, this is stuff for the options
-- dialog

local function ShowOptionValue( name )
  local mytype = type( CHYconfig[name] )
  local UIvar = _G["CantHealYouOptions"..name]
  
  Debug("type of "..name.." is "..mytype)  
  
  -- all our boolean variables are displayed in checkboxes
  if mytype == "boolean" then
    UIvar:SetChecked( CHYconfig[name] )
  elseif mytype == "number" then
    UIvar:SetText( tostring(CHYconfig[name]) )
  elseif mytype == "string" then
    UIvar:SetText( CHYconfig[name] )
  else
    UIvar:SetText( "" )
  end
end

local function ShowDefaultValue( name )
  local mytype = type( CantHealYou_Config[name] )
  local UIvar = _G["CantHealYouOptions"..name]
  
  if mytype == "boolean" then
    UIvar:SetChecked( CantHealYou_Config[name] )
  elseif mytype == "number" then
    UIvar:SetText( tostring(CHYconfig[name]) )
  else
    UIvar:SetText( CantHealYou_Config[name] )
  end
end

function CantHealYouOptions_OnShow()
  ShowOptionValue( "OnlyPartyRaidGuild" )
  ShowOptionValue( "Active" )
  ShowOptionValue( "InBattlegrounds" )
  ShowOptionValue( "DoOutOfRange" )
  ShowOptionValue( "OutOfRange" )
  ShowOptionValue( "DoLineOfSight" )
  ShowOptionValue( "LineOfSight" )
  ShowOptionValue( "DoInterrupted" )
  ShowOptionValue( "Interrupted" )
  ShowOptionValue( "DoLostControl" )
  ShowOptionValue( "LostControl" )
  ShowOptionValue( "GainedControl" )
  ShowOptionValue( "DoAuraBounced" )
  ShowOptionValue( "AuraBounced" )
  ShowOptionValue( "Interval" )
  ShowOptionValue( "Version" )	
end

function CantHealYouOptions_Save()
  CHYconfig.OnlyPartyRaidGuild = toboolean( CantHealYouOptionsOnlyPartyRaidGuild:GetChecked() )
  CHYconfig.Active = toboolean( CantHealYouOptionsActive:GetChecked() )
  CHYconfig.InBattlegrounds = toboolean( CantHealYouOptionsInBattlegrounds:GetChecked() )

  CHYconfig.DoOutOfRange = toboolean( CantHealYouOptionsDoOutOfRange:GetChecked() )
  CHYconfig.OutOfRange = CantHealYouOptionsOutOfRange:GetText()

  CHYconfig.DoLineOfSight = toboolean( CantHealYouOptionsDoLineOfSight:GetChecked() )
  CHYconfig.LineOfSight = CantHealYouOptionsLineOfSight:GetText()
  
  CHYconfig.DoInterrupted = toboolean( CantHealYouOptionsDoInterrupted:GetChecked() )
  CHYconfig.Interrupted = CantHealYouOptionsInterrupted:GetText()
  
  CHYconfig.DoLostControl = toboolean( CantHealYouOptionsDoLostControl:GetChecked() )
  CHYconfig.LostControl = CantHealYouOptionsLostControl:GetText()
  CHYconfig.GainedControl = CantHealYouOptionsGainedControl:GetText()

  CHYconfig.DoAuraBounced = toboolean( CantHealYouOptionsDoAuraBounced:GetChecked() )
  CHYconfig.AuraBounced = CantHealYouOptionsAuraBounced:GetText()
  
  CHYconfig.Interval = tonumber(CantHealYouOptionsInterval:GetText())
  if typeof(CHYconfig.Interval) ~= "number" then
  
 CHYconfig.interval = 0
  end
  
end

function CantHealYouOptions_OnLoad()
  CantHealYouOptionsTitle:SetText( CHYstrings.UItitle )
  CantHealYouOptionsListLabel:SetText( CHYstrings.UIsendwarningsfor )
  CantHealYouOptionsIntervalLabel:SetText( CHYstrings.UIinterval )

  CantHealYouOptions.name = "Can't Heal You"
  CantHealYouOptions.okay = function (self) CantHealYouOptions_Save() end
  CantHealYouOptions.cancel = nil

  InterfaceOptions_AddCategory(CantHealYouOptions)
end

function CantHealYouOptions_CheckButtonText(self, text, tooltiptext)
  local textobj = _G[self:GetName().."Text"]
  textobj:SetText(text)
  self.tooltipText = tooltiptext
end

function CantHealYouOptions_SaveDefaults()
  CantHealYou_Config.OnlyPartyRaidGuild = toboolean( CantHealYouOptionsOnlyPartyRaidGuild:GetChecked() )
  CantHealYou_Config.Active = toboolean( CantHealYouOptionsActive:GetChecked() )

  CantHealYou_Config.DoOutOfRange = toboolean( CantHealYouOptionsDoOutOfRange:GetChecked() )
  CantHealYou_Config.OutOfRange = CantHealYouOptionsOutOfRange:GetText()

  CantHealYou_Config.DoLineOfSight = toboolean( CantHealYouOptionsDoLineOfSight:GetChecked() )
  CantHealYou_Config.LineOfSight = CantHealYouOptionsLineOfSight:GetText()
  
  CantHealYou_Config.DoInterrupted = toboolean( CantHealYouOptionsDoInterrupted:GetChecked() )
  CantHealYou_Config.Interrupted = CanHealYouOptionsInterrupted:GetText()
  
  CantHealYou_Config.DoLostControl = toboolean( CantHealYouOptionsDoLostControl:GetChecked() )
  CantHealYou_Config.LostControl = CantHealYouOptionsLostControl:GetText()
  CantHealYou_Config.GainedControl = CantHealYouOptionsGainedControl:GetText()

  CantHealYou_Config.DoAuraBounced = toboolean( CantHealYouOptionsDoAuraBounced:GetChecked() )
  CantHealYou_Config.AuraBounced = CantHealYouOptionsAuraBounced:GetText()
  
  CantHealYou_Config.Interval = tonumber(CantHealYouOptionsInterval:GetText())
end

function CantHealYouOptions_LoadDefaults()
  ShowDefaultValue( "OnlyPartyRaidGuild" )
  ShowDefaultValue( "Active" )
  ShowDefaultValue( "DoOutOfRange" )
  ShowDefaultValue( "OutOfRange" )
  ShowDefaultValue( "DoLineOfSight" )
  ShowDefaultValue( "LineOfSight" )
  ShowDefaultValue( "DoInterrupted" )
  ShowDefaultValue( "Interrupted" )
  ShowDefaultValue( "DoLostControl" )
  ShowDefaultValue( "LostControl" )
  ShowDefaultValue( "GainedControl" )
  ShowDefaultValue( "DoAuraBounced" )
  ShowDefaultValue( "AuraBounced" )
  ShowDefaultValue( "Interval" )
end