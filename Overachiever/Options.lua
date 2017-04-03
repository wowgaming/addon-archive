
local L = OVERACHIEVER_STRINGS
local THIS_VERSION = GetAddOnMetadata("Overachiever", "Version")

Overachiever.DefaultSettings = {
  Tooltip_ShowProgress = true;
  Tooltip_ShowProgress_Other = true;
  Tooltip_ShowID = false;
  UI_SeriesTooltip = true;
  UI_RequiredForMetaTooltip = true;
  Tracker_AutoTimer = false;
  Explore_AutoTrack = false;
  Explore_AutoTrack_Completed = false;
  CritterTip_loved = true;
  CritterTip_killed = true;
  WellReadTip_read = true;
  AnglerTip_fished = true;
  Item_consumed = true;
  Item_consumed_whencomplete = false;
  CreatureTip_killed = false;
  LetItSnow_flaked = false;
  FistfulOfLove_petals = false;
  BunnyMaker_eared = false;
  CheckYourHead_pumpkin = false;
  TurkeyLurkey_feathered = false;
  Draggable_AchFrame = true;
  DragSave_AchFrame = false;
  SoundAchIncomplete = 0;
  SoundAchIncomplete_AnglerCheckPole = true;
  Version = THIS_VERSION;
};

local function SoundSelected(self, key, val, clicked)
  if (clicked) then  PlaySoundFile( self:Fetch() );  end
end

function Overachiever.CreateOptions(THIS_TITLE, BuildCriteriaLookupTab_check, AutoTrackCheck_Explore, CheckDraggable_AchFrame)
  local IDs = OVERACHIEVER_ACHID

  local items_general = {
	{ type = "labelwrap", text = L.OPT_LABEL_TOOLTIPS, topBuffer = 1 },
	{ variable = "Tooltip_ShowProgress", text = L.OPT_SHOWPROGRESS,
	  tooltip = L.OPT_SHOWPROGRESS_TIP },
	{ variable = "Tooltip_ShowProgress_Other", text = L.OPT_SHOWPROGRESS_OTHER,
	  tooltip = L.OPT_SHOWPROGRESS_OTHER_TIP },
	{ variable = "Tooltip_ShowID", text = L.OPT_SHOWID },
	
	{ type = "labelwrap", text = L.OPT_LABEL_TRACKING, topBuffer = 4 },
	{ variable = "Tracker_AutoTimer", text = L.OPT_AUTOTRACKTIMED, tooltip = L.OPT_AUTOTRACKTIMED_TIP },
	{ variable = "Explore_AutoTrack", text = L.OPT_AUTOTRACKEXPLORE,
	  tooltip = L.OPT_AUTOTRACKEXPLORE_TIP, OnChange = AutoTrackCheck_Explore },
	{ variable = "Explore_AutoTrack_Completed", text = L.OPT_AUTOTRACKEXPLORE_COMPLETED,
	  xOffset = 10, OnChange = AutoTrackCheck_Explore },

	{ type = "labelwrap", text = L.OPT_LABEL_MAINUI, topBuffer = 4, xOffset = 0 },
	{ variable = "UI_SeriesTooltip", text = L.OPT_UI_SERIESTIP, tooltip = L.OPT_UI_SERIESTIP_TIP },
	{ variable = "UI_RequiredForMetaTooltip", text = L.OPT_UI_REQUIREDFORMETATIP,
	  tooltip = L.OPT_UI_REQUIREDFORMETATIP_TIP, OnChange = BuildCriteriaLookupTab_check },
	{ variable = "Draggable_AchFrame", text = L.OPT_DRAGGABLE, OnChange = CheckDraggable_AchFrame },
	{ variable = "DragSave_AchFrame", text = L.OPT_DRAGSAVE, xOffset = 10, OnChange = CheckDraggable_AchFrame },
	
	{ type = "sharedmedia", mediatype = "sound", variable = "SoundAchIncomplete", text = L.OPT_SELECTSOUND,
	  tooltip = L.OPT_SELECTSOUND_TIP, tooltip2 = L.OPT_SELECTSOUND_TIP2,
	  xOffset = 0, topBuffer = 10, OnChange = SoundSelected },
	{ variable = "SoundAchIncomplete_AnglerCheckPole", text = L.OPT_SELECTSOUND_ANGLERCHECKPOLE,
	  tooltip = L.OPT_SELECTSOUND_ANGLERCHECKPOLE_TIP, xOffset = 10 },
  }

  local items_reminders = {
	{ type = "Oa_AchLabel", text = L.OPT_LABEL_NEEDTOKILL, topBuffer = 4, id1 = IDs.MediumRare, id2 = IDs.NorthernExposure },
	{ variable = "CreatureTip_killed", text = L.OPT_KILLCREATURETIPS, tooltip = L.OPT_KILLCREATURETIPS_TIP,
	  tooltip2 = L.OPT_KILLCREATURETIPS_TIP2, OnChange = BuildCriteriaLookupTab_check },

	{ type = "Oa_AchLabel", text = L.OPT_LABEL_ACHTWO, topBuffer = 4, id1 = IDs.LoveCritters, id2 = IDs.LoveCritters2 },
	{ variable = "CritterTip_loved", text = L.OPT_CRITTERTIPS, tooltip = L.OPT_CRITTERTIPS_TIP },

	{ type = "Oa_AchLabel", topBuffer = 4, id1 = IDs.PestControl },
	{ variable = "CritterTip_killed", text = L.OPT_PESTCONTROLTIPS, tooltip = L.OPT_PESTCONTROLTIPS_TIP },

	{ type = "Oa_AchLabel", text = L.OPT_LABEL_ACHTWO, topBuffer = 4, id1 = IDs.WellRead, id2 = IDs.HigherLearning },
	{ variable = "WellReadTip_read", text = L.OPT_WELLREADTIPS, tooltip = L.OPT_WELLREADTIPS_TIP },

	{ type = "Oa_AchLabel", text = L.OPT_LABEL_ACHTHREE, topBuffer = 4, id1 = IDs.Scavenger, id2 = IDs.OutlandAngler, id3 = IDs.NorthrendAngler },
	{ variable = "AnglerTip_fished", text = L.OPT_ANGLERTIPS, tooltip = L.OPT_ANGLERTIPS_TIP },

	{ type = "Oa_AchLabel", text = L.OPT_LABEL_ACHTWO, topBuffer = 4, id1 = IDs.HappyHour, id2 = IDs.TastesLikeChicken },
	{ variable = "Item_consumed", text = L.OPT_CONSUMEITEMTIPS, tooltip = L.OPT_CONSUMEITEMTIPS_TIP, tooltip2 = L.OPT_CONSUMEITEMTIPS_TIP2 },
	{ variable = "Item_consumed_whencomplete", text = L.OPT_CONSUMEITEMTIPS_WHENCOMPLETE, xOffset = 10 },

	{ type = "labelwrap", text = L.OPT_LABEL_SEASONALACHS, justifyH = "CENTER", topBuffer = 16 },

	{ type = "Oa_AchLabel", topBuffer = 4, xOffset = 0, id1 = IDs.FistfulOfLove },
	{ variable = "FistfulOfLove_petals", text = L.OPT_FISTFULOFLOVETIPS, tooltip = L.OPT_FISTFULOFLOVETIPS_TIP },

	{ type = "Oa_AchLabel", topBuffer = 4, xOffset = 0, id1 = IDs.BunnyMaker },
	{ variable = "BunnyMaker_eared", text = L.OPT_BUNNYMAKERTIPS, tooltip = L.OPT_BUNNYMAKERTIPS_TIP },

	{ type = "Oa_AchLabel", topBuffer = 4, id1 = IDs.CheckYourHead },
	{ variable = "CheckYourHead_pumpkin", text = L.OPT_CHECKYOURHEADTIPS, tooltip = L.OPT_CHECKYOURHEADTIPS_TIP },

	{ type = "Oa_AchLabel", topBuffer = 4, id1 = IDs.TurkeyLurkey },
	{ variable = "TurkeyLurkey_feathered", text = L.OPT_TURKEYLURKEYTIPS, tooltip = L.OPT_TURKEYLURKEYTIPS_TIP },
	
	{ type = "Oa_AchLabel", topBuffer = 4, id1 = IDs.LetItSnow },
	{ variable = "LetItSnow_flaked", text = L.OPT_LETITSNOWTIPS, tooltip = L.OPT_LETITSNOWTIPS_TIP },
  }

  local title = THIS_TITLE.." v"..THIS_VERSION

  local mainpanel, oldver = TjOptions.CreatePanel(THIS_TITLE, nil, {
	title = title,
	itemspacing = 3,
	scrolling = true,
	items = items_general,
	variables = "Overachiever_Settings",
	defaults = Overachiever.DefaultSettings
  });

  local reminderspanel = TjOptions.CreatePanel(L.OPTPANEL_REMINDERTOOLTIPS, THIS_TITLE, {
	title = title..": |cffffffff"..L.OPTPANEL_REMINDERTOOLTIPS,
	itemspacing = 3,
	scrolling = true,
	items = items_reminders,
	variables = Overachiever_Settings,
	defaults = Overachiever.DefaultSettings
  });

  return reminderspanel, oldver
end



-- CREATE AND REGISTER CUSTOM OPTIONS ITEMS
---------------------------------------------

do
  local function icon_OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetHyperlink( GetAchievementLink(self.id) )
    if (GameTooltip:GetBottom() < self:GetTop()) then
      GameTooltip:ClearAllPoints()
      GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMRIGHT")
    end
  end

  local function icon_OnClick(self)
    if (IsShiftKeyDown()) then
      if ( ChatEdit_GetActiveWindow() ) then
        ChatEdit_InsertLink(GetAchievementLink(self.id));
      else
        ChatFrame_OpenChat(GetAchievementLink(self.id));
      end
    else
      Overachiever.OpenToAchievement(self.id)
    end
  end

  local function createicon(name, num, parent, id)
    name = name.."Icon"..num
    local iconframe = CreateFrame("Button", name, parent)
    iconframe:SetWidth(21); iconframe:SetHeight(21)
    iconframe.id = id
    --iconframe:SetHitRectInsets(6, -6, 6, -6)
    local icon = iconframe:CreateTexture(name.."Texture", "BACKGROUND")
    icon:SetWidth(21); icon:SetHeight(21)
    icon:SetPoint("LEFT", iconframe)
    local _, _, _, _, _, _, _, _, _, tex = GetAchievementInfo(id)
    if (tex) then
      icon:SetTexture(tex)
      iconframe:SetScript("OnEnter", icon_OnEnter)
      iconframe:SetScript("OnLeave", GameTooltip_Hide)
      iconframe:SetScript("OnClick", icon_OnClick)
    else
      icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    end
    --[[
    local border = iconframe:CreateTexture(name.."Border", "BORDER")
    border:SetWidth(30); border:SetHeight(30)
    border:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Progressive-IconBorder")
    border:SetPoint("TOPLEFT", iconframe)
    border:SetTexCoord(0, 0.65625, 0, 0.65625)
    --]]
    return iconframe
  end

  local CreateAchLabel_pre
  do
    local d, count
    local function achsub(s)
      count = count + 1
      local _, name = GetAchievementInfo(d["id"..count])
      return name or L.OPT_ACHUNKNOWN
    end

    function CreateAchLabel_pre(name, parent, data, arg)
      local first = createicon(name, 1, parent, data.id1)
      data.icon1 = first
      local i, v, last, w, iconframe = 2, data.id2, first, 28
      while (v) do
        iconframe = createicon(name, i, parent, v)
        iconframe:SetPoint("LEFT", last, "RIGHT", 2, 0)
        last = iconframe
        w, i = w + 23, i + 1
        v = data["id"..i]
      end
      data.iconN = last
      data.justifyH = data.justifyH or "LEFT"
      data.width = data.width or (369 - w)

      local text = data.text
      if (not text) then
        local _, n = GetAchievementInfo(data.id1)
        text = '"'..(n or L.OPT_ACHUNKNOWN)..'"'
      else
        d, count = data, 0
        text = text:gsub("(%%s)", achsub)
        d = nil
      end
      data.text = text
    end
  end

  local function CreateAchLabel_post(frame, handletip, xOffset, yOffset, btmBuffer, name, parent, data, arg)
    frame:SetPoint("LEFT", data.iconN, "RIGHT", 4, 1)
    local icon1 = data.icon1
    data.icon1, data.iconN = nil, nil
    return true, icon1, handletip, xOffset + 4, yOffset - 6, btmBuffer
  end

  TjOptions.RegisterItemType("Oa_AchLabel", tonumber(THIS_VERSION) or 0, "labelwrap",
    { create_prehook = CreateAchLabel_pre, create_posthook = CreateAchLabel_post })
end
