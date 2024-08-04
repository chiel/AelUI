local _, addon = ...

addon.auras.CreateGroupBase = function(id)
	local aura = {
		base = addon.auras.CreateBase(id),
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
			r.anchorFrameType = self.anchor.type
			r.anchorFrameFrame = self.anchor.frame
			r.anchorPoint = self.anchor.to
			r.selfPoint = self.anchor.from
			r.xOffset = self.anchor.x
			r.yOffset = self.anchor.y
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
