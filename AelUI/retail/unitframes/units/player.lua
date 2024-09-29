local _, ns = ...

local a = ns.anchors
local e = ns.unitframes.elements

table.insert(ns.unitframes.units, {
	name = 'player',

	spawn = function(self)
		local f = self:Spawn('player', 'AelUIPlayer')
		f:SetSize(300, 40)
		f:SetPoint('TOPRIGHT', a.primary, 'TOPLEFT', -20, 0)
	end,

	style = function(self, unit)
		self:RegisterForClicks('AnyUp')
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		local health = e.health(self, unit)
		health:SetAllPoints()
	end,
})
