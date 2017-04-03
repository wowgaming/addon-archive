QuestHelper_File["static_koKR_2.lua"] = "1.4.1"
QuestHelper_Loadtime["static_koKR_2.lua"] = GetTime()

if GetLocale() ~= "koKR" then return end
if (UnitFactionGroup("player") == "Alliance" and 1 or 2) ~= 2 then return end

table.insert(QHDB, {
		flightmasters = {
		"&¥ÓRg¨všËKP’",
		[3] = "	´y)–j²}hí5$Žj¡Z¹CÀI",
		[4] = ",àëÁizOQH	 ",
		[5] = "Õ4†’ÓèÍ ûYÁÏ]%§V€$€",
		[6] = "	A¿	™¢pM‰vP>2’«?H",
		[8] = "	­9µ«Ò8P²êFÃ]õA¨È\000BH",
		[9] = "p¶-Ë‰Œ«Œ	PD²l$€",
		[10] = "\r£É1¹ár;ÊôÖ¡$",
		[11] = "†*V\000’",
		[13] = "Çr£)UÜcÙ4_ïH ð@",
		[14] = "é XÚ®µ]‹Bk#J„",
		[15] = "†¥§™XOAè—\000!$",
		[17] = "	A¿	–ÒBXéiŠU•³à’",
		[19] = "JèMDæïN¹ï	 ",
		[22] = "É¾}5{bÉxµ@ñ\000„",
		[24] = "ÊÙ§twŸªF[±ž0’",
		[26] = "Du÷9è1>B+ýtIiùÃÁø8ÞÀ;¥\000$€",
		[28] = "Èä#Ör*Ýãû8¬~",
		[29] = "ú¨–µþ»1&•Á¨æ¬[BH",
		[31] = "‘¾R'›4ÊL³Ñõ}®=äÉ?H",
		[32] = "A»ÅÔÖF8•	 ",
		[33] = "\réMiÃ¸šh,‰s`´î/*€’",
		[35] = "&9	·—ª»1&Ídc‰P’",
		[36] = "±¦„\000@",
		[38] = "¬ŒÉXb^ÓÜ¯$Ú;B3<ûÀI",
		[41] = "1ÎÊzŽy¡ÐŒm%G5bÚ@",
		[43] = "Ú:Óÿ=Ðå{;ôˆ’ÆÙH",
		[45] = "\
_(0Fû£þMÉÊ5›j>\000BH",
		[48] = "«8ž|@ÖðhÃV~",
		[49] = "v:§\rJÈßž‡œŸ—dûÀI",
		[50] = "\
™½õ€qR°x@n~",
		[51] = "*˜±	”<ÜŒ“®.Â·¼Pc$è¿\000!$",
		[52] = "ªtRû?e¢-€¨Øk¾¨5\000I",
		[53] = "ñ¦>¦*êÉ[â÷£	=D ’",
		[54] = "¨äÜ¯$Jõ“tf«U•³à’",
		[55] = "\r³T}zh÷yŸcs6X@8äPGø	 ",
		[57] = "Î| Ô9^Ç]šö€kÑ'„çàI",
		[58] = "9G-sÍ€Äci*9«Ð’",
		[59] = "³­µÆµvU»ºgÁ$",
		[61] = "ÏÅ$MÒˆØ×q~©l>ÆxdÂH",
		[62] = "\r£Ñ“¤ö\000‡+Ø¯Ž)á²",
		[63] = "\"\
@ÓÂ^‡„ü	 ",
		[64] = "fE¿CÎN¹ï	 ",
		[65] = "L½(/bcà¤\r<%èxOÀ’",
		[68] = "\
ðB·ƒY†Ma›X\"µåŠ6†Å‚H",
		[69] = "m„[Ù\";‰©[±ž0’",
		[70] = "°Eäi¶õiÍbZ#®&9R8€­Ÿ$",
		[71] = "°¥½7ª»Œ{õHËaö3Ã&@",
		[73] = "åÉÃ¤ªÎìæ’Tu€®`Òg©/\"I",
		[75] = "!Ÿ$WÎâ€®zæø\000„",
		[77] = "PÂš/™\000!$",
		[81] = "Ðb¨RKÅªŒ€$€",
		[83] = "’Þ‚¡Ô±ÛìeÏ\rÏÀ’",
		[84] = "*u§Ãrj¬FH½OÀ’",
		[85] = "nŒ3šž I",
		[86] = "	”6±†£5Ð!EèB~",
		[87] = "9RA}VRJtGzžô<'àI",
		[88] = "ŽeûGñÒ£›hÃV~",
		[89] = ".D¾\
vÐå{AU½â×”œ+gàI",
		[91] = "ïŠ„C’_ë¢Or¼híÌóï\000!$",
		[92] = "’å=¨vo\\yuÒFu@ùø@",
		[95] = "	RBÅ©—ê‘–Ãìg†L$€",
		[96] = "ï.Ã³	Ì†W™&²Èk¾¨5\000I",
		[97] = "	Mhò×Vá*ÔøúR$",
		[98] = "*u§ÃràÖù&±š­TfVÏ‚H",
		[99] = "\
„µiÒÑr;çs4¡à#Ïó-?@I",
		[103] = "F)®=ãå^ALàž~",
		[105] = "ÐÖPD•A‡]?¢T$€",
		[106] = "&¥ÓRg¨v™H1õË™,¼Aû>	 ",
		[107] = "ÄÌÕî[ËÄÖ¡$",
		[109] = "I{‘É¬vÓe|Hoy2OÀ’",
		[112] = "z)¨XÂÿ™4_ïH ð@",
		[113] = "OÙœb]§TŸ$",
		[114] = "”jX&5Ž§¡ç#gåÙ>ð@",
		[116] = "FZ¶(eÿNkÑ;õÁ¨æ¬[BH",
		[117] = "‹&“Ðw iá/CÂ~",
		[118] = "ƒŠ…",
		[119] = "\
tRDQ„ò¯PjÏ[ÎºHÎ¨?H",
		[121] = "möb¨XÂÿ™+|^ôa'¯è„@",
		[123] = "d9@‹‘S6RõÇâ<Ø¹ø@",
		[126] = "T õ\000NtÚƒ]O2\000„",
		__dictionary = " \"(),3=Kaemn€‚ƒ„…†ˆ‰Š‹ŒŽ‘’“”•–—˜™š›œžŸ ¡£¤¥¦§¨©ª¬­¯°±²³´µ¶·¸¹¼½¿êëìí",
		__tokens = ",@¡!¤ä`!%ÍŸFB‘kÙ@WopÌÇp’½6²F,×~ºLHu·I@Ï\\YØQÊÀˆ@Ô_×ß–žÑÈP#\000QŽÏ%‘N#Ø¤ˆ†å‘É¨¤QÊÈ(ÅK¥’ŽhÅ¨Ä©Ý‘f®žÑŒDí+ïÜM¦ÏåqªIN,	(Èìl53T‹,\
%‘w†·†a!¢\"€hñgÙ÷°öQÐìw®{W<¾¥õ¼Å-ãËdŠ:QƒÛÍÁb\000\000ˆâS<Œ>’¨'1@üH™\000ñ8áŽ#{Âá¤`¸0EBebÄ`1…\000a°ô†s~\000Ã(c•\
G	Á‹hd8Â/\000(ÔƒåøF\
‡À†Àt% Lªhgb{!Wˆ)í‚lF,è€†&Á˜‹L#‹pÔ\000a\
Rå¥àLŽ˜H¤Å	Ãí@É,º\"¾\000á§FôU<F§!Œ9!ˆ†À±	Ò8XÂFÈÎ\"Æ|Žÿ®D£=h°NSÐÎ %‰Ðºs'!0xO}á]ˆøèÖÝg¬îÄùä‚I[\"²ÈÜáyÖó(¹H 0Øýs”Ž:à@5ŠÐrˆ†ÛFÑ'	sš1ÚàéyÜÐ	ýÐa{ŽHIo0Z×Å ‚å_–Ñ„MLôi¦ƒ¡ ¡$`öYžÓp5Ks‰pÄ‚Å€h6FmÑ a&K„‡ˆ¥Ž\000•fƒT Ä'f—£uÂ–H#ÆºHöÕÒ‡F ŽX´5”‹€„U$Á*OÂ-(…o˜…ƒ!;\000æÀeed#œ	w1`g#öÜHfP5|‘&ÜGx¢C0iˆuå’m‚±+VÓ!”k€ C’ø¡ùx\\P@H\
\r$,hÕÊy„‚±]7âgˆ&jÂŠ5¥T\000å7‚ÐÊ4vj¡„;¨Mµ’ÉXÕÁ¸žƒQ¨„Œ*6BT%Hl—kë²^*~÷UIÑV¶ª~!ÑÄBÂ(aq·J“@ZV››)è¸Ù`È5m«oRáRa\000õÀw¬†|>'‰Å1ÂRÒ ¶`™êÔ—å€f_‰”ÁèÉ·ÀE…|1pÁaê”‘¶ÄÖ\000ž	FÑû\000QõÛÇ3Ù\000Al¶\\ù!\rdÔ“Ÿ2E€Ú—)°‰„a¸HA…E+(Ã`TÆPì2X‰ØÜõ4:âQxO@¡Å7ÂhÑ$Úa E_Ù×a…G’(xa3Ž®Ðh$½a`Õø\
Õ&jËe‘«@Ã<€‘Î|X\
íÇLL6¢¨€ðSŠÃÀXD&¡baðmÐ­ÅCÐU©¤]ÔœRR††\
á#Î¢°v/í@+·ÆÂ¡…Ü×+õï%ä¡…¼ºšn´Xs$ˆ¨rTõPÌ\"¹lGneai\
»Q¤U¨(ä\000M€8¦H™dFŸÀ‹h\000d¦‚¹`+@Aå¸M°<|…î©oâ|\000%iMã,¸R—u`Å­Å$X‘`bÖƒˆ.\000Mâíeå€¦D8‡à)èÐý† –RD\
?\rÙ+ø¯Tk§~â˜Bª/_|àÔwÃÑ=Ÿ8‡„ÁÞ•–ØÞÝyÅ:4aø˜X8q4\"¨A2·h‰oGÝ½Ôh[\000<„ˆXH¤KÝe@È’> rg¤,w¬z˜XîX\000ÈvU[z[Ã°	˜Â—ôa„\r…ÙhÙ9ãibð­ÇdLI»R˜\" A1øŠ’1‚\\»à\"°Ï¨½9)HWÚ™„†b©²ñ<!”Ð*¦–eŠ¨ÞD«¿~Ì¨Õé4Ýù±šÅH”¶¤œre ƒ2È©°µ'Œ+#ä#œA}„&‚huW—nÇÑ¢A„˜Q	ÇÈn‚•+x²ÝâwJºË°RVËâ$,¹@ÒÉ©âeªh$£,\0007Vl¨.€°_á‰\\LÁ„T—@°ÿéX~ê4•Ÿ‚…Þë·êhÜÐRqW+Ñ“f´¡Xxh¤Õ9‰\\\
â¤å‚MªàÈ£AY1,-ó”åÚš™_«ÈìŒ¡(¿ÍY<î©U.â¢e•W°v£c²4(IKÌà'-«ôW	°\0009bÕ,¸a\000”ø\000›Ö÷hU³’Œñõ	'(+ôQùª”Çk€``Ê0Ã‹\000¢Ì,AdhAPi`é$1cŠ*Ž,ž¢f\
>p„ÍŒQø\
´èsˆ£KÕœ5Ñ¼AÙ¨ ÷@Í8¢õ46b’ãÂÂ>éIó•…	OYš½À–Ï\000}À!’¡` ÁÐ½¸`é4â›²áùZÄÕƒž‰Òçk*\rL¨d\r†‹HX€}ó£vôo€@Ê±²Ôº\rÁÔFRF¦xaøÁ`àr*¯\r#ár$1“ÉZä—Q@\rÛ‹$ha[ @´…½&ç›Ð˜Q*„ƒ:JÃFÉjnRth¿Tm‹FŒ.à·F!ÏžT ÂÜbÈ#2Â¾%±g\000Ý\
ãSmÐcØ!8–Tëi”µ3cz·\000˜·be”âÀ¶ß£²F×h–×TS\rFí(ÆÑ„º`„E\
à˜FTÆ3KL	#·”yÑ›pm•ók\000ÄÁ<	\rÐXƒäZÔÀ‹z5ëþº²¥h@ÔZ!„–\000nùÀ©[ål¾p.A²4¨ÒKÄäh‡eÕ*°ü-õ\000MÀq–\r…ŠÆ¢(ÃÌF€ŠgEÛ­õ`žMèoèhç×hA ðü\r’¦íšL5kHÝë’ ‹p#>âXê41 0Æqøc•UÚÐcB×n) *Æaø„a`¾pE.@üÎç‰àÀü¹	ÿ*© ªã+9„YŽÌæLA¤k	L#Õà>¬f<o\
/œ	Ä“ŠÄðHi`‚žÈHùÀ*4=¡„	à8Ù žUô\000‚öÈæp«À¦	ƒÈ%È™Àë‹ƒø8>™ÁMˆ&:uF¿ó¥M© ‡Á\
ˆFuD…} 1Q2ÃðW˜Á±`–\000)p[Ó;.l0êàÂr}þ	ãð]P‡â	4°d»\\0‚×€°b;|‰\000àæ€;d¶ŸÙJ4`x»@™7DÜ>s¦AŒ\
4(ÐF;\000X·t@<ó‡$MÀAq\rR€à»Bd^DÜˆ»@èMÁ»@DtA("
	}
}
)
