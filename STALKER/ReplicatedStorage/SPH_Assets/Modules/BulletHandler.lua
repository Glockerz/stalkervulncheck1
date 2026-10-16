-- Decompiled with Potassium's decompiler.

local v1 = {};
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = ReplicatedStorage.SPH_Assets.Modules;
local GameConfig = require(Modules.Parent.GameConfig);
local HitFX = require(Modules.HitFX);
local BridgeNet = require(ReplicatedStorage.SPH_Assets.Modules.BridgeNet);
local u2 = nil;
local Projectiles = workspace:WaitForChild("SPH_Workspace"):WaitForChild("Projectiles");
local Cache = workspace.SPH_Workspace:WaitForChild("Cache");
local Suppression = ReplicatedStorage:WaitForChild("Suppression", 100);
local PierceMod = require(Modules.PierceMod);
local PartCache = require(Modules.PartCache);
local script_Bullet = script.Bullet;
local u3 = PartCache.new(script_Bullet:Clone(), GameConfig.maxBullets or 300, Cache);
local FastCast = require(Modules.FastCast);
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.IgnoreWater = true;
RaycastParams_new_ret.RespectCanCollide = true;
local u4 = FastCast.newBehavior();
u4.RaycastParams = RaycastParams_new_ret;
u4.MaxDistance = GameConfig.maxBulletDistance;
u4.AutoIgnoreContainer = true;
u4.CosmeticBulletContainer = Projectiles;
u4.HighFidelityBehavior = FastCast.HighFidelityBehavior.Default;
u4.CosmeticBulletProvider = u3;
u4.CanPierceFunction = PierceMod.CanPierce;
local u5 = FastCast.new();
FastCast.VisualizeCasts = false;
local u6 = nil;
local u7 = nil;

function v1.Initialize(p8) -- Line: 49
    -- upvalues: u6 (ref), u7 (ref), u2 (ref), BridgeNet (copy), RaycastParams_new_ret (copy)
    u6 = p8;
    u7 = p8.Character;
    u2 = BridgeNet.CreateBridge("BulletHit");
    RaycastParams_new_ret.FilterDescendantsInstances = { u7, workspace.CurrentCamera };
end;

local function ResetBullet(p9) -- Line: 56
    -- upvalues: script_Bullet (copy)
    p9.BulletSmoke.Enabled = false;
    p9.PointLight.Enabled = false;
    p9.Color = script_Bullet.Color;
    p9.BeamLong.Color = script_Bullet.BeamLong.Color;
    p9.BeamLong.Enabled = false;
    p9.Transparency = 1;
    p9.PointLight.Enabled = false;
    p9.PointLight.Color = script_Bullet.PointLight.Color;
    p9.DistanceEffect.Enabled = false;
    p9.DistanceEffect.Dot.ImageColor3 = script_Bullet.DistanceEffect.Dot.ImageColor3;
    p9.DistanceEffect.Flare.ImageColor3 = p9.DistanceEffect.Flare.ImageColor3;

    if p9:FindFirstChild("FakeBullet") then
        p9.FakeBullet:Destroy();
    end;
end;

local u10 = 0;

local function PlaySFX(u11, p12, p13) -- Line: 76
    -- upvalues: Debris (copy), u10 (ref), GameConfig (copy), u6 (ref)
    local FireSounds = u11:FindFirstChild("FireSounds");
    local SuppressorSounds = u11:FindFirstChild("SuppressorSounds");
    local BassSounds = u11:FindFirstChild("BassSounds");
    local TailSounds = u11:FindFirstChild("TailSounds");
    local MediumSounds = u11:FindFirstChild("MediumSounds");
    local FarSounds = u11:FindFirstChild("FarSounds");
    local ThumpSounds = u11:FindFirstChild("ThumpSounds");
    local Thump = u11:FindFirstChild("Thump");
    local v14 = not FireSounds and {} or FireSounds:GetChildren();
    local v15 = not SuppressorSounds and {} or SuppressorSounds:GetChildren();
    local u16 = nil;

    if p13 and #v15 > 0 then
        u16 = v15[math.random(1, #v15)];
    elseif not p13 and #v14 > 0 then
        u16 = v14[math.random(1, #v14)];
    end;

    local Echo = u11:FindFirstChild("Echo");
    local Bass = u11:FindFirstChild("Bass");
    local Tail = u11:FindFirstChild("Tail");

    local function playDistanceLayer(p17) -- Line: 108
        -- upvalues: u11 (copy), Debris (ref)
        if p17 and #p17:GetChildren() > 0 then
            local v18 = p17:GetChildren()[math.random(1, #p17:GetChildren())]:Clone();
            v18.Name = p17.Name .. "_Playing";
            v18.Parent = u11;
            v18:Play();
            Debris:AddItem(v18, v18.TimeLength == 0 and 5 or v18.TimeLength);
        end;
    end;

    playDistanceLayer(MediumSounds);
    playDistanceLayer(FarSounds);

    if u16 then
        if u16.Looped then
            local FireFirst = u11:FindFirstChild("FireFirst");

            if u16:GetAttribute("HasPlayedFirst") or not FireFirst then
                local BoolValue = Instance.new("BoolValue");
                BoolValue.Name = "LoopHeartbeat";
                BoolValue.Parent = u16;
                Debris:AddItem(BoolValue, 0.1);

                if not u16.IsPlaying then
                    u16:Play();
                end;

                u16:SetAttribute("HasPlayedSecond", true);
            else
                u16:SetAttribute("HasPlayedFirst", true);
                local v19 = FireFirst:Clone();
                v19.Name = v19.Name .. "_Playing";
                v19.Parent = u11;
                v19:Play();
                Debris:AddItem(v19, v19.TimeLength == 0 and 5 or v19.TimeLength);
                local v20 = nil;
                local v21;

                if BassSounds and #BassSounds:GetChildren() > 0 then
                    local Children = BassSounds:GetChildren();
                    v21 = Children[math.random(1, #Children)];
                else
                    v21 = Bass or v20;
                end;

                if v21 then
                    local v22 = v21:Clone();
                    v22.Name = "Bass_Playing";
                    v22.Parent = u11;
                    v22:Play();
                    Debris:AddItem(v22, v22.TimeLength == 0 and 5 or v22.TimeLength);
                end;
            end;

            task.delay(0.12, function() -- Line: 236
                -- upvalues: u16 (ref), u11 (copy), Debris (ref)
                if not u16:FindFirstChild("LoopHeartbeat") then
                    local FireLoopTail = u11:FindFirstChild("FireLoopTail");

                    if FireLoopTail and u16:GetAttribute("HasPlayedSecond") then
                        local v23 = FireLoopTail:Clone();
                        v23.Parent = u11;
                        v23:Play();
                        Debris:AddItem(v23, v23.TimeLength == 0 and 5 or v23.TimeLength);
                        u16:SetAttribute("HasPlayedSecond", nil);
                    end;

                    u16:Stop();
                    u16:SetAttribute("HasPlayedFirst", nil);
                end;
            end);
        else
            local v24 = u16:Clone();
            v24.Name = v24.Name .. "_Playing";
            v24.PlaybackSpeed = 1 + math.random(-5, 5) / 100;
            v24.Parent = u11;
            v24:Play();
            Debris:AddItem(v24, v24.TimeLength == 0 and 5 or v24.TimeLength);
            local v25 = nil;
            local v26;

            if BassSounds and #BassSounds:GetChildren() > 0 then
                local Children = BassSounds:GetChildren();
                v26 = Children[math.random(1, #Children)];
            else
                v26 = Bass or v25;
            end;

            if v26 then
                local v27 = v26:Clone();
                v27.Name = "Bass_Playing";
                v27.Parent = u11;
                v27:Play();
                Debris:AddItem(v27, v27.TimeLength == 0 and 5 or v27.TimeLength);
            end;

            local v28 = nil;
            local v29;

            if ThumpSounds and #ThumpSounds:GetChildren() > 0 then
                v29 = ThumpSounds:GetChildren()[math.random(1, #ThumpSounds:GetChildren())];
            else
                v29 = Thump or v28;
            end;

            if v29 then
                local v30 = v29:Clone();
                v30.Name = "Thump_Playing";
                v30.Parent = u11;
                v30:Play();
                Debris:AddItem(v30, v30.TimeLength == 0 and 5 or v30.TimeLength);
            end;

            if tick() - u10 >= 0.1 then
                local v31 = nil;
                local v32;

                if TailSounds and #TailSounds:GetChildren() > 0 then
                    local Children = TailSounds:GetChildren();
                    v32 = Children[math.random(1, #Children)];
                else
                    v32 = Tail or v31;
                end;

                if v32 then
                    local u33 = v32:Clone();
                    u33.Name = "Tail_Playing";
                    u33.Parent = u11;
                    task.delay(0.15, function() -- Line: 177
                        -- upvalues: u33 (copy)
                        u33:Play();
                    end);
                    Debris:AddItem(u33, u33.TimeLength == 0 and 5 or u33.TimeLength);
                    u10 = tick();
                end;
            end;

            if Echo and (GameConfig.firstPersonEcho or p12 ~= u6) then
                local u34 = Echo:Clone();
                u34.Name = "Echo_Playing";
                u34.Parent = u11;
                task.delay(0.25, function() -- Line: 190
                    -- upvalues: u34 (copy)
                    u34:Play();
                end);
                Debris:AddItem(u34, u34.TimeLength == 0 and 5 or u34.TimeLength);
            end;
        end;
    end;
end;

function v1.FireBullet(p35, p36, p37, p38, p39, p40, p41, p42, p43) -- Line: 256
    -- upvalues: u4 (ref), GameConfig (copy), u5 (copy), ResetBullet (copy), ReplicatedStorage (copy), TweenService (copy)
    local WeaponStats = require(p39.SPH_Weapon.WeaponStats);
    u4.Acceleration = GameConfig.bulletAcceleration;

    if not WeaponStats.bulletDrop then
        u4.Acceleration = Vector3.new(0, 0, 0);
    end;

    local v44 = u5:Fire(p36, p37, p38, u4);
    local v45 = {
        Player = p40,
        TracerColor = p41,
        Tool = p39,
        IgnoreModel = p35,
        FakeBullet = p42,
        Visible = false,
        Origin = p36,
        SuppressionLevel = WeaponStats.suppressionLevel or 1,
        ModTable = p43
    };
    local CosmeticBulletObject = v44.RayInfo.CosmeticBulletObject;

    if CosmeticBulletObject and CosmeticBulletObject.Transparency == 0 then
        ResetBullet(CosmeticBulletObject);
    end;

    local v46 = ReplicatedStorage.SPH_Assets.Projectiles:FindFirstChild(WeaponStats.projectile);

    if v46 and not p41 then
        local v47 = v46:Clone();
        v47.Anchored = false;
        v47.CanCollide = false;
        v47.Name = "FakeBullet";
        v47.Parent = CosmeticBulletObject;
        v45.Visible = true;
    end;

    v44.UserData = v45;

    if WeaponStats.serverOffset then
        local BaseWeld = p35.BaseWeld;
        local v48 = WeaponStats.serverOffset * CFrame.new(0, 0, 0.17);
        local CFrame_Angles = CFrame.Angles;
        local v49 = math.random(-10, 10) / 10;
        BaseWeld.C0 = v48 * CFrame_Angles(0.03490658503988659, math.rad(v49), 0);
        TweenService:Create(p35.BaseWeld, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            C0 = WeaponStats.serverOffset
        }):Play();
    end;

    if p35:FindFirstChild("Weapon") then
        local v50 = p35.Weapon:FindFirstChildWhichIsA("Model");

        if v50 and v50:FindFirstChild(WeaponStats.projectile) then
            local v51 = v50:FindFirstChild(WeaponStats.projectile);
            v51.LocalTransparencyModifier = 1;

            for _, descendant in ipairs(v51:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    descendant.LocalTransparencyModifier = 1;
                end;
            end;
        end;
    end;
end;

function v1.FireFX(p52: userdata, p53: any, p54: any, p55: any, p56: any) -- Line: 327
    -- upvalues: PlaySFX (copy), u6 (ref), GameConfig (copy)
    local Character = p52.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local v57 = p53:FindFirstChild("Grip") or p53:FindFirstChild("Base");

    if not (Character:FindFirstChild("WeaponRig"):FindFirstChild("Grip", true) or p53:FindFirstChild("Grip")) then
        p53:FindFirstChild("Base");
    end;

    local v58 = v57[p54];
    PlaySFX(v57, p52, p56);
    PlaySFX(v58, p52, p56);

    if HumanoidRootPart and u6:DistanceFromCharacter(HumanoidRootPart.Position) <= GameConfig.fireEffectDistance then
        local v59 = math.random(10) <= p55;

        for _, child in ipairs(v58:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                if child:GetAttribute("EmitNumber") then
                    if string.find(child.Name, "Flash") then
                        if v59 then
                            child:Emit(child:GetAttribute("EmitNumber"));
                        end;
                    else
                        child:Emit(child:GetAttribute("EmitNumber"));
                    end;
                elseif child:FindFirstChild("Particles") then
                    if not string.find(child.Name, "Flash") and true or (v59 and true or false) then
                        child:Emit(child.Particles.Value);
                    end;
                elseif child.Name == "Smoke" then
                    child:Emit(10);
                elseif child.Name == "Flash" and v59 then
                    child:Emit(5);
                end;
            elseif child:IsA("Light") and v59 then
                child.Enabled = true;
                task.delay(0.01, function() -- Line: 372
                    -- upvalues: child (copy)
                    child.Enabled = false;
                end);
            end;
        end;

        local Chamber = v58:FindFirstChild("Chamber");

        if Chamber then
            for _, child in ipairs(Chamber:GetChildren()) do
                if child:IsA("ParticleEmitter") then
                    if child:GetAttribute("EmitNumber") then
                        child:Emit(child:GetAttribute("EmitNumber"));
                    elseif child.Name == "Smoke" then
                        child:Emit(10);
                    elseif child.Name == "Flash" and v59 then
                        child:Emit(5);
                    end;
                end;
            end;
        end;
    end;
end;

function v1.MoveBolt(p60, p61, p62, p63) -- Line: 394
    -- upvalues: TweenService (copy)
    if not (p60 and p60:FindFirstChild("Grip")) then
        return;
    end;

    for _, child in ipairs(p60.Grip:GetChildren()) do
        local v64 = child;

        for _, v in ipairs(p61.fireMoveParts) do
            if v64.Name == v then
                v64.C1 = CFrame.new();
                local v65;

                if p63 <= 0 then
                    v65 = p61.emptyLockBolt;
                else
                    v65 = false;
                end;

                local TweenInfo_new_ret = TweenInfo.new(60 / p61.fireRate / 2, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, not v65);
                local v66;

                if typeof(p62) == "CFrame" then
                    v66 = p62;
                else
                    v66 = CFrame.new(0, 0, -p62);
                end;

                TweenService:Create(v64, TweenInfo_new_ret, {
                    C1 = v66
                }):Play();
                break;
            end;
        end;
    end;
end;

u5.LengthChanged:Connect(function(p67, p68, p69, p70, p71, p72) -- Line: 420
    -- upvalues: GameConfig (copy), u6 (ref), Suppression (copy)
    if not p72 then
        return;
    end;

    if GameConfig.suppressionEffects and (u6 ~= p67.UserData.Player and not (p67.UserData.Cracked or (u6:DistanceFromCharacter(p72.Position) > 60 or u6:DistanceFromCharacter(p67.UserData.Origin) < 60))) then
        Suppression:Fire(p67.UserData.SuppressionLevel);
        p67.UserData.Cracked = true;
    end;

    if not p67.UserData.Visible and (GameConfig.arcadeBullets or p67.UserData.TracerColor) and (p67.UserData.Origin - p72.Position).Magnitude > GameConfig.tracerStartDistance then
        p67.UserData.Visible = true;
        p72.Transparency = 0;
        p72.BeamLong.Enabled = true;
        p72.BulletSmoke.Enabled = true;
        p72.PointLight.Enabled = true;
        p72.DistanceEffect.Enabled = true;

        if p67.UserData.TracerColor then
            local TracerColor = p67.UserData.TracerColor;

            if GameConfig.teamTracers and p67.UserData.Player.Team then
                p72.Color = p67.UserData.Player.Team.TeamColor.Color;
            else
                p72.Color = TracerColor;
            end;

            p72.BeamLong.Enabled = true;
            p72.BeamLong.Color = ColorSequence.new(TracerColor);
            p72.PointLight.Color = TracerColor;
            p72.BulletSmoke.Enabled = false;
            p72.DistanceEffect.Dot.ImageColor3 = TracerColor;
            p72.DistanceEffect.Flare.ImageColor3 = TracerColor;
        end;
    end;

    local v73 = p72.Size.Z / 2;
    p72.CFrame = CFrame.new(p68, p68 + p69) * CFrame.new(0, 0, -(p70 - v73));

    if p72:FindFirstChild("FakeBullet") then
        p72.FakeBullet.CFrame = p72.CFrame;
    end;
end);
u5.RayHit:Connect(function(p74: any, p75: any, p76: any, p77: userdata) -- Line: 465
    -- upvalues: HitFX (copy), u2 (ref), GameConfig (copy), u6 (ref), Suppression (copy)
    if p74.UserData.TurretFired then
        local _ = require(p74.UserData.IgnoreModel.Parent.TurretModule).guns[p74.UserData.Tool];
    else
        require(p74.UserData.Tool.SPH_Weapon.WeaponStats);
    end;

    if not p74.UserData.FakeBullet then
        HitFX.HitEffect(p75.Position, p75.Instance, p75.Normal);
        u2:Fire(p74.UserData.TurretFired and {
            model = p74.UserData.IgnoreModel,
            index = p74.UserData.Tool
        } or p74.UserData.Tool, {
            Position = p75.Position,
            Normal = p75.Normal,
            Instance = p75.Instance
        }, p77.CFrame, p74.UserData.ModTable);

        if GameConfig.suppressionEffects and (u6 ~= p74.UserData.Player and not p74.UserData.Cracked) then
            Suppression:Fire(p74.UserData.SuppressionLevel);
            p74.UserData.Cracked = true;
        end;
    end;
end);
u5.CastTerminating:Connect(function(p78) -- Line: 494
    -- upvalues: ResetBullet (copy), u3 (copy)
    if p78.UserData.Visible then
        ResetBullet(p78.RayInfo.CosmeticBulletObject);
    end;

    u3:ReturnPart(p78.RayInfo.CosmeticBulletObject);
end);

return v1;