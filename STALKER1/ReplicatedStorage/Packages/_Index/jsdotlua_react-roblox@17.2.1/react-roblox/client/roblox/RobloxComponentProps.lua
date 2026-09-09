-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__
local CollectionService = game:GetService("CollectionService")
local v1 = require(script.Parent.Parent.Parent.Parent:WaitForChild("luau-polyfill"))
local Object = v1.Object
local inspect = v1.util.inspect
local console = require(script.Parent.Parent.Parent.Parent:WaitForChild("shared")).console
local react = require(script.Parent.Parent.Parent.Parent:WaitForChild("react"))
local ReactSymbols = require(script.Parent.Parent.Parent.Parent:WaitForChild("shared")).ReactSymbols
local SingleEventManager = require(script.Parent:WaitForChild("SingleEventManager"))
local Type = require(script.Parent.Parent.Parent.Parent:WaitForChild("shared")).Type
local getDefaultInstanceProperty = require(script.Parent:WaitForChild("getDefaultInstanceProperty"))

require(script.Parent.Parent:WaitForChild("ReactRobloxHostTypes.roblox"))

local Tag = require(script.Parent.Parent.Parent.Parent:WaitForChild("react")).Tag
local t = {}
local t2 = {}

local function identity(...) --[[ identity | Line: 69 ]]
	return ...
end

local function setRobloxInstanceProperty(p1, p2, p3) --[[ setRobloxInstanceProperty | Line: 73 | Upvalues: getDefaultInstanceProperty (copy) ]]
	if p3 == nil then
		local ok, _ = pcall(p1.ResetPropertyToDefault, p1, p2)

		if ok then
			return
		end

		local _2, v1 = getDefaultInstanceProperty(p1.ClassName, p2)

		p3 = v1
	end

	p1[p2] = p3
end

local function removeBinding(p1, p2) --[[ removeBinding | Line: 89 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	if v1 == nil then
		return
	end

	v1[p2]()
	v1[p2] = nil
end

local function attachBinding(p1, p2, p3) --[[ attachBinding | Line: 98 | Upvalues: setRobloxInstanceProperty (copy), identity (copy), console (copy), t2 (copy), react (copy) ]]
	local function updateBoundProperty(p12) --[[ updateBoundProperty | Line: 99 | Upvalues: setRobloxInstanceProperty (ref), identity (ref), p1 (copy), p2 (copy), p3 (copy), console (ref) ]]
		local ok, result = xpcall(setRobloxInstanceProperty, identity, p1, p2, p12)

		if ok then
			return
		end

		local v2 = string.format("Error updating binding or ref assigned to key %s of \'%s\' (%s).\n\nUpdated value:\n  %s\n\nError:\n  %s\n\n%s\n", p2, p1.Name, p1.ClassName, tostring(p12), result, p3._source or "<enable DEV mode for stack>")

		console.error(v2)
		error(v2, 0)
	end

	if t2[p1] == nil then
		t2[p1] = {}
	end

	t2[p1][p2] = react.__subscribeToBinding(p3, updateBoundProperty)
	updateBoundProperty(p3:getValue())
end

local function applyTags(p1, p2, p3) --[[ applyTags | Line: 131 | Upvalues: __DEV__ (copy), console (copy), inspect (copy), CollectionService (copy) ]]
	if __DEV__ and (p3 ~= nil and typeof(p3) ~= "string") then
		console.error("Type provided for ReactRoblox.Tag is invalid - tags should be specified as a single string, with individual tags delimited by spaces. Instead received:\n%s", inspect(p3))

		return
	end

	local t = {}

	for v1 in string.gmatch(p2 or "", "%S+") do
		t[v1] = true
	end

	local t2 = {}

	for v2 in string.gmatch(p3 or "", "%S+") do
		t2[v2] = true
	end

	for v3, v4 in t do
		if not t2[v3] then
			CollectionService:RemoveTag(p1, v3)
		end
	end

	for v5, v6 in t2 do
		if not t[v5] then
			CollectionService:AddTag(p1, v5)
		end
	end
end

local function removeAllTags(p1) --[[ removeAllTags | Line: 165 | Upvalues: CollectionService (copy) ]]
	for v1, v2 in CollectionService:GetTags(p1) do
		CollectionService:RemoveTag(p1, v2)
	end
end

local function applyProp(p1, p2, p3, p4) --[[ applyProp | Line: 171 | Upvalues: Type (copy), t (copy), SingleEventManager (copy), ReactSymbols (copy), t2 (copy), attachBinding (copy), Tag (copy), applyTags (copy), getDefaultInstanceProperty (copy) ]]
	local v1 = Type.of(p2)

	if v1 == Type.HostEvent or v1 == Type.HostChangeEvent then
		local v2 = t[p1]

		if v2 == nil then
			local v3 = SingleEventManager.new(p1)

			t[p1] = v3
			v2 = v3
		end

		local name = p2.name

		if v1 == Type.HostChangeEvent then
			v2:connectPropertyChange(name, p3)
		else
			v2:connectEvent(name, p3)
		end
	else
		local v4 = if typeof(p3) == "table" then if p3["$$typeof"] == ReactSymbols.REACT_BINDING_TYPE then true else false else false

		if if p4 == nil or typeof(p4) ~= "table" then false elseif p4["$$typeof"] == ReactSymbols.REACT_BINDING_TYPE then true else false then
			local v6 = t2[p1]

			if v6 ~= nil then
				v6[p2]()
				v6[p2] = nil
			end
		end

		if v4 then
			attachBinding(p1, p2, p3)

			return
		end

		if p2 == Tag then
			applyTags(p1, p4, p3)

			return
		end

		local v7

		if p3 == nil then
			local ok, _ = pcall(p1.ResetPropertyToDefault, p1, p2)

			if ok then
				return
			end

			local _2, v8 = getDefaultInstanceProperty(p1.ClassName, p2)

			v7 = v8
		else
			v7 = p3
		end

		p1[p2] = v7
	end
end

local function applyProps(p1, p2) --[[ applyProps | Line: 216 | Upvalues: applyProp (copy) ]]
	for v1, v2 in p2 do
		if v1 ~= "ref" and v1 ~= "children" then
			applyProp(p1, v1, v2)
		end
	end
end

local function setInitialProperties(p1, p2, p3, p4) --[[ setInitialProperties | Line: 227 | Upvalues: applyProps (copy), identity (copy), console (copy), t (copy) ]]
	local ok, result = xpcall(applyProps, identity, p1, p3)

	if not ok then
		local v1 = string.format("Error applying initial props to Roblox Instance \'%s\' (%s):\n  %s\n", p1.Name, p1.ClassName, result)

		console.error(v1)
		error(v1, 0)
	end

	if t[p1] == nil then
		return
	end

	t[p1]:resume()
end

local function safelyApplyProperties(p1, p2, p3) --[[ safelyApplyProperties | Line: 256 | Upvalues: Object (copy), applyProp (copy) ]]
	for i = 1, #p2, 2 do
		local v1 = p2[i]
		local v2 = p2[i + 1]

		if v2 == Object.None then
			v2 = nil
		end

		if v1 ~= "ref" and v1 ~= "children" then
			applyProp(p1, v1, v2, p3[v1])
		end
	end
end

local function updateProperties(p1, p2, p3) --[[ updateProperties | Line: 275 | Upvalues: t (copy), safelyApplyProperties (copy), identity (copy), console (copy) ]]
	if t[p1] ~= nil then
		t[p1]:suspend()
	end

	local ok, result = xpcall(safelyApplyProperties, identity, p1, p2, p3)

	if not ok then
		local v1 = string.format("Error updating props on Roblox Instance \'%s\' (%s):\n  %s\n", p1.Name, p1.ClassName, result)

		console.error(v1)
		error(v1, 0)
	end

	if t[p1] == nil then
		return
	end

	t[p1]:resume()
end

local function cleanupBindings(p1) --[[ cleanupBindings | Line: 309 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	if v1 == nil then
		return
	end

	for v2, v3 in v1 do
		v3()
	end

	t2[p1] = nil
end

return {
	setInitialProperties = setInitialProperties,
	updateProperties = updateProperties,
	cleanupHostComponent = function(p1) --[[ cleanupHostComponent | Line: 321 | Upvalues: t (copy), t2 (copy), CollectionService (copy) ]]
		if t[p1] ~= nil then
			t[p1] = nil
		end

		local v1 = t2[p1]

		if v1 ~= nil then
			for v2, v3 in v1 do
				v3()
			end

			t2[p1] = nil
		end

		if typeof(p1) ~= "Instance" then
			return
		end

		for v4, v5 in CollectionService:GetTags(p1) do
			CollectionService:RemoveTag(p1, v5)
		end

		for v6, v7 in p1:GetDescendants() do
			if t[v7] ~= nil then
				t[v7] = nil
			end

			local v8 = t2[v7]

			if v8 ~= nil then
				for v9, v10 in v8 do
					v10()
				end

				t2[v7] = nil
			end

			for v11, v12 in CollectionService:GetTags(p1) do
				CollectionService:RemoveTag(p1, v12)
			end
		end
	end,
	_instanceToEventManager = t,
	_instanceToBindings = t2
}