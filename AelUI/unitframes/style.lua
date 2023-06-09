local addon = select(2, ...)

local ufConfig = addon.config.unitframes
local round = addon.utils.Round

addon.unitframes.style = function(self, unit)
	self:RegisterForClicks 'AnyUp'
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)

	self.colors = addon.colors

	local unitConfig = addon.unitframes.config[unit] or {}
	local bars = unitConfig.bars or {}
	local indicators = unitConfig.indicators or {}
	local texts = unitConfig.texts or {}

	local health = addon.elements.Health(self, unit)
	health:SetAllPoints()

	if bars.power then
		local power = addon.elements.Power(self, unit, { healerOnly = bars.power == 'healer' })
		power:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', 0, -4)
		power:SetSize(100, 6)
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
		name:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', round(ufConfig.height * 0.1), -(ufConfig.height * 0.15))
		self:Tag(name, '[AelUI:name]')
		health.PostUpdateColor = function(r, g, b)
			name:SetTextColor(r, g, b)
		end
	end

	if texts.health or texts.healthpercent then
		local healthpercentPoint =
			{ 'BOTTOMRIGHT', self, 'BOTTOMRIGHT', -(ufConfig.height * 0.1), -(ufConfig.height * 0.1) }

		local healthpercent = nil
		local healthpercentSize = round(ufConfig.height * 0.5)

		if texts.healthpercent then
			healthpercent = addon.elements.Text(self.Health, { size = healthpercentSize })
			self:Tag(healthpercent, '[AelUI:healthpercent]')
			healthpercent:SetPoint(unpack(healthpercentPoint))
		end

		if texts.health then
			local healthSize = healthpercent == nil and healthpercentSize or round(ufConfig.height * 0.35)
			local currenthealth = addon.elements.Text(self.Health, { size = healthSize })
			self:Tag(currenthealth, '[AelUI:currenthealth]')

			local point = { 'BOTTOMRIGHT', healthpercent, 'TOPRIGHT', 0, 0 }

			if healthpercent == nil then
				point = healthpercentPoint
			end

			currenthealth:SetPoint(unpack(point))
		end
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

	if unitConfig.range then
		self.Range = {
			insideAlpha = 1,
			outsideAlpha = 0.5,
		}
	end
end
