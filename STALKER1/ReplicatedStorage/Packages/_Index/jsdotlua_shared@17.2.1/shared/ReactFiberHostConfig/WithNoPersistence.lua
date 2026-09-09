-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local invariant = require(script.Parent.Parent:WaitForChild("invariant"))

local function shim(...) --[[ shim | Line: 16 | Upvalues: invariant (copy) ]]
	invariant(false, "The current renderer does not support persistence. This error is likely caused by a bug in React. Please file an issue.")
end

return {
	supportsPersistence = false,
	cloneInstance = shim,
	cloneFundamentalInstance = shim,
	createContainerChildSet = shim,
	appendChildToContainerChildSet = shim,
	finalizeContainerChildren = shim,
	replaceContainerChildren = shim,
	cloneHiddenInstance = shim,
	cloneHiddenTextInstance = shim
}