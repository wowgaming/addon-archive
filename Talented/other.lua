local L = LibStub("AceLocale-3.0"):GetLocale("Talented")
local Talented = Talented

local function ShowDialog(sender, name, code)
	StaticPopupDialogs.TALENTED_CONFIRM_SHARE_TEMPLATE = {
		button1 = YES,
		button2 = NO,
		text = L["Do you want to add the template \"%s\" that %s sent you ?"],
		OnAccept = function(self)
			local res, value, class = pcall(Talented.StringToTemplate, Talented, self.code)
			if res then
				Talented:ImportFromOther(self.name, {
					code = self.code,
					class = class
				})
			else
				Talented:Print("Invalid template", value)
			end
		end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		interruptCinematic = 1
	}
	ShowDialog = function (sender, name, code)
		local dlg = StaticPopup_Show("TALENTED_CONFIRM_SHARE_TEMPLATE", name, sender)
		dlg.name = name
		dlg.code = code
	end
	return ShowDialog(sender, name, code)
end

function Talented:OnCommReceived(prefix, message, distribution, sender)
	local status, name, code = self:Deserialize(message)
	if not status then return end

	ShowDialog(sender, name, code)
end

function Talented:ExportTemplateToUser(name)
	local message = self:Serialize(self.template.name, self:TemplateToString(self.template))
	self:SendCommMessage("Talented", message, "WHISPER", name)
end
