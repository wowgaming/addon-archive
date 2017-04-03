local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local templates = addon.templates


local module = templates:CreateList("CritlineAnnounce", L["Announce"])

do
	local button = module.button
	button:SetScript("OnClick", function()
		PlaySound("gsTitleOptionOK")
		module:AnnounceRecords()
	end)

	local function onClick(self)
		self.owner:SetSelectedValue(self.value)
		local target = module.target
		if self.value == "WHISPER" or self.value == "CHANNEL" then
			target:Show()
			target:SetFocus()
		else
			target:Hide()
		end
	end

	local channels = {
		"SAY",
		"GUILD",
		"PARTY",
		"RAID",
		"WHISPER",
		"CHANNEL",
	}
	
	local function initialize(self)
		for i, v in ipairs(channels) do
			local info = UIDropDownMenu_CreateInfo()
			info.text = _G[v]
			info.value = v
			info.func = onClick
			info.owner = self
			UIDropDownMenu_AddButton(info)
		end
	end

	local channel = templates:CreateDropDownMenu("CritlineAnnounceChannel", module, nil, initialize, _G)
	channel:SetFrameWidth(120)
	channel:SetPoint("TOPLEFT", module.tree, "BOTTOMLEFT")
	channel:SetSelectedValue("SAY")
	module.channel = channel

	local target = templates:CreateEditBox(module)
	target:SetAutoFocus(false)
	target:SetWidth(144)
	target:SetPoint("LEFT", channel, "RIGHT", 0, 2)
	target:SetScript("OnEscapePressed", target.ClearFocus)
	target:SetScript("OnEnterPressed", function(self) module:AnnounceRecords(self:GetText():trim()) end)
	target:Hide()
	module.target = target
end


addon.RegisterCallback(module, "SpellsChanged", "Update")


function module:AnnounceRecords(target)
	local channel = self.channel:GetSelectedValue()
	local tree = self.tree:GetSelectedValue()
	local spells = addon.percharDB.profile.spells[tree]
	
	if channel == "WHISPER" then
		if target == "" then
			addon:Message(L["Invalid player name."])
			return
		end
	elseif channel == "CHANNEL" then
		target = GetChannelName(target)
		if target == 0 then
			addon:Message(L["Invalid channel. Please enter a valid channel name or ID."])
			return
		end
	end
	
	local sent
	
	for i in pairs(self.selectedSpells) do
		local data = spells[i]
		local normal = data.normal and data.normal.amount
		local crit = data.crit and data.crit.amount
		local text = format("%s - %s: %s %s: %s", addon:GetFullSpellName(tree, data.spellName, data.isPeriodic), L["Normal"], (normal or "n/a"), L["Crit"], (crit or "n/a"))
		SendChatMessage(text, channel, nil, target)
		sent = true
	end
	
	if sent then
		wipe(self.selectedSpells)
		self:Update()
		self.button:Disable()
		self.target:SetText("")
	end
end