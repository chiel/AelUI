local ns = select(2, ...)

local anchors = ns.anchors
local ce = ns.unitframes.elements

table.insert(ns.unitframes.units, {
	name = 'party',
	spawn = function(self, unit)
		local party = self:SpawnHeader(
			'AelUI_Party',
			nil,
			'party',
			'showPlayer',
			true,
			'showParty',
			true,
			'point',
			'LEFT',
			'xOffset',
			4,
			'groupBy',
			'ASSIGNEDROLE',
			'groupingOrder',
			'TANK,HEALER,DAMAGER',
			'oUF-initialConfigFunction',
			([[
					self:SetWidth(%d)
					self:SetHeight(%d)
				]]):format(100, 70)
		)
		party:SetPoint('TOPLEFT', anchors.group)
	end,
	style = function(self, unit)
		self:RegisterForClicks('AnyUp')
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = ns.colors

		local health = ce.health(self, unit)
		health:SetAllPoints()

		local nameText = ce.text(self.Health, { size = 16 })
		self:Tag(nameText, '[AelUI:raidtext]')
		nameText:SetPoint('BOTTOM', 0, 4)
		health.PostUpdateColor = function(r, g, b)
			nameText:SetTextColor(r, g, b)
		end

		local leader = ce.leader(self, unit)
		leader:SetParent(self.Health)
		leader:SetPoint('LEFT', self, 'TOPLEFT', 4, 0)

		local groupRole = ce.groupRole(self, unit)
		groupRole:SetParent(self.Health)
		groupRole:SetPoint('RIGHT', self, 'TOPRIGHT', -4, -1)

		local raidMarker = ce.raidMarker(self, unit)
		raidMarker:SetParent(self.Health)
		raidMarker:SetPoint('TOP', 0, -12)

		local readyCheck = ce.readyCheck(self, unit)
		readyCheck:SetParent(self.Health)
		readyCheck:SetPoint('TOP', 0, -12)

		local summon = ce.summon(self, unit)
		summon:SetParent(self.Health)
		summon:SetPoint('TOP', 0, -12)

		local resurrect = ce.resurrect(self, unit)
		resurrect:SetParent(self.Health)
		resurrect:SetSize(32, 32)
		resurrect:SetPoint('TOP', 0, -12)

		self.Range = {
			insideAlpha = 1,
			outsideAlpha = 0.5,
		}
	end,
})
