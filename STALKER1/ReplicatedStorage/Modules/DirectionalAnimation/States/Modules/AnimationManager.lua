-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local StateConstants = require(script.Parent.StateConstants)
local S_Config = require(game:GetService("ReplicatedStorage").Modules.DirectionalAnimation.S_Config)
local t2 = {
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
}
local t3 = {
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
}
local t4 = {
	DIAGONAL = {
		MIN = S_Config.ANIMATION_SPEED_LIMITS.DIAGONAL.MIN,
		MAX = S_Config.ANIMATION_SPEED_LIMITS.DIAGONAL.MAX
	},
	NORMAL = {
		MIN = 0.1,
		MAX = 3
	}
}
local WALK_DIRECTION = S_Config.TRANSITION_TIMES.WALK_DIRECTION

local function createAnimationInstance(p1) --[[ createAnimationInstance | Line: 69 ]]
	if p1 and p1 ~= "" then
		local Animation = Instance.new("Animation")

		Animation.AnimationId = p1

		return Animation
	end

	return nil
end

local function getTransitionStyle(p1) --[[ getTransitionStyle | Line: 76 | Upvalues: StateConstants (copy), S_Config (copy) ]]
	if StateConstants.DIAGONAL_STATE_SET[p1] then
		return Enum.EasingStyle.Sine, Enum.EasingDirection.InOut
	end

	return S_Config.ENUMS.EASING_STYLE, S_Config.ENUMS.EASING_DIRECTION
end

local function getSpeedLimits(p1) --[[ getSpeedLimits | Line: 84 | Upvalues: StateConstants (copy), t4 (copy) ]]
	if StateConstants.DIAGONAL_STATE_SET[p1] then
		return t4.DIAGONAL.MIN, t4.DIAGONAL.MAX
	end

	return t4.NORMAL.MIN, t4.NORMAL.MAX
end

local function getSmoothingConfig(p1) --[[ getSmoothingConfig | Line: 92 | Upvalues: StateConstants (copy), WALK_DIRECTION (copy) ]]
	if StateConstants.DIAGONAL_STATE_SET[p1] then
		return WALK_DIRECTION * 1.5
	end

	return WALK_DIRECTION
end

function t.new(p1, p2) --[[ new | Line: 100 | Upvalues: t (copy) ]]
	return setmetatable({
		currentWalkSpeed = 0,
		lastStateChange = 0,
		_destroyed = false,
		xa = p1,
		transitionManager = p2,
		animations = {},
		_pendingCallbacks = {}
	}, {
		__index = t
	})
end
function t.loadAnimations(p1) --[[ loadAnimations | Line: 113 | Upvalues: t2 (copy), t3 (copy) ]]
	if p1._destroyed then
		return
	end

	p1:_cleanupAnimations()
	p1.animations = {}

	local count = 0

	for k, v in pairs(t2) do
		local v1

		if v and v ~= "" then
			local Animation = Instance.new("Animation")

			Animation.AnimationId = v
			v1 = Animation
		else
			v1 = nil
		end

		if v1 then
			local ok, result = pcall(function() --[[ Line: 124 | Upvalues: p1 (copy), k (copy), v1 (copy) ]]
				return p1.xa:Load(k, v1)
			end)

			if ok and result then
				p1.animations[k] = result
				count = count + 1

				continue
			end

			warn("[DirAnim] Failed to load animation for state:", k, result)
		end
	end

	for k, v in pairs(t3) do
		for i, v2 in ipairs(v) do
			local v22 = p1.animations[v2]

			if v22 and v22.Track then
				v22.Track.Priority = k
			end
		end
	end
end
function t.initializeIdle(p1) --[[ initializeIdle | Line: 146 ]]
	if p1._destroyed then
		return
	end

	for k, v in pairs(p1.animations) do
		if v then
			v:Play()
			v:SetWeight(0)
		end
	end
end
function t.switchState(p1, p2, p3, p4, p5, p6) --[[ switchState | Line: 158 | Upvalues: StateConstants (copy), S_Config (copy) ]]
	if p1._destroyed then
		return
	end

	if p6 then
		p4 = 0.01
	elseif not p4 then
		p4 = if p1.transitionManager and p1.transitionManager.getTransitionTime then p1.transitionManager:getTransitionTime(p2, p3) else 0.2
	end

	local v2, v3

	if StateConstants.DIAGONAL_STATE_SET[p2] then
		v2 = Enum.EasingStyle.Sine
		v3 = Enum.EasingDirection.InOut
	else
		v2 = S_Config.ENUMS.EASING_STYLE
		v3 = S_Config.ENUMS.EASING_DIRECTION
	end

	for k, v in pairs(p1.animations) do
		if v and v.Blend then
			v:Blend(if k == p2 then 1 else 0, p4, v2, v3)
		end
	end

	p1.lastStateChange = os.clock()
end
function t.switchStateWithOverlay(p1, p2, p3, p4, p5, p6, p7) --[[ switchStateWithOverlay | Line: 188 | Upvalues: StateConstants (copy), S_Config (copy) ]]
	if p1._destroyed then
		return
	end

	local v1 = math.clamp(p4 or 0, 0, 1)
	local v2

	if p7 then
		v2 = v1
		p6 = 0.01
	elseif p6 then
		v2 = v1
	elseif p1.transitionManager and p1.transitionManager.getTransitionTime then
		v2, p6 = v1, p1.transitionManager:getTransitionTime(p2, p5)
	else
		v2 = v1
		p6 = 0.2
	end

	local v4, v5

	if StateConstants.DIAGONAL_STATE_SET[p2] then
		v4 = Enum.EasingStyle.Sine
		v5 = Enum.EasingDirection.InOut
	else
		v4 = S_Config.ENUMS.EASING_STYLE
		v5 = S_Config.ENUMS.EASING_DIRECTION
	end

	for k, v in pairs(p1.animations) do
		if v and v.Blend then
			local v6 = 0

			if k == p2 then
				v6 = 1 - v2
			elseif k == p3 then
				v6 = v2
			end

			v:Blend(v6, p6, v4, v5)
		end
	end

	p1.lastStateChange = os.clock()
end
function t.smoothAnimationSpeed(p1, p2, p3, p4) --[[ smoothAnimationSpeed | Line: 220 | Upvalues: StateConstants (copy), WALK_DIRECTION (copy), t4 (copy) ]]
	if p1._destroyed then
		return
	end

	p1.currentWalkSpeed = p1.currentWalkSpeed + (p3 - p1.currentWalkSpeed) * math.min(1, p4 / (if StateConstants.DIAGONAL_STATE_SET[p2] then WALK_DIRECTION * 1.5 else WALK_DIRECTION))

	local v3, v4

	if StateConstants.DIAGONAL_STATE_SET[p2] then
		v3 = t4.DIAGONAL.MIN
		v4 = t4.DIAGONAL.MAX
	else
		v3 = t4.NORMAL.MIN
		v4 = t4.NORMAL.MAX
	end

	local v5 = math.clamp(p1.currentWalkSpeed, v3, v4)
	local v6 = p1.animations[p2]

	if not (v6 and v6.Track) then
		return
	end

	v6.Track:AdjustSpeed(v5)
end
function t._cleanupAnimations(p1) --[[ _cleanupAnimations | Line: 237 ]]
	local v1 = pairs

	for v3, v4 in v1(p1.animations or {}) do
		if v4 then
			if v4.Stop then
				pcall(function() --[[ Line: 240 | Upvalues: v4 (copy) ]]
					v4:Stop()
				end)
			end

			if v4.Track then
				pcall(function() --[[ Line: 242 | Upvalues: v4 (copy) ]]
					v4.Track:Stop()
					v4.Track:Destroy()
				end)
			end
		end
	end
end
function t.destroy(p1) --[[ destroy | Line: 251 ]]
	if p1._destroyed then
		return
	end

	p1._destroyed = true
	p1:_cleanupAnimations()

	if p1.animations then
		table.clear(p1.animations)
		p1.animations = nil
	end

	p1.xa = nil
	p1.transitionManager = nil
	setmetatable(p1, nil)
end
t.ANIMATION_IDS = t2

return t