-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 12 ]]
	local describeError = require(script.Parent.Parent:WaitForChild("shared")).describeError
	local SchedulerFeatureFlags = require(script.Parent:WaitForChild("SchedulerFeatureFlags"))
	local enableSchedulerDebugging = SchedulerFeatureFlags.enableSchedulerDebugging
	local enableProfiling = SchedulerFeatureFlags.enableProfiling
	local v1 = if p1 then p1 else require(script.Parent:WaitForChild("SchedulerHostConfig"))
	local requestHostCallback = v1.requestHostCallback
	local requestHostTimeout = v1.requestHostTimeout
	local cancelHostTimeout = v1.cancelHostTimeout
	local shouldYieldToHost = v1.shouldYieldToHost
	local getCurrentTime = v1.getCurrentTime
	local v2 = nil
	local v3 = nil
	local v4 = nil

	v3 = function(p1, p2, p3) --[[ Line: 69 | Upvalues: v2 (ref) ]]
		while true do
			local v1 = math.floor(p3 / 2)
			local v22 = p1[v1]

			if v22 == nil or not (v2(v22, p2) > 0) then
				break
			end

			p1[v1] = p2
			p1[p3] = v22
			p3 = v1
		end
	end
	v4 = function(p1, p2, p3) --[[ Line: 85 | Upvalues: v2 (ref) ]]
		while p3 < #p1 do
			local v22 = p3 * 2
			local v3 = p1[v22]
			local v4 = v22 + 1
			local v5 = p1[v4]

			if v3 == nil or not (v2(v3, p2) < 0) then
				if v5 == nil or not (v2(v5, p2) < 0) then
					break
				end
			elseif v5 == nil or not (v2(v5, v3) < 0) then
				p1[p3] = v3
				p1[v22] = p2
				p3 = v22

				continue
			end

			p1[p3] = v5
			p1[v4] = p2
			p3 = v4
		end
	end
	v2 = function(p1, p2) --[[ Line: 115 ]]
		local v1 = p1.sortIndex - p2.sortIndex

		if v1 == 0 then
			return p1.id - p2.id
		end

		return v1
	end

	local SchedulerPriorities = require(script.Parent:WaitForChild("SchedulerPriorities"))
	local ImmediatePriority = SchedulerPriorities.ImmediatePriority
	local UserBlockingPriority = SchedulerPriorities.UserBlockingPriority
	local NormalPriority = SchedulerPriorities.NormalPriority
	local LowPriority = SchedulerPriorities.LowPriority
	local IdlePriority = SchedulerPriorities.IdlePriority
	local SchedulerProfiling = require(script.Parent:WaitForChild("SchedulerProfiling"))
	local markTaskRun = SchedulerProfiling.markTaskRun
	local markTaskYield = SchedulerProfiling.markTaskYield
	local markTaskCompleted = SchedulerProfiling.markTaskCompleted
	local markTaskCanceled = SchedulerProfiling.markTaskCanceled
	local markTaskErrored = SchedulerProfiling.markTaskErrored
	local markSchedulerSuspended = SchedulerProfiling.markSchedulerSuspended
	local markSchedulerUnsuspended = SchedulerProfiling.markSchedulerUnsuspended
	local markTaskStart = SchedulerProfiling.markTaskStart
	local t = {}
	local t2 = {}
	local v5 = 1
	local v6 = false
	local v7 = nil
	local v8 = NormalPriority
	local v9 = false
	local v10 = false
	local v11 = false
	local v12 = nil
	local v13 = nil

	local function advanceTimers(p1) --[[ advanceTimers | Line: 182 | Upvalues: t2 (copy), v4 (ref), t (copy), v3 (ref), enableProfiling (copy), markTaskStart (copy) ]]
		local v1 = t2[1]

		while v1 ~= nil do
			if v1.callback == nil then
				local v2 = t2
				local v32 = v2[1]

				if v32 ~= nil then
					local v42 = v2[#v2]

					v2[#v2] = nil

					if v42 ~= v32 then
						v2[1] = v42
						v4(v2, v42, 1)
					end
				end
			else
				if not (v1.startTime <= p1) then
					break
				end

				local v5 = t2
				local v6 = v5[1]

				if v6 ~= nil then
					local v7 = v5[#v5]

					v5[#v5] = nil

					if v7 ~= v6 then
						v5[1] = v7
						v4(v5, v7, 1)
					end
				end

				v1.sortIndex = v1.expirationTime

				local v8 = t
				local v9 = #v8 + 1

				v8[v9] = v1
				v3(v8, v1, v9)

				if enableProfiling then
					markTaskStart(v1, p1)
					v1.isQueued = true
				end
			end

			v1 = t2[1]
		end
	end

	local function v14(p1) --[[ Line: 208 | Upvalues: v11 (ref), advanceTimers (copy), v10 (ref), t (copy), requestHostCallback (copy), v12 (ref), t2 (copy), requestHostTimeout (copy), v14 (ref) ]]
		v11 = false
		advanceTimers(p1)

		if v10 then
			return
		end

		if t[1] ~= nil then
			v10 = true
			requestHostCallback(v12)

			return
		end

		local v1 = t2[1]

		if v1 == nil then
			return
		end

		requestHostTimeout(v14, v1.startTime - p1)
	end

	v12 = function(p1, p2) --[[ Line: 225 | Upvalues: enableProfiling (copy), markSchedulerUnsuspended (copy), v10 (ref), v11 (ref), cancelHostTimeout (copy), v9 (ref), v8 (ref), v13 (ref), describeError (copy), v7 (ref), getCurrentTime (copy), markTaskErrored (copy), markSchedulerSuspended (copy) ]]
		if enableProfiling then
			markSchedulerUnsuspended(p2)
		end

		v10 = false

		if v11 then
			v11 = false
			cancelHostTimeout()
		end

		v9 = true

		local v2, v3

		if _G.__YOLO__ then
			v2, v3 = true, v13(p1, p2)
		elseif enableProfiling then
			local ok, result = xpcall(v13, describeError, p1, p2)

			if not ok and v7 ~= nil then
				markTaskErrored(v7, (getCurrentTime()))
				v7.isQueued = false
			end

			v2 = ok
			v3 = result
		else
			v2, v3 = true, v13(p1, p2)
		end

		v7 = nil
		v8 = v8
		v9 = false

		if enableProfiling then
			markSchedulerSuspended((getCurrentTime()))
		end

		if not v2 then
			error(v3)
		end

		return v3
	end
	v13 = function(p1, p2) --[[ Line: 282 | Upvalues: advanceTimers (copy), v7 (ref), t (copy), enableSchedulerDebugging (copy), v6 (ref), shouldYieldToHost (copy), v8 (ref), markTaskRun (copy), getCurrentTime (copy), markTaskYield (copy), enableProfiling (copy), markTaskCompleted (copy), v4 (ref), t2 (copy), requestHostTimeout (copy), v14 (ref) ]]
		advanceTimers(p2)
		v7 = t[1]

		local v1 = p2

		while v7 ~= nil and not (enableSchedulerDebugging and v6) and (not (v1 < v7.expirationTime) or p1 and not shouldYieldToHost()) do
			local callback = v7.callback

			if typeof(callback) == "function" then
				v7.callback = nil
				v8 = v7.priorityLevel
				markTaskRun(v7, v1)

				local v3 = callback(v7.expirationTime <= v1)
				local v42 = getCurrentTime()

				if typeof(v3) == "function" then
					v7.callback = v3
					markTaskYield(v7, v42)
					v1 = v42
				else
					if enableProfiling then
						markTaskCompleted(v7, v42)
						v7.isQueued = false
					end

					v1 = v42

					if v7 == t[1] then
						local v5 = t
						local v62 = v5[1]

						if v62 ~= nil then
							local v72 = v5[#v5]

							v5[#v5] = nil

							if v72 ~= v62 then
								v5[1] = v72
								v4(v5, v72, 1)
							end
						end
					end
				end

				advanceTimers(v1)
			else
				local v82 = t
				local v9 = v82[1]

				if v9 ~= nil then
					local v10 = v82[#v82]

					v82[#v82] = nil

					if v10 ~= v9 then
						v82[1] = v10
						v4(v82, v10, 1)
					end
				end
			end

			v7 = t[1]
		end

		if v7 ~= nil then
			return true
		end

		local v11 = t2[1]

		if v11 == nil then
			return false
		end

		requestHostTimeout(v14, v11.startTime - v1)

		return false
	end

	local function unstable_runWithPriority(p1, p2) --[[ unstable_runWithPriority | Line: 339 | Upvalues: ImmediatePriority (copy), UserBlockingPriority (copy), NormalPriority (copy), LowPriority (copy), IdlePriority (copy), v8 (ref), describeError (copy) ]]
		if p1 ~= ImmediatePriority and (p1 ~= UserBlockingPriority and (p1 ~= NormalPriority and (p1 ~= LowPriority and p1 ~= IdlePriority))) then
			p1 = NormalPriority
		end

		local v1 = v8

		v8 = p1

		local v2, v3

		if _G.__YOLO__ then
			v2, v3 = true, p2()
		else
			local ok, result = xpcall(p2, describeError)

			v2 = ok
			v3 = result
		end

		v8 = v1

		if not v2 then
			error(v3)
		end

		return v3
	end

	local function unstable_next(p1) --[[ unstable_next | Line: 374 | Upvalues: v8 (ref), ImmediatePriority (copy), UserBlockingPriority (copy), NormalPriority (copy), describeError (copy) ]]
		local v2 = v8

		v8 = if v8 == ImmediatePriority or (v8 == UserBlockingPriority or v8 == NormalPriority) then NormalPriority else v8

		local v3, v4

		if _G.__YOLO__ then
			v3, v4 = true, p1()
		else
			local ok, result = xpcall(p1, describeError)

			v3 = ok
			v4 = result
		end

		v8 = v2

		if not v3 then
			error(v4)
		end

		return v4
	end

	local function unstable_wrapCallback(p1) --[[ unstable_wrapCallback | Line: 410 | Upvalues: v8 (ref), describeError (copy) ]]
		local v1 = v8

		return function(...) --[[ Line: 413 | Upvalues: v8 (ref), v1 (copy), p1 (copy), describeError (ref) ]]
			local v12 = v8

			v8 = v1

			local v2, v3

			if _G.__YOLO__ then
				v2, v3 = true, p1(...)
			else
				local ok, result = xpcall(p1, describeError, ...)

				v2 = ok
				v3 = result
			end

			v8 = v12

			if not v2 then
				error(v3)
			end

			return v3
		end
	end

	local function unstable_scheduleCallback(p1, p2, p3) --[[ unstable_scheduleCallback | Line: 438 | Upvalues: getCurrentTime (copy), ImmediatePriority (copy), UserBlockingPriority (copy), IdlePriority (copy), LowPriority (copy), v5 (ref), enableProfiling (copy), t2 (copy), v3 (ref), t (copy), v11 (ref), cancelHostTimeout (copy), requestHostTimeout (copy), v14 (ref), markTaskStart (copy), v10 (ref), v9 (ref), requestHostCallback (copy), v12 (ref) ]]
		local v1 = getCurrentTime()
		local v2

		if typeof(p3) == "table" then
			local v32 = p3.delay

			v2 = if typeof(v32) == "number" and v32 > 0 then v1 + v32 else v1
		else
			v2 = v1
		end

		local v52 = v2 + (if p1 == ImmediatePriority then -1 elseif p1 == UserBlockingPriority then 250 elseif p1 == IdlePriority then 1073741823 elseif p1 == LowPriority then 10000 else 5000)
		local t3 = {
			sortIndex = -1,
			id = v5,
			callback = p2,
			priorityLevel = p1,
			startTime = v2,
			expirationTime = v52
		}

		v5 = v5 + 1

		if enableProfiling then
			t3.isQueued = false
		end

		if v1 < v2 then
			t3.sortIndex = v2

			local v6 = t2
			local v7 = #v6 + 1

			v6[v7] = t3
			v3(v6, t3, v7)

			if #t == 0 and t3 == t2[1] then
				if v11 then
					cancelHostTimeout()
				else
					v11 = true
				end

				requestHostTimeout(v14, v2 - v1)

				return t3
			end
		else
			t3.sortIndex = v52

			local v8 = t
			local v92 = #v8 + 1

			v8[v92] = t3
			v3(v8, t3, v92)

			if enableProfiling then
				markTaskStart(t3, v1)
				t3.isQueued = true
			end

			if not (v10 or v9) then
				v10 = true
				requestHostCallback(v12)
			end
		end

		return t3
	end

	local function unstable_pauseExecution() --[[ unstable_pauseExecution | Line: 518 | Upvalues: v6 (ref) ]]
		v6 = true
	end

	local function unstable_continueExecution() --[[ unstable_continueExecution | Line: 522 | Upvalues: v6 (ref), v10 (ref), v9 (ref), requestHostCallback (copy), v12 (ref) ]]
		v6 = false

		if v10 or v9 then
			return
		end

		v10 = true
		requestHostCallback(v12)
	end

	local function unstable_getFirstCallbackNode() --[[ unstable_getFirstCallbackNode | Line: 530 | Upvalues: t (copy) ]]
		return t[1]
	end

	local t3 = {
		unstable_ImmediatePriority = ImmediatePriority,
		unstable_UserBlockingPriority = UserBlockingPriority,
		unstable_NormalPriority = NormalPriority,
		unstable_IdlePriority = IdlePriority,
		unstable_LowPriority = LowPriority,
		unstable_runWithPriority = unstable_runWithPriority,
		unstable_next = unstable_next,
		unstable_scheduleCallback = unstable_scheduleCallback,
		unstable_cancelCallback = function(p1) --[[ unstable_cancelCallback | Line: 534 | Upvalues: enableProfiling (copy), getCurrentTime (copy), markTaskCanceled (copy) ]]
			if enableProfiling and p1.isQueued then
				markTaskCanceled(p1, (getCurrentTime()))
				p1.isQueued = false
			end

			p1.callback = nil
		end,
		unstable_wrapCallback = unstable_wrapCallback,
		unstable_getCurrentPriorityLevel = function() --[[ unstable_getCurrentPriorityLevel | Line: 549 | Upvalues: v8 (ref) ]]
			return v8
		end,
		unstable_shouldYield = shouldYieldToHost,
		unstable_requestPaint = v1.requestPaint,
		unstable_continueExecution = unstable_continueExecution,
		unstable_pauseExecution = unstable_pauseExecution,
		unstable_getFirstCallbackNode = unstable_getFirstCallbackNode,
		unstable_now = getCurrentTime,
		unstable_forceFrameRate = v1.forceFrameRate
	}

	t3.unstable_Profiling = if enableProfiling then {
	startLoggingProfilingEvents = SchedulerProfiling.startLoggingProfilingEvents,
	stopLoggingProfilingEvents = SchedulerProfiling.stopLoggingProfilingEvents
} else nil

	return t3
end