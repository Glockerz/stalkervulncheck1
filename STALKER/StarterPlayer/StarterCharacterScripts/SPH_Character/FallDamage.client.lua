-- Decompiled with Potassium's decompiler.

local SPH_Assets = game:GetService("ReplicatedStorage").SPH_Assets;
local GameConfig = require(SPH_Assets.GameConfig);
local u1 = false;

if GameConfig.fallDamage then
    local RunService = game:GetService("RunService");
    local Parent = script.Parent.Parent;
    local Humanoid = Parent:WaitForChild("Humanoid");
    local HumanoidRootPart = Parent:WaitForChild("HumanoidRootPart");
    local Y = HumanoidRootPart.Position.Y;
    local u2 = require(SPH_Assets.Modules.BridgeNet).CreateBridge("FallDamage");
    Humanoid.Died:Connect(function() -- Line: 15
        -- upvalues: u2 (copy), u1 (ref)
        u2:Destroy();
        u1 = true;
    end);
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.IgnoreWater = false;
    RaycastParams_new_ret.RespectCanCollide = false;
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { Parent };
    local u3 = 0;
    local u4 = false;
    RunService.RenderStepped:Connect(function() -- Line: 29
        -- upvalues: u1 (ref), Humanoid (copy), u3 (ref), HumanoidRootPart (copy), RaycastParams_new_ret (copy), u4 (ref), GameConfig (copy), u2 (copy), Y (ref)
        if u1 then
            return;
        end;

        if Humanoid.Sit then
            u3 = 0;
        end;

        local v5 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -3.1, 0), RaycastParams_new_ret);

        if v5 and (v5.Instance and not script:GetAttribute("Override")) then
            if u4 then
                u4 = false;

                if u3 > GameConfig.fallDamageDist and v5.Material ~= Enum.Material.Water then
                    u2:Fire((u3 - GameConfig.fallDamageDist) * GameConfig.fallDamageMultiplier);
                end;

                u3 = 0;
            end;
        else
            u4 = true;
        end;

        local Y2 = HumanoidRootPart.Position.Y;

        if Y2 < Y and u4 then
            u3 = u3 + (Y - Y2);
        else
            u3 = 0;
        end;

        Y = Y2;
    end);
    Humanoid.Climbing:Connect(function() -- Line: 62
        -- upvalues: u3 (ref)
        u3 = 0;
    end);
    Humanoid.Swimming:Connect(function() -- Line: 66
        -- upvalues: u3 (ref)
        u3 = 0;
    end);
end;