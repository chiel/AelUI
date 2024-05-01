local ns = select(2, ...)

ns.media.statusbars = {
	default = {
		name = 'AelUI Bar',
		file = [[Interface\AddOns\AelUI\core\media\statusbars\statusbar]],
	},
	pixel = {
		name = 'AelUI Pixel Bar',
		file = [[Interface\AddOns\AelUI\core\media\statusbars\statusbar-pixel]],
	},
}
