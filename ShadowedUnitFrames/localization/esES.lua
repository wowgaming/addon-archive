if( GetLocale() ~= "esES" ) then return end
local L = {}

local ShadowUF = select(2, ...)
ShadowUF.L = setmetatable(L, {__index = ShadowUF.L})
