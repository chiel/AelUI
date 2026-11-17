local addonName, MHM = ...

MHM.addonName = addonName

function MHM:PlayerName(player)
	if player.secondaryName and player.secondaryName ~= '' then
		return player.name .. ' ' .. player.secondaryName
	end

	return player.name
end

local function playerKey(player)
	return player.guid or MHM:PlayerName(player)
end

function MHM:FormatPlayer(player)
	local name = self:PlayerName(player)
	local iconCoords = CLASS_ICON_TCOORDS and CLASS_ICON_TCOORDS[player.classFile]

	if iconCoords then
		local left = math.floor(iconCoords[1] * 256 + 0.5)
		local right = math.floor(iconCoords[2] * 256 + 0.5)
		local top = math.floor(iconCoords[3] * 256 + 0.5)
		local bottom = math.floor(iconCoords[4] * 256 + 0.5)
		name = string.format(
			'|TInterface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES:14:14:0:0:256:256:%d:%d:%d:%d|t %s',
			left,
			right,
			top,
			bottom,
			name
		)
	end

	local classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)
		and (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[player.classFile]
	if not classColor then
		return name
	end

	local color = classColor.colorStr
	if not color then
		color = string.format(
			'ff%02x%02x%02x',
			math.floor(classColor.r * 255 + 0.5),
			math.floor(classColor.g * 255 + 0.5),
			math.floor(classColor.b * 255 + 0.5)
		)
	end

	return '|c' .. color .. name .. '|r'
end

function MHM:SnapshotPlayer(unit)
	if not unit or not UnitExists(unit) or not UnitIsPlayer(unit) then
		return nil
	end

	local name, secondaryName = UnitFullName(unit)
	if not name then
		return nil
	end

	local className, classFile = UnitClass(unit)
	local guildName = GetGuildInfo(unit)
	local player = {
		guid = UnitGUID(unit),
		name = name,
		secondaryName = secondaryName,
		className = className,
		classFile = classFile,
		guildName = guildName,
	}

	player.key = playerKey(player)
	return player
end

function MHM:GetPersonalManifest()
	local manifest = MurderHoboManifestDB and MurderHoboManifestDB.personalManifest
	if manifest and manifest.name == 'My Manifest' then
		manifest.name = 'Grudge List'
	end

	return manifest
end

function MHM:PersonalManifest()
	local db = MurderHoboManifestDB
	if not db then
		db = {}
		MurderHoboManifestDB = db
	end

	if not db.personalManifest then
		db.personalManifest = {
			id = 'personal',
			name = 'Grudge List',
			entries = {},
		}
	end

	return db.personalManifest
end

function MHM:ClearPersonalManifest()
	local manifest = self:GetPersonalManifest()
	if not manifest or not next(manifest.entries) then
		return false
	end

	manifest.entries = {}
	DEFAULT_CHAT_FRAME:AddMessage('MHM: Cleared Grudge List.')
	return true
end

function MHM:AddToPersonalManifest(player)
	if not player or not player.key then
		return false
	end

	local manifest = self:PersonalManifest()
	if manifest.entries[player.key] then
		return false
	end

	manifest.entries[player.key] = {
		guid = player.guid,
		name = player.name,
		secondaryName = player.secondaryName,
		className = player.className,
		classFile = player.classFile,
		guildName = player.guildName,
		addedAt = GetServerTime(),
	}

	DEFAULT_CHAT_FRAME:AddMessage(string.format('MHM: Added %s to Grudge List.', self:FormatPlayer(player)))
	return true
end
