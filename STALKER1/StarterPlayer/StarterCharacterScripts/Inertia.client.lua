-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local PlayerScripts = game:GetService("Players").LocalPlayer.PlayerScripts
local ControlModule = require(PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
local v1 = require(script:WaitForChild("Spring")).new(ControlModule:GetMoveVector())
local Humanoid = script.Parent:WaitForChild("Humanoid")
local Speed = script:WaitForChild("Speed")
local Damper = script:WaitForChild("Damper")

RunService:BindToRenderStep("___update", Enum.RenderPriority.Character.Value - 1, function() --[[ Line: 16 | Upvalues: v1 (copy), ControlModule (copy), Speed (copy), Damper (copy), Humanoid (copy) ]]
	v1.Target = ControlModule:GetMoveVector()
	v1.Speed = Speed.Value
	v1.Damper = Damper.Value
	Humanoid:Move(v1.Position, true)
end)