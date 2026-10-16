local _, ns = ...

local Tracker = {}

ns.trackers.createTracker = function(fn)
	local tracker = CreateFrame('Frame', nil, AelUIParent)
	Mixin(tracker, Tracker)
	tracker.display = ns.trackers.createDisplay()

	fn(tracker)
	tracker:Build()

	return tracker
end

function Tracker:Build()
	if not self.display.icon then
		return
	end

	self.display:Build(self)
end
