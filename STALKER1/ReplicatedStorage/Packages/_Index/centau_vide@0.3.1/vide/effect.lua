-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1, v2, v3, v4

if game then
	v1 = require(script.Parent.graph)
	v2 = v1.create_node
	v3 = v1.assert_stable_scope
	v4 = v1.evaluate_node

	return function(p13, p23) --[[ effect | Line: 8 | Upvalues: v2 (copy), v3 (copy), v4 (copy) ]]
		v4((v2(v3(), p13, p23)))
	end
end

script = require("test/relative-string")
v1 = require(script.Parent.graph)
v2 = v1.create_node
v3 = v1.assert_stable_scope
v4 = v1.evaluate_node

return function(p13, p23) --[[ effect | Line: 8 | Upvalues: v2 (copy), v3 (copy), v4 (copy) ]]
	v4((v2(v3(), p13, p23)))
end