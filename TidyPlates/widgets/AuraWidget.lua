--[[
	- Debuffs shorter than 31 seconds
	- Debuffs equal or shorter than 2 min
	- Under 4 second remaining, increase scale?
--]]

local UnitBuffs = {}
local UnitDebuffs = {}
local UnitAuras = {}
local GUID = TidyPlates.GUID

--[[
	GUID.SpellID
	Debuffs; Updates via
--]]


--[[
local events = {}
local function AuraOnEvent(frame, event, ...) 
	--print(event)
	events[event](...) 
end

function events:COMBAT_LOG_EVENT_UNFILTERED(...) 
	-- http://www.wowwiki.com/API_COMBAT_LOG_EVENT
	local event, sourceguid, destguid, spellid, auratype, _
	event, sourceguid, _, _, destguid, _, _, spellid, _, _, auratype = ...
	--print(event, sourceguid, destguid, spellid, auratype)
	--if events[event] then addon[event]( self, ... ) end
end

local AuraWatcher = CreateFrame("Frame")
AuraWatcher:SetScript("OnEvent", AuraOnEvent)
for eventname in pairs(events) do AuraWatcher:RegisterEvent(eventname) end	
--]]
---------------
-- Aura Widgets
---------------
local aurafont = "Interface\\Addons\\TidyPlates\\Media\\LiberationSans-Regular.ttf"
--local aurafont =					"FONTS\\arialn.ttf"

----------------------
-- PolledHideIn() - Registers a callback, which polls the frame until it expires, then hides the frame and removes the callback
----------------------
local PolledHideIn
do
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
			-- If expired...
			--print("Exp", expiration)
			if expiration < curTime then frame:Hide(); Framelist[frame] = nil
			-- If active...
			else 
				-- Update the frame
				frame:Update(expiration)
				framecount = framecount + 1 
			end
		end
		-- If no more frames to watch, unregister the OnUpdate script
		if framecount == 0 then Watcherframe:SetScript("OnUpdate", nil); WatcherframeActive = false end
	end
	
	function PolledHideIn(frame, expiration)
		if expiration == 0 then 
			frame:Hide()
			Framelist[ frame] = nil
		else
			Framelist[frame] = expiration
			frame:Show()
			
			if not WatcherframeActive then 
				Watcherframe:SetScript("OnUpdate", CheckFramelist)
				WatcherframeActive = true
			end
		end
	end
end

----------------------
-- Debuff Frame
----------------------
do
	local AuraWatcher = CreateFrame("Frame", nil, WorldFrame )
	local isEnabled = false
	
	local function AuraWatcherHandler(frame, event, unitid)
		if unitid == "target" then TidyPlates:Update() end
		if event == "UNIT_SPELLCAST_SUCCEEDED" then TidyPlates:Update() end
	end
	
	local function EnableAuraWatcher(arg)
		if arg then AuraWatcher:SetScript("OnEvent", AuraWatcherHandler)
			AuraWatcher:RegisterEvent("UNIT_AURA")
			AuraWatcher:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
			isEnabled = true
		else AuraWatcher:SetScript("OnEvent", nil) 
			AuraWatcher:UnregisterEvent("UNIT_AURA")
			AuraWatcher:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
			isEnabled = false
		end
	end
	
	
	
	-- Individual Aura Frame
	local function UpdateAuraFrame(frame, expiration)
		local timeleft = expiration-GetTime()
		local green, yellow, red = "|cFF84FF00", "|cFFFFB400", "|cFFFF0000"
		local textcolor
		if timeleft > 60 then frame.TimeLeft:SetText(green..ceil(timeleft/60).."m")
		else 
			if timeleft < 3 then textcolor = red 
			elseif timeleft < 5 then textcolor = yellow
			else textcolor = green end
			frame.TimeLeft:SetText(textcolor..ceil(timeleft)) 
		end
		-- This is where the text gets changed, coloring, and any scaling gets done
	end

	local AuraBorderArt = "Interface\\AddOns\\TidyPlates\\widgets\\Aura\\AuraFrame"				-- FINISH ART
	local AuraGlowArt = "Interface\\AddOns\\TidyPlates\\widgets\\Aura\\AuraGlow"	
	local AuraTestArt = ""
	
	local function CreateAuraFrame(parent)
		local frame = CreateFrame("Frame", nil, parent)
		frame:SetWidth(26); frame:SetHeight(14)
		
		-- Icon
		frame.Icon = frame:CreateTexture(nil, "BACKGROUND")
		--frame.Icon:SetTexture("Interface\\Icons\\Spell_Shaman_StormEarthFire")
		frame.Icon:SetAllPoints(frame)
		--frame.Icon:SetTexCoord(.07, 1-.07, .23, 1-.23)  -- obj:SetTexCoord(left,right,top,bottom)
		frame.Icon:SetTexCoord(.07, 1-.07, .23, 1-.23)  -- obj:SetTexCoord(left,right,top,bottom)
		-- Border
		frame.Border = frame:CreateTexture(nil, "ARTWORK")
		frame.Border:SetWidth(32); frame.Border:SetHeight(32)
		frame.Border:SetPoint("CENTER", 1, -2)
		frame.Border:SetTexture(AuraBorderArt)
		-- Glow
		--frame.Glow = frame:CreateTexture(nil, "ARTWORK")
		--frame.Glow:SetAllPoints(frame.Border)
		--frame.Glow:SetTexture(AuraGlowArt)
		--  [[ Time Text
		frame.TimeLeft = frame:CreateFontString(nil, "OVERLAY")
		frame.TimeLeft:SetFont(aurafont,9, "OUTLINE")
		frame.TimeLeft:SetShadowOffset(1, -1)
		frame.TimeLeft:SetShadowColor(0,0,0,1)
		frame.TimeLeft:SetPoint("RIGHT", 0, 8)
		frame.TimeLeft:SetWidth(26)
		frame.TimeLeft:SetHeight(16)
		frame.TimeLeft:SetJustifyH("RIGHT")
		--  [[ Stacks
		frame.Stacks = frame:CreateFontString(nil, "OVERLAY")
		frame.Stacks:SetFont(aurafont,10, "OUTLINE")
		frame.Stacks:SetShadowOffset(1, -1)
		frame.Stacks:SetShadowColor(0,0,0,1)
		frame.Stacks:SetPoint("RIGHT", 0, -6)
		frame.Stacks:SetWidth(26)
		frame.Stacks:SetHeight(16)
		frame.Stacks:SetJustifyH("RIGHT")
		--]]
		-- Done
		frame.PolledHideIn = PolledHideIn
		
		frame.Update = UpdateAuraFrame
		frame:Hide()
		--frame:Show()
		return frame
	end
	
	local DebuffColor = {
		Magic	= { r = 0.20, g = 0.60, b = 1.00 },
		Curse	= { r = 0.60, g = 0.00, b = 1.00 },
		Disease = { r = 0.60, g = 0.40, b = 0 },
		Poison = { r = 0.00, g = 0.60, b = 0 },
	}
	
	local function GetDebuffColor(dispellType)
		local color = DebuffColor[dispellType]
		if color then return color.r, color.g, color.b 
		else return 0,0,0,0 end
	end
	
	--local auraDurationFilter = 36
	local auraDurationFilter = 600
	local function DefaultFilterFunction(debuff) 
		return (debuff.duration < auraDurationFilter)	
	end
	
	local aura = {}
	
	local function UpdateAuraWidget(frame, unit)	
		local unitid, expireTime
		local AuraFrames = frame.AuraFrames
		local AuraFrame
		local auraCount = 0
		
		if unit.isTarget then unitid = "target"
		elseif unit.isMouseover then unitid = "mouseover" end
		
		if not unit.guid then
			for index = 1, 4 do	AuraFrame = AuraFrames[index]; AuraFrame:Hide() end
		elseif unitid and unit.guid == UnitGUID(unitid) then
			-- Display the desired debuffs
		
			for index = 1, 40 do
				local name, rank, icon, count, dispelType, duration, expires, caster, isStealable = UnitDebuff(unitid, index ,"PLAYER")
				
				aura.name, aura.rank, aura.icon, aura.count = name, rank, icon, count
				aura.dispelType, aura.duration, aura.expires, aura.caster = dispelType, duration, expires, caster
				
				AuraFrame = AuraFrames[auraCount+1]
				
				if name and icon and frame.Filter(aura) then 
					auraCount = auraCount + 1
					AuraFrame.Icon:SetTexture(icon)
					if count > 1 then AuraFrame.Stacks:SetText(count)
					else  AuraFrame.Stacks:SetText("") end
					AuraFrame:PolledHideIn(expires)
					--AuraFrame:Show()
				else AuraFrame:Hide() end
				if auraCount > 7 then return end
			end	
			
		--[[
			
		elseif unit.partyID then
			-- unit.partyID

			-- Cycle through auras
			--print(unit.name, unit.partyID, "Aura Widget")
			unitid = unit.partyID
			
			for index = 1, 40 do
				local name, rank, icon, count, dispelType, duration, expires, caster, isStealable = UnitDebuff(unitid, index)
				
				aura.name, aura.rank, aura.icon, aura.count = name, rank, icon, count
				aura.dispelType, aura.duration, aura.expires, aura.caster = dispelType, duration, expires, caster
				
				AuraFrame = AuraFrames[auraCount+1]
				
				if name and icon then -- and frame.Filter(aura) then 
					auraCount = auraCount + 1
					AuraFrame.Icon:SetTexture(icon)
					
					--AuraFrame.Glow:SetVertexColor(GetDebuffColor(dispelType))
					
					if count > 1 then AuraFrame.Stacks:SetText(count)
					else  AuraFrame.Stacks:SetText("") end
					AuraFrame:PolledHideIn(expires)
					--AuraFrame:Show()
				else AuraFrame:Hide() end
				if auraCount > 7 then return end
			end	

		--]]
			
		end
		
	end
	
	local function CreateAuraWidget(parent)	
		local frame = CreateFrame("Frame", nil, parent)
		frame:SetWidth(128); frame:SetHeight(32); frame:Show()
		frame.AuraFrames = {}
		local AuraFrames = frame.AuraFrames
		-- Add functions
		frame.Update = UpdateAuraWidget
		-- Create Aura Frames
		for index = 1, 8 do AuraFrames[index] = CreateAuraFrame(frame);  end
		-- Set Anchors, first row	
		AuraFrames[1]:SetPoint("LEFT", frame)
		for index = 2, 3 do AuraFrames[index]:SetPoint("LEFT", AuraFrames[index-1], "RIGHT", 5, 0) end
		-- .. second row
		AuraFrames[4]:SetPoint("BOTTOMLEFT", AuraFrames[1], "TOPLEFT", 0, 8)
		for index = 5, 6 do AuraFrames[index]:SetPoint("LEFT", AuraFrames[index-1], "RIGHT", 5, 0) end
		
		-- If the plate gets hidden, the icons reset to prevent mis-anchoring on a different unit
		frame:SetScript("OnHide", function() for index = 1, 4 do PolledHideIn(AuraFrames[index], 0) end end)	
		frame.Filter = DefaultFilterFunction
		
		if not isEnabled then EnableAuraWatcher(true) end
		
		return frame
	end
	
	TidyPlatesWidgets.CreateAuraWidget = CreateAuraWidget
end




