local function ShowPartyFrame()
	Healium_ShowHidePartyFrame(true)
end

local function ShowMeFrame()
	Healium_ShowHideMeFrame(true)
end

local function ShowPetsFrame()
	Healium_ShowHidePetsFrame(true)
end

local function ShowTanksFrame()
	Healium_ShowHideTanksFrame(true)
end

local function ShowFriendsFrame()
	Healium_ShowHideFriendsFrame(true)
end


local function SetButtonCount(info, arg1)
	if InCombatLockdown() then
		Healium_Warn("Can't update button count while in combat!")
		return
	end
	
	Healium_SetButtonCount(arg1)
end

local function SetCurrentSpell(info, btnIndex, spellIndex)
	if InCombatLockdown() then
		Healium_Warn("Can't configure buttons while in combat!")
		return
	end
	
	local Profile = Healium_GetProfile()
	
	Profile.SpellNames[btnIndex] = Healium_Spell.Name[spellIndex]
	Profile.SpellIcons[btnIndex] = Healium_Spell.Icon[spellIndex]
	
	UIDropDownMenu_SetText(HealiumDropDown[btnIndex], Profile.SpellNames[btnIndex])	

	Healium_UpdateButtonIcons()
	Healium_UpdateButtonSpells()
end

local function HealiumMenu_InitializeDropDown(self,level)
	level = level or 1
	
	local MenuTable = 
	{
		[1] = -- Define level one elements here
		{
			{ -- Title
				text = Healium_AddonColor .. Healium_AddonName .. "|r Menu",
				isTitle = 1,
				notCheckable = 1,
			},
			{ -- Config Panel
				text = Healium_AddonName .. " Config Panel",
				func = Healium_ShowConfigPanel,
				notCheckable = 1,
			},
			{ -- Set button count
				text = "Set button count",
				hasArrow = 1,
				value = "SetButtonCount",
				notCheckable = 1,
			},
			{ -- Configure Buttons
				text = "Configure Buttons",
				hasArrow = 1,
				value = "ConfigureButtons",
				notCheckable = 1,
			},
			{ -- Frames Submenu
				text = "Show / Hide Frames",
				hasArrow = 1,
				value = "Frames",
				notCheckable = 1,
			},
			{ -- Reset all frame postions
				text = "Reset all frame positions",
				func = Healium_ResetAllFramePositions,
				notCheckable = 1,
			},
			{ -- Close
				hasArrow  = nil,
				value  = nil,
				notCheckable = 1,
				text = CLOSE,
				func = self.HideMenu			
			}
		},
		[2] = -- Submenu items, keyed by value
		{
			["Frames"] = 
			{
				{
					text = "Toggle Frames",
					notCheckable = 1,
					func = Healium_ToggleAllFrames,
				},
				{	-- Party Frame
					text = "Show Party",
					notCheckable = 1,
					func = ShowPartyFrame,
				},
				{	-- Me Frame
					text = "Show Me",
					notCheckable = 1,
					func = ShowMeFrame,
				},
				{	-- Pet Frame
					text = "Show Pets",
					notCheckable = 1,					
					func = ShowPetsFrame,
				},
				{	-- Friends Frame
					text = "Show Friends",
					notCheckable = 1,					
					func = ShowFriendsFrame,
				},
				{	-- Tanks Frame
					text = "Show Tanks",
					notCheckable = 1,					
					func = ShowTanksFrame,
				},
				{
					text = "Hide All Raid Groups",
					notCheckable = 1,					
					func = Healium_HideAllRaidFrames,
				},
				{
					text = "Show Raid Groups 1 and 2 (10 man)",
					notCheckable = 1,					
					func = Healium_Show10ManRaidFrames,
				},
				{
					text = "Show Raid Groups 1-5 (25 man)",
					notCheckable = 1,					
					func = Healium_Show25ManRaidFrames,
				}, 
				{
					text = "Show Raid Groups 1-8 (40 man)",
					notCheckable = 1,					
					func = Healium_Show40ManRaidFrames,
				}, 
			},
		},
		[3] = {},
	}

	local sbc = { }
	local btnConfig = {}
	local Profile = Healium_GetProfile()	
	
--	if level >= 2 then

		
		for i=0, Healium_MaxButtons, 1 do
		
			-- configure SetButtonCount
			local menuItem = { }
			menuItem.text = i
			menuItem.checked = i == Profile.ButtonCount
			menuItem.func = SetButtonCount
			menuItem.arg1 = i
--			menuItem.disabled = nil
			table.insert(sbc, menuItem)

			-- configure Configure Buttons		
			if i > 0 and i <= Profile.ButtonCount then
				local btnMenuItem = { }
				btnMenuItem.text = "Button " .. i
				btnMenuItem.value = i
				btnMenuItem.hasArrow = true
				btnMenuItem.notCheckable = 1
				table.insert(btnConfig, btnMenuItem)
			end
		end
	
		MenuTable[2].SetButtonCount = sbc
		MenuTable[2].ConfigureButtons = btnConfig
--	end

   
--    if level >= 3 then
		local index = UIDROPDOWNMENU_MENU_VALUE or 1

		local spells =
		{
			{-- Title
				text = Healium_AddonColor .. Healium_AddonName .. "|r Button " .. index,
				isTitle = 1,
			}
		}
		
		local currentSpell = Profile.SpellNames[index]
		
		for k, v in ipairs (Healium_Spell.Name) do
			local spellmenuItem = { }
			spellmenuItem.text = Healium_Spell.Name[k]
			spellmenuItem.func = SetCurrentSpell
			spellmenuItem.icon = Healium_Spell.Icon[k]
			spellmenuItem.checked = currentSpell == Healium_Spell.Name[k]
			spellmenuItem.arg1 = index
			spellmenuItem.arg2 = k
			
			if (spellmenuItem.icon) then
				table.insert(spells, spellmenuItem)
			end
		end

		MenuTable[3][index] = spells
--	end
	
	local info = MenuTable[level]
	local menuval = UIDROPDOWNMENU_MENU_VALUE
	
	if (level > 1 and menuval) then
		if info[menuval] then
			info = info[menuval]
		end
	end

	for idx, entry in ipairs(info) do
		UIDropDownMenu_AddButton(entry, level)
	end

end

function Healium_InitMenu()
	HealiumMenu = CreateFrame("Frame", "HealiumOptionsMenu", Healium_MMButton, "UIDropDownMenuTemplate") 
	HealiumMenu:SetPoint("TOP", Healium_MMButton, "BOTTOM")
	UIDropDownMenu_Initialize(HealiumMenu, HealiumMenu_InitializeDropDown, "MENU");
--[[
	HealiumMenu.HideMenu = function()
		if UIDROPDOWNMENU_OPEN_MENU == HealiumMenu then
			CloseDropDownMenus()
		end
	end
--]]
end