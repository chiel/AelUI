local _, ns = ...

local Icon = {}
Icon.__index = Icon

ns.trackers.createIcon = function(width, height)
	local i = setmetatable({}, Icon)
	i:Size(width, height)

	return i
end

function Icon:Color(r, g, b, a)
	self.color = { r, g, b, a == nil and 1 or a }
end

function Icon:Desaturate(value)
	self.desaturate = value
end

function Icon:Size(width, height)
	self.width = width
	self.height = height or width
end

function Icon:Texture(texture)
	self.textureId = texture

	if self.texture then
		self.texture:SetTexture(texture)
	end
end

function Icon:Build(tracker)
	tracker.frame:SetSize(self.width, self.height)

	self.texture = tracker.frame:CreateTexture(nil, 'ARTWORK')
	self.texture:SetAllPoints()
	self.texture:SetTexture(self.textureId or 134400)

	if self.color then
		self.texture:SetVertexColor(unpack(self.color))
	end

	if self.desaturate then
		self.texture:SetDesaturated(self.desaturate)
	end
end
