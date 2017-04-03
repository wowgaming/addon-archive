--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 3.1.14 (<%codename%>)
	Revision: $Id: GatherComm.lua 754 2008-10-14 04:43:39Z Esamynn $

	License:
	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program(see GPL.txt); if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit licence to use this AddOn with these facilities
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat

	
]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/release/Gatherer/GatherComm.lua $", "$Rev: 754 $")

local _tr = Gatherer.Locale.Tr
local _trC = Gatherer.Locale.TrClient
local _trL = Gatherer.Locale.TrLocale

local lib = Gatherer.Comm

local sendOfferer
local acceptFrom = {}

local lastHarvest = {}
function Gatherer.Comm.Send( objectId, gatherC, gatherZ, gatherIndex, gatherCoins, gatherLoot )
	if ( type(objectId) == "number" ) then
		gatherZ = Gatherer.ZoneTokens.GetZoneToken(gatherC, gatherZ)
		local gatherX, gatherY = Gatherer.Storage.GetNodeInfo(gatherC, gatherZ, objectId, gatherIndex)
		
		-- if both are nil, then we tried to get a non-existant node, just return
		if (not gatherX and not gatherY) then return end
		
		-- construct loot text string
		local lootText = gatherCoins or 0
		if ( gatherLoot ) then
			for pos, loot in ipairs(gatherLoot) do
				local id = loot.id
				if ( (not id) and loot.link ) then
					id = Gatherer.Util.BreakLink(loot.link)
				end
				if ( id ) then
					local count = loot.count
					if ( count ) then
						lootText = lootText .. ":" .. id .. "x" .. count
					end
				end
			end
		end
		
		-- Check if this node has been just broadcast by us
		if not (lastHarvest and lastHarvest.c == gatherC and lastHarvest.z == gatherZ and lastHarvest.o == objectId and lastHarvest.i == gatherIndex) then
			-- Ok, so lets broadcast this node
			local guildAlert, raidAlert, raidType
			local sendMessage = strjoin(";", objectId, gatherC, gatherZ, gatherX, gatherY, lootText)
			if Gatherer.Config.GetSetting("guild.enable") then
				if ( IsInGuild() ) then
					SendAddonMessage("GathX", sendMessage, "GUILD")
					if (Gatherer.Config.GetSetting("guild.print.send")) then guildAlert = true end
				end
			end
			if (Gatherer.Config.GetSetting("raid.enable")) then
				if GetNumRaidMembers() > 0 then
					raidType = "raid"
				elseif GetNumPartyMembers() > 0 then
					raidType = "party"
				end
				SendAddonMessage("GathX", sendMessage, "RAID")
				if (raidType and Gatherer.Config.GetSetting("raid.print.send")) then raidAlert = true end
			end
			
			if Gatherer.Config.GetSetting("personal.print") then
				local objName = Gatherer.Util.GetNodeName(objectId);
				Gatherer.Util.ChatPrint(_tr("Added gather of %1", objName))
			end
			if (guildAlert or raidAlert) then
				local objName = Gatherer.Util.GetNodeName(objectId);
				local whom
				if guildAlert and raidAlert then
					whom = "guild and "..raidType
				elseif guildAlert then
					whom = "guild"
				else
					whom = raidType
				end
				Gatherer.Util.ChatPrint(_tr("Sent gather of %1 to %2", objName, _tr(whom)))
			end
		end
		lastHarvest.c = gatherC
		lastHarvest.z = gatherZ
		lastHarvest.o = objectId
		lastHarvest.i = gatherIndex
	end
end

local lastMessage = ""
local playerName = UnitName("player")
function Gatherer.Comm.Receive( message, how, who )
	local setting = Gatherer.Config.GetSetting
	local msgtype = "raid"

	-- check if the player is on our sharing blacklist
	local blacklisted = Gatherer.Config.SharingBlacklist_IsPlayerIgnored(who)
	if ( blacklisted ) then
		return
	end

	if ( message ~= lastMessage and who ~= playerName ) then
		if (how:lower() == "guild") then msgtype = "guild" end
		if (how:lower() == "whisper") then
			msgtype = "whisper"
			if not acceptFrom[who:lower()] then return end
		elseif not (setting(msgtype..".enable") and setting(msgtype..".receive")) then return end

		lastMessage = message
		local objectID, gatherC, zoneToken, gatherX, gatherY, loot = strsplit(";", message)
		objectID = tonumber(objectID)
		gatherC = tonumber(gatherC)
		gatherX = tonumber(gatherX)
		gatherY = tonumber(gatherY)
		if ( objectID and gatherC and zoneToken and gatherX and gatherY ) then
			local gatherType = Gatherer.Nodes.Objects[objectID]
			local gatherZ = Gatherer.ZoneTokens.GetZoneIndex(gatherC, zoneToken)
			local localizedZoneName = select(gatherZ, GetMapZones(gatherC))
			
			if ( gatherType and gatherZ ) then
				local coins, loots = Gatherer.Util.LootSplit(loot)
				Gatherer.Api.AddGather(objectID, gatherType, "", who, coins, loots, false, gatherC, gatherZ, gatherX, gatherY)
				local objName = Gatherer.Util.GetNodeName(objectID);
				if msgtype == "whisper" then
					Gatherer.Report.SendFeedback(who, "RECV", objectID)
				elseif setting(msgtype..".print.recv") then
					Gatherer.Util.ChatPrint(_tr("Received gather of %1 in %2 from %3 (%4)", objName, localizedZoneName, who, _tr(how:lower())))
				end
			end
		end
	end
end

StaticPopupDialogs["GATHERER_COMM_REQUESTSEND"] = {
	text = "%s wants to send you %d Gatherer nodes. Accept?",
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
			StaticPopupDialogs["GATHERER_COMM_REQUESTSEND"].accepted = 1
			Gatherer.Comm.SendFeedback("ACCEPT")
	end,
	OnCancel = function()
			StaticPopupDialogs["GATHERER_COMM_REQUESTSEND"].accepted = -2
			Gatherer.Comm.SendFeedback("REJECT")
	end,
	OnShow = function()
		StaticPopupDialogs["GATHERER_COMM_REQUESTSEND"].accepted = nil
	end,
	OnHide = function()
		if StaticPopupDialogs["GATHERER_COMM_REQUESTSEND"].accepted == nil then
			Gatherer.Comm.SendFeedback("TIMEOUT")
			StaticPopupDialogs["GATHERER_COMM_REQUESTSEND"].accepted = -1
		end
	end,
	timeout = 15,
	whileDead = 1,
	exclusive = 1,
	showAlert = 1,
	hideOnEscape = 1
};

function Gatherer.Comm.SendFeedback(reply)
	SendAddonMessage("Gatherer", "SENDNODES:"..reply, "WHISPER", sendOfferer)
	Gatherer.Report.SendFeedback(sendOfferer, a)
	if (reply == "ACCEPT") then
		acceptFrom[sendOfferer:lower()] = true
		Gatherer.Report.SendFeedback(sendOfferer, "ACCEPTED")
	end
	if (reply ~= "PROMPT") then
		sendOfferer = nil
	end
end

function Gatherer.Comm.General( msg, how, who )
	if ( UnitName("player") == who ) then
		return
	end
	local cmd, a,b,c,d = strsplit(":", msg)
	if ( msg == "VER" ) then
		SendAddonMessage("Gatherer", "VER:"..Gatherer.Var.Version, how)
	elseif ( cmd == "SENDNODES" ) then
		-- check if the player is on our sharing blacklist
		local blacklisted = Gatherer.Config.SharingBlacklist_IsPlayerIgnored(who)
		if ( blacklisted ) then
			local tmp = sendOfferer
			sendOfferer = who
			Gatherer.Comm.SendFeedback("REJECT")
			sendOfferer = tmp
			return
		end
		if (Gatherer.Report.IsOpen()) then
			if (a == "OFFER") then
				local count = tonumber(b) or 0
				if (count > 0) then
					if (sendOfferer) then
						SendAddonMessage("Gatherer", "SENDNODES:BUSY", "WHISPER", who)
					else
						sendOfferer = who
						SendAddonMessage("Gatherer", "SENDNODES:PROMPT", "WHISPER", who)
						StaticPopup_Show("GATHERER_COMM_REQUESTSEND", who, count)
					end
				end
			elseif (a == "DONE") then
				if (acceptFrom[who:lower()]) then
					acceptFrom[who:lower()] = nil
					Gatherer.Report.SendFeedback(who, a)
					SendAddonMessage("Gatherer", "SENDNODES:COMPLETE", "WHISPER", who)
				end
			elseif (a == "PAUSE") then
				if (acceptFrom[who:lower()]) then
					SendAddonMessage("Gatherer", "SENDNODES:CONTINUE", "WHISPER", who)
				end
			elseif (a == "CONTINUE") then
				Gatherer.Report.SendFeedback(who, a)
			elseif (a == "ABORTED") then
				Gatherer.Report.SendFeedback(who, a)
			elseif (a == "COMPLETE") then
				Gatherer.Report.SendFeedback(who, a)
			end
		elseif (a == "OFFER") then
			SendAddonMessage("Gatherer", "SENDNODES:CLOSED", "WHISPER", who)
		end
		if (a == "PROMPT" or a == "ACCEPT" or a == "REJECT" or a == "BUSY" or a == "TIMEOUT") then
			Gatherer.Report.SendFeedback(who, a)
		end
	end
end
