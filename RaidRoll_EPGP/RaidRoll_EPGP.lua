
RR_EPGPHasLoaded=true
 
function RR_ReallyGetEPGPGuildData()
	if IsInGuild() then
		RR_GuildInfo = GetGuildInfoText();
		
		--[[
		-EPGP-
		@DECAY_P:10
		@EXTRAS_P:50
		@MIN_EP:2500
		@BASE_GP:100
		-EPGP-
		]]
		
		local string_start,string_end = string.find(RR_GuildInfo, "%-EPGP%-");
		if string_start ~= nil and string_end ~= nil then
			RR_GuildInfo = string.sub(RR_GuildInfo, string_end+2)
			
			--[[
			@DECAY_P:10
			@EXTRAS_P:50
			@MIN_EP:2500
			@BASE_GP:100
			-EPGP-
			]]
			
			local string_start,string_end = string.find(RR_GuildInfo, "%-EPGP%-");
			if string_start ~= nil then
				RR_GuildInfo = string.sub(RR_GuildInfo, 1, string_start-2);
				
				--[[	
				@DECAY_P:10
				@EXTRAS_P:50
				@MIN_EP:2500
				@BASE_GP:100
				]]
				
				for i=1,10 do
					if RR_GuildInfo ~= nil then
						string_start,string_end=string.find(RR_GuildInfo, "%@+%a+%_%a+%:%d+");
						if string_start ~= nil then
							Substring = string.sub(RR_GuildInfo, string_start, string_end);
							RR_GuildInfo = string.sub(RR_GuildInfo, string_end+2);
							if RaidRoll_DB["debug"] == true then RR_Test("Leftover String: " .. RR_GuildInfo) end
							
							--[[
							Substring
							@DECAY_P:10
							]]
							
							--[[
							RR_GuildInfo
							@EXTRAS_P:50
							@MIN_EP:2500
							@BASE_GP:100
							]]
							
							string_start,string_end=string.find(Substring, "%@+%a+%_%a+%:");
							Type = string.upper(string.sub(Substring, string_start+1, string_end-1))
							if RaidRoll_DB["debug"] == true then RR_Test("Type: " .. Type); end
							
							-- DECAY_P
							
							string_start,string_end=string.find(Substring, "%:%d+");
							Value = tonumber(string.sub(Substring, string_start+1, string_end));
							if RaidRoll_DB["debug"] == true then RR_Test("Value: " .. Value); end
							
							-- 10
							
							RaidRoll_DB[Type] = Value ;
						end
					end
				end
			end
		end
	end
end
	
	
	
	
	
function RR_ReallyGetEPGPCharacterData(character)
	-- setup defaults
	local PR = 0
	local AboveThreshold = false
	local EP = 0
	local GP = 0
	
	if IsInGuild() then
		RR_GetEPGPGuildData()
		if character ~= nil then 
			character = string.lower(character)
			
			for i=1,GetNumGuildMembers() do
				name, rank, rankIndex, level, class, zone, note, officernote, online, status, classFileName = GetGuildRosterInfo(i);
				
				name = string.lower(name)
				
				
				if character == name then
					
					
					officernote = strtrim(officernote)	-- cut out [space][tab][return][newline]
					
					EP,GP = strsplit("," ,officernote)
					
					EP = tonumber(EP)
					GP = tonumber(GP)
					
					
				-- Search for the Main character
					if tonumber(EP) == nil and tonumber(GP) == nil then
						if RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Enable_Alt_Mode"] == true then
							SetGuildRosterShowOffline(true);
							
							character = officernote
							
							for j=1,GetNumGuildMembers() do
								name, rank, rankIndex, level, class, zone, note, officernote, online, status, classFileName = GetGuildRosterInfo(j);
								
								if strlower(character) == strlower(name) then
									officernote = strtrim(officernote)	-- cut out [space][tab][return][newline]
									
									EP,GP = strsplit("," ,officernote)
									
									EP = tonumber(EP)
									GP = tonumber(GP)
								end								
							end
						end
					end
					
					if tonumber(EP) == nil then EP = 0 end
					if tonumber(GP) == nil then GP = 0 end
					
					GP = GP + RaidRoll_DB["BASE_GP"]
					
					
					PR = (ceil(EP/GP*100) / 100)
					
					if EP >= RaidRoll_DB["MIN_EP"] then AboveThreshold = true end
					
					if RaidRoll_DB["debug"] == true then RR_Test(name .. ": EP=" .. EP .. " GP=" .. GP .. " PR=" .. PR) end
					
				end
			end
		end
	end
	
	return PR,AboveThreshold,EP,GP
end






	