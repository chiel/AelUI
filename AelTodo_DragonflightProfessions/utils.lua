local addon = select(2, ...)

addon.utils = {}

addon.utils.getProfessionSkill = function(requestedSkillLine)
	local info = C_TradeSkillUI.GetProfessionInfoBySkillLineID(requestedSkillLine)
	if info.skillLevel > 0 then
		return info.skillLevel
	end

	local prof1, prof2 = GetProfessions()
	for _, profIndex in ipairs({ prof1, prof2 }) do
		if profIndex == nil then
			return 0
		end

		local _, _, skillLevel, _, _, _, skillLine = GetProfessionInfo(profIndex)
		if skillLine == requestedSkillLine then
			return skillLevel
		end
	end

	return 0
end
