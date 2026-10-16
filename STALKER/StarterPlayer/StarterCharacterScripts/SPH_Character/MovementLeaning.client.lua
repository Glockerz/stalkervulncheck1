-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local GameConfig = require(game:GetService("ReplicatedStorage").SPH_Assets.GameConfig);
local RunService = game:GetService("RunService");
local CFrame_new_ret = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0);
local maxLeanAngle = GameConfig.maxLeanAngle;

if GameConfig.movementLeaning then
    local function UpdateCharacterTilt(p1, p2) -- Line: 12
        -- upvalues: CFrame_new_ret (copy), maxLeanAngle (copy)
        local Humanoid = p1:FindFirstChild("Humanoid");
        local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");
        local v3;

        if HumanoidRootPart then
            v3 = HumanoidRootPart:FindFirstChild("RootJoint");
        else
            v3 = HumanoidRootPart;
        end;

        if not (Humanoid and (Humanoid.Health > 0 and (HumanoidRootPart and v3))) then
            return;
        end;

        local v4 = HumanoidRootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection);
        local v5 = CFrame_new_ret:Inverse() * v3.C0;
        local CFrame_Angles_ret = CFrame.Angles(math.rad(-v4.Z) * maxLeanAngle, math.rad(-v4.X) * maxLeanAngle, 0);

        if Humanoid.Sit or (Humanoid.Health <= 0 or (script:GetAttribute("DisableLean") or p1:GetAttribute("SeatAnim"))) then
            CFrame_Angles_ret = CFrame.new();
        end;

        v3.C0 = CFrame_new_ret * v5:Lerp(CFrame_Angles_ret, 0.2 ^ (1 / (p2 * 60)));
    end;

    RunService.RenderStepped:Connect(function(p6) -- Line: 27
        -- upvalues: UpdateCharacterTilt (copy), Players (copy), GameConfig (copy)
        UpdateCharacterTilt(Players.LocalPlayer.Character, p6);

        if GameConfig.replicateMovementLeaning then
            for _, v in ipairs(Players:GetPlayers()) do
                if v ~= Players.LocalPlayer and v.Character then
                    UpdateCharacterTilt(v.Character, p6);
                end;
            end;
        end;
    end);
end;