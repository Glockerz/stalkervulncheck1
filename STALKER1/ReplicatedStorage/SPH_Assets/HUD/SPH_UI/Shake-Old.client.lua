-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Ammo = script.Parent.Ammo
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local v1 = UDim2.fromScale(Ammo.Position.X.Scale, Ammo.Position.Y.Scale)
local Vector3Value = Instance.new("Vector3Value")
local v2 = 0
local v3 = 0

Vector3Value:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 14 | Upvalues: v2 (ref), Vector3Value (copy), v3 (ref) ]]
	v2 = Vector3Value.Value.X
	v3 = Vector3Value.Value.Y
end)
RunService.Heartbeat:Connect(function() --[[ Line: 19 | Upvalues: UserInputService (copy), TweenService (copy), Vector3Value (copy) ]]
	local v1 = UserInputService:GetMouseDelta()
	local v4 = TweenInfo.new(1, Enum.EasingStyle.Sine)
	local t = {}

	t.Value = Vector3.new(v1.X, v1.Y, 0)
	TweenService:Create(Vector3Value, v4, t):Play()
end)
RunService.Heartbeat:Connect(function() --[[ Line: 29 | Upvalues: UserInputService (copy), Ammo (copy), v1 (copy) ]]
	local v12 = UserInputService:GetMouseDelta()

	Ammo.Position = v1 + UDim2.fromOffset(v12.X, v12.Y)
end)