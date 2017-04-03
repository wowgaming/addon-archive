--[[
    Necrosis LdC
    Copyright (C) 2005-2008  Lom Enfroy

    This file is part of Necrosis LdC.

    Necrosis LdC is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Necrosis LdC is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Necrosis LdC; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
--]]


------------------------------------------------------------------------------------------------------
-- Necrosis LdC
-- Par Lomig (Kael'Thas EU/FR) & Tarcalion (Nagrand US/Oceanic) 
-- Contributions deLiadora et Nyx (Kael'Thas et Elune EU/FR)
--
-- Skins et voix Françaises : Eliah, Ner'zhul
--
-- Version Allemande par Geschan
-- Version Espagnole par DosS (Zul’jin)
-- Version Russe par Komsomolka
--
-- Version $LastChangedDate: 2009-12-10 17:09:53 +1100 (Thu, 10 Dec 2009) $
------------------------------------------------------------------------------------------------------

------------------------------------------------
-- CHINESE SIMPLIFIED VERSION TEXTS          --
--  2007/01/02
--  艾娜羅沙@奧妮克希亞/TW
------------------------------------------------

function Necrosis:Localization_Dialog_Cn()

	function Necrosis:Localization()
		self:Localization_Speech_Cn();
	end

	self.HealthstoneCooldown = "治疗石冷却时间"
	
	self.Localize = {
		["Utilisation"] = "Use",
		["Echange"] = "Trade",
	}

	self.TooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFNecrosis|r",
			Stone = {
				[true] = "是",
				[false] = "否",
			},
			Hellspawn = {
				[true] = "开",
				[false] = "关",
			},
			["Soulshard"] = "灵魂碎片: ",
			["InfernalStone"] = "地狱火石: ",
			["DemoniacStone"] = "恶魔雕像: ",
			["Soulstone"] = "\n灵魂石: ",
			["Healthstone"] = "治疗石: ",
			["Spellstone"] = "法术石: ",
			["Firestone"] = "火焰石: ",
			["CurrentDemon"] = "恶魔: ",
			["EnslavedDemon"] = "恶魔: 奴役",
			["NoCurrentDemon"] = "恶魔 : 无",
		},
		["Soulstone"] = {
			Text = {"制造","可使用","已使用","等待"},
			Ritual = "|c00FFFFFFShift+Click to cast the Ritual of Summoning|r"
		},
		["Healthstone"] = {
			Text = {"制造","使用"},
			Text2 = "按中键或是Ctrl-左键交易",
			Ritual = "|c00FFFFFFShift+左键施放灵魂仪式|r"
		},
		["Spellstone"] = {
			Text = {"Right click to create","In Inventory\nLeft click to use","Used", "Used\Click to create"}
		},
		["Firestone"] = {
			Label = "|c00FF4444火焰石|r",
			Text = {"Right click to create","In Inventory\nLeft click to use","Used", "Used\Click to create"}
		},
		["SpellTimer"] = {
			Text = "启用对目标的法术计时",
			Right = "右键使用炉石到"
		},
		["ShadowTrance"] = {
			Label = "|c00FFFFFF暗影冥思|r"
		},
		["Backlash"] = {
			Label = "|c00FFFFFF反冲|r"
		},
		["Banish"] = {
			Text = "按右键施放等级1"
		},
		["Imp"] = {
			Label = "|c00FFFFFF小鬼|r"
		},
		["Voidwalker"] = {
			Label = "|c00FFFFFF虚空行者|r"
		},
		["Succubus"] = {
			Label = "|c00FFFFFF魅魔|r"
		},
		["Felhunter"] = {
			Label = "|c00FFFFFF地狱猎犬|r"
		},
		["Felguard"] = {
			Label = "|c00FFFFFF地狱守卫|r"
		},
		["Infernal"] = {
			Label = "|c00FFFFFF地狱火|r"
		},
		["Doomguard"] = {
			Label = "|c00FFFFFF末日守卫|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFF坐骑|r",
			Text = "右键施放等级1"
		},
		["BuffMenu"] = {
			Label = "|c00FFFFFF法术菜单|r",
			Text = "右键保持菜单开启",
			Text2 = "自动模式：脱离战斗后自动关闭",
		},
		["PetMenu"] = {
			Label = "|c00FFFFFF恶魔菜单|r",
			Text = "右键保持菜单开启",
			Text2 = "自动模式：脱离战斗后自动关闭",
		},
		["CurseMenu"] = {
			Label = "|c00FFFFFF诅咒菜单|r",
			Text = "右键保持菜单开启",
			Text2 = "自动模式：脱离战斗后自动关闭",
		},
		["DominationCooldown"] = "右键快速召唤",
	}

	self.Sound = {
		["Fear"] = "Interface\\AddOns\\Necrosis\\sounds\\Fear-En.mp3",
		["SoulstoneEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\SoulstoneEnd-En.mp3",
		["EnslaveEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\EnslaveDemonEnd-En.mp3",
		["ShadowTrance"] = "Interface\\AddOns\\Necrosis\\sounds\\ShadowTrance-En.mp3",
		["Backlash"] = "Interface\\AddOns\\Necrosis\\sounds\\Backlash-En.mp3",
	}

	NECROSIS_NIGHTFALL_TEXT = {
		["NoBoltSpell"] = "你好像没有暗影箭法术。",
		["Message"] = "<white>暗<lightPurple1>影<lightPurple2>冥<purple>思<darkPurple1>！<darkPurple2>暗<darkPurple1>影<purple>冥<lightPurple2>思<lightPurple1>！<white>！"
	}


	self.ChatMessage = {
		["Bag"] = {
			["FullPrefix"] = "你的 ",
			["FullSuffix"] = " 满了 !",
			["FullDestroySuffix"] = " 满了; 下个碎片将被摧毁!",
		},
		["Interface"] = {
			["Welcome"] = "<white>/necrosis 显示设置菜单!",
			["TooltipOn"] = "打开提示" ,
			["TooltipOff"] = "关闭提示",
			["MessageOn"] = "打开聊天信息通知",
			["MessageOff"] = "关闭聊天信息通知",
			["DefaultConfig"] = "<lightYellow>默认配置已加载。",
			["UserConfig"] = "<lightYellow>配置已加载。",
		},
		["Help"] = {
			"/necrosis <lightOrange>recall<white> -- <lightBlue>将Necrosis和所有按钮置于屏幕中间",
			"/necrosis <lightOrange>reset<white> -- <lightBlue>Reset Necrosis entirely",
		},
		["Information"] = {
			["FearProtect"] = "你的目标对恐惧免疫!!!!",
			["EnslaveBreak"] = "恶魔摆脱奴役...",
			["SoulstoneEnd"] = "<lightYellow>你的灵魂石失效。"
		}
	}

	-- Gestion XML - Menu de configuration
	self.Config.Panel = {
		"信息设置",
		"Sphere Settings",
		"按钮设置",
		"Menus Settings",
		"计时器设置",
		"Miscellanious"
	}

	self.Config.Messages = {
		["Position"] = "<- 这儿将显示Necrosis的信息 ->",
		["Afficher les bulles d'aide"] = "显示提示",
		["Afficher les messages dans la zone systeme"] = "宣告Necrosis信息作为系统信息",
		["Activer les messages aleatoires de TP et de Rez"] = "随机显示召唤的信息",
		["Utiliser des messages courts"] = "Use short messages",
		["Activer egalement les messages pour les Demons"] = "激活随机语言 (恶魔)",
		["Activer egalement les messages pour les Montures"] = "激活随机语言 (坐骑)",
		["Activer egalement les messages pour le Rituel des ames"] = "激活灵魂仪式的随机信息",
		["Activer les sons"] = "开启声音",
		["Alerter quand la cible est insensible a la peur"] = "当我的目标免疫恐惧时提醒我。",
		["Alerter quand la cible peut etre banie ou asservie"] = "Warn when the target is banishable or enslavable",
		["M'alerter quand j'entre en Transe"] = "当我获得暗影冥思效果时提醒我。"
	}

	self.Config.Sphere = {
		["Taille de la sphere"] = "Necrosis按钮的大小",
		["Skin de la pierre Necrosis"] = "Necrosis球体的皮肤",
		["Evenement montre par la sphere"] = "图形显示",
		["Sort caste par la sphere"] = "Spell casted by the Sphere",
		["Afficher le compteur numerique"] = "显示碎片数量",
		["Type de compteur numerique"] = "石头类型"
	}

	self.Config.Sphere.Colour = {
		"粉红色",
		"蓝色",
		"橙色",
		"青绿色",
		"紫色",
		"666",
		"X"
	}
	self.Config.Sphere.Count = {
		"灵魂碎片",
		"恶魔召唤石",
		"灵魂石冷却计时",
		"Mana",
		"Health"
	}

	self.Config.Buttons = {
		["Rotation des boutons"] = "Buttons rotation",
		["Fixer les boutons autour de la sphere"] = "Stick buttons around the Sphere",
		["Utiliser mes propres montures"] = "Use my own mounts",
		["Choix des boutons a afficher"] = "Selection of buttons to be shown",
		["Monture - Clic gauche"] = "Left click",
		["Monture - Clic droit"] = "Right click",
	}
	self.Config.Buttons.Name = {
		"显示火焰石按钮",
		"显示法术石按钮",
		"显示治疗石按钮",
		"显示灵魂石按钮",
		"显示buff菜单按钮",
		"显示战马按钮",
		"显示恶魔召唤菜单按钮",
		"显示诅咒菜单按钮",
		"Show Metamorphosis menu button",
	}

	self.Config.Menus = {
		["Options Generales"] = "General Options",
		["Menu des Buffs"] = "法术菜单",
		["Menu des Demons"] = "恶魔菜单",
		["Menu des Maledictions"] = "诅咒菜单",
		["Afficher les menus en permanence"] = "Always show menus",
		["Afficher automatiquement les menus en combat"] = "Show automatically the menus while in combat",
		["Fermer le menu apres un clic sur un de ses elements"] = "Close a menu whenever you click on one of its items",
		["Orientation du menu"] = "Menu orientation",
		["Changer la symetrie verticale des boutons"] = "Change the vertical simetry of buttons",
		["Taille du bouton Banir"] = "放逐按钮大小",
	}
	self.Config.Menus.Orientation = {
		"Horizontal",
		"Upwards",
		"Downwards"
	}

	self.Config.Timers = {
		["Type de timers"] = "Timer type",
		["Afficher le bouton des timers"] = "Show the Spell Timer button",
		["Afficher les timers sur la gauche du bouton"] = "计时器在按钮左边",
		["Afficher les timers de bas en haut"] = "计时器向上升",
	}
	self.Config.Timers.Type = {
		"No Timer",
		"Graphical",
		"Textual"
	}

	self.Config.Misc = {
		["Deplace les fragments"] = "将碎片放入选择的包。",
		["Detruit les fragments si le sac plein"] = "如果包满摧毁所有新的碎片。",
		["Choix du sac contenant les fragments"] = "选择灵魂碎片包",
		["Nombre maximum de fragments a conserver"] = "Maximum number of shards to keep",
		["Verrouiller Necrosis sur l'interface"] = "锁定 Necrosis球体及周围的按钮。",
		["Afficher les boutons caches"] = "显示隐藏的按钮以拖动它。",
		["Taille des boutons caches"] = "暗影冥思和反恐按钮的大小"
	}

end
