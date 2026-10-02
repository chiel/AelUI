local _, ns = ...

local m = ns.media

ns.unitframes.elements.text = function(parent, options)
	local o = options or {}
	o.font = o.font or m.fonts.default.file
	o.fontSize = o.fontSize or 14
	o.justifyH = o.justifyH or 'RIGHT'

	local text = parent:CreateFontString(nil, 'OVERLAY')
	text:SetFont(o.font, o.fontSize, 'OUTLINE')
	text:SetJustifyH(o.justifyH)

	return text
end
