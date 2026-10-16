-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local WhirligigExplosion = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("WhirligigExplosion");

local function shakeCamera() -- Line: 32
    -- upvalues: LocalPlayer (copy), RunService (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    if not Character then
        return;
    end;

    local os_clock_ret = os.clock();
    local u1 = nil;
    u1 = RunService.RenderStepped:Connect(function() -- Line: 39
        -- upvalues: os_clock_ret (copy), Character (copy), u1 (ref)
        local v2 = os.clock() - os_clock_ret;

        if v2 >= 0.8 or not Character.Parent then
            if Character.Parent then
                Character.CameraOffset = Vector3.new(0, 0, 0);
            end;

            u1:Disconnect();

            return;
        end;

        local v3 = 1 * (1 - v2 / 0.8);
        local v4 = (math.random() - 0.5) * 2 * v3;
        local v5 = (math.random() - 0.5) * 2 * v3;
        local v6 = (math.random() - 0.5) * 2 * v3;
        Character.CameraOffset = Vector3.new(v4, v5, v6);
    end);
end;

local u7 = nil;
local u8 = nil;

local function ensureDarkenGui() -- Line: 65
    -- upvalues: u7 (ref), LocalPlayer (copy), u8 (ref)
    if u7 then
        return;
    end;

    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    u7 = Instance.new("ScreenGui");
    u7.Name = "WhirligigDarken";
    u7.IgnoreGuiInset = true;
    u7.ResetOnSpawn = false;
    u7.DisplayOrder = 50;
    u7.Parent = PlayerGui;
    u8 = Instance.new("Frame");
    u8.Size = UDim2.new(1, 0, 1, 0);
    u8.BackgroundColor3 = Color3.new(0, 0, 0);
    u8.BackgroundTransparency = 1;
    u8.BorderSizePixel = 0;
    u8.Parent = u7;
end;

local function darkenScreen() -- Line: 82
    -- upvalues: ensureDarkenGui (copy), TweenService (copy), u8 (ref)
    ensureDarkenGui();
    TweenService:Create(u8, TweenInfo.new(0.05), {
        BackgroundTransparency = 0.4
    }):Play();
    task.delay(0.2, function() -- Line: 86
        -- upvalues: TweenService (ref), u8 (ref)
        TweenService:Create(u8, TweenInfo.new(0.5), {
            BackgroundTransparency = 1
        }):Play();
    end);
end;

local u9 = {};

local function computeDroneVolume(p10) -- Line: 100
    -- upvalues: LocalPlayer (copy)
    local Attribute = p10:GetAttribute("State");

    if Attribute ~= "ACTIVE" and Attribute ~= "CAPTURED" then
        return 0;
    end;

    local ZoneCenter = p10:FindFirstChild("ZoneCenter");

    if not ZoneCenter then
        return 0;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return 2;
    end;

    local v11 = (p10:GetAttribute("FootprintRadius") or 4) * 4;
    local v12 = Character.Position.X - ZoneCenter.Position.X;
    local v13 = Character.Position.Z - ZoneCenter.Position.Z;
    local math_sqrt_ret = math.sqrt(v12 * v12 + v13 * v13);

    return v11 <= math_sqrt_ret and 2 or 2 + 3 * (1 - math_sqrt_ret / v11);
end;

local function syncDroneVolume(p14) -- Line: 121
    -- upvalues: computeDroneVolume (copy), TweenService (copy)
    local ZoneCenter = p14:FindFirstChild("ZoneCenter");

    if ZoneCenter then
        ZoneCenter = ZoneCenter:FindFirstChild("PullDrone");
    end;

    if not (ZoneCenter and ZoneCenter:IsA("Sound")) then
        return;
    end;

    if not ZoneCenter.Looped then
        ZoneCenter.Looped = true;
    end;

    local v15 = computeDroneVolume(p14);

    if v15 > 0 and not ZoneCenter.IsPlaying then
        ZoneCenter:Play();
    end;

    TweenService:Create(ZoneCenter, TweenInfo.new(0.15), {
        Volume = v15
    }):Play();
end;

local function watchAnomaly(u16) -- Line: 132
    -- upvalues: u9 (copy), syncDroneVolume (copy)
    if not u16:IsA("Model") then
        return;
    end;

    if u16:GetAttribute("AnomalyType") ~= "Whirligig" then
        return;
    end;

    if u9[u16] then
        return;
    end;

    if not u16:IsDescendantOf(workspace) then
        return;
    end;

    local u17 = {
        stopped = false
    };
    u9[u16] = u17;
    syncDroneVolume(u16);
    u16:GetAttributeChangedSignal("State"):Connect(function() -- Line: 142
        -- upvalues: syncDroneVolume (ref), u16 (copy)
        syncDroneVolume(u16);
    end);
    task.spawn(function() -- Line: 147
        -- upvalues: u17 (copy), u16 (copy), syncDroneVolume (ref)
        while not u17.stopped and u16.Parent do
            syncDroneVolume(u16);
            task.wait(0.15);
        end;
    end);
end;

local function unwatchAnomaly(p18) -- Line: 155
    -- upvalues: u9 (copy)
    local v19 = u9[p18];

    if not v19 then
        return;
    end;

    v19.stopped = true;
    u9[p18] = nil;
end;

for _, v in ipairs(CollectionService:GetTagged("Anomaly")) do
    watchAnomaly(v);
end;

CollectionService:GetInstanceAddedSignal("Anomaly"):Connect(watchAnomaly);
CollectionService:GetInstanceRemovedSignal("Anomaly"):Connect(unwatchAnomaly);
WhirligigExplosion.OnClientEvent:Connect(function(p20) -- Line: 174
    -- upvalues: LocalPlayer (copy), shakeCamera (copy), darkenScreen (copy)
    if not (p20 and p20.model) then
        return;
    end;

    local model = p20.model;

    if not model.Parent then
        return;
    end;

    local v21 = model:FindFirstChild("Apex") or model:FindFirstChild("ZoneCenter");
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if Character and (v21 and (Character.Position - v21.Position).Magnitude < 35) then
        shakeCamera();
        darkenScreen();
    end;
end);
print("[WhirligigClient] Initialized");