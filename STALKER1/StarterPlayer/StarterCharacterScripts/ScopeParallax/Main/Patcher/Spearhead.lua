-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	aimpartZOffset = 0,
	_SPEARHEAD_FOLDER_NAME = "SPH_Assets"
}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CurrentCamera = workspace.CurrentCamera
local Default = require(script.Parent:WaitForChild("Default"))

function t.autoDetectMethod() --[[ autoDetectMethod | Line: 10 | Upvalues: ReplicatedStorage (copy), t (copy) ]]
	if ReplicatedStorage:FindFirstChild(t._SPEARHEAD_FOLDER_NAME) then
		return script.Name
	end
end
function t.modelDetectionPath() --[[ modelDetectionPath | Line: 18 | Upvalues: CurrentCamera (copy) ]]
	return CurrentCamera:WaitForChild("WeaponRig"):WaitForChild("Weapon")
end
function t.modelDetectionMethod(p1) --[[ modelDetectionMethod | Line: 24 ]]
	return p1
end
t.parentingMethod = Default.parentingMethod

return t