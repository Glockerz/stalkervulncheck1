-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TerrainWater = require(ReplicatedStorage:WaitForChild("TerrainWater"));
local script_Parent = script.Parent;
local Humanoid = script_Parent:WaitForChild("Humanoid");
local HumanoidRootPart = script_Parent:WaitForChild("HumanoidRootPart");
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false);
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "BreathBar";
ScreenGui.ResetOnSpawn = true;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.Enabled = false;
local Frame = Instance.new("Frame");
Frame.AnchorPoint = Vector2.new(0.5, 1);
Frame.Position = UDim2.new(0.5, 0, 1, -120);
Frame.Size = UDim2.fromOffset(220, 22);
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20);
Frame.BackgroundTransparency = 0.35;
Frame.BorderSizePixel = 0;
Frame.Parent = ScreenGui;
local UIStroke = Instance.new("UIStroke");
UIStroke.Color = Color3.fromRGB(60, 60, 60);
UIStroke.Thickness = 1;
UIStroke.Parent = Frame;
local Frame2 = Instance.new("Frame");
Frame2.Name = "Fill";
Frame2.Size = UDim2.fromScale(1, 1);
Frame2.BackgroundColor3 = Color3.fromRGB(110, 170, 210);
Frame2.BorderSizePixel = 0;
Frame2.Parent = Frame;
local TextLabel = Instance.new("TextLabel");
TextLabel.Size = UDim2.fromScale(1, 1);
TextLabel.BackgroundTransparency = 1;
TextLabel.Text = "BREATH";
TextLabel.TextColor3 = Color3.fromRGB(235, 235, 235);
TextLabel.TextSize = 14;
TextLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
TextLabel.ZIndex = 2;
TextLabel.Parent = Frame;
ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui");

local function paintBreath() -- Line: 79
    -- upvalues: script_Parent (copy), ScreenGui (copy), Frame2 (copy)
    local Attribute = script_Parent:GetAttribute("Breath");

    if type(Attribute) ~= "number" then
        ScreenGui.Enabled = false;

        return;
    end;

    ScreenGui.Enabled = true;
    Frame2.Size = UDim2.fromScale(math.clamp(Attribute, 0, 1), 1);
    Frame2.BackgroundColor3 = Attribute <= 0 and Color3.fromRGB(190, 60, 55) or Color3.fromRGB(110, 170, 210);
end;

script_Parent:GetAttributeChangedSignal("Breath"):Connect(paintBreath);
paintBreath();
Humanoid.Died:Connect(function() -- Line: 93
    -- upvalues: ScreenGui (copy)
    ScreenGui:Destroy();
end);
task.spawn(function() -- Line: 98
    -- upvalues: script_Parent (copy), Humanoid (copy), TerrainWater (copy), HumanoidRootPart (copy)
    while script_Parent.Parent and Humanoid.Health > 0 do
        local v1 = TerrainWater.Submerged(HumanoidRootPart.Position - Vector3.new(0, 2.5, 0));

        if script_Parent:GetAttribute("InWater") == true ~= v1 then
            script_Parent:SetAttribute("InWater", v1 or nil);
        end;

        task.wait(0.2);
    end;
end);