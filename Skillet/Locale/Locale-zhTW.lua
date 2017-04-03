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

-- Chinese Traditional localizations provided by Purple and whocare@TW

-- If you are doing localization and would like your name added here, please feel free
-- to do so, or let me know and I will be happy to add you to the credits

local L = AceLibrary("AceLocale-2.2"):new("Skillet")

L:RegisterTranslations("zhTW", function() return {
    ["Skillet Trade Skills"]    = "專業助手", -- default message
    ["Create"]                  = "製造",
    ["Queue All"]               = "全部排程",
    ["Create All"]              = "全部製造",
    ["Create"]                  = "製造",
    ["Queue"]                   = "排程",
    ["Enchant"]                 = "附魔",
    ["Rescan"]                  = "掃描",
    ["Number of items to queue/create"] = "預計製造/排程的物品數量",
    ["buyable"]                 = "可購買",
    ["reagents in inventory"]   = "庫存材料",
    ["bank"]                    = "銀行", -- "reagents in bank"
    ["alts"]                    = "分身", -- "reagents on alts"
    ["can be created from reagents in your inventory"]          = "可用背包內的材料製造",
    ["can be created from reagents in your inventory and bank"] = "可用背包及銀行內的材料製造",
    ["can be created from reagents on all characters"]          = "可用其他角色的庫存材料製造",
    ["Scanning tradeskill"]     = "掃描專業技能",
    ["Scan completed"]          = "掃描結束",
    ["Filter"]                  = "篩選",
    ["Hide uncraftable"]        = "顯示可製造",
    ["Hide trivial"]            = "隱藏灰色",
    ["Options"]                 = "選項",
    ["Notes"]                   = "註釋",
    ["Purchased"]               = "已購買",
    ["Total spent"]             = "總價",
    ["This merchant sells reagents you need!"] = "這個商人有賣你所需要的材料!",
    ["Buy Reagents"]            = "購買材料",
    ["click here to add a note"] = "點擊新增註釋",
    ["not yet cached"]          = "尚未暫存",

    -- Options
    ["About"]             = "關於",
    ["ABOUTDESC"]         = "顯示Skillet簡介",
    ["Config"]            = "設定",
    ["CONFIGDESC"]        = "顯示Skillet的設定視窗",
    ["Shopping List"]     = "購物清單",
    ["SHOPPINGLISTDESC"]  = "顯示購物清單",

    ["Features"]                          = "功能",
    ["FEATURESDESC"]                      = "可選擇是否啟用的額外功能",
    ["VENDORBUYBUTTONNAME"]               = "在商人視窗顯示購買按鈕",
    ["VENDORBUYBUTTONDESC"]               = "與商人對話時，顯示購買按鈕以便採購排程所需材料.",
    ["VENDORAUTOBUYNAME"]                 = "自動購買材料",
    ["VENDORAUTOBUYDESC"]                 = "與商人對話時自動購買排程中所需材料",
    ["SHOWITEMNOTESTOOLTIPNAME"]          = "在提示訊息中增加自定註釋",
    ["SHOWITEMNOTESTOOLTIPDESC"]          = "在物品提示訊息中增加自定註釋",
    ["SHOWDETAILEDRECIPETOOLTIPNAME"]     = "顯示配方的詳細提示訊息",
    ["SHOWDETAILEDRECIPETOOLTIPDESC"]     = "滑鼠指向配方時顯示詳細提示訊息",
    ["LINKCRAFTABLEREAGENTSNAME"]         = "開啟點擊追蹤材料",
    ["LINKCRAFTABLEREAGENTSDESC"]         = "點擊顯示可製造配方的材料",
    ["QUEUECRAFTABLEREAGENTSNAME"]        = "將可製造的材料加入排程",
    ["QUEUECRAFTABLEREAGENTSDESC"]        = "若配方所需材料不足則列入排程",
    ["DISPLAYSHOPPINGLISTATBANKNAME"]     = "在銀行顯示購物清單",
    ["DISPLAYSHOPPINGLISTATBANKDESC"]     = "顯示排程配方所需材料清單",
    ["DISPLAYSGOPPINGLISTATAUCTIONNAME"]  = "在拍賣場顯示購物清單",
    ["DISPLAYSGOPPINGLISTATAUCTIONDESC"]  = "顯示排程配方所需材料清單",

    ["Appearance"]                   = "外觀",
    ["APPEARANCEDESC"]               = "Skillet顯示選項",
    ["DISPLAYREQUIREDLEVELNAME"]     = "顯示需要等級",
    ["DISPLAYREQUIREDLEVELDESC"]     = "若尚未達到製造物品所需等級 則於配方旁顯示所需等級",
    ["Transparency"]                 = "透明度",
    ["TRANSPARAENCYDESC"]            = "商業技能視窗透明度",

    -- New in version 1.6
    ["Shopping List"]               = "購物清單",
    ["Retrieve"]                    = "取得",
    ["Include alts"]                = "包括分身",

    -- New in vesrsion 1.9
    ["Start"]                       = "開始",
    ["Pause"]                       = "暫停",
    ["Clear"]                       = "清除",
    ["None"]                        = "無",
    ["By Name"]                     = "根據名稱",
    ["By Difficulty"]               = "根據難度",
    ["By Level"]                    = "根據等級",
    ["Scale"]                       = "大小",
    ["SCALEDESC"]                   = "專業技能視窗大小 (預設值 1.0)",
    ["Could not find bag space for"] = "背包無可用空格",
    ["SORTASC"]                     = "遞減排序",
    ["SORTDESC"]                    = "遞增排序",
    ["By Quality"]                  = "根據品質",

    -- New in version 1.10
    ["Inventory"]                   = "背包",
    ["INVENTORYDESC"]               = "背包訊息",
    ["Supported Addons"]            = "支援插件",
    ["Selected Addon"]              = "已選擇插件",
    ["Library"]                     = "函式庫",
    ["SUPPORTEDADDONSDESC"]         = "可支援的可監視追蹤物品插件",
    -- ["SHOWBANKALTCOUNTSNAME"]       = "Include bank and alt character contents",
    -- ["SHOWBANKALTCOUNTSDESC"]       = "When calculating and displaying craftable itemn counts, include items from your bank and from your other characters",
    -- ["ENHANCHEDRECIPEDISPLAYNAME"]  = "Show recipe difficulty as text",
    -- ["ENHANCHEDRECIPEDISPLAYDESC"]  = "When enabled, recipe names will have one or more '+' characters appeneded to their name to inidcate the difficulty of the recipe.",
    -- ["SHOWCRAFTCOUNTSNAME"]         = "Show craftable counts",
    -- ["SHOWCRAFTCOUNTSDESC"]         = "Show the number of times you can craft a recipe, not the total number of items producable",

    -- New in version 1.11
    ["Crafted By"]                  = "Crafted by",

} end)
