-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local SpatialWind = require(ReplicatedStorage:WaitForChild("SoundscapeConfig")).SpatialWind;
local SoundscapeAssets = ReplicatedStorage:WaitForChild("SoundscapeAssets", 10);

if not SoundscapeAssets then
    warn("[SpatialWind] SoundscapeAssets folder missing -- nothing will play");

    return;
end;

local Random_new_ret = Random.new();
local u1 = {};

local function pickRandomFromFolder(p2, p3) -- Line: 29
    -- upvalues: SoundscapeAssets (copy), Random_new_ret (copy)
    local v4 = SoundscapeAssets;

    for _, v in ipairs(p2) do
        v4 = v4:FindFirstChild(v);

        if not v4 then
            return nil;
        end;
    end;

    local v5 = {};

    for _, child in ipairs(v4:GetChildren()) do
        if child:IsA("Sound") and child.Name:match(p3) then
            table.insert(v5, child);
        end;
    end;

    if #v5 == 0 then
        return nil;
    end;

    return v5[Random_new_ret:NextInteger(1, #v5)];
end;

local function detach(p6) -- Line: 68
    -- upvalues: u1 (copy)
    local v7 = u1[p6];

    if not v7 then
        return;
    end;

    if v7.sound and v7.sound.Parent then
        v7.sound:Destroy();
    end;

    u1[p6] = nil;
end;

local function attach(p8, p9) -- Line: 45
    -- upvalues: u1 (copy), pickRandomFromFolder (copy)
    if u1[p8] then
        return;
    end;

    if not p8:IsA("BasePart") then
        return;
    end;

    local v10 = pickRandomFromFolder(p9.soundFolder, p9.namePattern);

    if not v10 then
        warn("[SpatialWind] No source sound found for", p9.namePattern, "in", table.concat(p9.soundFolder, "/"));

        return;
    end;

    local v11 = v10:Clone();
    v11.Name = "SpatialWind_" .. v10.Name;
    v11.Looped = true;
    v11.RollOffMode = Enum.RollOffMode.Inverse;
    v11.RollOffMinDistance = p9.rollOffMin;
    v11.RollOffMaxDistance = p9.rollOffMax;
    v11.Volume = p9.volumeMin;
    v11.Parent = p8;
    v11:Play();
    u1[p8] = {
        sound = v11,
        source = p9
    };
end;

for i, v in pairs(SpatialWind.Sources) do
    local v12 = i;
    local u13 = v;

    for _, v2 in ipairs(CollectionService:GetTagged(i)) do
        attach(v2, u13);
    end;

    CollectionService:GetInstanceAddedSignal(v12):Connect(function(p14) -- Line: 84
        -- upvalues: attach (copy), u13 (copy)
        attach(p14, u13);
    end);
    CollectionService:GetInstanceRemovedSignal(v12):Connect(function(p15) -- Line: 87
        -- upvalues: u1 (copy)
        local v16 = u1[p15];

        if not v16 then
            return;
        end;

        if v16.sound and v16.sound.Parent then
            v16.sound:Destroy();
        end;

        u1[p15] = nil;
    end);
end;

local u17 = 0;
RunService.Heartbeat:Connect(function(p18) -- Line: 96
    -- upvalues: u17 (ref), SpatialWind (copy), u1 (copy)
    u17 = u17 + p18;

    if u17 < 1 then
        return;
    end;

    u17 = u17 - 1;
    local math_clamp_ret = math.clamp(workspace.GlobalWind.Magnitude / SpatialWind.WindMagForMax, 0, 1);

    for _, v in pairs(u1) do
        if v.sound and v.sound.Parent then
            v.sound.Volume = v.sound.Volume + (v.source.volumeMin + (v.source.volumeMax - v.source.volumeMin) * math_clamp_ret - v.sound.Volume) * 0.25;
        end;
    end;
end);
local v19 = 0;

for _ in pairs(u1) do
    v19 = v19 + 1;
end;

print("[SpatialWind] Attacher initialized; existing attached:", v19);