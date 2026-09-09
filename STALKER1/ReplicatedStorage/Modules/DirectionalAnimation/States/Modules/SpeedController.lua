-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local StateConstants = require(script.Parent.StateConstants)
local S_Config = require(game:GetService("ReplicatedStorage").Modules.DirectionalAnimation.S_Config)

function t.new(p1) --[[ new | Line: 8 | Upvalues: t (copy), S_Config (copy) ]]
	local v1 = setmetatable({}, {
		__index = t
	})

	v1.humanoid = p1
	v1.movementState = {
		isWalkingBackwards = false,
		isWalkingLeft = false,
		isWalkingRight = false,
		isDiagonal = false
	}
	v1.prevPlanarSpeed = 0
	v1.speedDamping = S_Config.PHYSICS.SPEED_DAMPING

	return v1
end
function t.calculatePlanarSpeed(p1, p2) --[[ calculatePlanarSpeed | Line: 22 ]]
	local v2 = math.sqrt(p2.X * p2.X + p2.Z * p2.Z)
	local speedDamping = p1.speedDamping

	if p1.movementState.isDiagonal then
		speedDamping = speedDamping * 0.7
	end

	p1.prevPlanarSpeed = p1.prevPlanarSpeed + (v2 - p1.prevPlanarSpeed) * (1 - speedDamping)

	return p1.prevPlanarSpeed
end
function t.updateMovementFlags(p1, p2) --[[ updateMovementFlags | Line: 32 ]]
	local movementState = p1.movementState

	movementState.isWalkingBackwards = p2.isWalkingBackwards
	movementState.isWalkingLeft = p2.isWalkingLeft
	movementState.isWalkingRight = p2.isWalkingRight
	movementState.isDiagonal = p2.isDiagonal
end
function t.resetMovementFlags(p1) --[[ resetMovementFlags | Line: 40 ]]
	for k, v in pairs(p1.movementState) do
		p1.movementState[k] = false
	end
end
function t.adjustWalkSpeed(p1, p2) --[[ adjustWalkSpeed | Line: 47 ]] end
function t.calculateTargetAnimationSpeed(p1, p2, p3) --[[ calculateTargetAnimationSpeed | Line: 51 | Upvalues: StateConstants (copy), S_Config (copy) ]]
	local v1 = StateConstants.DIAGONAL_STATE_SET[p2] and S_Config.ANIMATION_SPEED_LIMITS.DIAGONAL or S_Config.ANIMATION_SPEED_LIMITS.WALK
	local v2 = if v1 then v1 else {
	MIN = 0.1,
	MAX = 2
}

	return math.clamp(p3 / S_Config.REF_SPEEDS.WALK, v2.MIN, v2.MAX)
end
function t.destroy(p1) --[[ destroy | Line: 59 ]]
	p1.humanoid = nil
end

return t