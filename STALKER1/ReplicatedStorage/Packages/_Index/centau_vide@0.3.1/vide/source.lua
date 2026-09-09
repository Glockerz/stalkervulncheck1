-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1, v2, v3, v4

if game then
	v1 = require(script.Parent.graph)
	v2 = v1.create_source_node
	v3 = v1.push_child_to_scope
	v4 = v1.update_descendants

	return function(p13) --[[ source | Line: 11 | Upvalues: v2 (copy), v3 (copy), v4 (copy) ]]
		local v1 = v2(p13)

		return function(...) --[[ Line: 14 | Upvalues: v3 (ref), v1 (copy), v4 (ref) ]]
			if select("#", ...) == 0 then
				v3(v1)

				return v1.cache
			end

			local v12 = ...

			if v1.cache ~= v12 or type(v12) == "table" and not table.isfrozen(v12) then
				v1.cache = v12
				v4(v1)
			end

			return v12
		end
	end
end

script = require("test/relative-string")
v1 = require(script.Parent.graph)
v2 = v1.create_source_node
v3 = v1.push_child_to_scope
v4 = v1.update_descendants

return function(p13) --[[ source | Line: 11 | Upvalues: v2 (copy), v3 (copy), v4 (copy) ]]
	local v1 = v2(p13)

	return function(...) --[[ Line: 14 | Upvalues: v3 (ref), v1 (copy), v4 (ref) ]]
		if select("#", ...) == 0 then
			v3(v1)

			return v1.cache
		end

		local v12 = ...

		if v1.cache ~= v12 or type(v12) == "table" and not table.isfrozen(v12) then
			v1.cache = v12
			v4(v1)
		end

		return v12
	end
end