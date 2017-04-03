if not ACP then return end

if (GetLocale() == 	"zhCN") then
	ACP:UpdateLocale( {
		["Reload your User Interface?"] = "重载插件？",
		["Save the current addon list to [%s]?"] = "保存当前插件设置为[%s]？",
		["Enter the new name for [%s]:"] = "输入[%s]的新名字：",
		["Addons [%s] Saved."] = "插件设置[%s]已保存。",
		["Addons [%s] Unloaded."] = "插件设置[%s]已卸载。",
		["Addons [%s] Loaded."] = "插件设置[%s]已加载。",
		["Addons [%s] renamed to [%s]."] = "插件设置[%s]已改名为[%s]。",
		["Loaded on demand."] = "需要时加载。",
		["AddOns"] = "插件管理",
		["Load"] = "加载",
		["Disable All"] = "全部禁用",
		["Enable All"] = "全部启用",
		["ReloadUI"] = "重载插件",
		["Sets"] = "配置",
		["No information available."] = "无可用信息。",
		["Loaded"] = "已加载",
		["Recursive"] = "递归",
		["Loadable OnDemand"] = "需要时加载",
		["Disabled on reloadUI"] = "重载插件后禁用",
		["Default"] = "默认";
		["Set "] = "配置：";
		["Save"] = "保存";
		["Load"] = "加载";
		["Add to current selection"] = "添加当前选择";
		["Remove from current selection"] = "移除当前选择";
		["Rename"] = "重命名";
		["Use SHIFT to override the current enabling of dependancies behaviour."] = "使用 Shift 键无视目前的递归设定。",
		["Click to enable protect mode. Protected addons will not be disabled"] = "点击启用保护模式。受保护插件不会被禁用。",
		["when performing a reloadui."]="重载插件时。",
		["ACP: Some protected addons aren't loaded. Reload now?"]="ACP：部分受保护插件没有被加载。现在重载插件么？",
		["Active Embeds"] = "单独使用",
		["Memory Usage"] = "内存占用",

		["Blizzard_AchievementUI"] = "Blizzard: Achievement",
		["Blizzard_AuctionUI"] = "Blizzard: Auction",
		["Blizzard_BarbershopUI"] = "Blizzard: Barbershop",
		["Blizzard_BattlefieldMinimap"] = "Blizzard: Battlefield Minimap",
		["Blizzard_BindingUI"] = "Blizzard: Binding",
		["Blizzard_Calendar"] = "Blizzard: Calendar",
		["Blizzard_CombatLog"] = "Blizzard: Combat Log",
		["Blizzard_CombatText"] = "Blizzard: Combat Text",
		["Blizzard_FeedbackUI"] = "Blizzard: Feedback",
		["Blizzard_GlyphUI"] = "Blizzard: Glyph",
		["Blizzard_GMSurveyUI"] = "Blizzard: GM Survey",
		["Blizzard_GuildBankUI"] = "Blizzard: GuildBank",
		["Blizzard_InspectUI"] = "Blizzard: Inspect",
		["Blizzard_ItemSocketingUI"] = "Blizzard: Item Socketing",
		["Blizzard_MacroUI"] = "Blizzard: Macro",
		["Blizzard_RaidUI"] = "Blizzard: Raid",
		["Blizzard_TalentUI"] = "Blizzard: Talent",
		["Blizzard_TimeManager"] = "Blizzard: TimeManager",
		["Blizzard_TokenUI"] = "Blizzard: Token",
		["Blizzard_TradeSkillUI"] = "Blizzard: Trade Skill",
		["Blizzard_TrainerUI"] = "Blizzard: Trainer",
		["Blizzard_VehicleUI"] = "Blizzard: Vehicle",

		["*** Enabling <%s> %s your UI ***"] = "*** 启用 <%s>，%s 你的插件 ***";
		["*** Unknown Addon <%s> Required ***"] = "*** 需要未知插件 <%s> ***";
		["LoD Child Enable is now %s"] = "需要时加载的子插件：%s";
		["Recursive Enable is now %s"] = "递归加载的插件：%s";
		["Addon <%s> not valid"] = "无效的插件：<%s>",
		["Reload"] = "重载";
		["Author"] = "作者";
		["Version"] = "版本";
		["Status"] = "状态";
		["Dependencies"] = "依赖";
		["Embeds"] = "内置";
		["Close"] = "关闭";
		} )
end
