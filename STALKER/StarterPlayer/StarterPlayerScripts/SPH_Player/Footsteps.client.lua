-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local SPH_Assets = ReplicatedStorage.SPH_Assets;
local GameConfig = require(SPH_Assets.GameConfig);
local BridgeNet = require(ReplicatedStorage.SPH_Assets.Modules.BridgeNet);
local WalkSounds = SPH_Assets.Sounds.WalkSounds;
local PlaceConfig = require(ReplicatedStorage:WaitForChild("PlaceConfig"));
local SoundService = game:GetService("SoundService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = {
    Running = true,
    Climbing = true,
    Swimming = true,
    Splash = true,
    Jumping = true,
    Landing = true,
    FreeFalling = true,
    GettingUp = true,
    Died = true
};
task.spawn(function() -- Line: 67
    -- upvalues: LocalPlayer (copy)
    local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts", 10);

    if not PlayerScripts then
        return;
    end;

    local function stopStockSounds(p2) -- Line: 70
        if p2:IsA("LuaSourceContainer") and p2.Name == "RbxCharacterSounds" then
            p2:Destroy();
        end;
    end;

    for _, child in ipairs(PlayerScripts:GetChildren()) do
        if child:IsA("LuaSourceContainer") and child.Name == "RbxCharacterSounds" then
            child:Destroy();
        end;
    end;

    PlayerScripts.ChildAdded:Connect(stopStockSounds);
end);
local u3 = BridgeNet.CreateBridge("ReplicateFootstep");
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = 0;
local u11 = {
    Asphalt = "Concrete",
    Basalt = "Concrete",
    Brick = "Concrete",
    Cobblestone = "Concrete",
    Concrete = "Concrete",
    CorrodedMetal = "Metal",
    CrackedLava = "Concrete",
    DiamondPlate = "MetalPlate",
    Fabric = "Ground",
    ForceField = "Metal",
    Glacier = "Ground",
    Granite = "Concrete",
    Grass = "Grass",
    Ground = "Ground",
    Ice = "Concrete",
    LeafyGrass = "Grass",
    Limestone = "Concrete",
    Marble = "Concrete",
    Metal = "Metal",
    Mud = "Ground",
    Neon = "Metal",
    Pavement = "Concrete",
    Pebble = "Ground",
    Plastic = "Concrete",
    Rock = "Concrete",
    Salt = "Ground",
    Sand = "Ground",
    Sandstone = "Concrete",
    Slate = "Concrete",
    SmoothPlastic = "Concrete",
    Snow = "Ground",
    Wood = "Wood",
    WoodPlanks = "Wood"
};

local function inSwampWater(p12: userdata?) -- Line: 150
    if p12 then
        p12 = p12:FindFirstAncestorOfClass("Model");
    end;

    local v13;

    if p12 == nil then
        v13 = false;
    else
        v13 = p12:GetAttribute("_InSwampWater") == true;
    end;

    return v13;
end;

local function GetMoveType() -- Line: 155
    -- upvalues: u8 (ref), GameConfig (copy)
    return u8 and (u8.WalkSpeed <= GameConfig.proneSpeed + 1 and "Prone" or (u8.WalkSpeed <= GameConfig.crouchSpeed + 1 and "Crouch" or (u8.WalkSpeed > GameConfig.walkSpeed + 2 and "Run" or "Walk"))) or "Walk";
end;

local u14 = "_" .. tostring(PlaceConfig.Id);

local function setFor(p15, p16) -- Line: 183
    -- upvalues: WalkSounds (copy), u14 (copy)
    local v17 = WalkSounds:FindFirstChild(u14);

    if v17 then
        v17 = v17:FindFirstChild(p15);
    end;

    if v17 then
        v17 = v17:FindFirstChild(p16);
    end;

    if v17 and #v17:GetChildren() > 0 then
        return v17;
    end;

    local v18 = WalkSounds:FindFirstChild(p15);

    if v18 then
        v18 = v18:FindFirstChild(p16);
    end;

    if v18 and #v18:GetChildren() > 0 then
        return v18;
    end;

    return nil;
end;

local function GetSound(p19, p20) -- Line: 196
    -- upvalues: u11 (copy), u8 (ref), GameConfig (copy), setFor (copy)
    local v21 = u11[p19] or "Concrete";
    local v22 = u8 and (u8.WalkSpeed <= GameConfig.proneSpeed + 1 and "Prone" or (u8.WalkSpeed <= GameConfig.crouchSpeed + 1 and "Crouch" or (u8.WalkSpeed > GameConfig.walkSpeed + 2 and "Run" or "Walk"))) or "Walk";

    if p20 then
        p20 = p20:FindFirstAncestorOfClass("Model");
    end;

    local v23;

    if p20 == nil then
        v23 = false;
    else
        v23 = p20:GetAttribute("_InSwampWater") == true;
    end;

    local v24 = v23 and setFor(v22, "Water") and "Water" or v21;
    local v25 = setFor(v22, v24) or setFor(v22, "Concrete") or (setFor("Walk", v24) or setFor("Walk", "Concrete"));

    if not v25 then
        return "", 1;
    end;

    local Children = v25:GetChildren();

    if #Children == 0 then
        return "", 1;
    end;

    local v26 = Children[math.random(#Children)];

    return v26.SoundId, v26.PlaybackSpeed;
end;

local function isOwnFoot(p27: userdata) -- Line: 230
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;
    local v28;

    if Character == nil then
        v28 = false;
    else
        v28 = p27:IsDescendantOf(Character);
    end;

    return v28;
end;

local function Footstep(p29, p30) -- Line: 238
    -- upvalues: GetSound (copy), LocalPlayer (copy), SoundService (copy)
    local v31, v32 = GetSound(p29.Name, p30);

    if v31 == "" then
        return;
    end;

    local Parent = p30.Parent;

    if not Parent then
        return;
    end;

    local Sound = Instance.new("Sound");
    Sound.Name = p30.Name .. "_step";
    Sound.SoundId = v31;
    Sound.PlaybackSpeed = v32 + math.random(-100, 100) / 1000;
    Sound.Volume = p30.Volume;
    local Character = LocalPlayer.Character;
    local v33;

    if Character == nil then
        v33 = false;
    else
        v33 = p30:IsDescendantOf(Character);
    end;

    if v33 then
        Sound.Parent = SoundService;
    else
        Sound.RollOffMode = p30.RollOffMode;
        Sound.RollOffMinDistance = p30.RollOffMinDistance;
        Sound.RollOffMaxDistance = p30.RollOffMaxDistance;
        Sound.Parent = Parent;
    end;

    Sound:Play();
    Sound.Ended:Connect(function() -- Line: 265
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);
    task.delay(2, function() -- Line: 267
        -- upvalues: Sound (copy)
        if Sound.Parent then
            Sound:Destroy();
        end;
    end);
end;

local function PlayStateSound(p34, p35) -- Line: 285
    -- upvalues: u7 (ref), u9 (ref), setFor (copy), SoundService (copy)
    if not (u7 and u9) then
        return;
    end;

    if not u9:GetAttribute("_InSwampWater") then
        return;
    end;

    local v36 = setFor(p34, "Water");

    if not v36 then
        return;
    end;

    local Children = v36:GetChildren();

    if #Children == 0 then
        return;
    end;

    local v37 = Children[math.random(#Children)];
    local Sound = Instance.new("Sound");
    Sound.Name = p34 .. "_water";
    Sound.SoundId = v37.SoundId;
    Sound.PlaybackSpeed = v37.PlaybackSpeed + math.random(-100, 100) / 1000;
    Sound.Volume = p35;
    Sound.Parent = SoundService;
    Sound:Play();
    Sound.Ended:Connect(function() -- Line: 311
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);
    task.delay(3, function() -- Line: 312
        -- upvalues: Sound (copy)
        if Sound.Parent then
            Sound:Destroy();
        end;
    end);
end;

local u38 = nil;
local Vector3_new_ret = Vector3.new();
local u39 = false;
local u40 = {
    Concrete = "Concrete",
    Asphalt = "Concrete",
    Brick = "Concrete",
    Grass = "Grass",
    LeafyGrass = "Grass",
    Ground = "Ground",
    Mud = "Ground",
    Sand = "Ground",
    Pebble = "Ground",
    Metal = "Metal",
    CorrodedMetal = "Metal",
    DiamondPlate = "Metal",
    Wood = "Wood",
    WoodPlanks = "Wood"
};

local function PlayTurnSound(p41) -- Line: 330
    -- upvalues: u39 (ref), u7 (ref), u40 (copy), u9 (ref), setFor (copy), u38 (ref), SoundService (copy)
    if u39 then
        return;
    end;

    if not u7 then
        return;
    end;

    local v42 = u40[p41] or "Default";
    local v43 = setFor("Turn", u9 and (u9:GetAttribute("_InSwampWater") and setFor("Turn", "Water")) and "Water" or v42) or setFor("Turn", "Default");

    if not v43 then
        return;
    end;

    local Children = v43:GetChildren();
    local v44 = Children[math.random(#Children)];

    if not u38 then
        u38 = Instance.new("Sound");
        u38.Name = "TurnSound";
        u38.Volume = 0.3;
        u38.Parent = SoundService;
    end;

    u38.SoundId = v44.SoundId;
    u38.PlaybackSpeed = v44.PlaybackSpeed + math.random(-50, 50) / 1000;
    u38:Play();
    u39 = true;
    task.delay(0.3, function() -- Line: 362
        -- upvalues: u39 (ref)
        u39 = false;
    end);
end;

local function SetupSoundsForCharacter(p45) -- Line: 367
    -- upvalues: u9 (ref), u8 (ref), PlayStateSound (copy), u7 (ref), u1 (copy), u4 (ref), u5 (ref), u6 (ref)
    u9 = p45;
    u8 = u9:WaitForChild("Humanoid", 10);

    if not u8 then
        return;
    end;

    u8.StateChanged:Connect(function(p46, p47) -- Line: 382
        -- upvalues: PlayStateSound (ref)
        if p47 == Enum.HumanoidStateType.Jumping then
            PlayStateSound("Jump", 0.55);

            return;
        end;

        if p47 == Enum.HumanoidStateType.Landed then
            PlayStateSound("Land", 0.75);
        end;
    end);
    u7 = u9:WaitForChild("HumanoidRootPart", 10);

    if not u7 then
        return;
    end;

    local function silenceStock(p48) -- Line: 414
        -- upvalues: u1 (ref)
        if p48:IsA("Sound") and u1[p48.Name] then
            p48.Volume = 0;
        end;
    end;

    for _, child in ipairs(u7:GetChildren()) do
        if child:IsA("Sound") and u1[child.Name] then
            child.Volume = 0;
        end;
    end;

    u7.ChildAdded:Connect(silenceStock);
    local FootstepSoundOrigin = u7:WaitForChild("FootstepSoundOrigin", 10);

    if not FootstepSoundOrigin then
        FootstepSoundOrigin = Instance.new("Folder");
        FootstepSoundOrigin.Name = "FootstepSoundOrigin";
        FootstepSoundOrigin.Parent = u7;
        local Sound = Instance.new("Sound");
        Sound.Name = "LeftFoot";
        Sound.Parent = FootstepSoundOrigin;
        local Sound2 = Instance.new("Sound");
        Sound2.Name = "RightFoot";
        Sound2.Parent = FootstepSoundOrigin;
    end;

    u4 = FootstepSoundOrigin:WaitForChild("LeftFoot", 5);
    u5 = FootstepSoundOrigin:WaitForChild("RightFoot", 5);
    u6 = true;
end;

LocalPlayer.CharacterAdded:Connect(SetupSoundsForCharacter);

if LocalPlayer.Character then
    task.spawn(function() -- Line: 450
        -- upvalues: SetupSoundsForCharacter (copy), LocalPlayer (copy)
        SetupSoundsForCharacter(LocalPlayer.Character);
    end);
end;

u3:Connect(function(p49, p50, p51) -- Line: 455
    -- upvalues: Footstep (copy)
    p50.Volume = p51;
    Footstep(p49, p50);
end);

if GameConfig.footstepSounds then
    RunService.Heartbeat:Connect(function() -- Line: 461
        -- upvalues: u8 (ref), u7 (ref), u4 (ref), u5 (ref), Vector3_new_ret (ref), PlayTurnSound (copy), u10 (ref), u6 (ref), Footstep (copy), u3 (copy)
        if not (u8 and (u7 and (u4 and u5))) then
            return;
        end;

        if u8.Health <= 0 then
            return;
        end;

        if u8.FloorMaterial == Enum.Material.Air or u8.FloorMaterial == Enum.Material.Water then
            return;
        end;

        local AssemblyLinearVelocity = u7.AssemblyLinearVelocity;
        local Vector3_new_ret2 = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z);
        local Magnitude = Vector3_new_ret2.Magnitude;

        if Magnitude > 3 and Vector3_new_ret.Magnitude > 0.1 then
            local v52 = Vector3_new_ret2.Unit:Dot(Vector3_new_ret);
            local math_clamp_ret = math.clamp(v52, -1, 1);

            if math.acos(math_clamp_ret) > 0.4 then
                PlayTurnSound(u8.FloorMaterial.Name);
            end;
        end;

        if Magnitude > 0.5 then
            Vector3_new_ret = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z).Unit;
        end;

        local os_clock_ret = os.clock();

        if Magnitude > 1.5 and (u8.WalkSpeed / 2 < Magnitude and u10 <= os_clock_ret) then
            local v53 = u6 and u4 or u5;
            u6 = not u6;
            v53.Volume = 0.4 * (Magnitude / 10);
            Footstep(u8.FloorMaterial, v53, v53.Volume);
            u3:Fire(u8.FloorMaterial, v53, v53.Volume);
            local v54 = 0.5 * (1 / (Magnitude / 10));
            u10 = os_clock_ret + (v54 > 2 and 2 or v54);
        end;
    end);
end;