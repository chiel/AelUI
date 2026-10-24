local _, ns = ...
local lib = LibStub('AelTrackers-1.0')

local AuraTrigger = {}
AuraTrigger.__index = AuraTrigger
setmetatable(AuraTrigger, { __index = lib.triggers.BaseTrigger })

lib.triggers.createAuraTrigger = function(unit, auraType, spellIds, options)
	options = options or {}

	if type(spellIds) ~= 'table' then
		spellIds = { spellIds }
	end

	local trigger = setmetatable({
		auraType = auraType,
		elements = options.elements or {},
		ownOnly = options.ownOnly,
		spellIds = spellIds,
		unit = unit,
	}, AuraTrigger)

	trigger:Init()

	return trigger
end

function AuraTrigger:Apply(tracker) end

function AuraTrigger:Build(tracker)
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

function AuraTrigger:IsActive()
	return false
end

function AuraTrigger:Update() end
