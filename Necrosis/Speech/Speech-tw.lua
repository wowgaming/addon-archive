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
-- Version $LastChangedDate: 2008-11-19 01:34:40 +1100 (Wed, 19 Nov 2008) $
------------------------------------------------------------------------------------------------------

--[[
中文化
羽毛球@鬼霧峰
艾娜羅沙@奧妮克希亞

[說明]
<player>替換為玩家名字
<target>替換為目標名字
<pet>替換為寵物名字
<emote>使用表情說出後面的句子
<yell>使用大喊喊出後面的句子
<after>施法完成後顯示的句子
<sacrifice>使用惡魔犧牲時說的句子
--]]

function Necrosis:Localization_Speech_Tw()

	self.Speech.TP = {
		[1] = {
			"開始準備召喚<target>。",
			"<emote>畫出一道門，透發著詭異的能量波動。",
			"<after>正在召喚【<target>】，麻煩隊友幫忙點擊傳送門，召喚期間請不要移動。",
		},
		[2] = {
			"開始準備召喚<target>。",
			"<emote>畫出一道門，透發著詭異的能量波動。",
			"<after>正在試著把【<target>】抓過來，麻煩隊友幫忙圍捕，圍捕期間勿對<target>拍打餵食。",
		},
		[3] = {
			"開始準備召喚<target>。",
			"<emote>畫出一道門，透發著詭異的能量波動。",
			"<after>儂正在召喚【<target>】，請戰友手持三柱香，幫點傳送門。儂命汝速速現身答禮。",
		},
		[4] = {
			"開始準備召喚<target>。",
			"<emote>畫出一道門，透發著詭異的能量波動。",
			"<after>正在傳訊被告【<target>】，請目擊證人幫點傳送門，以便被告到事故現場來模擬案發經過。",
		},
	}

	self.Speech.Rez = {
		[1]= {
			"<emote>向<target>做了一個複雜的結印。",
			"<after>【<target>】的靈魂已經被鎖進保險箱三十分鐘。",
		},
		[2]= {
			"<emote>向<target>做了一個複雜的結印。",
			"<after>【<target>】的靈魂已經寄放在天使姊姊的懷裡三十分鐘。",
		},
		[3]= {
			"<emote>向<target>做了一個複雜的結印。",
			"<after>【<target>】的靈魂已經借給惡魔姊姊把玩三十分鐘。",
		},
	}
	
	self.Speech.RoS = {
		[1] = {
			"糖果: 誰膽敢召喚我！你連自己補血的能力都沒有嗎？",
		},
		[2] = {
			"媽媽說帶乖乖桶來發有助人際發展。^O^",
		},
	}

	self.Speech.ShortMessage = {
		{{"<after>【<target>】的靈魂，已被綁定３０分鐘。"}},
		{{"<after><TP>正在召喚【<target>】，請幫忙點擊傳送門。<TP>"}},
	}

	self.Speech.Demon = {
		-- Imp
		[1] = {
			[1] = {
				"小鬼頭<pet>，現在正是需要你的時候了，出來吧！",
			},
			[2] = {
				"<pet>！應儂之求，速速現身！",
			},
			[3] = {
				"決定了，是你了！<pet>！",
			},
		},
		-- Voidwalker
		[2] = {
			[1] = {
				"我正在招喚藍色大沙包來幫我擋怪。",
				"正在召寵：<pet>",
			},
			[2] = {
				"決定了，是你了！<pet>！",
				"<after><emote>把靈魂碎片丟向空中，召喚出了<pet>",
			},
		},
		-- Succubus
		[3] = {
			[1] = {
				"出來吧<pet>，我渴望看到鞭子鞭人的那種那火辣辣的快感...囧",
			},
			[2] = {
				"決定了，是你了！<pet>！",
				"<after><emote>把靈魂碎片丟向空中，召喚出了<pet>",
			},
			[3] = {
				"親愛的女王大人<pet>，歡迎來到這個世界！",
				"<after><emote>向<pet>送出一個飛吻",
			},
		},
		-- Felhunter
		[4] = {
			[1] = {
				"正在呼叫不用餵食物的狗狗中！",
			},
			[2] = {
				"決定了，是你了！<pet>！",
				"<after><emote>把靈魂碎片丟向空中，召喚出了<pet>",
			},
		},
		-- Felguard
		[5] = {
			[1] = {
				"<emote>正在腦海中思索著，相當困難的有關於惡魔的知識...",
				"獻上吾之靈魂，惡魔守衛，請您聽見我、理解我的願望！",
				"<after>以儂之名，命你現身，<pet>！",
				"<after><emote>從包包中取出靈魂碎片，並且把它擲向<pet>",
				"<sacrifice>回到你原來的地方吧！但是以你必須給我你的力量用做交換！！"
			},
		},
		-- Sentences for the first summon : When Necrosis do not know the name of your demons yet
		[6] = {
			[1] = {
				"<emote>正在從異界釣出寵物中...",
				"<after><emote>把靈魂碎片丟向空中，召喚出了<pet>",
			},
		},
		-- Sentences for the stead summon
		[7] = {
			[1] = {
				"<emote>正在幫座騎鞍上風火輪...",
			},
			[2] = {
				"午夜的夢魘，出來吧!",
			},
		}
	}

end

