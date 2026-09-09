-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local StateConstants = require(script.Modules.StateConstants)
local MovementDetector = require(script.Modules.MovementDetector)
local AnimationManager = require(script.Modules.AnimationManager)
local TransitionManager = require(script.Modules.TransitionManager)
local SpeedController = require(script.Modules.SpeedController)
local S_Config = require(game:GetService("ReplicatedStorage").Modules.DirectionalAnimation.S_Config)
local Players = game:GetService("Players")

t.STATES = StateConstants.STATES

local function isBadVector3(p1) --[[ isBadVector3 | Line: 18 ]]
	local X = p1.X
	local Y = p1.Y
	local Z = p1.Z

	return if X == X and (Y == Y and (Z == Z and not (math.abs(X) > 1000000 or math.abs(Y) > 1000000))) then math.abs(Z) > 1000000 else true
end

function t.new(p1, p2) --[[ new | Line: 26 | Upvalues: t (copy), MovementDetector (copy), TransitionManager (copy), AnimationManager (copy), SpeedController (copy), StateConstants (copy), S_Config (copy) ]]
	local v1 = setmetatable({}, {
		__index = t
	})

	v1.character = p1
	v1.humanoid = p1:WaitForChild("Humanoid")
	v1.rootPart = p1:WaitForChild("HumanoidRootPart")
	v1.xa = p2
	v1.movementDetector = MovementDetector.new()
	v1.transitionManager = TransitionManager.new()
	v1.animationManager = AnimationManager.new(v1.xa, v1.transitionManager)
	v1.speedController = SpeedController.new(v1.humanoid)
	v1.state = StateConstants.STATES.IDLE
	v1.velocity = Vector3.new(0, 0, 0)
	v1._cachedConstants = {
		MOVEMENT_THRESHOLD = S_Config.THRESHOLDS.MOVEMENT,
		IDLE_STATE = StateConstants.STATES.IDLE
	}
	v1._connections = {}
	v1._destroyed = false
	v1:_initializeControls()

	return v1
end
function t._initializeControls(p1) --[[ _initializeControls | Line: 55 | Upvalues: Players (copy) ]]
	local LocalPlayer = Players.LocalPlayer

	if not LocalPlayer then
		return
	end

	local ok, result = pcall(function() --[[ Line: 59 | Upvalues: LocalPlayer (copy) ]]
		return require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule", 5))
	end)

	if not (ok and result) then
		return
	end

	p1.playerModule = result
	p1.controls = result:GetControls()

	if not (p1.movementDetector and p1.movementDetector.setControls) then
		return
	end

	p1.movementDetector:setControls(p1.controls)
end
function t.loadAnimations(p1) --[[ loadAnimations | Line: 73 ]]
	if not p1._destroyed then
		p1.animationManager:loadAnimations()
		p1.animationManager:initializeIdle()
	end
end
function t.switchState(p1, p2, p3, p4) --[[ switchState | Line: 79 ]]
	if p1._destroyed then
		return
	end

	if p2 == p1.state and not p3 then
		return
	end

	local v1 = p1.transitionManager:getTransitionTime(p2, p1.state)

	if p1._resumingFromSkip and p1._resumingFromSkip > 0 then
		v1 = math.max(v1, 0.5)
	end

	p1.animationManager:switchState(p2, p1.state, v1, p3, p4)
	p1.state = p2
end
function t.update(p1, p2) --[[ update | Line: 92 | Upvalues: S_Config (copy), StateConstants (copy) ]]
	if p1._destroyed then
		return
	end

	p1._dt = p2

	if p1._resumingFromSkip and p1._resumingFromSkip > 0 then
		p1._resumingFromSkip = p1._resumingFromSkip - p2
	end

	if not p1._kaTimer then
		p1._kaTimer = 0
	end

	p1._kaTimer = p1._kaTimer + p2

	if p1._kaTimer > 2 then
		p1._kaTimer = 0

		if S_Config.DEBUG_MODE then
			local v1 = p1.humanoid and p1.humanoid.Health or -1
			local v2 = if p1.humanoid then if v1 >= 80 then 0 elseif v1 <= 20 then 1 else (80 - v1) / 60 or 0 else 0

			print(string.format("[DirAnim] state=%s hp=%.1f injuryOverlay=%.2f", tostring(p1.state), v1, v2))
		end
	end

	local AssemblyLinearVelocity = p1.rootPart.AssemblyLinearVelocity
	local X = AssemblyLinearVelocity.X
	local Y = AssemblyLinearVelocity.Y
	local Z = AssemblyLinearVelocity.Z

	if if X == X and (Y == Y and (Z == Z and not (math.abs(X) > 1000000 or math.abs(Y) > 1000000))) then math.abs(Z) > 1000000 else true then
		return
	end

	p1.velocity = AssemblyLinearVelocity

	local v5 = false
	local v6 = false
	local v7 = if p1.humanoid.Health < 60 then if p1.humanoid.Health > 0 then true else false else false
	local v8 = false

	for v9, v10 in p1.character:GetChildren() do
		if v10:IsA("Tool") then
			v8 = true

			break
		end
	end

	local v11 = p1.character:GetAttribute("Stance") or 0

	if v11 == 2 then
		v5 = true
	elseif v11 == 1 then
		v6 = true
	end

	local v12 = p1.character:GetAttribute("Sprinting") == true

	if not v12 then
		local v13 = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift)

		if v13 and math.sqrt(p1.velocity.X * p1.velocity.X + p1.velocity.Z * p1.velocity.Z) > 11 then
			v12 = true
		end
	end

	if v12 and not v7 then
		v5 = true
	end

	if v5 then
		if p1._skipBlended then
			return
		end

		local v15 = pairs

		for v17, v18 in v15(p1.animationManager.animations or {}) do
			if v18 and v18.Blend then
				v18:Blend(0, 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			end
		end

		p1._skipBlended = true
		p1.state = StateConstants.STATES.IDLE
	else
		if p1._skipBlended then
			p1._skipBlended = false
			p1._resumingFromSkip = 0.5
		end

		local v19 = p1.speedController:calculatePlanarSpeed(p1.velocity)

		if p1._cachedConstants.MOVEMENT_THRESHOLD < v19 then
			p1:_handleWalk(v19, p2, v6, v7)
		else
			p1:_handleIdle(v6, v8)
		end
	end
end

local function calcInjuryOverlay(p1) --[[ calcInjuryOverlay | Line: 211 ]]
	if not p1 or p1.Health <= 0 then
		return 0
	end

	local Health = p1.Health

	if Health >= 80 then
		return 0
	end

	if Health <= 20 then
		return 1
	end

	return (80 - Health) / 60
end

function t._handleWalk(p1, p2, p3, p4, p5) --[[ _handleWalk | Line: 219 | Upvalues: StateConstants (copy) ]]
	if not p1.movementDetector:hasMovementInput() then
		p1:_handleIdle(p4)

		return
	end

	local v1 = p1.movementDetector:determineWalkState()

	p1.speedController:updateMovementFlags(p1.movementDetector:getMovementFlags())

	if p4 then
		local v2 = StateConstants.WALK_TO_CROUCH[v1] or v1

		p1.animationManager:smoothAnimationSpeed(v2, p1.speedController:calculateTargetAnimationSpeed(v2, p2), p3)
		p1:switchState(v2)

		return
	end

	local humanoid = p1.humanoid
	local v4

	if humanoid and not (humanoid.Health <= 0) then
		local Health = humanoid.Health

		v4 = if Health >= 80 then 0 elseif Health <= 20 then 1 else (80 - Health) / 60
	else
		v4 = 0
	end

	local v5 = v4 > 0 and StateConstants.WALK_TO_INJURED[v1] or nil
	local v6 = p1.speedController:calculateTargetAnimationSpeed(v1, p2)

	p1.animationManager:smoothAnimationSpeed(v1, v6, p3)

	if v5 then
		p1.animationManager:smoothAnimationSpeed(v5, v6, p3)
	end

	if v5 then
		if p1._destroyed then
			return
		end

		local v7 = p1.transitionManager:getTransitionTime(v1, p1.state)

		if p1._resumingFromSkip and p1._resumingFromSkip > 0 then
			v7 = math.max(v7, 0.5)
		end

		p1.animationManager:switchStateWithOverlay(v1, v5, v4, p1.state, v7)
		p1.state = v1
		p1._overlayActive = true
	else
		if not p1._overlayActive then
			p1:switchState(v1)

			return
		end

		p1._overlayActive = false

		if p1._destroyed then
			return
		end

		local v9 = p1.transitionManager:getTransitionTime(v1, p1.state)

		if p1._resumingFromSkip and p1._resumingFromSkip > 0 then
			v9 = math.max(v9, 0.5)
		end

		p1.animationManager:switchState(v1, p1.state, v9)
		p1.state = v1
	end
end
function t._handleIdle(p1, p2, p3) --[[ _handleIdle | Line: 286 | Upvalues: StateConstants (copy) ]]
	p1.speedController:resetMovementFlags()
	p1._overlayActive = false

	local IDLE_STATE = p1._cachedConstants.IDLE_STATE

	if p2 then
		IDLE_STATE = StateConstants.STATES.CROUCH_IDLE
	end

	p1:switchState(IDLE_STATE)
end
function t.destroy(p1) --[[ destroy | Line: 298 ]]
	if p1._destroyed then
		return
	end

	p1._destroyed = true

	for i, v in ipairs(p1._connections) do
		if v and v.Connected then
			v:Disconnect()
		end
	end

	table.clear(p1._connections)

	if p1.speedController then
		p1.speedController:destroy()
	end

	if p1.animationManager then
		p1.animationManager:destroy()
	end

	if p1.movementDetector then
		p1.movementDetector:destroy()
	end

	p1.transitionManager = nil
	p1.controls = nil
	p1.playerModule = nil
	p1.character = nil
	p1.humanoid = nil
	p1.rootPart = nil
	p1.xa = nil
	p1._cachedConstants = nil
	setmetatable(p1, nil)
end

return t