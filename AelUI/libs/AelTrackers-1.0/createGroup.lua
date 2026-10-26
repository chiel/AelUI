local lib = LibStub('AelTrackers-1.0')

local Group = {}

lib.createGroup = function(fn)
	local group = CreateFrame('Frame', nil, lib.defaults.parent or UIParent)
	Mixin(group, lib.utils.Watchable, Group)
	group.alignment = 'start'
	group.orientation = 'horizontal'
	group.spacing = 2
	group.trackers = {}

	fn(group)
	group:Update()

	return group
end

function Group:GetAnchor()
	if self.alignment == 'start' then
		return 'TOPLEFT'
	end

	if self.orientation == 'horizontal' then
		if self.alignment == 'middle' then
			return 'LEFT'
		end

		return 'BOTTOMLEFT'
	end

	if self.alignment == 'middle' then
		return 'TOP'
	end

	return 'TOPRIGHT'
end

function Group:Layout(orientation, alignment, spacing)
	self.orientation = orientation
	self.alignment = alignment
	self.spacing = spacing

	self:Update()
end

function Group:OnWatch()
	self:Notify(self.width, self.height)
end

function Group:Tracker(fn)
	local tracker = lib.createTracker(self, fn)
	tinsert(self.trackers, tracker)
	tracker:Watch(function()
		self:Update()
	end)

	return tracker
end

function Group:Update()
	local groupWidth = 0
	local groupHeight = 0

	local visibleCount = 0
	local dimensions = {}
	for i, tracker in ipairs(self.trackers) do
		if tracker:IsActive() then
			local width = math.round(tracker:GetWidth())
			local height = math.round(tracker:GetHeight())
			dimensions[i] = { width, height }

			local spacing = visibleCount == 0 and 0 or self.spacing
			visibleCount = visibleCount + 1
			if self.orientation == 'horizontal' then
				groupWidth = groupWidth + width + spacing
				groupHeight = math.max(groupHeight, height)
			else
				groupWidth = math.max(groupWidth, width)
				groupHeight = groupHeight + height + spacing
			end
		end
	end

	local anchor = self:GetAnchor()

	local nextOffset = 0
	for i, tracker in ipairs(self.trackers) do
		if dimensions[i] then
			local width, height = unpack(dimensions[i])
			tracker:ClearAllPoints()
			if self.orientation == 'horizontal' then
				tracker:SetPoint(anchor, self, nextOffset, 0)
				nextOffset = nextOffset + width + self.spacing
			else
				tracker:SetPoint(anchor, self, 0, -nextOffset)
				nextOffset = nextOffset + height + self.spacing
			end
		end
	end

	self:UpdateSize(groupWidth, groupHeight)
end

function Group:UpdateSize(width, height)
	if width == self.width and height == self.height then
		return
	end

	self.width = width
	self.height = height
	self:SetSize(width, height)
	self:Notify(width, height)
end
