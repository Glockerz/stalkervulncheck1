-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = require(script.Parent:WaitForChild("Symbol.roblox"))
local v2 = newproxy(true)
local t = {}

local function addType(p1) --[[ addType | Line: 32 | Upvalues: t (copy), v1 (copy) ]]
	t[p1] = v1.named("Roact" .. p1)
end

t.HostChangeEvent = v1.named("RoactHostChangeEvent")
t.HostEvent = v1.named("RoactHostEvent")
function t.of(p1) --[[ of | Line: 39 | Upvalues: v2 (copy) ]]
	if typeof(p1) == "table" then
		return p1[v2]
	end

	return nil
end
getmetatable(v2).__index = t
getmetatable(v2).__tostring = function() --[[ Line: 49 ]]
	return "RoactType"
end

return v2