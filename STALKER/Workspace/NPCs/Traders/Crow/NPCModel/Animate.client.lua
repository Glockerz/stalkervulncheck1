-- Decompiled with Potassium's decompiler.

local script_Parent = script.Parent;
local Torso = script_Parent:WaitForChild("Torso");
local u1 = Torso:WaitForChild("Right Shoulder");
local u2 = Torso:WaitForChild("Left Shoulder");
local u3 = Torso:WaitForChild("Right Hip");
local u4 = Torso:WaitForChild("Left Hip");
Torso:WaitForChild("Neck");
local Humanoid = script_Parent:WaitForChild("Humanoid");
local _ = game.ReplicatedStorage;
local _ = game.StarterPlayer;
local _ = script.Parent;
local u5, u6;

if game.ReplicatedStorage:FindFirstChild("SPH_Assets") then
    local SPH_Assets = game.ReplicatedStorage.SPH_Assets;
    local GameConfig = require(SPH_Assets:WaitForChild("GameConfig"));
    animconfig = require(SPH_Assets:FindFirstChild("GameConfig"):WaitForChild("AnimationsConfig"));
    u5 = GameConfig.walkSpeed;
    u6 = GameConfig.fallDamageDist;
else
    animconfig = require(game.ReplicatedStorage:WaitForChild("AnimationsConfig"));
    u5 = Humanoid.WalkSpeed;
    u6 = animconfig["Landing Mechanics"].RevertToDefaultFallDamageDistance;
end;

local idleSpeedSafetyRange = animconfig["Velocity Mechanics"].idleSpeedSafetyRange;
local walkSpeedSafetyRange = animconfig["Velocity Mechanics"].walkSpeedSafetyRange;
local _ = animconfig.Animations;
local success, result = pcall(function() -- Line: 39
    return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun");
end);
local u7 = success and result;

local function getRigScale() -- Line: 42
    -- upvalues: u7 (copy), script_Parent (copy)
    return not u7 and 1 or script_Parent:GetScale();
end;

local v8 = {
    pose = "Standing",
    currentAnim = "",
    currentAnimInstance = nil,
    currentAnimTrack = nil,
    currentAnimKeyframeHandler = nil,
    currentAnimLength = 0,
    currentAnimSpeed = 1,
    animTable = {},
    animNames = {
        idle = { {
                defaultid = "rbxassetid://180435571",
                weight = 9
            }, {
                defaultid = "rbxassetid://180435792",
                weight = 1
            } },
        swim = { {
                defaultid = "rbxassetid://0",
                weight = 10
            } },
        swimidle = { {
                defaultid = "rbxassetid://0",
                weight = 10
            } },
        walk = { {
                defaultid = "rbxassetid://180426354",
                weight = 10
            } },
        run = { {
                defaultid = "run.xml",
                weight = 10
            } },
        jump = { {
                defaultid = "rbxassetid://125750702",
                weight = 10
            } },
        fall = { {
                defaultid = "rbxassetid://180436148",
                weight = 10
            } },
        land = { {
                defaultid = "rbxassetid://0",
                weight = 10
            } },
        climb = { {
                defaultid = "rbxassetid://180436334",
                weight = 10
            } },
        sit = { {
                defaultid = "rbxassetid://178130996",
                weight = 10
            } },
        toolnone = { {
                defaultid = "rbxassetid://182393478",
                weight = 10
            } },
        toolslash = { {
                defaultid = "rbxassetid://129967390",
                weight = 10
            } },
        toollunge = { {
                defaultid = "rbxassetid://129967478",
                weight = 10
            } },
        wave = { {
                defaultid = "rbxassetid://128777973",
                weight = 10
            } },
        point = { {
                defaultid = "rbxassetid://128853357",
                weight = 10
            } },
        dance1 = { {
                defaultid = "rbxassetid://182435998",
                weight = 10
            }, {
                defaultid = "rbxassetid://182491037",
                weight = 10
            }, {
                defaultid = "rbxassetid://182491065",
                weight = 10
            } },
        dance2 = { {
                defaultid = "rbxassetid://182436842",
                weight = 10
            }, {
                defaultid = "rbxassetid://182491248",
                weight = 10
            }, {
                defaultid = "rbxassetid://182491277",
                weight = 10
            } },
        dance3 = { {
                defaultid = "rbxassetid://182436935",
                weight = 10
            }, {
                defaultid = "rbxassetid://182491368",
                weight = 10
            }, {
                defaultid = "rbxassetid://182491423",
                weight = 10
            } },
        laugh = { {
                defaultid = "rbxassetid://129423131",
                weight = 10
            } },
        cheer = { {
                defaultid = "rbxassetid://129423030",
                weight = 10
            } }
    },
    dances = { "dance1", "dance2", "dance3" },
    emoteNames = {
        wave = false,
        point = false,
        dance1 = true,
        dance2 = true,
        dance3 = true,
        laugh = false,
        cheer = false
    }
};
local pose = v8.pose;
local currentAnim = v8.currentAnim;
local currentAnimInstance = v8.currentAnimInstance;
local currentAnimTrack = v8.currentAnimTrack;
local currentAnimKeyframeHandler = v8.currentAnimKeyframeHandler;
local currentAnimLength = v8.currentAnimLength;
local currentAnimSpeed = v8.currentAnimSpeed;
local u9 = nil;
local animTable = v8.animTable;
local animNames = v8.animNames;
local dances = v8.dances;
local emoteNames = v8.emoteNames;
local RunService = game:GetService("RunService");
local Humanoid2 = script_Parent:WaitForChild("Humanoid");
local HumanoidRootPart = script_Parent:WaitForChild("HumanoidRootPart");
local Y = HumanoidRootPart.Position.Y;
local RevertToDefaultLandDelay = animconfig["Landing Mechanics"].RevertToDefaultLandDelay;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.IgnoreWater = false;
RaycastParams_new_ret.RespectCanCollide = false;
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.FilterDescendantsInstances = { script_Parent };
local u10 = 0;
local u11 = false;
task.wait();

if script:FindFirstChild("land").LandAnim.AnimationId ~= "rbxassetid://" .. 0 then
    RunService.RenderStepped:Connect(function() -- Line: 172
        -- upvalues: pose (ref), Humanoid2 (copy), u10 (ref), HumanoidRootPart (copy), RaycastParams_new_ret (copy), u11 (ref), u6 (ref), Humanoid (copy), RevertToDefaultLandDelay (ref), currentAnimLength (ref), script_Parent (copy), Y (ref)
        if pose == "Dead" then
            return;
        end;

        if Humanoid2.Sit then
            u10 = 0;
        end;

        local v12 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -3.1, 0), RaycastParams_new_ret);

        if v12 and v12.Instance then
            if u11 then
                u11 = false;

                if u10 > u6 + animconfig["Landing Mechanics"].FallDistanceAddition and pose ~= "Landing" then
                    pose = "Landing";
                    playAnimation("land", 0.1, Humanoid);
                    RevertToDefaultLandDelay = currentAnimLength;

                    if RevertToDefaultLandDelay == 0 then
                        RevertToDefaultLandDelay = animconfig["Landing Mechanics"].RevertToDefaultLandDelay;
                    end;

                    if animconfig["Landing Mechanics"].FindDefaultLandDelay then
                        if currentAnimLength == 0 then
                            warn("FIND LAND DELAY |", "Animation Loading... LAND AGAIN.");
                        else
                            warn("FIND LAND DELAY |", RevertToDefaultLandDelay, "- Use as Default LandDelay");
                        end;
                    end;

                    task.wait(RevertToDefaultLandDelay);
                    pose = "Standing";
                    onMoving(script_Parent.PrimaryPart.Velocity.Magnitude);
                end;

                u10 = 0;
            end;
        else
            u11 = true;
        end;

        local Y2 = HumanoidRootPart.Position.Y;

        if Y2 < Y and u11 then
            u10 = u10 + (Y - Y2);
        else
            u10 = 0;
        end;

        Y = Y2;
    end);
end;

function configureAnimationSet(u13, u14)
    -- upvalues: animTable (copy)
    if animTable[u13] ~= nil then
        for _, v in pairs(animTable[u13].connections) do
            v:Disconnect();
        end;
    end;

    animTable[u13] = {};
    animTable[u13].count = 0;
    animTable[u13].totalWeight = 0;
    animTable[u13].connections = {};
    local v15 = script:FindFirstChild(u13);

    if v15 ~= nil then
        table.insert(animTable[u13].connections, v15.ChildAdded:Connect(function(p16) -- Line: 233
            -- upvalues: u13 (copy), u14 (copy)
            configureAnimationSet(u13, u14);
        end));
        table.insert(animTable[u13].connections, v15.ChildRemoved:Connect(function(p17) -- Line: 234
            -- upvalues: u13 (copy), u14 (copy)
            configureAnimationSet(u13, u14);
        end));
        local v18 = 1;

        for _, child in pairs(v15:GetChildren()) do
            if child:IsA("Animation") then
                table.insert(animTable[u13].connections, child.Changed:Connect(function(p19) -- Line: 238
                    -- upvalues: u13 (copy), u14 (copy)
                    configureAnimationSet(u13, u14);
                end));
                animTable[u13][v18] = {};
                animTable[u13][v18].anim = child;
                local Weight = child:FindFirstChild("Weight");

                if Weight == nil then
                    animTable[u13][v18].weight = 1;
                else
                    animTable[u13][v18].weight = Weight.Value;
                end;

                animTable[u13].count = animTable[u13].count + 1;
                animTable[u13].totalWeight = animTable[u13].totalWeight + animTable[u13][v18].weight;
                v18 = v18 + 1;
            end;
        end;
    end;

    if animTable[u13].count <= 0 then
        for i, v in pairs(u14) do
            animTable[u13][i] = {};
            animTable[u13][i].anim = Instance.new("Animation");
            animTable[u13][i].anim.Name = u13;
            animTable[u13][i].anim.AnimationId = v.defaultid;
            animTable[u13][i].weight = v.weight;
            animTable[u13].count = animTable[u13].count + 1;
            animTable[u13].totalWeight = animTable[u13].totalWeight + v.weight;
        end;
    end;
end;

function scriptChildModified(p20)
    -- upvalues: animNames (copy)
    local v21 = animNames[p20.Name];

    if v21 ~= nil then
        configureAnimationSet(p20.Name, v21);
    end;
end;

script.ChildAdded:Connect(scriptChildModified);
script.ChildRemoved:Connect(scriptChildModified);
local v22;

if Humanoid then
    v22 = Humanoid:FindFirstChildOfClass("Animator");
else
    v22 = nil;
end;

if v22 then
    local PlayingAnimationTracks = v22:GetPlayingAnimationTracks();

    for _, v in ipairs(PlayingAnimationTracks) do
        v:Stop(0);
        v:Destroy();
    end;
end;

for i, v in pairs(animNames) do
    configureAnimationSet(i, v);
end;

local u23 = "None";
local u24 = 0;
local u25 = 0;

function stopAllAnimations()
    -- upvalues: currentAnim (ref), emoteNames (copy), currentAnimInstance (ref), currentAnimKeyframeHandler (ref), currentAnimTrack (ref)
    local v26 = currentAnim;
    local v27 = emoteNames[v26] ~= nil and emoteNames[v26] == false and "idle" or v26;
    currentAnim = "";
    currentAnimInstance = nil;

    if currentAnimKeyframeHandler ~= nil then
        currentAnimKeyframeHandler:Disconnect();
    end;

    if currentAnimTrack ~= nil then
        currentAnimTrack:Stop();
        currentAnimTrack:Destroy();
        currentAnimTrack = nil;
    end;

    return v27;
end;

function setAnimationSpeed(p28)
    -- upvalues: currentAnimSpeed (ref), currentAnimTrack (ref)
    if p28 ~= currentAnimSpeed then
        currentAnimSpeed = p28;
        currentAnimTrack:AdjustSpeed(currentAnimSpeed);
    end;
end;

function keyFrameReachedFunc(p29)
    -- upvalues: currentAnim (ref), emoteNames (copy), currentAnimSpeed (ref), Humanoid (copy)
    if p29 == "End" then
        local v30 = currentAnim;
        playAnimation(emoteNames[v30] ~= nil and emoteNames[v30] == false and "idle" or v30, 0, Humanoid);
        setAnimationSpeed(currentAnimSpeed);
    end;
end;

function playAnimation(p31, p32, p33)
    -- upvalues: animTable (copy), currentAnimInstance (ref), currentAnimTrack (ref), currentAnimSpeed (ref), u9 (ref), currentAnimLength (ref), currentAnim (ref), currentAnimKeyframeHandler (ref)
    local math_random_ret = math.random(1, animTable[p31].totalWeight);
    local v34 = 1;

    while animTable[p31][v34].weight < math_random_ret do
        math_random_ret = math_random_ret - animTable[p31][v34].weight;
        v34 = v34 + 1;
    end;

    local anim = animTable[p31][v34].anim;

    if anim ~= currentAnimInstance then
        if currentAnimTrack ~= nil then
            currentAnimTrack:Stop(p32);
            currentAnimTrack:Destroy();
        end;

        currentAnimTrack = p33:LoadAnimation(anim);
        currentAnimSpeed = 1;
        u9 = currentAnimTrack.Priority;
        currentAnimTrack.Priority = Enum.AnimationPriority.Core;
        currentAnimLength = currentAnimTrack.Length / currentAnimSpeed;
        currentAnimTrack:Play(p32);
        currentAnim = p31;
        currentAnimInstance = anim;

        if currentAnimKeyframeHandler ~= nil then
            currentAnimKeyframeHandler:Disconnect();
        end;

        currentAnimKeyframeHandler = currentAnimTrack.KeyframeReached:Connect(keyFrameReachedFunc);
    end;
end;

local u35 = "";
local u36 = nil;
local u37 = nil;
local u38 = nil;

function toolKeyFrameReachedFunc(p39)
    -- upvalues: u35 (ref), Humanoid (copy)
    if p39 == "End" then
        playToolAnimation(u35, 0, Humanoid);
    end;
end;

function playToolAnimation(p40, p41, p42, p43)
    -- upvalues: animTable (copy), u37 (ref), u36 (ref), u35 (ref), u38 (ref)
    local math_random_ret = math.random(1, animTable[p40].totalWeight);
    local v44 = 1;

    while animTable[p40][v44].weight < math_random_ret do
        math_random_ret = math_random_ret - animTable[p40][v44].weight;
        v44 = v44 + 1;
    end;

    local anim = animTable[p40][v44].anim;

    if u37 ~= anim then
        if u36 ~= nil then
            u36:Stop();
            u36:Destroy();
            p41 = 0;
        end;

        u36 = p42:LoadAnimation(anim);

        if p43 then
            u36.Priority = p43;
        end;

        u36:Play(p41);
        u35 = p40;
        u37 = anim;
        u38 = u36.KeyframeReached:Connect(toolKeyFrameReachedFunc);
    end;
end;

function stopToolAnimations()
    -- upvalues: u35 (ref), u38 (ref), u37 (ref), u36 (ref)
    local v45 = u35;

    if u38 ~= nil then
        u38:Disconnect();
    end;

    u35 = "";
    u37 = nil;

    if u36 ~= nil then
        u36:Stop();
        u36:Destroy();
        u36 = nil;
    end;

    return v45;
end;

function onMoving(p46)
    -- upvalues: pose (ref), u7 (copy), script_Parent (copy), idleSpeedSafetyRange (copy), Humanoid (copy), emoteNames (copy), currentAnim (ref), u5 (ref), walkSpeedSafetyRange (copy), currentAnimInstance (ref)
    if pose == "Landing" then
        return;
    end;

    local v47 = p46 / (not u7 and 1 or script_Parent:GetScale());

    if v47 <= idleSpeedSafetyRange or Humanoid.MoveDirection.Magnitude <= 0.01 then
        if emoteNames[currentAnim] == nil then
            playAnimation("idle", 0.1, Humanoid);
            pose = "Standing";
        end;
    else
        if v47 <= u5 + walkSpeedSafetyRange and idleSpeedSafetyRange < v47 then
            playAnimation("walk", 0.1, Humanoid);

            if currentAnimInstance and currentAnimInstance.AnimationId == "rbxassetid://180426354" then
                setAnimationSpeed(v47 / 14.5);
            end;

            pose = "Walking";

            return;
        end;

        if u5 + walkSpeedSafetyRange < v47 then
            playAnimation("run", 0.1, Humanoid);

            if currentAnimInstance and currentAnimInstance.AnimationId == "run.xml" then
                setAnimationSpeed(v47 / 14.5);
            end;

            pose = "Running";
        end;
    end;
end;

function onDied()
    -- upvalues: pose (ref)
    pose = "Dead";
    task.wait(1);

    if script then
        script:Destroy();
    end;
end;

function onJumping()
    -- upvalues: Humanoid (copy), u25 (ref), pose (ref)
    playAnimation("jump", 0.1, Humanoid);
    u25 = 0.3;
    pose = "Jumping";
end;

function onClimbing(p48)
    -- upvalues: u7 (copy), script_Parent (copy), Humanoid (copy), pose (ref), u10 (ref)
    local v49 = p48 / (not u7 and 1 or script_Parent:GetScale());
    playAnimation("climb", 0.1, Humanoid);
    setAnimationSpeed(v49 / 12);
    pose = "Climbing";
    u10 = 0;
end;

function onGettingUp()
    -- upvalues: pose (ref)
    pose = "GettingUp";
end;

function onFreeFall()
    -- upvalues: pose (ref), u25 (ref), Humanoid (copy)
    if pose == "Landing" then
        return;
    end;

    if u25 <= 0 then
        playAnimation("fall", 0.3, Humanoid);
    end;

    pose = "FreeFall";
end;

function onFallingDown()
    -- upvalues: pose (ref)
    pose = "FallingDown";
end;

function onSeated()
    -- upvalues: pose (ref)
    pose = "Seated";
end;

function onPlatformStanding()
    -- upvalues: pose (ref)
    pose = "PlatformStanding";
end;

function onSwimming(p50)
    -- upvalues: Humanoid (copy), pose (ref)
    if Humanoid.MoveDirection.Magnitude == 0 then
        if script:FindFirstChild("swimidle").SwimIdleAnim.AnimationId == "rbxassetid://" .. 0 then
            pose = "Standing";

            return;
        end;

        pose = "SwimmingIdle";

        return;
    end;

    if script:FindFirstChild("swim").SwimAnim.AnimationId == "rbxassetid://" .. 0 then
        pose = "Running";

        return;
    end;

    pose = "Swimming";
end;

function getTool()
    -- upvalues: script_Parent (copy)
    for _, child in ipairs(script_Parent:GetChildren()) do
        if child.className == "Tool" then
            return child;
        end;
    end;

    return nil;
end;

function getToolAnim(p51)
    for _, child in ipairs(p51:GetChildren()) do
        if child.Name == "toolanim" and child.className == "StringValue" then
            return child;
        end;
    end;

    return nil;
end;

function animateTool()
    -- upvalues: u23 (ref), Humanoid (copy)
    if u23 == "None" then
        playToolAnimation("toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle);

        return;
    end;

    if u23 == "Slash" then
        playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action);

        return;
    end;

    if u23 ~= "Lunge" then
        return;
    end;

    playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action);
end;

function moveSit()
    -- upvalues: u1 (copy), u2 (copy), u3 (copy), u4 (copy)
    u1.MaxVelocity = 0.15;
    u2.MaxVelocity = 0.15;
    u1:SetDesiredAngle(1.57);
    u2:SetDesiredAngle(-1.57);
    u3:SetDesiredAngle(1.57);
    u4:SetDesiredAngle(-1.57);
end;

local u52 = 0;

function move(p53)
    -- upvalues: u52 (ref), u25 (ref), pose (ref), Humanoid (copy), u1 (copy), u2 (copy), u3 (copy), u4 (copy), u23 (ref), u24 (ref), u37 (ref)
    local v54 = 1;
    local v55 = 1;
    local v56 = p53 - u52;
    u52 = p53;
    local v57 = false;

    if u25 > 0 then
        u25 = u25 - v56;
    end;

    if animconfig.DEBUG["Pose Warns"] then
        warn(pose);
    end;

    if pose == "Landing" then
        return;
    end;

    if pose == "FreeFall" and u25 <= 0 then
        playAnimation("fall", 0.3, Humanoid);
    else
        if pose == "Seated" then
            playAnimation("sit", 0.5, Humanoid);

            return;
        end;

        if pose == "Walking" then
            playAnimation("walk", 0.1, Humanoid);
        elseif pose == "Running" then
            playAnimation("run", 0.1, Humanoid);
        elseif pose == "Swimming" then
            playAnimation("swim", 0.1, Humanoid);
        elseif pose == "SwimmingIdle" then
            playAnimation("swimidle", 0.1, Humanoid);
        elseif pose == "Dead" or (pose == "GettingUp" or (pose == "FallingDown" or (pose == "Seated" or pose == "PlatformStanding"))) then
            stopAllAnimations();
            v57 = true;
            v55 = 1;
            v54 = 0.1;
        end;
    end;

    if v57 then
        local v58 = v54 * math.sin(p53 * v55);
        u1:SetDesiredAngle(v58 + 0);
        u2:SetDesiredAngle(v58 - 0);
        u3:SetDesiredAngle(-v58);
        u4:SetDesiredAngle(-v58);
    end;

    local v59 = getTool();

    if v59 and v59:FindFirstChild("Handle") then
        local v60 = getToolAnim(v59);

        if v60 then
            u23 = v60.Value;
            v60.Parent = nil;
            u24 = p53 + 0.3;
        end;

        if u24 < p53 then
            u24 = 0;
            u23 = "None";
        end;

        animateTool();

        return;
    end;

    stopToolAnimations();
    u23 = "None";
    u37 = nil;
    u24 = 0;
end;

Humanoid.Died:Connect(onDied);
Humanoid.Running:Connect(onMoving);
Humanoid.Jumping:Connect(onJumping);
Humanoid.Climbing:Connect(onClimbing);
Humanoid.GettingUp:Connect(onGettingUp);
Humanoid.FreeFalling:Connect(onFreeFall);
Humanoid.FallingDown:Connect(onFallingDown);
Humanoid.Seated:Connect(onSeated);
Humanoid.PlatformStanding:Connect(onPlatformStanding);
Humanoid.Swimming:Connect(onSwimming);
game:GetService("Players").LocalPlayer.Chatted:Connect(function(p61) -- Line: 725
    -- upvalues: dances (copy), pose (ref), emoteNames (copy), Humanoid (copy)
    local v62 = "";

    if p61 == "/e dance" then
        v62 = dances[math.random(1, #dances)];
    elseif string.sub(p61, 1, 3) == "/e " then
        v62 = string.sub(p61, 4);
    elseif string.sub(p61, 1, 7) == "/emote " then
        v62 = string.sub(p61, 8);
    end;

    if pose == "Standing" and emoteNames[v62] ~= nil then
        playAnimation(v62, 0.1, Humanoid);
    end;
end);

script:WaitForChild("PlayEmote").OnInvoke = function(p63) -- Line: 742
    -- upvalues: pose (ref), emoteNames (copy), Humanoid (copy), currentAnimTrack (ref)
    if pose == "Standing" then
        if emoteNames[p63] == nil then
            return false;
        end;

        playAnimation(p63, 0.1, Humanoid);

        return true, currentAnimTrack;
    end;
end;

playAnimation("idle", 0.1, Humanoid);
pose = "Standing";

while script_Parent.Parent ~= nil do
    local _, v64 = wait(0.1);
    move(v64);
end;