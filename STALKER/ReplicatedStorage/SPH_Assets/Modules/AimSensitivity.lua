-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local GameConfig = require(ReplicatedStorage:WaitForChild("SPH_Assets"):WaitForChild("GameConfig"));
local u1 = {
    MIN = 0.05,
    MAX = 1,
    STEP = 1.1,
    SAVE_DEBOUNCE = 0.6,
    READOUT_SECONDS = 1.4,
    SAVED_ATTR = "SavedAimSensitivity",
    CAMERA_ATTR = "CameraSensScale",

    Default = function() -- Line: 53, Name: Default
        -- upvalues: GameConfig (copy)
        return tonumber(GameConfig.defaultAimSensitivity) or 0.4;
    end
};

function u1.Clamp(p2) -- Line: 57
    -- upvalues: u1 (copy)
    local v3 = tonumber(p2) or u1.Default();

    return math.clamp(v3, u1.MIN, u1.MAX);
end;

function u1.Get() -- Line: 62
    -- upvalues: Players (copy), u1 (copy)
    local LocalPlayer = Players.LocalPlayer;

    if LocalPlayer then
        LocalPlayer = tonumber(LocalPlayer:GetAttribute(u1.SAVED_ATTR));
    end;

    return u1.Clamp(LocalPlayer or u1.Default());
end;

function u1.SetCameraScale(p4) -- Line: 70
    -- upvalues: Players (copy), u1 (copy), UserInputService (copy)
    local LocalPlayer = Players.LocalPlayer;

    if LocalPlayer then
        if p4 == nil or p4 == 1 then
            LocalPlayer:SetAttribute(u1.CAMERA_ATTR, nil);
        else
            LocalPlayer:SetAttribute(u1.CAMERA_ATTR, p4);
        end;
    end;

    UserInputService.MouseDeltaSensitivity = 1;
end;

local u5 = nil;
local u6 = 0;

local function showReadout(p7) -- Line: 84
    -- upvalues: Players (copy), u5 (ref), u1 (copy), u6 (ref), TweenService (copy)
    local LocalPlayer = Players.LocalPlayer;

    if LocalPlayer then
        LocalPlayer = LocalPlayer:FindFirstChildOfClass("PlayerGui");
    end;

    if not LocalPlayer then
        return;
    end;

    if not (u5 and (u5.Parent and u5.Parent.Parent == LocalPlayer)) then
        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Name = "AimSensitivityReadout";
        ScreenGui.ResetOnSpawn = false;
        ScreenGui.IgnoreGuiInset = true;
        ScreenGui.DisplayOrder = 50;
        u5 = Instance.new("TextLabel");
        u5.AnchorPoint = Vector2.new(0.5, 0);
        u5.Position = UDim2.new(0.5, 0, 0.5, 42);
        u5.Size = UDim2.fromOffset(260, 24);
        u5.BackgroundTransparency = 1;
        u5.Font = Enum.Font.GothamMedium;
        u5.TextSize = 16;
        u5.TextColor3 = Color3.fromRGB(230, 230, 220);
        u5.TextStrokeTransparency = 0.5;
        u5.Parent = ScreenGui;
        ScreenGui.Parent = LocalPlayer;
    end;

    local string_format = string.format;
    local v8 = p7 / u1.Default() * 100 + 0.5;
    u5.Text = string_format("Aim sensitivity: %d%%", (math.floor(v8)));
    u5.TextTransparency = 0;
    u5.TextStrokeTransparency = 0.5;
    u6 = u6 + 1;
    local u9 = u6;
    task.delay(u1.READOUT_SECONDS, function() -- Line: 114
        -- upvalues: u9 (copy), u6 (ref), u5 (ref), TweenService (ref)
        if u9 ~= u6 or not u5 then
            return;
        end;

        TweenService:Create(u5, TweenInfo.new(0.4), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
    end);
end;

local u10 = 0;

local function queueSave(u11) -- Line: 123
    -- upvalues: u10 (ref), u1 (copy), ReplicatedStorage (copy)
    u10 = u10 + 1;
    local u12 = u10;
    task.delay(u1.SAVE_DEBOUNCE, function() -- Line: 126
        -- upvalues: u12 (copy), u10 (ref), ReplicatedStorage (ref), u11 (copy)
        if u12 ~= u10 then
            return;
        end;

        local Remotes = ReplicatedStorage:FindFirstChild("Remotes");

        if Remotes then
            Remotes = Remotes:FindFirstChild("SetAimSensitivity");
        end;

        if Remotes then
            Remotes:FireServer(u11);
        end;
    end);
end;

function u1.Step(p13, p14) -- Line: 137
    -- upvalues: u1 (copy), Players (copy), showReadout (copy), u10 (ref), ReplicatedStorage (copy)
    local v15 = tonumber(p14) or 0;
    local v16 = u1.Clamp((tonumber(p13) or u1.Get()) * u1.STEP ^ v15) * 1000 + 0.5;
    local u17 = math.floor(v16) / 1000;
    local LocalPlayer = Players.LocalPlayer;

    if LocalPlayer then
        LocalPlayer:SetAttribute(u1.SAVED_ATTR, u17);
    end;

    showReadout(u17);
    u10 = u10 + 1;
    local u18 = u10;
    task.delay(u1.SAVE_DEBOUNCE, function() -- Line: 126
        -- upvalues: u18 (copy), u10 (ref), ReplicatedStorage (ref), u17 (copy)
        if u18 ~= u10 then
            return;
        end;

        local Remotes = ReplicatedStorage:FindFirstChild("Remotes");

        if Remotes then
            Remotes = Remotes:FindFirstChild("SetAimSensitivity");
        end;

        if Remotes then
            Remotes:FireServer(u17);
        end;
    end);

    return u17;
end;

return u1;