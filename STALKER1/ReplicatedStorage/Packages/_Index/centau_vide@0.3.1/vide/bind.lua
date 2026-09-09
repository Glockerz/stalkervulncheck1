-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1, v2, v3, v4, v5, v6, v7

if game then
	v1 = require(script.Parent.graph)
	v2 = v1.create_node
	v3 = v1.assert_stable_scope
	v4 = v1.evaluate_node
	function create_implicit_effect(p13, p23) --[[ create_implicit_effect | Line: 9 | Upvalues: v4 (copy), v2 (copy), v3 (copy) ]]
		v4(v2(v3(), p13, p23))
	end
	v5 = function(p13) --[[ update_property_effect | Line: 19 ]]
		p13.instance[p13.property] = p13.source()

		return p13
	end
	v6 = function(p13) --[[ update_parent_effect | Line: 29 ]]
		p13.instance.Parent = p13.parent()

		return p13
	end
	v7 = function(p13) --[[ update_children_effect | Line: 42 ]]
		local cur_children_set = p13.cur_children_set
		local new_children_set = p13.new_children_set
		local v1 = p13.children()

		if type(v1) ~= "table" then
			v1 = { v1 }
		end

		local function v2(p1) --[[ process_child | Line: 52 | Upvalues: v2 (copy), new_children_set (copy), cur_children_set (copy), p13 (copy) ]]
			if type(p1) == "table" then
				for v1, v22 in next, p1 do
					v2(v22)
				end
			else
				if new_children_set[p1] then
					return
				end

				new_children_set[p1] = true

				if cur_children_set[p1] then
					cur_children_set[p1] = nil
				else
					p1.Parent = p13.instance
				end
			end
		end

		v2(v1)

		for v3 in next, cur_children_set do
			v3.Parent = nil
		end

		table.clear(cur_children_set)
		p13.cur_children_set = new_children_set
		p13.new_children_set = cur_children_set

		return p13
	end

	return {
		property = function(p13, p23, p33) --[[ property | Line: 82 | Upvalues: v5 (copy) ]]
			return create_implicit_effect(v5, {
				instance = p13,
				property = p23,
				source = p33
			})
		end,
		parent = function(p13, p23) --[[ parent | Line: 90 | Upvalues: v6 (copy) ]]
			return create_implicit_effect(v6, {
				instance = p13,
				parent = p23
			})
		end,
		children = function(p13, p23) --[[ children | Line: 97 | Upvalues: v7 (copy) ]]
			return create_implicit_effect(v7, {
				instance = p13,
				cur_children_set = {},
				new_children_set = {},
				children = p23
			})
		end
	}
end

script = require("test/relative-string")
v1 = require(script.Parent.graph)
v2 = v1.create_node
v3 = v1.assert_stable_scope
v4 = v1.evaluate_node
function create_implicit_effect(p13, p23) --[[ create_implicit_effect | Line: 9 | Upvalues: v4 (copy), v2 (copy), v3 (copy) ]]
	v4(v2(v3(), p13, p23))
end
v5 = function(p13) --[[ update_property_effect | Line: 19 ]]
	p13.instance[p13.property] = p13.source()

	return p13
end
v6 = function(p13) --[[ update_parent_effect | Line: 29 ]]
	p13.instance.Parent = p13.parent()

	return p13
end
v7 = function(p13) --[[ update_children_effect | Line: 42 ]]
	local cur_children_set = p13.cur_children_set
	local new_children_set = p13.new_children_set
	local v1 = p13.children()

	if type(v1) ~= "table" then
		v1 = { v1 }
	end

	local function v2(p1) --[[ process_child | Line: 52 | Upvalues: v2 (copy), new_children_set (copy), cur_children_set (copy), p13 (copy) ]]
		if type(p1) == "table" then
			for v1, v22 in next, p1 do
				v2(v22)
			end
		else
			if new_children_set[p1] then
				return
			end

			new_children_set[p1] = true

			if cur_children_set[p1] then
				cur_children_set[p1] = nil
			else
				p1.Parent = p13.instance
			end
		end
	end

	v2(v1)

	for v3 in next, cur_children_set do
		v3.Parent = nil
	end

	table.clear(cur_children_set)
	p13.cur_children_set = new_children_set
	p13.new_children_set = cur_children_set

	return p13
end

return {
	property = function(p13, p23, p33) --[[ property | Line: 82 | Upvalues: v5 (copy) ]]
		return create_implicit_effect(v5, {
			instance = p13,
			property = p23,
			source = p33
		})
	end,
	parent = function(p13, p23) --[[ parent | Line: 90 | Upvalues: v6 (copy) ]]
		return create_implicit_effect(v6, {
			instance = p13,
			parent = p23
		})
	end,
	children = function(p13, p23) --[[ children | Line: 97 | Upvalues: v7 (copy) ]]
		return create_implicit_effect(v7, {
			instance = p13,
			cur_children_set = {},
			new_children_set = {},
			children = p23
		})
	end
}