if GetLocale() ~= "deDE" then return end

local L

--Attumen
L = DBM:GetModLocalization("Attumen")

L:SetGeneralLocalization{
	name = "Attumen der Jäger"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_ATH_YELL_1		= "Komm Mittnacht, lass' uns dieses Gesindel auseinander treiben!",
--	KillAttumen			= "Always knew... someday I would become... the hunted."
}


--Moroes
L = DBM:GetModLocalization("Moroes")

L:SetGeneralLocalization{
	name = "Moroes"
}

L:SetWarningLocalization{
	DBM_MOROES_VANISH_FADED	= "Moroes ist wieder da"
}

L:SetOptionLocalization{
	DBM_MOROES_VANISH_FADED	= "Show vanish fade warning"
}

L:SetMiscLocalization{
	DBM_MOROES_YELL_START	= "Hm, unangekündigte Besucher. Es müssen Vorbereitungen getroffen werden"
}


-- Maiden of Virtue
L = DBM:GetModLocalization("Maiden")

L:SetGeneralLocalization{
	name = "Tugendhafte Maid"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	RangeFrame			= "Show range frame (10)"
}

L:SetMiscLocalization{
}


-- Romulo and Julianne
L = DBM:GetModLocalization("RomuloAndJulianne")

L:SetGeneralLocalization{
	name = "Romulo and Julianne"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_RJ_PHASE2_YELL	= "Komm, milde, liebevolle Nacht! Komm, gibt mir meinen Romulo zurück!",
	Romulo				= "Romulo",
	Julianne			= "Julianne"
}


-- Big Bad Wolf
L = DBM:GetModLocalization("BigBadWolf")

L:SetGeneralLocalization{
	name = "Der große böse Wolf"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	RRHIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(30753)
}

L:SetMiscLocalization{
	DBM_BBW_YELL_1			= "The better to own you with!"
}


-- Curator
L = DBM:GetModLocalization("Curator")

L:SetGeneralLocalization{
	name = "Der Kurator"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	RangeFrame			= "Show range frame (10)"
}

L:SetMiscLocalization{
	DBM_CURA_YELL_PULL		= "Die Menagerie ist nur für Gäste.",
	DBM_CURA_YELL_OOM		= "Ihre Anfrage kann nicht bearbeitet werden."
}


-- Terestian Illhoof
L = DBM:GetModLocalization("TerestianIllhoof")

L:SetGeneralLocalization{
	name = "Terestian Siechhuf"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_TI_YELL_PULL		= "Ah, Ihr kommt genau richtig. Die Rituale fangen gleich an!",
	Kilrek					= "Kil'rek",
	DChains					= "Demon Chains"
}


-- Shade of Aran
L = DBM:GetModLocalization("Aran")

L:SetGeneralLocalization{
	name = "Arans Schemen"
}

L:SetWarningLocalization{
	DBM_ARAN_DO_NOT_MOVE	= "Nicht bewegen!"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	DBM_ARAN_DO_NOT_MOVE	= "Show special warning for $spell:30004"
}

L:SetMiscLocalization{
}


--Netherspite
L = DBM:GetModLocalization("Netherspite")

L:SetGeneralLocalization{
	name = "Nethergroll"
}

L:SetWarningLocalization{
	DBM_NS_WARN_PORTAL_SOON	= "Portal Phase in 5",
	DBM_NS_WARN_BANISH_SOON	= "Banish Phase in 5",
	warningPortal			= "Portal Phase",
	warningBanish			= "Banish Phase"
}

L:SetTimerLocalization{
	timerPortalPhase	= "Portal Phase",
	timerBanishPhase	= "Banish Phase"
}

L:SetOptionLocalization{
	DBM_NS_WARN_PORTAL_SOON	= "Show pre-warning for Portal phase",
	DBM_NS_WARN_BANISH_SOON	= "Show pre-warning for Banish phase",
	warningPortal			= "Show warning for Portal phase",
	warningBanish			= "Show warning for Banish phase",
	timerPortalPhase		= "Show timer for Portal Phase duration",
	timerBanishPhase		= "Show timer for Banish Phase duration"
}

L:SetMiscLocalization{
	DBM_NS_EMOTE_PHASE_2	= "Netherenergien versetzen %s in rasende Wut!",
	DBM_NS_EMOTE_PHASE_1	= "%s schreit auf und öffnet Tore zum Nether."
}


--Prince Malchezaar
L = DBM:GetModLocalization("Prince")

L:SetGeneralLocalization{
	name = "Prince Malchezaar"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_PRINCE_YELL_PULL	= "Der Wahnsinn führte Euch zu mir. Ich werde Euch das Genick brechen!",
	DBM_PRINCE_YELL_P2		= "Dummköpfe! Zeit ist das Feuer, in dem Ihr brennen werdet!",
	DBM_PRINCE_YELL_P3		= "Wie könnt Ihr hoffen, einer so überwältigenden Macht gewachsen zu sein?",
	DBM_PRINCE_YELL_INF1	= "Alle Realitäten, alle Dimensionen stehen mir offen!",
	DBM_PRINCE_YELL_INF2	= "Ihr steht nicht nur vor Malchezzar allein, sondern vor den Legionen, die ich befehlige!"
}


-- Nightbane
L = DBM:GetModLocalization("Nightbane")

L:SetGeneralLocalization{
	name = "Schrecken der Nacht"
}

L:SetWarningLocalization{
	DBM_NB_DOWN_WARN 		= "Ground Phase in 15 sec",
	DBM_NB_DOWN_WARN2 		= "Ground Phase in 5 sec",
	DBM_NB_AIR_WARN			= "Luft Phase"
}

L:SetTimerLocalization{
	timerNightbane			= "Schrecken der Nacht",
	timerAirPhase			= "Luft Phase"
}

L:SetOptionLocalization{
	DBM_NB_AIR_WARN			= "Show warning for Luft Phase",
	PrewarnGroundPhase		= "Show pre-warnings for Ground Phase",
	timerNightbane			= "Show timer for Nightbane summon",
	timerAirPhase			= "Show timer for Air Phase duration"
}

L:SetMiscLocalization{
	DBM_NB_EMOTE_PULL		= "Etwas Uraltes erwacht in der Ferne...",
	DBM_NB_YELL_PULL		= "Narren! Ich werde Eurem Leiden ein schnelles Ende setzen!",
	DBM_NB_YELL_AIR			= "Abscheuliches Gewürm! Ich werde euch aus der Luft vernichten!",
	DBM_NB_YELL_GROUND		= "Genug! Ich werde landen und mich höchst persönlich um Euch kümmern!",
	DBM_NB_YELL_GROUND2		= "Insekten! Lasst mich Euch meine Kraft aus nächster Nähe demonstrieren!"
}


-- Wizard of Oz
L = DBM:GetModLocalization("Oz")

L:SetGeneralLocalization{
	name = "Zauberer von Oz"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	AnnounceBosses			= "Show warnings for boss spawns",
	ShowBossTimers			= "Show timers for boss spawns",
	DBM_OZ_OPTION_1			= "Reichweiten Check in Phase 2 anzeigen"
}

L:SetMiscLocalization{
	DBM_OZ_WARN_TITO		= "Tito",
	DBM_OZ_WARN_ROAR		= "Brüller",
	DBM_OZ_WARN_STRAWMAN	= "Strohmann",
	DBM_OZ_WARN_TINHEAD		= "Blechkopf",
	DBM_OZ_WARN_CRONE		= "The Crone",
	DBM_OZ_YELL_DOROTHEE	= "Oh Tito, wir müssen einfach einen Weg nach Hause finden! Der alte Zauberer ist unsere einzige Hoffnung! Strohmann, Brüller, Blechkopf, wollt ihr - wartet… Donnerwetter, schaut! Wir haben Besucher!",
	DBM_OZ_YELL_ROAR		= "Ich habe keine Angst vor Euch! Wollt Ihr kämpfen? Hä, wollt Ihr? Kommt schon! Ich schaffe Euch mit beiden Pfoten hinter dem Rücken!",
	DBM_OZ_YELL_STRAWMAN	= "Was soll ich nur mit Euch machen? Mit fällt einfach nichts ein.",
	DBM_OZ_YELL_TINHEAD		= "Ich könnte wirklich ein Herz brauchen. Kann ich Eures haben?",
	DBM_OZ_YELL_CRONE		= "Wehe Euch allen, meine Hübschen!"
}


-- Named Beasts
L = DBM:GetModLocalization("Shadikith")

L:SetGeneralLocalization{
	name = "Shadikith the Glider"
}

L = DBM:GetModLocalization("Hyakiss")

L:SetGeneralLocalization{
	name = "Hyakiss the Lurker"
}

L = DBM:GetModLocalization("Rokad")

L:SetGeneralLocalization{
	name = "Rokad the Ravager"
}
