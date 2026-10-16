-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local v1 = {};
local CollectionService = game:GetService("CollectionService");
local Random_new_ret = Random.new();

local function RandomInt(p2, p3) -- Line: 9
    -- upvalues: Random_new_ret (copy)
    return Random_new_ret:NextInteger(p2, p3);
end;

local Modules = game:GetService("ReplicatedStorage").SPH_Assets.Modules;
local HitFX = require(Modules.HitFX);
local u4 = game:GetService("RunService"):IsServer();

local function effect(p5, p6, p7) -- Line: 23
    -- upvalues: u4 (copy), HitFX (copy)
    if u4 then
        return;
    end;

    HitFX.HitEffect(p5, p6, p7);
end;

local MaterialTypes = require(Modules.MaterialTypes);
local GameConfig = require(game:GetService("ReplicatedStorage").SPH_Assets.GameConfig);

local function IsInHumanoid(p8) -- Line: 31
    while p8.Parent do
        if p8.Parent:FindFirstChild("Humanoid") then
            return p8.Parent.Humanoid;
        end;

        p8 = p8.Parent;
    end;

    return false;
end;

local function RoundUp(p9) -- Line: 42
    return math.floor(p9 + 0.5);
end;

function v1.CanPierce(p10: any, p11, p12: any) -- Line: 46
    -- upvalues: IsInHumanoid (copy), Players (copy), CollectionService (copy), MaterialTypes (copy), Random_new_ret (copy), u4 (copy), HitFX (copy), GameConfig (copy)
    local v13 = false;
    local Instance = p11.Instance;
    local v14 = IsInHumanoid(Instance);
    local CosmeticBulletObject = p10.RayInfo.CosmeticBulletObject;
    local v15;

    if workspace:FindFirstChild("Vehicles") and Instance:IsDescendantOf(workspace.Vehicles) then
        v15 = Instance:GetAttribute("ArmorThickness") and true or false;
    elseif p10.UserData.IgnoreModel and Instance:IsDescendantOf(p10.UserData.IgnoreModel) then
        v15 = true;
    elseif v14 then
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(v14.Parent);
        v15 = PlayerFromCharacter and p10.UserData.Player == PlayerFromCharacter and true or ((Instance.Parent:IsA("Accoutrement") or Instance.Parent:IsA("Model") and Instance.Parent ~= v14.Parent) and true or v13);
    elseif CollectionService:HasTag(Instance, "SPH_Collide") then
        v15 = false;
    else
        v15 = (Instance.Transparency == 1 or not (Instance.CanCollide and (Instance.Name ~= "Ignore" and not CollectionService:HasTag(Instance, "SPH_NoCollide")))) and true or v13;
    end;

    if not v15 and p10.UserData.Tool then
        local v16 = nil;

        if typeof(p10.UserData.Tool) == "number" and p10.UserData.IgnoreModel.Base["FirePoint" .. p10.UserData.Tool]:FindFirstChild("BulletPhysics") then
            v16 = p10.UserData.IgnoreModel.Base["FirePoint" .. p10.UserData.Tool]:FindFirstChild("BulletPhysics");
        elseif p10.UserData.Tool:FindFirstChild("SPH_Weapon") and p10.UserData.Tool.SPH_Weapon:FindFirstChild("BulletPhysics") then
            v16 = p10.UserData.Tool.SPH_Weapon:FindFirstChild("BulletPhysics");
        end;

        if not v16 then
            return false;
        end;

        local v17 = require(v16).materialProperties[MaterialTypes(p11.Instance.Material)];
        local v18 = CosmeticBulletObject.CFrame.LookVector.Unit:Dot(p11.Normal.Unit);
        local math_acos_ret = math.acos(v18);
        local v19 = math.deg(math_acos_ret) - 180;
        local v20 = math.abs(v19) + 0.5;
        local math_floor_ret = math.floor(v20);
        local RicochetAngle = v17.RicochetAngle;
        local v21 = Random_new_ret:NextInteger(RicochetAngle[1] * 10, RicochetAngle[2] * 10) / 10 * (1 + p10:GetVelocity().Magnitude / 100000) + 0.5;

        if math.floor(v21) < math_floor_ret and (p12.Magnitude > v17.MinRicochetVelocity and not v14) then
            local Position = p11.Position;
            local Instance2 = p11.Instance;
            local Normal = p11.Normal;

            if not u4 then
                HitFX.HitEffect(Position, Instance2, Normal);
            end;

            local v22 = CosmeticBulletObject.CFrame.LookVector - 2 * CosmeticBulletObject.CFrame.LookVector:Dot(p11.Normal) * p11.Normal;
            local RicochetDeviation = v17.RicochetDeviation;
            local v23 = Random_new_ret:NextInteger(-RicochetDeviation, RicochetDeviation) / 5000;
            local v24 = Random_new_ret:NextInteger(-RicochetDeviation, RicochetDeviation) / 5000;
            local v25 = Random_new_ret:NextInteger(-RicochetDeviation, RicochetDeviation) / 5000;
            local Vector3_new_ret = Vector3.new(v23, v24, v25);
            local v26 = CFrame.fromOrientation(Vector3_new_ret.X, Vector3_new_ret.Y, Vector3_new_ret.Z) * v22;
            local VelocityMultiplier = v17.VelocityMultiplier;
            p10:SetPosition(p11.Position);
            p10:SetVelocity(Random_new_ret:NextInteger(VelocityMultiplier[1], VelocityMultiplier[2]) / 100 * p12.Magnitude * v26.Unit);

            return true;
        end;

        if GameConfig.bulletPen and not (v14 or Instance:HasTag("SPH_Collide")) then
            local PenetrationDepth = v17.PenetrationDepth;
            local v27 = math.random(PenetrationDepth[1] * 1000, PenetrationDepth[2] * 1000) / 1000;
            local Unit = p12.Unit;
            local v28 = p11.Position + Unit * v27;
            local RaycastParams_new_ret = RaycastParams.new();
            RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
            RaycastParams_new_ret.FilterDescendantsInstances = { Instance };
            local v29 = workspace:Raycast(v28, -Unit, RaycastParams_new_ret);

            if not v29 then
                return false;
            end;

            local Position = p11.Position;
            local Instance2 = p11.Instance;
            local Normal = p11.Normal;

            if not u4 then
                HitFX.HitEffect(Position, Instance2, Normal);
            end;

            local Position2 = v29.Position;
            local Instance3 = v29.Instance;
            local Normal2 = v29.Normal;

            if not u4 then
                HitFX.HitEffect(Position2, Instance3, Normal2);
            end;

            return true;
        end;
    end;

    return v15;
end;

return v1;