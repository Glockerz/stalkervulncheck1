# STALKER — Security / Anti-Dupe Audit

**Date:** 2026-09-09
**Scope:** `STALKER1/` export (859 Lua files). **Important:** this dump contains **client-side code only**.
`ServerScriptService` / `ServerStorage` are empty and every `.server.lua` is a
`[FilteringEnabled] Server Scripts are IMPOSSIBLE to save` stub — i.e. this is a
SynSaveInstance-style copy. The server could **not** be audited directly.

So this report audits the **client → server trust boundary**: every RemoteEvent /
RemoteFunction / BridgeNet bridge the client fires, what data the client controls,
and exactly which server-side validations must exist. Each finding includes a
concrete exploit scenario and a copy-paste test snippet you can run with an
executor to verify whether your server is actually protected.

**Method:** traced all ~170 `FireServer` / `InvokeServer` call sites and all
BridgeNet bridges outside vendored packages, plus remote inventory from
`ReplicatedStorage/Remotes.json`, `TaskRemotes`, `SquadRemotes`, `PdaRemotes`,
`ContactRemotes`, `ReplecsRemotes`, `JABBY_REMOTES`.

---

## Severity key

- 🔴 **CRITICAL** — likely live exploit if the server trusts the client; test first.
- 🟠 **HIGH** — classic dupe/economy-break pattern; needs a server mutex or check.
- 🟡 **MEDIUM** — needs validation/rate-limiting; limited or situational impact.
- 🟢 **LOW / OK** — checked, looks sane, or minor hardening note.

---

## 🔴 CRITICAL

### C1. Admin remotes are gated client-side — verify server re-checks rank
**Remotes:** `AdminSpawnItem` (Event), `AdminRunCommand` (Event),
`AdminWipeRequest` (Event), `AdminListItems` (Function)
**Client:** `StarterPlayerScripts/AdminSpawnerClient.client.lua`,
`ModeratorPanelClient.client.lua`

The client hides the panel unless `UserId ∈ {68620354, 184460696, 102248765}` or
group `9949403` rank ≥ 180 — but any exploiter can fire the remotes directly:

```lua
local R = game:GetService("ReplicatedStorage").Remotes
R.AdminSpawnItem:FireServer("SOME_ITEM_ID", 999)          -- item spawn
R.AdminRunCommand:FireServer("addroubles", {"1000000"})   -- money
R.AdminRunCommand:FireServer("ban", {"victim", "perm"})   -- ban anyone
R.AdminWipeRequest:FireServer("name", 12345, "reason")     -- wipe data
print(R.AdminListItems:InvokeServer())                    -- item list leak
```

**Commands found in the client:** `grant, reset, clearskins, addroubles, roubles,
stash, heal, god, tp, bring, time, barter, tutorial, mutant, where, daily,
supporterlog, pdatest, find, inspect, freeze, unfreeze, mute, unmute, kick, ban,
unban`, plus a free-text box that fires **any** command string.

**Exploit if unprotected:** item spawning, infinite roubles, god mode, teleport,
banning arbitrary players, data wipes — full game takeover from any account.

**Fix:** every one of these handlers must independently verify
`player:GetRankInGroup(9949403) >= 180` (or allowlist) **on the server** before
doing anything. Never trust the client's `isAdmin()`. Consider removing the
free-text command box path entirely.

---

### C2. `DropItem` / `DiscardItem` / `ContextMenuAction` send a client-chosen item ID
**Client:** `ReplicatedStorage/InventoryController.lua` (lines ~2039, 6677–6763,
7608, 7684, 7709, 7885)

```lua
Remotes.DropItem:FireServer(itemIndex, tiedInstance, itemID)   -- ID from client!
Remotes.DiscardItem:FireServer(itemIndex, tiedInstance, itemID)
Remotes.ContextMenuAction:FireServer("Take"|"Equip", itemIndex, tiedInstance, itemID)
```

**Exploit if the server uses the passed ID:** drop/equip/take a worthless item but
claim it's a rare one —

```lua
R.DropItem:FireServer(myJunkIndex, "Main_12345", "TOP_TIER_GUN_ID")
```

— i.e. **item transmutation / spawning**. Test by dropping junk with a forged ID
and seeing what spawns in the world.

**Fix:** server must resolve the item **solely by `(owner, tiedInstance,
itemIndex)` from its own inventory state** and ignore (or only cross-check) the
client-sent ID. Same rule for every remote that takes `index + id`.

---

### C3. `DropRoubles(amount)` — negative / unfunded drops = money from thin air
**Client:** `StarterPlayerScripts/RoubleHUD.client.lua` — client checks `> 0`, but
that's bypassable:

```lua
R.DropRoubles:FireServer(-1000000)   -- if server does balance -= amount → +1M
R.DropRoubles:FireServer(999999999)  -- if server doesn't check funds → free cash pickup
```

**Exploit if unprotected:** infinite money, solo, in 2 lines.

**Fix:** server must enforce `amount` is a positive integer **and** `amount <=
balance`, then debit atomically (inside the inventory mutex, see H1) before
spawning the pickup.

---

### C4. Gun combat sends the whole `ModTable` (damage / fire-rate / velocity) to the server
**Bridges:** `PlayerFire(muzzleCFrame, modTable)`, `BulletHit(tool, hit, muzzleCFrame, modTable)`
**Client:** `SPH_Character/CharacterClient.client.lua` (~line 3096),
`SPH_Assets/Modules/BulletHandler.lua` (`t.FireBullet`, `RayHit` handler),
`SPH_Assets/Modules/ModTable.lua`

`ModTable` is built client-side from attachments and contains **gameplay stats**:

```lua
damage = { Head = 1, Torso = 1, Other = 1 },
fireRate = 1, muzzleVelocity = ..., armorPenMultiplier = ...,
ammoType = ..., shotgunPellets = ..., magazineCapacity/maxAmmoPool = ...
```

**Exploit if the server reads any of these fields:** set
`damage.Head = 9999`, `fireRate = 0.01`, `muzzleVelocity = 99999` before firing →
one-shot / minigun / infinite-range. Even if damage is server-side, hit
registration is **client hitreg** — the client reports `{Position, Normal,
Instance}` — so a silent-aim script can do:

```lua
-- fire BulletHit with victim's Head as Instance from anywhere
bulletHitBridge:Fire(myTool, {Position=..., Normal=..., Instance=victimHead}, cf, modTable)
```

**Fix (server):**
1. **Ignore all gameplay fields in client-sent ModTable.** Recompute damage /
   fire-rate / velocity / pellets / pen from `WeaponStats` + the attachments the
   *server* believes are equipped.
2. Validate every `BulletHit`: shooter alive & owns/has-equipped that exact Tool;
   per-weapon **rate limit** (server clock, not client timing); **distance cap**
   from muzzle to hit position; **line-of-sight raycast** (no through-wall hits);
   ammo actually consumed on the server per shot (see C6).
3. Never trust `shotgunPellets`/hit-count from the client.

---

### C5. Melee is client hitreg with no visible server validation
**Remotes (per melee Tool):** `RemoteEventMelee(hitPart, hitPos, hitNormal)`,
`ConnectM6D(handle)`, `DisconnectM6D(handle)`, `SwingStart/SwingEnd`
**Client:** `MeleeSystemReplicated/ClientMelee.lua`

Client raycasts with RaycastHitbox and reports whatever part it touched, up to
`consecutiveHits`. Exploiter fires the remote with any part in the map:

```lua
tool.Remotes.RemoteEventMelee:FireServer(victimHead, victimHead.Position, Vector3.yAxis)
```

Also `ConnectM6D:FireServer(anyHandle)` welds things server-side — must validate
the handle belongs to the sender's equipped melee.

**Fix:** server must check sender owns & has the melee equipped, enforce cooldown
from server clock, distance check (≤ reach + slack), LOS check, and cap hits per
swing. Validate `ConnectM6D` ownership.

---

### C6. Ammo authority is unclear — verify the server decrements per shot
No client-side `MagAmmo.Value -= 1` was found in `CharacterClient` (good sign —
decrement is probably server-side on `PlayerFire`). But it must be verified:

- `Reload(ModTable)`, `PlayerChamber()`, `MoveBolt`, `MagGrab` carry client data.
- `LoadWeaponMag(slot)` / `UnloadWeaponMag(slot)` take only a slot name (good —
  server picks the mag), but the server must verify a compatible loaded mag
  actually exists in the player's inventory and consume/move it atomically.
- `RepackMagazine / UnloadMagazine` merge/split ammo between indices — concurrent
  repacks of the same mags must be serialized or ammo dupes (see H1).

**Test:** block all `Reload` traffic / tamper `MagAmmo` locally — if you can keep
firing past 0, ammo is client-trusted. Spam `LoadWeaponMag("Primary")` rapidly —
if one mag fills the gun N times, there's a dupe.

---

### C7. `FallDamage(damageAmount)` — the client computes its own damage number
**Client:** `SPH_Character/FallDamage.client.lua`

```lua
v3:Fire((v5 - GameConfig.fallDamageDist) * GameConfig.fallDamageMultiplier)
```

The client measures the fall and sends a **number**. Deleting/disabling this one
LocalScript = **permanent fall-damage immunity**. Conversely the value is
spoofable (though self-harm only, unless the server misattributes it).

**Fix:** compute fall damage on the **server** (track each character's peak height
/ velocity server-side and apply on landing). Never accept a damage number from
the client. At minimum, sanity-clamp it — but deletion still bypasses that.

---

## 🟠 HIGH (duping & economy)

### H1. No client-visible locking — every inventory mutation race is a dupe candidate
Moves are server-authoritative (`MoveItem` / `MoveItemAcrossItemManager` are
InvokeServers that return success + new index — good design). **But** `DropItem`,
`UseItem`, `DiscardItem`, `RepackMagazine`, `ContextMenuAction`, `PickupCurrency`
are one-way `FireServer`s, and RemoteFunctions yield, so an exploiter can overlap
operations the UI never overlaps. Unless the server wraps **all** per-player
inventory/economy mutations in a **per-player mutex** (and validates ownership +
existence inside the lock), these are all live:

| # | Recipe | Remotes |
|---|--------|---------|
| D1 | **Drop + sell race:** `DropItem(i)` then `TraderConfirmSell/SellFinalize` (or reverse) before either completes → item sold AND dropped | DropItem + Sell* |
| D2 | **Drop + disconnect/extract:** drop, then leave/extract before save → item in world AND in persisted inventory | DropItem + save timing |
| D3 | **Use spam:** fire `UseItem(i, tied)` 20× in one frame → one medkit heals 20× / one ammo box fills 20 mags (only first should succeed; rest must fail "item gone") | UseItem, UseItemByType |
| D4 | **Double-move:** `MoveItemAcrossItemManager(i, A, B)` + `(i, A, C)` concurrently → item in two grids | MoveItem* |
| D5 | **Repack race:** two `RepackMagazine` consuming the same source mag → ammo created | RepackMagazine |
| D6 | **Quick-take race:** two `QuickTakeItem` for the same vicinity/body item (or two players looting one body without lock) → item to both | QuickTakeItem, ContextMenuAction "Take" |
| D7 | **Sell-list duplication:** `TraderConfirmSell(npc, {same itemIndex × N})` → paid N× for one item. Server must dedupe + remove each item exactly once | TraderConfirmSell |
| D8 | **Death dupe:** die with Drop-on-death (`LostItems`) while a Drop/Move is in flight; or death-drop + respawn-keep overlap | death flow + DropItem |
| D9 | **Barter contribute + reuse:** `BarterContributeItem` then immediately move/drop the same index | BarterContributeItem |
| D10 | **Cross-place:** drop in raid → extract with stale save (multi-place game: lobby `72072976067143` + zones like cordon `112318794071351`) | RequestExtract + save order |

**Fix:** single per-player inventory mutex (or serialize on one actor/thread per
player); every handler re-resolves items from server state **inside** the lock;
make consume-then-grant atomic; on death, freeze the player's inventory first,
then compute drops; on extract/leave, save-then-clear in one atomic step.

### H2. `BuyBulk(npc, {{itemID, qty}})` — quantity is fully client-controlled
**Client:** `TraderController._confirmBuy` (no price sent — good).

```lua
R.BuyBulk:InvokeServer(npc, {{itemID="X", qty=-5}})        -- negative?
R.BuyBulk:InvokeServer(npc, {{itemID="X", qty=2^31}})      -- overflow / free?
R.BuyBulk:InvokeServer(farAwayNpc, {{itemID="X", qty=1}})  -- no proximity?
```

**Fix:** server must validate `qty` is a positive sane integer, item is in that
NPC's stock, compute `total = price * qty` server-side with overflow care,
check funds, debit + deliver atomically, verify trader window actually open /
player near that NPC.

### H3. `BarterAutoFillCommit({items, currency={{itemId, amount}}}})` — amount from client
**Client:** `InventoryController` barter dialog (~lines 3476–3493, 3729–3773).

The client tells the server how much currency it's contributing. If the server
adds progress without debiting (or debits from a client-named source), stash
expansion is free.

**Fix:** server recomputes the requirement, verifies each listed item index is
owned (and consumes it), verifies `amount <= requirement remaining` and debits
roubles from the server-side balance — all inside the H1 mutex.

### H4. `TutorialAcceptIntro` grants a starter kit — must be once per player ever
**Client:** `TalkController` — "Skorpion, three mags, a box of rounds, bandages
and a medkit. On the house."

```lua
R.TutorialAcceptIntro:FireServer(anything)  -- spam = infinite kits?
```

**Fix:** server-side persistent flag; second call is a no-op (and log it).

### H5. Reward-claim idempotency (daily login, pending rewards, turn-ins)
`DailyLoginClaim()` (no args — good), `DailyLoginRequest()`,
`CollectPendingRewards()`, `GetPendingRewards()`, `DailyTaskTurnIn(id)`,
`MainTaskTurnIn()`, `HandinTask(id, npcName)`, `MainTaskAccept(id)`,
`MainTaskParley()` — all server-validated by design, but each must be **atomic +
idempotent**: rapid double-`InvokeServer` must not pay twice, completed quests
must not re-complete, and hand-in must consume the required items inside the same
lock that grants the reward. `AcceptShare(shareId)` must verify the share is
real, unexpired, and addressed to the caller (no accepting other players'
shares / arbitrary task grants).

### H6. `SprintState(bool)` / stamina — server must not believe the flag
**Client:** `StaminaBarClient` fires `SprintState(true/false)`; stamina drains are
mirrored by `StaminaSync` server→client.

If the server drains stamina / allows sprint speed only while the client says
"I'm sprinting", never sending it = **infinite stamina**. Same class as C7.

**Fix:** server derives sprinting from character velocity + input-independent
state each tick; stamina drains server-side; treat `SprintState` as a hint at
most.

### H7. `RequestRespawn()` — respawn timer must be server-side
**Client:** `DeathScreenClient` — the button gating/countdown is all client-side.
Firing `RequestRespawn` immediately after death must not work until the server's
own timer expires; also validate the player is actually dead.

---

## 🟡 MEDIUM

### M1. `PlayerDropGun()` and weapon-state bridges need ownership checks
`SwitchWeapon(tool)`, `PlayerDropGun()`, `Reload(mod)`, `PlayerChamber()`,
`MoveBolt`, `SwitchFireMode`, `BodyAnimRequest`, `PlayerToggleAttachment`,
`PlayerLean`, `ReplicateFootstep`, `ReplicateNPCFire/ReplicateHit` — validate the
tool/character belongs to the sender; `PlayerDropGun` with no args must drop
*their* equipped gun only; rate-limit to prevent state desync spam. NPC bridges
(`serverSideShoot`, `ReplicateNPCFire`) must never accept shooter/hit data from
clients.

### M2. Loot/body flow — proximity + lock ownership
`LootBody(body)`, `RequestOpenContainer`, `RequestOpenInventoryContainer(tied,
index, id)`, `BumpBodyLock/ReleaseBodyLock`, `CloseNestedContainer`,
`StorageInventoryOpened/Closed` — the lock design looks deliberate (good), but
verify: proximity to the body/container on open *and* on each take; lock owned by
caller; lock expiry; `Take` re-validates the item is still there (covers D6).

### M3. `RequestExtract(npc)` and extract-save ordering
Verify: near the guide NPC, alive, not in combat/down (per your rules), then
**save-then-teleport atomically** (covers D10). Rate-limit.

### M4. Lobby remotes must be owner-checked
`Lobby_Start`, `Lobby_Kick(userId)`, `Lobby_SelectMap(id)`,
`Lobby_SetAccess`, `Lobby_Leave`, `Lobby_JoinRequest` — server must verify
caller is the lobby owner for owner actions; validate `mapId` against the
catalog (no arbitrary place IDs); `Kick` can't target the owner/themselves weirdly.

### M5. `ApplySkin(itemType, skinId)` / `RemoveSkin(itemType)` — verify ownership
Server must check the skin is unlocked for that player (`GetUnlockedSkins` is the
read path) — otherwise any skin, including paid ones, is wearable. Same for the
premium-vendor stash tab.

### M6. Paid-gamepass/product grants must ONLY come from `ProcessReceipt`
Client prompts via `MarketplaceService:PromptGamePassPurchase/PromptProductPurchase`
directly (correct). Verify the server grants the item/skin/stash-tab **only** in
`ProcessReceipt` / `PromptGamePassPurchaseFinished` — never on any client-fired
remote — or paid items are free. (`PromptGamePassPurchase` remote exists; confirm
its direction is server→client.)

### M7. `SubmitVeteranFactionPick(factionKey)` / `RequestVeteranFactionPick`
Verify eligibility (veteran status), key is a valid faction, and once-only —
otherwise free veteran gear for anyone.

### M8. `CinematicRequestEnter()` → camera powers need containment
Check what cinematic mode grants (free camera? noclip? teleport?). If it detaches
the camera or moves the character, ensure the server still enforces position
sanity on exit, and non-authorized players can't enter (or that entering grants
no advantage — ESP via free-cam is still an advantage; gate it).

### M9. `PlayVoiceline(npc, key)` — whitelist + rate limit
Spamming plays sounds for everyone nearby. Validate `key` against a whitelist
(not arbitrary asset IDs) and throttle per player. Same for `SquadCallout`,
`BubbleClient` chat, `MainTaskPromptFire(promptId)` (validate the prompt is
actually offered to that player).

### M10. Quest state-machine transitions
`MainTaskParleyAsk/Parley/Pause/TruceBreak(true)`, `MainTaskMessage`,
`TutorialStateChanged`, `SetTutorialBanner` — validate each transition is legal
from the player's current quest state; `TruceBreak(true)` from a client should
not be able to break someone else's truce — scope everything to sender.

### M11. Dead / caller-less remotes = hidden attack surface — remove or audit
These exist in `Remotes` but have **no client callers** in this dump: `BuyItem`,
`SellItem`, `SellBulk`, `BarterAutoFill`, `PickupItem`, `PickupVicinityItem`,
`PickupToInventory`, `QuickMove`, `InvokeNpcService`, `ForceDropWeapon`,
`EquipAnimEvent`, `BleedTick`(?), `MainTaskMessage`(recv?). If the server still
handles them, they're untested backdoors into the economy — either delete them
or fuzz them with garbage/negative/oversized args.

### M12. `GetAllInventories` / `GetLocalInventory` / `GetStashInventory` scoping
Confirm these return **only the caller's** data. If "All" includes nearby
players/bodies, it's a loot ESP + intel leak. Same for `GetVicinityItems` range
(server-side radius check).

### M13. Movement/physics sanity (standard Roblox hardening)
`WalkSpeed`, teleport, fly, noclip are all client-controllable by engine design
(`SpeedCap_*` attributes are consumed client-side only — they don't protect the
server). Add server-side checks: speed/distance-per-tick caps, floor/teleport
detection, and humanoid-state validation, tuned to forgive lag. This won't stop
all exploiters but raises the bar and feeds your ban pipeline (`freeze/inspect`
exist for a reason).

---

## 🟢 LOW / verified-sane

- **No backdoors in client code:** no `require(assetId)`, `loadstring`, `getfenv`
  abuse found outside normal module requires.
- **Jabby debugger remotes** (`delete_entity`, `update_entity`, …): server module
  gates on `RunService:IsStudio()` via `traffic_check`, so in a live server
  client traffic is dropped. Still, **strip Jabby/Planck debug packages from
  production builds** — dead code is risk.
- **Sell/buy prices are display-only on the client** (`TraderController` computes
  from `ItemDatabase.BaseSellValue` for UI; payloads carry no price). Just make
  sure the server never reads a price from any payload — it doesn't appear to
  receive one. ✔
- **Item use timers** (`ItemUseStarted/Stopped`) are server→client; client doesn't
  report completion. ✔ (Still needs H1-spam protection on `UseItem`.)
- **`PickupCurrency(tied, index)`** sends no amount — server resolves value. ✔
  (Still needs proximity + existence checks.)
- **`DropButton`/`FilterSelfChat`/contacts/PDA open-close** — cosmetic or
  correctly server-resolved.
- **Replecs `Handshake`** — verify it rejects forged handshakes (couldn't assess
  strength from client alone); treat all downstream replication as untrusted input.

---

## Recommended fix order (biggest win first)

**DO FIRST - confirmed live, not theoretical: L1** (server-owned ammo per
player+weapon, reject fire/damage at zero, server rate-limit). Then:

1. **Server-side admin check** on all 4 admin remotes (C1) — 10 lines, kills
   total-compromise.
2. **Per-player inventory/economy mutex** + resolve-by-index-everywhere (H1, C2,
   C3, H2, H3) — kills nearly all dupes in one architectural change.
3. **Combat validation**: ignore client `ModTable` gameplay fields; LOS + range +
   rate-limit + server ammo (C4, C5, C6).
4. **Self-reported numbers**: server-side fall damage + stamina (C7, H6).
5. **One-time/atomic claims**: tutorial kit, dailies, turn-ins, bodies, extract
   (H4, H5, M2, M3, H7).
6. **Ownership checks** on lobby/skins/veteran/cinematic/voiceline (M4–M10).
7. **Delete dead remotes**, strip Jabby from prod, add movement sanity + logging
   (M11–M13).

## How to verify (test plan)

For each 🔴/🟠 item, run the snippet against a live server with two accounts
(exploiter + victim/alt + a second client observing). Suggested assertions:

- Admin remotes from a non-admin alt → **no effect**.
- `DropItem(junkIndex, tied, "RARE_ID")` → world spawns **junk**, not rare.
- `DropRoubles(-X)` / `DropRoubles(balance+1)` → **rejected**, balance unchanged.
- `BulletHit`/`RemoteEventMelee` at a victim across the map / through a wall →
   **no damage**; tampered `ModTable.damage` → **normal damage**.
- Delete `FallDamage` LocalScript → **still take fall damage**.
- 20× `UseItem` same frame → **exactly 1 consumed**.
- `BuyBulk` with `qty = -1 / 0 / 2^31` → **rejected**; over-funds → **rejected**.
- `BarterAutoFillCommit` with inflated `amount` → **progress matches debit**.
- `TutorialAcceptIntro` × 5 → **one kit**.
- `DailyLoginClaim` × 2 same frame → **one payout**.
- Drop + sell/extract/death races → **item exists in exactly one place**.
- `RequestRespawn` instantly → **rejected until timer**.
- `Lobby_Start/Kick` from non-owner → **rejected**.
- `ApplySkin` for unowned skin → **rejected**.

---

*Generated from client-code analysis only. The server implementation is the
ground truth for every item above — treat each as "must verify," not "confirmed
broken." If you can share the server-side handlers (even just the inventory,
trader, combat, and admin modules), I can confirm each finding precisely and
write the patches.*

---

## LIVE CONFIRMATIONS (in-game harness runs, 2026-09-09)

> Observed against a LIVE server with TEST_HARNESS.lua. UNVERIFIED items were
> reported but still need the server-side-effect proof described beside them.

### L1. CONFIRMED CRITICAL: pinned Chambered + FireMode=2 = infinite server-accepted full-auto
**Status:** owner-verified LIVE 2026-09-09 (manual Dex repro; harness G1/G2 built
to automate it). First confirmed critical of this audit.
**Repro:** equip gun -> Dex-set `<GunTool>.FireMode = 2` -> empty the mag
legitimately -> pin `<GunTool>.Chambered = true` every frame (a plain set loses:
the fire code rewrites it) -> hold trigger. Shots continue past empty AND
hostiles take damage / die. Harness G2 automates this (pins 15s, snapshots
victim HP; FAIL = damage from an empty mag).
**Root cause:** the fire pipeline is client-driven - the client decides "may fire"
from its own Chambered/FireMode/ammo values and forwards shots the server applies
WITHOUT a server-side ammo check on the damage path. (C4c's 7->0 decrement was
either local sim or a counter the damage path never consults; either way the
damage path doesn't gate on ammo. This also CONFIRMS C6.)
**Impact:** infinite ammo + forced full-auto on any gun carrying these flags;
uncapped PvE/PvP DPS, zero ammo economy. Trivial to script (set 1 value + pin
1 flag). Check every gun via G1 - if they share the flags, they share the bug.
**Fix (server-side):**
1. Server owns ammo per player+weapon (`serverMag`), changed ONLY by
   server-validated reloads (reserve > 0, correct mag type); replicate DOWN for UI.
2. On EVERY fire/damage request (`PlayerFire` + `BulletHit` bridges): if
   `serverMag <= 0` -> REJECT (no damage, no decrement). Else decrement exactly
   1, then apply damage.
3. Damage numbers from SERVER weapon tables only (never client ModTable);
   validate hit part (head vs torso) server-side. (C4a-close retest still open.)
4. Server rate-limit per player from weapon stats (min interval); drop excess
   fire requests. Caps even visual-auto abuse.
5. Treat client `Chambered`/`FireMode`/`LoadedRounds`/`ReloadLockUntil` as
   cosmetics: never read them server-side; allowed rate derives from weapon TYPE.
6. Optional: count rejected fire-at-zero per player; sustained patterns =
   exploit telemetry (legit players only blip it on empty-clicks).
**Re-verify after patch:** G2 from empty mag -> INFO/no-damage; C4c full mag ->
decrements exactly to 0 then stops; legit fire+reload loop unaffected; C4b burst
-> capped.

### L2. Gun fire-pipeline state is client-side (recon only) - harness G1 dump
**Observed on Makarov (all client-writable):** attributes `CurrentMagRounds`,
`LoadedRounds` (the actual round list!), `CurrentMagType`, `ReloadLockUntil`,
`ReloadedAt`, `_AutoChamberPending`, `MagAmmoWatched`, `SlotType`; Values
`Chambered` (bool), `FireMode` (int, 1=semi), `BoltReady` (bool).
**Why it matters:** if fire/consume/reload logic reads any of this from the client
(or the server mirrors it without checks), each is a pin/spoof target:
`LoadedRounds` (never-empty mag), `ReloadLockUntil` (instant reload),
`_AutoChamberPending` / `BoltReady` (cycle skips). Next: G2 verdict on L1 first;
if the server rejects pinned-chamber shots, probe `LoadedRounds` the same way.
