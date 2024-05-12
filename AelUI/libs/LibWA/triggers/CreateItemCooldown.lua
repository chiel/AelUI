local addon = select(2, ...)

local showMap = {
	always = 'showAlways',
	onCooldown = 'showOnCooldown',
	onReady = 'showOnReady',
}

addon.triggers.CreateItemCooldown = function(itemName, options)
	local o = options or {}

	local aura = {
		table = {
			trigger = {
				type = 'item',
				event = 'Cooldown Progress (Item)',
				itemName = itemName,
				genericShowOn = o.show ~= nil and showMap[o.show] or showMap.onCooldown,
			},
			untrigger = {},
		},
	}

	aura.Serialize = function(self)
		return self.table
	end

	return aura
end
