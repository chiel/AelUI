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

	local a = aura:Serialize()

	-- action bar glow
	if showGlow then
		table.insert(a.subRegions, {
			type = 'subglow',
			glow = false,
			glowType = 'Proc',
		})
	end

	-- cooldown progress text
	if showProgress then
		table.insert(a.subRegions, {
			type = 'subtext',
			text_text = '%p',

			text_font = 'AelUI Bold',
			text_fontSize = 14,
			text_justify = 'CENTER',

			text_anchorPoint = 'BOTTOM',
			text_anchorXOffset = 0,
			text_anchorYOffset = -1,
			text_selfPoint = 'BOTTOM',

			text_text_format_p_time_dynamic_threshold = 0,
		})
	end

	-- stacks text
	if showStacks then
		table.insert(a.subRegions, {
			type = 'subtext',
			text_text = '%s',

			text_font = 'AelUI Bold',
			text_fontSize = 12,
			text_justify = 'CENTER',

			text_anchorPoint = 'TOPRIGHT',
			text_anchorXOffset = -2,
			text_anchorYOffset = -2,
			text_selfPoint = 'TOPRIGHT',
		})
	end

	return a
end
