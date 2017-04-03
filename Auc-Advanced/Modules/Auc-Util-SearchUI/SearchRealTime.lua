--[[
	Auctioneer - Search UI - Realtime module
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: SearchRealTime.lua 4721 2010-04-29 00:09:19Z Nechckn $
	URL: http://auctioneeraddon.com/

	This Auctioneer module allows the user to search the current Browse tab
	results in real time, without requiring scans or an up-to-date snapshot.
	It also provides top- and bottom-scanning capabilities (i.e. first and
	last AH pages) to find deals on items about to expire, or recently added
	to the AH.

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

local lib, parent, private = AucSearchUI.NewSearcher("RealTime")
if not lib then return end
local print,decode,_,_,replicate,empty,_,_,_,debugPrint,fill = AucAdvanced.GetModuleLocals()
local get,set,default,Const = AucSearchUI.GetSearchLocals()
lib.tabname = "realtime"

local Const = AucAdvanced.Const
--default assumption is that we're not embedded.  This is checked later.
local embedded = false
local embedpath = "Interface\\AddOns\\"
private.IsScanning = false
private.count = 0
private.searchertable = {}
private.ItemTable = {}
private.interval = 20
private.offset = 0
private.topScan = false
private.IsRefresh = false

default("realtime.always", true)
default("realtime.reload.enable", true)
default("realtime.reload.interval", 20)
default("realtime.reload.topscan", false)
default("realtime.reload.manpause", 60)
default("realtime.maxprice", 10000000)
default("realtime.alert.chat", true)
default("realtime.alert.showwindow", true)
default("realtime.alert.sound", "DoorBell")
default("realtime.skipresults", false)

local SearchUIgui
function lib:MakeGuiConfig(gui)
	SearchUIgui = gui
	local id = gui:AddTab(lib.tabname, "Options")
	gui:MakeScrollable(id)

	gui:AddControl(id, "Header",      0,   "RealTime Search Options")

	gui:AddControl(id, "Subhead",       0,    "Scan Settings")
	gui:AddControl(id, "Checkbox",      0, 1, "realtime.always", "Search while browsing")
	gui:AddTip(id, "Enables searching for results when browsing or scanning")
	gui:AddControl(id, "Checkbox",      0, 1, "realtime.reload.enable", "Enable automatic last page refreshing")
	gui:AddTip(id, "Refreshes the last page, looking for new bargains. (Bottomscanning)")
	gui:AddControl(id, "Slider",        0, 2, "realtime.reload.interval", 6, 60, 1, "Reload interval: %s seconds")
	gui:AddControl(id, "Slider",        0, 2, "realtime.reload.manpause", 10, 120, 1, "Pause after a manual search: %s seconds")
	gui:AddControl(id, "Checkbox",      0, 2, "realtime.reload.topscan", "Refresh first page as well")
	gui:AddTip(id, "Refreshes the first page, looking for bids about to expire")

	gui:AddControl(id, "Subhead",       0,    "Alert Settings")
	gui:AddControl(id, "Checkbox",      0, 1, "realtime.alert.chat", "Show alert in chat window")
	gui:AddControl(id, "Checkbox",      0, 1, "realtime.alert.showwindow", "Show SearchUI window")
	gui:AddTip(id, "When a bargain is found, opens the SearchUI window to facilitate buying the bargain")
	gui:AddControl(id, "Selectbox",     0, 1, {
		{"none", "None (do not play a sound)"},
		{"LEVELUP", "Level Up"},
		{"AuctionWindowOpen", "AuctionHouse Open"},
		{"AuctionWindowClose", "AuctionHouse Close"},
		{"RaidWarning", "Raid Warning"},
		{"DoorBell", "DoorBell (BottomScan-style)"},
	}, "realtime.alert.sound", "Pick the sound to play")
	gui:AddTip(id, "The selected sound will play whenever a bargain is found")
	gui:AddControl(id, "Subhead",       0,    "Power-user setting: One-Click Buying")
	gui:AddControl(id, "Checkbox",      0, 1, "realtime.skipresults", "Skip results and go straight to purchase confirmation !Power-user setting!")
	gui:AddTip(id, "One-Click Buying: RTS will queue the purchase instead of listing the item in SearchUI")
	gui:AddControl(id, "Subhead",          0,    "Searchers to use")
	for name, searcher in pairs(AucSearchUI.Searchers) do
		if searcher and searcher.Search then
			gui:AddControl(id, "Checkbox", 0, 1, "realtime.use."..name, name)
			gui:AddTip(id, "Include "..name.." when searching realtime")
		end
	end
end

--lib.RefreshPage()
--role: refreshes the page based on settings, and updates private.lastPage, private.interval, and private.manualSearchPause
function lib.RefreshPage()
	private.interval = get("realtime.reload.interval")

	--Check to see if the AH is open for business
	if not (AuctionFrame and AuctionFrame:IsVisible()) then
		private.interval = 1 --Try again in one second
		return
	end

	--Check to see if we can send a query
	if not (CanSendAuctionQuery()) then
		private.interval = 1 --try again in one second
		return
	end

	--Check to see if AucAdv is already scanning
	if AucAdvanced.Scan.IsScanning() or AucAdvanced.Scan.IsPaused() then
		private.timer = 0
		private.interval = get("realtime.reload.manpause")
		return
	end

	--Get the current number of auctions and pages
	local pageCount, totalCount = GetNumAuctionItems("list")
	local totalPages = math.floor((totalCount-1)/NUM_AUCTION_ITEMS_PER_PAGE)
	if (totalPages < 0) then
		totalPages = 0
	end

	--set the AH page count to a signal value, if this is our first time
	if (not private.pageCount) then
		private.pageCount = -1
	end

	--Decide whether we are just starting to use the Realtime queries (as opposed to piggybacking), which means we are going to do a few quick scans to get to the last page
	if (totalPages ~= private.pageCount) then
		private.pageCount = totalPages
		private.interval = 3 --cut short the delay, we want to get to the last page quickly
	end

	--every 5 pages, go back one just to doublecheck that nothing got by us
	private.offset = (private.offset + 1) % 5
	local offset = 0
	if private.offset == 0 then
		offset = 1
	end

	local page = private.pageCount - offset or 0
	if get("realtime.reload.topscan") then
		private.topScan = not private.topScan --flip the variable, so we alternate first and last pages
	else
		private.topScan = false --make sure we don't topScan if we don't want to
	end
	if private.topScan then
		page = 0
	end
	AuctionFrameBrowse.page = page
	SortAuctionClearSort("list")
	private.IsRefresh = true
	QueryAuctionItems("", "", "", nil, nil, nil, page, nil, nil)
end

--private.OnUpdate()
--checks whether it's time to refresh the page
function private.OnUpdate(me, elapsed)
	if (not private.lastTry) then
		private.lastTry = 0
	end
	if not private.interval then
		private.interval = 6
	end
	if not private.timer then
		private.timer = 0
	else
		private.timer = private.timer + elapsed

		--Check whether enough time has elapsed to do anything
		if private.timer < private.interval then
			return
		end
		private.timer = private.timer - private.interval
		private.lastTry = private.lastTry - private.interval
	end

	--if we've gotten to this point, it's time to refresh the page
	if (private.IsScanning) and (get("realtime.reload.enable")) then
		lib.RefreshPage()
	end
end

--lib.FinishedPage()
--called by AucAdv via SearchUI main when a page is done
--role: starts the page scan
function lib.FinishedPage()
	--if we're not scanning, we don't need to do anything
	--if we don't have searching while browsing on, then don't do anything if we're not actively refreshing
	local always = get("realtime.always")
	if not private.IsRefresh then
		private.timer = 0
		private.interval = get("realtime.reload.manpause")
	end
	if (not private.IsScanning)
			or ((not always) and (not private.IsRefresh))
			or ((not always) and (AucAdvanced.Scan.IsScanning())) then
			private.timer = 0
			private.interval = get("realtime.reload.manpause")
			private.IsRefresh = false
		return
	else
		private.IsRefresh = false
	end
	--scan the current page
	lib.ScanPage()
end

--[[
	lib.ScanPage()
	Called: from lib.FinishedPage, when AA is done with a page
	Function: Scans current AH page for bargains
	Note: will return if current page has >50 auctions on it
]]
function lib.ScanPage()
	if not private.IsScanning then return end
	private.IsRefresh = false
	local batch, totalCount
	batch, totalCount = GetNumAuctionItems("list")
	if batch > 50 then
		-- we don't want to freeze the computer by trying to process a getall, so return
		return
	end

	--this is a new page, so no alert sound has been played for it yet
	private.playedsound = false
	--store the current pagecount
	private.pageCount = math.floor((totalCount-1)/NUM_AUCTION_ITEMS_PER_PAGE)

	--Put all the searchers that are activated into our local table, so that the get()s are only called every page, not every auction
	for name, searcher in pairs(AucSearchUI.Searchers) do
		if get("realtime.use."..name) then
			table.insert(private.searchertable, searcher)
		end
	end
	for i = 1, batch do
		local link = GetAuctionItemLink("list", i)
		if link then
			local name, _, count, quality, canUse, level, minBid, minInc, buyout, curBid, isHigh, owner = GetAuctionItemInfo("list", i)
			local _, _, quality, iLevel, _, iType, iSubType, stack, iEquip = GetItemInfo(link)
			iEquip = Const.EquipEncode[iEquip]
			local timeleft = GetAuctionItemTimeLeft("list", i)
			local _, id, suffix, factor, enchant, seed = AucAdvanced.DecodeLink(link)
			owner = owner or ""
			count = count or 1

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

			-- put the data into a table laid out the same way as the AAdv Scandata, as that's what the searchers need
			private.ItemTable[Const.LINK]    = link
			private.ItemTable[Const.ILEVEL]  = iLevel
			private.ItemTable[Const.ITYPE]   = iType
			private.ItemTable[Const.ISUB]    = iSubType
			private.ItemTable[Const.IEQUIP]  = iEquip
			private.ItemTable[Const.PRICE]   = price
			private.ItemTable[Const.TLEFT]   = timeleft
			private.ItemTable[Const.NAME]    = name
			private.ItemTable[Const.COUNT]   = count
			private.ItemTable[Const.QUALITY] = quality
			private.ItemTable[Const.CANUSE]  = canUse
			private.ItemTable[Const.ULEVEL]  = level
			private.ItemTable[Const.MINBID]  = minBid
			private.ItemTable[Const.MININC]  = minInc
			private.ItemTable[Const.BUYOUT]  = buyout
			private.ItemTable[Const.CURBID]  = curBid
			private.ItemTable[Const.AMHIGH]  = isHigh
			private.ItemTable[Const.SELLER]  = owner
			private.ItemTable[Const.ITEMID]  = id
			private.ItemTable[Const.SUFFIX]  = suffix
			private.ItemTable[Const.FACTOR]  = factor
			private.ItemTable[Const.ENCHANT]  = enchant
			private.ItemTable[Const.SEED]  = seed

			local skipresults = get("realtime.skipresults")
			for i, searcher in pairs(private.searchertable) do
				if AucSearchUI.SearchItem(searcher.name, private.ItemTable, false, skipresults) then
					private.alert(private.ItemTable[Const.LINK], private.ItemTable["cost"], private.ItemTable["reason"])
					if skipresults then
						AucAdvanced.Buy.QueueBuy(private.ItemTable[Const.LINK],
							private.ItemTable[Const.SELLER],
							private.ItemTable[Const.COUNT],
							private.ItemTable[Const.MINBID],
							private.ItemTable[Const.BUYOUT],
							private.ItemTable["cost"],
							AucSearchUI.Private.cropreason(private.ItemTable["reason"]),
							true -- do not trigger a search if CoreBuy is unable to find this auction
							)
					else
						AucSearchUI.Private.repaintSheet()
					end
				end
			end
		end
		AucSearchUI.CleanTable(private.ItemTable)
	end
	AucSearchUI.CleanTable(private.searchertable)
end

--private.alert()
--alerts the user that a deal has been found,
--both by opening the searchUI panel and playing a sound
--(subject to options)
function private.alert(link, cost, reason)
	if get("realtime.alert.chat") then
		print("SearchUI: "..reason..": Found "..link.." for "..AucAdvanced.Coins(cost, true))
	end
	if get("realtime.alert.showwindow") and (not get("realtime.skipresults")) then
		AucSearchUI.Show()
		if SearchUIgui then
			if SearchUIgui.tabs.active then
				SearchUIgui:ContractFrame(SearchUIgui.tabs.active)
			end
			SearchUIgui:ClearFocus()
		end
	end
	local SoundPath = get("realtime.alert.sound")
	if SoundPath and (SoundPath ~= "none") and not private.playedsound then
		private.playedsound = true
		if SoundPath == "DoorBell" then
			SoundPath = embedpath.."Auc-Util-SearchUI\\DoorBell.mp3"
			PlaySound("GAMEHIGHLIGHTFRIENDLYUNIT")
			PlaySoundFile(SoundPath)
		else
			PlaySound(SoundPath)
		end
	end
end

--[[
	private.ButtonPressed()
	Called: when the control button gets pushed
	function: switches on/off btmscanning
]]
function private.ButtonPressed(self, button)
	if button == "LeftButton" then
		if private.IsScanning then
			private.IsScanning = false
			private.button.control.tex:SetTexCoord(0, .5, 0, 1)
		else
			private.IsScanning = true
			private.interval = 1 --we're starting the scan, so no need to wait
			private.button.control.tex:SetTexCoord(0.5, 1, 0, 1)
		end
	elseif button == "RightButton" then
		AucSearchUI.Toggle()
	end
end

--[[
	lib.HookAH()
	Called when the AH opens for the first time
	function: to create the control button on the AH, to the left of the regular ScanButtons
]]
function lib.HookAH()
	private.button = CreateFrame("Frame", nil, AuctionFrameBrowse)
	private.button:SetPoint("TOPRIGHT", AuctionFrameBrowse, "TOPLEFT", 310, -15)
	private.button:SetWidth(26)
	private.button:SetHeight(18)

	private.button.control = CreateFrame("Button", nil, private.button, "OptionsButtonTemplate")
	private.button.control:SetPoint("TOPLEFT", private.button, "TOPLEFT", 0, 0)
	private.button.control:SetWidth(22)
	private.button.control:SetHeight(18)
	private.button.control:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	private.button.control:SetScript("OnClick", private.ButtonPressed)
	private.button.control:SetScript("OnUpdate", private.OnUpdate)
	private.button.control.tex = private.button.control:CreateTexture(nil, "OVERLAY")
	private.button.control.tex:SetPoint("TOPLEFT", private.button.control, "TOPLEFT", 4, -2)
	private.button.control.tex:SetPoint("BOTTOMRIGHT", private.button.control, "BOTTOMRIGHT", -4, 2)
	private.button.control:SetScript("OnEnter", function()
			GameTooltip:SetOwner(private.button.control, "ANCHOR_TOPRIGHT")
			GameTooltip:SetText("Click to start Realtime Search\nRightclick to open SearchUI")
		end)
	private.button.control:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)

	--Figure out whether we're embedded or not.  If we are, adjust the path to the texture accordingly.
	for _, module in ipairs(AucAdvanced.EmbeddedModules) do
		if module == "Auc-Util-SearchUI"  then
			embedpath = "Interface\\AddOns\\Auc-Advanced\\Modules\\"
		end
	end
	private.button.control.tex:SetTexture(embedpath.."Auc-Util-SearchUI\\Textures\\SearchButton")
	private.button.control.tex:SetTexCoord(0,.5, 0, 1)
	private.button.control.tex:SetVertexColor(1, 0.9, 0.1)
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-SearchUI/SearchRealTime.lua $", "$Rev: 4721 $")
