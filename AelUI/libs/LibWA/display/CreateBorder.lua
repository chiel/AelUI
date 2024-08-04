local _, addon = ...

addon.display.CreateBorder = function(options)
	local o = options or {}

	local aura = {
		table = {
			type = 'subborder',
			border_color = o.color or { 1, 1, 1, 1 },
			border_edge = o.edge or 'Square Full White',
			border_offset = o.offset ~= nil and o.offset or 1,
			border_size = o.size ~= nil and o.size or 2,
			border_visible = o.options ~= nil and o.options or true,
		},
	}

	aura.Serialize = function(self)
		return self.table
	end

	return aura
end
