--[[
    Necrosis LdC
    Copyright (C) 2005-2008  Lom Enfroy

    This file is part of Necrosis LdC.

    Necrosis LdC is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Necrosis LdC is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Necrosis LdC; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
--]]

------------------------------------------------------------------------------------------------------
-- Necrosis LdC
-- Par Lomig (Kael'Thas EU/FR) & Tarcalion (Nagrand US/Oceanic) 
-- Contributions deLiadora et Nyx (Kael'Thas et Elune EU/FR)
--
-- Skins et voix Françaises : Eliah, Ner'zhul
--
-- Version Allemande par Geschan
-- Version Espagnole par DosS (Zul’jin)
-- Version Russe par Komsomolka
--
-- Version $LastChangedDate: 2008-10-19 14:52:05 +1100 (Sun, 19 Oct 2008) $
------------------------------------------------------------------------------------------------------

-- One defines G as being the table containing all the existing frames.
local _G = getfenv(0)

------------------------------------------------------------------------------------------------------
-- Message handler (CONSOLE, CHAT, MESSAGE SYSTEM)
------------------------------------------------------------------------------------------------------
function Necrosis:Msg(msg, type)
	if msg then
		-- dispatch the message to the appropriate chat channel depending on the message type
		if (type == "WORLD") then
			if (GetNumRaidMembers() > 0) then
				-- send to all raid members
				SendChatMessage(msg, "RAID")
			elseif (GetNumPartyMembers() > 0) then
				-- send to party members
				SendChatMessage(msg, "PARTY")
			else
				-- not in a group so lets use the 'say' channel
				SendChatMessage(msg, "SAY")
			end
		elseif (type == "PARTY") then
			SendChatMessage(msg, "PARTY")
		elseif (type == "RAID") then
			SendChatMessage(msg, "RAID")
		elseif (type == "SAY") then
			SendChatMessage(msg, "SAY")
		elseif (type == "EMOTE") then
			SendChatMessage(msg, "EMOTE")
		elseif (type == "YELL") then
			SendChatMessage(msg, "YELL")
		else
			-- Add some color to our message :D
			msg = self:MsgAddColor(msg)
			local Intro = "|CFFFF00FFNe|CFFFF50FFcr|CFFFF99FFos|CFFFFC4FFis|CFFFFFFFF: "
			if NecrosisConfig.ChatType then
				-- ...... on the first chat frame
				ChatFrame1:AddMessage(Intro..msg, 1.0, 0.7, 1.0, 1.0, UIERRORS_HOLD_TIME)
			else
				-- ...... on the middle of the screen
				UIErrorsFrame:AddMessage(Intro..msg, 1.0, 0.7, 1.0, 1.0, UIERRORS_HOLD_TIME)
			end
		end
	end
end

------------------------------------------------------------------------------------------------------
-- Color functions
------------------------------------------------------------------------------------------------------

-- Replace any color strings in the message with its associated value
function Necrosis:MsgAddColor(msg)
	if type(msg) == "string" then
		msg = msg:gsub("<white>", "|CFFFFFFFF")
		msg = msg:gsub("<lightBlue>", "|CFF99CCFF")
		msg = msg:gsub("<brightGreen>", "|CFF00FF00")
		msg = msg:gsub("<lightGreen2>", "|CFF66FF66")
		msg = msg:gsub("<lightGreen1>", "|CFF99FF66")
		msg = msg:gsub("<yellowGreen>", "|CFFCCFF66")
		msg = msg:gsub("<lightYellow>", "|CFFFFFF66")
		msg = msg:gsub("<darkYellow>", "|CFFFFCC00")
		msg = msg:gsub("<lightOrange>", "|CFFFFCC66")
		msg = msg:gsub("<dirtyOrange>", "|CFFFF9933")
		msg = msg:gsub("<darkOrange>", "|CFFFF6600")
		msg = msg:gsub("<redOrange>", "|CFFFF3300")
		msg = msg:gsub("<red>", "|CFFFF0000")
		msg = msg:gsub("<lightRed>", "|CFFFF5555")
		msg = msg:gsub("<lightPurple1>", "|CFFFFC4FF")
		msg = msg:gsub("<lightPurple2>", "|CFFFF99FF")
		msg = msg:gsub("<purple>", "|CFFFF50FF")
		msg = msg:gsub("<darkPurple1>", "|CFFFF00FF")
		msg = msg:gsub("<darkPurple2>", "|CFFB700B7")
		msg = msg:gsub("<close>", "|r")
	end
	return msg
end

-- Adjusts the timer color based on the percentage of time left.
function NecrosisTimerColor(percent)
	local color = "<brightGreen>"
	if (percent < 10) then
		color = "<red>"
	elseif (percent < 20) then
		color = "<redOrange>"
	elseif (percent < 30) then
		color = "<darkOrange>"
	elseif (percent < 40) then
		color = "<dirtyOrange>"
	elseif (percent < 50) then
		color = "<darkYellow>"
	elseif (percent < 60) then
		color = "<lightYellow>"
	elseif (percent < 70) then
		color = "<yellowGreen>"
	elseif (percent < 80) then
		color = "<lightGreen1>"
	elseif (percent < 90) then
		color = "<lightGreen2>"
	end
	return color
end

------------------------------------------------------------------------------------------------------
-- Replace user-friendly string variables in the invocation messages
------------------------------------------------------------------------------------------------------
function Necrosis:MsgReplace(msg, target, pet)
	msg = msg:gsub("<player>", UnitName("player"))
	msg = msg:gsub("<emote>", "")
	msg = msg:gsub("<after>", "")
	msg = msg:gsub("<sacrifice>", "")
	msg = msg:gsub("<yell>", "")
	if target then
		msg = msg:gsub("<target>", target)
	end
	if pet and NecrosisConfig.PetName[pet] then
		msg = msg:gsub("<pet>", NecrosisConfig.PetName[pet])
	end
	return msg
end

------------------------------------------------------------------------------------------------------
-- Handles the posting of messages while casting a spell.
------------------------------------------------------------------------------------------------------
function Necrosis:Speech_It(Spell, Speeches, metatable)
	-- messages to be posted while summoning a mount
	if (Spell.Name == Necrosis.Spell[1].Name or Spell.Name == Necrosis.Spell[2].Name) then
		Speeches.SpellSucceed.Steed = setmetatable({}, metatable)
		if NecrosisConfig.SteedSummon and NecrosisConfig.ChatMsg and self.Speech.Demon[7] and not NecrosisConfig.SM then
			local tempnum = math.random(1, #self.Speech.Demon[7])
			while tempnum == Speeches.LastSpeech.Steed and #self.Speech.Demon[7] >= 2 do
				tempnum = math.random(1, #self.Speech.Demon[7])
			end
			Speeches.LastSpeech.Steed = tempnum
			for i in ipairs(self.Speech.Demon[7][tempnum]) do
				if self.Speech.Demon[7][tempnum][i]:find("<after>") then
					Speeches.SpellSucceed.Steed:insert(self.Speech.Demon[7][tempnum][i])
				elseif self.Speech.Demon[7][tempnum][i]:find("<emote>") then
					self:Msg(self:MsgReplace(self.Speech.Demon[7][tempnum][i]), "EMOTE")
				elseif self.Speech.Demon[7][tempnum][i]:find("<yell>") then
					self:Msg(self:MsgReplace(self.Speech.Demon[7][tempnum][i]), "YELL")
				else
					self:Msg(self:MsgReplace(self.Speech.Demon[7][tempnum][i]), "SAY")
				end
			end
		end
	-- messsages to be posted while casting 'Ritual of Souls' -Draven (April 3rd, 2008)
	elseif Spell.Name == Necrosis.Spell[50].Name then
		Speeches.SpellSucceed.RoS = setmetatable({}, metatable)
		if (NecrosisConfig.ChatMsg or NecrosisConfig.SM) and NecrosisConfig.RoSSummon and self.Speech.RoS then
			local tempnum = math.random(1, #self.Speech.RoS)
			while tempnum == Speeches.LastSpeech.RoS and #self.Speech.RoS >= 2 do
				tempnum = math.random(1, #self.Speech.RoS)
			end
			Speeches.LastSpeech.RoS = tempnum
			for i in ipairs(self.Speech.RoS[tempnum]) do
				if self.Speech.RoS[tempnum][i]:find("<after>") then
					Speeches.SpellSucceed.RoS:insert(self.Speech.RoS[tempnum][i])
				elseif self.Speech.RoS[tempnum][i]:find("<emote>") then
					self:Msg(self:MsgReplace(self.Speech.RoS[tempnum][i]), "EMOTE")
				elseif self.Speech.RoS[tempnum][i]:find("<yell>") then
					self:Msg(self:MsgReplace(self.Speech.RoS[tempnum][i]), "YELL")
				else
					self:Msg(self:MsgReplace(self.Speech.RoS[tempnum][i]), "WORLD")
				end
			end
		end
	-- messages to be posted while casting 'Soulstone' on a friendly target
	elseif Spell.Name == Necrosis.Spell[11].Name and not (Spell.TargetName == UnitName("player")) then
		Speeches.SpellSucceed.Rez = setmetatable({}, metatable)
		if (NecrosisConfig.ChatMsg or NecrosisConfig.SM) and self.Speech.Rez then
			local tempnum = math.random(1, #self.Speech.Rez)
			while tempnum == Speeches.LastSpeech.Rez and #self.Speech.Rez >= 2 do
				tempnum = math.random(1, #self.Speech.Rez)
			end
			Speeches.LastSpeech.Rez = tempnum
			for i in ipairs(self.Speech.Rez[tempnum]) do
				if self.Speech.Rez[tempnum][i]:find("<after>") then
					Speeches.SpellSucceed.Rez:insert(self.Speech.Rez[tempnum][i])
				elseif self.Speech.Rez[tempnum][i]:find("<emote>") then
					self:Msg(self:MsgReplace(self.Speech.Rez[tempnum][i], Spell.TargetName), "EMOTE")
				elseif self.Speech.Rez[tempnum][i]:find("<yell>") then
					self:Msg(self:MsgReplace(self.Speech.Rez[tempnum][i], Spell.TargetName), "YELL")
				else
					self:Msg(self:MsgReplace(self.Speech.Rez[tempnum][i], Spell.TargetName), "WORLD")
				end
			end
		end
	-- messages to be posted while casting 'Ritual of Summoning'
	elseif Spell.Name == Necrosis.Spell[37].Name then
		Speeches.SpellSucceed.TP = setmetatable({}, metatable)
		if (NecrosisConfig.ChatMsg or NecrosisConfig.SM) and self.Speech.TP then
			local tempnum = math.random(1, #self.Speech.TP)
			while tempnum == Speeches.LastSpeech.TP and #self.Speech.TP >= 2 do
				tempnum = math.random(1, #self.Speech.TP)
			end
			Speeches.LastSpeech.TP = tempnum
			for i in ipairs(self.Speech.TP[tempnum]) do
				if self.Speech.TP[tempnum][i]:find("<after>") then
					Speeches.SpellSucceed.TP:insert(self.Speech.TP[tempnum][i])
				elseif self.Speech.TP[tempnum][i]:find("<emote>") then
					self:Msg(self:MsgReplace(self.Speech.TP[tempnum][i], Spell.TargetName), "EMOTE")
				elseif self.Speech.TP[tempnum][i]:find("<yell>") then
					self:Msg(self:MsgReplace(self.Speech.TP[tempnum][i], Spell.TargetName), "YELL")
				else
					self:Msg(self:MsgReplace(self.Speech.TP[tempnum][i], Spell.TargetName), "WORLD")
				end
			end
		end
		AlphaBuffMenu = 1
		AlphaBuffVar = GetTime() + 3
	-- messages to be posted while summoning a pet demon
	else for type = 3, 7, 1 do
		if Spell.Name == Necrosis.Spell[type].Name then
			Speeches.SpellSucceed.Pet = setmetatable({}, metatable)
			Speeches.SpellSucceed.Sacrifice = setmetatable({}, metatable)
			Speeches.DemonName = type - 2
			if NecrosisConfig.DemonSummon and NecrosisConfig.ChatMsg and not NecrosisConfig.SM then
				if not NecrosisConfig.PetName[Speeches.DemonName] and self.Speech.Demon[6] then
					local tempnum = math.random(1, #self.Speech.Demon[6])
					while tempnum == Speeches.LastSpeech.Pet and #self.Speech.Demon[6] >= 2 do
						tempnum = math.random(1, #self.Speech.Demon[6])
					end
					Speeches.LastSpeech.Pet = tempnum
					for i in ipairs(self.Speech.Demon[6][tempnum]) do
						if self.Speech.Demon[6][tempnum][i]:find("<after>") then
							Speeches.SpellSucceed.Pet:insert(self.Speech.Demon[6][tempnum][i])
						elseif self.Speech.Demon[6][tempnum][i]:find("<sacrifice>")then
							Speeches.SpellSucceed.Sacrifice:insert(self.Speech.Demon[6][tempnum][i])
						elseif self.Speech.Demon[6][tempnum][i]:find("<emote>") then
							self:Msg(self:MsgReplace(self.Speech.Demon[6][tempnum][i]), "EMOTE")
						elseif self.Speech.Demon[6][tempnum][i]:find("<yell>") then
							self:Msg(self:MsgReplace(self.Speech.Demon[6][tempnum][i]), "YELL")
						else
							self:Msg(self:MsgReplace(self.Speech.Demon[6][tempnum][i]), "SAY")
						end
					end
				elseif self.Speech.Demon[Speeches.DemonName] then
					local tempnum = math.random(1, #self.Speech.Demon[Speeches.DemonName])
					while tempnum == Speeches.LastSpeech.Pet and #self.Speech.Demon[Speeches.DemonName] >= 2 do
						tempnum = math.random(1, #self.Speech.Demon[Speeches.DemonName])
					end
					Speeches.LastSpeech.Pet = tempnum
					for i in ipairs(self.Speech.Demon[Speeches.DemonName][tempnum]) do
						if self.Speech.Demon[Speeches.DemonName][tempnum][i]:find("<after>") then
							Speeches.SpellSucceed.Pet:insert(
								self.Speech.Demon[Speeches.DemonName][tempnum][i]
							)
						elseif self.Speech.Demon[Speeches.DemonName][tempnum][i]:find("<sacrifice>")then
							Speeches.SpellSucceed.Sacrifice:insert(
								self.Speech.Demon[Speeches.DemonName][tempnum][i]
							)
						elseif self.Speech.Demon[Speeches.DemonName][tempnum][i]:find("<emote>") then
							self:Msg(self:MsgReplace(self.Speech.Demon[Speeches.DemonName][tempnum][i], nil , Speeches.DemonName), "EMOTE")
						elseif self.Speech.Demon[Speeches.DemonName][tempnum][i]:find("<yell>") then
							self:Msg(self:MsgReplace(self.Speech.Demon[Speeches.DemonName][tempnum][i], nil , Speeches.DemonName), "YELL")
						else
							self:Msg(self:MsgReplace(self.Speech.Demon[Speeches.DemonName][tempnum][i], nil , Speeches.DemonName), "SAY")
						end
					end
				end
			end
			AlphaPetMenu = 1
			AlphaPetVar = GetTime() + 3
		end
	end end
	return Speeches
end

------------------------------------------------------------------------------------------------------
-- Handles the posting of messages after a spell has been cast.
------------------------------------------------------------------------------------------------------
function Necrosis:Speech_Then(Spell, DemonName, Speech)
	-- messages to be posted after a mount is summoned.
	if (Spell.Name == Necrosis.Spell[1].Name or Spell.Name == Necrosis.Spell[2].Name) then
		for i in ipairs(Speech.Steed) do
			if Speech.Steed[i]:find("<emote>") then
				self:Msg(self:MsgReplace(Speech.Steed[i]), "EMOTE")
			elseif Speech.Steed[i]:find("<yell>") then
				self:Msg(self:MsgReplace(Speech.Steed[i]), "YELL")
			else
				self:Msg(self:MsgReplace(Speech.Steed[i]), "WORLD")
			end
		end
		Speech.Steed = {}
		if _G["NecrosisMountButton"] then
			NecrosisMountButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\MountButton-02")
		end
	-- messages to be posted after a 'Ritual of Souls' is cast -Draven (April 3rd, 2008)
	elseif Spell.Name == Necrosis.Spell[50].Name then
		for i in ipairs(Speech.RoS) do
			if Speech.RoS[i]:find("<emote>") then
				self:Msg(self:MsgReplace(Speech.RoS[i]), "EMOTE")
			elseif Speech.RoS[i]:find("<yell>") then
				self:Msg(self:MsgReplace(Speech.RoS[i]), "YELL")
			else
				self:Msg(self:MsgReplace(Speech.RoS[i]), "WORLD")
			end
		end
		Speech.RoS = {}
	-- messages to be posted after 'Soulstone' is cast
	elseif Spell.Name == Necrosis.Spell[11].Name then
		for i in ipairs(Speech.Rez) do
			if Speech.Rez[i]:find("<emote>") then
				self:Msg(self:MsgReplace(Speech.Rez[i], Spell.TargetName), "EMOTE")
			elseif Speech.Rez[i]:find("<yell>") then
				self:Msg(self:MsgReplace(Speech.Rez[i], Spell.TargetName), "YELL")
			else
				self:Msg(self:MsgReplace(Speech.Rez[i], Spell.TargetName), "WORLD")
			end
		end
		Speech.Rez = {}
	-- messages to be posted after 'Ritual of Summoning' is cast
	elseif (Spell.Name == Necrosis.Spell[37].Name) then
		for i in ipairs(Speech.TP) do
			if Speech.TP[i]:find("<emote>") then
				self:Msg(self:MsgReplace(Speech.TP[i], Spell.TargetName), "EMOTE")
			elseif Speech.TP[i]:find("<yell>") then
				self:Msg(self:MsgReplace(Speech.TP[i], Spell.TargetName), "YELL")
			else
				self:Msg(self:MsgReplace(Speech.TP[i], Spell.TargetName), "WORLD")
			end
		end
		Speech.TP = {}
	-- messages to be posted after sacrificing a demon
	elseif Spell.Name == Necrosis.Spell[44].Name then
		for i in ipairs(Speech.Sacrifice) do
			if Speech.Sacrifice[i]:find("<emote>") then
				self:Msg(self:MsgReplace(Speech.Sacrifice[i], nil, DemonName), "EMOTE")
			elseif Speech.Sacrifice[i]:find("<yell>") then
				self:Msg(self:MsgReplace(Speech.Sacrifice[i], nil, DemonName), "YELL")
			else
				self:Msg(self:MsgReplace(Speech.Sacrifice[i], nil, DemonName), "SAY")
			end
		end
		Speech.Sacrifice = {}
	-- messages to be posted after summoning a demon
	elseif Spell.Name == Necrosis.Spell[3].Name
			or Spell.Name == Necrosis.Spell[4].Name
			or Spell.Name == Necrosis.Spell[5].Name
			or Spell.Name == Necrosis.Spell[6].Name
			or Spell.Name == Necrosis.Spell[7].Name
			then
				for i in ipairs(Speech.Pet) do
					if Speech.Pet[i]:find("<emote>") then
						self:Msg(self:MsgReplace(Speech.Pet[i], nil, DemonName), "EMOTE")
					elseif Speech.Pet[i]:find("<yell>") then
						self:Msg(self:MsgReplace(Speech.Pet[i], nil, DemonName), "YELL")
					else
						self:Msg(self:MsgReplace(Speech.Pet[i], nil, DemonName), "SAY")
					end
				end
				Speech.Pet = {}
	end

	return Speech
end