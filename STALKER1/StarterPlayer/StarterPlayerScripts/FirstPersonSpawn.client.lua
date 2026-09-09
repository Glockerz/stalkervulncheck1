-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local LocalPlayer = game:GetService("Players").LocalPlayer

local function snapToFirstPerson() --[[ snapToFirstPerson | Line: 10 | Upvalues: LocalPlayer (copy) ]]
	LocalPlayer.CameraMaxZoomDistance = 0.5
	task.wait()
	LocalPlayer.CameraMaxZoomDistance = 8
end

LocalPlayer.CharacterAdded:Connect(snapToFirstPerson)

if not LocalPlayer.Character then
	return
end

LocalPlayer.CameraMaxZoomDistance = 0.5
task.wait()
LocalPlayer.CameraMaxZoomDistance = 8