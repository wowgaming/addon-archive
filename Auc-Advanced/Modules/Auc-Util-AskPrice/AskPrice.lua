--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: AskPrice.lua 4432 2009-08-29 14:55:35Z dinesh $
	URL: http://auctioneeraddon.com/

	Auctioneer AskPrice created by Mikezter and merged into
	Auctioneer by MentalPower. Swarm response functionallity added by Kandoko.

	Functions responsible for AskPrice's operation.

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
if not AucAdvanced then return end

local libType, libName = "Util", "AskPrice"
local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end
local print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill,_TRANS = AucAdvanced.GetModuleLocals()

private.whisperList = {}
private.sentRequest = {}
private.requestQueue = {}
private.sentAskPriceAd = {}
private.timeToWaitForPrices = 2
private.timeToWaitForResponse = 5
private.playerName = UnitName("player")
local AskPriceSentMessages = {}

function lib.Processor(callbackType, ...)
	if (callbackType == "config") then
		private.SetupConfigGui(...)
	end
end

function lib.OnLoad(addon)
	private.frame = CreateFrame("Frame")

	private.frame:RegisterEvent("CHAT_MSG_RAID_LEADER")
	private.frame:RegisterEvent("CHAT_MSG_IGNORED")
	private.frame:RegisterEvent("CHAT_MSG_WHISPER")
	private.frame:RegisterEvent("CHAT_MSG_OFFICER")
	private.frame:RegisterEvent("CHAT_MSG_PARTY")
	private.frame:RegisterEvent("CHAT_MSG_GUILD")
	private.frame:RegisterEvent("CHAT_MSG_RAID")

	private.frame:RegisterEvent("CHAT_MSG_ADDON")

	private.frame:SetScript("OnEvent", private.onEvent)
	private.frame:SetScript("OnUpdate", private.onUpdate)

	AucAdvanced.Const.PLAYERLANGUAGE = GetDefaultLanguage("player")

	Stubby.RegisterFunctionHook("ChatFrame_OnEvent", -200, private.onEventHook)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", function(self,event,...)
		local message = select(1,...) or arg1
		if (AskPriceSentMessages[message] and not private.getOption('util.askprice.whispers')) then
			AskPriceSentMessages[message] = nil
			return true
		end
	end)

	--Setup Configator defaults
	for config, value in pairs(private.defaults) do
		AucAdvanced.Settings.SetDefault(config, value)
	end
end

--[[ Local functions ]]--
--This function now runs even if AskPrice is disabled so that we don't leave stranded queries in the queue
function private.onUpdate(frame, secondsSinceLastUpdate)
	--Check the request queue for timeouts (We've finished waiting for other clients to send prices)
	for request, details in pairs(private.requestQueue) do
		if ((GetTime() - details.timer) >= private.timeToWaitForPrices) then
			if (details.querySeenBy == private.playerName) then --If we were the one who claimed the original query, then respond, else destroy the request.
				private.sendRequest(request, details)
			end
			private.requestQueue[request] = nil
		end
	end

	--Check the sent queue for timeouts (We've finished waiting the asker to ignore us)
	for request, details in pairs(private.sentRequest) do
		if ((GetTime() - details.timer) >= private.timeToWaitForResponse) then
			private.sentRequest[request] = nil
		end
	end
end

function private.onEvent(frame, event, ...)
	--Nothing to do if AskPrice is disabled
	if (not private.getOption('util.askprice.activated')) then
		return
	end

	if (event == "CHAT_MSG_ADDON") then
		return private.addOnEvent(...)

	elseif (event == "CHAT_MSG_IGNORED") then
		return private.beingIgnored(...)

	else
		return private.chatEvent(event, ...)
	end
end

function private.chatEvent(event, text, player)
	local channel
	if (event == "CHAT_MSG_RAID") or (event == "CHAT_MSG_PARTY") or (event == "CHAT_MSG_RAID_LEADER") then
		channel = "RAID"
	end

	if (event == "CHAT_MSG_GUILD") or (event == "CHAT_MSG_OFFICER") then
		channel = "GUILD"
	end

	if (event == "CHAT_MSG_WHISPER") then
		channel = "WHISPER"
	end

	if (not (
		text:find("|Hitem:", 1, true)
		and
		(
			text:sub(1, 1) == private.getOption('util.askprice.trigger')
			or
			private.isSmartWordsRequest(text:lower())
		)
	)) then
		return
	end

	local items = private.getItems(text)
	if (channel == "GUILD") or (channel == "RAID") then
		for i = 1, #items, 2 do
			local count = items[i]
			local link = items[i+1]

			private.sendAddOnMessage(channel, "QUERY", link, count, player, channel)
		end

	elseif (channel == "WHISPER") then
		for i = 1, #items, 2 do
			local count = items[i]
			local link = items[i+1]

			private.sendResponse(link, count, player, 1, private.getData(link))
		end
	end
end

function private.sendRequest(request, details)
	local link = details.itemLink
	local count = details.stackCount
	local player = details.sourcePlayer
	local totalPrice = details.totalPrice
	local vendorPrice = details.vendorPrice
	local answerCount = details.answerCount
	local totalSeenCount = details.totalSeenCount

	--Format pricing data
	totalPrice = math.floor(totalPrice/totalSeenCount)

	--Reset the timer and move the request over to the sent queue.
	details.timer = GetTime()
	private.sentRequest[request] = details

	--Send the response
	return private.sendResponse(link, count, player, answerCount, totalSeenCount, totalPrice, vendorPrice)
end
--recreate the simple coin value function from EH TT. Askprice is pretty much the only module that needs to whisper non-color coin values
--look into adding this into nTipHelper
local function coins(money)
	money = math.floor(tonumber(money) or 0)
	local g = math.floor(money / 10000)
	local s = math.floor(money % 10000 / 100)
	local c = money % 100
	local gsc = ""
	if (g > 0) then
		gsc = gsc .. g .. "g "
	end
	if (s > 0) then
		gsc = gsc .. s .. "s "
	end
	if (c > 0) then
		gsc = gsc .. c .. "c "
	end
	return gsc
end
function private.sendResponse(link, count, player, answerCount, totalSeenCount, totalPrice, vendorPrice)
	local marketPrice = totalPrice

	--If the stack size is grater than one, add the unit price to the message
	local strMarketOne
	if (count > 1) then
		strMarketOne = (_TRANS('ASKP_Interface_Each')):format(coins(marketPrice))--(%s each)
	else
		strMarketOne = ""
	end

	if (totalSeenCount > 0) then
		local averageSeenCount = math.floor(totalSeenCount/answerCount + 0.5)
		private.sendWhisper(
			(_TRANS('ASKP_Interface_SeenAverageByAuctioneer') ):format( --%s: Seen an average of %d times at auction by %d people using Auctioneer
				link,
				averageSeenCount,
				answerCount),
			player
		)
		private.sendWhisper(
			(_TRANS('ASKP_Interface_MarketValue') ):format(--%sMarket Value: %s%s
				"    ",
				coins(marketPrice * count),
				strMarketOne),
			player
		)
	else
		private.sendWhisper(
			(_TRANS('ASKP_Interface_NeverSeenByAuctioneer') ):format(--%s: Never seen at %s by Auctioneer
				link,
				AucAdvanced.GetFaction()
			),
			player
		)
	end

	--Send out vendor info if we have it
	if --[[private.getOption('util.askprice.vendor') and ]](vendorPrice and (vendorPrice > 0)) then --Vendor pricing option is still disabled

		local strVendOne
		--Again if the stack Size is greater than one, add the unit price to the message
		if (count > 1) then
			strVendOne = (_TRANS('ASKP_Interface_Each') ):format(coins(vendorPrice))--(%s each)
		else
			strVendOne = ""
		end

		private.sendWhisper(
			(_TRANS('ASKP_Interface_SellVendor') ):format(--%sSell to vendor for: %s%s
				"    ",
				coins(vendorPrice * count),
				strVendOne
			),
			player
		)
	end

	if (not (count > 1)) and (private.getOption('util.askprice.ad')) then
		if (not private.sentAskPriceAd[player]) then --If the player in question has been sent the ad message in this session, don't spam them again.
			private.sentAskPriceAd[player] = true
			private.sendWhisper((_TRANS('ASKP_Interface_GetStackPrices') ):format(private.getOption('util.askprice.trigger')), player)--Get stack prices with %sCount[ItemLink] (Count = stacksize)
		end
	end
end

function private.onEventHook() --%ToDo% Change the prototype once Blizzard changes their functions to use parameters instead of globals.
	if (event == "CHAT_MSG_WHISPER_INFORM") then
		if (private.whisperList[arg1]) then
			private.whisperList[arg1] = nil
		end
	end
end

function private.getData(itemLink)
	local marketValue, seenCount = AucAdvanced.API.GetMarketValue(itemLink, AucAdvanced.GetFaction())
	local vendorPrice = GetSellValue and GetSellValue(itemLink)

	return seenCount or 0, marketValue or 0, vendorPrice or 0
end

--Many thanks to the guys at irc://chat.freenode.net/wowi-lounge for their help in creating this function
local itemList = {}
function private.getItems(str)
	for i = #itemList, 1, -1 do
		itemList[i] = nil
	end

	for number, color, item, name in str:gmatch("(%d*)%s*|c(%x+)|Hitem:([^|]+)|h%[(.-)%]|h|r") do
		table.insert(itemList, tonumber(number) or 1)
		table.insert(itemList, "|c"..color.."|Hitem:"..item.."|h["..name.."]|h|r")
	end
	return itemList
end

function private.sendWhisper(message, player)
	private.whisperList[message] = true
	if not private.getOption('util.askprice.whispers') then
		AskPriceSentMessages[message] = true
	end
	ChatThrottleLib:SendChatMessage("ALERT", "AucAdvAskPrice", message, "WHISPER", AucAdvanced.Const.PLAYERLANGUAGE, player)
end

function private.sendAddOnMessage(channel, ...)
	local message = string.join(";", ...)
	ChatThrottleLib:SendAddonMessage("NORMAL", "AucAdvAskPrice", message, channel)
end

function private.addOnEvent(prefix, message, sourceChannel, sourcePlayer)
	if (not (prefix == "AucAdvAskPrice")) then
		return
	end

	--Decode the message
	local requestType, link, count, player, channel, totalPrice, totalSeenCount, vendorPrice, answerCount, ignoreList = string.split(";", message)
	local request
	if (link and count and player and channel) then
		request = link..count..player..channel
	end

	if (sourceChannel == "PARTY") then --Adjust the source if its party.
		sourceChannel = "RAID"
	end

	if (requestType == "QUERY") then --AskPrice query was received by someone and is requesting prices for that query.
		private.requestQueue[request] = private.requestQueue[request] or {
			timer = GetTime(),
			querySeenBy = sourcePlayer,

			itemLink = link,
			stackCount = tonumber(count),
			sourcePlayer = player,
			sourceChannel = channel,

			totalPrice = 0,
			answerCount = 0,
			totalSeenCount = 0,
		}

		if not private.requestQueue[request].sentPrice then --Only respond if we have not already done so
			local seenCount, marketValue, vendorPrice = private.getData(link)
			private.sendAddOnMessage(sourceChannel, "PRICE", link, count, player, channel, marketValue, seenCount, vendorPrice)
			private.requestQueue[request].sentPrice = true
		end

	elseif (requestType == "PRICE") then --AskPrice users are responding to the query. We only listen to these if we were the first to send out the QUERY event that pertains to this PRICE event (see above)
		local request = private.requestQueue[request]
		if (request and (request.querySeenBy == private.playerName)) then
			if not (request.priceProviders and request.priceProviders:find(sourcePlayer)) then
				--Better stat average formula for each response: total = total + (price * seen); count = count + seen; average = total/count
				local count = request.totalSeenCount + totalSeenCount
				local total = request.totalPrice + (totalPrice * totalSeenCount)

				request.totalPrice = total
				request.totalSeenCount = count
				request.vendorPrice = request.vendorPrice or tonumber(vendorPrice)
				request.answerCount = request.answerCount + 1
			end
		end

		if request then --Record providers, even if we are not going to answer the query
			if not request.priceProviders then
				request.priceProviders = sourcePlayer
			else
				request.priceProviders = request.priceProviders..":"..sourcePlayer
			end
		end

	elseif (requestType == "WFAIL") and (not ignoreList:find(private.playerName)) then --Whisper failed (Announcer is being ignored)
		private.requestQueue[request] = {
			timer = GetTime(),
			ignoreList = ignoreList,

			itemLink = link,
			stackCount = count,
			sourcePlayer = player,
			sourceChannel = channel,

			totalPrice = totalPrice,
			vendorPrice = vendorPrice,
			answerCount = answerCount,
			totalSeenCount = totalSeenCount
		}

		private.sendAddOnMessage(sourceChannel, "MFAIL", link, count, player, channel, totalPrice, totalSeenCount, vendorPrice, answerCount, ignoreList)

	elseif (requestType == "MFAIL") then --New type for v2, means "My Fail", if the current user receives one for a request in the queue, its either killed if it was not us that sent it, or answered if it was.
		if (sourcePlayer == private.playerName) and (private.requestQueue[request]) then
			private.sendRequest(request, private.requestQueue[request])
			private.requestQueue[request] = nil

		else
			private.requestQueue[request] = nil
		end

	elseif (requestType == "MAINR") then --General type of request (Version, login, etc)
		local subRequest = link

		if (subRequest == "version") then
			private.sendAddOnMessage(sourceChannel, "MAINR", "version:", private.GetVersion()) --Extended for v2 comms (See GetVersion() definition)

		elseif (subRequest == "version:") then
			--Responses to the above "version" request, currently ignored

		elseif (subRequest == "login") or (subRequest == "logout") or (subRequest == "online") then
			--Used in v1 comms, currently ignored
		end
	end
end

function private.beingIgnored(sourcePlayer)
	--Check the sent queue for occurances of the ignored player
	for request, details in pairs(private.sentRequest) do
		if (details.sourcePlayer == sourcePlayer) then
			local link, count, player, channel = details.itemLink, details.stackCount, details.sourcePlayer, details.sourceChannel
			local totalPrice, totalSeenCount, vendorPrice, answerCount, ignoreList = details.totalPrice, details.totalSeenCount, details.vendorPrice, details.answerCount, details.ignoreList

			if ignoreList then --Either add our list to the existent ignoreList or make our name the first entry
				ignoreList = ignoreList..":"..private.playerName

			else
				ignoreList = private.playerName
			end

			private.sendAddOnMessage(sourceChannel, "WFAIL", link, count, player, channel, totalPrice, totalSeenCount, vendorPrice, answerCount, ignoreList) --Expanded in v2 comms to include the ignoreList
		end
	end
end

--This function changed after AskPrice revision 2825 to include AucAdvanced's revision number in adition to AskPrice's
function private.GetVersion()
	return tonumber(("$Revision: 4432 $"):match("(%d+)")), (AucAdvanced.GetCurrentRevision()) --We just want the first return from GetCurrentRevision()
end

--This function is used to check if the received request (which should be lowercased before the function is called) is a valid SmartWords request
function private.isSmartWordsRequest(text)
	if private.getOption('util.askprice.smart') then
		if private.getOption('util.askprice.smartOr') == 1 then
			return text:find(private.getOption('util.askprice.word1'):lower(), 1, true)
				or text:find(private.getOption('util.askprice.word2'):lower(), 1, true)
		else
			return text:find(private.getOption('util.askprice.word1'):lower(), 1, true)
				and text:find(private.getOption('util.askprice.word2'):lower(), 1, true)
		end
	end
end

private.SlashHandler = {}

--This is the function that will be called by the slash handler when
--/askprice send is issued.
function private.SlashHandler.send(queryString)
	local parseError = false
	if queryString then
		local player, itemLinks = strsplit(" ", queryString, 2)
		print(player, itemLinks)

		--Error out if we have a target, but no potential itemLinks
		if itemLinks then
			local items = private.getItems(itemLinks)
			--Error out if we dont get any items back
			if #items == 0 then parseError = true end

			for i = 1, #items, 2 do
				local count = items[i]
				local link = items[i+1]

				private.sendResponse(link, count, player, 1, private.getData(link))
			end
		else
			parseError = true
		end
	else
			parseError = true
	end

	if parseError then
		print("The correct syntax is {{/asprice send Player <#>[Item Link]}}, where {{<#>}} is the stack size (optional) and {{Player}} is the person you wish to send to.")
	end
end

--This function handles parsing of the /askprice commands
function private.slashcommands(commandstring)
	if commandstring then
		local command, remains = strsplit(" ",commandstring, 2)
		if command then
			command = command:lower()
			if private.SlashHandler[command] then
				private.SlashHandler[command](remains)
			end
		end
	end
end

--Add the slash command
SlashCmdList['AUC_UTIL_ASKPRICE_SEND'] = private.slashcommands
_G['SLASH_AUC_UTIL_ASKPRICE_SEND1'] = '/askprice'

--[[ Configator Section ]]--
private.defaults = {
	["util.askprice.activated"]    = true,
	["util.askprice.ad"]           = true,
	["util.askprice.smart"]        = true,
	["util.askprice.trigger"]      = "?",
	["util.askprice.vendor"]       = false,
	["util.askprice.whispers"]     = true,
	["util.askprice.word1"]        = "what",
	["util.askprice.word2"]        = "worth",
	["util.askprice.smartOr"]      = 0, --1/0 instead of true/false due to limitations in the Configator API
}

function private.getOption(option)
	return AucAdvanced.Settings.GetSetting(option)
end

function private.SetupConfigGui(gui)
	-- The defaults for the following settings are set in the lib.OnLoad function
	local id = gui:AddTab(libName, libType.." Modules")
	gui:MakeScrollable(id)

	gui:AddHelp(id, "what askprice",
		_TRANS('ASKP_Help_WhatAskPrice'), --"What is AskPrice and what does it do?"
		_TRANS('ASKP_Help_WhatAskPriceAnswer')) --"AskPrice is a module that allows other players to obtain the values of items by sending special messages to various channels, or by sending those messages to you directly, via a whisper."

	gui:AddControl(id, "Header",     0,    libName.._TRANS('ASKP_Interface_Options')) --" options"
	gui:AddControl(id, "Checkbox",   0, 1, "util.askprice.activated", _TRANS('ASKP_Interface_Activated')) --"Respond to queries for item market values sent via chat"
	gui:AddTip(id, _TRANS('ASKP_HelpTooltip_Activated')) --"This checkbox will enable or disable the module."

	gui:AddHelp(id, "what triggers",
		_TRANS('ASKP_Help_WhatTriggers'), --"What are these triggers, and how are they used?"
		_TRANS('ASKP_Help_WhatTriggersAnswer')) --"The triggers control how someone needs to ask you for the price. \nThe Custom Smartwords allow Auctioneer to respond to natural language queries, while the Trigger Character allows for querying stack sizes \n\nCustom smartwords default respond to \'what is [item link] worth?\' \nTrigger character defaults respond to \'? (stack size) [item link]\'"
	
	
	gui:AddControl(id, "Subhead",    0,    _TRANS('ASKP_Interface_SimpleTrigger')) --"Simple trigger:"
	gui:AddControl(id, "Text",       0, 1, "util.askprice.trigger", _TRANS('ASKP_Interface_TriggerCharacter')) --"Askprice Trigger character"
	gui:AddTip(id, _TRANS('ASKP_HelpTooltip_TriggerCharacter')) --"The trigger character allows for simple querying of a price."

	gui:AddControl(id, "Subhead",    0,    _TRANS('ASKP_Interface_SmartWords')) --SmartWords:
	gui:AddControl(id, "Checkbox",   0, 1, "util.askprice.smart", _TRANS('ASKP_Interface_EnableSmartWords')) --"Enable SmartWords checking"
	gui:AddTip(id, _TRANS('ASKP_HelpTooltip_SmartWords')) --"Toggling this will enable responses to the SmartWords."
	local last = gui:GetLast(id) -- Get the current position so we can return here for the second column
	gui:AddControl(id, "Text",       0, 1, "util.askprice.word1", _TRANS('ASKP_Interface_SmartWordOne')) --"Askprice Custom SmartWord #1"
	gui:AddTip(id, _TRANS('ASKP_HelpTooltip_SmartWordOne')) --"The SmartWords allow for natural language queries."
	gui:SetLast(id, last) -- Return to the saved position
	gui:AddControl(id, "Text",       0.5, 1, "util.askprice.word2", _TRANS('ASKP_Interface_SmartWordTwo')) --"Askprice Custom SmartWord #2"
	gui:AddTip(id, _TRANS('ASKP_HelpTooltip_SmartWordOne')) --"The SmartWords allow for natural language queries."
	gui:AddControl(id, "Selectbox",  0, 1, {
		{1, "Either"},
		{0, "Both"}
	}, "util.askprice.smartOr", "Either or both SmartWords") --1/0 instead of true/false due to limitations in the Configator API
	gui:AddTip(id, _TRANS('ASKP_HelpTooltip_EitherBoth')) --"Both SmartWords are required to be present for just one or the other in order for it to trigger a query."

	gui:AddControl(id, "Subhead",    0,    _TRANS('ASKP_Interface_Miscellaneous')) --"Miscellaneous:")
	gui:AddControl(id, "Checkbox",   0, 1, "util.askprice.ad", _TRANS('ASKP_Interface_TutorialMessage')) --"Enable sending of tutorial message."
	gui:AddTip(id, _TRANS('ASKP_HelpTooltip_TutorialMessage')) --"If enabled, this will send players who ask for prices a message telling them how to use the trigger character in conjunction with a stack size parameter."
	gui:AddControl(id, "Checkbox",   0, 1, "util.askprice.whispers", _TRANS('ASKP_Interface_Whisper')) --"Show outgoing whispers from Askprice"
	gui:AddTip(id, _TRANS('ASKP_HelpTooltip_Whisper')) --"Shows (enabled) or hides (disabled) outgoing whispers from Askprice."

end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-AskPrice/AskPrice.lua $", "$Rev: 4432 $")
