-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local GasMaskVoiceConfig = require(ReplicatedStorage:WaitForChild("GasMaskVoiceConfig"));
local GasMaskPlane = ReplicatedStorage:FindFirstChild("GasMaskPlane");

local function resolvePlane() -- Line: 41
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), GasMaskPlane (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:GetAttribute("VisorPlane");
    end;

    if type(Character) == "string" and Character ~= "" then
        local v1 = ReplicatedStorage:FindFirstChild(Character);

        if v1 and v1:IsA("BasePart") then
            return v1, Character;
        end;

        warn(("[GasMaskVisor] VisorPlane=\'%s\' is missing or not a BasePart; falling back to GasMaskPlane"):format(Character));
    end;

    return GasMaskPlane, nil;
end;

local u2 = nil;
local u3 = ReplicatedStorage:FindFirstChild("GasMaskDamage") or ReplicatedStorage;
local u4 = nil;
local u5 = nil;
local u6 = {};

local function isFirstPerson(p7) -- Line: 97
    -- upvalues: LocalPlayer (copy)
    local v8 = p7 or workspace.CurrentCamera;
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("Head");
    end;

    if v8 and Character then
        return (v8.CFrame.Position - Character.Position).Magnitude <= 1.5;
    end;

    return false;
end;

local function setVisorOnScreen(p9: boolean) -- Line: 110
    -- upvalues: LocalPlayer (copy)
    if LocalPlayer:GetAttribute("VisorOnScreen") ~= p9 then
        LocalPlayer:SetAttribute("VisorOnScreen", p9);
    end;
end;

if LocalPlayer:GetAttribute("VisorOnScreen") ~= false then
    LocalPlayer:SetAttribute("VisorOnScreen", false);
end;

local function isWearingVisorMask() -- Line: 120
    -- upvalues: GasMaskVoiceConfig (copy), LocalPlayer (copy)
    return GasMaskVoiceConfig.isWearingVisorMask(LocalPlayer.Character);
end;

local function shouldShowVisor() -- Line: 128
    -- upvalues: LocalPlayer (copy), isWearingVisorMask (copy)
    local Character = LocalPlayer.Character;

    return Character and Character:GetAttribute("AltynVisorDown") == true and true or isWearingVisorMask();
end;

local function showVisor() -- Line: 136
    -- upvalues: u4 (ref), resolvePlane (copy), u2 (ref), LocalPlayer (copy), u3 (copy), u5 (ref), RunService (copy), Lighting (copy), u6 (copy)
    if u4 then
        return;
    end;

    local u10, v11 = resolvePlane();

    if not u10 then
        return;
    end;

    u2 = v11;
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "GasMaskVisorGui";
    ScreenGui.DisplayOrder = -10;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.Parent = LocalPlayer.PlayerGui;
    local ViewportFrame = Instance.new("ViewportFrame");
    ViewportFrame.Name = "VisorViewport";
    ViewportFrame.Size = UDim2.fromScale(1, 1);
    ViewportFrame.Position = UDim2.fromScale(0, 0);
    ViewportFrame.BackgroundTransparency = 1;
    ViewportFrame.ImageTransparency = 0;
    ViewportFrame.LightDirection = Vector3.new(-1, -1, -1);
    ViewportFrame.LightColor = Color3.new(1, 1, 1);
    ViewportFrame.Ambient = Color3.new(0.5, 0.5, 0.5);
    ViewportFrame.Parent = ScreenGui;
    local Camera = Instance.new("Camera");
    Camera.FieldOfView = 70;
    Camera.Parent = ViewportFrame;
    ViewportFrame.CurrentCamera = Camera;
    local WorldModel = Instance.new("WorldModel");
    WorldModel.Parent = ViewportFrame;
    local u12 = u10:Clone();
    u12.Name = "VisorMesh";
    u12.Anchored = true;
    u12.CanCollide = false;
    u12.CanQuery = false;
    u12.CanTouch = false;
    u12.CastShadow = false;
    u12.Parent = WorldModel;
    local u13 = nil;
    local u14 = -1;

    local function setDamageLevel(p15) -- Line: 192
        -- upvalues: u3 (ref), u14 (ref), u13 (ref), WorldModel (copy)
        if not u3 then
            return;
        end;

        local v16 = tonumber(p15) or 0;
        local math_clamp_ret = math.clamp(v16, 0, 10);

        if math_clamp_ret == u14 then
            return;
        end;

        local v17 = u3:FindFirstChild("Damage" .. math_clamp_ret);

        if not (v17 and v17:IsA("BasePart")) then
            if u13 then
                u13:Destroy();
            end;

            u13 = nil;
            u14 = math_clamp_ret;

            return;
        end;

        if u13 then
            u13:Destroy();
        end;

        u13 = v17:Clone();
        u13.Name = "DamageMesh";
        u13.Anchored = true;
        u13.CanCollide = false;
        u13.CanQuery = false;
        u13.CanTouch = false;
        u13.CastShadow = false;
        u13.Parent = WorldModel;
        u14 = math_clamp_ret;
    end;

    local Character = LocalPlayer.Character;
    setDamageLevel(Character and (Character:GetAttribute("MaskCrackLevel") or 0) or 0);
    u4 = ScreenGui;
    u5 = RunService.RenderStepped:Connect(function() -- Line: 264
        -- upvalues: LocalPlayer (ref), ViewportFrame (copy), Camera (copy), u12 (copy), u10 (copy), u13 (ref), Lighting (ref)
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if not workspace_CurrentCamera then
            return;
        end;

        local v18 = workspace_CurrentCamera or workspace.CurrentCamera;
        local Character2 = LocalPlayer.Character;

        if Character2 then
            Character2 = Character2:FindFirstChild("Head");
        end;

        local v19;

        if v18 and Character2 then
            v19 = (v18.CFrame.Position - Character2.Position).Magnitude <= 1.5;
        else
            v19 = false;
        end;

        if not v19 then
            ViewportFrame.Visible = false;

            if LocalPlayer:GetAttribute("VisorOnScreen") ~= false then
                LocalPlayer:SetAttribute("VisorOnScreen", false);
            end;

            return;
        end;

        ViewportFrame.Visible = true;

        if LocalPlayer:GetAttribute("VisorOnScreen") ~= true then
            LocalPlayer:SetAttribute("VisorOnScreen", true);
        end;

        Camera.FieldOfView = workspace_CurrentCamera.FieldOfView;
        Camera.CFrame = workspace_CurrentCamera.CFrame;
        local math_rad_ret = math.rad(workspace_CurrentCamera.FieldOfView);
        local ViewportSize = workspace_CurrentCamera.ViewportSize;
        local v20 = ViewportSize.X / ViewportSize.Y;
        local v21 = math.tan(math_rad_ret / 2) * 1.4 * 1.1;
        u12.Size = Vector3.new(v21 * v20, u10.Size.Y * 0.01, v21);
        u12.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(0, 0, -0.7) * CFrame.Angles(1.5707963267948966, 0, 0);

        if u13 then
            u13.Size = u12.Size;
            u13.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(0, 0, -0.6799999999999999) * CFrame.Angles(1.5707963267948966, 0, 0);
        end;

        local math_sin_ret = math.sin(Lighting.ClockTime / 24 * 3.141592653589793);
        local math_clamp_ret = math.clamp(math_sin_ret, 0.1, 1);
        ViewportFrame.Ambient = Color3.new(math_clamp_ret * 0.5, math_clamp_ret * 0.5, math_clamp_ret * 0.5);
    end);

    if Character then
        local AttributeChangedSignal = Character:GetAttributeChangedSignal("MaskCrackLevel");
        table.insert(u6, AttributeChangedSignal:Connect(function() -- Line: 314
            -- upvalues: setDamageLevel (copy), Character (copy)
            setDamageLevel(Character:GetAttribute("MaskCrackLevel") or 0);
        end));
    end;
end;

local function hideVisor() -- Line: 320
    -- upvalues: LocalPlayer (copy), u5 (ref), u6 (copy), u4 (ref), u2 (ref)
    if LocalPlayer:GetAttribute("VisorOnScreen") ~= false then
        LocalPlayer:SetAttribute("VisorOnScreen", false);
    end;

    if u5 then
        u5:Disconnect();
        u5 = nil;
    end;

    for _, v in ipairs(u6) do
        v:Disconnect();
    end;

    table.clear(u6);

    if u4 then
        u4:Destroy();
        u4 = nil;
    end;

    u2 = nil;
end;

local u22 = false;

local function blinkApply(p23) -- Line: 350
    -- upvalues: u22 (ref), LocalPlayer (copy), TweenService (copy), showVisor (copy), hideVisor (copy)
    u22 = true;
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "GasMaskBlink";
    ScreenGui.DisplayOrder = 200;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.Parent = LocalPlayer.PlayerGui;
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.Parent = ScreenGui;
    local v24 = TweenService:Create(Frame, TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0
    });
    v24:Play();
    v24.Completed:Wait();

    if p23 then
        showVisor();
    else
        hideVisor();
    end;

    task.wait(0.1);
    local v25 = TweenService:Create(Frame, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        BackgroundTransparency = 1
    });
    v25:Play();
    v25.Completed:Wait();
    ScreenGui:Destroy();
    u22 = false;
end;

task.spawn(function() -- Line: 387
    -- upvalues: u22 (ref), LocalPlayer (copy), GasMaskVoiceConfig (copy), u4 (ref), blinkApply (copy), resolvePlane (copy), u2 (ref), hideVisor (copy), showVisor (copy)
    while true do
        if not u22 then
            local Character = LocalPlayer.Character;
            local v26 = Character and Character:GetAttribute("AltynVisorDown") == true and true or GasMaskVoiceConfig.isWearingVisorMask(LocalPlayer.Character);

            if v26 and not u4 then
                blinkApply(true);
            elseif v26 or not u4 then
                if v26 and u4 then
                    local _, v27 = resolvePlane();

                    if v27 ~= u2 then
                        hideVisor();
                        showVisor();
                    end;
                end;
            else
                blinkApply(false);
            end;
        end;

        task.wait(0.5);
    end;
end);
LocalPlayer.CharacterAdded:Connect(function() -- Line: 413
    -- upvalues: hideVisor (copy)
    hideVisor();
end);
print("[GasMaskVisor] ViewportFrame mode initialized");