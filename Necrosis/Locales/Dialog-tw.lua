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

--[[
中文化
羽毛球@鬼霧峰
艾娜羅沙@奧妮克希亞
--]]

function Necrosis:Localization_Dialog_Tw()

	function Necrosis:Localization()
	  self:Localization_Speech_Tw()
	end

	self.HealthstoneCooldown = "治療石冷卻時間"
	
	self.Localize = {
		["Utilisation"] = "使用",
		["Echange"] = "交易",
	}

	self.TooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFNecrosis|r",
			Stone = {
				[true] = "是";
				[false] = "否";
			},
			Hellspawn = {
				[true] = "開";
				[false] = "關";
			},
			["Soulshard"] = "靈魂碎片：",
			["InfernalStone"] = "地獄火石：",
			["DemoniacStone"] = "惡魔雕像：",
			["Soulstone"] = "\n靈魂石：",
			["Healthstone"] = "治療石：",
			["Spellstone"] = "法術石：",
			["Firestone"] = "火焰石：",
			["CurrentDemon"] = "惡魔：",
			["EnslavedDemon"] = "惡魔：奴役",
			["NoCurrentDemon"] = "惡魔：無",
		},
		["Soulstone"] = {
			Text = {"製造","使用","已使用","等待中"},
			Ritual = "|c00FFFFFFShift+Click to cast the Ritual of Summoning|r"
		},
		["Healthstone"] = {
			Text = {"製造","使用"},
			Text2 = "按中鍵或是Ctrl-左鍵交易",
			Ritual = "|c00FFFFFFShift+左鍵施放靈魂儀式|r"
		},
		["Spellstone"] = {
			Text = {"按右鍵製造","按左鍵使用","已使用", "已使用\點擊製造"}
		},
		["Firestone"] = {
			Text = {"按右鍵製造","按左鍵使用","已使用", "已使用\點擊製造"}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFF法術持續時間|r",
			Text = "啟用對目標的法術計時",
			Right = "右鍵使用爐石到"
		},
		["ShadowTrance"] = {
			Label = "|c00FFFFFF暗影冥思|r"
		},
		["Backlash"] = {
			Label = "|c00FFFFFF反衝|r"
		},
		["Banish"] = {
			Text = "按右鍵施放等級1"
		},
		["Imp"] = {
			Label = "|c00FFFFFF小鬼|r"
		},
		["Voidwalker"] = {
			Label = "|c00FFFFFF虛空行者|r"
		},
		["Succubus"] = {
			Label = "|c00FFFFFF魅魔|r"
		},
		["Felhunter"] = {
			Label = "|c00FFFFFF地獄獵犬|r"
		},
		["Felguard"] = {
			Label = "|c00FFFFFF地獄守衛|r"
		},
		["Infernal"] = {
			Label = "|c00FFFFFF地獄火|r"
		},
		["Doomguard"] = {
			Label = "|c00FFFFFF末日守衛|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFF坐騎|r",
			Text = "右鍵施放等級1"
		},
		["BuffMenu"] = {
			Label = "|c00FFFFFF法術選單|r",
			Text = "右鍵保持選單開啟",
			Text2 = "自動模式：脫離戰鬥後自動關閉",
		},
		["PetMenu"] = {
			Label = "|c00FFFFFF惡魔選單|r",
			Text = "右鍵保持選單開啟",
			Text2 = "自動模式：脫離戰鬥後自動關閉",
		},
		["CurseMenu"] = {
			Label = "|c00FFFFFF詛咒選單|r",
			Text = "右鍵保持選單開啟",
			Text2 = "自動模式：脫離戰鬥後自動關閉",
		},
		["DominationCooldown"] = "右鍵快速召喚",
	}

	self.Sound = {
		["Fear"] = "Interface\\AddOns\\Necrosis\\sounds\\Fear-En.mp3",
		["SoulstoneEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\SoulstoneEnd-En.mp3",
		["EnslaveEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\EnslaveDemonEnd-En.mp3",
		["ShadowTrance"] = "Interface\\AddOns\\Necrosis\\sounds\\ShadowTrance-En.mp3",
		["Backlash"] = "Interface\\AddOns\\Necrosis\\sounds\\Backlash-En.mp3",
	}

	self.ProcText = {
		["ShadowTrance"] = "你沒有任何的暗影箭法術。",
		["Backlash"] = "<white>暗<lightPurple1>影<lightPurple2>冥<purple>思<darkPurple1>！<darkPurple2>暗<darkPurple1>影<purple>冥<lightPurple2>思<lightPurple1>！<white>！"
	}

	self.ChatMessage = {
		["Bag"] = {
			["FullPrefix"] = "你的",
			["FullSuffix"] = " 滿了！",
			["FullDestroySuffix"] = "滿了；下個碎片將被摧毀！",
		},
		["Interface"] = {
			["Welcome"] = "<white>/necrosis 顯示設定功能表",
			["TooltipOn"] = "打開提示" ,
			["TooltipOff"] = "關閉提示",
			["MessageOn"] = "打開聊天訊息通知",
			["MessageOff"] = "關閉聊天訊息通知",
			["DefaultConfig"] = "<lightYellow>預設配置已載入",
			["UserConfig"] = "<lightYellow>配置已載入"
		},
		["Help"] = {
			"/necrosis <lightOrange>recall<white> -- <lightBlue>將Necrosis置於螢幕中央",
			"/necrosis <lightOrange>reset<white> -- <lightBlue>重置所有設定",
		},
		["Information"] = {
			["FearProtect"] = "你的目標對恐懼免疫",
			["EnslaveBreak"] = "惡魔擺脫奴役...",
			["SoulstoneEnd"] = "<lightYellow>你的靈魂石已失效"
		}
	}

	-- Gestion XML - Menu de configuration
	self.Config.Panel = {
		"資訊設定",
		"球體設定",
		"按鈕設定",
		"選單設定",
		"計時器設定",
		"雜項設定"
	}

	self.Config.Messages = {
		["Position"] = "<- 這裡將顯示Necrosis的系統訊息 ->",
		["Afficher les bulles d'aide"] = "顯示提示",
		["Afficher les messages dans la zone systeme"] = "宣告Necrosis訊息為系統訊息",
		["Activer les messages aleatoires de TP et de Rez"] = "顯示隨機訊息",
		["Utiliser des messages courts"] = "採用簡短訊息",
		["Activer egalement les messages pour les Demons"] = "啟用招喚惡魔的隨機訊息",
		["Activer egalement les messages pour les Montures"] = "啟用招喚坐騎的隨機訊息",
		["Activer egalement les messages pour le Rituel des ames"] = "啟用靈魂儀式的隨機訊息",
		["Activer les sons"] = "開啟音效",
		["Alerter quand la cible est insensible a la peur"] = "提醒目標為免疫恐懼",
		["Alerter quand la cible peut etre banie ou asservie"] = "提醒目標為可放逐或可奴役",
		["M'alerter quand j'entre en Transe"] = "提醒獲得暗影冥思效果"
	}

	self.Config.Sphere = {
		["Taille de la sphere"] = "Necrosis按鈕的大小",
		["Skin de la pierre Necrosis"] = "Necrosis球體的外觀",
		["Evenement montre par la sphere"] = "球體事件顯示",
		["Sort caste par la sphere"] = "球體施放的法術",
		["Afficher le compteur numerique"] = "顯示碎片數量",
		["Type de compteur numerique"] = "計算石頭類型"
	}
	self.Config.Sphere.Colour = {
		"粉紅色",
		"藍色",
		"橘色",
		"青綠色",
		"紫色",
		"666",
		"X"
	}
	self.Config.Sphere.Count = {
		"靈魂碎片",
		"惡魔召喚石",
		"靈魂石冷卻計時",
		"魔力",
		"體力"
	}

	self.Config.Buttons = {
		["Rotation des boutons"] = "旋轉按鈕",
		["Fixer les boutons autour de la sphere"] = "將按鈕固定於球體週圍",
		["Utiliser mes propres montures"] = "使用自己的坐騎",
		["Choix des boutons a afficher"] = "顯示選擇的按鈕",
		["Monture - Clic gauche"] = "坐騎 - 左鍵",
		["Monture - Clic droit"] = "坐騎 - 右鍵",
	}
	self.Config.Buttons.Name = {
		"顯示火焰石按鈕",
		"顯示法術石按鈕",
		"顯示治療石按鈕",
		"顯示靈魂石按鈕",
		"顯示法術功能表按鈕",
		"顯示戰馬按鈕",
		"顯示惡魔召喚功能表按鈕",
		"顯示詛咒功能表按鈕",
		"Show Metamorphosis menu button",
	}

	self.Config.Menus = {
		["Options Generales"] = "一般選單",
		["Menu des Buffs"] = "法術增益選單",
		["Menu des Demons"] = "惡魔選單",
		["Menu des Maledictions"] = "詛咒選單",
		["Afficher les menus en permanence"] = "永遠顯示選單",
		["Afficher automatiquement les menus en combat"] = "當戰鬥時自動顯示選單",
		["Fermer le menu apres un clic sur un de ses elements"] = "點擊後關閉選單",
		["Orientation du menu"] = "選單方向",
		["Changer la symetrie verticale des boutons"] = "改變按鈕對稱性",
		["Taille du bouton Banir"] = "放逐按鈕大小",
	}
	self.Config.Menus.Orientation = {
		"水平",
		"往上",
		"往下"
	}

	self.Config.Timers = {
		["Type de timers"] = "計時器種類",
		["Afficher le bouton des timers"] = "顯示計時器按鈕",
		["Afficher les timers sur la gauche du bouton"] = "計時器在按鈕左邊",
		["Afficher les timers de bas en haut"] = "計時器向上增加",
	}
	self.Config.Timers.Type = {
		"無計時器",
		"圖型",
		"文字"
	}

	self.Config.Misc = {
		["Deplace les fragments"] = "將碎片放入選擇的包包",
		["Detruit les fragments si le sac plein"] = "如果包包滿了，摧毀所有新的碎片",
		["Choix du sac contenant les fragments"] = "選擇靈魂碎片包包",
		["Nombre maximum de fragments a conserver"] = "靈魂碎片最大保存量",
		["Verrouiller Necrosis sur l'interface"] = "鎖定Necrosis主體及周圍的按鈕",
		["Afficher les boutons caches"] = "顯示隱藏的按鈕以便能拖曳它",
		["Taille des boutons caches"] = "暗影冥思和反恐按鈕的大小"
	}

end