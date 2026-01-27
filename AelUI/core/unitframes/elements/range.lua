local _, ns = ...

local UPDATE_INTERVAL = 0.2

ns.unitframes.elements.range = function(f, options)
	local o = options or {}

	local insideAlpha = o.insideAlpha or 1
	local outsideAlpha = o.outsideAlpha or 0.5

	local elapsed = 0
	local lastGUID

	f:HookScript('OnUpdate', function(self, delta)
		if not self.unit then return end

		local guid = UnitGUID(self.unit)
		if guid ~= lastGUID then
			lastGUID = guid
			elapsed = UPDATE_INTERVAL -- Force immediate check
		end

		elapsed = elapsed + delta
		if elapsed < UPDATE_INTERVAL then return end
		elapsed = 0

		local inRange, checkedRange = UnitInRange(self.unit)
		if checkedRange and not inRange then
			self:SetAlpha(outsideAlpha)
		else
			self:SetAlpha(insideAlpha)
		end
	end)
end
