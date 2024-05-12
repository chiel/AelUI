AelTodo.checkers.Multiple = function(requiredCount, checkers)
	if requiredCount == 'ALL' then
		requiredCount = #checkers
	end

	if requiredCount == 'ANY' then
		requiredCount = 1
	end

	return function()
		local completedCount = 0
		for _, checker in ipairs(checkers) do
			if checker() then
				completedCount = completedCount + 1
			end
		end

		return completedCount >= requiredCount, completedCount, requiredCount
	end
end
