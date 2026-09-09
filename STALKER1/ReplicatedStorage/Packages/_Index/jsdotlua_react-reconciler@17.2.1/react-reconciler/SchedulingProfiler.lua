-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local WeakMap = require(script.Parent.Parent:WaitForChild("luau-polyfill")).WeakMap

require(script.Parent:WaitForChild("ReactFiberLane"))
require(script.Parent:WaitForChild("ReactInternalTypes"))
require(script.Parent.Parent:WaitForChild("shared"))

local enableSchedulingProfiler = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableSchedulingProfiler
local ReactVersion = require(script.Parent.Parent:WaitForChild("shared")).ReactVersion
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName
local isNotPerformance = _G.performance ~= nil
local v1 = _G.performance or {
	mark = function(p1) --[[ mark | Line: 39 ]]
		debug.profilebegin(p1)
		debug.profileend()
	end
}

function formatLanes(p1) --[[ formatLanes | Line: 45 ]]
	return tostring(p1)
end

if enableSchedulingProfiler and isNotPerformance then
	v1.mark("--react-init-" .. tostring(ReactVersion))
end

function t.markCommitStarted(p1) --[[ Line: 56 | Upvalues: enableSchedulingProfiler (copy), isNotPerformance (copy), v1 (copy) ]]
	if not (enableSchedulingProfiler and isNotPerformance) then
		return
	end

	v1.mark("--commit-start-" .. formatLanes(p1))
end
function t.markCommitStopped() --[[ Line: 64 | Upvalues: enableSchedulingProfiler (copy), isNotPerformance (copy), v1 (copy) ]]
	if not (enableSchedulingProfiler and isNotPerformance) then
		return
	end

	v1.mark("--commit-stop")
end

local v2 = WeakMap.new()
local v3 = 0

function getWakeableID(p1) --[[ getWakeableID | Line: 78 | Upvalues: v2 (copy), v3 (ref) ]]
	if not v2:has(p1) then
		v2:set(p1, v3)
		v3 = v3 + 1
	end

	return v2:get(p1)
end
function t.markComponentSuspended(p1, p2) --[[ Line: 86 | Upvalues: enableSchedulingProfiler (copy), isNotPerformance (copy), getComponentName (copy), v1 (copy) ]]
	if not (enableSchedulingProfiler and isNotPerformance) then
		return
	end

	local v12 = getWakeableID(p2)
	local v2 = getComponentName(p1.type) or "Unknown"

	v1.mark("--suspense-suspend-" .. tostring(v12) .. "-" .. v2)
	p2:andThen(function() --[[ Line: 95 | Upvalues: v1 (ref), v12 (copy), v2 (copy) ]]
		v1.mark("--suspense-resolved-" .. tostring(v12) .. "-" .. v2)
	end, function() --[[ Line: 99 | Upvalues: v1 (ref), v12 (copy), v2 (copy) ]]
		v1.mark("--suspense-rejected-" .. tostring(v12) .. "-" .. v2)
	end)
end
function t.markLayoutEffectsStarted(p1) --[[ Line: 108 | Upvalues: enableSchedulingProfiler (copy), isNotPerformance (copy), v1 (copy) ]]
	if not (enableSchedulingProfiler and isNotPerformance) then
		return
	end

	v1.mark("--layout-effects-start-" .. formatLanes(p1))
end
function t.markLayoutEffectsStopped() --[[ Line: 116 | Upvalues: enableSchedulingProfiler (copy), isNotPerformance (copy), v1 (copy) ]]
	if not (enableSchedulingProfiler and isNotPerformance) then
		return
	end

	v1.mark("--layout-effects-stop")
end
function t.markPassiveEffectsStarted(p1) --[[ Line: 124 | Upvalues: enableSchedulingProfiler (copy), isNotPerformance (copy), v1 (copy) ]]
	if not (enableSchedulingProfiler and isNotPerformance) then
		return
	end

	v1.mark("--passive-effects-start-" .. formatLanes(p1))
end
function t.markPassiveEffectsStopped() --[[ Line: 132 | Upvalues: enableSchedulingProfiler (copy), isNotPerformance (copy), v1 (copy) ]]
	if not (enableSchedulingProfiler and isNotPerformance) then
		return
	end

	v1.mark("--passive-effects-stop")
end
function t.markRenderStarted(p1) --[[ Line: 140 | Upvalues: enableSchedulingProfiler (copy), isNotPerformance (copy), v1 (copy) ]]
	if not (enableSchedulingProfiler and isNotPerformance) then
		return
	end

	v1.mark("--render-start-" .. formatLanes(p1))
end
function t.markRenderYielded() --[[ Line: 148 | Upvalues: enableSchedulingProfiler (copy), isNotPerformance (copy), v1 (copy) ]]
	if not (enableSchedulingProfiler and isNotPerformance) then
		return
	end

	v1.mark("--render-yield")
end
function t.markRenderStopped() --[[ Line: 156 | Upvalues: enableSchedulingProfiler (copy), isNotPerformance (copy), v1 (copy) ]]
	if not (enableSchedulingProfiler and isNotPerformance) then
		return
	end

	v1.mark("--render-stop")
end
function t.markRenderScheduled(p1) --[[ Line: 164 | Upvalues: enableSchedulingProfiler (copy), isNotPerformance (copy), v1 (copy) ]]
	if not (enableSchedulingProfiler and isNotPerformance) then
		return
	end

	v1.mark("--schedule-render-" .. formatLanes(p1))
end
function t.markForceUpdateScheduled(p1, p2) --[[ Line: 172 | Upvalues: enableSchedulingProfiler (copy), isNotPerformance (copy), getComponentName (copy), v1 (copy) ]]
	if not (enableSchedulingProfiler and isNotPerformance) then
		return
	end

	local v12 = getComponentName(p1.type) or "Unknown"

	v1.mark("--schedule-forced-update-" .. formatLanes(p2) .. "-" .. v12)
end
function t.markStateUpdateScheduled(p1, p2) --[[ Line: 184 | Upvalues: enableSchedulingProfiler (copy), isNotPerformance (copy), getComponentName (copy), v1 (copy) ]]
	if not (enableSchedulingProfiler and isNotPerformance) then
		return
	end

	local v12 = getComponentName(p1.type) or "Unknown"

	v1.mark("--schedule-state-update-" .. formatLanes(p2) .. "-" .. v12)
end

return t