AelTodo.checkers.MountKnown = function(mountID, shouldBeKnown)
	return function()
		local _, _, _, _, _, _, _, _, _, _, isKnown = C_MountJournal.GetMountInfoByID(mountID)
		return isKnown == shouldBeKnown
	end
end
