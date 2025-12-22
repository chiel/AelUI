local _, ns = ...

ns.display.CreateText = function(text, options)
	local o = options or {}

	local aura = {
		text = text,
		font = o.font,
		size = o.size,
		justify = o.justify,
		anchor = o.anchor,
		format = o.format,
	}

	aura.SetText = function(self, value)
		self.table.text_text = value
	end

	aura.Serialize = function(self)
		local r = {
			type = 'subtext',
			text_text = self.text,

			text_font = self.font,
			text_fontSize = self.size,
			text_justify = self.justify,
		}

		local anchor = self.anchor
		if anchor ~= nil then
			r.anchor_point = anchor.to
			r.text_selfPoint = anchor.from
			r.text_anchorXOffset = anchor.x
			r.text_anchorYOffset = anchor.y
		end

		local format = self.format
		if format ~= nil then
			r.text_text_format_p_format = format.format or 'timed'
			r.text_text_format_p_time_dynamic_threshold = format.dynamic_threshold or 60
		end

		return r
	end

	return aura
end
