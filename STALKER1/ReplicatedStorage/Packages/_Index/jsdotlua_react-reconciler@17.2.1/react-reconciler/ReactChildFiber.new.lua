-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__
local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"))
local Error = v1.Error
local console = require(script.Parent.Parent:WaitForChild("shared")).console
local describeError = require(script.Parent.Parent:WaitForChild("shared")).describeError

require(script.Parent.Parent:WaitForChild("shared"))
require(script.Parent.Parent:WaitForChild("react"))
require(script.Parent:WaitForChild("ReactInternalTypes"))
require(script.Parent:WaitForChild("ReactFiberLane"))

local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"))
local Placement = ReactFiberFlags.Placement
local Deletion = ReactFiberFlags.Deletion
local ReactSymbols = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols
local getIteratorFn = ReactSymbols.getIteratorFn
local REACT_ELEMENT_TYPE = ReactSymbols.REACT_ELEMENT_TYPE
local REACT_FRAGMENT_TYPE = ReactSymbols.REACT_FRAGMENT_TYPE
local REACT_PORTAL_TYPE = ReactSymbols.REACT_PORTAL_TYPE
local REACT_LAZY_TYPE = ReactSymbols.REACT_LAZY_TYPE
local REACT_BLOCK_TYPE = ReactSymbols.REACT_BLOCK_TYPE
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"))
local FunctionComponent = ReactWorkTags.FunctionComponent
local ClassComponent = ReactWorkTags.ClassComponent
local HostText = ReactWorkTags.HostText
local HostPortal = ReactWorkTags.HostPortal
local ForwardRef = ReactWorkTags.ForwardRef
local Fragment = ReactWorkTags.Fragment
local SimpleMemoComponent = ReactWorkTags.SimpleMemoComponent
local Block = ReactWorkTags.Block
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags
local enableLazyElements = ReactFeatureFlags.enableLazyElements
local enableBlocksAPI = ReactFeatureFlags.enableBlocksAPI
local v2 = require(script.Parent:WaitForChild("ReactFiber.new"))
local createWorkInProgress = v2.createWorkInProgress
local resetWorkInProgress = v2.resetWorkInProgress
local createFiberFromElement = v2.createFiberFromElement
local createFiberFromFragment = v2.createFiberFromFragment
local createFiberFromText = v2.createFiberFromText
local createFiberFromPortal = v2.createFiberFromPortal
local t = {}
local v3, v4, v5

if __DEV__ then
	v3 = false

	local t2 = {}

	v4 = function(p1, p2) --[[ Line: 112 | Upvalues: invariant (copy), getComponentName (copy), t2 (ref), console (copy) ]]
		if p1 == nil or type(p1) ~= "table" then
			return
		end

		if not p1._store or (p1._store.validated or p1.key ~= nil) then
			return
		end

		invariant(if p1._store == nil then false elseif type(p1._store) == "table" then true else false, "React Component in warnForMissingKey should have a _store. This error is likely caused by a bug in React. Please file an issue.")
		p1._store.validated = true

		local v3 = getComponentName(p2.type) or "Component"

		if not t2[v3] then
			t2[v3] = true
			console.error("Each child in a list should have a unique \"key\" prop. See https://reactjs.org/link/warning-keys for more information.")
		end
	end
	v5 = {}
else
	v4 = function(p1, p2) --[[ Line: 90 ]] end
	v3 = nil
	v5 = nil
end

local isArray = v1.Array.isArray

function coerceRef(p1, p2, p3) --[[ coerceRef | Line: 143 | Upvalues: __DEV__ (copy), getComponentName (copy), Error (copy) ]]
	local ref = p3.ref

	if ref ~= nil and type(ref) == "string" then
		if not p3._owner or (not p3._self or p3._owner.stateNode == p3._self) then
			error(Error.new(string.format("Component \"%s\" contains the string ref \"%s\". Support for string refs has been removed. We recommend using useRef() or createRef() instead. Learn more about using refs safely here: https://reactjs.org/link/strict-mode-string-ref", if __DEV__ then getComponentName(p1.type) or "Component" else "<enable __DEV__ mode for component names>", (tostring(ref)))))
		end

		if not p3._owner then
			error("Expected ref to be a function or an object returned by React.createRef(), or nil.")
		end
	end

	return ref
end

local function warnOnFunctionType(p1) --[[ warnOnFunctionType | Line: 316 | Upvalues: __DEV__ (copy), getComponentName (copy), v5 (ref), console (copy) ]]
	if not __DEV__ then
		return
	end

	local v1 = getComponentName(p1.type) or "Component"

	if v5[v1] then
		return
	end

	v5[v1] = true
	console.error("Functions are not valid as a React child. This may happen if you return a Component instead of <Component /> from render. Or maybe you meant to call this function rather than return it.")
end

function resolveLazyType(p1) --[[ resolveLazyType | Line: 335 | Upvalues: describeError (copy) ]]
	local ok, result = xpcall(p1._init, describeError, p1._payload)

	if ok then
		return result
	end

	return p1
end

local function ChildReconciler(p1) --[[ ChildReconciler | Line: 353 | Upvalues: Deletion (copy), createWorkInProgress (copy), Placement (copy), HostText (copy), createFiberFromText (copy), __DEV__ (copy), enableBlocksAPI (copy), Block (copy), REACT_LAZY_TYPE (copy), REACT_BLOCK_TYPE (copy), createFiberFromElement (copy), HostPortal (copy), createFiberFromPortal (copy), Fragment (copy), createFiberFromFragment (copy), REACT_ELEMENT_TYPE (copy), REACT_PORTAL_TYPE (copy), enableLazyElements (copy), getComponentName (copy), v5 (ref), console (copy), REACT_FRAGMENT_TYPE (copy), v4 (ref), v3 (ref), isArray (copy), getIteratorFn (copy) ]]
	local function deleteChild(p12, p2) --[[ deleteChild | Line: 354 | Upvalues: p1 (copy), Deletion (ref) ]]
		if not p1 then
			return
		end

		local deletions = p12.deletions

		if deletions == nil then
			p12.deletions = { p2 }
			p12.flags = bit32.bor(p12.flags, Deletion)
		else
			table.insert(deletions, p2)
		end
	end

	local function deleteRemainingChildren(p12, p2) --[[ deleteRemainingChildren | Line: 368 | Upvalues: p1 (copy), Deletion (ref) ]]
		if not p1 then
			return nil
		end

		local v1 = p2

		while v1 ~= nil do
			if p1 then
				local deletions = p12.deletions

				if deletions == nil then
					p12.deletions = { v1 }
					p12.flags = bit32.bor(p12.flags, Deletion)
				else
					table.insert(deletions, v1)
				end
			end

			v1 = v1.sibling
		end

		return nil
	end

	local function mapRemainingChildren(p1, p2) --[[ mapRemainingChildren | Line: 387 ]]
		local v1, v2 = p2, {}

		while v1 ~= nil do
			if v1.key == nil then
				v2[v1.index] = v1
			else
				v2[v1.key] = v1
			end

			v1 = v1.sibling
		end

		return v2
	end

	local function useFiber(p1, p2) --[[ useFiber | Line: 409 | Upvalues: createWorkInProgress (ref) ]]
		local v1 = createWorkInProgress(p1, p2)

		v1.index = 1
		v1.sibling = nil

		return v1
	end

	local function placeChild(p12, p2, p3) --[[ placeChild | Line: 419 | Upvalues: p1 (copy), Placement (ref) ]]
		p12.index = p3

		if not p1 then
			return p2
		end

		local alternate = p12.alternate

		if alternate == nil then
			p12.flags = bit32.bor(p12.flags, Placement)

			return p2
		end

		local index = alternate.index

		if index < p2 then
			p12.flags = bit32.bor(p12.flags, Placement)

			return p2
		end

		return index
	end

	local function placeSingleChild(p12) --[[ placeSingleChild | Line: 447 | Upvalues: p1 (copy), Placement (ref) ]]
		if p1 and p12.alternate == nil then
			p12.flags = bit32.bor(p12.flags, Placement)
		end

		return p12
	end

	local function updateTextNode(p1, p2, p3, p4) --[[ updateTextNode | Line: 456 | Upvalues: HostText (ref), createFiberFromText (ref), createWorkInProgress (ref) ]]
		if p2 == nil or p2.tag ~= HostText then
			local v1 = createFiberFromText(p3, p1.mode, p4)

			v1.return_ = p1

			return v1
		end

		local v2 = createWorkInProgress(p2, p3)

		v2.index = 1
		v2.sibling = nil
		v2.return_ = p1

		return v2
	end

	local function updateElement(p1, p2, p3, p4) --[[ updateElement | Line: 476 | Upvalues: createWorkInProgress (ref), __DEV__ (ref), enableBlocksAPI (ref), Block (ref), REACT_LAZY_TYPE (ref), REACT_BLOCK_TYPE (ref), createFiberFromElement (ref) ]]
		if p2 ~= nil and p2.elementType == p3.type then
			local v1 = createWorkInProgress(p2, p3.props)

			v1.index = 1
			v1.sibling = nil
			v1.ref = coerceRef(p1, p2, p3)
			v1.return_ = p1

			if __DEV__ then
				v1._debugSource = p3._source
				v1._debugOwner = p3._owner
			end

			return v1
		elseif p2 ~= nil and (enableBlocksAPI and p2.tag == Block) then
			local v3 = p3.type

			if type(v3) == "table" and v3["$$typeof"] == REACT_LAZY_TYPE then
				v3 = resolveLazyType(v3)
			end

			if v3["$$typeof"] == REACT_BLOCK_TYPE and v3._render == p2.type._render then
				local v5 = createWorkInProgress(p2, p3.props)

				v5.index = 1
				v5.sibling = nil
				v5.return_ = p1
				v5.type = v3

				if __DEV__ then
					v5._debugSource = p3._source
					v5._debugOwner = p3._owner
				end

				return v5
			end
		end

		local v7 = createFiberFromElement(p3, p1.mode, p4)

		v7.ref = coerceRef(p1, p2, p3)
		v7.return_ = p1

		return v7
	end

	local function updatePortal(p1, p2, p3, p4) --[[ updatePortal | Line: 529 | Upvalues: HostPortal (ref), createFiberFromPortal (ref), createWorkInProgress (ref) ]]
		if p2 == nil or (p2.tag ~= HostPortal or (p2.stateNode.containerInfo ~= p3.containerInfo or p2.stateNode.implementation ~= p3.implementation)) then
			local v1 = createFiberFromPortal(p3, p1.mode, p4)

			v1.return_ = p1

			return v1
		end

		local v3 = createWorkInProgress(p2, p3.children or {})

		v3.index = 1
		v3.sibling = nil
		v3.return_ = p1

		return v3
	end

	local function updateFragment(p1, p2, p3, p4, p5) --[[ updateFragment | Line: 554 | Upvalues: Fragment (ref), createFiberFromFragment (ref), createWorkInProgress (ref) ]]
		if p2 == nil or p2.tag ~= Fragment then
			local v1 = createFiberFromFragment(p3, p1.mode, p4, p5)

			v1.return_ = p1

			return v1
		end

		local v2 = createWorkInProgress(p2, p3)

		v2.index = 1
		v2.sibling = nil
		v2.return_ = p1

		return v2
	end

	local function assignStableKey(p1, p2) --[[ assignStableKey | Line: 581 ]]
		if p2.key ~= nil then
			return
		end

		local v1 = type(p1)

		if v1 == "string" or v1 == "number" then
			p2.key = p1

			return
		end

		if v1 ~= "table" then
			return
		end

		p2.key = tostring(p1)
	end

	local function v1(p1, p2, p3, p4) --[[ createChild | Line: 600 | Upvalues: REACT_ELEMENT_TYPE (ref), createFiberFromElement (ref), REACT_PORTAL_TYPE (ref), createFiberFromPortal (ref), REACT_LAZY_TYPE (ref), enableLazyElements (ref), v1 (copy), createFiberFromFragment (ref), createFiberFromText (ref), __DEV__ (ref), getComponentName (ref), v5 (ref), console (ref) ]]
		if p2 == nil then
			return nil
		end

		local v12 = type(p2)

		if v12 == "table" then
			if p2.key == nil then
				local v2 = type(p4)

				if v2 == "string" or v2 == "number" then
					p2.key = p4
				elseif v2 == "table" then
					p2.key = tostring(p4)
				end
			end

			local v3 = p2["$$typeof"]

			if v3 == REACT_ELEMENT_TYPE then
				local v4 = createFiberFromElement(p2, p1.mode, p3)

				v4.ref = coerceRef(p1, nil, p2)
				v4.return_ = p1

				return v4
			end

			if v3 == REACT_PORTAL_TYPE then
				local v52 = createFiberFromPortal(p2, p1.mode, p3)

				v52.return_ = p1

				return v52
			end

			if v3 == REACT_LAZY_TYPE and enableLazyElements then
				return v1(p1, p2._init(p2._payload), p3)
			end

			local v6 = createFiberFromFragment(p2, p1.mode, p3, nil)

			v6.return_ = p1

			return v6
		end

		if v12 == "string" or v12 == "number" then
			local v7 = createFiberFromText(tostring(p2), p1.mode, p3)

			v7.return_ = p1

			return v7
		end

		if not __DEV__ or (v12 ~= "function" or not __DEV__) then
			return nil
		end

		local v8 = getComponentName(p1.type) or "Component"

		if v5[v8] then
			return nil
		end

		v5[v8] = true
		console.error("Functions are not valid as a React child. This may happen if you return a Component instead of <Component /> from render. Or maybe you meant to call this function rather than return it.")

		return nil
	end

	local function v2(p1, p2, p3, p4, p5) --[[ updateSlot | Line: 671 | Upvalues: REACT_ELEMENT_TYPE (ref), REACT_FRAGMENT_TYPE (ref), Fragment (ref), createFiberFromFragment (ref), createWorkInProgress (ref), updateElement (copy), REACT_PORTAL_TYPE (ref), updatePortal (copy), REACT_LAZY_TYPE (ref), enableLazyElements (ref), v2 (copy), HostText (ref), createFiberFromText (ref), __DEV__ (ref), getComponentName (ref), v5 (ref), console (ref) ]]
		if p3 == nil then
			return nil
		end

		local v1 = if p2 == nil then nil else p2.key
		local v22 = type(p3)

		if v22 == "table" then
			if p3.key == nil then
				local v3 = type(p5)

				if v3 == "string" or v3 == "number" then
					p3.key = p5
				elseif v3 == "table" then
					p3.key = tostring(p5)
				end
			end

			local v4 = p3["$$typeof"]

			if v4 == REACT_ELEMENT_TYPE then
				if p3.key ~= v1 then
					return nil
				end

				if p3.type ~= REACT_FRAGMENT_TYPE then
					return updateElement(p1, p2, p3, p4)
				end

				local children = p3.props.children

				if p2 == nil or p2.tag ~= Fragment then
					local v52 = createFiberFromFragment(children, p1.mode, p4, v1)

					v52.return_ = p1

					return v52
				end

				local v6 = createWorkInProgress(p2, children)

				v6.index = 1
				v6.sibling = nil
				v6.return_ = p1

				return v6
			end

			if v4 == REACT_PORTAL_TYPE then
				if p3.key == v1 then
					return updatePortal(p1, p2, p3, p4)
				end

				return nil
			end

			if v4 == REACT_LAZY_TYPE and enableLazyElements then
				return v2(p1, p2, p3._init(p3._payload), p4)
			end

			if v1 ~= nil then
				return nil
			end

			if p2 == nil or p2.tag ~= Fragment then
				local v7 = createFiberFromFragment(p3, p1.mode, p4, nil)

				v7.return_ = p1

				return v7
			end

			local v8 = createWorkInProgress(p2, p3)

			v8.index = 1
			v8.sibling = nil
			v8.return_ = p1

			return v8
		end

		if v22 == "string" or v22 == "number" then
			if v1 ~= nil then
				return nil
			end

			local v9 = tostring(p3)

			if p2 == nil or p2.tag ~= HostText then
				local v10 = createFiberFromText(v9, p1.mode, p4)

				v10.return_ = p1

				return v10
			end

			local v11 = createWorkInProgress(p2, v9)

			v11.index = 1
			v11.sibling = nil
			v11.return_ = p1

			return v11
		end

		if not __DEV__ or (v22 ~= "function" or not __DEV__) then
			return nil
		end

		local v12 = getComponentName(p1.type) or "Component"

		if v5[v12] then
			return nil
		end

		v5[v12] = true
		console.error("Functions are not valid as a React child. This may happen if you return a Component instead of <Component /> from render. Or maybe you meant to call this function rather than return it.")

		return nil
	end

	local function v32(p1, p2, p3, p4, p5, p6) --[[ updateFromMap | Line: 759 | Upvalues: REACT_ELEMENT_TYPE (ref), REACT_FRAGMENT_TYPE (ref), Fragment (ref), createFiberFromFragment (ref), createWorkInProgress (ref), updateElement (copy), REACT_PORTAL_TYPE (ref), updatePortal (copy), REACT_LAZY_TYPE (ref), enableLazyElements (ref), v32 (copy), HostText (ref), createFiberFromText (ref), __DEV__ (ref), getComponentName (ref), v5 (ref), console (ref) ]]
		if p4 == nil then
			return nil
		end

		local v1 = type(p4)

		if v1 == "table" then
			if p4.key == nil then
				local v2 = type(p6)

				if v2 == "string" or v2 == "number" then
					p4.key = p6
				elseif v2 == "table" then
					p4.key = tostring(p6)
				end
			end

			local v3 = p4["$$typeof"]

			if v3 == REACT_ELEMENT_TYPE then
				local v52 = p1[if p4.key == nil then p3 else p4.key]

				if p4.type ~= REACT_FRAGMENT_TYPE then
					return updateElement(p2, v52, p4, p5)
				end

				local children = p4.props.children
				local key = p4.key

				if v52 == nil or v52.tag ~= Fragment then
					local v6 = createFiberFromFragment(children, p2.mode, p5, key)

					v6.return_ = p2

					return v6
				end

				local v7 = createWorkInProgress(v52, children)

				v7.index = 1
				v7.sibling = nil
				v7.return_ = p2

				return v7
			end

			if v3 == REACT_PORTAL_TYPE then
				return updatePortal(p2, p1[if p4.key == nil then p3 else p4.key], p4, p5)
			end

			if v3 == REACT_LAZY_TYPE and enableLazyElements then
				return v32(p1, p2, p3, p4._init(p4._payload), p5)
			end

			local v9 = p1[p3]

			if v9 == nil or v9.tag ~= Fragment then
				local v10 = createFiberFromFragment(p4, p2.mode, p5, nil)

				v10.return_ = p2

				return v10
			end

			local v11 = createWorkInProgress(v9, p4)

			v11.index = 1
			v11.sibling = nil
			v11.return_ = p2

			return v11
		end

		if v1 == "string" or v1 == "number" then
			local v12 = p1[p3] or nil
			local v13 = tostring(p4)

			if v12 == nil or v12.tag ~= HostText then
				local v14 = createFiberFromText(v13, p2.mode, p5)

				v14.return_ = p2

				return v14
			end

			local v15 = createWorkInProgress(v12, v13)

			v15.index = 1
			v15.sibling = nil
			v15.return_ = p2

			return v15
		end

		if not __DEV__ or (v1 ~= "function" or not __DEV__) then
			return nil
		end

		local v16 = getComponentName(p2.type) or "Component"

		if v5[v16] then
			return nil
		end

		v5[v16] = true
		console.error("Functions are not valid as a React child. This may happen if you return a Component instead of <Component /> from render. Or maybe you meant to call this function rather than return it.")

		return nil
	end

	local function v42(p1, p2, p3) --[[ warnOnInvalidKey | Line: 853 | Upvalues: __DEV__ (ref), REACT_ELEMENT_TYPE (ref), REACT_PORTAL_TYPE (ref), v4 (ref), console (ref), REACT_LAZY_TYPE (ref), enableLazyElements (ref), v42 (copy) ]]
		if __DEV__ then
			if p1 == nil or type(p1) ~= "table" then
				return p2
			end

			local v1 = p1["$$typeof"]

			if v1 == REACT_ELEMENT_TYPE or v1 == REACT_PORTAL_TYPE then
				v4(p1, p3)

				local key = p1.key

				if type(key) ~= "string" then
					return p2
				end

				if p2 == nil then
					return {
						[key] = true
					}
				end

				if p2[key] then
					console.error("Encountered two children with the same key, `%s`. Keys should be unique so that components maintain their identity across updates. Non-unique keys may cause children to be duplicated and/or omitted \226\128\148 the behavior is unsupported and could change in a future version.", key)
				else
					p2[key] = true
				end

				return p2
			elseif v1 == REACT_LAZY_TYPE and enableLazyElements then
				v42(p1._init(p1._payload), p2, p3)
			end
		end

		return p2
	end

	local function reconcileChildrenArray(p12, p2, p3, p4) --[[ reconcileChildrenArray | Line: 895 | Upvalues: __DEV__ (ref), v42 (copy), v2 (copy), p1 (copy), Deletion (ref), Placement (ref), v1 (copy), mapRemainingChildren (copy), v32 (copy) ]]
		if __DEV__ then
			local v12 = nil

			for v22, v3 in p3 do
				v12 = v42(v3, v12, p12)
			end
		end

		local v5, count, v6, v7, v8, v9 = p2, 1, #p3, nil, nil, 1

		while v5 ~= nil and count <= v6 do
			local v10, v11

			if count < v5.index then
				v10, v5 = v5, nil
			else
				v10 = v5.sibling
			end

			local v12 = p3[count]

			v11 = if v12 == nil or (type(v12) ~= "table" or v12["$$typeof"] == nil) then v2(p12, v5, v12, p4) else v2(p12, v5, v12, p4, count)

			if v11 == nil then
				if v5 == nil then
					v5 = v10
				end

				break
			end

			if p1 and (v5 and (v11.alternate == nil and p1)) then
				local deletions = p12.deletions

				if deletions == nil then
					p12.deletions = { v5 }
					p12.flags = bit32.bor(p12.flags, Deletion)
				else
					table.insert(deletions, v5)
				end
			end

			v11.index = count

			if p1 then
				local alternate = v11.alternate

				if alternate == nil then
					v11.flags = bit32.bor(v11.flags, Placement)
				else
					local index = alternate.index

					if index < v9 then
						v11.flags = bit32.bor(v11.flags, Placement)
					else
						v9 = index
					end
				end
			end

			if v7 == nil then
				v8 = v11
			else
				v7.sibling = v11
			end

			v5, count, v7 = v10, count + 1, v11
		end

		if v6 < count then
			if not p1 then
				return v8
			end

			local v18 = v5

			while v18 ~= nil do
				if p1 then
					local deletions = p12.deletions

					if deletions == nil then
						p12.deletions = { v18 }
						p12.flags = bit32.bor(p12.flags, Deletion)
					else
						table.insert(deletions, v18)
					end
				end

				v18 = v18.sibling
			end
		elseif v5 == nil then
			while count <= v6 do
				local v20
				local v21 = p3[count]

				v20 = if v21 == nil or (type(v21) ~= "table" or v21["$$typeof"] == nil) then v1(p12, v21, p4) else v1(p12, v21, p4, count)

				if v20 == nil then
					count = count + 1
				else
					v20.index = count

					if p1 then
						local alternate = v20.alternate

						if alternate == nil then
							v20.flags = bit32.bor(v20.flags, Placement)
						else
							local index = alternate.index

							if index < v9 then
								v20.flags = bit32.bor(v20.flags, Placement)
							else
								v9 = index
							end
						end
					end

					if v7 == nil then
						v8 = v20
					else
						v7.sibling = v20
					end

					count, v7 = count + 1, v20
				end
			end
		else
			local v26 = mapRemainingChildren(p12, v5)

			while count <= v6 do
				local v27 = v32(v26, p12, count, p3[count], p4, count)

				if v27 ~= nil then
					if p1 and v27.alternate ~= nil then
						v26[if v27.key == nil then count else v27.key] = nil
					end

					v27.index = count

					if p1 then
						local alternate = v27.alternate

						if alternate == nil then
							v27.flags = bit32.bor(v27.flags, Placement)
						else
							local index = alternate.index

							if index < v9 then
								v27.flags = bit32.bor(v27.flags, Placement)
							else
								v9 = index
							end
						end
					end

					if v7 == nil then
						v8 = v27
					else
						v7.sibling = v27
					end

					v7 = v27
				end

				count = count + 1
			end

			if p1 then
				for v31, v322 in v26 do
					if p1 then
						local deletions = p12.deletions

						if deletions == nil then
							p12.deletions = { v322 }
							p12.flags = bit32.bor(p12.flags, Deletion)

							continue
						end

						table.insert(deletions, v322)
					end
				end
			end
		end

		return v8
	end

	local function reconcileChildrenIterator(p12, p2, p3, p4, p5) --[[ reconcileChildrenIterator | Line: 1102 | Upvalues: __DEV__ (ref), v3 (ref), console (ref), v42 (copy), v2 (copy), p1 (copy), Deletion (ref), Placement (ref), v1 (copy), mapRemainingChildren (copy), v32 (copy) ]]
		if __DEV__ then
			if p3.entries == p5 then
				if not v3 then
					console.error("Using Maps as children is not supported. Use an array of keyed ReactElements instead.")
				end

				v3 = true
			end

			local v12 = p5(p3)

			if v12 then
				local v22 = v12.next()
				local v33 = nil

				while not v22.done do
					local v4 = v12.next()

					v22, v33 = v4, v42(v4.value, v33, p12)
				end
			end
		end

		local v6 = p5(p3)
		local v7 = v6.next()
		local v8, v9, v10, v11, v12 = p2, 1, nil, 1, nil

		while v8 ~= nil and not v7.done do
			local v13

			if v9 < v8.index then
				v13, v8 = v8, nil
			else
				v13 = v8.sibling
			end

			local v14 = v2(p12, v8, v7.value, p4, v7.key)

			if v14 == nil then
				if v8 == nil then
					v8 = v13
				end

				break
			end

			if p1 and (v8 and (v14.alternate == nil and p1)) then
				local deletions = p12.deletions

				if deletions == nil then
					p12.deletions = { v8 }
					p12.flags = bit32.bor(p12.flags, Deletion)
				else
					table.insert(deletions, v8)
				end
			end

			v14.index = v9

			if p1 then
				local alternate = v14.alternate

				if alternate == nil then
					v14.flags = bit32.bor(v14.flags, Placement)
				else
					local index = alternate.index

					if index < v11 then
						v14.flags = bit32.bor(v14.flags, Placement)
					else
						v11 = index
					end
				end
			end

			if v12 == nil then
				v10 = v14
			else
				v12.sibling = v14
			end

			v8, v7, v9, v12 = v13, v6.next(), v9 + 1, v14
		end

		if v7.done then
			if not p1 then
				return v10
			end

			local v19 = v8

			while v19 ~= nil do
				if p1 then
					local deletions = p12.deletions

					if deletions == nil then
						p12.deletions = { v19 }
						p12.flags = bit32.bor(p12.flags, Deletion)
					else
						table.insert(deletions, v19)
					end
				end

				v19 = v19.sibling
			end
		elseif v8 == nil then
			while not v7.done do
				local v21 = v1(p12, v7.value, p4, v7.key)

				if v21 == nil then
					v7, v9 = v6.next(), v9 + 1
				else
					v21.index = v9

					if p1 then
						local alternate = v21.alternate

						if alternate == nil then
							v21.flags = bit32.bor(v21.flags, Placement)
						else
							local index = alternate.index

							if index < v11 then
								v21.flags = bit32.bor(v21.flags, Placement)
							else
								v11 = index
							end
						end
					end

					if v12 == nil then
						v10 = v21
					else
						v12.sibling = v21
					end

					v7, v9, v12 = v6.next(), v9 + 1, v21
				end
			end
		else
			local v26 = nil

			while not v7.done do
				if not v26 then
					v26 = mapRemainingChildren(p12, v8)
				end

				local v28 = v32(v26, p12, v9, v7.value, p4, v7.key)

				if v28 ~= nil then
					if p1 and v28.alternate ~= nil then
						if v28.key == nil then
							v26[v9] = nil
						else
							v26[v28.key] = nil
						end
					end

					v28.index = v9

					if p1 then
						local alternate = v28.alternate

						if alternate == nil then
							v28.flags = bit32.bor(v28.flags, Placement)
						else
							local index = alternate.index

							if index < v11 then
								v28.flags = bit32.bor(v28.flags, Placement)
							else
								v11 = index
							end
						end
					end

					if v12 == nil then
						v10 = v28
					else
						v12.sibling = v28
					end

					v12 = v28
				end

				v7, v9 = v6.next(), v9 + 1
			end

			if p1 then
				for v322, v33 in v26 do
					if p1 then
						local deletions = p12.deletions

						if deletions == nil then
							p12.deletions = { v33 }
							p12.flags = bit32.bor(p12.flags, Deletion)

							continue
						end

						table.insert(deletions, v33)
					end
				end
			end
		end

		return v10
	end

	local function reconcileSingleTextNode(p12, p2, p3, p4) --[[ reconcileSingleTextNode | Line: 1315 | Upvalues: HostText (ref), p1 (copy), Deletion (ref), createWorkInProgress (ref), createFiberFromText (ref) ]]
		if p2 == nil or p2.tag ~= HostText then
			if p1 then
				local v1 = p2

				while v1 ~= nil do
					if p1 then
						local deletions = p12.deletions

						if deletions == nil then
							p12.deletions = { v1 }
							p12.flags = bit32.bor(p12.flags, Deletion)
						else
							table.insert(deletions, v1)
						end
					end

					v1 = v1.sibling
				end
			end

			local v3 = createFiberFromText(p3, p12.mode, p4)

			v3.return_ = p12

			return v3
		end

		local sibling = p2.sibling

		if p1 then
			local v4 = sibling

			while v4 ~= nil do
				if p1 then
					local deletions = p12.deletions

					if deletions == nil then
						p12.deletions = { v4 }
						p12.flags = bit32.bor(p12.flags, Deletion)
					else
						table.insert(deletions, v4)
					end
				end

				v4 = v4.sibling
			end
		end

		local v6 = createWorkInProgress(p2, p3)

		v6.index = 1
		v6.sibling = nil
		v6.return_ = p12

		return v6
	end

	local function reconcileSingleElement(p12, p2, p3, p4) --[[ reconcileSingleElement | Line: 1340 | Upvalues: Fragment (ref), REACT_FRAGMENT_TYPE (ref), p1 (copy), Deletion (ref), createWorkInProgress (ref), __DEV__ (ref), createFiberFromFragment (ref), createFiberFromElement (ref) ]]
		local key = p3.key
		local v1 = p2

		while v1 ~= nil do
			if v1.key == key then
				if v1.tag == Fragment then
					if p3.type == REACT_FRAGMENT_TYPE then
						local sibling = v1.sibling

						if p1 then
							local v2 = sibling

							while v2 ~= nil do
								if p1 then
									local deletions = p12.deletions

									if deletions == nil then
										p12.deletions = { v2 }
										p12.flags = bit32.bor(p12.flags, Deletion)
									else
										table.insert(deletions, v2)
									end
								end

								v2 = v2.sibling
							end
						end

						local v4 = createWorkInProgress(v1, p3.props.children)

						v4.index = 1
						v4.sibling = nil
						v4.return_ = p12

						if __DEV__ then
							v4._debugSource = p3._source
							v4._debugOwner = p3._owner
						end

						return v4
					end
				elseif v1.elementType == p3.type then
					local sibling = v1.sibling

					if p1 then
						local v6 = sibling

						while v6 ~= nil do
							if p1 then
								local deletions = p12.deletions

								if deletions == nil then
									p12.deletions = { v6 }
									p12.flags = bit32.bor(p12.flags, Deletion)
								else
									table.insert(deletions, v6)
								end
							end

							v6 = v6.sibling
						end
					end

					local v8 = createWorkInProgress(v1, p3.props)

					v8.index = 1
					v8.sibling = nil
					v8.ref = coerceRef(p12, v1, p3)
					v8.return_ = p12

					if __DEV__ then
						v8._debugSource = p3._source
						v8._debugOwner = p3._owner
					end

					return v8
				end

				if p1 then
					local v10 = v1

					while v10 ~= nil do
						if p1 then
							local deletions = p12.deletions

							if deletions == nil then
								p12.deletions = { v10 }
								p12.flags = bit32.bor(p12.flags, Deletion)
							else
								table.insert(deletions, v10)
							end
						end

						v10 = v10.sibling
					end
				end

				break
			end

			if p1 then
				local deletions = p12.deletions

				if deletions == nil then
					p12.deletions = { v1 }
					p12.flags = bit32.bor(p12.flags, Deletion)
				else
					table.insert(deletions, v1)
				end
			end

			v1 = v1.sibling
		end

		if p3.type == REACT_FRAGMENT_TYPE then
			local v13 = createFiberFromFragment(p3.props.children, p12.mode, p4, p3.key)

			v13.return_ = p12

			return v13
		end

		local v14 = createFiberFromElement(p3, p12.mode, p4)

		v14.ref = coerceRef(p12, p2, p3)
		v14.return_ = p12

		return v14
	end

	local function reconcileSinglePortal(p12, p2, p3, p4) --[[ reconcileSinglePortal | Line: 1440 | Upvalues: HostPortal (ref), p1 (copy), Deletion (ref), createWorkInProgress (ref), createFiberFromPortal (ref) ]]
		local key = p3.key
		local v1 = p2

		while v1 ~= nil do
			if v1.key == key then
				if v1.tag == HostPortal and (v1.stateNode.containerInfo == p3.containerInfo and v1.stateNode.implementation == p3.implementation) then
					local sibling = v1.sibling

					if p1 then
						local v2 = sibling

						while v2 ~= nil do
							if p1 then
								local deletions = p12.deletions

								if deletions == nil then
									p12.deletions = { v2 }
									p12.flags = bit32.bor(p12.flags, Deletion)
								else
									table.insert(deletions, v2)
								end
							end

							v2 = v2.sibling
						end
					end

					local v5 = createWorkInProgress(v1, p3.children or {})

					v5.index = 1
					v5.sibling = nil
					v5.return_ = p12

					return v5
				end

				if p1 then
					local v6 = v1

					while v6 ~= nil do
						if p1 then
							local deletions = p12.deletions

							if deletions == nil then
								p12.deletions = { v6 }
								p12.flags = bit32.bor(p12.flags, Deletion)
							else
								table.insert(deletions, v6)
							end
						end

						v6 = v6.sibling
					end
				end

				break
			end

			if p1 then
				local deletions = p12.deletions

				if deletions == nil then
					p12.deletions = { v1 }
					p12.flags = bit32.bor(p12.flags, Deletion)
				else
					table.insert(deletions, v1)
				end
			end

			v1 = v1.sibling
		end

		local v9 = createFiberFromPortal(p3, p12.mode, p4)

		v9.return_ = p12

		return v9
	end

	local function v52(p12, p2, p3, p4) --[[ reconcileChildFibers | Line: 1479 | Upvalues: REACT_FRAGMENT_TYPE (ref), isArray (ref), REACT_ELEMENT_TYPE (ref), reconcileSingleElement (copy), p1 (copy), Placement (ref), REACT_PORTAL_TYPE (ref), reconcileSinglePortal (copy), REACT_LAZY_TYPE (ref), enableLazyElements (ref), v52 (copy), reconcileChildrenArray (copy), reconcileSingleTextNode (copy), getIteratorFn (ref), reconcileChildrenIterator (copy), __DEV__ (ref), getComponentName (ref), v5 (ref), console (ref), Deletion (ref) ]]
		local v1 = type(p3)

		if if p3 == nil or (v1 ~= "table" or p3.type ~= REACT_FRAGMENT_TYPE) then false elseif p3.key == nil then true else false then
			p3 = p3.props.children
			v1 = type(p3)
		end

		local v4 = isArray(p3)

		if if p3 == nil or v1 ~= "table" then false else not v4 then
			local v6 = p3["$$typeof"]

			if v6 == REACT_ELEMENT_TYPE then
				local v7 = reconcileSingleElement(p12, p2, p3, p4)

				if p1 and v7.alternate == nil then
					v7.flags = bit32.bor(v7.flags, Placement)
				end

				return v7
			elseif v6 == REACT_PORTAL_TYPE then
				local v9 = reconcileSinglePortal(p12, p2, p3, p4)

				if p1 and v9.alternate == nil then
					v9.flags = bit32.bor(v9.flags, Placement)
				end

				return v9
			elseif v6 == REACT_LAZY_TYPE and enableLazyElements then
				return v52(p12, p2, p3._init(p3._payload), p4)
			end
		else
			if v4 then
				return reconcileChildrenArray(p12, p2, p3, p4)
			end

			if v1 == "string" or v1 == "number" then
				local v11 = reconcileSingleTextNode(p12, p2, tostring(p3), p4)

				if p1 and v11.alternate == nil then
					v11.flags = bit32.bor(v11.flags, Placement)
				end

				return v11
			end
		end

		local v13 = getIteratorFn(p3)

		if v13 then
			return reconcileChildrenIterator(p12, p2, p3, p4, v13)
		end

		if __DEV__ and (v1 == "function" and __DEV__) then
			local v14 = getComponentName(p12.type) or "Component"

			if not v5[v14] then
				v5[v14] = true
				console.error("Functions are not valid as a React child. This may happen if you return a Component instead of <Component /> from render. Or maybe you meant to call this function rather than return it.")
			end
		end

		if not p1 then
			return nil
		end

		local v15 = p2

		while v15 ~= nil do
			if p1 then
				local deletions = p12.deletions

				if deletions == nil then
					p12.deletions = { v15 }
					p12.flags = bit32.bor(p12.flags, Deletion)
				else
					table.insert(deletions, v15)
				end
			end

			v15 = v15.sibling
		end

		return nil
	end

	return v52
end

t.reconcileChildFibers = ChildReconciler(true)
t.mountChildFibers = ChildReconciler(false)
function t.cloneChildFibers(p1, p2) --[[ Line: 1627 | Upvalues: createWorkInProgress (copy) ]]
	if p2.child == nil then
		return
	end

	local child = p2.child
	local v1 = createWorkInProgress(child, child.pendingProps)

	p2.child = v1
	v1.return_ = p2

	while child.sibling ~= nil do
		child = child.sibling
		v1.sibling = createWorkInProgress(child, child.pendingProps)
		v1 = v1.sibling
		v1.return_ = p2
	end

	v1.sibling = nil
end
function t.resetChildFibers(p1, p2) --[[ Line: 1654 | Upvalues: resetWorkInProgress (copy) ]]
	local child = p1.child

	while child ~= nil do
		resetWorkInProgress(child, p2)
		child = child.sibling
	end
end

return t