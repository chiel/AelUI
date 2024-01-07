local addon = select(2, ...)

local ufConfig = addon.core.config.unitframes
local round = addon.core.utils.round

local getPoints = function(style)
	if style == 'mirror' then
		return {
			buffs = function(frame)
				return { 'BOTTOMLEFT', frame, 'TOPLEFT', 0, 2 }
			end,
			healthtext = function(frame)
				return { 'BOTTOMLEFT', frame, 'BOTTOMLEFT', ufConfig.height * 0.1, -(ufConfig.height * 0.1) }
			end,
			name = function(frame)
				return { 'BOTTOMRIGHT', frame, 'TOPRIGHT', -round(ufConfig.height * 0.1), -(ufConfig.height * 0.15) }
			end,
			power = function(frame)
				return { 'TOPLEFT', frame, 'BOTTOMLEFT', 0, -4 }
			end,
			powertext = function(frame)
				return { 'LEFT', frame, 'RIGHT', 4, 0 }
			end,
		}
	end

	return {
		buffs = function(frame)
			return { 'BOTTOMRIGHT', frame, 'TOPRIGHT', 0, 2 }
		end,
		healthtext = function(frame)
			return { 'BOTTOMRIGHT', frame, 'BOTTOMRIGHT', -(ufConfig.height * 0.1), -(ufConfig.height * 0.1) }
		end,
		name = function(frame)
			return { 'BOTTOMLEFT', frame, 'TOPLEFT', round(ufConfig.height * 0.1), -(ufConfig.height * 0.15) }
		end,
		power = function(frame)
			return { 'TOPRIGHT', frame, 'BOTTOMRIGHT', 0, -4 }
		end,
		powertext = function(frame)
			return { 'RIGHT', frame, 'LEFT', -4, 0 }
		end,
	}
end

addon.unitframes.style = function(self, unit)
	self:RegisterForClicks('AnyUp')
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)

	self.colors = addon.core.colors

	local unitConfig = addon.unitframes.config[unit] or {}
	local style = unitConfig.style
	local bars = unitConfig.bars or {}
	local indicators = unitConfig.indicators or {}
	local texts = unitConfig.texts or {}

	local health = addon.elements.Health(self, unit)
	health:SetAllPoints()

	local points = getPoints(style)

	if bars.power then
		local power = addon.elements.Power(self, unit, { healerOnly = bars.power == 'healer' })
		power:SetPoint(unpack(points.power(self)))
		power:SetSize(100, 6)

		if texts.power then
			local currentpower = addon.elements.Text(power, { size = round(ufConfig.height * 0.35) })
			currentpower:SetPoint(unpack(points.powertext(power)))
			self:Tag(currentpower, '[AelUI:currentpower]')
		end
	end

	if bars.cast then
		local castbar = addon.elements.Castbar(self, unit)
		castbar:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', 0, -4)
		castbar:SetPoint('TOPRIGHT', self, 'BOTTOMRIGHT', 0, 4)
		castbar:SetHeight(6)
	end

	local name

	if texts.name then
		name = addon.elements.Text(self.Health, { size = round(ufConfig.height * 0.5) })
		name:SetPoint(unpack(points.name(self)))
		if style == 'mirror' then
			name:SetJustifyH('RIGHT')
		end
		self:Tag(name, '[AelUI:name]')
		health.PostUpdateColor = function(r, g, b)
			name:SetTextColor(r, g, b)
		end
	end

	if texts.health or texts.healthpercent then
		local healthpercent = nil
		local healthpercentSize = round(ufConfig.height * 0.5)

		if texts.healthpercent then
			healthpercent = addon.elements.Text(self.Health, { size = healthpercentSize })
			self:Tag(healthpercent, '[AelUI:healthpercent]')
			healthpercent:SetPoint(unpack(points.healthtext(self)))
		end

		if texts.health then
			local healthSize = healthpercent == nil and healthpercentSize or round(ufConfig.height * 0.35)
			local currenthealth = addon.elements.Text(self.Health, { size = healthSize })
			self:Tag(currenthealth, '[AelUI:currenthealth]')

			local point = { 'BOTTOMRIGHT', healthpercent, 'TOPRIGHT', 0, 0 }
			if style == 'mirror' then
				point = { 'BOTTOMLEFT', healthpercent, 'TOPLEFT', 0, 0 }
			end

			if healthpercent == nil then
				point = points.healthtext(self)
			end

			currenthealth:SetPoint(unpack(point))
		end
	end

	if indicators.dispel then
		addon.elements.DispelBorder(self, unit)
	end

	if indicators.leader then
		local leader = addon.elements.Leader(self, unit)
		leader:SetParent(self.Health)
		if name ~= nil then
			leader:SetPoint('LEFT', name, 'RIGHT', 4, -1)
		else
			leader:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', round(ufConfig.height * 0.1), -(ufConfig.height * 0.15))
		end
	end

	if indicators.raidmarker then
		local raidMarker = addon.elements.RaidMarker(self, unit)
		raidMarker:SetParent(self.Health)
		raidMarker:SetPoint('CENTER', self.Health)
	end

	if indicators.readycheck then
		local readyCheck = addon.elements.ReadyCheck(self, unit)
		readyCheck:SetParent(self.Health)
		readyCheck:SetPoint('CENTER', self.Health, 'CENTER')
	end

	if indicators.resurrect then
		local resurrect = addon.elements.Resurrect(self, unit)
		resurrect:SetParent(self.Health)
		resurrect:SetPoint('CENTER', self.Health, 'CENTER')
	end

	if indicators.role then
		local groupRole = addon.elements.GroupRole(self, unit)
		groupRole:SetParent(self.Health)
		groupRole:SetPoint('RIGHT', self.Health, 'TOPRIGHT', -4, 0)
	end

	if indicators.summon then
		local summon = addon.elements.Summon(self, unit)
		summon:SetParent(self.Health)
		summon:SetPoint('CENTER', self.Health, 'CENTER')
	end

	if unitConfig.buffs then
		local buffSize = 24
		local buffSpacing = 2
		local buffColumns = 6
		local buffRows = 2
		local buffGrowthX = style == 'mirror' and 'RIGHT' or 'LEFT'
		local buffInitialAnchor = style == 'mirror' and 'BOTTOMLEFT' or 'BOTTOMRIGHT'

		local buffs = CreateFrame('Frame', nil, self)
		buffs['growth-x'] = buffGrowthX
		buffs.initialAnchor = buffInitialAnchor
		buffs.size = buffSize
		buffs.spacing = buffSpacing
		buffs:SetPoint(unpack(points.buffs(self)))
		buffs:SetSize((buffSize + buffSpacing) * buffColumns, (buffSize + buffSpacing) * buffRows)
		self.Buffs = buffs
	end

	if unitConfig.range then
		self.Range = {
			insideAlpha = 1,
			outsideAlpha = 0.5,
		}
	end
end
