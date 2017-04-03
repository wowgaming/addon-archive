-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

XPerl_SetModuleRevision("$Revision: 176 $")

-- XPerl_SlashHandler
local function XPerl_SlashHandler(msg)
	local args = {}

	for value in string.gmatch(msg, "[^ ]+") do
		tinsert(args, string.lower(value))
	end
	if (args[1]=="") then
		XPerl_OptionsMenu_Frame:Show()
		return
	end

	if (args[1] == nil or args[1] == XPERL_CMD_MENU or args[1] == XPERL_CMD_OPTIONS) then
		XPerl_UnlockFrames()

	elseif (args[1] == XPERL_CMD_LOCK) then
		XPerlLocked = 1
		if (XPerl_RaidTitles) then
			XPerl_RaidTitles()
			if (XPerl_RaidPets_Titles) then
				XPerl_RaidPets_Titles()
			end
		end

	elseif (args[1] == XPERL_CMD_UNLOCK) then
		XPerlLocked = 0
		if (XPerl_RaidTitles) then
			XPerl_RaidTitles()
			if (XPerl_RaidPets_Titles) then
				XPerl_RaidPets_Titles()
			end
		end

	elseif (args[1] == XPERL_CMD_CONFIG) then
		if (args[2] == XPERL_CMD_LIST) then
			local current
			XPerl_Notice(XPERL_CONFIG_LIST)
			for realmName,realmList in pairs(XPerlConfigNew) do
				if (type(realmList) == "table" and realmName ~= "global" and realmName ~= "savedPositions") then
					for playerName, realmSettings in pairs(realmList) do
						if (strlower(realmName) == strlower(GetRealmName()) and strlower(playerName) == myName) then
							current = XPERL_CONFIG_CURRENT
						else
							current = ""
						end

						DEFAULT_CHAT_FRAME:AddMessage(format("|c00FFFF80%s - %s%s", realmName, playerName, current))
					end
				end
			end

		elseif (args[2] == XPERL_CMD_DELETE) then
			if (args[3] and args[4]) then
				local me = GetRealmName().."/"..UnitName("player")

				if (strlower(args[3]) ~= strlower(GetRealmName()) and strlower(args[4]) ~= strlower(UnitName("player"))) then

					for realmName,realmList in pairs(XPerlConfigNew) do
						if (strlower(realmName) == strlower(args[3]) and type(realmList) == "table" and realmName ~= "global" and realmName ~= "savedPositions") then
							for playerName, realmSettings in pairs(realmList) do
								if (strlower(playerName) == strlower(args[4])) then
									XPerlConfigNew[realmName][playerName] = nil
									XPerl_Notice(XPERL_CONFIG_DELETED, realmName, playerName)
									return
								end
							end
						end
					end

					XPerl_Notice(XPERL_CANNOT_FIND_DELETE_TARGET, args[3], args[4])

				else
					XPerl_Notice(XPERL_CANNOT_DELETE_CURRENT)
				end
			else
				XPerl_Notice(XPERL_CANNOT_DELETE_BADARGS)
			end
		end


	else
		DEFAULT_CHAT_FRAME:AddMessage(XPERL_CMD_HELP)
	end
end

SlashCmdList["XPERL"] = XPerl_SlashHandler
SLASH_XPERL1 = "/xperl"
