local addon = select(2, ...)

local options = {
	type = 'group',
	name = 'AelUI',
	args = {},
}

local console = LibStub 'AceConsole-3.0'
local dialog = LibStub 'AceConfigDialog-3.0'
local registry = LibStub 'AceConfigRegistry-3.0'

dialog:SetDefaultSize('AelUI', 800, 600)
registry:RegisterOptionsTable('AelUI', options, false)

console:RegisterChatCommand('aelui', function()
	dialog:Open 'AelUI'
end)
