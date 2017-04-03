-- This file is script-generated and should not be manually edited. 
-- Localizers may copy this file to edit as necessary. 
local AceLocale = LibStub:GetLibrary("AceLocale-3.0") 
local L = AceLocale:NewLocale("SexyMap", "zhCN", false) 
if not L then return end 
 
-- Just temp, Antiarc's script will kill these and associate it all correctly
L["Lock coordinates"] = "锁定坐标"
L["Show inside chat"] = "在聊天显示"
L["Show on minimap"] = "在迷你地图显示"
L["Text width"] = "文本宽度"
L["Enable Hudmap"] = "启用 HUD 地图"
L["Enable fader"] = "启用淡出"
 
-- ./AutoZoom.lua
L["Autozoom out after..."] = "自动缩放"
L["Number of seconds to autozoom out after. Set to 0 to turn off Autozoom."] = "几秒后自动缩放。设置为“0”关闭自动缩放。"

-- ./BorderPresets.lua
-- no localization

-- ./Borders.lua
L["1. Background"] = "1、背景"
L["2. Border"] = "2、边框"
L["3. Artwork"] = "3、装饰"
L["4. Overlay"] = "4、覆盖"
L["5. Highlight"] = "5、高亮"
L["Blend (normal)"] = "混合效果（普通）"
L["Disable (opaque)"] = "禁用（不透明）"
L["Alpha Key (1-bit alpha)"] = "透明键（少量透明度）"
L["Mod Blend (modulative)"] = "模块混合（模块式）"
L["Add Blend (additive)"] = "添加混合（附加式）"
L["Borders"] = "边框"
L["Hide default border"] = "隐藏默认边框"
L["Hide the default border on the minimap."] = "隐藏小地图默认边框。"
L["Current Borders"] = "当前边框"
L["Enter a name to create a new border. The name can be anything you like to help you identify that border."] = "输入名称创建新边框。可以用任何你想用来帮助你识别此边框的名称。"
L["Create new border"] = "创建新边框"
L["Clear & start over"] = "重置"
L["Clear the current borders and start fresh"] = "清除当前边框并重新开始设置"
L["Background/edge"] = "背景/边缘"
L["You can set a background and edge file for the minimap like you would with any frame. This is useful when you want to create static square backdrops for your minimap."] = "为小地图设置背景和边缘可用任意框体。便于为小地图创建固定的方形背景图案。"
L["Enable"] = "启用"
L["Enable a backdrop and border for the minimap. This will let you set square borders more easily."] = "为小地图启用一个背景和边框。使设置方形边框变得更简单。"
L["Scale"] = "缩放"
L["Opacity"] = "不透明度"
L["Background Texture"] = "背景材质"
L["Texture"] = "材质"
L["Open TexBrowser"] = "打开 TexBrowser"
L["TexBrowser Not Installed"] = "没有安装 TexBrowser"
L["SharedMedia Texture"] = "SharedMedia 材质"
L["Tile background"] = "平铺背景"
L["Tile size"] = "平铺尺寸"
L["Backdrop color"] = "背景颜色"
L["Backdrop insets"] = "背景镶边"
L["Border Texture"] = "边框材质"
L["Border texture"] = "边框材质"
L["SharedMedia Border"] = "SharedMedia 边框"
L["Border color"] = "边框颜色"
L["Border edge size"] = "边框边缘尺寸"
L["Preset"] = "预设配置"
L["Select preset to load"] = "选择要加载的预设配置"
L["Select a preset to load settings from. This will erase any of your current borders."] = "选择一个预设配置。这样做会清除所有你当前正在使用的边框。"
L["This will wipe out any current settings!"] = "这样做将清除所有当前设置！"
L["Delete"] = "删除"
L["Really delete this preset? This can't be undone."] = "确定删除此预设效果？此操作将无法被恢复。"
L["Save current settings as preset..."] = "将当前设置保存为预设配置…"
L["Entry options"] = "基本设置"
L["Name"] = "名称"
L["Really delete this border?"] = "确定删除此边框效果？"
L["Texture path"] = "材质路径"
L["Enter the full path to a texture to use. It's recommended that you use something like |cffff6600TexBrowser|r to find textures to use."] = "输入完整的材质路径才能使用。建议使用类似 |cffff6600TexBrowser|r 的功能来找到需要使用材质。"
L["Texture options"] = "材质选项"
L["Rotation Speed"] = "旋转速度"
L["Speed to rotate the texture at. A setting of 0 turns off rotation."] = "材质旋转速度。设置为“0”时不旋转。"
L["Static Rotation"] = "固定旋转"
L["A static amount to rotate the texture by."] = "材质固定旋转量。"
L["Match player rotation"] = "随角色旋转"
L["Normal rotation"] = "正时针旋转"
L["Reverse rotation"] = "逆时针旋转"
L["Do not match player rotation"] = "不根据角色旋转"
L["Texture tint"] = "材质着色"
L["Horizontal nudge"] = "水平位移"
L["Vertical nudge"] = "垂直位移"
L["Layer"] = "层级"
L["Blend Mode"] = "混合模式"
L["Disable Rotation"] = "禁用旋转"
L["Force a square texture. Fixed distortion on square textures."] = "强制填充一个方形材质。修正方形材质上的变形失真。"

-- ./Buttons.lua
L["Addon Buttons"] = "插件按钮"
L["Standard Buttons"] = "系统按钮"
L["Capture New Buttons"] = "捕获新按钮"
L["Let SexyMap handle button dragging"] = "SexyMap 接管按钮拖动"
L["Allow SexyMap to assume drag ownership for buttons attached to the minimap. Turn this off if you have another mod that you want to use to position your minimap buttons."] = "允许 SexyMap 拖动依附在小地图上的按钮。如果你用其他的插件来拖动按钮，请关闭此功能。"
L["Lock Button Dragging"] = "锁定按钮拖动"
L["Let SexyMap control button visibility"] = "SexyMap 管理按钮可见性"
L["Turn this off if you want another mod to handle which buttons are visible on the minimap."] = "如果你用其他的插件来管理按钮是否显示在小地图，请关闭此功能。"
L["Drag Radius"] = "拖动半径"
L["Calendar"] = "日历"
L["Map Button"] = "地图按钮"
L["Tracking Button"] = "追踪按钮"
L["Zoom Buttons"] = "缩放按钮"
L["Clock"] = "时钟"
L["Close button"] = "关闭按钮"
L["Compass labels"] = "指南针"
L["New mail indicator"] = "新邮件提示"
L["Voice chat"] = "语音聊天"
L["Battlegrounds icon"] = "战场徽标"
L["Always"] = "总是"
L["Never"] = "从不"
L["On hover"] = "悬停时"

-- ./Coordinates.lua
L["Coordinates"] = "坐标"
L["Enable Coordinates"] = "启用坐标"
L["Settings"] = "设置"
L["Font size"] = "字体尺寸"
L["Lock"] = "锁定"
L["Font color"] = "字体颜色"
L["Reset position"] = "重置位置"

-- ./Fader.lua
L["Enabled"] = "已启用"
L["Enable fader functionality"] = "启用淡出功能"
L["Hover Opacity"] = "悬停不透明"
L["Normal Opacity"] = "普通不透明"

-- ./General.lua
L["Lock minimap"] = "锁定小地图"
L["Show movers"] = "显示锚点"
L["Clamp to screen"] = "固定在屏幕上"
L["Right click map to configure"] = "右击地图配置"
L["Armored Man"] = "耐久度"
L["Capture Bars"] = "占领进度条"
L["Vehicle Seat"] = "载具座位"

-- ./HudMap.lua
L["Enable a HUD minimap. This is very useful for gathering resources, but for technical reasons, the HUD map and the normal minimap can't be shown at the same time. Showing the HUD map will turn off the normal minimap."] = "启用 HUD 地图。这十分利于采集，但由于技术原因，HUD 地图和常规小地图无法同时显示。显示 HUD 地图将暂时关闭常规小地图。"
L["Keybinding"] = "按键绑定"
L["GatherMate is a resource gathering helper mod. Installing it allows you to have resource pins on your HudMap."] = "GatherMate 是一款采集助手类插件。安装 GatherMate 可以在 HUD 地图上显示资源点。"
L["Use GatherMate pins"] = "显示 GatherMate 资源点"
L["Use QuestHelper pins"] = "使用 QuestHelper 资源点"
L["Routes plots the shortest distance between resource nodes. Install it to show farming routes on your HudMap."] = "显示最近的资源点间的采集路线。加载此功能可在 HUD 地图上显示采集路线。"
L["Use Routes"] = "显示路线"
L["HUD Color"] = "HUD 颜色"
L["Text Color"] = "文本颜色"

-- ./moduleTemplate.lua
-- no localization

-- ./oldBorders.lua
-- no localization

-- ./Ping.lua
L["Show who pinged"] = "显示谁点击了小地图"
L["Show..."] = "显示到…"
L["On minimap"] = "小地图"
L["In chat"] = "聊天栏"

-- ./SexyMap.lua
L["Profiles"] = "配置文件"

-- ./Shapes.lua
L["Circle"] = "圆形"
L["Faded Circle (Small)"] = "圆形淡出（小）"
L["Faded Circle (Large)"] = "圆形淡出（大）"
L["Faded Square"] = "方形淡出"
L["Diamond"] = "钻石形"
L["Square"] = "方形"
L["Heart"] = "心形"
L["Octagon"] = "八边形"
L["Hexagon"] = "六边形"
L["Snowflake"] = "雪花形"
L["Route 66"] = "66路形"
L["Rounded - Bottom Right"] = "方形圆角-右下"
L["Rounded - Bottom Left"] = "方形圆角-左下"
L["Rounded - Top Right"] = "方形圆角-右上"
L["Rounded - Top Left"] = "方形圆角-左上"
L["Minimap shape"] = "小地图外形"

-- ./Snap.lua
-- no localization

-- ./ZoneText.lua
L["Horizontal position"] = "水平位置"
L["Vertical position"] = "垂直位置"
L["Width"] = "宽度"
L["Background color"] = "背景颜色"
L["Font"] = "字体"
L["Font Size"] = "字体尺寸"

-- ./localization/enUS.lua
-- no localization

-- ./localization/zhCN.lua
-- no localization

-- ./localization/zhTW.lua
-- no localization

