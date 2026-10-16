-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Workspace = game:GetService("Workspace");
local PdaMapData = require(ReplicatedStorage:WaitForChild("PdaMapData"));
local LocalPlayer = Players.LocalPlayer;
local v1 = {};

local function ensureAnchorsFolder() -- Line: 16
    -- upvalues: Workspace (copy)
    local PdaBlipAnchorsLocal = Workspace:FindFirstChild("PdaBlipAnchorsLocal");

    if not PdaBlipAnchorsLocal then
        PdaBlipAnchorsLocal = Instance.new("Folder");
        PdaBlipAnchorsLocal.Name = "PdaBlipAnchorsLocal";
        PdaBlipAnchorsLocal.Parent = Workspace;
    end;

    return PdaBlipAnchorsLocal;
end;

local function ensureAnchor(p2, p3, p4) -- Line: 26
    -- upvalues: Workspace (copy), CollectionService (copy)
    local PdaBlipAnchorsLocal = Workspace:FindFirstChild("PdaBlipAnchorsLocal");

    if not PdaBlipAnchorsLocal then
        PdaBlipAnchorsLocal = Instance.new("Folder");
        PdaBlipAnchorsLocal.Name = "PdaBlipAnchorsLocal";
        PdaBlipAnchorsLocal.Parent = Workspace;
    end;

    local v5 = p2 .. "_" .. p3;
    local v6 = PdaBlipAnchorsLocal:FindFirstChild(v5);

    if not v6 then
        v6 = Instance.new("Part");
        v6.Name = v5;
        v6.Anchored = true;
        v6.CanCollide = false;
        v6.CanQuery = false;
        v6.CanTouch = false;
        v6.Transparency = 1;
        v6.Size = Vector3.new(2, 2, 2);
        v6.Parent = PdaBlipAnchorsLocal;
    end;

    v6.Position = p4;

    if not CollectionService:HasTag(v6, p2) then
        CollectionService:AddTag(v6, p2);
    end;
end;

local u7 = {};
local u8 = {};

function v1.SetDepositTargets(p9) -- Line: 54
    -- upvalues: Workspace (copy), u8 (copy), CollectionService (copy)
    local PdaBlipAnchorsLocal = Workspace:FindFirstChild("PdaBlipAnchorsLocal");

    if not PdaBlipAnchorsLocal then
        PdaBlipAnchorsLocal = Instance.new("Folder");
        PdaBlipAnchorsLocal.Name = "PdaBlipAnchorsLocal";
        PdaBlipAnchorsLocal.Parent = Workspace;
    end;

    for i, v in pairs(u8) do
        if not p9[i] then
            v:Destroy();
            u8[i] = nil;
        end;
    end;

    for i, v in pairs(p9) do
        local v10 = u8[i];

        if not (v10 and v10.Parent) then
            v10 = Instance.new("Part");
            v10.Name = "Stash_dep_" .. tostring(i);
            v10.Anchored = true;
            v10.CanCollide = false;
            v10.CanQuery = false;
            v10.CanTouch = false;
            v10.Transparency = 1;
            v10.Size = Vector3.new(2, 2, 2);
            v10.Parent = PdaBlipAnchorsLocal;
            CollectionService:AddTag(v10, "Stash");
            u8[i] = v10;
        end;

        v10.Position = v.pos;
    end;
end;

function v1.SetExplorationTargets(p11) -- Line: 77
    -- upvalues: Workspace (copy), u7 (copy), CollectionService (copy)
    local PdaBlipAnchorsLocal = Workspace:FindFirstChild("PdaBlipAnchorsLocal");

    if not PdaBlipAnchorsLocal then
        PdaBlipAnchorsLocal = Instance.new("Folder");
        PdaBlipAnchorsLocal.Name = "PdaBlipAnchorsLocal";
        PdaBlipAnchorsLocal.Parent = Workspace;
    end;

    for i, v in pairs(u7) do
        if not p11[i] then
            v:Destroy();
            u7[i] = nil;
        end;
    end;

    for i, v in pairs(p11) do
        local v12 = u7[i];

        if not (v12 and v12.Parent) then
            v12 = Instance.new("Part");
            v12.Name = "SearchHere_" .. tostring(i);
            v12.Anchored = true;
            v12.CanCollide = false;
            v12.CanQuery = false;
            v12.CanTouch = false;
            v12.Transparency = 1;
            v12.Size = Vector3.new(2, 2, 2);
            v12.Parent = PdaBlipAnchorsLocal;
            CollectionService:AddTag(v12, "SearchHere");
            u7[i] = v12;
        end;

        v12.Position = v.pos;
    end;
end;

function v1.Attach(p13) -- Line: 102
    -- upvalues: LocalPlayer (copy), PdaMapData (copy), ensureAnchor (copy)
    if not (p13 and p13:IsA("GuiObject")) then
        warn("[PdaMapBlipFactory] Attach called without a GuiObject");

        return;
    end;

    local v14 = LocalPlayer:GetAttribute("Zone") or PdaMapData.CurrentZone();
    local Region = PdaMapData.GetRegion(v14);

    if not Region then
        warn(("[PdaMapBlipFactory] no baked region for zone %q; no static blips"):format((tostring(v14))));

        return;
    end;

    for _, v in ipairs(Region.Traders or {}) do
        ensureAnchor("Trader", v.Id, v.WorldPos);
    end;

    for _, v in ipairs(Region.Doctors or {}) do
        ensureAnchor("Doctor", v.Id, v.WorldPos);
    end;

    print(string.format("[PdaMapBlipFactory] Static anchors created+tagged: %d traders, %d doctors (stashes are dynamic)", #(Region.Traders or {}), #(Region.Doctors or {})));
end;

return v1;