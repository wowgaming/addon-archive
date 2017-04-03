QuestHelper_File["routing_route.lua"] = "1.4.1"
QuestHelper_Loadtime["routing_route.lua"] = GetTime()

-- Real simple - [1] through [N] is our route. Yes, the player position at the time the route was generated is [1]. There will be route manipulation functions later. I hear that metatables don't have per-table overhead, but do have some CPU use. I've heard this might only occur if the member doesn't exist inside the actual table. I've also heard that both of these might be wrong. I obviously need to research this since the people in #lua are being useless.

function NewRoute()
  return QuestHelper:CreateTable("route")
end

function PathToString(path)
  local dout
  for _, v in ipairs(path) do
    if dout then
      dout = dout .. string.format(", %d", v)
    else
      dout = string.format("%d", v)
    end
  end
  
  return string.format("[%s]:%f", dout, path.distance)
end
