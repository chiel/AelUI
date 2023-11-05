local addon = select(2, ...)

addon.nameplates = {}

local nameplatesEnabled = false

oUF:RegisterStyle('AelUI:nameplate', function(self, unit)
	if not unit:match 'nameplate' then
		return
	end

	self:SetSize(120, 10)
	self:SetPoint('CENTER', 0, 0)

	local health = addon.elements.Health(self, unit)
	health:SetAllPoints()

	local name = addon.elements.Text(self.Health, { size = 8 })
	name:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 2, -3)
	self:Tag(name, '[AelUI:name]')
	health.PostUpdateColor = function(r, g, b)
		name:SetTextColor(r, g, b)
	end
end)

if nameplatesEnabled then
	oUF:Factory(function(self)
		self:SetActiveStyle 'AelUI:nameplate'
		self:SpawnNamePlates('AelUINamePlate', function(frame, event, unit)
			if frame == nil then
				return
			end
		end)
	end)
end
