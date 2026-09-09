-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__
local __COMPAT_WARNINGS__ = _G.__COMPAT_WARNINGS__
local Object = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Object
local console = require(script.Parent.Parent:WaitForChild("shared")).console

require(script.Parent.Parent:WaitForChild("shared"))

local ReactNoopUpdateQueue = require(script.Parent:WaitForChild("ReactNoopUpdateQueue"))
local t = {}

if __DEV__ then
	Object.freeze(t)
end

local UninitializedState = require(script.Parent.Parent:WaitForChild("shared")).UninitializedState

local function trimPath(p1) --[[ trimPath | Line: 48 ]]
	local v1 = string.match(p1, "%.%u[%.%w]-$")

	if v1 then
		return string.gsub(v1, "^%.", "")
	end

	return p1
end

local function warnAboutExistingLifecycle(p1, p2, p3) --[[ warnAboutExistingLifecycle | Line: 62 | Upvalues: console (copy) ]]
	console.warn("%s already defined \'%s\', but it also defining the deprecated Roact method \'%s\'. %s should only implement one of these methods, preferably using the non-deprecated name.", p1, p3, p2, p1)
end

local function warnAboutDeprecatedLifecycleName(p1, p2, p3) --[[ warnAboutDeprecatedLifecycleName | Line: 72 | Upvalues: __DEV__ (copy), __COMPAT_WARNINGS__ (copy), console (copy) ]]
	if not (__DEV__ and __COMPAT_WARNINGS__) then
		return
	end

	local v1, v2 = debug.info(3, "sln")
	local v5 = string.match(v1, "%.%u[%.%w]-$")

	console.warn("%s is using method \'%s\', which is no longer supported and should be updated to \'%s\'\nFile: %s:%s", p1, p2, p3, if v5 then string.gsub(v5, "^%.", "") else v1, (tostring(v2)))
end

local t2 = {
	didMount = "componentDidMount",
	shouldUpdate = "shouldComponentUpdate",
	willUpdate = "UNSAFE_componentWillUpdate",
	didUpdate = "componentDidUpdate",
	willUnmount = "componentWillUnmount"
}

local function handleNewLifecycle(p1, p2, p3) --[[ handleNewLifecycle | Line: 94 | Upvalues: t2 (copy), console (copy), __DEV__ (copy), __COMPAT_WARNINGS__ (copy) ]]
	if t2[p2] ~= nil then
		if p1[t2[p2]] == nil then
			if p2 == "willUpdate" and p1.componentWillUpdate then
				local __componentName = p1.__componentName

				console.warn("%s already defined \'%s\', but it also defining the deprecated Roact method \'%s\'. %s should only implement one of these methods, preferably using the non-deprecated name.", __componentName, "UNSAFE_componentWillUpdate", p2, __componentName)
			else
				local __componentName = p1.__componentName
				local v1 = t2[p2]

				if __DEV__ and __COMPAT_WARNINGS__ then
					local v2, v3 = debug.info(3, "sln")
					local v6 = string.match(v2, "%.%u[%.%w]-$")

					console.warn("%s is using method \'%s\', which is no longer supported and should be updated to \'%s\'\nFile: %s:%s", __componentName, p2, v1, if v6 then string.gsub(v6, "^%.", "") else v2, (tostring(v3)))
				end
			end
		else
			local __componentName = p1.__componentName

			console.warn("%s already defined \'%s\', but it also defining the deprecated Roact method \'%s\'. %s should only implement one of these methods, preferably using the non-deprecated name.", __componentName, t2[p2], p2, __componentName)
		end

		p2 = t2[p2]
	end

	rawset(p1, p2, p3)
end

local v1 = setmetatable({
	__componentName = "Component"
}, {
	__newindex = handleNewLifecycle,
	__index = {
		isReactComponent = true
	},
	__tostring = function(p1) --[[ __tostring | Line: 124 ]]
		return p1.__componentName
	end
})
local v2 = if _G.__TESTEZ_RUNNING_TEST__ then 0 else 900
local v3 = table.create(v2)
local v4 = 1

for i = 1, v2 do
	table.insert(v3, {
		props = nil,
		context = nil,
		state = UninitializedState,
		__refs = t,
		__updater = ReactNoopUpdateQueue
	})
end

local function setStateInInit(p1, p2, p3) --[[ setStateInInit | Line: 160 | Upvalues: __DEV__ (copy), console (copy), Object (copy) ]]
	if __DEV__ and p3 ~= nil then
		console.warn("Received a `callback` argument to `setState` during initialization of \"%s\". The callback behavior is not supported when using `setState` in `init`.\n\nConsider defining similar behavior in a `compontentDidMount` method instead.", p1.__componentName)
	end

	local v1 = if p2 then type(p2) else p2

	if p2 == nil or v1 ~= "table" and v1 ~= "function" then
		error("setState(...): takes an object of state variables to update or a function which returns an object of state variables.")
	end

	local state = p1.state

	p1.state = Object.assign({}, state, if v1 == "function" then p2(state, p1.props) else p2)
end

function v1.extend(p1, p2) --[[ extend | Line: 200 | Upvalues: __COMPAT_WARNINGS__ (copy), console (copy), v4 (ref), v2 (copy), v3 (copy), UninitializedState (copy), t (copy), ReactNoopUpdateQueue (copy), setStateInInit (copy) ]]
	if p2 == nil then
		if __COMPAT_WARNINGS__ then
			console.warn("Component:extend() accepting no arguments is deprecated, and will not be supported in a future version of Roact. Please provide an explicit name.")
		end

		p2 = ""
	elseif type(p2) ~= "string" then
		error("Component class name must be a string")
	end

	local t2 = {
		init = nil,
		__componentName = p2,
		setState = p1.setState,
		forceUpdate = p1.forceUpdate
	}

	t2.__index = t2
	function t2.__ctor(p1, p2, p3) --[[ __ctor | Line: 234 | Upvalues: v4 (ref), v2 (ref), v3 (ref), UninitializedState (ref), t (ref), ReactNoopUpdateQueue (ref), t2 (copy), setStateInInit (ref) ]]
		local v1

		if v4 <= v2 then
			v1 = v3[v4]
			v1.props = p1
			v1.context = p2
			v3[v4] = nil
			v4 = v4 + 1
		else
			local t3 = {
				props = p1,
				context = p2,
				state = UninitializedState,
				__refs = t
			}

			t3.__updater = if p3 then p3 else ReactNoopUpdateQueue
			v1 = t3
		end

		local v42 = setmetatable(v1, t2)

		if t2.init and type(t2.init) == "function" then
			v42.setState = setStateInInit
			t2.init(v42, p1, p2)
			v42.setState = nil
		end

		return v42
	end
	setmetatable(t2, (getmetatable(p1)))

	return t2
end
function v1.setState(p1, p2, p3) --[[ setState | Line: 326 ]]
	if p2 ~= nil and (type(p2) ~= "table" and type(p2) ~= "function") then
		error("setState(...): takes an object of state variables to update or a function which returns an object of state variables.")
	end

	p1.__updater.enqueueSetState(p1, p2, p3, "setState")
end
function v1.forceUpdate(p1, p2) --[[ forceUpdate | Line: 355 ]]
	p1.__updater.enqueueForceUpdate(p1, p2, "forceUpdate")
end

if __DEV__ then
	local t4 = {
		isMounted = { "isMounted", "Instead, make sure to clean up subscriptions and pending requests in componentWillUnmount to prevent memory leaks." },
		replaceState = { "replaceState", "Refactor your code to use setState instead (see https://github.com/facebook/react/issues/3236)." }
	}

	for v5, v6 in t4 do
		if t4[v5] ~= nil then
			local v7 = t4[v5]

			v1[v5] = function() --[[ Line: 380 | Upvalues: console (copy), v7 (copy) ]]
				console.warn("%s(...) is deprecated in plain JavaScript React classes. %s", v7[1], v7[2])

				return nil
			end
		end
	end
end

local v8 = v1:extend("PureComponent")

v8.extend = v1.extend
setmetatable(v8, {
	__newindex = handleNewLifecycle,
	__index = {
		isReactComponent = true,
		isPureReactComponent = true
	},
	__tostring = function(p1) --[[ __tostring | Line: 427 ]]
		return p1.__componentName
	end
})

return {
	Component = v1,
	PureComponent = v8
}