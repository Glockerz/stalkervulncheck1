-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	aimpartZOffset = 0.5,
	_7CHON_CLIENT_SCRIPT_NAME = "ACS_Clientv2",
	_7CHON_NEW_VERSION_IDENTIFIER = "Debugs"
}
local StarterCharacterScripts = game:GetService("StarterPlayer").StarterCharacterScripts
local Default = require(script.Parent:WaitForChild("Default"))
local CurrentCamera = workspace.CurrentCamera

function t.autoDetectMethod() --[[ autoDetectMethod | Line: 12 | Upvalues: StarterCharacterScripts (copy), t (copy) ]]
	local Saude = StarterCharacterScripts:FindFirstChild("Saude")

	if not Saude then
		return
	end

	local v1 = Saude:FindFirstChild(t._7CHON_CLIENT_SCRIPT_NAME)

	if v1 and v1:FindFirstChild(t._7CHON_NEW_VERSION_IDENTIFIER) then
		return script.Name
	end
end
t.modelDetectionPath = Default.modelDetectionPath
t.modelDetectionMethod = Default.modelDetectionMethod
function t.parentingMethod(p1) --[[ parentingMethod | Line: 30 ]]
	task.spawn(function() --[[ Line: 31 | Upvalues: p1 (copy) ]]
		repeat
			task.wait()
		until p1:FindFirstChildWhichIsA("Motor6D")

		p1.Parent = workspace
	end)
end

return t