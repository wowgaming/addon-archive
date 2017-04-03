if( GetLocale() ~= "esMX" ) then return end
local L = {}

local ShadowUF = select(2, ...)
ShadowUF.L = setmetatable(L, {__index = ShadowUF.L})
