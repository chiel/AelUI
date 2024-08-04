local _, ns = ...

ns.media = {
	backgrounds = {
		default = {
			name = 'AelUI Background',
			file = [[Interface\Buttons\WHITE8X8]],
		},
	},

	borders = {
		default = {
			name = 'AelUI Border',
			file = [[Interface\Buttons\WHITE8X8]],
		},
	},

	fonts = {
		default = {
			name = 'AelUI',
			file = [[Interface\AddOns\AelUI\core\media\fonts\RobotoCondensed-Regular.ttf]],
		},
		bold = {
			name = 'AelUI Bold',
			file = [[Interface\AddOns\AelUI\core\media\fonts\RobotoCondensed-Bold.ttf]],
		},
		pixel = {
			name = 'AelUI Pixel',
			file = [[Interface\AddOns\AelUI\core\media\fonts\semplice.ttf]],
		},
	},

	statusbars = {
		default = {
			name = 'AelUI Bar',
			file = [[Interface\AddOns\AelUI\core\media\statusbars\statusbar]],
		},
		pixel = {
			name = 'AelUI Pixel Bar',
			file = [[Interface\AddOns\AelUI\core\media\statusbars\statusbar-pixel]],
		},
	},
}

local LSM = LibStub('LibSharedMedia-3.0')
local MT = LSM.MediaType

local allmedia = {
	{
		type = MT.BACKGROUND,
		entries = ns.media.backgrounds,
	},
	{
		type = MT.BORDER,
		entries = ns.media.borders,
	},
	{
		type = MT.FONT,
		entries = ns.media.fonts,
	},
	{
		type = MT.STATUSBAR,
		entries = ns.media.statusbars,
	},
}

for _, media in ipairs(allmedia) do
	for _, entry in pairs(media.entries) do
		LSM:Register(media.type, entry.name, entry.file)
	end
end
