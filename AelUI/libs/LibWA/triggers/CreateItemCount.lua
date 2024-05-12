local addon = select(2, ...)

addon.triggers.CreateItemCount = function(itemName, options)
	local o = options or {}

	local aura = {
		table = {
			trigger = {
				type = 'item',
				event = 'Item Count',
				itemName = itemName,
			},
			untrigger = {},
		},
	}

	local trigger = aura.table.trigger

	if o.count ~= nil then
		trigger.use_count = true
		trigger.count_operator = o.count[1]
		trigger.count = tostring(o.count[2])
	end

	if o.includeCharges ~= nil then
		trigger.use_includeCharges = o.includeCharges
	end

	aura.Serialize = function(self)
		return self.table
	end

	return aura
end
