local _, ns = ...

local h = ns.helpers
local m = ns.media

local defaultBarColor = { 35 / 255, 35 / 255, 35 / 255 }

ns.unitframes.elements.castbar = function(f, opts)
	opts = opts or {}
	local bd, bg = h.createBackdrop(f)

	local bar = CreateFrame('StatusBar', nil, bd)
	bar:SetStatusBarTexture(m.statusbars.default.file)
	bar:SetStatusBarColor(unpack(defaultBarColor))
	bar:SetPoint('TOPLEFT', 1, -1)
	bar:SetPoint('BOTTOMRIGHT', -1, 1)
	bar:SetMinMaxValues(0, 1)
	bar:SetValue(0)

	local spark = bar:CreateTexture(nil, 'OVERLAY')
	spark:SetTexture([[Interface\CastingBar\UI-CastingBar-Spark]])
	spark:SetBlendMode('ADD')
	spark:SetWidth(10)
	spark:SetSize(10, 30)
	spark:SetPoint('TOP', bar:GetStatusBarTexture(), 'TOPRIGHT', 0, 10)
	spark:SetPoint('BOTTOM', bar:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, -10)

	local startTime, endTime
	local channeling, gcd

	local function update(self)
		gcd = false

		local name, _, _, start, finish = UnitCastingInfo(self.unit)
		if name then
			startTime = start / 1000
			endTime = finish / 1000
			channeling = false
			bar:SetValue(0)
			bd:Show()
			if opts.onUpdate then
				opts.onUpdate(bd, { gcd = false, channeling = false, casting = true })
			end
			return
		end

		name, _, _, start, finish = UnitChannelInfo(self.unit)
		if name then
			startTime = start / 1000
			endTime = finish / 1000
			channeling = true
			bar:SetValue(1)
			bd:Show()
			if opts.onUpdate then
				opts.onUpdate(bd, { gcd = false, channeling = true, casting = false })
			end
			return
		end

		if self.unit == 'player' then
			local gcdStart, gcdDuration = GetSpellCooldown(29515)
			if gcdStart > 0 and gcdDuration > 0 then
				startTime = gcdStart
				endTime = gcdStart + gcdDuration
				gcd = true
				bar:SetValue(1)
				bd:Show()
				if opts.onUpdate then
					opts.onUpdate(bd, { gcd = true, channeling = false, casting = false })
				end
				return
			end
		end

		bd:Hide()
	end

	bd:SetScript('OnUpdate', function(self, elapsed)
		local now = GetTime()
		if now >= endTime then
			bd:Hide()
			return
		end

		local progress
		if channeling or gcd then
			progress = (endTime - now) / (endTime - startTime)
		else
			progress = (now - startTime) / (endTime - startTime)
		end

		bar:SetValue(progress)
	end)

	f:RegisterCallback('UNIT_SPELLCAST_START', update)
	f:RegisterCallback('UNIT_SPELLCAST_STOP', update)
	f:RegisterCallback('UNIT_SPELLCAST_FAILED', update)
	f:RegisterCallback('UNIT_SPELLCAST_INTERRUPTED', update)
	f:RegisterCallback('UNIT_SPELLCAST_DELAYED', update)
	f:RegisterCallback('UNIT_SPELLCAST_CHANNEL_START', update)
	f:RegisterCallback('UNIT_SPELLCAST_CHANNEL_UPDATE', update)
	f:RegisterCallback('UNIT_SPELLCAST_CHANNEL_STOP', update)
	f:RegisterCallback('UNIT_SPELLCAST_SUCCEEDED', update)

	if f.unit == 'player' then
		PlayerCastingBarFrame:UnregisterAllEvents()
		PlayerCastingBarFrame:Hide()
	end

	bd:Hide()

	return bd
end
