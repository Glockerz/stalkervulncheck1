-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local console = require(script.Parent.Parent:WaitForChild("shared")).console
local t = {}
local v1 = nil

require(script.Parent:WaitForChild("ReactFiberLane"))

local enableDebugTracing = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableDebugTracing
local v2 = nil
local t2 = {}
local v3 = 0

function decimalToBinaryString(p1) --[[ decimalToBinaryString | Line: 39 ]]
	local v1 = ""

	while true do
		local v2, v3 = math.modf(p1 / 2)

		v1 = math.ceil(v3) .. v1

		if v2 == 0 then
			break
		end

		p1 = v2
	end

	return string.rep("0", 31 - string.len(v1)) .. v1
end

local function formatLanes(p1) --[[ formatLanes | Line: 52 ]]
	return "0b" .. decimalToBinaryString(p1)
end

local function group(...) --[[ group | Line: 58 | Upvalues: t2 (copy), v2 (ref), console (copy), v1 (ref) ]]
	for v12, v22 in { ... } do
		table.insert(t2, v22)
	end

	if v2 ~= nil then
		return
	end

	v2 = console.log
	console.log = v1
end

local function groupEnd() --[[ groupEnd | Line: 68 | Upvalues: t2 (copy), v3 (ref), console (copy), v2 (ref) ]]
	table.remove(t2, 1)

	while #t2 < v3 do
		console.groupEnd()
		v3 = v3 - 1
	end

	if #t2 ~= 0 then
		return
	end

	console.log = v2
	v2 = nil
end

v1 = function(...) --[[ log | Line: 80 | Upvalues: v3 (ref), t2 (copy), console (copy), v2 (ref) ]]
	if v3 < #t2 then
		for i = v3 + 1, #t2 do
			console.group(t2[i])
		end

		v3 = #t2
	end

	if typeof(v2) == "function" then
		v2(...)
	else
		console.log(...)
	end
end
function t.logCommitStarted(p1) --[[ logCommitStarted | Line: 98 | Upvalues: enableDebugTracing (copy), group (copy) ]]
	if not (_G.__DEV__ and enableDebugTracing) then
		return
	end

	group(string.format("* commit (%s)", "0b" .. decimalToBinaryString(p1)), "", "", "")
end
function t.logCommitStopped() --[[ logCommitStopped | Line: 113 | Upvalues: enableDebugTracing (copy), groupEnd (copy) ]]
	if not (_G.__DEV__ and enableDebugTracing) then
		return
	end

	groupEnd()
end
function t.logComponentSuspended(p1, p2) --[[ logComponentSuspended | Line: 141 | Upvalues: enableDebugTracing (copy), v1 (ref) ]]
	if not (_G.__DEV__ and enableDebugTracing) then
		return
	end

	v1(string.format("* %s suspended", p1))
	p2:andThen(function() --[[ Line: 155 | Upvalues: v1 (ref), p1 (copy) ]]
		v1(string.format("* %s resolved", p1))
	end, function() --[[ Line: 164 | Upvalues: v1 (ref), p1 (copy) ]]
		v1(string.format("* %s rejected", p1))
	end)
end
function t.logLayoutEffectsStarted(p1) --[[ logLayoutEffectsStarted | Line: 179 | Upvalues: enableDebugTracing (copy), group (copy) ]]
	if not (_G.__DEV__ and enableDebugTracing) then
		return
	end

	group(string.format("* layout effects (%s)", "0b" .. decimalToBinaryString(p1)))
end
function t.logLayoutEffectsStopped() --[[ logLayoutEffectsStopped | Line: 194 | Upvalues: enableDebugTracing (copy), groupEnd (copy) ]]
	if not (_G.__DEV__ and enableDebugTracing) then
		return
	end

	groupEnd()
end
function t.logPassiveEffectsStarted(p1) --[[ logPassiveEffectsStarted | Line: 203 | Upvalues: enableDebugTracing (copy), group (copy) ]]
	if not (_G.__DEV__ and enableDebugTracing) then
		return
	end

	group(string.format("* passive effects (%s)", "0b" .. decimalToBinaryString(p1)))
end
function t.logPassiveEffectsStopped() --[[ logPassiveEffectsStopped | Line: 218 | Upvalues: enableDebugTracing (copy), groupEnd (copy) ]]
	if not (_G.__DEV__ and enableDebugTracing) then
		return
	end

	groupEnd()
end
function t.logRenderStarted(p1) --[[ logRenderStarted | Line: 227 | Upvalues: enableDebugTracing (copy), group (copy) ]]
	if not (_G.__DEV__ and enableDebugTracing) then
		return
	end

	group(string.format("* render (%s)", "0b" .. decimalToBinaryString(p1)))
end
function t.logRenderStopped() --[[ logRenderStopped | Line: 242 | Upvalues: enableDebugTracing (copy), groupEnd (copy) ]]
	if not (_G.__DEV__ and enableDebugTracing) then
		return
	end

	groupEnd()
end
function t.logForceUpdateScheduled(p1, p2) --[[ logForceUpdateScheduled | Line: 251 | Upvalues: enableDebugTracing (copy), v1 (ref) ]]
	if not (_G.__DEV__ and enableDebugTracing) then
		return
	end

	v1(string.format("* %s forced update (%s)", p1, "0b" .. decimalToBinaryString(p2)))
end
function t.logStateUpdateScheduled(p1, p2, p3) --[[ logStateUpdateScheduled | Line: 266 | Upvalues: enableDebugTracing (copy), v1 (ref) ]]
	if not (_G.__DEV__ and enableDebugTracing) then
		return
	end

	v1(string.format("* %s updated state (%s)", p1, "0b" .. decimalToBinaryString(p2)))
end

return t