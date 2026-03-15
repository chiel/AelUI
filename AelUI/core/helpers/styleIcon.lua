local _, ns = ...

local m = ns.media

ns.helpers.styleIcon = function(btn)
	if btn._styled then
		return
	end
	local name = btn.GetName and btn:GetName()

	-- add backdrop
	local bd, bg = ns.helpers.createBackdrop(btn, { borderSize = 2 })
	bd:SetAllPoints()
	bd:SetFrameLevel(math.max(btn:GetFrameLevel() - 1, 0))
	btn.bd = bd

	-- strip normal texture
	local nt = btn.GetNormalTexture and btn:GetNormalTexture()
	if nt then
		nt:SetTexture(nil)
	end
	if name then
		local gnt = _G[name .. 'NormalTexture']
		if gnt then
			gnt:SetTexture(nil)
		end
	end

	-- strip Blizzard chrome
	if btn.BattlepayItemTexture then
		btn.BattlepayItemTexture:Hide()
	end
	if btn.SlotBackground then
		btn.SlotBackground:Hide()
	end
	if btn.IconMask then
		btn.IconMask:Hide()
	end

	-- position icon
	local icon = btn.icon or btn.Icon
	if icon then
		icon:ClearAllPoints()
		icon:SetPoint('TOPLEFT', 2, -2)
		icon:SetPoint('BOTTOMRIGHT', -2, 2)
	end

	-- custom cooldown text
	local cd = btn.cooldown or btn.Cooldown or (name and _G[name .. 'Cooldown'])
	if cd and cd.GetCooldownTimes then
		local cdText = cd:CreateFontString(nil, 'OVERLAY')
		cdText:SetFont(m.fonts.bold.file, 16, 'OUTLINE')
		cdText:SetPoint('BOTTOM', btn, 'BOTTOM', 0, 1)
		cdText:SetJustifyH('CENTER')
		cdText:Hide()

		btn:HookScript('OnUpdate', function()
			local start, duration = cd:GetCooldownTimes()
			start = start / 1000
			duration = duration / 1000

			if start == 0 or duration <= 1.5 then
				cdText:Hide()
				if icon then
					icon:SetDesaturated(false)
				end
				return
			end

			local remaining = start + duration - GetTime()
			if remaining <= 0 then
				cdText:Hide()
				if icon then
					icon:SetDesaturated(false)
				end
				return
			end

			if icon then
				icon:SetDesaturated(true)
			end

			if remaining >= 3600 then
				cdText:SetText(math.floor(remaining / 3600) .. 'h')
			elseif remaining >= 300 then
				cdText:SetText(math.floor(remaining / 60) .. 'm')
			else
				cdText:SetText(string.format('%d:%02d', math.floor(remaining / 60), math.floor(remaining % 60)))
			end
			cdText:Show()
		end)
	end

	-- restyle count text
	local count = btn.Count or (name and _G[name .. 'Count'])
	if count then
		count:SetFont(m.fonts.bold.file, 16, 'OUTLINE')
		count:ClearAllPoints()
		count:SetPoint('TOPRIGHT', btn, 'TOPRIGHT', 0, -1)
		count:SetJustifyH('RIGHT')
	end

	btn._styled = true
end
