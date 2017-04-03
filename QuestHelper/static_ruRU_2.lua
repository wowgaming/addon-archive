QuestHelper_File["static_ruRU_2.lua"] = "1.4.1"
QuestHelper_Loadtime["static_ruRU_2.lua"] = GetTime()

if GetLocale() ~= "ruRU" then return end
if (UnitFactionGroup("player") == "Alliance" and 1 or 2) ~= 2 then return end

table.insert(QHDB, {
		flightmasters = {
		"6/&¤þR7;%‰8%þø.ÆæC¤M`", "7™|3] `", "t·5Eˆ‡´¢‡Õ;L±»\000V", "„:1Ç‚àƒpV", "\"ý;&±6i4êeY~1L^×Çvp`", "·ö’REL\"%=L27\000o„r¢W¯L&-^Wb€§I`", "ïW°5ö†Ñ–ƒV", "	1õz×É:Ue²ø4$lTïu V", "\
–A“G†²ä\"rT\rP`", "xGr‚^uãª.u­`", "[``", "CS+}fæ-A!‰%#ö\"u¶'×ç:fY\000V", "x{<&\r(Sæ,ñ!~€`", "\r1§Q¡g%·Øø.ÆæC¤M`", "„Ê†Ó¤ê0dÀ=câ19`", "¦øbÔCV¨ôj1uõ;GB9ÜEâUpó¶tV", "§¹ˆpƒøYuˆ:†Xf{XU…ÇW\000V", "šf3ÖdÔ.\"Ór°V", "¦QS©&‡PôÊAç}\000V",
		[21] = "\
4C@âôeRhVÆyzAqG³3eŽ `",
		[22] = "	1uÆ†AÂø4$lTïu V",
		[23] = "B¯ôsKa\
qrvTYH´r{µI\"¨ˆ`",
		[24] = "2(gÉ8ªf¦NR³)MÇÜ>ÀV",
		[25] = "Ðƒ'%V“+–_:0ç.R³o°V",
		[26] = "v\000q '\000ïoÑÒ,6‚†è2³¾CÀV",
		[28] = "wTtö—c&Cð…V",
		[29] = "\rÂz×´$ˆ6hHDÍ!3à\000V",
		[30] = "b3ÕV'0vú(B¸€àV",
		[31] = "\
ò%&c=dß!æHV¥RDÐV",
		[32] = "\
•ªwF3oâìnd:DÐV",
		[33] = "·ÅÖjo4ÛÇdU×F`",
		[34] = "Çn§±6aŸ>§]t`V",
		[35] = "\"ý ÐHqVÇØø.ÆæC¤M`",
		[36] = "RNQ²… V",
		[37] = "WyTJãÂ%·žW‘ë`²ômRçZÐV",
		[38] = "• f˜31—9×žW†V[u\"t€V",
		[39] = "	cú]qÓªBáOF19<ÐV",
		[40] = "6/&¥—;‘Njˆ†¢‰2`ä?Q`",
		[41] = "A—#På´ÈG7trQ´™l”DDV",
		[42] = "Âöˆpç.R³o°V",
		[43] = "• =·ý@‡Pƒe>â(uWf\000`",
		[44] = "âIFE¢¨1qÙ†àV",
		[45] = "6/&¡ß:\000j'¢jöb`",
		[46] = "ç€3QGj÷zg¶/”¶/Câ19`",
		[47] = "uÃOv;%‰8(j>f+<—n\"‡J`",
		[48] = "\"ýYf‘[d»jˆ}Su‡õ–P1¯HEqeà\000V",
		[49] = "\"ý ã$ÃöU—üPãþ+Õ\"t`V",
		[50] = "	•ýeôÞm• ,±–ƒV",
		[51] = "å35Cc.#éE‹=²@Ôw~–p‡ý=fMBá¢-7+`",
		[52] = "Â™pTàTÈb•ôlSrj$wÓBHÖÅN÷R`",
		[53] = "\
W\r8†1ñÏIÂ«\000V",
		[54] = "\000Úeó¡€€‘o†…¢AT\r5;gI`",
		[55] = "	$²6Åío¹9s0KEb¢A\000V",
		[56] = "\"ýFvÍHFÑÒÉ[’§\000V",
		[57] = "	k±´Vòªg¶ÂT—y4dƒV",
		[58] = "t¸Hr’wBo…I–ÉDDA`",
		[59] = "ò„³€³Gi¡+ð`",
		[60] = "“M4·xÛcÀFbú(B¸€àV",
		[61] = "xlbòUTqEW‘J´+Yhu\
j‚÷–ø‰`",
		[62] = "• Fs_yC!3oâìnd:DÐV",
		[63] = "˜N_‚tp°V",
		[64] = "\
§z€ïtL¤wÐ`",
		[65] = "xGr?TC_‚tp°V",
		[66] = "v/aQªK×öÂ1ƒ‰+¥é`",
		[67] = "\r1GHHDÍ!3à\000V",
		[68] = "v]l U€’Ÿôj=dÞgøS`",
		[69] = "vƒXâÚ€dh¶NR³)MÇÜ>ÀV",
		[70] = "x†.’“†v¢wg¤T{36Xáê\000V",
		[71] = "	·iiç +•H×xôûVÆNR³)M÷ÿ}Ãì`",
		[72] = "• S’¯tÓ,á&/¢„+ˆ`",
		[73] = "uÂ[6«j³¾5Ó)¼\rÂT—n\"‡J`",
		[74] = "\rIÔ8/1SWµIˆÑýq0V",
		[75] = "·ÅQcTj³¾µqjôÒCh1Pµ2&ñ\\\"'Ó)¼\000V",
		[76] = "• PÆ\"øON£Á vA9@p`",
		[77] = "ç¡LƒxsèG<\"¾@\000`",
		[78] = "\
7÷37T—yXAÑ`gb'ÔPt V",
		[79] = "u]_°ïpçT4`",
		[80] = "• ÝirLm6.B7Ú(ó¡yÖ(B}EJ`",
		[81] = "\r6Éw†]9ÔàTÃ\\!¼ZðV",
		[82] = "\
±coE:•^WØ1‘r\000V",
		[83] = "3€–HÖ|Ñ­H¢mRçZÐV",
		[84] = "\
!oF¡XænbÔ†ÄÊAç}\000V",
		[85] = "¤± Qã¯ƒV",
		[86] = "âYsybÔ†ÄÊAç}\000V",
		[87] = "	¥…¬[’î4åVH4“%´£XÒ°M7tV",
		[88] = "æÞ`â_1#mUü37a$>§B)Á9<ÐV",
		[89] = "• :•<#_GyÂ­g¶/”¶/Câ19`",
		[90] = "\
•W$þˆÃ„„LÒ>\000`",
		[91] = "\
AÌU\"oÁ­>•)eU\"t€V",
		[92] = "\
uLDCÖjRO<6Åa‰%!ÔTÂ\"SÔÃn0V",
		[93] = "yP>„t0üvE]t`V",
		[94] = "¶#:g$0/È;^ohhYeô„WQ>\000`",
		[95] = "“á€t¬EBnˆ'}Ãì`",
		[96] = "wêöIQpÕÆ;c;ÂQÑ¶;ðV",
		[97] = "ò&Gå_óÞO·ô’¡t€V",
		[98] = "“:oF£_GÊp7Ð+äÆZ$@ÓPpó¶tV",
		[99] = "àUZXz#‹mcYH.?–‹qrCü<’*ˆ€V",
		[100] = "6/&£ª8ˆƒX³ÓòüB&¤‰œ’¡t€V",
		[101] = "s@ˆ2–Xv™\\â©fõóf$(c`",
		[102] = "èPSü^Ö¾„Æì;×0yãÆ`\000V",
		[103] = "\
²|4wv|€õˆV",
		[104] = "u¾KsXvqµrsˆ*–o_1ÎBá¢-7+`",
		[105] = "	ãÂ`ÔDCC£LÖ>#ƒV",
		[107] = "\
áo_\\IÁî:ø9`",
		[108] = "‘4wO+42\rÄ^%W;gI`",
		[109] = "Â™b¡š<×zR¾tV",
		[110] = "	¢¿G—¦„õAÑ`gb'ÔPt V",
		[111] = "	u[GGÏ9S5…V",
		[112] = "6/&¥[a#G;Çä:†;[v™\\çJ`",
		[113] = "	ã\\ÓflWö’REL\"%=L6ã`",
		[114] = "æ*uÄ8Gró*–F+Õ\"t`V",
		[115] = "Ðƒqfjyd/0`",
		[116] = "\"ýP¶nUô»j\
}±M%¸HDÍ!3à\000V",
		[117] = "×wg‡~³¼:pÁEñh'G`",
		[118] = "T¶%TEè8`",
		[119] = "w%HTyy÷%3t·sÅa‰%!ÔTÂ\"SÔÃn0V",
		[120] = "ˆƒ$ÔY´Ñøiõb¢A\000V",
		[121] = "\rÂzØ.?¢y:g4eàôœ*°`",
		[122] = "	Ò³b«7qæsU\000V",
		[123] = "\
†Ë$¦7+ÃQ‡ÕF€c@Q{pî\000V",
		[124] = "àUZXkYÇ¡q%FGôÓ$ò°M7tV",
		[125] = "	b’„K6cX2HjI·TY“\r\000V",
		[126] = "”„oò1•ôx$dUÈ9`",
		[127] = "	R™n³Ãyåxee·R'H`",
		__dictionary = " \"',-235:=AIKSTVacdehlmnortuw€‚ƒ„…†‡ˆ‰‹ŒŽ‘’“”—˜š›œžŸ ¡¢£¤¥§¨­®¯°±²³´µ¶·¸¹º»¼½¾¿ÐÑ",
		__tokens = "\\bbk¨Ò¤J‘êIªvª€\000AØµrõF´f©nûwo±Äª<ª>ô²øäfÄ¨¡\
àú¨pì™¾fì“(â¾u©5p¨¥>Ý\r6¨þÇAY,Ð«^¨jëfwmMåD‰fX¨Ÿ~¨nÑfÃ3u+R©'—PtÍf§¡¤¥fy‰f^ÅgE”÷Qk}®ä]­ÉCƒÃªA½Ð¾n¨§fÿµìçdþ@‡!¼\rN @À` ¼ì¤mÁ×eñÊ–_DÙƒø¼ ä,ª±è¡P‡XŠÊ„‡º`;’Gc9Fz˜$DÒŽ T%,ÆÓ@ê(¢Ý7 Pq˜ÊŠ£*Rà©TIRYJC)J8š	ÌÐ×Áé£ËËêB{:³/² i DÊ³Ùé”j¡VÆM†Œ,EL¹ì\
ŸR\
7ø¹ÜŒòÖ1˜ÑžŒI<Na«ŒÎl©åÎìZUŒ“\r%Í-*Bœðb†ŽrÉ‚¡|D*Šõ5ÉF×o©›)B‰ý}£U›‘Dj‰ë'qÏí~¡ŒóË©î¸uPóPÜÚk”°ùªiÔ¯ù-PRÉ)´õñÅ/){>‘±ž¹º2ŒúºQ»ˆø'Êñbð˜¸Ü°OûjÏ†'’Rê3ÊRú©-nŠLàêÃÂ¡€$'®[ê4¸±A\"ƒâE	èì¶°Œ1ú\000·*0˜“Â\"Ï“¤ Üë4EˆÖ®)û,©*¬vE¦‰[(¨¼ÐãÒ\000DAl–72â¨JÇ0Ësz2?â –uŠ¡2Þ&JòMNký­íPÝ3RÜª>«D\000°i„7)bÈò(ÂE¹¦ñÀÆ–±ƒÔØÜS“QqÄšRN1<Öœ9oî»îÄž¨ÕqÖÜ·hsh£RÕ2`¼\"¨DŸQmB2ÇH0ÛG¯`QÊõK}?Ô š\"3ƒÒ4¥nD•&©dÔÃJEBî@«p˜PMD\000ËƒÃ¹	ÊŽZÝO=\
açQ­ÓÀ¾ÌÎòÙ$-môšô;æ}ðØ*—)Ö;ÅõCÒÇOóLÂ)p¾›ÇIõ Ý9;V¨´·HÔ†ˆMàÇXA.9‹\rËpÎP’mòÏ˜Ø¾1ÆV@ÜÓ€Ý/„¢öì=E÷ý¼íŠœN¹ºWÊÿ*ÍxáIU“ÌÍP;)–+ŒÌ2h™HV§€ÝEªys„‹Ãu ó3\rÆr!¡£	_ítö@7sAô7J^&¹@Ò‹Ûã\".Ìá\\àîTJ”ë'Ësë!æ„wŽ õh¦V>’iäßEÁàï(6¡¡ö¾ª­4]Q%7!VžÃô¢¤¿OÇìõXç\\´¡\rÑAG—ŠBf¸’tcÔ¸1ÅêGq¢øŠ­d‡É8Ä“6\"<¬xMTªhI¸ò`\\`n1¢VKŠ\\*“˜¨úZ/œýû=Æpª¢ô–\000žYƒyU§ÑRv4­MÁKréa6!fh\"Ø™R/î¨£%èêIªR!¤µ‘ÀºS8zqî,\000¢RúæŠ¡…! Õ}¬Â”kâ<…˜$Â¦·‰ŽEíø†!ÆÆj×\
d]:&ÓÌOÛÂ'Ñ®\000ô¡JgÚ'ÃöÚÍùE†Á¸žˆ |\"Ê„=‰,\r–4Ëb°5åÁ^Én†0¢ lêùTeƒåµ¿ƒ,jLq™D°Œ;¯s`Ê‚J(º(¯QävA×˜fð]_í‰±Ö<âä‚9I°åÉ\"×¬¦IF(¿š÷„kÉ³.GJ)±78Öƒ¤m2.¾$ìw	€05óã³‚`Cq¬3R¬À“äX_\
/N©/ój÷ê¸–›ôø^\"\rDâ„•ð «bKÁü’ÃtEå³™r•é­%L T#‚YDÕ—fß’ˆn‹µ&0dÖq0(ˆü›H¾R¥³<jÒ„‡©lŽùT/¯ä\"’ ôÿÕD¡`kæQ?µ4žhë	AÝªDnø\
‘Ü3+uÊ£ðô\000‡ú!9m\r,>ZpàÑÄuîø2?•MR{ W£†‹NžcˆVCI5ã¸Q>0ÀõŽHÜµpe2î8Q–·„òS™Ÿ\"Ê6†¤´–R÷«,±ÇVôVìfÔša¹êöVà_ãdP ¯³r	kü'Í	²‡uÐKk]OJ•,¦ ›_O\000F­	Ðizæò„‘Ù,%ø©9‹\\h‰j¨ˆãëhŒwÈ9°[PWÅbiŠ4WÖ\000Km¸.´ŸBr.Zk$“…B?§Ã§ÚqÄ…ä–#~Ch}&E\
¤3ªÊö›øžUÌ±¼c¤¼-ogyI1zàÂisDDXqÐþÀÐú8K“º>TTm™lÒÛMG•VËŸLì¨Ÿ¹—&\"/['z³dÃîôª¾ÇsÜƒÐ½¤úLi2-oÙB‰¹À6jb¬•V³¹ŠÓ›_ÎA¼ŸxŸ?ò‹Í|„Ø\"åÜ1=ˆ\
¨'¾t¦â†êY\000€\
o32`Á¶­3\000\
€¸a9rÑ3Ú{×AÚ´ Ñ½)Ã(Œ0—Œ­ Á8Ëq/sZ•,h¬D¢è¸\r}48\r„à=˜˜þS1\\ÁI`ƒVZEdV¾©¹À›œÔ˜u0Š¡·—ÂUPƒ;†àÈ’r×ÒXâ'°>¡˜±ŽÅ]¬ã¯ž®ùJL˜Æ9‚üm Æ|HÓ»pÛ‰ð¢Gðód\r~ôÒ—h,×3|µf¦L\000.“pô™-Ò“2U&msMbÎY h•ká.Ÿ™T\\\000-„Î¹À0uâÑ\
Œ‹&«`¶e¡»wfS?šÞô‰‚89®„âBPðÖBû´Þ@Óóaåžý=ÆèàÕ¶´ÒoÇÙd1¦ÀõAöÂÔÁÒ$#^d$žñ1É±éMåØ ¹P‰P577S}Ï¾¢ð|Ynh3™\rƒ3OK^zâiãÛ\\˜>D^pšüéPCyÝd4nû˜n¥)Ÿ1©¨Jø$‰sƒýø|³g	@A…§f˜²Å\\Mc½îÔ\000\000y\000èn¾±VWÒ=Uüo2Ã‚wœZö.¼0[¸¿¼mÈ!ðzÖˆQ7 ûßß…1Y@‰0I‘¾—ïÞzå”¸˜ÄæB=©“›Õ4èÇ¼xÉ*,(kÌR@êÎIØf¼u)ònÀÏ‘k&TEÓŒ«îë•ÎD<:FÒEÇU_ØQsO1™o¸zó·„Á“r/ƒ«ÝÐŠ®ÂÇ‡L1ƒ9aÑOÐpõïˆº<<g.‡TPžZÈlDÇM¡v`ÌCGÂž¨&ƒTÛGÜ9É”³ÀÜü)mžˆ+€km„¯!U\r†\"ä$|/C*”Îš1Äd×ëÚÿ$FÜ‚ÞC„D &aï²šÀÎÎÂ”Ê`ôÅ\".ðæö×ê²›îöÅËF2+ŒYÇt÷+àÂb.%ªXä\000ÌP‡Ú5ãÙì¦-cøgÐ^’B}«\rKºâ¥-gš×6\"å \"à 6J˜YEd“ÀPàˆPƒÄéªdI =p³ˆÔðRùÌpÉ'œ\"æ ]ƒÌÙâ¢“x5ç¹	à’CBVzHxÐ‚î|2ÍÖë.s#–úHâÜÀC\"{¬ÔÀÜõ¢t	â!¯ŠG-ÖG†ì¨ Œ8`<€>;†*-i.'ÈAð8õÁˆt…‚ÏÄÆ_gž¨¯ö8†ºeÑNf… å 'pò\000Ü§1\\-ÊDg`ÜN&hÆË!h\"áj`0€.œº\000*r² XiÜ\
BÖÓO°7(0 É&!Ö<ÌÈ«%P¥P5Ìà§%PM*YÁðcÇÂ“\
r“¤Ugúz@˜â`¨xU\000þUecÁ7Æ<Q‚¨¥”!ÆM°ftW„=¢x×äx ô3¤DYB¤Pˆˆ*€Æ|ÀŽP‚ÆYC¼Š€:;„ÈcÌr$døàÄ×‚ÜU`z<àÜ'b;ÇÌ	åFLà×Àô#M~6Ãª¦ÀÛföª\000¢¨§ vKnFG\"CŠ@.‘qÖ9¤p¥Œ:¤pƒ6bŠ×Šs$@Er\rÀC¸<ÌàjŽ\
¯Ž!è0dp’Üfc2fbZž dÛ`Æž¡\000m¯¨J$„p)	êEæ<,f<ŒàÜ>ÍjÀYÎ\rÏÛ	äpLàá¨0˜h07qâ·Ó«bÖçH˜sl´Â<ŒÈ\
±öAðÊ­èþ\
LÃ¸Kâ¨|'¤+Æ{àÜF‚ì.Ì‚cÄK1É \rÆö·ÀN¬óÈ\000*<·ÀB `rä‰2)ó>zOšd\000.ZÞ¨ó¢¨ª6ã\r¨Èà@;&*xP„Ø|ÉrÆÉrV\000\"B’jX^ð¨I*’dJ’cŠ^ã3& ¢×‹ä’j²^ë7\r,nH‰E=ÔÌ¡Ö&ëØ¸aÌA¸*ŽfR(\000ƒÉ,bŒÀBÆÀEYA€ÀB°`b\rBPûFå\000\000Fp¸ `j bP@€ô\".à @&ÕdÀô\"	B‡-\000Ü @ô¢E€ n.@‚ `\000ÊpF`,ëFP€:P€)K€Ü &@)P€Ü`*@Kà\000$@´@2° ôU*\rÀ4-m\",ã¸\
2¬P€›O£¸\0006@*Bh0R-fÎ@À'Òþ\"}dÂP€;€&;€;€„\"àG ÜÖ!J@;€¦q&Ž\rx\
€x'ÎôoâÖâÖ	‚ÖÔ®\rÇN@\
8:\000Ð®q.°\000 \000¨ P”Xƒî\
à"
	}
}
)
