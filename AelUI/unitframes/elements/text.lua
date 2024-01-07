local addon = select(2, ...)

local m = addon.core.media

function addon.elements.Text(parent, options)
	local options = options or {}
	options.size = options.size or 20

	local style = options.style or 'normal'
	if options.pixel then
		style = 'pixel'
	end

	local font = m.fonts.default.file
	if style == 'bold' then
		font = m.fonts.bold.file
	end
	if style == 'pixel' then
		font = m.fonts.pixel.file
	end

	local flags = style == 'pixel' and 'MONOCHROME,OUTLINE' or 'OUTLINE'

	local text = parent:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
	text:SetFont(font, options.size, flags)
	text:SetTextColor(1, 1, 1)

	return text
end
