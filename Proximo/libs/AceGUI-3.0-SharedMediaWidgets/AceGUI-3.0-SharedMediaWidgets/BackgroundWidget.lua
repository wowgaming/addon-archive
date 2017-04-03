-- Widget is based on the AceGUIWidget-DropDown.lua supplied with AceGUI-3.0
-- Widget created by Yssaril

local AceGUI = LibStub("AceGUI-3.0")
local Media = LibStub("LibSharedMedia-3.0")

do
	local min, max, floor = math.min, math.max, math.floor
	local fixlevels = AceGUISharedMediaWidgets.fixlevels
	local OnItemValueChanged = AceGUISharedMediaWidgets.OnItemValueChanged
	
	do
		local widgetType = "LSM30_Background_Item_Select"
		local widgetVersion = 1
			
		local function Frame_OnEnter(this)
			local self = this.obj

			if self.useHighlight then
				self.highlight:Show()
				self.texture:Show()
			end
			self:Fire("OnEnter")
			
			if self.specialOnEnter then
				self.specialOnEnter(self)
			end
		end

		local function Frame_OnLeave(this)
			local self = this.obj
			self.texture:Hide()
			self.highlight:Hide()
			self:Fire("OnLeave")
			
			if self.specialOnLeave then
				self.specialOnLeave(self)
			end
		end

		local function SetText(self, text)
			if text and text ~= '' then
				self.texture:SetTexture(Media:Fetch('background',text))
			end
			self.text:SetText(text or "")
		end
		
		local function Constructor()
			local self = AceGUI:Create("Dropdown-Item-Toggle")
			self.type = widgetType
			self.SetText = SetText
			local textureframe = CreateFrame('Frame')
			textureframe:SetFrameStrata("TOOLTIP")
			textureframe:SetWidth(128)
			textureframe:SetHeight(128)
			textureframe:SetPoint("LEFT",self.frame,"RIGHT",5,0)
			self.textureframe = textureframe
			local texture = textureframe:CreateTexture(nil, "OVERLAY")
			texture:SetTexture(0,0,0,0)
			texture:SetAllPoints(textureframe)
			texture:Hide()
			self.texture = texture
			self.frame:SetScript("OnEnter", Frame_OnEnter)
			self.frame:SetScript("OnLeave", Frame_OnLeave)
			return self
		end
		AceGUI:RegisterWidgetType(widgetType, Constructor, widgetVersion)
	end

	do 
		local widgetType = "LSM30_Background"
		local widgetVersion = 2
		
		local function Frame_OnEnter(this)
			local self = this.obj
			local text = self.text:GetText()
			if text ~= nil and text ~= '' then 
				self.textureframe:Show()
			end
		end
		
		local function Frame_OnLeave(this)
			local self = this.obj
			self.textureframe:Hide()
		end
		
		local function SetText(self, text)
			if text and text ~= '' then
				self.texture:SetTexture(Media:Fetch('background',text))
			end
			self.text:SetText(text or "")
		end
		
		local function AddListItem(self, value, text)
			local item = AceGUI:Create("LSM30_Background_Item_Select")
			item:SetText(text)
			item.userdata.obj = self
			item.userdata.value = value
			item:SetCallback("OnValueChanged", OnItemValueChanged)
			self.pullout:AddItem(item)
		end
		
		local sortlist = {}
		local function SetList(self, list)
			self.list = list or Media:HashTable("background")
			self.pullout:Clear()
			for v in pairs(self.list) do
				sortlist[#sortlist + 1] = v
			end
			table.sort(sortlist)
			for i, value in pairs(sortlist) do
				AddListItem(self, value, value)
				sortlist[i] = nil
			end
			if self.multiselect then
				AddCloseButton()
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
			
			local textureframe = CreateFrame('Frame')
			textureframe:SetFrameStrata("TOOLTIP")
			textureframe:SetWidth(128)
			textureframe:SetHeight(128)
			textureframe:SetPoint("LEFT",right,"RIGHT",-15,0)
			self.textureframe = textureframe
			local texture = textureframe:CreateTexture(nil, "OVERLAY")
			texture:SetTexture(0,0,0,0)
			texture:SetAllPoints(textureframe)
			textureframe:Hide()
			self.texture = texture
			
			self.dropdown:EnableMouse(true)
			self.dropdown:SetScript("OnEnter", Frame_OnEnter)
			self.dropdown:SetScript("OnLeave", Frame_OnLeave)
			
			return self
		end
		AceGUI:RegisterWidgetType(widgetType, Constructor, widgetVersion)
	end
end
