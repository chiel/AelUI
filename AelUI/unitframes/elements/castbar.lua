local addon = select(2, ...)

local function CreatePip(element)
	local frame = CreateFrame('Frame', nil, element, 'BackdropTemplate')
	frame:SetBackdrop { edgeFile = addon.media.border, edgeSize = 1 }
	frame:SetWidth(2)
	frame:SetBackdropBorderColor(1, 1, 1)
	return frame
end

function addon.elements.Castbar(self, unit)
	local castbar = CreateFrame('StatusBar', nil, self)
	castbar:SetStatusBarTexture(addon.media.texture)
	castbar:SetStatusBarColor(32 / 255, 32 / 255, 32 / 255)

	local backdrop = addon.elements.Backdrop(castbar)
	backdrop:SetFrameLevel(castbar:GetFrameLevel() - 1)
	castbar:SetPoint('TOPLEFT', backdrop, 'TOPLEFT', 1, -1)
	castbar:SetPoint('BOTTOMRIGHT', backdrop, 'BOTTOMRIGHT', -1, 1)

	local Spark = castbar:CreateTexture(nil, 'OVERLAY')
	Spark:SetSize(10, 10)
	Spark:SetBlendMode 'ADD'
	Spark:SetPoint('CENTER', castbar:GetStatusBarTexture(), 'RIGHT', 0, 0)

	local options = { pixel = true, size = 8 }

	local Text = addon.elements.Text(castbar, options)
	Text:SetPoint('TOPLEFT', backdrop, 'BOTTOMLEFT', 4, -6)

	local Time = addon.elements.Text(castbar, options)
	Time:SetPoint('TOPRIGHT', backdrop, 'BOTTOMRIGHT', -4, -6)
	Time:SetJustifyH 'RIGHT'

	backdrop.Spark = Spark
	backdrop.Text = Text
	backdrop.Time = Time

	castbar.CreatePip = CreatePip
	castbar.Spark = Spark
	castbar.Text = Text
	castbar.Time = Time

	self.Castbar = castbar
	self.CastbarBackdrop = backdrop

	return backdrop
end
