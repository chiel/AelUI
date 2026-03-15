local _, ns = ...

local m = ns.media

local faces = { ':(', ':|', ':)' }
local colors = {
	FACTION_BAR_COLORS[1],
	FACTION_BAR_COLORS[4],
	FACTION_BAR_COLORS[6],
}

ns.unitframes.elements.happiness = function(f, parent, options)
	local o = options or {}

	local text = (parent or f):CreateFontString(nil, 'OVERLAY')
	text:SetFont(m.fonts.bold.file, o.fontSize or 14, 'OUTLINE')

	local function update()
		local level = GetPetHappiness()
		if level then
			text:SetText(faces[level])
			local c = colors[level]
			text:SetTextColor(c.r, c.g, c.b)
		else
			text:SetText('')
		end
	end

	f:RegisterCallback('UNIT_HAPPINESS', update)

	update()

	return text
end
