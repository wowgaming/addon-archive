--[[
Atlas_GetLocaleLibBabble(typ)
Get english translations for non translated things. (Combines located and english table)
Only useable with LibBabble
]]
function Atlas_GetLocaleLibBabble(typ)

	local rettab = {}
	local tab = LibStub(typ):GetBaseLookupTable()
	local loctab = LibStub(typ):GetUnstrictLookupTable()
	for k,v in pairs(loctab) do
		rettab[k] = v;
	end
	for k,v in pairs(tab) do
		if not rettab[k] then
			rettab[k] = v;
		end
	end
	return rettab
end