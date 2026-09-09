-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Internal = script.Parent.Parent.Internal
local Janitor = require(Internal.Janitor)
local GoodSignal = require(Internal.GoodSignal)
local CameraUtils = require(Internal.CameraUtils)
local RotationCalculator = require(script.Parent.RotationCalculator)
local PlayerRenderer = require(script.Parent.PlayerRenderer)
local GeneralSettings = script.Parent.Parent.GeneralSettings
local LocalPlayer = game:GetService("Players").LocalPlayer
local t = {
	Signals = {
		SetNewWaypoint = GoodSignal.new()
	},
	InitializationPriority = 5,
	Waypoint = nil
}
local t2 = {}

local function SetNewWaypoint(p1) --[[ SetNewWaypoint | Line: 41 | Upvalues: t (copy), t2 (copy), Janitor (copy), GeneralSettings (copy), RotationCalculator (copy), LocalPlayer (copy), PlayerRenderer (copy) ]]
	t.Waypoint = p1
	t.Signals.SetNewWaypoint:Fire(p1)

	for v1, v2 in t2 do
		local v3 = v2.Janitor:Add(Janitor.new())
		local v4 = v3:Add(GeneralSettings:WaitForChild("Blip"):Clone())

		v4.AnchorPoint = Vector2.new(0.5, 0.5)
		v4.Parent = v2.BlipHolder
		v4.Image = GeneralSettings.WayPoint.Texture

		if v2.Blips.Waypoint then
			v2.Blips.Waypoint.Janitor:Destroy()
		end

		v2.Blips.Waypoint = {
			SnapToBorder = true,
			Rotate = false,
			Position = p1,
			Object = v4,
			Janitor = v3
		}
		v2.CalculatedCFrame:Fire(v2.Camera.CFrame, RotationCalculator.Heading)
	end

	local v5 = Vector3.new(0, 0, 0)
	local v6 = Vector3.new(0, 0, 0)
	local v7 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

	if v7 then
		local v8 = v7.CFrame

		v5 = v8.Position
		v6 = v8.LookVector
	end

	PlayerRenderer.Signals.CalculatedPlayerPosition:Fire(v5, v6)
end

function t.InitializeFrame(p1, p2, p3) --[[ InitializeFrame | Line: 85 | Upvalues: t2 (copy), CameraUtils (copy), t (copy), RotationCalculator (copy), LocalPlayer (copy), PlayerRenderer (copy), SetNewWaypoint (copy) ]]
	t2[p1] = p2

	if not p2.FullmapButton then
		return
	end

	p2.LastClick = 0
	p3:Add(p2.FullmapButton.MouseButton1Click:Connect(function() --[[ Line: 91 | Upvalues: p2 (copy), CameraUtils (ref), t (ref), RotationCalculator (ref), LocalPlayer (ref), PlayerRenderer (ref), SetNewWaypoint (ref) ]]
		if not (tick() - p2.LastClick <= 0.25) then
			p2.LastClick = tick()

			return
		end

		local v2 = CameraUtils.ViewportPointToPlanePoint(p2.Camera.CFrame, p2.Camera.FieldOfView, game:GetService("UserInputService"):GetMouseLocation() - Vector2.new(0, game:GetService("GuiService"):GetInsetArea(Enum.ScreenInsets.TopbarSafeInsets).Height) - p2.FullmapButton.AbsolutePosition, p2.FullmapButton.AbsoluteSize, 0)

		p2.LastClick = 0

		if t.Waypoint and (v2 - t.Waypoint).Magnitude <= 25 then
			if p2.Blips.Waypoint then
				p2.Blips.Waypoint.Janitor:Destroy()
				p2.Blips.Waypoint = nil
			end

			t.Waypoint = nil
			p2.CalculatedCFrame:Fire(p2.Camera.CFrame, RotationCalculator.Heading)

			local v3 = Vector3.new(0, 0, 0)
			local v4 = Vector3.new(0, 0, 0)
			local v5 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

			if v5 then
				local v6 = v5.CFrame

				v3 = v6.Position
				v4 = v6.LookVector
			end

			PlayerRenderer.Signals.CalculatedPlayerPosition:Fire(v3, v4)
		else
			SetNewWaypoint(v2)
		end
	end))
end
function t.CleanupFrame(p1) --[[ CleanupFrame | Line: 134 | Upvalues: t2 (copy) ]]
	t2[p1] = nil
end

return t