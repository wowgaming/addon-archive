if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

------------
-- Skeram --
------------
L = DBM:GetModLocalization("Skeram")

L:SetGeneralLocalization{
	name = "El profeta Skeram"
}

L:SetOptionLocalization{
	SetIconOnMC		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(785)
}

----------------
-- Three Bugs --
----------------
L = DBM:GetModLocalization("ThreeBugs")

L:SetGeneralLocalization{
	name = "Los tres bichos"
}
L:SetMiscLocalization{
	Yauj = "Princesa Yauj",
	Vem = "Vem",
	Kri = "Lord Kri"
}

-------------
-- Sartura --
-------------
L = DBM:GetModLocalization("Sartura")

L:SetGeneralLocalization{
	name = "Guardia de batalla Sartura"
}

--------------
-- Fankriss --
--------------
L = DBM:GetModLocalization("Fankriss")

L:SetGeneralLocalization{
	name = "Fankriss el Implacable"
}
L:SetWarningLocalization{
	WarnWound	= "%s en >%s< (%s)"
}
L:SetOptionLocalization{
	WarnWound = DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(25646, GetSpellInfo(25646) or "unknown")
}
--------------
-- Viscidus --
--------------
L = DBM:GetModLocalization("Viscidus")

L:SetGeneralLocalization{
	name = "Viscidus"
}
L:SetWarningLocalization{
	WarnFreeze	= "Congelación: %d/3",
	WarnShatter	= "Roto: %d/3"
}
L:SetOptionLocalization{
	WarnFreeze	= "Anunciar el estado de Congelación",
	WarnShatter	= "Anunciar el estado de rotura",
}
L:SetMiscLocalization{
	Phase4 	= "empieza a agrietarse",
	Phase5 	= "parece listo para romper",
	Phase6 	= "explota"
}
-------------
-- Huhuran --
-------------
L = DBM:GetModLocalization("Huhuran")

L:SetGeneralLocalization{
	name = "Princesa Huhuran"
}
L:SetWarningLocalization{
	WarnAcid	= "%s en >%s< (%s)"
}
L:SetOptionLocalization{
	WarnAcid	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(26180, GetSpellInfo(26180) or "unknown")
	}
---------------
-- Twin Emps --
---------------
L = DBM:GetModLocalization("TwinEmpsAQ")

L:SetGeneralLocalization{
	name = "Gemelos emperadores"
}
L:SetMiscLocalization{
	Veklor = "Emperador Vek'lor",
	Veknil = "Emperador Vek'nilash"
}

------------
-- C'Thun --
------------
L = DBM:GetModLocalization("CThun")

L:SetGeneralLocalization{
	name = "C'Thun"
}
L:SetOptionLocalization{
	RangeFrame	= "Mostrar distancia"
}
----------------
-- Ouro --
----------------
L = DBM:GetModLocalization("Ouro")

L:SetGeneralLocalization{
	name = "Ouro"
}
L:SetWarningLocalization{
	WarnSubmerge		= "Se Sumerge",
	WarnEmerge			= "Emerge",
	WarnSubmergeSoon	= "Se Sumerge pronto",
	WarnEmergeSoon		= "Emerge pronto"
}
L:SetTimerLocalization{
	TimerSubmerge		= "Se Sumerge",
	TimerEmerge			= "Emerge"
}
L:SetOptionLocalization{
	WarnSubmerge		= "Mostrar aviso para sumersión",
	WarnSubmergeSoon	= "Mostrar pre-aviso para sumersión",
	TimerSubmerge		= "Mostrar tiempo para sumersión",
	WarnEmerge			= "Mostrar aviso para emersión",
	WarnEmergeSoon		= "Mostrar pre-aviso para emersión",
	TimerEmerge			= "Mostrar tiempo para emersión"
}