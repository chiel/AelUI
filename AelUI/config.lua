local addon = select(2, ...)

local resolutionConfigs = {}

local width, height = GetPhysicalScreenSize()
local resConfig = resolutionConfigs[height]
local ufHeight = resConfig and resConfig.unitFrameHeight or height * 0.025

if ufHeight % 2 > 0 then
	ufHeight = ufHeight + 1
end

local iconSpacing = 2
local minPrimaryIcons = 7
local minSecondaryIcons = 7

addon.config = {
	core = {
		anchors = {
			primary = {
				height = ufHeight,
				minWidth = (minPrimaryIcons * ufHeight) + ((minPrimaryIcons - 1) * iconSpacing),
			},
			secondary = {
				height = 32,
				minWidth = (minSecondaryIcons * ufHeight) + ((minSecondaryIcons - 1) * iconSpacing),
			},
		},
	},
	screenSize = { width = width, height = height },
	unitframes = {
		height = ufHeight,
	},
	weakauras = {
		primaryIconSize = ufHeight,
		primaryIconSpacing = iconSpacing,

		secondaryIconSize = 32,
		secondaryIconSpacing = iconSpacing,
	},
}
