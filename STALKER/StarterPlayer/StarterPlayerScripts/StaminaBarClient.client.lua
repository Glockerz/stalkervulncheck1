-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local StaminaBar = PlayerGui:WaitForChild("StaminaHUD"):WaitForChild("StaminaBar");
local Fill = StaminaBar:WaitForChild("Fill");
local u1 = nil;
local u2 = 100;
local RunService = game:GetService("RunService");
local WeightBands = require(ReplicatedStorage:WaitForChild("WeightBands"));
local Sound = Instance.new("Sound");
Sound.Name = "ExhaustionBreathing";
Sound.SoundId = "rbxassetid://134336321560595";
Sound.Volume = 0;
Sound.Looped = true;
Sound.Playing = true;
task.defer(function() -- Line: 31
    -- upvalues: LocalPlayer (copy), Sound (copy)
    local Head = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("Head", 5);

    if Head then
        Sound.Parent = Head;
    end;

    LocalPlayer.CharacterAdded:Connect(function(p3) -- Line: 36
        -- upvalues: Sound (ref)
        local Head2 = p3:WaitForChild("Head", 5);

        if Head2 then
            Sound.Parent = Head2;
        end;
    end);
end);
local u4 = 100;
local u5 = 100;
local u6 = 0;
local walkSpeed = require(ReplicatedStorage:WaitForChild("SPH_Assets"):WaitForChild("GameConfig")).walkSpeed;
local u7 = walkSpeed * 0.6;
RunService.RenderStepped:Connect(function() -- Line: 54
    -- upvalues: LocalPlayer (copy), u4 (ref), u5 (ref), WeightBands (copy), u6 (ref), u7 (copy), walkSpeed (copy), Sound (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local CharacterClient = Character:FindFirstChild("CharacterClient", true);

    if not CharacterClient then
        return;
    end;

    local v8 = u4 / u5;
    local v9 = WeightBands.ExhaustionThreshold(u6);

    if v8 < v9 then
        local v10 = v8 / v9;
        CharacterClient:SetAttribute("SpeedCap_Stamina", u7 + (walkSpeed - u7) * v10);
        local v11 = Character:FindFirstChildOfClass("Humanoid");

        if v11 then
            local v12 = v11:FindFirstChildOfClass("Animator");

            if v12 then
                for _, v in v12:GetPlayingAnimationTracks() do
                    if v.Priority == Enum.AnimationPriority.Core or v.Priority == Enum.AnimationPriority.Movement then
                        v:AdjustSpeed(0.5 + 0.5 * v10);
                    end;
                end;
            end;
        end;
    else
        CharacterClient:SetAttribute("SpeedCap_Stamina", nil);
    end;

    Sound.Volume = (1 - v8) * 0.8;
end);
local UserInputService = game:GetService("UserInputService");
local u13 = false;
local u14 = false;
local SprintState = ReplicatedStorage:WaitForChild("Remotes"):FindFirstChild("SprintState");

local function sendSprintState(p15) -- Line: 104
    -- upvalues: u14 (ref), u13 (ref), SprintState (copy)
    if p15 ~= u14 then
        u14 = p15;
        u13 = p15;

        if SprintState then
            SprintState:FireServer(p15);
        end;
    end;
end;

UserInputService.InputBegan:Connect(function(p16, p17) -- Line: 112
    -- upvalues: UserInputService (copy), u14 (ref), u13 (ref), SprintState (copy)
    if UserInputService:GetFocusedTextBox() then
        return;
    end;

    if (p16.KeyCode == Enum.KeyCode.LeftShift or p16.KeyCode == Enum.KeyCode.ButtonL3) and u14 ~= true then
        u14 = true;
        u13 = true;

        if SprintState then
            SprintState:FireServer(true);
        end;
    end;
end);
UserInputService.InputEnded:Connect(function(p18) -- Line: 129
    -- upvalues: u14 (ref), u13 (ref), SprintState (copy)
    if (p18.KeyCode == Enum.KeyCode.LeftShift or p18.KeyCode == Enum.KeyCode.ButtonL3) and u14 ~= false then
        u14 = false;
        u13 = false;

        if SprintState then
            SprintState:FireServer(false);
        end;
    end;
end);
task.spawn(function() -- Line: 136
    -- upvalues: UserInputService (copy), u14 (ref), u13 (ref), SprintState (copy)
    while true do
        repeat
            task.wait(0.2);
        until not (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or (not u14 or u14 == false));

        u14 = false;
        u13 = false;

        if SprintState then
            SprintState:FireServer(false);
        end;
    end;
end);
local DebugSpeedUI = PlayerGui:WaitForChild("DebugSpeedUI", 5);

if DebugSpeedUI then
    local SpeedLabel = DebugSpeedUI:FindFirstChild("SpeedLabel");
    RunService.Heartbeat:Connect(function() -- Line: 150
        -- upvalues: LocalPlayer (copy), SpeedLabel (copy)
        local Character = LocalPlayer.Character;

        if Character then
            local v19 = Character:FindFirstChildOfClass("Humanoid");
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

            if v19 and (HumanoidRootPart and SpeedLabel) then
                SpeedLabel.Text = string.format("WalkSpeed: %d | Vel: %.1f", v19.WalkSpeed, HumanoidRootPart.AssemblyLinearVelocity.Magnitude);
            end;
        end;
    end);
end;

local function updateBarVisibility() -- Line: 166
    -- upvalues: u6 (ref), WeightBands (copy), u4 (ref), u2 (ref), StaminaBar (copy), Fill (copy), TweenService (copy), u1 (ref)
    if u4 >= u2 and u6 < WeightBands.LIGHT then
        if not u1 then
            u1 = task.delay(1, function() -- Line: 187
                -- upvalues: TweenService (ref), StaminaBar (ref), Fill (ref), u1 (ref)
                TweenService:Create(StaminaBar, TweenInfo.new(0.8), {
                    BackgroundTransparency = 1
                }):Play();
                TweenService:Create(Fill, TweenInfo.new(0.8), {
                    BackgroundTransparency = 1
                }):Play();
                task.delay(0.8, function() -- Line: 190
                    -- upvalues: StaminaBar (ref)
                    StaminaBar.Visible = false;
                end);
                u1 = nil;
            end);
        end;

        return;
    end;

    if not StaminaBar.Visible then
        StaminaBar.Visible = true;
        StaminaBar.BackgroundTransparency = 1;
        Fill.BackgroundTransparency = 1;
        TweenService:Create(StaminaBar, TweenInfo.new(0.3), {
            BackgroundTransparency = 0.5
        }):Play();
        TweenService:Create(Fill, TweenInfo.new(0.3), {
            BackgroundTransparency = 0.2
        }):Play();
    end;

    if u1 then
        task.cancel(u1);
        u1 = nil;
    end;

    StaminaBar.BackgroundTransparency = 0.5;
    Fill.BackgroundTransparency = 0.2;
end;

local WeightSync = ReplicatedStorage:WaitForChild("Remotes"):FindFirstChild("WeightSync");

if WeightSync then
    WeightSync.OnClientEvent:Connect(function(p20, p21) -- Line: 203
        -- upvalues: u6 (ref), updateBarVisibility (copy)
        if p20 and (p21 and p21 > 0) then
            u6 = p20 / p21;
            updateBarVisibility();
        end;
    end);
end;

ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("StaminaSync").OnClientEvent:Connect(function(p22, p23) -- Line: 213
    -- upvalues: u2 (ref), u5 (ref), u4 (ref), TweenService (copy), Fill (copy), updateBarVisibility (copy)
    u2 = p23 or 100;
    u5 = u2;
    u4 = p22;
    local v24 = p22 / u2;
    TweenService:Create(Fill, TweenInfo.new(0.15), {
        Size = UDim2.new(v24, 0, 1, 0)
    }):Play();

    if v24 >= 0.5 then
        Fill.BackgroundColor3 = Color3.fromRGB(220, 220, 220);
    elseif v24 >= 0.2 then
        Fill.BackgroundColor3 = Color3.fromRGB(220, 180, 50);
    else
        Fill.BackgroundColor3 = Color3.fromRGB(220, 60, 60);
    end;

    updateBarVisibility();
end);