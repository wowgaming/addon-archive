-- File: StateHandler.lua
-- Author: John Langone (Pazza - Bronzebeard)
-- Description: Always maintain the current state of the player. The term 'state'
-- in this case refers to whether or not the player is, in the battleground(pvp),
-- arena, 5 man instance, raid instance, combat, resting etc. States are utilize
-- by WIM to allow for 'state' based option sets. Plugin authors may retrieve the
-- current state by accessing WIM.curState

local WIM = WIM;

-- we want to know the current state since last login.
-- this information is loaded when WIM is initialized. Check WIM.lua
WIM.db_defaults.lastState = "other";

WIM.curState = "other";
-- available states include: resting, combat, pvp, arena, raid, party, other


-- state flags
local flag_combat = false;
local flag_resting = IsResting();

-- register events directly with main frame in order to preserve correct state when WIM is disabled.
local workerFrame = getglobal("WIM_workerFrame");

-- combat detection
workerFrame:RegisterEvent("PLAYER_REGEN_DISABLED");
workerFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
workerFrame:RegisterEvent("PLAYER_UPDATE_RESTING");
workerFrame:RegisterEvent("PLAYER_ENTERING_WORLD");


-- this function will analyze current flags and set WIM.curState appropriately.
local function evaluateState()
    if(select(2, IsInInstance()) == "arena") then
        WIM.curState = "arena";
    elseif(flag_combat) then
        WIM.curState = "combat";
    elseif(select(2, IsInInstance()) == "pvp") then
        -- inside battleground
        WIM.curState = "pvp";
    elseif(select(2, IsInInstance()) == "raid") then
        -- inside raid isntance
        WIM.curState = "raid";
    elseif(select(2, IsInInstance()) == "party") then
        -- inside 5 man instance
        WIM.curState = "party";
    elseif(flag_resting) then
        WIM.curState = "resting";
    else
        WIM.curState = "other";
    end
    
    WIM.lastState = WIM.curState; -- we want to remember our last state.
    
    WIM.CallModuleFunction("OnStateChange", WIM.curState, flag_combat);
    WIM.dPrint("Evaluated State: "..WIM.curState);
end


------------------------------------------
--      Event Triggers                  --
------------------------------------------

function WIM:PLAYER_REGEN_ENABLED(...)
    -- player no longer in combat
    flag_combat = false;
    evaluateState();
end

function WIM:PLAYER_REGEN_DISABLED(...)
    -- player in combat
    flag_combat = true;
    evaluateState();
end

function WIM:PLAYER_UPDATE_RESTING(...)
    -- player has either entered or left resting state
    flag_resting = IsResting();
    evaluateState();    
end

function WIM:PLAYER_ENTERING_WORLD(...)
    -- check if player is in arena, bg, party or raid.
    evaluateState();
end

