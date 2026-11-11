local lib = LibStub('AelTrackers-1.0')

local AuraProgressText = {}
AuraProgressText.__index = AuraProgressText
setmetatable(AuraProgressText, { __index = lib.display.Text })

lib.display.createAuraProgressText = function(options)
	options = options or {}

	return setmetatable({
		font = options.font or {},
	}, AuraProgressText)
end

function AuraProgressText:Bind(target)
	self:BuildInto(target, self.level)
	target:SetDurationText(self.text, { textFormatter = lib.defaults.text.formatters.duration })
end

function AuraProgressText:Build(_, level)
	self.level = level
end
