-- Decompiled with Potassium's decompiler.

for _, child in ipairs(script:GetChildren()) do
    if child:IsA("BillboardGui") then
        child.Enabled = false;
    end;
end;

local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local ProximityPromptService = game:GetService("ProximityPromptService");
local GameConfig = require(game:GetService("ReplicatedStorage").SPH_Assets.GameConfig);
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local script_CanView = script.CanView;
local PickUpUI = LocalPlayer.PlayerGui:WaitForChild("SPH_UI").PickUpUI;

local function ShowPrompt(p2) -- Line: 26
    -- upvalues: script_CanView (copy), u1 (ref), TweenService (copy)
    if script_CanView.Value and (u1 and u1.Humanoid.Health > 0) then
        local PromptUI = p2.PromptUI;
        local Input = PromptUI.Main.Input;
        local Frame = PromptUI.Main.Input.Key.Frame;
        PromptUI.Enabled = true;
        Frame.BackgroundTransparency = 0;
        PromptUI.Main.Size = UDim2.fromScale(0, 0);
        PromptUI.Main.White.BackgroundTransparency = 0;
        PromptUI.Main.Input.Frame.Visible = false;
        PromptUI.Main.Input.Key.Visible = false;

        for _, child in ipairs(Input:GetChildren()) do
            if child:IsA("TextLabel") then
                child.Visible = false;
            end;
        end;

        TweenService:Create(PromptUI.Main, TweenInfo.new(0.2), {
            Size = UDim2.fromScale(1, 0.05)
        }):Play();
        task.wait(0.25);
        TweenService:Create(PromptUI.Main, TweenInfo.new(0.2), {
            Size = UDim2.fromScale(1, 1)
        }):Play();
        TweenService:Create(PromptUI.Main.White, TweenInfo.new(0.2), {
            BackgroundTransparency = 1
        }):Play();
        PromptUI.Main.Input.Frame.Visible = true;
        PromptUI.Main.Input.Key.Visible = true;

        for _, child in ipairs(Input:GetChildren()) do
            if child:IsA("TextLabel") then
                child.Visible = true;
            end;
        end;
    end;
end;

local function HidePrompt(p3) -- Line: 66
    -- upvalues: TweenService (copy)
    local PromptUI = p3.PromptUI;
    local Input = PromptUI.Main.Input;
    PromptUI.Main.Input.Key.Frame.BackgroundTransparency = 1;
    TweenService:Create(PromptUI.Main, TweenInfo.new(0.2), {
        Size = UDim2.fromScale(1, 0.05)
    }):Play();
    TweenService:Create(PromptUI.Main.White, TweenInfo.new(0.2), {
        BackgroundTransparency = 0
    }):Play();
    PromptUI.Main.Input.Frame.Visible = false;
    PromptUI.Main.Input.Key.Visible = false;

    for _, child in ipairs(Input:GetChildren()) do
        if child:IsA("TextLabel") then
            child.Visible = false;
        end;
    end;

    task.wait(0.25);
    TweenService:Create(PromptUI.Main, TweenInfo.new(0.2), {
        Size = UDim2.fromScale(0, 0.05)
    }):Play();
    task.wait(0.2);
    PromptUI.Enabled = false;
end;

local function SetupPrompt(p4) -- Line: 95
    -- upvalues: UserInputService (copy), TweenService (copy)
    local v5 = p4:FindFirstChildWhichIsA("ProximityPrompt");
    local SPH_PromptConfig = v5.SPH_PromptConfig;
    local v6 = script[SPH_PromptConfig.ProxType.Value]:Clone();
    v6.Name = "PromptUI";
    v6.Parent = p4;
    v6.Enabled = false;
    v6.Main.HoldBar.Visible = v5.HoldDuration > 0;
    v6.Main.HoldBar.Bar.Size = UDim2.fromScale(0, 1);
    local Input = v6.Main.Input;
    Input.Key.KeyText.Text = UserInputService:GetStringForKeyCode(v5.KeyboardKeyCode);

    if SPH_PromptConfig:FindFirstChild("AmmoType") then
        Input.AmmoType.Text = SPH_PromptConfig.AmmoType.Value;

        if SPH_PromptConfig.InfAmmo.Value then
            Input.AmmoPool.Text = "INF";
        else
            Input.AmmoPool.Text = SPH_PromptConfig.AmmoPool.Value .. " / " .. SPH_PromptConfig.AmmoPool.MaxValue;
            SPH_PromptConfig.AmmoPool.Changed:Connect(function() -- Line: 114
                -- upvalues: Input (copy), SPH_PromptConfig (copy)
                Input.AmmoPool.Text = SPH_PromptConfig.AmmoPool.Value .. " / " .. SPH_PromptConfig.AmmoPool.MaxValue;
            end);
        end;
    elseif SPH_PromptConfig:FindFirstChild("GunPool") then
        local Name = v5:FindFirstChildWhichIsA("Tool").Name;
        Input.GunName.Text = Name;

        if SPH_PromptConfig.InfGuns.Value then
            Input.Remaining.Text = "INF";
        elseif SPH_PromptConfig.GunPool.MaxValue > 1 then
            Input.Remaining.Text = SPH_PromptConfig.GunPool.Value .. " / " .. SPH_PromptConfig.GunPool.MaxValue .. " REMAINING";
            SPH_PromptConfig.GunPool.Changed:Connect(function() -- Line: 125
                -- upvalues: Input (copy), SPH_PromptConfig (copy)
                Input.Remaining.Text = SPH_PromptConfig.GunPool.Value .. " / " .. SPH_PromptConfig.GunPool.MaxValue .. " REMAINING";
            end);
        else
            Input.Remaining.Text = "";
        end;
    end;

    local Frame = v6.Main.Input.Key.Frame;
    local u7 = TweenService:Create(Frame, TweenInfo.new(0.3), {
        BackgroundTransparency = 0.7,
        Size = UDim2.fromScale(1, 1)
    });
    local u8 = TweenService:Create(Frame, TweenInfo.new(0.1), {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(0, 0)
    });

    if v5.HoldDuration <= 0 then
        v5.Triggered:Connect(function() -- Line: 140
            -- upvalues: Frame (copy)
            Frame.Size = UDim2.fromScale(1, 1);
            Frame.BackgroundTransparency = 0.7;
        end);
        v5.TriggerEnded:Connect(function() -- Line: 144
            -- upvalues: u8 (copy)
            u8:Play();
        end);

        return;
    end;

    local Bar = v6.Main.HoldBar.Bar;
    local u9 = TweenService:Create(Bar, TweenInfo.new(v5.HoldDuration, Enum.EasingStyle.Linear), {
        Size = UDim2.fromScale(1, 1)
    });
    local u10 = TweenService:Create(Bar, TweenInfo.new(0.1), {
        Size = UDim2.fromScale(0, 1)
    });
    v5.PromptButtonHoldBegan:Connect(function() -- Line: 155
        -- upvalues: u7 (copy), u10 (copy), Bar (copy), u9 (copy)
        u7:Play();
        u10:Pause();
        Bar.Size = UDim2.fromScale(0, 1);
        u9:Play();
    end);
    v5.PromptButtonHoldEnded:Connect(function() -- Line: 164
        -- upvalues: u8 (copy), Frame (copy), u9 (copy), u10 (copy)
        u8:Play();
        Frame.Size = UDim2.fromScale(0, 0);
        u9:Pause();
        u10:Play();
    end);
end;

LocalPlayer.CharacterAdded:Connect(function(p11) -- Line: 175
    -- upvalues: u1 (ref), PickUpUI (ref), LocalPlayer (copy), ProximityPromptService (copy)
    local Humanoid = p11:WaitForChild("Humanoid");
    u1 = p11;
    PickUpUI = LocalPlayer.PlayerGui:WaitForChild("SPH_UI").PickUpUI;
    ProximityPromptService.Enabled = true;
    Humanoid.Died:Connect(function() -- Line: 182
        -- upvalues: ProximityPromptService (ref)
        ProximityPromptService.Enabled = false;
    end);
end);
ProximityPromptService.PromptShown:Connect(function(p12) -- Line: 187
    -- upvalues: SetupPrompt (copy), ShowPrompt (copy), PickUpUI (ref), GameConfig (copy)
    if not p12:FindFirstChild("SPH_PromptConfig") then
        if PickUpUI:FindFirstChild("ItemName") and p12.Parent.Parent:FindFirstChild("PickupHighlight") then
            p12.Parent.Parent.PickupHighlight.Enabled = true;
            PickUpUI.Visible = true;
            PickUpUI.ItemName.Text = "[" .. string.upper(GameConfig.pickupKey[1].Name) .. "] " .. p12.Parent.Parent.Name;
            local v13 = p12.Parent.Parent:FindFirstChildWhichIsA("Tool");

            if v13 and v13:FindFirstChild("SPH_Weapon") then
                local WeaponStats = require(v13.SPH_Weapon.WeaponStats);
                PickUpUI.ItemName.Text = PickUpUI.ItemName.Text .. " " .. WeaponStats.ammoType;
            end;
        end;

        return;
    end;

    if not p12.Parent:FindFirstChild("PromptUI") then
        SetupPrompt(p12.Parent);
    end;

    ShowPrompt(p12.Parent);
end);
ProximityPromptService.PromptHidden:Connect(function(p14) -- Line: 206
    -- upvalues: SetupPrompt (copy), HidePrompt (copy), PickUpUI (ref)
    if p14:FindFirstChild("SPH_PromptConfig") then
        if not p14.Parent:FindFirstChild("PromptUI") then
            SetupPrompt(p14.Parent);
        end;

        HidePrompt(p14.Parent);

        return;
    end;

    if not (p14.Parent and p14.Parent.Parent:FindFirstChild("PickupHighlight")) then
        PickUpUI.Visible = false;

        return;
    end;

    p14.Parent.Parent.PickupHighlight.Enabled = false;
    PickUpUI.Visible = false;
end);