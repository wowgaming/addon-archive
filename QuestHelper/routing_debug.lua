QuestHelper_File["routing_debug.lua"] = "1.4.1"
QuestHelper_Loadtime["routing_debug.lua"] = GetTime()

function RTO(text)
  DEFAULT_CHAT_FRAME:AddMessage(string.format("|cffFFC8C8QHV1: |r%s", text),
                                0.75,
                                0.87,
                                1.0)
end
