QuestHelper_File["core.lua"] = "1.4.1"
QuestHelper_Loadtime["core.lua"] = GetTime()


QuestHelper.Astrolabe = QH_Astrolabe_Ready and DongleStub("Astrolabe-0.4-QuestHelper")
local walker = QuestHelper:CreateWorldMapWalker()
QuestHelper.minimap_marker = QuestHelper:CreateMipmapDodad()

QH_Route_RegisterNotification(function (route) walker:RouteChanged(route) end)
QH_Route_RegisterNotification(function (route) QH_Tracker_UpdateRoute(route) end)
QH_Route_RegisterNotification(function (route) QuestHelper.minimap_marker:SetObjective(route[2]) end)
