local ns = select(2, ...)

local anchors = ns.core.anchors
local ce = ns.core.unitframes.elements

local function positionGroups(groups)
	for i = 1, NUM_RAID_GROUPS do
		groups[i]:ClearAllPoints()

		if i == 1 then
			groups[i]:SetPoint('TOPLEFT', anchors.group)
		else
			groups[i]:SetPoint('TOPLEFT', groups[i - 1], 'BOTTOMLEFT', 0, -4)
		end
	end
end

table.insert(ns.retail.unitframes.units, {
	name = 'raid',
	spawn = function(self)
		local groups = {}
		for i = 1, NUM_RAID_GROUPS do
			groups[i] = self:SpawnHeader(
				nil,
				nil,
				'raid',
				'showPlayer',
				true,
				'showRaid',
				true,
				'point',
				'LEFT',
				'xOffset',
				4,
				'groupFilter',
				i,
				'groupBy',
				'ASSIGNEDROLE',
				'groupingOrder',
				'TANK,HEALER,DAMAGER',
				'oUF-initialConfigFunction',
				([[
						self:SetWidth(%d)
						self:SetHeight(%d)
					]]):format(100, 54)
			)
		end

		positionGroups(groups)
	end,
	style = function(self, unit)
		self:RegisterForClicks('AnyUp')
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = ns.core.colors

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
