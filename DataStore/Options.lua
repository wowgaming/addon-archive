if not DataStore then return end

local addonName = ...
local addon = _G[addonName]
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local addonList = {
	"DataStore",
	"DataStore_Achievements",
	"DataStore_Auctions",
	"DataStore_Characters",
	"DataStore_Containers",
	"DataStore_Crafts",
	"DataStore_Currencies",
	"DataStore_Inventory",
	"DataStore_Mails",
	"DataStore_Pets",
	"DataStore_Quests",
	"DataStore_Reputations",
	"DataStore_Skills",
	"DataStore_Spells",
	"DataStore_Stats",
	"DataStore_Talents",
}


local WHITE		= "|cFFFFFFFF"
local TEAL		= "|cFF00FF9A"
local ORANGE   = "|cFFFF8400"
local GREEN		= "|cFF00FF00"
local RED		= "|cFFFF0000"

-- *** DataStore's own help topics ***
local help = {
	{	name = "General",
		questions = {
			"What is DataStore?",
			"What are the advantages of this approach?",
			"What do all these modules do? Do I need to enable them all?",
			"How should I update DataStore and its modules?",
		},
		answers = {
			"DataStore is the main component of a series of addons that serve as data repositories in game. Their respective purpose is to offer scanning and storing services to other addons.",
			format("%s\n\n%s\n%s\n%s\n%s",
				"There are multiple advantages, for both players and developers:",
				"- Data is scanned only once for all client addons (performance gain).",
				"- Data is stored only once for all client addons (memory gain).",
				"- Add-on authors can spend more time coding higher level features.",
				"- Each module is an independant add-on, and therefore has its own SavedVariables file, meaning that you could clean a module's data without disturbing other modules."
			),
			format("%s\n\n%s",
				"'DataStore' is the main module, client add-ons should have a dependency on it, it should therefore remain enabled all the time, as it is the interface used to access data from the various modules.",
				"The other modules are technically all optional, and could be enabled/disabled according to your needs. However, for the time being, Altoholic has not yet been modified to fully support this approach. It will happen soon(tm)!"
			),
			format("%s\n\n%s",
				"Altoholic is always packaged with the latest versions, most users should upgrade using this method.",
				"If you really can't wait, refer to the add-on's homepage in the 'About' panel. The homepage contains links to all the modules' projects on CurseForge. Alphas are available there for advanced users who are courageous enough to test new bu.. I mean new features!"
			)
		}
	},
	{	name = "Clearing data",
		questions = {
			"How do I clear data from DataStore?",
			"What if I want to get rid of Saved Variables?",
		},
		answers = {
			"At this point, characters and guilds can be erased from Altoholic's UI.",
			format("%s\n\n%s",
				"Databases are located in |cFFFFFFFFWTF \\ Account \\ <your_account> \\ SavedVariables|r.",
				format("If you deem it necessary, you can delete %sDataStore.lua|r and all %sDataStore_*.lua|r", GREEN, GREEN)
			),
		}
	},
}


-- *** Utility functions ***
local infoText

-- very basic support for info panes (FAQ, sections, text.. ), improve later if necessary, see if a lib exists to do that, etc..
local function AddHelpLine(str)
	infoText = format("%s%s\n", infoText, str)
end

local function AddSection(section)
	AddHelpLine(format("%s|r\n", ORANGE..section))
end

local function AddQuestion(question)
	AddHelpLine(format("%s) %s", WHITE.."Q", TEAL..question))
end

local function AddAnswer(answer)
	AddHelpLine(format("%s) |r%s\n", WHITE.."A", answer))
end

local function AddBulletedText(text)
	AddHelpLine(format("%s-|r %s\n", WHITE, text))
end

function addon:SetupInfoPanel(info, helpFrame)
	infoText = ""
	
	for _, section in ipairs(info) do
		AddSection(section.name)
		
		if section.questions then
			for i = 1, #section.questions do
				AddQuestion(section.questions[i])
				AddAnswer(section.answers[i])
			end
			
		elseif section.bulletedList then
			for _, text in ipairs(section.bulletedList) do
				AddBulletedText(text)
			end			
		
		elseif section.textLines then
			for _, text in ipairs(section.textLines) do
				AddHelpLine(text)
			end
		end
	end
	
	helpFrame:SetText(infoText)
	infoText = nil
end

function addon:AddOptionCategory(frame, name, parent)
	-- tiny wrapper to add categories in Blizzard's options panel
	frame.name = name
	frame.parent = parent
	InterfaceOptions_AddCategory(frame)
end

function addon:SetupOptions()
	addon:AddOptionCategory(DataStoreGeneralOptions, addonName)
	LibStub("LibAboutPanel").new(addonName, addonName);
	addon:AddOptionCategory(DataStoreHelp, HELP_LABEL, addonName)	-- more categories will be added as the various modules' OnEnable() get called.

	addon:SetupInfoPanel(help, DataStoreHelp_Text)
	
	DataStoreGeneralOptions_Title:SetText(TEAL..format("DataStore %s", DataStore.Version))
	
	-- manually adjust the width of a few panes, as resolution/scale may have an impact on the layout
	local width = InterfaceOptionsFramePanelContainer:GetWidth() - 45
	DataStoreHelp:SetWidth(width)
	DataStoreHelp_ScrollFrame:SetWidth(width)
	DataStoreHelp_Text:SetWidth(width-35)
end

function addon:ToggleOption(frame, module, option)
	if frame:GetChecked() then 
		addon:SetOption(module, option, 1)
	else
		addon:SetOption(module, option, 0)
	end
end

function addon:UpdateMyMemoryUsage()
	collectgarbage()
	addon:UpdateMemoryUsage(addonList, DataStoreGeneralOptions, format(L["Memory used for %d |4character:characters;:"], addon:GetNumCharactersInDB()))
end

function addon:UpdateMemoryUsage(addons, parent, totalText)
	UpdateAddOnMemoryUsage()
	
	local memInKb
	local totalMem = 0
	local text
	local list = ""
	local name = parent:GetName()
	
	-- title
	_G[name .. "_AddonsText"]:SetText(ORANGE..ADDONS)
	
	-- headers
	for index, dsModule in ipairs(addons) do
		list = format("%s%s:\n", list, dsModule)
	end

	list = format("%s\n%s", list, totalText)
	_G[name .. "_AddonsList"]:SetText(list)
		
	-- memory used
	list = ""
	for index, module in ipairs(addons) do
		if IsAddOnLoaded(module) then	-- module is enabled
			memInKb = GetAddOnMemoryUsage(module)
			totalMem = totalMem + memInKb
			
			if memInKb < 1024 then
				text = format("%s%.0f %sKB", GREEN, memInKb, WHITE)
			else
				text = format("%s%.2f %sMB", GREEN, memInKb/1024, WHITE)
			end
		else	-- module is disabled
			text = RED..ADDON_DISABLED
		end
		
		list = format("%s%s\n", list, text)
	end
	
	list = format("%s\n%s", list, format("%s%.2f %sMB", GREEN, totalMem/1024, WHITE))
	_G[name .. "_AddonsMem"]:SetText(list)	
end

function addon:SetCheckBoxTooltip(frame, title, whenEnabled, whenDisabled)
	frame.tooltipText = title
	frame.tooltipRequirement = format("%s|r:\n%s\n\n%s|r:\n%s", GREEN..L["Enabled"], whenEnabled, RED..L["Disabled"], whenDisabled)
end

local OptionsPanelWidth, OptionsPanelHeight
local lastOptionsPanelWidth = 0
local lastOptionsPanelHeight = 0

function addon:OnUpdate(self, mandatoryResize)
	OptionsPanelWidth = InterfaceOptionsFramePanelContainer:GetWidth()
	OptionsPanelHeight = InterfaceOptionsFramePanelContainer:GetHeight()
	
	if not mandatoryResize then -- if resize is not mandatory, allow exit
		if OptionsPanelWidth == lastOptionsPanelWidth and OptionsPanelHeight == lastOptionsPanelHeight then return end		-- no size change ? exit
	end
	
	lastOptionsPanelWidth = OptionsPanelWidth
	lastOptionsPanelHeight = OptionsPanelHeight
	
	DataStoreHelp:SetWidth(OptionsPanelWidth-45)
	DataStoreHelp_ScrollFrame:SetWidth(OptionsPanelWidth-45)
	DataStoreHelp:SetHeight(OptionsPanelHeight-30)
	DataStoreHelp_ScrollFrame:SetHeight(OptionsPanelHeight-30)
	DataStoreHelp_Text:SetWidth(OptionsPanelWidth-80)
end
