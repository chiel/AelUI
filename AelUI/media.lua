local addon = select(2, ...)

addon.media = {
	border = [[Interface\Buttons\WHITE8X8]],
	font = [[Interface\AddOns\AelUI\media\RobotoCondensed-Regular.ttf]],
	fontBold = [[Interface\AddOns\AelUI\media\RobotoCondensed-Bold.ttf]],
	fontPixel = [[Interface\AddOns\AelUI\media\semplice.ttf]],
	texture = [[Interface\AddOns\AelUI\media\statusbar]],
	textureBg = [[Interface\Buttons\WHITE8X8]],
	texturePixel = [[Interface\AddOns\AelUI\media\statusbar-pixel]],
}

local LSM = LibStub('LibSharedMedia-3.0')
local MT = LSM.MediaType
LSM:Register(MT.FONT, 'AelUI', addon.media.font)
LSM:Register(MT.FONT, 'AelUI Bold', addon.media.fontBold)
LSM:Register(MT.FONT, 'AelUI Pixel', addon.media.fontPixel)
LSM:Register(MT.BACKGROUND, 'AelUI background', addon.media.textureBg)
LSM:Register(MT.BORDER, 'AelUI border', addon.media.border)
LSM:Register(MT.STATUSBAR, 'AelUI bar', addon.media.texture)
LSM:Register(MT.STATUSBAR, 'AelUI pixel bar', addon.media.texturePixel)
