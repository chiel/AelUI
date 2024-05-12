AelTodo.checkers.AchievementCompleted = function(achievementID, shouldBeCompleted)
	return function()
		if shouldBeCompleted == nil then
			shouldBeCompleted = true
		end

		local _, _, _, completed = GetAchievementInfo(achievementID)
		return shouldBeCompleted == completed
	end
end
