local _, ns = ...

local MAX_LEVEL = 70

ns.xpbar.getData = function()
	local current = UnitXP('player')
	local max = math.max(UnitXPMax('player'), 1)
	local exhaustion = GetXPExhaustion() or 0

	return {
		current = current,
		max = max,
		exhaustion = exhaustion,
		isMaxLevel = UnitLevel('player') >= MAX_LEVEL,
	}
end
