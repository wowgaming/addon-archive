--[[
AtlasLoot_GetLocaleLibBabble(typ)
Get english translations for non translated things. (Combines Locatet and English table)
Only Useable with LibBabble
]]
function AtlasLoot_GetLocaleLibBabble(typ)
	--local tab = LibStub(typ):GetBaseLookupTable()
	--local loctab = LibStub(typ):GetUnstrictLookupTable()
	--setmetatable(loctab, {
	--	__index = tab
	--})
	
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