local lib = LibStub('AelTrackers-1.0')

local Display = {}
Display.__index = Display

lib.createDisplay = function()
	return setmetatable({ elements = {} }, Display)
end

function Display:Border(...)
	local border = lib.display.createBorder()
	tinsert(self.elements, border)
	return border
end

function Display:Build(tracker)
	if self.icon then
		self.icon:Build(tracker)
	end

	for _, element in ipairs(self.elements) do
		element:Build(tracker)
	end
end

function Display:CooldownDuration(...)
	if self.icon then
		self.icon:CooldownDuration(...)
	end
end

function Display:Icon(...)
	self.icon = lib.display.createIcon(...)
	return self.icon
end

function Display:IconTexture(...)
	if self.icon then
		self.icon:Texture(...)
	end
end

function Display:Reset()
	if self.icon then
		self.icon:Reset()
	end

	for _, element in ipairs(self.elements) do
		element:Reset()
	end
end
