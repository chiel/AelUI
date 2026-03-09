local _, ns = ...

local h = ns.helpers
local m = ns.media

local threatColors = {
	[1] = { 1, 0.6, 0 },
	[2] = { 1, 0.6, 0 },
	[3] = { 1, 0, 0 },
}

ns.unitframes.elements.threat = function(f, options)
	local o = options or {}
	local parent = o.parent or f
	local size = o.size or 8

	local bd, bg = h.createBackdrop(parent)
	bd:SetSize(size, size)
	bd:SetPoint('BOTTOMLEFT', parent, 'BOTTOMLEFT', 1, 1)
	bd:Hide()

	local function update(self)
		if not self.unit then
			bd:Hide()
			return
		end

		local status = UnitThreatSituation(self.unit)
		local color = status and threatColors[status]
		if color then
			bg:SetVertexColor(color[1], color[2], color[3])
			bd:Show()
		else
			bd:Hide()
		end
	end

	f:RegisterCallback('UNIT_THREAT_SITUATION_UPDATE', update)

	f.updaters[update] = true
	update(f)

	return bd
end
