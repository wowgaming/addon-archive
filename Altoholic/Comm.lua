local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
-- local LibComp = LibStub:GetLibrary("LibCompress")

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"

Altoholic.Comm = {}

-- Message types
local MSG_ACCOUNT_SHARING_REQUEST			= 1
local MSG_ACCOUNT_SHARING_REFUSED			= 2
local MSG_ACCOUNT_SHARING_REFUSEDINCOMBAT	= 3
local MSG_ACCOUNT_SHARING_REFUSEDDISABLED	= 4
local MSG_ACCOUNT_SHARING_ACCEPTED			= 5
local MSG_ACCOUNT_SHARING_SENDITEM			= 6
local MSG_ACCOUNT_SHARING_COMPLETED			= 7
local MSG_ACCOUNT_SHARING_ACK					= 8	-- a simple ACK message, confirms message has been received, but no data is sent back

local CMD_DATASTORE_XFER			= 100
local CMD_DATASTORE_CHAR_XFER		= 101		-- these 2 require a special treatment
local CMD_DATASTORE_STAT_XFER		= 102
local CMD_BANKTAB_XFER				= 103
local CMD_REFDATA_XFER				= 104


local TOC_SEP = "|"	-- separator used between items

-- TOC Item Types
local TOC_SETREALM				= "1"
local TOC_SETGUILD				= "2"
local TOC_BANKTAB					= "3"
local TOC_SETCHAR					= "4"
local TOC_DATASTORE				= "5"
local TOC_REFDATA					= "6"



--[[	*** Protocol ***

Client				Server

==> MSG_ACCOUNT_SHARING_REQUEST 
<== MSG_ACCOUNT_SHARING_REFUSED (stop)   
or 
<== MSG_ACCOUNT_SHARING_ACCEPTED (receives the TOC)

while toc not empty
==> MSG_ACCOUNT_SHARING_SENDNEXT (pass the type, based on the TOC)
<== CMD_??? (transfer & save data)
wend

==> MSG_ACCOUNT_SHARING_COMPLETED

--]]

Altoholic.Comm.Sharing = {}
Altoholic.Comm.Sharing.Callbacks = {
	[MSG_ACCOUNT_SHARING_REQUEST] = "OnSharingRequest",
	[MSG_ACCOUNT_SHARING_REFUSED] = "OnSharingRefused",
	[MSG_ACCOUNT_SHARING_REFUSEDINCOMBAT] = "OnPlayerInCombat",
	[MSG_ACCOUNT_SHARING_REFUSEDDISABLED] = "OnSharingDisabled",
	[MSG_ACCOUNT_SHARING_ACCEPTED] = "OnSharingAccepted",
	[MSG_ACCOUNT_SHARING_SENDITEM] = "OnSendItemReceived",
	[MSG_ACCOUNT_SHARING_COMPLETED] = "OnSharingCompleted",
	[MSG_ACCOUNT_SHARING_ACK] = "OnAckReceived",

	[CMD_DATASTORE_XFER] = "OnDataStoreReceived",
	[CMD_DATASTORE_CHAR_XFER] = "OnDataStoreCharReceived",
	[CMD_DATASTORE_STAT_XFER] = "OnDataStoreStatReceived",
	[CMD_BANKTAB_XFER] = "OnGuildBankTabReceived",
	[CMD_REFDATA_XFER] = "OnRefDataReceived",
}

local compressionMode = 1
local importedChars

local function Whisper(player, messageType, ...)
	local serializedData = Altoholic:Serialize(messageType, ...)
	--DEFAULT_CHAT_FRAME:AddMessage(strlen(serializedData))
	
	-- if compressionMode == 1 then				-- no comp
		Altoholic:SendCommMessage("AltoShare", serializedData, "WHISPER", player)
		
	-- elseif compressionMode == 2 then		-- comp huff
		-- local compData = LibComp:CompressHuffman(serializedData)
		
		-- local ser, comp
		-- ser = strlen(serializedData)
		-- comp = strlen(compData)
		-- DEFAULT_CHAT_FRAME:AddMessage(format("Compression (%d/%d) : %2.1f", ser, comp, (comp/ser)*100))
		
		-- Altoholic:SendCommMessage("AltoShare", compData, "WHISPER", player)

	-- elseif compressionMode == 3 then		-- comp lzw
		-- local compData = LibComp:CompressLZW(serializedData)
		
		-- local ser, comp
		-- ser = strlen(serializedData)
		-- comp = strlen(compData)
		-- DEFAULT_CHAT_FRAME:AddMessage(format("Compression (%d/%d) : %2.1f", ser, comp, (comp/ser)*100))
		
		-- Altoholic:SendCommMessage("AltoShare", compData, "WHISPER", player)
	-- end
end

local function GetRequestee()
	local player	-- name of the player to whom the account sharing request will be sent
	
	if AltoAccountSharing_UseTarget:GetChecked() then
		player = UnitName("target")
	elseif AltoAccountSharing_UseName:GetChecked() then
		player = AltoAccountSharing_AccTargetEditBox:GetText()
	end

	if player and strlen(player) > 0 then
		return player
	end
end

local function SetStatus(text)
	AltoAccountSharingTransferStatus:SetText(text)
end

function Altoholic:AccSharingHandler(prefix, message, distribution, sender)
	-- 	since Ace 3 communication handlers cannot be enabled/disabled on the fly, 
	--	let's use a function pointer to either an empty function, or the normal one
	local self = Altoholic.Comm.Sharing

	if self and self.msgHandler then
		self[self.msgHandler](self, prefix, message, distribution, sender)
	end
end

function Altoholic.Comm.Sharing:SetMessageHandler(handler)
	self.msgHandler = handler
end

function Altoholic.Comm.Sharing:EmptyHandler(prefix, message, distribution, sender)
	-- automatically reply that the option is disabled
	Whisper(sender, MSG_ACCOUNT_SHARING_REFUSEDDISABLED)
end

function Altoholic.Comm.Sharing:ActiveHandler(prefix, message, distribution, sender)
	local success, msgType, msgData
	
	if compressionMode == 1 then	
		success, msgType, msgData = Altoholic:Deserialize(message)
--	else
--		local decompData = LibComp:Decompress(message)
--		success, msgType, msgData = Altoholic:Deserialize(decompData)
	end
	
	if not success then
		self.SharingEnabled = nil
		-- self:Print(msgType)
		-- self:Print(string.sub(decompData, 1, 15))
		return
	end
	
	if success and msgType then
		local comm = Altoholic.Comm.Sharing
		local cb = comm.Callbacks[msgType]
		
		if cb then
			comm[cb](self, sender, msgData)		-- process the message
		end
	end
end

function Altoholic.Comm.Sharing:Request()

	local account = AltoAccountSharing_AccNameEditBox:GetText()
	if not account or strlen(account) == 0 then 		-- account name cannot be empty
		Altoholic:Print("[" .. L["Account Name"] .. "] " .. L["This field |cFF00FF00cannot|r be left empty."])
		return 
	end
	
	self.account = account

	local player = GetRequestee()
	if player then
		self.SharingInProgress = true
		-- AltoAccountSharing:Hide()
		-- Altoholic:Print(format(L["Sending account sharing request to %s"], player))
		SetStatus(format("Getting table of content from %s", player))
		Whisper(player, MSG_ACCOUNT_SHARING_REQUEST)
	end
end

local function ImportCharacters()
	-- once data has been transfered, finalize the import by acknowledging that these alts can be seen by client addons
	-- will be changed when account sharing goes into datastore.
	for k, v in pairs(importedChars) do
		DataStore:ImportCharacter(k, v.faction, v.guild)
	end
	importedChars = nil
end

function Altoholic.Comm.Sharing:RequestNext(player)
	self.NetDestCurItem = self.NetDestCurItem + 1
	local index = self.NetDestCurItem

	-- find the next checked item
	local isChecked = Altoholic.Sharing.AvailableContent:IsItemChecked(index)
	while not isChecked and index <= #self.DestTOC do
		index = index + 1
		isChecked = Altoholic.Sharing.AvailableContent:IsItemChecked(index)
	end

	if isChecked and index <= #self.DestTOC then
		SetStatus(format("Transfering item %d/%d", index, #self.DestTOC ))
		local TocData = self.DestTOC[index]
		
		local TocType = strsplit(TOC_SEP, TocData)
			
		if TocType == TOC_SETREALM then
			_, self.ClientRealmName = strsplit(TOC_SEP, TocData)
		elseif TocType == TOC_SETGUILD then
			_, self.ClientGuildName = strsplit(TOC_SEP, TocData)
			
		elseif TocType == TOC_BANKTAB then
		elseif TocType == TOC_SETCHAR then
			_, self.ClientCharName = strsplit(TOC_SEP, TocData)
			
		elseif TocType == TOC_DATASTORE then
			
		elseif TocType == TOC_REFDATA then
		end
		
		Whisper(player, MSG_ACCOUNT_SHARING_SENDITEM, index)
		self.NetDestCurItem = index
		return
	end

	ImportCharacters()
	SetStatus(L["Transfer complete"])
	Whisper(player, MSG_ACCOUNT_SHARING_COMPLETED)

	wipe(self.DestTOC)
	self.DestTOC = nil
	
	self.SharingInProgress = nil
	self.SharingEnabled = nil
	self.NetDestCurItem = nil
	self.ClientRealmName = nil
	self.ClientGuildName = nil
	self.ClientCharName = nil
	
	Altoholic.Sharing.AvailableContent:Clear()
	self:SetMode(1)
	
	Altoholic:SetLastAccountSharingInfo(player, GetRealmName(), self.account)
	
	Altoholic.Characters:BuildList()
	Altoholic.Characters:BuildView()
	Altoholic.Tabs.Summary:Refresh()
end

function Altoholic.Comm.Sharing:MsgBoxHandler(button)

	local self = Altoholic.Comm.Sharing
	
	AltoMsgBox.ButtonHandler = nil		-- prevent any other call to msgbox from coming back here
	local sender = AltoMsgBox.Sender
	AltoMsgBox.Sender = nil
	
	if not button then 
		Whisper(sender, MSG_ACCOUNT_SHARING_REFUSED)
		return 
	end

	self:SendSourceTOC(sender)
end

local AUTH_AUTO	= 1
local AUTH_ASK		= 2
local AUTH_NEVER	= 3

function Altoholic.Comm.Sharing:OnSharingRequest(sender, data)
	self.SharingEnabled = nil
	
	if UnitAffectingCombat("player") ~= nil then
		-- automatically reject if requestee is in combat
		Whisper(sender, MSG_ACCOUNT_SHARING_REFUSEDINCOMBAT)
		return
	end
	
	local auth = Altoholic.Sharing.Clients:GetRights(sender)
	
	if not auth then		-- if the sender is not a known client, add him with defaults rights (=ask)
		Altoholic.Sharing.Clients:Add(sender)
		auth = AUTH_ASK
	end
	
	if auth == AUTH_AUTO then
		self:SendSourceTOC(sender)
	elseif auth == AUTH_ASK then
		Altoholic:Print(format(L["Account sharing request received from %s"], sender))
		AltoMsgBox:SetHeight(130)
		AltoMsgBox_Text:SetHeight(60)
		AltoMsgBox.ButtonHandler = Altoholic.Comm.Sharing.MsgBoxHandler
		AltoMsgBox.Sender = sender
		AltoMsgBox_Text:SetText(format(L["You have received an account sharing request\nfrom %s%s|r, accept it?"], WHITE, sender) .. "\n\n"
								.. format(L["%sWarning:|r if you accept, %sALL|r information known\nby Altoholic will be sent to %s%s|r (bags, money, etc..)"], WHITE, GREEN, WHITE,sender))
		AltoMsgBox:Show()
	elseif auth == AUTH_NEVER then
		Whisper(sender, MSG_ACCOUNT_SHARING_REFUSED)
	end
end

function Altoholic.Comm.Sharing:SendSourceTOC(sender)
	self.SharingEnabled = true
	self.SourceTOC = Altoholic.Sharing.Content:GetSourceTOC()
	-- self.NetSrcCurItem = 0					-- to display that item is 1 of x
	self.AuthorizedRecipient = sender
	Altoholic:Print(format(L["Sending table of content (%d items)"], #self.SourceTOC))
	Whisper(sender, MSG_ACCOUNT_SHARING_ACCEPTED, self.SourceTOC)
end

function Altoholic.Comm.Sharing:GetContent()
	local player = GetRequestee()
	if player then
		self:SetMode(3)
		self:RequestNext(player)
	end
end

function Altoholic.Comm.Sharing:GetAccount()
	return self.account
end

function Altoholic.Comm.Sharing:SetMode(mode)
	local button = AltoAccountSharing_SendButton
	if mode == 1 then			-- send request, expect toc in return
		button:SetText("Send Request")
		button:Enable()
		button.requestMode = nil	
	elseif mode == 2 then	-- request content, get data in return
		button:SetText("Request Content")
		button:Enable()
		button.requestMode = true	
	elseif mode == 3 then
		importedChars = importedChars or {}
		wipe(importedChars)
		button:Disable()
	end
end

function Altoholic.Comm.Sharing:OnSharingRefused(sender, data)
	SetStatus(format(L["Request rejected by %s"], sender))
	self.SharingInProgress = nil
end

function Altoholic.Comm.Sharing:OnPlayerInCombat(sender, data)
	SetStatus(format(L["%s is in combat, request cancelled"], sender))
	self.SharingInProgress = nil
end

function Altoholic.Comm.Sharing:OnSharingDisabled(sender, data)
	SetStatus(format(L["%s has disabled account sharing"], sender))
	self.SharingInProgress = nil
end

function Altoholic.Comm.Sharing:OnSharingAccepted(sender, data)
	self.DestTOC = data
	self.NetDestCurItem = 0
	SetStatus(format(L["Table of content received (%d items)"], #self.DestTOC))
	
	-- build & refresh the scroll frame
	Altoholic.Sharing.AvailableContent:BuildView()
	Altoholic.Sharing.AvailableContent:Update()
	
	-- change the text on the 'send' button 
	self:SetMode(2)
end

-- Send Content
function Altoholic.Comm.Sharing:OnSendItemReceived(sender, data)
	-- Server side, a request to send a given item is processed here
	if not self.SharingEnabled or not self.AuthorizedRecipient then
		return
	end
	
	local DS = DataStore
	local index = tonumber(data)		-- get the index of the item in the toc
		
	local TocData = self.SourceTOC[index]
	local TocType = strsplit(TOC_SEP, TocData)		-- get its type
		
	if TocType == TOC_SETREALM then
		_, self.ServerRealmName = strsplit(TOC_SEP, TocData)
		Whisper(self.AuthorizedRecipient, MSG_ACCOUNT_SHARING_ACK)
	elseif TocType == TOC_SETGUILD then
		_, self.ServerGuildName = strsplit(TOC_SEP, TocData)
		Whisper(self.AuthorizedRecipient, MSG_ACCOUNT_SHARING_ACK)
	elseif TocType == TOC_BANKTAB then
		local _, _, tabID = strsplit(TOC_SEP, TocData)
		tabID = tonumber(tabID)
		local guild = DS:GetGuild(self.ServerGuildName, self.ServerRealmName)
		Whisper(self.AuthorizedRecipient, CMD_BANKTAB_XFER, DS:GetGuildBankTab(guild, tabID))
	elseif TocType == TOC_SETCHAR then		-- character ? send mandatory modules (char definition = DS_Char + DS_Stats)
		_, self.ServerCharacterName = strsplit(TOC_SEP, TocData)
		Whisper(self.AuthorizedRecipient, CMD_DATASTORE_CHAR_XFER, DS:GetCharacterTable("DataStore_Characters", self.ServerCharacterName, self.ServerRealmName))
		Whisper(self.AuthorizedRecipient, CMD_DATASTORE_STAT_XFER, DS:GetCharacterTable("DataStore_Stats", self.ServerCharacterName, self.ServerRealmName))
	
	elseif TocType == TOC_DATASTORE then	-- DS ? Send the appropriate DS module
		local _, moduleID = strsplit(TOC_SEP, TocData)
		local moduleName = Altoholic.Sharing.Content:GetOptionalModuleName(tonumber(moduleID))
		Whisper(self.AuthorizedRecipient, CMD_DATASTORE_XFER, DS:GetCharacterTable(moduleName, self.ServerCharacterName, self.ServerRealmName))
		
	elseif TocType == TOC_REFDATA then
		local _, class = strsplit(TOC_SEP, TocData)
		Whisper(self.AuthorizedRecipient, CMD_REFDATA_XFER, DS:GetClassReference(class))
	end
end

function Altoholic.Comm.Sharing:OnSharingCompleted(sender, data)
	self.SharingEnabled = nil
	self.AuthorizedRecipient = nil
	self.ServerRealmName = nil
	self.ServerGuildName = nil
	self.ServerCharacterName = nil
	wipe(self.SourceTOC)
	
	self.SourceTOC = nil
	Altoholic:Print(L["Transfer complete"])
end

function Altoholic.Comm.Sharing:OnAckReceived(sender, data)
	self:RequestNext(sender)
end


-- Receive content
function Altoholic.Comm.Sharing:OnDataStoreReceived(sender, data)
	local TocData = self.DestTOC[self.NetDestCurItem]
	local _, moduleID = strsplit(TOC_SEP, TocData)
	local moduleName = Altoholic.Sharing.Content:GetOptionalModuleName(tonumber(moduleID))
	
	DataStore:ImportData(moduleName, data, self.ClientCharName, self.ClientRealmName, self.account)
	self:RequestNext(sender)
end

function Altoholic.Comm.Sharing:OnDataStoreCharReceived(sender, data)
	DataStore:ImportData("DataStore_Characters", data, self.ClientCharName, self.ClientRealmName, self.account)

	-- temporarily deal with this here, will be changed when account sharing goes to  DataStore.
	local key = format("%s.%s.%s", self.account, self.ClientRealmName, self.ClientCharName)
	
	importedChars[key] = {}
	importedChars[key].faction = data.faction
	importedChars[key].guild = data.guildName
	
	-- NO REQUEST NEXT HERE !!
end

function Altoholic.Comm.Sharing:OnDataStoreStatReceived(sender, data)
	DataStore:ImportData("DataStore_Stats", data, self.ClientCharName, self.ClientRealmName, self.account)
	-- Request next, to resume transfer after processing mandatory data
	self:RequestNext(sender)
end

function Altoholic.Comm.Sharing:OnGuildBankTabReceived(sender, data)
	local TocData = self.DestTOC[self.NetDestCurItem]
	local _, _, tabID = strsplit(TOC_SEP, TocData)
	tabID = tonumber(tabID)
	
	local DS = DataStore
	local guild	= DS:GetGuild(self.ClientGuildName, self.ClientRealmName)
	
	DS:ImportGuildBankTab(guild, tabID, data)
	self:RequestNext(sender)
end

function Altoholic.Comm.Sharing:OnRefDataReceived(sender, data)
	local TocData = self.DestTOC[self.NetDestCurItem]
	local _, class = strsplit(TOC_SEP, TocData)
	
	DataStore:ImportClassReference(class, data)
--	Altoholic:Print(format(L["Reference data received (%s) !"], class))
	self:RequestNext(sender)
end


-- *** DataStore Event Handlers ***
function addon:DATASTORE_BANKTAB_REQUESTED(event, sender, tabName)
	if addon.Options:Get("GuildBankAutoUpdate") == 1 then
		DataStore:SendBankTabToGuildMember(sender, tabName)
		return
	end

	AltoMsgBox:SetHeight(130)
	AltoMsgBox_Text:SetHeight(60)
	
	addon:SetMsgBoxHandler(function(self, button, sender, tabName)
			if not button then 
				DataStore:RejectBankTabRequest(sender)
			else
				DataStore:SendBankTabToGuildMember(sender, tabName)
			end
		end, sender, tabName)
	
	AltoMsgBox_Text:SetText(format(L["%s%s|r has requested the bank tab %s%s|r\nSend this information ?"], WHITE, sender, WHITE, tabName) .. "\n\n"
							.. format(L["%sWarning:|r make sure this user may view this information before accepting"], WHITE))
	AltoMsgBox:Show()
end

function addon:DATASTORE_BANKTAB_REQUEST_ACK(event, sender)
	addon:Print(format(L["Waiting for %s to accept .."], sender))
end

function addon:DATASTORE_BANKTAB_REQUEST_REJECTED(event, sender)
	addon:Print(format(L["Request rejected by %s"], sender))
end

function addon:DATASTORE_BANKTAB_UPDATE_SUCCESS(event, sender, guildName, tabName, tabID)
	addon.Tabs.GuildBank:LoadGuild("Default", GetRealmName(), guildName)
	addon:Print(format(L["Guild bank tab %s successfully updated !"], tabName ))
	addon.Guild.BankTabs:InvalidateView()
end

function addon:DATASTORE_GUILD_ALTS_RECEIVED(event, sender, alts)
	addon.Guild.Members:InvalidateView()
	addon.Guild.Professions:InvalidateView()
end

function addon:DATASTORE_GUILD_BANKTABS_UPDATED(event, sender)
	addon.Guild.BankTabs:InvalidateView()
end

function addon:DATASTORE_GUILD_PROFESSION_RECEIVED(event, sender, alt, data, index)
	addon.Guild.Professions:InvalidateView()
end

function addon:DATASTORE_GUILD_MEMBER_OFFLINE(event, member)
	addon.Guild.Members:InvalidateView()
	addon.Guild.Professions:InvalidateView()
end

function addon:DATASTORE_GUILD_MAIL_RECEIVED(event, sender, recipient)
	if addon.Options:Get("GuildMailWarning") == 1 then
		addon:Print(format(L["%s|r has received a mail from %s"], GREEN..recipient, GREEN..sender))
	end
end
