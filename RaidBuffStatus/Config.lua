local L = LibStub('AceLocale-3.0'):GetLocale('RaidBuffStatus')

local buttonoptions = {
	enabledisable = L["Enable/disable buff check"],
	report = L["Report missing to raid"],
	whisper = L["Whisper buffers"],
	buff = L["Buff those missing buff"],
	none = L["None"],
}

local options = { 
	type='group',
	args = {
		show = {
			type = 'execute',
			name = L["Show the buff report dashboard."],
			desc = L["Show the buff report dashboard."],
			func = function()
				RaidBuffStatus:DoReport()
				RaidBuffStatus:ShowReportFrame()
			end,
			guiHidden = true,
		},
		hide = {
			type = 'execute',
			name = L["Hide the buff report dashboard."],
			desc = L["Hide the buff report dashboard."],
			func = function()
				RaidBuffStatus:HideReportFrame()
			end,
			guiHidden = true,
		},
		toggle = {
			type = 'execute',
			name = L["Hide and show the buff report dashboard."],
			desc = L["Hide and show the buff report dashboard."],
			func = function()
				if RaidBuffStatus.frame then
					if RaidBuffStatus.frame:IsVisible() then
						RaidBuffStatus:HideReportFrame()
					else
						RaidBuffStatus:DoReport()
						RaidBuffStatus:ShowReportFrame()
					end
				end
			end,
			guiHidden = true,
		},
		report = {
			type = 'execute',
			name = 'report',
			desc = L["Report to /raid or /party who is not buffed to the max."],
			func = function()
				RaidBuffStatus:DoReport()
				RaidBuffStatus:ReportToChat(true)
			end,
			guiHidden = true,
		},
		debug = {
			type = 'execute',
			name = 'debug',
			desc = 'Toggles debug messages.',
			func = function()
				RaidBuffStatus.db.profile.Debug = not RaidBuffStatus.db.profile.Debug
			end,
			guiHidden = true,
			cmdHidden = true,
		},
		f = {
			type = 'execute',
			name = 'f',
			desc = 'Testin stuff',
			func = function()
				RaidBuffStatus:PingMinimap("test")
			end,
			guiHidden = true,
			cmdHidden = true,
		},
		taunt = {
			type = 'execute',
			name = 'taunt',
			desc = 'Refreshes tank list.',
			func = function()
				RaidBuffStatus:oRA_MainTankUpdate()
			end,
			guiHidden = true,
			cmdHidden = true,
		},
		versions = {
			type = 'execute',
			name = 'versions',
			desc = 'Lists known RBS versions which other people and I have.',
			func = function()
				RaidBuffStatus:Print("Me:" .. RaidBuffStatus.version .. " build-" .. RaidBuffStatus.revision)
				for name, version in pairs(RaidBuffStatus.rbsversions) do
					RaidBuffStatus:Print(name .. ":" .. version)
				end
			end,
			guiHidden = true,
			cmdHidden = false,
		},
		buffwizard = {
			type = 'group',
			name = L["Buff Wizard"],
			desc = L["Automatically configures the dashboard buffs and configuration defaults for your class or raid leading role"],
			order = 1,
			args = {
				intro = {
					type = 'description',
					name = L["The Buff Wizard automatically configures the dashboard buffs and configuration defaults for your class or raid leading role."] .. "\n",
					order = 1,
				},
				raidleader = {
					type = 'execute',
					name = L["Raid leader"],
					desc = L["This is the default configuration in which RBS ships out-of-the-box.  It gives you pretty much anything a raid leader would need to see on the dashboard"],
					order = 2,
					func = function(info, v)
						RaidBuffStatus:SetAllOptions("raidleader")
					end,
				},
				coreraidbuffs = {
					type = 'execute',
					name = L["Core raid buffs"],
					desc = L["Only show the core class raid buffs"],
					order = 3,
					func = function(info, v)
						RaidBuffStatus:SetAllOptions("coreraidbuffs")
					end,
				},
				justmybuffs = {
					type = 'execute',
					name = L["Just my buffs"],
					desc = L["Only show the buffs for which your class is responsible for.  This configuration can be used like a buff-bot where one simply right clicks on the buffs to cast them"],
					order = 4,
					func = function(info, v)
						RaidBuffStatus:SetAllOptions("justmybuffs")
					end,
				},
			},
		},
		consumables = {
			type = 'group',
			name = L["Consumable options"],
			desc = L["Options for setting the quality requirements of consumables"],
			order = 2,
			args = {
				tbcflaskselixirs = {
					type = 'toggle',
					name = L["TBC flasks and elixirs"],
					desc = L["Allow raiders to use level 70 TBC flasks and elixirs"],
					order = 1,
					get = function(info) return RaidBuffStatus.db.profile.TBCFlasksElixirs end,
					set = function(info, v)
						RaidBuffStatus.db.profile.TBCFlasksElixirs = v
					end,
				},
				goodtbc = {
					type = 'toggle',
					name = L["Good TBC"],
					desc = L["Allow raiders to use level 70 TBC flasks and elixirs that are just as good as WotLK flasks and elixirs"] .. " (" .. table.concat(RaidBuffStatus.wotlkgoodtbcflixirs, ", ") .. ")",
					order = 2,
					get = function(info) return RaidBuffStatus.db.profile.GoodTBC end,
					set = function(info, v)
						RaidBuffStatus.db.profile.GoodTBC = v
					end,
				},
				goodfoodonly = {
					type = 'toggle',
					name = L["Good food only"],
					desc = L["Only allow food that is 40 Stamina and other stats.  I.e. only allow the top quality food with highest stats"],
					order = 3,
					get = function(info) return RaidBuffStatus.db.profile.GoodFoodOnly end,
					set = function(info, v)
						RaidBuffStatus.db.profile.GoodFoodOnly = v
					end,
				},
			},
		},
		reporting = {
			type = 'group',
			name = L["Reporting"],
			desc = L["Reporting options"],
			order = 3,
			args = {
				reportchat = {
					type = 'toggle',
					name = L["Report to raid/party"],
					desc = L["Report to raid/party - requires raid assistant"],
					order = 1,
					get = function(info) return RaidBuffStatus.db.profile.ReportChat end,
					set = function(info, v)
						RaidBuffStatus.db.profile.ReportChat = v
					end,
				},
				reportself = {
					type = 'toggle',
					name = L["Report to self"],
					desc = L["Report to self"],
					order = 2,
					get = function(info) return RaidBuffStatus.db.profile.ReportSelf end,
					set = function(info, v)
						RaidBuffStatus.db.profile.ReportSelf = v
					end,
				},
				reportofficer = {
					type = 'toggle',
					name = L["Report to officers"],
					desc = L["Report to officer channel"],
					order = 3,
					get = function(info) return RaidBuffStatus.db.profile.ReportOfficer end,
					set = function(info, v)
						RaidBuffStatus.db.profile.ReportOfficer = v
					end,
				},
				ignorelastthreegroups = {
					type = 'toggle',
					name = L["Ignore groups 6 to 8"],
					desc = L["Ignore groups 6 to 8 when reporting as these are for subs"],
					order = 4,
					get = function(info) return RaidBuffStatus.db.profile.IgnoreLastThreeGroups end,
					set = function(info, v)
						RaidBuffStatus.db.profile.IgnoreLastThreeGroups = v
					end,
				},
				
				prependrbs = {
					type = 'toggle',
					name = L["Prepend RBS::"],
					desc = L["Prepend RBS:: to all lines of report chat. Disable to only prepend on the first line of a report"],
					order = 5,
					get = function(info) return RaidBuffStatus.db.profile.PrependRBS end,
					set = function(info, v)
						RaidBuffStatus.db.profile.PrependRBS = v
					end,
				},
				showgroupnumber = {
					type = 'toggle',
					name = L["Show group number"],
					desc = L["Show the group number of the person missing a party/raid buff"],
					order = 6,
					get = function(info) return RaidBuffStatus.db.profile.ShowGroupNumber end,
					set = function(info, v)
						RaidBuffStatus.db.profile.ShowGroupNumber = v
					end,
				},
				showmany = {
					type = 'toggle',
					name = L["When many say so"],
					desc = L["When at least N people are missing a raid buff say MANY instead of spamming a list"],
					order = 7,
					get = function(info) return RaidBuffStatus.db.profile.ShowMany end,
					set = function(info, v)
						RaidBuffStatus.db.profile.ShowMany = v
					end,
				},
				whispermany = {
					type = 'toggle',
					name = L["Whisper many"],
					desc = L["When whispering and at least N people are missing a raid buff say MANY instead of spamming a list"],
					order = 8,
					get = function(info) return RaidBuffStatus.db.profile.WhisperMany end,
					set = function(info, v)
						RaidBuffStatus.db.profile.WhisperMany = v
					end,
				},
				howmany = {
					type = 'range',
					name = L["How MANY?"],
					desc = L['Set N - the number of people missing a buff considered to be "MANY". This also affects reagent buffing'],
					order = 9,
					min = 1,
					max = 25,
					step = 1,
					bigStep = 1,
					get = function(info) return RaidBuffStatus.db.profile.HowMany end,
					set = function(info, v)
						RaidBuffStatus.db.profile.HowMany = v
					end,
				},
				howoften = {
					type = 'range',
					name = L["Seconds between updates"],
					desc = L["Set how many seconds between dashboard raid scan updates"],
					order = 10,
					min = 1,
					max = 60,
					step = 1,
					bigStep = 5,
					get = function(info) return RaidBuffStatus.db.profile.HowOften end,
					set = function(info, v)
						RaidBuffStatus.db.profile.HowOften = v
						if RaidBuffStatus.timer then
							RaidBuffStatus:CancelTimer(RaidBuffStatus.timer)
							RaidBuffStatus.timer = RaidBuffStatus:ScheduleRepeatingTimer(RaidBuffStatus.DoReport, RaidBuffStatus.db.profile.HowOften)
						end
					end,
				},
--				showmissingblessing = {
--					type = 'toggle',
--					name = L["Show missing blessing"],
--					desc = L["Show the names of the missing Paladin blessings"],
--					order = 11,
--					get = function(info) return RaidBuffStatus.db.profile.ShowMissingBlessing end,
--					set = function(info, v)
--						RaidBuffStatus.db.profile.ShowMissingBlessing = v
--					end,
--				},
				shortmissingblessing = {
					type = 'toggle',
					name = L["Short missing blessing"],
					desc = L["When showing the names of the missing Paladin blessings, show them in short form"],
					order = 11,
					get = function(info) return RaidBuffStatus.db.profile.ShortMissingBlessing end,
					set = function(info, v)
						RaidBuffStatus.db.profile.ShortMissingBlessing = v
					end,
				},
-- The aliens stole my brain before I could write the code for this feature.
--				shortennames = {
--					type = 'toggle',
--					name = L["Shorten names"],
--					desc = L["Shorten names in the report to reduce channel spam"],
--					get = function(info) return RaidBuffStatus.db.profile.ShortenNames end,
--					set = function(info, v)
--						RaidBuffStatus.db.profile.ShortenNames = v
--					end,
--				},
			},
		},
		combat = {
			type = 'group',
			name = L["Combat"],
			desc = L["Combat options"],
			order = 4,
			args = {
				disableincombat = {
					type = 'toggle',
					name = L["Disable in combat"],
					desc = L["Hide dashboard and skip buff checking during combat"],
					get = function(info) return RaidBuffStatus.db.profile.DisableInCombat end,
					set = function(info, v)
						RaidBuffStatus.db.profile.DisableInCombat = v
					end,
				},
			},
		},
		pallypower = {
			type = 'group',
			name = L["Pally Power"],
			desc = L["Options for the integration of Pally Power"],
			order = 5,
			args = {
				usepallypower = {
					type = 'toggle',
					name = L["Use Pally Power"],
					desc = L["If Pally Power is detected then use that for working out who has not buffed, i.e. which Paladins are slacking"],
					order = 1,
					get = function(info) return RaidBuffStatus.db.profile.usepallypower end,
					set = function(info, v)
						RaidBuffStatus.db.profile.usepallypower = v
					end,
				},
				noppifpaladinmissing = {
					type = 'toggle',
					name = L["Only if all have it"],
					desc = L["If a Paladin is missing Pally Power then fall back to not using Pally Power"],
					order = 2,
					get = function(info) return RaidBuffStatus.db.profile.noppifpaladinmissing end,
					set = function(info, v)
						RaidBuffStatus.db.profile.noppifpaladinmissing = v
					end,
				},
			},
		},
		appearance = {
			type = 'group',
			name = L["Appearance"],
			desc = L["Skin and minimap options"],
			order = 6,
			args = {
				minimap = {
					type = 'toggle',
					name = L["Minimap icon"],
					desc = L["Toggle to display a minimap icon"],
					order = 1,
					get = function(info) return RaidBuffStatus.db.profile.MiniMap end,
					set = function(info, v)
						RaidBuffStatus.db.profile.MiniMap = v
						RaidBuffStatus:UpdateMiniMapButton()
					end,
				},
				backgroundcolour = {
					type = 'color',
					name = L["Background colour"],
					desc = L["Background colour"],
					order = 2,
					hasAlpha = true,
					get = function(info)
						local r = RaidBuffStatus.db.profile.bgr
						local g = RaidBuffStatus.db.profile.bgg
						local b = RaidBuffStatus.db.profile.bgb
						local a = RaidBuffStatus.db.profile.bga
						return r, g, b, a
					end,
					set = function(info, r, g, b, a)
						RaidBuffStatus.db.profile.bgr = r
						RaidBuffStatus.db.profile.bgg = g
						RaidBuffStatus.db.profile.bgb = b
						RaidBuffStatus.db.profile.bga = a
						RaidBuffStatus:SetFrameColours()
					end,
				},
				bordercolour = {
					type = 'color',
					name = L["Border colour"],
					desc = L["Border colour"],
					order = 3,
					hasAlpha = true,
					get = function(info)
						local r = RaidBuffStatus.db.profile.bbr
						local g = RaidBuffStatus.db.profile.bbg
						local b = RaidBuffStatus.db.profile.bbb
						local a = RaidBuffStatus.db.profile.bba
						return r, g, b, a
					end,
					set = function(info, r, g, b, a)
						RaidBuffStatus.db.profile.bbr = r
						RaidBuffStatus.db.profile.bbg = g
						RaidBuffStatus.db.profile.bbb = b
						RaidBuffStatus.db.profile.bba = a
						RaidBuffStatus:SetFrameColours()
					end,
				},
				dashboardcolumns = {
					type = 'range',
					name = L["Dashboard columns"],
					desc = L["Number of columns to display on the dashboard"],
					order = 4,
					min = 5,
					max = 25,
					step = 1,
					bigStep = 1,
					get = function() return RaidBuffStatus.db.profile.dashcols end,
					set = function(info, v)
						RaidBuffStatus.db.profile.dashcols = v
						RaidBuffStatus:AddBuffButtons()
					end,
				},
				autoshowdashraid = {
					type = 'toggle',
					name = L["Show in raid"],
					desc = L["Automatically show the dashboard when you join a raid"],
					order = 5,
					get = function(info) return RaidBuffStatus.db.profile.AutoShowDashRaid end,
					set = function(info, v)
						RaidBuffStatus.db.profile.AutoShowDashRaid = v
					end,
				},
				autoshowdashparty = {
					type = 'toggle',
					name = L["Show in party"],
					desc = L["Automatically show the dashboard when you join a party"],
					order = 6,
					get = function(info) return RaidBuffStatus.db.profile.AutoShowDashParty end,
					set = function(info, v)
						RaidBuffStatus.db.profile.AutoShowDashParty = v
					end,
				},
				autoshowdashbattle = {
					type = 'toggle',
					name = L["Show in battleground"],
					desc = L["Automatically show the dashboard when you join a battleground"],
					order = 7,
					get = function(info) return RaidBuffStatus.db.profile.AutoShowDashBattle end,
					set = function(info, v)
						RaidBuffStatus.db.profile.AutoShowDashBattle = v
					end,
				},
				highlightmybuffs = {
					type = 'toggle',
					name = L["Highlight my buffs"],
					desc = L["Hightlight currently missing buffs on the dashboard for which you are responsible including self buffs and buffs which you are missing that are provided by someone else. I.e. show buffs for which you must take action"],
					order = 8,
					get = function(info) return RaidBuffStatus.db.profile.HighlightMyBuffs end,
					set = function(info, v)
						RaidBuffStatus.db.profile.HighlightMyBuffs = v
					end,
				},
				movewithaltclick = {
					type = 'toggle',
					name = L["Move with Alt-click"],
					desc = L["Require the Alt buton to be held down to move the dashboard window"],
					order = 9,
					get = function(info) return RaidBuffStatus.db.profile.movewithaltclick end,
					set = function(info, v)
						RaidBuffStatus.db.profile.movewithaltclick = v
					end,
				},
				hidebossrtrash = {
					type = 'toggle',
					name = L["Hide Boss R Trash"],
					desc = L["Always hide the Boss R Trash buttons"],
					order = 10,
					get = function(info) return RaidBuffStatus.db.profile.hidebossrtrash end,
					set = function(info, v)
						RaidBuffStatus.db.profile.hidebossrtrash = v
						RaidBuffStatus:AddBuffButtons()
					end,
				},
			},
		},
		statusbars = {
			type = 'group',
			name = L["Raid Status Bars"],
			desc = L["Status bars to show raid, dps, tank health, mana, etc"],
			order = 7,
			args = {
				raidhealth = {
					type = 'toggle',
					name = L["Raid health"],
					desc = L["The average party/raid health percent"],
					get = function(info) return RaidBuffStatus.db.profile.RaidHealth end,
					set = function(info, v)
						RaidBuffStatus.db.profile.RaidHealth = v
						RaidBuffStatus:AddBuffButtons()
					end,
					order = 1,
				},
				tankhealth = {
					type = 'toggle',
					name = L["Tank health"],
					desc = L["The average tank health percent"],
					get = function(info) return RaidBuffStatus.db.profile.TankHealth end,
					set = function(info, v)
						RaidBuffStatus.db.profile.TankHealth = v
						RaidBuffStatus:AddBuffButtons()
					end,
					order = 2,
				},
				raidmana = {
					type = 'toggle',
					name = L["Raid mana"],
					desc = L["The average party/raid mana percent"],
					get = function(info) return RaidBuffStatus.db.profile.RaidMana end,
					set = function(info, v)
						RaidBuffStatus.db.profile.RaidMana = v
						RaidBuffStatus:AddBuffButtons()
					end,
					order = 3,
				},
				healermana = {
					type = 'toggle',
					name = L["Healer mana"],
					desc = L["The average healer mana percent"],
					get = function(info) return RaidBuffStatus.db.profile.HealerMana end,
					set = function(info, v)
						RaidBuffStatus.db.profile.HealerMana = v
						RaidBuffStatus:AddBuffButtons()
					end,
					order = 4,
				},
				dpsmana = {
					type = 'toggle',
					name = L["DPS mana"],
					desc = L["The average DPS mana percent"],
					get = function(info) return RaidBuffStatus.db.profile.DPSMana end,
					set = function(info, v)
						RaidBuffStatus.db.profile.DPSMana = v
						RaidBuffStatus:AddBuffButtons()
					end,
					order = 5,
				},
				alive = {
					type = 'toggle',
					name = L["Alive"],
					desc = L["The percentage of people alive in the raid"],
					get = function(info) return RaidBuffStatus.db.profile.Alive end,
					set = function(info, v)
						RaidBuffStatus.db.profile.Alive = v
						RaidBuffStatus:AddBuffButtons()
					end,
					order = 6,
				},
				tanksalive = {
					type = 'toggle',
					name = L["Tanks alive"],
					desc = L["The percentage of tanks alive in the raid"],
					get = function(info) return RaidBuffStatus.db.profile.TanksAlive end,
					set = function(info, v)
						RaidBuffStatus.db.profile.TanksAlive = v
						RaidBuffStatus:AddBuffButtons()
					end,
					order = 7,
				},
				healersalive = {
					type = 'toggle',
					name = L["Healers alive"],
					desc = L["The percentage of healers alive in the raid"],
					get = function(info) return RaidBuffStatus.db.profile.HealersAlive end,
					set = function(info, v)
						RaidBuffStatus.db.profile.HealersAlive = v
						RaidBuffStatus:AddBuffButtons()
					end,
					order = 8,
				},
			},
		},
		mousebuttons = {
			type = 'group',
			name = L["Mouse buttons"],
			desc = L["Dashboard mouse button actions options"],
			order = 8,
			args = {
				leftclick = {
					type = 'select',
					name = L["Left click"],
					desc = L["Select which action to take when you click with the left mouse button over a dashboard buff check"],
					order = 1,
					values = buttonoptions,
					get = function(info) return RaidBuffStatus.db.profile.LeftClick end,
					set = function(info, v)
						RaidBuffStatus.db.profile.LeftClick = v
					end,
				},
				rightclick = {
					type = 'select',
					name = L["Right click"],
					desc = L["Select which action to take when you click with the right mouse button over a dashboard buff check"],
					order = 2,
					values = buttonoptions,
					get = function(info) return RaidBuffStatus.db.profile.RightClick end,
					set = function(info, v)
						RaidBuffStatus.db.profile.RightClick = v
					end,
				},
				controlleftclick = {
					type = 'select',
					name = L["Ctrl-left click"],
					desc = L["Select which action to take when you click with the left mouse button with Ctrl held down over a dashboard buff check"],
					order = 3,
					values = buttonoptions,
					get = function(info) return RaidBuffStatus.db.profile.ControlLeftClick end,
					set = function(info, v)
						RaidBuffStatus.db.profile.ControlLeftClick = v
					end,
				},
				controlrightclick = {
					type = 'select',
					name = L["Ctrl-right click"],
					desc = L["Select which action to take when you click with the right mouse button with Ctrl held down over a dashboard buff check"],
					order = 4,
					values = buttonoptions,
					get = function(info) return RaidBuffStatus.db.profile.ControlRightClick end,
					set = function(info, v)
						RaidBuffStatus.db.profile.ControlRightClick = v
					end,
				},
				shiftleftclick = {
					type = 'select',
					name = L["Shift-left click"],
					desc = L["Select which action to take when you click with the left mouse button with Shift held down over a dashboard buff check"],
					order = 5,
					values = buttonoptions,
					get = function(info) return RaidBuffStatus.db.profile.ShiftLeftClick end,
					set = function(info, v)
						RaidBuffStatus.db.profile.ShiftLeftClick = v
					end,
				},
				shiftrightclick = {
					type = 'select',
					name = L["Shift-right click"],
					desc = L["Select which action to take when you click with the right mouse button with Shift held down over a dashboard buff check"],
					order = 6,
					values = buttonoptions,
					get = function(info) return RaidBuffStatus.db.profile.ShiftRightClick end,
					set = function(info, v)
						RaidBuffStatus.db.profile.ShiftRightClick = v
					end,
				},
				altleftclick = {
					type = 'select',
					name = L["Alt-left click"],
					desc = L["Select which action to take when you click with the left mouse button with Alt held down over a dashboard buff check"],
					order = 7,
					values = buttonoptions,
					get = function(info) return RaidBuffStatus.db.profile.AltLeftClick end,
					set = function(info, v)
						RaidBuffStatus.db.profile.AltLeftClick = v
					end,
				},
				altrightclick = {
					type = 'select',
					name = L["Alt-right click"],
					desc = L["Select which action to take when you click with the right mouse button with Alt held down over a dashboard buff check"],
					order = 8,
					values = buttonoptions,
					get = function(info) return RaidBuffStatus.db.profile.AltRightClick end,
					set = function(info, v)
						RaidBuffStatus.db.profile.AltRightClick = v
					end,
				},
			},
		},
		tanklist = {
			type = 'group',
			name = L["Tank list"],
			desc = L["Options to do with configuring the tank list"],
			order = 9,
			args = {
				onlyusetanklist = {
					type = 'toggle',
					name = L["Only use tank list"],
					desc = L["Only use the tank list and ignore spec when there is a tank list for determining if someone is a tank or not"],
					get = function(info) return RaidBuffStatus.db.profile.onlyusetanklist end,
					set = function(info, v)
						RaidBuffStatus.db.profile.onlyusetanklist = v
					end,
				},
			},
		},
		tankwarnings = {
			type = 'group',
			name = L["Tank warnings"],
			desc = L["Tank warnings about taunts, failed taunts and mob stealing including accidental taunts from non-tanks"],
			order = 10,
			args = {
				tankwarn = {
					type = 'toggle',
					name = L["Tank warnings"],
					desc = L["Enable tank warnings including taunts, failed taunts and mob stealing"],
					get = function(info) return RaidBuffStatus.db.profile.tankwarn end,
					set = function(info, v)
						RaidBuffStatus.db.profile.tankwarn = v
					end,
					order = 1,
				},
				bossonly = {
					type = 'toggle',
					name = L["Bosses only"],
					desc = L["Enable tank warnings including taunts, failed taunts and mob stealing only on bosses"],
					get = function(info) return RaidBuffStatus.db.profile.bossonly end,
					set = function(info, v)
						RaidBuffStatus.db.profile.bossonly = v
					end,
					order = 2,
				},
				failimmune = {
					type = 'group',
					name = L["Your taunt immune-fails"],
					desc = L["Warns when your taunts fail due to the target being immune"],
					order = 3,
					args = {
						failselfimmune = {
							type = 'toggle',
							name = L["Warn to self"],
							desc = L["Warn to self when one of your taunts fails due to the target being immune"],
							get = function(info) return RaidBuffStatus.db.profile.failselfimmune end,
							set = function(info, v)
								RaidBuffStatus.db.profile.failselfimmune = v
							end,
							order = 1,
						},
						failsoundimmune = {
							type = 'toggle',
							name = L["Play a sound"],
							desc = L["Play a sound when one of your taunts fails due to the target being immune"],
							get = function(info) return RaidBuffStatus.db.profile.failsoundimmune end,
							set = function(info, v)
								RaidBuffStatus.db.profile.failsoundimmune = v
							end,
							order = 2,
						},
						failrwimmune = {
							type = 'toggle',
							name = L["Warn to raid warning"],
							desc = L["Warn using raid warning when one of your taunts fails due to the target being immune"],
							get = function(info) return RaidBuffStatus.db.profile.failrwimmune end,
							set = function(info, v)
								RaidBuffStatus.db.profile.failrwimmune = v
							end,
							order = 3,
						},
						failraidimmune = {
							type = 'toggle',
							name = L["Warn to raid chat"],
							desc = L["Warn to raid chat when one of your taunts fails due to the target being immune"],
							get = function(info) return RaidBuffStatus.db.profile.failraidimmune end,
							set = function(info, v)
								RaidBuffStatus.db.profile.failraidimmune = v
							end,
							order = 4,
						},
						failpartyimmune = {
							type = 'toggle',
							name = L["Warn to party"],
							desc = L["Warn to party when one of your taunts fails due to the target being immune"],
							get = function(info) return RaidBuffStatus.db.profile.failpartyimmune end,
							set = function(info, v)
								RaidBuffStatus.db.profile.failpartyimmune = v
							end,
							order = 5,
						},
						failtestimmune = {
							type = 'execute',
							name = L["Test"],
							desc = L["Test what the warning is like"],
							func = function(info, v)
								RaidBuffStatus:TauntSay(L["[IMMUNE] Danielbarron FAILED TO TAUNT his target (The Lich King) with Hand of Reckoning"], "failedtauntimmune")
							end,
							order = 6,
						},
					},
				},
				failresist = {
					type = 'group',
					name = L["Your taunt resist-fails"],
					desc = L["Warns when your taunts fail due to resist"],
					order = 4,
					args = {
						failselfresist = {
							type = 'toggle',
							name = L["Warn to self"],
							desc = L["Warn to self when one of your taunts fails due to resist"],
							get = function(info) return RaidBuffStatus.db.profile.failselfresist end,
							set = function(info, v)
								RaidBuffStatus.db.profile.failselfresist = v
							end,
							order = 1,
						},
						failsoundresist = {
							type = 'toggle',
							name = L["Play a sound"],
							desc = L["Play a sound when one of your taunts fails due to resist"],
							get = function(info) return RaidBuffStatus.db.profile.failsoundresist end,
							set = function(info, v)
								RaidBuffStatus.db.profile.failsoundresist = v
							end,
							order = 2,
						},
						failrwresist = {
							type = 'toggle',
							name = L["Warn to raid warning"],
							desc = L["Warn using raid warning when one of your taunts fails due to resist"],
							get = function(info) return RaidBuffStatus.db.profile.failrwresist end,
							set = function(info, v)
								RaidBuffStatus.db.profile.failrwresist = v
							end,
							order = 3,
						},
						failraidresist = {
							type = 'toggle',
							name = L["Warn to raid chat"],
							desc = L["Warn to raid chat when one of your taunts fails due to resist"],
							get = function(info) return RaidBuffStatus.db.profile.failraidresist end,
							set = function(info, v)
								RaidBuffStatus.db.profile.failraidresist = v
							end,
							order = 4,
						},
						failpartyresist = {
							type = 'toggle',
							name = L["Warn to party"],
							desc = L["Warn to party when one of your taunts fails due to resist"],
							get = function(info) return RaidBuffStatus.db.profile.failpartyresist end,
							set = function(info, v)
								RaidBuffStatus.db.profile.failpartyresist = v
							end,
							order = 5,
						},
						failtestresist = {
							type = 'execute',
							name = L["Test"],
							desc = L["Test what the warning is like"],
							func = function(info, v)
								RaidBuffStatus:TauntSay(L["[RESIST] Danielbarron FAILED TO TAUNT his target (The Lich King) with Hand of Reckoning"], "failedtauntresist")
							end,
							order = 6,
						},
					},
				},
				otherfail = {
					type = 'group',
					name = L["Other taunt fails"],
					desc = L["Warns when other people's taunts to your target fail"],
					order = 5,
					args = {
						otherfailself = {
							type = 'toggle',
							name = L["Warn to self"],
							desc = L["Warn to self when other people's taunts to your target fail"],
							get = function(info) return RaidBuffStatus.db.profile.otherfailself end,
							set = function(info, v)
								RaidBuffStatus.db.profile.otherfailself = v
							end,
							order = 1,
						},
						otherfailsound = {
							type = 'toggle',
							name = L["Play a sound"],
							desc = L["Play a sound when other people's taunts to your target fail"],
							get = function(info) return RaidBuffStatus.db.profile.otherfailsound end,
							set = function(info, v)
								RaidBuffStatus.db.profile.otherfailsound = v
							end,
							order = 2,
						},
						otherfailrw = {
							type = 'toggle',
							name = L["Warn to raid warning"],
							desc = L["Warn using raid warning when other people's taunts to your target fail"],
							get = function(info) return RaidBuffStatus.db.profile.otherfailrw end,
							set = function(info, v)
								RaidBuffStatus.db.profile.otherfailrw = v
							end,
							order = 3,
						},
						otherfailraid = {
							type = 'toggle',
							name = L["Warn to raid chat"],
							desc = L["Warn to raid chat when other people's taunts to your target fail"],
							get = function(info) return RaidBuffStatus.db.profile.otherfailraid end,
							set = function(info, v)
								RaidBuffStatus.db.profile.otherfailraid = v
							end,
							order = 4,
						},
						otherfailparty = {
							type = 'toggle',
							name = L["Warn to party"],
							desc = L["Warn to party when other people's taunts to your target fail"],
							get = function(info) return RaidBuffStatus.db.profile.otherfailparty end,
							set = function(info, v)
								RaidBuffStatus.db.profile.otherfailparty = v
							end,
							order = 5,
						},
						otherfailtest = {
							type = 'execute',
							name = L["Test"],
							desc = L["Test what the warning is like"],
							func = function(info, v)
								RaidBuffStatus:TauntSay(L["[RESIST] Darinia FAILED TO TAUNT my target (The Lich King) with Taunt"], "otherfail")
							end,
							order = 6,
						},
					},
				},
				taunt = {
					type = 'group',
					name = L["Taunts to my target"],
					desc = L["Warnings when someone else taunts your target"],
					order = 6,
					args = {
						tauntself = {
							type = 'toggle',
							name = L["Warn to self"],
							desc = L["Warn to self when someone else taunts your target"],
							get = function(info) return RaidBuffStatus.db.profile.tauntself end,
							set = function(info, v)
								RaidBuffStatus.db.profile.tauntself = v
							end,
							order = 1,
						},
						tauntsound = {
							type = 'toggle',
							name = L["Play a sound"],
							desc = L["Play a sound when someone else taunts your target"],
							get = function(info) return RaidBuffStatus.db.profile.tauntsound end,
							set = function(info, v)
								RaidBuffStatus.db.profile.tauntsound = v
							end,
							order = 2,
						},
						tauntrw = {
							type = 'toggle',
							name = L["Warn to raid warning"],
							desc = L["Warn using raid warning when someone else taunts your target"],
							get = function(info) return RaidBuffStatus.db.profile.tauntrw end,
							set = function(info, v)
								RaidBuffStatus.db.profile.tauntrw = v
							end,
							order = 3,
						},
						tauntraid = {
							type = 'toggle',
							name = L["Warn to raid chat"],
							desc = L["Warn to raid chat when someone else taunts your target"],
							get = function(info) return RaidBuffStatus.db.profile.tauntraid end,
							set = function(info, v)
								RaidBuffStatus.db.profile.tauntraid = v
							end,
							order = 4,
						},
						tauntparty = {
							type = 'toggle',
							name = L["Warn to party"],
							desc = L["Warn to party when someone else taunts your target"],
							get = function(info) return RaidBuffStatus.db.profile.tauntparty end,
							set = function(info, v)
								RaidBuffStatus.db.profile.tauntparty = v
							end,
							order = 5,
						},
						taunttest = {
							type = 'execute',
							name = L["Test"],
							desc = L["Test what the warning is like"],
							func = function(info, v)
								RaidBuffStatus:TauntSay(L["Darinia taunted my target (The Lich King) with Taunt"], "taunt")
							end,
							order = 6,
						},
					},
				},
				ninja = {
					type = 'group',
					name = L["Ninja taunts"],
					desc = L["Warns when someone else taunts your target which is targeting you"],
					order = 7,
					args = {
						ninjaself = {
							type = 'toggle',
							name = L["Warn to self"],
							desc = L["Warn to self when someone else taunts your target which is targeting you"],
							get = function(info) return RaidBuffStatus.db.profile.ninjaself end,
							set = function(info, v)
								RaidBuffStatus.db.profile.ninjaself = v
							end,
							order = 1,
						},
						ninjasound = {
							type = 'toggle',
							name = L["Play a sound"],
							desc = L["Play a sound when someone else taunts your target which is targeting you"],
							get = function(info) return RaidBuffStatus.db.profile.ninjasound end,
							set = function(info, v)
								RaidBuffStatus.db.profile.ninjasound = v
							end,
							order = 2,
						},
						ninjarw = {
							type = 'toggle',
							name = L["Warn to raid warning"],
							desc = L["Warn using raid warning when someone else taunts your target which is targeting you"],
							get = function(info) return RaidBuffStatus.db.profile.ninjarw end,
							set = function(info, v)
								RaidBuffStatus.db.profile.ninjarw = v
							end,
							order = 3,
						},
						ninjaraid = {
							type = 'toggle',
							name = L["Warn to raid chat"],
							desc = L["Warn to raid chat when someone else taunts your target which is targeting you"],
							get = function(info) return RaidBuffStatus.db.profile.ninjaraid end,
							set = function(info, v)
								RaidBuffStatus.db.profile.ninjaraid = v
							end,
							order = 4,
						},
						ninjaparty = {
							type = 'toggle',
							name = L["Warn to party"],
							desc = L["Warn to party when someone else taunts your target which is targeting you"],
							get = function(info) return RaidBuffStatus.db.profile.ninjaparty end,
							set = function(info, v)
								RaidBuffStatus.db.profile.ninjaparty = v
							end,
							order = 5,
						},
						ninjatest = {
							type = 'execute',
							name = L["Test"],
							desc = L["Test what the warning is like"],
							func = function(info, v)
								RaidBuffStatus:TauntSay(L["Darinia ninjaed my target (The Lich King) with Taunt"], "ninjataunt")
							end,
							order = 6,
						},
					},
				},
				tauntme = {
					type = 'group',
					name = L["Taunts to my mobs"],
					desc = L["Warnings when someone else targets a mob and taunts that mob which is targeting you"],
					order = 8,
					args = {
						tauntmeself = {
							type = 'toggle',
							name = L["Warn to self"],
							desc = L["Warn to self when someone else targets a mob and taunts that mob which is targeting you"],
							get = function(info) return RaidBuffStatus.db.profile.tauntmeself end,
							set = function(info, v)
								RaidBuffStatus.db.profile.tauntmeself = v
							end,
							order = 1,
						},
						tauntmesound = {
							type = 'toggle',
							name = L["Play a sound"],
							desc = L["Play a sound when someone else targets a mob and taunts that mob which is targeting you"],
							get = function(info) return RaidBuffStatus.db.profile.tauntmesound end,
							set = function(info, v)
								RaidBuffStatus.db.profile.tauntmesound = v
							end,
							order = 2,
						},
						tauntmerw = {
							type = 'toggle',
							name = L["Warn to raid warning"],
							desc = L["Warn using raid warning when someone else targets a mob and taunts that mob which is targeting you"],
							get = function(info) return RaidBuffStatus.db.profile.tauntmerw end,
							set = function(info, v)
								RaidBuffStatus.db.profile.tauntmerw = v
							end,
							order = 3,
						},
						tauntmeraid = {
							type = 'toggle',
							name = L["Warn to raid chat"],
							desc = L["Warn to raid chat when someone else targets a mob and taunts that mob which is targeting you"],
							get = function(info) return RaidBuffStatus.db.profile.tauntmeraid end,
							set = function(info, v)
								RaidBuffStatus.db.profile.tauntmeraid = v
							end,
							order = 4,
						},
						tauntmeparty = {
							type = 'toggle',
							name = L["Warn to party"],
							desc = L["Warn to party when someone else targets a mob and taunts that mob which is targeting you"],
							get = function(info) return RaidBuffStatus.db.profile.tauntmeparty end,
							set = function(info, v)
								RaidBuffStatus.db.profile.tauntmeparty = v
							end,
							order = 5,
						},
						tauntmetest = {
							type = 'execute',
							name = L["Test"],
							desc = L["Test what the warning is like"],
							func = function(info, v)
								RaidBuffStatus:TauntSay(L["Darinia taunted my mob (The Lich King) with Taunt"], "tauntme")
							end,
							order = 6,
						},
					},
				},

				nontanktaunts = {
					type = 'group',
					name = L["Non-tank taunts my target"],
					desc = L["Warnings when someone else taunts your target who is not a tank"],
					order = 8,
					args = {
						nontanktauntself = {
							type = 'toggle',
							name = L["Warn to self"],
							desc = L["Warn to self when someone else who is not a tank taunts your target"],
							get = function(info) return RaidBuffStatus.db.profile.nontanktauntself end,
							set = function(info, v)
								RaidBuffStatus.db.profile.nontanktauntself = v
							end,
							order = 1,
						},
						nontanktauntsound = {
							type = 'toggle',
							name = L["Play a sound"],
							desc = L["Play a sound when someone else who is not a tank taunts your target"],
							get = function(info) return RaidBuffStatus.db.profile.nontanktauntsound end,
							set = function(info, v)
								RaidBuffStatus.db.profile.nontanktauntsound = v
							end,
							order = 2,
						},
						nontanktauntrw = {
							type = 'toggle',
							name = L["Warn to raid warning"],
							desc = L["Warn using raid warning when someone else who is not a tank taunts your target"],
							get = function(info) return RaidBuffStatus.db.profile.nontanktauntrw end,
							set = function(info, v)
								RaidBuffStatus.db.profile.nontanktauntrw = v
							end,
							order = 3,
						},
						nontanktauntraid = {
							type = 'toggle',
							name = L["Warn to raid chat"],
							desc = L["Warn to raid chat when someone else who is not a tank taunts your target"],
							get = function(info) return RaidBuffStatus.db.profile.nontanktauntraid end,
							set = function(info, v)
								RaidBuffStatus.db.profile.nontanktauntraid = v
							end,
							order = 4,
						},
						nontanktauntparty = {
							type = 'toggle',
							name = L["Warn to party"],
							desc = L["Warn to party when someone else who is not a tank taunts your target"],
							get = function(info) return RaidBuffStatus.db.profile.nontanktauntparty end,
							set = function(info, v)
								RaidBuffStatus.db.profile.nontanktauntparty = v
							end,
							order = 5,
						},
						taunttest = {
							type = 'execute',
							name = L["Test"],
							desc = L["Test what the warning is like"],
							func = function(info, v)
								RaidBuffStatus:TauntSay(L["NON-TANK Tanagra taunted my target (The Lich King) with Growl"], "nontanktaunt")
							end,
							order = 6,
						},
					},
				},
			},
		},
		ccbreakwarnings = {
			type = 'group',
			name = L["CC-break warnings"],
			desc = L["Warnings when Crowd Control is broken by tanks and non-tanks"],
			order = 11,
			args = {
				ccwarn = {
					type = 'toggle',
					name = L["CC-break warnings"],
					desc = L["Enable warnings when Crowd Control is broken by tanks and non-tanks"],
					get = function(info) return RaidBuffStatus.db.profile.ccwarn end,
					set = function(info, v)
						RaidBuffStatus.db.profile.ccwarn = v
					end,
					order = 1,
				},
				cconlyme = {
					type = 'toggle',
					name = L["Only me"],
					desc = L["Only show when you and only you break Crowd Control so you can say 'Now I don't believe you wanted to do that did you, ehee?'"],
					get = function(info) return RaidBuffStatus.db.profile.cconlyme end,
					set = function(info, v)
						RaidBuffStatus.db.profile.cconlyme = v
					end,
					order = 2,
				},
				ccwarntank = {
					type = 'group',
					name = L["Tank breaks CC"],
					desc = L["Warns when a tank breaks Crowd Control"],
					order = 3,
					args = {
						ccwarntankself = {
							type = 'toggle',
							name = L["Warn to self"],
							desc = L["Warn to self when a tank breaks Crowd Control"],
							get = function(info) return RaidBuffStatus.db.profile.ccwarntankself end,
							set = function(info, v)
								RaidBuffStatus.db.profile.ccwarntankself = v
							end,
							order = 1,
						},
						ccwarntanksound = {
							type = 'toggle',
							name = L["Play a sound"],
							desc = L["Play a sound when a tank breaks Crowd Control"],
							get = function(info) return RaidBuffStatus.db.profile.ccwarntanksound end,
							set = function(info, v)
								RaidBuffStatus.db.profile.ccwarntanksound = v
							end,
							order = 2,
						},
						ccwarntankrw = {
							type = 'toggle',
							name = L["Warn to raid warning"],
							desc = L["Warn using raid warning when a tank breaks Crowd Control"],
							get = function(info) return RaidBuffStatus.db.profile.ccwarntankrw end,
							set = function(info, v)
								RaidBuffStatus.db.profile.ccwarntankrw = v
							end,
							order = 3,
						},
						ccwarntankraid = {
							type = 'toggle',
							name = L["Warn to raid chat"],
							desc = L["Warn to raid chat when a tank breaks Crowd Control"],
							get = function(info) return RaidBuffStatus.db.profile.ccwarntankraid end,
							set = function(info, v)
								RaidBuffStatus.db.profile.ccwarntankraid = v
							end,
							order = 4,
						},
						ccwarntankparty = {
							type = 'toggle',
							name = L["Warn to party"],
							desc = L["Warn to party when a tank breaks Crowd Control"],
							get = function(info) return RaidBuffStatus.db.profile.ccwarntankparty end,
							set = function(info, v)
								RaidBuffStatus.db.profile.ccwarntankparty = v
							end,
							order = 5,
						},
						ccwarntanktest = {
							type = 'execute',
							name = L["Test"],
							desc = L["Test what the warning is like"],
							func = function(info, v)
								RaidBuffStatus:CCBreakSay(L["Danielbarron broke Sheep on The Lich King with Hand of Reckoning"], "ccwarntank")
							end,
							order = 6,
						},
					},
				},
				ccwarnnontank = {
					type = 'group',
					name = L["Non-tank breaks CC"],
					desc = L["Warns when a non-tank breaks Crowd Control"],
					order = 3,
					args = {
						ccwarnnontankself = {
							type = 'toggle',
							name = L["Warn to self"],
							desc = L["Warn to self when a non-tank breaks Crowd Control"],
							get = function(info) return RaidBuffStatus.db.profile.ccwarnnontankself end,
							set = function(info, v)
								RaidBuffStatus.db.profile.ccwarnnontankself = v
							end,
							order = 1,
						},
						ccwarnnontanksound = {
							type = 'toggle',
							name = L["Play a sound"],
							desc = L["Play a sound when a non-tank breaks Crowd Control"],
							get = function(info) return RaidBuffStatus.db.profile.ccwarnnontanksound end,
							set = function(info, v)
								RaidBuffStatus.db.profile.ccwarnnontanksound = v
							end,
							order = 2,
						},
						ccwarnnontankrw = {
							type = 'toggle',
							name = L["Warn to raid warning"],
							desc = L["Warn using raid warning when a non-tank breaks Crowd Control"],
							get = function(info) return RaidBuffStatus.db.profile.ccwarnnontankrw end,
							set = function(info, v)
								RaidBuffStatus.db.profile.ccwarnnontankrw = v
							end,
							order = 3,
						},
						ccwarnnontankraid = {
							type = 'toggle',
							name = L["Warn to raid chat"],
							desc = L["Warn to raid chat when a non-tank breaks Crowd Control"],
							get = function(info) return RaidBuffStatus.db.profile.ccwarnnontankraid end,
							set = function(info, v)
								RaidBuffStatus.db.profile.ccwarnnontankraid = v
							end,
							order = 4,
						},
						ccwarnnontankparty = {
							type = 'toggle',
							name = L["Warn to party"],
							desc = L["Warn to party when a non-tank breaks Crowd Control"],
							get = function(info) return RaidBuffStatus.db.profile.ccwarnnontankparty end,
							set = function(info, v)
								RaidBuffStatus.db.profile.ccwarnnontankparty = v
							end,
							order = 5,
						},
						ccwarnnontanktest = {
							type = 'execute',
							name = L["Test"],
							desc = L["Test what the warning is like"],
							func = function(info, v)
								RaidBuffStatus:CCBreakSay(L["Non-tank Glamor broke Hex on The Lich King with Moonfire"], "ccwarnnontank")
							end,
							order = 6,
						},
					},
				},
			},
		},
		misdirectionwarnings = {
			type = 'group',
			name = L["Misdirection warnings"],
			desc = L["Warnings when Misdirection or Tricks of the Trade is cast"],
			order = 12,
			args = {
				misdirection = {
					type = 'toggle',
					name = L["Misdirection warnings"],
					desc = L["Enable warnings when Misdirection or Tricks of the Trade is cast"],
					get = function(info) return RaidBuffStatus.db.profile.misdirectionwarn end,
					set = function(info, v)
						RaidBuffStatus.db.profile.misdirectionwarn = v
					end,
					order = 1,
				},
				misdirections = {
					type = 'group',
					name = L["Misdirection warnings"],
					desc = L["Warnings when Misdirection or Tricks of the Trade is cast"],
					order = 2,
					args = {
						misdirectionself = {
							type = 'toggle',
							name = L["Warn to self"],
								desc = L["Warn to self when Misdirection or Tricks of the Trade is cast"],
								get = function(info) return RaidBuffStatus.db.profile.misdirectionself end,
								set = function(info, v)
									RaidBuffStatus.db.profile.misdirectionself = v
								end,
								order = 1,
						},
						misdirectionsound = {
							type = 'toggle',
							name = L["Play a sound"],
							desc = L["Play a sound when Misdirection or Tricks of the Trade is cast"],
							get = function(info) return RaidBuffStatus.db.profile.misdirectionsound end,
							set = function(info, v)
								RaidBuffStatus.db.profile.misdirectionsound = v
							end,
							order = 2,
						},
						misdirectiontest = {
							type = 'execute',
							name = L["Test"],
							desc = L["Test what the warning is like"],
							func = function(info, v)
								RaidBuffStatus:MisdirectionEventLog("Garmann", GetSpellInfo(34477), "Darinia") -- Misdirection
							end,
							order = 3,
						},
					},
				},
			},
		},
		deathwarnings = {
			type = 'group',
			name = L["Death warnings"],
			desc = L["Warning messages when players die"],
			order = 13,
			args = {
				deathwarn = {
					type = 'toggle',
					name = L["Death warnings"],
					desc = L["Enable warning messages when players die"],
					get = function(info) return RaidBuffStatus.db.profile.deathwarn end,
					set = function(info, v)
						RaidBuffStatus.db.profile.deathwarn = v
					end,
					order = 1,
				},
				tankdeath = {
					type = 'group',
					name = L["Tank death"],
					desc = L["Warn when a tank dies"],
					order = 1,
					args = {
						tankdeathself = {
							type = 'toggle',
							name = L["Warn to self"],
							desc = L["Warn to self when a tank dies"],
							get = function(info) return RaidBuffStatus.db.profile.tankdeathself end,
							set = function(info, v)
								RaidBuffStatus.db.profile.tankdeathself = v
							end,
							order = 1,
						},
						tankdeathsound = {
							type = 'toggle',
							name = L["Play a sound"],
							desc = L["Play a sound when a tank dies"],
							get = function(info) return RaidBuffStatus.db.profile.tankdeathsound end,
							set = function(info, v)
								RaidBuffStatus.db.profile.tankdeathsound = v
							end,
							order = 2,
						},
						tankdeathrw = {
							type = 'toggle',
							name = L["Warn to raid warning"],
							desc = L["Warn using raid warning when a tank dies"],
							get = function(info) return RaidBuffStatus.db.profile.tankdeathrw end,
							set = function(info, v)
								RaidBuffStatus.db.profile.tankdeathrw = v
							end,
							order = 3,
						},
						tankdeathraid = {
							type = 'toggle',
							name = L["Warn to raid chat"],
							desc = L["Warn to raid chat when a tank dies"],
							get = function(info) return RaidBuffStatus.db.profile.tankdeathraid end,
							set = function(info, v)
								RaidBuffStatus.db.profile.tankdeathraid = v
							end,
							order = 4,
						},
						tankdeathparty = {
							type = 'toggle',
							name = L["Warn to party"],
							desc = L["Warn to party when a tank dies"],
							get = function(info) return RaidBuffStatus.db.profile.tankdeathparty end,
							set = function(info, v)
								RaidBuffStatus.db.profile.tankdeathparty = v
							end,
							order = 5,
						},
						tankdeathtest = {
							type = 'execute',
							name = L["Test"],
							desc = L["Test what the warning is like"],
							func = function(info, v)
								RaidBuffStatus:DeathSay(L["Tank Danielbarron has died!"], "tank")
							end,
							order = 6,
						},
					},
				},
				meleedpsdeath = {
					type = 'group',
					name = L["Melee DPS death"],
					desc = L["Warn when a melee DPS dies"],
					order = 2,
					args = {
						meleedpsdeathself = {
							type = 'toggle',
							name = L["Warn to self"],
							desc = L["Warn to self when a melee DPS dies"],
							get = function(info) return RaidBuffStatus.db.profile.meleedpsdeathself end,
							set = function(info, v)
								RaidBuffStatus.db.profile.meleedpsdeathself = v
							end,
							order = 1,
						},
						meleedpsdeathsound = {
							type = 'toggle',
							name = L["Play a sound"],
							desc = L["Play a sound when a melee DPS dies"],
							get = function(info) return RaidBuffStatus.db.profile.meleedpsdeathsound end,
							set = function(info, v)
								RaidBuffStatus.db.profile.meleedpsdeathsound = v
							end,
							order = 2,
						},
						meleedpsdeathrw = {
							type = 'toggle',
							name = L["Warn to raid warning"],
							desc = L["Warn using raid warning when a melee DPS dies"],
							get = function(info) return RaidBuffStatus.db.profile.meleedpsdeathrw end,
							set = function(info, v)
								RaidBuffStatus.db.profile.meleedpsdeathrw = v
							end,
							order = 3,
						},
						meleedpsdeathraid = {
							type = 'toggle',
							name = L["Warn to raid chat"],
							desc = L["Warn to raid chat when a melee DPS dies"],
							get = function(info) return RaidBuffStatus.db.profile.meleedpsdeathraid end,
							set = function(info, v)
								RaidBuffStatus.db.profile.meleedpsdeathraid = v
							end,
							order = 4,
						},
						meleedpsdeathparty = {
							type = 'toggle',
							name = L["Warn to party"],
							desc = L["Warn to party when a melee DPS dies"],
							get = function(info) return RaidBuffStatus.db.profile.meleedpsdeathparty end,
							set = function(info, v)
								RaidBuffStatus.db.profile.meleedpsdeathparty = v
							end,
							order = 5,
						},
						meleedpsdeathtest = {
							type = 'execute',
							name = L["Test"],
							desc = L["Test what the warning is like"],
							func = function(info, v)
								RaidBuffStatus:DeathSay(L["Melee DPS Danielbarron has died!"], "meleedps")
							end,
							order = 6,
						},
					},
				},
				rangeddpsdeath = {
					type = 'group',
					name = L["Ranged DPS death"],
					desc = L["Warn when a ranged DPS dies"],
					order = 3,
					args = {
						rangeddpsdeathself = {
							type = 'toggle',
							name = L["Warn to self"],
							desc = L["Warn to self when a ranged DPS dies"],
							get = function(info) return RaidBuffStatus.db.profile.rangeddpsdeathself end,
							set = function(info, v)
								RaidBuffStatus.db.profile.rangeddpsdeathself = v
							end,
							order = 1,
						},
						rangeddpsdeathsound = {
							type = 'toggle',
							name = L["Play a sound"],
							desc = L["Play a sound when a ranged DPS dies"],
							get = function(info) return RaidBuffStatus.db.profile.rangeddpsdeathsound end,
							set = function(info, v)
								RaidBuffStatus.db.profile.rangeddpsdeathsound = v
							end,
							order = 2,
						},
						rangeddpsdeathrw = {
							type = 'toggle',
							name = L["Warn to raid warning"],
							desc = L["Warn using raid warning when a ranged DPS dies"],
							get = function(info) return RaidBuffStatus.db.profile.rangeddpsdeathrw end,
							set = function(info, v)
								RaidBuffStatus.db.profile.rangeddpsdeathrw = v
							end,
							order = 3,
						},
						rangeddpsdeathraid = {
							type = 'toggle',
							name = L["Warn to raid chat"],
							desc = L["Warn to raid chat when a ranged DPS dies"],
							get = function(info) return RaidBuffStatus.db.profile.rangeddpsdeathraid end,
							set = function(info, v)
								RaidBuffStatus.db.profile.rangeddpsdeathraid = v
							end,
							order = 4,
						},
						rangeddpsdeathparty = {
							type = 'toggle',
							name = L["Warn to party"],
							desc = L["Warn to party when a ranged DPS dies"],
							get = function(info) return RaidBuffStatus.db.profile.rangeddpsdeathparty end,
							set = function(info, v)
								RaidBuffStatus.db.profile.rangeddpsdeathparty = v
							end,
							order = 5,
						},
						rangeddpsdeathtest = {
							type = 'execute',
							name = L["Test"],
							desc = L["Test what the warning is like"],
							func = function(info, v)
								RaidBuffStatus:DeathSay(L["Ranged DPS Garmann has died!"], "rangeddps")
							end,
							order = 6,
						},
					},
				},
				healerdeath = {
					type = 'group',
					name = L["Healer death"],
					desc = L["Warn when a healer dies"],
					order = 3,
					args = {
						healerdeathself = {
							type = 'toggle',
							name = L["Warn to self"],
							desc = L["Warn to self when a healer dies"],
							get = function(info) return RaidBuffStatus.db.profile.healerdeathself end,
							set = function(info, v)
								RaidBuffStatus.db.profile.healerdeathself = v
							end,
							order = 1,
						},
						healerdeathsound = {
							type = 'toggle',
							name = L["Play a sound"],
							desc = L["Play a sound when a healer dies"],
							get = function(info) return RaidBuffStatus.db.profile.healerdeathsound end,
							set = function(info, v)
								RaidBuffStatus.db.profile.healerdeathsound = v
							end,
							order = 2,
						},
						healerdeathrw = {
							type = 'toggle',
							name = L["Warn to raid warning"],
							desc = L["Warn using raid warning when a healer dies"],
							get = function(info) return RaidBuffStatus.db.profile.healerdeathrw end,
							set = function(info, v)
								RaidBuffStatus.db.profile.healerdeathrw = v
							end,
							order = 3,
						},
						healerdeathraid = {
							type = 'toggle',
							name = L["Warn to raid chat"],
							desc = L["Warn to raid chat when a healer dies"],
							get = function(info) return RaidBuffStatus.db.profile.healerdeathraid end,
							set = function(info, v)
								RaidBuffStatus.db.profile.healerdeathraid = v
							end,
							order = 4,
						},
						healerdeathparty = {
							type = 'toggle',
							name = L["Warn to party"],
							desc = L["Warn to party when a healer dies"],
							get = function(info) return RaidBuffStatus.db.profile.healerdeathparty end,
							set = function(info, v)
								RaidBuffStatus.db.profile.healerdeathparty = v
							end,
							order = 5,
						},
						healerdeathtest = {
							type = 'execute',
							name = L["Test"],
							desc = L["Test what the warning is like"],
							func = function(info, v)
								RaidBuffStatus:DeathSay(L["Healer Stormsnow has died!"], "healer")
							end,
							order = 6,
						},
					},
				},
			},
		},
		foodannounce = {
			type = 'group',
			name = L["Food announce"],
			desc = L["Food raid warning announcement options for things like Fish Feasts"],
			order = 14,
			args = {
				fishfeast = {
					type = 'toggle',
					name = L["Fish Feast"],
					desc = L["Announce to raid warning when a Fish Feast is prepared"],
					order = 1,
					get = function(info) return RaidBuffStatus.db.profile.fishfeast end,
					set = function(info, v)
						RaidBuffStatus.db.profile.fishfeast = v
					end,
				},
				feastautowhisper = {
					type = 'toggle',
					name = L["Feast auto whisper"],
					desc = L["Automatically whisper anyone missing Well Fed when your Fish Feast expire warnings appear"],
					order = 2,
					get = function(info) return RaidBuffStatus.db.profile.feastautowhisper end,
					set = function(info, v)
						RaidBuffStatus.db.profile.feastautowhisper = v
					end,
				},
				refreshmenttable = {
					type = 'toggle',
					name = L["Refreshment Table"],
					desc = L["Announce to raid warning when a Refreshment Table is prepared"],
					order = 3,
					get = function(info) return RaidBuffStatus.db.profile.refreshmenttable end,
					set = function(info, v)
						RaidBuffStatus.db.profile.refreshmenttable = v
					end,
				},
				soulwell = {
					type = 'toggle',
					name = L["Soul Well"],
					desc = L["Announce to raid warning when a Soul Well is prepared"],
					order = 4,
					get = function(info) return RaidBuffStatus.db.profile.soulwell end,
					set = function(info, v)
						RaidBuffStatus.db.profile.soulwell = v
					end,
				},
				repair = {
					type = 'toggle',
					name = L["Repair Bot"],
					desc = L["Announce to raid warning when a Repair Bot is prepared"],
					order = 5,
					get = function(info) return RaidBuffStatus.db.profile.repair end,
					set = function(info, v)
						RaidBuffStatus.db.profile.repair = v
					end,
				},
				wellautowhisper = {
					type = 'toggle',
					name = L["Well auto whisper"],
					desc = L["Automatically whisper anyone missing a Healthstone when your Soul Well expire warnings appear"],
					order = 6,
					get = function(info) return RaidBuffStatus.db.profile.wellautowhisper end,
					set = function(info, v)
						RaidBuffStatus.db.profile.wellautowhisper = v
					end,
				},
				antispam = {
					type = 'toggle',
					name = L["Anti spam"],
					desc = L["Wait before announcing to see if others have announced first in order to reduce spam"],
					order = 7,
					get = function(info) return RaidBuffStatus.db.profile.antispam end,
					set = function(info, v)
						RaidBuffStatus.db.profile.antispam = v
					end,
				},
			},
		},
		versionannounce = {
			type = 'group',
			name = L["Version announce"],
			desc = L["Tells you when someone in your party, raid or guild has a newer version of RBS installed"],
			order = 15,
			args = {
				versionannounce = {
					type = 'toggle',
					name = L["Version announce"],
					desc = L["Tells you when someone in your party, raid or guild has a newer version of RBS installed"],
					order = 1,
					get = function(info) return RaidBuffStatus.db.profile.versionannounce end,
					set = function(info, v)
						RaidBuffStatus.db.profile.versionannounce = v
					end,
				},
			},
		},
	},
}

RaidBuffStatus.configOptions = options
LibStub("AceConfig-3.0"):RegisterOptionsTable("RaidBuffStatus", options, {'rbs', 'raidbuffstatus'})
