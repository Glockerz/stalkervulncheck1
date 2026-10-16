-- Decompiled with Potassium's decompiler.

local u1 = {};
local StateConstants = require(script.Parent.StateConstants);
local S_Config = require(game:GetService("ReplicatedStorage").Modules.DirectionalAnimation.S_Config);
local u2 = {};

function u1.new() -- Line: 19
    -- upvalues: S_Config (copy), u1 (copy), u2 (copy), StateConstants (copy)
    local v3 = {
        controls = nil,
        _lastDirection = 0,
        _camera = nil,
        _lastMoveVector = Vector3.new(0, 0, 0),
        _lastMoveVectorMagnitude = 0,
        _cachedThresholds = {
            diagonal = S_Config.THRESHOLDS.DIAGONAL,
            sideways = S_Config.THRESHOLDS.SIDEWAYS,
            directional = S_Config.THRESHOLDS.DIRECTIONAL
        },
        _userInputService = game:GetService("UserInputService"),
        _workspace = workspace
    };
    local v4 = setmetatable(v3, {
        __index = u1
    });

    if not u2[1] then
        u2[1] = StateConstants.STATES.WALK;
        u2[2] = StateConstants.STATES.WALKR;
        u2[3] = StateConstants.STATES.WALKL;
        u2[4] = StateConstants.STATES.WALKRIGHT;
        u2[5] = StateConstants.STATES.WALKLD;
        u2[6] = StateConstants.STATES.WALKLDR;
        u2[7] = StateConstants.STATES.WALKRD;
        u2[8] = StateConstants.STATES.WALKRDR;
    end;

    return v4;
end;

function u1.setControls(p5, p6) -- Line: 49
    p5.controls = p6;
end;

function u1.hasMovementInput(p7) -- Line: 53
    -- upvalues: S_Config (copy)
    if not p7.controls then
        return false;
    end;

    local MoveVector = p7.controls:GetMoveVector();
    local Magnitude = MoveVector.Magnitude;
    p7._lastMoveVector = MoveVector;
    p7._lastMoveVectorMagnitude = Magnitude;

    return S_Config.THRESHOLDS.INPUT < Magnitude;
end;

function u1._getDirection(p8) -- Line: 62
    if not p8.controls then
        return 0;
    end;

    local _lastMoveVector = p8._lastMoveVector;

    if p8._lastMoveVectorMagnitude == 0 then
        _lastMoveVector = p8.controls:GetMoveVector();
        local Magnitude = _lastMoveVector.Magnitude;
        p8._lastMoveVector = _lastMoveVector;
        p8._lastMoveVectorMagnitude = Magnitude;
    end;

    if not p8._camera then
        p8._camera = p8._workspace.CurrentCamera;
    end;

    local math_abs_ret = math.abs(_lastMoveVector.X);
    local math_abs_ret2 = math.abs(_lastMoveVector.Z);
    local _cachedThresholds = p8._cachedThresholds;
    local diagonal = _cachedThresholds.diagonal;

    if p8._lastDirection >= 5 then
        diagonal = diagonal * 0.8;
    end;

    local v9;

    if diagonal < math_abs_ret then
        v9 = diagonal < math_abs_ret2;
    else
        v9 = false;
    end;

    if v9 then
        local directional = _cachedThresholds.directional;

        return _lastMoveVector.X < -diagonal and _lastMoveVector.Z < -directional and 5 or (_lastMoveVector.X < -diagonal and directional < _lastMoveVector.Z and 6 or (diagonal < _lastMoveVector.X and _lastMoveVector.Z < -directional and 7 or (diagonal < _lastMoveVector.X and directional < _lastMoveVector.Z and 8 or 1)));
    end;

    local sideways = _cachedThresholds.sideways;
    local directional = _cachedThresholds.directional;

    return _lastMoveVector.Z > 0 and 2 or (_lastMoveVector.X < -sideways and math_abs_ret2 < directional and 3 or (sideways < _lastMoveVector.X and math_abs_ret2 < directional and 4 or 1));
end;

function u1.determineWalkState(p10) -- Line: 115
    -- upvalues: u2 (copy), StateConstants (copy)
    local v11 = p10:_getDirection();
    p10._lastDirection = v11;

    return u2[v11] or StateConstants.STATES.WALK;
end;

function u1.getMovementFlags(p12) -- Line: 121
    local _lastDirection = p12._lastDirection;

    return {
        isWalkingBackwards = _lastDirection == 2,
        isWalkingLeft = _lastDirection == 3,
        isWalkingRight = _lastDirection == 4,
        isDiagonal = _lastDirection >= 5
    };
end;

function u1.destroy(p13) -- Line: 131
    p13.controls = nil;
    p13._userInputService = nil;
    p13._workspace = nil;
    p13._camera = nil;
    p13._lastMoveVector = nil;
    p13._lastMoveVectorMagnitude = 0;
end;

return u1;