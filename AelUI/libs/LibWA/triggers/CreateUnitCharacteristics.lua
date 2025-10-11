local _, addon = ...

addon.triggers.CreateUnitCharacteristics = function(unit, o)
	local aura = {
		table = {
			trigger = {
				type = 'unit',
				event = 'Unit Characteristics',
				unit = unit,
			},
			untrigger = {},
		},
	}

	local trigger = aura.table.trigger

	if o.class ~= nil then
		trigger.use_class = true
		trigger.class = o.class
	end

	if o.character ~= nil then
		trigger.use_character = true
		trigger.character = o.character
	end

	if o.level ~= nil then
		trigger.use_level = true
		trigger.level = {}
		trigger.level_operator = {}

		for _, level in ipairs(o.level) do
			table.insert(trigger.level_operator, level[1])
			table.insert(trigger.level, tostring(level[2]))
		end
	end

	if o.inCombat ~= nil then
		trigger.use_inCombat = o.inCombat
	end

	aura.Serialize = function(self)
		return self.table
	end

	return aura
end
