local _, ns = ...

local nursery = CreateFrame('Frame', nil, UIParent)
nursery:Hide()

local pool = {}

ns.storage.slot.get = function()
	return table.remove(pool, 1) or ns.storage.slot.create(nursery)
end

ns.storage.slot.release = function(slot)
	slot:Hide()
	slot:SetParent(nursery)
	slot:SetItem(nil)
	table.insert(pool, slot)
end
