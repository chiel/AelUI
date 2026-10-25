local lib = LibStub('AelTrackers-1.0')

local Watchable = {}
Watchable.__index = Watchable
lib.utils.Watchable = Watchable

function Watchable:Notify(...)
	if not self.watchers then
		return
	end

	for _, fn in ipairs(self.watchers) do
		fn(...)
	end
end

function Watchable:Watch(fn)
	local isFirst = not self.watchers

	self.watchers = self.watchers or {}
	tinsert(self.watchers, fn)

	if isFirst and self.OnWatch then
		self:OnWatch()
	end
end
