if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_Border requires PitBull4")
end

local L = PitBull4.L

local PitBull4_Border = PitBull4:NewModule("Border", "AceEvent-3.0")

PitBull4_Border:SetModuleType("custom")
PitBull4_Border:SetName(L["Border"])
PitBull4_Border:SetDescription(L["Show a highlight when hovering or targeting."])
PitBull4_Border:SetDefaults({
	normal_color = { 1, 1, 1, 1 },
	normal_texture = "None",
	boss_color = { 0.6, 0.3, 0.6, 1 },
	boss_texture = "Blizzard Tooltip",
	elite_color = { 1, 1, 0, 1 },
	elite_texture = "Blizzard Tooltip",
	rare_color = { 0.7, 0.7, 0.7, 1 },
	rare_texture = "Blizzard Tooltip",
	size = 16,
	padding = 3,
})

local LibSharedMedia
local LibSharedMedia_border_None = [[Interface\None]]

function PitBull4_Border:OnEnable()
	LibSharedMedia = LibStub("LibSharedMedia-3.0", true)
	if not LibSharedMedia then
		error(L["PitBull4_Border requires the library LibSharedMedia-3.0 to be available."])
	end
	self:RegisterEvent("UNIT_CLASSIFICATION_CHANGED")
	
	LibSharedMedia_border_None = LibSharedMedia:Fetch("border", "None")

	-- Force an update, OnEnable may not have run before PB4 tried to update the frames
	-- so they'd end up with no border because LSM would not have been available.
	self:UpdateAll()
end

-- this is here to allow it to be overridden, by say an aggro module
function PitBull4_Border:GetTextureAndColor(frame)
	local unit = frame.unit
	local classification = unit and PitBull4.Utils.BetterUnitClassification(unit)
	
    if classification == "worldboss" then
        classification = "boss"
	elseif classification == "elite" then
		classification = "elite"
	elseif classification == "rare" or classification == "rareelite" then
		classification = "rare"
	else
		classification = "normal"
	end

	local db = self:GetLayoutDB(frame)
	local texture = db[classification .. "_texture"]
	local color = db[classification .. "_color"]
	
	return texture, color[1], color[2], color[3], color[4]
end

function PitBull4_Border:UpdateFrame(frame)
	if not LibSharedMedia then
		return self:ClearFrame(frame)
	end
	
	local texture, r, g, b, a = self:GetTextureAndColor(frame)
	texture = LibSharedMedia:Fetch("border", texture) or LibSharedMedia_border_None
	
	local border = frame.Border
	
	if texture == LibSharedMedia_border_None then
		return self:ClearFrame(frame)
	end
	
	if not border then
		local db = self:GetLayoutDB(frame)
		local size = db.size
		local padding = db.padding
		border = PitBull4.Controls.MakeFrame(frame)
		frame.Border = border
		border:SetFrameLevel(frame:GetFrameLevel())
		border:SetAllPoints(frame)
		
		local tex = PitBull4.Controls.MakeTexture(border, "BORDER")
		border[1] = tex
		tex:SetWidth(size)
		tex:SetHeight(size)
		tex:SetPoint("TOPLEFT", border, "TOPLEFT", -padding, -size + padding)
		tex:SetPoint("BOTTOMLEFT", border, "BOTTOMLEFT", -padding, size - padding)
		tex:SetTexCoord(0, 0, 0, 1.948, 0.125, 0, 0.125, 1.948)
		local tex = PitBull4.Controls.MakeTexture(border, "BORDER")
		border[2] = tex
		tex:SetWidth(size)
		tex:SetHeight(size)
		tex:SetPoint("TOPRIGHT", border, "TOPRIGHT", padding, -size + padding)
		tex:SetPoint("BOTTOMRIGHT", border, "BOTTOMRIGHT", padding, size - padding)
		tex:SetTexCoord(0.125, 0, 0.125, 1.948, 0.25, 0, 0.25, 1.948)
		local tex = PitBull4.Controls.MakeTexture(border, "BORDER")
		border[3] = tex
		tex:SetWidth(size*8)
		tex:SetHeight(size)
		tex:SetPoint("TOPLEFT", border, "TOPLEFT", size - padding, padding)
		tex:SetPoint("TOPRIGHT", border, "TOPRIGHT", -size + padding, padding)
		tex:SetTexCoord(0.25, 9.2808, 0.375, 9.2808, 0.25, 0, 0.375, 0)
		local tex = PitBull4.Controls.MakeTexture(border, "BORDER")
		border[4] = tex
		tex:SetWidth(size*8)
		tex:SetHeight(size)
		tex:SetPoint("BOTTOMLEFT", border, "BOTTOMLEFT", size - padding, -padding)
		tex:SetPoint("BOTTOMRIGHT", border, "BOTTOMRIGHT", -size + padding, -padding)
		tex:SetTexCoord(0.375, 9.2808, 0.5, 9.2808, 0.375, 0, 0.5, 0)
		local tex = PitBull4.Controls.MakeTexture(border, "BORDER")
		border[5] = tex
		tex:SetWidth(size)
		tex:SetHeight(size)
		tex:SetPoint("TOPLEFT", border, "TOPLEFT", -padding, padding)
		tex:SetTexCoord(0.5, 0, 0.5, 1, 0.625, 0, 0.625, 1)
		local tex = PitBull4.Controls.MakeTexture(border, "BORDER")
		border[6] = tex
		tex:SetWidth(size)
		tex:SetHeight(size)
		tex:SetPoint("TOPRIGHT", border, "TOPRIGHT", padding, padding)
		tex:SetTexCoord(0.625, 0, 0.625, 1, 0.75, 0, 0.75, 1)
		local tex = PitBull4.Controls.MakeTexture(border, "BORDER")
		border[7] = tex
		tex:SetWidth(size)
		tex:SetHeight(size)
		tex:SetPoint("BOTTOMLEFT", border, "BOTTOMLEFT", -padding, -padding)
		tex:SetTexCoord(0.75, 0, 0.75, 1, 0.875, 0, 0.875, 1)
		local tex = PitBull4.Controls.MakeTexture(border, "BORDER")
		border[8] = tex
		tex:SetWidth(size)
		tex:SetHeight(size)
		tex:SetPoint("BOTTOMRIGHT", border, "BOTTOMRIGHT", padding, -padding)
		tex:SetTexCoord(0.875, 0, 0.875, 1, 1, 0, 1, 1)
	end
	
	for _, tex in ipairs(border) do
		tex:SetTexture(texture)
		tex:SetVertexColor(r, g, b, a)
	end
	
	border:Show()

	return false
end

function PitBull4_Border:ClearFrame(frame)
	local border = frame.Border
	if not border then
		return false
	end
	
	for i, tex in ipairs(border) do
		border[i] = tex:Delete()
	end
	frame.Border = border:Delete()
	
	return false
end

function PitBull4_Border:UNIT_CLASSIFICATION_CHANGED(event, unit)
	self:UpdateForUnitID(unit)
end

function PitBull4_Border:OnHide(frame)
	local border = frame.Border
	if border then
		border:Hide()
	end
end

function PitBull4_Border:OnEnter(frame)
	mouse_focus = frame
	if not frame.Border then
		return
	end
	if not self:ShouldShow(frame) then
		frame.Border:Hide()
		return
	end
	frame.Border:Show()
end

function PitBull4_Border:OnLeave(frame)
	mouse_focus = nil
	if not frame.Border then
		return
	end
	if not self:ShouldShow(frame) then
		frame.Border:Hide()
	end
end

function PitBull4_Border:ShouldShow(frame)
	local db = self:GetLayoutDB(frame)
	
	if mouse_focus == frame and db.while_hover then
		return true
	end
	
	if not target_guid or frame.guid ~= target_guid or EXEMPT_UNITS[frame.unit] then
		return false
	end
	
	if not db.show_target then
		return false
	end
	
	return true
end

function PitBull4_Border:PLAYER_TARGET_CHANGED()
	mouse_focus = GetMouseFocus()
	target_guid = UnitGUID("target")
	
	for frame in PitBull4:IterateFrames() do
		if frame.Border then
		 	if self:ShouldShow(frame) then
				frame.Border:Show()
			else
				frame.Border:Hide()
			end
		end
	end
end

function PitBull4_Border:LibSharedMedia_Registered(event, mediatype, key)
	if mediatype == "border" then
		self:UpdateAll()
	end
end

PitBull4_Border:SetLayoutOptionsFunction(function(self)
	LoadAddOn("AceGUI-3.0-SharedMediaWidgets")
	local AceGUI = LibStub("AceGUI-3.0")
	
	local function update()
		for frame in PitBull4:IterateFramesForLayout(PitBull4.Options.GetCurrentLayout()) do
			self:UpdateFrame(frame)
		end
	end
	
	local function clear_and_update()
		for frame in PitBull4:IterateFramesForLayout(PitBull4.Options.GetCurrentLayout()) do
			self:ClearFrame(frame)
			self:UpdateFrame(frame)
		end
	end
	
	local function get(info)
		return PitBull4.Options.GetLayoutDB(self)[info[#info]]
	end
	local function set(info, value)
		PitBull4.Options.GetLayoutDB(self)[info[#info]] = value
		update()
	end
	
	local function get_color(info)
		return unpack(PitBull4.Options.GetLayoutDB(self)[info[#info]])
	end
	local function set_color(info, r, g, b, a)
		local color = PitBull4.Options.GetLayoutDB(self)[info[#info]]
		color[1], color[2], color[3], color[4] = r, g, b, a
		update()
	end
	return 'size', {
		type = 'range',
		name = L["Size"],
		desc = L["How large the border should be."],
		get = get,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).size = value
			clear_and_update()
		end,
		min = 4,
		max = 30,
		step = 1,
	}, 'padding', {
		type = 'range',
		name = L["Padding"],
		desc = L["How far the border should be from the frame."],
		get = get,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).padding = value
			clear_and_update()
		end,
		min = -10,
		max = 10,
		step = 1,
	}, 'normal', {
		type = 'group',
		inline = true,
		name = L["Normal"],
		args = {
			normal_color = {
				type = 'color',
				name = L["Color"],
				desc = L["What color should be applied to the border if it is a normal unit."],
				hasAlpha = true,
				get = get_color,
				set = set_color,
			},
			normal_texture = {
				type = 'select',
				name = L["Texture"],
				desc = L["What texture should be applied to the border if it is a normal unit."],
				get = get,
				set = set,
				values = function(info)
					return LibSharedMedia:HashTable("border")
				end,
				hidden = function(info)
					return not LibSharedMedia
				end,
				dialogControl = AceGUI.WidgetRegistry["LSM30_Border"] and "LSM30_Border" or nil,
			}
		}
	}, 'elite', {
		type = 'group',
		inline = true,
		name = L["Elite"],
		args = {
			elite_color = {
				type = 'color',
				name = L["Color"],
				desc = L["What color should be applied to the border if it is an elite unit."],
				hasAlpha = true,
				get = get_color,
				set = set_color,
			},
			elite_texture = {
				type = 'select',
				name = L["Texture"],
				desc = L["What texture should be applied to the border if it is an elite unit."],
				get = get,
				set = set,
				values = function(info)
					return LibSharedMedia:HashTable("border")
				end,
				hidden = function(info)
					return not LibSharedMedia
				end,
				dialogControl = AceGUI.WidgetRegistry["LSM30_Border"] and "LSM30_Border" or nil,
			}
		}
    }, 'rare', {
        type = 'group',
        inline = true,
        name = L["Rare"],
        args = {
            rare_color = {
                type = 'color',
                name = L["Color"],
                desc = L["What color should be applied to the border if it is a rare unit."],
                hasAlpha = true,
                get = get_color,
                set = set_color,
            },
            rare_texture = {
                type = 'select',
                name = L["Texture"],
                desc = L["What texture should be applied to the border if it is a rare unit."],
                get = get,
                set = set,
                values = function(info)
                    return LibSharedMedia:HashTable("border")
                end,
                hidden = function(info)
                    return not LibSharedMedia
                end,
                dialogControl = AceGUI.WidgetRegistry["LSM30_Border"] and "LSM30_Border" or nil,
            }
        }
    }, 'boss', {
        type = 'group',
        inline = true,
        name = L["Boss"],
        args = {
            boss_color = {
                type = 'color',
                name = L["Color"],
                desc = L["What color should be applied to the border if it is a boss unit."],
                hasAlpha = true,
                get = get_color,
                set = set_color,
            },
            boss_texture = {
                type = 'select',
                name = L["Texture"],
                desc = L["What texture should be applied to the border if it is a boss unit."],
                get = get,
                set = set,
                values = function(info)
                    return LibSharedMedia:HashTable("border")
                end,
                hidden = function(info)
                    return not LibSharedMedia
                end,
                dialogControl = AceGUI.WidgetRegistry["LSM30_Border"] and "LSM30_Border" or nil,
            }
        }
	}
end)
