local addon = select(2, ...)

local u = addon.core.utils

local healerSize = { 88, 66, 4 }
local normalSize = { 68, 56, 4 }
local updatePending = false

local function Position(raid)
	local function doUpdate()
		local isHealer = u.getSpecRole() == 'HEALER'
		for i = 1, NUM_RAID_GROUPS do
			raid[i]:ClearAllPoints()

			if isHealer then
				if i == 1 then
					raid[i]:SetPoint(
						'TOPRIGHT',
						AelUIPlayer,
						'TOPLEFT',
						-4,
						48 + ((5 * healerSize[2]) + (4 * healerSize[3]))
					)
				else
					raid[i]:SetPoint('TOPRIGHT', raid[i - 1], 'TOPLEFT', -healerSize[3], 0)
				end
			else
				if i == 1 then
					raid[i]:SetPoint(
						'TOPLEFT',
						UIParent,
						'BOTTOMLEFT',
						24,
						480 + ((5 * normalSize[2]) + (4 * normalSize[3]))
					)
				else
					raid[i]:SetPoint('TOPLEFT', raid[i - 1], 'TOPRIGHT', normalSize[3], 0)
				end
			end
		end
	end

	local inCombat = UnitAffectingCombat('player')
	if not inCombat then
		doUpdate()
		return
	end

	if not updatePending then
		updatePending = true
		local f = CreateFrame('Frame')
		f:SetScript('OnEvent', function()
			doUpdate()
		end)
		f:RegisterEvent('PLAYER_REGEN_ENABLED')
	end
end

addon.units.raid = {
	spawn = function(self)
		local isHealer = u.getSpecRole() == 'HEALER'
		local width = isHealer and healerSize[1] or normalSize[1]
		local height = isHealer and healerSize[2] or normalSize[2]

		local raid = {}
		for i = 1, NUM_RAID_GROUPS do
			raid[i] = self:SpawnHeader(
				nil,
				nil,
				'raid',
				'showPlayer',
				true,
				'showRaid',
				true,
				'maxColumns',
				1,
				'unitsPerColumn',
				5,
				'yOffset',
				-healerSize[3],
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
				]]):format(width, height)
			)
		end

		Position(raid)

		local f = CreateFrame('Frame')
		f:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED')
		f:SetScript('OnEvent', function(_, event)
			if event == 'PLAYER_SPECIALIZATION_CHANGED' then
				Position(raid)
			end
		end)
	end,

	style = function(self, unit)
		self:RegisterForClicks('AnyUp')
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = addon.colors

		local health = addon.elements.Health(self, unit)
		health:SetAllPoints()

		local text = addon.elements.Text(self.Health, { size = 16 })
		self:Tag(text, '[AelUI:raidtext]')
		text:SetPoint('BOTTOM', self, 'BOTTOM', 0, 6)
		health.PostUpdateColor = function(r, g, b)
			text:SetTextColor(r, g, b)
		end

		local groupRole = addon.elements.GroupRole(self, unit)
		groupRole:SetParent(self.Health)
		groupRole:SetPoint('TOPLEFT', 4, -4)

		local summon = addon.elements.Summon(self, unit)
		summon:SetParent(self.Health)
		summon:SetPoint('TOP', self.Health, 'TOP', 0, -6)
		summon:SetSize(24, 24)

		local readyCheck = addon.elements.ReadyCheck(self, unit)
		readyCheck:SetParent(self.Health)
		readyCheck:SetPoint('TOP', self.Health, 'TOP', 0, -6)
		readyCheck:SetSize(16, 16)

		local resurrect = addon.elements.Resurrect(self, unit)
		resurrect:SetParent(self.Health)
		resurrect:SetPoint('TOP', self.Health, 'TOP', 0, -6)
		resurrect:SetSize(16, 16)

		self.Range = {
			insideAlpha = 1,
			outsideAlpha = 0.5,
		}
	end,
}
