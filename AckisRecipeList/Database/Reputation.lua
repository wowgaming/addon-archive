--[[
************************************************************************
Reputation.lua
Reputation data for all of Ackis Recipe List
************************************************************************
File date: 2009-12-30T10:16:20Z 
File revision: 2785 
Project revision: 2817
Project version: v1.0-r2818
************************************************************************
Format:
	self:addLookupList(RepDB,Rep ID, Rep Name)
************************************************************************
Please see http://www.wowace.com/addons/arl/ for more information.
************************************************************************
This source code is released under All Rights Reserved.
************************************************************************
]]--

local MODNAME	= "Ackis Recipe List"
local addon	= LibStub("AceAddon-3.0"):GetAddon(MODNAME)
local L		= LibStub("AceLocale-3.0"):GetLocale(MODNAME)
local BFAC	= LibStub("LibBabble-Faction-3.0"):GetLookupTable()

function addon:InitReputation(RepDB)
	self:addLookupList(RepDB,59,BFAC["Thorium Brotherhood"],"N/A")
	self:addLookupList(RepDB,270,BFAC["Zandalar Tribe"],"N/A")
	self:addLookupList(RepDB,529,BFAC["Argent Dawn"],"N/A")
	self:addLookupList(RepDB,576,BFAC["Timbermaw Hold"],"N/A")
	self:addLookupList(RepDB,609,BFAC["Cenarion Circle"],"N/A")
	self:addLookupList(RepDB,932,BFAC["The Aldor"],"N/A")
	self:addLookupList(RepDB,933,BFAC["The Consortium"],"N/A")
	self:addLookupList(RepDB,934,BFAC["The Scryers"],"N/A")
	self:addLookupList(RepDB,935,BFAC["The Sha'tar"],"N/A")
	self:addLookupList(RepDB,941,BFAC["The Mag'har"],"N/A")
	self:addLookupList(RepDB,942,BFAC["Cenarion Expedition"],"N/A")
	self:addLookupList(RepDB,946,BFAC["Honor Hold"],"N/A")
	self:addLookupList(RepDB,947,BFAC["Thrallmar"],"N/A")
	self:addLookupList(RepDB,967,BFAC["The Violet Eye"],"N/A")
	self:addLookupList(RepDB,970,BFAC["Sporeggar"],"N/A")
	self:addLookupList(RepDB,978,BFAC["Kurenai"],"N/A")
	self:addLookupList(RepDB,989,BFAC["Keepers of Time"],"N/A")
	self:addLookupList(RepDB,990,BFAC["The Scale of the Sands"],"N/A")
	self:addLookupList(RepDB,1011,BFAC["Lower City"],"N/A")
	self:addLookupList(RepDB,1012,BFAC["Ashtongue Deathsworn"],"N/A")
	self:addLookupList(RepDB,1037,BFAC["Alliance Vanguard"],"N/A")
	self:addLookupList(RepDB,1050,BFAC["Valiance Expedition"],"N/A")
	self:addLookupList(RepDB,1052,BFAC["Horde Expedition"],"N/A")
	self:addLookupList(RepDB,1064,BFAC["The Taunka"],"N/A")
	self:addLookupList(RepDB,1067,BFAC["The Hand of Vengeance"],"N/A")
	self:addLookupList(RepDB,1068,BFAC["Explorers' League"],"N/A")
	self:addLookupList(RepDB,1073,BFAC["The Kalu'ak"],"N/A")
	self:addLookupList(RepDB,1077,BFAC["Shattered Sun Offensive"],"N/A")
	self:addLookupList(RepDB,1085,BFAC["Warsong Offensive"],"N/A")
	self:addLookupList(RepDB,1090,BFAC["Kirin Tor"],"N/A")
	self:addLookupList(RepDB,1091,BFAC["The Wyrmrest Accord"],"N/A")
	self:addLookupList(RepDB,1098,BFAC["Knights of the Ebon Blade"],"N/A")
	self:addLookupList(RepDB,1104,BFAC["Frenzyheart Tribe"],"N/A")
	self:addLookupList(RepDB,1105,BFAC["The Oracles"],"N/A")
	self:addLookupList(RepDB,1106,BFAC["Argent Crusade"],"N/A")
	self:addLookupList(RepDB,1119,BFAC["The Sons of Hodir"],"N/A")
	self:addLookupList(RepDB,1156,BFAC["The Ashen Verdict"],"N/A")
end
