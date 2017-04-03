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

local L = AceLibrary("AceLocale-2.2"):new("Skillet")

L:RegisterTranslations("enUS", function() return {
	["Skillet Trade Skills"] 		= true, -- default message
    ["Create"] 				 		= true,
    ["Queue All"]					= true,
    ["Create All"]					= true,
    ["Create"]						= true,
    ["Queue"]						= true,
    ["Enchant"]						= true,
    ["Rescan"]                      = true,
    ["Number of items to queue/create"]	= true,
    ["buyable"]						= true,
    ["reagents in inventory"]		= true,
    ["bank"]						= true, -- "reagents in bank"
    ["alts"]						= true, -- "reagents on alts"
    ["can be created from reagents in your inventory"] = true,
    ["can be created from reagents in your inventory and bank"] = true,
    ["can be created from reagents on all characters"] = true,
    ["Scanning tradeskill"]			= true,
    ["Scan completed"]              = true,
    ["Filter"]						= true,
    ["Hide uncraftable"]			= true,
    ["Hide trivial"]				= true,
    ["Options"]						= true,
    ["Notes"]						= true,
    ["Purchased"]					= true,
    ["Total spent"]					= true,
    ["This merchant sells reagents you need!"] = true,
	["Buy Reagents"]				= true,
	["click here to add a note"]	= true,
    ["not yet cached"]              = true,

    -- Options
    ["About"]						= true,
    ["ABOUTDESC"]					= "Prints info about Skillet",
    ["Config"]						= true,
    ["CONFIGDESC"]					= "Opens a config window for Skillet",
    ["Shopping List"]					= true,
    ["SHOPPINGLISTDESC"]				= "Display the shopping list",

    ["Features"]					= true,
    ["FEATURESDESC"]					= "Optional behavior that can be enabled and disabled",
    ["VENDORBUYBUTTONNAME"]				= "Show reagent purchase button at vendors",
    ["VENDORBUYBUTTONDESC"]				= "Display a button when talking to vendors that will allow you to be the needed reagents for all queued recipes.",
    ["VENDORAUTOBUYNAME"]				= "Automatically buy reagents",
    ["VENDORAUTOBUYDESC"]				= "If you have queued recipes and talk to a vendor that sells something needed for those reicpes, it will be automatically purchased.",
    ["SHOWITEMNOTESTOOLTIPNAME"]			= "Add user specified notes to tooltip",
    ["SHOWITEMNOTESTOOLTIPDESC"]			= "Adds notes you provide for an item to the tool tip for that item",
    ["SHOWDETAILEDRECIPETOOLTIPNAME"]			= "Display a detailed tooltip for recipes",
    ["SHOWDETAILEDRECIPETOOLTIPDESC"]			= "Displays a detailed tooltip when hovering over recipes in the left hand panel",
    ["LINKCRAFTABLEREAGENTSNAME"]			= "Make reagents clickable",
    ["LINKCRAFTABLEREAGENTSDESC"]			= "If you can create a reagent needed for the current recipe, clicking the reagent will take you to its recipe.",
    ["QUEUECRAFTABLEREAGENTSNAME"]			= "Queue craftable reagents",
    ["QUEUECRAFTABLEREAGENTSDESC"]			= "If you can create a reagent needed for the current recipe, and don't have enough, then that reagent will be added to the queue",
    ["DISPLAYSHOPPINGLISTATBANKNAME"]			= "Display shopping list at banks",
    ["DISPLAYSHOPPINGLISTATBANKDESC"]			= "Display a shopping list of the items that are needed to craft queued recipes but are not in your bags",
    ["DISPLAYSGOPPINGLISTATAUCTIONNAME"]		= "Display shopping list at auctions",
    ["DISPLAYSGOPPINGLISTATAUCTIONDESC"]		= "Display a shopping list of the items that are needed to craft queued recipes but are not in your bags",

    ["Appearance"]					= true,
    ["APPEARANCEDESC"]					= "Options that control how Skillet is displayed",
    ["DISPLAYREQUIREDLEVELNAME"]			= "Display required level",
    ["DISPLAYREQUIREDLEVELDESC"]			= "If the item to be crafted requires a minimum level to use, that level will be displayed along with the recipe",
    ["Transparency"]					= true,
    ["TRANSPARAENCYDESC"]				= "Transparency of the main trade skill window",

    -- New in version 1.6
    ["Shopping List"]               = true,
    ["Retrieve"]                    = true,
    ["Include alts"]                = true,

    -- New in vesrsion 1.9
    ["Start"]                       = true,
    ["Pause"]                       = true,
    ["Clear"]                       = true,
    ["None"]                        = true,
    ["By Name"]                     = true,
    ["By Difficulty"]               = true,
    ["By Level"]                    = true,
    ["Scale"]                       = true,
    ["SCALEDESC"]                   = "Scale of the tradeskill window (default 1.0)",
    ["Could not find bag space for"] = true,
    ["SORTASC"]                     = "Sort the recipe list from highest (top) to lowest (bottom)",
    ["SORTDESC"]                    = "Sort the recipe list from lowest (top) to highest (bottom)",
    ["By Quality"]                  = true,

    -- New in version 1.10
    ["Inventory"]                   = true,
    ["INVENTORYDESC"]               = "Inventory Information",
    ["Supported Addons"]            = true,
    ["Selected Addon"]              = true,
    ["Library"]                     = true,
    ["SUPPORTEDADDONSDESC"]         = "Supported add ons that can or are being used to track inventory",
    ["SHOWBANKALTCOUNTSNAME"]       = "Include bank and alt character contents",
    ["SHOWBANKALTCOUNTSDESC"]       = "When calculating and displaying craftable item counts, include items from your bank and from your other characters",
    ["ENHANCHEDRECIPEDISPLAYNAME"]  = "Show recipe difficulty as text",
    ["ENHANCHEDRECIPEDISPLAYDESC"]  = "When enabled, recipe names will have one or more '+' characters appeneded to their name to inidcate the difficulty of the recipe.",
    ["SHOWCRAFTCOUNTSNAME"]         = "Show craftable counts",
    ["SHOWCRAFTCOUNTSDESC"]         = "Show the number of times you can craft a recipe, not the total number of items producable",
	
	 -- New in version 1.11
    ["Crafted By"]                  = "Crafted by",
	
	-- New in version 1.10-LS
	["craftable"]					= true,
	["No Data"]						= true,
	
	["DISPLAYSHOPPINGLISTATGUILDBANKNAME"]			= "Display shopping list at guild banks",
    ["DISPLAYSHOPPINGLISTATGUILDBANKDESC"]			= "Display a shopping list of the items that are needed to craft queued recipes but are not in your bags",

	["By Item Level"]                    = true,
	["By Skill Level"]                    = true,
	
	["Blizzard"]					= true,			-- as in, the company name
	["Process"]						= true,
} end)