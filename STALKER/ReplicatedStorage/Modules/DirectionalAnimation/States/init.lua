-- Decompiled with Potassium's decompiler.

local u1 = {};
local StateConstants = require(script.Modules.StateConstants);
local MovementDetector = require(script.Modules.MovementDetector);
local AnimationManager = require(script.Modules.AnimationManager);
local TransitionManager = require(script.Modules.TransitionManager);
local SpeedController = require(script.Modules.SpeedController);
local S_Config = require(game:GetService("ReplicatedStorage").Modules.DirectionalAnimation.S_Config);
local Players = game:GetService("Players");
u1.STATES = StateConstants.STATES;

local function isBadVector3(p2) -- Line: 18
    local X = p2.X;
    local Y = p2.Y;
    local Z = p2.Z;

    return (X ~= X or (Y ~= Y or (Z ~= Z or (math.abs(X) > 1000000 or math.abs(Y) > 1000000)))) and true or math.abs(Z) > 1000000;
end;

function u1.new(p3, p4) -- Line: 26
    -- upvalues: u1 (copy), MovementDetector (copy), TransitionManager (copy), AnimationManager (copy), SpeedController (copy), StateConstants (copy), S_Config (copy)
    local v5 = setmetatable({}, {
        __index = u1
    });
    v5.character = p3;
    v5.humanoid = p3:WaitForChild("Humanoid");
    v5.rootPart = p3:WaitForChild("HumanoidRootPart");
    v5.xa = p4;
    v5.movementDetector = MovementDetector.new();
    v5.transitionManager = TransitionManager.new();
    v5.animationManager = AnimationManager.new(v5.xa, v5.transitionManager);
    v5.speedController = SpeedController.new(v5.humanoid);
    v5.state = StateConstants.STATES.IDLE;
    v5.velocity = Vector3.new(0, 0, 0);
    v5._cachedConstants = {
        MOVEMENT_THRESHOLD = S_Config.THRESHOLDS.MOVEMENT,
        IDLE_STATE = StateConstants.STATES.IDLE
    };
    v5._connections = {};
    v5._destroyed = false;
    v5:_initializeControls();

    return v5;
end;

function u1._initializeControls(p6) -- Line: 55
    -- upvalues: Players (copy)
    local LocalPlayer = Players.LocalPlayer;

    if not LocalPlayer then
        return;
    end;

    local success, result = pcall(function() -- Line: 59
        -- upvalues: LocalPlayer (copy)
        return require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule", 5));
    end);

    if success and result then
        p6.playerModule = result;
        p6.controls = result:GetControls();

        if p6.movementDetector and p6.movementDetector.setControls then
            p6.movementDetector:setControls(p6.controls);
        end;
    end;
end;

function u1.loadAnimations(p7) -- Line: 73
    if p7._destroyed then
        return;
    end;

    p7.animationManager:loadAnimations();
    p7.animationManager:initializeIdle();
end;

function u1.switchState(p8, p9, p10, p11) -- Line: 79
    if p8._destroyed then
        return;
    end;

    if p9 == p8.state and not p10 then
        return;
    end;

    local TransitionTime = p8.transitionManager:getTransitionTime(p9, p8.state);

    if p8._resumingFromSkip and p8._resumingFromSkip > 0 then
        TransitionTime = math.max(TransitionTime, 0.5);
    end;

    p8.animationManager:switchState(p9, p8.state, TransitionTime, p10, p11);
    p8.state = p9;
end;

function u1.update(p12, p13) -- Line: 92
    -- upvalues: S_Config (copy), StateConstants (copy)
    if p12._destroyed then
        return;
    end;

    p12._dt = p13;

    if p12._resumingFromSkip and p12._resumingFromSkip > 0 then
        p12._resumingFromSkip = p12._resumingFromSkip - p13;
    end;

    if not p12._kaTimer then
        p12._kaTimer = 0;
    end;

    p12._kaTimer = p12._kaTimer + p13;

    if p12._kaTimer > 2 then
        p12._kaTimer = 0;

        if S_Config.DEBUG_MODE then
            local v14 = p12.humanoid and (p12.humanoid.Health or -1) or -1;
            local v15 = p12.humanoid and v14 < 80 and (v14 <= 20 and 1 or ((80 - v14) / 60 or 0)) or 0;
            print(string.format("[DirAnim] state=%s hp=%.1f injuryOverlay=%.2f", tostring(p12.state), v14, v15));
        end;
    end;

    local AssemblyLinearVelocity = p12.rootPart.AssemblyLinearVelocity;
    local X = AssemblyLinearVelocity.X;
    local Y = AssemblyLinearVelocity.Y;
    local Z = AssemblyLinearVelocity.Z;

    if (X ~= X or (Y ~= Y or (Z ~= Z or (math.abs(X) > 1000000 or math.abs(Y) > 1000000)))) and true or math.abs(Z) > 1000000 then
        return;
    end;

    p12.velocity = AssemblyLinearVelocity;
    local v16 = false;
    local v17 = false;
    local v18;

    if p12.humanoid.Health < 60 then
        v18 = p12.humanoid.Health > 0;
    else
        v18 = false;
    end;

    local v19 = false;

    for _, child in p12.character:GetChildren() do
        if child:IsA("Tool") then
            v19 = true;
            break;
        end;
    end;

    local v20 = p12.character:GetAttribute("Stance") or 0;

    if v20 == 2 then
        v16 = true;
    elseif v20 == 1 then
        v17 = true;
    end;

    local v21 = p12.character:GetAttribute("Sprinting") == true;

    if (v21 or (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) and math.sqrt(p12.velocity.X * p12.velocity.X + p12.velocity.Z * p12.velocity.Z) > 11 and true or v21)) and not v18 and true or v16 then
        if not p12._skipBlended then
            for _, v in pairs(p12.animationManager.animations or {}) do
                if v and v.Blend then
                    v:Blend(0, 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                end;
            end;

            p12._skipBlended = true;
            p12.state = StateConstants.STATES.IDLE;
        end;

        return;
    end;

    if p12._skipBlended then
        p12._skipBlended = false;
        p12._resumingFromSkip = 0.5;
    end;

    local v22 = p12.speedController:calculatePlanarSpeed(p12.velocity);

    if p12._cachedConstants.MOVEMENT_THRESHOLD < v22 then
        p12:_handleWalk(v22, p13, v17, v18);

        return;
    end;

    p12:_handleIdle(v17, v19);
end;

local function calcInjuryOverlay(p23) -- Line: 211
    if not p23 or p23.Health <= 0 then
        return 0;
    end;

    local Health = p23.Health;

    return Health >= 80 and 0 or (Health <= 20 and 1 or (80 - Health) / 60);
end;

function u1._handleWalk(p24, p25, p26, p27, p28) -- Line: 219
    -- upvalues: StateConstants (copy)
    if not p24.movementDetector:hasMovementInput() then
        p24:_handleIdle(p27);

        return;
    end;

    local v29 = p24.movementDetector:determineWalkState();
    p24.speedController:updateMovementFlags(p24.movementDetector:getMovementFlags());

    if p27 then
        local v30 = StateConstants.WALK_TO_CROUCH[v29] or v29;
        local v31 = p24.speedController:calculateTargetAnimationSpeed(v30, p25);
        p24.animationManager:smoothAnimationSpeed(v30, v31, p26);
        p24:switchState(v30);

        return;
    end;

    local humanoid = p24.humanoid;
    local v32;

    if humanoid and humanoid.Health > 0 then
        local Health = humanoid.Health;
        v32 = Health >= 80 and 0 or (Health <= 20 and 1 or (80 - Health) / 60);
    else
        v32 = 0;
    end;

    local v33;

    if v32 > 0 then
        v33 = StateConstants.WALK_TO_INJURED[v29] or nil;
    else
        v33 = nil;
    end;

    local v34 = p24.speedController:calculateTargetAnimationSpeed(v29, p25);
    p24.animationManager:smoothAnimationSpeed(v29, v34, p26);

    if v33 then
        p24.animationManager:smoothAnimationSpeed(v33, v34, p26);
    end;

    if v33 then
        if p24._destroyed then
            return;
        end;

        local TransitionTime = p24.transitionManager:getTransitionTime(v29, p24.state);

        if p24._resumingFromSkip and p24._resumingFromSkip > 0 then
            TransitionTime = math.max(TransitionTime, 0.5);
        end;

        p24.animationManager:switchStateWithOverlay(v29, v33, v32, p24.state, TransitionTime);
        p24.state = v29;
        p24._overlayActive = true;

        return;
    end;

    if not p24._overlayActive then
        p24:switchState(v29);

        return;
    end;

    p24._overlayActive = false;

    if p24._destroyed then
        return;
    end;

    local TransitionTime = p24.transitionManager:getTransitionTime(v29, p24.state);

    if p24._resumingFromSkip and p24._resumingFromSkip > 0 then
        TransitionTime = math.max(TransitionTime, 0.5);
    end;

    p24.animationManager:switchState(v29, p24.state, TransitionTime);
    p24.state = v29;
end;

function u1._handleIdle(p35, p36, p37) -- Line: 286
    -- upvalues: StateConstants (copy)
    p35.speedController:resetMovementFlags();
    p35._overlayActive = false;
    local IDLE_STATE = p35._cachedConstants.IDLE_STATE;

    if p36 then
        IDLE_STATE = StateConstants.STATES.CROUCH_IDLE;
    end;

    p35:switchState(IDLE_STATE);
end;

function u1.destroy(p38) -- Line: 298
    if p38._destroyed then
        return;
    end;

    p38._destroyed = true;

    for _, v in ipairs(p38._connections) do
        if v and v.Connected then
            v:Disconnect();
        end;
    end;

    table.clear(p38._connections);

    if p38.speedController then
        p38.speedController:destroy();
    end;

    if p38.animationManager then
        p38.animationManager:destroy();
    end;

    if p38.movementDetector then
        p38.movementDetector:destroy();
    end;

    p38.transitionManager = nil;
    p38.controls = nil;
    p38.playerModule = nil;
    p38.character = nil;
    p38.humanoid = nil;
    p38.rootPart = nil;
    p38.xa = nil;
    p38._cachedConstants = nil;
    setmetatable(p38, nil);
end;

return u1;