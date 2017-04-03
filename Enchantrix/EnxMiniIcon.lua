--[[
	Enchantrix Addon for World of Warcraft(tm).
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: EnxMiniIcon.lua 4432 2009-08-29 14:55:35Z dinesh $
	URL: http://enchantrix.org/

	Minimap Icon

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
Enchantrix_RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Enchantrix/EnxMiniIcon.lua $", "$Rev: 4432 $")

local settings = Enchantrix.Settings

--[[

Icon on the minimap related bits

]]

local miniIcon = CreateFrame("Button", "", Minimap);
Enchantrix.MiniIcon = miniIcon
miniIcon.enxMoving = false

local function mouseDown()
	miniIcon.icon:SetTexCoord(0, 1, 0, 1)
end

local function mouseUp()
	miniIcon.icon:SetTexCoord(0.075, 0.925, 0.075, 0.925)
end

local function dragStart()
	miniIcon.enxMoving = true
end

local function dragStop()
	miniIcon.icon:SetTexCoord(0.075, 0.925, 0.075, 0.925)
	miniIcon.enxMoving = false
end

local function click(obj, button)
	if (button == "LeftButton") then
		if (IsModifierKeyDown()) then
			CastSpellByName(_ENCH("Jewelcrafting"))
		else
			CastSpellByName(_ENCH("Enchanting"))
		end
	elseif (button == "RightButton") then
		settings.MakeGuiConfig()
		local gui = settings.Gui
		if (gui:IsVisible()) then
			gui:Hide()
		else
			gui:Show()
		end
	end
end

function miniIcon.Reposition(angle)
	if (not settings.GetSetting("miniicon.enable")) then
		miniIcon:Hide()
		return
	end
	miniIcon:Show()
	if (not angle) then angle = settings.GetSetting("miniicon.angle") or 0.5
	else settings.SetSetting("miniicon.angle", angle) end
	angle = angle
	local distance = settings.GetSetting("miniicon.distance")

	local width,height = Minimap:GetWidth()/2, Minimap:GetHeight()/2
	width = width+distance
	height = height+distance

	local iconX, iconY
	iconX = width * cos(angle)
	iconY = height * sin(angle)

	miniIcon:ClearAllPoints()
	miniIcon:SetPoint("CENTER", Minimap, "CENTER", iconX, iconY)
end

local function update()
	if miniIcon.enxMoving then
		local curX, curY = GetCursorPosition()
		local miniX, miniY = Minimap:GetCenter()
		miniX = miniX * Minimap:GetEffectiveScale()
		miniY = miniY * Minimap:GetEffectiveScale()

		local relX = miniX - curX
		local relY = miniY - curY
		local angle = math.deg(math.atan2(relY, relX)) + 180

		miniIcon.Reposition(angle)
	end
end

miniIcon:SetToplevel(true)
miniIcon:SetMovable(true)
miniIcon:SetFrameStrata("LOW")
miniIcon:SetWidth(20)
miniIcon:SetHeight(20)
miniIcon:SetPoint("RIGHT", Minimap, "LEFT", 0,0)
miniIcon:Hide()
miniIcon.icon = miniIcon:CreateTexture("", "BACKGROUND")
miniIcon.icon:SetTexture("Interface\\AddOns\\Enchantrix\\Skin\\EnxOrb")
miniIcon.icon:SetTexCoord(0.075, 0.925, 0.075, 0.925)
miniIcon.icon:SetWidth(20)
miniIcon.icon:SetHeight(20)
miniIcon.icon:SetPoint("TOPLEFT", miniIcon, "TOPLEFT", 0,0)
miniIcon.mask = miniIcon:CreateTexture("", "OVERLAY")
miniIcon.mask:SetTexCoord(0.0, 0.6, 0.0, 0.6)
miniIcon.mask:SetTexture("Interface\\Minimap\\Minimap-TrackingBorder")
miniIcon.mask:SetWidth(36)
miniIcon.mask:SetHeight(36)
miniIcon.mask:SetPoint("TOPLEFT", miniIcon, "TOPLEFT", -8,8)

miniIcon:RegisterForClicks("LeftButtonUp","RightButtonUp")
miniIcon:RegisterForDrag("LeftButton")
miniIcon:SetScript("OnMouseDown", mouseDown)
miniIcon:SetScript("OnMouseUp", mouseUp)
miniIcon:SetScript("OnDragStart", dragStart)
miniIcon:SetScript("OnDragStop", dragStop)
miniIcon:SetScript("OnClick", click)
miniIcon:SetScript("OnUpdate", update)



--[[

nSIdeBar related bits

]]

local sideIcon
local SlideBar

if LibStub then
	SlideBar = LibStub:GetLibrary("SlideBar", true)
	if SlideBar then
		sideIcon = SlideBar.AddButton("Enchantrix", "Interface\\AddOns\\Enchantrix\\Skin\\EnxOrb")
		sideIcon:RegisterForClicks("LeftButtonUp","RightButtonUp")
		sideIcon:SetScript("OnClick", click)
-- TODO - localize these strings!
		sideIcon.tip = {
			"Enchantrix",
			"Enchantrix shows you what reagents an item will disenchant or prospect into. It also provides integration into Auctioneer to allow pricing and purchasing decisions to be made.",
			"{{Click}} to open the Enchanting window.",
			"{{Shift-Click}} to open Jewel Crafting.",
			"{{Right-Click}} to edit the configuration.",
		}
	end
end

if sideIcon then
	function sideIcon.Update()
		if (settings.GetSetting("sideIcon.enable")) then
			SlideBar.AddButton("Enchantrix")
		else
			SlideBar.RemoveButton("Enchantrix")
		end
	end
else
	sideIcon = {}
	function sideIcon.Update() end
end

Enchantrix.SideIcon = sideIcon

