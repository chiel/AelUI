local _, ns = ...

ns.repbar.getData = function()
	if C_Reputation and C_Reputation.GetWatchedFactionData then
		local d = C_Reputation.GetWatchedFactionData()
		if not d then return nil end

		return {
			name = d.name,
			current = d.currentStanding - d.currentReactionThreshold,
			max = d.nextReactionThreshold - d.currentReactionThreshold,
			color = FACTION_BAR_COLORS[d.reaction] or FACTION_BAR_COLORS[4],
			reaction = d.reaction,
		}
	end

	local name, standing, min, max, value = GetWatchedFactionInfo()
	if not name then return nil end

	return {
		name = name,
		current = value - min,
		max = max - min,
		color = FACTION_BAR_COLORS[standing] or FACTION_BAR_COLORS[4],
		reaction = standing,
	}
end
