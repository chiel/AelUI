local ns = select(2, ...)

local u = ns.core.utils

ns.core.unitframes.createIndicatorGroup = function(parent, mirror)
	local indicators = {}
	local anchor = nil

	local f = CreateFrame('Frame', nil, parent)
	f:SetSize(1, 1)

	local update = function()
		anchor = nil
		local width = 0
		local offsetX = 0

		for _, entry in ipairs(indicators) do
			local i, offsetY = unpack(entry)

			if i:IsShown() then
				local w = i:GetSize()

				if mirror then
					i:SetPoint('RIGHT', -offsetX, offsetY or 0)
				else
					i:SetPoint('LEFT', offsetX, offsetY or 0)
				end
				offsetX = offsetX + u.round(w + 2)
				anchor = i
			end
		end
	end

	f.Add = function(self, indicator, offsetY)
		indicator:SetParent(f)
		table.insert(indicators, { indicator, offsetY })

		local postUpdate = indicator.PostUpdate
		indicator.PostUpdate = function(...)
			update()
			if postUpdate then
				postUpdate(...)
			end
		end
	end

	return f
end
