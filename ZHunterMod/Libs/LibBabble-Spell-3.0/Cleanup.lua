local MAJOR_VERSION = "LibBabble-Spell-3.0"
local MINOR_VERSION = tonumber(("$Revision: 61661 $"):match("%d+")) or 0

if MINOR_VERSION > _G.LibBabble_Spell_3_0_MINOR then
	_G.LibBabble_Spell_3_0_MINOR = MINOR_VERSION
end

local lib, oldMinor = LibStub("LibBabble-3.0"):New(MAJOR_VERSION, _G.LibBabble_Spell_3_0_MINOR)
if not lib then
	_G.LibBabble_Spell_3_0_funcs = nil
	_G.LibBabble_Spell_3_0_MINOR = nil
	return
end

for _,v in ipairs(_G.LibBabble_Spell_3_0_funcs) do
	v(lib)
end

_G.LibBabble_Spell_3_0_funcs = nil
_G.LibBabble_Spell_3_0_MINOR = nil