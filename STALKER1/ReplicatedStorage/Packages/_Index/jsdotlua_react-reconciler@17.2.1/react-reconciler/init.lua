-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script:WaitForChild("ReactInternalTypes"))
require(script:WaitForChild("ReactRootTags"))

return function(p1) --[[ initialize | Line: 28 ]]
	local ReactFiberHostConfig = require(script:WaitForChild("ReactFiberHostConfig"))

	for v1, v2 in p1 do
		ReactFiberHostConfig[v1] = v2
	end

	return require(script:WaitForChild("ReactFiberReconciler"))
end