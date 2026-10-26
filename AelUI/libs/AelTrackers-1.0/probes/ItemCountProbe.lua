local AelEvents = LibStub('AelEvents-1.0')
local lib = LibStub('AelTrackers-1.0')

local ItemCountProbe = {}
ItemCountProbe.__index = ItemCountProbe
setmetatable(ItemCountProbe, { __index = lib.utils.Watchable })

lib.probes.createItemCountProbe = function(itemId)
	local probe = setmetatable({
		itemId = itemId,
	}, ItemCountProbe)

	probe:Update()
	return probe
end

function ItemCountProbe:Count()
	return self.count
end

function ItemCountProbe:OnWatch()
	AelEvents.on('BAG_UPDATE_DELAYED', function()
		self:Update()
	end)

	self:Update()
end

function ItemCountProbe:Update()
	local count = C_Item.GetItemCount(self.itemId)
	if count == self.count then
		return
	end

	self.count = count
	self:Notify(count)
end
