local _, ns = ...

ns.display.CreateBorder = function(options)
	local o = options or {}

	local aura = {
		color = o.color,
		edge = o.edge,
		offset = o.offset,
		size = o.size,
		visible = o.visible,
	}

	aura.Serialize = function(self)
		return {
			type = 'subborder',
			border_color = self.color or { 1, 1, 1, 1 },
			border_edge = self.edge or 'Square Full White',
			border_offset = self.offset ~= nil and o.offset or 1,
			border_size = self.size ~= nil and o.size or 2,
			border_visible = self.visible ~= nil and o.visible or true,
		}
	end

	return aura
end
