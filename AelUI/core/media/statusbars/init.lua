local addon = select(2, ...)

addon.core.media.statusbars = {
	default = {
		name = 'AelUI Bar',
		file = [[Interface\AddOns\AelUI\core\media\statusbars\statusbar]],
	},
	pixel = {
		name = 'AelUI Pixel Bar',
		file = [[Interface\AddOns\AelUI\core\media\statusbars\statusbar-pixel]],
	},
}
