local core = LibStub("AceAddon-3.0"):GetAddon("SilverDragon")
local module = core:NewModule("Announce", "LibSink-2.0")

local LSM = LibStub("LibSharedMedia-3.0")

-- Register some media
LSM:Register("sound", "Rubber Ducky", [[Sound\Doodad\Goblin_Lottery_Open01.wav]])
LSM:Register("sound", "Cartoon FX", [[Sound\Doodad\Goblin_Lottery_Open03.wav]])
LSM:Register("sound", "Explosion", [[Sound\Doodad\Hellfire_Raid_FX_Explosion05.wav]])
LSM:Register("sound", "Shing!", [[Sound\Doodad\PortcullisActive_Closed.wav]])
LSM:Register("sound", "Wham!", [[Sound\Doodad\PVP_Lordaeron_Door_Open.wav]])
LSM:Register("sound", "Simon Chime", [[Sound\Doodad\SimonGame_LargeBlueTree.wav]])
LSM:Register("sound", "War Drums", [[Sound\Event Sounds\Event_wardrum_ogre.wav]])
LSM:Register("sound", "Cheer", [[Sound\Event Sounds\OgreEventCheerUnique.wav]])
LSM:Register("sound", "Humm", [[Sound\Spells\SimonGame_Visual_GameStart.wav]])
LSM:Register("sound", "Short Circuit", [[Sound\Spells\SimonGame_Visual_BadPress.wav]])
LSM:Register("sound", "Fel Portal", [[Sound\Spells\Sunwell_Fel_PortalStand.wav]])
LSM:Register("sound", "Fel Nova", [[Sound\Spells\SeepingGaseous_Fel_Nova.wav]])

function module:OnInitialize()
	self.db = core.db:RegisterNamespace("Announce", {
		profile = {
			sink = true,
			sound = true,
			soundfile = "Wham!",
			flash = true,
			sink_opts = {},
		},
	})

	self:SetSinkStorage(self.db.profile.sink_opts)
	core.RegisterCallback(self, "Seen")

	local config = core:GetModule("Config", true)
	if config then
		local function toggle(name, desc)
			return {
				type = "toggle",
				name = name,
				desc = desc,
			}
		end
		config.options.plugins.announce = {
			announce = {
				type = "group",
				name = "Announce",
				get = function(info) return self.db.profile[info[#info]] end,
				set = function(info, v) self.db.profile[info[#info]] = v end,
				args = {
					sink = {
						type = "group", name = "Message", inline = true,
						args = {
							sink = toggle("Message", "Send a message to whatever scrolling text addon you're using."),
							output = self:GetSinkAce3OptionsDataTable()
						},
					},
					sound = toggle("Sound", "Play a sound."),
					soundfile = {
						type = "select", dialogControl = "LSM30_Sound",
						name = "Sound to Play", desc = "Choose a sound file to play.",
						values = AceGUIWidgetLSMlists.sound,
						disabled = function() return not self.db.profile.sound end,
					},
					flash = toggle("Flash", "Flash the edges of the screen."),
				},
			},
		}
	end
end

function module:Seen(callback, zone, name, x, y, dead, newloc, source)
	if self.db.profile.sink then
		self:Pour(("Rare seen: %s%s (%s)"):format(name, dead and "... but it's dead" or '', source or ''))
	end
	if self.db.profile.sound then
		PlaySoundFile(LSM:Fetch("sound", self.db.profile.soundfile))
	end
	if self.db.profile.flash then
		UIFrameFlash(LowHealthFrame, 0.5, 0.5, 6, false, 0.5)
	end
end
