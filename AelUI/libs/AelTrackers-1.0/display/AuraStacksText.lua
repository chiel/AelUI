local lib = LibStub('AelTrackers-1.0')

local AuraStacksText = {}
AuraStacksText.__index = AuraStacksText
setmetatable(AuraStacksText, { __index = lib.display.Text })

lib.display.createAuraStacksText = function(options)
	options = options or {}

	return setmetatable({
		font = options.font or {},
	}, AuraStacksText)
end

function AuraStacksText:Bind(target)
	self:BuildInto(target, self.level)
	target:SetApplicationCount(self.text)
end

function AuraStacksText:Build(_, level)
	self.level = level
end
