

--~ TourGuideQuestHistoryDB

local TourGuide = TourGuide
local L = TourGuide.Locale
local hadquest


local turnedinquests, currentquests, oldquests, titles, firstscan, abandoning = {}, {}, {}, {}, true
TourGuide.turnedinquests = turnedinquests
local qids = setmetatable({}, {
	__index = function(t,i)
		local v = tonumber(i:match("|Hquest:(%d+):"))
		t[i] = v
		return v
	end,
})
TourGuide.QIDmemo = qids


function TourGuide:QUEST_QUERY_COMPLETE()
	GetQuestsCompleted(TourGuide.turnedinquests)
	self:UpdateStatusFrame()
end


function TourGuide:QuestID_QUEST_LOG_UPDATE()
	currentquests, oldquests = oldquests, currentquests
	for i in pairs(currentquests) do currentquests[i] = nil end

	for i=1,GetNumQuestLogEntries() do
		local link = GetQuestLink(i)
		local qid = link and qids[link]
		if qid then
			currentquests[qid] = true
			titles[qid] = GetQuestLogTitle(i)
		end
	end

	if firstscan then firstscan = nil; return end

	for qid in pairs(oldquests) do
		if not currentquests[qid] then
			local action = abandoning and "Abandoned quest" or "Turned in quest"
			if not abandoning then turnedinquests[qid] = true end
			abandoning = nil
			self:Debug(1, action, qid, titles[qid])
			return self:UpdateStatusFrame()
		end
	end

	for qid in pairs(currentquests) do
		if not oldquests[qid] then
			self:Debug(1, "Accepted quest", qid, titles[qid])
			return self:UpdateStatusFrame()
		end
	end
end


local orig = AbandonQuest
function AbandonQuest(...)
	abandoning = true
	return orig(...)
end

