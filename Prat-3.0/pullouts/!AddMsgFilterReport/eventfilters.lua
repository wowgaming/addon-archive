addMessageFilterEventsRegistered = {}
addMessageFilterAddonsRegistered = {}

if not PrintEventFilterReport then 
    local org_AMEF = _G.ChatFrame_AddMessageEventFilter
    _G.ChatFrame_AddMessageEventFilter = function(event, ...) 
        addMessageFilterEventsRegistered[event] = true 

        local addon = _G.debugstack():match("\n.-ns\\(.-)\\")

        if addon then
            addMessageFilterAddonsRegistered[addon] = true
        end
        return org_AMEF(event, ...) 
    end


    function PrintEventFilterReport()
        print("|cff80ffffAddons using event filters:|r")
        for addon in pairs(addMessageFilterAddonsRegistered) do
            print("    "..addon)
        end

        print("|cff80ffffEvents with filters:|r")
        for event in pairs(addMessageFilterEventsRegistered) do
            print("    "..event)
        end            
    end
end