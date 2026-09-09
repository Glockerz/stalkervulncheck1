-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = _G.UserInputService or game:GetService("UserInputService")

require("@self/types")

local v2 = require("@self/input")
local v3 = require("@self/getInputDevice")

return {
	input = v2,
	update = function(p1) --[[ update | Line: 35 ]]
		for v1, v2 in p1 do
			v2:update()
		end
	end,
	device = function(p1) --[[ device | Line: 54 | Upvalues: v3 (copy), v1 (copy) ]]
		return v3(if p1 then p1 else v1:GetLastInputType())
	end
}