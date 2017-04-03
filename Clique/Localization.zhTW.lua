-------------------------------------------------------------------------------
-- Localization                                                              --
-- Simple Chinese Translated by 昏睡墨魚&Costa<CWDG>                         --
-------------------------------------------------------------------------------

local L = Clique.Locals

if GetLocale() == "zhTW" then
	L.RANK                    = "等級"
	L.RANK_PATTERN            = "等級 (%d+)"
	L.CAST_FORMAT             = "%s(等級 %s)"

	L.RACIAL_PASSIVE          = "種族被動技能"
	L.PASSIVE                 = SPELL_PASSIVE
	
	L.CLICKSET_DEFAULT        = "默認"
	L.CLICKSET_HARMFUL        = "對敵方動作"
	L.CLICKSET_HELPFUL        = "對友方動作"
	L.CLICKSET_OOC            = "非戰鬥中動作"
	L.CLICKSET_BEARFORM       = "熊形態"
	L.CLICKSET_CATFORM        = "獵豹形態"
    L.CLICKSET_AQUATICFORM    = "水棲形態"
	L.CLICKSET_TRAVELFORM     = "旅行形態"
	L.CLICKSET_MOONKINFORM    = "梟獸形態"
	L.CLICKSET_TREEOFLIFE     = "樹形"
	L.CLICKSET_SHADOWFORM     = "暗影形態"
	L.CLICKSET_STEALTHED      = "潛行狀態"
	L.CLICKSET_BATTLESTANCE   = "戰鬥姿態"
	L.CLICKSET_DEFENSIVESTANCE = "防禦姿態"
	L.CLICKSET_BERSERKERSTANCE = "狂暴姿態"

	L.BEAR_FORM = "熊形態"
	L.DIRE_BEAR_FORM = "巨熊形態"
	L.CAT_FORM = "獵豹形態"
	L.AQUATIC_FORM = "水棲形態"
	L.TRAVEL_FORM = "旅行形態"
	L.TREEOFLIFE = "樹形"
	L.MOONKIN_FORM = "梟獸形態"
	L.STEALTH = "潛行狀態"
	L.SHADOWFORM = "暗影形態"
	L.BATTLESTANCE = "戰鬥姿態"
	L.DEFENSIVESTANCE = "防禦姿態"
	L.BERSERKERSTANCE = "狂暴姿態"

	L.BINDING_NOT_DEFINED     = "未定義綁定"
	L.CANNOT_CHANGE_COMBAT    = "戰鬥狀態中無法改變. 這些改變被推遲到脫離戰鬥狀態後."
	L.APPLY_QUEUE             = "脫離戰鬥狀態.  進行所有預定了的改變."
	L.PROFILE_CHANGED         = "已經切換到設置 '%s'."
	L.PROFILE_DELETED         = "你的設置 '%s' 已經被刪除."
	L.PROFILE_RESET         = "你的設置 '%s' 已經被重值."

	L.ACTION_ACTIONBAR = "切換動作條"
	L.ACTION_ACTION = "動作按鈕"
	L.ACTION_PET = "寵物動作按鈕"
	L.ACTION_SPELL = "釋放法術"
	L.ACTION_ITEM = "使用物品"
	L.ACTION_MACRO = "運行自定義宏"
	L.ACTION_STOP = "終止施法"
	L.ACTION_TARGET = "目標單位"
	L.ACTION_FOCUS = "指定目標單位"
	L.ACTION_ASSIST = "協助某單位"
	L.ACTION_CLICK = "點擊按鈕"
	L.ACTION_MENU = "顯示功能表"

	L.HELP_TEXT               = "歡迎使用Clique.  最基本的操作，你可以流覽法術書然後給喜歡的法術綁定按鍵.例如，你可以找到\快速治療\ 然後按住shift點左鍵，這樣shift+左鍵就被設置為釋放快速治療了."
	L.CUSTOM_HELP             = "這是Clique自定義視窗.在這裏，你可以設置任何點擊影射到介面允許的組合按鍵. 從左側選擇一個基本的動作，然後可以可以點擊下邊的按鈕來映射到任何你希望的操作. "
	
	L.BS_ACTIONBAR_HELP = "切換動作條.  'increment' 會向後翻一頁, 'decrement' 則相反. 如果你提供了一個編號, 動作條就會翻到那一頁.你可以定義1,3來在1和3頁之間翻動."
	L.BS_ACTIONBAR_ARG1_LABEL = "動作條:"

	L.BS_ACTION_HELP = "將一種點擊影射到某動作條的按鈕上. 請指定動作條的編號."
	L.BS_ACTION_ARG1_LABEL = "按鈕編號:"
	L.BS_ACTION_ARG2_LABEL = "(可選) 單位:"

	L.BS_PET_HELP = "將一種點擊影射到寵物動作條的按鈕上.  請指定按鈕編號."
	L.BS_PET_ARG1_LABEL = "寵物按鈕編號:"
	L.BS_PET_ARG2_LABEL = "(可選) 單位:"

	L.BS_SPELL_HELP = "從法術書上選擇施法. 設定法術名稱, 以及包裹與物品槽編號或者物品名稱(可選), 來對目標進行施法 (例如餵養寵物)"
	L.BS_SPELL_ARG1_LABEL = "法術名稱:"
	L.BS_SPELL_ARG2_LABEL = "*包裹編號:"
	L.BS_SPELL_ARG3_LABEL = "*物品槽編號:"
	L.BS_SPELL_ARG4_LABEL = "*物品名稱:"
	L.BS_SPELL_ARG5_LABEL = "(可選) 單位:"

	L.BS_ITEM_HELP = "使用一個物品. 可以通過包裹與物品槽的編號，或者物品名稱來指定."
	L.BS_ITEM_ARG1_LABEL = "包裹編號:"
	L.BS_ITEM_ARG2_LABEL = "物品槽編號:"
	L.BS_ITEM_ARG3_LABEL = "物品名稱:"
	L.BS_ITEM_ARG4_LABEL = "(可選) 單位:"

	L.BS_MACRO_HELP = "使用給定索引的自定義巨集"
	L.BS_MACRO_ARG1_LABEL = "巨集索引:"
	L.BS_MACRO_ARG2_LABEL = "巨集內容:"

	L.BS_STOP_HELP = "中斷當前施法"
	
	L.BS_TARGET_HELP = "將單位設定為目標"
	L.BS_TARGET_ARG1_LABEL = "(可選) 單位:"

	L.BS_FOCUS_HELP = "設定你的 \"目標\" 單位"
	L.BS_FOCUS_ARG1_LABEL = "(可選) 單位:"

	L.BS_ASSIST_HELP = "協助某單位"
	L.BS_ASSIST_ARG1_LABEL = "(可選) 單位:"

	L.BS_CLICK_HELP = "使用按鈕類比點擊"
	L.BS_CLICK_ARG1_LABEL = "按鈕名稱:"

	L.BS_MENU_HELP = "顯示單位的彈出功能表"
end
