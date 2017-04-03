--[[
	Enchantrix Addon for World of Warcraft(tm).
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: EnxAucUtil.lua 4432 2009-08-29 14:55:35Z dinesh $
	URL: http://enchantrix.org/

	This is an addon for World of Warcraft that add a list of what an item
	disenchants into to the items that you mouse-over in the game.

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
Enchantrix_RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Enchantrix/EnxAucUtil.lua $","$Rev: 4432 $")

-- Provide fixed price data by registering ourselves as a bonafide legitimate Auctioneer module.
if (not (AucAdvanced and AucAdvanced.Modules and AucAdvanced.Modules.Util) ) then return end

local lib = {}
Enchantrix.AucUtil = lib

AucAdvanced.Modules.Util.Enchantrix = lib

--local print = AucAdvanced.Print

local get = Enchantrix.Settings.GetSetting

function lib.GetName() return "Enchantrix" end

local priceTable = {}
local priceTableAge
function lib.IsValidAlgorithm(hyperlink)
	if not get("export.aucadv") then return false end

    if get("ScanValueType") == "adv:stat:Appraiser" then return false end  -- Stops infinite loop from using Appraiser prices which uses Market Price which uses Enchantrix.

	local linkType,itemId,property,factor = AucAdvanced.DecodeLink(hyperlink)
	if (linkType ~= "item") then return false end

	if Enchantrix.Constants.StaticPrices[itemId] then
		return true, itemId
	end
	return false
end

local array
function lib.GetPriceArray(link)
	local usable, itemId = lib.IsValidAlgorithm(link)
    if not usable then return end
	array = {}

	if not priceTableAge or priceTableAge < GetTime() - 15 then
		priceTable = Enchantrix.Util.CreateReagentPricingTable(priceTable)
		priceTableAge = GetTime()
	end

	array.price = priceTable[itemId]
	array.seen = 0
	array.confidence = 1
	return array
end
