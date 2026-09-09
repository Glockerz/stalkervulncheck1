-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local GoodSignal = require(script.Parent.Parent.Internal.GoodSignal)
local CurrentCamera = game.Workspace.CurrentCamera
local t = {
	Signals = {
		CalculatedRotation = GoodSignal.new()
	},
	InitializationPriority = 1,
	Heading = nil
}

RunService.RenderStepped:Connect(function(p1) --[[ Line: 33 | Upvalues: CurrentCamera (copy), t (copy) ]]
	local lookVector = CurrentCamera.CFrame.lookVector

	heading = math.atan2(lookVector.x, lookVector.z)
	heading = math.deg(heading) - 90
	t.Heading = math.rad(heading)
	t.Signals.CalculatedRotation:Fire((math.rad(heading)))
end)

return t