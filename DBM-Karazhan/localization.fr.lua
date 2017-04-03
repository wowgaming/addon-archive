if GetLocale() ~= "frFR" then return end

local L

--Attumen
L = DBM:GetModLocalization("Attumen")

L:SetGeneralLocalization{
	name = "Attumen le Veneur"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_ATH_YELL_1		= "Viens, Minuit, allons disperser cette insignifiante racaille !",
	KillAttumen			= "Always knew... someday I would become... the hunted."
}


--Moroes
L = DBM:GetModLocalization("Moroes")

L:SetGeneralLocalization{
	name = "Moroes"
}

L:SetWarningLocalization{
	DBM_MOROES_VANISH_FADED	= "Retour de Moroes"
}

L:SetOptionLocalization{
	DBM_MOROES_VANISH_FADED	= "Show vanish fade warning"
}

L:SetMiscLocalization{
	DBM_MOROES_YELL_START	= "Hum. Des visiteurs imprévus. Il va falloir se préparer."
}


-- Maiden of Virtue
L = DBM:GetModLocalization("Maiden")

L:SetGeneralLocalization{
	name = "Damoiselle de vertu"
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
	name = "Romulo et Julianne"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_RJ_PHASE2_YELL	= "Viens, gentille nuit ; rends-moi mon Romulo !",
	Romulo				= "Romulo",
	Julianne			= "Julianne"
}


-- Big Bad Wolf
L = DBM:GetModLocalization("BigBadWolf")

L:SetGeneralLocalization{
	name = "Le grand méchant Loup"
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
	name = "Le conservateur"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	RangeFrame			= "Show range frame (10)"
}

L:SetMiscLocalization{
	DBM_CURA_YELL_PULL		= "L'accès à la Ménagerie est réservé aux invités.",
	DBM_CURA_YELL_OOM		= "Impossible de traiter votre requête."
}


-- Terestian Illhoof
L = DBM:GetModLocalization("TerestianIllhoof")

L:SetGeneralLocalization{
	name = "Terestian Malsabot"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_TI_YELL_PULL		= "Ah, vous arrivez juste \195\160 temps. Les rituels vont commencer.",
	Kilrek					= "Kil'rek",
	DChains					= "Demon Chains"
}


-- Shade of Aran
L = DBM:GetModLocalization("Aran")

L:SetGeneralLocalization{
	name = "Ombre d'Aran"
}

L:SetWarningLocalization{
	DBM_ARAN_DO_NOT_MOVE	= "Ne bougez plus!"
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
	name = "Netherspite"
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
	DBM_NS_EMOTE_PHASE_2	= "%s entre dans une rage nourrie par le N\195\169ant\194\160!",
	DBM_NS_EMOTE_PHASE_1	= "%s se retire avec un cri en ouvrant un portail vers le N\195\169ant."
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
	DBM_PRINCE_YELL_PULL	= "La folie vous a fait venir ici, devant moi. Et je serai votre perte !",
	DBM_PRINCE_YELL_P2		= "Imb\195\169ciles heureux ! Le temps est le brasier dans lequel vous br\195\187lerez !",
	DBM_PRINCE_YELL_P3		= "Comment pouvez-vous esp\195\169rer r\195\169sister devant un tel pouvoir ?",
	DBM_PRINCE_YELL_INF1	= "Toutes les r\195\169alit\195\169s, toutes les dimensions me sont ouvertes !",
	DBM_PRINCE_YELL_INF2	= "Vous n'affrontez pas seulement Malchezzar, mais les l\195\169gions que je commande !"
}


-- Nightbane
L = DBM:GetModLocalization("Nightbane")

L:SetGeneralLocalization{
	name = "Plaie-de-nuit"
}

L:SetWarningLocalization{
	DBM_NB_DOWN_WARN 		= "Ground Phase in 15 sec",
	DBM_NB_DOWN_WARN2 		= "Ground Phase in 5 sec",
	DBM_NB_AIR_WARN			= "Air Phase"
}

L:SetTimerLocalization{
	timerNightbane			= "Nightbane incoming",
	timerAirPhase			= "Air Phase"
}

L:SetOptionLocalization{
	DBM_NB_AIR_WARN			= "Show warning for Air Phase",
	PrewarnGroundPhase		= "Show pre-warnings for Ground Phase",
	timerNightbane			= "Show timer for Nightbane summon",
	timerAirPhase			= "Show timer for Air Phase duration"
}

L:SetMiscLocalization{
	DBM_NB_EMOTE_PULL		= "Dans le lointain, un \195\170tre ancien s'\195\169veille...",
	DBM_NB_YELL_PULL		= "Fous ! Je vais mettre un terme \195\160 vos souffrances !",
	DBM_NB_YELL_AIR			= "Mis\195\169rable vermine. Je vais vous exterminer des airs !",
	DBM_NB_YELL_GROUND		= "Assez ! Je vais atterir et vous !",
	DBM_NB_YELL_GROUND2		= "Insectes ! Je vais vous montrer de quel bois je me chauffe !"
}


-- Wizard of Oz
L = DBM:GetModLocalization("Oz")

L:SetGeneralLocalization{
	name = "Le magicien d'Oz"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	AnnounceBosses			= "Show warnings for boss spawns",
	ShowBossTimers			= "Show timers for boss spawns",
	DBM_OZ_OPTION_1			= "Show range check frame in phase 2"
}

L:SetMiscLocalization{
	DBM_OZ_WARN_TITO		= "Tito",
	DBM_OZ_WARN_ROAR		= "Graou",
	DBM_OZ_WARN_STRAWMAN	= "Homme de paille",
	DBM_OZ_WARN_TINHEAD		= "Tête de fer-blanc",
	DBM_OZ_WARN_CRONE		= "La Mégère",
	DBM_OZ_YELL_DOROTHEE	= "Oh, Tito, nous devons trouver le moyen de rentrer à la maison ! Le vieux sorcier est notre dernier espoir ! Homme de paille, Graou, Tête de fer-blanc, vous voulez bien… Attendez… Oh, regardez, nous avons des visiteurs !",
	DBM_OZ_YELL_ROAR		= "J'ai peur d'personne ! Tu veux t'battre ! Hein, tu veux ? Vas-y ! Je te prends avec les deux pattes attachées dans l'dos !",
	DBM_OZ_YELL_STRAWMAN	= "Alors que vais-je faire de vous ? Je n'arrive tout simplement pas à me décider.",
	DBM_OZ_YELL_TINHEAD		= "J'aurais bien besoin d'un cœur. Dites, vous me donnez le vôtre ?",
	DBM_OZ_YELL_CRONE		= "Malheur à chacun d’entre vous, mes mignons !"
}


-- Named Beasts
L = DBM:GetModLocalization("Shadikith")

L:SetGeneralLocalization{
	name = "Shadikith le Glisseur"
}

L = DBM:GetModLocalization("Hyakiss")

L:SetGeneralLocalization{
	name = "Hyakiss la R\195\180deuse"
}

L = DBM:GetModLocalization("Rokad")

L:SetGeneralLocalization{
	name = "Rokad le Ravageur"
}
