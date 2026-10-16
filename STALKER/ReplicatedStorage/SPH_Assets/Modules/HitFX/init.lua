-- Decompiled with Potassium's decompiler.

local Debris = game:GetService("Debris");
local CollectionService = game:GetService("CollectionService");
local GameConfig = require(script.Parent.Parent.GameConfig);
local WorldToGui = script:WaitForChild("WorldToGui");

if typeof(WorldToGui) == "Instance" then
    WorldToGui = require(WorldToGui);
end;

local MaterialTypes = require(script.Parent.MaterialTypes);
local Value = script:WaitForChild("EnablePartBasedBulletHoles").Value;
local BulletHoles = script:WaitForChild("BulletHoles");

if not BulletHoles then
    warn("BulletHoles folder not found as a child. Part-based bullet holes will use default.");
end;

local u1 = {
    Stone = "rbxassetid://16872096336",
    Wood = "rbxassetid://114129020885295",
    Metal = "rbxassetid://132113206029212",
    Glass = "rbxassetid://108748702128763"
};
local u2 = { "1565824613", "1565825075" };
local u3 = { "282954522", "282954538", "282954576", "1565756607", "1565756818" };
local u4 = { "1565830611", "1565831129", "1565831468", "1565832329" };
local u5 = { "287772625", "287772674", "287772718", "287772829", "287772902" };
local u6 = { "287769261", "287769348", "287769415", "287769483", "287769538" };
local u7 = { "363818432", "363818488", "363818567", "363818611", "363818653" };
local u8 = { "4459572527", "4459573786", "3739364168" };
local u9 = script;
local v10 = {};

function CheckColor(p11, p12)
    local v13 = p11 + p12;

    return v13 > 1 and 1 or (v13 < 0 and 0 or v13);
end;

function BloodSplat(p14, p15, p16)
    -- upvalues: CollectionService (copy), u7 (copy), Debris (copy)
    local script_BloodSplatterModules = script.BloodSplatterModules;

    if math.random(0, 100) > 50 then
        p16 = -p16;
    end;

    local CFrame_new_ret = CFrame.new(p14, p14 + p16);
    local Attachment = Instance.new("Attachment");
    Attachment.CFrame = CFrame_new_ret;
    Attachment.Parent = game.Workspace.Terrain;
    local u17 = script_BloodSplatterModules.GibStuff.Drop3:Clone();
    u17.Parent = game.Workspace;
    u17.CFrame = Attachment.CFrame;
    local math_random_ret = math.random(-50, 50);
    local math_random_ret2 = math.random(-50, 50);
    local math_random_ret3 = math.random(-50, 50);
    u17.Orientation = Vector3.new(Attachment.Orientation.X + math_random_ret, Attachment.Orientation.Y + math_random_ret2, Attachment.Orientation.Z + math_random_ret3);
    local BodyThrust = Instance.new("BodyThrust");
    local v18 = math.random(-2, 2) * 0.5;
    local v19 = math.random(-2, 5) * 0.5;
    local v20 = math.random(-57, -5) * 0.5;
    BodyThrust.Force = Vector3.new(v18, v19, v20);
    BodyThrust.Parent = u17;
    task.delay(0.15, function() -- Line: 83
        -- upvalues: BodyThrust (copy)
        BodyThrust:Destroy();
    end);
    local GibStuff = script_BloodSplatterModules.GibStuff;
    local RaycastHitboxV3 = require(script_BloodSplatterModules.RaycastHitboxV3);
    local DecalSurface = require(script_BloodSplatterModules.DecalSurface);
    local u21 = RaycastHitboxV3:Initialize(u17, { workspace.ignore, u17.owner.Value, u17 });
    local u22 = { "splat", "blood", "Drop", "Drop2", "Puddle", "Handle", "Splatter", "Torso", "HumanoidRootPart", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "Head", "Collision", "Weight", "ColliderPart" };

    local function isBlacklisted(p23) -- Line: 95
        -- upvalues: u22 (copy)
        for _, v in pairs(u22) do
            if p23.Name == v then
                return true;
            end;
        end;

        return false;
    end;

    GibStuff.LightSplats:GetChildren();
    GibStuff.DenseSplatters:GetChildren();
    local u24 = false;
    local u25 = nil;
    delay(0.1, function() -- Line: 112
        -- upvalues: u24 (ref)
        u24 = true;
    end);
    u21:PartMode(true);
    u21.OnHit:Connect(function(p26, p27, p28) -- Line: 117
        -- upvalues: u22 (copy), CollectionService (ref), u25 (ref), DecalSurface (copy), u21 (copy), u17 (copy)
        local Position = p28.Position;
        local Normal = p28.Normal;

        if p26 then
            local v29 = false;

            for _, v in pairs(u22) do
                if p26.Name == v then
                    v29 = true;
                    break;
                end;
            end;

            if v29 == false and (p26.Parent:IsA("Accessory") == false and (p26.Parent:IsA("Tool") == false and (p26.Parent:FindFirstChild("Humanoid") == nil and p26.CanCollide ~= false))) then
                if not (CollectionService:HasTag(p26, "Gibbed") or (CollectionService:HasTag(p26, "Gibs") or CollectionService:HasTag(p26, "Gore"))) then
                    u25 = "Small";
                    DecalSurface.MakeDecalOnSurface("Blood", Normal, p26, Position, u25);
                end;

                u21:HitStop();
                u17:Destroy();
            end;
        end;
    end);
    u21:HitStart();
    local Sound = Instance.new("Sound");
    local v30 = u7;
    Sound.Parent = Attachment;
    Sound.Volume = math.random(5, 10) / 10;
    Sound.MaxDistance = 500;
    Sound.EmitterSize = 10;
    Sound.PlaybackSpeed = math.random(34, 50) / 40;
    Sound.SoundId = "rbxassetid://" .. v30[math.random(1, #v30)];
    Sound:Play();

    if Sound.TimeLength > 3 then
        local _ = Sound.TimeLength;
    end;

    for _, child in pairs(script_BloodSplatterModules.BloodEffect:GetChildren()) do
        if child.ClassName == "ParticleEmitter" then
            local u31 = child:Clone();
            u31.Parent = Attachment;
            local u32 = not u31:FindFirstChild("EmitCount") and 1 or u31.EmitCount.Value;
            task.delay(0.01, function() -- Line: 172
                -- upvalues: u31 (copy), u32 (ref), Debris (ref)
                u31:Emit(u32);
                Debris:AddItem(u31, u31.Lifetime.Max);
            end);
        end;
    end;

    Debris:AddItem(Attachment, 10);
end;

function CreateEffect(p33, p34, p35)
    -- upvalues: u9 (copy), u6 (copy), u8 (copy), u7 (copy), u2 (copy), u3 (copy), u4 (copy), u5 (copy), Debris (copy)
    local v36 = u9:FindFirstChild(p33) or u9.Stone;
    local v37 = v36:GetChildren()[math.random(1, #v36:GetChildren())]:Clone();
    local v38 = 3;

    for _, child in pairs(v37:GetChildren()) do
        if not child:IsA("ParticleEmitter") then
            return;
        end;

        child.Parent = p34;
        child.Enabled = false;

        if p33 == "Sand" and p35 then
            local Color = p35.Color;
            local v39 = p35.Material == Enum.Material.Fabric and -0.2 or 0.3;
            local Color3_new_ret = Color3.new(CheckColor(Color.R, v39), CheckColor(Color.G, v39), CheckColor(Color.B, v39));
            child.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3_new_ret), ColorSequenceKeypoint.new(1, Color3_new_ret) });
        end;

        child:Emit(child.Rate > 10 and (child.Rate / 10 or 1) or 1);

        if v38 < child.Lifetime.Max then
            v38 = child.Lifetime.Max;
        end;
    end;

    local Sound = Instance.new("Sound");
    local v40 = u6;

    if p33 == "Headshot" then
        v40 = u8;
    elseif p33 == "Hit" then
        v40 = u7;
    elseif p33 == "Glass" then
        v40 = u2;
    elseif p33 == "Metal" then
        v40 = u3;
    elseif p33 == "Ground" then
        v40 = u4;
    elseif p33 == "Wood" then
        v40 = u5;
    end;

    Sound.Parent = p34;
    Sound.Volume = math.random(5, 10) / 10;
    Sound.MaxDistance = 500;
    Sound.EmitterSize = 10;
    Sound.PlaybackSpeed = math.random(34, 50) / 40;
    Sound.SoundId = "rbxassetid://" .. v40[math.random(1, #v40)];
    Sound:Play();

    if v38 < Sound.TimeLength then
        v38 = Sound.TimeLength;
    end;

    Debris:AddItem(p34, v38);
end;

local function CreateSurfaceGuiBulletHole(p41, p42, p43) -- Line: 243
    -- upvalues: WorldToGui (ref), MaterialTypes (copy), u1 (copy), Debris (copy), GameConfig (copy)
    local v44, _, _, v45, v46 = WorldToGui:WorldPositionToGuiPosition(p41, p42);

    if not v44 then
        return;
    end;

    local v47 = MaterialTypes(p43);
    local string_format_ret = string.format("BulletHoleGui_%s", v44.Name);
    local v48 = p41:FindFirstChild(string_format_ret);
    local v49;

    if v48 then
        v49 = v48:WaitForChild("Container", 0.1);

        if not v49 then
            warn("Existing BulletHoleGui found without Container for part:", p41, "face:", v44.Name);
            v48:Destroy();
            v48 = nil;
        end;
    else
        v49 = nil;
    end;

    if not v48 then
        v48 = Instance.new("SurfaceGui");
        v48.Name = string_format_ret;
        v48.Parent = p41;
        v48.Face = v44;
        v48.Adornee = p41;
        v48.CanvasSize = Vector2.new(2048, 2048);
        v48.LightInfluence = 1;
        v48.AlwaysOnTop = false;
        v48.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        v48.ClipsDescendants = true;
        v48.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
        v48.PixelsPerStud = 50;
        v49 = Instance.new("Frame");
        v49.Name = "Container";
        v49.Parent = v48;
        v49.BackgroundTransparency = 1;
        v49.Size = UDim2.fromScale(1, 1);
        v49.ClipsDescendants = true;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "BulletHoleFrame";
    Frame.Parent = v49;
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.new(v45, 0, v46, 0);
    Frame.Size = UDim2.new(0, 0.45 * v48.PixelsPerStud, 0, 0.45 * v48.PixelsPerStud);
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "BulletHoleImage";
    ImageLabel.Parent = Frame;
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.ImageTransparency = 0;
    ImageLabel.SizeConstraint = Enum.SizeConstraint.RelativeXY;
    ImageLabel.Size = UDim2.fromScale(1, 1);
    ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Image = u1[v47] or "rbxassetid://12769915043";
    Debris:AddItem(Frame, GameConfig.bulletHoleDespawnTime);
end;

local function CreatePartBasedBulletHole(p50, p51, p52, p53) -- Line: 306
    -- upvalues: MaterialTypes (copy), BulletHoles (copy), Debris (copy), GameConfig (copy)
    local v54 = MaterialTypes(p53);
    local v55;

    if BulletHoles then
        v55 = BulletHoles:FindFirstChild(v54) or BulletHoles:FindFirstChild("Default");
    else
        v55 = nil;
    end;

    if not v55 then
        return;
    end;

    local v56 = v55:Clone();
    v56.Anchored = false;
    v56.CanCollide = false;
    v56.CastShadow = false;
    v56.CanCollide = false;
    v56.CanQuery = false;
    local v57 = CFrame.lookAt(p51, p51 + p52) * CFrame.Angles(-1.5707963267948966, 0, 0);
    v56.CFrame = CFrame.new(p51 + p52 * 0.01) * (v57 - v57.Position);
    v56.Parent = p50;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p50;
    WeldConstraint.Part1 = v56;
    WeldConstraint.Parent = v56;
    Debris:AddItem(v56, GameConfig.bulletHoleDespawnTime);
end;

function v10.HitEffect(p58, p59, p60) -- Line: 335
    -- upvalues: GameConfig (copy), CollectionService (copy), Value (copy), CreatePartBasedBulletHole (copy), CreateSurfaceGuiBulletHole (copy)
    local Material = p59.Material;
    local Attachment = Instance.new("Attachment");
    Attachment.CFrame = CFrame.new(p58, p58 + p60);
    Attachment.Parent = workspace.Terrain;

    if p59 then
        local v61 = "Stone";
        local v62 = false;

        if p59.Name == "Head" then
            v62 = true;
            v61 = "Headshot";
        elseif p59:IsA("BasePart") and (p59.Parent:FindFirstChild("Humanoid") or p59.Parent.Parent and p59.Parent.Parent:FindFirstChild("Humanoid") or p59.Parent.Parent and (p59.Parent.Parent.Parent and p59.Parent.Parent.Parent:FindFirstChild("Humanoid"))) or p59.Parent:IsA("Accessory") then
            v62 = true;
            v61 = "Hit";
        elseif Material == Enum.Material.Wood or Material == Enum.Material.WoodPlanks then
            v61 = "Wood";
        elseif Material == Enum.Material.Metal or (Material == Enum.Material.CorrodedMetal or (Material == Enum.Material.DiamondPlate or (Material == Enum.Material.Neon or Material == Enum.Material.Salt))) then
            v61 = "Metal";
        elseif Material == Enum.Material.Grass or (Material == Enum.Material.Ground or (Material == Enum.Material.LeafyGrass or Material == Enum.Material.Mud)) then
            v61 = "Ground";
        elseif Material == Enum.Material.Sand or (Material == Enum.Material.Fabric or Material == Enum.Material.Snow) then
            v61 = "Sand";
        elseif Material == Enum.Material.Foil or (Material == Enum.Material.Ice or (Material == Enum.Material.Glass or Material == Enum.Material.ForceField)) then
            v61 = "Glass";
        elseif p59.Name == "Glass" then
            p59:Destroy();
            v61 = "Glass";
        end;

        if v62 == true then
            BloodSplat(p58, p59, p60);
        else
            CreateEffect(v61, Attachment, p59);
        end;

        if GameConfig.bulletHoles and (p59.Transparency < 1 and not v62) then
            if GameConfig.glassShatter and (p59.Name == "Glass" or CollectionService:HasTag(p59, "BreakableGlass")) then
                return;
            end;

            if Value then
                CreatePartBasedBulletHole(p59, p58, p60, Material);

                return;
            end;

            CreateSurfaceGuiBulletHole(p59, p58, Material);
        end;
    end;
end;

return v10;