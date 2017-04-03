-------------------------------------------------------------------------------
-- MrTrader
--
-- Suite of tools for the avid crafter.
--
-- Send suggestions, comments, and bugs to user@zedonline.net
-------------------------------------------------------------------------------

MrTraderVersion = "0.5";

MrTrader = LibStub("AceAddon-3.0"):NewAddon("MrTrader",
											"AceEvent-3.0",
											"AceHook-3.0");
		
MRTLoc = LibStub("AceLocale-3.0"):GetLocale("MrTrader", true);									

local WhisperCommands = {
	["!link"] = function (args,player,broadcast) MrTrader:WhisperTradeskill(args,player,broadcast) end,
	["!full"] = function (args,player,broadcast) MrTrader:WhisperTradeskill(args,player,broadcast) end,
}
					
function MrTrader:OnInitialize()
	self:Load();
	self:InitializeMenu();
	
	-- Register for events.
	self:RegisterEvent("PLAYER_LOGIN", "OnLogin");
  	self:RegisterEvent("PLAYER_LOGOUT", "UpdateLinks");
	self:RegisterEvent("TRADE_SKILL_UPDATE", "UpdateLinks");
	self:RegisterEvent("TRAINER_UPDATE", "UpdateLinks");
	self:RegisterEvent("CHAT_MSG_WHISPER", "RespondToWhisper");
	self:RegisterEvent("CHAT_MSG_GUILD", "RespondToGuild");
	self:RegisterEvent("CHAT_MSG_PARTY", "RespondToRaid");
	self:RegisterEvent("CHAT_MSG_RAID", "RespondToRaid");
	
	-- Enable our hooks
	MRTHooks:OnEnable();

	self:Output(string.format(MRTLoc["%s v%s loaded."], MRTLoc["MrTrader"], MrTraderVersion));
end

function MrTrader:OnLogin()
	self:RegisterEvent("WORLD_MAP_UPDATE", "OnMapUpdate");
end

function MrTrader:OnMapUpdate()
	-- Keep trying until we know for sure we are up to date on skill links
	didUpdate = self:QuerySkills();
	if didUpdate then
		self:UnregisterEvent("WORLD_MAP_UPDATE");
	end
end

function MrTrader:UpdateLinks()
	self:QuerySkills();
end

function MrTrader:RespondToGuild( event, msg, player )
	if not self.db.profile.respondToGuild then
		return;
	end
	
	MrTrader:HandleMessageCommand( msg, player, true );
end

function MrTrader:RespondToRaid( event, msg, player )
	if not self.db.profile.respondToRaid then
		return;
	end
	
	MrTrader:HandleMessageCommand( msg, player, true );
end

function MrTrader:RespondToWhisper( event, msg, player )
	if not self.db.profile.respondToWhispers then
		return;
	end

	MrTrader:HandleMessageCommand( msg, player, false );
end

function MrTrader:HandleMessageCommand( msg, player, broadcast )
	for whisperCommand, whisperFunction in pairs(WhisperCommands) do
		start, split = string.find(msg, whisperCommand .. " ", 1, true);
		
		if start == 1 then
			local args = string.sub( msg, split + 1 );
			args = strtrim( args );
			
			whisperFunction( args, player, broadcast );
		end
	end
end

function MrTrader:WhisperTradeskill( args, player, broadcast )
	tradeskillID = MrTrader:MatchPartialCraftSkillName( args );
	
	if tradeskillID == "ambiguous" then
		if not broadcast then
			MrTrader:Whisper( MRTLoc["I don't know what skill you mean."] , player );
		end
	elseif tradeskillID == nil then
		if not broadcast then
			MrTrader:Whisper( MRTLoc["No skill exists by that name."] , player );
		end
	else
		local tradeskillLink, allLinks = MrTrader:GetBestSkillLink(tradeskillID);

		if tradeskillLink and self.db.profile.showAllFullLinks and getn(allLinks) > 1 then
			local count = getn(allLinks);
			for i=1, count do
				local whisperText = string.format(MRTLoc["Character %s knows %s"], i, allLinks[i][2]);
					
				if( self.db.profile.includePlayerNames ) then
					whisperText = string.format(MRTLoc["%s knows %s"], allLinks[i][1], allLinks[i][2]);
				end
					
				MrTrader:Whisper( whisperText, player );
			end
		elseif tradeskillLink then
			MrTrader:Whisper( tradeskillLink , player );
		elseif not broadcast then	
			MrTrader:Whisper( MRTLoc["I don't know that skill."] , player );
		end
	end
end

function MrTrader:Output( msg )
	if DEFAULT_CHAT_FRAME then
		DEFAULT_CHAT_FRAME:AddMessage( msg );
	end
end

function MrTrader:Whisper( msg, player )
	SendChatMessage(msg, "WHISPER", nil, player);
end

function MrTrader:TableSize(table)
	local count = 0;

	for _, _ in pairs(table) do
		count = count + 1;
	end
	
	return count;
end

function MrTrader:TableJoin(t1, t2)
        for k,v in pairs(t2) do
		t1[k] = v;
	end 
	return t1;  
end