local _, ns = ...

local e = ns.unitframes.elements
local m = ns.media

table.insert(ns.unitframes.units, function()
	local f = ns.unitframes.spawn('player')
	f:SetPoint('TOPRIGHT', AelUIPrimaryAnchor, 'TOPLEFT', -20, 0)
	f:SetSize(280, 58)

	local healthbar = e.healthbar(f)
	healthbar:SetAllPoints()

	local powerbar = e.powerbar(f)
	powerbar:SetPoint('BOTTOMLEFT', AelUIPrimaryAnchor, 'TOPLEFT', 0, 2)
	powerbar:SetPoint('BOTTOMRIGHT', AelUIPrimaryAnchor, 'TOPRIGHT', 0, 2)
	powerbar:SetHeight(16)

	local _, playerClass = UnitClass('player')
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

	local function onUpdateCastbar(self, state)
		self:SetHeight(state.gcd and 8 or 16)
	end

	local castbar = e.castbar(f, { onUpdate = onUpdateCastbar })
	castbar:SetPoint('TOPLEFT', AelUISecondaryAnchor, 'BOTTOMLEFT', 0, -2)
	castbar:SetPoint('TOPRIGHT', AelUISecondaryAnchor, 'BOTTOMRIGHT', 0, -2)
	castbar:SetHeight(16)

	return f
end)
