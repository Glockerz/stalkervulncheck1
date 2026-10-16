-- Decompiled with Potassium's decompiler.

local WeldMod = require(script.Parent.WeldMod);
local SPH_Assets = game:GetService("ReplicatedStorage").SPH_Assets;
local Mods = require(SPH_Assets.Mods);
local Arms = SPH_Assets.Arms;

return {
    RigModel = function(p1, p2, p3) -- Line: 8
        -- upvalues: Arms (copy), Mods (copy), WeldMod (copy)
        local v4;

        if p2 then
            local v5 = p3.Parent:FindFirstChildWhichIsA("Humanoid");

            if v5 and (v5.RigType ~= Enum.HumanoidRigType.R15 and Arms:FindFirstChild("R6_Arms")) then
                v4 = Arms.R6_Arms.WeaponRig;
            else
                v4 = Arms.Default.WeaponRig;
            end;
        elseif p1.Neutral or not (p1.Team and Arms:FindFirstChild(p1.Team.Name)) then
            v4 = Arms.Default.WeaponRig;
        else
            v4 = Arms[p1.Team.Name].WeaponRig;
        end;

        local v6;

        if p2 or not Mods.viewmodelOverride then
            v6 = v4;
        else
            v6 = Mods.viewmodelOverride(p1, v4);

            if v6 then
                if not v6:FindFirstChild("AnimBase") then
                    v6 = v4;
                end;
            else
                v6 = v4;
            end;
        end;

        local v7 = v6:Clone();
        local AnimBase = v7.AnimBase;
        local v8 = v7["Left Arm"];

        for _, child in ipairs(v8:GetChildren()) do
            if child:IsA("BasePart") then
                WeldMod.Weld(v8, child);
                child.CanCollide = false;
                child.CanQuery = false;
            end;
        end;

        local v9 = v7["Right Arm"];

        for _, child in ipairs(v9:GetChildren()) do
            if child:IsA("BasePart") then
                WeldMod.Weld(v9, child);
                child.CanCollide = false;
                child.CanQuery = false;
            end;
        end;

        WeldMod.M6D(v7.AnimBase, v8).Name = "LeftJoint";
        WeldMod.M6D(v7.AnimBase, v9).Name = "RightJoint";
        AnimBase.Transparency = 1;
        AnimBase.CanCollide = false;
        AnimBase.CanQuery = false;
        AnimBase.CanTouch = false;
        AnimBase.CastShadow = false;
        v8.CanCollide = false;
        v8.CanQuery = false;
        v8.CanTouch = false;
        v8.CastShadow = true;
        v9.CanCollide = false;
        v9.CanQuery = false;
        v9.CanTouch = false;
        v9.CastShadow = true;

        if p3 then
            local v10 = WeldMod.BlankWeld(p3, v7.AnimBase);
            v10.Name = "BaseWeld";
            v10.Parent = v7;
        end;

        Instance.new("Folder", v7).Name = "Weapon";

        return v7;
    end
};