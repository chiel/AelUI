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
	local baseLevel = tracker:GetFrameLevel()
	for index, element in ipairs(self.elements) do
		element:Build(tracker, baseLevel + index)
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

function Display:Text(...)
	local text = lib.display.createText(...)
	tinsert(self.elements, text)
	return text
end
