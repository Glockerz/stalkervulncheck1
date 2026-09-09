-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent:WaitForChild("shared"))
require(script.Parent:WaitForChild("ReactInternalTypes"))

local REACT_FORWARD_REF_TYPE = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols.REACT_FORWARD_REF_TYPE

return {
	resolveFunctionForHotReloading = function(p1) --[[ resolveFunctionForHotReloading | Line: 82 ]]
		local _ = _G.__DEV__

		return p1
	end,
	resolveClassForHotReloading = function(p1) --[[ resolveClassForHotReloading | Line: 100 ]]
		local _ = _G.__DEV__

		return p1
	end,
	resolveForwardRefForHotReloading = function(p1) --[[ resolveForwardRefForHotReloading | Line: 106 ]]
		local _ = _G.__DEV__

		return p1
	end,
	isCompatibleFamilyForHotReloading = function(p1, p2) --[[ Line: 144 ]]
		warn("isCompatibleFamilyForHotReloading is stubbed (returns false)")

		return false
	end,
	markFailedErrorBoundaryForHotReloading = function(p1) --[[ Line: 224 ]]
		local _ = _G.__DEV__
	end
}