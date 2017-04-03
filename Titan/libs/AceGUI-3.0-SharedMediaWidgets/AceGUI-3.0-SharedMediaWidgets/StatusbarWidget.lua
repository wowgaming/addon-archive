-- Widget is based on the AceGUIWidget-DropDown.lua supplied with AceGUI-3.0
-- Widget created by Yssaril

local AceGUI = LibStub("AceGUI-3.0")
local Media = LibStub("LibSharedMedia-3.0")

do
	local min, max, floor = math.min, math.max, math.floor
	local fixlevels = AceGUISharedMediaWidgets.fixlevels
	local OnItemValueChanged = AceGUISharedMediaWidgets.OnItemValueChanged

	do
		local widgetType = "LSM30_Statusbar_Item_Select"
		local widgetVersion = 1

		local function SetText(self, text)
			if text and text ~= '' then
				self.texture:SetTexture(Media:Fetch('statusbar',text))
				self.texture:SetVertexColor(.5,.5,.5)
			end
			self.text:SetText(text or "")
		end

		local function Constructor()
			local self = AceGUI:Create("Dropdown-Item-Toggle")
			self.type = widgetType
			self.SetText = SetText
			local texture = self.frame:CreateTexture(nil, "BACKGROUND")
			texture:SetTexture(0,0,0,0)
			texture:SetPoint("BOTTOMRIGHT",self.frame,"BOTTOMRIGHT",-4,1)
			texture:SetPoint("TOPLEFT",self.frame,"TOPLEFT",6,-1)
			self.texture = texture
			return self
		end
		AceGUI:RegisterWidgetType(widgetType, Constructor, widgetVersion)
	end

	do
		local widgetType = "LSM30_Statusbar"
		local widgetVersion = 4

		local function SetText(self, text)
			if text and text ~= '' then
				self.texture:SetTexture(Media:Fetch('statusbar',text))
				self.texture:SetVertexColor(.5,.5,.5)
			end
			self.text:SetText(text or "")
		end

		local function AddListItem(self, value, text)
			local item = AceGUI:Create("LSM30_Statusbar_Item_Select")
			item:SetText(text)
			item.userdata.obj = self
			item.userdata.value = value
			item:SetCallback("OnValueChanged", OnItemValueChanged)
			self.pullout:AddItem(item)
		end

		local function SetList(self, list)
			self.list = list or Media:HashTable("statusbar")
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
			self.SetList = SetList
			self.SetValue = AceGUISharedMediaWidgets.SetValue

			local left = _G[self.dropdown:GetName() .. "Left"]
			local middle = _G[self.dropdown:GetName() .. "Middle"]
			local right = _G[self.dropdown:GetName() .. "Right"]

			local texture = self.dropdown:CreateTexture(nil, "ARTWORK")
			texture:SetPoint("BOTTOMRIGHT", right, "BOTTOMRIGHT" ,-39, 26)
			texture:SetPoint("TOPLEFT", left, "TOPLEFT", 24, -24)
			self.texture = texture

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
