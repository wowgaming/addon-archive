QuestHelper_File["pathfinding.lua"] = "1.4.1"
QuestHelper_Loadtime["pathfinding.lua"] = GetTime()

local IRONFORGE_PORTAL = {25,0.255,0.084, "Ironforge portal site"}
local STORMWIND_CITY_PORTAL = QuestHelper_ConvertCoordsToWrath({36,0.387,0.802, "Stormwind City portal site"}, true)  -- Old pre-Wrath coordinates. I could fix it, but . . . meh.
local DARNASSUS_PORTAL = {21,0.397,0.824, "Darnassus portal site"}
local EXODAR_PORTAL = {12,0.476,0.598, "Exodar portal site"}

local SHATTRATH_CITY_PORTAL = {60,0.530,0.492, "Shattrath City portal site"}
local DALARAN_PORTAL = {67,0.500,0.394, "Dalaran portal site"}
local MOONGLADE_PORTAL = {20,0.563,0.320, "Moonglade portal site"}

local SILVERMOON_CITY_PORTAL = {52,0.583,0.192, "Silvermoon City portal site"}
local UNDERCITY_PORTAL = {45,0.846,0.163, "Undercity portal site"}
local ORGRIMMAR_PORTAL = {1,0.386,0.859, "Orgrimmar portal site"}
local THUNDER_BLUFF_PORTAL = {23,0.222,0.168, "Thunder Bluff portal site"}

local BLASTED_LANDS_PORTAL = {33,0.575,0.511, "Blasted Lands portal site"}

local static_horde_routes = 
  {
   {{7, 0.505, 0.124}, {38, 0.313, 0.303}, 210}, -- Durotar <--> Grom'gol Base Camp
   {{38, 0.316, 0.289}, {43, 0.621, 0.591}, 210}, -- Grom'gol Base Camp <--> Tirisfal Glades
   {{43, 0.605, 0.587}, {7, 0.509, 0.141}, 210}, -- Tirisfal Glades <--> Durotar
   {{45, 0.549, 0.11}, {52, 0.495, 0.148}, 60}, -- Undercity <--> Silvermoon City
   
   {{7, 0.413, 0.178}, {65, 0.414, 0.536}, 210}, -- Durotar <--> Warsong Hold
   {{43, 0.591, 0.590}, {70, 0.777, 0.283}, 210}, -- Tirisfal Glades <--> Vengeance Landing
   
   {{60, 0.592, 0.483}, SILVERMOON_CITY_PORTAL, 60, true, nil, "SILVERMOON_CITY_PORTAL"}, -- Shattrath City --> Silvermoon City
   {{60, 0.528, 0.531}, THUNDER_BLUFF_PORTAL, 60, true, nil, "THUNDER_BLUFF_PORTAL"}, -- Shattrath City --> Thunder Bluff
   {{60, 0.522, 0.529}, ORGRIMMAR_PORTAL, 60, true, nil, "ORGRIMMAR_PORTAL"}, -- Shattrath City --> Orgrimmar
   {{60, 0.517, 0.525}, UNDERCITY_PORTAL, 60, true, nil, "UNDERCITY_PORTAL"}, -- Shattrath City --> Undercity
   
   {{67, 0.583, 0.216}, SILVERMOON_CITY_PORTAL, 60, true, nil, "SILVERMOON_CITY_PORTAL"}, -- Dalaran --> Silvermoon City
   {{67, 0.573, 0.219}, THUNDER_BLUFF_PORTAL, 60, true, nil, "THUNDER_BLUFF_PORTAL"}, -- Dalaran --> Thunder Bluff
   {{67, 0.553, 0.255}, ORGRIMMAR_PORTAL, 60, true, nil, "ORGRIMMAR_PORTAL"}, -- Dalaran --> Orgrimmar
   {{67, 0.556, 0.238}, UNDERCITY_PORTAL, 60, true, nil, "UNDERCITY_PORTAL"}, -- Dalaran --> Undercity
   {{67, 0.563, 0.226}, SHATTRATH_CITY_PORTAL, 60, true, nil, "SHATTRATH_CITY_PORTAL"}, -- Dalaran --> Shatt
   
   {{1,0.381,0.857}, BLASTED_LANDS_PORTAL, 60, true, level_limit = 58},  -- Orgrimmar --> Blasted Lands
   {{23,0.231,0.135}, BLASTED_LANDS_PORTAL, 60, true, level_limit = 58},  -- Thunder Bluff --> Blasted Lands
   {{45,0.852,0.170}, BLASTED_LANDS_PORTAL, 60, true, level_limit = 58},  -- Undercity --> Blasted Lands
   {{52,0.584,0.210}, BLASTED_LANDS_PORTAL, 60, true, level_limit = 58},  -- Silvermoon --> Blasted Lands
  }

  
local static_alliance_routes = 
  {
   {QuestHelper_ConvertCoordsToWrath({36, 0.639, 0.083}, true), {25, 0.764, 0.512}, 180}, -- Deeprun Tram
   {{10, 0.718, 0.565}, {51, 0.047, 0.636}, 210}, -- Theramore Isle <--> Menethil Harmor
   {{36, 0.228, 0.560}, {16, 0.323, 0.441}, 210}, -- Stormwind City <--> Auberdine
   
   {{36, 0.183, 0.255}, {65, 0.597, 0.694}, 210}, -- Stormwind City <--> Valiance Keep
   {{51, 0.047, 0.571}, {70, 0.612, 0.626}, 210}, -- Menethil <--> Daggercap Bay
   
   {{60, 0.558, 0.366}, STORMWIND_CITY_PORTAL, 60, true, nil, "STORMWIND_CITY_PORTAL"}, -- Shattrath City --> Stormwind City
   {{60, 0.563, 0.37}, IRONFORGE_PORTAL, 60, true, nil, "IRONFORGE_PORTAL"}, -- Shattrath City --> Ironforge
   {{60, 0.552, 0.364}, DARNASSUS_PORTAL, 60, true, nil, "DARNASSUS_PORTAL"}, -- Shattrath City --> Darnassus
   {{60, 0.596, 0.467}, EXODAR_PORTAL, 60, true, nil, "EXODAR_PORTAL"}, -- Shattrath City --> Exodar
   
   {{67, 0.401, 0.628}, STORMWIND_CITY_PORTAL, 60, true, nil, "STORMWIND_CITY_PORTAL"}, -- Dalaran --> Stormwind City
   {{67, 0.395, 0.640}, IRONFORGE_PORTAL, 60, true, nil, "IRONFORGE_PORTAL"}, -- Dalaran --> Ironforge
   {{67, 0.389, 0.651}, DARNASSUS_PORTAL, 60, true, nil, "DARNASSUS_PORTAL"}, -- Dalaran --> Darnassus
   {{67, 0.382, 0.664}, EXODAR_PORTAL, 60, true, nil, "EXODAR_PORTAL"}, -- Dalaran --> Exodar
   {{67, 0.371, 0.667}, SHATTRATH_CITY_PORTAL, 60, true, nil, "SHATTRATH_CITY_PORTAL"}, -- Dalaran --> Shatt
   
   {{21,0.405,0.817}, BLASTED_LANDS_PORTAL, 60, true, level_limit = 58},  -- Darnassus --> Blasted Lands
   {{12,0.462,0.609}, BLASTED_LANDS_PORTAL, 60, true, level_limit = 58},  -- Exodar --> Blasted Lands
   {{25,0.273,0.071}, BLASTED_LANDS_PORTAL, 60, true, level_limit = 58},  -- Ironforge --> Blasted Lands
   {{36,0.490,0.874}, BLASTED_LANDS_PORTAL, 60, true, level_limit = 58},  -- Stormwind --> Blasted Lands
  }

local static_shared_routes = 
  {
   {{11, 0.638, 0.387}, {38, 0.257, 0.73}, 210}, -- Ratchet <--> Booty Bay
   {{40, 0.318, 0.503}, {32, 0.347, 0.84}, 130}, -- Burning Steppes <--> Searing Gorge
   
   -- More Alliance routes than anything, but without them theres no valid path to these areas for Horde characters.
   {{24, 0.559, 0.896}, {21, 0.305, 0.414}, 5}, -- Rut'Theran Village <--> Darnassus
   {{16, 0.332, 0.398}, {24, 0.548, 0.971}, 210}, -- Auberdine <--> Rut'Theran Village
   {{16, 0.306, 0.409}, {3, 0.2, 0.546}, 210}, -- Auberdine <--> Azuremyst Isle
   
   -- Route to new zone. Not valid, exists only to keep routing from exploding if you don't have the flight routes there.
   {{41, 0.5, 0.5}, {64, 0.5, 0.5}, 7200}, -- Eversong Woods <--> Sunwell
   
   {{70, 0.235, 0.578}, {68, 0.496, 0.784}, 210}, -- Kamagua <--> Moa'ki
   {{65, 0.789, 0.536}, {68, 0.480, 0.787}, 210}, -- Unu'pe <--> Moa'ki
   {{67, 0.559, 0.467}, {66, 0.158, 0.428}, 60, true}, -- Dalaran --> Violet Stand
   {{66, 0.157, 0.425}, {67, 0.559, 0.468}, 60, true}, -- Violent Stand --> Dalaran (slightly different coordinates, may be important once solid walls are in)
   
   {{34, 0.817, 0.461}, {78, 0.492, 0.312}, 86400}, -- EPL Ebon Hold <--> Scarlet Enclave Ebon Hold. Exists solely to fix some pathing crashes. 24-hour boat ride :D
   
   {{67, 0.256, 0.515}, {8, 0.659, 0.498}, 5, true}, -- Dalaran --> CoT
   
   -- Wrath instance entrances
   {{80, 0.693, 0.730}, {70, 0.573, 0.467}, 5}, -- UK
   {{86, 0.362, 0.880}, {65, 0.275, 0.260}, 5}, -- Nexus
   {{92, 0.094, 0.933}, {68, 0.260, 0.508}, 5}, -- AN
   {{94, 0.900, 0.791}, {68, 0.285, 0.517}, 5}, -- AK
   {{96, 0.294, 0.810}, {75, 0.286, 0.869}, 5}, -- Draktharon
   {{100, 0.469, 0.780}, {67, 0.679, 0.694}, 5}, -- VH
   {{102, 0.590, 0.309}, {75, 0.764, 0.214}, 5}, -- Gundrak NW
   {{102, 0.344, 0.312}, {75, 0.810, 0.286}, 5}, -- Gundrak SE
   {{104, 0.344, 0.362}, {73, 0.397, 0.269}, 5}, -- HoS
   {{106, 0.020, 0.538}, {73, 0.453, 0.216}, 5}, -- HoL
   {{110, 0.613, 0.476}, {65, 0.275, 0.266}, 5}, -- Oculus
   {{120, 0.875, 0.712}, {8, 0.614, 0.626}, 5}, -- CoT
   {{124, 0.445, 0.161}, {70, 0.573, 0.467}, 5}, -- UP
   {{126, 0.500, 0.500}, {74, 0.500, 0.115}, 5}, -- VoA, zone-in link is incorrect
   {{128, 0.500, 0.500}, {68, 0.873, 0.510}, 5}, -- Naxx, zone-in link is incorrect (but might be close)
   {{140, 0.635, 0.501}, {68, 0.600, 0.566}, 5}, -- Sarth
   {{142, 0.500, 0.500}, {65, 0.275, 0.267}, 5}, -- Malygos, zone-in link is incorrect (not that it matters with malygos)
   {{144, 0.500, 0.500}, {73, 0.416, 0.179}, 5}, -- Ulduar, zone-in link is incorrect
   {{155, 0.426, 0.203}, {71, 0.548, 0.899}, 5}, -- Forge of Souls
   {{157, 0.410, 0.801}, {71, 0.547, 0.916}, 5}, -- Pit of Saron
   
   -- Wrath in-zone links, all currently incorrect
    -- UK
    {{80, 0.500, 0.500}, {82, 0.500, 0.500}, 5},
    {{80, 0.500, 0.500}, {84, 0.500, 0.500}, 5},
    
    -- AN
    {{88, 0.500, 0.500}, {90, 0.500, 0.500}, 5},
    {{88, 0.500, 0.500}, {92, 0.500, 0.500}, 5},
    
    -- Drak
    {{96, 0.500, 0.500}, {98, 0.500, 0.500}, 5},
    
    -- HoL
    {{106, 0.500, 0.500}, {108, 0.500, 0.500}, 5},
    
    -- Oculus
    {{110, 0.500, 0.500}, {112, 0.500, 0.500}, 5},
    {{110, 0.500, 0.500}, {114, 0.500, 0.500}, 5},
    {{110, 0.500, 0.500}, {116, 0.500, 0.500}, 5},
    
    -- CoT
    {{120, 0.500, 0.500}, {118, 0.500, 0.500}, 5},
    
    -- UP
    {{122, 0.500, 0.500}, {124, 0.500, 0.500}, 5},
    
    -- Naxx
    {{128, 0.500, 0.500}, {130, 0.500, 0.500}, 5},
    {{128, 0.500, 0.500}, {132, 0.500, 0.500}, 5},
    {{128, 0.500, 0.500}, {134, 0.500, 0.500}, 5},
    {{128, 0.500, 0.500}, {136, 0.500, 0.500}, 5},
    {{128, 0.500, 0.500}, {138, 0.500, 0.500}, 5},
    
    -- Ulduar
    {{144, 0.500, 0.500}, {146, 0.500, 0.500}, 5},
    {{144, 0.500, 0.500}, {148, 0.500, 0.500}, 5},
    {{144, 0.500, 0.500}, {150, 0.500, 0.500}, 5},
    {{144, 0.500, 0.500}, {152, 0.500, 0.500}, 5},
  }

-- Darkportal is handled specially, depending on whether or not you're level 58+ or not.
local dark_portal_route = {{33, 0.587, 0.599}, {56, 0.898, 0.502}, 60}

local static_zone_transitions =
  {
   {2, 11, 0.687, 0.872}, -- Ashenvale <--> The Barrens
   {2, 6, 0.423, 0.711}, -- Ashenvale <--> Stonetalon Mountains
   {2, 15, 0.954, 0.484}, -- Ashenvale <--> Azshara
   {2, 16, 0.289, 0.144}, -- Ashenvale <--> Darkshore
   {2, 13, 0.557, 0.29}, -- Ashenvale <--> Felwood
   {21, 24, 0.894, 0.358}, -- Darnassus <--> Teldrassil
   {22, 11, 0.697, 0.604}, -- Mulgore <--> The Barrens
   {22, 23, 0.376, 0.33}, -- Mulgore <--> Thunder Bluff
   {22, 23, 0.403, 0.193}, -- Mulgore <--> Thunder Bluff
   {3, 12, 0.247, 0.494}, -- Azuremyst Isle <--> The Exodar
   {3, 12, 0.369, 0.469}, -- Azuremyst Isle <--> The Exodar
   {3, 12, 0.310, 0.487}, -- Azuremyst Isle <--> The Exodar
   {3, 12, 0.335, 0.494}, -- Azuremyst Isle <--> The Exodar
   {3, 9, 0.42, 0.013}, -- Azuremyst Isle <--> Bloodmyst Isle
   {4, 6, 0.539, 0.032}, -- Desolace <--> Stonetalon Mountains
   {4, 17, 0.428, 0.976}, -- Desolace <--> Feralas
   {5, 18, 0.865, 0.115}, -- Silithus <--> Un'Goro Crater
   {7, 11, 0.341, 0.424}, -- Durotar <--> The Barrens
   {7, 1, 0.455, 0.121}, -- Durotar <--> Orgrimmar
   {8, 18, 0.269, 0.516}, -- Tanaris <--> Un'Goro Crater
   {8, 14, 0.512, 0.21}, -- Tanaris <--> Thousand Needles
   {10, 11, 0.287, 0.472}, -- Dustwallow Marsh <--> The Barrens
   {10, 11, 0.563, 0.077}, -- Dustwallow Marsh <--> The Barrens
   {11, 14, 0.442, 0.915}, -- The Barrens <--> Thousand Needles
   {13, 19, 0.685, 0.06}, -- Felwood <--> Winterspring
   {13, 20, 0.669, -0.063}, -- Felwood <--> Moonglade
   {1, 11, 0.118, 0.69}, -- Orgrimmar <--> The Barrens
   {17, 14, 0.899, 0.46}, -- Feralas <--> Thousand Needles
   {6, 11, 0.836, 0.973}, -- Stonetalon Mountains <--> The Barrens
   {26, 48, 0.521, 0.7}, -- Alterac Mountains <--> Hillsbrad Foothills
   {26, 35, 0.173, 0.482}, -- Alterac Mountains <--> Silverpine Forest
   {26, 50, 0.807, 0.347}, -- Alterac Mountains <--> Western Plaguelands
   {39, 51, 0.454, 0.89}, -- Arathi Highlands <--> Wetlands
   {39, 48, 0.2, 0.293}, -- Arathi Highlands <--> Hillsbrad Foothills
   {27, 29, 0.49, 0.071}, -- Badlands <--> Loch Modan
   -- {27, 32, -0.005, 0.636}, -- Badlands <--> Searing Gorge  -- This is the "alliance-only" locked path, I'm disabling it for now entirely
   {33, 46, 0.519, 0.051}, -- Blasted Lands <--> Swamp of Sorrows
   {40, 30, 0.79, 0.842}, -- Burning Steppes <--> Redridge Mountains
   {47, 31, 0.324, 0.363}, -- Deadwind Pass <--> Duskwood
   {47, 46, 0.605, 0.41}, -- Deadwind Pass <--> Swamp of Sorrows
   {28, 25, 0.534, 0.349}, -- Dun Morogh <--> Ironforge
   {28, 29, 0.863, 0.514}, -- Dun Morogh <--> Loch Modan
   {28, 29, 0.844, 0.31}, -- Dun Morogh <--> Loch Modan
   {31, 37, 0.801, 0.158}, -- Duskwood <--> Elwynn Forest
   {31, 37, 0.15, 0.214}, -- Duskwood <--> Elwynn Forest
   {31, 38, 0.447, 0.884}, -- Duskwood <--> Stranglethorn Vale
   {31, 38, 0.209, 0.863}, -- Duskwood <--> Stranglethorn Vale
   {31, 30, 0.941, 0.103}, -- Duskwood <--> Redridge Mountains
   {31, 49, 0.079, 0.638}, -- Duskwood <--> Westfall
   {34, 50, 0.077, 0.661}, -- Eastern Plaguelands <--> Western Plaguelands
   {34, 44, 0.575, 0.000}, -- Eastern Plaguelands <--> Ghostlands
   {37, 36, 0.321, 0.493}, -- Elwynn Forest <--> Stormwind City   -- Don't need to convert because it's in Elwynn coordinates, not Stormwind coordinates
   {37, 49, 0.202, 0.804}, -- Elwynn Forest <--> Westfall
   {37, 30, 0.944, 0.724}, -- Elwynn Forest <--> Redridge Mountains
   {41, 52, 0.567, 0.494}, -- Eversong Woods <--> Silvermoon City
   {41, 44, 0.486, 0.916}, -- Eversong Woods <--> Ghostlands
   {35, 43, 0.678, 0.049}, -- Silverpine Forest <--> Tirisfal Glades
   {42, 50, 0.217, 0.264}, -- The Hinterlands <--> Western Plaguelands
   {43, 45, 0.619, 0.651}, -- Tirisfal Glades <--> Undercity
   {43, 50, 0.851, 0.703}, -- Tirisfal Glades <--> Western Plaguelands
   {38, 49, 0.292, 0.024}, -- Stranglethorn Vale <--> Westfall
   {48, 35, 0.137, 0.458}, -- Hillsbrad Foothills <--> Silverpine Forest
   {48, 42, 0.899, 0.253}, -- Hillsbrad Foothills <--> The Hinterlands
   {29, 51, 0.252, 0}, -- Loch Modan <--> Wetlands
   
   -- These are just guesses, since I haven't actually been to these areas.
   --{58, 60, 0.783, 0.545}, -- Nagrand <--> Shattrath City   -- this is aldor-only
   {60, 55, 0.782, 0.492}, -- Shattrath City <--> Terokkar Forest
   {54, 59, 0.842, 0.284}, -- Blade's Edge Mountains <--> Netherstorm
   {54, 57, 0.522, 0.996}, -- Blade's Edge Mountains <--> Zangarmarsh
   {54, 57, 0.312, 0.94}, -- Blade's Edge Mountains <--> Zangarmarsh
   {56, 55, 0.353, 0.901}, -- Hellfire Peninsula <--> Terokkar Forest
   {56, 57, 0.093, 0.519}, -- Hellfire Peninsula <--> Zangarmarsh
   {58, 55, 0.8, 0.817}, -- Nagrand <--> Terokkar Forest
   {58, 57, 0.343, 0.159}, -- Nagrand <--> Zangarmarsh
   {58, 57, 0.754, 0.331}, -- Nagrand <--> Zangarmarsh
   {53, 55, 0.208, 0.271}, -- Shadowmoon Valley <--> Terokkar Forest
   {55, 57, 0.341, 0.098}, -- Terokkar Forest <--> Zangarmarsh
   
   -- Most of these are also guesses :)
   {65, 72, 0.547, 0.059}, -- Borean Tundra <--> Sholazar Basin
   {65, 68, 0.967, 0.359}, -- Borean Tundra <--> Dragonblight
   {74, 72, 0.208, 0.191}, -- Wintergrasp <--> Sholazar 
   {68, 74, 0.250, 0.410}, -- Dragonblight <--> Wintergrasp
   {68, 71, 0.359, 0.155}, -- Dragonblight <--> Icecrown
   {68, 66, 0.612, 0.142}, -- Dragonblight <--> Crystalsong
   {68, 75, 0.900, 0.200}, -- Dragonblight <--> Zul'Drak
   {68, 69, 0.924, 0.304}, -- Dragonblight <--> Grizzly Hills
   {68, 69, 0.931, 0.634}, -- Dragonblight <--> Grizzly Hills
   {70, 69, 0.540, 0.042}, -- Howling Fjord <--> Grizzly Hills
   {70, 69, 0.233, 0.074}, -- Howling Fjord <--> Grizzly Hills
   {70, 69, 0.753, 0.060}, -- Howling Fjord <--> Grizzly Hills
   {69, 75, 0.432, 0.253}, -- Grizzly Hills <--> Zul'Drak
   {69, 75, 0.583, 0.136}, -- Grizzly Hills <--> Zul'Drak
   {66, 75, 0.967, 0.599}, -- Crystalsong <--> Zul'Drak
   {66, 71, 0.156, 0.085}, -- Crystalsong <--> Icecrown
   {66, 73, 0.706, 0.315}, -- Crystalsong <--> Storm Peaks
   {66, 73, 0.839, 0.340}, -- Crystalsong <--> Storm Peaks
   {71, 73, 0.920, 0.767}, -- Icecrown <--> Storm Peaks
}

if QuestHelper:IsWrath32() then
  table.insert(static_zone_transitions, {153, 71, 0.5, 0.5}) -- Hrothgar's Landing <--> Icecrown
end

function load_graph_links()
  local function convert_coordinate(coord)
    QuestHelper: Assert(coord[1] and coord[2] and coord[3])
    QuestHelper: Assert(QuestHelper_ZoneLookup[coord[1]])
    local c, x, y = QuestHelper.Astrolabe:GetAbsoluteContinentPosition(QuestHelper_ZoneLookup[coord[1]][1], QuestHelper_ZoneLookup[coord[1]][2], coord[2], coord[3])
    QuestHelper: Assert(c)
    return {x = x, y = y, p = coord[1], c = c}
  end

  local function do_routes(routes)
    for _, v in ipairs(routes) do
      if not v.level_limit or v.level_limit <= UnitLevel("player") then
        local src = convert_coordinate(v[1])
        local dst = convert_coordinate(v[2])
        QuestHelper: Assert(src.x and dst.x)
        src.map_desc = {QHFormat("WAYPOINT_REASON", QuestHelper_NameLookup[v[2][1]])}
        dst.map_desc = {QHFormat("WAYPOINT_REASON", QuestHelper_NameLookup[v[1][1]])}
        
        local rev_cost = v[3]
        if v[4] then rev_cost = nil end
        QH_Graph_Plane_Makelink("static_route", src, dst, v[3], rev_cost) -- this couldn't possibly fail
      end
    end
  end
  
  local faction_db
  if UnitFactionGroup("player") == "Alliance" then
    faction_db = static_alliance_routes
  else
    faction_db = static_horde_routes
  end
  
  do_routes(faction_db)
  do_routes(static_shared_routes)
  
  for _, v in ipairs(static_zone_transitions) do
    local src = convert_coordinate({v[1], v[3], v[4]})
    local dst = convert_coordinate({v[1], v[3], v[4]})
    dst.p = v[2]
    src.map_desc = {QHFormat("WAYPOINT_REASON", QHFormat("ZONE_BORDER_SIMPLE", QuestHelper_NameLookup[v[2]]))}
    dst.map_desc = {QHFormat("WAYPOINT_REASON", QHFormat("ZONE_BORDER_SIMPLE", QuestHelper_NameLookup[v[1]]))}
    QH_Graph_Plane_Makelink("static_transition", src, dst, 0, 0)
  end
  
  do
    local src = convert_coordinate(dark_portal_route[1])
    local dst = convert_coordinate(dark_portal_route[2])
    src.map_desc = {QHFormat("WAYPOINT_REASON", QHFormat("ZONE_BORDER_SIMPLE", QuestHelper_NameLookup[dark_portal_route[2]]))}
    dst.map_desc = {QHFormat("WAYPOINT_REASON", QHFormat("ZONE_BORDER_SIMPLE", QuestHelper_NameLookup[dark_portal_route[1]]))}
    QH_Graph_Plane_Makelink("dark_portal", src, dst, 15, 15)
  end
end
