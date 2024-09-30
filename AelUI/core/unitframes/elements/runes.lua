local _, ns = ...

local e = ns.unitframes.elements
local m = ns.media
local u = ns.utils

ns.unitframes.elements.runes = function(self, unit)
	local container = CreateFrame('Frame', nil, self)
	local backdrops = {}
	local runes = {}

	for i = 1, 6 do
		local backdrop = e.backdrop(container)
		backdrop:SetPoint('TOP')
		if i == 1 then
			backdrop:SetPoint('BOTTOMLEFT', 0)
		else
			backdrop:SetPoint('BOTTOMLEFT', backdrops[i - 1], 'BOTTOMRIGHT', -1, 0)
		end
		backdrops[i] = backdrop

		local rune = CreateFrame('StatusBar', nil, backdrop)
		rune:SetStatusBarTexture(m.statusbars.default.file)
		rune:SetPoint('TOPLEFT', 1, -1)
		rune:SetPoint('BOTTOMRIGHT', -1, 1)
		runes[i] = rune
	end

	container.UpdateWidth = function(self, width)
		container:SetWidth(width)
		local remainingWidth = width + 5
		for i = 1, 6 do
			local runeWidth = u.round(remainingWidth / (7 - i))
			backdrops[i]:SetWidth(runeWidth)
			remainingWidth = remainingWidth - runeWidth
		end
	end

	runes.colorSpec = true
	runes.sortOrder = 'asc'
	self.Runes = runes
	return container
end
