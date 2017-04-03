local revision = tonumber(string.sub("$Revision: 1127 $", 12, -3))
local Recount = _G.Recount
if Recount.Version < revision then Recount.Version = revision end

--Code for organizing the frame order
local TopWindow
local AddToScale={}
local AllWindows={}

local LevelDiff

--based off an aloft function to save memory usage by SetLevel (was creating a table for children frames)
local function SetLevel_ProcessChildFrames(...)
	for i = 1, select('#', ...) do
		local frame = select(i, ...)

		Recount:SetLevel(frame,frame:GetFrameLevel()+LevelDiff)
	end
end

function Recount:SetLevel(frame,level)
	LevelDiff = level-frame:GetFrameLevel()
	frame:SetFrameLevel(level)

	--SetLevel_ProcessChildFrames(frame:GetChildren()) --Elsia: If I understood correctly children now inherit frame levels so this should not be needed.
end

function Recount:InitOrder()
	TopWindow=UIParent

	Recount:AddWindow(Recount.MainWindow)
	Recount:AddWindow(Recount.DetailWindow)
	Recount:AddWindow(Recount.GraphWindow)
end

function Recount:SetWindowTop(window)	
	local Check=window.Above

	while Check~=nil do
		window.Above=Check.Above
		Check.Above=window

		Check.Below=window.Below
		window.Below=Check

		Check.Below.Above=Check
		
		Recount:SetLevel(Check,Check.Below:GetFrameLevel()+10)		
		Check=window.Above
	end
	Recount:SetLevel(window,window.Below:GetFrameLevel()+10)
	TopWindow=window
end

function Recount:AddWindow(window)
	window.Below=TopWindow
	TopWindow.Above=window
	window.Above=nil
	
	Recount:SetLevel(window,TopWindow:GetFrameLevel()+10)
	TopWindow=window

	if window:GetName()~="Recount_ConfigWindow" then
		AddToScale[#AddToScale+1]=window
	end
	AllWindows[#AllWindows+1]=window

	window.isLocked=Recount.db.profile.Locked
end

function Recount:ScaleWindows(scale,first)

	--local this

	--Reuses some of my code from IMBA to scale without moving the windows
	for _, v in pairs(AddToScale) do
		if not first then
			local pointNum=v:GetNumPoints()
			local curScale=v:GetScale();
			local points=Recount:GetTable()
			for i=1,pointNum,1 do
				points[i]=Recount:GetTable()
				points[i][1], points[i][2], points[i][3], points[i][4], points[i][5]=v:GetPoint(i)
				points[i][4]=points[i][4]*curScale/scale;
				points[i][5]=points[i][5]*curScale/scale;
			end

			v:ClearAllPoints()
			for i=1,pointNum,1 do
				v:SetPoint(points[i][1],points[i][2],points[i][3],points[i][4],points[i][5]);
				Recount:FreeTable(points[i])
			end

			Recount:FreeTable(points)
			
			if v:GetScript("OnMouseUp") then
				v.isMoving=true
				--this=v
				v:GetScript("OnMouseUp")(v)
				v.isMoving=false
			end
		end
 
		v:SetScale(scale)
		if v.SavePosition then -- Elsia, need to save position if the function exists to prevent problems with Realtime window when scaled.
			v:SavePosition()
		end
	end
end

function Recount:ResetPositionAllWindows()
	for _, v in pairs(AllWindows) do
		v:ClearAllPoints()
		v:SetPoint("CENTER",UIParent,"CENTER",0,0)
	end
end

function Recount:LockWindows(lock)
	for _, v in pairs(AllWindows) do
		if v.DragBottomRight then
			v.isLocked=lock -- Only lock windows whose position is stored.
			v:EnableMouse(not lock)
			if lock then
				v.DragBottomRight:Hide()
				v.DragBottomLeft:Hide()
			else
				v.DragBottomRight:Show()
				v.DragBottomLeft:Show()
			end
		else
			v.isLocked=false
			v:EnableMouse(true)
		end
	end
end

function Recount:HideRealtimeWindows()
	for _, v in pairs (AllWindows) do
		if v.tracking then
			v:Hide()
		end
	end
end

function Recount:SetStrataAndClamp()
	local strata
	if Recount.db.profile.FrameStrata then
		strata = strsub(Recount.db.profile.FrameStrata, 3)
	end

	for _, v in pairs (AllWindows) do
		if strata then
			v:SetFrameStrata(strata)
		end
		v:SetClampedToScreen(Recount.db.profile.ClampToScreen)
	end
end



--[[function Recount:ShowGrips(state)
	local theFrame = Recount.MainWindow
	if state then
		theFrame.DragBottomRight:Show()
		theFrame.DragBottomLeft:Show()
	else
		theFrame.DragBottomRight:Hide()
		theFrame.DragBottomLeft:Hide()
	end
end
]]
