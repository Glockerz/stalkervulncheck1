--[[===========================================================================
    STALKER // Security Test Harness  v1.15 (resizable window: drag corner grip, + to maximize)
    ---------------------------------------------------------------------------
    WHAT: In-game GUI to test every finding in SECURITY_AUDIT.md against a
          LIVE server. Fires the same remotes an exploiter would, then shows
          you whether the server accepted or rejected them.

    HOW TO USE:
      1. Join your game on a PRIVATE server with TWO accounts:
         - your main (admin, to observe / check logs)
         - an ALT with NO admin rights (run this script here!)
         Most tests are only meaningful from a NON-ADMIN account.
      2. Execute this whole file in your executor on the ALT.
      3. Press RIGHT-SHIFT to toggle the window.
      4. SETUP tab -> "Refresh context", pick a junk item, trader, victim alt.
      5. Run tests top to bottom. Read the LOG tab.

    READING RESULTS:
      [PASS] (green) = server REJECTED the abuse. Good. You are safe here.
      [FAIL] (red)   = server ACCEPTED the abuse. Vulnerable. Fix it.
      [INFO] (grey)  = observation / manual check needed.

    SAFE MODE (on by default): blocks DANGER tests (ban/kick/wipe, spends,
    one-time picks, damaging other players). Turn it off only on a private
    server with consenting alts. CAUTION tests mutate YOUR OWN state
    (drop/use/buy) - use junk items and small amounts.

    This tool is for testing YOUR OWN game. Don't run it in other games.
=============================================================================]]

--// Services ---------------------------------------------------------------
local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService  = game:GetService("UserInputService")
local RunService        = game:GetService("RunService")
local LocalPlayer       = Players.LocalPlayer

local Remotes      = ReplicatedStorage:WaitForChild("Remotes")
local TaskRemotes  = ReplicatedStorage:FindFirstChild("TaskRemotes")
local SquadRemotes = ReplicatedStorage:FindFirstChild("SquadRemotes")

local function R(name)
    local r = Remotes:FindFirstChild(name)
    if r then return r end
    return Remotes:WaitForChild(name, 3)
end

-- Optional modules (best effort)
local ItemDatabase, InventoryWire, BridgeNet
pcall(function() ItemDatabase  = require(ReplicatedStorage:WaitForChild("ItemDatabase", 5)) end)
pcall(function() InventoryWire = require(ReplicatedStorage:WaitForChild("InventoryWire", 5)) end)
pcall(function()
    local sph = ReplicatedStorage:FindFirstChild("SPH_Assets")
    if sph and sph:FindFirstChild("Modules") and sph.Modules:FindFirstChild("BridgeNet") then
        BridgeNet = require(sph.Modules.BridgeNet)
    end
end)

--// State ------------------------------------------------------------------
local SAFE_MODE = true
local CTX = {
    invItems   = {},  invSel   = 1,   -- {ID, index, tied, src}
    vicItems   = {},  vicSel   = 1,   -- {ID, index, tied}
    npcs       = {},  npcSel   = 1,   -- instances
    players    = {},  playerSel= 1,   -- players (alts first)
    aitargets  = {},  aiSel      = 1,   -- hostile AI models (solo testing)
    useAI      = false,                 -- combat victim mode
    itemIDs    = {},  itemSel  = 1,   -- all known item IDs (spoof targets)
    tiedList   = {},                  -- distinct tied strings
    balance    = 0,
    factions   = {"MercenaryFactionUniforms", "DutyFactionUniforms", "FreedomFactionUniforms"},
    factionSel = 1,
}

--// Log --------------------------------------------------------------------
local LogLines, LogBox, LogCount = {}, nil, 0
local function ts() return os.date("%H:%M:%S") end
local function log(sev, msg)
    -- sev: INFO | PASS | FAIL | WARN | TEST
    local line = string.format("[%s][%s] %s", ts(), sev, tostring(msg))
    table.insert(LogLines, line)
    if #LogLines > 600 then table.remove(LogLines, 1) end
    print("[HARNESS] " .. line)
    if LogBox then
        pcall(function()
            LogBox.Text = table.concat(LogLines, "\n")
            LogBox.CanvasPosition = Vector2.new(0, 1e9)
        end)
    end
end

local function short(v, n)
    n = n or 120
    local s
    pcall(function() s = tostring(v) end)
    s = tostring(s)
    if #s > n then s = string.sub(s, 1, n) .. "..." end
    return s
end

local function dump(t, depth, seen)
    depth = depth or 0; seen = seen or {}
    if depth > 3 then return "{...}" end
    if type(t) ~= "table" then return short(t, 60) end
    if seen[t] then return "{cycle}" end
    seen[t] = true
    local parts, n = {}, 0
    for k, v in pairs(t) do
        n = n + 1
        if n > 12 then table.insert(parts, "..."); break end
        local ks = tostring(k)
        if type(v) == "table" then
            table.insert(parts, ks .. "=" .. dump(v, depth + 1, seen))
        else
            table.insert(parts, ks .. "=" .. short(v, 40))
        end
    end
    return "{" .. table.concat(parts, ", ") .. "}"
end

--// Remote call helpers ----------------------------------------------------
local function fireEv(name, ...)
    local r = R(name)
    if not r then return false, "remote missing: " .. name end
    if not r:IsA("RemoteEvent") then return false, name .. " is " .. r.ClassName end
    local args = {...}
    local ok, err = pcall(function() r:FireServer(unpack(args)) end)
    if not ok then return false, tostring(err) end
    return true, "fired"
end

local function callFn(folder, name, ...)
    local f = folder or Remotes
    local r = f:FindFirstChild(name)
    if not r then return false, "missing: " .. name end
    if not r:IsA("RemoteFunction") then return false, name .. " is " .. r.ClassName end
    local args = {...}
    local results = {pcall(function() return r:InvokeServer(unpack(args)) end)}
    local ok = table.remove(results, 1)
    if not ok then return false, tostring(results[1]) end
    return true, unpack(results)
end

local function bridge(name)
    if not BridgeNet then return nil, "BridgeNet unavailable" end
    local ok, b = pcall(function() return BridgeNet.CreateBridge(name) end)
    if not ok then return nil, tostring(b) end
    return b
end

--// Inventory scanning -----------------------------------------------------
-- Best-effort generic scanner: finds {ID, ItemIndex} anywhere in a table,
-- tracks enclosing TiedInstance, survives cycles + wire-encoded form.
local function scanItems(root, label)
    local out, seen = {}, {}
    local function walk(node, path, tied, depth)
        if depth > 8 or type(node) ~= "table" or seen[node] then return end
        seen[node] = true
        local t = tied
        if type(node.TiedInstance) == "string" then t = node.TiedInstance end
        -- wire-encoded entry {Index=, Item=}
        if node.Index ~= nil and type(node.Item) == "table" and node.Item.ID ~= nil then
            table.insert(out, {ID = tostring(node.Item.ID), index = node.Index, tied = t, src = label .. ":" .. path})
        elseif node.ItemIndex ~= nil and node.ID ~= nil then
            table.insert(out, {ID = tostring(node.ID), index = node.ItemIndex, tied = t, src = label .. ":" .. path})
        end
        for k, v in pairs(node) do
            if type(v) == "table" then
                walk(v, path .. "." .. tostring(k), t, depth + 1)
            end
        end
    end
    if type(root) == "table" then
        for k, v in pairs(root) do
            if type(v) == "table" then
                local hint = nil
                if type(k) == "string" then hint = k end
                walk(v, tostring(k), hint, 1)
            end
        end
    end
    -- dedupe
    local ded, seenKey = {}, {}
    for _, e in ipairs(out) do
        local k = tostring(e.ID) .. "|" .. tostring(e.index) .. "|" .. tostring(e.tied)
        if not seenKey[k] then seenKey[k] = true; table.insert(ded, e) end
    end
    return ded
end

local function refreshInventory()
    CTX.invItems, CTX.tiedList = {}, {}
    local ok, res = callFn(Remotes, "GetAllInventories")
    if not ok then log("WARN", "GetAllInventories failed: " .. short(res)); return end
    CTX.invItems = scanItems(res, "all")
    local seen = {}
    for _, e in ipairs(CTX.invItems) do
        if e.tied and not seen[e.tied] then seen[e.tied] = true; table.insert(CTX.tiedList, e.tied) end
    end
    CTX.invSel = 1
    log("INFO", string.format("Inventory: %d items, %d tied grids. Raw keys: %s",
        #CTX.invItems, #CTX.tiedList, dump(res, 1)))
    if #CTX.invItems == 0 then
        log("WARN", "No items parsed - shape above. Open inventory UI once, then refresh again.")
    end
end

local function refreshVicinity()
    CTX.vicItems = {}
    local ok, res = callFn(Remotes, "GetVicinityItems")
    if not ok then log("WARN", "GetVicinityItems failed: " .. short(res)); return end
    local items = res
    if type(res) == "table" and res.Items ~= nil then items = res.Items end
    if InventoryWire then
        pcall(function()
            if InventoryWire.IsEncoded and InventoryWire.IsEncoded(items) then
                items = InventoryWire.DecodeItems(items)
            end
        end)
    end
    -- vicinity entries are usually keyed by index already
    if type(items) == "table" then
        for k, v in pairs(items) do
            if type(v) == "table" and v.ID ~= nil then
                table.insert(CTX.vicItems, {ID = tostring(v.ID), index = k, tied = res.Tied or res.tied})
            elseif type(v) == "table" then
                local sub = scanItems({[k] = v}, "vic")
                for _, e in ipairs(sub) do table.insert(CTX.vicItems, e) end
            end
        end
    end
    CTX.vicSel = 1
    log("INFO", string.format("Vicinity: %d items. Raw: %s", #CTX.vicItems, dump(res, 1)))
end

local function refreshNPCs()
    CTX.npcs = {}
    local function consider(m)
        if m:IsA("Model") then table.insert(CTX.npcs, m) end
    end
    local map = workspace:FindFirstChild("Map")
    if map and map:FindFirstChild("NPCs") then
        for _, d in ipairs(map.NPCs:GetDescendants()) do
            if d.Name == "NPCModel" or (d:IsA("Model") and (string.find(d.Name, "Trader") or string.find(d.Name, "NPC"))) then
                consider(d)
            end
        end
    end
    if #CTX.npcs == 0 then
        for _, d in ipairs(workspace:GetDescendants()) do
            if d:IsA("Model") and (string.find(d.Name, "Trader") or d.Name == "NPCModel") then
                consider(d)
                if #CTX.npcs >= 20 then break end
            end
        end
    end
    CTX.npcSel = 1
    log("INFO", "NPCs found: " .. tostring(#CTX.npcs))
    for i, n in ipairs(CTX.npcs) do
        if i <= 10 then log("INFO", "  [" .. i .. "] " .. n:GetFullName()) end
    end
end

local function refreshPlayers()
    CTX.players = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then table.insert(CTX.players, p) end
    end
    table.insert(CTX.players, LocalPlayer) -- self last
    CTX.playerSel = 1
    log("INFO", "Players: " .. tostring(#CTX.players) .. " (self listed last)")
end

local function refreshAI()
    CTX.aitargets = {}
    local chars = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then chars[p.Character] = true end
    end
    local traders = {}
    for _, n in ipairs(CTX.npcs) do traders[n] = true end
    for _, d in ipairs(workspace:GetDescendants()) do
        if d:IsA("Model") and not chars[d] and not traders[d] then
            local nl = string.lower(d.Name)
            -- skip corpses, dummies, target props (MT_*_Body, Scale Dummy, ...)
            local isProp = string.find(nl, "dead", 1, true) or string.find(nl, "body", 1, true)
                or string.find(nl, "corpse", 1, true) or string.find(nl, "ragdoll", 1, true)
                or string.find(nl, "dummy", 1, true) or string.find(nl, "target", 1, true)
                or string.find(nl, "mannequin", 1, true)
            if not isProp then
                local hum = d:FindFirstChildOfClass("Humanoid")
                local head = d:FindFirstChild("Head")
                if hum and head and hum.Health > 0 then
                    table.insert(CTX.aitargets, d)
                    if #CTX.aitargets >= 200 then break end
                end
            end
        end
    end
    -- nearest first: the default pick is always the closest hostile
    pcall(function()
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root then
            table.sort(CTX.aitargets, function(a, b)
                local pa, pb = nil, nil
                pcall(function()
                    pa = (a:FindFirstChild("Head").Position - root.Position).Magnitude
                    pb = (b:FindFirstChild("Head").Position - root.Position).Magnitude
                end)
                return (pa or 1e9) < (pb or 1e9)
            end)
        end
    end)
    while #CTX.aitargets > 30 do table.remove(CTX.aitargets) end
    CTX.aiSel = 1
    log("INFO", "Hostile AI candidates: " .. tostring(#CTX.aitargets) .. " (nearest first, d=studs)")
    for i, m in ipairs(CTX.aitargets) do
        if i <= 10 then
            local hum = m:FindFirstChildOfClass("Humanoid")
            local dist = "?"
            pcall(function()
                local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                dist = string.format("%.0f", (m:FindFirstChild("Head").Position - root.Position).Magnitude)
            end)
            log("INFO", "  [AI" .. i .. "] " .. m:GetFullName() .. " hp=" .. (hum and math.floor(hum.Health) or "?") .. " d=" .. dist)
        end
    end
    if #CTX.aitargets == 0 then
        log("WARN", "No AI found - walk near hostiles (bandits/mutants) and run S0 again.")
    end
end

local function refreshItemIDs()
    CTX.itemIDs = {}
    if ItemDatabase then
        for k, v in pairs(ItemDatabase) do
            if type(k) == "string" and type(v) == "table" then
                table.insert(CTX.itemIDs, k)
            end
        end
        table.sort(CTX.itemIDs)
    end
    CTX.itemSel = 1
    log("INFO", "ItemDatabase IDs loaded: " .. tostring(#CTX.itemIDs))
end

local function refreshBalance()
    local ok, res = callFn(Remotes, "RequestBalance")
    if ok and type(res) == "number" then CTX.balance = res end
    log("INFO", "Balance: " .. tostring(CTX.balance))
end

local function selInv()    return CTX.invItems[CTX.invSel] end
local function selVic()    return CTX.vicItems[CTX.vicSel] end
local function selNPC()    return CTX.npcs[CTX.npcSel] end
local function selPlayer() return CTX.players[CTX.playerSel] end
local function selItemID() return CTX.itemIDs[CTX.itemSel] end

local function countItem(id)
    local n = 0
    for _, e in ipairs(CTX.invItems) do
        if e.ID == id then n = n + 1 end
    end
    return n
end

-- Consumable allowlist for USE-spam tests (D3a/D3b). Firing UseItem at a
-- NON-usable item (ammo box, mag) consumes nothing and proves nothing, so
-- these tests auto-prefer a consumable and fall back to the picked item.
local FOOD_HINTS = {"bread", "canned", "ration", "sausage", "beans", "water",
    "vodka", "tourist", "delight", "meat", "soup", "mre"}
local MED_HINTS = {"medkit", "ai-2", "ai2", "dressing", "bandage", "iodine",
    "peroxide", "antirad", "syringe", "morphine", "splint", "charcoal", "tourniquet"}
-- Food first: meds are condition-gated (no-op at full HP / no bleed), so a
-- medkit at 100 HP consumes 0 and proves nothing. Food is the honest target.
local function findConsumable()
    for _, hints in ipairs({FOOD_HINTS, MED_HINTS}) do
        for _, e in ipairs(CTX.invItems) do
            local idl = string.lower(e.ID)
            for _, h in ipairs(hints) do
                if string.find(idl, h, 1, true) then return e end
            end
        end
    end
    return nil
end

--// GUI --------------------------------------------------------------------
local gui, main, contentFrames, tabBtns, statusLabels
local BG      = Color3.fromRGB(14, 15, 18)
local PANEL   = Color3.fromRGB(22, 23, 28)
local ROW     = Color3.fromRGB(30, 31, 38)
local TXT     = Color3.fromRGB(230, 230, 235)
local DIM     = Color3.fromRGB(150, 150, 165)
local ACCENT  = Color3.fromRGB(255, 190, 70)
local GREEN   = Color3.fromRGB(110, 210, 120)
local RED     = Color3.fromRGB(235, 100, 100)
local YELLOW  = Color3.fromRGB(235, 200, 100)
local GREY    = Color3.fromRGB(120, 120, 130)
local RISKCOL = { safe = GREEN, caution = YELLOW, danger = RED }

local function mk(class, props, parent)
    local o = Instance.new(class)
    for k, v in pairs(props) do
        pcall(function() o[k] = v end)
    end
    o.Parent = parent
    return o
end

local function buildGUI()
    if LocalPlayer.PlayerGui:FindFirstChild("StalkerSecTest") then
        LocalPlayer.PlayerGui.StalkerSecTest:Destroy()
    end
    gui = mk("ScreenGui", {Name = "StalkerSecTest", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 999}, LocalPlayer.PlayerGui)

    main = mk("Frame", {Name = "Main", Size = UDim2.fromOffset(780, 560),
        Position = UDim2.new(0.5, -390, 0.5, -280), BackgroundColor3 = BG,
        BorderSizePixel = 0, Active = true}, gui)
    mk("UICorner", {CornerRadius = UDim.new(0, 8)}, main)
    mk("UIStroke", {Color = Color3.fromRGB(60, 60, 70), Thickness = 1}, main)

    local top = mk("Frame", {Size = UDim2.new(1, 0, 0, 40), BackgroundColor3 = PANEL,
        BorderSizePixel = 0, Active = true}, main)
    mk("UICorner", {CornerRadius = UDim.new(0, 8)}, top)
    mk("TextLabel", {Size = UDim2.new(1, -270, 1, 0), Position = UDim2.fromOffset(12, 0),
        BackgroundTransparency = 1, Text = "STALKER // SECURITY TEST HARNESS  v1.15",
        Font = Enum.Font.GothamBold, TextSize = 15, TextColor3 = ACCENT,
        TextXAlignment = Enum.TextXAlignment.Left}, top)
    local safeBtn = mk("TextButton", {Size = UDim2.fromOffset(140, 26), Position = UDim2.new(1, -246, 0.5, -13),
        BackgroundColor3 = Color3.fromRGB(50, 110, 60), Text = "SAFE MODE: ON",
        Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = TXT, BorderSizePixel = 0}, top)
    mk("UICorner", {CornerRadius = UDim.new(0, 4)}, safeBtn)
    safeBtn.MouseButton1Click:Connect(function()
        SAFE_MODE = not SAFE_MODE
        safeBtn.Text = SAFE_MODE and "SAFE MODE: ON" or "SAFE MODE: OFF"
        safeBtn.BackgroundColor3 = SAFE_MODE and Color3.fromRGB(50, 110, 60) or Color3.fromRGB(140, 50, 50)
        log("WARN", "Safe mode " .. (SAFE_MODE and "ENABLED (danger tests blocked)" or "DISABLED (all tests live!)"))
    end)
    local hideBtn = mk("TextButton", {Size = UDim2.fromOffset(64, 26), Position = UDim2.new(1, -100, 0.5, -13),
        BackgroundColor3 = ROW, Text = "HIDE", Font = Enum.Font.GothamBold,
        TextSize = 11, TextColor3 = DIM, BorderSizePixel = 0}, top)
    mk("UICorner", {CornerRadius = UDim.new(0, 4)}, hideBtn)
    hideBtn.MouseButton1Click:Connect(function() main.Visible = false end)
    local maxBtn = mk("TextButton", {Size = UDim2.fromOffset(28, 26), Position = UDim2.new(1, -32, 0.5, -13),
        BackgroundColor3 = ROW, Text = "+", Font = Enum.Font.GothamBold,
        TextSize = 16, TextColor3 = DIM, BorderSizePixel = 0}, top)
    mk("UICorner", {CornerRadius = UDim.new(0, 4)}, maxBtn)
    local savedSize, savedPos, maximized = nil, nil, false
    maxBtn.MouseButton1Click:Connect(function()
        if not maximized then
            savedSize, savedPos = main.Size, main.Position
            local vs = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280, 720)
            local nw = math.clamp(vs.X - 40, 520, 1200)
            local nh = math.clamp(vs.Y - 40, 380, 800)
            main.Size = UDim2.fromOffset(nw, nh)
            main.Position = UDim2.new(0.5, -nw / 2, 0.5, -nh / 2)
            maximized = true
            maxBtn.Text = "-"
            log("INFO", "Window maximized (press - to restore, or drag the corner grip)")
        else
            if savedSize then main.Size = savedSize end
            if savedPos then main.Position = savedPos end
            maximized = false
            maxBtn.Text = "+"
        end
    end)

    -- Drag by title bar (custom, so it never fights the resize grip)
    local dragging = false
    local dsX, dsY, dmX, dmY = 0, 0, 0, 0
    top.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dsX, dsY = main.Position.X.Offset, main.Position.Y.Offset
            local scX = main.Position.X.Scale
            local scY = main.Position.Y.Scale
            local vs = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280, 720)
            dsX = scX * vs.X + dsX
            dsY = scY * vs.Y + dsY
            dmX, dmY = input.Position.X, input.Position.Y
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            main.Position = UDim2.fromOffset(input.Position.X - dmX + dsX, input.Position.Y - dmY + dsY)
        end
    end)

    -- Resize grip (bottom-right corner)
    local grip = mk("TextButton", {Name = "ResizeGrip", Size = UDim2.fromOffset(28, 28),
        Position = UDim2.new(1, -28, 1, -28), BackgroundTransparency = 1, Text = "",
        BorderSizePixel = 0, ZIndex = 5, AutoButtonColor = false}, main)
    for _, s in ipairs({{14, 13, 20}, {9, 12, 15}, {4, 11, 10}}) do
        mk("Frame", {Size = UDim2.fromOffset(s[1], 2),
            Position = UDim2.fromOffset(s[2], s[3]),
            BackgroundColor3 = DIM, BorderSizePixel = 0, Rotation = -45}, grip)
    end
    local resizing = false
    local rsX, rsY, rmX, rmY = 0, 0, 0, 0
    grip.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            maximized = false
            maxBtn.Text = "+"
            rsX, rsY = main.Size.X.Offset, main.Size.Y.Offset
            rmX, rmY = input.Position.X, input.Position.Y
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then resizing = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if not resizing then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            local nx = math.clamp(rsX + (input.Position.X - rmX), 520, 1200)
            local ny = math.clamp(rsY + (input.Position.Y - rmY), 380, 800)
            main.Size = UDim2.fromOffset(nx, ny)
        end
    end)

    local tabs = mk("Frame", {Size = UDim2.new(0, 130, 1, -40), Position = UDim2.fromOffset(0, 40),
        BackgroundColor3 = PANEL, BorderSizePixel = 0}, main)
    local tabList = mk("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, tabs)
    mk("UIPadding", {PaddingTop = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8)}, tabs)

    contentFrames, tabBtns, statusLabels = {}, {}, {}
    return tabs
end

local TAB_ORDER = {"START", "SETUP", "CRITICAL", "DUPES", "ECONOMY", "COMBAT", "MISC", "LOG"}
local function buildTabs(tabs)
    local content = mk("Frame", {Size = UDim2.new(1, -130, 1, -40), Position = UDim2.fromOffset(130, 40),
        BackgroundTransparency = 1}, main)
    for i, name in ipairs(TAB_ORDER) do
        local b = mk("TextButton", {Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = ROW,
            Text = name, Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = DIM,
            BorderSizePixel = 0, LayoutOrder = i}, tabs)
        mk("UICorner", {CornerRadius = UDim.new(0, 4)}, b)
        tabBtns[name] = b
        local scroll = mk("ScrollingFrame", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
            BorderSizePixel = 0, ScrollBarThickness = 5, ScrollBarImageColor3 = ACCENT,
            AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false}, content)
        local layout = mk("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, scroll)
        mk("UIPadding", {PaddingTop = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 12), PaddingBottom = UDim.new(0, 8)}, scroll)
        contentFrames[name] = scroll
        b.MouseButton1Click:Connect(function() showTab(name) end)
    end
end

function showTab(name)
    for n, f in pairs(contentFrames) do f.Visible = (n == name) end
    for n, b in pairs(tabBtns) do
        b.BackgroundColor3 = (n == name) and Color3.fromRGB(50, 55, 70) or ROW
        b.TextColor3 = (n == name) and TXT or DIM
    end
end

local testCounter = 0
local TESTS = {}    -- id -> {tab, label, risk, fn, row, status}
local RESULTS = {}  -- id -> PASS | FAIL | INFO | ERROR | RUN | SKIP | BLOCKED
local SUITE = {"C1b", "H2b", "D3b", "D7", "H4", "H5a", "H5b", "H5c", "C4b", "C4a"}
local SummaryVals = nil  -- filled by START tab: {pass, fail, rev, list}
local RISKWORD = {safe = "SAFE", caution = "CAREFUL", danger = "DANGER"}

-- Plain-English explanation shown under every test.
local DESCRIPTIONS = {
    S0 = "Reloads items, ground, traders, players + hostile AI from the server. Always run first.",
    S1 = "Lists every remote the game has. Read-only recon, changes nothing.",
    S2 = "Prints your parsed inventory to LOG. Confirms the tool can see your items.",
    C1b = "Runs the harmless admin command 'where'. Any reaction = admins not checked!",
    C1c = "Tries to spawn 1 item with the admin remote. PASS = nothing granted.",
    C1d = "Runs YOUR OWN admin command typed below. Only works with Safe Mode OFF.",
    C2b = "Picks up a ground item with a forged id. Checks what you actually receive.",
    C3c = "Control test: drops R1 then picks it up. Balance should end exactly equal.",
    D3b = "Same idea through the hotbar (10x). Auto-picks a consumable if you have one.",
    D4 = "Moves ONE item into TWO grids at the same time. In 2 places = dupe!",
    D1 = "Drops AND sells the same item simultaneously. It must end up in ONE place.",
    D7 = "Sells the same item 5 times inside one request. PASS = paid at most once.",
    D6 = "Grabs ONE ground item twice at the same time. You should receive exactly 1.",
    D5 = "Runs the same ammo repack twice concurrently. Then check ammo counts in LOG.",
    D9 = "Donates to barter while moving the item away at once. Race check.",
    H2b = "Tries to buy with quantity 0. PASS = rejected.",
    H2c = "Tries to buy 2 BILLION at once. Tests price-math overflow. Spends money!",
    H2d = "Tries to buy 99999 (more than you can afford). PASS = rejected.",
    H3a = "Reads the barter auto-fill suggestion. Read-only, changes nothing.",
    H3b = "Donates YOUR OWN currency amount typed below. PASS = rejected or fully paid.",
    H4 = "Claims the free tutorial starter kit 5 times. PASS = at most one kit, ever.",
    H5a = "Claims the daily login reward twice at the same time. Both paying = FAIL.",
    H5b = "Collects pending rewards twice at once. Both paying = double-spend bug.",
    H5c = "Turns in the main quest twice at once. Both paying = double-spend bug.",
    H5d = "Turns in the task id typed below, twice. Needs a finished task id.",
    E1 = "Loads your gun mag 5 times super fast. One mag must fill exactly once.",
    E2 = "Tries to wear a skin you do NOT own (typed below). Applied = FAIL.",
    E3 = "ONE-TIME faction pack pick! A non-veteran receiving it = FAIL.",
    G0 = "Shows your equipped gun and its ammo. Read-only, changes nothing.",
    G1 = "Dumps every flag inside your gun to find chamber + firemode. Paste the dump.",
    G2 = "Pins Chambered+AUTO 15s while YOU mag-dump the victim from EMPTY. Damage = CONFIRMED.",
    C4a = "Shoots your victim (ALT or hostile AI) in the head, 9999 dmg. STAND FAR / BEHIND A WALL!",
    C4b = "Hits your victim 30 times instantly. Full 30x damage = no rate limit.",
    C4c = "Forces 10 shots without reloading. Server must subtract ammo every shot.",
    C5a = "Hits your victim with a melee weapon from FAR away. Damage = no range check.",
    C5b = "Tries to weld a random arena part to you. A weld = no ownership check.",
    M1a = "Drops your gun 3 times at once. One gun must drop at most once.",
    M1b = "Switches weapon + reloads with hacked stats. Watch for weird behavior.",
    X2 = "Tries to start the lobby as a non-owner. Starting = missing owner check.",
    X3 = "Tries to kick the target below as a non-owner. Default target is YOU.",
    X4 = "Plays YOUR voiceline key (below) 5 times. Tests spam protection.",
    X5 = "Enters then exits cinematic mode. Checks it grants no free-camera powers.",
    X6 = "Runs your text through the chat filter. Read-only, changes nothing.",
    F1 = "Throws garbage data at 16 unused remotes. Any real reply = investigate!",
    L1 = "Checks YOUR inventory data for OTHER players' names. A hit = info leak.",
    L2 = "Shows server info (place, job). Read-only, changes nothing.",
}

local function refreshSummary()
    if not SummaryVals then return end
    local p, f, r = 0, 0, 0
    local failed, review = {}, {}
    for id, v in pairs(RESULTS) do
        if v == "PASS" then p = p + 1
        elseif v == "FAIL" then f = f + 1; table.insert(failed, id)
        elseif v == "INFO" or v == "ERROR" then
            r = r + 1
            table.insert(review, v == "ERROR" and (id .. "!") or id)
        end
    end
    table.sort(failed); table.sort(review)
    pcall(function()
        SummaryVals.pass.Text = "PASSED (safe): " .. p
        SummaryVals.fail.Text = "FAILED (fix me): " .. f
        SummaryVals.rev.Text = "TO REVIEW: " .. r
        local lines = {}
        if #failed > 0 then table.insert(lines, "FIX THESE: " .. table.concat(failed, ", ")) end
        if #review > 0 then table.insert(lines, "REVIEW: " .. table.concat(review, ", ")) end
        if #lines == 0 then lines = {"No results yet - run the suite!"} end
        SummaryVals.list.Text = table.concat(lines, "\n")
    end)
end

local function setStatus(id, verdict)
    local t = TESTS[id]
    if not t then return end
    RESULTS[id] = verdict
    local st, row = t.status, t.row
    if verdict == "PASS" then
        st.Text = "[  PASS  ]"; st.TextColor3 = GREEN
        row.BackgroundColor3 = Color3.fromRGB(26, 48, 30)
    elseif verdict == "FAIL" then
        st.Text = "[  FAIL  ]"; st.TextColor3 = RED
        row.BackgroundColor3 = Color3.fromRGB(54, 26, 28)
    elseif verdict == "RUN" then
        st.Text = "[   ...   ]"; st.TextColor3 = YELLOW
    elseif verdict == "SKIP" or verdict == "BLOCKED" then
        st.Text = "[" .. verdict .. "]"; st.TextColor3 = YELLOW
    elseif verdict == "ERROR" then
        st.Text = "[ ERROR ]"; st.TextColor3 = RED
    else
        st.Text = "[  INFO  ]"; st.TextColor3 = GREY
    end
    pcall(refreshSummary)
end

local function runTestSync(id)
    local t = TESTS[id]
    if not t then return end
    if t.risk == "danger" and SAFE_MODE then
        setStatus(id, "BLOCKED")
        log("WARN", id .. " blocked by SAFE MODE (toggle it OFF at the top to run red tests)")
        return
    end
    setStatus(id, "RUN")
    log("TEST", "== " .. id .. ": " .. t.label .. " ==")
    local ok, verdict, detail = pcall(t.fn)
    if not ok then
        setStatus(id, "ERROR")
        log("WARN", id .. " harness error: " .. short(verdict))
        return
    end
    verdict = verdict or "INFO"
    setStatus(id, verdict)
    if detail then log(verdict == "INFO" and "INFO" or verdict, id .. " :: " .. tostring(detail)) end
end

-- risk: "safe" | "caution" | "danger"
local function addTest(tab, id, label, risk, fn)
    testCounter = testCounter + 1
    local row = mk("Frame", {Size = UDim2.new(1, 0, 0, 58), BackgroundColor3 = ROW,
        BorderSizePixel = 0, LayoutOrder = testCounter}, contentFrames[tab])
    mk("UICorner", {CornerRadius = UDim.new(0, 4)}, row)
    local dot = mk("Frame", {Size = UDim2.fromOffset(10, 10), Position = UDim2.new(0, 8, 0, 8),
        BackgroundColor3 = RISKCOL[risk] or GREY, BorderSizePixel = 0}, row)
    mk("UICorner", {CornerRadius = UDim.new(1, 0)}, dot)
    mk("TextLabel", {Size = UDim2.fromOffset(64, 14), Position = UDim2.fromOffset(22, 6),
        BackgroundTransparency = 1, Text = RISKWORD[risk] or "", Font = Enum.Font.GothamBold,
        TextSize = 10, TextColor3 = RISKCOL[risk] or GREY,
        TextXAlignment = Enum.TextXAlignment.Left}, row)
    local btn = mk("TextButton", {Size = UDim2.new(1, -120, 0, 22), Position = UDim2.fromOffset(90, 4),
        BackgroundTransparency = 1, Text = "[" .. id .. "]  " .. label,
        Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = TXT,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd}, row)
    mk("TextLabel", {Size = UDim2.new(1, -128, 0, 28), Position = UDim2.fromOffset(90, 27),
        BackgroundTransparency = 1, Text = DESCRIPTIONS[id] or "", Font = Enum.Font.Gotham,
        TextSize = 11, TextColor3 = DIM, TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true, TextTruncate = Enum.TextTruncate.AtEnd}, row)
    local st = mk("TextLabel", {Size = UDim2.new(0, 108, 1, 0), Position = UDim2.new(1, -112, 0, 0),
        BackgroundTransparency = 1, Text = "[ -- ]", Font = Enum.Font.GothamBold,
        TextSize = 13, TextColor3 = GREY, TextXAlignment = Enum.TextXAlignment.Right}, row)
    TESTS[id] = {tab = tab, label = label, risk = risk, fn = fn, row = row, status = st}
    statusLabels[id] = st
    btn.MouseButton1Click:Connect(function()
        task.spawn(function() runTestSync(id) end)
    end)
end

local function addHeader(tab, text)
    testCounter = testCounter + 1
    mk("TextLabel", {Size = UDim2.new(1, 0, 0, 22), BackgroundTransparency = 1,
        Text = text, Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = ACCENT,
        TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = testCounter}, contentFrames[tab])
end

local function addNote(tab, text)
    testCounter = testCounter + 1
    local l = mk("TextLabel", {Size = UDim2.new(1, 0, 0, 14), BackgroundTransparency = 1,
        Text = text, Font = Enum.Font.Gotham, TextSize = 11, TextColor3 = DIM,
        TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true,
        AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = testCounter}, contentFrames[tab])
    return l
end

-- Dropdown: label + button showing current value; click opens a popup list.
-- itemsFn() -> array of strings; getFn() -> index; setFn(i) selects.
local openPopup = nil
local function closePopup()
    if openPopup then pcall(function() openPopup:Destroy() end); openPopup = nil end
end

local function addDropdown(tab, label, itemsFn, getFn, setFn)
    testCounter = testCounter + 1
    local row = mk("Frame", {Size = UDim2.new(1, 0, 0, 32), BackgroundColor3 = ROW,
        BorderSizePixel = 0, LayoutOrder = testCounter}, contentFrames[tab])
    mk("UICorner", {CornerRadius = UDim.new(0, 4)}, row)
    mk("TextLabel", {Size = UDim2.new(0, 150, 1, 0), Position = UDim2.fromOffset(8, 0),
        BackgroundTransparency = 1, Text = label, Font = Enum.Font.GothamBold,
        TextSize = 11, TextColor3 = DIM, TextXAlignment = Enum.TextXAlignment.Left}, row)
    local btn = mk("TextButton", {Size = UDim2.new(1, -166, 1, -8), Position = UDim2.fromOffset(158, 4),
        BackgroundColor3 = BG, Text = "", Font = Enum.Font.Code, TextSize = 11, TextColor3 = TXT,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
        BorderSizePixel = 0, AutoButtonColor = true}, row)
    mk("UICorner", {CornerRadius = UDim.new(0, 4)}, btn)
    local function refresh()
        local items = itemsFn() or {}
        local idx = getFn() or 1
        btn.Text = "  " .. (items[idx] or "(none - run S0 Refresh first)") .. "      v"
    end
    btn.MouseButton1Click:Connect(function()
        if openPopup then closePopup(); return end
        local items = itemsFn() or {}
        if #items == 0 then refresh(); return end
        local absPos, absSize = btn.AbsolutePosition, btn.AbsoluteSize
        local back = mk("TextButton", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
            Text = "", ZIndex = 90, AutoButtonColor = false}, gui)
        local h = math.min(#items * 26 + 10, 240)
        local pop = mk("Frame", {Size = UDim2.fromOffset(absSize.X, h),
            Position = UDim2.fromOffset(absPos.X, absPos.Y + absSize.Y + 2),
            BackgroundColor3 = PANEL, BorderSizePixel = 0, ZIndex = 91}, back)
        mk("UICorner", {CornerRadius = UDim.new(0, 4)}, pop)
        local stroke = mk("UIStroke", {Color = ACCENT, Thickness = 1}, pop)
        local scroll = mk("ScrollingFrame", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
            BorderSizePixel = 0, ScrollBarThickness = 4, ScrollBarImageColor3 = ACCENT,
            CanvasSize = UDim2.new(0, 0, 0, #items * 26 + 6), ZIndex = 92}, pop)
        mk("UIListLayout", {Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder}, scroll)
        mk("UIPadding", {PaddingTop = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4),
            PaddingRight = UDim.new(0, 4)}, scroll)
        for i, name in ipairs(items) do
            local ob = mk("TextButton", {Size = UDim2.new(1, -8, 0, 24),
                BackgroundColor3 = (i == getFn()) and Color3.fromRGB(50, 55, 70) or ROW,
                Text = "  " .. tostring(name), Font = Enum.Font.Code, TextSize = 11, TextColor3 = TXT,
                TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
                BorderSizePixel = 0, LayoutOrder = i, ZIndex = 93, AutoButtonColor = true}, scroll)
            mk("UICorner", {CornerRadius = UDim.new(0, 3)}, ob)
            ob.MouseButton1Click:Connect(function() setFn(i); refresh(); closePopup() end)
        end
        openPopup = back
        back.MouseButton1Click:Connect(function() closePopup() end)
    end)
    refresh()
    return refresh
end

local function addInput(tab, label, default)
    testCounter = testCounter + 1
    local row = mk("Frame", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW,
        BorderSizePixel = 0, LayoutOrder = testCounter}, contentFrames[tab])
    mk("UICorner", {CornerRadius = UDim.new(0, 4)}, row)
    mk("TextLabel", {Size = UDim2.new(0, 150, 1, 0), Position = UDim2.fromOffset(8, 0),
        BackgroundTransparency = 1, Text = label, Font = Enum.Font.GothamBold,
        TextSize = 11, TextColor3 = DIM, TextXAlignment = Enum.TextXAlignment.Left}, row)
    local box = mk("TextBox", {Size = UDim2.new(1, -166, 1, -8), Position = UDim2.fromOffset(158, 4),
        BackgroundColor3 = BG, Text = default or "", Font = Enum.Font.Code,
        TextSize = 12, TextColor3 = TXT, BorderSizePixel = 0, ClearTextOnFocus = false}, row)
    mk("UICorner", {CornerRadius = UDim.new(0, 4)}, box)
    return box
end

local SelectorRefresh = {}
local function cyc(list, sel, dir)
    if #list == 0 then return sel end
    sel = sel + dir
    if sel < 1 then sel = #list end
    if sel > #list then sel = 1 end
    return sel
end

--// Gun / melee discovery --------------------------------------------------
local function findGun()
    local char = LocalPlayer.Character
    local packs = {}
    if char then table.insert(packs, char) end
    local bp = LocalPlayer:FindFirstChild("Backpack")
    if bp then table.insert(packs, bp) end
    for _, c in ipairs(packs) do
        for _, t in ipairs(c:GetChildren()) do
            if t:IsA("Tool") and t:FindFirstChild("SPH_Weapon") then return t end
        end
    end
    return nil
end

local function findMelee()
    local char = LocalPlayer.Character
    local packs = {}
    if char then table.insert(packs, char) end
    local bp = LocalPlayer:FindFirstChild("Backpack")
    if bp then table.insert(packs, bp) end
    for _, c in ipairs(packs) do
        for _, t in ipairs(c:GetChildren()) do
            if t:IsA("Tool") then
                local rems = t:FindFirstChild("Remotes")
                if rems and rems:FindFirstChild("RemoteEventMelee") then return t end
            end
        end
    end
    return nil
end

local function victimHead()
    -- returns: head, humanoid, displayName, isSelf | nil
    if CTX.useAI then
        local m = CTX.aitargets and CTX.aitargets[CTX.aiSel]
        if not m or not m.Parent then return nil end
        local head = m:FindFirstChild("Head")
        local hum = m:FindFirstChildOfClass("Humanoid")
        if not head or not hum then return nil end
        return head, hum, m.Name, false
    end
    local p = selPlayer()
    if not p or not p.Character then return nil end
    local head = p.Character:FindFirstChild("Head")
    local hum = p.Character:FindFirstChildOfClass("Humanoid")
    if not head or not hum then return nil end
    return head, hum, p.Name, (p == LocalPlayer)
end

--// Build all ----------------------------------------------------------------
local tabs = buildGUI()
buildTabs(tabs)

-- ============================ START ========================================
addHeader("START", "WHAT IS THIS TOOL?")
addNote("START", "It attacks YOUR game the way an exploiter would, then shows whether your server blocked it.")
addNote("START", "Run it on an ALT account with NO admin rights, on a private server.")

addHeader("START", "LEGEND - what the colors mean")
local function legendRow(dotColor, text)
    testCounter = testCounter + 1
    local row = mk("Frame", {Size = UDim2.new(1, 0, 0, 24), BackgroundTransparency = 1,
        LayoutOrder = testCounter}, contentFrames["START"])
    local dot = mk("Frame", {Size = UDim2.fromOffset(10, 10), Position = UDim2.new(0, 8, 0.5, -5),
        BackgroundColor3 = dotColor, BorderSizePixel = 0}, row)
    mk("UICorner", {CornerRadius = UDim.new(1, 0)}, dot)
    mk("TextLabel", {Size = UDim2.new(1, -30, 1, 0), Position = UDim2.fromOffset(26, 0),
        BackgroundTransparency = 1, Text = text, Font = Enum.Font.Gotham, TextSize = 12,
        TextColor3 = TXT, TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd}, row)
end
legendRow(GREEN, "Green dot = SAFE test, changes nothing.        [PASS] = server blocked it. You are SAFE.")
legendRow(YELLOW, "Yellow dot = CAREFUL, touches YOUR items.  [FAIL] = server allowed it. FIX IT!")
legendRow(RED, "Red dot = DANGER. Blocked while Safe Mode is ON (top-right button).")
legendRow(GREY, "[INFO] = just an observation. Open the LOG tab for details.")

addHeader("START", "QUICK START - do this in order")
addNote("START", "1.  SETUP tab  ->  run S0 Refresh,  then pick a JUNK item + a trader in the dropdowns.")
addNote("START", "2.  Come back here and press RUN PRIORITY SUITE below (10 key tests, automatic).")
addNote("START", "3.  Read the summary + the LOG tab. Every red FAIL is a real vulnerability.")
addNote("START", "4.  Explore the other tabs. Combat victim = ALT player or HOSTILE AI (toggle in COMBAT).")

testCounter = testCounter + 1
local suiteBtn = mk("TextButton", {Size = UDim2.new(1, 0, 0, 42), BackgroundColor3 = Color3.fromRGB(60, 90, 140),
    Text = "RUN PRIORITY SUITE  (10 key tests, automatic)", Font = Enum.Font.GothamBold, TextSize = 14,
    TextColor3 = TXT, BorderSizePixel = 0, LayoutOrder = testCounter}, contentFrames["START"])
mk("UICorner", {CornerRadius = UDim.new(0, 6)}, suiteBtn)
addNote("START", "Red tests inside the suite are skipped while Safe Mode is ON. Totally safe to run as-is.")
suiteBtn.MouseButton1Click:Connect(function()
    suiteBtn.Text = "RUNNING... watch the LOG tab"
    task.spawn(function()
        if type(SUITE) ~= "table" or type(TESTS) ~= "table" then
            log("WARN", "Harness did not load fully (partial paste?). Re-copy the WHOLE Raw file and execute again.")
            suiteBtn.Text = "LOAD ERROR - re-copy full file!"
            return
        end
        for _, id in ipairs(SUITE) do
            if TESTS[id] then runTestSync(id); task.wait(2) end
        end
        suiteBtn.Text = "RUN PRIORITY SUITE  (10 key tests, automatic)"
        log("INFO", "Suite finished. Summary is above, details are in the LOG tab.")
    end)
end)

addHeader("START", "RESULTS SUMMARY")
testCounter = testCounter + 1
local sumRow = mk("Frame", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW,
    BorderSizePixel = 0, LayoutOrder = testCounter}, contentFrames["START"])
mk("UICorner", {CornerRadius = UDim.new(0, 4)}, sumRow)
local sumP = mk("TextLabel", {Size = UDim2.new(0.33, 0, 1, 0), BackgroundTransparency = 1,
    Text = "PASSED (safe): 0", Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = GREEN}, sumRow)
local sumF = mk("TextLabel", {Size = UDim2.new(0.34, 0, 1, 0), Position = UDim2.new(0.33, 0, 0, 0),
    BackgroundTransparency = 1, Text = "FAILED (fix me): 0", Font = Enum.Font.GothamBold, TextSize = 13,
    TextColor3 = RED}, sumRow)
local sumR = mk("TextLabel", {Size = UDim2.new(0.33, 0, 1, 0), Position = UDim2.new(0.67, 0, 0, 0),
    BackgroundTransparency = 1, Text = "TO REVIEW: 0", Font = Enum.Font.GothamBold, TextSize = 13,
    TextColor3 = DIM}, sumRow)
testCounter = testCounter + 1
local sumList = mk("TextBox", {Size = UDim2.new(1, 0, 0, 58), BackgroundColor3 = Color3.fromRGB(8, 9, 12),
    Text = "No results yet - run the suite!", Font = Enum.Font.Code, TextSize = 12, TextColor3 = TXT,
    TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
    MultiLine = true, TextEditable = false, ClearTextOnFocus = false, BorderSizePixel = 0,
    LayoutOrder = testCounter}, contentFrames["START"])
mk("UICorner", {CornerRadius = UDim.new(0, 4)}, sumList)
SummaryVals = {pass = sumP, fail = sumF, rev = sumR, list = sumList}

-- ============================ SETUP ========================================
addHeader("SETUP", "CONTEXT - refresh first, then pick targets")
addNote("SETUP", "Run on a NON-ADMIN alt. Pick a JUNK item for destructive tests.")

addTest("SETUP", "S0", "Refresh ALL context (inv, vicinity, npcs, players, ai, db)", "safe", function()
    refreshInventory(); refreshVicinity(); refreshNPCs(); refreshAI(); refreshPlayers(); refreshItemIDs(); refreshBalance()
    for _, f in ipairs(SelectorRefresh or {}) do pcall(f) end
    return "INFO", string.format("inv=%d vic=%d npc=%d ai=%d players=%d itemIDs=%d bal=%s",
        #CTX.invItems, #CTX.vicItems, #CTX.npcs, #CTX.aitargets, #CTX.players, #CTX.itemIDs, tostring(CTX.balance))
end)

table.insert(SelectorRefresh, addDropdown("SETUP", "My item (use JUNK!)", function()
    local t = {}
    for _, e in ipairs(CTX.invItems) do
        table.insert(t, string.format("%s | idx=%s | %s", e.ID, tostring(e.index), tostring(e.tied)))
    end
    return t
end, function() return CTX.invSel end, function(i) CTX.invSel = i end))

table.insert(SelectorRefresh, addDropdown("SETUP", "Vicinity item", function()
    local t = {}
    for _, e in ipairs(CTX.vicItems) do
        table.insert(t, string.format("%s | idx=%s", e.ID, tostring(e.index)))
    end
    return t
end, function() return CTX.vicSel end, function(i) CTX.vicSel = i end))

table.insert(SelectorRefresh, addDropdown("SETUP", "Trader NPC", function()
    local t = {}
    for _, n in ipairs(CTX.npcs) do table.insert(t, n:GetFullName()) end
    return t
end, function() return CTX.npcSel end, function(i) CTX.npcSel = i end))

table.insert(SelectorRefresh, addDropdown("SETUP", "Target player", function()
    local t = {}
    for _, p in ipairs(CTX.players) do
        table.insert(t, p.Name .. (p == LocalPlayer and " (YOU)" or " (alt)"))
    end
    return t
end, function() return CTX.playerSel end, function(i) CTX.playerSel = i end))

table.insert(SelectorRefresh, addDropdown("SETUP", "Hostile AI", function()
    local t = {}
    for _, m in ipairs(CTX.aitargets) do
        local hum = m:FindFirstChildOfClass("Humanoid")
        table.insert(t, m.Name .. " | hp=" .. (hum and math.floor(hum.Health) or "?"))
    end
    return t
end, function() return CTX.aiSel end, function(i) CTX.aiSel = i end))

table.insert(SelectorRefresh, addDropdown("SETUP", "Spoof item ID", function()
    return CTX.itemIDs
end, function() return CTX.itemSel end, function(i) CTX.itemSel = i end))

table.insert(SelectorRefresh, addDropdown("SETUP", "Faction key", function()
    return CTX.factions
end, function() return CTX.factionSel end, function(i) CTX.factionSel = i end))

addTest("SETUP", "S1", "Dump remote inventory (all folders)", "safe", function()
    for _, f in ipairs({Remotes, TaskRemotes, SquadRemotes,
        ReplicatedStorage:FindFirstChild("PdaRemotes"),
        ReplicatedStorage:FindFirstChild("ContactRemotes"),
        ReplicatedStorage:FindFirstChild("ReplecsRemotes"),
        ReplicatedStorage:FindFirstChild("JABBY_REMOTES")}) do
        if f then
            local ev, fn = 0, 0
            for _, c in ipairs(f:GetChildren()) do
                if c:IsA("RemoteEvent") or c:IsA("UnreliableRemoteEvent") then ev = ev + 1
                elseif c:IsA("RemoteFunction") then fn = fn + 1 end
            end
            log("INFO", string.format("%s: %d events, %d functions", f.Name, ev, fn))
        end
    end
    return "INFO", "see log"
end)

addTest("SETUP", "S2", "Dump my full inventory (check scoping)", "safe", function()
    if #CTX.invItems == 0 then refreshInventory() end
    for i, e in ipairs(CTX.invItems) do
        if i <= 40 then
            log("INFO", string.format("  %s idx=%s tied=%s src=%s", e.ID, tostring(e.index), tostring(e.tied), tostring(e.src)))
        end
    end
    return "INFO", tostring(#CTX.invItems) .. " items (capped at 40 shown)"
end)

-- ============================ CRITICAL =====================================
addHeader("CRITICAL", "C1 - ADMIN REMOTES (must fail on non-admin alt!)")

addTest("CRITICAL", "C1b", 'AdminRunCommand "where" (benign self-cmd)', "safe", function()
    local ok, err = fireEv("AdminRunCommand", "where", {"where"})
    log("INFO", "fired where -> " .. tostring(ok) .. " " .. short(err))
    log("INFO", "Watch for a toast/return. If the server EXECUTES it, C1 is live - then try C1d.")
    return "INFO", "check for server reaction (toast/chat/log on main)"
end)

addTest("CRITICAL", "C1c", "AdminSpawnItem self x1 (selected spoof ID)", "danger", function()
    local id = selItemID()
    if not id then return "INFO", "no item DB" end
    local before = #CTX.invItems
    local ok, err = fireEv("AdminSpawnItem", id, 1)
    task.wait(1)
    refreshInventory()
    log("INFO", string.format("spawn %s -> fired=%s inv %d -> %d", id, tostring(ok), before, #CTX.invItems))
    if #CTX.invItems > before then
        return "FAIL", "ITEM SPAWNED for non-admin - critical"
    end
    return "PASS", "no item granted"
end)

local c1cmd = addInput("CRITICAL", "Cmd", "addroubles")
local c1arg = addInput("CRITICAL", "Arg", "10000")
addTest("CRITICAL", "C1d", "AdminRunCommand CUSTOM (DANGER)", "danger", function()
    local bal0 = CTX.balance
    refreshBalance(); bal0 = CTX.balance
    local ok, err = fireEv("AdminRunCommand", c1cmd.Text, {c1arg.Text})
    task.wait(1)
    refreshBalance()
    log("INFO", string.format("cmd=%s arg=%s bal %s -> %s", c1cmd.Text, c1arg.Text, tostring(bal0), tostring(CTX.balance)))
    return "INFO", "compare balance / watch main for effect"
end)
addNote("CRITICAL", 'Try: addroubles, roubles 0, god, heal, tp <name>, ban <alt> perm. NEVER on real players.')

addHeader("CRITICAL", "C2 - ITEM-ID SPOOF (transmutation)")
addNote("CRITICAL", "Drops your SELECTED item while claiming a different ID. Pick junk!")

addTest("CRITICAL", "C2b", 'ContextMenuAction "Take" with forged id', "caution", function()
    local v = selVic()
    local spoof = selItemID()
    if not v then return "INFO", "need a vicinity item (drop junk nearby, refresh)" end
    local ok, err = fireEv("ContextMenuAction", "Take", v.index, v.tied, spoof)
    task.wait(1); refreshInventory()
    log("INFO", "Take forged -> " .. tostring(ok) .. " " .. short(err))
    return "INFO", "check if you received " .. tostring(spoof) .. " instead of " .. v.ID
end)

addHeader("CRITICAL", "C3 - MONEY (DropRoubles)")
addTest("CRITICAL", "C3c", "DropRoubles(1) control + re-pickup", "caution", function()
    refreshBalance(); local b0 = CTX.balance
    fireEv("DropRoubles", 1)
    task.wait(1); refreshBalance(); refreshVicinity()
    for _, v in ipairs(CTX.vicItems) do
        fireEv("PickupCurrency", v.tied, v.index)
    end
    task.wait(1); refreshBalance()
    return "INFO", string.format("bal %s -> %s (should end equal if honest)", tostring(b0), tostring(CTX.balance))
end)

-- ============================ DUPES ========================================
addHeader("DUPES", "H1 - INVENTORY RACE DUPES (use JUNK item!)")

addTest("DUPES", "D3b", "UseItemByType x10 (hotbar path)", "caution", function()
    local e = findConsumable()
    local auto = (e ~= nil)
    if not e then e = selInv() end
    if not e then return "INFO", "select item first" end
    log("INFO", (auto and "auto-picked consumable: " or "no consumable found, using picked: ") .. e.ID)
    refreshInventory()
    local before = countItem(e.ID)
    for _ = 1, 10 do fireEv("UseItemByType", e.ID) end
    task.wait(1.5); refreshInventory()
    local after = countItem(e.ID)
    log("INFO", string.format("%s count %d -> %d", e.ID, before, after))
    local c0 = before - after
    if c0 == 0 then return "INFO", "consumed 0 for 10 fires - gate unmet (meds need missing HP, food may need hunger)" end
    return "INFO", "consumed " .. c0 .. " for 10 fires (want <=1 effect)"
end)

addTest("DUPES", "D4", "Double-MOVE same index to 2 grids", "caution", function()
    local e = selInv()
    if not e then return "INFO", "select item first" end
    refreshInventory()
    local before = countItem(e.ID)
    log("INFO", "racing " .. e.ID .. " (baseline count=" .. before .. ")")
    local dests = {}
    for _, t in ipairs(CTX.tiedList) do
        if t ~= e.tied then table.insert(dests, t) end
    end
    if #dests < 2 then
        -- fall back: same-grid reposition race via MoveItem
        log("INFO", "only 1 grid known - racing MoveItem reposition instead")
        local r1, r2
        task.spawn(function() r1 = {callFn(Remotes, "MoveItem", e.index, e.tied, Vector2.new(0,0), 0)} end)
        task.spawn(function() r2 = {callFn(Remotes, "MoveItem", e.index, e.tied, Vector2.new(2,2), 0)} end)
        task.wait(1.5)
        log("INFO", "r1=" .. dump(r1) .. " r2=" .. dump(r2))
        refreshInventory()
        local after0 = countItem(e.ID)
        if after0 > before then return "FAIL", "count " .. before .. " -> " .. after0 .. " - DUPE CONFIRMED" end
        return "INFO", "count " .. before .. " -> " .. after0 .. " (stable = good)"
    end
    local r1, r2
    task.spawn(function() r1 = {callFn(Remotes, "MoveItemAcrossItemManager", e.index, e.tied, dests[1], Vector2.new(0,0), 0)} end)
    task.spawn(function() r2 = {callFn(Remotes, "MoveItemAcrossItemManager", e.index, e.tied, dests[2], Vector2.new(0,0), 0)} end)
    task.wait(1.5)
    log("INFO", "to " .. tostring(dests[1]) .. " -> " .. dump(r1))
    log("INFO", "to " .. tostring(dests[2]) .. " -> " .. dump(r2))
    refreshInventory()
    local after = countItem(e.ID)
    local acc1 = r1 and r1[1] == true and r1[2] == true
    local acc2 = r2 and r2[1] == true and r2[2] == true
    log("INFO", string.format("count %d -> %d, accepted: move1=%s move2=%s", before, after, tostring(acc1), tostring(acc2)))
    if after > before then return "FAIL", "count " .. before .. " -> " .. after .. " - DUPE CONFIRMED" end
    if after < before then return "INFO", "count DROPPED " .. before .. " -> " .. after .. " - item lost?? verify!" end
    if not acc1 and not acc2 then return "PASS", "both moves denied, count stable" end
    return "PASS", "count stable (" .. after .. "); exactly one move won = correct"
end)

addTest("DUPES", "D1", "DropItem + TraderConfirmSell RACE", "caution", function()
    local e, npc = selInv(), selNPC()
    if not e then return "INFO", "select item first" end
    if not npc then return "INFO", "select trader NPC first" end
    local entry = {itemID = e.ID, qty = 1, sourceInv = e.tied, position = nil, itemIndex = e.index}
    local r1
    task.spawn(function() fireEv("DropItem", e.index, e.tied, e.ID) end)
    task.spawn(function() r1 = {callFn(Remotes, "TraderConfirmSell", npc, {entry})} end)
    task.wait(1.5)
    log("INFO", "sell -> " .. dump(r1))
    refreshInventory(); refreshVicinity()
    local inInv = countItem(e.ID) > 0
    local inVic = false
    for _, v in ipairs(CTX.vicItems) do if v.ID == e.ID then inVic = true end end
    log("INFO", "inInv=" .. tostring(inInv) .. " inVic=" .. tostring(inVic))
    if inInv and inVic then return "FAIL", "item BOTH kept/sold AND dropped - dupe!" end
    return "INFO", "want exactly one of (sold, dropped, kept)"
end)

addTest("DUPES", "D7", "TraderConfirmSell SAME entry x5 (multi-pay?)", "caution", function()
    local e, npc = selInv(), selNPC()
    if not e then return "INFO", "select item first" end
    if not npc then return "INFO", "select trader NPC first" end
    refreshBalance(); local b0 = CTX.balance
    local entry = {itemID = e.ID, qty = 1, sourceInv = e.tied, position = nil, itemIndex = e.index}
    local ok, res = callFn(Remotes, "TraderConfirmSell", npc, {entry, entry, entry, entry, entry})
    task.wait(1); refreshBalance(); refreshInventory()
    log("INFO", "sell x5 same -> ok=" .. tostring(ok) .. " res=" .. dump(res, 1))
    log("INFO", string.format("bal %s -> %s, left=%d", tostring(b0), tostring(CTX.balance), countItem(e.ID)))
    if ok and type(res) == "table" and (res.sold or 0) > 1 then
        return "FAIL", "paid " .. tostring(res.sold) .. "x for ONE item!"
    end
    return "PASS", "paid at most once"
end)

addTest("DUPES", "D6", "QuickTake / Take RACE (vicinity item)", "caution", function()
    local v = selVic()
    if not v then return "INFO", "need vicinity item (drop junk, refresh)" end
    local r1, r2
    task.spawn(function() r1 = {callFn(Remotes, "QuickTakeItem", v.tied, v.index)} end)
    task.spawn(function() r2 = {callFn(Remotes, "QuickTakeItem", v.tied, v.index)} end)
    task.wait(1.5)
    log("INFO", "take1=" .. dump(r1) .. " take2=" .. dump(r2))
    refreshInventory()
    local n = countItem(v.ID)
    return "INFO", "received " .. n .. "x (want 1). If 2 visible and both true = FAIL"
end)

addTest("DUPES", "D5", "RepackMagazine x2 CONCURRENT (ammo create?)", "caution", function()
    local e = selInv()
    if not e then return "INFO", "select ammo/mag item first" end
    fireEv("RepackMagazine", e.index, e.tied, e.index, e.tied)
    fireEv("RepackMagazine", e.index, e.tied, e.index, e.tied)
    task.wait(1.5); refreshInventory()
    return "INFO", "fired same repack 2x concurrently - inspect ammo counts for creation"
end)

addTest("DUPES", "D9", "BarterContribute + MOVE race", "caution", function()
    local e = selInv()
    if not e then return "INFO", "select item first" end
    local dest = nil
    for _, t in ipairs(CTX.tiedList) do if t ~= e.tied then dest = t; break end end
    local r1
    task.spawn(function() r1 = {callFn(Remotes, "BarterContributeItem", e.tied, e.index, "TEST")} end)
    if dest then
        task.spawn(function() callFn(Remotes, "MoveItemAcrossItemManager", e.index, e.tied, dest, Vector2.new(0,0), 0) end)
    else
        task.spawn(function() fireEv("DropItem", e.index, e.tied, e.ID) end)
    end
    task.wait(1.5)
    log("INFO", "contribute -> " .. dump(r1))
    refreshInventory()
    return "INFO", "if contribute ok AND item still in inv/dropped = dupe"
end)

-- ============================ ECONOMY ======================================
addHeader("ECONOMY", "H2 - BUY (qty is client-controlled)")
addNote("ECONOMY", "Uses selected TRADER + SPOOF ID as the item to buy. DANGER = spends money.")

local function buyTest(qty)
    local npc, id = selNPC(), selItemID()
    if not npc then return "INFO", "select trader NPC" end
    if not id then return "INFO", "no item DB" end
    refreshBalance(); local b0 = CTX.balance
    local ok, res = callFn(Remotes, "BuyBulk", npc, {{itemID = id, qty = qty}})
    task.wait(1); refreshBalance(); refreshInventory()
    log("INFO", string.format("buy %s x%s -> ok=%s res=%s bal %s->%s got=%d",
        id, tostring(qty), tostring(ok), dump(res, 1), tostring(b0), tostring(CTX.balance), countItem(id)))
    return ok, res
end

addTest("ECONOMY", "H2b", "BuyBulk qty=0", "danger", function()
    local ok, res = buyTest(0)
    if ok and type(res) == "table" and (res.bought or 0) > 0 then return "FAIL", "zero qty bought!" end
    return "PASS", "rejected"
end)
addTest("ECONOMY", "H2c", "BuyBulk qty=2147483647 (overflow)", "danger", function()
    local ok, res = buyTest(2147483647)
    if ok and type(res) == "table" and (res.bought or 0) > 0 then return "FAIL", "huge qty bought - check price math!" end
    return "PASS", "rejected"
end)
addTest("ECONOMY", "H2d", "BuyBulk qty=99999 (over funds)", "danger", function()
    local ok, res = buyTest(99999)
    if ok and type(res) == "table" and (res.bought or 0) > 0 then return "FAIL", "bought without funds!" end
    return "PASS", "rejected"
end)

addHeader("ECONOMY", "H3 - BARTER (currency amount from client)")
addTest("ECONOMY", "H3a", "BarterAutoFillPreview (read)", "safe", function()
    local ok, res = callFn(Remotes, "BarterAutoFillPreview")
    log("INFO", "preview -> ok=" .. tostring(ok) .. " " .. dump(res, 2))
    return "INFO", "inspect shape for H3b"
end)
local barterID = addInput("ECONOMY", "Currency id", "Rouble")
local barterAmt = addInput("ECONOMY", "Amount", "999999")
addTest("ECONOMY", "H3b", "BarterAutoFillCommit MANUAL inflated", "danger", function()
    refreshBalance(); local b0 = CTX.balance
    local t = {items = {}, currency = {{itemId = barterID.Text, amount = tonumber(barterAmt.Text) or 0}}}
    local ok, res = callFn(Remotes, "BarterAutoFillCommit", t)
    task.wait(1); refreshBalance()
    log("INFO", "commit -> ok=" .. tostring(ok) .. " res=" .. dump(res, 1) .. string.format(" bal %s->%s", tostring(b0), tostring(CTX.balance)))
    if ok and type(res) == "table" and res.ok then
        return "INFO", "accepted - verify debit == progress (check stash size vs balance)"
    end
    return "PASS", "rejected"
end)

addHeader("ECONOMY", "H4/H5 - KITS & CLAIMS (idempotency)")
addTest("ECONOMY", "H4", "TutorialAcceptIntro x5 (free kits?)", "caution", function()
    refreshInventory(); local b0 = #CTX.invItems
    for i = 1, 5 do fireEv("TutorialAcceptIntro", "test" .. i); task.wait(0.15) end
    task.wait(1.5); refreshInventory()
    local gained = #CTX.invItems - b0
    log("INFO", "items " .. b0 .. " -> " .. #CTX.invItems .. " (+" .. gained .. ")")
    if gained > 8 then return "FAIL", "MULTIPLE kits granted (" .. gained .. " items)!" end
    if gained > 0 then return "INFO", "one kit granted (first-time?) - run again, want +0" end
    return "PASS", "no kit (already claimed or rejected)"
end)

addTest("ECONOMY", "H5a", "DailyLoginClaim x2 CONCURRENT", "caution", function()
    local r1, r2
    task.spawn(function() r1 = {callFn(Remotes, "DailyLoginClaim")} end)
    task.spawn(function() r2 = {callFn(Remotes, "DailyLoginClaim")} end)
    task.wait(1.5)
    log("INFO", "c1=" .. dump(r1) .. " c2=" .. dump(r2))
    return "INFO", "both ok=true with rewards = FAIL (double pay)"
end)

addTest("ECONOMY", "H5b", "CollectPendingRewards x2 CONCURRENT", "caution", function()
    local r1, r2
    task.spawn(function() r1 = {callFn(Remotes, "CollectPendingRewards")} end)
    task.spawn(function() r2 = {callFn(Remotes, "CollectPendingRewards")} end)
    task.wait(1.5)
    log("INFO", "c1=" .. dump(r1) .. " c2=" .. dump(r2))
    return "INFO", "both ok=true with rewards = FAIL (double pay)"
end)

addTest("ECONOMY", "H5c", "MainTaskTurnIn x2 CONCURRENT", "caution", function()
    local r1, r2
    task.spawn(function() r1 = {callFn(Remotes, "MainTaskTurnIn")} end)
    task.spawn(function() r2 = {callFn(Remotes, "MainTaskTurnIn")} end)
    task.wait(1.5)
    log("INFO", "c1=" .. dump(r1) .. " c2=" .. dump(r2))
    return "INFO", "both rewarded = FAIL"
end)

local taskInput = addInput("ECONOMY", "Task/quest id", "")
addTest("ECONOMY", "H5d", "HandinTask(taskId) x2 (need id)", "caution", function()
    if not TaskRemotes then return "INFO", "no TaskRemotes" end
    if taskInput.Text == "" then return "INFO", "enter a completed task id first" end
    local r1 = {callFn(TaskRemotes, "HandinTask", taskInput.Text, "TestNPC")}
    task.wait(0.5)
    local r2 = {callFn(TaskRemotes, "HandinTask", taskInput.Text, "TestNPC")}
    log("INFO", "h1=" .. dump(r1) .. " h2=" .. dump(r2))
    return "INFO", "both ok = FAIL"
end)

addHeader("ECONOMY", "MAGS / SKINS / FACTION")
addTest("ECONOMY", "E1", "LoadWeaponMag x5 spam (one mag fills 5x?)", "caution", function()
    for _ = 1, 5 do fireEv("LoadWeaponMag", "Primary") end
    task.wait(1.5)
    local gun = findGun()
    if gun then
        local ammo = gun:FindFirstChild("Ammo")
        local mag = ammo and ammo:FindFirstChild("MagAmmo")
        log("INFO", "MagAmmo=" .. (mag and (mag.Value .. "/" .. mag.MaxValue) or "?"))
    end
    refreshInventory()
    return "INFO", "compare mag count vs fills - mag consumed exactly once = good"
end)

local skinType = addInput("ECONOMY", "Skin itemType", "AKM")
local skinID = addInput("ECONOMY", "Skin id", "TEST_SKIN")
addTest("ECONOMY", "E2", "ApplySkin UNOWNED (paid skin free?)", "caution", function()
    local ok0, owned0 = callFn(Remotes, "GetUnlockedSkins")
    log("INFO", "owned before: " .. dump(owned0, 1))
    fireEv("ApplySkin", skinType.Text, skinID.Text)
    task.wait(1)
    local ok1, owned1 = callFn(Remotes, "GetUnlockedSkins")
    log("INFO", "owned after: " .. dump(owned1, 1))
    return "INFO", "check gun appearance - skin applied without ownership = FAIL"
end)

addTest("ECONOMY", "E3", "SubmitVeteranFactionPick (ONE-TIME!)", "danger", function()
    local key = CTX.factions[CTX.factionSel]
    fireEv("SubmitVeteranFactionPick", key)
    task.wait(1.5); refreshInventory()
    return "INFO", "fired " .. key .. " - non-veteran receiving pack = FAIL"
end)

-- ============================ COMBAT =======================================
addHeader("COMBAT", "C4 - GUN TRUST (needs consenting ALT victim!)")
addNote("COMBAT", "DANGER tests damage the VICTIM. Solo? Use HOSTILE AI via the toggle. Private server!")
testCounter = testCounter + 1
local victimBtn = mk("TextButton", {Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = Color3.fromRGB(70, 60, 40),
    Text = "VICTIM: ALT PLAYER  (click = HOSTILE AI)", Font = Enum.Font.GothamBold, TextSize = 13,
    TextColor3 = TXT, BorderSizePixel = 0, LayoutOrder = testCounter}, contentFrames["COMBAT"])
mk("UICorner", {CornerRadius = UDim.new(0, 6)}, victimBtn)
victimBtn.MouseButton1Click:Connect(function()
    CTX.useAI = not CTX.useAI
    victimBtn.Text = CTX.useAI
        and ("VICTIM: HOSTILE AI (" .. #(CTX.aitargets or {}) .. " found)  (click = ALT PLAYER)")
        or "VICTIM: ALT PLAYER  (click = HOSTILE AI)"
    victimBtn.BackgroundColor3 = CTX.useAI and Color3.fromRGB(90, 50, 50) or Color3.fromRGB(70, 60, 40)
    log("WARN", "Combat victim = " .. (CTX.useAI and "HOSTILE AI (pick one in the SETUP dropdown)" or "ALT PLAYER"))
end)
testCounter = testCounter + 1
local tpBtn = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = Color3.fromRGB(50, 70, 90),
    Text = "TP TO VICTIM (8m, for close-range tests)", Font = Enum.Font.GothamBold, TextSize = 12,
    TextColor3 = TXT, BorderSizePixel = 0, LayoutOrder = testCounter}, contentFrames["COMBAT"])
mk("UICorner", {CornerRadius = UDim.new(0, 6)}, tpBtn)
tpBtn.MouseButton1Click:Connect(function()
    local head = victimHead()
    if not head then
        log("WARN", "TP: no victim - pick ALT player or HOSTILE AI first")
        return
    end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then log("WARN", "TP: no character"); return end
    pcall(function()
        char:PivotTo(CFrame.new(head.Position + Vector3.new(0, 4, 8), head.Position))
    end)
    log("WARN", "TP'd to 8m of victim, facing it. Run C4a / C5a / G2 now.")
end)

addTest("COMBAT", "G0", "Inspect equipped gun + ammo", "safe", function()
    local gun = findGun()
    if not gun then return "INFO", "equip a gun first" end
    local ammo = gun:FindFirstChild("Ammo")
    local mag = ammo and ammo:FindFirstChild("MagAmmo")
    local res = ammo and ammo:FindFirstChild("ReserveAmmo")
    log("INFO", "gun=" .. gun:GetFullName())
    log("INFO", "Mag=" .. (mag and (mag.Value .. "/" .. mag.MaxValue) or "?") ..
        " Reserve=" .. (res and tostring(res.Value) or "?"))
    return "INFO", "done"
end)

addTest("COMBAT", "G1", "Dump gun internals (chamber/firemode hunt)", "safe", function()
    local gun = findGun()
    if not gun then return "INFO", "equip a gun first" end
    log("INFO", "gun=" .. gun:GetFullName())
    local ok, attrs = pcall(function() return gun:GetAttributes() end)
    if ok and type(attrs) == "table" then
        for k, v in pairs(attrs) do
            log("INFO", "  attr " .. tostring(k) .. " = " .. short(v, 60))
        end
    end
    for _, d in ipairs(gun:GetDescendants()) do
        if d:IsA("BoolValue") or d:IsA("IntValue") or d:IsA("NumberValue")
            or d:IsA("StringValue") or d:IsA("ObjectValue") then
            local nl = string.lower(d.Name)
            local suspect = string.find(nl, "chamber", 1, true) or string.find(nl, "firemode", 1, true)
                or string.find(nl, "fire mode", 1, true) or string.find(nl, "mode", 1, true)
                or string.find(nl, "auto", 1, true) or string.find(nl, "ammo", 1, true)
            local val = "?"
            pcall(function() val = tostring(d.Value) end)
            log("INFO", "  " .. d.ClassName .. " " .. d.Name .. " = " .. short(val, 60)
                .. (suspect and "  <== SUSPECT" or ""))
        end
    end
    return "INFO", "paste this dump - chamber/firemode names exposed above"
end)

addTest("COMBAT", "G2", "Pin Chambered+AUTO 15s (YOU mag-dump victim)", "caution", function()
    local gun = findGun()
    if not gun then return "INFO", "equip a gun first" end
    if gun.Parent ~= LocalPlayer.Character then
        return "INFO", "EQUIP the gun (hold it in your hands), then run"
    end
    local chamber = gun:FindFirstChild("Chambered")
    local fmode = gun:FindFirstChild("FireMode")
    if not chamber or not fmode then
        return "INFO", "no Chambered/FireMode on " .. gun.Name
    end
    local ammo = gun:FindFirstChild("Ammo")
    local mag = ammo and ammo:FindFirstChild("MagAmmo")
    local m0 = (mag and mag.Value) or -1
    if m0 < 0 then return "INFO", "could not read mag" end
    local head, hum, vname, isSelf = victimHead()
    if not head or isSelf then
        return "INFO", "pick a victim first (HOSTILE AI toggle + SETUP picker)"
    end
    local vdist = 0
    pcall(function()
        vdist = (LocalPlayer.Character.HumanoidRootPart.Position - head.Position).Magnitude
    end)
    if vdist > 500 then
        return "INFO", "victim is " .. string.format("%.0f", vdist) .. "m away - walk CLOSE to it, then re-run"
    end
    if vdist > 150 then
        log("WARN", "victim is " .. string.format("%.0f", vdist) .. "m - TP to it! Aiming past 150m is hopeless.")
    end
    pcall(function()
        local hrp0 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp0 then hrp0.CFrame = CFrame.new(hrp0.Position, head.Position) end
    end)
    log("INFO", "facing victim - keep your MOUSE IN THE GAME VIEW (not on buttons) for the full window")
    log("INFO", string.format("gun=%s Mag=%s Chambered=%s(%s) FireMode=%s(%s) victim=%s",
        gun:GetFullName(), tostring(m0), short(chamber.Value), chamber.ClassName,
        short(fmode.Value), fmode.ClassName, vname))
    if m0 ~= 0 then
        return "INFO", "mag must read EMPTY first (fire it dry - pin only takes on empty), then re-run"
    end
    local lr, cmr, bolt = nil, nil, nil
    pcall(function() lr = gun:GetAttribute("LoadedRounds") end)
    pcall(function() cmr = gun:GetAttribute("CurrentMagRounds") end)
    pcall(function()
        local b = gun:FindFirstChild("BoltReady")
        if b then bolt = b.Value end
    end)
    local lrc = (type(lr) == "table") and #lr or (lr ~= nil and "non-table?!" or "ABSENT")
    log("INFO", "ammo-state: CurrentMagRounds=" .. tostring(cmr) .. " LoadedRounds=" .. tostring(lrc) .. " BoltReady=" .. tostring(bolt))
    local h0 = hum.Health
    local c0, f0 = chamber.Value, fmode.Value
    pcall(function() fmode.Value = 2 end)
    task.wait(0.2)
    -- pin loop: the game's own fire logic rewrites Chambered, so win every frame.
    -- FireMode pinned too (nothing rewrites it, but belt + suspenders).
    local stop = false
    local conn = RunService.Heartbeat:Connect(function()
        if stop then return end
        pcall(function()
            if chamber.Value ~= true then chamber.Value = true end
            if fmode.Value ~= 2 then fmode.Value = 2 end
        end)
    end)
    task.wait(0.5)
    local fv, cv = nil, nil
    pcall(function() fv = fmode.Value end)
    pcall(function() cv = chamber.Value end)
    if fv == 2 and cv == true then
        log("INFO", "verify: writes TOOK (FireMode=2 Chambered=true on " .. gun:GetFullName() .. ")")
    else
        log("WARN", "verify FAILED: FireMode=" .. tostring(fv) .. " Chambered=" .. tostring(cv) .. " - paste this line!")
    end
    log("WARN", "PINNED 15s - HOLD TRIGGER on " .. vname .. " YOURSELF (no auto-clicker). Touch nothing else!")
    local lastH = h0
    for _ = 1, 30 do
        if chamber.Parent == nil or fmode.Parent == nil then
            log("WARN", "gun instance DESTROYED mid-run (re-equip/death?) - pin lost, aborting")
            break
        end
        task.wait(0.5)
        local hc = lastH
        pcall(function() hc = hum.Health end)
        if hc ~= lastH then
            log("INFO", "victim hp " .. tostring(lastH) .. " -> " .. tostring(hc) .. " DURING window")
            lastH = hc
        end
    end
    stop = true
    if conn then conn:Disconnect() end
    pcall(function() chamber.Value = c0 end)
    pcall(function() fmode.Value = f0 end)
    local h1 = h0
    pcall(function() h1 = hum.Health end)
    log("INFO", string.format("victim hp %s -> %s (dmg=%s), flags restored", tostring(h0), tostring(h1), tostring(h0 - h1)))
    if h1 < h0 then
        return "FAIL", "DAMAGE FROM AN EMPTY MAG while pinned - infinite ammo CONFIRMED server-side!"
    end
    return "INFO", "no damage - keep AIMED at the victim the whole window, or server rejected it (visual-only)"
end)

local evilMod = {
    damage = {Head = 9999, Torso = 9999, Other = 9999},
    fireRate = 0.01, muzzleVelocity = 99999,
    armorPenMultiplier = 9999, ammoType = "AP",
    spread = 0, shotgunPellets = 10,
}

addTest("COMBAT", "C4a", "BulletHit victim HEAD (LOS/range test)", "danger", function()
    local gun = findGun()
    if not gun then return "INFO", "equip a gun first" end
    local head, hum, vname, isSelf = victimHead()
    if not head then return "INFO", CTX.useAI and "no AI target - run S0 near hostiles, pick one in SETUP" or "need target player with character" end
    if isSelf then return "INFO", "pick your ALT, not yourself (or switch victim to HOSTILE AI)" end
    local b, err = bridge("BulletHit")
    if not b then return "INFO", "no BulletHit bridge: " .. short(err) end
    local h0 = hum.Health
    local dist = (LocalPlayer.Character.HumanoidRootPart.Position - head.Position).Magnitude
    log("INFO", string.format("victim=%s hp=%s dist=%.1f (stand FAR / behind WALL)", vname, tostring(h0), dist))
    pcall(function()
        b:Fire(gun, {Position = head.Position, Normal = Vector3.yAxis, Instance = head},
            CFrame.new(head.Position), evilMod)
    end)
    task.wait(1)
    local h1 = hum.Health
    log("INFO", string.format("hp %s -> %s (dmg=%s)", tostring(h0), tostring(h1), tostring(h0 - h1)))
    if h1 >= h0 then return "PASS", "no damage through wall/distance (or already dead)" end
    if h0 - h1 > 500 then return "FAIL", "MASSIVE damage - server trusts client ModTable damage!" end
    return "FAIL", "damaged through wall/distance - missing LOS/range check (dmg=" .. (h0-h1) .. ")"
end)

addTest("COMBAT", "C4b", "BulletHit x30 BURST (rate-limit test)", "danger", function()
    local gun = findGun()
    if not gun then return "INFO", "equip a gun first" end
    local head, hum, vname, isSelf = victimHead()
    if not head or isSelf then return "INFO", "need victim: ALT player or HOSTILE AI (toggle above)" end
    local b = bridge("BulletHit")
    if not b then return "INFO", "no bridge" end
    log("INFO", "victim=" .. vname)
    local h0 = hum.Health
    for _ = 1, 30 do
        pcall(function()
            b:Fire(gun, {Position = head.Position, Normal = Vector3.yAxis, Instance = head},
                CFrame.new(head.Position), {damage = {Head = 1, Torso = 1, Other = 1}})
        end)
    end
    task.wait(1.5)
    local h1 = hum.Health
    log("INFO", string.format("30 hits -> hp %s -> %s (dmg=%s)", tostring(h0), tostring(h1), tostring(h0-h1)))
    if h0 - h1 <= 0 then return "PASS", "burst did nothing (rate/dead)" end
    return "INFO", "dmg=" .. (h0-h1) .. " - if this equals ~30x single-hit dmg, NO rate limit (FAIL)"
end)

addTest("COMBAT", "C4c", "PlayerFire 10x no reload (ammo honesty)", "caution", function()
    local gun = findGun()
    if not gun then return "INFO", "equip a gun first" end
    local b = bridge("PlayerFire")
    if not b then return "INFO", "no PlayerFire bridge" end
    local ammo = gun:FindFirstChild("Ammo")
    local mag = ammo and ammo:FindFirstChild("MagAmmo")
    local m0 = mag and mag.Value or -1
    local cf = LocalPlayer.Character.HumanoidRootPart.CFrame
    for _ = 1, 10 do pcall(function() b:Fire(cf, {}) end) end
    task.wait(1.5)
    local m1 = mag and mag.Value or -1
    log("INFO", string.format("MagAmmo %s -> %s after 10 forced fires", tostring(m0), tostring(m1)))
    if m0 < 0 then return "INFO", "could not read mag" end
    local want = math.min(10, m0)
    if want == 0 then return "INFO", "mag is EMPTY - reload first (firing air proves nothing)" end
    if m0 - m1 >= want then return "PASS", "server decremented per shot (" .. (m0-m1) .. "/" .. want .. ")" end
    return "INFO", "decremented " .. (m0-m1) .. "/" .. want .. " - investigate"
end)

addHeader("COMBAT", "C5 - MELEE TRUST")
addTest("COMBAT", "C5a", "Melee hit victim from RANGE", "danger", function()
    local tool = findMelee()
    if not tool then return "INFO", "equip/hold a MELEE weapon first" end
    local head, hum, vname, isSelf = victimHead()
    if not head or isSelf then return "INFO", "need victim: ALT player or HOSTILE AI (toggle above)" end
    local h0 = hum.Health
    local dist = (LocalPlayer.Character.HumanoidRootPart.Position - head.Position).Magnitude
    log("INFO", string.format("victim=%s hp=%s dist=%.1f (stand FAR away)", vname, tostring(h0), dist))
    pcall(function()
        tool.Remotes.RemoteEventMelee:FireServer(head, head.Position, Vector3.yAxis)
    end)
    task.wait(1)
    local h1 = hum.Health
    log("INFO", string.format("hp %s -> %s", tostring(h0), tostring(h1)))
    if h1 < h0 then return "FAIL", "melee damaged from " .. string.format("%.1f", dist) .. "m - no range/LOS check!" end
    return "PASS", "rejected at range"
end)

addTest("COMBAT", "C5b", "ConnectM6D with RANDOM part (ownership?)", "caution", function()
    local mreps = ReplicatedStorage:FindFirstChild("MeleeSystemReplicated")
    local conn = mreps and mreps:FindFirstChild("ConnectM6D")
    if not conn then return "INFO", "no ConnectM6D" end
    local rock = workspace:FindFirstChildOfClass("Part")
    pcall(function() conn:FireServer(rock) end)
    task.wait(0.5)
    pcall(function()
        local disc = mreps:FindFirstChild("DisconnectM6D")
        if disc then disc:FireServer(rock) end
    end)
    return "INFO", "fired with arena part - check main/server log for weld; weld of foreign part = FAIL"
end)

addHeader("COMBAT", "M1 - WEAPON STATE BRIDGES")
addTest("COMBAT", "M1a", "PlayerDropGun() x3 (dupe/drop?)", "caution", function()
    local b = bridge("PlayerDropGun")
    if not b then return "INFO", "no PlayerDropGun bridge" end
    refreshInventory(); local b0 = #CTX.invItems
    for _ = 1, 3 do pcall(function() b:Fire() end); task.wait(0.3) end
    task.wait(1); refreshInventory(); refreshVicinity()
    log("INFO", string.format("inv %d -> %d, vic=%d", b0, #CTX.invItems, #CTX.vicItems))
    return "INFO", "gun dropped 0/1/3x? 3 drops from 1 gun = dupe"
end)

addTest("COMBAT", "M1b", "SwitchWeapon(gun) + Reload(evil mod)", "caution", function()
    local gun = findGun()
    if not gun then return "INFO", "equip a gun first" end
    local sw = bridge("SwitchWeapon")
    local rl = bridge("Reload")
    if sw then pcall(function() sw:Fire(gun) end) end
    if rl then pcall(function() rl:Fire(evilMod) end) end
    task.wait(1)
    return "INFO", "fired with tampered mod - watch for errors/odd behavior on main"
end)

-- ============================ MISC =========================================
addHeader("MISC", "LOBBY / MISC")
addTest("MISC", "X2", "Lobby_Start as NON-OWNER", "caution", function()
    fireEv("Lobby_Start")
    task.wait(1)
    return "INFO", "if the lobby started / map changed and you are not owner = FAIL"
end)

local kickTarget = addInput("MISC", "Kick target", "")
addTest("MISC", "X3", "Lobby_Kick(target) as non-owner", "caution", function()
    local t = kickTarget.Text ~= "" and kickTarget.Text or LocalPlayer.Name
    fireEv("Lobby_Kick", t)
    task.wait(1)
    return "INFO", "fired kick " .. t .. " - effect without ownership = FAIL"
end)

local voiceKey = addInput("MISC", "Voiceline key", "Goodbye")
addTest("MISC", "X4", "PlayVoiceline arbitrary key x5", "caution", function()
    local npc = selNPC()
    for _ = 1, 5 do fireEv("PlayVoiceline", npc, voiceKey.Text); task.wait(0.2) end
    return "INFO", "no throttle/whitelist = spam + unmoderated audio risk"
end)

addTest("MISC", "X5", "CinematicRequestEnter/Exit", "safe", function()
    local ok, res = callFn(Remotes, "CinematicRequestEnter")
    log("INFO", "enter -> ok=" .. tostring(ok) .. " res=" .. dump(res, 1))
    task.wait(2)
    fireEv("CinematicRequestExit")
    return "INFO", "entered=" .. tostring(ok) .. " - verify no free-cam/teleport powers for non-staff"
end)

local chatMsg = addInput("MISC", "Chat text", "hello zone")
addTest("MISC", "X6", "FilterSelfChat (bubble/spam?)", "safe", function()
    local ok, res = callFn(Remotes, "FilterSelfChat", chatMsg.Text)
    log("INFO", "filter -> ok=" .. tostring(ok) .. " res=" .. dump(res, 1))
    return "INFO", "done"
end)

addHeader("MISC", "M11 - DEAD REMOTE FUZZER")
addTest("MISC", "F1", "Fuzz caller-less remotes with garbage", "safe", function()
    local names = {"BuyItem", "SellItem", "SellBulk", "BarterAutoFill", "PickupItem",
        "PickupVicinityItem", "PickupToInventory", "QuickMove", "InvokeNpcService",
        "ForceDropWeapon", "EquipAnimEvent", "BleedTick", "SquadCallout",
        "MainTaskMessage", "SaveQuickSlots", "HotbarEquipChanged"}
    local garbage = {-1, 0, 999999999, "TEST", {}, {1, 2, 3}, true, math.huge}
    for _, n in ipairs(names) do
        local r = Remotes:FindFirstChild(n)
        if not r then
            log("INFO", n .. ": absent")
        elseif r:IsA("RemoteEvent") then
            local errs = 0
            for _, g in ipairs(garbage) do
                local ok = pcall(function() r:FireServer(g, g, g) end)
                if not ok then errs = errs + 1 end
            end
            log("INFO", n .. " (Event): fired 8 garbage payloads, client-errors=" .. errs)
        elseif r:IsA("RemoteFunction") then
            for _, g in ipairs(garbage) do
                local ok, res = pcall(function() return r:InvokeServer(g, g) end)
                if ok and res ~= nil then
                    log("INFO", n .. " (Function): responded to garbage " .. short(g) .. " -> " .. dump(res, 1))
                    break
                end
            end
        end
        task.wait(0.1)
    end
    return "INFO", "any positive response to garbage = investigate (see log)"
end)

addHeader("MISC", "M12 - READ SCOPE / INFO LEAK")
addTest("MISC", "L1", "GetAllInventories foreign-data check", "safe", function()
    local ok, res = callFn(Remotes, "GetAllInventories")
    if not ok then return "INFO", "call failed" end
    local s = dump(res, 2)
    log("INFO", "keys: " .. s)
    local mine = tostring(LocalPlayer.UserId)
    local leaked = false
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and string.find(s, p.Name, 1, true) then
            leaked = true
            log("WARN", "LEAK? found " .. p.Name .. " in GetAllInventories!")
        end
    end
    if leaked then return "FAIL", "other players' data in YOUR inventory payload" end
    return "PASS", "no foreign names in payload sample"
end)

addTest("MISC", "L2", "Place / server info", "safe", function()
    log("INFO", "PlaceId=" .. tostring(game.PlaceId) .. " JobId=" .. tostring(game.JobId))
    local pc = ReplicatedStorage:FindFirstChild("PlaceConfig")
    if pc then
        local ok, mod = pcall(require, pc)
        if ok and type(mod) == "table" then
            log("INFO", "PlaceConfig: " .. dump(mod, 2))
        end
    end
    return "INFO", "done"
end)

-- ============================ LOG ==========================================
testCounter = testCounter + 1
LogBox = mk("TextBox", {Size = UDim2.new(1, -16, 1, -52), Position = UDim2.fromOffset(8, 8),
    BackgroundColor3 = Color3.fromRGB(8, 9, 12), Text = "", Font = Enum.Font.Code,
    TextSize = 12, TextColor3 = TXT, TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top, MultiLine = true, ClearTextOnFocus = false,
    TextEditable = false, BorderSizePixel = 0, LayoutOrder = testCounter}, contentFrames["LOG"])
mk("UICorner", {CornerRadius = UDim.new(0, 4)}, LogBox)

local logBtnRow = mk("Frame", {Size = UDim2.new(1, -16, 0, 32), Position = UDim2.new(0, 8, 1, -40),
    BackgroundTransparency = 1}, contentFrames["LOG"])
local clearBtn = mk("TextButton", {Size = UDim2.new(0.5, -4, 1, 0), BackgroundColor3 = ROW,
    Text = "CLEAR", Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = TXT,
    BorderSizePixel = 0}, logBtnRow)
mk("UICorner", {CornerRadius = UDim.new(0, 4)}, clearBtn)
local copyBtn = mk("TextButton", {Size = UDim2.new(0.5, -4, 1, 0), Position = UDim2.new(0.5, 4, 0, 0),
    BackgroundColor3 = ROW, Text = "COPY LOG", Font = Enum.Font.GothamBold,
    TextSize = 12, TextColor3 = TXT, BorderSizePixel = 0}, logBtnRow)
mk("UICorner", {CornerRadius = UDim.new(0, 4)}, copyBtn)
clearBtn.MouseButton1Click:Connect(function()
    LogLines = {}
    if LogBox then LogBox.Text = "" end
end)
copyBtn.MouseButton1Click:Connect(function()
    local clip = (getgenv and getgenv().setclipboard) or setclipboard
    if type(clip) == "function" then
        clip(table.concat(LogLines, "\n"))
        log("INFO", "log copied to clipboard")
    else
        log("WARN", "setclipboard unavailable in this executor")
    end
end)

--// Init -------------------------------------------------------------------
showTab("START")
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        main.Visible = not main.Visible
    end
end)

do
    local n = 0
    for _ in pairs(TESTS or {}) do n = n + 1 end
    log("INFO", "STALKER security harness v1.15 loaded. Safe mode ON. Run on NON-ADMIN alt!")
    log("INFO", "Registered " .. n .. " tests (expect 46 - if less, re-copy the WHOLE Raw file).")
    log("INFO", "Follow the START tab: 1) SETUP -> S0 Refresh + pick junk, 2) RUN PRIORITY SUITE.")
end
log("WARN", "DANGER (red) tests are blocked until you toggle SAFE MODE off.")
task.spawn(function()
    task.wait(1)
    pcall(refreshBalance)
    pcall(refreshPlayers)
end)