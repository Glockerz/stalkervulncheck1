-- Decompiled with Potassium's decompiler.

local u1 = {};
local StateConstants = require(script.Parent.StateConstants);
local S_Config = require(game:GetService("ReplicatedStorage").Modules.DirectionalAnimation.S_Config);
local STATES = StateConstants.STATES;
local TRANSITION_TIMES = S_Config.TRANSITION_TIMES;

function u1.new() -- Line: 7
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, {
        __index = u1
    });
    v2.transitions = v2:_buildTransitionTable();

    return v2;
end;

function u1._buildTransitionTable(p3) -- Line: 13
    -- upvalues: STATES (copy), TRANSITION_TIMES (copy)
    return {
        [STATES.WALKR] = {
            [STATES.WALK] = TRANSITION_TIMES.WALK_TO_REVERSE
        },
        [STATES.WALK] = {
            [STATES.WALKR] = TRANSITION_TIMES.REVERSE_TO_WALK,
            [STATES.WALKLD] = TRANSITION_TIMES.WALK_TO_LEFT_DIAG,
            [STATES.WALKRD] = TRANSITION_TIMES.WALK_TO_RIGHT_DIAG
        },
        [STATES.WALKL] = {
            [STATES.WALK] = TRANSITION_TIMES.WALK_TO_LEFT,
            [STATES.WALKRIGHT] = TRANSITION_TIMES.RIGHT_TO_LEFT,
            [STATES.IDLE] = TRANSITION_TIMES.LEFT_TO_IDLE,
            [STATES.WALKLD] = TRANSITION_TIMES.WALK_TO_LEFT_DIAG,
            [STATES.WALKLDR] = TRANSITION_TIMES.WALK_TO_LEFT_DIAG
        },
        [STATES.WALKRIGHT] = {
            [STATES.WALK] = TRANSITION_TIMES.WALK_TO_RIGHT,
            [STATES.WALKL] = TRANSITION_TIMES.LEFT_TO_RIGHT,
            [STATES.IDLE] = TRANSITION_TIMES.RIGHT_TO_IDLE,
            [STATES.WALKRD] = TRANSITION_TIMES.WALK_TO_RIGHT_DIAG,
            [STATES.WALKRDR] = TRANSITION_TIMES.WALK_TO_RIGHT_DIAG
        },
        [STATES.WALKLD] = {
            [STATES.WALK] = TRANSITION_TIMES.LEFT_DIAG_TO_WALK,
            [STATES.WALKRD] = TRANSITION_TIMES.LEFT_DIAG_TO_RIGHT_DIAG,
            [STATES.WALKLDR] = TRANSITION_TIMES.LEFT_DIAG_TO_LEFT_DIAG_REV,
            [STATES.WALKL] = TRANSITION_TIMES.LEFT_DIAG_TO_WALK,
            [STATES.IDLE] = TRANSITION_TIMES.DIAG_TO_IDLE
        },
        [STATES.WALKLDR] = {
            [STATES.WALKLD] = TRANSITION_TIMES.LEFT_DIAG_REV_TO_LEFT_DIAG,
            [STATES.WALKRDR] = TRANSITION_TIMES.LEFT_DIAG_TO_RIGHT_DIAG,
            [STATES.WALKL] = TRANSITION_TIMES.LEFT_DIAG_TO_WALK,
            [STATES.IDLE] = TRANSITION_TIMES.DIAG_TO_IDLE
        },
        [STATES.WALKRD] = {
            [STATES.WALK] = TRANSITION_TIMES.RIGHT_DIAG_TO_WALK,
            [STATES.WALKLD] = TRANSITION_TIMES.RIGHT_DIAG_TO_LEFT_DIAG,
            [STATES.WALKRDR] = TRANSITION_TIMES.RIGHT_DIAG_TO_RIGHT_DIAG_REV,
            [STATES.WALKRIGHT] = TRANSITION_TIMES.RIGHT_DIAG_TO_WALK,
            [STATES.IDLE] = TRANSITION_TIMES.DIAG_TO_IDLE
        },
        [STATES.WALKRDR] = {
            [STATES.WALKRD] = TRANSITION_TIMES.RIGHT_DIAG_REV_TO_RIGHT_DIAG,
            [STATES.WALKLDR] = TRANSITION_TIMES.RIGHT_DIAG_TO_LEFT_DIAG,
            [STATES.WALKRIGHT] = TRANSITION_TIMES.RIGHT_DIAG_TO_WALK,
            [STATES.IDLE] = TRANSITION_TIMES.DIAG_TO_IDLE
        },
        [STATES.IDLE] = {
            [STATES.WALKL] = TRANSITION_TIMES.LEFT_TO_IDLE,
            [STATES.WALKRIGHT] = TRANSITION_TIMES.RIGHT_TO_IDLE,
            [STATES.WALKLD] = TRANSITION_TIMES.IDLE_TO_DIAG,
            [STATES.WALKLDR] = TRANSITION_TIMES.IDLE_TO_DIAG,
            [STATES.WALKRD] = TRANSITION_TIMES.IDLE_TO_DIAG,
            [STATES.WALKRDR] = TRANSITION_TIMES.IDLE_TO_DIAG
        }
    };
end;

function u1.getTransitionTime(p4, p5, p6) -- Line: 34
    local v7 = p4.transitions[p5];

    if v7 and v7[p6] then
        return v7[p6];
    end;

    return p4:_calculateDynamicTransition(p5, p6);
end;

function u1._calculateDynamicTransition(p8, p9, p10) -- Line: 42
    -- upvalues: StateConstants (copy), TRANSITION_TIMES (copy), STATES (copy)
    local v11 = StateConstants.DIAGONAL_STATE_SET[p9];
    local v12 = StateConstants.DIAGONAL_STATE_SET[p10];

    if not (v11 or v12) then
        if StateConstants.WALK_STATE_SET[p9] and p10 == STATES.IDLE then
            return TRANSITION_TIMES.IDLE_TO_WALK;
        end;

        return TRANSITION_TIMES.IDLE_TO_WALK;
    end;

    if v11 and v12 then
        return TRANSITION_TIMES.LEFT_DIAG_TO_RIGHT_DIAG * 0.7;
    end;

    if v11 then
        return TRANSITION_TIMES.IDLE_TO_DIAG;
    end;

    return TRANSITION_TIMES.DIAG_TO_IDLE;
end;

return u1;