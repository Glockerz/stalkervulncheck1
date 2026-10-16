-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = Players.LocalPlayer;
local script_Parent = script.Parent;
local Humanoid = script_Parent:WaitForChild("Humanoid");
local HumanoidRootPart = script_Parent:WaitForChild("HumanoidRootPart");
local Children = ReplicatedStorage:WaitForChild("RattleNoise"):GetChildren();
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"));

local function isBackpackModel(p1) -- Line: 14
    -- upvalues: ItemDatabase (copy)
    for _, v in pairs(ItemDatabase) do
        if type(v) == "table" and (v.ItemType == "Backpack" and v.Model == p1) then
            return true;
        end;
    end;

    return false;
end;

local u2 = {};

local function findWeldInModel(p3) -- Line: 30
    local HolsterWeld = p3:FindFirstChild("HolsterWeld");

    if HolsterWeld and HolsterWeld:IsA("Weld") then
        return HolsterWeld;
    end;

    local Middle = p3:FindFirstChild("Middle");

    if Middle then
        for _, child in Middle:GetChildren() do
            if child:IsA("Weld") then
                return child;
            end;
        end;
    end;

    return nil;
end;

local function isValidPhysicsModel(p4) -- Line: 44
    -- upvalues: isBackpackModel (copy), findWeldInModel (copy)
    if not p4:IsA("Model") then
        return false;
    end;

    if p4.Name:match("^Holster_") or isBackpackModel(p4.Name) then
        return findWeldInModel(p4) ~= nil;
    end;

    return false;
end;

local function addPhysicsObject(p5) -- Line: 53
    -- upvalues: isBackpackModel (copy), findWeldInModel (copy), u2 (ref)
    local v6;

    if p5:IsA("Model") and (p5.Name:match("^Holster_") or isBackpackModel(p5.Name)) then
        v6 = findWeldInModel(p5) ~= nil;
    else
        v6 = false;
    end;

    if v6 then
        local v7 = findWeldInModel(p5);
        local v8 = {
            springVelocityX = 0,
            springVelocityZ = 0,
            currentRotationX = 0,
            currentRotationZ = 0,
            wasInAir = false,
            lastVelocity = Vector3.new(0, 0, 0),
            Model = p5,
            Weld = v7,
            OriginalC1 = v7.C1,
            IsBackpack = isBackpackModel(p5.Name)
        };
        table.insert(u2, v8);
    end;
end;

local function removePhysicsObject(p9) -- Line: 72
    -- upvalues: u2 (ref)
    for i, v in pairs(u2) do
        if v.Model == p9 then
            if v.Weld and v.Weld.Parent then
                v.Weld.C1 = v.OriginalC1;
            end;

            table.remove(u2, i);

            return;
        end;
    end;
end;

local function initializePhysicsObjects() -- Line: 85
    -- upvalues: u2 (ref), script_Parent (copy), addPhysicsObject (copy)
    u2 = {};

    for _, child in pairs(script_Parent:GetChildren()) do
        addPhysicsObject(child);
    end;
end;

local u10 = false;
local u11 = false;
local BackpackFoley = ReplicatedStorage:FindFirstChild("BackpackFoley");
local u12 = BackpackFoley and BackpackFoley:GetChildren() or {};

local function playBackpackFoley() -- Line: 110
    -- upvalues: u11 (ref), u12 (copy), script_Parent (copy)
    if u11 or #u12 == 0 then
        return;
    end;

    local v13 = u12[math.random(#u12)];

    if not v13:IsA("Sound") or v13.SoundId == "" then
        return;
    end;

    u11 = true;
    local u14 = v13:Clone();
    u14.Parent = script_Parent.PrimaryPart;
    u14.PlaybackSpeed = 0.9 + math.random() * 0.2;
    u14.RollOffMaxDistance = 20;
    u14.RollOffMinDistance = 5;
    u14:Play();
    u14.Ended:Connect(function() -- Line: 121
        -- upvalues: u14 (copy)
        u14:Destroy();
    end);
    task.delay(0.8 + math.random() * 0.5, function() -- Line: 124
        -- upvalues: u11 (ref)
        u11 = false;
    end);
end;

local function playRattleSound() -- Line: 129
    -- upvalues: u10 (ref), Children (copy), script_Parent (copy)
    if not u10 and #Children > 0 then
        u10 = true;
        local u15 = Children[math.random(1, #Children)]:Clone();
        u15.Parent = script_Parent.PrimaryPart;
        u15:Play();
        u15.RollOffMaxDistance = 15;
        u15.RollOffMinDistance = 5;
        u15.Ended:Connect(function() -- Line: 137
            -- upvalues: u15 (copy), u10 (ref)
            u15:Destroy();
            u10 = false;
        end);
    end;
end;

local function updateSpring(p16, p17) -- Line: 148
    -- upvalues: Humanoid (copy), HumanoidRootPart (copy), playBackpackFoley (copy), playRattleSound (copy)
    local State = Humanoid:GetState();
    local v18 = State == Enum.HumanoidStateType.Jumping and true or State == Enum.HumanoidStateType.Freefall;
    local v19 = State == Enum.HumanoidStateType.Landed and true or State == Enum.HumanoidStateType.Running;
    local v20 = HumanoidRootPart.Velocity * Vector3.new(1, 0, 1);
    local Magnitude = v20.Magnitude;
    local v21 = p17.IsBackpack and 150 or 200;
    local v22 = p17.IsBackpack and 3 or 2;
    local v23 = p17.IsBackpack and 0.08726646259971647 or 0.12217304763960307;
    local v24, v25;

    if Magnitude > 0.1 then
        local v26 = HumanoidRootPart.CFrame:VectorToObjectSpace(v20);
        v24 = math.clamp(v26.X / 15, -1, 1) * v23;
        v25 = math.clamp(-v26.Z / 15, -1, 1) * v23;

        if p17.IsBackpack then
            if Magnitude > 5 and math.random() < 0.03 then
                playBackpackFoley();
            end;
        else
            playRattleSound();
        end;
    else
        v25 = 0;
        v24 = 0;
    end;

    if v18 and not p17.wasInAir then
        v25 = v25 - (p17.IsBackpack and 3.490658503988659 or 5.235987755982989);

        if not p17.IsBackpack then
            playRattleSound();
        end;
    elseif v19 and p17.wasInAir then
        v25 = v25 + (p17.IsBackpack and 4.363323129985824 or 6.981317007977318);

        if not p17.IsBackpack then
            playRattleSound();
        end;
    end;

    p17.wasInAir = v18;
    p17.springVelocityX = p17.springVelocityX + (v21 * (v24 - p17.currentRotationX) - p17.springVelocityX * v22) * p16;
    p17.currentRotationX = p17.currentRotationX + p17.springVelocityX * p16;
    p17.currentRotationX = math.clamp(p17.currentRotationX, -v23, v23);
    p17.springVelocityZ = p17.springVelocityZ + (v21 * (v25 - p17.currentRotationZ) - p17.springVelocityZ * v22) * p16;
    p17.currentRotationZ = p17.currentRotationZ + p17.springVelocityZ * p16;
    p17.currentRotationZ = math.clamp(p17.currentRotationZ, -v23, v23);
    local v27;

    if p17.IsBackpack then
        v27 = CFrame.Angles(p17.currentRotationZ, p17.currentRotationX, 0);
    else
        v27 = CFrame.Angles(0, p17.currentRotationX, p17.currentRotationZ);
    end;

    p17.Weld.C1 = CFrame.new(p17.OriginalC1.Position) * v27;
    p17.lastVelocity = v20;
end;

RunService.RenderStepped:Connect(function(p28) -- Line: 208
    -- upvalues: u2 (ref), updateSpring (copy)
    for _, v in pairs(u2) do
        if v.Weld and v.Weld.Parent then
            updateSpring(p28, v);
        end;
    end;
end);
initializePhysicsObjects();
(function() -- Line: 92, Name: connectPhysicsEvents
    -- upvalues: script_Parent (copy), isBackpackModel (copy), findWeldInModel (copy), addPhysicsObject (copy), removePhysicsObject (copy)
    script_Parent.ChildAdded:Connect(function(u29) -- Line: 93
        -- upvalues: isBackpackModel (ref), findWeldInModel (ref), addPhysicsObject (ref)
        task.defer(function() -- Line: 94
            -- upvalues: u29 (copy), isBackpackModel (ref), findWeldInModel (ref), addPhysicsObject (ref)
            local v30 = u29;
            local v31;

            if v30:IsA("Model") and (v30.Name:match("^Holster_") or isBackpackModel(v30.Name)) then
                v31 = findWeldInModel(v30) ~= nil;
            else
                v31 = false;
            end;

            if v31 then
                addPhysicsObject(u29);
            end;
        end);
    end);
    script_Parent.ChildRemoved:Connect(function(p32) -- Line: 100
        -- upvalues: removePhysicsObject (ref)
        removePhysicsObject(p32);
    end);
end)();