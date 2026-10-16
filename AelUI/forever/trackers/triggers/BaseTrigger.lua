local _, ns = ...

local BaseTrigger = {}
BaseTrigger.__index = BaseTrigger

ns.trackers.triggers.BaseTrigger = BaseTrigger

function BaseTrigger:Init()
	self.watchers = {}
end

function BaseTrigger:Notify()
	for _, fn in ipairs(self.watchers) do
		fn()
	end
end

function BaseTrigger:Watch(fn)
	tinsert(self.watchers, fn)
end
