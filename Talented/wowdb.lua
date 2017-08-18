local Talented = Talented
local ipairs = ipairs

local L = LibStub("AceLocale-3.0"):GetLocale("Talented")

local idFromClass = {
	WARRIOR = 1,
	PALADIN = 2,
	HUNTER = 3,
	ROGUE = 4,
	PRIEST = 5,
	DEATHKNIGHT = 6,
	SHAMAN = 7,
	MAGE = 8,
	WARLOCK = 9,
	DRUID = 11,
}

local classFromId = {}
for k, v in pairs(idFromClass) do classFromId[v] = k end

local diffStringMap = {
	[0] = "e",
	[1] = "d",
	[2] = "c",
	[3] = "b",
	[4] = "a",
	e = 0,
	d = 1,
	c = 2,
	b = 3,
	a = 4,
}

Talented.importers[".*/talent%-calc%.xml%?"] = function (self, url, dst)
	local s, _, key, value, src = url:find(".*/talent%-calc%.xml%?(.*)=(.*)&tal=(%d+)$")
	if not s then
		return
	end
	local class
	if key == 'cid' then
		class = classFromId[tonumber(value)]
	elseif key == 'pid' then
		class = self:GetPetClassByFamily(tonumber(value))
	elseif key == 'c' then
		class = value:upper():replace('+', '')
		if not idFromClass[class] then return end
	end

	dst.class = class
	local count = 1
	local info = self:UncompressSpellData(class)
	local len = src:len()

	for tab, tree in ipairs(info) do
		local t = {}
		dst[tab] = t
		for index = 1, #tree do
			t[index] = tonumber(src:sub(count, count))
			count = count + 1
			if count > len then break end
		end
	end
	return dst
end

Talented.exporters[L["Blizzard Talent Calculator"]] = function (self, template)
	if not RAID_CLASS_COLORS[template.class] then
		return self:ExportWowpetTemplate(template)
	end
	local s = {}
	for _, tree in ipairs(template) do
		for _, n in ipairs(tree) do
			s[#s + 1] = tostring(n)
		end
	end
	return L["http://www.wowarmory.com/talent-calc.xml?%s=%s&tal=%s"]:format("cid", idFromClass[template.class], table.concat(s))
end

Talented.exporters[L["Wowdb Talent Calculator"]] = function (self, template)
	local class = template.class
	if not RAID_CLASS_COLORS[class] then return end
	local talents = self:UncompressSpellData(class)
	if not talents then return end

	local result = "http://www.wowdb.com/talent.aspx?id="..idFromClass[class].."#"
	local lchar, nchar, clen = "", nil, 0

	for tab, tree in ipairs(talents) do
		for id, talent in ipairs(tree) do
			local value = template[tab][id]
			local max = #talent.ranks
			local diff = max - value
			if diff == max then
				nchar = "f"
			else
				nchar = diffStringMap[diff]
			end
			if nchar == lchar then
				clen = clen + 1
			else
				if clen > 1 then
					result = result..lchar..clen
				else
					result = result..lchar
				end
				clen = 1
				lchar = nchar
			end
		end
	end
	if clen > 1 then
		result = result..lchar..clen
	else
		result = result..lchar
	end
	return result
end

Talented.importers["/talent.aspx%?"] = function (self, s, dst)
	local id, code = s:match("/talent%.aspx%?id=(%d+)#(.*)")
	if not id then
		return
	end
	local class = classFromId[tonumber(id)]
	dst.class = class
	local talents = self:UncompressSpellData(class)
	if not talents then return end
	local tab, index = 1, 1
	for char, count in code:gmatch("([a-f])([0-9]*)") do
		count = tonumber(count) or 1
		for _ = 1, count do
			local t = dst[tab]
			if not t then
				t = {}
				dst[tab] = t
			end
			local ranks = #talents[tab][index].ranks
			local result
			if char == "f" then
				result = 0
			else
				result = ranks - diffStringMap[char]
			end
			t[index] = result
			index = index + 1
			if index > #talents[tab] then
				tab = tab + 1
				index = 1
			end
		end
	end
	return dst
end
