local addonName, ns = ...

AelUI = {}

local addon = LibStub('AceAddon-3.0'):NewAddon(addonName)

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

local charDefaults = {
	lootLog = {},
	gearSets = {},
	actionbars = {
		showBars = false,
	},
}

local function mergeDefaults(t, defaults)
	for k, v in pairs(defaults) do
		if type(v) == 'table' then
			if type(t[k]) ~= 'table' then t[k] = {} end
			mergeDefaults(t[k], v)
		elseif t[k] == nil then
			t[k] = v
		end
	end
end

function addon:OnInitialize()
	ns.db = LibStub('AceDB-3.0'):New('AelUIDB')
	mergeDefaults(ns.db.char, charDefaults)

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
