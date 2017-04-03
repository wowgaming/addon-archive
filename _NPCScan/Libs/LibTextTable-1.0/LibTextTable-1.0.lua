--[[****************************************************************************
  * LibTextTable-1.0 by Saiket                                                 *
  * LibTextTable-1.0.lua - Creates table controls for tabular text data.       *
  ****************************************************************************]]


local MAJOR, MINOR = "LibTextTable-1.0", 5;

local lib = LibStub:NewLibrary( MAJOR, MINOR );
if ( not lib ) then
	return;
end

lib.RowMeta = lib.RowMeta or { __index = {}; };
local RowMethods = lib.RowMeta.__index;
lib.TableMeta = lib.TableMeta or { __index = {}; };
local TableMethods = lib.TableMeta.__index;

local RowHeight = 14;
local ColumnPadding = 6;




--[[****************************************************************************
  * Function: RowObject:GetNumRegions                                          *
  ****************************************************************************]]
do
	local RowMethodsOriginal = getmetatable( BasicScriptErrorsButton ).__index; -- Generic button metatable
	function RowMethods:GetNumRegions ()
		return RowMethodsOriginal.GetNumRegions( self ) - 1; -- Skip highlight region
	end
--[[****************************************************************************
  * Function: RowObject:GetRegions                                             *
  ****************************************************************************]]
	function RowMethods:GetRegions ()
		return select( 2, RowMethodsOriginal.GetRegions( self ) ); -- Skip highlight region
	end
end
--[[****************************************************************************
  * Function: RowObject:GetData                                                *
  * Description: Returns the row's key and all original element data.          *
  ****************************************************************************]]
function RowMethods:GetData ()
	return self.Key, unpack( self, 1, self:GetParent().Table.NumColumns );
end




--[[****************************************************************************
  * Function: TableObject:Clear                                                *
  * Description: Empties the table of all rows.                                *
  ****************************************************************************]]
do
	local function ClearElements ( Count, ... )
		for Index = 1, Count do
			local Element = select( Index, ... );
			Element:Hide();
			Element:SetText();
		end
	end
	function TableMethods:Clear ()
		local Rows = self.Rows;
		if ( #Rows > 0 ) then
			if ( self.View.YScroll ) then -- Force correct view resize
				self.View.YScroll:SetValue( 0 );
			end
			self:SetSelection();
			wipe( self.Keys );
			for Index = #Rows, 1, -1 do -- Remove in reverse so rows don't move mid-loop
				local Row = Rows[ Index ];

				Rows[ Index ] = nil;
				self.UnusedRows[ Row ] = true;
				Row:Hide();
				Row.Key = nil;
				ClearElements( self.NumColumns, Row:GetRegions() );
				for Column = 1, self.NumColumns do -- Remove values
					Row[ Column ] = nil;
				end
			end
			self:Resize();
			return true;
		end
	end
end
--[[****************************************************************************
  * Function: TableObject:SetHeader                                            *
  * Description: Sets the headers for the data table to the list of header     *
  *   labels provided.  Labels with value nil will have no label text.         *
  ****************************************************************************]]
do
	local function ColumnOnClick ( Column ) -- Sorts by this column
		Column:GetParent().Table:SetSortColumn( Column );
		PlaySound( "igMainMenuOptionCheckBoxOn" );
	end
	local function ColumnCreate ( Header ) -- Creates a new column header for the table
		local Index = #Header + 1;
		local Column = CreateFrame( "Button", nil, Header );

		Column:SetScript( "OnClick", ColumnOnClick );
		Column:SetID( Index );
		Column:SetFontString( Column:CreateFontString( nil, "ARTWORK", Header.Table.HeaderFont ) );
		Column:SetPoint( "TOP" );
		Column:SetPoint( "BOTTOM" );
		if ( Index == 1 ) then
			Column:SetPoint( "LEFT" );
		else
			Column:SetPoint( "LEFT", Header[ Index - 1 ], "RIGHT" );
		end

		-- Artwork
		local Arrow = Column:CreateTexture( nil, "OVERLAY" );
		Column.Arrow = Arrow;
		Arrow:Hide();
		Arrow:SetSize( RowHeight * 0.5, RowHeight * 0.8 );
		Arrow:SetTexture( [[Interface\Buttons\UI-SortArrow]] );
		local Left = Column:CreateTexture( nil, "BACKGROUND" );
		Left:SetPoint( "TOPLEFT" );
		Left:SetPoint( "BOTTOM" );
		Left:SetWidth( 5 );
		Left:SetTexture( [[Interface\FriendsFrame\WhoFrame-ColumnTabs]] );
		Left:SetTexCoord( 0, 0.078125, 0, 0.75 );
		local Right = Column:CreateTexture( nil, "BACKGROUND" );
		Right:SetPoint( "TOPRIGHT" );
		Right:SetPoint( "BOTTOM" );
		Right:SetWidth( 4 );
		Right:SetTexture( [[Interface\FriendsFrame\WhoFrame-ColumnTabs]] );
		Right:SetTexCoord( 0.90625, 0.96875, 0, 0.75 );
		local Middle = Column:CreateTexture( nil, "BACKGROUND" );
		Middle:SetPoint( "TOPLEFT", Left, "TOPRIGHT" );
		Middle:SetPoint( "BOTTOMRIGHT", Right, "BOTTOMLEFT" );
		Middle:SetTexture( [[Interface\FriendsFrame\WhoFrame-ColumnTabs]] );
		Middle:SetTexCoord( 0.078125, 0.90625, 0, 0.75 );

		Column:SetHighlightTexture( [[Interface\Buttons\UI-Panel-Button-Highlight]], "ADD" );
		Column:GetHighlightTexture():SetTexCoord( 0, 0.625, 0, 0.6875 );
		local Backdrop = Column:CreateTexture( nil, "OVERLAY" );
		Backdrop:Hide();
		Backdrop:SetPoint( "TOPLEFT", Column, "BOTTOMLEFT" );
		Backdrop:SetPoint( "RIGHT" );
		Backdrop:SetPoint( "BOTTOM", Header.Table.Body ); -- Expand to bottom of view
		Backdrop:SetTexture( 0.15, 0.15, 0.15, 0.25 );
		Backdrop:SetBlendMode( "ADD" );
		Column.Backdrop = Backdrop;

		Header[ Index ] = Column;
		return Column;
	end
	function TableMethods:SetHeader ( ... )
		local Header = self.Header;
		local NumColumns = select( "#", ... );
		if ( self.View.XScroll ) then -- Force correct view resize
			self.View.XScroll:SetValue( 0 );
		end

		-- Create necessary column buttons
		if ( #Header < NumColumns ) then
			for Index = #Header + 1, NumColumns do
				ColumnCreate( Header );
			end
		end

		-- Fill out buttons
		for Index = 1, NumColumns do
			local Column = Header[ Index ];
			local Value = select( Index, ... );
			Column:SetText( Value ~= nil and tostring( Value ) or nil );
			Column:Show();
		end
		for Index = NumColumns + 1, #Header do -- Hide unused
			local Column = Header[ Index ];
			Column:Hide();
			Column:SetText();
			Column.Sort = nil;
		end

		if ( not self:Clear() ) then
			self:Resize(); -- Fit to only headers
		end
		self.NumColumns = NumColumns;
		self:SetSortHandlers(); -- None
	end
end
--[[****************************************************************************
  * Function: TableObject:SetSortHandlers                                      *
  * Description: Allows or disallows sorting of each column with a custom sort *
  *   function.  Sort functions are passed to table.sort, and a value of true  *
  *   uses the default table.sort comparison.                                  *
  ****************************************************************************]]
function TableMethods:SetSortHandlers ( ... )
	local Header = self.Header;
	for Index = 1, self.NumColumns do
		local Column = Header[ Index ];
		local Handler = select( Index, ... );

		Column.Sort = Handler;
		if ( Handler ) then
			Column:Enable();
		else
			Column:Disable();
		end
	end
	self:SetSortColumn(); -- None
end
--[[****************************************************************************
  * Function: TableObject:SetSortColumn                                        *
  * Description: Selects or clears the column to sort by.  The Inverted option *
  *   flips the sort order.  If it's not set and the column is already sorted, *
  *   the sort order flips automatically.                                      *
  ****************************************************************************]]
function TableMethods:SetSortColumn ( Column, Inverted )
	local Header = self.Header;

	if ( tonumber( Column ) ) then
		Column = Header[ tonumber( Column ) ];
	end
	if ( Column ) then
		assert( type( Column ) == "table", "Invalid colum." );
		assert( Column.Sort, "Column must have a sort handler assigned." );
	end

	if ( Header.SortColumn ~= Column ) then
		if ( Header.SortColumn ) then
			Header.SortColumn.Arrow:Hide();
			Header.SortColumn.Backdrop:Hide();
		end
		Header.SortColumn, Header.SortInverted = Column, Inverted or false;
		if ( Column ) then
			Column.Arrow:Show();
			Column.Backdrop:Show();
			self:Sort();
		end
	elseif ( Column ) then -- Selected same sort column
		if ( Inverted == nil ) then -- Unspecified; Flip inverted status
			Inverted = not Header.SortInverted;
		end
		if ( Header.SortInverted ~= Inverted ) then
			Header.SortInverted = Inverted;
			self:Sort();
		end
	end

	if ( Column ) then
		if ( Header.SortInverted ) then
			Column.Arrow:SetPoint( "LEFT", 0, 2 );
			Column.Arrow:SetTexCoord( 0.0625, 0.5, 1, 0 );
		else
			Column.Arrow:SetPoint( "LEFT", 0, -2 );
			Column.Arrow:SetTexCoord( 0.0625, 0.5, 0, 1 );
		end
	end
end
--[[****************************************************************************
  * Function: TableObject:Sort                                                 *
  * Description: Schedules rows to be resorted on the next OnUpdate.           *
  ****************************************************************************]]
do
	local type = type;
	local tostring = tostring;
	local function SortSimple ( Val1, Val2 )
		local Type1, Type2 = type( Val1 ), type( Val2 );
		if ( Type1 ~= "string" and Type1 ~= "number" ) then
			Val1 = Val1 == nil and "" or tostring( Val1 );
		end
		if ( Type2 ~= "string" and Type2 ~= "number" ) then
			Val2 = Val2 == nil and "" or tostring( Val2 );
		end
		if ( Val1 ~= Val2 ) then
			return Val1 < Val2;
		end
	end
	local Handler, Column, Inverted;
	local function Compare ( Row1, Row2 )
		local Result;
		if ( Inverted ) then -- Flip the handler's args
			Result = Handler( Row2[ Column ], Row1[ Column ], Row2, Row1 );
		else
			Result = Handler( Row1[ Column ], Row2[ Column ], Row1, Row2 );
		end
		if ( Result ~= nil ) then -- Not equal
			return Result;
		else -- Equal
			return Row1:GetID() < Row2:GetID(); -- Fall back on previous row order
		end
	end
	local function OnUpdate ( Header )
		Header:SetScript( "OnUpdate", nil );
		local Rows = Header.Table.Rows;
		if ( Header.SortColumn and #Rows > 0 ) then
			Column = Header.SortColumn:GetID();
			Handler, Inverted = Header.SortColumn.Sort, Header.SortInverted;
			if ( Handler == true ) then
				Handler = SortSimple; -- Less-than operator
			end
			sort( Rows, Compare );

			for Index, Row in ipairs( Rows ) do
				Row:SetID( Index );
				Row:SetPoint( "TOPLEFT", 0, ( 1 - Index ) * RowHeight );
			end
		end
	end
	function TableMethods:Sort ()
		self.Header:SetScript( "OnUpdate", OnUpdate );
	end
end
--[[****************************************************************************
  * Function: TableObject:CreateRow                                            *
  * Description: Creates a new row when none is available in the row pool.     *
  ****************************************************************************]]
do
	local function RowOnClick ( Row ) -- Selects a row element when the row is clicked.
		Row:GetParent().Table:SetSelection( Row );
	end
	function TableMethods:CreateRow ()
		local Row = CreateFrame( "Button", nil, self.Rows );
		Row:SetScript( "OnClick", RowOnClick );
		Row:RegisterForClicks( "AnyUp" );
		Row:SetHeight( RowHeight );
		Row:SetPoint( "RIGHT", self.Body ); -- Expand to right side of view
		Row:SetHighlightTexture( [[Interface\FriendsFrame\UI-FriendsFrame-HighlightBar]], "ADD" );
		-- Apply row methods
		if ( not getmetatable( RowMethods ) ) then
			setmetatable( RowMethods, getmetatable( Row ) );
		end
		setmetatable( Row, lib.RowMeta );
		return Row;
	end
end
--[[****************************************************************************
  * Function: TableObject:AddRow                                               *
  * Description: Adds a row of strings to the table with the current header.   *
  ****************************************************************************]]
do
	local select = select;
	local function RowAddElements ( Table, Row ) -- Adds and anchors missing element strings
		local Columns = Table.Header;
		for Index = Row:GetNumRegions() + 1, Table.NumColumns do
			local Element = Row:CreateFontString( nil, "ARTWORK", Table.ElementFont );
			Element:SetPoint( "TOP" );
			Element:SetPoint( "BOTTOM" );
			Element:SetPoint( "LEFT", Columns[ Index ], ColumnPadding, 0 );
			Element:SetPoint( "RIGHT", Columns[ Index ], -ColumnPadding, 0 );
		end
	end
	local function UpdateElements ( Table, Row, ... ) -- Shows, hides, and sets the values of elements
		for Index = 1, Table.NumColumns do
			local Element = select( Index, ... );
			local Value = Row[ Index ];
			Element:SetText( Value ~= nil and tostring( Value ) or nil );
			Element:Show();
			Element:SetJustifyH( type( Value ) == "number" and "RIGHT" or "LEFT" );
		end
		for Index = Table.NumColumns + 1, select( "#", ... ) do
			select( Index, ... ):Hide();
		end
	end
	function TableMethods:AddRow ( Key, ... )
		assert( Key == nil or self.Keys[ Key ] == nil, "Index key must be unique." );

		local Rows = self.Rows;
		local Index = #Rows + 1;

		local Row = next( self.UnusedRows );
		if ( Row ) then
			self.UnusedRows[ Row ] = nil;
			Row:Show();
		else
			Row = self:CreateRow();
		end
		Rows[ Index ] = Row;

		if ( Key ~= nil ) then
			self.Keys[ Key ] = Row;
			Row.Key = Key;
		end
		for Index = 1, self.NumColumns do
			Row[ Index ] = select( Index, ... );
		end

		Row:SetID( Index );
		Row:SetPoint( "TOPLEFT", 0, ( 1 - Index ) * RowHeight );
		RowAddElements( self, Row );
		UpdateElements( self, Row, Row:GetRegions() );

		self:Resize();
		self:Sort();
		return Row;
	end
end
--[[****************************************************************************
  * Function: TableObject:Resize                                               *
  * Description: Requests that the table be resized on the next update.        *
  ****************************************************************************]]
do
	local ColumnWidths = {};
	local select = select;
	local function GetElementWidths ( NumColumns, ... )
		for Index = 1, NumColumns do
			local Width = select( Index, ... ):GetStringWidth();
			if ( Width > ColumnWidths[ Index ] ) then
				ColumnWidths[ Index ] = Width;
			end
		end
	end
	local function Resize ( Rows ) -- Resizes all table headers and elements
		local Table = Rows.Table;
		local Header = Table.Header;
		local NumColumns = Table.NumColumns;

		for Index = 1, NumColumns do
			ColumnWidths[ Index ] = Header[ Index ]:GetTextWidth();
		end
		for _, Row in ipairs( Rows ) do
			GetElementWidths( NumColumns, Row:GetRegions() );
		end

		local TotalWidth = 0;
		for Index = 1, NumColumns do
			local Width = ColumnWidths[ Index ] + ColumnPadding * 2;
			Header[ Index ]:SetWidth( Width );
			TotalWidth = TotalWidth + Width;
		end
		local Height = #Rows * RowHeight;
		Rows:SetSize( TotalWidth > 1e-3 and TotalWidth or 1e-3, Height > 1e-3 and Height or 1e-3 );
	end
	local function OnUpdate ( Rows ) -- Handler for tables that limits resizes to once per frame
		Rows:SetScript( "OnUpdate", nil );
		Resize( Rows );
	end
	function TableMethods:Resize ()
		self.Rows:SetScript( "OnUpdate", OnUpdate );
	end
end
--[[****************************************************************************
  * Function: TableObject:GetSelectionData                                     *
  * Description: Returns the data contained in the selected row.               *
  ****************************************************************************]]
function TableMethods:GetSelectionData ()
	if ( self.Selection ) then
		return self.Selection:GetData();
	end
end
--[[****************************************************************************
  * Function: TableObject:SetSelection                                         *
  * Description: Sets the selection to a given row.                            *
  ****************************************************************************]]
function TableMethods:SetSelection ( Row )
	assert( Row == nil or type( Row ) == "table", "Row must be an existing table row." );
	if ( Row ~= self.Selection ) then
		if ( self.Selection ) then -- Remove old selection
			self.Selection:UnlockHighlight();
		end

		self.Selection = Row;
		if ( Row ) then
			Row:LockHighlight();
		end
		if ( self.OnSelect ) then
			self:OnSelect( self:GetSelectionData() );
		end
		return true;
	end
end
--[[****************************************************************************
  * Function: TableObject:SetSelectionByKey                                    *
  * Description: Sets the selection to a row indexed by the given key.         *
  ****************************************************************************]]
function TableMethods:SetSelectionByKey ( Key )
	return self:SetSelection( self.Keys[ Key ] );
end




--[[****************************************************************************
  * Function: lib.New                                                          *
  * Description: Creates a new table.                                          *
  ****************************************************************************]]
do
	local ViewOnSizeChanged, HeaderOnSizeChanged; -- Resizes when viewing area/table data width changes
	do
		local Padding = 2; -- Keeps the Body frame from causing scrolling
		-- Adjusts row widths and table height to fill the scrollframe without changing the scrollable area
		local function Resize ( Table, RowsX, RowsY, ViewX, ViewY )
			RowsY = RowsY + RowHeight; -- Allow room for header
			local Width, Height = ( RowsX > ViewX and RowsX or ViewX ) - Padding, ( RowsY > ViewY and RowsY or ViewY ) - Padding;
			Table.Body:SetSize( Width > 1e-3 and Width or 1e-3, Height > 1e-3 and Height or 1e-3 );
		end
		function ViewOnSizeChanged ( View, ViewX, ViewY ) -- Viewing area changes
			local RowsX, RowsY = View.Table.Rows:GetSize();
			Resize( View.Table, RowsX, RowsY, ViewX, ViewY );
		end
		function RowsOnSizeChanged ( Rows, RowsX, RowsY ) -- Table data size changes
			Resize( Rows.Table, RowsX, RowsY, Rows.Table.View:GetSize() );
		end
	end

	-- Handlers for scrollwheel and scrollbar increment/decrement
	local function ScrollHorizontal ( View, Delta )
		local XScroll = View.XScroll;
		XScroll:SetValue( XScroll:GetValue() + Delta * XScroll:GetWidth() / 2 )
	end
	local function ScrollVertical ( View, Delta )
		local YScroll = View.YScroll;
		YScroll:SetValue( YScroll:GetValue() + Delta * YScroll:GetHeight() / 2 )
	end

	local function OnMouseWheel ( Table, Delta ) -- Scrolls with the mousewheel vertically, or horizontally if shift is held
		local View = Table.View;
		if ( View:GetHorizontalScrollRange() > 0 and ( View:GetVerticalScrollRange() == 0 or IsShiftKeyDown() ) ) then
			ScrollHorizontal( View, -Delta );
		else
			ScrollVertical( View, -Delta );
		end
	end

	local function OnValueChangedHorizontal ( ScrollBar, HorizontalScroll ) -- Horizontal scrollbar updates
		local View = ScrollBar:GetParent();
		View:SetHorizontalScroll( HorizontalScroll );

		local Min, Max = ScrollBar:GetMinMaxValues();
		View.Left[ HorizontalScroll == Min and "Disable" or "Enable" ]( View.Left );
		View.Right[ HorizontalScroll == Max and "Disable" or "Enable" ]( View.Right );
	end
	local function OnValueChangedVertical ( ScrollBar, VerticalScroll ) -- Vertical scrollbar updates
		local View = ScrollBar:GetParent();
		View:SetVerticalScroll( VerticalScroll );

		local Min, Max = ScrollBar:GetMinMaxValues();
		View.Up[ VerticalScroll == Min and "Disable" or "Enable" ]( View.Up );
		View.Down[ VerticalScroll == Max and "Disable" or "Enable" ]( View.Down );
	end

	local OnScrollRangeChanged; -- Adds and adjusts scrollbars when necessary
	do
		local function CreateScrollBar ( View, ScrollScript ) -- Creates a scrollbar, decrement button, and increment button
			local Scroll = CreateFrame( "Slider", nil, View );
			Scroll:Hide();
			Scroll:SetThumbTexture( [[Interface\Buttons\UI-ScrollBar-Knob]] );
			local Dec = CreateFrame( "Button", nil, Scroll, "UIPanelScrollUpButtonTemplate" );
			local Inc = CreateFrame( "Button", nil, Scroll, "UIPanelScrollDownButtonTemplate" );
			Dec:SetScript( "OnClick", function ()
				PlaySound( "UChatScrollButton" );
				ScrollScript( View, -1 );
			end );
			Inc:SetScript( "OnClick", function ()
				PlaySound( "UChatScrollButton" );
				ScrollScript( View, 1 );
			end );
			local Thumb = Scroll:GetThumbTexture();
			Thumb:SetSize( Dec:GetSize() );
			Thumb:SetTexCoord( 0.25, 0.75, 0.25, 0.75 ); -- Remove transparent border
			local Background = Scroll:CreateTexture( nil, "BACKGROUND" );
			Background:SetTexture( 0, 0, 0, 0.5 );
			Background:SetAllPoints();
			return Scroll, Dec, Inc;
		end
		local function RotateTextures ( ... ) -- Rotates all regions 90 degrees CCW
			for Index = 1, select( "#", ... ) do
				select( Index, ... ):SetTexCoord( 0.75, 0.25, 0.25, 0.25, 0.75, 0.75, 0.25, 0.75 );
			end
		end
		function OnScrollRangeChanged ( View, XRange, YRange )
			local XScroll, YScroll = View.XScroll, View.YScroll;
			View.Table:EnableMouseWheel( XRange > 0 or YRange > 0 ); -- Enable only if scrollable

			-- Horizontal scrolling
			if ( XRange > 0 ) then
				if ( not XScroll ) then -- Create scrollbar
					XScroll, View.Left, View.Right = CreateScrollBar( View, ScrollHorizontal );
					View.XScroll = XScroll;
					View.Left:SetPoint( "BOTTOMLEFT", View.Table );
					XScroll:SetPoint( "BOTTOMLEFT", View.Left, "BOTTOMRIGHT" );
					XScroll:SetPoint( "TOPRIGHT", View.Right, "TOPLEFT" );
					XScroll:SetOrientation( "HORIZONTAL" );
					XScroll:SetScript( "OnValueChanged", OnValueChangedHorizontal );
					RotateTextures( View.Left:GetRegions() );
					RotateTextures( View.Right:GetRegions() );
				end
				if ( not XScroll:IsShown() ) then -- Show and position scrollbar
					XScroll:Show();
					View:SetPoint( "BOTTOM", XScroll, "TOP" );
				end
				-- Setup scrollbar's range
				View.Right:SetPoint( "BOTTOMRIGHT", View.Table, YRange > 0 and -View.Right:GetWidth() or 0, 0 );
				XScroll:SetMinMaxValues( 0, XRange );
				XScroll:SetValue( min( XScroll:GetValue(), XRange ) );
			elseif ( XScroll and XScroll:IsShown() ) then -- Hide scrollbar
				XScroll:SetValue( 0 ); -- Return to origin
				XScroll:Hide();
				View:SetPoint( "BOTTOM", View.Table );
			end

			-- Vertical scrolling
			if ( YRange > 0 ) then
				if ( not YScroll ) then -- Create scrollbar
					YScroll, View.Up, View.Down = CreateScrollBar( View, ScrollVertical );
					View.YScroll = YScroll;
					View.Up:SetPoint( "TOPRIGHT", View.Table );
					YScroll:SetPoint( "TOPRIGHT", View.Up, "BOTTOMRIGHT" );
					YScroll:SetPoint( "BOTTOMLEFT", View.Down, "TOPLEFT" );
					YScroll:SetScript( "OnValueChanged", OnValueChangedVertical );
				end
				if ( not YScroll:IsShown() ) then -- Show and position scrollbar
					YScroll:Show();
					View:SetPoint( "RIGHT", YScroll, "LEFT" );
				end
				-- Setup scrollbar's range
				View.Down:SetPoint( "BOTTOMRIGHT", View.Table, 0, XRange > 0 and View.Down:GetHeight() or 0 );
				YScroll:SetMinMaxValues( 0, YRange );
				YScroll:SetValue( min( YScroll:GetValue(), YRange ) );
			elseif ( YScroll and YScroll:IsShown() ) then -- Hide scrollbar
				YScroll:SetValue( 0 ); -- Return to origin
				YScroll:Hide();
				View:SetPoint( "RIGHT", View.Table );
			end
		end
	end

	function lib.New ( Name, Parent, HeaderFont, ElementFont )
		local Table = CreateFrame( "Frame", Name, Parent );
		if ( not getmetatable( TableMethods ) ) then
			setmetatable( TableMethods, getmetatable( Table ) );
		end
		setmetatable( Table, lib.TableMeta );

		local View = CreateFrame( "ScrollFrame", nil, Table );
		Table.View = View;
		View.Table = Table;
		View:SetPoint( "TOPLEFT" );
		View:SetPoint( "BOTTOM" ); -- Bottom and right anchors moved independently by scrollbars
		View:SetPoint( "RIGHT" );
		View:SetScript( "OnScrollRangeChanged", OnScrollRangeChanged );
		View:SetScript( "OnSizeChanged", ViewOnSizeChanged );

		-- Body frame expands to fill the scrollframe
		local Body = CreateFrame( "Frame" );
		Table.Body = Body;
		View:SetScrollChild( Body );

		-- Rows frame expands to the size of table data
		local Rows = CreateFrame( "Frame", nil, Body );
		Table.Rows = Rows;
		Rows.Table = Table;
		Rows:SetPoint( "TOPLEFT", 0, -RowHeight ); -- Leave room for header
		Rows:SetScript( "OnSizeChanged", RowsOnSizeChanged );

		local Header = CreateFrame( "Frame", nil, Body );
		Table.Header = Header;
		Header.Table = Table;
		Header:SetPoint( "TOP", Table, 0, 1 ); -- Make sure rows don't show in the crack above the header
		Header:SetPoint( "LEFT", Rows );
		Header:SetPoint( "RIGHT", Rows );
		Header:SetHeight( RowHeight );
		local Background = Header:CreateTexture( nil, "OVERLAY" );
		Background:SetTexture( 0, 0, 0 );
		Background:SetPoint( "TOPLEFT" );
		Background:SetPoint( "BOTTOM" );
		Background:SetPoint( "RIGHT", Body ); -- Expand with view

		Table.Keys = {};
		Table.UnusedRows = {};
		Table.HeaderFont = HeaderFont or "GameFontHighlightSmall";
		Table.ElementFont = ElementFont or "GameFontNormalSmall";

		Table:SetScript( "OnMouseWheel", OnMouseWheel );
		Table:SetHeader(); -- Clear all and resize
		return Table;
	end
end