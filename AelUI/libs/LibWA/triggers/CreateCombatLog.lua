local _, addon = ...

addon.triggers.CreateCombatLog = function(options)
	local o = options or {}
	local subevent = o.subevent or {}

	local aura = {
		subevent = o.subevent,
		sourceUnit = o.sourceUnit,
		spellId = o.spellId,
		duration = o.duration,
	}

	aura.Serialize = function(self)
		local r = {
			type = 'combatlog',
			event = 'Combat Log',
		}

		if self.subevent then
			r.subeventPrefix = string.upper(self.subevent[1])
			r.subeventSuffix = self.subevent[2] ~= nil and '_' .. string.upper(self.subevent[2]) or ''
		end

		if o.destinationUnit then
			r.use_destUnit = true
			r.destUnit = o.destinationUnit
		end

		if self.sourceUnit then
			r.use_sourceUnit = true
			r.sourceUnit = self.sourceUnit
		end

		if o.spellIds then
			r.use_spellId = true
			r.spellId = o.spellIds
		end

		if self.duration then
			r.duration = tostring(self.duration)
		end

		return {
			trigger = r,
			untrigger = {},
		}
	end

	return aura
end
