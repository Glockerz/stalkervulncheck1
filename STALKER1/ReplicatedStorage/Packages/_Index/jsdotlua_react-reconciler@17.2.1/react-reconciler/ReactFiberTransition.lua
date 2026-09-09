-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReactCurrentBatchConfig = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals.ReactCurrentBatchConfig

return {
	NoTransition = 0,
	requestCurrentTransition = function() --[[ requestCurrentTransition | Line: 18 | Upvalues: ReactCurrentBatchConfig (copy) ]]
		return ReactCurrentBatchConfig.transition
	end
}