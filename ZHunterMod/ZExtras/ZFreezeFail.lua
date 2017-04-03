local channels = {"yell", "raidWarning", "raid", "party", "channel"}

function ZFreezeFail(destName, missType)
	local tbl = ZHunterMod_Saved["ZFreezeFail"]
	if tbl.playSound then
		PlaySoundFile("Sound\\Creature\\Basilisk\\mBasiliskAttackC.wav")
	end
	missType = missType and missType:lower() or ""
	local message = tbl.format or "Freeze failed on $player. ($type)"
	local newmessage
	newmessage = message:gsub("$player", destName)
	newmessage = newmessage:gsub("$type", missType)
	local channelNum = tbl.channelNum
	for i, v in ipairs(channels) do
		if tbl[v] or (tbl[v] == nil and IsActiveBattlefieldArena()) then
			ZHunter[v](newmessage, channelNum)
		end
	end
	if tbl.print or (tbl.print == nil and IsActiveBattlefieldArena()) then
		newmessage = message:gsub("$player", destName)
		newmessage = newmessage:gsub("$type", "|cFFFF0000"..missType.."|r")
		ZHunter.print(newmessage)
	end
end

ZHunterModOptions.args.freezefail = {
	type = "group",
	name = "Freeze Fail",
	desc = "Options to customize the message when Freezing Trap fails.",
	order = 7,
	args = {
		description = {
			type = "description",
			name = "Use the gray check to only broadcast when you're in an arena.",
			order = 1
		},
		format = {
			type = "input",
			name = "Message",
			desc = "Change the format of the broadcast message. Use '$player' and '$type' to print the target of the trap and type of failure (resist/immune).",
			order = 2,
			get = function(info) return ZHunterMod_Saved.ZFreezeFail.format end,
			set = function(info, v) ZHunterMod_Saved.ZFreezeFail.format = v end
		},
		playSound = {
			type = "toggle",
			name = "Play Sound",
			desc = "Toggle the playing of a sound when your trap fails.",
			order = 3,
			get = function(info) return ZHunterMod_Saved.ZFreezeFail.playSound end,
			set = function(info, v) ZHunterMod_Saved.ZFreezeFail.playSound = v end
		}
	}
}

ZHunterModOptions_SetBroadcastOptions("ZFreezeFail", ZHunterModOptions.args.freezefail.args)