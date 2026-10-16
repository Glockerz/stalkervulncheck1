-- Decompiled with Potassium's decompiler.

local v1 = {};
game:GetService("PhysicsService");
local Sounds = script.Parent.Parent:WaitForChild("Sounds");
local Gore_Resource = game:GetService("ReplicatedStorage"):WaitForChild("SPH_Assets").Gore_Resource;
local Gibs = Gore_Resource.Gibs;
local CollectionService = game:GetService("CollectionService");
local script_Utilities = require(script.Utilities);
local u2 = nil;
game:GetService("Debris");
local Debris = game:GetService("Debris");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local script_UnitHitbox = require(script.UnitHitbox);

function BloodSplat(p3, p4, p5)
    -- upvalues: ReplicatedStorage (copy), CollectionService (copy), Debris (copy)
    local BloodSplatterModules = ReplicatedStorage.SPH_Assets.Modules.HitFX.BloodSplatterModules;

    if math.random(0, 100) > 50 then
        p5 = -p5;
    end;

    local CFrame_new_ret = CFrame.new(p3, p3 + p5);
    local Attachment = Instance.new("Attachment");
    Attachment.CFrame = CFrame_new_ret;
    Attachment.Parent = game.Workspace.Terrain;
    local u6 = BloodSplatterModules.GibStuff.Drop3:Clone();
    u6.Parent = game.Workspace;
    u6.CFrame = Attachment.CFrame;
    local math_random_ret = math.random(-50, 50);
    local math_random_ret2 = math.random(-50, 50);
    local math_random_ret3 = math.random(-50, 50);
    u6.Orientation = Vector3.new(Attachment.Orientation.X + math_random_ret, Attachment.Orientation.Y + math_random_ret2, Attachment.Orientation.Z + math_random_ret3);
    local BodyThrust = Instance.new("BodyThrust");
    local v7 = math.random(-2, 2) * 0.5;
    local v8 = math.random(-2, 5) * 0.5;
    local v9 = math.random(-57, -5) * 0.5;
    BodyThrust.Force = Vector3.new(v7, v8, v9);
    BodyThrust.Parent = u6;
    task.delay(0.15, function() -- Line: 48
        -- upvalues: BodyThrust (copy)
        BodyThrust:Destroy();
    end);
    local GibStuff = BloodSplatterModules.GibStuff;
    local RaycastHitboxV3 = require(BloodSplatterModules.RaycastHitboxV3);
    local DecalSurface = require(BloodSplatterModules.DecalSurface);
    local u10 = RaycastHitboxV3:Initialize(u6, { workspace.ignore, u6.owner.Value, u6 });
    local u11 = { "splat", "blood", "Drop", "Drop2", "Puddle", "Handle", "Splatter", "Torso", "HumanoidRootPart", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "Head", "Collision", "Weight", "ColliderPart" };

    local function isBlacklisted(p12) -- Line: 60
        -- upvalues: u11 (copy)
        for _, v in pairs(u11) do
            if p12.Name == v then
                return true;
            end;
        end;

        return false;
    end;

    GibStuff.LightSplats:GetChildren();
    GibStuff.DenseSplatters:GetChildren();
    local u13 = false;
    local u14 = nil;
    delay(0.1, function() -- Line: 77
        -- upvalues: u13 (ref)
        u13 = true;
    end);
    u10:PartMode(true);
    u10.OnHit:Connect(function(p15, p16, p17) -- Line: 82
        -- upvalues: u11 (copy), CollectionService (ref), u13 (ref), u14 (ref), DecalSurface (copy), u10 (copy), u6 (copy)
        local Position = p17.Position;
        local Normal = p17.Normal;

        if p15 then
            local v18 = false;

            for _, v in pairs(u11) do
                if p15.Name == v then
                    v18 = true;
                    break;
                end;
            end;

            if v18 == false and (p15.Parent:IsA("Accessory") == false and (p15.Parent:IsA("Tool") == false and (p15.Parent:FindFirstChild("Humanoid") == nil and p15.CanCollide ~= false))) then
                if not (CollectionService:HasTag(p15, "Gibbed") or (CollectionService:HasTag(p15, "Gibs") or CollectionService:HasTag(p15, "Gore"))) then
                    if u13 == false then
                        u14 = "Big";
                        DecalSurface.MakeDecalOnSurface("Blood", Normal, p15, Position, u14);
                    elseif u13 == true then
                        u14 = "Small";
                        DecalSurface.MakeDecalOnSurface("Blood", Normal, p15, Position, u14);
                    end;
                end;

                u10:HitStop();
                u6:Destroy();
            end;
        end;
    end);
    u10:HitStart();

    for _, child in pairs(BloodSplatterModules.BloodEffect:GetChildren()) do
        if child.ClassName == "ParticleEmitter" then
            local u19 = child:Clone();
            u19.Parent = Attachment;
            local u20 = not u19:FindFirstChild("EmitCount") and 1 or u19.EmitCount.Value;
            task.delay(0.01, function() -- Line: 126
                -- upvalues: u19 (copy), u20 (ref), Debris (ref)
                u19:Emit(u20);
                Debris:AddItem(u19, u19.Lifetime.Max);
            end);
        end;
    end;

    Debris:AddItem(Attachment, 10);
end;

local function setPartToGroup(p21, p22) -- Line: 138
    -- upvalues: CollectionService (copy)
    if p21:IsA("BasePart") then
        CollectionService:AddTag(p21, "SPH_NoCollide");
    end;

    for _, descendant in ipairs(p21:GetDescendants()) do
        if descendant:IsA("BasePart") then
            CollectionService:AddTag(descendant, "SPH_NoCollide");
        end;
    end;
end;

local function RemoveItems(p23: userdata, p24: userdata) -- Line: 152
    -- upvalues: CollectionService (copy)
    if p23.Name ~= "Head" then
        warn("error: Not a Head.");

        return;
    end;

    for _, child in pairs(p24:GetChildren()) do
        if child:IsA("Accessory") then
            for _, child2 in pairs(child:GetChildren()) do
                if child2:IsA("BasePart") then
                    CollectionService:AddTag(child2, "Gibbed");
                    child2.Transparency = 1;
                end;
            end;
        else
            warn("Error: Not a Head Accessory or visible decal");
        end;
    end;

    for _, child in pairs(p23:GetChildren()) do
        if child:IsA("Decal") and child.Transparency == 0 then
            print(child);
            child.Transparency = 1;
            CollectionService:AddTag(child, "Gibbed");
        end;
    end;
end;

local function Shirt(p25: userdata, p26: userdata, p27: userdata) -- Line: 179
    p25.Transparency = 1;
    p27.skin.Color = p25.Color;

    if p26:FindFirstChildOfClass("Shirt") or p26:FindFirstChildOfClass("Pants") and p27.Name ~= "Head" then
        if string.find(p25.Name, "Leg") then
            p27.skin.Shirt.Texture = p26:FindFirstChildOfClass("Pants").PantsTemplate;

            return;
        end;

        if string.find(p25.Name, "Arm") or string.find(p25.Name, "Torso") then
            p27.skin.Shirt.Texture = p26:FindFirstChildOfClass("Shirt").ShirtTemplate;
        end;
    end;
end;

local function u41(p28: userdata, p29: number) -- Line: 196
    -- upvalues: Gore_Resource (copy), Gibs (copy), Shirt (copy), CollectionService (copy), setPartToGroup (copy), script_UnitHitbox (copy)
    local v30 = nil;
    local v31 = nil;

    if p28.Name == "Head" then
        v30 = Gore_Resource.Debris.Bits[p28.Name].Brainmatter;
    elseif string.find(p28.Name, "Leg") or string.find(p28.Name, "Arm") then
        v30 = Gore_Resource.Debris.Bits.Arm_Leg.Flesh;
        v31 = Gibs.Debris[p28.Name];
    end;

    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.RespectCanCollide = true;
    RaycastParams_new_ret.IgnoreWater = true;
    RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Debris };

    if v31 then
        local v32 = v31:Clone();
        v32.Parent = workspace.Debris.chunks;
        v32.CFrame = p28.CFrame;
        local BodyVelocity = Instance.new("BodyVelocity");
        local v33 = Random.new():NextNumber(-2, 5);
        local v34 = Random.new():NextNumber(2, 5);
        local Random_new_ret = Random.new();
        BodyVelocity.Velocity = Vector3.new(v33, v34, Random_new_ret:NextNumber(-2, 5));
        BodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000);
        BodyVelocity.Parent = v32;
        game:GetService("Debris"):AddItem(BodyVelocity, 0.01);
        Shirt(p28, p28.Parent, v32);
        CollectionService:AddTag(v32, "Gibs");
        setPartToGroup(v32, "Players");
        local v35 = workspace:Raycast(v32.Position, Vector3.new(0, -3, 0), RaycastParams_new_ret);

        if v35 then
            print("blood splat");
            BloodSplat(v35.Position, v35.Instance, v35.Normal);
        end;

        game:GetService("Debris"):AddItem(v32, 30);
    end;

    if v30 then
        for i = 1, p29 do
            local u36 = v30:Clone();
            u36.Parent = workspace.Debris.chunks;
            u36.CollisionGroup = "Guns";
            u36.CFrame = CFrame.new(p28.Position);
            local BodyVelocity = Instance.new("BodyVelocity");
            local v37 = Random.new():NextNumber(-2, 5);
            local v38 = Random.new():NextNumber(2, 5);
            local Random_new_ret = Random.new();
            BodyVelocity.Velocity = Vector3.new(v37, v38, Random_new_ret:NextNumber(-2, 5));
            BodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000);
            u36.CanCollide = true;
            u36.Anchored = false;
            local u39 = script_UnitHitbox.new(u36, 10, RaycastParams_new_ret);
            u39:HitStart();
            BodyVelocity.Parent = u36;
            game:GetService("Debris"):AddItem(BodyVelocity, 0.01);
            CollectionService:AddTag(u36, "NotHit");
            CollectionService:AddTag(u36, "Gibs");
            u39.onHit:Connect(function(p40) -- Line: 258
                -- upvalues: u39 (copy), CollectionService (ref), u36 (copy)
                u39:HitStop();

                if p40.Instance.Parent:FindFirstChildOfClass("Humanoid") and (CollectionService:HasTag(u36, "NotHit") and not CollectionService:HasTag(u36, "Hit")) then
                    game:GetService("Debris"):AddItem(u36, 0.3);

                    return;
                end;

                local CFrame_new_ret = CFrame.new(p40.Position);
                local CFrame_Angles = CFrame.Angles;
                local math_random_ret = math.random(-180, 180);
                local math_rad_ret = math.rad(math_random_ret);
                local math_random_ret2 = math.random(-180, 180);
                local math_rad_ret2 = math.rad(math_random_ret2);
                local math_random_ret3 = math.random(-180, 180);
                u36.CFrame = CFrame_new_ret * CFrame_Angles(math_rad_ret, math_rad_ret2, (math.rad(math_random_ret3)));
                CollectionService:AddTag(u36, "Hit");
                game:GetService("Debris"):AddItem(u36, 30);
                task.delay(6, function() -- Line: 267
                    -- upvalues: u36 (ref)
                    u36.Anchored = true;
                    u36.CanCollide = false;
                end);

                if math.random() < 0.5 then
                    BloodSplat(p40.Position, p40.Instance, p40.Normal);
                end;
            end);
            task.wait();
            local _ = i;
        end;
    end;
end;

function v1.gore(p42: userdata, p43: userdata, p44: any) -- Line: 285
    -- upvalues: CollectionService (copy), u2 (ref), Sounds (copy), script_Utilities (copy), Shirt (copy), RemoveItems (copy), Gore_Resource (copy), u41 (copy)
    if CollectionService:HasTag(p42, "Gibbed") and p42.Name == "HumanoidRootPart" then
        return;
    end;

    if not CollectionService:HasTag(p42, "Gibbed") then
        p42.Transparency = 1;
        p42.CanCollide = false;
        u2 = p44:Clone();
        u2.Transparency = 1;
        local v45 = Sounds:GetChildren()[math.random(1, #Sounds:GetChildren())]:Clone();
        v45.Parent = u2;
        v45:Play();
        CollectionService:AddTag(p42, "Gibbed");
        CollectionService:AddTag(u2, "Gore");
        u2.Parent = p42;
        u2.CFrame = p42.CFrame;
        script_Utilities.Weld(u2, p42, p43, p42.Name .. "Gibbed");
        Shirt(p42, p43, u2);
        RemoveItems(p42, p43);
        Gore_Resource.Debris.Bits.Head:GetChildren();
        u41(p42, 5);
    end;
end;

return v1;