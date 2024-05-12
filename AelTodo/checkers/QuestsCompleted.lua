AelTodo.checkers.QuestsCompleted = function(amount, quests)
	return function()
		if amount == 'ALL' then
			amount = #quests
		end

		if amount == 'ANY' then
			amount = 1
		end

		if amount == 'NONE' then
			amount = 0
		end

		local completedCount = 0
		for _, quest in ipairs(quests) do
			local completed = C_QuestLog.IsQuestFlaggedCompleted(quest)
			if completed then
				completedCount = completedCount + 1

				if amount > 0 and completedCount >= amount then
					return true, completedCount, amount
				end
			end
		end

		if amount == 0 and completedCount == 0 then
			return true, completedCount, amount
		end

		return false, completedCount, amount
	end
end
