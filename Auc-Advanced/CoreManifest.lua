--[[
	Auctioneer
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: CoreManifest.lua 4432 2009-08-29 14:55:35Z dinesh $
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
local _,_,_,tocVersion = GetBuildInfo()
if (tocVersion < 30000) then
	local msg = CreateFrame("Frame", nil, UIParent)
	msg:Hide()
	msg:SetPoint("CENTER", "UIParent", "CENTER")
	msg:SetFrameStrata("DIALOG")
	msg:SetHeight(280)
	msg:SetWidth(500)
	msg:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 9, right = 9, top = 9, bottom = 9 }
	})
	msg:SetBackdropColor(0,0,0, 1)

	msg.Done = CreateFrame("Button", "", msg, "OptionsButtonTemplate")
	msg.Done:SetText("Done")
	msg.Done:SetPoint("BOTTOMRIGHT", msg, "BOTTOMRIGHT", -10, 10)
	msg.Done:SetScript("OnClick", function() msg:Hide() end)

	msg.Text = msg:CreateFontString(nil, "HIGH")
	msg.Text:SetPoint("TOPLEFT", msg, "TOPLEFT", 20, -20)
	msg.Text:SetPoint("BOTTOMRIGHT", msg.Done, "TOPRIGHT", -10, 10)
	msg.Text:SetFont("Fonts\\FRIZQT__.TTF",17)
	msg.Text:SetJustifyH("LEFT")
	msg.Text:SetJustifyV("TOP")
	msg.Text:SetShadowColor(0,0,0)
	msg.Text:SetShadowOffset(3,-3)

	msg.Text:SetText("|c00ff4400Auctioneer Error:|r\n\nNote: This development build of Auctioneer is only for use with game client versions 3.0 or higher!\n\nYour Auctioneer AddOn will now be disabled.\n\nPlease download a release version and re-enable it from the AddOns window on your character selection screen.\n\nURL:    |c005599ffhttp://auctioneeraddon.com/dl|r")

	msg:Show()

	DisableAddOn("Auc-Advanced")
	return
end

AucAdvanced = {}
local lib = AucAdvanced

lib.Version="5.8.4723";
if (lib.Version == "<".."%version%>") then
	lib.Version = "5.1.DEV";
end
local major, minor, release, revision = strsplit(".", lib.Version)
lib.MajorVersion = major
lib.MinorVersion = minor
lib.RelVersion = release
lib.Revision = revision

local versionPrefix = lib.MajorVersion.."."..lib.MinorVersion.."."..lib.RelVersion.."."

lib.moduledetail = {}
lib.revisions = {}
lib.distribution = {--[[<%revisions%>]]} --Currently unused, needs a change in the build script

local libRevision = LibStub("LibRevision")

function lib.RegisterRevision(path, revision)
	if (not path and revision) then return end

	local detail, file, rev = libRevision:Set(path, revision, versionPrefix, "auctioneer", "libs")
	if file then
		lib.revisions[file] = rev
	end
	return detail, file, rev
end

function lib.GetCurrentRevision()
	local revNumber = 0
	local revFile
	for file, revision in pairs(lib.revisions) do
		if (revision > revNumber) then
			revNumber = revision
			revFile = file
		end
	end

	return revNumber, revFile
end

function lib.GetRevisionList()
	return lib.revisions
end

function lib.GetDistributionList()
	return lib.distribution
end

function lib.ValidateInstall()
	return true --NoOp for the moment
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Advanced/CoreManifest.lua $", "$Rev: 4432 $")
