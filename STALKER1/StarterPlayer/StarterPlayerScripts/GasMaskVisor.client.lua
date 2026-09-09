-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local GasMaskVoiceConfig = require(ReplicatedStorage:WaitForChild("GasMaskVoiceConfig"))
local GasMaskPlane = ReplicatedStorage:FindFirstChild("GasMaskPlane")
local GasMaskWetEffect = ReplicatedStorage:FindFirstChild("GasMaskWetEffect")
local v1 = nil
local v2 = nil

local function isFirstPerson(p1) --[[ isFirstPerson | Line: 33 | Upvalues: LocalPlayer (copy) ]]
	local v1 = if p1 then p1 else workspace.CurrentCamera
	local Character = LocalPlayer.Character
	local v2 = if Character then Character:FindFirstChild("Head") else Character

	if not (v1 and v2) then
		return false
	end

	return (v1.CFrame.Position - v2.Position).Magnitude <= 1.5
end

local function isWearingVisorMask() --[[ isWearingVisorMask | Line: 44 | Upvalues: GasMaskVoiceConfig (copy), LocalPlayer (copy) ]]
	return GasMaskVoiceConfig.isWearingVisorMask(LocalPlayer.Character)
end

local function showVisor() --[[ showVisor | Line: 48 | Upvalues: v1 (ref), GasMaskPlane (copy), LocalPlayer (copy), GasMaskWetEffect (copy), v2 (ref), RunService (copy), Lighting (copy) ]]
	if v1 then
		return
	end

	if not GasMaskPlane then
		return
	end

	local GasMaskVisorGui = Instance.new("ScreenGui")

	GasMaskVisorGui.Name = "GasMaskVisorGui"
	GasMaskVisorGui.DisplayOrder = -10
	GasMaskVisorGui.IgnoreGuiInset = true
	GasMaskVisorGui.ResetOnSpawn = false
	GasMaskVisorGui.Parent = LocalPlayer.PlayerGui

	local VisorViewport = Instance.new("ViewportFrame")

	VisorViewport.Name = "VisorViewport"
	VisorViewport.Size = UDim2.fromScale(1, 1)
	VisorViewport.Position = UDim2.fromScale(0, 0)
	VisorViewport.BackgroundTransparency = 1
	VisorViewport.ImageTransparency = 0
	VisorViewport.LightDirection = Vector3.new(-1, -1, -1)
	VisorViewport.LightColor = Color3.new(255/255, 255/255, 255/255)
	VisorViewport.Ambient = Color3.new(0.5, 0.5, 0.5)
	VisorViewport.Parent = GasMaskVisorGui

	local Camera = Instance.new("Camera")

	Camera.FieldOfView = 70
	Camera.Parent = VisorViewport
	VisorViewport.CurrentCamera = Camera

	local WorldModel = Instance.new("WorldModel")

	WorldModel.Parent = VisorViewport

	local VisorMesh = GasMaskPlane:Clone()

	VisorMesh.Name = "VisorMesh"
	VisorMesh.Anchored = true
	VisorMesh.CanCollide = false
	VisorMesh.CanQuery = false
	VisorMesh.CanTouch = false
	VisorMesh.CastShadow = false
	VisorMesh.Parent = WorldModel

	local WetMesh

	if GasMaskWetEffect then
		WetMesh = GasMaskWetEffect:Clone()
		WetMesh.Name = "WetMesh"
		WetMesh.Anchored = true
		WetMesh.CanCollide = false
		WetMesh.CanQuery = false
		WetMesh.CanTouch = false
		WetMesh.CastShadow = false
		WetMesh.Parent = WorldModel
	else
		WetMesh = nil
	end

	v1 = GasMaskVisorGui
	v2 = RunService.RenderStepped:Connect(function() --[[ Line: 109 | Upvalues: LocalPlayer (ref), VisorViewport (copy), Camera (copy), VisorMesh (copy), GasMaskPlane (ref), WetMesh (ref), Lighting (ref) ]]
		local CurrentCamera = workspace.CurrentCamera

		if not CurrentCamera then
			return
		end

		local v1 = if CurrentCamera then CurrentCamera else workspace.CurrentCamera
		local Character = LocalPlayer.Character
		local v2 = if Character then Character:FindFirstChild("Head") else Character

		if not (if v1 and v2 then if (v1.CFrame.Position - v2.Position).Magnitude <= 1.5 then true else false else false) then
			VisorViewport.Visible = false

			return
		end

		VisorViewport.Visible = true
		Camera.FieldOfView = CurrentCamera.FieldOfView
		Camera.CFrame = CurrentCamera.CFrame

		local v4 = math.rad(CurrentCamera.FieldOfView)
		local ViewportSize = CurrentCamera.ViewportSize
		local v6 = math.tan(v4 / 2) * 1.4 * 1.1

		VisorMesh.Size = Vector3.new(v6 * (ViewportSize.X / ViewportSize.Y), GasMaskPlane.Size.Y * 0.01, v6)
		VisorMesh.CFrame = CurrentCamera.CFrame * CFrame.new(0, 0, -0.7) * CFrame.Angles(1.5707963267948966, 0, 0)

		local v9, v10, v11

		if WetMesh then
			WetMesh.Size = VisorMesh.Size
			WetMesh.CFrame = CurrentCamera.CFrame * CFrame.new(0, 0, -0.69) * CFrame.Angles(1.5707963267948966, 0, 0)
		end

		v9 = Lighting.ClockTime / 24 * math.pi
		v10 = math.sin(v9)
		v11 = math.clamp(v10, 0.1, 1)
		VisorViewport.Ambient = Color3.new(v11 * 0.5, v11 * 0.5, v11 * 0.5)
	end)
end

local function hideVisor() --[[ hideVisor | Line: 151 | Upvalues: v2 (ref), v1 (ref) ]]
	if v2 then
		v2:Disconnect()
		v2 = nil
	end

	if not v1 then
		return
	end

	v1:Destroy()
	v1 = nil
end

local v3 = false

local function blinkApply(p1) --[[ blinkApply | Line: 172 | Upvalues: v3 (ref), LocalPlayer (copy), TweenService (copy), showVisor (copy), v2 (ref), v1 (ref) ]]
	v3 = true

	local GasMaskBlink = Instance.new("ScreenGui")

	GasMaskBlink.Name = "GasMaskBlink"
	GasMaskBlink.DisplayOrder = 200
	GasMaskBlink.IgnoreGuiInset = true
	GasMaskBlink.ResetOnSpawn = false
	GasMaskBlink.Parent = LocalPlayer.PlayerGui

	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.fromScale(1, 1)
	Frame.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
	Frame.BackgroundTransparency = 1
	Frame.BorderSizePixel = 0
	Frame.Parent = GasMaskBlink

	local v12 = TweenService:Create(Frame, TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		BackgroundTransparency = 0
	})

	v12:Play()
	v12.Completed:Wait()

	if p1 then
		showVisor()
	else
		if v2 then
			v2:Disconnect()
			v2 = nil
		end

		if v1 then
			v1:Destroy()
			v1 = nil
		end
	end

	task.wait(0.1)

	local v22 = TweenService:Create(Frame, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		BackgroundTransparency = 1
	})

	v22:Play()
	v22.Completed:Wait()
	GasMaskBlink:Destroy()
	v3 = false
end

task.spawn(function() --[[ Line: 209 | Upvalues: v3 (ref), GasMaskVoiceConfig (copy), LocalPlayer (copy), v1 (ref), blinkApply (copy) ]]
	while true do
		if not v3 then
			local v12 = GasMaskVoiceConfig.isWearingVisorMask(LocalPlayer.Character)

			if v12 and not v1 then
				blinkApply(true)
			elseif not v12 and v1 then
				blinkApply(false)
			end
		end

		task.wait(0.5)
	end
end)
LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 224 | Upvalues: v2 (ref), v1 (ref) ]]
	if v2 then
		v2:Disconnect()
		v2 = nil
	end

	if not v1 then
		return
	end

	v1:Destroy()
	v1 = nil
end)
print("[GasMaskVisor] ViewportFrame mode initialized")