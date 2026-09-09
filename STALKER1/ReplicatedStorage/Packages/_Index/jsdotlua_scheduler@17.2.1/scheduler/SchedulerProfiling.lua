-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local console = require(script.Parent.Parent:WaitForChild("shared")).console
local t = {}

require(script.Parent:WaitForChild("SchedulerPriorities"))

local enableProfiling = require(script.Parent:WaitForChild("SchedulerFeatureFlags")).enableProfiling
local v1 = 0
local v2 = 0
local v3 = 0
local v4 = nil
local v5 = nil
local v6 = 1

local function logEvent(p1) --[[ logEvent | Line: 45 | Upvalues: v5 (ref), v6 (ref), v3 (ref), console (copy), t (copy), v4 (ref) ]]
	if v5 == nil then
		return
	end

	v6 = v6 + #p1

	if v3 < v6 + 1 then
		v3 = v3 * 2

		if v3 > 524288 then
			console.error("Scheduler Profiling: Event log exceeded maximum size. Don\'t forget to call `stopLoggingProfilingEvents()`.")
			t.stopLoggingProfilingEvents()

			return
		end

		local t2 = {}

		table.insert(t2, v5)
		v4 = t2
		v5 = t2
	end

	table.insert(v5, p1)
end

function t.startLoggingProfilingEvents() --[[ Line: 69 | Upvalues: v3 (ref), v4 (ref), v5 (ref), v6 (ref) ]]
	v3 = 131072
	v4 = {}
	v5 = v4
	v6 = 1
end
function t.stopLoggingProfilingEvents() --[[ Line: 76 | Upvalues: v4 (ref), v3 (ref), v5 (ref), v6 (ref) ]]
	local v1 = v4

	v3 = 0
	v4 = nil
	v5 = nil
	v6 = 1

	return v1
end
function t.markTaskStart(p1, p2) --[[ Line: 86 | Upvalues: enableProfiling (copy), v5 (ref), logEvent (copy) ]]
	if not enableProfiling or v5 == nil then
		return
	end

	logEvent({
		1,
		p2 * 1000,
		p1.id,
		p1.priorityLevel
	})
end
function t.markTaskCompleted(p1, p2) --[[ Line: 97 | Upvalues: enableProfiling (copy), v5 (ref), logEvent (copy) ]]
	if not enableProfiling or v5 == nil then
		return
	end

	logEvent({ 2, p2 * 1000, p1.id })
end
function t.markTaskCanceled(p1, p2) --[[ Line: 108 | Upvalues: enableProfiling (copy), v5 (ref), logEvent (copy) ]]
	if not enableProfiling or v5 == nil then
		return
	end

	logEvent({ 4, p2 * 1000, p1.id })
end
function t.markTaskErrored(p1, p2) --[[ Line: 116 | Upvalues: enableProfiling (copy), v5 (ref), logEvent (copy) ]]
	if not enableProfiling or v5 == nil then
		return
	end

	logEvent({ 3, p2 * 1000, p1.id })
end
function t.markTaskRun(p1, p2) --[[ Line: 124 | Upvalues: enableProfiling (copy), v1 (ref), v5 (ref), logEvent (copy) ]]
	if not enableProfiling then
		return
	end

	v1 = v1 + 1

	if v5 == nil then
		return
	end

	logEvent({
		5,
		p2 * 1000,
		p1.id,
		v1
	})
end
function t.markTaskYield(p1, p2) --[[ Line: 134 | Upvalues: enableProfiling (copy), v5 (ref), logEvent (copy), v1 (ref) ]]
	if not enableProfiling or v5 == nil then
		return
	end

	logEvent({
		6,
		p2 * 1000,
		p1.id,
		v1
	})
end
function t.markSchedulerSuspended(p1) --[[ Line: 142 | Upvalues: enableProfiling (copy), v2 (ref), v5 (ref), logEvent (copy) ]]
	if not enableProfiling then
		return
	end

	v2 = v2 + 1

	if v5 == nil then
		return
	end

	logEvent({ 7, p1 * 1000, v2 })
end
function t.markSchedulerUnsuspended(p1) --[[ Line: 152 | Upvalues: enableProfiling (copy), v5 (ref), logEvent (copy), v2 (ref) ]]
	if not enableProfiling or v5 == nil then
		return
	end

	logEvent({ 8, p1 * 1000, v2 })
end

return t