local _, ns = ...

local h = ns.helpers

local auraFunctions = {
	HELPFUL = UnitBuff,
	HARMFUL = UnitDebuff,
}

local debuffTypeColors = {
	Magic   = { 0.2, 0.6, 1 },
	Curse   = { 0.6, 0,   1 },
	Disease = { 0.6, 0.4, 0 },
	Poison  = { 0,   0.6, 0 },
}

ns.unitframes.elements.auras = function(f, type, options)
	local o = options or {}
	local auraFn = auraFunctions[type]
	local iconSize = o.iconSize or 18
	local spacingX = o.spacingX or o.spacing or 1
	local spacingY = o.spacingY or o.spacing or 1
	local filter = o.filter
	local initialAnchor = o.initialAnchor or 'BOTTOMLEFT'
	local growthx = (o.growthX == 'LEFT' and -1) or 1
	local growthy = (o.growthY == 'DOWN' and -1) or 1
	local colorBorders = type == 'HARMFUL'

	local sizex = iconSize + spacingX
	local sizey = iconSize + spacingY

	local container = CreateFrame('Frame', nil, f)
	container:SetSize(1, 1)

	local icons = {}

	local function getIcon(idx)
		if not icons[idx] then
			icons[idx] = h.createIcon(container, iconSize)
		end
		return icons[idx]
	end

	local function update(self)
		if not self.unit then return end

		local idx = 1
		for i = 1, 40 do
			local name, texture, count, debuffType, duration, expirationTime, caster, isStealable, nameplateShowPersonal, spellId =
				auraFn(self.unit, i)
			if not name then break end

			if not filter or filter(name, texture, count, debuffType, duration, expirationTime, caster, isStealable, nameplateShowPersonal, spellId) then
				local icon = getIcon(idx)
				icon:ClearAllPoints()
				icon:SetPoint(initialAnchor, container, initialAnchor, (idx - 1) * sizex * growthx, 0)
				icon.texture:SetTexture(texture)
				if duration and duration > 0 then
					icon.cooldown:SetCooldown(expirationTime - duration, duration)
				else
					icon.cooldown:Clear()
				end
				icon.stacks:SetText(count and count > 1 and count or '')

				if colorBorders then
					local color = debuffTypeColors[debuffType]
					if color then
						icon:SetBackdropBorderColor(color[1], color[2], color[3])
					else
						icon:SetBackdropBorderColor(0, 0, 0)
					end
				end

				icon:Show()
				idx = idx + 1
			end
		end

		for i = idx, #icons do
			icons[i]:Hide()
		end
	end

	f:RegisterCallback('UNIT_AURA', update)
	f:RegisterCallback('PLAYER_REGEN_DISABLED', update)
	f:RegisterCallback('PLAYER_REGEN_ENABLED', update)

	f.updaters[update] = true
	update(f)

	return container
end
