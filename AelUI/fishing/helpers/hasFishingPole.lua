local _, ns = ...

ns.fishing.helpers.hasFishingPole = function()
	local itemId = GetInventoryItemID('player', 16)
	if not itemId then
		return false
	end

	local subclassId = select(7, C_Item.GetItemInfoInstant(itemId))
	return subclassId == 20
end
