local type = type
local ipairs = ipairs
local Talented = Talented
local GameTooltip = GameTooltip
local IsAltKeyDown = IsAltKeyDown
local GREEN_FONT_COLOR = GREEN_FONT_COLOR
local NORMAL_FONT_COLOR = NORMAL_FONT_COLOR
local HIGHLIGHT_FONT_COLOR = HIGHLIGHT_FONT_COLOR
local RED_FONT_COLOR = RED_FONT_COLOR

local L = LibStub("AceLocale-3.0"):GetLocale("Talented")

local function addline(line, color, split)
	GameTooltip:AddLine(line, color.r, color.g, color.b, split)
end

local function addtipline(tip)
	local color = HIGHLIGHT_FONT_COLOR
	tip = tip or ""
	if type(tip) == "string" then
		addline(tip, NORMAL_FONT_COLOR, true)
	else
		for _, i in ipairs(tip) do
			if (_ == #tip) then color = NORMAL_FONT_COLOR end
			if i.right then
				GameTooltip:AddDoubleLine(i.left, i.right, color.r, color.g, color.b, color.r, color.g, color.b)
			else
				addline(i.left, color, true)
			end
		end
	end
end

local lastTooltipInfo = {}
function Talented:SetTooltipInfo(frame, class, tab, index)
	lastTooltipInfo[1] = frame
	lastTooltipInfo[2] = class
	lastTooltipInfo[3] = tab
	lastTooltipInfo[4] = index
	if not GameTooltip:IsOwned(frame) then
		GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
	end

	local tree = self.spelldata[class][tab]
	local info = tree[index]
	GameTooltip:ClearLines()
	local tier = (info.row - 1) * self:GetSkillPointsPerTier(class)
	local template = frame:GetParent().view.template

	self:UnpackTemplate(template)
	local rank = template[tab][index]
	local ranks, req = #info.ranks, info.req
	addline(self:GetTalentName(class, tab, index), HIGHLIGHT_FONT_COLOR)
	addline(TOOLTIP_TALENT_RANK:format(rank, ranks), HIGHLIGHT_FONT_COLOR)
	if req then
		local oranks = #tree[req].ranks
		if template[tab][req] < oranks then
			addline(TOOLTIP_TALENT_PREREQ:format(oranks, self:GetTalentName(class, tab, req)), RED_FONT_COLOR)
		end
	end
	if tier >= 1 and self:GetTalentTabCount(template, tab) < tier then
		addline(TOOLTIP_TALENT_TIER_POINTS:format(tier, self.tabdata[class][tab].name), RED_FONT_COLOR)
	end
	if IsAltKeyDown() then
		for i = 1, ranks do
			local tip = self:GetTalentDesc(class, tab, index, i)
			if type(tip) == "table" then tip = tip[#tip].left end
			addline(tip, i == rank and HIGHLIGHT_FONT_COLOR or NORMAL_FONT_COLOR, true)
		end
	else
		if rank > 0 then
			addtipline(self:GetTalentDesc(class, tab, index, rank))
		end
		if rank < ranks then
			if rank > 0 then
				addline("|n"..TOOLTIP_TALENT_NEXT_RANK, HIGHLIGHT_FONT_COLOR)
			end
			addtipline(self:GetTalentDesc(class, tab, index, rank + 1))
		end
	end
	local s = self:GetTalentState(template, tab, index)
	if self.mode == "edit" then
		if template.talentGroup then
			if s == "available" or s == "empty" then
				addline(TOOLTIP_TALENT_LEARN, GREEN_FONT_COLOR)
			end
		elseif s == "full" then
			addline(TALENT_TOOLTIP_REMOVEPREVIEWPOINT, GREEN_FONT_COLOR)
		elseif s == "available" then
			GameTooltip:AddDoubleLine(
				TALENT_TOOLTIP_ADDPREVIEWPOINT, TALENT_TOOLTIP_REMOVEPREVIEWPOINT,
				GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b,
				GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
		elseif s == "empty" then
			addline(TALENT_TOOLTIP_ADDPREVIEWPOINT, GREEN_FONT_COLOR)
		end
	end
	GameTooltip:Show()
end

function Talented:HideTooltipInfo()
	GameTooltip:Hide()
	wipe(lastTooltipInfo)
end

function Talented:UpdateTooltip()
	if next(lastTooltipInfo) then
		self:SetTooltipInfo(unpack(lastTooltipInfo))
	end
end

function Talented:MODIFIER_STATE_CHANGED(_, mod)
	if mod:sub(-3) == "ALT" then
		self:UpdateTooltip()
	end
end
