local L =  LibStub:GetLibrary("AceLocale-3.0"):NewLocale("Talented", "enUS", true)
if not L then return end

L["Talented - Talent Editor"] = true

L["Layout options"] = true
--~ L["Options that change the visual layout of Talented."] = true
L["Icon offset"] = true
L["Distance between icons."] = true
L["Frame scale"] = true
L["Overall scale of the Talented frame."] = true

L["Options"] = true
L["General Options for Talented."] = true
L["Always edit"] = true
L["Always allow templates and the current build to be modified, instead of having to Unlock them first."] = true
L["Confirm Learning"] = true
L["Ask for user confirmation before learning any talent."] = true
--~ L["Don't Confirm when applying"] = true
--~ L["Don't ask for user confirmation when applying full template."] = true
L["Always try to learn talent"] = true
L["Always call the underlying API when a user input is made, even when no talent should be learned from it."] = true
L["Talent cap"] = true
L["Restrict templates to a maximum of %d points."] = true
L["Level restriction"] = true
L["Show the required level for the template, instead of the number of points."] = true
--~ L["Load outdated data"] = true
--~ L["Load Talented_Data, even if outdated."] = true
L["Hook Inspect UI"] = true
L["Hook the Talent Inspection UI."] = true
L["Output URL in Chat"] = true
L["Directly outputs the URL in Chat instead of using a Dialog."] = true

L["Inspected Characters"] = true
--~ L["Talent trees of inspected characters."] = true
L["Edit template"] = true
L["Edit talents"] = true
L["Toggle edition of the template."] = true
L["Toggle editing of talents."] = true

L["Templates"] = true
L["Actions"] = true
L["You can edit the name of the template here. You must press the Enter key to save your changes."] = true

L["Remove all talent points from this tree."] = true
L["%s (%d)"] = true
L["Level %d"] = true
L["%d/%d"] = true
--~ L["Right-click to unlearn"] = true
L["Effective tooltip information not available"] = true
L["You have %d talent |4point:points; left"] = true
L["Are you sure that you want to learn \"%s (%d/%d)\" ?"] = true

--~ L["Open the Talented options panel."] = true

--~ L["View Current Spec"] = true
L["View the Current spec in the Talented frame."] = true
--~ L["View Alternate Spec"] = true
L["Switch to this Spec"] = true
L["View Pet Spec"] = true

L["New Template"] = true
L["Empty"] = true

L["Apply template"] = true
L["Copy template"] = true
L["Delete template"] = true
L["Set as target"] = true
L["Clear target"] = true

L["Sorry, I can't apply this template because you don't have enough talent points available (need %d)!"] = true
L["Sorry, I can't apply this template because it doesn't match your pet's class!"] = true
L["Sorry, I can't apply this template because it doesn't match your class!"] = true
L["Nothing to do"] = true
--~ L["Talented cannot perform the required action because it does not have the required talent data available for class %s. You should inspect someone of this class."] = true
--~ L["You must install the Talented_Data helper addon for this action to work."] = true
--~ L["You can download it from http://files.wowace.com/ ."] = true

L["Inspection of %s"] = true
L["Select %s"] = true
L["Copy of %s"] = true
L["Target: %s"] = true
L["Imported"] = true

L["Please wait while I set your talents..."] = true
L["The given template is not a valid one!"] = true
L["Error while applying talents! Not enough talent points!"] = true
L["Error while applying talents! some of the request talents were not set!"] = true
L["Error! Talented window has been closed during template application. Please reapply later."] = true
L["Talent application has been cancelled. %d talent points remaining."] = true
L["Template applied successfully, %d talent points remaining."] = true
--~ L["Talented_Data is outdated. It was created for %q, but current build is %q. Please update."] = true
--~ L["Loading outdated data. |cffff1010WARNING:|r Recent changes in talent trees might not be included in this data."] = true
L["\"%s\" does not appear to be a valid URL!"] = true

L["Import template ..."] = true
L["Enter the complete URL of a template from Blizzard talent calculator or wowhead."] = true

L["Export template"] = true
L["Blizzard Talent Calculator"] = true
L["Wowhead Talent Calculator"] = true
L["Wowdb Talent Calculator"] = true
L["MMO Champion Talent Calculator"] = true
--~ L["http://www.worldofwarcraft.com/info/classes/%s/talents.html?tal=%s"] = true
L["http://www.wowarmory.com/talent-calc.xml?%s=%s&tal=%s"] = true
L["http://www.wowhead.com/talent#%s"] = true
L["http://www.wowhead.com/petcalc#%s"] = true
L["Send to ..."] = true
L["Enter the name of the character you want to send the template to."] = true
L["Do you want to add the template \"%s\" that %s sent you ?"] = true

--~ L["Pet"] = true
L["Options ..."] = true

L["URL:"] = true
L["Talented has detected an incompatible change in the talent information that requires an update to Talented. Talented will now Disable itself and reload the user interface so that you can use the default interface."] = true
L["WARNING: Talented has detected that its talent data is outdated. Talented will work fine for your class for this session but may have issue with other classes. You should update Talented if you can."] = true
L["View glyphs of alternate Spec"] = true
L[" (alt)"] = true
L["The following templates are no longer valid and have been removed:"] = true
L["The template '%s' is no longer valid and has been removed."] = true
L["The template '%s' had inconsistencies and has been fixed. Please check it before applying."] = true

L["Lock frame"] = true
L["Can not apply, unknown template \"%s\""] = true

L["Glyph frame policy on spec swap"] = true
L["Select the way the glyph frame handle spec swaps."] = true
L["Keep the shown spec"] = true
L["Swap the shown spec"] = true
L["Always show the active spec after a change"] = true

L["General options"] = true
L["Glyph frame options"] = true
L["Display options"] = true
L["Add bottom offset"] = true
L["Add some space below the talents to show the bottom information."] = true

L["Right-click to activate this spec"] = true

--~ L["Mode of operation."] = true

--~ L["Toggle editing of the template."] = true
--~ L["Apply the current template to your character."] = true
--~ L["Are you sure that you want to apply the current template's talents?"] = true
--~ L["Delete the current template."] = true
--~ L["Are you sure that you want to delete this template?"] = true
--~ L["Import a template from Blizzard's talent calculator."] = true
--~ L["<full url of the template>"] = true
--~ L["Export this template to your current chat channel."] = true
--~ L["Write template link"] = true
--~ L["Write a link to the current template in chat."] = true
--~ L["New empty template"] = true
--~ L["Create a new template from scratch."] = true
--~ L["Copy current talent spec"] = true
--~ L["Create a new template from your current spec."] = true
--~ L["Copy from %s"] = true
--~ L["Create a new template from %s."] = true
--~ L["Talented - Template \"%s\" - %s :"] = true
--~ L["%s :"] = true
--~ L["_ %s"] = true
--~ L["_ %s (%d/%d)"] = true
--~ L["Options of Talented"] = true
--~ L["Options for Talented."] = true
--~ L["CHAT_COMMANDS"] = { "/talented" }
--~ L["Back to normal mode"] = true
--~ L["Return to the normal talents mode."] = true
--~ L["Switch to template mode"] = true
--~ L["Export the template."] = true
--~ L["Export to chat"] = true
--~ L["Export as URL"] = true
--~ L["Send the template to another Talented user."] = true
--~ L["<name>"] = true
--~ L["Export the template as a URL."] = true
--~ L["Export the template as a URL to the official talent calculator"] = true
--~ L["Export the template as a URL to the wowhead talent calculator."] = true
--~ L["Export the template as a URL to the wowdb talent calculator."] = true
--~ L["Default to edit"] = true
--~ L["Always show templates and talent in edit mode by default."] = true
--~ L["Set this template as the target template, so that you may use it as a guide in normal mode."] = true
--~ L["Talented Links options."] = true
--~ L["Color Template"] = true
--~ L["Toggle the Template color on and off."] = true
--~ L["Set Color"] = true
--~ L["Change the color of the Template."] = true
--~ L["Query Talent Spec"] = true
--~ L["From Rock"] = true
--~ L["Received talent information from LibRock."] = true
--~ L["Query"] = "Query user"
--~ L["Request a player's talent spec."] = true
--~ L["Query group"] = true
--~ L["Request talent information for your whole group (party or raid)."] = true
--~ L["Clone selected"] = true
--~ L["Make a copy of the current template."] = true
