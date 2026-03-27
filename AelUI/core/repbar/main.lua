local _, ns = ...

local s = ns.repbar

local function render() s.render(s.getData()) end

local handler = CreateFrame('Frame')
handler:RegisterEvent('UPDATE_FACTION')
handler:SetScript('OnEvent', function() render() end)

ns.OnEnable(function() render() end)

local trackingBar = StatusTrackingBarManager or ReputationWatchBar
if trackingBar ~= nil then
	trackingBar:UnregisterAllEvents()
	trackingBar:Hide()
end
