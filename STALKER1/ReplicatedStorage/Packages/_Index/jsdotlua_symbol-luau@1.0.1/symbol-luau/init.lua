-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Symbol = require(script:WaitForChild("Symbol"))
local v1 = require(script:WaitForChild("Registry.global"))
local v2 = setmetatable({}, {
	__call = function(p1, p2) --[[ __call | Line: 15 | Upvalues: Symbol (copy) ]]
		return Symbol.new(p2)
	end
})

v2.for_ = v1.getOrInit

return v2