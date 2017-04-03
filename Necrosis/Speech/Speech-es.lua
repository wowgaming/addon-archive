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

function Necrosis:Localization_Speech_Es()

	self.Speech.TP = {
		[1] = {
			"<after>\194\161 Compa\195\177\195\173a de Taxi Arcanum ! Estoy invocando a <target>, por favor cliquead en el portal.",
		},
		[2] = {
			"<after>Bienvenido a bordo, <target>, est\195\161 usted volando con ~Sucuiberia~ con destino <player>...",
			"<after>\194\161 Las Azafatas de Vuelo y sus l\195\161tigos est\195\161n a su disposici\195\179n durante el trayecto !",
		},
		[3] = {
			"<after>\194\161 Si haces click en el portal, alguien llamado <target> aparecer\195\161 y har\195\161 el trabajo por t\195\173 !",
		},
		[4] = {
			"<after>\194\161 Si no quieres que una criatura espatarrada, parecida a un escupitajo y asm\195\161tica aparezca de este portal, cliquea en \195\169l para ayudar a <target> a encontrar un camino en el Infierno tan r\195\161pido como sea posible!",
		},
	}

	self.Speech.Rez = {
		[1] = {
			"<after>Si os agrada la idea de un suicidio en masa, ahora <target> puede auto-resucitar, as\195\173 todos contentos. Adelante.",
		},
		[2]= {
			"<after><target> puede ponerse ausente para irse a tomar una tacita de caf\195\169 o lo que sea, la piedra de alma est\195\161 preparada para el wipe...",
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
		{{"<after>--> <target> ha recibido la piedra del alma durante 30 minutos <--"}},
		{{"<after><TP> Invocando a <target>, por favor cliquead en el portal <TP>"}},
		{{"Summoning a Ritual of Souls"}},
	}

	self.Speech.Demon = {
		-- Imp
		[1] = {
			[1] = {
				"\194\161 Bien, cutre y molesto Diablillo, ahora deja de enfurru\195\177arte y ven a ayudar ! \194\161 Y ES UNA ORDEN !",
			},
			[2] = {
				"\194\161<pet>! \194\161 A MIS PIES ! \194\161 YA !",
			},
		},
		-- Voidwalker
		[2] = {
			[1] = {
				"Ups, Probablemente necesitar\195\169 a un idiota para que le zurren en mi lugar...",
				"\194\161 <pet>, por favor ayuda !",
			},
		},
		-- Succubus
		[3] = {
			[1] = {
				"\194\161 <pet> nena, por favor ay\195\186dame coraz\195\179n !",
			},
		},
		-- Felhunter
		[4] = {
			[1] = {
				"\194\161 <pet> ! \194\161 <pet> ! \194\161 Ven chico, ven aqu\195\173 ! \194\161 <pet> !",
			},
		},
		-- Felguard
		[5] = {
			[1] = {
				"<emote> is concentrating hard on Demoniac knowledge...",
				"I'll give you a soul if you come to me, Felguard ! Please hear my command !",
				"<after>Obey now, <pet> !",
				"<after><emote>looks in a bag, then throws a mysterious shard at <pet>",
				"<sacrifice>Please return in the Limbs you are from, Demon, and give me your power in exchange !"
			},
		},
		-- Sentences for the first summon : When Necrosis do not know the name of your demons yet
		[6] = {
			[1] = {
				"\194\191Pescar? Si, me encanta pescar... \194\161 Mira !",
				"Cierro los ojos, muevo mis dedos as\195\173... y voila ! S\195\173, s\195\173, es un pescado, \194\161 Te lo juro !",
			},
			[2] = {
				"\194\161 De todas formas os odio a todos ! No os necesito, tengo amigos.... \194\161 Poderosos amigos !",
				"\194\161 VEN A MI, CRIATURA DE INFIERNO Y PESADILLA !",
			},
		},
		-- Sentences for the stead summon
		[7] = {
			[1] = {
				"\194\161 Eh, llego tarde ! \194\161 Busquemos un caballo que queme rueda !",
			},
			[2] = {
				"\194\161 Estoy invocando a un corcel de pesadilla !",
				"\194\161 MUAHAHAHAHA !",
			},
		},
	}

end

-- Caracteres especiales españoles :
-- á = \195\161 ---- Á = \195\161
-- é = \195\169 ---- É = \195\137
-- í = \195\173 ---- Í = \195\141
-- ó = \195\179 ---- Ó = \195\147
-- ú = \195\186 ---- Ú = \195\154
-- ñ = \195\177 ---- Ñ = \195\145
-- ¡ = \194\161 ---- ¿ = \194\191
