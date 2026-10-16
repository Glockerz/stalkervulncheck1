-- Decompiled with Potassium's decompiler.

local u1 = {};
local StateConstants = require(script.Parent.StateConstants);
local S_Config = require(game:GetService("ReplicatedStorage").Modules.DirectionalAnimation.S_Config);

function u1.new(p2) -- Line: 8
    -- upvalues: u1 (copy), S_Config (copy)
    local v3 = setmetatable({}, {
        __index = u1
    });
    v3.humanoid = p2;
    v3.movementState = {
        isWalkingBackwards = false,
        isWalkingLeft = false,
        isWalkingRight = false,
        isDiagonal = false
    };
    v3.prevPlanarSpeed = 0;
    v3.speedDamping = S_Config.PHYSICS.SPEED_DAMPING;

    return v3;
end;

function u1.calculatePlanarSpeed(p4, p5) -- Line: 22
    local math_sqrt_ret = math.sqrt(p5.X * p5.X + p5.Z * p5.Z);
    local speedDamping = p4.speedDamping;

    if p4.movementState.isDiagonal then
        speedDamping = speedDamping * 0.7;
    end;

    p4.prevPlanarSpeed = p4.prevPlanarSpeed + (math_sqrt_ret - p4.prevPlanarSpeed) * (1 - speedDamping);

    return p4.prevPlanarSpeed;
end;

function u1.updateMovementFlags(p6, p7) -- Line: 32
    local movementState = p6.movementState;
    movementState.isWalkingBackwards = p7.isWalkingBackwards;
    movementState.isWalkingLeft = p7.isWalkingLeft;
    movementState.isWalkingRight = p7.isWalkingRight;
    movementState.isDiagonal = p7.isDiagonal;
end;

function u1.resetMovementFlags(p8) -- Line: 40
    for i, _ in pairs(p8.movementState) do
        p8.movementState[i] = false;
    end;
end;

function u1.adjustWalkSpeed(p9, p10) -- Line: 47
end;

function u1.calculateTargetAnimationSpeed(p11, p12, p13) -- Line: 51
    -- upvalues: StateConstants (copy), S_Config (copy)
    local v14 = StateConstants.DIAGONAL_STATE_SET[p12] and S_Config.ANIMATION_SPEED_LIMITS.DIAGONAL or S_Config.ANIMATION_SPEED_LIMITS.WALK or {
        MIN = 0.1,
        MAX = 2
    };

    return math.clamp(p13 / S_Config.REF_SPEEDS.WALK, v14.MIN, v14.MAX);
end;

function u1.destroy(p15) -- Line: 59
    p15.humanoid = nil;
end;

return u1;