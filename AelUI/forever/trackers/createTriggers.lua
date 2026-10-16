local _, ns = ...

local Triggers = {}
Triggers.__index = Triggers

ns.trackers.createTriggers = function()
	return setmetatable({ entries = {} }, Triggers)
end

function Triggers:Build(tracker)
	for _, trigger in ipairs(self.entries) do
		trigger:Build(tracker)
	end
end
