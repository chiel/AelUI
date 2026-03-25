local _, ns = ...

local search = ns.storage.search

search.filterQuery = ''
search.listeners = {}

search.subscribe = function(cb)
	table.insert(search.listeners, cb)
end

search.notify = function(query)
	local q = query and query:lower():trim() or ''
	search.filterQuery = q
	for _, cb in ipairs(search.listeners) do
		cb(q)
	end
end

search.applyFilter = function(slots, q)
	for _, slot in ipairs(slots) do
		if q == '' then
			slot:SetAlpha(1)
		else
			local state = slot.state
			local match = false
			if state and state.tags then
				for _, tag in ipairs(state.tags) do
					if tag:find(q, 1, true) then
						match = true
						break
					end
				end
			end
			slot:SetAlpha(match and 1 or 0.2)
		end
	end
end
