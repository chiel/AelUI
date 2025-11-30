local _, ns = ...

ns.auras.CreateGroupBase = function(id)
	local aura = {
		base = ns.auras.CreateBase(id),
		children = {},
	}

	aura.AddChild = function(self, child)
		child:SetParent(self.base.id)
		table.insert(self.children, child)
	end

	aura.SetAnchor = function(self, anchor)
		self.anchor = anchor
	end

	aura.SetIcon = function(self, icon)
		self.icon = icon
	end

	aura.SetParent = function(self, ...)
		self.base:SetParent(...)
	end

	aura.Serialize = function(self)
		local r = self.base:Serialize()
		local rc = {}

		r.controlledChildren = {}
		r.groupIcon = self.icon

		if self.anchor ~= nil then
			local a = self.anchor
			r.anchorFrameType = a.type
			r.anchorFrameFrame = a.frame
			r.anchorPoint = a.to
			r.selfPoint = a.from
			r.xOffset = a.x
			r.yOffset = a.y
		end

		for _, child in ipairs(self.children) do
			local childAura, grandChildren = child:Serialize()
			table.insert(r.controlledChildren, childAura.id)
			table.insert(rc, childAura)

			if grandChildren ~= nil then
				for _, grandChild in ipairs(grandChildren) do
					table.insert(rc, grandChild)
				end
			end
		end

		return r, rc
	end

	return aura
end
