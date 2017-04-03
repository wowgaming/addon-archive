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
-- Version $LastChangedDate: 2008-10-20 03:36:53 +1100 (Mon, 20 Oct 2008) $
------------------------------------------------------------------------------------------------------

function Necrosis:Localization_Speech_Fr()

	self.Speech.TP = {
		[1] = {
			"<after>Taxi des Arcanes ! J'invoque <target>, cliquez sur le portail svp !",
		},
		[2] = {
			"<after>Bienvenue, <target>, sur le vol de ~Succube Air Lines~ \195\160 destination de <player>...",
			"<after>Les h\195\180tesses et leur fouet sont \195\160 votre disposition durant le trajet",
		},
		[3] = {
			"<after>Si vous ne voulez pas qu'une cr\195\169ature tentaculaire, glaireuse et asthmatique sorte de ce portail, cliquez dessus pour aider <target> \195\160 trouver son chemin au plus vite !",
		},
		[4] = {
			"<after>Si vous cliquez sur le portail, un machin nomm\195\169 <target> sortira et fera le boulot \195\160 votre place...",
		},
		[5] = {
			"Tel un lapin dans un chapeau de mage, <target> va appara\195\174tre devant vos yeux \195\169bahis.",
			"<after>Et hop.",
		},
		[6] = {
			"PAR ASTAROTH ET DASMODES, JE T'INVOQUE, O TOUT PUISSANT DEMON DES SEPTS ENFERS, PARANGON VELU DES INFRA MONDES DEMONIAQUES, PAR LA PUISSANCE DU SCEAU ANCESTR... euh ?!? Je crois qu'il y a un probl\195\168me l\195\160...",
			"<after>Ah merde c'est <target> qui d\195\169barque !!",
		},
		[7] = {
			"Chantons ensemble ! Venu de nulle part, c'est <target>, Plus vif que le serpent, c'est <target> !",
			"Personne ne l'aper\195\167oit, c'est <target>, Mais il est toujours l\195\160, c'est <target> !",
			"Plein d'effroi les Pirates de Tanaris rien qu'\195\160 son nom voient leur sang qui se glace, se glace, se glace... Mais quand il y a danger, c'est <target> qui vient pour nous aider, <target>...",
			"<after>(Cliquez vite sur le portail sinon je continue...)",
			"<after>C'EST <target> ! <target> ! <target> !",
		},
	}

	self.Speech.Rez = {
		[1] = {
			"<after>Si ca vous tente un suicide collectif, <target> s'en fout, la pierre d'\195\162me lui permettra de se relever",
		},
		[2] = {
			"<after><target> peut partir siroter un caf\195\169, et pourra se relever du wipe qui s'en suivra gr\195\162ce \195\160 sa pierre d'\195\162me",
		},
		[3] = {
			"<after>Pierre pos\195\169e sur <target>, vous pouvez recommencer \195\160 faire n'importe quoi sans risque",
		},
		[4] = {
			"<after>Gr\195\162ce \195\160 sa pierre d'\195\162me, <target> est pass\195\169 en mode Easy wipe",
		},
		[5] = {
			"<after><target> peut d\195\169sormais revenir d'entre les morts, histoire d'organiser le prochain wipe",
		},
		[6] = {
			"<after>Les hindous croient \195\160 l'immortalit\195\169, <target> aussi depuis que je lui ai pos\195\169 une pierre d'\195\162me",
		},
		[7] = {
			"Ne bougeons plus !",
			"<after><target> est d\195\169sormais \195\169quip\195\169 de son kit de survie temporaire.",
		},
		[8] = {
			"<after>Tel le ph\195\169nix, <target> pourra revenir d'entre les flammes de l'enfer (Faut dire aussi qu'il a beaucoup de rf...)",
		},
		[9] = {
			"<after>Gr\195\162ce \195\160 sa pierre d'\195\162me, <target> peut de nouveau faire n'importe quoi.",
		},
		[10] = {
			"<after>Sur <target> poser une belle pierre d'\195\162me,",
			"<after>Voil\195\160 qui peut ma foi \195\169viter bien des drames !",
		},
	}
	
	self.Speech.RoS = {
		[1] = {
			"Utilisons donc les \195\162mes de nos ennemis, pour nous redonner la vie !",
		},
		[2] = {
			"Votre \195\162me, mon \195\162me, leur \195\162me... Quelle importance ? Allez, piochez-en juste une !",
		},
	}

	self.Speech.ShortMessage = {
		{{"<after>--> <target> est prot\195\169g\195\169 par une pierre d'\195\162me <--"}},
		{{"<after><TP> Invocation de <target> en cours, cliquez sur le portail svp <TP>"}},
		{{"Rassembler un rituel des \195\162mes"}}
	}

	self.Speech.Demon = {
		-- Diablotin
		[1] = {
			[1] = {
				"Bon, s\195\162le petite peste de Diablotin, tu arr\195\170tes de bouder et tu viens m'aider ! ET C'EST UN ORDRE !",
			},
			[2] = {
				"<pet> ! AU PIED ! TOUT DE SUITE !",
			},
			[3] = {
				"Attendez, je sors mon briquet !",
			},
		},
		-- Marcheur éthéré
		[2] = {
			[1] = {
				"Oups, je vais sans doute avoir besoin d'un idiot pour prendre les coups \195\160 ma place...",
				"<pet>, viens m'aider !",
			},
			[2] = {
				"GRAOUbouhhhhh GROUAHOUhououhhaahpfffROUAH !",
				"GRAOUbouhhhhh GROUAHOUhououhhaahpfffROUAH !",
				"(Non je ne suis pas dingue, j'imite le bruit du marcheur en rut !)",
			},
		},
		-- Succube
		[3] = {
			[1] = {
				"<pet> ma grande, viens m'aider ch\195\169rie !",
			},
			[2] = {
				"Ch\195\169rie, l\195\162che ton rimmel et am\195\168ne ton fouet, y a du taf l\195\160 !",
			},
			[3] = {
				"<pet> ? Viens ici ma louloutte !",
			},
		},
		-- Chasseur corrompu
		[4] = {
			[1] = {
				"<pet> ! <pet> ! Aller viens mon brave, viens ! <pet> !",
			},
			[2] = {
				"Rhoo, et qui c'est qui va se bouffer le mage hein ? C'est <pet> !",
				"<after>Regardez, il bave d\195\169j\195\160 :)",
			},
			[3] = {
				"Une minute, je sors le caniche et j'arrive !",
			},
		},
		-- Gangregarde
		[5] = {
			[1] = {
				"<emote> concentre toute sa puissance dans ses connaissances d\195\169monologiques...",
				"En \195\169change de cette \195\162me, viens \195\160 moi, Gangregarde !",
				"<after>Ob\195\169is moi maintenant, <pet> !",
				"<after><emote>fouille dans son sac, puis lance un cristal \195\160 <pet>",
				"<sacrifice>Retourne dans les limbes et donne moi de ta puissance, D\195\169mon !"
			},
		},
		-- Phrase pour la première invocation de pet (quand Necrosis ne connait pas encore leur nom)
		[6] = {
			[1] = {
				"La p\195\170che au d\195\169mon ? Rien de plus facile !",
				"Bon, je ferme les yeux, j'agite les doigts comme \195\167a...",
				"<after>Et hop ! Oh, les jolies couleurs !",
			},
			[2] = {
				"Toute fa\195\167on je vous d\195\169teste tous ! J'ai pas besoin de vous, j'ai des amis.... Puissants !",
				"VENEZ A MOI, CREATURES DE L'ENFER !",
			},
			[3] = {
				"Eh, le d\195\169mon, viens voir, il y a un truc \195\160 cogner l\195\160 !",
			},
			[4] = {
				"En farfouillant dans le monde abyssal, on trouve de ces trucs...",
				"<after>Regardez, ceci par exemple !",
			},

		},
		-- Phrase pour la monture
		[7] = {
			[1] = {
				"Mmmphhhh, je suis en retard ! Invoquons vite un cheval qui rox !",
			},
			[2] = {
				"J'invoque une monture de l'enfer !",
			},
			[3] = {
				"<emote>ricane comme un damn\195\169 !",
				"<after><yell>TREMBLEZ, MORTELS, J'ARRIVE A LA VITESSE DU CAUCHEMAR !!!!",
			},
			[4] = {
				"Et hop, un cheval tout feu tout flamme !",
			},
			[5] = {
				"Vous savez, depuis que j'ai mis une selle ignifug\195\169e, je n'ai plus de probl\195\168me de culotte !"
			},
		},

	}

end


-- Pour les caractères spéciaux :
-- é = \195\169 ---- è = \195\168
-- à = \195\160 ---- â = \195\162
-- ô = \195\180 ---- ê = \195\170
-- û = \195\187 ---- ä = \195\164
-- Ä = \195\132 ---- ö = \195\182
-- Ö = \195\150 ---- ü = \195\188
-- Ü = \195\156 ---- ß = \195\159
-- ç = \195\167 ---- î = \195\174

