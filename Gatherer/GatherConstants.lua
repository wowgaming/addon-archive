--[[
	Various Constant Information definitions
	Revision: $Id: GatherConstants.lua 854 2009-04-16 06:13:47Z Esamynn $

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
		You have an implicit licence to use this AddOn with these facilities
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat

]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/release/Gatherer/GatherConstants.lua $", "$Rev: 854 $")

local metatable = { __index = getfenv(0) }
setmetatable( Gatherer.Constants, metatable )
setfenv(1, Gatherer.Constants)

Gatherer.Var.Skills.OPEN = true

-- OreRare Spawn/Herbs
RareMatches = {
	["ORE_TIN"]          = "ORE_SILVER",
	["ORE_IRON"]         = "ORE_GOLD",
	["ORE_MITHRIL"]      = "ORE_TRUESILVER",
	["HERB_MAGEROYAL"]   = "HERB_SWIFTTHISTLE",
	["HERB_BRIARTHORN"]  = "HERB_SWIFTTHISTLE",
	["HERB_PURPLELOTUS"] = "HERB_WILDVINE",
}

-- Skill levels required
SkillLevel = {
	-- Ores
	["ORE_COPPER"]      = 1,
	["ORE_TIN"]         = 65,
	["ORE_INCENDICITE"] = 65,
	["ORE_SILVER"]      = 75,
	["ORE_BLOODSTONE"]  = 75,
	["ORE_IRON"]        = 125,
	["ORE_INDURIUM"]    = 150,
	["ORE_GOLD"]        = 155,
	["ORE_MITHRIL"]     = 175,
	["ORE_DARKIRON"]    = 230,
	["ORE_TRUESILVER"]  = 230,
	["ORE_THORIUM"]     = 245,
	["ORE_RTHORIUM"]    = 275,
	["ORE_OBSIDIAN"]    = 305,
	-- TBC ORES
	["ORE_FELIRON"]     = 300,
	["ORE_ADAMANTITE"]  = 325,
	["ORE_ETERNIUM"]    = 350,
	["ORE_KHORIUM"]     = 375,
	["ORE_RADAMANTITE"] = 350,
	["ORE_NETHERCITE"]  = 350,
  -- WotLK ores
	["ORE_COBALT"]      = 350,
	["ORE_RCOBALT"]     = 375,
	["ORE_SARONITE"]    = 400,
	["ORE_RSARONITE"]   = 425,
	["ORE_TITANIUM"]    = 450,
  
	-- Herbs
	["HERB_PEACEBLOOM"]        = 1,
	["HERB_SILVERLEAF"]        = 1,
	["HERB_EARTHROOT"]         = 15,
	["HERB_MAGEROYAL"]         = 50,
	["HERB_BRIARTHORN"]        = 75,
	["HERB_SWIFTTHISTLE"]      = 50,
	["HERB_STRANGLEKELP"]      = 85,
	["HERB_BRUISEWEED"]        = 100,
	["HERB_WILDSTEELBLOOM"]    = 115,
	["HERB_GRAVEMOSS"]         = 120,
	["HERB_KINGSBLOOD"]        = 125,
	["HERB_LIFEROOT"]          = 150,
	["HERB_FADELEAF"]          = 160,
	["HERB_GOLDTHORN"]         = 175,
	["HERB_KHADGARSWHISKER"]   = 185,
	["HERB_WINTERSBITE"]       = 195,
	["HERB_FIREBLOOM"]         = 205,
	["HERB_PURPLELOTUS"]       = 210,
	["HERB_WILDVINE"]          = 210,
	["HERB_SUNGRASS"]          = 230,
	["HERB_BLINDWEED"]         = 235,
	["HERB_GHOSTMUSHROOM"]     = 245,
	["HERB_GROMSBLOOD"]        = 250,
	["HERB_GOLDENSANSAM"]      = 260,
	["HERB_ARTHASTEAR"]        = 220,
	["HERB_DREAMFOIL"]         = 270,
	["HERB_MOUNTAINSILVERSAGE"]= 280,
	["HERB_PLAGUEBLOOM"]       = 285,
	["HERB_ICECAP"]            = 290,
	["HERB_BLACKLOTUS"]        = 300,
	-- TBC HERBS
	["HERB_FELWEED"]       = 300,
	["HERB_DREAMINGGLORY"] = 315,
	["HERB_TEROCONE"]      = 325,
	["HERB_RAGVEIL"]       = 325,
	["HERB_NETHERBLOOM"]   = 350,
	["HERB_FLAMECAP"]      = 335,
	["HERB_BLOODTHISTLE"]  = 1, -- Bloodthistle
	["HERB_ANCIENTLICHEN"] = 340, -- Ancient Lichen
	["HERB_NIGHTMAREVINE"] = 365, -- Nightmare Vine
	["HERB_MANATHISTLE"]   = 375, -- Mana Thistle
	["HERB_NETHERDUST"]    = 350,
	-- WotLK herbs
	["HERB_GOLDCLOVER"]    = 350,
	["HERB_TIGERLILY"]     = 400,
	["HERB_TALANDRASROSE"] = 385,
	["HERB_LICHBLOOM"]     = 425,
	["HERB_ICETHORN"]      = 435,
	["HERB_FROZENHERB"]    = 415,
	["HERB_FROSTLOTUS"]    = 450,
	["HERB_ADDERSTONGUE"]  = 400,
	["HERB_FIRETHORN"]     = 360,
}

-- lists item categories which are tracked by a tracking skill
-- that is different from their gather type
TrackingOverrides = {
	["TREASURE_BLOODPETAL"] = "HERB",
}

-- This table defines remappings of old object ids which need 
-- to be remapped to new ones
Gatherer.Nodes.ReMappings = {
	[183043] = 181275,
	[2846] = 2844,
	[164883] = 174622, -- Cleansed Whipper Root re-numbered to 174622
}

TrackingTextures = {
	["Interface\\Icons\\Spell_Nature_Earthquake"]   = "MINE",
	["Interface\\Icons\\INV_Misc_Flower_02"]        = "HERB",
	["Interface\\Icons\\Racial_Dwarf_FindTreasure"] = "OPEN",
	["Interface\\Icons\\INV_Misc_Fish_02"]          = "FISH",
}
