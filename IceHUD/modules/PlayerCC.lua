-- changed to inherit from the TargetCC bar since the only difference is the unit and the default placement
-- helps keep changes in one place and we don't have to duplicate the CC spell tables and they don't have to be globals
local PlayerCC = IceCore_CreateClass(TargetCC)

-- Constructor --
function PlayerCC.prototype:init()
	PlayerCC.super.prototype.init(self, "PlayerCC", "player")
end

-- 'Public' methods -----------------------------------------------------------

-- OVERRIDE
function PlayerCC.prototype:GetDefaultSettings()
	local settings = PlayerCC.super.prototype.GetDefaultSettings(self)

	settings["side"] = IceCore.Side.Left
	settings["offset"] = 5

	return settings
end

-- 'Protected' methods --------------------------------------------------------

-- Load us up
IceHUD.PlayerCC = PlayerCC:new()
