local lib = LibStub('AelTrackers-1.0')

local Sources = {}
Sources.__index = Sources

lib.createSources = function()
	return setmetatable({ sources = {} }, Sources)
end

function Sources:Apply(tracker)
	for _, source in ipairs(self.sources) do
		if source.Apply then
			source:Apply(tracker)
		end
	end
end

function Sources:Aura(...)
	local source = lib.sources.createAura(...)
	tinsert(self.sources, source)
	return source
end

function Sources:Build(tracker)
	for _, source in ipairs(self.sources) do
		if source.Build then
			source:Build(tracker)
		end
	end
end

function Sources:Item(...)
	local source = lib.sources.createItem(...)
	tinsert(self.sources, source)
	return source
end

function Sources:Spell(...)
	local source = lib.sources.createSpell(...)
	tinsert(self.sources, source)
	return source
end

function Sources:Update()
	for _, source in ipairs(self.sources) do
		if source.Update then
			source:Update()
		end
	end
end

function Sources:Watch(fn)
	for _, source in ipairs(self.sources) do
		if source.Watch then
			source:Watch(fn)
		end
	end
end
