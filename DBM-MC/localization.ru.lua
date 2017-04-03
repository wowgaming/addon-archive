if GetLocale() ~= "ruRU" then return end

local L

----------------
--  Lucifron  --
----------------
L = DBM:GetModLocalization("Lucifron")

L:SetGeneralLocalization{
	name = "Люцифрон"
}

----------------
--  Magmadar  --
----------------
L = DBM:GetModLocalization("Magmadar")

L:SetGeneralLocalization{
	name = "Магмадар"
}

----------------
--  Gehennas  --
----------------
L = DBM:GetModLocalization("Gehennas")

L:SetGeneralLocalization{
	name = "Гееннас"
}

------------
--  Garr  --
------------
L = DBM:GetModLocalization("Garr")

L:SetGeneralLocalization{
	name = "Гарр"
}

--------------
--  Geddon  --
--------------
L = DBM:GetModLocalization("Geddon")

L:SetGeneralLocalization{
	name = "Барон Геддон"
}

L:SetOptionLocalization{
	SetIconOnBombTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(20475)
}

----------------
--  Shazzrah  --
----------------
L = DBM:GetModLocalization("Shazzrah")

L:SetGeneralLocalization{
	name = "Шаззрах"
}

----------------
--  Sulfuron  --
----------------
L = DBM:GetModLocalization("Sulfuron")

L:SetGeneralLocalization{
	name = "Предвестник Сульфурон"
}

----------------
--  Golemagg  --
----------------
L = DBM:GetModLocalization("Golemagg")

L:SetGeneralLocalization{
	name = "Големагг Испепелитель"
}
L:SetWarningLocalization{
	WarnP2Soon	= "Скоро 2-ая фаза"
}
L:SetOptionLocalization{
	WarnP2Soon 	= "Предупреждать о скором начале второй фазы"
}

-----------------
--  Majordomo  --
-----------------
L = DBM:GetModLocalization("Majordomo")

L:SetGeneralLocalization{
	name = "Мажордом Экзекутус"
}

L:SetMiscLocalization{
	Kill	= "Impossible! Stay your attack, mortals... I submit! I submit!"
}

----------------
--  Ragnaros  --
----------------
L = DBM:GetModLocalization("Ragnaros")

L:SetGeneralLocalization{
	name = "Рагнарос"
}
L:SetWarningLocalization{
	WarnSubmerge		= "Погружение",
	WarnSubmergeSoon	= "Скоро погружение",
	WarnEmerge			= "Появление",
	WarnEmergeSoon		= "Скоро появление"
}
L:SetTimerLocalization{
	TimerCombatStart	= "Начало боя",
	TimerSubmerge		= "Погружение",
	TimerEmerge			= "Появление"
}
L:SetOptionLocalization{
	TimerCombatStart	= "Показывать время до начала боя",
	WarnSubmerge		= "Показывать предупреждение о погружении",
	WarnSubmergeSoon	= "Показывать предварительное предупреждение о погружении",
	TimerSubmerge		= "Показывать время до погружения",
	WarnEmerge			= "Показывать предупреждение о появлении",
	WarnEmergeSoon		= "Показывать предварительное предупреждение о появлении",
	TimerEmerge			= "Показывать время до появления"
}
L:SetMiscLocalization{
	Submerge	= "COME FORTH, MY SERVANTS! DEFEND YOUR MASTER!",
	Pull		= "Impudent whelps! You've rushed headlong to your own deaths! See now, the master stirs!\r\n"
}