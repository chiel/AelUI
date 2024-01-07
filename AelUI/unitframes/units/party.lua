local addon = select(2, ...)

local ufConfig = addon.core.config.unitframes

addon.units.party = {
	spawn = function(self)
		local party = self:SpawnHeader(
			nil,
			nil,
			'party',
			'showParty',
			true,
			'showPlayer',
			true,
			'yOffset',
			-(ufConfig.height * 1.5),
			'groupBy',
			'ASSIGNEDROLE',
			'groupingOrder',
			'TANK,HEALER,DAMAGER',
			'oUF-initialConfigFunction',
			([[
				self:SetWidth(%d)
				self:SetHeight(%d)
			]]):format(ufConfig.height * 7, ufConfig.height)
		)

		party:SetPoint('TOPRIGHT', addon.uiGroupAnchor, 'TOPLEFT')
	end,

	style = addon.unitframes.style,
}
