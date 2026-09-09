-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.TypeDefinitions)

local TypeMarshaller = require(script.Parent.TypeMarshaller)
local t = {}

t.__index = t
t.__type = "ActiveCast"

local RunService = game:GetService("RunService")
local Table = require(script.Parent.Table)
local v1 = nil

local function GetFastCastVisualizationContainer() --[[ GetFastCastVisualizationContainer | Line: 61 ]]
	local FastCastVisualizationObjects = workspace.Terrain:FindFirstChild("FastCastVisualizationObjects")

	if FastCastVisualizationObjects == nil then
		local FastCastVisualizationObjects2 = Instance.new("Folder")

		FastCastVisualizationObjects2.Name = "FastCastVisualizationObjects"
		FastCastVisualizationObjects2.Archivable = false
		FastCastVisualizationObjects2.Parent = workspace.Terrain

		return FastCastVisualizationObjects2
	end

	return FastCastVisualizationObjects
end

local function PrintDebug(p1) --[[ PrintDebug | Line: 79 | Upvalues: v1 (ref) ]]
	if v1.DebugLogging ~= true then
		return
	end

	print(p1)
end

function DbgVisualizeSegment(p1, p2) --[[ DbgVisualizeSegment | Line: 86 | Upvalues: v1 (ref) ]]
	if v1.VisualizeCasts ~= true then
		return nil
	end

	local ConeHandleAdornment = Instance.new("ConeHandleAdornment")

	ConeHandleAdornment.Adornee = workspace.Terrain
	ConeHandleAdornment.CFrame = p1
	ConeHandleAdornment.Height = p2
	ConeHandleAdornment.Color3 = Color3.new()
	ConeHandleAdornment.Radius = 0.25
	ConeHandleAdornment.Transparency = 0.5

	local FastCastVisualizationObjects = workspace.Terrain:FindFirstChild("FastCastVisualizationObjects")
	local v12

	if FastCastVisualizationObjects == nil then
		local FastCastVisualizationObjects2 = Instance.new("Folder")

		FastCastVisualizationObjects2.Name = "FastCastVisualizationObjects"
		FastCastVisualizationObjects2.Archivable = false
		FastCastVisualizationObjects2.Parent = workspace.Terrain
		v12 = FastCastVisualizationObjects2
	else
		v12 = FastCastVisualizationObjects
	end

	ConeHandleAdornment.Parent = v12

	return ConeHandleAdornment
end
function DbgVisualizeHit(p1, p2) --[[ DbgVisualizeHit | Line: 100 | Upvalues: v1 (ref) ]]
	if v1.VisualizeCasts ~= true then
		return nil
	end

	local SphereHandleAdornment = Instance.new("SphereHandleAdornment")

	SphereHandleAdornment.Adornee = workspace.Terrain
	SphereHandleAdornment.CFrame = p1
	SphereHandleAdornment.Radius = 0.4
	SphereHandleAdornment.Transparency = 0.25
	SphereHandleAdornment.Color3 = p2 == false and Color3.new(0.2, 1, 0.5) or Color3.new(255/255, 51/255, 51/255)

	local FastCastVisualizationObjects = workspace.Terrain:FindFirstChild("FastCastVisualizationObjects")
	local v2

	if FastCastVisualizationObjects == nil then
		local FastCastVisualizationObjects2 = Instance.new("Folder")

		FastCastVisualizationObjects2.Name = "FastCastVisualizationObjects"
		FastCastVisualizationObjects2.Archivable = false
		FastCastVisualizationObjects2.Parent = workspace.Terrain
		v2 = FastCastVisualizationObjects2
	else
		v2 = FastCastVisualizationObjects
	end

	SphereHandleAdornment.Parent = v2

	return SphereHandleAdornment
end

local function GetPositionAtTime(p1, p2, p3, p4) --[[ GetPositionAtTime | Line: 120 ]]
	return p2 + p3 * p1 + Vector3.new(p4.X * p1 ^ 2 / 2, p4.Y * p1 ^ 2 / 2, p4.Z * p1 ^ 2 / 2)
end

local function GetVelocityAtTime(p1, p2, p3) --[[ GetVelocityAtTime | Line: 126 ]]
	return p2 + p3 * p1
end

local function GetTrajectoryInfo(p1, p2) --[[ GetTrajectoryInfo | Line: 130 ]]
	assert(if p1.StateInfo.UpdateConnection == nil then false else true, "This ActiveCast has been terminated. It can no longer be used.")

	local v2 = p1.StateInfo.Trajectories[p2]
	local v3 = v2.EndTime - v2.StartTime
	local InitialVelocity = v2.InitialVelocity
	local Acceleration = v2.Acceleration
	local t = {}

	t[1] = v2.Origin + InitialVelocity * v3 + Vector3.new(Acceleration.X * v3 ^ 2 / 2, Acceleration.Y * v3 ^ 2 / 2, Acceleration.Z * v3 ^ 2 / 2)
	t[2] = InitialVelocity + Acceleration * v3

	return t
end

local function GetLatestTrajectoryEndInfo(p1) --[[ GetLatestTrajectoryEndInfo | Line: 143 | Upvalues: GetTrajectoryInfo (copy) ]]
	assert(p1.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

	return GetTrajectoryInfo(p1, #p1.StateInfo.Trajectories)
end

local function CloneCastParams(p1) --[[ CloneCastParams | Line: 148 ]]
	local v1 = RaycastParams.new()

	v1.CollisionGroup = p1.CollisionGroup
	v1.FilterType = p1.FilterType
	v1.FilterDescendantsInstances = p1.FilterDescendantsInstances
	v1.IgnoreWater = p1.IgnoreWater

	return v1
end

local function SendRayHit(p1, p2, p3, p4) --[[ SendRayHit | Line: 157 ]]
	p1.Caster.RayHit:Fire(p1, p2, p3, p4)
end

local function SendRayPierced(p1, p2, p3, p4) --[[ SendRayPierced | Line: 162 ]]
	p1.Caster.RayPierced:Fire(p1, p2, p3, p4)
end

local function SendLengthChanged(p1, p2, p3, p4, p5, p6) --[[ SendLengthChanged | Line: 167 ]]
	p1.Caster.LengthChanged:Fire(p1, p2, p3, p4, p5, p6)
end

local function SimulateCast(p1, p2, p3) --[[ SimulateCast | Line: 173 | Upvalues: v1 (ref), Table (copy) ]]
	assert(if p1.StateInfo.UpdateConnection == nil then false else true, "This ActiveCast has been terminated. It can no longer be used.")

	if v1.DebugLogging == true then
		print("Casting for frame.")
	end

	local v2 = p1.StateInfo.Trajectories[#p1.StateInfo.Trajectories]
	local Origin = v2.Origin
	local v3 = p1.StateInfo.TotalRuntime - v2.StartTime
	local InitialVelocity = v2.InitialVelocity
	local Acceleration = v2.Acceleration
	local v7 = Origin + InitialVelocity * v3 + Vector3.new(Acceleration.X * v3 ^ 2 / 2, Acceleration.Y * v3 ^ 2 / 2, Acceleration.Z * v3 ^ 2 / 2)
	local v8 = p1.StateInfo.TotalRuntime - v2.StartTime
	local StateInfo = p1.StateInfo

	StateInfo.TotalRuntime = StateInfo.TotalRuntime + p2

	local v9 = p1.StateInfo.TotalRuntime - v2.StartTime
	local v13 = Origin + InitialVelocity * v9 + Vector3.new(Acceleration.X * v9 ^ 2 / 2, Acceleration.Y * v9 ^ 2 / 2, Acceleration.Z * v9 ^ 2 / 2)
	local v14 = InitialVelocity + Acceleration * v9
	local v15 = (v13 - v7).Unit * v14.Magnitude * p2
	local WorldRoot = p1.RayInfo.WorldRoot
	local v16 = WorldRoot:Raycast(v7, v15, p1.RayInfo.Parameters)
	local Air = Enum.Material.Air

	Vector3.new()

	local v17, v18

	if v16 == nil then
		v17 = v13
		v18 = nil
	else
		v17 = v16.Position
		v18 = v16.Instance

		local Material = v16.Material
		local Normal = v16.Normal
	end

	local Magnitude = (v17 - v7).Magnitude

	p1.Caster.LengthChanged:Fire(p1, v7, v15.Unit, Magnitude, v14, p1.RayInfo.CosmeticBulletObject)

	local StateInfo2 = p1.StateInfo

	StateInfo2.DistanceCovered = StateInfo2.DistanceCovered + Magnitude

	local v19 = if p2 > 0 then DbgVisualizeSegment(CFrame.new(v7, v7 + v15), Magnitude) else nil

	if v18 and v18 ~= p1.RayInfo.CosmeticBulletObject then
		tick()

		if v1.DebugLogging == true then
			print("Hit something, testing now.")
		end

		if p1.RayInfo.CanPierceCallback ~= nil then
			if p3 == false and p1.StateInfo.IsActivelySimulatingPierce then
				p1:Terminate()
				error("ERROR: The latest call to CanPierceCallback took too long to complete! This cast is going to suffer desyncs which WILL cause unexpected behavior and errors. Please fix your performance problems, or remove statements that yield (e.g. wait() calls)")
			end

			p1.StateInfo.IsActivelySimulatingPierce = true
		end

		if p1.RayInfo.CanPierceCallback == nil or p1.RayInfo.CanPierceCallback ~= nil and p1.RayInfo.CanPierceCallback(p1, v16, v14, p1.RayInfo.CosmeticBulletObject) == false then
			if v1.DebugLogging == true then
				print("Piercing function is nil or it returned FALSE to not pierce this hit.")
			end

			p1.StateInfo.IsActivelySimulatingPierce = false

			if p1.StateInfo.HighFidelityBehavior == 2 and (v2.Acceleration ~= Vector3.new() and p1.StateInfo.HighFidelitySegmentSize ~= 0) then
				p1.StateInfo.CancelHighResCast = false

				if p1.StateInfo.IsActivelyResimulating then
					p1:Terminate()
					error("Cascading cast lag encountered! The caster attempted to perform a high fidelity cast before the previous one completed, resulting in exponential cast lag. Consider increasing HighFidelitySegmentSize.")
				end

				p1.StateInfo.IsActivelyResimulating = true

				if v1.DebugLogging == true then
					print("Hit was registered, but recalculation is on for physics based casts. Recalculating to verify a real hit...")
				end

				local v22 = math.floor(Magnitude / p1.StateInfo.HighFidelitySegmentSize)
				local v23 = p2 / v22

				for i = 1, v22 do
					if p1.StateInfo.CancelHighResCast then
						p1.StateInfo.CancelHighResCast = false

						break
					end

					local v24 = v8 + v23 * i
					local v28 = Origin + InitialVelocity * v24 + Vector3.new(Acceleration.X * v24 ^ 2 / 2, Acceleration.Y * v24 ^ 2 / 2, Acceleration.Z * v24 ^ 2 / 2)
					local v29 = InitialVelocity + Acceleration * (v8 + v23 * i)
					local v30 = WorldRoot:Raycast(v28, v29 * p2, p1.RayInfo.Parameters)
					local Magnitude2 = (v28 - (v28 + v29)).Magnitude

					if v30 == nil then
						local v31 = DbgVisualizeSegment(CFrame.new(v28, v28 + v29), Magnitude2)

						if v31 ~= nil then
							v31.Color3 = Color3.new(0.286275, 0.329412, 0.247059)
						end

						continue
					end

					local v32 = DbgVisualizeSegment(CFrame.new(v28, v28 + v29), (v28 - v30.Position).Magnitude)

					if v32 ~= nil then
						v32.Color3 = Color3.new(0.286275, 0.329412, 0.247059)
					end

					if p1.RayInfo.CanPierceCallback == nil or p1.RayInfo.CanPierceCallback ~= nil and p1.RayInfo.CanPierceCallback(p1, v30, v29, p1.RayInfo.CosmeticBulletObject) == false then
						p1.StateInfo.IsActivelyResimulating = false
						p1.Caster.RayHit:Fire(p1, v30, v29, p1.RayInfo.CosmeticBulletObject)
						p1:Terminate()

						local v33 = DbgVisualizeHit(CFrame.new(v17), false)

						if v33 == nil then
							return
						end

						v33.Color3 = Color3.new(0.0588235, 0.87451, 1)

						return
					end

					p1.Caster.RayPierced:Fire(p1, v30, v29, p1.RayInfo.CosmeticBulletObject)

					local v34 = DbgVisualizeHit(CFrame.new(v17), true)

					if v34 ~= nil then
						v34.Color3 = Color3.new(1, 0.113725, 0.588235)
					end

					if v32 ~= nil then
						v32.Color3 = Color3.new(0.305882, 0.243137, 0.329412)
					end
				end

				p1.StateInfo.IsActivelyResimulating = false
			else
				if p1.StateInfo.HighFidelityBehavior == 1 or p1.StateInfo.HighFidelityBehavior == 3 then
					local v35

					if v1.DebugLogging ~= true then
						v35 = p1.RayInfo.CosmeticBulletObject
						p1.Caster.RayHit:Fire(p1, v16, v14, v35)
						p1:Terminate()
						DbgVisualizeHit(CFrame.new(v17), false)

						return
					end

					print("Hit was successful. Terminating.")
					v35 = p1.RayInfo.CosmeticBulletObject
					p1.Caster.RayHit:Fire(p1, v16, v14, v35)
					p1:Terminate()
					DbgVisualizeHit(CFrame.new(v17), false)

					return
				end

				p1:Terminate()
				error("Invalid value " .. p1.StateInfo.HighFidelityBehavior .. " for HighFidelityBehavior.")
			end
		else
			if v1.DebugLogging == true then
				print("Piercing function returned TRUE to pierce this part.")
			end

			if v19 ~= nil then
				v19.Color3 = Color3.new(0.4, 0.05, 0.05)
			end

			DbgVisualizeHit(CFrame.new(v17), true)

			local Parameters = p1.RayInfo.Parameters
			local FilterDescendantsInstances = Parameters.FilterDescendantsInstances
			local t = {}
			local v36 = false
			local v37 = 0
			local v38

			while true do
				if Parameters.FilterType == Enum.RaycastFilterType.Blacklist then
					local FilterDescendantsInstances2 = Parameters.FilterDescendantsInstances

					Table.insert(FilterDescendantsInstances2, v16.Instance)
					Table.insert(t, v16.Instance)
					Parameters.FilterDescendantsInstances = FilterDescendantsInstances2
				else
					local FilterDescendantsInstances2 = Parameters.FilterDescendantsInstances

					Table.removeObject(FilterDescendantsInstances2, v16.Instance)
					Table.insert(t, v16.Instance)
					Parameters.FilterDescendantsInstances = FilterDescendantsInstances2
				end

				p1.Caster.RayPierced:Fire(p1, v16, v14, p1.RayInfo.CosmeticBulletObject)

				local v39 = WorldRoot:Raycast(v7, v15, Parameters)

				if v39 == nil then
					v38 = v39

					break
				end

				if v37 >= 100 then
					warn("WARNING: Exceeded maximum pierce test budget for a single ray segment (attempted to test the same segment " .. 100 .. " times!)")
					v38 = v39

					break
				end

				if p1.RayInfo.CanPierceCallback(p1, v39, v14, p1.RayInfo.CosmeticBulletObject) == false then
					v36 = true
					v38 = v39

					break
				end

				v16, v37 = v39, v37 + 1
			end

			p1.RayInfo.Parameters.FilterDescendantsInstances = FilterDescendantsInstances
			p1.StateInfo.IsActivelySimulatingPierce = false

			if v36 then
				local v41 = "Broke because the ray hit something solid (" .. tostring(v38.Instance) .. ") while testing for a pierce. Terminating the cast."
				local v42

				if v1.DebugLogging ~= true then
					v42 = p1.RayInfo.CosmeticBulletObject
					p1.Caster.RayHit:Fire(p1, v38, v14, v42)
					p1:Terminate()
					DbgVisualizeHit(CFrame.new(v38.Position), false)

					return
				end

				print(v41)
				v42 = p1.RayInfo.CosmeticBulletObject
				p1.Caster.RayHit:Fire(p1, v38, v14, v42)
				p1:Terminate()
				DbgVisualizeHit(CFrame.new(v38.Position), false)

				return
			end
		end
	end

	if not (p1.StateInfo.DistanceCovered >= p1.RayInfo.MaxDistance) then
		return
	end

	p1:Terminate()
	DbgVisualizeHit(CFrame.new(v13), false)
end

function t.new(p1, p2, p3, p4, p5) --[[ new | Line: 422 | Upvalues: TypeMarshaller (copy), Table (copy), RunService (copy), t (copy), v1 (ref), SimulateCast (copy) ]]
	if TypeMarshaller(p4) == "number" then
		p4 = p3.Unit * p4
	end

	if p5.HighFidelitySegmentSize <= 0 then
		error("Cannot set FastCastBehavior.HighFidelitySegmentSize <= 0!", 0)
	end

	local t2 = {
		Caster = p1,
		StateInfo = {
			UpdateConnection = nil,
			Paused = false,
			TotalRuntime = 0,
			DistanceCovered = 0,
			IsActivelySimulatingPierce = false,
			IsActivelyResimulating = false,
			CancelHighResCast = false,
			HighFidelitySegmentSize = p5.HighFidelitySegmentSize,
			HighFidelityBehavior = p5.HighFidelityBehavior,
			Trajectories = {
				{
					StartTime = 0,
					EndTime = -1,
					Origin = p2,
					InitialVelocity = p4,
					Acceleration = p5.Acceleration
				}
			}
		},
		RayInfo = {
			Parameters = p5.RaycastParams,
			WorldRoot = workspace,
			MaxDistance = p5.MaxDistance or 1000,
			CosmeticBulletObject = p5.CosmeticBulletTemplate,
			CanPierceCallback = p5.CanPierceFunction
		},
		UserData = {}
	}

	if t2.StateInfo.HighFidelityBehavior == 2 then
		t2.StateInfo.HighFidelityBehavior = 3
	end

	if t2.RayInfo.Parameters == nil then
		t2.RayInfo.Parameters = RaycastParams.new()
	else
		local Parameters = t2.RayInfo.Parameters
		local v12 = RaycastParams.new()

		v12.CollisionGroup = Parameters.CollisionGroup
		v12.FilterType = Parameters.FilterType
		v12.FilterDescendantsInstances = Parameters.FilterDescendantsInstances
		v12.IgnoreWater = Parameters.IgnoreWater
		t2.RayInfo.Parameters = v12
	end

	local v2 = false

	if p5.CosmeticBulletProvider == nil then
		if t2.RayInfo.CosmeticBulletObject ~= nil then
			t2.RayInfo.CosmeticBulletObject = t2.RayInfo.CosmeticBulletObject:Clone()
			t2.RayInfo.CosmeticBulletObject.CFrame = CFrame.new(p2, p2 + p3)
			t2.RayInfo.CosmeticBulletObject.Parent = p5.CosmeticBulletContainer
		end
	elseif TypeMarshaller(p5.CosmeticBulletProvider) == "PartCache" then
		if t2.RayInfo.CosmeticBulletObject ~= nil then
			warn("Do not define FastCastBehavior.CosmeticBulletTemplate and FastCastBehavior.CosmeticBulletProvider at the same time! The provider will be used, and CosmeticBulletTemplate will be set to nil.")
			t2.RayInfo.CosmeticBulletObject = nil
			p5.CosmeticBulletTemplate = nil
		end

		t2.RayInfo.CosmeticBulletObject = p5.CosmeticBulletProvider:GetPart()
		t2.RayInfo.CosmeticBulletObject.CFrame = CFrame.new(p2, p2 + p3)
		v2 = true
	else
		warn("FastCastBehavior.CosmeticBulletProvider was not an instance of the PartCache module (an external/separate model)! Are you inputting an instance created via PartCache.new? If so, are you on the latest version of PartCache? Setting FastCastBehavior.CosmeticBulletProvider to nil.")
		p5.CosmeticBulletProvider = nil
	end

	local v3 = if v2 then p5.CosmeticBulletProvider.CurrentCacheParent else p5.CosmeticBulletContainer

	if p5.AutoIgnoreContainer == true and v3 ~= nil then
		local FilterDescendantsInstances = t2.RayInfo.Parameters.FilterDescendantsInstances

		if Table.find(FilterDescendantsInstances, v3) == nil then
			Table.insert(FilterDescendantsInstances, v3)
			t2.RayInfo.Parameters.FilterDescendantsInstances = FilterDescendantsInstances
		end
	end

	local v4 = if RunService:IsClient() then RunService.RenderStepped else RunService.Heartbeat

	setmetatable(t2, t)
	t2.StateInfo.UpdateConnection = v4:Connect(function(p1) --[[ Line: 535 | Upvalues: t2 (copy), v1 (ref), SimulateCast (ref) ]]
		if t2.StateInfo.Paused then
			return
		end

		if v1.DebugLogging == true then
			print("Casting for frame.")
		end

		local v12 = t2.StateInfo.Trajectories[#t2.StateInfo.Trajectories]

		if t2.StateInfo.HighFidelityBehavior == 3 and (v12.Acceleration ~= Vector3.new() and t2.StateInfo.HighFidelitySegmentSize > 0) then
			local v2 = tick()

			if t2.StateInfo.IsActivelyResimulating then
				t2:Terminate()
				error("Cascading cast lag encountered! The caster attempted to perform a high fidelity cast before the previous one completed, resulting in exponential cast lag. Consider increasing HighFidelitySegmentSize.")
			end

			t2.StateInfo.IsActivelyResimulating = true

			local Origin = v12.Origin
			local v3 = t2.StateInfo.TotalRuntime - v12.StartTime
			local InitialVelocity = v12.InitialVelocity
			local Acceleration = v12.Acceleration
			local v7 = Origin + InitialVelocity * v3 + Vector3.new(Acceleration.X * v3 ^ 2 / 2, Acceleration.Y * v3 ^ 2 / 2, Acceleration.Z * v3 ^ 2 / 2)
			local _ = t2.StateInfo.TotalRuntime - v12.StartTime
			local StateInfo = t2.StateInfo

			StateInfo.TotalRuntime = StateInfo.TotalRuntime + p1

			local v8 = t2.StateInfo.TotalRuntime - v12.StartTime
			local v122 = Origin + InitialVelocity * v8 + Vector3.new(Acceleration.X * v8 ^ 2 / 2, Acceleration.Y * v8 ^ 2 / 2, Acceleration.Z * v8 ^ 2 / 2)
			local v14 = t2.RayInfo.WorldRoot:Raycast(v7, (v122 - v7).Unit * (InitialVelocity + Acceleration * v8).Magnitude * p1, t2.RayInfo.Parameters)
			local Magnitude = ((if v14 == nil then v122 else v14.Position) - v7).Magnitude
			local StateInfo2 = t2.StateInfo

			StateInfo2.TotalRuntime = StateInfo2.TotalRuntime - p1

			local v17 = math.floor(Magnitude / t2.StateInfo.HighFidelitySegmentSize)

			if v17 == 0 then
				v17 = 1
			end

			local v18 = p1 / v17

			for i = 1, v17 do
				if getmetatable(t2) == nil then
					return
				end

				if t2.StateInfo.CancelHighResCast then
					t2.StateInfo.CancelHighResCast = false

					break
				end

				local v20 = "[" .. i .. "] Subcast of time increment " .. v18

				if v1.DebugLogging == true then
					print(v20)
				end

				SimulateCast(t2, v18, true)
			end

			if getmetatable(t2) == nil then
				return
			end

			t2.StateInfo.IsActivelyResimulating = false

			if tick() - v2 > 0.08 then
				warn("Extreme cast lag encountered! Consider increasing HighFidelitySegmentSize.")
			end
		else
			SimulateCast(t2, p1, false)
		end
	end)

	return t2
end
function t.SetStaticFastCastReference(p1) --[[ SetStaticFastCastReference | Line: 619 | Upvalues: v1 (ref) ]]
	v1 = p1
end

local function ModifyTransformation(p1, p2, p3, p4) --[[ ModifyTransformation | Line: 625 | Upvalues: GetTrajectoryInfo (copy), Table (copy) ]]
	local Trajectories = p1.StateInfo.Trajectories
	local v1 = Trajectories[#Trajectories]

	if v1.StartTime == p1.StateInfo.TotalRuntime then
		if p2 == nil then
			p2 = v1.InitialVelocity
		end

		if p3 == nil then
			p3 = v1.Acceleration
		end

		if p4 == nil then
			p4 = v1.Origin
		end

		v1.Origin = p4
		v1.InitialVelocity = p2
		v1.Acceleration = p3
	else
		v1.EndTime = p1.StateInfo.TotalRuntime
		assert(p1.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

		local v3, v4 = unpack((GetTrajectoryInfo(p1, #p1.StateInfo.Trajectories)))

		if p2 == nil then
			p2 = v4
		end

		if p3 == nil then
			p3 = v1.Acceleration
		end

		if p4 == nil then
			p4 = v3
		end

		Table.insert(p1.StateInfo.Trajectories, {
			EndTime = -1,
			StartTime = p1.StateInfo.TotalRuntime,
			Origin = p4,
			InitialVelocity = p2,
			Acceleration = p3
		})
		p1.StateInfo.CancelHighResCast = true
	end
end

function t.SetVelocity(p1, p2) --[[ SetVelocity | Line: 671 | Upvalues: t (copy), ModifyTransformation (copy) ]]
	assert(if getmetatable(p1) == t then true else false, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("SetVelocity", "ActiveCast.new(...)"))
	assert(if p1.StateInfo.UpdateConnection == nil then false else true, "This ActiveCast has been terminated. It can no longer be used.")
	ModifyTransformation(p1, p2, nil, nil)
end
function t.SetAcceleration(p1, p2) --[[ SetAcceleration | Line: 677 | Upvalues: t (copy), ModifyTransformation (copy) ]]
	assert(if getmetatable(p1) == t then true else false, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("SetAcceleration", "ActiveCast.new(...)"))
	assert(if p1.StateInfo.UpdateConnection == nil then false else true, "This ActiveCast has been terminated. It can no longer be used.")
	ModifyTransformation(p1, nil, p2, nil)
end
function t.SetPosition(p1, p2) --[[ SetPosition | Line: 683 | Upvalues: t (copy), ModifyTransformation (copy) ]]
	assert(if getmetatable(p1) == t then true else false, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("SetPosition", "ActiveCast.new(...)"))
	assert(if p1.StateInfo.UpdateConnection == nil then false else true, "This ActiveCast has been terminated. It can no longer be used.")
	ModifyTransformation(p1, nil, nil, p2)
end
function t.GetVelocity(p1) --[[ GetVelocity | Line: 689 | Upvalues: t (copy) ]]
	assert(getmetatable(p1) == t, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("GetVelocity", "ActiveCast.new(...)"))
	assert(p1.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

	local v2 = p1.StateInfo.Trajectories[#p1.StateInfo.Trajectories]

	return v2.InitialVelocity + v2.Acceleration * (p1.StateInfo.TotalRuntime - v2.StartTime)
end
function t.GetAcceleration(p1) --[[ GetAcceleration | Line: 696 | Upvalues: t (copy) ]]
	assert(getmetatable(p1) == t, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("GetAcceleration", "ActiveCast.new(...)"))
	assert(p1.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

	return p1.StateInfo.Trajectories[#p1.StateInfo.Trajectories].Acceleration
end
function t.GetPosition(p1) --[[ GetPosition | Line: 703 | Upvalues: t (copy) ]]
	assert(getmetatable(p1) == t, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("GetPosition", "ActiveCast.new(...)"))
	assert(p1.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

	local v2 = p1.StateInfo.Trajectories[#p1.StateInfo.Trajectories]
	local v3 = p1.StateInfo.TotalRuntime - v2.StartTime
	local Acceleration = v2.Acceleration

	return v2.Origin + v2.InitialVelocity * v3 + Vector3.new(Acceleration.X * v3 ^ 2 / 2, Acceleration.Y * v3 ^ 2 / 2, Acceleration.Z * v3 ^ 2 / 2)
end
function t.AddVelocity(p1, p2) --[[ AddVelocity | Line: 712 | Upvalues: t (copy) ]]
	assert(if getmetatable(p1) == t then true else false, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("AddVelocity", "ActiveCast.new(...)"))
	assert(if p1.StateInfo.UpdateConnection == nil then false else true, "This ActiveCast has been terminated. It can no longer be used.")
	p1:SetVelocity(p1:GetVelocity() + p2)
end
function t.AddAcceleration(p1, p2) --[[ AddAcceleration | Line: 718 | Upvalues: t (copy) ]]
	assert(if getmetatable(p1) == t then true else false, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("AddAcceleration", "ActiveCast.new(...)"))
	assert(if p1.StateInfo.UpdateConnection == nil then false else true, "This ActiveCast has been terminated. It can no longer be used.")
	p1:SetAcceleration(p1:GetAcceleration() + p2)
end
function t.AddPosition(p1, p2) --[[ AddPosition | Line: 724 | Upvalues: t (copy) ]]
	assert(if getmetatable(p1) == t then true else false, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("AddPosition", "ActiveCast.new(...)"))
	assert(if p1.StateInfo.UpdateConnection == nil then false else true, "This ActiveCast has been terminated. It can no longer be used.")
	p1:SetPosition(p1:GetPosition() + p2)
end
function t.Pause(p1) --[[ Pause | Line: 732 | Upvalues: t (copy) ]]
	assert(getmetatable(p1) == t, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Pause", "ActiveCast.new(...)"))
	assert(p1.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")
	p1.StateInfo.Paused = true
end
function t.Resume(p1) --[[ Resume | Line: 738 | Upvalues: t (copy) ]]
	assert(getmetatable(p1) == t, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Resume", "ActiveCast.new(...)"))
	assert(p1.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")
	p1.StateInfo.Paused = false
end
function t.Terminate(p1) --[[ Terminate | Line: 744 | Upvalues: t (copy) ]]
	assert(getmetatable(p1) == t, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Terminate", "ActiveCast.new(...)"))
	assert(p1.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

	local Trajectories = p1.StateInfo.Trajectories

	Trajectories[#Trajectories].EndTime = p1.StateInfo.TotalRuntime
	p1.StateInfo.UpdateConnection:Disconnect()
	p1.Caster.CastTerminating:FireSync(p1)
	p1.StateInfo.UpdateConnection = nil
	p1.Caster = nil
	p1.StateInfo = nil
	p1.RayInfo = nil
	p1.UserData = nil
	setmetatable(p1, nil)
end

return t