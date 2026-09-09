-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"))
local Number = v1.Number
local Error = v1.Error
local console = require(script.Parent.Parent:WaitForChild("shared")).console

require(script.Parent.Parent:WaitForChild("shared"))
require(script.Parent:WaitForChild("ReactInternalTypes"))

local v2 = require(script.Parent:WaitForChild("ReactFiberStack.new"))
local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"))
local v3 = require(script.Parent:WaitForChild("ReactUpdateQueue.new"))
local isPrimaryRenderer = require(script.Parent:WaitForChild("ReactFiberHostConfig")).isPrimaryRenderer
local push = v2.push
local pop = v2.pop
local MAX_SIGNED_31_BIT_INT = require(script.Parent:WaitForChild("MaxInts")).MAX_SIGNED_31_BIT_INT
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"))
local ContextProvider = ReactWorkTags.ContextProvider
local ClassComponent = ReactWorkTags.ClassComponent
local NoLanes = ReactFiberLane.NoLanes
local NoTimestamp = ReactFiberLane.NoTimestamp
local isSubsetOfLanes = ReactFiberLane.isSubsetOfLanes
local includesSomeLane = ReactFiberLane.includesSomeLane
local mergeLanes = ReactFiberLane.mergeLanes
local pickArbitraryLane = ReactFiberLane.pickArbitraryLane
local objectIs = require(script.Parent.Parent:WaitForChild("shared")).objectIs
local createUpdate = v3.createUpdate
local ForceUpdate = v3.ForceUpdate
local t = {}
local v4 = v2.createCursor(nil)
local v5 = if _G.__DEV__ then {} else nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = false

function t.resetContextDependencies() --[[ Line: 72 | Upvalues: v6 (ref), v7 (ref), v8 (ref), v9 (ref) ]]
	v6 = nil
	v7 = nil
	v8 = nil

	if not _G.__DEV__ then
		return
	end

	v9 = false
end
function t.enterDisallowedContextReadInDEV() --[[ Line: 83 | Upvalues: v9 (ref) ]]
	if not _G.__DEV__ then
		return
	end

	v9 = true
end
function t.exitDisallowedContextReadInDEV() --[[ Line: 89 | Upvalues: v9 (ref) ]]
	if not _G.__DEV__ then
		return
	end

	v9 = false
end
function t.pushProvider(p1, p2) --[[ Line: 95 | Upvalues: isPrimaryRenderer (copy), push (copy), v4 (copy), v5 (ref), console (copy) ]]
	local _context = p1.type._context

	if isPrimaryRenderer then
		push(v4, _context._currentValue, p1)
		_context._currentValue = p2

		if not _G.__DEV__ then
			return
		end

		if _context._currentRenderer ~= nil and _context._currentRenderer ~= v5 then
			console.error("Detected multiple renderers concurrently rendering the same context provider. This is currently unsupported.")
		end

		_context._currentRenderer = v5

		return
	end

	push(v4, _context._currentValue2, p1)
	_context._currentValue2 = p2

	if not _G.__DEV__ then
		return
	end

	if _context._currentRenderer2 ~= nil and _context._currentRenderer2 ~= v5 then
		console.error("Detected multiple renderers concurrently rendering the same context provider. This is currently unsupported.")
	end

	_context._currentRenderer2 = v5
end
function t.popProvider(p1) --[[ Line: 133 | Upvalues: v4 (copy), pop (copy), isPrimaryRenderer (copy) ]]
	local current = v4.current

	pop(v4, p1)

	local _context = p1.type._context

	if isPrimaryRenderer then
		_context._currentValue = current
	else
		_context._currentValue2 = current
	end
end
function t.calculateChangedBits(p1, p2, p3) --[[ Line: 147 | Upvalues: objectIs (copy), MAX_SIGNED_31_BIT_INT (copy) ]]
	if objectIs(p3, p2) then
		return 0
	end

	local v1 = MAX_SIGNED_31_BIT_INT

	if typeof(p1._calculateChangedBits) == "function" then
		v1 = p1._calculateChangedBits(p3, p2)
	end

	return math.floor(v1)
end
function t.scheduleWorkOnParentPath(p1, p2) --[[ Line: 174 | Upvalues: isSubsetOfLanes (copy), mergeLanes (copy) ]]
	local v1 = p1

	while v1 ~= nil do
		local alternate = v1.alternate

		if isSubsetOfLanes(v1.childLanes, p2) then
			if alternate == nil or isSubsetOfLanes(alternate.childLanes, p2) then
				break
			end

			alternate.childLanes = mergeLanes(alternate.childLanes, p2)
		else
			v1.childLanes = mergeLanes(v1.childLanes, p2)

			if alternate ~= nil then
				alternate.childLanes = mergeLanes(alternate.childLanes, p2)
			end
		end

		v1 = v1.return_
	end
end
function t.propagateContextChange(p1, p2, p3, p4) --[[ Line: 197 | Upvalues: ClassComponent (copy), createUpdate (copy), NoTimestamp (copy), pickArbitraryLane (copy), ForceUpdate (copy), t (copy), ContextProvider (copy) ]]
	local child = p1.child

	if child ~= nil then
		child.return_ = p1
	end

	while child ~= nil do
		local v1
		local dependencies = child.dependencies

		if dependencies == nil then
			v1 = if child.tag == ContextProvider then if child.type == p1.type then nil else child.child else child.child
		else
			v1 = child.child

			local firstContext = dependencies.firstContext

			while true do
				if firstContext == nil then
					break
				end

				if firstContext.context == p2 and bit32.band(firstContext.observedBits, p3) ~= 0 then
					if child.tag == ClassComponent then
						local v2 = createUpdate(NoTimestamp, pickArbitraryLane(p4))

						v2.tag = ForceUpdate

						local updateQueue = child.updateQueue

						if updateQueue ~= nil then
							local v3 = updateQueue.shared
							local pending = v3.pending

							if pending == nil then
								v2.next = v2
							else
								v2.next = pending.next
								pending.next = v2
							end

							v3.pending = v2
						end
					end

					child.lanes = bit32.bor(child.lanes, p4)

					local alternate = child.alternate

					if alternate ~= nil then
						alternate.lanes = bit32.bor(alternate.lanes, p4)
					end

					t.scheduleWorkOnParentPath(child.return_, p4)
					dependencies.lanes = bit32.bor(dependencies.lanes, p4)

					break
				end

				firstContext = firstContext.next
			end
		end

		if v1 == nil then
			v1 = child

			while v1 ~= nil do
				if v1 == p1 then
					v1 = nil

					break
				end

				local sibling = v1.sibling

				if sibling == nil then
					v1 = v1.return_
				else
					sibling.return_ = v1.return_
					v1 = sibling

					break
				end
			end
		else
			v1.return_ = child
		end

		child = v1
	end
end
function t.prepareToReadContext(p1, p2, p3) --[[ Line: 336 | Upvalues: v6 (ref), v7 (ref), v8 (ref), includesSomeLane (copy) ]]
	v6 = p1
	v7 = nil
	v8 = nil

	local dependencies = p1.dependencies

	if dependencies == nil or dependencies.firstContext == nil then
		return
	end

	if includesSomeLane(dependencies.lanes, p2) then
		p3()
	end

	dependencies.firstContext = nil
end
function t.readContext(p1, p2) --[[ Line: 360 | Upvalues: v9 (ref), console (copy), v8 (ref), Number (copy), v7 (ref), v6 (ref), Error (copy), NoLanes (copy), isPrimaryRenderer (copy) ]]
	if _G.__DEV__ and v9 then
		console.error("Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo().")
	end

	if v8 ~= p1 and (p2 ~= false and p2 ~= 0) then
		local v1

		if typeof(p2) == "number" and p2 ~= Number.MAX_SAFE_INTEGER then
			v1 = p2
		else
			v8 = p1
			v1 = Number.MAX_SAFE_INTEGER
		end

		local t = {
			next = nil,
			context = p1,
			observedBits = v1
		}

		if v7 == nil then
			if v6 == nil then
				error(Error.new("Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo()."))
			end

			v7 = t
			v6.dependencies = {
				responders = nil,
				lanes = NoLanes,
				firstContext = t
			}
		else
			v7.next = t
			v7 = t
		end
	end

	if isPrimaryRenderer then
		return p1._currentValue
	end

	return p1._currentValue2
end

return t