-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = require(script.Parent.Parent:WaitForChild("Type.roblox"))
local t = {}
local t2 = {
	__tostring = function(p1) --[[ __tostring | Line: 33 ]]
		return string.format("RoactHostChangeEvent(%s)", p1.name)
	end
}

setmetatable(t, {
	__index = function(p1, p2) --[[ __index | Line: 39 | Upvalues: v1 (copy), t2 (copy), t (copy) ]]
		local t3 = {
			[v1] = v1.HostChangeEvent,
			name = p2
		}

		setmetatable(t3, t2)
		t[p2] = t3

		return t3
	end
})

return t