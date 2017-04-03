-- Widget is based on the AceGUIWidget-DropDown.lua supplied with AceGUI-3.0
-- Widget created by Yssaril

local AceGUI = LibStub("AceGUI-3.0")
local Media = LibStub("LibSharedMedia-3.0")

do
	local min, max, floor = math.min, math.max, math.floor
	local fixlevels = AceGUISharedMediaWidgets.fixlevels
	local OnItemValueChanged = AceGUISharedMediaWidgets.OnItemValueChanged

	do
		local widgetType = "LSM30_Sound_Item_Select"
		local widgetVersion = 1

		local function Frame_OnEnter(this)
			local self = this.obj

			if self.useHighlight then
				self.highlight:Show()
			end
			self:Fire("OnEnter")

			if self.specialOnEnter then
				self.specialOnEnter(self)
			end
		end

		local function Frame_OnLeave(this)
			local self = this.obj

			self.highlight:Hide()
			self:Fire("OnLeave")

			if self.specialOnLeave then
				self.specialOnLeave(self)
			end
		end

		local function OnAcquire(self)
			self.frame:SetToplevel(true)
			self.frame:SetFrameStrata("FULLSCREEN_DIALOG")
		end

		local function OnRelease(self)
			self.pullout = nil
			self.frame:SetParent(nil)
			self.frame:ClearAllPoints()
			self.frame:Hide()
		end

		local function SetPullout(self, pullout)
			self.pullout = pullout

			self.frame:SetParent(nil)
			self.frame:SetParent(pullout.itemFrame)
			self.parent = pullout.itemFrame
			fixlevels(pullout.itemFrame, pullout.itemFrame:GetChildren())
		end

		local function SetText(self, text)
			self.sound = text or ''
			self.text:SetText(text or "")
		end

		local function GetText(self)
			return self.text:GetText()
		end

		local function SetPoint(self, ...)
			self.frame:SetPoint(...)
		end

		local function Show(self)
			self.frame:Show()
		end

		local function Hide(self)
			self.frame:Hide()
		end

		local function SetDisabled(self, disabled)
			self.disabled = disabled
			if disabled then
				self.useHighlight = false
				self.text:SetTextColor(.5, .5, .5)
			else
				self.useHighlight = true
				self.text:SetTextColor(1, 1, 1)
			end
		end

		local function SetOnLeave(self, func)
			self.specialOnLeave = func
		end

		local function SetOnEnter(self, func)
			self.specialOnEnter = func
		end

		local function UpdateToggle(self)
			if self.value then
				self.check:Show()
			else
				self.check:Hide()
			end
		end

		local function Frame_OnClick(this, button)
			local self = this.obj
			self.value = not self.value
			UpdateToggle(self)
			self:Fire("OnValueChanged", self.value)
		end

		local function Speaker_OnClick(this, button)
			local self = this.obj
			PlaySoundFile(Media:Fetch('sound',self.sound))
		end

		local function SetValue(self, value)
			self.value = value
			UpdateToggle(self)
		end

		local function Constructor()
			local count = AceGUI:GetNextWidgetNum(type)
			local frame = CreateFrame("Frame", "LSM30_Sound_DropDownItem"..count)
			local self = {}
			self.frame = frame
			frame.obj = self
			self.type = type

			self.useHighlight = true

			frame:SetHeight(17)
			frame:SetFrameStrata("FULLSCREEN_DIALOG")

			local button = CreateFrame("Button", nil, frame)
			button:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",-22,0)
			button:SetPoint("TOPLEFT",frame,"TOPLEFT",0,0)
			self.button = button
			button.obj = self

			local speakerbutton = CreateFrame("Button", nil, frame)
			speakerbutton:SetWidth(16)
			speakerbutton:SetHeight(16)
			speakerbutton:SetPoint("RIGHT",frame,"RIGHT",-6,0)
			self.speakerbutton = speakerbutton
			speakerbutton.obj = self

			local speaker = frame:CreateTexture(nil, "BACKGROUND")
			speaker:SetTexture("Interface\\Common\\VoiceChat-Speaker")
			speaker:SetAllPoints(speakerbutton)
			self.speaker = speaker

			local speakeron = speakerbutton:CreateTexture(nil, "HIGHLIGHT")
			speakeron:SetTexture("Interface\\Common\\VoiceChat-On")
			speakeron:SetAllPoints(speakerbutton)
			self.speakeron = speakeron

			local text = frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
			text:SetTextColor(1,1,1)
			text:SetJustifyH("LEFT")
			text:SetPoint("TOPLEFT",frame,"TOPLEFT",18,0)
			text:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",-24,0)
			self.text = text

			local highlight = button:CreateTexture(nil, "OVERLAY")
			highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
			highlight:SetBlendMode("ADD")
			highlight:SetHeight(14)
			highlight:ClearAllPoints()
			highlight:SetPoint("RIGHT",frame,"RIGHT",-19,0)
			highlight:SetPoint("LEFT",frame,"LEFT",5,0)
			highlight:Hide()
			self.highlight = highlight

			local check = frame:CreateTexture("OVERLAY")
			check:SetWidth(16)
			check:SetHeight(16)
			check:SetPoint("LEFT",frame,"LEFT",3,-1)
			check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
			check:Hide()
			self.check = check

			local sub = frame:CreateTexture("OVERLAY")
			sub:SetWidth(16)
			sub:SetHeight(16)
			sub:SetPoint("RIGHT",frame,"RIGHT",-3,-1)
			sub:SetTexture("Interface\\ChatFrame\\ChatFrameExpandArrow")
			sub:Hide()
			self.sub = sub

			button:SetScript("OnEnter", Frame_OnEnter)
			button:SetScript("OnLeave", Frame_OnLeave)

			self.OnAcquire = OnAcquire
			self.OnRelease = OnRelease

			self.SetPullout = SetPullout
			self.GetText	= GetText
			self.SetText	= SetText
			self.SetDisabled = SetDisabled

			self.SetPoint   = SetPoint
			self.Show	   = Show
			self.Hide	   = Hide

			self.SetOnLeave = SetOnLeave
			self.SetOnEnter = SetOnEnter

			self.button:SetScript("OnClick", Frame_OnClick)
			self.speakerbutton:SetScript("OnClick", Speaker_OnClick)

			self.SetValue = SetValue

			AceGUI:RegisterAsWidget(self)
			return self
		end
		AceGUI:RegisterWidgetType(widgetType, Constructor, widgetVersion)
	end

	do
		local widgetType = "LSM30_Sound"
		local widgetVersion = 3

		local function AddListItem(self, value, text)
			local item = AceGUI:Create("LSM30_Sound_Item_Select")
			item:SetText(text)
			item.userdata.obj = self
			item.userdata.value = value
			item:SetCallback("OnValueChanged", OnItemValueChanged)
			self.pullout:AddItem(item)
		end

		local function SetList(self, list)
			self.list = list or Media:HashTable("sound")
			self.pullout:Clear()
			if self.multiselect then
				AddCloseButton()
			end
		end

		local sortlist = {}
		local function ParseListItems(self)
			for v in pairs(self.list) do
				sortlist[#sortlist + 1] = v
			end
			table.sort(sortlist)
			for i, value in pairs(sortlist) do
				AddListItem(self, value, value)
				sortlist[i] = nil
			end
		end

		local function Constructor()
			local self = AceGUI:Create("Dropdown")
			self.type = widgetType
			self.SetList = SetList
			self.SetValue = AceGUISharedMediaWidgets.SetValue

			local clickscript = self.button:GetScript("OnClick")
			self.button:SetScript("OnClick", function(...)
				self.pullout:Clear()
				ParseListItems(self)
				clickscript(...)
			end)

			return self
		end
		AceGUI:RegisterWidgetType(widgetType, Constructor, widgetVersion)
	end
end
