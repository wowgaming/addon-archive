

local TourGuide = TourGuide
local L = TourGuide.Locale
local NUMROWS, ROWHEIGHT, GAP, EDGEGAP = 18, 17, 8, 16
local offset, rows = 0, {}


local frame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
TourGuide.guidespanel = frame
frame.name = L["Guides"]
frame.parent = "Tour Guide"
frame:Hide()
frame:SetScript("OnShow", function()
	local title, subtitle = LibStub("tekKonfig-Heading").new(frame, L["Tour Guide - Guides"], L["This panel lets you choose a guide to load.  Upon completion the next guide will load automatically.  Completed guides can be reset by shift-clicking."])

	local group = LibStub("tekKonfig-Group").new(frame, nil, "TOP", subtitle, "BOTTOM", 0, -EDGEGAP-GAP)
	group:SetPoint("LEFT", EDGEGAP, 0)
	group:SetPoint("BOTTOMRIGHT", -EDGEGAP, EDGEGAP)

	local scrollbar = LibStub("tekKonfig-Scroll").new(group, 6, NUMROWS/3)

	local function OnClick(self)
		if IsShiftKeyDown() then
			TourGuide.db.char.completion[self.guide] = nil
			TourGuide.db.char.turnins[self.guide] = {}
			TourGuide:UpdateGuidesPanel()
			GameTooltip:Hide()
		else
			local text = self.guide
			if not text then self:SetChecked(false)
			else
				TourGuide:LoadGuide(text)
				TourGuide:UpdateStatusFrame()
				TourGuide:UpdateGuidesPanel()
			end
		end
	end
	rows = {}
	for i=1,NUMROWS do
		local row = CreateFrame("CheckButton", nil, group)
		if i == 1 then row:SetPoint("TOP", 0, -4)
		else row:SetPoint("TOP", rows[i-1], "BOTTOM") end
		row:SetPoint("LEFT", 4, 0)
		row:SetPoint("RIGHT", scrollbar, "LEFT", -4, 0)
		row:SetHeight(ROWHEIGHT)

		local highlight = row:CreateTexture()
		highlight:SetTexture("Interface\\HelpFrame\\HelpFrameButton-Highlight")
		highlight:SetTexCoord(0, 1, 0, 0.578125)
		highlight:SetAllPoints()
		row:SetHighlightTexture(highlight)
		row:SetCheckedTexture(highlight)

		local text = row:CreateFontString(nil, nil, "GameFontWhite")
		text:SetPoint("LEFT", GAP, 0)
		local complete = row:CreateFontString(nil, nil, "GameFontWhite")
		complete:SetPoint("RIGHT", -GAP, 0)

		row:SetScript("OnClick", OnClick)

		row.text = text
		row.complete = complete
		rows[i] = row
	end


	local f = scrollbar:GetScript("OnValueChanged")
	scrollbar:SetMinMaxValues(0, math.max(0, #TourGuide.guidelist - NUMROWS - 1))
	scrollbar:SetScript("OnValueChanged", function(self, value, ...)
		offset = math.floor(value)
		TourGuide:UpdateGuidesPanel()
		return f(self, value, ...)
	end)

	frame:EnableMouseWheel()
	frame:SetScript("OnMouseWheel", function(self, val) scrollbar:SetValue(scrollbar:GetValue() - val*NUMROWS/3) end)

	local function newoffset() for i,name in ipairs(TourGuide.guidelist) do if name == TourGuide.db.char.currentguide then return i - (NUMROWS/2) - 1 end end end
	local function OnShow(self) scrollbar:SetValue(newoffset() or 0) end
	frame:SetScript("OnShow", OnShow)
	OnShow(frame)
end)


function TourGuide:UpdateGuidesPanel()
	if not frame:IsVisible() then return end
	for i,row in ipairs(rows) do
		row.i = i + offset + 1

		local name = self.guidelist[i + offset + 1]
		row.text:SetText(name)
		row.guide = name
		row:SetChecked(self.db.char.currentguide == name)

		local complete = self.db.char.currentguide == name and (self.current-1)/#self.actions or self.db.char.completion[name]
		local r,g,b = self.ColorGradient(complete or 0)
		local completetext = complete and complete ~= 0 and string.format(L["|cff%02x%02x%02x%d%% complete"], r*255, g*255, b*255, complete*100)
		row.complete:SetText(completetext)
	end
end

InterfaceOptions_AddCategory(frame)
