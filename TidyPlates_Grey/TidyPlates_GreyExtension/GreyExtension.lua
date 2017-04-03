--[[
Direct Theme Customization 
--------------------------------------------------------------------------
This file can be used to customize someone's premade theme, such as the 
'Grey' theme that comes with Tidy Plates.  You can ovverride or hook
the original appearance or functions with the simple methods, shown below.

The only requirement to do this is that you list the theme addon as a 
dependency (See the TOC file).

Make sure you change the 'local theme =' line (below) to reflect the 
proper theme.

--]]

-- Reference to the theme table
-- Right now, it's acting on "Grey/DPS", but you could use "Grey/Tank", too
local theme = TidyPlatesThemeList["Grey/DPS"]		
-- Table for original function reference
local OriginalFunctions = {}
-- Stores an original function
OriginalFunctions.SetAlpha = theme.SetAlpha


--[[ 
Function Hooking/Ovverriding; Example, Part 1:  
--------------------------------------------------------------------------
We'd like to hide specific mobs.  I've made a table
which contains a list of units to watch out for.  Calling the
table with the unit name as an index will return 'true' if the 
unit is defined on the list (with a return value of true),
and 'false' if the unit is not present.

Continued....

--]]
local UnitNameWatchlist = {
	["Drudge Ghoul"] = true,
}


--[[
Function Hooking/Ovverriding; Example, Part 2: 
--------------------------------------------------------------------------
Here, I've created a function which calls the list
with the unit name as the index.  If the name matches, and returns 
'true', the function will return 0, making the nameplate completely
transparent, and bypassing the original function.  

If the name is not found, the function will call the original
function, allowing the default behavior to continue.
--]]
local function ExtensionSetAlpha(unit)
	if UnitNameWatchlist[unit.name] then return 0 end
	return OriginalFunctions.SetAlpha(unit)
end


--[[
Function Hooking/Ovverriding; Example, Part 2: 
--------------------------------------------------------------------------
This last line sets our theme function pointer to 
the new function we created.
--]]
theme.SetAlpha = ExtensionSetAlpha


--[[
Style/Appearance Editing
--------------------------------------------------------------------------
Here's an example of how you can edit Grey's style.  See the 
TidyPlatesDefaults.lua file (under the TidyPlates folder) for a complete
list of style elements.
--]]

-- Modify the shape of the hitbox
--theme.hitbox.width = 145
--theme.hitbox.height = 40

-- Show's the level text
--theme.options.showLevel = true

-- Decreases the width of the unit's name textbox, so the level fits 
--theme.name.width = 88

-- Raises the vertical position of the artwork
--theme.frame = { y = 6 }


--[[
Function Name Reference and Examples
--------------------------------------------------------------------------
OriginalFunctions.SetSpecialText = theme.SetSpecialText
OriginalFunctions.SetSpecialText2 = theme.SetSpecialText2
OriginalFunctions.SetScale = theme.SetScale
OriginalFunctions.SetAlpha = theme.SetAlpha
OriginalFunctions.OnUpdate = theme.OnUpdate
OriginalFunctions.OnInitialize = theme.OnInitialize
OriginalFunctions.SetHealthbarColor = theme.SetHealthbarColor

theme.SetSpecialText
theme.SetSpecialText2
theme.SetScale
theme.SetAlpha 
theme.OnUpdate 
theme.OnInitialize 
theme.SetHealthbarColor

--]]


