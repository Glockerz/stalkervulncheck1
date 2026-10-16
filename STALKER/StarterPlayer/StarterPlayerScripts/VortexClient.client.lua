-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local VortexExplosion = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("VortexExplosion");

local function shakeCamera() -- Line: 37
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
    u1 = RunService.RenderStepped:Connect(function() -- Line: 44
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

local function ensureDarkenGui() -- Line: 70
    -- upvalues: u7 (ref), LocalPlayer (copy), u8 (ref)
    if u7 then
        return;
    end;

    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    u7 = Instance.new("ScreenGui");
    u7.Name = "VortexDarken";
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

local function darkenScreen() -- Line: 87
    -- upvalues: ensureDarkenGui (copy), TweenService (copy), u8 (ref)
    ensureDarkenGui();
    TweenService:Create(u8, TweenInfo.new(0.05), {
        BackgroundTransparency = 0.4
    }):Play();
    task.delay(0.2, function() -- Line: 91
        -- upvalues: TweenService (ref), u8 (ref)
        TweenService:Create(u8, TweenInfo.new(0.5), {
            BackgroundTransparency = 1
        }):Play();
    end);
end;

local u9 = {};

local function computeDroneVolume(p10) -- Line: 105
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

    local v11 = p10:GetAttribute("ZoneRadius") or 12;
    local v12 = Character.Position.X - ZoneCenter.Position.X;
    local v13 = Character.Position.Z - ZoneCenter.Position.Z;
    local math_sqrt_ret = math.sqrt(v12 * v12 + v13 * v13);

    return v11 <= math_sqrt_ret and 2 or 2 + 3 * (1 - math_sqrt_ret / v11);
end;

local function syncDroneVolume(p14) -- Line: 125
    -- upvalues: computeDroneVolume (copy), TweenService (copy)
    local ZoneCenter = p14:FindFirstChild("ZoneCenter");

    if ZoneCenter then
        ZoneCenter = ZoneCenter:FindFirstChild("PullDrone");
    end;

    if not (ZoneCenter and ZoneCenter:IsA("Sound")) then
        return;
    end;

    local v15 = computeDroneVolume(p14);

    if v15 > 0 and not ZoneCenter.IsPlaying then
        ZoneCenter:Play();
    end;

    TweenService:Create(ZoneCenter, TweenInfo.new(0.15), {
        Volume = v15
    }):Play();
end;

local Mesh = ReplicatedStorage:WaitForChild("BubbleModule"):WaitForChild("Mesh");

local function bubbleActive(p16) -- Line: 152
    local Attribute = p16:GetAttribute("State");

    return Attribute == "ACTIVE" and true or Attribute == "CAPTURED";
end;

local function clearBubbles(p17) -- Line: 157
    for _, v in ipairs(p17.bubbles) do
        if v.Parent then
            v:Destroy();
        end;
    end;

    table.clear(p17.bubbles);
end;

local function spawnBubble(p18, u19) -- Line: 164
    -- upvalues: Mesh (copy), TweenService (copy)
    local PrimaryPart = p18.PrimaryPart;

    if not PrimaryPart then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera or (workspace_CurrentCamera.CFrame.Position - PrimaryPart.Position).Magnitude > 300 then
        return;
    end;

    local v20 = (p18:GetAttribute("ZoneRadius") or 12) * 0.5;
    local u21 = Mesh:Clone();
    u21.CFrame = CFrame.new(PrimaryPart.Position);
    u21.Anchored = true;
    u21.CanCollide = false;
    u21.CanQuery = false;
    u21.CanTouch = false;
    u21.Massless = true;
    u21.Material = Enum.Material.Glass;
    u21.Size = Vector3.new(0.05, 0.05, 0.05);
    u21.Transparency = 3;
    u21.Parent = workspace.CurrentCamera;
    table.insert(u19.bubbles, u21);
    TweenService:Create(u21, TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = Vector3.new(v20 * 1.15, v20, v20 * 1.15)
    }):Play();
    task.delay(4, function() -- Line: 184
        -- upvalues: u19 (copy), u21 (copy)
        local table_find_ret = table.find(u19.bubbles, u21);

        if table_find_ret then
            table.remove(u19.bubbles, table_find_ret);
        end;

        if u21.Parent then
            u21:Destroy();
        end;
    end);
end;

local function watchAnomaly(u22) -- Line: 191
    -- upvalues: u9 (copy), syncDroneVolume (copy), clearBubbles (copy), spawnBubble (copy)
    if not u22:IsA("Model") then
        return;
    end;

    if u22:GetAttribute("AnomalyType") ~= "Vortex" then
        return;
    end;

    if u9[u22] then
        return;
    end;

    if not u22:IsDescendantOf(workspace) then
        return;
    end;

    local u23 = {
        stopped = false,
        bubbles = {}
    };
    u9[u22] = u23;
    syncDroneVolume(u22);
    u22:GetAttributeChangedSignal("State"):Connect(function() -- Line: 201
        -- upvalues: syncDroneVolume (ref), u22 (copy), clearBubbles (ref), u23 (copy)
        syncDroneVolume(u22);
        local Attribute = u22:GetAttribute("State");

        if Attribute ~= "ACTIVE" and Attribute ~= "CAPTURED" then
            clearBubbles(u23);
        end;
    end);
    task.spawn(function() -- Line: 209
        -- upvalues: u23 (copy), u22 (copy), syncDroneVolume (ref), spawnBubble (ref), clearBubbles (ref)
        local v24 = os.clock() - math.random() * 1;

        while not u23.stopped and u22.Parent do
            syncDroneVolume(u22);
            local os_clock_ret = os.clock();
            local Attribute = u22:GetAttribute("State");

            if (Attribute == "ACTIVE" and true or Attribute == "CAPTURED") and os_clock_ret - v24 >= 1 then
                spawnBubble(u22, u23);
            else
                os_clock_ret = v24;
            end;

            task.wait(0.15);
            v24 = os_clock_ret;
        end;

        clearBubbles(u23);
    end);
end;

local function unwatchAnomaly(p25) -- Line: 224
    -- upvalues: u9 (copy), clearBubbles (copy)
    local v26 = u9[p25];

    if not v26 then
        return;
    end;

    v26.stopped = true;
    clearBubbles(v26);
    u9[p25] = nil;
end;

for _, v in ipairs(CollectionService:GetTagged("Anomaly")) do
    watchAnomaly(v);
end;

CollectionService:GetInstanceAddedSignal("Anomaly"):Connect(watchAnomaly);
CollectionService:GetInstanceRemovedSignal("Anomaly"):Connect(unwatchAnomaly);
VortexExplosion.OnClientEvent:Connect(function(p27) -- Line: 245
    -- upvalues: LocalPlayer (copy), shakeCamera (copy), darkenScreen (copy)
    if not (p27 and p27.model) then
        return;
    end;

    local model = p27.model;

    if not model.Parent then
        return;
    end;

    local ZoneCenter = model:FindFirstChild("ZoneCenter");
    local BubbleOrigin = model:FindFirstChild("BubbleOrigin");
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    local v28 = BubbleOrigin or ZoneCenter;

    if Character and (v28 and (Character.Position - v28.Position).Magnitude < 25) then
        shakeCamera();
        darkenScreen();
    end;
end);
local UserInputService = game:GetService("UserInputService");
local VortexEscape = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("VortexEscape");
local LeftShift = Enum.KeyCode.LeftShift;
UserInputService.InputBegan:Connect(function(p29) -- Line: 272
    -- upvalues: LeftShift (copy), VortexEscape (copy)
    if p29.KeyCode == LeftShift then
        VortexEscape:FireServer(true);
    end;
end);
UserInputService.InputEnded:Connect(function(p30) -- Line: 277
    -- upvalues: LeftShift (copy), VortexEscape (copy)
    if p30.KeyCode == LeftShift then
        VortexEscape:FireServer(false);
    end;
end);
print("[VortexClient] Initialized");