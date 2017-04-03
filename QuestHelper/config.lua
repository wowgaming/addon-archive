QuestHelper_File["config.lua"] = "1.4.1"
QuestHelper_Loadtime["config.lua"] = GetTime()

-- This is pretty much ganked wholesale from lightsfuryuther's QuestHelperConfig UI mod, then tweaked heavily because I'm kind of an obsessive asshole when it comes to make things work.
-- It's provided under a somewhat mangled version of the MIT license, which I will reproduce verbatim:

--[[
The MIT License

Copyright (c) <year> <copyright holders>

Permission is hereby granted, free of charge, to any person obtaining a
copy
of this software and associated documentation files (the "Software"), to
deal
in the Software without restriction, including without limitation the
rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or
sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
IN
THE SOFTWARE.
]]

local addonTable = {} -- we are not doing a common table we're just jamming shit in here basically




local QH = QuestHelper;
QH.have_custom_config = true; -- enable a custom config page
local QHConfig = {}; -- create "global" addon table

local addon = QHConfig;
local ldb = LibStub("LibDataBroker-1.1");

QH_Event("ADDON_LOADED", function (addonid)
	if addonid ~= "QuestHelper" then
		return;
	end
	addon:OnInit(); -- initialize the config window and LDB entry
end);

function addon:OnInit()
	addonTable.Profile_OnInit_Start = GetTime();
	self:GenerateQHLocales();
	self.Locale:SetCurrentLocale(GetLocale());
	self.Version = GetAddOnMetadata("QuestHelper", "Version");
	self:GenerateOptions();
	self:SetupLDB();
	self:SetupGUI();
	addonTable.Profile_OnInit_Stop = GetTime();
end

function addon:SetupGUI()
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("QuestHelper", addon.Options);
	local lib = LibStub("AceConfigDialog-3.0");
	addon.OptionsFrames = {};
	if addon.Options.args.Error then -- version < targetVersion
		addon.OptionsFrames.Global = lib:AddToBlizOptions("QuestHelper", "QuestHelper", nil, "Error");
		return;
	end
	addon.OptionsFrames.Global = lib:AddToBlizOptions("QuestHelper", "QuestHelper", nil, "Global");
	addon.OptionsFrames.Route = lib:AddToBlizOptions("QuestHelper", "Route", "QuestHelper", "RouteOptions");
	addon.OptionsFrames.Interface = lib:AddToBlizOptions("QuestHelper", "Interface", "QuestHelper", "InterfaceOptions");
	addon.OptionsFrames.Plugins = lib:AddToBlizOptions("QuestHelper", "Plugins", "QuestHelper", "Plugins");
end

function addon:SetupLDB()
	self.dataObject = {
		type = "launcher",
		icon = "Interface\\QuestFrame\\UI-QuestLog-BookIcon",
		label = "QuestHelper",
		tocname = "QuestHelper",
		OnClick = function(self, button)
			if QuestHelper_Pref['hide'] then
				QuestHelper:ToggleHide();
				return
			end
			if button == "LeftButton" then
				if IsShiftKeyDown() then
					QH_Incomplete();
				else
					QuestHelper:ToggleHide();
				end
			else
				addon:ShowGUI();
			end
		end,
		OnTooltipShow = function(tooltip)
			local theme = QuestHelper:GetColourTheme();
			local L = addon.Locale
			tooltip:AddLine("QuestHelper v" .. (GetAddOnMetadata("QuestHelper", "Version")) .. ", Config v" .. addon.Version, unpack(theme.tooltip));
			tooltip:AddLine(QHFormat("QH_BUTTON_TOOLTIP1", QHText(QuestHelper_Pref.hide and "QH_BUTTON_SHOW" or "QH_BUTTON_HIDE")), unpack(theme.tooltip));
			if not QuestHelper_Pref.hide then
				tooltip:AddLine(L["TooltipOpenConfig"], unpack(theme.tooltip));
				tooltip:AddLine(L["IncompleteToggleTooltip"], unpack(theme.tooltip));
			end
		end,
	};
	ldb:NewDataObject("QuestHelper", self.dataObject);
end

function addon:ShowGUI()
	InterfaceOptionsFrame_OpenToCategory(self.OptionsFrames.Plugins);
	InterfaceOptionsFrame_OpenToCategory(self.OptionsFrames.Global);
end

function addon:GenerateOptions()
	local L = addon.Locale;
  
	addon.Options = {
		type = "group",
		name = "QuestHelper",
		get = function(i)
			return QuestHelper_Pref[i[#i]];
		end,
		set = function(i, v)
			QuestHelper_Pref[i[#i]] = v;
		end,
		args = {
			Global = {
				order = 1,
				type = "group",
				name = L["GlobalOptionsName"],
				desc = L["GlobalOptionsDesc"],
				disabled = function()
					return QuestHelper_Pref['hide'];
				end,
				args = {
					Enable = {
						order = 1,
						type = "toggle",
						name = L["GlobalEnableName"],
						desc = L["GlobalEnableDesc"],
						disabled = false,
						get = function(i)
							return not QuestHelper_Pref['hide'];
						end,
						set = function(i, v)
							QuestHelper_Pref['hide'] = not v;
							
							if QuestHelper.MapButton then
								QuestHelper.MapButton:GetNormalTexture():SetDesaturated(QuestHelper_Pref['hide']);
							end
							if QuestHelper_Pref['hide'] then
								if QuestHelper_Pref['track'] then
									QusetHelper:HideTracker();
								end
								QuestHelper.map_overlay:Hide();
							else
								if QuestHelper_Pref['track'] then
									QuestHelper:ShowTracker();
								end
								QuestHelper.map_overlay:Show();
								QuestHelper.minimap_marker:Show();
							end
						end,
					},
					Performance = {
						type = "group",
						order = 2,
						name = L["PerfName"],
						desc = L["PerfDesc"],
						guiInline = true,
						args = {
							Route = {
								type = "range",
								order = 1,
								name = L["PerfRouteName"],
								desc = L["PerfRouteDesc"],
								min = 0.1,
								max = 5,
								step = .05,
								isPercent = true,
								disabled = function()
									return QuestHelper_Pref['hide'];
								end,
								get = function(i)
									return QuestHelper_Pref['perf_scale_2'];
								end,
								set = function(i, v)
									QuestHelper_Pref['perf_scale_2'] = v;
								end,
							},
							Load = {
								type = "range",
								order = 2,
								name = L["PerfLoadName"],
								desc = L["PerfLoadDesc"],
								min = 0.1,
								max = 5,
								step = .05,
								isPercent = true,
								get = function(i)
									return QuestHelper_Pref['perfload_scale'];
								end,
								set = function(i, v)
									QuestHelper_Pref['perfload_scale'] = v;
								end,
							},
						},
					},
					Actions = {
						type = "group",
						order = 3,
						guiInline = true,
						name = L["ActionsName"],
						desc = L["ActionsDesc"],
						args = {
							Hidden = {
								type = "execute",
								order = 1,
								name = L["ActionsHiddenName"],
								desc = L["ActionsHiddenDesc"],
								func = function()
									QH_Hidden_Menu();
								end,
							},
							Incomplete = {
								type = "execute",
								order = 2,
								name = L["ActionsIncompName"],
								desc = L["ActionsIncompDesc"],
								func = function()
									QH_Incomplete();
								end,
							},
							Purge = {
								type = "execute",
								order = 3,
								name = L["ActionsPurgeName"],
								desc = L["ActionsPurgeDesc"],
								func = function()
									if not StaticPopupDialogs["QHC_Purge_Dialog"] then
										StaticPopupDialogs["QHC_Purge_Dialog"] = {
											text = L["ActionsPurgeDialogText"],
											button1 = L["ActionsDialogPurge"],
											button2 = L["ActionsDialogCancel"],
											OnAccept = function()
												QuestHelper:Purge(nil, true); -- force a purge
											end,
											hideOnEscape = 1,
											timeout = -1,
										};
									end
									StaticPopup_Show("QHC_Purge_Dialog");
								end,
							},
							HardReset = {
								type = "execute",
								order = 4,
								name = L["ActionsResetName"],
								desc = L["ActionsResetDesc"],
								func = function()
									if not StaticPopupDialogs["QHC_Reset_Dialog"] then
										StaticPopupDialogs["QHC_Reset_Dialog"] = {
											text = L["ActionsResetDialogText"],
											button1 = L["ActionsDialogReset"],
											button2 = L["ActionsDialogCancel"],
											OnAccept = function()
												QuestHelper.purge_code = 'asdf'; -- hack a 'force' parameter
												QuestHelper:HardReset('asdf');
											end,
											hideOnEscape = 1,
											timeout = -1,
										};
									end
									StaticPopup_Show("QHC_Reset_Dialog");
								end,
							},
							Submit = {
								type = "execute",
								order = 6,
								name = L["ActionsSubmitName"],
								desc = L["ActionsSubmitDesc"],
								func = function()
									QuestHelper:Submit();
								end,
							},
							Changes = {
								type = "execute",
								order = 6,
								name = L["ActionsChangesName"],
								desc = L["ActionsChangesDesc"],
								func = function()
									QuestHelper:ChangeLog();
								end,
							},
						},
					},
					AdditionalInfo = {
						type = "group",
						order = 4,
						guiInline = true,
						name = L["AdditionalInfoName"],
						desc = L["AdditionalInfoDesc"],
						args = {
							Tooltip = {
								type = "toggle",
								order = 1,
								name = L["InfoTooltipName"],
								desc = L["InfoTooltipDesc"],
								get = function(i)
									return QuestHelper_Pref['tooltip'];
								end,
								set = function(i, v)
									QuestHelper_Pref['tooltip'] = v;
								end,
							},
							Metric = {
								type = "select",
								order = 5,
								name = L["InfoMetricName"],
								desc = L["InfoMetricDesc"],
								values = {
									yards = "Yards",
									meters = "Meters",
								},
								get = function(i)
									local v = QuestHelper_Pref['metric'];
									if v then
										return "meters";
									else
										return "yards";
									end
								end,
								set = function(i, v)
									QuestHelper_Pref['metric'] = (v == 'meters' and true) or false;
								end,
							},
							FlightTime = {
								type = "toggle",
								order = 2,
								name = L["InfoFlightName"],
								desc = L["InfoFlightDesc"],
								get = function(i)
									return QuestHelper_Pref['flight_time'];
								end,
								set = function(i, v)
									QuestHelper_Pref['flight_time'] = v;
								end,
							},
							TravelTime = {
								type = "toggle",
								order = 3,
								name = L["InfoTravelName"],
								desc = L["InfoTravelDesc"],
								get = function(i)
									return QuestHelper_Pref['travel_time'];
								end,
								set = function(i, v)
									QuestHelper_Pref['travel_time'] = v;
								end,
							},
							MapButton = {
								type = "toggle",
								order = 4,
								name = L["MapButtonName"],
								desc = L["MapButtonDesc"],
								get = function(i)
									return QuestHelper_Pref['map_button'];
								end,
								set = function(i, v)
									QuestHelper_Pref['map_button'] = v;
									if QuestHelper_Pref['map_button'] then
										QuestHelper:InitMapButton();
									else
										QuestHelper:HideMapButton();
									end
								end,
							},
							MiniOpacity = {
								type = "range",
								order = 6,
								name = L["InfoMiniName"],
								desc = L["InfoMiniDesc"],
								min = 0,
								max = 1,
								step = 0.1,
								isPercent = true,
								get = function(i)
									return QuestHelper_Pref['mini_opacity'];
								end,
								set = function(i, v)
									QuestHelper_Pref['mini_opacity'] = v;
								end,
							},
						},
					},
				},
			},
			InterfaceOptions = {
				type = "group",
				order = 3,
				name = L["InterfaceOptionsName"],
				desc = L["InterfaceOptionsDesc"],
				disabled = function()
					return QuestHelper_Pref['hide'];
				end,
				args = {
					intro = {
						type = "description",
						order = 0,
						name = L["InterfaceIntro"]
					},
					ArrowOptions = {
						order = 1,
						type = "group",
						guiInline = true,
						name = L["ArrowOptionsName"],
						desc = L["ArrowOptionsDesc"],
						args = {
							Enable = {
								type = "toggle",
								order = 1,
								name = L["ArrowEnableName"],
								desc = L["ArrowEnableDesc"],
								get = function(i)
									return QuestHelper_Pref['arrow'];
								end,
								set = function(i, v)
									QuestHelper_Pref['arrow'] = v;
								end,
							},
							Locked = {
								type = "toggle",
								order = 2,
								name = L["ArrowLockedName"],
								desc = L["ArrowLockedDesc"],
								disabled = function()
									return not QuestHelper_Pref['arrow'] or QuestHelper_Pref['hide'];
								end,
								get = function(i)
									return QuestHelper_Pref['arrow_locked'];
								end,
								set = function(i, v)
									QuestHelper_Pref['arrow_locked'] = v;
								end,
							},
							Scale = {
								type = "range",
								order = 3,
								name = L["ArrowScaleName"],
								desc = L["ArrowScaleDesc"],
								min = 0.5,
								max = 1.5,
								step = 0.1,
								isPercent = true,
								disabled = function()
									return not QuestHelper_Pref['arrow'] or QuestHelper_Pref['hide'];
								end,
								get = function(i)
									return (QuestHelper_Pref['arrow_scale'] == nil) and 1 or QuestHelper_Pref['arrow_scale']; -- arrow_scale == nil ? 1 : arrow_scale
								end,
								set = function(i, v)
									QH_Arrow_SetScale(v);
								end,
							},
							TextSize = {
								type = "range",
								order = 4,
								name = L["ArrowTextSizeName"],
								desc = L["ArrowTextSizeDesc"],
								min = 0.5,
								max = 1.5,
								step = 0.1,
								isPercent = true,
								disabled = function()
									return not QuestHelper_Pref['arrow'] or QuestHelper_Pref['hide'];
								end,
								get = function(i)
									return (QuestHelper_Pref['arrow_textsize'] == nil) and 1 or QuestHelper_Pref['arrow_textsize'];
								end,
								set = function(i, v)
									QH_Arrow_SetTextScale(v);
								end,
							},
							Reset = {
								type = "execute",
								order = 5,
								name = L["ArrowResetName"],
								desc = L["ArrowResetDesc"],
								disabled = function()
									return not QuestHelper_Pref['arrow'] or QuestHelper_Pref['hide'];
								end,
								func = function()
									QH_Arrow_Reset();
								end,
							},
						},
					},
					TrackerOptions = {
						order = 2,
						type = "group",
						guiInline = true,
						name = L["TrackerOptionsName"],
						desc = L["TrackerOptionsDesc"],
						args = {
							Enable = {
								order = 1,
								type = "toggle",
								name = L["TrackerEnableName"],
								desc = L["TrackerEnableDesc"],
								get = function(i)
									return QuestHelper_Pref['track'];
								end,
								set = function(i, v)
									QuestHelper_Pref['track'] = v;
									if QuestHelper_Pref['track'] then
										QuestHelper:ShowTracker();
									else
										QuestHelper:HideTracker();
									end
								end,
							},
							Minimized = {
								order = 2,
								type = "toggle",
								name = L["TrackerMinimizeName"],
								desc = L["TrackerMinimizeDesc"],
								disabled = function()
									return not QuestHelper_Pref['track'] or QuestHelper_Pref['hide'];
								end,
								get = function(i)
									return QuestHelper_Pref['track_minimized'];
								end,
								set = function(i, v)
									QuestHelper_Pref['track_minimized'] = v;
									if QuestHelper_Pref['track_minimized'] then
										QuestHelperQuestWatchFrameMinimizeButton:GetScript("OnLeave")();
										QuestHelper.tracker:Hide();
									else
										QuestHelperQuestWatchFrameMinimizeButton:GetScript("OnLeave")();
										QuestHelper.tracker:Show();
									end
								end,
							},
							Scale = {
								type = "range",
								order = 3,
								name = L["TrackScaleName"],
								desc = L["TrackScaleDesc"],
								min = 0.5,
								max = 2,
								step = 0.1,
								isPercent = true,
								disabled = function()
									return not QuestHelper_Pref['track'] or QuestHelper_Pref['hide'];
								end,
								get = function(i)
									return QuestHelper_Pref['track_scale']; -- default to 1 if arrow_scale is nil
								end,
								set = function(i, v)
									QuestHelper_Pref['track_scale'] = v;
									QuestHelper.tracker:SetScale(QuestHelper_Pref.track_scale)
								end,
							},
							Lines = {
								type = "range",
								order = 4,
								name = L["TrackLinesName"],
								desc = L["TrackLinesDesc"],
								min = 2,
								max = 20,
								step = 1,
								disabled = function()
									return not QuestHelper_Pref['track'] or QuestHelper_Pref['hide'];
								end,
								get = function(i)
									return QuestHelper_Pref['track_size'];
								end,
								set = function(i, v)
									QuestHelper_Pref['track_size'] = v;
									QH_Tracker_Rescan();
								end,
							},
							Level = {
								order = 5,
								type = "toggle",
								name = L["TrackerLevelName"],
								desc = L["TrackerLevelDesc"],
								width = "double",
								disabled = function()
									return not QuestHelper_Pref['track'] or QuestHelper_Pref['hide'];
								end,
								get = function(i)
									return QuestHelper_Pref['track_level'];
								end,
								set = function(i, v)
									QuestHelper_Pref['track_level'] = v;
									QH_UpdateQuests(true)
									QH_Tracker_Rescan()
								end,
							},
							QuestColor = {
								order = 6,
								type = "toggle",
								name = L["TrackerQColorName"],
								desc = L["TrackerQColorDesc"],
								width = "double",
								disabled = function()
									return not QuestHelper_Pref['track'];
								end,
								get = function(i)
									return QuestHelper_Pref['track_qcolour'];
								end,
								set = function(i, v)
									QuestHelper_Pref['track_qcolour'] = v;
									QH_UpdateQuests(true)
									QH_Tracker_Rescan()
								end,
							},
							ObjColor = {
								order = 7,
								type = "toggle",
								name = L["TrackerOColorName"],
								desc = L["TrackerOColorDesc"],
								width = "double",
								disabled = function()
									return not QuestHelper_Pref['track'] or QuestHelper_Pref['hide'];
								end,
								get = function(i)
									return QuestHelper_Pref['track_ocolour'];
								end,
								set = function(i, v)
									QuestHelper_Pref['track_ocolour'] = v;
									QH_UpdateQuests(true)
									QH_Tracker_Rescan()
								end,
							},
						},
					},
					MapOptions = {
						type = "group",
						order = 3,
						guiInline = true,
						name = L["MapOptionsName"],
						desc = L["MapOptionsDesc"],
						args = {
							BlizzMap = {
								type = "toggle",
								order = 1,
								name = L["MapBlizzMapName"],
								desc = L["MapBlizzMapDesc"],
								hidden = function()
									return not UpdateQuestMapPOI; -- likely removed for WoW
								end,
								get = function(i)
									return QuestHelper_Pref['blizzmap'];
								end,
								set = function(i, v)
									QuestHelper_Pref['blizzmap'] = v;
								end,
							},
							Ants = {
								type = "toggle",
								order = 2,
								name = L["MapAntsName"],
								desc = L["MapAntsDesc"],
								get = function(i)
									return QuestHelper_Pref['show_ants'];
								end,
								set = function(i, v)
									QuestHelper_Pref['show_ants'] = v;
								end,
							},
							Zones = {
								type = "toggle",
								order = 3,
								name = L["MapZonesName"],
								desc = L["MapZonesDesc"],
								get = function(i)
									return QuestHelper_Pref['zones'] == 'next';
								end,
								set = function(i)
									QuestHelper_Pref['zones'] = (v and 'next') or 'none';
								end,
							},
							Scale = {
								type = "range",
								order = 4,
								min = 0.1,
								max = 1.5,
								step = .05,
								isPercent = true,
								name = L["MapScaleName"],
								desc = L["MapScaleDesc"],
								get = function(i)
									return QuestHelper_Pref['scale'];
								end,
								set = function(i, v)
									QuestHelper_Pref['scale'] = v;
								end,
							},
						},
					},
				},
			},
			RouteOptions = {
				type = "group",
				order = 2,
				name = L["RouteOptionsName"],
				desc = L["RouteOptionsDesc"],
				disabled = function()
					return QuestHelper_Pref['hide'];
				end,
				args = {
					intro = {
						type = "description",
						order = 0,
						name = L["RouteIntro"],
					},
					Solo = {
						type = "toggle",
						order = 1,
						name = L["RouteSoloName"],
						desc = L["RouteSoloDesc"],
						get = function(i)
							return QuestHelper_Pref['solo'];
						end,
						set = function(i, v)
							QuestHelper_Pref['solo'] = v;
							if QuestHelper_Pref['solo'] and QuestHelper_Pref['share'] then
								QuestHelper:SetShare(false);
							elseif QuestHelper_Pref['share'] then
								QuestHelper:SetShare(true);
							end
						end,
					},
					Share = {
						type = "toggle",
						order = 2,
						name = L["RouteShareName"],
						desc = L["RouteShareDesc"],
						disabled = function()
							return QuestHelper_Pref['solo'] or QuestHelper_Pref['hide'];
						end,
						get = function(i)
							return QuestHelper_Pref['share'];
						end,
						set = function(i, v)
							QuestHelper_Pref['share'] = v;
							if QuestHelper_Pref['share'] and not QuestHelper_Pref['solo'] then
								QuestHelper:SetShare(true);
							elseif QuestHelper_Pref['solo'] then
								QusetHelper:SetShare(false);
							end
						end,
					},
					ObjectiveFitlers = {
						type = "group",
						order = 3,
						guiInline = true,
						name = L["RouteFiltersName"],
						desc = L["RouteFiltersDesc"],
						args = {
							Level = {
								type = "toggle",
								order = 1,
								name = L["FilterLevelName"],
								desc = L["FilterLevelDesc"],
								get = function(i)
									return QuestHelper_Pref['filter_level'];
								end,
								set = function(i, v)
									QuestHelper_Pref['filter_level'] = v;
									QH_Route_Filter_Rescan("filter_quest_level");
								end,
							},
							LevelOffset = {
								type = "range",
								order = 2,
								name = L["FilterLevelOffsetName"],
								desc = L["FilterLevelOffsetDesc"],
								min = -2,
								max = 5,
								step = 1,
								get = function(i)
									return QuestHelper_Pref['level'];
								end,
								set = function(i, v)
									QuestHelper_Pref['level'] = v;
									QH_Route_Filter_Rescan("filter_quest_level");
								end,
								disabled = function()
									return not QuestHelper_Pref['filter_level'] or QuestHelper_Pref['hide'];
								end,
							},
							Group = {
								type = "toggle",
								order = 3,
								name = L["FilterGroupName"],
								desc = L["FilterGroupDesc"],
								get = function(i)
									return QuestHelper_Pref['filter_group'];
								end,
								set = function(i, v)
									QuestHelper_Pref['filter_group'] = v;
									QH_Route_Filter_Rescan("filter_quest_group");
								end,
							},
							GroupSize = {
								type = "range",
								order = 4,
								name = L["FilterGroupSizeName"],
								desc = L["FilterGroupSizeDesc"],
								min = 2,
								max = 5,
								step = 1,
								get = function(i)
									return QuestHelper_Pref['filter_group_param'];
								end,
								set = function(i, v)
									QuestHelper_Pref['filter_group_param'] = v;
									QH_Route_Filter_Rescan("filter_quest_level");
								end,
								disabled = function()
									return not QuestHelper_Pref['filter_group'] or QuestHelper_Pref['hide'];
								end,
							},
							Zone = {
								type = "toggle",
								order = 5,
								name = L["FilterZoneName"],
								desc = L["FilterZoneDesc"],
								width = "double",
								get = function(i)
									return QuestHelper_Pref['filter_zone'];
								end,
								set = function(i, v)
									QuestHelper_Pref['filter_zone'] = v;
									QH_Route_Filter_Rescan("filter_zone");
								end,
							},
							Done = {
								type = "toggle",
								order = 6,
								name = L["FilterDoneName"],
								desc = L["FilterDoneDesc"],
								width = "double",
								get = function(i)
									return QuestHelper_Pref['filter_done'];
								end,
								set = function(i, v)
									QuestHelper_Pref['filter_done'] = v;
									QH_Route_Filter_Rescan("filter_quest_done");
								end,
							},
							Blocked = {
								type = "toggle",
								order = 7,
								name = L["FilterBlockedName"],
								desc = L["FilterBlockedDesc"],
								width = "double",
								get = function(i)
									return QuestHelper_Pref['filter_blocked'];
								end,
								set = function(i, v)
									QuestHelper_Pref['filter_blocked'] = v;
									QH_Route_Filter_Rescan("filter_blocked");
								end,
							},
							Watched = {
								type = "toggle",
								order = 8,
								name = L["FilterWatchedName"],
								desc = L["FilterWatchedDesc"],
								width = "double",
								get = function(i)
									return QuestHelper_Pref['filter_watched'];
								end,
								set = function(i, v)
									QuestHelper_Pref['filter_watched'] = v;
									QH_Route_Filter_Rescan("filter_quest_watched");
								end,
							},
							Wintergrasp = {
								type = "toggle",
								order = 9,
								name = L["FilterWGName"],
								desc = L["FilterWGDesc"],
								width = "double",
								get = function(i)
									return QuestHelper_Pref['filter_wintergrasp'];
								end,
								set = function(i, v)
									QuestHelper_Pref['filter_wintergrasp'] = v;
									QH_Route_Filter_Rescan("filter_quest_wintergrasp");
								end,
							},
							Raid = {
								type = "toggle",
								order = 10,
								name = L["FilterRaidName"],
								desc = L["FilterRaidDesc"],
								width = "double",
								get = function(i)
									return QuestHelper_Pref['filter_raid_accessible'];
								end,
								set = function(i, v)
									QuestHelper_Pref['filter_raid_accessible'] = v;
									QH_Route_Filter_Rescan("filter_quest_raid_accessible");
								end,
							},
						},
					},
				},
			},
			Plugins = {
				order = 3,
				type = "group",
				name = L["PluginOptionsName"],
				desc = L["PluginOptionsDesc"],
				disabled = function()
					return QuestHelper_Pref['hide'];
				end,
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["PluginIntro"],
					},
					Cartographer = {
						order = 2,
						type = "group",
						guiInline = true,
						name = L["PluginCartographerName"],
						desc = L["PluginCartographerDesc"],
						disabled = function()
							return not Cartographer_Waypoints or QuestHelper_Pref['hide'];
						end,
						args = {
							Arrow = {
								order = 1,
								type = "toggle",
								name = L["CartographerArrowName"],
								desc = L["CartographerArrowDesc"],
								get = function(i)
									return QuestHelper_Pref['cart_wp_new'];
								end,
								set = function(i, v)
									QuestHelper_Pref['cart_wp_new'] = v;
									if QuestHelper_Pref['cart_wp_new'] then
										QuestHelper:EnableCartographer();
									else
										QuestHelper:DisableCartographer();
									end
								end,
							},
						},
					},
					TomTom = {
						order = 3,
						type = "group",
						guiInline = true,
						name = L["PluginTomTomName"],
						desc = L["PluginTomTomDesc"],
						disabled = function()
							return not TomTom or QuestHelper_Pref['hide'];
						end,
						args = {
							Arrow = {
								order = 1,
								type = "toggle",
								name = L["TomTomArrowName"],
								desc = L["TomTomArrowDesc"],
								get = function(i)
									return QuestHelper_Pref['tomtom_wp_new'];
								end,
								set = function(i, v)
									QuestHelper_Pref['tomtom_wp_new'] = v;
									if QuestHelper_Pref['tomtom_wp_new'] then
										QuestHelper:EnableTomTom();
									else
										QuestHelper:DisableTomTom();
									end
								end,
							},
						},
					},
				},
			},
		},
	};
end

function addon:GenerateQHLocales()
	local l = {};
	for loc, tbl in pairs(QuestHelper_Translations) do
		if tbl.LOCALE_NAME and tbl.LOCALE_NAME ~= '???' then
			l[loc] = tbl.LOCALE_NAME;
		end
	end
	addon.QHLocales = l;
end





if not addon then
	error("QuestHelperConfig did not load properly.");
end

local locale = {
	Data = {},
	CurLocale = "enUS",
};

function locale:SetCurrentLocale(loc)
	if not loc then -- reset locale
		loc = GetLocale(); -- default to client locale
	end
	if self.Data[loc] then -- only change if data is available
		self.CurLocale = loc;
	end
end

--[[
	loc: locale to register data for
	data: key-value pairs to register
	force: clear existing data before adding new data
--]]
function locale:RegisterData(loc, data, force)
	local d = self.Data[loc];
	if force and d then
		self:ClearTable(d);
	end
	if not d then
		self.Data[loc] = {};
		d = self.Data[loc];
	end
	for k, v in pairs(data) do -- add the new data
		d[k] = v;
	end
end

local function locale__index(t, k)
	local d, l = t.Data, t.CurLocale;
	if d[l] and d[l][k] then
		return d[l][k];
	elseif d["enUS"] and d["enUS"][k] then
		return d["enUS"][k];
	else
		return k;
	end
end

local function locale__newindex(t, k, v)
	local d, l = t.Data, t.CurLocale;
	if d[l] then
		d[l][k] = v;
	else
		d[l] = {};
		d[l][k] = v;
	end
	return v;
end

setmetatable(locale, {
	__index = locale__index,
	__newindex = locale__newindex,
});

addon.Locale = locale;





-- this is pretty dang grim isn't it
if not QHConfig or not QHConfig.Locale then
	return; -- if we made it this far, one or more errors are already shown
--	error("QuestHelperConfig did not load properly.");
end

local l = QHConfig.Locale;

l:RegisterData("enUS", {
	["GlobalOptionsName"] = "Interface options",
	["GlobalOptionsDesc"] = "Configure QuestHelper interface options",
	["FilterBlockedName"] = "Blocked Objectives",
	["FilterBlockedDesc"] = "Hide objectives that rely on incomplete objectives, such as quest turn-ins for incomplete quests",
	["FilterDoneName"] = "Complete Objectives",
	["FilterDoneDesc"] = "Only show objectives for complete quests",
	["FilterLevelName"] = "Quest level",
	["FilterLevelDesc"] = "Filter quests that are higher level than you",
	["FilterGroupName"] = "Group Quests",
	["FilterGroupDesc"] = "Filters objectives that require groups",
	["FilterWatchedName"] = "Watched quests",
	["FilterWatchedDesc"] = "Only show quests tracked in the Quest Log",
	["FilterZoneName"] = "Zone filter",
	["FilterZoneDesc"] = "Filter objectives outside the current zone",
	["TooltipOpenConfig"] = "Right click: Open configuration window",
	["GlobalEnableName"] = "Enable QuestHelper",
	["GlobalEnableDesc"] = "Enable/Disable QuestHelper",
	["PerfName"] = "Performance Options",
	["PerfDesc"] = "",
	["PerfRouteName"] = "Routing Performance",
	["PerfRouteDesc"] = "Percentage of default resources to use for calculating the route",
	["PerfLoadName"] = "Loading Performance",
	["PerfLoadDesc"] = "Percentage of default resources to use when loading quest and achievement data",
	["ArrowOptionsName"] = "Waypoint Arrow Options",
	["ArrowOptionsDesc"] = "",
	["ArrowEnableName"] = "Enable",
	["ArrowEnableDesc"] = "Show/Hide the waypoint arrow",
	["ArrowLockedName"] = "Lock",
	["ArrowLockedDesc"] = "Lock the waypoint arrow in place",
	["ArrowScaleName"] = "Size",
	["ArrowScaleDesc"] = "Size of the waypoint arrow (100% is normal size)",
	["ArrowTextSizeName"] = "Text Size",
	["ArrowTextSizeDesc"] = "Size of waypoint arrow text (100% is normal size)",
	["TrackerOptionsName"] = "Quest Tracker Options",
	["TrackerOptionsDesc"] = "",
	["TrackerEnableName"] = "Enable",
	["TrackerEnableDesc"] = "Show/Hide the QuestHelper quest tracker",
	["TrackerMinimizeName"] = "Minimize",
	["TrackerMinimizeDesc"] = "Minimize the QuestHelper quest tracker",
	["TrackScaleName"] = "Quest Tracker Size",
	["TrackScaleDesc"] = "Size of the quest tracker (100% is normal size)",
	["TrackerLevelName"] = "Quest Level",
	["TrackerLevelDesc"] = "Show/Hide quest level in the tracker",
	["TrackerQColorName"] = "Quest Color",
	["TrackerQColorDesc"] = "Color quest names in the tracker based on level",
	["TrackerOColorName"] = "Objective Color",
	["TrackerOColorDesc"] = "Color quest objectives based on progress",
	["RouteOptionsName"] = "Route Calculation Options",
	["RouteOptionsDesc"] = "Options to control route calculation",
	["RouteIntro"] = "Options to control route calculation",
	["InterfaceIntro"] = "Options to control how QuestHelper interacts with the interface",
	["RouteSoloName"] = "Solo mode",
	["RouteSoloDesc"] = "Ignore party members and disable communications with party members.",
	["RouteShareName"] = "Objective Sharing",
	["RouteShareDesc"] = "Inform your party members of objectives you have and have not completed.",
	["RouteFiltersName"] = "Objective Filter Options",
	["RouteFiltersDesc"] = "",
	["FilterGroupSizeName"] = "Group size",
	["FilterGroupSizeDesc"] = "Threshold party size for filtering group quests",
	["FilterLevelOffsetName"] = "Level difference",
	["FilterLevelOffsetDesc"] = "Threshold level difference for filtering quests",
	["FilterRaidName"] = "Raid Accessible Quests",
	["FilterRaidDesc"] = "Hide non-raid quests while in a raid group",
	["FilterWGName"] = "Lake Wintergrasp Quests",
	["FilterWGDesc"] = "Hide PvP-quests for Lake Wintergrasp while outside Lake Wintergrasp",
	["PluginOptionsName"] = "Plugin Options",
	["PluginOptionsDesc"] = "",
	["PluginIntro"] = "Options for 3rd party addons. 3rd party addons need to be installed for these options to be available",
	["PluginCartographerName"] = "Cartographer options",
	["PluginCartographerDesc"] = "",
	["CartographerArrowName"] = "Waypoint Arrow",
	["CartographerArrowDesc"] = "Use the Cartographer Waypoint Arrow instead of the built-in QuestHelper arrow",
	["PluginTomTomName"] = "TomTom options",
	["PluginTomTomDesc"] = "",
	["TomTomArrowName"] = "Waypoint Arrow",
	["TomTomArrowDesc"] = "Use the TomTom Waypoint Arrow instead of the built-in QuestHelper arrow",
	["MapOptionsName"] = "Map Options",
	["MapOptionsDesc"] = "",
	["MapAntsName"] = "Ant Trails",
	["MapAntsDesc"] = "Show ant trails on the world map",
	["MapScaleName"] = "Map Icon Size",
	["MapScaleDesc"] = "Size of icons, ant trails, etc on the world map and minimap (100 is normal size)",
	["AdditionalInfoName"] = "Miscellaneous options",
	["AdditionalInfoDesc"] = "",
	["InfoTooltipName"] = "Tooltip info",
	["InfoTooltipDesc"] = "Show quest progress in the tooltips of monsters, items, etc",
	["InfoMetricName"] = "Distance metric",
	["InfoMetricDesc"] = "Unit of measure to use when calculating distances",
	["InfoFlightName"] = "Show flight times",
	["InfoFlightDesc"] = "Show an estimated flight time onscreen while flying",
	["InfoTravelName"] = "Show travel times",
	["InfoTravelDesc"] = "Show an estimated travel time in objective tooltips",
	["MapButtonName"] = "World map button",
	["MapButtonDesc"] = "Show the QuestHelper button on the world map",
	["InfoMiniName"] = "Minimap item transparency",
	["InfoMiniDesc"] = "Adjust the transparency of QuestHelper items on the minimap",
	["MapBlizzMapName"] = "Blizzard map points",
	["MapBlizzMapDesc"] = "Show the built-in Blizzard map points",
	["MapZonesName"] = "Map zones",
	["MapZonesDesc"] = "Highlight areas of the world map where the current objective is located",
	["IncompleteToggleTooltip"] = "Shift+Left Click: Toggle incomplete quest start locations",
	["TrackLinesName"] = "Objectives shown",
	["TrackLinesDesc"] = "Change the number of objectives shown in the tracker. Watched quests will always be shown in the tracker.",
	["ErrorName"] = "This version of QuestHelperConfig is designed for a newer version of the QuestHelper addon. Please visit Curse or WoW Interface to update your version of QuestHelper.\nCurrent QuestHelper version: %s.\nTarget QuestHelper version: %s.",
	["ArrowResetName"] = "Reset arrow position",
	["ArrowResetDesc"] = "Unlock the waypoint arrow and bring it to the center of the screen. Use this if you can't find the arrow onscreen.",
	["ActionsName"] = "Useful commands",
	["ActionsDesc"] = "",
	["ActionsHiddenName"] = "/qh hidden",
	["ActionsHiddenDesc"] = "Display a list of hidden objectives and why those objectives are hidden.",
	["ActionsIncompName"] = "/qh incomplete",
	["ActionsIncompDesc"] = "Toggle map markers for incomplete quests.",
	["ActionsPurgeName"] = "/qh purge",
	["ActionsPurgeDesc"] = "Purge the local database of collected information. Deletes all collected data.\nPlease submit your data to qhaddon@gmail.com before performing a purge.",
	["ActionsPurgeDialogText"] = "Are you sure you want to purge the local database?\nThis will delete all collected data.\nEnter /qh submit for instructions on how to submit your collected data.",
	["ActionsResetName"] = "/qh hardreset",
	["ActionsResetDesc"] = "Reset QuestHelper to \"factory default\" settings. Deletes all collected data and preferences.\nPlease submit your data to qhaddon@gmail.com before performing a hard reset.",
	["ActionsResetDialogText"] = "Are you sure you want to reset QuestHelper?\nThis will delete all collected data and preferences.\nEnter /qh submit for instructions on how to submit your collected data.",
	["ActionsDialogPurge"] = "Purge",
	["ActionsDialogCancel"] = "Cancel",
	["ActionsDialogReset"] = "Reset",
	["ActionsChangesName"] = "/qh changes",
	["ActionsChangesDesc"] = "View the changelog for the current version.",
	["InterfaceOptionsName"] = "",
	["InterfaceOptionsDesc"] = "",
	["ActionsSubmitName"] = "/qh submit",
	["ActionsSubmitDesc"] = "View information on how to submit collected data.",
});




if not QHConfig or not QHConfig.Locale then
	return; -- if we made it this far, one or more errors are already shown
--	error("QuestHelperConfig did not load properly.");
end

local l = QHConfig.Locale;

local L = {};
L["ActionsDialogCancel"] = "Abbrechen"
L["AdditionalInfoName"] = "Verschiedene Einstellungen"
L["ArrowEnableDesc"] = "Wegepfeil zeigen/verbergen"
L["ArrowEnableName"] = "ein"
L["ArrowLockedDesc"] = "Wegpfeil sperren"
L["ArrowLockedName"] = "gesperrt"
L["ArrowOptionsName"] = "Wegepfeil Einstellungen"
L["ArrowScaleDesc"] = "Wegpfeilgr\195\182\195\159e (100% ist Normalgr\195\182\195\159e)"
L["ArrowScaleName"] = "Gr\195\182\195\159e"
L["ArrowTextSizeDesc"] = "Gr\195\182\195\159e des Wegpfeiltextes (100% ist Normalgr\195\182\195\159e)"
L["ArrowTextSizeName"] = "Textgr\195\182\195\159e"
L["CartographerArrowDesc"] = "Verwende Wegpfeil von Cartograpfer anstelle des eingebauten QuestHelper-Wegpfeils"
L["CartographerArrowName"] = "Wegepunkt Pfeil"
L["FilterGroupName"] = "Gruppenquests"
L["FilterGroupSizeName"] = "Gruppengr\195\182\195\159e"
L["FilterLevelDesc"] = "Quests ausblenden, die ein h\195\182heres Level haben als man selbst"
L["FilterLevelName"] = "Questlevel"
L["FilterLevelOffsetName"] = "Levelunterschied"


l:RegisterData("deDE", L);
