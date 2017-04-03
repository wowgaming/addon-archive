--[[
	Auctioneer - Scan Start module
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: ScanFinish.lua 3576 2008-10-10 03:07:13Z aesir $
	URL: http://auctioneeraddon.com/

	This is an Auctioneer module that adds a few event functionalities
	to Auctioneer 5 when a scan is started.

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
		You have an implicit license to use this AddOn with these facilities
		since that is its designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
--]]
if not AucAdvanced then return end

local libType, libName = "Util", "ScanStart"
local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end
private.scanTypeList = {partial="Partial",full="Full"}

local print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill = AucAdvanced.GetModuleLocals()

local blnDebug = false
local blnLibEmbedded = nil

function lib.Processor(callbackType, ...)
	if blnDebug then
		local msg = ("CallbackType=%s, IsBlocked=%s, IsScanning=%s"):format(callbackType, tostring(AucAdvanced.API.IsBlocked()),
			tostring(AucAdvanced.Scan.IsScanning()))
		debugPrint(msg, "ScanStart Processor", callbackType, 0, "Debug")
	end
	if (callbackType == "scanstart") then
		if not AucAdvanced.Settings.GetSetting("util.scanstart.activated") then
			return
		end
		private.ScanStart(...)
	elseif (callbackType == "config") then
		private.SetupConfigGui(...)
	elseif (callbackType == "configchanged") then
		private.ConfigChanged(...)
	end
end

function lib.OnLoad()
	print("AucAdvanced: {{"..libType..":"..libName.."}} loaded!")
	AucAdvanced.Settings.SetDefault("util.scanstart.activated", true)
	AucAdvanced.Settings.SetDefault("util.scanstart.debug", false)

	for scantype, scantypename in pairs(private.scanTypeList) do
		AucAdvanced.Settings.SetDefault("util.scanstart."..scantype..".activated", scantype=="full")
		AucAdvanced.Settings.SetDefault("util.scanstart."..scantype..".message.channel", "none")
		AucAdvanced.Settings.SetDefault("util.scanstart."..scantype..".message.text", "What do we have today")
		AucAdvanced.Settings.SetDefault("util.scanstart."..scantype..".emote", "none")
		AucAdvanced.Settings.SetDefault("util.scanstart."..scantype..".dnd.activated", false)
		AucAdvanced.Settings.SetDefault("util.scanstart."..scantype..".dnd.text", "Scanning Auction House")
		AucAdvanced.Settings.SetDefault("util.scanstart."..scantype..".afk.activated", false)
		AucAdvanced.Settings.SetDefault("util.scanstart."..scantype..".afk.text", "Scanning Auction House.  What, you want me to stand around twiddling thumbs?")
	end

	if AucAdvanced.Settings.GetSetting("util.scanstart.debug") then blnDebug = true end
end

function private.ScanStart(scanSize, querysig, query)
	if blnDebug then
		local msg = ("scanSize=%s, querysig=%s"):format(scanSize, querysig)
		debugPrint(msg, "ScanStart Handler", "Scan Started", 0, "Debug")
	end

	if (scanSize == "Full" or scanSize == "Partial") then
		--Message
		local scanId = scanSize:lower()
		debugPrint(AucAdvanced.Settings.GetSetting("util.scanstart."..scanId..".message.channel"), "ScanStart Handler", "Chat", 0, "Debug")
		if AucAdvanced.Settings.GetSetting("util.scanstart."..scanId..".message.channel") == "none" then
			--don't do anything
		elseif AucAdvanced.Settings.GetSetting("util.scanstart."..scanId..".message.channel") == "GENERAL" then
			SendChatMessage(AucAdvanced.Settings.GetSetting("util.scanstart."..scanId..".message.text"),"CHANNEL",nil,GetChannelName("General"))
		else
			SendChatMessage(AucAdvanced.Settings.GetSetting("util.scanstart."..scanId..".message.text"),AucAdvanced.Settings.GetSetting("util.scanstart."..scanId..".message.channel"))
		end

		--Emote
		if not (AucAdvanced.Settings.GetSetting("util.scanstart."..scanId..".emote") == "none") then
			debugPrint(AucAdvanced.Settings.GetSetting("util.scanstart."..scanId..".emote"), "ScanStart Handler", "Performing EMOTE", 0, "Debug")
			DoEmote(AucAdvanced.Settings.GetSetting("util.scanstart."..scanId..".emote"))
		end

		--Set AFK and/or DND
		if (AucAdvanced.Settings.GetSetting("util.scanstart."..scanId..".dnd.activated")) then
			debugPrint(AucAdvanced.Settings.GetSetting("util.scanstart."..scanId..".dnd.text"), "ScanStart Handler", "Setting DND", 0, "Debug")
			if not UnitIsDND("player") then SendChatMessage(AucAdvanced.Settings.GetSetting("util.scanstart."..scanId..".dnd.text"), "DND") end
		end
		if (AucAdvanced.Settings.GetSetting("util.scanstart."..scanId..".afk.activated")) then
			debugPrint(AucAdvanced.Settings.GetSetting("util.scanstart."..scanId..".afk.text"), "ScanStart Handler", "Setting AFK", 0, "Debug")
			if not UnitIsAFK("player") then SendChatMessage(AucAdvanced.Settings.GetSetting("util.scanstart."..scanId..".afk.text"), "AFK") end
		end
	else
			debugPrint(msg, "ScanStart Handler", "Unhandled Scan Size", 0, "Debug")
	end
end


--Config UI functions
function private.SetupConfigGui(gui)
	-- The defaults for the following settings are set in the lib.OnLoad function
	local emoteList = {
		{"none"	  , "None (do not emote)"},
		{"APOLOGIZE" , "Apologize"},
		{"APPLAUD"   , "Applaud"},
		{"BRB"	   , "BRB"},
		{"CACKLE"	, "Cackle"},
		{"CHICKEN"   , "Chicken"},
		{"DANCE"	 , "Dance"},
		{"FAREWELL"  , "Farewell"},
		{"FLIRT"	 , "Flirt"},
		{"GLOAT"	 , "Gloat"},
		{"JOKE"	  , "Silly"},
		{"SLEEP"	 , "Sleep"},
		{"VICTORY"   , "Victory"},
		{"YAWN"	  , "Yawn"}
	}
	local talkTypes = {
		{"none", "None (do not send message)"},
		{"SAY", "Say (/s)"},
		{"PARTY","Party (/p)"},
		{"RAID","Raid (/r)"},
		{"GUILD","Guild (/g)"},
		{"YELL","Yell (/y)"},
		{"EMOTE","Emote (/em)"},
		{"GENERAL","General"}
	}
	
	local id = gui:AddTab(libName, libType.." Modules")
	gui:MakeScrollable(id)

	gui:AddHelp(id, "what is scanstart",
		"What is ScanStart?",
		"ScanStart is an AuctioneerAdvanced module that will execute one or more useful events when Auctioneer starts an AH scan.\n")

	gui:AddControl(id, "Header",	 0,	libName.." options")
	gui:AddControl(id, "Checkbox",   0, 1, "util.scanstart.activated", "Allow the execution of events when a scan starts")
	gui:AddTip(id, "Selecting this option will enable Auctioneer to perform the selected events once Auctioneer has started a scan. \n\nUncheck this to disable all events.")
	
	for scantype, scantypename in pairs(private.scanTypeList) do
		gui:AddControl(id, "Subhead",	0,	scantypename.." AH Scan")
		gui:AddControl(id, "Checkbox",   0, 1, "util.scanstart."..scantype..".activated", 
			"Allow the execution of the events below when a "..scantypename.." scan starts")
		gui:AddTip(id, "Selecting this option will enable Auctioneer to perform the selected events once Auctioneer has started a "..scantypename.." AH scan. \n\nUncheck this to disable events for a "..scantypename.." scan.")
		gui:AddControl(id, "Selectbox",  0, 3, emoteList, "util.scanstart."..scantype..".emote", "Pick the Emote to perform")
		gui:AddTip(id, "Selecting one of these emotes will cause your character to perform the selected emote once Auctioneer has started a scan successfully.\n\nBy selecting None, no emote will be performed.")

		gui:AddControl(id, "Text",	   0, 1, "util.scanstart."..scantype..".message.text", "Message text:")
		gui:AddTip(id, "Enter the message text of what you wish your character to say as well as choosing a channel below. \n\nThis will not execute slash commands.")
		gui:AddControl(id, "Selectbox",  0, 3, talkTypes, "util.scanstart."..scantype..".message.channel", "Pick the channel to send your message to")
		gui:AddTip(id, "Selecting one of these channels will cause your character to say the message text into the selected channel once Auctioneer has completed a scan successfully. \n\nBy choosing Emote, your character will use the text above as a custom emote. \n\nBy selecting None, no message will be sent.")


		gui:AddControl(id, "Checkbox",   0, 1, "util.scanstart."..scantype..".dnd.activated", 
			"Set character status to DND when scan starts")
		gui:AddControl(id, "Text",	   0, 1, "util.scanstart."..scantype..".dnd.text", "DND Message:")
		gui:AddTip(id, "Enter the text to return when a user whispers while DND is enabled.\n\nThis will not execute slash commands.")
		gui:AddControl(id, "Checkbox",   0, 1, "util.scanstart."..scantype..".afk.activated", 
			"Set character status to AFK when scan starts")
		gui:AddControl(id, "Text",	   0, 1, "util.scanstart."..scantype..".afk.text", "AFK Message:")
		gui:AddTip(id, "Enter the text to return when a user whispers while AFK is enabled.\n\nThis will not execute slash commands.")
	end
		
	--Debug switch via gui. Currently not exposed to the end user
	gui:AddControl(id, "Subhead",	0,	"Debug ScanStart")
	gui:AddControl(id, "Checkbox",   0, 1, "util.scanstart.debug", "Show Debug Information for this session")


end

function lib.IsLibEmbedded()
	blnResult = false
	for pos, module in ipairs(AucAdvanced.EmbeddedModules) do
		if "Auc-Util-"..libName == module then
			if blnDebug then
				print("  Debug:Auc-Util-"..libName.." is an embedded module")
			end
			blnResult = true
			break
		end
	end
	return blnResult
end

function private.ConfigChanged()
	--Debug switch via gui. Currently not exposed to the end user
	--blnDebug = AucAdvanced.Settings.GetSetting("util.scanfinish.debug")
	if blnDebug then
		print("  Debug:Configuration Changed")
	end
	if AucAdvanced.Settings.GetSetting("util.scanstart.debug") then blnDebug = true end
end

AucAdvanced.RegisterRevision("$URL: http://dev.norganna.org/auctioneer/trunk/Auc-Util-ScanFinish/ScanFinish.lua $", "$Rev: 3576 $")
