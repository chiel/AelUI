local _, ns = ...

ns.unitframes.elements.tickspark = function(f, parent)
	local spark = parent:CreateTexture(nil, 'OVERLAY', nil, 7)
	spark:SetTexture([[Interface\CastingBar\UI-CastingBar-Spark]])
	spark:SetBlendMode('ADD')
	spark:SetWidth(16)
	spark:Hide()

	local lastTickTime = GetTime()
	local lastPower = 0
	local lastPowerType = -1

	local ticker = CreateFrame('Frame', nil, parent)
	ticker:SetScript('OnUpdate', function()
		local powerType = UnitPowerType(f.unit)

		-- Rage doesn't regen on ticks
		if powerType == Enum.PowerType.Rage then
			spark:Hide()
			return
		end

		local current = UnitPower(f.unit, powerType)
		local now = GetTime()

		-- Reset power tracking on form shift (but preserve tick timer)
		if powerType ~= lastPowerType then
			lastPower = current
			lastPowerType = powerType
		end

		-- Detect tick
		if current > lastPower then
			local diff = current - lastPower
			if powerType == Enum.PowerType.Energy then
				-- Energy: filter by expected tick amount
				local max = UnitPowerMax(f.unit, Enum.PowerType.Energy)
				if (diff > 18 and diff < 22)
					or (diff > 38 and diff < 42)
					or (diff < 42 and current == max) then
					lastTickTime = now
				end
			else
				-- Mana: any increase is a tick (amount varies with spirit)
				lastTickTime = now
			end
		end

		-- Fallback: resync (use while to catch up instantly after bear form etc)
		while now - lastTickTime >= 2 do
			lastTickTime = lastTickTime + 2
		end

		lastPower = current

		-- Position spark across the bar area (1px inset for border)
		local progress = (now - lastTickTime) / 2
		local width = parent:GetWidth() - 2
		local x = 1 + progress * width

		spark:ClearAllPoints()
		spark:SetPoint('TOP', parent, 'TOPLEFT', x, 3)
		spark:SetPoint('BOTTOM', parent, 'BOTTOMLEFT', x, -3)
		spark:Show()
	end)
end
