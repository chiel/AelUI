local addon = select(2, ...)

local glowTypeMap = {
	button = 'buttonOverlay',
	pixel = 'Pixel',
}

addon.display.CreateGlow = function(type, options)
	local o = options or {}

	local aura = {
		table = {
			type = 'subglow',
			glow = o.enabled or false,
			glowType = type ~= nil and glowTypeMap[type] or glowTypeMap.button,
			glowColor = o.color,
			useGlowColor = o.color ~= nil,
			glowFrequency = o.speed or 0.25,
			glowLength = o.length or 10,
			glowLines = o.lines or 8,
			glowScale = o.scale or 1,
			glowThickness = o.thickness or 1,
			glowXOffset = o.x or 0,
			glowYOffset = o.y or 0,
		},
	}

	aura.Serialize = function(self)
		return self.table
	end

	return aura
end
