local _, ns = ...

local m = ns.media

local charName = UnitName('player') .. ' - ' .. GetRealmName()

ns.storage.gold.create = function(parent)
	local frame = CreateFrame('Frame', nil, parent)
	frame:SetSize(200, 20)

	local text = frame:CreateFontString(nil, 'OVERLAY')
	text:SetFont(m.fonts.default.file, 18, 'OUTLINE')
	text:SetPoint('RIGHT', frame, 'RIGHT', 0, 0)

	frame:EnableMouse(true)
	frame:SetScript('OnEnter', function(self)
		if not ns.db then return end
		local gold = ns.db.global.gold or {}

		GameTooltip:SetOwner(self, 'ANCHOR_NONE')
		GameTooltip:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', 16, 4)
		GameTooltip:ClearLines()
		GameTooltip:AddLine('Gold')
		GameTooltip:AddLine(' ')

		local total = 0
		for name, amount in pairs(gold) do
			GameTooltip:AddDoubleLine(name, GetCoinTextureString(amount), 1, 1, 1, 1, 1, 1)
			total = total + amount
		end

		GameTooltip:AddLine(' ')
		GameTooltip:AddDoubleLine('Total', GetCoinTextureString(total), 1, 0.82, 0, 1, 1, 1)
		GameTooltip:Show()
	end)
	frame:SetScript('OnLeave', function()
		GameTooltip:Hide()
	end)

	frame.update = function(self)
		local amount = GetMoney()
		text:SetText(GetCoinTextureString(amount))
		if ns.db then
			if not ns.db.global.gold then ns.db.global.gold = {} end
			ns.db.global.gold[charName] = amount
		end
	end

	frame:RegisterEvent('PLAYER_MONEY')
	frame:SetScript('OnEvent', function(self)
		self:update()
	end)

	frame:update()

	return frame
end
