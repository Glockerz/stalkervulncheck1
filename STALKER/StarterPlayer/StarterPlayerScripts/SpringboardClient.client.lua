-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
local LocalPlayer = Players.LocalPlayer;
local SpringboardRingPulse = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("SpringboardRingPulse");
local Mesh = ReplicatedStorage:WaitForChild("BubbleModule"):WaitForChild("Mesh");
local u1 = nil;
local u2 = nil;

local function ensureDarkenGui() -- Line: 37
    -- upvalues: u1 (ref), LocalPlayer (copy), u2 (ref)
    if u1 then
        return;
    end;

    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    u1 = Instance.new("ScreenGui");
    u1.Name = "SpringboardDarken";
    u1.IgnoreGuiInset = true;
    u1.ResetOnSpawn = false;
    u1.DisplayOrder = 50;
    u1.Parent = PlayerGui;
    u2 = Instance.new("Frame");
    u2.Size = UDim2.new(1, 0, 1, 0);
    u2.BackgroundColor3 = Color3.new(0, 0, 0);
    u2.BackgroundTransparency = 1;
    u2.BorderSizePixel = 0;
    u2.Parent = u1;
end;

local function darkenScreen() -- Line: 54
    -- upvalues: ensureDarkenGui (copy), TweenService (copy), u2 (ref)
    ensureDarkenGui();
    TweenService:Create(u2, TweenInfo.new(0.05), {
        BackgroundTransparency = 0.5
    }):Play();
    task.delay(0.15000000000000002, function() -- Line: 59
        -- upvalues: TweenService (ref), u2 (ref)
        TweenService:Create(u2, TweenInfo.new(0.4), {
            BackgroundTransparency = 1
        }):Play();
    end);
end;

local function shakeCamera() -- Line: 65
    -- upvalues: LocalPlayer (copy), RunService (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    if not Character then
        return;
    end;

    local os_clock_ret = os.clock();
    local u3 = nil;
    u3 = RunService.RenderStepped:Connect(function() -- Line: 72
        -- upvalues: os_clock_ret (copy), Character (copy), u3 (ref)
        local v4 = os.clock() - os_clock_ret;

        if v4 >= 0.5 or not Character.Parent then
            if Character.Parent then
                Character.CameraOffset = Vector3.new(0, 0, 0);
            end;

            u3:Disconnect();

            return;
        end;

        local v5 = 0.5 * (1 - v4 / 0.5);
        local v6 = (math.random() - 0.5) * 2 * v5;
        local v7 = (math.random() - 0.5) * 2 * v5;
        local v8 = (math.random() - 0.5) * 2 * v5;
        Character.CameraOffset = Vector3.new(v6, v7, v8);
    end);
end;

local Effects = workspace:FindFirstChild("Effects");

if not Effects then
    Effects = Instance.new("Folder");
    Effects.Name = "Effects";
    Effects.Parent = workspace;
end;

local ForceField = Enum.Material.ForceField;
local u9 = {};

local function startOscillate(p10) -- Line: 141
    if p10.tween then
        p10.tween:Cancel();
        p10.tween = nil;
    end;

    local v11 = p10.sizeMax.Y - p10.sizeMin.Y;
    local v12 = v11 > 0 and (math.clamp((p10.bubble.Size.Y - p10.sizeMin.Y) / v11, 0, 1) or 0) or 0;
    local math_clamp_ret = math.clamp(v12 * 2 - 1, -1, 1);
    p10.phase = math.asin(math_clamp_ret) - os.clock() * 6.283185307179586 / p10.period;
    p10.oscillating = true;
end;

RunService.Heartbeat:Connect(function() -- Line: 154
    -- upvalues: u9 (copy)
    local os_clock_ret = os.clock();

    for _, v in pairs(u9) do
        if v.oscillating and (v.bubble and v.bubble.Parent) then
            local v13 = (math.sin(os_clock_ret * 6.283185307179586 / v.period + v.phase) + 1) * 0.5;
            v.bubble.Size = v.sizeMin:Lerp(v.sizeMax, v13);
            v.bubble.Transparency = v13 * -0.19999999999999996 + 0.85;
        end;
    end;
end);

local function implodeAndRestore(u14, p15) -- Line: 168
    -- upvalues: TweenService (copy), startOscillate (copy)
    if not (u14 and (u14.bubble and u14.bubble.Parent)) then
        return;
    end;

    u14.burstToken = (u14.burstToken or 0) + 1;
    local burstToken = u14.burstToken;
    u14.oscillating = false;

    if u14.tween then
        u14.tween:Cancel();
    end;

    local v16 = TweenService:Create(u14.bubble, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = Vector3.new(0.05, 0.05, 0.05)
    });
    u14.tween = v16;
    v16:Play();
    local math_max_ret = math.max(0, p15 - 0.18 - 0.35);
    task.delay(math_max_ret + 0.18, function() -- Line: 186
        -- upvalues: u14 (copy), burstToken (copy), TweenService (ref), startOscillate (ref)
        if u14.burstToken ~= burstToken then
            return;
        end;

        if not (u14.bubble and u14.bubble.Parent) then
            return;
        end;

        local v17 = TweenService:Create(u14.bubble, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = u14.sizeMin
        });
        u14.tween = v17;
        v17:Play();
        v17.Completed:Connect(function() -- Line: 196
            -- upvalues: u14 (ref), burstToken (ref), startOscillate (ref)
            if u14.burstToken ~= burstToken then
                return;
            end;

            startOscillate(u14);
        end);
    end);
end;

local u18 = nil;
local u19 = {};

local function spawnPersistentBubble(u20) -- Line: 221
    -- upvalues: u9 (copy), u19 (copy), u18 (ref)
    if not (u20 and u20:IsA("Model")) then
        return;
    end;

    if u9[u20] then
        return;
    end;

    if u19[u20] then
        return;
    end;

    u19[u20] = true;
    task.spawn(function() -- Line: 227
        -- upvalues: u20 (copy), u9 (ref), u18 (ref), u19 (ref)
        local os_clock_ret = os.clock();

        while os.clock() - os_clock_ret < 20 and (u20.Parent and not u9[u20]) do
            local Attribute = u20:GetAttribute("AnomalyType");
            local v21 = u20:FindFirstChild("BubbleOrigin") or u20.PrimaryPart;

            if Attribute ~= nil and v21 then
                if Attribute == "Springboard" then
                    u18(u20, v21);
                end;

                break;
            end;

            task.wait(0.25);
        end;

        u19[u20] = nil;
    end);
end;

u18 = function(p22, p23) -- Line: 251, Name: buildPersistentBubble
    -- upvalues: u9 (copy), Mesh (copy), ForceField (copy), Effects (ref)
    if u9[p22] then
        return;
    end;

    local v24 = p22:GetAttribute("ZoneRadius") or 12;
    local v25 = v24 * 0.45;
    local v26 = v24 * 0.9;
    local Vector3_new_ret = Vector3.new(v25 * 1.15, v25, v25 * 1.15);
    local Vector3_new_ret2 = Vector3.new(v26 * 1.15, v26, v26 * 1.15);
    local v27 = Mesh:Clone();
    v27.CFrame = p23.CFrame;
    v27.Anchored = true;
    v27.CanCollide = false;
    v27.Massless = true;
    v27.Material = ForceField;
    v27.Size = Vector3_new_ret;
    v27.Transparency = 0.85;
    v27.Parent = Effects;
    u9[p22] = {
        tween = nil,
        burstToken = 0,
        oscillating = true,
        bubble = v27,
        sizeMin = Vector3_new_ret,
        sizeMax = Vector3_new_ret2,
        period = 6 * (1 + (math.random() * 2 - 1) * 0.25),
        phase = math.random() * 2 * 3.141592653589793
    };
end;

local function despawnPersistentBubble(p28) -- Line: 288
    -- upvalues: u19 (copy), u9 (copy)
    u19[p28] = nil;
    local v29 = u9[p28];

    if v29 then
        v29.oscillating = false;

        if v29.tween then
            v29.tween:Cancel();
        end;

        if v29.bubble and v29.bubble.Parent then
            v29.bubble:Destroy();
        end;
    end;

    u9[p28] = nil;
end;

for _, v in ipairs(CollectionService:GetTagged("Anomaly")) do
    spawnPersistentBubble(v);
end;

CollectionService:GetInstanceAddedSignal("Anomaly"):Connect(spawnPersistentBubble);
CollectionService:GetInstanceRemovedSignal("Anomaly"):Connect(despawnPersistentBubble);
task.spawn(function() -- Line: 319
    -- upvalues: CollectionService (copy), u9 (copy), spawnPersistentBubble (copy)
    while true do
        task.wait(2);

        for _, v in ipairs(CollectionService:GetTagged("Anomaly")) do
            if not u9[v] then
                spawnPersistentBubble(v);
            end;
        end;
    end;
end);
SpringboardRingPulse.OnClientEvent:Connect(function(p30) -- Line: 333
    -- upvalues: u9 (copy), implodeAndRestore (copy), LocalPlayer (copy), shakeCamera (copy), darkenScreen (copy)
    if not (p30 and p30.model) then
        return;
    end;

    local model = p30.model;

    if not model.Parent then
        return;
    end;

    local v31 = u9[model];

    if v31 then
        implodeAndRestore(v31, p30.cooldown or 3);
    end;

    local v32 = model:FindFirstChild("BubbleOrigin") or model:FindFirstChild("ZoneCenter");

    if not v32 then
        return;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if Character and (Character.Position - v32.Position).Magnitude < 12 then
        shakeCamera();
        darkenScreen();
    end;
end);
print("[SpringboardClient] Initialized");