-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1, v2, v3, v4, v5

if game then
	v1 = require(script.Parent.graph)
	v2 = v1.create_node
	v3 = v1.push_child_to_scope
	v4 = v1.assert_stable_scope
	v5 = v1.evaluate_node

	return function(p13) --[[ derive | Line: 9 | Upvalues: v2 (copy), v4 (copy), v5 (copy), v3 (copy) ]]
		local v1 = v2(v4(), p13, false)

		v5(v1)

		return function() --[[ Line: 14 | Upvalues: v3 (ref), v1 (copy) ]]
			v3(v1)

			return v1.cache
		end
	end
end

script = require("test/relative-string")
v1 = require(script.Parent.graph)
v2 = v1.create_node
v3 = v1.push_child_to_scope
v4 = v1.assert_stable_scope
v5 = v1.evaluate_node

return function(p13) --[[ derive | Line: 9 | Upvalues: v2 (copy), v4 (copy), v5 (copy), v3 (copy) ]]
	local v1 = v2(v4(), p13, false)

	v5(v1)

	return function() --[[ Line: 14 | Upvalues: v3 (ref), v1 (copy) ]]
		v3(v1)

		return v1.cache
	end
end