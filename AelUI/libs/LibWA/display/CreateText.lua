local addon = select(2, ...)

addon.display.CreateText = function(text, options)
	local o = options or {}

	local aura = {
		table = {
			type = 'subtext',
			text_text = text,

			text_font = o.font,
			text_fontSize = o.size,
			text_justify = o.justify,
		},
	}

	if o.anchor ~= nil then
		aura.table.text_selfPoint = o.anchor.from
		aura.table.text_anchorPoint = o.anchor.to
		aura.table.text_anchorXOffset = o.anchor.x
		aura.table.text_anchorYOffset = o.anchor.y
	end

	if o.format ~= nil then
		aura.table.text_text_format_p_format = o.format.format or 'timed'
		aura.table.text_text_format_p_time_dynamic_threshold = o.format.dynamic_threshold or 60
	end

	aura.SetText = function(self, value)
		self.table.text_text = value
	end

	aura.Serialize = function(self)
		return self.table
	end

	return aura
end
