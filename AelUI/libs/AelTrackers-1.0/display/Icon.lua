local lib = LibStub('AelTrackers-1.0')

local Icon = {}
Icon.__index = Icon

lib.display.createIcon = function(width, height)
	local i = setmetatable({}, Icon)
	i:Size(width, height)

	return i
end

function Icon:Color(color, override)
	if not override then
		self.color = color
	end

	if self.texture then
		self.texture:SetVertexColor(unpack(color))
	end
end

function Icon:Cooldown(cooldown)
	self.cooldown = cooldown
end

function Icon:CooldownDuration(duration)
	if not self.cooldownFrame then
		return
	end

	if duration ~= nil then
		self.cooldownFrame:SetCooldownFromDurationObject(duration)
	else
		self.cooldownFrame:Clear()
	end
end

function Icon:Desaturate(desaturate, override)
	if not override then
		self.desaturate = desaturate
	end

	if self.texture then
		self.texture:SetDesaturated(desaturate)
	end
end

function Icon:Size(width, height)
	self.width = width
	self.height = height or width
end

function Icon:Texture(texture, override)
	if not override then
		self.textureId = texture
	end

	if self.texture then
		self.texture:SetTexture(texture)
	end
end

function Icon:Reset()
	self.texture:SetVertexColor(unpack(self.color or { 1, 1, 1, 1 }))
	self.texture:SetDesaturated(self.desaturate or false)
end

function Icon:Build(tracker, level)
	tracker:SetSize(self.width, self.height)

	self.frame = CreateFrame('Frame', nil, tracker)
	self.frame:SetPoint('TOPLEFT')
	self.frame:SetSize(self.width, self.height)
	self.frame:SetFrameLevel(level)

	self.texture = self.frame:CreateTexture(nil, 'ARTWORK')
	self.texture:SetAllPoints()
	self.texture:SetTexture(self.textureId or 134400)

	if self.cooldown then
		local cd = CreateFrame('Cooldown', nil, self.frame, 'CooldownFrameTemplate')
		cd:SetAllPoints()
		cd:SetDrawSwipe(true)
		cd:SetSwipeColor(0, 0, 0, 0.7)
		cd:SetDrawEdge(false)
		cd:SetHideCountdownNumbers(true)
		cd:Show()
		self.cooldownFrame = cd
	end

	self:Reset()
end
