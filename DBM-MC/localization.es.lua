if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

----------------
--  Lucifron  --
----------------
L = DBM:GetModLocalization("Lucifron")

L:SetGeneralLocalization{
	name = "Lucifron"
}

----------------
--  Magmadar  --
----------------
L = DBM:GetModLocalization("Magmadar")

L:SetGeneralLocalization{
	name = "Magmadar"
}

----------------
--  Gehennas  --
----------------
L = DBM:GetModLocalization("Gehennas")

L:SetGeneralLocalization{
	name = "Gehennas"
}

------------
--  Garr  --
------------
L = DBM:GetModLocalization("Garr")

L:SetGeneralLocalization{
	name = "Garr"
}

--------------
--  Geddon  --
--------------
L = DBM:GetModLocalization("Geddon")

L:SetGeneralLocalization{
	name = "Barón Geddon"
}

L:SetOptionLocalization{
	SetIconOnBombTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(20475)
}

----------------
--  Shazzrah  --
----------------
L = DBM:GetModLocalization("Shazzrah")

L:SetGeneralLocalization{
	name = "Shazzrah"
}

----------------
--  Sulfuron  --
----------------
L = DBM:GetModLocalization("Sulfuron")

L:SetGeneralLocalization{
	name = "Sulfuron Presagista"
}

----------------
--  Golemagg  --
----------------
L = DBM:GetModLocalization("Golemagg")

L:SetGeneralLocalization{
	name = "Golemagg el Incinerador"
}
L:SetWarningLocalization{
	WarnP2Soon	= "Fase 2 pronto"
}
L:SetOptionLocalization{
	WarnP2Soon 	= "Mostrar un pre-aviso para la fase 2"
}

-----------------
--  Majordomo  --
-----------------
L = DBM:GetModLocalization("Majordomo")

L:SetGeneralLocalization{
	name = "Mayordomo Executus"
}

L:SetMiscLocalization{
	Kill	= "¡Imposible! Deponed el ataque mortales... ¡Me rindo! ¡Me rindo!"
}

----------------
--  Ragnaros  --
----------------
L = DBM:GetModLocalization("Ragnaros")

L:SetGeneralLocalization{
	name = "Ragnaros"
}
L:SetWarningLocalization{
	WarnSubmerge		= "Sumersión",
	WarnSubmergeSoon	= "Sumersión pronto",
	WarnEmerge			= "Emerge",
	WarnEmergeSoon		= "Emerge pronto"
}
L:SetTimerLocalization{
	TimerCombatStart	= "Empieza el combate",
	TimerSubmerge		= "Sumersión",
	TimerEmerge			= "Emerge"
}
L:SetOptionLocalization{
	TimerCombatStart	= "Mostrar tiempo para inicio del combate",
	WarnSubmerge		= "Mostrar aviso para sumersión",
	WarnSubmergeSoon	= "Mostrar pre-aviso para sumersión",
	TimerSubmerge		= "Mostrar tiempo para sumersión",
	WarnEmerge			= "Mostrar aviso para emersión",
	WarnEmergeSoon		= "Mostrar pre-aviso para emersión",
	TimerEmerge			= "Mostrar tiempo para emersión"
}
L:SetMiscLocalization{
	Submerge	= "¡AVANZAD, MIS SIRVIENTES! ¡DEFENDED A VUESTRO MAESTRO!",
	Pull		= "¡Crías imprudentes! ¡Os habéis precipitado hasta vuestra propia muerte! ¡Ahora mirad, el maestro se agita!"
}