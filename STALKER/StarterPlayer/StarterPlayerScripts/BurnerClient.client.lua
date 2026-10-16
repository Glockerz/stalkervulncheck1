-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;

local function buildTintGui() -- Line: 20
    -- upvalues: LocalPlayer (copy)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    local BurnerScreenTint = PlayerGui:FindFirstChild("BurnerScreenTint");

    if BurnerScreenTint then
        return BurnerScreenTint, BurnerScreenTint.TintFrame;
    end;

    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "BurnerScreenTint";
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.DisplayOrder = 100;
    ScreenGui.Enabled = false;
    ScreenGui.Parent = PlayerGui;
    local Frame = Instance.new("Frame");
    Frame.Name = "TintFrame";
    Frame.Size = UDim2.new(1, 0, 1, 0);
    Frame.BackgroundColor3 = Color3.fromRGB(255, 80, 0);
    Frame.BackgroundTransparency = 0.6;
    Frame.BorderSizePixel = 0;
    Frame.Parent = ScreenGui;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.2),
        NumberSequenceKeypoint.new(0.45, 1),
        NumberSequenceKeypoint.new(0.55, 1),
        NumberSequenceKeypoint.new(1, 0.2)
    });
    UIGradient.Rotation = 90;
    UIGradient.Parent = Frame;

    return ScreenGui, Frame;
end;

local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;

local function applyBurning(p5) -- Line: 62
    -- upvalues: u1 (ref), u2 (ref), buildTintGui (copy), u4 (ref), u3 (ref), TweenService (copy)
    if not u1 then
        local v6, v7 = buildTintGui();
        u1 = v6;
        u2 = v7;
    end;

    if not p5 then
        if u3 then
            u3:Cancel();
            u3 = nil;
        end;

        if u1 then
            u4 = TweenService:Create(u2, TweenInfo.new(0.3), {
                BackgroundTransparency = 1
            });
            u4:Play();
            u4.Completed:Connect(function() -- Line: 87
                -- upvalues: u1 (ref)
                if u1 then
                    u1.Enabled = false;
                end;
            end);
        end;

        return;
    end;

    if u4 then
        u4:Cancel();
        u4 = nil;
    end;

    if u3 then
        u3:Cancel();
        u3 = nil;
    end;

    u1.Enabled = true;
    u2.BackgroundTransparency = 0.6;
    u3 = TweenService:Create(u2, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        BackgroundTransparency = 0.4
    });
    u3:Play();
end;

local function bindCharacter(u8) -- Line: 97
    -- upvalues: applyBurning (copy)
    applyBurning(u8:GetAttribute("Burning") == true);
    u8:GetAttributeChangedSignal("Burning"):Connect(function() -- Line: 102
        -- upvalues: applyBurning (ref), u8 (copy)
        applyBurning(u8:GetAttribute("Burning") == true);
    end);
end;

if LocalPlayer.Character then
    bindCharacter(LocalPlayer.Character);
end;

LocalPlayer.CharacterAdded:Connect(bindCharacter);
print("[BurnerClient] Initialized");