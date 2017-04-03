local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local WHITE		= "|cFFFFFFFF"
local RED		= "|cFFFF0000"
local GREEN		= "|cFF00FF00"
local TEAL		= "|cFF00FF9A"

local isViewValid
local collapsedHeaders

local questSizeColors = {
	[2] = GREEN,
	[3] = YELLOW,
	[4] = ORANGE,
	[5] = RED,
}

local function FormatQuestType(tag, size)
	if questSizeColors[size] then
		return format("%s%s%s (%d)", WHITE, tag, questSizeColors[size], size)
	else
		return format("%s%s", WHITE, tag)
	end
end

addon.Quests = {}

local ns = addon.Quests		-- ns = namespace

function ns:Update()
	local character = addon.Tabs.Characters:GetCurrent()

	
	local VisibleLines = 14
	local frame = "AltoholicFrameQuests"
	local entry = frame.."Entry"
	
	local DS = DataStore
	
	if DS:GetQuestLogSize(character) == 0 then
		AltoholicTabCharactersStatus:SetText(L["No quest found for "] .. addon:GetCurrentCharacter())
		addon:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 18)
		return
	end
	AltoholicTabCharactersStatus:SetText("")
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawGroup

	collapsedHeaders = collapsedHeaders or {}
	if not isViewValid then
		wipe(collapsedHeaders)
		isViewValid = true
	end

	local i=1
	
	for line = 1, DS:GetQuestLogSize(character) do
		local isHeader, quest, questTag, groupSize, money, isComplete = DS:GetQuestLogInfo(character, line)
		
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if isHeader then													-- then keep track of counters
				
				if not collapsedHeaders[line] then
					DrawGroup = true
				else
					DrawGroup = false
				end
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			elseif DrawGroup then
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			end
		else		-- line will be displayed
			if isHeader then
				if not collapsedHeaders[line] then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawGroup = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawGroup = false
				end
				_G[entry..i.."Collapse"]:Show()
				_G[entry..i.."QuestLinkNormalText"]:SetText(TEAL .. quest)
				_G[entry..i.."QuestLink"]:SetID(0)
				_G[entry..i.."QuestLink"]:SetPoint("TOPLEFT", 25, 0)
				
				_G[entry..i.."Tag"]:Hide()
				_G[entry..i.."Status"]:Hide()
				_G[entry..i.."Money"]:Hide()
				
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
				
			elseif DrawGroup then
				_G[entry..i.."Collapse"]:Hide()
				
				local _, _, level = DS:GetQuestInfo(quest)
				-- quick fix, level may be nil, I suspect that due to certain locales, the quest link may require different parsing.
				level = level or 0
				
				_G[entry..i.."QuestLinkNormalText"]:SetText(WHITE .. "[" .. level .. "] " .. quest)
				_G[entry..i.."QuestLink"]:SetID(line)
				_G[entry..i.."QuestLink"]:SetPoint("TOPLEFT", 15, 0)
				if questTag then 
					_G[entry..i.."Tag"]:SetText(FormatQuestType(questTag, groupSize))
					_G[entry..i.."Tag"]:Show()
				else
					_G[entry..i.."Tag"]:Hide()
				end
				
				_G[entry..i.."Status"]:Hide()
				if isComplete == 1 then
					_G[entry..i.."Status"]:SetText(GREEN .. COMPLETE)
					_G[entry..i.."Status"]:Show()
				elseif isComplete == -1 then
					_G[entry..i.."Status"]:SetText(RED .. FAILED)
					_G[entry..i.."Status"]:Show()
				end
				
				if money then
					_G[entry..i.."Money"]:SetText(addon:GetMoneyString(money))
					_G[entry..i.."Money"]:Show()
				else
					_G[entry..i.."Money"]:Hide()
				end
					
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

function ns:InvalidateView()
	isViewValid = nil
end

function ns:ListCharsOnQuest(questName, player, tooltip)
	if not questName then return nil end
	
	local DS = DataStore
	local CharsOnQuest = {}
	for characterName, character in pairs(DS:GetCharacters(realm)) do
		if characterName ~= player then
			local questLogSize = DS:GetQuestLogSize(character) or 0
			for i = 1, questLogSize do
				local isHeader, link = DS:GetQuestLogInfo(character, i)
				if not isHeader then
					local altQuestName = DS:GetQuestInfo(link)
					if altQuestName == questName then		-- same quest found ?
						table.insert(CharsOnQuest, DS:GetColoredCharacterName(character))	
					end
				end
			end
		end
	end
	
	if #CharsOnQuest > 0 then
		tooltip:AddLine(" ",1,1,1);
		tooltip:AddLine(GREEN .. L["Are also on this quest:"],1,1,1);
		tooltip:AddLine(table.concat(CharsOnQuest, "\n"),1,1,1);
	end
end

function ns:Collapse_OnClick(frame, button)
	local id = frame:GetParent():GetID()
	if id ~= 0 then
		collapsedHeaders[id] = not collapsedHeaders[id]
		ns:Update()
	end
end

function ns:Link_OnEnter(frame)
	local id = frame:GetID()
	if id == 0 then return end

	local DS = DataStore
	local character = addon.Tabs.Characters:GetCurrent()
	local _, link = DS:GetQuestLogInfo(character, id)
	if not link then return end

	local questName, questID, level = DS:GetQuestInfo(link)
	if IsAddOnLoaded("Odyssey") and IsAddOnLoaded("OdysseyQuests") then
		Odyssey:ShowQuestTooltip(frame, questID)
		return
	end
	
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(frame, "ANCHOR_RIGHT");
	GameTooltip:SetHyperlink(link);
	GameTooltip:AddLine(" ",1,1,1);
	
	GameTooltip:AddDoubleLine(LEVEL .. ": |cFF00FF9A" .. level, L["QuestID"] .. ": |cFF00FF9A" .. questID);
	
	local player = addon:GetCurrentCharacter()
	addon.Quests:ListCharsOnQuest(questName, player, GameTooltip)
	GameTooltip:Show();
end

function ns:Link_OnClick(frame, button)
	if button == "LeftButton" and IsShiftKeyDown() then
		local chat = ChatEdit_GetLastActiveWindow()
		if chat:IsShown() then
			local id = frame:GetID()
			if id == 0 then return end
			
			local character = addon.Tabs.Characters:GetCurrent()
			local _, link = DataStore:GetQuestLogInfo(character, id)
			if link then
				chat:Insert(link)
			end
		end
	end
end
