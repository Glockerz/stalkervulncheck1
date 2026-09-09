-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Maid = require(script.Utils:WaitForChild("Maid"))
local Spring = require(script.Utils:WaitForChild("Spring"))
local LocalPlayer = Players.LocalPlayer
local ToggleShiftLock = script:WaitForChild("ToggleShiftLock")
local t2 = {
	CHARACTER_SMOOTH_ROTATION = true,
	CHARACTER_ROTATION_SPEED = 3,
	TRANSITION_SPRING_DAMPER = 0.7,
	CAMERA_TRANSITION_IN_SPEED = 10,
	CAMERA_TRANSITION_OUT_SPEED = 14,
	LOCKED_CAMERA_OFFSET = Vector3.new(2.75, 0.25, 0),
	SHIFT_LOCK_KEYBINDS = { Enum.KeyCode.LeftControl, Enum.KeyCode.RightControl }
}
local v1 = Maid.new()

local function IsFirstPerson() --[[ IsFirstPerson | Line: 32 | Upvalues: Workspace (copy), LocalPlayer (copy) ]]
	local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")

	if not v1 then
		return false
	end

	return (Workspace.CurrentCamera.CFrame.Position - v1.Position).Magnitude < 1
end

function t.Init(p1) --[[ Init | Line: 39 | Upvalues: Maid (copy), LocalPlayer (copy) ]]
	local v1 = Maid.new()

	task.wait(1)

	if game.Players.LocalPlayer.Character then
		p1:CharacterAdded()
	end

	v1:GiveTask(LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 46 | Upvalues: p1 (copy) ]]
		p1:CharacterAdded()
	end))
end
function t.CharacterAdded(p1) --[[ CharacterAdded | Line: 51 | Upvalues: t (copy), LocalPlayer (copy), Workspace (copy), Maid (copy), Spring (copy), t2 (copy), UserInputService (copy), TweenService (copy), RunService (copy), ToggleShiftLock (copy) ]]
	game.ReplicatedStorage.miscEvents.Test2:Fire(false)

	local v2 = setmetatable({}, t)

	v2.Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	v2.RootPart = v2.Character:WaitForChild("HumanoidRootPart")
	v2.Humanoid = v2.Character:WaitForChild("Humanoid")
	v2.Head = v2.Character:WaitForChild("Head")
	v2.PlayerMouse = LocalPlayer:GetMouse()
	v2.Camera = Workspace.CurrentCamera
	v2.defaultFOV = 70
	v2.Zoomed = false
	v2.muzzleAttach = nil
	v2.gunModel = nil
	v2.ENABLED = true
	v2._wasShiftLockEnabled = true
	v2.crosshairLocation = Instance.new("Attachment")
	v2.crosshairLocation.Parent = workspace.Terrain
	v2.crosshairBeam = Instance.new("Beam")
	v2.crosshairBeam.Enabled = true
	v2.crosshairUI = script.CrosshairUI:Clone()
	v2.crosshairUI.Enabled = false
	v2.crosshairUI.Parent = v2.crosshairLocation
	v2.connectionsMaid = Maid.new()
	v2.camOffsetSpring = Spring.new(Vector3.new(0, 0, 0))
	v2.camOffsetSpring.Damper = t2.TRANSITION_SPRING_DAMPER
	v2:ToggleShiftLock(true)
	v2.connectionsMaid:GiveTask(UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 86 | Upvalues: Workspace (ref), LocalPlayer (ref), t2 (ref), v2 (copy), TweenService (ref) ]]
		if p2 then
			return
		end

		if p1.KeyCode == Enum.KeyCode.LeftControl or p1.KeyCode == Enum.KeyCode.RightControl then
			local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")

			if if v1 then if (Workspace.CurrentCamera.CFrame.Position - v1.Position).Magnitude < 1 then true else false else false then
				return
			end
		end

		for k, v in pairs(t2.SHIFT_LOCK_KEYBINDS) do
			local v3, v4, v5

			if p1.KeyCode == v and (v2.Humanoid and v2.Humanoid.Health ~= 0) then
				local v6 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")

				if if v6 then if (Workspace.CurrentCamera.CFrame.Position - v6.Position).Magnitude < 1 then true else false else false then
					if p1.UserInputType == v and (v2.Humanoid and (v2.Humanoid.Health ~= 0 and v2.Character:FindFirstChildOfClass("Tool"))) then
						v3 = Workspace.CurrentCamera
						v4 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
						v5 = if v4 then if (v3.CFrame.Position - v4.Position).Magnitude < 1 then true else false else false

						if not v5 then
							v2:ToggleShiftLock(not v2.ENABLED)
						end
					end

					continue
				end

				v2:ToggleShiftLock(not v2.ENABLED)
			elseif p1.UserInputType == v and (v2.Humanoid and (v2.Humanoid.Health ~= 0 and v2.Character:FindFirstChildOfClass("Tool"))) then
				v3 = Workspace.CurrentCamera
				v4 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
				v5 = if v4 then if (v3.CFrame.Position - v4.Position).Magnitude < 1 then true else false else false

				if not v5 then
					v2:ToggleShiftLock(not v2.ENABLED)
				end
			end
		end

		if p1.UserInputType ~= Enum.UserInputType.MouseButton2 then
			return
		end

		if not v2.ENABLED then
			return
		end

		local v8 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")

		if if v8 then (Workspace.CurrentCamera.CFrame.Position - v8.Position).Magnitude < 1 else false then
			return
		end

		print("Zoom ON")
		game.ReplicatedStorage.miscEvents.Test:Fire(true)
		v2.Zoomed = true
		v2.crosshairUI.Enabled = true
		TweenService:Create(v2.Camera, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			FieldOfView = 30
		}):Play()

		if not (v2.Character.WeaponRig and v2.Character.WeaponRig.Weapon:FindFirstChildOfClass("Model")) then
			return
		end

		local Model = v2.Character.WeaponRig.Weapon:FindFirstChildOfClass("Model")

		v2.gunModel = Model
		v2.muzzleAttach = Model.Grip.Muzzle
	end))
	v2.connectionsMaid:GiveTask(UserInputService.InputEnded:Connect(function(p1, p2) --[[ Line: 123 | Upvalues: t2 (ref), v2 (copy), Workspace (ref), LocalPlayer (ref), TweenService (ref) ]]
		if p2 then
			return
		end

		for k, v in pairs(t2.SHIFT_LOCK_KEYBINDS) do
			if p1.UserInputType == v and (v2.Humanoid and (v2.Humanoid.Health ~= 0 and v2.Character:FindFirstChildOfClass("Tool"))) then
				v2:ToggleShiftLock(not v2.ENABLED)
			end
		end

		if p1.UserInputType ~= Enum.UserInputType.MouseButton2 then
			return
		end

		if not v2.ENABLED then
			return
		end

		local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")

		if if v1 then (Workspace.CurrentCamera.CFrame.Position - v1.Position).Magnitude < 1 else false then
			return
		end

		if not v2.Zoomed then
			return
		end

		print("Zoom OFF")
		game.ReplicatedStorage.miscEvents.Test:Fire(false)
		v2.Zoomed = false
		v2.crosshairUI.Enabled = false
		TweenService:Create(v2.Camera, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			FieldOfView = v2.defaultFOV
		}):Play()
	end))
	v2.connectionsMaid:GiveTask(RunService.RenderStepped:Connect(function(p1) --[[ Line: 149 | Upvalues: v2 (copy), UserInputService (ref) ]]
		if v2.Zoomed then
			if not v2.gunModel then
				return
			end

			local muzzleAttach = v2.muzzleAttach
			local v1 = RaycastParams.new()

			v1.FilterType = Enum.RaycastFilterType.Exclude
			v1.FilterDescendantsInstances = { v2.gunModel, v2.Character }
			v1.RespectCanCollide = true

			local v22 = workspace:Raycast(muzzleAttach.WorldPosition, muzzleAttach.WorldCFrame.LookVector * 600, v1)

			if v22 then
				v2.crosshairLocation.WorldPosition = v22.Position
			else
				v2.crosshairLocation.WorldPosition = muzzleAttach.WorldCFrame.LookVector * 600
			end
		end

		if v2.Head.LocalTransparencyModifier > 0.6 then
			return
		end

		if v2.Camera.CameraType ~= Enum.CameraType.Custom then
			return
		end

		if not ((v2.Head.Position - v2.Camera.CFrame.p).Magnitude > 1) then
			return
		end

		v2.Camera.CFrame = v2.Camera.CFrame * CFrame.new(v2.camOffsetSpring.Position)

		if not v2.ENABLED or UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
			return
		end

		v2:SetMouseState(v2.ENABLED)
	end))
	v2.connectionsMaid:GiveTask(LocalPlayer:GetPropertyChangedSignal("CameraMode"):Connect(function() --[[ Line: 183 | Upvalues: Workspace (ref), LocalPlayer (ref), v2 (copy) ]]
		local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")

		if if v1 then (Workspace.CurrentCamera.CFrame.Position - v1.Position).Magnitude < 1 else false then
			if v2.ENABLED then
				v2:ToggleShiftLock(false)
				v2._wasShiftLockEnabled = true
			end
		else
			if not v2._wasShiftLockEnabled then
				return
			end

			v2:ToggleShiftLock(true)
			v2._wasShiftLockEnabled = false
		end
	end))
	v2.connectionsMaid:GiveTask(ToggleShiftLock.Event:Connect(function(p1) --[[ Line: 197 | Upvalues: v2 (copy) ]]
		if not v2.Humanoid or v2.Humanoid.Health == 0 then
			return
		end

		v2:ToggleShiftLock(p1)
	end))
	v2.connectionsMaid:GiveTask(v2.Humanoid.Died:Connect(function() --[[ Line: 203 | Upvalues: v2 (copy) ]]
		v2:CharacterDiedOrRemoved()
	end))
	v2.connectionsMaid:GiveTask(LocalPlayer.CharacterRemoving:Connect(function() --[[ Line: 207 | Upvalues: v2 (copy) ]]
		v2:CharacterDiedOrRemoved()
	end))

	return v2
end
function t.CharacterDiedOrRemoved(p1) --[[ CharacterDiedOrRemoved | Line: 214 | Upvalues: TweenService (copy), v1 (copy) ]]
	p1:ToggleShiftLock(false)
	game.ReplicatedStorage.miscEvents.Test2:Fire(false)
	p1.Zoomed = false
	p1.camOffsetSpring.Target = Vector3.new(0, 0, 0)
	TweenService:Create(p1.Camera, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		FieldOfView = p1.defaultFOV
	}):Play()

	if p1.connectionsMaid then
		p1.connectionsMaid:Destroy()
	end

	v1:DoCleaning()
end
function t.IsEnabled(p1) --[[ IsEnabled | Line: 229 ]]
	return p1.ENABLED
end
function t.SetMouseState(p1, p2) --[[ SetMouseState | Line: 233 | Upvalues: UserInputService (copy) ]]
	UserInputService.MouseBehavior = p2 and Enum.MouseBehavior.LockCenter or Enum.MouseBehavior.Default
end
function t.SetMouseIcon(p1, p2) --[[ SetMouseIcon | Line: 237 ]] end
function t.TransitionLockOffset(p1, p2) --[[ TransitionLockOffset | Line: 241 | Upvalues: t2 (copy) ]]
	if p2 then
		p1.camOffsetSpring.Speed = t2.CAMERA_TRANSITION_IN_SPEED
		p1.camOffsetSpring.Target = t2.LOCKED_CAMERA_OFFSET
	else
		p1.camOffsetSpring.Speed = t2.CAMERA_TRANSITION_OUT_SPEED
		p1.camOffsetSpring.Target = Vector3.new(0, 0, 0)
	end
end
function t.ToggleShiftLock(p1, p2) --[[ ToggleShiftLock | Line: 251 | Upvalues: LocalPlayer (copy), v1 (copy), RunService (copy), t2 (copy), TweenService (copy) ]]
	print("shiftlock fire")
	game.ReplicatedStorage.miscEvents.Test2:Fire(p2)
	assert(if typeof(p2) == "boolean" then true else false, "Enable value is not a boolean.")
	p1.ENABLED = p2
	LocalPlayer:SetAttribute("ShiftLockEnabled", p2)
	p1:SetMouseState(p1.ENABLED)
	p1:SetMouseIcon(p1.ENABLED)
	p1:TransitionLockOffset(p1.ENABLED)

	if p1.ENABLED then
		v1:GiveTask(RunService.RenderStepped:Connect(function(p12) --[[ Line: 265 | Upvalues: p1 (copy), t2 (ref), TweenService (ref), v1 (ref) ]]
			if p1.Humanoid and p1.RootPart then
				p1.Humanoid.AutoRotate = not p1.ENABLED
			end

			if p1.ENABLED and p1.Camera.CameraType == Enum.CameraType.Custom then
				if p1.Humanoid.Sit or (p1.Humanoid.PlatformStand or not t2.CHARACTER_SMOOTH_ROTATION) then
					if not (p1.Humanoid.Sit or p1.Humanoid.PlatformStand) then
						local _, v12, _2 = p1.Camera.CFrame:ToOrientation()

						p1.RootPart.CFrame = CFrame.new(p1.RootPart.Position) * CFrame.Angles(0, v12, 0)
					end
				else
					local _, v2, _2 = p1.Camera.CFrame:ToOrientation()

					p1.RootPart.CFrame = p1.RootPart.CFrame:Lerp(CFrame.new(p1.RootPart.Position) * CFrame.Angles(0, v2, 0), p12 * 5 * t2.CHARACTER_ROTATION_SPEED)
				end
			end

			if p1.ENABLED then
				return
			end

			if p1.Zoomed then
				p1.Zoomed = false
				p1.crosshairUI.Enabled = false
				TweenService:Create(p1.Camera, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
					FieldOfView = p1.defaultFOV
				}):Play()
			end

			v1:Destroy()
		end))
	end

	return p1
end

return t