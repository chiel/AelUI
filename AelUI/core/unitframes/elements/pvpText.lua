local _, ns = ...

local m = ns.media

ns.unitframes.elements.pvpText = function(f, parent, options)
	local o = options or {}

	local text = (parent or f):CreateFontString(nil, 'OVERLAY')
	text:SetFont(m.fonts.bold.file, o.fontSize or 12, 'OUTLINE')
	text:SetJustifyH(o.justifyH or 'LEFT')

	local function render(self)
		if not UnitIsPVP(self.unit) then
			text:SetText('')
			return
		end

		local faction = UnitFactionGroup(self.unit)
		if faction == 'Horde' then
			text:SetTextColor(0.9, 0.2, 0.2)
		elseif faction == 'Alliance' then
			text:SetTextColor(0.2, 0.4, 0.9)
		else
			text:SetTextColor(0.2, 0.9, 0.2)
		end

		if self.unit == 'player' and IsPVPTimerRunning() then
			local remaining = math.ceil(GetPVPTimer() / 1000)
			local minutes = math.floor(remaining / 60)
			local seconds = remaining % 60
			text:SetText(string.format('PVP |cff888888(%d:%02d)|r', minutes, seconds))
		else
			text:SetText('PVP')
		end
	end

	local ticker
	local function update(self)
		render(self)

		if UnitIsPVP(self.unit) and self.unit == 'player' and IsPVPTimerRunning() then
			if not ticker then
				local frame = parent or f
				ticker = true
				frame:SetScript('OnUpdate', function()
					render(self)
					if not IsPVPTimerRunning() then
						frame:SetScript('OnUpdate', nil)
						ticker = nil
						render(self)
					end
				end)
			end
		end
	end

	f:RegisterCallback('PLAYER_FLAGS_CHANGED', update)
	f:RegisterCallback('UNIT_FACTION', update)

	update(f)

	return text
end
