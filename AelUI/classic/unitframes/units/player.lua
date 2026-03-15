local _, ns = ...

local e = ns.unitframes.elements
local m = ns.media

table.insert(ns.unitframes.units, function()
	local f = ns.unitframes.spawn('player')
	f:SetPoint('TOPRIGHT', AelUIPrimaryAnchor, 'TOPLEFT', -20, 0)
	f:SetSize(350, 58)

	local healthbar, healthbarBar = e.healthbar(f)
	healthbar:SetAllPoints()

	local name = e.nameText(f, healthbarBar, { fontSize = 24 })
	name:SetPoint('BOTTOMLEFT', healthbar, 'BOTTOMLEFT', 6, 0)

	local pvp = e.pvpText(f, healthbarBar, { fontSize = 14 })
	pvp:SetPoint('BOTTOMLEFT', name, 'BOTTOMRIGHT', 8, 3)

	local hpPct = e.healthPercent(f, healthbarBar, { fontSize = 20 })
	hpPct:SetPoint('BOTTOMRIGHT', healthbar, 'BOTTOMRIGHT', -4, 0)

	local hpCur = e.healthCurrent(f, healthbarBar, { fontSize = 16 })
	hpCur:SetPoint('BOTTOMRIGHT', hpPct, 'TOPRIGHT', 0, 0)

	local resting = e.restingText(f, healthbarBar, { fontSize = 14 })
	resting:SetPoint('TOPLEFT', healthbar, 'TOPLEFT', 8, -2)

	local powerbar = e.powerbar(f)
	powerbar:SetPoint('BOTTOMLEFT', AelUIPrimaryAnchor, 'TOPLEFT', 0, 2)
	powerbar:SetPoint('BOTTOMRIGHT', AelUIPrimaryAnchor, 'TOPRIGHT', 0, 2)
	powerbar:SetHeight(16)

	local _, playerClass = UnitClass('player')
	if playerClass == 'DRUID' or playerClass == 'ROGUE' then
		local combopoints = e.combopoints(f)
		combopoints:SetPoint('BOTTOMLEFT', powerbar, 'TOPLEFT', 0, -1)
		combopoints:SetPoint('BOTTOMRIGHT', powerbar, 'TOPRIGHT', 0, -1)
		combopoints:SetHeight(4)
		powerbar:SetHeight(12)
	end

	if playerClass == 'DRUID' then
		local function onUpdateManabar(self, state)
			self:SetShown(state.displayType ~= state.powerType)
		end

		local manabar = e.powerbar(f, {
			powerType = Enum.PowerType.Mana,
			onUpdate = onUpdateManabar,
		})
		manabar:SetPoint('TOPRIGHT', healthbar, 'BOTTOMRIGHT', 0, -2)
		manabar:SetSize(140, 8)
	end

	local marker = e.raidmarker(f, healthbarBar)
	marker:SetPoint('LEFT', healthbarBar, 'LEFT', 4, 0)

	local function onUpdateCastbar(self, state)
		self:SetHeight(state.gcd and 6 or 16)
	end

	local castbar = e.castbar(f, { onUpdate = onUpdateCastbar })
	castbar:SetPoint('TOPLEFT', AelUISecondaryAnchor, 'BOTTOMLEFT', 0, -2)
	castbar:SetPoint('TOPRIGHT', AelUISecondaryAnchor, 'BOTTOMRIGHT', 0, -2)
	castbar:SetHeight(16)

	return f
end)
