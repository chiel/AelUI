local lib = LibStub('AelTrackers-1.0')

local Tracker = {}

lib.createTracker = function(fn)
	local tracker = CreateFrame('Frame', nil, AelUIParent)
	Mixin(tracker, Tracker)
	tracker.conditions = lib.createConditions()
	tracker.display = lib.createDisplay()
	tracker.triggers = lib.createTriggers()

	fn(tracker)
	tracker:Build()

	return tracker
end

function Tracker:Build()
	if not self.display.icon then
		return
	end

	self.display:Build(self)
	self.triggers:Build(self)
	self.triggers:Update()
	self.triggers:Watch(function()
		self:Update()
	end)

	self:Update()
end

function Tracker:Update()
	self.display:Reset(self)
	self.triggers:Apply(self)
	self.conditions:Apply(self)
end
