-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local StateConstants = require(script.Parent.StateConstants)
local S_Config = require(game:GetService("ReplicatedStorage").Modules.DirectionalAnimation.S_Config)
local t2 = {}

function t.new() --[[ new | Line: 19 | Upvalues: S_Config (copy), t (copy), t2 (copy), StateConstants (copy) ]]
	local v1 = setmetatable({
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
	}, {
		__index = t
	})

	if t2[1] then
		return v1
	end

	t2[1] = StateConstants.STATES.WALK
	t2[2] = StateConstants.STATES.WALKR
	t2[3] = StateConstants.STATES.WALKL
	t2[4] = StateConstants.STATES.WALKRIGHT
	t2[5] = StateConstants.STATES.WALKLD
	t2[6] = StateConstants.STATES.WALKLDR
	t2[7] = StateConstants.STATES.WALKRD
	t2[8] = StateConstants.STATES.WALKRDR

	return v1
end
function t.setControls(p1, p2) --[[ setControls | Line: 49 ]]
	p1.controls = p2
end
function t.hasMovementInput(p1) --[[ hasMovementInput | Line: 53 | Upvalues: S_Config (copy) ]]
	if not p1.controls then
		return false
	end

	local v1 = p1.controls:GetMoveVector()
	local Magnitude = v1.Magnitude

	p1._lastMoveVector = v1
	p1._lastMoveVectorMagnitude = Magnitude

	return S_Config.THRESHOLDS.INPUT < Magnitude
end
function t._getDirection(p1) --[[ _getDirection | Line: 62 ]]
	if not p1.controls then
		return 0
	end

	local _lastMoveVector = p1._lastMoveVector

	if p1._lastMoveVectorMagnitude == 0 then
		local v1 = p1.controls:GetMoveVector()

		p1._lastMoveVector = v1
		p1._lastMoveVectorMagnitude = v1.Magnitude
		_lastMoveVector = v1
	end

	if not p1._camera then
		p1._camera = p1._workspace.CurrentCamera
	end

	local v2 = math.abs(_lastMoveVector.X)
	local v3 = math.abs(_lastMoveVector.Z)
	local _cachedThresholds = p1._cachedThresholds
	local diagonal = _cachedThresholds.diagonal

	if p1._lastDirection >= 5 then
		diagonal = diagonal * 0.8
	end

	if if diagonal < v2 then if diagonal < v3 then true else false else false then
		local directional = _cachedThresholds.directional

		if _lastMoveVector.X < -diagonal and _lastMoveVector.Z < -directional then
			return 5
		end

		if _lastMoveVector.X < -diagonal and directional < _lastMoveVector.Z then
			return 6
		end

		if diagonal < _lastMoveVector.X and _lastMoveVector.Z < -directional then
			return 7
		end

		if diagonal < _lastMoveVector.X and directional < _lastMoveVector.Z then
			return 8
		end

		return 1
	end

	local sideways = _cachedThresholds.sideways
	local directional = _cachedThresholds.directional

	if _lastMoveVector.Z > 0 then
		return 2
	end

	if _lastMoveVector.X < -sideways and v3 < directional then
		return 3
	end

	if sideways < _lastMoveVector.X and v3 < directional then
		return 4
	end

	return 1
end
function t.determineWalkState(p1) --[[ determineWalkState | Line: 115 | Upvalues: t2 (copy), StateConstants (copy) ]]
	local v1 = p1:_getDirection()

	p1._lastDirection = v1

	return t2[v1] or StateConstants.STATES.WALK
end
function t.getMovementFlags(p1) --[[ getMovementFlags | Line: 121 ]]
	local _lastDirection = p1._lastDirection
	local t = {}

	t.isWalkingBackwards = _lastDirection == 2
	t.isWalkingLeft = _lastDirection == 3
	t.isWalkingRight = _lastDirection == 4
	t.isDiagonal = _lastDirection >= 5

	return t
end
function t.destroy(p1) --[[ destroy | Line: 131 ]]
	p1.controls = nil
	p1._userInputService = nil
	p1._workspace = nil
	p1._camera = nil
	p1._lastMoveVector = nil
	p1._lastMoveVectorMagnitude = 0
end

return t