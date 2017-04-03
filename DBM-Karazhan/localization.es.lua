if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

--Attumen
L = DBM:GetModLocalization("Attumen")

L:SetGeneralLocalization{
	name = "Attumen el Montero"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_ATH_YELL_1		= "Come Midnight, let's disperse this petty rabble!",
	KillAttumen			= "Always knew... someday I would become... the hunted."
}


--Moroes
L = DBM:GetModLocalization("Moroes")

L:SetGeneralLocalization{
	name = "Moroes"
}

L:SetWarningLocalization{
	DBM_MOROES_VANISH_FADED	= "Vanish faded"
}

L:SetOptionLocalization{
	DBM_MOROES_VANISH_FADED	= "Show vanish fade warning"
}

L:SetMiscLocalization{
	DBM_MOROES_YELL_START	= "Hm, unannounced visitors. Preparations must be made..."
}


-- Maiden of Virtue
L = DBM:GetModLocalization("Maiden")

L:SetGeneralLocalization{
	name = "Doncella de la Virtud"
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
	name = "Romulo y Julianne"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_RJ_PHASE2_YELL	= "¡Ven, dulce noche; y devuélveme a mi Romulo!",
	Romulo				= "Romulo",
	Julianne			= "Julianne"
}


-- Big Bad Wolf
L = DBM:GetModLocalization("BigBadWolf")

L:SetGeneralLocalization{
	name = "El Lobo Feroz"
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
	name = "The Curator"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	RangeFrame			= "Show range frame (10)"
}

L:SetMiscLocalization{
	DBM_CURA_YELL_PULL		= "La Galeria es solo para los invitados.",
	DBM_CURA_YELL_OOM		= "No se puede procesar tu solicitud."
}


-- Terestian Illhoof
L = DBM:GetModLocalization("TerestianIllhoof")

L:SetGeneralLocalization{
	name = "Terestian Pezuña Enferma"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_TI_YELL_PULL		= "Ah, you're just in time. The rituals are about to begin!",
	Kilrek					= "Kil'rek",
	DChains					= "Demon Chains"
}


-- Shade of Aran
L = DBM:GetModLocalization("Aran")

L:SetGeneralLocalization{
	name = "Sombra de Aran"
}

L:SetWarningLocalization{
	DBM_ARAN_DO_NOT_MOVE	= "¡No te muevas!"
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
	name = "Rencor abisal"
}

L:SetWarningLocalization{
	DBM_NS_WARN_PORTAL_SOON	= "Fase de portales en 5 seg",
	DBM_NS_WARN_BANISH_SOON	= "Fase Desterraren 5 seg",
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
	DBM_NS_EMOTE_PHASE_2	= "%s goes into a nether-fed rage!",
	DBM_NS_EMOTE_PHASE_1	= "%s cries out in withdrawal, opening gates to the nether."
}


--Prince Malchezaar
L = DBM:GetModLocalization("Prince")

L:SetGeneralLocalization{
	name = "Príncipe Malchezaar"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_PRINCE_YELL_PULL	= "Madness has brought you here to me. I shall be your undoing!",
	DBM_PRINCE_YELL_P2		= "Simple fools! Time is the fire in which you'll burn!",
	DBM_PRINCE_YELL_P3		= "How can you hope to stand against such overwhelming power?",
	DBM_PRINCE_YELL_INF1	= "All realities, all dimensions are open to me!",
	DBM_PRINCE_YELL_INF2	= "You face not Malchezaar alone, but the legions I command!"
}


-- Nightbane
L = DBM:GetModLocalization("Nightbane")

L:SetGeneralLocalization{
	name = "Nocturno"
}

L:SetWarningLocalization{
	DBM_NB_DOWN_WARN 		= "Aterriza en 15 seg",
	DBM_NB_DOWN_WARN2 		= "Aterriza en 5 seg",
	DBM_NB_AIR_WARN			= "Fase aerea"
}

L:SetTimerLocalization{
	timerNightbane			= "Nightbane incoming",
	timerAirPhase			= "Fase aerea"
}

L:SetOptionLocalization{
	DBM_NB_AIR_WARN			= "Show warning for Air Phase",
	PrewarnGroundPhase		= "Show pre-warnings for Ground Phase",
	timerNightbane			= "Show timer for Nightbane summon",
	timerAirPhase			= "Show timer for Air Phase duration"
}

L:SetMiscLocalization{
	DBM_NB_EMOTE_PULL		= "An ancient being awakens in the distance...",
	DBM_NB_YELL_PULL		= "What fools! I shall bring a quick end to your suffering!",
	DBM_NB_YELL_AIR			= "Miserable vermin. I shall exterminate you from the air!",
	DBM_NB_YELL_GROUND		= "Enough! I shall land and crush you myself!",
	DBM_NB_YELL_GROUND2		= "Insects! Let me show you my strength up close!"
}


-- Wizard of Oz
L = DBM:GetModLocalization("Oz")

L:SetGeneralLocalization{
	name = "Mago de Oz"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	AnnounceBosses			= "Show warnings for boss spawns",
	ShowBossTimers			= "Show timers for boss spawns",
	DBM_OZ_OPTION_1			= "SMostrar distancia en fase 2"
}

L:SetMiscLocalization{
	DBM_OZ_WARN_TITO		= "Tito",
	DBM_OZ_WARN_ROAR		= "Roar",
	DBM_OZ_WARN_STRAWMAN	= "Strawman",
	DBM_OZ_WARN_TINHEAD		= "Tinhead",
	DBM_OZ_WARN_CRONE		= "The Crone",
	DBM_OZ_YELL_DOROTHEE	= "Oh Tito, we simply must find a way home! The old wizard could be our only hope! Strawman, Roar, Tinhead, will you - wait... oh golly, look we have visitors!",
	DBM_OZ_YELL_ROAR		= "I'm not afraid a' you! Do you wanna' fight? Huh, do ya'? C'mon! I'll fight ya' with both paws behind my back!",
	DBM_OZ_YELL_STRAWMAN	= "Now what should I do with you? I simply can't make up my mind.",
	DBM_OZ_YELL_TINHEAD		= "I could really use a heart. Say, can I have yours?",
	DBM_OZ_YELL_CRONE		= "Woe to each and every one of you, my pretties!"
}


-- Named Beasts
L = DBM:GetModLocalization("Shadikith")

L:SetGeneralLocalization{
	name = "Shadikith el Planeador"
}

L = DBM:GetModLocalization("Hyakiss")

L:SetGeneralLocalization{
	name = "Hyakiss el Rondador"
}

L = DBM:GetModLocalization("Rokad")

L:SetGeneralLocalization{
	name = "Rokad el Devastador"
}
