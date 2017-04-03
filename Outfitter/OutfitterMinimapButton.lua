function Outfitter.MinimapButton_MouseDown(self)
	-- Remember where the cursor was in case the user drags
	
	local vCursorX, vCursorY = GetCursorPosition()
	
	vCursorX = vCursorX / self:GetEffectiveScale()
	vCursorY = vCursorY / self:GetEffectiveScale()
	
	OutfitterMinimapButton.CursorStartX = vCursorX
	OutfitterMinimapButton.CursorStartY = vCursorY
	
	local vCenterX, vCenterY = OutfitterMinimapButton:GetCenter()
	local vMinimapCenterX, vMinimapCenterY = Minimap:GetCenter()
	
	OutfitterMinimapButton.CenterStartX = vCenterX - vMinimapCenterX
	OutfitterMinimapButton.CenterStartY = vCenterY - vMinimapCenterY
	
	OutfitterMinimapButton.EnableFreeDrag = IsModifierKeyDown()
end

function Outfitter.MinimapButton_DragStart(self)
	Outfitter.SchedulerLib:ScheduleUniqueRepeatingTask(0, Outfitter.MinimapButton_UpdateDragPosition, self)
end

function Outfitter.MinimapButton_DragEnd(self)
	Outfitter.SchedulerLib:UnscheduleTask(Outfitter.MinimapButton_UpdateDragPosition, self)
end

function Outfitter.MinimapButton_UpdateDragPosition(self)
	-- Remember where the cursor was in case the user drags
	
	local vCursorX, vCursorY = GetCursorPosition()
	
	vCursorX = vCursorX / self:GetEffectiveScale()
	vCursorY = vCursorY / self:GetEffectiveScale()
	
	local vCursorDeltaX = vCursorX - OutfitterMinimapButton.CursorStartX
	local vCursorDeltaY = vCursorY - OutfitterMinimapButton.CursorStartY
	
	--
	
	local vCenterX = OutfitterMinimapButton.CenterStartX + vCursorDeltaX
	local vCenterY = OutfitterMinimapButton.CenterStartY + vCursorDeltaY
	
	if OutfitterMinimapButton.EnableFreeDrag then
		Outfitter.MinimapButton_SetPosition(vCenterX, vCenterY)
	else
		-- Calculate the angle and set the new position
		
		local vAngle = math.atan2(vCenterX, vCenterY)
		
		Outfitter.MinimapButton_SetPositionAngle(vAngle)
	end
end

function Outfitter:RestrictAngle(pAngle, pRestrictStart, pRestrictEnd)
	if pAngle <= pRestrictStart
	or pAngle >= pRestrictEnd then
		return pAngle
	end
	
	local vDistance = (pAngle - pRestrictStart) / (pRestrictEnd - pRestrictStart)
	
	if vDistance > 0.5 then
		return pRestrictEnd
	else
		return pRestrictStart
	end
end

function Outfitter.MinimapButton_SetPosition(pX, pY)
	gOutfitter_Settings.Options.MinimapButtonAngle = nil
	gOutfitter_Settings.Options.MinimapButtonX = pX
	gOutfitter_Settings.Options.MinimapButtonY = pY
	
	OutfitterMinimapButton:SetPoint("CENTER", Minimap, "CENTER", pX, pY)
end

function Outfitter.MinimapButton_SetPositionAngle(pAngle)
	local vAngle = pAngle
	
	-- Restrict the angle from going over the date/time icon or the zoom in/out icons
	--[[
	local vRestrictedStartAngle = nil
	local vRestrictedEndAngle = nil
	
	if GameTimeFrame:IsVisible() then
		if MinimapZoomIn:IsVisible()
		or MinimapZoomOut:IsVisible() then
			vAngle = Outfitter:RestrictAngle(vAngle, 0.4302272732931596, 2.930420793963121)
		else
			vAngle = Outfitter:RestrictAngle(vAngle, 0.4302272732931596, 1.720531504573905)
		end
		
	elseif MinimapZoomIn:IsVisible()
	or MinimapZoomOut:IsVisible() then
		vAngle = Outfitter:RestrictAngle(vAngle, 1.720531504573905, 2.930420793963121)
	end
	
	-- Restrict it from the tracking icon area
	
	vAngle = Outfitter:RestrictAngle(vAngle, -1.290357134304173, -0.4918423429923585)
	]]--
	
	--
	
	local vRadius = 80
	
	vCenterX = math.sin(vAngle) * vRadius
	vCenterY = math.cos(vAngle) * vRadius
	
	OutfitterMinimapButton:SetPoint("CENTER", Minimap, "CENTER", vCenterX - 1, vCenterY - 1)
	
	gOutfitter_Settings.Options.MinimapButtonAngle = vAngle
end

function Outfitter.MinimapButton_ItemSelected(pMenu, pValue)
	if type(pValue) == "table" then
		local vCategoryID = pValue.CategoryID
		local vIndex = pValue.Index
		local vOutfit = gOutfitter_Settings.Outfits[vCategoryID][vIndex]
		local vDoToggle = vCategoryID ~= "Complete"
		
		if vDoToggle
		and Outfitter:WearingOutfit(vOutfit) then
			Outfitter:RemoveOutfit(vOutfit)
		else
			Outfitter:WearOutfit(vOutfit)
		end
		
		if vDoToggle then
			return true
		end
	elseif pValue == 0 then -- Open Outfitter
		Outfitter:OpenUI()
	elseif pValue == -1 then -- Change AutoSwitch Value.
		Outfitter:SetAutoSwitch(gOutfitter_Settings.Options.DisableAutoSwitch)
		return true
	end

	return false
end

