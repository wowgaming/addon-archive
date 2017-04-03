--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 3.1.14 (<%codename%>)
	Revision: $Id: GatherNotifications.lua 754 2008-10-14 04:43:39Z Esamynn $

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

	User Notification System
		This is a system for delivering information to the user in a non-threatening manner 
		such as warnings about Gatherer not recognizing all of the client's maps

]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/release/Gatherer/GatherNotifications.lua $", "$Rev: 754 $")

local _tr = Gatherer.Locale.Tr
local _trC = Gatherer.Locale.TrClient
local _trL = Gatherer.Locale.TrLocale

local metatable = { __index = getfenv(0) }
setmetatable( Gatherer.Notifications, metatable )
setfenv(1, Gatherer.Notifications)

Tooltip = nil -- will be set by the OnLoad function
Messages = {}

local function DisplayNotification()
	if ( IsLoggedIn() and Messages[1] ) then
		Tooltip:ClearLines()
		if not ( Tooltip:IsShown() ) then
			Tooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")
		end
		local C = HIGHLIGHT_FONT_COLOR
		Tooltip:SetText(_trL("Gatherer: Warnings"), C.r, C.g, C.b)
		for _, text in ipairs(Messages) do
			Tooltip:AddLine("———————————————————————————————————————————————————") -- I'd perfer if this produced a solid line :/
			Tooltip:AddLine(text, nil, nil, nil, true)
		end
		Tooltip:Show()
	end
end

function AddInfo( text )
	table.insert(Messages, text)
	DisplayNotification()
end


function OnLoad( tooltip )
	Tooltip = tooltip
	tooltip:RegisterEvent("PLAYER_LOGIN")
end

function OnShow( tooltip )
	tooltip.timeVisible = 0
end

function OnHide( tooltip )
	Messages = {}
end

function OnUpdate( tooltip, elapsed )
	timeVisible = tooltip.timeVisible
	timeVisible = timeVisible + elapsed
	if ( MouseIsOver(tooltip) ) then
		tooltip.timeVisible = 0
		tooltip:Show()
	else
		if ( timeVisible > 30 ) then
			tooltip:FadeOut(10)
			tooltip.timeVisible = -1000
		else
			tooltip.timeVisible = timeVisible
		end
	end
end

function OnEvent(self, event, ...)
	if ( event == "PLAYER_LOGIN" ) then
		DisplayNotification()
	end
end