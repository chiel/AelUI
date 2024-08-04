local _, addon = ...

addon.triggers.CreateUnitCharacteristics = function(o)
	local aura = {
		table = {
			trigger = {
				type = 'unit',
				event = 'Unit Characteristics',
				unit = o.unit,
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

	aura.Serialize = function(self)
		return self.table
	end

	return aura
end
