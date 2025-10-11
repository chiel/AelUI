local _, ns = ...

local a = ns.anchors
local e = ns.unitframes.elements

local defaultConfig = {
	hidePowerText = false,
	powerbarHeight = 16,
}

local specConfigs = {
	-- death knight
	[250] = { -- blood
		powerbarHeight = 6,
	},
	[251] = { -- frost
		powerbarHeight = 6,
	},
	[252] = { -- unholy
		powerbarHeight = 6,
	},

	-- monk
	[268] = { -- brewmaster
		powerbarHeight = 6,
	},

	-- paladin
	[65] = { -- holy
		hidePowerText = true,
		powerbarHeight = 6,
	},
	[66] = { -- protection
		hidePowerText = true,
		powerbarHeight = 6,
	},
	[70] = { -- retribution
		hidePowerText = true,
		powerbarHeight = 6,
	},
}

local styler = ns.unitframes.createStyler({
	indicators = {
		leader = true,
	},
	texts = {
		health = true,
		healthpercent = true,
	},
})

table.insert(ns.unitframes.units, {
	name = 'player',

	spawn = function(self)
		local f = self:Spawn('player', 'AelUIPlayer')
		f:SetSize(300, 40)
		f:SetPoint('TOPRIGHT', a.primary, 'TOPLEFT', -20, 0)
	end,

	style = function(self, unit)
		styler(self, unit)

		local power = e.power(self, unit)
		power:SetPoint('BOTTOMLEFT', a.primary, 'TOPLEFT', 0, 2)
		power:SetPoint('BOTTOMRIGHT', a.primary, 'TOPRIGHT', 0, 2)
		power:SetHeight(16)

		local powerText = e.text(self.Power, { size = 18, style = 'bold' })
		powerText:SetPoint('BOTTOM', 0, -1)
		self:Tag(powerText, '[AelUI:powercurrent]')

		local classpower = e.classpower(self, unit)
		classpower:SetHeight(10)
		classpower:SetPoint('BOTTOMLEFT', power, 'TOPLEFT', 0, -1)

		a.primary:OnResize(function(width)
			classpower:UpdateWidth(width)
		end)

		local castbar = e.castbar(self, unit)
		castbar:SetPoint('TOPLEFT', a.secondary, 'BOTTOMLEFT', 0, -2)
		castbar:SetPoint('TOPRIGHT', a.secondary, 'BOTTOMRIGHT', 0, -2)
		castbar:SetHeight(16)

		local _, playerClass = UnitClass('player')
		if playerClass == 'DEATHKNIGHT' then
			local runes = e.runes(self, unit)
			runes:SetHeight(10)
			runes:SetPoint('BOTTOMLEFT', power, 'TOPLEFT', 0, -1)
			runes:SetFrameLevel(runes:GetFrameLevel() - 1)

			a.primary:OnResize(function(width)
				runes:UpdateWidth(width)
			end)
		end

		local function onSpecChange()
			local specIndex = GetSpecialization()
			local specId = GetSpecializationInfo(specIndex)
			local specConfig = Mixin({}, defaultConfig, specConfigs[specId] or {})

			power:SetHeight(specConfig.powerbarHeight)
			power.spark:SetHeight(specConfig.powerbarHeight * 2)
			classpower:SetHeight(defaultConfig.powerbarHeight - specConfig.powerbarHeight + 1)

			if specConfig.hidePowerText then
				powerText:Hide()
			else
				powerText:Show()
			end
		end

		onSpecChange()
		ns.addon:RegisterEvent('ACTIVE_PLAYER_SPECIALIZATION_CHANGED', onSpecChange)
	end,
})
