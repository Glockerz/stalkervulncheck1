-- Decompiled with Potassium's decompiler.

local Debris = game:GetService("Debris");
game:GetService("Players");
local GameConfig = require(game:GetService("ReplicatedStorage").SPH_Assets.GameConfig);
local OverlapParams_new_ret = OverlapParams.new();
OverlapParams_new_ret.MaxParts = 500;
OverlapParams_new_ret.RespectCanCollide = true;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.IgnoreWater = true;
RaycastParams_new_ret.RespectCanCollide = true;
local u1 = { 287390459, 287390954, 287391087, 287391197, 287391361, 287391499, 287391567, 8226406520 };
local DamageHandler = require(game.ReplicatedStorage.SPH_Assets:WaitForChild("Gore_Resource").Modules.DamageHandler);

return function(p2: vector, u3: number, p4: string) -- Line: 22, Name: Explode
    -- upvalues: Debris (copy), u1 (copy), OverlapParams_new_ret (copy), RaycastParams_new_ret (copy), GameConfig (copy), DamageHandler (copy)
    local v5 = script:FindFirstChild(p4);

    if v5 then
        local Children = v5:GetChildren();
        local Attachment = Instance.new("Attachment", workspace.Terrain);
        Attachment.Name = "Explosion";
        Attachment.WorldPosition = p2;
        local v6 = 10;

        for _, v in ipairs(Children) do
            local v7 = v:Clone();
            v7.Parent = Attachment;

            if v7:IsA("ParticleEmitter") then
                if v7:FindFirstChild("Count") then
                    v7:Emit(v7.Count.Value);
                else
                    v7:Emit(1);
                end;

                if v6 < v7.Lifetime.Max then
                    v6 = v7.Lifetime.Max;
                end;
            elseif v7:IsA("Light") then
                v7.Enabled = true;
                Debris:AddItem(v7, 0.1);
            end;
        end;

        local Sound = Instance.new("Sound", Attachment);
        Sound.SoundId = "rbxassetid://" .. u1[math.random(#u1)];
        Sound.Volume = 4;
        Sound.RollOffMode = Enum.RollOffMode.InverseTapered;
        Sound.RollOffMaxDistance = 10000;
        Sound.PlayOnRemove = true;
        Sound:Destroy();
        local PartBoundsInRadius = workspace:GetPartBoundsInRadius(p2, u3 * 2, OverlapParams_new_ret);
        local v8 = {};

        for _, v in ipairs(PartBoundsInRadius) do
            local Humanoid = v.Parent:FindFirstChild("Humanoid");
            local HumanoidRootPart = v.Parent:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart and (Humanoid and not table.find(v8, Humanoid)) then
                local v9 = workspace:Raycast(p2 + Vector3.new(0, 1, 0), (HumanoidRootPart.Position - p2).Unit * u3, RaycastParams_new_ret);

                if not GameConfig.explosionRaycast or v9 and (v9.Instance and v9.Instance:IsDescendantOf(Humanoid.Parent)) then
                    table.insert(v8, Humanoid);
                    local Magnitude = (p2 - v.Position).Magnitude;
                    Humanoid:TakeDamage(u3 / 1.5 / Magnitude * 100);
                    local LimbHealth = Humanoid.Parent:FindFirstChild("LimbHealth");

                    if LimbHealth then
                        task.spawn(function() -- Line: 75
                            -- upvalues: u3 (copy), Magnitude (copy), LimbHealth (copy), DamageHandler (ref), Humanoid (copy)
                            local math_floor_ret = math.floor(u3 / 1.5 / Magnitude * 100);

                            for _, child in ipairs(LimbHealth:GetChildren()) do
                                local math_random_ret = math.random(0, math_floor_ret);
                                DamageHandler.ApplyDamage(Humanoid, Humanoid.Parent:FindFirstChild(child.Name), math_random_ret);
                            end;
                        end);
                    end;
                end;
            end;

            if not v.Anchored then
                local Attachment2 = Instance.new("Attachment", v);
                Attachment2.Name = "ExplosionForce";
                local VectorForce = Instance.new("VectorForce", Attachment2);
                VectorForce.Attachment0 = Attachment2;
                VectorForce.Force = (p2 - v.Position).Unit * -2000;
                Debris:AddItem(Attachment2, 0.1);
            end;
        end;

        Debris:AddItem(Attachment, v6);
    end;
end;