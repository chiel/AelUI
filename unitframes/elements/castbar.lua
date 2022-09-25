local addon = select(2, ...)

function addon.elements.Castbar(self, unit)
	local castbar = CreateFrame('StatusBar', nil, self)
	castbar:SetStatusBarTexture(addon.media.texture)
	castbar:SetStatusBarColor(22 / 255, 142 / 255, 198 / 255)

	local backdrop = addon.elements.Backdrop(castbar)
	backdrop:SetFrameLevel(castbar:GetFrameLevel() - 1)
	castbar:SetPoint('TOPLEFT', backdrop, 'TOPLEFT', 1, -1)
	castbar:SetPoint('BOTTOMRIGHT', backdrop, 'BOTTOMRIGHT', -1, 1)

	local Icon = castbar:CreateTexture(nil, 'OVERLAY')
	Icon:SetPoint('BOTTOMRIGHT', backdrop, 'BOTTOMLEFT', -4, 0)
	Icon:SetSize(32, 32)

	local options = { pixel = true, size = 8 }

	local Text = addon.elements.Text(castbar, options)
	Text:SetPoint('TOPLEFT', backdrop, 'BOTTOMLEFT', 4, -6)

	local Time = addon.elements.Text(castbar, options)
	Time:SetPoint('TOPRIGHT', backdrop, 'BOTTOMRIGHT', -4, -6)
	Time:SetJustifyH 'RIGHT'

	backdrop.Icon = Icon
	backdrop.Text = Text
	backdrop.Time = Time

	castbar.Icon = Icon
	castbar.Text = Text
	castbar.Time = Time

	self.Castbar = castbar

	return backdrop
end
