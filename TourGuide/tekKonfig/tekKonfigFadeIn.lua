
local lib, oldminor = LibStub:NewLibrary("tekKonfig-FadeIn", 1)
if not lib then return end


local starttimes, endtimes, OnUpdates = {}, {}, {}
local function OnUpdate(frame)
	local time = GetTime()
	if time >= (starttimes[frame] + endtimes[frame]) then
		frame:SetScript("OnUpdate", OnUpdates[frame])
		frame:SetAlpha(1)
	else frame:SetAlpha((time - starttimes[frame])/endtimes[frame]) end
end

-- Fades in a frame, if time is not passed 0.5sec is used
function lib.FadeIn(frame, time)
	time = time or 0.5
	assert(frame, "No frame passed")
	assert(time > 0, "Time must be positive")

	starttimes[frame], endtimes[frame], OnUpdates[frame] = GetTime(), time, frame:GetScript("OnUpdate")
	frame:SetAlpha(0)
	frame:SetScript("OnUpdate", OnUpdate)
end
