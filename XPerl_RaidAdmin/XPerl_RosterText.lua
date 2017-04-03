-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

XPerl_SetModuleRevision("$Revision: 176 $")

-- onEvent
local function onEvent(self, event, a, b, c)
	self[event](self, a, b, c)
end

-- doUpdate
local function Update(self)

	local myZone = GetRealZoneText()
	local list = {}

	for unitid, unitName, unitClass, group, zone, online, dead in XPerl_NextMember do
		if (self.group[group]) then
			if (not self.sameZone or (zone == myZone)) then
				tinsert(list, {["group"] = group, name = unitName})
			end
		end
	end

	if (self.sortAlpha) then
		sort(list, function(a,b) return a.name < b.name end)
	else
		sort(list, function(a,b) return a.group..a.name < b.group..b.name end)
	end

	local text = ""
	local totals = 0
	for k,v in pairs(list) do
		text = text..v.name.."\r"
		totals = totals + 1
	end

	self.text = text
	self.textFrame.scroll.text:SetText(text)
	self.textFrame.scroll.text:HighlightText()
	--if (self.textFrame.scroll.text.SetCursorPosition) then
	--	self.textFrame.scroll.text:SetCursorPosition(1)			-- WoW 2.3
	--end
	self.textFrame.scroll.text:SetFocus()

	self.totals:SetFormattedText(XPERL_ROSTERTEXT_TOTAL, totals)
end

-- XPerl_RosterText_Init
function XPerl_RosterText_Init(self)

	XPerl_SetChildMembers(self)

	self:SetBackdropColor(0, 0, 0, 0.7)
	self:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
	self:RegisterForDrag("LeftButton")

	if (XPerl_SavePosition) then
		XPerl_SavePosition(XPerl_RosterTextAnchor, true)
	end

	XPerl_RegisterScalableFrame(self, XPerl_RosterTextAnchor)

	self.group = {1, 1, 1, 1, 1, nil, nil, nil}
	self.sameZone = nil

	self:SetScript("OnEvent", onEvent)
	self.Update = Update

	self.RAID_ROSTER_UPDATE = Update
	self.PLAYER_ENTERING_WORLD = Update

	self:SetScript("OnShow", function(self)
		self:RegisterEvent("RAID_ROSTER_UPDATE")
		self:RegisterEvent("PLAYER_ENTERING_WORLD")
		Update(self)
	end)
	self:SetScript("OnHide", function(self)
		XPerl_RosterText.text = nil
		self.textFrame.scroll.text:SetText("")
		self:UnregisterAllEvents()
	end)

	self:SetScript("OnLoad", nil)
	XPerl_RosterText_Init = nil
end
