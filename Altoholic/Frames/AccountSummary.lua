local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()

local INFO_REALM_LINE = 0
local INFO_CHARACTER_LINE = 1
local INFO_TOTAL_LINE = 2
local THIS_ACCOUNT = "Default"

local TEAL		= "|cFF00FF9A"
local WHITE		= "|cFFFFFFFF"
local GOLD		= "|cFFFFD700"
local YELLOW	= "|cFFFFFF00"
local GREEN		= "|cFF00FF00"

local VIEW_BAGS = 1
local VIEW_MAILS = 3
local VIEW_QUESTS = 4
local VIEW_AUCTIONS = 5
local VIEW_BIDS = 6
local VIEW_COMPANIONS = 7
local VIEW_MOUNTS = 8

local ICON_FACTION_HORDE = "Interface\\Icons\\INV_BannerPVP_01"
local ICON_FACTION_ALLIANCE = "Interface\\Icons\\INV_BannerPVP_02"

local Characters = addon.Characters

local function GetFactionTotals(f, line)
	local _, realm, account = Characters:GetInfo(line)
	
	local level = 0
	local money = 0
	local played = 0
	
	local DS = DataStore
	for _, character in pairs(DS:GetCharacters(realm, account)) do
		if DS:GetCharacterFaction(character) == f then
			level = level + DS:GetCharacterLevel(character)
			money = money + DS:GetMoney(character)
			played = played + DS:GetPlayTime(character)
		end
	end
	
	return level, money, played
end

local function DDM_Add(text, value, func, arg1)
	-- tiny wrapper
	local info = UIDropDownMenu_CreateInfo(); 
	
	info.text		= text
	info.value		= value
	info.func		= func
	info.arg1		= arg1
	info.checked	= nil
	UIDropDownMenu_AddButton(info, 1); 
end

local function DDM_AddCloseMenu()
	local info = UIDropDownMenu_CreateInfo(); 
	
	-- Close menu item
	info.text = CLOSE
	info.func = function() CloseDropDownMenus() end
	info.checked = nil
	info.notCheckable = 1
	info.icon		= nil
	UIDropDownMenu_AddButton(info, 1)
end

addon.Summary = {}

local ns = addon.Summary		-- ns = namespace

local function ViewAltInfo(self, characterInfoLine)
	local name, realm, account = Characters:GetInfo(characterInfoLine)
	addon:SetCurrentCharacter(name, realm, account)
	addon.Tabs.Characters:SetCurrent(name, realm, account)
	
	addon.Tabs:OnClick(2)
	addon.Tabs.Characters:ViewCharInfo(self.value)
end

local function DeleteAlt_MsgBox_Handler(self, button, characterInfoLine)
	if not button then return end
	
	local name, realm, account = Characters:GetInfo(characterInfoLine)
	
	DataStore:DeleteCharacter(name, realm, account)
	
	-- rebuild the main character table, and all the menus
	Characters:BuildList()
	Characters:BuildView()
	addon.Summary:Update()
		
	addon:Print(format( L["Character %s successfully deleted"], name))
end

local function DeleteAlt(self, characterInfoLine)
	local name, realm, account = Characters:GetInfo(characterInfoLine)
	
	if (account == THIS_ACCOUNT) and	(realm == GetRealmName()) and (name == UnitName("player")) then
		addon:Print(L["Cannot delete current character"])
		return
	end

	addon:SetMsgBoxHandler(DeleteAlt_MsgBox_Handler, characterInfoLine)
	
	AltoMsgBox_Text:SetText(L["Delete this Alt"] .. "?\n" .. name)
	AltoMsgBox:Show()
end

local function UpdateRealm(self, characterInfoLine)
	local _, realm, account = Characters:GetInfo(characterInfoLine)
	
	AltoAccountSharing_AccNameEditBox:SetText(account)
	AltoAccountSharing_UseTarget:SetChecked(nil)
	AltoAccountSharing_UseName:SetChecked(1)
	
	local _, updatedWith = addon:GetLastAccountSharingInfo(realm, account)
	AltoAccountSharing_AccTargetEditBox:SetText(updatedWith)
	
	addon.Tabs.Summary:AccountSharingButton_OnClick()
end

local function DeleteRealm_MsgBox_Handler(self, button, characterInfoLine)
	if not button then return end

	local _, realm, account = Characters:GetInfo(characterInfoLine)
	DataStore:DeleteRealm(realm, account)

	-- if the realm being deleted was the current ..
	if addon:GetCurrentRealm() == realm and addon:GetCurrentAccount() == account then
		
		-- reset to this player
		local tc = addon.Tabs.Characters
		local player = UnitName("player")
		local realmName = GetRealmName()
		addon:SetCurrentCharacter(player, realmName, THIS_ACCOUNT)
		addon.Tabs.Characters:SetCurrent(player, realmName, THIS_ACCOUNT)
		addon.Containers:UpdateCache()
		tc:ViewCharInfo(VIEW_BAGS)
	end
	
	-- rebuild the main character table, and all the menus
	Characters:BuildList()
	Characters:BuildView()
	addon.Summary:Update()
		
	addon:Print(format( L["Realm %s successfully deleted"], realm))
end

local function DeleteRealm(self, characterInfoLine)
	local _, realm, account = Characters:GetInfo(characterInfoLine)
		
	if (account == THIS_ACCOUNT) and	(realm == GetRealmName()) then
		addon:Print(L["Cannot delete current realm"])
		return
	end

	addon:SetMsgBoxHandler(DeleteRealm_MsgBox_Handler, characterInfoLine)
	AltoMsgBox_Text:SetText(L["Delete this Realm"] .. "?\n" .. realm)
	AltoMsgBox:Show()
end


function ns:Update()
	local VisibleLines = 14
	local frame = "AltoholicFrameSummary"
	local entry = frame.."Entry"
	

	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawRealm
	local i=1
	
	local DS = DataStore
	
	local view = Characters:GetView()
	if not view then return end
	
	for _, line in pairs(view) do
		local lineType = Characters:GetLineType(line)
		
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if lineType == INFO_REALM_LINE then								-- then keep track of counters
				if Characters:GetField(line, "isCollapsed") == false then
					DrawRealm = true
				else
					DrawRealm = false
				end
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			elseif DrawRealm then
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			end
		else		-- line will be displayed
			if lineType == INFO_REALM_LINE then
				local _, realm, account = Characters:GetInfo(line)
				
				if Characters:GetField(line, "isCollapsed") == false then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawRealm = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawRealm = false
				end
				_G[entry..i.."Collapse"]:Show()
				_G[entry..i.."Name"]:SetWidth(300)
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 25, 0)
				_G[entry..i.."NameNormalText"]:SetWidth(300)
				if account == THIS_ACCOUNT then	-- saved as default, display as localized.
					_G[entry..i.."NameNormalText"]:SetText(format("%s (%s".. L["Account"]..": %s%s|r)", realm, WHITE, GREEN, L["Default"]))
				else
					local last = addon:GetLastAccountSharingInfo(realm, account)
					_G[entry..i.."NameNormalText"]:SetText(format("%s (%s".. L["Account"]..": %s%s %s%s|r)", realm, WHITE, GREEN, account, YELLOW, last or ""))
				end
				_G[entry..i.."Level"]:SetText("")

				_G[entry..i.."Money"]:SetText("")
				_G[entry..i.."Played"]:SetText("")
				_G[entry..i.."XP"]:SetText("")
				_G[entry..i.."Rested"]:SetText("")
				_G[entry..i.."AvgILevelNormalText"]:SetText("")
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			elseif DrawRealm then
				if (lineType == INFO_CHARACTER_LINE) then
					local character = DS:GetCharacter( Characters:GetInfo(line) )
					
					local icon
					if DS:GetCharacterFaction(character) == "Alliance" then
						icon = addon:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18) .. " "
					else
						icon = addon:TextureToFontstring(ICON_FACTION_HORDE, 18, 18) .. " "
					end
					
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(170)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 10, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(170)
					_G[entry..i.."NameNormalText"]:SetText(icon .. format("%s (%s)", DS:GetColoredCharacterName(character), DS:GetCharacterClass(character)))
					_G[entry..i.."Level"]:SetText(GREEN .. DS:GetCharacterLevel(character))

					_G[entry..i.."Money"]:SetText(addon:GetMoneyString(DS:GetMoney(character)))
					_G[entry..i.."Played"]:SetText(addon:GetTimeString(DS:GetPlayTime(character)))
					_G[entry..i.."XP"]:SetText(GREEN .. DS:GetXPRate(character) .. "%")

					if DS:GetCharacterLevel(character) == MAX_PLAYER_LEVEL then
						_G[entry..i.."Rested"]:SetText(WHITE .. "0%")
					else
						_G[entry..i.."Rested"]:SetText( addon:GetRestedXP(character) )
					end
					
					_G[entry..i.."AvgILevelNormalText"]:SetText(YELLOW..format("%.1f", DS:GetAverageItemLevel(character)))
					
				elseif (lineType == INFO_TOTAL_LINE) then
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(200)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(200)
					_G[entry..i.."NameNormalText"]:SetText(L["Totals"])
					_G[entry..i.."Level"]:SetText(Characters:GetField(line, "level"))
					_G[entry..i.."Money"]:SetText(addon:GetMoneyString(Characters:GetField(line, "money"), WHITE))
					_G[entry..i.."Money"]:SetTextColor(1.0, 1.0, 1.0)
					_G[entry..i.."Played"]:SetText(Characters:GetField(line, "played"))
					_G[entry..i.."XP"]:SetText("")
					_G[entry..i.."Rested"]:SetText("")
					_G[entry..i.."AvgILevelNormalText"]:SetText("")
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

function ns:Level_OnEnter(frame)
	local line = frame:GetParent():GetID()
	local lineType = Characters:GetLineType(line)
	if not lineType then return end
	
	if lineType == INFO_REALM_LINE then		
		return
	elseif lineType == INFO_TOTAL_LINE then		
		AltoTooltip:ClearLines();
		AltoTooltip:SetOwner(frame, "ANCHOR_TOP");
		AltoTooltip:AddLine(L["Totals"]);
		
		local aLevels, aMoney, aPlayed = GetFactionTotals("Alliance", line)
		local hLevels, hMoney, hPlayed = GetFactionTotals("Horde", line)
		
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddDoubleLine(WHITE..L["Levels"] , format("%s|r (%s %s|r, %s %s|r)", 
			Characters:GetField(line, "level"),
			addon:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18), WHITE..aLevels,
			addon:TextureToFontstring(ICON_FACTION_HORDE, 18, 18), WHITE..hLevels))
		
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddDoubleLine(WHITE..MONEY, format("%s|r (%s %s|r, %s %s|r)", 
			addon:GetMoneyString(Characters:GetField(line, "money"), WHITE, true),
			addon:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18), 
			addon:GetMoneyString(aMoney, WHITE, true),
			addon:TextureToFontstring(ICON_FACTION_HORDE, 18, 18), 
			addon:GetMoneyString(hMoney, WHITE, true)))
		
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddDoubleLine(WHITE..PLAYED , format("%s|r (%s %s|r, %s %s|r)",
			Characters:GetField(line, "played"),
			addon:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18),
			addon:GetTimeString(aPlayed),
			addon:TextureToFontstring(ICON_FACTION_HORDE, 18, 18), 
			addon:GetTimeString(hPlayed)))
		
		AltoTooltip:Show();
		return
	end
	
	local DS = DataStore
	local character = DS:GetCharacter(Characters:GetInfo(line))
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(frame, "ANCHOR_RIGHT");
	
	AltoTooltip:AddDoubleLine(DS:GetColoredCharacterName(character), DS:GetColoredCharacterFaction(character))
	AltoTooltip:AddLine(format("%s %s |r%s %s", L["Level"], 
		GREEN..DS:GetCharacterLevel(character), DS:GetCharacterRace(character),	DS:GetCharacterClass(character)),1,1,1)

	local zone, subZone = DS:GetLocation(character)
	AltoTooltip:AddLine(format("%s: %s |r(%s|r)", L["Zone"], GOLD..zone, GOLD..subZone),1,1,1)
	
	local guildName = DS:GetGuildInfo(character)
	if guildName then
		AltoTooltip:AddLine(format("%s: %s", GUILD, GREEN..guildName),1,1,1)
	end
	
	AltoTooltip:AddLine(EXPERIENCE_COLON .. " " 
				.. GREEN .. DS:GetXP(character) .. WHITE .. "/" 
				.. GREEN .. DS:GetXPMax(character) .. WHITE .. " (" 
				.. GREEN .. DS:GetXPRate(character) .. "%"
				.. WHITE .. ")",1,1,1);	
	
	local restXP = DS:GetRestXP(character)
	if restXP and restXP > 0 then
		AltoTooltip:AddLine(format("%s: %s", L["Rest XP"], GREEN..restXP),1,1,1)
	end
	
	local suggestion = addon:GetSuggestion("Leveling", DS:GetCharacterLevel(character))
	if suggestion then
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddLine(L["Suggested leveling zone: "],1,1,1);
		AltoTooltip:AddLine(TEAL .. suggestion,1,1,1);
	end

	-- parse saved instances
	local c = addon:GetCharacterTableByLine(line)
	
	local bLineBreak = true
	for Instance, InstanceInfo in pairs (c.SavedInstance) do
		local InstanceName, InstanceID = strsplit("|", Instance)
			
		local reset, lastcheck = strsplit("|", InstanceInfo)
		reset = tonumber(reset)
		lastcheck = tonumber(lastcheck)
		local expiresIn = reset - (time() - lastcheck)
		
		if expiresIn > 0 then
			if bLineBreak then
				AltoTooltip:AddLine(" ",1,1,1);		-- add a line break only once
				bLineBreak = nil
			end
			AltoTooltip:AddDoubleLine(GOLD .. InstanceName .. 
				" (".. WHITE.."ID: " .. GREEN .. InstanceID .. "|r)", addon:GetTimeString(expiresIn))
		else
			c.SavedInstance[Instance] = nil
		end
	end
	
	-- add PVP info if any

	local hk, dk, arena, honor = DS:GetStats(character, "PVP")
	
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddDoubleLine(WHITE.. L["Arena points: "] .. GREEN .. arena, "HK: " .. GREEN .. hk )
	AltoTooltip:AddDoubleLine(WHITE.. L["Honor points: "] .. GREEN .. honor, "DK: " .. GREEN .. dk )
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(GREEN .. L["Right-Click for options"]);
	AltoTooltip:Show();
end

function ns:Level_OnClick(frame, button)
	local line = frame:GetParent():GetID()
	if line == 0 then return end

	local lineType = Characters:GetLineType(line)
	if lineType == INFO_TOTAL_LINE then		
		return
	end
	
	if button == "RightButton" then
		ns.CharInfoLine = line	-- line containing info about the alt on which action should be taken (delete, ..)
		ToggleDropDownMenu(1, nil, AltoholicFrameSummaryRightClickMenu, frame:GetName(), 0, -5);
		return
	elseif button == "LeftButton" and lineType == INFO_CHARACTER_LINE then
	
		local tc = addon.Tabs.Characters
		local charName, realm, account = Characters:GetInfo(line)
		addon:SetCurrentCharacter(charName, realm, account)
		addon.Tabs.Characters:SetCurrent(charName, realm, account)
		
		addon.Tabs:OnClick(2)
		addon.Containers:UpdateCache()
		tc:ViewCharInfo(VIEW_BAGS)
	end
end

function ns:AIL_OnEnter(frame)
	local line = frame:GetParent():GetID()
	local lineType = Characters:GetLineType(line)
	
	if lineType ~= INFO_CHARACTER_LINE then		
		return
	end
		
	local DS = DataStore
	local character = DS:GetCharacter(Characters:GetInfo(line))
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(frame, "ANCHOR_RIGHT");
	AltoTooltip:AddLine(DS:GetColoredCharacterName(character),1,1,1);
	AltoTooltip:AddLine(WHITE .. L["Average Item Level"] ..": " .. GREEN.. format("%.1f", DS:GetAverageItemLevel(character)),1,1,1);

	addon:AiLTooltip()
	AltoTooltip:Show();
end

function addon:AiLTooltip()
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(TEAL .. L["Level"] .. " 60",1,1,1);
	AltoTooltip:AddDoubleLine(YELLOW .. "58-63", WHITE .. "Tier 0")
	AltoTooltip:AddDoubleLine(YELLOW .. "66", WHITE .. "Tier 1")
	AltoTooltip:AddDoubleLine(YELLOW .. "76", WHITE .. "Tier 2")
	AltoTooltip:AddDoubleLine(YELLOW .. "86-92", WHITE .. "Tier 3")
	AltoTooltip:AddLine(" ",1,1,1);
	
	AltoTooltip:AddLine(TEAL .. L["Level"] .. " 70",1,1,1);
	AltoTooltip:AddDoubleLine(YELLOW .. "115", WHITE .. BZ["Karazhan"])
	AltoTooltip:AddDoubleLine(YELLOW .. "120", WHITE .. "Tier 4")
	AltoTooltip:AddDoubleLine(YELLOW .. "128", WHITE .. BZ["Zul'Aman"])
	AltoTooltip:AddDoubleLine(YELLOW .. "133", WHITE .. "Tier 5")
	AltoTooltip:AddDoubleLine(YELLOW .. "146-154", WHITE .. "Tier 6")
	AltoTooltip:AddLine(" ",1,1,1);

	AltoTooltip:AddLine(TEAL .. L["Level"] .. " 80",1,1,1);
	AltoTooltip:AddDoubleLine(YELLOW .. "200", WHITE .. BZ["Naxxramas"] .. " (10)")
	AltoTooltip:AddDoubleLine(YELLOW .. "213", WHITE .. BZ["Naxxramas"] .. " (25)")
	AltoTooltip:AddDoubleLine(YELLOW .. "200-219", WHITE .. BZ["Trial of the Champion"])
	AltoTooltip:AddDoubleLine(YELLOW .. "219", WHITE .. BZ["Ulduar"] .. " (10)")
	AltoTooltip:AddDoubleLine(YELLOW .. "226-239", WHITE .. BZ["Ulduar"] .. " (25)")
	AltoTooltip:AddDoubleLine(YELLOW .. "232-258", WHITE .. BZ["Trial of the Crusader"] .. " (10)")
	AltoTooltip:AddDoubleLine(YELLOW .. "245-272", WHITE .. BZ["Trial of the Crusader"] .. " (25)")
	AltoTooltip:AddDoubleLine(YELLOW .. "251-271", WHITE .. BZ["Icecrown Citadel"] .. " (10)")
	AltoTooltip:AddDoubleLine(YELLOW .. "264-284", WHITE .. BZ["Icecrown Citadel"] .. " (25)")
end

function ns:RightClickMenu_OnLoad()
	local characterInfoLine = ns.CharInfoLine
	if not characterInfoLine then return end

	local lineType = Characters:GetLineType(characterInfoLine)
	if not lineType then return end

	if lineType == INFO_REALM_LINE then
		local _, realm, account = Characters:GetInfo(characterInfoLine)
		local _, updatedWith = addon:GetLastAccountSharingInfo(realm, account)
		
		if updatedWith then
			DDM_Add(format("Update from %s", GREEN..updatedWith), nil, UpdateRealm, characterInfoLine)
		end
		DDM_Add(L["Delete this Realm"], nil, DeleteRealm, characterInfoLine)
		return
	end

	DDM_Add(L["View bags"], VIEW_BAGS, ViewAltInfo, characterInfoLine)
	DDM_Add(L["View mailbox"], VIEW_MAILS, ViewAltInfo, characterInfoLine)
	DDM_Add(L["View quest log"], VIEW_QUESTS, ViewAltInfo, characterInfoLine)
	DDM_Add(L["View auctions"], VIEW_AUCTIONS, ViewAltInfo, characterInfoLine)
	DDM_Add(L["View bids"], VIEW_BIDS, ViewAltInfo, characterInfoLine)
	DDM_Add(COMPANIONS, VIEW_COMPANIONS, ViewAltInfo, characterInfoLine)
	DDM_Add(MOUNTS, VIEW_MOUNTS, ViewAltInfo, characterInfoLine)
	DDM_Add(L["Delete this Alt"], nil, DeleteAlt, characterInfoLine)
	DDM_AddCloseMenu()
end
