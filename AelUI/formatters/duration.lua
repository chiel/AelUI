local _, ns = ...

local fmt = C_StringUtil.CreateNumericRuleFormatter()
fmt:SetBreakpoints({
	{ threshold = 0, format = '%d', step = 1, rounding = Enum.NumericRuleFormatRounding.Up },
	{
		threshold = 60,
		format = '%d:%02d',
		step = 1,
		rounding = Enum.NumericRuleFormatRounding.Up,
		components = {
			{ div = 60 },
			{ mod = 60 },
		},
	},
	{
		threshold = 600,
		format = '%dm',
		step = 1,
		rounding = Enum.NumericRuleFormatRounding.Down,
		components = { { div = 60 } },
	},
	{
		threshold = 3600,
		format = '%dh',
		step = 1,
		rounding = Enum.NumericRuleFormatRounding.Down,
		components = { { div = 3600 } },
	},
})

ns.formatters.duration = fmt
