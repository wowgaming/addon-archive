--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 3.1.14 (<%codename%>)
	Revision: $Id: GatherTooltip.lua 754 2008-10-14 04:43:39Z Esamynn $

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

	Tooltip functions
]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/release/Gatherer/GatherTooltip.lua $", "$Rev: 754 $")

local _tr = Gatherer.Locale.Tr
local _trC = Gatherer.Locale.TrClient
local _trL = Gatherer.Locale.TrLocale

function Gatherer.Tooltip.AddDropRates( tooltip, nodeId, cont, zone, maxDropsToShow )
	if not ( maxDropsToShow ) then maxDropsToShow = 5 end
-- the following lines replace the commented out section for the momment so that all
-- drop rates are shown with worldwide data
	local total = Gatherer.DropRates.GetDropsTotal(nodeId)
	cont = nil
	zone = nil
--[[
	local total = Gatherer.DropRates.GetDropsTotal(nodeId, cont, zone)
	if not ( total and (total > 0) ) then
		total = Gatherer.DropRates.GetDropsTotal(nodeId)
		cont = nil
		zone = nil
	end
]]
	if ( total and (total > 0) ) then
		tooltip:AddLine(_tr("NOTE_OVERALLDROPS"))
		local numLeft = 0
		for i, item, count in Gatherer.DropRates.ObjectDrops(nodeId, cont, zone, "DESC") do
			local itemName, itemLink, itemRarity, _, _, _, _, _, _, invTexture = GetItemInfo(item)
			if ( itemName and (i <= maxDropsToShow) ) then
				tooltip:AddDoubleLine(itemLink, string.format("x%0.2f", count/total))
				tooltip:AddTexture(invTexture)
			else
				numLeft = numLeft + 1
			end
		end
		if ( numLeft > 0 ) then
			tooltip:AddLine(_tr("NOTE_ADDITIONAL", numLeft))
		end
	end
end