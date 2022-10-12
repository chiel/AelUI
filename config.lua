local addon = select(2, ...)

local width, height = GetPhysicalScreenSize()

addon.config = {
	screenSize = { width = width, height = height },
}
