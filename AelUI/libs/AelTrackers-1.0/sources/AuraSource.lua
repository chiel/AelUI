local _, ns = ...
local lib = LibStub('AelTrackers-1.0')

local AuraSource = {}
AuraSource.__index = AuraSource
setmetatable(AuraSource, { __index = lib.sources.BaseSource })

lib.sources.createAura = function(unit, auraType, spellIds, options)
	options = options or {}

	if type(spellIds) ~= 'table' then
		spellIds = { spellIds }
	end

	local source = setmetatable({
		auraType = auraType,
		elements = options.elements or {},
		ownOnly = options.ownOnly,
		spellIds = spellIds,
		unit = unit,
	}, AuraSource)

	source:Init()

	return source
end

function AuraSource:Build(tracker)
	local flags = self.auraType == 'buff' and 'HELPFUL' or 'HARMFUL'
	if self.ownOnly then
		flags = flags .. '|PLAYER'
	end

	local spellIdMap = {}
	for _, spellId in ipairs(self.spellIds) do
		spellIdMap[spellId] = true
	end

	local slotKey = 'spell-' .. self.spellIds[1]
	lib.auraContainers:Get(self.unit):AddAuraSlot(slotKey, flags, {
		candidateFilters = { includeSpellIDs = spellIdMap },
		initializeFrame = function(btn)
			btn:ClearAllPoints()
			btn:SetAllPoints(tracker)
			btn:SetFrameLevel(tracker:GetFrameLevel())

			for _, element in ipairs(self.elements) do
				element:Bind(btn)
			end
		end,
	})
end
