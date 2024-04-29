local ns = select(2, ...)

local oUF = ns.oUF
local anchors = ns.core.anchors

local ce = ns.core.unitframes.elements
local createStyler = ns.classic.unitframes.createStyler

local units = {
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
			castbar:SetPoint('TOPLEFT', anchors.secondary, 'BOTTOMLEFT', 0, -8)
			castbar:SetPoint('TOPRIGHT', anchors.secondary, 'BOTTOMRIGHT', 0, -8)
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
}

for _, unit in ipairs(units) do
	oUF:RegisterStyle('AelUI:' .. unit.name, unit.style)
end

oUF:Factory(function(self)
	for _, unit in ipairs(units) do
		self:SetActiveStyle('AelUI:' .. unit.name)
		unit.spawn(self)
	end
end)
