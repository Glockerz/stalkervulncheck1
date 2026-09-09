-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1, v2, v3, v4, v5, v6, v7, v8, v9

if game then
	v1 = require(script.Parent.throw)
	v2 = require(script.Parent.graph)
	v3 = v2.create_node
	v4 = v2.get_scope
	v5 = v2.push_scope
	v6 = v2.pop_scope
	v7 = v2.set_context
	v8 = newproxy()
	v9 = 0

	return function(...) --[[ context | Line: 17 | Upvalues: v9 (ref), v4 (copy), v8 (copy), v1 (copy), v3 (copy), v7 (copy), v5 (copy), v6 (copy) ]]
		v9 = v9 + 1

		local v12 = v9
		local v2 = select("#", ...) > 0
		local v32 = ...

		return function(...) --[[ Line: 24 | Upvalues: v4 (ref), v12 (copy), v8 (ref), v2 (copy), v32 (copy), v1 (ref), v3 (ref), v7 (ref), v5 (ref), v6 (ref) ]]
			local v13 = v4()

			if select("#", ...) == 0 then
				while v13 do
					local context = v13.context

					if context then
						local v22 = context[v12]

						if v22 == nil then
							v13 = v13.owner
						else
							if v22 == v8 then
								return nil
							end

							return v22
						end
					else
						v13 = v13.owner
					end
				end

				if v2 == nil then
					v1("attempt to get context when no context is set and no default context is set")

					return nil
				end

				return v32
			end

			if not v13 then
				return v1("attempt to set context outside of a vide scope")
			end

			local v33, v42 = ...
			local v52 = v3(v13, false, false)

			v7(v52, v12, if v33 == nil then v8 else v33)
			v5(v52)

			local function efn(p13) --[[ efn | Line: 61 ]]
				return debug.traceback(p13, 3)
			end

			local ok, result = xpcall(v42, efn)

			v6()

			if not ok then
				v1((("error while running context:\n\n%*"):format(result)))
			end

			return result
		end
	end
end

script = require("test/relative-string")
v1 = require(script.Parent.throw)
v2 = require(script.Parent.graph)
v3 = v2.create_node
v4 = v2.get_scope
v5 = v2.push_scope
v6 = v2.pop_scope
v7 = v2.set_context
v8 = newproxy()
v9 = 0

return function(...) --[[ context | Line: 17 | Upvalues: v9 (ref), v4 (copy), v8 (copy), v1 (copy), v3 (copy), v7 (copy), v5 (copy), v6 (copy) ]]
	v9 = v9 + 1

	local v12 = v9
	local v2 = select("#", ...) > 0
	local v32 = ...

	return function(...) --[[ Line: 24 | Upvalues: v4 (ref), v12 (copy), v8 (ref), v2 (copy), v32 (copy), v1 (ref), v3 (ref), v7 (ref), v5 (ref), v6 (ref) ]]
		local v13 = v4()

		if select("#", ...) == 0 then
			while v13 do
				local context = v13.context

				if context then
					local v22 = context[v12]

					if v22 == nil then
						v13 = v13.owner
					else
						if v22 == v8 then
							return nil
						end

						return v22
					end
				else
					v13 = v13.owner
				end
			end

			if v2 == nil then
				v1("attempt to get context when no context is set and no default context is set")

				return nil
			end

			return v32
		end

		if not v13 then
			return v1("attempt to set context outside of a vide scope")
		end

		local v33, v42 = ...
		local v52 = v3(v13, false, false)

		v7(v52, v12, if v33 == nil then v8 else v33)
		v5(v52)

		local function efn(p13) --[[ efn | Line: 61 ]]
			return debug.traceback(p13, 3)
		end

		local ok, result = xpcall(v42, efn)

		v6()

		if not ok then
			v1((("error while running context:\n\n%*"):format(result)))
		end

		return result
	end
end