local L = LibStub("AceLocale-3.0"):GetLocale("Talented")
local Talented = Talented

Talented.importers["talent%.mmo%-champion%.com/"] = function (self, url, dst)
	local s, _, class, src = url:find(".*talent%.mmo%-champion%.com/%?([^=]+)=([0-5]+)")
	if not s then
		return
	end

	dst.class = class:upper()
	local count = 1
	local info = self:UncompressSpellData(dst.class)
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

Talented.exporters[L["MMO Champion Talent Calculator"]] = function (self, template)
	if not RAID_CLASS_COLORS[template.class] then return end
	local s = {}
	for _, tree in ipairs(template) do
		for _, n in ipairs(tree) do
			s[#s + 1] = tostring(n)
		end
	end
	return ("http://talent.mmo-champion.com/?%s=%s"):format(template.class:lower(), table.concat(s))
end
