-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	aimpartZOffset = 0.5
}
local CurrentCamera = workspace.CurrentCamera

function t.autoDetectMethod() --[[ autoDetectMethod | Line: 7 ]]
	return false
end
function t.modelDetectionPath() --[[ modelDetectionPath | Line: 13 | Upvalues: CurrentCamera (copy) ]]
	return CurrentCamera
end
function t.modelDetectionMethod(p1) --[[ modelDetectionMethod | Line: 17 ]]
	if not p1:IsA("Model") then
		return nil
	end

	local Model = p1:FindFirstChildOfClass("Model")

	if Model then
		return Model
	end

	return nil
end
function t.parentingMethod(p1) --[[ parentingMethod | Line: 31 ]]
	p1.Parent = workspace
end

return t