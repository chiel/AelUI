local _, ns = ...

local m = ns.media

ns.storage.gold.create = function(parent)
	local frame = CreateFrame('Frame', nil, parent)
	frame:SetSize(200, 20)

	local text = frame:CreateFontString(nil, 'OVERLAY')
	text:SetFont(m.fonts.default.file, 18, 'OUTLINE')
	text:SetPoint('RIGHT', frame, 'RIGHT', 0, 0)

	frame:EnableMouse(true)
	frame:SetScript('OnEnter', function(self)
		if not ns.db or not ns.db.global.characters then return end

		GameTooltip:SetOwner(self, 'ANCHOR_NONE')
		GameTooltip:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', 16, 4)
		GameTooltip:ClearLines()
		GameTooltip:AddLine('Gold')
		GameTooltip:AddLine(' ')

		local total = 0
		local sorted = {}
		for _, data in pairs(ns.db.global.characters) do
			if data.money and data.money > 0 then
				sorted[#sorted + 1] = data
			end
		end
		table.sort(sorted, function(a, b) return a.name < b.name end)

		for _, data in ipairs(sorted) do
			local displayName = data.name
			if data.realm ~= ns.chardata.charRealm then
				displayName = displayName .. ' - ' .. data.realm
			end

			local classColor = RAID_CLASS_COLORS[data.class]
			local r, g, b = 1, 1, 1
			if classColor then r, g, b = classColor.r, classColor.g, classColor.b end

			GameTooltip:AddDoubleLine(displayName, GetCoinTextureString(data.money), r, g, b, 1, 1, 1)
			total = total + data.money
		end

		GameTooltip:AddLine(' ')
		GameTooltip:AddDoubleLine('Total', GetCoinTextureString(total), 1, 0.82, 0, 1, 1, 1)
		GameTooltip:Show()
	end)
	frame:SetScript('OnLeave', function()
		GameTooltip:Hide()
	end)

	frame.update = function(self)
		text:SetText(GetCoinTextureString(GetMoney()))
	end

	frame:RegisterEvent('PLAYER_MONEY')
	frame:SetScript('OnEvent', function(self)
		self:update()
	end)

	frame:update()

	return frame
end
