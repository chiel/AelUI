local lib = LibStub('AelTrackers-1.0')

local Text = {}
Text.__index = Text

lib.display.createText = function(options)
	options = options or {}

	return setmetatable({
		font = options.font or {},
	}, Text)
end

function Text:Build(tracker, level)
	self.frame = CreateFrame('Frame', nil, tracker)
	self.frame:SetFrameLevel(level)
	self.frame:SetAllPoints()

	local font = lib.defaults.text.font
	self.text = self.frame:CreateFontString(nil, 'OVERLAY')
	self.text:SetPoint('BOTTOM', 0, -6)
	self.text:SetFont(self.font.file or font.file, self.font.size or font.size, self.font.flags or font.flags)

	self:Reset()
end

function Text:Duration(duration)
	if not duration then
		return
	end

	if not self.binding then
		self.binding = C_DurationUtil.CreateDurationTextBinding()
		self.binding:SetFontString(self.text)
		self.binding:SetFormatter(lib.defaults.text.formatters.duration)
		self.binding:SetEnabled(true)
	end

	self.binding:SetDuration(duration)
end

function Text:Reset() end
