-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local SoundService = game:GetService("SoundService");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local Sound = Instance.new("Sound");
Sound.Name = "AnomalyDetector";
Sound.SoundId = "rbxassetid://1153680689";
Sound.Looped = true;
Sound.Volume = 0;
Sound.PlaybackSpeed = 1;
Sound.Parent = SoundService;
local u1 = {};

local function radiusOf(p2) -- Line: 67
    return p2:GetAttribute("ZoneRadius") or p2:GetAttribute("FootprintRadius") or 5;
end;

local function positionOf(u3) -- Line: 75
    local ZoneCenter = u3:FindFirstChild("ZoneCenter");

    if ZoneCenter and ZoneCenter:IsA("BasePart") then
        return ZoneCenter.Position;
    end;

    local success, result = pcall(function() -- Line: 78
        -- upvalues: u3 (copy)
        return u3:GetPivot();
    end);

    if success then
        return result.Position;
    end;

    return nil;
end;

local function rebuildCache() -- Line: 83
    -- upvalues: CollectionService (copy), positionOf (copy), u1 (ref)
    local v4 = {};

    for _, v in ipairs(CollectionService:GetTagged("Anomaly")) do
        if v:IsDescendantOf(workspace) then
            local v5 = positionOf(v);

            if v5 then
                v4[#v4 + 1] = {
                    pos = v5,
                    radius = v:GetAttribute("ZoneRadius") or (v:GetAttribute("FootprintRadius") or 5)
                };
            end;
        end;
    end;

    u1 = v4;
end;

rebuildCache();
CollectionService:GetInstanceAddedSignal("Anomaly"):Connect(rebuildCache);
CollectionService:GetInstanceRemovedSignal("Anomaly"):Connect(rebuildCache);
local u6 = 0;
local u7 = 0;
local u8 = 1;
RunService.RenderStepped:Connect(function(p9) -- Line: 104
    -- upvalues: Sound (copy), u7 (ref), u8 (ref), u6 (ref), LocalPlayer (copy), u1 (ref)
    local math_clamp_ret = math.clamp(p9 * 6, 0, 1);
    Sound.Volume = Sound.Volume + (u7 - Sound.Volume) * math_clamp_ret;
    Sound.PlaybackSpeed = Sound.PlaybackSpeed + (u8 - Sound.PlaybackSpeed) * math_clamp_ret;

    if Sound.Volume > 0.005 then
        if not Sound.IsPlaying then
            Sound:Play();
        end;
    elseif Sound.IsPlaying and u7 <= 0 then
        Sound:Stop();
    end;

    u6 = u6 + p9;

    if u6 < 0.15 then
        return;
    end;

    u6 = 0;
    local Character = LocalPlayer.Character;
    local v10;

    if Character then
        v10 = Character:FindFirstChild("HumanoidRootPart");
    else
        v10 = Character;
    end;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    if not (v10 and (Character and Character.Health > 0)) then
        u7 = 0;
        u8 = 1;

        return;
    end;

    local Position = v10.Position;
    local v11 = (1 / 0);

    for i = 1, #u1 do
        local v12 = u1[i];
        local v13 = (v12.pos - Position).Magnitude - v12.radius;
        local v14;

        if v13 < v11 then
            v11 = v13;
            v14 = i;
        else
            v14 = i;
        end;
    end;

    if v11 >= 50 then
        u7 = 0;
        u8 = 1;

        return;
    end;

    local v15 = (1 - math.max(v11, 0) / 50) ^ 1.6;
    u7 = v15 * 0.9 + 0.1;
    u8 = v15 * 0 + 1;
end);