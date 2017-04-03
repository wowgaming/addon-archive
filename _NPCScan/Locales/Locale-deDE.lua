--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-deDE.lua - Localized string constants (de-DE).              *
  ****************************************************************************]]


if ( GetLocale() ~= "deDE" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/deDE/
local _NPCScan = select( 2, ... );
_NPCScan.L.NPCs = setmetatable( {
	[ 18684 ] = "Bro'Gaz der Klanlose",
	[ 32491 ] = "Zeitverlorener Protodrache",
	[ 33776 ] = "Gondria",
	[ 35189 ] = "Skoll",
	[ 38453 ] = "Arcturis",
}, { __index = _NPCScan.L.NPCs; } );