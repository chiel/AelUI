local _, ns = ...

local AelTrackers = LibStub('AelTrackers-1.0')

local h = ns.trackers.helpers

local _, playerClass = UnitClass('player')

if playerClass ~= 'WARLOCK' then
	return
end

local secondary = AelTrackers.createGroup(function(g)
	g:Tracker(h.createSpellIcon(7744)) -- Will of the Forsaken
end)

secondary:SetPoint('TOP', AelUISecondaryAnchor, 'TOP', 0, 0)
secondary:Watch(function(width, height)
	ns.anchors.secondary:UpdateWidth(width)
end)
