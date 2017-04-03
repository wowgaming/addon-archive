QuestHelper_File["static_esMX_1.lua"] = "1.4.1"
QuestHelper_Loadtime["static_esMX_1.lua"] = GetTime()

if GetLocale() ~= "esMX" then return end
if (UnitFactionGroup("player") == "Alliance" and 1 or 2) ~= 1 then return end

table.insert(QHDB, {
		flightmasters = {
				[6] = "µ½Ñ¶_5ÙúH¼‘E¡®\000ä",
		[7] = "¢%|8ßx¯Çò_Æž¬L9",
		[8] = "újû=ÊIx8a=Âoš€@",
		[16] = "î8}p€y¸%cÎ(Ã",
		[18] = "*Eœù!šš‚—s 9",
		[20] = "\\ßzŒ^àyû€v ä",
		[22] = "·‰P¶Ãhj\000š	§ì÷fg\0009",
		[28] = "_˜ƒîzÄxÀ€šái­XóŠ0ä",
		[29] = "ÇºçŒ‚›1H\\¢u ªÿÅÖ| ä",
		[31] = "yØ¯¼ÏêkÆ¬+±¢kêQ\000ä",
		[32] = "x5ø\000k=™G'Þ’7Ê„,“[I)ð‚\r›j@",
		[33] = "\\É¬²%9¯^#i@",
		[34] = "ç¶3^ŠÅ¹E\r%àá‡ˆ>¯6 9",
		[35] = "ÛhÒ=ÓFßÉj·þëñä\000C",
		[37] = "ôà-Ò¥—ÐQÛk@",
		[40] = "§‚zíQsÜ\"3¯5ø\000k=™G'Û",
		[43] = "ž²²i@EÒ{a†	Ò„\\ÚÃ",
		[44] = "mV(h*¿ñuŸ(9",
		[46] = "`‹)(æÜÄ¸ÝÆ)cl@",
		[49] = " HÛ\\Â|K šÙ\000C",
		[52] = "‚BÄ°ûƒƒIŠ:ÖëòÃ",
		[56] = "ìb.¹+GFÚƒ",
		[59] = "šq.l”HÂ=Ç~\000C",
		[60] = "*D :PrŸ’Íí€ÁÉž0@",
		[61] = "BY uª'*±XóŠ0ä",
		[63] = "`‹)(Pú¢(v¤Ý£•Á>ÏF@@",
		[65] = "%œ-Jù_R¶p³“ý¬9",
		[66] = "¢%q7SÚƒ",
		[68] = "ªûôÓ$yeœ(Çö°ä",
		[70] = "T½5)XçýK\000C",
		[72] = "_˜†›¼op.¼‘r*_€| ä",
		[73] = "lÙÙ¹oŒ®?ÚÃ",
		[76] = "Š»`-™Ì	½\000i¯v[Ë@",
		[78] = "TÿGF^Iº}¦æP/(9",
		[81] = "mB=ŽjÀÞ8…­09",
		[82] = "¤p!®œ[ãÝ™œ\000ä",
		[84] = "Ç_‚i¤¢ÔÉô€y¸#o@´‘Ý9",
		[86] = "‹g4ÂE¯09",
		[87] = "ÍÂ¾5»…PX†Æž¬L9",
		[91] = "·T²|²±y¨9",
		[92] = "ÛÛsî9•óž'25ð@",
		[95] = "Pºo4G;œìôd\000ä",
		[100] = "ŠH«/º|ûõòc(ÝÆ)cl@",
		[101] = "ÁˆÏ‘<v›& ä",
		[103] = "yÂz§½RÊºÈët\000ûIÑ©\000C",
		[106] = "_˜™âs#bwò3¯5ø\000k=™G'Û",
		[107] = "g®FYWaÙTTíTû‡Rä@",
		[108] = "æ´\\@",
		[110] = "%œíV¥7­Û°\r²ªêÓ€ä",
		[111] = "ð²œ;ÈúôÂQYïSl@",
		[112] = "aþâaPBmô@",
		[114] = "“§0ïN·håcpO³Ñ\000C",
		[115] = "µ½Ñµóç&¶­à×à¬|öeŸl@",
		[116] = ":s†Œ\\é>WÔÝÆ)cl@",
		[118] = "%œìußãsZ‡Àä",
		[119] = ":7w¯Ë@",
		[123] = "§‚zì“¡Üô)äQh@Ç+€9",
		[124] = "qo”k&ÏÒÊÄYæ ä",
		[125] = "mš` PQÛk@",
		[127] = "‰½Õ¬BëÜˆv¤yž·@g‰ÌÒ€ä",
		__dictionary = " \"',ABCDEFGHILMNOPRSTUVZabcdefghijklmnopqrstuvwxyz‰¡­±³Ã",
		__prefix = "name=\"",
		__tokens = "€r0\000ƒ™éÀÔÃw\000™€À8âY‘À#y23ës˜<™)ËÖ‹L®¬â”pJÓ€7Y9H\"bbö0´ÃƒrTtÅÄç„°BÄÀ’ÁÆSÆÅ\000–ö!‚£ÔÂ³ÃéÃðdCä\000¹Y„FÑ„DA!ÁÒÁäÊ”„ÀRb¢‰DA‚•&´D¡‚)¨x•$Ár’¹ðbb<5'{ \000ÜgöÒn‚VäÂU!GäE Z´.AHj\
°\000å°´Py˜É\"DLd	pT¨\000\rŽÁ1,‰.ˆªW«ß|²GbFZœ0e#P 8pZL\"ÄCxˆn–€i0°F“¸¤<ò\000»À3aNâ—Ç@\"šv6çÀ`•s4 8À&Z¼òL‰†f•á0¬ì&¥rAÝŠ™¦2ÕDA;xq]±0T°—˜ T'F)ö*|{)AÈÔ¼¿l¡S!¢È@U ŠDÍ2$º<1x0E!º`:3H\000ÄÃe.èD‰ˆ0s€Æ6R(ÄŽ¢ X@#¼‚0s,BŸÉ‚PìŸ¹	Ä|ŠlðÄîjQ¨q«¾.+8¼Ø²öÆì 3Ç—/ÖQÀU*ö’ÿ±8zY\
ž\000%6ÛÁ¹x‚B—M;fÌ¦¶\"Z†Õ@FgLõ½IzžF1[\000õœc€\000Œ Zñ7mD†-ŒÀ #†·b…Q\"¢/D %‹Ì¸Œ•6aà|¢%hk\000äp›˜Ž—bìRb\000Ái#ÉE/O AŠ;… 59FÁE£µUð…+—‘™€¤CÑ¹Q„xð–,ŠÂ&9^	”$(Ñà¤W'„ÌóÞÔ“'rmÀHÀ”ÊA0JL¢Hs!å†Œz¥0­&äé`&À±(!ÃE|J×)Hb¦rò™[2Â‹Á@¦,rÞ¢Áš`b©#Í²¯6¥\000Ae¹ªÀ}ËGDµ&lPŽÌ-Î2e‹Á¦ø×\"òIà&p)n0BJqä†…@óbÆNKLÅ~[AU	o)Þ)Áô˜,Iý‹ÅKqM\
©Á%&í,\000KÈ¦Dx|YÙ°† ™´)K#Ì§ü” §j™`\"…ì|D‚É€-ºŠû\rÉ®å:€Ä¹Â–˜p€yÚ DîtÅ_RàG+ÙÌ²)#ð¦7bó#CEtÈ/`ÖDK½xMBëÖ¹–ö-J G’g#ÎD@xˆ[6s¸†D¼ Æh`Åß\\‚ÉD‰€$	ÔÆŽ¶ÒðùX‘ácü\rUûBœ;ÈöÎ+ˆ?S1zqÙçBP¡]KÆx½ßGþ2‰§‘#™ÁÎ¬LiR0½;S\rÕ|…³AøJI²Èc,WÊ]$+ëÏßTWè×Z‹Â XâØD%¼¤€ŸåhùP«¤Àv`\000vá¤´€´x\000\000)€…p\000\rÁùA\ruV'XÒJQ?B0\r¢Ä^xL:íô)'cæå‚#,B/eET!Á“%\
HÙ:ÃÏ R„<)‘—„G‚A\000.D¼%HY€q51mO¹ÕrFr4Äy}·Õ*ñÀÙUkæ˜¯u”€f E| jxB”jq•ñ$§qö/FA†¾Š`?ÈÄ&\000ðAECh¼ŸG2^\000+@q€:\000œ‡:¥àc7Òb‹Û;%%fÐž» LôÏélSˆB80æ {O%å…0!ò^JÔá°Eç¯ÉrðdÍ fSž'1ÈDc±_„%}²JÈdÀDêpàÊà1\r‡øLlè|H°ZxJ/äy©BÆ€A£}Ï4eYpª‹ÀjfÕ¡€T† rõSƒÄ&sÀ/‚`.¸“úI“ E˜ž	ð;¢ô€€ò<¨ %+à±ƒ_Uä¸â—#ÀÕ·qÉœ¦p@™ÞÐîLà°½¦p @@$¸Éª\\Ov²e3>u0TÀS\000‚gq¡’€´H\000rœS¸€‚¢\r  %è®Q\0000\000‚`‰hñ\"˜JøbK¡\000¢\r‘`…ˆ°`6m\000Åad Á`ž\000	=¢©/G€ùÒ‡™™´>Å¢¾ø‚!#&€¼¶$¹CGX9à“Ð½ÆD04 x\"hu©)Úäyl\rão Fl)ÀR²À6å0’dLu¼“ÀØS€Y/\000b\\4!Ü†\000C}ˆa0VÑõZÛè¢Šl\000ƒ "
	}
}
)
