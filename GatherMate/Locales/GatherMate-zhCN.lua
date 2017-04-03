-- GatherMate Locale
-- Please use the Localization App on WoWAce to Update this
-- http://www.wowace.com/projects/gathermate/localization/ ;¶

local L = LibStub("AceLocale-3.0"):NewLocale("GatherMate", "zhCN")
if not L then return end

L["Add this location to Cartographer_Waypoints"] = "将该地点加入Cartographer_Waypoints"
L["Add this location to TomTom waypoints"] = "将该地点加入TomTom节点"
L["Always show"] = "总是显示"
L["Are you sure you want to delete all nodes from this database?"] = "你确认你想要删除这个数据库的所有数据？"
L["Are you sure you want to delete all of the selected node from the selected zone?"] = "你确认要删除已选中地区的所有已选中的节点？"
L["Auto Import"] = "自动导入"
L["Auto import complete for addon "] = "自动导入数据源："
L["Automatically import when ever you update your data module, your current import choice will be used."] = "当你升级你的数据模块的时候自动导入升级后的数据，你当前的导入选项将控制导入的数据类型。"
L["CLEANUP_RADIUS_DESC"] = "设置以码为单位的半径，在半径内的数据将被清除。默认设置为 |cffffd20050|r 码(气体云雾)/ |cffffd20015|r 码（其他采集数据）。这些设置也被用于增加的节点。"
L["Cleanup Complete."] = "清理结束！"
L["Cleanup Database"] = "清理数据"
L["Cleanup radius"] = "清理半径"
L["Cleanup your database by removing duplicates. This takes a few moments, be patient."] = "清理你的数据库，移除重复数据。这个过程可能持续几分钟，请耐心等待。"
L["Cleanup_Desc"] = "经过一段时间后，你的数据库可能会非常大，清理数据可以让你的相同专业的在一定范围内的数据合并为一个，以避免重复。"
L["Clear node selections"] = "清除选择的节点"
L["Color of the tracking circle."] = "追踪环的颜色。"
L["Control various aspects of node icons on both the World Map and Minimap."] = "控制你想要在世界地图和迷你地图上显示的多种节点图标。"
L["DATABASE_LOCKING_DESC"] = "锁定数据库选项将冻结你的数据库状态。一旦你锁定了数据库，对其任何操作(增加节点、删除节点、修改节点包括清理数据库和导入数据库)均不可用。"
L["DELETE_ENTIRE_DESC"] = "这个选项将会忽略数据库的锁定设置，删除所有选中的数据库的数据！"
L["DELETE_SPECIFIC_DESC"] = "从选定区域清除所有选定的节点.你必须先行解除数据库锁定."
L["Database Locking"] = "数据库锁定"
L["Database Maintenance"] = "数据库选项"
L["Database locking"] = "数据库已被锁定"
L["Databases to Import"] = "导入的数据库"
L["Databases you wish to import"] = "你想要导入的数据库"
L["Delete"] = "删除"
L["Delete Entire Database"] = "删除整个数据库"
L["Delete Specific Nodes"] = "删除特定节点"
L["Delete selected node from selected zone"] = "从选择的地区删除选择的节点"
L["Display Settings"] = "显示设置"
L["Engineering"] = "工程学"
L["Expansion"] = "资料片"
L["Expansion Data Only"] = "仅资料片数据"
L["FAQ"] = "FAQ"
L["FAQ_TEXT"] = [=[|cffffd200
我安装了GatherMate，但是却不能在地图上看见任何节点，这是怎么回事？
|r
GatherMate本身是不包含任何数据的，你如果想要数据，可以安装GatherMate_Data并导入数据库。GatherMate的工作原理是，当你采集任何资源，包括草药，矿脉，采集气体或者钓鱼的时候将该点记录下来，然后在地图上标出。另外，你也要查看你的显示选项是否设置正确。

|cffffd200
我在世界地图上看到了节点，但是在迷你地图上却没有，这是为什么？
|r
|cffffff78Minimap Button Bag|r (或者类似的插件) 很可能会把你所有的迷你地图按钮收起，禁用它们！

|cffffd200
我在哪里可以找到数据库下载啊？
|r
你可以通过以下途径获取GatherMate的数据库:

1. |cffffff78GatherMate_Data|r - 这个插件是WoWHead网站的数据库的GatherMate版本，它每周都更新一次，你可以打开自动更新选项，在其更新后，自动更新你的数据库。

2. |cffffff78GatherMate_CartImport|r - 这个插件将导入 |cffffff78Cartographer_<Profession>|r 已存在的数据库到GatherMate。你必须保证GatherMate_CartImport和 |cffffff78Cartographer_<Profession>|r 同时启用才可进行导入工作。

注意：该导入动作不是自动进行的，你必须进入“导入数据”选项，然后点击“导入”按钮。

如果 |cffffff78Cartographer_Data|r 中的数据和GatherMate数据不符，用户将被提示选择数据库修改的方式, |cffffff78Cartographer_Data|r载入时，可能会导致你新建立的节点在不被警告的自动覆盖！

|cffffd200
你可以增加邮箱或者飞行管理员的数据支持么？
|r
不，我不会。尽管可能会有其他的作者以插件的形式支持，但是GatherMate的核心组件将不会支持该功能。

|cffffd200
我发现一处Bug！我到哪里去报告啊？
|r
你可以到如下网址反应Bug和提供建议: |cffffff78http://www.wowace.com/forums/index.php?topic=10990.0|r

你也可以在这里找到我们： |cffffff78irc://irc.freenode.org/wowace|r

当反应Bug的时候，请确认你在|cffffff78何种步骤|r下产生的该Bug，并尽可能提供所有的|cffffff78错误信息|r，并请提供出错的GatherMate|cffffff78版本号|r，以及你当是使用的|cffffff78魔兽世界的客户端语言|r。

|cffffd200
谁写出了这么Cool的插件？
|r
Kagaro, Xinhuan, Nevcairiel 以及 Ammo
]=]
L["Failed to load GatherMateData due to "] = "载入GatherMateData失败："
L["Filter_Desc"] = "选择你想要在世界地图和迷你地图上显示的节点类型，不选择的类型将仅记录在数据库中。"
L["Filters"] = "过滤"
L["Fish filter"] = "渔点过滤"
L["Fishes"] = "渔点"
L["Fishing"] = "钓鱼"
L["Frequently Asked Questions"] = "常见问题解答"
L["Gas Clouds"] = "气体云雾"
L["Gas filter"] = "气体云雾过滤"
L["GatherMate Pin Options"] = "GatherMate Pin选项"
L["GatherMateData has been imported."] = "GatherMateData已经被导入。"
L["General"] = "一般设置"
L["Herb Bushes"] = "草药"
L["Herb filter"] = "草药过滤"
L["Herbalism"] = "草药学"
L["Icon Alpha"] = "图标透明度"
L["Icon Scale"] = "图标缩放"
L["Icon alpha value, this lets you change the transparency of the icons. Only applies on World Map."] = "图标透明度，这个选项让你更改图标的透明度，仅作用于世界地图！"
L["Icon scaling, this lets you enlarge or shrink your icons on both the World Map and Minimap."] = "图标缩放，这个选项让你把世界地图和迷你地图上的图标放大或缩小。"
L["Icons"] = "图标"
L["Import Data"] = "导入数据"
L["Import GatherMateData"] = "导入GatherMateData"
L["Import Options"] = "导入选项"
L["Import Style"] = "导入模式"
L["Importing_Desc"] = "导入允许GatherMate从其他来源获取节点数据。导入结束后，你最好进行一次数据清理。"
L["Keybind to toggle Minimap Icons"] = "给迷你地图图标的显示设置按键绑定。"
L["Load GatherMateData and import the data to your database."] = "载入GatherMateData并把其中的数据导入你的数据库"
L["Merge"] = "合并"
L["Merge will add GatherMateData to your database. Overwrite will replace your database with the data in GatherMateData"] = "合并将GatherMateDate数据加入你的数据库，覆盖将用GatherMateData中的数据替换你现有的数据库"
L["Mine filter"] = "矿脉过滤"
L["Mineral Veins"] = "矿脉"
L["Minimap Icon Tooltips"] = "迷你地图图标的鼠标提示"
L["Mining"] = "采矿"
L["Never show"] = "从不显示"
L["Only import selected expansion data from WoWDB"] = "仅从WoWDB导入选中的资料片数据"
L["Only while tracking"] = "仅显示追踪相关"
L["Only with profession"] = "仅显示专业相关"
L["Overwrite"] = "覆盖"
L["Processing "] = "处理 "
L["Select All"] = "全部选择"
L["Select Database"] = "选择数据库"
L["Select Node"] = "选择节点"
L["Select None"] = "清空选择"
L["Select Zone"] = "选择地区"
L["Select all nodes"] = "选择全部节点"
L["Select the fish nodes you wish to display."] = "选择你想要显示的渔点节点。"
L["Select the gas clouds you wish to display."] = "选择你想要显示的气体云雾节点。"
L["Select the herb nodes you wish to display."] = "选择你想要显示的草药节点。"
L["Select the mining nodes you wish to display."] = "选择你想要显示的矿脉节点。"
L["Select the treasure you wish to display."] = "选择你想要显示的财宝节点。"
L["Selected databases are shown on both the World Map and Minimap."] = "选择在世界地图和迷你地图上显示数据。"
L["Show Databases"] = "显示数据"
L["Show Fishing Nodes"] = "显示鱼群"
L["Show Gas Clouds"] = "显示气云"
L["Show Herbalism Nodes"] = "显示草药"
L["Show Minimap Icons"] = "显示迷你地图图标"
L["Show Mining Nodes"] = "显示矿脉"
L["Show Nodes on Minimap Border"] = "迷你地图边界显示"
L["Show Tracking Circle"] = "显示追踪环"
L["Show Treasure Nodes"] = "显示宝藏"
L["Show World Map Icons"] = "显示世界地图图标"
L["Shows more Nodes that are currently out of range on the minimap's border."] = "在迷你地图边界上显示哪些超出迷你地图的节点。"
L["The Burning Crusades"] = "燃烧的远征"
L["The Frozen Sea"] = "冰冻之海"
L["The North Sea"] = "北海"
L["The distance in yards to a node before it turns into a tracking circle"] = "在一个节点变成追踪环之前的距离。"
L["Toggle showing Minimap icon tooltips."] = "打开\\关闭 迷你地图图标的鼠标提示。"
L["Toggle showing Minimap icons."] = "切换显示图标与否(在小地图上)。"
L["Toggle showing World Map icons."] = "切换显示图标与否(在世界地图上)。"
L["Toggle showing fishing nodes."] = "切换显示鱼群垂钓点。"
L["Toggle showing gas clouds."] = "切换显示气云(微粒采集点)。"
L["Toggle showing herbalism nodes."] = "切换显示草药采集点。"
L["Toggle showing mining nodes."] = "切换显示矿脉采集点。"
L["Toggle showing the tracking circle."] = "切换是否显示追踪环。"
L["Toggle showing treasure nodes."] = "切换显示财宝地点。"
L["Tracking Circle Color"] = "追踪环颜色"
L["Tracking Distance"] = "追踪距离"
L["Treasure"] = "财宝"
L["Treasure filter"] = "财宝过滤"
L["Wrath of the Lich King"] = "巫妖王之怒"


local NL = LibStub("AceLocale-3.0"):NewLocale("GatherMateNodes", "zhCN")
if not NL then return end

NL["Abundant Bloodsail Wreckage"] = "大型的血帆残骸" -- Needs review
NL["Abundant Firefin Snapper School"] = "大型的火鳞鳝鱼群" -- Needs review
NL["Abundant Oily Blackmouth School"] = "大型的黑口鱼群" -- Needs review
NL["Adamantite Bound Chest"] = "加固精金宝箱"
NL["Adamantite Deposit"] = "精金矿脉"
NL["Adder's Tongue"] = "蛇信草"
NL["Arcane Vortex"] = "奥术漩涡"
NL["Arctic Cloud"] = "北极云雾"
NL["Arthas' Tears"] = "阿尔萨斯之泪"
NL["Battered Chest"] = "破损的箱子"
NL["Battered Footlocker"] = "破碎的提箱"
NL["Black Lotus"] = "黑莲花"
NL["Blindweed"] = "盲目草"
NL["Blood of Heroes"] = "英雄之血"
NL["Bloodpetal Sprout"] = "血瓣花苗"
NL["Bloodsail Wreckage"] = "血帆残骸"
NL["Bloodthistle"] = "血蓟"
NL["Bluefish School"] = "蓝鱼群"
NL["Borean Man O' War School"] = "北风水母群"
NL["Bound Fel Iron Chest"] = "加固魔铁宝箱"
NL["Brackish Mixed School"] = "混水鱼类"
NL["Briarthorn"] = "石南草"
NL["Brightly Colored Egg"] = "明亮的彩蛋"
NL["Bruiseweed"] = "跌打草"
NL["Buccaneer's Strongbox"] = "海盗的保险箱"
NL["Burial Chest"] = "埋起来的箱子"
NL["Cinder Cloud"] = "Cinder Cloud"
NL["Cobalt Deposit"] = "钴矿脉"
NL["Copper Vein"] = "铜矿"
NL["Dark Iron Deposit"] = "黑铁矿脉"
NL["Deep Sea Monsterbelly School"] = "深海巨腹鱼群"
NL["Dented Footlocker"] = "凹陷的提箱"
NL["Dragonfin Angelfish School"] = "龙鳞天使鱼群"
NL["Dreamfoil"] = "梦叶草"
NL["Dreaming Glory"] = "梦露花"
NL["Earthroot"] = "地根草"
NL["Everfrost Chip"] = "永冻薄片"
NL["Fadeleaf"] = "枯叶草"
NL["Fangtooth Herring School"] = "利齿青鱼群"
NL["Fel Iron Chest"] = "魔铁宝箱"
NL["Fel Iron Deposit"] = "魔铁矿脉"
NL["Felmist"] = "魔雾"
NL["Felsteel Chest"] = "魔钢宝箱"
NL["Feltail School"] = "斑点魔尾鱼群" -- Needs review
NL["Felweed"] = "魔草"
NL["Firebloom"] = "火焰花"
NL["Firefin Snapper School"] = "火鳞鳝鱼群"
NL["Firethorn"] = "火棘"
NL["Flame Cap"] = "烈焰菇"
NL["Floating Debris"] = "漂浮的碎片"
NL["Floating Wreckage"] = "漂浮的残骸"
-- NL["Floating Wreckage Pool"] = "Floating Wreckage Pool"
NL["Frost Lotus"] = "雪莲花"
NL["Frozen Herb"] = "冰冷的草药"
NL["Ghost Mushroom"] = "幽灵菇"
NL["Giant Clam"] = "巨型贝壳"
NL["Glacial Salmon School"] = "冰河鲑鱼群"
NL["Glassfin Minnow School"] = "亮鳞鲤鱼群" -- Needs review
NL["Glowcap"] = "亮顶蘑菇"
NL["Gold Vein"] = "金矿石"
NL["Goldclover"] = "金苜蓿"
NL["Golden Sansam"] = "黄金参"
NL["Goldthorn"] = "金棘草"
NL["Grave Moss"] = "墓地苔"
NL["Greater Sagefish School"] = "大型鼠尾鱼群"
NL["Gromsblood"] = "格罗姆之血"
NL["Heavy Fel Iron Chest"] = "重型魔铁宝箱"
NL["Highland Mixed School"] = "高地杂鱼群"
NL["Icecap"] = "冰盖草"
NL["Icethorn"] = "冰棘草"
NL["Imperial Manta Ray School"] = "帝王鳐鱼群" -- Needs review
NL["Incendicite Mineral Vein"] = "火岩矿脉"
NL["Indurium Mineral Vein"] = "精铁矿脉"
NL["Iron Deposit"] = "铁矿石"
NL["Khadgar's Whisker"] = "卡德加的胡须"
NL["Khorium Vein"] = "氪金矿脉"
NL["Kingsblood"] = "皇血草"
NL["Large Battered Chest"] = "破损的大箱子"
NL["Large Darkwood Chest"] = "大型黑木箱"
NL["Large Iron Bound Chest"] = "大型铁箍储物箱"
NL["Large Mithril Bound Chest"] = "大型秘银储物箱"
NL["Large Solid Chest"] = "坚固的大箱子"
NL["Lesser Bloodstone Deposit"] = "次级血石矿脉"
NL["Lesser Firefin Snapper School"] = "次级火鳞鳝鱼群" -- Needs review
NL["Lesser Floating Debris"] = "次级漂浮的碎片" -- Needs review
NL["Lesser Oily Blackmouth School"] = "次级黑口鱼群" -- Needs review
NL["Lesser Sagefish School"] = "次级鼠尾鱼群" -- Needs review
NL["Lichbloom"] = "巫妖花"
NL["Liferoot"] = "活根草"
NL["Mageroyal"] = "魔皇草"
NL["Mana Thistle"] = "法力蓟"
NL["Mithril Deposit"] = "秘银矿脉"
NL["Moonglow Cuttlefish School"] = "月光墨鱼群" -- Needs review
NL["Mossy Footlocker"] = "生苔的提箱"
NL["Mountain Silversage"] = "山鼠草"
NL["Mudfish School"] = "泥鱼群"
NL["Musselback Sculpin School"] = "蚌背鱼群" -- Needs review
NL["Netherbloom"] = "虚空花"
NL["Nethercite Deposit"] = "虚空矿脉"
NL["Netherdust Bush"] = "灵尘灌木丛"
NL["Netherwing Egg"] = "灵翼龙卵"
NL["Nettlefish School"] = "水母鱼群" -- Needs review
NL["Nightmare Vine"] = "噩梦藤"
NL["Oil Spill"] = "油井"
NL["Oily Blackmouth School"] = "黑口鱼群"
NL["Ooze Covered Gold Vein"] = "软泥覆盖的金矿脉"
NL["Ooze Covered Mithril Deposit"] = "软泥覆盖的秘银矿脉"
NL["Ooze Covered Rich Thorium Vein"] = "软泥覆盖的富瑟银矿脉"
NL["Ooze Covered Silver Vein"] = "软泥覆盖的银矿脉"
NL["Ooze Covered Thorium Vein"] = "软泥覆盖的瑟银矿脉"
NL["Ooze Covered Truesilver Deposit"] = "软泥覆盖的真银矿脉"
NL["Patch of Elemental Water"] = "元素之水"
NL["Peacebloom"] = "宁神花"
NL["Plaguebloom"] = "瘟疫花"
NL["Practice Lockbox"] = "练习用保险箱"
NL["Primitive Chest"] = "粗糙的箱子"
NL["Pure Water"] = "纯水"
NL["Purple Lotus"] = "紫莲花"
NL["Ragveil"] = "邪雾草"
NL["Rich Adamantite Deposit"] = "富精金矿脉"
NL["Rich Cobalt Deposit"] = "富钴矿脉"
NL["Rich Saronite Deposit"] = "富蓝铜矿脉"
NL["Rich Thorium Vein"] = "富瑟银矿脉"
NL["Sagefish School"] = "鼠尾鱼群"
NL["Saronite Deposit"] = "蓝铜矿脉"
NL["Scarlet Footlocker"] = "血色十字军提箱"
NL["School of Darter"] = "金镖鱼群"
NL["School of Deviate Fish"] = "变异鱼群"
NL["School of Tastyfish"] = "可口鱼"
NL["Schooner Wreckage"] = "帆船残骸"
NL["Silver Vein"] = "银矿"
NL["Silverleaf"] = "银叶草"
NL["Small Thorium Vein"] = "瑟银矿脉"
NL["Solid Chest"] = "坚固的箱子"
NL["Solid Fel Iron Chest"] = "坚固的魔铁宝箱"
NL["Sparse Firefin Snapper School"] = "稀疏的火鳞鳝鱼群" -- Needs review
NL["Sparse Oily Blackmouth School"] = "稀疏的黑口鱼群" -- Needs review
-- NL["Sparse Schooner Wreckage"] = "Sparse Schooner Wreckage"
NL["Sporefish School"] = "孢子鱼群"
NL["Steam Cloud"] = "Steam Cloud"
NL["Steam Pump Flotsam"] = "蒸汽泵废料"
NL["Stonescale Eel Swarm"] = "石鳞鳗群"
NL["Strange Pool"] = "奇怪的水池"
NL["Stranglekelp"] = "荆棘藻"
NL["Sungrass"] = "太阳草"
NL["Swamp Gas"] = "沼泽毒气"
NL["Talandra's Rose"] = "塔兰德拉的玫瑰"
NL["Tattered Chest"] = "联盟宝箱"
NL["Teeming Firefin Snapper School"] = "拥挤的火鳞鳝鱼群" -- Needs review
NL["Teeming Floating Wreckage"] = "拥挤的漂浮残骸" -- Needs review
NL["Teeming Oily Blackmouth School"] = "拥挤的黑口鱼群" -- Needs review
NL["Terocone"] = "泰罗果"
NL["Tiger Lily"] = "虎百合"
NL["Tin Vein"] = "锡矿"
NL["Titanium Vein"] = "泰坦钢矿"
NL["Truesilver Deposit"] = "真银矿石"
NL["Un'Goro Dirt Pile"] = "安戈落泥土堆"
NL["Waterlogged Footlocker"] = "浸水的提箱"
NL["Waterlogged Wreckage"] = "浸水的残骸" -- Needs review
NL["Wicker Chest"] = "柳条箱"
NL["Wild Steelbloom"] = "野钢花"
NL["Windy Cloud"] = "气体云雾"
NL["Wintersbite"] = "冬刺草"

