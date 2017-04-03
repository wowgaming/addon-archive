--[[---------------------------------------------------------------------------------
    Localisation for frFR.  Any commented lines need to be updated
----------------------------------------------------------------------------------]]

local L = Clique.Locals

if GetLocale() == "frFR" then
	L.RANK                    = "Rang"
	L.RANK_PATTERN            = "Rang (%d+)"
	L.CAST_FORMAT             = "%s(Rang %d)"

--	L.RACIAL_PASSIVE          = "Racial Passive"
	
--	L.CLICKSET_DEFAULT        = "Default"
--	L.CLICKSET_HARMFUL        = "Harmful actions"
--	L.CLICKSET_HELPFUL        = "Helpful actions"
--	L.CLICKSET_OOC            = "Out of Combat"

--	L.BINDING_NOT_DEFINED     = "Binding not defined"

--	L.HELP_TEXT               = "Welcome to Clique.  For basic operation, you can navigate the spellbook and decide what spell you'd like to bind to a specific click.  Then click on that spell with whatever click-binding you would like.  For example, navigate to \"Flash Heal\" and shift-LeftClick on it to bind that spell to Shift-LeftClick."
--	L.CUSTOM_HELP             = "This is the Clique custom edit screen.  From here you can configure any of the combinations that the UI makes available to us in response to clicks.  Select a base action from the left column.  You can then click on the button below to set the binding you'd like, and then supply the arguments required (if any)."
end
