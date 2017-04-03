--[[
	Informant - An addon for World of Warcraft that shows pertinent information about
	an item in a tooltip when you hover over the item in the game.
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: InfManifest.lua 3581 2008-10-11 12:36:19Z Norganna $
	URL: http://auctioneeraddon.com/dl/Informant/

	Informant Manifest
	Keep track of the revision numbers for various informant files

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

if (Informant_Manifest) then return end

Informant_Manifest = { }
local manifest = Informant_Manifest

manifest.revs = { }
manifest.dist = {
--[[<%revisions%>]]}

local libRevision = LibStub("LibRevision")
function manifest.RegisterRevision(path, revision)
	local detail, file, rev = libRevision:Set(path,revision,"5.1.DEV.", 'auctioneer', 'libs')
	if not file then return end
	if not rev then rev = 0 else rev = tonumber(rev) or 0 end

	manifest.revs[file] = rev
	if (nLog) then
		nLog.AddMessage("Informant", "AucRevision", N_INFO, "Loaded "..file, "Loaded", file, "revision", rev)
	end
end
Informant_RegisterRevision = manifest.RegisterRevision


function manifest.ShowMessage(msg)
	local messageFrame = manifest.messageFrame
	if not messageFrame then
		messageFrame = CreateFrame("Frame", "", UIParent)
		manifest.messageFrame = messageFrame

		messageFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 150)
		messageFrame:SetWidth(400);
		messageFrame:SetHeight(200);
		messageFrame:SetFrameStrata("DIALOG")
		messageFrame:SetBackdrop({
			bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
			tile = true, tileSize = 32, edgeSize = 16,
			insets = { left = 4, right = 4, top = 4, bottom = 4 }
		})
		messageFrame:SetBackdropColor(0.5,0,0, 0.8)

		messageFrame.done = CreateFrame("Button", "", messageFrame, "OptionsButtonTemplate")
		messageFrame.done:SetText(OKAY)
		messageFrame.done:SetPoint("BOTTOMRIGHT", messageFrame, "BOTTOMRIGHT", -10, 10)
		messageFrame.done:SetScript("OnClick", function() messageFrame:Hide() end)

		messageFrame.text = messageFrame:CreateFontString("", "HIGH")
		messageFrame.text:SetPoint("TOPLEFT", messageFrame, "TOPLEFT", 10, -10)
		messageFrame.text:SetPoint("BOTTOMRIGHT", messageFrame.done, "TOPRIGHT")
		messageFrame.text:SetFont("Fonts\\FRIZQT__.TTF",13)
		messageFrame.text:SetJustifyH("LEFT")
		messageFrame.text:SetJustifyV("TOP")
	end
	messageFrame.text:SetText(msg)
	messageFrame:Show()
end

function manifest.Validate()
	local matches = true
	for file, revision in pairs(manifest.dist) do
		local current = manifest.revs[file]
		if (not current or current ~= revision) then
			matches = false
			if (nLog) then
				nLog.AddMessage("Informant", "Validate", N_WARNING, "File revision mismatch", "File", file, "should be revision", revision, "but is actually", current)
			end
		end
	end
	if (not matches) then
		manifest.ShowMessage("|cffff1111Warning:|r Your Informant installation appears to have mismatching file versions.\n\nPlease make sure you delete the old:\n  |cffffaa11Interface\\AddOns\\Informant|r\ndirectory, reinstall a fresh copy from:\n  |cff44ff11http://auctioneeraddon.com/dl/Informant|r\nand restart WoW completely before reporting any bugs.\n\nThanks,\n  The Informant Dev Team.")
	end
	return true
end

Informant_RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Informant/InfManifest.lua $", "$Rev: 3581 $")
