local _, ns = ...

local Tracker = {}

ns.trackers.createTracker = function(fn)
	local tracker = CreateFrame('Frame', nil, AelUIParent)
	Mixin(tracker, Tracker)

	fn(tracker)
	tracker:Build()

	return tracker
end

function Tracker:Icon(...)
	local icon = ns.trackers.createIcon(...)
	self.display = icon
	return icon
end

function Tracker:Build()
	if not self.display then
		return
	end

	self.display:Build(self)
end
