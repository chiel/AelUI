local _, ns = ...

ns.OnEnable(function()
	for _, fn in ipairs(ns.unitframes.units) do
		fn()
	end
end)
