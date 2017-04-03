--[[--------------------------------------------------------------------
	GridLocale-zhCN.lua
	Simplified Chinese (简体中文) localization for Grid.
----------------------------------------------------------------------]]

if GetLocale() ~= "zhCN" then return end
local _, ns = ...
ns.L = {

--{{{ GridCore
	["Debugging"] = "除错",
	["Module debugging menu."] = "除错模块配置。",
	["Debug"] = "除错",
	["Toggle debugging for %s."] = "打开/关闭%s的除错。",
	["Configure"] = "配置",
	["Configure Grid"] = "配置 Grid",
	["Hide minimap icon"] = "隐藏迷你地图按钮",
	["Grid is disabled: use '/grid standby' to enable."] = "Gird 已被禁用：使用“/grid standby”命令启用。",
--	["Enable dual profile"] = "",
--	["Automatically swap profiles when switching talent specs."] = "",
--	["Dual profile"] = "",
--	["Select the profile to swap with the current profile when switching talent specs."] = "",
--}}}

--{{{ GridFrame
	["Frame"] = "框架",
	["Options for GridFrame."] = "Grid 框架的选项。",

	["Show Tooltip"] = "显示提示信息",
	["Show unit tooltip.  Choose 'Always', 'Never', or 'OOC'."] = "显示单位框架的鼠标信息。选择“一直”，“不显示”或“非战斗”。",
	["Always"] = "一直",
	["Never"] = "不显示",
	["OOC"] = "非战斗",
	["Center Text Length"] = "中间文字长度",
	["Number of characters to show on Center Text indicator."] = "中间文字提示器所显示文字的长度。",
	["Invert Bar Color"] = "反转颜色",
	["Swap foreground/background colors on bars."] = "反转提示条上背景/前景的颜色。",
	["Healing Bar Opacity"] = "治疗条透明度",
	["Sets the opacity of the healing bar."] = "设置治疗条的透明度。",

	["Indicators"] = "提示器",
	["Border"] = "外框",
	["Health Bar"] = "生命条",
	["Health Bar Color"] = "生命条颜色",
	["Healing Bar"] = "治疗条",
	["Center Text"] = "中心文字",
	["Center Text 2"] = "中心文字2",
	["Center Icon"] = "中心图标",
	["Top Left Corner"] = "左上角",
	["Top Right Corner"] = "右上角",
	["Bottom Left Corner"] = "左下角",
	["Bottom Right Corner"] = "右下角",
	["Frame Alpha"] = "框架透明度",

	["Options for %s indicator."] = "%s提示器的选项。",
	["Statuses"] = "状态",
	["Toggle status display."] = "打开/关闭显示状态。",

	-- Advanced options
	["Advanced"] = "高级",
	["Advanced options."] = "高级选项。",
	["Enable %s indicator"] = "启用%s指示",
	["Toggle the %s indicator."] = "打开/关闭%s指示。",
	["Frame Width"] = "框架宽度",
	["Adjust the width of each unit's frame."] = "调整个体框架的宽度。",
	["Frame Height"] = "框架高度",
	["Adjust the height of each unit's frame."] = "调整个体框架的高度。",
	["Frame Texture"] = "框架材质",
	["Adjust the texture of each unit's frame."] = "调整个体框架的材质。",
	["Border Size"] = "外框大小",
	["Adjust the size of the border indicators."] = "调整外框指示的大小。",
	["Corner Size"] = "边角指示大小",
	["Adjust the size of the corner indicators."] = "调整边角指示的大小。",
	["Enable Mouseover Highlight"] = "启用鼠标悬停高亮",
	["Toggle mouseover highlight."] = "打开/关闭鼠标悬停高亮。",
	["Font"] = "字体",
	["Adjust the font settings"] = "调整字体",
	["Font Size"] = "字体大小",
	["Adjust the font size."] = "调整字体尺寸。",
	["Font Outline"] = "字体描边",
	["Adjust the font outline."] = "调整字体描边。",
	["None"] = "无",
	["Thin"] = "细",
	["Thick"] = "粗",
	["Orientation of Frame"] = "框架方向",
	["Set frame orientation."] = "设置框架方向。",
	["Orientation of Text"] = "文字方向",
	["Set frame text orientation."] = "设置文字方向。",
	["Vertical"] = "竖直",
	["Horizontal"] = "水平",
	["Icon Size"] = "图标大小",
	["Adjust the size of the center icon."] = "调整中心图标的尺寸。",
	["Icon Border Size"] = "图标外框大小",
	["Adjust the size of the center icon's border."] = "调整屏幕中心图标外框的大小。",
	["Icon Stack Text"] = "图标堆叠文字",
	["Toggle center icon's stack count text."] = "打开/关闭中心图标的堆叠计数文字。",
	["Icon Cooldown Frame"] = "图标冷却时间框架",
	["Toggle center icon's cooldown frame."] = "打开/关闭中心图标的冷却时间框架。",
--}}}

--{{{ GridLayout
	["Layout"] = "布局",
	["Options for GridLayout."] = "Grid 布局的选项。",

	["Drag this tab to move Grid."] = "拖动此标签移动 Grid。",
	["Lock Grid to hide this tab."] = "锁定 Grid 隐藏此标签。",
	["Alt-Click to permanantly hide this tab."] = "Alt-单击总是隐藏此标签。",

	-- Layout options
	["Show Frame"] = "显示框架",

	["Solo Layout"] = "单人布局",
	["Select which layout to use when not in a party."] = "没有小队时所选择使用的布局。",
	["Party Layout"] = "小队布局",
	["Select which layout to use when in a party."] = "在小队时所选择使用的布局。",
	["25 Player Raid Layout"] = "25人团队布局",
	["Select which layout to use when in a 25 player raid."] = "25人团队时所选择使用的布局。",
	["10 Player Raid Layout"] = "10人团队布局",
	["Select which layout to use when in a 10 player raid."] = "10人团队时所选择使用的布局。",
	["Battleground Layout"] = "战场布局",
	["Select which layout to use when in a battleground."] = "在战场时所选择使用的布局。",
	["Arena Layout"] = "竞技场布局",
	["Select which layout to use when in an arena."] = "在竞技场时所选择使用的布局。",
	["Horizontal groups"] = "横向排列队伍",
	["Switch between horzontal/vertical groups."] = "选择横向/竖向显示队伍。",
	["Clamped to screen"] = "保持在屏幕上",
	["Toggle whether to permit movement out of screen."] = "打开/关闭是否允许把窗口移到超出屏幕的位置。",
	["Frame lock"] = "锁定框架",
	["Locks/unlocks the grid for movement."] = "锁定/解锁 Grid 框体来让其移动。",
	["Click through the Grid Frame"] = "透过 Grid 框体点击",
	["Allows mouse click through the Grid Frame."] = "是否允许透过 Grid 框体点击。",

	["Center"] = "中心",
	["Top"] = "顶部",
	["Bottom"] = "底部",
	["Left"] = "左侧",
	["Right"] = "右侧",
	["Top Left"] = "左上",
	["Top Right"] = "右上",
	["Bottom Left"] = "左下",
	["Bottom Right"] = "右下",

	-- Display options
	["Padding"] = "填白",
	["Adjust frame padding."] = "调整框架填白。",
	["Spacing"] = "空隙",
	["Adjust frame spacing."] = "调整框架空隙。",
	["Scale"] = "大小比率",
	["Adjust Grid scale."] = "调整框架大小比率。",
	["Border"] = "外框",
	["Adjust border color and alpha."] = "调整外框的颜色和透明度。",
	["Border Texture"] = "外框材质",
	["Choose the layout border texture."] = "选择外框材质布局。",
	["Background"] = "背景",
	["Adjust background color and alpha."] = "调整背景颜色和透明度。",
	["Pet color"] = "宠物颜色",
	["Set the color of pet units."] = "设定宠物的颜色。",
	["Pet coloring"] = "宠物颜色",
	["Set the coloring strategy of pet units."] = "设置宠物颜色策略。",
	["By Owner Class"] = "以主人的职业颜色",
	["By Creature Type"] = "以种类（野兽/恶魔/人型）",
	["Using Fallback color"] = "使用已知颜色",
	["Beast"] = "野兽",
	["Demon"] = "恶魔",
	["Humanoid"] = "人型",
	["Undead"] = "亡灵",
	["Dragonkin"] = "龙类",
	["Elemental"] = "元素",
	["Not specified"] = "未分类",
	["Colors"] = "颜色",
	["Color options for class and pets."] = "玩家和宠物的颜色选项。",
	["Fallback colors"] = "已知颜色",
	["Color of unknown units or pets."] = "未知单位/宠物颜色。",
	["Unknown Unit"] = "未知单位",
	["The color of unknown units."] = "未知单位颜色。",
	["Unknown Pet"] = "未知宠物",
	["The color of unknown pets."] = "未知宠物的颜色。",
	["Class colors"] = "职业颜色",
	["Color of player unit classes."] = "玩家职业颜色。",
	["Creature type colors"] = "生物种类颜色",
	["Color of pet unit creature types."] = "宠物的生物种类的颜色。",
	["Color for %s."] = "%s的颜色。",

	-- Advanced options
	["Advanced"] = "高级",
	["Advanced options."] = "高级选项。",
	["Layout Anchor"] = "布局锚点",
	["Sets where Grid is anchored relative to the screen."] = "设置屏幕中 Grid 的锚点。",
	["Group Anchor"] = "队伍锚点",
	["Sets where groups are anchored relative to the layout frame."] = "设置布局中队伍的锚点。",
	["Reset Position"] = "重置位置",
	["Resets the layout frame's position and anchor."] = "重置布局框架的位置和锚点。",
	["Hide tab"] = "隐藏标签",
	["Do not show the tab when Grid is unlocked."] = "当未锁定 Grid 时不显示标签。",
--}}}

--{{{ GridLayoutLayouts
	["None"] = "无",
	["By Group 5"] = "5人小队",
	["By Group 5 w/Pets"] = "5人小队以及宠物",
	["By Group 10"] = "10人团队",
	["By Group 10 w/Pets"] = "10人团队以及宠物",
	["By Group 15"] = "15人团队",
	["By Group 15 w/Pets"] = "15人团队以及宠物",
	["By Group 25"] = "25人团队",
	["By Group 25 w/Pets"] = "25人团队以及宠物",
	["By Group 25 w/Tanks"] = "25人团队及坦克",
	["By Group 40"] = "40人团队",
	["By Group 40 w/Pets"] = "40人团队以及宠物",
	["By Class 10 w/Pets"] = "10人职业",
	["By Class 25 w/Pets"] = "25人职业",
--}}}

--{{{ GridLDB
--	["Click to open the options in a GUI window."] = "",
--	["Right-Click to open the options in a drop-down menu."] = "",
--}}}

--{{{ GridRange
	-- used for getting spell range from tooltip
	["(%d+) yd range"] = "(%d+)码射程", -- changed from 码距离 as per hehehillman (ticket #166)
--}}}

--{{{ GridStatus
	["Status"] = "状态",
	["Options for %s."] = "%s状态的选项。",
	["Reset class colors"] = "重置职业颜色",
	["Reset class colors to defaults."] = "重置职业颜色为默认。",

	-- module prototype
	["Status: %s"] = "状态：%s",
	["Color"] = "颜色",
	["Color for %s"] = "%s的颜色",
	["Priority"] = "优先度",
	["Priority for %s"] = "%s的优先度",
	["Range filter"] = "距离过滤",
	["Range filter for %s"] = "%s的距离过滤",
	["Enable"] = "启用",
	["Enable %s"] = "启用%s",
--}}}

--{{{ GridStatusAggro
	["Aggro"] = "仇恨",
	["Aggro alert"] = "仇恨警报",
	["High Threat color"] = "高威胁颜色",
	["Color for High Threat."] = "高威胁时的颜色。",
	["Aggro color"] = "仇恨颜色",
	["Color for Aggro."] = "获得仇恨时的颜色。",
	["Tanking color"] = "坦克颜色",
	["Color for Tanking."] = "坦克时的颜色。",
	["Threat"] = "威胁",
	["Show more detailed threat levels."] = "显示更多威胁分级。",
	["High"] = "高",
	["Tank"] = "坦克",
--}}}

--{{{ GridStatusAuras
	["Auras"] = "光环",
	["Debuff type: %s"] = "减益类型：%s",
	["Poison"] = "毒药",
	["Disease"] = "疾病",
	["Magic"] = "魔法",
	["Curse"] = "诅咒",
	["Ghost"] = "幽灵",
	["Buffs"] = "增益",
	["Debuff Types"] = "减益类型",
	["Debuffs"] = "减益",
	["Add new Buff"] = "增加新的增益",
	["Adds a new buff to the status module"] = "状态模组添加一个新的增益",
	["<buff name>"] = "<增益名称>",
	["Add new Debuff"] = "增加新的减益",
	["Adds a new debuff to the status module"] = "状态模组添加一个新的减益",
	["<debuff name>"] = "<减益名称>",
	["Delete (De)buff"] = "删除 增(减)益",
	["Deletes an existing debuff from the status module"] = "删除状态模组内已有的一个增（减）益",
	["Remove %s from the menu"] = "从列表中移除%s",
	["Debuff: %s"] = "减益：%s",
	["Buff: %s"] = "增益：%s",
	["Class Filter"] = "职业过滤",
	["Show status for the selected classes."] = "显示选定职业的状态。",
	["Show on %s."] = "在%s上显示。",
	["Show if mine"] = "显示自身",
	["Display status only if the buff was cast by you."] = "显示你施放增益时的状态。",
	["Show if missing"] = "缺少时显示",
	["Display status only if the buff is not active."] = "仅在增益缺少时才显示状态。",
	["Filter Abolished units"] = "过滤无效单位",
	["Skip units that have an active Abolish buff."] = "忽略单位上存在无效效果。",
	["Show duration"] = "显示持续效果",
	["Show the time remaining, for use with the center icon cooldown."] = "显示的剩余时间，用于中心的图标冷却。",
--}}}

--{{{ GridStatusHeals
	["Heals"] = "治疗",
	["Incoming heals"] = "正被治疗",
	["Ignore Self"] = "忽略自己",
	["Ignore heals cast by you."] = "忽略对自己施放的治疗。",
	["Heal filter"] = "治疗过滤",
	["Show incoming heals for the selected heal types."] = "显示承受治疗的治疗类型。",
	["Direct heals"] = "直接治疗",
	["Include direct heals."] = "包括直接治疗。",
	["Channeled heals"] = "通道治疗",
	["Include channeled heals."] = "包括通道治疗",
	["HoT heals"] = "HoT 治疗",
	["Include heal over time effects."] = "包括 HoT 治疗",
--}}}

--{{{ GridStatusHealth
	["Low HP"] = "低",
	["DEAD"] = "死",
	["FD"] = "假",
	["Offline"] = "离",
	["Unit health"] = "血量",
	["Health deficit"] = "损失的血量",
	["Low HP warning"] = "低血量警报",
	["Feign Death warning"] = "假死提示",
	["Death warning"] = "死亡警报",
	["Offline warning"] = "掉线警报",
	["Health"] = "血量",
	["Show dead as full health"] = "把死亡的显示为满血",
	["Treat dead units as being full health."] = "把死亡的显示为满血。",
	["Use class color"] = "使用职业颜色",
	["Color health based on class."] = "用职业颜色来显示血量。",
	["Health threshold"] = "血量临界点",
	["Only show deficit above % damage."] = "只显示已经损失了%的血量。",
	["Color deficit based on class."] = "用职业颜色来显示损失的血量。",
	["Low HP threshold"] = "低血量临界点",
	["Set the HP % for the low HP warning."] = "设置低血量警报的临界点。",
--}}}

--{{{ GridStatusMana
	["Mana"] = "法力",
	["Low Mana"] = "低法力",
	["Mana threshold"] = "法力临界点",
	["Set the percentage for the low mana warning."] = "设置低法力警告的临界点。",
	["Low Mana warning"] = "低法力警报",
--}}}

--{{{ GridStatusName
	["Unit Name"] = "名字",
	["Color by class"] = "使用职业颜色",
--}}}

--{{{ GridStatusRange
	["Range"] = "距离",
	["Range check frequency"] = "距离检测的频率",
	["Seconds between range checks"] = "多少秒检测一次距离",
	["More than %d yards away"] = "距离超过%d码",
	["%d yards"] = "%d码",
	["Text"] = "文字",
	["Text to display on text indicators"] = "在文字提示器上显示文字",
	["<range>"] = "<距离>",
--}}}

--{{{ GridStatusReadyCheck
	["Ready Check"] = "检查就绪",
	["Set the delay until ready check results are cleared."] = "设置准备就绪检查结果清除的延迟。",
	["Delay"] = "延迟",
	["?"] = "？",
	["R"] = "是",
	["X"] = "否",
	["AFK"] = "暂离",
	["Waiting color"] = "等待颜色",
	["Color for Waiting."] = "等待时的颜色。",
	["Ready color"] = "就绪颜色",
	["Color for Ready."] = "已就绪时的颜色。",
	["Not Ready color"] = "未准备好颜色",
	["Color for Not Ready."] = "未准备好时的颜色。",
	["AFK color"] = "暂离颜色",
	["Color for AFK."] = "暂离时的颜色。",
--}}}

--{{{ GridStatusTarget
	["Target"] = "目标",
	["Your Target"] = "你的目标",
--}}}

--{{{ GridStatusVehicle
	["In Vehicle"] = "使用载具",
	["Driving"] = "驾驶中",
--}}}

--{{{ GridStatusVoiceComm
	["Voice Chat"] = "语音",
	["Talking"] = "正在说话",
--}}}

}