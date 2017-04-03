--[[
    This file is part of Decursive.
    
    Decursive (v 2.5.1-6-gd3885c5) add-on for World of Warcraft UI
    Copyright (C) 2006-2007-2008-2009 John Wellesz (archarodim AT teaser.fr) ( http://www.2072productions.com/?to=decursive.php )

    This is the continued work of the original Decursive (v1.9.4) by Quu
    "Decursive 1.9.4" is in public domain ( www.quutar.com )

    Decursive is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Decursive is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Decursive.  If not, see <http://www.gnu.org/licenses/>.
--]]
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Simplified Chinese localization
-------------------------------------------------------------------------------

--[=[
--                      YOUR ATTENTION PLEASE
--
--         !!!!!!! TRANSLATORS TRANSLATORS TRANSLATORS !!!!!!!
--
--    Thank you very much for your interest in translating Decursive.
--    Do not edit those files. Use the localization interface available at the following address:
--
--      ################################################################
--      #  http://wow.curseforge.com/projects/decursive/localization/  #
--      ################################################################
--
--    Your translations made using this interface will be automatically included in the next release.
--
--]=]

local addonName, T = ...;
-- big ugly scary fatal error message display function {{{
if not T._FatalError then
-- the beautiful error popup : {{{ -
StaticPopupDialogs["DECURSIVE_ERROR_FRAME"] = {
    text = "|cFFFF0000Decursive Error:|r\n%s",
    button1 = "OK",
    OnAccept = function()
        return false;
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    showAlert = 1,
    }; -- }}}
T._FatalError = function (TheError) StaticPopup_Show ("DECURSIVE_ERROR_FRAME", TheError); end
end
-- }}}
if not T._LoadedFiles or not T._LoadedFiles["enUS.lua"] then
    if not DecursiveInstallCorrupted then T._FatalError("Decursive installation is corrupted! (enUS.lua not loaded)"); end;
    DecursiveInstallCorrupted = true;
    return;
end

local L = LibStub("AceLocale-3.0"):NewLocale("Decursive", "zhCN");

if not L then
    T._LoadedFiles["zhCN.lua"] = "2.5.1-6-gd3885c5";
    return;
end;

L["ABOLISH_CHECK"] = "在施法前检测是否需要净化"
L["ABOUT_AUTHOREMAIL"] = "作者 E-Mail"
L["ABOUT_CREDITS"] = "贡献者"
L["ABOUT_LICENSE"] = "许可"
L["ABOUT_NOTES"] = "当单独、小队和团队时清除有害状态，并可使用高级过滤和优先等级系统。"
L["ABOUT_OFFICIALWEBSITE"] = "官方网站"
L["ABOUT_SHAREDLIBS"] = "共享库"
L["ABSENT"] = "不存在 （%s）"
L["AFFLICTEDBY"] = "受%s影响"
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "实时列表显示人数："
L["ANCHOR"] = "Decursive 文字定位点"
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "显示或隐藏微单元面板（MUF）"
L["BINDING_NAME_DCRPRADD"] = "将目标加入优先列表"
L["BINDING_NAME_DCRPRCLEAR"] = "清空优先列表"
L["BINDING_NAME_DCRPRLIST"] = "显示优先列表明细条目"
L["BINDING_NAME_DCRPRSHOW"] = "显示/隐藏 优先列表"
L["BINDING_NAME_DCRSHOW"] = "显示或隐藏一键驱散状态条"
L["BINDING_NAME_DCRSHOWOPTION"] = "显示选项设置窗口"
L["BINDING_NAME_DCRSKADD"] = "将目标加入忽略列表"
L["BINDING_NAME_DCRSKCLEAR"] = "清空忽略列表"
L["BINDING_NAME_DCRSKLIST"] = "显示忽略列表明细条目"
L["BINDING_NAME_DCRSKSHOW"] = "显示/隐藏 忽略列表"
L["BLACK_LENGTH"] = "黑名单持续时间: "
L["BLACKLISTED"] = "黑名单"
L["CHARM"] = "魅惑"
L["CLASS_HUNTER"] = "猎人"
L["CLEAR_PRIO"] = "C"
L["CLEAR_SKIP"] = "C"
L["COLORALERT"] = "预警颜色"
L["COLORCHRONOS"] = "秒表"
L["COLORCHRONOS_DESC"] = "设置秒表颜色"
L["COLORSTATUS"] = "设定当玩家状态是'%s'时微单元面板（MUF）的颜色"
L["CTRL"] = "Ctrl"
L["CURE_PETS"] = "检测并净化宠物"
L["CURSE"] = "诅咒"
L["DEBUG_REPORT_HEADER"] = [=[|cFF11FF33请报告此窗口的内容给 Archarodim+DcrReport@teaser.fr|r
|cFF009999（使用 CTRL+A 选择所有 CTRL+C 复制文本到剪切板）|r
如果发现 Decursive 任何奇怪的行为也一并报告。]=]
L["DECURSIVE_DEBUG_REPORT"] = "**** |cFFFF0000Decursive 除错报告|r ****"
L["DECURSIVE_DEBUG_REPORT_NOTIFY"] = [=[一个除错报告可用！输入
|cFFFF0000/dcr general report|r 查看]=]
L["DECURSIVE_DEBUG_REPORT_SHOW"] = "除错报告可用！"
L["DECURSIVE_DEBUG_REPORT_SHOW_DESC"] = "显示作者需要看到的除错报告…"
L["DEFAULT_MACROKEY"] = "`"
L["DEV_VERSION_ALERT"] = [=[您正在使用的是开发版本的 Decursive 。

如果不想参加测试新功能与修复，得到游戏中的除错报告后发送问题给作者，请“不要使用此版本”并从 curse.com 和 wowace.com 下载最新的“稳定”版本。

这条消息只将在版本更新中显示一次

使用开发版本 Decursive 的玩家开始游戏显示此提示。]=]
L["DEV_VERSION_EXPIRED"] = [=[此开发版 Decursive 已过期。
请从 CURSE.COM 或 WOWACE.COM 下载最新的开发版或使用当前稳定版。谢谢！ ^_^
此提示每两天显示一次。

说明：当用户使用过期的开发版 Decursive 登录时每次显示。]=]
L["DEWDROPISGONE"] = "没有等同于 Ace3 的 DewDrop。Alt+右键点击打开选项面板。"
L["DISABLEWARNING"] = [=[Decursive 已被禁用！

要重新启用，输入 |cFFFFAA44/DCR ENABLE|r]=]
L["DISEASE"] = "疾病"
L["DONOT_BL_PRIO"] = "不将优先列表中的玩家加入黑名单"
L["FAILEDCAST"] = [=[|cFF22FFFF%s %s|r |cFFAA0000未能施放于|r %s
|cFF00AAAA%s|r]=]
L["FOCUSUNIT"] = "焦点单位"
L["FUBARMENU"] = "FuBar 选项"
L["FUBARMENU_DESC"] = "FuBar 的相关设定"
L["GLOR1"] = "纪念 Glorfindal"
L["GLOR2"] = "献给匆匆离我们而去的 Bertrand；他将永远被我们所铭记。"
L["GLOR3"] = "纪念 Bertrand（１９６９－２００７）"
L["GLOR4"] = "对于那些在魔兽世界里遇见过 Glorfindal 的人来说，他是一个重承诺的男人，也是一个有超凡魅力的领袖。友谊和慈爱将永植于他们的心中。他在游戏中就如同在他生活中一样的无私，彬彬有礼，乐于奉献，最重要的是他对生活充满热情。他离开我们的时候才仅仅38岁，随他离去的绝不会是虚拟世界匿名的角色；在这里还有一群忠实的朋友在永远想念他。"
L["GLOR5"] = "他将永远被我们所铭记。"
L["HANDLEHELP"] = "拖拽移动 MUF"
L["HIDE_LIVELIST"] = "隐藏实时列表"
L["HIDE_MAIN"] = "隐藏状态条"
L["HIDESHOW_BUTTONS"] = "显示/隐藏按钮"
L["HLP_LEFTCLICK"] = "鼠标左键"
L["HLP_LL_ONCLICK_TEXT"] = "由于暴雪禁用函数的缘故，点击实时列表已经不能驱散负面效果了"
L["HLP_MIDDLECLICK"] = "鼠标中键"
L["HLP_NOTHINGTOCURE"] = "没有可处理的负面效果！"
L["HLP_RIGHTCLICK"] = "鼠标右键"
L["HLP_USEXBUTTONTOCURE"] = "用 \"%s\" 來净化这个负面效果！"
L["HLP_WRONGMBUTTON"] = "错误的鼠标按键！"
L["IGNORE_STEALTH"] = "忽略潜行的玩家"
L["IS_HERE_MSG"] = "一键驱散已经启动，请核对相关设置。"
L["LIST_ENTRY_ACTIONS"] = [=[|cFF33AA33[CTRL]|r+单击：删除
|cFF33AA33左键|r单击：上移
|cFF33AA33右键|r单击：下移
|cFF33AA33[SHIFT]+左键|r单击：移到顶端
|cFF33AA33[SHIFT]+右键|r单击：移到底端]=]
L["MACROKEYALREADYMAPPED"] = [=[警告: 一键驱散的宏绑定按键 [%s] 先前绑定到 '%s' 。
当你设置別的宏按键后一键驱散会恢复此按键原有的动作。]=]
L["MACROKEYMAPPINGFAILED"] = "按键 [%s] 不能绑定到一键驱散的宏！"
L["MACROKEYMAPPINGSUCCESS"] = "按键 [%s] 已成功绑定到一键驱散的宏。"
L["MACROKEYNOTMAPPED"] = "未绑定一键驱散的宏按键，你可以通过设置选项来设置该功能。"
L["MAGIC"] = "魔法"
L["MAGICCHARMED"] = "魔法魅惑"
L["MISSINGUNIT"] = "丢失单位"
L["NORMAL"] = "一般"
L["NOSPELL"] = "没有相关技能"
L["OPT_ABOLISHCHECK_DESC"] = "设置是否显示和净化带有“驱毒术”增益效果的玩家。"
L["OPT_ABOUT"] = "关于"
L["OPT_ADDDEBUFF"] = "新增"
L["OPT_ADDDEBUFF_DESC"] = "向列表中新增一个负面效果。"
L["OPT_ADDDEBUFFFHIST"] = "新增一个最近受到的负面效果"
L["OPT_ADDDEBUFFFHIST_DESC"] = "从历史记录中新增一个负面效果"
L["OPT_ADDDEBUFF_USAGE"] = "<负面效果名称>"
L["OPT_ADVDISP"] = "高级显示选项"
L["OPT_ADVDISP_DESC"] = "允许分别设置面板和边框的透明度，以及 MUF 的间距。"
L["OPT_AFFLICTEDBYSKIPPED"] = "%s受到%s的影响，但将被忽略。"
L["OPT_ALWAYSIGNORE"] = "不在战斗状态时也忽略"
L["OPT_ALWAYSIGNORE_DESC"] = "选中后不在状态时此负面效果也会被忽略。"
L["OPT_AMOUNT_AFFLIC_DESC"] = "设置实时列表显示的最大玩家数目。"
L["OPT_ANCHOR_DESC"] = "设置自定义信息面板的定位点。"
L["OPT_AUTOHIDEMFS"] = "自动隐藏"
L["OPT_AUTOHIDEMFS_DESC"] = "选择何时自动隐藏微单元面板（MUF）"
L["OPT_BLACKLENTGH_DESC"] = "设置被暂时加入黑名单的玩家在名单中停留的时间。"
L["OPT_BORDERTRANSP"] = "边框透明度"
L["OPT_BORDERTRANSP_DESC"] = "设置边框的透明度。"
L["OPT_CENTERTRANSP"] = "面板透明度"
L["OPT_CENTERTRANSP_DESC"] = "设置面板的透明度"
L["OPT_CHARMEDCHECK_DESC"] = "选中后你将可以查看和处理被诱惑的玩家。"
L["OPT_CHATFRAME_DESC"] = "提示信息将显示在默认聊天窗口中。"
L["OPT_CHECKOTHERPLAYERS"] = "检查其他玩家"
L["OPT_CHECKOTHERPLAYERS_DESC"] = "显示当前小队或团队玩家 Decursive 版本（不能显示 Decursive 2.4.6之前的版本）。"
L["OPT_CREATE_VIRTUAL_DEBUFF"] = "创建一个虚拟的测试用负面效果"
L["OPT_CREATE_VIRTUAL_DEBUFF_DESC"] = "让你看看出现负面效果时的界面是什么样子"
L["OPT_CUREPETS_DESC"] = "宠物也会被检查和净化。"
L["OPT_CURINGOPTIONS"] = "净化选项"
L["OPT_CURINGOPTIONS_DESC"] = "关于净化过程的选项设置。"
L["OPT_CURINGOPTIONS_EXPLANATION"] = [=[
选择你想要治疗的伤害类型，未经检查的类型将被 Decursive 完全忽略。

绿色数字确定优先的伤害。这一优先事项将影响几方面：
- 如果一个玩家获得许多类型的减益效果，Decursive 将优先显示。
- 鼠标按钮点击将治疗减益（第一法术是左键点击，第二法术是右键点击，等等…）

所有这一切的说明文档（请见）：
http://www.wowace.com/addons/decursive/]=]
L["OPT_CURINGORDEROPTIONS"] = "净化顺序设置"
L["OPT_CURSECHECK_DESC"] = "选中后你将可以查看和净化受到诅咒效果影响的玩家。"
L["OPT_DEBCHECKEDBYDEF"] = [=[

默认被选中

]=]
L["OPT_DEBUFFENTRY_DESC"] = "选择在战斗中哪些受到此负面效果影响的职业将被忽略。"
L["OPT_DEBUFFFILTER"] = "负面效果过滤"
L["OPT_DEBUFFFILTER_DESC"] = "根据名称和职业选择在战斗中要过滤掉的负面效果"
L["OPT_DISABLEMACROCREATION"] = "禁止创建宏"
L["OPT_DISABLEMACROCREATION_DESC"] = "Decursive 宏将不再创建和保留"
L["OPT_DISEASECHECK_DESC"] = "选中后你将可以查看和净化受到疾病效果影响的玩家。"
L["OPT_DISPLAYOPTIONS"] = "显示选项"
L["OPT_DONOTBLPRIO_DESC"] = "优先列表中的玩家不会被加入黑名单。"
L["OPT_ENABLEDEBUG"] = "启用除错"
L["OPT_ENABLEDEBUG_DESC"] = "启用除错输出"
L["OPT_ENABLEDECURSIVE"] = "启用 Decursive"
L["OPT_FILTEROUTCLASSES_FOR_X"] = "在战斗中指定的职业%q将被忽略。"
L["OPT_GENERAL"] = "一般选项"
L["OPT_GROWDIRECTION"] = "反向显示 MUF"
L["OPT_GROWDIRECTION_DESC"] = "MUF 将从下向上显示。"
L["OPT_HIDELIVELIST_DESC"] = "显示所有受到负面效果影响的玩家列表。"
L["OPT_HIDEMFS_GROUP"] = "单人/小队"
L["OPT_HIDEMFS_GROUP_DESC"] = "不在团队中时隐藏微单元面板（MUF）"
L["OPT_HIDEMFS_NEVER"] = "从不"
L["OPT_HIDEMFS_NEVER_DESC"] = "从不隐藏"
L["OPT_HIDEMFS_SOLO"] = "单人"
L["OPT_HIDEMFS_SOLO_DESC"] = "在没有组队或者团队时隐藏微单元面板（MUF）"
L["OPT_HIDEMUFSHANDLE"] = "隐藏 MUF 表头"
L["OPT_HIDEMUFSHANDLE_DESC"] = "隐藏微单元面板（MUF）表头并禁止移动。"
L["OPT_IGNORESTEALTHED_DESC"] = "处于潜行状态的玩家会被忽略。"
L["OPTION_MENU"] = "选项设置"
L["OPT_LIVELIST"] = "实时列表"
L["OPT_LIVELIST_DESC"] = "关于实时列表的选项设置。"
L["OPT_LLALPHA"] = "实时列表透明度"
L["OPT_LLALPHA_DESC"] = "改变一键驱散状态条面和实时列表的透明度（状态条必须可见）"
L["OPT_LLSCALE"] = "设置实时列表缩放比例"
L["OPT_LLSCALE_DESC"] = "设置状态条以及其实时列表的大小（状态条必须显示）"
L["OPT_LVONLYINRANGE"] = "只显示法术有效范围内的目标"
L["OPT_LVONLYINRANGE_DESC"] = "实时列表将只显示法术有效范围内的目标,超出范围的目标将被忽略。"
L["OPT_MACROBIND"] = "设置宏按键"
L["OPT_MACROBIND_DESC"] = [=[绑定一键驱散宏的按键。

按你想設定的按键后按 'Enter' 键保存设置(鼠标需要移动到编辑区域之外)]=]
L["OPT_MACROOPTIONS"] = "宏选项"
L["OPT_MACROOPTIONS_DESC"] = "有关 Decursive 创建的宏的选项设置"
L["OPT_MAGICCHARMEDCHECK_DESC"] = "选中后你将可以查看和净化受到魔法诱惑效果影响的玩家。"
L["OPT_MAGICCHECK_DESC"] = "选中后你将可以查看和净化受到不良魔法效果影响的玩家。"
L["OPT_MAXMFS"] = "最大单位数"
L["OPT_MAXMFS_DESC"] = "设置在屏幕上显示的MUF的个数。"
L["OPT_MESSAGES"] = "信息设置"
L["OPT_MESSAGES_DESC"] = "关于提示信息的选项设置。"
L["OPT_MFALPHA"] = "透明度"
L["OPT_MFALPHA_DESC"] = "定义玩家没有受到负面效果影响时MUF的透明度。"
L["OPT_MFPERFOPT"] = "性能选项"
L["OPT_MFREFRESHRATE"] = "刷新率"
L["OPT_MFREFRESHRATE_DESC"] = "每两次刷新之间的时间间隔"
L["OPT_MFREFRESHSPEED"] = "刷新速度"
L["OPT_MFREFRESHSPEED_DESC"] = "设置每次刷新多少个MUF。"
L["OPT_MFSCALE"] = "MUF 缩放比例"
L["OPT_MFSCALE_DESC"] = "设置微单元面板（MUF）的大小。"
L["OPT_MFSETTINGS"] = "微单元面板（MUF）选项"
L["OPT_MFSETTINGS_DESC"] = "关于微单元面板（MUF）的选项设置。"
L["OPT_MUFFOCUSBUTTON"] = "焦点按钮："
L["OPT_MUFMOUSEBUTTONS"] = "鼠标按钮"
L["OPT_MUFMOUSEBUTTONS_DESC"] = "设置每个 MUF 鼠标按钮的警报颜色。"
L["OPT_MUFSCOLORS"] = "颜色"
L["OPT_MUFSCOLORS_DESC"] = "更改关于微单元面板（MUF）的颜色"
L["OPT_MUFTARGETBUTTON"] = "目标按钮："
L["OPT_NOKEYWARN"] = "没有映射按键"
L["OPT_NOKEYWARN_DESC"] = "没有映射按键"
L["OPT_NOSTARTMESSAGES"] = "禁用欢迎信息"
L["OPT_NOSTARTMESSAGES_DESC"] = "移除每次登陆时在聊天框体显示的三个 Decursive 信息。"
L["OPT_PLAYSOUND_DESC"] = "有玩家受到负面效果影响时播放声音提示。"
L["OPT_POISONCHECK_DESC"] = "选中后你将可以查看和净化受到中毒效果影响的玩家。"
L["OPT_PRINT_CUSTOM_DESC"] = "提示信息将显示在自定义聊天窗口中。"
L["OPT_PRINT_ERRORS_DESC"] = "错误信息将被显示。"
L["OPT_PROFILERESET"] = "正在重置选项设置方案……"
L["OPT_RANDOMORDER_DESC"] = "随机净化玩家（不推荐使用）。"
L["OPT_READDDEFAULTSD"] = "重新加入缺省负面效果"
L["OPT_READDDEFAULTSD_DESC1"] = [=[向列表中加入所有缺失的默认负面效果。
你的自定义项目不会丢失]=]
L["OPT_READDDEFAULTSD_DESC2"] = "所有缺省负面效果都已加入列表。"
L["OPT_REMOVESKDEBCONF"] = [=[你确定要将“%s”
从不良状态忽略列表中删除吗？]=]
L["OPT_REMOVETHISDEBUFF"] = "删除"
L["OPT_REMOVETHISDEBUFF_DESC"] = "从忽略列表中删除“%s”。"
L["OPT_RESETDEBUFF"] = "重置"
L["OPT_RESETDTDCRDEFAULT"] = [=[将
%s
恢复默认值。]=]
L["OPT_RESETMUFMOUSEBUTTONS"] = "重置"
L["OPT_RESETMUFMOUSEBUTTONS_DESC"] = "重置鼠标按钮指派为默认。"
L["OPT_RESETOPTIONS"] = "恢复默认设置"
L["OPT_RESETOPTIONS_DESC"] = "将当前选项设置方案恢复到默认值"
L["OPT_RESTPROFILECONF"] = "你确定要将选项设置方案“(%s) %s”恢复默认值吗？"
L["OPT_REVERSE_LIVELIST_DESC"] = "实时列表将从下往上显示。"
L["OPT_SCANLENGTH_DESC"] = "设置实时检测的时间间隔。"
L["OPT_SHOWBORDER"] = "显示职业彩色边框"
L["OPT_SHOWBORDER_DESC"] = "MUF 边框将会显示出代表该玩家职业的颜色。"
L["OPT_SHOWCHRONO"] = "显示计时"
L["OPT_SHOWCHRONO_DESC"] = "显示单位受到不良效果的时间"
L["OPT_SHOWCHRONOTIMElEFT"] = "剩余时间"
L["OPT_SHOWCHRONOTIMElEFT_DESC"] = "显示剩余时间而不是消耗时间。"
L["OPT_SHOWHELP"] = "显示帮助信息"
L["OPT_SHOWHELP_DESC"] = "当鼠标移动到 MUF 上时显示信息提示窗口。"
L["OPT_SHOWMFS"] = "在屏幕上显示 MUF"
L["OPT_SHOWMFS_DESC"] = "如果你要打地鼠就必須选择这项。"
L["OPT_SHOWMINIMAPICON"] = "迷你地图图标"
L["OPT_SHOWMINIMAPICON_DESC"] = "开启或关闭迷你地图图标。"
L["OPT_SHOW_STEALTH_STATUS"] = "显示潜行状态"
L["OPT_SHOW_STEALTH_STATUS_DESC"] = "当玩家前行时，他的 MUF 将有一个特殊的颜色"
L["OPT_SHOWTOOLTIP_DESC"] = "在实时列表以及微单元面板（MUF）上显示信息提示。"
L["OPT_STICKTORIGHT"] = "将微单元面板（MUF）向右对齐"
L["OPT_STICKTORIGHT_DESC"] = "这个选项将会使微单元面板（MUF）向右对齐"
L["OPT_TESTLAYOUT"] = "测试布局"
L["OPT_TESTLAYOUT_DESC"] = [=[新建测试单位以测试显示布局。
（点击后稍等片刻）]=]
L["OPT_TESTLAYOUTUNUM"] = "单位数字"
L["OPT_TESTLAYOUTUNUM_DESC"] = "设置新建测试单位数字。"
L["OPT_TIECENTERANDBORDER"] = "绑定面板和边框的透明度"
L["OPT_TIECENTERANDBORDER_OPT"] = "选中时边框的透明度为面板的一半。"
L["OPT_TIE_LIVELIST_DESC"] = "实时列表将和状态条一起 显示/隐藏。"
L["OPT_TIEXYSPACING"] = "绑定水平和垂直间距。"
L["OPT_TIEXYSPACING_DESC"] = "MUF 之间的水平和垂直间距相同。"
L["OPT_UNITPERLINES"] = "每行单位数"
L["OPT_UNITPERLINES_DESC"] = "设置每行最多可显示单元面板（MUF）的个数。"
L["OPT_USERDEBUFF"] = "该负面效果不是<一键驱散>预设的效果之一"
L["OPT_XSPACING"] = "水平距离"
L["OPT_XSPACING_DESC"] = "设置 MUF 间的水平距离。"
L["OPT_YSPACING"] = "垂直距离"
L["OPT_YSPACING_DESC"] = "设置 MUF 间的垂直距离。"
L["PLAY_SOUND"] = "有玩家需要净化时播放声音提示"
L["POISON"] = "中毒"
L["POPULATE"] = "p"
L["POPULATE_LIST"] = "列表快速添加器"
L["PRINT_CHATFRAME"] = "在聊天窗口显示信息"
L["PRINT_CUSTOM"] = "在游戏画面显示信息"
L["PRINT_ERRORS"] = "显示错误信息"
L["PRIORITY_LIST"] = "设置 优先列表"
L["PRIORITY_SHOW"] = "P"
L["RANDOM_ORDER"] = "随机净化玩家"
L["REVERSE_LIVELIST"] = "反向显示实时列表"
L["SCAN_LENGTH"] = "实时检测时间间隔（秒）："
L["SHIFT"] = "Shift"
L["SHOW_MSG"] = "如果需要显示状态条，请输入 /dcrshow。"
L["SHOW_TOOLTIP"] = "在实时列表中显示信息提示"
L["SKIP_LIST_STR"] = "Decursive 忽略列表"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "找到%s法术！"
L["STEALTHED"] = "已潜行"
L["STR_CLOSE"] = "关闭"
L["STR_DCR_PRIO"] = "Decursive 优先"
L["STR_DCR_SKIP"] = "Decursive 忽略"
L["STR_GROUP"] = "小队"
L["STR_OPTIONS"] = "Decursive 选项"
L["STR_OTHER"] = "其他"
L["STR_POP"] = "快速添加列表"
L["STR_QUICK_POP"] = "快速添加器"
L["SUCCESSCAST"] = "%s %s|cFF00AA00成功施放于|r|cFF22FFFF %s|r。"
L["TARGETUNIT"] = "设为目标"
L["TIE_LIVELIST"] = "根据状态条是否可见 显示/隐藏 实时列表"
L["TOOFAR"] = "太远"
L["UNITSTATUS"] = "玩家状态："



T._LoadedFiles["zhCN.lua"] = "2.5.1-6-gd3885c5";
