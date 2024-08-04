local _, addon = ...

local glowTypeMap = {
	autocast = 'ACShine',
	button = 'buttonOverlay',
	pixel = 'Pixel',
	proc = 'Proc',
}

addon.display.CreateGlow = function(type, options)
	local o = options or {}

	local aura = {
		table = {
			type = 'subglow',
			glow = o.enabled or false,
			glowType = type ~= nil and glowTypeMap[type] or glowTypeMap.button,
			glowBorder = o.border or false,
			glowColor = o.color or { 1, 1, 1, 1 },
			useGlowColor = o.color ~= nil,
			glowDuration = o.duration ~= nil and o.duration or 1,
			glowFrequency = o.speed or 0.25,
			glowLength = o.length or 10,
			glowLines = o.lines or 8,
			glowScale = o.scale or 1,
			glowStartAnim = o.startAnimation or false,
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
