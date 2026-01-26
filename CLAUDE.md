# AelUI Classic

A World of Warcraft Classic (TBC) UI addon with custom unit frames and a programmatic WeakAuras generation library.

## Key Architecture Decisions

### UI Scaling

- `AelUIParent` is scaled to `768 / screenHeight` for pixel-perfect rendering
- This gives crisp 1px borders at any resolution
- All custom UI elements parent to `AelUIParent`, not `UIParent`
- Blizzard UI remains on `UIParent` at default scale

### Unit Frames (No oUF Dependency)

Built from scratch using `SecureUnitButtonTemplate`. Key patterns:

**Callback Registry Pattern** - Elements register callbacks, central OnEvent dispatches:
```lua
f.eventCallbacks = {}
f.updaters = {}  -- Unique callbacks for Update()

f:SetScript('OnEvent', function(self, event, ...)
    if self.eventCallbacks[event] then
        for _, cb in ipairs(self.eventCallbacks[event]) do
            cb(self, event, ...)
        end
    end
end)

f.RegisterCallback = function(self, event, cb)
    if not self.eventCallbacks[event] then
        self.eventCallbacks[event] = {}
        self:RegisterUnitEvent(event, f.unit)
    end
    table.insert(self.eventCallbacks[event], cb)
    f.updaters[cb] = true  -- Track unique callbacks
end

f.Update = function(self)
    for cb in pairs(self.updaters) do
        cb(self)
    end
end
```

**Element Pattern** - Elements are functions that take a frame and set themselves up:
```lua
ns.unitframes.elements.healthbar = function(f)
    local bd, bg = h.createBackdrop(f)
    local bar = CreateFrame('StatusBar', nil, bd)
    -- ... setup ...

    local function update(self)
        -- update logic using self.unit
    end

    f:RegisterCallback('UNIT_HEALTH', update)  -- Also adds to f.updaters

    update(f)  -- Initial update for always-visible frames

    return bd
end
```

**What's Implemented:**
- `spawn.lua`: Creates frames with SecureUnitButtonTemplate, RegisterUnitWatch, click handling
- `healthbar.lua`: Health bar with class colors for players
- `powerbar.lua`: Power bar with power type colors
- `castbar.lua`: Cast bar with GCD support (player only)
- `player.lua` / `target.lua`: Unit-specific styling

**Target/Focus Frame Support (Implemented):**
- `updaters` table stores unique update callbacks (using callback as key for deduplication)
- `Update()` method iterates over `updaters` and calls each callback
- `OnShow` script calls `Update()` when `RegisterUnitWatch` shows the frame
- Unit-specific events (`PLAYER_TARGET_CHANGED`, `PLAYER_FOCUS_CHANGED`) trigger `Update()`
- Note: `OnShow` only fires when transitioning hidden→shown; always-visible frames (player) need manual initial update in elements

**Party/Raid Frames (Future):**
- Will need `SecureGroupHeaderTemplate` for dynamic spawning
- `GROUP_ROSTER_UPDATE` with GUID tracking for unit changes
- Or simpler: spawn individual `party1`-`party4` frames with RegisterUnitWatch

**Castbar Design:**
- Follows "query current state" philosophy - always queries `UnitCastingInfo()`/`UnitChannelInfo()` from the game rather than tracking state manually
- Single `update` function handles all events, checking cast → channel → GCD in priority order
- `OnUpdate` script animates smoothly using stored start/end times and `GetTime()`
- GCD detection (player only) uses spell ID `29515` (works in Classic/TBC via `GetSpellCooldown`)
- Supports optional `onUpdate` callback for dynamic styling:
  ```lua
  local castbar = e.castbar(f, {
      onUpdate = function(bd, state)
          -- state has: gcd, channeling, casting booleans
          bd:SetHeight(state.gcd and 6 or 16)
      end,
  })
  ```
- Channels and GCD deplete (fill reversed), casts fill normally
- Hides default `PlayerCastingBarFrame` when created for player unit

**Special Casts (Not Yet Implemented):**
- Hunter's Aimed Shot and Multi-Shot don't fire normal `UNIT_SPELLCAST_*` events in Classic/TBC
- oUF/ElvUI handles this by intercepting `UNIT_SPELLCAST_SENT` and checking spell IDs against a hardcoded list with known cast times
- Could be added later if needed

### createBackdrop Helper

Returns `backdrop, background` - caller controls positioning:
```lua
local bd, bg = h.createBackdrop(parent)
bd:SetPoint(...)  -- Caller positions
bd:SetSize(...)
```

Does NOT call `SetAllPoints()` to avoid anchor conflicts.

## LibWA (WeakAuras Generation)

Programmatic API for generating WeakAuras import tables. Not a WeakAuras replacement - generates tables that WeakAuras can import.

Namespace structure:
- `ns.libwa.animations`
- `ns.libwa.conditions`
- `ns.libwa.display`
- `ns.libwa.load`
- `ns.libwa.triggers`

## WoW API Notes

- `RegisterUnitEvent(event, unit)` does NOT accept callbacks - only subscribes to events
- Must use `SetScript('OnEvent', handler)` separately
- oUF overrides `RegisterEvent` to accept callbacks - we use a similar pattern via `RegisterCallback`
- `RegisterUnitWatch(frame)` auto shows/hides based on `UnitExists(frame.unit)`
- Click attributes: `*type1` (left click), `*type2` (right click) - asterisk propagates to children
- `togglemenu` opens unit dropdown menu
- `OnUpdate` script fires every frame only while the frame is **shown** - hidden frames don't receive OnUpdate calls
- `GetSpellCooldown(spellID)` works on any spell ID, even ones you don't have learned - useful for GCD detection

## oUF Analysis Reference

oUF's flow: `Spawn` → `walkObject` → `initObject` → `HandleUnit` → `EnableElement`

Key oUF concepts we adapted:
- `updaters` table for storing unique update functions (oUF uses `__elements` array)
- `Update()` iterating through them (oUF uses `UpdateAllElements`)
- `OnShow` triggering full update
- Unit-specific events (`PLAYER_TARGET_CHANGED`, etc.)

oUF features we DON'T need:
- Vehicle swapping (TBC doesn't have vehicle UI)
- Multiple style registration (single addon)
- Element enable/disable tracking (just don't create them)
- Arena prep handling (not in Classic)
- Eventless unit polling (not doing boss frames/nameplates yet)

## File Locations

- Main addon: `/home/chiel/dev/aelUI-classic/AelUI/`
- Retail version (reference): `/home/chiel/dev/aelUI/`

## Common Issues Encountered

1. **SetAllPoints conflicts**: Calling SetPoint after SetAllPoints ADDS anchors. Remove SetAllPoints or clear points first.

2. **Tooltip errors**: `UnitFrame_OnEnter` expects `frame.unit` property, not just the attribute. Set both:
   ```lua
   f.unit = unit
   f:SetAttribute('unit', unit)
   ```

3. **Wrong directory**: Classic is `aelUI-classic`, retail is `aelUI`. Check which you're editing.

4. **Event callbacks misconception**: Native WoW `RegisterEvent`/`RegisterUnitEvent` don't accept callbacks. Need wrapper pattern.

5. **Dynamic texture sizing**: Textures can use multiple anchor points like frames. Use `SetWidth()` + two vertical anchors instead of `SetSize()` when height should be dynamic:
   ```lua
   texture:SetWidth(16)
   texture:SetPoint('TOP', parent, 'TOPRIGHT', 0, 0)
   texture:SetPoint('BOTTOM', parent, 'BOTTOMRIGHT', 0, 0)
   ```

6. **Clipping overflow**: Use `frame:SetClipsChildren(true)` to hide child elements that extend beyond frame bounds.

7. **UnitPowerMax returns 0 for distant targets**: When calling `UnitPowerMax(unit)` without a power type argument, it returns 0 for targets that are far away. Fix by passing the power type explicitly:
   ```lua
   local powerType = UnitPowerType(self.unit)
   local current = UnitPower(self.unit, powerType)
   local max = UnitPowerMax(self.unit, powerType)
   ```
   Note: `UnitHealthMax` does not have this issue - health data is always available for targeted units.
