local Postal = LibStub("AceAddon-3.0"):GetAddon("Postal")
local Postal_BlackBook = Postal:NewModule("BlackBook", "AceEvent-3.0", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Postal")
Postal_BlackBook.description = L["Adds a contact list next to the To: field."]
Postal_BlackBook.description2 = L[ [[|cFFFFCC00*|r This module will list your contacts, friends, guild mates, alts and track the last 10 people you mailed.
|cFFFFCC00*|r It will also autocomplete all names in your BlackBook.]] ]

local Postal_BlackBookButton
local numFriendsOnList = 0
local sorttable = {}
local ignoresortlocale = {
	["koKR"] = true,
	["zhCN"] = true,
	["zhTW"] = true,
}
local enableAltsMenu = true
local Postal_BlackBook_Autocomplete_Flags = {
	include = AUTOCOMPLETE_FLAG_ALL,
	exclude = AUTOCOMPLETE_FLAG_NONE,
}

function Postal_BlackBook:OnEnable()
	if not Postal_BlackBookButton then
		-- Create the Menu Button
		Postal_BlackBookButton = CreateFrame("Button", "Postal_BlackBookButton", SendMailFrame)
		Postal_BlackBookButton:SetWidth(25)
		Postal_BlackBookButton:SetHeight(25)
		Postal_BlackBookButton:SetPoint("LEFT", SendMailNameEditBox, "RIGHT", -2, 0)
		Postal_BlackBookButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
		Postal_BlackBookButton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Round")
		Postal_BlackBookButton:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled")
		Postal_BlackBookButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down")
		Postal_BlackBookButton:SetScript("OnClick", function(self, button, down)
			if Postal_DropDownMenu.initialize ~= Postal_BlackBook.BlackBookMenu then
				CloseDropDownMenus()
				Postal_DropDownMenu.initialize = Postal_BlackBook.BlackBookMenu
			end
			ToggleDropDownMenu(1, nil, Postal_DropDownMenu, self:GetName(), 0, 0)
		end)
		Postal_BlackBookButton:SetScript("OnHide", Postal_DropDownMenu.HideMenu)
	end

	SendMailNameEditBox:SetHistoryLines(15)
	self:RawHook("SendMailFrame_Reset", true)
	self:RawHook("MailFrameTab_OnClick", true)
	if Postal.db.profile.BlackBook.UseAutoComplete then
		self:RawHookScript(SendMailNameEditBox, "OnChar")
	end
	self:HookScript(SendMailNameEditBox, "OnEditFocusGained")
	self:RawHook("AutoComplete_Update", true)
	self:RegisterEvent("MAIL_SHOW")
	self:RegisterEvent("BN_FRIEND_INFO_CHANGED")

	local db = Postal.db.profile.BlackBook
	local exclude = bit.bor(db.AutoCompleteFriends and AUTOCOMPLETE_FLAG_NONE or AUTOCOMPLETE_FLAG_FRIEND,
		db.AutoCompleteGuild and AUTOCOMPLETE_FLAG_NONE or AUTOCOMPLETE_FLAG_IN_GUILD)
	Postal_BlackBook_Autocomplete_Flags.include = bit.bxor(
		db.ExcludeRandoms and (bit.bor(AUTOCOMPLETE_FLAG_FRIEND, AUTOCOMPLETE_FLAG_IN_GUILD)) or AUTOCOMPLETE_FLAG_ALL, exclude)
	SendMailNameEditBox.autoCompleteParams = Postal_BlackBook_Autocomplete_Flags

	-- For enabling after a disable
	Postal_BlackBookButton:Show()
end

function Postal_BlackBook:OnDisable()
	-- Disabling modules unregisters all events/hook automatically
	SendMailNameEditBox:SetHistoryLines(1)
	Postal_BlackBookButton:Hide()
	SendMailNameEditBox.autoCompleteParams = AUTOCOMPLETE_LIST.MAIL
end

function Postal_BlackBook:MAIL_SHOW()
	self:RegisterEvent("MAIL_CLOSED", "Reset")
	self:RegisterEvent("PLAYER_LEAVING_WORLD", "Reset")
	if self.AddAlt then self:AddAlt() end
	self:BN_FRIEND_INFO_CHANGED()
end

function Postal_BlackBook:Reset(event)
	self:UnregisterEvent("MAIL_CLOSED")
	self:UnregisterEvent("PLAYER_LEAVING_WORLD")
end

function Postal_BlackBook:BN_FRIEND_INFO_CHANGED(presenceID)
	local numBNetTotal, numBNetOnline = BNGetNumFriends()
	for i = 1, numBNetOnline do
		local presenceID, givenName, surname, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, broadcastText, noteText, isFriend, broadcastTime = BNGetFriendInfo(i)
		if givenName and surname and toonID then
			local hasFocus, toonName, client, realmName, faction, race, class, guild, zoneName, level, gameText = BNGetToonInfo(toonID)
			if client == BNET_CLIENT_WOW then
				-- Convert data to non-localized form
				for token, loc_male in pairs(LOCALIZED_CLASS_NAMES_MALE) do
					if loc_male == class then class = token end
				end
				for token, loc_female in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do
					if loc_female == class then class = token end
				end
				faction = PLAYER_FACTION_GROUP[faction]
				-- Insert the toon into our global db
				local nameStr = givenName.."|"..surname
				local toonStr = ("%s|%s|%s|%s|%s"):format(toonName, realmName, faction, level, class)
				local db = Postal.db.global.BlackBook.realID
				db[nameStr] = db[nameStr] or {}
				db = db[nameStr]
				local flag = true
				for i = 1, #db do
					local n, r, f, l, c = strsplit("|", db[i])
					if n == toonName and r == realmName then
						if f == faction and l == level and c == class then
							flag = false
						else
							tremove(db, i)
						end
						break
					end
				end
				if flag then
					tinsert(db, toonStr)
					table.sort(db)
				end
			end
		end
	end
end

-- We do this once on MAIL_SHOW because UnitFactionGroup() is only valid after
-- PLAYER_ENTERING_WORLD and because Postal might be LoD due to AddOnLoader
-- and PLAYER_ENTERING_WORLD won't fire in that scenerio.
function Postal_BlackBook:AddAlt()
	local realm = GetRealmName()
	local faction = UnitFactionGroup("player")
	local player = UnitName("player")
	local level = UnitLevel("player")
	local _, class = UnitClass("player")
	local namestring = ("%s|%s|%s|%s|%s"):format(player, realm, faction, level, class)
	local flag = true
	local db = Postal.db.global.BlackBook.alts
	enableAltsMenu = false
	for i = #db, 1, -1 do
		local p, r, f, l, c = strsplit("|", db[i])
		if p == player and r == realm and f == faction then
			tremove(db, i)
		end
		if p ~= player and r == realm and f == faction then
			enableAltsMenu = true
		end
	end
	if flag then
		tinsert(db, namestring)
		table.sort(db)
	end
	self.AddAlt = nil -- Kill ourselves so we only run it once
end

function Postal_BlackBook.DeleteAlt(dropdownbutton, arg1, arg2, checked)
	local realm = GetRealmName()
	local faction = UnitFactionGroup("player")
	local player = UnitName("player")
	local db = Postal.db.global.BlackBook.alts
	enableAltsMenu = false
	for i = #db, 1, -1 do
		if arg1 == db[i] then
			tremove(db, i)
		else
			local p, r, f = strsplit("|", db[i])
			if r == realm and f == faction and p ~= player then
				enableAltsMenu = true
			end
		end
	end
	CloseDropDownMenus()
end

-- Only called on a mail that is sent successfully
function Postal_BlackBook:SendMailFrame_Reset()
	local name = strtrim(SendMailNameEditBox:GetText())
	if name == "" then return self.hooks["SendMailFrame_Reset"]() end
	SendMailNameEditBox:AddHistoryLine(name)
	local db = Postal.db.profile.BlackBook.recent
	for k = 1, #db do
		if name == db[k] then tremove(db, k) break end
	end
	tinsert(db, 1, name)
	for k = #db, 11, -1 do
		tremove(db, k)
	end
	self.hooks["SendMailFrame_Reset"]()
	if Postal.db.profile.BlackBook.AutoFill then
		SendMailNameEditBox:SetText(name)
		SendMailNameEditBox:HighlightText()
	end
end

function Postal_BlackBook.ClearRecent(dropdownbutton, arg1, arg2, checked)
	wipe(Postal.db.profile.BlackBook.recent)
	CloseDropDownMenus()
end

function Postal_BlackBook:MailFrameTab_OnClick(button, tab)
	self.hooks["MailFrameTab_OnClick"](button, tab)
	if Postal.db.profile.BlackBook.AutoFill and tab == 2 then
		local name = Postal.db.profile.BlackBook.recent[1]
		if name and SendMailNameEditBox:GetText() == "" then
			SendMailNameEditBox:SetText(name)
			SendMailNameEditBox:HighlightText()
		end
	end
end

function Postal_BlackBook:OnEditFocusGained(editbox, ...)
	-- Most other addons aren't hooking properly and do not pass in editbox at all.
	SendMailNameEditBox:HighlightText()
end

function Postal_BlackBook:AutoComplete_Update(editBox, editBoxText, utf8Position, ...)
	if editBox ~= SendMailNameEditBox or not Postal.db.profile.BlackBook.DisableBlizzardAutoComplete then
		self.hooks["AutoComplete_Update"](editBox, editBoxText, utf8Position, ...)
	end
end

-- OnChar fires before OnTextChanged
-- OnChar does not fire for Backspace, Delete keys that shorten the text
-- Hook player name autocomplete to look in our dbs first
function Postal_BlackBook:OnChar(editbox, ...)
	if editbox:GetUTF8CursorPosition() ~= strlenutf8(editbox:GetText()) then return end

	local db = Postal.db.profile.BlackBook
	local text = strupper(editbox:GetText())
	local textlen = strlen(text)
	local realm = GetRealmName()
	local faction = UnitFactionGroup("player")
	local player = UnitName("player")
	local newname

	-- Check alt list
	if db.AutoCompleteAlts then
		local db = Postal.db.global.BlackBook.alts
		for i = 1, #db do
			local p, r, f = strsplit("|", db[i])
			if r == realm and f == faction and p ~= player then
				if strfind(strupper(p), text, 1, 1) == 1 then
					newname = p
					break
				end
			end
		end
	end

	-- Check recent list
	if not newname and db.AutoCompleteRecent then
		local db2 = db.recent
		for j = 1, #db2 do
			local name = db2[j]
			if strfind(strupper(name), text, 1, 1) == 1 then
				newname = name
				break
			end
		end
	end

	-- Check contacts list
	if not newname and db.AutoCompleteContacts then
		local db2 = db.contacts
		for j = 1, #db2 do
			local name = db2[j]
			if strfind(strupper(name), text, 1, 1) == 1 then
				newname = name
				break
			end
		end
	end

	-- Check Real ID friends list
	if not newname and db.AutoCompleteRealIDFriends then
		local db2 = Postal.db.global.BlackBook.realID
		for realname, charList in pairs(db2) do
			for j = 1, #charList do
				local p, r, f, l, c = strsplit("|", charList[j])
				if r == realm and f == faction and p ~= player then
					if strfind(strupper(p), text, 1, 1) == 1 then
						newname = p
						break
					end
				end
			end
			if newname then break end
		end
	end

	-- Call the original Blizzard function to autocomplete and for its popup
	self.hooks[SendMailNameEditBox].OnChar(editbox, ...)

	-- Set our match if we found one (overriding Blizzard's match if there's one)
	if newname then
		editbox:SetText(newname)
		editbox:HighlightText(textlen, -1)
		editbox:SetCursorPosition(textlen)
	end
end

function Postal_BlackBook.SetSendMailName(dropdownbutton, arg1, arg2, checked)
	SendMailNameEditBox:SetText(arg1)
	if SendMailNameEditBox:HasFocus() then SendMailSubjectEditBox:SetFocus() end
	CloseDropDownMenus()
end

function Postal_BlackBook.AddContact(dropdownbutton, arg1, arg2, checked)
	local name = strtrim(SendMailNameEditBox:GetText())
	if name == "" then return end
	local db = Postal.db.profile.BlackBook.contacts
	for k = 1, #db do
		if name == db[k] then return end
	end
	tinsert(db, name)
	table.sort(db)
end

function Postal_BlackBook.RemoveContact(dropdownbutton, arg1, arg2, checked)
	local name = strtrim(SendMailNameEditBox:GetText())
	if name == "" then return end
	local db = Postal.db.profile.BlackBook.contacts
	for k = 1, #db do
		if name == db[k] then tremove(db, k) return end
	end
end

function Postal_BlackBook.DeleteRealIDChar(dropdownbutton, arg1, arg2, checked)
	local db = Postal.db.global.BlackBook.realID[arg1]
	local i, j = string.match(dropdownbutton:GetName(), "DropDownList(%d+)Button(%d+)")
	for k = 1, #db do
		if arg2 == db[k] then
			tremove(db, k)
			if #db == 0 then
				Postal.db.global.BlackBook.realID[arg1] = nil
				CloseDropDownMenus(i-2)
			else
				CloseDropDownMenus(i-1)
			end
			if Postal_BlackBook:CountRealIDFriends() == 0 then
				CloseDropDownMenus()
			end
			return
		end
	end
end

function Postal_BlackBook.RealNameSort(a, b)
	local nameA = strupper(format(BATTLENET_NAME_FORMAT, strsplit("|", a)))
	local nameB = strupper(format(BATTLENET_NAME_FORMAT, strsplit("|", b)))
	return nameA < nameB
end

function Postal_BlackBook:CountRealIDFriends()
	local db = Postal.db.global.BlackBook.realID
	local realm = GetRealmName()
	local faction = UnitFactionGroup("player")
	local numFriends = 0
	-- For each friend
	for realName, charList in pairs(db) do
		-- For each char, see if it matches the same realm and faction
		for i = 1, #charList do
			local n, r, f, l, c = strsplit("|", charList[i])
			if realm == r and faction == f then
				numFriends = numFriends + 1
				break  -- Just count each friend once
			end
		end
	end
	return numFriends
end

function Postal_BlackBook.BlackBookMenu(self, level)
	if not level then return end
	local info = self.info
	wipe(info)
	if level == 1 then
		info.isTitle = 1
		info.text = L["Contacts"]
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)

		info.disabled = nil
		info.isTitle = nil

		local db = Postal.db.profile.BlackBook.contacts
		for i = 1, #db do
			info.text = db[i]
			info.func = Postal_BlackBook.SetSendMailName
			info.arg1 = db[i]
			UIDropDownMenu_AddButton(info, level)
		end

		info.arg1 = nil
		if #db > 0 then
			info.disabled = 1
			info.text = nil
			info.func = nil
			UIDropDownMenu_AddButton(info, level)
			info.disabled = nil
		end

		info.text = L["Add Contact"]
		info.func = Postal_BlackBook.AddContact
		UIDropDownMenu_AddButton(info, level)

		info.text = L["Remove Contact"]
		info.func = Postal_BlackBook.RemoveContact
		UIDropDownMenu_AddButton(info, level)

		info.disabled = 1
		info.text = nil
		info.func = nil
		UIDropDownMenu_AddButton(info, level)

		info.hasArrow = 1
		info.keepShownOnClick = 1
		info.func = self.UncheckHack

		info.disabled = #Postal.db.profile.BlackBook.recent == 0
		info.text = L["Recently Mailed"]
		info.value = "recent"
		UIDropDownMenu_AddButton(info, level)

		info.disabled = not enableAltsMenu
		info.text = L["Alts"]
		info.value = "alt"
		UIDropDownMenu_AddButton(info, level)

		info.disabled = (not BNGetNumFriends) or (Postal_BlackBook:CountRealIDFriends() == 0)
		info.text = BATTLENET_FRIEND.." "..L["Friends"]
		info.value = "friendRealID"
		UIDropDownMenu_AddButton(info, level)

		info.disabled = GetNumFriends() == 0
		info.text = L["Friends"]
		info.value = "friend"
		UIDropDownMenu_AddButton(info, level)

		info.disabled = not IsInGuild()
		info.text = L["Guild"]
		info.value = "guild"
		UIDropDownMenu_AddButton(info, level)

		wipe(info)
		info.disabled = 1
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)
		info.disabled = nil

		info.text = CLOSE
		info.func = self.HideMenu
		UIDropDownMenu_AddButton(info, level)

	elseif level == 2 then
		info.notCheckable = 1
		if UIDROPDOWNMENU_MENU_VALUE == "recent" then
			local db = Postal.db.profile.BlackBook.recent
			if #db == 0 then return end
			for i = 1, #db do
				info.text = db[i]
				info.func = Postal_BlackBook.SetSendMailName
				info.arg1 = db[i]
				UIDropDownMenu_AddButton(info, level)
			end

			info.disabled = 1
			info.text = nil
			info.func = nil
			info.arg1 = nil
			UIDropDownMenu_AddButton(info, level)
			info.disabled = nil

			info.text = L["Clear list"]
			info.func = Postal_BlackBook.ClearRecent
			info.arg1 = nil
			UIDropDownMenu_AddButton(info, level)

		elseif UIDROPDOWNMENU_MENU_VALUE == "alt" then
			if not enableAltsMenu then return end
			local db = Postal.db.global.BlackBook.alts
			local realm = GetRealmName()
			local faction = UnitFactionGroup("player")
			local player = UnitName("player")
			info.notCheckable = 1
			for i = 1, #db do
				local p, r, f, l, c = strsplit("|", db[i])
				if r == realm and f == faction and p ~= player then
					if l and c then
						local clr = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[c] or RAID_CLASS_COLORS[c]
						info.text = format("%s |cff%.2x%.2x%.2x(%d %s)|r", p, clr.r*255, clr.g*255, clr.b*255, l, LOCALIZED_CLASS_NAMES_MALE[c])
					else
						info.text = p
					end
					info.func = Postal_BlackBook.SetSendMailName
					info.arg1 = p
					UIDropDownMenu_AddButton(info, level)
				end
			end

			info.disabled = 1
			info.text = nil
			info.func = nil
			info.arg1 = nil
			UIDropDownMenu_AddButton(info, level)
			info.disabled = nil

			info.text = L["Delete"]
			info.hasArrow = 1
			info.keepShownOnClick = 1
			info.func = self.UncheckHack
			info.value = "deletealt"
			UIDropDownMenu_AddButton(info, level)

		elseif UIDROPDOWNMENU_MENU_VALUE == "friendRealID" then
			-- Friends list (RealID)
			local db = Postal.db.global.BlackBook.realID
			local realm = GetRealmName()
			local faction = UnitFactionGroup("player")
			local numFriends = 0
			-- For each friend
			for realName, charList in pairs(db) do
				-- For each char, see if it matches the same realm and faction
				for i = 1, #charList do
					local n, r, f, l, c = strsplit("|", charList[i])
					if realm == r and faction == f then
						numFriends = numFriends + 1
						sorttable[numFriends] = realName
						break  -- Just add each friend once
					end
				end
			end

			-- Sort the list
			if numFriends == 0 then return end
			for i = #sorttable, numFriends+1, -1 do
				sorttable[i] = nil
			end
			if not ignoresortlocale[GetLocale()] then table.sort(sorttable, Postal_BlackBook.RealNameSort) end

			-- Store upvalue
			numFriendsOnList = numFriends

			info.hasArrow = 1
			info.keepShownOnClick = 1
			info.func = self.UncheckHack
			-- 25 or less, don't need multi level menus
			if numFriends > 0 and numFriends <= 25 then
				for i = 1, numFriends do
					local name = sorttable[i]
					info.text = format(BATTLENET_NAME_FORMAT, strsplit("|", name))
					info.value = "frname"..i
					UIDropDownMenu_AddButton(info, level)
				end
			elseif numFriends > 25 then
				-- More than 25 people, split the list into multiple sublists of 25
				for i = 1, math.ceil(numFriends/25) do
					info.text  = L["Part %d"]:format(i)
					info.value = "frpart"..i
					UIDropDownMenu_AddButton(info, level)
				end
			end
		
		elseif UIDROPDOWNMENU_MENU_VALUE == "friend" then
			-- Friends list
			local numFriends = GetNumFriends()
			for i = 1, numFriends do
				sorttable[i] = GetFriendInfo(i)
			end

			-- Battle.net friends
			if BNGetNumFriends then -- For pre 3.3.5 backwards compat
				local numBNetTotal, numBNetOnline = BNGetNumFriends()
				for i= 1, numBNetOnline do
					local presenceID, givenName, surname, toonName, toonID, client = BNGetFriendInfo(i)
					--local hasFocus, toonName, client = BNGetToonInfo(toonID)
					if (toonName and client == BNET_CLIENT_WOW and CanCooperateWithToon(toonID)) then
						-- Check if already on friends list
						local alreadyOnList = false
						for j = 1, numFriends do
							if sorttable[j] == toonName then
								alreadyOnList = true
								break
							end
						end			
						if not alreadyOnList then
							numFriends = numFriends + 1
							sorttable[numFriends] = toonName
						end
					end
				end
			end

			-- Sort the list
			if numFriends == 0 then return end
			for i = #sorttable, numFriends+1, -1 do
				sorttable[i] = nil
			end
			if not ignoresortlocale[GetLocale()] then table.sort(sorttable) end

			-- Store upvalue
			numFriendsOnList = numFriends

			-- 25 or less, don't need multi level menus
			if numFriends > 0 and numFriends <= 25 then
				for i = 1, numFriends do
					local name = sorttable[i]
					info.text = name
					info.func = Postal_BlackBook.SetSendMailName
					info.arg1 = name
					UIDropDownMenu_AddButton(info, level)
				end
			elseif numFriends > 25 then
				-- More than 25 people, split the list into multiple sublists of 25
				info.hasArrow = 1
				info.keepShownOnClick = 1
				info.func = self.UncheckHack
				for i = 1, math.ceil(numFriends/25) do
					info.text  = L["Part %d"]:format(i)
					info.value = "fpart"..i
					UIDropDownMenu_AddButton(info, level)
				end
			end

		elseif UIDROPDOWNMENU_MENU_VALUE == "guild" then
			if not IsInGuild() then return end
			local numFriends = GetNumGuildMembers(true)
			for i = 1, numFriends do
				local name, rank, rankIndex, level, class, zone, note, officernote, online, status, classFileName = GetGuildRosterInfo(i)
				local c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[classFileName] or RAID_CLASS_COLORS[classFileName]
				sorttable[i] = format("%s |cffffd200(%s)|r |cff%.2x%.2x%.2x(%d %s)|r", name, rank, c.r*255, c.g*255, c.b*255, level, class)
			end
			for i = #sorttable, numFriends+1, -1 do
				sorttable[i] = nil
			end
			if not ignoresortlocale[GetLocale()] then table.sort(sorttable) end
			if numFriends > 0 and numFriends <= 25 then
				for i = 1, numFriends do
					info.text = sorttable[i]
					info.func = Postal_BlackBook.SetSendMailName
					info.arg1 = strmatch(sorttable[i], "(.*) |cffffd200")
					UIDropDownMenu_AddButton(info, level)
				end
			elseif numFriends > 25 then
				-- More than 25 people, split the list into multiple sublists of 25
				info.hasArrow = 1
				info.keepShownOnClick = 1
				info.func = self.UncheckHack
				for i = 1, math.ceil(numFriends/25) do
					info.text  = L["Part %d"]:format(i)
					info.value = "gpart"..i
					UIDropDownMenu_AddButton(info, level)
				end
			end
		end

	elseif level >= 3 then
		info.notCheckable = 1
		if UIDROPDOWNMENU_MENU_VALUE == "deletealt" then
			local db = Postal.db.global.BlackBook.alts
			local realm = GetRealmName()
			local faction = UnitFactionGroup("player")
			local player = UnitName("player")
			for i = 1, #db do
				local p, r, f, l, c = strsplit("|", db[i])
				if r == realm and f == faction and p ~= player then
					if l and c then
						local clr = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[c] or RAID_CLASS_COLORS[c]
						info.text = format("%s |cff%.2x%.2x%.2x(%d %s)|r", p, clr.r*255, clr.g*255, clr.b*255, l, LOCALIZED_CLASS_NAMES_MALE[c])
					else
						info.text = p
					end
					info.func = Postal_BlackBook.DeleteAlt
					info.arg1 = db[i]
					UIDropDownMenu_AddButton(info, level)
				end
			end

		elseif strfind(UIDROPDOWNMENU_MENU_VALUE, "deleterealidchar") then
			local index = tonumber(strmatch(UIDROPDOWNMENU_MENU_VALUE, "deleterealidchar(%d+)"))
			local name = sorttable[index]
			local db = Postal.db.global.BlackBook.realID[name]
			local realm = GetRealmName()
			local faction = UnitFactionGroup("player")
			for i = 1, #db do
				local n, r, f, l, c = strsplit("|", db[i])
				if realm == r and faction == f then
					local clr = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[c] or RAID_CLASS_COLORS[c]
					info.text = format("%s |cff%.2x%.2x%.2x(%d %s)|r", n, clr.r*255, clr.g*255, clr.b*255, l, LOCALIZED_CLASS_NAMES_MALE[c])
					info.func = Postal_BlackBook.DeleteRealIDChar
					info.arg1 = name
					info.arg2 = db[i]
					UIDropDownMenu_AddButton(info, level)
				end
			end

		elseif strfind(UIDROPDOWNMENU_MENU_VALUE, "frname") then
			local index = tonumber(strmatch(UIDROPDOWNMENU_MENU_VALUE, "frname(%d+)"))
			local name = sorttable[index]
			local db = Postal.db.global.BlackBook.realID[name]
			local realm = GetRealmName()
			local faction = UnitFactionGroup("player")
			for i = 1, #db do
				local n, r, f, l, c = strsplit("|", db[i])
				if realm == r and faction == f then
					local clr = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[c] or RAID_CLASS_COLORS[c]
					info.text = format("%s |cff%.2x%.2x%.2x(%d %s)|r", n, clr.r*255, clr.g*255, clr.b*255, l, LOCALIZED_CLASS_NAMES_MALE[c])
					info.func = Postal_BlackBook.SetSendMailName
					info.arg1 = n
					UIDropDownMenu_AddButton(info, level)
				end
			end

			info.disabled = 1
			info.text = nil
			info.func = nil
			info.arg1 = nil
			UIDropDownMenu_AddButton(info, level)
			info.disabled = nil

			info.text = L["Delete"]
			info.hasArrow = 1
			info.keepShownOnClick = 1
			info.func = self.UncheckHack
			info.value = "deleterealidchar"..index
			UIDropDownMenu_AddButton(info, level)

		elseif strfind(UIDROPDOWNMENU_MENU_VALUE, "frpart") then
			info.hasArrow = 1
			info.keepShownOnClick = 1
			info.func = self.UncheckHack

			local startIndex = tonumber(strmatch(UIDROPDOWNMENU_MENU_VALUE, "frpart(%d+)")) * 25 - 24
			local endIndex = math.min(startIndex+24, numFriendsOnList)
			for i = startIndex, endIndex do
				local name = sorttable[i]
				info.text = format(BATTLENET_NAME_FORMAT, strsplit("|", name))
				info.value = "frname"..i
				UIDropDownMenu_AddButton(info, level)
			end

		elseif strfind(UIDROPDOWNMENU_MENU_VALUE, "fpart") then
			local startIndex = tonumber(strmatch(UIDROPDOWNMENU_MENU_VALUE, "fpart(%d+)")) * 25 - 24
			local endIndex = math.min(startIndex+24, numFriendsOnList)
			for i = startIndex, endIndex do
				local name = sorttable[i]
				info.text = name
				info.func = Postal_BlackBook.SetSendMailName
				info.arg1 = name
				UIDropDownMenu_AddButton(info, level)
			end

		elseif strfind(UIDROPDOWNMENU_MENU_VALUE, "gpart") then
			local startIndex = tonumber(strmatch(UIDROPDOWNMENU_MENU_VALUE, "gpart(%d+)")) * 25 - 24
			local endIndex = math.min(startIndex+24, (GetNumGuildMembers(true)))
			for i = startIndex, endIndex do
				local name = sorttable[i]
				info.text = sorttable[i]
				info.func = Postal_BlackBook.SetSendMailName
				info.arg1 = strmatch(sorttable[i], "(.*) |cffffd200")
				UIDropDownMenu_AddButton(info, level)
			end
		end

	end
end

function Postal_BlackBook.SaveFriendGuildOption(dropdownbutton, arg1, arg2, checked)
	Postal.SaveOption(dropdownbutton, arg1, arg2, checked)
	local db = Postal.db.profile.BlackBook
	local exclude = bit.bor(db.AutoCompleteFriends and AUTOCOMPLETE_FLAG_NONE or AUTOCOMPLETE_FLAG_FRIEND,
		db.AutoCompleteGuild and AUTOCOMPLETE_FLAG_NONE or AUTOCOMPLETE_FLAG_IN_GUILD)
	Postal_BlackBook_Autocomplete_Flags.include = bit.bxor(
		db.ExcludeRandoms and (bit.bor(AUTOCOMPLETE_FLAG_FRIEND, AUTOCOMPLETE_FLAG_IN_GUILD)) or AUTOCOMPLETE_FLAG_ALL, exclude)
end

function Postal_BlackBook.SetAutoComplete(dropdownbutton, arg1, arg2, checked)
	local self = Postal_BlackBook
	Postal.db.profile.BlackBook.UseAutoComplete = not checked
	if checked then
		if self:IsHooked(SendMailNameEditBox, "OnChar") then
			self:Unhook(SendMailNameEditBox, "OnChar")
		end
	else
		if not self:IsHooked(SendMailNameEditBox, "OnChar") then
			self:RawHookScript(SendMailNameEditBox, "OnChar")
		end
	end
end

function Postal_BlackBook.ModuleMenu(self, level)
	if not level then return end
	local info = self.info
	wipe(info)
	info.isNotRadio = 1
	if level == 1 + self.levelAdjust then
		info.keepShownOnClick = 1
		info.text = L["Autofill last person mailed"]
		info.func = Postal.SaveOption
		info.arg1 = "BlackBook"
		info.arg2 = "AutoFill"
		info.checked = Postal.db.profile.BlackBook.AutoFill
		UIDropDownMenu_AddButton(info, level)

		info.hasArrow = 1
		info.keepShownOnClick = 1
		info.func = self.UncheckHack
		info.checked = nil
		info.arg1 = nil
		info.arg2 = nil
		info.text = L["Name auto-completion options"]
		info.value = "AutoComplete"
		UIDropDownMenu_AddButton(info, level)
		local listFrame = _G["DropDownList"..level]
		self.UncheckHack(_G[listFrame:GetName().."Button"..listFrame.numButtons])

	elseif level == 2 + self.levelAdjust then
		local db = Postal.db.profile.BlackBook
		info.arg1 = "BlackBook"

		if UIDROPDOWNMENU_MENU_VALUE == "AutoComplete" then
			info.text = L["Use Postal's auto-complete"]
			info.arg2 = "UseAutoComplete"
			info.checked = db.UseAutoComplete
			info.func = Postal_BlackBook.SetAutoComplete
			UIDropDownMenu_AddButton(info, level)

			info.func = Postal.SaveOption
			info.disabled = not db.UseAutoComplete
			info.keepShownOnClick = 1

			info.text = L["Alts"]
			info.arg2 = "AutoCompleteAlts"
			info.checked = db.AutoCompleteAlts
			UIDropDownMenu_AddButton(info, level)

			info.text = L["Recently Mailed"]
			info.arg2 = "AutoCompleteRecent"
			info.checked = db.AutoCompleteRecent
			UIDropDownMenu_AddButton(info, level)

			info.text = L["Contacts"]
			info.arg2 = "AutoCompleteContacts"
			info.checked = db.AutoCompleteContacts
			UIDropDownMenu_AddButton(info, level)

			info.text = BATTLENET_FRIEND.." "..L["Friends"]
			info.arg2 = "AutoCompleteRealIDFriends"
			info.checked = db.AutoCompleteRealIDFriends
			info.func = Postal_BlackBook.SaveFriendGuildOption
			UIDropDownMenu_AddButton(info, level)

			info.disabled = nil

			info.text = L["Friends"]
			info.arg2 = "AutoCompleteFriends"
			info.checked = db.AutoCompleteFriends
			info.func = Postal_BlackBook.SaveFriendGuildOption
			UIDropDownMenu_AddButton(info, level)

			info.text = L["Guild"]
			info.arg2 = "AutoCompleteGuild"
			info.checked = db.AutoCompleteGuild
			UIDropDownMenu_AddButton(info, level)

			info.text = L["Exclude randoms you interacted with"]
			info.arg2 = "ExcludeRandoms"
			info.checked = db.ExcludeRandoms
			UIDropDownMenu_AddButton(info, level)

			info.text = L["Disable Blizzard's auto-completion popup menu"]
			info.arg2 = "DisableBlizzardAutoComplete"
			info.checked = db.DisableBlizzardAutoComplete
			info.func = Postal.SaveOption
			UIDropDownMenu_AddButton(info, level)
		end
	end
end

