local ns = select(2, ...)

local anchors = ns.anchors
local createStyler = ns.unitframes.createStyler

table.insert(ns.unitframes.units, {
	name = 'boss',
	spawn = function(self)
		local boss = {}
		for i = 1, MAX_BOSS_FRAMES or 5 do
			-- local f = self:Spawn('player')
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
		indicators = {
			raidmarker = true,
		},
		texts = {
			health = true,
			healthpercent = true,
			name = true,
		},
	}),
})
