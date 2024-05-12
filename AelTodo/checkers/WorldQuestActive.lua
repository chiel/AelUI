AelTodo.checkers.WorldQuestActive = function(quest)
	return function()
		return C_TaskQuest.IsActive(quest)
	end
end
