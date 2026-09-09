-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent:WaitForChild("luau-polyfill"))

local supportsTestSelectors = require(script.Parent:WaitForChild("ReactFiberHostConfig")).supportsTestSelectors
local t = {}
local t2 = {}

function t.onCommitRoot() --[[ Line: 511 | Upvalues: supportsTestSelectors (copy), t2 (copy) ]]
	if not supportsTestSelectors then
		return
	end

	for v1, v2 in t2 do
		v2()
	end
end

return t