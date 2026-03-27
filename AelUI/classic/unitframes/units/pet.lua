local _, ns = ...

local e = ns.unitframes.elements

table.insert(ns.unitframes.units, function()
	local f = ns.unitframes.spawn('pet')
	f:SetPoint('TOPLEFT', AelUIPlayerFrame, 'BOTTOMLEFT', 0, -2)
	f:SetSize(175, 30)

	local healthbar, healthbarBar = e.healthbar(f)
	healthbar:SetAllPoints()

	local name = e.nameText(f, healthbarBar, { fontSize = 16 })
	name:SetPoint('BOTTOMLEFT', healthbar, 'BOTTOMLEFT', 6, 2)

	local marker = e.raidmarker(f, healthbarBar, { size = 16 })
	marker:SetPoint('LEFT', healthbarBar, 'LEFT', 2, 0)

	local _, playerClass = UnitClass('player')
	if playerClass == 'HUNTER' then
		local happiness = e.happiness(f, healthbarBar, { fontSize = 20 })
		happiness:SetPoint('RIGHT', healthbar, 'RIGHT', -4, 1)

		local whitelist = {
			[27046] = true,
			[1539] = true,
		}

		local buffs = e.auras(f, 'HELPFUL', {
			iconSize = 30,
			spacing = 2,
			initialAnchor = 'TOPLEFT',
			growthX = 'RIGHT',
			filter = function(
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
				return whitelist[spellId]
			end,
		})
		buffs:SetPoint('TOPLEFT', f, 'TOPRIGHT', 2, 0)
	end

	return f
end)
