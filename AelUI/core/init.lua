local addonName, ns = ...

local addon = LibStub('AceAddon-3.0'):NewAddon(addonName)
LibStub('AceEvent-3.0'):Embed(addon)

ns.addon = addon
