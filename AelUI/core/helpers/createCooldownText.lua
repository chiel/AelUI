local _, ns = ...

local m = ns.media

ns.helpers.createCooldownText = function(parent, cooldown)
	local cdText = cooldown:CreateFontString(nil, 'OVERLAY')
	cdText:SetFont(m.fonts.bold.file, 16, 'OUTLINE')
	cdText:SetPoint('BOTTOM', parent, 'BOTTOM', 0, 1)
	cdText:SetJustifyH('CENTER')
	cdText:Hide()

	parent:HookScript('OnUpdate', function()
		local start, duration = cooldown:GetCooldownTimes()
		start = start / 1000
		duration = duration / 1000

		if start == 0 or duration <= 1.5 then
			cdText:Hide()
			return
		end

		local remaining = start + duration - GetTime()
		if remaining <= 0 then
			cdText:Hide()
			return
		end

		if remaining >= 3600 then
			cdText:SetText(math.floor(remaining / 3600) .. 'h')
		elseif remaining >= 60 then
			cdText:SetText(math.floor(remaining / 60) .. 'm')
		else
			cdText:SetText(math.floor(remaining))
		end
		cdText:Show()
	end)

	return cdText
end
