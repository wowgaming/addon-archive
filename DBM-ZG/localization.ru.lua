if GetLocale() ~= "ruRU" then return end

local L

-------------------
--  Venoxis  --
-------------------
L = DBM:GetModLocalization("Venoxis")

L:SetGeneralLocalization{
	name = "Верховный жрец Веноксис"
}
L:SetWarningLocalization{
	warnPhase2Soon	= "Скоро 2-ая фаза"
}
L:SetOptionLocalization{
	warnPhase2Soon	= "Объявлять о скором начале 2-ой фазы",
	RangeFrame		= "Показывать окно дистанции"
}

-------------------
--  Jeklik  --
-------------------
L = DBM:GetModLocalization("Jeklik")

L:SetGeneralLocalization{
	name = "Верховная жрица Джеклик"
}

-------------------
--  Marli  --
-------------------
L = DBM:GetModLocalization("Marli")

L:SetGeneralLocalization{
	name = "Верховная жрица Мар'ли"
}

-------------------
--  Thekal  --
-------------------
L = DBM:GetModLocalization("Thekal")

L:SetGeneralLocalization{
	name = "Верховный жрец Текал"
}

L:SetWarningLocalization({
	WarnSimulKill	= "Первый адд пал - воскрешение через ~12 сек."
})

L:SetTimerLocalization({
	TimerSimulKill	= "Воскрешение"
})

L:SetOptionLocalization({
	WarnSimulKill	= "Объявлять о смерти первого адда",
	TimerSimulKill	= "Показывать время до воскрешения жреца"
})

L:SetMiscLocalization({
	PriestDied	= "%s dies.",
	YellPhase2	= "Shirvallah, fill me with your RAGE!",
	YellKill	= "Hakkar binds me no more!  Peace at last!"
})

-------------------
--  Arlokk  --
-------------------
L = DBM:GetModLocalization("Arlokk")

L:SetGeneralLocalization{
	name = "Верховная жрица Арлокк"
}

-------------------
--  Hakkar  --
-------------------
L = DBM:GetModLocalization("Hakkar")

L:SetGeneralLocalization{
	name = "Хаккар"
}

-------------------
--  Bloodlord  --
-------------------
L = DBM:GetModLocalization("Bloodlord")

L:SetGeneralLocalization{
	name = "Мандокир Повелитель Крови"
}
L:SetMiscLocalization{
	Bloodlord 	= "Мандокир Повелитель Крови",
	Ohgan		= "Охган"
}

-------------------
--  Edge of Madness  --
-------------------
L = DBM:GetModLocalization("EdgeOfMadness")

L:SetGeneralLocalization{
	name = "Edge of Madness"
}
L:SetMiscLocalization{
	Hazzarah = "Хазза'рах",
	Renataki = "Ренатаки",
	Wushoolay = "Вушулай",
	Grilek = "Гри'лек"
}

-------------------
--  Gahz'ranka  --
-------------------
L = DBM:GetModLocalization("Gahzranka")

L:SetGeneralLocalization{
	name = "Газ'ранка"
}

-------------------
--  Jindo  --
-------------------
L = DBM:GetModLocalization("Jindo")

L:SetGeneralLocalization{
	name = "Мастер проклятий Джин'до"
}