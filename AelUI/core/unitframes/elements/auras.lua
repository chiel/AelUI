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
	local parent = o.parent or f
	local iconSize = o.iconSize or 18
	local spacing = o.spacing or 1
	local filter = o.filter
	local anchor = o.anchor or 'TOPLEFT'
	local grow = o.grow or 'RIGHT'
	local colorBorders = type == 'HARMFUL'

	local icons = {}

	local function getIcon(idx)
		if not icons[idx] then
			local icon = h.createIcon(parent, iconSize)
			if idx == 1 then
				icon:SetPoint(anchor, parent, anchor, anchor:find('RIGHT') and -1 or 1, anchor:find('TOP') and -1 or 1)
			else
				if grow == 'RIGHT' then
					icon:SetPoint('LEFT', icons[idx - 1], 'RIGHT', spacing, 0)
				else
					icon:SetPoint('RIGHT', icons[idx - 1], 'LEFT', -spacing, 0)
				end
			end
			icons[idx] = icon
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

	return icons
end
