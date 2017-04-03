local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local WHITE		= "|cFFFFFFFF"
--local GRAY		= "|cFFBBBBBB"
local GRAY		= "|cFF888888"
local GREEN		= "|cFF00FF00"
local LIGHTBLUE = "|cFFB0B0FF"
local YELLOW	= "|cFFFFFF00"

local view
local isViewValid
local myClientTimes = {}		-- small hash table containing the current player's client times, this allows quick comparison of client times among guild members.
local expandedHeaders = {}

local TABINFO_LINE = 0	-- Bank tab info line
local CHAR_LINE = 1		-- Character line

local function BuildView()
	view = view or {}
	wipe(view)
	
	local guild = DataStore:GetGuild()
	if not guild then return end

	local line = 0
	for tabID = 1, 6 do
		local tabName = DataStore:GetGuildBankTabName(guild, tabID)
		if tabName then
			table.insert(view, {	lineType = line, id = tabID } )	-- insert an entry for the tab name
			line = line + 1
			
			for member in pairs(DataStore:GetGuildBankTabSuppliers()) do
				local clientTime = DataStore:GetGuildMemberBankTabInfo(member, tabName)
				if clientTime then	-- if there's data, we can add this member in the view for the current bank tab
					table.insert(view, { lineType = line, id = member,	name = tabName } )				
				end
			end
			line = line + 1
		end
	end
		
	isViewValid = true
end

local function DisplayClientTime(frame, color, clientTime)
	if clientTime then
		frame:SetText(color .. date("%m/%d/%Y %H:%M", clientTime))
		frame:Show()
	else
		frame:Hide()
	end
end

local function DisplayServerTime(frame, serverHour, serverMinute)
	if serverHour and serverMinute then
		frame:SetText(format("%s%02d%s:%s%02d", GREEN, serverHour, WHITE, GREEN, serverMinute ))
		frame:Show()
	else
		frame:Hide()
	end
end

addon.Guild.BankTabs = {}

local ns = addon.Guild.BankTabs		-- ns = namespace

function ns:Update()
	if not isViewValid then
		BuildView()
	end

	local VisibleLines = 14
	local frame = "AltoholicFrameGuildBankTabs"
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
	
	local guild = DataStore:GetGuild()
	
	for line, v in pairs(view) do
		local lineType = mod(v.lineType, 2)
		
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if lineType == TABINFO_LINE then								-- then keep track of counters
				if expandedHeaders[v.id] then
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
			
			if lineType == TABINFO_LINE then
				
				if expandedHeaders[v.id] then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawAlts = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawAlts = false
				end

				local tabName = DataStore:GetGuildBankTabName(guild, v.id)
				_G[entry..i.."Collapse"]:Show()
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 25, 0)
				_G[entry..i.."NameNormalText"]:SetText(YELLOW..tabName)
				
				local clientTime, serverHour, serverMinute = DataStore:GetGuildMemberBankTabInfo(UnitName("player"), tabName)
				myClientTimes[tabName] = clientTime
				DisplayClientTime( _G[entry..i.."Client"], WHITE, clientTime)
				DisplayServerTime( _G[entry..i.."Server"], serverHour, serverMinute)
				_G[entry..i.."UpdateTab"]:Hide()
				
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			elseif DrawAlts then
				local member = v.id
				_G[entry..i.."Collapse"]:Hide()
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
				_G[entry..i.."NameNormalText"]:SetText(LIGHTBLUE..member)
				
				local tabName = v.name
				local clientTime, serverHour, serverMinute = DataStore:GetGuildMemberBankTabInfo(member, tabName)

				local color = GRAY
				if myClientTimes[tabName] then
					if clientTime > myClientTimes[tabName] then
						color = YELLOW
					end
				end
				
				DisplayClientTime( _G[entry..i.."Client"], color, clientTime)
				DisplayServerTime( _G[entry..i.."Server"], serverHour, serverMinute)
				_G[entry..i.."UpdateTab"]:Show()

				_G[ entry..i ]:SetID(line)
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

function ns:OnClick(self, button)
	if button ~= "LeftButton" then return end

	local id = self:GetParent():GetID()
	if id == 0 then return end
	
	local line = view[id]
	local member = line.id
	local tabName = line.name

	if member == UnitName("player") then return end		-- do nothing if clicking on own alts

	addon:Print(format(L["Requesting %s information from %s"], tabName, member ))
	DataStore:RequestGuildMemberBankTab(member, tabName)
end

function ns:OnEnter(self)
	local id = self:GetParent():GetID()
	if id == 0 then return end
	
	local line = view[id]
	local member = line.id
	local tabName = line.name
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT");
	
	AltoTooltip:AddLine(L["Guild Bank Remote Update"]);
	AltoTooltip:AddLine(format(L["Clicking this button will update\nyour local %s%s|r bank tab\nbased on %s%s's|r data"], LIGHTBLUE, line.name, YELLOW, line.id),1,1,1);
	AltoTooltip:Show();
end

function ns:Collapse_OnClick(self)
	local id = self:GetParent():GetID()
	if id == 0 then return end
	
	local line = view[id]
	if expandedHeaders[line.id] then		-- toggle header
		expandedHeaders[line.id] = nil
	else
		expandedHeaders[line.id] = true
	end
	ns:Update()
end

function ns:ToggleView(self)
	if self.isCollapsed then	-- collapse all headers
		wipe(expandedHeaders)
	else								-- expand all headers
		for _, line in pairs(view) do
			if mod(line.lineType, 2) == TABINFO_LINE then
				expandedHeaders[line.id] = true
			end
		end
	end
	ns:Update()
end

function ns:InvalidateView()
	isViewValid = nil
	if AltoholicFrameGuildBankTabs:IsVisible() then
		ns:Update()
	end
end
