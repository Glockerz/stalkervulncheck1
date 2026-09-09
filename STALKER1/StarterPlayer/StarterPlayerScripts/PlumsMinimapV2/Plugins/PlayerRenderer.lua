-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Internal = script.Parent.Parent.Internal
local GoodSignal = require(Internal.GoodSignal)

require(Internal.Janitor)
require(Internal.BorderSnap)

local CameraUtils = require(Internal.CameraUtils)
local LocalPlayer = game:GetService("Players").LocalPlayer
local DontRotate = script.Parent.Parent.GeneralSettings.DontRotate

game:GetService("CollectionService")

local RotationCalculator = require(script.Parent.RotationCalculator)
local MinimapRenderer = require(script.Parent.MinimapRenderer)
local t = {
	InitializationPriority = 3,
	Signals = {
		CalculatedPlayerPosition = GoodSignal.new()
	}
}
local t2 = {}

function t.InitializeFrame(p1, p2, p3) --[[ InitializeFrame | Line: 43 | Upvalues: t2 (copy), GoodSignal (copy), LocalPlayer (copy), CameraUtils (copy), MinimapRenderer (copy) ]]
	local v1 = p3:Add(Instance.new("ImageLabel"))

	v1.AnchorPoint = Vector2.new(0.5, 0.5)
	v1.Position = UDim2.fromScale(0.5, 0.5)
	v1.Size = UDim2.fromOffset(30, 30)
	v1.Image = "rbxassetid://" .. 5820620303
	v1.BackgroundTransparency = 1
	v1.ZIndex = 1000

	local CanvasGroup = Instance.new("CanvasGroup")

	CanvasGroup.Size = UDim2.fromScale(1, 1)
	CanvasGroup.BackgroundTransparency = 1
	CanvasGroup.Parent = p1
	CanvasGroup.ZIndex = 502
	v1.Parent = CanvasGroup
	p2.PlayerObj = v1
	t2[p1] = p2
	p2.PlayerPositionCalculated = GoodSignal.new()
	p3:Add(p2.CalculatedCFrame:Connect(function(p12) --[[ Line: 66 | Upvalues: LocalPlayer (ref), p1 (copy), CameraUtils (ref), MinimapRenderer (ref), v1 (copy), p2 (copy) ]]
		local v12 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

		if v12 then
			local AbsoluteSize = p1.AbsoluteSize
			local Position = v12.CFrame.Position
			local v2 = CameraUtils.PointToViewport(p12, 70, MinimapRenderer.WorldToMap((Vector3.new(Position.X, 0, Position.Z))), AbsoluteSize)

			v1.Position = UDim2.fromScale(v2.X / AbsoluteSize.X, v2.Y / AbsoluteSize.Y)
			p2.PlayerPositionCalculated:Fire(Position)
		end
	end))
end

local function getAngleAboutYAxis(p1) --[[ getAngleAboutYAxis | Line: 86 ]]
	local _, _2, _3, v1, _4, v2, _5, _6, _7, v3, _8, v4 = p1:components()

	return math.atan2(v2 - v3, v1 + v4)
end

RotationCalculator.Signals.CalculatedRotation:Connect(function(p1) --[[ Line: 95 | Upvalues: LocalPlayer (copy), t2 (copy), DontRotate (copy) ]]
	local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

	if not v1 then
		return
	end

	local _, _2, _3, v2, _4, v3, _5, _6, _7, v4, _8, v5 = v1.CFrame:components()
	local v7 = math.atan2(v3 - v4, v2 + v5)

	for v8, v9 in t2 do
		local v10 = v8:GetAttribute("DontRotate")

		if v10 then
			v9.PlayerObj.Rotation = -math.deg(v7) - 90

			continue
		end

		if v10 == nil and DontRotate.Value then
			v9.PlayerObj.Rotation = -math.deg(v7) - 90

			continue
		end

		v9.PlayerObj.Rotation = math.deg(p1 - v7) - 90
	end
end)

local v1 = nil
local v2 = nil

game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 137 | Upvalues: LocalPlayer (copy), v1 (ref), v2 (ref), t2 (copy), CameraUtils (copy), MinimapRenderer (copy), DontRotate (copy), RotationCalculator (copy), t (copy) ]]
	local v12 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

	if not v12 then
		v1 = nil
		v2 = nil

		return
	end

	local v22 = v12.CFrame
	local _, _2, _3, v3, _4, v4, _5, _6, _7, v5, _8, v6 = v22:components()
	local v7 = math.atan2(v4 - v5, v3 + v6)
	local Position = v22.Position

	if Position == v2 and v7 == v1 then
		return
	end

	local v8 = v7

	v2 = Position
	v1 = v8

	for v9, v10 in t2 do
		local AbsoluteSize = v10.MinimapFrame.AbsoluteSize
		local v122 = CameraUtils.PointToViewport(v10.Camera.CFrame, 70, MinimapRenderer.WorldToMap((Vector3.new(Position.X, 0, Position.Z))), AbsoluteSize)

		v10.PlayerPositionCalculated:Fire(Position)

		local v13 = v9:GetAttribute("DontRotate")

		if v13 then
			v10.PlayerObj.Rotation = -math.deg(v8) - 90
			v10.PlayerObj.Position = UDim2.fromScale(v122.X / AbsoluteSize.X, v122.Y / AbsoluteSize.Y)

			continue
		end

		if v13 == nil and DontRotate.Value then
			v10.PlayerObj.Rotation = -math.deg(v8) - 90
			v10.PlayerObj.Position = UDim2.fromScale(v122.X / AbsoluteSize.X, v122.Y / AbsoluteSize.Y)

			continue
		end

		v10.PlayerObj.Rotation = math.deg((RotationCalculator.Heading or 0) - v8) - 90
		v10.PlayerObj.Position = UDim2.fromScale(v122.X / AbsoluteSize.X, v122.Y / AbsoluteSize.Y)
	end

	t.Signals.CalculatedPlayerPosition:Fire(Position, v22.LookVector)
end)
function t.CleanupFrame(p1) --[[ CleanupFrame | Line: 193 ]] end

return t