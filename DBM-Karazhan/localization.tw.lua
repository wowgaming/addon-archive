if GetLocale() ~= "zhTW" then return end

local L

--Attumen
L = DBM:GetModLocalization("Attumen")

L:SetGeneralLocalization{
	name = "獵人阿圖曼"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_ATH_YELL_1		= "來吧午夜，讓我們驅散這群小規模的烏合之眾!",
	KillAttumen			= "Always knew... someday I would become... the hunted."
}


--Moroes
L = DBM:GetModLocalization("Moroes")

L:SetGeneralLocalization{
	name = "摩洛"
}

L:SetWarningLocalization{
	DBM_MOROES_VANISH_FADED	= "摩洛失去消失"
}

L:SetOptionLocalization{
	DBM_MOROES_VANISH_FADED	= "Show vanish fade warning"
}

L:SetMiscLocalization{
	DBM_MOROES_YELL_START	= "嗯，突然上門的訪客。一定要好好準備"
}


-- Maiden of Virtue
L = DBM:GetModLocalization("Maiden")

L:SetGeneralLocalization{
	name = "貞潔聖女"
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
	name = "羅慕歐與茱麗葉"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_RJ_PHASE2_YELL	= "來吧，溫和的夜晚；把我的羅慕歐還給我!",
	Romulo				= "羅慕歐",
	Julianne			= "茱麗葉"
}


-- Big Bad Wolf
L = DBM:GetModLocalization("BigBadWolf")

L:SetGeneralLocalization{
	name = "大野狼"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	RRHIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(30753)
}

L:SetMiscLocalization{
	DBM_BBW_YELL_1			= "我想把你吃掉!"
}


-- Curator
L = DBM:GetModLocalization("Curator")

L:SetGeneralLocalization{
	name = "館長"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	RangeFrame			= "Show range frame (10)"
}

L:SetMiscLocalization{
	DBM_CURA_YELL_PULL		= "展示廳是賓客專屬的。",
	DBM_CURA_YELL_OOM		= "無法處理你的要求。"
}


-- Terestian Illhoof
L = DBM:GetModLocalization("TerestianIllhoof")

L:SetGeneralLocalization{
	name = "泰瑞斯提安·疫蹄"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_TI_YELL_PULL		= "啊，你來的正好。儀式正要開始!",
	Kilrek					= "Kil'rek",
	DChains					= "Demon Chains"
}


-- Shade of Aran
L = DBM:GetModLocalization("Aran")

L:SetGeneralLocalization{
	name = "埃蘭之影"
}

L:SetWarningLocalization{
	DBM_ARAN_DO_NOT_MOVE	= "烈焰火圈，不要動！"
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
	name = "尼德斯"
}

L:SetWarningLocalization{
	DBM_NS_WARN_PORTAL_SOON	= "5秒後進入第一階段",
	DBM_NS_WARN_BANISH_SOON	= "5秒後進入第二階段",
	warningPortal			= "光線門階段",
	warningBanish			= "放逐階段"
}

L:SetTimerLocalization{
	timerPortalPhase	= "光線門階段",
	timerBanishPhase	= "放逐階段"
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
	DBM_NS_EMOTE_PHASE_2 	= "%s陷入一陣狂怒!",
	DBM_NS_EMOTE_PHASE_1 	= "%s大聲呼喊撤退，打開通往虛空的門。"
}


--Prince Malchezaar
L = DBM:GetModLocalization("Prince")

L:SetGeneralLocalization{
	name = "莫克札王子"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_PRINCE_YELL_PULL	= "瘋狂把你帶到我的面前。我會成為你失敗的原因!",
	DBM_PRINCE_YELL_P2		= "頭腦簡單的笨蛋!你在燃燒的是時間的火焰!",
	DBM_PRINCE_YELL_P3		= "你怎能期望抵抗這樣勢不可擋的力量?",
	DBM_PRINCE_YELL_INF1	= "所有的實體，所有的空間對我來說都是開放的!",
	DBM_PRINCE_YELL_INF2	= "你挑戰的不只是莫克札，而是我所率領的整個軍隊!"
}


-- Nightbane
L = DBM:GetModLocalization("Nightbane")

L:SetGeneralLocalization{
	name = "夜禍"
}

L:SetWarningLocalization{
	DBM_NB_DOWN_WARN 		= "15秒後夜禍回到地面",
	DBM_NB_DOWN_WARN2 		= "5秒後夜禍回到地面",
	DBM_NB_AIR_WARN			= "空中階段"
}

L:SetTimerLocalization{
	timerNightbane			= "夜禍",
	timerAirPhase			= "空中階段"
}

L:SetOptionLocalization{
	DBM_NB_AIR_WARN			= "Show warning for Air Phase",
	PrewarnGroundPhase		= "Show pre-warnings for Ground Phase",
	timerNightbane			= "Show timer for Nightbane summon",
	timerAirPhase			= "Show timer for Air Phase duration"
}

L:SetMiscLocalization{
	DBM_NB_EMOTE_PULL 		= "一個古老的生物在遠處甦醒過來……",
	DBM_NB_YELL_PULL 		= "真是蠢蛋!我會快點結束你的痛苦!",
	DBM_NB_YELL_AIR 		= "悲慘的害蟲。我將讓你消失在空氣中!",
	DBM_NB_YELL_GROUND 		= "夠了!我要親自挑戰你!",
	DBM_NB_YELL_GROUND2 	= "昆蟲!給你們近距離嚐嚐我的厲害!"
}


-- Wizard of Oz
L = DBM:GetModLocalization("Oz")

L:SetGeneralLocalization{
	name = "綠野仙蹤"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	AnnounceBosses			= "Show warnings for boss spawns",
	ShowBossTimers			= "Show timers for boss spawns",
	DBM_OZ_OPTION_1			= "在第二階段顯示距離框"
}

L:SetMiscLocalization{
	DBM_OZ_WARN_TITO		= "多多",
	DBM_OZ_WARN_ROAR		= "獅子",
	DBM_OZ_WARN_STRAWMAN	= "稻草人",
	DBM_OZ_WARN_TINHEAD		= "機器人",
	DBM_OZ_WARN_CRONE		= "老巫婆",
	DBM_OZ_YELL_DOROTHEE	= "喔多多，我們一定要找到回家的路!那個老巫師是我們唯一的希望!稻草人，獅子，機器人，你會 - 等等哦……天呀，快看，我們有訪客!",
	DBM_OZ_YELL_ROAR		= "我不是害怕你!你想要戰鬥嗎?啊，你是嗎?來! 我將把兩支爪子放在背後跟你戰鬥!",
	DBM_OZ_YELL_STRAWMAN	= "現在我該與你做什麼?我完全不能決定。",
	DBM_OZ_YELL_TINHEAD		= "我真得能使用心。嗯，我能有你的心嗎?",
	DBM_OZ_YELL_CRONE		= "為你們每一個人感到不幸，我的小美人們!"
}


-- Named Beasts
L = DBM:GetModLocalization("Shadikith")

L:SetGeneralLocalization{
	name = "滑翔者‧薛迪依斯"
}

L = DBM:GetModLocalization("Hyakiss")

L:SetGeneralLocalization{
	name = "潛伏者‧亞奇斯"
}

L = DBM:GetModLocalization("Rokad")

L:SetGeneralLocalization{
	name = "劫掠者‧拉卡"
}
