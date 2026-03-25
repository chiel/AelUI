local _, ns = ...

local bank = ns.storage.bank
local state = bank.state

local function fetchBag(bagID)
	local numSlots = C_Container.GetContainerNumSlots(bagID)
	local _, bagFamily = C_Container.GetContainerNumFreeSlots(bagID)
	return { numSlots = numSlots, bagFamily = bagFamily or 0 }
end

state.build = function()
	local bags = {}
	for _, bagID in ipairs(bank.bagIds) do
		bags[bagID] = fetchBag(bagID)
	end
	state.bags = bags
end

state.updateBag = function(bagID)
	if not state.bags then return end
	state.bags[bagID] = fetchBag(bagID)
end
