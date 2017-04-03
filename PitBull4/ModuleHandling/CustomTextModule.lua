local _G = _G
local PitBull4 = _G.PitBull4
local DEBUG = PitBull4.DEBUG
local expect = PitBull4.expect

local CustomTextModule = PitBull4:NewModuleType("custom_text", {
	size = 1,
	attach_to = "root",
	location = "edge_top_left",
	position = 1,
	side = false,
	enabled = true,
})

--- Does nothing. This should be implemented by the module.
-- When implementing, this should return whether :UpdateLayout(frame) should be called.
-- @param frame the Unit Frame to update
-- @usage local update_layout = MyModule:UpdateFrame(frame)
-- @return false
function CustomTextModule:UpdateFrame(frame)
	return false
end

--- Does nothing. This should be implemented by the module.
-- When implementing, this should return whether :UpdateLayout(frame) should be called.
-- @param frame the Unit Frame to update
-- @usage local update_layout = MyModule:ClearFrame(frame)
function CustomTextModule:ClearFrame(frame)
	return false
end

--- Handle the frame being hidden
-- @param frame the Unit Frame hidden.
-- @usage MyModule:OnHide(frame)
function CustomTextModule:OnHide(frame)
	if DEBUG then
		expect(frame, 'typeof', 'frame')
	end

	-- Nothing to do, we don't want to remove anything from
	-- a hidden frame
	return
end

--- Return the font and size to use for the given frame.
-- @param frame the unit frame
-- @return the font path
-- @return the font size
-- @usage local font, size = MyModule:GetFont(some_frame)
-- some_frame.MyModule:SetFont(font, size)
function CustomTextModule:GetFont(frame)
	local db = self:GetLayoutDB(frame)
	return frame:GetFont(db.font, db.size)
end
