

local skillColors = {
	["unknown"]			= { r = 1.00, g = 0.00, b = 0.00, level = 5, alttext="???", cstring = "|cffff0000"},
	["optimal"]	        = { r = 1.00, g = 0.50, b = 0.25, level = 4, alttext="+++", cstring = "|cffff8040"},
	["medium"]          = { r = 1.00, g = 1.00, b = 0.00, level = 3, alttext="++",  cstring = "|cffffff00"},
	["easy"]            = { r = 0.25, g = 0.75, b = 0.25, level = 2, alttext="+",   cstring = "|cff40c000"},
	["trivial"]	        = { r = 0.50, g = 0.50, b = 0.50, level = 1, alttext="",    cstring = "|cff808080"},
	["header"]          = { r = 1.00, g = 0.82, b = 0,    level = 0, alttext="",    cstring = "|cffffc800"},
}


function Skillet:GetTradeSkillLevels(id)
	if not id then return 0,0,0,0 end

	local levels

	local lib, minorVersion = LibStub:GetLibrary("LibPeriodicTable-3.1", true)

	if lib then
		levels = LibStub("LibPeriodicTable-3.1"):ItemInSet(id,"TradeskillLevels")
	end

--	local levels = self.SkillLevelsByID[id]

	if not levels then
		return 0,0,0,0
	else
		local a,b,c,d = string.split("/",levels)

		a = tonumber(a) or 0
		b = tonumber(b) or 0
		c = tonumber(c) or 0
		d = tonumber(d) or 0

		return a, b, c, d
	end
end


function Skillet:GetTradeSkillLevelColor(id, rank)
	if not id then return skillColors["unknown"] end

	local orange, yellow, green, gray = self:GetTradeSkillLevels(id)

	if rank >= gray then return skillColors["trivial"] end

	if rank >= green then return skillColors["easy"] end

	if rank >= yellow then return skillColors["moderate"] end

	if rank >= orange then return skillColors["optimal"] end

	return skillColors["unknown"]
end

