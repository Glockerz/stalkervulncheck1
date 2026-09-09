-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent:WaitForChild("common"))

local t = {}

t.__index = t
function t.handle(p1, p2) --[[ handle | Line: 28 ]]
	p1.handle_callback = p2
end
function create(p1, p2) --[[ create | Line: 32 | Upvalues: t (copy) ]]
	return setmetatable({
		identifier = p1,
		handle_callback = p2
	}, t)
end

return {
	create = create
}