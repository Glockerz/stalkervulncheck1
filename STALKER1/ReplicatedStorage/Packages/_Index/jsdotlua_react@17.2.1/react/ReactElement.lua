-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__
local Error = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Error
local console = require(script.Parent.Parent:WaitForChild("shared")).console

require(script.Parent.Parent:WaitForChild("shared"))
require(script.Parent:WaitForChild("ReactLazy"))

local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName
local REACT_ELEMENT_TYPE = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols.REACT_ELEMENT_TYPE
local ReactCurrentOwner = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals.ReactCurrentOwner
local t = {
	key = true,
	ref = true,
	__self = true,
	__source = true
}
local v1 = nil
local v2 = nil
local v3 = if __DEV__ then {} else nil
local t2 = {}

local function hasValidRef(p1) --[[ hasValidRef | Line: 59 | Upvalues: __DEV__ (copy) ]]
	if __DEV__ and p1.ref ~= nil and (type(p1.ref) == "table" and p1.ref.isReactWarning) then
		return false
	end

	return p1.ref ~= nil
end

local function hasValidKey(p1) --[[ hasValidKey | Line: 73 | Upvalues: __DEV__ (copy) ]]
	if __DEV__ and p1.key ~= nil and (type(p1.key) == "table" and p1.key.isReactWarning) then
		return false
	end

	return p1.key ~= nil
end

local t3 = {
	isReactWarning = true
}

local function defineKeyPropWarningGetter(p1, p2) --[[ defineKeyPropWarningGetter | Line: 92 | Upvalues: __DEV__ (copy), v1 (ref), console (copy), t3 (copy) ]]
	p1.key = nil

	local t = {
		__index = function(p1, p22) --[[ __index | Line: 112 | Upvalues: __DEV__ (ref), v1 (ref), console (ref), p2 (copy), t3 (ref) ]]
			if p22 ~= "key" then
				return nil
			end

			if not __DEV__ or v1 then
				return t3
			end

			v1 = true
			console.error("%s: `key` is not a prop. Trying to access it will result in `nil` being returned. If you need to access the same value within the child component, you should pass it as a different prop. (https://reactjs.org/link/special-props)", p2)

			return t3
		end
	}

	setmetatable(p1, t)
end

local function defineRefPropWarningGetter(p1, p2) --[[ defineRefPropWarningGetter | Line: 124 | Upvalues: __DEV__ (copy), v2 (ref), console (copy), t3 (copy) ]]
	p1.ref = nil

	local t = {
		__index = function(p1, p22) --[[ __index | Line: 146 | Upvalues: __DEV__ (ref), v2 (ref), console (ref), p2 (copy), t3 (ref) ]]
			if p22 ~= "ref" then
				return nil
			end

			if not __DEV__ or v2 then
				return t3
			end

			v2 = true
			console.error("%s: `ref` is not a prop. Trying to access it will result in `nil` being returned. If you need to access the same value within the child component, you should pass it as a different prop. (https://reactjs.org/link/special-props)", p2)

			return t3
		end
	}

	setmetatable(p1, t)
end

local function warnIfStringRefCannotBeAutoConverted(p1) --[[ warnIfStringRefCannotBeAutoConverted | Line: 158 | Upvalues: __DEV__ (copy), ReactCurrentOwner (copy), getComponentName (copy), v3 (ref) ]]
	if not __DEV__ then
		return
	end

	if type(p1.ref) ~= "string" or not ReactCurrentOwner.current then
		return
	end

	local v1 = getComponentName(ReactCurrentOwner.current.type)

	if v3[v1] then
		return
	end

	error(string.format("Component \"%s\" contains the string ref \"%s\". Support for string refs has been removed. We recommend using useRef() or createRef() instead. Learn more about using refs safely here: https://reactjs.org/link/strict-mode-string-ref", v1 or "Unknown", p1.ref))
end

local function ReactElement(p1, p2, p3, p4, p5, p6, p7) --[[ ReactElement | Line: 209 | Upvalues: REACT_ELEMENT_TYPE (copy), __DEV__ (copy) ]]
	local t = {
		type = p1,
		key = p2,
		ref = p3,
		props = p7,
		_owner = p6,
		["$$typeof"] = REACT_ELEMENT_TYPE
	}

	if __DEV__ then
		local t2 = {
			validated = false
		}

		t._store = setmetatable({}, {
			__index = t2,
			__newindex = function(p1, p2, p3) --[[ __newindex | Line: 246 | Upvalues: t2 (copy) ]]
				if p2 == "validated" then
					t2.validated = p3
				else
					rawset(p1, p2, p3)
				end
			end
		})
		setmetatable(t, {
			__index = {
				_self = p4,
				_source = p5
			}
		})
	end

	return t
end

function t2.jsx(p1, p2, p3) --[[ Line: 277 ]]
	error("JSX is currently unsupported")
end
function t2.jsxDEV(p1, p2, p3, p4, p5) --[[ Line: 332 ]]
	error("JSX is currently unsupported")
end
function t2.createElement(p1, p2, ...) --[[ createElement | Line: 408 | Upvalues: __DEV__ (copy), warnIfStringRefCannotBeAutoConverted (copy), defineKeyPropWarningGetter (copy), defineRefPropWarningGetter (copy), ReactElement (copy), ReactCurrentOwner (copy) ]]
	local v1 = if p2 == nil then {} else table.clone(p2)
	local v2 = nil
	local v3 = nil
	local v4

	if p2 == nil then
		v4 = nil
	else
		if if __DEV__ and p2.ref ~= nil then if type(p2.ref) == "table" and p2.ref.isReactWarning then false elseif p2.ref == nil then false else true elseif p2.ref == nil then false else true then
			v3 = p2.ref

			if __DEV__ then
				warnIfStringRefCannotBeAutoConverted(p2)
			end
		end

		if if __DEV__ and p2.key ~= nil then if type(p2.key) == "table" and p2.key.isReactWarning then false elseif p2.key == nil then false else true elseif p2.key == nil then false else true then
			local key = p2.key

			v2 = if type(key) == "number" then key else tostring(key)
		end

		v4 = if p2.__source == nil then nil else p2.__source

		if v1.key ~= nil then
			v1.key = nil
		end

		if v1.ref ~= nil then
			v1.ref = nil
		end

		if v1.__self ~= nil then
			v1.__self = nil
		end

		if v1.__source ~= nil then
			v1.__source = nil
		end
	end

	local v8 = select("#", ...)

	if v8 == 1 then
		v1.children = select(1, ...)
	elseif v8 > 1 then
		local v9 = table.create(v8)

		for i = 1, v8 do
			table.insert(v9, (select(i, ...)))
		end

		if __DEV__ then
			table.freeze(v9)
		end

		v1.children = v9
	end

	if type(p1) == "table" and p1.defaultProps then
		local defaultProps = p1.defaultProps

		for v11, v12 in defaultProps do
			if v1[v11] == nil then
				v1[v11] = defaultProps[v11]
			end
		end
	end

	if __DEV__ then
		if v2 or v3 then
			local v13 = if type(p1) == "function" then debug.info(p1, "n") or "<function>" elseif type(p1) == "table" then p1.displayName or (p1.name or "Unknown") else p1

			if v2 then
				defineKeyPropWarningGetter(v1, v13)
			end

			if v3 then
				defineRefPropWarningGetter(v1, v13)
			end
		end

		if v4 == nil then
			v4 = {
				fileName = debug.info(3, "s"),
				lineNumber = debug.info(3, "l")
			}
		end
	end

	return ReactElement(p1, v2, v3, nil, v4, ReactCurrentOwner.current, v1)
end
function t2.cloneAndReplaceKey(p1, p2) --[[ Line: 587 | Upvalues: ReactElement (copy) ]]
	return ReactElement(p1.type, p2, p1.ref, p1._self, p1._source, p1._owner, p1.props)
end
function t2.cloneElement(p1, p2, ...) --[[ Line: 605 | Upvalues: Error (copy), ReactCurrentOwner (copy), __DEV__ (copy), t (copy), ReactElement (copy) ]]
	if p1 == nil then
		error(Error.new("React.cloneElement(...): The argument must be a React element, but you passed " .. tostring(p1)))
	end

	local props = p1.props
	local v1 = if props == nil then {} else table.clone(props)
	local key = p1.key
	local ref = p1.ref
	local _owner = p1._owner

	if p2 ~= nil then
		local ref2 = p2.ref

		if ref2 == nil then
			local isRef2

			if __DEV__ and p2.ref ~= nil then
				if type(p2.ref) ~= "table" or not p2.ref.isReactWarning then
					local isRef2 = p2.ref == nil
				end
			else
				local isRef2 = p2.ref == nil
			end
		else
			_owner = ReactCurrentOwner.current
			ref = ref2
		end

		local key2 = p2.key

		if key2 == nil then
			local isKey2

			if __DEV__ and p2.key ~= nil then
				if type(p2.key) ~= "table" or not p2.key.isReactWarning then
					local isKey2 = p2.key == nil
				end
			else
				local isKey2 = p2.key == nil
			end
		else
			key = if type(key2) == "number" then key2 else key2 or "nil"
		end
	end

	local v2 = p1.type
	local v3 = if type(v2) == "table" then v2.defaultProps else nil

	if p2 ~= nil then
		for v4, v5 in p2 do
			if p2[v4] ~= nil and not t[v4] then
				if p2[v4] == nil and v3 ~= nil then
					v1[v4] = v3[v4]

					continue
				end

				v1[v4] = p2[v4]
			end
		end
	end

	local v6 = select("#", ...)

	if v6 == 1 then
		v1.children = select(1, ...)
	elseif v6 > 1 then
		v1.children = { ... }
	end

	return ReactElement(p1.type, key, ref, nil, p1._source, _owner, v1)
end
function t2.isValidElement(p1) --[[ Line: 721 | Upvalues: REACT_ELEMENT_TYPE (copy) ]]
	return if type(p1) == "table" then p1["$$typeof"] == REACT_ELEMENT_TYPE else false
end

return t2