--[[
-- You need edit this file for configuration ONLY if
-- TinyTipOptions is NOT loaded. Otherwise, the options
-- in this file do nothing.
--]]

if not TinyTipDB or not TinyTipDB.configured then
    local t = {
                --[[
                -- To select the TinyTip default, set the value to nil.
                --]]
                ["PvPRankText"] = nil,       -- nil, 1, 2
                                             -- 1 will show the PvP Rank text after the name instead of
                                             -- before. 2 will disable showing the text altogether.
                ["KeyServer"] = nil,         -- true will add (*) instead of the server's name for players from
                                             -- different realm.
                ["KeyElite"] = nil,          -- true will use (!), +++, ++, and + for Boss, Rare Elite,
                                             -- Elite, and Rare, respectively.
                ["HideRace"] = nil,          -- true will hide the player's race text.
                ["HideNPCType"] = nil,       -- true will hide the creature/NPC type text.
                ["ReactionText"] = nil,      -- true adds Reaction Text (Hostile, Friendly, etc.)
                ["LevelGuess"] = nil,        -- true will show ">70", ">60", etc. instead of ??
                ["ColoursFriends"] = nil,    -- nil, 1, 2
                                             -- 1 will colour only the name. 2 will disable colouring altogether.
                ["BGColor"] = nil,           -- nil, 1, 2, 3
                                             -- 1 will disable colouring the background. 3 will make it black,
                                             -- except for Tapped/Dead. 2 will colour NPCs as well as PCs.
                ["Border"] = nil,            -- nil, 1, 2, 3
                                             -- 1 will disable colouring the border. 2 will make it always black.
                                             -- 3 will make it a similiar colour to the background for NPCs.
    }

    TinyTip_StandAloneDB =  (TinyTip_StandAloneDB and setmetatable(t, {__index=TinyTip_StandAloneDB})) or t
    t = nil
end

