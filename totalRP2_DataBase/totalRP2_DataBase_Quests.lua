-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

TRP2_DB_Quests = nil;

function TRP2_LoadDBQuests_1()
	TRP2_DB_Quests = {
		["QUE00001"] = {
			["Nom"] = "Quête";
			["Description"] = "Une quête vide, sans aucune données.",
			["bManual"] = false,
		},
		------------------------
		-- Exemples : 00002 à 00010
		------------------------
		["QUE00003"] = { -- Traitresse ! Coté Horde
			["DireAction"] = {
				["007"] = {
					["OnActionCondi"] = "namec$==$\"Morag le tavernier\";dist10yard$==$\"1\";",
					["EtapesNum"] = "007",
					["OnActionEffet"] = "texte$Une lettre ? Montrez-moi cela.\n{son:Sound\\\\Character\\\\Tauren\\\\TaurenMale\\\\TaurenMaleSigh01.wav}<Morag le tavernier lit la lettre en soupirant.>\nTout ça pour une histoire d'amour ... Il va falloir régler cela maintenant.\nAllez parler au concerné, celui qui se fait appeler Zazo.$4;quest$QUE00003$008$1;objet$ITE00401$1$2;",
					["DireTab"] = "talk",
				},
				["017"] = {
					["OnActionCondi"] = "namec$==$\"Goma\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Oui, elles n'arrêtent jamais de se prendre le chou.\nMais je ne sais pas pourquoi. Le mieux est de leur demander directement non ?$4;",
					["DireTab"] = "talk",
				},
				["013"] = {
					["OnActionCondi"] = "namec$==$\"Sana\";dist10yard$==$\"1\";",
					["EtapesNum"] = "010",
					["OnActionEffet"] = "texte$C'est Gryshka ?! C'est donc pour cela qu'elle m'avait volé la lettre !\n{anim084}Maintenant que j'y pense ... Les relations sont interdites entre les serveuses et les clients !\nAllez le dire à Morag le tavernier ! Il vous récompensera sûrement pour votre découverte !$4;quest$QUE00003$011$1;",
					["DireTab"] = "nod",
				},
				["003"] = {
					["OnActionCondi"] = "namec$==$\"Morag le tavernier\";dist10yard$==$\"1\";",
					["EtapesNum"] = "003",
					["OnActionEffet"] = "texte$Alors, vous avez découvert quelque chose ?\nGryshka a volé quelque chose à Sana dites-vous ? Mais quoi donc ?\nMmh vous ne savez pas ... Et bien je crois qu'il ne nous reste plus qu'à chercher ... Mais je connais Gryshka, si elle a volé quelque chose, elle le garde sûrement sur elle.\nAllez demander à Doyo’da de vous conseiller, dites lui que c'est moi qui vous envoie.$4;quest$QUE00003$004$1;",
					["DireTab"] = "talk",
				},
				["023"] = {
					["OnActionCondi"] = "namec$==$\"Zazo\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Un soucis entre Gryshka et Sana ?\nNon, je ne vois pas de quoi vous voulez parler ...$4;",
					["DireTab"] = "talk",
				},
				["016"] = {
					["OnActionCondi"] = "namec$==$\"Doyo’da\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Je vois tout, je sais tout ...\n... Mais je ne dis rien. Du moins pas gratuitement !\nMaintenant allez vous-en ! Vous allez faire refroidir mon grog.$4;",
					["DireTab"] = "talk",
				},
				["002"] = {
					["OnActionCondi"] = "namec$==$\"Sana\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002",
					["OnActionEffet"] = "texte$Oui, que désirez-vous ?\nCe qu'il y a entre Gryshka et moi ? Mais de quoi je me mèle ?\nElle m'a volé une chose qui m'est chère, voilà ce qu'il se passe !\nTant que cette truie ne m'aura pas rendu ce qui m'appartient, je continuerai de faire de sa vie un enfer !$4;quest$QUE00003$003$1;",
					["DireTab"] = "talk",
				},
				["012"] = {
					["OnActionCondi"] = "namec$==$\"Zazo\";dist10yard$==$\"1\";",
					["EtapesNum"] = "012",
					["OnActionEffet"] = "texte$Oh merci grandement. Vous avez réglé le problème sans briser notre secret.\nGryshka et moi nous nous aimons vraiment vous savez. Cet amour fou et indescriptible.\nVoici pour vous remercier.\n<Zazo vous donne une pièce d'or.>$4;quest$QUE00003$FinGood$1;or$10000$1;",
					["DireTab"] = "talk",
				},
				["022"] = {
					["OnActionCondi"] = "namec$==$\"Morag le tavernier\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002",
					["OnActionEffet"] = "texte$Je ne comprends pas ... Elles étaient pourtant meilleures amies ...$4;",
					["DireTab"] = "talk",
				},
				["015"] = {
					["OnActionCondi"] = "namec$==$\"Kozish\";dist10yard$==$\"1\";",
					["OnActionEffet"] = "texte${anim137}Mmh ? Vous ... *hic* .... Vous voyez pô qu'chuis oc... *hic* ... occupé à boire ?$4;",
					["DireTab"] = "talk",
				},
				["005"] = {
					["OnActionCondi"] = "namec$==$\"Doyo’da\";",
					["EtapesNum"] = "005",
					["OnActionEffet"] = "quest$QUE00003$006$1;parole$|| Doyo’da jete son verre à travers la pièce.$2;parole$|| Doyo’da crie : Mais c'est dégueulasse ! Cette bière est chaude !$2;parole$|| Gryshka regarde Doyo’da avec étonnement.$2;aura$AUR00101$20$1$1;son$Sound\\\\Spells\\\\GlassBreaking1.wav$2$15;",
					["DireTab"] = "wave",
				},
				["011"] = {
					["OnActionCondi"] = "namec$==$\"Sana\";dist10yard$==$\"1\";",
					["EtapesNum"] = "010",
					["OnActionEffet"] = "texte${anim073}{son:Sound\\\\Character\\\\Draenei\\\\DraeneiMaleRaspberry01.wav}Allez au diable ! Je découvrirai bien qui c'est un jour ! Elle ne perd rien pour attendre !$4;quest$QUE00003$012$1;",
					["DireTab"] = "no",
				},
				["001"] = {
					["OnActionCondi"] = "namec$==$\"Morag le tavernier\";dist10yard$==$\"1\";",
					["EtapesNum"] = "001",
					["OnActionEffet"] = "texte$Ah bien, vous voilà !\nJe n'en peux plus ... Gryshka l'aubergiste et Sana la marchande de cottes de mailles d'à coté n'arrêtent pas de s'engueuler. C'est pesant ! Et cela fait fuir la clientèle !\nS'il vous plait {me}, parlez-leur, à elles et aux autres clients. Trouvez la source du conflit et réglez ce problème ...$4;quest$QUE00003$002$1;",
					["DireTab"] = "talk",
				},
				["014"] = {
					["OnActionCondi"] = "namec$==$\"Morag le tavernier\";dist10yard$==$\"1\";",
					["EtapesNum"] = "011",
					["OnActionEffet"] = "texte$De quoi ?! Une de mes serveuses freluche avec un client ! Mais c'est interdit !\nElle sera virée sur le champ !\nJe vous remercie pour votre aide {me}. Voici de quoi vous récompenser.\n<Morag le tavernier vous donne 3 pièces d'or.>\nPartez maintenant. J'ai une serveuse à licencier !$4;quest$QUE00003$FinBad$1;or$30000$1;",
					["DireTab"] = "talk",
				},
				["004"] = {
					["OnActionCondi"] = "namec$==$\"Doyo’da\";dist10yard$==$\"1\";",
					["EtapesNum"] = "004",
					["OnActionEffet"] = "texte$Vous voulez des conseils, à propos de quoi ?\nAh, je vois, vous voulez dérober quelque chose à Gryshka ... Mmmh voyons.\nVoilà ce que nous allons faire : lorsque vous serez prêt vous me ferez un signe. J'attirerai alors son attention et vous n'aurez plus qu'à vous glisser derrière elle et la fouiller !\nSoyez réactif hein !\nFaites moi signe lorsque vous serez prêt.$4;quest$QUE00003$005$1;",
					["DireTab"] = "talk",
				},
				["010"] = {
					["OnActionCondi"] = "namec$==$\"Sana\";dist10yard$==$\"1\";",
					["EtapesNum"] = "009",
					["OnActionEffet"] = "texte$DE QUOI !? Il en désire une autre ?\n{anim074}{son:Sound\\\\Character\\\\PlayerRoars\\\\CharacterRoarsOrcFemale.wav}RAAAAAAAAAAAH !\nQui ça ? Seriez-vous d'accord pour me donner son nom ? Que je lui arrache les yeux !\n<Choix : /oui ou /non>$4;quest$QUE00003$010$1;",
					["DireTab"] = "talk",
				},
				["008"] = {
					["OnActionCondi"] = "namec$==$\"Gryshka l'aubergiste\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Ce qu'il se passe entre elle et moi ?\nCette dinde est totalement dingue de cet orc, Zazo.\nPourtant c'était ma meilleure amie ! Les amies se disent ce genre de chose ! Et bien non j'ai dü le découvrir moi même lorsque je suis tombée sur une lettre d'amour qu'elle comptait lui donner !\n{anim073}{son:Sound\\\\Character\\\\BloodElf\\\\BloodElfMaleRaspberry01.wav}Je lui en veux à mort !$4;",
					["DireTab"] = "talk",
				},
				["018"] = {
					["OnActionCondi"] = "namec$==$\"Sarok\";dist10yard$==$\"1\";",
					["OnActionEffet"] = "texte$Hey ! Tire sur mon doigt !\n<Sarok vous tend son gros doigt d'orc.>\n<Vous tirez dessus.>\n{son:Sound\\\\Character\\\\Gnome\\\\GnomeVocalMale\\\\GnomeMaleRaspberry01.wav}<Sarok pète alors soudainement.>\n{son:Sound\\\\Creature\\\\HeadlessHorseman\\\\Horseman_Laugh_01.wav}HAHAHAHA !$4;",
					["DireTab"] = "talk",
				},
				["009"] = {
					["OnActionCondi"] = "namec$==$\"Zazo\";dist10yard$==$\"1\";",
					["EtapesNum"] = "008",
					["OnActionEffet"] = "texte$Quoi ? Sana est folle de moi ?\nEt Gryshka l'a découvert ? Enfers !\nLa vérité est que ... Gryshka l'aubergiste et moi sommes ensembles ! Mais c'est un secret, personne ne doit le savoir. Car c'est interdit dans le métier.\nGryshka est très possessive et jalouse ... \n{anim083}{son:Sound\\\\Character\\\\Orc\\\\OrcMale\\\\OrcMaleSigh01.wav}Mais elle a une paire de fesses comme ... comme ...\nMais ce n'est pas le moment de parler de ça !\nJe m'occupe de calmer Gryshka. Allez voir Sana et dites lui simplement que mon corps appartient déjà à quelqu'un d'autre. Mais ne citez pas Gryshka !$4;quest$QUE00003$009$1;",
					["DireTab"] = "talk",
				},
			},
			["Etapes"] = {
				["007"] = {
					["Description"] = "Vous avez volé une lettre à Gryshka. Parler de la lettre à Morag le tavernier.",
				},
				["005"] = {
					["Description"] = "Doyo’da distraira Gryshka lorsque vous lui ferez signe. {bbbbbb}(/wave)",
				},
				["003"] = {
					["Description"] = "Vous avez découvert que Gryshka a volé quelque chose de précieux à Sana. Vous devriez en toucher un mot à Morag le tavernier.",
				},
				["008"] = {
					["Description"] = "Parlez à Zazo.",
				},
				["001"] = {
					["Description"] = "Morag le tavernier vous demande de l'aider à la taverne d'Orgrimmar.",
					["OnEtapeEffet"] = "texte$pas cible\n{questicon:INV_Letter_13}<Morag le tavernier de la taverne d'Orgrimmar, vous a envoyé une lettre :>\n{me}, j'ai besoin de vous. Nous avons actuellement un problème à la taverne. Je ne peux pas en dire plus, venez me voir !$4;",
				},
				["009"] = {
					["Description"] = "Allez parler à Sana.",
				},
				["004"] = {
					["Description"] = "Morag le tavernier vous a dit d'aller discuter avec Doyo’da.",
				},
				["011"] = {
					["Description"] = "Allez parler à Morag le tavernier.",
				},
				["002"] = {
					["Description"] = "Morag vous a demandé de trouver la source du conflit entre Gryshka et Sana. Parlez-leur, à elles et aux clients de la taverne.",
				},
				["012"] = {
					["Description"] = "Parlez à Zazo.",
				},
				["FinGood"] = {
					["Description"] = "Vous avez décidé de garder le secret et avez fait deux heureux.",
					["EtapeFlag"] = 3,
				},
				["FinBad"] = {
					["Description"] = "Vous avez dénoncé Gryshka auprès de Morag le tavernier. Et oui, les relations avec les clients sont strictement interdites !",
					["EtapeFlag"] = 3,
				},
			},
			["FouillerAction"] = {
				["006"] = {
					["OnActionCondi"] = "namec$==$\"Gryshka l'aubergiste\";dist10yard$==$\"1\";aurat(AUR00101)$>=$0;",
					["EtapesNum"] = "006",
					["OnActionEffet"] = "quest$QUE00003$007$1;objet$ITE00401$1$1;parole$dérobe une lettre à Gryshka.$2;son$Sound\\\\Interface\\\\PickUp\\\\PutDownParchment_Paper.wav$1$0;",
					["DireTab"] = "talk",
				},
			},
			["Createur"] = "Euphorine",
			["Icone"] = "Spell_BrokenHeart",
			["Nom"] = "Traîtresse ! (Coté Horde)",
			["Description"] = "Il s'en passe des choses bizarres à la taverne d'Orgrimmar",
			["bReinit"] = "true",
		},
		
		["QUE00002"] = { -- Traitresse ! Coté Alliance
			["DireAction"] = {
				["007"] = {
					["OnActionCondi"] = "namec$==$\"Reese Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "007",
					["OnActionEffet"] = "texte$Une lettre ? Montrez-moi cela.\n{son:Sound\\\\Character\\\\Human\\\\Male\\\\HumanMaleSigh01.wav}<Reese Langston lit la lettre en soupirant.>\nTout ça pour une histoire d'amour ... Il va falloir régler cela maintenant.\nAllez parler au concerné, celui qui se fait appeler Bartleby.$4;quest$QUE00002$008$1;objet$ITE00402$1$2;",
					["DireTab"] = "talk",
				},
				["017"] = {
					["OnActionCondi"] = "namec$==$\"David Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Oui, elles n'arrêtent jamais de se prendre le chou.\nMais je ne sais pas pourquoi. Le mieux est de leur demander directement non ?$4;",
					["DireTab"] = "talk",
				},
				["013"] = {
					["OnActionCondi"] = "namec$==$\"Elly Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "010",
					["OnActionEffet"] = "texte$C'est Erika ?! C'est donc pour cela qu'elle m'avait volé la lettre !\n{anim084}Maintenant que j'y pense ... Les relations sont interdites entre les serveuses et les clients !\nAllez le dire à mon père, Reese ! Il vous récompensera sûrement pour votre découverte !$4;quest$QUE00002$011$1;",
					["DireTab"] = "nod",
				},
				["003"] = {
					["OnActionCondi"] = "namec$==$\"Reese Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "003",
					["OnActionEffet"] = "texte$Alors, vous avez découvert quelque chose ?\nErika a volé quelque chose à Elly dites-vous ? Mais quoi donc ?\nMmh vous ne savez pas ... Et bien je crois qu'il ne nous reste plus qu'à chercher ... Mais je connais Erika, si elle a volé quelque chose, elle le garde sûrement sur elle.\nAllez demander à Stephen de vous conseiller, dites lui que c'est moi qui vous envoie. Il se trouve dans les cuisines.$4;quest$QUE00002$004$1;",
					["DireTab"] = "talk",
				},
				["023"] = {
					["OnActionCondi"] = "namec$==$\"Bartleby\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Un soucis entre Erika et Elly ?\nNon, je ne vois pas de quoi vous voulez parler ...$4;",
					["DireTab"] = "talk",
				},
				["016"] = {
					["OnActionCondi"] = "namec$==$\"Stephen Ryback\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Je vois tout, je sais tout ...\n... Mais je ne dis rien. Du moins pas gratuitement !\nMaintenant allez vous-en ! J'ai de la bidoche à découper.$4;",
					["DireTab"] = "talk",
				},
				["002"] = {
					["OnActionCondi"] = "namec$==$\"Elly Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002",
					["OnActionEffet"] = "texte$Oui, que désirez-vous ?\nCe qu'il y a entre Erika et moi ? Mais de quoi je me mèle ?\nElle m'a volé une chose qui m'est chère, voilà ce qu'il se passe !\nTant que cette truie ne m'aura pas rendu ce qui m'appartient, je continuerai de faire de sa vie un enfer !$4;quest$QUE00002$003$1;",
					["DireTab"] = "talk",
				},
				["012"] = {
					["OnActionCondi"] = "namec$==$\"Bartleby\";dist10yard$==$\"1\";",
					["EtapesNum"] = "012",
					["OnActionEffet"] = "texte$Oh merci grandement. Vous avez réglé le problème sans briser notre secret.\nErika et moi nous nous aimons vraiment vous savez. Cet amour fou et indescriptible.\nVoici pour vous remercier.\n<Bartleby vous donne une pièce d'or.>$4;quest$QUE00002$FinGood$1;or$10000$1;",
					["DireTab"] = "talk",
				},
				["022"] = {
					["OnActionCondi"] = "namec$==$\"Reese Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002",
					["OnActionEffet"] = "texte$Je ne comprends pas ... Elles étaient pourtant meilleures amies ...$4;",
					["DireTab"] = "talk",
				},
				["015"] = {
					["OnActionCondi"] = "namec$==$\"Harry Burlguard\";dist10yard$==$\"1\";",
					["OnActionEffet"] = "texte${anim137}Mmh ? Vous ... *hic* .... Vous voyez pô qu'chuis oc... *hic* ... occupé à boire ?$4;",
					["DireTab"] = "talk",
				},
				["005"] = {
					["OnActionCondi"] = "namec$==$\"Stephen Ryback\";",
					["EtapesNum"] = "005",
					["OnActionEffet"] = "quest$QUE00002$006$1;parole$|| Stephen plante son couteau dans le bois.$2;parole$|| Stephen crie : Hey Erika ! T'aurais pas un peu pris des fesses ?!$2;parole$|| Erika regarde Stephen en fronçant les sourcils.$2;aura$AUR00102$20$1$1;son$Sound\\\\Item\\\\Weapons\\\\Sword1H\\\\m1hSwordHitStone1a.wav$2$15;",
					["DireTab"] = "wave",
				},
				["011"] = {
					["OnActionCondi"] = "namec$==$\"Elly Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "010",
					["OnActionEffet"] = "texte${anim073}{son:Sound\\\\Character\\\\Draenei\\\\DraeneiMaleRaspberry01.wav}Allez au diable ! Je découvrirai bien un jour qui c'est ! Elle ne perd rien pour attendre !$4;quest$QUE00002$012$1;",
					["DireTab"] = "no",
				},
				["001"] = {
					["OnActionCondi"] = "namec$==$\"Reese Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "001",
					["OnActionEffet"] = "texte$Ah bien, vous voilà !\nJe n'en peux plus ... Erika la cuisinière et ma fille Elly n'arrêtent pas de s'engueuler. C'est pesant ! Et cela fait fuir la clientèle !\nS'il vous plait {me}, parlez-leur, à elles et aux autres clients. Trouvez la source du conflit et réglez ce problème ...$4;quest$QUE00002$002$1;",
					["DireTab"] = "talk",
				},
				["014"] = {
					["OnActionCondi"] = "namec$==$\"Reese Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "011",
					["OnActionEffet"] = "texte$De quoi ?! Ma cuisinière freluche avec un client ! Mais c'est interdit !\nElle sera virée sur le champ !\nJe vous remercie pour votre aide {me}. Voici de quoi vous récompenser.\n<Reese Langston vous donne 3 pièces d'or.>\nPartez maintenant. J'ai une cuisinière à licencier !$4;quest$QUE00002$FinBad$1;or$30000$1;",
					["DireTab"] = "talk",
				},
				["004"] = {
					["OnActionCondi"] = "namec$==$\"Stephen Ryback\";dist10yard$==$\"1\";",
					["EtapesNum"] = "004",
					["OnActionEffet"] = "texte$Vous voulez des conseils, à propos de quoi ?\nAh, je vois, vous voulez dérober quelque chose à Erika ... Mmmh voyons.\nVoilà ce que nous allons faire : lorsque vous serez prêt vous me ferez un signe. J'attirerai alors son attention et vous n'aurez plus qu'à vous glisser derrière elle et la fouiller !\nSoyez réactif hein !\nFaites moi signe lorsque vous serez prêt.$4;quest$QUE00002$005$1;",
					["DireTab"] = "talk",
				},
				["010"] = {
					["OnActionCondi"] = "namec$==$\"Elly Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "009",
					["OnActionEffet"] = "texte$DE QUOI !? Il en désire une autre ?\n{anim074}{son:Sound\\\\Character\\\\PlayerRoars\\\\CharacterRoarsHumanFemale.wav}RAAAAAAAAAAAH !\nQui ça ? Seriez-vous d'accord pour me donner son nom ? Que je lui arrache les yeux !\n<Choix : /oui ou /non>$4;quest$QUE00002$010$1;",
					["DireTab"] = "talk",
				},
				["008"] = {
					["OnActionCondi"] = "namec$==$\"Erika Tate\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Ce qu'il se passe entre elle et moi ?\nCette dinde est totalement dingue de ce poivrot de Bartleby.\nPourtant c'était ma meilleure amie ! Les amies se disent ce genre de chose ! Et bien non j'ai dû le découvrir moi même lorsque je suis tombée sur une lettre d'amour qu'elle comptait lui donner !\n{anim073}{son:Sound\\\\Character\\\\BloodElf\\\\BloodElfMaleRaspberry01.wav}Je lui en veux à mort !$4;",
					["DireTab"] = "talk",
				},
				["018"] = {
					["OnActionCondi"] = "namec$==$\"Kendor Kabonka\";dist10yard$==$\"1\";",
					["OnActionEffet"] = "texte$Hey ! Tire sur mon doigt !\n<Kendor vous tend son doigt.>\n<Vous tirez dessus.>\n{son:Sound\\\\Character\\\\Gnome\\\\GnomeVocalMale\\\\GnomeMaleRaspberry01.wav}<Kendor pète alors soudainement.>\n{son:Sound\\\\Creature\\\\HeadlessHorseman\\\\Horseman_Laugh_01.wav}HAHAHAHA !$4;",
					["DireTab"] = "talk",
				},
				["009"] = {
					["OnActionCondi"] = "namec$==$\"Bartleby\";dist10yard$==$\"1\";",
					["EtapesNum"] = "008",
					["OnActionEffet"] = "texte$Quoi ? Elly est folle de moi ?\nEt Erika l'a découvert ? Enfers !\nLa vérité est que ... Erika et moi sommes ensembles ! Mais c'est un secret, personne ne doit le savoir. Car c'est interdit dans le métier.\nErika est très possessive et jalouse ... Mais Elly aussi ...\n{anim083}{son:Sound\\\\Character\\\\NightElf\\\\NightElfMale\\\\NightElfMaleSigh01.wav}Mais elle a une paire de fesses comme ... comme ...\nMais ce n'est pas le moment de parler de ça !\nJe m'occupe de calmer Erika. Allez voir Elly et dites lui simplement que mon corps appartient déjà à quelqu'un d'autre. Mais ne citez pas Erika !$4;quest$QUE00002$009$1;",
					["DireTab"] = "talk",
				},
			},
			["Etapes"] = {
				["007"] = {
					["Description"] = "Vous avez volé une lettre à Erika. Parler de la lettre à Reese Langston.",
				},
				["005"] = {
					["Description"] = "Stephen Ryback distraira Erika lorsque vous lui ferez signe. {bbbbbb}(/wave)",
				},
				["003"] = {
					["Description"] = "Vous avez découvert qu'Erika a volé quelque chose de précieux à Elly. Vous devriez en toucher un mot à Reese Langston.",
				},
				["008"] = {
					["Description"] = "Parlez à Bartleby.",
				},
				["001"] = {
					["Description"] = "Reese Langston vous demande de l'aider à la taverne du Cochon siffleur, à Hurlevent.",
					["OnEtapeEffet"] = "texte$pas cible\n{questicon:INV_Letter_13}<Reese Langston de la taverne du Cochon siffleur, à Hurlevent, vous a envoyé une lettre :>\n{me}, j'ai besoin de vous. Nous avons actuellement un problème à la taverne. Je ne peux pas en dire plus, venez me voir !$4;",
				},
				["009"] = {
					["Description"] = "Allez parler à Elly.",
				},
				["004"] = {
					["Description"] = "Reese Langston vous a dit d'aller discuter avec Stephen Ryback.",
				},
				["011"] = {
					["Description"] = "Allez parler à Reese Langston.",
				},
				["002"] = {
					["Description"] = "Reese vous a demandé de trouver la source du conflit entre Erika et Elly. Parlez-leur, à elles et aux autres clients de la taverne.",
				},
				["012"] = {
					["Description"] = "Parlez à Bartleby.",
				},
				["FinGood"] = {
					["Description"] = "Vous avez décidé de garder le secret et avez fait deux heureux.",
					["EtapeFlag"] = 3,
				},
				["FinBad"] = {
					["Description"] = "Vous avez dénoncé Erika auprès de Reese Langston. Et oui, les relations entre le personnel et les clients sont strictement interdites !",
					["EtapeFlag"] = 3,
				},
			},
			["FouillerAction"] = {
				["006"] = {
					["OnActionCondi"] = "namec$==$\"Erika Tate\";dist10yard$==$\"1\";aurat(AUR00102)$>=$0;",
					["EtapesNum"] = "006",
					["OnActionEffet"] = "quest$QUE00002$007$1;objet$ITE00402$1$1;parole$dérobe une lettre à Erika.$2;son$Sound\\\\Interface\\\\PickUp\\\\PutDownParchment_Paper.wav$1$0;",
					["DireTab"] = "talk",
				},
			},
			["Createur"] = "Telkostrasz",
			["Icone"] = "Spell_BrokenHeart",
			["Nom"] = "Traîtresse ! (Coté Alliance)",
			["Description"] = "Il s'en passe des choses bizarres à la taverne du Cochon siffleur",
			["bReinit"] = true,
		},
	}
end

function TRP2_LoadDBQuests_2()
	TRP2_DB_Quests = {
		["QUE00001"] = {
			["Nom"] = "Quest";
			["Description"] = "A blank quest, with no data.",
			["bManual"] = false,
		},
		------------------------
		-- Exemples : 00002 à 00010
		------------------------
		["QUE00003"] = { -- Traitresse ! Coté Horde
			["DireAction"] = {
				["007"] = {
					["OnActionCondi"] = "namec$==$\"Barkeep Morag\";dist10yard$==$\"1\";",
					["EtapesNum"] = "007",
					["OnActionEffet"] = "texte$A letter? Show it to me.\n{son:Sound\\\\Character\\\\Tauren\\\\TaurenMale\\\\TaurenMaleSigh01.wav}<Barkeep Morag reads the letter and sighs.>\nAll that, just for a love affair... You must deal with it now.\nGo talk to the one called Zazo.$4;quest$QUE00003$008$1;objet$ITE00401$1$2;",
					["DireTab"] = "talk",
				},
				["017"] = {
					["OnActionCondi"] = "namec$==$\"Goma\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Yes, they're always bickering.\nI have no idea why. Why don't you ask them?$4;",
					["DireTab"] = "talk",
				},
				["013"] = {
					["OnActionCondi"] = "namec$==$\"Grunt Mojka\";dist10yard$==$\"1\";",
					["EtapesNum"] = "010",
					["OnActionEffet"] = "texte$It's Gryshka ?! So that's why she stole the letter from me!\n{anim084}Now that I think about it... There's a dating policy: waitresses and patrons are not supposed to get romantically involved!\nGo tell Barkeep Morag! He will surely reward you for this find!$4;quest$QUE00003$011$1;",
					["DireTab"] = "nod",
				},
				["003"] = {
					["OnActionCondi"] = "namec$==$\"Barkeep Morag\";dist10yard$==$\"1\";",
					["EtapesNum"] = "003",
					["OnActionEffet"] = "texte$So, did you find anything?\nGryshka stole something from Mojka, you say? What was it?\nMmh you don't know... Well, I guess all you have to do now is find out... Be careful though, I know Gryshka. If she stole something, she's probably got it with her.\nAsk Doyo’da for advice. Tell him I sent you.$4;quest$QUE00003$004$1;",
					["DireTab"] = "talk",
				},
				["023"] = {
					["OnActionCondi"] = "namec$==$\"Zazo\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Trouble between Gryshka and Mojka?\nNo, I have no idea what you're talking about...$4;",
					["DireTab"] = "talk",
				},
				["016"] = {
					["OnActionCondi"] = "namec$==$\"Doyo’da\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$I see all, I know all...\n... But I say nothing. At least, not for free!\nNow, sod off! My grog's getting cold.$4;",
					["DireTab"] = "talk",
				},
				["002"] = {
					["OnActionCondi"] = "namec$==$\"Grunt Mojka\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002",
					["OnActionEffet"] = "texte$Yes, what do you want?\nWhat's with  Gryshka and me? How's that any of your business?\nShe stole something from me, something dear, that's what!\nUnless that sow gives it back to me, I'll make sure her life's a nighmare!$4;quest$QUE00003$003$1;",
					["DireTab"] = "talk",
				},
				["012"] = {
					["OnActionCondi"] = "namec$==$\"Zazo\";dist10yard$==$\"1\";",
					["EtapesNum"] = "012",
					["OnActionEffet"] = "texte$Oh thanks a bunch. You solved the problem without exposing our secret.\nGryshka and I are really in love, you know. Crazy indescriptible love.\nHere, take this for your trouble.\n<Zazo gives you a gold coin.>$4;quest$QUE00003$FinGood$1;or$10000$1;",
					["DireTab"] = "talk",
				},
				["022"] = {
					["OnActionCondi"] = "namec$==$\"Barkeep Morag\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002",
					["OnActionEffet"] = "texte$I don't understand. They were best friends.$4;",
					["DireTab"] = "talk",
				},
				["015"] = {
					["OnActionCondi"] = "namec$==$\"Grunt Komak\";dist10yard$==$\"1\";",
					["OnActionEffet"] = "texte${anim137}Mmh? You ... *hic* ... Don'tcha see I'm... *hic* ... busy drinkin'?$4;",
					["DireTab"] = "talk",
				},
				["019"] = {
					["OnActionCondi"] = "namec$==$\"Gamon\";dist10yard$==$\"1\";",
					["OnActionEffet"] = "texte$Prepare for trouble!\nAnd make it double!\n{anim068}To protect the world from devastation!\nTo unite all people within our nation.\nTo denounce the evils of truth and love!\n{anim084}To extend our reach to the stars above!\n{anim082}Gamon, blast off at the speed of light!\n{anim074}Surrender now or prepare to fight!$4;",
					["DireTab"] = "talk",
				},
				["005"] = {
					["OnActionCondi"] = "namec$==$\"Doyo’da\";",
					["EtapesNum"] = "005",
					["OnActionEffet"] = "quest$QUE00003$006$1;parole$|| Doyo’da tosses his mug across the room.$2;parole$|| Doyo’da yells: That's bloody disgusting! The beer is lukewarm!$2;parole$|| Gryshka stares at Doyo’da with surprise.$2;aura$AUR00101$20$1$1;son$Sound\\\\Spells\\\\GlassBreaking1.wav$2$15;",
					["DireTab"] = "wave",
				},
				["011"] = {
					["OnActionCondi"] = "namec$==$\"Grunt Mojka\";dist10yard$==$\"1\";",
					["EtapesNum"] = "010",
					["OnActionEffet"] = "texte${anim073}{son:Sound\\\\Character\\\\Draenei\\\\DraeneiMaleRaspberry01.wav}Go to Hell! I will find out who that is, eventually! She's gonna be sorry!$4;quest$QUE00003$012$1;",
					["DireTab"] = "no",
				},
				["001"] = {
					["OnActionCondi"] = "namec$==$\"Barkeep Morag\";dist10yard$==$\"1\";",
					["EtapesNum"] = "001",
					["OnActionEffet"] = "texte$Why, you're here!\nI can't stand it anymore! Innkeeper Gryshka and Mojka won't stop yelling at each other. It's driving me nuts! And it's bad for business!\nPlease, {me}, talk to them, and to the customers too. Find out what the fuss is about and solve the problem for me.$4;quest$QUE00003$002$1;",
					["DireTab"] = "talk",
				},
				["014"] = {
					["OnActionCondi"] = "namec$==$\"Barkeep Morag\";dist10yard$==$\"1\";",
					["EtapesNum"] = "011",
					["OnActionEffet"] = "texte$What?! One of my waitresses is sleeping with a customer? But that's forbidden!\nShe's getting sacked right this moment!\nThanks for your help, {me}. Here's your reward.\n<Barkeep Morag gives you 3 gold coins.>\nLeave now. I've got a waitress to fire!$4;quest$QUE00003$FinBad$1;or$30000$1;",
					["DireTab"] = "talk",
				},
				["004"] = {
					["OnActionCondi"] = "namec$==$\"Doyo’da\";dist10yard$==$\"1\";",
					["EtapesNum"] = "004",
					["OnActionEffet"] = "texte$So, what kind of advice do you want?\nOh, I see. You want to steal from Gryshka... Mmmh, let's see.\nHere's what we're gonna do: As soon as you're ready, give me a sign. I will distract her. Then all you'll have to do is slip right behind her and search her pockets!\nBe creative, alright!\nWave when you're ready.$4;quest$QUE00003$005$1;",
					["DireTab"] = "talk",
				},
				["010"] = {
					["OnActionCondi"] = "namec$==$\"Grunt Mojka\";dist10yard$==$\"1\";",
					["EtapesNum"] = "009",
					["OnActionEffet"] = "texte$WHAT!? He's got the hots for another?\n{anim074}{son:Sound\\\\Character\\\\PlayerRoars\\\\CharacterRoarsOrcFemale.wav}RAAAAAAAAAAAH!\nWho's she? Would you give me her name? I want to tear her eyeballs out!\n<Choice: /yes or /no>$4;quest$QUE00003$010$1;",
					["DireTab"] = "talk",
				},
				["008"] = {
					["OnActionCondi"] = "namec$==$\"Innkeeper Gryshka\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$What's going on between us?\nThat gooze is crazy for the orc, Zazo, even though she used to be my best friend! Friends tell each other those sorts of things! Well no, I had to find out by myself, when I saw this love letter she wanted to give him!\n{anim073}{son:Sound\\\\Character\\\\BloodElf\\\\BloodElfMaleRaspberry01.wav}I wish she were dead!$4;",
					["DireTab"] = "talk",
				},
				["018"] = {
					["OnActionCondi"] = "namec$==$\"Sarok\";dist10yard$==$\"1\";",
					["OnActionEffet"] = "texte$Hey, you! Pull my finger!\n<Sarok points a big orkish finger at you.>\n<You pull.>\n{son:Sound\\\\Character\\\\Gnome\\\\GnomeVocalMale\\\\GnomeMaleRaspberry01.wav}<Sarok farts noisily.>\n{son:Sound\\\\Character\\\\Orc\\\\OrcMale\\\\OrcMaleLaugh01.wav}HAHAHAHA!$4;",
					["DireTab"] = "talk",
				},
				["009"] = {
					["OnActionCondi"] = "namec$==$\"Zazo\";dist10yard$==$\"1\";",
					["EtapesNum"] = "008",
					["OnActionEffet"] = "texte$What do you say? Mojka's crazy in love with me?\nAnd Gryshka found out? Hell!\nTruth is... Innkeeper Gryshka and I are in a relationship! It's a secret though. No one must know, cos it's forbidden by her boss.\n And Gryshka is vicously jealous... \n{anim083}{son:Sound\\\\Character\\\\Orc\\\\OrcMale\\\\OrcMaleSigh01.wav}But she's got a backside like... like...\nWhatever, there's not time to talk about that!\nI will deal with Gryshka. Go see Mojka and tell her that my heart belongs to someone else. But do not mention Gryshka!$4;quest$QUE00003$009$1;",
					["DireTab"] = "talk",
				},
			},
			["Etapes"] = {
				["007"] = {
					["Description"] = "You stole a letter from Gryshka. Talk to Barkeep Morag about it.",
				},
				["005"] = {
					["Description"] = "Doyo’da will distract Gryshka when you wave at him. {bbbbbb}(/wave)",
				},
				["003"] = {
					["Description"] = "You found out that Gryshka stole something important from Mojka. You should talk to Barkeep Morag about this.",
				},
				["008"] = {
					["Description"] = "Talk to Zazo.",
				},
				["001"] = {
					["Description"] = "Barkeep Morag needs your help in Orgrimmar.",
					["OnEtapeEffet"] = "texte$pas cible\n{questicon:INV_Letter_13}<Barkeep Morag of the Orgrimmar inn, sent you a letter:>\n{me}, I need your help. We've got trouble at the inn. Can't say more. Meet me there!$4;",
				},
				["009"] = {
					["Description"] = "Go talk to Mojka.",
				},
				["004"] = {
					["Description"] = "Barkeep Morag says you should chat with Doyo’da.",
				},
				["011"] = {
					["Description"] = "Go talk to Barkeep Morag.",
				},
				["002"] = {
					["Description"] = "Morag wants you to find the source of the conflict between Gryshka and Mojka. Talk to them and to the patrons in the inn.",
				},
				["012"] = {
					["Description"] = "Talk to Zazo.",
				},
				["FinGood"] = {
					["Description"] = "You decided to keep the secret and made two persons happy.",
					["EtapeFlag"] = 3,
				},
				["FinBad"] = {
					["Description"] = "You turned Gryshka in to Barkeep Morag. Well, yeah, waitresses can't date customers. That's unethical!",
					["EtapeFlag"] = 3,
				},
			},
			["FouillerAction"] = {
				["006"] = {
					["OnActionCondi"] = "namec$==$\"Innkeeper Gryshka\";dist10yard$==$\"1\";aurat(AUR00101)$>=$0;",
					["EtapesNum"] = "006",
					["OnActionEffet"] = "quest$QUE00003$007$1;objet$ITE00401$1$1;parole$steals a letter from Gryshka.$2;son$Sound\\\\Interface\\\\PickUp\\\\PutDownParchment_Paper.wav$1$0;",
					["DireTab"] = "talk",
				},
			},
			["Createur"] = "Euphorine",
			["Icone"] = "Spell_BrokenHeart",
			["Nom"] = "Traitoress! (Horde)",
			["Description"] = "Something fishy's going on in Orgrimmar",
			["bReinit"] = "true",
		},
		
		["QUE00002"] = { -- Traitresse ! Coté Alliance
			["DireAction"] = {
				["007"] = {
					["OnActionCondi"] = "namec$==$\"Reese Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "007",
					["OnActionEffet"] = "texte$A letter? Let me have a look.\n{son:Sound\\\\Character\\\\Human\\\\Male\\\\HumanMaleSigh01.wav}<Reese Langston reads the letter and sighs.>\nAll that in the name of love... You must put an end to this right now.\nGo talk to the man in question, the one called Bartleby.$4;quest$QUE00002$008$1;objet$ITE00402$1$2;",
					["DireTab"] = "talk",
				},
				["017"] = {
					["OnActionCondi"] = "namec$==$\"David Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Yes, they can't stop bickering.\nI have no idea why. Why don't you ask them yourself?$4;",
					["DireTab"] = "talk",
				},
				["013"] = {
					["OnActionCondi"] = "namec$==$\"Elly Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "010",
					["OnActionEffet"] = "texte$It's Erika?! So that's why she stole the letter from me!\n{anim084}Now that I think about it... They have a dating policy: no relationships between waitresses and patrons!\nGo tell my father, Reese! He will reward you for this find!$4;quest$QUE00002$011$1;",
					["DireTab"] = "nod",
				},
				["003"] = {
					["OnActionCondi"] = "namec$==$\"Reese Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "003",
					["OnActionEffet"] = "texte$So, did you find out anything?\nErika stole from Elly, you say? But what did she take?\nMmh you have no idea... Well, I guess you'll just have to find out... That being said, I know Erika. If she stole something, she's surely keeping it with her at all times.\nAsk Stephen for advice. Tell him I sent you. You'll find him in the kitchen.$4;quest$QUE00002$004$1;",
					["DireTab"] = "talk",
				},
				["023"] = {
					["OnActionCondi"] = "namec$==$\"Bartleby\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Trouble with Erika and Elly ?\nNay, I don't know what you're talking about.$4;",
					["DireTab"] = "talk",
				},
				["016"] = {
					["OnActionCondi"] = "namec$==$\"Stephen Ryback\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$I see all, I know all...\n... But I tell naught. Not for free at least!\nNow shoo! I got meat to slice.$4;",
					["DireTab"] = "talk",
				},
				["002"] = {
					["OnActionCondi"] = "namec$==$\"Elly Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002",
					["OnActionEffet"] = "texte$Yes, what can I do for you?\nWhat's between Erika and me? How's that any of your business?\nShe stole something important from me, that's what!\nUnless that sow gives it back, I'm going to make her pay!$4;quest$QUE00002$003$1;",
					["DireTab"] = "talk",
				},
				["012"] = {
					["OnActionCondi"] = "namec$==$\"Bartleby\";dist10yard$==$\"1\";",
					["EtapesNum"] = "012",
					["OnActionEffet"] = "texte$Oh, thanks a bunch. You solved the problem without exposing our secret.\nErika and I love each other very much, you know. A crazy and indescriptible love.\nHere's for your trouble.\n<Bartleby gives you a gold coin.>$4;quest$QUE00002$FinGood$1;or$10000$1;",
					["DireTab"] = "talk",
				},
				["022"] = {
					["OnActionCondi"] = "namec$==$\"Reese Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002",
					["OnActionEffet"] = "texte$I don't get it. They used to be best friends...$4;",
					["DireTab"] = "talk",
				},
				["015"] = {
					["OnActionCondi"] = "namec$==$\"Harry Burlguard\";dist10yard$==$\"1\";",
					["OnActionEffet"] = "texte${anim137}Mmh? Can ... *hic* .... Can'tcha see I'm... *hic* ... busy drinkin'?$4;",
					["DireTab"] = "talk",
				},
				["005"] = {
					["OnActionCondi"] = "namec$==$\"Stephen Ryback\";",
					["EtapesNum"] = "005",
					["OnActionEffet"] = "quest$QUE00002$006$1;parole$|| Stephen throws a knife in the woodwork.$2;parole$|| Stephen yells: Hey, Erika! Anyone ever told you your arse looks fat?!$2;parole$|| Erika frowns at Stephen.$2;aura$AUR00102$20$1$1;son$Sound\\\\Item\\\\Weapons\\\\Sword1H\\\\m1hSwordHitStone1a.wav$2$15;",
					["DireTab"] = "wave",
				},
				["011"] = {
					["OnActionCondi"] = "namec$==$\"Elly Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "010",
					["OnActionEffet"] = "texte${anim073}{son:Sound\\\\Character\\\\Draenei\\\\DraeneiMaleRaspberry01.wav}Go to Hell! I'll find out who she is sooner or later! She's gonna be sorry!$4;quest$QUE00002$012$1;",
					["DireTab"] = "no",
				},
				["001"] = {
					["OnActionCondi"] = "namec$==$\"Reese Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "001",
					["OnActionEffet"] = "texte$Why, there you are!\nI can't stand it any longer... Erika, the cook, and my daughter Elly won't stop yelling at each other. It's driving me crazy... and it's driving the customers away!\nPlease, {me}, talk to them, and to the patrons too. Find out what the fuss is about and put an end to it...$4;quest$QUE00002$002$1;",
					["DireTab"] = "talk",
				},
				["014"] = {
					["OnActionCondi"] = "namec$==$\"Reese Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "011",
					["OnActionEffet"] = "texte$What now?! My cook is having an affair with one of my customers? But that's against the rules!\nI'm sacking her right this instant!\nThanks for your help, {me}. Here's your reward.\n<Reese Langston gives you 3 gold coins.>\nLeave now. I've got a cook to fire!$4;quest$QUE00002$FinBad$1;or$30000$1;",
					["DireTab"] = "talk",
				},
				["004"] = {
					["OnActionCondi"] = "namec$==$\"Stephen Ryback\";dist10yard$==$\"1\";",
					["EtapesNum"] = "004",
					["OnActionEffet"] = "texte$What kind of advice do you want?\nOh, I see. You want to rob Erika... Mmmh let's see.\nHere's what we're gonna do: as soon as you're ready, give me a sign. I will distract her. Meanwhile, slip behind her and search her pockets!\nBe creative, alright!\nWave at me whe, you're ready.$4;quest$QUE00002$005$1;",
					["DireTab"] = "talk",
				},
				["010"] = {
					["OnActionCondi"] = "namec$==$\"Elly Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "009",
					["OnActionEffet"] = "texte$WHAT!? He's in love with another?\n{anim074}{son:Sound\\\\Character\\\\PlayerRoars\\\\CharacterRoarsHumanFemale.wav}RAAAAAAAAAAAH!\nWho's she? Would you give me her name? I'm going to claw her eyes out!\n<Choix : /yes or /no>$4;quest$QUE00002$010$1;",
					["DireTab"] = "talk",
				},
				["008"] = {
					["OnActionCondi"] = "namec$==$\"Erika Tate\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$What's happening between us?\nThat goose is all over that drunkard Bartleby.\nAnd she was my best friend! Friends tell each other these things, right? Yeah, well, I had to find out when I saw that love letter she was planning on sending him!\n{anim073}{son:Sound\\\\Character\\\\BloodElf\\\\BloodElfMaleRaspberry01.wav}I wish she were dead!$4;",
					["DireTab"] = "talk",
				},
				["018"] = {
					["OnActionCondi"] = "namec$==$\"Kendor Kabonka\";dist10yard$==$\"1\";",
					["OnActionEffet"] = "texte$Hey! Pull my finger!\n<Kendor points a finger at you.>\n<You pull.>\n{son:Sound\\\\Character\\\\Gnome\\\\GnomeVocalMale\\\\GnomeMaleRaspberry01.wav}<Kendor farts noisily.>\n{son:Sound\\\\Character\\\\Orc\\\\OrcMale\\\\OrcMaleLaugh01.wav}HAHAHAHA!$4;",
					["DireTab"] = "talk",
				},
				["009"] = {
					["OnActionCondi"] = "namec$==$\"Bartleby\";dist10yard$==$\"1\";",
					["EtapesNum"] = "008",
					["OnActionEffet"] = "texte$What? Elly's in love with me?\nAnd Erika found out? Hell!\nTruth be told... Erika and I are together! But it's a secret. You mustn't tell anyone, because that's forbidden in her line of work.\nErika is viciously jealous... But so is Elly...\n{anim083}{son:Sound\\\\Character\\\\NightElf\\\\NightElfMale\\\\NightElfMaleSigh01.wav}But she's got such a nice backside that ... well, I ...\nOh, whatever. There's no time for that!\nI'll deal with Erika. Go see Elly and just tell her my heart belongs to someone else. But please, don't involve Erika!$4;quest$QUE00002$009$1;",
					["DireTab"] = "talk",
				},
			},
			["Etapes"] = {
				["007"] = {
					["Description"] = "You stole a letter from Erika. Tell Reese Langston about it.",
				},
				["005"] = {
					["Description"] = "Stephen Ryback will distract Erika's attention. Wave at him when you're ready. {bbbbbb}(/wave)",
				},
				["003"] = {
					["Description"] = "You found out that Erika stole something important from Elly. Ask Reese Langston about it.",
				},
				["008"] = {
					["Description"] = "Talk to Bartleby.",
				},
				["001"] = {
					["Description"] = "Reese Langston asked for your help at the Pig and Whistle Tavern in Stormwind.",
					["OnEtapeEffet"] = "texte$pas cible\n{questicon:INV_Letter_13}<Reese Langston of the Pig and Whistle Tavern in Stormwind sent you a letter:>\n{me}, I need your help. We've got problems at the tavern. I can't elaborate now. Meet me there!$4;",
				},
				["009"] = {
					["Description"] = "Go talk to Elly.",
				},
				["004"] = {
					["Description"] = "Reese Langston wants you to talk to Stephen Ryback.",
				},
				["011"] = {
					["Description"] = "Go talk to Reese Langston.",
				},
				["002"] = {
					["Description"] = "Reese wants you to find out what's going on between Erika and Elly. Talk to them, and to the patrons in the tavern as well.",
				},
				["012"] = {
					["Description"] = "Talk to Bartleby.",
				},
				["FinGood"] = {
					["Description"] = "You decided to keep the affair secret and make two persons happy.",
					["EtapeFlag"] = 3,
				},
				["FinBad"] = {
					["Description"] = "You give Erika up to Reese Langston. Yeah well, there're rules about those sorts of things!",
					["EtapeFlag"] = 3,
				},
			},
			["FouillerAction"] = {
				["006"] = {
					["OnActionCondi"] = "namec$==$\"Erika Tate\";dist10yard$==$\"1\";aurat(AUR00102)$>=$0;",
					["EtapesNum"] = "006",
					["OnActionEffet"] = "quest$QUE00002$007$1;objet$ITE00402$1$1;parole$steals a letter from Erika.$2;son$Sound\\\\Interface\\\\PickUp\\\\PutDownParchment_Paper.wav$1$0;",
					["DireTab"] = "talk",
				},
			},
			["Createur"] = "Telkostrasz",
			["Icone"] = "Spell_BrokenHeart",
			["Nom"] = "Traitoress! (Alliance)",
			["Description"] = "Something fishy's going on at the Pig and Whistle Tavern.",
			["bReinit"] = true,
		},
	}
end

function TRP2_LoadDBQuests_3()
	TRP2_DB_Quests = {
		["QUE00001"] = {
			["Nom"] = "Misión";
			["Description"] = "Una misión en blanco, sin datos.",
			["bManual"] = false,
		},
		------------------------
		-- Exemples : 00002 à 00010
		------------------------
		["QUE00003"] = { -- Traitresse ! Coté Horde
			["DireAction"] = {
				["007"] = {
					["OnActionCondi"] = "namec$==$\"Camarero Morag\";dist10yard$==$\"1\";",
					["EtapesNum"] = "007",
					["OnActionEffet"] = "texte$¿Una carta? Enséñamela.\n{son:Sound\\\\Character\\\\Tauren\\\\TaurenMale\\\\TaurenMaleSigh01.wav}<Camarero Morag lee la carta y suspira.>\nTodo esto únicamente por una historia de amor... Deberías tratar este asunto inmediatamente.\nVe a hablar con ese tal Zazo.$4;quest$QUE00003$008$1;objet$ITE00401$1$2;",
					["DireTab"] = "talk",
				},
				["017"] = {
					["OnActionCondi"] = "namec$==$\"Goma\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Sí, no pueden dejar de reñir.\nNo tengo ni idea del motivo. ¿Por qué no les preguntas tú mismo?$4;",
					["DireTab"] = "talk",
				},
				["013"] = {
					["OnActionCondi"] = "namec$==$\"Bruta Mojka\";dist10yard$==$\"1\";",
					["EtapesNum"] = "010",
					["OnActionEffet"] = "texte$¡¿Es Gryshka?! ¡Así que por eso me robó la carta!\n{anim084}Ahora que lo pienso... ¡Están prohibidas las relaciones entre camareras y clientes!\n¡Vete a decírselo a Morag! ¡Seguramente te recompensará por este descubrimiento!$4;quest$QUE00003$011$1;",
					["DireTab"] = "nod",
				},
				["003"] = {
					["OnActionCondi"] = "namec$==$\"Camarero Morag\";dist10yard$==$\"1\";",
					["EtapesNum"] = "003",
					["OnActionEffet"] = "texte$¿De modo que has averiguado algo?\n¿Dices que Gryshka robó algo a Mojka? ¿Pero qué?\nMmh, no tienes ni idea... Bueno, supongo que todo lo que tienes que hacer ahora es descubrir de que se trata... Pero ten cuidado, conozco a Gryshka. Si robó algo probablemente lo lleve encima.\nPídele consejo a Doyo’da. Dile que te envio yo.$4;quest$QUE00003$004$1;",
					["DireTab"] = "talk",
				},
				["023"] = {
					["OnActionCondi"] = "namec$==$\"Zazo\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$¿Problemas entre Gryshka y Mojka?\nNo, no tengo ni idea de lo que estás hablando...$4;",
					["DireTab"] = "talk",
				},
				["016"] = {
					["OnActionCondi"] = "namec$==$\"Doyo’da\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Lo veo todo, lo sé todo...\n... Pero no diré nada. ¡O al menos no gratis!\n¡Ahora, piérdete! Mi grog se está enfriando.$4;",
					["DireTab"] = "talk",
				},
				["002"] = {
					["OnActionCondi"] = "namec$==$\"Bruta Mojka\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002",
					["OnActionEffet"] = "texte$¿Si, qué quieres?\n¿Qué pasa con Gryshka y conmigo? ¿No tienes nada mejor que hacer?\n¡Me robó algo, algo muy querido, eso pasa!\n¡Hasta que esa puerca me devuelva lo que es mio, me aseguraré de convertir su vida en una pesadilla!$4;quest$QUE00003$003$1;",
					["DireTab"] = "talk",
				},
				["012"] = {
					["OnActionCondi"] = "namec$==$\"Zazo\";dist10yard$==$\"1\";",
					["EtapesNum"] = "012",
					["OnActionEffet"] = "texte$Oh, muchas gracias. Has solucionado este embrollo sin descubrir nuestro secreto.\nGryshka y yo estamos realmente enamorados, ya sabes. Loco amor indescriptible.\nTen, toma esto por las molestias.\n<Zazo te da una moneda de oro.>$4;quest$QUE00003$FinGood$1;or$10000$1;",
					["DireTab"] = "talk",
				},
				["022"] = {
					["OnActionCondi"] = "namec$==$\"Camarero Morag\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002",
					["OnActionEffet"] = "texte$No lo entiendo. Eran buenas amigas.$4;",
					["DireTab"] = "talk",
				},
				["015"] = {
					["OnActionCondi"] = "namec$==$\"Bruto Komak\";dist10yard$==$\"1\";",
					["OnActionEffet"] = "texte${anim137}¿Mmh? ¿No... *hic* ... no ves... *hic* ... que estoy ocupado bebiendo?$4;",
					["DireTab"] = "talk",
				},
				["019"] = {
					["OnActionCondi"] = "namec$==$\"Gamon\";dist10yard$==$\"1\";",
					["OnActionEffet"] = "texte$¿Tienes problemas?\n¡Pues escucha mi lema!\n{anim068}¡Para proteger al mundo de la devastación!\n¡Para unir a todos los pueblos en una sola nación!\n¡Para denunciar a los enemigos de la verdad y el amor!\n{anim084}¡Para extender nuestro poder más allá del espacio exterior!\n{anim082}¡Gamon despega a la velocidad de la luz!\n{anim074}¡Ríndete ahora o prepárate para luchar!$4;",
					["DireTab"] = "talk",
				},
				["005"] = {
					["OnActionCondi"] = "namec$==$\"Doyo’da\";",
					["EtapesNum"] = "005",
					["OnActionEffet"] = "quest$QUE00003$006$1;parole$|| Doyo’da tira su jarra al suelo.$2;parole$|| Doyo’da grita: ¡Esto está repugnante! ¡La cerveza está caliente!$2;parole$|| Gryshka mira a Doyo’da con sorpresa.$2;aura$AUR00101$20$1$1;son$Sound\\\\Spells\\\\GlassBreaking1.wav$2$15;",
					["DireTab"] = "wave",
				},
				["011"] = {
					["OnActionCondi"] = "namec$==$\"Bruta Mojka\";dist10yard$==$\"1\";",
					["EtapesNum"] = "010",
					["OnActionEffet"] = "texte${anim073}{son:Sound\\\\Character\\\\Draenei\\\\DraeneiMaleRaspberry01.wav}¡Vete al infierno! ¡Voy a averiguar quién es, tarde o temprano! ¡Se arrepentirá!$4;quest$QUE00003$012$1;",
					["DireTab"] = "no",
				},
				["001"] = {
					["OnActionCondi"] = "namec$==$\"Camarero Morag\";dist10yard$==$\"1\";",
					["EtapesNum"] = "001",
					["OnActionEffet"] = "texte$¡Ah, bien, has llegado!\n¡No puedo soportarlo más! La tabernera Gryshka y Mojka no dejan de gritarse la una a la otra. ¡Me están volviendo loco! ¡Y es malo para el negocio!\nPor favor, {me}, habla con ellas, y también con los clientes. Averigüa a qué viene tanto jaleo y solucionalo.$4;quest$QUE00003$002$1;",
					["DireTab"] = "talk",
				},
				["014"] = {
					["OnActionCondi"] = "namec$==$\"Camarero Morag\";dist10yard$==$\"1\";",
					["EtapesNum"] = "011",
					["OnActionEffet"] = "texte$¿Qué? ¿Una de mis camareras se acuesta con un cliente? ¡Pero eso está prohibido!\n¡La voy a despedir ahora mismo!\nGracias por tu ayuda, {me}. Aquí tienes tu recompensa.\n<Camarero Morag te da tres monedas de oro.>\nVete ahora. ¡Tengo que despedir a una camarera!$4;quest$QUE00003$FinBad$1;or$30000$1;",
					["DireTab"] = "talk",
				},
				["004"] = {
					["OnActionCondi"] = "namec$==$\"Doyo’da\";dist10yard$==$\"1\";",
					["EtapesNum"] = "004",
					["OnActionEffet"] = "texte$¿Qué tipo de consejo necesitas?\nOh, ya veo. Quieres quitarle algo a Gryshka... Mmmh, vamos a ver.\nEsto es lo que vamos a hacer: tan pronto como estés listo, hazme una señal. Voy a distraerla. ¡Mientras tanto aprovecha para buscar en sus bolsillos!\nTen cuidado.\nAvísame cuando estés listo.$4;quest$QUE00003$005$1;",
					["DireTab"] = "talk",
				},
				["010"] = {
					["OnActionCondi"] = "namec$==$\"Bruta Mojka\";dist10yard$==$\"1\";",
					["EtapesNum"] = "009",
					["OnActionEffet"] = "texte$¿¡QUÉ!? ¿Él desea a otra?\n{anim074}{son:Sound\\\\Character\\\\PlayerRoars\\\\CharacterRoarsOrcFemale.wav}RAAAAAAAAAAAH!\n¿Quién es? ¿Podrías decirme su nombre? ¡Voy a sacarle los ojos!\n<Elige: /sí o /no>$4;quest$QUE00003$010$1;",
					["DireTab"] = "talk",
				},
				["008"] = {
					["OnActionCondi"] = "namec$==$\"Tabernera Gryshka\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$¿Qué nos pasa?\nEsa arpía está loca por ese orco, Zazo.\n¡Y ella era mi mejor amiga! ¡Las amigas se cuentan estas cosas! ¡Bueno, no hizo falta cuando encontré la carta de amor que ella le había dado!\n{anim073}{son:Sound\\\\Character\\\\BloodElf\\\\BloodElfMaleRaspberry01.wav}¡Ojalá se muera!$4;",
					["DireTab"] = "talk",
				},
				["018"] = {
					["OnActionCondi"] = "namec$==$\"Sarok\";dist10yard$==$\"1\";",
					["OnActionEffet"] = "texte$¡Eh, tú! ¡Tira de mi dedo!\n<Sarok te tiende su dedazo orco.>\n<Tiras del dedo.>\n{son:Sound\\\\Character\\\\Gnome\\\\GnomeVocalMale\\\\GnomeMaleRaspberry01.wav}<Sarok se tira un pedo.>\n{son:Sound\\\\Character\\\\Orc\\\\OrcMale\\\\OrcMaleLaugh01.wav}¡JAJAJAJA!$4;",
					["DireTab"] = "talk",
				},
				["009"] = {
					["OnActionCondi"] = "namec$==$\"Zazo\";dist10yard$==$\"1\";",
					["EtapesNum"] = "008",
					["OnActionEffet"] = "texte$¿Qué dices? ¿Mojka está loca por mí?\n¿Y Gryshka se enteró? ¡Demonios!\n¡La verdad es que... ¡Gryshka y yo tenémos una relación! Pero es un secreto, nadie debe saberlo. Su jefe no le deja intimar con los clientes.\n Y Gryshka es brutalmente celosa... \n{anim083}{son:Sound\\\\Character\\\\Orc\\\\OrcMale\\\\OrcMaleSigh01.wav}Aunque tiene un trasero como... como...\n¡Lo que sea, no hay tiempo para hablar de esto!\nVoy a hablar con Gryshka. Vete a hablar con Mojka y dile que mi corazón pertenece a otra. ¡Pero no menciones a Gryshka!$4;quest$QUE00003$009$1;",
					["DireTab"] = "talk",
				},
			},
			["Etapes"] = {
				["007"] = {
					["Description"] = "Robaste una carta a Gryshka. Habla con Morag al respecto.",
				},
				["005"] = {
					["Description"] = "Doyo’da distraerá a Gryshka cuando le hagas una señal. {bbbbbb}(/wave)",
				},
				["003"] = {
					["Description"] = "Descubres que Gryshka robó algo importante para Mojka. Deberías hablar con Morag sobre ello.",
				},
				["008"] = {
					["Description"] = "Habla con Zazo.",
				},
				["001"] = {
					["Description"] = "Camarero Morag necesita tu ayuda en Orgrimmar.",
					["OnEtapeEffet"] = "texte$pas cible\n{questicon:INV_Letter_13}<Morag, el camarero de la taberna de Orgrimmar, te ha enviado una carta:>\n{me}, necesito tu ayuda. Tenemos un problema en la taberna. No puede decirte más. ¡Reúnete conmigo en la taberna!$4;",
				},
				["009"] = {
					["Description"] = "Vete a hablar con Mojka.",
				},
				["004"] = {
					["Description"] = "Camarero Morag dice que deberías charlar con Doyo’da.",
				},
				["011"] = {
					["Description"] = "Vete a hablar con Morag.",
				},
				["002"] = {
					["Description"] = "Morag quiere que descubras por qué riñen Gryshka y Mojka. Habla con ellas y también con los clientes de la taberna.",
				},
				["012"] = {
					["Description"] = "Habla con Zazo.",
				},
				["FinGood"] = {
					["Description"] = "Decides mantener el secreto y hacer felices a dos personas.",
					["EtapeFlag"] = 3,
				},
				["FinBad"] = {
					["Description"] = "Le cuentas todo a Morag. ¡Las camareras no pueden salir con los clientes! ¡Es inmoral!",
					["EtapeFlag"] = 3,
				},
			},
			["FouillerAction"] = {
				["006"] = {
					["OnActionCondi"] = "namec$==$\"Tabernera Gryshka\";dist10yard$==$\"1\";aurat(AUR00101)$>=$0;",
					["EtapesNum"] = "006",
					["OnActionEffet"] = "quest$QUE00003$007$1;objet$ITE00401$1$1;parole$roba una carta a Gryshka.$2;son$Sound\\\\Interface\\\\PickUp\\\\PutDownParchment_Paper.wav$1$0;",
					["DireTab"] = "talk",
				},
			},
			["Createur"] = "Euphorine",
			["Icone"] = "Spell_BrokenHeart",
			["Nom"] = "¡Traidora! (Horda)",
			["Description"] = "Algo raro está pasando en la taberna de Orgrimmar",
			["bReinit"] = "true",
		},
		
		["QUE00002"] = { -- Traitresse ! Coté Alliance
			["DireAction"] = {
				["007"] = {
					["OnActionCondi"] = "namec$==$\"Reese Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "007",
					["OnActionEffet"] = "texte$¿Una carta? Déjame echar un vistazo.\n{son:Sound\\\\Character\\\\Human\\\\Male\\\\HumanMaleSigh01.wav}<Reese Langston lee la carta y suspira.>\nTodo esto por amor... Deberías poner fin a este asunto ahora mismo.\nVe a hablar con el hombre en cuestión, el tal Bartleby.$4;quest$QUE00002$008$1;objet$ITE00402$1$2;",
					["DireTab"] = "talk",
				},
				["017"] = {
					["OnActionCondi"] = "namec$==$\"David Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Sí, no pueden dejar de reñir.\nNo tengo ni idea del motivo. ¿Por qué no les preguntas tú mismo?$4;",
					["DireTab"] = "talk",
				},
				["013"] = {
					["OnActionCondi"] = "namec$==$\"Elly Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "010",
					["OnActionEffet"] = "texte$¡¿Es Erika?! ¡Así que por eso me robó la carta!\n{anim084}Ahora que lo pienso... ¡Están prohibidas las relaciones entre camareras y clientes!\n¡Vete a decírselo a Reese, mi padre! Te recompensará por este descubrimiento!$4;quest$QUE00002$011$1;",
					["DireTab"] = "nod",
				},
				["003"] = {
					["OnActionCondi"] = "namec$==$\"Reese Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "003",
					["OnActionEffet"] = "texte$¿De modo que has averiguado algo?\n¿Dices que Erika le robó algo a Elly? ¿Pero qué?\nMmh, no tienes ni idea... Bueno, supongo que tendrás que descubrirlo ... Dicho esto, conozco a Erika. Si robó algo, seguramente lo mantiene con ella en todo momento.\nPide consejo a Stephen. Dile que te envio. Lo encontrarás en la cocina.$4;quest$QUE00002$004$1;",
					["DireTab"] = "talk",
				},
				["023"] = {
					["OnActionCondi"] = "namec$==$\"Bartleby\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$¿Problemas con Erika y Elly?\nNo, no sé de que estás hablando.$4;",
					["DireTab"] = "talk",
				},
				["016"] = {
					["OnActionCondi"] = "namec$==$\"Stephen Lomocenteno\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Lo veo todo, lo sé todo...\n... Pero no diré nada. ¡O al menos no gratis!\n¡Ahora largo! Tengo carne que deshuesar.$4;",
					["DireTab"] = "talk",
				},
				["002"] = {
					["OnActionCondi"] = "namec$==$\"Elly Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002",
					["OnActionEffet"] = "texte$¿Si, qué puedo hacer por ti?\n¿Qué pasa con Erika y conmigo? ¿No tienes nada mejor que hacer?\n¡Ella me robó algo importante, eso es todo!\n¡Hasta que esa puerca no me devuelva lo que es mio, voy a seguir haciendo de su vida un infierno!$4;quest$QUE00002$003$1;",
					["DireTab"] = "talk",
				},
				["012"] = {
					["OnActionCondi"] = "namec$==$\"Bartleby\";dist10yard$==$\"1\";",
					["EtapesNum"] = "012",
					["OnActionEffet"] = "texte$Oh, muchas gracias. Has solucionado este embrollo sin descubrir nuestro secreto.\nErika y yo nos amamos mucho, ya sabes. Un amor loco e indescriptible.\nEsto es por las molestias.\n<Bartleby te da una moneda de oro.>$4;quest$QUE00002$FinGood$1;or$10000$1;",
					["DireTab"] = "talk",
				},
				["022"] = {
					["OnActionCondi"] = "namec$==$\"Reese Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002",
					["OnActionEffet"] = "texte$No no lo entiendo. Eran buenas amigas...$4;",
					["DireTab"] = "talk",
				},
				["015"] = {
					["OnActionCondi"] = "namec$==$\"Harry Burlguard\";dist10yard$==$\"1\";",
					["OnActionEffet"] = "texte${anim137}¿Mmh? ¿No... *hic* ... no ves... *hic* ... que estoy ocupado bebiendo?$4;",
					["DireTab"] = "talk",
				},
				["005"] = {
					["OnActionCondi"] = "namec$==$\"Stephen Lomocenteno\";",
					["EtapesNum"] = "005",
					["OnActionEffet"] = "quest$QUE00002$006$1;parole$|| Stephen deja el cuchillo sobre la mesa.$2;parole$|| Stephen grita: ¡Ey, Erika! ¡¿Alguien te ha dicho alguna vez que tu culo es gordo?!$2;parole$|| Erika frunce el ceño ante Stephen.$2;aura$AUR00102$20$1$1;son$Sound\\\\Item\\\\Weapons\\\\Sword1H\\\\m1hSwordHitStone1a.wav$2$15;",
					["DireTab"] = "wave",
				},
				["011"] = {
					["OnActionCondi"] = "namec$==$\"Elly Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "010",
					["OnActionEffet"] = "texte${anim073}{son:Sound\\\\Character\\\\Draenei\\\\DraeneiMaleRaspberry01.wav}¡Vete al infierno! ¡Voy a averiguar quién es ella, tarde o temprano! ¡Se arrepentirá!$4;quest$QUE00002$012$1;",
					["DireTab"] = "no",
				},
				["001"] = {
					["OnActionCondi"] = "namec$==$\"Reese Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "001",
					["OnActionEffet"] = "texte$¡Ah, bien, has llegado!\nNo puedo soportarlo más... Erika, la cocinera, y mi hija Elly no dejan de gritarse la una a la otra. Me están volviendo loco... ¡Y ahuyentan a la clientela!\nPor favor, {me}, habla con ellas y también con los clientes. Averigüa a qué viene tanto revuelo y pon fin a esta situación...$4;quest$QUE00002$002$1;",
					["DireTab"] = "talk",
				},
				["014"] = {
					["OnActionCondi"] = "namec$==$\"Reese Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "011",
					["OnActionEffet"] = "texte$¿Y ahora qué?! ¿Mi cocinera está teniendo un romance con uno de mis clientes? ¡Pero eso va contra las normas!\n¡La despediré ahora mismo!\nGracias por tu ayuda, {me}. Aquí está tu recompensa.\n<Reese Langston te da tres monedas de oro.>\nAhora vete. Tengo una olla en el fuego.$4;quest$QUE00002$FinBad$1;or$30000$1;",
					["DireTab"] = "talk",
				},
				["004"] = {
					["OnActionCondi"] = "namec$==$\"Stephen Lomocenteno\";dist10yard$==$\"1\";",
					["EtapesNum"] = "004",
					["OnActionEffet"] = "texte$¿Qué tipo de consejo necesitas?\nOh, ya veo. Quieres quitarle algo a Erika... Mmmh, vamos a ver.\nEsto es lo que vamos a hacer: tan pronto como estés listo, hazme una señal. Voy a distraerla. ¡Mientras tanto aprovecha para buscar en sus bolsillos!\nTen cuidado.\nAvísame cuando estés listo.$4;quest$QUE00002$005$1;",
					["DireTab"] = "talk",
				},
				["010"] = {
					["OnActionCondi"] = "namec$==$\"Elly Langston\";dist10yard$==$\"1\";",
					["EtapesNum"] = "009",
					["OnActionEffet"] = "texte$¿¡QUÉ!? ¿Él está enamorado de otra?\n{anim074}{son:Sound\\\\Character\\\\PlayerRoars\\\\CharacterRoarsHumanFemale.wav}RAAAAAAAAAAAH!\n¿Quién es? ¿Podrías decirme su nombre? ¡Voy a sacarle los ojos!\n<Elige : /sí o /no>$4;quest$QUE00002$010$1;",
					["DireTab"] = "talk",
				},
				["008"] = {
					["OnActionCondi"] = "namec$==$\"Erika Tate\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$¿Qué nos pasa?\nEsa arpía está loca por ese borracho de Bartleby.\n¡Y ella era mi mejor amiga! ¡Las amigas se cuentan estas cosas! ¡Bueno, no hizo falta cuando encontré la carta de amor que ella le había dado!\n{anim073}{son:Sound\\\\Character\\\\BloodElf\\\\BloodElfMaleRaspberry01.wav}¡Ojalá se muera!$4;",
					["DireTab"] = "talk",
				},
				["018"] = {
					["OnActionCondi"] = "namec$==$\"Kendor Kabonka\";dist10yard$==$\"1\";",
					["OnActionEffet"] = "texte$¡Ey, tú! ¡Tira de mi dedo!\n<Kendor te tiende el dedo.>\n<Tiras del dedo.>\n{son:Sound\\\\Character\\\\Gnome\\\\GnomeVocalMale\\\\GnomeMaleRaspberry01.wav}<Kendor se tira un pedo.>\n{son:Sound\\\\Character\\\\Orc\\\\OrcMale\\\\OrcMaleLaugh01.wav}¡JAJAJAJA!$4;",
					["DireTab"] = "talk",
				},
				["009"] = {
					["OnActionCondi"] = "namec$==$\"Bartleby\";dist10yard$==$\"1\";",
					["EtapesNum"] = "008",
					["OnActionEffet"] = "texte$¿Qué? ¿Elly está enamorada de mí?\n¿Y Erika se enteró? ¡Demonios!\nLa verdad sea dicha... ¡Erika y yo estamos juntos! Pero es un secreto, no debes decirselo a nadie. Ella tiene prohibido relacionarse con los clientes.\nErika es ferozmente celosa... Pero también lo es Elly.\n{anim083}{son:Sound\\\\Character\\\\NightElf\\\\NightElfMale\\\\NightElfMaleSigh01.wav}Aunque tiene un bonito trasero que... bueno, yo...\n¡Oh, lo que sea! ¡No es momento para esto!\nVoy a hablar con Erika. Vete a ver a Elly y dile que mi corazón pertenece a otra persona. ¡Pero, por favor, no menciones a Erika!$4;quest$QUE00002$009$1;",
					["DireTab"] = "talk",
				},
			},
			["Etapes"] = {
				["007"] = {
					["Description"] = "Robaste una carta a Erika. Habla con Reese Langston al respecto.",
				},
				["005"] = {
					["Description"] = "Stephen Lomocenteno distraerá a Erika cuando le hagas una señal. {bbbbbb}(/wave)",
				},
				["003"] = {
					["Description"] = "Descubres que Erika robó algo importante para Elly. Deberías hablar con Reese Langston sobre ello.",
				},
				["008"] = {
					["Description"] = "Habla con Bartleby.",
				},
				["001"] = {
					["Description"] = "Reese Langston te ha pedido ayuda en la taberna El Cerdo Borracho de Ventormenta.",
					["OnEtapeEffet"] = "texte$pas cible\n{questicon:INV_Letter_13}<Reese Langston, el tabernero de El Cerdo Borracho de Ventormenta, te ha enviado una carta:>\n{me}, necesito tu ayuda. Tenemos problemas en la taberna. No puede darte más detalles ahora. ¡Reúnete conmigo en la taberna!$4;",
				},
				["009"] = {
					["Description"] = "Vete a hablar con Elly.",
				},
				["004"] = {
					["Description"] = "Reese Langston quiere que hables con Stephen Lomocenteno.",
				},
				["011"] = {
					["Description"] = "Vete a hablar con Reese Langston.",
				},
				["002"] = {
					["Description"] = "Reese quiere que descubras por qué riñen Erika y Elly. Habla con ellas y también con los clientes de la taberna.",
				},
				["012"] = {
					["Description"] = "Habla con Bartleby.",
				},
				["FinGood"] = {
					["Description"] = "Decides mantener el secreto y hacer felices a dos personas.",
					["EtapeFlag"] = 3,
				},
				["FinBad"] = {
					["Description"] = "Le cuentas todo a Reese Langston. ¡Las relaciones entre camareras y clientes deben estar estrictamente prohibidas!",
					["EtapeFlag"] = 3,
				},
			},
			["FouillerAction"] = {
				["006"] = {
					["OnActionCondi"] = "namec$==$\"Erika Tate\";dist10yard$==$\"1\";aurat(AUR00102)$>=$0;",
					["EtapesNum"] = "006",
					["OnActionEffet"] = "quest$QUE00002$007$1;objet$ITE00402$1$1;parole$roba una carta a Erika.$2;son$Sound\\\\Interface\\\\PickUp\\\\PutDownParchment_Paper.wav$1$0;",
					["DireTab"] = "talk",
				},
			},
			["Createur"] = "Telkostrasz",
			["Icone"] = "Spell_BrokenHeart",
			["Nom"] = "¡Traidora! (Alianza)",
			["Description"] = "Algo raro está pasando en la taberna de El Cerdo Borracho.",
			["bReinit"] = true,
		},
	};
end

function TRP2_LoadDBQuests_4()
	TRP2_DB_Quests = {
		["QUE00001"] = {
			["Nom"] = "Quest";
			["Description"] = "Eine leere Quest, ohne Inhalt.",
			["bManual"] = false,
		},
		------------------------
		-- Exemples : 00002 à 00010
		------------------------
		["QUE00003"] = { -- Traitresse ! Coté Horde
			["DireAction"] = {
				["007"] = {
					["OnActionCondi"] = "namec$==$\"Barkeeper Morag\";dist10yard$==$\"1\";",
					["EtapesNum"] = "007",
					["OnActionEffet"] = "texte$Ein Brief? Zeigt ihn mir.\n{son:Sound\\\\Character\\\\Tauren\\\\TaurenMale\\\\TaurenMaleSigh01.wav}<Barkeeper Morag liest den Brief und seufzt.>\nAll dies, nur wegen einer Liebesbeziehung... damit müssen wir wohl nun leben.\nSuch Zazo und sprech mit ihm darüber.$4;quest$QUE00003$008$1;objet$ITE00401$1$2;",
					["DireTab"] = "talk",
				},
				["017"] = {
					["OnActionCondi"] = "namec$==$\"Goma\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Ja, sie zanken sich andauernd.\nIch habe keine Ahnung warum. Vielleicht solltet ihr sie selbst fragen?$4;",
					["DireTab"] = "talk",
				},
				["013"] = {
					["OnActionCondi"] = "namec$==$\"Grunzer Mojka\";dist10yard$==$\"1\";",
					["EtapesNum"] = "010",
					["OnActionEffet"] = "texte$Es ist Gryshka?! Das würde erklären warum sie mir den Brief gestohlen hat!\n{anim084}Nun wo ich darüber nachdenke... Da gibt es eine Beziehungsklausel im Vertrag: Angestellte dürfen sich nicht auf eine romantische Beziehung mit Kunden einlassen!\nGeht und erzählt es Barkeeper Morag! Er wird euch sicherlich für eure Recherche belohnen!$4;quest$QUE00003$011$1;",
					["DireTab"] = "nod",
				},
				["003"] = {
					["OnActionCondi"] = "namec$==$\"Barkeeper Morag\";dist10yard$==$\"1\";",
					["EtapesNum"] = "003",
					["OnActionEffet"] = "texte$So, habt ihr was herausgefunden?\nGryshka hat was von Mojka gestohlen, sagt ihr? Was war es?\nHmm, ihr wisst es nicht... Nun gut, ich schätze ihr solltet es als erstes in Erfahrung bringen... Seit jedoch vorsichtig, I kenne Gryshka. Wenn sie etwas gestohlen hat, trägt sie es sicherlich die ganze Zeit bei sich.\nLasst euch von Doyo’da beraten. Sagt ihm, das ich euch gesandt habe.$4;quest$QUE00003$004$1;",
					["DireTab"] = "talk",
				},
				["023"] = {
					["OnActionCondi"] = "namec$==$\"Zazo\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Probleme zwischen Gryshka und Mojka?\nNö, ich habe keine Ahnung wovon ihr da sprecht...$4;",
					["DireTab"] = "talk",
				},
				["016"] = {
					["OnActionCondi"] = "namec$==$\"Doyo’da\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Ich sehn alles, wissn alles...\n...aber sagen nichs. Zumindes, nich Umsonst!\nNun, lassn mich inruh! Mein Grog werden langsam kalt.$4;",
					["DireTab"] = "talk",
				},
				["002"] = {
					["OnActionCondi"] = "namec$==$\"Grunzer Mojka\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002",
					["OnActionEffet"] = "texte$Ja, was wollt ihr?\nWas ist mit Gryshka und mir? Warum sollte es euch etwas angehen?\nSie hat mir etwas gestohlen... etwas wertvolles, das ist es!\nSollte diese Scharbe es mir nicht zurück geben, werde ich dafür sorgen das ihr Leben ganz sicher zu einem Alptraum wird!$4;quest$QUE00003$003$1;",
					["DireTab"] = "talk",
				},
				["012"] = {
					["OnActionCondi"] = "namec$==$\"Zazo\";dist10yard$==$\"1\";",
					["EtapesNum"] = "012",
					["OnActionEffet"] = "texte$Oh vielen Dank. Du hast das Problem gelöst, ohne unser Geheimnis zu verraten.\nDu musst wissen, Gryshka und ich sind wirklich zusammen. Wir sind unvorstellbar ineinander verliebt.\nHier, nimm das für deine Mühen.\n<Zazo reicht dir 1 Goldstück>$4;quest$QUE00003$FinGood$1;or$10000$1;",
					["DireTab"] = "talk",
				},
				["022"] = {
					["OnActionCondi"] = "namec$==$\"Barkeeper Morag\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002",
					["OnActionEffet"] = "texte$Ich verstehe das nicht. Sie waren doch eigentlich beste Freunde.$4;",
					["DireTab"] = "talk",
				},
				["015"] = {
					["OnActionCondi"] = "namec$==$\"Grunzer Komak\";dist10yard$==$\"1\";",
					["OnActionEffet"] = "texte${anim137}Hmm? Duhhh... *hicks* ...siehscht dudas nich... ich... ich... *hicks* ...beschäftigt trinken... oder sho...* hicks*'?$4;",
					["DireTab"] = "talk",
				},
				["019"] = {
					["OnActionCondi"] = "namec$==$\"Gamon\";dist10yard$==$\"1\";",
					["OnActionEffet"] = "texte$Bereite dich vor, den gleich gibts Ärger!\nSchlage zurück, und das um so Härter!\n{anim068}Die Welt versinkt im Chaos, hebe schützend deine Hand!\nVereine alle Kräfte, zu einem mächtigen Verband.\nUm das Böse von Wahrheit und Liebe zu denunzieren!\n{anim084}Um uns näher an die Sterne heran zu katapultieren!\n{anim082}Gamon hebt ab, schneller als das Licht!\n{anim074}Zieh deine Waffe, dann stirbst du vielleicht nicht!$4;",
					["DireTab"] = "talk",
				},
				["005"] = {
					["OnActionCondi"] = "namec$==$\"Doyo’da\";",
					["EtapesNum"] = "005",
					["OnActionEffet"] = "quest$QUE00003$006$1;parole$|| Doyo’da wirft seinen Krug quer durch den Raum.$2;parole$|| Doyo’da schreit: Dahs Bier sein ja lauwarm!$2;parole$|| Gryshka starrt Doyo’da darauf plötzlich überrascht an.$2;aura$AUR00101$20$1$1;son$Sound\\\\Spells\\\\GlassBreaking1.wav$2$15;",
					["DireTab"] = "wave",
				},
				["011"] = {
					["OnActionCondi"] = "namec$==$\"Grunzer Mojka\";dist10yard$==$\"1\";",
					["EtapesNum"] = "010",
					["OnActionEffet"] = "texte${anim073}{son:Sound\\\\Character\\\\Draenei\\\\DraeneiMaleRaspberry01.wav}Fahr zur Hölle! Ich werde schon herausfinden wer das ist! Sie wird dann um Vergebung betteln!$4;quest$QUE00003$012$1;",
					["DireTab"] = "no",
				},
				["001"] = {
					["OnActionCondi"] = "namec$==$\"Barkeeper Morag\";dist10yard$==$\"1\";",
					["EtapesNum"] = "001",
					["OnActionEffet"] = "texte$Warum seit ihr hier!\nIch halte das nicht länger aus! Gastwirtin Gryshka und Mojka hören gar nicht mehr auf, sich gegenseitig anzuschreien. Das geht mir langsam echt auf die Nüsse! Und es ist schlecht für das Geschäft!\nBitte, {me}, rede mit ihnen! Befragt auch die Gäste, was da vor sich geht. Findet heraus was da vor sich geht und löst das Problem ein für alle mal für mich.$4;quest$QUE00003$002$1;",
					["DireTab"] = "talk",
				},
				["014"] = {
					["OnActionCondi"] = "namec$==$\"Barkeeper Morag\";dist10yard$==$\"1\";",
					["EtapesNum"] = "011",
					["OnActionEffet"] = "texte$Waaaas?! Eine meiner Angestellten schläft mit'nem Kunden? Das ist absolut VERBOTEN!\nSie wird auf der Stelle entlassen!\nIch danke dir für deine Hilfe, {me}. Hier ist deine Belohnung.\n<Barkeeper Morag reicht dir 3 Goldstücke>\nGeht jetzt. Ich werde jetzt eine Angestellte aus den Laden befördern!$4;quest$QUE00003$FinBad$1;or$30000$1;",
					["DireTab"] = "talk",
				},
				["004"] = {
					["OnActionCondi"] = "namec$==$\"Doyo’da\";dist10yard$==$\"1\";",
					["EtapesNum"] = "004",
					["OnActionEffet"] = "texte$Soho, was fürn Rat benötigt ihr den von Doyo’da?\nOh, ich sehen. Du wollen was stehlen von Gryshka... Hmmm, wollen wir mal sehen.\nWir werden machen folgendes: Wenn du geben mir Zeichen, das du bereit. Ich sie werden ablenken. Du dann nur müssen dich hinter ihr stehlen um ihre Taschen zuh durchsuchen!\nSein Kreative, verstandeeeen!\nWinkt wenn ihr sein, bereit.$4;quest$QUE00003$005$1;",
					["DireTab"] = "talk",
				},
				["010"] = {
					["OnActionCondi"] = "namec$==$\"Grunzer Mojka\";dist10yard$==$\"1\";",
					["EtapesNum"] = "009",
					["OnActionEffet"] = "texte$WAS?! Er interessiert sich für eine andere?\n{anim074}{son:Sound\\\\Character\\\\PlayerRoars\\\\CharacterRoarsOrcFemale.wav}RAAAAAAAAAAAH!\nWer ist sie? Verrätst du mir ihren Namen? I werde ihr die Augäpfel herausreißen!\n<Wähle: /ja oder /nein>$4;quest$QUE00003$010$1;",
					["DireTab"] = "talk",
				},
				["008"] = {
					["OnActionCondi"] = "namec$==$\"Gastwirtin Gryshka\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Was zwischen uns vor sich geht?\nDas wird mir langsam zu verrückt mit diesem Orc, Zazo dachte auch das sie meine beste Freundin sein würde! Freunde erzählen einander solche Dinge! Nun gut, Ich muss selbst herausfinden, wann sie ihm den Liebesbrief überreichen will!\n{anim073}{son:Sound\\\\Character\\\\BloodElf\\\\BloodElfMaleRaspberry01.wav}Ich wünschte sie wäre tot!$4;",
					["DireTab"] = "talk",
				},
				["018"] = {
					["OnActionCondi"] = "namec$==$\"Sarok\";dist10yard$==$\"1\";",
					["OnActionEffet"] = "texte$Hey, du! Zieh an meinem Finger!\n<Sarok zeigt mit seinem großen Finger auf dich.>\n<Du ziehst daran.>\n{son:Sound\\\\Character\\\\Gnome\\\\GnomeVocalMale\\\\GnomeMaleRaspberry01.wav}<Sarok fuzt laut.>\n{son:Sound\\\\Character\\\\Orc\\\\OrcMale\\\\OrcMaleLaugh01.wav}HAHAHAHA!$4;",
					["DireTab"] = "talk",
				},
				["009"] = {
					["OnActionCondi"] = "namec$==$\"Zazo\";dist10yard$==$\"1\";",
					["EtapesNum"] = "008",
					["OnActionEffet"] = "texte$Was sagst du? Mojka ist wie verrückt nach mir?\nUnd Gryshka hat das herausgefunden? Verdammt!\nDie Wahrheit ist... das ich mit der Gastwirtin Gryshka eine Beziehung habe. Wur halten es geheim. Niemand darf davon erfahren, da ihr Boss es nicht duldet wenn seine Angestellten eine Beziehung mit ihren Gästen eingehen.\n Und Gryshka ist mächtig eifersüchtig... \n{anim083}{son:Sound\\\\Character\\\\Orc\\\\OrcMale\\\\OrcMaleSigh01.wav}Aber sie hat so ein Hinterteil wie... wie...\nWas auch immer, ich habe keine Zeit mich darüber weiter zu unterhalten!\nIch werde mich um Gryshka kümmern. Geh bitte zu Mojka und erzähl ihr das mein Herz bereits einer anderen gehört. Jedoch erwähne auf keinen Fall Gryshka dabei!$4;quest$QUE00003$009$1;",
					["DireTab"] = "talk",
				},
			},
			["Etapes"] = {
				["007"] = {
					["Description"] = "Du hast einen Brief von Gryshka gestohlen. Rede mit dem Barkeeper Morag darüber.",
				},
				["005"] = {
					["Description"] = "Doyo’da wird Gryshka ablenken, wenn du ihm zuwinkst. {bbbbbb}(/wave)",
				},
				["003"] = {
					["Description"] = "Du hast herausgefunden, das Gryshka etwas wertvolles von Mojka gestohlen hat. Du solltest mit dem Barkeeper Morag darüber reden.",
				},
				["008"] = {
					["Description"] = "Rede mit Zazo.",
				},
				["001"] = {
					["Description"] = "Barkeeper Morag in Orgrimmar, benötigt deine Hilfe.",
					["OnEtapeEffet"] = "texte$pas cible\n{questicon:INV_Letter_13}<Barkeeper Morag von der Taverne in Orgrimmar, hat dir einen Brief gesendet:>\n{me}, Ich benötige eure Hilfe. Wir haben hier ernste Schwierigkeiten in der Taverne. Ich kann nicht mehr sagen, bitte sucht mich schnell auf!$4;",
				},
				["009"] = {
					["Description"] = "Geh und rede mit Mojka.",
				},
				["004"] = {
					["Description"] = "Barkeeper Morag sagt, du solltest dich mal mit Doyo’da unterhalten.",
				},
				["011"] = {
					["Description"] = "Geh und Rede mit Barkeeper Morag.",
				},
				["002"] = {
					["Description"] = "Morag möchte, das ihr herausfindest warum sich Gryshka and Mojka im Moment so streiten... Redet mit ihnen und den Gästen der Taverne.",
				},
				["012"] = {
					["Description"] = "Rede mit Zazo.",
				},
				["FinGood"] = {
					["Description"] = "Du hast dich entschieden das Geheimnis für dich zu behalten und machst damit zwei Personen sehr sehr glücklich.",
					["EtapeFlag"] = 3,
				},
				["FinBad"] = {
					["Description"] = "Du verrätst Gryshka beim Barkeeper Morag. Ja, genau, Angestellte dürfen nichts mit ihren Gästen anfangen. Sowas ist unethisch!",
					["EtapeFlag"] = 3,
				},
			},
			["FouillerAction"] = {
				["006"] = {
					["OnActionCondi"] = "namec$==$\"Gastwirtin Gryshka\";dist10yard$==$\"1\";aurat(AUR00101)$>=$0;",
					["EtapesNum"] = "006",
					["OnActionEffet"] = "quest$QUE00003$007$1;objet$ITE00401$1$1;parole$stiehlt einen Brief von Gryshka.$2;son$Sound\\\\Interface\\\\PickUp\\\\PutDownParchment_Paper.wav$1$0;",
					["DireTab"] = "talk",
				},
			},
			["Createur"] = "Euphorine",
			["Icone"] = "Spell_BrokenHeart",
			["Nom"] = "Verräter! (Horde)",
			["Description"] = "Irgendetwas läuft verkehrt, in der Taverne von Orgrimmar",
			["bReinit"] = "true",
		},
		
		["QUE00002"] = { -- Traitresse ! Coté Alliance
			["DireAction"] = {
				["007"] = {
					["OnActionCondi"] = "namec$==$\"Reese Langstein\";dist10yard$==$\"1\";",
					["EtapesNum"] = "007",
					["OnActionEffet"] = "texte$Ein Brief? Lasst mal schauen.\n{son:Sound\\\\Character\\\\Human\\\\Male\\\\HumanMaleSigh01.wav}<Reese Langstein liest den Brief und seufzt darauf.>\nAlles im Namen der Liebe... Ihr solltet dem ein Ende bereitet, hier und jetzt.\nGeht und sprecht mit dem Mann welchen hier einige Bartleby nennen.$4;quest$QUE00002$008$1;objet$ITE00402$1$2;",
					["DireTab"] = "talk",
				},
				["017"] = {
					["OnActionCondi"] = "namec$==$\"David Langstein\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Ja, sie hören gar nicht auf mehr zu streiten.\nIch habe nur leider keine Ahnung warum. Wobei, warum fragt ihr sie nicht selbst?$4;",
					["DireTab"] = "talk",
				},
				["013"] = {
					["OnActionCondi"] = "namec$==$\"Elly Langstein\";dist10yard$==$\"1\";",
					["EtapesNum"] = "010",
					["OnActionEffet"] = "texte$Es ist Erika?! Darum hat sie also den Brief von mir gestohlen!\n{anim084}Nun wo ich darüber nachdenke... gibt es hier eine Richtlinie, welche es Angestellten auf keinen Fall erlaubt Beziehungen mit den Gästen einzugehen!\nGeht und sprecht mit meinem Vater, Reese! Er wird euch für euren Fund sicher bedankbar zeigen!$4;quest$QUE00002$011$1;",
					["DireTab"] = "nod",
				},
				["003"] = {
					["OnActionCondi"] = "namec$==$\"Reese Langstein\";dist10yard$==$\"1\";",
					["EtapesNum"] = "003",
					["OnActionEffet"] = "texte$So, habt ihr irgendwas herausgefunden?\nErika hat Elly bestohlen, sagt ihr!? Aber warum, was hat sie den an sich genommen?\nHmmm, ich habe keine Idee was das sein könnte... Nun, am besten ihr versucht es herauszufinden... Wie gesagt, ich kenne Erika. Wenn sie etwas gestohlen hat, wird sie es sicherlich bei sich tragen.\nFragt Stephen ob er euch helfen könnte. Sagt ihm, ich habe euch geschickt. Er sollte sich momentan in der Kücke aufhalten.$4;quest$QUE00002$004$1;",
					["DireTab"] = "talk",
				},
				["023"] = {
					["OnActionCondi"] = "namec$==$\"Bartleby\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Probleme zwischen Erika und Elly ?\nNeee, davon wüsste ich nichts.$4;",
					["DireTab"] = "talk",
				},
				["016"] = {
					["OnActionCondi"] = "namec$==$\"Stephen Ryback\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$I sehe alles, ich weiß alles... jedoch...\n... sagen werde ich nichts. Zumindest nicht umsonst!\nNun geht! Ich habe Fleisch was geschnitten werden möchte.$4;",
					["DireTab"] = "talk",
				},
				["002"] = {
					["OnActionCondi"] = "namec$==$\"Elly Langstein\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002",
					["OnActionEffet"] = "texte$Ja, was kann ich für euch tun?\nWas mit mir und Erika ist? Wie kommt ihr darauf, das es euch was angeht?\nSie hat mir etwas wichtiges gestohlen, mehr nicht!\nSolange sie es mir nicht zurück gibt, werde ich dafür Sorge tragen das sie dafür bezahlen wird!$4;quest$QUE00002$003$1;",
					["DireTab"] = "talk",
				},
				["012"] = {
					["OnActionCondi"] = "namec$==$\"Bartleby\";dist10yard$==$\"1\";",
					["EtapesNum"] = "012",
					["OnActionEffet"] = "texte$Oh, habt vielen Dank. Ihr habt das Problem gelöst, ohne unser Geheimnis zu verraten.\nErika und ich mögen uns nämlich sehr, müsst ihr wissen.\nHier, nehmt das für die Probleme die wir euch bereitet haben.\n<Bartleby gibt euch eine Goldmünze.>$4;quest$QUE00002$FinGood$1;or$10000$1;",
					["DireTab"] = "talk",
				},
				["022"] = {
					["OnActionCondi"] = "namec$==$\"Reese Langstein\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002",
					["OnActionEffet"] = "texte$Ich verstehe das nicht. Sie sind doch eigentlich die beste Freundinnen...$4;",
					["DireTab"] = "talk",
				},
				["015"] = {
					["OnActionCondi"] = "namec$==$\"Harry Burlwacht\";dist10yard$==$\"1\";",
					["OnActionEffet"] = "texte${anim137}Hmmm? Kann... *hickst* ...isch was führ eusch... tun? *hickst* Wahs? Ihr redet mihr zu wirres Zeusch... verschwindet. *hickst*'?$4;",
					["DireTab"] = "talk",
				},
				["005"] = {
					["OnActionCondi"] = "namec$==$\"Stephen Ryback\";",
					["EtapesNum"] = "005",
					["OnActionEffet"] = "quest$QUE00002$006$1;parole$|| Stephen wirft ein Messer ins Holz.$2;parole$|| Stephen schreit: Hey, Erika! Der Typ hier meint du hättest einen fetten Arsch?!$2;parole$|| Erika sieht mit einem missbilligenden Blick zu Stephen.$2;aura$AUR00102$20$1$1;son$Sound\\\\Item\\\\Weapons\\\\Sword1H\\\\m1hSwordHitStone1a.wav$2$15;",
					["DireTab"] = "wave",
				},
				["011"] = {
					["OnActionCondi"] = "namec$==$\"Elly Langstein\";dist10yard$==$\"1\";",
					["EtapesNum"] = "010",
					["OnActionEffet"] = "texte${anim073}{son:Sound\\\\Character\\\\Draenei\\\\DraeneiMaleRaspberry01.wav}Waaaas zur Hölle! Ich werde früher oder später eh herausfinden wer Sie ist! Ihr werd es noch Leid tun!$4;quest$QUE00002$012$1;",
					["DireTab"] = "no",
				},
				["001"] = {
					["OnActionCondi"] = "namec$==$\"Reese Langstein\";dist10yard$==$\"1\";",
					["EtapesNum"] = "001",
					["OnActionEffet"] = "texte$Was? Ah, da seit ihr ja!\nIch halte das hier wirklich nicht länger aus... Erika, unsere Köchin und meine Tochter Elly wollen gar nicht mehr aufhören sich gegenseitig anzuschreien. Ich werde hier noch wahnsinnig... wenn es so weiter geht.\nBitte, {me}, redet mit ihnen und unseren Gästen. Ansonsten läuft mir die Kunschaft davon. Findet heraus was der Grund für deren Streit ist und setzt dem ein Ende...$4;quest$QUE00002$002$1;",
					["DireTab"] = "talk",
				},
				["014"] = {
					["OnActionCondi"] = "namec$==$\"Reese Langstein\";dist10yard$==$\"1\";",
					["EtapesNum"] = "011",
					["OnActionEffet"] = "texte$Wie jetzt?! Meine Köchin hat eine Affäre mit einem unserer Kunden? Aber, das verstößt doch gegen die Hausordung!\nIch werde sie auf der Stelle entlassen!\nDanke für eure Hilfe, {me}. Hier ist eure Belohnung.\n<Reese Langstein reicht euch 3 Goldmünzen.>\nNun geht, ich hab einen Koch zu feuern!$4;quest$QUE00002$FinBad$1;or$30000$1;",
					["DireTab"] = "talk",
				},
				["004"] = {
					["OnActionCondi"] = "namec$==$\"Stephen Ryback\";dist10yard$==$\"1\";",
					["EtapesNum"] = "004",
					["OnActionEffet"] = "texte$Was für einen Rat, benötigt ihr von mir?\nAh, ich verstehe. Du möchtest Erika ausnehmen... das wird leicht.\nSobald ihr mir ein Zeichen gebt, werde ich ihre Aufmerksamkeit auf mich ziehen. Ihr müsst euch dann nur noch hinter sie schleichen und schauen was die junge Dame in ihren Taschen trägt!\nSeit kreativ, verstanden!\nWinkt mir einfach zu, sobald ihr bereit seit.$4;quest$QUE00002$005$1;",
					["DireTab"] = "talk",
				},
				["010"] = {
					["OnActionCondi"] = "namec$==$\"Elly Langstein\";dist10yard$==$\"1\";",
					["EtapesNum"] = "009",
					["OnActionEffet"] = "texte$WAAAAS!? Er ist mit einer anderen zusammen?\n{anim074}{son:Sound\\\\Character\\\\PlayerRoars\\\\CharacterRoarsHumanFemale.wav}RAAAAAAAAAAAH!\nWer ist sie? Verratet mir ihren Namen? Ich werde ihre Augen ausreißen!\n<Wählt: /ja oder /nein>$4;quest$QUE00002$010$1;",
					["DireTab"] = "talk",
				},
				["008"] = {
					["OnActionCondi"] = "namec$==$\"Erika Tate\";dist10yard$==$\"1\";",
					["EtapesNum"] = "002,003",
					["OnActionEffet"] = "texte$Was mit und geschehen ist?\nSie hat auch ein Auge auf unseren Trunkenbold Bartleby geworfen.\nSie war mal meine beste Freundin. Freundinnen erzählen sich doch solche Dinge, oder? Nun gut, ich muss wohl herausfinden wann sie ihm den Liebesbrief überreichen will!\n{anim073}{son:Sound\\\\Character\\\\BloodElf\\\\BloodElfMaleRaspberry01.wav}I wünschte sie wäre tot!$4;",
					["DireTab"] = "talk",
				},
				["018"] = {
					["OnActionCondi"] = "namec$==$\"Kendor Kabonka\";dist10yard$==$\"1\";",
					["OnActionEffet"] = "texte$Hey, du! Wollt ihr mal an meinem Finger ziehen?!\n<Kendor zeigt mit seinem rechten Zeigefinger auf euch.>\n<Ihr zieht selbstverständlich daran.>\n{son:Sound\\\\Character\\\\Gnome\\\\GnomeVocalMale\\\\GnomeMaleRaspberry01.wav}<Kendor furzt laut auf.>\n{son:Sound\\\\Character\\\\Orc\\\\OrcMale\\\\OrcMaleLaugh01.wav}HAHAHAHA!$4;",
					["DireTab"] = "talk",
				},
				["009"] = {
					["OnActionCondi"] = "namec$==$\"Bartleby\";dist10yard$==$\"1\";",
					["EtapesNum"] = "008",
					["OnActionEffet"] = "texte$Was? Elly ist in mich verknallt?\nUnd Erika weiß davon? Oh scheiße!\nDie Wahrheit ist nämlich... das Erika und ich zusammen sind! Doch das muss ein Geheimnis bleiben, wegen dieser dummen Hausordnung. Bitte, erzählt keinem davon.\nErika kann ziemlich eifersüchtig werden... jedoch so ist Elly nun mal...\n{anim083}{son:Sound\\\\Character\\\\NightElf\\\\NightElfMale\\\\NightElfMaleSigh01.wav}Wobei, sie hat so einen schönen runden Hintern... ich... ich könnte...\nNein, vergessen wirs. Für sowas haben wir nun wirklich keine Zeit!\nIch werde mit Erika darüber reden. Geht bitte zu Elly und erklärt ihr das mein Herz bereits einer anderen gehört. Aber bitte, auf keinen Fall, erwähnt Erikas Namen!$4;quest$QUE00002$009$1;",
					["DireTab"] = "talk",
				},
			},
			["Etapes"] = {
				["007"] = {
					["Description"] = "Du hast einen Brief von Erika gestohlen. Rede mit Reese Langstein darüber.",
				},
				["005"] = {
					["Description"] = "Stephen Ryback wird Erika ablenken und ihre Aufmerksamkeit auf sich ziehen. Winkt ihm zu, wenn ihr bereit seit. {bbbbbb}(/wave)",
				},
				["003"] = {
					["Description"] = "Du hast herausgefunden, das Erika irgendetwas wertvolles von Elly gestohlen hat. Fragt Reese Langstein, ob er mehr darüber weiß.",
				},
				["008"] = {
					["Description"] = "Redet mit dem Trunkenbold Bartleby.",
				},
				["001"] = {
					["Description"] = "Reese Langstein aus der Taverne von Sturmwind bittet euch um eure Hilfe.",
					["OnEtapeEffet"] = "texte$pas cible\n{questicon:INV_Letter_13}<Reese Langstein aus der Taverne von Sturmwind hat euch einen Brief zugesandt:>\n{me}, ich brauche eure Hilfe. Wir haben Probleme in der Taverne. Ich kann das nun nicht in einem Brief zusammenfassen. Bitte sucht mich in der Taverne von Sturmwind auf!$4;",
				},
				["009"] = {
					["Description"] = "Geht und sprecht mit Elly.",
				},
				["004"] = {
					["Description"] = "Reese Langstein möchte, das du mit Stephen Ryback sprichst.",
				},
				["011"] = {
					["Description"] = "Geht und sprecht mit Reese Langstein.",
				},
				["002"] = {
					["Description"] = "Reese möchte, das du herausfindet was da zwischen Erika und Elly verkehrt läuft. Redet mit ihnen, fragt die Gäste ob sie vielleicht auch mehr darüber wissen.",
				},
				["012"] = {
					["Description"] = "Redet mit Bartleby.",
				},
				["FinGood"] = {
					["Description"] = "Du hast dich entschieden die Beziehung der beiden geheim zu halten und machst damit zwei Menschen sehr, sehr Glücklich!",
					["EtapeFlag"] = 3,
				},
				["FinBad"] = {
					["Description"] = "Du hast Erika bei Reese Langstein verraten. Ja, sie hätte es selber wissen müssen. Sowas darf nicht unbestraft bleiben!",
					["EtapeFlag"] = 3,
				},
			},
			["FouillerAction"] = {
				["006"] = {
					["OnActionCondi"] = "namec$==$\"Erika Tate\";dist10yard$==$\"1\";aurat(AUR00102)$>=$0;",
					["EtapesNum"] = "006",
					["OnActionEffet"] = "quest$QUE00002$007$1;objet$ITE00402$1$1;parole$stiehlt einen Brief von Erika.$2;son$Sound\\\\Interface\\\\PickUp\\\\PutDownParchment_Paper.wav$1$0;",
					["DireTab"] = "talk",
				},
			},
			["Createur"] = "Telkostrasz",
			["Icone"] = "Spell_BrokenHeart",
			["Nom"] = "Verräter! (Allianz)",
			["Description"] = "Irgendwas läuft da gewaltig schief, in der Taverne von Sturmwind.",
			["bReinit"] = true,
		},
	}
end