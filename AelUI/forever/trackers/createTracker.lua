local _, ns = ...

local Tracker = {}
Tracker.__index = Tracker

ns.trackers.createTracker = function(fn)
	local tracker = setmetatable({}, Tracker)

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
	self.frame = CreateFrame('Frame', nil, AelUIParent)

	if not self.display then
		return
	end

	self.display:Build(self)
end

function Tracker:ClearAllPoints(...)
	self.frame:ClearAllPoints(...)
end

function Tracker:SetPoint(...)
	self.frame:SetPoint(...)
end
