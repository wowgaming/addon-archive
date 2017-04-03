--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-esES.lua - Localized string constants (es-ES/es-MX).        *
  ****************************************************************************]]


if ( GetLocale() ~= "esES" and GetLocale() ~= "esMX" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/esES/
local _NPCScan = select( 2, ... );
_NPCScan.L.NPCs = setmetatable( {
	[ 18684 ] = "Bro'Gaz sin Clan",
	[ 32491 ] = "Protodraco Tiempo Perdido",
	[ 33776 ] = "Gondria",
	[ 35189 ] = "Skoll",
	[ 38453 ] = "Arcturis",
}, { __index = _NPCScan.L.NPCs; } );