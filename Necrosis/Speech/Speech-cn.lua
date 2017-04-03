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
-- Version $LastChangedDate: 2008-10-19 14:52:05 +1100 (Sun, 19 Oct 2008) $
------------------------------------------------------------------------------------------------------

-------------------------------------
--  CHINESE TRADITIONAL VERSION --
--  2006/01/05
--  艾娜羅沙@奧妮克希亞/TW
-------------------------------------


function Necrosis:Localization_Speech_Cn()

	self.Speech.TP = {
		[1] = {
		  "<emote>开始在空中画出一道有着强烈光芒的符咒",
			"<after>》<player>《正在召唤【<target>】，需要二名队友合作，请按右键点击传送门，召唤期间不要移动。",
		},
		[2] = {
			"<after>》<player>《正在召唤【<target>】，请队友帮忙点击传送门，召唤期间请不要移动。",
		},
		[3] = {
			"<after>欢迎【<target>】搭乘由<player>所驾驶的恶魔姊姊航空，请已到的乘客二名，帮按右键点击传送专用登机门，谢谢。",
		},
		[4] = {
			"<after>》<player>《正在试着把【<target>】抓过来，需要二名队友一起围捕，围捕期间请勿移动，以及勿对<target>拍打喂食。",
		},
	}

	self.Speech.Rez = {
		[1] = {
			"<after>【<target>】灵魂已经被绑定。",
		},
		[2]= {
			"<after>【<target>】灵魂已经被锁进保险箱三十分钟。",
		},
		[3]= {
			"<after>【<target>】的灵魂，已经寄放在天使姊姊的怀里三十分钟",
		},
	}

	self.Speech.RoS = {
		[1] = {
			"Let us use the souls of our fallen enemies to give us vitality",
		},
		[2] = {
			"My soul, their soul, doesn't matter, just take one",
		},
	}

	self.Speech.ShortMessage = {
		{{"<after>■【<target>】的灵魂，已被绑定３０分钟■"}},
		{{"<after><TP>正在召唤【<target>】，请帮忙点击传送门<TP>"}},
		{{"Summoning a Ritual of Souls"}},
	}

	self.Speech.Demon = {
		-- Imp
		[1] = {
			[1] = {
				"小鬼头<pet>，现在正是需要你的时候了，出来吧！",
			},
			[2] = {
				"<pet>！应侬之求，速速现身！",
			},
			[3] = {
				"决定了，是你了！<pet>！",
			},
		},
		-- Voidwalker
		[2] = {
			[1] = {
				"我正在招唤蓝色大沙包来帮我挡怪。",
				"正在召宠：<pet>",
			},
			[2] = {
				"决定了，是你了！<pet>！",
				"<after><emote>把灵魂碎片丢向空中，召唤出了<pet>",
			},
		},
		-- Succubus
		[3] = {
			[1] = {
				"出来吧<pet>，我渴望看到鞭子鞭人的那种那火辣辣的快感!!",
			},
			[2] = {
				"决定了，是你了！<pet>！",
				"<after><emote>把灵魂碎片丢向空中，召唤出了<pet>",
			},
			[3] = {
				"亲爱的女王大人<pet>，欢迎来到这个世界！",
				"<after><emote>向<pet>送出一个飞吻",
			},
		},
		-- Felhunter
		[4] = {
			[1] = {
				"正在呼叫不用喂食物的狗狗中！",
			},
			[2] = {
				"决定了，是你了！<pet>！",
				"<after><emote>把灵魂碎片丢向空中，召唤出了<pet>",
			},
		},
		-- Felguard
		[5] = {
			[1] = {
				"<emote>正在脑海中思索着，相当困难的有关于恶魔的知识...",
				"献上吾之灵魂，恶魔守卫，请您听见我、理解我的愿望！",
				"<after>以侬之名，命你现身，<pet>！",
				"<after><emote>从包包中取出灵魂碎片，并且把它掷向<pet>",
				"<sacrifice>回到你原来的地方吧！但是以你必须给我你的力量用做交换！！"
			},
		},
		-- Sentences for the first summon : When Necrosis do not know the name of your demons yet
		[6] = {
			[1] = {
				"正在从异界钓出宠物中...",
				"<after><emote>把灵魂碎片丢向空中，召唤出了<pet>",
			},
		},
		-- Sentences for the stead summon
		[7] = {
			[1] = {
				"<emote>正在帮座骑鞍上风火轮...",
			},
			[2] = {
				"午夜的梦魇，出来吧!",
			},
		}
	}

end

