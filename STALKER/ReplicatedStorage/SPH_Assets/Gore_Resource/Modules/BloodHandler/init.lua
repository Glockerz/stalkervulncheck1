-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local Blood = ReplicatedStorage.Gore_Resource.Debris.Blood;
local Splatters = Blood.Splatters;
local script_Utilities = require(script.Utilities);
local Squirts = Blood.Squirts;
local script_UnitHitbox = require(script.UnitHitbox);
local v1 = {};

local function Rand(p2) -- Line: 13
    local Children = p2:GetChildren();

    return Children[math.random(1, #Children)];
end;

function v1.Spew(p3, p4) -- Line: 18
    -- upvalues: Splatters (copy), script_UnitHitbox (copy), Debris (copy)
    local RaycastParams_new_ret = RaycastParams.new();
    local u5 = Random.new():NextNumber(0.5, 4);
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.RespectCanCollide = true;
    RaycastParams_new_ret.IgnoreWater = true;
    RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Debris };
    local u6 = Splatters.Template.Blood:Clone();
    local Children = Splatters.Decals:GetChildren();
    local u7 = Children[math.random(1, #Children)]:Clone();
    local u8 = script_UnitHitbox.new(u6, 10, RaycastParams_new_ret);
    u8:HitStart();
    u6.Position = p4;
    u6.Velocity = p3;
    u6.Parent = workspace.Debris.Blood;
    u8.onHit:Connect(function(p9) -- Line: 35
        -- upvalues: u8 (copy), u7 (copy), u6 (copy), u5 (copy), Debris (ref)
        u8:HitStop();

        if p9.Instance.Parent:FindFirstChildOfClass("Humanoid") then
            return;
        end;

        u7.Parent = u6;
        u6.CFrame = CFrame.new(p9.Position, p9.Position - p9.Normal) * CFrame.Angles(1.5707963267948966, 0, 0);
        u6.Size = Vector3.new(u5, 0.05, u5);
        Debris:AddItem(u6, 30);
        u6.Anchored = true;
    end);
end;

function v1.spill(p10: userdata) -- Line: 51
    -- upvalues: Squirts (copy), script_UnitHitbox (copy), script_Utilities (copy), TweenService (copy), Debris (copy)
    for i = 1, 16 do
        local RaycastParams_new_ret = RaycastParams.new();
        local u11 = Random.new():NextNumber(0.1, 1.243);
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.RespectCanCollide = true;
        RaycastParams_new_ret.IgnoreWater = true;
        RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Debris };
        local u12 = Squirts.Template.Blood:Clone();
        local u13 = script_UnitHitbox.new(u12, 10, RaycastParams_new_ret);
        u13:HitStart();
        u12.Position = p10.WorldPosition;
        local v14 = p10.WorldCFrame.UpVector * script_Utilities.Random(5, 25);
        local v15 = script_Utilities.Random(-5, 5);
        local v16 = script_Utilities.Random(-5, 5);
        u12.Velocity = v14 + Vector3.new(v15, v16, script_Utilities.Random(-5, 5));
        u12.Parent = workspace.Debris.Blood;
        u13.onHit:Connect(function(p17) -- Line: 69
            -- upvalues: u12 (copy), u13 (copy), TweenService (ref), u11 (copy), Debris (ref)
            u12:FindFirstChildOfClass("Trail").Enabled = false;
            u13:HitStop();

            if p17.Instance.Parent:FindFirstChildOfClass("Humanoid") then
                return;
            end;

            u12.Transparency = 0.2;
            u12.CFrame = CFrame.new(p17.Position, p17.Position - p17.Normal) * CFrame.Angles(1.5707963267948966, 0, 0);
            TweenService:Create(u12, TweenInfo.new(0.2), {
                Size = Vector3.new(u11, 0.08, u11)
            }):Play();
            Debris:AddItem(u12, 30);
            u12.Anchored = true;
        end);
        local _ = i;
    end;

    wait(Random.new():NextNumber(0.01, 0.3));
end;

return v1;