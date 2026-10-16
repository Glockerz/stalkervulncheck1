-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "AmmoDebugUI";
ScreenGui.ResetOnSpawn = false;
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
local TextLabel = Instance.new("TextLabel");
TextLabel.Name = "AmmoDebug";
TextLabel.Size = UDim2.new(0, 350, 0, 200);
TextLabel.Position = UDim2.new(1, -360, 0, 10);
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
TextLabel.BackgroundTransparency = 0.4;
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
TextLabel.Font = Enum.Font.RobotoMono;
TextLabel.TextSize = 12;
TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
TextLabel.TextYAlignment = Enum.TextYAlignment.Top;
TextLabel.TextWrapped = true;
TextLabel.Parent = ScreenGui;
local UICorner = Instance.new("UICorner");
UICorner.CornerRadius = UDim.new(0, 6);
UICorner.Parent = TextLabel;
local UIPadding = Instance.new("UIPadding");
UIPadding.PaddingLeft = UDim.new(0, 6);
UIPadding.PaddingTop = UDim.new(0, 4);
UIPadding.Parent = TextLabel;
RunService.Heartbeat:Connect(function() -- Line: 33
    -- upvalues: LocalPlayer (copy), TextLabel (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        TextLabel.Text = "No character";

        return;
    end;

    local v1 = nil;

    for _, child in ipairs(Character:GetChildren()) do
        if child:IsA("Tool") and child:FindFirstChild("SPH_Weapon") then
            v1 = child;
            break;
        end;
    end;

    if not v1 then
        for _, child in ipairs(LocalPlayer.Backpack:GetChildren()) do
            if child:IsA("Tool") and child:FindFirstChild("SPH_Weapon") then
                v1 = child;
                break;
            end;
        end;
    end;

    if not v1 then
        TextLabel.Text = "No weapon";

        return;
    end;

    local v2 = { "[" .. v1.Name .. "]" };
    local Ammo = v1:FindFirstChild("Ammo");

    if Ammo then
        Ammo = Ammo:FindFirstChild("MagAmmo");
    end;

    local v3 = Ammo and tostring(Ammo.Value) or "nil";
    table.insert(v2, "MagAmmo: " .. v3);
    local Chambered = v1:FindFirstChild("Chambered");
    local v4 = Chambered and tostring(Chambered.Value) or "nil";
    table.insert(v2, "Chambered: " .. v4);
    local v5 = v1:GetAttribute("MagUnloaded") or false;
    local v6 = "MagUnloaded: " .. tostring(v5);
    table.insert(v2, v6);
    local Attribute = v1:GetAttribute("LoadedRounds");

    if Attribute then
        local HttpService = game:GetService("HttpService");
        local success, result = pcall(function() -- Line: 76
            -- upvalues: HttpService (copy), Attribute (copy)
            return HttpService:JSONDecode(Attribute);
        end);

        if success and result then
            table.insert(v2, "LoadedRounds: " .. #result .. " total");
            local v7 = {};
            local v8 = {};

            for _, v in ipairs(result) do
                if not v7[v] then
                    v7[v] = 0;
                    table.insert(v8, v);
                end;

                v7[v] = v7[v] + 1;
            end;

            for _, v in ipairs(v8) do
                local v9 = v:match("_(.+)$") or v;
                table.insert(v2, "  " .. v7[v] .. "x " .. v9);
            end;

            table.insert(v2, "");
            table.insert(v2, "Next to fire:");

            for i = #result, math.max(1, #result - 2), -1 do
                local v10 = result[i]:match("_(.+)$") or result[i];
                table.insert(v2, "  > " .. v10);
                local _ = i;
            end;
        else
            table.insert(v2, "LoadedRounds: (parse error)");
        end;
    else
        table.insert(v2, "LoadedRounds: nil (legacy)");
    end;

    TextLabel.Text = table.concat(v2, "\n");
end);