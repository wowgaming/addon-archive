local Combo = {}
ShadowUF:RegisterModule(Combo, "comboPoints", ShadowUF.L["Combo points"])

function Combo:OnEnable(frame)
	frame.comboPoints = frame.comboPoints or CreateFrame("Frame", nil, frame)
	frame:RegisterNormalEvent("UNIT_COMBO_POINTS", self, "Update")
	frame:RegisterUpdateFunc(self, "Update")
end

function Combo:OnLayoutApplied(frame, config)
	-- Not a bar so set the containers frame configuration
	if( config.comboPoints and not config.comboPoints.isBar ) then
		ShadowUF.Layout:ToggleVisibility(frame.comboPoints, frame.visibility.comboPoints)
	end
	
	if( not frame.visibility.comboPoints ) then	return end
	
	-- Hide the active combo points
	if( frame.comboPoints.points ) then
		for _, texture in pairs(frame.comboPoints.points) do
			texture:Hide()
		end
	end
	
	-- Setup for bar display!
	if( config.comboPoints.isBar ) then
		frame.comboPoints.blocks = frame.comboPoints.blocks or {}
		frame.comboPoints.points = frame.comboPoints.blocks
	
		-- Position bars, the 5 accounts for borders
		local blockWidth = (frame.comboPoints:GetWidth() - 4 ) / MAX_COMBO_POINTS
		for id=1, MAX_COMBO_POINTS do
			frame.comboPoints.blocks[id] = frame.comboPoints.blocks[id] or frame.comboPoints:CreateTexture(nil, "OVERLAY")
			local texture = frame.comboPoints.blocks[id]
			texture:SetVertexColor(1, 0.80, 0)
			texture:SetHorizTile(false)
			texture:SetTexture(ShadowUF.Layout.mediaPath.statusbar)
			texture:SetHeight(frame.comboPoints:GetHeight())
			texture:SetWidth(blockWidth)
			texture:ClearAllPoints()
			
			if( config.comboPoints.growth == "LEFT" ) then
				if( id > 1 ) then
					texture:SetPoint("TOPRIGHT", frame.comboPoints.blocks[id - 1], "TOPLEFT", -1, 0)
				else
					texture:SetPoint("TOPRIGHT", frame.comboPoints, "TOPRIGHT", 0, 0)
				end
			else
				if( id > 1 ) then
					texture:SetPoint("TOPLEFT", frame.comboPoints.blocks[id - 1], "TOPRIGHT", 1, 0)
				else
					texture:SetPoint("TOPLEFT", frame.comboPoints, "TOPLEFT", 0, 0)
				end
			end
		end

	-- guess not, will have to do icons :(
	else
		local point, relativePoint
		local x, y = 0, 0
		
		if( config.comboPoints.growth == "LEFT" ) then
			point, relativePoint = "BOTTOMRIGHT", "BOTTOMLEFT"
			x = config.comboPoints.spacing
		elseif( config.comboPoints.growth == "RIGHT" ) then
			point, relativePoint = "BOTTOMLEFT", "BOTTOMRIGHT"
			x = config.comboPoints.spacing
		elseif( config.comboPoints.growth == "UP" ) then
			point, relativePoint = "BOTTOMLEFT", "TOPLEFT"
			y = config.comboPoints.spacing
		elseif( config.comboPoints.growth == "DOWN" ) then
			point, relativePoint = "TOPLEFT", "BOTTOMLEFT"
			y = config.comboPoints.spacing
		end
		

		frame.comboPoints.icons = frame.comboPoints.icons or {}
		frame.comboPoints.points = frame.comboPoints.icons
		
		for id=1, MAX_COMBO_POINTS do
			frame.comboPoints.icons[id] = frame.comboPoints.icons[id] or frame.comboPoints:CreateTexture(nil, "OVERLAY")
			local texture = frame.comboPoints.icons[id]
			texture:SetTexture("Interface\\AddOns\\ShadowedUnitFrames\\media\\textures\\combo")
			texture:SetHeight(config.comboPoints.size)
			texture:SetWidth(config.comboPoints.size)
			
			if( id > 1 ) then
				texture:ClearAllPoints()
				texture:SetPoint(point, frame.comboPoints.icons[id - 1], relativePoint, x, y)
			else
				texture:ClearAllPoints()
				texture:SetPoint("CENTER", frame.comboPoints, "CENTER", 0, 0)
			end
		end
		
		-- Position the main frame
		frame.comboPoints:SetHeight(0.1)
		frame.comboPoints:SetWidth(0.1)

		ShadowUF.Layout:AnchorFrame(frame, frame.comboPoints, config.comboPoints)
	end
end

function Combo:OnDisable(frame)
	frame:UnregisterAll(self)
end

function Combo:Update(frame)
	-- For Malygos dragons, they also self cast their CP on themselves, which is why we check CP on ourself!
	local playerUnit = UnitHasVehicleUI("player") and "vehicle" or "player"
	local points = GetComboPoints(playerUnit)
	if( points == 0 ) then
		points = GetComboPoints(playerUnit, playerUnit)
	end
	
	-- Bar display, hide it if we don't have any combo points
	if( ShadowUF.db.profile.units[frame.unitType].comboPoints.isBar ) then
		ShadowUF.Layout:SetBarVisibility(frame, "comboPoints", points > 0)
	end
	
	for id, pointTexture in pairs(frame.comboPoints.points) do
		if( id <= points ) then
			pointTexture:Show()
		else
			pointTexture:Hide()
		end
	end
end
