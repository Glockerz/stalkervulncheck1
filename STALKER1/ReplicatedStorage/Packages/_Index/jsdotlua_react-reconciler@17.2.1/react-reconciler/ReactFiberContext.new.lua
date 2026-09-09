-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__
local __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ = _G.__DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__
local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"))
local Object = v1.Object
local Error = v1.Error
local console = require(script.Parent.Parent:WaitForChild("shared")).console

require(script.Parent:WaitForChild("ReactInternalTypes"))

local v2 = require(script.Parent:WaitForChild("ReactFiberStack.new"))
local isFiberMounted = require(script.Parent:WaitForChild("ReactFiberTreeReflection")).isFiberMounted
local disableLegacyContext = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.disableLegacyContext
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"))
local ClassComponent = ReactWorkTags.ClassComponent
local HostRoot = ReactWorkTags.HostRoot
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName
local checkPropTypes = require(script.Parent.Parent:WaitForChild("shared")).checkPropTypes
local createCursor = v2.createCursor
local push = v2.push
local pop = v2.pop
local v3 = if __DEV__ then {} else nil
local t = {}

if __DEV__ then
	Object.freeze(t)
end

local v4 = createCursor(t)
local v5 = createCursor(false)
local v6 = t
local v7 = nil

local function getUnmaskedContext(p1, p2, p3) --[[ getUnmaskedContext | Line: 67 | Upvalues: v7 (ref), v6 (ref), v4 (copy) ]]
	if p3 and v7(p2) then
		return v6
	end

	return v4.current
end

local function cacheContext(p1, p2, p3) --[[ cacheContext | Line: 87 ]]
	local stateNode = p1.stateNode

	stateNode.__reactInternalMemoizedUnmaskedChildContext = p2
	stateNode.__reactInternalMemoizedMaskedChildContext = p3
end

local function getMaskedContext(p1, p2) --[[ getMaskedContext | Line: 102 | Upvalues: t (copy), __DEV__ (copy), __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ (copy), getComponentName (copy), checkPropTypes (copy) ]]
	local v1 = p1.type

	if type(v1) == "function" then
		return p2
	end

	local contextTypes = v1.contextTypes

	if not contextTypes then
		return t
	end

	local stateNode = p1.stateNode

	if stateNode and stateNode.__reactInternalMemoizedUnmaskedChildContext == p2 then
		return stateNode.__reactInternalMemoizedMaskedChildContext
	end

	local t2 = {}

	for v2, v3 in contextTypes do
		t2[v2] = p2[v2]
	end

	if __DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ then
		checkPropTypes(contextTypes, nil, t2, "context", getComponentName(v1) or "Unknown")
	end

	if stateNode then
		local stateNode2 = p1.stateNode

		stateNode2.__reactInternalMemoizedUnmaskedChildContext = p2
		stateNode2.__reactInternalMemoizedMaskedChildContext = t2
	end

	return t2
end

local function hasContextChanged() --[[ hasContextChanged | Line: 151 | Upvalues: disableLegacyContext (copy), v5 (copy) ]]
	if disableLegacyContext then
		return false
	end

	return v5.current
end

v7 = function(p1) --[[ isContextProvider | Line: 160 ]]
	if type(p1) == "function" then
		return false
	end

	return p1.childContextTypes ~= nil
end

local function popContext(p1) --[[ popContext | Line: 175 | Upvalues: pop (copy), v5 (copy), v4 (copy) ]]
	pop(v5, p1)
	pop(v4, p1)
end

local function popTopLevelContextObject(p1) --[[ popTopLevelContextObject | Line: 185 | Upvalues: pop (copy), v5 (copy), v4 (copy) ]]
	pop(v5, p1)
	pop(v4, p1)
end

local function pushTopLevelContextObject(p1, p2, p3) --[[ pushTopLevelContextObject | Line: 195 | Upvalues: v4 (copy), t (copy), Error (copy), push (copy), v5 (copy) ]]
	if v4.current ~= t then
		error(Error.new("Unexpected context found on stack. This error is likely caused by a bug in React. Please file an issue."))
	end

	push(v4, p2, p1)
	push(v5, p3, p1)
end

local function processChildContext(p1, p2, p3) --[[ processChildContext | Line: 218 | Upvalues: __DEV__ (copy), getComponentName (copy), v3 (ref), console (copy), Error (copy), __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ (copy), checkPropTypes (copy), Object (copy) ]]
	local stateNode = p1.stateNode
	local childContextTypes = p2.childContextTypes

	if stateNode.getChildContext ~= nil and type(stateNode.getChildContext) == "function" then
		local v1 = stateNode:getChildContext()

		for v2, v32 in v1 do
			if childContextTypes[v2] == nil then
				error(Error.new(string.format("%s.getChildContext(): key \"%s\" is not defined in childContextTypes.", getComponentName(p2) or "Unknown", v2)))
			end
		end

		if __DEV__ or __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ then
			checkPropTypes(childContextTypes, nil, v1, "child context", getComponentName(p2) or "Unknown")
		end

		return Object.assign({}, p3, v1)
	end

	if not __DEV__ then
		return p3
	end

	local v5 = getComponentName(p2) or "Unknown"

	if v3[v5] then
		return p3
	end

	v3[v5] = true
	console.error("%s.childContextTypes is specified but there is no getChildContext() method on the instance. You can either define getChildContext() on %s or remove childContextTypes from it.", v5, v5)

	return p3
end

return {
	emptyContextObject = t,
	getUnmaskedContext = getUnmaskedContext,
	cacheContext = cacheContext,
	getMaskedContext = getMaskedContext,
	hasContextChanged = hasContextChanged,
	popContext = popContext,
	popTopLevelContextObject = popTopLevelContextObject,
	pushTopLevelContextObject = pushTopLevelContextObject,
	processChildContext = processChildContext,
	isContextProvider = v7,
	pushContextProvider = function(p1) --[[ pushContextProvider | Line: 278 | Upvalues: t (copy), v6 (ref), v4 (copy), push (copy), v5 (copy) ]]
		v6 = v4.current
		push(v4, p1.stateNode and p1.stateNode.__reactInternalMemoizedMergedChildContext or t, p1)
		push(v5, v5.current, p1)

		return true
	end,
	invalidateContextProvider = function(p1, p2, p3) --[[ invalidateContextProvider | Line: 301 | Upvalues: Error (copy), processChildContext (copy), v6 (ref), pop (copy), v5 (copy), v4 (copy), push (copy) ]]
		local stateNode = p1.stateNode

		if not stateNode then
			error(Error.new("Expected to have an instance by this point. This error is likely caused by a bug in React. Please file an issue."))
		end

		if p3 then
			local v1 = processChildContext(p1, p2, v6)

			stateNode.__reactInternalMemoizedMergedChildContext = v1
			pop(v5, p1)
			pop(v4, p1)
			push(v4, v1, p1)
		else
			pop(v5, p1)
		end

		push(v5, p3, p1)
	end,
	findCurrentUnmaskedContext = function(p1) --[[ findCurrentUnmaskedContext | Line: 342 | Upvalues: ClassComponent (copy), isFiberMounted (copy), Error (copy), HostRoot (copy) ]]
		if p1.tag ~= ClassComponent or not isFiberMounted(p1) then
			error(Error.new("Expected subtree parent to be a mounted class component. This error is likely caused by a bug in React. Please file an issue."))
		end

		local v1 = p1

		repeat
			if v1.tag == HostRoot then
				return v1.stateNode.context
			end

			if v1.tag == ClassComponent and v1.type.childContextTypes ~= nil then
				return v1.stateNode.__reactInternalMemoizedMergedChildContext
			end

			v1 = v1.return_
		until v1 == nil

		error(Error.new("Found unexpected detached subtree parent. This error is likely caused by a bug in React. Please file an issue."))
	end
}