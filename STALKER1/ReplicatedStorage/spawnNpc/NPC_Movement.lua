-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SimplePath = require(ReplicatedStorage.SimplePath)

function t.New(p1) --[[ New | Line: 6 | Upvalues: SimplePath (copy) ]]
	local t = {}
	local npcConfig = p1.npcConfig
	local v1 = SimplePath.new(p1.CharacterAsset)
	local v2 = false

	function t.StopMoving() --[[ StopMoving | Line: 12 | Upvalues: v2 (ref), v1 (copy), SimplePath (ref), p1 (copy) ]]
		v2 = false

		if v1.Status == SimplePath.StatusType.Active then
			pcall(function() --[[ Line: 17 | Upvalues: v1 (ref) ]]
				v1:Stop()
			end)
		end

		p1.Humanoid:MoveTo(p1.HumanoidRootPart.Position)
	end
	function t.WalkTo(p12, p2) --[[ WalkTo | Line: 22 | Upvalues: v2 (ref), v1 (copy), p1 (copy) ]]
		if not p12 then
			return
		end

		if p2 then
			v2 = true
			v1:Run(p12)
		else
			p1.Humanoid:MoveTo(p12)
		end
	end
	function t.CheckLOSFromPosition(p12, p2) --[[ CheckLOSFromPosition | Line: 32 | Upvalues: p1 (copy) ]]
		local v1 = RaycastParams.new()

		v1.FilterType = Enum.RaycastFilterType.Exclude
		v1.FilterDescendantsInstances = { p1.CharacterAsset }

		if p1.CharacterAsset.Target.Value then
			v1.FilterDescendantsInstances = { p1.CharacterAsset, p1.CharacterAsset.Target.Value }
		end

		local v2 = p2 - p12

		return workspace:Raycast(p12, v2.Unit * v2.Magnitude, v1) == nil
	end
	function t.GetDistToTarget() --[[ GetDistToTarget | Line: 44 | Upvalues: p1 (copy) ]]
		local Target = p1.CharacterAsset.Target.Value

		if Target and Target:FindFirstChild("HumanoidRootPart") then
			return (Target.HumanoidRootPart.Position - p1.HumanoidRootPart.Position).Magnitude
		end

		return (1 / 0)
	end
	function t.FindFlankPosition() --[[ FindFlankPosition | Line: 52 | Upvalues: p1 (copy), npcConfig (copy), t (copy) ]]
		local Target = p1.CharacterAsset.Target.Value

		if not (Target and Target:FindFirstChild("HumanoidRootPart")) then
			return nil
		end

		local Position = Target.HumanoidRootPart.Position
		local Position2 = p1.HumanoidRootPart.Position
		local v1 = RaycastParams.new()

		v1.FilterDescendantsInstances = { p1.CharacterAsset }

		local v2 = npcConfig.IdealMinRange + 5
		local v3 = nil

		for i = 0, 315, 45 do
			local v4 = math.rad(i)
			local v7 = Position + Vector3.new(math.cos(v4) * v2, 0, math.sin(v4) * v2)
			local v8 = workspace:Raycast(v7 + Vector3.new(0, 5, 0), Vector3.new(0, -15, 0), v1)

			if v8 then
				local v10 = Vector3.new(v7.X, v8.Position.Y + 3, v7.Z)

				if t.CheckLOSFromPosition(v10, Position) and (v3 == nil or (v10 - Position2).Magnitude < (v3 - Position2).Magnitude) then
					v3 = v10
				end
			end
		end

		return v3
	end
	function t.Strafe() --[[ Strafe | Line: 80 | Upvalues: p1 (copy), t (copy) ]]
		local Target = p1.CharacterAsset.Target.Value

		if not (Target and Target:FindFirstChild("HumanoidRootPart")) then
			return
		end

		local v1 = math.random(2) == 1 and p1.HumanoidRootPart.CFrame.RightVector or -p1.HumanoidRootPart.CFrame.RightVector
		local Position = p1.HumanoidRootPart.Position
		local v2 = RaycastParams.new()

		v2.FilterDescendantsInstances = { p1.CharacterAsset }

		local v3 = 4

		for i = 1, 4 do
			if workspace:Raycast(Position, v1 * (i * 2), v2) or not workspace:Raycast(Position + v1 * (i * 2), Vector3.new(0, -7, 0), v2) then
				break
			end

			v3 = i * 2
		end

		if not (v3 >= 4) then
			return
		end

		local v4 = Position + v1 * v3

		if not t.CheckLOSFromPosition(v4 + Vector3.new(0, 2, 0), Target.HumanoidRootPart.Position) then
			return
		end

		p1.Humanoid:MoveTo(v4)
	end
	function t.FindNearestTarget(p12, p2) --[[ FindNearestTarget | Line: 111 | Upvalues: npcConfig (copy), p1 (copy) ]]
		local v1 = nil
		local MaximumMagnitude = npcConfig.MaximumMagnitude
		local v2 = if (npcConfig.AllyTag or "") == "LONER_FACTION" then true else false
		local Target = p1.CharacterAsset.Target.Value

		local function checkCandidate(p12) --[[ checkCandidate | Line: 126 | Upvalues: p1 (ref), p2 (copy), MaximumMagnitude (ref), v1 (ref) ]]
			if not p12:FindFirstChild("HumanoidRootPart") or (not p12:FindFirstChild("Humanoid") or (not (p12.Humanoid.Health > 0) or (p12 == p1.CharacterAsset or p2(p12)))) then
				return
			end

			local Magnitude = (p12.HumanoidRootPart.Position - p1.HumanoidRootPart.Position).Magnitude

			if not (Magnitude < MaximumMagnitude) then
				return
			end

			v1 = p12
			MaximumMagnitude = Magnitude
		end

		for k, v in pairs(game.Players:GetPlayers()) do
			if v.Character and (not v2 or v.Character == Target) then
				checkCandidate(v.Character)
			end
		end

		if p12 then
			for k, v in pairs(workspace.PlayerCharacters.NPCs:GetChildren()) do
				checkCandidate(v)
			end

			for k, v in pairs(workspace.PlayerCharacters.HostileNPCs:GetChildren()) do
				checkCandidate(v)
			end
		end

		return v1
	end
	t.IdealMinRange = npcConfig.IdealMinRange
	t.IdealMaxRange = npcConfig.IdealMaxRange
	t.TooCloseRange = npcConfig.TooCloseRange

	return t
end

return t