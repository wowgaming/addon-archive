local Talented = Talented
local L = LibStub("AceLocale-3.0"):GetLocale("Talented")

local WH_MAP = "0zMcmVokRsaqbdrfwihuGINALpTjnyxtgevE"
local WH_PET_INFO_CLASS = "FFCTTTFTT FF       TT  CFCC  CCTCCC FCF CTTFFF"

local TALENTED_MAP = "012345abcdefABCDEFmnopqrMNOPQRtuvwxy*"
local TALENTED_CLASS_CODE = {
	F = "Ferocity",
	C = "Cunning",
	T = "Tenacity",

	Ferocity = "t",
	Cunning = "w",
	Tenacity = "*",
	["t"] = "Ferocity",
	["w"] = "Cunning",
	["*"] = "Tenacity",
}

function Talented:GetPetClassByFamily(index)
	return TALENTED_CLASS_CODE[WH_PET_INFO_CLASS:sub(index, index)]
end

local function GetPetFamilyForClass(class)
	return WH_PET_INFO_CLASS:find(class:sub(1, 1), nil, true)
end

local function map(code, src, dst)
	local temp = {}
	for i = 1, string.len(code) do
		local index = assert(src:find(code:sub(i, i), nil, true))
		temp[i] = dst:sub(index, index)
	end
	return table.concat(temp)
end

local function ImportCode(code)
	local a = (WH_MAP:find(code:sub(1, 1), nil, true) - 1) * 10
	local b = (WH_MAP:find(code:sub(2, 2), nil, true) - 1) / 2
	local family = a + math.floor(b)
	local class = Talented:GetPetClassByFamily(family)

	return TALENTED_CLASS_CODE[class]..map(code:sub(3), WH_MAP, TALENTED_MAP)
end

local function ExportCode(code)
	local class = TALENTED_CLASS_CODE[code:sub(1, 1)]
	local family = GetPetFamilyForClass(class)

	local a = math.floor(family / 10)
	local b = (family - (a * 10)) * 2 + 1
	return WH_MAP:sub(a + 1, a + 1)..WH_MAP:sub(b, b)..map(code:sub(2), TALENTED_MAP, WH_MAP)
end

local function FixImportTemplate(self, template)
	local data = self:UncompressSpellData(template.class)[1]
	template = template[1]
	for index, info in ipairs(data) do
		if info.inactive then
			if index > 1 and info.row == data[index - 1].row and info.column == data[index - 1].column then
				template[index - 1] = template[index] + template[index - 1]
			elseif index < #data and info.row == data[index + 1].row and info.column == data[index + 1].column then
				template[index + 1] = template[index] + template[index + 1]
			end
		end
	end
end

local function FixExportTemplate(self, template)
	local data = self:UncompressSpellData(template.class)[1]
	template = template[1]
	for index, info in ipairs(data) do
		if info.inactive then
			if index > 1 and info.row == data[index - 1].row and info.column == data[index - 1].column then
				template[index - 1] = template[index] + template[index - 1]
			end
		end
	end
end

Talented.importers["/%??petcalc#"] = function (self, url, dst)
	local s, _, code = url:find(".*/%??petcalc#(.*)$")
	if not s or not code then return end
	code = ImportCode(code)
	if not code then return end
	local val, class = self:StringToTemplate(code, dst)
	dst.class = class
	FixImportTemplate(self, dst)
	return dst
end

function Talented:ExportWhpetTemplate(template)
	if RAID_CLASS_COLORS[template.class] then return end
	FixExportTemplate(self, template)
	local code = ExportCode(self:TemplateToString(template))
	FixImportTemplate(self, template)
	if code then
		return L["http://www.wowhead.com/petcalc#%s"]:format(code)
	end
end

function Talented:ExportWowpetTemplate(template)
	if RAID_CLASS_COLORS[template.class] then return end
	FixExportTemplate(self, template)
	local family = GetPetFamilyForClass(template.class)
	local s = {}
	for _, tree in ipairs(template) do
		for _, n in ipairs(tree) do
			s[#s + 1] = tostring(n)
		end
	end
	return L["http://www.wowarmory.com/talent-calc.xml?%s=%s&tal=%s"]:format("pid", family, table.concat(s))
end
