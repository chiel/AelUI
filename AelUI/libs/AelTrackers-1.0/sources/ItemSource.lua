local lib = LibStub('AelTrackers-1.0')

local ItemSource = {}
ItemSource.__index = ItemSource
setmetatable(ItemSource, { __index = lib.utils.Watchable })

lib.sources.createItem = function(itemId, options)
	options = options or {}

	local source = setmetatable({
		icon = options.icon,
		itemId = itemId,
	}, ItemSource)

	return source
end

function ItemSource:Apply(tracker)
	if self.icon then
		self.icon:Texture(C_Item.GetItemIconByID(self.itemId))
	end
end
