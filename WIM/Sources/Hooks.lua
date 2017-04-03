--[[
This file contains hooks which are required by WIM's core.
Module specific hooks are found within it's own files.
]]


-------------------------------------------------------------------------------------------
-- The following hooks will account for anything that is being inserted into default chat frame and
-- spoofs other callers into thinking that they are actually linking into the chat frame.
--DEFAULT_CHAT_FRAME.editBox

local Hooked_ChatFrameEditBoxes = {};

-- may no longer be needed.... not sure of other addons depend on it...
local function hookChatFrameEditBox(editBox)
    if(editBox and not Hooked_ChatFrameEditBoxes[editBox:GetName()]) then
        hooksecurefunc(editBox, "Insert", function(self,theText)
				if(WIM.EditBoxInFocus) then
					WIM.EditBoxInFocus:Insert(theText);
				end
			end )


        editBox.wimIsVisible = editBox.IsVisible;
        editBox.IsVisible = function(self)
				if(WIM.EditBoxInFocus) then
					return true;
				else
					return self:wimIsVisible();
				end
			end
        editBox.wimIsShown = editBox.IsShown;
        editBox.IsShown = function(self)
				if(WIM.EditBoxInFocus) then
					return true;
				else
					return self:wimIsShown();
				end
			end

        -- can not hook GetText() because it taints the chat bar. Breaks /tar
        hooksecurefunc(editBox, "SetText", function(self,theText)
				local firstChar = "";
				--if a slash command is being set, ignore it. Let WoW take control of it.
				if(string.len(theText) > 0) then firstChar = string.sub(theText, 1, 1); end
				if(WIM.EditBoxInFocus and firstChar ~= "/") then
					WIM.EditBoxInFocus:SetText(theText);
				end
			end );
        editBox.wimHighlightText = editBox.HighlightText;
        editBox.HighlightText = function(self, theStart, theEnd)
				if(WIM.EditBoxInFocus) then
					WIM.EditBoxInFocus:HighlightText(theStart, theEnd);
				else
					self:wimHighlightText(theStart, theEnd);
				end
			end
        Hooked_ChatFrameEditBoxes[editBox:GetName()] = true;
    end
end

hooksecurefunc("ChatEdit_ActivateChat", function(editBox)
        hookChatFrameEditBox(editBox);
    end);

   
function WIM.getVisibleChatFrameEditBox()
    for eb in pairs(Hooked_ChatFrameEditBoxes) do
        if _G[eb]:wimIsVisible() then
            return _G[eb];
        end
    end
end


-------------------------------------------------------------------------------------------

-- linking hooks
local ChatEdit_GetActiveWindow_orig = ChatEdit_GetActiveWindow;
function ChatEdit_GetActiveWindow()
    --[[
    --local tb = debugstack();
    --DEFAULT_CHAT_FRAME:AddMessage(tb);
    if(WIM.EditBoxInFocus) then
        -- if WIM has focus, see where its coming from first...
        -- if from ChatEdit_InsertLink, return EditBoxInFocus, otherwise, return normal.
        if(tb:match('ChatEdit_InsertLink')) then
            return WIM.EditBoxInFocus;
        end
    end
    ]]
    return WIM.EditBoxInFocus or ChatEdit_GetActiveWindow_orig();
end


--ItemRef Definitions
local registeredItemRef = {};
function WIM.RegisterItemRefHandler(cmd, fun)
    registeredItemRef[cmd] = fun;
end
local ItemRefTooltip_SetHyperlink = ItemRefTooltip.SetHyperlink;
ItemRefTooltip.SetHyperlink = function(self, link)
    for cmd, fun in pairs(registeredItemRef) do
        if(string.match(link, "^"..cmd..":")) then
            fun(link);
            return;
        end
    end
    ItemRefTooltip_SetHyperlink(self, link);
end




