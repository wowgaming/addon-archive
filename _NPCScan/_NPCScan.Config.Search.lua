--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * _NPCScan.Config.Search.lua - Adds a configuration pane to add/remove NPCs  *
  *   and achievements to search for.                                          *
  ****************************************************************************]]


local _NPCScan = select( 2, ... );
local L = _NPCScan.L;
local me = CreateFrame( "Frame" );
_NPCScan.Config.Search = me;

me.AddFoundCheckbox = CreateFrame( "CheckButton", "_NPCScanSearchAchievementAddFoundCheckbox", me, "InterfaceOptionsCheckButtonTemplate" );

me.TableContainer = CreateFrame( "Frame", nil, me );

me.NPCControls = CreateFrame( "Frame", nil, me.TableContainer );
me.NPCName = CreateFrame( "EditBox", "_NPCScanSearchNpcName", me.NPCControls, "InputBoxTemplate" );
me.NPCNpcID = CreateFrame( "EditBox", "_NPCScanSearchNpcID", me.NPCControls, "InputBoxTemplate" );
me.NPCWorld = CreateFrame( "EditBox", "_NPCScanSearchNpcWorld", me.NPCControls, "InputBoxTemplate" );
me.NPCWorldButton = CreateFrame( "Button", nil, me.NPCWorld );
me.NPCWorldButton.Dropdown = CreateFrame( "Frame", "_NPCScanSearchNPCWorldDropdown", me.NPCWorldButton );
me.NPCAdd = CreateFrame( "Button", nil, me.NPCControls, "GameMenuButtonTemplate" );
me.NPCRemove = CreateFrame( "Button", nil, me.NPCControls, "GameMenuButtonTemplate" );

me.InactiveAlpha = 0.5;

local LibRareSpawnsData;
if ( IsAddOnLoaded( "LibRareSpawns" ) ) then
	LibRareSpawnsData = LibRareSpawns.ByNPCID;
end




--- Sets the search for found achievement mobs option when its checkbox is clicked.
function me.AddFoundCheckbox.setFunc ( Enable )
	if ( _NPCScan.SetAchievementsAddFound( Enable == "1" ) ) then
		_NPCScan.CacheListPrint( true );
	end
end




--- Converts a localized world name into a WorldID.
local function GetWorldID ( World )
	if ( World ~= "" ) then
		return _NPCScan.ContinentIDs[ World ] or World;
	end
end
-- Converts a WorldID into a localized world name.
local function GetWorldIDName ( WorldID )
	return type( WorldID ) == "number" and select( WorldID, GetMapContinents() ) or WorldID;
end
--- Selects the given table tab.
function me.TabSelect ( NewTab )
	local OldTab = me.TabSelected;
	if ( NewTab ~= OldTab ) then
		if ( OldTab ) then
			if ( OldTab.Deactivate ) then
				OldTab:Deactivate();
			end
			PanelTemplates_DeselectTab( OldTab );
		end

		for _, Row in ipairs( me.Table.Rows ) do
			Row:SetAlpha( 1.0 );
		end
		me.Table:Clear();

		me.TabSelected = NewTab;
		PanelTemplates_SelectTab( NewTab );
		if ( NewTab.Activate ) then
			NewTab:Activate();
		end
		NewTab:Update();
	end
end
--- Selects a tab's table view when clicked.
function me:TabOnClick ()
	PlaySound( "igCharacterInfoTab" );
	me.TabSelect( self );
end
--- Displays a tooltip for a table tab when moused over.
function me:TabOnEnter ()
	GameTooltip:SetOwner( self, "ANCHOR_TOPLEFT", 0, -8 );
	if ( self.AchievementID ) then
		local _, Name, _, _, _, _, _, Description = GetAchievementInfo( self.AchievementID );
		local WorldID = _NPCScan.Achievements[ self.AchievementID ].WorldID;
		local Highlight = HIGHLIGHT_FONT_COLOR;
		if ( WorldID ) then
			GameTooltip:ClearLines();
			local Gray = GRAY_FONT_COLOR;
			GameTooltip:AddDoubleLine( Name, L.SEARCH_WORLD_FORMAT:format( GetWorldIDName( WorldID ) ),
				Highlight.r, Highlight.g, Highlight.b, Gray.r, Gray.g, Gray.b );
		else
			GameTooltip:SetText( Name, Highlight.r, Highlight.g, Highlight.b );
		end
		GameTooltip:AddLine( Description, nil, nil, nil, true );

		if ( not _NPCScan.OptionsCharacter.Achievements[ self.AchievementID ] ) then
			local Color = RED_FONT_COLOR;
			GameTooltip:AddLine( L.SEARCH_ACHIEVEMENT_DISABLED, Color.r, Color.g, Color.b );
		end
	else
		GameTooltip:SetText( L.SEARCH_NPCS_DESC, nil, nil, nil, nil, true );
	end
	GameTooltip:Show();
end
--- Enables or disables tracking an achievement when its tab checkbox is clicked.
function me:TabCheckOnClick ()
	local Enable = self:GetChecked();
	PlaySound( Enable and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff" );

	local AchievementID = self:GetParent().AchievementID;
	me.AchievementSetEnabled( AchievementID, Enable );
	if ( not Enable ) then
		_NPCScan.AchievementRemove( AchievementID );
	elseif ( _NPCScan.AchievementAdd( AchievementID ) ) then -- Cache might have changed
		_NPCScan.CacheListPrint( true );
	end
end
--- Show's the tab's tooltip when mousing over the tab's checkbox.
function me:TabCheckOnEnter ()
	me.TabOnEnter( self:GetParent() );
end




local Tabs = {}; -- [ "NPC" or AchievementID ] = Tab;
--- Validates ability to use add and remove buttons for NPCs.
function me.NPCValidate ()
	local NpcID, Name, WorldID = me.NPCNpcID:GetNumber(), me.NPCName:GetText(), GetWorldID( me.NPCWorld:GetText() );

	local OldName = _NPCScan.OptionsCharacter.NPCs[ NpcID ];
	local OldWorldID = _NPCScan.OptionsCharacter.NPCWorldIDs[ NpcID ];
	local CanAdd = NpcID and Name ~= ""
		and NpcID >= 1 and NpcID <= _NPCScan.NpcIDMax
		and ( Name ~= OldName or WorldID ~= OldWorldID );

	-- Color world name orange if not a standard continent
	local WorldColor = type( WorldID ) == "string" and ORANGE_FONT_COLOR or HIGHLIGHT_FONT_COLOR;
	me.NPCWorld:SetTextColor( WorldColor.r, WorldColor.g, WorldColor.b );

	if ( me.Table ) then
		me.Table:SetSelectionByKey( OldName and NpcID or nil );
	end
	me.NPCAdd[ CanAdd and "Enable" or "Disable" ]( me.NPCAdd );
	me.NPCRemove[ OldName and "Enable" or "Disable" ]( me.NPCRemove );
end
--- Clears the NPC controls.
function me.NPCClear ()
	me.NPCNpcID:SetText( "" );
	me.NPCName:SetText( "" );
	me.NPCWorld:SetText( "" );
end
--- Adds a Custom NPC list element.
function me.NPCAdd:OnClick ()
	local NpcID, Name, WorldID = me.NPCNpcID:GetNumber(), me.NPCName:GetText(), GetWorldID( me.NPCWorld:GetText() );
	if ( _NPCScan.TamableIDs[ NpcID ] ) then
		_NPCScan.Print( L.SEARCH_ADD_TAMABLE_FORMAT:format( Name ) );
	end
	_NPCScan.NPCRemove( NpcID );
	if ( _NPCScan.NPCAdd( NpcID, Name, WorldID ) ) then
		_NPCScan.CacheListPrint( true );
	end
	me.NPCClear();
end
--- Removes a Custom NPC list element.
function me.NPCRemove:OnClick ()
	_NPCScan.NPCRemove( me.NPCNpcID:GetNumber() );
	me.NPCClear();
end
--- Cycles through edit box controls.
function me:NPCOnTabPressed ()
	self.NextEditBox:SetFocus();
end
--- Attempts to add the entered NPC when enter is pressed in any edit box.
function me:NPCOnEnterPressed ()
	self:ClearFocus();
	me.NPCAdd:Click();
end
--- Fills in the edit boxes when a table row is selected.
function me:NPCOnSelect ( NpcID )
	if ( NpcID ~= nil ) then
		me.NPCNpcID:SetNumber( NpcID );
		me.NPCName:SetText( _NPCScan.OptionsCharacter.NPCs[ NpcID ] );
		me.NPCWorld:SetText( GetWorldIDName( _NPCScan.OptionsCharacter.NPCWorldIDs[ NpcID ] ) or "" );
	end
end
--- Builds a dropdown of continent names.
function me.NPCWorldButton.Dropdown:initialize ()
	local Info = UIDropDownMenu_CreateInfo();
	Info.func = self.OnSelect;
	for Index = 1, select( "#", GetMapContinents() ) do
		local World = select( Index, GetMapContinents() );
		Info.text, Info.arg1 = World, World;
		UIDropDownMenu_AddButton( Info );
	end
	local CurrentWorld = GetInstanceInfo();
	if ( not _NPCScan.ContinentIDs[ CurrentWorld ] ) then -- Add current instance name
		-- Spacer
		Info = UIDropDownMenu_CreateInfo();
		Info.disabled = 1;
		UIDropDownMenu_AddButton( Info );
		-- Current instance
		Info.disabled = nil;
		Info.text, Info.arg1 = CurrentWorld, CurrentWorld;
		Info.colorCode = ORANGE_FONT_COLOR_CODE;
		Info.func = self.OnSelect;
		UIDropDownMenu_AddButton( Info );
	end
end
--- Selects a preset world name from the dropdown.
function me.NPCWorldButton.Dropdown:OnSelect ( Name )
	me.NPCWorld:SetText( Name );
end
--- Opens a dropdown with world name presets.
function me.NPCWorldButton:OnClick ()
	local Parent = self:GetParent();
	Parent:ClearFocus();
	ToggleDropDownMenu( nil, nil, self.Dropdown );
	PlaySound( "igMainMenuOptionCheckBoxOn" );
end
--- Hides the dropdown if its button is hidden.
function me.NPCWorldButton:OnHide ()
	CloseDropDownMenus();
end
--- Fills the search table with custom NPCs.
function me:NPCUpdate ()
	me.NPCValidate();
	local WorldIDs = _NPCScan.OptionsCharacter.NPCWorldIDs;
	for NpcID, Name in pairs( _NPCScan.OptionsCharacter.NPCs ) do
		local Row = me.Table:AddRow( NpcID,
			_NPCScan.TestID( NpcID ) and [[|TInterface\RaidFrame\ReadyCheck-NotReady:0|t]] or nil,
			Name, NpcID, GetWorldIDName( WorldIDs[ NpcID ] ) );

		if ( not _NPCScan.NPCIsActive( NpcID ) ) then
			Row:SetAlpha( me.InactiveAlpha );
		end
	end
end
--- Customizes the table when the NPCs tab is selected.
function me:NPCActivate ()
	me.Table:SetHeader( L.SEARCH_CACHED, L.SEARCH_NAME, L.SEARCH_ID, L.SEARCH_WORLD );
	me.Table:SetSortHandlers( true, true, true, true );
	me.Table:SetSortColumn( 2 ); -- Default by name

	me.NPCClear();
	me.NPCControls:Show();
	me.TableContainer:SetPoint( "BOTTOM", me.NPCControls, "TOP", 0, 4 );
	me.Table.OnSelect = me.NPCOnSelect;
end
--- Undoes customization to the table when leaving the NPCs tab.
function me:NPCDeactivate ()
	me.NPCControls:Hide();
	me.TableContainer:SetPoint( "BOTTOM", me.NPCControls );
	me.Table.OnSelect = nil;
end




--- Enables/disables the achievement related to a tab.
function me.AchievementSetEnabled ( AchievementID, Enable )
	local Tab = Tabs[ AchievementID ];
	Tab.Checkbox:SetChecked( Enable );
	local Texture = Tab.Checkbox:GetCheckedTexture();
	Texture:SetTexture( Enable
		and [[Interface\Buttons\UI-CheckBox-Check]]
		or [[Interface\RAIDFRAME\ReadyCheck-NotReady]] );
	Texture:Show();

	-- Update tooltip if shown
	if ( GameTooltip:GetOwner() == Tab ) then
		me.TabOnEnter( Tab );
	end

	if ( me.TabSelected == Tab ) then
		me.Table.Header:SetAlpha( Enable and 1.0 or me.InactiveAlpha );
	end
end
--- Fills the search table with achievement NPCs.
function me:AchievementUpdate ()
	local Achievement = _NPCScan.Achievements[ self.AchievementID ];
	for CriteriaID, NpcID in pairs( Achievement.Criteria ) do
		local Name, _, Completed = GetAchievementCriteriaInfo( CriteriaID );

		local Row = me.Table:AddRow( NpcID,
			_NPCScan.TestID( NpcID ) and [[|TInterface\RaidFrame\ReadyCheck-NotReady:0|t]] or nil,
			Name, NpcID,
			Completed and [[|TInterface\RaidFrame\ReadyCheck-Ready:0|t]] or nil );

		if ( not _NPCScan.AchievementNPCIsActive( Achievement, NpcID ) ) then
			Row:SetAlpha( me.InactiveAlpha );
		end
	end
end
--- Customizes the table when an achievement tab is selected.
function me:AchievementActivate ()
	me.Table:SetHeader( L.SEARCH_CACHED, L.SEARCH_NAME, L.SEARCH_ID, L.SEARCH_COMPLETED );
	me.Table:SetSortHandlers( true, true, true, true );
	me.Table:SetSortColumn( 2 ); -- Default by name

	me.Table.Header:SetAlpha( _NPCScan.OptionsCharacter.Achievements[ self.AchievementID ] and 1.0 or me.InactiveAlpha );
end
--- Undoes customization to the table when leaving an achievement tab.
function me:AchievementDeactivate ()
	me.Table.Header:SetAlpha( 1.0 );
end




do
	--- Recreates table data at most once per frame.
	local function OnUpdate ( self )
		self:SetScript( "OnUpdate", nil );

		for _, Row in ipairs( me.Table.Rows ) do
			Row:SetAlpha( 1.0 );
		end
		me.Table:Clear();
		me.TabSelected:Update();
	end
	--- Updates the table for a given tab if it is displayed.
	function me.UpdateTab ( ID )
		if ( not ID or Tabs[ ID ] == me.TabSelected ) then
			me.TableContainer:SetScript( "OnUpdate", OnUpdate );
		end;
	end
end


if ( LibRareSpawnsData ) then
	local MaxSize = 160; -- Larger images are forced to this max width and height
	--- Adds mob info from LibRareSpawns to each row.
	function me:TableRowOnEnter ()
		local Data = LibRareSpawnsData[ self:GetData() ];
		if ( Data ) then
			local Width, Height = Data.PortraitWidth, Data.PortraitHeight;
			if ( Width > MaxSize ) then
				Width, Height = MaxSize, Height * ( MaxSize / Width );
			end
			if ( Height > MaxSize ) then
				Width, Height = Width * ( MaxSize / Height ), MaxSize;
			end

			GameTooltip:SetOwner( self, "ANCHOR_TOPRIGHT" );
			GameTooltip:SetText( "|T"..Data.Portrait..":"..Height..":"..Width.."|t" );
			GameTooltip:AddLine( L.SEARCH_LEVEL_TYPE_FORMAT:format( Data.Level, Data.MonsterType ) );
			GameTooltip:Show();
		end
	end
end
do
	local CreateRowBackup;
	if ( LibRareSpawnsData ) then
		--- Adds mouseover tooltip hooks to new rows.
		local function AddTooltipHooks( Row, ... )
			Row:SetScript( "OnEnter", me.TableRowOnEnter );
			Row:SetScript( "OnLeave", GameTooltip_Hide );

			return Row, ...;
		end
		--- Hooks new table rows.
		function me:TableCreateRow ( ... )
			return AddTooltipHooks( CreateRowBackup( self, ... ) );
		end
	end
	--- Creates the NPC table frame at most once.
	function me:TableCreate ()
		-- Note: Keep late bound so _NPCScan.Overlay can hook into the table as it's created
		if ( not self.Table ) then
			self.Table = LibStub( "LibTextTable-1.0" ).New( nil, self.TableContainer );
			self.Table:SetAllPoints();

			if ( LibRareSpawnsData ) then
				-- Hook row creation to add mouseover tooltips
				CreateRowBackup = self.Table.CreateRow;
				self.Table.CreateRow = self.TableCreateRow;
			end

			return self.Table;
		end
	end
end
--- Creates the NPC table when first shown, and selects the Custom NPCs tab.
function me:OnShow ()
	if ( not me.Table ) then
		me:TableCreate();
	end

	if ( me.TabSelected ) then
		me.UpdateTab();
	else
		me.TabSelect( Tabs[ "NPC" ] );
	end
end
--- Reverts to default options.
function me:default ()
	_NPCScan.Synchronize( _NPCScan.Options ); -- Resets only character settings
end




me.name = L.SEARCH_TITLE;
me.parent = L.CONFIG_TITLE;
me:Hide();
me:SetScript( "OnShow", me.OnShow );

-- Pane title
local Title = me:CreateFontString( nil, "ARTWORK", "GameFontNormalLarge" );
Title:SetPoint( "TOPLEFT", 16, -16 );
Title:SetText( L.SEARCH_TITLE );
local SubText = me:CreateFontString( nil, "ARTWORK", "GameFontHighlightSmall" );
SubText:SetPoint( "TOPLEFT", Title, "BOTTOMLEFT", 0, -8 );
SubText:SetPoint( "RIGHT", -32, 0 );
SubText:SetHeight( 32 );
SubText:SetJustifyH( "LEFT" );
SubText:SetJustifyV( "TOP" );
SubText:SetText( L.SEARCH_DESC );


-- Settings checkboxes
me.AddFoundCheckbox:SetPoint( "TOPLEFT", SubText, "BOTTOMLEFT", -2, -8 );
me.AddFoundCheckbox.tooltipText = L.SEARCH_ACHIEVEMENTADDFOUND_DESC;
local Label = _G[ me.AddFoundCheckbox:GetName().."Text" ];
Label:SetText( L.SEARCH_ACHIEVEMENTADDFOUND );
me.AddFoundCheckbox:SetHitRectInsets( 4, 4 - Label:GetStringWidth(), 4, 4 );


-- Controls for NPCs table
me.NPCControls:Hide();

-- Create add and remove buttons
me.NPCRemove:SetSize( 16, 20 );
me.NPCRemove:SetPoint( "BOTTOMRIGHT", me, -16, 16 );
me.NPCRemove:SetText( L.SEARCH_REMOVE );
me.NPCRemove:SetScript( "OnClick", me.NPCRemove.OnClick );
me.NPCAdd:SetSize( 16, 20 );
me.NPCAdd:SetPoint( "BOTTOMRIGHT", me.NPCRemove, "TOPRIGHT", 0, 4 );
me.NPCAdd:SetText( L.SEARCH_ADD );
me.NPCAdd:SetScript( "OnClick", me.NPCAdd.OnClick );
me.NPCAdd:SetScript( "OnEnter", _NPCScan.Config.ControlOnEnter );
me.NPCAdd:SetScript( "OnLeave", GameTooltip_Hide );
me.NPCAdd.tooltipText = L.SEARCH_ADD_DESC;

-- Create edit boxes
local NameLabel = me.NPCControls:CreateFontString( nil, "ARTWORK", "GameFontHighlight" );
NameLabel:SetPoint( "LEFT", me, 16, 0 );
NameLabel:SetPoint( "TOP", me.NPCRemove );
NameLabel:SetPoint( "BOTTOM", me.NPCRemove );
NameLabel:SetText( L.SEARCH_NAME );
local NpcIDLabel = me.NPCControls:CreateFontString( nil, "ARTWORK", "GameFontHighlight" );
NpcIDLabel:SetPoint( "LEFT", NameLabel );
NpcIDLabel:SetPoint( "TOP", me.NPCAdd );
NpcIDLabel:SetPoint( "BOTTOM", me.NPCAdd );
NpcIDLabel:SetText( L.SEARCH_ID );

local function EditBoxSetup ( self )
	self:SetAutoFocus( false );
	self:SetScript( "OnTabPressed", me.NPCOnTabPressed );
	self:SetScript( "OnEnterPressed", me.NPCOnEnterPressed );
	self:SetScript( "OnTextChanged", me.NPCValidate );
	self:SetScript( "OnEnter", _NPCScan.Config.ControlOnEnter );
	self:SetScript( "OnLeave", GameTooltip_Hide );
	return self;
end
local NpcID, Name, World = EditBoxSetup( me.NPCNpcID ), EditBoxSetup( me.NPCName ), EditBoxSetup( me.NPCWorld );
Name:SetPoint( "LEFT", -- Attach to longest label
	NameLabel:GetStringWidth() > NpcIDLabel:GetStringWidth() and NameLabel or NpcIDLabel,
	"RIGHT", 8, 0 );
Name:SetPoint( "RIGHT", me.NPCRemove, "LEFT", -4, 0 );
Name:SetPoint( "TOP", NameLabel );
Name:SetPoint( "BOTTOM", NameLabel );
Name.NextEditBox, Name.tooltipText = NpcID, L.SEARCH_NAME_DESC;

NpcID:SetPoint( "LEFT", Name );
NpcID:SetPoint( "TOP", NpcIDLabel );
NpcID:SetPoint( "BOTTOM", NpcIDLabel );
NpcID:SetWidth( 64 );
NpcID:SetNumeric( true );
NpcID:SetMaxLetters( floor( log10( _NPCScan.NpcIDMax ) ) + 1 );
NpcID.NextEditBox, NpcID.tooltipText = World, L.SEARCH_ID_DESC;

local WorldLabel = me.NPCControls:CreateFontString( nil, "ARTWORK", "GameFontHighlight" );
WorldLabel:SetPoint( "LEFT", NpcID, "RIGHT", 8, 0 );
WorldLabel:SetPoint( "TOP", NpcIDLabel );
WorldLabel:SetPoint( "BOTTOM", NpcIDLabel );
WorldLabel:SetText( L.SEARCH_WORLD );

World:SetPoint( "LEFT", WorldLabel, "RIGHT", 8, 0 );
World:SetPoint( "RIGHT", Name );
World:SetPoint( "TOP", NpcIDLabel );
World:SetPoint( "BOTTOM", NpcIDLabel );
World.NextEditBox, World.tooltipText = Name, L.SEARCH_WORLD_DESC;

local WorldButton = me.NPCWorldButton;
WorldButton:SetPoint( "RIGHT", World, 3, 1 );
WorldButton:SetSize( 24, 24 );
WorldButton:SetNormalTexture( [[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Up]] );
WorldButton:SetPushedTexture( [[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Down]] );
WorldButton:SetHighlightTexture( [[Interface\Buttons\UI-Common-MouseHilight]], "ADD" );
WorldButton:SetScript( "OnClick", WorldButton.OnClick );
WorldButton:SetScript( "OnHide", WorldButton.OnHide );
UIDropDownMenu_SetAnchor( WorldButton.Dropdown, 0, 0, "TOPRIGHT", WorldButton, "BOTTOMRIGHT" );

me.NPCControls:SetPoint( "BOTTOMRIGHT", me.NPCRemove );
me.NPCControls:SetPoint( "LEFT", NpcIDLabel );
me.NPCControls:SetPoint( "TOP", me.NPCAdd );


-- Place table
me.TableContainer:SetPoint( "TOP", me.AddFoundCheckbox, "BOTTOM", 0, -28 );
me.TableContainer:SetPoint( "LEFT", SubText, -2, 0 );
me.TableContainer:SetPoint( "RIGHT", -16, 0 );
me.TableContainer:SetPoint( "BOTTOM", me.NPCControls );
me.TableContainer:SetBackdrop( { bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]]; } );

-- Add all tabs
local LastTab;
local TabCount = 0;
local function AddTab ( ID, Update, Activate, Deactivate )
	TabCount = TabCount + 1;
	local Tab = CreateFrame( "Button", "_NPCScanSearchTab"..TabCount, me.TableContainer, "TabButtonTemplate" );
	Tabs[ ID ] = Tab;

	Tab:SetHitRectInsets( 6, 6, 6, 0 );
	Tab:SetScript( "OnClick", me.TabOnClick );
	Tab:SetScript( "OnEnter", me.TabOnEnter );
	Tab:SetScript( "OnLeave", GameTooltip_Hide );
	Tab:SetMotionScriptsWhileDisabled( true ); -- Allow tooltip while active

	if ( type( ID ) == "number" ) then -- AchievementID
		Tab:SetText( ( select( 2, GetAchievementInfo( ID ) ) ) );
		Tab:GetFontString():SetPoint( "RIGHT", -12, 0 );
		local Checkbox = CreateFrame( "CheckButton", nil, Tab, "UICheckButtonTemplate" );
		Tab.AchievementID, Tab.Checkbox = ID, Checkbox;
		Checkbox:SetSize( 20, 20 );
		Checkbox:SetPoint( "BOTTOMLEFT", 8, 0 );
		Checkbox:SetHitRectInsets( 4, 4, 4, 4 );
		Checkbox:SetScript( "OnClick", me.TabCheckOnClick );
		Checkbox:SetScript( "OnEnter", me.TabCheckOnEnter );
		Checkbox:SetScript( "OnLeave", GameTooltip_Hide );
		me.AchievementSetEnabled( ID, false ); -- Initialize the custom "unchecked" texture
		PanelTemplates_TabResize( Tab, Checkbox:GetWidth() - 12 );
	else
		Tab:SetText( L.SEARCH_NPCS );
		PanelTemplates_TabResize( Tab, -8 );
	end

	Tab.Update = Update;
	Tab.Activate, Tab.Deactivate = Activate, Deactivate;

	PanelTemplates_DeselectTab( Tab );
	if ( LastTab ) then
		Tab:SetPoint( "LEFT", LastTab, "RIGHT", -4, 0 );
	else
		Tab:SetPoint( "BOTTOMLEFT", me.TableContainer, "TOPLEFT" );
	end
	LastTab = Tab;
end
AddTab( "NPC", me.NPCUpdate, me.NPCActivate, me.NPCDeactivate );
for AchievementID in pairs( _NPCScan.Achievements ) do
	AddTab( AchievementID, me.AchievementUpdate, me.AchievementActivate, me.AchievementDeactivate );
end


InterfaceOptions_AddCategory( me );