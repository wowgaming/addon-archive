local _G = _G
local PitBull4 = _G.PitBull4
local DEBUG = PitBull4.DEBUG
local expect = PitBull4.expect

local CustomModule = PitBull4:NewModuleType("custom", {
	enabled = true,
})

--- Does nothing. This should be implemented by the module.
-- When implementing, this should return whether :UpdateLayout(frame) should be called.
-- @param frame the Unit Frame to update
-- @usage local update_layout = MyModule:UpdateFrame(frame)
-- @return false
function CustomModule:UpdateFrame(frame)
	return false
end

--- Does nothing. This should be implemented by the module.
-- When implementing, this should return whether :UpdateLayout(frame) should be called.
-- @param frame the Unit Frame to update
-- @usage local update_layout = MyModule:ClearFrame(frame)
function CustomModule:ClearFrame(frame)
	return false
end

--- Handle the frame being hidden
-- @param frame the Unit Frame hidden.
-- @usage MyModule:OnHide(frame)
function CustomModule:OnHide(frame)
	if DEBUG then
		expect(frame, 'typeof', 'frame')
	end

	-- Nothing to do, we don't want to remove anything from
	-- a hidden frame
	return
end
