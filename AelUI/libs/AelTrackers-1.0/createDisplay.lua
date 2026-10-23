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
	for index, element in ipairs(self.elements) do
		element:Build(tracker)
	end
end

function Display:Icon(...)
	local icon = lib.display.createIcon(...)
	tinsert(self.elements, icon)
	return icon
end

function Display:Reset()
	for _, element in ipairs(self.elements) do
		element:Reset()
	end
end
