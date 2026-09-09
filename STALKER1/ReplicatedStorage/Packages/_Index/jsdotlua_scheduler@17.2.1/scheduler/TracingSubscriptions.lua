-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local Object = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Object
local Tracing = require(script.Parent:WaitForChild("Tracing"))
local enableSchedulerTracing = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableSchedulerTracing
local __subscriberRef = Tracing.__subscriberRef
local t2 = {}

function t.unstable_subscribe(p1) --[[ Line: 29 | Upvalues: enableSchedulerTracing (copy), t2 (ref), Object (copy), __subscriberRef (copy) ]]
	if not enableSchedulerTracing then
		return
	end

	t2[p1] = true

	if #Object.keys(t2) ~= 1 then
		return
	end

	__subscriberRef.current = {
		onInteractionScheduledWorkCompleted = onInteractionScheduledWorkCompleted,
		onInteractionTraced = onInteractionTraced,
		onWorkCanceled = onWorkCanceled,
		onWorkScheduled = onWorkScheduled,
		onWorkStarted = onWorkStarted,
		onWorkStopped = onWorkStopped
	}
end
function t.unstable_unsubscribe(p1) --[[ Line: 46 | Upvalues: enableSchedulerTracing (copy), t2 (ref), Object (copy), __subscriberRef (copy) ]]
	if not enableSchedulerTracing then
		return
	end

	t2[p1] = nil

	if #Object.keys(t2) ~= 0 then
		return
	end

	__subscriberRef.current = nil
end
function onInteractionTraced(p1) --[[ onInteractionTraced | Line: 56 | Upvalues: t2 (ref) ]]
	local v1 = false
	local v2 = nil

	for v3, v4 in t2 do
		local ok, result = pcall(v3.onInteractionTraced, p1)

		if not (ok or v1) then
			v1 = true
			v2 = result
		end
	end

	if not v1 then
		return
	end

	error(v2)
end
function onInteractionScheduledWorkCompleted(p1) --[[ onInteractionScheduledWorkCompleted | Line: 78 | Upvalues: t2 (ref) ]]
	local v1 = false
	local v2 = nil

	for v3, v4 in t2 do
		local ok, result = pcall(v3.onInteractionScheduledWorkCompleted, p1)

		if not (ok or v1) then
			v1 = true
			v2 = result
		end
	end

	if not v1 then
		return
	end

	error(v2)
end
function onWorkScheduled(p1, p2) --[[ onWorkScheduled | Line: 101 | Upvalues: t2 (ref) ]]
	local v1 = false
	local v2 = nil

	for v3, v4 in t2 do
		local ok, result = pcall(v3.onWorkScheduled, p1, p2)

		if not (ok or v1) then
			v1 = true
			v2 = result
		end
	end

	if not v1 then
		return
	end

	error(v2)
end
function onWorkStarted(p1, p2) --[[ onWorkStarted | Line: 123 | Upvalues: t2 (ref) ]]
	local v1 = false
	local v2 = nil

	for v3, v4 in t2 do
		local ok, result = pcall(v3.onWorkStarted, p1, p2)

		if not (ok or v1) then
			v1 = true
			v2 = result
		end
	end

	if not v1 then
		return
	end

	error(v2)
end
function onWorkStopped(p1, p2) --[[ onWorkStopped | Line: 145 | Upvalues: t2 (ref) ]]
	local v1 = false
	local v2 = nil

	for v3, v4 in t2 do
		local ok, result = pcall(v3.onWorkStopped, p1, p2)

		if not (ok or v1) then
			v1 = true
			v2 = result
		end
	end

	if not v1 then
		return
	end

	error(v2)
end
function onWorkCanceled(p1, p2) --[[ onWorkCanceled | Line: 167 | Upvalues: t2 (ref) ]]
	local v1 = false
	local v2 = nil

	for v3, v4 in t2 do
		local ok, result = pcall(v3.onWorkCanceled, p1, p2)

		if not (ok or v1) then
			v1 = true
			v2 = result
		end
	end

	if not v1 then
		return
	end

	error(v2)
end

return t