local L

-----------------
--  Razorgore  --
-----------------
L = DBM:GetModLocalization("Razorgore")

L:SetGeneralLocalization{
	name = "Razorgore the Untamed"
}
L:SetTimerLocalization{
	TimerAddsSpawn	= "Adds spawning"
}
L:SetOptionLocalization{
	TimerAddsSpawn	= "Show timer for first adds spawning"
}
L:SetMiscLocalization{
	YellPull = "Intruders have breached the hatchery! Sound the alarm! Protect the eggs at all costs!"--This yell actually has a return in it, so message match WILL fail. not sure if pulls can use msg find or not?
}
-------------------
--  Vaelastrasz  --
-------------------
L = DBM:GetModLocalization("Vaelastrasz")

L:SetGeneralLocalization{
	name = "Vaelastrasz the Corrupt"
}

-----------------
--  Broodlord  --
-----------------
L = DBM:GetModLocalization("Broodlord")

L:SetGeneralLocalization{
	name = "Broodlord Lashlayer"
}

---------------
--  Firemaw  --
---------------
L = DBM:GetModLocalization("Firemaw")

L:SetGeneralLocalization{
	name = "Firemaw"
}

---------------
--  Ebonroc  --
---------------
L = DBM:GetModLocalization("Ebonroc")

L:SetGeneralLocalization{
	name = "Ebonroc"
}

----------------
--  Flamegor  --
----------------
L = DBM:GetModLocalization("Flamegor")

L:SetGeneralLocalization{
	name = "Flamegor"
}

------------------
--  Chromaggus  --
------------------
L = DBM:GetModLocalization("Chromaggus")

L:SetGeneralLocalization{
	name = "Chromaggus"
}
L:SetWarningLocalization{
	WarnBreathSoon	= "Breath soon",
	WarnBreath		= "%s",
	WarnPhase2Soon	= "Phase 2 soon"
}
L:SetTimerLocalization{
	TimerBreathCD	= "%s CD"
}
L:SetOptionLocalization{
	WarnBreathSoon	= "Show pre-warning for Chromaggus' Breaths",
	WarnBreath		= "Show warning when Chromaggus casts one of his Breaths",
	TimerBreathCD	= "Show Breath CD",
	WarnPhase2Soon	= "Announce when phase 2 is about to start"
}

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian")

L:SetGeneralLocalization{
	name = "Nefarian"
}
L:SetWarningLocalization{
	WarnClassCallSoon	= "Class call soon",
	WarnClassCall		= "%s call",
	WarnPhaseSoon		= "Phase %s soon",
	WarnPhase			= "Phase %s"
}
L:SetTimerLocalization{
	TimerClassCall		= "%s call"
}
L:SetOptionLocalization{
	TimerClassCall		= "Show timer for class call duration",
	WarnClassCallSoon	= "Pre-warn class calls",
	WarnClassCall		= "Announce class calls",
	WarnPhaseSoon		= "Announce when a new phase is about to start",
	WarnPhase			= "Announce phase change"
}
L:SetMiscLocalization{
	YellPull	= "Let the games begin!",
	YellP2		= "Well done, my minions. The mortals' courage begins to wane! Now, let's see how they contend with the true Lord of Blackrock Spire!!!",
	YellP3		= "Impossible! Rise my minions!  Serve your master once more!",
	YellShaman	= "Shamans, show me",
	YellPaladin	= "Paladins... I've heard you have many lives. Show me.",
	YellDruid	= "Druids and your silly shapeshifting. Lets see it in action!",
	YellPriest	= "Priests! If you're going to keep healing like that, we might as well make it a little more interesting!",
	YellWarrior	= "Warriors, I know you can hit harder than that! Lets see it!",
	YellRogue	= "Rogues? Stop hiding and face me!",
	YellWarlock	= "Warlocks, you shouldn't be playing with magic you don't understand. See what happens?",
	YellHunter	= "Hunters and your annoying pea-shooters!",
	YellMage	= "Mages too? You should be more careful when you play with magic..."
}