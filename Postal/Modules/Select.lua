local Postal = LibStub("AceAddon-3.0"):GetAddon("Postal")
local Postal_Select = Postal:NewModule("Select", "AceEvent-3.0", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Postal")
Postal_Select.description = L["Add check boxes to the inbox for multiple mail operations."]
Postal_Select.description2 = L[ [[|cFFFFCC00*|r Selected mail will be batch opened or returned to sender by clicking Open or Return.
|cFFFFCC00*|r You can Shift-Click 2 checkboxes to mass select every mail between the 2 checkboxes.
|cFFFFCC00*|r You can Ctrl-Click a checkbox to mass select or unselect every mail from that sender.
|cFFFFCC00*|r Select will never delete any mail (mail without text is auto-deleted by the game when all attached items and gold are taken).
|cFFFFCC00*|r Select will skip CoD mails and mails from Blizzard.
|cFFFFCC00*|r Disable the Verbose option to stop the chat spam while opening mail.]] ]

local _G = getfenv(0)
local currentMode = nil
local selectedMail = {}
local openButton = nil
local returnButton = nil
local checkboxFunc = function(self) Postal_Select:ToggleMail(self) end
local mailIndex, attachIndex
local lastItem, lastNumAttach, lastNumGold
local wait
local skipFlag
local invFull
local lastCheck

local updateFrame = CreateFrame("Frame")
updateFrame:Hide()
updateFrame:SetScript("OnShow", function(self)
	self.time = Postal.db.profile.OpenSpeed
end)
updateFrame:SetScript("OnUpdate", function(self, elapsed)
	self.time = self.time - elapsed
	if self.time <= 0 then
		self:Hide()
		Postal_Select:ProcessNext()
	end
end)

local lastUnseen,lastTime = 0,0
local function noop() end
local function printTooMuchMail()
	local cur,tot = GetInboxNumItems()
	if tot-cur ~= lastUnseen or GetTime()-lastTime>=61 then
		-- This is a low-effort guess at how long is remaining until we can fetch new mail.
		lastUnseen = tot-cur
		lastTime = GetTime()
	end
	if cur>=50 then
		Postal:Print(format(L["There are %i more messages not currently shown."], lastUnseen))
	else
		Postal:Print(format(L["There are %i more messages not currently shown. More should become available in %i seconds."], lastUnseen, lastTime+61-GetTime()))
	end
	
	-- Just print once
	InboxTooMuchMail.Show = noop
end

function Postal_Select:OnEnable()
	--create the open button
	if not openButton then
		openButton = CreateFrame("Button", "PostalSelectOpenButton", InboxFrame, "UIPanelButtonTemplate")
		openButton:SetWidth(120)
		openButton:SetHeight(25)
		openButton:SetPoint("RIGHT", InboxFrame, "TOP", 5, -53)
		openButton:SetText(L["Open"])
		openButton:SetScript("OnClick", function() Postal_Select:HandleSelect(1) end)
		openButton:SetFrameLevel(openButton:GetFrameLevel() + 1)
	end

	--create the return button
	if not returnButton then
		returnButton = CreateFrame("Button", "PostalSelectReturnButton", InboxFrame, "UIPanelButtonTemplate")
		returnButton:SetWidth(120)
		returnButton:SetHeight(25)
		returnButton:SetPoint("LEFT", InboxFrame, "TOP", 10, -53)
		returnButton:SetText(L["Return"])
		returnButton:SetScript("OnClick", function() Postal_Select:HandleSelect() end)
		returnButton:SetFrameLevel(returnButton:GetFrameLevel() + 1)
	end

	--indent to make room for the checkboxes
	MailItem1:SetPoint("TOPLEFT", "InboxFrame", "TOPLEFT", 48, -80)
	for i = 1, 7 do
		_G["MailItem"..i.."ExpireTime"]:SetPoint("TOPRIGHT", "MailItem"..i, "TOPRIGHT", 10, -4)
		_G["MailItem"..i]:SetWidth(280)
	end

	--now create the checkboxes
	for i = 1, 7 do
		if not _G["PostalInboxCB"..i] then
			local CB = CreateFrame("CheckButton", "PostalInboxCB"..i, _G["MailItem"..i], "OptionsCheckButtonTemplate")
			CB:SetID(i)
			CB:SetPoint("RIGHT", "MailItem"..i, "LEFT", 1, -5)
			CB:SetWidth(24)
			CB:SetHeight(24)
			CB:SetHitRectInsets(0, 0, 0, 0)
			CB:SetScript("OnClick", checkboxFunc)
			local text = CB:CreateFontString("PostalInboxCB"..i.."Text", "BACKGROUND", "GameFontHighlightSmall")
			text:SetPoint("BOTTOM", CB, "TOP")
			text:SetText(i)
			CB.text = text
		end
	end

	self:RawHook("InboxFrame_Update", true)
	self:RegisterEvent("MAIL_SHOW")

	-- Don't show that silly "Not all of your mail could be delivered. Please delete some
	-- mail to make room." message under our Open and Return buttons. Print it to chat instead.
	InboxTooMuchMail.Show = printTooMuchMail
	InboxTooMuchMail:Hide()

	-- For enabling after a disable
	openButton:Show()
	returnButton:Show()
	for i = 1, 7 do
		_G["PostalInboxCB"..i]:Show()
	end
end

function Postal_Select:OnDisable()
	self:Reset()
	if self:IsHooked("InboxFrame_Update") then
		self:Unhook("InboxFrame_Update")
	end
	openButton:Hide()
	returnButton:Hide()
	MailItem1:SetPoint("TOPLEFT", "InboxFrame", "TOPLEFT", 28, -80)
	for i = 1, 7 do
		_G["PostalInboxCB"..i]:Hide()
		_G["MailItem"..i.."ExpireTime"]:SetPoint("TOPRIGHT", "MailItem"..i, "TOPRIGHT", -4, -4)
		_G["MailItem"..i]:SetWidth(305)
	end
	InboxTooMuchMail.Show = nil
end

function Postal_Select:MAIL_SHOW()
	self:RegisterEvent("MAIL_CLOSED", "Reset")
	self:RegisterEvent("PLAYER_LEAVING_WORLD", "Reset")
end

function Postal_Select:ToggleMail(frame)
	local index = frame:GetID() + (InboxFrame.pageNum - 1) * 7
	if lastCheck and IsShiftKeyDown() then
		-- Sneaky feature to shift-click a checkbox to select every
		-- mail between the clicked one and the previous click
		for i = lastCheck, index, lastCheck <= index and 1 or -1 do
			selectedMail[i] = true
		end
		self:InboxFrame_Update()
		return
	end
	if IsControlKeyDown() then
		-- Sneaky feature to ctrl-click a checkbox to select/unselect every
		-- mail where the sender is the same
		local status = frame:GetChecked()
		local indexSender = select(3, GetInboxHeaderInfo(index))
		for i = 1, GetInboxNumItems() do
			if select(3, GetInboxHeaderInfo(i)) == indexSender then
				selectedMail[i] = status
			end
		end
		self:InboxFrame_Update()
		return
	end
	if frame:GetChecked() then
		selectedMail[index] = true
		lastCheck = index
	else
		selectedMail[index] = nil
		lastCheck = nil
	end
end

function Postal_Select:HandleSelect(mode)
	mailIndex = GetInboxNumItems() or 0
	attachIndex = ATTACHMENTS_MAX_RECEIVE
	invFull = nil
	skipFlag = false
	lastItem = false
	lastNumAttach = nil
	lastNumGold = nil
	wait = false
	if mailIndex == 0 then
		return
	end

	currentMode = mode
	if currentMode then
		openButton:SetText(L["In Progress"])
		returnButton:Hide()
	else
		returnButton:SetText(L["In Progress"])
		openButton:Hide()
	end

	--protect the user from changing anything while were in process
	Postal:DisableInbox(1)
	if self:IsHooked("InboxFrame_Update") then
		self:Unhook("InboxFrame_Update")
	end

	for i = 1, 7 do
		local index = i + (InboxFrame.pageNum-1) * 7
		local CB = _G["PostalInboxCB"..i]
		CB:Hide()
	end

	self:RegisterEvent("UI_ERROR_MESSAGE")
	self:ProcessNext()
end

function Postal_Select:ProcessNext()
	-- Skip mails not selected to be processed
	while not selectedMail[mailIndex] and mailIndex > 0 do
		mailIndex = mailIndex - 1
		attachIndex = ATTACHMENTS_MAX_RECEIVE
	end

	if mailIndex > 0 then
		local msgSubject, msgMoney, msgCOD, _, msgItem, _, wasReturned, msgText, canReply, isGM = select(4, GetInboxHeaderInfo(mailIndex))

		if currentMode then
			-- Open mode

			-- Check if we need to wait for the mailbox to change
			if wait then
				local attachCount, goldCount = Postal:CountItemsAndMoney()
				if lastNumGold ~= goldCount then
					-- Process next mail, gold has been taken
					wait = false
					selectedMail[mailIndex] = nil
					mailIndex = mailIndex - 1
					attachIndex = ATTACHMENTS_MAX_RECEIVE
					return self:ProcessNext() -- tail call
				elseif lastNumAttach ~= attachCount then
					-- Process next item, an attachment has been taken
					wait = false
					attachIndex = attachIndex - 1
					if lastItem then
						-- The item taken was the last item, process next mail
						lastItem = false
						selectedMail[mailIndex] = nil
						mailIndex = mailIndex - 1
						attachIndex = ATTACHMENTS_MAX_RECEIVE
						return self:ProcessNext() -- tail call
					end
				else
					-- Wait longer until something in the mailbox changes
					updateFrame:Show()
					return
				end
			end

			-- Print message on next mail
			if Postal.db.profile.Select.SpamChat and attachIndex == ATTACHMENTS_MAX_RECEIVE then
				if not invFull or msgMoney > 0 then
					local moneyString = msgMoney > 0 and " ["..Postal:GetMoneyString(msgMoney).."]" or ""
					Postal:Print(format("%s %d: %s%s", L["Open"], mailIndex, msgSubject or "", moneyString))
				end
			end

			-- Skip mail if it contains a CoD or if its from a GM
			if (msgCOD and msgCOD > 0) or (isGM) then
				skipFlag = true
				selectedMail[mailIndex] = nil
				mailIndex = mailIndex - 1
				attachIndex = ATTACHMENTS_MAX_RECEIVE
				return self:ProcessNext() -- tail call
			end

			-- Find next attachment index backwards
			while not GetInboxItemLink(mailIndex, attachIndex) and attachIndex > 0 do
				attachIndex = attachIndex - 1
			end

			-- Check for free bag space
			if attachIndex > 0 and not invFull and Postal.db.profile.Select.KeepFreeSpace > 0 then
				local free = 0
				for bag = 0, NUM_BAG_SLOTS do
					local bagFree, bagFam = GetContainerNumFreeSlots(bag)
					if bagFam == 0 then
						free = free + bagFree
					end
				end
				if free <= Postal.db.profile.Select.KeepFreeSpace then
					invFull = true
					Postal:Print(format(L["Not taking more items as there are now only %d regular bagslots free."], free))
				end
			end

			if attachIndex > 0 and not invFull then
				-- If there's attachments, take the item
				--Postal:Print("Getting Item from Message "..mailIndex..", "..attachIndex)
				TakeInboxItem(mailIndex, attachIndex)

				lastNumAttach, lastNumGold = Postal:CountItemsAndMoney()
				wait = true
				-- Find next attachment index backwards
				local attachIndex2 = attachIndex - 1
				while not GetInboxItemLink(mailIndex, attachIndex2) and attachIndex2 > 0 do
					attachIndex2 = attachIndex2 - 1
				end
				if attachIndex2 == 0 and msgMoney == 0 then lastItem = true end

				updateFrame:Show()
			elseif msgMoney > 0 then
				-- No attachments, but there is money
				--Postal:Print("Getting Gold from Message "..mailIndex)
				TakeInboxMoney(mailIndex)

				lastNumAttach, lastNumGold = Postal:CountItemsAndMoney()
				wait = true

				updateFrame:Show()
			else
				-- Mail has no item or money, go to next mail
				selectedMail[mailIndex] = nil
				mailIndex = mailIndex - 1
				attachIndex = ATTACHMENTS_MAX_RECEIVE
				return self:ProcessNext() -- tail call
			end

		else
			-- Return mode
			if Postal.db.profile.Select.SpamChat and attachIndex == ATTACHMENTS_MAX_RECEIVE then
				Postal:Print(L["Return"].." "..mailIndex..": "..msgSubject)
			end
			if not wasReturned and canReply then
				self:RegisterEvent("MAIL_INBOX_UPDATE")
				ReturnInboxItem(mailIndex)
				selectedMail[mailIndex] = nil
				mailIndex = mailIndex - 1
			else
				Postal:Print(L["Skipping"].." "..mailIndex..": "..msgSubject)
				mailIndex = mailIndex - 1
				return self:ProcessNext() -- tail call
			end
		end

	else
		-- Reached the end of opening all selected mail
		if IsAddOnLoaded("MrPlow") then
			if MrPlow.DoStuff then
				MrPlow:DoStuff("stack")
			elseif MrPlow.ParseInventory then -- Backwards compat
				MrPlow:ParseInventory()
			end
		end
		if skipFlag then Postal:Print(L["Some Messages May Have Been Skipped."]) end
		self:Reset()
	end
end

function Postal_Select:InboxFrame_Update()
	self.hooks["InboxFrame_Update"]()
	for i = 1, 7 do
		local index = i + (InboxFrame.pageNum-1)*7
		local CB = _G["PostalInboxCB"..i]
		if index > GetInboxNumItems() then
			CB:Hide()
		else
			CB:Show()
			CB:SetChecked(selectedMail[index])
			CB.text:SetText(index)
		end
	end
end

function Postal_Select:MAIL_INBOX_UPDATE()
	--Postal:Print("update")
	self:UnregisterEvent("MAIL_INBOX_UPDATE")
	updateFrame:Show()
end

function Postal_Select:Reset(event)
	if not self:IsHooked("InboxFrame_Update") then self:RawHook("InboxFrame_Update", true) end

	updateFrame:Hide()
	self:UnregisterEvent("UI_ERROR_MESSAGE")

	wipe(selectedMail)

	Postal:DisableInbox()
	self:InboxFrame_Update()
	openButton:SetText(L["Open"])
	openButton:Show()
	returnButton:SetText(L["Return"])
	returnButton:Show()
	lastCheck = nil
	if event == "MAIL_CLOSED" or event == "PLAYER_LEAVING_WORLD" then
		self:UnregisterEvent("MAIL_CLOSED")
		self:UnregisterEvent("PLAYER_LEAVING_WORLD")
	end
	InboxTooMuchMail.Show = printTooMuchMail
end

function Postal_Select:UI_ERROR_MESSAGE(event, error_message)
	if error_message == ERR_INV_FULL then
		invFull = true
		wait = false
	elseif error_message == ERR_ITEM_MAX_COUNT then
		attachIndex = attachIndex - 1
		wait = false
	end
end

function Postal_Select.SetKeepFreeSpace(dropdownbutton, arg1, arg2, checked)
	Postal.db.profile.Select.KeepFreeSpace = arg1
end

function Postal_Select.ModuleMenu(self, level)
	if not level then return end
	local info = self.info
	wipe(info)
	if level == 1 + self.levelAdjust then
		info.keepShownOnClick = 1

		info.text = L["Keep free space"]
		info.hasArrow = 1
		info.value = "KeepFreeSpace"
		info.func = self.UncheckHack
		UIDropDownMenu_AddButton(info, level)
		local listFrame = _G["DropDownList"..level]
		self.UncheckHack(_G[listFrame:GetName().."Button"..listFrame.numButtons])

		info.text = L["Verbose mode"]
		info.hasArrow = nil
		info.value = nil
		info.func = Postal.SaveOption
		info.arg1 = "Select"
		info.arg2 = "SpamChat"
		info.checked = Postal.db.profile.Select.SpamChat
		info.isNotRadio = 1
		UIDropDownMenu_AddButton(info, level)

	elseif level == 2 + self.levelAdjust then
		if UIDROPDOWNMENU_MENU_VALUE == "KeepFreeSpace" then
			local keepFree = Postal.db.profile.Select.KeepFreeSpace
			info.func = Postal_Select.SetKeepFreeSpace
			for _, v in ipairs(Postal.keepFreeOptions) do
				info.text = v
				info.checked = v == keepFree
				info.arg1 = v
				UIDropDownMenu_AddButton(info, level)
			end
		end
	end
end

