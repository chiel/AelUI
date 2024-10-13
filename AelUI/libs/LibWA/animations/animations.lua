local _, addon = ...

addon.animations = {}

addon.animations.Create = function()
	local aura = {}

	aura.Finish = function(self, ...)
		self.finish = addon.animations.CreateAnimation('finish', ...)
	end

	aura.Main = function(self, ...)
		self.main = addon.animations.CreateAnimation('main', ...)
	end

	aura.Start = function(self, ...)
		self.start = addon.animations.CreateAnimation('start', ...)
	end

	aura.Serialize = function(self)
		local r = {}

		if self.finish ~= nil or self.main ~= nil or self.start ~= nil then
			r.animation = {}
		end

		if self.finish ~= nil then
			r.animation.finish = self.finish:Serialize()
		end

		if self.main ~= nil then
			r.animation.main = self.main:Serialize()
		end

		if self.start ~= nil then
			r.animation.start = self.start:Serialize()
		end

		return r
	end

	return aura
end
