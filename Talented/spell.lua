local function handle_ranks(...)
	local result = {}
	local first = (...)
	local pos, row, column, req = 1
	local c = string.byte(first, pos)
	if c == 42 then
		row, column = nil, -1
		pos = pos + 1
		c = string.byte(first, pos)
	elseif c > 32 and c <= 40 then
		column = c - 32
		if column > 4 then
			row = true
			column = column - 4
		end
		pos = pos + 1
		c = string.byte(first, pos)
	end
	if c >= 65 and c <= 90 then
		req = c - 64
		pos = pos + 1
	elseif c >= 97 and c <= 122 then
		req = 96 - c
		pos = pos + 1
	end
	result[1] = tonumber(first:sub(pos))
	for i = 2, select("#", ...) do
		result[i] = tonumber((select(i, ...)))
	end
	local entry = {
		ranks = result,
		row = row,
		column = column,
		req = req
	}
	if not result[1] then
		entry.req = nil
		entry.ranks = nil
		entry.inactive = true
	end
	return entry
end

local function next_talent_pos(row, column)
	column = column + 1
	if column >= 5 then
		return row + 1, 1
	else
		return row, column
	end
end

local function handle_talents(...)
	local result = {}
	for talent = 1, select("#", ...) do
		result[talent] = handle_ranks(strsplit(";", (select(talent, ...))))
	end
	local row, column = 1, 1
	for index, talent in ipairs(result) do
		local drow, dcolumn = talent.row, talent.column
		if dcolumn == -1 then
			talent.row, talent.column = result[index - 1].row, result[index - 1].column
			talent.inactive = true
		elseif dcolumn then
			if drow then
				row = row + 1
				column = dcolumn
			else
				column = column + dcolumn
			end
			talent.row, talent.column = row, column
		else
			talent.row, talent.column = row, column
		end
		if dcolumn ~= -1 or drow then
			row, column = next_talent_pos(row, column)
		end
		if talent.req then
			talent.req = talent.req + index
			assert(talent.req > 0 and talent.req <= #result)
		end
	end
	return result
end

local function handle_tabs(...)
	local result = {}
	for tab = 1, select("#", ...) do
		result[tab] = handle_talents(strsplit(",", (select(tab, ...))))
	end
	return result
end

function Talented:UncompressSpellData(class)
	local data = self.spelldata[class]
	if type(data) == "table" then return data end
	self:Debug("UNCOMPRESS CLASSDATA", class)
	data = handle_tabs(strsplit("|", data))
	self.spelldata[class] = data
	if class == select(2, UnitClass"player") then
		self:CheckSpellData(class)
	end
	return data
end

local spellTooltip
local function CreateSpellTooltip()
	local tt = CreateFrame"GameTooltip"
	local lefts, rights = {}, {}
	for i = 1, 5 do
		local left, right = tt:CreateFontString(), tt:CreateFontString()
		left:SetFontObject(GameFontNormal)
		right:SetFontObject(GameFontNormal)
		tt:AddFontStrings(left, right)
		lefts[i], rights[i] = left, right
	end
	tt.lefts, tt.rights = lefts, rights
	function tt:SetSpell(spell)
		self:SetOwner(TalentedFrame)
		self:ClearLines()
		self:SetHyperlink("spell:"..spell)
		return self:NumLines()
	end
	local index
	if CowTip then
		index = function (self, key)
			if not key then return "" end
			local lines = tt:SetSpell(key)
			if not lines then return "" end
			local value
			if lines == 2 and not tt.rights[2]:GetText() then
				value = tt.lefts[2]:GetText()
			else
				value = {}
				for i=2, tt:NumLines() do
					value[i - 1] = {
						left=tt.lefts[i]:GetText(),
						right=tt.rights[i]:GetText(),
					}
				end
			end
			tt:Hide() -- CowTip forces the Tooltip to Show, for some reason
			self[key] = value
			return value
		end
	else
		index = function (self, key)
			if not key then return "" end
			local lines = tt:SetSpell(key)
			if not lines then return "" end
			local value
			if lines == 2 and not tt.rights[2]:GetText() then
				value = tt.lefts[2]:GetText()
			else
				value = {}
				for i=2, tt:NumLines() do
					value[i - 1] = {
						left=tt.lefts[i]:GetText(),
						right=tt.rights[i]:GetText(),
					}
				end
			end
			self[key] = value
			return value
		end
	end
	Talented.spellDescCache = setmetatable({}, { __index = index, })
	CreateSpellTooltip = nil
	return tt
end

function Talented:GetTalentName(class, tab, index)
	local spell = self:UncompressSpellData(class)[tab][index].ranks[1]
	return (GetSpellInfo(spell))
end

function Talented:GetTalentIcon(class, tab, index)
	local spell = self:UncompressSpellData(class)[tab][index].ranks[1]
	return (select(3, GetSpellInfo(spell)))
end

function Talented:GetTalentDesc(class, tab, index, rank)
	if not spellTooltip then
		spellTooltip = CreateSpellTooltip()
	end
	local spell = self:UncompressSpellData(class)[tab][index].ranks[rank]
	return self.spellDescCache[spell]
end

function Talented:GetTalentPos(class, tab, index)
	local talent = self:UncompressSpellData(class)[tab][index]
	return talent.row, talent.column
end

function Talented:GetTalentPrereqs(class, tab, index)
	local talent = self:UncompressSpellData(class)[tab][index]
	return talent.req
end

function Talented:GetTalentRanks(class, tab, index)
	local talent = self:UncompressSpellData(class)[tab][index]
	return #talent.ranks
end

function Talented:GetTalentLink(template, tab, index, rank)
	local data = self:UncompressSpellData(template.class)
	local rank = rank or (template[tab] and template[tab][index])
	if not rank or rank == 0 then
		rank = 1
	end
	return
		("|cff71d5ff|Hspell:%d|h[%s]|h|r"):format(data[tab][index].ranks[rank], self:GetTalentName(template.class, tab, index))
end
