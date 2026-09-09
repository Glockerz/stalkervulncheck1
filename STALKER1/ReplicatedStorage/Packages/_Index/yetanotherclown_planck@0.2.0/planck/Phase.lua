-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
function t.__tostring(p1) --[[ __tostring | Line: 8 ]]
	return p1._name
end
function t.new(p1) --[[ new | Line: 16 | Upvalues: t (copy) ]]
	return setmetatable({
		_type = "phase",
		_name = if p1 then p1 else debug.info(2, "sl")
	}, t)
end
t.PreStartup = t.new("PreStartup")
t.Startup = t.new("Startup")
t.PostStartup = t.new("PostStartup")

return t