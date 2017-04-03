local Postal = LibStub("AceAddon-3.0"):GetAddon("Postal")
local Postal_Express = Postal:NewModule("Express", "AceEvent-3.0", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Postal")
Postal_Express.description = L["Mouse click short cuts for mail."]
Postal_Express.description2 = L[ [[|cFFFFCC00*|r Shift-Click to take item/money from mail.
|cFFFFCC00*|r Ctrl-Click to return mail.
|cFFFFCC00*|r Alt-Click to move an item from your inventory to the current outgoing mail (same as right click in default UI).
|cFFFFCC00*|r Mousewheel to scroll the inbox.]] ]

local _G = getfenv(0)

function Postal_Express:MAIL_SHOW()
	if Postal.db.profile.Express.EnableAltClick and not self:IsHooked(GameTooltip, "OnTooltipSetItem") then
		self:HookScript(GameTooltip, "OnTooltipSetItem")
		self:RawHook("ContainerFrameItemButton_OnModifiedClick", true)
	end
	self:RegisterEvent("MAIL_CLOSED", "Reset")
	self:RegisterEvent("PLAYER_LEAVING_WORLD", "Reset")
end

function Postal_Express:Reset(event)
	if self:IsHooked(GameTooltip, "OnTooltipSetItem") then
		self:Unhook(GameTooltip, "OnTooltipSetItem")
		self:Unhook("ContainerFrameItemButton_OnModifiedClick")
	end
	self:UnregisterEvent("MAIL_CLOSED")
	self:UnregisterEvent("PLAYER_LEAVING_WORLD")
end
	
function Postal_Express:OnEnable()
	self:RawHook("InboxFrame_OnClick", true)
	self:RawHook("InboxFrame_OnModifiedClick", "InboxFrame_OnClick", true) -- Eat all modified clicks too
	self:RawHook("InboxFrameItem_OnEnter", true)

	self:RegisterEvent("MAIL_SHOW")
	if Postal.db.profile.Express.MouseWheel then
		MailFrame:EnableMouseWheel(true)
		self:HookScript(MailFrame, "OnMouseWheel")
	end
end

-- Disabling modules unregisters all events/hook automatically
--function Postal_Express:OnDisable()
--end

function Postal_Express:InboxFrameItem_OnEnter(this, motion)
	self.hooks["InboxFrameItem_OnEnter"](this, motion)
	local tooltip = GameTooltip
	
	local money, COD, _, hasItem, _, wasReturned, _, canReply = select(5, GetInboxHeaderInfo(this.index))
	if Postal.db.profile.Express.MultiItemTooltip and hasItem and hasItem > 1 then
		for i = 1, ATTACHMENTS_MAX_RECEIVE do
			local name, itemTexture, count, quality, canUse = GetInboxItem(this.index, i);
			if name then
				local itemLink = GetInboxItemLink(this.index, i);
				if count > 1 then
					tooltip:AddLine(("%sx%d"):format(itemLink, count))
				else
					tooltip:AddLine(itemLink)
				end
				tooltip:AddTexture(itemTexture)
			end
		end
	end
	if (money > 0 or hasItem) and (not COD or COD == 0) then
		tooltip:AddLine(L["|cffeda55fShift-Click|r to take the contents."])
	end
	if not wasReturned and canReply then
		tooltip:AddLine(L["|cffeda55fCtrl-Click|r to return it to sender."])
	end
	tooltip:Show()
end

function Postal_Express:InboxFrame_OnClick(button, index)
	if IsShiftKeyDown() then
		local cod = select(6, GetInboxHeaderInfo(index))
		if cod <= 0 then
			AutoLootMailItem(index)
		end
		--button:SetChecked(not button:GetChecked())
	elseif IsControlKeyDown() then
		local wasReturned, _, canReply = select(10, GetInboxHeaderInfo(index))
		if not wasReturned and canReply then
			ReturnInboxItem(index)
		end
	else
		return self.hooks["InboxFrame_OnClick"](button, index)
	end
end

function Postal_Express:OnTooltipSetItem(tooltip, ...)
	local recipient = SendMailNameEditBox:GetText()
	if Postal.db.profile.Express.AutoSend and recipient ~= "" and SendMailFrame:IsVisible() and not CursorHasItem() then
		tooltip:AddLine(string.format(L["|cffeda55fAlt-Click|r to send this item to %s."], recipient))
	end
end

function Postal_Express:ContainerFrameItemButton_OnModifiedClick(this, button, ...)
	if button == "LeftButton" and IsAltKeyDown() and SendMailFrame:IsVisible() and not CursorHasItem() then
		local bag, slot = this:GetParent():GetID(), this:GetID()
		local texture, count = GetContainerItemInfo(bag, slot)
		PickupContainerItem(bag, slot)
		ClickSendMailItemButton()
		if Postal.db.profile.Express.AutoSend then
			for i = 1, ATTACHMENTS_MAX_SEND do
				-- get info about the attachment
				local itemName, itemTexture, stackCount, quality = GetSendMailItem(i)
				if SendMailNameEditBox:GetText() ~= "" and texture == itemTexture and count == stackCount then
					SendMailFrame_SendMail()
				end
			end
		end
	else
		return self.hooks["ContainerFrameItemButton_OnModifiedClick"](this, button, ...)
	end
end

function Postal_Express:OnMouseWheel(frame, direction)
	if direction == -1 then
		if math.ceil(GetInboxNumItems() / 7) > InboxFrame.pageNum then
			InboxNextPage()
		end
	elseif InboxFrame.pageNum ~= 1 then
		InboxPrevPage()
	end
end

function Postal_Express.SetEnableAltClick(dropdownbutton, arg1, arg2, checked)
	local self = Postal_Express
	Postal.db.profile.Express.EnableAltClick = checked
	if checked then
		if MailFrame:IsVisible() and not self:IsHooked(GameTooltip, "OnTooltipSetItem") then
			self:HookScript(GameTooltip, "OnTooltipSetItem")
			self:RawHook("ContainerFrameItemButton_OnModifiedClick", true)
		end
	else
		if self:IsHooked(GameTooltip, "OnTooltipSetItem") then
			self:Unhook(GameTooltip, "OnTooltipSetItem")
			self:Unhook("ContainerFrameItemButton_OnModifiedClick")
		end
	end
	-- A hack to get the next button to disable/enable
	local i, j = string.match(dropdownbutton:GetName(), "DropDownList(%d+)Button(%d+)")
	j = tonumber(j) + 1
	if checked then
		_G["DropDownList"..i.."Button"..j]:Enable()
		_G["DropDownList"..i.."Button"..j.."InvisibleButton"]:Hide()
	else
		_G["DropDownList"..i.."Button"..j]:Disable()
		_G["DropDownList"..i.."Button"..j.."InvisibleButton"]:Show()
	end
end

function Postal_Express.SetAutoSend(dropdownbutton, arg1, arg2, checked)
	Postal.db.profile.Express.AutoSend = checked
end

function Postal_Express.SetMouseWheel(dropdownbutton, arg1, arg2, checked)
	local self = Postal_Express
	Postal.db.profile.Express.MouseWheel = checked
	if checked then
		if not self:IsHooked(MailFrame, "OnMouseWheel") then
			MailFrame:EnableMouseWheel(true)
			self:HookScript(MailFrame, "OnMouseWheel")
		end
	else
		if self:IsHooked(MailFrame, "OnMouseWheel") then
			self:Unhook(MailFrame, "OnMouseWheel")
		end
	end
end

function Postal_Express.ModuleMenu(self, level)
	if not level then return end
	local info = self.info
	wipe(info)
	info.isNotRadio = 1
	if level == 1 + self.levelAdjust then
		local db = Postal.db.profile.Express
		info.keepShownOnClick = 1

		info.text = L["Enable Alt-Click to send mail"]
		info.func = Postal_Express.SetEnableAltClick
		info.checked = db.EnableAltClick
		UIDropDownMenu_AddButton(info, level)

		info.text = L["Auto-Send on Alt-Click"]
		info.func = Postal_Express.SetAutoSend
		info.checked = db.AutoSend
		info.disabled = not Postal.db.profile.Express.EnableAltClick
		UIDropDownMenu_AddButton(info, level)

		info.text = L["Mousewheel to scroll Inbox"]
		info.func = Postal_Express.SetMouseWheel
		info.checked = db.MouseWheel
		info.disabled = nil
		UIDropDownMenu_AddButton(info, level)

		info.text = L["Add multiple item mail tooltips"]
		info.func = Postal.SaveOption
		info.checked = db.MultiItemTooltip
		info.arg1 = "Express"
		info.arg2 = "MultiItemTooltip"
		info.disabled = nil
		UIDropDownMenu_AddButton(info, level)
	end
end
