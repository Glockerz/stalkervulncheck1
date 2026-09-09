-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
if not game then
	script = require("test/relative-string")
end

local v1 = game and Vector3 or require("test/mock").Vector3
local throw = require(script.Parent.throw)
local graph = require(script.Parent.graph)
local create_node = graph.create_node
local create_source_node = graph.create_source_node
local assert_stable_scope = graph.assert_stable_scope
local evaluate_node = graph.evaluate_node
local update_descendants = graph.update_descendants
local push_child_to_scope = graph.push_child_to_scope

local function Vec3(p1, p2, p3) --[[ Vec3 | Line: 40 | Upvalues: v1 (copy) ]]
	return v1.new(p1, p2, p3)
end

local v2 = v1.new(0, 0, 0)
local t = {
	number = function(p1) --[[ Line: 69 | Upvalues: v1 (copy), v2 (copy) ]]
		return v1.new(p1, 0, 0), v2
	end,
	CFrame = function(p1) --[[ Line: 73 | Upvalues: Vec3 (copy) ]]
		return p1.Position, Vec3(p1:ToEulerAnglesXYZ())
	end,
	Color3 = function(p1) --[[ Line: 77 | Upvalues: v1 (copy), v2 (copy) ]]
		return v1.new(p1.R, p1.G, p1.B), v2
	end,
	UDim = function(p1) --[[ Line: 82 | Upvalues: v1 (copy), v2 (copy) ]]
		return v1.new(p1.Scale, p1.Offset, 0), v2
	end,
	UDim2 = function(p1) --[[ Line: 86 | Upvalues: v1 (copy), Vec3 (copy) ]]
		return v1.new(p1.X.Scale, p1.X.Offset, p1.Y.Scale), Vec3(p1.Y.Offset, 0, 0)
	end,
	Vector2 = function(p1) --[[ Line: 90 | Upvalues: v1 (copy), v2 (copy) ]]
		return v1.new(p1.X, p1.Y, 0), v2
	end,
	Vector3 = function(p1) --[[ Line: 94 | Upvalues: v2 (copy) ]]
		return p1, v2
	end,
	Rect = function(p1) --[[ Line: 98 | Upvalues: v1 (copy), Vec3 (copy) ]]
		return v1.new(p1.Min.X, p1.Min.Y, p1.Max.X), Vec3(p1.Max.Y, 0, 0)
	end
}
local t2 = {
	number = function(p1, p2) --[[ Line: 104 ]]
		return p1.X
	end,
	CFrame = function(p1, p2) --[[ Line: 108 ]]
		return CFrame.new(p1) * CFrame.fromEulerAnglesXYZ(p2.X, p2.Y, p2.Z)
	end,
	Color3 = function(p1) --[[ Line: 112 ]]
		return Color3.new(math.clamp(p1.X, 0, 1), math.clamp(p1.Y, 0, 1), (math.clamp(p1.Z, 0, 1)))
	end,
	UDim = function(p1) --[[ Line: 116 ]]
		return UDim.new(p1.X, (math.round(p1.Y)))
	end,
	UDim2 = function(p1, p2) --[[ Line: 120 ]]
		return UDim2.new(p1.X, math.round(p1.Y), p1.Z, (math.round(p2.X)))
	end,
	Vector2 = function(p1) --[[ Line: 124 ]]
		return Vector2.new(p1.X, p1.Y)
	end,
	Vector3 = function(p1) --[[ Line: 128 ]]
		return p1
	end,
	Rect = function(p1, p2) --[[ Line: 132 ]]
		return Rect.new(p1.X, p1.Y, p1.Z, p2.X)
	end
}
local t3 = {
	__index = function(p1, p2) --[[ __index | Line: 138 | Upvalues: throw (copy) ]]
		throw((("cannot spring type %*"):format(p2)))
	end
}

setmetatable(t, t3)
setmetatable(t2, t3)

local t4 = {}

setmetatable(t4, {
	__mode = "v"
})

local function spring(p1, p2, p3) --[[ spring | Line: 151 | Upvalues: assert_stable_scope (copy), throw (copy), v2 (copy), create_source_node (copy), t (copy), t4 (copy), create_node (copy), evaluate_node (copy), push_child_to_scope (copy) ]]
	local v1 = assert_stable_scope()
	local v22 = 6.283185307179586 / (p2 or 1)
	local v3 = v22 ^ 2
	local v4 = (p3 or 1) * (2 * v22)
	local v5, v6, v7, v8

	if not (v4 > 240) then
		v5 = {
			source_value = false,
			k = v3,
			c = v4,
			x0_123 = v2,
			x1_123 = v2,
			v_123 = v2,
			x0_456 = v2,
			x1_456 = v2,
			v_456 = v2
		}
		v6 = create_source_node(false)
		evaluate_node((create_node(v1, function() --[[ updater_effect | Line: 186 | Upvalues: p1 (copy), v5 (copy), t (ref), t4 (ref), v6 (copy) ]]
			local v1 = p1()
			local v4, v52 = t[typeof(v1)](v1)

			v5.x1_123 = v4
			v5.x1_456 = v52
			v5.source_value = v1
			t4[v5] = v6

			return v1
		end, false)))
		v7 = v5.x1_123
		v8 = v5.x1_456
		v5.x0_123 = v7
		v5.x0_456 = v8
		v6.cache = v5.source_value

		return function(...) --[[ Line: 204 | Upvalues: push_child_to_scope (ref), v6 (copy), v5 (copy), t (ref), v2 (ref), t4 (ref) ]]
			if select("#", ...) == 0 then
				push_child_to_scope(v6)

				return v6.cache
			end

			local v1 = ...
			local v4, v52 = t[typeof(v1)](v1)

			v5.x0_123 = v4
			v5.x0_456 = v52
			v5.v_123 = v2
			v5.v_456 = v2
			t4[v5] = v6
			v6.cache = v1

			return v1
		end
	end

	throw("spring damping too high, consider reducing damping or increasing period")
	v5 = {
		source_value = false,
		k = v3,
		c = v4,
		x0_123 = v2,
		x1_123 = v2,
		v_123 = v2,
		x0_456 = v2,
		x1_456 = v2,
		v_456 = v2
	}
	v6 = create_source_node(false)
	evaluate_node((create_node(v1, function() --[[ updater_effect | Line: 186 | Upvalues: p1 (copy), v5 (copy), t (ref), t4 (ref), v6 (copy) ]]
		local v1 = p1()
		local v4, v52 = t[typeof(v1)](v1)

		v5.x1_123 = v4
		v5.x1_456 = v52
		v5.source_value = v1
		t4[v5] = v6

		return v1
	end, false)))
	v7 = v5.x1_123
	v8 = v5.x1_456
	v5.x0_123 = v7
	v5.x0_456 = v8
	v6.cache = v5.source_value

	return function(...) --[[ Line: 204 | Upvalues: push_child_to_scope (ref), v6 (copy), v5 (copy), t (ref), v2 (ref), t4 (ref) ]]
		if select("#", ...) == 0 then
			push_child_to_scope(v6)

			return v6.cache
		end

		local v1 = ...
		local v4, v52 = t[typeof(v1)](v1)

		v5.x0_123 = v4
		v5.x0_456 = v52
		v5.v_123 = v2
		v5.v_456 = v2
		t4[v5] = v6
		v6.cache = v1

		return v1
	end
end

local function step_springs(p1) --[[ step_springs | Line: 228 | Upvalues: t4 (copy) ]]
	for v1 in next, t4 do
		local k = v1.k
		local c = v1.c
		local x0_123 = v1.x0_123
		local v_123 = v1.v_123
		local x0_456 = v1.x0_456
		local v_456 = v1.v_456
		local v2 = v_123 + ((x0_123 - v1.x1_123) * -k + v_123 * -c) * p1
		local v3 = v_456 + ((x0_456 - v1.x1_456) * -k + v_456 * -c) * p1

		v1.x0_123 = x0_123 + v2 * p1
		v1.x0_456 = x0_456 + v3 * p1
		v1.v_123 = v2
		v1.v_456 = v3
	end
end

local t5 = {}

local function update_spring_sources() --[[ update_spring_sources | Line: 268 | Upvalues: t4 (copy), t5 (copy), t2 (copy), update_descendants (copy) ]]
	for v1, v2 in next, t4 do
		local x0_123 = v1.x0_123
		local x0_456 = v1.x0_456

		if (v1.v_123 + v1.v_456 + (x0_123 - v1.x1_123) + (x0_456 - v1.x1_456)).Magnitude < 0.0001 then
			table.insert(t5, v1)
			v2.cache = v1.source_value
		else
			v2.cache = t2[typeof(v1.source_value)](x0_123, x0_456)
		end

		update_descendants(v2)
	end

	for v5, v6 in next, t5 do
		t4[v6] = nil
	end

	table.clear(t5)
end

return function() --[[ Line: 298 | Upvalues: spring (copy), step_springs (copy), update_spring_sources (copy) ]]
	local v1 = 0

	return spring, function(p1) --[[ Line: 301 | Upvalues: v1 (ref), step_springs (ref), update_spring_sources (ref) ]]
		v1 = v1 + p1

		while v1 > 0.008333333333333333 do
			v1 = v1 - 0.008333333333333333
			step_springs(0.008333333333333333)
		end

		update_spring_sources()
	end
end