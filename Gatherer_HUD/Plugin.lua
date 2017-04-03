--[[
	Gatherer Addon for World of Warcraft(tm).
	HUD Plugin Module
	Version: 3.1.14 (<%codename%>)
	Revision: $Id: Plugin.lua 854 2009-04-16 06:13:47Z Esamynn $

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
		This AddOn\'s source code is specifically designed to work with
		World of Warcraft\'s interpreted AddOn system.
		You have an implicit licence to use this AddOn with these facilities
		since that is it\'s designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
]]


local plugin = Gatherer_HUD

local _tr = Gatherer.Locale.Tr
local _trC = Gatherer.Locale.TrClient
local _trL = Gatherer.Locale.TrLocale

local function getDefault(setting)
	if (setting == "plugin.gatherer_hud.radius")        then return 500     end
	if (setting == "plugin.gatherer_hud.iconsize")      then return 40      end
	if (setting == "plugin.gatherer_hud.offset.horizontal") then return 0   end
	if (setting == "plugin.gatherer_hud.offset.vertical") then return -200  end
	if (setting == "plugin.gatherer_hud.alpha")         then return 70      end
	if (setting == "plugin.gatherer_hud.strata")        then return 1       end
	if (setting == "plugin.gatherer_hud.yards")         then return 1200    end
	if (setting == "plugin.gatherer_hud.fade")          then return 45      end
	if (setting == "plugin.gatherer_hud.aspect")        then return 40      end
	if (setting == "plugin.gatherer_hud.reduce")        then return 60      end
	if (setting == "plugin.gatherer_hud.heat.enable")   then return true    end
	if (setting == "plugin.gatherer_hud.heat.cooldown") then return 600     end
	if (setting == "plugin.gatherer_hud.heat.size")     then return 120     end
	if (setting == "plugin.gatherer_hud.heat.alpha")    then return 25      end
	if (setting == "plugin.gatherer_hud.base.enable")   then return false   end
	if (setting == "plugin.gatherer_hud.base.alpha")    then return 50      end
	if (setting == "plugin.gatherer_hud.hide.combat")   then return true    end
	if (setting == "plugin.gatherer_hud.hide.target")   then return true    end
	if (setting == "plugin.gatherer_hud.hide.flying")   then return false   end
	if (setting == "plugin.gatherer_hud.hide.inside")   then return true    end
	if (setting == "plugin.gatherer_hud.hide.mounted")  then return false   end
	if (setting == "plugin.gatherer_hud.hide.walking")  then return false   end
	if (setting == "plugin.gatherer_hud.hide.resting")  then return true    end
	if (setting == "plugin.gatherer_hud.hide.stealth")  then return true    end
	if (setting == "plugin.gatherer_hud.hide.swimming") then return false   end
	if (setting == "plugin.gatherer_hud.base.color")    then return "0,0,0,0.5" end
	if (setting == "plugin.gatherer_hud.center.color")  then return "1,1,1,0.4" end
	if (setting == "plugin.gatherer_hud.heat.color")    then return "1,0.3,0,0.7" end
	if (setting == "plugin.gatherer_hud.base.enable")   then return false   end
	if (setting == "plugin.gatherer_hud.center.enable") then return true    end
	if (setting == "plugin.gatherer_hud.min_fullframerate") then return 100 end
end

local function makeConfigTab( gui )
	local tabName = GetAddOnMetadata("Gatherer_HUD", "X-Gatherer-Plugin-Name")
	
	local _, id = gui:GetTabByName(tabName, "PLUGINS")
	gui:MakeScrollable(id)
	gui:AddControl(id, "Note",       0, 1, 580, 30, _tr("The use of the HUD will consume frames from your framerate, and will consume even more frames if you enable the \"Heat\" tracking mode which keeps track of your past traffic via a heat trail."))
	gui:AddControl(id, "Subhead",    0,    _trL("HUD display options"))
	gui:AddControl(id, "WideSlider", 0, 2, "plugin.gatherer_hud.radius", 25, 800, 25, _trL("Overall HUD radius: %d pixels"))
	gui:AddControl(id, "WideSlider", 0, 2, "plugin.gatherer_hud.iconsize", 5, 80, 1, _trL("Note size: %d pixels"))
	gui:AddControl(id, "WideSlider", 0, 2, "plugin.gatherer_hud.offset.horizontal", -800, 800, 10, _trL("Horizontal offset: %d pixels"))
	gui:AddControl(id, "WideSlider", 0, 2, "plugin.gatherer_hud.offset.vertical", -800, 800, 10, _trL("Vertical offset: %d pixels"))
	gui:AddControl(id, "WideSlider", 0, 2, "plugin.gatherer_hud.alpha", 1, 100, 1, _trL("Overall HUD alpha: %d%%"))
	gui:AddControl(id, "Selectbox",  0, 2, {
		{1, "Strata: Background"},
		{2, "Strata: Low"},
		{3, "Strata: Medium"},
		{4, "Strata: High"}
	}, "plugin.gatherer_hud.strata", _trL("HUD strata"))
	gui:AddControl(id, "WideSlider", 0, 2, "plugin.gatherer_hud.yards", 100, 2000, 100, _trL("Notes range: %d yards"))
	gui:AddControl(id, "WideSlider", 0, 2, "plugin.gatherer_hud.fade", 1, 100, 1, _trL("Notes fade out at: %d%% of radius"))
	gui:AddControl(id, "WideSlider", 0, 2, "plugin.gatherer_hud.aspect", 1, 100, 1, _trL("Vertical ratio: %d%%"))
	gui:AddControl(id, "WideSlider", 0, 2, "plugin.gatherer_hud.reduce", 0, 100, 1, _trL("Forward/Backward reduction: %d%%"))
	gui:AddControl(id, "WideSlider", 0, 2, "plugin.gatherer_hud.min_fullframerate", 0, 100, 1, _trL("minimum framerate to draw every frame: %dfps"))
	gui:AddControl(id, "Subhead",    0,    _trL("HUD hiding options"))
	gui:AddControl(id, "Checkbox",   0, 1, "plugin.gatherer_hud.hide.combat", _trL("Hide HUD while in combat"))
	gui:AddControl(id, "Checkbox",   0, 1, "plugin.gatherer_hud.hide.target", _trL("Hide HUD while targetting"))
	gui:AddControl(id, "Checkbox",   0, 1, "plugin.gatherer_hud.hide.flying", _trL("Hide HUD while flying"))
	gui:AddControl(id, "Checkbox",   0, 1, "plugin.gatherer_hud.hide.inside", _trL("Hide HUD while inside"))
	gui:AddControl(id, "Checkbox",   0, 1, "plugin.gatherer_hud.hide.mounted", _trL("Hide HUD while mounted"))
	gui:AddControl(id, "Checkbox",   0, 1, "plugin.gatherer_hud.hide.walking", _trL("Hide HUD while not mounted"))
	gui:AddControl(id, "Checkbox",   0, 1, "plugin.gatherer_hud.hide.resting", _trL("Hide HUD while resting"))
	gui:AddControl(id, "Checkbox",   0, 1, "plugin.gatherer_hud.hide.stealth", _trL("Hide HUD while stealthed"))
	gui:AddControl(id, "Checkbox",   0, 1, "plugin.gatherer_hud.hide.swimming", _trL("Hide HUD while swimming"))
	gui:AddControl(id, "Subhead",    0,    _trL("HUD visibility options"))
	gui:AddControl(id, "Checkbox",   0, 2, "plugin.gatherer_hud.base.enable", _trL("Darken HUD to improve visibility"))
	gui:AddControl(id, "ColorSelectAlpha", 0, 3, "plugin.gatherer_hud.base.color", _trL("Underlay color"))
	gui:AddControl(id, "Checkbox",   0, 2, "plugin.gatherer_hud.center.enable", _trL("Enable player Field Of View circle"))
	gui:AddControl(id, "ColorSelectAlpha", 0, 3, "plugin.gatherer_hud.center.color", _trL("Center color"))
	gui:AddControl(id, "Checkbox",   0, 2, "plugin.gatherer_hud.heat.enable", _trL("Show travel tracking (heat)"))
	gui:AddControl(id, "ColorSelectAlpha", 0, 3, "plugin.gatherer_hud.heat.color", _trL("Heat color"))
	gui:AddControl(id, "Subhead",    0,    _trL("HUD heat tracking mode"))
	gui:AddControl(id, "WideSlider", 0, 3, "plugin.gatherer_hud.heat.cooldown", 10, 4800, 10, _trL("Tracking cooldown: %d seconds"))
	gui:AddControl(id, "Checkbox",   0, 1, "plugin.gatherer_hud.heat.nevercooldown", _trL("Never cooldown"))
	gui:AddControl(id, "WideSlider", 0, 3, "plugin.gatherer_hud.heat.size", 0, 300, 10, _trL("Tracking trail width: %d yards"))
end

local function onConfigChange(setting, value)
	if ( setting:sub(1, 20) == "plugin.gatherer_hud." ) then
		Gatherer_HUD.UpdateStruture()
	end
end

function Gatherer_HUD.Register()
	Gatherer.Plugins.RegisterPlugin("Gatherer_HUD", getDefault, makeConfigTab, onConfigChange)
end
