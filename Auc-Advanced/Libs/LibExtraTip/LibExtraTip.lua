--[[-
LibExtraTip

LibExtraTip is a library of API functions for manipulating additional information into GameTooltips by either adding information to the bottom of existing tooltips (embedded mode) or by adding information to an extra "attached" tooltip construct which is placed to the bottom of the existing tooltip.

Copyright (C) 2008, by the respective below authors.

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

@author Matt Richard (Tem)
@author Ken Allan <ken@norganna.org>
@libname LibExtraTip
@version 1.1
--]]

local MAJOR,MINOR,REVISION = "LibExtraTip", 1, "$Revision: 227 $"

-- A string unique to this version to prevent frame name conflicts.
local LIBSTRING = MAJOR.."_"..MINOR.."_"..REVISION
local lib = LibStub:NewLibrary(MAJOR.."-"..MINOR, REVISION)
if not lib then return end

-- Call function to deactivate any outdated version of the library.
-- (calls the OLD version of this function, NOT the one defined in this
-- file's scope)
if lib.Deactivate then lib:Deactivate() end

-- Forward definition of a few locals that get defined at the bottom of
-- the file.
local tooltipMethodPrehooks
local tooltipMethodPosthooks
local ExtraTipClass

--[[ The following events are enabled by default unless disabled in the
	callback options "enabled" table all other events are default disabled.
	Note that this only applies to events that will lead to calling ProcessCallbacks,
	currently any method that fires OnTooltipSetItem, OnTooltipSetSpell or
	OnTooltipSetUnit
--]]
local defaultEnable = {
	SetAuctionItem = true,
	SetAuctionSellItem = true,
	SetBagItem = true,
	SetBuybackItem = true,
	SetGuildBankItem = true,
	SetInboxItem = true,
	SetInventoryItem = true,
	SetLootItem = true,
	SetLootRollItem = true,
	SetMerchantItem = true,
	SetQuestItem = true,
	SetQuestLogItem = true,
	SetSendMailItem = true,
	SetTradePlayerItem = true,
	SetTradeTargetItem = true,
	SetTradeSkillItem = true,
	SetHyperlink = true,
	SetHyperlinkAndCount = true, -- Creating a tooltip via lib:SetHyperlinkAndCount()
}

-- Money Icon setup
local iconpath = "Interface\\MoneyFrame\\UI-"
local goldicon = "%d|T"..iconpath.."GoldIcon:0|t"
local silvericon = "%s|T"..iconpath.."SilverIcon:0|t"
local coppericon = "%s|T"..iconpath.."CopperIcon:0|t"

-- Function that calls all the interested tooltips
local function ProcessCallbacks(reg, tiptype, tooltip, ...)
	local self = lib
	if not reg then return end

	local event = reg.additional.event or "Unknown"
	local default = defaultEnable[event]

	if self.sortedCallbacks and #self.sortedCallbacks > 0 then
		for i,options in ipairs(self.sortedCallbacks) do
			if options.type == tiptype and options.callback and type(options.callback) == "function" then
				local enable = default
				if options.enable and options.enable[event] ~= nil then
					enable = options.enable[event]
				end
				if enable then
					options.callback(tooltip, ...)
				end
			end
		end
	end
end

-- Function that gets run when an item is set on a registered tooltip.
local function OnTooltipSetItem(tooltip)
	local self = lib
	local reg = self.tooltipRegistry[tooltip]
	assert(reg, "Unknown tooltip passed to LibExtraTip:OnTooltipSetItem()")

	if self.sortedCallbacks and #self.sortedCallbacks > 0 then
		tooltip:Show()

		local _,item = tooltip:GetItem()
		-- For generated tooltips
		if not item and reg.item then item = reg.item end

		if item and not reg.hasItem then
			local name,link,quality,ilvl,minlvl,itype,isubtype,stack,equiploc,texture = GetItemInfo(item)
			if link then
				name = name or "unknown" -- WotLK bug
				reg.hasItem = true
				local extraTip = self:GetFreeExtraTipObject()
				reg.extraTip = extraTip
				extraTip:Attach(tooltip)
				local r,g,b = GetItemQualityColor(quality)
				extraTip:AddLine(name,r,g,b)

				local quantity = reg.quantity

				reg.additional.item = item
				reg.additional.quantity = quantity or 1
				reg.additional.name = name
				reg.additional.link = link
				reg.additional.quality = quality
				reg.additional.itemLevel = ilvl
				reg.additional.minLevel = minlvl
				reg.additional.itemType = itype
				reg.additional.itemSubtype = isubtype
				reg.additional.stackSize = stack
				reg.additional.equipLocation = equiploc
				reg.additional.texture = texture

				ProcessCallbacks(reg, "item", tooltip, item,quantity,name,link,quality,ilvl,minlvl,itype,isubtype,stack,equiploc,texture)
				tooltip:Show()
				if reg.extraTipUsed then reg.extraTip:Show() end
			end
		end
	end
end

-- Function that gets run when a spell is set on a registered tooltip.
local function OnTooltipSetSpell(tooltip)
	local self = lib
	local reg = self.tooltipRegistry[tooltip]
	assert(reg, "Unknown tooltip passed to LibExtraTip:OnTooltipSetSpell()")

	if self.sortedCallbacks and #self.sortedCallbacks > 0 then
		tooltip:Show()
		local name, rank = tooltip:GetSpell()
		local link = reg.additional.link

		if name and not reg.hasItem then
			reg.hasItem = true
			local extraTip = self:GetFreeExtraTipObject()
			reg.extraTip = extraTip
			extraTip:Attach(tooltip)
			extraTip:AddLine(name, 1,0.8,0)

			ProcessCallbacks(reg, "spell", tooltip, link, name,rank)
			tooltip:Show()
			if reg.extraTipUsed then reg.extraTip:Show() end
		end
	end
end

-- Function that gets run when a unit is set on a registered tooltip.
local function OnTooltipSetUnit(tooltip)
	local self = lib
	local reg = self.tooltipRegistry[tooltip]
	assert(reg, "Unknown tooltip passed to LibExtraTip:OnTooltipSetUnit()")

	if self.sortedCallbacks and #self.sortedCallbacks > 0 then
		tooltip:Show()
		local name, unitId = tooltip:GetUnit()

		if name and not reg.hasItem then
			reg.hasItem = true
			local extraTip = self:GetFreeExtraTipObject()
			reg.extraTip = extraTip
			extraTip:Attach(tooltip)
			extraTip:AddLine(name, 0.8,0.8,0.8)

			ProcessCallbacks(reg, "unit", tooltip, name,unitId)
			tooltip:Show()
			if reg.extraTipUsed then reg.extraTip:Show() end
		end
	end
end

-- Function that gets run when a registered tooltip's item is cleared.
local function OnTooltipCleared(tooltip)
	local self = lib
	local reg = self.tooltipRegistry[tooltip]
	assert(reg, "Unknown tooltip passed to LibExtraTip:OnTooltipCleared()")
	if reg.ignoreOnCleared then return end
	tooltip:SetFrameLevel(1)

	if reg.extraTip then
		table.insert(self.extraTippool, reg.extraTip)
		reg.extraTip:Hide()
		reg.extraTip:Release()
		reg.extraTip:SetHeight(0)
		reg.extraTip = nil
	end
	reg.extraTipUsed = nil
	reg.minWidth = 0
	reg.quantity = nil
	reg.hasItem = nil
	reg.item = nil
	table.wipe(reg.additional)
end

-- Function that gets run when a registered tooltip's size changes.
local function OnSizeChanged(tooltip,w,h)
	local self = lib
	local reg = self.tooltipRegistry[tooltip]
	assert(reg, "Unknown tooltip passed to LibExtraTip:OnSizeChanged()")

	local extraTip = reg.extraTip
	if extraTip then
		extraTip:NeedsRefresh(true)
	end
end

function lib:GetFreeExtraTipObject()
	if not self.extraTippool then self.extraTippool = {} end
	return table.remove(self.extraTippool) or ExtraTipClass:new()
end

--[[ hookStore:
	@since version 1.1
	(see below for hookStore version)
	stores control information for method and script hooks on tooltips
	lib.hookStore[tooltip][method] = <control>
	<control> = {prehook, posthook}
	<control> is an upvalue to our installed hookstub: insert new values to change the hook, or wipe it to deactivate

	if we are updating, keep the old hookStore table IF it has the right version, so that we can reuse the hook stubs
--]]
local HOOKSTORE_VERSION = "A"
if not lib.hookStore or lib.hookStore.version ~= HOOKSTORE_VERSION then
	lib.hookStore = {version = HOOKSTORE_VERSION}
end

-- Called to install/modify a pre-/post-hook on the given tooltip's method
local function hook(tip, method, prehook, posthook)
	if not lib.hookStore[tip] then lib.hookStore[tip] = {} end
	local control
	-- check for existing hook
	control = lib.hookStore[tip][method]
	if control then
		control[1] = prehook or control[1] or false --(avoid nil values by substituting false instead)
		control[2] = posthook or control[2] or false
		return
	end
	-- prepare upvalues
	local orig = tip[method]
	if not orig then
		-- there should be an original method. for now silently bail out. todo: insert debug tracking here so we can identify defunct methods
		return
	end
	control = {prehook or false, posthook or false}
	lib.hookStore[tip][method] = control
	-- install hook stub
	local stub = function(...)
		local h
		-- prehook
		h = control[1]
		if h then h(...) end
		-- original hook
		local a,b,c,d = orig(...)
		-- posthook
		h = control[2]
		if h then h(...) end
		-- return values from original
		return a,b,c,d
	end
	tip[method] = stub
	--[[
	Note: neither the stub hook nor the original function should be called directly after our hook is installed,
	because the behaviour of any other third-party hooks to the same method would then be undefined
	(i.e. they might get called or they might not...)
	--]]
end

-- Called to deactivate our stub hook for the given tooltip's method
-- The stub is left in place: we assume we are undergoing a version upgrade, and that the stubs will be reused
--[[ not used in this version (left in place in case needed for future changes)
local function unhook(tip,method)
	wipe(lib.hookStore[tip][method])
end
--]]

-- Called to install/modify a pre-hook on the given tooltip's event
-- Currently we do not need any posthooks on scripts
local function hookscript(tip, script, prehook)
	if not lib.hookStore[tip] then lib.hookStore[tip] = {} end
	local control
	-- check for existing hook
	control = lib.hookStore[tip][script]
	if control then
		control[1] = prehook or control[1]
		return
	end
	-- prepare upvalues
	local orig = tip:GetScript(script)
	control = {prehook}
	lib.hookStore[tip][script] = control
	-- install hook stub
	local stub = function(...)
		local h
		-- prehook
		h = control[1]
		if h then h(...) end
		-- original hook
		if orig then orig(...) end
	end
	tip:SetScript(script, stub)
end

-- Called to deactivate all our pre-hooks on the given tooltip's event
--local function unhookscript(tip,script)
-- not used in this version

--[[-
	Adds the provided tooltip to the list of tooltips to monitor for items.
	@param tooltip GameTooltip object
	@return true if tooltip is registered
	@since 1.0
]]
function lib:RegisterTooltip(tooltip)
	if not tooltip or type(tooltip) ~= "table" or type(tooltip.GetObjectType) ~= "function" or tooltip:GetObjectType() ~= "GameTooltip" then return end

	if not self.tooltipRegistry then
		self.tooltipRegistry = {}
		self:GenerateTooltipMethodTable()
	end

	if not self.tooltipRegistry[tooltip] then
		local reg = {}
		self.tooltipRegistry[tooltip] = reg
		reg.additional = {}

		hookscript(tooltip,"OnTooltipSetItem",OnTooltipSetItem)
		hookscript(tooltip,"OnTooltipSetUnit",OnTooltipSetUnit)
		hookscript(tooltip,"OnTooltipSetSpell",OnTooltipSetSpell)
		hookscript(tooltip,"OnTooltipCleared",OnTooltipCleared)
		hookscript(tooltip,"OnSizeChanged",OnSizeChanged)

		for k,v in pairs(tooltipMethodPrehooks) do
			hook(tooltip,k,v)
		end
		for k,v in pairs(tooltipMethodPosthooks) do
			hook(tooltip,k,nil,v)
		end
		return true
	end
end

--[[-
	Checks to see if the tooltip has been registered with LibExtraTip
	@param tooltip GameTooltip object
	@return true if tooltip is registered
	@since 1.0
]]
function lib:IsRegistered(tooltip)
	if not self.tooltipRegistry or not self.tooltipRegistry[tooltip] then
		return
	end
	return true
end

local sortFunc

--[[-
	Adds a callback to be informed of any registered tooltip's activity.
	Callbacks are passed the following parameters (in order):
		* tooltip: The tooltip object being shown (GameTooltip object)
		* item: The item being shown (in {@wowwiki:ItemLink} format)
		* quantity: The quantity of the item being shown (may be nil when the quantity is unavailable)
		* return values from {@wowwiki:API_GetItemInfo|GetItemInfo} (in order)
	@param options a table containing the callback type and callback function
	@param priority the priority of the callback (optional, default 200)
	@since 1.0
]]
function lib:AddCallback(options,priority)
-- Lower priority gets called before higher priority.  Default is 200.
	if not options then return end
	local otype = type(options)
	if otype == "function" then
		options = { type = "item", callback = options }
	elseif otype ~= "table" then return end

	if not sortFunc then
		local callbacks = self.callbacks
		if not callbacks then
			callbacks = {}
			self.callbacks = callbacks
			self.sortedCallbacks = {}
		end
		sortFunc = function(a,b)
			return callbacks[a] < callbacks[b]
		end
	end

	self.callbacks[options] = priority or 200
	table.insert(self.sortedCallbacks,options)
	table.sort(self.sortedCallbacks,sortFunc)
end

--[[-
	Removes the given callback from the list of callbacks.
	@param callback the callback to remove from notifications
	@return true if successfully removed
	@since 1.0
]]
function lib:RemoveCallback(callback)
	if not (callback and self.callbacks) then return end
	if not self.callbacks[callback] then
		-- backward compatibility for old 'function' style AddCallback and RemoveCallback
		for options, priority in pairs(self.callbacks) do
			if options.callback == callback then
				callback = options
				break
			end
		end
		if not self.callbacks[callback] then return end
	end
	self.callbacks[callback] = nil
	for index,options in ipairs(self.sortedCallbacks) do
		if options == callback then
			table.remove(self.sortedCallbacks, index)
			return true
		end
	end
end

--[[-
	Sets the default embed mode of the library (default false)
	A false embedMode causes AddLine, AddDoubleLine and AddMoneyLine to add lines to the attached tooltip rather than embed added lines directly in the item tooltip.
	This setting only takes effect when embed mode is not specified on individual AddLine, AddDoubleLine and AddMoneyLine commands.
	@param flag boolean flag if true embeds by default
	@since 1.0
]]
function lib:SetEmbedMode(flag)
	self.embedMode = flag and true or false
end

--[[-
	Adds a line to a registered tooltip.
	@param tooltip GameTooltip object
	@param text the contents of the tooltip line
	@param r red component of the tooltip line color (optional)
	@param g green component of the tooltip line color (optional)
	@param b blue component of the tooltip line color (optional)
	@param embed override the lib's embedMode setting (optional)
	@see SetEmbedMode
	@since 1.0
]]
function lib:AddLine(tooltip,text,r,g,b,embed)
	local reg = self.tooltipRegistry[tooltip]
	assert(reg, "Unknown tooltip passed to LibExtraTip:AddLine()")

	if r and not g then embed = r r = nil end
	embed = embed ~= nil and embed or self.embedMode
	if not embed then
		reg.extraTip:AddLine(text,r,g,b)
		reg.extraTipUsed = true
	else
		tooltip:AddLine(text,r,g,b)
	end
end

--[[-
	Adds a two-columned line to the tooltip.
	@param tooltip GameTooltip object
	@param textLeft the left column's contents
	@param textRight the left column's contents
	@param r red component of the tooltip line color (optional)
	@param g green component of the tooltip line color (optional)
	@param b blue component of the tooltip line color (optional)
	@param embed override the lib's embedMode setting (optional)
	@see SetEmbedMode
	@since 1.0
]]
function lib:AddDoubleLine(tooltip,textLeft,textRight,lr,lg,lb,rr,rg,rb,embed)
	local reg = self.tooltipRegistry[tooltip]
	assert(reg, "Unknown tooltip passed to LibExtraTip:AddDoubleLine()")

	if lr and not lg and not rr then embed = lr lr = nil end
	if lr and lg and rr and not rg then embed = rr rr = nil end
	embed = embed ~= nil and embed or self.embedMode
	if not embed then
		reg.extraTip:AddDoubleLine(textLeft,textRight,lr,lg,lb,rr,rg,rb)
		reg.extraTipUsed = true
	else
		tooltip:AddDoubleLine(textLeft,textRight,lr,lg,lb,rr,rg,rb)
	end
end

--[[-
	Creates a string representation of the money value passed using embedded textures for the icons
	@param money the money value to be converted in copper
	@param concise when false (default), the representation of 1g is "1g 00s 00c" when true, it is simply "1g" (optional)
	@since 1.0
]]
function lib:GetMoneyText(money, concise)
	local g = math.floor(money / 10000)
	local s = math.floor(money % 10000 / 100)
	local c = math.floor(money % 100)

	local moneyText = ""

	local sep, fmt = "", "%d"
	if g > 0 then
		moneyText = goldicon:format(g)
		sep, fmt = " ", "%02d"
	end

	if s > 0 or (money >= 10000 and (concise and c > 0) or not concise) then
		moneyText = moneyText..sep..silvericon:format(fmt):format(s)
		sep, fmt = " ", "%02d"
	end

	if not concise or c > 0 or money < 100 then
		moneyText = moneyText..sep..coppericon:format(fmt):format(c)
	end

	return moneyText
end

--[[-
	Adds a line with text in the left column and a money frame in the right.
	The money parameter is given in copper coins (i.e. 1g 27s 5c would be 12705)
	@param tooltip GameTooltip object
	@param text the contents of the tooltip line
	@param money the money value to be displayed (in copper)
	@param r red component of the tooltip line color (optional)
	@param g green component of the tooltip line color (optional)
	@param b blue component of the tooltip line color (optional)
	@param embed override the lib's embedMode setting (optional)
	@param concise specify if concise money mode is to be used (optional)
	@see SetEmbedMode
	@since 1.0
]]
function lib:AddMoneyLine(tooltip,text,money,r,g,b,embed,concise)
	local reg = self.tooltipRegistry[tooltip]
	assert(reg, "Unknown tooltip passed to LibExtraTip:AddMoneyLine()")

	if r and not g then embed = r r = nil end
	embed = embed ~= nil and embed or self.embedMode

	local moneyText = self:GetMoneyText(money, concise)

	if not embed then
		reg.extraTip:AddDoubleLine(text,moneyText,r,g,b,1,1,1)
		reg.extraTipUsed = true
	else
		tooltip:AddDoubleLine(text,moneyText,lr,lg,lb,1,1,1)
	end
end

--[[-
	Sets a tooltip to hyperlink with specified quantity
	@param tooltip GameTooltip object
	@param link hyperlink to display in the tooltip
	@param quantity quantity of the item to display
	@param detail additional detail items to set for the callbacks
	@return nil
	@since 1.0
]]
function lib:SetHyperlinkAndCount(tooltip, link, quantity, detail)
	local reg = self.tooltipRegistry[tooltip]
	assert(reg, "Unknown tooltip passed to LibExtraTip:SetHyperlinkAndCount()")

	OnTooltipCleared(tooltip)
	reg.quantity = quantity
	reg.item = link
	reg.additional.event = "SetHyperlinkAndCount"
	reg.additional.eventLink = link
	if detail then
		for k,v in pairs(detail) do
			reg.additional[k] = v
		end
	end
	reg.ignoreOnCleared = true
	reg.ignoreSetHyperlink = true
	tooltip:SetHyperlink(link)
	reg.ignoreSetHyperlink = nil
	reg.ignoreOnCleared = nil
end

--[[-
	Get the additional information from a tooltip event.
	Often additional event details are available about the situation under which the tooltip was invoked, such as:
		* The call that triggered the tooltip.
		* The slot/inventory/index of the item in question.
		* Whether the item is usable or not.
		* Auction price information.
		* Ownership information.
		* Any data provided by the Get*Info() functions.
	If you require access to this information for the current tooltip, call this function to retrieve it.
	@param tooltip GameTooltip object
	@return table containing the additional information
	@since 1.0
]]
function lib:GetTooltipAdditional(tooltip)
	local reg = self.tooltipRegistry[tooltip]
	assert(reg, "Unknown tooltip passed to LibExtraTip:GetTooltipAdditional()")

	if reg then
		return reg.additional
	end
	return nil
end



--[[ INTERNAL USE ONLY
	Deactivates this version of the library, rendering it inert.
	Needed to run before an upgrade of the library takes place.
	@since 1.0
]]
function lib:Deactivate()
	-- deactivate all hook stubs
	for tooltip, tiptable in pairs(lib.hookStore) do
		if tooltip ~= "version" then -- skip over the version indicator
			for method, control in pairs(tiptable) do
				wipe(control) -- disable the hook stub by removing all hooks from the control table
			end
		end
	end
end

--[[ INTERNAL USE ONLY
	Activates this version of the library.
	Configures this library for use by setting up its variables and reregistering any previously registered tooltips.
	@since 1.0
]]
function lib:Activate()
	if self.tooltipRegistry then
		local oldreg = self.tooltipRegistry
		self.tooltipRegistry = nil
		for tooltip in pairs(oldreg) do
			self:RegisterTooltip(tooltip)
		end
	end
end

-- Sets all the complex spell details
local function SetSpellDetail(reg, link)
	local name, rank, icon, cost, funnel, power, ctime, min, max = GetSpellInfo(link)
	reg.additional.name = name
	reg.additional.link = link
	reg.additional.rank = rank
	reg.additional.icon = icon
	reg.additional.cost = cost
	reg.additional.powerType = power
	reg.additional.isFunnel = funnel
	reg.additional.castTime = ctime
	reg.additional.minRange = min
	reg.additional.maxRange = max
end

--[[ INTERNAL USE ONLY
	Generates a tooltip method table.
	The tooltip method table supplies hooking information for the tooltip registration functions, including the methods to hook and a function to run that parses the hooked functions parameters.
	@since 1.0
	Addendum: generates 2 method tables, for prehooks and posthooks. Where the prehook sets a flag, a posthook must be installed to clear it. Specifically: reg.ignoreOnCleared
]]
function lib:GenerateTooltipMethodTable() -- Sets up hooks to give the quantity of the item
	local tooltipRegistry = self.tooltipRegistry

	tooltipMethodPrehooks = {

		-- Default enabled events

		SetAuctionItem = function(self,type,index)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			local _,_,q,_,cu,_ ,min,inc,bo,ba,hb,own = GetAuctionItemInfo(type,index)
			reg.quantity = q
			reg.additional.event = "SetAuctionItem"
			reg.additional.eventType = type
			reg.additional.eventIndex = index
			reg.additional.canUse = cu
			reg.additional.minBid = min
			reg.additional.minIncrement = inc
			reg.additional.buyoutPrice = bo
			reg.additional.bidAmount = ba
			reg.additional.highBidder = hb
			reg.additional.owner = own
		end,

		SetAuctionSellItem = function(self)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			local name,texture,quantity,quality,canUse,price = GetAuctionSellItemInfo()
			reg.quantity = quantity
			reg.additional.event = "SetAuctionSellItem"
			reg.additional.canUse = canUse
		end,

		SetBagItem = function(self,bag,slot)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			local _,q,l,_,r= GetContainerItemInfo(bag,slot)
			reg.quantity = q
			reg.additional.event = "SetBagItem"
			reg.additional.eventContainer = bag
			reg.additional.eventIndex = slot
			reg.additional.readable = r
			reg.additional.locked = l
		end,

		SetBuybackItem = function(self,index)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			local name,texture,price,quantity = GetBuybackItemInfo(index)
			reg.quantity = quantity
			reg.additional.event = "SetBuybackItem"
			reg.additional.eventIndex = index
		end,

		SetGuildBankItem = function(self,tab,index)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			local texture,quantity,locked = GetGuildBankItemInfo(tab,index)
			reg.quantity = quantity
			reg.additional.event = "SetGuildBankItem"
			reg.additional.eventContainer = tab
			reg.additional.eventIndex = index
			reg.additional.locked = locked
		end,

		SetInboxItem = function(self,index)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			local _,_,q,_,cu = GetInboxItem(index)
			reg.quantity = q
			reg.additional.event = "SetInboxItem"
			reg.additional.eventIndex = index
			reg.additional.canUse = cu
		end,

		SetInventoryItem = function(self,unit,index)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			local q = GetInventoryItemCount(unit,index)
			reg.quantity = q
			reg.additional.event = "SetInventoryItem"
			reg.additional.eventIndex = index
			reg.additional.eventUnit = unit
		end,

		SetLootItem = function(self,index)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			local _,_,q = GetLootSlotInfo(index)
			reg.quantity = q
			reg.additional.event = "SetLootItem"
			reg.additional.eventIndex = index
		end,

		SetLootRollItem = function(self,index)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			local texture, name, count, quality = GetLootRollItemInfo(index)
			reg.quantity = count
			reg.additional.event = "SetLootRollItem"
			reg.additional.eventIndex = index
		end,

		SetMerchantItem = function(self,index)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			local _,_,p,q,na,cu,ec = GetMerchantItemInfo(index)
			reg.quantity = q
			reg.additional.event = "SetLootItem"
			reg.additional.eventIndex = index
			reg.additional.price = p
			reg.additional.numAvailable = na
			reg.additional.canUse = cu
			reg.additional.extendedCost = ec
		end,

		SetQuestItem = function(self,type,index)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			local _,_,q,_,cu = GetQuestItemInfo(type,index)
			reg.quantity = q
			reg.additional.event = "SetQuestItem"
			reg.additional.eventType = type
			reg.additional.eventIndex = index
			reg.additional.canUse = cu
		end,

		SetQuestLogItem = function(self,type,index)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			local _,q,cu
			if type == "choice" then
				_,_,q,_,cu = GetQuestLogChoiceInfo(index)
			else
				_,_,q,_,cu = GetQuestLogRewardInfo(index)
			end
			reg.quantity = q
			reg.additional.event = "SetQuestLogItem"
			reg.additional.eventType = type
			reg.additional.eventIndex = index
			reg.additional.canUse = cu
		end,

		SetSendMailItem = function(self,index)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			local name,texture,quantity = GetSendMailItem(index)
			reg.quantity = quantity
			reg.additional.event = "SetSendMailItem"
			reg.additional.eventIndex = index
		end,

		SetTradePlayerItem = function(self,index)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			local name, texture, quantity = GetTradePlayerItemInfo(index)
			reg.quantity = quantity
			reg.additional.event = "SetTradePlayerItem"
			reg.additional.eventIndex = index
		end,

		SetTradeTargetItem = function(self,index)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			local name, texture, quantity = GetTradeTargetItemInfo(index)
			reg.quantity = quantity
			reg.additional.event = "SetTradeTargetItem"
			reg.additional.eventIndex = index
		end,

		SetTradeSkillItem = function(self,index,reagentIndex)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			reg.additional.event = "SetTradeSkillItem"
			reg.additional.eventIndex = index
			reg.additional.eventReagentIndex = reagentIndex
			if reagentIndex then
				local _,_,q,rc = GetTradeSkillReagentInfo(index,reagentIndex)
				reg.quantity = q
				reg.additional.playerReagentCount = rc
			else
				local link = GetTradeSkillItemLink(index)
				reg.additional.link = link
				reg.result = item
				reg.quantity = GetTradeSkillNumMade(index)
				if (link:sub(0, 6) == "spell:") then
					SetSpellDetail(reg, link)
				end
			end
		end,

		SetHyperlink = function(self,link)
			local reg = tooltipRegistry[self]
			if reg.ignoreSetHyperlink then return end
			OnTooltipCleared(self)
			reg.ignoreOnCleared = true
			reg.additional.event = "SetHyperlink"
			reg.additional.eventLink = link
			reg.additional.link = link
		end,

		-- Default disabled events:

--		SetAction = function(self,actionid)
--			OnTooltipCleared(self)
--			local reg = tooltipRegistry[self]
--			reg.ignoreOnCleared = true
--			local t,id,sub = GetActionInfo(actionid)
--			reg.additional.event = "SetAction"
--			reg.additional.eventIndex = actionid
--			reg.additional.actionType = t
--			reg.additional.actionIndex = id
--			reg.additional.actionSubtype = subtype
--			if t == "item" then
--				reg.quantity = GetActionCount(actionid)
--			elseif t == "spell" then
--				if id and id > 0 then
--					local link = GetSpellLink(id, sub)
--					SetSpellDetail(reg, link)
--				end
--			end
--		end,

		SetAuctionCompareItem = function(self, type, index, offset)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			reg.additional.event = "SetAuctionCompareItem"
			reg.additional.eventType = type
			reg.additional.eventIndex = index
			reg.additional.eventOffset = offset
		end,

		SetCurrencyToken = function(self, index)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			reg.additional.event = "SetCurrencyToken"
			reg.additional.eventIndex = index
		end,

		SetMerchantCompareItem = function(self, index, offset)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			reg.additional.event = "SetMerchantCompareItem"
			reg.additional.eventIndex = index
			reg.additional.eventOffset = offset
		end,

		SetPetAction = function(self, index)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			reg.additional.event = "SetPetAction"
			reg.additional.eventIndex = index
		end,

		SetPlayerBuff = function(self, index)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			reg.additional.event = "SetPlayerBuff"
			reg.additional.eventIndex = index
		end,

		SetQuestLogRewardSpell = function(self)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			reg.additional.event = "SetQuestLogRewardSpell"
		end,

		SetQuestRewardSpell = function(self)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			reg.additional.event = "SetQuestRewardSpell"
		end,

		SetShapeshift = function(self, index)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			reg.additional.event = "SetShapeshift"
			reg.additional.eventIndex = index
		end,

		SetSpell = function(self,index,type)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			local link = GetSpellLink(index, type)
			if link then
				reg.additional.event = "SetSpell"
				reg.additional.eventIndex = index
				reg.additional.eventType = type
				SetSpellDetail(reg, link)
			end
		end,

		SetTalent = function(self, type, index)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			reg.additional.event = "SetTalent"
			reg.additional.eventIndex = index
		end,

		SetTracking = function(self, index)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			reg.additional.event = "SetTracking"
			reg.additional.eventIndex = index
		end,

		SetTrainerService = function(self, index)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			reg.additional.event = "SetTrainerService"
			reg.additional.eventIndex = index
		end,

		SetUnit = function(self, unit)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			reg.additional.event = "SetUnit"
			reg.additional.eventUnit= unit
		end,

		SetUnitAura = function(self, unit, index, filter)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			reg.additional.event = "SetUnitAura"
			reg.additional.eventUnit = unit
			reg.additional.eventIndex = index
			reg.additional.eventFilter = filter
		end,

		SetUnitBuff = function(self, unit, index, filter)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			reg.additional.event = "SetUnitBuff"
			reg.additional.eventUnit = unit
			reg.additional.eventIndex = index
			reg.additional.eventFilter = filter
		end,

		SetUnitDebuff = function(self, unit, index, filter)
			OnTooltipCleared(self)
			local reg = tooltipRegistry[self]
			reg.ignoreOnCleared = true
			reg.additional.event = "SetUnitDebuff"
			reg.additional.eventUnit = unit
			reg.additional.eventIndex = index
			reg.additional.eventFilter = filter
		end,
	}

	local function posthookClearIgnore(self)
		tooltipRegistry[self].ignoreOnCleared = nil
	end
	tooltipMethodPosthooks = {
		SetAuctionItem = posthookClearIgnore,
		SetAuctionSellItem = posthookClearIgnore,
		SetBagItem = posthookClearIgnore,
		SetBuybackItem = posthookClearIgnore,
		SetGuildBankItem = posthookClearIgnore,
		SetInboxItem = posthookClearIgnore,
		SetInventoryItem = posthookClearIgnore,
		SetLootItem = posthookClearIgnore,
		SetLootRollItem = posthookClearIgnore,
		SetMerchantItem = posthookClearIgnore,
		SetQuestItem = posthookClearIgnore,
		SetQuestLogItem = posthookClearIgnore,
		SetSendMailItem = posthookClearIgnore,
		SetTradePlayerItem = posthookClearIgnore,
		SetTradeTargetItem = posthookClearIgnore,
		SetTradeSkillItem = posthookClearIgnore,

		SetHyperlink = function(self)
			local reg = tooltipRegistry[self]
			if not reg.ignoreSetHyperlink then
				reg.ignoreOnCleared = nil
			end
		end,

--		SetAction = posthookClearIgnore,
		SetAuctionCompareItem = posthookClearIgnore,
		SetCurrencyToken = posthookClearIgnore,
		SetMerchantCompareItem = posthookClearIgnore,
		SetPetAction = posthookClearIgnore,
		SetPlayerBuff = posthookClearIgnore,
		SetQuestLogRewardSpell = posthookClearIgnore,
		SetQuestRewardSpell = posthookClearIgnore,
		SetShapeshift = posthookClearIgnore,
		SetSpell = posthookClearIgnore,
		SetTalent = posthookClearIgnore,
		SetTracking = posthookClearIgnore,
		SetTrainerService = posthookClearIgnore,
		SetUnit = posthookClearIgnore,
		SetUnitAura = posthookClearIgnore,
		SetUnitBuff = posthookClearIgnore,
		SetUnitDebuff = posthookClearIgnore,
	}

end

do -- ExtraTip "class" definition
	local methods = {"InitLines","Attach","Show","MatchSize","Release","NeedsRefresh","SetParentClamp"}
	local scripts = {"OnShow","OnHide","OnSizeChanged"}
	local numTips = 0
	local class = {}
	ExtraTipClass = class

	local addLine,addDoubleLine,show = GameTooltip.AddLine,GameTooltip.AddDoubleLine,GameTooltip.Show

	local line_mt = {
		__index = function(t,k)
			local v = getglobal(t.name..k)
			rawset(t,k,v)
			return v
		end
	}

	function class:new()
		local n = numTips + 1
		numTips = n
		local o = CreateFrame("GameTooltip",LIBSTRING.."Tooltip"..n,UIParent,"GameTooltipTemplate")

		for _,method in pairs(methods) do
			o[method] = self[method]
		end

		for _,script in pairs(scripts) do
			o:SetScript(script,self[script])
		end

		o.Left = setmetatable({name = o:GetName().."TextLeft"},line_mt)
		o.Right = setmetatable({name = o:GetName().."TextRight"},line_mt)
		return o
	end

	function class:Attach(tooltip)
		if self.parent then self:SetParentClamp(0) end
		self.parent = tooltip
		self:SetParent(tooltip)
		self:SetOwner(tooltip,"ANCHOR_NONE")
		self:SetPoint("TOP",tooltip,"BOTTOM")
	end

	function class:Release()
		if self.parent then self:SetParentClamp(0) end
		self.parent = nil
		self:SetParent(nil)
		self.minWidth = 0
	end

	function class:InitLines()
		local n = self:NumLines()
		local changedLines = self.changedLines
		if not changedLines or changedLines < n then
			for i = changedLines or 1,n do
				local left,right = self.Left[i],self.Right[i]
				local font
				if i == 1 then
					font = GameFontNormal
				else
					font = GameFontNormalSmall
				end

				local r,g,b,a

				r,g,b,a = left:GetTextColor()
				left:SetFontObject(font)
				left:SetTextColor(r,g,b,a)

				r,g,b,a = right:GetTextColor()
				right:SetFontObject(font)
				right:SetTextColor(r,g,b,a)
			end
			self.changedLines = n
		end
	end

	local function refresh(self)
		self:NeedsRefresh(false)
		self:MatchSize()
	end

	function class:NeedsRefresh(flag)
		if flag then
			self:SetScript("OnUpdate",refresh)
		else
			self:SetScript("OnUpdate",nil)
		end
	end

	function class:SetParentClamp(h)
		local p = self.parent
		if not p then return end
		local l,r,t,b = p:GetClampRectInsets()
		p:SetClampRectInsets(l,r,t,-h)
		self:NeedsRefresh(true)
	end

	function class:OnShow()
		self:SetParentClamp(self:GetHeight())
	end

	function class:OnSizeChanged(w,h)
		self:SetParentClamp(h)
	end

	function class:OnHide()
		self:SetParentClamp(0)
	end

	-- The right-side text is statically positioned to the right of the left-side text.
	-- As a result, manually changing the width of the tooltip causes the right-side text to not be in the right place.
	local function fixRight(tooltip, shift)
		local rights, rightname
		rights = tooltip.Right
		if not rights then
			rightname = tooltip:GetName().."TextRight"
		end
		for line = 1, tooltip:NumLines() do
			local right
			if rights then
				right = rights[line]
			else
				right = _G[rightname..line]
			end
			if right and right:IsVisible() then
				for index = 1, right:GetNumPoints() do
					local point, relativeTo, relativePoint, xofs, yofs = right:GetPoint(index)
					if xofs then
						right:SetPoint(point, relativeTo, relativePoint, xofs + shift, yofs)
					end
				end
			end
		end
	end

	function class:MatchSize()
		local p = self.parent
		local pw = p:GetWidth()
		local w = self:GetWidth()
		local d = pw - w
		if d > .005 then
			self.sizing = true
			self:SetWidth(pw)
			fixRight(self, d)
		elseif d < -.005 then
			self.sizing = true
			p:SetWidth(w)
			fixRight(p, -d)
		end
	end

	function class:Show()
		show(self)
		self:InitLines()
	end

end

-- More housekeeping upgrade stuff
lib:SetEmbedMode(lib.embedMode)
lib:Activate()


--[[ Test Code -----------------------------------------------------

local LT = LibStub("LibExtraTip-1")

LT:RegisterTooltip(GameTooltip)
LT:RegisterTooltip(ItemRefTooltip)

--[=[
LT:AddCallback(function(tip,item,quantity,name,link,quality,ilvl)
	LT:AddDoubleLine(tip,"Item Level:",ilvl,nil,nil,nil,1,1,1,0)
	LT:AddDoubleLine(tip,"Item Level:",ilvl,1,1,1,0)
	LT:AddDoubleLine(tip,"Item Level:",ilvl,0)
end,0)
--]=]
LT:AddCallback(function(tip,item,quantity,name,link,quality,ilvl)
	quantity = quantity or 1
	local price = GetSellValue(item)
	if price then
		LT:AddMoneyLine(tip,"Sell to vendor"..(quantity > 1 and "("..quantity..")" or "") .. ":",price*quantity,1)
	end
	LT:AddDoubleLine(tip,"Item Level:",ilvl,1)
end)

-- Test Code ]]-----------------------------------------------------

--[[ Debugging code
local f = {"AddDoubleLine", "AddFontStrings", "AddLine", "AddTexture", "AppendText", "ClearLines", "FadeOut", "GetAnchorType", "GetItem", "GetSpell", "GetOwner", "GetUnit", "IsUnit", "NumLines", "SetAction", "SetAuctionCompareItem", "SetAuctionItem", "SetAuctionSellItem", "SetBagItem", "SetBuybackItem", "SetCraftItem", "SetCraftSpell", "SetCurrencyToken", "SetGuildBankItem", "SetHyperlink", "SetInboxItem", "SetInventoryItem", "SetLootItem", "SetLootRollItem", "SetMerchantCompareItem", "SetMerchantItem", "SetMinimumWidth", "SetOwner", "SetPadding", "SetPetAction", "SetPlayerBuff", "SetQuestItem", "SetQuestLogItem", "SetQuestLogRewardSpell", "SetQuestRewardSpell", "SetSendMailItem", "SetShapeshift", "SetSpell", "SetTalent", "SetText", "SetTracking", "SetTradePlayerItem", "SetTradeSkillItem", "SetTradeTargetItem", "SetTrainerService", "SetUnit", "SetUnitAura", "SetUnitBuff", "SetUnitDebuff"}

for _,k in ipairs(f) do
	print("Hooking ", k)
	local h = GameTooltip[k]
	GameTooltip[k] = function(...)
	    local t
	    for i=2,5 do
			if not t then
				t = debugstack(i,1,0):gsub("\n[.\s\n]*", ""):gsub(": in function.*", "")
				if not t:match("Interface\\") then t = nil
				else t = t:gsub("Interface\\", "") end
			end
		end
		if t then
			print(t..": "..k.."(", ..., ")")
		elseif true then
			print("-------");
			print(debugstack());
			print("Call to: "..k.."(", ..., ")")
			print("-------");
		end
		return h(...)
	end
end
--]]
