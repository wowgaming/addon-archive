-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

-- Thanks 星塵、Player Lin for translations

if (GetLocale() == "zhTW") then
XPerl_ProductName	= "|cFFD00000X-Perl|r 單位框架"
XPerl_Description	= XPerl_ProductName.." 作者 "..XPerl_Author

XPerl_LongDescription	= "全新外觀的玩家狀態框架模組，包括玩家、寵物、隊伍、專注(focus)、團隊、目標以及目標的目標等。"

XPERL_MINIMAP_HELP1	= "|c00FFFFFF左鍵點擊|r 開啟設定視窗 (以及 |c0000FF00解鎖框架|r)"
XPERL_MINIMAP_HELP2	= "|c00FFFFFF右鍵拖動|r 移動此圖標"
XPERL_MINIMAP_HELP3	= "\r團隊成員: |c00FFFF80%d|r\r隊伍成員: |c00FFFF80%d|r"
XPERL_MINIMAP_HELP4	= "\r你是此 隊伍/團隊 隊長"
XPERL_MINIMAP_HELP5	= "|c00FFFFFFAlt|r 顯示 X-Perl 記憶體用量"
XPERL_MINIMAP_HELP6	= "|c00FFFFFF+Shift|r 顯示 X-Perl 記憶體使用明細"

XPERL_MINIMENU_OPTIONS	= "功能設定"
XPERL_MINIMENU_ASSIST	= "顯示協助框架"
XPERL_MINIMENU_CASTMON	= "顯示施法監視"
XPERL_MINIMENU_RAIDAD	= "顯示團隊幫手"
XPERL_MINIMENU_ITEMCHK	= "顯示物品確認"
XPERL_MINIMENU_RAIDBUFF = "團隊 Buffs"
XPERL_MINIMENU_ROSTERTEXT="名單文字"
XPERL_MINIMENU_RAIDSORT = "團隊排序"
XPERL_MINIMENU_RAIDSORT_GROUP = "依據隊伍排序"
XPERL_MINIMENU_RAIDSORT_CLASS = "依據職業排序"

XPERL_TYPE_NOT_SPECIFIED = "未指定"
XPERL_TYPE_PET		= PET			-- "Pet"
XPERL_TYPE_BOSS		= "首領"
XPERL_TYPE_RAREPLUS	= "稀有精英+"
XPERL_TYPE_ELITE	= "精英"
XPERL_TYPE_RARE		= "稀有"

-- Zones
XPERL_LOC_ZONE_SERPENTSHRINE_CAVERN = "毒蛇神殿洞穴"
XPERL_LOC_ZONE_BLACK_TEMPLE = "黑暗神廟"
XPERL_LOC_ZONE_HYJAL_SUMMIT = "海加爾山"
XPERL_LOC_ZONE_KARAZHAN = "卡拉贊"
XPERL_LOC_ZONE_SUNWELL_PLATEAU = "太陽之井高地"
XPERL_LOC_ZONE_NAXXRAMAS = "納克薩瑪斯"
XPERL_LOC_ZONE_OBSIDIAN_SANCTUM = "黑曜聖所"
XPERL_LOC_ZONE_EYE_OF_ETERNITY = "永恆之眼"
XPERL_LOC_ZONE_ULDUAR = "奧杜亞"
XPERL_LOC_ZONE_TRIAL_OF_THE_CRUSADER = "十字軍試煉"
XPERL_LOC_ZONE_ICECROWN_CITADEL = "冰冠城塞"
XPERL_LOC_ZONE_RUBY_SANCTUM = "晶紅聖所"

-- Status
XPERL_LOC_DEAD		= DEAD			-- "Dead"
XPERL_LOC_GHOST		= "靈魂"
XPERL_LOC_FEIGNDEATH	= "假死"
XPERL_LOC_OFFLINE	= PLAYER_OFFLINE	-- "Offline"
XPERL_LOC_RESURRECTED	= "復活"
XPERL_LOC_SS_AVAILABLE	= "靈魂保存"
XPERL_LOC_UPDATING	= "更新中"
XPERL_LOC_ACCEPTEDRES	= "已接受"		-- Res accepted
XPERL_RAID_GROUP	= "小隊 %d"
XPERL_RAID_GROUPSHORT	= "%d隊"

XPERL_LOC_NONEWATCHED	= "無監看"

XPERL_LOC_STATUSTIP	= "狀態提示："		-- Tooltip explanation of status highlight on unit
XPERL_LOC_STATUSTIPLIST = {
	HOT = "持續治療",
	AGGRO = "敵方目標",
	MISSING = "你職業的 buff 被遺漏",
	HEAL = "已受治療",
	SHIELD = "已上盾"
}

XPERL_OK		= "確定"
XPERL_CANCEL		= "取消"

XPERL_LOC_LARGENUMDIV	= 10000
XPERL_LOC_LARGENUMTAG	= "萬"
XPERL_LOC_HUGENUMDIV	= 100000000
XPERL_LOC_HUGENUMTAG	= "億"

BINDING_HEADER_XPERL = "X-Perl 快捷鍵設定"
BINDING_NAME_TOGGLERAID = "開/關團隊視窗"
BINDING_NAME_TOGGLERAIDSORT = "切換團隊排序方式為 職業/隊伍"
BINDING_NAME_TOGGLERAIDPETS = "切換是否使用團隊寵物"
BINDING_NAME_TOGGLEOPTIONS = "開/關設定視窗"
BINDING_NAME_TOGGLEBUFFTYPE = "切換 增益/減益/無"
BINDING_NAME_TOGGLEBUFFCASTABLE = "切換顯示可施加/解除的增益/減益魔法"
BINDING_NAME_TEAMSPEAKMONITOR = "顯示 Teamspeak 監看圖標"
BINDING_NAME_TOGGLERANGEFINDER = "切換距離偵測開啟/關閉"

XPERL_KEY_NOTICE_RAID_BUFFANY = "顯示所有 增益/減益魔法"
XPERL_KEY_NOTICE_RAID_BUFFCURECAST = "只有 可施加/可解除 的增益/減益魔法顯示"
XPERL_KEY_NOTICE_RAID_BUFFS = "顯示團隊的 增益魔法"
XPERL_KEY_NOTICE_RAID_DEBUFFS = "顯示團隊的 減益魔法"
XPERL_KEY_NOTICE_RAID_NOBUFFS = "不顯示團隊的 增益魔法"

XPERL_DRAGHINT1		= "|c00FFFFFF點擊|r 調整視窗比例"
XPERL_DRAGHINT2		= "|c00FFFFFFShift+點擊|r 重置視窗尺寸"

-- Usage
XPerlUsageNameList	= {XPerl = "核心", XPerl_Player = "玩家", XPerl_PlayerPet = "寵物", XPerl_Target = "目標", XPerl_TargetTarget = "目標的目標", XPerl_Party = "隊友", XPerl_PartyPet = "隊友寵物", XPerl_RaidFrames = "團隊框架", XPerl_RaidHelper = "團隊助手", XPerl_RaidAdmin = "團隊紀錄", XPerl_TeamSpeak = "TS 監視", XPerl_RaidMonitor = "團隊監視", XPerl_RaidPets = "團隊寵物", XPerl_ArcaneBar = "施法條", XPerl_PlayerBuffs = "玩家 Buffs"}
XPERL_USAGE_MEMMAX	= "UI 記憶體用量: %d"
XPERL_USAGE_MODULES	= "模組: "
XPERL_USAGE_NEWVERSION	= "*新版本"
XPERL_USAGE_AVAILABLE	= "已有新版本 %s |c00FFFFFF%s|r 可以下載使用"

XPERL_CMD_HELP		= "|c00FFFF80使用: |c00FFFFFF/xperl menu | lock | unlock | config list | config delete <realm> <name>"
XPERL_CANNOT_DELETE_CURRENT	= "無法刪除您的個人設定"
XPERL_CONFIG_DELETED		= "刪除 %s/%s 的個人設定"
XPERL_CANNOT_FIND_DELETE_TARGET	= "找不到 (%s/%s) 設定來刪除"
XPERL_CANNOT_DELETE_BADARGS	= "請給予正確的伺服器名稱以及玩家名稱"
XPERL_CONFIG_LIST		= "設定清單："
XPERL_CONFIG_CURRENT		= " (目前)"

XPERL_RAID_TOOLTIP_WITHBUFF	= "有此 buff 的：(%s)"
XPERL_RAID_TOOLTIP_WITHOUTBUFF	= "沒有此 buff 的：(%s)"
XPERL_RAID_TOOLTIP_BUFFEXPIRING	= "%s 的 %s 將要在 %s 後消失。"	-- Name, buff name, time to expire

XPerl_DefaultRangeSpells.ANY = {item = "厚霜紋繃帶"}

end