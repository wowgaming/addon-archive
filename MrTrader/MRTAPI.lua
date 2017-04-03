-------------------------------------------------------------------------------
-- MrTrader 
--
-- Suite of tools for the avid crafter.
--
-- Send suggestions, comments, and bugs to user@zedonline.net
-------------------------------------------------------------------------------
-- Public APIs go here
-----

----
-- Methods to let addons clear out the state of the filter selection (for scanning), and then restore it.
----
function MRTUIUtils_PushFilterSelection()
	local handled = false;

	if( MRTSkillFrame and MRTSkillFrame:IsVisible() ) then
		MRTSkillWindow.didPushFilter = true;
		MRTSkillWindow.savedFilterSelection = MRTSkillWindow.filterSelection;
		MRTSkillWindow.savedFilterCategory = MRTSkillWindow.filterCategory;
		MRTSkillWindow.savedShowOnlyMakeable = MRTUIUtils_GetTradeSkillOnlyShowMakeable();
		MRTSkillWindow.filterSelection = nil;
		MRTSkillWindow.filterCategory = nil;
		MRTUIUtils_SetTradeSkillOnlyShowMakeable(false);
	
		MRTSkillWindow:PopulateFilterTree();	
		MRTSkillWindow:Update();
		handled = true;
	end
	
	return handled;
end

function MRTUIUtils_PopFilterSelection()
	if( MRTSkillWindow and MRTSkillWindow.didPushFilter ) then
		MRTSkillWindow.didPushFilter = nil;
		MRTUIUtils_SetTradeSkillOnlyShowMakeable(MRTSkillWindow.savedOnlyMakeable);
		MRTSkillWindow.filterSelection = MRTSkillWindow.savedFilterSelection;
		MRTSkillWindow.filterCategory = MRTSkillWindow.savedFilterCategory;
	
		MRTSkillWindow:PopulateFilterTree();	
		MRTSkillWindow:Update();
	end
end

-----
-- Methods to let addons hook the skill buttons more easily
-----
local MRTOnShow = {};
local MRTOnHide = {};
local MRTOnWindowShow = {};
local MRTOnWindowUpdate = {};

function MRTUIUtils_RegisterSkillOnShow(handler)
	tinsert(MRTOnShow, handler);
end

function MRTUIUtils_RegisterSkillOnHide(handler)
	tinsert(MRTOnHide, handler);
end

function MRTUIUtils_RegisterWindowOnShow(handler)
	tinsert(MRTOnWindowShow, handler);
end

function MRTUIUtils_RegisterWindowOnUpdate(handler)
	tinsert(MRTOnWindowUpdate, handler);
end

function MRTUIUtils_SkillOnShow(skillButtonFrame)
	MRTUIUtils_CallFunctionList(MRTOnShow, skillButtonFrame);
end

function MRTUIUtils_SkillOnHide(skillButtonFrame)
	MRTUIUtils_CallFunctionList(MRTOnHide, skillButtonFrame);	
end

function MRTUIUtils_WindowOnShow(skillFrame)
	MRTUIUtils_CallFunctionList(MRTOnWindowShow, skillFrame);
end

function MRTUIUtils_CallFunctionList(list, self)
	local count = getn(list);
	for i=1,count do
		list[i](self);
	end	
end