local ipairs = ipairs
local Talented = Talented
local format = string.format

local L = LibStub("AceLocale-3.0"):GetLocale("Talented")

function Talented:WriteToChat(text, ...)
	if text:find("%", 1, true) then text = text:format(...) end
	local edit = ChatEdit_GetLastActiveWindow and ChatEdit_GetLastActiveWindow() or DEFAULT_CHAT_FRAME.editBox
	local type = edit:GetAttribute("chatType")
	local lang = edit.language
	if type == "WHISPER" then
		local target = edit:GetAttribute("tellTarget")
		SendChatMessage(text, type, lang, target)
	elseif type == "CHANNEL" then
		local channel = edit:GetAttribute("channelTarget")
		SendChatMessage(text, type, lang, channel)
	else
		SendChatMessage(text, type, lang)
	end
end

local function GetDialog()
	StaticPopupDialogs.TALENTED_SHOW_DIALOG = {
		text = L["URL:"],
		button1 = OKAY,
		hasEditBox = 1,
		hasWideEditBox = 1,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = 1,
		OnShow = function (self)
			self.button1:SetPoint("TOP", self.editBox, "BOTTOM", 0, -8)
		end,
	}
	GetDialog = function () return StaticPopup_Show"TALENTED_SHOW_DIALOG" end
	return GetDialog()
end

function Talented:ShowInDialog(text, ...)
	if text:find("%", 1, true) then text = text:format(...) end
	local edit = GetDialog().wideEditBox
	edit:SetText(text)
	edit:HighlightText()
end
