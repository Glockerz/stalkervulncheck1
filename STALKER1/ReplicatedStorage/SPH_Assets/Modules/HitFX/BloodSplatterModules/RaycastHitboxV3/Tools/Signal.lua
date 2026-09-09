-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
function t.Create(p1) --[[ Create | Line: 6 | Upvalues: t (copy) ]]
	return setmetatable({}, t)
end
function t.Connect(p1, p2) --[[ Connect | Line: 10 ]]
	p1[1] = p2
end
function t.Fire(p1, ...) --[[ Fire | Line: 14 ]]
	if p1[1] then
		coroutine.resume(coroutine.create(p1[1]), ...)
	end
end
function t.Delete(p1) --[[ Delete | Line: 21 ]]
	p1[1] = nil
end

return t