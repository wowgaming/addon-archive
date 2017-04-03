local function SpellCastWatcherEvents(self, event, unit, other)
	print("Spell Event", self, event, unit, other)
	if unit == "target" then TidyPlates:ForceUpdate() end
end

local SpellCastWatcher = CreateFrame("Frame")
--SpellCastWatcher:SetScript("OnEvent", SpellCastWatcherEvents)
SpellCastWatcher:RegisterEvent("UNIT_SPELLCAST_START")
SpellCastWatcher:RegisterEvent("UNIT_SPELLCAST_STOP")
--SpellCastWatcher:RegisterEvent("ACTIONBAR_SHOWGRID")
--print("Watcher")

local function UpdateCastWidget(self, unit)
	if unit.isTarget then
		local spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitCastingInfo("target") 
		if spell then --and unit.type == "PLAYER" then 
			self.Text:SetText(spell)
			self:Show()
		else self:Hide() end
	else self:Hide() end

end


---------------
-- Note Widget
---------------

local notefont =					"FONTS\\arialn.ttf"

-- Use for prototype
local art = "Interface\\Addons\\TidyPlates\\Widgets\\NoteWidget\\NoteBackground"

NoteWidgetNames = {
	-- Halls of Reflection
	--Phantom Mage
	--Shadowy Mercenary
	--Ghostly Priest
	--Tortured Rifleman
	--Spectral Footman
	
	-- Marrowgar
	[" Bone Spike"] = "|cFFFFC600Priority Kill",
	-- Deathwhisper
	["Cult Adherent"] = "|cFFFFC600Priority Kill |n |cFF80491C Use Physical Damage",
	["Reanimated Adherent"] = "|cFFFFC600Priority Kill |n |cFF80491C Use Physical Damage",
	["Cult Fanatic"] = "|cFFFFC600Priority Kill |n |cFF80491C Use Magic Damage",
	["Reanimated Fanatic"] = "|cFFFFC600Priority Kill |n |cFF80491C Use Magic Damage",
	["Deformed Fanatic"] = "|cFFFFC600Kite |n |cFF80491C Use Magic Damage",
	-- Saurfang
	["Blood Beast"] = "|cFFFFC600Don't Tank/Melee |n |cFF80491C Kill/Kite at range",
	-- 
	["Little Ooze"] = "|cFFFFC600Kite |n |cFF80491C Kite to Big Ooze",
	["Big Ooze"] = "|cFFFFC600Kite |n |cFF80491C Hits hard",
	--
	["Professor Putricide"] = "|cFFFFC600 Tank till 35%, then.. |n |cFF80491C Tanks taunt, 2x Mutated Plague",
	["Volatile Slime"] = "|cFFFFC600Snare and Kill  |n |cFF80491C Use Slime, Stack on Target",
	["Gas Cloud"] = "|cFFFFC600Snare, Kite and Kill |n |cFF80491C Use Slime, Avoid Target",
	
	--
	
	["Insane Ghoul"] = "|cFFFFC600Danger! |n |cFF80491C Patrolling Mob",
}

local function UpdateNoteWidget(self, unit)
	local text = NoteWidgetNames[unit.name]
	
		if text then --and unit.type == "PLAYER" then 
			self.Text:SetText(text)
			self:Show()
		else self:Hide() end
end

local function CreateNoteWidget(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(16); frame:SetHeight(16)
	-- Image
	frame.Texture = frame:CreateTexture(nil, "OVERLAY")
	frame.Texture:SetPoint("CENTER")
	frame.Texture:SetWidth(256)
	frame.Texture:SetHeight(64)
	frame.Texture:SetTexture(art)
	
	
	-- Target Text
	frame.Text = frame:CreateFontString(nil, "OVERLAY")
	frame.Text:SetFont(notefont, 14, "None")

	frame.Text:SetPoint("CENTER", 0, 7)
	frame.Text:SetShadowOffset(1, -1)
	frame.Text:SetShadowColor(0,0,0,1)
	frame.Text:SetWidth(260)
	frame.Text:SetHeight(40)
	--frame.Text:SetText("|cFFFFC600Priority Kill |n |cFF80491C High Damage Caster")
		
		
		
	-- Vars and Mech
	frame:Hide()
	frame.Update = UpdateNoteWidget
	return frame
end

TidyPlatesWidgets.CreateNoteWidget = CreateNoteWidget


--[[

local MobFilter = {
	"Drudge Ghoul",
	"Decaying Skeleton",
	"Onyxian Whelpling",
	"Tyrande Whisperwind",
	"Border Collie",
	"Dachshund",
	"Great Dane",
	"Saint Bernhard",
	"Mr. Wiggles",
	"Charlie the Teacup-Maker",
}

TestSlider = CreateFrame("Slider","TestScroller", UIParent, "UIPanelScrollBarTemplate")
TestSlider:SetPoint("CENTER")
TestSlider:SetWidth(16)
TestSlider:SetHeight(200)
TestSlider:SetScript("OnValueChanged", function(self, value) print("Value changed to,", value) end)
TestSlider:SetMinMaxValues(0, 2000)
TestSlider:SetValue(2)
TestSlider:SetValueStep(1)
--TestSlider.SetVerticalScroll = function ()	print("SetVerticalScroll") end
--]]
 
--[[

CreateListWidget(parent, reference, createFunction, statusFunction, itemList, numberOfItems)
.AddItem
.DeleteItem
.GetSelected
.SetSelected
.Constructor




Constructor
- Create ScrollFrame
- Create ListItems


AddItem



--]]
 
 
 
 
--[[

Ok, here's how my EZ scroll list is going to work:

CreateScrollList(
	parent,
	reference name,
	button creation function,
	button status function,
	list table)
	
button creation function(parent, reference) return frame
	creates and returns a frame
	must have height and width
	
button status function(self, item)
	passed a list item from the list table
	updates the frame elements (highlights, name, icon, etc.)

For selections, the user can store a variable, Value, which indicates
the selected item.  The 'button status function' would look at self.Value
to determine if it needed to display the selected item.


The scroll list would create one button, determine its size, and then repeat the 
creation process until it filled the base frame.

On scrolling...


	
	
	
--]]

--[[
			
GlobalScrollFrameTest = CreateFrame("ScrollFrame","MyScrollFrameTest", UIParent, "UIPanelScrollFrameTemplate")
GlobalScrollFrameTest:SetPoint("CENTER")
GlobalScrollFrameTest:SetWidth(100)
GlobalScrollFrameTest:SetHeight(100)
GlobalScrollFrameTest:SetScript("OnVerticalScroll", function()  
	local range = (GlobalScrollFrameTest:GetVerticalScroll() / 300)*100
	print("Offset", range) 
end)

GlobalScrollFrameTest:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                            tile = true, tileSize = 16, edgeSize = 16, 
                                            insets = { left = 4, right = 4, top = 4, bottom = 4 }});
GlobalScrollFrameTest:SetBackdropColor(0,0,0,.8);

local TestImage = CreateFrame("Frame")
TestImage:SetWidth(200)
TestImage:SetHeight(400)

TestImage.Texture = TestImage:CreateTexture(nil, "BACKGROUND")
TestImage.Texture:SetTexture("Interface\\Addons\\TidyPlates\\ScrollTest")
TestImage.Texture:SetAllPoints()

GlobalScrollFrameTest:SetScrollChild(TestImage)

-- Create a bunch of buttons
local CreateItemButtom(parent, reference)
	local self = CreateFrame("Button", reference, parent)
	-- Set Size
	-- Set Outline
	-- 
	self.HideMob_Checkbox = 
	self.MobName_Textbox = 
	self.MobNote_Textbox = 
end

--GlobalScrollFrameTest:SetVerticalScrollRange(400)


--]]

		
--[[
"UIPanelScrollBarTemplate"
Slider

--]]

--   http://forums.wowace.com/showthread.php?t=16785&page=2		



--local function CreateListItemFrame()
	
--end











--[[
UNIT_SPELLCAST_CHANNEL_START	Fires when a unit starts channeling a spell
UNIT_SPELLCAST_CHANNEL_STOP	Fires when a unit stops or cancels a channeled spell
UNIT_SPELLCAST_CHANNEL_UPDATE	Fires when a unit's channeled spell is interrupted or delayed
UNIT_SPELLCAST_DELAYED	Fires when a unit's spell cast is delayed
UNIT_SPELLCAST_FAILED	Fires when a unit's spell cast fails
UNIT_SPELLCAST_FAILED_QUIET	Fires when a unit's spell cast fails and no error message should be displayed
UNIT_SPELLCAST_INTERRUPTED	Fires when a unit's spell cast is interrupted
UNIT_SPELLCAST_INTERRUPTIBLE	Fires when a unit's spell cast becomes interruptible again
UNIT_SPELLCAST_NOT_INTERRUPTIBLE	Fires when a unit's spell cast becomes uninterruptible
UNIT_SPELLCAST_SENT	Fires when a request to cast a spell (on behalf of the player or a unit controlled by the player) is sent to the server
UNIT_SPELLCAST_START	Fires when a unit begins casting a spell
UNIT_SPELLCAST_STOP	Fires when a unit stops or cancels casting a spell
UNIT_SPELLCAST_SUCCEEDED

TidyPlates:Update()

* NEW spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitCastingInfo("unit") 
* NEW spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitChannelInfo("unit") 

Event Watcher only needs to watch for events that happen to the current target

--]]


local function UpdateCastWidget(self, unit)
	--local text = NoteWidgetNames[unit.name]
	
	if text then --and unit.type == "PLAYER" then 
		self.Text:SetText(text)
		self:Show()
	else self:Hide() end
end

local function CreateCastWidget(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(16); frame:SetHeight(16)
	-- Image
	frame.Texture = frame:CreateTexture(nil, "OVERLAY")
	frame.Texture:SetPoint("CENTER")
	frame.Texture:SetWidth(256)
	frame.Texture:SetHeight(64)
	frame.Texture:SetTexture(art)
	
	-- Target Text
	frame.Text = frame:CreateFontString(nil, "OVERLAY")
	frame.Text:SetFont(notefont, 14, "None")

	frame.Text:SetPoint("CENTER", 0, 7)
	frame.Text:SetShadowOffset(1, -1)
	frame.Text:SetShadowColor(0,0,0,1)
	frame.Text:SetWidth(260)
	frame.Text:SetHeight(40)

	-- Vars and Mech
	frame:Hide()
	frame.Update = UpdateCastWidget
	return frame
end

TidyPlatesWidgets.CreateCastWidget = CreateCastWidget

