--[[
************************************************************************
Colour.lua
Colouring functions for ARL
************************************************************************
File date: 2010-01-02T20:37:10Z 
File revision: 2791 
Project revision: 2817
Project version: v1.0-r2818
************************************************************************
Code adopted from Crayon library
************************************************************************
Please see http://www.wowace.com/addons/arl/ for more information.
************************************************************************
This source code is released under All Rights Reserved.
************************************************************************
]]--


local MODNAME			= "Ackis Recipe List"
local addon				= LibStub("AceAddon-3.0"):GetAddon(MODNAME)

--Colour constants
local RED		= "ff0000"
local ORANGE	= "ff7f00"
local YELLOW	= "ffff00"
local GREEN		= "00ff00"
local WHITE		= "ffffff"
local COPPER	= "eda55f"
local SILVER	= "c7c7cf"
local GOLD		= "ffd700"
local PURPLE	= "9980CC"
local BLUE		= "0000ff"
local CYAN		= "00ffff"
local BLACK		= "000000"
local GREY		= "666666"
local MIDGREY	= "858585"
local NEUTRAL	= "bfbfbf"
local FRIENDLY	= WHITE
local HONORED	= "00ff00"
local REVERED	= "3f66e5"
local EXALTED	= "9933cc"

local TRAINER	= "d9cb9e"
local VENDOR	= "aad372"
local QUEST		= "2359ff"
local REP		= "ff7c0a"
local SEASON	= "80590e"
local MOBDROP	= "ffffc0"

local POOR		= "919191"
local COMMON	= WHITE
local UNCOMMON	= "00A900"
local RARE		= "0062C3"
local EPIC		= "B343FF"
local LEGENDARY	= "FA9900"
local ARTIFACT	= "e5cc80"

local HIGH		= WHITE
local NORMAL	= "ffd100"

local HORDE		= RED
local ALLIANCE	= "00ffff"
----------------------------------------------------------------------
--Text colourization functions
----------------------------------------------------------------------
function addon:RGBtoHEX(r,g,b)
	return string.format("%2x%2x%2x", r*255, g*255, b*255)
end


-- Changes any string of text to the specified hex colour
function addon:Colourize(hexColour, text)

	return "|cff" .. tostring(hexColour or 'ffffff') .. tostring(text) .. "|r"

end

-- Converts text to Neutral Colour
function addon:Neutral(text)
	return self:Colourize(NEUTRAL, text)
end

-- Converts text to Friendly Colour
function addon:Friendly(text)
	return self:Colourize(FRIENDLY, text)
end

-- Converts text to Honored Colour
function addon:Honored(text)
	return self:Colourize(HONORED, text)
end

-- Converts text to Revered Colour
function addon:Revered(text)
	return self:Colourize(REVERED, text)
end

-- Converts text to Exalted Colour
function addon:Exalted(text)
	return self:Colourize(EXALTED, text)
end

function addon:Horde(text)
	return self:Colourize(RED, text)
end

function addon:Alliance(text)
	return self:Colourize(CYAN, text)
end

function addon:Coords(text)
	return self:Colourize(WHITE, text)
end

function addon:Trainer(text)
	return self:Colourize(TRAINER, text)
end

function addon:Vendor(text)
	return self:Colourize(VENDOR, text)
end

function addon:Quest(text)
	return self:Colourize(QUEST, text)
end

function addon:Rep(text)
	return self:Colourize(REP, text)
end

function addon:Season(text)
	return self:Colourize(SEASON, text)
end

function addon:MobDrop(text)
	return self:Colourize(MOBDROP, text)
end

-- Rarity Colors
function addon:Poor(text)
	return self:Colourize(POOR, text)
end

function addon:Common(text)
	return self:Colourize(COMMON, text)
end

function addon:Uncommon(text)
	return self:Colourize(UNCOMMON, text)
end

function addon:Rare(text)
	return self:Colourize(RARE, text)
end

function addon:Epic(text)
	return self:Colourize(EPIC, text)
end

function addon:Legendary(text)
	return self:Colourize(LEGENDARY, text)
end

function addon:Artifact(text)
	return self:Colourize(ARTIFACT, text)
end

function addon:RarityColor(rarityColor, text)
	if (rarityColor == 1) then
		return self:Colourize(POOR, text)
	elseif (rarityColor == 2) then
		return self:Colourize(COMMON, text)
	elseif (rarityColor == 3) then
		return self:Colourize(UNCOMMON, text)
	elseif (rarityColor == 4) then
		return self:Colourize(RARE, text)
	elseif (rarityColor == 5) then
		return self:Colourize(EPIC, text)
	elseif (rarityColor == 6) then
		return self:Colourize(LEGENDARY, text)
	else
		return self:Colourize(ARTIFACT, text)
	end
end

-- Converts text to Red
function addon:Red(text)
	return self:Colourize(RED, text)
end

-- Converts text to Orange
function addon:Orange(text)
	return self:Colourize(ORANGE, text)
end

-- Converts text to Yellow
function addon:Yellow(text)
	return self:Colourize(YELLOW, text)
end

-- Converts text to Green
function addon:Green(text)
	return self:Colourize(GREEN, text)
end

-- Converts text to White
function addon:White(text)
	return self:Colourize(WHITE, text)
end

-- Converts text to Copper
function addon:Copper(text)
	return self:Colourize(COPPER, text)
end

-- Converts text to Silver
function addon:Silver(text)
	return self:Colourize(SILVER, text)
end

-- Converts text to Gold
function addon:Gold(text)
	return self:Colourize(GOLD, text)
end

-- Converts text to Purple
function addon:Purple(text)
	return self:Colourize(PURPLE, text)
end

-- Converts text to Blue
function addon:Blue(text)
	return self:Colourize(BLUE, text)
end

-- Converts text to Cyan
function addon:Cyan(text)
	return self:Colourize(CYAN, text)
end

-- Converts text to Black
function addon:Black(text)
	return self:Colourize(BLACK, text)
end

-- Converts text to Grey
function addon:Grey(text)
	return self:Colourize(GREY, text)
end

-- Converts text to Middle Grey
function addon:MidGrey(text)
	return self:Colourize(MIDGREY, text)
end

-- Standard bliz yellowish sort of thing
function addon:Normal(text)
	return self:Colourize(NORMAL, text)
end

-- used for tooltip rgb stuff
function addon:hexcolor(colorstring)
	if (colorstring == "NEUTRAL")			then return NEUTRAL
	elseif (colorstring == "FRIENDLY")		then return FRIENDLY
	elseif (colorstring == "HONORED")		then return HONORED
	elseif (colorstring == "REVERED")		then return REVERED
	elseif (colorstring == "EXALTED")		then return EXALTED

	elseif (colorstring == "TRAINER")		then return TRAINER
	elseif (colorstring == "VENDOR")		then return VENDOR
	elseif (colorstring == "QUEST")			then return QUEST
	elseif (colorstring == "REP")			then return REP
	elseif (colorstring == "SEASON")		then return SEASON
	elseif (colorstring == "MOBDROP")		then return MOBDROP

	elseif (colorstring == "POOR")			then return POOR
	elseif (colorstring == "COMMON")		then return COMMON
	elseif (colorstring == "UNCOMMON")		then return UNCOMMON
	elseif (colorstring == "RARE")			then return RARE
	elseif (colorstring == "EPIC")			then return EPIC
	elseif (colorstring == "LEGENDARY")		then return LEGENDARY
	elseif (colorstring == "ARTIFACT")		then return ARTIFACT

	elseif (colorstring == "HORDE")			then return HORDE
	elseif (colorstring == "ALLIANCE")		then return ALLIANCE

	elseif (colorstring == "BLACK")			then return BLACK
	elseif (colorstring == "ORANGE")		then return ORANGE
	elseif (colorstring == "GREEN")			then return GREEN
	elseif (colorstring == "YELLOW")		then return YELLOW
	elseif (colorstring == "GREY")			then return GREY
	elseif (colorstring == "MIDGREY")		then return MIDGREY
	elseif (colorstring == "RED")			then return RED

	elseif (colorstring == "HIGH")			then return HIGH
--	elseif (colorstring == "NORMAL")		then return NORMAL
	else
		return NORMAL
	end
----------------------------------------------------------------------
end
