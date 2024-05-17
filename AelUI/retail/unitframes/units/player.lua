local ns = select(2, ...)

local anchors = ns.anchors
local ce = ns.unitframes.elements
local createStyler = ns.unitframes.createStyler

local playerStyler = createStyler({
	indicators = {
		combat = true,
		leader = true,
		raidmarker = true,
		resting = true,
	},
	texts = {
		health = true,
		healthpercent = true,
		level = true,
		name = true,
	},
})

local defaultConfig = {
	hidePowerText = false,
	powerbarHeight = 16,
}

local specConfigs = {
	-- monk
	[270] = { -- mistweaver
		hidePowerText = true,
	},
	[269] = { -- windwalker
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

table.insert(ns.unitframes.units, {
	name = 'player',
	spawn = function(self)
		local f = self:Spawn('player', 'AelUIPlayer')
		f:SetSize(40 * 7, 40)
		f:SetPoint('TOPRIGHT', anchors.primary, 'TOPLEFT', -20, 0)
	end,
	style = function(self, unit)
		playerStyler(self, unit)

		local power = ce.power(self, unit)
		power:SetPoint('BOTTOMLEFT', anchors.primary, 'TOPLEFT', 0, 2)
		power:SetPoint('BOTTOMRIGHT', anchors.primary, 'TOPRIGHT', 0, 2)
		power:SetFrameStrata('MEDIUM')
		AelUIPlayerPower = power

		local classpower = ce.classpower(self, unit)
		classpower:SetPoint('BOTTOMLEFT', power, 'TOPLEFT', 0, -1)
		classpower:SetPoint('BOTTOMRIGHT', power, 'TOPRIGHT', 0, -1)

		local powerText = ce.text(self.Power, { size = 18 })
		powerText:SetPoint('BOTTOM', 0, -1)
		self:Tag(powerText, '[AelUI:powercurrent]')

		local castbar = ce.castbar(self, unit)
		castbar:SetPoint('TOPLEFT', anchors.secondary, 'BOTTOMLEFT', 0, -2)
		castbar:SetPoint('TOPRIGHT', anchors.secondary, 'BOTTOMRIGHT', 0, -2)
		castbar:SetHeight(16)

		local function handleSpecChange()
			local specIndex = GetSpecialization()
			local specId = GetSpecializationInfo(specIndex)
			local specConfig = Mixin({}, defaultConfig, specConfigs[specId] or {})

			power:SetHeight(specConfig.powerbarHeight)
			classpower:SetHeight(defaultConfig.powerbarHeight - specConfig.powerbarHeight)

			if specConfig.hidePowerText then
				powerText:Hide()
			else
				powerText:Show()
			end
		end

		handleSpecChange()
		ns.addon:RegisterEvent('ACTIVE_PLAYER_SPECIALIZATION_CHANGED', handleSpecChange)
	end,
})
