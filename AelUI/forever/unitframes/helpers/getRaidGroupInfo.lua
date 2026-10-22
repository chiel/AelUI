local _, ns = ...

ns.unitframes.helpers.getRaidGroupInfo = function()
	local groupCount = 0
	local memberCounts = {}
	local maxGroupSize = 0

	for i = 1, GetNumGroupMembers() do
		local _, _, subgroup = GetRaidRosterInfo(i)
		if subgroup then
			memberCounts[subgroup] = (memberCounts[subgroup] or 0) + 1
			if memberCounts[subgroup] > maxGroupSize then
				maxGroupSize = memberCounts[subgroup]
			end
		end
	end

	-- GetRaidRosterInfo only works in raids, so for party/solo we get
	-- the amount of members in the group and add those to group 1
	if not next(memberCounts) then
		local n = GetNumGroupMembers()
		maxGroupSize = math.max(n, 1)
		memberCounts[1] = maxGroupSize
	end

	for _ in pairs(memberCounts) do
		groupCount = groupCount + 1
	end

	return memberCounts, maxGroupSize, groupCount
end
