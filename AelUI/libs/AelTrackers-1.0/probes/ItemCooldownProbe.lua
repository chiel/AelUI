local AelEvents = LibStub('AelEvents-1.0')
local lib = LibStub('AelTrackers-1.0')

local ItemCooldownProbe = {}
ItemCooldownProbe.__index = ItemCooldownProbe
setmetatable(ItemCooldownProbe, { __index = lib.utils.Watchable })

lib.probes.createItemCooldownProbe = function(itemId)
	local probe = setmetatable({
		itemId = itemId,
	}, ItemCooldownProbe)

	probe:Update()
	return probe
end

function ItemCooldownProbe:Duration()
	return self.duration
end

function ItemCooldownProbe:IsOnCooldown()
	return self.duration ~= nil
end

function ItemCooldownProbe:OnWatch()
	self.tracker = CreateFrame('Cooldown', nil, WorldFrame)
	self.tracker:SetSize(1, 1)
	self.tracker:SetAlpha(0)
	self.tracker:Show()
	self.tracker:SetScript('OnCooldownDone', function()
		C_Timer.After(0, function()
			self:Update()
		end)
	end)

	AelEvents.on('BAG_UPDATE_COOLDOWN', function()
		self:Update()
	end)

	self:Update()
end

function ItemCooldownProbe:Update()
	local startTime, durationSeconds = C_Item.GetItemCooldown(self.itemId)
	local cdChanged = startTime ~= self.startTime or durationSeconds ~= self.durationSeconds
	if cdChanged then
		if startTime > 0 then
			self.startTime = startTime
			self.durationSeconds = durationSeconds
			self.duration = C_DurationUtil.CreateDuration()
			self.duration:SetTimeFromStart(startTime, durationSeconds)
		else
			self.startTime = nil
			self.durationSeconds = nil
			self.duration = nil
		end
	end

	if self.tracker and self.duration ~= self.activeDuration then
		self.activeDuration = self.duration

		if self.duration then
			self.tracker:SetCooldownFromDurationObject(self.duration)
		else
			self.tracker:Clear()
		end
	end

	if cdChanged then
		self:Notify(self.duration ~= nil)
	end
end
