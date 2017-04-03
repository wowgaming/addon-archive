-- Widget is based on the AceGUIWidget-DropDown.lua supplied with AceGUI-3.0
-- Widget created by Yssaril
LoadAddOn("LibSharedMedia-3.0")
local AceGUI = LibStub("AceGUI-3.0")
local Media = LibStub("LibSharedMedia-3.0")

AceGUISharedMediaWidgets = {}
do
	AceGUIWidgetLSMlists = {
		['font'] = Media:HashTable("font"),
		['sound'] = Media:HashTable("sound"),
		['statusbar'] = Media:HashTable("statusbar"),
		['border'] = Media:HashTable("border"),
		['background'] = Media:HashTable("background"),
	}

	local min, max, floor = math.min, math.max, math.floor
	
	local function fixlevels(parent,...)
		local i = 1
		local child = select(i, ...)
		while child do
			child:SetFrameLevel(parent:GetFrameLevel()+1)
			fixlevels(child, child:GetChildren())
			i = i + 1
			child = select(i, ...)
		end
	end

	local function OnItemValueChanged(this, event, checked)
		local self = this.userdata.obj
		if self.multiselect then
			self:Fire("OnValueChanged", this.userdata.value, checked)
		else
			if checked then
				self:SetValue(this.userdata.value)
				self:Fire("OnValueChanged", this.userdata.value)
			else
				this:SetValue(true)
			end		
			self.pullout:Close()
		end
	end
	
	local function SetValue(self, value)
		if value then
			self:SetText(value or "")
		end
		self.value = value
	end
	
	AceGUISharedMediaWidgets.fixlevels = fixlevels
	AceGUISharedMediaWidgets.OnItemValueChanged = OnItemValueChanged
	AceGUISharedMediaWidgets.SetValue = SetValue
end
