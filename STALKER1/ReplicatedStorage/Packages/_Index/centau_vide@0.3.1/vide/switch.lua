-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1, v2, v3, v4, v5, v6, v7, v8, v9

if game then
	v1 = require(script.Parent.throw)
	v2 = require(script.Parent.graph)
	v3 = v2.create_node
	v4 = v2.evaluate_node
	v5 = v2.push_child_to_scope
	v6 = v2.destroy
	v7 = v2.assert_stable_scope
	v8 = v2.push_scope
	v9 = v2.pop_scope

	return function(p13) --[[ switch | Line: 17 | Upvalues: v7 (copy), v6 (copy), v1 (copy), v3 (copy), v8 (copy), v9 (copy), v4 (copy), v5 (copy) ]]
		local v12 = v7()

		return function(p1) --[[ Line: 20 | Upvalues: p13 (copy), v6 (ref), v1 (ref), v3 (ref), v12 (copy), v8 (ref), v9 (ref), v4 (ref), v5 (ref) ]]
			local v13 = nil
			local v2 = nil
			local v32 = v3(v12, function(p12) --[[ update | Line: 24 | Upvalues: p1 (copy), p13 (ref), v2 (ref), v13 (ref), v6 (ref), v1 (ref), v3 (ref), v12 (ref), v8 (ref), v9 (ref) ]]
				local v14 = p1[p13()]

				if v14 == v2 then
					return p12
				end

				v2 = v14

				if v13 then
					v6(v13)
					v13 = nil
				end

				if v14 == nil then
					return nil
				end

				if type(v14) ~= "function" then
					v1("map must map a value to a function")
				end

				local v22 = v3(v12, false, false)

				v13 = v22
				v8(v22)

				local ok, result = pcall(v14)

				v9()

				if not ok then
					error(result, 0)
				end

				return result
			end, nil)

			v4(v32)

			return function() --[[ Line: 58 | Upvalues: v5 (ref), v32 (copy) ]]
				v5(v32)

				return v32.cache
			end
		end
	end
end

script = require("test/relative-string")
v1 = require(script.Parent.throw)
v2 = require(script.Parent.graph)
v3 = v2.create_node
v4 = v2.evaluate_node
v5 = v2.push_child_to_scope
v6 = v2.destroy
v7 = v2.assert_stable_scope
v8 = v2.push_scope
v9 = v2.pop_scope

return function(p13) --[[ switch | Line: 17 | Upvalues: v7 (copy), v6 (copy), v1 (copy), v3 (copy), v8 (copy), v9 (copy), v4 (copy), v5 (copy) ]]
	local v12 = v7()

	return function(p1) --[[ Line: 20 | Upvalues: p13 (copy), v6 (ref), v1 (ref), v3 (ref), v12 (copy), v8 (ref), v9 (ref), v4 (ref), v5 (ref) ]]
		local v13 = nil
		local v2 = nil
		local v32 = v3(v12, function(p12) --[[ update | Line: 24 | Upvalues: p1 (copy), p13 (ref), v2 (ref), v13 (ref), v6 (ref), v1 (ref), v3 (ref), v12 (ref), v8 (ref), v9 (ref) ]]
			local v14 = p1[p13()]

			if v14 == v2 then
				return p12
			end

			v2 = v14

			if v13 then
				v6(v13)
				v13 = nil
			end

			if v14 == nil then
				return nil
			end

			if type(v14) ~= "function" then
				v1("map must map a value to a function")
			end

			local v22 = v3(v12, false, false)

			v13 = v22
			v8(v22)

			local ok, result = pcall(v14)

			v9()

			if not ok then
				error(result, 0)
			end

			return result
		end, nil)

		v4(v32)

		return function() --[[ Line: 58 | Upvalues: v5 (ref), v32 (copy) ]]
			v5(v32)

			return v32.cache
		end
	end
end