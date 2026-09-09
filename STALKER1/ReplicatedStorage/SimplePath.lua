-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	TIME_VARIANCE = 0.07,
	COMPARISON_CHECKS = 1,
	JUMP_WHEN_STUCK = true
}
local PathfindingService = game:GetService("PathfindingService")
local Players = game:GetService("Players")

local function output(p1, p2) --[[ output | Line: 24 ]]
	p1((if p1 == error then "SimplePath Error: " else "SimplePath: ") .. p2)
end

local t2 = {
	StatusType = {
		Idle = "Idle",
		Active = "Active"
	},
	ErrorType = {
		LimitReached = "LimitReached",
		TargetUnreachable = "TargetUnreachable",
		ComputationError = "ComputationError",
		AgentStuck = "AgentStuck"
	}
}

function t2.__index(p1, p2) --[[ Line: 39 | Upvalues: t2 (copy) ]]
	if p2 == "Stopped" and not p1._humanoid then
		local v1 = error

		v1((if v1 == error then "SimplePath Error: " else "SimplePath: ") .. "Attempt to use Path.Stopped on a non-humanoid.")
	end

	return p1._events[p2] and p1._events[p2].Event or (p2 == "LastError" and p1._lastError or (p2 == "Status" and p1._status or t2[p2]))
end

local Part = Instance.new("Part")

Part.Size = Vector3.new(0.3, 0.3, 0.3)
Part.Anchored = true
Part.CanCollide = false
Part.Material = Enum.Material.Neon
Part.Shape = Enum.PartType.Ball

local function declareError(p1, p2) --[[ declareError | Line: 58 ]]
	p1._lastError = p2
	p1._events.Error:Fire(p2)
end

local function createVisualWaypoints(p1) --[[ createVisualWaypoints | Line: 64 | Upvalues: Part (copy) ]]
	local t = {}

	for i, v in ipairs(p1) do
		local v1 = Part:Clone()

		v1.Position = v.Position
		v1.Parent = workspace
		v1.Color = v == p1[#p1] and Color3.fromRGB(0, 255, 0) or (v.Action == Enum.PathWaypointAction.Jump and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 139, 0))
		table.insert(t, v1)
	end

	return t
end

local function destroyVisualWaypoints(p1) --[[ destroyVisualWaypoints | Line: 80 ]]
	if not p1 then
		return
	end

	for i, v in ipairs(p1) do
		v:Destroy()
	end
end

local function getNonHumanoidWaypoint(p1) --[[ getNonHumanoidWaypoint | Line: 90 ]]
	for i = 2, #p1._waypoints do
		if (p1._waypoints[i].Position - p1._waypoints[i - 1].Position).Magnitude > 0.1 then
			return i
		end
	end

	return 2
end

local function setJumpState(p1) --[[ setJumpState | Line: 101 ]]
	pcall(function() --[[ Line: 102 | Upvalues: p1 (copy) ]]
		if p1._humanoid:GetState() == Enum.HumanoidStateType.Jumping or p1._humanoid:GetState() == Enum.HumanoidStateType.Freefall then
			return
		end

		p1._humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end)
end

local function move(p1) --[[ move | Line: 110 ]]
	if p1._waypoints[p1._currentWaypoint].Action == Enum.PathWaypointAction.Jump then
		pcall(function() --[[ Line: 102 | Upvalues: p1 (copy) ]]
			if p1._humanoid:GetState() == Enum.HumanoidStateType.Jumping or p1._humanoid:GetState() == Enum.HumanoidStateType.Freefall then
				return
			end

			p1._humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end)
	end

	p1._humanoid:MoveTo(p1._waypoints[p1._currentWaypoint].Position)
end

local function disconnectMoveConnection(p1) --[[ disconnectMoveConnection | Line: 118 ]]
	p1._moveConnection:Disconnect()
	p1._moveConnection = nil
end

local function invokeWaypointReached(p1) --[[ invokeWaypointReached | Line: 124 ]]
	p1._events.WaypointReached:Fire(p1._agent, p1._waypoints[p1._currentWaypoint - 1], p1._waypoints[p1._currentWaypoint])
end

local function moveToFinished(p1, p2) --[[ moveToFinished | Line: 130 | Upvalues: t2 (copy) ]]
	if not getmetatable(p1) then
		return
	end

	if p1._humanoid then
		if p2 and p1._currentWaypoint + 1 <= #p1._waypoints then
			if p1._currentWaypoint + 1 < #p1._waypoints then
				p1._events.WaypointReached:Fire(p1._agent, p1._waypoints[p1._currentWaypoint - 1], p1._waypoints[p1._currentWaypoint])
			end

			p1._currentWaypoint = p1._currentWaypoint + 1

			if p1._waypoints[p1._currentWaypoint].Action == Enum.PathWaypointAction.Jump then
				pcall(function() --[[ Line: 102 | Upvalues: p1 (copy) ]]
					if p1._humanoid:GetState() == Enum.HumanoidStateType.Jumping or p1._humanoid:GetState() == Enum.HumanoidStateType.Freefall then
						return
					end

					p1._humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end)
			end

			p1._humanoid:MoveTo(p1._waypoints[p1._currentWaypoint].Position)
		elseif p2 then
			p1._moveConnection:Disconnect()
			p1._moveConnection = nil
			p1._status = t2.StatusType.Idle

			local _visualWaypoints = p1._visualWaypoints

			if _visualWaypoints then
				for i, v in ipairs(_visualWaypoints) do
					v:Destroy()
				end
			end

			p1._visualWaypoints = nil
			p1._events.Reached:Fire(p1._agent, p1._waypoints[p1._currentWaypoint])
		else
			p1._moveConnection:Disconnect()
			p1._moveConnection = nil
			p1._status = t2.StatusType.Idle

			local _visualWaypoints = p1._visualWaypoints

			if _visualWaypoints then
				for i, v in ipairs(_visualWaypoints) do
					v:Destroy()
				end
			end

			p1._visualWaypoints = nil

			local TargetUnreachable = p1.ErrorType.TargetUnreachable

			p1._lastError = TargetUnreachable
			p1._events.Error:Fire(TargetUnreachable)
		end
	else
		if p2 and p1._currentWaypoint + 1 <= #p1._waypoints then
			p1._events.WaypointReached:Fire(p1._agent, p1._waypoints[p1._currentWaypoint - 1], p1._waypoints[p1._currentWaypoint])
			p1._currentWaypoint = p1._currentWaypoint + 1

			return
		end

		if p2 then
			local _visualWaypoints = p1._visualWaypoints

			if _visualWaypoints then
				for i, v in ipairs(_visualWaypoints) do
					v:Destroy()
				end
			end

			p1._visualWaypoints = nil
			p1._target = nil
			p1._events.Reached:Fire(p1._agent, p1._waypoints[p1._currentWaypoint])
		else
			local _visualWaypoints = p1._visualWaypoints

			if _visualWaypoints then
				for i, v in ipairs(_visualWaypoints) do
					v:Destroy()
				end
			end

			p1._visualWaypoints = nil
			p1._target = nil

			local TargetUnreachable = p1.ErrorType.TargetUnreachable

			p1._lastError = TargetUnreachable
			p1._events.Error:Fire(TargetUnreachable)
		end
	end
end

local function comparePosition(p1) --[[ comparePosition | Line: 172 ]]
	if p1._currentWaypoint == #p1._waypoints then
		return
	end

	p1._position._count = (p1._agent.PrimaryPart.Position - p1._position._last).Magnitude <= 0.07 and p1._position._count + 1 or 0
	p1._position._last = p1._agent.PrimaryPart.Position

	if not (p1._position._count >= p1._settings.COMPARISON_CHECKS) then
		return
	end

	if p1._settings.JUMP_WHEN_STUCK then
		pcall(function() --[[ Line: 102 | Upvalues: p1 (copy) ]]
			if p1._humanoid:GetState() == Enum.HumanoidStateType.Jumping or p1._humanoid:GetState() == Enum.HumanoidStateType.Freefall then
				return
			end

			p1._humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end)
	end

	local AgentStuck = p1.ErrorType.AgentStuck

	p1._lastError = AgentStuck
	p1._events.Error:Fire(AgentStuck)
end

function t2.GetNearestCharacter(p1) --[[ GetNearestCharacter | Line: 185 | Upvalues: Players (copy) ]]
	local v1 = (1 / 0)
	local v2 = nil

	for i, v in ipairs(Players:GetPlayers()) do
		if v.Character and (v.Character.PrimaryPart.Position - p1).Magnitude < v1 then
			v2 = v.Character
			v1 = (v.Character.PrimaryPart.Position - p1).Magnitude
		end
	end

	return v2
end
function t2.new(p1, p2, p3) --[[ new | Line: 196 | Upvalues: t (copy), PathfindingService (copy), t2 (copy) ]]
	if not (p1 and (p1:IsA("Model") and p1.PrimaryPart)) then
		local v1 = error

		v1((if v1 == error then "SimplePath Error: " else "SimplePath: ") .. "Pathfinding agent must be a valid Model Instance with a set PrimaryPart.")
	end

	local t3 = {
		_status = "Idle",
		_t = 0
	}

	t3._settings = if p3 then p3 else t
	t3._events = {
		Reached = Instance.new("BindableEvent"),
		WaypointReached = Instance.new("BindableEvent"),
		Blocked = Instance.new("BindableEvent"),
		Error = Instance.new("BindableEvent"),
		Stopped = Instance.new("BindableEvent")
	}
	t3._agent = p1
	t3._humanoid = p1:FindFirstChildOfClass("Humanoid")
	t3._path = PathfindingService:CreatePath(p2)
	t3._position = {
		_count = 0,
		_last = Vector3.new()
	}

	local v5 = setmetatable(t3, t2)

	for k, v in pairs(t) do
		v5._settings[k] = if v5._settings[k] == nil and v then v else v5._settings[k]
	end

	v5._path.Blocked:Connect(function(...) --[[ Line: 227 | Upvalues: v5 (copy) ]]
		if not (v5._currentWaypoint <= ... and (... <= v5._currentWaypoint + 1 and v5._humanoid)) then
			return
		end

		local v1 = v5

		pcall(function() --[[ Line: 102 | Upvalues: v1 (copy) ]]
			if v1._humanoid:GetState() == Enum.HumanoidStateType.Jumping or v1._humanoid:GetState() == Enum.HumanoidStateType.Freefall then
				return
			end

			v1._humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end)
		v5._events.Blocked:Fire(v5._agent, v5._waypoints[...])
	end)

	return v5
end
function t2.Destroy(p1) --[[ Destroy | Line: 239 ]]
	for i, v in ipairs(p1._events) do
		v:Destroy()
	end

	p1._events = nil

	if rawget(p1, "_visualWaypoints") then
		local _visualWaypoints = p1._visualWaypoints

		if _visualWaypoints then
			for i, v in ipairs(_visualWaypoints) do
				v:Destroy()
			end
		end

		p1._visualWaypoints = nil
	end

	p1._path:Destroy()
	setmetatable(p1, nil)

	for k, v in pairs(p1) do
		p1[k] = nil
	end
end
function t2.Stop(p1) --[[ Stop | Line: 254 | Upvalues: t2 (copy) ]]
	if p1._humanoid then
		if p1._status == t2.StatusType.Idle then
			warn(debug.traceback((if function(p1) --[[ Line: 260 ]]
	warn(debug.traceback(p1))
end == error then "SimplePath Error: " else "SimplePath: ") .. "Attempt to run Path:Stop() in idle state"))
		else
			p1._moveConnection:Disconnect()
			p1._moveConnection = nil
			p1._status = t2.StatusType.Idle

			local _visualWaypoints = p1._visualWaypoints

			if _visualWaypoints then
				for i, v in ipairs(_visualWaypoints) do
					v:Destroy()
				end
			end

			p1._visualWaypoints = nil
			p1._events.Stopped:Fire(p1._model)
		end
	else
		local v2 = error

		v2((if v2 == error then "SimplePath Error: " else "SimplePath: ") .. "Attempt to call Path:Stop() on a non-humanoid.")
	end
end
function t2.Run(p1, p2) --[[ Run | Line: 271 | Upvalues: moveToFinished (copy), t2 (copy), comparePosition (copy), createVisualWaypoints (copy), getNonHumanoidWaypoint (copy) ]]
	if not p2 and (not p1._humanoid and p1._target) then
		moveToFinished(p1, true)

		return
	end

	if not p2 or typeof(p2) ~= "Vector3" and not p2:IsA("BasePart") then
		local v1 = error

		v1((if v1 == error then "SimplePath Error: " else "SimplePath: ") .. "Pathfinding target must be a valid Vector3 or BasePart.")
	end

	if os.clock() - p1._t <= p1._settings.TIME_VARIANCE and p1._humanoid then
		task.wait(os.clock() - p1._t)

		local LimitReached = p1.ErrorType.LimitReached

		p1._lastError = LimitReached
		p1._events.Error:Fire(LimitReached)

		return false
	end

	if p1._humanoid then
		p1._t = os.clock()
	end

	local ok, _ = pcall(function() --[[ Line: 294 | Upvalues: p1 (copy), p2 (copy) ]]
		p1._path:ComputeAsync(p1._agent.PrimaryPart.Position, typeof(p2) == "Vector3" and p2 or p2.Position)
	end)

	if ok and (p1._path.Status ~= Enum.PathStatus.NoPath and (not (#p1._path:GetWaypoints() < 2) and (not p1._humanoid or p1._humanoid:GetState() ~= Enum.HumanoidStateType.Freefall))) then
		p1._status = p1._humanoid and t2.StatusType.Active or t2.StatusType.Idle
		p1._target = p2
		pcall(function() --[[ Line: 314 | Upvalues: p1 (copy) ]]
			p1._agent.PrimaryPart:SetNetworkOwner(nil)
		end)
		p1._waypoints = p1._path:GetWaypoints()
		p1._currentWaypoint = 2

		if p1._humanoid then
			comparePosition(p1)
		end

		local _visualWaypoints = p1._visualWaypoints

		if _visualWaypoints then
			for i, v in ipairs(_visualWaypoints) do
				v:Destroy()
			end
		end

		p1._visualWaypoints = p1.Visualize and createVisualWaypoints(p1._waypoints)
		p1._moveConnection = p1._humanoid and (p1._moveConnection or p1._humanoid.MoveToFinished:Connect(function(...) --[[ Line: 332 | Upvalues: moveToFinished (ref), p1 (copy) ]]
			moveToFinished(p1, ...)
		end))

		if p1._humanoid then
			p1._humanoid:MoveTo(p1._waypoints[p1._currentWaypoint].Position)
		elseif #p1._waypoints == 2 then
			p1._target = nil

			local _visualWaypoints2 = p1._visualWaypoints

			if _visualWaypoints2 then
				for i, v in ipairs(_visualWaypoints2) do
					v:Destroy()
				end
			end

			p1._visualWaypoints = nil
			p1._events.Reached:Fire(p1._agent, p1._waypoints[2])
		else
			p1._currentWaypoint = getNonHumanoidWaypoint(p1)
			moveToFinished(p1, true)
		end

		return true
	end

	local _visualWaypoints = p1._visualWaypoints

	if _visualWaypoints then
		for i, v in ipairs(_visualWaypoints) do
			v:Destroy()
		end
	end

	p1._visualWaypoints = nil
	task.wait()

	local ComputationError = p1.ErrorType.ComputationError

	p1._lastError = ComputationError
	p1._events.Error:Fire(ComputationError)

	return false
end

return t2