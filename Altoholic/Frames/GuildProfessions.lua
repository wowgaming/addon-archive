local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local WHITE		= "|cFFFFFFFF"
local GRAY		= "|cFFBBBBBB"
local GREEN		= "|cFF00FF00"
local LIGHTBLUE = "|cFFB0B0FF"
local YELLOW	= "|cFFFFFF00"

local view
local viewSortField = "name"
local viewSortOrder
local viewSortArg1
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
			
			if viewSortOrder then
				return levelA < levelB
			else
				return levelA > levelB
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
	["profLink"] = function(a, b)
			local guild = DataStore:GetGuild()
			local link

			_, link = DataStore:GetGuildMemberProfession(guild, a.name, viewSortArg1)
			local levelA = DataStore:GetProfessionInfo(link)
			_, link = DataStore:GetGuildMemberProfession(guild, b.name, viewSortArg1)
			local levelB = DataStore:GetProfessionInfo(link)

			levelA = levelA or 0
			levelB = levelB or 0
			
			if viewSortOrder then
				return levelA < levelB
			else
				return levelA > levelB
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
	["profLink"] = function(a, b)
			local guild = DataStore:GetGuild()
			local link

			_, link = DataStore:GetGuildMemberProfession(guild, a, viewSortArg1)
			local levelA = DataStore:GetProfessionInfo(link)
			_, link = DataStore:GetGuildMemberProfession(guild, b, viewSortArg1)
			local levelB = DataStore:GetProfessionInfo(link)

			levelA = levelA or 0
			levelB = levelB or 0
			
			if viewSortOrder then
				return levelA < levelB
			else
				return levelA > levelB
			end
		end,
}

local ALTO_MAIN_LINE = 0			-- the currently connected character of a guild mate using altoholic
local ALTO_ALT_LINE = 1				-- an alt belonging to the previous line
local OFFLINEHEADER_LINE = 2
local OFFLINEMEMBER_LINE = 3

local HEADER_LINE = 0				-- line number modulo 2 = 0, it's a header

local function BuildView()
	view = view or {}
	wipe(view)
	
	local altoOnlineMembers = {}		-- list of online guild members for which we have professions

	-- 1) Start by adding mains, users of altoholic only
	for member in pairs(DataStore:GetOnlineGuildMembers()) do
		if addon:GetGuildMemberVersion(member) then			-- altoholic user
			table.insert(view, { lineType = ALTO_MAIN_LINE, name = member } )			-- main character first
			altoOnlineMembers[member] = true
		end
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
					altoOnlineMembers[altName] = true
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
	for member, crafts in pairs(DataStore:GetGuildCrafters(guild)) do
		if not altoOnlineMembers[member] then
			offlineMembers[ #offlineMembers + 1 ] = member
		end
	end
	
	table.sort(offlineMembers, SecondaryLevelSort[viewSortField])

	for _, member in ipairs(offlineMembers) do
		table.insert(view, {	lineType = OFFLINEMEMBER_LINE, name = member } )
	end
	
	isViewValid = true
end

local function DisplayProfessionLink(frameName, member, index)
	local frame = _G[frameName]
	if not member then 
		frame:Hide()
		return 
	end
	
	local text = _G[frameName.."NormalText"]
	local guild = DataStore:GetGuild()
	local spellID, link = DataStore:GetGuildMemberProfession(guild, member, index)
	
	if spellID then
		local icon = addon:TextureToFontstring(addon:GetSpellIcon(tonumber(spellID)), 18, 18) .. " "
		if link then
			local curRank, maxRank = DataStore:GetProfessionInfo(link)
			local ts = addon.TradeSkills
			text:SetText(icon .. ts:GetColor(curRank) .. curRank .. "/" .. maxRank)
		else
			local spellName = GetSpellInfo(spellID)
			text:SetText(WHITE..spellName)
		end
		frame:Show()
	else
		frame:Hide()
	end
end

addon.Guild.Professions = {}

local ns = addon.Guild.Professions		-- ns = namespace

function ns:Update()
	if not isViewValid then
		BuildView()
	end

	local VisibleLines = 14
	local frame = "AltoholicFrameGuildProfessions"
	local entry = frame.."Entry"
	
	if #view == 0 then
		addon:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 18)
		return
	end
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawAlts
	local i=1
	
	for lineIndex, v in pairs(view) do
		local lineType = mod(v.lineType, 2)
		
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if lineType == HEADER_LINE then												-- then keep track of counters
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
			
			if lineType == HEADER_LINE then
				if expandedHeaders[v.name] then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawAlts = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawAlts = false
				end
				_G[entry..i.."Collapse"]:Show()
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 25, 0)
				
				_G[entry..i.."NameNormalText"]:SetText(YELLOW..member)
				
				if member == L["Offline Members"] then
					level = ""
				end
				_G[entry..i.."Level"]:SetText(GREEN .. level)
				
				if v.lineType == ALTO_MAIN_LINE then
					_G[entry..i.."Class"]:SetText(classText)

					for index = 1, 3 do
						DisplayProfessionLink( entry..i.."Skill"..index, member, index )
					end
				else
					_G[entry..i.."Class"]:SetText("")
					for index = 1, 3 do
						DisplayProfessionLink( entry..i.."Skill"..index)
					end					
				end
				
				_G[ entry..i ].CharName = member
				_G[ entry..i ]:SetID(lineIndex)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			elseif DrawAlts then
				_G[entry..i.."Collapse"]:Hide()
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
				_G[entry..i.."Level"]:SetText(GREEN .. level)
				_G[entry..i.."Class"]:SetText(classText)
				
				if v.lineType == ALTO_ALT_LINE then
					_G[entry..i.."NameNormalText"]:SetText(LIGHTBLUE..member)
				else
					_G[entry..i.."NameNormalText"]:SetText(GRAY..member)
				end
				
				for index = 1, 3 do
					DisplayProfessionLink( entry..i.."Skill"..index, member, index )
				end

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

function ns:Sort(self, field, index)
	viewSortField = field
	viewSortOrder = self.ascendingSort
	viewSortArg1 = index			-- arg 1 = index of the profession, to use the same function for all
	
	ns:InvalidateView()
end

function ns:OnEnter(self)
	local member = self:GetParent().CharName
	if not member then return end

	local id = self:GetID()					-- id of the button that was clicked
	local guild = DataStore:GetGuild()
	local spellID, link, lastUpdate = DataStore:GetGuildMemberProfession(guild, member, id)
	if not spellID or not link then return end

	local curRank, maxRank = DataStore:GetProfessionInfo(link)
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT");
	
	local _, _, _, _, _, _, _, _, _, _, englishClass = DataStore:GetGuildMemberInfo(member)
	AltoTooltip:AddLine(addon:GetClassColor(englishClass) .. member,1,1,1);
	
	local skillName = GetSpellInfo(spellID)
	AltoTooltip:AddLine(skillName,1,1,1);
	
	local ts = addon.TradeSkills
	AltoTooltip:AddLine(ts:GetColor(curRank) .. curRank .. "/" .. maxRank,1,1,1);
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(date("%m/%d/%Y %H:%M", lastUpdate),1,1,1);
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(GREEN..L["Left click to view"],1,1,1);
	AltoTooltip:AddLine(GREEN..L["Shift+Left click to link"],1,1,1);
	 	
	AltoTooltip:Show();
end

function ns:OnClick(self, button)
	if button ~= "LeftButton" then return end
	
	local member = self:GetParent().CharName
	if not member then return end
	
	local id = self:GetID()					-- id of the button that was clicked
	local guild = DataStore:GetGuild()
	local _, link = DataStore:GetGuildMemberProfession(guild, member, id)
	if not link then return end

	local chat = ChatEdit_GetLastActiveWindow()
	if chat:IsShown() and IsShiftKeyDown() then
		chat:Insert(link);
	else
		SetItemRef(link:match("|H([^|]+)"), "Profession", "LeftButton")
	end
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

function ns:ToggleView(self)
	if self.isCollapsed then	-- collapse all headers
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
	if AltoholicFrameGuildProfessions:IsVisible() then
		ns:Update()
	end
end
