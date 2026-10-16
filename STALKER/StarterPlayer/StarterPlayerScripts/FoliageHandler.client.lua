-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Random_new_ret = Random.new();
local u1 = require(script:WaitForChild("Octree")).new();
local Spring = require(script:WaitForChild("Spring"));
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local os_clock_ret = os.clock();
local u2 = ReplicatedStorage:GetAttribute("InfluenceMin") or -0.125;
local u3 = ReplicatedStorage:GetAttribute("InfluenceMax") or 0.125;
local u4 = ReplicatedStorage:GetAttribute("Power") or 0.65;
local u5 = ReplicatedStorage:GetAttribute("Speed") or 17.5;
local u6 = ReplicatedStorage:GetAttribute("Direction") or Vector3.new(0.65, 0, 0.65);
local u7 = true;
local Sounds = script:WaitForChild("Sounds");
local u8 = {};

local function isPointInPart(p9: vector, p10: userdata) -- Line: 82
    local v11 = p10.CFrame:PointToObjectSpace(p9);
    local v12;

    if math.abs(v11.X) < p10.Size.X * 0.5 and math.abs(v11.Y) < p10.Size.Y * 0.5 then
        v12 = math.abs(v11.Z) < p10.Size.Z * 0.5;
    else
        v12 = false;
    end;

    return v12;
end;

local function playRandomSound(p13: any, p14: userdata) -- Line: 88
    -- upvalues: Random_new_ret (copy)
    local v15 = p13[Random_new_ret:NextInteger(1, #p13:GetChildren())];

    if v15 and v15:IsA("Sound") then
        local v16 = v15:Clone();
        v16.PlayOnRemove = true;
        v16.Parent = p14;
        v16:Destroy();
    end;
end;

local function addFoliageObject(u17: userdata) -- Line: 100
    -- upvalues: u8 (copy), Spring (copy), Players (copy), u7 (ref), LocalPlayer (copy), isPointInPart (copy), u1 (copy), Random_new_ret (copy)
    if typeof(u17) ~= "Instance" then
        warn("FoliageHandler - Object passed was not an instance!");

        return;
    end;

    if u17:IsA("Model") and u17.PrimaryPart then
        u17 = u17.PrimaryPart;
    elseif not u17:IsA("BasePart") then
        warn("FoliageHandler - Specified object does not exist!");

        return;
    end;

    if u8[u17] then
        return;
    end;

    local v18 = Spring.new(Vector3.new(0, 0, 0));
    v18.s = 17.5;
    v18.d = 0.25;
    v18.t = Vector3.new();
    local v21 = u17.Touched:Connect(function(p19: userdata) -- Line: 126
        -- upvalues: u8 (ref), u17 (ref), Players (ref), u7 (ref), LocalPlayer (ref)
        if not u8[u17] then
            return;
        end;

        local v20 = u8[u17];
        local Parent = p19.Parent;

        if Parent and (Parent:IsA("Model") and Players:GetPlayerFromCharacter(Parent)) then
            if not Parent.PrimaryPart or p19 ~= Parent.PrimaryPart then
                return;
            end;

            local PlayerFromCharacter = Players:GetPlayerFromCharacter(Parent);

            if not u7 and PlayerFromCharacter ~= LocalPlayer then
                return;
            end;

            v20.Touching[PlayerFromCharacter] = true;
        end;
    end);
    local v24 = u17.TouchEnded:Connect(function(p22: userdata) -- Line: 148
        -- upvalues: u8 (ref), u17 (ref), Players (ref), isPointInPart (ref), u7 (ref), LocalPlayer (ref)
        if not u8[u17] then
            return;
        end;

        local v23 = u8[u17];
        local Parent = p22.Parent;

        if Parent and (Parent:IsA("Model") and Players:GetPlayerFromCharacter(Parent)) then
            if not (Parent.PrimaryPart and (p22 == Parent.PrimaryPart and not isPointInPart(u17.Position, p22))) then
                return;
            end;

            local PlayerFromCharacter = Players:GetPlayerFromCharacter(Parent);

            if not u7 and PlayerFromCharacter ~= LocalPlayer then
                return;
            end;

            v23.Touching[PlayerFromCharacter] = nil;
        end;
    end);
    u8[u17] = {
        LastComputeTime = 0,
        SoundCooldown = false,
        OctreeNode = u1:CreateNode(u17.Position, u17),
        OriginCFrame = u17.CFrame,
        CFrame = u17.CFrame,
        Goal = CFrame.new(),
        Seed = Random_new_ret:NextNumber(0, 10000) * 0.01,
        MovementSpring = v18,
        TouchedEvent = v21,
        TouchEndedEvent = v24,
        Touching = {}
    };
end;

local function removeFoliageObject(p25: userdata) -- Line: 185
    -- upvalues: u8 (copy)
    if typeof(p25) ~= "Instance" then
        warn("FoliageHandler - Object passed was not an instance!");

        return;
    end;

    if p25:IsA("Model") and p25.PrimaryPart then
        p25 = p25.PrimaryPart;
    elseif not p25:IsA("BasePart") then
        warn("FoliageHandler - Specified object does not exist! If you are using StreamingEnabled make sure you tag PrimaryParts directly with the \'Foliage\' tag rather than the entire Model.");

        return;
    end;

    if u8[p25] then
        p25.CFrame = u8[p25].OriginCFrame;
        u8[p25].OctreeNode:Destroy();

        if u8[p25].TouchedEvent then
            u8[p25].TouchedEvent:Disconnect();
        end;

        if u8[p25].TouchEndedEvent then
            u8[p25].TouchEndedEvent:Disconnect();
        end;

        u8[p25] = nil;
    end;
end;

local function updateFoliage() -- Line: 218
    -- upvalues: os_clock_ret (ref), workspace_CurrentCamera (copy), u1 (copy), u8 (copy), u4 (ref), u5 (ref), u6 (ref), playRandomSound (copy), Sounds (copy), u2 (ref), u3 (ref)
    local os_clock_ret2 = os.clock();
    local v26 = os_clock_ret2 - os_clock_ret;

    if v26 < 0.025 then
        return;
    end;

    debug.profilebegin("FoliageUpdate");
    os_clock_ret = os_clock_ret2;
    local CFrame2 = workspace_CurrentCamera.CFrame;
    local v27 = u1:RadiusSearch(CFrame2.Position + CFrame2.LookVector * 76.5, 85);
    local v28 = #v27;

    if v28 <= 0 then
        return;
    end;

    local table_create_ret = table.create(v28);
    debug.profilebegin("FoliageCalculation");

    for i, v in v27 do
        local u29 = u8[v];
        local OriginCFrame = u29.OriginCFrame;
        local CFrame3 = u29.CFrame;
        local v30;

        if os_clock_ret2 - u29.LastComputeTime > 0.035 then
            local Seed = u29.Seed;
            local v31 = u4 * 0.085;
            local v32 = os_clock_ret2 * (u5 * 0.075);
            local v33 = math.noise(v32, 0, Seed) * v31;
            local v34 = math.noise(v32, 0, -Seed) * v31;
            local v35 = math.noise(v32, 0, Seed + Seed) * v31;
            local Vector3_new_ret = Vector3.new(v33, v34, v35);
            u29.Goal = (OriginCFrame * v.PivotOffset * CFrame.Angles(Vector3_new_ret.X, Vector3_new_ret.Y, Vector3_new_ret.Z) + u6 * ((0.4 + math.noise(v32, Seed, Seed)) * v31)) * v.PivotOffset:Inverse();
            u29.LastComputeTime = os_clock_ret2;
            debug.profilebegin("FoliagePlayerCollision");
            v30 = i;
            local v36 = v;

            for i2, v2 in u29.Touching do
                if v2 and (i2.Character and i2.Character.PrimaryPart) then
                    local AssemblyLinearVelocity = i2.Character.PrimaryPart.AssemblyLinearVelocity;

                    if not u29.SoundCooldown and AssemblyLinearVelocity.Magnitude >= 0.01 then
                        u29.SoundCooldown = true;
                        task.delay(2, function() -- Line: 267
                            -- upvalues: u29 (copy)
                            u29.SoundCooldown = false;
                        end);
                        playRandomSound(Sounds, v36);
                    end;

                    local MovementSpring = u29.MovementSpring;
                    local v37 = -math.clamp(AssemblyLinearVelocity.Z, u2, u3);
                    local math_clamp_ret = math.clamp(AssemblyLinearVelocity.X, u2, u3);
                    MovementSpring.t = Vector3.new(v37, 0, math_clamp_ret);
                    u29.Goal = u29.Goal * CFrame.Angles(u29.MovementSpring.p.X, u29.MovementSpring.p.Y, u29.MovementSpring.p.Z);
                end;
            end;

            debug.profileend();
        else
            v30 = i;
        end;

        local math_min_ret = math.min(1, v26 * 6);
        local v38 = CFrame3:Lerp(u29.Goal, math_min_ret);
        u29.CFrame = v38;
        table_create_ret[v30] = v38;
    end;

    debug.profileend();
    workspace:BulkMoveTo(v27, table_create_ret, Enum.BulkMoveMode.FireCFrameChanged);
    debug.profileend();
end;

local function onPlayerRemoving(p39: userdata) -- Line: 292
    -- upvalues: u8 (copy)
    for _, v in u8 do
        if v.Touching[p39] then
            v.Touching[p39] = nil;
        end;
    end;
end;

(function() -- Line: 300, Name: initialize
    -- upvalues: ReplicatedStorage (copy), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u8 (copy), u6 (ref), u7 (ref), CollectionService (copy), addFoliageObject (copy), Players (copy), onPlayerRemoving (copy), removeFoliageObject (copy), RunService (copy), updateFoliage (copy)
    ReplicatedStorage:GetAttributeChangedSignal("InfluenceMin"):Connect(function() -- Line: 301
        -- upvalues: u2 (ref), ReplicatedStorage (ref)
        u2 = ReplicatedStorage:GetAttribute("InfluenceMin");
    end);
    ReplicatedStorage:GetAttributeChangedSignal("InfluenceMax"):Connect(function() -- Line: 305
        -- upvalues: u3 (ref), ReplicatedStorage (ref)
        u3 = ReplicatedStorage:GetAttribute("InfluenceMax");
    end);
    ReplicatedStorage:GetAttributeChangedSignal("Power"):Connect(function() -- Line: 309
        -- upvalues: u4 (ref), ReplicatedStorage (ref)
        u4 = ReplicatedStorage:GetAttribute("Power");
    end);
    ReplicatedStorage:GetAttributeChangedSignal("Speed"):Connect(function() -- Line: 313
        -- upvalues: u5 (ref), ReplicatedStorage (ref), u8 (ref)
        u5 = ReplicatedStorage:GetAttribute("Speed");

        for _, v in u8 do
            v.MovementSpring.s = u5;
        end;
    end);
    ReplicatedStorage:GetAttributeChangedSignal("Direction"):Connect(function() -- Line: 321
        -- upvalues: u6 (ref), ReplicatedStorage (ref)
        u6 = ReplicatedStorage:GetAttribute("Direction");
    end);
    ReplicatedStorage:GetAttributeChangedSignal("Replicates"):Connect(function() -- Line: 325
        -- upvalues: u7 (ref), ReplicatedStorage (ref)
        u7 = ReplicatedStorage:GetAttribute("Replicates");
    end);
    task.spawn(function() -- Line: 329
        -- upvalues: CollectionService (ref), addFoliageObject (ref)
        for _, v in CollectionService:GetTagged("Foliage") do
            if v:IsA("Model") or v:IsA("BasePart") then
                addFoliageObject(v);
            end;
        end;
    end);
    Players.PlayerRemoving:Connect(onPlayerRemoving);
    CollectionService:GetInstanceAddedSignal("Foliage"):Connect(addFoliageObject);
    CollectionService:GetInstanceRemovedSignal("Foliage"):Connect(removeFoliageObject);
    RunService.Heartbeat:Connect(updateFoliage);
end)();