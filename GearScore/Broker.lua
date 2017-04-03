--Created by Fyrye



--@Fyrye: 
--I intergrated this directly within the addon.
--I also commented off the "Pruneing" function because it doesnt really work in the same way anymore. The pruning is down almost all automatically and it doesnt actually remove "low" scores anymore.
--Next, when Opening the options menu I set the variable "GearScore_DontDisplayDataAfterClosingOptions = true" so that when they open the options menu from this method
--it wont cause the profiles screen to display afterwards. (I made the appropriate changes within the addon as well)


GearScoreLDB = {}
function GearScoreLDB:Initialize()
	self.LDB = LibStub("LibDataBroker-1.1", true);
	self.DataObj = self.LDB:NewDataObject("GearScore",
	{
		type = "data source",
		icon = "Interface\\ICONS\\INV_Chest_Plate12",
		text = "GearScore",
		OnClick = function(pFrame, pButton) self:OnClick(pFrame, pButton); end,
		OnTooltipShow = function(tooltip)
			if not tooltip or not tooltip.AddLine then return end
			tooltip:AddLine("GearScore",1,1,1)
			tooltip:AddLine("|cff7fff7fClick|r to show GearScore profile UI.")
			tooltip:AddLine("|cff7fff7fShift-click|r to show the GearScore database.")
			--tooltip:AddLine("|cff7fff7fAlt-click|r to Prune the database of low GearScores.")
			tooltip:AddLine("|cff7fff7fRight-click|r to show GearScore Options.")
			tooltip:AddLine(" ")
		end,
	});

	StaticPopupDialogs["GearScoreLDBPrompt"] = {
  		text = "Are you sure you want to prune your GearScore Database?",
  		button1 = "Yes",
  		button2 = "No",
  		OnAccept = function()
      			GearScore_Prune()
  		end,
  		timeout = 0,
  		whileDead = 1,
  		hideOnEscape = 1
	};
end

local pTarget
function GearScoreLDB:OnClick(pFrame, pButton)
	if pButton == "LeftButton" then
		if IsAltKeyDown() then
		 	--StaticPopup_Show("GearScoreLDBPrompt")
		elseif IsShiftKeyDown() then
			GearScore_HideOptions()
			GearScore_DisplayDatabase()		
		else
			GS_SCANSET("")
		end
	else
		GearScore_DontDisplayDataAfterClosingOptions = true
		GearScore_ShowOptions()
	end
end

GearScoreLDB:Initialize();