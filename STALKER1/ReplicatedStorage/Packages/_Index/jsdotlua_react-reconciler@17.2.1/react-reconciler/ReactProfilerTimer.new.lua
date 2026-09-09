-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent:WaitForChild("ReactInternalTypes"))

local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags
local enableProfilerTimer = ReactFeatureFlags.enableProfilerTimer
local enableProfilerCommitHooks = ReactFeatureFlags.enableProfilerCommitHooks
local Profiler = require(script.Parent:WaitForChild("ReactWorkTags")).Profiler
local unstable_now = require(script.Parent.Parent:WaitForChild("scheduler")).unstable_now
local v1 = 0
local v2 = -1
local v3 = -1
local v4 = -1

function getCommitTime() --[[ getCommitTime | Line: 41 | Upvalues: v1 (ref) ]]
	return v1
end
function recordCommitTime() --[[ recordCommitTime | Line: 45 | Upvalues: enableProfilerTimer (copy), v1 (ref), unstable_now (copy) ]]
	if enableProfilerTimer then
		v1 = unstable_now()
	end
end
function startProfilerTimer(p1) --[[ startProfilerTimer | Line: 52 | Upvalues: enableProfilerTimer (copy), v3 (ref), unstable_now (copy) ]]
	if not enableProfilerTimer then
		return
	end

	v3 = unstable_now()

	if p1.actualStartTime == nil or not (p1.actualStartTime < 0) then
		return
	end

	p1.actualStartTime = unstable_now()
end
function stopProfilerTimerIfRunning(p1) --[[ stopProfilerTimerIfRunning | Line: 65 | Upvalues: enableProfilerTimer (copy), v3 (ref) ]]
	if enableProfilerTimer then
		v3 = -1
	end
end
function stopProfilerTimerIfRunningAndRecordDelta(p1, p2) --[[ stopProfilerTimerIfRunningAndRecordDelta | Line: 72 | Upvalues: enableProfilerTimer (copy), v3 (ref), unstable_now (copy) ]]
	if not enableProfilerTimer then
		return
	end

	if not (v3 >= 0) then
		return
	end

	local v1 = unstable_now() - v3

	p1.actualDuration = p1.actualDuration + v1

	if p2 then
		p1.selfBaseDuration = v1
	end

	v3 = -1
end
function recordLayoutEffectDuration(p1) --[[ recordLayoutEffectDuration | Line: 90 | Upvalues: enableProfilerTimer (copy), enableProfilerCommitHooks (copy), v2 (ref), unstable_now (copy), Profiler (copy) ]]
	if not (enableProfilerTimer and enableProfilerCommitHooks) then
		return
	end

	if not (v2 >= 0) then
		return
	end

	local v1 = unstable_now() - v2

	v2 = -1

	local return_ = p1.return_

	while return_ ~= nil do
		if return_.tag == Profiler then
			local stateNode = return_.stateNode

			stateNode.effectDuration = stateNode.effectDuration + v1

			return
		end

		return_ = return_.return_
	end
end
function recordPassiveEffectDuration(p1) --[[ recordPassiveEffectDuration | Line: 113 | Upvalues: enableProfilerTimer (copy), enableProfilerCommitHooks (copy), v4 (ref), unstable_now (copy), Profiler (copy) ]]
	if not (enableProfilerTimer and enableProfilerCommitHooks) then
		return
	end

	if not (v4 >= 0) then
		return
	end

	local v1 = unstable_now() - v4

	v4 = -1

	local return_ = p1.return_

	while return_ ~= nil do
		if return_.tag == Profiler then
			local stateNode = return_.stateNode

			if stateNode == nil then
				break
			end

			stateNode.passiveEffectDuration = stateNode.passiveEffectDuration + v1

			return
		end

		return_ = return_.return_
	end
end
function startLayoutEffectTimer() --[[ startLayoutEffectTimer | Line: 141 | Upvalues: enableProfilerTimer (copy), enableProfilerCommitHooks (copy), v2 (ref), unstable_now (copy) ]]
	if enableProfilerTimer and enableProfilerCommitHooks then
		v2 = unstable_now()
	end
end
function startPassiveEffectTimer() --[[ startPassiveEffectTimer | Line: 148 | Upvalues: enableProfilerTimer (copy), enableProfilerCommitHooks (copy), v4 (ref), unstable_now (copy) ]]
	if enableProfilerTimer and enableProfilerCommitHooks then
		v4 = unstable_now()
	end
end
function transferActualDuration(p1) --[[ transferActualDuration | Line: 155 ]]
	local child = p1.child

	while child do
		p1.actualDuration = p1.actualDuration + child.actualDuration
		child = child.sibling
	end
end

return {
	getCommitTime = getCommitTime,
	recordCommitTime = recordCommitTime,
	recordLayoutEffectDuration = recordLayoutEffectDuration,
	recordPassiveEffectDuration = recordPassiveEffectDuration,
	startLayoutEffectTimer = startLayoutEffectTimer,
	startPassiveEffectTimer = startPassiveEffectTimer,
	startProfilerTimer = startProfilerTimer,
	stopProfilerTimerIfRunning = stopProfilerTimerIfRunning,
	stopProfilerTimerIfRunningAndRecordDelta = stopProfilerTimerIfRunningAndRecordDelta,
	transferActualDuration = transferActualDuration
}