local lib = LibStub('AelTrackers-1.0')

local ItemSource = {}
ItemSource.__index = ItemSource
setmetatable(ItemSource, { __index = lib.utils.Watchable })

lib.sources.createItem = function(itemId, options)
	options = options or {}

	local source = setmetatable({
		durations = options.durations or {},
		icon = options.icon,
		itemId = itemId,
	}, ItemSource)

	return source
end

function ItemSource:Apply(tracker)
	local duration = self.cooldownProbe and self.cooldownProbe:Duration()

	for _, d in ipairs(self.durations) do
		d:Duration(duration)
	end

	if self.icon then
		self.icon:Texture(C_Item.GetItemIconByID(self.itemId))
	end
end

function ItemSource:Build(tracker)
	if self.cooldownProbe then
		self.cooldownProbe:Watch(function()
			self:Notify()
		end)
	end
end

function ItemSource:IsOnCooldown()
	return self.cooldownProbe:IsOnCooldown()
end

function ItemSource:RequireCooldown()
	if self.cooldownProbe then
		return
	end

	self.cooldownProbe = lib.probes.createItemCooldownProbe(self.itemId)
end
