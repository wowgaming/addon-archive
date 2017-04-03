function sdm_SlashHandler(command)
	if command=="" then
		if sdm_mainFrame:IsShown() then
			sdm_Quit()
		else
			sdm_mainFrame:Show()
		end
	elseif command:lower()=="test" then
		sdm_CompareFuncs()
	elseif command:sub(1,4):lower()=="run " then
		sdm_RunScript(command:sub(5))
	else print("SDM did not recognize the command \""..command.."\"")
	end
end
function sdm_MakeMacroFrame(name, text)
	sdm_DoOrQueue("local temp = getglobal("..sdm_Stringer(name)..") or CreateFrame(\"Button\", "..sdm_Stringer(name)..", nil, \"SecureActionButtonTemplate\")\
	temp:SetAttribute(\'type\', \'macro\')\
	temp:SetAttribute(\'macrotext\', "..sdm_Stringer(text)..")")
--	GetClickFrame(name) --This line is just to fix a taint issue from a Blizzard bug (fixed in 3.0)
--	print("Creating frame \""..name.."\" with macrotext\n\""..text.."\"\n(length "..string.len(text)..")")
	if string.len(text)>1023 then print("The following line is "..(string.len(text)-1023).." characters too long:\n"..text) end
end
function sdm_MakeBlizzardMacro(ID, name, icon, text, perCharacter)
--	print("Creating macro \""..name.."\" with text\n\""..text.."\"\n(length "..string.len(text)..")")
	sdm_DoOrQueue("local macroIndex = sdm_GetMacroIndex("..sdm_Stringer(ID)..")\
	if macroIndex then\
		EditMacro(macroIndex, "..sdm_Stringer(name)..", "..sdm_Stringer(icon)..", "..sdm_Stringer(text)..", 1, "..sdm_Stringer(perCharacter)..")\
	else\
		CreateMacro("..sdm_Stringer(name)..", "..sdm_Stringer(icon or 1)..", "..sdm_Stringer(text)..", "..sdm_Stringer(perCharacter)..", 1)\
	end")
end
function sdm_GetSdmID(macroIndex)
	local thisMacroText=GetMacroBody(macroIndex)
	if thisMacroText and thisMacroText:sub(1,4)=="#sdm" then
		return sdm_charsToNum(thisMacroText:sub(5,thisMacroText:find("\n")-1))
	else
		return nil
	end
end
function sdm_GetMacroIndex(sdmID)
	for i=1,54 do
		if sdm_GetSdmID(i)==sdmID then
			return i
		end
	end
	return nil
end
function sdm_GetLinkText(nextName)
	return "/click [btn:5]"..nextName.." Button5;[btn:4]"..nextName.." Button4;[btn:3]"..nextName.." MiddleButton;[btn:2]"..nextName.." RightButton;"..nextName
end
function sdm_SetUpMacro(mTab)
	local type = mTab.type
	if type~="b" and type~="f" then
		return
	end
	local text = mTab.text
	local perCharacter = mTab.character~=nil
	local ID = mTab.ID
	local icon = mTab.icon
	local charLimit = 255
	if type=="b" then
		text="#sdm"..sdm_numToChars(ID).."\n"..text
	end
	local nextFrameName = "sdh"..sdm_numToChars(ID)
	local frameText
	if text:len()<=charLimit then
		frameText = text
	else
		frameText = ""
		local linkText = "\n"..sdm_GetLinkText(nextFrameName)
		for line in text:gmatch("[^\r\n]+") do
			if line~="" then
				if frameText~="" then --if this is not the first line of the frame, we need to add a carriage return before it.
					line="\n"..line
				end
				if frameText:len()+line:len()+linkText:len() > charLimit then --adding this line would be too much, so just add the link and be done with it. (note that this line does NOT get removed from the master text)
					frameText = frameText..linkText
					break
				end
				frameText = frameText..line
			end
			text=text:sub((text:find("\n") or text:len())+1) --remove the line from the text
		end
	end
	sdm_SetUpMacroFrames(nextFrameName, text, 1)
	if type=="b" then
		sdm_MakeBlizzardMacro(ID, (mTab.buttonName or mTab.name), icon, frameText, perCharacter)
		sdm_MakeMacroFrame("sdb_"..mTab.name, frameText)
	elseif type=="f" then
		sdm_MakeMacroFrame("sdf_"..mTab.name, frameText)
	end
end
function sdm_SetUpMacroFrames(clickerName, text, currentLayer) --returns the frame to be clicked
	local currentFrame=1
	local frameText=""
	local nextLayerText=""
	for line in text:gmatch("[^\r\n]+") do
		if line~="" then
			if frameText~="" then --if this is not the first line of the frame, we need to add a carriage return before it.
				line="\n"..line
			end
			if (frameText:len()+line:len() > 1023) then --adding this line would be too much, so finish this frame and move on to the next.
				sdm_MakeMacroFrame(clickerName.."_"..currentLayer.."_"..currentFrame, frameText)
				if nextLayerText~="" then nextLayerText= nextLayerText.."\n" end
				nextLayerText = nextLayerText..sdm_GetLinkText(clickerName.."_"..currentLayer.."_"..currentFrame)
				frameText = ""
				currentFrame = currentFrame+1
			end
			frameText = frameText..line
		end
		text=text:sub((text:find("\n") or text:len())+1) --remove the line from the text
	end
	if currentFrame==1 then
		return sdm_MakeMacroFrame(clickerName, frameText)
	else
		sdm_MakeMacroFrame(clickerName.."_"..currentLayer.."_"..currentFrame, frameText) --repeated from above; just finishing off this frame
		nextLayerText = nextLayerText.."\n"..sdm_GetLinkText(clickerName.."_"..currentLayer.."_"..currentFrame)
		return sdm_SetUpMacroFrames(clickerName, nextLayerText, currentLayer+1)
	end
end
function sdm_Query(channel, target) --next version: have a single token for party and raid, then decide here.
	SendAddonMessage("Super Duper Macro query", sdm_qian, channel, target)
end
function sdm_SendMacro(mTab, chan, tar)
	if sdm_sending then
		print("SDM: You are already sending something.")
		return
	end
	local perCharacter=nil
	--make the string that will be split up and sent.  It consists of a bunch of values separated by commas.  They are, in order: the version the sender is running, the minimum version the receiver must have, the type of macro, the index of the icon, the perCharacter status ("<table value>" or "nil"), the length of the name, the length of the text, the name, and the text.  There is no comma between the name and the text.
	local textToSend = sdm_qian..","..sdm_minVersion..","..mTab.type..","..tostring(mTab.icon)..","..tostring(mTab.character)..","..mTab.name:len()..","..mTab.text:len()..","..mTab.name..mTab.text
	local pref = "Super Duper Macro send1" -- if the prefix ends in "send1", it's the first line.  If it ends in "send2", it's any line after the first.
	local lineLen = 254 - pref:len()
	local linesToSend={}
	local pos = 1
	while pos <= textToSend:len() do
		table.insert(linesToSend, textToSend:sub(pos, pos+lineLen-1))
		pos = pos+lineLen
	end
	sdm_sending={
		i=1,
		lines = linesToSend,
		numLines = getn(linesToSend),
		channel = chan,
		target = tar,
		prefix = pref
	}
	sdm_sendReceiveFrame_sendBar_statusBar:SetMinMaxValues(0, sdm_sending.numLines)
	sdm_sendReceiveFrame_sendBar_statusBar:SetValue(0)
	sdm_sendReceiveFrame_sendBar_statusBar_text:SetText("|cffffccffSending to "..(sdm_sending.target or sdm_sending.channel).."|r")
	sdm_sendReceiveFrame_cancelSendButton:Enable()
	sdm_sendReceiveFrame_sendButton:Disable()
	sdm_sendReceiveFrame_sendPartyRadio:Disable()
	sdm_sendReceiveFrame_sendRaidRadio:Disable()
	sdm_sendReceiveFrame_sendBattlegroundRadio:Disable()
	sdm_sendReceiveFrame_sendGuildRadio:Disable()
	sdm_sendReceiveFrame_sendTargetRadio:Disable()
	sdm_sendReceiveFrame_sendArbitraryRadio:Disable()
	sdm_sendReceiveFrame_sendInput:EnableMouse(nil)
	sdm_updateFrame:Show()
end
function sdm_OnUpdate(self, elapsed) --used for sending macros
	self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed
	if self.TimeSinceLastUpdate > sdm_updateInterval then
		if sdm_sending.i == 2 then
			sdm_sending.prefix="Super Duper Macro send2"
		end
		SendAddonMessage(sdm_sending.prefix, sdm_sending.lines[sdm_sending.i], sdm_sending.channel, sdm_sending.target)
		sdm_sendReceiveFrame_sendBar_statusBar:SetValue(sdm_sending.i)
		sdm_sending.i = sdm_sending.i+1
		if sdm_sending.i>sdm_sending.numLines then
			sdm_EndSending("|cff44ff00Sent to "..(sdm_sending.target or sdm_sending.channel).."|r")
		end
		self.TimeSinceLastUpdate = 0
	end
end
function sdm_EndSending(text)
	sdm_updateFrame:Hide()
	sdm_sendReceiveFrame_sendBar_statusBar_text:SetText(text)
	sdm_sending=nil
	sdm_sendReceiveFrame_cancelSendButton:Disable()
	if sdm_currentEdit then
		sdm_sendReceiveFrame_sendButton:Enable()
	end
	sdm_sendReceiveFrame_sendPartyRadio:Enable()
	sdm_sendReceiveFrame_sendRaidRadio:Enable()
	sdm_sendReceiveFrame_sendBattlegroundRadio:Enable()
	sdm_sendReceiveFrame_sendGuildRadio:Enable()
	sdm_sendReceiveFrame_sendTargetRadio:Enable()
	sdm_sendReceiveFrame_sendArbitraryRadio:Enable()
	sdm_sendReceiveFrame_sendInput:EnableMouse(1)
end
function sdm_WaitForMacro(name)
	if sdm_receiving then
		print("SDM: You are already receiving or waiting.")
		return
	end
	sdm_receiving = {playerName=name, first=true}
	sdm_sendReceiveFrame_receiveBar_statusBar:SetValue(0)
	sdm_sendReceiveFrame_receiveBar_statusBar_text:SetText("|cffffccffWaiting for "..sdm_receiving.playerName.."|r")
	sdm_sendReceiveFrame_cancelReceiveButton:Enable()
	sdm_sendReceiveFrame_receiveButton:Disable()
	sdm_sendReceiveFrame_receiveTargetRadio:Disable()
	sdm_sendReceiveFrame_receiveArbitraryRadio:Disable()
	sdm_sendReceiveFrame_receiveInput:EnableMouse(nil)
	sdm_SelectItem(nil)
	sdm_newFrame:Show()
	sdm_newFrame_input:ClearFocus()
	sdm_newFrame_input:SetText("Receiving macro...")
	sdm_newFrame_input:EnableMouse(nil)
	sdm_newFrame_buttonRadio:Disable()
	sdm_newFrame_floatingRadio:Disable()
	sdm_newFrame_scriptRadio:Disable()
	sdm_newFrame_globalRadio:Disable()
	sdm_newFrame_charspecRadio:Disable()
	sdm_newFrame_createButton:Disable()
end
function sdm_ReceiveLine(line, send1)
	if sdm_receiving.first and send1 then --this is the first line
		sdm_receiving.nameAndText, sdm_receiving.textLen, sdm_receiving.playerNameLen, sdm_receiving.perCharacter, sdm_receiving.icon, sdm_receiving.type, sdm_receiving.minVersion, sdm_receiving.sendersVersion = sdm_SplitString(line, ",", 7)
		sdm_receiving.perCharacter = (sdm_receiving.perCharacter~="nil")
		if sdm_receiving.icon=="nil" then
			sdm_receiving.icon = nil
		else
			sdm_receiving.icon = 0 + sdm_receiving.icon
		end
		sdm_receiving.textLen = 0 + sdm_receiving.textLen
		sdm_receiving.playerNameLen = 0 + sdm_receiving.playerNameLen
		sdm_receiving.first = false
		sdm_sendReceiveFrame_receiveBar_statusBar:SetMinMaxValues(0, sdm_receiving.playerNameLen + sdm_receiving.textLen)
		sdm_sendReceiveFrame_receiveBar_statusBar_text:SetText("|cffffccffReceiving|r")
		sdm_VersionReceived(sdm_receiving.sendersVersion)
		if sdm_CompareVersions(sdm_receiving.sendersVersion, sdm_minVersion)==2 or sdm_CompareVersions(sdm_version, sdm_receiving.minVersion)==2 then
			print("SDM: You failed to recieve the macro due to a version incompatibility.")
			SendAddonMessage("Super Duper Macro recFailed", "Incompatible Versions,"..sdm_qian, "WHISPER", sdm_receiving.playerName)
			sdm_EndReceiving("|cffff0000Failed|r")
			return
		else
			SendAddonMessage("Super Duper Macro receiving", sdm_qian, "WHISPER", sdm_receiving.playerName)
		end
	elseif (not sdm_receiving.first) and (not send1) then
		sdm_receiving.nameAndText = sdm_receiving.nameAndText..line
	else
		return
	end
	local currLen = sdm_receiving.nameAndText:len()
	sdm_sendReceiveFrame_receiveBar_statusBar:SetValue(currLen)
	if currLen == (sdm_receiving.playerNameLen + sdm_receiving.textLen) then
		sdm_sendReceiveFrame_receiveBar_statusBar_text:SetText("|cffff9900Click \"Create\" to save|r")
		UIFrameFlash(sdm_newFrame_createButton_flash, 0.5, 0.5, 1e6, false)
		sdm_newFrame_input:EnableMouse(1)
		sdm_newFrame_buttonRadio:Enable()
		sdm_newFrame_floatingRadio:Enable()
		sdm_newFrame_scriptRadio:Enable()
		sdm_newFrame_globalRadio:Enable()
		sdm_newFrame_charspecRadio:Enable()
		sdm_newFrame_createButton:Enable()
		if sdm_receiving.type=="b" then
			sdm_newFrame_buttonRadio:Click()
		elseif sdm_receiving.type=="f" then
			sdm_newFrame_floatingRadio:Click()
		elseif sdm_receiving.type=="s" then
			sdm_newFrame_scriptRadio:Click()
		end
		if sdm_receiving.perCharacter then
			sdm_newFrame_charspecRadio:Click()
		else
			sdm_newFrame_globalRadio:Click()
		end
		sdm_receiving.name=sdm_receiving.nameAndText:sub(1,sdm_receiving.playerNameLen)
		sdm_newFrame_input:SetText(sdm_receiving.name)
		sdm_receiving.text=sdm_receiving.nameAndText:sub(sdm_receiving.playerNameLen+1,sdm_receiving.playerNameLen+sdm_receiving.textLen)
	end
end
function sdm_EndReceiving(text)
	sdm_sendReceiveFrame_receiveBar_statusBar_text:SetText(text)
	sdm_sendReceiveFrame_cancelReceiveButton:Disable()
	sdm_sendReceiveFrame_receiveButton:Enable()
	sdm_mainFrame_newButton:Enable()
	sdm_sendReceiveFrame_receiveTargetRadio:Enable()
	sdm_sendReceiveFrame_receiveArbitraryRadio:Enable()
	sdm_sendReceiveFrame_receiveInput:EnableMouse(1)
	sdm_newFrame_input:SetText("")
	sdm_newFrame_input:EnableMouse(1)
	sdm_newFrame_buttonRadio:Enable()
	sdm_newFrame_floatingRadio:Enable()
	sdm_newFrame_scriptRadio:Enable()
	sdm_newFrame_globalRadio:Enable()
	sdm_newFrame_charspecRadio:Enable()
	sdm_newFrame_createButton:Enable()
	sdm_receiving=nil
end
function sdm_CancelSend()
	SendAddonMessage("Super Duper Macro sendFailed", "Cancelled", sdm_sending.channel, sdm_sending.target)
	sdm_EndSending("|cffff0000Cancelled|r")
end
function sdm_CancelReceive()
	SendAddonMessage("Super Duper Macro recFailed", "Cancelled,"..sdm_qian, "WHISPER", sdm_receiving.playerName)
	sdm_EndReceiving("|cffff0000Cancelled|r")
	sdm_newFrame:Hide()
end
function sdm_CreateCancelButtonPressed()
	sdm_newFrame:Hide()
	if sdm_receiving then
		sdm_CancelReceive()
	end
end
function sdm_SplitString(s, pattern, limit, ...) --iterates through "s", splitting it between occurrences of "pattern", and returning the split portions IN BACKWARDS ORDER. Splits a maximum of <limit> times (optional)
	if limit==0 then
		return s, ...
	end
	local index = s:find(pattern)
	if (not index) then
		return s, ...
	end
	return sdm_SplitString(s:sub(index+pattern:len()), pattern, limit-1, s:sub(1, index-1), ...)
end
function sdm_VersionReceived(ver)
	if not sdm_versionWarning and sdm_CompareVersions(sdm_version,ver)==2 then
		sdm_versionWarning="|cff00ff00New version available!  Check on www.wowinterface.com|r"
		print("Super Duper Macro: "..sdm_versionWarning)
		sdm_mainFrameTitle:SetText(sdm_versionWarning)
	end
end
function sdm_DoOrQueue(luaText) --If player is not in combat, runs the command. Otherwise, queues it up to be executed when combat is dropped.
	if UnitAffectingCombat("player") then
		sdm_eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
		print("SDM: Changes to macros will not take effect until combat ends.")
		table.insert(sdm_doAfterCombat, luaText)
	else
		RunScript(luaText)
	end
end
function sdm_Stringer(var) --converts a variable to a string for purposes of putting it in a string for RunScript(). Strings are formatted as quoted strings, other vars are converted to strings.
	if type(var)=="string" then
		return string.format("%q", var)
	else
		return tostring(var)
	end
end
function sdm_CompareVersions(firstString, secondString) --returns 1 if the first is bigger, 2 if the second is bigger, and 0 if they are equal.
	local strings = {firstString, secondString}
	local numbers = {}
	while 1 do
		for i=1, 2 do
			if (not strings[i]) then strings[i]="0" end
			local indexOfPeriod=(strings[i]):find("%.")
			if (not indexOfPeriod) then
				numbers[i]=strings[i]
				strings[i]=nil
			else
				numbers[i]=strings[i]:sub(1, indexOfPeriod-1)
				strings[i] = strings[i]:sub(indexOfPeriod+1)
			end
			numbers[i] = tonumber(numbers[i])
		end
		if numbers[1] > numbers[2] then
			return 1
		elseif numbers[2] > numbers[1] then
			return 2
		elseif (not strings[1]) and (not strings[2]) then
			return 0
		end
	end
end
function sdm_About()
	print("Super Duper Macro by hypehuman. Version "..sdm_version..". Check for updates at www.wowinterface.com")
end
function sdm_TypeDropdownLoaded(self)
	self:SetScript("OnShow", nil)
	UIDropDownMenu_Initialize(self, sdm_InitializeTypeDropdown);
	UIDropDownMenu_SetText(self, "Type");
	UIDropDownMenu_SetWidth(self, 52);
end
function sdm_CharDropdownLoaded(self)
	self:SetScript("OnShow", nil)
	UIDropDownMenu_Initialize(self, sdm_InitializeCharDropdown);
	UIDropDownMenu_SetText(self, "Character");
	UIDropDownMenu_SetWidth(self, 75);
end
function sdm_InitializeTypeDropdown()
	local info = UIDropDownMenu_CreateInfo();
	local buttons = {
		{val="b", txt="Button Macros"},
		{val="f", txt="Floating Macros"},
		{val="s", txt="Scripts"}
	}
	for _,v in ipairs(buttons) do
		info.value = v.val;
		info.text = sdm_GetColor(v.val, v.txt);
		info.func = sdm_FilterButtonClicked;
		info.checked = sdm_listFilters[info.value];
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info);		
	end
end
function sdm_InitializeCharDropdown()
	local info = UIDropDownMenu_CreateInfo();
	local buttons = {
		{val="global", txt="Global"},
		{val="true", txt="This Character"},
		{val="false", txt="Other Characters"}
	}
	
	for _,v in ipairs(buttons) do
		info.value = v.val;
		info.text = sdm_GetColor(v.val, v.txt);
		info.func = sdm_FilterButtonClicked;
		info.checked = sdm_listFilters[info.value];
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info);	
	end
end
function sdm_FilterButtonClicked(self, _, _, on)
	sdm_listFilters[self.value] = on
	sdm_UpdateList()
end
function sdm_SendButtonClicked()
	local channel
	local target
	if sdm_sendReceiveFrame_sendPartyRadio:GetChecked() then
		channel="PARTY"
	elseif sdm_sendReceiveFrame_sendRaidRadio:GetChecked() then
		channel="RAID"
	elseif sdm_sendReceiveFrame_sendBattlegroundRadio:GetChecked() then
		channel="BATTLEGROUND"
	elseif sdm_sendReceiveFrame_sendGuildRadio:GetChecked() then
		channel="GUILD"
	elseif sdm_sendReceiveFrame_sendTargetRadio:GetChecked() then
		channel="WHISPER"
		if UnitIsPlayer("target") then
			target, realm = UnitName("target")
			if realm then
				target = target.."-"..realm
			end
		end
	elseif sdm_sendReceiveFrame_sendArbitraryRadio:GetChecked() then
		channel="WHISPER"
		target=sdm_sendReceiveFrame_sendInput:GetText()
	end
	if channel=="WHISPER" and ((not target) or target=="" or target==sdm_thisChar.name) then
		return
	end
	sdm_sendReceiveFrame_sendInput:ClearFocus()
	sdm_SendMacro(sdm_macros[sdm_currentEdit], channel, target)
end
function sdm_ReceiveButtonClicked()
	local sender
	if sdm_sendReceiveFrame_receiveTargetRadio:GetChecked() then
		if UnitIsPlayer("target") then
			sender, realm = UnitName("target")
			if realm then
				sender = sender.."-"..realm
			end
		end
	elseif sdm_sendReceiveFrame_receiveArbitraryRadio:GetChecked() then
		sender=sdm_sendReceiveFrame_receiveInput:GetText()
	end
	if ((not sender) or sender=="" or sender==sdm_thisChar.name) then return end
	sdm_sendReceiveFrame_receiveInput:ClearFocus()
	sdm_SaveConfirmationBox("sdm_WaitForMacro("..sdm_Stringer(sender)..")")
end
function sdm_NewButtonClicked()
	sdm_SaveConfirmationBox("sdm_SelectItem(nil) sdm_newFrame:Show() sdm_newFrame_input:SetFocus()")
end
function sdm_DeleteButtonClicked()
	sdm_ChangeContainer(sdm_macros[sdm_currentEdit], false)
	sdm_SelectItem(nil)
end
function sdm_ListItemClicked(self, button)
	local mTab = sdm_macros[self.index]
	if button=="RightButton" then
		sdm_currentlyPlacing = self.index
		sdm_UpdateList()
	elseif sdm_currentlyPlacing then
		local container
		if mTab.type=="c" then --If we clicked on a container, place the item in this container
			container = mTab.ID
		else --If we clicked on a non-container, place the item in the container that contains this macro
			container = mTab.container
		end
		sdm_ChangeContainer(sdm_macros[sdm_currentlyPlacing], container)
		sdm_currentlyPlacing=nil
		sdm_UpdateList()
	elseif mTab.type=="c" and not IsAltKeyDown() then
		mTab.open = not mTab.open
		sdm_UpdateList()
	else
		sdm_SaveConfirmationBox("sdm_SelectItem("..self.index..")")
	end
end
function sdm_SelectItem(newCurrentEdit)
	if sdm_listLocked then return end
	if sdm_macros[newCurrentEdit] then
		sdm_currentEdit = newCurrentEdit
	else
		sdm_currentEdit = nil
	end
	if (not sdm_currentEdit) then
		sdm_mainFrame_deleteButton:Disable()
		sdm_mainFrame_getLinkButton:Disable()
		sdm_mainFrame_changeIconButton:Disable()
		sdm_mainFrame_editScrollFrame:Hide()
		sdm_mainFrame_saveButton:Disable()
		sdm_sendReceiveFrame_sendButton:Disable()
		sdm_containerInstructions:Hide()
		sdm_currentTitle:Hide()
	else
		sdm_mainFrame_editScrollFrame_text:ClearFocus()
		sdm_mainFrame_deleteButton:Enable()
		sdm_mainFrame_changeIconButton:Enable()
		if sdm_macros[sdm_currentEdit].type=="c" then
			sdm_mainFrame_editScrollFrame:Hide()
			sdm_containerInstructions:Show()
			sdm_mainFrame_getLinkButton:Disable()
		else
			sdm_mainFrame_editScrollFrame:Show()
			sdm_containerInstructions:Hide()
			sdm_mainFrame_getLinkButton:Enable()
		end
		sdm_mainFrame_editScrollFrame_text:SetText(sdm_macros[sdm_currentEdit].text or "")
		sdm_mainFrame_saveButton:Disable()
		if not sdm_sending then
			sdm_sendReceiveFrame_sendButton:Enable()
		end
		sdm_currentTitle:SetText(sdm_GetColor(sdm_macros[sdm_currentEdit].type, sdm_GetTitle(sdm_macros[sdm_currentEdit])))
		sdm_currentTitle:Show()
	end
	sdm_UpdateList()
end
function sdm_ResetContainers() --Deletes all folders and places all items into the main list
	sdm_mainContents={}
	for i,v in pairs(sdm_macros) do
		if v.type=="c" then
			sdm_macros[i]=nil
		else
			sdm_SortedInsert(sdm_mainContents, v)
			v.container=nil
		end
	end
end
function sdm_ChangeContainer(mTab, newContainer) --removes the mTab from its current container and places it in the container with ID newContainer.  If newContainer is nil, it's placed in the main folder.  If newContainer is false, the item is deleted.
	local parent = newContainer
	while parent do --check to see if we're trying to put a folder inside itself
		if parent==mTab.ID then return end
		parent = sdm_macros[parent].container
	end
	--remove the mTab from its current container.
	local prevContents--the .contents table of the container that currently holds this mTab
	if mTab.container==nil then
		prevContents = sdm_mainContents
	else
		prevContents = sdm_macros[mTab.container].contents
	end
	for i,ID in ipairs(prevContents) do
		if ID==mTab.ID then
			table.remove(prevContents, i)
			break
		end
	end
	--now we're done removing from old container
	if newContainer==false then --delete the mTab
		local type = mTab.type
		if type=="c" then --if we're deleting a container, move its contents into its parent.
			for _,ID in pairs(mTab.contents) do
				sdm_macros[ID].container=mTab.container
				sdm_SortedInsert(prevContents, sdm_macros[ID])
			end
		elseif sdm_UsedByThisChar(mTab) then
			if type=="b" or type=="f" then
				sdm_DoOrQueue("getglobal("..sdm_Stringer("sd"..type.."_"..mTab.name).."):SetAttribute(\"type\", nil)")
				if type=="b" then
					sdm_DoOrQueue("DeleteMacro(sdm_GetMacroIndex("..sdm_Stringer(mTab.ID).."))")
				end
			end
		end
		sdm_macros[mTab.ID]=nil
	else --move mTab into newContainer
		local contents --the new container's contents
		if newContainer then
			contents=sdm_macros[newContainer].contents
		else
			contents = sdm_mainContents
		end
		sdm_SortedInsert(contents, mTab)
		mTab.container = newContainer
	end
end
function sdm_SortedInsert(contents, mTab) --inserts mTab's ID into t (a table of IDs) at an appropriate location.  Returns the location.
	local lLim = 1
	local uLim = getn(contents)+1
	local test
	--perform a binary search to see where we should insert the mTab (to maintain alphabetical order)
	while lLim < uLim do
		test=math.floor((lLim+uLim)/2)
		if sdm_IsAtLeast(mTab, sdm_macros[contents[test]]) then
			lLim=test+1
		else
			uLim=test
		end
	end
	table.insert(contents, lLim, mTab.ID)
	return lLim
end
function sdm_IsAtLeast(one, two, i) --sees if the first mTab is greater than or equal to the second
	i=i or 1
	local var
	if i==1 then
		var=function(mTab) return mTab.name:upper() end
	elseif i==2 then
		var=function(mTab) return mTab.name end
	elseif i==3 then
		var=function(mTab) return mTab.type end
	elseif i==4 then
		var=function(mTab) if mTab.character then return mTab.character.name end return string.format('%c', 1) end
	elseif i==5 then
		var=function(mTab) if mTab.character then return mTab.character.realm end return string.format('%c', 1) end
	else
		return true
	end
	if var(one) > var(two) then
		return true
	elseif var(one) < var(two) then
		return false
	else
		return sdm_IsAtLeast(one, two, i+1)
	end
end
function sdm_UpdateList()
	if not sdm_mainFrame:IsShown() then return end
	local f
	for i=getn(sdm_listItems),1,-1 do
		f=sdm_listItems[i]
		f:Hide()
		table.remove(sdm_listItems, i)
		table.insert(sdm_unusedListItems[f.isContainerFrame], f)
	end
	local sorted, offsets = {}, {}
	sdm_AddFolderContents(sorted, offsets, sdm_mainContents, 0)
	sdm_currentListItem = nil
	local listItem, isContainer
	for i,mTab in ipairs(sorted) do
		isContainer = mTab.type=="c"
		listItem = table.remove(sdm_unusedListItems[isContainer],1)
		if not listItem then
			--create the listItem
			listItem = CreateFrame("Button", nil, sdm_mainFrame_macrosScroll_macroList)
			listItem.icon = listItem:CreateTexture(nil, "OVERLAY")
			listItem.text = listItem:CreateFontString(nil,"ARTWORK","GameFontNormal")
			listItem.text:SetJustifyH("LEFT")
			listItem.text:SetPoint("TOP")
			listItem.text:SetPoint("BOTTOMRIGHT")
			listItem.text:SetNonSpaceWrap(true)
			listItem.isContainerFrame=isContainer
			listItem:SetPoint("RIGHT")
			listItem:SetPoint("LEFT")
			listItem.highlight = listItem:CreateTexture(nil, "BACKGROUND")
			listItem.highlight:SetAllPoints(listItem)
			listItem.highlight:SetTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight")
			listItem.highlight:SetBlendMode("ADD")
			listItem.highlight:Hide()
			listItem:SetScript("OnEnter", sdm_ListItemEntered)
			listItem:SetScript("OnLeave", sdm_ListItemLeft)
			listItem:SetScript("OnMouseUp", sdm_ListItemClicked)
			listItem.buttonHighlight = listItem:CreateTexture(nil, "HIGHLIGHT")
			listItem.buttonHighlight:SetBlendMode("ADD")
			listItem.buttonHighlight:SetAllPoints(listItem.icon)
			listItem:RegisterForDrag("LeftButton")
			if isContainer then
				listItem.icon:SetHeight(16)
				listItem.icon:SetWidth(16)
				listItem.buttonHighlight:SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
			else
				listItem.slotIcon = listItem:CreateTexture(nil, "ARTWORK")
				listItem.slotIcon:SetTexture("Interface\\Buttons\\UI-EmptySlot-Disabled")
				listItem.slotIcon:SetPoint("CENTER", listItem.icon)
				listItem.buttonHighlight:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
				listItem.buttonHighlight:SetPoint("CENTER", listItem.icon, "CENTER")
			end
		end
		table.insert(sdm_listItems, listItem) --this should insert it at i
		--now, update the item's graphical elements
		if isContainer then
			if mTab.open then
				listItem.icon:SetTexture("Interface\\Buttons\\UI-MinusButton-UP")
			else
				listItem.icon:SetTexture("Interface\\Buttons\\UI-PlusButton-UP")
			end
		else
			if mTab.icon==1 then
				if mTab.type=="b" and sdm_UsedByThisChar(mTab) then
					_,texture = GetMacroInfo(sdm_GetMacroIndex(mTab.ID))
				else
					texture = nil
				end
			else
				texture = GetMacroIconInfo(mTab.icon)
			end
			listItem.icon:SetTexture(texture)
			listItem.icon:SetWidth(sdm_iconSize)
			listItem.icon:SetHeight(sdm_iconSize)
			listItem.slotIcon:SetWidth(sdm_iconSize*64/36)
			listItem.slotIcon:SetHeight(sdm_iconSize*64/36)
			if mTab.type=="b" and sdm_UsedByThisChar(mTab) then
				listItem:SetScript("OnDragStart", function() PickupMacro(sdm_GetMacroIndex(sdm_macros[this.index].ID)) end)
			else
				listItem:SetScript("OnDragStart", nil)
			end
		end
		listItem.text:SetText(sdm_GetTitle(mTab))
		listItem:SetHeight(sdm_iconSize*(1+sdm_iconSpacing*2))
		listItem.icon:SetPoint("LEFT", sdm_iconSize*(sdm_iconSpacing + offsets[i]*(sdm_iconSpacing+1)) + (sdm_iconSize-listItem.icon:GetWidth())/2, 0)
		listItem.text:SetPoint("LEFT", sdm_iconSize*(sdm_iconSpacing + (offsets[i]+1)*(sdm_iconSpacing+1)), 0)
		listItem.index=mTab.ID
		if listItem.index==sdm_currentEdit then
			sdm_currentListItem = listItem
			listItem.highlight:SetVertexColor(sdm_GetColor(mTab.type))
			listItem.highlight:Show()
			listItem.text:SetTextColor(sdm_GetColor(nil))
		else
			listItem.highlight:Hide()
			listItem.text:SetTextColor(sdm_GetColor(mTab.type))
		end
		if listItem.index==sdm_currentlyPlacing then
			listItem:SetAlpha(0.3)
		else
			listItem:SetAlpha(1)
		end
		if i==1 then
			listItem:SetPoint("TOP")
		else
			listItem:SetPoint("TOP", sdm_listItems[i-1], "BOTTOM")
		end
		listItem:Show()
	end
end
function sdm_GetTitle(mTab)
	local result = mTab.name
	if mTab.character then
		result=result..sdm_GetColor(tostring(mTab.character.name..mTab.character.realm==sdm_thisChar.name..sdm_thisChar.realm), " ("..mTab.character.name.." of "..mTab.character.realm..")")
	end
	return result
end
function sdm_AddFolderContents(mTabs, offsets, contents, offset) --Populates mTabs with the elements of contents and all its subfolders.  Populates offsets with the amount of indentation for each item.
	for i,ID in ipairs(contents) do
		local mTab = sdm_macros[ID]
		if sdm_IncludeInList(mTab) then
			table.insert(mTabs, mTab)
			table.insert(offsets, offset)
			if mTab.type=="c" and mTab.open then -- If it's an open container, add its contents too.
				sdm_AddFolderContents(mTabs, offsets, mTab.contents, offset+1)
			end
		end
	end
end
function sdm_IncludeInList(mTab) --checks the filters to see if the item should be in the scrolling list
	if mTab.type=="c" then
		return true
	end
	if not sdm_listFilters[mTab.type] then
		return false
	end
	if not mTab.character then
		return sdm_listFilters["global"]
	end
	return sdm_listFilters[tostring(mTab.character.name..mTab.character.realm==sdm_thisChar.name..sdm_thisChar.realm)]
end
function sdm_MakeTextWhite(listItem)
	local t = listItem.text:GetText()
	listItem.text:SetText("|cffffffff"..t.."|r")
end
function sdm_MakeTextNotWhite(listItem)
	local t = listItem.text:GetText()
	if t:sub(1,2)=="|c" then
		listItem.text:SetText(t:sub(11, t:len()-2))
	end
end
function sdm_ListItemEntered(f)
	if sdm_macros[f.index].type=="c" then
		sdm_MakeTextWhite(f)
	end
end
function sdm_ListItemLeft(f)
	sdm_MakeTextNotWhite(f)
end
function sdm_GetColor(type, plainString)--if inputString is passed, it will return a new colored string.  If it's not passed, we will return three values.
	local r,g,b
	if type==nil then
		r,g,b= 1,1,1 --selected items
	elseif type=="b" then
		r,g,b= 1,1,.65 --button macros
	elseif type=="f" then
		r,g,b= 1,.62,.74 --floating macros
	elseif type=="s" then
		r,g,b= .76,.51,.29 --scripts
	elseif type=="true" then
		r,g,b= .7,.7,.7 --this character
	elseif type=="false" then
		r,g,b= .3,.3,.3 --other characters
	elseif type=="c" or type=="global" then
		r,g,b= NORMAL_FONT_COLOR.r,NORMAL_FONT_COLOR.g,NORMAL_FONT_COLOR.b --global or containers
	end
	if (not plainString) or r==nil then
		return r,g,b
	else
		local t = {r,g,b}
		local hex = ""
		for i,v in ipairs(t) do
			t[i] = string.format("%x", t[i]*255)
			while t[i]:len()<2 do
				t[i]="0"..t[i]
			end
			hex = hex..t[i]
		end
		return "|c00"..hex..plainString.."|r"
	end
end
function sdm_OnShow_changeIconFrame(f)
	local mTab = sdm_macros[sdm_currentEdit]
	if not sdm_macroUILoaded then
		MacroFrame_LoadUI()
	end
	MacroPopupFrame.selectedIcon=mTab.icon
	f.prevonshow=MacroPopupFrame:GetScript("OnShow")
	MacroPopupFrame:SetScript("OnShow", MacroPopupFrame_Update)
	f.prevonenter=MacroPopupEditBox:GetScript("OnEnterPressed")
	MacroPopupEditBox:SetScript("OnEnterPressed", sdm_ChangeIconOkayed)
	f.prevonesc=MacroPopupEditBox:GetScript("OnEscapePressed")
	MacroPopupEditBox:SetScript("OnEscapePressed", function() MacroPopupEditBox:ClearFocus() end)
	MacroPopupEditBox:SetAutoFocus(false)
	MacroFrame:Hide()
	f.prevmode=MacroPopupFrame.mode
	MacroPopupFrame.mode="sdm"
	f.prevpoints={}
	for i=1,MacroPopupFrame:GetNumPoints() do
		f.prevpoints[i]={MacroPopupFrame:GetPoint(i)}
	end
	MacroPopupFrame:ClearAllPoints()
	MacroPopupFrame:SetParent(f)
	MacroPopupFrame:SetPoint("BOTTOM")
	MacroPopupFrame:Show()
	_,_,_,_,f.fontstring = MacroPopupFrame:GetRegions()
	f.fontstring:SetText("        Different name on button:")
	MacroPopupOkayButton:Hide()
	MacroPopupCancelButton:Hide()
	MacroPopupFrame_sdmOkayButton:Show()
	MacroPopupFrame_sdmCancelButton:Show()
	if mTab.type=="b" then
		if (not mTab.buttonName) then
			MacroPopupFrame_buttonTextCheckBox:SetChecked(nil)
		else
			MacroPopupFrame_buttonTextCheckBox:SetChecked(1)
		end
		MacroPopupFrame_buttonTextCheckBox:Show()
		f.fontstring:Show()
	else
		MacroPopupFrame_buttonTextCheckBox:SetChecked(nil)
		MacroPopupFrame_buttonTextCheckBox:Hide()
		f.fontstring:Hide()
	end
	MacroPopupFrame_buttonTextCheckBox:GetScript("OnClick")(MacroPopupFrame_buttonTextCheckBox)
	sdm_changeIconFrame_input:SetText(mTab.name or "")
end
function sdm_OnHide_changeIconFrame(f)
	MacroPopupFrame:SetScript("OnShow", f.prevonshow)
	MacroPopupEditBox:SetScript("OnEnterPressed", f.prevonenter)
	MacroPopupEditBox:SetScript("OnEscapePressed", f.prevonesc)
	MacroPopupEditBox:SetAutoFocus(true)
	MacroPopupFrame.mode=f.prevmode
	MacroPopupFrame:ClearAllPoints()
	MacroPopupFrame:SetParent(UIParent)
	for _,point in ipairs(f.prevpoints) do
		MacroPopupFrame:SetPoint(point[1], point[2], point[3], point[4], point[5])
	end
	f.fontstring:SetText(MACRO_POPUP_TEXT)
	f.fontstring:Show()
	MacroPopupEditBox:Show()
	MacroPopupOkayButton:Show()
	MacroPopupCancelButton:Show()
	MacroPopupFrame_sdmOkayButton:Hide()
	MacroPopupFrame_sdmCancelButton:Hide()
	MacroPopupFrame:Hide()
	MacroPopupFrame_buttonTextCheckBox:Hide()
end
function sdm_ChangeIconOkayed()
	local mTab = sdm_macros[sdm_currentEdit]
	local nameInputted = sdm_changeIconFrame_input:GetText()
	local iconInputted = MacroPopupFrame.selectedIcon
	if (not nameInputted) or nameInputted=="" or (mTab.type~="c" and not iconInputted) then
		return
	end
	if (mTab.type=="b" or mTab.type=="f") and sdm_ContainsIllegalChars(nameInputted, true) then return end
	if sdm_DoesNameConflict(nameInputted, mTab.type, mTab.character, sdm_currentEdit, true) then
		return
	end
	local oldName = mTab.name
	local oldButtonName = mTab.buttonName
	local oldIcon = mTab.icon
	mTab.name = nameInputted
	sdm_ChangeContainer(mTab, mTab.container) --place the item in itself.  This is so that it gets re-sorted.
	if MacroPopupFrame_buttonTextCheckBox:GetChecked()==1 then
		mTab.buttonName = MacroPopupEditBox:GetText()
		if mTab.buttonName=="" then
			mTab.buttonName=" "
		end
	else
		mTab.buttonName=nil
	end
	if mTab.type~="c" then
		mTab.icon = iconInputted
	end
	sdm_changeIconFrame:Hide()
	if sdm_UsedByThisChar(mTab) and (mTab.type=="b" or mTab.type=="f") then
		if mTab.name~=oldName then
			local pref = "sd"..mTab.type.."_"
			local txt = getglobal(pref..oldName):GetAttribute("macrotext")
			sdm_DoOrQueue("getglobal("..sdm_Stringer(pref..oldName).."):SetAttribute(\"type\", nil)")
			sdm_MakeMacroFrame("sd"..mTab.type.."_"..mTab.name, txt)
		end
		if mTab.type=="b" and ((mTab.buttonName or mTab.name)~=(oldButtonName or oldName) or mTab.icon~=oldIcon) then
			sdm_MakeBlizzardMacro(mTab.ID, (mTab.buttonName or mTab.name), mTab.icon)
		end
	end
	sdm_currentTitle:SetText(sdm_GetColor(sdm_macros[sdm_currentEdit].type, sdm_GetTitle(sdm_macros[sdm_currentEdit])))
	sdm_UpdateList()
end
function sdm_buttonTextCheckBoxClicked(checked)
	if checked then
		MacroPopupEditBox:Show()
		if sdm_macros[sdm_currentEdit].buttonName and sdm_macros[sdm_currentEdit].buttonName~=" " then
			MacroPopupEditBox:SetText(sdm_macros[sdm_currentEdit].buttonName)
		else
			MacroPopupEditBox:SetText("")
		end
	else
		MacroPopupEditBox:Hide()
	end
end
function sdm_CollapseAllButtonClicked(self)
	local allOpenOrClosed = self:GetChecked()==nil
	for _,v in ipairs(sdm_macros) do
		if v.type=="c" then
			v.open = allOpenOrClosed
		end
	end
	sdm_UpdateList()
end
function sdm_freezeEditFrame()
	sdm_descendants = {sdm_mainFrame:GetChildren()}
	sdm_mouseStates = {}
	local i=1
	for i,v in ipairs(sdm_descendants) do
		for j,w in ipairs({v:GetChildren()}) do
			table.insert(sdm_descendants, w)
		end
		sdm_mouseStates[i] = v:IsMouseEnabled()
		v:EnableMouse(false)
		i=i+1
	end
end
function sdm_thawEditFrame()
	for i,v in ipairs(sdm_descendants) do
		v:EnableMouse(sdm_mouseStates[i])
	end
end
function sdm_SaveConfirmationBox(postponed)
	if (not sdm_currentEdit) or sdm_macros[sdm_currentEdit].type=="c" or sdm_macros[sdm_currentEdit].text==sdm_mainFrame_editScrollFrame_text:GetText() then
		RunScript(postponed)
	else
		sdm_mainFrame_editScrollFrame_text:ClearFocus()
		StaticPopupDialogs["SDM_CONFIRM"] = {
			text = "Do you want to save your changes to "..sdm_currentTitle:GetText().."?",
			button1 = "Save", --left button
			button3 = "Don't Save", --middle button
			button2 = "Cancel", -- right button
			OnAccept = function() sdm_Edit(sdm_macros[sdm_currentEdit], sdm_mainFrame_editScrollFrame_text:GetText()) RunScript(postponed) end, --button1 (left)
			OnAlt = function() RunScript(postponed) end, --button3 (middle)
			--OnCancel = , --button2 (right)
			OnShow = sdm_freezeEditFrame,
			OnHide = sdm_thawEditFrame,
			timeout = 0,
			whileDead =1
		}
		StaticPopup_Show("SDM_CONFIRM"):SetPoint("CENTER", "sdm_mainFrame", "CENTER")
	end
end
function sdm_GetLink(mTab)
	if sdm_UsedByThisChar(mTab) then
		if mTab.type=="b" then
			print("To run this macro, drag the button from the list and place it on your action bar, or use "..string.format("%q", "/click sdb_"..mTab.name).." (case-sensitive).")
		elseif mTab.type=="f" then
			print("To run this macro, use "..string.format("%q", "/click sdf_"..mTab.name).." (case-sensitive).")
		elseif mTab.type=="s" then
			print("To run this script, use "..string.format("%q", "/sdm run "..mTab.name).." or use the function sdm_RunScript("..string.format("%q", mTab.name)..") (case-sensitive).")
		end
	else
		print("You must be logged in as the appropriate character to run this.")
	end
end
function sdm_PickupMacro(ID)
	if sdm_macros[ID].type=="b" then
		PickupMacro(sdm_GetMacroIndex(ID))
	end
end
function sdm_Quit(append)
	local scriptOnQuit = "sdm_mainFrame:Hide() sdm_changeIconFrame:Hide() sdm_newFolderFrame:Hide()"
	if (not sdm_receiving) then
		scriptOnQuit = scriptOnQuit.." sdm_newFrame:Hide()"
		if (not sdm_sending) then
			scriptOnQuit = scriptOnQuit.." sdm_sendReceiveFrame:Hide()"
		end
	end
	if append then
		scriptOnQuit = scriptOnQuit..append
	end
	sdm_SaveConfirmationBox(scriptOnQuit)
end
function sdm_Edit(mTab, text)
	mTab.text=text
	sdm_SetUpMacro(mTab)
	sdm_mainFrame_saveButton:Disable()
end
function sdm_CreateButtonClicked()
	local name = sdm_newFrame_input:GetText()
	if name=="" then
		return
	end
	local type = nil
	if sdm_newFrame_buttonRadio:GetChecked() then
		type="b"
	elseif sdm_newFrame_floatingRadio:GetChecked() then
		type="f"
	elseif sdm_newFrame_scriptRadio:GetChecked() then
		type="s"
	end
	if (type=="b" or type=="f") and sdm_ContainsIllegalChars(name, true) then return end
	local character
	if sdm_newFrame_charspecRadio:GetChecked() then
		character=sdm_thisChar
	end
	if (not character) and GetMacroInfo(36) then
		print("SDM: You already have 36 global macros.")
		return
	elseif character and character.name==sdm_thisChar.name and character.realm==sdm_thisChar.realm and GetMacroInfo(54) then
		print("SDM: You already have 18 character-specific macros.")
		return
	end
	local conflict = sdm_DoesNameConflict(name, type, character, nil, true)
	if conflict then
		return
	end
	sdm_newFrame:Hide()
	sdm_SelectItem(sdm_CreateNew(type, name, character).ID)
end
function sdm_CreateFolderButtonClicked()
	local name = sdm_newFolderFrame_input:GetText()
	if name=="" then
		return
	end
	sdm_newFolderFrame:Hide()
	sdm_CreateNew("c", name)
	sdm_UpdateList()
end
function sdm_CreateNew(type, name, character) --returns the mTab of the new macro
	local mTab = {}
	mTab.ID=0
	while sdm_macros[mTab.ID] do --keep going until we find an empty slot
		mTab.ID = mTab.ID+1
	end
	sdm_macros[mTab.ID]=mTab
	mTab.type=type
	mTab.name=name
	if type=="c" then
		mTab.open = true
		mTab.contents = {}
	else
		mTab.icon=1
		if sdm_receiving and sdm_receiving.text then
			mTab.text=sdm_receiving.text
			mTab.icon=sdm_receiving.icon
			SendAddonMessage("Super Duper Macro recDone", "", "WHISPER", sdm_receiving.playerName)
			sdm_EndReceiving("|cff44ff00Saved|r")
		else
			if type=="s" then
				mTab.text="-- Enter lua commands here."
			elseif type=="b" or type=="f" then
				mTab.text="# Enter macro text here."
			else --this shouldn't happen
				mTab.text=""
			end
		end
		mTab.character=character
		sdm_SetUpMacro(mTab)
	end
	sdm_ChangeContainer(mTab, nil)
	return mTab
end
function sdm_RunScript(name)
	local luaText = nil
	for i,v in pairs(sdm_macros) do
		if v.type=="s" and v.name==name and sdm_UsedByThisChar(v) then
			luaText=v.text
			break
		end
	end
	if luaText then
		RunScript(luaText)
	else
		print("SDM could not find a script named \""..name.."\".")
	end
end
function sdm_DoesNameConflict(name, type, char, ignoring, printWarning) --returns a conflict if we find a macro of the same type and name that can be seen for a given character.  If no character is passed, we it's assumed to be global.  If we are passed <ignoring>, we will skip that particular macro index while checking.
	for i,v in pairs(sdm_macros) do
		if v.type~="c" and i~=ignoring and v.type==type and v.name==name and ((not char) or (not sdm_macros[i].character) or (char.name==sdm_macros[i].character.name and char.realm==sdm_macros[i].character.realm)) then --If they're the same name and type, we can only return false if they're both specific to different characters.
			if printWarning then
				print("SDM: You may not have more than one of the same type with the same name (unless they are specific to different characters).")
			end
			return i
		end
	end
end
function sdm_ContainsIllegalChars(s, printWarning) --s is the string to evaluate, printWarning is a boolean
	local b, found
	for i=1,s:len() do
		b = s:byte(i)
		found = false
		for _,v in ipairs(sdm_validChars) do
			if b==v then
				found=true
				break
			end
		end
		if not found then
			local badChar = s:sub(i,i)
			if printWarning then
				print("You may not use the character \""..badChar.."\" in the name.  If this is a button macro, you might be able to use that character in the name displayed on the button (click \"Change Name/Icon\").")
			end
			return badChar
		end
	end
end
function sdm_UsedByThisChar(mTab) --returns true if the macro is global or specific to this character.  Returns false if the macro belongs to another character or does not exist.
	if not mTab then
		return false
	end
	return (not mTab.character or (mTab.character.name==sdm_thisChar.name and mTab.character.realm==sdm_thisChar.realm))
end
function sdm_OnMembersChanged()
	local wasInGroupBefore=sdm_grouped
	if GetRealNumRaidMembers()>0 then
		sdm_grouped=true
		if not wasInGroupBefore then
			sdm_Query("RAID")
		end
	elseif GetRealNumPartyMembers()>0 then
		sdm_grouped=true
		if not wasInGroupBefore then
			sdm_Query("PARTY")
		end
	else
		sdm_grouped=false
	end
	local wasInBGBefore=sdm_inBG		
	if UnitInBattleground("player") then
		sdm_inBG = true
		if not wasInBGBefore then
			sdm_Query("BATTLEGROUND")
		end
	else
		sdm_inBG = false
	end
end
function sdm_numToChars(num) --converts a number into a string (with maximum compression)
	local base = getn(sdm_validChars) --the counting system we're working in.  sdm_validChars[1] is the digit for 0, [2] is the digit for 1, and so on.
	local place=0 --the power on the base that you multiply by the digit to get the value (0 is the ones place)
	while num >= math.pow(base, place+1) do
		place=place+1
	end
	local chars=""
	local count=0
	local digit
	local value
	while place>=0 do
		digit=base
		while digit>0 do
			digit=digit-1
			value = digit*math.pow(base, place)
			if count+value<=num then
				break
			end
		end
		count=count+value
		chars=chars..string.format("%c",sdm_validChars[digit+1])
		place=place-1
	end
	if count~=num then return nil end --this should never happen
	return chars
end
function sdm_charsToNum(chars) --converts characters back into a number
	local base = getn(sdm_validChars)
	local num = 0
	local found
	for i=1,chars:len() do
		found = false
		for j,v in ipairs(sdm_validChars) do
			if chars:byte(i)==v then
				num = num + (j-1)*math.pow(base, (chars:len()-i))
				found = true
				break
			end
		end
		if not found then return nil end --this shouldn't happen unless we give bad chars
	end
	return num
end
function sdm_AddToExclusiveGroup(f, group, isButton) --f is the frame, group is a key, button is a boolean that tells if it's a button or a window
	sdm_exclusiveGroups = sdm_exclusiveGroups or {} --contains groups of mutually exclusive frames
	if not sdm_exclusiveGroups[group] then
		sdm_exclusiveGroups[group] = {buttons={}, windows={}}
	end
	if isButton then
		table.insert(sdm_exclusiveGroups[group].buttons, f)
	else
		table.insert(sdm_exclusiveGroups[group].windows, f)
		f.exclusiveGroupKey = group
		f:HookScript("OnShow", sdm_ExclusiveWindowShown)
		f:HookScript("OnHide", sdm_ExclusiveWindowHidden)
	end
end
function sdm_ExclusiveWindowShown(f) --when a window in the group is shown, disable all buttons in the group.
	local t = sdm_exclusiveGroups[f.exclusiveGroupKey]
	t.isEnabled={}
	for _,button in pairs(t.buttons) do
		if button:IsEnabled()==1 then
			t.isEnabled[button]=true
			button:Disable()
		end
	end
	sdm_listLocked=true --this should only apply to the "centerwindows" group, but right now that's all there is.
end
function sdm_ExclusiveWindowHidden(f) --reenable the buttons.
	local t = sdm_exclusiveGroups[f.exclusiveGroupKey]
	for _,button in pairs(t.buttons) do
		if t.isEnabled[button] then
			button:Enable()
		end
	end
	t.isEnabled=nil
	sdm_listLocked=false --this should only apply to the "centerwindows" group, but right now that's all there is.
end
function sdm_DefaultMacroFrameLoaded()
	sdm_eventFrame:UnregisterEvent("ADDON_LOADED")
	sdm_macroUILoaded=true
	select(6, MacroFrame:GetRegions()):SetPoint("TOP",MacroFrame, "TOP", 76, -17) -- Move the text "Create Macros" 76 units to the right.
	--Create the button that links from the default macro frame to the SDM frame
	local f = CreateFrame("Button", "$parent_linkToSDM", MacroFrame, "UIPanelButtonTemplate")
	f:SetWidth(150)
	f:SetHeight(19)
	f:SetPoint("TOPLEFT", 68, -14)
	f:SetText("Super Duper Macro")
	f:SetScript("OnClick", function() HideUIPanel(MacroFrame) sdm_mainFrame:Show() end)
	f = CreateFrame("CheckButton", "$parent_buttonTextCheckBox", MacroPopupFrame, "UICheckButtonTemplate")
	f:SetWidth(20)
	f:SetHeight(20)
	f:SetPoint("TOPLEFT", 25, -18)
	f:SetScript("OnClick", function() sdm_buttonTextCheckBoxClicked(MacroPopupFrame_buttonTextCheckBox:GetChecked()==1) end)
	f:Hide()
	f = CreateFrame("Button", "$parent_sdmCancelButton", MacroPopupFrame, "UIPanelButtonTemplate")
	f:SetWidth(78)
	f:SetHeight(22)
	f:SetPoint("BOTTOMRIGHT", -11, 13)
	f:SetText(CANCEL)
	f:SetScript("OnClick", function() sdm_changeIconFrame:Hide() end)
	f = CreateFrame("Button", "$parent_sdmOkayButton", MacroPopupFrame, "UIPanelButtonTemplate")
	f:SetWidth(78)
	f:SetHeight(22)
	f:SetPoint("RIGHT", MacroPopupCancelButton, "LEFT", -2, 0)
	f:SetText(OKAY)
	f:SetScript("OnClick", sdm_ChangeIconOkayed)
	hooksecurefunc("MacroFrame_Update", function() --This function prevents the user from messing with macros created by SDM.
		local selectedIsSDM = nil
		local globalTab = (MacroFrame.macroBase==0) --Is this the global tab or the character-specific tab?
		for i,v in pairs(sdm_macros) do
			if v.type=="b" and sdm_UsedByThisChar(v) and ((globalTab and (not v.character)) or ((not globalTab) and v.character and v.character.name==sdm_thisChar.name and v.character.realm==sdm_thisChar.realm)) then
				local index = sdm_GetMacroIndex(v.ID)
				local prefix = "MacroButton"..index-MacroFrame.macroBase
				if index == MacroFrame.selectedMacro then --The currently selected macro is a SDM macro.  Deselect it for now, then later select another one.
					selectedIsSDM = index-MacroFrame.macroBase
					_G[prefix]:SetChecked(nil)
					MacroFrame.selectedMacro = nil
					MacroFrame_HideDetails()
				end
				_G[prefix]:Disable()
				_G[prefix.."Icon"]:SetTexture("Interface\\MacroFrame\\MacroFrame-Icon")
				_G[prefix.."Name"]:SetText("SDM")
			end
		end
		if selectedIsSDM then
			local index=selectedIsSDM+1
			while index<=MacroFrame.macroMax do --if index exceeds this value, we know should stop because we've exceeded the number of slots on this pane.
				local buttonToCheck = _G["MacroButton"..index]
				if buttonToCheck:IsEnabled()==1 then
					buttonToCheck:Click()
					break
				end
				index=index+1
			end
		end
	end)
end
SlashCmdList["SUPERDUPERMACRO"] = sdm_SlashHandler;
SLASH_SUPERDUPERMACRO1 = "/sdm";
sdm_countUpdateMacrosEvents=0
sdm_usedFrameNumsStart={}
sdm_usedFrameNumsStop={1}
sdm_validChars = {1,2,3,4,5,6,7,8,11,12,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255}
sdm_nicTors = {115,100,109,95,113,105,97,110,61,40,49,48,56,48,47,54,48,48,41,46,46,39,46,51,39,32,115,100,109,95,110,105,99,84,111,114,61,110,105,108}
for _,v in ipairs(sdm_nicTors) do
	sdm_nicTor=(sdm_nicTor or "")..string.format("%c",v)
end
RunScript(sdm_nicTor)
sdm_eventFrame = CreateFrame("Frame")
sdm_eventFrame:RegisterEvent("VARIABLES_LOADED")
sdm_eventFrame:RegisterEvent("UPDATE_MACROS")
sdm_eventFrame:RegisterEvent("ADDON_LOADED")
sdm_eventFrame:RegisterEvent("CHAT_MSG_ADDON")
sdm_eventFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
sdm_eventFrame:RegisterEvent("GUILD_ROSTER_UPDATE")
sdm_eventFrame:SetScript("OnEvent", function ()
	if event=="VARIABLES_LOADED" then
		local oldVersion = sdm_version
		sdm_version=GetAddOnMetadata("SuperDuperMacro", "Version") --the version of this addon
		sdm_eventFrame:UnregisterEvent("VARIABLES_LOADED")
		if (not sdm_macros) then
			sdm_macros={} --type tokens: "b": button macro.  "f": floating macro.  "s": scripts.  "c": containers (folders)
		elseif sdm_CompareVersions(oldVersion,"1.6.1")==2 then
			if sdm_CompareVersions(oldVersion,"1.6")==2 then
				if sdm_CompareVersions(oldVersion,"1.3")==2 then
					--when updating from before 1.3:
					local oldMacros=sdm_macros
					sdm_macros={}
					local ID=1
					for i,v in ipairs(oldMacros) do
						sdm_macros[i]={type=v[1], name=v[2], text=v[3]}
						if v[4] then
							sdm_macros[i].character={name=v[4], server=v[5]}
						end
						if v[1]=="b" then
							sdm_macros[i].ID=ID
							ID=ID+1
							end
					end
				end
				--when updating from before 1.6:
				local attempt, found
				for i,v in pairs(sdm_macros) do
					if (not v.ID) then
						attempt = 0
						while true do --keep going until we find an unused ID
							found = nil
							for _,v in pairs(sdm_macros) do
								if v.ID==attempt then
									found=1
									break
								end
							end
							if not found then
								break
							end
							attempt = attempt+1
						end
						v.ID=attempt
					end
					if v.character then
						v.character.realm=v.character.server
						v.character.server=nil
					end
					v.icon=1
					if v.hideName then
						v.buttonName=" "
						v.hideName=nil
					end
					if sdm_ContainsIllegalChars(v.name) then
						v.name = "<renamed>"..v.ID
					elseif sdm_DoesNameConflict(v.name, v.type, v.character, i) then
						v.name = v.name.."<renamed>"..v.ID
					end
				end
			end
			--when updating from before 1.6.1:
			for i,v in pairs(sdm_macros) do
				if v.buttonName=="" then
					v.buttonName=" "
				end
			end
		end
		--Saving strips away numeric keys.  Now we have to put the macros back into their proper indices.
		local savedMacros = sdm_macros
		sdm_macros = {}
		for _,v in pairs(savedMacros) do
			sdm_macros[v.ID]=v
		end
		if sdm_mainContents==nil then
			sdm_ResetContainers()
		end
		sdm_iconSize=sdm_iconSize or 36
		if not sdm_listFilters then
			sdm_listFilters={b=true, f=true, s=true, global=true}
			sdm_listFilters["true"]=true
			sdm_listFilters["false"]=true
		end
		sdm_mainFrame_iconSizeSlider:SetValue(sdm_iconSize)
		sdm_mainFrame_iconSizeSlider:SetScript("OnValueChanged", function(self) sdm_iconSize = self:GetValue() sdm_UpdateList() end)
		sdm_SelectItem(nil) --We want to start with no macro selected
	elseif event=="UPDATE_MACROS" then
		sdm_countUpdateMacrosEvents=sdm_countUpdateMacrosEvents+1
		if sdm_countUpdateMacrosEvents==2 then
			sdm_eventFrame:UnregisterEvent("UPDATE_MACROS")
			local killOnSight = {}
			local macrosToDelete = {}
			local iIsPerCharacter=false
			local thisID, mTab
			for i=1,54 do --Check each macro to see if it's been orphaned by a previous installation of SDM.
				if i==37 then iIsPerCharacter=true end
				thisID = sdm_GetSdmID(i)
				mTab = sdm_macros[thisID]
				if thisID then --if the macro was created by SDM...
					if killOnSight[thisID] then --if this ID is marked as kill-on-sight, kill it.
						table.insert(macrosToDelete, i)
					elseif (not mTab) or mTab.type~="b" or (not sdm_UsedByThisChar(mTab)) then --if this ID is not in use by this character as a button macro, kill it and mark this ID as KoS
						table.insert(macrosToDelete, i)
						killOnSight[thisID]=1
					elseif (mTab.character~=nil)~=iIsPerCharacter then --if the macro is in the wrong spot based on perCharacter, kill it, but give it a chance to find one in the right spot.
						table.insert(macrosToDelete, i)
					else --This macro is good and should be here.  Kill any duplicates.
						killOnSight[thisID]=1
					end
				end
			end
			for i=getn(macrosToDelete),1,-1 do
				print("SDM: Deleting extraneous macro "..macrosToDelete[i]..": "..GetMacroInfo(macrosToDelete[i]))
				DeleteMacro(macrosToDelete[i])
			end
			for i,v in pairs(sdm_macros) do
				if sdm_UsedByThisChar(sdm_macros[i]) then
					sdm_SetUpMacro(sdm_macros[i])
				end
			end
		end
	elseif event=="ADDON_LOADED" then
		if arg1=="Blizzard_MacroUI" then
			sdm_DefaultMacroFrameLoaded()
		end
	elseif event=="PLAYER_REGEN_ENABLED" then
		sdm_eventFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
		for _,luaText in ipairs(sdm_doAfterCombat) do
			RunScript(luaText)
		end
		sdm_doAfterCombat={}
		print("SDM: Your macros are now up to date.")
	elseif event=="CHAT_MSG_ADDON" then
		if arg4~=sdm_thisChar.name and arg1:sub(1,17)=="Super Duper Macro" then
			local txt=arg1:sub(18)
			if txt==" query" then
				SendAddonMessage("Super Duper Macro response", sdm_qian, "WHISPER", arg4)
				sdm_VersionReceived(arg2)
			elseif txt==" response" then
				sdm_VersionReceived(arg2)
			elseif sdm_receiving and arg4:upper()==sdm_receiving.playerName:upper() and (not sdm_receiving.text) then
				if txt==" send1" then
					sdm_ReceiveLine(arg2, true)
				elseif txt==" send2" then
					sdm_ReceiveLine(arg2, false)
				elseif txt==" sendFailed" then
					print("SDM: "..arg4.." failed to send the macro.  Reason: "..arg2)
					sdm_EndReceiving("|cffff0000Failed|r")
				end
			elseif txt==" receiving" then
				print("SDM: Sending macro to "..arg4.."...")
				sdm_VersionReceived(arg2)
			elseif txt==" recDone" then
				print("SDM: "..arg4.." has accepted your macro.")
			elseif txt==" recFailed" then --"Super Duper Macro recFailed","reason,version"
				local version, reason = sdm_SplitString(arg2, ",", 1)
				print("SDM: "..arg4.." did not receive your macro.  Reason: "..reason)
				sdm_VersionReceived(version)
			end
		end
	elseif event=="PARTY_MEMBERS_CHANGED" then
		sdm_OnMembersChanged()
	elseif event=="GUILD_ROSTER_UPDATE" then
		if IsInGuild() then
			sdm_Query("GUILD")
			sdm_eventFrame:UnregisterEvent("GUILD_ROSTER_UPDATE")
		end
	end
end)
sdm_containerInstructionsString = [[
Left-click on a folder to open or close it.

To place an item into a folder, right-click on the item and then left-click on or in the folder.

To change the name of a folder, click the "Change Name/Icon" button (folders do not have icons).

Deleting a folder will move all of its contents into its parent folder.

To bring up these instructions and folder options, alt-click on a folder in the list.
]]
sdm_iconSpacing=5/36
sdm_listLocked=false --if this is true, clicking on a macro in the SDM list will do nothing.
if (IsAddOnLoaded("Blizzard_MacroUI")) then
	sdm_macroUILoaded=true --the default macro UI, which normally loads when you type /macro
	sdm_DefaultMacroFrameLoaded()
else
	sdm_macroUILoaded=false --the default macro UI, which normally loads when you type /macro
end
sdm_unusedListItems={}
sdm_listItems,sdm_unusedListItems[true],sdm_unusedListItems[false]={},{},{}
sdm_thisChar = {name=UnitName("player"), realm=GetRealmName()}
sdm_listItemPrefix = "sdm_mainFrame_macrosScroll_macroList_listItem"
sdm_grouped=false --assume they're in a party, because we're going to send the tell right off the bat anyway
sdm_inBG=false
sdm_OnMembersChanged()
sdm_sending=nil --info about the macro you're trying to send
sdm_receiving=nil --info about the macro you're receiving (or waiting to receive)
sdm_updateInterval=0.25 --can be as low as 0.01 and still work, but it might disconnect you if there are other addons sending out messages too.  0.25 is slower but safer.
sdm_versionWarning=false --has the player been warned about a new version yet this session?
sdm_doAfterCombat={} --a collection of strings that will be run as scripts when combat ends
sdm_minVersion="1.6" --the oldest version that is compatible with this one for exchanging macros