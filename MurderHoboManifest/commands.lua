local _, MHM = ...

local dialogKey = 'MHM_PERSONAL_MANIFEST'

StaticPopupDialogs[dialogKey] = {
	text = '%s\n\n%s',
	button1 = 'Clear List',
	button2 = CLOSE,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	enterClicksFirstButton = false,
	preferredIndex = 3,
	OnAccept = function()
		MHM:ClearPersonalManifest()
	end,
}

function MHM:ShowPersonalManifest()
	local manifest = self:GetPersonalManifest()
	local name = manifest and manifest.name or 'Grudge List'
	if not manifest or not next(manifest.entries) then
		StaticPopup_Show(dialogKey, name, 'No one is on your grudge list yet.')
		return
	end

	local entries = {}
	for _, entry in pairs(manifest.entries) do
		table.insert(entries, entry)
	end

	table.sort(entries, function(left, right)
		return self:PlayerName(left) < self:PlayerName(right)
	end)

	local lines = {}
	for _, entry in ipairs(entries) do
		table.insert(lines, string.format('• %s', self:FormatPlayer(entry)))
	end

	StaticPopup_Show(dialogKey, name, table.concat(lines, '\n'))
end

SLASH_MURDERHOBOMANIFEST1 = '/mhm'
SlashCmdList.MURDERHOBOMANIFEST = function()
	MHM:ShowPersonalManifest()
end
