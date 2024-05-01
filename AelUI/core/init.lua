local addonName, ns = ...

AelUI = {}

local addon = LibStub('AceAddon-3.0'):NewAddon(addonName)
LibStub('AceEvent-3.0'):Embed(addon)

local defaults = {
	profile = {
		anchors = {
			primary = {
				minWidth = (40 * 7) + (2 * 6),
				offset = 220,
			},
			secondary = {
				minWidth = (32 * 7) + (2 * 6),
			},
		},
		icons = {
			primary = {
				size = 40,
			},
			secondary = {
				size = 32,
			},
		},
		spacing = 2,
		unitframes = {
			party = {
				width = 100,
				height = 70,
			},
		},
	},
}

function addon:OnInitialize()
	local db = LibStub('AceDB-3.0'):New('AelUIDB', defaults, true)
	ns.db = db.profile

	ns.anchors.Initialise(db.profile.anchors)
end

ns.addon = addon
