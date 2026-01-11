local _, ns = ...

ns.OnEnable(function()
	for _, c in ipairs(ns.unitframes.units) do
		local f = ns.unitframes.spawn(c.unit)
		c.style(f)
	end
end)
