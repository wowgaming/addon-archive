local default = {
	version = 1,
	ZAutoShot = {
		on = true
	},
	ZMisdirect = {
		format = "Misdirected $player",
		party = false,
		raid = false,
		raidWarning = false,
		yell = true,
		channel = false,
		channelNum = 9,
		print = true
	},
	ZFreezeFail = {
		format = "Freeze failed on $player ($type)",
		party = false,
		raid = false,
		raidWarning = true,
		yell = false,
		channel = false,
		channelNum = 9,
		print = true,
		playSound = false
	},
	ZArcaneDispel = {
		format = ">$spell< removed from $player",
		party = false,
		raid = false,
		raidWarning = true,
		yell = false,
		channel = false,
		channelNum = 9,
		print = true,
		condition = "Blessing of Protection\nBlessing of Freedom\nPain Suppression"
	},
	ZAntiDaze = {
		on = false
	}
}

local pairs = pairs
local type = type

local function validate(src, dest)
	for i, v in pairs(src) do
		local varType = type(v)
		if varType == "table" then
			if type(dest[i]) ~= "table" then
				dest[i] = {}
			end
			validate(v, dest[i])
		else
			local otherType = type(dest[i])
			if varType ~= otherType then
				if varType ~= "boolean" or otherType ~= "nil" then
					dest[i] = v
				end
			end
		end
	end
end

local f = CreateFrame("frame")
f:RegisterEvent("VARIABLES_LOADED")
f:SetScript("OnEvent", function()
	if not ZHunterMod_Saved or default.version ~= ZHunterMod_Saved.version then
		ZHunterMod_Saved = {}
	end
	validate(default, ZHunterMod_Saved)
	ZArcaneDispelParse(ZHunterMod_Saved.ZArcaneDispel.desiredSpells)
end)