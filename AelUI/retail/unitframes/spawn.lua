local ns = select(2, ...)

local oUF = ns.oUF
local units = ns.unitframes.units

for _, unit in ipairs(units) do
	oUF:RegisterStyle('AelUI:' .. unit.name, unit.style)
end

oUF:Factory(function(self)
	for _, unit in ipairs(units) do
		self:SetActiveStyle('AelUI:' .. unit.name)
		unit.spawn(self)
	end
end)
