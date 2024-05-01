local ns = select(2, ...)

local m = ns.media

ns.unitframes.elements.text = function(self, options)
	local o = options or {}
	o.size = options.size or 20
	o.style = options.style or 'normal'

	local font = m.fonts.default.file
	local flags = 'OUTLINE'
	if o.style == 'bold' then
		font = m.fonts.bold.file
	end
	if o.style == 'pixel' then
		font = m.fonts.pixel.file
		flags = 'MONOCHROME,OUTLINE'
	end

	local text = self:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
	text:SetFont(font, o.size, flags)
	text:SetTextColor(1, 1, 1)

	return text
end
