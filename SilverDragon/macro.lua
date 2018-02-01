local core = LibStub("AceAddon-3.0"):GetAddon("SilverDragon")
local module = core:NewModule("Macro", "AceEvent-3.0", "AceConsole-3.0")

function module:OnInitialize()
	self.db = core.db:RegisterNamespace("Macro", {
		profile = {
			enabled = true,
		},
	})
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")

	local config = core:GetModule("Config", true)
	if config then
		local function toggle(name, desc)
			return {type = "toggle", name = name, desc = desc,}
		end
		config.options.plugins.macro = {
			macro = {
				type = "group",
				name = "Macro",
				get = function(info) return self.db.profile[info[#info]] end,
				set = function(info, v) self.db.profile[info[#info]] = v end,
				args = {
					about = {
						type = "description",
						name = "Creates a button that can be used in a macro to target rares that might be nearby.\n\n"..
							"Either create a macro that says: /click SilverDragonMacroButton\n\n"..
							"...or click the \"Create Macro\" button below. It'll make a new macro called SilverDragon. Drag it to your bars and click it to target rares that might be nearby.",
						order = 0,
					},
					create = {
						type = "execute",
						name = "Create Macro",
						desc = "Click this to create the macro",
						func = function()
							self:CreateMacro()
						end
					},
				},
			},
		}
	end

	self:ZONE_CHANGED_NEW_AREA()
end

function module:Update()
	if not self.db.profile.enabled then return end
	-- first, create the macro text on the button:
	local zone = core:GetPlayerLocation()
	local mobs = core.db.global.mobs_byzone[zone]
	if not mobs then return end
	local macro = {}
	for mob in pairs(mobs) do
		table.insert(macro, "/targetexact "..mob)
	end
	self.button:SetAttribute("macrotext", ("\n"):join(unpack(macro)))
	table.wipe(macro)
end

function module:CreateMacro()
	if InCombatLockdown() then
		return self:Print("|cffff0000Can't make a macro while in combat!|r")
	end
	LoadAddOn("Blizzard_MacroUI") -- required for MAX_ACCOUNT_MACROS
	local macroIndex = GetMacroIndexByName("SilverDragon")
	if macroIndex == 0 then
		local numglobal,numperchar = GetNumMacros()
		if numglobal < MAX_ACCOUNT_MACROS then
			--/script for i=1,GetNumMacroIcons() do if GetMacroIconInfo(i):match("SniperTraining$") then DEFAULT_CHAT_FRAME:AddMessage(i) end end
			CreateMacro("SilverDragon", 180, "/click SilverDragonMacroButton", nil, nil)
			self:Print("Created the SilverDragon macro. Open the macro editor with /macro and drag it onto your actionbar to use it.")
		else
			self:Print("|cffff0000Couldn't create rare-scanning macro, too many macros already created.|r")
		end
	else
		self:Print("|cffff0000A macro named SilverDragon already exists.|r")
	end
end

function module:ZONE_CHANGED_NEW_AREA(...)
	if InCombatLockdown() then
		self.waiting = true
	else
		self:Update()
	end
end

function module:PLAYER_REGEN_ENABLED()
	if self.waiting then
		self:Update()
	end
end

local button = CreateFrame("Button", "SilverDragonMacroButton", nil, "SecureActionButtonTemplate")
button:SetAttribute("type", "macro")
button:SetAttribute("macrotext", "/script DEFAULT_CHAT_FRAME:AddMessage('SilverDragon Macro: Not initialized yet.', 1, 0, 0)")
module.button = button

