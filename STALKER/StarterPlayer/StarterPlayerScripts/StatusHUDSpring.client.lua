-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local StatusContainer = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("StatusHUD"):WaitForChild("StatusContainer");
StatusContainer.Position = UDim2.new(1, -16, 1, -68);
StatusContainer.Size = UDim2.fromOffset(250, 64);
local v1 = StatusContainer:FindFirstChildOfClass("UIListLayout");

if v1 then
    v1.Padding = UDim.new(0, 6);
    v1.HorizontalAlignment = Enum.HorizontalAlignment.Right;
end;

local v2 = StatusContainer:FindFirstChildOfClass("UIPadding");

if v2 then
    v2.PaddingLeft = UDim.new(0, 0);
    v2.PaddingRight = UDim.new(0, 0);
end;

local u3 = {};

local function buildChip(p4) -- Line: 31
    -- upvalues: StatusContainer (copy), u3 (copy)
    local v5 = StatusContainer:WaitForChild(p4);
    local Frame = Instance.new("Frame");
    Frame.Name = p4 .. "Chip";
    Frame.Size = UDim2.fromOffset(48, 56);
    Frame.LayoutOrder = v5.LayoutOrder;
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.Parent = StatusContainer;
    v5.Size = UDim2.fromOffset(34, 34);
    v5.Position = UDim2.new(0.5, 0, 0, 5);
    v5.AnchorPoint = Vector2.new(0.5, 0);
    v5.BackgroundTransparency = 1;
    v5.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "BarTrack";
    Frame2.AnchorPoint = Vector2.new(0.5, 1);
    Frame2.Position = UDim2.new(0.5, 0, 1, -5);
    Frame2.Size = UDim2.new(1, -12, 0, 6);
    Frame2.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    Frame2.BackgroundTransparency = 0.5;
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = Frame;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(1, 0);
    UICorner.Parent = Frame2;
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "Fill";
    Frame3.Size = UDim2.new(1, 0, 1, 0);
    Frame3.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Frame3.BorderSizePixel = 0;
    Frame3.Parent = Frame2;
    local UICorner2 = Instance.new("UICorner");
    UICorner2.CornerRadius = UDim.new(1, 0);
    UICorner2.Parent = Frame3;
    u3[p4] = {
        icon = v5,
        fill = Frame3
    };
end;

local ImageLabel = Instance.new("ImageLabel");
ImageLabel.Name = "Bleeding";
ImageLabel.Image = "rbxassetid://100351074073995";
ImageLabel.BackgroundTransparency = 1;
ImageLabel.Size = UDim2.fromOffset(34, 34);
ImageLabel.ImageColor3 = Color3.fromRGB(200, 40, 40);
ImageLabel.ImageTransparency = 1;
ImageLabel.LayoutOrder = -1;
ImageLabel.Parent = StatusContainer;
buildChip("Bleeding");
buildChip("Blood");
buildChip("Food");
buildChip("Thirst");
buildChip("Radiation");
local BleedingChip = StatusContainer:FindFirstChild("BleedingChip");

if BleedingChip then
    BleedingChip.Visible = false;
end;

local function setFill(p6, p7, p8) -- Line: 96
    if not p6 then
        return;
    end;

    p6.fill.Size = UDim2.new(math.clamp(p7 / 100, 0, 1), 0, 1, 0);
    p6.fill.BackgroundColor3 = p8;
end;

local function getStatusColor(p9) -- Line: 103
    if p9 >= 90 then
        return Color3.fromRGB(255, 255, 255);
    end;

    if p9 >= 70 then
        local v10 = (p9 - 70) / 20;

        return Color3.fromRGB(255, math.floor(255 * v10 + 200 * (1 - v10)), (math.floor(255 * v10 + 50 * (1 - v10))));
    end;

    if p9 >= 40 then
        local v11 = (p9 - 40) / 30;

        return Color3.fromRGB(255, math.floor(200 * v11 + 100 * (1 - v11)), (math.floor(50 * v11)));
    end;

    local v12 = p9 / 40;

    return Color3.fromRGB(math.floor(255 * v12 + 200 * (1 - v12)), math.floor(100 * v12 + 30 * (1 - v12)), (math.floor(30 * (1 - v12))));
end;

local icon = u3.Blood.icon;

local function connectHealth(p13) -- Line: 121
    -- upvalues: icon (copy), getStatusColor (copy), u3 (copy)
    local Humanoid = p13:WaitForChild("Humanoid", 5);

    if not Humanoid then
        return;
    end;

    Humanoid.HealthChanged:Connect(function() -- Line: 125, Name: updateHealth
        -- upvalues: Humanoid (copy), icon (ref), getStatusColor (ref), u3 (ref)
        local v14 = Humanoid.Health / Humanoid.MaxHealth * 100;
        icon.ImageColor3 = getStatusColor(v14);
        icon:SetAttribute("Value", (math.floor(v14)));
        local Blood = u3.Blood;
        local v15 = getStatusColor(v14);

        if not Blood then
            return;
        end;

        Blood.fill.Size = UDim2.new(math.clamp(v14 / 100, 0, 1), 0, 1, 0);
        Blood.fill.BackgroundColor3 = v15;
    end);
    local v16 = Humanoid.Health / Humanoid.MaxHealth * 100;
    icon.ImageColor3 = getStatusColor(v16);
    icon:SetAttribute("Value", (math.floor(v16)));
    local Blood = u3.Blood;
    local v17 = getStatusColor(v16);

    if not Blood then
        return;
    end;

    Blood.fill.Size = UDim2.new(math.clamp(v16 / 100, 0, 1), 0, 1, 0);
    Blood.fill.BackgroundColor3 = v17;
end;

local u18 = LocalPlayer.Character and LocalPlayer.Character:WaitForChild("Humanoid", 5);

if u18 then
    u18.HealthChanged:Connect(function() -- Line: 125, Name: updateHealth
        -- upvalues: u18 (copy), icon (copy), getStatusColor (copy), u3 (copy)
        local v19 = u18.Health / u18.MaxHealth * 100;
        icon.ImageColor3 = getStatusColor(v19);
        icon:SetAttribute("Value", (math.floor(v19)));
        local Blood = u3.Blood;
        local v20 = getStatusColor(v19);

        if not Blood then
            return;
        end;

        Blood.fill.Size = UDim2.new(math.clamp(v19 / 100, 0, 1), 0, 1, 0);
        Blood.fill.BackgroundColor3 = v20;
    end);
    local v21 = u18.Health / u18.MaxHealth * 100;
    icon.ImageColor3 = getStatusColor(v21);
    icon:SetAttribute("Value", (math.floor(v21)));
    local Blood = u3.Blood;
    local v22 = getStatusColor(v21);

    if Blood then
        Blood.fill.Size = UDim2.new(math.clamp(v21 / 100, 0, 1), 0, 1, 0);
        Blood.fill.BackgroundColor3 = v22;
    end;
end;

LocalPlayer.CharacterAdded:Connect(connectHealth);
local icon2 = u3.Food.icon;
local icon3 = u3.Thirst.icon;
local SurvivalSync = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("SurvivalSync", 10);
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local UserInputService = game:GetService("UserInputService");
local u23 = nil;
local u24 = nil;
local u25 = false;
local u26 = nil;

local function updateHungerEffects(p27) -- Line: 154
    -- upvalues: u23 (ref), Lighting (copy), TweenService (copy), LocalPlayer (copy)
    if p27 <= 30 then
        if not u23 then
            u23 = Instance.new("BlurEffect");
            u23.Name = "HungerBlur";
            u23.Size = 0;
            u23.Parent = Lighting;
        end;

        TweenService:Create(u23, TweenInfo.new(1), {
            Size = (1 - p27 / 30) * 8
        }):Play();
    elseif u23 then
        TweenService:Create(u23, TweenInfo.new(1), {
            Size = 0
        }):Play();
    end;

    local Character = LocalPlayer.Character;
    local v28 = Character and Character:FindFirstChildOfClass("Humanoid");

    if v28 then
        if p27 <= 10 then
            v28.WalkSpeed = math.max(8, v28.WalkSpeed * 0.6);

            return;
        end;

        if p27 <= 30 then
            v28.WalkSpeed = math.max(12, v28.WalkSpeed * 0.85);
        end;
    end;
end;

local function updateThirstEffects(u29) -- Line: 187
    -- upvalues: u24 (ref), Lighting (copy), TweenService (copy), u25 (ref), u26 (ref), RunService (copy), UserInputService (copy)
    if u29 <= 30 then
        if not u24 then
            u24 = Instance.new("ColorCorrectionEffect");
            u24.Name = "ThirstDesat";
            u24.Parent = Lighting;
        end;

        TweenService:Create(u24, TweenInfo.new(1), {
            Saturation = (1 - u29 / 30) * -0.7
        }):Play();
    elseif u24 then
        TweenService:Create(u24, TweenInfo.new(1), {
            Saturation = 0
        }):Play();
    end;

    if u29 <= 20 then
        if not u25 then
            u25 = true;
            local workspace_CurrentCamera = workspace.CurrentCamera;
            u26 = RunService.RenderStepped:Connect(function() -- Line: 208
                -- upvalues: u25 (ref), UserInputService (ref), u29 (copy), workspace_CurrentCamera (copy)
                if not u25 then
                    return;
                end;

                if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                    local v30 = (1 - u29 / 20) * 0.004;
                    local v31 = (math.random() - 0.5) * v30;
                    local v32 = (math.random() - 0.5) * v30;
                    workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.Angles(v31, v32, 0);
                end;
            end);
        end;
    elseif u25 then
        u25 = false;

        if u26 then
            u26:Disconnect();
            u26 = nil;
        end;
    end;
end;

if SurvivalSync then
    SurvivalSync.OnClientEvent:Connect(function(p33, p34) -- Line: 230
        -- upvalues: icon2 (copy), getStatusColor (copy), icon3 (copy), u3 (copy), updateHungerEffects (copy), updateThirstEffects (copy)
        icon2.ImageColor3 = getStatusColor(p33);
        icon2:SetAttribute("Value", (math.floor(p33)));
        icon3.ImageColor3 = getStatusColor(p34);
        icon3:SetAttribute("Value", (math.floor(p34)));
        local Food = u3.Food;
        local v35 = getStatusColor(p33);

        if Food then
            Food.fill.Size = UDim2.new(math.clamp(p33 / 100, 0, 1), 0, 1, 0);
            Food.fill.BackgroundColor3 = v35;
        end;

        local Thirst = u3.Thirst;
        local v36 = getStatusColor(p34);

        if Thirst then
            Thirst.fill.Size = UDim2.new(math.clamp(p34 / 100, 0, 1), 0, 1, 0);
            Thirst.fill.BackgroundColor3 = v36;
        end;

        updateHungerEffects(p33);
        updateThirstEffects(p34);
    end);
end;

local icon4 = u3.Radiation.icon;
local RadSync = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("RadSync", 10);

local function getRadColor(p37) -- Line: 248
    -- upvalues: getStatusColor (copy)
    return getStatusColor(100 - p37);
end;

if RadSync and icon4 then
    icon4.ImageTransparency = 0;
    RadSync.OnClientEvent:Connect(function(p38, p39) -- Line: 257
        -- upvalues: icon4 (copy), getStatusColor (copy), u3 (copy)
        local v40 = p38 / p39 * 100;
        icon4.ImageColor3 = getStatusColor(100 - v40);
        icon4:SetAttribute("Value", (math.floor(v40)));
        local Radiation = u3.Radiation;
        local v41 = getStatusColor(100 - v40);

        if not Radiation then
            return;
        end;

        Radiation.fill.Size = UDim2.new(math.clamp(v40 / 100, 0, 1), 0, 1, 0);
        Radiation.fill.BackgroundColor3 = v41;
    end);
end;

local Bleeding = u3.Bleeding;
local BleedingChip2 = StatusContainer:FindFirstChild("BleedingChip");
local BleedSync = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("BleedSync", 10);
local u42 = nil;

local function setBleedPulse(p43) -- Line: 271
    -- upvalues: u42 (ref), RunService (copy), Bleeding (copy)
    if not p43 or u42 then
        if not p43 and u42 then
            u42:Disconnect();
            u42 = nil;

            if Bleeding and Bleeding.icon then
                Bleeding.icon.ImageTransparency = 1;
            end;
        end;

        return;
    end;

    local os_clock_ret = os.clock();
    u42 = RunService.RenderStepped:Connect(function() -- Line: 274
        -- upvalues: Bleeding (ref), os_clock_ret (copy)
        if not (Bleeding and Bleeding.icon) then
            return;
        end;

        local v44 = (os.clock() - os_clock_ret) * 4;
        local math_sin_ret = math.sin(v44);
        local v45 = math.abs(math_sin_ret) * 0.45 + 0.55;
        Bleeding.icon.ImageTransparency = 1 - v45;
    end);
end;

if BleedSync and Bleeding then
    BleedSync.OnClientEvent:Connect(function(p46, p47) -- Line: 287
        -- upvalues: BleedingChip2 (copy), Bleeding (copy), u42 (ref), RunService (copy)
        local math_clamp_ret = math.clamp((p46 or 0) / (p47 or 1), 0, 1);

        if math_clamp_ret > 0 then
            if BleedingChip2 then
                BleedingChip2.Visible = true;
            end;

            Bleeding.icon.ImageColor3 = Color3.fromRGB(255, math.floor((1 - math_clamp_ret) * 110), (math.floor((1 - math_clamp_ret) * 110)));
            local v48 = Bleeding;
            local v49 = math_clamp_ret * 100;
            local Color3_fromRGB_ret = Color3.fromRGB(200, 40, 40);

            if v48 then
                v48.fill.Size = UDim2.new(math.clamp(v49 / 100, 0, 1), 0, 1, 0);
                v48.fill.BackgroundColor3 = Color3_fromRGB_ret;
            end;

            if not u42 then
                local os_clock_ret = os.clock();
                u42 = RunService.RenderStepped:Connect(function() -- Line: 274
                    -- upvalues: Bleeding (ref), os_clock_ret (copy)
                    if not (Bleeding and Bleeding.icon) then
                        return;
                    end;

                    local v50 = (os.clock() - os_clock_ret) * 4;
                    local math_sin_ret = math.sin(v50);
                    local v51 = math.abs(math_sin_ret) * 0.45 + 0.55;
                    Bleeding.icon.ImageTransparency = 1 - v51;
                end);
            end;
        else
            if u42 then
                u42:Disconnect();
                u42 = nil;

                if Bleeding and Bleeding.icon then
                    Bleeding.icon.ImageTransparency = 1;
                end;
            end;

            local v52 = Bleeding;
            local Color3_fromRGB_ret = Color3.fromRGB(200, 40, 40);

            if v52 then
                v52.fill.Size = UDim2.new(0, 0, 1, 0);
                v52.fill.BackgroundColor3 = Color3_fromRGB_ret;
            end;

            if BleedingChip2 then
                BleedingChip2.Visible = false;
            end;
        end;
    end);
end;