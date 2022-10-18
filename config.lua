local addon = select(2, ...)

local resolutionConfigs = {}

local width, height = GetPhysicalScreenSize()
local resConfig = resolutionConfigs[height]
local ufHeight = resConfig and resConfig.unitFrameHeight or height * 0.025

if ufHeight % 2 > 0 then
	ufHeight = ufHeight + 1
end

addon.config = {
	screenSize = { width = width, height = height },
	unitframes = {
		height = ufHeight,
	},
	weakauras = {
		primaryIconSize = ufHeight,
		primaryIconSpacing = 2,
	},
}
