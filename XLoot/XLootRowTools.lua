-- Various functions both Group and Monitor share

local _G = getfenv(0)

function XLoot:QualityColorRow(row, quality)
	if quality == "coin" then
		row.border:Hide()
		row.button.border:Hide()
		row:SetBackdropBorderColor(unpack(XLoot.db.profile.lootbordercolor))				
		row.button:SetBackdropBorderColor(unpack(XLoot.db.profile.lootbordercolor))
		row.button.wrapper:SetBackdropBorderColor(unpack(XLoot.db.profile.lootbordercolor))
	else
		local r, g, b, hex = GetItemQualityColor(quality)
		if quality >= XLoot.db.profile.loothighlightthreshold then
			if XLoot.db.profile.texcolor then
				row.button.border:SetVertexColor(r, g, b, .5)
				row.button.border:Show()
			else row.button.border:Hide() end
			if XLoot.db.profile.loothighlightframe and not row.status then
				row.border:SetVertexColor(r, g, b, .3)
				row.border:Show()
			else row.border:Hide() end
		else
			row.button.border:Hide()
			row.border:Hide()
		end
		if XLoot.db.profile.lootqualityborder then
			row:SetBackdropBorderColor(r, g, b, 1)				
			row.button:SetBackdropBorderColor(r, g, b, 1)				
			row.button.wrapper:SetBackdropBorderColor(r, g, b, 1)
		else
			row:SetBackdropBorderColor(unpack(XLoot.db.profile.lootbordercolor))				
			row.button:SetBackdropBorderColor(unpack(XLoot.db.profile.lootbordercolor))
			row.button.wrapper:SetBackdropBorderColor(unpack(XLoot.db.profile.lootbordercolor))
		end
		if row.status then
			row.status:SetStatusBarColor(r, g, b, .7)
		end
	end
end

function XLoot:OnRowClick(button, stack, row, AA)
	if button == "LeftButton" and row.link then
		if ( IsControlKeyDown() ) then
			DressUpItemLink(row.link)
		elseif ( IsShiftKeyDown() ) then
			ChatEdit_InsertLink(row.link)
		else
			ShowUIPanel(ItemRefTooltip)
			if not ItemRefTooltip:IsVisible() then
				ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")
			end
			ItemRefTooltip:SetHyperlink(row.link)
		end
	elseif button == "RightButton" and not IsControlKeyDown() and not IsShiftKeyDown() and row.candismiss then
		AA:PopRow(stack, row.id, nil, nil, 0.3, function() AA:Restack(stack) end)
	end
end

function XLoot:SizeRow(stack, row)
	local row = row
	local playerwidth, lootwidth, rollswidth, bindwidth = row.fsplayer:GetStringWidth(), row.fsloot:GetStringWidth(), (row.bgreed and XLootGroup.db.profile.buttonscale or 0), (row.fsbind and row.fsbind:GetStringWidth() or 0)
	local framewidth = (playerwidth > 0 and playerwidth+37 or -11)+lootwidth+(rollswidth*4)+bindwidth -- rollswidth*4 patch 3.3 disenchant button.
	row:SetWidth(framewidth+0+(row.sizeoffset or 0))--38
	XLoot:QualityBorderResize(row, 1.76, 1.34, 2, 1)
end


function XLoot:GenericItemRow(stack, id, AA)
	local row = CreateFrame("Frame", "XLRow"..stack.name..id, UIParent)
	local button = CreateFrame("Button", "XLRowButton"..stack.name..id, row, "ItemButtonTemplate")
	button:EnableMouse(false)
	_G[button:GetName().."NormalTexture"]:SetWidth(66)
	_G[button:GetName().."NormalTexture"]:SetHeight(66)
	local overlay = CreateFrame("Button", "XLMonitorRowOverlay"..stack.name..id, row)
	row.overlay = overlay

	row.fsplayer = row:CreateFontString("XLRow"..stack.name..id.."Player", "ARTWORK", "GameFontNormalSmall")
	row.fsloot = row:CreateFontString("XLRow"..stack.name..id.."Loot", "ARTWORK", "GameFontNormalSmall")
	row.fsextra = row:CreateFontString("XLRow"..stack.name..id.."Extra", "ARTWORK", "GameFontNormalSmall")

	row:SetWidth(316)
	row:SetHeight(22)
	button:SetScale(.55)
	button:ClearAllPoints()
	button:SetPoint("LEFT", row, "LEFT", 5, 0)
	button:Disable()
	overlay:ClearAllPoints()
	overlay:SetAllPoints(row)
	row.fsplayer:SetHeight(16)
	row.fsloot:SetHeight(16)
	row.fsplayer:ClearAllPoints()
	row.fsplayer:SetPoint("LEFT", button, "RIGHT", 3, 0)
	row.fsloot:ClearAllPoints()
	row.fsloot:SetPoint("LEFT", row.fsplayer, "RIGHT", 2, 0)
	row.fsplayer:SetJustifyH("LEFT")
	row.fsloot:SetJustifyH("LEFT")
	row.fsextra:SetHeight(16)
	row.fsextra:ClearAllPoints()
	row.fsextra:SetPoint("RIGHT", button, "LEFT")
	row.fsextra:SetJustifyH("RIGHT")
	
	overlay:RegisterForDrag("LeftButton")
	overlay:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	overlay:SetScript("OnDragStart", function() AA:DragStart(stack, row) end)
	overlay:SetScript("OnDragStop", function() AA:DragStop(stack, row) end)
	overlay:SetScript("OnClick", function(self,arg1) XLoot:OnRowClick(arg1, stack, row, AA) end)
	overlay:SetScript("OnEnter", function(self) 
		if row.link then 
			GameTooltip:SetOwner(row, "ANCHOR_TOPLEFT")
			GameTooltip:SetHyperlink(row.link) 
			if IsShiftKeyDown() then 
				GameTooltip_ShowCompareItem() 
			end 
			CursorUpdate(self); 
		end 
	end )
	overlay:SetScript("OnHide", function() AA:OnRowHide(stack, row) end)
	overlay:SetScript("OnLeave", function() GameTooltip:Hide(); ResetCursor(); end)
	overlay:SetScript("OnUpdate", function(self) 
		if IsShiftKeyDown() then 
			GameTooltip_ShowCompareItem() 
		end 
		CursorOnUpdate(self); 
	end)
	
	button.wrapper = XLoot:ItemButtonWrapper(button, 9, 9, 20)
	row.border = XLoot:QualityBorder(row)
	button.border = XLoot:QualityBorder(button.wrapper)
	XLoot:QualityBorderResize(button.wrapper, 1.6, 1.6, 0, 1)
	button:Show()
	button:SetAlpha(1)
	
	XLoot:Skin(row)
	
	row.candismiss = true
	row.sizeoffset = 0
	
	row.button = button
	row.id = id
	
	row:Hide()
	stack.rows[id] = row
	
	stack.built = table.getn(stack.rows)
	return row
end