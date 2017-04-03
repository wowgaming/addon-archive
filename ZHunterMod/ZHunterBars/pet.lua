local spells = {
--	883,  -- Call Pet
--	136,  -- Mend Pet
	6991, -- Feed Pet
	1002, -- Eyes of the Beast
	2641, -- Dismiss Pet
	1462, -- Beast Lore
	1515, -- Tame Beast
	1513, -- Scare Beast
	982,  -- Revive Pet
	62757 -- Call Stabled Pet
}

local bar = ZActionBar_Create("ZPet", spells, ZHunterModOptions, "ZHunterMod_Saved")
bar.special = true

local macrotext = "/cast [target=pet, dead] [modifier:ctrl] "..GetSpellInfo(982).."; [nopet] "..GetSpellInfo(883).."; "..GetSpellInfo(136)

local function setup(bar)
	local spellName = SecureCmdOptionParse(macrotext)
	bar.button[1]:SetTexture(GetSpellTexture(spellName))
	bar.button[1].spellName = spellName
end

function bar.OnLoad(bar)
	bar:RegisterEvent("UNIT_PET")
	bar:RegisterEvent("MODIFIER_STATE_CHANGED")
	bar.button[1]:SetAttribute("macrotext", macrotext)
	setup(bar)
end

function bar.OnEvent(bar, event, arg1)
	if event == "UNIT_PET" and arg1 == "player" or event == "MODIFIER_STATE_CHANGED" then
		setup(bar)
	end
end