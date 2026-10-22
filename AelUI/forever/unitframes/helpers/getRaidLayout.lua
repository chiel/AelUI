local _, ns = ...

local h = ns.unitframes.helpers

local CONTAINER_MAX_WIDTH = 640
local CONTAINER_MAX_HEIGHT = 320
local SPACING_GROUP = 4
local SPACING_UNIT = 4
local UNIT_MAX_WIDTH = 120
local UNIT_MAX_HEIGHT = 80

ns.unitframes.helpers.getRaidLayout = function()
	local memberCounts, maxGroupSize, groupCount = h.getRaidGroupInfo()
	if groupCount == 0 or maxGroupSize == 0 then
		return nil
	end

	local groupAxis = groupCount > 5 and 'x' or 'y'

	local point = 'LEFT'
	local xOffset = SPACING_UNIT
	local yOffset = 0
	local xUnits = maxGroupSize
	local yUnits = groupCount
	local xSpacing = SPACING_UNIT
	local ySpacing = SPACING_GROUP
	if groupAxis == 'x' then
		point = 'TOP'
		xOffset = 0
		yOffset = -SPACING_UNIT
		xUnits = groupCount
		yUnits = maxGroupSize
		xSpacing = SPACING_GROUP
		ySpacing = SPACING_UNIT
	end

	local unitWidth = math.floor((CONTAINER_MAX_WIDTH - (xUnits - 1) * xSpacing) / xUnits)
	unitWidth = math.min(unitWidth, UNIT_MAX_WIDTH)
	unitWidth = math.floor(unitWidth / 2) * 2

	local unitHeight = math.floor((CONTAINER_MAX_HEIGHT - (yUnits - 1) * ySpacing) / yUnits)
	unitHeight = math.min(unitHeight, UNIT_MAX_HEIGHT)
	unitHeight = math.floor(unitHeight / 2) * 2

	local containerWidth = (xUnits * (unitWidth + xSpacing)) - xSpacing
	local containerHeight = (yUnits * (unitHeight + ySpacing)) - ySpacing

	return {
		groupAxis = groupAxis,
		point = point,
		xOffset = xOffset,
		yOffset = yOffset,
		xSpacing = xSpacing,
		ySpacing = ySpacing,
		containerWidth = containerWidth,
		containerHeight = containerHeight,
		unitWidth = unitWidth,
		unitHeight = unitHeight,
		memberCounts = memberCounts,
	}
end
