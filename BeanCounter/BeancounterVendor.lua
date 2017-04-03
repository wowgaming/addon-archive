--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: BeancounterVendor.lua 3583 2008-10-11 16:50:02Z Norganna $
	URL: http://auctioneeraddon.com/

	BeanCounterVendor - Records Vendor Transactions

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
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
]]
LibStub("LibRevision"):Set("$URL: http://svn.norganna.org/auctioneer/branches/5.8/BeanCounter/BeancounterVendor.lua $","$Rev: 3583 $","5.1.DEV.", 'auctioneer', 'libs')

local libName = "BeanCounter"
local libType = "Util"
local lib = BeanCounter
local private, print, get, set, _BC = lib.getLocals()

local function debugPrint(...)
    if get("util.beancounter.debugVendor") then
        private.debugPrint("BeanCounterVendor",...)
    end
end

function private.vendorOnevent(event,...)
	if (event == "MERCHANT_SHOW") then
		private.merchantShow()
	elseif (event == "MERCHANT_CLOSED") then


	elseif (event == "MERCHANT_UPDATE") then
		--private.merchantUpdate()
	end
end
local moneyStart, LastitemSold, repairAllCost

function private.merchantShow()
--hooksecurefunc("ShowContainerSellCursor", private.merchantUpdate)

moneyStart = private.wealth

	if CanMerchantRepair() then
		repairAllCost = GetRepairAllCost()
	end
end

 function private.merchantUpdate(...)
--print("SOLD",...)

 end

 function private.merchantRepairAllItems()
	if CanMerchantRepair() then
		if (GetRepairAllCost() == 0) and (repairAllCost > 0) then --we repaired
			--print("we repaired this amount",repairAllCost)
		end
	end

 end

function private.merchantBuy(id, amount) --Hooked function
	local name, _, price, quantity, _, _, _ = GetMerchantItemInfo(id)
	local link = GetMerchantItemLink(id)
	local itemID, _ = private.getItemInfo(link, "itemid")

	if amount then quantity = amount end --Amount only send for stacked items

	local value = private.packString(link, price, quantity, time())

	--private.databaseAdd("vendorbuy", itemID, value)
	debugPrint("Vendor buy added..",itemID, value)
end
