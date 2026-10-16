-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local CinematicCameraConfig = require(ReplicatedStorage:WaitForChild("CinematicCameraConfig"));
local LocalPlayer = Players.LocalPlayer;

local function hasAccess() -- Line: 23
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer:GetAttribute("CinematicAccess") == true;
end;

local CinematicModules = script.Parent:WaitForChild("CinematicModules");
local InputHandler = require(CinematicModules:WaitForChild("InputHandler"));
local CameraController = require(CinematicModules:WaitForChild("CameraController"));
local FocusTargeter = require(CinematicModules:WaitForChild("FocusTargeter"));
local HoverHighlight = require(CinematicModules:WaitForChild("HoverHighlight"));
local OverlayRenderer = require(CinematicModules:WaitForChild("OverlayRenderer"));
local LightingController = require(CinematicModules:WaitForChild("LightingController"));
local BillboardSuppressor = require(CinematicModules:WaitForChild("BillboardSuppressor"));
local CinematicRequestEnter = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CinematicRequestEnter");
local CinematicRequestExit = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CinematicRequestExit");
local u1 = {
    active = false,
    mode = "Smoothed",
    lockTarget = nil,
    hudHidden = false,
    mouseSensitivityMult = 1,
    cursorFree = false,
    handheldTime = 0,
    actions = {
        scroll = 0,
        boost = false,
        precise = false,
        focusPickThisFrame = false,
        breakFocusThisFrame = false,
        move = Vector3.new(),
        look = Vector2.new()
    },
    cameraCFrame = CFrame.new(),
    smoothedCFrame = CFrame.new(),
    fov = CinematicCameraConfig.Camera.DefaultFOV,
    speed = CinematicCameraConfig.Speed.Base,
    focus = {
        target = nil,
        distanceOffset = 0,
        locked = false,
        distance = CinematicCameraConfig.Focus.DefaultDistance
    },
    overlays = {
        thirds = true,
        letterbox = "off",
        focusRect = true,
        level = true,
        info = true,
        centerDot = true,
        lightingPanel = false,
        controlPanel = true,
        hoverHighlight = true
    },
    lighting = {
        exposure = 0,
        bloom = {
            on = false,
            intensity = 1,
            threshold = 2,
            size = 24
        },
        colorCorrection = {
            on = false,
            brightness = 0,
            contrast = 0,
            saturation = 0,
            tint = Color3.new(1, 1, 1)
        },
        dof = {
            on = false,
            focusDistance = CinematicCameraConfig.Focus.DefaultDistance,
            farIntensity = CinematicCameraConfig.DOF.FarIntensity,
            nearIntensity = CinematicCameraConfig.DOF.NearIntensity,
            inFocusRadius = CinematicCameraConfig.DOF.InFocusRadius
        },
        blur = {
            on = false,
            size = 24
        }
    }
};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = {
    CinematicHUD = true,
    CinematicToast = true
};

local function hideGameUI() -- Line: 103
    -- upvalues: u3 (ref), LocalPlayer (copy), u6 (copy), u4 (ref), u5 (ref)
    u3 = {};
    local v7 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if v7 then
        for _, child in ipairs(v7:GetChildren()) do
            if child:IsA("ScreenGui") and not u6[child.Name] then
                u3[child] = child.Enabled;
                child.Enabled = false;
            end;
        end;
    end;

    u4 = {};
    local StarterGui = game:GetService("StarterGui");

    for _, v in ipairs({
        Enum.CoreGuiType.Backpack,
        Enum.CoreGuiType.Chat,
        Enum.CoreGuiType.PlayerList,
        Enum.CoreGuiType.Health,
        Enum.CoreGuiType.EmotesMenu
    }) do
        local success, result = pcall(function() -- Line: 123
            -- upvalues: StarterGui (copy), v (copy)
            return StarterGui:GetCoreGuiEnabled(v);
        end);

        if success then
            u4[v] = result;
            pcall(function() -- Line: 126
                -- upvalues: StarterGui (copy), v (copy)
                StarterGui:SetCoreGuiEnabled(v, false);
            end);
        end;
    end;

    pcall(function() -- Line: 129
        -- upvalues: u5 (ref), StarterGui (copy)
        u5 = StarterGui:GetCore("TopbarEnabled");
        StarterGui:SetCore("TopbarEnabled", false);
    end);
end;

local function restoreGameUI() -- Line: 135
    -- upvalues: u3 (ref), u4 (ref), u5 (ref)
    if u3 then
        for i, v in pairs(u3) do
            if i.Parent then
                i.Enabled = v;
            end;
        end;

        u3 = nil;
    end;

    if u4 then
        local StarterGui = game:GetService("StarterGui");

        for i, v in pairs(u4) do
            pcall(function() -- Line: 145
                -- upvalues: StarterGui (copy), i (copy), v (copy)
                StarterGui:SetCoreGuiEnabled(i, v);
            end);
        end;

        u4 = nil;
    end;

    if u5 ~= nil then
        pcall(function() -- Line: 150
            -- upvalues: u5 (ref)
            game:GetService("StarterGui"):SetCore("TopbarEnabled", u5);
        end);
        u5 = nil;
    end;
end;

local function showToast(p8) -- Line: 155
    -- upvalues: LocalPlayer (copy)
    local v9 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if not v9 then
        return;
    end;

    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "CinematicToast";
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.DisplayOrder = 1500;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.Parent = v9;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.AnchorPoint = Vector2.new(0.5, 0);
    TextLabel.Position = UDim2.new(0.5, 0, 0, 60);
    TextLabel.Size = UDim2.fromOffset(360, 32);
    TextLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
    TextLabel.BackgroundTransparency = 0.15;
    TextLabel.BorderSizePixel = 0;
    TextLabel.Font = Enum.Font.Code;
    TextLabel.TextSize = 14;
    TextLabel.TextColor3 = Color3.fromRGB(255, 200, 90);
    TextLabel.Text = p8;
    TextLabel.Parent = ScreenGui;
    task.delay(3, function() -- Line: 172
        -- upvalues: ScreenGui (copy)
        ScreenGui:Destroy();
    end);
end;

local u10 = nil;

local function enter() -- Line: 179
    -- upvalues: u1 (copy), CinematicRequestEnter (copy), showToast (copy), hideGameUI (copy), BillboardSuppressor (copy), InputHandler (copy), CameraController (copy), FocusTargeter (copy), HoverHighlight (copy), LightingController (copy), OverlayRenderer (copy), u2 (ref), RunService (copy), u10 (ref)
    if u1.active then
        return;
    end;

    local success, result = pcall(function() -- Line: 181
        -- upvalues: CinematicRequestEnter (ref)
        return CinematicRequestEnter:InvokeServer();
    end);

    if not (success and (result and result.ok)) then
        local v11 = result and result.reason or "rpc_failed";
        warn("[CinematicCamera] enter denied: " .. v11);
        showToast("Cinematic denied: " .. v11);

        return;
    end;

    u1.active = true;
    hideGameUI();
    BillboardSuppressor:Enter(u1);
    InputHandler:Enter(u1);
    CameraController:Enter(u1);
    FocusTargeter:Enter(u1);
    HoverHighlight:Enter(u1);
    LightingController:Enter(u1);
    OverlayRenderer:Enter(u1);
    u2 = RunService.RenderStepped:Connect(function(p12) -- Line: 197
        -- upvalues: InputHandler (ref), u1 (ref), CameraController (ref), FocusTargeter (ref), HoverHighlight (ref), LightingController (ref), OverlayRenderer (ref), u10 (ref)
        InputHandler:Tick(u1, p12);
        CameraController:Tick(u1, p12);
        FocusTargeter:Tick(u1, p12);
        HoverHighlight:Tick(u1, p12);
        LightingController:Tick(u1, p12);
        OverlayRenderer:Tick(u1, p12);

        if u1.__exitRequested then
            u1.__exitRequested = false;
            task.defer(function() -- Line: 208
                -- upvalues: u1 (ref), u10 (ref)
                if u1.active then
                    u10();
                end;
            end);
        end;
    end);
    print("[CinematicCamera] ENTERED");
end;

u10 = function() -- Line: 214
    -- upvalues: u1 (copy), u2 (ref), OverlayRenderer (copy), LightingController (copy), HoverHighlight (copy), FocusTargeter (copy), CameraController (copy), InputHandler (copy), BillboardSuppressor (copy), restoreGameUI (copy), CinematicRequestExit (copy)
    if not u1.active then
        return;
    end;

    if u2 then
        u2:Disconnect();
        u2 = nil;
    end;

    OverlayRenderer:Exit();
    LightingController:Exit();
    HoverHighlight:Exit();
    FocusTargeter:Exit();
    CameraController:Exit();
    InputHandler:Exit();
    BillboardSuppressor:Exit();
    restoreGameUI();
    CinematicRequestExit:FireServer();
    u1.active = false;
    print("[CinematicCamera] EXITED");
end;

UserInputService.InputBegan:Connect(function(p13, p14) -- Line: 230
    -- upvalues: CinematicCameraConfig (copy), u1 (copy), u10 (ref), LocalPlayer (copy), enter (copy)
    if p13.KeyCode == CinematicCameraConfig.Keys.Toggle then
        if u1.active then
            u10();

            return;
        end;

        if LocalPlayer:GetAttribute("CinematicAccess") == true then
            enter();
        end;
    end;
end);
LocalPlayer:GetAttributeChangedSignal("CinematicAccess"):Connect(function() -- Line: 242
    -- upvalues: LocalPlayer (copy), u1 (copy), u10 (ref)
    if LocalPlayer:GetAttribute("CinematicAccess") ~= true and u1.active then
        u10();
    end;
end);
LocalPlayer.CharacterAdded:Connect(function() -- Line: 247
    -- upvalues: u1 (copy), u10 (ref)
    if u1.active then
        u10();
    end;
end);
print("[CinematicCameraClient] Ready (toggle: " .. CinematicCameraConfig.Keys.Toggle.Name .. ")");