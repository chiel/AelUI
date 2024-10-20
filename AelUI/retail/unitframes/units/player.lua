local _, ns = ...

local a = ns.anchors
local e = ns.unitframes.elements

local styler = ns.unitframes.createStyler({
	indicators = {
		leader = true,
	},
	texts = {
		health = true,
		healthpercent = true,
	},
})

table.insert(ns.unitframes.units, {
	name = 'player',

	spawn = function(self)
		local f = self:Spawn('player', 'AelUIPlayer')
		f:SetSize(300, 40)
		f:SetPoint('TOPRIGHT', a.primary, 'TOPLEFT', -20, 0)
	end,

	style = function(self, unit)
		styler(self, unit)

		local power = e.power(self, unit)
		power:SetPoint('BOTTOMLEFT', a.primary, 'TOPLEFT', 0, 2)
		power:SetPoint('BOTTOMRIGHT', a.primary, 'TOPRIGHT', 0, 2)
		power:SetHeight(16)

		local powerText = e.text(self.Power, { size = 18, style = 'bold' })
		powerText:SetPoint('BOTTOM', 0, -1)
		self:Tag(powerText, '[AelUI:powercurrent]')

		local castbar = e.castbar(self, unit)
		castbar:SetPoint('TOPLEFT', a.secondary, 'BOTTOMLEFT', 0, -2)
		castbar:SetPoint('TOPRIGHT', a.secondary, 'BOTTOMRIGHT', 0, -2)
		castbar:SetHeight(16)

		local _, playerClass = UnitClass('player')
		if playerClass == 'DEATHKNIGHT' then
			local runes = e.runes(self, unit)
			runes:SetHeight(10)
			runes:SetPoint('BOTTOMLEFT', power, 'TOPLEFT', 0, -1)
			runes:SetFrameLevel(runes:GetFrameLevel() - 1)

			a.primary:OnResize(function(width)
				runes:UpdateWidth(width)
			end)
		end
	end,
})
