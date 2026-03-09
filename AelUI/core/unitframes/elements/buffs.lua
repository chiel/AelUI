local _, ns = ...

local h = ns.helpers

ns.unitframes.elements.buffs = function(f, options)
	local o = options or {}
	local parent = o.parent or f
	local iconSize = o.iconSize or 20
	local spacing = o.spacing or 1
	local filter = o.filter

	local icons = {}

	local function getIcon(idx)
		if not icons[idx] then
			local icon = h.createIcon(parent, iconSize)
			if idx == 1 then
				icon:SetPoint('TOPRIGHT', parent, 'TOPRIGHT', -1, -1)
			else
				icon:SetPoint('RIGHT', icons[idx - 1], 'LEFT', -spacing, 0)
			end
			icons[idx] = icon
		end
		return icons[idx]
	end

	local function update(self)
		if not self.unit then
			return
		end

		local idx = 1
		for i = 1, 40 do
			local name, texture, count, debuffType, duration, expirationTime, caster, isStealable, nameplateShowPersonal, spellId =
				UnitBuff(self.unit, i)
			if not name then
				break
			end

			if
				not filter
				or filter(
					name,
					texture,
					count,
					debuffType,
					duration,
					expirationTime,
					caster,
					isStealable,
					nameplateShowPersonal,
					spellId
				)
			then
				local icon = getIcon(idx)
				icon.texture:SetTexture(texture)
				if duration and duration > 0 then
					icon.cooldown:SetCooldown(expirationTime - duration, duration)
				else
					icon.cooldown:Clear()
				end
				icon.stacks:SetText(count and count > 1 and count or '')
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
