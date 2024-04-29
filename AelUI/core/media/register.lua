local ns = select(2, ...)

local LSM = LibStub('LibSharedMedia-3.0')
local MT = LSM.MediaType

local allmedia = {
	{
		type = MT.BACKGROUND,
		entries = ns.core.media.backgrounds,
	},
	{
		type = MT.BORDER,
		entries = ns.core.media.borders,
	},
	{
		type = MT.FONT,
		entries = ns.core.media.fonts,
	},
	{
		type = MT.STATUSBAR,
		entries = ns.core.media.statusbars,
	},
}

for _, media in ipairs(allmedia) do
	for _, entry in pairs(media.entries) do
		LSM:Register(media.type, entry.name, entry.file)
	end
end
