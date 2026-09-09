-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Internal = script.Parent.Parent.Internal

require(Internal.Janitor)

local CameraUtils = require(Internal.CameraUtils)
local GeneralSettings = script.Parent.Parent.GeneralSettings
local t = {
	Signals = {},
	InitializationPriority = 4
}
local v1 = nil

function t.InitializeFrame(p1, p2, p3) --[[ InitializeFrame | Line: 34 | Upvalues: GeneralSettings (copy), v1 (ref), LocalPlayer (copy), UserInputService (copy), GuiService (copy), CameraUtils (copy) ]]
	if p1:GetAttribute("FullSize") then
		v1 = p1
		p1:SetAttribute("FocusPoint", Vector3.new(0, 0, 0))
		p1:SetAttribute("DontRotate", true)

		local v12 = p3:Add(Instance.new("ImageButton"))

		v12.Size = UDim2.fromScale(1, 1)
		v12.BorderSizePixel = 0
		v12.BackgroundColor3 = p1.BackgroundColor3
		v12.AutoButtonColor = false
		v12.Parent = p1
		p2.FullmapButton = v12

		local UICorner = p1:FindFirstChildOfClass("UICorner")

		if UICorner then
			UICorner:Clone().Parent = v12
		end

		p2.MouseDown = false
		p2.LastPosition = nil
		p2.OriginalFocusPoint = nil
		p3:Add(v12.InputBegan:Connect(function(p1) --[[ Line: 95 | Upvalues: p2 (copy), UserInputService (ref), v12 (copy), GuiService (ref) ]]
			if p1.UserInputType ~= Enum.UserInputType.MouseButton1 then
				return
			end

			p2.MouseDown = true
			p2.LastPosition = UserInputService:GetMouseLocation() - v12.AbsolutePosition - GuiService:GetGuiInset()
		end))
		p3:Add(v12.InputChanged:Connect(function(p12) --[[ Line: 105 | Upvalues: UserInputService (ref), v12 (copy), GuiService (ref), CameraUtils (ref), p2 (copy), p1 (copy) ]]
			if p12.UserInputType ~= Enum.UserInputType.MouseWheel then
				return
			end

			local v1 = UserInputService:GetMouseLocation() - v12.AbsolutePosition - GuiService:GetGuiInset()
			local v2 = CameraUtils.ViewportPointToPlanePoint(p2.Camera.CFrame, p2.Camera.FieldOfView, v1, v12.AbsoluteSize, 0.05)
			local v7 = math.clamp(p2.Zoom - p12.Position.Z * p2.Zoom * 0.1, 100, p2.BoundingBox.Y / (math.tan((math.rad(p2.Camera.FieldOfView / 2))) * 2) + 100)

			p1:SetAttribute("Zoom", v7)

			local v8 = Vector3.new(p2.FocusPoint.X, v7, p2.FocusPoint.Z)

			p1:SetAttribute("FocusPoint", p2.Camera.CFrame * CFrame.new(p2.Camera.CFrame:VectorToObjectSpace(v2 - CameraUtils.ViewportPointToPlanePoint(CFrame.new(v8, v8 - Vector3.new(0, 1, 0)), p2.Camera.FieldOfView, v1, v12.AbsoluteSize, 0.05))).Position)
		end))
		p3:Add(UserInputService.TouchPan:Connect(function(p12, p22, p3, p4) --[[ Line: 131 | Upvalues: p2 (copy), v12 (copy), p1 (copy) ]]
			local zero = Vector2.zero

			for v1, v2 in p12 do
				zero = zero + v2
			end

			local v3 = zero / #p12

			if p4 == Enum.UserInputState.End then
				p2.TouchPanning = false

				return
			end

			if not p2.TouchPanning then
				return
			end

			if #p12 == 2 then
				local v4 = p2.LastPositionPan - v3

				p2.LastPositionPan = v3

				local v6 = 2 * ((p2.Zoom - 0.05) / math.abs(p2.Camera.CFrame.LookVector.Y))
				local v9 = (p2.Camera.CFrame.RightVector * v4.X + p2.Camera.CFrame.UpVector * -v4.Y) * (v6 * math.tan(math.rad(p2.Camera.FieldOfView) / 2) / v12.AbsoluteSize.Y)
				local v10 = p2.FocusPoint + Vector3.new(v9.X, 0, v9.Z)
				local v17 = Vector3.new(math.clamp(v10.X, p2.Center.X - p2.BoundingBox.X / 2, p2.Center.X + p2.BoundingBox.X / 2), 0, (math.clamp(v10.Z, p2.Center.Y - p2.BoundingBox.Y / 2, p2.Center.Y + p2.BoundingBox.Y / 2)))

				p1:SetAttribute("Zoom", (math.clamp(p2.StartZoom + (p22 - p2.StartScale).Magnitude, 100, p2.BoundingBox.Y / (math.tan((math.rad(p2.Camera.FieldOfView / 2))) * 2) + 100)))
				p1:SetAttribute("FocusPoint", v17)
			end
		end))
		p3:Add(v12.TouchPan:Connect(function(p1, p22, p3, p4) --[[ Line: 181 | Upvalues: p2 (copy) ]]
			local zero = Vector2.zero

			for v1, v2 in p1 do
				zero = zero + v2
			end

			if p4 ~= Enum.UserInputState.Begin then
				return
			end

			p2.LastPositionPan = zero / #p1
			p2.StartZoom = p2.Zoom
			p2.StartScale = p22
			p2.TouchPanning = true
		end))
		p3:Add(UserInputService.InputEnded:Connect(function(p1) --[[ Line: 200 | Upvalues: p2 (copy) ]]
			if p1.UserInputType ~= Enum.UserInputType.MouseButton1 then
				return
			end

			p2.MouseDown = false
		end))
		p3:Add(UserInputService.InputChanged:Connect(function(p12) --[[ Line: 206 | Upvalues: p2 (copy), UserInputService (ref), v12 (copy), GuiService (ref), p1 (copy) ]]
			if not p2.MouseDown then
				return
			end

			if p12.UserInputType ~= Enum.UserInputType.MouseMovement then
				return
			end

			local v1 = UserInputService:GetMouseLocation() - v12.AbsolutePosition - GuiService:GetGuiInset()
			local v2 = v1 - p2.LastPosition

			p2.LastPosition = v1

			local v4 = 2 * ((p2.Zoom - 0.05) / math.abs(p2.Camera.CFrame.LookVector.Y))
			local v7 = (p2.Camera.CFrame.RightVector * -v2.X + p2.Camera.CFrame.UpVector * v2.Y) * (v4 * math.tan(math.rad(p2.Camera.FieldOfView) / 2) / v12.AbsoluteSize.Y)
			local v8 = p2.FocusPoint + Vector3.new(v7.X, 0, v7.Z)

			p1:SetAttribute("FocusPoint", (Vector3.new(math.clamp(v8.X, p2.Center.X - p2.BoundingBox.X / 2, p2.Center.X + p2.BoundingBox.X / 2), 0, (math.clamp(v8.Z, p2.Center.Y - p2.BoundingBox.Y / 2, p2.Center.Y + p2.BoundingBox.Y / 2)))))
		end))
	else
		if not GeneralSettings.OpenFullMapWithClick.Value then
			return
		end

		local v2 = p3:Add(Instance.new("ImageButton"))

		v2.Size = UDim2.fromScale(1, 1)
		v2.BorderSizePixel = 0
		v2.BackgroundColor3 = p1.BackgroundColor3
		v2.AutoButtonColor = false
		v2.Parent = p1

		local UICorner = p1:FindFirstChildOfClass("UICorner")

		if UICorner then
			UICorner:Clone().Parent = v2
		end

		v2.MouseButton1Click:Connect(function() --[[ Line: 50 | Upvalues: v1 (ref), LocalPlayer (ref) ]]
			if not v1 then
				return
			end

			local v12 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

			if v12 then
				v1:SetAttribute("FocusPoint", v12.CFrame.Position)
			end

			v1.Visible = not v1.Visible
		end)
	end
end
function t.CleanupFrame(p1) --[[ CleanupFrame | Line: 237 ]] end

return t