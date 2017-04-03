if GetLocale() == "esES" or GetLocale() == "esMX" then
	-- Maulgar
	DBM_MAULGAR_NAME			= "Su majestad Maulgar";
	DBM_MAULGAR_DESCRIPTION		= "Anuncia escudo y sanación y muestra tiempo para Machaque, Torbellino y salida de manáfago.";
	DBM_MAULGAR_OPTION_1		= "Anunciar Palabra de poder superior: escudo";
	DBM_MAULGAR_OPTION_2		= "Anunciar Escudo contra hechizos";
	DBM_MAULGAR_OPTION_3		= "Anunciar Rezo de sanación";
	DBM_MAULGAR_OPTION_4		= "Anunciar Sanar";
	DBM_MAULGAR_OPTION_5		= "Anunciar Torbellino";
	DBM_MAULGAR_OPTION_6		= "Anunciar Machaque arqueado";
	DBM_MAULGAR_OPTION_7		= "Anunciar Manáfago";

	DBM_MAULGAR_WARN_GPWS		= "*** Escudo en Ciego ***";
	DBM_MAULGAR_WARN_SHIELD		= "*** Escudo contra hechizos en Krosh ***";
	DBM_MAULGAR_WARN_SMASH		= "Machaque arqueado en >%s<: %s";
	DBM_MAULGAR_WARN_POH		= "*** Ciego castea Rezo de sanación ***";
	DBM_MAULGAR_WARN_HEAL		= "*** Ciego castea Sanar ***";

	DBM_MAULGAR_WARN_WHIRLWIND	= "*** Torbellino ***";
	DBM_MAULGAR_WARN_WW_SOON	= "*** Torbellino ponto ***";
	DBM_MAULGAR_WARN_FELHUNTER	= "*** Felhunter ***";


	DBM_MAULGAR_DODGED	= "esquivado";
	DBM_MAULGAR_PARRIED	= "parado";
	DBM_MAULGAR_MISSED	= "fallado";


	-- Gruul
	DBM_GRUUL_NAME				= "Gruul el Asesino de Dragones";
	DBM_GRUUL_DESCRIPTION		= "Anuncia Trizar, Crecimiento, Reverberación y Sepultar";

	DBM_GRUUL_RANGE_OPTION		= "Muestra una ventana para comprobar distancia";
	DBM_GRUUL_GROW_OPTION		= "Anuncia Crecimiento";
	DBM_GRUUL_SHATTER_OPTION	= "Anuncia Embate en el suelo y Trizar";
	DBM_GRUUL_SILENCE_OPT		= "Anuncia Silenciar";
	DBM_GRUUL_CAVE_OPTION		= "Mostrar aviso especial para Sepultar";
	DBM_GRUUL_OPTION_GROWBAR	= "Crece"

	DBM_GRUUL_SAY_PULL			= "Come.... and die."--translate
	DBM_GRUUL_GROW_EMOTE		= "%s crece de tamaño!";
	DBM_GRUUL_EMOTE_SHATTER		= "%s ruge!";
	DBM_GRUUL_SILENCE			= "Reverberación";

	DBM_GRUUL_GROW_ANNOUNCE		= "*** Crece #%s ***";
	DBM_GRUUL_SHATTER_WARN		= "*** Trizar ***";
	DBM_GRUUL_SHATTER_20WARN	= "*** Embate en el suelo pronto ***";
	DBM_GRUUL_SHATTER_10WARN	= "*** Embate en el suelo - Trizar en 10 seg ***";
	DBM_GRUUL_SHATTER_SOON		= "*** Trizar pronto ***";
	DBM_GRUUL_SILENCE_WARN		= "*** Silenciar ***";
	DBM_GRUUL_SILENCE_SOON_WARN	= "*** Silenciar pronto ***";
	DBM_GRUUL_CAVE_IN_WARN		= "Trizar";


	-- LordKazzak
	DBM_KAZZAK_NAME				= "Señor de fatalidad Kazzak";
	DBM_KAZZAK_DESCRIPTION		= "Anuncia Enrage, Marca de Kazzak y Reflejo retorcido.";
	DBM_KAZZAK_OPTION_1			= "Anunciar Enrage";
	DBM_KAZZAK_OPTION_2			= "Anunciar Reflejo retorcido";
	DBM_KAZZAK_OPTION_3			= "Anunciar Marca de Kazzak";
	DBM_KAZZAK_OPTION_4			= "Poner icono";
	DBM_KAZZAK_OPTION_5			= "Enviar susurro";

	DBM_KAZZAK_YELL_PULL		= "All mortals will perish!";--translate
	DBM_KAZZAK_YELL_PULL2		= "The Legion will conquer all!";--translate
	DBM_KAZZAK_EMOTE_ENRAGE		= "%s entra en enrage!";

	DBM_KAZZAK_SUP_SEC			= "*** Enrage en %s seg ***";
	DBM_KAZZAK_SUP_SOON			= "*** Enrage pronto ***";
	DBM_KAZZAK_TWISTED_WARN		= "*** Reflejo retorcido en >%s< ***";
	DBM_KAZZAK_MARK_WARN		= "*** Marca de Kazzak en >%s< ***";
	DBM_KAZZAK_WARN_ENRAGE		= "*** Enrage ***";
	DBM_KAZZAK_MARK_SPEC_WARN	= "¡Tienes la marca de Kazzak!";

	-- Magtheridon
	DBM_MAG_NAME			= "Magtheridon";
	DBM_MAG_DESCRIPTION		= "Anuncia Infernales y Alivio oscuro y muestra los tiempos para la fase 2 y Nova explosiva.";
	DBM_MAG_OPTION_1		= "Anunciar Infernales";
	DBM_MAG_OPTION_2		= "Anunciar Sanación";
	DBM_MAG_OPTION_3		= "Anunciar Nova explosiva";

	DBM_MAG_EMOTE_PULL		= "¡Las cadenas de %s empiezan a debilitarse!";
	DBM_MAG_YELL_PHASE2		= "I... am... unleashed!"--translate
	DBM_MAG_EMOTE_NOVA		= "¡%s empieza a castear Nova explosiva!";

	DBM_MAG_PHASE2_WARN		= "*** Fase 2 en %s seg ***";
	DBM_MAG_WARN_P2			= "*** Magtheridon se libera ***";
	DBM_MAG_WARN_INFERNAL	= "*** Infernal ***";
	DBM_MAG_WARN_HEAL		= "*** Sanación ***";
	DBM_MAG_WARN_NOVA_NOW	= "*** Nova explosiva ***";
	DBM_MAG_WARN_NOVA_SOON	= "¡Preparate para Nova explosiva!";



	-- Doomwalker
	DBM_DOOMW_NAME			= "Caminante del Destino";
	DBM_DOOMW_DESCRIPTION	= "Muestra el tiempo para Terremoto.";
	DBM_DOOMW_OPTION_1		= "Mostrar distancia";
	DBM_DOOMW_OPTION_2		= "Anunciar Terremoto";
	DBM_DOOMW_OPTION_3		= "Anunciar Infestar";

	DBM_DOOMW_EMOTE_ENRAGE	= "¡%s entra en enrage!";

	DBM_DOOMW_QUAKE_WARN	= "*** Terremoto ***";
	DBM_DOOMW_QUAKE_SOON	= "*** Terremoto pronto ***";
	DBM_DOOMW_CHARGE		= "*** Infestar ***";
	DBM_DOOMW_CHARGE_SOON	= "*** Infestar pronto ***";
	DBM_DOOMW_WARN_ENRAGE	= "*** Enrage ***";
end
