-------------------------------------------------------------------------------
-- Localization                                                              --
-- Simple Chinese Translated by 昏睡墨鱼&Costa<CWDG>                         --
-------------------------------------------------------------------------------

local L = Clique.Locals

if GetLocale() == "zhCN" then
	L.RANK                    = "等级"
	L.RANK_PATTERN            = "等级 (%d+)"
	L.CAST_FORMAT             = "%s(等级 %s)"

	L.RACIAL_PASSIVE          = "种族被动技能"
	L.PASSIVE                 = SPELL_PASSIVE
	
	L.CLICKSET_DEFAULT        = "默认"
	L.CLICKSET_HARMFUL        = "对敌方动作"
	L.CLICKSET_HELPFUL        = "对友方动作"
	L.CLICKSET_OOC            = "非战斗中动作"
	L.CLICKSET_BEARFORM       = "熊形态"
	L.CLICKSET_CATFORM        = "猎豹形态"
    L.CLICKSET_AQUATICFORM    = "水栖形态"
	L.CLICKSET_TRAVELFORM     = "旅行形态"
	L.CLICKSET_MOONKINFORM    = "枭兽形态"
	L.CLICKSET_TREEOFLIFE     = "树形"
	L.CLICKSET_SHADOWFORM     = "暗影形态"
	L.CLICKSET_STEALTHED      = "潜行状态"
	L.CLICKSET_BATTLESTANCE   = "战斗姿态"
	L.CLICKSET_DEFENSIVESTANCE = "防御姿态"
	L.CLICKSET_BERSERKERSTANCE = "狂暴姿态"

	L.BEAR_FORM = "熊形态"
	L.DIRE_BEAR_FORM = "巨熊形态"
	L.CAT_FORM = "猎豹形态"
	L.AQUATIC_FORM = "水栖形态"
	L.TRAVEL_FORM = "旅行形态"
	L.TREEOFLIFE = "树形"
	L.MOONKIN_FORM = "枭兽形态"
	L.STEALTH = "潜行状态"
	L.SHADOWFORM = "暗影形态"
	L.BATTLESTANCE = "战斗姿态"
	L.DEFENSIVESTANCE = "防御姿态"
	L.BERSERKERSTANCE = "狂暴姿态"

	L.BINDING_NOT_DEFINED     = "未定义绑定"
	L.CANNOT_CHANGE_COMBAT    = "战斗状态中无法改变. 这些改变被推迟到脱离战斗状态后."
	L.APPLY_QUEUE             = "脱离战斗状态.  进行所有预定了的改变."
	L.PROFILE_CHANGED         = "已经切换到设置 '%s'."
	L.PROFILE_DELETED         = "你的设置 '%s' 已经被删除."
	L.PROFILE_RESET         = "你的设置 '%s' 已经被重值."

	L.ACTION_ACTIONBAR = "切换动作条"
	L.ACTION_ACTION = "动作按钮"
	L.ACTION_PET = "宠物动作按钮"
	L.ACTION_SPELL = "释放法术"
	L.ACTION_ITEM = "使用物品"
	L.ACTION_MACRO = "运行自定义宏"
	L.ACTION_STOP = "终止施法"
	L.ACTION_TARGET = "目标单位"
	L.ACTION_FOCUS = "指定目标单位"
	L.ACTION_ASSIST = "协助某单位"
	L.ACTION_CLICK = "点击按钮"
	L.ACTION_MENU = "显示菜单"

	L.HELP_TEXT               = "欢迎使用Clique.  最基本的操作，你可以浏览法术书然后给喜欢的法术绑定按键.例如，你可以找到\快速治疗\ 然后按住shift点左键，这样shift+左键就被设置为释放快速治疗了."
	L.CUSTOM_HELP             = "这是Clique自定义窗口.在这里，你可以设置任何点击影射到界面允许的组合按键. 从左侧选择一个基本的动作，然后可以可以点击下边的按钮来映射到任何你希望的操作. "
	
	L.BS_ACTIONBAR_HELP = "切换动作条.  'increment' 会向后翻一页, 'decrement' 则相反. 如果你提供了一个编号, 动作条就会翻到那一页.你可以定义1,3来在1和3页之间翻动."
	L.BS_ACTIONBAR_ARG1_LABEL = "动作条:"

	L.BS_ACTION_HELP = "将一种点击影射到某动作条的按钮上. 请指定动作条的编号."
	L.BS_ACTION_ARG1_LABEL = "按钮编号:"
	L.BS_ACTION_ARG2_LABEL = "(可选) 单位:"

	L.BS_PET_HELP = "将一种点击影射到宠物动作条的按钮上.  请指定按钮编号."
	L.BS_PET_ARG1_LABEL = "宠物按钮编号:"
	L.BS_PET_ARG2_LABEL = "(可选) 单位:"

	L.BS_SPELL_HELP = "从法术书上选择施法. 设定法术名称, 以及包裹与物品槽编号或者物品名称(可选), 来对目标进行施法 (例如喂养宠物)"
	L.BS_SPELL_ARG1_LABEL = "法术名称:"
	L.BS_SPELL_ARG2_LABEL = "*包裹编号:"
	L.BS_SPELL_ARG3_LABEL = "*物品槽编号:"
	L.BS_SPELL_ARG4_LABEL = "*物品名称:"
	L.BS_SPELL_ARG5_LABEL = "(可选) 单位:"

	L.BS_ITEM_HELP = "使用一个物品. 可以通过包裹与物品槽的编号，或者物品名称来指定."
	L.BS_ITEM_ARG1_LABEL = "包裹编号:"
	L.BS_ITEM_ARG2_LABEL = "物品槽编号:"
	L.BS_ITEM_ARG3_LABEL = "物品名称:"
	L.BS_ITEM_ARG4_LABEL = "(可选) 单位:"

	L.BS_MACRO_HELP = "使用给定索引的自定义宏"
	L.BS_MACRO_ARG1_LABEL = "宏索引:"
	L.BS_MACRO_ARG2_LABEL = "宏内容:"

	L.BS_STOP_HELP = "中断当前施法"
	
	L.BS_TARGET_HELP = "将单位设定为目标"
	L.BS_TARGET_ARG1_LABEL = "(可选) 单位:"

	L.BS_FOCUS_HELP = "设定你的 \"目标\" 单位"
	L.BS_FOCUS_ARG1_LABEL = "(可选) 单位:"

	L.BS_ASSIST_HELP = "协助某单位"
	L.BS_ASSIST_ARG1_LABEL = "(可选) 单位:"

	L.BS_CLICK_HELP = "使用按钮模拟点击"
	L.BS_CLICK_ARG1_LABEL = "按钮名称:"

	L.BS_MENU_HELP = "显示单位的弹出菜单"
end