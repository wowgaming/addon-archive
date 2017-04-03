-- This file is script-generated and should not be manually edited. 
-- Localizers may copy this file to edit as necessary. 
local AceLocale = LibStub:GetLibrary("AceLocale-3.0") 
local L = AceLocale:NewLocale("SexyMap", "zhTW", false) 
if not L then return end 
 
-- Just temp, Antiarc's script will kill these and associate it all correctly
L["Lock coordinates"] = "鎖定座標框"
L["Show inside chat"] = "在聊天窗口顯示"
L["Show on minimap"] = "在迷你地圖顯示"
L["Text width"] = "文本寬度"
L["Enable Hudmap"] = "啟用 HUD 地圖"
L["Enable fader"] = "啟用淡出"
 
-- ./AutoZoom.lua
L["Autozoom out after..."] = "自動縮放到最小"
L["Number of seconds to autozoom out after. Set to 0 to turn off Autozoom."] = "幾秒後自動縮放到最小。‘0’為不自動縮放"

-- ./BorderPresets.lua
-- no localization

-- ./Borders.lua
L["1. Background"] = "1、背景"
L["2. Border"] = "2、邊框"
L["3. Artwork"] = "3、藝術裝飾"
L["4. Overlay"] = "4、覆蓋"
L["5. Highlight"] = "5、高亮"
L["Blend (normal)"] = "混合效果（普通）"
L["Disable (opaque)"] = "禁用（不透明）"
L["Alpha Key (1-bit alpha)"] = "測試鍵（1位測試）"
L["Mod Blend (modulative)"] = "模塊混合（模塊式）"
L["Add Blend (additive)"] = "添加混合（附加式）"
L["Borders"] = "邊框"
L["Hide default border"] = "隱藏默認邊框"
L["Hide the default border on the minimap."] = "隱藏小地圖默認的邊框"
L["Current Borders"] = "當前邊框"
L["Enter a name to create a new border. The name can be anything you like to help you identify that border."] = "輸入一個名稱以創建一個新的邊框。可以用任何你想用來幫助你識別此邊框的名稱"
L["Create new border"] = "創建一個新的邊框"
L["Clear & start over"] = "重置"
L["Clear the current borders and start fresh"] = "清除當前邊框重新開始設置"
L["Background/edge"] = "背景/邊緣"
L["You can set a background and edge file for the minimap like you would with any frame. This is useful when you want to create static square backdrops for your minimap."] = "設定你喜歡的迷你地圖設定背景與邊框檔案，便於建立迷你地圖為靜態方形。"
L["Enable"] = "啟用"
L["Enable a backdrop and border for the minimap. This will let you set square borders more easily."] = "啟用迷你地圖的背景與邊框，便於設定方形邊框。"
L["Scale"] = "縮放"
L["Opacity"] = "不透明度"
L["Background Texture"] = "背景材質"
L["Texture"] = "材質"
L["Open TexBrowser"] = "開啟 TexBrowser"
L["TexBrowser Not Installed"] = "尚未安裝 TexBrowser"
L["SharedMedia Texture"] = "SharedMedia 材質"
L["Tile background"] = "平鋪背景"
L["Tile size"] = "平鋪大小"
L["Backdrop color"] = "背景塊顏色"
L["Backdrop insets"] = "背景塊鑲邊"
L["Border Texture"] = "邊框材質"
L["Border texture"] = "邊框材質"
L["SharedMedia Border"] = "SharedMedia 邊框"
L["Border color"] = "邊框顏色"
L["Border edge size"] = "邊框厚度"
L["Preset"] = "配置檔"
L["Select preset to load"] = "選擇要載入的配置檔"
L["Select a preset to load settings from. This will erase any of your current borders."] = "選擇配置檔以載入設定值，這將會清除你目前的邊框設定。"
L["This will wipe out any current settings!"] = "這將會清除你目前的設定值！"
L["Delete"] = "刪除"
L["Really delete this preset? This can't be undone."] = "此動作無法再回復，確定要刪除此設定檔？"
L["Save current settings as preset..."] = "儲存目前設定於配置檔"
L["Entry options"] = "項目選項"
L["Name"] = "名稱"
L["Really delete this border?"] = "確定刪除此邊框？"
L["Texture path"] = "材質路徑"
L["Enter the full path to a texture to use. It's recommended that you use something like |cffff6600TexBrowser|r to find textures to use."] = "請輸入要使用的材質完整路徑。建議使用如 TexBrowser 來尋找可用的材質。"
L["Texture options"] = "材質選項"
L["Rotation Speed"] = "旋轉速度"
L["Speed to rotate the texture at. A setting of 0 turns off rotation."] = "材質旋轉速度，設定為 0 則停止旋轉"
L["Static Rotation"] = "靜態旋轉"
L["A static amount to rotate the texture by."] = "材質靜態旋轉量"
L["Match player rotation"] = "隨玩家旋轉"
L["Normal rotation"] = "正常旋轉"
L["Reverse rotation"] = "反向旋轉"
L["Do not match player rotation"] = "不隨玩家旋轉"
L["Texture tint"] = "材質色彩"
L["Horizontal nudge"] = "水平微調"
L["Vertical nudge"] = "垂直微調"
L["Layer"] = "層級"
L["Blend Mode"] = "混合模式"
L["Disable Rotation"] = "關閉旋轉"
L["Force a square texture. Fixed distortion on square textures."] = "強制使用方形材質，修正因方形材質產生的變形。"

-- ./Buttons.lua
L["Addon Buttons"] = "插件按鈕"
L["Standard Buttons"] = "標準按鈕"
L["Capture New Buttons"] = "截獲新按鈕"
L["Let SexyMap handle button dragging"] = "SexyMap 接管按鈕拖曳"
L["Allow SexyMap to assume drag ownership for buttons attached to the minimap. Turn this off if you have another mod that you want to use to position your minimap buttons."] = "令 SexyMap 能夠拖曳迷你地圖上的按鈕。假如你想用其他插件來拖曳，關閉這個功能"
L["Lock Button Dragging"] = "鎖定按鈕拖曳"
L["Let SexyMap control button visibility"] = "SexyMap 管理按鈕可見性"
L["Turn this off if you want another mod to handle which buttons are visible on the minimap."] = "假如你用其他插件控制隱藏，關閉這個功能"
L["Drag Radius"] = "拖曳半徑"
L["Calendar"] = "行事曆"
L["Map Button"] = "世界地圖按鈕"
L["Tracking Button"] = "追蹤技能按鈕"
L["Zoom Buttons"] = "縮放按鈕"
L["Clock"] = "時鐘"
L["Close button"] = "關閉按鈕"
L["Compass labels"] = "指北針標籤"
L["New mail indicator"] = "新郵件指示器"
L["Voice chat"] = "語音"
L["Battlegrounds icon"] = "戰場徽標"
L["Always"] = "總是顯示"
L["Never"] = "不顯示"
L["On hover"] = "滑鼠停留"

-- ./Coordinates.lua
L["Coordinates"] = "坐標"
L["Enable Coordinates"] = "啟用坐標顯示"
L["Settings"] = "設定"
L["Font size"] = "字型大小"
L["Lock"] = "鎖定"
L["Font color"] = "字型顏色"
L["Reset position"] = "重置位置"

-- ./Fader.lua
L["Enabled"] = "啟用"
L["Enable fader functionality"] = "啟用亮度調節功能"
L["Hover Opacity"] = "滑鼠懸停時不透明度"
L["Normal Opacity"] = "常規狀態時不透明度"

-- ./General.lua
L["Lock minimap"] = "鎖定迷你地圖"
L["Show movers"] = "顯示可移動項目"
L["Clamp to screen"] = "不超出螢幕範圍"
L["Right click map to configure"] = "右鍵點擊迷你地圖開啟設定檔"
L["Armored Man"] = "耐久小人"
L["Capture Bars"] = "佔領狀態條"
L["Vehicle Seat"] = "載具座位"

-- ./HudMap.lua
L["Enable a HUD minimap. This is very useful for gathering resources, but for technical reasons, the HUD map and the normal minimap can't be shown at the same time. Showing the HUD map will turn off the normal minimap."] = "啟用 HUD 式迷你地圖。這個對采集資源很有好處，但是因為技術上的關係，HUD 地圖和原本的迷你地圖不能一起顯示。顯示 HUD 地圖會關閉原本的迷你地圖。"
L["Keybinding"] = "綁定熱鍵"
L["GatherMate is a resource gathering helper mod. Installing it allows you to have resource pins on your HudMap."] = "GatherMate 是一個采集助手類的插件。安裝 GatherMate 能在 HUD 地圖上顯示資源點"
L["Use GatherMate pins"] = "使用 GatherMate 资源点"
L["Use QuestHelper pins"] = "使用 QuestHelper 资源点"
L["Routes plots the shortest distance between resource nodes. Install it to show farming routes on your HudMap."] = "顯示最近的資源點之間的采集路線。加載這個能在 HUD 地圖上顯示 FARM 路線"
L["Use Routes"] = "顯示采集路線"
L["HUD Color"] = "HUD 顏色"
L["Text Color"] = "文本顏色"

-- ./moduleTemplate.lua
-- no localization

-- ./oldBorders.lua
-- no localization

-- ./Ping.lua
L["Show who pinged"] = "顯示誰點擊地圖"
L["Show..."] = "顯示至..."
L["On minimap"] = "迷你地圖"
L["In chat"] = "聊天視窗"

-- ./SexyMap.lua
L["Profiles"] = "配置檔"

-- ./Shapes.lua
L["Circle"] = "圓形"
L["Faded Circle (Small)"] = "圓形淡出（小）"
L["Faded Circle (Large)"] = "圓形淡出（大）"
L["Faded Square"] = "方形淡出"
L["Diamond"] = "鑽石形"
L["Square"] = "方形"
L["Heart"] = "心形"
L["Octagon"] = "八邊形"
L["Hexagon"] = "六邊形"
L["Snowflake"] = "雪花形"
L["Route 66"] = "66路形"
L["Rounded - Bottom Right"] = "方形圓角-右下"
L["Rounded - Bottom Left"] = "方形圓角-左下"
L["Rounded - Top Right"] = "方形圓角-右上"
L["Rounded - Top Left"] = "方形圓角-左上"
L["Minimap shape"] = "迷你地圖外觀"

-- ./Snap.lua
-- no localization

-- ./ZoneText.lua
L["Horizontal position"] = "水平位置"
L["Vertical position"] = "垂直位置"
L["Width"] = "寬度"
L["Background color"] = "背景顏色"
L["Font"] = "字型"
L["Font Size"] = "字型大小"

-- ./localization/enUS.lua
-- no localization

-- ./localization/zhCN.lua
-- no localization

-- ./localization/zhTW.lua
-- no localization

