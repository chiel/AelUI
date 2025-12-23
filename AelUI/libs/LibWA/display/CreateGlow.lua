local _, ns = ...

local glowTypeMap = {
	autocast = 'ACShine',
	button = 'buttonOverlay',
	pixel = 'Pixel',
}

ns.display.CreateGlow = function(type, options)
	local o = options or {}

	local aura = {
		enabled = o.enabled,
		type = type,
		border = o.border,
		color = o.color,
		duration = o.duration,
		speed = o.speed,
		length = o.length,
		lines = o.lines,
		scale = o.scale,
		startAnimation = o.startAnimation,
		thickness = o.thickness,
		x = o.x,
		y = o.y,
	}

	aura.Serialize = function(self)
		return {
			type = 'subglow',
			glow = self.enabled or false,
			glowType = self.type ~= nil and glowTypeMap[self.type] or glowTypeMap.button,
			glowBorder = self.border or false,
			glowColor = self.color or { 1, 1, 1, 1 },
			useGlowColor = self.color ~= nil,
			glowDuration = self.duration ~= nil and self.duration or 1,
			glowFrequency = self.speed or 0.25,
			glowLength = self.length or 10,
			glowLines = self.lines or 8,
			glowScale = self.scale or 1,
			glowStartAnim = self.startAnimation or false,
			glowThickness = self.thickness or 1,
			glowXOffset = self.x or 0,
			glowYOffset = self.y or 0,
		}
	end

	return aura
end
