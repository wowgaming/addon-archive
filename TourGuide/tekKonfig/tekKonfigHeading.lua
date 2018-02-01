
local lib, oldminor = LibStub:NewLibrary("tekKonfig-Heading", 1)
if not lib then return end


-- Creates a heading and subheading
-- parent is required, texts are optional
function lib.new(parent, text, subtext)
	local title = parent:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(text)

	local subtitle = parent:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	subtitle:SetHeight(32)
	subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	subtitle:SetPoint("RIGHT", parent, -32, 0)
--~ 	nonSpaceWrap="true" maxLines="3"
	subtitle:SetNonSpaceWrap(true)
	subtitle:SetJustifyH("LEFT")
	subtitle:SetJustifyV("TOP")
	subtitle:SetText(subtext)

	return title, subtitle
end
