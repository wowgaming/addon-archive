if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-----------------
--  Razorgore  --
-----------------
L = DBM:GetModLocalization("Razorgore")

L:SetGeneralLocalization{
	name = "Sangrevaja el Indomable"
}
L:SetTimerLocalization{
	TimerAddsSpawn	= "Salen adds"
}
L:SetOptionLocalization{
	TimerAddsSpawn	= "Mostrar tiempo para que salgan los primeros adds"
}

-------------------
--  Vaelastrasz  --
-------------------
L = DBM:GetModLocalization("Vaelastrasz")

L:SetGeneralLocalization{
	name = "Vaelastrasz el Corrupto"
}

-----------------
--  Broodlord  --
-----------------
L = DBM:GetModLocalization("Broodlord")

L:SetGeneralLocalization{
	name = "Señor de linaje Capazote"
}

---------------
--  Firemaw  --
---------------
L = DBM:GetModLocalization("Firemaw")

L:SetGeneralLocalization{
	name = "Faucefogo"
}

---------------
--  Ebonroc  --
---------------
L = DBM:GetModLocalization("Ebonroc")

L:SetGeneralLocalization{
	name = "Ebanorroca"
}

----------------
--  Flamegor  --
----------------
L = DBM:GetModLocalization("Flamegor")

L:SetGeneralLocalization{
	name = "Flamagor"
}

------------------
--  Chromaggus  --
------------------
L = DBM:GetModLocalization("Chromaggus")

L:SetGeneralLocalization{
	name = "Chromaggus"
}
L:SetWarningLocalization{
	WarnBreathSoon	= "Aliento pronto",
	WarnBreath		= "%s",
	WarnPhase2Soon	= "Fase 2 pronto"
}
L:SetTimerLocalization{
	TimerBreathCD	= "%s CD"
}
L:SetOptionLocalization{
	WarnBreathSoon	= "Mostrar pre-aviso para los Alientos",
	WarnBreath		= "Mostrar aviso cuando castea Aliento",
	TimerBreathCD	= "Mostrar tiempo para siguiente Aliento",
	WarnPhase2Soon	= "Mostrar pre-aviso para la fase 2"
}

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian")

L:SetGeneralLocalization{
	name = "Nefarian"
}
L:SetWarningLocalization{
	WarnClassCallSoon	= "Debuff de clase pronto",
	WarnClassCall		= "Debuff de %s",
	WarnPhaseSoon		= "Fase %s pronto",
	WarnPhase			= "Fase %s"
}
L:SetTimerLocalization{
	TimerClassCall		= "%s Debuff de clase"
}
L:SetOptionLocalization{
	TimerClassCall		= "Mostrar duración de debuff de clase",
	WarnClassCallSoon	= "Mostrar pre-aviso para debuff de clase",
	WarnClassCall		= "Mostrar aviso para debuff de clase",
	WarnPhaseSoon		= "Mostrar pre-aviso para cambio de fase",
	WarnPhase			= "Mostrar aviso al cambiar de fase"
}
L:SetMiscLocalization{
	YellPull	= "Let the games begin!",--translate
	YellP2		= "Well done, my minions. The mortals' courage begins to wane! Now, let's see how they contend with the true Lord of Blackrock Spire!!!",--translate
	YellP3		= "Impossible! Rise my minions!  Serve your master once more!",--translate
	YellShaman	= "Shamans, show me",--translate
	YellPaladin	= "Paladins... I've heard you have many lives. Show me.",--translate
	YellDruid	= "Druids and your silly shapeshifting. Lets see it in action!",--translate
	YellPriest	= "Priests! If you're going to keep healing like that, we might as well make it a little more interesting!",--translate
	YellWarrior	= "Warriors, I know you can hit harder than that! Lets see it!",--translate
	YellRogue	= "Rogues? Stop hiding and face me!",--translate
	YellWarlock	= "Warlocks, you shouldn't be playing with magic you don't understand. See what happens?",--translate
	YellHunter	= "Hunters and your annoying pea-shooters!",--translate
	YellMage	= "Mages too? You should be more careful when you play with magic...",--translate
	YellDK		= ""--translate
}