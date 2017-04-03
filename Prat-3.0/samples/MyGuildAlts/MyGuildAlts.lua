-- This is just an example, but you can fill it with alt = main entries
local alts = {
    somealt1 = "somemain1",
    somealt2 = "somemain2",
    somealt3 = "somemain1",
}


-- This function actually loads the alt data, you should modify this
local function loadAlts()
    local altregistry = LibStub("LibAlts-1.0")

-- Load shared Alts data
    for alt,main in pairs(alts) do
    	altregistry:SetAlt(main,alt)
    end
end

local function onEvent(self, event, ...)
    if event == "PLAYER_LOGIN" then
        self:UnregisterAllEvents()
        self:Hide()

        loadAlts()
    end
end

-- Delay loading the alt data until some event fires
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", onEvent)
f:Show()





