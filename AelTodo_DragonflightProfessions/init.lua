print('AelTodo_DragonflightProfessions: init.lua')

-- local f = CreateFrame('Frame')
-- f:RegisterEvent('CURRENCY_DISPLAY_UPDATE')
-- f:RegisterEvent('LOOT_CLOSED')
-- f:RegisterEvent('PLAYER_ENTERING_WORLD')
-- f:RegisterEvent('QUEST_TURNED_IN')
-- f:RegisterEvent('STATUS')
-- f:RegisterEvent('AEL_TODO_DRAGONFLIGHT_PROFESSIONS_UPDATE')

-- f:SetScript('OnEvent', function(event, ...)
-- 	-- knowledge points are treated as currencies, there is no `QUEST_TURNED_IN` event
-- 	-- associated with using a treatise, nor is the hidden quest immediately marked as
-- 	-- completed by `IsQuestFlaggedCompleted`, so instead I set a timer for 1 second
-- 	-- and fire a fake event which re-triggers this function and causes a full update
-- 	if event == 'CURRENCY_DISPLAY_UPDATE' then
-- 		local currency = select(1, ...)
-- 		if aura_env.knowledgePointCurrencies[currency] then
-- 			C_Timer.After(1, function()
-- 				WeakAuras.ScanEvents('AEL_TODO_DRAGONFLIGHT_PROFESSIONS_UPDATE')
-- 			end)
-- 		end

-- 		return
-- 	end

-- 	-- profession items that are looted will trigger a hidden quest, so we need to
-- 	-- check if the associated quest is available. Similar to above, there can be a
-- 	-- delay so we just schedule the re-check
-- 	if event == 'LOOT_CLOSED' then
-- 		C_Timer.After(1, function()
-- 			WeakAuras.ScanEvents('AEL_TODO_DRAGONFLIGHT_PROFESSIONS_UPDATE')
-- 		end)
-- 	end

-- 	local turnedInQuest = nil
-- 	if event == 'QUEST_TURNED_IN' then
-- 		turnedInQuest = select(1, ...)
-- 	end

-- 	local profMap = {}
-- 	local profNames = {}
-- 	local prof1, prof2 = GetProfessions()
-- 	for _, profIndex in ipairs({ prof1, prof2 }) do
-- 		if profIndex == nil then
-- 			break
-- 		end

-- 		local name, icon, skillLevel, _, _, _, skillLine = GetProfessionInfo(profIndex)
-- 		profMap[name] = {
-- 			name = name,
-- 			icon = icon,
-- 			skillLevel = skillLevel,
-- 			skillLine = skillLine,
-- 		}
-- 		table.insert(profNames, name)
-- 	end

-- 	table.sort(profNames)

-- 	local sections = {}

-- 	local entries = AelTodoProcessEntries(aura_env.generalEntries, turnedInQuest)
-- 	if #entries > 0 then
-- 		table.insert(sections, { name = 'Professions', entries = entries })
-- 	end

-- 	for _, profName in ipairs(profNames) do
-- 		local prof = profMap[profName]
-- 		local rawEntries = aura_env.entriesByProfession[prof.skillLine]
-- 		local entries = AelTodoProcessEntries(rawEntries, turnedInQuest)

-- 		if #entries > 0 then
-- 			table.insert(sections, { name = prof.name, entries = entries })
-- 		end
-- 	end

-- 	local plugin = {
-- 		name = 'Dragonflight Professions',
-- 		priority = 'MEDIUM',
-- 		sections = sections,
-- 	}

-- 	WeakAuras.ScanEvents('AEL_TODO_UPDATE', 'dragonflight_professions', plugin)
-- end)
