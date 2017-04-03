local PetInfo = IceCore_CreateClass(IceTargetInfo)

-- Constructor --
function PetInfo.prototype:init()
	PetInfo.super.prototype.init(self, "PetInfo", "pet")
end

function PetInfo.prototype:GetDefaultSettings()
	local settings = PetInfo.super.prototype.GetDefaultSettings(self)

	settings["enabled"] = false
	settings["vpos"] = -150
	settings["line2Tag"] = "[Level:DifficultyColor] [SmartRace:ClassColor] [HappyText:HappyColor] [PvPIcon] [InCombat ? 'Combat':Red]"

	return settings
end

function PetInfo.prototype:CreateFrame(redraw)
	PetInfo.super.prototype.CreateFrame(self, redraw)

	self.frame.menu = function()
		ToggleDropDownMenu(1, nil, PetFrameDropDown, "cursor")
	end
end

-- Load us up
IceHUD.PetInfo = PetInfo:new()
