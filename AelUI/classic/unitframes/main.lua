local _, ns = ...

ns.OnEnable(function()
	PlayerFrame:ClearAllPoints()
	PlayerFrame:SetPoint('RIGHT', AelUIPrimaryAnchor, 'LEFT', -20, -100)

	TargetFrame:ClearAllPoints()
	TargetFrame:SetPoint('LEFT', AelUIPrimaryAnchor, 'RIGHT', 20, -100)
end)
