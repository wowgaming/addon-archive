if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_Background requires PitBull4")
end

local PitBull4_Background = PitBull4:NewModule("Background")
local L = PitBull4.L

PitBull4_Background:SetModuleType("custom")
PitBull4_Background:SetName(L["Background"])
PitBull4_Background:SetDescription(L["Show a flat background for your unit frames."])
PitBull4_Background:SetDefaults({
	color = { 0, 0, 0, 0.5 }
})

-- this is here to allow it to be overridden, by say an aggro module
function PitBull4_Background:GetColor(frame)
	return unpack(PitBull4_Background:GetLayoutDB(frame).color)
end

function PitBull4_Background:UpdateFrame(frame)
	local background = frame.Background
	if not background then
		background = PitBull4.Controls.MakeTexture(frame, "BACKGROUND")
		frame.Background = background
		background:SetAllPoints(frame)
	end
	
	background:Show()
	background:SetTexture(self:GetColor(frame))
	return false
end

function PitBull4_Background:ClearFrame(frame)
	if not frame.Background then
		return false
	end
	
	frame.Background = frame.Background:Delete()
	return false
end

function PitBull4_Background:OnHide(frame)
	local background = frame.Background
	if background then
		background:Hide()
	end
end

PitBull4_Background:SetLayoutOptionsFunction(function(self)
	return 'color', {
		type = 'color',
		name = L["Color"],
		desc = L["Color that the background should be."],
		hasAlpha = true,
		get = function(info)
			return unpack(PitBull4.Options.GetLayoutDB(self).color)
		end,
		set = function(info, r, g, b, a)
			local color = PitBull4.Options.GetLayoutDB(self).color
			color[1], color[2], color[3], color[4] = r, g, b, a
			
			PitBull4.Options.UpdateFrames()
		end,
	}
end)
