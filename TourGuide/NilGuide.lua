
local L = TourGuide.Locale

TourGuide:RegisterGuide("No Guide", nil, "Alliance", function() return L["K No guide loaded... |N|Click to select a guide|"] end)
TourGuide:RegisterGuide("No Guide", nil, "Horde", function() return L["K No guide loaded... |N|Click to select a guide|"] end)
