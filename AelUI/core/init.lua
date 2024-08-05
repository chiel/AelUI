local addonName, ns = ...

AelUI = {}

local addon = LibStub('AceAddon-3.0'):NewAddon(addonName)
LibStub('AceEvent-3.0'):Embed(addon)

ns.handlers = {
	initialise = {},
	enable = {},
}

ns.OnInitialise = function(fn)
	table.insert(ns.handlers.initialise, fn)
end

ns.OnEnable = function(fn)
	table.insert(ns.handlers.enable, fn)
end

function addon:OnInitialize()
	for _, fn in ipairs(ns.handlers.initialise) do
		fn()
	end
end

function addon:OnEnable()
	for _, fn in ipairs(ns.handlers.enable) do
		fn()
	end
end

ns.addon = addon
ns.console = LibStub('AceConsole-3.0')
