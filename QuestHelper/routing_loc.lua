QuestHelper_File["routing_loc.lua"] = "1.4.1"
QuestHelper_Loadtime["routing_loc.lua"] = GetTime()

-- Okay, this is going to be revamped seriously later, but for now:
-- .c is continent, either 0, 3, or -77
-- .x is x-coordinate
-- .y is y-coordinate
-- .p is original-questhelper plane
-- that's it.

-- Also, we're gonna pull something similar as with Collect to wrap everything up and not pollute the global space. But for now we don't.

-- LOCATIONS ARE IMMUTABLE, THEY NEVER CHANGE, THIS IS INCREDIBLY IMPORTANT

function NewLoc(c, x, y, rc, rz)
  QuestHelper: Assert(c)
  QuestHelper: Assert(x)
  QuestHelper: Assert(y)
  local tab = QuestHelper:CreateTable("location")
  tab.c = c
  tab.x = x
  tab.y = y
  if not QuestHelper_IndexLookup[rc] or not QuestHelper_IndexLookup[rc][rz] then
    QuestHelper:TextOut(string.format("lolwut %s %s", tostring(rc), tostring(rz)))
  end
  QuestHelper: Assert(QuestHelper_IndexLookup[rc])
  QuestHelper: Assert(QuestHelper_IndexLookup[rc][rz])
  tab.p = QuestHelper_IndexLookup[rc][rz]
  return tab
end

function IsLoc(c)
  return c and c.c and c.x and c.y and c.p
end
