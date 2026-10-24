local _, ns = ...

local h = ns.fishing.helpers

local LURES = {
	{ 6529, 25 }, --  Shiny Bauble
	{ 6530, 50 }, --  Nightcrawlers
	{ 6532, 75 }, --  Bright Baubles
	{ 6533, 100 }, -- Aquadynamic Fish Attractor
}

local Angler = {}

ns.fishing.createAngler = function()
	local angler = CreateFrame('Frame', nil, AelUIParent)
	Mixin(angler, Angler)
	angler:Hide()

	return angler
end

function Angler:Build()
	if self.castBtn then
		return
	end

	local castBtn = h.createButton('AelUIFishingButton', 60, self)
	castBtn:SetPoint('BOTTOMRIGHT', 0, 0)
	castBtn:SetAttribute('type', 'spell')
	castBtn:SetAttribute('spell', 7620)
	castBtn.texture:SetTexture(C_Spell.GetSpellTexture(7620))

	castBtn:SetScript('OnEnter', function(self)
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:SetSpellByID(7620)
		GameTooltip:Show()
	end)

	castBtn:SetScript('OnLeave', function()
		GameTooltip:Hide()
	end)

	self.castBtn = castBtn
end

function Angler:Disable()
	if not self:IsShown() then
		return
	end

	self:Hide()
end

function Angler:Enable()
	if self:IsShown() then
		return
	end

	self:Build()
	self:UpdateLures()
	self:SetSize(1, 1)
	self:Show()
end

function Angler:GetLureButton(id)
	local btn = self.lureButtons[id]
	local count = C_Item.GetItemCount(id)
	if count == 0 then
		if btn then
			btn:Hide()
		end
		return
	end

	if not btn then
		local icon = C_Item.GetItemIconByID(id)
		if not icon then
			return
		end

		btn = h.createButton('AelUIFishingLureButton' .. id, 50, self)
		btn:SetAttribute('type', 'macro')
		btn:SetAttribute('macrotext', '/use item:' .. id .. '\n/use 16')
		btn.texture:SetTexture(icon)
		self.lureButtons[id] = btn
	end

	btn.stacks:SetText(count)

	return btn
end

function Angler:UpdateLures()
	self.lureButtons = self.lureButtons or {}
	local visibleLures = 0

	for _, lure in ipairs(LURES) do
		local id, bonus = unpack(lure)
		local btn = self:GetLureButton(id)
		if btn then
			btn:SetPoint('BOTTOMRIGHT', -(62 + (visibleLures * 52)), 0)
			btn:Show()
			visibleLures = visibleLures + 1
		end
	end
end
