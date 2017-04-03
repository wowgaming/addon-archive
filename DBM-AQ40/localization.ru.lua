if GetLocale() ~= "ruRU" then return end

local L

------------
-- Skeram --
------------
L = DBM:GetModLocalization("Skeram")

L:SetGeneralLocalization{
	name = "Пророк Скерам"
}

L:SetOptionLocalization{
	SetIconOnMC		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(785)
}

----------------
-- Three Bugs --
----------------
L = DBM:GetModLocalization("ThreeBugs")

L:SetGeneralLocalization{
	name = "Семейство жуков"
}
L:SetMiscLocalization{
	Yauj = "Принцесса Яудж",
	Vem = "Вем",
	Kri = "Лорд Кри"
}

-------------
-- Sartura --
-------------
L = DBM:GetModLocalization("Sartura")

L:SetGeneralLocalization{
	name = "Боевой страж Сартура"
}

--------------
-- Fankriss --
--------------
L = DBM:GetModLocalization("Fankriss")

L:SetGeneralLocalization{
	name = "Фанкрисс Непреклонный"
}
L:SetWarningLocalization{
	WarnWound	= "%s на >%s< (%s)"
}
L:SetOptionLocalization{
	WarnWound = DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(25646, GetSpellInfo(25646) or "unknown")
}
--------------
-- Viscidus --
--------------
L = DBM:GetModLocalization("Viscidus")

L:SetGeneralLocalization{
	name = "Нечистотон"
}
L:SetWarningLocalization{
	WarnFreeze	= "Заморожен: %d/3",
	WarnShatter	= "Shatter: %d/3"
}
L:SetOptionLocalization{
	WarnFreeze	= "Announce Freeze status",
	WarnShatter	= "Announce Shatter status",
}
L:SetMiscLocalization{
	Phase4 	= "Нечистотон начинает раскалываться!",
	Phase5 	= "Нечистотон едва держится!",
	Phase6 	= "Explodes."
}
-------------
-- Huhuran --
-------------
L = DBM:GetModLocalization("Huhuran")

L:SetGeneralLocalization{
	name = "Принцесса Хухуран"
}
L:SetWarningLocalization{
	WarnAcid	= "%s на >%s< (%s)"
}
L:SetOptionLocalization{
	WarnAcid	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(26180, GetSpellInfo(26180) or "unknown")
	}
---------------
-- Twin Emps --
---------------
L = DBM:GetModLocalization("TwinEmpsAQ")

L:SetGeneralLocalization{
	name = "Императоры-близнецы"
}
L:SetMiscLocalization{
	Veklor = "Император Век'лор",
	Veknil = "Император Век'нилаш"
}

------------
-- C'Thun --
------------
L = DBM:GetModLocalization("CThun")

L:SetGeneralLocalization{
	name = "К'Тун"
}
L:SetWarningLocalization{
	WarnEyeTentacle 	= "Появляются глазные отростки!",
	WarnClawTentacle	= "Появляется когтещупальце!",
	WarnGiantEyeTentacle	= "Появляется гигантский глазной отросток!",
	WarnGiantClawTentacle	= "Появляется гигантское когтещупальце!",
	WarnWeakened 		= "К'Тун ослаблен! Бейте его!"
}
L:SetTimerLocalization{
	TimerEyeTentacle	= "Глазных отроски",
	TimerGiantEyeTentacle	= "Гигантский глазной отросток",
	TimerClawTentacle	= "Когтещупальце",
	TimerGiantClawTentacle	= "Гигантское когтещупальце",
	TimerWeakened		= "К'Тун ослаблен"
}
L:SetOptionLocalization{
	RangeFrame	= "Показывать окно дистанции"
}
----------------
-- Ouro --
----------------
L = DBM:GetModLocalization("Ouro")

L:SetGeneralLocalization{
	name = "Оуро"
}
L:SetWarningLocalization{
	WarnSubmerge		= "Закапывание",
	WarnEmerge			= "Появление",
	WarnSubmergeSoon	= "Скоро закапывание",
	WarnEmergeSoon		= "Скоро появление"
}
L:SetTimerLocalization{
	TimerSubmerge		= "Закапывание",
	TimerEmerge			= "Появление"
}
L:SetOptionLocalization{
	WarnSubmerge		= "Показывать предупреждение о закапывании",
	WarnSubmergeSoon	= "Предупреждать заранее о закапывании",
	TimerSubmerge		= "Показывать таймер до закапывания",
	WarnEmerge			= "Показывать предупреждение о появлении",
	WarnEmergeSoon		= "Предупреждать заранее о появлении",
	TimerEmerge			= "Показывать таймер до появления"
}