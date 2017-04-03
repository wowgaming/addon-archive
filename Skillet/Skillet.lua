--[[

Skillet: A tradeskill window replacement.
Copyright (c) 2007 Robert Clark <nogudnik@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

]]--

local MAJOR_VERSION = "1.10-LS"
local MINOR_VERSION = ("$Revision: 163 $"):match("%d+") or 1
local DATE = string.gsub("$Date: 2009-08-15 06:00:40 +0000 (Sat, 15 Aug 2009) $", "^.-(%d%d%d%d%-%d%d%-%d%d).-$", "%1")

Skillet = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0", "AceDB-2.0", "AceHook-2.1")
Skillet.title   = "Skillet"
Skillet.version = MAJOR_VERSION .. "-" .. MINOR_VERSION
Skillet.date    = DATE

-- Pull it into the local namespace, it's faster to access that way
local Skillet = Skillet


local nonLinkingTrade = { [2656] = true, [53428] = true }				-- smelting, runeforging



-- Is a copy of LibPossessions is avaialable, use it for alt
-- character inventory checks
--Skillet.inventoryCheck = LibStub and LibStub:GetLibrary('LibPossessions')

-- Register to have the AceDB class handle data and option persistence for us
Skillet:RegisterDB("SkilletDB", "SkilletDBPC")

-- Global ( across all alts ) options
Skillet:RegisterDefaults('profile', {
    -- user configurable options
    vendor_buy_button = true,
    vendor_auto_buy   = false,
    show_item_notes_tooltip = false,
    show_detailed_recipe_tooltip = true,
    link_craftable_reagents = true,
    queue_craftable_reagents = true,
    display_required_level = false,
    display_shopping_list_at_bank = false,
    display_shopping_list_at_guildbank = false,
    display_shopping_list_at_auction = false,
    transparency = 1.0,
    scale = 1.0,
} )

-- default options for each player/tradeskill

Skillet.defaultOptions = {
	["sortmethod"] = "None",
	["grouping"] = "Blizzard",
	["filtertext"] = "",
	["filterInventory-bag"] = true,
	["filterInventory-vendor"] = true,
	["filterInventory-bank"] = true,
	["filterInventory-alts"] = true,
	["filterLevel"] = 1,
	["hideuncraftable"] = false,
}


Skillet.unknownRecipe = {
	tradeID = 0,
	name = "unknown",
	tools = {},
	reagentData = {},
	cooldown = 0,
	itemID = 0,
	numMade = 0,
	spellID = 0,
}


function DebugSpam(message)
--	DEFAULT_CHAT_FRAME:AddMessage(message)
end

-- Options specific to a single character
Skillet:RegisterDefaults('server', {
    -- we tell Stitch to keep the "recipes" table up to data for us.
    recipes = {},

    -- and any queued up recipes
    queues = {},

    -- notes added to items crafted or used in crafting.
    notes = {},
} )

-- Options specific to a single character
Skillet:RegisterDefaults('char', {
    -- options specific to a current tradeskill
    tradeskill_options = {},

    -- Display alt's items in shopping list
    include_alts = true,
} )

-- Localization
local L = AceLibrary("AceLocale-2.2"):new("Skillet")

-- Events
local AceEvent = AceLibrary("AceEvent-2.0")



-- All the options that we allow the user to control.
local Skillet = Skillet
Skillet.options =
{
	handler = Skillet,
	type = 'group',
	args = {
		features = {
			type = 'group',
			name = L["Features"],
			desc = L["FEATURESDESC"],
			order = 11,
			args = {
				vendor_buy_button = {
					type = "toggle",
					name = L["VENDORBUYBUTTONNAME"],
					desc = L["VENDORBUYBUTTONDESC"],
					get = function()
						return Skillet.db.profile.vendor_buy_button;
					end,
					set = function(value)
						Skillet.db.profile.vendor_buy_button = value;
					end,
					order = 12
				},
				vendor_auto_buy = {
					type = "toggle",
					name = L["VENDORAUTOBUYNAME"],
					desc = L["VENDORAUTOBUYDESC"],
					get = function()
						return Skillet.db.profile.vendor_auto_buy;
					end,
					set = function(value)
						Skillet.db.profile.vendor_auto_buy = value;
					end,
					order = 12
				},
				show_item_notes_tooltip = {
					type = "toggle",
					name = L["SHOWITEMNOTESTOOLTIPNAME"],
					desc = L["SHOWITEMNOTESTOOLTIPDESC"],
					get = function()
						return Skillet.db.profile.show_item_notes_tooltip;
					end,
					set = function(value)
						Skillet.db.profile.show_item_notes_tooltip = value;
					end,
					order = 13
				},
                show_detailed_recipe_tooltip = {
                    type = "toggle",
                    name = L["SHOWDETAILEDRECIPETOOLTIPNAME"],
                    desc = L["SHOWDETAILEDRECIPETOOLTIPDESC"],
                    get = function()
                        return Skillet.db.profile.show_detailed_recipe_tooltip;
                    end,
                    set = function(value)
                        Skillet.db.profile.show_detailed_recipe_tooltip = value;
                    end,
                    order = 14
                },
                link_craftable_reagents = {
                    type = "toggle",
                    name = L["LINKCRAFTABLEREAGENTSNAME"],
                    desc = L["LINKCRAFTABLEREAGENTSDESC"],
                    get = function()
                        return Skillet.db.profile.link_craftable_reagents;
                    end,
                    set = function(value)
                        Skillet.db.profile.link_craftable_reagents = value;
                    end,
                    order = 14
                },
                queue_craftable_reagents = {
                    type = "toggle",
                    name = L["QUEUECRAFTABLEREAGENTSNAME"],
                    desc = L["QUEUECRAFTABLEREAGENTSDESC"],
                    get = function()
                        return Skillet.db.profile.queue_craftable_reagents;
                    end,
                    set = function(value)
                        Skillet.db.profile.queue_craftable_reagents = value;
                    end,
                    order = 15
                },
                display_shopping_list_at_bank = {
                    type = "toggle",
                    name = L["DISPLAYSHOPPINGLISTATBANKNAME"],
                    desc = L["DISPLAYSHOPPINGLISTATBANKDESC"],
                    get = function()
                        return Skillet.db.profile.display_shopping_list_at_bank;
                    end,
                    set = function(value)
                        Skillet.db.profile.display_shopping_list_at_bank = value;
                    end,
                    order = 16
                },
                display_shopping_list_at_guildbank = {
                    type = "toggle",
                    name = L["DISPLAYSHOPPINGLISTATGUILDBANKNAME"],
                    desc = L["DISPLAYSHOPPINGLISTATGUILDBANKDESC"],
                    get = function()
                        return Skillet.db.profile.display_shopping_list_at_guildbank;
                    end,
                    set = function(value)
                        Skillet.db.profile.display_shopping_list_at_guildbank = value;
                    end,
                    order = 16
                },
                display_shopping_list_at_auction = {
                    type = "toggle",
                    name = L["DISPLAYSGOPPINGLISTATAUCTIONNAME"],
                    desc = L["DISPLAYSGOPPINGLISTATAUCTIONDESC"],
                    get = function()
                        return Skillet.db.profile.display_shopping_list_at_auction;
                    end,
                    set = function(value)
                        Skillet.db.profile.display_shopping_list_at_auction = value;
                    end,
                    order = 17
                },
                show_craft_counts = {
                    type = "toggle",
                    name = L["SHOWCRAFTCOUNTSNAME"],
                    desc = L["SHOWCRAFTCOUNTSDESC"],
                    get = function()
                        return Skillet.db.profile.show_craft_counts
                    end,
                    set = function(value)
                        Skillet.db.profile.show_craft_counts = value
                        Skillet:UpdateTradeSkillWindow()
                    end,
                    order = 18,
                },
			}
		},
        appearance = {
            type = 'group',
            name = L["Appearance"],
            desc = L["APPEARANCEDESC"],
            order = 12,
            args = {
                display_required_level = {
                    type = "toggle",
                    name = L["DISPLAYREQUIREDLEVELNAME"],
                    desc = L["DISPLAYREQUIREDLEVELDESC"],
                    get = function()
                        return Skillet.db.profile.display_required_level
                    end,
                    set = function(value)
                        Skillet.db.profile.display_required_level = value
                        Skillet:UpdateTradeSkillWindow()
                    end,
                    order = 1
                },
                transparency = {
                    type = "range",
                    name = L["Transparency"],
                    desc = L["TRANSPARAENCYDESC"],
                    min = 0.1, max = 1, step = 0.05, isPercent = true,
                    get = function()
                        return Skillet.db.profile.transparency
                    end,
                    set = function(t)
                        Skillet.db.profile.transparency = t
                        Skillet:UpdateTradeSkillWindow()
                    end,
                    order = 2,
                },
                scale = {
                    type = "range",
                    name = L["Scale"],
                    desc = L["SCALEDESC"],
                    min = 0.1, max = 1.25, step = 0.05, isPercent = true,
                    get = function()
                        return Skillet.db.profile.scale
                    end,
                    set = function(t)
                        Skillet.db.profile.scale = t
                        Skillet:UpdateTradeSkillWindow()
                    end,
                    order = 3,
                },
                enhanced_recipe_display = {
                    type = "toggle",
                    name = L["ENHANCHEDRECIPEDISPLAYNAME"],
                    desc = L["ENHANCHEDRECIPEDISPLAYDESC"],
                    get = function()
                        return Skillet.db.profile.enhanced_recipe_display
                    end,
                    set = function(value)
                        Skillet.db.profile.enhanced_recipe_display = value
                        Skillet:UpdateTradeSkillWindow()
                    end,
                    order = 2,
                },
            },
        },
 --[[
		inventory = {
            type = "group",
            name = L["Inventory"],
            desc = L["INVENTORYDESC"],
            order = 13,
            args = {
                addons = {
                    type = 'execute',
                    name = L["Supported Addons"],
                    desc = L["SUPPORTEDADDONSDESC"],
                    func = function()
                        Skillet:ShowInventoryInfoPopup()
                    end,
                    order = 1,
                },
                show_bank_alt_counts = {
                    type = "toggle",
                    name = L["SHOWBANKALTCOUNTSNAME"],
                    desc = L["SHOWBANKALTCOUNTSDESC"],
                    get = function()
                        return Skillet.db.profile.show_bank_alt_counts
                    end,
                    set = function(value)
                        Skillet.db.profile.show_bank_alt_counts = value
                        Skillet:UpdateTradeSkillWindow()
                    end,
                    order = 2,
                },
            },
        },
]]
		about = {
			type = 'execute',
			name = L["About"],
			desc = L["ABOUTDESC"],
			func = function()
				Skillet:PrintAddonInfo()
			end,
			order = 50
		},
		config = {
			type = 'execute',
			name = L["Config"],
			desc = L["CONFIGDESC"],
			func = function()
				if not (UnitAffectingCombat("player")) then
					AceLibrary("Waterfall-1.0"):Open("Skillet")
				else
					DebugSpam("|cff8888ffSkillet|r: Combat lockdown restriction." ..
												  " Leave combat and try again.")
				end
			end,
            guiHidden = true,
			order = 51
		},
        shoppinglist = {
            type = 'execute',
            name = L["Shopping List"],
            desc = L["SHOPPINGLISTDESC"],
            func = function()
                if not (UnitAffectingCombat("player")) then
                    Skillet:DisplayShoppingList(false)
                else
                    DebugSpam("|cff8888ffSkillet|r: Combat lockdown restriction." ..
                                                  " Leave combat and try again.")
                end
            end,
            order = 52
        },
	}
}


-- replaces the standard bliz frameshow calls with this for supported tradeskills
function DoNothing()
DebugSpam("Do Nothing")
end


function Skillet:GetIDFromLink(link)				-- works with items or enchants
	if (link) then
		local found, _, string = string.find(link, "^|c%x+|H(.+)|h%[.+%]")

		if found then
			local _, id = strsplit(":", string)

			return tonumber(id);
		else
			return nil
		end
	end
end


function Skillet:DisableBlizzardFrame()
	if self.BlizzardTradeSkillFrame == nil then
		if (not IsAddOnLoaded("Blizzard_TradeSkillUI")) then
			LoadAddOn("Blizzard_TradeSkillUI");
		end

		self.BlizzardTradeSkillFrame = TradeSkillFrame
		self.BlizzardTradeSkillFrame_Show = TradeSkillFrame_Show

		TradeSkillFrame_Show = DoNothing
	end
end


-- Called when the addon is loaded
function Skillet:OnInitialize()
--	self:InitializeDatabase((UnitName("player")), true)  --- force clean rescan for now

	-- hook default tooltips
	local tooltipsToHook = { ItemRefTooltip, GameTooltip, ShoppingTooltip1, ShoppingTooltip2 };
	for _, tooltip in pairs(tooltipsToHook) do
		if tooltip and tooltip:HasScript("OnTooltipSetItem") then
			if tooltip:GetScript("OnTooltipSetItem") then
				local oldOnTooltipSetItem = tooltip:GetScript("OnTooltipSetItem")
				tooltip:SetScript("OnTooltipSetItem", function(tooltip)
					oldOnTooltipSetItem(tooltip)
					Skillet:AddItemNotesToTooltip(tooltip)
				end)
			else
				tooltip:SetScript("OnTooltipSetItem", function(tooltip)
					Skillet:AddItemNotesToTooltip(tooltip)
				end)
			end
		end
	end

    -- no need to be spammy about the fact that we are here, they'll find out seen enough
	-- self:Print("Skillet v" .. self.version .. " loaded");

	self:DisableBlizzardFrame()

    self:RegisterChatCommand({"/skillet"}, self.options, "SKILLET")
end

function EchoEvent(...)
	DEFAULT_CHAT_FRAME:AddMessage("echo event: "..(event or "no event"))
end


function Skillet:FlushAllData()
	Skillet.data = {}
	Skillet.data.recipeDB = {}

	Skillet.db.server.skillRanks = {}
	Skillet.db.server.skillDB = {}
	Skillet.db.server.linkDB = {}
	Skillet.db.server.groupDB = {}
	Skillet.db.server.queueData = {}
	Skillet.db.server.reagentsInQueue = {}
	Skillet.db.server.inventoryData = {}

	Skillet:InitializeDatabase((UnitName("player")))
end


function Skillet:InitializeDatabase(player, clean)
DebugSpam("initialize database for "..player)

	if not self.db.server.groupDB then
		self.db.server.groupDB = {}
	end

	if not self.db.server.inventoryData then
		self.db.server.inventoryData = {}
	end

	if not self.db.server.inventoryData[player] then
		self.db.server.inventoryData[player] = {}
	end

	if not self.db.server.reagentsInQueue then
		self.db.server.reagentsInQueue = {}
	end

	if not self.db.server.skillDB then
		self.db.server.skillDB = {}
	end

	if not self.db.server.skillRanks then
		self.db.server.skillRanks = {}
	end

	if not self.data then
		self.data = {}
	end

	if not self.data.recipeList then
		self.data.recipeList = {}
	end

	if not self.data.skillList then
		self.data.skillList = {}
	end

	if not self.db.server.linkDB then
		self.db.server.linkDB = {}
	end


	if not self.data.groupList then
		self.data.groupList = {}
	end

	if not self.data.groupList[player] then
		self.data.groupList[player] = {}
	end

	if not self.data.recipeDB then
		self.data.recipeDB = {}
	end

	if not self.db.server.queueData then
		self.db.server.queueData = {}
	end

	if not self.db.server.queueData[player] then
 		self.db.server.queueData[player] = {}
 	end

    if not self.data.skillIndexLookup then
        self.data.skillIndexLookup = {}
    end

    if not self.data.skillIndexLookup[player] then
        self.data.skillIndexLookup[player] = {}
    end

 	if self.dataGatheringModules[player] then
 		local mod = self.dataGatheringModules[player]

 		mod.ScanPlayerTradeSkills(mod, player, clean)
 	else
 DebugSpam("data gather module is nil")
 	end

	self:CollectRecipeInformation()

--	self:RecipeGroupDeconstructDBStrings()
end


function Skillet:RegisterRecipeFilter(name, namespace, initMethod, filterMethod)
	if not self.recipeFilters then
		self.recipeFilters = {}
	end
DEFAULT_CHAT_FRAME:AddMessage("add recipe filter "..name)
	self.recipeFilters[name] = { namespace = namespace, initMethod = initMethod, filterMethod = filterMethod }
end



function Skillet:RegisterRecipeDatabase(name, modules)
	if not self.recipeDataModules then
		self.recipeDataModules = {}
	end

	self.recipeDataModules[name] = modules
end


function Skillet:RegisterPlayerDataGathering(player, modules, recipeDB)
DebugSpam("RegisterPlayerDataGathering "..(player or "nil"))
	if not self.dataGatheringModules then
		self.dataGatheringModules = {}
	end

	if not self.recipeDB then
		self.recipeDB = {}
	end
DebugSpam("A")
	self.dataGatheringModules[player] = modules
	self.recipeDB[player] = recipeDB
DebugSpam("done with register")
end


-- Called when the addon is enabled
function Skillet:OnEnable()
    -- Hook into the events that we care about

    -- Trade skill window changes
	self:RegisterEvent("TRADE_SKILL_CLOSE",				"SkilletClose")
	self:RegisterEvent("TRADE_SKILL_SHOW",				"SkilletShow")
--	self:RegisterEvent("TRADE_SKILL_UPDATE")

    -- TODO: Tracks when the number of items on hand changes
	self:RegisterEvent("BAG_UPDATE")
--    self:RegisterEvent("TRADE_CLOSED")
--	self:RegisterEvent("CHAT_MSG_LOOT")

    -- MERCHANT_SHOW, MERCHANT_HIDE, MERCHANT_UPDATE events needed for auto buying.
    self:RegisterEvent("MERCHANT_SHOW")
	self:RegisterEvent("MERCHANT_UPDATE")
	self:RegisterEvent("MERCHANT_CLOSED")

    -- May need to show a shopping list when at the bank/auction house
    self:RegisterEvent("BANKFRAME_OPENED")
    self:RegisterEvent("BANKFRAME_CLOSED")
    self:RegisterEvent("GUILDBANKFRAME_OPENED", "BANKFRAME_OPENED")
    self:RegisterEvent("GUILDBANKFRAME_CLOSED", "BANKFRAME_CLOSED")
    self:RegisterEvent("AUCTION_HOUSE_SHOW")
    self:RegisterEvent("AUCTION_HOUSE_CLOSED")

    -- Messages from the Stitch libary
    -- These need to update the tradeskill window, not just the queue
    -- as we need to redisplay the number of items that can be crafted
    -- as we consume reagents.
	self:RegisterEvent("Skillet_Queue_Continue", "QueueChanged")
	self:RegisterEvent("Skillet_Queue_Complete", "QueueChanged")
	self:RegisterEvent("Skillet_Queue_Add",      "QueueChanged")

--    self:RegisterEvent("SkilletStitch_Scan_Complete",  "ScanCompleted")


    self.hideUncraftableRecipes = false
    self.hideTrivialRecipes = false
    self.currentTrade = nil
    self.selectedSkill = nil
	self.currentPlayer = (UnitName("player"))
    self.currentGroupLabel = "Blizzard"
	self.currentGroup = nil

    -- run the upgrade code to convert any old settings
    self:UpgradeDataAndOptions()


    -- hook up our copy of stitch to the data for this character
--    if self.db.server.recipes[self.currentPlayer] then
--        self.data = self.db.server.recipes[self.currentPlayer]
--    end
--    self.db.server.recipes[self.currentPlayer] = self.db.account.recipeData

 	self:EnableQueue("Skillet")
	self:EnableDataGathering("Skillet")

--	self:InitializeDatabase((UnitName("player")))

	AceLibrary("Waterfall-1.0"):Register("Skillet",
                   "aceOptions", Skillet.options,
                   "title",      L["Skillet Trade Skills"],
                   "colorR",     0,
                   "colorG",     0.7,
                   "colorB",     0
                   )

	self:DisableBlizzardFrame()

--	AceLibrary("Waterfall-1.0"):Open("Skillet")
end

-- Called when the addon is disabled
function Skillet:OnDisable()
    self:DisableDataGathering("Skillet")
    self:DisableQueue("Skillet");

    self:UnregisterAllEvents()

    AceLibrary("Waterfall-1.0"):Close("Skillet")
	AceLibrary("Waterfall-1.0"):UnRegister("Skillet")
end


local scan_in_progress = false
local need_rescan_on_open = false
local forced_rescan = false

function Skillet:ScanCompleted()
--    if scan_in_progress then
--        if forced_rescan and not need_rescan_on_open then
            -- only print this if we are not not doing a bag rescan,
            -- i.e. a first time or forced rescan.
--            local name = self:GetTradeSkillLine()
--            self:Print(L["Scan completed"] .. ": " .. name);
--        end

 --       self:UpdateScanningText("")
--        scan_in_progress = false
--        need_rescan_on_open = false
--        forced_rescan = false
        self:UpdateTradeSkillWindow()
 --   end
end



-- show the tradeskill window
-- only gets called from TRADE_SKILL_SHOW and CRAFT_SHOW events
-- this means, the skill being shown is for the main toon (not an alt)
function Skillet:SkilletShow()
DebugSpam("SHOW WINDOW (was showing "..(self.currentTrade or "nil")..")");

	if (IsTradeSkillLinked()) then
		_, self.currentPlayer = IsTradeSkillLinked()
		if (self.currentPlayer == UnitName("player")) then
			self.currentPlayer = "All Data"
		end

		self:RegisterPlayerDataGathering(self.currentPlayer,SkilletLink,"sk")
	else
		self:InitializeAllDataLinks("All Data")

		self.currentPlayer = (UnitName("player"))
	end

--DEFAULT_CHAT_FRAME:AddMessage("SkilletShow")

--[[
	if self.currentTrade then
		if self.craftOpen and event == "TRADE_SKILL_SHOW" then		-- crafting is open, but we've been asked to show tradeskills
			self.craftOpen = false
			CloseCraft()
		end

		if self.tradeSkillOpen and event == "CRAFT_SHOW" then		-- tradeskill is open, but we've been asked to show crafting
			self.tradeSkillOpen = false
			CloseTradeSkill()
		end
	end
]]


	self.currentTrade = self.tradeSkillIDsByName[(GetTradeSkillLine())] or 2656      -- smelting caveat


	self:InitializeDatabase(self.currentPlayer)

	if self:IsSupportedTradeskill(self.currentTrade) then
		self:InventoryScan()


		self.tradeSkillOpen = true
DebugSpam("SkilletShow: "..self.currentTrade)

		self.selectedSkill = nil

		self.dataScanned = false


		if IsControlKeyDown() then
			self.db.server.skillDB[self.currentPlayer][self.currentTrade] = {}
		end

		self:RescanTrade()

		self.currentGroup = nil
		self.currentGroupLabel = self:GetTradeSkillOption("grouping")
		self:RecipeGroupDropdown_OnShow()

		self:ShowTradeSkillWindow()

		local filterbox = getglobal("SkilletFilterBox")
		local oldtext = filterbox:GetText()
		local filterText = self:GetTradeSkillOption("filtertext")

		-- if the text is changed, set the new text (which fires off an update) otherwise just do the update
		if filterText ~= oldtext then
			filterbox:SetText(filterText)
		else
			self:UpdateTradeSkillWindow()
		end

-- this comes from the blizzard ui tradeskill_show() routine.  for some reason, one (or all) of these needs to be called to prevent skill-ups from killing the DoTrade repeat
		TradeSkillCreateButton:Disable();
		TradeSkillCreateAllButton:Disable();
		if ( GetTradeSkillSelectionIndex() == 0 ) then
			TradeSkillFrame_SetSelection(GetFirstTradeSkill());
		else
			TradeSkillFrame_SetSelection(GetTradeSkillSelectionIndex());
		end
		FauxScrollFrame_SetOffset(TradeSkillListScrollFrame, 0);
		TradeSkillListScrollFrameScrollBar:SetMinMaxValues(0, 0);
		TradeSkillListScrollFrameScrollBar:SetValue(0);
		SetPortraitTexture(TradeSkillFramePortrait, "player");
		TradeSkillOnlyShowMakeable(TradeSkillFrameAvailableFilterCheckButton:GetChecked());
		TradeSkillFrame_Update();

		-- Moved to the bottom to prevent addons which hook it from blocking tradeskills
		CloseDropDownMenus();
-- end of weird blizzard code stuff



		self.dataSource = "api"
	else
		self:HideAllWindows()
		self:BlizzardTradeSkillFrame_Show()
	end
end


function Skillet:FreeCaches()
--	collectgarbage("collect")
	if not cache then
		cache = Skillet.data
	end

--	local kbA = collectgarbage("count")
	Skillet.data = {}
--	collectgarbage("collect")
--	local kbB = collectgarbage("count")
-- DEFAULT_CHAT_FRAME:AddMessage("free'd " .. data .. " (" .. math.floor((kbA - kbB)*100+.5)/100 .. " Kb)")
end


function Skillet:SkilletClose()
DebugSpam("SKILLET CLOSE")
	if self.dataSource == "api" then			-- if the skillet system is using the api for data access, then close the skillet window
		self:HideAllWindows()
		self:FreeCaches()
	end
end


-- Rescans the trades (and thus bags). Can only be called if the tradeskill
-- window is open and a trade selected.
local function Skillet_rescan_bags()
	local start = GetTime()


	Skillet:InventoryScan()
	Skillet:UpdateTradeSkillWindow()
    Skillet:UpdateShoppingListWindow()


	local elapsed = GetTime() - start

	if elapsed > 0.5 then
		DEFAULT_CHAT_FRAME:AddMessage("WARNING: skillet inventory scan took " .. math.floor(elapsed*100+.5)/100 .. " seconds to complete.")
	end

end



-- So we can track when the players inventory changes and update craftable counts
function Skillet:BAG_UPDATE()


	local showing = false
    if self.tradeSkillFrame and self.tradeSkillFrame:IsVisible() then
        showing = true
    end
    if self.shoppingList and self.shoppingList:IsVisible() then
        showing = true
    end

	if showing then
		-- bag updates can happen fairly frequently and we don't want to
		-- be scanning all the time so ... buffer updates to a single event
		-- that fires after a 1/4 second.
		if not AceEvent:IsEventScheduled("Skillet_rescan_bags") then
			AceEvent:ScheduleEvent("Skillet_rescan_bags", Skillet_rescan_bags, 0.05)
		end
    else
       -- no trade window open, but something change, we will need to rescan
       -- when the window is next opened.
       need_rescan_on_open = true
	end

    if MerchantFrame and MerchantFrame:IsVisible() then
        -- may need to update the button on the merchant frame window ...
        self:UpdateMerchantFrame()
    end
end


function Skillet:CHAT_MSG_LOOT()
--	DebugSpam("CHAT_MSG_LOOT: "..arg1.." "..arg2)
end


-- Trade window close, the counts may need to be updated.
-- This could be because an enchant has used up mats or the player
-- may have received more mats.
function Skillet:TRADE_CLOSED()
    self:BAG_UPDATE()
end



function Skillet:SetTradeSkill(player, tradeID, skillIndex)
DebugSpam("setting tradeskill to "..player.." "..tradeID.." "..(skillIndex or "nil"))
    if not self.db.server.queueData[player] then
 		self.db.server.queueData[player] = {}
 	end

 	if player ~= self.currentPlayer or tradeID ~= self.currentTrade then
--		local kbA = collectgarbage("count")
--		self.data.recipeList = {}
--		self.data.skillList = {}
--		self.data.groupList = {}
--		collectgarbage("collect")
--		local kbB = collectgarbage("count")
--DEFAULT_CHAT_FRAME:AddMessage("free'd " .. math.floor((kbA - kbB)*100+.5)/100 .. " Kb")

		collectgarbage("collect")

	 	self.currentPlayer = player
		local oldTradeID = self.currentTrade

		if player == (UnitName("player")) then								-- we can update the tradeskills if this toon is the current one
			self.dataSource = "api"
			self.dataScanned = false
			self.currentGroup = nil

			self.currentGroupLabel = self:GetTradeSkillOption("grouping")
			self:RecipeGroupDropdown_OnShow()

DebugSpam("cast: "..self:GetTradeName(tradeID))

			CastSpellByName(self:GetTradeName(tradeID))				-- this will trigger the whole rescan process via a TRADE_SKILL_SHOW/CRAFT_SHOW event
        else
            self.dataSource = "cache"
			CloseTradeSkill()

			self.dataScanned = false

			self:HideNotesWindow();

			self.currentTrade = tradeID
			self.currentGroup = nil
			self.currentGroupLabel = self:GetTradeSkillOption("grouping")

--			self:RecipeGroupDeconstructDBStrings()

			self:RecipeGroupGenerateAutoGroups()

			self:RecipeGroupDropdown_OnShow()

			if not self.data.skillList[player] then
				self.data.skillList[player] = {}
			end

			if not self.data.skillList[player][tradeID] then
				self.data.skillList[player][tradeID] = {}
			end

			-- remove any filters currently in place
			local filterbox = getglobal("SkilletFilterBox")
	        local oldtext = filterbox:GetText()
	        local filterText = self:GetTradeSkillOption("filtertext")

	    	-- if the text is changed, set the new text (which fires off an update) otherwise just do the update
	    	if filterText ~= oldtext then
	    		filterbox:SetText(filterText)
	    	else
	    		self:UpdateTradeSkillWindow()
	    	end
	 	end

DebugSpam("Tradeskill is set to "..(self.currentPlayer or "nil").." "..(self.currentTrade or "nil"))
    end
 	self:SetSelectedSkill(skillIndex, false)
end


-- Updates the tradeskill window, if the current trade has changed.
function Skillet:UpdateTradeSkill()
DebugSpam("UPDATE TRADE SKILL")

	local trade_changed = false
	local new_trade = self:GetTradeSkillLine()

	if not self.currentTrade and new_trade then
		trade_changed = true
	elseif self.currentTrade ~= new_trade then
		trade_changed = true
	end

	if true or trade_changed then
		self:HideNotesWindow();

		self.sortedRecipeList = {}

	   	-- And start the update sequence through the rest of the mod
		self:SetSelectedTrade(new_trade)

--		self:RescanTrade()

		-- remove any filters currently in place
		local filterbox = getglobal("SkilletFilterBox");
        local filtertext = self:GetTradeSkillOption("filtertext", self.currentPlayer, new_trade)
    	-- this fires off a redraw event, so only change after data has been acquired
    	filterbox:SetText(filtertext);
    end
DebugSpam("UPDATE TRADE SKILL complete")
end

-- Shows the trade skill frame.
function Skillet:internal_ShowTradeSkillWindow()
DebugSpam("internal_ShowTradeSkillWindow")
	local frame = self.tradeSkillFrame
    if not frame then
        frame = self:CreateTradeSkillWindow()
        self.tradeSkillFrame = frame
    end

    self:ResetTradeSkillWindow()

    if not frame:IsVisible() then
		frame:Show()
		self:UpdateTradeSkillWindow()
    else
    	self:UpdateTradeSkillWindow()
    end
DebugSpam("internal_ShowTradeSkillWindow complete")
end

--
-- Hides the Skillet trade skill window. Does nothing if the window is not visible
--
function Skillet:internal_HideTradeSkillWindow()

    local closed -- was anything closed by us?
    local frame = self.tradeSkillFrame

    if frame and frame:IsVisible() then
        self:StopCast()
        frame:Hide()
        closed = true
    end

    return closed
end

--
-- Hides any and all Skillet windows that are open
--
function Skillet:internal_HideAllWindows()
    local closed -- was anything closed?

    -- Cancel anything currently being created
    if self:HideTradeSkillWindow() then
        closed = true
    end

    if self:HideNotesWindow() then
        closed = true
    end

    if self:HideShoppingList() then
        closed = true
    end

    self.currentTrade = nil
    self.selectedSkill = nil

    return closed
end

-- Show the options window
function Skillet:ShowOptions()
	AceLibrary("Waterfall-1.0"):Open("Skillet");
end

-- Notes when a new trade has been selected
function Skillet:SetSelectedTrade(newTrade)
	self.currentTrade = newTrade;
	self:SetSelectedSkill(nil, false)
--	self.headerCollapsedState = {};

--	self:UpdateTradeSkillWindow()

	-- Stop the stitch queue and nuke anything in it.
	-- would be nice to allow queuing items from different
	-- trades, but the Blizzard design does not allow that
--	self:CancelCast();
--	self:StopCast();
--	self:ClearQueue();
end

-- Sets the specific trade skill that the user wants to see details on.
function Skillet:SetSelectedSkill(skillIndex, wasClicked)
	if not skillIndex then
		-- no skill selected
		self:HideNotesWindow()
	elseif self.selectedSkill and self.selectedSkill ~= skillIndex then
		-- new skill selected
		self:HideNotesWindow() -- XXX: should this be an update?
	end

--	if skillIndex then
--		local recipe = self:GetRecipeDataByProfessionIndex(self.currentTrade, skillIndex)
--
--		self:ConfigureRecipeControls(recipe.numMade==0)			-- numMade==0 indicates an enchantment
--	else
--		self:ConfigureRecipeControls(false)
--	end

	self:ConfigureRecipeControls(false)				-- allow ALL trades to queue up items (enchants as well)

	self.selectedSkill = skillIndex
	self:ScrollToSkillIndex(skillIndex)
	self:UpdateDetailsWindow(skillIndex)
end


-- Updates the text we filter the list of recipes against.
function Skillet:UpdateFilter(text)
DebugSpam("UpdateFilter")
    self:SetTradeSkillOption("filtertext", text)
	self:SortAndFilterRecipes()
	self:UpdateTradeSkillWindow()
DebugSpam("UpdateFilter complete")
end

-- Called when the queue has changed in some way
function Skillet:QueueChanged()

DebugSpam("QUEUE CHANGED")
    -- Hey! What's all this then? Well, we may get the request to update the
    -- windows while the queue is being processed and the reagent and item
    -- counts may not have been updated yet. So, the "0.5" puts in a 1/2
    -- second delay before the real update window method is called. That
    -- give the rest of the UI (and the API methods called by Stitch) time
    -- to record any used reagents.
--    if Skillet.tradeSkillFrame and Skillet.tradeSkillFrame:IsVisible() then
--        if not AceEvent:IsEventScheduled("Skillet_UpdateWindows") then
--            AceEvent:ScheduleEvent("Skillet_UpdateWindows", Skillet.UpdateTradeSkillWindow, 0.5, self)
--        end
--    end

--    if SkilletShoppingList and SkilletShoppingList:IsVisible() then
--        if not AceEvent:IsEventScheduled("Skillet_UpdateShoppingList") then
--            AceEvent:ScheduleEvent("Skillet_UpdateShoppingList", Skillet.UpdateShoppingListWindow, 0.25, self)
--        end
--    end

--    if MerchantFrame and MerchantFrame:IsVisible() then
--        if not AceEvent:IsEventScheduled("Skillet_UpdateMerchantFrame") then
--            AceEvent:ScheduleEvent("Skillet_UpdateMerchantFrame", Skillet.UpdateMerchantFrame, 0.25, self)
 --       end
 --   end
end

-- Gets the note associated with the item, if there is such a note.
-- If there is no user supplied note, then return nil
-- The item can be either a recipe or reagent name
function Skillet:GetItemNote(key)
	local result

    if not self.db.server.notes[self.currentPlayer] then
        return
    end

--    local id = self:GetItemIDFromLink(link)
	local kind, id = string.split(":", key)

	if id and self.db.server.notes[self.currentPlayer] then
		result = self.db.server.notes[self.currentPlayer][id]
	else
		self:Print("Error: Skillet:GetItemNote() could not determine item ID for " .. key);
	end

	if result and result == "" then
		result = nil
		self.db.server.notes[self.currentPlayer][id] = nil
	end

	return result
end

-- Sets the note for the specified object, if there is already a note
-- then it is overwritten
function Skillet:SetItemNote(key, note)
--	local id = self:GetItemIDFromLink(link);
	local kind, id = string.split(":", key)

    if not self.db.server.notes[self.currentPlayer] then
        self.db.server.notes[self.currentPlayer] = {}
    end

	if id then
		self.db.server.notes[self.currentPlayer][id] = note
	else
		self:Print("Error: Skillet:SetItemNote() could not determine item ID for " .. key);
	end

end

-- Adds the skillet notes text to the tooltip for a specified
-- item.
-- Returns true if tooltip modified.
function Skillet:AddItemNotesToTooltip(tooltip)
	local enabled = self.db.profile.show_item_notes_tooltip or false
	if enabled == false or IsControlKeyDown() then
		return
	end

	-- get item name
	local name,link = tooltip:GetItem();
	if not link then return; end

    local id = self:GetItemIDFromLink(link);
    if not id then return end;

    local header_added = false
    for player,notes_table in pairs(self.db.server.notes) do
        local note = notes_table[id]
        if note then
            if not header_added then
                tooltip:AddLine("Skillet " .. L["Notes"] .. ":")
                header_added = true
            end
            if player ~= self.currentPlayer then
                note = GRAY_FONT_COLOR_CODE .. player .. ": " .. FONT_COLOR_CODE_CLOSE .. note
            end
            tooltip:AddLine(" " .. note, 1, 1, 1, 1) -- r,g,b, wrap
        end
    end

    return header_added
end


function Skillet:ToggleTradeSkillOption(option)
	local v = self:GetTradeSkillOption(option)

	self:SetTradeSkillOption(option, not v)
end


-- Returns the state of a craft specific option
function Skillet:GetTradeSkillOption(option, playerOverride, tradeOverride)
    local player = playerOverride or self.currentPlayer
	local trade = tradeOverride or self.currentTrade

	local options = self.db.account.options

    if not options or not options[player] or not options[player][trade] then
       return Skillet.defaultOptions[option]
    end

	if options[player][trade][option] == nil then
		return Skillet.defaultOptions[option]
	end

    return options[player][trade][option]
end


-- sets the state of a craft specific option
function Skillet:SetTradeSkillOption(option, value, playerOverride, tradeOverride)
	local player = playerOverride or self.currentPlayer
	local trade = tradeOverride or self.currentTrade

	if not self.db.account.options then
		self.db.account.options = {}
	end

	if not self.db.account.options[player] then
		self.db.account.options[player] = {}
	end

    if not self.db.account.options[player][trade] then
        self.db.account.options[player][trade] = {}
    end

    self.db.account.options[player][trade][option] = value
end


function ProfessionPopup_SelectPlayerTrade(menuFrame,player,tradeID)
	ToggleDropDownMenu(1, nil, ProfessionPopupFrame, this, this:GetWidth(), 0)
	Skillet:SetTradeSkill(player,tradeID)
end

--|c%x+|Htrade:%d+:%d+:%d+:[0-9a-fA-F]+:[<-{]+|h%[[%a%s]+%]|h|r]]
--	[3273] = "|cffffd000|Htrade:3274:148:150:23F381A:zD<<t=|h[First Aid]|h|r",

function ProfessionPopup_SelectTradeLink(menuFrame,player,link)
--	link = "|cffffd000|Htrade:3274:400:450:23F381A:{{{{{{|h[First Aid]|h|r"
	ToggleDropDownMenu(1, nil, ProfessionPopupFrame, this, this:GetWidth(), 0)
	local _,_,tradeString = string.find(link, "(trade:%d+:%d+:%d+:[0-9a-fA-F]+:[A-Za-z0-9+/]+)")

	SetItemRef(tradeString,link,"LeftButton")
end


function ProfessionPopup_Init(menuFrame, level)
	if (level == 1) then  -- character names
		local title = {}
		local playerMenu = {}

		title.text = "Select Player and Tradeskill"
		title.isTitle = true

		UIDropDownMenu_AddButton(title)

		local i=1
		for player, gatherModule in pairs(Skillet.dataGatheringModules) do
			skillData = gatherModule.ScanPlayerTradeSkills(gatherModule, player)

			if skillData then
				playerMenu.text = player
				playerMenu.hasArrow = true
				playerMenu.value = player
				playerMenu.disabled = false


				UIDropDownMenu_AddButton(playerMenu)
				i = i + 1
			end
		end

		if (i == 1) then
			playerMenu.text = "[no players scanned]";
			playerMenu.disabled = true;

			playerMenu.arg1 = "";
			playerMenu.arg2 = "";
			playerMenu.func = nil;

			UIDropDownMenu_AddButton(playerMenu, level);
		end
	end

	if (level == 2) then  -- skills per player
		local gatherModule = Skillet.dataGatheringModules[UIDROPDOWNMENU_MENU_VALUE]

		local skillRanks = gatherModule.ScanPlayerTradeSkills(gatherModule, UIDROPDOWNMENU_MENU_VALUE)
		local skillButton = {}



		for i=1,#Skillet.tradeSkillList do
			local tradeID = Skillet.tradeSkillList[i]
			local list = Skillet:GetSkillRanks(UIDROPDOWNMENU_MENU_VALUE, tradeID)

			if not nonLinkingTrade[tradeID] or UIDROPDOWNMENU_MENU_VALUE == UnitName("player") then
				if list then

					local rank, maxRank = string.split(" ", list)

					skillButton.text = Skillet:GetTradeName(tradeID).." |cff00ff00["..(rank or "?").."/"..(maxRank or "?").."]|r"
					skillButton.value = tradeID

					skillButton.icon = list.texture


					if gatherModule == SkilletLink then
						skillButton.arg1 = UIDROPDOWNMENU_MENU_VALUE
						skillButton.arg2 = Skillet.db.server.linkDB[UIDROPDOWNMENU_MENU_VALUE][tradeID]
						skillButton.func = ProfessionPopup_SelectTradeLink
					else
						skillButton.arg1 = UIDROPDOWNMENU_MENU_VALUE
						skillButton.arg2 = tradeID
						skillButton.func = ProfessionPopup_SelectPlayerTrade
					end

					if tradeID == Skillet.currentTrade and UIDROPDOWNMENU_MENU_VALUE == Skillet.currentPlayer then
						skillButton.checked = true
					else
						skillButton.checked = false
					end

					if UIDROPDOWNMENU_MENU_VALUE ~= (UnitName("player")) and not list then
						skillButton.disabled = true
					else
						skillButton.disabled = false
					end

					UIDropDownMenu_AddButton(skillButton, level)
				end
			end
		end
	end
end


function ProfessionPopup_Show()
--	if not ProfessionPopupFrame then
	ProfessionPopupFrame = CreateFrame("Frame", "ProfessionPopupFrame", getglobal("UIParent"), "UIDropDownMenuTemplate")
--	end

	UIDropDownMenu_Initialize(ProfessionPopupFrame, ProfessionPopup_Init, "MENU")
	ToggleDropDownMenu(1, nil, ProfessionPopupFrame, this, this:GetWidth(), 0)
end

