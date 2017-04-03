--This file contains code that is adapted from ChatFrame.lua

local funcsToGetSpell = {} -- Analoguous to SecureCmdList in ChatFrame.lua

funcsToGetSpell["CAST"] = function(msg)
    local action, target = SecureCmdOptionParse(msg);
    if ( action ) then
		local name, bag, slot = SecureCmdItemParse(action);
		if ( slot or GetItemInfo(name) ) then
			return "item", name, target, bag, slot
		else
			return "spell", action, target
		end
    end
end
funcsToGetSpell["USE"] = funcsToGetSpell["CAST"];

funcsToGetSpell["CASTRANDOM"] = function(msg)
    local actions, target = SecureCmdOptionParse(msg);
	if ( actions ) then
		local action = strtrim(strsplit(",", actions)); --took out GetRandomArgument because the icon always shows the first spell
		local name, bag, slot = SecureCmdItemParse(action);
		if ( slot or GetItemInfo(name) ) then
			return "item", name, target, bag, slot
		else
			return "spell", action, target
		end
	end
end
funcsToGetSpell["USERANDOM"] = funcsToGetSpell["CASTRANDOM"];

funcsToGetSpell["CASTSEQUENCE"] = function(msg)
	local sequence, target = SecureCmdOptionParse(msg);
	if ( sequence ) then
		local _,item,spell = QueryCastSequence(sequence)
		if spell then
			return "spell", spell, target
		elseif item then
			return "item", item, target
		end
	end
end

funcsToGetSpell["EQUIP"] = function(msg)
	local item = SecureCmdOptionParse(msg);
	if ( item ) then
		local name, bag, slot = SecureCmdItemParse(item)
		return "item", name, nil, bag, slot --name may be in the format "<name>", "item:<ID>", or an itemlink
	end
end

funcsToGetSpell["EQUIP_TO_SLOT"] = function(msg)
	local action = SecureCmdOptionParse(msg);
	if ( action ) then
		local slot, item = strmatch(action, "^(%d+)%s+(.*)");
		if ( item ) then
			local name, bag, slot = SecureCmdItemParse(item)
			return "item", name, nil, bag, slot
		end
	end
end

--[[SecureCmdList["STOPMACRO"] = function(msg) --this command doesn't affect the icon, but I think it should!
	if not ( SecureCmdOptionParse(msg) ) then
		return true
	end
end]]

--[[funcsToGetSpell["CLICK"] = function(msg)
	local action = SecureCmdOptionParse(msg);
	if ( action and action ~= "" ) then
		local name, mouseButton, down = strmatch(action, "([^%s]+)%s+([^%s]+)%s*(.*)");
		if ( not name ) then
			name = action;
		end
		local button = GetClickFrame(name);
		if ( button and button:IsObjectType("Button") ) then
			if button:GetAttribute("type")=="macro" then
				local text = button:GetAttribute("macrotext")
				if text then
					return sdm_GetMacrotextSpell(text, mouseButton, down)
				end
			end
		end
	end
end]]

sdm_importantSlashHash = {} -- Analoguous to hash_SecureCmdList in ChatFrame.lua. Keys are slash commands that should not be ignored when getting a macro's icon.  Values are functions that return the spell or item.
for index, value in pairs(funcsToGetSpell) do
	local i = 1;
	local cmdString = _G["SLASH_"..index..i];
	while ( cmdString ) do
		cmdString = strupper(cmdString);
		sdm_importantSlashHash[cmdString] = value;	-- add to hash
		i = i + 1;
		cmdString = _G["SLASH_"..index..i];
	end
end

function sdm_GetMacrotextAction(multiLineText) -- Input & calculations are adapted from ChatEdit_ParseText in ChatFrame.lua, and output is a combination of GetMacroSpell and GetMacroItem.
	local show, showtooltip
	for text in multiLineText:gmatch("[^\r\n]+") do -- <text> is a single line of the macro
		if ( strlen(text) > 0 ) then
			--deal with #show and #showtooltip
			local showtxt, showcmd = sdm_SplitString(text:trim(), " ", 1)
			if showcmd then
				showcmd = showcmd:lower()
				if showcmd:sub(1,5)=="#show" then
					show=1
					if showcmd:sub(1,12)=="#showtooltip" then
						showtooltip=1
					end
					text = "/cast "..showtxt
				end
			end
			--get the info from the line
			if ( strsub(text, 1, 1) == "/" ) then
				local command = strmatch(text, "^(/[^%s]+)") or "";
				local msg = "";
				if ( command ~= text ) then
					msg = strsub(text, strlen(command) + 2);
				end
				command = strupper(command);
				if sdm_importantSlashHash[command] then
					--return the info.  If no info, move on to the next line.
					local type,name,target,bag,slot = sdm_importantSlashHash[command](strtrim(msg))
					local nameReturn, otherReturn
					if type then
						if not name then return end
						if type=="spell" then
							nameReturn, otherReturn = GetSpellName(name)
							if not nameReturn then
								for _,companionType in pairs({"MOUNT", "CRITTER"}) do
									for i=1,GetNumCompanions(companionType) do
										local _, thisname = GetCompanionInfo(companionType, i)
										if thisname==name then
											nameReturn = thisname
											otherReturn = ""
											break
										end
									end
								end
							end
							if not nameReturn then return end
						elseif type=="item" then
							nameReturn = GetItemInfo(name)
							if not nameReturn then return end
							-- this part mimics SecureCmdUseItem in ChatFrame.lua
							if bag then
								otherReturn = GetContainerItemLink(bag, slot)
							elseif slot then
								otherReturn = GetInventoryItemLink("player", slot)
							else
								-- this part may or may not be necessary, but it produces the exact numbers within the item link from GetMacroItem
								for i=0,23 do
									local link = GetInventoryItemLink("player",i)
									if link and link:sub(link:find("%[")+1,link:find("\]")-1)==nameReturn then
										otherReturn = link
										break
									end
								end
								if not otherReturn then
									for i=-2,11 do
										for j=1,GetContainerNumSlots(i) do
											local link = GetContainerItemLink(i,j)
											if link and link:sub(link:find("%[")+1,link:find("\]")-1)==nameReturn then
												otherReturn = link
												break
											end
										end
									end
								end
							end
							if not otherReturn then _,otherReturn = GetItemInfo(name) end
						end
						return type, nameReturn, otherReturn, target, show, showtooltip
					end
				end
			end
		end
	end
end

function sdm_CompareFuncs()
	local result
	for i=1,54 do
		local body = GetMacroBody(i)
		if  body then
			local a1,a2,a3,b1,b2,b3
			b1,b2,b3 = sdm_GetMacrotextAction(body)
			a2,a3 = GetMacroSpell(i)
			if a2 then
				a1 = "spell"
			else
			a2,a3 = GetMacroItem(i)
				if a2 then
					a1 = "item"
				end
			end
			if a1~=b1 or a2~=b2 or a3~=b3 then
				result = (result or "ver: "..sdm_version.."\n\n").."body: "..body.."\nBlizz got: "..(a1 or "<nil>").." "..(a2 or "<nil>").." "..(a3 or "<nil>").."\nYou got: "..(b1 or "<nil>").." "..(b2 or "<nil>").." "..(b3 or "<nil>").."\n\n"
			end
		end
	end
	if result then
		local f = getglobal("sdm_testResultFrame")
		if not f then
			f = CreateFrame("Frame", "SDM_testResultFrame", UIParent)
			f:SetWidth(300)
			f:SetHeight(300)
			f:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",tile = true,tileSize = 32,edgeSize = 32,insets = {left = 11,right = 11,top = 12,bottom = 10}})
			f:SetPoint("CENTER")
			f.close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
			f.close:SetPoint("TOPRIGHT",-10,-10)
			f.close:SetScript("OnClick", function() f:Hide() end)
			f.scroll = CreateFrame("ScrollFrame", "sdm_sillyName", f, "UIPanelScrollFrameTemplate")
			f.box = CreateFrame("EditBox", nil, f)
			f.scroll:SetScrollChild(box)
			f.scroll:SetHeight(100)
			f.scroll:SetWidth(100)
			f.scroll:SetPoint("BOTTOM")
			f.box:SetHeight(100)
			f.box:SetWidth(100)
			f.box:SetFontObject("GameFontHighlightSmall")
			f.box:SetMultiLine(1)
			f.box:SetScript("OnTextChanged", function(self) if self:GetText()~=result then self:SetText(result) end self:HighlightText() end)
			f.box:SetScript("OnCursorChanged", f.box.HighlightText)
			f.box:SetScript("OnEditFocusLost", function(self) self:SetFocus() self:HighlightText() end)
			f.text = f:CreateFontString(nil, "ARTWORK", "GameFontNormal")
			f.text:SetPoint("TOPLEFT",20,-30)
			f.text:SetPoint("BOTTOMRIGHT",-20,20)
			f.text:SetJustifyH("TOP")
			f.text:SetText("Press ctrl-C or cmd-C to copy the selected text below (it's selected right now, even if you can't see it). Kindly head over to wowinterface.com and paste the text into a comment. Thanks!")
		end
		f:Show()
		f.box:SetText(result)
	else
		print("SDM test result: All correct!")
	end
end

--now, hook the events that update the action buttons