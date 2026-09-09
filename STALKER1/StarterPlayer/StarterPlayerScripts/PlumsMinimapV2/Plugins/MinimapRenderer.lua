-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Internal = script.Parent.Parent.Internal
local GoodSignal = require(Internal.GoodSignal)
local Janitor = require(Internal.Janitor)

game:GetService("RunService")

local LocalPlayer = game:GetService("Players").LocalPlayer
local GeneralSettings = script.Parent.Parent.GeneralSettings
local CurrentMap = GeneralSettings.CurrentMap
local RotationCalculator = require(script.Parent.RotationCalculator)
local t = {
	InitializationPriority = 2,
	Signals = {
		CalculatedCFrameForFrame = GoodSignal.new()
	},
	MapDivisionNumber = 1
}
local t2 = {}

function t.InitializeFrame(p1, p2, p3) --[[ InitializeFrame | Line: 40 | Upvalues: Janitor (copy), t (copy), GoodSignal (copy), GeneralSettings (copy), CurrentMap (copy), t2 (copy) ]]
	local v1 = p3:Add(Janitor.new())
	local v2 = p3:Add(Instance.new("ViewportFrame"))

	v2.Size = UDim2.fromScale(1, 1)
	v2.BackgroundTransparency = 1
	v2.LightColor = Color3.fromRGB(255, 255, 255)
	v2.Ambient = Color3.fromRGB(255, 255, 255)
	v2.LightDirection = Vector3.new(0, 1, 0)
	v2.ZIndex = 100
	v2.Parent = p1

	local UICorner = p1:FindFirstChildOfClass("UICorner")

	if UICorner then
		UICorner:Clone().Parent = v2
	end

	local v3 = p3:Add(Instance.new("Camera"))

	v3.Parent = v2
	v2.CurrentCamera = v3

	local function CreateMap(p1) --[[ CreateMap | Line: 62 | Upvalues: v1 (copy), t (ref), v2 (copy), p2 (copy) ]]
		v1:Cleanup()

		local v12 = 2048

		for v22, v3 in p1:GetChildren() do
			v12 = math.max(v12, v3.Size.Value.X, v3.Size.Value.Z)
		end

		t.MapDivisionNumber = math.max(1, v12 / 2048)

		local zero = Vector2.zero
		local zero2 = Vector2.zero
		local zero3 = Vector2.zero
		local v5 = p1:GetAttribute("Rotation") or 0

		for v6, v7 in p1:GetChildren() do
			local v8 = v1:Add(Instance.new("Part"))
			local v10 = v7.Position.Value.X * math.cos((math.rad(v5)))
			local v122 = v10 - v7.Position.Value.Z * math.sin((math.rad(v5)))
			local v14 = v7.Position.Value.X * math.sin((math.rad(v5)))
			local v17 = Vector3.new(v122, 0, v14 + v7.Position.Value.Z * math.cos((math.rad(v5))))

			v8.Size = Vector3.new(v7.Size.Value.X / t.MapDivisionNumber, 0.1, v7.Size.Value.Z / t.MapDivisionNumber)
			v8.Position = Vector3.new(v17.X / t.MapDivisionNumber, 0, v17.Z / t.MapDivisionNumber)
			v8.Transparency = 1
			v8.Orientation = Vector3.new(0, v7.Rotation.Value, 0)

			if not v7:FindFirstChildOfClass("Decal") then
				error("No image was provided in image data " .. v7:GetFullName())
			end

			local v22 = v1:Add(v7:FindFirstChildOfClass("Decal"):Clone())

			v22.Parent = v8
			v22.Face = Enum.NormalId.Top
			v8.Parent = v2
			v8.Name = v7.Name
			zero3 = zero3 + Vector2.new(v8.Size.X, v8.Size.Z)
			zero2 = zero2 + Vector2.new(v8.Position.X, v8.Position.Z)
			zero = zero + Vector2.new(1, 1)
		end

		p2.BoundingBox = zero3
		p2.Center = zero2 / zero
	end

	p3:Add(p1:GetAttributeChangedSignal("DontRotate"):Connect(function() --[[ Line: 119 | Upvalues: p2 (copy), p1 (copy) ]]
		p2.DontRotate = p1:GetAttribute("DontRotate")
	end))
	p3:Add(p1:GetAttributeChangedSignal("FocusPoint"):Connect(function() --[[ Line: 123 | Upvalues: p2 (copy), p1 (copy) ]]
		p2.FocusPoint = p1:GetAttribute("FocusPoint")
	end))
	p2.ZoomChanged = GoodSignal.new()
	p3:Add(p1:GetAttributeChangedSignal("Zoom"):Connect(function() --[[ Line: 128 | Upvalues: p2 (copy), p1 (copy), GeneralSettings (ref) ]]
		p2.Zoom = p1:GetAttribute("Zoom") or GeneralSettings.Zoom.Value
		p2.ZoomChanged:Fire(p2.Zoom)
	end))
	p2.Camera = v3
	p2.MinimapFrame = v2
	p2.FocusPoint = p1:GetAttribute("FocusPoint")
	p2.DontRotate = p1:GetAttribute("DontRotate")
	p2.Zoom = p1:GetAttribute("Zoom") or GeneralSettings.Zoom.Value
	p2.CalculatedCFrame = GoodSignal.new()
	p2.LastRotation = nil
	p2.LastCFrame = nil
	CreateMap(CurrentMap.Value)
	p3:Add(CurrentMap:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 147 | Upvalues: CreateMap (copy), CurrentMap (ref) ]]
		CreateMap(CurrentMap.Value)
	end))
	t2[p1] = p2
end
function t.CleanupFrame(p1) --[[ CleanupFrame | Line: 155 | Upvalues: t2 (copy) ]]
	t2[p1] = nil
end
function t.WorldToMap(p1) --[[ WorldToMap | Line: 159 | Upvalues: t (copy) ]]
	return p1 / t.MapDivisionNumber
end
function t.WorldToMapVec2(p1) --[[ WorldToMapVec2 | Line: 163 | Upvalues: t (copy) ]]
	local v1 = p1 / t.MapDivisionNumber

	return Vector2.new(v1.X, v1.Z)
end
RotationCalculator.Signals.CalculatedRotation:Connect(function(p1) --[[ Line: 168 | Upvalues: LocalPlayer (copy), t2 (copy), t (copy), GeneralSettings (copy) ]]
	local v1 = Vector3.new(0, 0, 0)
	local v2 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

	if v2 then
		v1 = v2.CFrame.Position
	end

	for v3, v4 in t2 do
		local v5 = nil

		if v3.Visible then
			if v4.FocusPoint then
				v5 = t.WorldToMap((Vector3.new(v4.FocusPoint.X, 0, v4.FocusPoint.Z)))
			elseif not v5 then
				v5 = t.WorldToMap(v1)
			end

			local v9 = Vector3.new(v5.X, v4.Zoom or GeneralSettings.Zoom.Value, v5.Z)
			local DontRotate = v4.DontRotate

			if DontRotate == nil then
				DontRotate = GeneralSettings.DontRotate.Value
			end

			if DontRotate then
				v4.Camera.CFrame = CFrame.new(v9, v9 - Vector3.new(0, 1, 0))
			else
				v4.Camera.CFrame = CFrame.new(v9, v9 - Vector3.new(0, 1, 0)) * CFrame.Angles(0, 0, p1)
			end

			if v4.Camera.CFrame.Position ~= v4.LastCFrame or p1 ~= v4.LastRotation then
				v4.CalculatedCFrame:Fire(v4.Camera.CFrame, p1)
				v4.Rotation = p1
				v4.LastCFrame = v4.Camera.CFrame.Position
				v4.LastRotation = p1
			end
		end
	end
end)

return t