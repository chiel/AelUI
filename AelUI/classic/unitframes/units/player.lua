local _, ns = ...

local e = ns.unitframes.elements
local m = ns.media

table.insert(ns.unitframes.units, {
	unit = 'player',
	style = function(f)
		f:SetPoint('TOPRIGHT', AelUIPrimaryAnchor, 'TOPLEFT', -20, 0)
		f:SetSize(280, 60)

		local healthbar = e.healthbar(f)
		healthbar:SetAllPoints()

		local powerbar = e.powerbar(f)
		powerbar:SetPoint('BOTTOMLEFT', AelUIPrimaryAnchor, 'TOPLEFT', 0, 2)
		powerbar:SetPoint('BOTTOMRIGHT', AelUIPrimaryAnchor, 'TOPRIGHT', 0, 2)
		powerbar:SetHeight(16)

		local function onUpdate(bd, state)
			if state.gcd then
				bd:SetHeight(6)
			else
				bd:SetHeight(16)
			end
		end

		local castbar = e.castbar(f, { onUpdate = onUpdate })
		castbar:SetPoint('TOPLEFT', AelUISecondaryAnchor, 'BOTTOMLEFT', 0, -2)
		castbar:SetPoint('TOPRIGHT', AelUISecondaryAnchor, 'BOTTOMRIGHT', 0, -2)
		castbar:SetHeight(16)

		return f
	end,
})
