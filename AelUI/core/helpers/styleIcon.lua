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

	-- restyle hotkey text
	local hotkey = name and _G[name .. 'HotKey']
	if hotkey then
		hotkey:SetFont(m.fonts.default.file, 14, 'OUTLINE')
		hotkey:SetTextColor(1, 1, 1)
	end

	-- custom cooldown text
	local cd = btn.cooldown or btn.Cooldown or (name and _G[name .. 'Cooldown'])
	if cd and cd.GetCooldownTimes then
		if cd.SetHideCountdownNumbers then
			cd:SetHideCountdownNumbers(true)
		end
		ns.helpers.createCooldownText(btn, cd)

		if icon then
			btn:HookScript('OnUpdate', function()
				local start, duration = cd:GetCooldownTimes()
				start = start / 1000
				duration = duration / 1000

				local onCooldown = start > 0 and duration > 1.5 and (start + duration - GetTime()) > 0
				icon:SetDesaturated(onCooldown or icon.isLocked)
			end)
		end
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

	return bd, bg
end

