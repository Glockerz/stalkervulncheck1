-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

if require(ReplicatedStorage:WaitForChild("PlaceConfig")).IsLobby then
    return;
end;

local MusicConfig = require(ReplicatedStorage:WaitForChild("MusicConfig"));
local MusicPlayer = require(ReplicatedStorage:WaitForChild("MusicPlayer"));
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u2 = {};

local function hearOthers() -- Line: 34
    -- upvalues: MusicPlayer (copy)
    return MusicPlayer:GetState().settings.hearOthers ~= false;
end;

local function refresh(p3: userdata) -- Line: 38
    -- upvalues: u2 (copy), MusicConfig (copy), MusicPlayer (copy)
    local v4 = (u2[p3] or 0) + 1;
    u2[p3] = v4;
    local HumanoidRootPart = p3:FindFirstChild("HumanoidRootPart");
    local v5;

    if HumanoidRootPart then
        v5 = HumanoidRootPart:FindFirstChild("PdaSpeaker");
    else
        v5 = HumanoidRootPart;
    end;

    local Attribute = p3:GetAttribute("MusicTrack");
    local Attribute2 = p3:GetAttribute("MusicCustomId");
    local Attribute3 = p3:GetAttribute("MusicStartedAt");
    local v6;

    if type(Attribute) == "number" then
        v6 = MusicConfig.TRACKS[Attribute] or nil;
    else
        v6 = nil;
    end;

    local v7 = v6 and v6.id;

    if v7 then
        Attribute2 = v7;
    elseif type(Attribute2) ~= "number" or (Attribute2 ~= Attribute2 or (Attribute2 < 1 or (Attribute2 % 1 ~= 0 or not Attribute2))) then
        Attribute2 = nil;
    end;

    if not (HumanoidRootPart and (Attribute2 and type(Attribute3) == "number")) or MusicPlayer:GetState().settings.hearOthers == false then
        if v5 then
            v5:Destroy();
        end;

        return;
    end;

    local v8 = "rbxassetid://" .. string.format("%d", Attribute2);

    if not v5 then
        v5 = Instance.new("Sound");
        v5.Name = "PdaSpeaker";
        v5.Volume = MusicConfig.SPEAKER_VOLUME;
        v5.RollOffMode = Enum.RollOffMode.InverseTapered;
        v5.RollOffMinDistance = MusicConfig.SPEAKER_MIN_RANGE;
        v5.RollOffMaxDistance = MusicConfig.SPEAKER_RANGE;
        v5.Parent = HumanoidRootPart;
    end;

    local v9;

    if v5.SoundId == v8 then
        v9 = 0;
    else
        v5.SoundId = v8;
        v9 = 0;
    end;

    while not v5.IsLoaded and v9 < MusicConfig.LOAD_TIMEOUT do
        v9 = v9 + task.wait(0.1);

        if u2[p3] ~= v4 or not v5.Parent then
            return;
        end;
    end;

    if not (v5.IsLoaded and (u2[p3] == v4 and v5.Parent)) then
        return;
    end;

    local v10 = workspace:GetServerTimeNow() - Attribute3;

    if v5.TimeLength > 0 and v5.TimeLength <= v10 then
        v5:Stop();

        return;
    end;

    if math.abs(v5.TimePosition - v10) > 1.5 or not v5.IsPlaying then
        v5.TimePosition = math.max(0, v10);
    end;

    if not v5.IsPlaying then
        v5:Play();
    end;
end;

local function watch(p11: userdata, u12: userdata) -- Line: 83
    -- upvalues: LocalPlayer (copy), u1 (copy), refresh (copy), u2 (copy)
    if p11 == LocalPlayer or u1[u12] then
        return;
    end;

    u1[u12] = true;
    u12:GetAttributeChangedSignal("MusicTrack"):Connect(function() -- Line: 86
        -- upvalues: refresh (ref), u12 (copy)
        task.spawn(refresh, u12);
    end);
    u12:GetAttributeChangedSignal("MusicCustomId"):Connect(function() -- Line: 87
        -- upvalues: refresh (ref), u12 (copy)
        task.spawn(refresh, u12);
    end);
    u12:GetAttributeChangedSignal("MusicStartedAt"):Connect(function() -- Line: 88
        -- upvalues: refresh (ref), u12 (copy)
        task.spawn(refresh, u12);
    end);
    u12.ChildAdded:Connect(function(p13) -- Line: 92
        -- upvalues: refresh (ref), u12 (copy)
        if p13.Name == "HumanoidRootPart" then
            task.spawn(refresh, u12);
        end;
    end);
    u12.Destroying:Connect(function() -- Line: 95
        -- upvalues: u1 (ref), u12 (copy), u2 (ref)
        u1[u12] = nil;
        u2[u12] = nil;
    end);
    task.spawn(refresh, u12);
end;

Players.PlayerAdded:Connect(function(u14: userdata) -- Line: 99, Name: onPlayer
    -- upvalues: watch (copy)
    if u14.Character then
        watch(u14, u14.Character);
    end;

    u14.CharacterAdded:Connect(function(p15) -- Line: 101
        -- upvalues: watch (ref), u14 (copy)
        watch(u14, p15);
    end);
end);

for _, v in ipairs(Players:GetPlayers()) do
    if v.Character then
        watch(v, v.Character);
    end;

    v.CharacterAdded:Connect(function(p16) -- Line: 101
        -- upvalues: watch (copy), v (copy)
        watch(v, p16);
    end);
end;

local u17 = MusicPlayer:GetState().settings.hearOthers ~= false;
MusicPlayer:OnChanged(function() -- Line: 110
    -- upvalues: MusicPlayer (copy), u17 (ref), u1 (copy), refresh (copy)
    local v18 = MusicPlayer:GetState().settings.hearOthers ~= false;

    if v18 == u17 then
        return;
    end;

    u17 = v18;

    for i in pairs(u1) do
        task.spawn(refresh, i);
    end;
end);