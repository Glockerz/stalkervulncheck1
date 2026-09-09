-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15

if game then
	v1 = require(script.Parent.throw)
	v2 = require(script.Parent.flags)
	v3 = require(script.Parent.graph)
	v4 = v3.create_node
	v5 = v3.create_source_node
	v6 = v3.push_child_to_scope
	v7 = v3.update_descendants
	v8 = v3.assert_stable_scope
	v9 = v3.push_scope
	v10 = v3.pop_scope
	v11 = v3.evaluate_node
	v12 = v3.destroy
	v13 = function(p13) --[[ check_primitives | Line: 20 | Upvalues: v2 (copy), v1 (copy) ]]
		if not v2.strict then
			return
		end

		for v12, v22 in next, p13 do
			if type(v22) ~= "table" and (type(v22) ~= "userdata" and type(v22) ~= "function") then
				v1("table source map cannot return primitives")
			end
		end
	end
	v14 = function(p13, p23) --[[ indexes | Line: 29 | Upvalues: v8 (copy), v4 (copy), v12 (copy), v9 (copy), v5 (copy), v6 (copy), v10 (copy), v7 (copy), v13 (copy), v11 (copy) ]]
		local v1 = v8()
		local v2 = v4(v1, false, false)
		local t2 = {}
		local t22 = {}
		local t3 = {}
		local t4 = {}
		local t5 = {}

		local function update_children(p13) --[[ update_children | Line: 39 | Upvalues: t2 (copy), t4 (copy), v12 (ref), t5 (copy), t22 (copy), t3 (copy), v9 (ref), v2 (copy), v4 (ref), v5 (ref), p23 (copy), v6 (ref), v10 (ref), v7 (ref), v13 (ref) ]]
			for v1 in next, t2 do
				if p13[v1] == nil then
					table.insert(t4, v1)
				end
			end

			for v3, v42 in next, t4 do
				v12(t5[v42])
				t2[v42] = nil
				t22[v42] = nil
				t3[v42] = nil
				t5[v42] = nil
			end

			table.clear(t4)
			v9(v2)

			for v52, v62 in next, p13 do
				local v72 = t2[v52]

				if v72 ~= v62 then
					if v72 == nil then
						local v8 = v4(v2, false, false)

						t5[v52] = v8

						local v92 = v5(v62)

						v9(v8)

						local ok, result = pcall(p23, function() --[[ Line: 74 | Upvalues: v6 (ref), v92 (copy) ]]
							v6(v92)

							return v92.cache
						end, v52)

						v10()

						if not ok then
							v10()
							error(result, 0)
						end

						t3[v52] = v92
						t22[v52] = result
					else
						t3[v52].cache = v62
						v7(t3[v52])
					end

					t2[v52] = v62
				end
			end

			v10()

			local v102 = table.create(#t5)

			for v11, v122 in next, t22 do
				table.insert(v102, v122)
			end

			v13(v102)

			return v102
		end

		local v3 = v4(v1, function() --[[ Line: 108 | Upvalues: update_children (copy), p13 (copy) ]]
			return update_children(p13())
		end, false)

		v11(v3)

		return function() --[[ Line: 114 | Upvalues: v6 (ref), v3 (copy) ]]
			v6(v3)

			return v3.cache
		end
	end
	v15 = function(p13, p23) --[[ values | Line: 120 | Upvalues: v8 (copy), v4 (copy), v2 (copy), v1 (copy), v9 (copy), v5 (copy), v6 (copy), v10 (copy), v7 (copy), v12 (copy), v13 (copy), v11 (copy) ]]
		local v14 = v8()
		local v22 = v4(v14, false, false)
		local t2 = {}
		local t22 = {}
		local t3 = {}
		local t4 = {}
		local t5 = {}

		local function update_children(p13) --[[ update_children | Line: 130 | Upvalues: t2 (ref), t22 (ref), v2 (ref), v1 (ref), v9 (ref), v22 (copy), v4 (ref), t5 (copy), v5 (ref), p23 (copy), v6 (ref), v10 (ref), t4 (copy), t3 (copy), v7 (ref), v12 (ref), v13 (ref) ]]
			local v14 = t2
			local v23 = t22

			if v2.strict then
				local t6 = {}

				for v3, v42 in next, p13 do
					if t6[v42] ~= nil then
						v1("duplicate table value detected")
					end

					t6[v42] = true
				end
			end

			v9(v22)

			for v52, v62 in next, p13 do
				v23[v62] = v52

				local v72 = v14[v62]

				if v72 == nil then
					local v8 = v4(v22, false, false)

					t5[v62] = v8

					local v92 = v5(v52)

					v9(v8)

					local ok, result = pcall(p23, v62, function() --[[ Line: 159 | Upvalues: v6 (ref), v92 (copy) ]]
						v6(v92)

						return v92.cache
					end)

					v10()

					if not ok then
						v10()
						error(result, 0)
					end

					t4[v62] = v92
					t3[v62] = result

					continue
				end

				if v72 ~= v52 then
					t4[v62].cache = v52
					v7(t4[v62])
				end

				v14[v62] = nil
			end

			v10()

			for v102 in next, v14 do
				v12(t5[v102])
				t3[v102] = nil
				t4[v102] = nil
				t5[v102] = nil
			end

			table.clear(v14)
			t2 = v23
			t22 = v14

			local v11 = table.create(#t5)

			for v122, v132 in next, t3 do
				table.insert(v11, v132)
			end

			v13(v11)

			return v11
		end

		local v3 = v4(v14, function() --[[ Line: 207 | Upvalues: update_children (copy), p13 (copy) ]]
			return update_children(p13())
		end, false)

		v11(v3)

		return function() --[[ Line: 213 | Upvalues: v6 (ref), v3 (copy) ]]
			v6(v3)

			return v3.cache
		end
	end

	return function() --[[ Line: 219 | Upvalues: v14 (copy), v15 (copy) ]]
		return v14, v15
	end
end

script = require("test/relative-string")
v1 = require(script.Parent.throw)
v2 = require(script.Parent.flags)
v3 = require(script.Parent.graph)
v4 = v3.create_node
v5 = v3.create_source_node
v6 = v3.push_child_to_scope
v7 = v3.update_descendants
v8 = v3.assert_stable_scope
v9 = v3.push_scope
v10 = v3.pop_scope
v11 = v3.evaluate_node
v12 = v3.destroy
v13 = function(p13) --[[ check_primitives | Line: 20 | Upvalues: v2 (copy), v1 (copy) ]]
	if not v2.strict then
		return
	end

	for v12, v22 in next, p13 do
		if type(v22) ~= "table" and (type(v22) ~= "userdata" and type(v22) ~= "function") then
			v1("table source map cannot return primitives")
		end
	end
end
v14 = function(p13, p23) --[[ indexes | Line: 29 | Upvalues: v8 (copy), v4 (copy), v12 (copy), v9 (copy), v5 (copy), v6 (copy), v10 (copy), v7 (copy), v13 (copy), v11 (copy) ]]
	local v1 = v8()
	local v2 = v4(v1, false, false)
	local t2 = {}
	local t22 = {}
	local t3 = {}
	local t4 = {}
	local t5 = {}

	local function update_children(p13) --[[ update_children | Line: 39 | Upvalues: t2 (copy), t4 (copy), v12 (ref), t5 (copy), t22 (copy), t3 (copy), v9 (ref), v2 (copy), v4 (ref), v5 (ref), p23 (copy), v6 (ref), v10 (ref), v7 (ref), v13 (ref) ]]
		for v1 in next, t2 do
			if p13[v1] == nil then
				table.insert(t4, v1)
			end
		end

		for v3, v42 in next, t4 do
			v12(t5[v42])
			t2[v42] = nil
			t22[v42] = nil
			t3[v42] = nil
			t5[v42] = nil
		end

		table.clear(t4)
		v9(v2)

		for v52, v62 in next, p13 do
			local v72 = t2[v52]

			if v72 ~= v62 then
				if v72 == nil then
					local v8 = v4(v2, false, false)

					t5[v52] = v8

					local v92 = v5(v62)

					v9(v8)

					local ok, result = pcall(p23, function() --[[ Line: 74 | Upvalues: v6 (ref), v92 (copy) ]]
						v6(v92)

						return v92.cache
					end, v52)

					v10()

					if not ok then
						v10()
						error(result, 0)
					end

					t3[v52] = v92
					t22[v52] = result
				else
					t3[v52].cache = v62
					v7(t3[v52])
				end

				t2[v52] = v62
			end
		end

		v10()

		local v102 = table.create(#t5)

		for v11, v122 in next, t22 do
			table.insert(v102, v122)
		end

		v13(v102)

		return v102
	end

	local v3 = v4(v1, function() --[[ Line: 108 | Upvalues: update_children (copy), p13 (copy) ]]
		return update_children(p13())
	end, false)

	v11(v3)

	return function() --[[ Line: 114 | Upvalues: v6 (ref), v3 (copy) ]]
		v6(v3)

		return v3.cache
	end
end
v15 = function(p13, p23) --[[ values | Line: 120 | Upvalues: v8 (copy), v4 (copy), v2 (copy), v1 (copy), v9 (copy), v5 (copy), v6 (copy), v10 (copy), v7 (copy), v12 (copy), v13 (copy), v11 (copy) ]]
	local v14 = v8()
	local v22 = v4(v14, false, false)
	local t2 = {}
	local t22 = {}
	local t3 = {}
	local t4 = {}
	local t5 = {}

	local function update_children(p13) --[[ update_children | Line: 130 | Upvalues: t2 (ref), t22 (ref), v2 (ref), v1 (ref), v9 (ref), v22 (copy), v4 (ref), t5 (copy), v5 (ref), p23 (copy), v6 (ref), v10 (ref), t4 (copy), t3 (copy), v7 (ref), v12 (ref), v13 (ref) ]]
		local v14 = t2
		local v23 = t22

		if v2.strict then
			local t6 = {}

			for v3, v42 in next, p13 do
				if t6[v42] ~= nil then
					v1("duplicate table value detected")
				end

				t6[v42] = true
			end
		end

		v9(v22)

		for v52, v62 in next, p13 do
			v23[v62] = v52

			local v72 = v14[v62]

			if v72 == nil then
				local v8 = v4(v22, false, false)

				t5[v62] = v8

				local v92 = v5(v52)

				v9(v8)

				local ok, result = pcall(p23, v62, function() --[[ Line: 159 | Upvalues: v6 (ref), v92 (copy) ]]
					v6(v92)

					return v92.cache
				end)

				v10()

				if not ok then
					v10()
					error(result, 0)
				end

				t4[v62] = v92
				t3[v62] = result

				continue
			end

			if v72 ~= v52 then
				t4[v62].cache = v52
				v7(t4[v62])
			end

			v14[v62] = nil
		end

		v10()

		for v102 in next, v14 do
			v12(t5[v102])
			t3[v102] = nil
			t4[v102] = nil
			t5[v102] = nil
		end

		table.clear(v14)
		t2 = v23
		t22 = v14

		local v11 = table.create(#t5)

		for v122, v132 in next, t3 do
			table.insert(v11, v132)
		end

		v13(v11)

		return v11
	end

	local v3 = v4(v14, function() --[[ Line: 207 | Upvalues: update_children (copy), p13 (copy) ]]
		return update_children(p13())
	end, false)

	v11(v3)

	return function() --[[ Line: 213 | Upvalues: v6 (ref), v3 (copy) ]]
		v6(v3)

		return v3.cache
	end
end

return function() --[[ Line: 219 | Upvalues: v14 (copy), v15 (copy) ]]
	return v14, v15
end