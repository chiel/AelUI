local _, ns = ...

local u = ns.utils

local GCD_SPELL_ID = 29515
local defaultBarColor = { 35 / 255, 35 / 255, 35 / 255 }

ns.unitframes.elements.castbar = function(f, options)
	local o = options or {}

	local bar, bd, bg = u.createStatusBar(f, { spark = { overflow = 10 } })
	bar:SetStatusBarColor(unpack(defaultBarColor))
	bar:SetMinMaxValues(0, 1)
	bar:SetValue(0)

	local ticker

	local function hide()
		bd:Hide()

		if ticker then
			ticker:Cancel()
			ticker = nil
		end
	end

	local function update(self)
		local direction, duration
		local isGCD = false

		local name = UnitCastingInfo(self.unit)
		if name then
			duration = UnitCastingDuration(self.unit)
			direction = Enum.StatusBarTimerDirection.ElapsedTime
		end

		if not duration then
			name = UnitChannelInfo(self.unit)
			if name then
				duration = UnitChannelDuration(self.unit)
				direction = Enum.StatusBarTimerDirection.RemainingTime
			end
		end

		if not duration and self.unit == 'player' then
			local cd = C_Spell.GetSpellCooldown(GCD_SPELL_ID)
			if cd.isActive then
				isGCD = true
				duration = C_Spell.GetSpellCooldownDuration(GCD_SPELL_ID, false)
				direction = Enum.StatusBarTimerDirection.RemainingTime

				if not ticker then
					ticker = C_Timer.NewTicker(0.05, function()
						if not C_Spell.GetSpellCooldown(GCD_SPELL_ID).isActive then
							hide()
						end
					end)
				end
			end
		end

		if duration then
			if not isGCD and ticker then
				ticker:Cancel()
				ticker = nil
			end

			bar:SetTimerDuration(duration, nil, direction)
			bd:Show()
		else
			hide()
		end
	end

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

	hide()

	return bd
end
