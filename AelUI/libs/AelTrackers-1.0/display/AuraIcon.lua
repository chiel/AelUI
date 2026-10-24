local lib = LibStub('AelTrackers-1.0')

local AuraIcon = {}
AuraIcon.__index = AuraIcon
setmetatable(AuraIcon, { __index = lib.display.Icon })

lib.display.createAuraIcon = function(width, height)
	local icon = setmetatable({}, AuraIcon)
	icon:Size(width, height)
	return icon
end

function AuraIcon:Bind(target)
	self:BuildInto(target, self.level)
	target:SetIcon(self.texture)

	if self.cooldownFrame then
		target:SetDurationCooldown(self.cooldownFrame)
	end
end

function AuraIcon:Build(tracker, level)
	self.level = level
end
