-- Decompiled with Potassium's decompiler.

local function dbg(...) -- Line: 24
end;

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local SoundscapeConfig = require(ReplicatedStorage:WaitForChild("SoundscapeConfig"));
local PlaceConfig = require(ReplicatedStorage:WaitForChild("PlaceConfig"));
local SoundscapeAssets = ReplicatedStorage:WaitForChild("SoundscapeAssets", 10);
local u1 = "_" .. tostring(PlaceConfig.Id);

if not SoundscapeAssets then
    warn("[Soundscape] SoundscapeAssets folder missing -- nothing will play");
end;

local LocalPlayer = Players.LocalPlayer;

local function ensureChild(p2, p3, p4) -- Line: 61
    local v5 = p2:FindFirstChild(p3);

    if v5 and v5:IsA(p4) then
        return v5;
    end;

    if v5 then
        v5:Destroy();
    end;

    local Instance_new_ret = Instance.new(p4);
    Instance_new_ret.Name = p3;
    Instance_new_ret.Parent = p2;

    return Instance_new_ret;
end;

local Soundscape = SoundService:FindFirstChild("Soundscape");

if not (Soundscape and Soundscape:IsA("Folder")) then
    if Soundscape then
        Soundscape:Destroy();
    end;

    Soundscape = Instance.new("Folder");
    Soundscape.Name = "Soundscape";
    Soundscape.Parent = SoundService;
end;

local Bed = Soundscape:FindFirstChild("Bed");

if not (Bed and Bed:IsA("SoundGroup")) then
    if Bed then
        Bed:Destroy();
    end;

    Bed = Instance.new("SoundGroup");
    Bed.Name = "Bed";
    Bed.Parent = Soundscape;
end;

local Environmental = Soundscape:FindFirstChild("Environmental");

if not (Environmental and Environmental:IsA("SoundGroup")) then
    if Environmental then
        Environmental:Destroy();
    end;

    Environmental = Instance.new("SoundGroup");
    Environmental.Name = "Environmental";
    Environmental.Parent = Soundscape;
end;

local OneShots = Soundscape:FindFirstChild("OneShots");

if not (OneShots and OneShots:IsA("SoundGroup")) then
    if OneShots then
        OneShots:Destroy();
    end;

    OneShots = Instance.new("SoundGroup");
    OneShots.Name = "OneShots";
    OneShots.Parent = Soundscape;
end;

Bed.Volume = 1.5;
Environmental.Volume = 1.5;
OneShots.Volume = 1.8;
local u6 = {};

local function resolveUnder(p7, p8) -- Line: 89
    if not p7 then
        return nil;
    end;

    for _, v in ipairs(p8) do
        p7 = p7:FindFirstChild(v);

        if not p7 then
            return nil;
        end;
    end;

    if p7:IsA("Sound") then
        return p7;
    end;

    return nil;
end;

local function resolvePath(p9) -- Line: 100
    -- upvalues: SoundscapeAssets (copy), resolveUnder (copy), u1 (copy)
    if SoundscapeAssets then
        return resolveUnder(SoundscapeAssets:FindFirstChild(u1), p9) or resolveUnder(SoundscapeAssets, p9);
    end;

    return nil;
end;

local function pathKey(p10) -- Line: 123
    return table.concat(p10, "/");
end;

local function cloneAsset(p11, p12) -- Line: 108
    -- upvalues: SoundscapeAssets (copy), resolveUnder (copy), u1 (copy), u6 (copy)
    local v13;

    if SoundscapeAssets then
        v13 = resolveUnder(SoundscapeAssets:FindFirstChild(u1), p11) or resolveUnder(SoundscapeAssets, p11);
    else
        v13 = nil;
    end;

    if v13 then
        local v14 = v13:Clone();
        v14.SoundGroup = p12;

        return v14;
    end;

    local table_concat_ret = table.concat(p11, "/");

    if not u6[table_concat_ret] then
        warn("[Soundscape] Asset not found:", table_concat_ret);
        u6[table_concat_ret] = true;
    end;

    return nil;
end;

local u15 = {};

for _, v in ipairs(SoundscapeConfig.Bed.Layers) do
    local v16 = cloneAsset(v.path, Bed);

    if v16 then
        v16.Name = "Bed_" .. v.path[#v.path];
        v16.Looped = true;
        v16.Volume = 0;
        v16.Parent = SoundService;
        v16:Play();
        table.insert(u15, {
            sound = v16,
            thresholdMin = v.thresholdMin,
            baseVolume = v.baseVolume,
            thresholdMax = v.thresholdMax,
            maxVolume = v.maxVolume
        });
        dbg("[Soundscape] Bed layer:", table.concat(v.path, "/"), "-- silent below mag", v.thresholdMin, "| range", v.baseVolume, "->", v.maxVolume, "@ mag", v.thresholdMin, "->", v.thresholdMax);
    end;
end;

local function computeLayerTarget(p17, p18) -- Line: 160
    if p17 < p18.thresholdMin then
        return 0;
    end;

    local v19 = p18.thresholdMax - p18.thresholdMin;
    local v20 = v19 > 0 and (math.clamp((p17 - p18.thresholdMin) / v19, 0, 1) or 1) or 1;

    return p18.baseVolume + (p18.maxVolume - p18.baseVolume) * v20;
end;

local u21 = 0;
RunService.Heartbeat:Connect(function(p22) -- Line: 169
    -- upvalues: u21 (ref), u15 (copy)
    u21 = u21 + p22;

    if u21 < 1 then
        return;
    end;

    u21 = u21 - 1;
    local Magnitude = workspace.GlobalWind.Magnitude;

    for _, v in ipairs(u15) do
        local v23;

        if Magnitude < v.thresholdMin then
            v23 = 0;
        else
            local v24 = v.thresholdMax - v.thresholdMin;
            local v25 = v24 > 0 and (math.clamp((Magnitude - v.thresholdMin) / v24, 0, 1) or 1) or 1;
            v23 = v.baseVolume + (v.maxVolume - v.baseVolume) * v25;
        end;

        v.sound.Volume = v.sound.Volume + (v23 - v.sound.Volume) * 0.25;
    end;
end);
local u26 = {};

for _, v in ipairs(SoundscapeConfig.TimeSlots) do
    local v27 = SoundscapeConfig.EnvironmentalLoops[v.name];

    if v27 then
        local v28 = cloneAsset(v27.path, Environmental);

        if v28 then
            v28.Name = "Env_" .. v.name;
            v28.Looped = true;
            v28.Volume = 0;
            v28.Parent = SoundService;
            v28:Play();
            u26[v.name] = v28;
        end;
    end;
end;

local function resolveSlot(p29) -- Line: 200
    -- upvalues: SoundscapeConfig (copy)
    for _, v in ipairs(SoundscapeConfig.TimeSlots) do
        local startHour = v.startHour;
        local endHour = v.endHour;

        if startHour < endHour then
            if startHour <= p29 and p29 < endHour then
                return v.name;
            end;
        elseif startHour <= p29 or p29 < endHour then
            return v.name;
        end;
    end;

    return SoundscapeConfig.TimeSlots[1].name;
end;

local function crossfadeTo(p30) -- Line: 213
    -- upvalues: u26 (copy), SoundscapeConfig (copy), TweenService (copy)
    for i, v in pairs(u26) do
        local v31 = i == p30 and SoundscapeConfig.EnvironmentalLoops[i].volume or 0;
        TweenService:Create(v, TweenInfo.new(SoundscapeConfig.SlotCrossfadeSeconds, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            Volume = v31
        }):Play();
    end;
end;

local u32 = resolveSlot((math.floor(Lighting.ClockTime)));
crossfadeTo(u32);
dbg("[Soundscape] Starting slot:", u32);
task.spawn(function() -- Line: 229
    -- upvalues: resolveSlot (copy), Lighting (copy), u32 (ref), dbg (copy), crossfadeTo (copy)
    while true do
        local v33;

        repeat
            task.wait(1);
            v33 = resolveSlot((math.floor(Lighting.ClockTime)));
        until v33 ~= u32;

        dbg("[Soundscape] Slot change:", u32, "->", v33);
        u32 = v33;
        crossfadeTo(u32);
    end;
end);
local Random_new_ret = Random.new();

local function poissonDelay(p34) -- Line: 246
    -- upvalues: Random_new_ret (copy)
    local v35 = 1 - Random_new_ret:NextNumber();

    return -math.log(v35) * p34;
end;

local function weightedPick(p36) -- Line: 250
    -- upvalues: Random_new_ret (copy)
    if #p36 == 0 then
        return nil;
    end;

    local v37 = 0;

    for _, v in ipairs(p36) do
        v37 = v37 + v.weight;
    end;

    local v38 = Random_new_ret:NextNumber() * v37;
    local v39 = 0;

    for _, v in ipairs(p36) do
        v39 = v39 + v.weight;

        if v38 <= v39 then
            return v;
        end;
    end;

    return p36[#p36];
end;

local u40 = {};

if SoundscapeConfig.SpookOneShots and SoundscapeAssets then
    local Spooks = SoundscapeAssets:FindFirstChild("Spooks");

    if Spooks then
        for i, v in pairs(SoundscapeConfig.SpookOneShots.Categories) do
            local v41 = Spooks:FindFirstChild(i);

            if v41 then
                local v42 = v;
                local v43 = i;
                local v44 = {};

                for _, child in ipairs(v41:GetChildren()) do
                    if child:IsA("Sound") then
                        table.insert(v44, {
                            path = { "Spooks", v43, child.Name },
                            volume = v42.volume,
                            spatial = v42.spatial,
                            rollOffMin = v42.rollOffMin,
                            rollOffMax = v42.rollOffMax
                        });
                    end;
                end;

                u40[v43] = {
                    entries = v44,
                    weights = v42.weight
                };
                dbg("[Soundscape] Spook category:", v43, "-- " .. #v44 .. " sounds");
            else
                warn("[Soundscape] Spook folder missing:", i);
            end;
        end;
    else
        warn("[Soundscape] SoundscapeAssets/Spooks not found -- spook pool empty");
    end;
end;

local function getCurrentPool() -- Line: 296
    -- upvalues: SoundscapeConfig (copy), u6 (copy), u32 (ref), u40 (copy)
    local v45 = {};

    for _, v in ipairs(SoundscapeConfig.OneShots.Global) do
        if not u6[table.concat(v.path, "/")] then
            table.insert(v45, v);
        end;
    end;

    for _, v in ipairs(SoundscapeConfig.OneShots[u32] or {}) do
        if not u6[table.concat(v.path, "/")] then
            table.insert(v45, v);
        end;
    end;

    for _, v in pairs(u40) do
        local v46 = v.weights[u32];

        if v46 and v46 > 0 then
            for _, v2 in ipairs(v.entries) do
                if not u6[table.concat(v2.path, "/")] then
                    table.insert(v45, {
                        path = v2.path,
                        volume = v2.volume,
                        spatial = v2.spatial,
                        rollOffMin = v2.rollOffMin,
                        rollOffMax = v2.rollOffMax,
                        weight = v46
                    });
                end;
            end;
        end;
    end;

    return v45;
end;

local function spawnSpatialAttachment() -- Line: 330
    -- upvalues: LocalPlayer (copy), Random_new_ret (copy), SoundscapeConfig (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return nil;
    end;

    local v47 = Random_new_ret:NextNumber() * 3.141592653589793 * 2;
    local v48 = Random_new_ret:NextNumber(SoundscapeConfig.SpatialRadiusMin, SoundscapeConfig.SpatialRadiusMax);
    local v49 = Random_new_ret:NextNumber(SoundscapeConfig.SpatialHeightRange.min, SoundscapeConfig.SpatialHeightRange.max);
    local Position = Character.Position;
    local v50 = math.cos(v47) * v48;
    local v51 = math.sin(v47) * v48;
    local v52 = Position + Vector3.new(v50, v49, v51);
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "SoundscapeOneShotAttach";
    Attachment.WorldPosition = v52;
    Attachment.Parent = workspace.Terrain;

    return Attachment;
end;

local function playOneShot(u53) -- Line: 345
    -- upvalues: cloneAsset (copy), OneShots (copy), spawnSpatialAttachment (copy), SoundService (copy), u6 (copy)
    local u54 = cloneAsset(u53.path, OneShots);

    if not u54 then
        return;
    end;

    u54.Name = "OneShot_" .. u53.path[#u53.path];
    u54.Volume = u53.volume;

    if u53.rollOffMin then
        u54.RollOffMinDistance = u53.rollOffMin;
    end;

    if u53.rollOffMax then
        u54.RollOffMaxDistance = u53.rollOffMax;
    end;

    if u53.spatial then
        local u55 = spawnSpatialAttachment();

        if not u55 then
            u54:Destroy();

            return;
        end;

        u54.Parent = u55;
        u54.Ended:Connect(function() -- Line: 357
            -- upvalues: u55 (copy)
            u55:Destroy();
        end);
    else
        u54.Parent = SoundService;
        u54.Ended:Connect(function() -- Line: 360
            -- upvalues: u54 (copy)
            u54:Destroy();
        end);
    end;

    u54:Play();
    task.delay(3, function() -- Line: 366
        -- upvalues: u54 (copy), u53 (copy), u6 (ref)
        if u54.Parent and not (u54.IsLoaded or u54.IsPlaying) then
            local table_concat_ret = table.concat(u53.path, "/");

            if not u6[table_concat_ret] then
                warn("[Soundscape] One-shot failed to load, removing from pool:", table_concat_ret);
                u6[table_concat_ret] = true;
            end;

            u54:Destroy();
        end;
    end);
end;

task.spawn(function() -- Line: 378
    -- upvalues: SoundscapeConfig (copy), u32 (ref), Random_new_ret (copy), getCurrentPool (copy), weightedPick (copy), playOneShot (copy)
    while true do
        local v56;

        repeat
            local v57 = SoundscapeConfig.OneShotMeanIntervalSeconds[u32] or 60;
            local task_wait = task.wait;
            local v58 = 1 - Random_new_ret:NextNumber();
            task_wait(-math.log(v58) * v57);
            v56 = weightedPick((getCurrentPool()));
        until v56;

        playOneShot(v56);
    end;
end);
local Magnitude = workspace.GlobalWind.Magnitude;
local u59 = (-1 / 0);

local function nearestTaggedTree(p60, p61) -- Line: 395
    -- upvalues: CollectionService (copy), SoundscapeConfig (copy)
    local v62 = nil;

    for _, v in ipairs(CollectionService:GetTagged(SoundscapeConfig.Gust.TreeTag)) do
        if v:IsA("BasePart") then
            local Magnitude2 = (v.Position - p60).Magnitude;

            if Magnitude2 <= p61 then
                v62 = v;
                p61 = Magnitude2;
            end;
        end;
    end;

    return v62;
end;

local function playGustOneShot() -- Line: 409
    -- upvalues: weightedPick (copy), SoundscapeConfig (copy), cloneAsset (copy), OneShots (copy), LocalPlayer (copy), nearestTaggedTree (copy), spawnSpatialAttachment (copy)
    local v63 = weightedPick(SoundscapeConfig.Gust.OneShots);

    if not v63 then
        return;
    end;

    local u64 = cloneAsset(v63.path, OneShots);

    if not u64 then
        return;
    end;

    u64.Name = "Gust_" .. v63.path[#v63.path];
    u64.Volume = v63.volume;
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        u64:Destroy();

        return;
    end;

    local v65 = nearestTaggedTree(Character.Position, SoundscapeConfig.Gust.PreferTaggedTreeRadius);

    if v65 then
        u64.Parent = v65;
        u64.Ended:Connect(function() -- Line: 425
            -- upvalues: u64 (copy)
            u64:Destroy();
        end);
    else
        local u66 = spawnSpatialAttachment();

        if not u66 then
            u64:Destroy();

            return;
        end;

        u64.Parent = u66;
        u64.Ended:Connect(function() -- Line: 430
            -- upvalues: u66 (copy)
            u66:Destroy();
        end);
    end;

    u64:Play();
end;

local u67 = 0;
RunService.Heartbeat:Connect(function(p68) -- Line: 437
    -- upvalues: u67 (ref), Magnitude (ref), SoundscapeConfig (copy), u59 (ref), playGustOneShot (copy), dbg (copy)
    u67 = u67 + p68;

    if u67 < 0.25 then
        return;
    end;

    u67 = u67 - 0.25;
    local Magnitude2 = workspace.GlobalWind.Magnitude;
    local v69;

    if Magnitude < SoundscapeConfig.Gust.PeakMagnitudeThreshold then
        v69 = SoundscapeConfig.Gust.PeakMagnitudeThreshold <= Magnitude2;
    else
        v69 = false;
    end;

    if v69 and os.clock() - u59 >= SoundscapeConfig.Gust.MinSecondsBetweenOneShots then
        u59 = os.clock();
        playGustOneShot();
        dbg("[Soundscape] Gust one-shot fired at magnitude", string.format("%.1f", Magnitude2));
    end;

    Magnitude = Magnitude2;
end);
_G.Soundscape = {
    GetCurrentSlot = function() -- Line: 461, Name: GetCurrentSlot
        -- upvalues: u32 (ref)
        return u32;
    end,

    ForceSlot = function(p70) -- Line: 462, Name: ForceSlot
        -- upvalues: u26 (copy), u32 (ref), crossfadeTo (copy)
        if not u26[p70] then
            warn("[Soundscape] ForceSlot: unknown slot", p70);

            return;
        end;

        u32 = p70;
        crossfadeTo(u32);
        print("[Soundscape] Forced slot:", p70);
    end
};
local v71 = print;
local v72 = 0;

for _ in pairs(u26) do
    v72 = v72 + 1;
end;

v71("[Soundscape] Controller fully initialized; bed layers:", #u15, "env loops:", v72);