-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local RunService = game:GetService("RunService")

game:GetService("ReplicatedStorage")
game:GetService("StarterPlayer"):WaitForChild("StarterCharacterScripts")

local CurrentCamera = workspace.CurrentCamera
local v1 = nil
local v2 = nil
local v3 = nil
local t2 = {}
local t3 = {}
local t4 = {}
local v4 = 3.75
local v5 = 3.45
local v6 = 0
local v7 = nil

local function updateFocus() --[[ updateFocus | Line: 33 | Upvalues: t2 (ref), v2 (ref), v3 (ref), CurrentCamera (copy), v6 (ref), v5 (ref), v4 (ref), v1 (ref), t3 (ref), v7 (ref) ]]
	local v12 = t2[1]

	if v2.Parent == nil or not v12 then
		v3:Disconnect()

		return
	end

	local v22 = v2.AimPart.CFrame:ToObjectSpace(v12.CFrame)
	local v32 = CFrame.new(v22.Position.X, -v22.Position.Y, 0)
	local v42 = v12.CFrame * CFrame.new(-v12.Size.X / 2, 0, 0) * CFrame.Angles(0, -1.5707963267948966, 0)
	local v62 = CurrentCamera.CFrame:ToObjectSpace(v12.CFrame * CFrame.new(v12.Size.X / 2, 0, 0) * CFrame.Angles(0, -1.5707963267948966, 0) * v32)
	local v72 = v42:ToObjectSpace(CurrentCamera.CFrame)
	local v8 = 1 / v6 * v5
	local v9 = 1 / v6 * v4
	local v10 = v6 * 2 + v62.Position.Z
	local v11 = v12.Size.Y * v10 * v9
	local v122 = v12.Size.Y * 0.5 * (v10 * v9 - 1)
	local v14 = math.tan(-v62.Position.X * v1.focusSensitivity) / v1.eyeboxCurve
	local v16 = math.tan(v62.Position.Y * v1.focusSensitivity) / v1.eyeboxCurve
	local v17 = v14 + v122
	local v18 = v16 + v122
	local v19 = -v62.Position.Z
	local v20 = v12.Size.Y * v19 * v8
	local v21 = v12.Size.Y * 0.5 * (v19 * v8 - 1)
	local v222 = v21 + v72.Position.X
	local v23 = v21 + v72.Position.Y
	local v24 = -math.abs(v14 + v16)
	local v26 = -math.abs(v6 - v19)

	t3[1].OffsetStudsU = v17
	t3[1].OffsetStudsV = v18
	t3[1].StudsPerTileU = v11
	t3[1].StudsPerTileV = v11
	t3[2].OffsetStudsU = v222
	t3[2].OffsetStudsV = v23
	t3[2].StudsPerTileU = v20
	t3[2].StudsPerTileV = v20
	t3[3].Transparency = 1 + v24 * v1.lightSensitivity + v1.lightDeadzone
	t3[4].OffsetStudsU = v17
	t3[4].OffsetStudsV = v18
	t3[4].StudsPerTileU = v11
	t3[4].StudsPerTileV = v11
	t3[4].Transparency = math.max(0, 1 + v24 * v1.ocularCASensitivity + v26 + v1.ocularCADeadzone)
	t3[5].OffsetStudsU = v222
	t3[5].OffsetStudsV = v23
	t3[5].StudsPerTileU = v20
	t3[5].StudsPerTileV = v20
	t3[5].Transparency = 1 + v24 * v1.objectiveCASensitivity + v26 + v1.objectiveCADeadzone

	if not v7 then
		return
	end

	v7.CFrame = v12.CFrame * CFrame.new(v12.Size.X / 2 - v1.glassOffset, 0, 0)

	local Y = v12.Size.Y

	if Y < math.abs(-v62.Position.X) or Y < math.abs(v62.Position.Y) then
		v7.Transparency = 1

		return
	end

	v7.Transparency = v1.glassTransparency
end

function t.start(p1, p2) --[[ start | Line: 119 | Upvalues: t2 (ref), t3 (ref), t4 (ref), v4 (ref), v5 (ref), v2 (ref), v1 (ref), v6 (ref), v7 (ref), v3 (ref), RunService (copy), updateFocus (copy) ]]
	t2 = {}
	t3 = {}
	t4 = {}
	v4 = 3.75
	v5 = 3.45
	v2 = p1

	local Position = (p1.AimPart.CFrame * CFrame.new(0, 0, p2.aimpartZOffset)).Position
	local t = {}

	for v12, v22 in p1:GetDescendants() do
		if v22.Name == "SCOPE_FOCUS" and v22:IsA("BasePart") then
			v1 = require(v22:FindFirstChildWhichIsA("ModuleScript"))
			t2[1] = v22
			t3[1] = v22.OcularLens
			t3[2] = v22.ObjectiveLens
			t3[3] = v22.Light
			t3[4] = v22.OcularCA
			t3[5] = v22.ObjectiveCA
			t3[1].Transparency = 0
			t3[2].Transparency = 0
			v22.Transparency = 1
			v4 = v4 + v1.eyeReliefOffset
			v5 = v5 - v1.eyeReliefOffset
			v4 = v4 * v1.ocularLensScale
			v5 = v5 * v1.objectiveLensScale
			v6 = (Position - (v22.CFrame * CFrame.new(v22.Size.X / 2, 0, 0)).Position).Magnitude
			p2.parentingMethod(v22)

			if v1.useGlassEffect then
				v7 = Instance.new("Part")

				local SpecialMesh = Instance.new("SpecialMesh", v7)

				v7.CFrame = v22.CFrame * CFrame.new(v22.Size.X / 2 - v1.glassOffset, 0, 0)
				v7.Material = Enum.Material.Glass
				v7.Color = v1.glassColor
				v7.Transparency = v1.glassTransparency
				v7.CanCollide = false
				SpecialMesh.MeshType = Enum.MeshType.Sphere

				local Position2 = (v22.CFrame * CFrame.new(v22.Size.X / 2, 0, 0)).Position
				local v32 = v22.Size.Z * ((Position - v7.Position).Magnitude / (Position - Position2).Magnitude)

				v7.Size = Vector3.new(v1.glassZoomFactor * (1 + (v7.Position - Position2).Magnitude ^ 2), v32, v32)
				v7.Parent = p1
			end

			v3 = RunService.PreRender:Connect(updateFocus)
			table.insert(t, v22)
		end
	end

	return t
end

return t