local BS = LibStub("LibBabble-Spell-3.0"):GetLookupTable()

local channels = {"yell", "raidWarning", "raid", "party", "print", "channel"}

local f = CreateFrame("frame")

f:RegisterEvent("UNIT_SPELLCAST_SENT")
f:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

f:SetScript("OnEvent", function(self, event, unit, spell, _, player)
	if unit == "player" and spell == BS["Misdirection"] then
		if event == "UNIT_SPELLCAST_SENT" then
			self.player = player
		elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
			ZMisdirect_Announce(self.player)
		end

	end
end)

function ZMisdirect_Announce(player)
	if not player then return end
	local tbl = ZHunterMod_Saved.ZMisdirect
	local message = tbl.format:gsub("$player", player)
	local channelNum = tbl.channelNum
	for i, v in ipairs(channels) do
		if tbl[v] or (tbl[v] == nil and IsInInstance()) then
			ZHunter[v](message, channelNum)
		end
	end
end

ZHunterModOptions.args.misdirect = {
	type = "group",
	name = "Misdirect",
	desc = "Options to customize the Misdirect messages.",
	order = 6,
	args = {
		description = {
			type = "description",
			name = "Use the gray check to only broadcast when you're in an instance.",
			order = 1
		},
		format = {
			type = "input",
			name = "Message Format",
			desc = "Set the format of how the message is broadcast. Use '$player' to represent the player's name when broadcast.",
			order = 2,
			get = function(info) return ZHunterMod_Saved.ZMisdirect.format end,
			set = function(info, v) ZHunterMod_Saved.ZMisdirect.format = v end
		}
	}
}

ZHunterModOptions_SetBroadcastOptions("ZMisdirect", ZHunterModOptions.args.misdirect.args)