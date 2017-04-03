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
-- Version Russe par Komsomolka:Navigator (Азурегос/Пиратская Бухта) (http://koms.ruguild.ru)
--
-- Version $LastChangedDate: 2008-10-22 13:02:11 +1100 (Wed, 22 Oct 2008) $
------------------------------------------------------------------------------------------------------


function Necrosis:Localization_Speech_Ru()

	self.Speech.TP = {
		[1] = {
			"<after>Для осуществления доставки груза с кодовым названием '<target>', нажмите на портал.",
		},
		[2] = {
			"<after>Уважаемый <target>, Вас приветствует капитан воздушного судна <player> на борту Темных Авиалиний.",
			"<after>Напоминаем, что на борту запрещено курение на всем протяжении полета.",
		},
		[3] = {
			"<after>Если Вы нажмете на портал, кто-то по имени <target> прибудет сюда и выполнит за Вас работу...",
		},
		[4] = {
			"<after>Если Вы не хотите, чтобы из этого портала вылезла демоническая гадость, нажмите на него скорее, и <target> найдет дорогу через Ад как можно быстрее.",
		},
		[5] =  {
			"<after>Услуги такси для лентяя с именем <target>. Нажмите на портал, пожалуйста.",
		},
	}

	self.Speech.Rez = {
		[1] = {
			"<after>Если Вы затаили идею массового суицида, смею Вас расстроить! <target> сейчас может самостоятельно оживить свой труп и всё будет хорошо!",
		},
		[2]= {
			"<after><target> теперь может отправиться гулят, выпить кофе или принять ванну. Сохраненная душенка может позволить ему разок сдохнуть...",
		},
		[3]= {
			"<after>Хм... <target> предохранен... и может пуститься в разгул. Но, увы, не вы!",
		},
		[4]= {
			"<after><target> предохранен! Чернокнижники за безопасный секс!",
		},
	}

	self.Speech.RoS = {
		[1] = {
			"Используйте души наших врагов..., чтобы стать сильнее!",
		},
		[2] = {
			"Моя душа... Твоя душа... Не имеет значения! Возьми себе одну...",
		},
	}

	self.Speech.ShortMessage = {
		{{"<after>--> <target> теперь сохранен(а) на 30 минут <--"}},
		{{"<after><TP> Призываю <target>. Пожалуйста, нажмите на портал! <TP>"}},
	}

	self.Speech.Demon = {
		-- Imp
		[1] = {
			[1] = {
				"Ах ты позорный маленький бес... Прекрати шкодить и помоги мне! ЭТО ПРИКАЗ!",
			},
			[2] = {
				"<pet>, бес! Приказываю служить мне!",
			},
		},
		-- Voidwalker
		[2] = {
			[1] = {
				"Упс... Похоже, мне нужне идиот, который бы прислуживал мне...",
				"<pet>, мне нужна твоя помощь!",
			},
		},
		-- Succubus
		[3] = {
			[1] = {
				"<pet>, детка... Помоги мне, милая!",
			},
		},
		-- Felhunter
		[4] = {
			[1] = {
				"<pet>! <pet>! Ко мне, пёсик. К ноге, <pet>.",
			},
		},
		-- Felguard
		[5] = {
			[1] = {
				"<emote> концентрируется на своих Демонических знаниях...",
				"Я отдам тебе душу, если ты явишься! Слушай мою команду!",
				"<after>Воскресни вновь, <pet>!",
				"<after><emote>смотрит в сумку, затем кидает мистический осколок в <pet>",
				"<sacrifice>Я возвращаю тебя туда, откуда ты пришел, демон... но в замен ты одашь мне свою силу!"
			},
		},
		-- Sentences for the first summon : When Necrosis do not know the name of your demons yet
		[6] = {
			[1] = {
				"Удить рыбу? Да, я люблю рыбалку... смотри...",
				"Я закрываю свои глаза... Я опускаю свои пальцы ниже...",
				"<after>И вуаля! Да, да, да! Это рыбка...",
			},
			[2] = {
				"Я ненавижу Вас всех! Вы не нужны мне! У меня есть лишь один друг... сильный друг!",
				"ПРИДИ КО МНЕ, СОЗДАНИЕ ДЬЯВОЛА И ТЬМЫ!",
			},
		},
		-- Sentences for the stead summon
		[7] = {
			[1] = {
				"Лошааааадкаааа! Лошааааадкаааа!",
			},
			[2] = {
				"<emote> глумится...",
				"Я призываю коня из глубин Ада!",
			},
			[3] = {
				"Я призываю коня из глубин Ада, для моего комфортного путешествия...",
			},
		}
	}

end