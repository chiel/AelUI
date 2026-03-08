local _, ns = ...

local m = ns.media

local listeners = {}

local eventFrame = CreateFrame('Frame')
eventFrame:RegisterEvent('PLAYER_TARGET_CHANGED')
eventFrame:SetScript('OnEvent', function()
	for _, fn in ipairs(listeners) do
		fn()
	end
end)

ns.unitframes.elements.selection = function(f)
	local border = CreateFrame('Frame', nil, f, 'BackdropTemplate')
	border:SetPoint('TOPLEFT', -1, 1)
	border:SetPoint('BOTTOMRIGHT', 1, -1)
	border:SetBackdrop({ edgeFile = m.borders.default.file, edgeSize = 1 })
	border:SetBackdropBorderColor(1, 1, 1, 0.75)
	border:SetFrameLevel(f:GetFrameLevel() + 10)
	border:Hide()

	local function update()
		if f.unit then
			border:SetShown(UnitIsUnit(f.unit, 'target'))
		else
			border:Hide()
		end
	end

	table.insert(listeners, update)
	f.updaters[update] = true

	return border
end
