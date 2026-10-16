-- Decompiled with Potassium's decompiler.

local Debris = game:GetService("Debris");
local SPH_Assets = game:GetService("ReplicatedStorage").SPH_Assets;
local GameConfig = require(SPH_Assets.GameConfig);
local Ammo = SPH_Assets.Ammo;
local Shells = workspace:WaitForChild("SPH_Workspace"):FindFirstChild("Shells");
local u1 = {};

return {
    ejectShell = function(u2: userdata, p3: any, u4: any) -- Line: 12
        -- upvalues: Ammo (copy), GameConfig (copy), Debris (copy), u1 (copy), Shells (copy)
        local WeaponStats = require(p3.SPH_Weapon.WeaponStats);

        if not (p3 and (u4 and u4:FindFirstChild("Grip"))) then
            return;
        end;

        local Chamber = u4.Grip:FindFirstChild("Chamber");

        if not Chamber then
            warn(p3.Name .. " does not have a chamber! Add an attachment named \'Chamber\' to the gun\'s grip to resolve this issue.");

            return;
        end;

        local WorldCFrame = Chamber.WorldCFrame;
        local v5 = u2:DistanceFromCharacter(WorldCFrame.Position);
        local v6 = Ammo:FindFirstChild(WeaponStats.ammoType) or Ammo.Default;

        if v5 <= GameConfig.shellDistance then
            local u7 = v6.Casing:Clone();
            u7.Anchored = false;
            u7.CFrame = WorldCFrame;
            u7.Name = u2.Name .. "_Casing_" .. p3.Name;
            u7.CastShadow = false;
            u7.CollisionGroup = "Casings";
            u7.CollisionGroup = "Casings";
            u7.Transparency = 1;
            task.delay(0.01, function() -- Line: 31
                -- upvalues: u7 (copy)
                u7.Transparency = 0;
            end);
            local v8 = u7.ForcePoint or Instance.new("Attachment", u7);
            local VectorForce = Instance.new("VectorForce", u7);
            VectorForce.Visible = false;
            VectorForce.Force = WeaponStats.calcEjectionForce();
            VectorForce.Attachment0 = v8;
            Debris:AddItem(v8, 0.001);
            table.insert(u1, u7);

            if #u1 > GameConfig.shellMaxCount then
                table.remove(u1, 1);
            end;

            Debris:AddItem(u7, GameConfig.shellDespawn);
            u7.Parent = Shells;
            local u9 = nil;
            u9 = u7.Touched:Connect(function(p10) -- Line: 55
                -- upvalues: u7 (copy), u2 (copy), u4 (copy), Debris (ref), u9 (ref)
                if u7.AssemblyLinearVelocity.Magnitude > 20 and not (p10:IsDescendantOf(u2.Character) or (p10:IsDescendantOf(u4) or not p10.CanCollide)) then
                    local v11 = u7.Drop:Clone();
                    v11.Parent = u7;
                    v11.PlaybackSpeed = math.random(30, 50) / 40;
                    v11:Play();
                    v11.PlayOnRemove = true;
                    v11:Destroy();
                    Debris:AddItem(v11, 2);
                    u9:Disconnect();
                end;
            end);
        end;
    end
};