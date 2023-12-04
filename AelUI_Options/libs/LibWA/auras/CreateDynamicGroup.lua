local addon = select(2, ...)

LibWA.CreateDynamicGroup = function(id)
	local aura = addon.auras.CreateBase(id)
	aura.table.regionType = 'dynamicgroup'
	aura.table.controlledChildren = {}
	aura.children = {}

	aura.AddChild = function(self, child)
		child:SetParent(self.id)
		table.insert(self.children, child)
		table.insert(self.table.controlledChildren, child.id)
	end

	aura.Serialize = function(self)
		local childAuras = {}
		for _, child in ipairs(self.children) do
			local boop, grandChildren = child:Serialize()
			table.insert(childAuras, boop)
			if grandChildren ~= nil then
				for _, grandChild in ipairs(grandChildren) do
					table.insert(childAuras, grandChild)
				end
			end
		end

		return self.table, childAuras
	end

	return aura
end
