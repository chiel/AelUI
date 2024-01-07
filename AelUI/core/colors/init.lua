local addon = select(2, ...)

if oUF ~= nil then
	addon.core.colors = setmetatable({
		power = setmetatable({
			['ENERGY'] = { 188 / 255, 175 / 255, 96 / 255 },
			['MANA'] = { 75 / 255, 153 / 255, 229 / 255 },
			['RAGE'] = { 255 / 255, 91 / 255, 79 / 255 },
			['RUNIC_POWER'] = { 0 / 255, 196 / 255, 239 / 255 },
		}, { __index = oUF.colors.power }),
	}, { __index = oUF.colors })
end
