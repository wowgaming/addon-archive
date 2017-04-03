--[[
	fadeManager.lua
		Handles fading out frames when not moused over
		Necessary since using the blizzard fading functions can cause issues in combat
--]]

--[[
	Copyright (c) 2008-2009 Jason Greer
	All rights reserved.

	Redistribution and use in source and binary forms, with or without 
	modification, are permitted provided that the following conditions are met:

		* Redistributions of source code must retain the above copyright notice, 
		  this list of conditions and the following disclaimer.
		* Redistributions in binary form must reproduce the above copyright
		  notice, this list of conditions and the following disclaimer in the 
		  documentation and/or other materials provided with the distribution.
		* Neither the name of the author nor the names of its contributors may 
		  be used to endorse or promote products derived from this software 
		  without specific prior written permission.

	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
	ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
	LIABLE FORANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
	SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
	INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
	CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
	POSSIBILITY OF SUCH DAMAGE.
--]]

local FadeManager = {}
Dominos.FadeManager = FadeManager

local FadeWatcher = CreateFrame('Frame')
local Fader = CreateFrame('Frame')

--[[ Registers Frames for Fading ]]--

function FadeManager:Add(f)
	FadeWatcher:Add(f)
end

function FadeManager:Remove(f)
	FadeWatcher:Remove(f)
end


--[[ Watch Frames For Fade Changing ]]--

do
	local watchedFrames = {}

	FadeWatcher:Hide()
	FadeWatcher.nextUpdate = 0
	FadeWatcher.DELAY = 0.1

	FadeWatcher:SetScript('OnUpdate', function(self, elapsed)
		if not next(watchedFrames) then
			self:Hide()
		end


		self.nextUpdate = self.nextUpdate - elapsed
		if self.nextUpdate < 0 then
			self.nextUpdate = self.DELAY

			for f in pairs(watchedFrames) do
				--check for faded frames that are now in focus
				if self:IsFocus(f) then
					--the checking logic is a little weird because floating point values tend to not be exact
					if abs(f:GetAlpha() - f:GetFadedAlpha()) < 0.01 then
						Fader:Fade(f, 0.1, f:GetAlpha(), f:GetFrameAlpha())
					end
				--check for unfaded frames that are not in focus
				else
					if abs(f:GetAlpha() - f:GetFrameAlpha()) < 0.01 then
						Fader:Fade(f, 0.1, f:GetAlpha(), f:GetFadedAlpha())
					end
				end
			end
		end
	end)

	FadeWatcher:SetScript('OnHide', function(self)
		self.nextUpdate = 0
	end)

	function FadeWatcher:Add(f)
		watchedFrames[f] = true
		self:Show()
	end

	function FadeWatcher:Remove(f)
		watchedFrames[f] = nil
	end

	--this code determins if the mouse is over either the frame itself, or any child frames
if select(4, GetBuildInfo()) == 30200 then
	function FadeWatcher:IsFocus(f)
		if MouseIsOver(f, 1, -1, -1, 1) then
			return GetMouseFocus() == _G['WorldFrame'] or self:IsChildFocus(f:GetChildren())
		end
	end
else
	function FadeWatcher:IsFocus(f)
		if f:IsMouseOver(1, -1, -1, 1) then
			return GetMouseFocus() == _G['WorldFrame'] or self:IsChildFocus(f:GetChildren())
		end
	end
end

	function FadeWatcher:IsChildFocus(...)
		for i = 1, select('#', ...) do
			if GetMouseFocus() == select(i, ...) then
				return true
			end
		end

		for i = 1, select('#', ...) do
			local f = select(i, ...)
			if f:IsShown() and self:IsChildFocus(f:GetChildren()) then
				return true
			end
		end
	end
end


--[[ Handle Fading ]]--

do
	local fadingFrames = {}

	Fader:Hide()

	Fader:SetScript('OnUpdate', function(self, elapsed)
		if not next(fadingFrames) then
			self:Hide()
		end

		for frame, fadeInfo in pairs(fadingFrames) do
			fadeInfo.fadeTimer = (fadeInfo.fadeTimer or 0) + elapsed

			if fadeInfo.fadeTimer < fadeInfo.timeToFade then
				local pct = fadeInfo.fadeTimer / fadeInfo.timeToFade
				local delta = fadeInfo.endAlpha - fadeInfo.startAlpha

				frame:SetAlpha(fadeInfo.startAlpha + pct*delta)
			else
				frame:SetAlpha(fadeInfo.endAlpha)
				fadingFrames[frame] = nil
			end
		end
	end)

	function Fader:Fade(frame, timeToFade, startAlpha, endAlpha)
		frame:SetAlpha(startAlpha)

		if not fadingFrames[frame] then
			local fadeInfo = frame.fadeInfo or {}
			fadeInfo.timeToFade = timeToFade
			fadeInfo.startAlpha = startAlpha
			fadeInfo.endAlpha = endAlpha
			fadeInfo.fadeTimer = 0
			frame.fadeInfo = fadeInfo
			
			fadingFrames[frame] = fadeInfo
			self:Show()
		end
	end
end
