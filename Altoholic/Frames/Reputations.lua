local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local BF = LibStub("LibBabble-Faction-3.0"):GetLookupTable()
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local TEAL		= "|cFF00FF9A"
local YELLOW	= "|cFFFFFF00"
local DARK_RED = "|cFFF00000"

local ICON_UNKNOWN = "\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t"
local ICON_EXALTED = "\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t"

local Factions = {
	-- Factions reference table, based on http://www.wowwiki.com/Factions
	{	-- [1]
		name = "Classic",
		{	-- [1]
			name = FACTION_ALLIANCE,
			{ name = BZ["Darnassus"], icon = "Achievement_Character_Nightelf_Female"	},
			{ name = BF["Exodar"], icon = "Achievement_Character_Draenei_Male" },
			{ name = BF["Gnomeregan Exiles"], icon = "Achievement_Character_Gnome_Female" },
			{ name = BZ["Ironforge"], icon = "Achievement_Character_Dwarf_Male" },
			{ name = BF["Stormwind"], icon = "Achievement_Character_Human_Male" },
		},
		{	-- [2]
			name = FACTION_HORDE,
			{ name = BF["Darkspear Trolls"], icon = "Achievement_Character_Troll_Male" },
			{ name = BZ["Orgrimmar"], icon = "Achievement_Character_Orc_Male" },
			{ name = BZ["Thunder Bluff"], icon = "Achievement_Character_Tauren_Male" },
			{ name = BZ["Undercity"], icon = "Achievement_Character_Undead_Female" },
			{ name = BZ["Silvermoon City"], icon = "Achievement_Character_Bloodelf_Male" },
		},
		{	-- [3]
			name = L["Alliance Forces"],
			{ name = BF["The League of Arathor"], icon = "Achievement_BG_winAB" },
			{ name = BF["Silverwing Sentinels"], icon = "Achievement_BG_captureflag_WSG" },
			{ name = BF["Stormpike Guard"], icon = "Achievement_BG_winAV" },
		},
		{	-- [4]
			name = L["Horde Forces"],
			{ name = BF["The Defilers"], icon = "Achievement_BG_winAB" },
			{ name = BF["Warsong Outriders"], icon = "Achievement_BG_captureflag_WSG" },
			{ name = BF["Frostwolf Clan"], icon = "Achievement_BG_winAV" },
		},
		{	-- [5]
			name = L["Steamwheedle Cartel"],
			{ name = BZ["Booty Bay"], icon = "Achievement_Zone_Stranglethorn_01" },
			{ name = BZ["Everlook"], icon = "Achievement_Zone_Winterspring" },
			{ name = BZ["Gadgetzan"], icon = "Achievement_Zone_Tanaris_01" },
			{ name = BZ["Ratchet"], icon = "Achievement_Zone_Barrens_01" },
		},
		{	-- [6]
			name = L["Other"],
			{ name = BF["Argent Dawn"], icon = "INV_Jewelry_Talisman_07" },
			{ name = BF["Bloodsail Buccaneers"], icon = "INV_Helmet_66" },
			{ name = BF["Brood of Nozdormu"], icon = "INV_Misc_Head_Dragon_Bronze" },
			{ name = BF["Cenarion Circle"], icon = "Achievement_Zone_Silithus_01" },
			{ name = BF["Darkmoon Faire"], icon = "INV_Misc_Ticket_Darkmoon_01" },
			{ name = BF["Gelkis Clan Centaur"], icon = "INV_Misc_Head_Centaur_01" },
			{ name = BF["Hydraxian Waterlords"], icon = "Spell_Frost_SummonWaterElemental_2" },
			{ name = BF["Magram Clan Centaur"], icon = "INV_Misc_Head_Centaur_01" },
			{ name = BF["Ravenholdt"], icon = "INV_ThrowingKnife_04" },
			{ name = BF["Shen'dralar"], icon = "Achievement_Zone_Feralas" },
			{ name = BF["Syndicate"], icon = "INV_Misc_ArmorKit_03" },
			{ name = BF["Thorium Brotherhood"], icon = "INV_Ingot_Thorium" },
			{ name = BF["Timbermaw Hold"], icon = "Achievement_Reputation_timbermaw" },
			{ name = BF["Tranquillien"], icon = "Achievement_Zone_Ghostlands" },
			{ name = BF["Wintersaber Trainers"], icon = "Ability_Mount_PinkTiger" },
			{ name = BF["Zandalar Tribe"], icon = "INV_Bijou_Green" },
		}
	},
	{	-- [2]
		name = "The Burning Crusade",
		{	-- [1]
			name = BZ["Outland"],
			{ name = BF["Ashtongue Deathsworn"], icon = "Achievement_Reputation_AshtongueDeathsworn" },
			{ name = BF["Cenarion Expedition"], icon = "Achievement_Reputation_GuardiansofCenarius" },
			{ name = BF["The Consortium"], icon = "INV_Enchant_ShardPrismaticLarge" },
			{ name = BF["Honor Hold"], icon = "Spell_Misc_HellifrePVPHonorHoldFavor" },
			{ name = BF["Kurenai"], icon = "INV_Misc_Foot_Centaur" },
			{ name = BF["The Mag'har"], icon = "Achievement_Zone_Nagrand_01" },
			{ name = BF["Netherwing"], icon = "Ability_Mount_NetherdrakePurple" },
			{ name = BF["Ogri'la"], icon = "Achievement_Reputation_Ogre" },
			{ name = BF["Sporeggar"], icon = "INV_Mushroom_11" },
			{ name = BF["Thrallmar"], icon = "Spell_Misc_HellifrePVPThrallmarFavor" },
		},
		{	-- [2]
			name = BZ["Shattrath City"],
			{ name = BF["Lower City"], icon = "Achievement_Zone_Terrokar" },
			{ name = BF["Sha'tari Skyguard"], icon = "Ability_Hunter_Pet_NetherRay" },
			{ name = BF["Shattered Sun Offensive"], icon = "INV_Shield_48" },
			{ name = BF["The Aldor"], icon = "Achievement_Character_Draenei_Female" },
			{ name = BF["The Scryers"], icon = "Achievement_Character_Bloodelf_Female" },
			{ name = BF["The Sha'tar"], icon = "Achievement_Zone_Netherstorm_01" },
		},
		{	-- [3]
			name = L["Other"],
			{ name = BF["Keepers of Time"], icon = "Achievement_Zone_HillsbradFoothills" },
			{ name = BF["The Scale of the Sands"], icon = "INV_Enchant_DustIllusion" },
			{ name = BF["The Violet Eye"], icon = "Spell_Holy_MindSooth" },
		}
	},
	{	-- [3]
		name = "Wrath of the Lich King",
		{	-- [1]
			name = BZ["Northrend"],
			{ name = BF["Argent Crusade"], icon = "Achievement_Reputation_ArgentCrusader" },
			{ name = BF["Kirin Tor"], icon = "Achievement_Reputation_KirinTor" },
			{ name = BF["The Kalu'ak"], icon = "Achievement_Reputation_Tuskarr" },
			{ name = BF["The Wyrmrest Accord"], icon = "Achievement_Reputation_WyrmrestTemple" },
			{ name = BF["Knights of the Ebon Blade"], icon = "Achievement_Reputation_KnightsoftheEbonBlade" },
			{ name = BF["The Sons of Hodir"], icon = "Achievement_Boss_Hodir_01" },
			{ name = BF["The Ashen Verdict"], icon = "Achievement_Reputation_ArgentCrusader" },
		},
		{	-- [2]
			name = BF["Alliance Vanguard"],
			{ name = BF["Alliance Vanguard"], icon = "Spell_Misc_HellifrePVPHonorHoldFavor" },
			{ name = BF["Explorers' League"], icon = "Achievement_Zone_HowlingFjord_02" },
			{ name = BF["The Frostborn"], icon = "Achievement_Zone_StormPeaks_01" },
			{ name = BF["The Silver Covenant"], icon = "Achievement_Zone_CrystalSong_01" },
			{ name = BF["Valiance Expedition"], icon = "Achievement_Zone_BoreanTundra_01" },
		},
		{	-- [3]
			name = BF["Horde Expedition"],
			{ name = BF["Horde Expedition"], icon = "Spell_Misc_HellifrePVPThrallmarFavor" },
			{ name = BF["The Hand of Vengeance"], icon = "Achievement_Zone_HowlingFjord_02" },
			{ name = BF["The Sunreavers"], icon = "Achievement_Zone_CrystalSong_01" },
			{ name = BF["The Taunka"], icon = "Achievement_Zone_BoreanTundra_02" },
			{ name = BF["Warsong Offensive"], icon = "Achievement_Zone_BoreanTundra_03" },
		},
		{	-- [4]
			name = BZ["Sholazar Basin"],
			{ name = BF["Frenzyheart Tribe"], icon = "Ability_Mount_WhiteDireWolf" },
			{ name = BF["The Oracles"], icon = "Achievement_Reputation_MurlocOracle" },
		},
	},
}

local VertexColors = {
	[FACTION_STANDING_LABEL1] = { r = 0.4, g = 0.13, b = 0.13 },	-- hated
	[FACTION_STANDING_LABEL2] = { r = 0.5, g = 0.0, b = 0.0 },		-- hostile
	[FACTION_STANDING_LABEL3] = { r = 0.6, g = 0.4, b = 0.13 },		-- unfriendly
	[FACTION_STANDING_LABEL4] = { r = 0.6, g = 0.6, b = 0.0 },		-- neutral
	[FACTION_STANDING_LABEL5] = { r = 0.0, g = 0.6, b = 0.0 },		-- friendly
	[FACTION_STANDING_LABEL6] = { r = 0.0, g = 0.6, b = 0.4 },		-- honored
	[FACTION_STANDING_LABEL7] = { r = 0.0, g = 0.6, b = 0.6 },		-- revered
	[FACTION_STANDING_LABEL8] = { r = 1.0, g = 1.0, b = 1.0 },		-- exalted
}

local currentXPack = 1					-- default to wow classic
local currentFactionGroup = (UnitFactionGroup("player") == "Alliance") and 1 or 2	-- default to alliance or horde

addon.Reputations = {}

local ns = addon.Reputations		-- ns = namespace

local function DDM_AddTitle(text)
	-- tiny wrapper
	local info = UIDropDownMenu_CreateInfo(); 

	info.isTitle	= 1
	info.text		= text
	info.checked	= nil
	info.notCheckable = 1
	info.icon		= nil
	UIDropDownMenu_AddButton(info, 1)
end

local function DDM_Add(text, func, arg1, arg2)
	-- tiny wrapper
	local info = UIDropDownMenu_CreateInfo(); 
	
	info.text		= text
	info.func		= func
	info.arg1		= arg1
	info.arg2		= arg2
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

local function DDM_OnClick(self, xpackIndex, factionGroupIndex)
	currentXPack = xpackIndex
	currentFactionGroup = factionGroupIndex
	
	local factionGroup = Factions[currentXPack][currentFactionGroup]
	UIDropDownMenu_SetText(AltoholicFrameReputations_SelectFaction, factionGroup.name)
	
	ns:Update()
end

local function Reputations_UpdateEx(self, offset, entry, desc)
	local line
	local size = desc:GetSize()
	
	local DS = DataStore
	local realm, account = addon:GetCurrentRealm()
	local character
	local factionGroup = Factions[currentXPack][currentFactionGroup]
	
	for i=1, desc.NumLines do
		line = i + offset
		if line <= size then
			local faction = factionGroup[line]
		
			_G[entry..i.."Name"]:SetText(WHITE .. faction.name)
			_G[entry..i.."Name"]:SetJustifyH("LEFT")
			_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
			
			for j = 1, 10 do	-- loop through the 10 alts
				local itemName = entry.. i .. "Item" .. j;
				local itemButton = _G[itemName]
				local classButton = _G["AltoholicFrameClassesItem" .. j]
				
				local itemTexture = _G[itemName .. "_Background"]
				itemTexture:SetTexture("Interface\\Icons\\"..faction.icon)

				local status, rate
				if classButton.CharName then	-- if there's an alt in this column..
					character = DS:GetCharacter(classButton.CharName, realm, account)
					status, _, _, rate = DS:GetReputationInfo(character, faction.name)
				
					if status and rate then 
						local vc = VertexColors[status]
						itemTexture:SetVertexColor(vc.r, vc.g, vc.b);
						
						local text
						if status == FACTION_STANDING_LABEL8 then
							_G[itemName .. "Name"]:SetPoint("BOTTOMRIGHT", 5, 0)
							text = ICON_EXALTED
						else
							_G[itemName .. "Name"]:SetPoint("BOTTOMRIGHT", -5, 0)
							text = format("%2d", floor(rate)) .. "%"
						end
						
						local color = WHITE
						if status == FACTION_STANDING_LABEL1 or status == FACTION_STANDING_LABEL2 then
							color = DARK_RED
						end

						itemButton.CharName = classButton.CharName
						_G[itemName .. "Name"]:SetText(color..text)
					else
						itemTexture:SetVertexColor(0.3, 0.3, 0.3);	-- greyed out
						_G[itemName .. "Name"]:SetPoint("BOTTOMRIGHT", 5, 0)
						_G[itemName .. "Name"]:SetText(ICON_UNKNOWN)
						itemButton.CharName = nil
					end
					itemButton:Show()				
				else
					itemButton:Hide()
				end
			end
			_G[ entry..i ]:SetID(line)
			_G[ entry..i ]:Show()
		end
	end
end

local ReputationsScrollFrame_Desc = {
	NumLines = 8,
	LineHeight = 41,
	Frame = "AltoholicFrameReputations",
	GetSize = function() return #Factions[currentXPack][currentFactionGroup] end,
	Update = Reputations_UpdateEx,
}

function ns:DropDownFaction_Initialize()
	for xpackIndex, xpack in ipairs(Factions) do
		DDM_AddTitle(xpack.name)
		
		for factionGroupIndex, factionGroup in ipairs(Factions[xpackIndex]) do
			DDM_Add(factionGroup.name, DDM_OnClick, xpackIndex, factionGroupIndex)
		end
	end
	DDM_AddCloseMenu()
end

function ns:Update()
	addon:ScrollFrameUpdate(ReputationsScrollFrame_Desc)
end

function ns:OnEnter(frame)
	local charName = frame.CharName
	if not charName then return end
	
	local DS = DataStore
	local realm, account = addon:GetCurrentRealm()
	local character = DS:GetCharacter(charName, realm, account)
	local factionGroup = Factions[currentXPack][currentFactionGroup]
	local faction = factionGroup[ frame:GetParent():GetID() ].name
	
	local status, currentLevel, maxLevel, rate = DS:GetReputationInfo(character, faction)
	if not status then return end
	
	AltoTooltip:SetOwner(frame, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();
	AltoTooltip:AddLine(DS:GetColoredCharacterName(character) .. WHITE .. " @ " ..	TEAL .. faction,1,1,1);

	rate = format("%d", floor(rate)) .. "%"
	AltoTooltip:AddLine(format("%s: %d/%d (%s)", status, currentLevel, maxLevel, rate),1,1,1 )
				
	local bottom = DS:GetRawReputationInfo(character, faction)
	local suggestion = addon:GetSuggestion(faction, bottom)
	if suggestion then
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddLine("Suggestion: ",1,1,1);
		AltoTooltip:AddLine(TEAL .. suggestion,1,1,1);
	end
	
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(format("%s = %s", ICON_UNKNOWN, UNKNOWN), 0.8, 0.13, 0.13);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL1, 0.8, 0.13, 0.13);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL2, 1.0, 0.0, 0.0);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL3, 0.93, 0.4, 0.13);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL4, 1.0, 1.0, 0.0);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL5, 0.0, 1.0, 0.0);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL6, 0.0, 1.0, 0.53);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL7, 0.0, 1.0, 0.8);
	AltoTooltip:AddLine(format("%s = %s", ICON_EXALTED, FACTION_STANDING_LABEL8), 1, 1, 1);
	
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(GREEN .. L["Shift+Left click to link"]);
	AltoTooltip:Show();
end

function ns:OnClick(frame, button)
	local charName = frame.CharName
	if not charName then return end
	
	local DS = DataStore
	local realm, account = addon:GetCurrentRealm()
	local character = DS:GetCharacter(charName, realm, account)
	local factionGroup = Factions[currentXPack][currentFactionGroup]
	local faction = factionGroup[ frame:GetParent():GetID() ].name
	
	local status, currentLevel, maxLevel, rate = DS:GetReputationInfo(character, faction)
	if not status then return end
	
	if ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
		local chat = ChatEdit_GetLastActiveWindow()
		if chat:IsShown() then
			chat:Insert(format(L["%s is %s with %s (%d/%d)"], charName, status, faction, currentLevel, maxLevel))
		end
	end	
end
