-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"))
local ReactSymbols = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols

require(script.Parent.Parent:WaitForChild("shared"))

local v2 = require(script.Parent:WaitForChild("createSignal.roblox"))
local v3 = v1.Symbol("BindingImpl")
local t = {}
local t2 = {
	__index = {
		getValue = function(p1) --[[ getValue | Line: 45 | Upvalues: t (copy) ]]
			return t.getValue(p1)
		end,
		map = function(p1, p2) --[[ map | Line: 49 | Upvalues: t (copy) ]]
			return t.map(p1, p2)
		end
	},
	__tostring = function(p1) --[[ __tostring | Line: 58 ]]
		return string.format("RoactBinding(%s)", (tostring(p1:getValue())))
	end
}

function t.update(p1, p2) --[[ update | Line: 63 | Upvalues: v3 (copy) ]]
	return p1[v3].update(p2)
end
function t.subscribe(p1, p2) --[[ subscribe | Line: 67 | Upvalues: v3 (copy) ]]
	return p1[v3].subscribe(p2)
end
function t.getValue(p1) --[[ getValue | Line: 71 | Upvalues: v3 (copy) ]]
	return p1[v3]:getValue()
end
function t.create(p1) --[[ create | Line: 75 | Upvalues: v2 (copy), ReactSymbols (copy), v3 (copy), t2 (copy) ]]
	local v1, v22 = v2()
	local t = {
		value = p1,
		subscribe = v1
	}

	function t.update(p1) --[[ update | Line: 82 | Upvalues: t (copy), v22 (copy) ]]
		t.value = p1
		v22(p1)
	end
	function t.getValue() --[[ getValue | Line: 87 | Upvalues: t (copy) ]]
		return t.value
	end

	return setmetatable({
		["$$typeof"] = ReactSymbols.REACT_BINDING_TYPE,
		[v3] = t,
		_source = if _G.__DEV__ then debug.traceback("Binding created at:", 3) else nil
	}, t2), t.update
end
function t.map(p1, p2) --[[ map | Line: 105 | Upvalues: ReactSymbols (copy), t (copy), v3 (copy), t2 (copy) ]]
	if _G.__DEV__ then
		assert(if typeof(p1) == "table" then if p1["$$typeof"] == ReactSymbols.REACT_BINDING_TYPE then true else false else false, "Expected `self` to be a binding")
		assert(if typeof(p2) == "function" then true else false, "Expected arg #1 to be a function")
	end

	local t3 = {
		subscribe = function(p12) --[[ subscribe | Line: 121 | Upvalues: t (ref), p1 (copy), p2 (copy) ]]
			return t.subscribe(p1, function(p1) --[[ Line: 122 | Upvalues: p12 (copy), p2 (ref) ]]
				p12(p2(p1))
			end)
		end,
		update = function(p1) --[[ update | Line: 127 ]]
			error("Bindings created by Binding:map(fn) cannot be updated directly", 2)
		end,
		getValue = function() --[[ getValue | Line: 131 | Upvalues: p2 (copy), p1 (copy) ]]
			return p2(p1:getValue())
		end
	}

	return setmetatable({
		["$$typeof"] = ReactSymbols.REACT_BINDING_TYPE,
		[v3] = t3,
		_source = if _G.__DEV__ then debug.traceback("Mapped binding created at:", 3) else nil
	}, t2)
end
function t.join(p1) --[[ join | Line: 152 | Upvalues: ReactSymbols (copy), t (copy), v3 (copy), t2 (copy) ]]
	if _G.__DEV__ then
		assert(typeof(p1) == "table", "Expected arg #1 to be of type table")

		for v2, v32 in p1 do
			if typeof(v32) ~= "table" or v32["$$typeof"] ~= ReactSymbols.REACT_BINDING_TYPE then
				error(("Expected arg #1 to contain only bindings, but key %q had a non-binding value"):format((tostring(v2))), 2)
			end
		end
	end

	local t3 = {}

	local function getValue() --[[ getValue | Line: 173 | Upvalues: p1 (copy) ]]
		local t = {}

		for k, v in pairs(p1) do
			t[k] = v:getValue()
		end

		return t
	end

	function t3.subscribe(p12) --[[ subscribe | Line: 184 | Upvalues: p1 (copy), t (ref), getValue (copy) ]]
		local t2 = {}

		for v1, v2 in p1 do
			t2[v1] = t.subscribe(v2, function(p1) --[[ Line: 189 | Upvalues: p12 (copy), getValue (ref) ]]
				p12((getValue()))
			end)
		end

		return function() --[[ Line: 194 | Upvalues: t2 (ref) ]]
			if t2 == nil then
				return
			end

			for v1, v2 in t2 do
				v2()
			end

			t2 = nil
		end
	end
	function t3.update(p1) --[[ update | Line: 207 ]]
		error("Bindings created by joinBindings(...) cannot be updated directly", 2)
	end
	function t3.getValue() --[[ getValue | Line: 211 | Upvalues: getValue (copy) ]]
		return getValue()
	end

	return setmetatable({
		["$$typeof"] = ReactSymbols.REACT_BINDING_TYPE,
		[v3] = t3,
		_source = if _G.__DEV__ then debug.traceback("Joined binding created at:", 2) else nil
	}, t2)
end

return t