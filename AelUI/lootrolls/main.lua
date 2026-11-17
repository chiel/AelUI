local _, ns = ...

local AelEvents = LibStub('AelEvents-1.0')

local FRAME_WIDTH = 500
local FRAME_HEIGHT = 40
local FRAME_SPACING = 20

local container = CreateFrame('Frame', 'AelUILootRollContainer', AelUIParent)
container:SetPoint('BOTTOMRIGHT', AelUIPrimaryAnchor, 'TOPLEFT', -200, 320)
container:SetSize(FRAME_WIDTH, FRAME_HEIGHT)

local slots = {}
local activeRolls = {}

local function dismissRoll(frame)
	local roll = frame.roll
	if roll and activeRolls[roll.rollID] == frame then
		activeRolls[roll.rollID] = nil
	end
	frame:Hide()
	frame.roll = nil
	frame.rollID = nil
end

local function showRoll(roll)
	local slotIndex = 1
	while slots[slotIndex] and slots[slotIndex]:IsShown() do
		slotIndex = slotIndex + 1
	end

	local frame = slots[slotIndex]
	if not frame then
		frame = ns.lootrolls.createRollFrame(container)
		frame.slotIndex = slotIndex
		frame:SetPoint('BOTTOMLEFT', container, 'BOTTOMLEFT', 0, (slotIndex - 1) * (FRAME_HEIGHT + FRAME_SPACING))
		local function onClick(button)
			if not frame.roll then
				return
			end
			-- Keep the slot until cancellation, including while a
			-- Blizzard confirmation dialog is waiting for an answer.
			RollOnLoot(frame.rollID, button:GetID())
		end
		frame.needBtn:SetScript('OnClick', onClick)
		frame.greedBtn:SetScript('OnClick', onClick)
		frame.passBtn:SetScript('OnClick', onClick)
		slots[slotIndex] = frame
	end

	frame:ApplyRoll(roll)
	activeRolls[roll.rollID] = frame
	frame:Show()
end

-- Replace normal roll prompts, but retain Blizzard's confirmations and special rolls.
GameEvent.UnregisterInternalEvent('START_LOOT_ROLL')
GameEvent.UnregisterInternalEvent('CANCEL_LOOT_ROLL')

AelEvents.on('START_LOOT_ROLL', function(_, rollID, rollTime)
	if activeRolls[rollID] then
		return
	end

	local texture, name, count, quality, bindOnPickUp, canNeed, canGreed, _, _, _, _, _, canTransmog =
		GetLootRollItemInfo(rollID)
	if not name then
		return
	end

	local duration = C_DurationUtil.CreateDuration()
	duration:SetTimeFromStart(GetTime(), rollTime / 1000)

	showRoll({
		rollID = rollID,
		texture = texture,
		name = name,
		count = count,
		quality = quality,
		bindOnPickUp = bindOnPickUp,
		canNeed = canNeed,
		canGreed = canGreed,
		canTransmog = canTransmog,
		duration = duration,
	})
end)

AelEvents.on('CANCEL_LOOT_ROLL', function(_, rollID)
	local frame = activeRolls[rollID]
	if frame then
		dismissRoll(frame)
	end
end)

AelEvents.on('CANCEL_ALL_LOOT_ROLLS', function()
	for _, frame in pairs(activeRolls) do
		dismissRoll(frame)
	end
end)
