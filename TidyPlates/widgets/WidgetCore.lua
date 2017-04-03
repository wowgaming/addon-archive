--[[
Yep, that's all there is to it... haha
--]]

TidyPlatesWidgets = {}

----------------------
-- HideIn() - Registers a callback, which hides the specified frame in X seconds
----------------------
do
		-- table constructions cause heap allocation; reuse tables
	local Framelist = {}			-- Key = Frame, Value = Expiration Time
	local Watcherframe = CreateFrame("Frame")
	local WatcherframeActive = false
	local select = select
	local timeToUpdate = 0
	
	local function CheckFramelist(self)
		local curTime = GetTime()
		if curTime < timeToUpdate then return end
		local framecount = 0
		timeToUpdate = curTime + 1
		-- Cycle through the watchlist, hiding frames which are timed-out
		for frame, expiration in pairs(Framelist) do
			if expiration < curTime then frame:Hide(); Framelist[frame] = nil
			else framecount = framecount + 1 end
		end
		-- If no more frames to watch, unregister the OnUpdate script
		if framecount == 0 then Watcherframe:SetScript("OnUpdate", nil) end
	end
	
	function TidyPlatesWidgets:HideIn(frame, expiration)
		-- Register Frame
		Framelist[ frame] = expiration
		-- Init Watchframe
		if not WatcherframeActive then 
			Watcherframe:SetScript("OnUpdate", CheckFramelist)
			WatcherframeActive = true
		end
	end
	
end


----------------------
-- Multi-Purpose Mouseover Frame
----------------------
do
	local function UpdateMouseoverWidget(frame, unit)
		local unitid
		if unit.reaction == "FRIENDLY" or (not InCombatLockdown()) then frame:Hide(); return end
		if unit.isTarget then unitid = "target"
		elseif unit.isMouseover then unitid = "mouseover" end

		if unitid then
			frame.FadeTime = GetTime() + 2
			frame:HideIn(frame.FadeTime)
			frame:Show()
		elseif (GetTime() > frame.FadeTime) then frame:Hide() end
	end

	local function CreateMouseoverWidget(parent)		
		local frame = CreateFrame("Frame", nil, parent)
		frame.FadeTime = 0
		frame.HideIn = TidyPlatesWidgets.HideIn
		frame.Update = UpdateMouseoverWidget
		frame:Hide()
		return frame
	end
	
	TidyPlatesWidgets.CreateMouseoverWidget = CreateMouseoverWidget
end


do
	local plate, plateIndex, WorldFrameChildren, WidgetChildren, widgetIndex
	local function ResetWidgets()
		WorldFrameChildren = {WorldFrame:GetChildren()}
		for plateIndex = 1, #WorldFrameChildren do
			plate = WorldFrameChildren[plateIndex]
			if plate.extended and plate.extended.widgets then
				for widgetIndex, widget in pairs(plate.extended.widgets) do
					--print("Removing Widget", plate, widgetIndex, widget)
					-- if is-widget
					widget:Hide()
					--widget:SetParent(nil)
					--
					plate.extended.widgets[widgetIndex] = nil
				end
			end
		end
	end
	TidyPlatesWidgets.ResetWidgets = ResetWidgets
end
		


