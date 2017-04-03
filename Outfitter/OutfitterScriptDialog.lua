------------------------------------
Outfitter._EditScriptDialog = {}
------------------------------------

Outfitter._EditScriptDialog.Widgets =
{
	"Title",
	"Source",
	"Settings",
	"SettingsDescription",
	"SourceScriptEditBox",
	"SourceStatusMessage",
	"PresetScript",
}

function Outfitter._EditScriptDialog:Construct()
	Outfitter._PortraitWindowFrame.Construct(self)
	
	self.Widgets.SourceScriptEditBox.Dialog = self
	self.Widgets.SourceScriptEditBox.TextChanged = Outfitter.EditorScript_TextChanged
	
	self.Widgets.PresetScript.Dialog = self
	
	self.CloseButton:SetScript("OnClick", function (self) self:GetParent():Done() end)
	
	-- Tabs
	
	PanelTemplates_SetNumTabs(self, 2)
	self.selectedTab = 1
	PanelTemplates_UpdateTabs(self)
	
	-- Setting frames
	
	self.FrameCache = {}
end

function Outfitter._EditScriptDialog:Open(pOutfit, pShowSource)
	self.Outfit = pOutfit
	
	self.Widgets.Title:SetText(string.format(Outfitter.cEditScriptTitle, pOutfit:GetName()))
	
	local vScript = Outfitter:GetScript(pOutfit)
	
	if vScript then
		self.Widgets.SourceScriptEditBox:SetText(vScript)
	else
		self.Widgets.SourceScriptEditBox:SetText("")
	end
	
	-- Copy the script values
	
	self.ScriptSettings = {}
	
	if self.Outfit.ScriptSettings then
		for vKey, vValue in pairs(self.Outfit.ScriptSettings) do
			self.ScriptSettings[vKey] = vValue
		end
	end
	
	self:SetPresetScriptID(Outfitter:FindMatchingPresetScriptID(vScript))
	
	--
	
	if pShowSource then
		self:SetPanelIndex(2) -- Show the source panel
	else
		self:SetPanelIndex(1) -- Show the settings panel
	end
	
	self:Show()
	
	Outfitter.UIElementsLib:BeginDialog(self)
end

function Outfitter._EditScriptDialog:Close()
	Outfitter.SchedulerLib:UnscheduleTask(self.CheckScriptErrors, self)
	
	self.Outfit = nil
	self:Hide()
	
	Outfitter.UIElementsLib:EndDialog(self)
end

function Outfitter._EditScriptDialog:Done()
	-- Save the script
	
	local vScript = self.Widgets.SourceScriptEditBox:GetText()
	local vScriptID = Outfitter:FindMatchingPresetScriptID(vScript)
	
	if vScriptID then
		Outfitter:SetScriptID(self.Outfit, vScriptID)
	else
		Outfitter:SetScript(self.Outfit, vScript)
	end
	
	-- Save the settings
	
	self.Outfit.ScriptSettings = self:GetScriptSettings()
	
	--
	
	self:Close()
end

function Outfitter._EditScriptDialog:LoadScript(pScript)
	local vFunction, vMessage = loadstring(Outfitter.cScriptPrefix..pScript..Outfitter.cScriptSuffix, "Outfit Script")
	
	if vMessage then
		local _, _, vLine, vMessage2 = string.find(vMessage, Outfitter.cExtractErrorFormat)
		
		if vLine then
			vMessage = string.format(Outfitter.cScriptErrorFormat, vLine - Outfitter.cScriptPrefixNumLines, vMessage2)
		end
	end
	
	return vFunction, vMessage
end

function Outfitter._EditScriptDialog:CheckScriptErrors()
	local vScript = self.Widgets.SourceScriptEditBox:GetText()
	local vScriptFields, vMessage = Outfitter:ParseScriptFields(vScript)
	
	if not vMessage then
		_, vMessage = self:LoadScript(vScript)
	end
	
	if vMessage then
		self.Widgets.SourceStatusMessage:SetText(vMessage)
	else
		self.Widgets.SourceStatusMessage:SetText("OK")
	end
	
	self:SetPresetScriptID(Outfitter:FindMatchingPresetScriptID(vScript))
end

function Outfitter._EditScriptDialog:SetPresetScriptID(pID)
	local vPresetScript = Outfitter:GetPresetScriptByID(pID)
	
	if not vPresetScript then
		Outfitter.DropDown_SetSelectedValue(self.Widgets.PresetScript, "CUSTOM")
		return
	end
	
	Outfitter.DropDown_SetSelectedValue(self.Widgets.PresetScript, pID)
	
	self.Widgets.SourceScriptEditBox:SetText(vPresetScript.Script)

	local vScriptFields, vMessage = Outfitter:ParseScriptFields(vPresetScript.Script)
	
	if vScriptFields then
		self:ConstructSettingsFields(vScriptFields)
	end
end

function Outfitter._EditScriptDialog:SetPanelIndex(pIndex)
	if pIndex == 1 then
		local vScript = self.Widgets.SourceScriptEditBox:GetText()
		local vScriptFields = Outfitter:ParseScriptFields(vScript)
		
		if vScriptFields then
			self:ConstructSettingsFields(vScriptFields)
		end
		
		self.Widgets.Settings:Show()
		self.Widgets.Source:Hide()
	else
		self.ScriptSettings = self:GetScriptSettings()
		
		self.Widgets.Settings:Hide()
		self.Widgets.Source:Show()
	end
	
	PanelTemplates_SetTab(self, pIndex)
end

function Outfitter._EditScriptDialog:ConstructSettingsFields(pSettings)
	-- Outfitter:DebugTable(pSettings, "ConstructSettingsFields")
	
	local vNumFramesUsed = {}
	
	self.SettingsFrames = {}
	
	-- Hide and de-anchor all frames
	
	for vFrameType, vFrames in pairs(self.FrameCache) do
		for _, vFrame in ipairs(vFrames) do
			vFrame:ClearAllPoints()
			vFrame:Hide()
		end
		
		vNumFramesUsed[vFrameType] = 0
	end
	
	--
	
	local vPreviousFrame = nil
	local vPreviousOffsetX = 0
	
	if pSettings.Inputs then
		self.Widgets.SettingsDescription:SetText(pSettings.Description or " ")
		
		for _, vDescriptor in ipairs(pSettings.Inputs) do
			local vType = string.lower(vDescriptor.Type)
			local vSettingTypeInfo = Outfitter.SettingTypeInfo[vType]
			
			if not vSettingTypeInfo then
				Outiftter:ErrorMessage("Unknown $SETTING type %s in the script, I can't create a control for it", vType or "nil")
				break
			end
			
			local vFrameType = vSettingTypeInfo.FrameType
			
			if not vNumFramesUsed[vFrameType] then
				vNumFramesUsed[vFrameType] = 0
			end
			
			local vFrameIndex = vNumFramesUsed[vFrameType] + 1
			local vFrame
			
			-- Create a new frame if needed
			
			local vFrameCache = self.FrameCache[vFrameType]
			
			if not vFrameCache then
				vFrameCache = {}
				self.FrameCache[vFrameType] = vFrameCache
			end
			
			vFrame = vFrameCache[vFrameIndex]
			
			if not vFrame then
				local vFrameName = self.Widgets.Settings:GetName()..vFrameType..vFrameIndex
				
				if vFrameType == "ScrollableEditBox" then
					vFrame = CreateFrame("ScrollFrame", vFrameName, self.Widgets.Settings, "OutfitterScrollableEditBox")
					vFrame:SetWidth(300)
					vFrame:SetHeight(80)
				
				elseif vFrameType == "EditBox" then
					vFrame = CreateFrame("EditBox", vFrameName, self.Widgets.Settings, "OutfitterInputBoxTemplate")
					vFrame:SetAutoFocus(false)
					vFrame:SetWidth(300)
					vFrame:SetHeight(18)
				
				elseif vFrameType == "ZoneListEditBox" then
					vFrame = CreateFrame("ScrollFrame", vFrameName, self.Widgets.Settings, "OutfitterZoneListEditBox")
					vFrame:SetWidth(180)
					vFrame:SetHeight(80)
				
				elseif vFrameType == "Checkbox" then
					vFrame = CreateFrame("CheckButton", vFrameName, self.Widgets.Settings, "OutfitterCheckboxTemplate")
					vFrame:SetWidth(24)
					vFrame:SetHeight(24)
				end
				
				if vFrame then
					vFrameCache[vFrameIndex] = vFrame
				end
			end
			
			if vFrame then
				table.insert(self.SettingsFrames, vFrame)
				
				vFrame.Descriptor = vDescriptor
				
				-- Position the frame
				
				local vOffsetX, vOffsetY = 0, -10
				
				if vDescriptor.Type == "Number" then
					vFrame:SetWidth(100)
				end
				
				if vFrameType == "EditBox" then
					vOffsetX = 6
				end
				
				if not vPreviousFrame then
					vFrame:SetPoint("TOPLEFT", self.Widgets.SettingsDescription, "BOTTOMLEFT", vOffsetX - vPreviousOffsetX, vOffsetY)
				else
					vFrame:SetPoint("TOPLEFT", vPreviousFrame, "BOTTOMLEFT", vOffsetX - vPreviousOffsetX, vOffsetY)
				end
				
				vPreviousFrame = vFrame
				vPreviousOffsetX = vOffsetX
				vNumFramesUsed[vFrameType] = vFrameIndex
				
				-- Set the label
				
				local vLabelText = getglobal(vFrame:GetName().."Label")
				
				if not vLabelText then
					vLabelText = getglobal(vFrame:GetName().."Text")
				end
				
				vLabelText:SetText(vDescriptor.Label)
				
				-- Set the suffix
				
				local vSuffixText = getglobal(vFrame:GetName().."Suffix")
				
				if vSuffixText then
					vSuffixText:SetText(vDescriptor.Suffix or "")
				end
				
				-- Set the zone type if it's a zone list
				
				if vFrameType == "ZoneListEditBox" then
					local vType = vDescriptor.ZoneType
					
					if not vType then
						vType = "Zone"
					end
					
					local vZoneButton = getglobal(vFrame:GetName().."ZoneButton")
					
					vZoneButton.GetTextFunc = getglobal("Get"..vType.."Text")
					vZoneButton:SetText(string.format(Outfitter.cInsertFormat, vZoneButton.GetTextFunc()))
				end
				
				-- Show it
				
				vFrame:Show()
			end
		end
	else -- if pSettings.Inputs
		self.Widgets.SettingsDescription:SetText(pSettings.Description or Outfitter.cNoScriptSettings)
	end
	
	self:SetScriptSettings()
end

function Outfitter._EditScriptDialog:GetScriptSettings()
	local vSettings = {}
	
	if self.SettingsFrames then
		for _, vFrame in ipairs(self.SettingsFrames) do
			local vType = string.lower(vFrame.Descriptor.Type)
			local vValue
			
			if vType == "string" then
				vValue = vFrame:GetText()
			
			elseif vType == "number" then
				vValue = tonumber(vFrame:GetText())
			
			elseif vType == "boolean" then
				vValue = vFrame:GetChecked() == 1
			
			elseif vType == "stringtable"
			or vType == "zonelist" then
				local vEditBox = getglobal(vFrame:GetName().."EditBox")
				
				vValue = {}
				
				for vLine in string.gmatch(vEditBox:GetText(), "([^\r\n]*)") do
					if string.len(vLine) > 0 then
						table.insert(vValue, vLine)
					end
				end
			else
				Outfitter:DebugMessage("EditScriptDialog:GetScriptSettings: Unknown type %s", vType or "nil")
			end
			
			vSettings[vFrame.Descriptor.Field] = vValue
		end
	end
	
	-- Outfitter:DebugTable(vSettings, "GetScriptSettings")
	
	return vSettings
end

function Outfitter._EditScriptDialog:SetScriptSettings()
	if not self.SettingsFrames then
		return
	end
	
	for _, vFrame in ipairs(self.SettingsFrames) do
		local vType = string.lower(vFrame.Descriptor.Type)
		local vValue = self.ScriptSettings[vFrame.Descriptor.Field]
		
		if not vValue then
			local vSettingTypeInfo = Outfitter.SettingTypeInfo[vType]
			
			if not vSettingTypeInfo then
				return
			end
			
			vValue = vSettingTypeInfo.Default
		end
		
		if vType == "string"
		or vType == "number" then
			vFrame:SetText(vValue)
		
		elseif vType == "boolean" then
			vFrame:SetChecked(vValue)
		
		elseif vType == "stringtable"
		or vType == "zonelist" then
			local vEditBox = getglobal(vFrame:GetName().."EditBox")
			
			if type(vValue) == "table" then
				vEditBox:SetText(table.concat(vValue, "\n"))
			else
				vEditBox:SetText("")
			end
		end
	end
end

function Outfitter.EditorScript_TextChanged(pEditBox)
	local vDialog = pEditBox.Dialog
	
	vDialog.Widgets.SourceStatusMessage:SetText(Outfitter.cTyping)
	
	Outfitter.SchedulerLib:RescheduleTask(1.5, vDialog.CheckScriptErrors, vDialog)
end

