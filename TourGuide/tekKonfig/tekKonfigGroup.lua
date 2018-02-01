
local lib, oldminor = LibStub:NewLibrary("tekKonfig-Group", 2)
if not lib then return end

lib.bg = {
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true,
	tileSize = 16,
	edgeSize = 16,
	insets = { left = 5, right = 5, top = 5, bottom = 5 }
}


-- Creates a background box to place behind widgets for visual grouping.
-- All args optional, parent highly recommended
function lib.new(parent, label, ...)
	local box = CreateFrame('Frame', nil, parent)
	box:SetBackdrop(lib.bg)
	box:SetBackdropBorderColor(0.4, 0.4, 0.4)
	box:SetBackdropColor(0.1, 0.1, 0.1)
	if select('#',...) > 0 then box:SetPoint(...) end

	if label then
		local fs = box:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
		fs:SetPoint("BOTTOMLEFT", box, "TOPLEFT", 16, 0)
		fs:SetText(label)
	end

	return box
end
