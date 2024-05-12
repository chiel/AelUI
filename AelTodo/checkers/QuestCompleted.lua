AelTodo.checkers.QuestCompleted = function(questID, shouldBeCompleted)
	return function()
		if shouldBeCompleted == nil then
			shouldBeCompleted = true
		end

		local completed = C_QuestLog.IsQuestFlaggedCompleted(questID)
		return shouldBeCompleted == completed
	end
end
