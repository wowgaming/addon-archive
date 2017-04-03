--[[
	Auctioneer
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: CoreConfig.lua 4432 2009-08-29 14:55:35Z dinesh $
	URL: http://auctioneeraddon.com/

	This is an addon for World of Warcraft that adds statistical history to the auction data that is collected
	when the auction is scanned, so that you can easily determine what price
	you will be able to sell an item for at auction or at a vendor whenever you
	mouse-over an item in the game

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
]]
if not AucAdvanced then return end

AucAdvanced.Config = {}
local lib = AucAdvanced.Config
local private = {}
private.Print = AucAdvanced.Print

function private.CommandHandler(editbox, command, subcommand, ...)
	command = command:lower()
	if (command == "help") then
		local pos, cmdList, cmdL, cmd, cmdFunc = 0,"", "", "", nil
		repeat
			if (pos == 1) then
				cmdList = cmd
			elseif (pos == 2) then
				cmdL = cmd
			elseif (pos > 2) then
				cmdList = cmdList..", "..cmdL
				cmdL = cmd
			end
			pos = pos + 1
			cmdFunc = loadstring("return SLASH_AUCADVANCED"..pos)
			cmd = cmdFunc()
		until (cmd == nil or cmd == "")
		if (pos > 3 and cmdL~="") then
			cmdList = cmdList..", or "..cmdL
		elseif (cmdL~="") then
			cmdList = cmdList.." or ".. cmdL
		end		
		local cmd = strsplit(" ", editbox:GetText())		
		private.Print("Auctioneer Help ("..cmdList..")")
		private.Print("  {{"..cmd.." help}} - Show this help")
		private.Print("  {{"..cmd.." begin [catid [subcatid]]}} - Scan the auction house (optional catid and subcatid)")
		private.Print("  {{"..cmd.." config}} - Opens the configuration page.")
		private.Print("  {{"..cmd.." getall}} - Download auctionhouse using getall")
		private.Print("  {{"..cmd.." pause}} - Pause scanning of the auctionhouse")
		private.Print("  {{"..cmd.." resume||unpause||cont||continue}} - Recommence scanning of the auctionhouse")
		private.Print("  {{"..cmd.." end}} - Stop scanning the auctionhouse, commit current data")
		private.Print("  {{"..cmd.." abort}} - Stop scanning the auctionhouse, discard current data")
		private.Print("  {{"..cmd.." clear <itemlink>}} - Clears data for <itemlink> from the stat modules")
		private.Print("  {{"..cmd.." about [all]}} - Shows the currenly running version of Auctioneer, if all is specified, also shows the version for every file in the package")

		for system in pairs(AucAdvanced.Modules) do
			local modules = AucAdvanced.GetAllModules("CommandHandler", system)
			for pos, engineLib in ipairs(modules) do
				local engine = engineLib:GetName()
				private.Print("  {{"..cmd.." "..system:lower().." "..engine:lower().." help}} - Show "..engineLib.GetName().." "..system.." help")
			end
		end
	elseif command == "begin" or command == "scan" then
		lib.ScanCommand(subcommand, ...)
	elseif command == "end" or command == "stop" then
		AucAdvanced.Scan.SetPaused(false)
		AucAdvanced.Scan.Cancel()
	elseif command == "pause" then
		AucAdvanced.Scan.SetPaused(true)
	elseif command == "resume" or command == "unpause" or command == "cont" or command == "continue" then
		AucAdvanced.Scan.SetPaused(false)
	elseif command == "abort" then
		AucAdvanced.Scan.Abort()
	elseif command == "config" then
		AucAdvanced.Settings.Show()
	elseif command == "clear" then
		if ... then
			subcommand = string.join(" ", subcommand, ...)
		end
		AucAdvanced.API.ClearItem(subcommand)
	elseif command == "about" then
		lib.About(subcommand, ...)
	elseif command == "getallspeed" then
		AucAdvanced.Settings.SetSetting("GetAllSpeed", subcommand)
		AucAdvanced.Print("Setting GetAllSpeed to "..tostring(AucAdvanced.Settings.GetSetting("GetAllSpeed")))
	elseif command == "getall" then
		AucAdvanced.Scan.StartScan(nil, nil, nil, nil, nil, nil, nil, nil, true)
	else
		if command and subcommand then
			local engineLib = AucAdvanced.GetAllModules("CommandHandler", command, subcommand)
			if engineLib then
				engineLib.CommandHandler(...)
				return
			end
		end

		-- No match found
		private.Print("Unable to find command: "..command)
		private.Print("Type {{/auc help}} for help")
	end
end

function lib.ScanCommand(cat, subcat)
	cat = tonumber(cat)
	subcat = tonumber(subcat)
	local catName = nil
	local subcatName = nil
	--If there was a requested category to scan, we'll first check if its a valid category
	if cat then
		catName = AucAdvanced.Const.CLASSES[cat]
		if catName then
			if subcat then
				subcatName = AucAdvanced.Const.SUBCLASSES[cat][subcat]
				if not subcatName then
					subcat = nil
				end
			end
		else
			cat = nil
			subcat = nil
		end
	else
		subcat = nil
	end
	--If the requested category was invalid, we'll scan the whole AH
	if not cat then
		private.Print("Beginning scanning: {{All categories}}")
	elseif not subcat then
			private.Print("Beginning scanning: {{Category "..cat.." ("..catName..")}}")
	else
			private.Print("Beginning scanning: {{Category "..cat.."."..subcat.." ("..subcatName.." of "..catName..")}}")
	end
	AucAdvanced.Scan.StartScan(nil, nil, nil, nil, cat, subcat, nil, nil)
end

function lib.GetCommandLead(llibType, llibName)
	return "  {{"..SLASH_AUCADVANCED1.." "..llibType:lower().." "..llibName:lower()
end

function lib.About(all)
	local rev = AucAdvanced.GetCurrentRevision()
	private.Print(("Auctioneer rev.%d loaded"):format(rev))

	if (all) then
		local revisionsList = AucAdvanced.GetRevisionList()

		for file, revision in pairs(revisionsList) do
			local shortName = file:match(".-/(%u.*)")
			private.Print(("    File \"%s\", revision: %d"):format(shortName, revision))
		end
	end
end

SLASH_AUCADVANCED1 = "/auc"
SLASH_AUCADVANCED2 = "/aadv"
SLASH_AUCADVANCED3 = "/auctioneer"
SlashCmdList["AUCADVANCED"] = function(msg, editbox) private.CommandHandler(editbox, strsplit(" ", msg)) end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Advanced/CoreConfig.lua $", "$Rev: 4432 $")
