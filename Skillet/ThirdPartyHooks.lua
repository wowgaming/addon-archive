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

--[[

This file contains functions intended to be used by authors of other mods.
I will make every effort never to change the names or behaviour of any of the
methods listed in this file. All bets are off for methods in other files though.

If you would like to see a method added here that would benefit your mod, by all
means contact me and let me know.

Hooking a Method Using AceHook
------------------------------

To hook this routine with an Ace2 mod, use (for example):

    self:Hook(Skillet, "GetExtraItemDetailText")

and write your method:

    function MyMod:GetExtraItemDetailText(obj, tradeskill, skill_index)
        -- get the previous value from the hook chain
        local before = self.hooks["GetExtraItemDetailText"](obj, tradeskill, skill_index)
        local myvalue = "samplething"
        if before then
            return before .. "\n" .. myvalue
        else
            return myvalue
        end
    end

Hooking a Method Without Using AceHook
--------------------------------------

local orig_get_extra = Skillet.GetExtraItemDetailText
Skillet.GetExtraItemDetailText = function(obj, tradeskill, skill_index)
    local before = orig_get_extra(obj, tradeskill, skill_index)
    local myvalue = "samplething"
    if before then
        return before .. "\n" .. myvalue
    else
        return myvalue
    end
end

In both methods, the 'obj' passed in will be a copy of the 'Skillet' main object.

Of course, the action you take with the previous value is entirely dependent
of what the method does. For methods that return text, you should probably
concatenetate the values. For something like Skillet:GetMinSkillButtonWidth()
you should return the maximum of the previous value and you value.

Please remember that there may be multple mods hooking these methods so please
be courteous and make sure not to discard their data, but rather combine it with
your own in as sane a fashion as possible.

]]

local function tradejunkie_custom_add()
    if TradeJunkieMain and TJ_OpenButtonTradeSkill then
        -- Override the default action of the button to attach it
        -- to our window, rather than the Blizzard trade skill window
        TJ_OpenButtonTradeSkill:SetScript("OnClick", function()
           TradeJunkie_Attach("SkilletFrame")
           TradeJunkieMain:SetPoint("TOPLEFT", "SkilletFrame", "TOPRIGHT", 0, 0)
        end)

    end
end

local function armorcraft_custom_add()
    if AC_Craft and AC_UseButton and AC_ToggleButton then
        AC_Craft:SetParent("SkilletFrame")
        AC_Craft:SetPoint("TOPLEFT","SkilletFrame","TOPRIGHT", 0, 0)
        AC_Craft:SetAlpha(1.0)
    end
end

local function Skillet_NOP()
    -- do nothing!
end

--=================================================================================
--                ******* Start of the public API ********
--=================================================================================

-- Adds a button to the tradeskill window. The button will be
-- reparented and placed appropriately in the window.
--
-- You should not hook this method, you should call it directly.
--
-- The frame representing the main tradeskill window will be
-- returned in case you need to pop up a frame attached to it.
function Skillet:AddButtonToTradeskillWindow(button)

    if not SkilletFrame.added_buttons then
        SkilletFrame.added_buttons = {}
    end

    if TJ_OpenButtonTradeSkill and button == TJ_OpenButtonTradeSkill then
        tradejunkie_custom_add()
    elseif AC_UseButton and button == AC_UseButton then
        armorcraft_custom_add()
    end
	
	button:Hide()
	
    -- See if this button has already been added ....
    for i=1, #SkilletFrame.added_buttons, 1 do
        if SkilletFrame.added_buttons[i] == button then
            -- ... yup
            return SkilletFrame
        end
    end
	

    -- ... nope
    table.insert(SkilletFrame.added_buttons, button)
    return SkilletFrame

end

--
-- Adds a sort method to those used for recipe names.
--
-- You should not hook this method, you should call it directly.
--
-- With this method you can add your own custom sorting to the
-- list of recipes in the scrolling list.
--
-- @param text The name of you sorting method, will be shown to the
--        user in a drop-down menu
-- @param method Your sorting method (described below)
--
-- Your sorting method must have the following signature
--
--    function sort(tradeskill, index_a, index_b)
--
-- where:
--    tradeskill is the name of the currently selected tradeskill
--    index_a in the skill index of the first recipe
--    index_b is the skill index of the second recipe
--
-- Your method must return 'true' if a should be before b and 'false'
-- if a should be after b.
--
function Skillet:AddRecipeSorter(text, sorter)
    self:internal_AddRecipeSorter(text, sorter)
end

--
-- A hook to get the reagent label
--
-- Refer to the notes at the top of this file for how to hook this method.
--
-- @param tradeskill name of the currently selected tradeskill
-- @param skill_index the index of the currently selected recipe
--
function Skillet:GetReagentLabel(tradeskill, skill_index)
    if (FRC_PriceSource ~= nill and FRC_CraftFrame_SetSelection and FRC_TradeSkillFrame_SetSelection) then
        -- Support for Fizzwidget's Reagent Cost
        if self:IsCraft() then
            local Orig_CraftFrame_SetSelection = FRC_Orig_CraftFrame_SetSelection;
            FRC_Orig_CraftFrame_SetSelection = Skillet_NOP;
            FRC_CraftFrame_SetSelection(skill_index);
            FRC_Orig_CraftFrame_SetSelection = Orig_CraftFrame_SetSelection;
            return CraftReagentLabel:GetText();
        else
            local Orig_TradeSkillFrame_SetSelection = FRC_Orig_TradeSkillFrame_SetSelection
            FRC_Orig_TradeSkillFrame_SetSelection = Skillet_NOP
            FRC_TradeSkillFrame_SetSelection(skill_index)
            FRC_Orig_TradeSkillFrame_SetSelection = Orig_TradeSkillFrame_SetSelection
            return TradeSkillReagentLabel:GetText()
        end
    else
        -- boring
        return SPELL_REAGENTS;
    end
end

--
-- A hook to get text to prefix the name of the recipe in the scrolling list of recipes.
-- If you hook this method, make sure to include any text you get from calling the hooked method.
-- This will allow more than one mod to use the hook.
--
-- This will be called for both crafts and tradeskills, you can use Skillet:IsCraft()
-- to determine if it's a craft. This avoid having to localize the tradeskill name just to
-- see if it is a craft or a tradeskill.
--
-- Refer to the notes at the top of this file for how to hook this method.
--
-- @param tradeskill name of the currently selected tradeskill
-- @param skill_index the index of the currently selected recipe
--
function Skillet:GetRecipeNamePrefix(tradeskill, skill_index)
end

--
-- A hook to get text to append to the name of the recipe in the scrolling list of recipes
-- If you hook this method, make sure to include any text you get from calling the hooked method.
-- This will allow more than one mod to use the hook.
--
-- This will be called for both crafts and tradeskills, you can use Skillet:IsCraft()
-- to determine if it's a craft. This avoid having to localize the tradeskill name just to
-- see if it is a craft or a tradeskill.
--
-- Refer to the notes at the top of this file for how to hook this method.
--
-- @param tradeskill name of the currently selected tradeskill
-- @param skill_index the index of the currently selected recipe
--
function Skillet:GetRecipeNameSuffix(tradeskill, skill_index)
end

--
-- A hook to display extra information about a recipe. Any text returned from this function
-- will be displayed in the recipe details frame when the user clicks on the recipe name.
-- The text will be added to the bottom the frame, after the list of reagents.
--
-- This will be called for both crafts and tradeskills, you can use Skillet:IsCraft()
-- to determine if it's a craft. This avoid having to localize the tradeskill name just to
-- see if it is a craft or a tradeskill.
--
-- Refer to the notes at the top of this file for how to hook this method.
--
-- @param tradeskill name of the currently selected tradeskill
-- @param skill_index the index of the currently selected recipe
--
function Skillet:GetExtraItemDetailText(tradeskill, skill_index)
end

--
-- Returns the minimum width of the skill button. This is the
-- button that displays the name of the recipe in the scrolling
-- list. If you was to add text to the button and need more room,
-- then hook this method and return a minimum width for the button
-- that works for your mod.
--
-- The hard limit is 165, any size below this will be ignored
--
-- Refer to the notes at the top of this file for how to hook this method.
--
-- @return the minimum width allow for a recipe button
--
function Skillet:GetMinSkillButtonWidth()
end

--
-- Called immediately before the button containng the name of a
-- tradeskill recipe is displayed in the scrolling list
--
-- The value you return from this method (if not nil) will have it's
-- :Show() method called. You can return the button based in to have
-- Skillet's button shown, or you can return your own button.
--
-- If you return your own button, you are responsible for attaching
-- properly in the list. The list_offset parameter might be useful
-- here as you could use this to determine the name of the button
-- immediately before this one in the list and attach to it.
--
-- Refer to the notes at the top of this file for how to hook this method.
--
-- @param button the button that is about to be displayed
-- @param tradeskill the name of the currently selected tradeskill
-- @param skill_index the index of recipe thius button is used for
-- @param list_offset how far down in the scrolling this button is located.
--        No matter where the list is scrolled to, the first visible recipe
--        is at list_offset 0
--
-- @return a button who's :Show() method is to be called. Use nil to have
--         the default button used.
--
function Skillet:BeforeRecipeButtonShow(button, tradeskill, skill_index, list_offset)
    -- these tests are in here to make sure that I don't
    -- accidentally break the hooking code.
    assert(button, "Button cannot be nil")
    assert(tradeskill  and tostring(tradeskill), "Tradeskill cannot be nil")
    assert(skill_index and tonumber(skill_index) and skill_index > 0, "Recipe index cannot be nil")
    assert(list_offset and tonumber(list_offset) and list_offset > 0, "List offset cannot be nil")

    return button
end

--
-- Called immediately before the button containing the name of a
-- tradeskill recipe is hidden in the scrolling list
--
-- The value you return from this method (if not nil) will have it's
-- :Hide() method called. You can return the button based in to have
-- Skillet's button hidden, or you can return your own button.
--
-- If you return your own button, you are responsible for attaching
-- properly in the list. The list_offset parameter might be useful
-- here as you could use this to determine the name of the button
-- immediately before this one in the list and attach to it.
--
-- Refer to the notes at the top of this file for how to hook this method.
--
-- @param button the button that is about to be hidden
-- @param tradeskill the name of the currently selected tradeskill
-- @param skill_index the index of the recipe this button is used for
-- @param list_offset how far down in the scrolling this button is located.
--        No matter where the list is scrolled to, the first visible recipe
--        is at list_offset 0
--
-- @return a button who's :Hide() method is to be called. Use nil to have
--         the default button used.
--
function Skillet:BeforeRecipeButtonHide(button, tradeskill, skill_index, list_offset)
    -- these tests are in here to make sure that I don't
    -- accidentally break the hooking code.
    assert(button, "Button cannot be nil")
    assert(tradeskill  and tostring(tradeskill), "Tradeskill cannot be nil")
    assert(skill_index and tonumber(skill_index) and skill_index >= 0, "Recipe index cannot be nil")
    assert(list_offset and tonumber(list_offset) and list_offset >= 0, "List offset cannot be nil")

    return button
end

--
-- Adds a method that will be called before a button in the recipe list
-- is shown. If multiple methods are added, they will be called in the
-- order they are registered.
--
-- The method you provide *must* have the following signature and behaviour:
--
--   function yourfunc(button, tradeskill, skill_index, list_offset)
--
--     where:
--        o button the button that is about to be displayed
--        o tradeskill the name of the currently selected tradeskill
--        o skill_index the index of recipe thius button is used for
--        o list_offset how far down in the scrolling this button is located.
--          No matter where the list is scrolled to, the first visible recipe
--          is at list_offset 0
--
--     returns:
--        the button who's :Show() method is to be called
--
-- If you return your own button (instead of returning the button passed in),
-- you are responsible for attaching it properly in the list. The list_offset
-- parameter might be useful here as you could use this to determine the name
-- of the button immediately before this one in the list and attach to it.
--
function Skillet:AddPreButtonShowCallback(method)
    assert(method and type(method) == "function",
           "Usage: Skillet:AddPreButtonShowCallback(method). method must be a non-nil function")
    self:internal_AddPreButtonShowCallback(method)
end

--
-- Adds a method that will be called before a button in the recipe list
-- is hidden. If multiple methods are added, they will be called in the
-- order they are registered.
--
-- The method you provide *must* have the following signature and behaviour:
--
--   function yourfunc(button, tradeskill, skill_index, list_offset)
--
--     where:
--        o button the button that is about to be displayed
--        o tradeskill the name of the currently selected tradeskill
--        o skill_index the index of recipe thius button is used for
--        o list_offset how far down in the scrolling this button is located.
--          No matter where the list is scrolled to, the first visible recipe
--          is at list_offset 0
--
--     returns:
--        the button who's :Hide() method is to be called
--
-- If you return your own button (instead of returning the button passed in),
-- you are responsible for attaching it properly in the list. The list_offset
-- parameter might be useful here as you could use this to determine the name
-- of the button immediately before this one in the list and attach to it.
--
function Skillet:AddPreButtonHideCallback(method)
    assert(method and type(method) == "function",
           "Usage: Skillet:AddPreButtonShowCallback(method). method must be a non-nil function")
    self:internal_AddPreButtonHideCallback(method)
end

--
-- Shows the trade skill frame for the currently selected tradeskill or craft.
--
-- Refer to the notes at the top of this file for how to hook this method.
-- If you do not (eventually) call the hooked method from your method, the
-- window will not be shown.
--
function Skillet:ShowTradeSkillWindow()
    return self:internal_ShowTradeSkillWindow()
end

--
-- Hides the Skillet trade skill window. Does nothing if the window is not visible
--
-- Refer to the notes at the top of this file for how to hook this method.
-- If you do not (eventually) call the hooked method from your method, the
-- window will not be hidden.
--
--
function Skillet:HideTradeSkillWindow()
    return self:internal_HideTradeSkillWindow()
end

--
-- Called to update the trade skill window. This will redraw the main
-- tradeskill window with the current settings.
--
-- Refer to the notes at the top of this file for how to hook this method.
-- If you do not (eventually) call the hooked method from your method, the
-- window will not be updated.
--
function Skillet:UpdateTradeSkillWindow()
	return self:internal_UpdateTradeSkillWindow()
end

--
-- Hides any and all Skillet windows that are open
--
-- Refer to the notes at the top of this file for how to hook this method.
-- If you do not (eventually) call the hooked method from your method, the
-- windows will not be hidden.
--
--
function Skillet:HideAllWindows()
    return self:internal_HideAllWindows()
end

--
-- Fills out and displays the shopping list frame
--
-- Refer to the notes at the top of this file for how to hook this method.
-- If you do not (eventually) call the hooked method from your method, the
-- window will not be shown.
--
-- @param atBank whether or not we are displaying the shopping list at a bank
--
function Skillet:DisplayShoppingList(atBank)
    return self:internal_DisplayShoppingList(atBank)
end

--
-- Hides the shopping list window
--
-- Refer to the notes at the top of this file for how to hook this method.
-- If you do not (eventually) call the hooked method from your method, the
-- window will not be hidden.
--
function Skillet:HideShoppingList()
    return self:internal_HideShoppingList()
end

--
-- Causes the list of recipes to be resorted. This should only be called
-- when the trade skill window is open.
--
-- You should not hook this method, you should call it directly.
--
--
-- returns the number of trade skills in the sorted and filtered list
function Skillet:SortAndFilterRecipes()
    return self:internal_SortAndFilterRecipes()
end


-- =================================================================
--                Skillet Recipe API
-- =================================================================

--[[

All data returned from theses methods is to be considered READ-ONLY

Data Formats
============

Reagent = {
    ["name"] = name,
    ["link"] = link,
    ["needed"] = number,
    ["texture"] = texture
}

Recipe = {
    ["name"] = name,
    ["link"] = link,
    ["texture"] = texture
    ["difficulty"] = "optimal", "medium", "easy", trivial" (non-localized)
    ["nummade"] = number made, (how many this recipe make)
    ["tools"] = "tools", (tools required, nil for no requirements)
    ["count"] = number of reagents for this recipe
    [index 1] = Reagent,
    [index 2] = Reagent,
    ....
}

So, recipe.name is the name of the recipe, recipe[1].name is the name of
the first required reagent.

Profession = {
    ["name"] = trade skill name
    ["count"] = number of recipes for this profession
    [recipe 1] = Recipe,
    [recipe 2] = Recipe,
    ....
}

So, profession.name is the name of the profession, profession[1].name is the
name of the first recipe in the profession.

Character = {
    ["name"] = name of the character
    ["count"] = number of professions for this character
    [profession 1] = Profession,
    [profession 2] = Profession,
    ...
}

So, character.name is the name of the character, character[1].name is the
name of the first profession known by that character.

Characters = {
    ["count"] = number of characters
    [character 1] = Character,
    [character 2] = Character,
}

So, characters.count is the number of characters, characters[1].name is the
name of the first character.

]]

--
-- Returns a list of characters for which Skillet recipe data
-- is available. This list will apply only to current realm and
-- faction. Characters on other servers or in the opposite
-- faction will no be included.
--
-- You should not hook this method, you should call it directly.
--
-- @return A list of characters for which Skillet has data
--
function Skillet:GetCharacters()
    return self:internal_GetCharacters()
end

--
-- Returns the list of professions that a particular character
-- knows. The character name must be one of those returned by
-- Skillet:GetCharacters().
--
-- You should not hook this method, you should call it directly.
--
-- @param character_name the character for which a profession list
--           should be returned
--
-- @return A list of professions for the specified character or nil
--            if the character has no professions known to Skillet.
--
function Skillet:GetCharacterProfessions(character_name)
    return self:internal_GetCharacterProfessions(character_name)
end

--
-- Returns the list of tradeskills for the specified character
-- and profession, or nil if either the character or profession
-- is unknown to Skillet.
--
-- You should not hook this method, you should call it directly.
--
-- @param character_name the character for which a tradeksill list
--           should be returned
-- @param professions the profession for which a tradeksill list
--           should be returned
--
-- @return A table of tradeskills known for the specified character name
--           and profession. Refer to the comment above for details on
--           the table's format.
--
function Skillet:GetCharacterTradeskills(character_name, profession)
    return self:internal_GetCharacterTradeskills(character_name, profession)
end
