local _, ns = ...

ns.OnEnable(function()
	ns.options.addSection('actionbars', {
		type = 'group',
		name = 'Action Bars',
		args = {
			showBars = {
				type = 'toggle',
				name = 'Show hidden action bars',
				desc = 'Show the main action bar, bottom bars, and stance bar',
				get = function() return ns.db.char.actionbars.showBars end,
				set = function(_, val)
					ns.db.char.actionbars.showBars = val
				end,
			},
		},
	})
end)
