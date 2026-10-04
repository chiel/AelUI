local _, ns = ...

local e = ns.unitframes.elements

ns.unitframes.units.spawn('player', function(f)
	f:SetSize(300, 58)
	f:SetPoint('TOPRIGHT', AelUIPrimaryAnchor, 'TOPLEFT', -20, 0)

	local healthbar, healthbarBar = e.healthbar(f)
	healthbar:SetAllPoints()

	local powerbar = e.powerbar(f)
	powerbar:SetPoint('BOTTOMLEFT', AelUIPrimaryAnchor, 'TOPLEFT', 0, 2)
	powerbar:SetPoint('BOTTOMRIGHT', AelUIPrimaryAnchor, 'TOPRIGHT', 0, 2)
	powerbar:SetHeight(16)

	local castbar = e.castbar(f, {
		onUpdate = function(self, state)
			self:SetHeight(state.isGCD and 6 or 16)
		end,
	})
	castbar:SetPoint('TOPLEFT', AelUIPrimaryAnchor, 'BOTTOMLEFT', 0, -2)
	castbar:SetPoint('TOPRIGHT', AelUIPrimaryAnchor, 'BOTTOMRIGHT', 0, -2)
	castbar:SetHeight(16)

	local name = e.nameText(f, healthbarBar, { fontSize = 24 })
	name:SetPoint('BOTTOMLEFT', healthbar, 'BOTTOMLEFT', 6, 0)

	local hpPct = e.healthPercentText(f, healthbarBar, { fontSize = 20 })
	hpPct:SetPoint('BOTTOMRIGHT', healthbar, 'BOTTOMRIGHT', -4, 0)

	local hpCur = e.healthCurrentText(f, healthbarBar, { fontSize = 16 })
	hpCur:SetPoint('BOTTOMRIGHT', hpPct, 'TOPRIGHT', 0, 0)

	local leaderIcon = e.leaderIcon(f, healthbarBar)
	leaderIcon:SetPoint('TOPLEFT', 4, 0)
	leaderIcon:SetSize(24, 24)
end)
