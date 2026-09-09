-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
if not game then
	script = require("test/relative-string")
end

local v1 = game and typeof or require("test/mock").typeof
local v2 = game and Vector2 or require("test/mock").Vector2
local v3 = game and UDim2 or require("test/mock").UDim2
local flags = require(script.Parent.flags)
local throw = require(script.Parent.throw)
local bind = require(script.Parent.bind)
local _, v4 = require(script.Parent.action)()

require(script.Parent.graph)

local v5 = nil

local function borrow_caches() --[[ borrow_caches | Line: 43 | Upvalues: v5 (ref) ]]
	if v5 then
		local v1 = v5

		v5 = nil

		return v1
	end

	local t = {
		events = {}
	}

	t.actions = setmetatable({}, {
		__index = function(p1, p2) --[[ __index | Line: 52 ]]
			p1[p2] = {}

			return p1[p2]
		end
	})
	t.nested_debug = setmetatable({}, {
		__index = function(p1, p2) --[[ __index | Line: 55 ]]
			p1[p2] = {}

			return p1[p2]
		end
	})
	t.nested_stack = {}

	return t
end

local function return_caches(p1) --[[ return_caches | Line: 62 | Upvalues: v5 (ref) ]]
	v5 = p1
end

local t = {}

for v6, v7 in {
	CFrame = CFrame,
	Color3 = Color3,
	UDim = UDim,
	UDim2 = v3,
	Vector2 = v2,
	Vector3 = Vector3,
	Rect = Rect
} do
	t[v6] = v7.new
end

return function(p1, p2) --[[ apply | Line: 81 | Upvalues: throw (copy), flags (copy), borrow_caches (copy), t (copy), v1 (copy), bind (copy), v4 (copy), v5 (ref) ]]
	if not p2 then
		throw("attempt to call a constructor returned by create() with no properties")
	end

	local strict = flags.strict
	local v12 = p2.Parent
	local v2 = borrow_caches()
	local events = v2.events
	local actions = v2.actions
	local nested_debug = v2.nested_debug
	local nested_stack = v2.nested_stack
	local v3 = 1

	while true do
		for v42, v52 in p2 do
			if v42 ~= "Parent" then
				if type(v42) == "string" then
					if strict then
						if nested_debug[v3][v42] then
							throw((("duplicate property %* at depth %*"):format(v42, v3)))
						end

						nested_debug[v3][v42] = true
					end

					if type(v52) == "table" then
						local v6 = t[v1(p1[v42])]

						if v6 == nil then
							throw((("cannot aggregate type %* for property %*"):format(v1(v52), v42)))
						end

						p1[v42] = v6(unpack(v52))

						continue
					end

					if type(v52) == "function" then
						if v1(p1[v42]) == "RBXScriptSignal" then
							events[v42] = v52

							continue
						end

						bind.property(p1, v42, v52)

						continue
					end

					p1[v42] = v52

					continue
				end

				if type(v42) == "number" then
					if type(v52) == "function" then
						bind.children(p1, v52)

						continue
					end

					if type(v52) == "table" then
						if v4(v52) then
							table.insert(actions[v52.priority], v52.callback)

							continue
						end

						table.insert(nested_stack, v52)
						table.insert(nested_stack, v3 + 1)

						continue
					end

					v52.Parent = p1
				end
			end
		end

		local v8 = table.remove(nested_stack)
		local v9 = table.remove(nested_stack)

		if v9 then
			p2 = v9
			v3 = v8
		else
			for v10, v11 in next, events do
				p1[v10]:Connect(v11)
			end

			for v122, v13 in next, actions do
				for v14, v15 in next, v13 do
					v15(p1)
				end
			end

			if v12 and type(v12) == "function" then
				bind.parent(p1, v12)
			elseif v12 then
				p1.Parent = v12
			end

			table.clear(events)

			for v16, v17 in next, actions do
				table.clear(v17)
			end

			if not strict then
				table.clear(nested_stack)
				v5 = v2

				return p1
			end

			table.clear(nested_debug)
			table.clear(nested_stack)
			v5 = v2

			return p1
		end
	end
end