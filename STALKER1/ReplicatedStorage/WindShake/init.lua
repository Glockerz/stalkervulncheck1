-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local Settings = require(script.Settings)
local VectorMap = require(script.VectorMap)
local v1 = Instance.new("BindableEvent")
local v2 = Instance.new("BindableEvent")
local v3 = Instance.new("BindableEvent")
local v4 = Instance.new("BindableEvent")
local v5 = Instance.new("BindableEvent")

return {
	RenderDistance = 350,
	MaxRefreshRate = 1 / 60,
	Handled = 0,
	Active = 0,
	SharedSettings = Settings.new(script),
	ObjectMetadata = {},
	VectorMap = VectorMap.new(),
	_partList = table.create(500),
	_cframeList = table.create(500),
	ObjectShakeAdded = v1.Event,
	ObjectShakeRemoved = v2.Event,
	ObjectShakeUpdated = v3.Event,
	Paused = v4.Event,
	Resumed = v5.Event,
	Connect = function(p1, p2, p3) --[[ Connect | Line: 62 ]]
		local v1 = p1[p2]

		assert(if typeof(v1) == "function" then true else false, "Unknown function: " .. p2)

		return p3:Connect(function(...) --[[ Line: 66 | Upvalues: v1 (copy), p1 (copy) ]]
			return v1(p1, ...)
		end)
	end,
	AddObjectShake = function(p1, p2, p3) --[[ AddObjectShake | Line: 71 | Upvalues: Settings (copy), v1 (copy) ]]
		if typeof(p2) ~= "Instance" then
			return
		end

		if not (p2:IsA("BasePart") or p2:IsA("Bone")) then
			return
		end

		local ObjectMetadata = p1.ObjectMetadata

		if ObjectMetadata[p2] then
			return
		end

		p1.Handled = p1.Handled + 1

		local t = {}

		t.ChunkKey = p1.VectorMap:AddObject(if p2:IsA("Bone") then p2.WorldPosition else p2.Position, p2)
		t.Settings = Settings.new(p2)
		t.Seed = math.random(5000) * 0.32
		t.Origin = if p2:IsA("Bone") then p2.WorldCFrame else p2.CFrame
		t.LastUpdate = os.clock()
		ObjectMetadata[p2] = t

		if p3 then
			p1:UpdateObjectSettings(p2, p3)
		end

		v1:Fire(p2)
	end,
	RemoveObjectShake = function(p1, p2) --[[ RemoveObjectShake | Line: 107 | Upvalues: v2 (copy) ]]
		if typeof(p2) ~= "Instance" then
			return
		end

		local ObjectMetadata = p1.ObjectMetadata
		local v1 = ObjectMetadata[p2]

		if v1 then
			p1.Handled = p1.Handled - 1
			ObjectMetadata[p2] = nil
			v1.Settings:Destroy()
			p1.VectorMap:RemoveObject(v1.ChunkKey, p2)

			if p2:IsA("BasePart") then
				p2.CFrame = v1.Origin
			elseif p2:IsA("Bone") then
				p2.WorldCFrame = v1.Origin
			end
		end

		v2:Fire(p2)
	end,
	Update = function(p1, p2) --[[ Update | Line: 131 ]]
		debug.profilebegin("WindShake")

		local v1 = 0

		debug.profilebegin("Update")

		local v2 = os.clock()
		local v3 = p2 * 3
		local v4 = math.min(1, p2 * 5)
		local v5 = 0
		local _partList = p1._partList
		local _cframeList = p1._cframeList

		table.clear(_partList)
		table.clear(_cframeList)

		local ObjectMetadata = p1.ObjectMetadata
		local CurrentCamera = workspace.CurrentCamera
		local Position = CurrentCamera.CFrame.Position
		local RenderDistance = p1.RenderDistance
		local MaxRefreshRate = p1.MaxRefreshRate
		local SharedSettings = p1.SharedSettings
		local WindPower = SharedSettings.WindPower
		local WindSpeed = SharedSettings.WindSpeed
		local WindDirection = SharedSettings.WindDirection

		p1.VectorMap:ForEachObjectInView(CurrentCamera, RenderDistance, function(p1, p2) --[[ Line: 161 | Upvalues: ObjectMetadata (copy), Position (copy), RenderDistance (copy), v3 (copy), MaxRefreshRate (copy), v2 (copy), v1 (ref), WindDirection (copy), WindPower (copy), WindSpeed (copy), v4 (copy), v5 (ref), _partList (copy), _cframeList (copy) ]]
			local v12 = ObjectMetadata[p2]
			local v32 = p1 == "Bone"
			local v42 = if v32 then p2.WorldCFrame else p2.CFrame
			local v52 = (Position - v42.Position).Magnitude / RenderDistance
			local v6 = v52 * v52

			if v3 * v6 + MaxRefreshRate >= v2 - (v12.LastUpdate or 0) + 1 / math.random(60, 120) then
				return
			end

			v12.LastUpdate = v2
			v1 = v1 + 1

			local Settings = v12.Settings
			local v7 = Settings.WindDirection or WindDirection

			if v7.Magnitude < 0.00001 then
				return
			end

			local v9 = (Settings.WindPower or WindPower) * 0.2

			if v9 < 0.00001 then
				return
			end

			local v122 = v2 * ((Settings.WindSpeed or WindSpeed) * 0.08)

			if v122 < 0.00001 then
				return
			end

			local Seed = v12.Seed
			local v13 = (math.noise(v122, 0, Seed) + 0.4) * v9
			local v15 = math.clamp(v4 + v6, 0.1, 0.5)
			local v16 = v9 / 3
			local v18 = v12.Origin * (Settings.PivotOffset or CFrame.identity)
			local v19 = v18:VectorToObjectSpace(v7)

			if v32 then
				p2.Transform = p2.Transform:Lerp(CFrame.fromAxisAngle(v19:Cross(Vector3.new(0, 1, 0)), -v13) * CFrame.Angles(math.noise(Seed, 0, v122) * v16, math.noise(Seed, v122, 0) * v16, math.noise(v122, Seed, 0) * v16) + v19 * v13 * v9, v15)

				return
			end

			v5 = v5 + 1
			_partList[v5] = p2
			_cframeList[v5] = v42:Lerp(v18 * CFrame.fromAxisAngle(v19:Cross(Vector3.new(0, 1, 0)), -v13) * CFrame.Angles(math.noise(Seed, 0, v122) * v16, math.noise(Seed, v122, 0) * v16, math.noise(v122, Seed, 0) * v16) * (Settings.PivotOffsetInverse or CFrame.identity) + v7 * v13 * (v9 * 2), v15)
		end)
		p1.Active = v1
		debug.profileend()
		workspace:BulkMoveTo(_partList, _cframeList, Enum.BulkMoveMode.FireCFrameChanged)
		debug.profileend()
	end,
	Pause = function(p1) --[[ Pause | Line: 247 | Upvalues: v4 (copy) ]]
		if p1.UpdateConnection then
			p1.UpdateConnection:Disconnect()
			p1.UpdateConnection = nil
		end

		p1.Active = 0
		p1.Running = false
		v4:Fire()
	end,
	Resume = function(p1) --[[ Resume | Line: 259 | Upvalues: RunService (copy), v5 (copy) ]]
		if not p1.Running then
			p1.Running = true
			p1.UpdateConnection = p1:Connect("Update", RunService.Heartbeat)
			v5:Fire()
		end
	end,
	Init = function(p1, p2) --[[ Init | Line: 272 | Upvalues: CollectionService (copy) ]]
		if p1.Initialized then
			return
		end

		local v1 = script:GetAttribute("WindPower")
		local v2 = script:GetAttribute("WindSpeed")
		local v3 = script:GetAttribute("WindDirection")

		if typeof(v1) ~= "number" then
			script:SetAttribute("WindPower", 0.34)
		end

		if typeof(v2) ~= "number" then
			script:SetAttribute("WindSpeed", 7.4)
		end

		if typeof(v3) ~= "Vector3" then
			script:SetAttribute("WindDirection", Vector3.new(0.47, 0.12, 0.63))
		end

		p1:Cleanup()
		p1.Initialized = true
		p1.AddedConnection = p1:Connect("AddObjectShake", (CollectionService:GetInstanceAddedSignal("WindShake")))
		p1.RemovedConnection = p1:Connect("RemoveObjectShake", (CollectionService:GetInstanceRemovedSignal("WindShake")))

		for v4, v5 in CollectionService:GetTagged("WindShake") do
			p1:AddObjectShake(v5)
		end

		if p2 and p2.MatchWorkspaceWind then
			p1:MatchWorkspaceWind()
			p1.WorkspaceWindConnection = workspace:GetPropertyChangedSignal("GlobalWind"):Connect(function() --[[ Line: 312 | Upvalues: p1 (copy) ]]
				p1:MatchWorkspaceWind()
			end)
		end

		p1:Resume()
	end,
	Cleanup = function(p1) --[[ Cleanup | Line: 321 ]]
		if not p1.Initialized then
			return
		end

		p1:Pause()

		if p1.AddedConnection then
			p1.AddedConnection:Disconnect()
			p1.AddedConnection = nil
		end

		if p1.RemovedConnection then
			p1.RemovedConnection:Disconnect()
			p1.RemovedConnection = nil
		end

		if p1.WorkspaceWindConnection then
			p1.WorkspaceWindConnection:Disconnect()
			p1.WorkspaceWindConnection = nil
		end

		table.clear(p1.ObjectMetadata)
		p1.VectorMap:ClearAll()
		p1.Handled = 0
		p1.Active = 0
		p1.Initialized = false
	end,
	UpdateObjectSettings = function(p1, p2, p3) --[[ UpdateObjectSettings | Line: 351 | Upvalues: v3 (copy) ]]
		if typeof(p2) ~= "Instance" then
			return
		end

		if typeof(p3) ~= "table" then
			return
		end

		if not p1.ObjectMetadata[p2] and p2 ~= script then
			return
		end

		for v1, v2 in p3 do
			p2:SetAttribute(v1, v2)
		end

		v3:Fire(p2)
	end,
	UpdateAllObjectSettings = function(p1, p2) --[[ UpdateAllObjectSettings | Line: 371 | Upvalues: v3 (copy) ]]
		if typeof(p2) ~= "table" then
			return
		end

		for v1, v2 in p1.ObjectMetadata do
			for v32, v4 in p2 do
				v1:SetAttribute(v32, v4)
			end

			v3:Fire(v1)
		end
	end,
	SetDefaultSettings = function(p1, p2) --[[ SetDefaultSettings | Line: 384 ]]
		p1:UpdateObjectSettings(script, p2)
	end,
	MatchWorkspaceWind = function(p1) --[[ MatchWorkspaceWind | Line: 388 ]]
		local GlobalWind = workspace.GlobalWind
		local Magnitude = GlobalWind.Magnitude
		local v1, v2

		if Magnitude > 0 then
			v1 = if Magnitude > 1 then math.log10(Magnitude) + 0.2 else 0.3
			v2 = if Magnitude < 100 then Magnitude * 1.2 + 5 else 125
		else
			v2 = 0
			v1 = 0
		end

		p1:SetDefaultSettings({
			WindDirection = GlobalWind.Unit,
			WindSpeed = v2,
			WindPower = v1
		})
	end
}