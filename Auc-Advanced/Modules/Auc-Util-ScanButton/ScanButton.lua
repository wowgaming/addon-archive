--[[
	Auctioneer - Scan Button module
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: ScanButton.lua 4711 2010-04-11 00:26:20Z Nechckn $
	URL: http://auctioneeraddon.com/

	This is an Auctioneer module that adds a textual scan progress
	indicator to the Auction House UI.

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

local libType, libName = "Util", "ScanButton"
local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end
local print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill,_TRANS = AucAdvanced.GetModuleLocals()

function lib.Processor(callbackType, ...)
	if (callbackType == "scanprogress") then
		private.UpdateScanProgress(...)
	elseif (callbackType == "auctionui") then
		private.HookAH(...)
	elseif (callbackType == "config") then
		private.SetupConfigGui(...)
	elseif (callbackType == "configchanged") then
		private.ConfigChanged(...)
	end
end

function lib.OnLoad()
	AucAdvanced.Settings.SetDefault("util.scanbutton.enabled", true)
	AucAdvanced.Settings.SetDefault("util.scanbutton.message", true)
	AucAdvanced.Settings.SetDefault("util.scanbutton.getall", false)
end

-- /run local t = AucAdvanced.Modules.Util.ScanButton.Private.buttons.stop.tex t:SetPoint("TOPLEFT", t:GetParent() "TOPLEFT", 3,-3) t:SetPoint("BOTTOMRIGHT", t:GetParent(), "BOTTOMRIGHT", -3,3)
-- /run local t = AucAdvanced.Modules.Util.ScanButton.Private.buttons.stop.tex t:SetTexture("Interface\\AddOns\\Auc-Advanced\\Textures\\NavButtons") t:SetTexCoord(0.25, 0.5, 0, 1) t:SetVertexColor(1.0, 0.9, 0.1)

function private.HookAH()
	private.buttons = CreateFrame("Frame", nil, AuctionFrameBrowse)
	private.buttons:SetPoint("TOPLEFT", AuctionFrameBrowse, "TOPLEFT", 180,-15)
	private.buttons:SetWidth(22*4 + 4)
	private.buttons:SetHeight(18)
	private.buttons:SetScript("OnUpdate", private.OnUpdate)

	private.buttons.stop = CreateFrame("Button", nil, private.buttons, "OptionsButtonTemplate")
	private.buttons.stop:SetPoint("TOPLEFT", private.buttons, "TOPLEFT", 0,0)
	private.buttons.stop:SetWidth(22)
	private.buttons.stop:SetHeight(18)
	private.buttons.stop:SetScript("OnClick", private.stop)
	private.buttons.stop.tex = private.buttons.stop:CreateTexture(nil, "OVERLAY")
	private.buttons.stop.tex:SetPoint("TOPLEFT", private.buttons.stop, "TOPLEFT", 4,-2)
	private.buttons.stop.tex:SetPoint("BOTTOMRIGHT", private.buttons.stop, "BOTTOMRIGHT", -4,2)
	private.buttons.stop:SetScript("OnEnter", function()
			GameTooltip:SetOwner(private.buttons.stop, "ANCHOR_TOPRIGHT")
			GameTooltip:SetText("Click to stop the current scan")
		end)
	private.buttons.stop:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)
	private.buttons.stop.tex:SetTexture("Interface\\AddOns\\Auc-Advanced\\Textures\\NavButtons")
	private.buttons.stop.tex:SetTexCoord(0.25, 0.5, 0, 1)
	private.buttons.stop.tex:SetVertexColor(1.0, 0.9, 0.1)
	--displays remaining # of scans queued
	private.buttons.stop.count = private.buttons.stop:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	private.buttons.stop.count:ClearAllPoints()
	private.buttons.stop.count:SetPoint("RIGHT", private.buttons.stop, "LEFT", -5, 0)
	private.buttons.stop.count:SetTextColor(1, 0.8, 0)
	private.buttons.stop.count:SetText("0")
	private.buttons.stop.count:SetJustifyH("RIGHT")

	private.buttons.play = CreateFrame("Button", nil, private.buttons, "OptionsButtonTemplate")
	private.buttons.play:SetPoint("TOPLEFT", private.buttons.stop, "TOPRIGHT", 2,0)
	private.buttons.play:SetWidth(22)
	private.buttons.play:SetHeight(18)
	private.buttons.play:SetScript("OnClick", private.play)
	private.buttons.play.tex = private.buttons.play:CreateTexture(nil, "OVERLAY")
	private.buttons.play.tex:SetPoint("TOPLEFT", private.buttons.play, "TOPLEFT", 4,-2)
	private.buttons.play.tex:SetPoint("BOTTOMRIGHT", private.buttons.play, "BOTTOMRIGHT", -4,2)
	private.buttons.play:SetScript("OnEnter", function()
			GameTooltip:SetOwner(private.buttons.play, "ANCHOR_TOPRIGHT")
			GameTooltip:SetText("Click here to start/resume a scan of the auction house")
		end)
	private.buttons.play:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)
	private.buttons.play.tex:SetTexture("Interface\\AddOns\\Auc-Advanced\\Textures\\NavButtons")
	private.buttons.play.tex:SetTexCoord(0, 0.25, 0, 1)
	private.buttons.play.tex:SetVertexColor(1.0, 0.9, 0.1)

	private.buttons.pause = CreateFrame("Button", nil, private.buttons, "OptionsButtonTemplate")
	private.buttons.pause:SetPoint("TOPLEFT", private.buttons.play, "TOPRIGHT", 2,0)
	private.buttons.pause:SetWidth(22)
	private.buttons.pause:SetHeight(18)
	private.buttons.pause:SetScript("OnClick", private.pause)
	private.buttons.pause.tex = private.buttons.pause:CreateTexture(nil, "OVERLAY")
	private.buttons.pause.tex:SetPoint("TOPLEFT", private.buttons.pause, "TOPLEFT", 4,-2)
	private.buttons.pause.tex:SetPoint("BOTTOMRIGHT", private.buttons.pause, "BOTTOMRIGHT", -4,2)
	private.buttons.pause:SetScript("OnEnter", function()
			GameTooltip:SetOwner(private.buttons.pause, "ANCHOR_TOPRIGHT")
			GameTooltip:SetText("Click here to pause the current scan")
		end)
	private.buttons.pause:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)
	private.buttons.pause.tex:SetTexture("Interface\\AddOns\\Auc-Advanced\\Textures\\NavButtons")
	private.buttons.pause.tex:SetTexCoord(0.5, 0.75, 0, 1)
	private.buttons.pause.tex:SetVertexColor(1.0, 0.9, 0.1)

	private.buttons.getall = CreateFrame("Button", nil, private.buttons, "OptionsButtonTemplate")
	private.buttons.getall:SetPoint("TOPLEFT", private.buttons.pause, "TOPRIGHT", 2,0)
	private.buttons.getall:SetWidth(22)
	private.buttons.getall:SetHeight(18)
	private.buttons.getall:SetScript("OnClick", private.getall)
	private.buttons.getall.tex = private.buttons.getall:CreateTexture(nil, "OVERLAY")
	private.buttons.getall.tex:SetPoint("TOPLEFT", private.buttons.getall, "TOPLEFT", 4,-2)
	private.buttons.getall.tex:SetPoint("BOTTOMRIGHT", private.buttons.getall, "BOTTOMRIGHT", -4,2)
	private.buttons.getall:SetScript("OnEnter", function()
			GameTooltip:SetOwner(private.buttons.getall, "ANCHOR_TOPRIGHT")
			GameTooltip:SetText("Click here to do a fast getall scan of the auction house")
		end)
	private.buttons.getall:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)
	private.buttons.getall.tex:SetTexture("Interface\\AddOns\\Auc-Advanced\\Textures\\NavButtons")
	private.buttons.getall.tex:SetTexCoord(0.75, 1, 0, 1)
	private.buttons.getall.tex:SetVertexColor(0.3, 0.7, 1.0)

	local msg = CreateFrame("Frame", nil, UIParent)
	private.message = msg
	msg:Hide()
	msg:SetPoint("CENTER", "UIParent", "CENTER")
	msg:SetFrameStrata("DIALOG")
	msg:SetHeight(280)
	msg:SetWidth(500)
	msg:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 9, right = 9, top = 9, bottom = 9 }
	})
	msg:SetBackdropColor(0,0,0, 1)

	msg.Done = CreateFrame("Button", "", msg, "OptionsButtonTemplate")
	msg.Done:SetText("Done")
	msg.Done:SetPoint("BOTTOMRIGHT", msg, "BOTTOMRIGHT", -10, 10)
	msg.Done:SetScript("OnClick", function() msg:Hide() end)

	msg.Text = msg:CreateFontString(nil, "HIGH")
	msg.Text:SetPoint("TOPLEFT", msg, "TOPLEFT", 20, -20)
	msg.Text:SetPoint("BOTTOMRIGHT", msg.Done, "TOPRIGHT", -10, 10)
	msg.Text:SetFont("Fonts\\FRIZQT__.TTF",14)
	msg.Text:SetJustifyH("LEFT")
	msg.Text:SetJustifyV("TOP")
	msg.Text:SetShadowColor(0,0,0)
	msg.Text:SetShadowOffset(3,-3)

	msg.Text:SetText("|c00ff4400Important note about the GetAll scan option:|r\n\nUtilizing this feature can result in a very fast scan once every 15 minutes, however it requires a fast computer, low latency/ping times to the server, and for the servers to be running in optimum conditions. If any one of these three things are lagging, you may be disconnected from the server during the scan process.\n\nIf you wish to continue click the button again.\n\n|c00444444If you wish, you can disable this warning message via the Scan Button configuration settings.|r")

	private.UpdateScanProgress()
end

function private.UpdateScanProgress(state, _, _, _, _, _, _, scansQueued)
	local scanning, paused = false, false
	if AucAdvanced and AucAdvanced.Scan then
		scanning, paused = AucAdvanced.Scan.IsScanning(), AucAdvanced.Scan.IsPaused()
	end

	private.ConfigChanged()

	if scanning or paused then
		private.buttons.stop:Enable()
		private.buttons.stop.tex:SetVertexColor(1.0, 0.9, 0.1)
	else
		private.buttons.stop:Disable()
		private.buttons.stop.tex:SetVertexColor(0.3,0.3,0.3)
	end
	local pending = 0
	if scansQueued then
		pending = scansQueued
		if scanning then
			pending = pending + 1
		end
		if pending ~= private.lastpending then
			private.lastpending = pending
			private.buttons.stop.count:SetText(pending)
		end
	end
	--handle when we are on the last scan and no more queued when that scan completes set remaining to 0
	if scansQueued == 0 and state == false then
		private.buttons.stop.count:SetText(pending)
	end
	
	private.blink = nil
	if scanning and not paused then
		private.buttons.pause:Enable()
		private.buttons.pause.tex:SetVertexColor(1.0, 0.9, 0.1)
		private.buttons.play:Disable()
		private.buttons.play.tex:SetVertexColor(0.3,0.3,0.3)
	else
		private.buttons.play:Enable()
		private.buttons.play.tex:SetVertexColor(1.0, 0.9, 0.1)
		private.buttons.pause:Disable()
		private.buttons.pause.tex:SetVertexColor(0.3,0.3,0.3)
		if paused then
			private.blink = 1
		end
	end
end

local queue, queueFinished = {}, false
function private:OnUpdate(delay)
	if private.blink then
		private.timer = (private.timer or 0) - delay
		if private.timer < 0 then
			if not AucAdvanced.Scan.IsPaused() then
				private.UpdateScanProgress()
				return
			end
			if private.blink == 1 then
				private.buttons.pause.tex:SetVertexColor(0.1, 0.3, 1.0)
				private.blink = 2
			else
				private.buttons.pause.tex:SetVertexColor(0.3, 0.3, 0.3)
				private.blink = 1
			end
			private.timer = 0.75
		end
	end
	--Create the overlay filter buttons the (callbackType == "auctionui") is too early.
	if not AuctioneerFilterButton1 and AuctionFilterButton1 then
		private.CreateSecondaryFilterButtons()
		hooksecurefunc("AuctionFrameFilters_Update", private.AuctionFrameFilters_UpdateClasses)--used to respond to scrollframe
	end
	--if we still have filters pending process it, unless a scan is in progress or paused
	if #queue > 0 and not AucAdvanced.Scan.IsScanning() and not AucAdvanced.Scan.IsPaused() then
		private.play()
	end
	--Used to clear the selected filters/highlights AFTER the last queued scan has completed
	if queueFinished and not AucAdvanced.Scan.IsScanning() and not AucAdvanced.Scan.IsPaused() then
		queueFinished = false
		if AucAdvanced.Settings.GetSetting("util.scanbutton.message") then print("|CFFFFFF00 Last queued Auction Filter completed") end
		private.AuctionFrameFilters_ClearSelection()
		private.AuctionFrameFilters_ClearHighlight()
	end

	local canSend, canSendAll = CanSendAuctionQuery()
	if canSendAll and not AucAdvanced.Scan.IsScanning() and private.buttons.play:IsEnabled() then
		private.buttons.getall:Enable()
		if AucAdvanced.Settings.GetSetting("util.scanbutton.getall") or private.warned then
			private.buttons.getall.tex:SetVertexColor(1.0, 0.9, 0.1)
			private.buttons.getall.warn = nil
		else
			private.buttons.getall.tex:SetVertexColor(0.3, 0.7, 1.0)
			private.buttons.getall.warn = not private.warned
		end
	else
		private.buttons.getall:Disable()
		private.buttons.getall.tex:SetVertexColor(0.3,0.3,0.3)
	end
end

function private.SetupConfigGui(gui)
	-- The defaults for the following settings are set in the lib.OnLoad function
	local id = gui:AddTab(libName, libType.." Modules")
	gui:AddControl(id, "Header",     0,    libName.._TRANS('SBTN_Interface_Options')) --" Options"

	gui:AddHelp(id, "what scanbutton",
		_TRANS('SBTN_Help_WhatScanButton'), --"What are the scan buttons?
		_TRANS('SBTN_Help_WhatScanButtonAnswer')) --"The scan buttons are the Stop/Play/Pause buttons in the titlebar of the Auction House frame."

	gui:AddControl(id, "Checkbox",   0, 1, "util.scanbutton.enabled", _TRANS('SBTN_Interface_Enabled')) --"Show scan buttons in the Auction House"
	gui:AddTip(id, _TRANS('SBTN_HelpTooltip_Enabled')) --"Toggles the display of the Stop/Play/Pause/Fast Forward scan buttons in the title bar of the Auction House."

	gui:AddControl(id, "Checkbox",   0, 1, "util.scanbutton.message", _TRANS('SBTN_Interface_Message')) --"Show messages about which category selections have been queued"
	gui:AddTip(id, _TRANS('SBTN_HelpTooltip_Message')) --"Toggles the display of the starting search of filtered messages when using the ctr+click to select specific categories of the AH to scan."

	gui:AddControl(id, "Checkbox",   0, 1, "util.scanbutton.getall", _TRANS('SBTN_Interface_Getall')) --"Don't warn about GetAll scanning"
	gui:AddTip(id, _TRANS('SBTN_HelpTooltip_Getall')) --"Disable the warning that you get when you click the GetAll button."
end

function private.ConfigChanged()
	if not private.buttons then return end
	if AucAdvanced.Settings.GetSetting("util.scanbutton.enabled") then
		private.buttons:Show()
	else
		private.buttons:Hide()
	end
end

function private.stop()
	--this just makes the scan queue count decrease by 1 until the next processor event  sets it to a proper # helpfull if user is spamming stop button
	local count = tonumber(private.buttons.stop.count:GetText() )
	if count > 0 then	count = count -1 end
	private.buttons.stop.count:SetText(count)
	
	AucAdvanced.Scan.SetPaused(false)
	AucAdvanced.Scan.Cancel()
	private.UpdateScanProgress()
	queue = {}
	queueFinished = true --Will clear currently selected scan filters with the Next Onupdate event.
end

function private.play()
	if AucAdvanced.Scan.IsPaused() then
		AucAdvanced.Scan.SetPaused(false)
	elseif not AucAdvanced.Scan.IsScanning() then
		if #queue == 0 then queue = private.checkedFrames() end --check for user selected frames
		debugPrint(("play: queue count=%i"):format(#queue), "ScanButton", "play", 0, "Debug")
		if #queue > 0  then
			if AucAdvanced.Settings.GetSetting("util.scanbutton.message") then print("Starting search on filter: |CFFFFFF00", CLASS_FILTERS[queue[1]]) end
			AucAdvanced.Scan.StartScan("", "", "", nil, queue[1], nil, nil, nil)
			table.remove(queue, 1)
			if #queue == 0 then
				queueFinished = true --Used to clear the selected filters/highlights AFTER the last queued scan has completed
			end
		else
			AucAdvanced.Scan.StartScan("", "", "", AuctionFrameBrowse.selectedInvtypeIndex, AuctionFrameBrowse.selectedClassIndex, AuctionFrameBrowse.selectedSubclassIndex,  nil, nil)
		end
	end
	private.UpdateScanProgress()
end

function private.getall()
	if not AucAdvanced.Scan.IsScanning() then
		if (private.buttons.getall.warn) then
			private.message:Show()
			private.warned = true
			return
		end

		AucAdvanced.Scan.StartScan(nil, nil, nil, nil, nil, nil, nil, nil, true)
	end
	private.UpdateScanProgress()
end

function private.pause()
	if not AucAdvanced.Scan.IsPaused() then
		AucAdvanced.Scan.SetPaused(true)
	end
	private.UpdateScanProgress()
end

--[[
This adds a transparent replica of the AH filters on the browse frame, we have scripts on this frame to select catagories a user chooses to scan
This means we do not have to directly modify blizzards filter frame
]]
--store the primary AH filter categories, this is a copy of the global table the AH uses CLASS_FILTERS generated via GetAuctionItemClasses()
--Resets the selections table to 0 if an alt click is not used, or after a scan has been implemented
private.Filters = {}
function private.AuctionFrameFilters_ClearSelection()
	for i,v in pairs(CLASS_FILTERS) do
		private.Filters[v] = {0,i} --store cleared table of selections
	end
end
--clear any current highlighting from a prev search
function private.AuctionFrameFilters_ClearHighlight()
	for i in pairs(CLASS_FILTERS) do
		_G["AuctionFilterButton"..i]:UnlockHighlight()
	end
end

function private.checkedFrames()
	queue = {}
	for i,v in pairs(private.Filters) do
		if v[1] == 1 then
			table.insert(queue, v[2])
		end
	end

	return queue
end

function private.CreateSecondaryFilterButtons()
local base, frame, prev = AuctionFrameBrowse, nil, nil
	private.AuctionFrameFilters_ClearSelection() --create the filter selection table
	for i = 1,15 do
		frame = "AuctioneerFilterButton"..i
		prev = "AuctioneerFilterButton"..(i - 1)
		if i == 1 then
			base[frame] = CreateFrame("Button", frame, AuctionFilterButton1, "AuctionClassButtonTemplate")
			base[frame]:SetText("TICK-"..i)
			base[frame]:SetPoint("LEFT",0,0)
			base[frame]:SetWidth(156)
			base[frame]:SetAlpha(0)
			base[frame]:SetScript("OnClick", function()
									if IsControlKeyDown() then
-- Test patch to clear AH settings when CTRL click is used just like we clear ours when non-ctrl is used
if (AuctionFrameBrowse.selectedClassIndex) then
	AuctionFrameBrowse.selectedClass = nil
	AuctionFrameBrowse.selectedClassIndex = nil
	AuctionFrameBrowse.selectedSubclass = nil
	AuctionFrameBrowse.selectedSubclassIndex = nil
	AuctionFrameBrowse.selectedInvtype = nil
	AuctionFrameBrowse.selectedInvtypeIndex = nil
	AuctionFrameFilters_Update()
end
 										if private.Filters[ _G["AuctionFilterButton"..i]:GetText()][1] then
											if  private.Filters[ _G["AuctionFilterButton"..i]:GetText()][1] == 1 then
												private.Filters[ _G["AuctionFilterButton"..i]:GetText()][1] = 0
												 _G["AuctionFilterButton"..i]:UnlockHighlight()
											else
												private.Filters[ _G["AuctionFilterButton"..i]:GetText()][1] = 1
												 _G["AuctionFilterButton"..i]:LockHighlight()
											end
										end
									else
										private.AuctionFrameFilters_ClearSelection()
										AuctionFrameFilter_OnClick(_G["AuctionFilterButton"..i])
									end
								end)
		else
			base[frame] = CreateFrame("Button", frame, AuctionFilterButton1, "AuctionClassButtonTemplate")
			base[frame]:SetText("TICK-"..i)
			base[frame]:ClearAllPoints()
			base[frame]:SetPoint("TOPLEFT", base[prev],"BOTTOMLEFT",0,0)
			base[frame]:SetWidth(156)
			base[frame]:SetAlpha(0)
			base[frame]:SetScript("OnClick", function()
									if IsControlKeyDown() then
-- Test patch to clear AH settings when CTRL click is used just like we clear ours when non-ctrl is used
if (AuctionFrameBrowse.selectedClassIndex) then
	AuctionFrameBrowse.selectedClass = nil
	AuctionFrameBrowse.selectedClassIndex = nil
	AuctionFrameBrowse.selectedSubclass = nil
	AuctionFrameBrowse.selectedSubclassIndex = nil
	AuctionFrameFilters_Update()
end
										if private.Filters[ _G["AuctionFilterButton"..i]:GetText()] then
											if  private.Filters[ _G["AuctionFilterButton"..i]:GetText()][1] == 1 then
												private.Filters[ _G["AuctionFilterButton"..i]:GetText()][1] = 0
												 _G["AuctionFilterButton"..i]:UnlockHighlight()
											else
												private.Filters[ _G["AuctionFilterButton"..i]:GetText()][1] = 1
												 _G["AuctionFilterButton"..i]:LockHighlight()
											end
										end
									else
										private.AuctionFrameFilters_ClearSelection()
										AuctionFrameFilter_OnClick(_G["AuctionFilterButton"..i])
									end
								end)
		end
	end
	private.AuctionFrameFilters_UpdateClasses() --Changes the frame to match current filter frame, needed for 1 refresh after frame creation.
end

--Blizzard code base, used to generate a replica of the default filter frame
function private.AuctionFrameFilters_UpdateClasses()
	-- Display the list of open filters
	local button, index, info, isLast
	local offset = FauxScrollFrame_GetOffset(BrowseFilterScrollFrame)
	index = offset
	for i=1, NUM_FILTERS_TO_DISPLAY do
		button = _G["AuctioneerFilterButton"..i]

		if ( getn(OPEN_FILTER_LIST) > NUM_FILTERS_TO_DISPLAY ) then
			button:SetWidth(126)
		else
			button:SetWidth(126)
		end
		index = index + 1
		if ( index <= getn(OPEN_FILTER_LIST) ) then
			info = OPEN_FILTER_LIST[index]
			while ((info[2] == "invtype") and (not info[6])) do
				index = index + 1
				if ( index <= getn(OPEN_FILTER_LIST) ) then
					info = OPEN_FILTER_LIST[index]
				else
					info = nil
					button:Hide()
					break
				end
			end
			if ( info ) then
				FilterButton_SetType(button, info[2], info[1], info[5])
				button.index = info[3]
				if ( info[4] ) then
					button:LockHighlight()
				else
					button:UnlockHighlight()
				end
				button:Show()
			end
		else
			button:Hide()
		end

	end
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-ScanButton/ScanButton.lua $", "$Rev: 4711 $")
