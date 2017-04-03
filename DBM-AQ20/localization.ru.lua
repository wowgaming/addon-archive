if GetLocale() ~= "ruRU" then return end

local L

---------------
-- Kurinnaxx --
---------------
L = DBM:GetModLocalization("Kurinnaxx")

L:SetGeneralLocalization{
	name 		= "Куриннакс"
}
L:SetWarningLocalization{
	WarnWound	= "%s на >%s< (%s)"
}
L:SetOptionLocalization{
	WarnWound	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(25646, GetSpellInfo(25646) or "unknown"),	
}
------------
-- Rajaxx --
------------
L = DBM:GetModLocalization("Rajaxx")

L:SetGeneralLocalization{
	name 		= "Генерал Раджакс"
}
L:SetWarningLocalization{
	WarnWave	= "Волна %s",
	WarnBoss	= "Появление босса"
}
L:SetOptionLocalization{
	WarnWave	= "Показывать предупреждение о следующей волне"
}
L:SetMiscLocalization{
	Wave1		= "They come now. Try not to get yourself killed, young blood.",
	Wave3		= "The time of our retribution is at hand! Let darkness reign in the hearts of our enemies!",
	Wave4		= "No longer will we wait behind barred doors and walls of stone! No longer will our vengeance be denied! The dragons themselves will tremble before our wrath!",
	Wave5		= "Fear is for the enemy! Fear and death!",
	Wave6		= "Staghelm will whimper and beg for his life, just as his whelp of a son did! One thousand years of injustice will end this day!",
	Wave7		= "Fandral! Your time has come! Go and hide in the Emerald Dream and pray we never find you!",
	Wave8		= "Impudent fool! I will kill you myself!"
}

----------
-- Moam --
----------
L = DBM:GetModLocalization("Moam")

L:SetGeneralLocalization{
	name 		= "Моам"
}

----------
-- Buru --
----------
L = DBM:GetModLocalization("Buru")

L:SetGeneralLocalization{
	name 		= "Буру Ненасытный"
}
L:SetWarningLocalization{
	WarnPursue		= "Преследует >%s<",
	SpecWarnPursue	= "Преследует вас!"
}
L:SetOptionLocalization{
	WarnPursue		= "Называть преследуемые цели",
	SpecWarnPursue	= "Показывать специальное предупреждение, когда преследование на вас"
}
L:SetMiscLocalization{
	PursueEmote 	= "%s sets eyes on %s!"
}

-------------
-- Ayamiss --
-------------
L = DBM:GetModLocalization("Ayamiss")

L:SetGeneralLocalization{
	name 		= "Аямисса Охотница"
}

--------------
-- Ossirian --
--------------
L = DBM:GetModLocalization("Ossirian")

L:SetGeneralLocalization{
	name 		= "Оссириан Неуязвимый"
}
L:SetWarningLocalization{
	WarnVulnerable	= "%s"
}
L:SetTimerLocalization{
	TimerVulnerable	= "%s"
}
L:SetOptionLocalization{
	WarnVulnerable	= "Объявлять слабость",
	TimerVulnerable	= "Показывать таймер до слабости"
}