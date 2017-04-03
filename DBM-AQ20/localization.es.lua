if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------
-- Kurinnaxx --
---------------
L = DBM:GetModLocalization("Kurinnaxx")

L:SetGeneralLocalization{
	name 		= "Kurinnaxx"
}
L:SetWarningLocalization{
	WarnWound	= "%s en >%s< (%s)"
}
L:SetOptionLocalization{
	WarnWound	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(25646, GetSpellInfo(25646) or "unknown"),	
}
------------
-- Rajaxx --
------------
L = DBM:GetModLocalization("Rajaxx")

L:SetGeneralLocalization{
	name 		= "General Rajaxx"
}
L:SetWarningLocalization{
	WarnWave	= "Oleada %s",
	WarnBoss	= "Sale Boss"
}
L:SetOptionLocalization{
	WarnWave	= "Mostrar aviso para oleada siguiente"
}
L:SetMiscLocalization{
	Wave1		= "They come now. Try not to get yourself killed, young blood.", --translate
	Wave3		= "The time of our retribution is at hand! Let darkness reign in the hearts of our enemies!", --translate
	Wave4		= "No longer will we wait behind barred doors and walls of stone! No longer will our vengeance be denied! The dragons themselves will tremble before our wrath!", --translate
	Wave5		= "Fear is for the enemy! Fear and death!", --translate
	Wave6		= "Staghelm will whimper and beg for his life, just as his whelp of a son did! One thousand years of injustice will end this day!", --translate
	Wave7		= "Fandral! Your time has come! Go and hide in the Emerald Dream and pray we never find you!", --translate
	Wave8		= "Impudent fool! I will kill you myself!" --translate
}

----------
-- Moam --
----------
L = DBM:GetModLocalization("Moam")

L:SetGeneralLocalization{
	name 		= "Moam"
}

----------
-- Buru --
----------
L = DBM:GetModLocalization("Buru")

L:SetGeneralLocalization{
	name 		= "Buru el Manducador"
}
L:SetWarningLocalization{
	WarnPursue		= "Persigue a >%s<",
	SpecWarnPursue	= "Te persigue a ti"
}
L:SetOptionLocalization{
	WarnPursue		= "Anunciar los objetivos perseguidos",
	SpecWarnPursue	= "Mostrar aviso especial cuando te persigan"
}
L:SetMiscLocalization{
	PursueEmote 	= "%s fija su mirada en %s!"
}

-------------
-- Ayamiss --
-------------
L = DBM:GetModLocalization("Ayamiss")

L:SetGeneralLocalization{
	name 		= "Ayamiss el Cazador"
}

--------------
-- Ossirian --
--------------
L = DBM:GetModLocalization("Ossirian")

L:SetGeneralLocalization{
	name 		= "Osirio el Sinmarcas"
}
L:SetWarningLocalization{
	WarnVulnerable	= "%s"
}
L:SetTimerLocalization{
	TimerVulnerable	= "%s"
}
L:SetOptionLocalization{
	WarnVulnerable	= "Anunciar Debilidad",
	TimerVulnerable	= "Mostrar tiempo para Debilidad"
}