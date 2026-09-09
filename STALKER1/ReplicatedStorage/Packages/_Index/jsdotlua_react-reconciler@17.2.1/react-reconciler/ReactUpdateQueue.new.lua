-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__
local __YOLO__ = _G.__YOLO__
local Object = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Object
local console = require(script.Parent.Parent:WaitForChild("shared")).console

require(script.Parent:WaitForChild("ReactInternalTypes"))

local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"))
local NoLane = ReactFiberLane.NoLane
local NoLanes = ReactFiberLane.NoLanes
local isSubsetOfLanes = ReactFiberLane.isSubsetOfLanes
local mergeLanes = ReactFiberLane.mergeLanes
local v1 = nil

local function enterDisallowedContextReadInDEV() --[[ enterDisallowedContextReadInDEV | Line: 113 | Upvalues: v1 (ref) ]]
	if not v1 then
		v1 = require(script.Parent:WaitForChild("ReactFiberNewContext.new"))
	end

	v1.enterDisallowedContextReadInDEV()
end

local function exitDisallowedContextReadInDEV() --[[ exitDisallowedContextReadInDEV | Line: 119 | Upvalues: v1 (ref) ]]
	if v1 then
		v1.exitDisallowedContextReadInDEV()

		return
	end

	v1 = require(script.Parent:WaitForChild("ReactFiberNewContext.new"))
	v1.exitDisallowedContextReadInDEV()
end

local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"))
local Callback = ReactFiberFlags.Callback
local ShouldCapture = ReactFiberFlags.ShouldCapture
local DidCapture = ReactFiberFlags.DidCapture
local debugRenderPhaseSideEffectsForStrictMode = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.debugRenderPhaseSideEffectsForStrictMode
local StrictMode = require(script.Parent:WaitForChild("ReactTypeOfMode")).StrictMode
local markSkippedUpdateLanes = require(script.Parent:WaitForChild("ReactFiberWorkInProgress")).markSkippedUpdateLanes
local describeError = require(script.Parent.Parent:WaitForChild("shared")).describeError
local ConsolePatchingDev = require(script.Parent.Parent:WaitForChild("shared")).ConsolePatchingDev
local disableLogs = ConsolePatchingDev.disableLogs
local reenableLogs = ConsolePatchingDev.reenableLogs
local t = {
	UpdateState = 0,
	ReplaceState = 1,
	ForceUpdate = 2,
	CaptureUpdate = 3
}
local v2 = false
local v3, v4

v4 = nil

if __DEV__ then
	v3 = false
	function t.resetCurrentlyProcessingQueue() --[[ Line: 179 | Upvalues: v4 (ref) ]]
		v4 = nil
	end
else
	v3 = nil
end

local v5 = table.create(210)
local v6 = 210

for i = 1, 210 do
	v5[i] = {
		eventTime = -1,
		lane = -1,
		tag = -1,
		payload = nil,
		callback = nil,
		next = nil
	}
end

function t.initializeUpdateQueue(p1) --[[ initializeUpdateQueue | Line: 200 ]]
	p1.updateQueue = {
		firstBaseUpdate = nil,
		lastBaseUpdate = nil,
		effects = nil,
		baseState = p1.memoizedState,
		shared = {
			pending = nil
		}
	}
end
function t.cloneUpdateQueue(p1, p2) --[[ cloneUpdateQueue | Line: 214 ]]
	local updateQueue2 = p1.updateQueue

	if p2.updateQueue ~= updateQueue2 then
		return
	end

	p2.updateQueue = table.clone(updateQueue2)
end
function t.createUpdate(p1, p2, p3, p4) --[[ createUpdate | Line: 228 | Upvalues: v6 (ref), v5 (copy) ]]
	if v6 > 0 then
		local v1 = v5[v6]

		v5[v6] = nil
		v6 = v6 - 1
		v1.eventTime = p1
		v1.lane = p2
		v1.tag = 0
		v1.payload = p3
		v1.callback = p4

		return v1
	end

	return {
		tag = 0,
		next = nil,
		eventTime = p1,
		lane = p2,
		payload = p3,
		callback = p4
	}
end
function t.enqueueUpdate(p1, p2) --[[ enqueueUpdate | Line: 278 | Upvalues: __DEV__ (copy), v4 (ref), v3 (ref), console (copy) ]]
	local updateQueue = p1.updateQueue

	if updateQueue == nil then
		return
	end

	local v1 = updateQueue.shared
	local pending = v1.pending

	if pending == nil then
		p2.next = p2
	else
		p2.next = pending.next
		pending.next = p2
	end

	v1.pending = p2

	if not __DEV__ or (v4 ~= v1 or v3) then
		return
	end

	console.error("An update (setState, replaceState, or forceUpdate) was scheduled from inside an update function. Update functions should be pure, with zero side-effects. Consider using componentDidUpdate or a callback.")
	v3 = true
end
function t.enqueueCapturedUpdate(p1, p2) --[[ enqueueCapturedUpdate | Line: 310 ]]
	local updateQueue = p1.updateQueue
	local alternate = p1.alternate

	if alternate ~= nil then
		local updateQueue2 = alternate.updateQueue

		if updateQueue == updateQueue2 then
			local firstBaseUpdate = updateQueue.firstBaseUpdate
			local v1, v2

			if firstBaseUpdate == nil then
				v1 = p2
				v2 = p2
			else
				local v3, v4

				v3 = firstBaseUpdate
				v4 = nil
				v1 = nil

				repeat
					local t = {
						next = nil,
						eventTime = v3.eventTime,
						lane = v3.lane,
						tag = v3.tag,
						payload = v3.payload,
						callback = v3.callback
					}

					if v4 == nil then
						v4 = t
						v1 = t
					else
						v4.next = t
						v4 = t
					end

					v3 = v3.next
				until v3 == nil

				if v4 == nil then
					v1 = p2
					v2 = p2
				else
					v4.next = p2
					v2 = p2
				end
			end

			p1.updateQueue = {
				baseState = updateQueue2.baseState,
				firstBaseUpdate = v1,
				lastBaseUpdate = v2,
				shared = updateQueue2.shared,
				effects = updateQueue2.effects
			}

			return
		end
	end

	local lastBaseUpdate = updateQueue.lastBaseUpdate

	if lastBaseUpdate == nil then
		updateQueue.firstBaseUpdate = p2
	else
		lastBaseUpdate.next = p2
	end

	updateQueue.lastBaseUpdate = p2
end

local function getStateFromUpdate(p1, p2, p3, p4, p5, p6) --[[ getStateFromUpdate | Line: 391 | Upvalues: __DEV__ (copy), v1 (ref), debugRenderPhaseSideEffectsForStrictMode (copy), StrictMode (copy), disableLogs (copy), __YOLO__ (copy), describeError (copy), reenableLogs (copy), ShouldCapture (copy), DidCapture (copy), Object (copy), v2 (ref) ]]
	local tag = p3.tag

	if tag == 1 then
		local payload = p3.payload

		if type(payload) ~= "function" then
			return payload
		end

		if __DEV__ then
			if not v1 then
				v1 = require(script.Parent:WaitForChild("ReactFiberNewContext.new"))
			end

			v1.enterDisallowedContextReadInDEV()
		end

		local v12 = payload(p4, p5)

		if __DEV__ then
			if debugRenderPhaseSideEffectsForStrictMode and bit32.band(p1.mode, StrictMode) ~= 0 then
				disableLogs()

				local v3 = nil
				local v4

				if __YOLO__ then
					payload(p4, p5)
					v4 = true
				else
					local ok, result = xpcall(payload, describeError, p4, p5)

					v4 = ok
					v3 = result
				end

				reenableLogs()

				if not v4 then
					error(v3)
				end
			end

			if not v1 then
				v1 = require(script.Parent:WaitForChild("ReactFiberNewContext.new"))
			end

			v1.exitDisallowedContextReadInDEV()
		end

		return v12
	end

	if tag == 3 or tag == 0 then
		if tag == 3 then
			p1.flags = bit32.bor(bit32.band(p1.flags, (bit32.bnot(ShouldCapture))), DidCapture)
		end

		local payload = p3.payload
		local v9

		if type(payload) == "function" then
			if __DEV__ then
				if not v1 then
					v1 = require(script.Parent:WaitForChild("ReactFiberNewContext.new"))
				end

				v1.enterDisallowedContextReadInDEV()
			end

			v9 = payload(p4, p5)

			if __DEV__ then
				if debugRenderPhaseSideEffectsForStrictMode and bit32.band(p1.mode, StrictMode) ~= 0 then
					disableLogs()

					local v12 = nil
					local v13

					if __YOLO__ then
						payload(p4, p5)
						v13 = true
					else
						local ok, result = xpcall(payload, describeError, p4, p5)

						v13 = ok
						v12 = result
					end

					reenableLogs()

					if not v13 then
						error(v12)
					end
				end

				if not v1 then
					v1 = require(script.Parent:WaitForChild("ReactFiberNewContext.new"))
				end

				v1.exitDisallowedContextReadInDEV()
			end
		else
			v9 = payload
		end

		if v9 == nil then
			return p4
		end

		return Object.assign({}, p4, v9)
	end

	if tag == 2 then
		v2 = true
	end

	return p4
end

t.getStateFromUpdate = getStateFromUpdate
function t.processUpdateQueue(p1, p2, p3, p4) --[[ processUpdateQueue | Line: 500 | Upvalues: v2 (ref), __DEV__ (copy), v4 (ref), NoLanes (copy), isSubsetOfLanes (copy), mergeLanes (copy), NoLane (copy), getStateFromUpdate (copy), Callback (copy), markSkippedUpdateLanes (copy) ]]
	local updateQueue = p1.updateQueue

	v2 = false

	if __DEV__ then
		v4 = updateQueue.shared
	end

	local firstBaseUpdate = updateQueue.firstBaseUpdate
	local lastBaseUpdate = updateQueue.lastBaseUpdate
	local pending = updateQueue.shared.pending

	if pending ~= nil then
		updateQueue.shared.pending = nil

		local v1 = pending.next

		pending.next = nil

		if lastBaseUpdate == nil then
			firstBaseUpdate = v1
		else
			lastBaseUpdate.next = v1
		end

		local alternate = p1.alternate

		if alternate ~= nil then
			local updateQueue2 = alternate.updateQueue
			local lastBaseUpdate2 = updateQueue2.lastBaseUpdate

			if lastBaseUpdate2 ~= pending then
				if lastBaseUpdate2 == nil then
					updateQueue2.firstBaseUpdate = v1
				else
					lastBaseUpdate2.next = v1
				end

				updateQueue2.lastBaseUpdate = pending
			end
		end
	end

	if firstBaseUpdate ~= nil then
		local baseState = updateQueue.baseState
		local v22 = NoLanes

		v3 = firstBaseUpdate
		v42 = nil
		v5 = nil
		v6 = nil

		while true do
			v3 = v3.next

			if v3 == nil then
				local pending2 = updateQueue.shared.pending

				if pending2 == nil then
					break
				end

				local v7 = pending2.next

				pending2.next = nil
				updateQueue.lastBaseUpdate = pending2
				updateQueue.shared.pending = nil
				v3 = v7

				break
			end

			local lane = v3.lane
			local eventTime = v3.eventTime

			if isSubsetOfLanes(p4, lane) then
				if v42 ~= nil then
					local t = {
						next = nil,
						eventTime = eventTime,
						lane = NoLane,
						tag = v3.tag,
						payload = v3.payload,
						callback = v3.callback
					}

					v42.next = t
					v42 = t
				end

				local v8 = getStateFromUpdate(p1, updateQueue, v3, baseState, p2, p3)

				if v3.callback ~= nil and v3.lane ~= NoLane then
					p1.flags = bit32.bor(p1.flags, Callback)

					local effects = updateQueue.effects

					if effects == nil then
						updateQueue.effects = { v3 }
					else
						table.insert(effects, v3)
					end
				end

				baseState = v8
			else
				local t = {
					next = nil,
					eventTime = eventTime,
					lane = lane,
					tag = v3.tag,
					payload = v3.payload,
					callback = v3.callback
				}

				if v42 == nil then
					v42 = t
					v5 = baseState
					v6 = t
				else
					v42.next = t
					v42 = t
				end

				v22 = mergeLanes(v22, lane)
			end
		end

		if v42 == nil then
			v5 = baseState
		end

		updateQueue.baseState = v5
		updateQueue.firstBaseUpdate = v6
		updateQueue.lastBaseUpdate = v42
		markSkippedUpdateLanes(v22)
		p1.lanes = v22
		p1.memoizedState = baseState
	end

	if not __DEV__ then
		return
	end

	v4 = nil
end

local function callCallback(p1, p2) --[[ callCallback | Line: 692 ]]
	if type(p1) ~= "function" then
		error(string.format("Invalid argument passed as callback. Expected a function. Instead received: %s", (tostring(p1))))
	end

	p1(p2)
end

function t.resetHasForceUpdateBeforeProcessing() --[[ Line: 707 | Upvalues: v2 (ref) ]]
	v2 = false
end
function t.checkHasForceUpdateAfterProcessing() --[[ Line: 711 | Upvalues: v2 (ref) ]]
	return v2
end
function t.commitUpdateQueue(p1, p2, p3) --[[ commitUpdateQueue | Line: 715 | Upvalues: v5 (copy), v6 (ref) ]]
	local effects = p2.effects

	p2.effects = nil

	if effects == nil then
		return
	end

	for v1, v2 in effects do
		local callback = v2.callback

		if callback ~= nil then
			if type(callback) ~= "function" then
				error(string.format("Invalid argument passed as callback. Expected a function. Instead received: %s", (tostring(callback))))
			end

			callback(p3)
		end

		table.clear(v2)
		table.insert(v5, v2)
		v6 = v6 + 1
	end
end

return t