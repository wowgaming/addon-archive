-- Highlight.lua : Code to handle showing a highlight on a frame for an aura.

if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local _G = getfenv(0)
local PitBull4 = _G.PitBull4
local PitBull4_Aura = PitBull4:GetModule("Aura")
local L = PitBull4.L
local wipe = _G.table.wipe

local HighlightNormal_path, HighlightBorder_path, HighlightThinBorder_path
do
	local module_path = _G.debugstack():match("[d%.][d%.][O%.]ns\\(.-)\\[A-Za-z0-9]-%.lua")
	HighlightNormal_path = "Interface\\AddOns\\" .. module_path .. "\\HighlightNormal"
	HighlightBorder_path = "Interface\\AddOns\\" .. module_path .. "\\HighlightBorder"
	HighlightThinBorder_path = "Interface\\AddOns\\" .. module_path .. "\\HighlightThinBorder"
end


-- Handle the reusults table used for tracking the priority of auras to highlight
local results, pool = {}, {}

local function new_result()
	local t = next(pool)
	if t then
		pool[t] = nil
	else
		t = {}
	end
	return t
end

local function del_result(t)
	wipe(t)
	pool[t] = true
	return nil
end

-- Clean the results table before starting a highlight filter
function PitBull4_Aura:HighlightFilterStart()
	for i = 1, #results do
		results[i] = del_result(results[i])
	end
end

-- Replacement iterator for use when auras aren't being displayed on
-- a frame we want to highlight.  Arguments mirror the update_auras()
-- function in Update.lua.  TODO: Make get_aura_list() in Update.lua
-- and this use the same iterator.
local entry = {}
function PitBull4_Aura:HighlightFilterIterator(frame, db, is_buff)
	local unit = frame.unit
	if not unit then return end
	local filter = is_buff and "HELPFUL" or "HARMFUL"
	local id = 1

	-- Loop through the auras
	while true do
		-- Note entry[2] says if the aura is a weapon enchant
		entry[1], entry[2], entry[3], entry[4], entry[5], entry[6],
			entry[7], entry[8], entry[9], entry[10], entry[11],
			entry[12], entry[13], entry[14], entry[15]  = 
			id, nil, nil, is_buff, UnitAura(unit, id, filter)

		-- Hack to get around a Blizzard bug.  The Enrage debuff_type
		-- gets set to "" instead of "Enrage" like it should.
		-- Once this is fixed this code should be removed.
		if entry[9] == "" then
			entry[9] = "Enrage"
		end

		-- Make pre 3.1.0 clients emulate the return of the caster
		-- argument in the new 3.1.0 clients.  Once 3.1.0 is live
		-- for everyone this can be removed.
		if entry[12] == 1 then
			entry[12] = "player"
		end

		if not entry[5] then
			-- No more auras, break the outer loop
			break
		end

		self:HighlightFilter(db, entry, frame)

		id = id + 1
	end
end

-- Takes a single aura entry and runs the Highlight Filter on it.
-- Storing the results in the results table for use by SetHighlight()
-- later
function PitBull4_Aura:HighlightFilter(db, entry, frame)
	local highlight_filters = db.highlight_filters
	local highlight_filters_color_by_type = db.highlight_filters_color_by_type
	local highlight_filters_custom_color = db.highlight_filters_custom_color
	local dispel_type_colors = self.db.profile.global.colors.type

	-- Iterate the highlight filters
	for id = 1, #highlight_filters do
		local filter_name = highlight_filters[id]
		if filter_name and filter_name ~= "" then
			local filter = self:GetFilterDB(filter_name)
			if filter then
				-- Run the filter and capture the result
				local filter_func = self.filter_types[filter.filter_type].filter_func
				local filter_result = filter_func(filter_name, entry, frame)
				if filter_result then
					-- Setup an entry in our result table
					local result = new_result()
					result.priority = id

					-- Determine the color for the match
					if highlight_filters_color_by_type[id] then
						local dispel_type = tostring(entry[9])
						local color = dispel_type_colors[dispel_type]
						if not color then
							color = dispel_type_colors["nil"]
						end
						result.color = color
					else
						result.color = highlight_filters_custom_color[id]
					end

					-- Add the entry
					results[#results+1] = result
				end
			end
		end
	end
end

-- Sort the highlights to select the best possible match
local function result_sort(a, b)
	if not a then
		return false
	elseif not b then
		return true
	end

	local a_priority, b_priority = a.priority, b.priority
	if a_priority ~= b_priority then
		return a_priority < b_priority
	end
end


-- Handle displaying or removing the actual highlight based on the
-- contents of the results table.
function PitBull4_Aura:SetHighlight(frame, db)
	-- Sort the table first to ensure the first entry is the highest priority
	table.sort(results, result_sort)

	-- Grab the highlight to display.  TODO: Handle display of multiple highlights
	local entry = results[1]

	local aura_highlight = frame.aura_highlight
	if entry then
		-- Display the highlight
		if not aura_highlight then
			aura_highlight = PitBull4.Controls.MakeTexture(frame.overlay, "OVERLAY")
			frame.aura_highlight = aura_highlight
		end

		local highlight_style = db.highlight_style
		if highlight_style == "border" then
			aura_highlight:SetTexture(HighlightBorder_path)
		elseif highlight_style == "thinborder" then
			aura_highlight:SetTexture(HighlightThinBorder_path)
		else
			aura_highlight:SetTexture(HighlightNormal_path)
		end

		aura_highlight:SetBlendMode("ADD")
		aura_highlight:SetAlpha(0.75)
		aura_highlight:SetAllPoints(frame)
		aura_highlight:SetVertexColor(unpack(entry.color, 1, 3))
	else
		-- No highlight so remove one if we have one showing
		if aura_highlight then
			frame.aura_highlight = aura_highlight:Delete()
		end
	end
end
