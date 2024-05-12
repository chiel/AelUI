local ns = select(2, ...)

local m = ns.media
local ce = ns.unitframes.elements

-- local function CreatePip(element)
-- 	local frame = CreateFrame('Frame', nil, element, 'BackdropTemplate')
-- 	frame:SetBackdrop({ edgeFile = m.borders.default.file, edgeSize = 1 })
-- 	frame:SetWidth(2)
-- 	frame:SetBackdropBorderColor(1, 1, 1)
-- 	return frame
-- end

ns.unitframes.elements.castbar = function(self, unit)
	if unit == 'player' then
		if CastingBarFrame then
			CastingBarFrame:UnregisterAllEvents()
		end

		PlayerCastingBarFrame:UnregisterAllEvents()
	end

	local castbar = CreateFrame('StatusBar', nil, self)
	local backdrop = ce.backdrop(castbar)
	backdrop:SetFrameLevel(castbar:GetFrameLevel() - 1)

	castbar:SetStatusBarTexture(m.statusbars.default.file)
	castbar:SetStatusBarColor(32 / 255, 32 / 255, 32 / 255)
	castbar:SetPoint('TOPLEFT', backdrop, 1, -1)
	castbar:SetPoint('BOTTOMRIGHT', backdrop, -1, 1)

	local Spark = castbar:CreateTexture(nil, 'OVERLAY')
	Spark:SetSize(10, 30)
	Spark:SetBlendMode('ADD')
	Spark:SetPoint('CENTER', castbar:GetStatusBarTexture(), 'RIGHT', 0, 0)

	-- local options = { pixel = true, size = 8 }

	-- local Text = ns.elements.Text(castbar, options)
	-- Text:SetPoint('TOPLEFT', backdrop, 'BOTTOMLEFT', 4, -6)

	-- local Time = ns.elements.Text(castbar, options)
	-- Time:SetPoint('TOPRIGHT', backdrop, 'BOTTOMRIGHT', -4, -6)
	-- Time:SetJustifyH('RIGHT')

	-- backdrop.Spark = Spark
	-- backdrop.Text = Text
	-- backdrop.Time = Time

	-- -- castbar.CreatePip = CreatePip
	castbar.Spark = Spark
	-- castbar.Text = Text
	-- castbar.Time = Time

	self.Castbar = castbar

	return backdrop
end
