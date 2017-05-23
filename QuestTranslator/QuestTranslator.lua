-- Addon: QuestTranslator (version: 1.05) 2011.11.30
-- Description: AddOn displays translated quest information in a separete window.
-- Autor: Platine  (e-mail: platine.wow@gmail.com)
-- Based on addon "QuestJapanizer" v.0.5.8 by lalha


-- Global Variables
local QTR_name = UnitName("player");
local QTR_class= UnitClass("player");
local QTR_race = UnitRace("player");
local QTR_event="";
local QTR_waitTable = {};
local QTR_waitFrame = nil;
if not QuestTranslator then
   QuestTranslator = { };
end


function QuestTranslator_OnLoad1()
  QuestTranslator.frame1 = CreateFrame("Frame");
  QuestTranslator.frame1:RegisterEvent("ADDON_LOADED");
  QuestTranslator.frame1:RegisterEvent("QUEST_LOG_UPDATE");
  QuestTranslator.frame1:SetScript("OnEvent", function(self, event, ...) return QuestTranslator[event] and QuestTranslator[event](QuestTranslator, event, ...) end);
  QuestLogDetailScrollFrame:SetScript("OnShow", QuestTranslator_ShowAndUpdateQuestInfo);
  QuestLogDetailScrollFrame:SetScript("OnHide", QuestTranslator_HideQuestInfo);

  QuestTranslator_QuestTitle:SetFont(QuestTranslator_Font, 17);
  QuestTranslator_QuestDetail:SetFont(QuestTranslator_Font, 14);
  QuestTranslatorFrame1:ClearAllPoints();
  QuestTranslatorFrame1:SetPoint("TOPLEFT", QuestLogFrame, "TOPRIGHT", -3, -12);

  -- small button in QuestLogFrame
  QTR_ToggleButton1 = CreateFrame("Button",nil, QuestLogFrame, "UIPanelButtonTemplate");
  QTR_ToggleButton1:SetWidth(35);
  QTR_ToggleButton1:SetHeight(18);
  QTR_ToggleButton1:SetText("QTR");
  QTR_ToggleButton1:Show();
  QTR_ToggleButton1:ClearAllPoints();
  QTR_ToggleButton1:SetPoint("TOPLEFT", QuestLogFrame, "TOPLEFT", 620, -15);
  QTR_ToggleButton1:SetScript("OnClick", QuestTranslator_ToggleVisibility);

  -- button for ChangeFrameHeight
  QTR_ToggleButton2 = CreateFrame("Button",nil, QuestTranslatorFrame1, "UIPanelButtonTemplate");
  QTR_ToggleButton2:SetWidth(15);
  QTR_ToggleButton2:SetHeight(22);
  QTR_ToggleButton2:SetText("v");
  QTR_ToggleButton2:Show();
  QTR_ToggleButton2:ClearAllPoints();
  QTR_ToggleButton2:SetPoint("BOTTOMLEFT", QuestTranslatorFrame1, "BOTTOMRIGHT", -40, 9);
  QTR_ToggleButton2:SetScript("OnClick", QuestTranslator_ChangeFrameHeight);

  -- button for ChangeFrameWidth
  QTR_ToggleButton3 = CreateFrame("Button",nil, QuestTranslatorFrame1, "UIPanelButtonTemplate");
  QTR_ToggleButton3:SetWidth(15);
  QTR_ToggleButton3:SetHeight(22);
  QTR_ToggleButton3:SetText(">");
  QTR_ToggleButton3:Show();
  QTR_ToggleButton3:ClearAllPoints();
  QTR_ToggleButton3:SetPoint("BOTTOMLEFT", QuestTranslatorFrame1, "BOTTOMRIGHT", -25, 9);
  QTR_ToggleButton3:SetScript("OnClick", QuestTranslator_ChangeFrameWidth);

  hooksecurefunc("QuestLogTitleButton_OnClick", function() QuestTranslator_UpdateQuestInfo() end);
end


function QuestTranslator_OnLoad2()
  QuestTranslator.frame2 = CreateFrame("Frame");
  QuestTranslator.frame2:RegisterEvent("QUEST_DETAIL");
  QuestTranslator.frame2:RegisterEvent("QUEST_PROGRESS");
  QuestTranslator.frame2:RegisterEvent("QUEST_COMPLETE");
  QuestTranslator.frame2:SetScript("OnEvent", function(self, event, ...) return QuestTranslator[event] and QuestTranslator[event](QuestTranslator, event, ...) end);
  QuestTranslator_QuestTitle2:SetFont(QuestTranslator_Font, 17);
  QuestTranslator_QuestDetail2:SetFont(QuestTranslator_Font, 14);
  QuestTranslator_QuestWarning2:SetFont(QuestTranslator_Font, 12);
  QuestTranslatorFrame2:ClearAllPoints();
  QuestTranslatorFrame2:SetPoint("TOPLEFT", QuestFrame, "TOPRIGHT", -31, -19);
  QuestFrame:SetScript("OnHide", QuestTranslator_Frame2Close);
end


function QuestTranslator:ADDON_LOADED(_, addon)
  if (addon == "QuestTranslator") then
     QuestTranslator_CheckVars();
     local QTR_message = "|cffffff00QuestTranslator ver. 1.05 - " .. QuestTranslator_Messages.loaded;
     if (DEFAULT_CHAT_FRAME) then
         DEFAULT_CHAT_FRAME:AddMessage(QTR_message);
     else
         UIErrorsFrame:AddMessage(QTR_message, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
     end
     self.frame1:UnregisterEvent("ADDON_LOADED");
     self.ADDON_LOADED = nil;
     if (not isGetQuestID) then
        DetectEmuServer();
     end;
  end
end


function QuestTranslator:QUEST_LOG_UPDATE()
  if (QuestTranslatorFrame1:IsVisible()) then
     QuestTranslator_UpdateQuestInfo();
  end
end


function DetectEmuServer()
  QTR_PS["isGetQuestID"]="0";
  isGetQuestID="0";
  -- function GetQuestID() don't work on wow-emulator servers - possible lua error when you first start - not significant
  if ( GetQuestID() ) then
     QTR_PS["isGetQuestID"]="1";
     isGetQuestID="1";
  end
end


function QTR_wait(delay, func, ...)
  if(type(delay)~="number" or type(func)~="function") then
    return false;
  end
  if(QTR_waitFrame == nil) then
    QTR_waitFrame = CreateFrame("Frame","QTR_WaitFrame", UIParent);
    QTR_waitFrame:SetScript("onUpdate",function (self,elapse)
      local count = #QTR_waitTable;
      local i = 1;
      while(i<=count) do
        local waitRecord = tremove(QTR_waitTable,i);
        local d = tremove(waitRecord,1);
        local f = tremove(waitRecord,1);
        local p = tremove(waitRecord,1);
        if(d>elapse) then
          tinsert(QTR_waitTable,i,{d-elapse,f,p});
          i = i + 1;
        else
          count = count - 1;
          f(unpack(p));
        end
      end
    end);
  end
  tinsert(QTR_waitTable,{delay,func,{...}});
  return true;
end


function QuestTranslator:QUEST_DETAIL()
  QTR_event = "QUEST_DETAIL";
  if (isGetQuestID=="0") then
     if ( not QTR_wait(1,QuestTranslator_OnEvent2) ) then
        QuestTranslator_OnEvent2();
     end
  else
     QuestTranslator_OnEvent2();
  end
end


function QuestTranslator:QUEST_PROGRESS()
  QTR_event = "QUEST_PROGRESS";
  QuestTranslator_OnEvent2();
end


function QuestTranslator:QUEST_COMPLETE()
  QTR_event = "QUEST_COMPLETE";
  QuestTranslator_OnEvent2();
end


function QuestTranslator_OnEvent2()
  local q_ID = 0;
  local q_title = GetTitleText();
  local q_i = 1;
  -- search in QuestLog
  while GetQuestLogTitle(q_i) do
    local questTitle, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID = GetQuestLogTitle(q_i)
    if ( not isHeader ) then
       if ( q_title == questTitle ) then
          q_ID=questID;
          break;
       end
    end
    q_i = q_i + 1;
  end
  if ( QuestTranslator_Show )then
     QuestTranslator_QuestID2:SetText("");
     QuestTranslator_QuestTitle2:SetText(q_title);
     QuestTranslator_QuestDetail2:SetText(QuestTranslator_Messages.missing);
     QuestTranslator_QuestWarning2:SetText("");
     -- not exist in QuestLog ?
     if ( q_ID == 0 ) then
        if ( isGetQuestID=="1" ) then
           q_ID = GetQuestID();
        end
        if ( q_ID == 0 ) then
           if (QuestTranslator_QuestList[q_title]) then
              local q_lists=QuestTranslator_QuestList[q_title];
              q_i=string.find(q_lists, ",");
              if ( string.find(q_lists, ",")==nil ) then
                 -- only 1 questID to this title
                 q_ID=tonumber(q_lists);
              else
                 -- multiple questIDs - get first, available (not completed) questID from QuestLists
                 local QTR_table=QTR_split(q_lists, ",");
                 local QTR_multiple = "";
                 local QTR_Center="";
                 for ii,vv in ipairs(QTR_table) do
                    if (not QTR_PC[vv]) then
                       if (QTR_Center=="") then
                           QTR_Center=vv;
                       else
                           QTR_multiple = QTR_multiple .. ", " .. vv;
                       end
                    end
                 end
                 if ( string.len(QTR_Center)>0 ) then
                    q_ID=tonumber(QTR_Center);
                    if ( string.len(QTR_multiple)>0 ) then
                       QTR_multiple = " (" .. string.sub(QTR_multiple, 3) .. ")";
                       QuestTranslator_QuestWarning2:SetText(QuestTranslator_Messages.multipleID .. QTR_multiple);
                    end
                 end
              end
           end
        end
     end
     if ( q_ID > 0 ) then
        local str_id = tostring(q_ID);
        QuestTranslator_QuestID2:SetText("QuestID: " .. str_id);
        QuestTranslator_QuestTitle2:SetText(q_title);
        if (QuestTranslator_QuestData[str_id]) then
           -- display only, if translation exists
           QuestTranslator_ShowFrame2(QTR_event, str_id);
        else
           -- DEFAULT_CHAT_FRAME:AddMessage("QuestTranslator - Qid: "..tostring(q_ID).." ("..QuestTranslator_Messages.missing..")");
           QuestTranslatorFrame2:Hide();
        end
     end
  end
  if (event == "QUEST_COMPLETE") then
     if ( q_ID > 0) then
        local str_id = tostring(q_ID);
        QTR_PC[str_id]="OK";
     end
  end
end


function QuestTranslator_ShowFrame2(eventStr, qid)
  QuestTranslator_QuestID2:SetText("QuestID: " .. qid);
  QuestTranslator_QuestDetail2:SetText(QuestTranslator_Messages.missing);
  if (QuestTranslator_QuestData[qid]) then
     QuestTranslator_QuestTitle2:SetText(QuestTranslator_ExpandUnitInfo(QuestTranslator_QuestData[qid]["Title"]));
     local QTR_text = "";
     if (eventStr == "QUEST_DETAIL") then
        if (QuestTranslator_QuestData[qid]["Description"]) then
           QTR_text = QuestTranslator_ExpandUnitInfo(QuestTranslator_QuestData[qid]["Description"]);
        end;
        local QTR_text2 = "";
        if (QuestTranslator_QuestData[qid]["Objectives"]) then
           QTR_text2 = QuestTranslator_ExpandUnitInfo(QuestTranslator_QuestData[qid]["Objectives"]);
        end;
        QTR_text = QTR_text .. "\n\n" .. QuestTranslator_Messages.objectives .. "\n" .. QTR_text2;
     end
     if (eventStr == "QUEST_PROGRESS") then
        if (QuestTranslator_QuestData[qid]["Progress"]) then
           QTR_text = QuestTranslator_ExpandUnitInfo(QuestTranslator_QuestData[qid]["Progress"]);
        end;
     end
     if (eventStr == "QUEST_COMPLETE") then
        if (QuestTranslator_QuestData[qid]["Completion"]) then
           QTR_text = QuestTranslator_ExpandUnitInfo(QuestTranslator_QuestData[qid]["Completion"]);
        end
     end
     QuestTranslator_QuestDetail2:SetText(QTR_text);
     QuestTranslatorFrame2:Show();
  end
end


function QuestTranslator_Frame2Close()
  QuestTranslatorFrame2:Hide();
  QuestFrame_OnHide();
end


function QTR_split(str, c)
  local aCount = 0;
  local array = {};
  local a = string.find(str, c);
  while a do
     aCount = aCount + 1;
     array[aCount] = string.sub(str, 1, a-1);
     str=string.sub(str, a+1);
     a = string.find(str, c);
  end
  aCount = aCount + 1;
  array[aCount] = str;
  return array;
end


function QTR_findlast(source, char)
  if (not source) then
     return 0;
  end
  local lastpos = 0;
  local byte_char = string.byte(char);
  for i=1, #source do
     if (string.byte(source,i)==byte_char) then
        lastpos = i;
     end
  end
  return lastpos;
end


function QuestTranslator_CheckVars()
  if (not QTR_PS) then
     QTR_PS = {};
  end
  if (not QTR_PC) then
     QTR_PC = {};
  end
  -- initialize check options
  if (not QTR_PS["visible"] ) then
     QTR_PS["visible"] = "on";   
  end
  if (not QTR_PS["size"] ) then
     QTR_PS["size"] = "1";   
  end
  if (not QTR_PS["width"] ) then
     QTR_PS["width"] = "1";   
  end

  -- set check buttons 
  if (QTR_PS["visible"] == "on") then
     QuestTranslator_Show = true;
  else 
     QuestTranslator_Show = false;     
  end
  if (QTR_PS["size"] == "1") then
     QuestTranslator_SizeH = 1;
  else 
     QuestTranslator_SizeH = 2;     
     QuestTranslatorFrame1:SetHeight(525);
     QuestTranslator_QuestDetail:SetHeight(430);
     QTR_ToggleButton2:SetText("^");
  end
  if (QTR_PS["width"] == "1") then
     QuestTranslator_SizeW = 1;
  else 
     QuestTranslator_SizeW = 2;     
     QuestTranslatorFrame1:SetWidth(525);
     QuestTranslator_QuestDetail:SetWidth(495);
     QuestTranslator_QuestTitle:SetWidth(495);
     QTR_ToggleButton3:SetText("<");
  end
  if ( QTR_PS["isGetQuestID"] ) then
     isGetQuestID=QTR_PS["isGetQuestID"];
  end;
end


function QuestTranslator_ChangeFrameHeight()
  -- normal height of Frame = 425, quest detail = 350
  if (QuestTranslator_SizeH == 1) then
     QuestTranslatorFrame1:SetHeight(525);
     QuestTranslator_QuestDetail:SetHeight(430);
     QTR_ToggleButton2:SetText("^");
     QuestTranslator_SizeH = 2;
     QTR_PS["size"] = "2";
  else
     QuestTranslatorFrame1:SetHeight(425);
     QuestTranslator_QuestDetail:SetHeight(350);
     QTR_ToggleButton2:SetText("v");
     QuestTranslator_SizeH = 1;
     QTR_PS["size"] = "1";
  end
end


function QuestTranslator_ChangeFrameWidth()
  -- normal width of Frame = 350, quest detail = 320
  if (QuestTranslator_SizeW == 1) then
     QuestTranslatorFrame1:SetWidth(525);
     QuestTranslator_QuestDetail:SetWidth(495);
     QuestTranslator_QuestTitle:SetWidth(495);
     QTR_ToggleButton3:SetText("<");
     QuestTranslator_SizeW = 2;
     QTR_PS["width"] = "2";
  else
     QuestTranslatorFrame1:SetWidth(350);
     QuestTranslator_QuestDetail:SetWidth(320);
     QuestTranslator_QuestTitle:SetWidth(320);
     QTR_ToggleButton3:SetText(">");
     QuestTranslator_SizeW = 1;
     QTR_PS["width"] = "1";
  end
end


function QuestTranslator_OnMouseDown1()
  -- start moving the window
  QuestTranslatorFrame1:StartMoving();
end
  

function QuestTranslator_OnMouseUp1()
  -- stop moving the window
  QuestTranslatorFrame1:StopMovingOrSizing();
end


function QuestTranslator_OnMouseDown2()
  -- start moving the window
  QuestTranslatorFrame2:StartMoving();
end
  

function QuestTranslator_OnMouseUp2()
  -- stop moving the window
  QuestTranslatorFrame2:StopMovingOrSizing();
end


function QuestTranslator_ToggleVisibility()
  -- click on QTR button in QuestLogFrame
  if (QuestTranslatorFrame1:IsVisible()) then
     QTR_PS["visible"] = "off";   
     QuestTranslator_Show = false;
     QuestTranslator_HideQuestInfo();
     local QTR_message = "|cffffff00QuestTranslator is disabled";
     if (DEFAULT_CHAT_FRAME) then
         DEFAULT_CHAT_FRAME:AddMessage(QTR_message);
     else
         UIErrorsFrame:AddMessage(QTR_message, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
     end
  else
     QTR_PS["visible"] = "on";   
     QuestTranslator_Show = true;
     QuestTranslator_ShowAndUpdateQuestInfo();
     local QTR_message = "|cffffff00QuestTranslator is enabled";
     if (DEFAULT_CHAT_FRAME) then
         DEFAULT_CHAT_FRAME:AddMessage(QTR_message);
     else
         UIErrorsFrame:AddMessage(QTR_message, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
     end
  end
end


function QuestTranslator_ShowAndUpdateQuestInfo()
  if (not QuestTranslator_Show) then
     return;
  end
  QuestTranslatorFrame1:Show();
  QuestTranslator_UpdateQuestInfo();
end


function QuestTranslator_HideQuestInfo()
  QuestTranslatorFrame1:Hide();
end


function QuestTranslator_UpdateQuestInfo()
  local questSelected = GetQuestLogSelection();
  if (GetQuestLogTitle(questSelected) == nil) then
     return;
  end

  local questTitle, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID = GetQuestLogTitle(questSelected);
  if (isHeader) then
     return;
  end

  local qid = tostring(questID);
  QuestTranslator_QuestID:SetText("QuestID: " .. qid);

  if (QuestTranslator_QuestData[qid]) then
     QTR_objectives  = QuestTranslator_ExpandUnitInfo(QuestTranslator_QuestData[qid]["Objectives"]);
     QTR_description = QuestTranslator_ExpandUnitInfo(QuestTranslator_QuestData[qid]["Description"]);
     QTR_description = QuestTranslator_Messages.details .. "\n" .. QTR_description;
     QTR_translator = "";
     if (QuestTranslator_QuestData[qid]["Translator"]) then
        if (QuestTranslator_QuestData[qid]["Translator"]>"") then
            QTR_translator = "\n\n" .. QuestTranslator_Messages.translator .. " " .. QuestTranslator_ExpandUnitInfo(QuestTranslator_QuestData[qid]["Translator"]);
        end
     end
     QuestTranslator_QuestTitle:SetText(QuestTranslator_ExpandUnitInfo(QuestTranslator_QuestData[qid]["Title"]));
     QuestTranslator_QuestDetail:SetText(QTR_objectives .. "\n\n" .. QTR_description .. QTR_translator);
  else
     QuestTranslator_QuestTitle:SetText(questTitle);
     QuestTranslator_QuestDetail:SetText(QuestTranslator_Messages.missing);
  end
end


function QuestTranslator_ExpandUnitInfo(msg)
  -- replace special characters into message
  msg = string.gsub(msg, "NEW_LINE", "\n");
  msg = string.gsub(msg, "YOUR_NAME", QTR_name);
  msg = string.gsub(msg, "YOUR_CLASS", QTR_class);
  msg = string.gsub(msg, "YOUR_RACE", QTR_race);
  return msg;
end

