local _, addon = ...

local presetMap = {
	finish = {
		bounce = 'bounceDecay',
		slideDown = 'slidebottom',
		slideLeft = 'slideleft',
		slideRight = 'slideright',
		slideUp = 'slidetop',
		starShake = 'starShakeDecay',
	},
	main = {
		flash = 'alphaPulse',
		spiral = 'spiralandpulse',
	},
	start = {
		bounce = 'bounceDecay',
		grow = 'shrink',
		shrink = 'grow',
		slideDown = 'slidetop',
		slideLeft = 'slideright',
		slideRight = 'slideleft',
		slideUp = 'slidebottom',
		starShake = 'starShakeDecay',
	},
}

addon.animations.CreateAnimation = function(stage, type, config)
	local aura = {
		config = config,
		stage = stage,
		type = type,
	}

	if type == 'custom' then
		print('[LibWA] Custom animations have not been implemented yet.')
	end

	aura.Serialize = function(self)
		if self.type == 'preset' then
			return {
				type = 'preset',
				preset = presetMap[self.stage][self.config] or self.config,
			}
		end

		return nil
	end

	return aura
end
