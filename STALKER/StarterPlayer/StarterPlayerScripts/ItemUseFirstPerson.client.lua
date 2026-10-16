-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local u1 = false;
local u2 = nil;

local function showArms() -- Line: 9
    -- upvalues: u1 (ref), LocalPlayer (copy), u2 (ref), RunService (copy)
    u1 = true;

    if not LocalPlayer.Character then
        return;
    end;

    u2 = RunService.RenderStepped:Connect(function() -- Line: 15
        -- upvalues: u1 (ref), LocalPlayer (ref)
        if not u1 then
            return;
        end;

        local Character = LocalPlayer.Character;

        if not Character then
            return;
        end;

        local v3 = Character:FindFirstChild("Right Arm");
        local v4 = Character:FindFirstChild("Left Arm");

        if v3 then
            v3.LocalTransparencyModifier = 0;
        end;

        if v4 then
            v4.LocalTransparencyModifier = 0;
        end;

        local Handle = Character:FindFirstChild("Handle");

        if Handle then
            Handle.LocalTransparencyModifier = 0;

            for _, descendant in Handle:GetDescendants() do
                if descendant:IsA("BasePart") then
                    descendant.LocalTransparencyModifier = 0;
                end;
            end;
        end;
    end);
end;

local function hideArms() -- Line: 39
    -- upvalues: u1 (ref), u2 (ref)
    u1 = false;

    if u2 then
        u2:Disconnect();
        u2 = nil;
    end;
end;

local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "ItemUseLoadingGui";
ScreenGui.ResetOnSpawn = false;
ScreenGui.DisplayOrder = 10;
ScreenGui.Parent = LocalPlayer.PlayerGui;
local Frame = Instance.new("Frame");
Frame.Name = "LoadingContainer";
Frame.Size = UDim2.new(0, 200, 0, 30);
Frame.Position = UDim2.new(0.5, 0, 0.75, 0);
Frame.AnchorPoint = Vector2.new(0.5, 0.5);
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
Frame.BackgroundTransparency = 0.5;
Frame.BorderSizePixel = 0;
Frame.Visible = false;
Frame.Parent = ScreenGui;
local UICorner = Instance.new("UICorner");
UICorner.CornerRadius = UDim.new(0, 4);
UICorner.Parent = Frame;
local Frame2 = Instance.new("Frame");
Frame2.Name = "Fill";
Frame2.Size = UDim2.new(0, 0, 1, 0);
Frame2.BackgroundColor3 = Color3.fromRGB(200, 200, 200);
Frame2.BackgroundTransparency = 0.3;
Frame2.BorderSizePixel = 0;
Frame2.Parent = Frame;
local UICorner2 = Instance.new("UICorner");
UICorner2.CornerRadius = UDim.new(0, 4);
UICorner2.Parent = Frame2;
local TextLabel = Instance.new("TextLabel");
TextLabel.Name = "ItemLabel";
TextLabel.Size = UDim2.new(1, 0, 0, 18);
TextLabel.Position = UDim2.new(0, 0, -1, -2);
TextLabel.BackgroundTransparency = 1;
TextLabel.TextColor3 = Color3.fromRGB(220, 220, 220);
TextLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
TextLabel.TextSize = 30;
TextLabel.Text = "";
TextLabel.Parent = Frame;
local u5 = nil;
ReplicatedStorage.Remotes.ItemUseStarted.OnClientEvent:Connect(function(p6, p7, p8, p9) -- Line: 94
    -- upvalues: u1 (ref), LocalPlayer (copy), u2 (ref), RunService (copy), ReplicatedStorage (copy), TextLabel (copy), Frame2 (copy), Frame (copy), u5 (ref)
    local u10 = p9 == "bench";
    u1 = true;

    if LocalPlayer.Character then
        u2 = RunService.RenderStepped:Connect(function() -- Line: 15
            -- upvalues: u1 (ref), LocalPlayer (ref)
            if not u1 then
                return;
            end;

            local Character = LocalPlayer.Character;

            if not Character then
                return;
            end;

            local v11 = Character:FindFirstChild("Right Arm");
            local v12 = Character:FindFirstChild("Left Arm");

            if v11 then
                v11.LocalTransparencyModifier = 0;
            end;

            if v12 then
                v12.LocalTransparencyModifier = 0;
            end;

            local Handle = Character:FindFirstChild("Handle");

            if Handle then
                Handle.LocalTransparencyModifier = 0;

                for _, descendant in Handle:GetDescendants() do
                    if descendant:IsA("BasePart") then
                        descendant.LocalTransparencyModifier = 0;
                    end;
                end;
            end;
        end);
    end;

    if LocalPlayer.Character then
        LocalPlayer.Character:SetAttribute("_UsingItem", true);
    end;

    local InventoryController = require(ReplicatedStorage:FindFirstChild("InventoryController"));

    if InventoryController then
        InventoryController.IsUsingItem = true;
    end;

    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
    local TweenService = game:GetService("TweenService");
    TextLabel.Text = string.upper(p8 or "USING...");
    Frame2.Size = UDim2.new(0, 0, 1, 0);
    Frame.Visible = true;
    u5 = TweenService:Create(Frame2, TweenInfo.new(p7 or 3, Enum.EasingStyle.Linear), {
        Size = UDim2.new(1, 0, 1, 0)
    });
    u5:Play();
    local Lighting = game:GetService("Lighting");
    local HealEffect = Lighting:FindFirstChild("HealEffect");

    if not HealEffect then
        HealEffect = Instance.new("ColorCorrectionEffect");
        HealEffect.Name = "HealEffect";
        HealEffect.Brightness = 0;
        HealEffect.Contrast = 0;
        HealEffect.Saturation = 0;
        HealEffect.TintColor = Color3.fromRGB(255, 255, 255);
        HealEffect.Parent = Lighting;
    end;

    task.delay(p6 or 0, function() -- Line: 151
        -- upvalues: u10 (copy), HealEffect (ref), TweenService (copy)
        if u10 then
            return;
        end;

        HealEffect.Brightness = 0.15;
        HealEffect.Saturation = -0.2;
        HealEffect.TintColor = Color3.fromRGB(230, 255, 230);
        TweenService:Create(HealEffect, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Brightness = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
end);
ReplicatedStorage.Remotes.ItemUseStopped.OnClientEvent:Connect(function() -- Line: 165
    -- upvalues: u1 (ref), u2 (ref), LocalPlayer (copy), ReplicatedStorage (copy), Frame (copy), u5 (ref)
    u1 = false;

    if u2 then
        u2:Disconnect();
        u2 = nil;
    end;

    if LocalPlayer.Character then
        LocalPlayer.Character:SetAttribute("_UsingItem", false);
    end;

    local InventoryController = require(ReplicatedStorage:FindFirstChild("InventoryController"));

    if InventoryController then
        InventoryController.IsUsingItem = false;
    end;

    Frame.Visible = false;

    if u5 then
        u5:Cancel();
        u5 = nil;
    end;
end);

local function getActiveEffectsFrame() -- Line: 184
    -- upvalues: LocalPlayer (copy)
    local StatusHUD = LocalPlayer.PlayerGui:FindFirstChild("StatusHUD");

    if not StatusHUD then
        return nil;
    end;

    local ActiveEffects = StatusHUD:FindFirstChild("ActiveEffects");

    if not ActiveEffects then
        ActiveEffects = Instance.new("Frame");
        ActiveEffects.Name = "ActiveEffects";
        ActiveEffects.Size = UDim2.new(0, 250, 0, 55);
        ActiveEffects.Position = UDim2.new(1, -16, 1, -140);
        ActiveEffects.AnchorPoint = Vector2.new(1, 1);
        ActiveEffects.BackgroundTransparency = 1;
        ActiveEffects.Parent = StatusHUD;
        local UIListLayout = Instance.new("UIListLayout");
        UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right;
        UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom;
        UIListLayout.Padding = UDim.new(0, 8);
        UIListLayout.Parent = ActiveEffects;
    end;

    return ActiveEffects;
end;

local function createEffectIndicator(p13, p14, u15) -- Line: 213
    -- upvalues: getActiveEffectsFrame (copy)
    local v16 = getActiveEffectsFrame();

    if not v16 then
        return;
    end;

    local Frame3 = Instance.new("Frame");
    Frame3.Name = (p14 or "Effect") .. "_" .. tostring(tick());
    Frame3.Size = UDim2.new(0, 55, 0, 65);
    Frame3.BackgroundTransparency = 1;
    Frame3.LayoutOrder = #v16:GetChildren();
    Frame3.Parent = v16;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Icon";
    ImageLabel.Size = UDim2.new(0, 45, 0, 45);
    ImageLabel.Position = UDim2.new(0.5, 0, 0, 0);
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = p13 or "";
    ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255);
    ImageLabel.ImageTransparency = 0.4;
    ImageLabel.ScaleType = Enum.ScaleType.Fit;
    ImageLabel.Parent = Frame3;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Name = "Timer";
    TextLabel2.Size = UDim2.new(1, 0, 0, 16);
    TextLabel2.Position = UDim2.new(0, 0, 1, -16);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.TextColor3 = Color3.fromRGB(200, 200, 200);
    TextLabel2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
    TextLabel2.TextSize = 13;
    TextLabel2.Text = "";
    TextLabel2.Parent = Frame3;
    task.spawn(function() -- Line: 248
        -- upvalues: u15 (copy), TextLabel2 (copy), Frame3 (copy)
        local v17 = u15;

        while v17 > 0 do
            local math_floor_ret = math.floor(v17 / 60);
            local v18 = v17 % 60;

            if math_floor_ret > 0 then
                TextLabel2.Text = string.format("%d:%02d", math_floor_ret, v18);
            else
                TextLabel2.Text = tostring(v18) .. "s";
            end;

            task.wait(1);
            v17 = v17 - 1;
        end;

        Frame3:Destroy();
    end);
end;

local u19 = false;
local u20 = nil;

local function startAimJitter(p21) -- Line: 269
    -- upvalues: u19 (ref), u20 (ref), RunService (copy)
    if u19 then
        return;
    end;

    u19 = true;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local UserInputService = game:GetService("UserInputService");
    u20 = RunService.RenderStepped:Connect(function(p22) -- Line: 276
        -- upvalues: u19 (ref), UserInputService (copy), workspace_CurrentCamera (copy)
        if not u19 then
            return;
        end;

        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            local v23 = (math.random() - 0.5) * 0.003;
            local v24 = (math.random() - 0.5) * 0.003;
            workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.Angles(v23, v24, 0);
        end;
    end);
    task.delay(p21, function() -- Line: 286
        -- upvalues: u19 (ref), u20 (ref)
        u19 = false;

        if u20 then
            u20:Disconnect();
            u20 = nil;
        end;
    end);
end;

ReplicatedStorage.Remotes.SideEffect.OnClientEvent:Connect(function(p25, u26, p27, p28, p29) -- Line: 296
    -- upvalues: createEffectIndicator (copy), startAimJitter (copy)
    createEffectIndicator(p27, p28, u26);

    if p29 then
        startAimJitter(u26);
    end;

    local TweenService = game:GetService("TweenService");
    local Lighting = game:GetService("Lighting");

    if p25 ~= "Contrast" then
        if p25 == "Desaturation" then
            local SideEffect = Lighting:FindFirstChild("SideEffect");

            if not SideEffect then
                SideEffect = Instance.new("ColorCorrectionEffect");
                SideEffect.Name = "SideEffect";
                SideEffect.Parent = Lighting;
            end;

            SideEffect.Saturation = 0;
            TweenService:Create(SideEffect, TweenInfo.new(u26 * 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Saturation = -0.8
            }):Play();
            task.delay(u26 * 0.7, function() -- Line: 344
                -- upvalues: TweenService (copy), SideEffect (ref), u26 (copy)
                TweenService:Create(SideEffect, TweenInfo.new(u26 * 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Saturation = 0
                }):Play();
            end);
        end;

        return;
    end;

    local SideEffect = Lighting:FindFirstChild("SideEffect");

    if not SideEffect then
        SideEffect = Instance.new("ColorCorrectionEffect");
        SideEffect.Name = "SideEffect";
        SideEffect.Parent = Lighting;
    end;

    SideEffect.Contrast = 0;
    TweenService:Create(SideEffect, TweenInfo.new(u26 * 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Contrast = 0.5
    }):Play();
    task.delay(u26 * 0.8, function() -- Line: 322
        -- upvalues: TweenService (copy), SideEffect (ref), u26 (copy)
        TweenService:Create(SideEffect, TweenInfo.new(u26 * 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Contrast = 0
        }):Play();
    end);
end);
local TweenService = game:GetService("TweenService");
local u30 = nil;

local function ensureVignette() -- Line: 358
    -- upvalues: u30 (ref), LocalPlayer (copy)
    if u30 and u30.Parent then
        return u30;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");

    if PlayerGui then
        PlayerGui = PlayerGui:FindFirstChild("SPH_UI");
    end;

    if PlayerGui then
        PlayerGui = PlayerGui:FindFirstChild("DamageUI");
    end;

    local v31;

    if PlayerGui then
        v31 = PlayerGui:FindFirstChild("Damage2d");
    else
        v31 = PlayerGui;
    end;

    if not v31 then
        return nil;
    end;

    local BleedVignette = PlayerGui:FindFirstChild("BleedVignette");

    if not BleedVignette then
        BleedVignette = Instance.new("ImageLabel");
        BleedVignette.Name = "BleedVignette";
        BleedVignette.Image = v31.Image;
        BleedVignette.BackgroundTransparency = 1;
        BleedVignette.Size = v31.Size;
        BleedVignette.Position = v31.Position;
        BleedVignette.AnchorPoint = v31.AnchorPoint;
        BleedVignette.ScaleType = v31.ScaleType;
        BleedVignette.ImageColor3 = v31.ImageColor3;
        BleedVignette.ImageTransparency = 1;
        BleedVignette.ZIndex = math.max(1, (v31.ZIndex or 1) - 1);
        BleedVignette.Parent = PlayerGui;
    end;

    u30 = BleedVignette;

    return BleedVignette;
end;

ReplicatedStorage.Remotes:WaitForChild("BleedSync").OnClientEvent:Connect(function(p32, p33) -- Line: 384
    -- upvalues: ensureVignette (copy), TweenService (copy)
    local v34 = ensureVignette();

    if not v34 then
        return;
    end;

    local math_clamp_ret = math.clamp((p32 or 0) / (p33 or 1), 0, 1);
    TweenService:Create(v34, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = math_clamp_ret > 0 and math_clamp_ret * -0.39999999999999997 + 0.85 or 1
    }):Play();
end);

local function clearAllEffects() -- Line: 404
    -- upvalues: u1 (ref), u2 (ref), u19 (ref), u20 (ref), LocalPlayer (copy), Frame (copy), u5 (ref)
    u1 = false;

    if u2 then
        u2:Disconnect();
        u2 = nil;
    end;

    u19 = false;

    if u20 then
        u20:Disconnect();
        u20 = nil;
    end;

    local Lighting = game:GetService("Lighting");

    for _, v in ipairs({ "SideEffect", "HealEffect" }) do
        local v35 = Lighting:FindFirstChild(v);

        if v35 and v35:IsA("ColorCorrectionEffect") then
            v35.Brightness = 0;
            v35.Contrast = 0;
            v35.Saturation = 0;
            v35.TintColor = Color3.fromRGB(255, 255, 255);
        end;
    end;

    local v36 = LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("StatusHUD");

    if v36 then
        v36 = v36:FindFirstChild("ActiveEffects");
    end;

    if v36 then
        for _, child in ipairs(v36:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;
    end;

    Frame.Visible = false;

    if u5 then
        u5:Cancel();
        u5 = nil;
    end;
end;

LocalPlayer.CharacterAdded:Connect(clearAllEffects);
local v37 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

if v37 then
    v37.Died:Connect(clearAllEffects);
end;

LocalPlayer.CharacterAdded:Connect(function(p38) -- Line: 440
    -- upvalues: clearAllEffects (copy)
    local Humanoid = p38:WaitForChild("Humanoid", 10);

    if Humanoid then
        Humanoid.Died:Connect(clearAllEffects);
    end;
end);