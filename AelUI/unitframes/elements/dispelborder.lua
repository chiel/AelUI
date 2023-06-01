local addon = select(2, ...)

local playerClass = select(2, UnitClass 'player')

local debuffPrioByClass = {
	['DRUID'] = { 'Curse', 'Poison' },
	['EVOKER'] = { 'Poison' },
	['MAGE'] = { 'Curse' },
	['MONK'] = { 'Poison', 'Disease' },
	['PALADIN'] = { 'Poison', 'Disease' },
	['PRIEST'] = { 'Magic', 'Disease' },
	['SHAMAN'] = { 'Curse', 'Poison' },
	['WARLOCK'] = { 'Magic' },
}

local debuffPrioBySpec = {
	[65] = { 'Magic', 'Disease' }, -- holy paladin
	[105] = { 'Magic', 'Curse', 'Poison' }, -- restoration druid
	[256] = { 'Magic', 'Disease' }, -- discipline priest
	[257] = { 'Magic', 'Disease' }, -- holy priest
	[264] = { 'Magic', 'Curse', 'Poison' }, -- restoration shaman
	[270] = { 'Magic', 'Poison', 'Disease' }, -- mistweaver monk
	[1468] = { 'Magic', 'Poison' }, -- preservation evoker
}

function addon.elements.DispelBorder(self, unit)
	local border = CreateFrame('Frame', nil, self, 'BackdropTemplate')
	border:SetBackdrop { edgeFile = addon.media.border, edgeSize = 2 }
	border:SetBackdropBorderColor(0, 0, 0, 1)
	border:SetPoint('TOPLEFT', -2, 2)
	border:SetPoint('BOTTOMRIGHT', 2, -2)
	border:SetBackdropBorderColor(0, 0, 0, 0)

	border:RegisterEvent 'UNIT_AURA'
	border:SetScript('OnEvent', function(_, event, unit)
		if event ~= 'UNIT_AURA' or not UnitIsUnit(self.unit, unit) then
			return
		end

		local specIndex = GetSpecialization()
		if not specIndex then
			return
		end

		local specID = GetSpecializationInfo(specIndex)

		local prio = debuffPrioBySpec[specID]
		if prio == nil then
			prio = debuffPrioByClass[playerClass]
		end

		if prio == nil then
			return
		end

		local hasDebuffTypes = {}

		AuraUtil.ForEachAura(unit, 'HARMFUL', nil, function(name, icon, count, dispelType, duration)
			if dispelType ~= nil then
				hasDebuffTypes[dispelType] = true
			end
		end)

		local hit = false
		for _, type in ipairs(prio) do
			if hasDebuffTypes[type] then
				local r, g, b = unpack(self.colors.debuff[type])
				border:SetBackdropBorderColor(r, g, b, 1)
				hit = true
				break
			end
		end

		if not hit then
			border:SetBackdropBorderColor(0, 0, 0, 0)
		end
	end)

	return border
end
