-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local t2 = {}

t.__index = t

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local Functions = require(script:WaitForChild("Functions"))
local v1 = true

game.Players.LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 14 | Upvalues: v1 (ref) ]]
	if not v1 then
		return
	end

	v1 = false
end)
function t.New(p1, p2, p3, p4, p5, p6) --[[ New | Line: 21 | Upvalues: Functions (copy), t2 (copy), t (copy) ]]
	local t3 = {
		UI = p1,
		SizeX = 5,
		SizeY = 1
	}
	local v1, v2, v3, v4, v5, v6, v7 = Functions:CreateHairs(p1, t3.SizeX, t3.SizeY)

	t3.Top = v1
	t3.Bottom = v2
	t3.Left = v3
	t3.Right = v4
	t3.HitMarker = v5
	t3.CenterDot = v6
	t3.ImageCrosshair = v7
	t3.Spreading = {
		Spread = p2 or 20,
		MaxSpread = p3 or 60,
		MinSpread = p2 or 20,
		DecreasePerSecond = p4 or 40,
		IncreasePerSecond = p5 or 30
	}
	t3.FollowingMouse = if p6 and (type(p6) == "boolean" and p6) then p6 else false
	t3.Locked = false
	t3.WorldPosition = nil
	t3.show = true
	t3.Hairs = {
		t3.Top,
		t3.Bottom,
		t3.Left,
		t3.Right
	}
	t3.EasingStyle = Enum.EasingStyle.Linear
	t3.EasingDirection = Enum.EasingDirection.InOut
	t3.HitMarker = {
		fadeTime = 0.25,
		hitmarker = t3.HitMarker,
		size = UDim2.fromOffset(50, 50),
		default = Color3.fromRGB(255, 255, 255),
		headshot = Color3.fromRGB(255, 0, 0),
		easingStyle = Enum.EasingStyle.Linear,
		easingDirection = Enum.EasingDirection.InOut,
		Image = {
			default = "rbxassetid://285779644",
			headshot = nil
		}
	}
	t3.CenterDot = {
		enabled = false,
		transparency = 0,
		Image = "rbxassetid://11003529439",
		centerdot = t3.CenterDot,
		size = UDim2.fromOffset(7.5, 7.5)
	}
	t3.ImageCrosshair = {
		enabled = false,
		Image = "rbxassetid://12550071496",
		crosshair = t3.ImageCrosshair
	}
	table.insert(t2, t3)
	Functions:UpdateEnabled(t3.Hairs, false)

	return setmetatable(t3, t)
end
function t.Enable(p1) --[[ Enable | Line: 88 | Upvalues: UserInputService (copy), Functions (copy) ]]
	p1.Enabled = true
	UserInputService.MouseIconEnabled = false
	Functions:UpdateEnabled(p1.Hairs, p1.Enabled)
end
function t.Disable(p1) --[[ Disable | Line: 95 | Upvalues: UserInputService (copy), Functions (copy) ]]
	p1.Enabled = false
	UserInputService.MouseIconEnabled = true
	Functions:UpdateEnabled(p1.Hairs, p1.Enabled)
end
function t.Lock(p1, p2) --[[ Lock | Line: 101 ]]
	p1.Locked = p2 or true
end
function t.FollowMouse(p1, p2) --[[ FollowMouse | Line: 105 ]]
	p1.FollowingMouse = p2 or true
end
function t.UseMuzzleAttach(p1, p2, p3, p4) --[[ UseMuzzleAttach | Line: 110 ]]
	local v1 = p3 or 600
	local v2 = workspace:Raycast(p2.WorldPosition, p2.WorldCFrame.LookVector * v1, p4)

	p1:SetWorldPosition(v2 and v2.Position or p2.WorldPosition + p2.WorldCFrame.LookVector * v1)
	p1.FollowingMouse = false
end
function t.SetWorldPosition(p1, p2) --[[ SetWorldPosition | Line: 120 ]]
	p1.WorldPosition = p2
	p1.FollowingMouse = false
end
function t.Shove(p1, p2) --[[ Shove | Line: 127 | Upvalues: RunService (copy) ]]
	if not p2 then
		p1.Spreading.Spread = p1.Spreading.Spread / (p1.Spreading.IncreasePerSecond * RunService.Heartbeat:Wait())

		return
	end

	p1.Spreading.Spread = p1.Spreading.Spread + (if type(p2) == "number" and p2 then p2 else p2.Magnitude)
end
function t.SmoothSet(p1, p2, p3, p4) --[[ SmoothSet | Line: 138 | Upvalues: TweenService (copy), RunService (copy) ]]
	print("MAKING SMOOTH")

	local v1 = tick()
	local Spread = p1.Spreading.Spread

	while tick() - v1 < p3 do
		p1.Spreading.Spread = Spread + (p2 - Spread) * TweenService:GetValue((tick() - v1) / p3, p1.EasingStyle or Enum.EasingStyle.Linear, p1.EasingDirection or Enum.EasingDirection.InOut)
		RunService.Heartbeat:Wait()
	end

	if p4 then
		p1.Spreading.MinSpread = p1.Spreading.Spread
	end

	p1.Spreading.Spread = p2
end
function t.Set(p1, p2) --[[ Set | Line: 153 ]]
	p1.Spreading.Spread = tonumber(p2)
end
function t.Size(p1, p2, p3) --[[ Size | Line: 158 ]]
	if type(p2) == "number" and type(p3) == "number" then
		p1.SizeX = p2
		p1.SizeY = p3
		p1.Top.Size = UDim2.fromOffset(p3, p2)
		p1.Bottom.Size = UDim2.fromOffset(p3, p2)
		p1.Left.Size = UDim2.fromOffset(p2, p3)
		p1.Right.Size = UDim2.fromOffset(p2, p3)
	end
end
function t.Display(p1, p2) --[[ Display | Line: 169 ]]
	local function ApplyAll(p12, p2) --[[ ApplyAll | Line: 170 | Upvalues: p1 (copy) ]]
		for k, v in pairs(p1.Hairs) do
			v[p12] = p2
		end
	end

	for k, v in pairs(p2) do
		if pcall(function() --[[ Line: 176 | Upvalues: p1 (copy), k (copy) ]]
			local _ = p1.Top[k]
		end) then
			for k2, v2 in pairs(p1.Hairs) do
				v2[k] = v
			end
		end
	end
end
function t.Destroy(p1) --[[ Destroy | Line: 184 | Upvalues: t2 (copy) ]]
	for k, v in pairs(p1.Hairs) do
		v:Destroy()
	end

	p1.CenterDot.centerdot:Destroy()
	p1.ImageCrosshair.crosshair:Destroy()
	table.remove(t2, table.find(t2, p1))
	table.clear(p1)
end

local v2 = false

game.ReplicatedStorage.miscEvents.Test2.Event:Connect(function(p1) --[[ Line: 194 | Upvalues: v2 (ref) ]]
	v2 = p1
end)
function t.Update(p1, p2) --[[ Update | Line: 198 | Upvalues: v1 (ref), v2 (ref), Functions (copy) ]]
	if not p1.Enabled then
		return
	end

	p1.Spreading.Spread = p1.Spreading.Spread - p1.Spreading.DecreasePerSecond * p2
	p1.Spreading.Spread = math.clamp(p1.Spreading.Spread, p1.Spreading.MinSpread, p1.Spreading.MaxSpread)

	local AbsoluteSize = p1.UI.AbsoluteSize
	local LocalPlayer = game:GetService("Players").LocalPlayer
	local CurrentCamera = workspace.CurrentCamera
	local v12

	if p1.WorldPosition then
		local v22

		if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
			local v3 = CurrentCamera:WorldToViewportPoint(p1.WorldPosition)

			v22, v12 = v3, UDim2.fromOffset(v3.X, v3.Y)
		elseif v1 then
			if v2 == true then
				local v6 = CurrentCamera:WorldToViewportPoint(p1.WorldPosition - CurrentCamera.CFrame:VectorToWorldSpace(Vector3.new(0, 0, 0)))

				v22, v12 = v6, UDim2.fromOffset(v6.X, v6.Y)
			else
				local v8, _ = CurrentCamera:WorldToViewportPoint(p1.WorldPosition)

				v22, v12 = v8, UDim2.fromOffset(v8.X, v8.Y)
			end
		else
			local v10, _ = CurrentCamera:WorldToViewportPoint(p1.WorldPosition)

			v22, v12 = v10, UDim2.fromOffset(v10.X, v10.Y)
		end

		if v22.Z < 0 then
			v12 = UDim2.fromOffset(-1000, -1000)
		end
	else
		v12 = if p1.FollowingMouse then UDim2.fromOffset(game:GetService("UserInputService"):GetMouseLocation().X, game:GetService("UserInputService"):GetMouseLocation().Y - game:GetService("GuiService"):GetGuiInset().Y) else UDim2.fromOffset(AbsoluteSize.X / 2, AbsoluteSize.Y / 2)
	end

	local v15 = UDim2.fromOffset(0, p1.Spreading.Spread)
	local v16 = UDim2.fromOffset(p1.Spreading.Spread, 0)

	p1.Top.Position = v12 - v15
	p1.Bottom.Position = v12 + v15
	p1.Right.Position = v12 - v16
	p1.Left.Position = v12 + v16
	p1.HitMarker.hitmarker.Position = v12

	if p1.CenterDot.enabled then
		p1.CenterDot.centerdot.Visible = true
		p1.CenterDot.centerdot.Image = p1.CenterDot.Image
		p1.CenterDot.centerdot.Size = p1.CenterDot.size
		p1.CenterDot.centerdot.ImageTransparency = p1.CenterDot.transparency
		p1.CenterDot.centerdot.Position = v12
	else
		p1.CenterDot.centerdot.Visible = false
	end

	if p1.ImageCrosshair.enabled then
		p1.ImageCrosshair.crosshair.Visible = true
		p1.ImageCrosshair.crosshair.Image = p1.ImageCrosshair.Image
		p1.ImageCrosshair.crosshair.Size = UDim2.fromOffset(p1.SizeX * 2 + p1.Spreading.Spread, p1.SizeX * 2 + p1.Spreading.Spread)
		p1.ImageCrosshair.crosshair.AnchorPoint = Vector2.new(0.5, 0.5)
		p1.ImageCrosshair.crosshair.Position = v12
		Functions:UpdateEnabled(p1.Hairs, false)

		return
	end

	if p1.show then
		p1.ImageCrosshair.crosshair.Visible = false
		Functions:UpdateEnabled(p1.Hairs, true)
	else
		Functions:UpdateEnabled(p1.Hairs, false)
	end
end
function t.ToggleVisible(p1, p2) --[[ ToggleVisible | Line: 287 | Upvalues: UserInputService (copy) ]]
	print("------------------------")
	print(p2)
	p1.show = p2

	for i, v in ipairs(p1.Hairs) do
		v.Visible = p2
	end

	if p1.CenterDot and p1.CenterDot.centerdot then
		p1.CenterDot.centerdot.Visible = p2 and p1.CenterDot.enabled or false
	end

	if p1.ImageCrosshair and p1.ImageCrosshair.crosshair then
		p1.ImageCrosshair.crosshair.Visible = if p2 then p1.ImageCrosshair.enabled or false else false
	end

	if not p2 then
		return
	end

	UserInputService.MouseIconEnabled = false
end
function t.Raycast(p1) --[[ Raycast | Line: 307 | Upvalues: Functions (copy), GuiService (copy) ]]
	local v1, v2 = Functions:RandomPointsInsideCrosshair(p1.Spreading.Spread)
	local AbsoluteSize = p1.UI.AbsoluteSize
	local v3 = workspace.CurrentCamera:ViewportPointToRay(AbsoluteSize.X / 2 + v1, AbsoluteSize.Y / 2 + v2 - GuiService:GetGuiInset().Y)

	return v3.Origin, v3.Direction
end
RunService.RenderStepped:Connect(function(p1) --[[ Line: 319 | Upvalues: t2 (copy) ]]
	for k, v in pairs(t2) do
		v:Update(p1)
	end
end)

return t