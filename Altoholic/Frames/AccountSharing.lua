local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

Altoholic.Sharing = {}
Altoholic.Sharing.Clients = {}		-- authorized clients
Altoholic.Sharing.Content = {}		-- shared content
Altoholic.Sharing.AvailableContent = {}		-- available content

local THIS_ACCOUNT = "Default"
local WHITE		= "|cFFFFFFFF"
local RED		= "|cFFFF0000"
local GREEN		= "|cFF00FF00"
local LIGHTBLUE = "|cFFB0B0FF"

local AUTH_AUTO	= 1
local AUTH_ASK		= 2
local AUTH_NEVER	= 3

local function FirstCap(s)
	return strupper(s:sub(1,1)) .. strlower(s:sub(2))	-- first letter in cap, the rest lowercase
end

local function GetNumClients()
	return #Altoholic.db.global.Sharing.Clients
end

local function GetClientInfo(index)
	local info = Altoholic.db.global.Sharing.Clients[index]
	if info then
		local name, auth = strsplit("|", info)
		return name, tonumber(auth)
	end
end

local function GetSizeInKB(size)
	return format("%2.1f KB", size / 1024)
end

-- *** Authorized Clients ***

local ClientsScrollFrame_Desc = {
	NumLines = 6,
	LineHeight = 18,
	Frame = "AltoholicFrameSharingClients",
	GetSize = function()
			return #Altoholic.db.global.Sharing.Clients 
		end,
	Update = function(self, offset, entry, desc)
			for i=1, desc.NumLines do
				local line = i + offset
				if line <= desc:GetSize() then
					local name, auth = GetClientInfo(line)
					_G[ entry..i.."NameNormalText" ].name = name
					
					if auth == AUTH_NEVER then
						name = RED..name
					elseif auth == AUTH_AUTO then
						name = GREEN..name
					end
					
					_G[ entry..i.."NameNormalText" ]:SetText(name)
					_G[ entry..i.."Never" ]:SetChecked((auth == AUTH_NEVER) and 1 or nil)
					_G[ entry..i.."Ask" ]:SetChecked((auth == AUTH_ASK) and 1 or nil)
					_G[ entry..i.."Auto" ]:SetChecked((auth == AUTH_AUTO) and 1 or nil)
				
					_G[ entry..i ]:SetID(line)
					_G[ entry..i ]:Show()
				else
					_G[ entry..i.."NameNormalText" ].name = nil
				end
			end
		end,
}

function Altoholic.Sharing.Clients:Update()
	Altoholic:ScrollFrameUpdate(ClientsScrollFrame_Desc)
end

function Altoholic.Sharing.Clients:Add(name)
	if type(name) ~= "string" then return end
	if strlen(name) == 0 then return end
	
	name = FirstCap(name)
	
	local clients = Altoholic.db.global.Sharing.Clients
	local alreadyExists
	
	for _, clientInfo in pairs(clients) do
		local clientName = strsplit("|", clientInfo)
		if clientName == name then
			alreadyExists = true
		end
	end
	
	if not alreadyExists then			-- if this character does not exist, add it
		table.insert(clients, format("%s|%s", name, AUTH_ASK))
	end
end

function Altoholic.Sharing.Clients:Delete(name)
	if type(name) ~= "string" then return end
	
	name = FirstCap(name)
	local clients = Altoholic.db.global.Sharing.Clients
	
	for index, clientInfo in pairs(clients) do
		local clientName = strsplit("|", clientInfo)
		if clientName == name then			-- clear the name if found in the table
			table.remove(clients, index)
			break
		end
	end
end

function Altoholic.Sharing.Clients:Auth_OnClick(self)
	local line = self:GetParent():GetID()
	local name = GetClientInfo(line)
	local clients = Altoholic.db.global.Sharing.Clients
	
	clients[line] = format("%s|%s", name, self:GetID())
	Altoholic.Sharing.Clients:Update()
end

function Altoholic.Sharing.Clients:GetRights(name)
	-- returns the right of a given player
	local clients = Altoholic.db.global.Sharing.Clients
	
	for i = 1, GetNumClients() do
		local clientName, auth = GetClientInfo(i)
		if clientName == name then
			return auth
		end
	end
end


-- *** Shared Content ***

local mandatoryModules = {		-- mandatory modules are sent anyway (if the character is shared, of course)
	"DataStore_Characters",
	"DataStore_Stats",
}

local optionalModules = {		-- this defines the order in which modules should be listed
	"DataStore_Achievements",
	"DataStore_Auctions",
	"DataStore_Containers",
	"DataStore_Crafts",
	"DataStore_Currencies",
	"DataStore_Inventory",
	"DataStore_Mails",
	"DataStore_Pets",
	"DataStore_Quests",
	"DataStore_Reputations",
	"DataStore_Skills",
	"DataStore_Spells",
	"DataStore_Talents",
}

local moduleLabels = {		-- these are the labels
	["DataStore_Achievements"] = ACHIEVEMENT_BUTTON,		-- "Achievements"
	["DataStore_Auctions"] = format("%s & %s", AUCTIONS, BIDS),
--	["DataStore_Characters"] = ,
	["DataStore_Containers"] = L["Containers"],
	["DataStore_Crafts"] = L["Professions"],
	["DataStore_Currencies"] = CURRENCY,
	["DataStore_Inventory"] = L["Equipment"],
	["DataStore_Mails"] = L["Mails"],
	["DataStore_Pets"] = format("%s & %s", COMPANIONS, MOUNTS),
	["DataStore_Quests"] = L["Quests"],
	["DataStore_Reputations"] = L["Reputations"],
	["DataStore_Skills"] = SKILLS,
	["DataStore_Spells"] = SPELLBOOK,
--	["DataStore_Stats"] = ,
	["DataStore_Talents"] = format("%s & %s", TALENTS, GLYPHS),
}


local GUILD_HEADER_LINE				= 1
local GUILD_BANKTAB_LINE			= 2
local CHARACTER_HEADER_LINE		= 3
local CHARACTER_DATASTORE_LINE	= 4
local CLASS_REFDATA_LINE			= 5		-- only for available content, not for shared content view

local function isGuildShared(realm, name)
	local sc = Altoholic.db.global.Sharing.SharedContent
	local index = format("%s.%s.%s", THIS_ACCOUNT, realm, name)

	return sc[index]
end

local function isGuildBankTabShared(realm, name, tabID)
	local sc = Altoholic.db.global.Sharing.SharedContent
	local index = format("%s.%s.%s.%s", THIS_ACCOUNT, realm, name, tabID)

	return sc[index]
end

local function isCharacterShared(key)
	local sc = Altoholic.db.global.Sharing.SharedContent
	return sc[key]
end

local function isCharacterDataShared(key, module)
	local sc = Altoholic.db.global.Sharing.SharedContent
	local index = key .. "." .. module
	
	return sc[index]
end



local ContentCollapsedHeaders			-- a table containing the collapsed headers (character keys)

local ContentScrollFrame_Desc = {
	NumLines = 14,
	LineHeight = 18,
	Frame = "AltoholicFrameSharedContent",
	GetSize = function()
			return #Altoholic.Sharing.Content.view
		end,
	Update = function(self, offset, entry, desc)
			local line, LineDesc
			
			for i=1, desc.NumLines do
				line = i + offset
				local lineData = Altoholic.Sharing.Content.view[line]
				if line <= desc:GetSize() then
					LineDesc = desc.Lines[lineData.linetype]
					LineDesc:DrawCollapseButton(lineData, entry..i)
					LineDesc:DrawCheckBox(lineData, entry..i)
					_G[entry..i.."CheckText"]:SetText(LineDesc:GetText(lineData))
					_G[entry..i.."Check"]:SetPoint("TOPLEFT", LineDesc:GetOffset(lineData), 0)
					_G[ entry..i ]:SetID(line)
					_G[ entry..i ]:Show()
				end
			end
		end,
	Lines = {
		[GUILD_HEADER_LINE] = {
			GetText = function(self, line)
					return format("%s|r / %s", WHITE..line.realm, GREEN..line.name)
				end,
			GetOffset = function(self, line)
					return 20
				end,
			DrawCollapseButton = function(self, line, entry)
					local item = _G[ entry.."Collapse" ]
					local index = format("%s.%s.%s", THIS_ACCOUNT, line.realm, line.name)
					
					if not ContentCollapsedHeaders[index] then
						item:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					else
						item:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					end
					item:Show()
				end,
			DrawCheckBox = function(self, line, entry)
					_G[ entry.."Check" ]:SetChecked(isGuildShared(line.realm, line.name))
				end,
		},
		[GUILD_BANKTAB_LINE] = {
			GetText = function(self, line)
					local DS = DataStore
					local guild = DS:GetGuild(line.name, line.realm)
					local tabName = DS:GetGuildBankTabName(guild, line.tabID)
					
					return tabName
				end,
			GetOffset = function(self, line)
					return 40
				end,
			DrawCollapseButton = function(self, line, entry)
					_G[ entry.."Collapse" ]:Hide()
				end,
			DrawCheckBox = function(self, line, entry)
					_G[ entry.."Check" ]:SetChecked(isGuildBankTabShared(line.realm, line.name, line.tabID))
				end,
		},
		[CHARACTER_HEADER_LINE] = {
			GetText = function(self, line)
					local _, realm, name = strsplit(".", line.key)
					return format("%s|r / %s", WHITE..realm, DataStore:GetColoredCharacterName(line.key))
				end,
			GetOffset = function(self, line)
					return 20
				end,
			DrawCollapseButton = function(self, line, entry)
					local item = _G[ entry.."Collapse" ]
					if not ContentCollapsedHeaders[line.key] then
						item:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					else
						item:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					end
					item:Show()
				end,
			DrawCheckBox = function(self, line, entry)
					_G[ entry.."Check" ]:SetChecked(isCharacterShared(line.key))
				end,
		},
		[CHARACTER_DATASTORE_LINE] = {
			GetText = function(self, line)
					return moduleLabels[line.module]
				end,
			GetOffset = function(self, line)
					return 40
				end,
			DrawCollapseButton = function(self, line, entry)
					_G[ entry.."Collapse" ]:Hide()
				end,
			DrawCheckBox = function(self, line, entry)
					_G[ entry.."Check" ]:SetChecked(isCharacterDataShared(line.key, line.module))
				end,
		},
	},
}


function Altoholic.Sharing.Content:BuildView()
	ContentCollapsedHeaders = ContentCollapsedHeaders or {}
	self.view = self.view or {}
	wipe(self.view)
	
	local DS = DataStore
	for realm in pairs(DS:GetRealms()) do			-- all realms on this account
		for guildName, guild in pairs(DS:GetGuilds(realm)) do		-- add guilds
			table.insert(self.view, { linetype = GUILD_HEADER_LINE, realm = realm, name = guildName } )
			
			local index = format("%s.%s.%s", THIS_ACCOUNT, realm, guildName)
			
			if not ContentCollapsedHeaders[index] then
				for i=1, 6 do		-- add guild bank tabs
					local tabName = DS:GetGuildBankTabName(guild, i)
					if tabName then
						table.insert(self.view, { linetype = GUILD_BANKTAB_LINE, realm = realm, name = guildName, tabID = i } )
					end
				end
			end
		end
	
		for characterName, character in pairs(DS:GetCharacters(realm)) do
			table.insert(self.view, { linetype = CHARACTER_HEADER_LINE, key = character } )
			
			if not ContentCollapsedHeaders[character] then
				for _, v in pairs(optionalModules) do
					table.insert(self.view, { linetype = CHARACTER_DATASTORE_LINE, key = character, module = v } )
				end
			end
		end
	end
end

function Altoholic.Sharing.Content:Update()
	Altoholic:ScrollFrameUpdate(ContentScrollFrame_Desc)
end

function Altoholic.Sharing.Content:Collapse_OnClick(self, button)
	local id = self:GetParent():GetID()
	local self = Altoholic.Sharing.Content
	local line = self.view[id]
	
	local index
	if line.linetype == GUILD_HEADER_LINE then
		index = format("%s.%s.%s", THIS_ACCOUNT, line.realm, line.name)
	elseif line.linetype == CHARACTER_HEADER_LINE then
		index = line.key
	end
	
	if not ContentCollapsedHeaders[index] then
		ContentCollapsedHeaders[index] = true
	else
		ContentCollapsedHeaders[index] = nil
	end
	self:BuildView()
	self:Update()
end

function Altoholic.Sharing.Content:Check_OnClick(self, button)
	local id = self:GetParent():GetID()
	local isChecked = self:GetChecked()
	
	local self = Altoholic.Sharing.Content
	local line = self.view[id]
	
	local sc = Altoholic.db.global.Sharing.SharedContent
	local index
	
	if line.linetype == GUILD_HEADER_LINE then
		index = format("%s.%s.%s", THIS_ACCOUNT, line.realm, line.name)
	elseif line.linetype == GUILD_BANKTAB_LINE then
		index = format("%s.%s.%s.%s", THIS_ACCOUNT, line.realm, line.name, line.tabID)
	elseif line.linetype == CHARACTER_HEADER_LINE then
		index = line.key
	else
		index = line.key .. "." .. line.module
	end
	sc[index] = isChecked
	self:BuildView()
	self:Update()
end

function Altoholic.Sharing.Content:ToggleAll(self, button)
	local tex
	
	if not self.isCollapsed then			-- are all entries collapsed or not ?
		self.isCollapsed = true
		tex = "Interface\\Buttons\\UI-PlusButton-Up"
	else
		self.isCollapsed = nil
		tex = "Interface\\Buttons\\UI-MinusButton-Up"
	end
	self:SetNormalTexture(tex); 
	
	local DS = DataStore
	for realm in pairs(DS:GetRealms()) do			-- all realms on this account
		for guildName, _ in pairs(DS:GetGuilds(realm)) do
			local index = format("%s.%s.%s", THIS_ACCOUNT, realm, guildName)
			ContentCollapsedHeaders[index] = self.isCollapsed
		end
	
		for characterName, character in pairs(DS:GetCharacters(realm)) do
			ContentCollapsedHeaders[character] = self.isCollapsed
		end
	end
		
	local self = Altoholic.Sharing.Content
	self:BuildView()
	self:Update()
end

function Altoholic.Sharing.Content:CheckAll(self, button)
	local sc = Altoholic.db.global.Sharing.SharedContent

	if not self.isChecked then			-- are all entries collapsed or not ?
		self.isChecked = true
	else
		self.isChecked = nil
	end
	self:SetChecked(self.isChecked);
	
	local DS = DataStore
	for realm in pairs(DS:GetRealms()) do			-- all realms on this account
		-- guilds
		for guildName, guild in pairs(DS:GetGuilds(realm)) do
			local index = format("%s.%s.%s", THIS_ACCOUNT, realm, guildName)
			sc[index] = self.isChecked
			
			for i=1, 6 do		-- add guild bank tabs
				if DS:GetGuildBankTabName(guild, i) then
					index = format("%s.%s.%s.%s", THIS_ACCOUNT, realm, guildName, i)
					sc[index] = self.isChecked
				end
			end
		end
	
		-- characters
		for characterName, character in pairs(DS:GetCharacters(realm)) do
			sc[character] = self.isChecked
			
			for _, v in pairs(optionalModules) do
				sc[character .. "." .. v] = self.isChecked
			end
		end
	end

	local self = Altoholic.Sharing.Content
	self:BuildView()
	self:Update()
end

local TOC_SETREALM				= "1"
local TOC_SETGUILD				= "2"
local TOC_BANKTAB					= "3"
local TOC_SETCHAR					= "4"
local TOC_DATASTORE				= "5"
local TOC_REFDATA					= "6"

function Altoholic.Sharing.Content:GetOptionalModuleName(index)
	return optionalModules[index]
end

function Altoholic.Sharing.Content:GetSourceTOC()
	-- prepares the table of content that will be sent to the user requesting account sharing
	
	-- This method adds all realms, all guilds, all characters on the current account, assuming they are shared
	-- Reference data (available classes) is always sent, and mandatory modules in datastore are not sent (they're implicit, if a character is shared, they must be sent)
	
	-- on the receiving side, display mandatory items as part of the list, but greyed out/disabled and automatically selected for transfer
	
	local DS = DataStore
	local serializedData, lastUpdate
	local toc = {}

	for realm in pairs(DS:GetRealms()) do			-- all realms on this account
		table.insert(toc, format("%s|%s", TOC_SETREALM, realm))
	
		for guildName, guild in pairs(DS:GetGuilds(realm)) do		-- add guilds
			if isGuildShared(realm, guildName) then
				table.insert(toc, format("%s|%s", TOC_SETGUILD, guildName))
				
				for tabID = 1, 6 do		-- add guild bank tabs
					local tabName = DS:GetGuildBankTabName(guild, tabID)
					if tabName and isGuildBankTabShared(realm, guildName, tabID) then
						serializedData = Altoholic:Serialize(DS:GetGuildBankTab(guild, tabID))
						lastUpdate = DS:GetGuildBankTabLastUpdate(guild, tabID)
						table.insert(toc, format("%s|%s|%s|%s|%s", TOC_BANKTAB, tabName, tabID, strlen(serializedData), lastUpdate or 0))
					end
				end
			end
		end
	
		for characterName, character in pairs(DS:GetCharacters(realm)) do
			if isCharacterShared(character) then
				-- get the size of mandatory modules
				local size = 0
				for k, module in pairs(mandatoryModules) do
					serializedData = Altoholic:Serialize(DS:GetCharacterTable(module, characterName, realm))
					size = size + strlen(serializedData)
				end
				
				local _, class = DS:GetCharacterClass(character)
				lastUpdate = DS:GetModuleLastUpdate("DataStore_Characters", characterName, realm)
				table.insert(toc, format("%s|%s|%s|%s|%s", TOC_SETCHAR, characterName, class, size, lastUpdate or 0))
				
				
				for k, module in pairs(optionalModules) do
					if isCharacterDataShared(character, module) then
						-- evaluate the size of transferred data
						serializedData = Altoholic:Serialize(DS:GetCharacterTable(module, characterName, realm))
						lastUpdate = DS:GetModuleLastUpdate(module, characterName, realm)
					
						-- only pass the key to the right datastore module (ex 4 for DataStore_Crafts)
						table.insert(toc, format("%s|%s|%s|%s", TOC_DATASTORE, k, strlen(serializedData), lastUpdate or 0))
					end
				end
			end
		end
	end
	
	-- add reference here
	for class, _ in pairs(DS:GetReferenceTable()) do
		serializedData = Altoholic:Serialize(DS:GetClassReference(class))
		table.insert(toc, format("%s|%s|%s", TOC_REFDATA, class, strlen(serializedData)))
	end
	
	return toc
end




-- *** Available Content ***
local AvailableContentCollapsedHeaders			-- a table containing the collapsed headers (character keys)
local AvailableContentCheckedItems				-- a table containing the items checked in the TOC (index = true)

local AvailableContentScrollFrame_Desc = {
	NumLines = 10,
	LineHeight = 18,
	Frame = "AltoholicFrameAvailableContent",
	GetSize = function()
			return #Altoholic.Sharing.AvailableContent.view
		end,
	Update = function(self, offset, entry, desc)
			local line, LineDesc
			
			for i=1, desc.NumLines do
				line = i + offset
				local lineData = Altoholic.Sharing.AvailableContent.view[line]
				if line <= desc:GetSize() then
					LineDesc = desc.Lines[lineData.linetype]
					LineDesc:DrawCollapseButton(lineData, entry..i)
					_G[entry..i.."CheckText"]:SetText(LineDesc:GetText(lineData))
					_G[entry..i.."Check"]:SetPoint("TOPLEFT", LineDesc:GetOffset(lineData), 0)
					_G[entry..i.."Check"]:SetID(lineData.parentID)
					_G[entry..i.."Check"]:SetChecked(AvailableContentCheckedItems[lineData.parentID])
					
					if lineData.size then
						_G[entry..i.."Size"]:SetText(LIGHTBLUE..GetSizeInKB(lineData.size))
						_G[entry..i.."Size"]:Show()
					else
						_G[entry..i.."Size"]:Hide()
					end
					
					if lineData.lastUpdate then
						local text
						if lineData.lastUpdate == 0 then
							text = RED..NEVER
						else
							text = LineDesc:GetDate(lineData)
						end
					
						_G[entry..i.."Date"]:SetText(text)
						_G[entry..i.."Date"]:Show()
					else
						_G[entry..i.."Date"]:Hide()
					end
					
					_G[ entry..i ]:SetID(line)
					_G[ entry..i ]:Show()
				end
			end
		end,
	Lines = {
		[GUILD_HEADER_LINE] = {
			GetText = function(self, line)
					return format("%s|r / %s", WHITE..line.realm, GREEN..line.name)
				end,
			GetOffset = function(self, line)
					return 20
				end,
			DrawCollapseButton = function(self, line, entry)
					local item = _G[ entry.."Collapse" ]
					local index = format("%s.%s.%s", Altoholic.Comm.Sharing:GetAccount(), line.realm, line.name)
					
					if not AvailableContentCollapsedHeaders[index] then
						item:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					else
						item:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					end
					item:Show()
				end,
			GetDate = function(self, line)
					return LIGHTBLUE..date("%m/%d/%Y %H:%M", line.lastUpdate)
				end,
		},
		[GUILD_BANKTAB_LINE] = {
			GetText = function(self, line)
					return line.tabName
				end,
			GetOffset = function(self, line)
					return 40
				end,
			DrawCollapseButton = function(self, line, entry)
					_G[ entry.."Collapse" ]:Hide()
				end,
			GetDate = function(self, line)
					return LIGHTBLUE..date("%m/%d/%Y %H:%M", line.lastUpdate)
				end,
		},
		[CHARACTER_HEADER_LINE] = {
			GetText = function(self, line)
					local _, realm, name = strsplit(".", line.key)
					name = Altoholic:GetClassColor(line.class) ..name
					return format("%s|r / %s", WHITE..realm, name)
				end,
			GetOffset = function(self, line)
					return 20
				end,
			DrawCollapseButton = function(self, line, entry)
					local item = _G[ entry.."Collapse" ]
					if not AvailableContentCollapsedHeaders[line.key] then
						item:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					else
						item:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					end
					item:Show()
				end,
			GetDate = function(self, line)
					local account, realm, name = strsplit(".", line.key)
					local last = DataStore:GetModuleLastUpdate("DataStore_Characters", name, realm, account)
					
					if last == line.lastUpdate then
						return GREEN.."Up-to-date"
					else
						return LIGHTBLUE..date("%m/%d/%Y %H:%M", line.lastUpdate)
					end
				end,
		},
		[CHARACTER_DATASTORE_LINE] = {
			GetText = function(self, line)
					return moduleLabels[line.module]
				end,
			GetOffset = function(self, line)
					return 40
				end,
			DrawCollapseButton = function(self, line, entry)
					_G[ entry.."Collapse" ]:Hide()
				end,
			GetDate = function(self, line)
					local account, realm, name = strsplit(".", line.key)
					local last = DataStore:GetModuleLastUpdate(line.module, name, realm, account)
					
					if last == line.lastUpdate then
						return GREEN.."Up-to-date"
					else
						return LIGHTBLUE..date("%m/%d/%Y %H:%M", line.lastUpdate)
					end
				end,
		},
		[CLASS_REFDATA_LINE] = {
			GetText = function(self, line)
					return "Talent Tree Reference : " .. FirstCap(line.class)
				end,
			GetOffset = function(self, line)
					return 20
				end,
			DrawCollapseButton = function(self, line, entry)
					_G[ entry.."Collapse" ]:Hide()
				end,
			GetDate = function(self, line)
					return LIGHTBLUE..date("%m/%d/%Y %H:%M", line.lastUpdate)
				end,
		},
	},
}


function Altoholic.Sharing.AvailableContent:BuildView()
	AvailableContentCollapsedHeaders = AvailableContentCollapsedHeaders or {}
	AvailableContentCheckedItems = AvailableContentCheckedItems or {}
	self.view = self.view or {}
	wipe(self.view)
	
	local sharing = Altoholic.Comm.Sharing
	self.ToC = sharing.DestTOC
	if not self.ToC then return end
	
	local account = sharing:GetAccount()
	local realm, character, guildName
	
	for i = 1, #self.ToC do
		local tocType, arg1, arg2, arg3, arg4 = strsplit("|", self.ToC[i])
		
		if tocType == TOC_SETREALM then
			realm = arg1
		elseif tocType == TOC_SETGUILD then
			guildName = arg1
			table.insert(self.view, { linetype = GUILD_HEADER_LINE, realm = realm, name = guildName, parentID = i } )
		elseif tocType == TOC_BANKTAB then
			local index = format("%s.%s.%s", account, realm, guildName)
			if not AvailableContentCollapsedHeaders[index] then
				table.insert(self.view, { 
					linetype = GUILD_BANKTAB_LINE, 
					tabName = arg1, 
					tabID = tonumber(arg2), 
					size = tonumber(arg3),
					lastUpdate = tonumber(arg4),
					parentID = i,
				} )
			end
		elseif tocType == TOC_SETCHAR then
			character = format("%s.%s.%s", account, realm, arg1)
			table.insert(self.view, { 
				linetype = CHARACTER_HEADER_LINE, 
				key = character, 
				class = arg2, 
				size = tonumber(arg3),
				lastUpdate = tonumber(arg4),
				parentID = i,
			} )
		elseif tocType == TOC_DATASTORE then
			if not AvailableContentCollapsedHeaders[character] then
				table.insert(self.view, { 
					linetype = CHARACTER_DATASTORE_LINE, 
					key = character, 
					module = optionalModules[tonumber(arg1)],
					size = tonumber(arg2),
					lastUpdate = tonumber(arg3),
					parentID = i,
				} )
			end
		elseif tocType == TOC_REFDATA then
			if not DataStore:IsClassKnown(arg1) then		-- filter to only list classes that are not yet available
				table.insert(self.view, { linetype = CLASS_REFDATA_LINE, class = arg1, size = tonumber(arg2), parentID = i } )
			end
		end
	end
end

function Altoholic.Sharing.AvailableContent:Update()
	Altoholic:ScrollFrameUpdate(AvailableContentScrollFrame_Desc)
end

function Altoholic.Sharing.AvailableContent:Collapse_OnClick(self, button)
	local id = self:GetParent():GetID()
	local content = Altoholic.Sharing.AvailableContent
	local line = content.view[id]
	
	local index
	if line.linetype == GUILD_HEADER_LINE then
		index = format("%s.%s.%s", Altoholic.Comm.Sharing:GetAccount(), line.realm, line.name)
	elseif line.linetype == CHARACTER_HEADER_LINE then
		index = line.key
	end
	
	if not AvailableContentCollapsedHeaders[index] then
		AvailableContentCollapsedHeaders[index] = true
	else
		AvailableContentCollapsedHeaders[index] = nil
	end
	content:BuildView()
	content:Update()
end

function Altoholic.Sharing.AvailableContent:Check_OnClick(self, button)
	local id = self:GetID()
	
	if not AvailableContentCheckedItems[id] then
		AvailableContentCheckedItems[id] = true
	else
		AvailableContentCheckedItems[id] = nil
	end
end

function Altoholic.Sharing.AvailableContent:ToggleAll(self, button)
	local tex
	
	if not self.isCollapsed then			-- are all entries collapsed or not ?
		self.isCollapsed = true
		tex = "Interface\\Buttons\\UI-PlusButton-Up"
	else
		self.isCollapsed = nil
		tex = "Interface\\Buttons\\UI-MinusButton-Up"
	end
	self:SetNormalTexture(tex); 
	
	local content = Altoholic.Sharing.AvailableContent
	if not content.view then return end
	
	for k, v in pairs(content.view) do			-- parse the whole view
		local index
		if v.linetype == GUILD_HEADER_LINE then			-- get the right index in lines that actually require it
			index = format("%s.%s.%s", Altoholic.Comm.Sharing:GetAccount(), v.realm, v.name)
		elseif v.linetype == CHARACTER_HEADER_LINE then
			index = v.key
		end

		if index then
			AvailableContentCollapsedHeaders[index] = self.isCollapsed
		end
	end
		
	content:BuildView()
	content:Update()
end

function Altoholic.Sharing.AvailableContent:CheckAll(self, button)
	if not self.isChecked then			-- are all entries collapsed or not ?
		self.isChecked = true
	else
		self.isChecked = nil
	end
	self:SetChecked(self.isChecked);
	
	local content = Altoholic.Sharing.AvailableContent
	if not content.view then return end
	
	for k, v in pairs(content.view) do			-- parse the whole view
		AvailableContentCheckedItems[v.parentID] = self.isChecked	-- check or uncheck all
	end

	local self = Altoholic.Sharing.AvailableContent
	self:BuildView()
	self:Update()
end

function Altoholic.Sharing.AvailableContent:IsItemChecked(index)
	if self.ToC then
		local TocData = self.ToC[index]
		if TocData then
			local TocType = strsplit("|", TocData)
					
			if TocType == TOC_SETREALM then
				-- until I have more time to implement a fancier solution, always return true for realm lines, necessary to correctly switch realms when importing data from foreign realms
				return true
			end
		end
	end

	return AvailableContentCheckedItems[index]
end

function Altoholic.Sharing.AvailableContent:Clear()
	-- clear command, after a successful transfer
	
	wipe(AvailableContentCollapsedHeaders)
	wipe(AvailableContentCheckedItems)
	
	self:BuildView()
	self:Update()
end
