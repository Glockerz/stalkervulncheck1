-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");

local function num(p1, p2, p3) -- Line: 10
    return tonumber(p1:GetAttribute(p2)) or p3;
end;

local LocalPlayer = game:GetService("Players").LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "FilmGrain";
ScreenGui.ResetOnSpawn = false;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.DisplayOrder = 99;
ScreenGui.Parent = PlayerGui;
local ImageLabel = Instance.new("ImageLabel");
ImageLabel.Size = UDim2.new(1, 0, 1, 0);
ImageLabel.BackgroundTransparency = 1;
ImageLabel.ImageTransparency = 1;
ImageLabel.ScaleType = Enum.ScaleType.Tile;
ImageLabel.TileSize = UDim2.new(1, 0, 1, 0);
ImageLabel.Image = "rbxassetid://95161230430908";
ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255);
ImageLabel.Parent = ScreenGui;
local u4 = 0;
local u5 = 100;
local RadSync = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("RadSync", 10);

if RadSync then
    RadSync.OnClientEvent:Connect(function(p6, p7) -- Line: 42
        -- upvalues: u4 (ref), u5 (ref)
        u4 = p6;
        u5 = p7 or 100;
    end);
end;

local function getProximityIntensity() -- Line: 49
    -- upvalues: LocalPlayer (copy), CollectionService (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return 0;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return 0;
    end;

    local Tagged = CollectionService:GetTagged("RadZone");
    local v8 = 0;

    for _, v in ipairs(Tagged) do
        if v:IsA("BasePart") then
            local v9 = tonumber(v:GetAttribute("RadLevel")) or 1;
            local _ = (HumanoidRootPart.Position - v.Position).Magnitude;
            local v10 = tonumber(v:GetAttribute("RadProximityRange")) or 80;
            local v11 = v.CFrame:PointToObjectSpace(HumanoidRootPart.Position);
            local v12 = v.Size * 0.5;
            local math_clamp_ret = math.clamp(v11.X, -v12.X, v12.X);
            local math_clamp_ret2 = math.clamp(v11.Y, -v12.Y, v12.Y);
            local math_clamp_ret3 = math.clamp(v11.Z, -v12.Z, v12.Z);
            local Magnitude = (v11 - Vector3.new(math_clamp_ret, math_clamp_ret2, math_clamp_ret3)).Magnitude;
            local v13 = 0;

            if Magnitude <= 0 then
                v13 = v9 / 10;
            elseif Magnitude < v10 then
                v13 = v9 / 10 * (1 - Magnitude / v10);
            end;

            if v8 < v13 then
                v8 = v13;
            end;
        end;
    end;

    local Tagged2 = CollectionService:GetTagged("RadSource");

    for _, v in ipairs(Tagged2) do
        if v:IsA("BasePart") then
            local v14 = tonumber(v:GetAttribute("RadIntensity")) or 5;
            local v15 = tonumber(v:GetAttribute("RadRadius")) or 30;

            if v15 > 0 then
                local Magnitude = (v.Position - HumanoidRootPart.Position).Magnitude;

                if Magnitude < v15 then
                    local v16 = v14 / 10;
                    local v17 = v16 * math.sqrt(1 - Magnitude / v15);
                    local math_max_ret = math.max(v16 * 0.15, v17);

                    if v8 < math_max_ret then
                        v8 = math_max_ret;
                    end;
                end;
            end;
        end;
    end;

    return math.clamp(v8, 0, 1);
end;

local math_random = math.random;
local u18 = 0;
RunService.Heartbeat:Connect(function() -- Line: 120
    -- upvalues: getProximityIntensity (copy), u4 (ref), u5 (ref), ImageLabel (copy), u18 (ref), math_random (copy)
    local v19 = getProximityIntensity();
    local math_max_ret = math.max(v19, u4 / u5);
    local v20;

    if math_max_ret <= 0.02 then
        v20 = 1;
    elseif math_max_ret <= 0.4 then
        v20 = 0.95 - (math_max_ret - 0.02) / 0.38 * 0.07;
    elseif math_max_ret <= 0.7 then
        v20 = 0.88 - (math_max_ret - 0.4) / 0.3 * 0.08;
    else
        v20 = 0.8 - math.clamp((math_max_ret - 0.7) / 0.3, 0, 1) * 0.1;
    end;

    ImageLabel.ImageTransparency = v20;

    if tick() - u18 >= 0.025 then
        u18 = tick();
        local v21 = math_random(950, 1050) / 1000;
        local v22 = math_random(950, 1050) / 1000;
        ImageLabel.TileSize = UDim2.new(v21, 0, v22, 0);
        ImageLabel.Position = UDim2.new(0, math_random(-3, 3), 0, math_random(-3, 3));
    end;
end);