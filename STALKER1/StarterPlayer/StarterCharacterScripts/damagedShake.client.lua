-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Humanoid = game.Players.LocalPlayer.Character.Humanoid
local Health = Humanoid.Health
local CurrentCamera = workspace.CurrentCamera
local v1 = require(game.ReplicatedStorage.CameraShaker).new(Enum.RenderPriority.Camera.Value, function(p1) --[[ Line: 10 | Upvalues: CurrentCamera (copy) ]]
	CurrentCamera.CFrame = CurrentCamera.CFrame * p1
end)

v1:Start()
Humanoid.HealthChanged:Connect(function(p1) --[[ Line: 16 | Upvalues: Health (ref), v1 (copy) ]]
	if not (p1 < Health) then
		return
	end

	difference = Health - p1
	Health = p1
	v1:ShakeOnce(difference / 4, 10, 0, 1.5)
end)