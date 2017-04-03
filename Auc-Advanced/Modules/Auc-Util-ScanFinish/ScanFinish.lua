--[[
	Auctioneer - Scan Finish module
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: ScanFinish.lua 4640 2010-01-26 02:18:04Z Nechckn $
	URL: http://auctioneeraddon.com/

	This is an Auctioneer module that adds a few event functionalities
	to Auctioneer when a successful scan is completed.

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

local libType, libName = "Util", "ScanFinish"
local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end
local print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill = AucAdvanced.GetModuleLocals()

local blnDebug = false
local blnLibEmbedded = nil

local intScanMinThreshold = 300  --Safeguard to prevent Auditor Refresh button scans from executing our finish events. Use 300 or more to be safe
local strPrevSound = "AuctioneerClassic"

function lib.Processor(callbackType, ...)
	if blnDebug then
		local msg = ("CallbackType=%s, Sound=%s, IsBlocked=%s, IsScanning=%s"):format(callbackType, 
			tostring(AucAdvanced.Settings.GetSetting("util.scanfinish.soundpath")), 
			tostring(AucAdvanced.API.IsBlocked()), tostring(AucAdvanced.Scan.IsScanning()))
		debugPrint(msg, "ScanFinish Processor", callbackType, 0, "Debug")
	end
	
	if (callbackType == "scanfinish") then
		if not AucAdvanced.Settings.GetSetting("util.scanfinish.activated") then
			return
		end
		private.ScanFinish(...)
	elseif (callbackType == "scanstart") then
		if not AucAdvanced.Settings.GetSetting("util.scanfinish.activated") then
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
	print("Auctioneer: {{"..libType..":"..libName.."}} loaded!")
	AucAdvanced.Settings.SetDefault("util.scanfinish.activated", true)
	AucAdvanced.Settings.SetDefault("util.scanfinish.shutdown", false)
	AucAdvanced.Settings.SetDefault("util.scanfinish.logout", false)
	AucAdvanced.Settings.SetDefault("util.scanfinish.message", "So many auctions... so little time")
	AucAdvanced.Settings.SetDefault("util.scanfinish.messagechannel", "none")
	AucAdvanced.Settings.SetDefault("util.scanfinish.emote", "none")
	AucAdvanced.Settings.SetDefault("util.scanfinish.debug", false)
	if AucAdvanced.Settings.GetSetting("util.scanfinish.debug") then blnDebug = true end
end

function private.ScanStart(scanSize, querysig, query)
	debugPrint(scanSize, "ScanFinish", "ScanStart", 0, "Debug")

	if (scanSize ~= "Full") then return end
	AlertShutdownOrLogOff()
end


function private.ScanFinish(scanSize, querysig, query, wasComplete)
	debugPrint(scanSize..","..tostring(wasComplete), "ScanFinish", "ScanFinish", 0, "Debug")

	if (scanSize ~= "Full") then return end
	if (not wasComplete) then return end
	private.PerformFinishEvents()
end

function private.PerformFinishEvents()
	--Clean up/reset local variables
	local msg = ("Message: '%s', MessageChannel: '%s', Emote: '%s', Logout: %s, ShutDown %s"):format(
		AucAdvanced.Settings.GetSetting("util.scanfinish.message"),
		AucAdvanced.Settings.GetSetting("util.scanfinish.messagechannel"),
		AucAdvanced.Settings.GetSetting("util.scanfinish.emote"),
		tostring(AucAdvanced.Settings.GetSetting("util.scanfinish.logout")),
		tostring(AucAdvanced.Settings.GetSetting("util.scanfinish.shutdown")))
	debugPrint(msg, "ScanFinish", "PerformFinishEvents", 0, "Debug")

	--Sound
	PlayCompleteSound()

	--Message
	if AucAdvanced.Settings.GetSetting("util.scanfinish.messagechannel") == "none" then
		--don't do anything
	elseif AucAdvanced.Settings.GetSetting("util.scanfinish.messagechannel") == "GENERAL" then
		SendChatMessage(AucAdvanced.Settings.GetSetting("util.scanfinish.message"),"CHANNEL",nil,GetChannelName("General"))
	else
		SendChatMessage(AucAdvanced.Settings.GetSetting("util.scanfinish.message"),AucAdvanced.Settings.GetSetting("util.scanfinish.messagechannel"))
	end

	--Emote
	if not (AucAdvanced.Settings.GetSetting("util.scanfinish.emote") == "none") then
		DoEmote(AucAdvanced.Settings.GetSetting("util.scanfinish.emote"))
	end

	--Shutdown or Logoff
	if (AucAdvanced.Settings.GetSetting("util.scanfinish.shutdown")) then
		print("AucAdvanced: {{"..libName.."}} Shutting Down!!")
		if not blnDebug then
			Quit()
		end
	elseif (AucAdvanced.Settings.GetSetting("util.scanfinish.logout")) then
		print("AucAdvanced: {{"..libName.."}} Logging Out!")
		if not blnDebug then
			Logout()
		end
	end
end

function AlertShutdownOrLogOff()
	if (AucAdvanced.Settings.GetSetting("util.scanfinish.shutdown")) then
		PlaySound("TellMessage")
		print("AucAdvanced: {{"..libName.."}} |cffff3300Reminder|r: Shutdown is enabled. World of Warcraft will be shut down once the current scan successfully completes.")
	elseif (AucAdvanced.Settings.GetSetting("util.scanfinish.logout")) then
		PlaySound("TellMessage")
		print("AucAdvanced: {{"..libName.."}} |cffff3300Reminder|r: LogOut is enabled. This character will be logged off once the current scan successfully completes.")
	end
end

function PlayCompleteSound()
	strConfiguredSoundPath = AucAdvanced.Settings.GetSetting("util.scanfinish.soundpath")
	if strConfiguredSoundPath and not (strConfiguredSoundPath == "none") then
		if blnDebug then
			print("AucAdvanced: {{"..libName.."}} You are listening to "..strConfiguredSoundPath)
		end
		if strConfiguredSoundPath == "AuctioneerClassic" then
			if blnLibEmbedded == nil then
			  	blnLibEmbedded = IsLibEmbedded()
			end
			strConfiguredSoundPath = "Interface\\AddOns\\Auc-Util-ScanFinish\\ScanComplete.mp3"
			if blnLibEmbedded then
				strConfiguredSoundPath = "Interface\\AddOns\\Auc-Advanced\\Modules\\Auc-Util-ScanFinish\\ScanComplete.mp3"
			end

			--Known PlaySoundFile bug seems to require some event preceeding it to get it to work reliably
			--Can get this working as a print to screen or an internal sound. Other developers
			--suggested this workaround.
			--http://forums.worldofwarcraft.com/thread.html?topicId=1777875494&sid=1&pageNo=4
			PlaySound("GAMEHIGHLIGHTFRIENDLYUNIT")
			PlaySoundFile(strConfiguredSoundPath)

		else
			PlaySound(strConfiguredSoundPath)
		end
	end
end

--Config UI functions
function private.SetupConfigGui(gui)
	-- The defaults for the following settings are set in the lib.OnLoad function
	local id = gui:AddTab(libName, libType.." Modules")

	gui:AddHelp(id, "what is scanfinish",
		"What is ScanFinish?",
		"ScanFinish is an Auctioneer module that will execute one or more useful events once Auctioneer has completed a scan successfully.\n\nScanFinish will only execute these events during full Auctioneer scans with a minimum threshold of "..intScanMinThreshold .." items, so there is no worry about logging off or spamming emotes during the incremental scans or SearchUI activities. Unfortunately, this also means the functionality will not be enabled in auction houses with under "..intScanMinThreshold.." items."
		)

	gui:AddControl(id, "Header",	 0,	libName.." options")
	gui:AddControl(id, "Checkbox",   0, 1, "util.scanfinish.activated", "Allow the execution of the events below once a successful full scan completes")
	gui:AddTip(id, "Selecting this option will enable Auctioneer to perform the events below once Auctioneer has completed a scan successfully. \n\nUncheck this to disable all events.")

	gui:AddControl(id, "Subhead",	0,	"Sound & Emote")
	gui:AddControl(id, "Selectbox",  0, 3, {
		{"none", "None (do not play a sound)"},
		{"AuctioneerClassic", "Auctioneer Classic"},
		{"QUESTCOMPLETED","Quest Completed"},
		{"LEVELUP","Level Up"},
		{"AuctionWindowOpen","Auction House Open"},
		{"AuctionWindowClose","Auction House Close"},
		{"ReadyCheck","Raid Ready Check"},
		{"RaidWarning","Raid Warning"},
		{"LOOTWINDOWCOINSOUND","Coin"},
	}, "util.scanfinish.soundpath", "Pick the sound to play")
	gui:AddTip(id, "Selecting one of these sounds will cause Auctioneer to play that sound once Auctioneer has completed a scan successfully. \n\nBy selecting None, no sound will be played.")

	gui:AddControl(id, "Selectbox",  0, 3, {
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
		{"YAWN"	  , "Yawn"},

	}, "util.scanfinish.emote", "Pick the Emote to perform")
	gui:AddTip(id, "Selecting one of these emotes will cause your character to perform the selected emote once Auctioneer has completed a scan successfully.\n\nBy selecting None, no emote will be performed.")

	gui:AddControl(id, "Subhead",	0,	"Message")
	gui:AddControl(id, "Text",	   0, 1, "util.scanfinish.message", "Message text:")
	gui:AddTip(id, "Enter the message text of what you wish your character to say as well as choosing a channel below. \n\nThis will not execute slash commands.")
	gui:AddControl(id, "Selectbox",  0, 3, {
		{"none", "None (do not send message)"},
		{"SAY", "Say (/s)"},
		{"PARTY","Party (/p)"},
		{"RAID","Raid (/r)"},
		{"GUILD","Guild (/g)"},
		{"YELL","Yell (/y)"},
		{"EMOTE","Emote (/em)"},
		{"GENERAL","General"},
	}, "util.scanfinish.messagechannel", "Pick the channel to send your message to")
	gui:AddTip(id, "Selecting one of these channels will cause your character to say the message text into the selected channel once Auctioneer has completed a scan successfully. \n\nBy choosing Emote, your character will use the text above as a custom emote. \n\nBy selecting None, no message will be sent.")


	gui:AddControl(id, "Subhead",	0,	"Shutdown or Log Out")
	gui:AddControl(id, "Checkbox",   0, 1, "util.scanfinish.shutdown", "Shutdown World of Warcraft")
	gui:AddTip(id, "Selecting this option will cause Auctioneer to shut down World of Warcraft completely once Auctioneer has completed a scan successfully.")
	gui:AddControl(id, "Checkbox",   0, 1, "util.scanfinish.logout", "Log Out the current character")
	gui:AddTip(id, "Selecting this option will cause Auctioneer to log out to the character select screen once Auctioneer has completed a scan successfully. \n\nIf Shutdown is enabled, selecting this will have no effect")


	--Debug switch via gui. Currently not exposed to the end user
	gui:AddControl(id, "Subhead",	0,	"")
	gui:AddControl(id, "Checkbox",   0, 1, "util.scanfinish.debug", "Show Debug Information for this session")


end

function IsLibEmbedded()
	blnResult = false
	for pos, module in ipairs(AucAdvanced.EmbeddedModules) do
		--print("  Debug:Comparing Auc-Util-"..libName.." with "..module)
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
	if AucAdvanced.Settings.GetSetting("util.scanfinish.debug") then blnDebug = true end

	if not (strPrevSound == AucAdvanced.Settings.GetSetting("util.scanfinish.soundpath")) then
		PlayCompleteSound()
		strPrevSound = AucAdvanced.Settings.GetSetting("util.scanfinish.soundpath")
	end

	if (not AucAdvanced.Settings.GetSetting("util.scanfinish.activated")) then
		if blnDebug then print("  Debug:Updating ScanFinish:Deactivated") end
	elseif (AucAdvanced.Scan.IsScanning()) then
		if blnDebug then print("  Debug:Updating ScanFinish with Scan in progress") end
	end
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-ScanFinish/ScanFinish.lua $", "$Rev: 4640 $")
