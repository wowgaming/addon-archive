if GetLocale() ~= "zhCN" then return end

local L

--Attumen
L = DBM:GetModLocalization("Attumen")

L:SetGeneralLocalization{
	name = "猎手阿图门"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_ATH_YELL_1		= "来吧，午夜，让我们解决这群乌合之众！",
--	KillAttumen			= "Always knew... someday I would become... the hunted."
}


--Moroes
L = DBM:GetModLocalization("Moroes")

L:SetGeneralLocalization{
	name = "莫罗斯"
}

L:SetWarningLocalization{
	DBM_MOROES_VANISH_FADED	= "消失 - 效果消失"
}

L:SetOptionLocalization{
	DBM_MOROES_VANISH_FADED	= "Show vanish fade warning"
}

L:SetMiscLocalization{
	DBM_MOROES_YELL_START	= "啊，不速之客。我得准备一下……"
}


-- Maiden of Virtue
L = DBM:GetModLocalization("Maiden")

L:SetGeneralLocalization{
	name = "贞节圣女"
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
	name = "罗密欧与朱丽叶"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_RJ_PHASE2_YELL	= "来吧，可爱的黑颜的夜，把我的罗密欧给我！",
	Romulo				= "Romulo",
	Julianne			= "Julianne"
}


-- Big Bad Wolf
L = DBM:GetModLocalization("BigBadWolf")

L:SetGeneralLocalization{
	name = "大灰狼"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	RRHIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(30753)
}

L:SetMiscLocalization{
	DBM_BBW_YELL_1			= "可以一口把你吃掉呀！"
}


-- Curator
L = DBM:GetModLocalization("Curator")

L:SetGeneralLocalization{
	name = "馆长"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	RangeFrame			= "Show range frame (10)"
}

L:SetMiscLocalization{
	DBM_CURA_YELL_PULL		= "展览厅只对访客开放。",
	DBM_CURA_YELL_OOM		= "你的请求未能得到批准。"
}


-- Terestian Illhoof
L = DBM:GetModLocalization("TerestianIllhoof")

L:SetGeneralLocalization{
	name = "特雷斯坦·邪蹄"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_TI_YELL_PULL		= "啊，你们来的正是时候。仪式就要开始了！",
	Kilrek					= "Kil'rek",
	DChains					= "Demon Chains"
}


-- Shade of Aran
L = DBM:GetModLocalization("Aran")

L:SetGeneralLocalization{
	name = "埃兰之影"
}

L:SetWarningLocalization{
	DBM_ARAN_DO_NOT_MOVE	= "不要移动！"
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
	name = "虚空幽龙"
}

L:SetWarningLocalization{
	DBM_NS_WARN_PORTAL_SOON	= "5秒后进入虚空门阶段",
	DBM_NS_WARN_BANISH_SOON	= "5秒后进入放逐阶段",
	warningPortal			= "虚空门阶段",
	warningBanish			= "放逐阶段"
}

L:SetTimerLocalization{
	timerPortalPhase	= "虚空门阶段",
	timerBanishPhase	= "放逐阶段"
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
	DBM_NS_EMOTE_PHASE_2	= "%s的怒火甚至可以充满整个虚空！",
	DBM_NS_EMOTE_PHASE_1	= "%s在撤退中大声呼喊着，打开了回到虚空的传送门。"
}


--Prince Malchezaar
L = DBM:GetModLocalization("Prince")

L:SetGeneralLocalization{
	name = "玛克扎尔王子"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	DBM_PRINCE_YELL_PULL	= "疯狂将你们带到我的面前，而我将以死亡终结你们！",
	DBM_PRINCE_YELL_P2		= "愚蠢的家伙！时间就是吞噬你躯体的烈焰！",
	DBM_PRINCE_YELL_P3		= "你如何抵挡这无坚不摧的力量？",
	DBM_PRINCE_YELL_INF1	= "所有的世界都向我敞开大门！",
	DBM_PRINCE_YELL_INF2	= "你面对的不仅仅是玛克扎尔，还有我所号令的军团！"
}


-- Nightbane
L = DBM:GetModLocalization("Nightbane")

L:SetGeneralLocalization{
	name = "夜之魇"
}

L:SetWarningLocalization{
	DBM_NB_DOWN_WARN 		= "15秒后夜之魇着陆",
	DBM_NB_DOWN_WARN2 		= "5秒后夜之魇着陆",
	DBM_NB_AIR_WARN			= "空中阶段"
}

L:SetTimerLocalization{
	timerNightbane			= "夜之魇",
	timerAirPhase			= "空中阶段"
}

L:SetOptionLocalization{
	DBM_NB_AIR_WARN			= "Show warning for Air Phase",
	PrewarnGroundPhase		= "Show pre-warnings for Ground Phase",
	timerNightbane			= "Show timer for Nightbane summon",
	timerAirPhase			= "Show timer for Air Phase duration"
}

L:SetMiscLocalization{
	DBM_NB_EMOTE_PULL	= "一个远古的生物在远处被唤醒了……",
	DBM_NB_YELL_PULL	= "愚蠢的家伙！我会很快终结你们的痛苦！",
	DBM_NB_YELL_AIR		= "可怜的渣滓。我要腾空而起，让你尝尝毁灭的滋味！",
	DBM_NB_YELL_GROUND	= "够了！我要落下来把你们打得粉碎！",
	DBM_NB_YELL_GROUND2	= "没用的虫子！让你们见识一下我的力量吧！"
}


-- Wizard of Oz
L = DBM:GetModLocalization("Oz")

L:SetGeneralLocalization{
	name = "绿野仙踪"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	AnnounceBosses			= "Show warnings for boss spawns",
	ShowBossTimers			= "Show timers for boss spawns",
	DBM_OZ_OPTION_1			= "在第2阶段显示距离框体"
}

L:SetMiscLocalization{
	DBM_OZ_WARN_TITO		= "托托",
	DBM_OZ_WARN_ROAR		= "胆小的狮子",
	DBM_OZ_WARN_STRAWMAN	= "稻草人",
	DBM_OZ_WARN_TINHEAD		= "铁皮人",
	DBM_OZ_WARN_CRONE		= "巫婆",
	DBM_OZ_YELL_DOROTHEE	= "啊，托托，我们必须找到回家的路！那位老巫师是我们唯一的希望了！稻草人、狮子，还有铁皮人，你们能不能——呀，有人来了！",
	DBM_OZ_YELL_ROAR		= "我不怕你们！你们想打架？那就来呀！来呀！我不用前爪都可以打败你们！",
	DBM_OZ_YELL_STRAWMAN	= "我该把你怎么办？我完全不知道。",
	DBM_OZ_YELL_TINHEAD		= "我真的需要一颗心。啊，用你的行吗？",
	DBM_OZ_YELL_CRONE		= "我为你们感到可悲，小家伙们！"
}


-- Named Beasts
L = DBM:GetModLocalization("Shadikith")

L:SetGeneralLocalization{
	name = "滑翔者沙德基斯"
}

L = DBM:GetModLocalization("Hyakiss")

L:SetGeneralLocalization{
	name = "潜伏者希亚其斯"
}

L = DBM:GetModLocalization("Rokad")

L:SetGeneralLocalization{
	name = "蹂躏者洛卡德"
}
