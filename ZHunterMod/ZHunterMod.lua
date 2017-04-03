SLASH_ZHunter1 = "/ZHunter"
SLASH_ZHunter2 = "/ZHunterMod"
SlashCmdList["ZHunter"] = function()
	LibStub("AceConfigDialog-3.0"):Open("ZHunterMod")
end

ZHunter = {}

function ZHunter.raid(message)
	if GetNumRaidMembers() > 0 then
		SendChatMessage(message, "raid")
		return 1
	end
end

function ZHunter.party(message)
	if GetNumPartyMembers() > 0 then
		SendChatMessage(message, "party")
		return 1
	end
end

function ZHunter.raidWarning(message)
	if (IsRaidLeader() or IsRaidOfficer()) or (GetNumRaidMembers() == 0 and GetNumPartyMembers() > 0) then
		SendChatMessage(message, "raid_warning")
		return 1
	end
end

function ZHunter.print(message)
	DEFAULT_CHAT_FRAME:AddMessage("|cffffd200ZHunter:|r "..message, 1, 1, 1)
	return 1
end

function ZHunter.yell(message)
	SendChatMessage(message, "yell")
	return 1
end

function ZHunter.channel(message, channel)
	if channel and channel > 0 then
		SendChatMessage(message, "channel", nil, channel)
		return 1
	end
end

function ZHunterMod_AlignButtons(direction, distance)
	local t = {}
	t["BOTTOM"] = "TOP"
	t["TOP"] = "BOTTOM"
	t["LEFT"] = "RIGHT"
	t["RIGHT"] = "LEFT"
	distance = tonumber(distance) or 0
	local x, y = 0, 0
	direction = string.upper(direction or "BOTTOM")
	if direction == "TOP" or direction == "BOTTOM" then
		y = distance
	elseif direction == "LEFT" or direction == "RIGHT" then
		x = distance
	else
		direction = "BOTTOM"
		y = distance
	end
	if direction == "LEFT" or direction == "BOTTOM" then
		x = x * -1
		y = y * -1
	end
	ZTrack:ClearAllPoints()
	ZTrack:SetPoint(t[direction], ZAspect, direction, x, y)
	ZTrap:ClearAllPoints()
	ZTrap:SetPoint(t[direction], ZTrack, direction, x, y)
	ZPet:ClearAllPoints()
	ZPet:SetPoint(t[direction], ZTrap, direction, x, y)
end