local _, ns = ...

local Icon = {}
Icon.__index = Icon

ns.trackers.display.createIcon = function(width, height)
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

function Icon:Build(tracker)
	tracker:SetSize(self.width, self.height)

	self.texture = tracker:CreateTexture(nil, 'ARTWORK')
	self.texture:SetAllPoints()
	self.texture:SetTexture(self.textureId or 134400)

	self:Reset()
end
