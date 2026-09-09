-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local ToggleHeadlamp = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ToggleHeadlamp")

UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 28 | Upvalues: ToggleHeadlamp (copy) ]]
	if p2 then
		return
	end

	if p1.KeyCode ~= Enum.KeyCode.L then
		return
	end

	ToggleHeadlamp:FireServer()
end)

local function findLocalHeadlamp() --[[ findLocalHeadlamp | Line: 38 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	return if Character then Character:FindFirstChild("PETZL HeadLamp") else Character
end

local function isFirstPerson() --[[ isFirstPerson | Line: 43 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return false
	end

	local Head = Character:FindFirstChild("Head")

	if not Head then
		return false
	end

	local CurrentCamera = workspace.CurrentCamera

	if not CurrentCamera then
		return false
	end

	return (CurrentCamera.CFrame.Position - Head.Position).Magnitude < 1
end

local v1 = 0

RunService.Heartbeat:Connect(function(p1) --[[ Line: 56 | Upvalues: v1 (ref), LocalPlayer (copy) ]]
	v1 = v1 + p1

	if v1 < 0.25 then
		return
	end

	v1 = v1 - 0.25

	local Character = LocalPlayer.Character
	local v12 = Character and Character:FindFirstChild("PETZL HeadLamp")

	if not v12 then
		return
	end

	local HeadLampLight = v12:FindFirstChild("HeadLampLight")

	if not HeadLampLight then
		return
	end

	local Character2 = LocalPlayer.Character
	local v3

	if Character2 then
		local Head = Character2:FindFirstChild("Head")

		if Head then
			local CurrentCamera = workspace.CurrentCamera

			v3 = if CurrentCamera then (CurrentCamera.CFrame.Position - Head.Position).Magnitude < 1 else false
		else
			v3 = false
		end
	else
		v3 = false
	end

	local v4 = LocalPlayer.Character and LocalPlayer.Character:GetAttribute("HeadlampOn") == true
	local Attachment = HeadLampLight:FindFirstChild("Attachment")
	local v5 = if Attachment then Attachment:FindFirstChild("BulbGlow") else Attachment

	if v5 and v5:IsA("BillboardGui") then
		v5.Enabled = if v4 then not v3 else v4
	end

	local SpotLight = HeadLampLight:FindFirstChild("SpotLight")

	if not (SpotLight and SpotLight:IsA("SpotLight")) then
		return
	end

	SpotLight.Shadows = not v3
end)
print("[HeadlampClient] Bound -- L toggle, local-only BulbGlow hide, first-person shadow suppress")