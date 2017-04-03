function IceCore_CreateClass(parent)
	local class = { prototype = {} }
	if parent then
		class.super = parent
		setmetatable(class.prototype, { __index = parent.prototype })
	end
	local mt = { __index = class.prototype }
	function class:new(...)
		local self = setmetatable({}, mt)
		if self.init then
			self:init(...)
		end
		return self
	end

	return class
end

IceCore = IceCore_CreateClass()

IceCore.Side = { Left = "LEFT", Right = "RIGHT" }
IceCore.BuffLimit = 40

IceCore.prototype.defaults = {}
IceCore.prototype.settings = nil
IceCore.prototype.IceHUDFrame = nil
IceCore.prototype.updatees = {}
IceCore.prototype.update_elapsed = 0
IceCore.prototype.elements = {}
IceCore.prototype.enabled = nil
IceCore.prototype.presets = {}
IceCore.prototype.bConfigMode = false

-- Constructor --
function IceCore.prototype:init()
	IceHUD:Debug("IceCore.prototype:init()")

	self.IceHUDFrame = CreateFrame("Frame","IceHUDFrame", UIParent)
end


function IceCore.prototype:SetupDefaults()
-- DEFAULT SETTINGS
	local defaultPreset = "RoundBar"
	self.defaults = {
		profile = {
			enable = true,
			gap = 150,
			verticalPos = -110,
			horizontalPos = 0,
			scale = 0.9,

			alphaooc = 0.3,
			alphaic = 0.6,
			alphaTarget = 0.4,
			alphaNotFull = 0.4,

			alphaoocbg = 0.2,
			alphaicbg = 0.3,
			alphaTargetbg = 0.25,
			alphaNotFullbg = 0.25,

			backgroundToggle = false,
			backgroundColor = {r = 0.5, g = 0.5, b = 0.5},
			barTexture = "Bar",
			barPreset = defaultPreset,
			fontFamily = "Arial Narrow",
			debug = false,

			barBlendMode = "BLEND",
			barBgBlendMode = "BLEND",

			bShouldUseDogTags = true,

			updatePeriod = 0.1,
			minimap = {},
		},
		global = {
			lastRunVersion = 0,
		},
	}

	self:LoadPresets()
	for k, v in pairs(self.presets[defaultPreset]) do
		self.defaults.profile[k] = v
	end

	-- get default settings from the modules
	self.defaults.profile.modules = {}
	for i = 1, table.getn(self.elements) do
		local name = self.elements[i]:GetElementName()
		self.defaults.profile.modules[name] = self.elements[i]:GetDefaultSettings()
	end

	if (table.getn(self.elements) > 0) then
		self.defaults.profile.colors = self.elements[1].defaultColors
	end
end


StaticPopupDialogs["ICEHUD_CONVERTED_TO_ACE3"] =
{
	text = "(If this is your first time running IceHUD, please disregard this message)\n\nSince the last version of IceHUD you ran, we have upgraded to Ace3! This means that if you were using a custom profile for your settings you may need to open the /icehud options and re-choose it. You'll only need to do this once.\n\nThanks for using IceHUD!",
	button1 = OKAY,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 0,
}

function IceCore.prototype:CheckDisplayUpdateMessage()
	local thisVersion
--@non-debug@
	thisVersion = 609
--@end-non-debug@
--[===[@debug@
	thisVersion = 9999
--@end-debug@]===]
	if self.accountSettings.lastRunVersion < thisVersion then
		if self.accountSettings.lastRunVersion < 549 then
			StaticPopup_Show("ICEHUD_CONVERTED_TO_ACE3")
		end
		self.accountSettings.lastRunVersion = thisVersion
	end
end


function IceCore.prototype:Enable(userToggle)
	if userToggle then
		self.settings.enable = true
	end

	self:DrawFrame()

	for i = 1, table.getn(self.elements) do
		-- make sure there are settings for this bar (might not if we make a new profile with existing custom bars)
		if self.settings.modules[self.elements[i].elementName] then
			self.elements[i]:Create(self.IceHUDFrame)
			if (self.elements[i]:IsEnabled()) then
				self.elements[i]:Enable(true)
			end
		end
	end

	-- go through the list of loaded elements that don't have associated settings and dump them
	toRemove = {}
	for i = #self.elements, 1, -1 do
		if not self.settings.modules[self.elements[i]:GetElementName()] then
			toRemove[#toRemove + 1] = i
		end
	end
	for i=1,#toRemove do
		table.remove(self.elements, toRemove[i])
	end

	for k,v in pairs(self.settings.modules) do
		if self.settings.modules[k].customBarType == "Bar" and IceCustomBar ~= nil then
			local newBar
			newBar = IceCustomBar:new()
			newBar.elementName = k
			self:AddNewDynamicModule(newBar, true)
		elseif self.settings.modules[k].customBarType == "Counter" and IceCustomCount ~= nil then
			local newCounter
			newCounter = IceCustomCount:new()
			newCounter.elementName = k
			self:AddNewDynamicModule(newCounter, true)
		elseif self.settings.modules[k].customBarType == "CD" and IceCustomCDBar ~= nil then
			local newCD
			newCD = IceCustomCDBar:new()
			newCD.elementName = k
			self:AddNewDynamicModule(newCD, true)
		elseif self.settings.modules[k].customBarType == "Health" and IceCustomHealth ~= nil then
			local newHealth
			newHealth = IceCustomHealth:new()
			newHealth.elementName = k
			self:AddNewDynamicModule(newHealth, true)
		elseif self.settings.modules[k].customBarType == "Mana" and IceCustomMana ~= nil then
			local newMana
			newMana = IceCustomMana:new()
			newMana.elementName = k
			self:AddNewDynamicModule(newMana, true)
		end
	end

	if self.settings.updatePeriod == nil then
		self.settings.updatePeriod = 0.1
	end

	-- make sure the module options are re-generated. if we switched profiles, we don't want the old elements hanging around
	IceHUD:GenerateModuleOptions()

	self.enabled = true
end


function IceCore.prototype:AddNewDynamicModule(module, hasSettings)
	if not hasSettings then
		self.settings.modules[module.elementName] = module:GetDefaultSettings()
	end

	module:SetDatabase(self.settings)

	if not hasSettings then
		local numExisting = self:GetNumCustomModules(module, module:GetDefaultSettings().customBarType)
		self:RenameDynamicModule(module, "MyCustom"..module:GetDefaultSettings().customBarType..(numExisting+1))
	end

	module:Create(self.IceHUDFrame)
	if (module:IsEnabled()) then
		module:Enable(true)
	end

	IceHUD:GenerateModuleOptions()
end


function IceCore.prototype:GetNumCustomModules(exceptMe, customBarType)
	local num = 0
	local foundNum = 0

	for i=1,table.getn(self.elements) do
		if (self.elements[i] and self.elements[i] ~= exceptMe and
			customBarType == self.elements[i].moduleSettings.customBarType) then
			local str = self.elements[i].elementName:match("MyCustom"..(customBarType).."%d+")
			if str then
				foundNum = str:match("%d+")
			end

			num = max(num, foundNum)
		end
	end

	return num
end


function IceCore.prototype:DeleteDynamicModule(module)
	if module:IsEnabled() then
		module:Disable()
	end

	local ndx
	for i = 1,table.getn(self.elements) do
		if (self.elements[i] == module) then
			ndx = i
			break
		end
	end

	table.remove(self.elements,ndx)
	self.settings.modules[module.elementName] = nil

	IceHUD:GenerateModuleOptions()
end


function IceCore.prototype:RenameDynamicModule(module, newName)
	self.settings.modules[newName] = self.settings.modules[module.elementName]
	self.settings.modules[module.elementName] = nil

	module.elementName = newName

	IceHUD:GenerateModuleOptions()

	LibStub("AceConfigDialog-3.0"):SelectGroup("IceHUD", "modules", newName)
end


function IceCore.prototype:ProfileChanged()
	self:SetModuleDatabases()

	self:Redraw()
end


function IceCore.prototype:SetModuleDatabases()
	for i = 1, table.getn(self.elements) do
		self.elements[i]:SetDatabase(self.settings)
	end
end


function IceCore.prototype:Disable(userToggle)
	if userToggle then
		self.settings.enable = false
	end

	self:ConfigModeToggle(false)

	for i = 1, table.getn(self.elements) do
		if (self.elements[i]:IsEnabled()) then
			self.elements[i]:Disable(true)
		end
	end

	self.IceHUDFrame:Hide()
	self:EmptyUpdates()

	for i=#self.elements, 1, -1 do
		if self.elements[i].moduleSettings.customBarType ~= nil then
			table.remove(self.elements, i)
		end
	end

	self.enabled = false
end


function IceCore.prototype:IsEnabled()
	return self.enabled
end

function IceCore.prototype:DrawFrame()
	self.IceHUDFrame:SetFrameStrata("BACKGROUND")
	self.IceHUDFrame:SetWidth(self.settings.gap)
	self.IceHUDFrame:SetHeight(20)

	self:SetScale(self.settings.scale)

	self.IceHUDFrame:SetPoint("CENTER", self.settings.horizontalPos, self.settings.verticalPos)
	self.IceHUDFrame:Show()
end


function IceCore.prototype:Redraw()
	for i = 1, table.getn(self.elements) do
		self.elements[i]:Redraw()
	end
end


function IceCore.prototype:GetModuleOptions()
	local options = {}

	options["aaaClickPlus"] = {
		type = 'description',
		fontSize = 'large',
		name = 'Click the + next to |cffffdc42Module Settings|r to see the available modules that you can tweak.\n\nAlso notice that some modules have a + next to them. This will open up additional settings such as text tweaks and icon tweaks on that module.',
		order = 1
	}

	for i = 1, table.getn(self.elements) do
		local modName = self.elements[i]:GetElementName()
		local opt = self.elements[i]:GetOptions()
		options[modName] =  {
			type = 'group',
			desc = 'Module options',
			name = modName,
			args = opt
		}
	end

	return options
end


function IceCore.prototype:GetColorOptions()
	assert(table.getn(IceHUD.IceCore.elements) > 0, "Unable to get color options, no elements found!")

	local options = {}

	for k, v in pairs(self.elements[1]:GetColors()) do
		local kk, vv = k, v
		options[k] =  {
			type = 'color',
			desc = k,
			name = k,
			get = function()
				return IceHUD.IceCore:GetColor(kk)
			end,
			set = function(info, r, g, b)
				local color = k
				IceHUD.IceCore:SetColor(kk, r, g, b)
			end
		}
	end

	return options
end


-- Method to handle module registration
function IceCore.prototype:Register(element)
	assert(element, "Trying to register a nil module")
	IceHUD:Debug("Registering: " .. element:ToString())
	table.insert(self.elements, element)
end



-------------------------------------------------------------------------------
-- Configuration methods                                                     --
-------------------------------------------------------------------------------

function IceCore.prototype:GetVerticalPos()
	return self.settings.verticalPos
end
function IceCore.prototype:SetVerticalPos(value)
	self.settings.verticalPos = value
	self.IceHUDFrame:ClearAllPoints()
	self.IceHUDFrame:SetPoint("CENTER", self.settings.horizontalPos, self.settings.verticalPos)
end

function IceCore.prototype:GetHorizontalPos()
	return self.settings.horizontalPos
end
function IceCore.prototype:SetHorizontalPos(value)
	self.settings.horizontalPos = value
	self.IceHUDFrame:ClearAllPoints()
	self.IceHUDFrame:SetPoint("CENTER", self.settings.horizontalPos, self.settings.verticalPos)
end


function IceCore.prototype:GetGap()
	return self.settings.gap
end
function IceCore.prototype:SetGap(value)
	self.settings.gap = value
	self.IceHUDFrame:SetWidth(self.settings.gap)
	self:Redraw()
end


function IceCore.prototype:GetScale()
	return self.settings.scale
end
function IceCore.prototype:SetScale(value)
	self.settings.scale = value

	self.IceHUDFrame:SetScale(value)
end


function IceCore.prototype:GetAlpha(mode)
	if (mode == "IC") then
		return self.settings.alphaic
	elseif (mode == "Target") then
		return self.settings.alphaTarget
	elseif (mode == "NotFull") then
		return self.settings.alphaNotFull
	else
		return self.settings.alphaooc
	end
end
function IceCore.prototype:SetAlpha(mode, value)
	if (mode == "IC") then
		self.settings.alphaic = value
	elseif (mode == "Target") then
		self.settings.alphaTarget = value
	elseif (mode == "NotFull") then
		self.settings.alphaNotFull = value
	else
		self.settings.alphaooc = value
	end
	self:Redraw()
end


function IceCore.prototype:GetAlphaBG(mode)
	if (mode == "IC") then
		return self.settings.alphaicbg
	elseif (mode == "Target") then
		return self.settings.alphaTargetbg
	elseif (mode == "NotFull") then
		return self.settings.alphaNotFullbg
	else
		return self.settings.alphaoocbg
	end
end
function IceCore.prototype:SetAlphaBG(mode, value)
	if (mode == "IC") then
		self.settings.alphaicbg = value
	elseif (mode == "Target") then
		self.settings.alphaTargetbg = value
	elseif (mode == "NotFull") then
		self.settings.alphaNotFullbg = value
	else
		self.settings.alphaoocbg = value
	end
	self:Redraw()
end


function IceCore.prototype:GetBackgroundToggle()
	return self.settings.backgroundToggle
end
function IceCore.prototype:SetBackgroundToggle(value)
	self.settings.backgroundToggle = value
	self:Redraw()
end


function IceCore.prototype:GetBackgroundColor()
	local c = self.settings.backgroundColor
	return c.r, c.g, c.b
end
function IceCore.prototype:SetBackgroundColor(r, g, b)
	self.settings.backgroundColor.r = r
	self.settings.backgroundColor.g = g
	self.settings.backgroundColor.b = b
	self:Redraw()
end


function IceCore.prototype:GetBarTexture()
	return self.settings.barTexture
end
function IceCore.prototype:SetBarTexture(value)
	self.settings.barTexture = value
	self:Redraw()
end


function IceCore.prototype:GetBarBlendMode()
	return self.settings.barBlendMode
end
function IceCore.prototype:SetBarBlendMode(value)
	self.settings.barBlendMode = value
	self:Redraw()
end


function IceCore.prototype:GetBarBgBlendMode()
	return self.settings.barBgBlendMode
end
function IceCore.prototype:SetBarBgBlendMode(value)
	self.settings.barBgBlendMode = value
	self:Redraw()
end


function IceCore.prototype:GetBarWidth()
	return self.settings.barWidth
end
function IceCore.prototype:SetBarWidth(value)
	self.settings.barWidth = value
	self:Redraw()
end


function IceCore.prototype:GetBarHeight()
	return self.settings.barHeight
end
function IceCore.prototype:SetBarHeight(value)
	self.settings.barHeight = value
	self:Redraw()
end


function IceCore.prototype:GetBarProportion()
	return self.settings.barProportion
end
function IceCore.prototype:SetBarProportion(value)
	self.settings.barProportion = value
	self:Redraw()
end


function IceCore.prototype:GetBarSpace()
	return self.settings.barSpace
end
function IceCore.prototype:SetBarSpace(value)
	self.settings.barSpace = value
	self:Redraw()
end


function IceCore.prototype:GetBarPreset()
	return self.settings.barPreset
end
function IceCore.prototype:SetBarPreset(value)
	self.settings.barPreset = value
	self:ChangePreset(value)
	self:Redraw()
end
function IceCore.prototype:ChangePreset(value)
	self:SetBarTexture(self.presets[value].barTexture)
	self:SetBarHeight(self.presets[value].barHeight)
	self:SetBarWidth(self.presets[value].barWidth)
	self:SetBarSpace(self.presets[value].barSpace)
	self:SetBarProportion(self.presets[value].barProportion)
	self:SetBarBlendMode(self.presets[value].barBlendMode)
	self:SetBarBgBlendMode(self.presets[value].barBgBlendMode)

	IceHUD:NotifyOptionsChange()
end


function IceCore.prototype:GetFontFamily()
	return self.settings.fontFamily
end
function IceCore.prototype:SetFontFamily(value)
	self.settings.fontFamily  = value
	self:Redraw()
end


function IceCore.prototype:GetDebug()
	return self.settings.debug
end
function IceCore.prototype:SetDebug(value)
	self.settings.debug = value
	IceHUD:SetDebugging(value)
end


function IceCore.prototype:GetColor(color)
	return self.settings.colors[color].r,
		   self.settings.colors[color].g,
		   self.settings.colors[color].b
end
function IceCore.prototype:SetColor(color, r, g, b)
	self.settings.colors[color].r = r
	self.settings.colors[color].g = g
	self.settings.colors[color].b = b

	self:Redraw()
end


function IceCore.prototype:IsInConfigMode()
	return self.bConfigMode
end

function IceCore.prototype:ConfigModeToggle(bWantConfig)
	self.bConfigMode = bWantConfig

	if bWantConfig then
		for i = 1, table.getn(self.elements) do
			if self.elements[i]:IsEnabled() then
				self.elements[i].frame:Show()
				self.elements[i]:Redraw()
				if self.elements[i].IsBarElement then
					self.elements[i]:SetBottomText1(self.elements[i].elementName)
				end
			end
		end
	else
		for i = 1, table.getn(self.elements) do
			if not self.elements[i]:IsVisible() then
				self.elements[i].frame:Hide()
			end

			-- blank the bottom text that we set before. if the module uses this text, it will reset itself on redraw
			if self.elements[i].IsBarElement then
				self.elements[i]:SetBottomText1()
			end

			self.elements[i]:Redraw()
		end
	end
end

function IceCore.prototype:ShouldUseDogTags()
	return LibStub("LibDogTag-3.0", true) and self.settings.bShouldUseDogTags
end

function IceCore.prototype:SetShouldUseDogTags(should)
	self.settings.bShouldUseDogTags = should
end

function IceCore.prototype:UpdatePeriod()
	return self.settings.updatePeriod
end

function IceCore.prototype:SetUpdatePeriod(period)
	self.settings.updatePeriod = period
end

-- For elements that want to receive updates even when hidden
function IceCore.prototype:HandleUpdates()
	local update_period = self:UpdatePeriod()
	local elapsed = 1 / GetFramerate()
	self.update_elapsed = self.update_elapsed + elapsed
	if (self.update_elapsed > update_period) then
		for frame, func in pairs(self.updatees)
		do
			func()
		end
		if (elapsed > update_period) then
			self.update_elapsed = 0
		else
			self.update_elapsed = self.update_elapsed - update_period
		end
	end
end

function IceCore.prototype:RequestUpdates(frame, func)
	self.updatees[frame] = func

	local count = 0
	for k,v in pairs(self.updatees) do
		count = count + 1
	end

	if (count == 0) then
		self.IceHUDFrame:SetScript("OnUpdate", nil)
	else
		self.IceHUDFrame:SetScript("OnUpdate", function() self:HandleUpdates() end)
	end
end

function IceCore.prototype:IsUpdateSubscribed(frame)
	return self.updatees[frame] ~= nil
end

function IceCore.prototype:EmptyUpdates()
	self.IceHUDFrame:SetScript("OnUpdate", nil)
	self.updatees = {}
end

-------------------------------------------------------------------------------
-- Presets                                                                   --
-------------------------------------------------------------------------------

function IceCore.prototype:LoadPresets()
	self.presets["Bar"] = {
		barTexture = "Bar",
		barWidth = 120,
		barHeight = 220,
		barProportion = 0.15,
		barSpace = 3,
		barBlendMode = "BLEND",
		barBgBlendMode = "BLEND",
	}

	self.presets["HiBar"] = {
		barTexture = "HiBar",
		barWidth = 63,
		barHeight = 150,
		barProportion = 0.34,
		barSpace = 4,
		barBlendMode = "BLEND",
		barBgBlendMode = "BLEND",
	}

	self.presets["RoundBar"] = {
		barTexture = "RoundBar",
		barWidth = 155,
		barHeight = 220,
		barProportion = 0.14,
		barSpace = 1,
		barBlendMode = "BLEND",
		barBgBlendMode = "BLEND",
	}

	self.presets["ColorBar"] = {
		barTexture = "ColorBar",
		barWidth = 120,
		barHeight = 220,
		barProportion = 0.15,
		barSpace = 3,
		barBlendMode = "Blend",
		barBgBlendMode = "BLEND",
	}

	self.presets["RivetBar"] = {
		barTexture = "RivetBar",
		barWidth = 120,
		barHeight = 220,
		barProportion = 0.15,
		barSpace = 3,
		barBlendMode = "BLEND",
		barBgBlendMode = "BLEND",
	}

	self.presets["RivetBar2"] = {
		barTexture = "RivetBar2",
		barWidth = 120,
		barHeight = 220,
		barProportion = 0.15,
		barSpace = 3,
		barBlendMode = "BLEND",
		barBgBlendMode = "BLEND",
	}

	self.presets["CleanCurves"] = {
		barTexture = "CleanCurves",
		barWidth = 155,
		barHeight = 220,
		barProportion = 0.14,
		barSpace = 1,
		barBlendMode = "BLEND",
		barBgBlendMode = "BLEND",
	}

	self.presets["GlowArc"] = {
		barTexture = "GlowArc",
		barWidth = 155,
		barHeight = 220,
		barProportion = 0.14,
		barSpace = 1,
		barBlendMode = "ADD",
		barBgBlendMode = "ADD",
	}

	self.presets["BloodGlaives"] = {
		barTexture = "BloodGlaives",
		barWidth = 155,
		barHeight = 220,
		barProportion = 0.14,
		barSpace = 1,
		barBlendMode = "ADD",
		barBgBlendMode = "BLEND",
	}

	self.presets["ArcHUD"] = {
		barTexture = "ArcHUD",
		barWidth = 160,
		barHeight = 300,
		barProportion = 0.15,
		barSpace = 3,
		barBlendMode = "BLEND",
		barBgBlendMode = "BLEND",
	}

	self.presets["FangRune"] = {
		barTexture = "FangRune",
		barWidth = 155,
		barHeight = 220,
		barProportion = 0.14,
		barSpace = 1,
		barBlendMode = "BLEND",
		barBgBlendMode = "BLEND",
	}
end

