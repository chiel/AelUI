local addon = select(2, ...)

local function createUpdateHealthColor(backdrop)
	return function(self, event, unit)
		local health = self.Health
		if health.disconnected or UnitIsDeadOrGhost(unit) then
			health:SetValue(0)
		end

		local color = addon.utils.UnitColor(unit)
		if color then
			local r, g, b = unpack(color)
			backdrop.background:SetVertexColor(r * 0.75, g * 0.75, b * 0.75)
		end
	end
end

function addon.elements.Health(self, unit)
	local backdrop = addon.elements.Backdrop(self)

	local health = CreateFrame('StatusBar', nil, backdrop)
	health:SetStatusBarTexture(addon.media.texture)
	health.colorTapping = unit ~= 'raid'
	health.colorDisconnected = true
	health:SetStatusBarColor(38 / 255, 38 / 255, 38 / 255)
	health:SetPoint('TOPLEFT', 1, -1)
	health:SetPoint('BOTTOMRIGHT', -1, 1)
	health.UpdateColor = createUpdateHealthColor(backdrop)

	self.Health = health

	return backdrop
end
