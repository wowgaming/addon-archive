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

L:RegisterTranslations("frFR", function() return {
--    ["Skillet Trade Skills"] 	                	= true, -- default message
    ["Create"] 				 		= "Créer",
    ["Queue All"]					= "Queue tous", -- If someone got a good translation for this ...
    ["Create All"]					= "Créer tous",
    ["Create"]						= "Créer",
    ["Queue"]						= "Queue",
    ["Enchant"]						= "Enchanter",
    ["Rescan"]                                          = "Actualiser",
--    ["Number of items to queue/create"]                 = true,
    ["buyable"]						= "Achetable",
    ["reagents in inventory"]                           = "Réactifs dans l'inventaire",
    ["bank"]						= "banque", -- "reagents in bank"
    ["alts"]						= "alts (rerolls)", -- "reagents on alts"
    ["can be created from reagents in your inventory"]  = "Peut être créé à partir de réactifs dans votre inventaire",
    ["can be created from reagents in your inventory and bank"] = "Peut être créé à partir de réactifs dans votre inventaire et votre banque",
    ["can be created from reagents on all characters"]  = "Peut être créé à partir de réactifs sur tous vos personnages",
    ["Scanning tradeskill"]                             = "Balayage en cours",
    ["Scan completed"]                                  = "Balayage terminé",
    ["Filter"]						= "Filtrer",
    ["Hide uncraftable"]                                = "Cacher les infaisables",
    ["Hide trivial"]                                    = "Cacher les triviaux",
--    ["Options"]		        			= true,
--    ["Notes"] 	        			= true,
    ["Purchased"]					= "Achetés",
    ["Total spent"]					= "Total dépensé",
    ["This merchant sells reagents you need!"]          = "Ce marchand vend des réactifs dont vous avez besoin!",
    ["Buy Reagents"]			        	= "Acheter des réactifs",
    ["click here to add a note"]                       	= "Cliquez pour ajouter une note",
    ["not yet cached"]                                  = "Pas encore en cache",

    -- Options
    ["About"]						= "A propos",
    ["ABOUTDESC"]					= "Affiche des informations sur l'addon",
    ["Config"]						= "Configuration",
    ["CONFIGDESC"]					= "Ouvre la fenêtre de configuration de l'addon",
    ["Shopping List"]					= "Liste des courses",
    ["SHOPPINGLISTDESC"]				= "Affiche la liste des courses à faire",

    ["Features"]					= "Fonctionalités",
    ["FEATURESDESC"]					= "Réglage des options",
--    ["VENDORBUYBUTTONNAME"]				= "Show reagent purchase button at vendors",
--    ["VENDORBUYBUTTONDESC"]				= "Display a button when talking to vendors that will allow you to be the needed reagents for all queued recipes.",
    ["VENDORAUTOBUYNAME"]				= "Acheter les réactifs automatiquement",
    ["VENDORAUTOBUYDESC"]				= "Permet d'acheter automatiquement les réactifs nécessaires a vos crafts en attente si le marchand les propose.",
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

    ["Appearance"]					= "Apparence",
    ["APPEARANCEDESC"]					= "Réglage de l'apparence de la fenètre Skillet",
    ["DISPLAYREQUIREDLEVELNAME"]			= "Afficher le niveau requis",
    ["DISPLAYREQUIREDLEVELDESC"]			= "Si l'objet à créer a un niveau minimum requis, ce niveau sera affiché a gauche de la recette",
    ["Transparency"]					= "Transparence",
    ["TRANSPARAENCYDESC"]				= "Transparence de la fenêtre principale",

    -- New in version 1.6
--    ["Shopping List"]               = true, --appears twice
    ["Retrieve"]                    = "Récupérer",
    ["Include alts"]                = "Inclure les alts",

    -- New in vesrsion 1.9
    ["Start"]                       = "Commencer",
    ["Pause"]                       = "Pause",
    ["Clear"]                       = "Nettoyer",
    ["None"]                        = "Aucun",
    ["By Name"]                     = "Par nom",
    ["By Difficulty"]               = "Par difficulté",
    ["By Level"]                    = "Par niveau",
    ["Scale"]                       = "Echelle",
    ["SCALEDESC"]                   = "Echelle de la fenêtre (1.0 par défaut)",
    ["Could not find bag space for"] = "Il n'y a plusde place dans vos sacs pour",
    ["SORTASC"]                     = "Sort the recipe list from highest (top) to lowest (bottom)",
    ["SORTDESC"]                    = "Sort the recipe list from lowest (top) to highest (bottom)",
    ["By Quality"]                  = "Par qualité",

    -- New in version 1.10
    ["Inventory"]                   = "Inventaire",
    ["INVENTORYDESC"]               = "Informations sur l'inventaire",
    ["Supported Addons"]            = "Addons compatibles",
    ["Selected Addon"]              = "Addon selectionné",
    ["Library"]                     = "Librairie",
    ["SUPPORTEDADDONSDESC"]         = "Addons reconnus pouvant ou étant utilisés pour surveiller le contenu de l'inventaire",
    -- ["SHOWBANKALTCOUNTSNAME"]       = "Include bank and alt character contents",
    -- ["SHOWBANKALTCOUNTSDESC"]       = "When calculating and displaying craftable itemn counts, include items from your bank and from your other characters",
    -- ["ENHANCHEDRECIPEDISPLAYNAME"]  = "Show recipe difficulty as text",
    -- ["ENHANCHEDRECIPEDISPLAYDESC"]  = "When enabled, recipe names will have one or more '+' characters appeneded to their name to inidcate the difficulty of the recipe.",
    -- ["SHOWCRAFTCOUNTSNAME"]         = "Show craftable counts",
    -- ["SHOWCRAFTCOUNTSDESC"]         = "Show the number of times you can craft a recipe, not the total number of items producable",

    -- New in version 1.11
    ["Crafted By"]                  = "Crafted by",

} end)
