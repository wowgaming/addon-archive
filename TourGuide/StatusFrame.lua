
local bg = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	edgeSize = 16,
	insets = {left = 5, right = 5, top = 5, bottom = 5},
	tile = true, tileSize = 16,
}

local ICONSIZE, CHECKSIZE, GAP = 16, 16, 8
local FIXEDWIDTH = ICONSIZE + CHECKSIZE + GAP*4 - 4

local TourGuide = TourGuide
local ww = WidgetWarlock
local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local dataobj = ldb:GetDataObjectByName("TourGuide")


local function GetQuadrant(frame)
	local x,y = frame:GetCenter()
	if not x or not y then return "BOTTOMLEFT", "BOTTOM", "LEFT" end
	local hhalf = (x > UIParent:GetWidth()/2) and "RIGHT" or "LEFT"
	local vhalf = (y > UIParent:GetHeight()/2) and "TOP" or "BOTTOM"
	return vhalf..hhalf, vhalf, hhalf
end


local f = CreateFrame("Button", nil, UIParent)
TourGuide.statusframe = f
f:SetHeight(24)
f:SetFrameStrata("LOW")
f:EnableMouse(true)
f:RegisterForClicks("anyUp")
f:SetBackdrop(bg)
f:SetBackdropColor(0.09, 0.09, 0.19, 0.5)
f:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.5)

local check = ww.SummonCheckBox(CHECKSIZE, f, "LEFT", GAP, 0)
local icon = ww.SummonTexture(f, "ARTWORK", ICONSIZE, ICONSIZE, nil, "LEFT", check, "RIGHT", GAP-4, 0)
local text = ww.SummonFontString(f, "OVERLAY", "GameFontNormalSmall", nil, "RIGHT", -GAP-4, 0)
text:SetPoint("LEFT", icon, "RIGHT", GAP-4, 0)


local f2 = CreateFrame("Frame", nil, f)
local f2anchor = "RIGHT"
f2:SetHeight(32)
f2:SetWidth(100)
local text2 = ww.SummonFontString(f2, "OVERLAY", "GameFontNormalSmall", nil, "RIGHT", -GAP-4, 0)
local icon2 = ww.SummonTexture(f2, "ARTWORK", ICONSIZE, ICONSIZE, nil, "RIGHT", text2, "LEFT", -GAP+4, 0)
local check2 = ww.SummonCheckBox(CHECKSIZE, f2, "RIGHT", icon2, "LEFT", -GAP+4, 0)
check2:SetChecked(true)
f2:Hide()


local elapsed, oldsize, newsize
f2:SetScript("OnUpdate", function(self, el)
	elapsed = elapsed + el
	if elapsed > 1 then
		self:Hide()
		icon:SetAlpha(1)
		text:SetAlpha(1)
		f:SetWidth(newsize)
	else
		self:SetPoint(f2anchor, f, f2anchor, 0, elapsed*40)
		self:SetAlpha(1 - elapsed)
		text:SetAlpha(elapsed)
		icon:SetAlpha(elapsed)
		f:SetWidth(oldsize + (newsize-oldsize)*elapsed)
	end
end)


function TourGuide:PositionStatusFrame()
	f:ClearAllPoints()
	if self.db.profile.statusframepoint then
		f:SetPoint(self.db.profile.statusframepoint, self.db.profile.statusframex, self.db.profile.statusframey)
	else
		f:SetPoint("BOTTOMRIGHT", MinimapCluster, -160, 15)
	end

	if self.db.char.showstatusframe then f:Show() else f:Hide() end
end


ldb.RegisterCallback(TourGuide, "LibDataBroker_AttributeChanged_TourGuide_text", function(event, name, attr, value, dataobj)
	oldsize = f:GetWidth()
	icon:SetAlpha(0)
	text:SetAlpha(0)
	elapsed = 0
	f2:SetWidth(f:GetWidth())
	f2anchor = select(3, GetQuadrant(f))
	f2:ClearAllPoints()
	f2:SetPoint(f2anchor, f, f2anchor, 0, 0)
	f2:SetAlpha(1)
	text2:SetText(text:GetText())

	text:SetText(value)
	check:SetChecked(false)
	check:SetButtonState("NORMAL")
	if TourGuide.db.char.currentguide == "No Guide" then check:Disable() else check:Enable() end
	if i == 1 then f:SetWidth(FIXEDWIDTH + text:GetWidth()) end
	newsize = FIXEDWIDTH + text:GetWidth()

	f2:Show()
end)


ldb.RegisterCallback(TourGuide, "LibDataBroker_AttributeChanged_TourGuide_icon", function(event, name, attr, value, dataobj)
	local oldtexture = icon:GetTexture()
	icon2:SetTexture(oldtexture)
	if oldtexture and oldtexture:match("Interface\\Icons") then icon2:SetTexCoord(4/48, 44/48, 4/48, 44/48) else icon2:SetTexCoord(0,1,0,1) end

	icon:SetTexture(value)
	if value and value:match("Interface\\Icons") then icon:SetTexCoord(4/48, 44/48, 4/48, 44/48) else icon:SetTexCoord(0,1,0,1) end
end)


f:SetScript("OnClick", dataobj.OnClick)
f:SetScript("OnLeave", dataobj.OnLeave)
f:SetScript("OnEnter", dataobj.OnEnter)
check:SetScript("OnClick", function(self, btn) TourGuide:SetTurnedIn() end)


local function OnUpdate(self)
	local oldnewsize = newsize
	newsize = FIXEDWIDTH + text:GetWidth()
	if oldnewsize ~= newsize and not f2:IsVisible() then
		oldsize = newsize
		self:SetWidth(newsize)
	end
	self:SetScript("OnUpdate", nil)
end
f:SetScript("OnEvent", function(self) self:SetScript("OnUpdate", OnUpdate) end)
f:RegisterEvent("ADDON_LOADED") -- Force resize in case of font changes


function TourGuide.GetUIParentAnchor(frame)
	local w, h, x, y = UIParent:GetWidth(), UIParent:GetHeight(), frame:GetCenter()
	local hhalf, vhalf = (x > w/2) and "RIGHT" or "LEFT", (y > h/2) and "TOP" or "BOTTOM"
	local dx = hhalf == "RIGHT" and math.floor(frame:GetRight() + 0.5) - w or math.floor(frame:GetLeft() + 0.5)
	local dy = vhalf == "TOP" and math.floor(frame:GetTop() + 0.5) - h or math.floor(frame:GetBottom() + 0.5)

	return vhalf..hhalf, dx, dy
end


f:RegisterForDrag("LeftButton")
f:SetMovable(true)
f:SetClampedToScreen(true)
f:SetScript("OnDragStart", function(frame)
	if TourGuide.objectiveframe:IsVisible() then HideUIPanel(TourGuide.objectiveframe) end
	dataobj.OnLeave(frame)
	frame:StartMoving()
end)
f:SetScript("OnDragStop", function(frame)
	frame:StopMovingOrSizing()
	TourGuide.db.profile.statusframepoint, TourGuide.db.profile.statusframex, TourGuide.db.profile.statusframey = TourGuide.GetUIParentAnchor(frame)
	TourGuide:Debug(1, "Status frame moved", TourGuide.db.profile.statusframepoint, TourGuide.db.profile.statusframex, TourGuide.db.profile.statusframey)
	frame:ClearAllPoints()
	frame:SetPoint(TourGuide.db.profile.statusframepoint, TourGuide.db.profile.statusframex, TourGuide.db.profile.statusframey)
	dataobj.OnEnter(frame)
end)
