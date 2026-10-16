-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");

local function num(p1, p2, p3) -- Line: 12
    return tonumber(p1:GetAttribute(p2)) or p3;
end;

local LocalPlayer = Players.LocalPlayer;
local u4 = 0;
local u5 = 100;
local u6 = { "rbxassetid://9116449749", "rbxassetid://9116449574" };
local Sound = Instance.new("Sound");
Sound.Name = "RadiationContaminated";
Sound.SoundId = "rbxassetid://281066056";
Sound.Volume = 0;
Sound.Looped = true;
Sound.Playing = true;
Sound.RollOffMode = Enum.RollOffMode.Inverse;
Sound.RollOffMaxDistance = 10;

local function parentSounds(p7) -- Line: 41
    -- upvalues: Sound (copy)
    local Head = p7:WaitForChild("Head", 5);

    if Head then
        Sound.Parent = Head;
    end;
end;

local Character = LocalPlayer.Character;
local v8 = Character and Character:WaitForChild("Head", 5);

if v8 then
    Sound.Parent = v8;
end;

LocalPlayer.CharacterAdded:Connect(function(p9) -- Line: 50
    -- upvalues: u4 (ref), Sound (copy)
    u4 = 0;
    local Head = p9:WaitForChild("Head", 5);

    if Head then
        Sound.Parent = Head;
    end;
end);
local SoundService = game:GetService("SoundService");
local Sound2 = Instance.new("Sound");
Sound2.Name = "RadiationHum";
Sound2.SoundId = "rbxassetid://17541330396";
Sound2.Volume = 0;
Sound2.Looped = true;
Sound2.Playing = true;
Sound2.Parent = SoundService;

local function ensureZoneSound(p10) -- Line: 69
    return nil;
end;

local u11 = {};

local function distanceToBboxEdge(p12, p13) -- Line: 75
    local v14 = p12.CFrame:PointToObjectSpace(p13);
    local v15 = p12.Size * 0.5;
    local math_clamp_ret = math.clamp(v14.X, -v15.X, v15.X);
    local math_clamp_ret2 = math.clamp(v14.Y, -v15.Y, v15.Y);
    local math_clamp_ret3 = math.clamp(v14.Z, -v15.Z, v15.Z);

    return (v14 - Vector3.new(math_clamp_ret, math_clamp_ret2, math_clamp_ret3)).Magnitude;
end;

for _, v in ipairs(CollectionService:GetTagged("RadZone")) do
    local RadiationLoop = v:FindFirstChild("RadiationLoop");

    if RadiationLoop then
        RadiationLoop:Destroy();
    end;
end;

local u16 = {};

local function ensureSourceSound(p17) -- Line: 92
    -- upvalues: u16 (copy)
    if u16[p17] then
        return u16[p17];
    end;

    if not p17:IsA("BasePart") then
        return nil;
    end;

    local v18 = tonumber(p17:GetAttribute("RadRadius")) or 30;
    local Sound3 = Instance.new("Sound");
    Sound3.Name = "RadiationLoop";
    Sound3.SoundId = "rbxassetid://17541330396";
    Sound3.Volume = 0;
    Sound3.Looped = true;
    Sound3.Playing = true;
    Sound3.RollOffMode = Enum.RollOffMode.Linear;
    Sound3.RollOffMinDistance = 0;
    Sound3.RollOffMaxDistance = v18;
    Sound3.Parent = p17;
    u16[p17] = Sound3;

    return Sound3;
end;

for _, _ in ipairs(CollectionService:GetTagged("RadZone")) do

end;

CollectionService:GetInstanceAddedSignal("RadZone"):Connect(function(p19) -- Line: 115
end);
CollectionService:GetInstanceRemovedSignal("RadZone"):Connect(function(p20) -- Line: 118
    -- upvalues: u11 (copy)
    if u11[p20] then
        u11[p20]:Destroy();
        u11[p20] = nil;
    end;
end);

for _, v in ipairs(CollectionService:GetTagged("RadSource")) do
    ensureSourceSound(v);
end;

CollectionService:GetInstanceAddedSignal("RadSource"):Connect(function(p21) -- Line: 129
    -- upvalues: ensureSourceSound (copy)
    ensureSourceSound(p21);
end);
CollectionService:GetInstanceRemovedSignal("RadSource"):Connect(function(p22) -- Line: 132
    -- upvalues: u16 (copy)
    if u16[p22] then
        u16[p22]:Destroy();
        u16[p22] = nil;
    end;
end);
local RadSync = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("RadSync", 10);

if RadSync then
    RadSync.OnClientEvent:Connect(function(p23, p24) -- Line: 142
        -- upvalues: u4 (ref), u5 (ref), LocalPlayer (copy)
        u4 = p23;
        u5 = p24 or 100;
        local DebugRadUI = LocalPlayer.PlayerGui:FindFirstChild("DebugRadUI");
        local v25 = DebugRadUI and DebugRadUI:FindFirstChild("RadLabel");

        if v25 then
            v25.Text = string.format("RAD: %.1f / %d", p23, p24);
        end;
    end);
end;

local u26 = 0;
local math_random_ret = math.random(5, 15);

local function playCough() -- Line: 163
    -- upvalues: LocalPlayer (copy), u6 (copy)
    local Character2 = LocalPlayer.Character;

    if not Character2 then
        return;
    end;

    local Head = Character2:FindFirstChild("Head");

    if not Head then
        return;
    end;

    local v27 = u6[math.random(#u6)];
    local Sound3 = Instance.new("Sound");
    Sound3.SoundId = v27;
    Sound3.Volume = 1.5;
    Sound3.PlaybackSpeed = 0.9 + math.random() * 0.2;
    Sound3.RollOffMaxDistance = 30;
    Sound3.Parent = Head;
    Sound3:Play();
    Sound3.Ended:Connect(function() -- Line: 177
        -- upvalues: Sound3 (copy)
        Sound3:Destroy();
    end);
end;

local function getProximityIntensity() -- Line: 181
    -- upvalues: LocalPlayer (copy), CollectionService (copy)
    local Character2 = LocalPlayer.Character;

    if not Character2 then
        return 0;
    end;

    local HumanoidRootPart = Character2:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return 0;
    end;

    local Tagged = CollectionService:GetTagged("RadZone");
    local v28 = 0;

    for _, v in ipairs(Tagged) do
        if v:IsA("BasePart") then
            local v29 = tonumber(v:GetAttribute("RadLevel")) or 1;
            local Magnitude = (HumanoidRootPart.Position - v.Position).Magnitude;
            local v30 = v.Size.Magnitude * 0.5;
            local v31 = tonumber(v:GetAttribute("RadProximityRange")) or 80;
            local _ = v30 + v31;
            local v32 = v.CFrame:PointToObjectSpace(HumanoidRootPart.Position);
            local v33 = v.Size * 0.5;
            local v34;

            if math.abs(v32.X) <= v33.X and math.abs(v32.Y) <= v33.Y then
                v34 = math.abs(v32.Z) <= v33.Z;
            else
                v34 = false;
            end;

            local v35 = 0;

            if v34 then
                v35 = v29 / 10;
            else
                local math_max_ret = math.max(0, Magnitude - v30);

                if math_max_ret < v31 then
                    v35 = v29 / 10 * (1 - math_max_ret / v31);
                end;
            end;

            if v28 < v35 then
                v28 = v35;
            end;
        end;
    end;

    return math.clamp(v28, 0, 1);
end;

local u36 = 0;
RunService.Heartbeat:Connect(function(p37) -- Line: 223
    -- upvalues: u36 (ref), LocalPlayer (copy), CollectionService (copy), distanceToBboxEdge (copy), Sound2 (copy), u16 (copy), u4 (ref), u5 (ref), Sound (copy), u26 (ref), math_random_ret (ref), playCough (copy)
    u36 = u36 + p37;
    local Character2 = LocalPlayer.Character;

    if Character2 then
        Character2 = Character2:FindFirstChild("HumanoidRootPart");
    end;

    local v38 = 0;

    if Character2 then
        local Position = Character2.Position;

        for _, v in ipairs(CollectionService:GetTagged("RadZone")) do
            if v:IsA("BasePart") then
                local v39 = tonumber(v:GetAttribute("RadProximityRange")) or 80;
                local v40 = distanceToBboxEdge(v, Position);

                if v40 < v39 then
                    local v41 = (tonumber(v:GetAttribute("RadLevel")) or 1) / 10;
                    local v42 = math.clamp(v41, 0, 1) * (1 - v40 / v39);

                    if v38 < v42 then
                        v38 = v42;
                    end;
                end;
            end;
        end;
    end;

    Sound2.Volume = Sound2.Volume + (v38 - Sound2.Volume) * math.min(1, p37 * 4);

    for i, v in pairs(u16) do
        local v43 = tonumber(i:GetAttribute("RadIntensity")) or 5;
        local v44 = tonumber(i:GetAttribute("RadRadius")) or 30;

        if v.RollOffMaxDistance ~= v44 then
            v.RollOffMaxDistance = v44;
        end;

        local math_clamp_ret = math.clamp(v43 / 10, 0.1, 1);
        v.Volume = v.Volume + (math_clamp_ret - v.Volume) * math.min(1, p37 * 2);
    end;

    local v45 = u4 / u5;
    local v46 = v45 <= 0.01 and 0 or math.clamp(v45 * 0.6, 0.05, 0.6);
    Sound.Volume = Sound.Volume + (v46 - Sound.Volume) * math.min(1, p37 * 2);

    if u4 >= 40 then
        u26 = u26 + p37;

        if math_random_ret <= u26 then
            playCough();
            u26 = 0;

            if u4 >= 70 then
                math_random_ret = math.random(3, 7);

                return;
            end;

            math_random_ret = math.random(5, 15);
        end;
    else
        u26 = 0;
    end;
end);
print("[RadiationAudio] Initialized");