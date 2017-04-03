if GetLocale() ~= "ruRU" then return end

local L

-----------------
--  Razorgore  --
-----------------
L = DBM:GetModLocalization("Razorgore")

L:SetGeneralLocalization{
	name = "Бритвосмерт Неукротимый"
}
L:SetTimerLocalization{
	TimerAddsSpawn	= "Появление аддов"
}
L:SetOptionLocalization{
	TimerAddsSpawn	= "Показывать таймер до первого появления аддов"
}

-------------------
--  Vaelastrasz  --
-------------------
L = DBM:GetModLocalization("Vaelastrasz")

L:SetGeneralLocalization{
	name = "Валестраз Порочный"
}

-----------------
--  Broodlord  --
-----------------
L = DBM:GetModLocalization("Broodlord")

L:SetGeneralLocalization{
	name = "Предводитель драконов Разящий Бич"
}

---------------
--  Firemaw  --
---------------
L = DBM:GetModLocalization("Firemaw")

L:SetGeneralLocalization{
	name = "Огнечрев"
}

---------------
--  Ebonroc  --
---------------
L = DBM:GetModLocalization("Ebonroc")

L:SetGeneralLocalization{
	name = "Черноскал"
}

----------------
--  Flamegor  --
----------------
L = DBM:GetModLocalization("Flamegor")

L:SetGeneralLocalization{
	name = "Пламегор"
}

------------------
--  Chromaggus  --
------------------
L = DBM:GetModLocalization("Chromaggus")

L:SetGeneralLocalization{
	name = "Хромаггус"
}
L:SetWarningLocalization{
	WarnBreathSoon	= "Скоро дыхание",
	WarnBreath		= "%s",
	WarnPhase2Soon	= "Скоро 2-ая фаза"
}
L:SetTimerLocalization{
	TimerBreathCD	= "%s восстановление"
}
L:SetOptionLocalization{
	WarnBreathSoon	= "Предварительное предупреждение Дыхания Хромаггуса",
	WarnBreath		= "Показывать предупреждение о дыханиях Хромаггуса",
	TimerBreathCD	= "Показывать время восстановления дыханий",
	WarnPhase2Soon	= "Предупреждать о второй фазе"
}

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian")

L:SetGeneralLocalization{
	name = "Нефариан"
}
L:SetWarningLocalization{
	WarnClassCallSoon	= "Скоро вызов класса",
	WarnClassCall		= "Дебафф на %s",
	WarnPhaseSoon		= "Скоро фаза %s",
	WarnPhase			= "Фаза %s"
}
L:SetTimerLocalization{
	TimerClassCall		= "%s зов"
}
L:SetOptionLocalization{
	TimerClassCall		= "Показывать таймер классовых вызовов",
	WarnClassCallSoon	= "Предупреждение классовых вызовов",
	WarnClassCall		= "Объявлять классовый вызов",
	WarnPhaseSoon		= "Объявлять, когда следующая фаза скоро начнется",
	WarnPhase			= "Объявлять смену фаз"
}
L:SetMiscLocalization{
	YellPull	= "Ну что ж, поиграем!",
	YellP2		= "Браво, слуги мои! Смертные утрачивают мужество! Поглядим же, как они справятся с истинным Повелителем Черной горы!!!",
	YellP3		= "Не может быть! Восстаньте, мои прислужники! Послужите господину еще раз!",
	YellShaman	= "Шаманы, покажите, на что способны ваши тотемы!",
	YellPaladin	= "Паладины… Я слышал, у вас несколько жизней. Докажите.",
	YellDruid	= "Друиды и их дурацкие превращения… Ну что ж, поглядим!",
	YellPriest	= "Жрецы! Если вы собираетесь продолжать так лечить, то давайте хоть немного разнообразим процесс!",
	YellWarrior	= "Воины! Я знаю, вы можете бить сильнее! Ну-ка, покажите!",
	YellRogue	= "Rogues? Stop hiding and face me!",
	YellWarlock	= "Чернокнижники, ну не беритесь вы за волшебство, которого сами не понимаете! Видите, что получилось?",
	YellHunter	= "Охотники со своими жалкими пугачами!",
	YellMage	= "И маги тоже? Осторожнее надо быть, когда играешь с магией…"
}