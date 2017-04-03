local AddonName, Addon = ...

Addon.DebugLib =
{
	Version = 1,
}

if not Addon.DebugColorCode then
	Addon.DebugColorCode = GREEN_FONT_COLOR_CODE
end

-- Add the /reloadui command if it isn't already installed

if not SLASH_RELOADUI1 then
	SlashCmdList.RELOADUI = function () if SlashCmdList.SWATTER then SlashCmdList.SWATTER("clear") end ReloadUI() end
	SLASH_RELOADUI1 = "/reloadui"
end

if not tern then
	function tern(a, b, c)
		if a then return b else return c end
	end
end

function Addon.DebugLib:Initialize()
	if self.Initialized then
		return
	end
	
	self.Initialized = true
	
	hooksecurefunc(
			"ChatFrame_ConfigEventHandler",
			function (event)
				if event == "UPDATE_CHAT_WINDOWS"
				and not self.DebugFrame then
					self:FindDebugFrame()
				end
			end)
	
	self:FindDebugFrame()
end

function Addon.DebugLib:FindDebugFrame()
	if self.DebugFrame then
		return
	end
	
	for vChatIndex = 1, NUM_CHAT_WINDOWS do
		local vChatFrame = _G["ChatFrame"..vChatIndex]
		
		if vChatFrame
		and (vChatFrame:IsVisible() or vChatFrame.isDocked) then
			local vTab = _G["ChatFrame"..vChatIndex.."Tab"]
			local vName = vTab:GetText()
			
			if vName == "Debug" then
				self.DebugFrame = vChatFrame
				
				if self.DebugFrame:GetMaxLines() < 1000 then
					self.DebugFrame:SetMaxLines(1000)
				end
				
				self.DebugFrame:SetFading(false)
				self.DebugFrame:SetMaxResize(1200, 1000)
			end
		end
	end
	
	if self.DebugFrame then
		Addon:NoteMessage("Found debugging chat frame")
	end
end

function Addon.DebugLib:ClearDebugLog()
	if not self.Initialized then
		self:Initialize()
	end
	
	if not self.DebugFrame then
		return
	end
	
	self.DebugFrame:Clear()
end

function Addon.DebugLib:AddDebugMessage(pPrefix, pMessage, ...)
	if not self.Initialized then
		self:Initialize()
	end
	
	local vMessage = (pPrefix or "")..Addon.DebugColorCode..string.format("[%s] ", AddonName)..FONT_COLOR_CODE_CLOSE..HIGHLIGHT_FONT_COLOR_CODE..pMessage..FONT_COLOR_CODE_CLOSE
	
	if true then -- set to false to diagnose debug message problems
		if select("#", ...) > 0 then
			if type(select(1, ...)) == "table" then
				vMessage = string.gsub(vMessage, "%$(%w+)", ...)
			else
				vMessage = string.format(vMessage, ...)
			end
		end
	else
		local vSucceeded
		
		if select("#", ...) > 0 then
			if type(select(1, ...)) == "table" then
				vSucceeded, vMessage = pcall(string.gsub, vMessage, "%$(%w+)", ...)
			else
				vSucceeded, vMessage = pcall(string.format, vMessage, ...)
			end
		end
	end
	
	if self.DebugFrame then
		self.DebugFrame:AddMessage(vMessage)
		
		local vTabFlash = _G[self.DebugFrame:GetName().."TabFlash"]
		
		vTabFlash:Show()
		UIFrameFlash(vTabFlash, 0.25, 0.25, 60, nil, 0.5, 0.5)
	end
	
	return vMessage
end

function Addon:DebugMessage(pMessage, ...)
	if not self.DebugLib.Initialized then
		self.DebugLib:Initialize()
	end
	
	if not self.DebugLib.DebugFrame then
		return
	end
	
	self.DebugLib:AddDebugMessage(NORMAL_FONT_COLOR_CODE.."[DEBUG] "..FONT_COLOR_CODE_CLOSE, pMessage, ...)
end

function Addon:TestMessage(pMessage, ...)
	local vMessage = self.DebugLib:AddDebugMessage(GREEN_FONT_COLOR_CODE.."[   TEST] "..FONT_COLOR_CODE_CLOSE, pMessage, ...)
	DEFAULT_CHAT_FRAME:AddMessage(vMessage)
end

function Addon:ErrorMessage(pMessage, ...)
	local vMessage = self.DebugLib:AddDebugMessage(RED_FONT_COLOR_CODE.."[ERROR] "..FONT_COLOR_CODE_CLOSE, pMessage, ...)
	self:DebugStack()
	
	DEFAULT_CHAT_FRAME:AddMessage(vMessage)
end

function Addon:NoteMessage(pMessage, ...)
	local vMessage = self.DebugLib:AddDebugMessage("", pMessage, ...)
	DEFAULT_CHAT_FRAME:AddMessage(vMessage)
end

function Addon:DebugTable(pValue, pValuePath, pMaxDepth, pMode)
	if not pValuePath then
		pValuePath = "table"
	end
	
	if not pValue then
		self:DebugMessage(pValuePath.." = nil")
		return
	end
	
	local vType = type(pValue)
	
	if vType == "number" then
		self:DebugMessage(pValuePath.." = "..pValue)
	elseif vType == "string" then
		self:DebugMessage(pValuePath.." = \""..pValue.."\"")
	elseif vType == "boolean" then
		if pValue then
			self:DebugMessage(pValuePath.." = true")
		else
			self:DebugMessage(pValuePath.." = false")
		end
	elseif vType == "table" then
		local vMaxDepth
		
		if pMaxDepth then
			vMaxDepth = pMaxDepth
		else
			vMaxDepth = 5
		end
		
		if vMaxDepth == 0 then
			self:DebugMessage(pValuePath.." = {...}")
		else
			local vFoundElement = false
			
			for vIndex, vElement in pairs(pValue) do
				local vValuePath 
				
				if not vFoundElement then
					vValuePath = pValuePath
				elseif string.sub(pValuePath, 1, 10) == "|cff888888" then
					vValuePath = string.gsub(pValuePath, "|cffffffff", "")
				else
					vValuePath = "|cff888888"..string.gsub(pValuePath, "|cffffffff", "")
				end
				
				if type(vIndex) ~= "string" then
					vValuePath = vValuePath.."|cffffffff["..tostring(vIndex).."]"
				else
					vValuePath = vValuePath.."|cffffffff."..vIndex
				end
				
				self:DebugTable(vElement, vValuePath, vMaxDepth - 1, pMode)
				
				vFoundElement = true
			end
			
			if not vFoundElement then
				self:DebugMessage(pValuePath.." = {}")
			end
		end
	elseif vType == "function" then
		if pMode ~= "NO_FUNCTIONS" then
			self:DebugMessage(pValuePath.." "..vType)
		end
	else
		self:DebugMessage(pValuePath.." "..vType)
	end
end

function Addon:DebugStack(pPrefix, pDepth)
	local vCallStack = self.DebugLib:GetCallStack(pPrefix, pDepth, 1)
	
	for vIndex, vMessage in ipairs(vCallStack) do
		self:DebugMessage(vMessage)
	end
end

function Addon:ErrorStack(pPrefix, pDepth)
	local vCallStack = self.DebugLib:GetCallStack(pPrefix, pDepth, 1)
	
	for vIndex, vMessage in ipairs(vCallStack) do
		self:ErrorMessage(vMessage)
	end
end

function Addon:DebugMark()
	self:DebugMessage("————————————————————————————————————————")
end

function Addon.DebugLib:ReduceAddonPath(pPath)
	return string.gsub(pPath, "^Interface\\AddOns\\[^\\]*\\", "")
end

function Addon.DebugLib:GetCallStack(pPrefix, pDepth, pDepthOffset)
	local vCallStack = {}
	
	if not pPrefix then
		pPrefix = "    "
	end
	
	if not pDepth then
		pDepth = 18
	end
	
	local vStackString = debugstack((pDepthOffset or 0) + 2, pDepth, 0)
	
	for vMessageLine in string.gmatch(vStackString, "(.-)\n") do
		--table.insert(vCallStack, pPrefix.."LINE: "..vMessageLine)
		
		local _, _, vFile, vLine, vFunction = string.find(vMessageLine, "([%w%.]+):(%d+): in function .(.*)'")
		
		if not vFunction then
			_, _, vFunction, vLine, vFile = string.find(vMessageLine, "%[string \"(.*)\"%]:(%d+): in (.*)")
		end
		
		if not vFunction then
			_, _, vFile, vLine, vFunctionFile, vFunctionLine = string.find(vMessageLine, "([^:]+):(%d+): in function <([^:]+):(%d+)>")
			
			if vFunctionLine then
				vFunctionFile = self:ReduceAddonPath(vFunctionFile)
				vFunction = vFunctionFile..", "..vFunctionLine
			end
		end
		
		if not vFunction then
			_, _, vFunction = string.find(vMessageLine, "(tail call.*)")
		end
		
		if not vFunction then
			_, _, _, vFunction = string.find(vMessageLine, "(%[C%]): in function .(.*)'")
			
			if vFunction then
				vFunction = "[C] "..vFunction
				vFile = nil
				vLine = nil
			end
		end
		
		if vFunction then
			if vFile then
				if not vLine then
					vLine = 0
				end
				
				vFile = self:ReduceAddonPath(vFile)
				
				table.insert(vCallStack, pPrefix..vFile..", "..vLine..": "..vFunction)
			else
				table.insert(vCallStack, pPrefix..vFunction)
			end
		else
			table.insert(vCallStack, pPrefix.."Unknown function: "..vMessageLine)
		end
	end
	
	return vCallStack
end

function Addon.DebugLib:NewBuckets(pInterval)
	local vBuckets =
	{
		Interval = pInterval,
		BucketStartTime = GetTime(),
		BucketIndex = 1,
		NumBuckets = math.floor(pInterval),
		Buckets = {[1] = {Value = 0, Time = 0}},
		
		AddSample = self.BucketsAddSample,
		GetValue = self.BucketsGetValue,
	}
	
	return vBuckets
end

function Addon.DebugLib:BucketsAddSample(pValue, pTime)
	local vBucket = self.Buckets[self.BucketIndex]
	
	vBucket.Value = vBucket.Value + pValue
	
	local vElapsed = pTime - self.BucketStartTime
	
	if vElapsed > 1 then
		vBucket.Time = vElapsed
		
		self.BucketStartTime = pTime
		self.BucketIndex = self.BucketIndex + 1
		
		if self.BucketIndex > self.NumBuckets then
			self.BucketIndex = 1
		end
		
		vBucket = self.Buckets[self.BucketIndex]
		
		if not vBucket then
			vBucket = {}
			self.Buckets[self.BucketIndex] = vBucket
		end
		
		vBucket.Value = 0
		vBucket.Time = 0
	end
end

function Addon.DebugLib:BucketsGetValue()
	local vTotalElapsed = 0
	local vTotalValue = 0
	
	for vIndex, vBucket in ipairs(self.Buckets) do
		if vBucket.Time > 0 then
			vTotalElapsed = vTotalElapsed + vBucket.Time
			vTotalValue = vTotalValue + vBucket.Value
		end
	end
	
	if vTotalElapsed == 0 then
		return 0, 0
	end
	
	return vTotalValue / vTotalElapsed, vTotalElapsed
end

function Addon.DebugLib:NewPerfMonitor(pLabel)
	local vPerfMonitor =
	{
		Label = pLabel,
		CPUBuckets = self:NewBuckets(10),
		MemBuckets = self:NewBuckets(10),
		
		FunctionEnter = self.PerfMonitorFunctionEnter,
		FunctionExit = self.PerfMonitorFunctionExit,
		DumpValue = self.PerfMonitorDumpValue,
	}
	
	return vPerfMonitor
end

function Addon.DebugLib:PerfMonitorFunctionEnter(pTime)
	self.StartTime = pTime
	self.StartMem = gcinfo()
end

function Addon.DebugLib:PerfMonitorFunctionExit(pTime)
	local vEndMem = gcinfo()
	
	self.CPUBuckets:AddSample(pTime - self.StartTime, pTime)
	self.MemBuckets:AddSample(vEndMem - self.StartMem, pTime)
end

function Addon.DebugLib:PerfMonitorDumpValue()
	local vCPUTime, vTotalTime = self.CPUBuckets:GetValue()
	local vMemRate = self.MemBuckets:GetValue()
	local vCPUPercent
	
	if vTotalTime > 0 then
		vCPUPercent = 100 * vCPUTime / vTotalTime
	else
		vCPUPercent = 0
	end
	
	self:DebugMessage("%s: CPU: %.1f%% Mem: %dKB/sec", self.Label, vCPUPercent, vMemRate)
end

function Addon.DebugLib.BoolToString(pValue)
	if pValue then
		return "true"
	else
		return "false"
	end
end

function Addon.DebugLib:ShowFrameStatus(pFrame, pPrefix)
	self:DebugMessage("%sVisible: %s Protected: %s Width: %d Height: %d Level: %d", pPrefix or pFrame:GetName(), self.BoolToString(pFrame:IsVisible()), self.BoolToString(pFrame:IsProtected()), pFrame:GetWidth(), pFrame:GetHeight(), pFrame:GetFrameLevel())
end

function Addon.DebugLib:ShowParentTree(pFrame, pPrefix)
	if not pPrefix then
		pPrefix = ""
	end
	
	local vParent = pFrame:GetParent()
	
	if vParent then
		self:DebugMessage(pPrefix.."Parent: "..vParent:GetName())
		
		if vParent ~= UIParent then
			self:ShowFrameStatus(vParent, pPrefix.."    ")
			self:ShowParentTree(vParent, pPrefix.."    ")
		end
	end
end

function Addon.DebugLib:ShowAnchorTree(pFrame, pPrefix)
	if not pPrefix then
		pPrefix = ""
	end
	
	local vIndex = 1
	local vDidAnchor = {}
	
	local vIndex = 1
	
	while true do
		local vPoint, vRelativeTo, vRelativePoint, vOffsetX, vOffsetY = pFrame:GetPoint(vIndex)
		
		if not vPoint
		or not vRelativeTo then
			break
		end
		
		self:DebugMessage("%sAnchor %d: %s, %s, %s, %d, %d", pPrefix, vIndex, vPoint, vRelativeTo:GetName(), vRelativePoint, vOffsetX, vOffsetY)
		
		if vRelativeTo ~= UIParent
		and not vDidAnchor[vRelativeTo] then
			vDidAnchor[vRelativeTo] = true
			
			self:DebugMessage(pPrefix.."RelativeTo: "..vRelativeTo:GetName())
			self:ShowFrameStatus(vRelativeTo, pPrefix.."    ")
			self:ShowAnchorTree(vRelativeTo, pPrefix.."    ")
		end
		
		vIndex = vIndex + 1
	end
	
	if vIndex == 1 then
		self:DebugMessage(pPrefix.." No Anchors")
	end
end

function Addon.DebugLib:ShowFrameTree(pFrame)
	self:DebugMessage("ShowFrameTree: "..pFrame:GetName())
	self:ShowFrameStatus(pFrame, "    ")
	self:ShowParentTree(pFrame, "    ")
	self:ShowAnchorTree(pFrame, "    ")
end
