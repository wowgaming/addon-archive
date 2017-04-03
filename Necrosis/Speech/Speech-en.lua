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

function Necrosis:Localization_Speech_En()

	self.Speech.TP = {
		[1] = {
			"<after>Arcanum Taxi Cab! Please click on the portal so we can get this show on the road.",
		},
		[2] = {
			"<after>Welcome aboard ~Succubus Air Lines~...",
			"<after>Air Hostesses and their lashes are at your service during your trip!",
		},
		[3] = {
			"<after>If you click on the portal, we might get this party started a lot quicker!",
		},
		[4] = {
			"<after>Fools! Dont just stand there looking at the portal - click on it so we can summon those scrubs!",
		},
		[5] =  {
			"<after>Healthstones=10g, Soulstones=20g, Summons(cos you're too lazy to fly here)=10000g!",
		},
		[6] =  {
			"<after>WTB people that click on the portal instead of looking at it :/",
		},
	}

	self.Speech.Rez = {
		[1] = {
			"<after>If you cherish the idea of a mass suicide, <target> can now self-resurrect, so all should be fine. Go ahead.",
		},
		[2]= {
			"<after><target> can go afk to drink a cup of coffee or something, soulstone is in place to allow for the wipe...",
		},
		[3]= {
			"<after>Hmmm... <target> is soulstoned... full of confidence tonight aren't we!!",
		},
		[4]= {
			"<after><target> is Stoned... duuuude heavy!",
		},
		[5]= {
			"<after>Why does <target> always go afk when soulstoned?!!!",
		},
	}

	self.Speech.RoS = {
		[1] = {
			"Let us use the souls of our fallen enemies to give us vitality",
		},
		[2] = {
			"My soul, their soul, doesn't matter, just take one",
		},
		[3] = {
			"WTS healthstones 10g each!! Cheaper than AH!",
		},
		[4] = {
			"This healthstone probably wont save your life, but take one anyway!",
		},
		[5] = {
			"If you dont pull aggro, then you wont need a healthstone!",
		},
	}

	self.Speech.ShortMessage = {
		{{"<after>--> <target> is soulstoned for 30 minutes <--"}},
		{{"<after><TP> Summoning <target>, please click on the portal <TP>"}},
		{{"Casting Ritual of Souls"}},
	}

	self.Speech.Demon = {
		-- Imp
		[1] = {
			[1] = {
				"You nasty little Imp, stop sulking and get over here to help! AND THAT'S AN ORDER!",
			},
			[2] = {
				"<pet>! HEEL! NOW!",
			},
		},
		-- Voidwalker
		[2] = {
			[1] = {
				"Oops, I'll probably need an idiot to be knocked around for me...",
				"<pet>, please help!",
			},
		},
		-- Succubus
		[3] = {
			[1] = {
				"<pet> baby, please help me sweetheart!",
			},
		},
		-- Felhunter
		[4] = {
			[1] = {
				"<pet> ! <pet>! Come on boy, come here! <pet>!",
			},
		},
		-- Felguard
		[5] = {
			[1] = {
				"<emote> is concentrating hard on Demoniac knowledge...",
				"I'll give you a soul if you come to me, Felguard! Please hear my command!",
				"<after>Obey now, <pet>!",
				"<after><emote>looks in a bag, then throws a mysterious shard at <pet>",
				"<sacrifice>Please return in the Limbs you are from, Demon, and give me your power in exchange!"
			},
		},
		-- Sentences for the first summon : When Necrosis do not know the name of your demons yet
		[6] = {
			[1] = {
				"Fishing? Yes I love fishing... Look!",
				"I close my eyes, I move my fingers like that...",
				"<after>And voila! Yes, yes, it is a fish, I can swear you!",
			},
			[2] = {
				"Anyway I hate you all! I don't need you, I have friends.... powerful friends!",
				"COME TO ME, CREATURE OF HELL AND NIGHTMARE!",
			},
		},
		-- Sentences for the stead summon
		[7] = {
			[1] = {
				"Hey, I'm late! Let's find a horse that roxes!",
			},
			[2] = {
				"<emote> is giggling gloomily...",
				"<yell>I am summoning a steed from nightmare!",
			},
			[3] = {
				"I call forth the flames of feet to make my travels swift!",
			},
		}
	}

end

