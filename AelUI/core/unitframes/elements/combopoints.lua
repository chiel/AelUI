local _, ns = ...

local h = ns.helpers

local colors = {
	{ 1.0, 0.2, 0.2 },
	{ 1.0, 0.4, 0.2 },
	{ 1.0, 0.6, 0.2 },
	{ 1.0, 0.8, 0.2 },
	{ 1.0, 1.0, 0.2 },
}

ns.unitframes.elements.combopoints = function(f)
	local container = CreateFrame('Frame', nil, f)

	local points = {}
	for i = 1, 5 do
		local bd, bg = h.createBackdrop(container)
		points[i] = { bd = bd, bg = bg }
	end

	container:SetScript('OnSizeChanged', function(self, width, height)
		local total = width + 4 -- 4 shared borders at -1 each
		local base = math.floor(total / 5)
		local remainder = total - base * 5
		local x = 0
		for i = 1, 5 do
			local w = base + (i <= remainder and 1 or 0)
			points[i].bd:ClearAllPoints()
			points[i].bd:SetPoint('LEFT', x, 0)
			points[i].bd:SetSize(w, height)
			x = x + w - 1
		end
	end)

	local function update(self)
		local cp = GetComboPoints(self.unit, 'target')
		for i = 1, 5 do
			local c = colors[i]
			if i <= cp then
				points[i].bg:SetVertexColor(c[1], c[2], c[3])
			else
				points[i].bg:SetVertexColor(50 / 255, 50 / 255, 50 / 255)
			end
		end
	end

	f:RegisterCallback('UNIT_POWER_UPDATE', update)
	f:RegisterCallback('PLAYER_TARGET_CHANGED', update)

	update(f)

	return container
end
