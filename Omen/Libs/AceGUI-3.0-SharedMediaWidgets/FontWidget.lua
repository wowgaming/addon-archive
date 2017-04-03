-- Widget is based on the AceGUIWidget-DropDown.lua supplied with AceGUI-3.0
-- Widget created by Yssaril

local AceGUI = LibStub("AceGUI-3.0")
local Media = LibStub("LibSharedMedia-3.0")

do
	local min, max, floor = math.min, math.max, math.floor
	local fixlevels = AceGUISharedMediaWidgets.fixlevels
	local OnItemValueChanged = AceGUISharedMediaWidgets.OnItemValueChanged

	do
		local widgetType = "LSM30_Font_Item_Select"
		local widgetVersion = 1

		local function SetText(self, text)
			if text and text ~= '' then
				local _, size, outline= self.text:GetFont()
				self.text:SetFont(Media:Fetch('font',text),size,outline)
			end
			self.text:SetText(text or "")
		end

		local function Constructor()
			local self = AceGUI:Create("Dropdown-Item-Toggle")
			self.type = widgetType
			self.SetText = SetText
			return self
		end

		AceGUI:RegisterWidgetType(widgetType, Constructor, widgetVersion)
	end

	do
		local widgetType = "LSM30_Font"
		local widgetVersion = 3

		local function SetText(self, text)
			if text and text ~= '' then
				local _, size, outline= self.text:GetFont()
				self.text:SetFont(Media:Fetch('font',text),size,outline)
			end
			self.text:SetText(text or "")
		end

		local function AddListItem(self, value, text)
			local item = AceGUI:Create("LSM30_Font_Item_Select")
			item:SetText(text)
			item.userdata.obj = self
			item.userdata.value = value
			item:SetCallback("OnValueChanged", OnItemValueChanged)
			self.pullout:AddItem(item)
		end

		local function SetList(self, list)
			self.list = list or Media:HashTable("font")
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
			self.SetText = SetText
			self.SetValue = AceGUISharedMediaWidgets.SetValue
			self.SetList = SetList

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
