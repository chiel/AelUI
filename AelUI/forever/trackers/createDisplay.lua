local _, ns = ...

local Display = {}
Display.__index = Display

ns.trackers.createDisplay = function()
	return setmetatable({}, Display)
end

function Display:Build(tracker)
	if self.icon then
		self.icon:Build(tracker)
	end
end

function Display:CooldownDuration(...)
	if self.icon then
		self.icon:CooldownDuration(...)
	end
end

function Display:Icon(...)
	self.icon = ns.trackers.display.createIcon(...)
	return self.icon
end

function Display:Reset()
	if self.icon then
		self.icon:Reset()
	end
end
