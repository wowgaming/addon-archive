local spells = {
	34074,	-- Aspect of the Viper
	20043,	-- Aspect of the Wild
	13165,	-- Aspect of the Hawk
	13163,	-- Aspect of the Monkey
	5118,	-- Aspect of the Cheetah
	13159,	-- Aspect of the Pack
	13161,	-- Aspect of the Beast
	61846,	-- Aspect of the Dragonhawk
	19506	-- Trueshot Aura
}

local bar = ZActionBar_Create("ZAspect", spells, ZHunterModOptions, "ZHunterMod_Saved")
bar.setupSpecial = true

local texture = "Interface\\Icons\\Spell_Nature_WispSplode"
local macrotext = "/cast %s\n/cast %s"
local spell1 = ""
local spell2 = ""

local function checkSpecial(button)
	if UnitBuff("player", spell1) then
		button.spellName = spell2
		button:SetTexture(GetSpellTexture(spell2))
	else
		button.spellName = spell1
		button:SetTexture(GetSpellTexture(spell1))
	end
end

local function checkActive(bar)
	local start = bar.special and 2 or 1
	for i = start, bar.numButtons do
		if bar.button[i].isUsed then
			local spellName = bar.button[i].spellName
			if UnitBuff("player", spellName) then
				if not bar.button[i].customTexture then
					bar.button[i]:SetTexture(texture)
					bar.button[i].customTexture = 1
				end
			elseif bar.button[i].customTexture then
				bar.button[i]:SetTexture(GetSpellTexture(spellName))
				bar.button[i].customTexture = nil
			end
		end
	end
end

local function setup(bar)
	if bar.special then
		local button = bar.button[1]
		button:SetAttribute("macrotext", macrotext:format(spell1, spell2))
		checkSpecial(button)
	end
end

function bar.OnLoad(bar)
	bar:RegisterEvent("UNIT_AURA")
	bar:RegisterEvent("PLAYER_ENTERING_WORLD")
	bar:RegisterEvent("PLAYER_DEAD")
	checkActive(bar)
end

function bar.OnEvent(bar, event, arg1, arg2)
	if event == "UNIT_AURA" then
		if arg1 == "player" then
			if bar.special then
				checkSpecial(bar.button[1])
			end
			checkActive(bar)
		end
	elseif event == "BUTTON_SPELL_SET" then
		if arg1 == 2 then
			spell1 = arg2
			setup(bar)
		elseif arg1 == 3 then
			spell2 = arg2
			setup(bar)
		end
	elseif event == "SPECIAL_TOGGLED" then
		setup(bar)
		checkActive(bar)
	else
		if bar.special then
			checkSpecial(bar.button[1])
		end
		checkActive(bar)
	end
end