-- Decompiled with Potassium's decompiler.

local u1 = {};
local StateConstants = require(script.Parent.StateConstants);
local S_Config = require(game:GetService("ReplicatedStorage").Modules.DirectionalAnimation.S_Config);
local u2 = {
    [StateConstants.STATES.WALK] = "rbxassetid://102279296722086",
    [StateConstants.STATES.WALKR] = "rbxassetid://79065434901606",
    [StateConstants.STATES.WALKL] = "rbxassetid://124200188073533",
    [StateConstants.STATES.WALKRIGHT] = "rbxassetid://85314447616582",
    [StateConstants.STATES.WALKLD] = "rbxassetid://128112729937135",
    [StateConstants.STATES.WALKLDR] = "rbxassetid://99985200261707",
    [StateConstants.STATES.WALKRD] = "rbxassetid://140213617015554",
    [StateConstants.STATES.WALKRDR] = "rbxassetid://104532728852424",
    [StateConstants.STATES.IDLE] = nil,
    [StateConstants.STATES.CROUCH_IDLE] = nil,
    [StateConstants.STATES.CROUCH_IDLE_ARMLESS] = "rbxassetid://82205581852305",
    [StateConstants.STATES.CROUCH_WALK] = "rbxassetid://127966633589974",
    [StateConstants.STATES.CROUCH_WALKR] = "rbxassetid://78070504560071",
    [StateConstants.STATES.CROUCH_WALKL] = "rbxassetid://103855135499865",
    [StateConstants.STATES.CROUCH_WALKRIGHT] = "rbxassetid://127766953760465",
    [StateConstants.STATES.CROUCH_WALKLD] = "rbxassetid://138996766261387",
    [StateConstants.STATES.CROUCH_WALKLDR] = "rbxassetid://88095045138483",
    [StateConstants.STATES.CROUCH_WALKRD] = "rbxassetid://98947022649454",
    [StateConstants.STATES.CROUCH_WALKRDR] = "rbxassetid://94786389328205",
    [StateConstants.STATES.INJURED_WALK] = "rbxassetid://94157175711472",
    [StateConstants.STATES.INJURED_WALKR] = "rbxassetid://125206420066583",
    [StateConstants.STATES.INJURED_WALKL] = "rbxassetid://133797730594655",
    [StateConstants.STATES.INJURED_WALKRIGHT] = "rbxassetid://110481801730065",
    [StateConstants.STATES.INJURED_WALKLD] = "rbxassetid://75873041065059",
    [StateConstants.STATES.INJURED_WALKLDR] = "rbxassetid://139142001094705",
    [StateConstants.STATES.INJURED_WALKRD] = "rbxassetid://140354307829243",
    [StateConstants.STATES.INJURED_WALKRDR] = "rbxassetid://81450366261156"
};
local u3 = {
    [S_Config.ENUMS.ANIMATION_PRIORITY.Movement] = {
        StateConstants.STATES.WALK,
        StateConstants.STATES.WALKR,
        StateConstants.STATES.WALKL,
        StateConstants.STATES.WALKRIGHT,
        StateConstants.STATES.WALKLD,
        StateConstants.STATES.WALKLDR,
        StateConstants.STATES.WALKRD,
        StateConstants.STATES.WALKRDR,
        StateConstants.STATES.CROUCH_IDLE,
        StateConstants.STATES.CROUCH_IDLE_ARMLESS,
        StateConstants.STATES.PRONE_IDLE,
        StateConstants.STATES.CROUCH_WALK,
        StateConstants.STATES.CROUCH_WALKR,
        StateConstants.STATES.CROUCH_WALKL,
        StateConstants.STATES.CROUCH_WALKRIGHT,
        StateConstants.STATES.CROUCH_WALKLD,
        StateConstants.STATES.CROUCH_WALKLDR,
        StateConstants.STATES.CROUCH_WALKRD,
        StateConstants.STATES.CROUCH_WALKRDR,
        StateConstants.STATES.INJURED_WALK,
        StateConstants.STATES.INJURED_WALKR,
        StateConstants.STATES.INJURED_WALKL,
        StateConstants.STATES.INJURED_WALKRIGHT,
        StateConstants.STATES.INJURED_WALKLD,
        StateConstants.STATES.INJURED_WALKLDR,
        StateConstants.STATES.INJURED_WALKRD,
        StateConstants.STATES.INJURED_WALKRDR
    }
};
local u4 = {
    DIAGONAL = {
        MIN = S_Config.ANIMATION_SPEED_LIMITS.DIAGONAL.MIN,
        MAX = S_Config.ANIMATION_SPEED_LIMITS.DIAGONAL.MAX
    },
    NORMAL = {
        MIN = 0.1,
        MAX = 3
    }
};
local WALK_DIRECTION = S_Config.TRANSITION_TIMES.WALK_DIRECTION;

local function createAnimationInstance(p5) -- Line: 69
    if not p5 or p5 == "" then
        return nil;
    end;

    local Animation = Instance.new("Animation");
    Animation.AnimationId = p5;

    return Animation;
end;

local function getTransitionStyle(p6) -- Line: 76
    -- upvalues: StateConstants (copy), S_Config (copy)
    if StateConstants.DIAGONAL_STATE_SET[p6] then
        return Enum.EasingStyle.Sine, Enum.EasingDirection.InOut;
    end;

    return S_Config.ENUMS.EASING_STYLE, S_Config.ENUMS.EASING_DIRECTION;
end;

local function getSpeedLimits(p7) -- Line: 84
    -- upvalues: StateConstants (copy), u4 (copy)
    if StateConstants.DIAGONAL_STATE_SET[p7] then
        return u4.DIAGONAL.MIN, u4.DIAGONAL.MAX;
    end;

    return u4.NORMAL.MIN, u4.NORMAL.MAX;
end;

local function getSmoothingConfig(p8) -- Line: 92
    -- upvalues: StateConstants (copy), WALK_DIRECTION (copy)
    if StateConstants.DIAGONAL_STATE_SET[p8] then
        return WALK_DIRECTION * 1.5;
    end;

    return WALK_DIRECTION;
end;

function u1.new(p9, p10) -- Line: 100
    -- upvalues: u1 (copy)
    return setmetatable({
        currentWalkSpeed = 0,
        lastStateChange = 0,
        _destroyed = false,
        xa = p9,
        transitionManager = p10,
        animations = {},
        _pendingCallbacks = {}
    }, {
        __index = u1
    });
end;

function u1.loadAnimations(u11) -- Line: 113
    -- upvalues: u2 (copy), u3 (copy)
    if u11._destroyed then
        return;
    end;

    u11:_cleanupAnimations();
    u11.animations = {};
    local v12 = 0;

    for i, v in pairs(u2) do
        local u13;

        if v and v ~= "" then
            u13 = Instance.new("Animation");
            u13.AnimationId = v;
        else
            u13 = nil;
        end;

        if u13 then
            local success, result = pcall(function() -- Line: 124
                -- upvalues: u11 (copy), i (copy), u13 (copy)
                return u11.xa:Load(i, u13);
            end);

            if success and result then
                u11.animations[i] = result;
                v12 = v12 + 1;
            else
                warn("[DirAnim] Failed to load animation for state:", i, result);
            end;
        end;
    end;

    for i, v in pairs(u3) do
        local v14 = i;

        for _, v2 in ipairs(v) do
            local v15 = u11.animations[v2];

            if v15 and v15.Track then
                v15.Track.Priority = v14;
            end;
        end;
    end;
end;

function u1.initializeIdle(p16) -- Line: 146
    if p16._destroyed then
        return;
    end;

    for _, v in pairs(p16.animations) do
        if v then
            v:Play();
            v:SetWeight(0);
        end;
    end;
end;

function u1.switchState(p17, p18, p19, p20, p21, p22) -- Line: 158
    -- upvalues: StateConstants (copy), S_Config (copy)
    if p17._destroyed then
        return;
    end;

    local v23 = p22 and 0.01 or (p20 or (not (p17.transitionManager and p17.transitionManager.getTransitionTime) and 0.2 or p17.transitionManager:getTransitionTime(p18, p19)));
    local v24, v25;

    if StateConstants.DIAGONAL_STATE_SET[p18] then
        v24 = Enum.EasingStyle.Sine;
        v25 = Enum.EasingDirection.InOut;
    else
        v24 = S_Config.ENUMS.EASING_STYLE;
        v25 = S_Config.ENUMS.EASING_DIRECTION;
    end;

    for i, v in pairs(p17.animations) do
        if v and v.Blend then
            v:Blend(i == p18 and 1 or 0, v23, v24, v25);
        end;
    end;

    p17.lastStateChange = os.clock();
end;

function u1.switchStateWithOverlay(p26, p27, p28, p29, p30, p31, p32) -- Line: 188
    -- upvalues: StateConstants (copy), S_Config (copy)
    if p26._destroyed then
        return;
    end;

    local math_clamp_ret = math.clamp(p29 or 0, 0, 1);
    local v33 = p32 and 0.01 or (p31 or (not (p26.transitionManager and p26.transitionManager.getTransitionTime) and 0.2 or p26.transitionManager:getTransitionTime(p27, p30)));
    local v34, v35;

    if StateConstants.DIAGONAL_STATE_SET[p27] then
        v34 = Enum.EasingStyle.Sine;
        v35 = Enum.EasingDirection.InOut;
    else
        v34 = S_Config.ENUMS.EASING_STYLE;
        v35 = S_Config.ENUMS.EASING_DIRECTION;
    end;

    for i, v in pairs(p26.animations) do
        if v and v.Blend then
            local v36 = 0;

            if i == p27 then
                v36 = 1 - math_clamp_ret;
            elseif i == p28 then
                v36 = math_clamp_ret;
            end;

            v:Blend(v36, v33, v34, v35);
        end;
    end;

    p26.lastStateChange = os.clock();
end;

function u1.smoothAnimationSpeed(p37, p38, p39, p40) -- Line: 220
    -- upvalues: StateConstants (copy), WALK_DIRECTION (copy), u4 (copy)
    if p37._destroyed then
        return;
    end;

    local v41;

    if StateConstants.DIAGONAL_STATE_SET[p38] then
        v41 = WALK_DIRECTION * 1.5;
    else
        v41 = WALK_DIRECTION;
    end;

    local math_min_ret = math.min(1, p40 / v41);
    p37.currentWalkSpeed = p37.currentWalkSpeed + (p39 - p37.currentWalkSpeed) * math_min_ret;
    local v42, v43;

    if StateConstants.DIAGONAL_STATE_SET[p38] then
        v42 = u4.DIAGONAL.MIN;
        v43 = u4.DIAGONAL.MAX;
    else
        v42 = u4.NORMAL.MIN;
        v43 = u4.NORMAL.MAX;
    end;

    local math_clamp_ret = math.clamp(p37.currentWalkSpeed, v42, v43);
    local v44 = p37.animations[p38];

    if v44 and v44.Track then
        v44.Track:AdjustSpeed(math_clamp_ret);
    end;
end;

function u1._cleanupAnimations(p45) -- Line: 237
    for _, v in pairs(p45.animations or {}) do
        if v then
            if v.Stop then
                pcall(function() -- Line: 240
                    -- upvalues: v (copy)
                    v:Stop();
                end);
            end;

            if v.Track then
                pcall(function() -- Line: 242
                    -- upvalues: v (copy)
                    v.Track:Stop();
                    v.Track:Destroy();
                end);
            end;
        end;
    end;
end;

function u1.destroy(p46) -- Line: 251
    if p46._destroyed then
        return;
    end;

    p46._destroyed = true;
    p46:_cleanupAnimations();

    if p46.animations then
        table.clear(p46.animations);
        p46.animations = nil;
    end;

    p46.xa = nil;
    p46.transitionManager = nil;
    setmetatable(p46, nil);
end;

u1.ANIMATION_IDS = u2;

return u1;