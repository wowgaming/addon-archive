--[[
	Auctioneer - Search UI
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: SearchMain.lua 4640 2010-01-26 02:18:04Z Nechckn $
	URL: http://auctioneeraddon.com/

	This Addon provides a Search tab on the AH interface, which allows
	Auctioneer users to use Searcher plug-ins to search for good deals
	in the auction house.  It searches the "snapshot", which requires
	having data from recent auction house scans.

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

local libType, libName = "Util", "SearchUI"
local AucAdvanced = AucAdvanced
local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end
local print,decode,_,_,replicate,_,get,set,default,debugPrint,fill = AucAdvanced.GetModuleLocals()
local debugPrint = AucAdvanced.Debug.DebugPrint

local empty = wipe
local ipairs,pairs,type,select = ipairs,pairs,type,select
local tostring,tonumber = tostring,tonumber
local floor,ceil,abs = floor,ceil,abs
local strmatch,format = strmatch,format
local tinsert,tremove = tinsert,tremove
-- GLOBALS: CreateFrame, GameTooltip

-- Our official name:
AucSearchUI = lib

function lib.GetName()
	return libName
end

local Const = AucAdvanced.Const
local gui
private.data = {}
private.sheetData = {}
private.sheetStyle = {}
private.isSearching = false
local coSearch
local SettingCache = {}
local currentSettings = {}
local hasUnsaved = nil

local TAB_NAME = "Search"

private.tleft = {
	"|cff000001|cffe5e5e530m", -- 30m
	"|cff000002|cffe5e5e52h",  --2h
	"|cff000003|cffe5e5e512h", --12h
	"|cff000004|cffe5e5e548h"  --48h
}

lib.CleanTable = wipe -- for compatibility

local resources = {}
lib.Resources = resources
local flagResourcesUpdateRequired = false
local flagScanStats = false

-- Faction Resources
-- Commonly used values which change depending whether you are at home or neutral Auctionhouse
-- Modules should expect these to always contain valid values; nil tests should not be required
resources.Realm = GetRealmName() -- will not change during session
function private.UpdateFactionResources()
	local serverKey, _, Faction = AucAdvanced.GetFaction()
	if serverKey ~= resources.serverKey then
		-- store new settings
		resources.Faction = Faction
		resources.faction = Faction:lower() -- lowercase for GetDepositCost
		resources.serverKey = serverKey
		resources.CutAdjust = 1 - AucAdvanced.cutRate -- multiply price by .CutAdjust to subtract the AH brokerage fees
		-- notify the change
		lib.NotifyCallbacks("resources", "faction", serverKey)
	end
end
-- todo: we really should update when Zone changes, but there in't a processor event for that

-- Selectbox Resources
--[[ Usages:
gui:AddControl(id, "Selectbox", column, indent, resources.selectorPriceModels, "searcher.model")
gui:AddControl(id, "Selectbox", column, indent, resources.selectorPriceModelsEnx, "searcher.model")
gui:AddControl(id, "Selectbox", column, indent, resources.selectorAuctionLength, "searcher.deplength")
local price, seen, curModel = resources.lookupPriceModel[model](model, link || itemID [, serverKey]) ~ price, seen or curModel may be nil
local price, seen, curModel = resources.GetPrice(model, link || itemID [, serverKey]) ~ simplified wrapper function for lookupPriceModel
if not resources.isValidPriceModel(get("searcher.model")) then <code to report warning...>
--]]
do -- limit scope of locals
	resources.selectorAuctionLength = AucAdvanced.selectorAuctionLength
	lib.AucLengthSelector = AucAdvanced.selectorAuctionLength -- for compatibility
	resources.selectorPriceModels = AucAdvanced.selectorPriceModels

	local pricemodelsenx
	function resources.selectorPriceModelsEnx()
		if not pricemodelsenx then
			pricemodelsenx = replicate(resources.selectorPriceModels())
			if resources.isEnchantrixLoaded then
				tinsert(pricemodelsenx, 1, {"Enchantrix", "Enchantrix"})
			end
		end
		return pricemodelsenx
	end
	function private.ResetPriceModelEnx()
		pricemodelsenx = nil
	end

	function resources.isValidPriceModel(testmodel)
		local pricemodels = resources.selectorPriceModelsEnx() -- make sure table is up to date
		local found -- default return value nil
		for pos, model in ipairs(pricemodels) do
			if model[1] == testmodel then
				found = model[2]
				break
			end
		end
		return found
	end

	-- lookup functions
	local function UnknownFunc() end -- return nil

	local function MarketFunc(model, link, serverKey)
		local price, seen = AucAdvanced.API.GetMarketValue(link, serverKey)
		return price, seen, model
	end

	local function AppraiserFunc(model, link, serverKey)
		local market, bid, _, seen, curModel = AucAdvanced.Modules.Util.Appraiser.GetPrice(link, serverKey)
		if not market or market == 0 then
			market = bid -- fallback to bid price if no market
		end
		return market, seen, curModel
	end

	local function EnchantrixFunc(model, link, serverKey)
		-- GetReagentPrice does not handle serverKey, and it does not return a seen count
		local extra, mkt, five, _
		_, extra = Enchantrix.Util.GetPricingModel()
		_, _, mkt, five = Enchantrix.Util.GetReagentPrice(link, extra)
		return five or mkt, nil, extra or model
	end

	local function AlgorithmFunc(model, link, serverKey)
		local market, seen = AucAdvanced.API.GetAlgorithmValue(model, link, serverKey)
		return market, seen, model
	end

	local function indexFunc(lookup, model)
		local func
		if model == "Appraiser" and AucAdvanced.Modules.Util.Appraiser then
			func = AppraiserFunc
		elseif model == "Enchantrix" and resources.isEnchantrixLoaded then
			func = EnchantrixFunc
		elseif AucAdvanced.API.IsValidAlgorithm(model) then
			func = AlgorithmFunc
		end
		if func then
			rawset(lookup, model, func)
			return func
		end
		return UnknownFunc
	end

	local lookuppricemodel = setmetatable({market = MarketFunc}, {__index = indexFunc})

	resources.lookupPriceModel = lookuppricemodel
	function resources.GetPrice(model, link, serverKey) -- simplified wrapper
		return lookuppricemodel[model](model, link, serverKey)
	end
end

-- Enchantrix Load detection
if Enchantrix and Enchantrix.Storage and Enchantrix.Util then
	resources.isEnchantrixLoaded = true
else
	local _, _, _, enabled, loadable = GetAddOnInfo("Enchantrix") -- check it's actually possible to load
	if enabled and loadable then
		Stubby.RegisterAddOnHook("Enchantrix", "Auc-Util-SearchUI", function()
			if Enchantrix and Enchantrix.Storage and Enchantrix.Util then
				Stubby.UnregisterAddOnHook("Enchantrix", "Auc-Util-SearchUI")
				resources.isEnchantrixLoaded = true
				private.ResetPriceModelEnx()
				lib.NotifyCallbacks("onload", "enchantrix")
			end
		end)
	end
end

function lib.OnLoad(addon)
	-- Notify that SearchUI is fully loaded
	resources.isSearchUILoaded = true
	lib.NotifyCallbacks("onload", addon)

	-- Initialize
	private.UpdateFactionResources()
end

function lib.Processor(callbackType, ...)
	if callbackType == "load" then
		private.ResetPriceModelEnx()
	elseif (callbackType == "auctionclose") then
		if private.isAttached then
			lib.DetachFromAH()
		end
		flagResourcesUpdateRequired = true
	elseif callbackType == "auctionopen" then
		flagResourcesUpdateRequired = true
	elseif (callbackType == "auctionui") then
		if lib.Searchers.RealTime then
			lib.Searchers.RealTime.HookAH()
		end

		--we need to make sure that the GUI is made by the time the AH opens, as RealTime could be trying to add lines to it.
		if not gui then
			lib.MakeGuiConfig()
		end

		lib.CreateAuctionFrames()
	elseif (callbackType == "pagefinished") then
		if lib.Searchers.RealTime then
			lib.Searchers.RealTime.FinishedPage(...)
		end
	elseif (callbackType == "bidcancelled") then --bid was cancelled, we need to ignore auction for current session
		private.bidcancelled(...)
	elseif (callbackType == "tooltip") then
		lib.ProcessTooltip(...)
	elseif callbackType == "scanstats" then
		-- pass the message in next OnUpdate
		flagScanStats = true
	elseif callbackType == "scanprogress" and private.UpdateScanProgress then
		private.UpdateScanProgress(...)
	elseif callbackType == "buyqueue" and private.UpdateBuyQueue then
		private.UpdateBuyQueue()
	end
end

function lib.ProcessTooltip(tooltip, name, hyperlink, quality, quantity, cost, additional)
	if not additional or additional.event ~= "SetAuctionItem" then
		--this isn't an auction, so we're not interested
		return
	end
	if not lib.GetSetting("debug.show") then
		--we're not interested in adding debug
		return
	end
	local button = GetMouseFocus():GetParent() --Note: check that it works without CompactUI
	local id = button.id --CompactUI's layout
	if not id then
		id = button:GetID() + FauxScrollFrame_GetOffset(BrowseScrollFrame) --without CompactUI
	end

	local name, _, count, _, canUse, level, minBid, minInc, buyout, curBid, isHigh, owner = GetAuctionItemInfo("list", id)
	local price
	if curBid > 0 then
		price = curBid + minInc
		if buyout > 0 and price > buyout then
			price = buyout
		end
	elseif minBid > 0 then
		price = minBid
	else
		price = 1
	end
	local timeleft = GetAuctionItemTimeLeft("list", id)
	local _, _, _, iLevel, _, iType, iSubType, stack, iEquip = GetItemInfo(hyperlink)
	iEquip = Const.EquipEncode[iEquip]
	local _, itemid, suffix, factor, enchant, seed = AucAdvanced.DecodeLink(hyperlink)
	local ItemTable = {}
	-- put the data into a table laid out the same way as the AAdv Scandata, as that's what the searchers need
	ItemTable[Const.LINK]    = hyperlink
	ItemTable[Const.ILEVEL]  = iLevel
	ItemTable[Const.ITYPE]   = iType
	ItemTable[Const.ISUB]    = iSubType
	ItemTable[Const.IEQUIP]  = iEquip
	ItemTable[Const.PRICE]   = price
	ItemTable[Const.TLEFT]   = timeleft
	ItemTable[Const.NAME]    = name
	ItemTable[Const.COUNT]   = count
	ItemTable[Const.QUALITY] = quality
	ItemTable[Const.CANUSE]  = canUse
	ItemTable[Const.ULEVEL]  = level
	ItemTable[Const.MINBID]  = minBid
	ItemTable[Const.MININC]  = minInc
	ItemTable[Const.BUYOUT]  = buyout
	ItemTable[Const.CURBID]  = curBid
	ItemTable[Const.AMHIGH]  = isHigh
	ItemTable[Const.SELLER]  = owner
	ItemTable[Const.ITEMID]  = itemid
	ItemTable[Const.SUFFIX]  = suffix
	ItemTable[Const.FACTOR]  = factor
	ItemTable[Const.ENCHANT]  = enchant
	ItemTable[Const.SEED]  = seed

	tooltip:AddLine("SearchUI:", 1, 0.7, 0.3)

	local active = false
	for name, searcher in pairs(lib.Searchers) do
		if lib.GetSetting("debug."..name) then
			active = true
			local success, returnvalue, value = lib.SearchItem(name, ItemTable, true, true)
			if success then
				if value then
					tooltip:AddLine("  "..name.." profit:"..floor(100*returnvalue/value).."%:", returnvalue, 1, 0.7, 0.3)
				elseif returnvalue then
					tooltip:AddLine("  "..name.." profit:", returnvalue, 1, 0.7, 0.3)
				else
					tooltip:AddLine("  "..name.." success", 1, 0.7, 0.3)
				end
			else
				tooltip:AddLine("  "..name..":"..returnvalue, 1, 0.7, 0.3)
			end
		end
	end
	if not active then --if it hasn't changed, we're not enabled for any searcher
		tooltip:AddLine("  No debugging enabled", 1, 0.7, 0.3)
	end
end

-- Default setting values
local settingDefaults = {
	["processpriority"] = 80,
	["reserve"] = 0,
	["reserve.enable"] = false,
	["global.createtab"] = true,
	["maxprice"] = 10000000,
	["maxprice.enable"] = false,
	["tooltiphelp.show"] = true,
	--Scrollframe defaults
	["columnwidth.Item"] = 120,
	["columnwidth.Pct"] = 30,
	["columnwidth.Profit"] = 85,
	["columnwidth.Stk"] = 30,
	["columnwidth.Buyout"] = 85,
	["columnwidth.Bid"] = 85,
	["columnwidth.Reason"] = 85,
	["columnwidth.Seller"] = 75,
	["columnwidth.Left"] = 40,
	["columnwidth.Buy/ea"] = 85,
	["columnwidth.Bid/ea"] = 85,
	["columnwidth.MinBid"] = 85,
	["columnwidth.CurBid"] = 85,
	["columnwidth.Min/ea"] = 85,
	["columnwidth.Cur/ea"] = 85,
}

local function getDefault(setting)
	return settingDefaults[setting]
end

function lib.GetDefault(setting)
	return getDefault(setting)
end

function lib.SetDefault(setting, default)
	settingDefaults[setting] = default
end

local function initData()
	local data = AucAdvancedData.UtilSearchUiData
	if not data then
		data = {}
		data.Version = 1
		AucAdvancedData.UtilSearchUiData = data
	end
	if not data.SavedSearches then data.SavedSearches = {} end
	if not data.Current then data.Current = {} end
	if not data.Global then data.Global = {} end
end

local function isGlobalSetting(setting)
	local a,b,c = strsplit(".", setting)
	if a == "configator" then return true end
	if a == "global" then return true end
	return
end

local function setter(setting, value)
	AucAdvancedData.UtilSearchUI = nil -- Remove old settings
	initData()

	local db = currentSettings

	-- turn value into a canonical true or false
	if value == 'on' then
		value = true
	elseif value == 'off' then
		value = false
	end

	if (isGlobalSetting(setting)) then
		AucAdvancedData.UtilSearchUiData.Global[setting] = value
		return
	end

	-- for defaults, just remove the value and it'll fall through
	if (value == 'default') or (value == getDefault(setting)) then
		-- Don't save default values
		value = nil
	end

	if db[setting] == value then
		if type(value) == "table" then
			-- same table as before
			-- call UpdateSave to check if the *contents* of the table have changed
			-- but don't send Processor message as *setting* is the same (consistent with Core version of 'setter')
			hasUnsaved = true
			lib.UpdateSave()
		end
		return
	end
	db[setting] = value

	hasUnsaved = true
	lib.UpdateSave()

	AucAdvanced.SendProcessorMessage("configchanged", setting, value)
	lib.NotifyCallbacks('config', 'changed', setting, value)
end

function lib.SetSetting(...)
	setter(...)
	if (gui) then
		gui:Refresh()
	end
end

local function getter(setting)
	initData()
	local db = currentSettings

	if (isGlobalSetting(setting)) then
		local value = AucAdvancedData.UtilSearchUiData.Global[setting]
		if value ~= nil then return value end
		return getDefault(setting)
	end

	if ( db[setting] ~= nil ) then
		return db[setting]
	else
		return getDefault(setting)
	end
end

function lib.GetSetting(setting, default)
	--use settings cache during a search
	if private.isSearching then
		if SettingCache[setting]~=nil then
			return SettingCache[setting]
		end
	end
	local option = getter(setting)
	if ( option ~= nil ) then
		if private.isSearching then
			SettingCache[setting] = option
		end
		return option
	else
		if private.isSearching then
			SettingCache[setting] = default
		end
		return default
	end
end

function lib.Show()
	if not gui then --no need to make the GUI if it already exists
		lib.MakeGuiConfig()
	end
	gui:Show()
	private.UpdateFactionResources()
end

function lib.Hide()
	if (gui) then
		gui:Hide()
	end
end

function lib.Toggle()
	if private.isAttached then return end
	if (gui and gui:IsShown()) then
		lib.Hide()
	else
		lib.Show()
	end
end

private.callbacks = {}
function lib.AddCallback(name, callback)
	if private.callbacks[name] then -- prevent overwriting an exisiting callback
		error("AucSearchUI.AddCallback Error:\nCallback for "..name.." already exists", 2) -- level 2 is calling function
	end
	private.callbacks[name] = callback
	-- fire certain callbacks, that have already happened, to new callback function
	if resources.isEnchantrixLoaded then
		callback("onload", "enchantrix")
	end
	if resources.isSearchUILoaded then
		callback("onload", "auc-util-searchui")
	end
	if gui then
		callback("guiconfig", gui)
	end
end

function lib.NotifyCallbacks(msg, ...)
	for name, callback in pairs(private.callbacks) do
		callback(msg, ...)
	end

	for name, searcher in pairs(lib.Searchers) do
		local processor = searcher.Processor
		if processor then
			local pType = type(processor)
			if pType == "table" then
				processor = processor[msg]
				if type(processor) == "function" then
					processor(...)
				end
			elseif pType == "function" then
				processor(msg, ...)
			end
		end
	end
	for name, filter in pairs(lib.Filters) do
		local processor = filter.Processor
		if processor then
			local pType = type(processor)
			if pType == "table" then
				processor = processor[msg]
				if type(processor) == "function" then
					processor(...)
				end
			elseif pType == "function" then
				processor(msg, ...)
			end
		end
	end
end

function lib.RemoveCallback(name, callback)
	if callback and private.callbacks[name] == callback then
		private.callbacks[name] = nil
		return true
	end
end

local searcherKit = {}
function searcherKit:GetName()
	return self.name
end

lib.Searchers = {}
function lib.NewSearcher(searcherName)
	if not lib.Searchers[searcherName] then
		local searcher = {}
		searcher.name = searcherName
		for k,v in pairs(searcherKit) do
			searcher[k] = v
		end

		lib.Searchers[searcherName] = searcher
		return searcher, lib, {}
	end
end

local filterKit = {}
function filterKit:GetName()
	return self.name
end

lib.Filters = {}
function lib.NewFilter(filterName)
	if not lib.Filters[filterName] then
		local filter = {}
		filter.name = filterName
		for k,v in pairs(filterKit) do
			filter[k] = v
		end

		lib.Filters[filterName] = filter
		return filter, lib, {}
	end
end

function lib.GetSearchLocals()
	return lib.GetSetting, lib.SetSetting, lib.SetDefault, Const, resources
end

function private.removeline()
	local selected = gui.sheet.selected
	--find the place in the sort list, so we can select the next one.
	for i,j in ipairs(gui.sheet.sort) do
		if j == selected then
			selected = i
			break
		end
	end
	tremove(private.sheetData, gui.sheet.selected)
	--regenerate style elements, to match shorter data table
	local total =  #private.sheetData
	for i = gui.sheet.selected, total do
		private.sheetStyle[i] = private.sheetStyle[i+1]
		if i == total then private.sheetStyle[i+1] = nil end --remove extra style
	end
	--gui.frame.remove:Disable()
	gui.sheet.selected = nil
	gui.sheet:SetData(private.sheetData, private.sheetStyle)
	lib.UpdateControls()
	gui.sheet.selected = gui.sheet.sort[selected]
	gui.sheet:Render() --need to redraw, so the selection looks right
	lib.UpdateControls()
end

function private.removeall()
	empty(private.sheetData)
	empty(private.sheetStyle)
	gui.sheet.selected = nil
	gui.sheet:SetData(private.sheetData, private.sheetStyle)
	gui.sheet:Render() --need to redraw, so the selection looks right
	lib.UpdateControls()
end

function private.repaintSheet()
	local wasEmpty = #gui.sheet.data < 1
	gui.sheet:SetData(private.sheetData, private.sheetStyle)
	if wasEmpty then --sheet was empty, so select the just added auction
		gui.sheet.selected = 1
		gui.sheet:Render() --need to redraw, so the selection looks right
		lib.UpdateControls()
	end
end

function private.cropreason(reason)
	if reason then
		reason = strsplit(":", reason)
		return reason
	end
end

function private.buyauction()
	AucAdvanced.Buy.QueueBuy(private.data.link, private.data.seller, private.data.stack, private.data.minbid, private.data.buyout, private.data.buyout, private.cropreason(private.data.reason))
	private.removeline()
end

function private.bidauction()
	local bid = MoneyInputFrame_GetCopper(gui.frame.bidbox)
	AucAdvanced.Buy.QueueBuy(private.data.link, private.data.seller, private.data.stack, private.data.minbid, private.data.buyout, bid, private.cropreason(private.data.reason))
	private.removeline()
end

function private.buyfirst()
	gui.sheet.selected = gui.sheet.sort[1]
	if not gui.sheet.selected then
		return
	end
	lib.UpdateControls()
	if strmatch(private.data.reason, ":buy") then
		AucAdvanced.Buy.QueueBuy(private.data.link, private.data.seller, private.data.stack, private.data.minbid, private.data.buyout, private.data.buyout, private.cropreason(private.data.reason))
	elseif strmatch(private.data.reason, ":bid") then
		AucAdvanced.Buy.QueueBuy(private.data.link, private.data.seller, private.data.stack, private.data.minbid, private.data.buyout, private.data.bid, private.cropreason(private.data.reason))
	elseif private.data.buyout > 0 then
		AucAdvanced.Buy.QueueBuy(private.data.link, private.data.seller, private.data.stack, private.data.minbid, private.data.buyout, private.data.buyout, private.cropreason(private.data.reason))
	else
		AucAdvanced.Buy.QueueBuy(private.data.link, private.data.seller, private.data.stack, private.data.minbid, private.data.buyout, private.data.bid, private.cropreason(private.data.reason))
	end
	private.removeline()
end

--private.purchase
--Will buy/bid selected auction based on "reason" column
function private.purchase()
	if not gui.sheet.selected then
		return
	end
	local enableres = lib.GetSetting("reserve.enable")
	local reserve = lib.GetSetting("reserve") or 1
	local bidqueue = gui.frame.cancel.value or 0
	local balance = GetMoney()
	balance = balance - bidqueue --account for money we've already "spent"

	local price = 0
	if strmatch(private.data.reason, ":buy") then
		price = private.data.buyout
	elseif strmatch(private.data.reason, ":bid") then
		price = private.data.bid
	elseif private.data.buyout > 0 then
		price = private.data.buyout
	else
		price = private.data.bid
	end
	if ((balance-price) > reserve or not enableres) then
		AucAdvanced.Buy.QueueBuy(private.data.link, private.data.seller, private.data.stack, private.data.minbid, private.data.buyout, price, private.cropreason(private.data.reason))
	else
		print("Purchase cancelled: Reserve reached")
	end
	private.removeline()
end
--Will buy/bid ALL auctions based on "reason" column
function private.purchaseall()
	gui.sheet.selected = gui.sheet.sort[1]
	if not gui.sheet.selected then
		return
	end
	lib.UpdateControls()
	local count = 0
	while #gui.sheet.sort > 0 and (gui.sheet.sort[1] or count < 5000 ) do
		count = count+1--emergency break routine
		local enableres = lib.GetSetting("reserve.enable")
		local reserve = lib.GetSetting("reserve") or 1
		local bidqueue = gui.frame.cancel.value or 0
		local balance = GetMoney()
		balance = balance - bidqueue --account for money we've already "spent"

		local price = 0
		if strmatch(private.data.reason, ":buy") then
			price = private.data.buyout
		elseif strmatch(private.data.reason, ":bid") then
			price = private.data.bid
		elseif private.data.buyout > 0 then
			price = private.data.buyout
		else
			price = private.data.bid
		end
		if ((balance-price) > reserve or not enableres) then
			AucAdvanced.Buy.QueueBuy(private.data.link, private.data.seller, private.data.stack, private.data.minbid, private.data.buyout, price, private.cropreason(private.data.reason))
		else
			print("Purchase cancelled: Reserve reached")
		end
		private.removeline()
	end
end
function private.ignore()
	local sig = AucAdvanced.API.GetSigFromLink(private.data.link)
	local price
	if strmatch(private.data.reason, ":buy") then
		price = private.data.buyout
	elseif strmatch(private.data.reason, ":bid") then
		price = private.data.bid
	elseif private.data.buyout > 0 then
		price = private.data.buyout
	else
		price = private.data.bid
	end
	local count = private.data.stack or 1
	price = floor(price/count)
	AucSearchUI.Filters.ItemPrice.AddIgnore(sig, price)
	print("SearchUI now ignoring "..private.data.link.." at "..AucAdvanced.Coins(price, true))
	private.removeline()
end

function private.ignoreperm()
	local sig = AucAdvanced.API.GetSigFromLink(private.data.link)
	AucSearchUI.Filters.ItemPrice.AddIgnore(sig, 0)
	print("SearchUI now ignoring "..private.data.link.." at any price")
	private.removeline()
end

--a bid was cancelled, so ignore for session
function private.bidcancelled(callbackstring)
	local link, price, count = strsplit(";", callbackstring)
	local sig = AucAdvanced.API.GetSigFromLink(link)
	local price = floor(price/count) - 1
	if AucSearchUI.Filters.ItemPrice then
		AucSearchUI.Filters.ItemPrice.AddIgnore(sig, price, true)
		print("SearchUI now ignoring "..link.." at "..AucAdvanced.Coins(price, true).." for the session")
	end

end

function private.ignoretemp()
	local sig = AucAdvanced.API.GetSigFromLink(private.data.link)
	local price
	if strmatch(private.data.reason, ":buy") then
		price = private.data.buyout
	elseif strmatch(private.data.reason, ":bid") then
		price = private.data.bid
	elseif private.data.buyout > 0 then
		price = private.data.buyout
	else
		price = private.data.bid
	end
	local count = private.data.stack or 1
	price = floor(price/count)
	AucSearchUI.Filters.ItemPrice.AddIgnore(sig, price, true)
	print("SearchUI now ignoring "..private.data.link.." at "..AucAdvanced.Coins(price, true).." for the session")
	private.removeline()
end

function private.snatch()
	local link = private.data.link
	local price
		if strmatch(private.data.reason, ":buy") then
		price = private.data.buyout
	elseif strmatch(private.data.reason, ":bid") then
		price = private.data.bid
	elseif private.data.buyout > 0 then
		price = private.data.buyout
	else
		price = private.data.bid
	end
	local count = private.data.stack or 1
	price = floor(price/count) + 1 -- +1 so the current item also matches the search
	lib.Searchers.Snatch.AddSnatch(link,price)
	print("SearchUI will now snatch "..private.data.link.." at "..AucAdvanced.Coins(price, true))
end

local function keyPairs(t,f)
	local a, i = {}, 0
	for n in pairs(t) do tinsert(a, n) end
	table.sort(a, f)
	local iter = function ()
		i = i + 1
		if a[i] == nil then return nil
		else return a[i], t[a[i]] end
	end
	return iter
end

local function isEqual(a, b, l)
	if not l then l = 0
	elseif l > 10 then return false end

	local ta, tb = type(a), type(b)
	if ta ~= tb then return false end
	if ta == 'table' then
		for k,v in pairs(a) do
			if not isEqual(v, b[k], l+1) then return false end
		end
		for k,v in pairs(b) do
			if not isEqual(v, a[k], l+1) then return false end
		end
	else
		if tostring(a) ~= tostring(b) then
			return false
		end
	end
	return true
end
lib.IsEqual = isEqual

function lib.LoadCurrent()
	initData()
	local name = gui.saves.name:GetText()
	currentSettings = AucAdvancedData.UtilSearchUiData.Current
	if not currentSettings then
		lib.LoadSearch()
		return
	end

	local existing = AucAdvancedData.UtilSearchUiData.SavedSearches[name]
	if not existing then
		hasUnsaved = true
	elseif not isEqual(currentSettings, existing) then
		hasUnsaved = true
	else
		hasUnsaved = nil
	end
	lib.UpdateSave()
	gui:Refresh()
	lib.NotifyCallbacks('config', 'loaded', nil)
end

function lib.LoadSearch()
	initData()
	local name = gui.saves.name:GetText()
	if not AucAdvancedData.UtilSearchUiData.SavedSearches[name] then
		message("SearchUI warning:\nThat search does not exist, please select an available search from the menu.")
		return
	end
	currentSettings = replicate(AucAdvancedData.UtilSearchUiData.SavedSearches[name])
	AucAdvancedData.UtilSearchUiData.Current = currentSettings
	AucAdvancedData.UtilSearchUiData.Selected = name
	hasUnsaved = nil
	lib.UpdateSave()
	gui:Refresh()
	lib.NotifyCallbacks('config', 'loaded', name)
end

function lib.SaveSearch()
	initData()
	local name = gui.saves.name:GetText()
	AucAdvancedData.UtilSearchUiData.SavedSearches[name] = replicate(currentSettings)
	AucAdvancedData.UtilSearchUiData.Selected = name
	hasUnsaved = nil
	lib.UpdateSave()
	gui:Refresh()
	lib.NotifyCallbacks('config', 'saved', name)
end

function lib.DeleteSearch()
	initData()
	local name = gui.saves.name:GetText()
	AucAdvancedData.UtilSearchUiData.SavedSearches[name] = nil
	hasUnsaved = nil
	AucAdvancedData.UtilSearchUiData.Selected = ""
	gui.saves.name:SetText("")
	lib.UpdateSave()
	gui:Refresh()
	lib.NotifyCallbacks('config', 'deleted', name)
end

function lib.ResetSearch()
	initData()
	currentSettings = {}
	AucAdvancedData.UtilSearchUiData.Current = currentSettings
	hasUnsaved = nil
	AucAdvancedData.UtilSearchUiData.Selected = ""
	gui.saves.name:SetText("")
	lib.UpdateSave()
	gui:Refresh()
	lib.NotifyCallbacks('config', 'reset')
end

local curColor = "white"
function lib.UpdateSave()
	if not (gui and AucAdvancedData.UtilSearchUiData) then return end

	local name = gui.saves.name:GetText()

	if hasUnsaved then
		local saved = AucAdvancedData.UtilSearchUiData.SavedSearches[name]
		if saved and isEqual(currentSettings, saved) then
			hasUnsaved = false
		end
	end

	if AucAdvancedData.UtilSearchUiData.Selected ~= name then
		if curColor ~= "white" then
			gui.saves.name:SetTextColor(1, 1, 1, 1)
			curColor = "white"
		end
	elseif hasUnsaved then
		if curColor ~= "red" then
			gui.saves.name:SetTextColor(1, 0.5, 0.1, 1)
			curColor = "red"
		end
	else
		if curColor ~= "green" then
			gui.saves.name:SetTextColor(0.3, 1, 0.3, 1)
			curColor = "green"
		end
	end
end

function lib.AddSearcher(gui, searchType, searchDetail, searchPos)
	if not gui.searchers[searchPos] then gui.searchers[searchPos] = {} end
	gui.searchers[searchPos][searchType] = searchDetail
end

function lib.AttachToAH()
	if private.isAttached then return end
	local height, width = 410, 830
	gui.buttonTop = -30
	gui:SetPosition(gui.AuctionFrame, width, height, 5, 7+height)
	gui:HideBackdrop()
	gui:EnableMouse(false)
	gui:RealSetScale(0.9999)
	gui:RealSetScale(1.0)
	gui:Show()
	private.isAttached = true
end

function lib.DetachFromAH()
	if not private.isAttached then return end
	gui.buttonTop = 0
	gui:SetPosition()
	gui:EnableMouse(true)
	gui:ShowBackdrop()
	gui:RealSetScale(0.9999)
	gui:RealSetScale(private.scale or 1)
	gui:Hide()
	private.isAttached = nil
end

function lib.CreateAuctionFrames()
	if not lib.GetSetting("global.createtab") then return end

	local frame = CreateFrame("Frame", "AucAdvSearchUiAuctionFrame", AuctionFrame)
	gui.AuctionFrame = frame

	frame:SetParent(AuctionFrame)
	frame:SetPoint("TOPLEFT", AuctionFrame, "TOPLEFT")
	frame:SetPoint("BOTTOMRIGHT", AuctionFrame, "BOTTOMRIGHT")

	frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	frame.title:SetPoint("TOP", frame,  "TOP", 20, -17)
	frame.title:SetText("SearchUI - Auction search interface")

	local myTabName = "AuctionFrameTabUtilSearchUi"
	frame.tab = CreateFrame("Button", myTabName, AuctionFrame, "AuctionTabTemplate")
	frame.tab:SetText(TAB_NAME)
	frame.tab:Show()

	function frame.tab.OnClick(self, button, down)
		local index = self:GetID()
		local tab = getglobal("AuctionFrameTab"..index)
		if (tab and tab:GetName() == myTabName) then
			AuctionFrameTopLeft:SetTexture("Interface\\AddOns\\Auc-Advanced\\Textures\\AuctionFrameTopLeft")
			AuctionFrameTop:SetTexture("Interface\\AddOns\\Auc-Advanced\\Textures\\AuctionFrameTopMid")
			AuctionFrameTopRight:SetTexture("Interface\\AddOns\\Auc-Advanced\\Textures\\AuctionFrameTopRight")
			AuctionFrameBotLeft:SetTexture("Interface\\AddOns\\Auc-Advanced\\Textures\\AuctionFrameBotLeft")
			AuctionFrameBot:SetTexture("Interface\\AddOns\\Auc-Advanced\\Textures\\AuctionFrameBotMid")
			AuctionFrameBotRight:SetTexture("Interface\\AddOns\\Auc-Advanced\\Textures\\AuctionFrameBotRight")
			AuctionFrameMoneyFrame:Hide()
			frame:Show()
			lib.AttachToAH()
		else
			AuctionFrameMoneyFrame:Show()
			frame:Hide()
			lib.DetachFromAH()
		end
	end

	PanelTemplates_DeselectTab(frame.tab)
	AucAdvanced.AddTab(frame.tab, frame)

	hooksecurefunc("AuctionFrameTab_OnClick", frame.tab.OnClick)

	frame.money = frame:CreateTexture(nil, "ARTWORK")
	frame.money:SetTexture("Interface\\AddOns\\Auc-Advanced\\Textures\\GoldMoney")
	frame.money:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 18, 34)
	frame.money:SetWidth(256)
	frame.money:SetHeight(32)

	frame.backing = CreateFrame("Frame", nil, frame)
	frame.backing:SetPoint("TOPLEFT", frame, "TOPLEFT", 17, -70)
	frame.backing:SetPoint("BOTTOMRIGHT", frame.money, "TOPLEFT", 145, 50)
	frame.backing:SetBackdrop({ bgFile="Interface\\AddOns\\Auc-Advanced\\Textures\\BlackBack", edgeFile="Interface\\AddOns\\Auc-Advanced\\Textures\\WhiteCornerBorder", tile=1, tileSize=8, edgeSize=8, insets={left=3, right=3, top=3, bottom=3} })
	frame.backing:SetBackdropColor(0,0,0, 0.60)

	frame.scanslabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	frame.scanslabel:SetPoint("TOPLEFT", frame, "TOPLEFT", 72, -20)
	frame.scanslabel:SetText("Pending Scans")
	frame.scanscount = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	frame.scanscount:ClearAllPoints()
	frame.scanscount:SetPoint("LEFT", frame.scanslabel, "RIGHT", 5, 0)
	frame.scanscount:SetText("0")
	frame.scanscount:SetJustifyH("RIGHT")
	frame.scanscount.last = 0
	function private.UpdateScanProgress(_, _, _, _, _, _, _, scansQueued)
		if AucAdvanced.Scan.IsScanning() then
			scansQueued = scansQueued + 1
		end
		if scansQueued ~= frame.scanscount.last then
			frame.scanscount.last = scansQueued
			frame.scanscount:SetText(scansQueued)
		end
	end
end

function lib.MakeGuiConfig()
	if gui then return end

	local Configator = LibStub("Configator")
	local ScrollSheet = LibStub("ScrollSheet")
	local id, last, cont
	local selected

	gui = Configator:Create(setter,getter, 900, 500, 5, 350, 20, 5)
	gui:SetBackdropColor(0,0,0,1)

	gui.expandGap = 25
	gui.expandOnActivate = true
	gui.autoScrollTabs = true

	gui.searchers = {}
	gui.AddSearcher = function (self, searchType, searchDetail, searchPos)
		lib.AddSearcher(self, searchType, searchDetail, searchPos)
	end

	-- Only set scale if the gui isn't attached to the AH frame
	gui.RealSetScale = gui.SetScale
	function gui:SetScale(scale)
		private.scale = scale
		if private.isAttached then return end
		gui:RealSetScale(scale)
	end

	-- hook ActivateTab to notify callback
	gui.RealActivateTab = gui.ActivateTab
	function gui:ActivateTab(...)
		gui:RealActivateTab(...)
		local newtab = gui.config.selectedTab
		if newtab ~= gui.LastActiveTab then
			gui.LastActiveTab = newtab
			lib.NotifyCallbacks("selecttab", newtab)
		end
		gui.Search.updateDisplay()
	end

	private.gui = gui

	-- common functions and scripthandlers, used by various buttons and frames
	local function showTooltipText(button)
		if lib.GetSetting("tooltiphelp.show") then
			GameTooltip:SetOwner(button, "ANCHOR_BOTTOMRIGHT")
			GameTooltip:SetText(button.TooltipText)
		end
	end
	local function hideTooltip()
		GameTooltip:Hide()
	end

	gui.frame = CreateFrame("Frame", nil, gui)
	gui.frame:SetPoint("TOP", gui, "TOP", 0, -115)
	gui.frame:SetPoint("BOTTOMRIGHT", gui.Done, "TOPRIGHT", 0,25)
	gui.frame:SetPoint("LEFT", gui:GetButton(1), "RIGHT", 5,0)
	gui.frame:SetBackdrop({
		bgFile = "Interface/Tooltips/ChatBubble-Background",
		edgeFile = "Interface/Tooltips/ChatBubble-BackDrop",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 32, right = 32, top = 32, bottom = 32 }
	})
	gui.frame:SetBackdropColor(0, 0, 0, 1)

	gui.saves = CreateFrame("Frame", nil, gui)
	gui.saves:SetPoint("TOPRIGHT", gui, "TOPRIGHT", -5,-7)
	gui.saves:SetPoint("LEFT", gui:GetButton(1), "RIGHT", 10,0)
	gui.saves:SetHeight(28)
--	gui.saves:SetBackdrop({
--		bgFile = "Interface/Tooltips/ChatBubble-Background",
--		edgeFile = "Interface/Tooltips/ChatBubble-BackDrop",
--		tile = true, tileSize = 32, edgeSize = 18,
--		insets = { left = 20, right = 20, top = 20, bottom = 20 }
--	})
--	gui.saves:SetBackdropColor(0, 0, 0, 1)

	gui.saves.title = gui.saves:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	gui.saves.title:SetPoint("LEFT", gui.saves, "LEFT", 10,0)
	gui.saves.title:SetText("Saved searches:")

	gui.saves.name = CreateFrame("EditBox", "SearchUiSaveName", gui.saves, "InputBoxTemplate")
	gui.saves.name:SetPoint("LEFT", gui.saves.title, "RIGHT", 10,0)
	gui.saves.name:SetAutoFocus(false)
	gui.saves.name:SetWidth(200)
	gui.saves.name:SetHeight(18)
	gui.saves.name:SetScript("OnTextChanged", function() lib.UpdateSave() end)
	if AucAdvancedData.UtilSearchUiData then
		local curSearch = AucAdvancedData.UtilSearchUiData.Selected or ""
		if AucAdvancedData.UtilSearchUiData.SavedSearches[curSearch] then
			gui.saves.name:SetText(curSearch)
		else
			gui.saves.name:SetText("")
		end
		lib.LoadCurrent()
	end

	local SelectBox = LibStub:GetLibrary("SelectBox")

	gui.saves.select = SelectBox:Create("SearchUiSaveSelect", gui.saves, 220, function(pos, key, value)
		gui.saves.name:SetText(value)
	end, function ()
		local saves = AucAdvancedData.UtilSearchUiData.SavedSearches
		local items = {}
		if (saves) then
			for name, sdata in keyPairs(saves) do
				tinsert(items, name)
			end
		end
		return items
	end, "")
	gui.saves.select:SetParent(gui.saves)
	gui.saves.select:SetScale(0.999)
	gui.saves.select:SetScale(1.0)
	gui.saves.select:SetPoint("RIGHT", gui.saves.name, "RIGHT", 38,-4)
	gui.saves.select:SetInputHidden(true)

	gui.saves.load = CreateFrame("Button", nil, gui.saves, "OptionsButtonTemplate")
	gui.saves.load:SetPoint("LEFT", gui.saves.name, "RIGHT", 25, 0)
	gui.saves.load:SetWidth(70)
	gui.saves.load:SetHeight(20)
	gui.saves.load:SetText("Load")
	gui.saves.load:SetScript("OnClick", function() lib.LoadSearch() end)

	gui.saves.save = CreateFrame("Button", nil, gui.saves, "OptionsButtonTemplate")
	gui.saves.save:SetPoint("LEFT", gui.saves.load, "RIGHT", 5, 0)
	gui.saves.save:SetWidth(70)
	gui.saves.save:SetHeight(20)
	gui.saves.save:SetText("Save")
	gui.saves.save:SetScript("OnClick", function() lib.SaveSearch() end)

	gui.saves.delete = CreateFrame("Button", nil, gui.saves, "OptionsButtonTemplate")
	gui.saves.delete:SetPoint("LEFT", gui.saves.save, "RIGHT", 5, 0)
	gui.saves.delete:SetWidth(70)
	gui.saves.delete:SetHeight(20)
	gui.saves.delete:SetText("Delete")
	gui.saves.delete:SetScript("OnClick", function() lib.DeleteSearch() end)

	gui.saves.reset = CreateFrame("Button", nil, gui.saves, "OptionsButtonTemplate")
	gui.saves.reset:SetPoint("LEFT", gui.saves.delete, "RIGHT", 10, 0)
	gui.saves.reset:SetWidth(70)
	gui.saves.reset:SetHeight(20)
	gui.saves.reset:SetText("Reset")
	gui.saves.reset:SetScript("OnClick", function()
		if IsShiftKeyDown() and IsControlKeyDown() and IsAltKeyDown() then
			lib.ResetSearch()
			print("All searchUI settings have been reset.")
		else
			print("This resets all searchUI settings, you must hold CTRL + SHIFT + ALT when clicking this button")
		end
	end)

	function lib.UpdateControls()
		if gui.sheet.selected then
			gui.frame.ignore:Enable()
			gui.frame.ignoreperm:Enable()
			gui.frame.notnow:Enable()
			gui.frame.snatch:Enable()
		else
			gui.frame.ignore:Disable()
			gui.frame.ignoreperm:Disable()
			gui.frame.notnow:Disable()
			gui.frame.snatch:Disable()
		end
		if selected ~= gui.sheet.selected then
			selected = gui.sheet.selected
			local data = gui.sheet:GetSelection()
			if not data then
				empty(private.data)
			else
				private.data.link = data[1]
				private.data.seller = data[8]
				private.data.stack = data[4]
				private.data.bid = data[6]
				private.data.minbid = data[12]
				private.data.curbid = data[13]
				private.data.buyout = data[5]
				private.data.reason = data[7]
			end
			if private.data.buyout and (private.data.buyout > 0) then
				gui.frame.buyout:Enable()
				gui.frame.buyoutbox:SetText(AucAdvanced.Coins(private.data.buyout, true))
			else
				gui.frame.buyout:Disable()
				gui.frame.buyoutbox:SetText(AucAdvanced.Coins(0, true))
			end

			if private.data.bid then
				MoneyInputFrame_SetCopper(gui.frame.bidbox, private.data.bid)
				gui.frame.bid:Enable()
			else
				MoneyInputFrame_SetCopper(gui.frame.bidbox, 0)
				gui.frame.bid:Disable()
			end
		elseif private.data.curbid then--bid price was changed, so make sure that it's allowable
			if MoneyInputFrame_GetCopper(gui.frame.bidbox) < ceil(private.data.curbid*1.05) then
				MoneyInputFrame_SetCopper(gui.frame.bidbox, ceil(private.data.curbid*1.05))
			end
			gui.frame.bid:Enable()
		end
		--if bid >= buyout, it's going to be a buyout anyway, so disable bid button to indicate that
		if private.data.buyout and (private.data.buyout > 0) and (MoneyInputFrame_GetCopper(gui.frame.bidbox) >= private.data.buyout) then
			MoneyInputFrame_SetCopper(gui.frame.bidbox, private.data.buyout)
			gui.frame.bid:Disable()
		end
		gui.frame.purchase.updateEnable()
	end

	function lib.OnEnterSheet(button, row, index)
		if gui.sheet.rows[row][index]:IsShown() then --Hide tooltip for hidden cells
			local link, count
			link = gui.sheet.rows[row][index]:GetText()
			if link and link:find("\124Hitem:%d") then
				if gui.sheet.order then
					for i, label in pairs(gui.sheet.labels) do
						if  label:GetText() == "Stk" then --need to localize this when we localize the rest of searchUI
							count = tonumber(gui.sheet.rows[row][i]:GetText())
							break
						end
					end
				else
					count = tonumber(gui.sheet.rows[row][4]:GetText() )
				end

				GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
				AucAdvanced.ShowItemLink(GameTooltip, link, count)
			end
		end
	end

	function lib.OnClickSheet(button, row, index)
		index = index - (index%15-1)
		if IsShiftKeyDown() then --Add the item link to chat
			local link = gui.sheet.rows[row][index]:GetText()
			if not link then
				return
			end
			ChatEdit_InsertLink(link)
		elseif IsAltKeyDown() then --Search for the item in browse tab.
			local name = gui.sheet.rows[row][index]:GetText()
			if not name then
				return
			end
			name = GetItemInfo(name)
			QueryAuctionItems(name)
		end
	end
	--records the column width changes
	--store width by header name, that way if column reorginizing is added we apply size to proper column
	function private.OnResizeSheet(self, column, width)
		if not width then
			lib.SetSetting("columnwidth."..self.labels[column]:GetText(), "default") --reset column if no width is passed. We use CTRL+rightclick to reset column
			self.labels[column].button:SetWidth(lib.GetSetting("columnwidth."..self.labels[column]:GetText()))
		else
			lib.SetSetting("columnwidth."..self.labels[column]:GetText(), width)
		end
	end

	gui.sheet = ScrollSheet:Create(gui.frame, {
		{ "Item",   "TOOLTIP", lib.GetSetting("columnwidth.Item") }, --120
		{ "Pct",    "INT", lib.GetSetting("columnwidth.Pct")   }, --30
		{ "Profit", "COIN", lib.GetSetting("columnwidth.Profit") , { DESCENDING=true } }, --85
		{ "Stk",    "INT",  lib.GetSetting("columnwidth.Stk")  }, --30
		{ "Buyout", "COIN", lib.GetSetting("columnwidth.Buyout"), { DESCENDING=true } }, --85
		{ "Bid",    "COIN", lib.GetSetting("columnwidth.Bid"), { DESCENDING=true } }, --85
		{ "Reason", "TEXT", lib.GetSetting("columnwidth.Reason")  }, --85
		{ "Seller", "TEXT", lib.GetSetting("columnwidth.Seller")  }, --75
		{ "Left",   "TEXT", lib.GetSetting("columnwidth.Left")  }, --40
		{ "Buy/ea", "COIN", lib.GetSetting("columnwidth.Buy/ea"), { DESCENDING=true, DEFAULT=true } }, --85
		{ "Bid/ea", "COIN", lib.GetSetting("columnwidth.Bid/ea"), { DESCENDING=true, DEFAULT=true } }, --85
		{ "MinBid", "COIN", lib.GetSetting("columnwidth.MinBid"), { DESCENDING=true } }, --85
		{ "CurBid", "COIN", lib.GetSetting("columnwidth.CurBid"), { DESCENDING=true } }, --85
		{ "Min/ea", "COIN", lib.GetSetting("columnwidth.Min/ea"), { DESCENDING=true } }, --85
		{ "Cur/ea", "COIN", lib.GetSetting("columnwidth.Cur/ea"), { DESCENDING=true } }, --85
	})
	gui.sheet:EnableSelect(true)
	gui.sheet:EnableVerticalScrollReset(false) --tells scrollframes we do NOT want to reset position when rendering a new data table

	--If we have a saved order reapply
	if lib.GetSetting("columnorder") then
		--print("saved order applied")
		gui.sheet:SetOrder(lib.GetSetting("columnorder") )
	end
	--Apply last column sort used
	if lib.GetSetting("columnsortcurSort") then
		gui.sheet.curSort = lib.GetSetting("columnsortcurSort") or 1
		gui.sheet.curDir = lib.GetSetting("columnsortcurDir") or 1
		gui.sheet:PerformSort()
	end
	--After we have finished creating the scrollsheet and all saved settings have been applied set our event processor
	function gui.sheet.Processor(callback, self, button, column, row, order, curDir, ...)
		if (callback == "ColumnOrder") then
			lib.SetSetting("columnorder", order)
		elseif (callback == "ColumnWidthSet") then
			private.OnResizeSheet(self, column, button:GetWidth() )
		elseif (callback == "ColumnWidthReset") then
			private.onResize(self, column, nil)
		elseif (callback == "OnEnterCell")  then
			lib.OnEnterSheet(button, row, column)
		elseif (callback == "OnLeaveCell") then
			GameTooltip:Hide()
		elseif (callback == "OnClickCell") then
			lib.OnClickSheet(button, row, column)
		elseif (callback == "ColumnSort") then
			lib.SetSetting("columnsortcurDir", curDir)
			lib.SetSetting("columnsortcurSort", column)
		elseif (callback == "OnMouseDownCell") then
			lib.UpdateControls()
		end
	end

	gui.Search = CreateFrame("Button", "AucSearchUISearchButton", gui, "OptionsButtonTemplate")
	gui.Search:SetPoint("BOTTOMLEFT", gui, "BOTTOMLEFT", 30, 50)
	gui.Search:SetText("Search")
	gui.Search:SetScript("OnClick", lib.PerformSearch)
	gui.Search:SetFrameLevel(11)
	gui.Search.TooltipText = "Search Snapshot using current Searcher"
	gui.Search:SetScript("OnEnter", showTooltipText)
	gui.Search:SetScript("OnLeave", hideTooltip)
	gui.Search:Disable()
	gui.Search.updateDisplay = function()
		if gui.config.selectedCat == "Searchers" then
			gui.Search:Enable()
		else
			gui.Search:Disable()
		end
	end


	gui:AddCat("Welcome")

	id = gui:AddTab("About")
	gui.aboutTab = id
	gui:MakeScrollable(id)
	gui:AddControl(id, "Subhead",    0,    "About the SearchUI")

	gui:AddCat("Searchers", nil, nil, true)
	gui:AddCat("Filters")

	gui:AddCat("Options")
	id = gui:AddTab("General Options", "Options")
	gui:MakeScrollable(id)
	gui:AddControl(id, "Header",           0,    "Setup general options")
	gui:AddControl(id, "WideSlider",       0, 1, "processpriority", 10, 100, 10, "Search process priority: %s")
	gui:AddControl(id, "Subhead",          0,    "Purchase Settings")
	gui:AddControl(id, "Checkbox",         0, 1, "reserve.enable", "Enable reserve amount:")
	gui:AddControl(id, "MoneyFramePinned", 0, 2, "reserve", 0, 99999999, "Reserve Amount")
	gui:AddTip(id, "Sets the amount that you don't want your cash-on-hand to fall below")
	gui:AddControl(id, "Checkbox",         0, 1, "maxprice.enable", "Enable maximum price:")
	gui:AddControl(id, "MoneyFramePinned", 0, 2, "maxprice", 1, 99999999, "Maximum Price")
	gui:AddTip(id, "Sets the amount that you don't want to spend more than")

	id = gui:AddTab("Global Settings", "Settings")
	gui:MakeScrollable(id)
	gui:AddControl(id, "Header",           0,    "Setup global options")

	gui:AddControl(id, "Subhead",          0,    "Tooltip")
	gui:AddControl(id, "Checkbox",          0, 1, "tooltiphelp.show", "Show tooltip help over buttons")
	gui:AddControl(id, "Checkbox",         0, 1, "debug.show", "Show debug line in tooltip for auctions")
	for name, searcher in pairs(lib.Searchers) do
		if searcher and searcher.Search then
			gui:AddControl(id, "Checkbox",  0, 2, "debug."..name, "Show debug for "..name)
			gui:AddTip(id, "Show a debug line in the tooltip over auctions for searcher: "..name)
		end
	end

	gui:AddControl(id, "Subhead",          0,    "Integration")
	gui:AddControl(id, "Checkbox",          0, 1, "global.createtab", "Create tab in auction house (requires restart)")

	gui:SetScript("OnKeyDown", lib.UpdateControls)

	gui.frame.purchase = CreateFrame("Button", nil, gui.frame, "OptionsButtonTemplate")
	gui.frame.purchase:SetPoint("BOTTOMLEFT", gui, "BOTTOMLEFT", 170, 35)
	gui.frame.purchase:SetText("Purchase")
	gui.frame.purchase:SetScript("OnClick", private.purchase)
	gui.frame.purchase:Disable()
	gui.frame.purchase.TooltipText = "Bid/BuyOut selected auction\nbased on 'reason' column. \nHold CTRL+ALT+SHIFT to purchase all items."
	gui.frame.purchase:SetScript("OnEnter", showTooltipText)
	gui.frame.purchase:SetScript("OnLeave", hideTooltip)
	gui.frame.purchase.toggleAll = false
	gui.frame.purchase.updateEnable = function()
		if gui.frame.purchase.toggleAll then
			if gui.sheet.sort[1] then
				gui.frame.purchase:Enable()
			else
				gui.frame.purchase:Disable()
			end
		else
			if (gui.frame.bid:IsEnabled()==1) or (gui.frame.buyout:IsEnabled()==1) then
				gui.frame.purchase:Enable()
			else
				gui.frame.purchase:Disable()
			end
		end
	end
	gui.frame.purchase.updateDisplay = function()
		local all = IsShiftKeyDown() and IsControlKeyDown() and IsAltKeyDown()
		if all ~= gui.frame.purchase.toggleAll then
			gui.frame.purchase.toggleAll = all
			if all then
				gui.frame.purchase:SetText("Purchase All")
				gui.frame.purchase:SetScript("OnClick", private.purchaseall)
			else
				gui.frame.purchase:SetText("Purchase")
				gui.frame.purchase:SetScript("OnClick", private.purchase)
			end
		end
		gui.frame.purchase.updateEnable()
	end
	Stubby.RegisterEventHook("MODIFIER_STATE_CHANGED", "Auc-Util-SearchUI", gui.frame.purchase.updateDisplay)


	gui.frame.notnow = CreateFrame("Button", nil, gui.frame, "OptionsButtonTemplate")
	gui.frame.notnow:SetPoint("BOTTOMLEFT", gui, "BOTTOMLEFT", 260, 35)
	gui.frame.notnow:SetText("Not Now")
	gui.frame.notnow:SetScript("OnClick", private.ignoretemp)
	gui.frame.notnow:Disable()
	gui.frame.notnow.TooltipText = "Ignore selected auction for session"
	gui.frame.notnow:SetScript("OnEnter", showTooltipText)
	gui.frame.notnow:SetScript("OnLeave", hideTooltip)

	gui.frame.ignore = CreateFrame("Button", nil, gui.frame, "OptionsButtonTemplate")
	gui.frame.ignore:SetPoint("BOTTOMLEFT", gui, "BOTTOMLEFT", 400, 35)
	gui.frame.ignore:SetText("Ignore Price")
	gui.frame.ignore:SetScript("OnClick", private.ignore)
	gui.frame.ignore:Disable()
	gui.frame.ignore.TooltipText = "Ignore selected auction at listed price"
	gui.frame.ignore:SetScript("OnEnter", showTooltipText)
	gui.frame.ignore:SetScript("OnLeave", hideTooltip)

	gui.frame.ignoreperm = CreateFrame("Button", nil, gui.frame, "OptionsButtonTemplate")
	gui.frame.ignoreperm:SetPoint("BOTTOMLEFT", gui, "BOTTOMLEFT", 490, 35)
	gui.frame.ignoreperm:SetText("Ignore")
	gui.frame.ignoreperm:SetScript("OnClick", private.ignoreperm)
	gui.frame.ignoreperm:Disable()
	gui.frame.ignoreperm.TooltipText = "Ignore selected auction at any price"
	gui.frame.ignoreperm:SetScript("OnEnter", showTooltipText)
	gui.frame.ignoreperm:SetScript("OnLeave", hideTooltip)

	gui.frame.snatch = CreateFrame("Button", nil, gui.frame, "OptionsButtonTemplate")
	gui.frame.snatch:SetPoint("BOTTOMLEFT", gui, "BOTTOMLEFT", 630, 35)
	gui.frame.snatch:SetText("Snatch")
	gui.frame.snatch:SetScript("OnClick", private.snatch)
	gui.frame.snatch:Disable()
	gui.frame.snatch.TooltipText = "Add selected auction to snatch list"
	gui.frame.snatch:SetScript("OnEnter", showTooltipText)
	gui.frame.snatch:SetScript("OnLeave", hideTooltip)

	gui.frame.clear = CreateFrame("Button", nil, gui.frame, "OptionsButtonTemplate")
	gui.frame.clear:SetPoint("BOTTOMLEFT", gui, "BOTTOMLEFT", 170, 10)
	gui.frame.clear:SetText("Clear")
	gui.frame.clear:SetScript("OnClick", private.removeall)
	gui.frame.clear:Enable()
	gui.frame.clear.TooltipText = "Clear results list"
	gui.frame.clear:SetScript("OnEnter", showTooltipText)
	gui.frame.clear:SetScript("OnLeave", hideTooltip)

	gui.frame.cancel = CreateFrame("Button", "AucAdvSearchUICancelButton", gui.frame, "OptionsButtonTemplate")
	gui.frame.cancel:SetPoint("BOTTOMLEFT", gui, "BOTTOMLEFT", 30, 30)
	gui.frame.cancel:SetWidth(22)
	gui.frame.cancel:SetHeight(18)
	gui.frame.cancel:Disable()
	gui.frame.cancel:SetScript("OnClick", function()
		AucAdvanced.Buy.CancelBuyQueue(true)
		gui.frame.cancel.value = 0
	end)
	gui.frame.cancel.value = 0
	private.UpdateBuyQueue = function ()
		local queuelen, queuecost, prompt, promptcost = AucAdvanced.Buy.GetQueueStatus()
		if prompt then
			queuelen = queuelen + 1
			queuecost = queuecost + promptcost
		end
		if queuelen > 0 then
			gui.frame.cancel.label:SetText(tostring(queuelen)..": "..AucAdvanced.Coins(queuecost, true))
			gui.frame.cancel.value = queuecost
			gui.frame.cancel:Enable()
			gui.frame.cancel.tex:SetVertexColor(1.0, 0.9, 0.1)
		else
			gui.frame.cancel.label:SetText("")
			gui.frame.cancel.value = 0
			gui.frame.cancel:Disable()
			gui.frame.cancel.tex:SetVertexColor(0.3, 0.3, 0.3)
		end
	end
	gui.frame.cancel.tex = gui.frame.cancel:CreateTexture(nil, "OVERLAY")
	gui.frame.cancel.tex:SetPoint("TOPLEFT", gui.frame.cancel, "TOPLEFT", 4, -2)
	gui.frame.cancel.tex:SetPoint("BOTTOMRIGHT", gui.frame.cancel, "BOTTOMRIGHT", -4, 2)
	gui.frame.cancel.tex:SetTexture("Interface\\Addons\\Auc-Advanced\\Textures\\NavButtons")
	gui.frame.cancel.tex:SetTexCoord(0.25, 0.5, 0, 1)
	gui.frame.cancel.tex:SetVertexColor(0.3, 0.3, 0.3)
	gui.frame.cancel.label = gui.frame.cancel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	gui.frame.cancel.label:SetPoint("LEFT", gui.frame.cancel, "RIGHT", 5, 0)
	gui.frame.cancel.label:SetTextColor(1, 0.8, 0)
	gui.frame.cancel.label:SetText("")
	gui.frame.cancel.label:SetJustifyH("LEFT")

	gui.frame.buyout = CreateFrame("Button", nil, gui.frame, "OptionsButtonTemplate")
	gui.frame.buyout:SetPoint("BOTTOMLEFT", gui, "BOTTOMLEFT", 650, 10)
	gui.frame.buyout:SetText("Buyout")
	gui.frame.buyout:SetScript("OnClick", private.buyauction)
	gui.frame.buyout:Disable()
	gui.frame.buyout.TooltipText = "Buyout selected auction"
	gui.frame.buyout:SetScript("OnEnter", showTooltipText)
	gui.frame.buyout:SetScript("OnLeave", hideTooltip)

	gui.frame.buyoutbox = gui.frame.buyout:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	gui.frame.buyoutbox:SetPoint("BOTTOMRIGHT", gui.frame.buyout, "BOTTOMLEFT", -4, 4)
	gui.frame.buyoutbox:SetWidth(100)

	gui.frame.bid = CreateFrame("Button", nil, gui.frame, "OptionsButtonTemplate")
	gui.frame.bid:SetPoint("BOTTOMRIGHT", gui.frame.buyoutbox, "BOTTOMLEFT", -10, -4)
	gui.frame.bid:SetText("Bid")
	gui.frame.bid:SetScript("OnClick", private.bidauction)
	gui.frame.bid:Disable()
	gui.frame.bid.TooltipText = "Bid on selected auction using custom price"
	gui.frame.bid:SetScript("OnEnter", showTooltipText)
	gui.frame.bid:SetScript("OnLeave", hideTooltip)

	gui.frame.bidbox = CreateFrame("Frame", "AucAdvSearchUIBidBox", gui.frame, "MoneyInputFrameTemplate")
	gui.frame.bidbox:SetPoint("BOTTOMRIGHT", gui.frame.bid, "BOTTOMLEFT", -4, 4)
	MoneyInputFrame_SetOnValueChangedFunc(gui.frame.bidbox, lib.UpdateControls)

	gui.frame.progressbar = CreateFrame("STATUSBAR", nil, gui.frame, "TextStatusBar")
	gui.frame.progressbar:SetWidth(400)
	gui.frame.progressbar:SetHeight(30)
	gui.frame.progressbar:SetPoint("BOTTOM", gui.frame, "BOTTOM", 0, 100)
	gui.frame.progressbar:SetBackdrop({
	  bgFile="Interface\\Tooltips\\UI-Tooltip-Background",
	  edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
	  tile=1, tileSize=10, edgeSize=10,
	  insets={left=3, right=3, top=3, bottom=3}
	})
	gui.frame.progressbar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
	gui.frame.progressbar:SetStatusBarColor(0.6, 0, 0, 0.4)
	gui.frame.progressbar:SetMinMaxValues(0, 1000)
	gui.frame.progressbar:SetValue(0)
	gui.frame.progressbar:SetFrameLevel(10)
	gui.frame.progressbar:Hide()

	gui.frame.progressbar.text = gui.frame.progressbar:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	gui.frame.progressbar.text:SetPoint("CENTER", gui.frame.progressbar, "CENTER")
	gui.frame.progressbar.text:SetText("AucAdv SearchUI: Searching")
	gui.frame.progressbar.text:SetTextColor(1,1,1)

	gui.frame.progressbar.cancel = CreateFrame("Button", nil, gui.frame.progressbar, "OptionsButtonTemplate")
	gui.frame.progressbar.cancel:SetPoint("BOTTOMRIGHT", gui.frame.progressbar, "BOTTOMRIGHT", -5, 5)
	gui.frame.progressbar.cancel:SetPoint("TOPLEFT", gui.frame.progressbar, "TOPRIGHT", -25, -5)
	gui.frame.progressbar.cancel:SetText("X")
	gui.frame.progressbar.cancel:SetScript("OnClick", private.cancelSearch)

	-- Alert our searchers?
	for name, searcher in pairs(lib.Searchers) do
		if searcher.MakeGuiConfig then
			searcher:MakeGuiConfig(gui)
		end
	end
	--Alert our Filters
	for name, filter in pairs(lib.Filters) do
		if filter.MakeGuiConfig then
			filter:MakeGuiConfig(gui)
		end
	end

	lib.NotifyCallbacks('guiconfig', gui)

	-- Add the welcome text now
	local b = "  |TInterface\\QuestFrame\\UI-Quest-BulletPoint.blp:13|t "
	local w = ""
	w=w.."The Auctioneer Search UI is here to assist you in finding the Auctions that are of special interest to you.\n"
	w=w.."\n"
	w=w.."It has 2 modes of operation:\n"
	w=w..b.."Offline - Searches are applied against the current data\n"
	w=w..b.."Realtime - Searches are applied against the realtime scans of the AH\n"
	w=w.."\n"
	w=w.."There are also 2 types of searching modules that exist in the Search UI:\n"
	w=w..b.."Searchers - Searches for a specific set of criteria, only 1 searcher is active at once\n"
	w=w..b.."Filters - All filters always apply their criteria, excluding non-matching items from the search.\n"
	w=w.."\n"
	w=w.."In order to begin using the Search UI, you should first setup your filters to exclude the items you don't wish to find, then select a searcher to perform a search.\n"
	w=w.."\n"
	w=w.."Here's a quick list of the searchers and filters that you may wish to investigate:\n"
	for pos, sdata in keyPairs(gui.searchers) do
		for searchType, searchDetail in keyPairs(sdata) do
			w=w..b.."|cffffce00"..searchType.."|r - "..searchDetail.."\n"
		end
	end

	gui:AddControl(gui.aboutTab, "Note", 0, 1, nil, nil, w)
	gui:ActivateTab(gui.aboutTab)
end

local sideIcon
local SlideBar = LibStub:GetLibrary("SlideBar", true)
if SlideBar then
	--Need to figure out if we're embedded first
	local embedded = false
	for _, module in ipairs(AucAdvanced.EmbeddedModules) do
		if module == "Auc-Util-SearchUI"  then
			embedded = true
		end
	end
	if embedded then
		sideIcon = SlideBar.AddButton("Auc-Util-SearchUI", "Interface\\AddOns\\Auc-Advanced\\Modules\\Auc-Util-SearchUI\\Textures\\SearchUIIcon", 300)
	else
		sideIcon = SlideBar.AddButton("Auc-Util-SearchUI", "Interface\\AddOns\\Auc-Util-SearchUI\\Textures\\SearchUIIcon", 300)
	end
	sideIcon:RegisterForClicks("LeftButtonUp","RightButtonUp")
	sideIcon:SetScript("OnClick", lib.Toggle)
	sideIcon.tip = {
		"Auction SearchUI",
		"Allows you to perform searches on the Auctioneer auction cache snapshot, even when away from the Auction House",
		"{{Click}} to open the Search UI.",
	}
end

function private.FindSearcher(item)
	if not gui.config.selectedTab then
		return
	end
	for name, searcher in pairs(lib.Searchers) do
		if searcher and searcher.tabname and searcher.tabname == gui.config.selectedTab and searcher.Search then
			return searcher, name
		end
	end
end

function private.cancelSearch()
	private.SearchCancel = true
end

--lib.SearchItem(searcherName, item, nodupes)
--purpose: handles sending the item to the specified searcher, and if necessary, adds it to the SearchUI results
--nodupes is boolean flag.  If true, no duplicate checking is done.  This flag is true for searching from the cache, but false for realtime.
--skipresults is boolean flag, If true, nothing gets added to the results list
--returns true, value, profit when successful
--returns false, reason when not
function lib.SearchItem(searcherName, item, nodupes, skipresults)
	if not searcherName or not item or #item == 0 then
		return
	end
	if item[Const.SELLER] == UnitName("player") then
		return false, "Blocked: Can't buy own auction"
	end
	local searcher = lib.Searchers[searcherName]
	if not searcher then
		return
	end
	local debugstring

	--next, pass the item through the filters
	local isfiltered = false
	for filtername, filter in pairs(lib.Filters) do
		if filter.Filter then
			local dofilter, filterreturn = filter.Filter(item, searcherName)
			if dofilter then
				return false, "Filter:"..filtername..": "..tostring(filterreturn)
			end
		end
	end

	--buyorbid must be either "bid", "buy", true, false, or nil
	--if string is returned for buyorbid, value must be number or nil (in which case value will be Marketprice)
	local buyorbid, value, pct, reason
	buyorbid, value, pct, reason = searcher.Search(item)
	if buyorbid then
		--give the filters a second chance to filter out, based on bid/buy differences
		for filtername, filter in pairs(lib.Filters) do
			if filter.PostFilter then
				local dofilter, filterreturn = filter.PostFilter(item, searcherName, buyorbid)
				if dofilter then
					return false, "Filtered by "..filtername..": "..filterreturn
				end
			end
		end

		local cost
		if type(buyorbid) == "string" then
			item["reason"] = searcher.tabname..":"..buyorbid
			if reason then
				item["reason"] = item["reason"]..":"..reason
			end
			if buyorbid == "bid" then
				--don't show result if we're already the highest bidder
				if item[Const.AMHIGH] then
					return false, "Bid blocked: Already high bidder"
				end
				cost = item[Const.PRICE]
			else
				cost = item[Const.BUYOUT]
			end
		else --the searcher only returned that it matches the criteria, so assume buyout if possible.
			item["reason"] = searcher.tabname
			if item[Const.BUYOUT] and item[Const.BUYOUT] > 0 then
				cost = item[Const.BUYOUT]
			elseif item[Const.PRICE] and item[Const.PRICE] > 0 then
				cost = item[Const.PRICE]
				if item[Const.AMHIGH] then
					return false, "Bid blocked: Already high bidder"
				end
			end
		end
		if not value then
			local market = AucAdvanced.API.GetMarketValue(item[Const.LINK])
			if market then -- needs a nil check
				value = item[Const.COUNT]*market
			end
		end
		if not value then
			value = 0
		end
		if not cost then
			return false, "Bid blocked: No valid price possible"
		end
		item["profit"] = value - cost
		local enablemax = lib.GetSetting("maxprice.enable")
		local maxprice = lib.GetSetting("maxprice") or 10000000
		local enableres = lib.GetSetting("reserve.enable")
		local reserve = lib.GetSetting("reserve") or 1
		local bidqueue = gui.frame.cancel.value or 0

		local balance = GetMoney()
		balance = balance - bidqueue --account for money we've already "spent"

		if (cost <= maxprice or not enablemax) and ((balance-cost) > reserve or not enableres) then
			--Check to see whether the item already exists in the results table
			local isdupe = false
			if not nodupes then

				if not private.sheetData then
					private.sheetData = {}
					private.sheetStyle = {}
				end
				for j,k in pairs(private.sheetData) do
					if (k[1] == item[Const.LINK]) and (k[7] == item["reason"]) then
						isdupe = true
					end
				end

			end
			if nodupes or (not isdupe) then
				local level, _, r, g, b
				pct = tonumber(pct) --make sure its not a string
				if not pct and AucAdvanced.Modules.Util.PriceLevel then
					local valueper
					if value and value > 0 then
						valueper = value/item[Const.COUNT]
					end
					if buyorbid == "bid" then
						level, _, r, g, b = AucAdvanced.Modules.Util.PriceLevel.CalcLevel(item[Const.LINK], item[Const.COUNT], item[Const.PRICE], item[Const.PRICE], valueper)
					else
						level, _, r, g, b = AucAdvanced.Modules.Util.PriceLevel.CalcLevel(item[Const.LINK], item[Const.COUNT], item[Const.PRICE], item[Const.BUYOUT], valueper)
					end
					if not r or not b or not g then
					--print("price level failure in searchUI")
					--print(r,g,b, item[Const.LINK], item[Const.COUNT], item[Const.PRICE], item[Const.BUYOUT], valueper)
					r,g,b = 1,1,1
					end
					local total = #private.sheetData+1
					private.sheetStyle[total] = {}
					private.sheetStyle[total][2] = {["textColor"] = {r, g, b}}
					--private.sheetStyle[total][1] = {["rowColor"] = {r, g, b, 0, 0.2, "Horizontal"}} --allow row coloring, needs config options
					level = level or 0
					pct = floor(level)
				end
				item["pct"] = pct
				item["cost"] = cost
				local count = item[Const.COUNT] or 1
				local min = item[Const.MINBID] or 0
				local cur = item[Const.CURBID] or 0
				local buy = item[Const.BUYOUT] or 0
				local price = item[Const.PRICE] or 0
				if not skipresults then
					tinsert(private.sheetData, {
						item[Const.LINK],
						item["pct"],
						item["profit"],
						count,
						buy,
						price,
						item["reason"],
						item[Const.SELLER],
						private.tleft[item[Const.TLEFT]],
						buy/count,
						price/count,
						min,
						cur,
						min/count,
						cur/count
					})
				end
				return true, item["profit"], value
			end
		elseif cost > maxprice and enablemax then
			return false, "Price higher than maxprice"
		else
			return false, "Balance lower than reserve"
		end
	end
	return false, value
end

local PerformSearch = function()
	if gui.tabs.active then
		gui:ContractFrame(gui.tabs.active)
	end
	gui:ClearFocus()
	--Perform the search.  We're not using API.QueryImage() because we need it to be a coroutine
	local image = AucAdvanced.Scan.GetImageCopy()
	local imagesize = #image
	local speed = lib.GetSetting("processpriority") or 50
	speed = (speed / 100)^2.5
	local processingTime = speed * 0.1 + 0.02
	local GetTime = GetTime
	local nextPause = GetTime() + processingTime

	local searcher, searcherName = private.FindSearcher()
	if not searcher then
		print("No valid Searches selected")
		return
	end
	gui.frame.progressbar.text:SetText("AucAdv SearchUI: Searching |cffffcc19"..gui.config.selectedTab)
	gui.frame.progressbar:Show()

	--clear the results table
	private.removeall()
	local repaintSheet = false
	local nextRepaint = 0	-- can do it immediately

	private.isSearching = true
	AucAdvanced.SendProcessorMessage("searchbegin", searcherName)
	lib.NotifyCallbacks("search", "begin", searcherName)
	for i, data in ipairs(image) do
		if GetTime() > nextPause then
			gui.frame.progressbar:SetValue((i/imagesize)*1000)

			coroutine.yield()

			nextPause = GetTime() + processingTime
			if private.SearchCancel then
				private.SearchCancel = nil
				break
			end
			if repaintSheet and GetTime()>=nextRepaint then
				local b=GetTime()
				private.repaintSheet()
				repaintSheet = false
				local e=GetTime()
				nextRepaint = e + ((e-b)*10)  -- only let repainting consume 10% of our total CPU
			end
		end
		if lib.SearchItem(searcher.name, data, true) then
			repaintSheet = true
		end
	end

	private.repaintSheet()

	private.isSearching = false
	empty(SettingCache)
	gui.frame.progressbar:Hide()
	AucAdvanced.SendProcessorMessage("searchcomplete", searcherName)
	lib.NotifyCallbacks("search", "complete", searcherName)
end

function lib.IsSearching()
	return private.isSearching
end

function lib.PerformSearch(searcher)
	if (not coSearch) or (coroutine.status(coSearch) == "dead") then
		coSearch = coroutine.create(PerformSearch)
		local status, result = coroutine.resume(coSearch, searcher)
		if not status and result then
            error("Error in search coroutine: "..result.."\n\n{{{Coroutine Stack:}}}\n"..debugstack(coSearch));
		end
	else
		print("coroutine already running: "..coroutine.status(coSearch))
	end
end

function private.OnUpdate(self, elapsed)
	if coSearch then
		if coroutine.status(coSearch) == "suspended" then
			local status, result = coroutine.resume(coSearch)
			if not status and result then
				error("Error in search coroutine: "..result.."\n\n{{{Coroutine Stack:}}}\n"..debugstack(coSearch));
			end
		elseif coroutine.status(coSearch) == "dead" then
			coSearch = nil
		end
	end
	if flagResourcesUpdateRequired then
		-- Update Faction resources following Auctionhouse open or close (to handle Neutral AH)
		-- Delayed until OnUpdate handler to give GetFaction time to update its own internal settings
		flagResourcesUpdateRequired = false
		private.UpdateFactionResources()
	end
	if flagScanStats then
		flagScanStats = false
		lib.NotifyCallbacks("postscanupdate")
	end
end

private.updater = CreateFrame("Frame", nil, UIParent)
private.updater:SetScript("OnUpdate", private.OnUpdate)

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-SearchUI/SearchMain.lua $", "$Rev: 4640 $")
