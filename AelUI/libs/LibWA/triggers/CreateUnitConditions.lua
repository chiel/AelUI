local _, ns = ...

ns.triggers.CreateUnitConditions = function(options)
	local o = options or {}

	local aura = {
		alwaysActive = o.alwaysActive,
		groupType = o.groupType, -- 'party' | 'raid' | 'solo'
		hasPet = o.hasPet,
		isAfk = o.isAfk,
		isAlive = o.isAlive,
		isInCombat = o.isInCombat,
		isMoving = o.isMoving,
		isMounted = o.isMounted,
		isOnTaxi = o.isOnTaxi,
		isResting = o.isResting,
	}

	aura.Serialize = function(self)
		local t = {
			type = 'unit',
			event = 'Conditions',
		}

		if self.alwaysActive ~= nil then
			t.use_alwaystrue = self.alwaysActive
		end

		if self.hasPet ~= nil then
			t.use_HasPet = self.hasPet
		end

		if self.isAfk ~= nil then
			t.use_afk = self.isAfk
		end

		if self.isAlive ~= nil then
			t.use_alive = self.isAlive
		end

		if self.isInCombat ~= nil then
			t.use_incombat = self.isInCombat
		end

		if self.isMoving ~= nil then
			t.use_ismoving = self.isMoving
		end

		if self.isMounted ~= nil then
			t.use_mounted = self.isMounted
		end

		if self.isOnTaxi ~= nil then
			t.use_vehicle = self.isOnTaxi
		end

		if self.isResting ~= nil then
			t.use_resting = self.isResting
		end

		if type(self.groupType) == 'string' then
			t.use_ingroup = true
			t.ingroup = {
				single = self.groupType == 'party' and 'group' or self.groupType,
			}
		end

		if type(self.groupType) == 'table' then
			local multi = {}
			for _, type in ipairs(self.groupType) do
				if type == 'party' then
					multi.group = true
				else
					multi[type] = true
				end
			end
			t.use_ingroup = false
			t.ingroup = { multi = multi }
		end

		return { trigger = t, untrigger = {} }
	end

	return aura
end
