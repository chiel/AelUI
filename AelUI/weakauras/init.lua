local addon = select(2, ...)

AelUI.weakauras = {}
addon.weakauras = {}

local playerClass = select(2, UnitClass 'player')
playerClass = string.lower(playerClass)

local import = function()
	local classData = addon.weakauras.classes[playerClass]
	if not classData then
		print '[AelUI] No WeakAuras available for your class - sorry!'
		return
	end

	local classAura, childAuras = addon.weakauras.utils.buildClassAuras(classData)
	local inData = {
		d = classAura,
		c = childAuras,
		v = 2000,
	}

	local ok, error = WeakAuras.Import(inData, nil, function()
		print '[AelUI] WeakAuras import done'
	end)

	if not ok and error ~= nil then
		print('[AelUI] Error occured while trying to import WeakAuras', error)
	end
end

SLASH_AELUI1 = '/aelui'
SlashCmdList.AELUI = function(msg)
	if not WeakAuras or not WeakAuras.Import then
		return
	end

	local cmd, opts = string.match(msg, '(%S+)')
	cmd = string.lower(cmd or '')

	if cmd == 'import' then
		import()
	else
		print 'USAGE:'
		print '- /aelui import - to import class-specific WeakAuras'
	end
end
