local _, ns = ...

local m = ns.media

ns.unitframes.elements.restingText = function(f, parent, options)
	local o = options or {}

	local text = (parent or f):CreateFontString(nil, 'OVERLAY')
	text:SetFont(m.fonts.bold.file, o.fontSize or 12, 'OUTLINE')
	text:SetJustifyH(o.justifyH or 'LEFT')
	text:SetTextColor(1.0, 0.82, 0)

	local function update(self)
		text:SetText(IsResting() and 'ZZZ' or '')
	end

	f:RegisterCallback('PLAYER_UPDATE_RESTING', update)

	update(f)

	return text
end
