local Talented = Talented
local ipairs = ipairs

local L = LibStub("AceLocale-3.0"):GetLocale("Talented")

Talented.importers[".*/(.*)/talents%..-%?t?a?l?=?(%d+)$"] = function (self, url, dst)
	local s, _, class, src = url:find(".*/(.*)/talents%..-%?t?a?l?=?(%d+)$")
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

Talented.importers["/%??talent#"] = function (self, url, dst)
	local s, _, code = url:find(".*/%??talent#(.*)$")
	if not s or not code then return end
	local p = code:find(":", nil, true)
	if p then code = code:sub(1, p -1) end
	local val, class = self:StringToTemplate(code, dst, "0zMcmVokRsaqbdrfwihuGINALpTjnyxtgevE")
	dst.class = class
	return dst
end

Talented.exporters[L["Wowhead Talent Calculator"]] = function (self, template)
	if not RAID_CLASS_COLORS[template.class] then return self:ExportWhpetTemplate(template) end
	return L["http://www.wowhead.com/talent#%s"]:format(self:TemplateToString(template, "0zMcmVokRsaqbdrfwihuGINALpTjnyxtgevE"))
end
