--[[
	Auctioneer - VendMarkup
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: vendMarkup.lua 4432 2009-08-29 14:55:35Z dinesh $
	URL: http://auctioneeraddon.com/

	This is an addon for World of Warcraft that provides a vendor mark-up
	price statistic for items.  It is intended to be used only at times when
	you do not have a more reliable price statistic, and wish to post an item
	for just a simple vendor markup price instead.

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

local libType, libName = "Util", "VendMarkup"
local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end
local print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill = AucAdvanced.GetModuleLocals()

function lib.GetPrice(hyperlink, serverKey)
	local linkType,itemId,property,factor = decode(hyperlink)
	if linkType == "item" and itemId and itemId > 0 and type(GetSellValue) == "function" then
		local vendorFor = GetSellValue(itemId)
		if vendorFor then
			return vendorFor * get("util.vendmarkup.multiplier") / 100
		end
	end
end

function lib.GetPriceColumns()
	return "Vendor Price Markup"
end

local array = {}
function lib.GetPriceArray(hyperlink, serverKey)
	-- no need to clean the array; we will overwrite the single entry anyway

	-- this module only provides "price"
	array.price = lib.GetPrice(hyperlink)

	-- Return a temporary array. Data in this array is
	-- only valid until this function is called again.
	return array
end

function lib.Processor(callbackType, ...)
	if callbackType == "config" then
		private.SetupConfigGui(...)
	end
end

function lib.OnLoad(addon)
	default("util.vendmarkup.multiplier", 300)
end

function private.SetupConfigGui(gui)
	-- The defaults for the following settings are set in the lib.OnLoad function

	local id = gui:AddTab(libName, libType.." Modules")

	gui:AddHelp(id, "what vendmarkup",
		"What is the Vendor Markup module?",
		"This module will give you the price to vendor an item multiplied by a percentage of that vendor's price to give you the vendor markup price.\n"..
		"This vendor markup is most often used when posting items for auction which do not have any data, you can tell Appraiser to use the vendor markup for the buyout price, and that will give you a good starting point for what the item might sell for.\n")

	gui:AddControl(id, "Header",     0, libName.." options")

	gui:AddControl(id, "TinyNumber", 0, 1, "util.vendmarkup.multiplier", 100, 1000, "Vendor markup (in percent)")

end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-VendMarkup/vendMarkup.lua $", "$Rev: 4432 $")
