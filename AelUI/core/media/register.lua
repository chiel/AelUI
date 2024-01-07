local addon = select(2, ...)

local LSM = LibStub('LibSharedMedia-3.0')
local MT = LSM.MediaType

local allmedia = {
	{
		type = MT.BACKGROUND,
		entries = addon.core.media.backgrounds,
	},
	{
		type = MT.BORDER,
		entries = addon.core.media.borders,
	},
	{
		type = MT.FONT,
		entries = addon.core.media.fonts,
	},
	{
		type = MT.STATUSBAR,
		entries = addon.core.media.statusbars,
	},
}

for _, media in ipairs(allmedia) do
	for _, entry in pairs(media.entries) do
		LSM:Register(media.type, entry.name, entry.file)
	end
end
