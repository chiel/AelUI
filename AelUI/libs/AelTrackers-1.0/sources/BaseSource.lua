local AelEvents = LibStub('AelEvents-1.0')
local lib = LibStub('AelTrackers-1.0')

local BaseSource = {}
BaseSource.__index = BaseSource

lib.sources.BaseSource = BaseSource

function BaseSource:Init()
	self.requirements = {}
	self.watchers = {}
end

function BaseSource:AttributeEvent(attr, ...)
	local eventFilter = self.attributes[attr].eventFilter
	if eventFilter and not self[eventFilter](self, ...) then
		return
	end

	self:Update()
	self:Notify()
end

function BaseSource:Notify()
	for _, fn in ipairs(self.watchers) do
		fn()
	end
end

function BaseSource:RegisterAttributeEvents()
	for attr in pairs(self.requirements) do
		for _, event in ipairs(self.attributes[attr].events) do
			AelEvents.on(event, function(...)
				self:AttributeEvent(attr, ...)
			end)
		end
	end
end

function BaseSource:Require(attribute)
	assert(self.attributes and self.attributes[attribute], ('Source does not support attribute %s'):format(attribute))
	self.requirements[attribute] = true
end

function BaseSource:Requires(attribute)
	return self.requirements[attribute] or false
end

function BaseSource:Watch(fn)
	tinsert(self.watchers, fn)
end
