-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

if (not XPerl_GetUsage) then

local conf
XPerl_RequestConfig(function(new) conf = new end, "$Revision: 384 $")

XPerl_Usage = {}

local new, del, copy = XPerl_GetReusableTable, XPerl_FreeTable, XPerl_CopyTable

local mod = CreateFrame("Frame", "XPerl_UsageFrame")
mod:RegisterEvent("PLAYER_ENTERING_WORLD")
mod:RegisterEvent("CHAT_MSG_ADDON")
mod:RegisterEvent("RAID_ROSTER_UPDATE")
mod:RegisterEvent("PARTY_MEMBERS_CHANGED")

local function modOnEvent(self, event, ...)
	local f = mod[event]
	if (f) then
		f(mod, ...)
	end
end

mod:SetScript("OnEvent", modOnEvent)
mod.notifiedVersion = nil

GameTooltip:HookScript("OnTooltipSetUnit",
	function(self)
		local name, unitid = self:GetUnit()
		if (not unitid) then
			unitid = "mouseover"
		end
		mod:TooltipInfo(self, unitid)
	end)


local function UnitFullName(unit)
	local n,s = UnitName(unit)
	if (s and s ~= "") then
		return n.."-"..s
	end
	return n
end

function mod:TooltipInfo(tooltip, unitid)
	if (unitid and conf and conf.tooltip.xperlInfo and UnitIsPlayer(unitid) and UnitIsFriend(unitid, "player")) then
		local xpUsage = XPerl_GetUsage(UnitFullName(unitid), unitid)
		if (xpUsage) then
			local xp = "|cFFD00000X-Perl|r "..(xpUsage.version or XPerl_VersionNumber)

			if (xpUsage.revision) then
				local r = "r"..xpUsage.revision
				xp = format("%s |cFF%s%s", xp, r == XPerl_GetRevision() and "80FF80" or "FF8080", r)
			elseif (UnitIsUnit("player", unitid)) then
				xp = xp.." |cFF80FF80"..XPerl_GetRevision()
			end

			if (xpUsage.mods and IsShiftKeyDown()) then
				local modList = self:DecodeModuleList(xpUsage.mods)
				if (modList) then
					xp = xp.." : |c00909090"..modList
				end
			end

			GameTooltip:AddLine(xp, 1, 1, 1, 1)
			GameTooltip:Show()
		end
	end
end

-- CheckForNewerVersion
function mod:CheckForNewerVersion(ver)
	if (not strfind(strlower(ver), "beta")) then
		if (ver > XPerl_VersionNumber) then
			if (not self.notifiedVersion or self.notifiedVersion < ver) then
				self.notifiedVersion = ver

				if (not conf or conf.tooltip.xperlInfo) then
					DEFAULT_CHAT_FRAME:AddMessage(format(XPERL_USAGE_AVAILABLE, XPerl_ProductName, ver))
				end
			end
			return true
		end
	end
end

-- ProcessXPerlMessage
function mod:ProcessXPerlMessage(sender, msg, channel)
	local myUsage = XPerl_Usage[sender]

	if (strsub(msg, 1, 4) == "VER ") then
		-- ChatFrame7:AddMessage(" Received info from "..sender..", channel: "..channel)
		if (not myUsage) then
			myUsage = {}
			XPerl_Usage[sender] = myUsage
		end

		if (XPerlTest) then myUsage.packets = (myUsage.packets or 0) + 1 end

		myUsage.old = nil
		local ver = strsub(msg, 5)

		if (ver == XPerl_VersionNumber) then
			myUsage.version = nil
		else
			myUsage.version = ver
			self:CheckForNewerVersion(ver)			-- Won't do a per revision check
		end

		if (channel ~= "WHISPER" and sender and sender ~= UnitName("player")) then
			self:SendModules("WHISPER", sender)
		end

	elseif (strsub(msg, 1, 4) == "REV ") then
		if (myUsage) then
			local temp = strmatch(strsub(msg, 5), "(%d+)")
			if (temp) then
				myUsage.revision = tonumber(temp)
			end
		end

	elseif (strsub(msg, 1, 7) == "MAXVER ") then
		local ver = strsub(msg, 8)
		if (ver >= XPerl_VersionNumber) then
			self:CheckForNewerVersion(ver)
		end

	elseif (msg == "S") then
		if (channel == "WHISPER") then
			-- Version only sent, so ask for rest
			SendAddonMessage(XPERL_COMMS_PREFIX, "ASK", channel, sender)
		end

	elseif (msg == "ASK") then
		if (channel == "WHISPER") then
			-- Details asked for
			self:SendModules("WHISPER", sender)
		end

	elseif (strsub(msg, 1, 4) == "MOD ") then
		if (myUsage) then
			myUsage.mods = strsub(msg, 5)
		end

	elseif (strsub(msg, 1, 4) == "LOC ") then
		if (myUsage) then
			local loc = strsub(msg, 5)
			if (loc ~= GetLocale()) then
				myUsage.locale = loc
			end
		end

	elseif (strsub(msg, 1, 3) == "GC ") then
		if (myUsage) then
			myUsage.gc = tonumber(strsub(msg, 4))
		end
	end
end

-- GeneralTooltip
function mod:GeneralTooltip(name, anchor)
	if (name) then
		local xpUsage = XPerl_Usage[name]
		if (xpUsage) then
			local ver
			if (xpUsage.version) then
				ver = xpUsage.version
			else
				ver = XPerl_VersionNumber
			end

			GameTooltip:SetOwner(anchor, "ANCHOR_BOTTOMRIGHT")
			GameTooltip:ClearLines()

			local str
			if (xpUsage.revision) then
				local r = "r"..xpUsage.revision
				str = format("%s %s |cFF%s%s", XPerl_ProductName, ver, r == XPerl_GetRevision() and "80FF80" or "FF8080", r)
			elseif (name == UnitName("player")) then
				str = format("%s %s |cFF80FF80%s", XPerl_ProductName, ver, XPerl_GetRevision())
			else
				str = format("%s %s", XPerl_ProductName, ver)
			end

			if (xpUsage.locale) then
				GameTooltip:AddDoubleLine(str, xpUsage.locale, 1, 1, 1, 0.5, 0.5, 0.5)
			else
				GameTooltip:SetText(str, 1, 1, 1)
			end

			if (xpUsage.version and self:CheckForNewerVersion(xpUsage.version)) then
				GameTooltip:AddLine(XPERL_USAGE_NEWVERSION, 0.5, 1, 0.5)
			end

			if (xpUsage.mods) then
				local modList = self:DecodeModuleList(xpUsage.mods)
				if (modList) then
					GameTooltip:AddLine(XPERL_USAGE_MODULES..modList, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
				end
			end

			if (xpUsage.gc and IsShiftKeyDown()) then
				GameTooltip:AddLine(format(XPERL_USAGE_MEMMAX, xpUsage.gc), 0.8, 0.2, 0.2)
			end

			GameTooltip:Show()
			return
		end
	end

	GameTooltip:Hide()
end

-- GuildMateTooltip
local function XPerl_GuildMateTooltip(self)
	if (not conf.tooltip.xperlInfo) then
		return
	end

	local name, rank, rankIndex, level, class, zone, note, officernote, online = GetGuildRosterInfo(self.guildIndex)
	mod:GeneralTooltip(name, self)
end

-- XPerl_FriendTooltip
local function XPerl_FriendTooltip(self)
	if (not conf.tooltip.xperlInfo) then
		return
	end

	local name, level, class, area, connected, status = GetFriendInfo(self:GetID())
	mod:GeneralTooltip(name, self)
end

-- XPerl_WhoTooltip
local function XPerl_WhoTooltip(self)
	if (not conf.tooltip.xperlInfo) then
		return
	end

	local name, guild, level, race, class, zone = GetWhoInfo(self.whoIndex)
	mod:GeneralTooltip(name, self)
end

-- XPerl_UsageStartup
function mod:PLAYER_ENTERING_WORLD()
	if (conf.tooltip.xperlInfo) then			-- FOR TESTING
		-- If this cures taint problem, then put a frame mask over whole guild area and use MouseIsOver()
		-- Check for nil for GUILDMEMBERS_TO_DISPLAY
		if not (GUILDMEMBERS_TO_DISPLAY == nil) then 
                        -- Hook the guild name list to show tooltip for X-Perl users
                        for i = 1,GUILDMEMBERS_TO_DISPLAY do
                                local f = _G["GuildFrameButton"..i]
                                if (f) then
                                        f:SetScript("OnEnter", XPerl_GuildMateTooltip)
                                        f:SetScript("OnLeave", XPerl_PlayerTipHide)
                                end
                                f = _G["GuildFrameGuildStatusButton"..i]
                                if (f) then
                                        f:SetScript("OnEnter", XPerl_GuildMateTooltip)
                                        f:SetScript("OnLeave", XPerl_PlayerTipHide)
                                end
                        end
		end

		for i = 1,FRIENDS_TO_DISPLAY do
			local f = _G["FriendsFrameFriendButton"..i]
			if (f) then
				f:SetScript("OnEnter", XPerl_FriendTooltip)
				f:SetScript("OnLeave", XPerl_PlayerTipHide)
			end
		end

		for i = 1,WHOS_TO_DISPLAY do
			local f = _G["WhoFrameButton"..i]
			if (f) then
				f:SetScript("OnEnter", XPerl_WhoTooltip)
				f:SetScript("OnLeave", XPerl_PlayerTipHide)
			end
		end

		self:SendModules()			-- No channel given will detect BG, RAID, PARTY
		if (IsInGuild()) then
			self:SendModules("GUILD")
		end
	end
end

-- RAID_ROSTER_UPDATE
function mod:RAID_ROSTER_UPDATE()
	if (GetNumRaidMembers() > 0) then
		if (not self.inRaid) then
			self.inRaid = true
			self:SendModules()
		end
	else
		self.inRaid = nil
	end
end

-- PARTY_MEMBERS_CHANGED
function mod:PARTY_MEMBERS_CHANGED()
	if (GetNumPartyMembers() > 0) then
		if (not self.inParty and not self.inRaid) then
			self.inParty = true
			self:SendModules("PARTY")			-- Let other X-Perl users know which version we're running
		end
	else
		self.inParty = nil
	end
end

-- CHAT_MSG_ADDON
function mod:CHAT_MSG_ADDON(prefix, msg, channel, sender)
	if (prefix == XPERL_COMMS_PREFIX) then
		self:ParseCTRA(sender, msg, channel)
	end
end

-- XPerl_ParseCTRA
function mod:ParseCTRA(sender, msg, channel)
	local arr = new(strsplit("#", msg))
	for i,subMsg in pairs(arr) do
		self:ProcessXPerlMessage(sender, subMsg, channel)
	end
	del(arr)
end

-- !!!!! Don't change the order of this list - EVER!!!!!
local xpModList = {"XPerl", "XPerl_Player", "XPerl_PlayerPet", "XPerl_Target", "XPerl_TargetTarget", "XPerl_Party", "XPerl_PartyPet", "XPerl_RaidFrames", "XPerl_RaidHelper", "XPerl_RaidAdmin", "XPerl_TeamSpeak", "XPerl_RaidMonitor", "XPerl_RaidPets", "XPerl_ArcaneBar", "XPerl_PlayerBuffs", "XPerl_GrimReaper"}
--------------------------------------------------------

-- XPerl_SendModules
mod.throttle = {}
function mod:SendModules(chan, target)
	if (not chan) then
		if (GetNumRaidMembers() > 0) then
			if (select(2, IsInInstance()) == "pvp") then
				chan = "BATTLEGROUND"
			else
				chan = "RAID"
			end
		elseif (GetNumPartyMembers() > 0) then
			chan = "PARTY"
		end
	end

	if (chan) then
		if (chan == "PARTY" or chan == "RAID") then
			-- Cope with WoW 3.2 bug which says party members exist, when in BGs in fake raid
			local instance, pvp = IsInInstance()
			if (pvp == "arena" or pvp == "pvp") then
				return
			end
		end

		if (chan == "WHISPER") then
			local t = self.throttle[target]
			if (t and time() < t + 15) then
				return
			end
			self.throttle[target] = time()
		end

		local packet = self:MakePacket(chan == "WHISPER")
		SendAddonMessage(XPERL_COMMS_PREFIX, packet, chan, target)
	end
end

-- MakePacket
function mod:MakePacket(response, versionOnly)
	local resp
	if (response) then resp = "R#S#" else resp = "" end

	if (versionOnly) then
		return format("%sVER %s#REV %s", resp, XPerl_VersionNumber, XPerl_GetRevision())
	else
		local modules = ""
		for k,v in pairs(xpModList) do
			modules = modules..(tostring(IsAddOnLoaded(v) or 0))
		end
		local gc = floor(collectgarbage("count"))

		local s = format("%sVER %s#REV %s#GC %d#LOC %s#MOD %s", resp, XPerl_VersionNumber, XPerl_GetRevision(), gc, GetLocale(), modules)
		if (self.notifiedVersion and self.notifiedVersion > XPerl_VersionNumber) then
			s = format("%s#MAXVER %s", s, self.notifiedVersion)
		end
		return s
	end
end

-- XPerl_DecodeModuleList
function mod:DecodeModuleList(modList)
	local ret = new()
	for k,v in pairs(xpModList) do
		if (strsub(modList, k, k) == "1") then
			if (XPerlUsageNameList[v]) then
				tinsert(ret, XPerlUsageNameList[v])
			else
				tinsert(ret, v)
			end
		end
	end
	local tmp = table.concat(ret, ", ")
	del(ret)
	return tmp
end

-- XPerl_GetUsage
function XPerl_GetUsage(unitName, unitID)
	local ver = XPerl_Usage[unitName]
	if (not ver and XPerlTest) then
		if (unitID and unitName ~= UNKNOWN and (UnitIsPlayer(unitID) and UnitFactionGroup("player") == UnitFactionGroup(unitID) and UnitIsConnected(unitID))) then
			if (not mod.directQueries) then
				mod.directQueries = {}
			end
			if (not mod.directQueries[unitName]) then
				mod.directQueries[unitName] = true
				SendAddonMessage(XPERL_COMMS_PREFIX, mod:MakePacket(nil, true), "WHISPER", unitName)
			end
		end
	end

	return ver
end


end
