local _, ns = ...

ns.repbar.getData = function()
	local d = C_Reputation.GetWatchedFactionData()
	if not d then
		return nil
	end

	local current = d.currentStanding - d.currentReactionThreshold
	local max = d.nextReactionThreshold - d.currentReactionThreshold
	local color = FACTION_BAR_COLORS[d.reaction] or FACTION_BAR_COLORS[4]

	return {
		name = d.name,
		current = current,
		max = max,
		color = color,
		reaction = d.reaction,
	}
end
