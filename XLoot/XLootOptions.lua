local L = AceLibrary("AceLocale-2.2"):new("XLoot")

local _G = getfenv(0)

function XLoot:optGetKey(table, value)
	for k, v in pairs(table) do
		if value == v then 
			return k
		end
	end
end

function XLoot:DoOptions()
	self.opts_qualitykeys = {}
	self.opts_partyconditions = { always = ALWAYS, party = PARTY, raid = RAID, never = CAMERA_NEVER }
	for i = 0, 6 do
		self.opts_qualitykeys[i+1] = ITEM_QUALITY_COLORS[i].hex.._G["ITEM_QUALITY"..tostring(i).."_DESC"].."|r"
	end
		
	local db = self.db.profile
	local hcolor = "|cFF77BBFF"
	XLoot.opts = {
		type = "group",
		args = {
			header = {
				type = "header",
				name = hcolor..L["guiTitle"].."  |c88888888"..self.revision,
				icon = "Interface\\Buttons\\UI-GroupLoot-Dice-Up",
				iconHeight = 32,
				iconWidth = 32,
				order = 1
			}, 
			lock = {
				type = "toggle",
				name = L["optLock"],
				desc = L["descLock"],
					get = function()
					return db.lock
					end,
				set = function(v)
					db.lock = v
					end,
					order = 2
			},
			mspacer = {
				type = "header",
				order = 3
			},
			options = {
				type = "execute",
				name = L["optOptions"],
				desc = L["descOptions"],
				func = function() self:OpenMenu(UIParent) end,
				order = 100,
				guiHidden = true
			},
			behavior = {
				type = "group",
				name = L["optBehavior"],
				desc = L["descBehavior"],
				order = 5,
				args = {
					bheader1 = {
						type = "header",
						name = hcolor..L["catSnap"],
						order = 1
					},
					cursor = {
						type = "toggle",
						name = L["optCursor"],
						desc = L["descCursor"],
							get = function()
							return db.cursor
							end,
						set = function(v)
							XLootFrame:SetUserPlaced(v)
							db.pos.x = nil
							db.pos.y = nil
							db.cursor = v
							end,
							order = 2
					},
					smartsnap = {
						type = "toggle",
						name = L["optSmartsnap"],
						desc = L["descSmartsnap"],
							get = function()
							return db.smartsnap
							end,
						set = function(v)
							db.smartsnap = v
							end,
							order = 3
					},
					snapoffset = {
						type = "range",
						name = L["optSnapoffset"],
						desc = L["descSnapoffset"],
							get = function()
							return db.snapoffset
							end,
						set = function(v)
							db.snapoffset = v
							end,
						min = -100,
						max = 100,
						step = 1,
						order = 5
					},
					bspacer1 = {
						type = "header",
						order = 7
					},
					bheader2 = {
						type = "header",
						name = hcolor..L["catLoot"],
						order = 7
					},
					collapse = {
						type = "toggle",
						name = L["optCollapse"],
						desc = L["descCollapse"],
						get = function()
							return db.collapse
							end,
						set = function(v)
							db.collapse = v
							end,
						order = 9
					},
					lootexpand = {
						type = "toggle",
						name = L["optLootexpand"],
						desc = L["descLootexpand"],
						get = function()
							return db.lootexpand
							end,
						set = function(v)
							db.lootexpand = v
							end,
						order = 11
					},
					bspacer2 = {
						type = "header",
						order = 13
					},
					bheader3 = {
						type = "header",
						name = hcolor..L["catFrame"],
						order = 13
					},
					dragborder = {
						type = "toggle",
						name = L["optDragborder"],
						desc = L["descDragborder"],
						get = function()
							return db.dragborder
							end,
						set = function(v)
							self.frame:EnableMouse(v)
							db.dragborder = v
							end,
						order = 15
					},
					altoptions = {
						type = "toggle",
						name = L["optAltoptions"],
						desc = L["descAltoptions"],
						get = function()
							return db.altoptions
							end,
						set = function(v)
							db.altoptions = v
							end,
						order = 17
					},
					swiftloot = {
						type = "toggle",
						name = L["optSwiftloot"],
						desc = L["descSwiftloot"],
						get = function()
							return db.swiftloot
							end,
						set = function(v)
							db.swiftloot = v
							self:SwiftMouseDeuce(v)
							end,
						order = 19
					},
					bspacer3 = {
						type = "header",
						order = 21
					},
					bheader4 = {
						type = "header",
						name = hcolor..L["catInfo"],
						order = 21
					},
					qualitytext = {
						type = "toggle",
						name = L["optQualitytext"],
						desc = L["descQualitytext"],
						get = function()
							return db.qualitytext
							end,
						set = function(v)
							db.qualitytext = v
							end,
						order = 23
					},
					infotext = {
						type = "toggle",
						name = L["optInfotext"],
						desc = L["descInfotext"],
						get = function()
							return db.infotext
							end,
						set = function(v)
							db.infotext = v
							end,
						order = 25
					},
					bindtext = {
						type = "toggle",
						name = L["Show BoP/BoE/BoU"],
						desc = L["Show Bind on Pickup/Bind on Equip/Bind on Use text opposite stack size for items"],
						get = function()
							return db.bindtext
							end,
						set = function(v)
							db.bindtext = v
							end,
						order = 26
					},
					bspacer4 = {
						type = "header",
						order = 27
					},
					bheader5 = {
						type = "header",
						name = hcolor..L["optLinkAll"],
						order = 29
					},
					linkallvis = {
						type = "text",
						name = L["optLinkAllVis"]..self.opts_partyconditions[db.linkallvis],
						desc = L["descLinkAllVis"],
						get = function() return self.opts_partyconditions[db.linkallvis] end,
						set = function(v) db.linkallvis = v; self.opts.args.behavior.args.linkallvis.name = L["optLinkAllVis"]..self.opts_partyconditions[v]; end,
						validate = self.opts_partyconditions,
						order = 31
					},
					linkallthreshold = {
						type = "text",
						name = L["optLinkAllThreshold"],
						desc = L["descLinkAllThreshold"],
						get = function() return self.opts_qualitykeys[db.linkallthreshold+1] end,
						set = function(v) db.linkallthreshold = self:optGetKey(self.opts_qualitykeys, v) - 1 end,
						validate = self.opts_qualitykeys,
						order = 33
					},
					linkallchannels = {
						type = "group",
						name = L.optLinkAllChannels,
						desc = L.descLinkAllChannels,
						args = {
							header = {
								type = "header",
								name = "|cFF77BBFF"..CHANNELS,
								order = 1
							},
						},
						order = 35
					},
				},
			},
			appearance = {
				type = "group",
				name = L["optAppearance"],
				desc = L["descAppearance"],
				order = 7, 
				args = {
					aheader = {
						type = "header",
						name = hcolor..L["catGeneralAppearance"],
						order = 1
					},
					scale = {
						type = "range",
						name = L["optScale"],
						desc = L["descScale"],
						get = function()
							return db.scale
							end,
						set = function(v)
							db.scale = v
							self.frame:SetScale(v)
							end,
						min = 0.5,
						max = 1.5,
						step = 0.05,
						order = 5
					},
					alpha = {
						type = "range",
						name = L["Alpha"],
						desc = L["Alpha"],
						get = function() return db.alpha end,
						set = function(v) db.alpha = v self.frame:SetAlpha(v) end,
						min = 0.05,
						max = 1,
						step = 0.05,
						order = 6
					},
					aspacer = {
						type = "header",
						order = 7
					},
					aheader1 = {
						type = "header",
						name = hcolor..L["catFrameAppearance"],
						order = 8
					},
					qualityborder = {
						type = "toggle",
						name = L["optQualityborder"],
						desc = L["descQualityborder"],
							get = function()
							return db.qualityborder
							end,
						set = function(v)
							db.qualityborder = v
							end,
						order = 9
					},
					qualityframe = {
						type = "toggle",
						name = L["optQualityframe"],
						desc = L["descQualityframe"],
							get = function()
							return db.qualityframe
							end,
						set = function(v)
							db.qualityframe = v
							end,
						order = 11
					},
					bgcolor = {
						type = "color",
						name = L["optBgcolor"].." ",
						desc = L["descBgcolor"],
						get = function()
							return unpack(db.bgcolor)
						end,
						set = function(r, g, b, a)
							db.bgcolor = { r, g, b, a }
							self.frame:SetBackdropColor(r, g, b, a)
						end,
						hasAlpha = true,
						order = 13
					},
					bordercolor = {
						type = "color",
						name = L["optBordercolor"],
						desc = L["descBordercolor"],
						get = function()
							return unpack(db.bordercolor)
						end,
						set = function(r, g, b, a)
							db.bordercolor = { r, g, b, a }
							self.frame:SetBackdropBorderColor(r, g, b, a)
						end, 
						hasAlpha = true,
						order = 14,
					},
					aspacer1 = {
						type = "header",
						order = 15,
					},
					aheader2 = {
						type = "header",
						name = hcolor..L["catLootAppearance"],
						order = 17,
					},
					texcolor = {
						type = "toggle",
						name = L["optTexColor"],
						desc = L["descTexColor"],
							get = function()
							return db.texcolor
							end,
						set = function(v)
							db.texcolor = v
							end,
						order = 18
					},
					lootqualityborder = {
						type = "toggle",
						name = L["optLootqualityborder"],
						desc = L["descLootqualityborder"],
							get = function()
							return db.lootqualityborder
							end,
						set = function(v)
							db.lootqualityborder = v
							end,
						order = 19
					},
					loothighlightframe = {
						type = "toggle",
						name = L["optHighlightLoot"],
						desc = L["descHighlightLoot"],
							get = function()
							return db.loothighlightframe
							end,
						set = function(v)
							db.loothighlightframe = v
							end,
						order = 20
					},
					loothighlightthreshold = {
						type = "text",
						name = L["optHighlightThreshold"],
						desc = L["descHighlightThreshold"],
						get = function() return self.opts_qualitykeys[db.loothighlightthreshold+1] end,
						set = function(v) db.loothighlightthreshold = self:optGetKey(self.opts_qualitykeys, v) - 1 end,
						validate = self.opts_qualitykeys,
						order = 21
					},
					lootbgcolor = {
						type = "color",
						name = L["optLootbgcolor"],
						desc = L["descLootbgcolor"],
						get = function()
							return unpack(db.lootbgcolor)
						end,
						set = function(r, g, b, a)
							db.lootbgcolor = { r, g, b, a }
							local i
							for i = 1, self.numButtons do
								self.frames[i]:SetBackdropColor(r, g, b, a)
							end
						end,
						hasAlpha = true,
						order = 22
					},
					lootbordercolor = {
						type = "color",
						name = L["optLootbordercolor"],
						desc = L["descLootbordercolor"],
						get = function()
							return unpack(db.lootbordercolor)
						end,
						set = function(r, g, b, a)
							db.lootbordercolor = { r, g, b, a }
							local i
							for i = 1, self.numButtons do
								self.frames[i]:SetBackdropBorderColor(r, g, b, a)
							end
						end, 
						hasAlpha = true,
						order = 24
					},
					infocolorspacer = {
						type = "header",
						order = 25,
					},
					infocolor = {
						type = "color",
						name = L["optInfoColor"],
						desc = L["descInfoColor"],
						get = function()
							return unpack(db.infocolor)
						end,
						set = function(r, g, b)
							db.infocolor = { r, g, b }
						end, 
						order = 36,
					},
				},
			},
			advanced = {
				type = "group",
				name = "|c77AAAAAA"..L["optAdvanced"],
				desc = "|c77AAAAAA"..L["descAdvanced"],
				order = 80,
				args = {
					debug = {
						type = "toggle",
						name = L["optDebug"],
						desc = L["descDebug"],
						get = function()
							return db.debug
							end,
						set = function(v)
							db.debug = v
							end,
						order = 1
					},
					adspacer = {
						type = "header",
						order = 7
					},
					defaults = {
						type = "execute",
						name = "|cFFFF5522"..L["optDefaults"],
						desc = L["descDefaults"],
						func = function() self:Defaults() end, 
						order = 10
					}
				}
			},
		}
	}

	-- What a long freaking menu for channnneeellllllsssssss hateee hate HATE rrrrrrawr.
	self.linkallchannelorder = 2
	self.opt_addchannel = function(name, ref, extchannel)
		if not name then
			self.opts.args.behavior.args.linkallchannels.args["spacer"..self.linkallchannelorder] = {
				type = "header",
				order = self.linkallchannelorder
			}
		else
			if not db.linkallchannels[ref] then db.linkallchannels[ref] = false end
			self.opts.args.behavior.args.linkallchannels.args[ref] = {
				type = "toggle",
				name = name,
				desc = string.format(L["linkallchanneldesc"], name),
				get = function() return (db.linkallchannels and db.linkallchannels[ref] ~= false) end,
				set = function(v) db.linkallchannels[ref] = v and { extchannel = extchannel } or false end,
				order = self.linkallchannelorder
			}
		end
		self.linkallchannelorder = self.linkallchannelorder +1
	end
	for k, v in pairs(ChannelMenuChatTypeGroups) do
		if v ~= "WHISPER" then
			self.opt_addchannel(_G["CHAT_MSG_"..v], v)
		end
	end
	self.opt_addchannel(CHAT_MSG_OFFICER, "OFFICER")
	self.opt_addchannel(CHAT_MSG_RAID, "RAID")
	self.opt_addchannel(CHAT_MSG_RAID_WARNING, "RAID_WARNING")
	self.opt_addchannel()
	local channellist = {GetChannelList()}
	local number = nil
	for k, v in pairs(channellist) do
		if type(v) == "string" then
			local cnum, cname = GetChannelName(number)
			self.opt_addchannel((cnum > 0 and cnum or number).." - "..v, v, true)
		else
			number = v
		end
	end

	self:RegisterChatCommand({ "/xloot" }, self.opts)
end