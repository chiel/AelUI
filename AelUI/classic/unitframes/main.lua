local _, ns = ...

ns.OnEnable(function()
	PlayerFrame:ClearAllPoints()
	PlayerFrame:SetPoint('RIGHT', AelUIPrimaryAnchor, 'LEFT', 0, 0)

	TargetFrame:ClearAllPoints()
	TargetFrame:SetPoint('LEFT', AelUIPrimaryAnchor, 'RIGHT', 0, 0)
end)
