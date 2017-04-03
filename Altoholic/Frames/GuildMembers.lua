local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local WHITE		= "|cFFFFFFFF"
local GRAY		= "|cFFBBBBBB"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"
local LIGHTBLUE = "|cFFB0B0FF"

local view
local viewSortField = "name"
local viewSortOrder
local isViewValid
local expandedHeaders = {}

local PrimaryLevelSort = {	-- sort functions for the mains
	["name"] = function(a, b)
			if viewSortOrder then
				return a.name < b.name
			else
				return a.name > b.name 
			end
		end,
	["level"] = function(a, b)
			local levelA = select(4, DataStore:GetGuildMemberInfo(a.name))
			local levelB = select(4, DataStore:GetGuildMemberInfo(b.name))
			
			levelA = levelA or 0
			levelB = levelB or 0
			
			if viewSortOrder then
				return levelA < levelB
			else
				return levelA > levelB
			end
		end,
	["averageItemLvl"] = function(a, b)
			local guild = DataStore:GetGuild()
			local ailA = DataStore:GetGuildMemberAverageItemLevel(guild, a.name) or 0
			local ailB = DataStore:GetGuildMemberAverageItemLevel(guild, b.name) or 0
			
			if viewSortOrder then
				return ailA < ailB
			else
				return ailA > ailB
			end
		end,
	["version"] = function(a, b)
			local versionA = addon:GetGuildMemberVersion(a.name) or ""
			local versionB = addon:GetGuildMemberVersion(b.name) or ""
			
			if viewSortOrder then
				return versionA < versionB
			else
				return versionA > versionB
			end
		end,
	["englishClass"] = function(a, b)
			local classA = select(11, DataStore:GetGuildMemberInfo(a.name))
			local classB = select(11, DataStore:GetGuildMemberInfo(b.name))
			
			classA = classA or ""
			classB = classB or ""
			
			if viewSortOrder then
				return classA < classB
			else
				return classA > classB
			end
		end,
}

local SecondaryLevelSort = {-- sort functions for the alts
	["name"] = function(a, b)
			if viewSortOrder then
				return a < b
			else
				return a > b
			end
		end,
	["level"] = function(a, b)
			local levelA = select(4, DataStore:GetGuildMemberInfo(a))
			local levelB = select(4, DataStore:GetGuildMemberInfo(b))
			
			if viewSortOrder then
				return levelA < levelB
			else
				return levelA > levelB
			end
		end,
	["averageItemLvl"] = function(a, b)
			local guild = DataStore:GetGuild()
			local ailA = DataStore:GetGuildMemberAverageItemLevel(guild, a) or 0
			local ailB = DataStore:GetGuildMemberAverageItemLevel(guild, b) or 0
			
			if viewSortOrder then
				return ailA < ailB
			else
				return ailA > ailB
			end
		end,
	["version"] = function(a, b)
			local versionA = addon:GetGuildMemberVersion(a) or ""
			local versionB = addon:GetGuildMemberVersion(b) or ""
			
			if viewSortOrder then
				return versionA < versionB
			else
				return versionA > versionB
			end
		end,
	["englishClass"] = function(a, b)
			local classA = select(11, DataStore:GetGuildMemberInfo(a))
			local classB = select(11, DataStore:GetGuildMemberInfo(b))
			
			classA = classA or ""
			classB = classB or ""
			
			if viewSortOrder then
				return classA < classB
			else
				return classA > classB
			end
		end,
}

-- *** Utility functions ***

local NORMALPLAYER_LINE = 0		-- a guild mate who does not use altoholic
local ALTO_MAIN_LINE = 2			-- the currently connected character of a guild mate using altoholic
local ALTO_ALT_LINE = 3				-- an alt belonging to the previous line
local OFFLINEHEADER_LINE = 4
local OFFLINEMEMBER_LINE = 5

local HEADER_LINE = 0				-- line number modulo 2 = 0, it's a header

local function BuildView()
	
	view = view or {}
	wipe(view)
	
	local onlineMembers = {}		-- list of online guild members (and their alts)

	-- 1) Start by adding mains, users of altoholic or not
	for member in pairs(DataStore:GetOnlineGuildMembers()) do
		if addon:GetGuildMemberVersion(member) then			-- altoholic user
			table.insert(view, { lineType = ALTO_MAIN_LINE, name = member } )			-- main character first
		else		-- non altoholic user
			table.insert(view, { lineType = NORMALPLAYER_LINE, name = member } )
		end
		onlineMembers[member] = true
	end
	
	-- 2) sort the highest level
	table.sort(view, PrimaryLevelSort[viewSortField])
	
	-- 3) add the alts whenver applicable
	for index, line in ipairs(view) do
		if line.lineType == ALTO_MAIN_LINE then
			local alts = DataStore:GetGuildMemberAlts(line.name)
			if alts then
				local altsTable = { strsplit("|", alts) }
				
				-- 4) sort the alts on the same criteria
				table.sort(altsTable, SecondaryLevelSort[viewSortField])
			
				local altCount = 1	-- because the insert must be done at index+1 for alt 1, index+2 for alt2, etc..
				for _, altName in ipairs(altsTable) do
					table.insert(view, index + altCount, { lineType = ALTO_ALT_LINE, name = altName } )
					onlineMembers[altName] = true
					altCount = altCount + 1
				end
			end
		end
	end
	
	-- 5) add the header "offline members"
	table.insert(view, {	lineType = OFFLINEHEADER_LINE, name = L["Offline Members"] } )
	
	-- 6) Prepare the list of offline members for which we have data, sort it, then add it to the view
	local offlineMembers = {}

	local guild = DataStore:GetGuild()
	
	for i=1, GetNumGuildMembers(true) do		-- browse all players (online & offline)
		local member = GetGuildRosterInfo(i)
		if not onlineMembers[member] then
			offlineMembers[ #offlineMembers + 1 ] = member
		end		
	end
	
	table.sort(offlineMembers, SecondaryLevelSort[viewSortField])

	for _, member in ipairs(offlineMembers) do
		table.insert(view, {	lineType = OFFLINEMEMBER_LINE, name = member } )
	end
	
	isViewValid = true
end

local EquipmentToFrame = { 1,3,5,9,10,6,7,8,11,12,13,14,15,4,2,19,16,17,18 }

local function LoadEquipmentTextures()
	local itemName
	
	for i = 1, 19 do
		itemName = "AltoholicFrameGuildMembersItem".. i;
		addon:SetItemButtonTexture(itemName, addon.Equipment:GetSlotTexture(EquipmentToFrame[i]));
		_G[itemName]:Show()
	end
end

local function UpdateEquipment(member)
--[[
	button layout				equipment table layout
	
	1	5	9				1	10	11
	2	6	10 				3	6	12
	3	7	11				5	7	13
	4	8	12 				9	8	14
	
	15 13 14 16				2 15 4 19
	
	17 18 19					16 17 18
--]]

	local itemName, itemButton, itemCount
	local guild = DataStore:GetGuild()
	
	for i = 1, 19 do
		itemName = "AltoholicFrameGuildMembersItem".. i;
		itemButton = _G[itemName];
		itemCount = _G[itemName .. "Count"]
		itemCount:Hide();

		addon:CreateButtonBorder(itemButton)
		itemButton.border:Hide()
	
		local itemID = DataStore:GetGuildMemberInventoryItem(guild, member, EquipmentToFrame[i])
		if itemID then
			addon:SetItemButtonTexture(itemName, GetItemIcon(itemID));

			-- set link and id for addon:Item_OnEnter(self)
			if type(itemID) == "string" then
				itemButton.link = itemID
				itemButton.id = addon:GetIDFromLink(itemID)
			elseif type(itemID) == "number" then
				itemButton.id = itemID
				itemButton.link = nil
			end
			
			-- display the coloured border
			local _, _, itemRarity, itemLevel = GetItemInfo(itemID)
			if itemRarity and itemRarity >= 2 then
				local r, g, b = GetItemQualityColor(itemRarity)
				itemButton.border:SetVertexColor(r, g, b, 0.5)
				itemButton.border:Show()
			end
			
			itemCount:SetText(itemLevel);
			itemCount:Show();
		else
			addon:SetItemButtonTexture(itemName, addon.Equipment:GetSlotTexture(EquipmentToFrame[i]));
			itemButton.id = nil
			itemButton.link = nil
		end
		
		itemButton:Show()
	end
end

addon.Guild.Members = {}

local ns = addon.Guild.Members		-- ns = namespace

function ns:Update()
	if AltoholicFrameGuildMembers.InitRequired then
		LoadEquipmentTextures()
		AltoholicFrameGuildMembers.InitRequired = nil
	end

	if not isViewValid then
		BuildView()
	end
	
	local VisibleLines = 14
	local frame = "AltoholicFrameGuildMembers"
	local entry = frame.."Entry"
	
	AltoholicTabSummaryStatus:SetText(L["Click a character's AiL to see its equipment"])
	
	if #view == 0 then
		addon:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 18)
		return
	end
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawAlts
	local i=1
	
	local guild = DataStore:GetGuild()
	
	for lineIndex, v in pairs(view) do
		local lineType = mod(v.lineType, 2)
	
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if v.lineType == NORMALPLAYER_LINE then
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			elseif lineType == HEADER_LINE then							-- then keep track of counters
				if expandedHeaders[v.name] then
					DrawAlts = true
				else
					DrawAlts = false
				end
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			elseif DrawAlts then
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			end
		else		-- line will be displayed
			local member = v.name
			local _, _, _, level, class, _, _, _, _, _, englishClass = DataStore:GetGuildMemberInfo(member)
			level = level or 0
			
			local classText = L["N/A"]
			if class and englishClass then
				classText = format("%s%s", addon:GetClassColor(englishClass), class)
			end
			
			local version = addon:GetGuildMemberVersion(member) or L["N/A"]
			local averageItemLvl = DataStore:GetGuildMemberAverageItemLevel(guild, member) or 0
		
			if v.lineType == NORMALPLAYER_LINE then
				_G[entry..i.."Collapse"]:Hide()
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
				_G[entry..i.."NameNormalText"]:SetText(YELLOW..member)
				_G[entry..i.."Level"]:SetText(GREEN .. level)
				_G[entry..i.."AvgILevelNormalText"]:SetText(YELLOW..format("%.1f", averageItemLvl))
				_G[entry..i.."Version"]:SetText(WHITE..version)
				_G[entry..i.."Class"]:SetText(classText)
				
				_G[ entry..i ].CharName = member
				_G[ entry..i ]:SetID(lineIndex)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
				
			elseif lineType == HEADER_LINE then
				if expandedHeaders[member] then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawAlts = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawAlts = false
				end
				
				if member == L["Offline Members"] then
					level = ""
					version = ""
					classText = ""
				end
				
				_G[entry..i.."Collapse"]:Show()
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 25, 0)
				_G[entry..i.."NameNormalText"]:SetText(YELLOW..member)
				_G[entry..i.."Level"]:SetText(GREEN .. level)
				if member == L["Offline Members"] then
					_G[entry..i.."AvgILevelNormalText"]:SetText("")
				else
					_G[entry..i.."AvgILevelNormalText"]:SetText(YELLOW..format("%.1f", averageItemLvl))
				end
				
				_G[entry..i.."Version"]:SetText(WHITE..version)
				_G[entry..i.."Class"]:SetText(classText)
				
				_G[ entry..i ].CharName = member
				_G[ entry..i ]:SetID(lineIndex)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1

			elseif DrawAlts then
			
				_G[entry..i.."Collapse"]:Hide()
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
				if v.lineType == ALTO_ALT_LINE then
					_G[entry..i.."NameNormalText"]:SetText(LIGHTBLUE..member)
				else
					_G[entry..i.."NameNormalText"]:SetText(GRAY..member)
				end
				_G[entry..i.."Level"]:SetText(GREEN .. level)
				_G[entry..i.."AvgILevelNormalText"]:SetText(YELLOW..format("%.1f", averageItemLvl))
				_G[entry..i.."Version"]:SetText(WHITE..version)
				_G[entry..i.."Class"]:SetText(classText)
				
				_G[ entry..i ].CharName = member
				_G[ entry..i ]:SetID(lineIndex)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			end
		end
	end
	
	while i <= VisibleLines do
		_G[ entry..i ]:SetID(0)
		_G[ entry..i ]:Hide()
		i = i + 1
	end
	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleCount, VisibleLines, 18);
end

function ns:Sort(self, field)
	viewSortField = field
	viewSortOrder = self.ascendingSort
	
	ns:InvalidateView()
end

function ns:Name_OnEnter(self)
	local member = self:GetParent().CharName
	if not member then return end

	local name, rank, rankIndex, _, _, zone, note, officernote, _, _, englishClass = DataStore:GetGuildMemberInfo(member)
	if name ~= member then return end
  
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT");
	AltoTooltip:AddLine(addon:GetClassColor(englishClass) .. member,1,1,1);
	AltoTooltip:AddLine(WHITE .. RANK_COLON .. "|r " .. rank .. GREEN .. " (".. rankIndex .. ")");
	if zone then
		AltoTooltip:AddLine(WHITE .. ZONE_COLON .. "|r " .. zone);
	end
	
	if note then
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddLine(WHITE .. NOTE .. ":");
		AltoTooltip:AddLine(note);
	end
	
	if officernote then
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddLine(WHITE .. GUILD_OFFICER_NOTE .. ":");
		AltoTooltip:AddLine(officernote);
	end

	AltoTooltip:Show();
end

function ns:Level_OnClick(self, button)
	if button ~= "LeftButton" then return end

	local id = self:GetParent():GetID()
	local line = view[id]
	if line.lineType == NORMALPLAYER_LINE then return end
	
	local member = self:GetParent().CharName
	if member then
		DataStore:RequestGuildMemberEquipment(member)
		AltoholicFrameGuildMembers_Name:SetText(member)
	end
end

function ns:Level_OnEnter(self)
	local id = self:GetParent():GetID()
	if id == 0 then return end
	
	local line = view[id]
	local member = line.name
	local _, _, _, _, _, _, _, _, _, _, englishClass = DataStore:GetGuildMemberInfo(member)
	local guild = DataStore:GetGuild()
	local averageItemLvl = DataStore:GetGuildMemberAverageItemLevel(guild, member) or 0
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT");
	AltoTooltip:AddLine(addon:GetClassColor(englishClass) .. member,1,1,1);
	AltoTooltip:AddLine(WHITE .. L["Average Item Level"] ..": " .. GREEN.. format("%.1f", averageItemLvl),1,1,1);

	addon:AiLTooltip()
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(GREEN .. L["Left-click to see this character's equipment"],1,1,1);
	AltoTooltip:Show();
end

function ns:Collapse_OnClick(self)
	local id = self:GetParent():GetID()
	if id == 0 then return end
	
	local line = view[id]
	if expandedHeaders[line.name] then		-- toggle header
		expandedHeaders[line.name] = nil
	else
		expandedHeaders[line.name] = true
	end
	ns:Update()
end

function ns:ToggleView(frame)
	if frame.isCollapsed then	-- collapse all headers
		wipe(expandedHeaders)
	else								-- expand all headers
		for _, line in pairs(view) do
			if mod(line.lineType, 2) == HEADER_LINE then
				expandedHeaders[line.name] = true
			end
		end
	end
	ns:Update()
end

function ns:InvalidateView()
	isViewValid = nil
	if AltoholicFrameGuildMembers:IsVisible() then
		ns:Update()
	end
end
	
function ns:OnRosterUpdate()
	AltoholicTabSummaryMenuItem5:SetText(format("%s %s(%d)", L["Guild Members"], GREEN, GetNumGuildMembers()))
	
	ns:InvalidateView()
	addon.Guild.Professions:InvalidateView()
	addon.Guild.BankTabs:InvalidateView()
--	addon.Tabs.Summary:Refresh()
end

function addon:DATASTORE_PLAYER_EQUIPMENT_RECEIVED(event, sender, character)
	UpdateEquipment(character)
end
