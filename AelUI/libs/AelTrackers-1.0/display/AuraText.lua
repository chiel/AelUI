local lib = LibStub('AelTrackers-1.0')

local AuraText = {}
AuraText.__index = AuraText
setmetatable(AuraText, { __index = lib.display.Text })

lib.display.createAuraText = function(options)
	options = options or {}

	return setmetatable({
		font = options.font or {},
	}, AuraText)
end

function AuraText:Bind(target)
	self:BuildInto(target, self.level)
	target:SetDurationText(self.text, { textFormatter = lib.defaults.text.formatters.duration })
end

function AuraText:Build(_, level)
	self.level = level
end
