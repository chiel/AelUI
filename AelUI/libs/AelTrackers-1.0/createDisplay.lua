local lib = LibStub('AelTrackers-1.0')

local Display = {}
Display.__index = Display

lib.createDisplay = function()
	return setmetatable({}, Display)
end

function Display:Build(tracker)
	if self.icon then
		self.icon:Build(tracker)
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
end
