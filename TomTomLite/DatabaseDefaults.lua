local addonName, addon = ...
local L = addon.L

addon.defaults = {
    char = {},
    profile = {
        positions = {},

        corpseSource = true,
        questObjectivesSource = true,
        archaeologyDigSitesSource = true,

        showMapIconsZone = false,
        showMapIconsContinent = false,

        corpseArrow = true,

        goodcolor = {0, 1, 0},
        badcolor = {1, 0, 0},
        middlecolor = {1, 1, 0},
    },
}
