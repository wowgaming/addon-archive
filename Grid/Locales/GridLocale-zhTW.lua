--[[--------------------------------------------------------------------
	GridLocale-zhTW.lua
	Traditional Chinese (正體中文) localization for Grid.
----------------------------------------------------------------------]]

if GetLocale() ~= "zhTW" then return end
local _, ns = ...
ns.L = {

--{{{ GridCore
	["Debugging"] = "除錯",
	["Module debugging menu."] = "除錯模組設定。",
	["Debug"] = "除錯",
	["Toggle debugging for %s."] = "啟用/禁用 %s 的除錯訊息。",
	["Configure"] = "設定",
	["Configure Grid"] = "設定 Grid",
	["Hide minimap icon"] = "隱藏小地圖按鈕",
	["Grid is disabled: use '/grid standby' to enable."] = "Grid 已被禁用：輸入'/grid standby'的指令啟用。",
	["Enable dual profile"] = "啟用雙天賦配置",
	["Automatically swap profiles when switching talent specs."] = "當切換天賦的時候自動切換配置",
	["Dual profile"] = "雙天賦配置",
	["Select the profile to swap with the current profile when switching talent specs."] = "當切換天賦的時候選擇配置文件替換當前配置文件",
--}}}

--{{{ GridFrame
	["Frame"] = "框架",
	["Options for GridFrame."] = "GridFrame 設定選項。",

	["Show Tooltip"] = "顯示提示訊息",
	["Show unit tooltip.  Choose 'Always', 'Never', or 'OOC'."] = "顯示單位框架的提示訊息。選擇「總是」，「永不」或「戰鬥外」。",
	["Always"] = "總是",
	["Never"] = "永不",
	["OOC"] = "戰鬥外",
	["Center Text Length"] = "中央文字長度",
	["Number of characters to show on Center Text indicator."] = "中央文字提示器所顯示的文字長度。",
	["Invert Bar Color"] = "調換顏色",
	["Swap foreground/background colors on bars."] = "調換提示條背景與前景之顏色。",
	["Healing Bar Opacity"] = "治療條透明度",
	["Sets the opacity of the healing bar."] = "設定治療條的透明度。",

	["Indicators"] = "提示器",
	["Border"] = "邊框",
	["Health Bar"] = "生命力條",
	["Health Bar Color"] = "生命力條顏色",
	["Healing Bar"] = "治療條",
	["Center Text"] = "中央文字",
	["Center Text 2"] = "中央文字2",
	["Center Icon"] = "中央圖示",
	["Top Left Corner"] = "左上角",
	["Top Right Corner"] = "右上角",
	["Bottom Left Corner"] = "左下角",
	["Bottom Right Corner"] = "右下角",
	["Frame Alpha"] = "框架透明度",

	["Options for %s indicator."] = "%s提示器的設定選項。",
	["Statuses"] = "狀態",
	["Toggle status display."] = "啟用/禁用顯示狀態。",

	-- Advanced options
	["Advanced"] = "進階",
	["Advanced options."] = "進階選項。",
	["Enable %s indicator"] = "啟用%s提示器",
	["Toggle the %s indicator."] = "啟用/禁用%s提示器。",
	["Frame Width"] = "框架寬度",
	["Adjust the width of each unit's frame."] = "為每一個單位框架調整寬度。",
	["Frame Height"] = "框架高度",
	["Adjust the height of each unit's frame."] = "為每一個單位框架調整高度。",
	["Frame Texture"] = "框架材質",
	["Adjust the texture of each unit's frame."] = "調整每一個單位框架的材質。",
	["Border Size"] = "邊框大小",
	["Adjust the size of the border indicators."] = "調整邊框提示器大小",
	["Corner Size"] = "角落提示器大小",
	["Adjust the size of the corner indicators."] = "調整角落提示器的大小。",
	["Enable Mouseover Highlight"] = "啟用滑鼠懸停高亮",
	["Toggle mouseover highlight."] = "啟用/禁用滑鼠懸停高亮。",
	["Font"] = "字型設定",
	["Adjust the font settings"] = "調整字型。",
	["Font Size"] = "字型大小",
	["Adjust the font size."] = "調整字型大小。",
--	["Font Outline"] = "",
--	["Adjust the font outline."] = "",
--	["None"] = "",
--	["Thin"] = "",
--	["Thick"] = "",
	["Orientation of Frame"] = "框架排列方式",
	["Set frame orientation."] = "設定框架排列方式。",
	["Orientation of Text"] = "文字排列方式",
	["Set frame text orientation."] = "設定框架中文字排列方式。",
	["Vertical"] = "垂直",
	["Horizontal"] = "水平",
	["Icon Size"] = "圖示大小",
	["Adjust the size of the center icon."] = "調整中央圖示大小。",
	["Icon Border Size"] = "圖示邊框大小",
	["Adjust the size of the center icon's border."] = "調整中央圖示的邊框大小",
	["Icon Stack Text"] = "圖示堆疊文字",
	["Toggle center icon's stack count text."] = "啟用/禁用圖示的堆疊計數文字。",
	["Icon Cooldown Frame"] = "圖示冷卻時間框架",
	["Toggle center icon's cooldown frame."] = "啟用/禁用圖示的冷卻時間框架。",
--}}}

--{{{ GridLayout
	["Layout"] = "版面編排",
	["Options for GridLayout."] = "Grid版面設定選項。",

	["Drag this tab to move Grid."] = "拖動此標簽移動 Grid。",
	["Lock Grid to hide this tab."] = "鎖定 Grid 隱藏此標簽。",
	["Alt-Click to permanantly hide this tab."] = "Alt-單擊總是隱藏此標簽。。",

	-- Layout options
	["Show Frame"] = "顯示框架",

	["Solo Layout"] = "單人版面編排",
	["Select which layout to use when not in a party."] = "選擇單人版面編排方式。",
	["Party Layout"] = "隊伍版面編排",
	["Select which layout to use when in a party."] = "選擇隊伍版面編排方式。",
	["25 Player Raid Layout"] = "25人團隊模式",
	["Select which layout to use when in a 25 player raid."] = "選擇25人團隊模式面板編排",
	["10 Player Raid Layout"] = "10人團隊模式",
	["Select which layout to use when in a 10 player raid."] = "選擇10人團隊模式面板編排",
	["Battleground Layout"] = "戰場版面編排",
	["Select which layout to use when in a battleground."] = "選擇戰場版面編排方式。",
	["Arena Layout"] = "競技場版面編排",
	["Select which layout to use when in an arena."] = "選擇競技場版面編排方式。",
	["Horizontal groups"] = "橫向顯示小組",
	["Switch between horzontal/vertical groups."] = "轉換橫向/垂直顯示小組。",
	["Clamped to screen"] = "限制框架於視窗內",
	["Toggle whether to permit movement out of screen."] = "啟用/禁用框架於視窗內限制，避免拖曳出視窗外。",
	["Frame lock"] = "鎖定框架",
	["Locks/unlocks the grid for movement."] = "鎖定/解鎖 Grid 框架。",
	["Click through the Grid Frame"] = "透過點擊 Grid 框架",
	["Allows mouse click through the Grid Frame."] = "允許透過滑鼠點擊 Grid 框架。",

	["Center"] = "中",
	["Top"] = "上",
	["Bottom"] = "下",
	["Left"] = "左",
	["Right"] = "右",
	["Top Left"] = "左上",
	["Top Right"] = "右上",
	["Bottom Left"] = "左下",
	["Bottom Right"] = "右下",

	-- Display options
	["Padding"] = "間距",
	["Adjust frame padding."] = "調整框架間距。",
	["Spacing"] = "空間",
	["Adjust frame spacing."] = "調整外框架空間。",
	["Scale"] = "縮放比例",
	["Adjust Grid scale."] = "調整 Grid 縮放比例。",
	["Border"] = "邊框",
	["Adjust border color and alpha."] = "調整邊框顏色與透明度。",
	["Border Texture"] = "邊框材質",
	["Choose the layout border texture."] = "選擇版面編排的邊框材質",
	["Background"] = "背景",
	["Adjust background color and alpha."] = "調整背景顏色與透明度。",
	["Pet color"] = "寵物顏色",
	["Set the color of pet units."] = "設定寵物使用的顏色",
	["Pet coloring"] = "寵物配色",
	["Set the coloring strategy of pet units."] = "設定寵物的配色方案。",
	["By Owner Class"] = "依玩家職業",
	["By Creature Type"] = "依支配類型",
	["Using Fallback color"] = "使用備用顏色",
	["Beast"] = "野獸",
	["Demon"] = "惡魔",
	["Humanoid"] = "人形生物",
	["Undead"] = "不死生物",
	["Dragonkin"] = "龍類",
	["Elemental"] = "元素生物",
	["Not specified"] = "未指定",
	["Colors"] = "顏色",
	["Color options for class and pets."] = "職業與寵物的顏色選項。",
	["Fallback colors"] = "備用顏色",
	["Color of unknown units or pets."] = "未知單位或寵物的顏色。",
	["Unknown Unit"] = "未知單位",
	["The color of unknown units."] = "未知單位的顏色。",
	["Unknown Pet"] = "未知寵物",
	["The color of unknown pets."] = "未知寵物的顏色。",
	["Class colors"] = "職業顏色",
	["Color of player unit classes."] = "玩家職業的顏色。",
	["Creature type colors"] = "召喚類型的顏色",
	["Color of pet unit creature types."] = "玩家召喚之寵物的顏色。",
	["Color for %s."] = "%s的顏色",

	-- Advanced options
	["Advanced"] = "進階",
	["Advanced options."] = "進階選項。",
	["Layout Anchor"] = "版面編排錨點",
	["Sets where Grid is anchored relative to the screen."] = "設定 Grid 的版面位置錨點。",
	["Group Anchor"] = "小組錨點",
	["Sets where groups are anchored relative to the layout frame."] = "設定版面編排中的小組錨點。",
	["Reset Position"] = "重設位置",
	["Resets the layout frame's position and anchor."] = "重設版面位置和錨點。",
	["Hide tab"] = "隱藏標簽",
	["Do not show the tab when Grid is unlocked."] = "當未鎖定 Grid 時不顯示標簽。",
--}}}

--{{{ GridLayoutLayouts
	["None"] = "無",
	["By Group 5"] = "5人團隊",
	["By Group 5 w/Pets"] = "5人團隊及寵物",
	["By Group 10"] = "10人團隊",
	["By Group 10 w/Pets"] = "10人團隊及寵物",
	["By Group 15"] = "15人團隊",
	["By Group 15 w/Pets"] = "15人團隊及寵物",
	["By Group 25"] = "25人團隊",
	["By Group 25 w/Pets"] = "25人團隊及寵物",
	["By Group 25 w/Tanks"] = "25人團隊及坦克",
	["By Group 40"] = "40人團隊",
	["By Group 40 w/Pets"] = "40人團隊及寵物",
	["By Class 10 w/Pets"] = "10人以職業排列",
	["By Class 25 w/Pets"] = "25人以職業排列",
--}}}

--{{{ GridLDB
--	["Click to open the options in a GUI window."] = "",
--	["Right-Click to open the options in a drop-down menu."] = "",
--}}}

--{{{ GridRange
	-- used for getting spell range from tooltip
	["(%d+) yd range"] = "(%d+)碼距離",
--}}}

--{{{ GridStatus
	["Status"] = "狀態",
	["Options for %s."] = "%s 設定選項。",
	["Reset class colors"] = "重置職業顔色",
	["Reset class colors to defaults."] = "重置職業顔色為默認",

	-- module prototype
	["Status: %s"] = "狀態: %s",
	["Color"] = "顏色",
	["Color for %s"] = "%s的顏色",
	["Priority"] = "優先程度",
	["Priority for %s"] = "%s的優先程度",
	["Range filter"] = "距離過濾",
	["Range filter for %s"] = "%s的距離過濾",
	["Enable"] = "啟用",
	["Enable %s"] = "啟用%s",
--}}}

--{{{ GridStatusAggro
	["Aggro"] = "仇恨",
	["Aggro alert"] = "仇恨警告",
	["High Threat color"] = "高仇恨的顏色",
	["Color for High Threat."] = "高仇恨時的顏色。",
	["Aggro color"] = "仇恨的顏色",
	["Color for Aggro."] = "獲得仇恨時的顏色",
	["Tanking color"] = "坦克的顏色",
	["Color for Tanking."] = "坦克時的顏色。",
	["Threat"] = "仇恨",
	["Show more detailed threat levels."] = "顯示更詳細的仇恨值",
	["High"] = "高",
	["Tank"] = "坦克",
--}}}

--{{{ GridStatusAuras
	["Auras"] = "光環",
	["Debuff type: %s"] = "減益類型: %s",
	["Poison"] = "毒",
	["Disease"] = "疾病",
	["Magic"] = "魔法",
	["Curse"] = "詛咒",
	["Ghost"] = "鬼魂",
	["Buffs"] = "增益",
	["Debuff Types"] = "減益類型",
	["Debuffs"] = "減益",
	["Add new Buff"] = "增加新的增益",
	["Adds a new buff to the status module"] = "增加一個新的增益至狀態模組中",
	["<buff name>"] = "<增益名稱>",
	["Add new Debuff"] = "增加新的減益",
	["Adds a new debuff to the status module"] = "增加一個新的減益至狀態模組中",
	["<debuff name>"] = "<減益名稱>",
	["Delete (De)buff"] = "刪除增/減益",
	["Deletes an existing debuff from the status module"] = "刪除狀態模組內已有的增/減益",
	["Remove %s from the menu"] = "從選單中刪除%s",
	["Debuff: %s"] = "減益: %s",
	["Buff: %s"] = "增益: %s",
	["Class Filter"] = "職業過濾",
	["Show status for the selected classes."] = "顯示選定職業的狀態。",
	["Show on %s."] = "在%s上顯示。",
	["Show if mine"] = "顯示我的",
	["Display status only if the buff was cast by you."] = "顯示只有你所施放的增益。",
	["Show if missing"] = "顯示缺少",
	["Display status only if the buff is not active."] = "當缺少增益時提示。",
	["Filter Abolished units"] = "過濾驅散單位",
	["Skip units that have an active Abolish buff."] = "略過身上有驅散增益的單位。",
	["Show duration"] = "顯示持續時間",
	["Show the time remaining, for use with the center icon cooldown."] = "在圖示中顯示持續時間。",
--}}}

--{{{ GridStatusHeals
	["Heals"] = "治療",
	["Incoming heals"] = "治療中",
	["Ignore Self"] = "忽略自己",
	["Ignore heals cast by you."] = "忽略自己施放的治療法術。",
	["Heal filter"] = "治療過濾",
	["Show incoming heals for the selected heal types."] = "顯示治療中選擇的治療類型",
	["Direct heals"] = "直接治療",
	["Include direct heals."] = "加入直接治療",
	["Channeled heals"] = "引導治療",
	["Include channeled heals."] = "加入引導治療",
	["HoT heals"] = "HoT治療",
	["Include heal over time effects."] = "加入(HoT)持續回血效果",
--}}}

--{{{ GridStatusHealth
	["Low HP"] = "生命力不足",
	["DEAD"] = "死亡",
	["FD"] = "假死",
	["Offline"] = "離線",
	["Unit health"] = "單位生命力",
	["Health deficit"] = "損失生命力",
	["Low HP warning"] = "生命力不足警報",
	["Feign Death warning"] = "假死警報",
	["Death warning"] = "死亡警報",
	["Offline warning"] = "斷線警報",
	["Health"] = "生命力",
	["Show dead as full health"] = "顯示死亡為生命力全滿",
	["Treat dead units as being full health."] = "把死亡玩家的生命力顯示成全滿。",
	["Use class color"] = "使用職業顏色",
	["Color health based on class."] = "生命力顏色根據不同的職業著色。",
	["Health threshold"] = "生命力臨界點",
	["Only show deficit above % damage."] = "當損失生命力超過總生命力某個百分比時顯示損失生命力值。",
	["Color deficit based on class."] = "損失生命力值根據不同的職業著色。",
	["Low HP threshold"] = "生命力不足臨界點",
	["Set the HP % for the low HP warning."] = "設定當生命力低於臨界點時警告。",
--}}}

--{{{ GridStatusMana
	["Mana"] = "法力",
	["Low Mana"] = "法力不足",
	["Mana threshold"] = "法力不足臨界點",
	["Set the percentage for the low mana warning."] = "設定當法力低於臨界點時警告。",
	["Low Mana warning"] = "法力不足警報",
--}}}

--{{{ GridStatusName
	["Unit Name"] = "名字",
	["Color by class"] = "使用職業顏色",
--}}}

--{{{ GridStatusRange
	["Range"] = "距離",
	["Range check frequency"] = "距離檢測頻率",
	["Seconds between range checks"] = "設定程式多少秒檢測一次距離",
	["More than %d yards away"] = "距離超過%d碼",
	["%d yards"] = "%d 碼",
	["Text"] = "文字",
	["Text to display on text indicators"] = "顯示文字於文字提示器上",
	["<range>"] = "<距離>",
--}}}

--{{{ GridStatusReadyCheck
	["Ready Check"] = "檢查就緒",
	["Set the delay until ready check results are cleared."] = "設定檢查就續結果清除的延遲。",
	["Delay"] = "延遲",
	["?"] = "？",
	["R"] = "是",
	["X"] = "否",
	["AFK"] = "暫離",
	["Waiting color"] = "等待中的顏色",
	["Color for Waiting."] = "等待中的顏色",
	["Ready color"] = "就緒的顏色",
	["Color for Ready."] = "就緒的顏色",
	["Not Ready color"] = "尚未就緒的顏色",
	["Color for Not Ready."] = "尚未就緒的顏色",
	["AFK color"] = "暫離的顏色",
	["Color for AFK."] = "暫離的顏色",
--}}}

--{{{ GridStatusTarget
	["Target"] = "目標",
	["Your Target"] = "你的目標",
--}}}

--{{{ GridStatusVehicle
	["In Vehicle"] = "載具上",
	["Driving"] = "操作",
--}}}

--{{{ GridStatusVoiceComm
	["Voice Chat"] = "語音",
	["Talking"] = "說話中",
--}}}

}