local lib = LibStub('AelTrackers-1.0')

local Tracker = {}

lib.createTracker = function(fn)
	local tracker = CreateFrame('Frame', nil, AelUIParent)
	Mixin(tracker, Tracker)
	tracker.conditions = lib.createConditions()
	tracker.display = lib.createDisplay()
	tracker.needs = lib.createNeeds()
	tracker.sources = lib.createSources()

	fn(tracker)

	tracker.needs:Watch(function()
		tracker:Update()
	end)

	tracker:Update()

	return tracker
end

function Tracker:Build()
	self.built = true

	self.display:Build(self)
	self.sources:Build(self)
	self.sources:Update()

	self.sources:Watch(function()
		self:Update()
	end)
end

function Tracker:Update()
	if not self.needs:Matches() then
		self:Hide()
		return
	end

	if not self.built then
		self:Build()
	end

	self:Show()
	self.display:Reset(self)
	self.sources:Apply(self)
	self.conditions:Apply(self)
end
