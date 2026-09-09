-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1, v2, v3, v4, v5, v6, v7

if game then
	v1 = require(script.Parent.throw)
	v2 = require(script.Parent.graph)
	v3 = v2.create_node
	v4 = v2.push_scope
	v5 = v2.pop_scope
	v6 = v2.destroy
	v7 = {}

	return function(p13) --[[ root | Line: 13 | Upvalues: v3 (copy), v7 (copy), v1 (copy), v6 (copy), v4 (copy), v5 (copy) ]]
		local v12 = v3(false, false, false)

		v7[v12] = true

		local function f22() --[[ Line: 18 | Upvalues: v7 (ref), v12 (copy), v1 (ref), v6 (ref) ]]
			if not v7[v12] then
				v1("root already destroyed")
			end

			v7[v12] = nil
			v6(v12)
		end

		v4(v12)

		local function efn(p13) --[[ efn | Line: 26 ]]
			return debug.traceback(p13, 3)
		end

		local t2 = { xpcall(p13, efn, f22) }

		v5()

		if not t2[1] then
			if not v7[v12] then
				v1("root already destroyed")
			end

			v7[v12] = nil
			v6(v12)
			v1((("error while running root():\n\n%*"):format(t2[2])))
		end

		return f22, unpack(t2, 2)
	end
end

script = require("test/relative-string")
v1 = require(script.Parent.throw)
v2 = require(script.Parent.graph)
v3 = v2.create_node
v4 = v2.push_scope
v5 = v2.pop_scope
v6 = v2.destroy
v7 = {}

return function(p13) --[[ root | Line: 13 | Upvalues: v3 (copy), v7 (copy), v1 (copy), v6 (copy), v4 (copy), v5 (copy) ]]
	local v12 = v3(false, false, false)

	v7[v12] = true

	local function f22() --[[ Line: 18 | Upvalues: v7 (ref), v12 (copy), v1 (ref), v6 (ref) ]]
		if not v7[v12] then
			v1("root already destroyed")
		end

		v7[v12] = nil
		v6(v12)
	end

	v4(v12)

	local function efn(p13) --[[ efn | Line: 26 ]]
		return debug.traceback(p13, 3)
	end

	local t2 = { xpcall(p13, efn, f22) }

	v5()

	if not t2[1] then
		if not v7[v12] then
			v1("root already destroyed")
		end

		v7[v12] = nil
		v6(v12)
		v1((("error while running root():\n\n%*"):format(t2[2])))
	end

	return f22, unpack(t2, 2)
end