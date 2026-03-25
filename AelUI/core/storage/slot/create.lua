local _, ns = ...

local SLOT_SIZE = 54

local slotCount = 0

ns.storage.slot.create = function(parent, template)
	slotCount = slotCount + 1
	local name = 'AelUIBagSlot' .. slotCount
	local slot = CreateFrame('ItemButton', name, parent, template or 'ContainerFrameItemButtonTemplate')
	slot:SetSize(SLOT_SIZE, SLOT_SIZE)
	slot:Hide()

	slot.icon = slot.icon or slot.Icon
	slot.Cooldown = slot.Cooldown or _G[name .. 'Cooldown']
	local _, bg = ns.helpers.styleIcon(slot)
	bg:SetVertexColor(0, 0, 0)

	slot.emptyBg = slot:CreateTexture(nil, 'BACKGROUND')
	slot.emptyBg:SetPoint('TOPLEFT', 2, -2)
	slot.emptyBg:SetPoint('BOTTOMRIGHT', -2, 2)
	slot.emptyBg:SetTexture([[Interface\PaperDoll\UI-Backpack-EmptySlot]])
	slot.emptyBg:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	slot.emptyBg:SetAlpha(0.85)

	slot.questIcon = slot:CreateFontString(nil, 'OVERLAY')
	slot.questIcon:SetFont(ns.media.fonts.bold.file, 30, 'THICKOUTLINE')
	slot.questIcon:SetText('!')
	slot.questIcon:SetTextColor(1, 0.82, 0)
	slot.questIcon:SetPoint('BOTTOMLEFT', slot.bd, 'BOTTOMLEFT', 2, 0)
	slot.questIcon:Hide()


	slot:SetAttribute('type2', 'item')

	slot.SetItem = function(self, state)
		self.state = state

		if state and state.hasItem then
			if self.icon then
				self.icon:SetTexture(state.icon)
				self.icon:Show()
			end

			SetItemButtonCount(self, state.count)
			self.emptyBg:Hide()

			local c = state.quality and state.quality ~= 1 and ITEM_QUALITY_COLORS[state.quality]
			if c then
				self.bd:SetBackdropBorderColor(c.r, c.g, c.b, 1)
			else
				self.bd:SetBackdropBorderColor(0, 0, 0, 1)
			end

			if self.icon then
				self.icon.isLocked = state.isLocked
				self.icon:SetDesaturated(state.isLocked)
			end

			local cd = self.Cooldown or self.cooldown
			if cd then
				CooldownFrame_Set(cd, state.cdStart or 0, state.cdDuration or 0, state.cdEnable or 0)
			end

			if state.startsQuest then
				self.questIcon:ClearAllPoints()
				self.questIcon:SetPoint('BOTTOMLEFT', self.bd, 'BOTTOMLEFT', 4, -4)
				self.questIcon:SetFont(ns.media.fonts.bold.file, 48, 'THICKOUTLINE')
				self.questIcon:Show()
			elseif state.isQuestItem then
				self.questIcon:ClearAllPoints()
				self.questIcon:SetPoint('BOTTOMLEFT', self.bd, 'BOTTOMLEFT', 2, 0)
				self.questIcon:SetFont(ns.media.fonts.bold.file, 30, 'THICKOUTLINE')
				self.questIcon:Show()
			else
				self.questIcon:Hide()
			end
		else
			self.state = { hasItem = false }

			if self.icon then self.icon:Hide() end
			SetItemButtonCount(self, 0)
			self.emptyBg:Show()
			self.bd:SetBackdropBorderColor(0, 0, 0, 1)
			self.questIcon:Hide()
			local cd = self.Cooldown or self.cooldown
			if cd then
				CooldownFrame_Set(cd, 0, 0, 0)
			end
			if self.icon then
				self.icon.isLocked = false
				self.icon:SetDesaturated(false)
			end
		end
	end

	return slot
end
