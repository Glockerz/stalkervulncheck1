-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent:WaitForChild("ReactInternalTypes"))

local v1 = require(script.Parent:WaitForChild("ReactFiberStack.new"))
local push = v1.push
local pop = v1.pop
local t = {
	InvisibleParentSuspenseContext = 1,
	ForceSuspenseFallback = 2
}
local v2 = v1.createCursor(0)

t.suspenseStackCursor = v2
function t.hasSuspenseContext(p1, p2) --[[ hasSuspenseContext | Line: 59 ]]
	return bit32.band(p1, p2) ~= 0
end
function t.setDefaultShallowSuspenseContext(p1) --[[ setDefaultShallowSuspenseContext | Line: 66 ]]
	return bit32.band(p1, 1)
end
function t.setShallowSuspenseContext(p1, p2) --[[ setShallowSuspenseContext | Line: 72 ]]
	return bit32.bor(bit32.band(p1, 1), p2)
end
function t.addSubtreeSuspenseContext(p1, p2) --[[ addSubtreeSuspenseContext | Line: 82 ]]
	return bit32.bor(p1, p2)
end
function t.pushSuspenseContext(p1, p2) --[[ pushSuspenseContext | Line: 89 | Upvalues: push (copy), v2 (copy) ]]
	push(v2, p2, p1)
end
function t.popSuspenseContext(p1) --[[ popSuspenseContext | Line: 93 | Upvalues: pop (copy), v2 (copy) ]]
	pop(v2, p1)
end

return t