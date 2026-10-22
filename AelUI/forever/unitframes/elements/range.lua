local _, ns = ...

ns.unitframes.elements.range = function(f, options)
	local o = options or {}

	local insideAlpha = o.insideAlpha or 1
	local outsideAlpha = o.outsideAlpha or 0.5

	local function update(self)
		if not self.unit then
			return
		end

		if self.unit == 'player' then
			self:SetAlpha(1)
			return
		end

		local inRange = UnitInRange(self.unit)
		self:SetAlphaFromBoolean(inRange, insideAlpha, outsideAlpha)
	end

	f:RegisterCallback('UNIT_CONNECTION', update)
	f:RegisterCallback('UNIT_IN_RANGE_UPDATE', update)

	update(f)
end
