local addon = select(2, ...)

function addon.elements.Text(parent, options)
	local options = options or {}
	options.size = options.size or 20

	local style = options.style or 'normal'
	if options.pixel then
		style = 'pixel'
	end

	local font = addon.media.font
	if style == 'bold' then
		font = addon.media.fontBold
	end
	if style == 'pixel' then
		font = addon.media.fontPixel
	end

	local flags = style == 'pixel' and 'MONOCHROME,OUTLINE' or 'OUTLINE'

	local text = parent:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
	text:SetFont(font, options.size, flags)
	text:SetTextColor(1, 1, 1)

	return text
end
