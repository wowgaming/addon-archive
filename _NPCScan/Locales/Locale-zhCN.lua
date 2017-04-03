--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-zhCN.lua - Localized string constants (zh-CN).              *
  ****************************************************************************]]


if ( GetLocale() ~= "zhCN" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/zhCN/
local _NPCScan = select( 2, ... );
_NPCScan.L.NPCs = setmetatable( {
	[ 18684 ] = "独行者布罗加斯",
	[ 33776 ] = "古德利亚",
}, { __index = _NPCScan.L.NPCs; } );