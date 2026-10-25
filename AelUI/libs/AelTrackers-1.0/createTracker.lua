local lib = LibStub('AelTrackers-1.0')

local Tracker = {}

lib.createTracker = function(parent, fn)
	if type(parent) == 'function' then
		fn = parent
		parent = lib.defaults.parent or UIParent
	end

	local tracker = CreateFrame('Frame', nil, parent)
	Mixin(tracker, lib.utils.Watchable, Tracker)
	tracker.effects = lib.createEffects()
	tracker.display = lib.createDisplay()
	tracker.needs = lib.createNeeds()
	tracker.sources = lib.createSources()

	fn(tracker)

	tracker.needs:Watch(function()
		tracker:Update()
	end)

	tracker:Update()

	return tracker
end

function Tracker:Build()
	self.built = true

	self.display:Build(self)
	self.sources:Build(self)
	self.sources:Update()

	self.sources:Watch(function()
		self:Update()
	end)
end

function Tracker:IsActive()
	return self.isActive
end

function Tracker:SetActive(isActive)
	if isActive == self.isActive then
		return
	end

	self.isActive = isActive
	self:Notify(self.isActive)
end

function Tracker:Update()
	if not self.needs:Matches() then
		self:Hide()
		self:SetActive(false)
		return
	end

	if not self.built then
		self:Build()
	end

	self:Show()
	self.display:Reset(self)
	self.sources:Apply(self)
	self.effects:Apply(self)
	self:SetActive(true)
end
