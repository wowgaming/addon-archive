--[[

Skillet: A tradeskill window replacement.
Copyright (c) 2007 Robert Clark <nogudnik@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

]]--

-- Localization provided by Shadowsongs

-- If you are doing localization and would like your name added here, please feel free
-- to do so, or let me know and I will be happy to add you to the credits

local L = AceLibrary("AceLocale-2.2"):new("Skillet")

L:RegisterTranslations("zhCN", function() return {
    ["Skillet Trade Skills"] = "Skillet Trade Skills", -- default message
    ["Create"] = "制造",
    ["Queue All"] = "队列所有",
    ["Create All"] = "全部制造",
    ["Create"] = "制造",
    ["Queue"] = "队列",
    ["Enchant"] = "附魔",
    ["Rescan"] = "重新扫描",
    ["Number of items to queue/create"] = "队列/制造 的物品数量数量",
    ["buyable"] = "可购买",
    ["reagents in inventory"] = "背包中的材料",
    ["bank"] = "银行",-- "reagents in bank"
    ["alts"] = "小计",-- "reagents on alts"
    ["can be created from reagents in your inventory"] = "可由背包中的材料制造",
    ["can be created from reagents in your inventory and bank"] = "可由背包与银行中的材料制造",
    ["can be created from reagents on all characters"] = "可由所有人物的材料制造",
    ["Scanning tradeskill"] = "扫描商业技能中...",
    ["Scan completed"] = "扫描完成",
    ["Filter"] = "筛选",
    ["Hide uncraftable"] = "隐藏不能制作的",
    ["Hide trivial"] = "隐藏无价值的",
    ["Options"] = "选项",
    ["Notes"] = "注释",
    ["Purchased"] = "已购买的",
    ["Total spent"] = "总计",
    ["This merchant sells reagents you need!"] = "这个商人出售你所需的材料!",
    ["Buy Reagents"] = "购买材料",
    ["click here to add a note"] = "点击这里来添加注释",
    ["not yet cached"] = "未缓存",

    -- Options
    ["About"]						=  "关于",
    ["ABOUTDESC"]					= "显示Skillet简介",
    ["Config"]						= "设定",
    ["CONFIGDESC"]					= "显示Skillet的设定窗口",
    ["Shopping List"]					= "购物清单",
    ["SHOPPINGLISTDESC"]				= "显示购物清单",

    ["Features"]					= "功能",
    ["FEATURESDESC"]					= "可选择是否启用的额外功能",
    ["VENDORBUYBUTTONNAME"]				= "在商人窗口显示购买按钮",
    ["VENDORBUYBUTTONDESC"]				= "开启商人对话窗口时，显示购买按钮，以便购买队列中需要的材料.",
    ["VENDORAUTOBUYNAME"]				= "自动购买材料",
    ["VENDORAUTOBUYDESC"]				= "拜访商人时自动购买队列中配方所需材料.",
    ["SHOWITEMNOTESTOOLTIPNAME"]			= "在提示信息中增加自定义注释",
    ["SHOWITEMNOTESTOOLTIPDESC"]			= "在那个物品的提示信息中增加自定义注释",
    ["SHOWDETAILEDRECIPETOOLTIPNAME"]			= "显示详细的配方提示信息",
    ["SHOWDETAILEDRECIPETOOLTIPDESC"]			= "鼠标指向配方时，在左边显示详细提示信息",
    ["LINKCRAFTABLEREAGENTSNAME"]			= "开启点击追踪材料",
    ["LINKCRAFTABLEREAGENTSDESC"]			= "如果你可以制造配方所需材料, 点击那个材料会显示材料的配方.",
    ["QUEUECRAFTABLEREAGENTSNAME"]			= "将可制造的材料加入队列",
    ["QUEUECRAFTABLEREAGENTSDESC"]			= "如果你可以制造当前配方所需材料, 但是不够, 那么该材料会被加入队列",
    ["DISPLAYSHOPPINGLISTATBANKNAME"]			= "在银行显示购物清单",
    ["DISPLAYSHOPPINGLISTATBANKDESC"]			= "为队列配方中所需,但不在你背包中的材料显示一个清单",
    ["DISPLAYSGOPPINGLISTATAUCTIONNAME"]		= "在AH显示购物清单",
    ["DISPLAYSGOPPINGLISTATAUCTIONDESC"]		= "为队列配方中所需,但不在你背包中的材料显示一个清单",

    ["Appearance"]					= "外观",
    ["APPEARANCEDESC"]					= "控制 Skillet 显示方式的选项",
    ["DISPLAYREQUIREDLEVELNAME"]			= "显示需要等级",
    ["DISPLAYREQUIREDLEVELDESC"]			= "如果要制造的物品需要更高的等级来使用, 该等级会显示在配方旁",
    ["Transparency"]					= "透明度",
    ["TRANSPARAENCYDESC"]				= "商业技能窗口透明度",

    -- New in version 1.6
    ["Shopping List"]               = "购物清单",
    ["Retrieve"]                    = "收回",
    ["Include alts"]                = "包括其他人物",

    -- New in vesrsion 1.9
    ["Start"]                       = "开始",
    ["Pause"]                       = "暂停",
    ["Clear"]                       = "清除",
    ["None"]                        = "无",
    ["By Name"]                     = "根据名称",
    ["By Difficulty"]               = "根据难度",
    ["By Level"]                    = "根据等级",
	["Scale"]                       = "大小",
    ["SCALEDESC"]                   = "专业技能窗口大小 (默认值 1.0)",
    ["Could not find bag space for"] = "背包无可用空格",
    ["SORTASC"]                     = "递减排序",   -- Sort the recipe list from highest (top) to lowest (bottom)
    ["SORTDESC"]                    = "递增排序",   -- Sort the recipe list from lowest (top) to highest (bottom)
    ["By Quality"]                  = "根据质量",

    -- New in version 1.10
    ["Inventory"]                   = "背包",
    ["INVENTORYDESC"]               = "背包信息",
    ["Supported Addons"]            = "兼容插件",
    ["Selected Addon"]              = "已选择插件",
    ["Library"]                     = "函数库",
    ["SUPPORTEDADDONSDESC"]         = "能监视背包或正在监视背包的兼容插件",
    -- ["SHOWBANKALTCOUNTSNAME"]       = "Include bank and alt character contents",
    -- ["SHOWBANKALTCOUNTSDESC"]       = "When calculating and displaying craftable itemn counts, include items from your bank and from your other characters",
    -- ["ENHANCHEDRECIPEDISPLAYNAME"]  = "Show recipe difficulty as text",
    -- ["ENHANCHEDRECIPEDISPLAYDESC"]  = "When enabled, recipe names will have one or more '+' characters appeneded to their name to inidcate the difficulty of the recipe.",
    -- ["SHOWCRAFTCOUNTSNAME"]         = "Show craftable counts",
    -- ["SHOWCRAFTCOUNTSDESC"]         = "Show the number of times you can craft a recipe, not the total number of items producable",

    -- New in version 1.11
    ["Crafted By"]                  = "Crafted by",

 } end)
