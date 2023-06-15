local addon = select(2, ...)

AelUI = {}

SLASH_AELUI1 = '/aelui'
SlashCmdList.AELUI = function(msg)
	local cmd, opts = string.match(msg, '(%S+)')
	cmd = string.lower(cmd or '')

	if cmd == '' then
		print 'show config'
	elseif cmd == 'import' then
		addon.weakauras.import()
	else
		print 'USAGE:'
		print '- /aelui import - to import class-specific WeakAuras'
	end
end
