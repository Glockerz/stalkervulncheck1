-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent:WaitForChild("ReactInternalTypes"))

local v1 = require(script.Parent:WaitForChild("ReactFiberStack.new"))
local ReactFiberHostConfig = require(script.Parent:WaitForChild("ReactFiberHostConfig"))
local getChildHostContext = ReactFiberHostConfig.getChildHostContext
local getRootHostContext = ReactFiberHostConfig.getRootHostContext
local createCursor = v1.createCursor
local push = v1.push
local pop = v1.pop
local t = {}
local v2 = createCursor(t)
local v3 = createCursor(t)
local v4 = createCursor(t)

function requiredContext(p1) --[[ requiredContext | Line: 40 ]]
	return p1
end
function getRootHostContainer() --[[ getRootHostContainer | Line: 50 | Upvalues: v4 (copy) ]]
	return v4.current
end
function pushHostContainer(p1, p2) --[[ pushHostContainer | Line: 57 | Upvalues: push (copy), v4 (copy), v3 (copy), v2 (copy), t (copy), getRootHostContext (copy), pop (copy) ]]
	push(v4, p2, p1)
	push(v3, p1, p1)
	push(v2, t, p1)

	local v1 = getRootHostContext(p2)

	pop(v2, p1)
	push(v2, v1, p1)
end
function popHostContainer(p1) --[[ popHostContainer | Line: 77 | Upvalues: pop (copy), v2 (copy), v3 (copy), v4 (copy) ]]
	pop(v2, p1)
	pop(v3, p1)
	pop(v4, p1)
end
function getHostContext() --[[ getHostContext | Line: 83 | Upvalues: v2 (copy) ]]
	return v2.current
end
function pushHostContext(p1) --[[ pushHostContext | Line: 90 | Upvalues: v4 (copy), v2 (copy), getChildHostContext (copy), push (copy), v3 (copy) ]]
	local v1 = requiredContext(v4.current)
	local v22 = requiredContext(v2.current)
	local v32 = getChildHostContext(v22, p1.type, v1)

	if v22 ~= v32 then
		push(v3, p1, p1)
		push(v2, v32, p1)
	end
end
function popHostContext(p1) --[[ popHostContext | Line: 106 | Upvalues: v3 (copy), pop (copy), v2 (copy) ]]
	if v3.current == p1 then
		pop(v2, p1)
		pop(v3, p1)
	end
end

return {
	getHostContext = getHostContext,
	getRootHostContainer = getRootHostContainer,
	popHostContainer = popHostContainer,
	popHostContext = popHostContext,
	pushHostContainer = pushHostContainer,
	pushHostContext = pushHostContext
}