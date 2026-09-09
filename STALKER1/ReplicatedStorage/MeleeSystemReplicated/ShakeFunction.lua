-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")

ReplicatedStorage:WaitForChild("MeleeSystemReplicated")

local CameraShaker = require(ReplicatedStorage.CameraShaker)
local v1 = nil

local function ShakeCamera(p1) --[[ ShakeCamera | Line: 15 ]]
	workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * p1
end

function t.Init() --[[ Init | Line: 20 | Upvalues: v1 (ref), CameraShaker (copy), ShakeCamera (copy) ]]
	v1 = CameraShaker.new(Enum.RenderPriority.Camera.Value + 1, ShakeCamera)
	v1:Start()
end
function t.Shake(p1) --[[ Shake | Line: 26 | Upvalues: v1 (ref) ]]
	if not v1 then
		return
	end

	v1:ShakeOnce(p1.magnitude, p1.rougness, p1.fadein, p1.fadeout, p1.PositionInfluence, p1.RotationInfluence)
end
function t.miscShake(p1) --[[ miscShake | Line: 39 | Upvalues: v1 (ref), CameraShaker (copy) ]]
	if not v1 then
		return
	end

	v1:Shake(if p1 then p1 else CameraShaker.Presets.Bump)
end
function t.Stop() --[[ Stop | Line: 47 | Upvalues: v1 (ref) ]]
	if not v1 then
		return
	end

	v1:Stop()
end

return t