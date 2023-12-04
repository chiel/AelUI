local addon = select(2, ...)

local c = addon.weakauras.config

addon.weakauras.utils.buildIconAura = function(id, options)
	local options = options or {}
	local showGlow = options.showGlow or false
	local showProgress = options.showProgress or true
	local showStacks = options.showStacks or true

	local config = c.groupTypes[options.groupType].childConfig

	local aura = LibWA.CreateIcon(id)
	aura:SetSize(config.width or 40, config.height or 40)
	aura:AddCooldown()

	if showGlow then
		aura:AddGlow()
	end

	-- cooldown progress text
	if showProgress then
		aura:AddText('%p', {
			font = 'AelUI Bold',
			size = 14,
			justify = 'CENTER',
			anchor = {
				from = 'BOTTOM',
				to = 'BOTTOM',
				x = 0,
				y = -1,
			},
			format = {
				dynamic_threshold = 0,
			},
		})
	end

	-- stacks text
	if showStacks then
		aura:AddText('%s', {
			font = 'AelUI Bold',
			size = 12,
			justify = 'RIGHT',
			anchor = {
				from = 'TOPRIGHT',
				to = 'TOPRIGHT',
				x = -2,
				y = -2,
			},
		})
	end

	return aura
end
