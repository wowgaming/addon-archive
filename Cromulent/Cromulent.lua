--[[
--	Credit to ckknight for originally writing Cartographer_ZoneInfo
--]]
Cromulent = LibStub("AceAddon-3.0"):NewAddon("Cromulent", "AceHook-3.0")
local Cromulent, self = Cromulent, Cromulent
-- Perhaps add toggling of the different infos later.
--[[local defaults = {
	profile = {
		zonelevels = true,
		instances = true,
		fishing = true,
	},
}]]
local L = LibStub("AceLocale-3.0"):GetLocale("Cromulent")
local T = LibStub("LibTourist-3.0")
local string_format = string.format
local string_gsub = string.gsub
local table_concat = table.concat
local table_insert = table.insert
local table_wipe = table.wipe
local GetCurrentMapContinent = GetCurrentMapContinent
local GetNumSkillLines = GetNumSkillLines
local GetSkillLineInfo = GetSkillLineInfo
local GetSpellInfo = GetSpellInfo
local fishingSpell -- Filled in in OnEnable

function Cromulent:OnEnable()
	if not self.frame then
		self.frame = CreateFrame("Frame", "CromulentZoneInfo", WorldMapFrame)

		self.frame.text = WorldMapFrameAreaFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
		local text = self.frame.text
		local font, size = GameFontHighlightLarge:GetFont()
		text:SetFont(font, size, "OUTLINE")
		text:SetPoint("TOP", WorldMapFrameAreaDescription, "BOTTOM", 0, -5)
		text:SetWidth(1024)
	end
	fishingSpell = GetSpellInfo(7620)
	self.frame:Show()
	self:SecureHookScript(WorldMapButton, "OnUpdate", "WorldMapButton_OnUpdate")
end

function Cromulent:OnDisable()
	self.frame:Hide()
	WorldMapFrameAreaLabel:SetTextColor(1, 1, 1)
end

local lastZone	-- So we don't keep processing zones in every Update
local t = {}	-- Text to display stored here

function Cromulent:WorldMapButton_OnUpdate()
	if not self.frame then
		return
	end
	if not WorldMapDetailFrame:IsShown() or not WorldMapFrameAreaLabel:IsShown() then
		self.frame.text:SetText("")
		lastZone = nil
		return
	end

	-- Under Attack is used during events like the Naxxramas opening event.
	local underAttack = false
	local zone = WorldMapFrameAreaLabel:GetText()
	if zone then
		zone = string_gsub(WorldMapFrameAreaLabel:GetText(), " |cff.+$", "")
		if WorldMapFrameAreaDescription:GetText() then
			underAttack = true
			zone = string_gsub(WorldMapFrameAreaDescription:GetText(), " |cff.+$", "")
		end
	end
	-- Set the text to white and hide the zone info if we're hovering over
	-- Kalimdor or Eastern Kingdoms on the old world continement map (I think)
	if GetCurrentMapContinent() == 0 then
		local c1, c2 = GetMapContinents()
		if zone == c1 or zone == c2 then
			WorldMapFrameAreaLabel:SetTextColor(1, 1, 1)
			self.frame.text:SetText("")
			return
		end
	end
	-- If we didn't find a zone, or the zone isn't an instance or a real zone
	-- steal the zone name from the WorldMapFrame
	if not zone or not T:IsZoneOrInstance(zone) then
		zone = WorldMapFrame.areaName
	end
	WorldMapFrameAreaLabel:SetTextColor(1, 1, 1)
	-- Now we can do some real work if the zone is a real zone and/or has instances
	if zone and (T:IsZoneOrInstance(zone) or T:DoesZoneHaveInstances(zone)) then
		-- For PvP servers, perhaps?  I haven't seen this do anything on my home (PvE) server
		-- when a city was attacked.
		if not underAttack then
			WorldMapFrameAreaLabel:SetTextColor(T:GetFactionColor(zone))
			WorldMapFrameAreaDescription:SetTextColor(1, 1, 1)
		else
			WorldMapFrameAreaLabel:SetTextColor(1, 1, 1)
			WorldMapFrameAreaDescription:SetTextColor(T:GetFactionColor(zone))
		end
		local low, high = T:GetLevel(zone)
		local minFish = T:GetFishingLevel(zone)
		local fishingSkillText
		-- Fishing levels!
		if minFish then
			-- Find our current fishing rank
			for i = 1, GetNumSkillLines() do
				local skillName, _, _, skillRank = GetSkillLineInfo(i)
				if skillName == fishingSpell then
					local r, g, b = 1, 1, 0
					local r1, g1, b1 = 1, 0, 0
					if minFish < skillRank then
						r1, g1, b1 = 0, 1, 0
					end
					fishingSkillText = string_format("|cff%02x%02x%02x%s|r |cff%02x%02x%02x[%d]|r", r * 255, g * 255, b * 255, fishingSpell, r1 * 255, g1 * 255, b1 * 255, minFish)
					-- Break out of the loop after it has been found.
					break
				end
			end
			if not fishingSkillText then
				minFish = nil
			end
		end
		-- Set the difficulty colour of the zone, based on our current level.
		if low > 0 and high > 0 then
			local r, g, b = T:GetLevelColor(zone)
			local levelText
			if low == high then
				levelText = string_format(" |cff%02x%02x%02x[%d]|r", r * 255, g * 255, b * 255, high)
			else
				levelText = string_format(" |cff%02x%02x%02x[%d-%d]|r", r * 255, g * 255, b * 255, low, high)
			end
			local groupSize = T:GetInstanceGroupSize(zone)
			local sizeText = ""
			if groupSize > 0 then
				sizeText = " " .. string_format(L["%d-man"], groupSize)
			end
			if not underAttack then
				WorldMapFrameAreaLabel:SetText(string_gsub(WorldMapFrameAreaLabel:GetText(), " |cff.+$", "") .. levelText .. sizeText)
			else
				WorldMapFrameAreaDescription:SetText(string_gsub(WorldMapFrameAreaDescription:GetText(), " |cff.+$", "") .. levelText .. sizeText)
			end
		end
		-- List the instances in the zone if it has any.
		if T:DoesZoneHaveInstances(zone) then
			if lastZone ~= zone then
				-- Set lastZone so we don't keep grabbing this info in every Update.
				lastZone = zone
				table_insert(t, string_format("|cffffff00%s:|r", L["Instances"]))
				-- Iterate over the instance list and insert them into t[]
				for instance in T:IterateZoneInstances(zone) do
					local complex = T:GetComplex(instance)
					local low, high = T:GetLevel(instance)
					local r1, g1, b1 = T:GetFactionColor(instance)
					local r2, g2, b2 = T:GetLevelColor(instance)
					local groupSize = T:GetInstanceGroupSize(instance)
					local name = instance
					if complex then
						name = complex .. " - " .. instance
					end
					if low == high then
						if groupSize > 0 then
							table_insert(t, string_format("|cff%02x%02x%02x%s|r |cff%02x%02x%02x[%d]|r " .. L["%d-man"], r1 * 255, g1 * 255, b1 * 255, name, r2 * 255, g2 * 255, b2 * 255, high, groupSize))
						else
							table_insert(t, string_format("|cff%02x%02x%02x%s|r |cff%02x%02x%02x[%d]|r", r1 * 255, g1 * 255, b1 * 255, name, r2 * 255, g2 * 255, b2 * 255, high))
						end
					else
						if groupSize > 0 then
							table_insert(t, string_format("|cff%02x%02x%02x%s|r |cff%02x%02x%02x[%d-%d]|r " .. L["%d-man"], r1 * 255, g1 * 255, b1 * 255, name, r2 * 255, g2 * 255, b2 * 255, low, high, groupSize))
						else
							table_insert(t, string_format("|cff%02x%02x%02x%s|r |cff%02x%02x%02x[%d-%d]|r", r1 * 255, g1 * 255, b1 * 255, name, r2 * 255, g2 * 255, b2 * 255, low, high))
						end
					end
				end
				-- Add the fishing info to t[] if it exists.
				if minFish and fishingSkillText then
					table_insert(t, fishingSkillText)
				end
				-- OK, add all of the info from t[] into the zone info!
				self.frame.text:SetText(table_concat(t, "\n"))
				-- Reset t[], ready for the next run.
				table_wipe(t)
			end
		else 	-- If the zone has no instances
			-- Just set the fishing level text and be on our way.
			if minFish and fishingSkillText then
				self.frame.text:SetText(fishingSkillText)
			else
				self.frame.text:SetText("")
			end
			lastZone = nil
		end
	elseif not zone then
		-- If we couldn't identify a valid zone at all, just blank it out.
		lastZone = nil
		self.frame.text:SetText("")
	end
end
