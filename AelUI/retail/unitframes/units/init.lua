local ns = select(2, ...)

local anchors = ns.anchors

local ce = ns.unitframes.elements
local createStyler = ns.unitframes.createStyler

ns.unitframes.units = {
	{
		name = 'player',
		spawn = function(self)
			local f = self:Spawn('player', 'AelUIPlayer')
			f:SetSize(40 * 7, 40)
			f:SetPoint('TOPRIGHT', anchors.primary, 'TOPLEFT', -20, 0)
		end,
		style = function(self, unit)
			local styler = createStyler({
				indicators = {
					combat = true,
					leader = true,
					masterlooter = true,
					pvp = true,
					resting = true,
				},
				texts = {
					health = true,
					healthpercent = true,
					level = true,
					name = true,
				},
			})

			styler(self, unit)

			local castbar = ce.castbar(self, unit)
			castbar:SetPoint('TOPLEFT', anchors.secondary, 'BOTTOMLEFT', 0, -2)
			castbar:SetPoint('TOPRIGHT', anchors.secondary, 'BOTTOMRIGHT', 0, -2)
			castbar:SetHeight(16)
		end,
	},
	{
		name = 'pet',
		spawn = function(self)
			local f = self:Spawn('pet', 'AelUIPet')
			f:SetSize(40 * 3.5, 32)
			f:SetPoint('TOPLEFT', AelUIPlayer, 'BOTTOMLEFT', 0, -16)
		end,
		style = createStyler({
			indicators = {
				combat = true,
				leader = true,
			},
			texts = {
				health = true,
				healthpercent = true,
				level = true,
				name = true,
			},
		}),
	},
	{
		name = 'target',
		spawn = function(self)
			local f = self:Spawn('target', 'AelUITarget')
			f:SetSize(40 * 7, 40)
			f:SetPoint('TOPLEFT', anchors.primary, 'TOPRIGHT', 20, 0)
		end,
		style = createStyler({
			mirror = true,
			indicators = {
				leader = true,
				masterlooter = true,
				pvp = true,
				resting = true,
			},
			texts = {
				health = true,
				healthpercent = true,
				level = true,
				name = true,
			},
		}),
	},
	{
		name = 'targettarget',
		spawn = function(self)
			local f = self:Spawn('targettarget', 'AelUITargetTarget')
			f:SetSize(40 * 3.5, 32)
			f:SetPoint('TOPRIGHT', AelUITarget, 'BOTTOMRIGHT', 0, -16)
		end,
		style = createStyler({
			mirror = true,
			indicators = {
				combat = true,
				leader = true,
			},
			texts = {
				health = true,
				healthpercent = true,
				level = true,
				name = true,
			},
		}),
	},
	{
		name = 'focus',
		spawn = function(self)
			local f = self:Spawn('focus', 'AelUIFocus')
			f:SetSize(40 * 5, 40)
			f:SetPoint('BOTTOMRIGHT', anchors.primary, 'TOPLEFT', -60, 140)
		end,
		style = createStyler({
			indicators = {},
			texts = {
				health = true,
				healthpercent = true,
				name = true,
			},
		}),
	},
	{
		name = 'boss',
		spawn = function(self)
			local boss = {}
			for i = 1, MAX_BOSS_FRAMES or 5 do
				local f = self:Spawn('boss' .. i)
				f:SetSize(40 * 7, 40)

				if i == 1 then
					f:SetPoint('TOPLEFT', anchors.primary, 'TOPRIGHT', (40 * 8) + 20 + 4, 40 * (5 + 2 + (1.5 * 4)))
				else
					f:SetPoint('TOPLEFT', boss[i - 1], 'BOTTOMLEFT', 0, -(40 * 1.5))
				end

				boss[i] = f
			end
		end,
		style = createStyler({
			mirror = true,
			texts = {
				health = true,
				healthpercent = true,
				name = true,
			},
		}),
	},
	{
		name = 'party',
		spawn = function(self)
			local party = self:SpawnHeader(
				nil,
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
	},
}
