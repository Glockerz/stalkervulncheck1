-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CinematicCameraConfig = require(ReplicatedStorage:WaitForChild("CinematicCameraConfig"))
local LocalPlayer = Players.LocalPlayer

if #CinematicCameraConfig.Whitelist > 0 and not table.find(CinematicCameraConfig.Whitelist, LocalPlayer.UserId) then
	return
end

local CinematicModules = script.Parent:WaitForChild("CinematicModules")
local InputHandler = require(CinematicModules:WaitForChild("InputHandler"))
local CameraController = require(CinematicModules:WaitForChild("CameraController"))
local FocusTargeter = require(CinematicModules:WaitForChild("FocusTargeter"))
local HoverHighlight = require(CinematicModules:WaitForChild("HoverHighlight"))
local OverlayRenderer = require(CinematicModules:WaitForChild("OverlayRenderer"))
local LightingController = require(CinematicModules:WaitForChild("LightingController"))
local BillboardSuppressor = require(CinematicModules:WaitForChild("BillboardSuppressor"))
local CinematicRequestEnter = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CinematicRequestEnter")
local CinematicRequestExit = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CinematicRequestExit")
local t = {
	active = false,
	mode = "Smoothed",
	lockTarget = nil,
	hudHidden = false,
	mouseSensitivityMult = 1,
	cursorFree = false,
	handheldTime = 0,
	actions = {
		scroll = 0,
		boost = false,
		precise = false,
		focusPickThisFrame = false,
		breakFocusThisFrame = false,
		move = Vector3.new(),
		look = Vector2.new()
	},
	cameraCFrame = CFrame.new(),
	smoothedCFrame = CFrame.new(),
	fov = CinematicCameraConfig.Camera.DefaultFOV,
	speed = CinematicCameraConfig.Speed.Base,
	focus = {
		target = nil,
		distanceOffset = 0,
		locked = false,
		distance = CinematicCameraConfig.Focus.DefaultDistance
	},
	overlays = {
		thirds = true,
		letterbox = "off",
		focusRect = true,
		level = true,
		info = true,
		centerDot = true,
		lightingPanel = false,
		controlPanel = true,
		hoverHighlight = true
	},
	lighting = {
		exposure = 0,
		bloom = {
			on = false,
			intensity = 1,
			threshold = 2,
			size = 24
		},
		colorCorrection = {
			on = false,
			brightness = 0,
			contrast = 0,
			saturation = 0,
			tint = Color3.new(255/255, 255/255, 255/255)
		},
		dof = {
			on = false,
			focusDistance = CinematicCameraConfig.Focus.DefaultDistance,
			farIntensity = CinematicCameraConfig.DOF.FarIntensity,
			nearIntensity = CinematicCameraConfig.DOF.NearIntensity,
			inFocusRadius = CinematicCameraConfig.DOF.InFocusRadius
		},
		blur = {
			on = false,
			size = 24
		}
	}
}
local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil
local t2 = {
	CinematicHUD = true,
	CinematicToast = true
}

local function hideGameUI() --[[ hideGameUI | Line: 101 | Upvalues: v2 (ref), LocalPlayer (copy), t2 (copy), v3 (ref), v4 (ref) ]]
	v2 = {}

	local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")

	if PlayerGui then
		for i, v in ipairs(PlayerGui:GetChildren()) do
			if v:IsA("ScreenGui") and not t2[v.Name] then
				v2[v] = v.Enabled
				v.Enabled = false
			end
		end
	end

	v3 = {}

	local StarterGui = game:GetService("StarterGui")

	for i, v in ipairs({
		Enum.CoreGuiType.Backpack,
		Enum.CoreGuiType.Chat,
		Enum.CoreGuiType.PlayerList,
		Enum.CoreGuiType.Health,
		Enum.CoreGuiType.EmotesMenu
	}) do
		local ok, result = pcall(function() --[[ Line: 121 | Upvalues: StarterGui (copy), v (copy) ]]
			return StarterGui:GetCoreGuiEnabled(v)
		end)

		if ok then
			v3[v] = result
			pcall(function() --[[ Line: 124 | Upvalues: StarterGui (copy), v (copy) ]]
				StarterGui:SetCoreGuiEnabled(v, false)
			end)
		end
	end

	pcall(function() --[[ Line: 127 | Upvalues: v4 (ref), StarterGui (copy) ]]
		v4 = StarterGui:GetCore("TopbarEnabled")
		StarterGui:SetCore("TopbarEnabled", false)
	end)
end

local function restoreGameUI() --[[ restoreGameUI | Line: 133 | Upvalues: v2 (ref), v3 (ref), v4 (ref) ]]
	if v2 then
		for k, v in pairs(v2) do
			if k.Parent then
				k.Enabled = v
			end
		end

		v2 = nil
	end

	if v3 then
		local StarterGui = game:GetService("StarterGui")

		for k, v in pairs(v3) do
			pcall(function() --[[ Line: 143 | Upvalues: StarterGui (copy), k (copy), v (copy) ]]
				StarterGui:SetCoreGuiEnabled(k, v)
			end)
		end

		v3 = nil
	end

	if v4 == nil then
		return
	end

	pcall(function() --[[ Line: 148 | Upvalues: v4 (ref) ]]
		game:GetService("StarterGui"):SetCore("TopbarEnabled", v4)
	end)
	v4 = nil
end

local function showToast(p1) --[[ showToast | Line: 153 | Upvalues: LocalPlayer (copy) ]]
	local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")

	if PlayerGui then
		local CinematicToast = Instance.new("ScreenGui")

		CinematicToast.Name = "CinematicToast"
		CinematicToast.ResetOnSpawn = false
		CinematicToast.DisplayOrder = 1500
		CinematicToast.IgnoreGuiInset = true
		CinematicToast.Parent = PlayerGui

		local TextLabel = Instance.new("TextLabel")

		TextLabel.AnchorPoint = Vector2.new(0.5, 0)
		TextLabel.Position = UDim2.new(0.5, 0, 0, 60)
		TextLabel.Size = UDim2.fromOffset(360, 32)
		TextLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		TextLabel.BackgroundTransparency = 0.15
		TextLabel.BorderSizePixel = 0
		TextLabel.Font = Enum.Font.Code
		TextLabel.TextSize = 14
		TextLabel.TextColor3 = Color3.fromRGB(255, 200, 90)
		TextLabel.Text = p1
		TextLabel.Parent = CinematicToast
		task.delay(3, function() --[[ Line: 170 | Upvalues: CinematicToast (copy) ]]
			CinematicToast:Destroy()
		end)
	end
end

local function enter() --[[ enter | Line: 173 | Upvalues: t (copy), CinematicRequestEnter (copy), showToast (copy), hideGameUI (copy), BillboardSuppressor (copy), InputHandler (copy), CameraController (copy), FocusTargeter (copy), HoverHighlight (copy), LightingController (copy), OverlayRenderer (copy), v1 (ref), RunService (copy) ]]
	if t.active then
		return
	end

	local ok, result = pcall(function() --[[ Line: 175 | Upvalues: CinematicRequestEnter (ref) ]]
		return CinematicRequestEnter:InvokeServer()
	end)

	if ok and (result and result.ok) then
		t.active = true
		hideGameUI()
		BillboardSuppressor:Enter(t)
		InputHandler:Enter(t)
		CameraController:Enter(t)
		FocusTargeter:Enter(t)
		HoverHighlight:Enter(t)
		LightingController:Enter(t)
		OverlayRenderer:Enter(t)
		v1 = RunService.RenderStepped:Connect(function(p1) --[[ Line: 191 | Upvalues: InputHandler (ref), t (ref), CameraController (ref), FocusTargeter (ref), HoverHighlight (ref), LightingController (ref), OverlayRenderer (ref) ]]
			InputHandler:Tick(t, p1)
			CameraController:Tick(t, p1)
			FocusTargeter:Tick(t, p1)
			HoverHighlight:Tick(t, p1)
			LightingController:Tick(t, p1)
			OverlayRenderer:Tick(t, p1)

			if not t.__exitRequested then
				return
			end

			t.__exitRequested = false
			task.defer(function() --[[ Line: 202 | Upvalues: t (ref) ]]
				if not t.active then
					return
				end

				exit()
			end)
		end)
		print("[CinematicCamera] ENTERED")

		return
	end

	local v12 = if result then result.reason or "rpc_failed" else "rpc_failed"

	warn("[CinematicCamera] enter denied: " .. v12)
	showToast("Cinematic denied: " .. v12)
end

local function exit() --[[ exit | Line: 208 | Upvalues: t (copy), v1 (ref), OverlayRenderer (copy), LightingController (copy), HoverHighlight (copy), FocusTargeter (copy), CameraController (copy), InputHandler (copy), BillboardSuppressor (copy), restoreGameUI (copy), CinematicRequestExit (copy) ]]
	if not t.active then
		return
	end

	if not v1 then
		OverlayRenderer:Exit()
		LightingController:Exit()
		HoverHighlight:Exit()
		FocusTargeter:Exit()
		CameraController:Exit()
		InputHandler:Exit()
		BillboardSuppressor:Exit()
		restoreGameUI()
		CinematicRequestExit:FireServer()
		t.active = false
		print("[CinematicCamera] EXITED")

		return
	end

	v1:Disconnect()
	v1 = nil
	OverlayRenderer:Exit()
	LightingController:Exit()
	HoverHighlight:Exit()
	FocusTargeter:Exit()
	CameraController:Exit()
	InputHandler:Exit()
	BillboardSuppressor:Exit()
	restoreGameUI()
	CinematicRequestExit:FireServer()
	t.active = false
	print("[CinematicCamera] EXITED")
end

UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 224 | Upvalues: CinematicCameraConfig (copy), t (copy), exit (copy), enter (copy) ]]
	if p1.KeyCode ~= CinematicCameraConfig.Keys.Toggle then
		return
	end

	if t.active then
		exit()

		return
	end

	enter()
end)
LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 235 | Upvalues: t (copy), exit (copy) ]]
	if not t.active then
		return
	end

	exit()
end)
print("[CinematicCameraClient] Ready (toggle: " .. CinematicCameraConfig.Keys.Toggle.Name .. ")")