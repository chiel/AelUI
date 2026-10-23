local lib = LibStub('AelTrackers-1.0')

local Border = {}
Border.__index = Border

lib.display.createBorder = function()
	return setmetatable({}, Border)
end

function Border:Build(tracker, level)
	self.border = CreateFrame('Frame', nil, tracker, 'BackdropTemplate')
	self.border:SetAllPoints()
	self.border:SetFrameLevel(level)

	self.border:SetBackdrop({
		edgeFile = [[Interface\Buttons\WHITE8X8]],
		edgeSize = 1,
	})

	self:Reset()
end

function Border:Color(color, override)
	if not override then
		self.color = color
	end

	if self.border then
		self.border:SetBackdropBorderColor(unpack(color))
	end
end

function Border:Reset()
	self.border:SetBackdropBorderColor(unpack(self.color or { 1, 1, 1, 1 }))
end
