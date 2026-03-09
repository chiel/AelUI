local _, ns = ...

local m = ns.media

ns.unitframes.elements.selection = function(f)
	local border = CreateFrame('Frame', nil, f, 'BackdropTemplate')
	border:SetPoint('TOPLEFT', -1, 1)
	border:SetPoint('BOTTOMRIGHT', 1, -1)
	border:SetBackdrop({ edgeFile = m.borders.default.file, edgeSize = 1 })
	border:SetBackdropBorderColor(1, 1, 1, 0.75)
	border:SetFrameLevel(f:GetFrameLevel() + 10)
	border:Hide()

	local function update(self)
		if f.unit then
			border:SetShown(UnitIsUnit(f.unit, 'target'))
		else
			border:Hide()
		end
	end

	f:RegisterCallback('PLAYER_TARGET_CHANGED', update)

	f.updaters[update] = true

	return border
end
