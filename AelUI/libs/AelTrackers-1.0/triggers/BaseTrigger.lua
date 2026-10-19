local AelEvents = LibStub('AelEvents-1.0')
local lib = LibStub('AelTrackers-1.0')

local BaseTrigger = {}
BaseTrigger.__index = BaseTrigger

lib.triggers.BaseTrigger = BaseTrigger

function BaseTrigger:Init()
	self.requirements = {}
	self.watchers = {}
end

function BaseTrigger:AttributeEvent(attr, ...)
	local eventFilter = self.attributes[attr].eventFilter
	if eventFilter and not self[eventFilter](self, ...) then
		return
	end

	self:Update()
	self:Notify()
end

function BaseTrigger:Notify()
	for _, fn in ipairs(self.watchers) do
		fn()
	end
end

function BaseTrigger:RegisterAttributeEvents()
	for attr in pairs(self.requirements) do
		for _, event in ipairs(self.attributes[attr].events) do
			AelEvents.on(event, function(...)
				self:AttributeEvent(attr, ...)
			end)
		end
	end
end

function BaseTrigger:Require(attribute)
	assert(self.attributes and self.attributes[attribute], ('Trigger does not support attribute %s'):format(attribute))
	self.requirements[attribute] = true
end

function BaseTrigger:Requires(attribute)
	return self.requirements[attribute] or false
end

function BaseTrigger:Watch(fn)
	tinsert(self.watchers, fn)
end
