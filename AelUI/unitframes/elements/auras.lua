local _, ns = ...

local m = ns.media

ns.unitframes.elements.auras = function(f, options)
	local o = options or {}

	if not C_AddOns.IsAddOnLoaded('Blizzard_AuraContainer') then
		C_AddOns.LoadAddOn('Blizzard_AuraContainer')
	end

	local container = CreateFrame('AuraContainer', nil, f, 'CustomAuraContainerTemplate')
	container:SetSize(1, 1)
	container:SetFlowLayoutAnchorPoint(o.initialAnchor or 'TOPLEFT')
	container:SetFlowLayoutAxis(o.layout or AnchorUtil.FlowLayoutAxis.Horizontal)
	container:SetFlowLayoutMaximumLineSize(o.layoutLimit or f:GetWidth())
	container:SetFlowLayoutGrowthDirection((o.growthX == 'LEFT' and -1) or 1, (o.growthY == 'DOWN' and -1) or 1)
	container:SetFlowLayoutPadding(0, 0, 0, 0)

	local initialized = false
	local function update(self)
		if container:GetUnit() ~= self.unit then
			container:SetUnit(self.unit)
		else
			container:UpdateAllAuras()
		end
	end

	f:RegisterCallback('UNIT_AURA', update)

	function container:AddGroup(key, filter, options)
		local group = options or {}
		local size = group.size or o.size or 20
		local font = group.font or o.font or m.fonts.bold.file
		local fontSize = group.fontSize or o.fontSize or 18
		local showProgress = group.showProgress or o.showProgress
		local showStacks = group.showStacks or o.showStacks
		local showDispelBorder = group.showDispelBorder
		if showDispelBorder == nil then
			showDispelBorder = filter:find('HARMFUL', 1, true) ~= nil
		end

		self:AddAuraGroup(key, filter, {
			maxFrameCount = group.maxFrameCount,
			layout = {
				elementSpacing = group.spacing or o.spacing or 1,
				lineSpacing = group.lineSpacing or o.lineSpacing or group.spacing or o.spacing or 1,
				groupSpacing = group.groupSpacing or o.groupSpacing or 0,
				groupLineSpacing = group.groupLineSpacing or o.groupLineSpacing or 0,
				forceNewLine = group.forceNewLine,
			},
			initializeFrame = function(button)
				button:SetSize(size, size)
				button:EnableMouse(true)

				local icon = button:CreateTexture(nil, 'BORDER')
				icon:SetAllPoints()
				button:SetIcon(icon)

				local cooldown = CreateFrame('Cooldown', nil, button, 'CooldownFrameTemplate')
				cooldown:SetAllPoints()
				cooldown:SetDrawSwipe(true)
				cooldown:SetDrawEdge(false)
				cooldown:SetHideCountdownNumbers(true)
				cooldown:SetReverse(true)
				button:SetDurationCooldown(cooldown)

				local border = CreateFrame('Frame', nil, button, 'BackdropTemplate')
				border:SetAllPoints()
				border:SetFrameLevel(cooldown:GetFrameLevel() + 1)
				border:SetBackdrop({ edgeFile = m.borders.default.file, edgeSize = 1 })
				border:SetBackdropBorderColor(0, 0, 0, 1)

				if showDispelBorder then
					local dispelBorder = border:CreateTexture(nil, 'OVERLAY')
					dispelBorder:SetAllPoints()
					button:AddDispelTypeTexture(dispelBorder, {
						style = Enum.CustomAuraButtonDispelTypeTextureStyle.Border,
						showWhenHarmful = true,
					})
				end

				if showProgress or showStacks then
					local textFrame = CreateFrame('Frame', nil, button)
					textFrame:SetAllPoints()
					textFrame:SetFrameLevel(border:GetFrameLevel() + 1)

					if showProgress then
						local progress = textFrame:CreateFontString(nil, 'OVERLAY')
						progress:SetPoint('BOTTOM', 0, -2)
						progress:SetFont(font, fontSize, 'OUTLINE')
						button:SetDurationText(progress, { textFormatter = ns.formatters.duration })
					end

					if showStacks then
						local stacks = textFrame:CreateFontString(nil, 'OVERLAY')
						stacks:SetPoint('TOPRIGHT', 0, -2)
						stacks:SetFont(font, fontSize, 'OUTLINE')
						button:SetApplicationCount(stacks)
					end
				end
			end,
		})

		if initialized then
			self:UpdateAllAuras()
		else
			initialized = true
			update(f)
			self:SetEnabled(true)
		end
	end

	return container
end
