--[[
	Enchantrix:Barker Addon for World of Warcraft(tm).
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: EnchantrixBarker.lua 3767 2008-11-05 17:57:29Z Norganna $
	URL: http://enchantrix.org/

	This is an addon for World of Warcraft that adds the ability to advertise
	your enchants to other players via the Trade channel.

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit license to use this AddOn with these facilities
		since that is its designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat

]]
EnchantrixBarker_RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Enchantrix-Barker/EnchantrixBarker.lua $", "$Rev: 3767 $")

-- ccox - WoW 3.0 API change
local GetCraftInfoFunc = GetCraftInfo or GetTradeSkillInfo;

local priorityList = {};

	-- this is used to search the trade categories
	-- the key is our internal value
	-- search is the string to look for in the enchant name
	-- print is what we print for the output
local categories = {
	['factor_item.bracer'] = {search = _BARKLOC('Bracer'), print = _BARKLOC('Bracer') },
	['factor_item.gloves'] = {search = _BARKLOC('Gloves'), print = _BARKLOC('Gloves') },
	['factor_item.boots'] = {search = _BARKLOC('Boots'), print = _BARKLOC('Boots') },
	['factor_item.shield'] = {search = _BARKLOC('Shield'), print = _BARKLOC('Shield') },
	['factor_item.chest'] = {search = _BARKLOC('Chest'), print = _BARKLOC('Chest') },
	['factor_item.cloak'] = {search = _BARKLOC('Cloak'), print = _BARKLOC('Cloak') },
	['factor_item.2hweap'] = {search = _BARKLOC('TwoHandWeapon'), print = _BARKLOC('TwoHandWeapon')},
	['factor_item.weapon'] = {search = _BARKLOC('Weapon'), print = _BARKLOC('AnyWeapon') },
	['factor_item.ring'] = {search = _BARKLOC('Ring'), print = _BARKLOC('Ring'), exclude = true },	-- currently applies to the enchanter only, can't sell
};


	-- this is used internally only, to determine the order of enchants shown
local print_order = {
	'factor_item.bracer',
	'factor_item.gloves',
	'factor_item.boots',
	'factor_item.chest',
	'factor_item.cloak',
	'factor_item.shield',
	'factor_item.2hweap',
	'factor_item.weapon',
	'factor_item.ring',
};


	-- these are used to search the craft listing
	-- the order of items is important to get the longest match (ie: "resistance to shadow" before "resistance")
	--  	BUT that may not work with locallized strings!   Try to get longer string matches!
	-- search is what we use to search the enchant description text
	--		all strings are reduced to lower case
	-- key is how we lookup percentanges from the settings (internal only)
	-- print is what we print for the output
 -- TODO: check for mistakes and mis-classifications/exceptions, need high level enchanters to check output!
local attributes = {

	{ search = _BARKLOC("EnchSearchCrusader"), key = "factor_stat.other", ignoreValues = true, print = _BARKLOC("Crusader") },	-- incorrectly matched strength
	{ search = _BARKLOC("EnchSearchIntellect"), key = 'factor_stat.intellect', print = _BARKLOC("INT") },
	{ search = _BARKLOC("EnchSearchBoarSpeed"), key = "factor_stat.other", ignoreValues = true, print = _BARKLOC("ShortBoarSpeed") },		-- INCORRECTLY matches stamina?
	{ search = _BARKLOC("EnchSearchStamina"), key = "factor_stat.stamina", print = _BARKLOC("STA") },
	{ search = _BARKLOC("EnchSearchSpirit"), key = "factor_stat.spirit", print = _BARKLOC("SPI") },
	{ search = _BARKLOC("EnchSearchStrength"), key = "factor_stat.strength", print = _BARKLOC("STR") },
	{ search = _BARKLOC("EnchSearchCatSwiftness"), key = "factor_stat.other", ignoreValues = true, print = _BARKLOC("ShortCatSwiftness") },	-- INCORRECTLY matches agility?
	{ search = _BARKLOC("EnchSearchMongoose"), key = "factor_stat.other", ignoreValues = true, print = _BARKLOC("ShortMongoose") },			-- INCORRECTLY matches agility?
	{ search = _BARKLOC("EnchSearchAgility"), key = "factor_stat.agility", print = _BARKLOC("AGI") },
	{ search = _BARKLOC("EnchSearchFireRes"), key = "factor_stat.fireRes", print = _BARKLOC("FireRes") },
	{ search = _BARKLOC("EnchSearchResFire"), key = "factor_stat.fireRes", print = _BARKLOC("FireRes") },
	{ search = _BARKLOC("EnchSearchFrostRes"), key = "factor_stat.frostRes", print = _BARKLOC("FrostRes") },
	{ search = _BARKLOC("EnchSearchNatureRes"), key = "factor_stat.natureRes", print = _BARKLOC("NatureRes") },
	{ search = _BARKLOC("EnchSearchResShadow"), key = "factor_stat.shadowRes", print = _BARKLOC("ShadowRes") },
	{ search = _BARKLOC("EnchSearchAllStats"), key = "factor_stat.all", print = _BARKLOC("AllStats") },
	{ search = _BARKLOC("EnchSearchSpellsurge"), key = "factor_stat.other", ignoreValues = true, print = _BARKLOC("ShortSpellSurge") },		-- INCORRECTLY matches mana?
	{ search = _BARKLOC("EnchSearchVitality"), key = "factor_stat.other", ignoreValues = true, print = _BARKLOC("ShortVitality") },			-- INCORRECTLY matches health and mana?
	{ search = _BARKLOC("EnchSearchManaPerFive"), key = "factor_stat.other", print = _BARKLOC("ShortManaPerFive") },						-- INCORRECTLY matches mana
	{ search = _BARKLOC("EnchSearchMana"), key = "factor_stat.mana", print = _BARKLOC("ShortMana") },
	{ search = _BARKLOC("EnchSearchBattlemaster"), key = "factor_stat.other", ignoreValues = true, print = _BARKLOC("ShortBattlemaster") },	-- INCORRECTLY matches health?
	{ search = _BARKLOC("EnchSearchHealth"), key = "factor_stat.health", print = _BARKLOC("ShortHealth") },
	{ search = _BARKLOC("EnchSearchSunfire"), key = "factor_stat.other", ignoreValues = true, print = _BARKLOC("ShortSunfire") },			-- INCORRECTLY matches damage?
	{ search = _BARKLOC("EnchSearchSoulfrost"), key = "factor_stat.other", ignoreValues = true, print = _BARKLOC("ShortSoulfrost") },		-- INCORRECTLY matches damage?
	{ search = _BARKLOC("EnchSearchBeastslayer"), key = "factor_stat.other", print = _BARKLOC("ShortBeastslayer") },						-- INCORRECTLY matches damage?
	{ search = _BARKLOC("EnchSearchSpellPower1"), key = "factor_stat.other", print = _BARKLOC("ShortSpellPower") },							-- INCORRECTLY matches damage?		weapon "spell power"
	{ search = _BARKLOC("EnchSearchSpellPower2"), key = "factor_stat.other", print = _BARKLOC("ShortSpellPower") },							-- INCORRECTLY matches damage?		weapon "major spell power"
	{ search = _BARKLOC("EnchSearchSpellPower3"), key = "factor_stat.other", print = _BARKLOC("ShortSpellPower") },							-- INCORRECTLY matches damage?		bracer, ring, gloves "spell power"
	{ search = _BARKLOC("EnchSearchHealing"), key = "factor_stat.other", print = _BARKLOC("ShortHealing") },								-- INCORRECTLY matches spell power after Blizzard changed the strings
	{ search = _BARKLOC("EnchSearchDMGAbsorption"), key = "factor_stat.damageAbsorb", print = _BARKLOC("DMGAbsorb") },			-- must come before armor and damage
	{ search = _BARKLOC("EnchSearchDamage1"), key = "factor_stat.damage", print = _BARKLOC("DMG") },
	{ search = _BARKLOC("EnchSearchDamage2"), key = "factor_stat.damage", print = _BARKLOC("DMG") },
	{ search = _BARKLOC("EnchSearchDefense"),  key = "factor_stat.defense", print = _BARKLOC("DEF") },
	{ search = _BARKLOC("EnchSearchAllResistance1"), key = "factor_stat.allRes", print = _BARKLOC("ShortAllRes") },
	{ search = _BARKLOC("EnchSearchAllResistance2"), key = "factor_stat.allRes", print = _BARKLOC("ShortAllRes") },
	{ search = _BARKLOC("EnchSearchAllResistance3"), key = "factor_stat.allRes", print = _BARKLOC("ShortAllRes") },
	{ search = _BARKLOC("EnchSearchArmor"), key = "factor_stat.armor", print = _BARKLOC("ShortArmor") },						-- too general, has to come near last

};

--[[
Other possible exceptions or additions

	{ search = 'damage against elementals', key = "factor_stat.other", print = "Elemental" },		-- probably safe
	{ search = 'damage to demons', key = "factor_stat.other", print = "Demon" },					-- probably safe
	{ search = 'frost spells', key = "factor_stat.other", print = "frost" },						-- probably safe
	{ search = 'frost damage', key = "factor_stat.other", print = "frost" },						-- probably safe
	{ search = 'shadow damage', key = "factor_stat.other", print = "shadow" },						-- probably safe
	{ search = "increase fire damage", key = "factor_stat.other", print = "fire" },					-- probably safe
	{ search = 'block rating', key = "factor_stat.other", print = "block" },						-- probably safe
	{ search = 'block value', key = "factor_stat.other", print = "block" },							-- probably safe

Other... (these should be ok as-is)
surefooted "snare and root resistance"
spell strike "spell hit rating"
spell penetration  "spell penetration"
blasting  "spell critical strike rating"
savagery 	"attack power"
haste "attack speed bonus"
stealth  "increase to stealth"
dodge  "dodge rating"
assult  "increase attack power"
enchanted leather "Enchanted Leather"
enchanted thorium "Enchanted Thorium Bar"
brawn  "increase Strength"										-- correctly matches strength

]]


	-- this is used to match up trade zone game names with short strings for the output
local short_location = {
	[_BARKLOC('Orgrimmar')] = _BARKLOC('ShortOrgrimmar'),
	[_BARKLOC('ThunderBluff')] = _BARKLOC('ShortThunderBluff'),
	[_BARKLOC('Undercity')] = _BARKLOC('ShortUndercity'),
	[_BARKLOC('StormwindCity')] = _BARKLOC('ShortStormwind'),
	[_BARKLOC('Darnassus')] = _BARKLOC('ShortDarnassus'),
	[_BARKLOC('Ironforge')] = _BARKLOC('ShortIronForge'),
	[_BARKLOC('Shattrath')] = _BARKLOC('ShortShattrath'),
	[_BARKLOC('SilvermoonCity')] = _BARKLOC('ShortSilvermoon'),
	[_BARKLOC('TheExodar')] = _BARKLOC('ShortExodar'),
-- TODO - ccox - localize me!
	['Dalaran'] = 'Dalaran',
};


local relevelFrame;
local relevelFrames;

local addonName = "Enchantrix Barker"

-- UI code

local function getGSC(money)
	money = math.floor(tonumber(money) or 0)
	local g = math.floor(money / 10000)
	local s = math.floor(money % 10000 / 100)
	local c = money % 100
	return g,s,c
end

function EnchantrixBarker_OnEvent()

	--Returns "Enchanting" for enchantwindow
	local GetTradeLineFunc = GetCraftDisplaySkillLine or GetTradeSkillLine	-- ccox - WoW 3.0 - GetCraft routines are gone
	local craftName, _rank, _maxRank = GetTradeLineFunc();

	if craftName and craftName == _BARKLOC('Enchanting') then
		if( event == "CRAFT_SHOW" or event == "TRADE_SKILL_SHOW") then
			if( Barker.Settings.GetSetting('barker') ) then
				Enchantrix_BarkerDisplayButton:Show();
				Enchantrix_BarkerDisplayButton.tooltipText = _BARKLOC('OpenBarkerWindow');
			else
				Enchantrix_BarkerDisplayButton:Hide();
				Enchantrix_BarkerOptions_Frame:Hide();
			end
		end
	elseif (event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE" or event == "CRAFT_CLOSE" ) then
		-- we are closing, or it's a different craft/trade, hide the button and frame
		Enchantrix_BarkerDisplayButton:Hide();
		Enchantrix_BarkerOptions_Frame:Hide();
	end


	-- ccox - WoW 3.0 - Tradeskill Window no longer has space for the button
	if select(4, GetBuildInfo() ) >= 30000 then
		if craftName and craftName == _BARKLOC('Enchanting') then
			if( event == "CRAFT_SHOW" or event == "TRADE_SKILL_SHOW") then
				if( Barker.Settings.GetSetting('barker') ) then
					Enchantrix_BarkerOptions_TradeTab:Show();
					Enchantrix_BarkerOptions_TradeTab.tooltipText = _BARKLOC('OpenBarkerWindow');
				else
					Enchantrix_BarkerOptions_TradeTab:Hide();
					Enchantrix_BarkerOptions_TradeTab:Hide();
				end
			end
		elseif (event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE" or event == "CRAFT_CLOSE" ) then
			-- we are closing, or it's a different craft/trade, hide the button and frame
			Enchantrix_BarkerOptions_TradeTab:Hide();
			Enchantrix_BarkerOptions_TradeTab:Hide();
		end
	end


	-- ccox - WoW 3.0 - Tradeskill Window no longer has space for the button
	if select(4, GetBuildInfo() ) >= 30000 then
		if craftName and craftName == _BARKLOC('Enchanting') then
			if( event == "CRAFT_SHOW" or event == "TRADE_SKILL_SHOW") then
				if( Barker.Settings.GetSetting('barker') ) then
					Enchantrix_BarkerOptions_TradeTab:Show();
					Enchantrix_BarkerOptions_TradeTab.tooltipText = _BARKLOC('OpenBarkerWindow');
				else
					Enchantrix_BarkerOptions_TradeTab:Hide();
					Enchantrix_BarkerOptions_TradeTab:Hide();
				end
			end
		elseif (event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE" or event == "CRAFT_CLOSE" ) then
			-- we are closing, or it's a different craft/trade, hide the button and frame
			Enchantrix_BarkerOptions_TradeTab:Hide();
			Enchantrix_BarkerOptions_TradeTab:Hide();
		end
	end
	
end

function Enchantrix_BarkerOptions_OnShow()
	Enchantrix_BarkerOptions_ShowFrame(1);
end

function Enchantrix_BarkerOnClick()
	local barker = Enchantrix_CreateBarker();
	local id = GetChannelName( _BARKLOC("TradeChannel") ) ;
	--Barker.Util.DebugPrintQuick("Attempting to send barker ", barker, " Trade Channel ID ", id)

	if (id and (not(id == 0))) then
		if (barker) then
			SendChatMessage(barker,"CHANNEL", GetDefaultLanguage("player"), id);
		end
	else
		Barker.Util.ChatPrint( _BARKLOC("BarkerNotTradeZone") );
	end
end

function Barker.Barker.AddonLoaded()
	Barker.Util.ChatPrint( _BARKLOC("BarkerLoaded") );
end

function relevelFrame(frame)
	return relevelFrames(frame:GetFrameLevel() + 2, frame:GetChildren())
end

function relevelFrames(myLevel, ...)
	for i = 1, select("#", ...) do
		local child = select(i, ...)
		child:SetFrameLevel(myLevel)
		relevelFrame(child)
	end
end

local function craftUILoaded()

	Stubby.UnregisterAddOnHook("Blizzard_CraftUI", "Enchantrix")
	Stubby.UnregisterAddOnHook("Blizzard_TradeSkillUI", "Enchantrix")

	-- ccox - CraftFrame pre LK / 3.0, TradeSkillFrame after (where CraftFrame is nil)
	local useFrame = CraftFrame or TradeSkillFrame;

	if (ATSWFrame ~= nil) then
		Stubby.UnregisterAddOnHook("ATSWFrame", "Enchantrix")
		useFrame = ATSWFrame;
	end
	
	-- ccox - WoW 3.0 - the tradskill window no longer has room for the barker button
	if select(4, GetBuildInfo() ) >= 30000 then
		Enchantrix_BarkerOptions_TradeTab:SetParent(useFrame);
		if (ATSWFrame ~= nil) then
			-- this works for ATSW
			Enchantrix_BarkerOptions_TradeTab:SetPoint("TOPLEFT", useFrame, "BOTTOMLEFT", 10, 15 );
		else
			-- and this works for the WoW 3.0 trade Window
			Enchantrix_BarkerOptions_TradeTab:SetPoint("TOPLEFT", useFrame, "BOTTOMLEFT", 10, 75 );
		end
	else
		Enchantrix_BarkerDisplayButton:SetParent(useFrame);
	
		if (ATSWFrame ~= nil) then
			-- this works for ATSW
			Enchantrix_BarkerDisplayButton:SetPoint("TOPRIGHT", useFrame, "TOPRIGHT", -185, -51 );
		else
			-- and this works for the WoW 2.1 trade Window
			Enchantrix_BarkerDisplayButton:SetPoint("TOPRIGHT", useFrame, "TOPRIGHT", -185, -68 );
		end
	end

	-- skillet has an API to add buttons
	if SkilletFrame then
	    local frame = Skillet:AddButtonToTradeskillWindow(Enchantrix_BarkerDisplayButton)
	    useFrame = frame;
	end

	Enchantrix_BarkerOptions_Frame:SetParent(useFrame);
	Enchantrix_BarkerOptions_Frame:SetPoint("TOPLEFT", useFrame, "TOPRIGHT");
	relevelFrame(Enchantrix_BarkerOptions_Frame)

end

function EnchantrixBarker_OnLoad()
	if (ATSWFrame ~= nil) then
		Stubby.RegisterAddOnHook("ATSWFrame", "Enchantrix", craftUILoaded)
	end
	Stubby.RegisterAddOnHook("Blizzard_CraftUI", "Enchantrix", craftUILoaded)			-- pre 3.0
	Stubby.RegisterAddOnHook("Blizzard_TradeSkillUI", "Enchantrix", craftUILoaded)		-- post 3.0
end

function Enchantrix_BarkerGetConfig( key )
	return Barker.Settings.GetSetting("barker."..key)
end

function Enchantrix_BarkerSetConfig( key, value )
	Barker.Settings.SetSetting("barker."..key, value)
end

function Enchantrix_BarkerOptions_SetDefaults()
	-- currently, we have no settings other than what's in the dialog
	-- resetting the WHOLE profile will reset everything

	Barker.Settings.SetSetting("barker.reset_all", nil)

	if Enchantrix_BarkerOptions_Frame:IsVisible() then
		Enchantrix_BarkerOptions_Refresh()
	end
end

function Enchantrix_BarkerOptions_ResetButton_OnClick()
	-- reset all slider values
	Enchantrix_BarkerOptions_SetDefaults();
end

function Enchantrix_BarkerOptions_TestButton_OnClick()
	local barker = Enchantrix_CreateBarker();
	local id = GetChannelName( _BARKLOC("TradeChannel") )
	--Barker.Util.DebugPrintQuick("Attempting to send test barker ", barker, "Trade Channel ID ", id)

	if (id and (not(id == 0))) then
		if (barker) then
			Barker.Util.ChatPrint(barker);
		end
	else
		Barker.Util.ChatPrint( _BARKLOC("BarkerNotTradeZone") );
	end
end

function Enchantrix_BarkerOptions_Factors_Slider_GetValue(id)
	if (not id) then
		id = this:GetID();
	end
	return Enchantrix_BarkerGetConfig(Enchantrix_BarkerOptions_TabFrames[Enchantrix_BarkerOptions_ActiveTab].options[id].key);
end

function Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged(id)
	if (not id) then
		id = this:GetID();
	end
	Enchantrix_BarkerSetConfig(Enchantrix_BarkerOptions_TabFrames[Enchantrix_BarkerOptions_ActiveTab].options[id].key, this:GetValue());
end

Enchantrix_BarkerOptions_ActiveTab = -1;


Enchantrix_BarkerOptions_TabFrames = {
	{
		title = _BARKLOC('BarkerOptionsTab1Title'),
		options = {
			{
				name = _BARKLOC('BarkerOptionsProfitMarginTitle'),
				tooltip = _BARKLOC('BarkerOptionsProfitMarginTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'profit_margin',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsHighestProfitTitle'),
				tooltip = _BARKLOC('BarkerOptionsHighestProfitTooltip'),
				units = 'money',
				min = 0,
				max = 250000,
				step = 500,
				key = 'highest_profit',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsLowestPriceTitle'),
				tooltip = _BARKLOC('BarkerOptionsLowestPriceTooltip'),
				units = 'money',
				min = 0,
				max = 50000,
				step = 500,
				key = 'lowest_price',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsPricePriorityTitle'),
				tooltip = _BARKLOC('BarkerOptionsPricePriorityTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_price',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsPriceSweetspotTitle'),
				tooltip = _BARKLOC('BarkerOptionsPriceSweetspotTooltip'),
				units = 'money',
				min = 0,
				max = 500000,
				step = 5000,
				key = 'sweet_price',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsHighestPriceForFactorTitle'),
				tooltip = _BARKLOC('BarkerOptionsHighestPriceForFactorTooltip'),
				units = 'money',
				min = 0,
				max = 1000000,
				step = 50000,
				key = 'high_price',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsRandomFactorTitle'),
				tooltip = _BARKLOC('BarkerOptionsRandomFactorTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'randomise',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
		}
	},
	{
		title = 'Item Priorities',
		options = {
			{
				name = _BARKLOC('BarkerOptionsItemsPriority'),
				tooltip = _BARKLOC('BarkerOptionsItemsPriorityTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_item',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('TwoHandWeapon'),
				tooltip = _BARKLOC('BarkerOptions2HWeaponPriorityTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_item.2hweap',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('AnyWeapon'),
				tooltip = _BARKLOC('BarkerOptionsAnyWeaponPriorityTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_item.weapon',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('Bracer'),
				tooltip = _BARKLOC('BarkerOptionsBracerPriorityTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_item.bracer',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('Gloves'),
				tooltip = _BARKLOC('BarkerOptionsGlovesPriorityTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_item.gloves',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('Boots'),
				tooltip = _BARKLOC('BarkerOptionsBootsPriorityTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_item.boots',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('Chest'),
				tooltip = _BARKLOC('BarkerOptionsChestPriorityTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_item.chest',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('Cloak'),
				tooltip = _BARKLOC('BarkerOptionsCloakPriorityTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_item.cloak',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('Shield'),
				tooltip = _BARKLOC('BarkerOptionsShieldPriorityTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_item.shield',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
		}
	},
	{
		title = 'Stats 1',
		options = {
			{
				name = _BARKLOC('BarkerOptionsStatsPriority'),
				tooltip = _BARKLOC('BarkerOptionsStatsPriorityTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_stat',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsIntellectPriority'),
				tooltip = _BARKLOC('BarkerOptionsIntellectPriorityTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_stat.intellect',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsStrengthPriority'),
				tooltip = _BARKLOC('BarkerOptionsStrengthPriorityTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_stat.strength',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsAgilityPriority'),
				tooltip = _BARKLOC('BarkerOptionsAgilityPriorityTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_stat.agility',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsStaminaPriority'),
				tooltip = _BARKLOC('BarkerOptionsStaminaPriorityTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_stat.stamina',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsSpiritPriority'),
				tooltip = _BARKLOC('BarkerOptionsSpiritPriorityTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_stat.spirit',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsArmorPriority'),
				tooltip = _BARKLOC('BarkerOptionsArmorPriorityTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_stat.armor',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsAllStatsPriority'),
				tooltip = _BARKLOC('BarkerOptionsAllStatsPriorityTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_stat.all',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
		}
	},
	{
		title = 'Stats 2',
		options = {
			{
				name = _BARKLOC('BarkerOptionsAllResistances'),
				tooltip = _BARKLOC('BarkerOptionsAllResistancesTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_stat.allRes',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsFireResistance'),
				tooltip = _BARKLOC('BarkerOptionsFireResistanceTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_stat.fireRes',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsFrostResistance'),
				tooltip = _BARKLOC('BarkerOptionsFrostResistanceTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_stat.frostRes',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsNatureResistance'),
				tooltip = _BARKLOC('BarkerOptionsNatureResistanceTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_stat.natureRes',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsShadowResistance'),
				tooltip = _BARKLOC('BarkerOptionsShadowResistanceTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_stat.shadowRes',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsMana'),
				tooltip = _BARKLOC('BarkerOptionsManaTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_stat.mana',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsHealth'),
				tooltip = _BARKLOC('BarkerOptionsHealthTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_stat.health',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsDamage'),
				tooltip = _BARKLOC('BarkerOptionsDamageTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_stat.damage',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsDefense'),
				tooltip = _BARKLOC('BarkerOptionsDefenseTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_stat.defense',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = _BARKLOC('BarkerOptionsOther'),
				tooltip = _BARKLOC('BarkerOptionsOtherTooltip'),
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_stat.other',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
		}
	}
};

function EnchantrixBarker_OptionsSlider_OnValueChanged()
	if Enchantrix_BarkerOptions_ActiveTab ~= -1 then
		--Barker.Util.ChatPrint( "Tab - Slider changed: "..Enchantrix_BarkerOptions_ActiveTab..' - '..this:GetID() );
		Enchantrix_BarkerOptions_TabFrames[Enchantrix_BarkerOptions_ActiveTab].options[this:GetID()].valuechanged();
		value = this:GetValue();
		--Enchantrix_BarkerOptions_TabFrames[Enchantrix_BarkerOptions_ActiveTab].options[this:GetID()].getvalue();

		valuestr = EnchantrixBarker_OptionsSlider_GetTextFromValue( value, Enchantrix_BarkerOptions_TabFrames[Enchantrix_BarkerOptions_ActiveTab].options[this:GetID()].units );

		getglobal(this:GetName().."Text"):SetText(Enchantrix_BarkerOptions_TabFrames[Enchantrix_BarkerOptions_ActiveTab].options[this:GetID()].name.." - "..valuestr );
	end
end

function EnchantrixBarker_OptionsSlider_GetTextFromValue( value, units )

	local valuestr = ''

	if units == 'percentage' then
		valuestr = value..'%'
	elseif units == 'money' then
		local p_gold,p_silver,p_copper = getGSC(value);

		if( p_gold > 0 ) then
			valuestr = p_gold.."g";
		end
		if( p_silver > 0 ) then
			valuestr = valuestr..p_silver.."s";
		end
	end
	return valuestr;
end

function Enchantrix_BarkerOptions_Tab_OnClick()
	--Barker.Util.ChatPrint( "Clicked Tab: "..this:GetID() );
	Enchantrix_BarkerOptions_ShowFrame( this:GetID() )

end

function Enchantrix_BarkerOptions_Refresh()
	local cur = Enchantrix_BarkerOptions_ActiveTab
	if (cur and cur > 0) then
		Enchantrix_BarkerOptions_ShowFrame(cur)
	end
end

function Enchantrix_BarkerOptions_ShowFrame( frame_index )
	Enchantrix_BarkerOptions_ActiveTab = -1
	for index, frame in pairs(Enchantrix_BarkerOptions_TabFrames) do
		if ( index == frame_index ) then
			--Barker.Util.ChatPrint( "Showing Frame: "..index );
			for i = 1,10 do
				local slider = getglobal('EnchantrixBarker_OptionsSlider_'..i);
				slider:Hide();
			end
			for i, opt in pairs(frame.options) do
				local slidername = 'EnchantrixBarker_OptionsSlider_'..i
				local slider = getglobal(slidername);
				slider:SetMinMaxValues(opt.min, opt.max);
				slider:SetValueStep(opt.step);
				slider.tooltipText = opt.tooltip;
				getglobal(slidername.."High"):SetText();
				getglobal(slidername.."Low"):SetText();
				slider:Show();
			end
			Enchantrix_BarkerOptions_ActiveTab = index
			for i, opt in pairs(frame.options) do
				local slidername = 'EnchantrixBarker_OptionsSlider_'..i
				local slider = getglobal(slidername);
				local newValue = opt.getvalue(i);
				slider:SetValue(newValue);
				getglobal(slidername.."Text"):SetText(opt.name..' - '..EnchantrixBarker_OptionsSlider_GetTextFromValue(slider:GetValue(),opt.units));
			end
		end
	end
end

function Enchantrix_BarkerOptions_OnClick()
	--Barker.Util.ChatPrint("You pressed the options button." );
	--showUIPanel(Enchantrix_BarkerOptions_Frame);
	if not Enchantrix_BarkerOptions_Frame:IsShown() then
		Enchantrix_BarkerOptions_Frame:Show();
	else
		Enchantrix_BarkerOptions_Frame:Hide();
	end
end

function Enchantrix_CheckButton_OnShow()
end
function Enchantrix_CheckButton_OnClick()
end
function Enchantrix_CheckButton_OnEnter()
end
function Enchantrix_CheckButton_OnLeave()
end

--[[
function Enchantrix_BarkerOptions_ChanFilterDropDown_Initialize()

		local dropdown = this:GetParent();
		local frame = dropdown:GetParent();

		ChnPtyBtn		= {};
		ChnPtyBtn.text	= _BARKLOC('ChannelParty');
		ChnPtyBtn.func	= Enchantrix_BarkerOptions_ChanFilterDropDownItem_OnClick;
		ChnPtyBtn.owner	= dropdown
		UIDropDownMenu_AddButton(ChnPtyBtn)

		ChnRdBtn		= {};
	    ChnRdBtn.text	= _BARKLOC('ChannelRaid');
		ChnRdBtn.func	= Enchantrix_BarkerOptions_ChanFilterDropDownItem_OnClick;
		ChnRdBtn.owner	= dropdown
		UIDropDownMenu_AddButton(ChnRdBtn)

		ChnGldBtn		= {};
		ChnGldBtn.text	= _BARKLOC('ChannelGuild');
		ChnGldBtn.func	= Enchantrix_BarkerOptions_ChanFilterDropDownItem_OnClick;
		ChnGldBtn.owner	= dropdown
		UIDropDownMenu_AddButton(ChnGldBtn)

		ChnTlRBtn		= {};
		ChnTlRBtn.text	= _BARKLOC('ChannelTellRec');
		ChnTlRBtn.func	= Enchantrix_BarkerOptions_ChanFilterDropDownItem_OnClick;
		ChnTlRBtn.owner	= dropdown
		UIDropDownMenu_AddButton(ChnTlRBtn)

		ChnTlSBtn		= {};
		ChnTlSBtn.text	= _BARKLOC('ChannelTellSent');
		ChnTlSBtn.func	= Enchantrix_BarkerOptions_ChanFilterDropDownItem_OnClick;
		ChnTlSBtn.owner	= dropdown
		UIDropDownMenu_AddButton(ChnTlSBtn)

		ChnSayBtn		= {};
		ChnSayBtn.text	= _BARKLOC('ChannelSay');
		ChnSayBtn.func	= Enchantrix_BarkerOptions_ChanFilterDropDownItem_OnClick;
		ChnSayBtn.owner	= dropdown
		UIDropDownMenu_AddButton(ChnSayBtn)

		local chanlist = {GetChannelList()}; --GetChannelList can be buggy.
		local ZoneName = GetRealZoneText();

		for i = 1, table.getn(chanlist) do
			id, channame = GetChannelName(i);

			if ((channame) and  (channame ~= (_BARKLOC('ChannelGeneral')..ZoneName)) and
			 (channame ~= (_BARKLOC('ChannelLocalDefense')..ZoneName)) and (channame ~= _BARKLOC('ChannelWorldDefense')) and
			 (channame ~= _BARKLOC('ChannelGuildRecruitment')) and (channame ~= _BARKLOC('ChannelBlock1')) ) then
					info	= {};
				info.text	= channame;
				info.value	= i;
				info.func	= Enchantrix_BarkerOptions_ChanFilterDropDownItem_OnClick;
				info.owner	= dropdown;
				UIDropDownMenu_AddButton(info)
			end
       end
end

function Enchantrix_BarkerOptions_ChanFilterDropDown_OnClick()
       ToggleDropDownMenu(1, nil, Enchantrix_BarkerOptions_ChanFilterDropDown, "cursor");
end

-- The following is shamelessly lifted from auctioneer/UserInterace/AuctioneerUI.lua
-------------------------------------------------------------------------------
-- Wrapper for UIDropDownMenu_Initialize() that sets 'this' before calling
-- UIDropDownMenu_Initialize().
-------------------------------------------------------------------------------
function dropDownMenuInitialize(dropdown, func)
	-- Hide all the buttons to prevent any calls to Hide() inside
	-- UIDropDownMenu_Initialize() which will screw up the value of this.
	local button, dropDownList;
	for i = 1, UIDROPDOWNMENU_MAXLEVELS, 1 do
		dropDownList = getglobal("DropDownList"..i);
		if ( i >= UIDROPDOWNMENU_MENU_LEVEL or dropdown:GetName() ~= UIDROPDOWNMENU_OPEN_MENU ) then
			dropDownList.numButtons = 0;
			dropDownList.maxWidth = 0;
			for j=1, UIDROPDOWNMENU_MAXBUTTONS, 1 do
				button = getglobal("DropDownList"..i.."Button"..j);
				button:Hide();
			end
		end
	end

	-- Call the UIDropDownMenu_Initialize() after swapping in a value for 'this'.
	local oldThis = this;
	this = getglobal(dropdown:GetName().."Button");
	local newThis = this;
	UIDropDownMenu_Initialize(dropdown, func);
	-- Double check that the value of 'this' didn't change... this can screw us
	-- up and prevent the reason for this method!
	if (newThis ~= this) then
		Barker.Util.DebugPrintQuick("WARNING: The value of this changed during dropDownMenuInitialize()")
	end
	this = oldThis;
end

-------------------------------------------------------------------------------
-- Wrapper for UIDropDownMenu_SetSeletedID() that sets 'this' before calling
-- UIDropDownMenu_SetSelectedID().
-------------------------------------------------------------------------------
function dropDownMenuSetSelectedID(dropdown, index)
	local oldThis = this;
	this = dropdown;
	local newThis = this;
	UIDropDownMenu_SetSelectedID(dropdown, index);
	-- Double check that the value of 'this' didn't change... this can screw us
	-- up and prevent the reason for this method!
	if (newThis ~= this) then
		Barker.Util.DebugPrintQuick("WARNING: The value of this changed during dropDownMenuSetSelectedID()")
	end
	this = oldThis;
end

function Enchantrix_BarkerOptions_ChanFilterDropDownItem_OnClick()
	local index = this:GetID();
	local dropdown = this.owner;

	dropDownMenuSetSelectedID(dropdown, index);
	Enchantrix_BarkerSetConfig("barker_chan", this:GetText())
end
]]

-- end UI code

function Enchantrix_CreateBarker()

	if (not EnchantrixBarker_BarkerGetZoneText()) then
		-- not in a recognized trade zone
		return nil;
	end
	
	local temp
	if select(4, GetBuildInfo() ) >= 30000 then
		temp = GetTradeSkillLine();
	else
		temp = GetCraftSkillLine(1);
	end

	local temp
	if select(4, GetBuildInfo() ) >= 30000 then
		temp = GetTradeSkillLine();
	else
		temp = GetCraftSkillLine(1);
	end

	if (not temp) then
		-- trade skill window isn't open (how did this happen?)
		Barker.Util.ChatPrint(_BARKLOC('BarkerEnxWindowNotOpen'));
		return nil;
	end

	local availableEnchants = {};
	local numAvailable = 0;

	EnchantrixBarker_ResetBarkerString();
	EnchantrixBarker_ResetPriorityList();

	local highestProfit = Enchantrix_BarkerGetConfig("highest_profit");
	local profitMargin = Enchantrix_BarkerGetConfig("profit_margin");

	-- ccox - WoW 3.0 - API change
	local GetNumCraftsFunc = GetNumCrafts or GetNumTradeSkills
	local GetCraftItemLinkFunc = GetCraftItemLink or GetTradeSkillItemLink
	local GetCraftNumReagentsFunc = GetCraftNumReagents or GetTradeSkillNumReagents
	local GetCraftReagentInfoFunc = GetCraftReagentInfo or GetTradeSkillReagentInfo
	local GetCraftReagentItemLinkFunc = GetCraftReagentItemLink or GetTradeSkillReagentItemLink

	local craftCount = GetNumCraftsFunc()

	for index=1, craftCount do

		local craftName, craftSubSpellName, craftType, numEnchantsAvailable, isExpanded;

		-- ccox - WoW 3.0 - API change, and return value change
		if select(4, GetBuildInfo() ) >= 30000 then
			craftName, craftType, numEnchantsAvailable, isExpanded = GetTradeSkillInfo(index);
		else
			craftName, craftSubSpellName, craftType, numEnchantsAvailable, isExpanded = GetCraftInfo(index);
		end

		if ( numEnchantsAvailable > 0 ) then -- user has reagents

			-- does this skill produce an enchant, or a trade good?
			local itemLink = GetCraftItemLinkFunc(index);
			local itemName, newItemLink = GetItemInfo(itemLink);

			-- item name and link are nil for enchants, and valid for produced items (which we want to ignore)
			if (not itemName and not newItemLink) then

				local cost = 0;
				for j=1,GetCraftNumReagentsFunc(index),1 do
					local reagentName,_,countRequired = GetCraftReagentInfoFunc(index,j);
					local reagent = GetCraftReagentItemLinkFunc(index,j);
					cost = cost + (Enchantrix_GetReagentHSP(reagent)*countRequired);
				end

				local profit = cost * profitMargin*0.01;
				if( profit > highestProfit ) then
					profit = highestProfit;
				end
				local price = EnchantrixBarker_RoundPrice(cost + profit);

				local enchant = {
					index = index,
					name = craftName,
					type = craftType,
					available = numEnchantsAvailable,
					isExpanded = isExpanded,
					cost = cost,
					price = price,
					profit = price - cost
				};
				availableEnchants[ numAvailable] = enchant;

				local p_gold,p_silver,p_copper = getGSC(enchant.price);
				local pr_gold,pr_silver,pr_copper = getGSC(enchant.profit);

				EnchantrixBarker_AddEnchantToPriorityList( enchant )
				numAvailable = numAvailable + 1;
			end
		end
	end

	if numAvailable == 0 then
		Barker.Util.ChatPrint(_BARKLOC('BarkerNoEnchantsAvail'));
		return nil
	end

	for i,element in ipairs(priorityList) do
		EnchantrixBarker_AddEnchantToBarker( element.enchant );
	end

	return EnchantrixBarker_GetBarkerString();

end

function EnchantrixBarker_ScoreEnchantPriority( enchant )

	local score_item = 0;

	if Enchantrix_BarkerGetConfig( EnchantrixBarker_GetItemCategoryKey(enchant.index) ) then
		score_item = Enchantrix_BarkerGetConfig( EnchantrixBarker_GetItemCategoryKey(enchant.index) );
		score_item = score_item * Enchantrix_BarkerGetConfig( 'factor_item' )*0.01;
	end

	local score_stat = Enchantrix_BarkerGetConfig( EnchantrixBarker_GetEnchantStat(enchant) );
	if not score_stat then
		score_stat = Enchantrix_BarkerGetConfig( 'factor_stat.other' );
	end

	score_stat = score_stat * Enchantrix_BarkerGetConfig( 'factor_stat' )*0.01;

	local score_price = 0;
	local price_score_floor = Enchantrix_BarkerGetConfig("sweet_price");
	local price_score_ceiling = Enchantrix_BarkerGetConfig("high_price");

	if enchant.price < price_score_floor then
		score_price = (price_score_floor - (price_score_floor - enchant.price))/price_score_floor * 100;
	elseif enchant.price < price_score_ceiling then
		range = (price_score_ceiling - price_score_floor);
		score_price = (range - (enchant.price - price_score_floor))/range * 100;
	end

	score_price = score_price * Enchantrix_BarkerGetConfig( 'factor_price' )*0.01;
	score_total = (score_item + score_stat + score_price);

	return score_total * (1 - Enchantrix_BarkerGetConfig("randomise")*0.01) + math.random(300) * Enchantrix_BarkerGetConfig("randomise")*0.01;
end

function EnchantrixBarker_ResetPriorityList()
	priorityList = {};
end

function EnchantrixBarker_AddEnchantToPriorityList(enchant)

	local enchant_score = EnchantrixBarker_ScoreEnchantPriority( enchant );

	for i,priorityentry in ipairs(priorityList) do
		if( priorityentry.score < enchant_score ) then
			table.insert( priorityList, i, {score = enchant_score, enchant = enchant} );
			return;
		end
	end

	table.insert( priorityList, {score = enchant_score, enchant = enchant} );
end

function EnchantrixBarker_RoundPrice( price )

	local round

	if( price < 5000 ) then
		round = 1000;
	elseif ( price < 20000 ) then
		round = 2500;
	elseif (price < 100000) then
		round = 5000;
	else
		round = 10000;
	end

	odd = math.fmod(price,round);

	price = price + (round - odd);

	if( price < Enchantrix_BarkerGetConfig("lowest_price") ) then
		price = Enchantrix_BarkerGetConfig("lowest_price");
	end

	return price
end

function Enchantrix_GetReagentHSP( itemLink )

	if ((not Enchantrix) or (not Enchantrix.Util)) then
		Barker.Util.ChatPrint(_BARKLOC("MesgNotloaded"));
		return 0;
	end

	local hsp, median, baseline, price5 = Enchantrix.Util.GetReagentPrice( itemLink );

	if hsp == nil then
		hsp = 0;
	end

	-- if auc4 is missing, and auc5 has a price, use the auc5 price
	if (hsp == 0 and AucAdvanced and price5) then
		hsp = price5;
	end

	return hsp;
end

local barkerString = '';
local barkerCategories = {};

function EnchantrixBarker_ResetBarkerString()
	barkerString = "("..EnchantrixBarker_BarkerGetZoneText()..") ".._BARKLOC('BarkerOpening');
	barkerCategories = {};
end

function EnchantrixBarker_BarkerGetZoneText()
	local result = short_location[GetZoneText()];
	if (not result) then
		Barker.Util.DebugPrintQuick("Attempting to use barker in zone", GetZoneText() )
	end
	return result;
end

function EnchantrixBarker_AddEnchantToBarker( enchant )

	local currBarker = EnchantrixBarker_GetBarkerString();

	local category_key = EnchantrixBarker_GetItemCategoryKey( enchant.index )

	-- see if this category (self enchants) should be excluded from barking
	if (categories[category_key] and categories[category_key].exclude) then
		return false;
	end

	local category_string = "";
	local test_category = {};
	if barkerCategories[ category_key ] then
		for i,element in ipairs(barkerCategories[category_key]) do
			--Barker.Util.ChatPrint("Inserting: "..i..", elem: "..element.index );
			table.insert(test_category, element);
		end
	end

	table.insert(test_category, enchant);

	category_string = EnchantrixBarker_GetBarkerCategoryString( test_category );


	if #currBarker + #category_string > 255 then
		return false;
	end

	if not barkerCategories[ category_key ] then
		barkerCategories[ category_key ] = {};
	end

	table.insert( barkerCategories[ category_key ],enchant );

	return true;
end

function EnchantrixBarker_GetBarkerString()
	if not barkerString then EnchantrixBarker_ResetBarkerString() end

	local barker = ""..barkerString;

	for index, key in ipairs(print_order) do
		if( barkerCategories[key] ) then
			barker = barker..EnchantrixBarker_GetBarkerCategoryString( barkerCategories[key] )
		end
	end

	return barker;
end

function EnchantrixBarker_GetBarkerCategoryString( barkerCategory )
	local barkercat = ""
	--Barker.Util.DebugPrintQuick("setting up ", barkerCategory[1].index, EnchantrixBarker_GetItemCategoryString(barkerCategory[1].index) );
	barkercat = barkercat.." ["..EnchantrixBarker_GetItemCategoryString(barkerCategory[1].index)..": ";
	for j,enchant in ipairs(barkerCategory) do
		if( j > 1) then
			barkercat = barkercat..", "
		end
		barkercat = barkercat..EnchantrixBarker_GetBarkerEnchantString(enchant);
	end
	barkercat = barkercat.."]"

	return barkercat
end

function EnchantrixBarker_GetBarkerEnchantString( enchant )
	local p_gold,p_silver,p_copper = getGSC(enchant.price);

	enchant_barker = Enchantrix_GetShortDescriptor(enchant.index).." - ";
	if( p_gold > 0 ) then
		enchant_barker = enchant_barker..p_gold.._BARKLOC('OneLetterGold');
	end
	if( p_silver > 0 ) then
		enchant_barker = enchant_barker..p_silver.._BARKLOC('OneLetterSilver');
	end
	--enchant_barker = enchant_barker..", ";
	return enchant_barker
end

function EnchantrixBarker_GetItemCategoryString( index )

	local enchant = GetCraftInfoFunc( index );

	for key,category in pairs(categories) do
		--Barker.Util.DebugPrintQuick( "cat key: ", key);
		if( enchant:find(category.search ) ~= nil ) then
			--Barker.Util.DebugPrintQuick( "cat key: ", key, ", name: ", category.print, ", enchant: ", enchant );
			return category.print;
		end
	end

	--Barker.Util.DebugPrintQuick("Unknown category for", enchant )

	return 'Unknown';
end

function EnchantrixBarker_GetItemCategoryKey( index )

	local enchant = GetCraftInfoFunc( index );

	for key,category in pairs(categories) do
		--Barker.Util.DebugPrintQuick( "cat key: ", key, ", name: ", category );
		if( enchant:find(category.search ) ~= nil ) then
			return key;
		end
	end

	--Barker.Util.DebugPrintQuick("Unknown category for", enchant )

	return 'Unknown';

end

function EnchantrixBarker_GetCraftDescription( index )

	-- ccox - WoW 3.0 - API change
	if select(4, GetBuildInfo() ) >= 30000 then
		return GetTradeSkillDescription(index) or "";
	else
		return GetCraftDescription(index) or "";
	end
end

function Enchantrix_GetShortDescriptor( index )
	local long_str = EnchantrixBarker_GetCraftDescription(index):lower();

	for index,attribute in ipairs(attributes) do
		if( long_str:find(attribute.search ) ~= nil ) then
			--Barker.Util.DebugPrintQuick("Matched attribute: ", attribute.print, " in: ", long_str);

			local print_string = attribute.print;
			if (print_string == nil) then
				Barker.Util.DebugPrintQuick("Failed print lookup for: ", long_str);		-- should not fail
				print_string = "unknown";
			end

			if (not attribute.ignoreValues) then
				statvalue = long_str:sub(long_str:find('[0-9]+[^%%]'));
				statvalue = statvalue:sub(statvalue:find('[0-9]+'));
				return "+"..statvalue..' '..print_string;
			else
				return print_string;
			end
		end
	end


	local enchant = Barker.Util.Split(GetCraftInfoFunc(index), "-");

	-- this happens for any enchant we don't have a special case for, which is relatively often
	--Barker.Util.DebugPrintQuick("Nomatch in: ", GetCraftInfoFunc(index),  long_str,  enchant  );

	if (enchant == nil) then
		Barker.Util.DebugPrintQuick("Failed enchant split for: ", long_str);		-- should not fail
		return "unknown";
	end

	return enchant[#enchant];
end

function EnchantrixBarker_GetEnchantStat( enchant )
	local index = enchant.index;
	local long_str = EnchantrixBarker_GetCraftDescription(index):lower();

	for index,attribute in ipairs(attributes) do

		--if (not attribute.search) then
		--	Barker.Util.DebugPrintQuick("bad attribute: ", index, attribute  );
		--end

		if( long_str:find(attribute.search) ~= nil ) then
			return attribute.key;
		end
	end

	local enchant = Barker.Util.Split(GetCraftInfoFunc(index), "-");

	return enchant[#enchant];
end
