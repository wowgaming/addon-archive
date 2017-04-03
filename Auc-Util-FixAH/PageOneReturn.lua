--[[
	Auctioneer - Fix for searches not returning to page one in Blizzard code.
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: Example.lua 3882 2008-12-02 16:36:58Z kandoko $
	URL: http://auctioneeraddon.com/

	This is an Auctioneer module that temporarily patches known errors and issues
	with Blizzard's code.

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

local libName = "FixAH"
local libType = "Util"

local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end
local print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill = AucAdvanced.GetModuleLocals()

--[[
The following functions are part of the module's exposed methods:
	GetName()         (required) Should return this module's full name
	CommandHandler()  (optional) Slash command handler for this module
	Processor()       (optional) Processes messages sent by Auctioneer
	ScanProcessor()   (optional) Processes items from the scan manager
*	GetPrice()        (required) Returns estimated price for item link
*	GetPriceColumns() (optional) Returns the column names for GetPrice
	OnLoad()          (optional) Receives load message for all modules

	(*) Only implemented in stats modules; util modules do not provide


-- Auto disable if build version is not correct:
local requiredBuildLive = 10314
local requiredBuildPTR = 10147
local version, build = GetBuildInfo()
if (tonumber(build) ~= requiredBuildLive) and (tonumber(build) ~= requiredBuildPTR) then
	print("AucAdvanced: {{"..libType..":"..libName.."}} not loading: Build ("..build..") detected.  Requires Live build ("..requiredBuildLive.." or PTR build "..requiredBuildPTR.." )")
	DisableAddOn("Auc-Util-FixAH")
	return
end]]

function lib.GetName()
	return libName
end

function lib.Processor(callbackType, ...)
	if (callbackType == "config") then
		private.SetupConfigGui(...)
	elseif (callbackType == "auctionui") then
		private.HookAH(...)
	end
end

function lib.OnLoad()
	--This function is called when your variables have been loaded.
	--You should also set your Configator defaults here
	print("AucAdvanced: {{"..libType..":"..libName.."}} loaded!")
	AucAdvanced.Settings.SetDefault("util.fixah.pageonereturn", true)
end

--[[ Local functions ]]--

function private.SetupConfigGui(gui)
	-- The defaults for the following settings are set in the lib.OnLoad function
	local id = gui:AddTab(libName)
	gui:MakeScrollable(id)
	gui:AddControl(id, "Header",     0,    libName.." options")
	gui:AddControl(id, "Checkbox",   0, 1, "util.fixah.pageonereturn", "Fix Blizzard search bug where new search stays on current page (requires reload)")
end

function private.HookAH(...)
	if (AucAdvanced.Settings.GetSetting("util.fixah.pageonereturn")) then
		private.RealSearchButtonClick = BrowseSearchButton:GetScript("OnClick")
		BrowseSearchButton:SetScript("OnClick", private.SearchButtonClick);
	end
end

function private.SearchButtonClick(...)
	AuctionFrameBrowse.page = 0
	private.RealSearchButtonClick(...)
end

AucAdvanced.RegisterRevision("$URL: http://dev.norganna.org/auctioneer/trunk/Auc-Advanced/Modules/Auc-Util-Example/Example.lua $", "$Rev: 3882 $")
