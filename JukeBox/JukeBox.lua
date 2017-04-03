function JukeBoxEvent(arg1)
	if(event == "ADDON_LOADED") then
		if(alreadyLoaded == nil)then
			if(DebugMessages == 1)then
				DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] Event trigger: ADDON_LOADED");
			end
			alreadyLoaded = true;
			local Page1 = getglobal("JukeBoxForm".."Page1");
			Page1:ClearAllPoints();
			Page1:SetPoint("TOPLEFT", "JukeBoxForm", 18, -50);
			Page1:Show();
			
			local Page2 = getglobal("JukeBoxForm".."Page2");
			Page2:ClearAllPoints();
			Page2:SetPoint("TOPLEFT", "JukeBoxForm", 18, -50);
			Page2:Hide();
        
			local Page3 = getglobal("JukeBoxForm".."Page3");
			Page3:ClearAllPoints();
			Page3:SetPoint("TOPLEFT", "JukeBoxForm", 18, -50);
			Page3:Hide();
        
			local Page4 = getglobal("JukeBoxForm".."Page4");
			Page4:ClearAllPoints();
			Page4:SetPoint("TOPLEFT", "JukeBoxForm", 18, -50);
			Page4:Hide();
			
			JukeBox_CurrentPage = 1;
			PageBtn1:Disable();

			local labelName,labelLength,labelNowPlayingName,labelNowPlayingTime,barThing;
			labelName = getglobal("JukeBoxForm".."Page1".."PanelPlay".."TextName".."Label");
			labelName:SetText("(None Selected)");
			labelLength = getglobal("JukeBoxForm".."Page1".."PanelPlay".."TextLength".."Label");
			labelLength:SetText("0:00");
			labelNowPlayingName = getglobal("JukeBoxForm".."PanelNowPlaying".."NowPlayingName".."Label");
			labelNowPlayingName:SetText("(None)");
			labelNowPlayingTime = getglobal("JukeBoxForm".."PanelNowPlaying".."NowPlayingTime".."Label");
			labelNowPlayingTime:SetText("0:00/0:00");
			barThing = getglobal("JukeBoxForm".."PanelNowPlaying".."TrackingBar");
			barThing:SetValue(0);
			JukeBox_SelectedName = "Nothing Selected Error";
			JukeBox_SelectedFile = "Sound\\Character\\BloodElf\\BloodElfMale_Err_GenericNoTarget03.wav";
			JukeBox_SelectedLength = "7";
			JukeBox_SelectedPlayListData = "";
			JukeBox_PlayingName = "";
			JukeBox_PlayingFile = "";
			JukeBox_PlayingLength = "";
			JukeBox_PlayListMaxTracks = 0;
			JukeBox_SelectedPlayListMaxTracks = 0;
			JukeBox_QuePlayListMaxTracks = 0;
			JukeBox_QueName = "";
			JukeBox_QueFile = "";
			JukeBox_QueLength = "";
			JukeBox_QueActive = false;
			JukeBox_QueIsPL = false;
			JukeBox_QuePLData = "";
			JukeBox_elapsedtime = "0";
			JukeBox_nothingselected = true;
			JukeBox_musicisplaying = false;
			JukeBox_waitformusicdone = true;
			JukeBox_loopmusic = false;
			JukeBox_visible = false;
			JukeBox_PlayListIsSelected = false;
			JukeBox_PlayListIsPlaying = false;
			JukeBox_PlayListID = 0;
			JukeBox_PlayListData = "";
			JukeBox_PlayListCurTrack = 0;
			SlashCmdList["JUKEBOX"] = function(msg)
				JukeBox_SlashCmdHandler(msg);
			end
			--SlashCmdList["JUKEBOX"] = JukeBox_SlashCmdHandler;
			SLASH_JUKEBOX1 = "/jukebox";
			SLASH_JUKEBOX2 = "/jb";
			Selected_Game = 0;
			Selected_Zone = 0;
			windowA = false;
			local PlayButton = getglobal("JukeBoxForm".."Page1".."PanelPlay".."PlayButton");
			PlayButton:Disable();
			local StopButton = getglobal("JukeBoxForm".."PanelNowPlaying".."StopButton");
			StopButton:Disable();
			BtnPLChooseTrack:Disable();
			ADD_TO_PLAYLISTMODE = false;
			PL_Editing = false;
			PL_makingnew = false;
			Custom_DontCheck = false;
			ResetPLEdit();
        
			txtPLNameEdit:SetAutoFocus(false);
			txtCustomName:SetAutoFocus(false);
			txtCustomLength:SetAutoFocus(false);
			txtCustomFile:SetAutoFocus(false);
        
			CustomIsSelected=false;
			CustomSelectedID = 0;
        
			Custom_Edit_ListID = 0;

			if(PL_TotalIDs==nil)then
				PL_TotalIDs = 0;
			end
			if(Custom_TotalIDs==nil)then
				Custom_TotalIDs = 0;
			end
			if(PlayListsTable==nil)then
				PlayListsTable = { };
			end
			if(CustomTable==nil)then
				CustomTable = { };
			end
        
			--if(AutoPlayTable==nil)then
			--	AutoPlayTable = { };
			--	FormatAPTable()
			--else
			--	FormatAPTable()
				if(AutoPlayTable[1]~=nil)then
					if(tonumber(AutoPlayTable[1])~=0)then
						local useSwitch1, useType1, useName1, useLength1, useFile1, useAutoLoop = strsplit("\a", AutoPlayTable[1]);
						AP_Edit_MountName = useName1;
						AP_Edit_MountLength = useLength1;
						AP_Edit_MountFile = useFile1;
						AP_Edit_MountType = useType1;
						AP_Edit_MountAutoLoop = useAutoLoop;
					else
						AP_Edit_MountName = "(None)";
						AP_Edit_MountLength = 0;
						AP_Edit_MountFile = 0;
						AP_Edit_MountType = 0;
						AP_Edit_MountAutoLoop = 0;
					end
					if(DebugMessages == 1)then
						DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] AutoPlay table loading... APTABLEKey1 Loaded");
					end
				else
					if(DebugMessages == 1)then
						DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] AutoPlay table loading... APTABLEKey1 =CREATED=");
					end
					AutoPlayTable[1] = 0;
					AP_Edit_MountName = "(None)";
					AP_Edit_MountLength = 0;
					AP_Edit_MountFile = 0;
					AP_Edit_MountType = 0;
					AP_Edit_MountAutoLoop = 0;
				end
				if(AutoPlayTable[2]~=nil)then
					if(tonumber(AutoPlayTable[2])~=0)then
						local useSwitch2, useType2, useName2, useLength2, useFile2, useAutoLoop = strsplit("\a", AutoPlayTable[2]);
						AP_Edit_CombatName = useName2;
						AP_Edit_CombatLength = useLength2;
						AP_Edit_CombatFile = useFile2;
						AP_Edit_CombatType = useType2;
						AP_Edit_CombatAutoLoop = useAutoLoop;
					else
						AP_Edit_CombatName = "(None)";
						AP_Edit_CombatLength = 0;
						AP_Edit_CombatFile = 0;
						AP_Edit_CombatType = 0;
						AP_Edit_CombatAutoLoop = 0;
					end
					if(DebugMessages == 1)then
						DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] AutoPlay table loading... APTABLEKey2 Loaded");
					end
				else
					if(DebugMessages == 1)then
						DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] AutoPlay table loading... APTABLEKey2 =CREATED=");
					end
					AutoPlayTable[2] = 0;
					AP_Edit_CombatName = "(None)";
					AP_Edit_CombatLength = 0;
					AP_Edit_CombatFile = 0;
					AP_Edit_CombatType = 0;
					AP_Edit_CombatAutoLoop = 0;
				end
				if(AutoPlayTable[3]~=nil)then
					if(tonumber(AutoPlayTable[3])~=0)then
						local useSwitch2, useType2, useName2, useLength2, useFile2, useAutoLoop = strsplit("\a", AutoPlayTable[3]);
						AP_Edit_AreaName = useName2;
						AP_Edit_AreaLength = useLength2;
						AP_Edit_AreaFile = useFile2;
						AP_Edit_AreaType = useType2;
						AP_Edit_AreaAutoLoop = useAutoLoop;
					else
						AP_Edit_AreaName = "(None)";
						AP_Edit_AreaLength = 0;
						AP_Edit_AreaFile = 0;
						AP_Edit_AreaType = 0;
						AP_Edit_AreaAutoLoop = 0;
					end
					if(DebugMessages == 1)then
						DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] AutoPlay table loading... APTABLEKey3 Loaded");
					end
				else
					if(DebugMessages == 1)then
						DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] AutoPlay table loading... APTABLEKey3 =CREATED=");
					end
					AutoPlayTable[3] = 0;
					AP_Edit_AreaName = "(None)";
					AP_Edit_AreaLength = 0;
					AP_Edit_AreaFile = 0;
					AP_Edit_AreaType = 0;
					AP_Edit_AreaAutoLoop = 0;
				end
			--end
			
			
			currentVersion = "1.2.1";
			if(versionID==nil)then
				versionID = currentVersion;
			elseif(versionID ~= currentVersion)then
				if(versionID == "1.0")then
				
				elseif(versionID == "1.1")then
				
				elseif(versionID == "1.2")then
				
				elseif(versionID == "1.2.1")then
				
				else
					
				end
				versionID = currentVersion;
			end
			
			local TitleString = getglobal("LabelTitle".."Label");
			TitleString:SetText("JukeBox Version "..versionID);--..GetTitleName(GetCurrentTitle()));
			
			
			ap_DontCheck = false;
			APMountCheck:Disable()
			APAreaCheck:Disable()
			APCombatCheck:Disable()
			
			APMountAutoLoopCheck:Disable()
			APAreaAutoLoopCheck:Disable()
			APCombatAutoLoopCheck:Disable()
        
			APMountAutoLoopText:Hide()
			APAreaAutoLoopText:Hide()
			APCombatAutoLoopText:Hide()
			
        
			mountCheck = 0;
			combatCheck = 0;
			areaCheck = 0;
			deadCheck = 0;
			
			
			mountOutsideStopCheck = 0;
			combatOutsideStopCheck = 0;
			areaOutsideStopCheck = 0;
        
			PL_Edit_Type1 = 0;
			PL_Edit_ID1 = 0;
			PL_Edit_Type2 = 0;
			PL_Edit_ID2 = 0;
			PL_Edit_Type3 = 0;
			PL_Edit_ID3 = 0;
			PL_Edit_Type4 = 0;
			PL_Edit_ID4 = 0;
			PL_Edit_Type5 = 0;
			PL_Edit_ID5 = 0;
		
			checkFirst = "mount";
			checkSecond = "combat";
			
			lolCheck = 27;
			
			if(DebugMessages == nil)then
				DebugMessages = 0;
			end
			
			previousLoopState = false;
			alreadyAutoLooping = false;
		end 
	end
end

function FormatAPTable(arg)
    local curpos = 0;
    local lastpos = 2;
    while(curpos < lastpos)do
		curpos = curpos + 1;
		AutoPlayTable[curpos] = 0;
    end
			AP_Edit_MountName = "(None)"
			AP_Edit_AreaName = "(None)"
			AP_Edit_CombatName = "(None)"
			AP_Edit_MountLength = 0;
			AP_Edit_AreaLength = 0;
			AP_Edit_CombatLength = 0;
			AP_Edit_MountFile = 0;
			AP_Edit_AreaFile = 0;
			AP_Edit_CombatFile = 0;
        
			AP_Edit_MountType = 0;
			AP_Edit_AreaType = 0;
			AP_Edit_CombatType = 0;

			AP_Edit_MountPLData  = 0;
			AP_Edit_AreaPLData = 0;
			AP_Edit_CombatPLData = 0;
end


function APSave(arg1, arg2)
	if(arg2 == nil)then
			arg2=0;
	end
	if(DebugMessages == 1)then
		DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] APSave "..arg1.." "..arg2);
	end
	if(arg1 == "mount")then
		AutoPlayTable[1] = strjoin("\a", arg2, AP_Edit_MountType, AP_Edit_MountName, AP_Edit_MountLength, AP_Edit_MountFile, AP_Edit_MountAutoLoop)
	elseif(arg1 == "combat")then
		AutoPlayTable[2] = strjoin("\a", arg2, AP_Edit_CombatType, AP_Edit_CombatName, AP_Edit_CombatLength, AP_Edit_CombatFile, AP_Edit_CombatAutoLoop)
	elseif(arg1 == "area")then
		AutoPlayTable[3] = strjoin("\a", arg2, AP_Edit_AreaType, AP_Edit_AreaName, AP_Edit_AreaLength, AP_Edit_AreaFile, AP_Edit_CombatAutoLoop)
	end
end

function APSaveAutoLoop(arg1, arg2)
	if(arg2 == nil)then
			arg2=0;
	end
	if(DebugMessages == 1)then
		DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] APSaveAL "..arg1.." "..arg2);
	end
	if(arg1 == "mount")then
		local useSwitch = strsplit("\a", AutoPlayTable[1]);
		AutoPlayTable[1] = strjoin("\a", useSwitch, AP_Edit_MountType, AP_Edit_MountName, AP_Edit_MountLength, AP_Edit_MountFile, arg2)
	elseif(arg1 == "combat")then
		local useSwitch = strsplit("\a", AutoPlayTable[2]);
		AutoPlayTable[2] = strjoin("\a", useSwitch, AP_Edit_CombatType, AP_Edit_CombatName, AP_Edit_CombatLength, AP_Edit_CombatFile, arg2)
	elseif(arg1 == "area")then
		local useSwitch = strsplit("\a", AutoPlayTable[3]);
		AutoPlayTable[3] = strjoin("\a", useSwitch, AP_Edit_AreaType, AP_Edit_AreaName, AP_Edit_AreaLength, AP_Edit_AreaFile, arg2)
	end
end

function APAddNewTrack()
    if(JukeBox_PlayListIsSelected == true)then
        JukeBox_SelectedType = 1;
    elseif(CustomIsSelected == true)then
        JukeBox_SelectedType = 2;
    else
        JukeBox_SelectedType = 0;
    end
    if(APChangeWhich == "mount")then
        APMountCheck:Enable()
		APMountAutoLoopCheck:Enable()
		APMountAutoLoopText:Show()
        AP_Edit_MountName = JukeBox_SelectedName;
        AP_Edit_MountLength = JukeBox_SelectedLength;
        AP_Edit_MountFile = JukeBox_SelectedFile;
        AP_Edit_MountType = JukeBox_SelectedType;
		local loopCheck = APMountAutoLoopCheck:GetChecked();
		if(loopCheck == nil)then
			loopCheck = 0;
		end
		AP_Edit_MountAutoLoop = loopCheck;
        --AP_Edit_MountPLData = JukeBox_SelectedPlayListData;
        local NameText = getglobal("APMountLabel".."Label");
        NameText:SetText(AP_Edit_MountName.." ("..TimeString(AnalyzeLength(AP_Edit_MountLength, AP_Edit_MountFile))..")")
		APSave("mount",APMountCheck:GetChecked());
    elseif(APChangeWhich == "combat")then
		APCombatCheck:Enable()
		APCombatAutoLoopCheck:Enable()
		APCombatAutoLoopText:Show()
        AP_Edit_CombatName = JukeBox_SelectedName;
        AP_Edit_CombatLength = JukeBox_SelectedLength;
        AP_Edit_CombatFile = JukeBox_SelectedFile;
        AP_Edit_CombatType = JukeBox_SelectedType;
		local loopCheck = APCombatAutoLoopCheck:GetChecked();
		if(loopCheck == nil)then
			loopCheck = 0;
		end
		AP_Edit_CombatAutoLoop = loopCheck;
        --AP_Edit_MountPLData = JukeBox_SelectedPlayListData;
        local NameText = getglobal("APCombatLabel".."Label");
        NameText:SetText(AP_Edit_CombatName.." ("..TimeString(AnalyzeLength(AP_Edit_CombatLength, AP_Edit_CombatFile))..")")
		APSave("combat",APCombatCheck:GetChecked());
    elseif(APChangeWhich == "area")then
		APAreaCheck:Enable()
		APAreaAutoLoopCheck:Enable()
		APAreaAutoLoopText:Show()
        AP_Edit_AreaName = JukeBox_SelectedName;
        AP_Edit_AreaLength = JukeBox_SelectedLength;
        AP_Edit_AreaFile = JukeBox_SelectedFile;
        AP_Edit_AreaType = JukeBox_SelectedType;
		local loopCheck = APAreaAutoLoopCheck:GetChecked();
		if(loopCheck == nil)then
			loopCheck = 0;
		end
		AP_Edit_AreaAutoLoop = loopCheck;
        --AP_Edit_MountPLData = JukeBox_SelectedPlayListData;
        local NameText = getglobal("APAreaLabel".."Label");
        NameText:SetText(AP_Edit_AreaName.." ("..TimeString(AnalyzeLength(AP_Edit_AreaLength, AP_Edit_AreaFile))..")")
		APSave("area",APAreaCheck:GetChecked());
    end
end

function MakeNewCustom()
    ResetCustomEdit()
    Custom_TotalIDs = #(CustomTable);
    Custom_Edit_ListID = Custom_TotalIDs + 1;
    btnSaveCustom:Disable();
    btnDeleteCustom:Disable();
    PanelCustomEdit:Show();
    CustomHelp("name")
    PanelCustomHelp:Show()
	
end

function CustomHelp(arg)
    local Title = getglobal("CustomHelpTitle".."Label");
    local Body = getglobal("CustomHelpBody".."Label");
    local Example = getglobal("CustomHelpExample".."Label");
    
    if(arg=="name")then
        Title:SetText("Track Name")
        Body:SetText("The name of your song. It can be anything you want.")
        Example:SetText("Example: My Song")
    elseif(arg=="file")then
        Title:SetText("File Name")
        Body:SetText("The filename of your song, relative to the CustomMusic\\ folder.\n\nNote that you will not be able to play songs you have just placed into the CustomMusic folder until you restart World of Warcraft.")
        Example:SetText("Example: music.mp3 or Band1\\song1.mp3")
    elseif(arg=="length")then
        Title:SetText("Song Length")
        Body:SetText("The duration of your song. Format is in minutes.\n\nDue to the way World of Warcraft handles music and to compensate for timer lag, you may need to put a lower length than the actual duration. Otherwise, the music may loop a few seconds before being stopped.")
        Example:SetText("Example: 3:20 or 0:45")
    end
end

function TimeTime(arg)
	local result = 0;
	local delPos = string.find(arg, ":")
	local preDel = tonumber(strsub(arg, 0, delPos-1))
	local postDel = tonumber(strsub(arg, delPos+1))
	
	result = (preDel*60)+postDel;
	return result;
end

function SaveCustom()
	txtCustomName:ClearFocus()
	txtCustomLength:ClearFocus()
	txtCustomFile:ClearFocus()
    btnSaveCustom:Disable();
    Custom_TotalIDs = #(CustomTable);
    btnDeleteCustom:Enable();
    local checkName = txtCustomName:GetText()
    local checkLength = TimeTime(txtCustomLength:GetText())
    local checkFile = txtCustomFile:GetText()
	if(strfind(checkFile, "/")~=nil)then
		checkFile = gsub(checkFile, "/", "\\")
	end
    local joinedString = strjoin("\a", Custom_Edit_ListID, checkName, checkLength, checkFile)
    local tempIDCheck = tonumber(Custom_TotalIDs);
    local tempIDCheckb = tonumber(Custom_Edit_ListID);
    if(tempIDCheck >= tempIDCheckb)then
        table.remove(CustomTable,Custom_Edit_ListID)
    end
    table.insert(CustomTable, Custom_Edit_ListID, joinedString)
end

function EditCustom(arg)
    Custom_TotalIDs = #(CustomTable);
    ResetCustomEdit()
    btnDeleteCustom:Enable();
    local plid, plname, pllength, plfile = strsplit("\a", arg);
    Custom_Edit_ListID = plid;
    txtCustomName:SetText(plname)
    txtCustomLength:SetText(TimeString(pllength))
    txtCustomFile:SetText(plfile)
    btnSaveCustom:Disable()
    PanelCustomEdit:Show()
    CustomHelp("name")
    PanelCustomHelp:Show()
end

function DeleteCustom()
local target = tonumber(Custom_Edit_ListID);
Custom_TotalIDs = #(CustomTable);
local total = tonumber(Custom_TotalIDs);
if(target == total)then
table.remove(CustomTable,target)
else
local curpos = target;
local nextpos = curpos + 1;
while(curpos < total)do
local plid, plname, pllength, plfile = strsplit("\a", CustomTable[nextpos]);
plid = curpos;
local joinedString = strjoin("\a", plid, plname, pllength, plfile);

CustomTable[curpos] = joinedString;
curpos = curpos + 1;
nextpos = curpos + 1;
end
table.remove(CustomTable,total)
end
--table.remove(PlayListsTable,PL_Edit_ListID)
Custom_TotalIDs = #(CustomTable);
ResetCustomEdit()
end

function ResetCustomEdit()
btnSaveCustom:Disable()
PanelCustomHelp:Hide()
PanelCustomEdit:Hide()
txtCustomName:SetText("")
txtCustomLength:SetText("")
txtCustomFile:SetText("")
end

function CheckValid()
        local checkName = txtCustomName:GetText()
        local checkLength = txtCustomLength:GetText()
        local checkFile = txtCustomFile:GetText()

        if(checkName == "")then
            btnSaveCustom:Disable();
        else
            if(checkFile == "")then
                btnSaveCustom:Disable();
            else
                if(checkLength == "")then
                    btnSaveCustom:Disable();
                else
					if(string.find(checkName, "\\".."a")~=nil)then
						btnSaveCustom:Disable();
					else
						if(string.find(checkName, "\a")~=nil)then
							btnSaveCustom:Disable();
						else
							local delPos = string.find(checkLength, ":")
							if(delPos==nil)then
								btnSaveCustom:Disable();
							else
								local preDel = strsub(checkLength, 0, delPos-1)
								if(preDel == "")then
									btnSaveCustom:Disable();
								else
									local postDel = strsub(checkLength, delPos+1)
									if(postDel == "")then
										btnSaveCustom:Disable();
									else
										if(strlen(postDel) ~= 2)then
											btnSaveCustom:Disable();
										else
											if(checkLength == "0:00")then
												btnSaveCustom:Disable();
											else
												if(string.find(postDel, ":")~=nil)then
													btnSaveCustom:Disable();
												else
													if(tonumber(preDel) == nil)then
														btnSaveCustom:Disable();
													else
														if(tonumber(postDel) == nil)then
															btnSaveCustom:Disable();
														else
															if(tonumber(preDel)+tonumber(postDel) == 0)then
																btnSaveCustom:Disable();
															else
																btnSaveCustom:Enable();
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
                end
            end
        end
   

end


function DDCustom_Initialise()
 level = level or 1 --drop down menus can have sub menus. The value of "level" determines the drop down sub menu tier.
 Custom_TotalIDs = #(CustomTable);
 local info = UIDropDownMenu_CreateInfo();
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 
    for index,value in ipairs(CustomTable) do 
        local id, name = strsplit("\a", value)

        info.text = name;
        info.value = id;
        info.func = function() EditCustom(value) end;
        UIDropDownMenu_AddButton(info, level);
    end
end



function CheckCustomLength(arg)
    local result = 0;
    if(CustomTable[tonumber(arg)]~=nil)then
        local id, name, length, file = strsplit("\a", CustomTable[tonumber(arg)])
        result = length;
    else
        --Delete Mr Custom from PL
    end
    return tonumber(result);
end

function CheckCustomFile(arg)
    local result = 0;
    if(CustomTable[tonumber(arg)]~=nil)then
        local id, name, length, file = strsplit("\a", CustomTable[tonumber(arg)])
        result = CPath(file);
    else
        result = arg;
    end
    return result;
end

function CheckCustomName(arg)
    local result = 0;
    if(CustomTable[tonumber(arg)]~=nil)then
        local id, name, length, file = strsplit("\a", CustomTable[tonumber(arg)])
        result = name;
    else
        result = 0;
    end
    return result;
end


function AnalyzeName(arg1, arg2, arg3)
    local result = 0;
    if(arg1=="c")then
            result = CheckCustomName(arg2)
    else
        result = arg3;
    end
    return result;
end

function AnalyzeLength(arg1, arg2)
    local result = 0;
    if(arg1=="c")then
            result = CheckCustomLength(arg2)
    else
        result = arg1;
    end
    return tonumber(result);
end

function AnalyzeFile(arg1, arg2)
    local result = 0;
    if(arg1=="c")then
        result = CheckCustomFile(arg2)
    else
        result = arg2;
    end
    return result;
end

function ChoosePlayList(arg)
    arg = tonumber(arg)
    if(PlayListsTable[arg]~=nil)then
        --local checkString = tonumber(arg)
        local checkData = PlayListsTable[arg];
        local plid, plname, plcount, plname1, pllength1, plfile1, plname2, pllength2, plfile2, plname3, pllength3, plfile3, plname4, pllength4, plfile4, plname5, pllength5, plfile5 = strsplit("\a", checkData);

        JukeBox_PlayListIsSelected = true;
        CustomIsSelected = false;
        local labelName,labelLength;
        if(EditMode=="PL")then
            BtnPLChooseTrack:Disable();
        else
            BtnPLChooseTrack:Enable();
        end
        JukeBox_nothingselected = false;
        JukeBox_SelectedName = plname;
        JukeBox_SelectedFile = tonumber(plid);
        JukeBox_SelectedPlayListData = checkData;
        JukeBox_SelectedPlayListMaxTracks = tonumber(plcount);
        -- local test = getglobal("LabelTitle".."Label");
        -- test:SetText("("..JukeBox_SelectedPlayListMaxTracks..") ("..JukeBox_PlayListMaxTracks..") ("..JukeBox_QuePlayListMaxTracks..")");
    
        --------------------------------
       
       local clength1 = pllength1;
       local clength2 = pllength2;
       local clength3 = pllength3;
       local clength4 = pllength4;
       local clength5 = pllength5;
       
       
       clength1 = AnalyzeLength(pllength1, plfile1);
       clength2 = AnalyzeLength(pllength2, plfile2);
       clength3 = AnalyzeLength(pllength3, plfile3);
       clength4 = AnalyzeLength(pllength4, plfile4);
       clength5 = AnalyzeLength(pllength5, plfile5);
       
       
       
       
       
       --------------------------------
        JukeBox_SelectedLength = clength1+clength2+clength3+clength4+clength5;
        labelName = getglobal("JukeBoxForm".."Page1".."PanelPlay".."TextName".."Label");
        labelName:SetText(JukeBox_SelectedName);
        labelLength = getglobal("JukeBoxForm".."Page1".."PanelPlay".."TextLength".."Label");
        labelLength:SetText(TimeString(JukeBox_SelectedLength));
		
		
		
        local PlayButton = getglobal("JukeBoxForm".."Page1".."PanelPlay".."PlayButton");
        PlayButton:Enable();
    else
	
    end
end

function ReadPlayListString(arg)
end

function OpenPlayListEdit(arg)
    local plid, plname, plcount, plname1, pllength1, plfile1, plname2, pllength2, plfile2, plname3, pllength3, plfile3, plname4, pllength4, plfile4, plname5, pllength5, plfile5 = strsplit("\a", arg);
    ResetPLEdit();
    --local test = getglobal("LabelTitle".."Label");
    plcount=tonumber(plcount);
    if(plcount==5)then
        PLAddTrack:Disable();
    else
        PLAddTrack:Enable();
    end


       local clength1 = pllength1;
       local clength2 = pllength2;
       local clength3 = pllength3;
       local clength4 = pllength4;
       local clength5 = pllength5;
       
       
       clength1 = AnalyzeLength(pllength1, plfile1);
       clength2 = AnalyzeLength(pllength2, plfile2);
       clength3 = AnalyzeLength(pllength3, plfile3);
       clength4 = AnalyzeLength(pllength4, plfile4);
       clength5 = AnalyzeLength(pllength5, plfile5);
       
       local cname1 = plname1;
       local cname2 = plname2;
       local cname3 = plname3;
       local cname4 = plname4;
       local cname5 = plname5;
       
       
       cname1 = AnalyzeName(pllength1, plfile1, plname1);
       cname2 = AnalyzeName(pllength2, plfile2, plname2);
       cname3 = AnalyzeName(pllength3, plfile3, plname3);
       cname4 = AnalyzeName(pllength4, plfile4, plname4);
       cname5 = AnalyzeName(pllength5, plfile5, plname5);






        PL_Editing = true;
        PL_Edit_ListID = plid;
        PL_Edit_ListName = plname;
        PL_Edit_TrackCount = tonumber(plcount);
        PL_Edit_Track1Name = cname1;
        PL_Edit_Track1Length = pllength1;
        PL_Edit_Track1File = plfile1;
        PL_Edit_Track2Name = cname2;
        PL_Edit_Track2Length = pllength2;
        PL_Edit_Track2File = plfile2;
        PL_Edit_Track3Name = cname3;
        PL_Edit_Track3Length = pllength3;
        PL_Edit_Track3File = plfile3;
        PL_Edit_Track4Name = cname4;
        PL_Edit_Track4Length = pllength4;
        PL_Edit_Track4File = plfile4;
        PL_Edit_Track5Name = cname5;
        PL_Edit_Track5Length = pllength5;
        PL_Edit_Track5File = plfile5;
        
        
        
        
        
       
        PL_Edit_TrackTime = clength1 + clength2 + clength3 + clength4 + clength5;
        
        txtPLNameEdit:SetText(plname);
        
        --local test = getglobal("debugPlaylistID".."Label");
        --test:SetText(PL_Edit_ListID);
        
        local Track1Name = getglobal("PLTrack1Name".."Label");
        Track1Name:SetText(cname1);
        local Track2Name = getglobal("PLTrack2Name".."Label");
        Track2Name:SetText(cname2);
        local Track3Name = getglobal("PLTrack3Name".."Label");
        Track3Name:SetText(cname3);
        local Track4Name = getglobal("PLTrack4Name".."Label");
        Track4Name:SetText(cname4);
        local Track5Name = getglobal("PLTrack5Name".."Label");
        Track5Name:SetText(cname5);
        
        local Track1Length = getglobal("PLTrack1Length".."Label");
        Track1Length:SetText(TimeString(clength1));
        local Track2Length = getglobal("PLTrack2Length".."Label");
        Track2Length:SetText(TimeString(clength2));
        local Track3Length = getglobal("PLTrack3Length".."Label");
        Track3Length:SetText(TimeString(clength3));
        local Track4Length = getglobal("PLTrack4Length".."Label");
        Track4Length:SetText(TimeString(clength4));
        local Track5Length = getglobal("PLTrack5Length".."Label");
        Track5Length:SetText(TimeString(clength5));
        
        
        if(PL_Edit_TrackCount >= 1)then
            PanelPLTrack1:Show();
        end
        if(PL_Edit_TrackCount >= 2)then
            PanelPLTrack2:Show();
        end
        if(PL_Edit_TrackCount >= 3)then
            PanelPLTrack3:Show();
        end
        if(PL_Edit_TrackCount >= 4)then
            PanelPLTrack4:Show();
        end
        if(PL_Edit_TrackCount >= 5)then
            PanelPLTrack5:Show();
        end
        local ResetTrackCount = getglobal("FramePLEdit".."TxtPLEditTrackCount".."Label");
        ResetTrackCount:SetText(plcount);
        local ResetTimeCount = getglobal("PLEditTime".."Label");
        ResetTimeCount:SetText(TimeString(PL_Edit_TrackTime));

		PurgeCustom(clength1, clength2, clength3, clength4, clength5)
		
        FramePLEdit:Show();
end

function DDPlayLists_Initialise()
 level = level or 1 --drop down menus can have sub menus. The value of "level" determines the drop down sub menu tier.
 PL_TotalIDs = #(PlayListsTable);
 local info = UIDropDownMenu_CreateInfo();
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 
    for index,value in ipairs(PlayListsTable) do 
        local id, name = strsplit("\a", value)

        info.text = name;
        info.value = id;
        info.func = function() OpenPlayListEdit(value) end;
        UIDropDownMenu_AddButton(info, level);
    end
end

function ResetPLEdit()
        local ResetTrackCount = getglobal("FramePLEdit".."TxtPLEditTrackCount".."Label");
        ResetTrackCount:SetText("0");
        local ResetTimeCount = getglobal("PLEditTime".."Label");
        ResetTimeCount:SetText("0:00");
        PanelPLTrack1:Hide();
        PanelPLTrack2:Hide();
        PanelPLTrack3:Hide();
        PanelPLTrack4:Hide();
        PanelPLTrack5:Hide();
        FramePLEdit:Hide();
        ADD_TO_PLAYLISTMODE = false;
        PL_makingnew = false;
        PL_Editing = false;
        PL_Edit_ListID = 0;
        PL_Edit_ListName = "0";
        PL_Edit_TrackCount = 0;
        PL_Edit_TrackTime = 0;
        PL_Edit_Track1Name = "0";
        PL_Edit_Track1Length = "0";
        PL_Edit_Track1File = "0";
        PL_Edit_Track2Name = "0";
        PL_Edit_Track2Length = "0";
        PL_Edit_Track2File = "0";
        PL_Edit_Track3Name = "0";
        PL_Edit_Track3Length = "0";
        PL_Edit_Track3File = "0";
        PL_Edit_Track4Name = "0";
        PL_Edit_Track4Length = "0";
        PL_Edit_Track4File = "0";
        PL_Edit_Track5Name = "0";
        PL_Edit_Track5Length = "0";
        PL_Edit_Track5File = "0";
        PL_Edit_Type1 = 0;
        PL_Edit_ID1 = 0;
        PL_Edit_Type2 = 0;
        PL_Edit_ID2 = 0;
        PL_Edit_Type3 = 0;
        PL_Edit_ID3 = 0;
        PL_Edit_Type4 = 0;
        PL_Edit_ID4 = 0;
        PL_Edit_Type5 = 0;
        PL_Edit_ID5 = 0;
        PLAddTrack:Enable();
end

function TimeString(input)
    local secondsStringT = mod(input, 60);
    if(secondsStringT < 10) then
        secondsStringT = "0"..secondsStringT;
    end
    local minuteStringT = floor(input / 60);
    local TimeStringT = minuteStringT..":"..secondsStringT;
    return TimeStringT;
end

function AddTrackCancelButton()
    if(EditMode=="PL")then
    AddToPlaylistMode(false, 2)
    elseif(EditMode=="AP")then
    AddToPlaylistMode(false, 3)
    end
end

function AddToPlaylistMode(arg1, arg2)
	local helpLabel = getglobal("JukeBoxForm".."Page1".."PanelSelect".."AddTrackHelp".."Label");
	local PlayButton = getglobal("JukeBoxForm".."Page1".."PanelPlay".."PlayButton");
	local queName = getglobal("JukeBoxForm".."Page1".."PanelPlay".."QueLabel".."Label");
       
	ADD_TO_PLAYLISTMODE = arg1;
	if(arg1 == true) then
    
		SwitchPage(1);
		if(arg2 == 3)then
			EditMode="AP";
		else
			EditMode="PL";
		end
		if(JukeBox_PlayListIsSelected==true)then
    
		--    if(EditMode=="AP")then
		--        BtnPLChooseTrack:Enable();
		--    else
			BtnPLChooseTrack:Disable();
		--    end
		end
   
		--PageBtn1:SetDisabledTexture("interface\\glues\\common\\glue-panel-button-up-blue");
		PageBtn1:Disable();
		PageBtn2:Disable();
		PageBtn3:Disable();
		PageBtn4:Disable();
		--BtnPLChooseTrack, PLEditAddThisNewTrack();
		--BtnPLAddTrackCancel, PLAddTrackCancel();
		--
		BtnPLChooseTrack:Show();
		BtnPLAddTrackCancel:Show();
		helpLabel:Show();
		PlayButton:Hide();
		PlayCheck:Hide();
		queName:Hide();
		if(EditMode=="AP")then
			BtnPLChooseTrack:Enable();
		end
	else
		PageBtn1:Enable();
		PageBtn2:Enable();
		PageBtn3:Enable();
		PageBtn4:Enable();
		SwitchPage(arg2);
		helpLabel:Hide();
		BtnPLChooseTrack:Hide();
		BtnPLAddTrackCancel:Hide();
		PlayButton:Show();
		PlayCheck:Show();
		queName:Show();
	end
end

function PLCancelChanges()
	PL_makingnew = false;
	ResetPLEdit();
	BtnSavePLChange:Enable();
	BtnDeletePL:Enable();
end

function CreateNewPlayList()
	ResetPLEdit()
	PL_TotalIDs = #(PlayListsTable);
	PL_Edit_ListID = PL_TotalIDs + 1;



	--PL_Edit_ListID = PL_NewIDIndex + 1;

	--local test = getglobal("debugPlaylistID".."Label");
	--test:SetText(PL_Edit_ListID);
	PL_Editing = true;
	BtnSavePLChange:Disable();
	BtnDeletePL:Disable();
	PL_Edit_ListName = "New Playlist";
	txtPLNameEdit:SetText(PL_Edit_ListName);
	PL_Edit_TrackCount = 0;
	PL_Edit_TrackTime = 0;
	FramePLEdit:Show();
end

function PLDelete()
	local target = tonumber(PL_Edit_ListID);
	PL_TotalIDs = #(PlayListsTable);
	local total = tonumber(PL_TotalIDs);
	if(target == total)then
		table.remove(PlayListsTable,target)
	else
		local curpos = target;
		local nextpos = curpos + 1;
		while(curpos < total)do
			local plid, plname, plcount, plname1, pllength1, plfile1, plname2, pllength2, plfile2, plname3, pllength3, plfile3, plname4, pllength4, plfile4, plname5, pllength5, plfile5 = strsplit("\a", PlayListsTable[nextpos]);
			plid = curpos;
			local joinedString = strjoin("\a", plid, plname, plcount, plname1, pllength1, plfile1, plname2, pllength2, plfile2, plname3, pllength3, plfile3, plname4, pllength4, plfile4, plname5, pllength5, plfile5);

			PlayListsTable[curpos] = joinedString;
			curpos = curpos + 1;
			nextpos = curpos + 1;
		end
		table.remove(PlayListsTable,total)
	end
--table.remove(PlayListsTable,PL_Edit_ListID)
	PL_TotalIDs = #(PlayListsTable);
	ResetPLEdit()
end

function PLSaveChanges()
	PL_makingnew = false;
	PL_TotalIDs = #(PlayListsTable);
	BtnDeletePL:Enable();
	--local test = getglobal("LabelTitle".."Label");
	PL_Edit_ListName = txtPLNameEdit:GetText();
    if(PL_Edit_TrackCount < 5)then
        PL_Edit_Track5Name = 0;
        PL_Edit_Track5Length = 0;
        PL_Edit_Track5File = 0;
    end
    if(PL_Edit_TrackCount < 4)then
        PL_Edit_Track4Name = 0;
        PL_Edit_Track4Length = 0;
        PL_Edit_Track4File = 0;
    end
    if(PL_Edit_TrackCount < 3)then
        PL_Edit_Track3Name = 0;
        PL_Edit_Track3Length = 0;
        PL_Edit_Track3File = 0;
    end
    if(PL_Edit_TrackCount < 2)then
        PL_Edit_Track2Name = 0;
        PL_Edit_Track2Length = 0;
        PL_Edit_Track2File = 0;
    end
  --  test:SetText(PL_Edit_Track1Length..PL_Edit_Track2Length..PL_Edit_Track3Length..PL_Edit_Track4Length..PL_Edit_Track5Length);
  
  local useName1 = PL_Edit_Track1Name;
  local useName2 = PL_Edit_Track2Name;
  local useName3 = PL_Edit_Track3Name;
  local useName4 = PL_Edit_Track4Name;
  local useName5 = PL_Edit_Track5Name;
  
  local useLength1 = PL_Edit_Track1Length;
  local useLength2 = PL_Edit_Track2Length;
  local useLength3 = PL_Edit_Track3Length;
  local useLength4 = PL_Edit_Track4Length;
  local useLength5 = PL_Edit_Track5Length;
  
  local useFile1 = PL_Edit_Track1File;
  local useFile2 = PL_Edit_Track2File;
  local useFile3 = PL_Edit_Track3File;
  local useFile4 = PL_Edit_Track4File;
  local useFile5 = PL_Edit_Track5File;
  
  if(PL_Edit_Type1 == 2)then
    useLength1 = "c";
    useFile1 = PL_Edit_ID1;
  end
  if(PL_Edit_Type2 == 2)then
    useLength2 = "c";
    useFile2 = PL_Edit_ID2;
  end
  if(PL_Edit_Type3 == 2)then
    useLength3 = "c";
    useFile3 = PL_Edit_ID3;
  end
  if(PL_Edit_Type4 == 2)then
    useLength4 = "c";
    useFile4 = PL_Edit_ID4;
  end
  if(PL_Edit_Type5 == 2)then
    useLength5 = "c";
    useFile5 = PL_Edit_ID5;
  end
  local joinedString = strjoin("\a", PL_Edit_ListID, PL_Edit_ListName, PL_Edit_TrackCount, useName1, useLength1, useFile1, useName2, useLength2, useFile2, useName3, useLength3, useFile3, useName4, useLength4, useFile4, useName5, useLength5, useFile5);

--local joinedString = strjoin("\a", PL_Edit_ListID, PL_Edit_ListName, PL_Edit_TrackCount, PL_Edit_Track1Name, PL_Edit_Track1Length, PL_Edit_Track1File, PL_Edit_Track2Name, PL_Edit_Track2Length, PL_Edit_Track2File, PL_Edit_Track3Name, PL_Edit_Track3Length, PL_Edit_Track3File, PL_Edit_Track4Name, PL_Edit_Track4Length, PL_Edit_Track4File, PL_Edit_Track5Name, PL_Edit_Track5Length, PL_Edit_Track5File);

--table.remove(PlayListsTable,PL_Edit_ListID)
local tempIDCheck = tonumber(PL_TotalIDs);
local tempIDCheckb = tonumber(PL_Edit_ListID);
if(tempIDCheck >= tempIDCheckb)then
table.remove(PlayListsTable,PL_Edit_ListID)
end
table.insert(PlayListsTable, PL_Edit_ListID, joinedString)
end


function PLAddNewTrackBtn()
    AddToPlaylistMode(true, 2);
    EditMode = "PL";
end

function APAddNewTrackBtn(arg1)
    AddToPlaylistMode(true, 2);
    EditMode = "AP";
    APChangeWhich = arg1;
end

function PLEditAddThisNewTrack()
    if(EditMode == "PL")then
        PLAddNewTrack();
        AddToPlaylistMode(false, 2);
        BtnSavePLChange:Enable();
    elseif(EditMode == "AP")then
        AddToPlaylistMode(false, 3);
        APAddNewTrack()
    end
end

function PLAddNewTrack()
    PL_Edit_TrackCount = tonumber(PL_Edit_TrackCount) + 1;
    

    if(PL_Edit_TrackCount == 1)then
		if(CustomIsSelected==true)then
            PL_Edit_Track1Length="c";
        end
        local TrackName = getglobal("PLTrack1Name".."Label");
        TrackName:SetText(JukeBox_SelectedName);
        local trackLength = getglobal("PLTrack1Length".."Label");
        trackLength:SetText(TimeString(AnalyzeLength(JukeBox_SelectedLength,JukeBox_SelectedFile)));
        
        PL_Edit_Track1Name = JukeBox_SelectedName;
        PL_Edit_Track1Length = JukeBox_SelectedLength;
        PL_Edit_Track1File = JukeBox_SelectedFile;
        
        
        --JukeBox_SelectedFile JukeBox_SelectedLength
        PanelPLTrack1:Show();
        
    elseif(PL_Edit_TrackCount == 2)then
		if(CustomIsSelected==true)then
            PL_Edit_Track2Length="c";
        end
        local TrackName = getglobal("PLTrack2Name".."Label");
        TrackName:SetText(JukeBox_SelectedName);
        local trackLength = getglobal("PLTrack2Length".."Label");
        trackLength:SetText(TimeString(AnalyzeLength(JukeBox_SelectedLength, JukeBox_SelectedFile)));
        
        PL_Edit_Track2Name = JukeBox_SelectedName;
        PL_Edit_Track2Length = JukeBox_SelectedLength;
        PL_Edit_Track2File = JukeBox_SelectedFile;
        
        
        PanelPLTrack2:Show();
      elseif(PL_Edit_TrackCount == 3)then
		if(CustomIsSelected==true)then
            PL_Edit_Track3Length="c";
        end
        local TrackName = getglobal("PLTrack3Name".."Label");
        TrackName:SetText(JukeBox_SelectedName);
        local trackLength = getglobal("PLTrack3Length".."Label");
        trackLength:SetText(TimeString(AnalyzeLength(JukeBox_SelectedLength, JukeBox_SelectedFile)));
        
        PL_Edit_Track3Name = JukeBox_SelectedName;
        PL_Edit_Track3Length = JukeBox_SelectedLength;
        PL_Edit_Track3File = JukeBox_SelectedFile;
        
        
        PanelPLTrack3:Show();
     elseif(PL_Edit_TrackCount == 4)then
		if(CustomIsSelected==true)then
            PL_Edit_Track4Length="c";
        end
        local TrackName = getglobal("PLTrack4Name".."Label");
        TrackName:SetText(JukeBox_SelectedName);
        local trackLength = getglobal("PLTrack4Length".."Label");
        trackLength:SetText(TimeString(AnalyzeLength(JukeBox_SelectedLength, JukeBox_SelectedFile)));
        
        PL_Edit_Track4Name = JukeBox_SelectedName;
        PL_Edit_Track4Length = JukeBox_SelectedLength;
        PL_Edit_Track4File = JukeBox_SelectedFile;
        
        
        
        PanelPLTrack4:Show();
    elseif(PL_Edit_TrackCount == 5)then
		if(CustomIsSelected==true)then
            PL_Edit_Track5Length="c";
        end
        local TrackName = getglobal("PLTrack5Name".."Label");
        TrackName:SetText(JukeBox_SelectedName);
        local trackLength = getglobal("PLTrack5Length".."Label");
        trackLength:SetText(TimeString(AnalyzeLength(JukeBox_SelectedLength, JukeBox_SelectedFile)));
        
        PL_Edit_Track5Name = JukeBox_SelectedName;
        PL_Edit_Track5Length = JukeBox_SelectedLength;
        PL_Edit_Track5File = JukeBox_SelectedFile;
        
        
        
        PanelPLTrack5:Show();
        PLAddTrack:Disable();
    end
	PL_Edit_TrackTime = PL_Edit_TrackTime + AnalyzeLength(JukeBox_SelectedLength, JukeBox_SelectedFile);
    local trackCountLabel = getglobal("FramePLEdit".."TxtPLEditTrackCount".."Label");
    trackCountLabel:SetText(PL_Edit_TrackCount);
    local trackTimeLabel = getglobal("PLEditTime".."Label");
    trackTimeLabel:SetText(TimeString(PL_Edit_TrackTime));
end

function PLTrackMoveAct(arg1, arg2)
    if(arg1 == 1)then
        if(arg2== 2)then
        local Track1Name = getglobal("PLTrack1Name".."Label");
        local Track1Length = getglobal("PLTrack1Length".."Label");
        local Track2Name = getglobal("PLTrack2Name".."Label");
        local Track2Length = getglobal("PLTrack2Length".."Label");
            
        local TempName = PL_Edit_Track1Name;   
        local TempLength = PL_Edit_Track1Length;
        local TempFile = PL_Edit_Track1File;
        PL_Edit_Track1Name = PL_Edit_Track2Name;
        PL_Edit_Track1Length = PL_Edit_Track2Length;
        PL_Edit_Track1File = PL_Edit_Track2File;
        PL_Edit_Track2Name = TempName;
        PL_Edit_Track2Length = TempLength;
        PL_Edit_Track2File = TempFile;
                                                                   
        Track1Name:SetText(PL_Edit_Track1Name);
        Track1Length:SetText(TimeString(AnalyzeLength(PL_Edit_Track1Length, PL_Edit_Track1File)));
        Track2Name:SetText(PL_Edit_Track2Name);
        Track2Length:SetText(TimeString(AnalyzeLength(PL_Edit_Track2Length, PL_Edit_Track2File)));
        end
        if(arg2==3)then
        local Track1Name = getglobal("PLTrack1Name".."Label");
        local Track1Length = getglobal("PLTrack1Length".."Label");
        local Track3Name = getglobal("PLTrack3Name".."Label");
        local Track3Length = getglobal("PLTrack3Length".."Label");
            
        local TempName = PL_Edit_Track1Name;   
        local TempLength = PL_Edit_Track1Length;
        local TempFile = PL_Edit_Track1File;
        PL_Edit_Track1Name = PL_Edit_Track3Name;
        PL_Edit_Track1Length = PL_Edit_Track3Length;
        PL_Edit_Track1File = PL_Edit_Track3File;
        PL_Edit_Track3Name = TempName;
        PL_Edit_Track3Length = TempLength;
        PL_Edit_Track3File = TempFile;
                                                                   
        Track1Name:SetText(PL_Edit_Track1Name);
        Track1Length:SetText(TimeString(AnalyzeLength(PL_Edit_Track1Length, PL_Edit_Track1File)));
        Track3Name:SetText(PL_Edit_Track3Name);
        Track3Length:SetText(TimeString(AnalyzeLength(PL_Edit_Track3Length, PL_Edit_Track3File)));
        end
        if(arg2==4)then
        local Track1Name = getglobal("PLTrack1Name".."Label");
        local Track1Length = getglobal("PLTrack1Length".."Label");
        local Track4Name = getglobal("PLTrack4Name".."Label");
        local Track4Length = getglobal("PLTrack4Length".."Label");
            
        local TempName = PL_Edit_Track1Name;   
        local TempLength = PL_Edit_Track1Length;
        local TempFile = PL_Edit_Track1File;
        PL_Edit_Track1Name = PL_Edit_Track4Name;
        PL_Edit_Track1Length = PL_Edit_Track4Length;
        PL_Edit_Track1File = PL_Edit_Track4File;
        PL_Edit_Track4Name = TempName;
        PL_Edit_Track4Length = TempLength;
        PL_Edit_Track4File = TempFile;
                                                                   
        Track1Name:SetText(PL_Edit_Track1Name);
        Track1Length:SetText(TimeString(AnalyzeLength(PL_Edit_Track1Length, PL_Edit_Track1File)));
        Track4Name:SetText(PL_Edit_Track4Name);
        Track4Length:SetText(TimeString(AnalyzeLength(PL_Edit_Track4Length, PL_Edit_Track4File)));
        end
        if(arg2==5)then
        local Track1Name = getglobal("PLTrack1Name".."Label");
        local Track1Length = getglobal("PLTrack1Length".."Label");
        local Track5Name = getglobal("PLTrack5Name".."Label");
        local Track5Length = getglobal("PLTrack5Length".."Label");
            
        local TempName = PL_Edit_Track1Name;   
        local TempLength = PL_Edit_Track1Length;
        local TempFile = PL_Edit_Track1File;
        PL_Edit_Track1Name = PL_Edit_Track5Name;
        PL_Edit_Track1Length = PL_Edit_Track5Length;
        PL_Edit_Track1File = PL_Edit_Track5File;
        PL_Edit_Track5Name = TempName;
        PL_Edit_Track5Length = TempLength;
        PL_Edit_Track5File = TempFile;
                                                                   
        Track1Name:SetText(PL_Edit_Track1Name);
        Track1Length:SetText(TimeString(AnalyzeLength(PL_Edit_Track1Length, PL_Edit_Track1File)));
        Track5Name:SetText(PL_Edit_Track5Name);
        Track5Length:SetText(TimeString(AnalyzeLength(PL_Edit_Track5Length, PL_Edit_Track5File)));
        end
    end
    if(arg1 == 2)then
        if(arg2 == 3)then
        local Track2Name = getglobal("PLTrack2Name".."Label");
        local Track2Length = getglobal("PLTrack2Length".."Label");
        local Track3Name = getglobal("PLTrack3Name".."Label");
        local Track3Length = getglobal("PLTrack3Length".."Label");
            
        local TempName = PL_Edit_Track2Name;   
        local TempLength = PL_Edit_Track2Length;
        local TempFile = PL_Edit_Track2File;
        PL_Edit_Track2Name = PL_Edit_Track3Name;
        PL_Edit_Track2Length = PL_Edit_Track3Length;
        PL_Edit_Track2File = PL_Edit_Track3File;
        PL_Edit_Track3Name = TempName;
        PL_Edit_Track3Length = TempLength;
        PL_Edit_Track3File = TempFile;
                                                                   
        Track2Name:SetText(PL_Edit_Track2Name);
        Track2Length:SetText(TimeString(AnalyzeLength(PL_Edit_Track2Length, PL_Edit_Track2File)));
        Track3Name:SetText(PL_Edit_Track3Name);
        Track3Length:SetText(TimeString(AnalyzeLength(PL_Edit_Track3Length, PL_Edit_Track3File)));
        end
    end
    if(arg1 == 3)then
        if(arg2 == 4)then
        local Track4Name = getglobal("PLTrack4Name".."Label");
        local Track4Length = getglobal("PLTrack4Length".."Label");
        local Track3Name = getglobal("PLTrack3Name".."Label");
        local Track3Length = getglobal("PLTrack3Length".."Label");
            
        local TempName = PL_Edit_Track4Name;   
        local TempLength = PL_Edit_Track4Length;
        local TempFile = PL_Edit_Track4File;
        PL_Edit_Track4Name = PL_Edit_Track3Name;
        PL_Edit_Track4Length = PL_Edit_Track3Length;
        PL_Edit_Track4File = PL_Edit_Track3File;
        PL_Edit_Track3Name = TempName;
        PL_Edit_Track3Length = TempLength;
        PL_Edit_Track3File = TempFile;
                                                                   
        Track4Name:SetText(PL_Edit_Track4Name);
        Track4Length:SetText(TimeString(AnalyzeLength(PL_Edit_Track4Length, PL_Edit_Track4File)));
        Track3Name:SetText(PL_Edit_Track3Name);
        Track3Length:SetText(TimeString(AnalyzeLength(PL_Edit_Track3Length, PL_Edit_Track3File)));
        end
    end
    if(arg1 == 4)then
        if(arg2 == 5)then
        local Track4Name = getglobal("PLTrack4Name".."Label");
        local Track4Length = getglobal("PLTrack4Length".."Label");
        local Track5Name = getglobal("PLTrack5Name".."Label");
        local Track5Length = getglobal("PLTrack5Length".."Label");
            
        local TempName = PL_Edit_Track4Name;   
        local TempLength = PL_Edit_Track4Length;
        local TempFile = PL_Edit_Track4File;
        PL_Edit_Track4Name = PL_Edit_Track5Name;
        PL_Edit_Track4Length = PL_Edit_Track5Length;
        PL_Edit_Track4File = PL_Edit_Track5File;
        PL_Edit_Track5Name = TempName;
        PL_Edit_Track5Length = TempLength;
        PL_Edit_Track5File = TempFile;
                                                                   
        Track4Name:SetText(PL_Edit_Track4Name);
        Track4Length:SetText(TimeString(AnalyzeLength(PL_Edit_Track4Length, PL_Edit_Track4File)));
        Track5Name:SetText(PL_Edit_Track5Name);
        Track5Length:SetText(TimeString(AnalyzeLength(PL_Edit_Track5Length, PL_Edit_Track5File)));
        end
    end
end
function PLTrackMoveUp(trackNum)
    if(trackNum==1)then
        PLTrackMoveAct(1, PL_Edit_TrackCount)
    end
    if(trackNum==2)then
        PLTrackMoveAct(1, 2)
    end
    if(trackNum==3)then
        PLTrackMoveAct(2, 3)
    end
    if(trackNum==4)then
        PLTrackMoveAct(3, 4)
    end
    if(trackNum==5)then
        PLTrackMoveAct(4, 5)
    end
end

function PLTrackMoveDown(trackNum)
    if(trackNum==1)then
        if(PL_Edit_TrackCount > 1)then
            PLTrackMoveAct(1, 2)
        end
    end
    if(trackNum==2)then
        if(PL_Edit_TrackCount == 2)then
            PLTrackMoveAct(1, 2)
        else
            PLTrackMoveAct(2, 3)
        end
    end
    if(trackNum==3)then
        if(PL_Edit_TrackCount == 3)then
            PLTrackMoveAct(1, 3)
        else
            PLTrackMoveAct(3, 4)
        end
    end
    if(trackNum==4)then
        if(PL_Edit_TrackCount == 4)then
            PLTrackMoveAct(1, 4)
        else
            PLTrackMoveAct(4, 5)
        end
    end
    if(trackNum==5)then
        PLTrackMoveAct(1, 5)
    end
end

function PLDeleteMoveUp(tracknum)
        if(tracknum == 1)then
            local track1Name = getglobal("PLTrack1Name".."Label")
            local track1Length = getglobal("PLTrack1Length".."Label");
            PL_Edit_Track1Name = PL_Edit_Track2Name;
            PL_Edit_Track1Length = PL_Edit_Track2Length;
            PL_Edit_Track1File = PL_Edit_Track2File;
            track1Name:SetText(PL_Edit_Track1Name);
            track1Length:SetText(TimeString(AnalyzeLength(PL_Edit_Track1Length, PL_Edit_Track1File)));
       
        end
        if(tracknum == 2)then
            local track2Name = getglobal("PLTrack2Name".."Label")
            local track2Length = getglobal("PLTrack2Length".."Label");
            PL_Edit_Track2Name = PL_Edit_Track3Name;
            PL_Edit_Track2Length = PL_Edit_Track3Length;
            PL_Edit_Track2File = PL_Edit_Track3File;
            track2Name:SetText(PL_Edit_Track2Name);
            track2Length:SetText(TimeString(AnalyzeLength(PL_Edit_Track2Length, PL_Edit_Track2File)));
        
        end
         if(tracknum == 3)then
            local track3Name = getglobal("PLTrack3Name".."Label")
            local track3Length = getglobal("PLTrack3Length".."Label");
            PL_Edit_Track3Name = PL_Edit_Track4Name;
            PL_Edit_Track3Length = PL_Edit_Track4Length;
            PL_Edit_Track3File = PL_Edit_Track4File;
            track3Name:SetText(PL_Edit_Track3Name);
            track3Length:SetText(TimeString(AnalyzeLength(PL_Edit_Track3Length, PL_Edit_Track3File)));
        
        end
         if(tracknum == 4)then
            local track4Name = getglobal("PLTrack4Name".."Label")
            local track4Length = getglobal("PLTrack4Length".."Label");
            PL_Edit_Track4Name = PL_Edit_Track5Name;
            PL_Edit_Track4Length = PL_Edit_Track5Length;
            PL_Edit_Track4File = PL_Edit_Track5File;
            track4Name:SetText(PL_Edit_Track4Name);
            track4Length:SetText(TimeString(AnalyzeLength(PL_Edit_Track4Length, PL_Edit_Track4File)));
        PanelPLTrack5:Hide();
        end
end

function PLDeleteTrack(tracknum)
    PLAddTrack:Enable();
    PL_Edit_TrackCount = PL_Edit_TrackCount - 1;
    local trackContLabel = getglobal("FramePLEdit".."TxtPLEditTrackCount".."Label");
    trackContLabel:SetText(PL_Edit_TrackCount);
    if(tracknum==1)then
        --PL_Edit_TrackTime = PL_Edit_TrackTime - PL_Edit_Track1Length;
		--PL_Edit_Track5Name
        if(PL_Edit_TrackCount >= 1)then
            PLDeleteMoveUp(1);
        else
            PanelPLTrack1:Hide();
        end
        if(PL_Edit_TrackCount >= 2)then
            PLDeleteMoveUp(2);
        else
            PanelPLTrack2:Hide();
        end
        if(PL_Edit_TrackCount >= 3)then
            PLDeleteMoveUp(3);
        else
            PanelPLTrack3:Hide();
        end
        if(PL_Edit_TrackCount >= 4)then
            PLDeleteMoveUp(4);
        else
            PanelPLTrack4:Hide();
        end
       ------- 
    elseif(tracknum==2)then
        --PL_Edit_TrackTime = PL_Edit_TrackTime - PL_Edit_Track2Length;
        if(PL_Edit_TrackCount >= 2)then
            PLDeleteMoveUp(2);
        else
            PanelPLTrack2:Hide();
        end
        if(PL_Edit_TrackCount >= 3)then
            PLDeleteMoveUp(3);
        else
            PanelPLTrack3:Hide();
        end
        if(PL_Edit_TrackCount >= 4)then
            PLDeleteMoveUp(4);
        else
            PanelPLTrack4:Hide();
        end
    elseif(tracknum==3)then
        --PL_Edit_TrackTime = PL_Edit_TrackTime - PL_Edit_Track3Length;
        if(PL_Edit_TrackCount >= 3)then
            PLDeleteMoveUp(3);
        else
            PanelPLTrack3:Hide();
        end
        if(PL_Edit_TrackCount >= 4)then
            PLDeleteMoveUp(4);
        else
            PanelPLTrack4:Hide();
        end
    elseif(tracknum==4)then
        --PL_Edit_TrackTime = PL_Edit_TrackTime - PL_Edit_Track4Length;
        if(PL_Edit_TrackCount >= 4)then
            PLDeleteMoveUp(4);
        else
            PanelPLTrack4:Hide();
        end
    elseif(tracknum==5)then
        --PL_Edit_TrackTime = PL_Edit_TrackTime - PL_Edit_Track5Length;
        PanelPLTrack5:Hide();
    end
    local trackTimeLabel = getglobal("PLEditTime".."Label");
    trackTimeLabel:SetText(TimeString(PL_Edit_TrackTime));
    
    if(PL_Edit_TrackCount == 0)then
        BtnSavePLChange:Disable();
    else
        BtnSavePLChange:Enable();
    end
end


function PurgeCustom(clength1, clength2, clength3, clength4, clength5)
		if(clength5 == 0)then
			if(PL_Edit_TrackCount >= 5)then
				PLDeleteTrack(5)
			end
		end
		if(clength4 == 0)then
			if(PL_Edit_TrackCount >= 4)then
				PLDeleteTrack(4)
			end
		end
		if(clength3 == 0)then
			if(PL_Edit_TrackCount >= 3)then
				PLDeleteTrack(3)
			end
		end
		if(clength2 == 0)then
			if(PL_Edit_TrackCount >= 2)then
				PLDeleteTrack(2)
			end
		end
		if(clength1 == 0)then
			if(PL_Edit_TrackCount >= 1)then
				PLDeleteTrack(1)
			end
		end
end


function SetNothingSelected()
        local PlayButton = getglobal("JukeBoxForm".."Page1".."PanelPlay".."PlayButton");
        PlayButton:Disable();
        
        BtnPLChooseTrack:Disable();
        JukeBox_SelectedName = "Nothing Selected Error";
        JukeBox_SelectedFile = "Sound\\Character\\BloodElf\\BloodElfMale_Err_GenericNoTarget03.wav";
        JukeBox_SelectedLength = "7";
        JukeBox_SelectedPlayListData = "";
        labelName = getglobal("JukeBoxForm".."Page1".."PanelPlay".."TextName".."Label");
            labelName:SetText("(None Selected)");
            labelLength = getglobal("JukeBoxForm".."Page1".."PanelPlay".."TextLength".."Label");
            labelLength:SetText("0:00");
            JukeBox_nothingselected = true;
            JukeBox_PlayListIsSelected = false;
            CustomIsSelected = false;
            
end

function SwitchPage(pageNumber)
    local Page1 = getglobal("JukeBoxForm".."Page1");
    local Page2 = getglobal("JukeBoxForm".."Page2");
    local Page3 = getglobal("JukeBoxForm".."Page3");
    local Page4 = getglobal("JukeBoxForm".."Page4");
    PlaySound("UChatScrollButton");
    JukeBox_CurrentPage = pageNumber;
    if(pageNumber==1)then
        local test = getglobal("LabelTitle".."Label");
        local checkString = tonumber(JukeBox_SelectedFile);
        if(JukeBox_PlayListIsSelected==true)then
            if(PlayListsTable[checkString]~=nil)then
                ChoosePlayList(checkString)
            else
                SetNothingSelected();
            end
        elseif(CustomIsSelected==true)then
            if(CustomTable[checkString]~=nil)then
                ChooseCustomSong(checkString);
            else
                SetNothingSelected();
            end
        end
        Page1:Show();
        Page2:Hide();
        Page3:Hide();
        Page4:Hide();
        PageBtn1:Disable();
        PageBtn2:Enable();
        PageBtn3:Enable();
        PageBtn4:Enable();
    elseif(pageNumber==2)then
        local pllength1 = PL_Edit_Track1Length
        local pllength2 = PL_Edit_Track2Length
        local pllength3 = PL_Edit_Track3Length
        local pllength4 = PL_Edit_Track4Length
        local pllength5 = PL_Edit_Track5Length
        local plname1 = PL_Edit_Track1Name
        local plname2 = PL_Edit_Track2Name
        local plname3 = PL_Edit_Track3Name
        local plname4 = PL_Edit_Track4Name
        local plname5 = PL_Edit_Track5Name
        local plfile1 = PL_Edit_Track1File
        local plfile2 = PL_Edit_Track2File
        local plfile3 = PL_Edit_Track3File
        local plfile4 = PL_Edit_Track4File
        local plfile5 = PL_Edit_Track5File
        
       
        
        local clength1 = pllength1;
        local clength2 = pllength2;
        local clength3 = pllength3;
        local clength4 = pllength4;
        local clength5 = pllength5;
       
       
        clength1 = AnalyzeLength(pllength1, plfile1);
        clength2 = AnalyzeLength(pllength2, plfile2);
        clength3 = AnalyzeLength(pllength3, plfile3);
        clength4 = AnalyzeLength(pllength4, plfile4);
        clength5 = AnalyzeLength(pllength5, plfile5);
       
        local cname1 = plname1;
        local cname2 = plname2;
        local cname3 = plname3;
        local cname4 = plname4;
        local cname5 = plname5;
       
       
        cname1 = AnalyzeName(pllength1, plfile1, plname1);
        cname2 = AnalyzeName(pllength2, plfile2, plname2);
        cname3 = AnalyzeName(pllength3, plfile3, plname3);
        cname4 = AnalyzeName(pllength4, plfile4, plname4);
        cname5 = AnalyzeName(pllength5, plfile5, plname5);
       
        
        
        local cfile1 = plfile1;
        local cfile2 = plfile2;
        local cfile3 = plfile3;
        local cfile4 = plfile4;
        local cfile5 = plfile5;
       
       
        cfile1 = AnalyzeFile(pllength1, plfile1);
        cfile2 = AnalyzeFile(pllength2, plfile2);
        cfile3 = AnalyzeFile(pllength3, plfile3);
        cfile4 = AnalyzeFile(pllength4, plfile4);
        cfile5 = AnalyzeFile(pllength5, plfile5);
		local trackCounter = PL_Edit_TrackCount;
		-- local delCounter = 0;
		
		local test = getglobal("LabelTitle".."Label");
		--SillyTest(clength1, clength2, clength3, clength4, clength5)
		--SillyTest(clength1, clength2, clength3, clength4, clength5)
		-- if(clength5 == 0)then
			-- if(PL_Edit_TrackCount >= 5)then
				-- PLDeleteTrack(5)
				-- test:SetText("HELLO!")
				-- else
				-- test:SetText("MEW!")
			-- end
		-- end
		-- if(clength4 == 0)then
			-- if(PL_Edit_TrackCount >= 4)then
				-- PLDeleteTrack(4)
			-- end
		-- end
		-- if(clength3 == 0)then
			-- if(PL_Edit_TrackCount >= 3)then
				-- PLDeleteTrack(3)
			-- end
		-- end
		-- if(clength2 == 0)then
			-- if(PL_Edit_TrackCount >= 2)then
				-- PLDeleteTrack(2)
			-- end
		-- end
		-- if(clength1 == 0)then
			-- if(PL_Edit_TrackCount >= 1)then
				-- PLDeleteTrack(1)
			-- end
		-- end
		
		
		
		
		
        
        
       
        PL_Edit_TrackTime = clength1 + clength2 + clength3 + clength4 + clength5;
        
        
        
        --local test = getglobal("debugPlaylistID".."Label");
        --test:SetText(PL_Edit_ListID);
        
        local Track1Name = getglobal("PLTrack1Name".."Label");
        Track1Name:SetText(cname1);
        local Track2Name = getglobal("PLTrack2Name".."Label");
        Track2Name:SetText(cname2);
        local Track3Name = getglobal("PLTrack3Name".."Label");
        Track3Name:SetText(cname3);
        local Track4Name = getglobal("PLTrack4Name".."Label");
        Track4Name:SetText(cname4);
        local Track5Name = getglobal("PLTrack5Name".."Label");
        Track5Name:SetText(cname5);
        
        local Track1Length = getglobal("PLTrack1Length".."Label");
        Track1Length:SetText(TimeString(clength1));
        local Track2Length = getglobal("PLTrack2Length".."Label");
        Track2Length:SetText(TimeString(clength2));
        local Track3Length = getglobal("PLTrack3Length".."Label");
        Track3Length:SetText(TimeString(clength3));
        local Track4Length = getglobal("PLTrack4Length".."Label");
        Track4Length:SetText(TimeString(clength4));
        local Track5Length = getglobal("PLTrack5Length".."Label");
        Track5Length:SetText(TimeString(clength5));
       
        local ResetTimeCount = getglobal("PLEditTime".."Label");
        ResetTimeCount:SetText(TimeString(PL_Edit_TrackTime));
		local ResetTrackCount = getglobal("FramePLEdit".."TxtPLEditTrackCount".."Label");
        ResetTrackCount:SetText(PL_Edit_TrackCount);
        
		PurgeCustom(clength1, clength2, clength3, clength4, clength5)
       
    
        Page2:Show();
        Page1:Hide();
        Page3:Hide();
        Page4:Hide();
        PageBtn2:Disable();
        PageBtn1:Enable();
        PageBtn3:Enable();
        PageBtn4:Enable();
    elseif(pageNumber==3)then
        Page3:Show();
        Page2:Hide();
        Page1:Hide();
        Page4:Hide();
        PageBtn3:Disable();
        PageBtn2:Enable();
        PageBtn1:Enable();
        PageBtn4:Enable();
        local Page3Text = getglobal("JukeBoxForm".."Page3".."Container3".."pageThreeText".."Label");
        Page3Text:SetText(GetZoneText());
        
        local MountText = getglobal("APMountLabel".."Label");
		local CombatText = getglobal("APCombatLabel".."Label");
		local AreaText = getglobal("APAreaLabel".."Label");
        ---------------
		local test = getglobal("LabelTitle".."Label");
        if(tonumber(AutoPlayTable[1])~=0)then
			APMountCheck:Enable()
			APMountAutoLoopCheck:Enable()
			APMountAutoLoopText:Show()
            local useSwitch, useType, useName, useLength, useFile, useAutoLoop = strsplit("\a", AutoPlayTable[1]);
			--ap_DontCheck = true;
			APMountCheck:SetChecked(tonumber(useSwitch))
			APMountAutoLoopCheck:SetChecked(tonumber(useAutoLoop))
			--ap_DontCheck = false;
            local labelName = "";
            local labelLength = 0;
            if(useType=="0")then
                labelName = useName
                labelLength = useLength
                MountText:SetText(labelName.." ("..TimeString(AnalyzeLength(useLength, useFile))..")")
            elseif(useType=="1")then
                if(PlayListsTable[tonumber(useFile)]~=nil)then
					local plid, plname, plcount, plname1, pllength1, plfile1, plname2, pllength2, plfile2, plname3, pllength3, plfile3, plname4, pllength4, plfile4, plname5, pllength5, plfile5 = strsplit("\a", PlayListsTable[tonumber(useFile)]);
					labelName = plname;
					labelLength = AnalyzeLength(pllength1, plfile1)+AnalyzeLength(pllength2, plfile2)+AnalyzeLength(pllength3, plfile3)+AnalyzeLength(pllength4, plfile4)+AnalyzeLength(pllength5, plfile5);
					MountText:SetText(labelName.." ("..TimeString(labelLength)..")")
                else
					AutoPlayTable[1] = 0;
					MountText:SetText("(None)")
					APMountCheck:Disable()
					APMountAutoLoopCheck:Disable()
					APMountAutoLoopText:Hide()
                end
            elseif(useType=="2")then
                if(CustomTable[tonumber(useFile)]~=nil)then
					local id, name, length, file = strsplit("\a", CustomTable[tonumber(useFile)])
					labelName = name;
					labelLength = tonumber(length);
					MountText:SetText(labelName.." ("..TimeString(labelLength)..")")
                else
					AutoPlayTable[1] = 0;
					MountText:SetText("(None)")
					APMountCheck:Disable()
					APMountAutoLoopCheck:Disable()
					APMountAutoLoopText:Hide()
                end
            end
		else
			MountText:SetText("(None)")
			APMountCheck:Disable()
			APMountAutoLoopCheck:Disable()
			APMountAutoLoopText:Hide()
        end
		
		if(tonumber(AutoPlayTable[2]) ~= 0)then
			APCombatCheck:Enable()
			APCombatAutoLoopCheck:Enable()
			APCombatAutoLoopText:Show()
			local useSwitch, useType, useName, useLength, useFile, useAutoLoop = strsplit("\a", AutoPlayTable[2]);
            ap_DontCheck = true;
			APCombatCheck:SetChecked(tonumber(useSwitch))
			APCombatAutoLoopCheck:SetChecked(tonumber(useAutoLoop))
			ap_DontCheck = false;
			local labelName = "";
            local labelLength = 0;
            if(useType=="0")then
                labelName = useName
                labelLength = useLength
                CombatText:SetText(labelName.." ("..TimeString(AnalyzeLength(useLength, useFile))..")")
            elseif(useType=="1")then
                if(PlayListsTable[tonumber(useFile)]~=nil)then
					local plid, plname, plcount, plname1, pllength1, plfile1, plname2, pllength2, plfile2, plname3, pllength3, plfile3, plname4, pllength4, plfile4, plname5, pllength5, plfile5 = strsplit("\a", PlayListsTable[tonumber(useFile)]);
					labelName = plname;
					labelLength = AnalyzeLength(pllength1, plfile1)+AnalyzeLength(pllength2, plfile2)+AnalyzeLength(pllength3, plfile3)+AnalyzeLength(pllength4, plfile4)+AnalyzeLength(pllength5, plfile5);
					CombatText:SetText(labelName.." ("..TimeString(labelLength)..")")
                else
					AutoPlayTable[2] = 0;
					CombatText:SetText("(None)")
					APCombatCheck:Disable()
					APCombatAutoLoopCheck:Disable()
					APCombatAutoLoopText:Hide()
                end
            elseif(useType=="2")then
                if(CustomTable[tonumber(useFile)]~=nil)then
					local id, name, length, file = strsplit("\a", CustomTable[tonumber(useFile)])
					labelName = name;
					labelLength = tonumber(length);
					CombatText:SetText(labelName.." ("..TimeString(labelLength)..")")
                else
					AutoPlayTable[2] = 0;
					CombatText:SetText("None")
					APCombatCheck:Disable()
					APCombatAutoLoopCheck:Disable()
					APCombatAutoLoopText:Hide()
                end
            end
		else
			CombatText:SetText("(None)")
			APCombatCheck:Disable()
			APCombatAutoLoopCheck:Disable()
			APCombatAutoLoopText:Hide()
        end
		
		if(tonumber(AutoPlayTable[3]) ~= 0)then
			APAreaCheck:Enable()
			APAreaAutoLoopCheck:Enable()
			APAreaAutoLoopText:Show()
			local useSwitch, useType, useName, useLength, useFile, useAutoLoop = strsplit("\a", AutoPlayTable[3]);
            ap_DontCheck = true;
			APAreaCheck:SetChecked(tonumber(useSwitch))
			APAreaAutoLoopCheck:SetChecked(tonumber(useAutoLoop))
			ap_DontCheck = false;
			local labelName = "";
            local labelLength = 0;
            if(useType=="0")then
                labelName = useName
                labelLength = useLength
                AreaText:SetText(labelName.." ("..TimeString(AnalyzeLength(useLength, useFile))..")")
            elseif(useType=="1")then
                if(PlayListsTable[tonumber(useFile)]~=nil)then
					local plid, plname, plcount, plname1, pllength1, plfile1, plname2, pllength2, plfile2, plname3, pllength3, plfile3, plname4, pllength4, plfile4, plname5, pllength5, plfile5 = strsplit("\a", PlayListsTable[tonumber(useFile)]);
					labelName = plname;
					labelLength = AnalyzeLength(pllength1, plfile1)+AnalyzeLength(pllength2, plfile2)+AnalyzeLength(pllength3, plfile3)+AnalyzeLength(pllength4, plfile4)+AnalyzeLength(pllength5, plfile5);
					AreaText:SetText(labelName.." ("..TimeString(labelLength)..")")
                else
					AutoPlayTable[3] = 0;
					AreaText:SetText("(None)")
					APAreaCheck:Disable()
					APAreaAutoLoopCheck:Disable()
					APAreaAutoLoopText:Hide()
                end
            elseif(useType=="2")then
                if(CustomTable[tonumber(useFile)]~=nil)then
					local id, name, length, file = strsplit("\a", CustomTable[tonumber(useFile)])
					labelName = name;
					labelLength = tonumber(length);
					AreaText:SetText(labelName.." ("..TimeString(labelLength)..")")
                else
					AutoPlayTable[3] = 0;
					AreaText:SetText("(None)")
					APAreaCheck:Disable()
					APAreaAutoLoopCheck:Disable()
					APAreaAutoLoopText:Hide()
                end
            end
		else
			AreaText:SetText("(None)")
			APAreaCheck:Disable()
			APAreaAutoLoopCheck:Disable()
			APAreaAutoLoopText:Hide()
        end
        -----------
        
        
    elseif(pageNumber==4)then
        Page4:Show();
        Page2:Hide();
        Page3:Hide();
        Page1:Hide();
        PageBtn4:Disable();
        PageBtn2:Enable();
        PageBtn3:Enable();
        PageBtn1:Enable();
    end
end



function DDGame_Initialise()
 level = level or 1 --drop down menus can have sub menus. The value of "level" determines the drop down sub menu tier.
 
 local info = UIDropDownMenu_CreateInfo();
 
 info.text = "World of Warcraft";
 info.value = 0;
 info.func = function() DDGameItem_OnClick() end;
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 UIDropDownMenu_AddButton(info, level);
 
 info.text = "Burning Crusade";
 info.value = 1;
 info.func = function() DDGameItem_OnClick() end;
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 UIDropDownMenu_AddButton(info, level);
 
 info.text = "Wrath of the Lich King (Zones)";
 info.value = 2;
 info.func = function() DDGameItem_OnClick() end;
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 UIDropDownMenu_AddButton(info, level);
 
 info.text = "Wrath of the Lich King (Dungeons)";
 info.value = 10;
 info.func = function() DDGameItem_OnClick() end;
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 UIDropDownMenu_AddButton(info, level);
 
 info.text = "Wrath of the Lich King (Raids)";
 info.value = 11;
 info.func = function() DDGameItem_OnClick() end;
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 UIDropDownMenu_AddButton(info, level);

 info.text = "Editor's Pick";
 info.value = 3;
 info.func = function() DDGameItem_OnClick() end;
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 UIDropDownMenu_AddButton(info, level);
 
 info.text = "Playlists";
 info.value = 4;
 info.func = function() DDGameItem_OnClick() end;
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 UIDropDownMenu_AddButton(info, level);

 info.text = "Custom Tracks";
 info.value = 5;
 info.func = function() DDGameItem_OnClick() end;
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 UIDropDownMenu_AddButton(info, level);
        
end


function DDGameItem_OnClick() -- See note 1
  UIDropDownMenu_SetSelectedValue(this.owner, this.value);
  

  --  DDZone:SetText("TEST");
  --  UIDropDownMenu_ClearAll(DDZone);
  --UIDropDownMenu_ClearAll(DDSong);
	if (this.value == 0) then
		Selected_Game = 0;
		DDZone:Show();
	elseif (this.value == 1) then
		Selected_Game = 1;
		DDZone:Show();
	elseif (this.value == 2) then
		Selected_Game = 2;
		DDZone:Show();
	elseif (this.value == 2) then
		Selected_Game = 2;
		DDZone:Show();
	elseif (this.value == 10) then
		Selected_Game = 10;
		DDZone:Show();
	elseif (this.value == 11) then
		Selected_Game = 11;
		DDZone:Show();
	elseif (this.value == 3) then
		Selected_Game = 3;
		DDZone:Hide();
	elseif (this.value == 4) then
		Selected_Game = 4;
		DDZone:Hide();
	elseif (this.value == 5) then
		Selected_Game = 5;
		DDZone:Hide();
	end
end

function DDZone_Initialise()
 level = level or 1 --drop down menus can have sub menus. The value of "level" determines the drop down sub menu tier.
 
 local info = UIDropDownMenu_CreateInfo();
 if(Selected_Game == 0)then
    info.text = "Title Screen";
    info.value = 0;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
    
    info.text = "Battlegrounds";
    info.value = 2;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
 elseif(Selected_Game == 1)then
    info.text = "Title Screen";
    info.value = 1;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
 
    info.text = "Karazhan";
    info.value = 2;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
 elseif(Selected_Game == 2)then
    info.text = "Title Screen";
    info.value = 1;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
    
    info.text = "Howling Fjord";
    info.value = 2;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
    
    
     
    --info.text = "Utgarde Pinnacle";
    --info.value = 4;
    --info.func = function() DDZoneItem_OnClick() end;
    --info.owner = this:GetParent();
    --info.checked = nil;
    --info.icon = nil;
    --UIDropDownMenu_AddButton(info, level);
	
	info.text = "Borean Tundra";
    info.value = 5;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
    
    info.text = "Borean Tundra (2)";
    info.value = 34;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
    
   
    
    --info.text = "The Oculus";
    --info.value = 7;
    --info.func = function() DDZoneItem_OnClick() end;
    --info.owner = this:GetParent();
    --info.checked = nil;
    --info.icon = nil;
    --UIDropDownMenu_AddButton(info, level);
    
    --info.text = "The Eye of Eternity";
    --info.value = 8;
    --info.func = function() DDZoneItem_OnClick() end;
    --info.owner = this:GetParent();
    --info.checked = nil;
    --info.icon = nil;
    --UIDropDownMenu_AddButton(info, level);
    
    info.text = "Dragonblight";
    info.value = 9;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
    
    info.text = "Dragonblight (2)";
    info.value = 35;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
    
    
    
    info.text = "Grizzly Hills";
    info.value = 10;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
    
    info.text = "Grizzly Hills (2)";
    info.value = 36;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
    
    info.text = "Zul'Drak";
    info.value = 11;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
    
   -- info.text = "Drak'Theron Keep";
   -- info.value = 12;
   -- info.func = function() DDZoneItem_OnClick() end;
   -- info.owner = this:GetParent();
   -- info.checked = nil;
   -- info.icon = nil;
   -- UIDropDownMenu_AddButton(info, level);
    
    -- info.text = "Gun'Drak";
    -- info.value = 13;
    -- info.func = function() DDZoneItem_OnClick() end;
    -- info.owner = this:GetParent();
    -- info.checked = nil;
    -- info.icon = nil;
    -- UIDropDownMenu_AddButton(info, level);
    
    info.text = "Crystalsong Forest";
    info.value = 14;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
    
    info.text = "Dalaran";
    info.value = 15;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
    
    
    
    info.text = "Sholazar Basin";
    info.value = 16;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
    
    info.text = "Storm Peaks";
    info.value = 17;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
    
    
    
    info.text = "Icecrown";
    info.value = 21;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
    
    info.text = "Acherus, the Ebon Hold";
    info.value = 26;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
    
    
    
    info.text = "Wintergrasp";
    info.value = 25;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
    
    info.text = "Northrend Racials";
    info.value = 24;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
    
    --info.text = "Race: Orc";
    --info.value = 30;
    --info.func = function() DDZoneItem_OnClick() end;
    --info.owner = this:GetParent();
    --info.checked = nil;
    --info.icon = nil;
    --UIDropDownMenu_AddButton(info, level);
    
    info.text = "Northrend Racials (2)";
    info.value = 31;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
	
	--info.text = "The Secrets of Ulduar";
    --info.value = 99;
    --info.func = function() DDZoneItem_OnClick() end;
    --info.owner = this:GetParent();
    --info.checked = nil;
    --info.icon = nil;
	--info.hasArrow = true; -- creates submenu
    --info.notCheckable = true;
    --UIDropDownMenu_AddButton(info, level);
	
	
    
    --info.text = "Race: Troll";
    --info.value = 32;
    --info.func = function() DDZoneItem_OnClick() end;
    --info.owner = this:GetParent();
    --info.checked = nil;
    --info.icon = nil;
    --UIDropDownMenu_AddButton(info, level);
    
    --info.text = "Northrend Transports";
    --info.value = 33;
    --info.func = function() DDZoneItem_OnClick() end;
    --info.owner = this:GetParent();
    --info.checked = nil;
    --info.icon = nil;
    --UIDropDownMenu_AddButton(info, level);
	
	
	
	info.text = "Argent Tournament";
    info.value = 42;
    info.func = function() DDZoneItem_OnClick() end;
    info.owner = this:GetParent();
    info.checked = nil;
    info.icon = nil;
    UIDropDownMenu_AddButton(info, level);
	elseif(Selected_Game == 10)then --Lich King Dungeons
		info.text = "Utgarde Keep and Pinnacle";
		info.value = 3;
		info.func = function() DDZoneItem_OnClick() end;
		info.owner = this:GetParent();
		info.checked = nil;
		info.icon = nil;
		UIDropDownMenu_AddButton(info, level);

		info.text = "The Nexus, Oculus and Eye of Eternity";
		info.value = 6;
		info.func = function() DDZoneItem_OnClick() end;
		info.owner = this:GetParent();
		info.checked = nil;
		info.icon = nil;
		UIDropDownMenu_AddButton(info, level);
		
		info.text = "Azjol-Nerub";
		info.value = 8;
		info.func = function() DDZoneItem_OnClick() end;
		info.owner = this:GetParent();
		info.checked = nil;
		info.icon = nil;
		UIDropDownMenu_AddButton(info, level);

		info.text = "The Violet Hold";
		info.value = 22;
		info.func = function() DDZoneItem_OnClick() end;
		info.owner = this:GetParent();
		info.checked = nil;
		info.icon = nil;
		UIDropDownMenu_AddButton(info, level);

		info.text = "Halls of Stone and Lightning";
		info.value = 18;
		info.func = function() DDZoneItem_OnClick() end;
		info.owner = this:GetParent();
		info.checked = nil;
		info.icon = nil;
		UIDropDownMenu_AddButton(info, level);

		info.text = "The Culling of Stratholme";
		info.value = 23;
		info.func = function() DDZoneItem_OnClick() end;
		info.owner = this:GetParent();
		info.checked = nil;
		info.icon = nil;
		UIDropDownMenu_AddButton(info, level);
	elseif(Selected_Game == 11)then	--Lich King Raids
		info.text = "Naxxramas";
		info.value = 43;
		info.func = function() DDZoneItem_OnClick() end;
		info.owner = this:GetParent();
		info.checked = nil;
		info.icon = nil;
		UIDropDownMenu_AddButton(info, level);
		
		info.text = "The Obsidian Sanctum";
		info.value = 7;
		info.func = function() DDZoneItem_OnClick() end;
		info.owner = this:GetParent();
		info.checked = nil;
		info.icon = nil;
		UIDropDownMenu_AddButton(info, level);
		
		info.text = "The Secrets of Ulduar - Welcome";
		info.value = 45;
		info.func = function() DDZoneItem_OnClick() end;
		info.owner = this:GetParent();
		info.checked = nil;
		info.icon = nil;
		UIDropDownMenu_AddButton(info, level);
		
		info.text = "The Secrets of Ulduar - Exterior";
		info.value = 40;
		info.func = function() DDZoneItem_OnClick() end;
		info.owner = this:GetParent();
		info.checked = nil;
		info.icon = nil;
		UIDropDownMenu_AddButton(info, level);
		
		info.text = "The Secrets of Ulduar - Interior";
		info.value = 41;
		info.func = function() DDZoneItem_OnClick() end;
		info.owner = this:GetParent();
		info.checked = nil;
		info.icon = nil;
		UIDropDownMenu_AddButton(info, level);
		
		info.text = "The Secrets of Ulduar - Algalon";
		info.value = 44;
		info.func = function() DDZoneItem_OnClick() end;
		info.owner = this:GetParent();
		info.checked = nil;
		info.icon = nil;
		UIDropDownMenu_AddButton(info, level);
	
	elseif(Selected_Game == 3)then
		info.text = "test_item_ecselected";
		info.value = 0;
		info.func = function() DDZoneItem_OnClick() end;
		info.owner = this:GetParent();
		info.checked = nil;
		info.icon = nil;
		UIDropDownMenu_AddButton(info, level);
	elseif(Selected_Game == 4)then
		info.text = "test_item_favselected";
		info.value = 0;
		info.func = function() DDZoneItem_OnClick() end;
		info.owner = this:GetParent();
		info.checked = nil;
		info.icon = nil;
		UIDropDownMenu_AddButton(info, level);
 
 info.text = "test_item_favselectedB";
 info.value = 0;
 info.func = function() DDZoneItem_OnClick() end;
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 UIDropDownMenu_AddButton(info, level);
 end
end


function DDSong_Initialise()
 level = level or 1 --drop down menus can have sub menus. The value of "level" determines the drop down sub menu tier.
 
 local info = UIDropDownMenu_CreateInfo();
 if(Selected_Game == 0)then
    if(Selected_Zone == 0)then
        info.text = "World of Warcraft Main Theme";
        info.value = 0;
        info.func = function() ChooseSong("World of Warcraft Main Theme", "Sound\\Music\\GlueScreenMusic\\wow_main_theme.mp3", "145"); end; --2:25
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
    elseif(Selected_Zone == 2)then
        info.text = "PvP Battlegrounds - 1";
        info.value = 0;
        info.func = function() ChooseSong("PvP Battlegrounds - 1", "Sound\\Music\\ZoneMusic\\PVP\\pvp1.mp3", "44"); end; --44
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "PvP Battlegrounds - 2";
        info.value = 0;
        info.func = function() ChooseSong("PvP Battlegrounds - 2", "Sound\\Music\\ZoneMusic\\PVP\\pvp2.mp3", "50"); end; --50
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "PvP Battlegrounds - 3";
        info.value = 0;
        info.func = function() ChooseSong("PvP Battlegrounds - 3", "Sound\\Music\\ZoneMusic\\PVP\\pvp3.mp3", "36"); end; --36
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "PvP Battlegrounds - 4";
        info.value = 0;
        info.func = function() ChooseSong("PvP Battlegrounds - 4", "Sound\\Music\\ZoneMusic\\PVP\\pvp4.mp3", "58"); end; --58
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "PvP Battlegrounds - 5";
        info.value = 0;
        info.func = function() ChooseSong("PvP Battlegrounds - 5", "Sound\\Music\\ZoneMusic\\PVP\\pvp5.mp3", "58"); end; --58
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
    end
  elseif(Selected_Game == 1)then
    if(Selected_Zone == 1)then
        info.text = "Burning Crusade Main Theme";
        info.value = 0;
        info.func = function() ChooseSong("Burning Crusade Main Theme", "Sound\\Music\\GlueScreenMusic\\BC_main_theme.mp3", "226"); end; --3:46
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Lament of the Highborne";
        info.value = 0;
        info.func = function() ChooseSong("Lament of the Highborne", "Sound\\Music\\GlueScreenMusic\\BCCredits_Lament_of_the_Highborne.mp3", "171"); end; --2:51
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
    elseif(Selected_Zone == 2)then
        info.text = "Prince Malchezar 1";
        info.value = 0;
        info.func = function() ChooseSong("Prince Malchezar 1", "Sound\\Music\\ZoneMusic\\Karazhan\\KA_MalchezarWalkUni01.mp3", "124"); end; --2:04
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        info.text = "Prince Malchezar 2";
        info.value = 0;
        info.func = function() ChooseSong("Prince Malchezar 2", "Sound\\Music\\ZoneMusic\\Karazhan\\KA_MalchezarWalkUni02.mp3", "111"); end; --1:51
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        info.text = "Prince Malchezar 3";
        info.value = 0;
        info.func = function() ChooseSong("Prince Malchezar 3", "Sound\\Music\\ZoneMusic\\Karazhan\\KA_MalchezarWalkUni03.mp3", "113"); end; --1:53
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
     end
   elseif(Selected_Game == 2)then
     if(Selected_Zone == 1)then
        info.text = "Wrath of the Lich King Main Theme";
        info.value = 0;
        info.func = function() ChooseSong("Wrath of the Lich King Main Theme", "Sound\\Music\\GlueScreenMusic\\WotLK_main_title.mp3", "540"); end; --9 min
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
     elseif(Selected_Zone == 2)then
        info.text = "Howling Fjord - Day 1";
        info.value = 0;
        info.func = function() ChooseSong("Howling Fjord - Day 1", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_GeneralWalk_Day01.mp3", "109"); end; --1:49
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Howling Fjord - Day 2";
        info.value = 0;
        info.func = function() ChooseSong("Howling Fjord - Day 2", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_GeneralWalk_Day02.mp3", "74"); end; --1:14
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Howling Fjord - Day 3";
        info.value = 0;
        info.func = function() ChooseSong("Howling Fjord - Day 3", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_GeneralWalk_Day03.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Howling Fjord - Day 4";
        info.value = 0;
        info.func = function() ChooseSong("Howling Fjord - Day 4", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_GeneralWalk_Day04.mp3", "63"); end; --1:03
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Howling Fjord - Day 5";
        info.value = 0;
        info.func = function() ChooseSong("Howling Fjord - Day 5", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_GeneralWalk_Day05.mp3", "123"); end; --2:03
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Howling Fjord - Day 6";
        info.value = 0;
        info.func = function() ChooseSong("Howling Fjord - Day 6", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_GeneralWalk_Day06.mp3", "114"); end; --1:54
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Howling Fjord - Day 7";
        info.value = 0;
        info.func = function() ChooseSong("Howling Fjord - Day 7", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_GeneralWalk_Day07.mp3", "149"); end; --2:29
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Howling Fjord - Night 1";
        info.value = 0;
        info.func = function() ChooseSong("Howling Fjord - Night 1", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_GeneralWalk_Night01.mp3", "106"); end; --1:46
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Howling Fjord - Night 2";
        info.value = 0;
        info.func = function() ChooseSong("Howling Fjord - Night 2", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_GeneralWalk_Night02.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Howling Fjord - Night 3";
        info.value = 0;
        info.func = function() ChooseSong("Howling Fjord - Night 3", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_GeneralWalk_Night03.mp3", "84"); end; --1:24
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Howling Fjord - Night 4";
        info.value = 0;
        info.func = function() ChooseSong("Howling Fjord - Night 4", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_GeneralWalk_Night04.mp3", "157"); end; --2:37
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Kamagua - Day 1";
        info.value = 0;
        info.func = function() ChooseSong("Kamagua Day 1", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_Tusk_KamaguaDay01.mp3", "94"); end; --1:34
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Kamagua - Day 2";
        info.value = 0;
        info.func = function() ChooseSong("Kamagua Day 2", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_Tusk_KamaguaDay02.mp3", "54"); end; --54 sec
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Kamagua - Night 1";
        info.value = 0;
        info.func = function() ChooseSong("Kamagua - Night 1", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_Tusk_KamaguaNight01.mp3", "99"); end; --1:39
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Kamagua - Night 2";
        info.value = 0;
        info.func = function() ChooseSong("Kamagua - Night 2", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_Tusk_KamaguaNight02.mp3", "80"); end; --1:20
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Vrykul Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Vrykul Theme 1", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_DistWalkUni01.mp3", "30"); end; --30 sec
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Vrykul Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Vrykul Theme 2", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_DistWalkUni02.mp3", "47"); end; --47 sec
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Vrykul Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Vrykul Theme 3", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_DistWalkUni03.mp3", "52"); end; --52 sec
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Vrykul Theme 4";
        info.value = 0;
        info.func = function() ChooseSong("Vrykul Theme 4", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_DistWalkUni04.mp3", "26"); end; --26 sec
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Vrykul Theme 5";
        info.value = 0;
        info.func = function() ChooseSong("Vrykul Theme 5", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_DistWalkUni05.mp3", "22"); end; --22 sec
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Vrykul Theme 6";
        info.value = 0;
        info.func = function() ChooseSong("Vrykul Theme 6", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_DistWalkUni06.mp3", "41"); end; --41 sec
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Vrykul Theme 7";
        info.value = 0;
        info.func = function() ChooseSong("Vrykul Theme 7", "Sound\\Music\\ZoneMusic\\HowlingFjord\\HF_DistWalkUni07.mp3", "22"); end; --22 sec
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
     elseif(Selected_Zone == 3)then
        info.text = "Utgarde Keep 1";
        info.value = 0;
        info.func = function() ChooseSong("Utgarde Keep 1", "Sound\\Music\\ZoneMusic\\Utgarde Keep\\UK_GeneralWalkUni01.mp3", "55"); end; --55 sec
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        
        info.text = "Utgarde Keep 2";
        info.value = 0;
        info.func = function() ChooseSong("Utgarde Keep 2", "Sound\\Music\\ZoneMusic\\Utgarde Keep\\UK_GeneralWalkUni02.mp3", "52"); end; --52 sec
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Utgarde Keep 3";
        info.value = 0;
        info.func = function() ChooseSong("Utgarde Keep 3", "Sound\\Music\\ZoneMusic\\Utgarde Keep\\UK_GeneralWalkUni03.mp3", "54"); end; --54 sec
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Utgarde Keep 4";
        info.value = 0;
        info.func = function() ChooseSong("Utgarde Keep 4", "Sound\\Music\\ZoneMusic\\Utgarde Keep\\UK_GeneralWalkUni04.mp3", "26"); end; --26 sec
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Utgarde Keep 5";
        info.value = 0;
        info.func = function() ChooseSong("Utgarde Keep 5", "Sound\\Music\\ZoneMusic\\Utgarde Keep\\UK_GeneralWalkUni05.mp3", "30"); end; --30 sec
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Utgarde Keep - Normal A";
        info.value = 0;
        info.func = function() ChooseSong("Utgarde Keep - Normal A", "Sound\\Music\\ZoneMusic\\Utgarde Keep\\UK_QuietWalkUni01.mp3", "108"); end; --1:48 sec
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Utgarde Keep - Normal B";
        info.value = 0;
        info.func = function() ChooseSong("Utgarde Keep - Normal B", "Sound\\Music\\ZoneMusic\\Utgarde Keep\\UK_QuietWalkUni02.mp3", "107"); end; --1:47 sec
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
     elseif(Selected_Zone == 5)then
        info.text = "Borean Tundra - Day Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Day Theme 1", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_GeneralWalk_Day01.mp3", "73"); end; --1:13 sec
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Day Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Day Theme 2", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_GeneralWalk_Day02.mp3", "100"); end; --1:40
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Day Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Day Theme 3", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_GeneralWalk_Day03.mp3", "76"); end; --1:16
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Day Theme 4";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Day Theme 4", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_GeneralWalk_Day04.mp3", "104"); end; --1:44
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Day Theme 5";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Day Theme 5", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_GeneralWalk_Day04.mp3", "71"); end; --1:11
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Day Theme 6";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Day Theme 6", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_GeneralWalk_Day06.mp3", "113"); end; --1:53
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Day Theme 7";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Day Theme 7", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_GeneralWalk_Day07.mp3", "83"); end; --1:23
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Day Theme 8";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Day Theme 8", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_GeneralWalk_Day08.mp3", "68"); end; --1:08
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Night Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Night Theme 1", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_GeneralWalk_Night01.mp3", "72"); end; --1:12
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Night Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Night Theme 2", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_GeneralWalk_Night02.mp3", "122"); end; --1:52
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Night Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Night Theme 3", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_GeneralWalk_Night03.mp3", "84"); end; --1:24
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Night Theme 4";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Night Theme 4", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_GeneralWalk_Night04.mp3", "66"); end; --1:06
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Night Theme 5";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Night Theme 5", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_GeneralWalk_Night05.mp3", "74"); end; --1:14
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Night Theme 6";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Night Theme 6", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_GeneralWalk_Night06.mp3", "98"); end; --1:38
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Night Theme 7";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Night Theme 7", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_GeneralWalk_Night07.mp3", "77"); end; --1:17
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Night Theme 8";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Night Theme 8", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_GeneralWalk_Night08.mp3", "110"); end; --1:50
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
      elseif(Selected_Zone == 34)then  
        info.text = "Coldarra Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Coldarra Theme 1", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_ColdarraWalkUni01.mp3", "63"); end; --1:03 sec
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Coldarra Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Coldarra Theme 2", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_ColdarraWalkUni02.mp3", "63"); end; --1:03 sec
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Coldarra Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Coldarra Theme 3", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_ColdarraWalkUni03.mp3", "120"); end; --2:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Geyser Field Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Geyser Field Theme 1", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_GeyserField_General01.mp3", "55"); end; --55
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Geyser Field Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Geyser Field Theme 2", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_GeyserField_General02.mp3", "45"); end; --45
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Geyser Field Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Geyser Field Theme 3", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_GeyserField_General03.mp3", "60"); end; --1:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Mountainous Intro Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Mountainous Intro Theme 1", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_Riplash_Intro01.mp3", "150"); end; --2:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Mountainous Intro Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Mountainous Intro Theme 2", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_Riplash_Intro02.mp3", "175"); end; --2:55
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Mountainous Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Mountainous Theme 1", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_Riplash_Day01.mp3", "146"); end; --2:26
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Mountainous Day Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Mountainous Day Theme 2", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_Riplash_Day02.mp3", "182"); end; --3:02
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Mountainous Day Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Mountainous Day Theme 3", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_Riplash_Day03.mp3", "159"); end; --2:39
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Mountainous Night Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Mountainous Night Theme 1", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_Riplash_Night01.mp3", "156"); end; --2:36
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Mountainous Night Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Mountainous Night Theme 2", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_Riplash_Night02.mp3", "78"); end; --1:18
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Mountainous Night Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Mountainous Night Theme 3", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_Riplash_Night03.mp3", "74"); end; --1:14
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Mountainous Night Theme 4";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Mountainous Night Theme 4", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_Riplash_Night04.mp3", "93"); end; --1:33
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Kaskala Day 1";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Kaskala Day 1", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_Tusk_KaskalaDay01.mp3", "95"); end; --1:35
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Kaskala Day 2";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Kaskala Day 2", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_Tusk_KaskalaDay02.mp3", "70"); end; --1:10
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Kaskala Night 1";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Kaskala Night 1", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_Tusk_KaskalaNight01.mp3", "91"); end; --1:31
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Borean Tundra - Kaskala Night 2";
        info.value = 0;
        info.func = function() ChooseSong("Borean Tundra - Kaskala Night 2", "Sound\\Music\\ZoneMusic\\BoreanTundra\\BO_Tusk_KaskalaNight02.mp3", "50"); end; --50
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
     elseif(Selected_Zone == 6)then
        info.text = "Nexus Normal Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Nexus Normal Theme 1", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusQuietWalkUni01.mp3", "107"); end; --1:47
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Nexus Normal Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Nexus Normal Theme 2", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusQuietWalkUni02.mp3", "107"); end; --1:47
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Nexus Normal Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Nexus Normal Theme 3", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusQuietWalkUni03.mp3", "53"); end; --53
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Nexus Normal Theme 4";
        info.value = 0;
        info.func = function() ChooseSong("Nexus Normal Theme 4", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusQuietWalkUni04.mp3", "67"); end; --1:07
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Nexus Battle 1";
        info.value = 0;
        info.func = function() ChooseSong("Nexus Battle 1", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusActionWalkUni01.mp3", "70"); end; --1:10
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Nexus Battle 2";
        info.value = 0;
        info.func = function() ChooseSong("Nexus Battle 2", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusActionWalkUni02.mp3", "60"); end; --1:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Nexus Battle 3";
        info.value = 0;
        info.func = function() ChooseSong("Nexus Battle 3", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusActionWalkUni03.mp3", "100"); end; --1:40
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Nexus Battle 4";
        info.value = 0;
        info.func = function() ChooseSong("Nexus Battle 4", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusActionWalkUni04.mp3", "105"); end; --1:45
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Nexus Battle 5";
        info.value = 0;
        info.func = function() ChooseSong("Nexus Battle 5", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusActionWalkUni05.mp3", "81"); end; --1:21
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Nexus Hail Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Nexus Hail Theme 1", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusHailWalkUni01.mp3", "55"); end; --55
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Nexus Hail Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Nexus Hail Theme 2", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusHailWalkUni02.mp3", "60"); end; --1:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Nexus Pulse Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Nexus Pulse Theme 1", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusPulseWalkUni01.mp3", "60"); end; --1:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Nexus Pulse Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Nexus Pulse Theme 2", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusPulseWalkUni02.mp3", "68"); end; --1:08
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);   
     elseif(Selected_Zone == 9)then
        info.text = "Dragonblight Intro 1";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight Intro 1", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_GeneralIntro_01.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight Intro 2";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight Intro 2", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_GeneralIntro_02.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight Intro 3";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight Intro 3", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_GeneralIntro_03.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight Intro 4";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight Intro 4", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_GeneralIntro_04.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Day Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Day Theme 1", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_GeneralWalk_Day01.mp3", "65"); end; --1:05
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Day Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Day Theme 2", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_GeneralWalk_Day02.mp3", "55"); end; --55
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Day Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Day Theme 3", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_GeneralWalk_Day03.mp3", "117"); end; --1:57
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Day Theme 4";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Day Theme 4", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_GeneralWalk_Day04.mp3", "75"); end; --1:15
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Day Theme 5";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Day Theme 5", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_GeneralWalk_Day05.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Day Theme 6";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Day Theme 6", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_GeneralWalk_Day06.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Day Theme 7";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Day Theme 7", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_GeneralWalk_Day07.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Day Theme 8";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Day Theme 8", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_GeneralWalk_Day08.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
      elseif(Selected_Zone == 35)then  
        info.text = "Dragonblight - Night Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Night Theme 1", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_GeneralWalk_Night01.mp3", "67"); end; --1:07
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Night Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Night Theme 2", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_GeneralWalk_Night02.mp3", "52"); end; --52
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Night Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Night Theme 3", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_GeneralWalk_Night03.mp3", "114"); end; --1:54
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Night Theme 4";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Night Theme 4", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_GeneralWalk_Night04.mp3", "74"); end; --1:14
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Night Theme 5";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Night Theme 5", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_GeneralWalk_Night05.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Night Theme 6";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Night Theme 6", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_GeneralWalk_Night06.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Night Theme 7";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Night Theme 7", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_GeneralWalk_Night07.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Night Theme 8";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Night Theme 8", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_GeneralWalk_Night08.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Indule Day 1";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Indule Day 1", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_Tusk_Indule_Day01.mp3", "126"); end; --2:06
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Indule Day 2";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Indule Day 2", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_Tusk_Indule_Day02.mp3", "60"); end; --1:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Indule Day 3";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Indule Day 3", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_Tusk_InduleDay01.mp3", "60"); end; --1:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Indule Day 4";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Indule Day 4", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_Tusk_InduleDay02.mp3", "60"); end; --1:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Indule Day 5";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Indule Day 5", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_Tusk_InduleDay03.mp3", "35"); end; --35
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Indule Night 1";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Indule Night 1", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_Tusk_InduleNight01.mp3", "130"); end; --2:10
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Indule Night 2";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Indule Night 2", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_Tusk_InduleNight02.mp3", "60"); end; --1:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Dragonblight - Indule Night 3";
        info.value = 0;
        info.func = function() ChooseSong("Dragonblight - Indule Night 3", "Sound\\Music\\ZoneMusic\\Dragonblight\\DB_Tusk_InduleNight03.mp3", "35"); end; --35
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
     elseif(Selected_Zone == 7)then
        info.text = "Obsidian Sanctum - Day Intro";
        info.value = 0;
        info.func = function() ChooseSong("Obsidian Sanctum - Day Intro", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsIntroADay01.mp3", "72"); end; --1:12
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Obsidian Sanctum - Night Intro";
        info.value = 0;
        info.func = function() ChooseSong("Obsidian Sanctum - Night Intro", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsIntroANight01.mp3", "72"); end; --1:12
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Obsidian Sanctum - Day 1";
        info.value = 0;
        info.func = function() ChooseSong("Obsidian Sanctum - Day 1", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsGeneralWalkADay01.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Obsidian Sanctum - Day 2";
        info.value = 0;
        info.func = function() ChooseSong("Obsidian Sanctum - Day 2", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsGeneralWalkADay02.mp3", "128"); end; --2:08
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Obsidian Sanctum - Day 3";
        info.value = 0;
        info.func = function() ChooseSong("Obsidian Sanctum - Day 3", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsGeneralWalkADay03.mp3", "72"); end; --1:12
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Obsidian Sanctum - Day 4";
        info.value = 0;
        info.func = function() ChooseSong("Obsidian Sanctum - Day 4", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsGeneralWalkADay04.mp3", "63"); end; --1:03
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Obsidian Sanctum - Night 1";
        info.value = 0;
        info.func = function() ChooseSong("Obsidian Sanctum - Night 1", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsGeneralWalkANight01.mp3", "88"); end; --1:28
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Obsidian Sanctum - Night 2";
        info.value = 0;
        info.func = function() ChooseSong("Obsidian Sanctum - Night 2", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsGeneralWalkANight02.mp3", "128"); end; --2:08
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Obsidian Sanctum - Night 3";
        info.value = 0;
        info.func = function() ChooseSong("Obsidian Sanctum - Night 3", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsGeneralWalkANight03.mp3", "73"); end; --1:13
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Obsidian Sanctum - Night 4";
        info.value = 0;
        info.func = function() ChooseSong("Obsidian Sanctum - Night 4", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsGeneralWalkANight04.mp3", "61"); end; --1:01
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Obsidian Sanctum - General 1";
        info.value = 0;
        info.func = function() ChooseSong("Obsidian Sanctum - General 1", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsGeneralWalkAUni01.mp3", "70"); end; --1:10
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Obsidian Sanctum - General 2";
        info.value = 0;
        info.func = function() ChooseSong("Obsidian Sanctum - General 2", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsGeneralWalkAUni01.mp3", "63"); end; --1:03
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
     elseif(Selected_Zone == 8)then
        info.text = "Azjol-Nerub Intro 1";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub Intro 1", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralIntro_01.mp3", "60"); end; --1:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub Intro 2";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub Intro 2", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralIntro_02.mp3", "97"); end; --1:37
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub Intro 3";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub Intro 3", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralIntro_03.mp3", "109"); end; --1:49
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub Intro 4";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub Intro 4", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralIntro_04.mp3", "62"); end; --1:02
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub Intro 5";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub Intro 5", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralIntro_05.mp3", "75"); end; --1:15
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub Intro 6";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub Intro 6", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralIntro_06.mp3", "105"); end; --1:45
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub Intro 7";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub Intro 7", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralIntro_07.mp3", "105"); end; --1:45
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub Intro 8";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub Intro 8", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralIntro_08.mp3", "102"); end; --1:42
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub General 1";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub General 1", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_01.mp3", "60"); end; --1:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub General 2";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub General 2", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_02.mp3", "97"); end; --1:37
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub General 3";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub General 3", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_03.mp3", "50"); end; --50
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub General 4";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub General 4", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_04.mp3", "62"); end; --1:02
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub General 5";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub General 5", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_05.mp3", "76"); end; --1:16
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub General 6";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub General 6", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_06.mp3", "103"); end; --1:43
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub General 7";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub General 7", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_07.mp3", "60"); end; --1:0
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub General 8";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub General 8", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_08.mp3", "60"); end; --1:0
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub General 9";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub General 9", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_09.mp3", "97"); end; --1:37
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub General 10";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub General 10", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_10.mp3", "97"); end; --1:37
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub General 11";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub General 11", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_11.mp3", "110"); end; --1:50
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub General 12";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub General 12", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_12.mp3", "110"); end; --1:50
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub General 13";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub General 13", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_13.mp3", "62"); end; --1:02
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub General 14";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub General 14", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_14.mp3", "62"); end; --1:02
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub General 15";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub General 15", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_15.mp3", "75"); end; --1:15
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Azjol-Nerub General 16";
        info.value = 0;
        info.func = function() ChooseSong("Azjol-Nerub General 16", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_16.mp3", "75"); end; --1:15
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
     elseif(Selected_Zone == 10)then
        info.text = "Grizzly Hills - Intro 1";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - Intro 1", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_Intro1Uni01.mp3", "275"); end; --4:35
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - Intro 2";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - Intro 2", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_Intro1Uni02.mp3", "140"); end; --2:20
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - Day Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - Day Theme 1", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_WalkDay01.mp3", "133"); end; --2:13
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - Day Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - Day Theme 2", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_WalkDay02.mp3", "128"); end; --2:08
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - Day Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - Day Theme 3", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_WalkDay03.mp3", "225"); end; --3:45
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - Day Theme 4";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - Day Theme 4", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_WalkDay04.mp3", "105"); end; --1:45
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - Day Theme 5";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - Day Theme 5", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_WalkDay05.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - Day Theme 6";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - Day Theme 6", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_WalkDay06.mp3", "145"); end; --2:25
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - Day Theme 7";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - Day Theme 7", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_WalkDay07.mp3", "150"); end; --2:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - Day Theme 8";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - Day Theme 8", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_WalkDay08.mp3", "85"); end; --1:25
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - Day Theme 9";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - Day Theme 9", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_WalkDay09.mp3", "85"); end; --1:25
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
      elseif(Selected_Zone == 36)then
        info.text = "Grizzly Hills - General Day Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - General Day Theme 1", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_GeneralWalk_A_Day01.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - General Day Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - General Day Theme 2", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_GeneralWalk_A_Day02.mp3", "140"); end; --2:20
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - General Day Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - General Day Theme 3", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_GeneralWalk_A_Day03.mp3", "85"); end; --1:25
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - General Day Theme 4";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - General Day Theme 4", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_GeneralWalk_A_Day04.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - General Day Theme 5";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - General Day Theme 5", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_GeneralWalk_B_Day01.mp3", "105"); end; --1:45
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - General Day Theme 6";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - General Day Theme 6", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_GeneralWalk_B_Day02.mp3", "105"); end; --1:45
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - Night Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - Night Theme 1", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_WalkNight01.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - Night Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - Night Theme 2", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_WalkNight02.mp3", "100"); end; --1:40
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - Night Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - Night Theme 3", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_WalkNight03.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - Night Theme 4";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - Night Theme 4", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_WalkNight04.mp3", "150"); end; --2:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - Night Theme 5";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - Night Theme 5", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_WalkNight05.mp3", "145"); end; --2:25
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - Night Theme 6";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - Night Theme 6", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_WalkNight06.mp3", "130"); end; --2:10
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - General Night Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - General Night Theme 1", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_GeneralWalk_A_Night01.mp3", "120"); end; --2:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - General Night Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - General Night Theme 2", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_GeneralWalk_A_Night02.mp3", "137"); end; --2:17
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - General Night Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - General Night Theme 3", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_GeneralWalk_B_Night01.mp3", "95"); end; --1:35
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - General Night Theme 4";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - General Night Theme 4", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_GeneralWalk_B_Night02.mp3", "115"); end; --1:55
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
     elseif(Selected_Zone == 11)then
        info.text = "Zul'Drak - General Intro 1";
        info.value = 0;
        info.func = function() ChooseSong("Zul'Drak - General Intro 1", "Sound\\Music\\ZoneMusic\\ZulDrak\\ZD_GeneralIntro_01.mp3", "98"); end; --1:38
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Zul'Drak - General Intro 2";
        info.value = 0;
        info.func = function() ChooseSong("Zul'Drak - General Intro 2", "Sound\\Music\\ZoneMusic\\ZulDrak\\ZD_GeneralIntro_02.mp3", "98"); end; --1:38
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Zul'Drak - General Intro 3";
        info.value = 0;
        info.func = function() ChooseSong("Zul'Drak - General Intro 3", "Sound\\Music\\ZoneMusic\\ZulDrak\\ZD_GeneralIntro_03.mp3", "125"); end; --2:05
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Zul'Drak - General Intro 4";
        info.value = 0;
        info.func = function() ChooseSong("Zul'Drak - General Intro 4", "Sound\\Music\\ZoneMusic\\ZulDrak\\ZD_GeneralIntro_04.mp3", "125"); end; --2:05
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Zul'Drak - General Intro 5";
        info.value = 0;
        info.func = function() ChooseSong("Zul'Drak - General Intro 5", "Sound\\Music\\ZoneMusic\\ZulDrak\\ZD_GeneralIntro_05.mp3", "125"); end; --2:05
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Zul'Drak - General Intro 6";
        info.value = 0;
        info.func = function() ChooseSong("Zul'Drak - General Intro 6", "Sound\\Music\\ZoneMusic\\ZulDrak\\ZD_GeneralIntro_05.mp3", "125"); end; --2:05
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Zul'Drak - General Day Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Zul'Drak - General Day Theme 1", "Sound\\Music\\ZoneMusic\\ZulDrak\\ZD_GeneralWalk_Day01.mp3", "88"); end; --1:28
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Zul'Drak - General Day Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Zul'Drak - General Day Theme 2", "Sound\\Music\\ZoneMusic\\ZulDrak\\ZD_GeneralWalk_Day02.mp3", "88"); end; --1:28
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Zul'Drak - General Day Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Zul'Drak - General Day Theme 3", "Sound\\Music\\ZoneMusic\\ZulDrak\\ZD_GeneralWalk_Day03.mp3", "101"); end; --1:41
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Zul'Drak - General Day Theme 4";
        info.value = 0;
        info.func = function() ChooseSong("Zul'Drak - General Day Theme 4", "Sound\\Music\\ZoneMusic\\ZulDrak\\ZD_GeneralWalk_Day04.mp3", "92"); end; --1:32
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Zul'Drak - General Night Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Zul'Drak - General Night Theme 1", "Sound\\Music\\ZoneMusic\\ZulDrak\\ZD_GeneralWalk_Night01.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Zul'Drak - General Night Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Zul'Drak - General Night Theme 2", "Sound\\Music\\ZoneMusic\\ZulDrak\\ZD_GeneralWalk_Night02.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Zul'Drak - General Night Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Zul'Drak - General Night Theme 3", "Sound\\Music\\ZoneMusic\\ZulDrak\\ZD_GeneralWalk_Night03.mp3", "100"); end; --1:40
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Zul'Drak - General Night Theme 4";
        info.value = 0;
        info.func = function() ChooseSong("Zul'Drak - General Night Theme 4", "Sound\\Music\\ZoneMusic\\ZulDrak\\ZD_GeneralWalk_Night04.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Harkoa Theme A";
        info.value = 0;
        info.func = function() ChooseSong("Harkoa Theme A", "Sound\\Music\\ZoneMusic\\ZulDrak\\ZD_HarKoa_Intro01.mp3", "25"); end; --25
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Harkoa Theme B";
        info.value = 0;
        info.func = function() ChooseSong("Harkoa Theme B", "Sound\\Music\\ZoneMusic\\ZulDrak\\ZD_HarKoa_Intro02.mp3", "25"); end; --25
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Mamtoth Theme A";
        info.value = 0;
        info.func = function() ChooseSong("Mamtoth Theme A", "Sound\\Music\\ZoneMusic\\ZulDrak\\ZD_MamToth_Intro01.mp3", "25"); end; --25
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Mamtoth Theme B";
        info.value = 0;
        info.func = function() ChooseSong("Mamtoth Theme B", "Sound\\Music\\ZoneMusic\\ZulDrak\\ZD_MamToth_Intro02.mp3", "25"); end; --25
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "QuetzLun Theme A";
        info.value = 0;
        info.func = function() ChooseSong("QuetzLun Theme A", "Sound\\Music\\ZoneMusic\\ZulDrak\\ZD_QuetzLun_Intro01.mp3", "25"); end; --25
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "QuetzLun Theme B";
        info.value = 0;
        info.func = function() ChooseSong("QuetzLun Theme B", "Sound\\Music\\ZoneMusic\\ZulDrak\\ZD_QuetzLun_Intro02.mp3", "25"); end; --25
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
     elseif(Selected_Zone == 14)then
        info.text = "Crystalsong Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Crystalsong Theme 1", "Sound\\Music\\ZoneMusic\\Crystalsong\\CS_CrystalsongWalkUni01.mp3", "105"); end; --1:45
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Crystalsong Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Crystalsong Theme 2", "Sound\\Music\\ZoneMusic\\Crystalsong\\CS_CrystalsongWalkUni02.mp3", "95"); end; --1:35
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Crystalsong Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Crystalsong Theme 3", "Sound\\Music\\ZoneMusic\\Crystalsong\\CS_CrystalsongWalkUni03.mp3", "60"); end; --1:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Crystalsong Theme 4";
        info.value = 0;
        info.func = function() ChooseSong("Crystalsong Theme 4", "Sound\\Music\\ZoneMusic\\Crystalsong\\CS_CrystalsongWalkUni04.mp3", "105"); end; --1:45
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Crystalsong Theme 5";
        info.value = 0;
        info.func = function() ChooseSong("Crystalsong Theme 5", "Sound\\Music\\ZoneMusic\\Crystalsong\\CS_CrystalsongWalkUni05.mp3", "98"); end; --1:38
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
     elseif(Selected_Zone == 15)then
        info.text = "Dalaran Intro";
        info.value = 0;
        info.func = function() ChooseSong("Dalaran Intro", "Sound\\Music\\ZoneMusic\\Dalaran\\DC_IntroUni01.mp3", "65"); end; --1:05
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The City of Dalaran 1";
        info.value = 0;
        info.func = function() ChooseSong("The City of Dalaran 1", "Sound\\Music\\ZoneMusic\\Dalaran\\DC_GeneralWalkUni01.mp3", "65"); end; --1:05
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The City of Dalaran 2";
        info.value = 0;
        info.func = function() ChooseSong("The City of Dalaran 2", "Sound\\Music\\ZoneMusic\\Dalaran\\DC_GeneralWalkUni02.mp3", "40"); end; --40
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The City of Dalaran 3";
        info.value = 0;
        info.func = function() ChooseSong("The City of Dalaran 3", "Sound\\Music\\ZoneMusic\\Dalaran\\DC_GeneralWalkUni03.mp3", "65"); end; --1:05
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The City of Dalaran 4";
        info.value = 0;
        info.func = function() ChooseSong("The City of Dalaran 4", "Sound\\Music\\ZoneMusic\\Dalaran\\DC_GeneralWalkUni04.mp3", "87"); end; --1:27
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Underbelly 1";
        info.value = 0;
        info.func = function() ChooseSong("The Underbelly 1", "Sound\\Music\\ZoneMusic\\Dalaran\\DC_SewerWalkUni01.mp3", "65"); end; --1:05
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Underbelly 2";
        info.value = 0;
        info.func = function() ChooseSong("The Underbelly 2", "Sound\\Music\\ZoneMusic\\Dalaran\\DC_SewerWalkUni02.mp3", "95"); end; --1:35
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Underbelly 3";
        info.value = 0;
        info.func = function() ChooseSong("The Underbelly 3", "Sound\\Music\\ZoneMusic\\Dalaran\\DC_SewerWalkUni03.mp3", "67"); end; --1:07
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Underbelly 4";
        info.value = 0;
        info.func = function() ChooseSong("The Underbelly 4", "Sound\\Music\\ZoneMusic\\Dalaran\\DC_SewerWalkUni04.mp3", "63"); end; --1:03
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Purple Parlor";
        info.value = 0;
        info.func = function() ChooseSong("The Purple Parlor", "Sound\\Music\\ZoneMusic\\Dalaran\\DC_SpireWalkUni01.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
     elseif(Selected_Zone == 22)then
        info.text = "Violet Hold Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Violet Hold Theme 1", "Sound\\Music\\ZoneMusic\\VioletHold\\VH_GeneralWalkUni01.mp3", "78"); end; --1:18
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Violet Hold Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Violet Hold Theme 2", "Sound\\Music\\ZoneMusic\\VioletHold\\VH_GeneralWalkUni02.mp3", "78"); end; --1:18
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Violet Hold Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Violet Hold Theme 3", "Sound\\Music\\ZoneMusic\\VioletHold\\VH_GeneralWalkUni03.mp3", "68"); end; --1:08
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
     elseif(Selected_Zone == 16)then
        info.text = "Sholazar Basin - Day 1";
        info.value = 0;
        info.func = function() ChooseSong("Sholazar Basin - Day 1", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_SholazarWalkDay01.mp3", "165"); end; --2:45
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Sholazar Basin - Day 2";
        info.value = 0;
        info.func = function() ChooseSong("Sholazar Basin - Day 2", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_SholazarWalkDay02.mp3", "105"); end; --1:45
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Sholazar Basin - Day 3";
        info.value = 0;
        info.func = function() ChooseSong("Sholazar Basin - Day 3", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_SholazarWalkDay03.mp3", "95"); end; --1:35
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Sholazar Basin - Day 4";
        info.value = 0;
        info.func = function() ChooseSong("Sholazar Basin - Day 4", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_SholazarWalkDay04.mp3", "100"); end; --1:40
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Sholazar Basin - Day 5";
        info.value = 0;
        info.func = function() ChooseSong("Sholazar Basin - Day 5", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_SholazarWalkDay05.mp3", "110"); end; --1:50
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Sholazar Basin - Day 6";
        info.value = 0;
        info.func = function() ChooseSong("Sholazar Basin - Day 6", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_SholazarWalkDay06.mp3", "125"); end; --2:05
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Sholazar Basin - Night 1";
        info.value = 0;
        info.func = function() ChooseSong("Sholazar Basin - Night 1", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_SholazarWalkNight01.mp3", "100"); end; --1:40
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Sholazar Basin - Night 2";
        info.value = 0;
        info.func = function() ChooseSong("Sholazar Basin - Night 2", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_SholazarWalkNight02.mp3", "120"); end; --2:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Sholazar Basin - Night 3";
        info.value = 0;
        info.func = function() ChooseSong("Sholazar Basin - Night 3", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_SholazarWalkNight03.mp3", "115"); end; --1:55
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Sholazar Basin - Night 4";
        info.value = 0;
        info.func = function() ChooseSong("Sholazar Basin - Night 4", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_SholazarWalkNight04.mp3", "80"); end; --1:20
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Sholazar Basin - Night 5";
        info.value = 0;
        info.func = function() ChooseSong("Sholazar Basin - Night 5", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_SholazarWalkNight05.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Sholazar Basin - Crystal Cave A";
        info.value = 0;
        info.func = function() ChooseSong("Sholazar Basin - Crystal Cave A", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_CrystalsWalkUni01.mp3", "120"); end; --2:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Sholazar Basin - Crystal Cave B";
        info.value = 0;
        info.func = function() ChooseSong("Sholazar Basin - Crystal Cave B", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_CrystalsWalkUni01.mp3", "125"); end; --2:05
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Sholazar Basin - Fire Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Sholazar Basin - Fire Theme 1", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_FireWalkUni01.mp3", "100"); end; --1:40
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Sholazar Basin - Fire Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Sholazar Basin - Fire Theme 2", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_FireWalkUni02.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Sholazar Basin - Fire Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Sholazar Basin - Fire Theme 3", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_FireWalkUni03.mp3", "55"); end; --55
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Sholazar Basin - Fire Theme 4";
        info.value = 0;
        info.func = function() ChooseSong("Sholazar Basin - Fire Theme 4", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_FireWalkUni04.mp3", "100"); end; --1:40
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Lifeblood Cavern A";
        info.value = 0;
        info.func = function() ChooseSong("Lifeblood Cavern A", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_LifebloodCaveWalkUni01.mp3", "77"); end; --1:17
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Lifeblood Cavern B";
        info.value = 0;
        info.func = function() ChooseSong("Lifeblood Cavern B", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_LifebloodCaveWalkUni02.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Lifeblood Cavern C";
        info.value = 0;
        info.func = function() ChooseSong("Lifeblood Cavern C", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_LifebloodCaveWalkUni03.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Maker's Terrace A";
        info.value = 0;
        info.func = function() ChooseSong("Maker's Terrace A", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_MakersTerraceWalkUni01.mp3", "75"); end; --1:15
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Maker's Terrace B";
        info.value = 0;
        info.func = function() ChooseSong("Maker's Terrace B", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_MakersTerraceWalkUni02.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Path of the Life Warden A";
        info.value = 0;
        info.func = function() ChooseSong("Path of the Life Warden A", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_PathofLifeWardenWalkUni01.mp3", "128"); end; --2:08
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Path of the Life Warden B";
        info.value = 0;
        info.func = function() ChooseSong("Path of the Life Warden B", "Sound\\Music\\ZoneMusic\\SholazarBasin\\SB_PathofLifeWardenWalkUni02.mp3", "155"); end; --2:35
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
     elseif(Selected_Zone == 17)then
        info.text = "Storm Peaks - Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Storm Peaks - Theme 1", "Sound\\Music\\ZoneMusic\\StormPeaks\\SP_GeneralWalkADark_Uni01.mp3", "117"); end; --1:57
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Storm Peaks - Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Storm Peaks - Theme 2", "Sound\\Music\\ZoneMusic\\StormPeaks\\SP_GeneralWalkB_Uni02.mp3", "82"); end; --1:22
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Storm Peaks - Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Storm Peaks - Theme 3", "Sound\\Music\\ZoneMusic\\StormPeaks\\SP_GeneralWalkC_Uni03.mp3", "56"); end; --56
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Storm Peaks - Theme 4";
        info.value = 0;
        info.func = function() ChooseSong("Storm Peaks - Theme 4", "Sound\\Music\\ZoneMusic\\StormPeaks\\SP_GeneralWalkD_Uni04.mp3", "53"); end; --53
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Storm Peaks - Theme 5";
        info.value = 0;
        info.func = function() ChooseSong("Storm Peaks - Theme 5", "Sound\\Music\\ZoneMusic\\StormPeaks\\SP_GeneralWalkE_Uni05.mp3", "80"); end; --1:20
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Storm Peaks - Day Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Storm Peaks - Day Theme 1", "Sound\\Music\\ZoneMusic\\StormPeaks\\SP_GeneralWalkA_Day01.mp3", "85"); end; --1:25
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Storm Peaks - Day Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Storm Peaks - Day Theme 2", "Sound\\Music\\ZoneMusic\\StormPeaks\\SP_GeneralWalkB_Day02.mp3", "80"); end; --1:20
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Storm Peaks - Day Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Storm Peaks - Day Theme 3", "Sound\\Music\\ZoneMusic\\StormPeaks\\SP_GeneralWalkC_Day03.mp3", "63"); end; --1:03
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Storm Peaks - Day Theme 4";
        info.value = 0;
        info.func = function() ChooseSong("Storm Peaks - Day Theme 4", "Sound\\Music\\ZoneMusic\\StormPeaks\\SP_GeneralWalkD_Day04.mp3", "53"); end; --53
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Storm Peaks - Day Theme 5";
        info.value = 0;
        info.func = function() ChooseSong("Storm Peaks - Day Theme 5", "Sound\\Music\\ZoneMusic\\StormPeaks\\SP_GeneralWalkE_Day05.mp3", "80"); end; --1:20
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Storm Peaks - Night Theme 1";
        info.value = 0;
        info.func = function() ChooseSong("Storm Peaks - Night Theme 1", "Sound\\Music\\ZoneMusic\\StormPeaks\\SP_GeneralWalkA_Night01.mp3", "85"); end; --1:25
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Storm Peaks - Night Theme 2";
        info.value = 0;
        info.func = function() ChooseSong("Storm Peaks - Night Theme 2", "Sound\\Music\\ZoneMusic\\StormPeaks\\SP_GeneralWalkB_Night02.mp3", "80"); end; --1:20
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Storm Peaks - Night Theme 3";
        info.value = 0;
        info.func = function() ChooseSong("Storm Peaks - Night Theme 3", "Sound\\Music\\ZoneMusic\\StormPeaks\\SP_GeneralWalkC_Night03.mp3", "57"); end; --57
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Storm Peaks - Night Theme 4";
        info.value = 0;
        info.func = function() ChooseSong("Storm Peaks - Night Theme 4", "Sound\\Music\\ZoneMusic\\StormPeaks\\SP_GeneralWalkD_Night04.mp3", "50"); end; --50
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Storm Peaks - Night Theme 5";
        info.value = 0;
        info.func = function() ChooseSong("Storm Peaks - Night Theme 5", "Sound\\Music\\ZoneMusic\\StormPeaks\\SP_GeneralWalkE_Night05.mp3", "72"); end; --1:12
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
     elseif(Selected_Zone == 18)then
        info.text = "Halls of Stone - Intro";
        info.value = 0;
        info.func = function() ChooseSong("Halls of Stone - Intro", "Sound\\Music\\ZoneMusic\\Ulduar\\UL_StoneIntro.mp3", "84"); end; --1:24
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Halls of Stone - Normal 1";
        info.value = 0;
        info.func = function() ChooseSong("Halls of Stone - Normal 1", "Sound\\Music\\ZoneMusic\\Ulduar\\UL_StoneGeneralWalk01.mp3", "38"); end; --38
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Halls of Stone - Normal 2";
        info.value = 0;
        info.func = function() ChooseSong("Halls of Stone - Normal 2", "Sound\\Music\\ZoneMusic\\Ulduar\\UL_StoneGeneralWalk02.mp3", "38"); end; --38
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Halls of Stone - Normal 3";
        info.value = 0;
        info.func = function() ChooseSong("Halls of Stone - Normal 3", "Sound\\Music\\ZoneMusic\\Ulduar\\UL_StoneGeneralWalk03.mp3", "32"); end; --32
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Halls of Stone - Battle";
        info.value = 0;
        info.func = function() ChooseSong("Halls of Stone - Battle", "Sound\\Music\\ZoneMusic\\Ulduar\\UL_StoneBattleWalk.mp3", "49"); end; --49
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Halls of Lightning - Intro";
        info.value = 0;
        info.func = function() ChooseSong("Halls of Lightning - Intro", "Sound\\Music\\ZoneMusic\\Ulduar\\UL_LightningIntro.mp3", "80"); end; --1:24
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Halls of Lightning 1";
        info.value = 0;
        info.func = function() ChooseSong("Halls of Lightning 1", "Sound\\Music\\ZoneMusic\\Ulduar\\UL_LightningGeneralWalk01.mp3", "33"); end; --33
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Halls of Lightning 2";
        info.value = 0;
        info.func = function() ChooseSong("Halls of Lightning 2", "Sound\\Music\\ZoneMusic\\Ulduar\\UL_LightningGeneralWalk01.mp3", "38"); end; --38
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Halls of Lightning 3";
        info.value = 0;
        info.func = function() ChooseSong("Halls of Lightning 3", "Sound\\Music\\ZoneMusic\\Ulduar\\UL_LightningGeneralWalk01.mp3", "33"); end; --33
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Halls of Lightning - Battle";
        info.value = 0;
        info.func = function() ChooseSong("Halls of Lightning - Battle", "Sound\\Music\\ZoneMusic\\Ulduar\\UL_LightningGeneralWalk01.mp3", "50"); end; --50
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
     elseif(Selected_Zone == 21)then
        info.text = "Icecrown Glacier - Intro 1";
        info.value = 0;
        info.func = function() ChooseSong("Icecrown Glacier - Intro 1", "Sound\\Music\\ZoneMusic\\IcecrownGlacier\\IC_GeneralIntro_01.mp3", "55"); end; --55
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Icecrown Glacier - Intro 2";
        info.value = 0;
        info.func = function() ChooseSong("Icecrown Glacier - Intro 2", "Sound\\Music\\ZoneMusic\\IcecrownGlacier\\IC_GeneralIntro_02.mp3", "55"); end; --55
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Icecrown Glacier - Intro 3";
        info.value = 0;
        info.func = function() ChooseSong("Icecrown Glacier - Intro 3", "Sound\\Music\\ZoneMusic\\IcecrownGlacier\\IC_GeneralIntro_03.mp3", "51"); end; --51
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Icecrown Glacier - Day 1";
        info.value = 0;
        info.func = function() ChooseSong("Icecrown Glacier - Day 1", "Sound\\Music\\ZoneMusic\\IcecrownGlacier\\IC_GeneralWalk_Day01.mp3", "73"); end; --1:13
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Icecrown Glacier - Day 2";
        info.value = 0;
        info.func = function() ChooseSong("Icecrown Glacier - Day 2", "Sound\\Music\\ZoneMusic\\IcecrownGlacier\\IC_GeneralWalk_Day02.mp3", "93"); end; --1:33
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Icecrown Glacier - Day 3";
        info.value = 0;
        info.func = function() ChooseSong("Icecrown Glacier - Day 3", "Sound\\Music\\ZoneMusic\\IcecrownGlacier\\IC_GeneralWalk_Day03.mp3", "60"); end; --1:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Icecrown Glacier - Day 4";
        info.value = 0;
        info.func = function() ChooseSong("Icecrown Glacier - Day 4", "Sound\\Music\\ZoneMusic\\IcecrownGlacier\\IC_GeneralWalk_Day04.mp3", "95"); end; --1:35
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Icecrown Glacier - Night 1";
        info.value = 0;
        info.func = function() ChooseSong("Icecrown Glacier - Night 1", "Sound\\Music\\ZoneMusic\\IcecrownGlacier\\IC_GeneralWalk_Night01.mp3", "95"); end; --1:35
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Icecrown Glacier - Night 2";
        info.value = 0;
        info.func = function() ChooseSong("Icecrown Glacier - Night 2", "Sound\\Music\\ZoneMusic\\IcecrownGlacier\\IC_GeneralWalk_Night02.mp3", "75"); end; --1:15
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Icecrown Glacier - Night 3";
        info.value = 0;
        info.func = function() ChooseSong("Icecrown Glacier - Night 3", "Sound\\Music\\ZoneMusic\\IcecrownGlacier\\IC_GeneralWalk_Night03.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Icecrown Glacier - Night 4";
        info.value = 0;
        info.func = function() ChooseSong("Icecrown Glacier - Night 4", "Sound\\Music\\ZoneMusic\\IcecrownGlacier\\IC_GeneralWalk_Night04.mp3", "60"); end; --1:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Icecrown Glacier - Night 5";
        info.value = 0;
        info.func = function() ChooseSong("Icecrown Glacier - Night 5", "Sound\\Music\\ZoneMusic\\IcecrownGlacier\\IC_GeneralWalk_Night05.mp3", "95"); end; --1:35
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
     elseif(Selected_Zone == 26)then
        info.text = "Acherus, the Ebon Hold (Part 1)";
        info.value = 0;
        info.func = function() ChooseSong("Acherus, the Ebon Hold (Part 1)", "Sound\\Music\\ZoneMusic\\Ebon Hold\\EH_GeneralWalkUni01.mp3", "80"); end; --1:20
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Acherus, the Ebon Hold (Part 2)";
        info.value = 0;
        info.func = function() ChooseSong("Acherus, the Ebon Hold (Part 2)", "Sound\\Music\\ZoneMusic\\Ebon Hold\\EH_GeneralWalkUni02.mp3", "75"); end; --1:15
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Acherus, the Ebon Hold (Part 3)";
        info.value = 0;
        info.func = function() ChooseSong("Acherus, the Ebon Hold (Part 3)", "Sound\\Music\\ZoneMusic\\Ebon Hold\\EH_GeneralWalkUni03.mp3", "79"); end; --1:19
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Acherus, the Ebon Hold - Assault! (Part 1)";
        info.value = 0;
        info.func = function() ChooseSong("Acherus, the Ebon Hold - Assault! (Part 1)", "Sound\\Music\\ZoneMusic\\Ebon Hold\\EH_AssaultUni01.mp3", "63"); end; --1:03
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Acherus, the Ebon Hold - Assault! (Part 2)";
        info.value = 0;
        info.func = function() ChooseSong("Acherus, the Ebon Hold - Assault! (Part 2)", "Sound\\Music\\ZoneMusic\\Ebon Hold\\EH_AssaultUni02.mp3", "68"); end; --1:08
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Acherus, the Ebon Hold - Assault! (Part 3)";
        info.value = 0;
        info.func = function() ChooseSong("Acherus, the Ebon Hold - Assault! (Part 3)", "Sound\\Music\\ZoneMusic\\Ebon Hold\\EH_AssaultUni03.mp3", "61"); end; --1:01
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Acherus, the Ebon Hold - Assault! (Part 4)";
        info.value = 0;
        info.func = function() ChooseSong("Acherus, the Ebon Hold - Assault! (Part 4)", "Sound\\Music\\ZoneMusic\\Ebon Hold\\EH_AssaultUni04.mp3", "66"); end; --1:06
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Acherus, the Ebon Hold - Assault! (Part 5)";
        info.value = 0;
        info.func = function() ChooseSong("Acherus, the Ebon Hold - Assault! (Part 5)", "Sound\\Music\\ZoneMusic\\Ebon Hold\\EH_AssaultUni05.mp3", "111"); end; --1:51
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Acherus, the Ebon Hold - Assault! (Part 6)";
        info.value = 0;
        info.func = function() ChooseSong("Acherus, the Ebon Hold - Assault! (Part 6)", "Sound\\Music\\ZoneMusic\\Ebon Hold\\EH_AssaultUni06.mp3", "85"); end; --1:25
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Acherus, the Ebon Hold - Assault! (Part 7)";
        info.value = 0;
        info.func = function() ChooseSong("Acherus, the Ebon Hold - Assault! (Part 7)", "Sound\\Music\\ZoneMusic\\Ebon Hold\\EH_AssaultUni07.mp3", "88"); end; --1:28
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
     elseif(Selected_Zone == 23)then
        info.text = "The Culling of Stratholme - Intro";
        info.value = 0;
        info.func = function() ChooseSong("The Culling of Stratholme - Intro", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastIntro.mp3", "31"); end; --31
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Culling of Stratholme";
        info.value = 0;
        info.func = function() ChooseSong("The Culling of Stratholme", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastWalkUni.mp3", "100"); end; --1:40
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Culling of Stratholme - Outdoors Intro";
        info.value = 0;
        info.func = function() ChooseSong("The Culling of Stratholme - Outdoors Intro", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastOutdoorsIntro.mp3", "36"); end; --36
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Culling of Stratholme - Outdoors 1";
        info.value = 0;
        info.func = function() ChooseSong("The Culling of Stratholme - Outdoors 1", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastOutdoorsWalkAUni.mp3", "31"); end; --31
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Culling of Stratholme - Outdoors 2";
        info.value = 0;
        info.func = function() ChooseSong("The Culling of Stratholme - Outdoors 2", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastOutdoorsWalkBUni.mp3", "36"); end; --36
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Culling of Stratholme - Outdoors Night 1";
        info.value = 0;
        info.func = function() ChooseSong("The Culling of Stratholme - Outdoors Night 1", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastOutdoorsWalkANight.mp3", "31"); end; --31
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Culling of Stratholme - Outdoors Night 2";
        info.value = 0;
        info.func = function() ChooseSong("The Culling of Stratholme - Outdoors Night 2", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastOutdoorsWalkBNight.mp3", "36"); end; --36
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Culling of Stratholme - Battle 1";
        info.value = 0;
        info.func = function() ChooseSong("The Culling of Stratholme - Battle 1", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastBattleWalk01.mp3", "93"); end; --1:33
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Culling of Stratholme - Battle 2";
        info.value = 0;
        info.func = function() ChooseSong("The Culling of Stratholme - Battle 2", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastBattleWalk02.mp3", "35"); end; --35
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Culling of Stratholme - Battle 3";
        info.value = 0;
        info.func = function() ChooseSong("The Culling of Stratholme - Battle 3", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastBattleWalk03.mp3", "35"); end; --35
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Culling of Stratholme - Indoors Intro";
        info.value = 0;
        info.func = function() ChooseSong("The Culling of Stratholme - Indoors Intro", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastIndoorsIntro.mp3", "96"); end; --1:36
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Culling of Stratholme - Alley Intro";
        info.value = 0;
        info.func = function() ChooseSong("The Culling of Stratholme - Alley Intro", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastAlleyIntro.mp3", "96"); end; --1:36
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Culling of Stratholme - Alley End";
        info.value = 0;
        info.func = function() ChooseSong("The Culling of Stratholme - Alley End", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastAlleyEnd.mp3", "27"); end; --27
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Culling of Stratholme - Malganis";
        info.value = 0;
        info.func = function() ChooseSong("The Culling of Stratholme - Malganis", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastMalGanis.mp3", "66"); end; --1:06
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Culling of Stratholme - Ending";
        info.value = 0;
        info.func = function() ChooseSong("The Culling of Stratholme - Ending", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastEndStinger.mp3", "27"); end; --27
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
     elseif(Selected_Zone == 24)then
        info.text = "Iron Dwarf - 01";
        info.value = 0;
        info.func = function() ChooseSong("Iron Dwarf - 01", "Sound\\Music\\ZoneMusic\\Northrend\\IronDwarf\\NR_Dwarf_GeneralWalkADark_Uni01.mp3", "111"); end; --1:51
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Iron Dwarf - 02";
        info.value = 0;
        info.func = function() ChooseSong("Iron Dwarf - 02", "Sound\\Music\\ZoneMusic\\Northrend\\IronDwarf\\NR_Dwarf_GeneralWalkB_Uni02.mp3", "160"); end; --2:40
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Iron Dwarf - 03";
        info.value = 0;
        info.func = function() ChooseSong("Iron Dwarf - 03", "Sound\\Music\\ZoneMusic\\Northrend\\IronDwarf\\NR_Dwarf_GeneralWalkC_Uni03.mp3", "41"); end; --41
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Iron Dwarf - 04";
        info.value = 0;
        info.func = function() ChooseSong("Iron Dwarf - 04", "Sound\\Music\\ZoneMusic\\Northrend\\IronDwarf\\NR_Dwarf_GeneralWalkCDark_Uni04.mp3", "80"); end; --1:20
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Iron Dwarf - 05";
        info.value = 0;
        info.func = function() ChooseSong("Iron Dwarf - 05", "Sound\\Music\\ZoneMusic\\Northrend\\IronDwarf\\NR_Dwarf_GeneralWalkDDark_Uni05.mp3", "67"); end; --1:07
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Iron Dwarf - Day 1";
        info.value = 0;
        info.func = function() ChooseSong("Iron Dwarf - Day 1", "Sound\\Music\\ZoneMusic\\Northrend\\IronDwarf\\NR_Dwarf_GeneralWalkA_Day01.mp3", "97"); end; --1:37
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Iron Dwarf - Day 2";
        info.value = 0;
        info.func = function() ChooseSong("Iron Dwarf - Day 2", "Sound\\Music\\ZoneMusic\\Northrend\\IronDwarf\\NR_Dwarf_GeneralWalkB_Day02.mp3", "93"); end; --1:33
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Iron Dwarf - Day 3";
        info.value = 0;
        info.func = function() ChooseSong("Iron Dwarf - Day 3", "Sound\\Music\\ZoneMusic\\Northrend\\IronDwarf\\NR_Dwarf_GeneralWalkC_Day03.mp3", "41"); end; --41
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Iron Dwarf - Day 4";
        info.value = 0;
        info.func = function() ChooseSong("Iron Dwarf - Day 4", "Sound\\Music\\ZoneMusic\\Northrend\\IronDwarf\\NR_Dwarf_GeneralWalkD_Day04.mp3", "45"); end; --45
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Iron Dwarf - Night 1";
        info.value = 0;
        info.func = function() ChooseSong("Iron Dwarf - Night 1", "Sound\\Music\\ZoneMusic\\Northrend\\IronDwarf\\NR_Dwarf_GeneralWalkA_Night01.mp3", "93"); end; --1:33
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Iron Dwarf - Night 2";
        info.value = 0;
        info.func = function() ChooseSong("Iron Dwarf - Night 2", "Sound\\Music\\ZoneMusic\\Northrend\\IronDwarf\\NR_Dwarf_GeneralWalkB_Night02.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Iron Dwarf - Night 3";
        info.value = 0;
        info.func = function() ChooseSong("Iron Dwarf - Night 3", "Sound\\Music\\ZoneMusic\\Northrend\\IronDwarf\\NR_Dwarf_GeneralWalkC_Night03.mp3", "41"); end; --41
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Iron Dwarf - Night 4";
        info.value = 0;
        info.func = function() ChooseSong("Iron Dwarf - Night 4", "Sound\\Music\\ZoneMusic\\Northrend\\IronDwarf\\NR_Dwarf_GeneralWalkD_Night04.mp3", "45"); end; --45
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
      --elseif(Selected_Zone == 33)then
        --trans
      --elseif(Selected_Zone == 30)then
        info.text = "Orc - Intro";
        info.value = 0;
        info.func = function() ChooseSong("Orc - Intro", "Sound\\Music\\ZoneMusic\\Northrend\\Orc\\NR_Orc_General_Intro01.mp3", "24"); end; --24
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Orc - Day 1";
        info.value = 0;
        info.func = function() ChooseSong("Orc - Day 1", "Sound\\Music\\ZoneMusic\\Northrend\\Orc\\NR_Orc_GeneralWalk_Day01.mp3", "20"); end; --20
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Orc - Day 2";
        info.value = 0;
        info.func = function() ChooseSong("Orc - Day 2", "Sound\\Music\\ZoneMusic\\Northrend\\Orc\\NR_Orc_GeneralWalk_Day02.mp3", "20"); end; --20
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Orc - Day 3";
        info.value = 0;
        info.func = function() ChooseSong("Orc - Day 3", "Sound\\Music\\ZoneMusic\\Northrend\\Orc\\NR_Orc_GeneralWalk_Day03.mp3", "20"); end; --20
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Orc - Day 4";
        info.value = 0;
        info.func = function() ChooseSong("Orc - Day 4", "Sound\\Music\\ZoneMusic\\Northrend\\Orc\\NR_Orc_GeneralWalk_Day4.mp3", "40"); end; --20
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Orc - Night 1";
        info.value = 0;
        info.func = function() ChooseSong("Orc - Night 1", "Sound\\Music\\ZoneMusic\\Northrend\\Orc\\NR_Orc_GeneralWalk_Night01.mp3", "75"); end; --1:15
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Orc - Night 2";
        info.value = 0;
        info.func = function() ChooseSong("Orc - Night 2", "Sound\\Music\\ZoneMusic\\Northrend\\Orc\\NR_Orc_GeneralWalk_Night02.mp3", "77"); end; --1:17
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Orc - Night 3";
        info.value = 0;
        info.func = function() ChooseSong("Orc - Night 3", "Sound\\Music\\ZoneMusic\\Northrend\\Orc\\NR_Orc_GeneralWalk_Night03.mp3", "78"); end; --1:18
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
      elseif(Selected_Zone == 31)then
        info.text = "Taunka 1";
        info.value = 0;
        info.func = function() ChooseSong("Taunka 1", "Sound\\Music\\ZoneMusic\\Northrend\\Taunka\\NR_Taunka_GeneralWalkA_Uni01.mp3", "120"); end; --2:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Taunka 2";
        info.value = 0;
        info.func = function() ChooseSong("Taunka 2", "Sound\\Music\\ZoneMusic\\Northrend\\Taunka\\NR_Taunka_GeneralWalkD_Uni02.mp3", "68"); end; --1:08
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Taunka 3";
        info.value = 0;
        info.func = function() ChooseSong("Taunka 3", "Sound\\Music\\ZoneMusic\\Northrend\\Taunka\\NR_Taunka_GeneralWalkE_Uni03.mp3", "70"); end; --1:10
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Taunka - Day 1";
        info.value = 0;
        info.func = function() ChooseSong("Taunka - Day 1", "Sound\\Music\\ZoneMusic\\Northrend\\Taunka\\NR_Taunka_GeneralWalkA_Day01.mp3", "120"); end; --2:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Taunka - Day 2";
        info.value = 0;
        info.func = function() ChooseSong("Taunka - Day 2", "Sound\\Music\\ZoneMusic\\Northrend\\Taunka\\NR_Taunka_GeneralWalkB_Day02.mp3", "120"); end; --2:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Taunka - Day 3";
        info.value = 0;
        info.func = function() ChooseSong("Taunka - Day 3", "Sound\\Music\\ZoneMusic\\Northrend\\Taunka\\NR_Taunka_GeneralWalkC_Day03.mp3", "105"); end; --1:45
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Taunka - Day 4";
        info.value = 0;
        info.func = function() ChooseSong("Taunka - Day 4", "Sound\\Music\\ZoneMusic\\Northrend\\Taunka\\NR_Taunka_GeneralWalkD_Day04.mp3", "68"); end; --1:08
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Taunka - Night 1";
        info.value = 0;
        info.func = function() ChooseSong("Taunka - Night 1", "Sound\\Music\\ZoneMusic\\Northrend\\Taunka\\NR_Taunka_GeneralWalkA_Night01.mp3", "110"); end; --1:50
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Taunka - Night 2";
        info.value = 0;
        info.func = function() ChooseSong("Taunka - Night 2", "Sound\\Music\\ZoneMusic\\Northrend\\Taunka\\NR_Taunka_GeneralWalkB_Night02.mp3", "120"); end; --2:00
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Taunka - Night 3";
        info.value = 0;
        info.func = function() ChooseSong("Taunka - Night 3", "Sound\\Music\\ZoneMusic\\Northrend\\Taunka\\NR_Taunka_GeneralWalkC_Night03.mp3", "105"); end; --1:45
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Taunka - Night 4";
        info.value = 0;
        info.func = function() ChooseSong("Taunka - Night 4", "Sound\\Music\\ZoneMusic\\Northrend\\Taunka\\NR_Taunka_GeneralWalkD_Night04.mp3", "67"); end; --1:07
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
      --elseif(Selected_Zone == 32)then
        info.text = "Troll 1";
        info.value = 0;
        info.func = function() ChooseSong("Troll 1", "Sound\\Music\\ZoneMusic\\Northrend\\Troll\\NR_Troll_General01.mp3", "45"); end; --45
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Troll 2";
        info.value = 0;
        info.func = function() ChooseSong("Troll 2", "Sound\\Music\\ZoneMusic\\Northrend\\Troll\\NR_Troll_General02.mp3", "50"); end; --50
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Troll 3";
        info.value = 0;
        info.func = function() ChooseSong("Troll 3", "Sound\\Music\\ZoneMusic\\Northrend\\Troll\\NR_Troll_General03.mp3", "36"); end; --36
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Troll 4";
        info.value = 0;
        info.func = function() ChooseSong("Troll 4", "Sound\\Music\\ZoneMusic\\Northrend\\Troll\\NR_Troll_General04.mp3", "38"); end; --38
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Northrend Transport - Day";
        info.value = 0;
        info.func = function() ChooseSong("Northrend Transport - Day", "Sound\\Music\\ZoneMusic\\Northrend\\NorthrendTransport\\NR_NorthrendTransportGeneralDay.mp3", "150"); end; --2:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Northrend Transport - Night";
        info.value = 0;
        info.func = function() ChooseSong("Northrend Transport - Night", "Sound\\Music\\ZoneMusic\\Northrend\\NorthrendTransport\\NR_NorthrendTransportGeneralNight.mp3", "90"); end; --1:30
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
     elseif(Selected_Zone == 25)then
        info.text = "Lake Wintergrasp (Part 1)";
        info.value = 0;
        info.func = function() ChooseSong("Lake Wintergrasp (Part 1)", "Sound\\Music\\ZoneMusic\\LakeWintergrasp\\WG_GeneralWalk_01.mp3", "91"); end; --1:31
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Lake Wintergrasp (Part 2)";
        info.value = 0;
        info.func = function() ChooseSong("Lake Wintergrasp (Part 2)", "Sound\\Music\\ZoneMusic\\LakeWintergrasp\\WG_GeneralWalk_02.mp3", "58"); end; --58
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Lake Wintergrasp (Part 3)";
        info.value = 0;
        info.func = function() ChooseSong("Lake Wintergrasp (Part 3)", "Sound\\Music\\ZoneMusic\\LakeWintergrasp\\WG_GeneralWalk_03.mp3", "91"); end; --1:31
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Lake Wintergrasp (Part 4)";
        info.value = 0;
        info.func = function() ChooseSong("Lake Wintergrasp (Part 4)", "Sound\\Music\\ZoneMusic\\LakeWintergrasp\\WG_GeneralWalk_04.mp3", "40"); end; --40
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Lake Wintergrasp (Part 5)";
        info.value = 0;
        info.func = function() ChooseSong("Lake Wintergrasp (Part 5)", "Sound\\Music\\ZoneMusic\\LakeWintergrasp\\WG_GeneralWalk_05.mp3", "55"); end; --55
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Battle for Lake Wintergrasp, Part 1";
        info.value = 0;
        info.func = function() ChooseSong("The Battle for Lake Wintergrasp, Part 1", "Sound\\Music\\ZoneMusic\\LakeWintergrasp\\WG_Contested_01.mp3", "40"); end; --40
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "The Battle for Lake Wintergrasp, Part 2";
        info.value = 0;
        info.func = function() ChooseSong("The Battle for Lake Wintergrasp, Part 2", "Sound\\Music\\ZoneMusic\\LakeWintergrasp\\WG_Contested_02.mp3", "91"); end; --1:31
        info.owner = this:GetParent();
        info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "The Battle for Lake Wintergrasp, Part 3";
			info.value = 0;
			info.func = function() ChooseSong("The Battle for Lake Wintergrasp, Part 3", "Sound\\Music\\ZoneMusic\\LakeWintergrasp\\WG_Contested_03.mp3", "55"); end; --55
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
		elseif(Selected_Zone == 40)then
			info.text = "Welcome to Ulduar - 1";
			info.value = 0;
			info.func = function() ChooseSong("Welcome to Ulduar - 1", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtIntro01.mp3", "10"); end; --10
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
		
			info.text = "Welcome to Ulduar - 2";
			info.value = 0;
			info.func = function() ChooseSong("Welcome to Ulduar - 2", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtIntro02.mp3", "10"); end; --10
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
		elseif(Selected_Zone == 42)then
			info.text = "Rank Up!!";
			info.value = 0;
			info.func = function() ChooseSong("Rank Up!!", "Sound\\Music\\ZoneMusic\\ArgentTournament\\AT_HeraldEvent.mp3", "10"); end; --10
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Joust Battle!";
			info.value = 0;
			info.func = function() ChooseSong("Joust Battle!", "Sound\\Music\\ZoneMusic\\ArgentTournament\\AT_JoustEvent.mp3", "120"); end; --2:00
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Tournament Grounds";
			info.value = 0;
			info.func = function() ChooseSong("Tournament Grounds", "Sound\\Music\\ZoneMusic\\ArgentTournament\\AT_Tourney03NightWalkUniWalk.mp3", "160"); end; --2:40
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Tournament Grounds - Day 1";
			info.value = 0;
			info.func = function() ChooseSong("Tournament Grounds - Day 1", "Sound\\Music\\ZoneMusic\\ArgentTournament\\AT_Tourney02DayWalk.mp3", "155"); end; --2:35
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Tournament Grounds - Day 2";
			info.value = 0;
			info.func = function() ChooseSong("Tournament Grounds - Day 2", "Sound\\Music\\ZoneMusic\\ArgentTournament\\AT_Tourney06DayWalk.mp3", "142"); end; --2:22
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Tournament Grounds - Day 3";
			info.value = 0;
			info.func = function() ChooseSong("Tournament Grounds - Day 3", "Sound\\Music\\ZoneMusic\\ArgentTournament\\AT_Tourney09DayWalk.mp3", "150"); end; --2:30
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Tournament Grounds - Day 4";
			info.value = 0;
			info.func = function() ChooseSong("Tournament Grounds - Day 4", "Sound\\Music\\ZoneMusic\\ArgentTournament\\AT_Tourney10DayWalk.mp3", "150"); end; --2:30
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Tournament Grounds - Night 1";
			info.value = 0;
			info.func = function() ChooseSong("Tournament Grounds - Night 1", "Sound\\Music\\ZoneMusic\\ArgentTournament\\AT_Tourney01NightWalk.mp3", "155"); end; --2:35
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Tournament Grounds - Night 2";
			info.value = 0;
			info.func = function() ChooseSong("Tournament Grounds - Night 2", "Sound\\Music\\ZoneMusic\\ArgentTournament\\AT_Tourney05NightWalk.mp3", "162"); end; --2:42
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Tournament Grounds - Night 3";
			info.value = 0;
			info.func = function() ChooseSong("Tournament Grounds - Night 3", "Sound\\Music\\ZoneMusic\\ArgentTournament\\AT_Tourney07NightWalk.mp3", "180"); end; --3:00
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Tournament Grounds - Night 4";
			info.value = 0;
			info.func = function() ChooseSong("Tournament Grounds - Night 4", "Sound\\Music\\ZoneMusic\\ArgentTournament\\AT_Tourney08NightWalk.mp3", "180"); end; --3:00
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
		end
	elseif(Selected_Game == 10)then
		if(Selected_Zone == 3)then
			info.text = "Utgarde Keep 1";
			info.value = 0;
			info.func = function() ChooseSong("Utgarde Keep 1", "Sound\\Music\\ZoneMusic\\Utgarde Keep\\UK_GeneralWalkUni01.mp3", "55"); end; --55 sec
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
        
			info.text = "Utgarde Keep 2";
			info.value = 0;
			info.func = function() ChooseSong("Utgarde Keep 2", "Sound\\Music\\ZoneMusic\\Utgarde Keep\\UK_GeneralWalkUni02.mp3", "52"); end; --52 sec
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Utgarde Keep 3";
			info.value = 0;
			info.func = function() ChooseSong("Utgarde Keep 3", "Sound\\Music\\ZoneMusic\\Utgarde Keep\\UK_GeneralWalkUni03.mp3", "54"); end; --54 sec
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Utgarde Keep 4";
			info.value = 0;
			info.func = function() ChooseSong("Utgarde Keep 4", "Sound\\Music\\ZoneMusic\\Utgarde Keep\\UK_GeneralWalkUni04.mp3", "26"); end; --26 sec
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Utgarde Keep 5";
			info.value = 0;
			info.func = function() ChooseSong("Utgarde Keep 5", "Sound\\Music\\ZoneMusic\\Utgarde Keep\\UK_GeneralWalkUni05.mp3", "30"); end; --30 sec
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Utgarde Keep - Normal A";
			info.value = 0;
			info.func = function() ChooseSong("Utgarde Keep - Normal A", "Sound\\Music\\ZoneMusic\\Utgarde Keep\\UK_QuietWalkUni01.mp3", "108"); end; --1:48 sec
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Utgarde Keep - Normal B";
			info.value = 0;
			info.func = function() ChooseSong("Utgarde Keep - Normal B", "Sound\\Music\\ZoneMusic\\Utgarde Keep\\UK_QuietWalkUni02.mp3", "107"); end; --1:47 sec
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);


		elseif(Selected_Zone == 6)then
			info.text = "Nexus Normal Theme 1";
			info.value = 0;
			info.func = function() ChooseSong("Nexus Normal Theme 1", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusQuietWalkUni01.mp3", "107"); end; --1:47
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Nexus Normal Theme 2";
			info.value = 0;
			info.func = function() ChooseSong("Nexus Normal Theme 2", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusQuietWalkUni02.mp3", "107"); end; --1:47
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Nexus Normal Theme 3";
			info.value = 0;
			info.func = function() ChooseSong("Nexus Normal Theme 3", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusQuietWalkUni03.mp3", "53"); end; --53
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Nexus Normal Theme 4";
			info.value = 0;
			info.func = function() ChooseSong("Nexus Normal Theme 4", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusQuietWalkUni04.mp3", "67"); end; --1:07
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Nexus Battle 1";
			info.value = 0;
			info.func = function() ChooseSong("Nexus Battle 1", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusActionWalkUni01.mp3", "70"); end; --1:10
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Nexus Battle 2";
			info.value = 0;
			info.func = function() ChooseSong("Nexus Battle 2", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusActionWalkUni02.mp3", "60"); end; --1:00
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Nexus Battle 3";
			info.value = 0;
			info.func = function() ChooseSong("Nexus Battle 3", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusActionWalkUni03.mp3", "100"); end; --1:40
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Nexus Battle 4";
			info.value = 0;
			info.func = function() ChooseSong("Nexus Battle 4", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusActionWalkUni04.mp3", "105"); end; --1:45
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Nexus Battle 5";
			info.value = 0;
			info.func = function() ChooseSong("Nexus Battle 5", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusActionWalkUni05.mp3", "81"); end; --1:21
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Nexus Hail Theme 1";
			info.value = 0;
			info.func = function() ChooseSong("Nexus Hail Theme 1", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusHailWalkUni01.mp3", "55"); end; --55
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Nexus Hail Theme 2";
			info.value = 0;
			info.func = function() ChooseSong("Nexus Hail Theme 2", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusHailWalkUni02.mp3", "60"); end; --1:00
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Nexus Pulse Theme 1";
			info.value = 0;
			info.func = function() ChooseSong("Nexus Pulse Theme 1", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusPulseWalkUni01.mp3", "60"); end; --1:00
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Nexus Pulse Theme 2";
			info.value = 0;
			info.func = function() ChooseSong("Nexus Pulse Theme 2", "Sound\\Music\\ZoneMusic\\Nexus\\NZ_NexusPulseWalkUni02.mp3", "68"); end; --1:08
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);   

		elseif(Selected_Zone == 8)then
			info.text = "Azjol-Nerub Intro 1";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub Intro 1", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralIntro_01.mp3", "60"); end; --1:00
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Azjol-Nerub Intro 2";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub Intro 2", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralIntro_02.mp3", "97"); end; --1:37
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Azjol-Nerub Intro 3";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub Intro 3", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralIntro_03.mp3", "109"); end; --1:49
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Azjol-Nerub Intro 4";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub Intro 4", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralIntro_04.mp3", "62"); end; --1:02
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Azjol-Nerub Intro 5";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub Intro 5", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralIntro_05.mp3", "75"); end; --1:15
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Azjol-Nerub Intro 6";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub Intro 6", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralIntro_06.mp3", "105"); end; --1:45
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Azjol-Nerub Intro 7";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub Intro 7", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralIntro_07.mp3", "105"); end; --1:45
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Azjol-Nerub Intro 8";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub Intro 8", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralIntro_08.mp3", "102"); end; --1:42
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Azjol-Nerub General 1";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub General 1", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_01.mp3", "60"); end; --1:00
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Azjol-Nerub General 2";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub General 2", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_02.mp3", "97"); end; --1:37
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Azjol-Nerub General 3";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub General 3", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_03.mp3", "50"); end; --50
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Azjol-Nerub General 4";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub General 4", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_04.mp3", "62"); end; --1:02
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Azjol-Nerub General 5";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub General 5", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_05.mp3", "76"); end; --1:16
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Azjol-Nerub General 6";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub General 6", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_06.mp3", "103"); end; --1:43
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Azjol-Nerub General 7";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub General 7", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_07.mp3", "60"); end; --1:0
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Azjol-Nerub General 8";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub General 8", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_08.mp3", "60"); end; --1:0
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Azjol-Nerub General 9";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub General 9", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_09.mp3", "97"); end; --1:37
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Azjol-Nerub General 10";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub General 10", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_10.mp3", "97"); end; --1:37
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Azjol-Nerub General 11";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub General 11", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_11.mp3", "110"); end; --1:50
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Azjol-Nerub General 12";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub General 12", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_12.mp3", "110"); end; --1:50
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Azjol-Nerub General 13";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub General 13", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_13.mp3", "62"); end; --1:02
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Azjol-Nerub General 14";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub General 14", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_14.mp3", "62"); end; --1:02
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Azjol-Nerub General 15";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub General 15", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_15.mp3", "75"); end; --1:15
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Azjol-Nerub General 16";
			info.value = 0;
			info.func = function() ChooseSong("Azjol-Nerub General 16", "Sound\\Music\\ZoneMusic\\AzjolNerub\\AN_GeneralWalk_16.mp3", "75"); end; --1:15
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);

		elseif(Selected_Zone == 22)then
			info.text = "Violet Hold Theme 1";
			info.value = 0;
			info.func = function() ChooseSong("Violet Hold Theme 1", "Sound\\Music\\ZoneMusic\\VioletHold\\VH_GeneralWalkUni01.mp3", "78"); end; --1:18
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Violet Hold Theme 2";
			info.value = 0;
			info.func = function() ChooseSong("Violet Hold Theme 2", "Sound\\Music\\ZoneMusic\\VioletHold\\VH_GeneralWalkUni02.mp3", "78"); end; --1:18
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Violet Hold Theme 3";
			info.value = 0;
			info.func = function() ChooseSong("Violet Hold Theme 3", "Sound\\Music\\ZoneMusic\\VioletHold\\VH_GeneralWalkUni03.mp3", "68"); end; --1:08
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);

		elseif(Selected_Zone == 18)then
			info.text = "Halls of Stone - Intro";
			info.value = 0;
			info.func = function() ChooseSong("Halls of Stone - Intro", "Sound\\Music\\ZoneMusic\\Ulduar\\UL_StoneIntro.mp3", "84"); end; --1:24
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Halls of Stone - Normal 1";
			info.value = 0;
			info.func = function() ChooseSong("Halls of Stone - Normal 1", "Sound\\Music\\ZoneMusic\\Ulduar\\UL_StoneGeneralWalk01.mp3", "38"); end; --38
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Halls of Stone - Normal 2";
			info.value = 0;
			info.func = function() ChooseSong("Halls of Stone - Normal 2", "Sound\\Music\\ZoneMusic\\Ulduar\\UL_StoneGeneralWalk02.mp3", "38"); end; --38
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Halls of Stone - Normal 3";
			info.value = 0;
			info.func = function() ChooseSong("Halls of Stone - Normal 3", "Sound\\Music\\ZoneMusic\\Ulduar\\UL_StoneGeneralWalk03.mp3", "32"); end; --32
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Halls of Stone - Battle";
			info.value = 0;
			info.func = function() ChooseSong("Halls of Stone - Battle", "Sound\\Music\\ZoneMusic\\Ulduar\\UL_StoneBattleWalk.mp3", "49"); end; --49
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Halls of Lightning - Intro";
			info.value = 0;
			info.func = function() ChooseSong("Halls of Lightning - Intro", "Sound\\Music\\ZoneMusic\\Ulduar\\UL_LightningIntro.mp3", "80"); end; --1:24
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Halls of Lightning 1";
			info.value = 0;
			info.func = function() ChooseSong("Halls of Lightning 1", "Sound\\Music\\ZoneMusic\\Ulduar\\UL_LightningGeneralWalk01.mp3", "33"); end; --33
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Halls of Lightning 2";
			info.value = 0;
			info.func = function() ChooseSong("Halls of Lightning 2", "Sound\\Music\\ZoneMusic\\Ulduar\\UL_LightningGeneralWalk01.mp3", "38"); end; --38
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Halls of Lightning 3";
			info.value = 0;
			info.func = function() ChooseSong("Halls of Lightning 3", "Sound\\Music\\ZoneMusic\\Ulduar\\UL_LightningGeneralWalk01.mp3", "33"); end; --33
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Halls of Lightning - Battle";
			info.value = 0;
			info.func = function() ChooseSong("Halls of Lightning - Battle", "Sound\\Music\\ZoneMusic\\Ulduar\\UL_LightningGeneralWalk01.mp3", "50"); end; --50
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);

		elseif(Selected_Zone == 23)then
			info.text = "The Culling of Stratholme - Intro";
			info.value = 0;
			info.func = function() ChooseSong("The Culling of Stratholme - Intro", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastIntro.mp3", "31"); end; --31
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "The Culling of Stratholme";
			info.value = 0;
			info.func = function() ChooseSong("The Culling of Stratholme", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastWalkUni.mp3", "100"); end; --1:40
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "The Culling of Stratholme - Outdoors Intro";
			info.value = 0;
			info.func = function() ChooseSong("The Culling of Stratholme - Outdoors Intro", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastOutdoorsIntro.mp3", "36"); end; --36
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "The Culling of Stratholme - Outdoors 1";
			info.value = 0;
			info.func = function() ChooseSong("The Culling of Stratholme - Outdoors 1", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastOutdoorsWalkAUni.mp3", "31"); end; --31
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "The Culling of Stratholme - Outdoors 2";
			info.value = 0;
			info.func = function() ChooseSong("The Culling of Stratholme - Outdoors 2", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastOutdoorsWalkBUni.mp3", "36"); end; --36
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "The Culling of Stratholme - Outdoors Night 1";
			info.value = 0;
			info.func = function() ChooseSong("The Culling of Stratholme - Outdoors Night 1", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastOutdoorsWalkANight.mp3", "31"); end; --31
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "The Culling of Stratholme - Outdoors Night 2";
			info.value = 0;
			info.func = function() ChooseSong("The Culling of Stratholme - Outdoors Night 2", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastOutdoorsWalkBNight.mp3", "36"); end; --36
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "The Culling of Stratholme - Battle 1";
			info.value = 0;
			info.func = function() ChooseSong("The Culling of Stratholme - Battle 1", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastBattleWalk01.mp3", "93"); end; --1:33
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "The Culling of Stratholme - Battle 2";
			info.value = 0;
			info.func = function() ChooseSong("The Culling of Stratholme - Battle 2", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastBattleWalk02.mp3", "35"); end; --35
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "The Culling of Stratholme - Battle 3";
			info.value = 0;
			info.func = function() ChooseSong("The Culling of Stratholme - Battle 3", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastBattleWalk03.mp3", "35"); end; --35
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "The Culling of Stratholme - Indoors Intro";
			info.value = 0;
			info.func = function() ChooseSong("The Culling of Stratholme - Indoors Intro", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastIndoorsIntro.mp3", "96"); end; --1:36
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "The Culling of Stratholme - Alley Intro";
			info.value = 0;
			info.func = function() ChooseSong("The Culling of Stratholme - Alley Intro", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastAlleyIntro.mp3", "96"); end; --1:36
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "The Culling of Stratholme - Alley End";
			info.value = 0;
			info.func = function() ChooseSong("The Culling of Stratholme - Alley End", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastAlleyEnd.mp3", "27"); end; --27
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "The Culling of Stratholme - Malganis";
			info.value = 0;
			info.func = function() ChooseSong("The Culling of Stratholme - Malganis", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastMalGanis.mp3", "66"); end; --1:06
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "The Culling of Stratholme - Ending";
			info.value = 0;
			info.func = function() ChooseSong("The Culling of Stratholme - Ending", "Sound\\Music\\ZoneMusic\\StratholmePast\\CT_StratholmePastEndStinger.mp3", "27"); end; --27
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
		end
	elseif(Selected_Game == 11)then
		if(Selected_Zone == 7)then
			info.text = "Obsidian Sanctum - Day Intro";
			info.value = 0;
			info.func = function() ChooseSong("Obsidian Sanctum - Day Intro", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsIntroADay01.mp3", "72"); end; --1:12
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Obsidian Sanctum - Night Intro";
			info.value = 0;
			info.func = function() ChooseSong("Obsidian Sanctum - Night Intro", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsIntroANight01.mp3", "72"); end; --1:12
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Obsidian Sanctum - Day 1";
			info.value = 0;
			info.func = function() ChooseSong("Obsidian Sanctum - Day 1", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsGeneralWalkADay01.mp3", "90"); end; --1:30
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Obsidian Sanctum - Day 2";
			info.value = 0;
			info.func = function() ChooseSong("Obsidian Sanctum - Day 2", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsGeneralWalkADay02.mp3", "128"); end; --2:08
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Obsidian Sanctum - Day 3";
			info.value = 0;
			info.func = function() ChooseSong("Obsidian Sanctum - Day 3", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsGeneralWalkADay03.mp3", "72"); end; --1:12
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Obsidian Sanctum - Day 4";
			info.value = 0;
			info.func = function() ChooseSong("Obsidian Sanctum - Day 4", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsGeneralWalkADay04.mp3", "63"); end; --1:03
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Obsidian Sanctum - Night 1";
			info.value = 0;
			info.func = function() ChooseSong("Obsidian Sanctum - Night 1", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsGeneralWalkANight01.mp3", "88"); end; --1:28
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Obsidian Sanctum - Night 2";
			info.value = 0;
			info.func = function() ChooseSong("Obsidian Sanctum - Night 2", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsGeneralWalkANight02.mp3", "128"); end; --2:08
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Obsidian Sanctum - Night 3";
			info.value = 0;
			info.func = function() ChooseSong("Obsidian Sanctum - Night 3", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsGeneralWalkANight03.mp3", "73"); end; --1:13
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Obsidian Sanctum - Night 4";
			info.value = 0;
			info.func = function() ChooseSong("Obsidian Sanctum - Night 4", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsGeneralWalkANight04.mp3", "61"); end; --1:01
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Obsidian Sanctum - General 1";
			info.value = 0;
			info.func = function() ChooseSong("Obsidian Sanctum - General 1", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsGeneralWalkAUni01.mp3", "70"); end; --1:10
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
        
			info.text = "Obsidian Sanctum - General 2";
			info.value = 0;
			info.func = function() ChooseSong("Obsidian Sanctum - General 2", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsGeneralWalkAUni01.mp3", "63"); end; --1:03
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
		elseif(Selected_Zone == 45)then -- Ulduar, Welcome
			info.text = "Welcome to Ulduar - 1";
			info.value = 0;
			info.func = function() ChooseSong("Welcome to Ulduar - 1", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtIntro01.mp3", "10"); end; --10
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
		
			info.text = "Welcome to Ulduar - 2";
			info.value = 0;
			info.func = function() ChooseSong("Welcome to Ulduar - 2", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtIntro02.mp3", "10"); end; --10
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Welcome to Ulduar - 3";
			info.func = function() ChooseSong("Welcome to Ulduar - 3", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtIntro03.mp3", "10"); end; --10
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Welcome to Ulduar - 4";
			info.value = 0;
			info.func = function() ChooseSong("Welcome to Ulduar - 4", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtIntro04.mp3", "13"); end; --13
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Welcome to Ulduar - 5";
			info.value = 0;
			info.func = function() ChooseSong("Welcome to Ulduar - 5", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtIntro05.mp3", "10"); end; --10
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Welcome to Ulduar - 6";
			info.value = 0;
			info.func = function() ChooseSong("Welcome to Ulduar - 6", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtIntro06.mp3", "10"); end; --10
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Welcome to Ulduar - 7";
			info.value = 0;
			info.func = function() ChooseSong("Welcome to Ulduar - 7", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtIntro07.mp3", "10"); end; --10
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Welcome to Ulduar - 8";
			info.value = 0;
			info.func = function() ChooseSong("Welcome to Ulduar - 8", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtIntro08.mp3", "23"); end; --23
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Welcome to Ulduar - 9";
			info.value = 0;
			info.func = function() ChooseSong("Welcome to Ulduar - 9", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtIntro09.mp3", "23"); end; --23
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Expedition Base Camp 1";
			info.value = 0;
			info.func = function() ChooseSong("Expedition Base Camp 1", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtWalk01.mp3", "30"); end; --30
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Expedition Base Camp 2";
			info.value = 0;
			info.func = function() ChooseSong("Expedition Base Camp 2", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtWalk02.mp3", "30"); end; --30
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Expedition Base Camp 3";
			info.value = 0;
			info.func = function() ChooseSong("Expedition Base Camp 3", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtWalk03.mp3", "85"); end; --1:25
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Expedition Base Camp 4";
			info.value = 0;
			info.func = function() ChooseSong("Expedition Base Camp 4", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtWalk04.mp3", "85"); end; --1:25
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
		elseif(Selected_Zone == 40)then -- Ulduar, Exterior
			info.text = "Exterior Battle 1";
			info.value = 0;
			info.func = function() ChooseSong("Exterior Battle 1", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtAction01.mp3", "30"); end; --30
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Exterior Battle 2";
			info.value = 0;
			info.func = function() ChooseSong("Exterior Battle 2", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtAction12.mp3", "25"); end; --25
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Exterior Battle 3";
			info.value = 0;
			info.func = function() ChooseSong("Exterior Battle 3", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtAction13.mp3", "25"); end; --25
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Exterior Battle 4";
			info.value = 0;
			info.func = function() ChooseSong("Exterior Battle 4", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtAction14.mp3", "30"); end; --30
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Exterior Battle 5";
			info.value = 0;
			info.func = function() ChooseSong("Exterior Battle 5", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtAction16.mp3", "33"); end; --33
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Gauntlet 1";
			info.value = 0;
			info.func = function() ChooseSong("Gauntlet 1", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtAction02.mp3", "135"); end; --2:15
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Gauntlet 2";
			info.value = 0;
			info.func = function() ChooseSong("Gauntlet 2", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtAction03.mp3", "135"); end; --2:15
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Gauntlet 3";
			info.value = 0;
			info.func = function() ChooseSong("Gauntlet 3", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtAction04.mp3", "50"); end; --50
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Formation Grounds 1";
			info.value = 0;
			info.func = function() ChooseSong("Formation Grounds 1", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtWalk05.mp3", "85"); end; --1:25
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Formation Grounds 2";
			info.value = 0;
			info.func = function() ChooseSong("Formation Grounds 2", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtWalk06.mp3", "25"); end; --25
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Razorscale's Aerie 1";
			info.value = 0;
			info.func = function() ChooseSong("Razorscale's Aerie 1", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtWalk07.mp3", "55"); end; --55
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Razorscale's Aerie 2";
			info.value = 0;
			info.func = function() ChooseSong("Razorscale's Aerie 2", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtWalk08.mp3", "50"); end; --50
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Razorscale 1";
			info.value = 0;
			info.func = function() ChooseSong("Razorscale 1", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtAction05.mp3", "90"); end; --1:30
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Razorscale 2";
			info.value = 0;
			info.func = function() ChooseSong("Razorscale 2", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtAction06.mp3", "90"); end; --1:30
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "The Great Furnace 1";
			info.value = 0;
			info.func = function() ChooseSong("The Great Furnace 1", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtWalk09.mp3", "25"); end; --25
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "The Great Furnace 2";
			info.value = 0;
			info.func = function() ChooseSong("The Great Furnace 2", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtWalk10.mp3", "25"); end; --25
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Ignis 1";
			info.value = 0;
			info.func = function() ChooseSong("Ignis 1", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtAction07.mp3", "35"); end; --35
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Ignis 2";
			info.value = 0;
			info.func = function() ChooseSong("Ignis 2", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtAction08.mp3", "35"); end; --35
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Gates of Ulduar";
			info.value = 0;
			info.func = function() ChooseSong("Gates of Ulduar", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtWalk11.mp3", "25"); end; --25
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Deconstructor 1";
			info.value = 0;
			info.func = function() ChooseSong("Deconstructor 1", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtAction09.mp3", "25"); end; --25
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Deconstructor 2";
			info.value = 0;
			info.func = function() ChooseSong("Deconstructor 3", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtAction10.mp3", "25"); end; --25
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Deconstructor 3";
			info.value = 0;
			info.func = function() ChooseSong("Deconstructor 3", "Sound\\Music\\ZoneMusic\\UlduarRaidExt\\UR_UlduarRaidExtAction11.mp3", "25"); end; --25
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
		elseif(Selected_Zone == 41)then --Ulduar, Interior
			info.text = "Ulduar Tone Walk";
			info.value = 0;
			info.func = function() ChooseSong("Ulduar Tone Walk", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_UlduarToneWalk.mp3", "90"); end; --1:30
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Halls Instrumental";
			info.value = 0;
			info.func = function() ChooseSong("Halls Instrumental", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_HallsInstrumentalWalk.mp3", "110"); end; --1:50
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Halls Past";
			info.value = 0;
			info.func = function() ChooseSong("Halls Past", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_HallsPastWalk.mp3", "110"); end; --1:50
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Titan Halls";
			info.value = 0;
			info.func = function() ChooseSong("Titan Halls", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_TitanHallsHeroWalk.mp3", "105"); end; --1:45
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Titan Intro";
			info.value = 0;
			info.func = function() ChooseSong("Titan Intro", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_TitanOrchestraIntro.mp3", "95"); end; --1:35
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Titan Ghosts Walk";
			info.value = 0;
			info.func = function() ChooseSong("Titan Ghosts Walk", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_TitanGhostsWalk.mp3", "105"); end; --1:45
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Four Sigils Intro";
			info.value = 0;
			info.func = function() ChooseSong("Four Sigils Intro", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_FourSigilsHeroIntro.mp3", "215"); end; --3:35
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Four Sigils Hall";
			info.value = 0;
			info.func = function() ChooseSong("Four Sigils Hall", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_FourSigilsHallWalk.mp3", "118"); end; --1:58
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Sigil Ghosts Walk";
			info.value = 0;
			info.func = function() ChooseSong("Sigil Ghosts Walk", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_SigilGhostsWalk.mp3", "60"); end; --1:00
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Titan Sigils";
			info.value = 0;
			info.func = function() ChooseSong("Titan Sigils", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_TitanSigilsWalk.mp3", "55"); end; --55
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Halls of Iron Event";
			info.value = 0;
			info.func = function() ChooseSong("Halls of Iron Event", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_HallsofIronHeroEvent.mp3", "185"); end; --3:05
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Mimiron Intro";
			info.value = 0;
			info.func = function() ChooseSong("Mimiron Intro", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_MimironHeroIntro.mp3", "165"); end; --2:45
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Mimiron 1";
			info.value = 0;
			info.func = function() ChooseSong("Mimiron 1", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_MimironBWalk.mp3", "165"); end; --2:45
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Mimiron 2";
			info.value = 0;
			info.func = function() ChooseSong("Mimiron 2", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_MimironCWalk.mp3", "95"); end; --1:35
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Mimiron 3";
			info.value = 0;
			info.func = function() ChooseSong("Mimiron 3", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_MimironDWalk.mp3", "95"); end; --1:35
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Mimiron 4";
			info.value = 0;
			info.func = function() ChooseSong("Mimiron 4", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_MimironEWalk.mp3", "80"); end; --1:20
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Mimiron 5";
			info.value = 0;
			info.func = function() ChooseSong("Mimiron 5", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_MimironFWalk.mp3", "170"); end; --2:50
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Mimiron Ghosts Walk";
			info.value = 0;
			info.func = function() ChooseSong("Mimiron Ghosts Walk", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_MimironGhostsWalk.mp3", "170"); end; --2:50
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Titan Mech";
			info.value = 0;
			info.func = function() ChooseSong("Titan Mech", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_TitanMechWalk.mp3", "120"); end; --2:00
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Yogg-Saron Intro";
			info.value = 0;
			info.func = function() ChooseSong("Yogg-Saron Intro", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_YoggSaronHeroIntro.mp3", "100"); end; --1:40
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Prison of Yogg-Saron";
			info.value = 0;
			info.func = function() ChooseSong("Prison of Yogg-Saron", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_YoggLiteWalk.mp3", "100"); end; --1:40
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Prison of Yogg-Saron B";
			info.value = 0;
			info.func = function() ChooseSong("Prison of Yogg-Saron B", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_YoggWoodsWalk.mp3", "80"); end; --1:20
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Titan Yogg";
			info.value = 0;
			info.func = function() ChooseSong("Titan Yogg", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_TitanYoggWalk.mp3", "90"); end; --1:30
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
		elseif(Selected_Zone == 44)then --Ulduar:Algalon
			info.text = "The Planetary Hall";
			info.value = 0;
			info.func = function() ChooseSong("The Planetary Hall", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_AlgalonPlanetaryHallWalk.mp3", "140"); end; --2:20
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "Algalon Intro";
			info.value = 0;
			info.func = function() ChooseSong("Algalon Intro", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_AlgalonHeroIntro.mp3", "145"); end; --2:25
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "In the Presence of Algalon";
			info.value = 0;
			info.func = function() ChooseSong("In the Presence of Algalon", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_AlgalonVoicesWalk.mp3", "145"); end; --2:25
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "The Observatory 1";
			info.value = 0;
			info.func = function() ChooseSong("The Observatory 1", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_AlgalonBattle01Walk.mp3", "160"); end; --2:40
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
			
			info.text = "The Observatory 2";
			info.value = 0;
			info.func = function() ChooseSong("The Observatory 2", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_AlgalonBattle02Walk.mp3", "120"); end; --2:00
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
			UIDropDownMenu_AddButton(info, level);
		elseif(Selected_Zone == 43)then --Naxxramas
		end
	elseif(Selected_Game == 3)then
        info.text = "Acherus, the Ebon Hold (Part 1)";
        info.value = 0;
        info.func = function() ChooseSong("Acherus, the Ebon Hold (Part 1)", "Sound\\Music\\ZoneMusic\\Ebon Hold\\EH_GeneralWalkUni01.mp3", "80"); end; --1:20
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Grizzly Hills - Intro 1";
        info.value = 0;
        info.func = function() ChooseSong("Grizzly Hills - Intro 1", "Sound\\Music\\ZoneMusic\\GrizzlyHills\\GH_Intro1Uni01.mp3", "275"); end; --4:35
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
        info.text = "Obsidian Sanctum - Day Intro";
        info.value = 0;
        info.func = function() ChooseSong("Obsidian Sanctum - Day Intro", "Sound\\Music\\ZoneMusic\\ChamberOfTheAspects\\CA_AspectsIntroADay01.mp3", "72"); end; --1:12
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
        UIDropDownMenu_AddButton(info, level);
        
		info.text = "Taunka 3";
		info.value = 0;
		info.func = function() ChooseSong("Taunka 3", "Sound\\Music\\ZoneMusic\\Northrend\\Taunka\\NR_Taunka_GeneralWalkE_Uni03.mp3", "70"); end; --1:10
		info.owner = this:GetParent();
		info.checked = nil;
		info.icon = nil;
		UIDropDownMenu_AddButton(info, level);
        
		info.text = "Prince Malchezar 3";
		info.value = 0;
		info.func = function() ChooseSong("Prince Malchezar 3", "Sound\\Music\\ZoneMusic\\Karazhan\\KA_MalchezarWalkUni03.mp3", "113"); end; --1:53
		info.owner = this:GetParent();
		info.checked = nil;
		info.icon = nil;
		UIDropDownMenu_AddButton(info, level);
		
		info.text = "Halls of Iron Event";
		info.value = 0;
		info.func = function() ChooseSong("Halls of Iron Event", "Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_HallsofIronHeroEvent.mp3", "185"); end; --3:05
		info.owner = this:GetParent();
		info.checked = nil;
		info.icon = nil;
		UIDropDownMenu_AddButton(info, level);
	elseif(Selected_Game == 4)then
			PL_TotalIDs = #(PlayListsTable);
			local info = UIDropDownMenu_CreateInfo();
			info.owner = this:GetParent();
			info.checked = nil;
			info.icon = nil;
 
        for index,value in ipairs(PlayListsTable) do 
            local id, name = strsplit("\a", value)

            info.text = name;
            info.value = id;
            info.func = function() ChoosePlayList(id) end;
            UIDropDownMenu_AddButton(info, level);
        end
    elseif(Selected_Game == 5)then
		level = level or 1 --drop down menus can have sub menus. The value of "level" determines the drop down sub menu tier.
        Custom_TotalIDs = #(CustomTable);
        local info = UIDropDownMenu_CreateInfo();
        info.owner = this:GetParent();
        info.checked = nil;
        info.icon = nil;
 
        for index,value in ipairs(CustomTable) do 
            local id, name, length, file = strsplit("\a", value)

            info.text = name;
            info.value = id;
            info.func = function() ChooseCustomSong(id); end;
            UIDropDownMenu_AddButton(info, level);
        end
    end
end




function DDZoneItem_OnClick()
	UIDropDownMenu_SetSelectedValue(this.owner, this.value);
	Selected_Zone = this.value;
    DDZone:Show();
end


function DDBackground_Initialise()
 level = level or 1
 local info = UIDropDownMenu_CreateInfo();
 
 info.text = "No Background";
 info.value = 11;
 info.func = function() DDBackgroundItem_OnClick() end;
 info.owner = this:GetParent(); 
 info.checked = nil;
 info.icon = nil; 
 UIDropDownMenu_AddButton(info, level);
 
 info.text = "World of Warcraft";
 info.value = 0; 
 info.func = function() DDBackgroundItem_OnClick() end; 
 info.owner = this:GetParent(); 
 info.checked = nil; 
 info.icon = nil; 
 UIDropDownMenu_AddButton(info, level); 


 info.text = "Burning Crusade";
 info.value = 1;
 info.func = function() DDBackgroundItem_OnClick() end;
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 UIDropDownMenu_AddButton(info, level);
 
 info.text = "Wrath of the Lich King";
 info.value = 2;
 info.func = function() DDBackgroundItem_OnClick() end;
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 UIDropDownMenu_AddButton(info, level);
 
 info.text = "Human";
 info.value = 3;
 info.func = function() DDBackgroundItem_OnClick() end;
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 UIDropDownMenu_AddButton(info, level);
 
 info.text = "Dwarf & Gnome";
 info.value = 4;
 info.func = function() DDBackgroundItem_OnClick() end;
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 UIDropDownMenu_AddButton(info, level);
 
 info.text = "Night Elf";
 info.value = 5;
 info.func = function() DDBackgroundItem_OnClick() end;
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 UIDropDownMenu_AddButton(info, level);
 
 info.text = "Draenei";
 info.value = 6;
 info.func = function() DDBackgroundItem_OnClick() end;
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 UIDropDownMenu_AddButton(info, level);
 
 info.text = "Orc & Troll";
 info.value = 7;
 info.func = function() DDBackgroundItem_OnClick() end;
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 UIDropDownMenu_AddButton(info, level);
 
 info.text = "Undead";
 info.value = 8;
 info.func = function() DDBackgroundItem_OnClick() end;
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 UIDropDownMenu_AddButton(info, level);
 
 info.text = "Tauren";
 info.value = 9;
 info.func = function() DDBackgroundItem_OnClick() end;
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 UIDropDownMenu_AddButton(info, level);
 
 info.text = "Blood Elf";
 info.value = 10;
 info.func = function() DDBackgroundItem_OnClick() end;
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 UIDropDownMenu_AddButton(info, level);
 
  info.text = "Death Knight";
 info.value = 12;
 info.func = function() DDBackgroundItem_OnClick() end;
 info.owner = this:GetParent();
 info.checked = nil;
 info.icon = nil;
 UIDropDownMenu_AddButton(info, level);
end

function DDBackgroundItem_OnClick() -- See note 1
	UIDropDownMenu_SetSelectedValue(this.owner, this.value);

	
	model:SetLight(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	model:SetSequence(0)
	if (this.value == 0) then
		model:SetModel("Interface\\GLUES\\MODELS\\UI_MAINMENU\\UI_MainMenu.mdx");
		model:SetCamera(0)
		model:SetLight(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	elseif (this.value == 1) then
		model:SetModel("Interface\\GLUES\\MODELS\\UI_MainMenu_BurningCrusade\\UI_MainMenu_BurningCrusade.mdx");
		model:SetCamera(0)
	elseif (this.value == 2) then
		model:SetModel("Interface\\GLUES\\MODELS\\UI_MainMenu_Northrend\\UI_MainMenu_Northrend.mdx");
		model:SetCamera(0)
	elseif (this.value == 3) then
		model:SetModel("Interface\\GLUES\\MODELS\\UI_Human\\UI_Human.mdx");
		model:SetCamera(0)
	elseif (this.value == 4) then  
		model:SetModel("Interface\\GLUES\\MODELS\\UI_Dwarf\\UI_Dwarf.mdx");
		model:SetCamera(0)
	elseif (this.value == 5) then 
		model:SetModel("Interface\\GLUES\\MODELS\\UI_NightElf\\UI_NightElf.mdx")
		model:SetCamera(0)
	elseif (this.value == 6) then   
		model:SetModel("Interface\\GLUES\\MODELS\\UI_DRAENEI\\UI_Draenei.mdx");
		model:SetCamera(0)
	elseif (this.value == 7) then
		model:SetModel("Interface\\GLUES\\MODELS\\UI_Orc\\UI_Orc.mdx");
		model:SetCamera(0)
	elseif (this.value == 8) then  
		model:SetModel("Interface\\GLUES\\MODELS\\UI_SCOURGE\\UI_Scourge.mdx");
		model:SetCamera(0)
	elseif (this.value == 9) then
		model:SetModel("Interface\\GLUES\\MODELS\\UI_Tauren\\UI_Tauren.mdx");
		model:SetCamera(0)
	elseif (this.value == 10) then 
		if(IsModifierKeyDown() == nil)then
			model:SetModel("Interface\\GLUES\\MODELS\\UI_BLOODELF\\UI_BloodElf.mdx");
			model:SetCamera(0)
		else
			model:SetModel("Creature\\FelElfWarriorMale\\FelElfWarriorMale.mdx");
			model:SetSequence(69)
		end
	elseif (this.value == 11) then
		model:ClearModel();
	elseif (this.value == 12) then  
		model:SetModel("Interface\\GLUES\\MODELS\\UI_DeathKnight\\UI_DeathKnight.mdx");
		model:SetCamera(0)
	end
end




function JukeBox_SlashCmdHandler(arg)
	local arg1, arg2, arg3, arg4, arg5 = strsplit(" ", arg);
	if(arg == nil)then
        if(JukeBox_visible == true)then
            HideJukeBox();
        else
            ShowJukeBox();
        end
	elseif(arg == "")then
        if(JukeBox_visible == true)then
            HideJukeBox();
        else
            ShowJukeBox();
        end
	elseif (arg == "stop")then
		AttemptStopMusic()
	elseif (arg == "nowplaying")then
		if(JukeBox_PlayingName == "")then
			DEFAULT_CHAT_FRAME:AddMessage("[JukeBox] Now playing: No song is playing.");
		else
			DEFAULT_CHAT_FRAME:AddMessage("[JukeBox] Now playing: "..JukeBox_PlayingName.." ("..TimeString(JukeBox_elapsedtime).."/"..TimeString(JukeBox_PlayingLength)..")");
		end
	elseif (arg == "ver")then
		DEFAULT_CHAT_FRAME:AddMessage("[JukeBox] Version "..versionID);
	elseif (arg == "help")then
		DEFAULT_CHAT_FRAME:AddMessage("JukeBox Command Help:");
		DEFAULT_CHAT_FRAME:AddMessage("All commands are prefixed with /jukebox or /jb");
		DEFAULT_CHAT_FRAME:AddMessage("(no command) - Toggle the display of the JukeBox window.");
		DEFAULT_CHAT_FRAME:AddMessage("'help' - Displays command help.");
		DEFAULT_CHAT_FRAME:AddMessage("'ver' - Print current addon version number.");
		DEFAULT_CHAT_FRAME:AddMessage("'stop' - Stops the currently playing song.");
		DEFAULT_CHAT_FRAME:AddMessage("'nowplaying' - Print info on the currently playing song or playlist.");
	elseif (arg1 == "debug")then
		if(arg2 == "help")then
			DEFAULT_CHAT_FRAME:AddMessage("JukeBox DEBUG Command Help:");
			DEFAULT_CHAT_FRAME:AddMessage("*WARNING: Use of these debug commands can result in data loss.");
			DEFAULT_CHAT_FRAME:AddMessage("'debug setver <x>' - Set current version number to x.");
			DEFAULT_CHAT_FRAME:AddMessage("'debug messages [0/1]' - Turn debug messages on or off. 0 = off, 1 = on.");
			DEFAULT_CHAT_FRAME:AddMessage("'debug resetaptable' - Empties the AP Table.");
			DEFAULT_CHAT_FRAME:AddMessage("'debug printaptable <x>' - Prints AP Table at x.");
			DEFAULT_CHAT_FRAME:AddMessage("'debug zone' - Prints current RealZoneName.");
			DEFAULT_CHAT_FRAME:AddMessage("'debug debufftest' - Debuff check test.");
			DEFAULT_CHAT_FRAME:AddMessage("'debug getvar <x>' - Print the value of variable x.");
			DEFAULT_CHAT_FRAME:AddMessage("'debug setvar <x> <y> ([string/int/bool/nil])' - Set the value of X to Y. If no type is provided, set as string. Specify type as nil to make nil.");
		elseif (arg2 == "zone")then
			DEFAULT_CHAT_FRAME:AddMessage(GetRealZoneText());
		elseif (arg2 == "debufftest")then
			DEFAULT_CHAT_FRAME:AddMessage("Running AP_Dead...");
			local result = AP_Dead();
			DEFAULT_CHAT_FRAME:AddMessage(result);
		elseif (arg2 == "setver")then
			if(arg3 ~= nil)then
				local oldver = versionID;
				versionID = arg3;
				DEFAULT_CHAT_FRAME:AddMessage("[JukeBox] VERSION NUMBER CHANGED FROM "..oldver.." TO "..versionID);
			else
				DEFAULT_CHAT_FRAME:AddMessage("[JukeBox] setver error: No arg provided.");
			end
		elseif (arg2 == "getvar")then
			if(arg3 ~= nil)then
				DEFAULT_CHAT_FRAME:AddMessage("[JukeBox] "..arg3..": "..tostring(_G[arg3]));
			else
				DEFAULT_CHAT_FRAME:AddMessage("[JukeBox] getvar error: No arg provided.");
			end
		elseif (arg2 == "setvar")then
			if(arg3 ~= nil)then
				if(arg4 ~= nil)then
					if(arg5 ~= "nil")then
						DEFAULT_CHAT_FRAME:AddMessage("[JukeBox] "..arg3.." set to "..tostring(_G[arg4]));
					else
						DEFAULT_CHAT_FRAME:AddMessage("[JukeBox] "..arg3.." set to nil");
					end
					if(arg5 == nil)then
						_G[arg3] = arg4;
					elseif(arg5 == "string")then
						_G[arg3] = tostring(arg4);
					elseif(arg5 == "int")then
						_G[arg3] = tonumber(arg4);
					elseif(arg5 == "bool")then
						_G[arg3] = arg4;
					elseif(arg5 == "nil")then
						_G[arg3] = nil;
					end
				else
					DEFAULT_CHAT_FRAME:AddMessage("[JukeBox] setvar error: No arg provided.");
				end
			else
				DEFAULT_CHAT_FRAME:AddMessage("[JukeBox] setvar error: No arg provided.");
			end
		elseif (arg2 == "resetaptable")then
			AutoPlayTable = { };	
			DEFAULT_CHAT_FRAME:AddMessage("[JukeBox] AP Table Reset");
		elseif (arg2 == "messages")then
			if(arg3 ~= nil)then
				if(arg3 == "0")then
					DebugMessages = 0;
					DEFAULT_CHAT_FRAME:AddMessage("[JukeBox] Debug Messages: Turned off. (0)");
				elseif(arg3 == "1")then
					DebugMessages = 1;
					DEFAULT_CHAT_FRAME:AddMessage("[JukeBox] Debug Messages: Turned on. (1)");
				else
					DEFAULT_CHAT_FRAME:AddMessage("[JukeBox] messages error: Invalid arg provided.");
				end
			else
				DEFAULT_CHAT_FRAME:AddMessage("[JukeBox] Debug Messages: "..DebugMessages);
			end	
		elseif (arg2 == "printaptable")then
			if(arg3~=nil)then
				if(AutoPlayTable[tonumber(arg3)]~=nil)then
					DEFAULT_CHAT_FRAME:AddMessage("[JukeBox] "..AutoPlayTable[tonumber(arg3)]);
				else
					DEFAULT_CHAT_FRAME:AddMessage("[JukeBox] nil");
				end
			end
		end
	end
end


function HideJukeBox()
    JukeBoxForm:Hide();
    JukeBox_visible = false;
end

function ShowJukeBox()
    JukeBoxForm:Show();
    JukeBox_visible = true;
    
    UIDropDownMenu_Initialize(DDBackground, DDBackground_Initialise);
    UIDropDownMenu_Initialize(DDGame, DDGame_Initialise);
    UIDropDownMenu_Initialize(DDZone, DDZone_Initialise);
    UIDropDownMenu_Initialize(DDSong, DDSong_Initialise);
    UIDropDownMenu_Initialize(DDPlayLists, DDPlayLists_Initialise);
    UIDropDownMenu_Initialize(DDCustom, DDCustom_Initialise);
end

function SwitchLoop()
    if(JukeBox_loopmusic == true) then
        JukeBox_loopmusic = false;
    else
        JukeBox_loopmusic = true;
    end
end

function ActivateAutoLoop(arg)
	arg = tonumber(arg);
	if(arg==1)then
		if(alreadyAutoLooping == false)then
			alreadyAutoLooping = true;
			previousLoopState=JukeBox_loopmusic;
			JukeBox_loopmusic = true;
			LoopCheckBox:SetChecked(1)
			if(DebugMessages == 1)then
				DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] CheckingAutoLoop:UseAutoLoop PreviousState: "..tostring(previousLoopState));
			end
		else
			if(DebugMessages == 1)then
				DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] CheckingAutoLoop:AutoLoop already activated, no change.");
			end
		end
	else
		if(DebugMessages == 1)then
			DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] CheckingAutoLoop:DontUseAutoLoop. PreviousState: "..tostring(previousLoopState));
		end
	end
end
function CheckAutoLoop(arg)
	if(tonumber(arg) == 1)then
		if(DebugMessages == 1)then
			DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] CheckingAutoLoop. Before: previous("..tostring(previousLoopState)..") current("..tostring(JukeBox_loopmusic)..")");
		end
		if(previousLoopState~=JukeBox_loopmusic)then
			if(DebugMessages == 1)then
				DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] CheckingAutoLoop. They're not equal. Deactivating AL.");
			end
			if(previousLoopState == true)then
				LoopCheckBox:SetChecked(1)
				JukeBox_loopmusic = true;
			else
				LoopCheckBox:SetChecked(0)
				JukeBox_loopmusic = false;
			end
			alreadyAutoLooping = false;
		else
			if(DebugMessages == 1)then
				DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] CheckingAutoLoop. They're equal, deactivating AL.");
			end
			alreadyAutoLooping = false;
		end
		if(DebugMessages == 1)then
			DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] CheckingAutoLoop. After: previous("..tostring(previousLoopState)..") current("..tostring(JukeBox_loopmusic)..")");
		end
	end
end

function ToggleWait()
    if(JukeBox_waitformusicdone == true) then
        JukeBox_waitformusicdone = false;
        JukeBox_QueActive = false;
        local queName = getglobal("JukeBoxForm".."Page1".."PanelPlay".."QueLabel".."Label");
        queName:SetText(" ");
    else
        JukeBox_waitformusicdone = true;
    end
end

function ChooseSong(arg1, arg2, arg3)
    JukeBox_PlayListIsSelected = false;
    CustomIsSelected = false;
    local labelName,labelLength;
    BtnPLChooseTrack:Enable();
    JukeBox_nothingselected = false;
    JukeBox_SelectedName = arg1;
    JukeBox_SelectedFile = arg2;
    JukeBox_SelectedLength = arg3;
    local secondsStringT = mod(JukeBox_SelectedLength, 60);
    if(secondsStringT < 10) then
        secondsStringT = "0"..secondsStringT;
    end
    local minuteStringT = floor(JukeBox_SelectedLength / 60);
    local TimeStringT = minuteStringT..":"..secondsStringT;
    labelName = getglobal("JukeBoxForm".."Page1".."PanelPlay".."TextName".."Label");
    labelName:SetText(JukeBox_SelectedName);
    labelLength = getglobal("JukeBoxForm".."Page1".."PanelPlay".."TextLength".."Label");
    labelLength:SetText(TimeStringT);
    
    local PlayButton = getglobal("JukeBoxForm".."Page1".."PanelPlay".."PlayButton");
    PlayButton:Enable();
end

function ChooseCustomSong(arg)
    arg = tonumber(arg)
    if(CustomTable[arg]~=nil)then
        JukeBox_PlayListIsSelected = false;
        CustomIsSelected = true;
        CustomSelectedID = arg;
        local labelName,labelLength;
        BtnPLChooseTrack:Enable();
        JukeBox_nothingselected = false;
        
        JukeBox_SelectedName = AnalyzeName("c", arg, "<error>")
        JukeBox_SelectedFile = arg;
        JukeBox_SelectedLength = "c";
    
        labelName = getglobal("JukeBoxForm".."Page1".."PanelPlay".."TextName".."Label");
        labelName:SetText(JukeBox_SelectedName);
        labelLength = getglobal("JukeBoxForm".."Page1".."PanelPlay".."TextLength".."Label");
        labelLength:SetText(TimeString(AnalyzeLength("c", arg)));
    
        local PlayButton = getglobal("JukeBoxForm".."Page1".."PanelPlay".."PlayButton");
        PlayButton:Enable();
    end
end


function PlaySongButton()
    if(JukeBox_nothingselected == false) then
    
    mountOutsideStopCheck = 1;
        if(JukeBox_PlayListIsSelected == false)then
            if(CustomIsSelected==false)then
                if(JukeBox_waitformusicdone == false) then
                    PlaySong();
					JukeBox_PlayListIsPlaying = false;
                else
                    if(JukeBox_musicisplaying == false) then
                        PlaySong();
						JukeBox_PlayListIsPlaying = false;
                    else
                        JukeBox_QueName = JukeBox_SelectedName;
                        JukeBox_QueFile = JukeBox_SelectedFile;
                        JukeBox_QueLength = JukeBox_SelectedLength;
                        JukeBox_QueIsPL = false;
                        JukeBox_QueActive = true;
                        local queName = getglobal("JukeBoxForm".."Page1".."PanelPlay".."QueLabel".."Label");
                        queName:SetText("Queued song: "..JukeBox_QueName); 
                    end
                end
            else
                ------ UpdateToCustomData
                local oldvar = JukeBox_SelectedFile;
                local readid = tonumber(JukeBox_SelectedFile)
                local id, name, length, file = strsplit("\a", CustomTable[readid])
                
                JukeBox_SelectedName = name;
                JukeBox_SelectedLength = length;
                JukeBox_SelectedFile = "Interface\\AddOns\\JukeBox\\CustomMusic\\"..file;
                ------
                if(JukeBox_waitformusicdone == false) then
                    PlaySong();
					JukeBox_PlayListIsPlaying = false;
                else
                    if(JukeBox_musicisplaying == false) then
                        PlaySong();
						JukeBox_PlayListIsPlaying = false;
                    else
                        JukeBox_QueName = JukeBox_SelectedName;
                        JukeBox_QueFile = JukeBox_SelectedFile;
                        JukeBox_QueLength = JukeBox_SelectedLength;
                        JukeBox_QueIsPL = false;
                        JukeBox_QueActive = true;
                        local queName = getglobal("JukeBoxForm".."Page1".."PanelPlay".."QueLabel".."Label");
                        queName:SetText("Queued song: "..JukeBox_QueName); 
                    end
                end
                
                JukeBox_SelectedFile = oldvar;
            end
        else
        --PlayList is Selected
            if(JukeBox_waitformusicdone == false) then
                JukeBox_PlayListIsPlaying = true;
                --JukeBox_PlayListData = JukeBox_SelectedPlayListData;
                JukeBox_PlayListCurTrack = 1;
                JukeBox_PlayListMaxTracks = JukeBox_SelectedPlayListMaxTracks;
                --local test = getglobal("LabelTitle".."Label");
                -- test:SetText("("..JukeBox_SelectedPlayListMaxTracks..") ("..JukeBox_PlayListMaxTracks..") ("..JukeBox_QuePlayListMaxTracks..")");
    
                PlaySongPL(JukeBox_PlayListData);
            else
                if(JukeBox_musicisplaying == false) then
                JukeBox_PlayListIsPlaying = true;
                JukeBox_PlayListData = JukeBox_SelectedPlayListData;
                JukeBox_PlayListCurTrack = 1;
                JukeBox_PlayListMaxTracks = JukeBox_SelectedPlayListMaxTracks;
                PlaySongPL(JukeBox_PlayListData);
                else
                    JukeBox_QueName = JukeBox_SelectedName;
                    JukeBox_QueFile = JukeBox_SelectedFile;
                    JukeBox_QueLength = JukeBox_SelectedLength;
                    JukeBox_QueIsPL = true;
                    JukeBox_QuePLData = JukeBox_SelectedPlayListData;
                    JukeBox_QueActive = true;
                    JukeBox_QuePlayListMaxTracks = JukeBox_SelectedPlayListMaxTracks;
                    local queName = getglobal("JukeBoxForm".."Page1".."PanelPlay".."QueLabel".."Label");
                    queName:SetText("Queued playlist: "..JukeBox_QueName); 
                end
            end
            
        end
    end
end


function PlaySong()
    --if(JukeBox_nothingselected == false) then
        --if(JukeBox_waitformusicdone == false) then
        local labelName,labelLength;
        labelName = getglobal("JukeBoxForm".."PanelNowPlaying".."NowPlayingName".."Label");
        JukeBox_PlayingName = JukeBox_SelectedName;
        labelName:SetText(JukeBox_PlayingName);
        labelLength = getglobal("JukeBoxForm".."PanelNowPlaying".."NowPlayingTime".."Label");
        JukeBox_PlayingLength = JukeBox_SelectedLength;
        
            local secondsStringT = mod(JukeBox_PlayingLength, 60);
            if(secondsStringT < 10) then
            secondsStringT = "0"..secondsStringT;
            end
            local minuteStringT = floor(JukeBox_PlayingLength / 60);
            local TimeStringT = minuteStringT..":"..secondsStringT;
        labelLength:SetText("0:00/"..TimeStringT);
        JukeBox_elapsedtime = "0";
        JukeBox_PlayingFile = JukeBox_SelectedFile;
        PlayMusic(JukeBox_PlayingFile);
        JukeBox_musicisplaying = true;
        
        local StopButton = getglobal("JukeBoxForm".."PanelNowPlaying".."StopButton");
        StopButton:Enable();
        --TestTimer();
        Time:Show();
        --end
        
    --end
end    

function PlaySongPL(arg1)
    --if(JukeBox_nothingselected == false) then
    local plid, plname, plcount, plname1, pllength1, plfile1, plname2, pllength2, plfile2, plname3, pllength3, plfile3, plname4, pllength4, plfile4, plname5, pllength5, plfile5 = strsplit("\a", arg1);
    JukeBox_PlayListIsPlaying = true;
    JukeBox_PlayListMaxTracks = plcount;
    local checkCur = tonumber(JukeBox_PlayListCurTrack)
    local checkMax = tonumber(JukeBox_PlayListMaxTracks)
    if(checkCur == checkMax)then
        JukeBox_PlayListIsPlaying = false;
    end
    --local nowPlayingNameString = "";
    local checkLength = 0;
    local checkFile = 0;
    
    
    if(JukeBox_PlayListCurTrack == 1)then
        JukeBox_PlayingName = plname1.." ("..plname..", "..JukeBox_PlayListCurTrack.."/"..JukeBox_PlayListMaxTracks..")";
        JukeBox_PlayingLength = pllength1;
        JukeBox_PlayingFile = plfile1;
        checkLength = AnalyzeLength(pllength1, plfile1);
        checkFile = AnalyzeFile(pllength1, plfile1);
    elseif(JukeBox_PlayListCurTrack == 2)then
        JukeBox_PlayingName = plname2.." ("..plname..", "..JukeBox_PlayListCurTrack.."/"..JukeBox_PlayListMaxTracks..")";
        JukeBox_PlayingLength = pllength2;
        JukeBox_PlayingFile = plfile2;
        checkLength = AnalyzeLength(pllength2, plfile2);
        checkFile = AnalyzeFile(pllength2, plfile2);
    elseif(JukeBox_PlayListCurTrack == 3)then
        JukeBox_PlayingName = plname3.." ("..plname..", "..JukeBox_PlayListCurTrack.."/"..JukeBox_PlayListMaxTracks..")";
        JukeBox_PlayingLength = pllength3;
        JukeBox_PlayingFile = plfile3;
        checkLength = AnalyzeLength(pllength3, plfile3);
        checkFile = AnalyzeFile(pllength3, plfile3);
    elseif(JukeBox_PlayListCurTrack == 4)then
        JukeBox_PlayingName = plname4.." ("..plname..", "..JukeBox_PlayListCurTrack.."/"..JukeBox_PlayListMaxTracks..")";
        JukeBox_PlayingLength = pllength4;
        JukeBox_PlayingFile = plfile4;
        checkLength = AnalyzeLength(pllength4, plfile4);
        checkFile = AnalyzeFile(pllength4, plfile4);
    elseif(JukeBox_PlayListCurTrack == 5)then
        JukeBox_PlayingName = plname5.." ("..plname..", "..JukeBox_PlayListCurTrack.."/"..JukeBox_PlayListMaxTracks..")";
        JukeBox_PlayingLength = pllength5;
        JukeBox_PlayingFile = plfile5;
        checkLength = AnalyzeLength(pllength5, plfile5);
        checkFile = AnalyzeFile(pllength5, plfile5);
    end
    
    JukeBox_PlayingLength = checkLength;
    JukeBox_PlayingFile = checkFile;
       
    if(checkFile == 0)then
        checkLength = 0;
    else
        local labelName,labelLength;
        labelName = getglobal("JukeBoxForm".."PanelNowPlaying".."NowPlayingName".."Label");
        labelName:SetText(JukeBox_PlayingName);
        labelLength = getglobal("JukeBoxForm".."PanelNowPlaying".."NowPlayingTime".."Label");
        labelLength:SetText("0:00/"..TimeString(checkLength));
    end 
    
    
    JukeBox_elapsedtime = "0";
    PlayMusic(checkFile);
    JukeBox_musicisplaying = true;
       
    local StopButton = getglobal("JukeBoxForm".."PanelNowPlaying".."StopButton");
    StopButton:Enable();
        
    Time:Show();
       
        
    --end
end 


function TestDD()
local testLabel = getglobal("JukeBoxForm".."PanelNowPlaying".."NowPlayingTime".."Label");
local testBox = getglobal("JukeBoxForm".."Panel1".."ComboBox1".."Button");
testLabel:SetText(testBox.SelectedIndex);
end




--mountOutsideStopCheck

function StopButtonAct()
    AttemptStopMusic()
	--wipe(AutoPlayTable)
	--AutoPlayTable = { };
	--FormatAPTable()
    --local test = getglobal("LabelTitle".."Label");
    --test:SetText(mountOutsideStopCheck);     
end

function AttemptStopMusic()
    if(JukeBox_musicisplaying == true) then
        JukeBox_musicisplaying = false;
        StopMusic();
        Time:Hide();
        local StopButton = getglobal("JukeBoxForm".."PanelNowPlaying".."StopButton");
        StopButton:Disable();
    end
end

local timer = 0

local delay = 1

function Time_OnUpdate(self, elapsed)

	timer = timer + elapsed

	if ( timer >= delay ) then

		timer = 0
        local labelLength,barThing;
        if(JukeBox_musicisplaying == true) then
        
            local elapsed = tonumber(JukeBox_elapsedtime) + 1;
            local total = tonumber(AnalyzeLength(JukeBox_PlayingLength, JukeBox_PlayingFile));
            
            
            local TimeStringE = TimeString(elapsed);
            
            local TimeStringT = TimeString(total);
            

            if(elapsed <= total) then
                JukeBox_elapsedtime = elapsed;
                labelLength = getglobal("JukeBoxForm".."PanelNowPlaying".."NowPlayingTime".."Label");
                labelLength:SetText(TimeStringE.."/"..TimeStringT);
                barThing = getglobal("JukeBoxForm".."PanelNowPlaying".."TrackingBar");
                barThing:SetValue((elapsed / total) * 100);
            else
                elapsed = 0;
                JukeBox_elapsedtime = elapsed;
                
               
                labelLength = getglobal("JukeBoxForm".."PanelNowPlaying".."NowPlayingTime".."Label");
                labelLength:SetText("0:00/"..TimeStringT);
                barThing = getglobal("JukeBoxForm".."PanelNowPlaying".."TrackingBar");
                barThing:SetValue(0);
                if(JukeBox_loopmusic == false) then
                    if(JukeBox_PlayListIsPlaying == false)then
                        if(JukeBox_waitformusicdone == true) then
                            if(JukeBox_QueActive == true) then
                                if(JukeBox_QueIsPL == false)then
                                    local tempName = JukeBox_SelectedName;
                                    local tempFile = JukeBox_SelectedFile;
                                    local tempLength = JukeBox_SelectedLength;
                                    JukeBox_SelectedName = JukeBox_QueName;
                                    JukeBox_SelectedFile = JukeBox_QueFile;
                                    JukeBox_SelectedLength = JukeBox_QueLength;
                                    JukeBox_QueActive = false;
                                    local queName = getglobal("JukeBoxForm".."Page1".."PanelPlay".."QueLabel".."Label");
                                    queName:SetText(" ");
                                    PlaySong();
									JukeBox_PlayListIsPlaying = false;
                                    JukeBox_SelectedName = tempName;
                                    JukeBox_SelectedFile = tempFile;
                                    JukeBox_SelectedLength = tempLength;
                                else
                                
                                    local test = getglobal("LabelTitle".."Label");
                                    --test:SetText("("..JukeBox_SelectedPlayListMaxTracks..") ("..JukeBox_PlayListMaxTracks..") ("..JukeBox_QuePlayListMaxTracks..")");
                                    JukeBox_QueIsPL = false;
                                    --if(JukeBox_PlayListIsSelected == false)then
                                    local tempName = JukeBox_SelectedName;
                                    local tempFile = JukeBox_SelectedFile;
                                    local tempLength = JukeBox_SelectedLength;
                                    local tempPlayListMaxTracks = JukeBox_SelectedPlayListMaxTracks;
                                    local tempPlayListData = JukeBox_SelectedPlayListData;
                                    
                                    local testCheck = JukeBox_QuePlayListMaxTracks;
                                    
                                    JukeBox_SelectedName = JukeBox_QueName;
                                    JukeBox_SelectedFile = JukeBox_QueFile;
                                    JukeBox_SelectedLength = JukeBox_QueLength;
                                    JukeBox_SelectedPlayListMaxTracks = JukeBox_QuePlayListMaxTracks;
                                    JukeBox_SelectedPlayListData = JukeBox_QuePLData;
                                    JukeBox_PlayListData = JukeBox_QuePLData;
                                    
                                    JukeBox_QueActive = false;
                                    local queName = getglobal("JukeBoxForm".."Page1".."PanelPlay".."QueLabel".."Label");
                                    queName:SetText(" ");
                                    JukeBox_PlayListCurTrack = 1;
                                    JukeBox_PlayListCurTrack = 1;
                                    PlaySongPL(JukeBox_SelectedPlayListData);
                                    JukeBox_PlayListIsPlaying = true;
                                    --test:SetText("("..JukeBox_SelectedPlayListMaxTracks..") ("..JukeBox_PlayListMaxTracks..") ("..JukeBox_QuePlayListMaxTracks.."), "..JukeBox_PlayListCurTrack.." ["..testCheck.."]");
                                   -- test:SetText(JukeBox_QuePLData)
                                    JukeBox_SelectedName = tempName;
                                    JukeBox_SelectedFile = tempFile;
                                    JukeBox_SelectedLength = tempLength;
                                    JukeBox_SelectedPlayListMaxTracks = tempPlayListMaxTracks;
                                    JukeBox_SelectedPlayListData = tempPlayListData;
                                    
                                     
                                    --else
                                    
                                    --end
                                ----QueueIsAPL
                                end
                            else
                                AttemptStopMusic();
                                --local test = getglobal("LabelTitle".."Label");
                                --test:SetText("A")
                            end
                        else
                            AttemptStopMusic();
                            --local test = getglobal("LabelTitle".."Label");
                                --test:SetText("B")
                        end
                    else
                        --PlayNextPLTrack
                        JukeBox_PlayListCurTrack = JukeBox_PlayListCurTrack + 1;
                        local checkmaxtracks = tonumber(JukeBox_PlayListMaxTracks)
                        local checkCurtrack = tonumber(JukeBox_PlayListCurTrack)
                        --local test = getglobal("LabelTitle".."Label");
                            --test:SetText(checkCurtrack.."/"..checkmaxtracks.."|"..JukeBox_PlayListIsPlaying);
                        if(checkCurtrack <= checkmaxtracks)then
                            PlaySongPL(JukeBox_PlayListData);
                        else
                            AttemptStopMusic();
                            
                        end
                    end    
                else
                --AttemptStopMusic();
                --PlaySong();
                end
            end
        end

	end

end	



local timerCheck = 0

local delayCheck = 1




function Check_OnUpdate(self, elapsed)

	timerCheck = timerCheck + elapsed

	if ( timerCheck >= delayCheck ) then
        timerCheck = 0
        ---------------------------------------------------------------------------------
		
		local test = getglobal("LabelTitle".."Label");
		local resultA = 0;
		local resultB = 0;
		local resultC = 0;
		
		resultC = AP_Area();
		
		if(resultC == 0)then
		
			if(checkFirst=="mount")then
				resultA = AP_Mount()
			elseif(checkFirst=="combat")then
				resultA = AP_Combat()
			end
			
			if(checkSecond=="mount")then
				if(resultA == 0)then
					resultB = AP_Mount()
				end
			elseif(checkSecond=="combat")then
				if(resultA == 0)then
					resultB = AP_Combat()
				end
			end
			
		else
		
			if(AP_Dead() == 1)then
				--RePlayMusic()
				areaCheck = 0;
			end
		end
            
        
    
       --------------------------------------------------------------------------------- 
    end
end

function AP_Normal(argName, argLength, argFile)

    local tempName = JukeBox_SelectedName;
    local tempFile = JukeBox_SelectedFile;
    local tempLength = JukeBox_SelectedLength;
    JukeBox_SelectedName = argName;
    JukeBox_SelectedFile = AnalyzeFile(argLength,argFile);
    JukeBox_SelectedLength = AnalyzeLength(argLength, argFile);
    PlaySong();
    JukeBox_SelectedName = tempName;
    JukeBox_SelectedFile = tempFile;
    JukeBox_SelectedLength = tempLength;
	JukeBox_PlayListIsPlaying = false;
end

function CPath(arg1)
local result = "Interface\\AddOns\\JukeBox\\CustomMusic\\"..arg1
return result;
end

function AP_PL(argName, argLength, argFile, argPLData)
   local tempName = JukeBox_SelectedName;
   local tempFile = JukeBox_SelectedFile;
   local tempLength = JukeBox_SelectedLength;
   local tempPlayListMaxTracks = JukeBox_SelectedPlayListMaxTracks;
   local tempPlayListData = JukeBox_SelectedPlayListData;
                                    
   local plid, plname, plcount, plname1, pllength1, plfile1, plname2, pllength2, plfile2, plname3, pllength3, plfile3, plname4, pllength4, plfile4, plname5, pllength5, plfile5 = strsplit("\a", argPLData);
                                    
   JukeBox_SelectedName = argName;
   JukeBox_SelectedFile = argFile;
   JukeBox_SelectedLength = argLength;
   JukeBox_SelectedPlayListMaxTracks = plcount;
   JukeBox_PlayListMaxTracks = plcount;
   JukeBox_SelectedPlayListData = argPLData;
   JukeBox_PlayListData = argPLData;
   JukeBox_PlayListCurTrack = 1;
   PlaySongPL(JukeBox_SelectedPlayListData);
   JukeBox_PlayListIsPlaying = true;
   JukeBox_SelectedName = tempName;
   JukeBox_SelectedFile = tempFile;
   JukeBox_SelectedLength = tempLength;
   JukeBox_SelectedPlayListMaxTracks = tempPlayListMaxTracks;
   JukeBox_SelectedPlayListData = tempPlayListData;
end


function AP_Mount()
	local result = 0;
		
	if(tonumber(AutoPlayTable[1]) ~= 0)then
        local mounted;
        if (IsMounted() == 1) then
			mounted = true;
		else
			mounted = false;
		end
		if(mounted == true)then
			if (UnitOnTaxi("player") == 1) then
				mounted = false;
			else
				mounted = true;
			end
		end
		-----------------------------------------
        if(mounted == true)then
			result = 1;
			local test = getglobal("LabelTitle".."Label");
            if(mountCheck == 0)then
				
                mountCheck = 1;
                mountOutsideStopCheck = 0;
                ---Play from table 1
                AP_PlayMusic(1)
				if(DebugMessages == 1)then
					DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] Mounted - Start");
				end
            end
        else
			AP_StopMusic(1)
        end
    end
	return result;
end

function AP_Combat()
	local result = 0;
	if(tonumber(AutoPlayTable[2]) ~= 0)then
           
			local combat;
            if (UnitAffectingCombat("player") == 1) then
           
			    combat = true;
		    else
           
			    combat = false;
		    end
			if(combat == true)then
				result = 1;
				if(combatCheck == 0)then
					if(DebugMessages == 1)then
						DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] Combat - Start");
					end
                    combatCheck = 1;
                    mountOutsideStopCheck = 0;
                    ---Play from table 1
                    AP_PlayMusic(2)
                end
            else
				AP_StopMusic(2)
            end
        end
	return result;
end

function AP_Area()
	local result = 0;
		
	if(tonumber(AutoPlayTable[3]) ~= 0)then
        local inBG;
		local zoneName = GetRealZoneText();
        if(zoneName == "Arathi Basin")then
			inBG = true;
		end
		if(zoneName == "Warsong Gulch")then
			inBG = true;
		end
		if(zoneName == "Alterac Valley")then
			inBG = true;
		end
		if(zoneName == "Eye of the Storm")then
			inBG = true;
		end
		if(zoneName == "Strand of the Ancients")then
			inBG = true;
		end
        if(inBG == true)then
			result = 1;
            if(areaCheck == 0)then
                areaCheck = 1;
                mountOutsideStopCheck = 0;
				
                AP_PlayMusic(3)
				
            end
        else
			AP_StopMusic(3)
        end
    end
	return result;
end


deadCheckB = 0;
deadCheckC = 0;
function AP_Dead()
	local result = 0;
	--if(tonumber(AutoPlayTable[3]) ~= 0)then
        if(UnitIsDeadOrGhost('player'))then
			if(deadCheck == 0)then
				deadCheck = 1;
				deadCheckB = 1;
            --if(areaCheck == 0)then
            --    areaCheck = 1;
            --    mountOutsideStopCheck = 0;
				
            --    AP_PlayMusic(3)
			end
        else
			if(deadCheckB == 1)then
				result = 1;
				deadCheckB = 0;
				deadCheck = 0;
			else
			
			
				if(deadCheckC == 0)then
					if(UnitAura('player', 1, "HARMFUL")~=nil)then
						local n = UnitAura('player', 1, "HARMFUL");
						if(n == "End of Round")then
							deadCheckC = 1;
							if(DebugMessages == 1)then
								DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] End of Round Found");
							end
						end
					end
				else
					if(UnitAura('player', 1, "HARMFUL")~=nil)then
						local n = UnitAura('player', 1, "HARMFUL");
						if(n ~= "End of Round")then
							deadCheckC = 0;
							result = 1;
							if(DebugMessages == 1)then
								DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] End of Round Lost");
							end
						else
						end
					else
							deadCheckC = 0;
							result = 1;
							if(DebugMessages == 1)then
								DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] End of Round Lost");
							end
					end
				end
			end
			--AP_StopMusic(3)
        end
    --end
	return result;
end

function AP_PlayMusic(arg)
	arg = tonumber(arg);
	local useSwitch, useType, useName, useLength, useFile, useAutoLoop = strsplit("\a", AutoPlayTable[arg]);
				
				
    if(tonumber(useSwitch) == 1)then
		ActivateAutoLoop(useAutoLoop);
		if(useType == "0")then
            AP_Normal(useName, useLength, useFile)
        elseif(useType == "1")then
            local id = tonumber(useFile)
            if(PlayListsTable[id]~=nil)then
				AP_PL(useName, useLength, useFile, PlayListsTable[id])
            else
				AutoPlayTable[arg] = 0;
            end
        elseif(useType == "2")then
            if(CustomTable[tonumber(useFile)]~=nil)then
				local id, name, length, file = strsplit("\a", CustomTable[tonumber(useFile)])
                AP_Normal(name, length, CPath(file))
            else
                AutoPlayTable[arg] = 0;
            end
        end
    end
end

function AP_StopMusic(arg)
	arg = tonumber(arg)
	local useSwitch, useType, useName, useLength, useFile, useAutoLoop = strsplit("\a", AutoPlayTable[arg]);
	if(tonumber(useSwitch) == 1)then
		local doCheck = 0;
		if(arg == 1)then
			doCheck = mountCheck;
			if(mountCheck == 1)then
				mountCheck = 0;
				if(DebugMessages == 1)then
					DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] Mounted - Stop");
				end
			end
		elseif(arg == 2)then
			doCheck = combatCheck;
			if(combatCheck == 1)then
				combatCheck = 0;
				if(DebugMessages == 1)then
					DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] Combat - Stop");
				end
			end
		elseif(arg == 3)then
			doCheck = areaCheck;
			if(areaCheck == 1)then
				areaCheck = 0;
				if(DebugMessages == 1)then
					DEFAULT_CHAT_FRAME:AddMessage("[JukeBoxDebug] Area - Stop");
				end
			end
		end
		if(doCheck == 1)then
			if(mountOutsideStopCheck == 0)then
				CheckAutoLoop(useAutoLoop);
						
				AttemptStopMusic();
			end
		else
			
		end
	end
end

function RePlayMusic()

end
